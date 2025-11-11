Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CF8CCFA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Nov 2025 13:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB85D10E046;
	Tue, 11 Nov 2025 13:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EKwWEEww";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB5C10E046
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 13:38:24 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so20177645e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 05:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762868303; x=1763473103; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GrwdyoxI2lUALNY0TRANh662eC4IKDTitbT7pD9E+gE=;
 b=EKwWEEwwkUwelNVO+Nu7eLx/Zxa6N7qg5fQVV2wu2OwhcBaYSWylexvB3atBTmMKtR
 l5BYHoNXxUJKXtBrUN9VUdJpodOCyNsXS6Pm0QPkuoP+VCGPZFgAiVuZ7H20IdkrT1MM
 NyoZ1SHEZU6sby5eyXYaB4emXARKNB0hDukhjAfr6+AibR6t5Fot73YzfT73RqqPtdVj
 we1SBNBuEp+BZoaoUNFxjfEnR2DkAAAyAT0xJpWWQYHvsFsDlOEStcJ7oNrWncvyZqur
 3um48Uea/YflUBzj+u0zvdFgd7R0jVo4qJiW13eM7b90M7P+mIqeNoErF2bRAjyxWEKF
 zPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762868303; x=1763473103;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GrwdyoxI2lUALNY0TRANh662eC4IKDTitbT7pD9E+gE=;
 b=Hq4ndR8DwrmX7E8jUmVHA4ycDh1C4obKO/hcNBx0/Uvr8vLhmcJNpotFul23qtsw6Z
 xFd/yfc9sqbz5VQO/VbmnV5rEtya+oElVFI7/3HOS4GSZHdkf6tBEK0zLDZp9pz+aGba
 PaBkj68XArgSA3+KPxbVJuUouwtrS4epX84ck1Mg0Z4lkm2r3jf2IH+pbwubKrrLPtR0
 vaZ5qQt2BxfEvsllDGfOW9BXBQQagAQUwdUc7NFfbKedKnyvDWWP8S+ASHqSbYhhLGEQ
 R34GQsW9pM5/cmaSbxTO8Tyaxl/398YlCwEbvcPI/K4BHC2fxdLtTqtxM8SBQVY2ieJ+
 7TMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPsSDg5TgQV6McAKVarLtu73p5fe4+kic+UP94QwSjkzBuvYL2BNAcrLLjosaIKtWcKTmLafa6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHDY47svFJ3i1MMiq1BQKUdlKSSY2vtiXnDyKA348MNnFRbHKQ
 m2/OpS68Psfn0LRS/Fwwh2FjVtUlWEzb+MfAWyCe2U/o6ZiNz6j7JvlT
X-Gm-Gg: ASbGncvTPatDh4z2wf1Wjk9Nf3he1br9jCwg4w9EYTAtPJZqQpveAZjxxqZ7wmPqb1B
 MQzZVIgbmeiXuuXTk01Mwv7tDHPWtbqR8r9AdbRXBS5g0mFIjCCQo/Y40R7P3nRJw+I/vn8Lmvd
 qeEsP29yoB+/IvsOU6cw51ICa6YKYrgnol3uTPaD8k/9YWc5HdXUP06Wop1pnqMyZRNXN/BQX6O
 0GsrlF3yT6t2+RM2ILhYWJ2tn8deg+aTXadyoUUh4ZUyC1cEmjJYER14u0TvJqTI2kJk8+iCgGG
 lR38v+5UWDcQ0drDVLHMdCiechfcbhUm7Obi20/TWYgzEYtjmfQIVhRswVuxS5hHXlWF4LkvjvO
 H5Jxx5CHbMLgoasr1GTDNrl9+iXSRCFGgSojB8ICcdvYQL/KmH0pccPjuTGvGMywVSknxGFjkOx
 YquF5F6S5h/NuYOcmidtv/BhEEDJY5YH37j0wlLjvk5/Ok81WuAHLe
X-Google-Smtp-Source: AGHT+IHxdICTtfr47guR8kd1BuuHAytzu5/NoRm9sPjURe0K3ZBg2j5w6eGHi02CQPOhU0gaerumoQ==
X-Received: by 2002:a05:600c:4583:b0:477:19b7:d3c0 with SMTP id
 5b1f17b1804b1-4777322d955mr107093375e9.2.1762868302753; 
 Tue, 11 Nov 2025 05:38:22 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24e1:af00:ca8b:1d2c:125:e560?
 ([2001:4c4e:24e1:af00:ca8b:1d2c:125:e560])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47781d4a91esm19273035e9.4.2025.11.11.05.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 05:38:21 -0800 (PST)
Message-ID: <e8d330e5262e7db6b2be739f849849307f873555.camel@gmail.com>
Subject: Re: [PATCH v7 04/15] drm/amd/display: use drm_edid helper to set
 analog EDID caps
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Melissa Wen <mwen@igalia.com>, Harry Wentland <harry.wentland@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Rodrigo Siqueira	 <siqueira@igalia.com>,
 airlied@gmail.com, alexander.deucher@amd.com, 	andrzej.hajda@intel.com,
 christian.koenig@amd.com, jernej.skrabec@gmail.com, 	jonas@kwiboo.se,
 Laurent.pinchart@ideasonboard.com, 	maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, neil.armstrong@linaro.org, 	rfoss@kernel.org,
 simona@ffwll.ch, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Michel Daenzer <michel.daenzer@mailbox.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Date: Tue, 11 Nov 2025 14:38:18 +0100
In-Reply-To: <20251106165536.161662-5-mwen@igalia.com>
References: <20251106165536.161662-1-mwen@igalia.com>
 <20251106165536.161662-5-mwen@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Thu, 2025-11-06 at 13:49 -0300, Melissa Wen wrote:
> Use drm_edid_is_digital helper instead of open-coded mask.
>=20
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Thanks for catching this, I was not aware of this helper.

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
> =C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git
> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 7d05cff08233..05e5f51b0a90 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -135,7 +135,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
> =C2=A0	edid_caps->serial_number =3D
> le32_to_cpu(product_id.serial_number);
> =C2=A0	edid_caps->manufacture_week =3D
> product_id.week_of_manufacture;
> =C2=A0	edid_caps->manufacture_year =3D
> product_id.year_of_manufacture;
> -	edid_caps->analog =3D !(edid_buf->input &
> DRM_EDID_INPUT_DIGITAL);
> +	edid_caps->analog =3D !drm_edid_is_digital(drm_edid);
> =C2=A0
> =C2=A0	drm_edid_get_monitor_name(edid_buf,
> =C2=A0				=C2=A0 edid_caps->display_name,
