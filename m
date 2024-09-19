Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A94CDD57B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 13:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A7210E6E7;
	Thu, 19 Sep 2024 13:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JwnfiUp6";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 683F610E6E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 13:19:04 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-7d50ac2e3f8so65253a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726751944; x=1727356744; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4knBA90pBX01dDLpb8b8Hdd1YXakegAXYRByPCSJJjs=;
 b=JwnfiUp6Lu89rD1KvPbOK3HZu70uiRGNeElYuJNa5NfNGbCajCcjMdq6JIYWvRo+lm
 mrYfOqO4xb/St1vC1ggdS6boa2FCzti1LPGocOaH0f2KjE1M7iK01rz2L4CT3Qw7UwXd
 8u9y1taqHAyDW6RBCnXaDQIx24BM06vi6+OazHJDfpiCeWEc5yTuMmu93HlwcuZ/YBhU
 fybnLYrTdGJX+hd0xe1DwBhxCQ9vv6IMGi3jDYZbBg2h/D/FJAmuKsVoJwz+w39rvbMP
 ew5AhVQMilah6/sNEkmBCnopmeeh272r1QKrWOLQPTbjZ0ZnGhWvaBkiiIF1xxvFFCPc
 6yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751944; x=1727356744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4knBA90pBX01dDLpb8b8Hdd1YXakegAXYRByPCSJJjs=;
 b=mJzne6AFvpQ4pMsh3sR0rCViU1xqT3qZgUnEpMU5VBuFSlLU79WZnddJB7BzQMYTm1
 CFd76ZXaMcBOgZ+hNg4rS4qj9OA0rxtMf3nyHdj2PfMKenqCgVoYLzsgJPrMc1JhCp19
 Y5L2r2qPC6bGYYpfik5JrIsbotrDqI+5X0sQ3SGi2Nop8g2BnhSh1sYSWV7gKK5f59ye
 TwxmPPniSZ9zGJUuA0rtOeAAtCxF/NB9Yo2J3dDg/rV4bzmkFIiIQFj6wIJL+8Ir6lKF
 DVXOOJOnNiLDMlu62ojQyHKQ+iCP5SGseZlKxcEgppU6qFNqAZKBb5s05BArvWDfCDyD
 QrNw==
X-Gm-Message-State: AOJu0YweibrIUl925tzO3reOecLLFmNZk1HWtGRAhZkgn5zj5N8wq8wy
 v5BjXiFjPbAgcO+C+sL2hLGRkw6lGBogz7J6/FNbv/5Mpe8xSqX9Of8bOIi03VSyuRbgY4jPWg8
 nY13qRcAzE43WUFsL7BRy++ZavWI=
X-Google-Smtp-Source: AGHT+IF+Ata/VUt1KQq8MvbPTq8Dmt3Iczz1zGgwUXJ/EN+eHGw34S+U/8g0swWIA+JIYlLrB4jAgF445AeZdDcHpE4=
X-Received: by 2002:a05:6a20:6a20:b0:1cf:43e0:d75f with SMTP id
 adf61e73a8af0-1cf7648f937mr17244025637.7.1726751943891; Thu, 19 Sep 2024
 06:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240919104400.155699-1-lincao12@amd.com>
In-Reply-To: <20240919104400.155699-1-lincao12@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Sep 2024 09:18:51 -0400
Message-ID: <CADnq5_MVcNjOs9O=zyZjn4GkgxjXROG-2Yqm=0k1AMbdV3Ghrw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/swsmu: disable force reprogram HW state in
 SR-IOV environment
To: "Lin.Cao" <lincao12@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, horace.chen@amd.com
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

On Thu, Sep 19, 2024 at 6:53=E2=80=AFAM Lin.Cao <lincao12@amd.com> wrote:
>
> SRIOV do not need to forece reprogram HW state on init which should be
> set from host side.

This function will still get called indirectly if you change the
performance level via sysfs for example.  This proposed patch avoids
the programming at init time, but it can still get called at runtime.

Alex

>
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 4a6b4ad97f06..a67678ee2d3c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2234,6 +2234,9 @@ static int smu_adjust_power_state_dynamic(struct sm=
u_context *smu,
>         long workload[1];
>         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
>
> +       if (amdgpu_sriov_vf(adev))
> +               force_update =3D false;
> +
>         if (!skip_display_settings) {
>                 ret =3D smu_display_config_changed(smu);
>                 if (ret) {
> --
> 2.45.2
>
