From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm: Harmonize CIK ASIC support in radeon and amdgpu (v2)
Date: Thu, 27 Apr 2017 11:09:32 +0200
Message-ID: <cda15938-d4f9-8f6c-2afb-fb08d1e9d5c4@vodafone.de>
References: <1491866474-1016-1-git-send-email-Felix.Kuehling@amd.com>
 <ac35e641-6fd9-a5d1-c4d9-35e71fa9eb08@daenzer.net>
 <cbcc54ec-c86f-f0eb-715e-f66790b5f964@amd.com>
 <340a5310-e6d1-5e09-81aa-d7106bcdca02@daenzer.net>
 <dedfed15-00b3-83ff-aca7-f4dffff8cc09@amd.com>
 <4bd2c7cf-a555-6cee-a863-b56ee824f9ad@daenzer.net>
 <f2f87cd4-c6c5-7c62-3035-d2f1584d7f00@amd.com>
 <cebca833-9e3f-86c5-8100-feca6ea590e5@daenzer.net>
 <588f3a43-3f29-e733-1ffd-154878303f0f@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1037976333=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <588f3a43-3f29-e733-1ffd-154878303f0f-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1037976333==
Content-Type: multipart/alternative;
 boundary="------------3A75A7DB60281DB695C3CDD0"

This is a multi-part message in MIME format.
--------------3A75A7DB60281DB695C3CDD0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.04.2017 um 22:15 schrieb Felix Kuehling:
> On 17-04-25 02:28 AM, Michel Dänzer wrote:
>> On 22/04/17 02:05 AM, Felix Kuehling wrote:
>>> __setup doesn't work in modules.
>> Right. We could build something like
>> drivers/video/fbdev/core/fb_cmdline.c:video_setup() into the kernel to
>> handle this, but it's a bit ugly, which is one reason why I was leaning
>> towards:
>>
>>
>>> s8250_options is only compiled if the driver is not a module.
>> That doesn't prevent us from using __module_param_call directly, does it?
>>
>> Although, that still doesn't work as I envision if only one driver's
>> option is set e.g. in /etc/modprobe.d/*.conf .
>>
>>
>> So, I'm starting to think we need a shared module for this, which
>> provides one or multiple module parameters to choose which driver to use
>> for CIK/SI[0], and provides the result to the amdgpu/radeon drivers.
>> That might make things easier for amdgpu-pro / other standalone amdgpu
>> versions in the long run as well, as they could add files to
>> /etc/modprobe.d/ choosing themselves by default, without having to
>> blacklist radeon.
>>
>> What do you guys think?
> Hi Michel,
>
> You said in an earlier email that it doesn't have to be convenient. With
> that in mind, I went back to a minimalistic solution that doesn't need
> any additional Kconfig options and only uses two module parameters (one
> in radeon, one in amdgpu).
>
> I'm attaching my WIP patches for reference (currently based on
> amd-kfd-staging). For an official review I'd rebase them on
> amd-staging-4.9, remove the #if-0-ed hack that didn't work out, and add
> the same for SI.
>
> Can everyone can agree that this is good enough?

It's certainly good enough for me.

With the disabled dummy code removed feel free to stick a Reviewed-by: 
Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org> at those patches.

Regards,
Christian.

>
> Regards,
>    Felix
>
>>
>> [0] or possibly even more fine-grained in the future
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------3A75A7DB60281DB695C3CDD0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 26.04.2017 um 22:15 schrieb Felix
      Kuehling:<br>
    </div>
    <blockquote cite="mid:588f3a43-3f29-e733-1ffd-154878303f0f-5C7GfCeVMHo@public.gmane.org"
      type="cite">
      <pre wrap="">On 17-04-25 02:28 AM, Michel Dänzer wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">On 22/04/17 02:05 AM, Felix Kuehling wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">__setup doesn't work in modules.
</pre>
        </blockquote>
        <pre wrap="">Right. We could build something like
drivers/video/fbdev/core/fb_cmdline.c:video_setup() into the kernel to
handle this, but it's a bit ugly, which is one reason why I was leaning
towards:


</pre>
        <blockquote type="cite">
          <pre wrap="">s8250_options is only compiled if the driver is not a module.
</pre>
        </blockquote>
        <pre wrap="">That doesn't prevent us from using __module_param_call directly, does it?

Although, that still doesn't work as I envision if only one driver's
option is set e.g. in /etc/modprobe.d/*.conf .


So, I'm starting to think we need a shared module for this, which
provides one or multiple module parameters to choose which driver to use
for CIK/SI[0], and provides the result to the amdgpu/radeon drivers.
That might make things easier for amdgpu-pro / other standalone amdgpu
versions in the long run as well, as they could add files to
/etc/modprobe.d/ choosing themselves by default, without having to
blacklist radeon.

What do you guys think?
</pre>
      </blockquote>
      <pre wrap="">
Hi Michel,

You said in an earlier email that it doesn't have to be convenient. With
that in mind, I went back to a minimalistic solution that doesn't need
any additional Kconfig options and only uses two module parameters (one
in radeon, one in amdgpu).

I'm attaching my WIP patches for reference (currently based on
amd-kfd-staging). For an official review I'd rebase them on
amd-staging-4.9, remove the #if-0-ed hack that didn't work out, and add
the same for SI.

Can everyone can agree that this is good enough?</pre>
    </blockquote>
    <br>
    It's certainly good enough for me.<br>
    <br>
    With the disabled dummy code removed feel free to stick a
    Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a> at
    those patches.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote cite="mid:588f3a43-3f29-e733-1ffd-154878303f0f-5C7GfCeVMHo@public.gmane.org"
      type="cite">
      <pre wrap="">

Regards,
  Felix

</pre>
      <blockquote type="cite">
        <pre wrap="">

[0] or possibly even more fine-grained in the future

</pre>
      </blockquote>
      <pre wrap="">
</pre>
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

--------------3A75A7DB60281DB695C3CDD0--

--===============1037976333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1037976333==--
