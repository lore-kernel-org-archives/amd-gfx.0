Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDABC87FCA
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Aug 2025 16:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07EBA10E02A;
	Sun,  3 Aug 2025 16:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jbdBaKyP";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED88E10E02A
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Aug 2025 16:27:10 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-4338d0596f7so919943b6e.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 03 Aug 2025 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754238430; x=1754843230; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LI2Dzn65MJoL8h+nOMp3ODH04CxpFN2pknSSpWOjBa0=;
 b=jbdBaKyPVzoqIYki0JFhGxGxcbXR2NnY6LSbHrNyRuZyjDrc4DolfTmXHNXr1+uC54
 WhgWqACfgxH8oemjg3oqLrIao2RrDcoUtZ+9pIIkF8owlk62yy1izVn88HZ8eTuQp6gx
 BVkniwRN85hezCyt1PrcM/4uuthaOAS0w7IUtCXUXPBzlN3me+OWXutsAlCK3BVTndlY
 NJjsv3K/wAcrEErb+sqchoIVHLtXB6Pm6iczHkT9qTxKOG4KQ8ADq/cDSBgSulnDRgEF
 V5U+ZqvGvgf9wKVkxaxSs6RTYn0qvcqMQKqQRxnQQ4fzQHlKvSpGUbYprh5UM7RRKCBf
 TJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754238430; x=1754843230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LI2Dzn65MJoL8h+nOMp3ODH04CxpFN2pknSSpWOjBa0=;
 b=JTChx/RskezbjcO4Ng4CRQv128ZmGoq3S5Pg/j7drOImRg9/rU0TAqWOZlx22t6rWr
 qg8rTrod0LRk5eb5q7WW9BhiE72mAzdbFTt/SBA9XZGMVN5EQoVKdQz7YNKDYtS8BVT8
 HFeC510K4VlQp+fNn86kZwFGj2TpVu9z3T0rukn5P0aDqNKKV3NV3KccInf6feBHaab0
 HJd8Pp6uVcwqf4AzBRJdNNyDmaEmsKUy4W0oYEzmBo5c+EeGDBISm0nolDuiN6vY9Wl0
 SL4s2NWIuTIf+mOy/tYy8dwg1/CnTDAx8upCIrwys3/kEM1XFh3xSBb2iUFJj2DCAi3I
 gsmg==
X-Gm-Message-State: AOJu0Yx5XH5jjZBbX2maG1mBSkLVTeI/MbIqZWZCAv6VD9pi1fw1d7Oj
 ET3Nzzwk1SMuu4+Hg+tF0RAQbIK0LdQiY6Wp/+8Z9s0FMsXvSARbjI62DQEu3qnFYRLVxb2oZUw
 Pai82kvJTywPWLjCx1pkl2gxObCrp9LxDL22W
X-Gm-Gg: ASbGncsuHeQMbpIREnGBfoElcod4XkmxxwTF9zqpZSfKmQ+Ae0qDLvf49XDIPvpP5RH
 h5J58dtI7mRsKF9zeHzRZFlpeYN1QXM5HhjNsGznPPVUO9Hv6sbu7LDlVFoM1IilVsybh1/6pCS
 KhjiHpOAw4QrE0LJ8NidkvABuGW7H3A5ZLpavhUEOZ44waa+L9yfOnJ5urj3VPEFBjN5CtefDY2
 jqE1MSb
X-Google-Smtp-Source: AGHT+IHUpB2kh+hG+Q6khjnhsRrnfsFhKVDVg0zfY9qQ0YYS+3nhQ2uHG1V/g40rrQam33Wvm/8BxmKOI5Hdhkz7REY=
X-Received: by 2002:a05:6808:66c7:b0:42c:5291:8ec with SMTP id
 5614622812f47-433f0309c08mr2696460b6e.18.1754238430149; Sun, 03 Aug 2025
 09:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250723155813.9101-12-timur.kristof@gmail.com>
 <382a6232-c500-4d5e-96d4-0444947130ea@gmail.com>
 <CAFF-SiX_FipFpaZyQaFEE5raFN2zz_yQPYUkBq2kRzLP1PHyZg@mail.gmail.com>
In-Reply-To: <CAFF-SiX_FipFpaZyQaFEE5raFN2zz_yQPYUkBq2kRzLP1PHyZg@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Sun, 3 Aug 2025 12:26:59 -0400
X-Gm-Features: Ac12FXywvdhJiNFgkHIUktV3RP-rh0kjxGU3EAlmp17u8La95ZMBSNBDcywOMHc
Message-ID: <CAPEhTTEy9J9_zza9p-pnVVMGcxCrKkfOAdy54YVkJofCsNJTsA@mail.gmail.com>
Subject: Re: [PATCH 11/20] drm/amd/display: Implement DCE analog link encoders
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="0000000000007aff0e063b78767f"
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

--0000000000007aff0e063b78767f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 6:02=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com>
wrote:

>
>
> 2025. augusztus 1., p=C3=A9ntek d=C3=A1tummal Alexandre Demers <
> alexandre.f.demers@gmail.com> ezt =C3=ADrta:
> >> We support two kinds of analog connections:
> >>
> >> 1. VGA, which only supports analog signals:
> >> For VGA, we need to create a link encoder that only works with the
> >> DAC without perturbing any digital transmitter functionality.
> >> This is achieved by the new dce110_analog_link_encoder_construct.
> >>
> >> 2. DVI-I, which allows both digital and analog signals:
> >> The DC code base only allows 1 encoder per connector, and the
> >> preferred engine type is still going to be digital. So, for DVI-I
> >> to work, we need to make sure the pre-existing link encoder can
> >> also work with analog signals.
> >>
> >> Signed-off-by: Timur Krist=C3=B3f <timur.kristof at gmail.com>
> >> ---
> >> .../drm/amd/display/dc/dce/dce_link_encoder.c | 100 ++++++++++++++++++
> >> .../drm/amd/display/dc/dce/dce_link_encoder.h | 21 ++--
> >
> > I have the same comment about the use of "dce110_" prefix under
> general/global DCE code that I left on the previous patch.
> >
> > For consistency with the current code, I understand why this prefix is
> used, but I'd gladly clean this up once the patches have landed in if the=
re
> is a common agreement.
> >
> > Alexandre
>
> Hi Alexandre,
>
> With regards to the coding style. I already replied to your other thread
> about it, let's have that conversation there.
>
> With regards to the link encoders specifically. Due to DVI-I, we need
> dce110_link_encoder to handle analog signals in addition to digital, so t=
he
> question about this part is, is there any need to have a separate
> dce110_analog_link_encoder? When I wrote the patch I felt yes, but now I
> feel maybe we should just let dce110_link_encoder handle VGA as well.
>
> What do you think about that?
>
> Thanks,
> Timur
>
>
> Since a distinction is already made in the code between digital and analo=
g
encoders, I would be tempted to go with the dce110_analog_link_encoder so
it may be just easier/quicker to distinguish what this part of code does.

Alexandre

--0000000000007aff0e063b78767f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Aug 1, 2025 at 6:02=E2=80=AFPM Timur =
Krist=C3=B3f &lt;<a href=3D"mailto:timur.kristof@gmail.com">timur.kristof@g=
mail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><br><br>2025. augusztus 1., p=C3=A9ntek d=C3=A1tummal Alexandre Dem=
ers &lt;<a href=3D"mailto:alexandre.f.demers@gmail.com" target=3D"_blank">a=
lexandre.f.demers@gmail.com</a>&gt; ezt =C3=ADrta:<br>&gt;&gt; We support t=
wo kinds of analog connections:<br>&gt;&gt;<br>&gt;&gt; 1. VGA, which only =
supports analog signals:<br>&gt;&gt; For VGA, we need to create a link enco=
der that only works with the<br>&gt;&gt; DAC without perturbing any digital=
 transmitter functionality.<br>&gt;&gt; This is achieved by the new dce110_=
analog_link_encoder_construct.<br>&gt;&gt;<br>&gt;&gt; 2. DVI-I, which allo=
ws both digital and analog signals:<br>&gt;&gt; The DC code base only allow=
s 1 encoder per connector, and the<br>&gt;&gt; preferred engine type is sti=
ll going to be digital. So, for DVI-I<br>&gt;&gt; to work, we need to make =
sure the pre-existing link encoder can<br>&gt;&gt; also work with analog si=
gnals.<br>&gt;&gt;<br>&gt;&gt; Signed-off-by: Timur Krist=C3=B3f &lt;timur.=
kristof at <a href=3D"http://gmail.com" target=3D"_blank">gmail.com</a>&gt;=
<br>&gt;&gt; ---<br>&gt;&gt; .../drm/amd/display/dc/dce/dce_link_encoder.c =
| 100 ++++++++++++++++++<br>&gt;&gt; .../drm/amd/display/dc/dce/dce_link_en=
coder.h | 21 ++--<br>&gt;<br>&gt; I have the same comment about the use of =
&quot;dce110_&quot; prefix under general/global DCE code that I left on the=
 previous patch.<br>&gt;<br>&gt; For consistency with the current code, I u=
nderstand why this prefix is used, but I&#39;d gladly clean this up once th=
e patches have landed in if there is a common agreement.<br>&gt;<br>&gt; Al=
exandre<br><br>Hi Alexandre,<br><br>With regards to the coding style. I alr=
eady replied to your other thread about it, let&#39;s have that conversatio=
n there.<br><br>With regards to the link encoders specifically. Due to DVI-=
I, we need dce110_link_encoder to handle analog signals in addition to digi=
tal, so the question about this part is, is there any need to have a separa=
te dce110_analog_link_encoder? When I wrote the patch I felt yes, but now I=
 feel maybe we should just let dce110_link_encoder handle VGA as well.<br><=
br>What do you think about that?<br><br>Thanks,<br>Timur<br><br><br></block=
quote><div>Since a distinction is already made in the code between digital =
and analog encoders, I would be tempted to go with the dce110_analog_link_e=
ncoder so it may be just easier/quicker to distinguish what this part of co=
de does.</div><div><br></div><div>Alexandre</div></div></div>

--0000000000007aff0e063b78767f--
