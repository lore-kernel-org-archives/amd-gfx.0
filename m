Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A94D49C94
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 10:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8273A10E972;
	Fri, 30 Jan 2026 10:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="R2w1YU9m";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1395E10E941
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 10:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F8EVit+zYqieCwlk9TxrFZFxJgg82je3TyM/TJamYRY=; b=R2w1YU9mz7YIjcizefy7VddKgH
 +CxGl4hrRxHO7nKGqpSK0+vUrVBkcGlAMhKnNnpkjSXMtjKbcNtWoj+BarP7eZqdoqzT1uPEKCsuD
 TJ6/psJxQos1aHA6wWaWVkhTbyeJD9esVVL225pg9jBLtw6m957+md82bGpwrXQJzKMwF8gxkmxp2
 ov0r6nVX4x9px4VWm4rY11EyQO/TBOaQRGM0BpStHeiwOXuHpEhI9adHrLrFPQZ3e2U+N5LkqdlKW
 M5dKq6LfZQbe0y8ntEOIJRJfqIvOHrAfqBFSOvDVr8RAc5RNesKJvBID5fhR4KX72C723PF2DnsNU
 IW5/jRow==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vllM1-00BhEb-8n; Fri, 30 Jan 2026 11:03:53 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC 0/2] RLC register access diet
Date: Fri, 30 Jan 2026 10:03:48 +0000
Message-ID: <20260130100350.2883-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I have sent this before but maybe it was lost in the sea of other patches. So
this time round with explicit cc to hopefully get a definitive decision whether
to pursue or drop.

Basically replacing the runtime conditionals in RLC15 register access with a
function table set at device probe time:

    add/remove: 9/31 grow/shrink: 74/1012 up/down: 39784/-381724 (-341940)
    ...
    Total: Before=9421643, After=9079703, chg -3.63%

More or less, but probably a little bit more, since I collected that before
the gfx12.1 support landed.

Unless I missed some gotcha it looks like the approach could work (it doesn't
crash and burn on the Steam Deck at least) and as the saving is quite
significant so why not? Let me know of the verdict.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>

Tvrtko Ursulin (2):
  drm/amdgpu: Choose SOC15 RLC register read write functions at init
    time
  drm/amdgpu: Only calculate register offset once in SOC15 RLC

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c    | 39 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    | 10 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  | 55 ++++++++++++----------
 10 files changed, 91 insertions(+), 26 deletions(-)

-- 
2.52.0

