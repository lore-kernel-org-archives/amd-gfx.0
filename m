From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: reset fpriv vram_lost_counter
Date: Wed, 17 May 2017 10:56:33 +0200
Message-ID: <46582a1e-e019-34ac-1913-ed4a2a992e4c@vodafone.de>
References: <1494926750-1081-1-git-send-email-David1.Zhou@amd.com>
 <1494926750-1081-4-git-send-email-David1.Zhou@amd.com>
 <58988726-543a-535a-3011-860d29b9f2da@daenzer.net> <591BBDA2.1070900@amd.com>
 <29fe2142-7fd1-e23a-49d9-c38dc685db92@daenzer.net> <591BD17C.8050903@amd.com>
 <7d87bc8e-9c09-ad25-de6e-dfbd8116bf6e@daenzer.net> <591BF825.6090505@amd.com>
 <31db7a30-dd98-5cb2-4125-187d3d0e2a49@daenzer.net>
 <7a302ebe-1de1-734f-fb21-aadcc7904d37@vodafone.de> <591C0DFB.8030604@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0580712843=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <591C0DFB.8030604-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0580712843==
Content-Type: multipart/alternative;
 boundary="------------8A795AACE1137E7D8E145897"

This is a multi-part message in MIME format.
--------------8A795AACE1137E7D8E145897
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.05.2017 um 10:46 schrieb zhoucm1:
>
>
> On 2017年05月17日 16:40, Christian König wrote:
>> Am 17.05.2017 um 10:01 schrieb Michel Dänzer:
>>> On 17/05/17 04:13 PM, zhoucm1 wrote:
>>>> On 2017年05月17日 14:57, Michel Dänzer wrote:
>>>>> On 17/05/17 01:28 PM, zhoucm1 wrote:
>>>>>> On 2017年05月17日 11:15, Michel Dänzer wrote:
>>>>>>> On 17/05/17 12:04 PM, zhoucm1 wrote:
>>>>>>>> On 2017年05月17日 09:18, Michel Dänzer wrote:
>>>>>>>>> On 16/05/17 06:25 PM, Chunming Zhou wrote:
>>>>>>>>>> Change-Id: I8eb6d7f558da05510e429d3bf1d48c8cec6c1977
>>>>>>>>>> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>>>>> index bca1fb5..f3e7525 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>>>>> @@ -2547,6 +2547,9 @@ int amdgpu_vm_ioctl(struct drm_device 
>>>>>>>>>> *dev,
>>>>>>>>>> void *data, struct drm_file *filp)
>>>>>>>>>>          case AMDGPU_VM_OP_UNRESERVE_VMID:
>>>>>>>>>>              amdgpu_vm_free_reserved_vmid(adev, &fpriv->vm,
>>>>>>>>>> AMDGPU_GFXHUB);
>>>>>>>>>>              break;
>>>>>>>>>> +    case AMDGPU_VM_OP_RESET:
>>>>>>>>>> +        fpriv->vram_lost_counter =
>>>>>>>>>> atomic_read(&adev->vram_lost_counter);
>>>>>>>>>> +        break;
>>>>>>>>> How do you envision the UMDs using this? I can mostly think of 
>>>>>>>>> them
>>>>>>>>> calling this ioctl when a context is created or destroyed. But 
>>>>>>>>> that
>>>>>>>>> would also allow any other remaining contexts using the same 
>>>>>>>>> DRM file
>>>>>>>>> descriptor to use all ioctls again. So, I think there needs to 
>>>>>>>>> be a
>>>>>>>>> vram_lost_counter in struct amdgpu_ctx instead of in struct
>>>>>>>>> amdgpu_fpriv.
>>>>>>>> struct amdgpu_fpriv for vram_lost_counter is proper place, 
>>>>>>>> especially
>>>>>>>> for ioctl return value.
>>>>>>>> if you need to reset ctx one by one, we can mark all contexts 
>>>>>>>> of that
>>>>>>>> vm, and then reset by userspace.
>>>>>>> I'm not following. With vram_lost_counter in amdgpu_fpriv, if any
>>>>>>> context calls this ioctl, all other contexts using the same file
>>>>>>> descriptor will also be considered safe again, right?
>>>>>> Yes, but it really depends on userspace requirement, if you need to
>>>>>> reset ctx one by one, we can mark all contexts of that vm to 
>>>>>> guilty, and
>>>>>> then reset one context by userspace.
>>>>> Still not sure what you mean by that.
>>>>>
>>>>> E.g. what do you mean by "guilty"? I thought that refers to the 
>>>>> context
>>>>> which caused a hang. But it seems like you're using it to refer to 
>>>>> any
>>>>> context which hasn't reacted yet to VRAM contents being lost.
>>>> When vram is lost, we treat all contexts need to reset.
>>> Essentially, your patches only track VRAM contents being lost per file
>>> descriptor, not per context. I'm not sure (rather skeptical) that this
>>> is suitable for OpenGL UMDs, since state is usually tracked per 
>>> context.
>>> Marek / Nicolai?
>>
>> Oh, yeah that's a good point.
>>
>> The problem with tracking it per context is that Vulkan also wants 
>> the ENODEV on the amdgpu_gem_va_ioct() and amdgpu_info_ioctl() which 
>> are context less.
>>
>> But thinking more about this blocking those two doesn't make much 
>> sense. The VM content can be restored and why should be disallow 
>> reading GPU info?
> I can re-paste the Vulkan APIs requiring ENODEV:
> "
>
> The Vulkan APIs listed below could return VK_ERROR_DEVICE_LOST 
> according to the spec.
>
> I tries to provide a list of u/k interfaces that could be called for 
> each vk API.
>

Well those are the Vulkan requirements, but that doesn't necessary mean 
we must follow that on the kernel side. Keep in mind that Vulkan can't 
made any requirements towards the kernel driver.

IIRC we already have a query Vulkan can use to figure out if a GPU reset 
happened or not. So they could use that instead.

Regards,
Christian.

> vkCreateDevice
>
> -amdgpu_device_initialize.
>
> -amdgpu_query_gpu_info
>
> vkQueueSubmit
>
> -amdgpu_cs_submit
>
> vkWaitForFences
>
>                 amdgpu_cs_wait_fences
>
> vkGetEventStatus
>
> vkQueueWaitIdle
>
> vkDeviceWaitIdle
>
> vkGetQueryPoolResults**
>
>                 amdgpu_cs_query_Fence_status
>
> vkQueueBindSparse**
>
>                 amdgpu_bo_va_op
>
>                 amdgpu_bo_va_op_raw
>
> vkCreateSwapchainKHR**
>
> vkAcquireNextImageKHR**
>
> vkQueuePresentKHR
>
>                 Not related with u/k interface.**
>
> **
>
> Besides those listed above, I think 
> amdgpu_cs_signal_Sem/amdgpu_cs_wait_sem should respond to gpu reset as 
> well."
>>
>> Christian.
>>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------8A795AACE1137E7D8E145897
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 17.05.2017 um 10:46 schrieb zhoucm1:<br>
    </div>
    <blockquote cite="mid:591C0DFB.8030604-5C7GfCeVMHo@public.gmane.org" type="cite">
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
      <br>
      <br>
      <div class="moz-cite-prefix">On 2017年05月17日 16:40, Christian König
        wrote:<br>
      </div>
      <blockquote
        cite="mid:7a302ebe-1de1-734f-fb21-aadcc7904d37-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
        type="cite">Am 17.05.2017 um 10:01 schrieb Michel Dänzer: <br>
        <blockquote type="cite">On 17/05/17 04:13 PM, zhoucm1 wrote: <br>
          <blockquote type="cite">On 2017年05月17日 14:57, Michel Dänzer
            wrote: <br>
            <blockquote type="cite">On 17/05/17 01:28 PM, zhoucm1 wrote:
              <br>
              <blockquote type="cite">On 2017年05月17日 11:15, Michel
                Dänzer wrote: <br>
                <blockquote type="cite">On 17/05/17 12:04 PM, zhoucm1
                  wrote: <br>
                  <blockquote type="cite">On 2017年05月17日 09:18, Michel
                    Dänzer wrote: <br>
                    <blockquote type="cite">On 16/05/17 06:25 PM,
                      Chunming Zhou wrote: <br>
                      <blockquote type="cite">Change-Id:
                        I8eb6d7f558da05510e429d3bf1d48c8cec6c1977 <br>
                        Signed-off-by: Chunming Zhou <a
                          moz-do-not-send="true"
                          class="moz-txt-link-rfc2396E"
                          href="mailto:David1.Zhou-5C7GfCeVMHo@public.gmane.org">&lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;</a>
                        <br>
                        <br>
                        diff --git
                        a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
                        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
                        index bca1fb5..f3e7525 100644 <br>
                        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
                        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
                        @@ -2547,6 +2547,9 @@ int amdgpu_vm_ioctl(struct
                        drm_device *dev, <br>
                        void *data, struct drm_file *filp) <br>
                                 case AMDGPU_VM_OP_UNRESERVE_VMID: <br>
                                     amdgpu_vm_free_reserved_vmid(adev,
                        &amp;fpriv-&gt;vm, <br>
                        AMDGPU_GFXHUB); <br>
                                     break; <br>
                        +    case AMDGPU_VM_OP_RESET: <br>
                        +        fpriv-&gt;vram_lost_counter = <br>
                        atomic_read(&amp;adev-&gt;vram_lost_counter); <br>
                        +        break; <br>
                      </blockquote>
                      How do you envision the UMDs using this? I can
                      mostly think of them <br>
                      calling this ioctl when a context is created or
                      destroyed. But that <br>
                      would also allow any other remaining contexts
                      using the same DRM file <br>
                      descriptor to use all ioctls again. So, I think
                      there needs to be a <br>
                      vram_lost_counter in struct amdgpu_ctx instead of
                      in struct <br>
                      amdgpu_fpriv. <br>
                    </blockquote>
                    struct amdgpu_fpriv for vram_lost_counter is proper
                    place, especially <br>
                    for ioctl return value. <br>
                    if you need to reset ctx one by one, we can mark all
                    contexts of that <br>
                    vm, and then reset by userspace. <br>
                  </blockquote>
                  I'm not following. With vram_lost_counter in
                  amdgpu_fpriv, if any <br>
                  context calls this ioctl, all other contexts using the
                  same file <br>
                  descriptor will also be considered safe again, right?
                  <br>
                </blockquote>
                Yes, but it really depends on userspace requirement, if
                you need to <br>
                reset ctx one by one, we can mark all contexts of that
                vm to guilty, and <br>
                then reset one context by userspace. <br>
              </blockquote>
              Still not sure what you mean by that. <br>
              <br>
              E.g. what do you mean by "guilty"? I thought that refers
              to the context <br>
              which caused a hang. But it seems like you're using it to
              refer to any <br>
              context which hasn't reacted yet to VRAM contents being
              lost. <br>
            </blockquote>
            When vram is lost, we treat all contexts need to reset. <br>
          </blockquote>
          Essentially, your patches only track VRAM contents being lost
          per file <br>
          descriptor, not per context. I'm not sure (rather skeptical)
          that this <br>
          is suitable for OpenGL UMDs, since state is usually tracked
          per context. <br>
          Marek / Nicolai? <br>
        </blockquote>
        <br>
        Oh, yeah that's a good point. <br>
        <br>
        The problem with tracking it per context is that Vulkan also
        wants the ENODEV on the amdgpu_gem_va_ioct() and
        amdgpu_info_ioctl() which are context less. <br>
        <br>
        But thinking more about this blocking those two doesn't make
        much sense. The VM content can be restored and why should be
        disallow reading GPU info? <br>
      </blockquote>
      I can re-paste the Vulkan APIs requiring ENODEV:<br>
      "
      <p class="MsoNormal">The Vulkan APIs listed below could return
        VK_ERROR_DEVICE_LOST according to the spec. <o:p></o:p></p>
      <p class="MsoNormal">I tries to provide a list of u/k interfaces
        that could be called for each vk API.</p>
    </blockquote>
    <br>
    Well those are the Vulkan requirements, but that doesn't necessary
    mean we must follow that on the kernel side. Keep in mind that
    Vulkan can't made any requirements towards the kernel driver.<br>
    <br>
    IIRC we already have a query Vulkan can use to figure out if a GPU
    reset happened or not. So they could use that instead.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote cite="mid:591C0DFB.8030604-5C7GfCeVMHo@public.gmane.org" type="cite">
      <p class="MsoNormal"><o:p></o:p></p>
      <p class="MsoNormal"><o:p> </o:p></p>
      <p class="MsoNormal">vkCreateDevice<o:p></o:p></p>
      <p class="MsoListParagraph" style="text-indent:-.25in;mso-list:l1
        level1 lfo2"><span style="mso-list:Ignore">-<span
            style="font:7.0pt &quot;Times New Roman&quot;">          </span></span><span
          style="color:#1F497D">amdgpu_device_initialize.<o:p></o:p></span></p>
      <p class="MsoListParagraph" style="text-indent:-.25in;mso-list:l1
        level1 lfo2"><span style="mso-list:Ignore">-<span
            style="font:7.0pt &quot;Times New Roman&quot;">          </span></span><span
          style="color:#1F497D">amdgpu_query_gpu_info<o:p></o:p></span></p>
      <p class="MsoNormal"><o:p> </o:p></p>
      <p class="MsoNormal">vkQueueSubmit<o:p></o:p></p>
      <p class="MsoListParagraph" style="text-indent:-.25in;mso-list:l1
        level1 lfo2"><span style="mso-list:Ignore">-<span
            style="font:7.0pt &quot;Times New Roman&quot;">          </span></span>amdgpu_cs_submit<o:p></o:p></p>
      <p class="MsoNormal"><o:p> </o:p></p>
      <p class="MsoNormal">vkWaitForFences<o:p></o:p></p>
      <p class="MsoNormal">                amdgpu_cs_wait_fences<span
          style="color:#1F497D"><o:p></o:p></span></p>
      <p class="MsoNormal"><o:p> </o:p></p>
      <p class="MsoNormal">vkGetEventStatus<o:p></o:p></p>
      <p class="MsoNormal">vkQueueWaitIdle<o:p></o:p></p>
      <p class="MsoNormal">vkDeviceWaitIdle<o:p></o:p></p>
      <p class="MsoNormal">vkGetQueryPoolResults<b><o:p></o:p></b></p>
      <p class="MsoNormal">                amdgpu_cs_query_Fence_status<o:p></o:p></p>
      <p class="MsoNormal"><o:p> </o:p></p>
      <p class="MsoNormal">vkQueueBindSparse<b><o:p></o:p></b></p>
      <p class="MsoNormal">                amdgpu_bo_va_op<o:p></o:p></p>
      <p class="MsoNormal">                amdgpu_bo_va_op_raw<o:p></o:p></p>
      <p class="MsoNormal"><o:p> </o:p></p>
      <p class="MsoNormal">vkCreateSwapchainKHR<b><o:p></o:p></b></p>
      <p class="MsoNormal">vkAcquireNextImageKHR<b><o:p></o:p></b></p>
      <p class="MsoNormal">vkQueuePresentKHR<o:p></o:p></p>
      <p class="MsoNormal">                Not related with u/k
        interface.<b><o:p></o:p></b></p>
      <p class="MsoNormal"><b><o:p> </o:p></b></p>
      Besides those listed above, I think
      amdgpu_cs_signal_Sem/amdgpu_cs_wait_sem should respond to gpu
      reset as well."<br>
      <blockquote
        cite="mid:7a302ebe-1de1-734f-fb21-aadcc7904d37-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
        type="cite"> <br>
        Christian. <br>
        <br>
      </blockquote>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------8A795AACE1137E7D8E145897--

--===============0580712843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0580712843==--
