Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD11D41D5A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 15:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA5E10E7FF;
	Thu, 11 Dec 2025 15:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T1q/1U96";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E697D10E7FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 15:27:29 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-297e2736308so296665ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 07:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765466849; x=1766071649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mPh7zmTOGUVPTMLFSZ6vEbMW9/l1AN7XzzjIqCmpjk=;
 b=T1q/1U96OnD+la32wItW6CocpzGfOAux2iENXnSrCAwr5T70S3rqJKu/sHDizvsVCe
 SIYYb0D6ncPumVDM7jGBEJoZZQ0oeDlGosyJYzQkfC3xjobMOIqDUiFw18WkChHdtx4M
 ogxRpjRtWR6Vd/zC6qwHavRGIlFOExLbLrPdlQBtoh4G5Kz/y4lKwg997YZSMwekDW2X
 2f7H9n2lz0rVhxefeRU73OVn8Zj4qtj1YUDi3r63SG7tMD5w81PiA8JtcYWtfIo/VT9N
 Jb4raVaL59WHktU7zqy6nAGpSHdWlTtCiNnA2g9l3P/lEUvMqZIHSLHqqZEWydJ5+uRZ
 hBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765466849; x=1766071649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8mPh7zmTOGUVPTMLFSZ6vEbMW9/l1AN7XzzjIqCmpjk=;
 b=tSK/sPC+ViZxWFx9ovnYrkHAmD9+pTr22SoX8TAysP9plYKZ8dvmR8rTWQsA7bx2o0
 pWIuUQadNbyQbmgSeCrgZXyoraJe1qWfrSRao64QYgHThw4RPBOP+TLEUIe4DugV8BFB
 gSX9pzIyKNPoNsPk3PZ0reyUzT3enAVnnlvXcJ61pCXr0r4G2GNLfgu+tsOV5vOx9nBP
 Jo50NIxJCEvLx1Z2wtaTbjaR2y+NDTFZ09UXuAtnn8WI3PtUVChhS9eJS4L21mjW+sTU
 Kz1PEtJ17A5XrIZhxfGMZVSFHMNh1MxAIm5OL7cmaAy+KwzQjdiymnvvmXbdi5vvmCZo
 WzrA==
X-Gm-Message-State: AOJu0Yzk0GpuTUOlSpNzglaCDslga4TJeDKWlOB3nzZAz/mrr05/MA6v
 VyfzZx1bcQda5DUmSpKUeiGge0DvFmIx3xhbUTZzZNSnbbGoRvHYp7KslCo/gfOkos/vpZD23TL
 sIKvksAGPDiggy1zonO5Jbcws2Wndz2o=
X-Gm-Gg: AY/fxX7CXZF1BFK4rU2ElCyLBYORXuHL3UD1cKWQ3X64BR10YSdjq7gEaApf/3lhupl
 iSrEe8i6XwmnPjK5IQBSXD3RXPJQxsUxphDuk4Vl5D8waZtsN/gMffkRy70crw66VyMAXKC0rvP
 RWcGQ6Mv/C7jOGR9Q4ybAXtWV0h7AcVXXRP/rIvsrVh57HGNoVIcnt6kVZn1I3oq++vNs+5xkPH
 7QQpy+i/KGv7Gr8tBNAly2ln+XMidIpJxxSNVhfQxp6zqE0HmeKS/bfkUv5PdlP7RskHVY=
X-Google-Smtp-Source: AGHT+IEOP0zsIRnWGFmwSTfsSPSIMM+uzpry2kLosUoORWx0AcIgGHgLj4uhT/fyqxwWJ4bXM/+5knaOQiOaIdrX49E=
X-Received: by 2002:a05:7022:4384:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-11f2966a6fcmr3198406c88.2.1765466849189; Thu, 11 Dec 2025
 07:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20251211051635.652412-1-kevinyang.wang@amd.com>
 <CADnq5_Owz_0ywh5Q_AxWwRn9zeeuOgBeFuyE9GqF1-8DvkA96w@mail.gmail.com>
In-Reply-To: <CADnq5_Owz_0ywh5Q_AxWwRn9zeeuOgBeFuyE9GqF1-8DvkA96w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Dec 2025 10:27:17 -0500
X-Gm-Features: AQt7F2rSHn-YqD0__Ql-Eqa2KMj4oixAMgWdGGJN_J_iQOcFgZy1gMfS3Hdwttc
Message-ID: <CADnq5_MLib=LpFkHUWEFH5CuHQr0OCJHRbxnsemg5JeD-hLoPQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix wrong pcie parameter on navi10
To: Yang Wang <kevinyang.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com, 
 alexander.deucher@amd.com, Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Dec 11, 2025 at 9:01=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Thu, Dec 11, 2025 at 12:24=E2=80=AFAM Yang Wang <kevinyang.wang@amd.co=
m> wrote:
> >
> > fix wrong pcie dpm parameter on navi10
> >
> > Fixes: 1a18607c07bb ("drm/amd/pm: override pcie dpm parameters only if =
it is necessary")
>
> Assuming this fixes the gitlab ticket:
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4671

per the reporter, this does not fix the issue.

Alex

>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> >
> > Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> > Co-developed-by: Kenneth Feng <kenneth.feng@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index 882830770b79..0c26fe6fb949 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -2216,8 +2216,8 @@ static int navi10_update_pcie_parameters(struct s=
mu_context *smu,
> >                                                                        =
 pptable->PcieLaneCount[i] > pcie_width_cap ?
> >                                                                        =
 pcie_width_cap : pptable->PcieLaneCount[i];
> >                         smu_pcie_arg =3D i << 16;
> > -                       smu_pcie_arg |=3D pcie_gen_cap << 8;
> > -                       smu_pcie_arg |=3D pcie_width_cap;
> > +                       smu_pcie_arg |=3D dpm_context->dpm_tables.pcie_=
table.pcie_gen[i] << 8;
> > +                       smu_pcie_arg |=3D dpm_context->dpm_tables.pcie_=
table.pcie_lane[i];
> >                         ret =3D smu_cmn_send_smc_msg_with_param(smu,
> >                                                         SMU_MSG_Overrid=
ePcieParameters,
> >                                                         smu_pcie_arg,
> > --
> > 2.34.1
> >
