Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D329CD98CE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 13:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 830C410EA18;
	Fri, 12 Jun 2026 13:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SQS1KGrW";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA36F10EA18
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 13:37:36 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so1011896f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781271455; x=1781876255; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vE8aWVHh1qr+zpGueDWqMsWW3pHMlD0JWqKerG4rz6o=;
 b=SQS1KGrWwcBXiuenqVeLOATr1okxMNPyT7ZFqC2LJM/yK+PQbioppaZaw0g8sNcCpW
 ERoo9ZPocdC00NaYZ+tLTfTKfnBxuvx+9G12DTd7vfOfmrumY0F3SEKKaNywjPG82/8L
 emO7ITlw7ADxYAvwDYrvnY3VgyMn9RtQLqM23PIM919udNdbLFsVztL76eZOZg366KAD
 TiBqDx+UJlE2JvWnYwzUXk2S0/oTsG0YOyASW9uzQjJC0G6SFGw4yKB/jeyscG5aY5j6
 5D/uHzA9P9Wpxw5ai/jWB3w4OU1FWB2xvBO8PmST6qOvAHv8GubF+jh2XBxMxg8FQLqI
 z+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781271455; x=1781876255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vE8aWVHh1qr+zpGueDWqMsWW3pHMlD0JWqKerG4rz6o=;
 b=eaRwQtQXHFhO4NFcd1gz0gFxyry4C5qxzdxpI4UhMaLmcqooMBr8DjrDtNsZuGLBNb
 as2cfDpKbEFv4KUx/orrglYsTBek6vi8skLoTMaef8nxkdwJdDC8MZu5AWtolEFe/y/V
 Iv75TmU0zTvBEd72GWM/MMldCo2gZTllQEQr54NXmMOyOrN9uUiBQxZmsbP0tsSyheaY
 q7g8OPoUembd7YS5xXHkdKRbFAlKEP3OSSk3WxHcMbt4wH+r0nxfAqU8KP0DXT0Su6Xp
 hECwD2xBnl43BRMJnF65POYHbDtnYDtkLyTc3BAxY6PNRJZSXEsxqiXt0sIq6x2RMLJP
 0rwA==
X-Gm-Message-State: AOJu0YzRFRrfdB5Mh/vI2B8xXdhQOeSbtIpelxosyQrvJ+1nK65Ki6YZ
 f6FI/dFgKy6FgUpMTKDjelQ+8VScYUEGEOCLr0A2+cQ4PTnd4T+59nfE
X-Gm-Gg: Acq92OEobvfsd+E+gCX4EIoXZhb1JT6krVO1Am8lRQs8azdyhedjW2lAHw22mR4KoW7
 CCPAxgq/wSLMKanx20gpdpXuPFcM5QJEvspH/CjnlzisjgF05o2/9U7ZWRheD7wbiJaHX1rra2Y
 ykhlvDvP3em5LRSceqnKjv2ukpfzfh0Ufo6dwLdn3FYorkbN1/PmsoCcKWsFo04A+77422ztrJk
 IY0E9FQYXa+8Mg2EMZn9xAjfAT/V5lnRneme9f2O4W+gsYSQPDOEAvW2CXigwIBAsXyS53H3R9q
 eVaM3OifyHnnfOUhxufOc7lpDgRS97JVTAtNanxLX71nY71vKg/fz33zlCcUelosdBiDuDsficj
 GIQ29GW6Cpvhd7JXAal/fJ4t4x7g1KDazTLwGWOFvtYf5vL6epe8jrUlIfCvH8m2dR8sz+NjE/Z
 DAGEyg6ameLcsy1y5GZnSv5RXkmFes08xxS6zw0VNQRHfZFKPTyAkkxQ25DYlo4hStX/yTJA==
X-Received: by 2002:a05:600c:468d:b0:490:9588:bdae with SMTP id
 5b1f17b1804b1-490ec4ee664mr43806615e9.18.1781271454951; 
 Fri, 12 Jun 2026 06:37:34 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2ca1a43sm159472805e9.8.2026.06.12.06.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 06:37:34 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Jiqian Chen <Jiqian.Chen@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Huang Rui <ray.huang@amd.com>,
 Huang Trigger <Trigger.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: Re: [PATCH v3 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
Date: Fri, 12 Jun 2026 15:37:33 +0200
Message-ID: <4951358.vXUDI8C0e8@timur-hyperion>
In-Reply-To: <20260612092654.1632603-1-Jiqian.Chen@amd.com>
References: <20260612092654.1632603-1-Jiqian.Chen@amd.com>
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

On Friday, June 12, 2026 11:26:54=E2=80=AFAM Central European Summer Time J=
iqian Chen=20
wrote:
> For Renior APU with gfx9, in some test scenarios with disabling
> ring_reset, like accessing an unmapped invalid address, it can
> trigger a gpu job timeout event, then driver uses Mode2 reset
> to reset GPU, but after Mode2 compute Ring test and IB test fail
> randomly. It because the HQDs of MECs are always active before or
> after Mode2, that causes MECs use stale HQDs when MECs are unhalted
> before driver restore MQDs, and causes CPC and CPF are still stuck
> after Mode2, then causes compute Ring and IB tests fail.
>=20
> So, add sequences to deactivate HQDs of MECs in suspend IP function
> of the resetting process.
>=20
> v2: Move all sequences into a new function gfx_v9_0_cp_mode2_clear_state
> (Ray Huang) To check reset Mode2 method in the if condition (Ray Huang)
> v3: Move all sequences before Mode2 instead of after Mode2 (Timur Krist=
=C3=B3f)
>=20
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

Looks good, thank you!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
> v2->v3 changes:
> * Move all sequencess before Mode2 instead of after Mode2, and add a new
>   function gfx_v9_0_deactivate_kcq_hqd to do the disable compute HQDs
>   sequences.
>   Then the resetting CPC and CPF are not needed since we have already
>   move all sequences before Mode2 and they are not stuck
>=20
> v1->v2 changes:
> * Move my sequences into a new function gfx_v9_0_cp_mode2_clear_state
> * Add reset Mode2 method check to the if condition that call my sequences
>=20
> v1:
> Hi all,
>=20
> My board is Renior APU with gfx9, smu12. I run a testcase that
> accesses an invalid address to trigger a amdgpu_job_timedout()
> with disabling ring_reset, so that driver will call mode2 reset
> directly. After mode2 reset I found compute Ring tests and compute
> IB tests fail randomly on random compute ring.
>=20
> We checked the scan dump of GPU, we can see the CPC and CPF are
> still stuck, that caused Compute Ring tests fail.
>=20
> I added printings in driver codes (gfx_v9_0_cp_resume), and found
> the HQDs of MECs are still active, that may cause MECs use stale
> HQDs when MECs are unhalted before mapping compute queues (restoring
> MQDs to HQDs).
>=20
> So, I send this patch to fix above problems.
> There are two main changes of my patch:
> One is to reset CPC and CPF before resuming KCQ.
> Another is to disable HQDs beofre unhalting MECs.
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 37 +++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c index 90bbddb45730..0c01701488e7
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4071,6 +4071,39 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block
> *ip_block) return r;
>  }
>=20
> +static void gfx_v9_0_deactivate_kcq_hqd(struct amdgpu_device *adev)
> +{
> +	for (int i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> +		u32 tmp;
> +		struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[i];
> +
> +		mutex_lock(&adev->srbm_mutex);
> +		soc15_grbm_select(adev, ring->me, ring->pipe, ring-
>queue, 0, 0);
> +		tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
> +		/* disable the queue if it's active */
> +		if (tmp & CP_HQD_ACTIVE__ACTIVE_MASK) {
> +			int j;
> +
> +			WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST,=20
1);
> +			for (j =3D 0; j < adev->usec_timeout; j++) {
> +				tmp =3D RREG32_SOC15(GC, 0,=20
mmCP_HQD_ACTIVE);
> +				if (!(tmp &=20
CP_HQD_ACTIVE__ACTIVE_MASK))
> +					break;
> +				udelay(1);
> +			}
> +			if (j =3D=3D AMDGPU_MAX_USEC_TIMEOUT) {
> +				DRM_DEBUG("comp_%u_%u_%u dequeue=20
request failed.\n",
> +						=09
ring->me, ring->pipe, ring->queue);
> +				/* Manual disable if dequeue=20
request times out */
> +				WREG32_SOC15(GC, 0,=20
mmCP_HQD_ACTIVE, 0);
> +			}
> +			WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST,=20
0);
> +		}
> +		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
> +		mutex_unlock(&adev->srbm_mutex);
> +	}
> +}
> +
>  static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev =3D ip_block->adev;
> @@ -4095,6 +4128,10 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block
> *ip_block) return 0;
>  	}
>=20
> +	if ((adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev) &&
> +		amdgpu_asic_reset_method(adev) =3D=3D=20
AMD_RESET_METHOD_MODE2)
> +		gfx_v9_0_deactivate_kcq_hqd(adev);
> +
>  	/* Use deinitialize sequence from CAIL when unbinding device from=20
driver,
>  	 * otherwise KIQ is hanging when binding back
>  	 */




