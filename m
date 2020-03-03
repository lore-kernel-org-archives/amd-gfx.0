Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3273EC3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 18:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D1F2072D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 18:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oY0jmJw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D1F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3146E51C;
	Tue,  3 Mar 2020 18:44:40 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9730F6E51C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 18:44:39 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a132so4484942wme.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Mar 2020 10:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=OtEFu24D+JQPAZ2vyTITMhkRFB27sc/GCzGx+OIElJM=;
 b=oY0jmJw8QfDmzx6NjnP6daSDQTO1YLfWNGs3cK3/BB+nyhqJbwV3eiWFT88UCbbn0L
 qlVg0RqpNrsAG7iZS4TJgFb6j814Aouxx+cQQXbYfMa0P/WrDpCPH7yNg/cAZI2doJz/
 HCnznnXT45rdlXoZaPqzB03mgtmiF66MRwyTQNyMANk+zOfnplFr1DYjrjDF6SSjHJuD
 epJxuyhJ9+AwCNymnewEy4208E0i3uzetARd9RDVVAdEv4UnXMh9EcdqxGe98V405F60
 T6Gi1yYZjFUcPzQ8Qtt8Gt+Ql6EtIebrVT3I5+YNQnjw2gcaeVYoouC9DUyov0kQE3p7
 YvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=OtEFu24D+JQPAZ2vyTITMhkRFB27sc/GCzGx+OIElJM=;
 b=WSfy5niyYhhN+wDqOU2tPQpLVXNF1/EBeGBei4f1vzDC/9UqgZKzYTHafriLBzlq9B
 uEicShC29WHAVOeh3YRwv/Xg02dt57s+b1eezVaBl5ppB9j0Wc+1CBDY6xj5liAmLhRw
 XRAxwdRB/r09v3P70tqayVEOsp6WFWpmRrKWg+3VEZaez2K8yp5UpWyg8t2I5HM+1dP9
 vbmQJTU03BCc5ilKXYK6F1tLcwg2XEHdpbYspxVrV6wTlNBVH0I5pGJHGLrTOuMs5bLl
 t8aliY+NkvJw6aTSSAqoZxwvbsrbirgU5abZYM4CcEIRV7QNi9CVpvmKFGiiUoL3o6ft
 6fsA==
X-Gm-Message-State: ANhLgQ0miHd0lW4KqN/g9z+U0gtWeN/csLtwiODWqxKG/TazwG0xbe+D
 x9uJbhkctw+GWLdxpYHBYhgEP75v
X-Google-Smtp-Source: ADFU+vv0h3F7fI7RIdnshcRXkPWTk2NYd59iUFuG31wjYhLRP8MBJZAA5Pd1NYsz1rz3LtNY5D1xDQ==
X-Received: by 2002:a05:600c:414f:: with SMTP id
 h15mr5343679wmm.130.1583261078224; 
 Tue, 03 Mar 2020 10:44:38 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id o18sm30955008wrv.60.2020.03.03.10.44.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Mar 2020 10:44:37 -0800 (PST)
Subject: Re: [PATCH 1/4] drm/amdgpu/vcn: fix race condition issue for vcn start
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <29c65b64-26d1-dfef-9da9-2563f291c2e8@gmail.com>
Date: Tue, 3 Mar 2020 19:44:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
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

Am 03.03.20 um 19:16 schrieb James Zhu:
> Fix race condition issue when multiple vcn starts are called.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 1 +
>   2 files changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index f96464e..aa7663f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -63,6 +63,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   	int i, r;
>   
>   	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
> +	mutex_init(&adev->vcn.vcn_pg_lock);
>   
>   	switch (adev->asic_type) {
>   	case CHIP_RAVEN:
> @@ -210,6 +211,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>   	}
>   
>   	release_firmware(adev->vcn.fw);
> +	mutex_destroy(&adev->vcn.vcn_pg_lock);
>   
>   	return 0;
>   }
> @@ -321,6 +323,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   	struct amdgpu_device *adev = ring->adev;
>   	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
> +	mutex_lock(&adev->vcn.vcn_pg_lock);

That still won't work correctly here.

The whole idea of the cancel_delayed_work_sync() and 
schedule_delayed_work() dance is that you have exactly one user of that. 
If you have multiple rings that whole thing won't work correctly.

To fix this you need to call mutex_lock() before 
cancel_delayed_work_sync() and schedule_delayed_work() before 
mutex_unlock().

Regards,
Christian.

>   	if (set_clocks) {
>   		amdgpu_gfx_off_ctrl(adev, false);
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> @@ -345,6 +348,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   
>   		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
>   	}
> +	mutex_unlock(&adev->vcn.vcn_pg_lock);
>   }
>   
>   void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 6fe0573..2ae110d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -200,6 +200,7 @@ struct amdgpu_vcn {
>   	struct drm_gpu_scheduler *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];
>   	uint32_t		 num_vcn_enc_sched;
>   	uint32_t		 num_vcn_dec_sched;
> +	struct mutex		 vcn_pg_lock;
>   
>   	unsigned	harvest_config;
>   	int (*pause_dpg_mode)(struct amdgpu_device *adev,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
