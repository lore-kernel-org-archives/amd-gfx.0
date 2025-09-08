Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D54ECAC582
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 19:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FD010E5BC;
	Mon,  8 Sep 2025 19:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="RjKxiOOy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 095A610E5BC
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 19:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NjjXowRseiLL8JgkKIsdG4wOG5QyBw7fqGwalfERf6w=; b=RjKxiOOymXbVM/YBHEZ4NP338U
 SUZOQoNSKX8ybrR7BpKlJLMAUpc2Wd6PZvv0p5ZPsELAXOX7MlNbzMBmXy/esokCBfwDX4O5fa3Vs
 YmgSJi5+gZx015Tgxlmyb7WloxgSSZUDb8ZuIAXuOWbA5tAxkx1Zb6m4HaJB4tBJEJ1hb5rqx8b85
 AvBijtXTDuIYa+RccIIh29uHHZsI8IcQcfAdkV9lzGCIaHynf9EjohSXeMKQBcK4eZmE5vG9FP5SI
 tjQPmTXQ0+BJXBk3ViVdEuqEclViUBEvBZknhjiHMP0L39kX8XToFj4NBc0mBz1JViVQK99R81TSx
 5lUsoOtw==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uvhv1-008ewg-Rx; Mon, 08 Sep 2025 21:52:52 +0200
Date: Mon, 8 Sep 2025 13:52:47 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 James Zhu <James.Zhu@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2 0/2] Add some adjustment for VCN 4.0.3 and 5.0.1
Message-ID: <jfb6rno5hzx6j5hcrsbn5mq426tkdpxaggwhjfdcjefseu3im3@pmon7amd2lya>
References: <20250825004800.3851474-1-siqueira@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825004800.3851474-1-siqueira@igalia.com>
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

On 08/24, Rodrigo Siqueira wrote:
> While I was looking into the ring buffer interface, I noticed some minor
> issues in the VCN 4.0.3 and 5.0.1. This series has some code
> improvements in those two components.
> 
> Changes since V1:
> After Alex's feedback, this second version changed a lot, but I decided
> to send this as a V2 to make it easy to follow the series evolution.
> Follows the change summary:
> - Patch 1: Rewrite the patch to describe VCN 4.0.3-specific behavior.
> - Patch 2: Change amdgpu_vcn_sw_fini() return to void, and add the required modification.
> Link to V1: https://patchwork.freedesktop.org/series/153016/
> 
> Thanks
> 
> Rodrigo Siqueira (2):
>   drm/amdgpu/vcn: Document IRQ per-instance irq behavior for VCN 4.0.3
>   drm/amdgpu/vcn: Change amdgpu_vcn_sw_fini return to void
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  6 ++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  7 ++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 13 +++++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  4 +---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  7 ++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c |  9 +++------
>  11 files changed, 24 insertions(+), 40 deletions(-)
> 
> -- 
> 2.47.2
>

Hi,

Any comment about this series?

Thanks

-- 
Rodrigo Siqueira
