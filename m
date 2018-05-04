From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: amdgpu 0000:01:00.0: IH ring buffer overflow (0x00000010,
 0x00000000, 0x00000020)
Date: Fri, 4 May 2018 15:48:23 +0200
Message-ID: <35373d0f-4a47-68a4-35ca-9b532efb0617@gmail.com>
References: <1a8d69dc-4a6b-3cfa-a146-38d48b3e031e@molgen.mpg.de>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1065501172=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1a8d69dc-4a6b-3cfa-a146-38d48b3e031e-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
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
To: Paul Menzel <pmenzel+amd-gfx-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1065501172==
Content-Type: multipart/alternative;
 boundary="------------A8FD9C6A3B0C737747DB2C08"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A8FD9C6A3B0C737747DB2C08
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 27.04.2018 um 14:02 schrieb Paul Menzel:
> Dear Linux AMD folks,
>
>
> I get the overrun message below.

Sorry for the delayed response, I was on vacation and then on sick leave :(

>
>> $ more /proc/version
>> Linux version 4.14.30.mx64.211 (root-mccexzeWwsejwueTl6BtlECU5h/uR09zhGxnpwIvXIk@public.gmane.org) 
>> (gcc version 7.3.0 (GCC)) #1 SMP Tue Mar 27 12:40:07 CEST 2018

That one is ancient, please try an up to date kernel as well.

>> [90612.637194] amdgpu 0000:01:00.0: IH ring buffer overflow 
>> (0x00000010, 0x00000000, 0x00000020)
>
> Should this be reported and fixed? How can this be debugged? 
> (`drm.debug=0xe`?). We do not know how to reproduce it yet.

Yes, that should certainly be fixed. The issue is that your hardware is 
producing so many interrupts that the CPU can't catch up any more 
processing them.

That either sounds like a hardware problem or something is blocking the 
CPU for quite a long time with interrupts disabled.

Regards,
Christian.

>
>
> Kind regards,
>
> Paul
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------A8FD9C6A3B0C737747DB2C08
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 27.04.2018 um 14:02 schrieb Paul
      Menzel:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1a8d69dc-4a6b-3cfa-a146-38d48b3e031e-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org">Dear
      Linux AMD folks,
      <br>
      <br>
      <br>
      I get the overrun message below.
      <br>
    </blockquote>
    <br>
    Sorry for the delayed response, I was on vacation and then on sick
    leave :(<br>
    <br>
    <blockquote type="cite"
      cite="mid:1a8d69dc-4a6b-3cfa-a146-38d48b3e031e-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org">
      <br>
      <blockquote type="cite">$ more /proc/version
        <br>
        Linux version 4.14.30.mx64.211
        (<a class="moz-txt-link-abbreviated" href="mailto:root-mccexzeWwsejwueTl6BtlECU5h/uR09zhGxnpwIvXIk@public.gmane.org">root-mccexzeWwsejwueTl6BtlECU5h/uR09zhGxnpwIvXIk@public.gmane.org</a>) (gcc version 7.3.0 (GCC))
        #1 SMP Tue Mar 27 12:40:07 CEST 2018
        <br>
      </blockquote>
    </blockquote>
    <br>
    That one is ancient, please try an up to date kernel as well.<br>
    <br>
    <blockquote type="cite"
      cite="mid:1a8d69dc-4a6b-3cfa-a146-38d48b3e031e-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org">
      <blockquote type="cite">[90612.637194] amdgpu 0000:01:00.0: IH
        ring buffer overflow (0x00000010, 0x00000000, 0x00000020)
        <br>
      </blockquote>
      <br>
      Should this be reported and fixed? How can this be debugged?
      (`drm.debug=0xe`?). We do not know how to reproduce it yet.
      <br>
    </blockquote>
    <br>
    Yes, that should certainly be fixed. The issue is that your hardware
    is producing so many interrupts that the CPU can't catch up any more
    processing them.<br>
    <br>
    That either sounds like a hardware problem or something is blocking
    the CPU for quite a long time with interrupts disabled.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:1a8d69dc-4a6b-3cfa-a146-38d48b3e031e-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org">
      <br>
      <br>
      Kind regards,
      <br>
      <br>
      Paul
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

--------------A8FD9C6A3B0C737747DB2C08--

--===============1065501172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1065501172==--
