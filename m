Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2357DCA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 15:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0CB910E944;
	Wed, 10 Sep 2025 15:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b2XOucU1";
	dkim-atps=neutral
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B97210E944
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 15:11:32 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-746d6eb7d81so144768a34.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757517091; x=1758121891; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ugRLUsCFdeH8bvFQpCw1TQpVEXRjSaI5YHzq9bncBG4=;
 b=b2XOucU1UawHw3Xdm3iFV8goVA8+dGC6DeIfeWjJ6gksmcu4x+0qYR8l3zQAiuw4PK
 pATg2or7Zd0wFR8ERZuZbnIIUt+L2Ti/WLPJdPl0+63G3uv15L6/lIGeDke9Cdga4L/V
 3Za9twarQ1phO7mjQHpcr7d2ukU6nGOqBfBlJ3HBbvy9UPwsAYnhIiI/fL4G2PHI+tww
 3izuPHst+FapeIi7I0MKeYD4P/LuEavWod+u0JxqTF0zaGO9M9T5aWz0frTXS2mv5R49
 q3hsKmdXmmBVSQaCeBIQVF93Nb8OAHZZcH/g+kIjjVTZOvdzIAa/kMmuaD1A3YMVHJ9v
 E6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757517091; x=1758121891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ugRLUsCFdeH8bvFQpCw1TQpVEXRjSaI5YHzq9bncBG4=;
 b=l3f5MgzAsk3IAEszl8cepIzsbGWdH+lGhdr4MgoI7513yDR9hnHpXq70JY7SGcAgwm
 HeM1+y4ee5ZoqK/n3TyTmlS2N5cQjGpf9uFBd43AqBlN4dBSNFFsEv7u/uecYrLD+MFI
 gpXuEGliQRWlRsIucsNDHmrOgYrvHrDp6l41v0mN+hWOkMOc3uGrV6w+2nrTMKFgK/oN
 GRGm9CaFdLRiQcjA9M6c4kMJ/N2TsATc4Oxl5R8635vxgwuhSYB+Qkba/t1dw58to8rm
 Gj+sn9d5P4LOLO61qoCxF/Sh4j+32jAxf9Vi4kRY38E5rDvsOClOmQVS80mRRKMrTf/o
 2g0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg5mCJYf2fbCv4x+QFmVsyk7Bl5pTU42CrdkTodxU8dFwATNEf7q39FQhj20lhf95W9d3TqVzb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwIUJTMHUvk7di22NlFcpwXKTPWaFZ6WF8wO3vN2JGvAr/imwQ
 up9eJ6EKt9FVZ9w/6NVgRDh+8hOwzX2i93yp6KWcqY/HosDT5w81DL7Og7vBvXC7SW1ky4Z4okY
 LvTSel/dRpS6eyELDUEW3XxnvIOPzUBk=
X-Gm-Gg: ASbGnctyalKRge5PtRFk9D1X9yPp7yM72CVamFBjEdj0ITTvaQ4A6swE32sftDPlNw6
 rp7ITbBt1S1GTBJylZGBoTcdCYv8DfWBdy7/luBezZ1gSpzFmSOSpLCt9TwhoJik1rBendDOD+g
 AOiPLb7YqmPcyaExL7xaBpFDmnbUBb50VUSbje2A8JfIl2qRGlaqb0PniGlYCHPidKWxvsggh7J
 XIyeu5lnkDyolrdKP0=
X-Google-Smtp-Source: AGHT+IH7VUvsO2SmuORLLW8oCQD2XxOuHHruq/KWNP+b7dTbfQPGnH/VNEWF99UKprBiOCon9LNuPGuc8F0cz6EP/sM=
X-Received: by 2002:a05:6830:34a1:b0:74b:60b7:9a15 with SMTP id
 46e09a7af769-74c6f311c29mr3615078a34.1.1757517091326; Wed, 10 Sep 2025
 08:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250909144937.22452-1-timur.kristof@gmail.com>
 <20250909144937.22452-2-timur.kristof@gmail.com>
 <26b5d36d-1c9b-4891-962c-ec13b65f02ac@amd.com>
 <a065f044dd629a9863ca18bb0e913d8f9299bedc.camel@gmail.com>
 <32b1c868-8b0d-41fd-94b9-0ebfbc6b3711@amd.com>
 <0d07fe34d3857ece68d29ce21ea2768e43538aa6.camel@gmail.com>
 <a77a5934-afa8-48e5-bb15-a7f55087c245@amd.com>
 <CAAxE2A4ZUG_DLnMpW7yd=pSqnGoyELmxi_u9GveLg1zra82_wg@mail.gmail.com>
 <eff9b0b0-ff7d-490b-b81c-ab866f5a4b14@amd.com>
In-Reply-To: <eff9b0b0-ff7d-490b-b81c-ab866f5a4b14@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 10 Sep 2025 11:10:55 -0400
X-Gm-Features: Ac12FXxun9PXl2WlKBADIJmcUL8HtgBKyljeOiOtapzG6NfLMWUATdy3j7pEqRo
Message-ID: <CAAxE2A4HvuAHsuoeaNKVMxsFanR25iNo_THGV=vdyaMT6_qy9A@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 "Olsak, Marek" <Marek.Olsak@amd.com>
Content-Type: multipart/alternative; boundary="000000000000ea5040063e73d55d"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000ea5040063e73d55d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I added the comment into Mesa that 0x3fff00 is the limit. I did research on
that bug separately from PAL, but I don't remember the details.

There is no performance to gain here. It's only about consistency and clear
communication to the public what the recommended SDMA programming is.

Marek

On Wed, Sep 10, 2025 at 10:57=E2=80=AFAM Christian K=C3=B6nig <christian.ko=
enig@amd.com>
wrote:

> On 10.09.25 16:52, Marek Ol=C5=A1=C3=A1k wrote:
> > It's probably better to use 0x3fff00 to match Mesa and PAL. There is no
> benefit in using a different limit, not even a perf benefit, and it's
> better to be consistent with all UMDs.
>
> Unification with Mesa is certainly a valid argument, but just using an
> approach because PAL does it has proven to be troublesome before.
>
> If we are interested in best performance we should actually round down th=
e
> value to the next multiple of PAGE_SIZE.
>
> Christian.
>
> >
> > Marek
> >
> > On Wed, Sep 10, 2025 at 7:54=E2=80=AFAM Christian K=C3=B6nig <
> christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
> >
> >     On 10.09.25 11:34, Timur Krist=C3=B3f wrote:
> >     > On Wed, 2025-09-10 at 10:34 +0200, Christian K=C3=B6nig wrote:
> >     >> On 09.09.25 18:56, Timur Krist=C3=B3f wrote:
> >     >>>> Even when we apply it I think we should drop that, the value t=
he
> >     >>>> kernel uses is correct.
> >     >>>
> >     >>> Hi Christian,
> >     >>>
> >     >>> The kernel and Mesa disagree on the limits for almost all SDMA
> >     >>> versions, so it would be nice to actually understand what the
> >     >>> limits of
> >     >>> the SDMA HW are and use the same limit in the kernel and Mesa, =
or
> >     >>> if
> >     >>> that isn't viable, let's document why the different limits make
> >     >>> sense.
> >     >>>
> >     >>> I'm adding Marek to CC, he wrote the comment that I referenced
> >     >>> here.
> >     >>> As far as I understand from my conversation with Marek, the
> kernel
> >     >>> is
> >     >>> actually wrong.
> >     >>>
> >     >>> If the limits depend on alignment, then we should either set a
> >     >>> limit
> >     >>> that is always safe, or make sure SDMA copies in the kernel are
> >     >>> always
> >     >>> aligned and add assertions about it.
> >     >>
> >     >> That's already done. See the size restrictions applied to BOs an=
d
> the
> >     >> callers of amdgpu_copy_buffer().
> >     >
> >     > Based on the code comments I cited, as far as I understand, the
> issue
> >     > is with copying the last 256 bytes of 2^22-1. Do I understood you=
r
> >     > response correctly that you are saying that the kernel isn't
> affected
> >     > by this issue because it always copies things that are 256 byte
> >     > aligned?
> >
> >     Yes, see the kernel always works with at least PAGE_SIZE buffers
> (between 4k and 64k depending on CPU architecture). You never get anythin=
g
> smaller than that.
> >
> >     The only exception is the debugger interface, but that always copie=
s
> < PAGE_SIZE, so the SDMA limits are irrelevant.
> >
> >     > I checked the callers of amdgpu_copy_buffer and can't find what
> you are
> >     > referring to. However, assuming that all callers use
> amdgpu_copy_buffer
> >     > on 256 byte aligned addresses, there is still an issue with large
> BOs:
> >     >
> >     > When the kernel copies a BO that is larger than 0x3fffe0 bytes
> then it
> >     > needs to emit multiple SDMA copy packets, and the copy done by th=
e
> >     > second packet (and other subsequent packets) won't be 256 byte
> aligned.
> >
> >     I've just double checked the documentation and for SI it clearly
> states that the limit is 0x3fffe0. Documentation for later HW says 2^22 -=
 1
> - start_addr[4:2] (which is 0x1f in the worst case so you end up with
> 0x3fffe0 again).
> >
> >     For backward, tiled and windowed copies a 256byte bounce buffer is
> used instead of the 32byte buffer for the linear copy. So the limit is th=
en
> 0x3fff00.
> >
> >     Looks like that buffer is also used for byte aligned copies and tha=
t
> limit applies there as well.
> >
> >     >>
> >     >> We could add another warning to amdgpu_copy_buffer(), but that i=
s
> >     >> just the backend function.
> >     >>
> >     >>> Looking at the implementation of
> >     >>> amdgpu_copy_buffer in the kernel, I see that it relies on
> >     >>> copy_max_bytes and doesn't take alignment into account, so with
> the
> >     >>> current limit it could issue subsequent copies that aren't 256
> byte
> >     >>> aligned.
> >     >>
> >     >> "Due to HW limitation, the maximum count may not be 2^n-1, can
> only
> >     >> be 2^n - 1 - start_addr[4:2]"
> >     >>
> >     >> Well according to this comments the size restriction is 32 bytes
> (256
> >     >> bits!) and not 256 bytes.
> >     >>
> >     >> Were do you actually get the 256 bytes restriction from?
> >     >
> >     > The comments I cited above are from the following sources:
> >     >
> >     > PAL uses 1<<22-256 =3D 0x3fff00 here:
> >     >
> https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5e3da0c=
549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308
> <
> https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5e3da0c=
549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308
> >
> >     >
> >     > Mesa also uses 0x3fff00 here:
> >     >
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd36224c112ee2d=
48e511ae078f8c2/src/amd/common/sid.h#L390
> <
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd36224c112ee2d=
48e511ae078f8c2/src/amd/common/sid.h#L390
> >
> >     >
> >     > The limit in Mesa was added by this commit:
> >     >
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be50222411b=
c0d41c095004232ed
> <
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be50222411b=
c0d41c095004232ed
> >
> >     > According to the commit message, Dave added this limit when
> hitting an
> >     > issue trying to use SDMA with buffers that are larger than this.
> >     >
> >     > For SDMA v5.2 and newer, a larger limit was added by Marek later:
> >     >
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666fcbe38c046=
60cc4b3f8abbde259
> <
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666fcbe38c046=
60cc4b3f8abbde259
> >
> >     > Which confirms the same issue copying the last 256 bytes on these
> >     > versions, although in this case the kernel isn't technically wron=
g
> >     > because it uses a smaller overall maximum.
> >
> >     Yeah, I mean that totally makes sense. When you want allow byte
> aligned copies as well then you have to use 0x3fff00 as maximum.
> >
> >     The PAL code even has extra checks to speed up copies where src and
> dst are byte aligned, but size isn't:
> >
> >         if (IsPow2Aligned(srcGpuAddr, sizeof(uint32)) &&
> >             IsPow2Aligned(dstGpuAddr, sizeof(uint32)) &&
> >             (*pBytesCopied >=3D sizeof(uint32)))
> >     ....
> >
> >     So it totally makes sense to use the lower limit in Mesa but not fo=
r
> the kernel.
> >
> >     Regards,
> >     Christian.
> >
>
>

--000000000000ea5040063e73d55d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>I added the comment into Mesa that 0=
x3fff00 is the limit. I did research on that bug separately from PAL, but I=
 don&#39;t remember the details.</div><div><br></div><div>There is no perfo=
rmance to gain here. It&#39;s only about consistency and clear communicatio=
n to the=C2=A0public what the recommended SDMA programming is.</div><div><b=
r></div><div>Marek</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Wed, Sep 10, 2025 at 10:57=E2=80=AFAM Christian K=C3=
=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">ch=
ristian.koenig@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On 10.09.25 16:52, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; It&#39;s probably better to use=C2=A00x3fff00 to match Mesa and PAL. T=
here is no benefit in using a different limit,=C2=A0not even a perf benefit=
, and it&#39;s better to be consistent with all UMDs.<br>
<br>
Unification with Mesa is certainly a valid argument, but just using an appr=
oach because PAL does it has proven to be troublesome before.<br>
<br>
If we are interested in best performance we should actually round down the =
value to the next multiple of PAGE_SIZE.<br>
<br>
Christian.<br>
<br>
&gt; <br>
&gt; Marek<br>
&gt; <br>
&gt; On Wed, Sep 10, 2025 at 7:54=E2=80=AFAM Christian K=C3=B6nig &lt;<a hr=
ef=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.koenig@a=
md.com</a> &lt;mailto:<a href=3D"mailto:christian.koenig@amd.com" target=3D=
"_blank">christian.koenig@amd.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 10.09.25 11:34, Timur Krist=C3=B3f wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Wed, 2025-09-10 at 10:34 +0200, Christian K=
=C3=B6nig wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; On 09.09.25 18:56, Timur Krist=C3=B3f wrot=
e:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt; Even when we apply it I think we s=
hould drop that, the value the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt; kernel uses is correct.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; Hi Christian,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; The kernel and Mesa disagree on the li=
mits for almost all SDMA<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; versions, so it would be nice to actua=
lly understand what the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; limits of<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; the SDMA HW are and use the same limit=
 in the kernel and Mesa, or<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; if<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; that isn&#39;t viable, let&#39;s docum=
ent why the different limits make<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; sense.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; I&#39;m adding Marek to CC, he wrote t=
he comment that I referenced<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; here.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; As far as I understand from my convers=
ation with Marek, the kernel<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; is<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; actually wrong.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; If the limits depend on alignment, the=
n we should either set a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; limit<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; that is always safe, or make sure SDMA=
 copies in the kernel are<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; always<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; aligned and add assertions about it.<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; That&#39;s already done. See the size rest=
rictions applied to BOs and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; callers of amdgpu_copy_buffer().<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Based on the code comments I cited, as far as =
I understand, the issue<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; is with copying the last 256 bytes of 2^22-1. =
Do I understood your<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; response correctly that you are saying that th=
e kernel isn&#39;t affected<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; by this issue because it always copies things =
that are 256 byte<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; aligned?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Yes, see the kernel always works with at least PAGE=
_SIZE buffers (between 4k and 64k depending on CPU architecture). You never=
 get anything smaller than that.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The only exception is the debugger interface, but t=
hat always copies &lt; PAGE_SIZE, so the SDMA limits are irrelevant.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I checked the callers of amdgpu_copy_buffer an=
d can&#39;t find what you are<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; referring to. However, assuming that all calle=
rs use amdgpu_copy_buffer<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; on 256 byte aligned addresses, there is still =
an issue with large BOs:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; When the kernel copies a BO that is larger tha=
n 0x3fffe0 bytes then it<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; needs to emit multiple SDMA copy packets, and =
the copy done by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; second packet (and other subsequent packets) w=
on&#39;t be 256 byte aligned.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;ve just double checked the documentation and =
for SI it clearly states that the limit is 0x3fffe0. Documentation for late=
r HW says 2^22 - 1 - start_addr[4:2] (which is 0x1f in the worst case so yo=
u end up with 0x3fffe0 again).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0For backward, tiled and windowed copies a 256byte b=
ounce buffer is used instead of the 32byte buffer for the linear copy. So t=
he limit is then 0x3fff00.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Looks like that buffer is also used for byte aligne=
d copies and that limit applies there as well.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; We could add another warning to amdgpu_cop=
y_buffer(), but that is<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; just the backend function.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; Looking at the implementation of<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; amdgpu_copy_buffer in the kernel, I se=
e that it relies on<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; copy_max_bytes and doesn&#39;t take al=
ignment into account, so with the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; current limit it could issue subsequen=
t copies that aren&#39;t 256 byte<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; aligned.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; &quot;Due to HW limitation, the maximum co=
unt may not be 2^n-1, can only<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; be 2^n - 1 - start_addr[4:2]&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Well according to this comments the size r=
estriction is 32 bytes (256<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; bits!) and not 256 bytes.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Were do you actually get the 256 bytes res=
triction from?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The comments I cited above are from the follow=
ing sources:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; PAL uses 1&lt;&lt;22-256 =3D 0x3fff00 here:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"https://github.com/GPUOpen-Drivers/=
pal/blob/bcec463efe5260776d486a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/os=
s2DmaCmdBuffer.cpp#L308" rel=3D"noreferrer" target=3D"_blank">https://githu=
b.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5e3da0c549bc0a75d2/src=
/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308</a> &lt;<a href=3D"https://gi=
thub.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5e3da0c549bc0a75d2/=
src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d4=
86a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308</a>&=
gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Mesa also uses 0x3fff00 here:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"https://gitlab.freedesktop.org/mesa=
/mesa/-/blob/47f5d25f93fd36224c112ee2d48e511ae078f8c2/src/amd/common/sid.h#=
L390" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/m=
esa/mesa/-/blob/47f5d25f93fd36224c112ee2d48e511ae078f8c2/src/amd/common/sid=
.h#L390</a> &lt;<a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/blob/=
47f5d25f93fd36224c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390" rel=3D"=
noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/mesa/mesa/-/bl=
ob/47f5d25f93fd36224c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390</a>&g=
t;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The limit in Mesa was added by this commit:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"https://gitlab.freedesktop.org/mesa=
/mesa/-/commit/2c1f249f2b61be50222411bc0d41c095004232ed" rel=3D"noreferrer"=
 target=3D"_blank">https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f24=
9f2b61be50222411bc0d41c095004232ed</a> &lt;<a href=3D"https://gitlab.freede=
sktop.org/mesa/mesa/-/commit/2c1f249f2b61be50222411bc0d41c095004232ed" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/mesa/mesa/=
-/commit/2c1f249f2b61be50222411bc0d41c095004232ed</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; According to the commit message, Dave added th=
is limit when hitting an<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; issue trying to use SDMA with buffers that are=
 larger than this.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; For SDMA v5.2 and newer, a larger limit was ad=
ded by Marek later:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"https://gitlab.freedesktop.org/mesa=
/mesa/-/commit/a54bcb9429666fcbe38c04660cc4b3f8abbde259" rel=3D"noreferrer"=
 target=3D"_blank">https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb=
9429666fcbe38c04660cc4b3f8abbde259</a> &lt;<a href=3D"https://gitlab.freede=
sktop.org/mesa/mesa/-/commit/a54bcb9429666fcbe38c04660cc4b3f8abbde259" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/mesa/mesa/=
-/commit/a54bcb9429666fcbe38c04660cc4b3f8abbde259</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Which confirms the same issue copying the last=
 256 bytes on these<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; versions, although in this case the kernel isn=
&#39;t technically wrong<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; because it uses a smaller overall maximum.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Yeah, I mean that totally makes sense. When you wan=
t allow byte aligned copies as well then you have to use 0x3fff00 as maximu=
m.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The PAL code even has extra checks to speed up copi=
es where src and dst are byte aligned, but size isn&#39;t:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 if (IsPow2Aligned(srcGpuAddr, sizeof(=
uint32)) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 IsPow2Aligned(dstGpuAdd=
r, sizeof(uint32)) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*pBytesCopied &gt;=3D =
sizeof(uint32)))<br>
&gt;=C2=A0 =C2=A0 =C2=A0....<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0So it totally makes sense to use the lower limit in=
 Mesa but not for the kernel.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Christian.<br>
&gt; <br>
<br>
</blockquote></div></div>
</div>

--000000000000ea5040063e73d55d--
