Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E23E7717F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 21:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C96810E639;
	Mon, 16 Dec 2024 21:49:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JAEZS01T";
	dkim-atps=neutral
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366A210E639
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 21:49:49 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3ce64e7e5so551321a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 13:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734385788; x=1734990588; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+ghNhQid0DkBHv76x2DcxyuVJ0HKDDV4RW6k0LG/rdA=;
 b=JAEZS01T9WtT5kKqobNvEh+HQ8uMJGZO5ClHWiPyJSGTiF8MhFehXgKfqWDmubvf7C
 5Y6DqHkTaXAsxA0XMgrD2nRdjzyVTmjJN4lkXufEzZN1ZD078/8/OAOriArNTjBeD3HY
 3VSQaiwhPusikZ6Mlcz0lZRCWgqdOJDYcs+nIroev4UmMXMD78WUAR9buv7c0Akd3Ni2
 tjHFnHBy5M3sZHpSS4SD7MaqvCsTRfgDC5JBLdQqMMUhqEujGpNxW8aXgftEhALlv9xA
 YTIsoDfiJnaFPpPB/EpVsJf25yKMofJJPCeMZw6fsIZkaHp60opwPit87C9s5PzeJDBF
 Hs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734385788; x=1734990588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ghNhQid0DkBHv76x2DcxyuVJ0HKDDV4RW6k0LG/rdA=;
 b=TjYdGj6VB7yxyI1eA2dZOToDob6nfeamuLTG5gk9fkQL8pRPWlfCGvAmQ3BN4UW7zI
 huzV0PNeBqe1zosxIf2fPStLOSMo/mlAYo1Uuayv+6O3jVqD7/0sYe+BdXOZVmUzq8s4
 7pGRUYfT9XVQFRabAi9HA4ls5TXrWenb36DuRNVg8hm1GEFRUE2iYntT2214358n5eZI
 KwyqKfVAwIp45GtAX7IE4ku5h8UE6e8ZXgKVNByMvgJpTANXOx2D5tMe4F8macyAbxRS
 MK6e+FXV0vhkx6w+jNjc4ZD3z0PcjVKtk6w874fKkk8hY6wuorZypYhIy6GqDfNBm8v6
 lajA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3MGPOb8UnndjKA8/Au6LGcKx07me/M6Wf0orjJrOItsiuche+lbI17cpzDjQ05VQKg+moIvAB@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxj7GsLsTVo9Q0ARnoEdFMC0WW89uVR+qq43/eKFzf9Z5Xh8nB3
 RkgYmYqbNnLqbnBAWhsFMcaOI29eJY7w/DKu/bL4j41s+GLcLsfXpZJL/8eMZfnWqT07U1HdnkP
 k6PEAtBK3tg9ieX2krFiIooImqq8qTQ==
X-Gm-Gg: ASbGncsnMLjfUQPR+xxbbuSsUa2PdKWVfCnemWSqI2+wL1+QpR+KOxO7R/aT9axLfFi
 gkAkSKY0xBNZ+I4wxmeLb/7Oeuc6vhXmk8t1sj5s=
X-Google-Smtp-Source: AGHT+IFYlHahlbI7XVXNYVLU4+vR+TYjN4wik6pMGAbmX+L9B8yOh92Hyqg4lo8AVuPbWGENvECkkWbx2TuOrgLXz8w=
X-Received: by 2002:a05:6402:27cb:b0:5d0:bcc4:8af1 with SMTP id
 4fb4d7f45d1cf-5d63c157160mr5073941a12.0.1734385787422; Mon, 16 Dec 2024
 13:49:47 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A5BkF13bFt8_UnuiqPM8W-ZESgmKEjqqGfv=DGzSfJ7aQ@mail.gmail.com>
 <CAAxE2A77j94VNp33VhO97n3db_fZz1zUpM_VUPfkt96_Dzu9Bg@mail.gmail.com>
 <972c14f7-bf6f-450f-92c5-3f2b8390eac8@froggi.es>
 <CAAxE2A6popiaVF=u5B1swqXLGwnPxFTrqJKSEJJZ4tjVeWDpsA@mail.gmail.com>
 <893fedef-1592-487d-abd7-18f9d9ff79c8@froggi.es>
 <CAAxE2A79pOgZV9iK4fnbG0m8+vhrWej1J0jdMKwsxMSYEq3Chw@mail.gmail.com>
 <j6tx2oxperyjzb2qukuho5jadricty7twshempdxufl5b6c6hs@ccyy6hnnrphq>
In-Reply-To: <j6tx2oxperyjzb2qukuho5jadricty7twshempdxufl5b6c6hs@ccyy6hnnrphq>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 16 Dec 2024 16:49:11 -0500
Message-ID: <CAAxE2A65DwFQurmCFAnv0r5-KKj36gwbZbeNWMBDoreyXsF0YQ@mail.gmail.com>
Subject: Re: [PATCH] drm/fourcc: add LINEAR modifiers with an exact pitch
 alignment
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000c34fbd06296a284f"
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

--000000000000c34fbd06296a284f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 4:28=E2=80=AFAM Dmitry Baryshkov <
dmitry.baryshkov@linaro.org> wrote:

> On Mon, Dec 16, 2024 at 12:40:54AM -0500, Marek Ol=C5=A1=C3=A1k wrote:
> > git send-email (or rather the way it sends email) has been banned by
> gmail
> > due to being considered unsecure. I don't plan to find a way to make it
> > work and I don't plan to use a different email provider. It doesn't
> matter
> > because I'll be the committer of this patch in our amd-staging-drm-next
> > branch.
>
> I'm sorry, but I'd second Joshua. As a community we use certain methods
> and certain approaches which makes it easier for other people to review
> your patches. One of those includes sending patches in plain text
> without any attachments, etc (documented under Documentation/process/).
> All my patches are being sent using git-send-email or b4 send via GMail.
> Other developers use web-relay provided by the B4 tool.
>
> Next, the MAINTAINERS file lists Alex, Christian and Xinhui as
> maintainers of the drm/amd tree. If the file is incorrect or incomplete,
> please correct it.
>
> Last, but not least, this patch will likely go into drm-misc-next or
> drm-next instead of amd-saging-drm-next. It is not AMD-specific.
>

I won't comment on this because it's irrelevant. Alex will decide which
pull request it will end up in.


> > Let's talk about the concept and brokenness of DRM_FORMAT_MOD_LINEAR, n=
ot
> > send-email.
>
> The biggest problem with your approach is tht it is not clear which
> modifier to use. For example, if one of the formats requires 128-byte
> alignment, should the driver list just 128B or both 128B and 256B? If at
> some point we add 32B alignment, will we have to update the drivers?
> Which format should be used for exported buffers? Please provide
> corresponding driver patches that utilize new uAPI.
>

This is format(bpp)-independent. If some formats don't support some
alignment, only modifiers that are supported by all formats should be
exposed.

Drivers should list the alignment they support and all greater ones, e.g.:
Intel: 64B, 128B, 256B
AMD: 256B

Nobody chooses exactly which modifier to use in advance, and if some app
did that, it would be a violation of how modifiers work. Drivers only
expose modifiers sorted from best to worst, apps only compute intersections
of modifier lists and pass them to drivers, and drivers pick the first one
in the list or the best one in the list, but it doesn't matter which one at
that point. The computation of the intersection is what determines which
modifiers are allowed.


>
> Also, please don't forget the backwards compatibility issue. If we
> follow this approach, the drivers have to list both LINEAR and new
> PITCH_ALIGN modifiers. So the userspace still will attempt to use
> LINEAR.
>

Yes and no. Apps should never get an image using LINEAR if PITCH_ALIGN is
first in the list.


> It is true that such requirements are platform-specific and are usually
> encoded in the compostitor. I think it might make more sense to export
> the pitch requirements using the extra hint-like property, which then
> can be used by a smart userspace.
>

If we did that, it would be an admission that using modifiers exposed by
drivers can fail image allocation for any reason, and thus it would be an
indication that modifiers are a badly designed API because driver-exposed
modifiers don't fully describe image layouts, which is what they were
supposed to do in the first place.

Marek

--000000000000c34fbd06296a284f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Dec 16, 2024 at 4:28=E2=80=AFAM Dmitr=
y Baryshkov &lt;<a href=3D"mailto:dmitry.baryshkov@linaro.org">dmitry.barys=
hkov@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Mon, Dec 16, 2024 at 12:40:54AM -0500, Marek Ol=C5=A1=C3=
=A1k wrote:<br>
&gt; git send-email (or rather the way it sends email) has been banned by g=
mail<br>
&gt; due to being considered unsecure. I don&#39;t plan to find a way to ma=
ke it<br>
&gt; work and I don&#39;t plan to use a different email provider. It doesn&=
#39;t matter<br>
&gt; because I&#39;ll be the committer of this patch in our amd-staging-drm=
-next<br>
&gt; branch.<br>
<br>
I&#39;m sorry, but I&#39;d second Joshua. As a community we use certain met=
hods<br>
and certain approaches which makes it easier for other people to review<br>
your patches. One of those includes sending patches in plain text<br>
without any attachments, etc (documented under Documentation/process/).<br>
All my patches are being sent using git-send-email or b4 send via GMail.<br=
>
Other developers use web-relay provided by the B4 tool.<br>
<br>
Next, the MAINTAINERS file lists Alex, Christian and Xinhui as<br>
maintainers of the drm/amd tree. If the file is incorrect or incomplete,<br=
>
please correct it.<br>
<br>
Last, but not least, this patch will likely go into drm-misc-next or<br>
drm-next instead of amd-saging-drm-next. It is not AMD-specific.<br></block=
quote><div><br></div><div>I won&#39;t comment on this because it&#39;s irre=
levant. Alex will decide which pull request it will end up in.</div><div><b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Let&#39;s talk about the concept and brokenness of DRM_FORMAT_MOD_LINE=
AR, not<br>
&gt; send-email.<br>
<br>
The biggest problem with your approach is tht it is not clear which<br>
modifier to use. For example, if one of the formats requires 128-byte<br>
alignment, should the driver list just 128B or both 128B and 256B? If at<br=
>
some point we add 32B alignment, will we have to update the drivers?<br>
Which format should be used for exported buffers? Please provide<br>
corresponding driver patches that utilize new uAPI.<br></blockquote><div><b=
r></div><div>This is format(bpp)-independent. If some formats don&#39;t sup=
port some alignment, only modifiers that are supported by all formats shoul=
d be exposed.</div><div><br></div><div>Drivers should list the alignment th=
ey support and all greater ones, e.g.:</div><div>Intel: 64B, 128B, 256B<br>=
</div><div>AMD: 256B</div><div><br></div><div>Nobody chooses exactly which =
modifier to use in advance, and if some app did that, it would be a violati=
on of how modifiers work. Drivers only expose modifiers sorted from best to=
 worst, apps only compute intersections of modifier lists and pass them to =
drivers, and drivers pick the first one in the list or the best one in the =
list, but it doesn&#39;t matter which one at that point. The computation of=
 the intersection is what determines which modifiers are allowed.<br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Also, please don&#39;t forget the backwards compatibility issue. If we<br>
follow this approach, the drivers have to list both LINEAR and new<br>
PITCH_ALIGN modifiers. So the userspace still will attempt to use<br>
LINEAR.<br></blockquote><div><br></div><div>Yes and no. Apps should never g=
et an image using LINEAR if PITCH_ALIGN is first in the list.<br></div><div=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
It is true that such requirements are platform-specific and are usually<br>
encoded in the compostitor. I think it might make more sense to export<br>
the pitch requirements using the extra hint-like property, which then<br>
can be used by a smart userspace.<br></blockquote><div><br></div><div>If we=
 did that, it would be an admission that using modifiers exposed by drivers=
 can fail image allocation for any reason, and thus it would be an indicati=
on that modifiers are a badly designed API because driver-exposed modifiers=
 don&#39;t fully describe image layouts, which is what they were supposed t=
o do in the first place.<br></div><div>=C2=A0</div>Marek<br></div></div>

--000000000000c34fbd06296a284f--
