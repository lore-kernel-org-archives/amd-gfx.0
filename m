Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE72C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Feb 2022 14:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E89D10E47A;
	Mon, 28 Feb 2022 14:49:46 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF1210E274
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Feb 2022 14:35:31 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id p17so10875859plo.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Feb 2022 06:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XuTwE5beaOixZYdxb384STVfwZXGxyg3Lyp6qIx2S1U=;
 b=ZNUEWwPXsLUa7MRpE6+VbCEEKooEVeJ3HdQT82HLsjPTbrQM8q/dLgy1+OsK01Y1xs
 M7/WL1KDQrG2pmColzy/RdUvAzTVWJ1MkteDDAsQVANW8eO3ZiRKY9V3pGW/JoYLmhCc
 GD7o1a2fRfGhJmT1a0nC2lTfkblOToWsSaU3X8LOOJID/YRQzDwkoCZwhNWEwkQ2s1+7
 Gzp4RzR5sfBSXJNL4gJ1DoOknPAgT01D+QEBmqWWdyL9T3pXpvxbLZ3PY+wuOUNwcBKR
 zdP2+5p+MkEwmJ5te5pcLMRAWvkfHrXsPM6lvoikPb57ol3n+e4VQkloDzA5Id739foo
 34Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XuTwE5beaOixZYdxb384STVfwZXGxyg3Lyp6qIx2S1U=;
 b=1Fz9sckknX4PvXQObG7VDCO8MTNfXXVwjCJ/HdOofcJrQyo98GwGZU1T7IYqNOxAkN
 Kk9zMH9kzkkx5/f/nXb/bIczttrHYeGes4g0uH7sxzyOVGAjfsItd8AN34jl1zw8KZu9
 AlfDpMU98CpoCMajCu6BNglsA1U7Ml1rmhdl22bgiqL/+xY4I9UdkfUBMta4yzYU6u7X
 SvQ+kVvYOh47ryN89aeLBQMx9CArKfiRDGOfNrFlzSeN84Rf47aUzuMb0d75dfysJbLN
 3AQHVwktFZFLYAZBiNLkDW6slqQPhzJd38zfDcSERDIpTIUvFaDPrTwKq9mw2dsGLv0M
 AlMg==
X-Gm-Message-State: AOAM532axHV8NabruXXyzaRCb7FWSsKW10wvSObJ18kLire/rLiExcjs
 JK8UVdAA06xxeoWprJT8jJpiqXT1hd7+6CwG58XnRBDX5gw=
X-Google-Smtp-Source: ABdhPJx079CvyY8iOXR5yGJPAeQvRr38kls4r449FBPdSx+o8sHrcEHGfRO8SwTNf0R2+F6dz2wQU2mSYsc+/auCevE=
X-Received: by 2002:a17:902:cf0d:b0:14f:e424:3579 with SMTP id
 i13-20020a170902cf0d00b0014fe4243579mr20808194plg.74.1646058931145; Mon, 28
 Feb 2022 06:35:31 -0800 (PST)
MIME-Version: 1.0
References: <CAALKErFVZt9+5pPuDYj=zcaB9xr0=iWN4whQR2WRVK6vGe=bdQ@mail.gmail.com>
 <CAHbf0-G8Rm-Q665mrEOOds109ojvng7qA4DseJsAYq01UfaJtQ@mail.gmail.com>
 <CAALKErHVGydCZ3V2ZSNz9BCZTXCxOxgjJdmjX5BY6MyAA5xXbQ@mail.gmail.com>
 <599ef7a1-389a-6fda-71e3-11776645e6dc@gmail.com>
In-Reply-To: <599ef7a1-389a-6fda-71e3-11776645e6dc@gmail.com>
From: Alex fxmbsw7 Ratchev <fxmbsw7@gmail.com>
Date: Mon, 28 Feb 2022 15:35:15 +0100
Message-ID: <CAALKErFdRHZNLCXvX0t7HDejpn1QU42G_5crjdTaP31YHqVJyw@mail.gmail.com>
Subject: Re: kernel amdgpu problems
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000ded28c05d914f52d"
X-Mailman-Approved-At: Mon, 28 Feb 2022 14:49:45 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Mike Lothian <mike@fireburn.co.uk>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000ded28c05d914f52d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

i dont have currently a setup with non as module compiled
but when i do, im sure it tries to load em right, they were just not in the
initrd ...
ill check when i be on it, somewhen not now
cheers

On Mon, Feb 28, 2022 at 12:50 PM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Am 28.02.22 um 07:43 schrieb Alex fxmbsw7 Ratchev:
>
>
>
> On Mon, Feb 28, 2022 at 12:22 AM Mike Lothian <mike@fireburn.co.uk> wrote=
:
>
>> On Sat, 26 Feb 2022 at 10:01, Alex fxmbsw7 Ratchev <fxmbsw7@gmail.com>
>> wrote:
>> >
>> > i have observed at least two major problems of using amdgpu
>> >
>> > 1. cant be built-in instead of module, display stays blank
>>
>> Are you remembering to add in the firmware to the kernel image too?
>>
>
> i copied all from official linux-firmware.gif to /lib/firmware
>
>
> That's not sufficient, you need to tell the kernel explicitly which
> firmware will be needed.
>
> In other words try mentioning everything in /lib/firmware/amdgpu as
> CONFIG_EXTRA_FIRMWARE.
>
> Regards,
> Christian.
>
>
>> There's a good guide at
>> https://wiki.gentoo.org/wiki/AMDGPU#Known_firmware_blobs
>>
>> I've successfully used AMDGPU builtin on Tonga, Raven, Renoir and Navy
>> Flounder systems
>>
>> I've never used kexec so have no suggestions for that
>>
>
> it may be back then when i compiled it inline not as module i didnt
> include firmware in the initrd so that may been that
>
> about kexec, i dunno, X dri doesnt work after first kexec, after second
> screen at all is blank
>
> driver init problems ..
>
> cheers..
>
>
>

--000000000000ded28c05d914f52d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">i dont have currently a setup with non as module compiled<=
div>but when i do, im sure it tries to load em right, they were just not in=
 the initrd ...</div><div>ill check when i be on it, somewhen not now</div>=
<div>cheers</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Mon, Feb 28, 2022 at 12:50 PM Christian K=C3=B6nig &lt;=
<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@=
gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
 =20
   =20
 =20
  <div>
    Am 28.02.22 um 07:43 schrieb Alex fxmbsw7 Ratchev:<br>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div dir=3D"ltr"><br>
        </div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 28, 2022 at
            12:22 AM Mike Lothian &lt;<a href=3D"mailto:mike@fireburn.co.uk=
" target=3D"_blank">mike@fireburn.co.uk</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Sat, 26 Feb =
2022 at
            10:01, Alex fxmbsw7 Ratchev &lt;<a href=3D"mailto:fxmbsw7@gmail=
.com" target=3D"_blank">fxmbsw7@gmail.com</a>&gt;
            wrote:<br>
            &gt;<br>
            &gt; i have observed at least two major problems of using
            amdgpu<br>
            &gt;<br>
            &gt; 1. cant be built-in instead of module, display stays
            blank<br>
            <br>
            Are you remembering to add in the firmware to the kernel
            image too?<br>
          </blockquote>
          <div><br>
          </div>
          <div>i copied all from official linux-firmware.gif to
            /lib/firmware <br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    That&#39;s not sufficient, you need to tell the kernel explicitly which
    firmware will be needed.<br>
    <br>
    In other words try mentioning everything in /lib/firmware/amdgpu as
    CONFIG_EXTRA_FIRMWARE.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <br>
            There&#39;s a good guide at <a href=3D"https://wiki.gentoo.org/=
wiki/AMDGPU#Known_firmware_blobs" rel=3D"noreferrer" target=3D"_blank">http=
s://wiki.gentoo.org/wiki/AMDGPU#Known_firmware_blobs</a><br>
            <br>
            I&#39;ve successfully used AMDGPU builtin on Tonga, Raven,
            Renoir and Navy<br>
            Flounder systems<br>
            <br>
            I&#39;ve never used kexec so have no suggestions for that<br>
          </blockquote>
          <div><br>
          </div>
          <div>it may be back then when i compiled it inline not as
            module i didnt include firmware in the initrd so that may
            been that</div>
          <div><br>
          </div>
          <div>about kexec, i dunno, X dri doesnt work after first
            kexec, after second screen at all is blank</div>
          <div><br>
          </div>
          <div>driver init problems ..</div>
          <div><br>
          </div>
          <div>cheers..=C2=A0</div>
        </div>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--000000000000ded28c05d914f52d--
