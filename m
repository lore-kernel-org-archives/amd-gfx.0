Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D328E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 10:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5148410E268;
	Fri, 13 Dec 2024 10:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jB2QTZhc";
	dkim-atps=neutral
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A2710E268
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 10:14:01 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso2706665e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 02:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734084840; x=1734689640; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3nN8GSa6GighCsMiMfeKbPTscVJzXUP/F9SPJ/Ag+UQ=;
 b=jB2QTZhcjxdzoskPQfr9UcA+OkIDDV8DYhf7hyllOvIOZ3O/bMrhRNgpUKE/8IFJrx
 RdYUnO3L9xQV8pVMnXM5ePD0zjMBKSqRlx9OCEEzxpbulGDpRaC6PMzE2tK66REGRMm+
 nLCWtd7ehUpzk2hE7YGiww2l7cdHAdT9t7w4wwV+gEwtxJ/yECeC8cySgrXLK7PA88t4
 QS3CfnT1qEqlNw8yd+NZFlKPWD/YOqrHsO0UXn1A5S4Qm2alYnO8x9OMQmm9HeD4SjcA
 dFFlApF9cS3JqdwRXhkhtJ+28SLyFrnjF7EcZ+Z2llVE7Xo0R0j9rGnP0j1YjFgna9/l
 52Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734084840; x=1734689640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3nN8GSa6GighCsMiMfeKbPTscVJzXUP/F9SPJ/Ag+UQ=;
 b=Ugnkvv3+EbBTRRQDbkA9/ZtZNg8s4sqLGsVP3pQ7G0vGbhKMtr3o5X5oXiyFAdOcJt
 zJKDOYbNd1XHL17xVoh/JhdbLsCzhweb44I+N07qCT1+Zx/kB8JKvj+a1QEPdJoxAQ7Z
 aICWguLFELKm25SmdRPJ+3sSB5DCPOvhy1Egbd5Nf0zE4+cczNu1kDN9a6wNqewwbevK
 gqqBTanHaxos1OkH3WDiKJNMSGecux+uc8ml9Fpo9WpwE1rBd8FDEvQv+z2KWVpL+5le
 9HQjx8DZ0N2lRQg/1vCeKf99Y+vCJSivIqVzcbsEaTs13X6D1ufglC2U6y7MaquUQAUu
 c9bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0Vm7BwibYGE3I2pBgkST1hMtSqp2tfRencpm7DXi7NnvdmcpkEqon5kC7pkJFvJfkUMUyYT0h@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqNpjXDmuZ+4/9mlIuIuRXtSz787YMfs0pdNG76e8l+uIknz9a
 4maBdEvuK2yt9Wi2CvJyKMvO2/vi78uhRnMEgCZsVh2xQZcJwBht
X-Gm-Gg: ASbGncvhY8727gYqg/FrgyEtJCxBIx/z1q9Reoi+bXp3p00repPZd5JY9VN+fv0gdSb
 thQubAB2XgvNO/0DQSxMadKbgCMB1QA+Xl9B5wsVxuVNci09wCuyONm3BmSPesrCnqpfj+mfVUz
 oKxjlA26iEvtRSmBLgwUtb/KslhGaCDlNEw9ylw9lGKYddk2f8BVh+cCorcCzUZBWTgvvPXgtt5
 ekL5GR9pnhjUwAHbxwtkocOvYyeMY45y/jBKrZ29n+GvuD+T90rwcNrJellloyUMugeWZkc7xCh
 KCotPdhk4g==
X-Google-Smtp-Source: AGHT+IEnBGic2r8qua0HdNElmYX8zjRRiLaCdiBgPfTY+Emq8htB+fDLeF9Upq/k5sxtmv1KYNh8cQ==
X-Received: by 2002:a05:600c:5025:b0:436:1c0c:bfb6 with SMTP id
 5b1f17b1804b1-4362aab0763mr16082425e9.27.1734084839637; 
 Fri, 13 Dec 2024 02:13:59 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514dcesm6516021f8f.65.2024.12.13.02.13.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 02:13:59 -0800 (PST)
Message-ID: <0a7dfd9a-9bef-432b-9175-976e56dcb6f0@gmail.com>
Date: Fri, 13 Dec 2024 11:13:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] drm/amdgpu: Fix the use-after-free issue in wait
 IOCTL
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
 <20241212142533.2164946-3-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241212142533.2164946-3-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 12.12.24 um 15:25 schrieb Arunpravin Paneer Selvam:
> The xarray pointer which has the userqueue xarray structure
> reference should be cleared when the userqueue gets
> destroyed. Otherwise, we may access the freed xa memory and
> see the below warnings.
>
> warning 1:
> BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x7a/0xe0
> [  +0.000044] Call Trace:
> [  +0.000017]  <TASK>
> [  +0.000016]  dump_stack_lvl+0x6c/0x90
> [  +0.000025]  print_report+0xc4/0x5e0
> [  +0.000025]  ? srso_return_thunk+0x5/0x5f
> [  +0.000024]  ? kasan_complete_mode_report_info+0x60/0x1d0
> [  +0.000030]  ? _raw_spin_lock+0x7a/0xe0
> [  +0.000023]  kasan_report+0xdf/0x120
> [  +0.000023]  ? _raw_spin_lock+0x7a/0xe0
> [  +0.000025]  kasan_check_range+0xf7/0x1b0
> [  +0.000025]  __kasan_check_write+0x14/0x20
> [  +0.000024]  _raw_spin_lock+0x7a/0xe0
> [  +0.000023]  ? __pfx__raw_spin_lock+0x10/0x10
> [  +0.000024]  ? amdgpu_userq_wait_ioctl+0xac0/0x1f30 [amdgpu]
> [  +0.000442]  amdgpu_userq_wait_ioctl+0x18fc/0x1f30 [amdgpu]
> [  +0.000428]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000424]  ? __pfx_idr_alloc_u32+0x10/0x10
> [  +0.000027]  ? srso_return_thunk+0x5/0x5f
> [  +0.000024]  ? __kasan_check_write+0x14/0x20
> [  +0.000025]  ? srso_return_thunk+0x5/0x5f
> [  +0.000024]  ? idr_alloc+0x72/0xc0
> [  +0.000023]  ? srso_return_thunk+0x5/0x5f
> [  +0.000023]  ? fput+0x1c/0x2f0
> [  +0.000025]  drm_ioctl_kernel+0x178/0x2f0 [drm]
> [  +0.000065]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000425]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
> [  +0.000064]  ? srso_return_thunk+0x5/0x5f
> [  +0.000023]  ? __kasan_check_write+0x14/0x20
> [  +0.000025]  drm_ioctl+0x513/0xd20 [drm]
> [  +0.000058]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000428]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
> [  +0.000061]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  +0.000027]  ? __count_memcg_events+0x11f/0x3a0
> [  +0.000027]  ? srso_return_thunk+0x5/0x5f
> [  +0.001040]  ? srso_return_thunk+0x5/0x5f
> [  +0.000969]  ? _raw_spin_unlock_irqrestore+0x27/0x50
> [  +0.000966]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
> [  +0.001352]  __x64_sys_ioctl+0x135/0x1b0
> [  +0.000966]  x64_sys_call+0x1205/0x20d0
> [  +0.000968]  do_syscall_64+0x4d/0x120
> [  +0.000960]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000962] RIP: 0033:0x7f42af11a94f
>
> warning 2:
> WARNING: at lib/xarray.c:1849 __xa_alloc+0x13a/0x150
> [  366.491409] RIP: 0010:__xa_alloc+0x13a/0x150
> [  366.491434] Call Trace:
> [  366.491437]  <TASK>
> [  366.491440]  ? show_regs+0x6d/0x80
> [  366.491445]  ? __warn+0x91/0x140
> [  366.491450]  ? __xa_alloc+0x13a/0x150
> [  366.491453]  ? report_bug+0x1c9/0x1e0
> [  366.491459]  ? handle_bug+0x63/0xa0
> [  366.491463]  ? exc_invalid_op+0x1d/0x80
> [  366.491467]  ? asm_exc_invalid_op+0x1f/0x30
> [  366.491476]  ? __xa_alloc+0x13a/0x150
> [  366.491484]  amdgpu_userq_wait_ioctl+0xe0e/0xfe0 [amdgpu]
> [  366.491743]  ? idr_alloc_u32+0x97/0xd0
> [  366.491749]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  366.491912]  drm_ioctl_kernel+0xae/0x100 [drm]
> [  366.491942]  drm_ioctl+0x2a1/0x500 [drm]
> [  366.491961]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  366.492127]  ? srso_return_thunk+0x5/0x5f
> [  366.492132]  ? srso_return_thunk+0x5/0x5f
> [  366.492135]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
> [  366.492139]  amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]
> [  366.492288]  __x64_sys_ioctl+0x99/0xd0
> [  366.492295]  x64_sys_call+0x1209/0x20d0
> [  366.492299]  do_syscall_64+0x51/0x120
> [  366.492303]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  366.492418] RIP: 0033:0x7f86f3b1a94f
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index cba51bdf2e2c..311d536a7079 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -73,6 +73,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>   	}
>   
>   	uq_funcs->mqd_destroy(uq_mgr, queue);
> +	queue->fence_drv->fence_drv_xa_ptr = NULL;
>   	amdgpu_userq_fence_driver_free(queue);
>   	idr_remove(&uq_mgr->userq_idr, queue_id);
>   	kfree(queue);

