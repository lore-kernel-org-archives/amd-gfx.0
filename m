Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FDBCCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 16:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61C710E07A;
	Wed, 29 Oct 2025 16:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kmBiRyTd";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 186AD10E07A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 16:54:12 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-63bdfd73e6eso2317779a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761756850; x=1762361650; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0rQoDMscrch0Xz9H6XdTuDZFaQwdAn+uRsaziDW16I=;
 b=kmBiRyTdsd3ipqI6IP5xwO/Ojs6n7R7GxYsZzOfDSE4i4EpeMcglaMdRW5RTl8wlW+
 gZqb/rx1hds6gJWiB5vjzR4j7Deb/zLVfzE/p44kkCX+fjowbj8VlfviQB5XiqxTNSPJ
 xkGN2M49VFEywvgqNG2fe5I7lHmR8e0oxS1gdhQW1hyJyAsJGMO1X9Y5U/Pmzv2YbbaO
 VfpIP73yeuyYLEZ4svW/COCfzOqv2XKDJhWKklO44sHNYq8qPg9NxTzJ5qVP34eVBVeo
 nDUbD5o0JyR8vbgdy9ACsnucIgmoZnGxAvJv9mSDapoWiM0TN9U6pS4Q3q+EbleHIX7y
 pnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761756850; x=1762361650;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X0rQoDMscrch0Xz9H6XdTuDZFaQwdAn+uRsaziDW16I=;
 b=LXIEUO4SggtG2oYMOprR4OQjrHx0/ckxnmSCesqSyl2Trlt9mM2ElLchoJbznTeJNt
 DcTTasSW/hWjoTDkyBv+//P9n/BnIgNvME8zrKEMhhXttXpbF8x1GzTLwCG41/fKY6dZ
 7lP1CNA2LTmWN4B28FTqiLC5FDcFXbb0KPk4zy9A4LgfeXoMc9Z2rbeG3mPivhXrshsQ
 GIdjTfs7aAXFjHc6mwOMq+ParYKIe1CuOtBGWxeMQ8E7xLxVBgfQlavZLDaDdznf3ZSy
 KfM5ghbIfUdpdPsHC3sQYXDy9dLaUtiYl2+YVy9u6Gs4Mayn0IeQCAyf3tGw224Dbv3I
 ZnxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNYGXj7p9uxpA6qTWFaoFmZkFiIzVFgmCwZy12J9mBwvGXF0wQ54wToqSpidV/BiHMA8z/TuXI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlEbU1TwI1AK9iBdiJzn1fP0SsebQLAZtorROm3Cb/TVJCapc7
 iODTwEu1RmGY5uigxvFQ2b0xl09nI3Z2sx3KEEtqcYE4AL5UUIHEldvMKzU0kXCP
X-Gm-Gg: ASbGncvNPW9GyGgyHGwmJzlZACAafWZrN4auBsmwez3vR1Qlc3H394rCIAhvILMULrd
 hEMNE1VbwK4WzREuB9VVycoADYAV26eWT9dJ1PN9M1mSu+WxmfYxSN4BVBcQBavfv0uqSkZT854
 9tXfIzCoUpXc41I0eNNQIJ2i1JotWD5A7HodxAjhQ7fXaND9MVzLxujnh7gL+b0y5/nuZdRW/aK
 lXYEldwavp//AxqiLqwiYEROmKPH4ckTs3CsmZNpQHcogHkTzt4oc8Ebpb4h6U1bWBpccmsCG7U
 aNmaEDRxbjLoANIcK/XHEorinXKNeuAtFWl9jLw6Cpa+FZNCzsLGLEWo5I3GCLgbWoSzR2LG2/w
 t3iQTUNmY1gUaQHjRVVyVwhS1vK2EC6KsBen4tTtq6qTuehhHHYxQzG0EiDSnENhUAjTOOsmN2f
 4aD8Py54gwoTXTjbFtUyqjQwgHAMcoGi1eg6uWiKiE86nk1sngBwB60bMti7AXgNZbQg==
X-Google-Smtp-Source: AGHT+IGdwYL1/MSg8YYDi99K1r7oo6GXeqFZEIxVZc4mEZmazEVVZV8ISQX+GQs8OIArXIbbZ1F7Dw==
X-Received: by 2002:a05:6402:3514:b0:639:e5da:637e with SMTP id
 4fb4d7f45d1cf-6405ecc0244mr258690a12.6.1761756850226; 
 Wed, 29 Oct 2025 09:54:10 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24cb:f700:23e8:3719:bda9:8268?
 ([2001:4c4e:24cb:f700:23e8:3719:bda9:8268])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7efb97cbsm12622883a12.26.2025.10.29.09.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 09:54:09 -0700 (PDT)
Message-ID: <4b4aabe98541494474296d6f2062482dcfd9c193.camel@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix null pointer on analog detection
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Date: Wed, 29 Oct 2025 17:54:07 +0100
In-Reply-To: <20251029161607.401452-1-harry.wentland@amd.com>
References: <20251029161607.401452-1-harry.wentland@amd.com>
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

On Wed, 2025-10-29 at 12:16 -0400, Harry Wentland wrote:
> Check if we have an amdgpu_dm_connector->dc_sink first before
> adding common modes for analog outputs. If we don't have a
> sink yet we can safely skip this.

Hi Harry, nice catch!

Out of curiosity, how is it possible to reach this code when the
dc_sink is NULL?

The patch is:
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

>=20
> Fixes: 0c9f9ca99238 ("drm/amd/display: Add common modes to analog
> displays without EDID")
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c621e50f636a..bc5a8b8442a2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8669,7 +8669,7 @@ static int amdgpu_dm_connector_get_modes(struct
> drm_connector *connector)
> =C2=A0			amdgpu_dm_connector->num_modes +=3D
> =C2=A0				drm_add_modes_noedid(connector,
> 1920, 1080);
> =C2=A0
> -		if (amdgpu_dm_connector->dc_sink->edid_caps.analog)
> {
> +		if (amdgpu_dm_connector->dc_sink &&
> amdgpu_dm_connector->dc_sink->edid_caps.analog) {
> =C2=A0			/* Analog monitor connected by DAC load
> detection.
> =C2=A0			 * Add common modes. It will be up to the
> user to select one that works.
> =C2=A0			 */
