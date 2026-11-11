Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4281D606A338
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wiPYvc6K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E2210EA63;
	Wed, 11 Nov 2026 15:26:07 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E5910EA63
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 15:26:00 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso1974461f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 07:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794410759; x=1795015559; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A9dOo25ttZFwgNg8F48g3BkAn2q6ZuSbqW0th7s83iE=;
 b=wiPYvc6K6Tj500jdGEGNe43w4O6YDjuJC8GL6tNKYXX/sCJEMhx4uL3nG+TUNrMBMW
 dvsya7zJvS+erY8LUT3oj04qtHv8Xl3Q8PJW5xUbcYzCOTUKdFM09hKYdXeJObfiigny
 zJa310h/Xj7RavJ3sWgA7Aoo8RPvJAwDYl+P2WJmw81WXIOjc2YFxnVfyFijAPTaYTVy
 63nzeCyuAPD7X17t7T1paYL8mRw6wy+txdvgO93ojolUW6SOtt5NUGAKkICo3J0YDwDg
 8tQgkRR1+QUtPW4Wtj1y9bjLUHh6nG6mMkmGgEKLUrsLRhlTsIyDDDeWLT5TICoJH9m7
 Y2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794410759; x=1795015559;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A9dOo25ttZFwgNg8F48g3BkAn2q6ZuSbqW0th7s83iE=;
 b=1X2cV3g7AQVummMd2pL6DgGZUrwtx5Es6z5GExylmfG9Z+hHo3RlbZCQSnmPlUwf07
 W8HFFLQWbdPA0/AaQ+Pw5k/3lpv4CeK9I2A8y7PpcVZEIcK0O+G0jARtVKJdtFqAz4hq
 58NfV6C+/WpVW27o3Ly+vMj0oSJGUq5le9ir9bW5s4+7erajc40n1bplwLErKXRMiLlb
 qnntQm0abfbHfBoORlymtFY6UVAeIclXigXTroAQGlC1pOah451vICCkUdfDio9xqS0I
 Wcho7O+w9/Gl+waPyWpvh4qDuDRBYTz1SYbNHMH02sleqc+xUXHxdMlI22U6zF3KTDsj
 8q9g==
X-Forwarded-Encrypted: i=1;
 AL+hErE0XHxZe6Zg+yYrdbRGy4vwgfmQIjSCM7YGvrJOJUupVJJJFBNNSuK2r/yP++vOvJZOwVpfpw/P@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8SBc3XHM7Y+zKVPPo+Tzfg3zIcSwY+Wo6tiTFcte6qo6wmp7Co
 kFATR4dsXAyYakSnVxFx4b86UHEXugd8bYBPfWF+OaAqTy2MBvKFMH3pHAhxCqXET1c=
X-Gm-Gg: AYBFou2wfXiXcg7CKI71eybjJFUkOsFRKt1qsyVkKJeRUzM1aN4JjKudFSZhJqtoUnE
 56tUAG2A1OD+mLf1NAIXwO78l0tUubhAzYvQ3hnxMs3RD1yU07KPCrErIyuc32EXfbGS/KSw+O1
 f4v2Y2yWzPiHY/rx0DIlWKGi7L3xOQkdmqi4QiA0H7HRwELCd2bFOoei8Vng3Y93HTqcaotKzIX
 hnM6Oznvm3larxfewHEQBzya8rNqF7nTBUuQs30r3AjgrTS8EqK55iBaa7Es90mtjekMxcqmNVg
 iFL8ZHU1rFirDoWVM7vgSXU5/6CUFfMaUUSTEEteNKQebB6ccPWrJMMOCewLQg1YMFHq8pBmUaC
 gRP9F5k6Egdrnw5YyFi+gbeBzBRWA7lnYrY61X8i8MkS5V3e7dZFPtAuejgNBwFkyc2YSVk1wQu
 rmNBz8HCkWA20rtYi3okdvh1VGgSlOOV+WsHz+HVZFZNblmX24IM+MR43kyBe6FiGXQ8QpGhVn/
 vrxB0FlZeCpASpAHGrLxbkzy5JejcNT7sIcE+mj7zox4kiPwxSKTOJ97afd70blFgeF79acyv1u
 VGg4XRFhYjxcV15W6WFtlMujdeYe0UVEDUYjUu6T244Cp1/BxMU7G3bH7qYsm+lgSRVrL2i+rTh
 FrRFPf9jY
X-Received: by 2002:a05:6000:2612:b0:488:8bc1:a2eb with SMTP id
 ffacd0b85a97d-499c84b6fe2mr4317143f8f.39.1794410758782; 
 Wed, 11 Nov 2026 07:25:58 -0800 (PST)
Received: from [192.168.1.92] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498361f6bacsm11794469f8f.35.2026.11.11.07.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 07:25:58 -0800 (PST)
Message-ID: <be8c36e9adff908f37bcfd59d329ab1207444cb5.camel@gmail.com>
Subject: Re: [PATCH 0/7] Drop non-DC display support
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 tzimmermann@suse.de
Date: Wed, 11 Nov 2026 16:25:57 +0100
In-Reply-To: <20261111151546.3105062-1-alexander.deucher@amd.com>
References: <20261111151546.3105062-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-11 at 10:15 -0500, Alex Deucher wrote:
> Thanks to a lot of hard work from Timur and others we now have
> full DC support for all chips supported by AMD GPU.=C2=A0 DC supports
> a much wider range of features compared to the legacy code and
> supports the atomic KMS API.=C2=A0 DC has been the default now for
> all chips for several kernel cycles and we have an LTS kernel
> for 2026 so I think it's finally time to retire the legacy code.

Thanks, I agree with that 100%.
If somebody still has issues with DC on the old chips, or finds a
missing feature, they can use 7.3 LTS while we fix it.

For the whole series,
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

>=20
> Alex Deucher (7):
> =C2=A0 drm/amdgpu: fix audio parameter documentation
> =C2=A0 drm/amdgpu: drop non-DC DCE10 support
> =C2=A0 drm/amdgpu: drop non-DC DCE8 support
> =C2=A0 drm/amdgpu: drop non-DC DCE6 support
> =C2=A0 drm/amdgpu: remove legacy non-DC display support code
> =C2=A0 drm/amdgpu: remove atombios i2c support
> =C2=A0 drm/amdgpu: warn when driver is built without SI/DCE display
> support
>=20
> =C2=A0drivers/gpu/drm/amd/amdgpu/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 15 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 5 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 106 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c=C2=A0 |=C2=A0 418 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h=C2=A0 |=C2=A0=C2=A0 10=
 +-
> =C2=A0.../gpu/drm/amd/amdgpu/amdgpu_connectors.c=C2=A0=C2=A0=C2=A0 | 2063=
 ----------
> =C2=A0.../gpu/drm/amd/amdgpu/amdgpu_connectors.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 41 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 37 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_display.c=C2=A0=C2=A0 |=C2=A0 670=
 ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_display.h=C2=A0=C2=A0 |=C2=A0=C2=
=A0 13 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 36 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c=C2=A0 |=C2=A0 262 --
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 176 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 4 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 90 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 40 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/atombios_crtc.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 885 ----
> =C2=A0drivers/gpu/drm/amd/amdgpu/atombios_crtc.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 60 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/atombios_dp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 770 ----
> =C2=A0drivers/gpu/drm/amd/amdgpu/atombios_dp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 42 -
> =C2=A0.../gpu/drm/amd/amdgpu/atombios_encoders.c=C2=A0=C2=A0=C2=A0 | 2126=
 ----------
> =C2=A0.../gpu/drm/amd/amdgpu/atombios_encoders.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 78 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/atombios_i2c.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 176 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/atombios_i2c.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 33 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/cik.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 18 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v10_0.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 3595 ---------------
> --
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v10_0.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 33 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v6_0.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 3502 ---------------
> -
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v6_0.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 32 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v8_0.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 3536 ---------------
> -
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v8_0.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 35 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/si.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 9 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/vi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 15 +-
> =C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |=C2=A0=C2=A0=C2=A0 7=
 -
> =C2=A036 files changed, 83 insertions(+), 18857 deletions(-)
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.h
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_crtc.h
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_dp.c
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_dp.h
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_encoders.h
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_i2c.h
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v10_0.h
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v6_0.h
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v8_0.h
