Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAA6C2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 14:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE6618AE8D;
	Wed, 21 May 2025 14:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YrmKZWfU";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A591112E7A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 14:47:38 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-232219cc6d0so2818195ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747838854; x=1748443654; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyjOBiDX28KZ9Ybw5ff4mjrH5xblEXxirGPVj4LYZio=;
 b=YrmKZWfUw+S0Eh+P95yMRBPlWCBv2kKyIIO5kDQjxA1iB+BzR8jeNV+G2DWlATuacG
 Uq6yUXKjctP8ZpTT/0eJ0SmlAnMUKuA4VZQp9WhqgGnVYNnCBRWP4vCJtjmJF4uvpm7t
 ZkEsC/1CWyFCgPfpuz4qx6ruCCYyZJNbO5aC8SNV088Gq6a13T/x7NGY7Sw8FJp6Cnlg
 0vYI65ivwhMClqbIrI3KB/ZrO28MT2CwBnHhTYq7Wrd1BO/xhyCvmoDn/Mh0k9H7WrUx
 BgpapCi2XU2lCskv3tF+9violXv3//ByevMl4dJ2LeT+344D+bZe2caJ2H+Y6+3wLDCu
 wlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747838854; x=1748443654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyjOBiDX28KZ9Ybw5ff4mjrH5xblEXxirGPVj4LYZio=;
 b=NFV9ouRCWAKyKpBPBH6d4xTaRYYn9hWGsVBkyiXLPBgpgV+bCUMJlnlLjN9OUIZPyM
 ff9S+cUa/jjiq3y2dJ7dGOB2/JL8VJ96xGBDIPyTZ1joH6umxcQL7WaOXWsiBGdUgW6M
 owXfhSDJl3gIVJjQFKLu4D4dF9tX6PMmw0bvTH6ax63MFqxmTEqj/CAKJocOaFSdynYe
 x2c1EfSUuMLlc7HHa9AsGXDQWgV6hRsWl588DortcdBhwbfhKSX2M9Lq9Bp3SryGWH+u
 D71Iyyg6XmpI0liwK8RKCLeslmS2+L/BahALiqwavu2yweDOz+a6SDKztzoVJuq9L/Mn
 JKHg==
X-Gm-Message-State: AOJu0YxcOZ8jAAj5wIiQsWtqJiSKMFbgbVmPZkjNL6IPQOhuzNGaAuuY
 pPchBMjBnTZHgCPNPYEIfVMslqDZ/3IPN0Hw+KeTMe0+pcpyHzfBwYdpnNQ3mCPMbyZYxXqRelR
 kyM6kA6oqhYsJoZlh/3UFGSoUnkz5q7wbjw==
X-Gm-Gg: ASbGnctePEWQzYGl7e4GC+M4USKbcaZvQq1GUzDi7Qy1UUPtsWz9Ajhas8il1EKKrMn
 4MhRDQtEfdFSH0ckwFpA5e9QrKVra7cWkRP/9UPuZ8WTmFVCvFEbIhqxP/g6f/+orJwTNjljhbS
 Tq+M98ddRsms5yrlurot78ZycgNIGmoX1Deg==
X-Google-Smtp-Source: AGHT+IE3+jvHmghOsS/lg/GZPbFz203jlaFqZySeUbzHoKB29Meed8xJK/pPDkfX9azmgnsmq1uBfXwsGLScGbRfrQE=
X-Received: by 2002:a17:902:f543:b0:212:48f0:5b6f with SMTP id
 d9443c01a7336-231d45262a6mr105388775ad.9.1747838854182; Wed, 21 May 2025
 07:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250521142508.1868414-1-aurabindo.pillai@amd.com>
In-Reply-To: <20250521142508.1868414-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 May 2025 10:47:22 -0400
X-Gm-Features: AX0GCFsJYRsP5q0hEfdSFKKTTuV4HCFwIPBVnfmweEnRGekVx7Gz3oCbRGVaKz0
Message-ID: <CADnq5_PBj=_dmkZN7Y=Ro99o8-dUTq+Hi7TsHNgZs1PdeRfX8g@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: [FW Promotion] Release 0.1.11.0"
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com, harry.wentland@amd.com, 
 alex.hung@amd.com, alexander.deucher@amd.com
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

On Wed, May 21, 2025 at 10:25=E2=80=AFAM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> This reverts commit 572193a6e3a842204757a6fa2944125811b29f70 since it
> introduces incompatbility with older firmware
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 34 ++-----------------
>  1 file changed, 2 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gp=
u/drm/amd/display/dmub/inc/dmub_cmd.h
> index 57fa05bddb45..b66bd10cdc9b 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -2139,11 +2139,6 @@ union dmub_cmd_fams2_config {
>         } stream_v1; //v1
>  };
>
> -struct dmub_fams2_config_v2 {
> -       struct dmub_cmd_fams2_global_config global;
> -       struct dmub_fams2_stream_static_state_v1 stream_v1[DMUB_MAX_STREA=
MS]; //v1
> -};
> -
>  /**
>   * DMUB rb command definition for FAMS2 (merged SubVP, FPO, Legacy)
>   */
> @@ -2152,22 +2147,6 @@ struct dmub_rb_cmd_fams2 {
>         union dmub_cmd_fams2_config config;
>  };
>
> -/**
> - * Indirect buffer descriptor
> - */
> -struct dmub_ib_data {
> -       union dmub_addr src; // location of indirect buffer in memory
> -       uint16_t size; // indirect buffer size in bytes
> -};
> -
> -/**
> - * DMUB rb command definition for commands passed over indirect buffer
> - */
> -struct dmub_rb_cmd_ib {
> -       struct dmub_cmd_header header;
> -       struct dmub_ib_data ib_data;
> -};
> -
>  /**
>   * enum dmub_cmd_idle_opt_type - Idle optimization command type.
>   */
> @@ -2191,11 +2170,6 @@ enum dmub_cmd_idle_opt_type {
>          * DCN hardware notify power state.
>          */
>         DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE =3D 3,
> -
> -       /**
> -        * DCN notify to release HW.
> -        */
> -        DMUB_CMD__IDLE_OPT_RELEASE_HW =3D 4,
>  };
>
>  /**
> @@ -2957,9 +2931,8 @@ enum dmub_cmd_fams_type {
>          */
>         DMUB_CMD__FAMS_SET_MANUAL_TRIGGER =3D 3,
>         DMUB_CMD__FAMS2_CONFIG =3D 4,
> -       DMUB_CMD__FAMS2_IB_CONFIG =3D 5,
> -       DMUB_CMD__FAMS2_DRR_UPDATE =3D 6,
> -       DMUB_CMD__FAMS2_FLIP =3D 7,
> +       DMUB_CMD__FAMS2_DRR_UPDATE =3D 5,
> +       DMUB_CMD__FAMS2_FLIP =3D 6,
>  };
>
>  /**
> @@ -5953,11 +5926,8 @@ union dmub_rb_cmd {
>          * Definition of a DMUB_CMD__PSP_ASSR_ENABLE command.
>          */
>         struct dmub_rb_cmd_assr_enable assr_enable;
> -
>         struct dmub_rb_cmd_fams2 fams2_config;
>
> -       struct dmub_rb_cmd_ib ib_fams2_config;
> -
>         struct dmub_rb_cmd_fams2_drr_update fams2_drr_update;
>
>         struct dmub_rb_cmd_fams2_flip fams2_flip;
> --
> 2.49.0
>
