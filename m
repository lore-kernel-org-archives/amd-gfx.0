Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A1EC3F2D4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD67F246B9
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIOaITtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD67F246B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8965C6E20D;
	Mon,  2 Mar 2020 09:34:48 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C646E20D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 09:34:47 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id e10so10160182wrr.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2020 01:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=aNp9uiLbQb6uw4tNAZpGCNBOEH6wvsjbX0mderKz1wo=;
 b=gIOaITtRBy0OqGsmNEcyutqTAZbI+Bmga3wCpHLC1uy2IOe4RUgLC4G7Og2O6JRr92
 WfpgnkzAYK56kO4S1V/nJ1tRIUOx+q8u+l7gK4nC6au1LxUAMZ1d2kLR+mTeRiJriA4L
 muda/jP2O15+qSIpdSfUdsv9ce0oLKBytkLaVENjgeK3/Jdh1vIW+cVeh0dHJcyBBCK3
 5RPoUm3fIhXEVboJlc40IisrvkVrTn8wIn4GVuKd6/zq3ZscQyLiwuMd5bV+RHyidniz
 h0OyNTmmEpf3D0o4kYfwIWhOplIufa983pmhvHfTXXOqCoFoLuWXK8oC3dK2Q3ECz3Ls
 1y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=aNp9uiLbQb6uw4tNAZpGCNBOEH6wvsjbX0mderKz1wo=;
 b=fONSetC6yfGqYbQzptugtl2ZgACCvDjMEjhJiMpjaabcH+RuYD9Y1NVPFTaU/wziJG
 Pmuu/Gu+C+e4uVzyODIzZq4iKN8y/5U6AMmdAWesg33wZ1vyWE95HbFKHAOF72IggzEm
 ynBWTm3Qd5T9p41C8yAjeHmXyOY4nDqkAxkspS0oFCSKDhx6nJ508uw9nFK7nvD7fHjG
 Ekm9/0WKL/jEYaS22zGwCrlO288aHBHMA5r7vM2GnS0YE0Ebcp32HjtE3TvuLPlnGrlS
 TWfbOv9nOAlJvZDQt9re1qaFoAJxLpTJ6zyA4Tz6fZqs7S1G57WtZORcVcj1GPAcT7KF
 r/WA==
X-Gm-Message-State: APjAAAXO3jTlhb6UyJ+Mut6R6BNEyjVuB0/qgA4BEX7aTrp/n2t355nT
 76bsWlwsO6rR96Ca5amDXr5LnpXt
X-Google-Smtp-Source: APXvYqysAWgiAsv7H8rcoehE2SieHsplwzYqHFo/13PR/8ck/R7ZR68PvlxTWVcleMKz2SX5dqCjDw==
X-Received: by 2002:adf:fecf:: with SMTP id q15mr22494367wrs.360.1583141686224; 
 Mon, 02 Mar 2020 01:34:46 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j14sm27918884wrn.32.2020.03.02.01.34.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2020 01:34:45 -0800 (PST)
Subject: Re: [PATCH 1/3] drm/amdgpu: fix IB test MCBP bug
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583140927-19809-1-git-send-email-Monk.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <63e00945-68e3-f128-5a78-51c1d87bc778@gmail.com>
Date: Mon, 2 Mar 2020 10:34:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583140927-19809-1-git-send-email-Monk.Liu@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.03.20 um 10:22 schrieb Monk Liu:
> 1)for gfx IB test we shouldn't insert DE meta data
>
> 2)we should make sure IB test finished before we
> send event 3 to hypervisor otherwise the IDLE from
> event 3 will preempt IB test, which is not designed
> as a compatible structure for MCBP
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 3 ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 2 +-
>   5 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 351096a..572eb6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3195,6 +3195,12 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>   	flush_delayed_work(&adev->delayed_init_work);
>   	adev->shutdown = true;
>   
> +	/* make sure IB test finished before entering exclusive mode
> +	 * to avoid preemption on IB test
> +	 * */
> +	if (amdgpu_sriov_vf(adev))
> +		amdgpu_virt_request_full_gpu(adev, false);
> +
>   	/* disable all interrupts */
>   	amdgpu_irq_disable_all(adev);
>   	if (adev->mode_info.mode_config_initialized){
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 0f35639..0b1511a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -88,9 +88,6 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
>   	if (adev->rmmio == NULL)
>   		goto done_free;
>   
> -	if (amdgpu_sriov_vf(adev))
> -		amdgpu_virt_request_full_gpu(adev, false);
> -
>   	if (adev->runpm) {
>   		pm_runtime_get_sync(dev->dev);
>   		pm_runtime_forbid(dev->dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 94ca9ff..0555989 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4432,7 +4432,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>   		if (flags & AMDGPU_IB_PREEMPTED)
>   			control |= INDIRECT_BUFFER_PRE_RESUME(1);
>   
> -		if (!(ib->flags & AMDGPU_IB_FLAG_CE))
> +		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
>   			gfx_v10_0_ring_emit_de_meta(ring,
>   				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 393a132..b14f46a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6116,7 +6116,7 @@ static void gfx_v8_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>   	if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
>   		control |= INDIRECT_BUFFER_PRE_ENB(1);
>   
> -		if (!(ib->flags & AMDGPU_IB_FLAG_CE))
> +		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)

Kernel copies also don't use a VMID, so I think that this won't work 
correctly.

Do you have the job available as well? That would probably be better to 
test for since only IB tests don't use a job.

Christian.

>   			gfx_v8_0_ring_emit_de_meta(ring);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 0156479..d8d256e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4985,7 +4985,7 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>   	if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
>   		control |= INDIRECT_BUFFER_PRE_ENB(1);
>   
> -		if (!(ib->flags & AMDGPU_IB_FLAG_CE))
> +		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
>   			gfx_v9_0_ring_emit_de_meta(ring);
>   	}
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
