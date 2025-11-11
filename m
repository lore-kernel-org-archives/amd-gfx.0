Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECA0CCFA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Nov 2025 13:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF5DE10E5BF;
	Tue, 11 Nov 2025 13:40:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h47g92jQ";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163CB10E5C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 13:40:22 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-42b3720e58eso2270037f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 05:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762868420; x=1763473220; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xJKVxLqx4Fo/Xa6d9JkAQUqq7owt+xEw7i1LX/ZS+ls=;
 b=h47g92jQpYdSnD/I2J60z684nDGtEfNj8r0VUW3oUtU88CL3JF1eteCGEgYogwvCGz
 Sv2bp1TGgBI6+vN4PxSY94TUJvXrXe+XGIS0WeUmoPX1fIsnAbwIZso/RbbfH+7kDxvM
 DJHw3TnCTw/9jJts/88Xlt7d37ydgbblKa1jqA53092dTnQvLQRsdtEHncbjarZ/l+jr
 I6zk5cwuoIuE4Q+ncLsS/nzG2wktyGVRBZsYd7O7KNrs0RIlnkvWUMQwCQXCwCH+odnX
 LU6J3CcCLMm9hNOh1ityjPfVj28XmM7uD/vlzvONtijWzVykCUWDkW27kgHIqJ52Roma
 F14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762868420; x=1763473220;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xJKVxLqx4Fo/Xa6d9JkAQUqq7owt+xEw7i1LX/ZS+ls=;
 b=CGz0CjgNHKIRGHfQf/uUeFcZz8PuvQo5OE6Gnbd+hOUhh/XV4DW1o6Y251b5nNgqqG
 Y/FFpJSxxuXib0amfFndl2b9m9qjogW3dmEVRG2245Uy96PitluP+rajRZ+d114QL+TO
 zWuIxyF6F67utmOlj+w4BnEwjqP18yyYuFgK9ew0HO1aP3nAct2ncGNBTbwizmslq8iJ
 +n7bNnNzsNqB5MQUAJx7mTl8Q8Xnywzp4pS++LXTtMLHzTb5YmxXEuPQ3UxlAUnehIUE
 ugEa+luThHGrUDIBqr0X7sa4UsPlUyk+tIRedh6gSwIkEyW+dPjcz7r1QoRebjzh5FWT
 E5CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHwAJkVJ9dFb/t9NEOztBkAWgCBPPc8d4lt0EILj0YeBRpmtbM6Rc3sLaR/Uc9G04gBNazBEzB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNM7oAgd4qvyYmxejQ2Lx2A+lwppkEYWcVfasO+b36ojGdxTpw
 6SWGWzk7c1d7KWEj1dWM3xK0GdtWMCRLTbJlDscxtb6/B1lotpTdReHK
X-Gm-Gg: ASbGnct47y7b0mgzb5yYzqCkocF9X+3/VJrI4e954gqb7LZ3rMFk2ljZY7KewtzmhgO
 oN6+M4x2wHK9i/uDLmdV9TSzImCogFE489CDQ7RmTVl0BUtXzuGJFdu1zsR55MQ09b7TBWrtFqB
 B4b4u+37B+RtJv5Tbe4U4Ksa1Tw3+0TXK9Hu95us/n5ISAP98JFjm5PZsM3YM77LQLF27O/edUy
 R0XvN/LPmi64q5h/aRtV5oVNKLCy7LYrk8lV/QezrDdgDuqpWo7RugDolH11R+HCopUovC4D/Eu
 AWQJZuQMJC6dN78F6zodFTy+JSHP8pK8Vx2LcQ1z6gtnPK+P3wqNOTuIH1LJodVtALQqppR21Gk
 WPGu4bWPTNoDrEbcIB3DPVz1mCVHSU6nnxh0lFAMWj59IZtsk3pD2YU8NPZW8z//btDSRIaMA4x
 KSMnxZDlOeeJiQ/J7OoDDhorYT2jWpd/C8R3syy8jKZtcZWyKo/jrO
X-Google-Smtp-Source: AGHT+IFRRQSc72YvPyAmP5efFNXaZfWdExmLegNw+Dz/1bNJtGhdq5pbXVtVeu+TLtqHZCfyh/OOag==
X-Received: by 2002:a05:6000:649:b0:3eb:c276:a347 with SMTP id
 ffacd0b85a97d-42b2db8fb35mr7997659f8f.0.1762868420370; 
 Tue, 11 Nov 2025 05:40:20 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24e1:af00:ca8b:1d2c:125:e560?
 ([2001:4c4e:24e1:af00:ca8b:1d2c:125:e560])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2e9644fbsm20323361f8f.25.2025.11.11.05.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 05:40:19 -0800 (PST)
Message-ID: <828a38f6700c6292ed43ae5f23d5e0dac72e88fc.camel@gmail.com>
Subject: Re: [PATCH v7 02/15] drm/amd/display: start using drm_edid helpers
 to parse EDID caps
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
Date: Tue, 11 Nov 2025 14:40:16 +0100
In-Reply-To: <20251106165536.161662-3-mwen@igalia.com>
References: <20251106165536.161662-1-mwen@igalia.com>
 <20251106165536.161662-3-mwen@igalia.com>
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
> Groundwork that allocates a temporary drm_edid from raw edid to take
> advantage of DRM common-code helpers instead of driver-specific code.
>=20
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
> =C2=A0.../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c=C2=A0=C2=A0=C2=A0=
 | 12 +++++++++-
> --
> =C2=A01 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git
> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index eb2c587b0b9b..70014bec7099 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -110,18 +110,21 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
> =C2=A0	struct drm_connector *connector =3D &aconnector->base;
> =C2=A0	struct drm_device *dev =3D connector->dev;
> =C2=A0	struct edid *edid_buf =3D edid ? (struct edid *) edid-
> >raw_edid : NULL;
> +	const struct drm_edid *drm_edid;
> =C2=A0	struct cea_sad *sads;
> =C2=A0	int sad_count =3D -1;
> =C2=A0	int sadb_count =3D -1;
> =C2=A0	int i =3D 0;
> =C2=A0	uint8_t *sadb =3D NULL;
> -
> =C2=A0	enum dc_edid_status result =3D EDID_OK;
> =C2=A0
> +
> =C2=A0	if (!edid_caps || !edid)
> =C2=A0		return EDID_BAD_INPUT;
> =C2=A0
> -	if (!drm_edid_is_valid(edid_buf))
> +	drm_edid =3D drm_edid_alloc(edid_buf, EDID_LENGTH * (edid_buf-
> >extensions + 1));
> +
> +	if (!drm_edid_valid(drm_edid))
> =C2=A0		result =3D EDID_BAD_CHECKSUM;
> =C2=A0
> =C2=A0	edid_caps->manufacturer_id =3D (uint16_t) edid_buf->mfg_id[0]
> |
> @@ -142,8 +145,10 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
> =C2=A0	apply_edid_quirks(dev, edid_buf, edid_caps);
> =C2=A0
> =C2=A0	sad_count =3D drm_edid_to_sad((struct edid *) edid->raw_edid,
> &sads);
> -	if (sad_count <=3D 0)
> +	if (sad_count <=3D 0) {
> +		drm_edid_free(drm_edid);
> =C2=A0		return result;
> +	}

For consistency with other parts of the codebase, I suggest adding a
label at the end of the function, above drm_edid_free. Then here you
could jump to that label.

> =C2=A0
> =C2=A0	edid_caps->audio_mode_count =3D min(sad_count,
> DC_MAX_AUDIO_DESC_COUNT);
> =C2=A0	for (i =3D 0; i < edid_caps->audio_mode_count; ++i) {
> @@ -169,6 +174,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
> =C2=A0
> =C2=A0	kfree(sads);
> =C2=A0	kfree(sadb);
> +	drm_edid_free(drm_edid);
> =C2=A0
> =C2=A0	return result;
> =C2=A0}
