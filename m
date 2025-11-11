Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E9DCCFA18
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Nov 2025 13:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4C110E5D0;
	Tue, 11 Nov 2025 13:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LXsoOk01";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561C110E155
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 13:47:02 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1321so1242091f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 05:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762868821; x=1763473621; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lqp3H7Hh0ahbpm5asw7hSYjR5fyabNxukpQSjLLjqfI=;
 b=LXsoOk01bcgJNcB6RG1z+spbwtjS3C/q8qdi5jQrEu0ZAyVxgIrd8v92kf6a+D0lQu
 ZR84zMW8XzVoTfUWWQWOIypVT4xMaY29qIYstaKwipFnHwb4fhPrrIrucXKQs5egz94R
 KVrEjMJHVNmMCb3mYPOxNDNT0lDDuIFrzDJGv9Z6TE5tr1htBElzlidBCBw6k5tqu3r4
 wiKIqYlHa3bQpNks0Gvl56SXCsFpTHq7WLT/LA2VySJw55aZUGhwWAQkkUtJfZIa4wlQ
 vBjwWWM6PpEj7bN6Hz6xYcGteDch5QkUk2lpzhxJ07MeTTaF6ZLfC3tsr8Wm+u2sV99Q
 UjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762868821; x=1763473621;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lqp3H7Hh0ahbpm5asw7hSYjR5fyabNxukpQSjLLjqfI=;
 b=QXqRqCclc56y1pwbdubLTbAqZNjeTjlLIZBg2XN3UeIBADbbXPKCElNZhoh6hqQniy
 uW82w1rU/pTvNAyQ0yxI8OjjbL08IhOLY8ACcpA30/d+WHXpUL6blsZf3CGR/8Rf2sIx
 z108DgdByrSvCJoaVzGxrbp7mOM2ZIUTeoguRV7xrjiG2fri+tfQltj6n7JLEBMjmK3k
 LeakeZoBoFSSMy+DQQivztrN2LZmPyVI008nGdzM2gQCiRCBK71os+brP6s60Q37dJmv
 kkxLYp/iDDc0LJgzh97nVYpyd1JjQPEtKRVmYfIxXLQLw1EEgp3TxV5TVSfGlil356fs
 sSFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtX8OeCUr41Z8z+kMpt178bJY1sB69AdZs+wfbhn9gIcuu+y2NPhEpH7NAiDLUvOGQkwGtnr0N@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxANrWyo94EXyKft3UceLeR2SXPJsFaZsP4ucB3py+7TxwIqWbe
 hiucZBy81p+BITr3pGv3qUy6EzRxUpXCV9rdjUStW5WuNEGLsFOBWaP3
X-Gm-Gg: ASbGncvaocjjNJa613rItGphUXaEn34EocGTr5b5Gg/cqcB6MukQDaDaXG4bAmuCSOC
 N9Y8HrFQVc/0kth7SfH7USYcED3JygMYDHEPl/pwBIVRIOEZ+jSaHjmSxVjtbmVSB+x6vaQBrsd
 jC5v7AJThKDDNVo9JAhD90Ox06fT3nWH7BEQTuTsH1BXhHOam4w6QztGWpFN7hIcCy1eCqjJ6fV
 Os/rAW6WNPDTaFvO0Blgy1LNOxPZzTWBUIBtN+HZq7rXkFxFIwCX99cIzjsFoyI3oRvc4FyFcr8
 vU2FZsIsLq86NUmlqSi1LIfCf4ogin5f0QD0BatE91TaQKuYifmZRKozMWB2pLAeWUtpYxtUsVX
 zedj7WeqsXkZQ4gNjyDpSVPhr0Lg4OAu4mXl0LaSsXqJLkfM+VcOQcc7w6TVCgORZcHFlIuYWxL
 HV3AjSG7ilXDyKN9+d3uUerrJThpPOObGTTlyTApLe7BZZmBbnEX1T
X-Google-Smtp-Source: AGHT+IHagdKxC9CDq9Z5KrnivvzwMC1LqsmSwImIzBnIdoRYO8w7pjRNA08g73rvSt+TxQnf33h8Gw==
X-Received: by 2002:a05:6000:2107:b0:425:742e:7823 with SMTP id
 ffacd0b85a97d-42b2dc12cfamr8200062f8f.12.1762868820773; 
 Tue, 11 Nov 2025 05:47:00 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24e1:af00:ca8b:1d2c:125:e560?
 ([2001:4c4e:24e1:af00:ca8b:1d2c:125:e560])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2f7a0512sm21076633f8f.18.2025.11.11.05.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 05:47:00 -0800 (PST)
Message-ID: <614c1ff4a998c140b2ed812b9a707839339cb94a.camel@gmail.com>
Subject: Re: [PATCH v7 06/15] drm/amd/display: get panel id with drm_edid
 helper
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
Date: Tue, 11 Nov 2025 14:46:57 +0100
In-Reply-To: <20251106165536.161662-7-mwen@igalia.com>
References: <20251106165536.161662-1-mwen@igalia.com>
 <20251106165536.161662-7-mwen@igalia.com>
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
> Instead of using driver-specific code, use DRM helpers.
>=20
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
> =C2=A0.../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 15 +++++-------=
-
> --
> =C2=A01 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git
> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 632cf2a32a4e..c055841c3a8f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -49,16 +49,11 @@
> =C2=A0#include "ddc_service_types.h"
> =C2=A0#include "clk_mgr.h"
> =C2=A0
> -static u32 edid_extract_panel_id(struct edid *edid)
> +static void apply_edid_quirks(struct drm_device *dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_edid *drm_edid,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dc_edid_caps *edid_caps)
> =C2=A0{
> -	return (u32)edid->mfg_id[0] << 24=C2=A0=C2=A0 |
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (u32)edid->mfg_id[1] << 16=C2=A0=
=C2=A0 |
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (u32)EDID_PRODUCT_ID(edid);
> -}
> -
> -static void apply_edid_quirks(struct drm_device *dev, struct edid
> *edid, struct dc_edid_caps *edid_caps)
> -{
> -	uint32_t panel_id =3D edid_extract_panel_id(edid);
> +	uint32_t panel_id =3D drm_edid_get_panel_id(drm_edid);
> =C2=A0
> =C2=A0	switch (panel_id) {
> =C2=A0	/* Workaround for monitors that need a delay after detecting
> the link */
> @@ -143,7 +138,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
> =C2=A0
> =C2=A0	edid_caps->edid_hdmi =3D connector->display_info.is_hdmi;
> =C2=A0
> -	apply_edid_quirks(dev, edid_buf, edid_caps);
> +	apply_edid_quirks(dev, drm_edid, edid_caps);
> =C2=A0
> =C2=A0	sad_count =3D drm_edid_to_sad((struct edid *) edid->raw_edid,
> &sads);
> =C2=A0	if (sad_count <=3D 0) {
