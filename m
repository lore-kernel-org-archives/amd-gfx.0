Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDDCC87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 08:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBAC10E73B;
	Wed,  6 Aug 2025 08:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b+rwoDKC";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6FB10E65E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 11:51:45 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-55b859545c3so5927974e87.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Aug 2025 04:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754394703; x=1754999503; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eKoYknbp1lTrsZTB7bW+rX2M/KdDXC6rCLX3NEF5wzE=;
 b=b+rwoDKCFIgaoFs8jsDzrKcu0IkJn8tjoXE3eYbe0KmM5MuB6sl8PklsvrTGajaxFM
 pXyipNGo39Ka7M3xzMhu+vptDzT2Q9jJteyai9iZk0R3ogpEH9U1sIQt5l/jcrzU6Rzm
 x43tYE7HvnraFYmCzjSBdPYpuVnEamvcybq3JzGS4i/Z3vQiqeT1cFvBNDj0GFjxUBGm
 3/3S9RoTd9R40FO5m06oQY0pnUm+ICWOjgPwNK2dbc2lmKdIsGDuYvIa15xAukwploaJ
 smiJfCOoGIubjNakdbe7IShwJc1c3eISHRZwGAPzj5617TvkmYZh1Zsnso29+NQpRZ7D
 8Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754394703; x=1754999503;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKoYknbp1lTrsZTB7bW+rX2M/KdDXC6rCLX3NEF5wzE=;
 b=h/9FcSGg1jWlw3tzH2gcHdgfD9ByhtMYpcUTen/bHEjv5mTF7wfE9glilg35hxjwTB
 tF8R67YnvpABk9mABo8eqIwYMeyF95fvSeW0F4uTzkEpVDmSV3vD5Pm2/ahM2AWU75/e
 Hi3eTOrRQ7gOmm4lAUao1+rbEfzI94ZkVtN6itvhfR5vr4VEex1eLO/nc1osR+RO5VsK
 omWHSH8PY7sPMmqnwnafOu02/FsrXhx4KOfzeC+PFoA3ikR4zvSat+B4ukpEMa9OCimD
 uPvnknGuFurz5auRA17GVNwq0dA5gJ/Xir2u50YpI8Gew7chOraxscUlfSA1BTT8zQpp
 la1A==
X-Gm-Message-State: AOJu0YxgQbZqreNdCmUi0mPis+zeBZpJG+Lhfim10rjn579WfpzCgbJ+
 pNUScfAeQRBklDfQAteLJT3Y214XMQiOxR/nOWAjmJWIwr750sQEMFrykl8m/Q==
X-Gm-Gg: ASbGncs4Wxh33E/+8R3gk15BhRDf3lYM/umbh0pmSMUG6aXJG8PY0pzww6oG8IsdhqY
 ImAAhHHibkHrLfFf4DSfrplW11pdeT2h1w8HuQY4WxVagf1mgSM5XeMayyg8e1ST+vKlzdNjVZT
 7rDPvHRIoAGL6wSFncwJXnAYmB2xJOof43MNeIu/Iv/0TH1oRmlauiZuuMmwFgmXdlVHLC4Pu9S
 So0pYGEj+iKH9TVJsJpMRrfOOdfv8T1wzRvr4FAdfTz3ebr8J7XPOUrka4ru+Xt5nSBl5QRZK0J
 mVVmVOd973K/FeDtc1PMCTtr6cCsc7jcN/AFJXOdz2xC6xoz2bxwsPrtl1NmdztQogQZZq6Eaad
 i+6qrPN+VEvXFi0CYsNGmWUedJa8RqzphOoOOKA==
X-Google-Smtp-Source: AGHT+IHCb9sOGrAFtOk/G8dm6OXMqQYb5gKPmMKeGqRiet75pccMpAHcG7GbFdQryvar5Mvmnjvn/g==
X-Received: by 2002:a05:6512:3e04:b0:550:e8b6:6996 with SMTP id
 2adb3069b0e04-55bab32879cmr1005833e87.2.1754394702711; 
 Tue, 05 Aug 2025 04:51:42 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu.
 [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
 by smtp.gmail.com with UTF8SMTPSA id
 2adb3069b0e04-55b88c990e6sm1945928e87.113.2025.08.05.04.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 04:51:42 -0700 (PDT)
Date: Tue, 5 Aug 2025 13:51:41 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Roman.Li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
 Fangzhi Zuo <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH 03/12] drm/amd/display: fix dmub access race condition
Message-ID: <75rerexc7d5my3gb3mwlquqx7k6yissioelxcea45agw6fpa7h@dalkkqguzjh6>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
 <20250730185903.1023256-4-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730185903.1023256-4-Roman.Li@amd.com>
X-Mailman-Approved-At: Wed, 06 Aug 2025 08:28:28 +0000
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

Hi,

On 2025-07-30 14:58:54 -0400, Roman.Li@amd.com wrote:
> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
> 
> Accessing DC from amdgpu_dm is usually preceded by acquisition of
> dc_lock mutex. Most of the DC API that DM calls are under a DC lock.
> However, there are a few that are not. Some DC API called from interrupt
> context end up sending DMUB commands via a DC API, while other threads were
> using DMUB. This was apparent from a race between calls for setting idle
> optimization enable/disable and the DC API to set vmin/vmax.
> 
> Offload the call to dc_stream_adjust_vmin_vmax() to a thread instead
> of directly calling them from the interrupt handler such that it waits
> for dc_lock.
> 
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Roman Li <roman.li@amd.com>

With this patch I get sleeping function called from invalid context
roughly every second. This occurs on at least PREEMPT_LAZY and
PREEMPT_VOLUNTARY.

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:321
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 13841, name: cc1
preempt_count: 10002, expected: 0
CPU: 23 UID: 1000 PID: 13841 Comm: cc1 Kdump: loaded Tainted: G        W           6.16.0-next-20250805 #631 PREEMPTLAZY 
Tainted: [W]=WARN
Hardware name: Micro-Star International Co., Ltd. MS-7C91/MAG B550 TOMAHAWK (MS-7C91), BIOS A.I0 03/20/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x4b/0x70
 __might_resched.cold+0xac/0xb9
 __kmalloc_cache_noprof+0x2d4/0x430
 ? schedule_dc_vmin_vmax+0x49/0x1c0 [amdgpu]
 ? __alloc_frozen_pages_noprof+0x18f/0x360
 ? _raw_spin_unlock_irqrestore+0x12/0x40
 ? schedule_dc_vmin_vmax+0x49/0x1c0 [amdgpu]
 schedule_dc_vmin_vmax+0x49/0x1c0 [amdgpu]
 dm_crtc_high_irq+0x2ab/0x310 [amdgpu]
 amdgpu_dm_irq_handler+0x8d/0x210 [amdgpu]
 amdgpu_irq_dispatch+0x166/0x1a0 [amdgpu]
 amdgpu_ih_process+0x60/0x160 [amdgpu]
 amdgpu_irq_handler+0x23/0x60 [amdgpu]
 __handle_irq_event_percpu+0x4a/0x1a0
 handle_irq_event+0x38/0x90
 handle_edge_irq+0xc4/0x190
 __common_interrupt+0x44/0xe0
 ? srso_return_thunk+0x5/0x5f
 common_interrupt+0x3a/0xa0
 asm_common_interrupt+0x26/0x40
RIP: 0033:0x55d4848fab81
Code: 28 44 8b 5f 70 ff 87 80 00 00 00 49 89 d7 48 89 34 24 45 8d 73 ff 44 89 f3 21 cb 48 8b 4f 58 41 89 dd 49 c1 e5 03 4a 8b 2c 29 <48> 85 ed 0f 84 36 02 00 00 48 83 fd ff 0f 84 bc 00 00 00 44 39 4d
RSP: 002b:00007fff71eeed50 EFLAGS: 00000212
RAX: 000000000000001f RBX: 0000000000002182 RCX: 00007f47b3f00010
RDX: 000000000000001f RSI: 000055d4bfce1e3c RDI: 000055d4bfbb2e80
RBP: 0000000000000000 R08: 0000000000000001 R09: 000000006d35e182
R10: 000055d4bfb94630 R11: 0000000000004000 R12: 000055d4bfbb2e80
R13: 0000000000010c10 R14: 0000000000003fff R15: 000000000000001f
 </TASK>

...

> +static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
> +	struct dc_stream_state *stream,
> +	struct dc_crtc_timing_adjust *adjust)
> +{
> +	struct vupdate_offload_work *offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
> +	if (!offload_work) {
> +		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate vupdate_offload_work\n");
> +		return;
> +	}
> +
> +	struct dc_crtc_timing_adjust *adjust_copy = kzalloc(sizeof(*adjust_copy), GFP_KERNEL);
> +	if (!adjust_copy) {
> +		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate adjust_copy\n");
> +		kfree(offload_work);
> +		return;
> +	}
> +
> +	dc_stream_retain(stream);
> +	memcpy(adjust_copy, adjust, sizeof(*adjust_copy));
> +
> +	INIT_WORK(&offload_work->work, dm_handle_vmin_vmax_update);
> +	offload_work->adev = adev;
> +	offload_work->stream = stream;
> +	offload_work->adjust = adjust_copy;
> +
> +	queue_work(system_wq, &offload_work->work);
> +}
> +

The allocations in this function seems to be the culprit. If I change
them to GFP_ATOMIC the issue disappears:

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 31ea57edeb45..afe0fea13bb0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -550,13 +550,13 @@ static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
 	struct dc_stream_state *stream,
 	struct dc_crtc_timing_adjust *adjust)
 {
-	struct vupdate_offload_work *offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
+	struct vupdate_offload_work *offload_work = kzalloc(sizeof(*offload_work), GFP_ATOMIC);
 	if (!offload_work) {
 		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate vupdate_offload_work\n");
 		return;
 	}
 
-	struct dc_crtc_timing_adjust *adjust_copy = kzalloc(sizeof(*adjust_copy), GFP_KERNEL);
+	struct dc_crtc_timing_adjust *adjust_copy = kzalloc(sizeof(*adjust_copy), GFP_ATOMIC);
 	if (!adjust_copy) {
 		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate adjust_copy\n");
 		kfree(offload_work);

...

Regards,
Klara Modin
