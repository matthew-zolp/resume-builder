import { LightningElement, track } from 'lwc';
import getResume from "@salesforce/apex/ResumeBuilderController.getResume";
export default class Resume extends LightningElement {
    @track resume;
    @track loading;
    connectedCallback(){
        this.getResumeJS();
        console.log('We are live!');
    }

    getResumeJS(){
        this.loading = true;
        try {
            this.resume = getResume();
            console.log('ResumeJSON: ' + JSON.stringify(this.resume));
        } catch (e) {
        }
        finally {
            this.loading = false;
        }
    }







}