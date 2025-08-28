Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB1CC8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 14:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B94D10EA0B;
	Thu, 28 Aug 2025 14:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UuzYY1p2";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3535310E9FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 14:32:06 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-248f2da72edso783535ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756391526; x=1756996326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2I9d9O1aancjSBcMzDar/fhsmKojO5gFDqCfmIR9Bg0=;
 b=UuzYY1p2nQs1i2LtuuhyKKPg82DiB0b78QZJCw5zz5ABfUDUNStZTMchh8Nl8f+HTM
 JXd8LJoOoF5/tWFKft5k+/m4/Ao7qMn4NsK2lOag6rHL1YCVTxRkmw3nT49/WnFay+hQ
 YfbylCWjKO55lMrscfGTW+7qL3yOHrslFXA1BCsg5GRf0nbpgTDeQsVvODHChr5vkzzw
 6AzORnHDCM36Q5Bs8t+svFo0efq4mtjqqHuUADHw1WOrNprZGeBUHrTUgiLTqLdJIJD1
 0liI93/Lo1tV5gbt+iNofEqhkP2L3S/tDLPkJF+dFDZ1yitj8adHzJfBiPilJMeb2tQJ
 77Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391526; x=1756996326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2I9d9O1aancjSBcMzDar/fhsmKojO5gFDqCfmIR9Bg0=;
 b=Dx/tGBBliFDZIKSw5XarodcWBKN9eH4yzW0QFNPVfGuQBR0mW+MMaZkgi2Vbih3kyH
 EWeOgq0UY6fa6WyORm7bKHgiCpAZ8itMbtp8JY7yYW6tvlH9L3K8tl8SKaUCicnKIOgd
 UfmxLhNrzGmg/u7ITzU45sYPNK6Rbvc5UVLpsx0zOSBHoPem7LwxWmtaEHbQS9mS1tQl
 PifeJYoTavhxokiQH0R7Ba0wk7sbd1pAQ1Ff9Ecu7/FFedLT4A1SdNBAGTGXbvjcj2av
 aVjZeuQpR1rEMnmjp/tVUn7TqhRnLMvlfnd2wBrnBt+ONnORs1sbRo8ILNR35Dx4ocWB
 h1Jw==
X-Gm-Message-State: AOJu0YzsY9lLqpIZqBEYWeEpctoJcq9FVXsl1u2Lm0QkGIPk/mUlWnMq
 BOTCkMFWn1AGOkt/HIEyKeuj2FUnAL6cJ1Hg45S2kPEnwEvcXNA3wszx8vWgZzUe3C1MI1Vgo9a
 Tar9Jb3VpNuLVJ2428nbNhlgKLngKrNw=
X-Gm-Gg: ASbGncvkHdzcTG+6Ffi6r1jA92L+cM9d6WvN6DZdkZIH4YSGt6MQJk2G6sE6XrwC9EQ
 W0Voliiy0G+gfinHPoczzwgI8uhlkUD+Dd3i5IFmIPhRm54kI1xJ+xNJTsRFRN6W6MA+oOSZKe1
 hddoXvXv/jXva7rNbDaTHvmDF/fnj0kAWZfCNycbozkKCT2Cgxiln0D8/WvGFB7Q50HBwEd2VWJ
 hOODtynSXwBrIgIlQ==
X-Google-Smtp-Source: AGHT+IE16tU7JgvJ0lS1TKZXBF0EYZVg9JLR/E+sLEvor3A2i09e20Yig3ih/U3toYkEClJ583uYs6G/aUsRHdJA/RY=
X-Received: by 2002:a17:902:c951:b0:248:9afa:7bc3 with SMTP id
 d9443c01a7336-2489b09c5damr48923455ad.8.1756391525562; Thu, 28 Aug 2025
 07:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250828140856.2887993-1-superm1@kernel.org>
In-Reply-To: <20250828140856.2887993-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 10:31:54 -0400
X-Gm-Features: Ac12FXw_zuE60CZpJjz51LM5OkVGNf_IKyVly_IGXqn_BxApOxs5TIIVxnlTWY0
Message-ID: <CADnq5_MFts43dTXP3h1s4+LHy=Hi=2SBs23H0h2kockzg=BHEA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Re-enable common modes for eDP and LVDS
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
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

On Thu, Aug 28, 2025 at 10:18=E2=80=AFAM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> [Why]
> Although compositors will add their own modes, Xorg won't use it's own
> modes and will only stick to modes advertised by the driver. This mean a
> user that used to pick 1024x768 could no longer access it unless the
> panel's native resolution was 1024x768.
>
> [How]
> Revert commit 6d396e7ac1ce3 ("drm/amd/display: Disable common modes for
> LVDS") and commit 7948afb46af92 ("drm/amd/display: Disable common modes
> for eDP").
>
> The panel will still use scaling for any non-native modes due to
> commit 978fa2f6d0b12 ("drm/amd/display: Use scaling for non-native
> resolutions on eDP")
>
> Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab=
.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4538
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d533bd633f163..bb156c26a08ee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8440,8 +8440,7 @@ static int amdgpu_dm_connector_get_modes(struct drm=
_connector *connector)
>                                 drm_add_modes_noedid(connector, 1920, 108=
0);
>         } else {
>                 amdgpu_dm_connector_ddc_get_modes(connector, drm_edid);
> -               if (encoder && (connector->connector_type !=3D DRM_MODE_C=
ONNECTOR_eDP) &&
> -                   (connector->connector_type !=3D DRM_MODE_CONNECTOR_LV=
DS))
> +               if (encoder)
>                         amdgpu_dm_connector_add_common_modes(encoder, con=
nector);
>                 amdgpu_dm_connector_add_freesync_modes(connector, drm_edi=
d);
>         }
> --
> 2.43.0
>
