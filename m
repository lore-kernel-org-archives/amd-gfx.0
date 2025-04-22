Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66986C369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 15:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0323E10E5C9;
	Tue, 22 Apr 2025 15:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mWp9Pt+Q";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A11FC10E5C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 15:25:26 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-30363975406so641254a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745335526; x=1745940326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOMoAl9bSEcvRCzOL70b/TcYJR4NfYN2FwSHRfDY0Hg=;
 b=mWp9Pt+Qlz3Z0wbz5fSKP1RCyMrN5fp9AKPP9U57A/F+8cxFHvlmeoe2Cp+gJqOLsE
 p4thMG/tM6aeE78rCxXQCAK4B2JucM1XmKcB+VuD5jF65umgZbpxT4CzQvzo+RM7zuxP
 RLkYyXpcYXb94/iBVDKfQG5OeaicWzgjyOWacsxCP1wlhPCSq4xBYj60Xr3x+zkPpvUp
 iGoFFPH8/8r8bSfNrpMlSzE2nJEQNYTNYilQK+hBGT1Ek3rzCiwOL7bHDPDNBSqr/g2v
 s05yuG7HmUod6QgL/1P2TKwZWMMiDuNwGuGYSOzh+VZdbuo8HFouGf5cwcKNeJabo5rM
 BMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745335526; x=1745940326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOMoAl9bSEcvRCzOL70b/TcYJR4NfYN2FwSHRfDY0Hg=;
 b=QkZOey/rplTA5qFMe3Sj4O+1yG62DNgvDLu0vWNAqJmV6tv459Ax3Qwb5yyTI55Gbi
 bcFXx9UtWbCLMxREQTDPbtFej3eiGIaHfj89syayC3+YFP9g4ZSaRq8YKZg0+5Ijd6bH
 vnkxPf23xK652pxe7fWL0e8IbfzeqSzUjDN952qQZ+arv1MZroTxR4Dd0fJVAqNMDPZF
 u96iDBFl90UKt4dLy8ZpRirbNIO826cehdLVJulOCBw6UkPL7BW9IIo97tvK5LYBVeeK
 ljHQFOUfaFklZ2bDOaZERZAAXwRDG8K9O7ssUBCavPLOAxQMB6euIaO6ziL3lWiKCcZb
 RNPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWVd8DyMZ8KjNxy14u6cIy8vb27W085jqJ87axh9nisETI01uNnKsk3DZD8BjzWflgdzw6+eQy@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzi4oPeFvA1tbqz8EVbPzz/ZFxJ00NUIuNoofOAxNFJj6jSx6aK
 y4JwPLiMOup1RA6vSOedD6ShMP3pBMFLMLbFrPy+VQgJonSSYIgqpW/UvFuXit8cfqbfAxzO+Vf
 UlvOj6KsWjnkAsEPCQa3bwJD6hFM=
X-Gm-Gg: ASbGncudaDqfwxwL5z5lqL/GAGxQIn4k9WGtC5yGJi2C09ktEIb7V+PaYWtpC2LtYMt
 LM042d7+3TApFWNVKPBVM465Sa4++FgB2i46XYMltiVop4TCA+JGz4NweZz+hgEcAXAktDfFqWM
 gfEVhijfb7O+ZTwKG/pQun4g==
X-Google-Smtp-Source: AGHT+IFQQMeibdshGwHHjlVpI+XG1UAtIpu7/s/4qLr8WVvv6aKDgCXS9whS6DHuEEuNacVt5Z8PsJAUIfe6ro47JVs=
X-Received: by 2002:a17:90b:1a8d:b0:305:5f2c:c580 with SMTP id
 98e67ed59e1d1-3087bb400c1mr9165124a91.2.1745335525951; Tue, 22 Apr 2025
 08:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250421221616.387927-1-siqueira@igalia.com>
 <20250421221616.387927-2-siqueira@igalia.com>
In-Reply-To: <20250421221616.387927-2-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Apr 2025 11:25:14 -0400
X-Gm-Features: ATxdqUFNUikG2eEpIjUmk-clmxwNBs1fAbK7_SHjk0GYVMND8J6pZjDnk_zi0eo
Message-ID: <CADnq5_P0cpgsXzC+wjS2M9Khswrph7q78aGhPP2ouovOVK4Q_w@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] drm/amdgpu/gfx: Introduce helpers handling CSB
 manipulation
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

Applied the series.  Thanks!

On Mon, Apr 21, 2025 at 6:18=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> From GFX6 to GFX11, there is a function for getting the CSB buffer to be
> put into the hardware. Three common parts are duplicated in all of these
> GFX functions:
>
> 1. Prepare the CSB preamble.
> 2. Parser the CS data.
> 3. End the CSB preamble.
>
> This commit creates helpers to be used from GFX6 to GFX11.
>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 69 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
>  2 files changed, 72 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index e1dca45a152b..d81f7975a676 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -33,6 +33,7 @@
>  #include "amdgpu_reset.h"
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_xgmi.h"
> +#include "nvd.h"
>
>  /* delay 0.1 second to enable gfx off feature */
>  #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
> @@ -2247,6 +2248,74 @@ void amdgpu_gfx_profile_ring_end_use(struct amdgpu=
_ring *ring)
>         schedule_delayed_work(&ring->adev->gfx.idle_work, GFX_PROFILE_IDL=
E_TIMEOUT);
>  }
>
> +/**
> + * amdgpu_gfx_csb_preamble_start - Set CSB preamble start
> + *
> + * @buffer: This is an output variable that gets the PACKET3 preamble se=
tup.
> + *
> + * Return:
> + * return the latest index.
> + */
> +u32 amdgpu_gfx_csb_preamble_start(volatile u32 *buffer)
> +{
> +       u32 count =3D 0;
> +
> +       buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0)=
);
> +       buffer[count++] =3D cpu_to_le32(PACKET3_PREAMBLE_BEGIN_CLEAR_STAT=
E);
> +
> +       buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_CONTEXT_CONTROL, =
1));
> +       buffer[count++] =3D cpu_to_le32(0x80000000);
> +       buffer[count++] =3D cpu_to_le32(0x80000000);
> +
> +       return count;
> +}
> +
> +/**
> + * amdgpu_gfx_csb_data_parser - Parser CS data
> + *
> + * @adev: amdgpu_device pointer used to get the CS data and other gfx in=
fo.
> + * @buffer: This is an output variable that gets the PACKET3 preamble en=
d.
> + * @count: Index to start set the preemble end.
> + *
> + * Return:
> + * return the latest index.
> + */
> +u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, volatile u32 =
*buffer, u32 count)
> +{
> +       const struct cs_section_def *sect =3D NULL;
> +       const struct cs_extent_def *ext =3D NULL;
> +       u32 i;
> +
> +       for (sect =3D adev->gfx.rlc.cs_data; sect->section !=3D NULL; ++s=
ect) {
> +               for (ext =3D sect->section; ext->extent !=3D NULL; ++ext)=
 {
> +                       if (sect->id =3D=3D SECT_CONTEXT) {
> +                               buffer[count++] =3D cpu_to_le32(PACKET3(P=
ACKET3_SET_CONTEXT_REG, ext->reg_count));
> +                               buffer[count++] =3D cpu_to_le32(ext->reg_=
index - PACKET3_SET_CONTEXT_REG_START);
> +
> +                               for (i =3D 0; i < ext->reg_count; i++)
> +                                       buffer[count++] =3D cpu_to_le32(e=
xt->extent[i]);
> +                       }
> +               }
> +       }
> +
> +       return count;
> +}
> +
> +/**
> + * amdgpu_gfx_csb_preamble_end - Set CSB preamble end
> + *
> + * @buffer: This is an output variable that gets the PACKET3 preamble en=
d.
> + * @count: Index to start set the preemble end.
> + */
> +void amdgpu_gfx_csb_preamble_end(volatile u32 *buffer, u32 count)
> +{
> +       buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0)=
);
> +       buffer[count++] =3D cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE)=
;
> +
> +       buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, 0));
> +       buffer[count++] =3D cpu_to_le32(0);
> +}
> +
>  /*
>   * debugfs for to enable/disable gfx job submission to specific core.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index ed54095e6ad6..9187b0b3bff6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -599,6 +599,9 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct=
 amdgpu_ring *ring);
>  void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work);
>  void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring);
>  void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring);
> +u32 amdgpu_gfx_csb_preamble_start(volatile u32 *buffer);
> +u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, volatile u32 =
*buffer, u32 count);
> +void amdgpu_gfx_csb_preamble_end(volatile u32 *buffer, u32 count);
>
>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
> --
> 2.49.0
>
