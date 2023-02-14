Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A816AC61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 17:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3381410E248;
	Tue, 14 Feb 2023 17:39:55 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BC6710E238
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 17:39:54 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-16e2c22c3baso3437626fac.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 09:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5TF520PpzqGkBQLmYWM01onQmUaA7umrS/wgQXd5TH4=;
 b=OOF9uh2wbRZdUTFZRbB3y9g8vBhoEeMrENhf5vNveaudTFO94bS3hGN6dwjph7TJ7N
 mnJ56b7w+Kbjz/MFaXBZJKQG2gcUNwsj75yNve3OCiKUJ83FbQ8kEVSe3Re7Xzm+BBlj
 zBdlWnDWH+cRPowNqpOqURnX+scoLwt/jbZLGibeLQMx7Iuqg47JiOFtNaRdE3ihQPyE
 PooGSxnYwKsA8mAkx+xxZJdo5AH25xbLfYnsS5uWdm9bk6MtpH2hVnXrJpccjGyX2AyW
 MlJ9aLR3EBOhdVrAg2N1787NqXJ2Z41DkdbXTWYi+9ljTdjMtCd4gHmVK1lAThCm+F0J
 3zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5TF520PpzqGkBQLmYWM01onQmUaA7umrS/wgQXd5TH4=;
 b=1KGmtzCTdwOpM4V4Be35kakbWXoxhxvC34N1Xt7/mP1PeuowTDFZA+F3MbWdVsllnN
 ECBs9M6vWSGGKEVs7K+rzxV7FrSgmeSShrixw1j0ZEPRLEOCtILXacPqIon9kMnccaAz
 +Y3flqGP5GDYVFQHFfKFooeUg+WwYcvW9ZnRZZR08Y71t2CQEJ6gV3mhez+hNmE/5aGq
 pISvwt17ojgaTHq8ArcVvF/iQ4r/2D0x8g5BELqzbt3/NtGQNAZcDB1fWqJIGKtkgElc
 h84z5S3e7g+0xhzncyRl7TeFv6dDl5Ns17fMEbKeiHMTod46Q686BR11olOMBRxhn08W
 YlvQ==
X-Gm-Message-State: AO0yUKUwvWgxW+rfEDbLfE7LNqgTuGIT8HBeAxZ3Hpkt3Trtflw1zQMN
 Stfjt5gBrLknnYcn5a9epZ+eQTesB1+CGWOv88sqMOm+
X-Google-Smtp-Source: AK7set8ffUbjrQ5jpXt76RYC8HoeyKn8UDSHEUccjBdbOOY4YpyfswTEwj8hkdQ3afxizySh9bKZKx0Ppxfk57Zm8wA=
X-Received: by 2002:a05:6870:c154:b0:16e:2d40:daf5 with SMTP id
 g20-20020a056870c15400b0016e2d40daf5mr40346oad.96.1676396393353; Tue, 14 Feb
 2023 09:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20230214121406.97750-1-mwen@igalia.com>
 <75defc22-3b18-262e-5917-c42ab8ee3c28@gmail.com>
In-Reply-To: <75defc22-3b18-262e-5917-c42ab8ee3c28@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Feb 2023 12:39:42 -0500
Message-ID: <CADnq5_MqkGL1+cu7WjF7fGqY0b7RKLr3bJ08gTEHiJwPs_-oZw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Trivial code cleanup around color resources
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: sunpeng.li@amd.com, Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
 amd-gfx@lists.freedesktop.org, Melissa Wen <mwen@igalia.com>,
 kernel-dev@igalia.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Feb 14, 2023 at 7:48 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 14.02.23 um 13:14 schrieb Melissa Wen:
> > Hi,
> >
> > Sorry for the noise, but while I've been working on wiring 3D LUT
> > support to AMD display driver [1] I found some annoying code style
> > issues in the shared-code part. So I'm just sending what I've been
> > cleaning to better examine the code.
> >
> > Most seem trivial, except the last one "remove unused
> > _calculate_degamma_curve" since this could just be a matter of missing
> > parts. If so, happy to remove the patch and include a comment describin=
g
> > the situation (or the potential usage of it).
>
> The display stack is not my field of expertise, but those cleanups are
> so obvious that I think I can safely give my Reviewed-by: Christian
> K=C3=B6nig <christian.koenig@amd.com> for the entire series.
>
> Thanks,
> Christian.
>
> >
> > Thanks,
> >
> > Melissa
> >
> > [1] https://lore.kernel.org/dri-devel/20230109143846.1966301-1-mwen@iga=
lia.com/
> >
> > Melissa Wen (6):
> >    drm/amd/display: ident braces in dcn30_acquire_post_bldn_3dlut
> >      correctly
> >    drm/amd/display: clean code-style issues in dcn30_set_mpc_shaper_3dl=
ut
> >    drm/amd/display: camel case cleanup in color_gamma file
> >    drm/amd/display: unset initial value for tf since it's never used
> >    drm/amd/display: remove unused func declaration from resource header=
s
> >    drm/amd/display: remove unused _calculate_degamma_curve function
> >
> >   .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  37 ++---
> >   .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
> >   drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 -
> >   .../amd/display/modules/color/color_gamma.c   | 140 ++++-------------=
-
> >   .../amd/display/modules/color/color_gamma.h   |   3 -
> >   5 files changed, 48 insertions(+), 138 deletions(-)
> >
>
