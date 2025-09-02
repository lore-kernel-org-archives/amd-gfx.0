Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C917CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 14:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 415C010E0A5;
	Tue,  2 Sep 2025 14:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EJd6Ir3Q";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 530A210E0A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 14:14:42 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-24b150fb800so1876905ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 07:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756822482; x=1757427282; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWCAu5SjEYrThBfusRio297/qEr4sArFegdpD/cfvJs=;
 b=EJd6Ir3Q0SEBrKEfhlVxV2FAawJGf24tg3fpRH/9nS1OrxjoZ8p9T1g9zlAfymQwT+
 VQWlDOFWeWhTyLPoRN1hX0y7t2YRsgNAzHeGNuynf9bTCcfFSkhQladRUBqxbKztxxML
 KcgW/c9S7tdMCdJRNj8apq88TTO/HTFOpxk/zDkUThRGurArVTMIicqQpx8DjzRmNNS3
 SQiI1PsBWKjniyYno0zsWA9ixkuqszSSy6srzmJmi2XuX+D+bVrX3dhXObzoHhYtp0C4
 6wHzxuokfynkNXVBX9+oHpxxQVqVaVx8H1UZPu2BLKzpwZ5X4W3DuaSHfTpks5kXGpcJ
 SNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756822482; x=1757427282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWCAu5SjEYrThBfusRio297/qEr4sArFegdpD/cfvJs=;
 b=WbHRUxt1JfdEBG9/7xvxdZTZ81XDk33+s6bZj0pGvhoQCzhkQYaPfqsnL7ieSqH0UM
 Z47sUNuNNxVzaG9hmiCtCaKXm3n+Ocgk/e4nztJgRuJYoSIBstEH5edvQ5OBdzqPDuNb
 wTBI86qSDTFy07iEdIRlIdAEKKeaNZHdeDu/3DiNuQu/tJFsfzRcdn5z0e6pOSXlMo84
 52K1Cwm7IyIvnInJnqLFmMgOuli/0ksjmSPrvT6m9Q52QeDBaifuZBGfsstgKBDOGfx6
 pgL7Sd7+1rkUIGfYe4GTh9LGWRAWVRAXVQxAuC02NGOlXm+YOqSA70b0rKCbMZNNi+1M
 3FjQ==
X-Gm-Message-State: AOJu0YwKMHNXvHD2gANB/8/dSt0ahDOiB+w5Hox8qr3zqywCYHfyhzT7
 22hTDXFyDukLuDzWAkZRA5m+WgHkMqlBIWBnMBHZLV9Rb+eMfXzQ9m7sTs+MkHdPcqBOYqNbsFK
 BTt/jfR9KG4oncL0eVTd/O47PFkaDsS/DjA==
X-Gm-Gg: ASbGncsrvPvDKPHuwFKq/QetFu4/ns5q5A/4FAM2FS3H8SJ+XxY5ssRJ4UdyAIWIQTh
 F+M3Xpfn2R+cuX4uRoj2SXv6Kl9HSCJPD3AxeP7FmfAV54v6mVo79+Qmjkoa9TTPDu8ABnUcmjL
 LF2nVzcCOlLrk9caoBSC6GEbIzzeF+YYgL/E27WmB4yjPqAy3j5m0UpTQ4a2WJYRU5wALWnZL/i
 3NIAOw=
X-Google-Smtp-Source: AGHT+IFUGG7afsZP5DWluIzS80iy+kP3sX9U9hg5+AM2pR4NhpuETpvzpnh5b5SaZ6x0ZvK0DIDJ4eVItM/O6ovfxno=
X-Received: by 2002:a17:902:c409:b0:248:79d4:939f with SMTP id
 d9443c01a7336-2490fc97225mr103336235ad.7.1756822481782; Tue, 02 Sep 2025
 07:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250825142347.45997-1-jinhuieric.huang@amd.com>
In-Reply-To: <20250825142347.45997-1-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Sep 2025 10:14:30 -0400
X-Gm-Features: Ac12FXwtL3qtiNGeTjHoHM-xCq4tw1K7jpo_ZD_ehvVed8_5-SZYhVHwg1tiAxo
Message-ID: <CADnq5_Nq60d1scwgCRoDfX3hZD4Vc+LW69GDy6vhOz_da=EWzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix p2p links bug in topology
To: Eric Huang <jinhuieric.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Aug 25, 2025 at 10:33=E2=80=AFAM Eric Huang <jinhuieric.huang@amd.c=
om> wrote:
>
> When creating p2p links, KFD needs to check XGMI link
> with two conditions, hive_id and is_sharing_enabled,
> but it is missing to check is_sharing_enabled, so add
> it to fix the error.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c
> index 82dbd68d8c99..5c98746eb72d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1589,7 +1589,8 @@ static int kfd_dev_create_p2p_links(void)
>                         break;
>                 if (!dev->gpu || !dev->gpu->adev ||
>                     (dev->gpu->kfd->hive_id &&
> -                    dev->gpu->kfd->hive_id =3D=3D new_dev->gpu->kfd->hiv=
e_id))
> +                    dev->gpu->kfd->hive_id =3D=3D new_dev->gpu->kfd->hiv=
e_id &&
> +                    amdgpu_xgmi_get_is_sharing_enabled(dev->gpu->adev, n=
ew_dev->gpu->adev)))
>                         goto next;
>
>                 /* check if node(s) is/are peer accessible in one directi=
on or bi-direction */
> --
> 2.34.1
>
