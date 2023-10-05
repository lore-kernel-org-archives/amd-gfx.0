Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B800E9370C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 13:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1787010E3F8;
	Thu,  5 Oct 2023 13:14:54 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 647B910E01F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 12:11:15 +0000 (UTC)
Date: Thu, 5 Oct 2023 14:11:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1696507873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=625Y/cDD2OHsrHgGAr7LgMBsCYyGRwESn4t6SD2TUr8=;
 b=c5tyit0XY9d+Ob7RWpT04OokBuFlA5Yx/B9v/v1C9Jv4iP74QnAOwf6DbwdAYG4EI0YrYs
 hQW7mcj6u78cVzgoWsUt6HITqwrLdTNzOKgp2Id4cDEFjOhpMgkzBy9+x3/BrUj9d86jJ+
 A8kz0MsZrqAkSlRTQ4iz++/QU6td4x9EU9fz9rmp3KMUnyY3GhS/mREpfjSjXRSU+3iaST
 tmCiEUhhmU7vt5KztFY9Lsh36ySGIJ15b3Hmr0Gq4tdcc7/txvT6Mg82uCPrVC74O2uFeC
 HmPhFGQOmkBzlOCITC2vPrgBepcgpH+djOvjxLHdGgrUIhG+4IMSWHQBt/nyog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1696507873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=625Y/cDD2OHsrHgGAr7LgMBsCYyGRwESn4t6SD2TUr8=;
 b=12poWRT3BlYVzO23axk1QXNubOeHawYD5RG/G0nnDu1l6bdKHkZlqyWNNORdGNmOG4ysOe
 0Su/lAXYp37GT3CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 0/5] drm/amd/display: Remove migrate-disable and move
 memory allocation.
Message-ID: <20231005121112.g8n1wB8S@linutronix.de>
References: <20230921141516.520471-1-bigeasy@linutronix.de>
 <8be685cb-f44a-1143-60ec-d1073fda8e16@gmail.com>
 <20231002105813.NrEGqSCY@linutronix.de>
 <7a3875f6-122f-426e-95c9-06ed8123249b@amd.com>
 <afad1d4a-6572-43bd-98cb-8f326ad02061@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afad1d4a-6572-43bd-98cb-8f326ad02061@amd.com>
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
Cc: Leo Li <sunpeng.li@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 David Airlie <airlied@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-04 08:44:58 [-0400], Harry Wentland wrote:
> CI passed.
> 
> Series is
> Acked-by: Harry Wentland <harry.wentland@amd.com>

Thank you.

> Harry

Sebastian
