From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Fixing SDMA TO after GPU reset
Date: Tue, 11 Sep 2018 13:46:52 +0200
Message-ID: <aa21f524-ac5e-ddb7-448a-d12ec1599a59@gmail.com>
References: <059118f3-2729-12a1-7c8d-e306f69369aa@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2104527908=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <059118f3-2729-12a1-7c8d-e306f69369aa-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============2104527908==
Content-Type: multipart/alternative;
 boundary="------------987A97BE9B1E68E2D6CC5C0D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------987A97BE9B1E68E2D6CC5C0D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

It would probably be better to initialize job->vm_pd_addr with 
AMDGPU_BO_INVALID_OFFSET.

And then just drop the vm flush alltogether when the vm_pd_addr isn't 
set to something sane.

Thanks,
Christian.

Am 11.09.2018 um 00:52 schrieb Andrey Grodzovsky:
> Attached patch fixes SDMA TO after GPU reset, it's a regression caused 
> by cbd5285 drm/amdgpu: move setting the GART addr into TTM.
>
> But to me it looks safer just to revert the original patch all 
> together since we never can predict for sure if VM flush will take 
> place and so it's safer to just always assign job->vm_pd_addr.
>
> Andrey
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------987A97BE9B1E68E2D6CC5C0D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
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
      cbd5285 drm/amdgpu: move setting the GART addr into TTM.
      <br>
      <br>
      But to me it looks safer just to revert the original patch all
      together since we never can predict for sure if VM flush will take
      place and so it's safer to just always assign job-&gt;vm_pd_addr.
      <br>
      <br>
      Andrey
      <br>
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
    <br>
  </body>
</html>

--------------987A97BE9B1E68E2D6CC5C0D--

--===============2104527908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2104527908==--
