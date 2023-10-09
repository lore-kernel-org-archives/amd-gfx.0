Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C12E95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 14:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD7010E125;
	Mon,  9 Oct 2023 14:44:27 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A78E10E125
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 14:44:26 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6c4a25f6390so3092607a34.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696862665; x=1697467465; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQpZUoavLBBo7rEqaNzU0du79mkxFPIslW3A3rkQNZs=;
 b=X783/fFP7W42KMmCw7D3DrUnc1pCWySuc3mWLVS3Bo9kcB564gls3hRhJeR4fx7/ht
 jOkgha+tpkFscmtMhv8LI0iKAxyuoxffxvLQpvJM738TZ4676EVOGiejHEJp5XyZWP2J
 /9qH6LAOCU+v2GzXEIQ5Xmm9/tpnIWM5Rmhz59J9+jJtMOGyIioQYoAPBqafttHQZcx3
 707WuI+Y49f7ZFOj18Y/IrnOTQkNmCY5GPTYwAI7aAEdCK9NXR34taTo1zh8TRnPgSyV
 WXizO6e7QxDCDqdnwpro+x2an4EGuGdE/oh+5IihlzyiWyaCJz1IVMup/3HwrxxSf171
 /ggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862665; x=1697467465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQpZUoavLBBo7rEqaNzU0du79mkxFPIslW3A3rkQNZs=;
 b=dUMSwd7hUlW8BbEHO6d9HeRufzn+Od43KgA0Ppge4tvUsWSaqwu+H9QYAkINzVQPDQ
 JY5trKlSlKTMLkJb7nODjIL7ml7jCoEMBOBr+4azO8hmGKl6iI+SPUXAYqBBr0cX04n/
 kaFoL/1ZreY62TJd6p6Z44GujzU8bsbP9WQtQu1cBNQnpVKUGqQ50/c4HuRxum6TZN9M
 tLfkKkpnGskwsVF1HNg95q0srq+hMiQjXLHftizfqwbLxby0FeNaZEInLZkrqqP/3nva
 hZ81OxnlYh3BxbUGhk2DQRH7qzCsj+EYVrKYZhy7ZJq1Xi5zr2Aym0D4MfPyZ2WpR3s/
 Y4tg==
X-Gm-Message-State: AOJu0YwbL6u404pZnsX36udlIFjD0qtI5EjQsijiOW6qWzRcuB+si+d8
 m3bt4ssRc9EdcmNls104iGUF9IpmBhHuZ7MXAvM=
X-Google-Smtp-Source: AGHT+IFg0c1KeJH/MlaWspZBxvbI+lQCOLQkqEBBg7JG68TJby/dtZUOKiblE3dZXBxzqORAQ78UtVZjOJpMJ/GUJoc=
X-Received: by 2002:a05:6870:f103:b0:1d5:8e6c:1794 with SMTP id
 k3-20020a056870f10300b001d58e6c1794mr16890875oac.58.1696862665335; Mon, 09
 Oct 2023 07:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231006185026.5536-1-mario.limonciello@amd.com>
 <20231006185026.5536-6-mario.limonciello@amd.com>
In-Reply-To: <20231006185026.5536-6-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Oct 2023 10:44:14 -0400
Message-ID: <CADnq5_MhtJtYRB=g0+ckNoSw1rKCo2btzm01QSA3Twk1MYVusA@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] drm/amd/display: Catch errors from
 drm_atomic_helper_suspend()
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Harry.Wentland@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Oct 8, 2023 at 6:57=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> drm_atomic_helper_suspend() can return PTR_ERR(), in which case the
> error gets stored into `dm->cached_state`.  This can cause failures
> during resume.  Catch the error during suspend and fail the suspend
> instead.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v4->v5:
>  * New patch
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a59a11ae42db..63944d3b9e8c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2716,6 +2716,8 @@ static int dm_suspend(void *handle)
>
>         WARN_ON(adev->dm.cached_state);
>         adev->dm.cached_state =3D drm_atomic_helper_suspend(adev_to_drm(a=
dev));
> +       if (IS_ERR(adev->dm.cached_state))
> +               return PTR_ERR(adev->dm.cached_state);
>
>         s3_handle_mst(adev_to_drm(adev), true);
>
> --
> 2.34.1
>
