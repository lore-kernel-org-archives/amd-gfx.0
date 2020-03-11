Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681EBC10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 14:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AE320637
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 14:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl0IeKni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AE320637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C3289973;
	Wed, 11 Mar 2020 14:39:25 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F15489973
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 14:39:24 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id e26so2408502wme.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=kn0MUNRxlaXnEj0pIzYAStbSM/CfM2QbWplpo/uWvWw=;
 b=Fl0IeKnigAfFdHEKEUcv1e/7y/e3ywvDUXJ1BSGYXM7QQYstdWnl+5y9b8Bu0iCD6n
 B31xAfJU68iAKuDQ6GJKdKj3YnGe9ewuwTWJIJnGlSGaF4AxgI/6e70qWrqr5nA5WXqH
 XPlOvZipkaqNq4Uz3s7MeeuzdFcHPkWvX1MF1OVDj9lffnDYVictfVM6M+VTwy5vYUMH
 2WsNxLLHbI5LZIMW0YkwGMJTf1E9i0Eg6/XLB718p1/+Isv23PZJo145/xlyYeR5LmNH
 h4XDlbXLOpZ6Z1K4Td2IO/s44zdfv1aCkcH678RMvdeTNGVf0WvThcnEcGgjXysZoTNz
 aNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=kn0MUNRxlaXnEj0pIzYAStbSM/CfM2QbWplpo/uWvWw=;
 b=dtShQreAYvkOc7EL+ATMPnne8OXFINi9WtYsmGJczsiqX26RP5smjNNj2oi9cI57vZ
 PVWok9ANVnsfBPL/OOkOgr8XS1DWpMMhJJpZB4GZQdV7daoREubySOW/OhfKM06JsXQz
 CeRzt3geMW6gfpNanZ+27A0i1t9yQ3V8WUnIE4wZoVMwnr5lAse21WJm5sFosWJYeCf4
 aKRLu5d8fNKYjvrg7C1/nDvbwaNBjt7FduWRhGa05/UQ/aoAR7FiZ11YkkJ1KBD6AofX
 mKhuxVzvHV6mEHIZHHJIm7RtfV9jRLDqq1Hnkf9IgJfbF+Hg5J+XmQIWOh0fe+EfgLah
 n4gw==
X-Gm-Message-State: ANhLgQ3FGQ9IYcrrOs2XeQmjbjV1GBzG2kySBpgWAwnnJ1YPY8z+G34b
 BRF89I8xw0jJGIhvn67N4Y4gsCWf
X-Google-Smtp-Source: ADFU+vusXgNKp+ILo6z1p1NKFQax9TdMBJvmxRvnkgHw4ipdi9MZ0C5heQ9mkuOid7LN6T5NIesYfQ==
X-Received: by 2002:a1c:6583:: with SMTP id z125mr4290218wmb.51.1583937563166; 
 Wed, 11 Mar 2020 07:39:23 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b16sm68498115wrq.14.2020.03.11.07.39.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Mar 2020 07:39:22 -0700 (PDT)
Subject: Re: [PATCH v4 1/4] drm/amdgpu/vcn: fix race condition issue for vcn
 start
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
 <1583936114-706-1-git-send-email-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <dccb35e9-43f8-2cdc-e0ab-04581c0d2bf7@gmail.com>
Date: Wed, 11 Mar 2020 15:39:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583936114-706-1-git-send-email-James.Zhu@amd.com>
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.03.20 um 15:15 schrieb James Zhu:
> Fix race condition issue when multiple vcn starts are called.
>
> v2: Removed checking the return value of cancel_delayed_work_sync()
> to prevent possible races here.
>
> v3: Add total_submission_cnt to avoid gate power unexpectedly.
>
> v4: Remove extra counter check, and reduce counter before idle
> work schedule
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22 +++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
>   2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index a41272f..2fa2891 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -63,6 +63,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   	int i, r;
>   
>   	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
> +	mutex_init(&adev->vcn.vcn_pg_lock);
> +	atomic_set(&adev->vcn.total_submission_cnt, 0);
>   
>   	switch (adev->asic_type) {
>   	case CHIP_RAVEN:
> @@ -210,6 +212,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>   	}
>   
>   	release_firmware(adev->vcn.fw);
> +	mutex_destroy(&adev->vcn.vcn_pg_lock);
>   
>   	return 0;
>   }
> @@ -307,7 +310,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   		fences += fence[j];
>   	}
>   
> -	if (fences == 0) {
> +	if (fences == 0 &&
> +		likely(atomic_read(&adev->vcn.total_submission_cnt) == 0)) {

The indentation here looks off, maybe just write that as !fences && 
!atomic_read(&adev->vcn.total_submission_cnt).

Apart from that looks good to me now,
Christian.

>   		amdgpu_gfx_off_ctrl(adev, true);
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>   		       AMD_PG_STATE_GATE);
> @@ -319,13 +323,14 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
> -	if (set_clocks) {
> -		amdgpu_gfx_off_ctrl(adev, false);
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -		       AMD_PG_STATE_UNGATE);
> -	}
> +	atomic_inc(&adev->vcn.total_submission_cnt);
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +
> +	mutex_lock(&adev->vcn.vcn_pg_lock);
> +	amdgpu_gfx_off_ctrl(adev, false);
> +	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +	       AMD_PG_STATE_UNGATE);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
>   		struct dpg_pause_state new_state;
> @@ -345,10 +350,13 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   
>   		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
>   	}
> +	mutex_unlock(&adev->vcn.vcn_pg_lock);
>   }
>   
>   void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
>   {
> +	atomic_dec(&ring->adev->vcn.total_submission_cnt);
> +
>   	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 6fe0573..111c4cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -200,6 +200,8 @@ struct amdgpu_vcn {
>   	struct drm_gpu_scheduler *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];
>   	uint32_t		 num_vcn_enc_sched;
>   	uint32_t		 num_vcn_dec_sched;
> +	struct mutex		 vcn_pg_lock;
> +	atomic_t		 total_submission_cnt;
>   
>   	unsigned	harvest_config;
>   	int (*pause_dpg_mode)(struct amdgpu_device *adev,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
