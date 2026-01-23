Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1A9D72371
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 11:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6D5910E2A0;
	Fri, 23 Jan 2026 11:20:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mWrWApMp";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D3010E2A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 11:20:37 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so24241805e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 03:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769167236; x=1769772036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+I0tLnCW0GptpxTH+Hd4lO3qhepn+XYRWxHDF8cKq3Y=;
 b=mWrWApMp7RYmxEyHLuOwq1BdpvKOpa3DoCwX6ywU3DlK6UKwFTwfxC5NFCE5mUtPn3
 Kdfwl3SjMNwXrMfOfDC79xE+nAskmbXMmtAptcXz/UTyN3wq1p9gR1ia0ef8fPvJ9gVg
 lh4v95B89YbJlhgXNrvUTyc2ut3OW+JMlWH1e5N96g5kgwdxummCVBQv0ajgxpkb9ScI
 ibegtpXTwdBkK+iKtCnWY9RkzRtUxI6++b9GcHsuc9X10Ln/qqwOmAb3hM/KPmIWXGqJ
 kgsxmgSV/ymlgQ+EHuRwwWtv3YLFDL9PhcVbDTp84MPmrhkVilz5Nj/cbBPcEy6TptTS
 5vgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769167236; x=1769772036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+I0tLnCW0GptpxTH+Hd4lO3qhepn+XYRWxHDF8cKq3Y=;
 b=F8BfYE6whoWjcnYx8oCARPguEY979bM4pwprggwpLdM5hahDJ1gZQ/jG1zb6qO12+v
 tVdPK7a54xKj0B9c6GQbuxLxAzKqoAuMbqt5xmhgX7MN4BJK6mFbKpTHHAq89xSAacN9
 CdyxbtFIU8nm0VUHnNJPMLpeVq8NniIlXzmzn9t5KYh2k4P57Z62VNPrvavbMRv4pPt2
 wD1rcsCMdzEdk/I8rNPwkHTHUAbBbTVFIbhtJJSotTMxAWLLsrNZPKAGPmJW1JzTtMW+
 Vxrbo5FDQPE2a9uF7Es9tgtFx4gdO+0nkAhOclvhB7JG9Kq6PNYpx9b0UL883W3CHNeY
 wM6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzxrVGoQNz2OWzergZ9DZJBe0A5Iyho5H4NAF2LzrOwYA6ZMuUVoeCJzhBFLQyINQPjREKXEce@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRYLtrOU256yw59hWubOflh/IJWZXT74nIwNmidpeagO5E/9O1
 DPgcrV40NbLjVIl3uDMGzImpWLeDFfE45H9OTT7m4aQDP4tcK3hSHNN9
X-Gm-Gg: AZuq6aJIHhviC2Ee273PQ+qazlqVo9WvZzJCfIjhx1Cr49UqWWDjyP7uZE3rx1FKwBe
 dyfEBg9e2+G/wQ/cgG5am1hIaaMaqIS1tgNbdyJgXDSN8NvOJfZaL8qr6t2562U8vfdg0wUdCzo
 tIzws8qjwdcAFY0MNQhFwvY9U60G6KpFpxsf4IkTtHSOl7L+oy+UWCg83VdeBzrNU0PY41SdMqa
 D3A62Au2XlhovrxG1/mKNwwmUNV46+lCA2bfnMi6R8LKNNKqmqPdOratQDDE3kjRg6Vnx608qr1
 b8rJQF8eOaoC0SLTkeiI7Qql+kFHcnoxJtk3BBgoS8IwRUDCaVyzsyanZHujtsoeMXWrGdgUa4I
 Oqevuic0LSS3G+LmvE2UGQF4Qwu9KV4YabE7o0yoU2+oY4QEx92cHOeK7/eYX52nAuYPdyEXxqT
 w5DG0pTiADqt99wOBqS2qtr4+8UJJoZMBfiRsMS5x6FsN53aLjqwSlIpf1qg==
X-Received: by 2002:a05:600c:40c8:b0:47a:80f8:82ab with SMTP id
 5b1f17b1804b1-4805067fadcmr16578755e9.24.1769167235975; 
 Fri, 23 Jan 2026 03:20:35 -0800 (PST)
Received: from timur-hyperion.localnet (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48047028928sm191404245e9.2.2026.01.23.03.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 03:20:32 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: dri-devel@lists.freedesktop.org,
 Hamza Mahfooz <someguy@effective-light.com>
Cc: Hamza Mahfooz <someguy@effective-light.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Ce Sun <cesun102@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Melissa Wen <mwen@igalia.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <mdaenzer@redhat.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/amdgpu: implement page_flip_timeout() support
Date: Fri, 23 Jan 2026 12:20:30 +0100
Message-ID: <10030872.eNJFYEL58v@timur-hyperion>
In-Reply-To: <20260123000537.2450496-2-someguy@effective-light.com>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <20260123000537.2450496-2-someguy@effective-light.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Friday, January 23, 2026 1:05:28=E2=80=AFAM Central European Standard Ti=
me Hamza=20
Mahfooz wrote:
> We now have a means to respond to page flip timeouts. So, hook up
> support for the new page_flip_timeout() callback.
>=20
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
> Hi,
>=20
> I have tested this on 7940HS system and it appears even a MODE2 reset
> will reset display firmware, so I don't think we need to force a full
> reset here.
> ---

MODE2 reset _is_ a full reset on APUs, it resets everything but just doesn'=
t=20
lose the RAM contents. Also note that MODE2 reset is not supported on=20
dedicated GPUs, so this will likely trigger a full reset for those.

Can you say how you tested this? I'd be happy to test it myself too.

>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c      |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h      |  1 +
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c index
> 28c4ad62f50e..bd63f0345984 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -343,6 +343,8 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context
> *rst_ctxt, char *buf, case AMDGPU_RESET_SRC_USERQ:
>  		strscpy(buf, "user queue trigger", len);
>  		break;
> +	case AMDGPU_RESET_SRC_DISPLAY:
> +		strscpy(buf, "display hang", len);
>  	default:
>  		strscpy(buf, "unknown", len);
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h index
> 07b4d37f1db6..53b577062b11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -44,6 +44,7 @@ enum AMDGPU_RESET_SRCS {
>  	AMDGPU_RESET_SRC_HWS,
>  	AMDGPU_RESET_SRC_USER,
>  	AMDGPU_RESET_SRC_USERQ,
> +	AMDGPU_RESET_SRC_DISPLAY,
>  };
>=20
>  struct amdgpu_reset_context {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c index
> 697e232acebf..2233e5b3b6a2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -28,6 +28,7 @@
>=20
>  #include "dc.h"
>  #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>  #include "amdgpu_dm_psr.h"
>  #include "amdgpu_dm_replay.h"
>  #include "amdgpu_dm_crtc.h"
> @@ -578,12 +579,29 @@ amdgpu_dm_atomic_crtc_get_property(struct drm_crtc
> *crtc, }
>  #endif
>=20
> +static void amdgpu_dm_crtc_handle_timeout(struct drm_crtc *crtc)
> +{
> +	struct amdgpu_device *adev =3D drm_to_adev(crtc->dev);
> +	struct amdgpu_reset_context reset_context =3D {0};
> +
> +	if (amdgpu_device_should_recover_gpu(adev)) {
> +		memset(&reset_context, 0, sizeof(reset_context));
> +
> +		reset_context.method =3D AMD_RESET_METHOD_NONE;
> +		reset_context.reset_req_dev =3D adev;
> +		reset_context.src =3D AMDGPU_RESET_SRC_DISPLAY;
> +
> +		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +	}
> +}
> +
>  /* Implemented only the options currently available for the driver */
>  static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs =3D {
>  	.reset =3D amdgpu_dm_crtc_reset_state,
>  	.destroy =3D amdgpu_dm_crtc_destroy,
>  	.set_config =3D drm_atomic_helper_set_config,
>  	.page_flip =3D drm_atomic_helper_page_flip,
> +	.page_flip_timeout =3D amdgpu_dm_crtc_handle_timeout,
>  	.atomic_duplicate_state =3D amdgpu_dm_crtc_duplicate_state,
>  	.atomic_destroy_state =3D amdgpu_dm_crtc_destroy_state,
>  	.set_crc_source =3D amdgpu_dm_crtc_set_crc_source,




