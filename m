Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D84DCC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 15:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A5110E6CD;
	Wed, 14 Oct 2026 15:17:28 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB66A10FE00
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 15:17:22 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-3550dd02c9cso333733eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 08:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791991042; cv=none;
 d=google.com; s=arc-20260327;
 b=mc409IBmsQkeqCW85MjghbBdvxphVirwwGbzckrYkC0g6szPDS9BDxrZquhLybkrz2
 W9zz70JAXygGRc+Mjy73hY14PfL4vD2Rd8p5OP3KdR5HkXEjdEXLX2tpW4S2Yp2Ictec
 4O4BYIXN3NAMK3cgtQCeG0GfhZQVAEujv+RtjNMFgYZ6BGEXTTcI9dfoaei3M7fH3ioN
 OwbG7o91ifxwthPaVw0hhb5Ysyo5mMxZrlm3ofOMz2jhRTOwGis1UcxaVV73ro53qID2
 zr/Q+gdUzVJOuh0llOX6edo/6WpuGC0he86ukUTFQsUFCZEHNOg7Nwhg1aucjxerYzCj
 S5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MP15FskDIroB85P/ZsRhtMZULyczrJXp5CoRckGiRdk=;
 fh=3UfFCq9duX2idZTMF3iG5fmzgl72Pf3xO/wEOJj/rV4=;
 b=Mdq3ycsGTK/VSOH6IPuJPxg/1X6KS5ZyxxPt0oGJtyfvk2OznfBshlrMHO0eTUqFWT
 7eck3pO4y1lge9t6BeU0NBhHjDh4teW+NUTcvrIBTfXyN2kojRII+h++LWBXdBNrjMhh
 N4ZqVdkrTR8x7t0TB8E+yeVGfKfGtuI7HVmvjLox0Fujm958NIDCbKiMIuOwp05eleya
 GQQmLVFvDPlx8UEskOEUVjLiqNXfkgV+ghpvfABLo1Wtppl1pk7HpbAm5RWWoVoNDHSt
 wFCzQ7X/cm7hWPEtfwGXXdHrDTR2msuIbCm8uPFsMUuRsRz9gFrCr0eokY4uHdvtaQXu
 7ViQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791991042; x=1792595842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MP15FskDIroB85P/ZsRhtMZULyczrJXp5CoRckGiRdk=;
 b=cuO4KGZF5AvZCBNuvx/zxUamm4LUbuJj3wpzBfQM7xf3X0swkhaCPU5hPEKQwmNGcw
 aJy4hT3ur0xEuaQqy/4vW2RHN6rdbnBMGTUVI8lkcwEJv4SUG40VJUhD8T4zbYJhluV3
 V9nEZumyz0z1g84UB1zffe3jNH+AQpYGTzvRJEhzjaPAqs7enXnHFlYZBw9c76BwZI9j
 3kfLcmAlW5mlbE1kjqCazT4VPUUC1D7NF1TtQH4PIelnz8hP5pfsFHnx7D0l1MyzUWsz
 dmSJyP1tjMPsIpl38JgkB7hB8f+b5ZACMfuvSnVmYd0t50k41LSSKRUCG322OzYrFIsA
 BB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791991042; x=1792595842;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MP15FskDIroB85P/ZsRhtMZULyczrJXp5CoRckGiRdk=;
 b=ZG6tRELGOh59/tmhDVO0FjEWkh0yYN6IDY/SRlzvDYw/A02js/YtMsAsuNTDf4FE1C
 W0OboHLtkDbSwaAA98BgzXneuAfqRyDxzYoNmZZ0nixnpKQeEyoeQVHFLGZ8IIWe17PL
 A4jFAT0/hrWP1Dfx/vX8iePU6Q63hWbg0iYbOv14Em599e6CV9D7NLl0k0yHf9Puur/m
 0zrEEcO6rWi3d649di/TKPHf7ZzQixEg0b4UOEZ9MUL/LI7yd64jk/07DBq/ZNKQKiFQ
 s3hWNld+HgjG7cxPjZeoUVPc9aqFe+skjHg3sSX3KJ9OUIdoHBHCB1OC44nfxPoAXwVW
 +b9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrOVDapGeWZuw6jvfYZ0TnYwgUGr+8tz3LhdFUl5l7D39MxLlh07F/EbjOGi5GK9PlkShFzXK5@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIs2SxEyvlYC/iY3AC5la1Cy+/MdERn2psshZxPBStn0juTs0Fo
 3zBZv7f/AdoGzL1QW+DPiU3sFktMgaMtA4bQ+376XfE4trCoE80IsELqAnvx+s7TiauofqfWlTO
 h1Qn7/30r4rZNQvCGI3FKjAiQ39hd4iU=
X-Gm-Gg: AYBFou2FyNJxqmKoxWlS9yWz4ueqHk540OFSewBvU+mv+TwkNMc+7iMcZ+iFvB0W0ZP
 /zDb0n/A7VVqjJzMq/cGL0uvtY5wyzqJYgyc3WhKmP5tefyaye8rLl2Gok1WR5zzjElcjCV9DQs
 3RC5OO4zUrU8R2FIc5PCz/Efw/QQGrCfBhwzNol4qgnGRvUzG3G5iPl2CVug9LwJKxK5yrpmv6q
 zJhhIs9EaueY0ZjK9UC9tsId+Zrp+irft7v23AqAqE8jnTiArodyz6OldRKuu2JfGuRExtMYzdZ
 uPzBxTuHHbimKljKdVtdvyI5taFS7Dtiudm5AuvJ8cAsi3ZShEaitnuVlnKS0I/7satFcgOUEki
 ZdVcJOH7x4CkIeWoQiyKtH51QJb0jDyY8WzupVfI/zQ==
X-Received: by 2002:a05:701b:4515:20b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-16a4e2f6033mr31922651c88.0.1791991041918; Wed, 14 Oct 2026
 08:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20261014073228.2095339-1-thnkslprpt@gmail.com>
In-Reply-To: <20261014073228.2095339-1-thnkslprpt@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2026 11:17:08 -0400
X-Gm-Features: AclHuK9RTzCxHcsg5D_RZu9qnWTIP8aQ_tciSx9Ychi7L8Go00NiqggSGvOxZjg
Message-ID: <CADnq5_OVC0GgZfiKA1yoW3zJXtTK7Wx+TnPQjQE7xW2FkbMSKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: propagate errors when forcing SMU11 clock
 levels
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Wed, Oct 14, 2026 at 8:56=E2=80=AFAM Avi Weiss <thnkslprpt@gmail.com> wr=
ote:
>
> navi10_force_clk_levels() and sienna_cichlid_force_clk_levels()
> return success when a DPM frequency lookup or soft frequency range
> update fails. smu_force_smuclk_levels() then records the requested
> clock mask even though the operation failed.
>
> Return the helper error from both callbacks instead to improve
> observability. No obvious reason to clobber the return values here.
>
> Fixes: db439ca21b81f ("drm/amd/powerplay: add function force_clk_levels f=
or navi10")
> Fixes: b455159c05313 ("drm/amdgpu/powerplay: add initial swSMU support fo=
r sienna_cichlid (v2)")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 6 +++---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index f8ca5eb9adc6..2d05088619f6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1439,15 +1439,15 @@ static int navi10_force_clk_levels(struct smu_con=
text *smu,
>
>                 ret =3D smu_v11_0_get_dpm_freq_by_index(smu, clk_type, so=
ft_min_level, &min_freq);
>                 if (ret)
> -                       return 0;
> +                       return ret;
>
>                 ret =3D smu_v11_0_get_dpm_freq_by_index(smu, clk_type, so=
ft_max_level, &max_freq);
>                 if (ret)
> -                       return 0;
> +                       return ret;
>
>                 ret =3D smu_v11_0_set_soft_freq_limited_range(smu, clk_ty=
pe, min_freq, max_freq, false);
>                 if (ret)
> -                       return 0;
> +                       return ret;
>                 break;
>         case SMU_DCEFCLK:
>                 dev_info(smu->adev->dev, "Setting DCEFCLK min/max dpm lev=
el is not supported!\n");
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index b42897e7c066..4ef3863fae1a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1460,7 +1460,7 @@ static int sienna_cichlid_force_clk_levels(struct s=
mu_context *smu,
>         }
>
>  forec_level_out:
> -       return 0;
> +       return ret;
>  }
>
>  static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu=
)
>
> base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef
> --
> 2.43.0
>
