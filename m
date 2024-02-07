Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A23C4828F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 22:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D99510EAF0;
	Wed,  7 Feb 2024 22:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bD6ZRpxS";
	dkim-atps=neutral
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C654710EAF0
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 22:37:24 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-214ca209184so775508fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Feb 2024 14:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707345443; x=1707950243; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9zpDUyn3vjJXqe+Yz1R83TaXqWSjtPVxlOzzZEEj5U=;
 b=bD6ZRpxSgimBBIKGayje2ma46H5ECEq18DpgQmvgQCSyvG7+AKvbuWf+WLz+zyteFx
 VDagVlpiHHdoShQ+lhYuAkeCe3zyH5Xaab/Ch+Oy7cXUozJriowoRIJ/wvYmRgQzNcDy
 yStt5Af2Hf/oSkg4e2m83IKYPXF1Jrfm4Eiy2DsmPyowWjPZR8GvinQTRqz7lYLZTuRc
 8HKrF9pxaLwKX6new3vm2slW5CC1IUVVNuzVuV9i9HdpW4m4cxvor4b2KxeGpt9Nq1fv
 OR27A18RrifXsPH8OFVEUtH5SqAf4+m1NwWSd6/iPIstxyQptf/5QylSwU7gMdntnmRb
 yDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707345443; x=1707950243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9zpDUyn3vjJXqe+Yz1R83TaXqWSjtPVxlOzzZEEj5U=;
 b=ktuLCy2DcOD9JKlOUC93yszb+/qooqY7h2LCXw5nQ8J+OhF4FVO7/XJH8nZixu71qh
 0hdUzBlGt2DMRR5tPohX6g8hyxK/9aX5Hr9xynJq4CckDH8w6ocXq8+NAvnoCgDSqLCY
 MT7TQBicn3U86p3ZnpdvAeFZRuzmC1QOEvRkIH5t4V75fU9u6rZHrt2AETzEI2I6vOaO
 DptpBguc68MxJ6W86MqRY2Ygo1zu4zoA/NsUmbi8DYR1nc7baVoOdC/FDVV6n5rv++Vv
 0OcYwVYLKHhiL2O3NgS5XGtBheMpe9UB/IzUNFNSwcBcHlgvqxLprPjgFBulU2ncwu5r
 yRRA==
X-Gm-Message-State: AOJu0YyESXAMx1kVIT3f/nKSkwR+hVYxo38fXunEQEM3SJdOJVT6VN4b
 dA1ysciVx9mQR3uOHT3OIYkMZaHwiPB8mq5UocGvFBArrkiKybgRHwG388Ko4Y3r8i7nWeRSuQG
 FjOrUgaNyvkISPzWFT9uylN8CRmOhNFHQ
X-Google-Smtp-Source: AGHT+IEx/81a31Dn38vR+lWbXfxkddsMOQp1Up0TyTeSHYxUgRVR5ZBT62SauKVOEReM18xD3jqxL4yXLguSoooPUKs=
X-Received: by 2002:a05:6870:170e:b0:219:1dc6:fe11 with SMTP id
 h14-20020a056870170e00b002191dc6fe11mr8166087oae.43.1707345443335; Wed, 07
 Feb 2024 14:37:23 -0800 (PST)
MIME-Version: 1.0
References: <20240207204103.82789-1-mario.limonciello@amd.com>
In-Reply-To: <20240207204103.82789-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Feb 2024 17:37:12 -0500
Message-ID: <CADnq5_PmGUGLO5dg+qZiGcPin6a8S354SqKpmRwrq6PK8L3QPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Revert "drm/amd: flush any delayed gfxoff on
 suspend entry"
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Wed, Feb 7, 2024 at 4:18=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit ab4750332dbe ("drm/amdgpu/sdma5.2: add begin/end_use ring callback=
s")
> caused GFXOFF control to be used more heavily and the codepath that was
> removed from commit 0dee72639533 ("drm/amd: flush any delayed gfxoff on
> suspend entry") now can be exercised at suspend again.
>
> Users report that by using GNOME to suspend the lockscreen trigger will
> cause SDMA traffic and the system can deadlock.
>
> This reverts commit 0dee726395333fea833eaaf838bc80962df886c8.
>
> Fixes: ab4750332dbe ("drm/amdgpu/sdma5.2: add begin/end_use ring callback=
s")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 9 ++++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 670ecb789d59..2bc460cb993d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4573,7 +4573,6 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool fbcon)
>                 drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_=
helper, true);
>
>         cancel_delayed_work_sync(&adev->delayed_init_work);
> -       flush_delayed_work(&adev->gfx.gfx_off_delay_work);
>
>         amdgpu_ras_suspend(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index aa8e1d29d10a..9831dd854532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -727,8 +727,15 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev,=
 bool enable)
>
>                 if (adev->gfx.gfx_off_req_count =3D=3D 0 &&
>                     !adev->gfx.gfx_off_state) {
> -                       schedule_delayed_work(&adev->gfx.gfx_off_delay_wo=
rk,
> +                       /* If going to s2idle, no need to wait */
> +                       if (adev->in_s0ix) {
> +                               if (!amdgpu_dpm_set_powergating_by_smu(ad=
ev,
> +                                               AMD_IP_BLOCK_TYPE_GFX, tr=
ue))
> +                                       adev->gfx.gfx_off_state =3D true;
> +                       } else {
> +                               schedule_delayed_work(&adev->gfx.gfx_off_=
delay_work,
>                                               delay);
> +                       }
>                 }
>         } else {
>                 if (adev->gfx.gfx_off_req_count =3D=3D 0) {
> --
> 2.34.1
>
