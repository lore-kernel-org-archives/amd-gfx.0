Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56976E9370D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 13:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA4610E3F9;
	Thu,  5 Oct 2023 13:14:54 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF5D10E3F7;
 Thu,  5 Oct 2023 12:10:41 +0000 (UTC)
Date: Thu, 5 Oct 2023 14:10:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1696507838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jx3WmHSafZ6lVoo0Hs4Pf1IVLbQn5dapa0CE9NYPH0g=;
 b=SKCqyDcGiMN5G7dokJn53gB969nlMP1eVcnlKt2BWyXITefVFoFqIV4/MxR11Up5p+VsmW
 IDgSv9DTmpKVZc884Ek40FcskdTU9pW5MmoC771eyZ8A2G7ozhrHwikp8XkBHzYgFrc+uu
 K+sTIg44NE6PzhFHKVTQHcpP79VCDn/7ZZMYFO4hcrQqkLGJsgrqYnP3EU2/ac2IEJlzj/
 TImWp7YgWpQGv32EdhxqVpv7sx7Vkcs5ycBejkhCtc1bZOPveRBssK7vYjjP43Ozw6pF6R
 ryezSbH2sh3NHj1bPVnmB4u5vwHmgTAPzXWnuwdDT/V87i7l8EdZz7V5vHry9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1696507838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jx3WmHSafZ6lVoo0Hs4Pf1IVLbQn5dapa0CE9NYPH0g=;
 b=xWXDpTxI8Mf5DpNj/mRcurjs2c6juqFf5fWp/8YJaVx4xlrbNQ061ygv4l5AgbiZ6qjkA6
 YPTinFHFIOznaPCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: Re: [PATCH 1/5] drm/amd/display: Remove migrate_en/dis from
 dc_fpu_begin().
Message-ID: <20231005121036.NmJqqCrV@linutronix.de>
References: <20230921141516.520471-1-bigeasy@linutronix.de>
 <20230921141516.520471-2-bigeasy@linutronix.de>
 <ad5179f7-d2f6-4306-b70e-f0ae5cefcff6@amd.com>
 <b0afd174-2a52-40f0-9908-6f2e9161ae9d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0afd174-2a52-40f0-9908-6f2e9161ae9d@amd.com>
X-Mailman-Approved-At: Thu, 05 Oct 2023 13:14:53 +0000
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
Cc: Tianci Yin <tianci.yin@amd.com>, Leo Li <sunpeng.li@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-04 08:10:35 [-0400], Hamza Mahfooz wrote:
> I did some digging, and it seems like the intention of that patch was to
> fix the following splat:
> 
> WARNING: CPU: 5 PID: 1062 at
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:71
> dc_assert_fp_enabled+0x1a/0x30 [amdgpu]
> [...]
> CPU: 5 PID: 1062 Comm: Xorg Tainted: G           OE 5.15.0-56-generic

So it has hard to look this up with a upstream v5.15 kernel since the
dcn32_populate_dml_pipes_from_context() was introduced in v6.0-rc1.
Judging from v6.0-rc1 I don't see how that warning could occur other
than using dc_assert_fp_enabled() without invoking DC_FP_START first.

> Hamza

Sebastian
