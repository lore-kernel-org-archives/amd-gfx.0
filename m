From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Fixing SDMA TO after GPU reset
Date: Tue, 11 Sep 2018 09:54:39 -0400
Message-ID: <e73cb83b-750c-fd4f-40c9-635cd04bd979@amd.com>
References: <059118f3-2729-12a1-7c8d-e306f69369aa@amd.com>
 <aa21f524-ac5e-ddb7-448a-d12ec1599a59@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2137524477=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <aa21f524-ac5e-ddb7-448a-d12ec1599a59-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============2137524477==
Content-Type: multipart/alternative;
 boundary="------------100119B8509CF26E90515ABC"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------100119B8509CF26E90515ABC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

By current code logic job->vm_pd_addr is never going to be set unless 
the job is created for user SC or for buffer copy in amdgpu_copy_buffer
So in any other case we are going to skip VM flush. But amdgpu_vm_flush 
wants a flush to happen in case GPU reset just happend 
(amdgpu_vmid_had_gpu_reset is true)
so we will be skipping that VM flush (as in my case with 
amdgpu_driver_open_kms->amdgpu_vm_init->amdgpu_vm_clear_bo right after 
GPU reset occured)
Is it safe ?

Andrey

On 09/11/2018 07:46 AM, Christian König wrote:
> It would probably be better to initialize job->vm_pd_addr with 
> AMDGPU_BO_INVALID_OFFSET.
>
> And then just drop the vm flush alltogether when the vm_pd_addr isn't 
> set to something sane.
>
> Thanks,
> Christian.
>
> Am 11.09.2018 um 00:52 schrieb Andrey Grodzovsky:
>> Attached patch fixes SDMA TO after GPU reset, it's a regression 
>> caused by cbd5285 drm/amdgpu: move setting the GART addr into TTM.
>>
>> But to me it looks safer just to revert the original patch all 
>> together since we never can predict for sure if VM flush will take 
>> place and so it's safer to just always assign job->vm_pd_addr.
>>
>> Andrey
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------100119B8509CF26E90515ABC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    By current code logic job-&gt;vm_pd_addr is never going to be set
    unless the job is created for user SC or for buffer copy in
    amdgpu_copy_buffer<br>
    So in any other case we are going to skip VM flush. But
    amdgpu_vm_flush wants a flush to happen in case GPU reset just
    happend (amdgpu_vmid_had_gpu_reset is true)<br>
    so we will be skipping that VM flush (as in my case with
    amdgpu_driver_open_kms-&gt;amdgpu_vm_init-&gt;amdgpu_vm_clear_bo
    right after GPU reset occured)<br>
    Is it safe ?<br>
    <br>
    Andrey<br>
    <br>
    <div class="moz-cite-prefix">On 09/11/2018 07:46 AM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:aa21f524-ac5e-ddb7-448a-d12ec1599a59-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div class="moz-cite-prefix">It would probably be better to
        initialize job-&gt;vm_pd_addr with AMDGPU_BO_INVALID_OFFSET.<br>
        <br>
        And then just drop the vm flush alltogether when the vm_pd_addr
        isn't set to something sane.<br>
        <br>
        Thanks,<br>
        Christian.<br>
        <br>
        Am 11.09.2018 um 00:52 schrieb Andrey Grodzovsky:<br>
      </div>
      <blockquote type="cite"
        cite="mid:059118f3-2729-12a1-7c8d-e306f69369aa-5C7GfCeVMHo@public.gmane.org">Attached
        patch fixes SDMA TO after GPU reset, it's a regression caused by
        cbd5285 drm/amdgpu: move setting the GART addr into TTM. <br>
        <br>
        But to me it looks safer just to revert the original patch all
        together since we never can predict for sure if VM flush will
        take place and so it's safer to just always assign
        job-&gt;vm_pd_addr. <br>
        <br>
        Andrey <br>
        <br>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <br>
        <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------100119B8509CF26E90515ABC--

--===============2137524477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2137524477==--
