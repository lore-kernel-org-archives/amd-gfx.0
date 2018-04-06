From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: always steal the first 32MB of vram
 for fw hand-over
Date: Fri, 6 Apr 2018 14:26:22 +0200
Message-ID: <e201782f-0d93-0259-a425-0c0d8cf99ea4@gmail.com>
References: <1522952800-32300-1-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_MFUWDCDtcVXcnF27DAuE3L5kC9EqKFeCPs4V1AM5gL0A@mail.gmail.com>
 <87cc962a-8a35-36d6-6b48-85c156e68f04@daenzer.net>
 <1c6e6260-10cf-f189-45b3-74fd2d1c991c@gmail.com>
 <40be8e12-8f2e-449f-d09e-aa46aa396f4c@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1217876933=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <40be8e12-8f2e-449f-d09e-aa46aa396f4c-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Ranjbar,
 Ramin" <ramin.ranjbar-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1217876933==
Content-Type: multipart/alternative;
 boundary="------------B61D7E0FB0F5B4FCB698B308"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B61D7E0FB0F5B4FCB698B308
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I feared that you would say that :(

In this case the patches are Acked-by: Christian König 
<christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Thanks,
Christian.

Am 06.04.2018 um 13:23 schrieb Andrey Grodzovsky:
>
> Me and Alex talked to a BIOS guys yesterday exactly about that, a 
> dynamic way to query this info from BIOS, he just told us to reserve 
> 32M to cover 4K display.
>
> Andrey
>
>
> On 04/06/2018 04:30 AM, Christian König wrote:
>>> I wonder if there's no way to determine which part of VRAM is being
>>> scanned out. If there was, we could just create a normal BO covering
>>> that, which would get destroyed once no CRTC references it anymore.
>>
>> Unfortunately it goes further than that. The stolen VRAM is needed 
>> for VGA emulation, not only for scanout.
>>
>> But yes I agree that we somehow figure that value out from the BIOS. 
>> If I'm not completely mistaken I've also seen some atombios table 
>> with that info in some discussion.
>>
>> Christian. 
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------B61D7E0FB0F5B4FCB698B308
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">I feared that you would say that :(<br>
      <br>
      In this case the patches are Acked-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
      <br>
      Thanks,<br>
      Christian.<br>
      <br>
      Am 06.04.2018 um 13:23 schrieb Andrey Grodzovsky:<br>
    </div>
    <blockquote type="cite"
      cite="mid:40be8e12-8f2e-449f-d09e-aa46aa396f4c-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <p>Me and Alex talked to a BIOS guys yesterday exactly about that,
        a dynamic way to query this info from BIOS, he just told us to
        reserve 32M to cover 4K display.</p>
      <p>Andrey<br>
      </p>
      <br>
      <div class="moz-cite-prefix">On 04/06/2018 04:30 AM, Christian
        König wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:1c6e6260-10cf-f189-45b3-74fd2d1c991c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
        <blockquote type="cite" style="color: #000000;">I wonder if
          there's no way to determine which part of VRAM is being <br>
          scanned out. If there was, we could just create a normal BO
          covering <br>
          that, which would get destroyed once no CRTC references it
          anymore. <br>
        </blockquote>
        <br>
        Unfortunately it goes further than that. The stolen VRAM is
        needed for VGA emulation, not only for scanout. <br>
        <br>
        But yes I agree that we somehow figure that value out from the
        BIOS. If I'm not completely mistaken I've also seen some
        atombios table with that info in some discussion. <br>
        <br>
        Christian. </blockquote>
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

--------------B61D7E0FB0F5B4FCB698B308--

--===============1217876933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1217876933==--
