From: =?UTF-8?Q?Christian_K=c3=b6nig?= via amd-gfx
 <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: "ring gfx timeout" with Vega 64 on mesa 19.0.0-rc2 and kernel
 5.0.0-rc6 (GPU reset still not works)
Date: Thu, 14 Feb 2019 10:32:23 +0100
Message-ID: <936118e1-ec6a-2af4-7cea-c26bd2d5ffc8@gmail.com>
References: <CABXGCsOakru4=RMrhpocLhN99LwKp4q1-UfFJrEUh7q4UeKJ_g@mail.gmail.com>
 <47477f0a-76dd-2f33-ff38-01f8216cffcc@amd.com>
 <CABXGCsMMOx+Ay7Dkjfy1bKcvnsqEE0v2XnZzLNVM3ygM4G2PWg@mail.gmail.com>
 <0349a887-b5b2-827a-830a-91c93dc9628d@amd.com>
 <CABXGCsMWKw2wkQmKeRj1CNwx2=EMMcBG=XvVqGMKshOXiQ7ZsQ@mail.gmail.com>
 <024290f1-97e2-ee24-6f54-3fe14a3855cf@amd.com>
 <CABXGCsOngQCDrG2GhuXTO0FaonXzK7qwe3wRdW_oPg_OLGryDg@mail.gmail.com>
 <12b7ac94-f093-d606-ead4-463c747a716c@amd.com>
 <CABXGCsM4a0XuFbhLobJriRxa55C_zgWtexg=t_6A9Dwn1vt9bg@mail.gmail.com>
 <b10e4e75-921d-e89f-2a32-68aa8437854b@amd.com>
 <CABXGCsO-shqmH1ZLsT0M+AfyHkOJDN986DeV0SF+8vLG63=0Zw@mail.gmail.com>
 <249fa2ee-136f-3d6a-5f81-f768fe234000@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1320333509=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <249fa2ee-136f-3d6a-5f81-f768fe234000-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, Mikhail Gavrilov <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1320333509==
Content-Type: multipart/alternative;
 boundary="------------47441CE2A7F38F3A776CE3EF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------47441CE2A7F38F3A776CE3EF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Andrey,

this is on Vega10, so the ASIC always stops after it sees the first fault.

I'm actually working on implementing that it should continue without 
interruption.

Regards,
Christian.

Am 13.02.19 um 22:47 schrieb Grodzovsky, Andrey:
>
> Looks like you are still running this without the latest hang fix 
> since i see the deadlock again, but actually what i forgot to ask you 
> is to load amdgpu with vm_fault_stop=2 to freeze the ASIC once 
> VM_FAULT is encountered - sorry about that. So please retest with 
> amdgpu.vm_fault_stop=2 parameter in GRUB loader.
>
> Andrey
>
> On 2/13/19 3:08 PM, Mikhail Gavrilov wrote:
>> On Wed, 13 Feb 2019 at 23:40, Grodzovsky, Andrey 
>> <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org <mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>> wrote:
>> >
>> > Regarding the original VM_FAULT we can try to debug that a bit to - 
>> enable this from trace-cmd
>> >
>> > sudo trace-cmd start -e dma_fence -e gpu_scheduler -e amdgpu -v -e 
>> "amdgpu:amdgpu_mm_rreg" -e "amdgpu:amdgpu_mm_wreg" -e "amdgpu:amdgpu_iv"
>> >
>> > and when the hang happens
>> >
>> > as root
>> > cd /sys/kernel/debug/tracing && cat trace > event_dump
>> >
>> > + as usual would be nice to have the relevant wave dump and 
>> registers from UMR + dmesg.
>> >
>> > Andrey
>> gfx.tar.xz 
>> <https://drive.google.com/file/d/1lgNu_JSfmhnnRGgHUQu2V39fhspOW4i8/view?usp=drive_web>
>>
>>
>> Just in case, I duplicated all the files on the  file sharing service 
>> Mega:
>> https://mega.nz/#F!pgYCjYrS!NkeTFIja_qwmxqLoSEUyzA
>>
>>
>> --
>> Best Regards,
>> Mike Gavrilov.
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------47441CE2A7F38F3A776CE3EF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hey Andrey,<br>
      <br>
      this is on Vega10, so the ASIC always stops after it sees the
      first fault.<br>
      <br>
      I'm actually working on implementing that it should continue
      without interruption.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 13.02.19 um 22:47 schrieb Grodzovsky, Andrey:<br>
    </div>
    <blockquote type="cite"
      cite="mid:249fa2ee-136f-3d6a-5f81-f768fe234000-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>Looks like you are still running this without the latest hang
        fix since i see the deadlock again, but actually what i forgot
        to ask you is to load amdgpu with vm_fault_stop=2 to freeze the
        ASIC once VM_FAULT is encountered - sorry about that. So please
        retest with amdgpu.vm_fault_stop=2 parameter in GRUB loader.</p>
      <p>Andrey<br>
      </p>
      <div class="moz-cite-prefix">On 2/13/19 3:08 PM, Mikhail Gavrilov
        wrote:<br>
      </div>
      <blockquote type="cite"
cite="mid:CABXGCsO-shqmH1ZLsT0M+AfyHkOJDN986DeV0SF+8vLG63=0Zw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
        <div dir="ltr">
          <div dir="ltr">
            <div dir="ltr">
              <div dir="ltr">
                <div dir="ltr">On Wed, 13 Feb 2019 at 23:40, Grodzovsky,
                  Andrey &lt;<a href="mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org"
                    target="_blank" moz-do-not-send="true">Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org</a>&gt;
                  wrote:<br>
                  &gt;<br>
                  &gt; <span class="gmail_default"
                    style="font-family:verdana,sans-serif"></span>Regarding
                  the original VM_FAULT we can try to debug that a bit
                  to - enable this from trace-cmd<br>
                  &gt;<br>
                  &gt; sudo trace-cmd start -e dma_fence -e
                  gpu_scheduler -e amdgpu -v -e "amdgpu:amdgpu_mm_rreg"
                  -e "amdgpu:amdgpu_mm_wreg" -e "amdgpu:amdgpu_iv"<br>
                  &gt;<br>
                  &gt; and when the hang happens<br>
                  &gt;<br>
                  &gt; as root<br>
                  &gt; cd /sys/kernel/debug/tracing &amp;&amp; cat trace
                  &gt; event_dump<br>
                  &gt;<br>
                  &gt; + as usual would be nice to have the relevant
                  wave dump and registers from UMR + dmesg.<br>
                  &gt;<br>
                  &gt; Andrey<br>
                  <div class="gmail_chip gmail_drive_chip"
style="width:396px;height:18px;max-height:18px;background-color:#f5f5f5;padding:5px;color:#222;font-family:arial;font-style:normal;font-weight:bold;font-size:13px;border:1px
                    solid #ddd;line-height:1">
                    <a
href="https://drive.google.com/file/d/1lgNu_JSfmhnnRGgHUQu2V39fhspOW4i8/view?usp=drive_web"
                      target="_blank"
style="display:inline-block;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;text-decoration:none;padding:1px
                      0px;border:none;width:100%" moz-do-not-send="true"><img
                        style="vertical-align: bottom; border: none;"
src="https://ssl.gstatic.com/docs/doclist/images/icon_10_generic_list.png"
                        moz-do-not-send="true"> <span dir="ltr"
                        style="color:#15c;text-decoration:none;vertical-align:bottom">gfx.tar.xz</span></a></div>
                  <br>
                  <br>
                  <div class="gmail_default"
                    style="font-family:verdana,sans-serif">Just in case,
                    I duplicated all the files on the  file sharing
                    service Mega:</div>
                  <div class="gmail_default"><font face="verdana,
                      sans-serif"><a
                        href="https://mega.nz/#F!pgYCjYrS!NkeTFIja_qwmxqLoSEUyzA"
                        moz-do-not-send="true">https://mega.nz/#F!pgYCjYrS!NkeTFIja_qwmxqLoSEUyzA</a></font><br>
                  </div>
                  <br>
                  <br>
                  --<br>
                  Best Regards,<br>
                  Mike Gavrilov.</div>
              </div>
            </div>
          </div>
        </div>
      </blockquote>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------47441CE2A7F38F3A776CE3EF--

--===============1320333509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1320333509==--
