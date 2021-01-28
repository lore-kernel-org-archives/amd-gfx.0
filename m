Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6994C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 14:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9427D64D99
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 14:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9427D64D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC2746E1D5;
	Thu, 28 Jan 2021 14:49:10 +0000 (UTC)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9671D6E1D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 14:49:09 +0000 (UTC)
Received: by mail-il1-x12d.google.com with SMTP id p15so4702001ilq.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=5wsV0e5dg1RVslqEUa/isBe0k4Idf9v0cCurcsp6Vck=;
 b=L/2t8+08NIDlq4zb7KCfnJHGKIhwIgJOLa3v5hbIRPssC1azu8fWZXYLAC19FHa3rV
 NOhMcCnz8CTqativrrUGI1Hp/W5tjnM4tU8ilvdZ5yWhuglNSnM9dkWoGDvDhZW3YypA
 pLOJhMNfcuhp6hpyAY48qmALw0PKKAInfzLFiia0WrTYRkFy+dIPDPz467HMDPguvjJ/
 +qbrugs4DwBdlt2pU+plQKb0//ppcGtQzuZm5yPa/WRrC/idIX49FXCm02uvjiwWNHH6
 yNxU/OQUYX4UttDDaAUpgNgse2B+vNlQACNI67N6QcFW0qNVpfBZ/PiIOTuLfDcA/Dtn
 ETxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=5wsV0e5dg1RVslqEUa/isBe0k4Idf9v0cCurcsp6Vck=;
 b=Z3fSA0YIfVPp0wdyOUe8w8y72cRJwBD+87wWS5yCtMR58lMhYLoDJ5ymK6QUnRIoUb
 9xq3oSWi9CXrkJUPnKgIcQCK5ar3A7A3WClIEfyrFWzLsMPgwSJg0GzBAMDcZGnHBger
 NiHv8aLyEghNlzPUu2tUO6TELkkJjN3+i1mUXOhCXqneJUxQAlpR/LzGQtEUzbUgChLH
 RlrqZgNWEG64czwHrI5NeGQDKU/gGF50Gg55x8jMAmO/KxU20OPabh7u9Ngo95JFLn1z
 /LO27mcOPgo2kD3kCZaRjybKON6Iq8KhPMEcc8BZiIoJydQyY6x1RBCQBMPqqabvUkJR
 fxrQ==
X-Gm-Message-State: AOAM530aRPWkSoYoOcmLuqB6PzEjOv0PKA1j7lp5AIpqd3IiM2y6rX8Z
 SK2CLaMgADS+K4mB7igAaBY=
X-Google-Smtp-Source: ABdhPJx47tM4HYXKHHv2kpFuctAZ6+yDE+xu03hPnjL37B5+2ZUdQHW/GJZwWHh5to7uAG37MhmvWQ==
X-Received: by 2002:a92:c80b:: with SMTP id v11mr12867860iln.215.1611845348028; 
 Thu, 28 Jan 2021 06:49:08 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id e7sm2800046ilr.13.2021.01.28.06.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 06:49:07 -0800 (PST)
Subject: Re: [RFC PATCH 2/2] drm/amdgpu: enable gfx wave limiting for high
 priority compute jobs
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210128143554.61100-1-nirmoy.das@amd.com>
 <20210128143554.61100-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0adf796d-c0c8-87cc-e7c0-8a29336385f7@gmail.com>
Date: Thu, 28 Jan 2021 15:49:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128143554.61100-2-nirmoy.das@amd.com>
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
Cc: Alan.Harrison@amd.com, Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 ray.huang@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.01.21 um 15:35 schrieb Nirmoy Das:
> Enable gfx wave limiting for gfx jobs before pushing high priority
> compute jobs so that high priority compute jobs gets more resources
> to finish early.

The problem here is what happens if you have multiple high priority jobs 
running at the same time?

Christian

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 024d0a563a65..ee48989dfb4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -195,6 +195,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
>   		ring->funcs->emit_mem_sync(ring);
>   
> +	if (ring->funcs->emit_wave_limit && job &&
> +	    job->base.s_priority >= DRM_SCHED_PRIORITY_HIGH)
> +		ring->funcs->emit_wave_limit(ring, true);
> +
>   	if (ring->funcs->insert_start)
>   		ring->funcs->insert_start(ring);
>   
> @@ -295,6 +299,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	ring->current_ctx = fence_ctx;
>   	if (vm && ring->funcs->emit_switch_buffer)
>   		amdgpu_ring_emit_switch_buffer(ring);
> +
> +	if (ring->funcs->emit_wave_limit && job &&
> +	    job->base.s_priority >= DRM_SCHED_PRIORITY_HIGH)
> +		ring->funcs->emit_wave_limit(ring, false);
> +
>   	amdgpu_ring_commit(ring);
>   	return 0;
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
