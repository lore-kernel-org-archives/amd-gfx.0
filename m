Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA8260A261D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zv1m8T8s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212C0112327;
	Thu, 19 Nov 2026 11:47:27 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4932112314
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 11:47:20 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so1508864f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 03:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795088839; x=1795693639; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/iNYi2wcmMwyctTiBqD/BYhybXbpztBYbs/ijxRTwBo=;
 b=zv1m8T8ssxovpqN9v6+7njm+maY4BqkTyo4I7zvDdcEwR6TDHQzHxMPswT1yG4EZRb
 8PEdydqK8x6CxcOEXroi4pC9k8CfWtycnhHz9WW+qPqWctaiVc1X7XHnCBVFw+pqCB16
 nLDREcEOsIBczi4/wuFOVh+IqDpmX50jVRppBY+KgbVtXSkZvpnBk2BgPXaqbapa0gll
 B+1Thrv4yLSrI4LdkmW245pIh9pgbWZtDvMhUki9BfKvuIq0C7Y8hDu5FSW52di6kWnB
 +zw+E9jwL9edQsxArUtgAZAAwCWbhHsZcwIi7Kejn4HLm/5BtiXFsFP2Vs6jt82gweQ1
 udoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088839; x=1795693639;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/iNYi2wcmMwyctTiBqD/BYhybXbpztBYbs/ijxRTwBo=;
 b=2Xh399nf+NACdktu7PV4+lSaWG3UmK8XQYParHpLqWe6MNflKiu+cfYmm3iG2Gl2eH
 9OhtDoG0rvLHsxoMoMezSUwidTG4vlm+ZeU+rwh478YvjJwg64Q15vYOHC+NavzKp20g
 hnrCJhs9vyUd+n648TfKje+LsCPFO+UkuWKpuGhECEIhsH1/AK56TqDIeREK1ZUPEftE
 1q8kj/gJDLK4QOOicmUYgpsadSwk9enCkojtciyYSh41X8dP0OMloiN2RbnAH+htv3vr
 1yraDqoHNoTR61Dd8DyeBSw8gtCdwvIf/X7vtHos4N9ttEywO0aUKzB5Wa6PE4nTstHK
 8kMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErENlxMlg7oSB9SQUXhA3ZMVIGVQbjL9jHZG1CG9G8dlFzWpvwLa2ch1ykP4TCR3/oRaGiQFL7nG@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+cN0QDqAGIBnE0cFVui/ifOQKfenSDar1kiX09o2o9Hdoi5pEe
 WiNCwFWOXt8BtCTDlZd4ECYitfuxnELnL7YTCuOMcM3jkJsSI8EDIH9c
X-Gm-Gg: AZFdTZe2icR9o2ITKPivBk6ZFO/+FTPHT6j8etpVVE10UeNWjWUs04irANRJGPI5H60
 zUdI1puFkb46DHQkH2FyUNBFheEHuNzytPZSH7HwBNjpmVbf/ZI+z83SyngMnxBrhEIYQFjIBy/
 OyNTdUmYNeRoKvI5h979wUYjv4EOwwIr54+Wao3VPSN49rkLDl7VvfIfwvJI+7prQGl71p8T0sh
 Oy9pfjTwvebOjnB6+/3cOxNZkJbxbQhs5onCmQoEAFGmaacfS9+61h9+q5vTIw9EukxvRQh2LAP
 nDGfZZsgfv+KRTuakr0qktEd5yaF6LvV95zkyNvE7omuk+FfuOVUiAViikqj3FTNOFMiifq+3Qt
 Y7mlQWqmhwS5q5l2nxZYoPdmgfmrSyGrm+gazIff9oHAax/N2GiKHkADuQk1DOScwm3yzca/JRj
 9MpEh51etBSZ71IJxqfb8yz/dgrBiFoxw9DFw34tP5fJi7tOFipFeQOCiTgNbA5o7co2wF0BaHW
 sWUpdD+VT5NBnDPD3A2+b8Yr3zU4MQYVbD7Fvnnwli0dygRWTH1AIV8jmXmNj7B9lhTZifpArWs
 RClU/9iSM0TZXb/W58+XhH14ooM0jR3AHVjxxN89vDUKohxALgMrzlGrH7hPdSeCmYq5FDSp0P9
 m1ff6FpafletsAcALgOqMViWMrPE=
X-Received: by 2002:a05:6000:310a:b0:4a8:714:7ae2 with SMTP id
 ffacd0b85a97d-4a807330779mr8654569f8f.29.1795088838950; 
 Thu, 19 Nov 2026 03:47:18 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6573baa9fsm10912020f8f.57.2026.11.19.03.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:47:18 -0800 (PST)
Message-ID: <54b73d2a2b8ac13919bd904c8a38d07c417d3d34.camel@gmail.com>
Subject: Re: [PATCH v4 11/13] drm/amdgpu/userq: reset the gfx engine when a
 gfx user queue reset fails
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Thu, 19 Nov 2026 12:47:17 +0100
In-Reply-To: <20261105030612.726542-11-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-11-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
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

On Thu, 2026-11-05 at 11:05 +0800, Jesse Zhang wrote:
> When neither the queue nor the pipe reset recovered a gfx user queue,
> fall back to a soft reset of the gfx engine before a full reset, when
> the GFX IP supports it. A hung kernel gfx queue gets there through
> the
> IP block soft reset of the job timeout handler; a user queue has no
> kernel ring, so call amdgpu_device_ip_soft_reset() directly, with the
> gfx ring type and no guilty ring.
>=20
> The hung queue can't be unmapped before the reset: pass it to the
> engine
> reset, which unmaps it once the reset cleared its HQD, and hangs it,
> while the other gfx user queues keep their state.
>=20
> v4: Call amdgpu_device_ip_soft_reset(), which now takes the ring type
> =C2=A0=C2=A0=C2=A0 (Timur).
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 27 +++++++++++++++++++=
-
> --
> =C2=A01 file changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 7abb9d95ef59..4f2dea21ad54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -235,11 +235,25 @@ int mes_userq_reset_hw(struct
> amdgpu_usermode_queue *queue,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/* The hung queue can't be unmapped now: the engine reset unmaps it
> after. */
> +static int mes_userq_reset_gfx_engine(struct amdgpu_usermode_queue
> *queue)
> +{
> +	return amdgpu_device_ip_soft_reset(queue->userq_mgr->adev,
> +					=C2=A0=C2=A0 AMDGPU_RING_TYPE_GFX,
> NULL, NULL, queue);
> +}
> +
> +static bool mes_userq_gfx_engine_reset_supported(struct
> amdgpu_device *adev)
> +{
> +	return adev->gfx.gfx_supported_reset &
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RE=
SET;
> +}
> +
> =C2=A0int mes_userq_reset(struct amdgpu_usermode_queue *queue)
> =C2=A0{
> =C2=A0	struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
> =C2=A0	struct amdgpu_device *adev =3D uq_mgr->adev;
> =C2=A0	struct mes_reset_queue_input queue_input;
> +	int r;
> =C2=A0
> =C2=A0	/* already reset by an earlier job's hang-detect; just
> signal and bail */
> =C2=A0	if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG)
> @@ -248,8 +262,10 @@ int mes_userq_reset(struct amdgpu_usermode_queue
> *queue)
> =C2=A0	/* A GFX pipe reset also affects the kernel rings on that
> pipe. */
> =C2=A0	if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 adev->gfx.funcs->detect_hung_queue &&
> -	=C2=A0=C2=A0=C2=A0 amdgpu_gfx_me_pipe_reset_supported(adev))
> -		return amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL,
> queue, 0, true);
> +	=C2=A0=C2=A0=C2=A0 amdgpu_gfx_me_pipe_reset_supported(adev)) {
> +		r =3D amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL,
> queue, 0, true);
> +		goto out;
> +	}
> =C2=A0
> =C2=A0	memset(&queue_input, 0x0, sizeof(struct
> mes_reset_queue_input));
> =C2=A0	queue_input.doorbell_offset =3D queue->doorbell_index;
> @@ -277,7 +293,12 @@ int mes_userq_reset(struct amdgpu_usermode_queue
> *queue)
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	return mes_userq_reset_hw(queue, &queue_input);
> +	r =3D mes_userq_reset_hw(queue, &queue_input);
> +out:
> +	if (r && queue->queue_type =3D=3D AMDGPU_HW_IP_GFX &&
> +	=C2=A0=C2=A0=C2=A0 mes_userq_gfx_engine_reset_supported(adev))
> +		r =3D mes_userq_reset_gfx_engine(queue);
> +	return r;
> =C2=A0}
> =C2=A0
> =C2=A0int mes_userq_reset_queue(struct amdgpu_device *adev,
