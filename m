Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A7BE77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 19:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D74B10E378;
	Tue, 14 Jan 2025 19:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E/w4jysF";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04C010E378
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 19:21:20 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2ef718cb473so1198514a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 11:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736882420; x=1737487220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRkoMhIfo2Wwp19eBs/m3yl20fPyn3NazQt9/6VOrFc=;
 b=E/w4jysFe28RDDazpVNlUJ6KazGsAKWg+lEJpmk92ZEYcYPl5lbLQiOVlzKPZp1X8f
 NhYVOvPx7pxA31n32rfSz4LQY3mL8lS5XkI66JQdwY3LoW9UYgt2n3DhbdoUzi6N47YQ
 z6v51BH0gKE10IgbXRH8JOqc75WcwPTzmhTYqu6DeOIk5FIAgSzpmpqgWZ5FAwiJvbkl
 G//l8fhh22BdW1SKrtVeQKU3yScSh9m8xMy9uYfP1HMMuEAP932s0qU3B6RB8q9Z5t7w
 lo4dgueQJik1xzXPH0/zihIeYA/5awVkyyZvAnqcHxbt1lswPkM5vQNUbTfp/AVggL/h
 2Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736882420; x=1737487220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yRkoMhIfo2Wwp19eBs/m3yl20fPyn3NazQt9/6VOrFc=;
 b=oX8ohr3v2O/QFQnAzJTsTxcv4YrfCWjhJHJZtM7Zt24HEnCz+7cZvDwgwxzDlM7efC
 /ktP3QxGkYjQCDrFKvaZaRYDTUcO6D0vzjWEp8UvMb6z/HQi/dXpaZmNcJair/4c/AuW
 YQNzoCv2OHWwrB+zA8kZ/Z23MllM/6YFg+SMk4AwKpXEQO8A0h6NO0MiP3uBRTajHEaj
 IJ/lVVlWqCZIiRzi0QkPWBup3GafSrfw9QmPz9+AbeB2gd8Mt75e7xgsehCOv/GUfxCz
 DGgJ0d2KAjWIXyUqU0DamIuayKNvc1veUk1tEVOi5U/u14kcjbH3p7Lr71/hWPMgGZgf
 KeSA==
X-Gm-Message-State: AOJu0Yzwb4iFP3N5mdG0PFS0GfHsRtxO1nNVWeptb5kYgbMLkek34k9l
 QiZGz1GwLVMDxSCCKa3cIMfgFrIPvWKwkPWWwqnXLbjPSZak3FLbBND/u5xgR35EBYNYYqveFGh
 TdbCjZY5pj73weP51gMWDEx5UIOw=
X-Gm-Gg: ASbGncvjN1YVPQxrw46fMYkhb/5zgsaKuN27auWYIgYUye5eiQiStPGJKo4zGabMWz0
 4+xb8Vp6T5p5rpAkG21x2hKK9k9qBcYVcTwqGbA==
X-Google-Smtp-Source: AGHT+IEMVCQac+uZ4VmtTz0atKCL7mXhnl+yY/CsgX6mGTLxfj7YLlDqsCe9FirmPADZPBaPIY4/MZXdb12z53cGyzY=
X-Received: by 2002:a17:90a:d645:b0:2f4:f7f8:f70b with SMTP id
 98e67ed59e1d1-2f5490fafb1mr14961180a91.5.1736882420174; Tue, 14 Jan 2025
 11:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20250114183045.23341-1-aurabindo.pillai@amd.com>
In-Reply-To: <20250114183045.23341-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jan 2025 14:20:08 -0500
X-Gm-Features: AbW1kvb5c3YbvPKTGo55DpdJtQtGxo_GcqVxIkASB54uqOJ9czPykiVyVbbLL2s
Message-ID: <CADnq5_P-DqCY8yHkmvSg_e401aDfMe-FSaO3LzDBQ0vFZ1vhog@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add debug option to disable subvp
To: aurabindo.pillai@amd.com
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, alex.hung@amd.com, 
 sunpeng.li@amd.com
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

On Tue, Jan 14, 2025 at 1:31=E2=80=AFPM <aurabindo.pillai@amd.com> wrote:
>
> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
>
> Some monitors flicker when subvp is enabled which maybe related to
> an uncommon timing they use. To isolate such issues, add a debug
> option to help isolate this the issue for debugging.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>  drivers/gpu/drm/amd/include/amd_shared.h          | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e0c977e28626..fe75fbced027 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2033,6 +2033,9 @@ static int amdgpu_dm_init(struct amdgpu_device *ade=
v)
>         if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
>                 adev->dm.dc->debug.force_subvp_mclk_switch =3D true;
>
> +       if (amdgpu_dc_debug_mask & DC_DISABLE_SUBVP)
> +               adev->dm.dc->debug.force_disable_subvp =3D true;
> +
>         if (amdgpu_dc_debug_mask & DC_ENABLE_DML2) {
>                 adev->dm.dc->debug.using_dml2 =3D true;
>                 adev->dm.dc->debug.using_dml21 =3D true;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/a=
md/include/amd_shared.h
> index 05bdb4e020ae..c3e6dd4f4e00 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -349,6 +349,11 @@ enum DC_DEBUG_MASK {
>          * @DC_DISABLE_HDMI_CEC: If set, disable HDMI-CEC feature in amdg=
pu driver.
>          */
>         DC_DISABLE_HDMI_CEC =3D 0x10000,
> +
> +       /*
> +        * @DC_DISABLE_SUBVP: If set, disable DCN Sub-Viewport feature in=
 amdgpu driver.
> +        */
> +       DC_DISABLE_SUBVP =3D 0x20000,
>  };
>
>  enum amd_dpm_forced_level;
> --
> 2.48.0
>
