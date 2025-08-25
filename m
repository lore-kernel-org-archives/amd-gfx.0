Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F266CA0EED
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 00:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EBFE10E057;
	Mon, 25 Aug 2025 00:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="P38A3BK0";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F1F910E225
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 00:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LSp8VctIGv5Xp5/rRgBGavhNc1pBk2vg4RlkDIQfjaQ=; b=P38A3BK0ZTI1FYRH5krE0bX+a9
 R9OcrCRJyd5vIUYQtPSW6J2mvG1ZYHnM63O9B/qW3So+5ciw5wFoqXiBzMJrFQ4qqXyQrIN+q/cek
 2YOUZmYLudNzYaG0lBXJnuPzZDn9gRWAq23HZ+XPhnKzCzBu3zjVKl3JcHWVqjFSEQbiIW4HoFh2j
 F7wktSO9U6WPdnUlqyAbaRTR4EHWMW3PlGonk8gQxtrGqFNMjNm+ArmxtwPdVPdPERQlyzjR6fvB9
 N0JqU9KiokDluWSvvfI6JvNwKDNKpZch+qYGDoum/l6o7aDMvK1VHZnYt4iD9zqCtqY6Fot5teoLU
 5gJChLhg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uqLNf-001AML-9l; Mon, 25 Aug 2025 02:48:15 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v2 1/2] drm/amdgpu/vcn: Document IRQ per-instance irq behavior
 for VCN 4.0.3
Date: Sun, 24 Aug 2025 18:46:40 -0600
Message-ID: <20250825004800.3851474-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825004800.3851474-1-siqueira@igalia.com>
References: <20250825004800.3851474-1-siqueira@igalia.com>
MIME-Version: 1.0
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

When examining the VCN function init, it is common to find a loop that
initializes VCN rings, which uses one IRQ per instance. However, VCN
4.0.3 deviates from this pattern, as it includes a distinct field to
differentiate instances, which results in a slightly different ring
init. This commit makes this difference explicit by using a fixed index
when initializing the ring buffer and also adds a comment.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 7b93a275ec4f..bae1ad4484ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -212,7 +212,11 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
 		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
+
+		/* There are no per-instance irq source IDs on 4.0.3, the IH
+		 * packets use a separate field to differentiate instances.
+		 */
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[0].irq, 0,
 				     AMDGPU_RING_PRIO_DEFAULT,
 				     &adev->vcn.inst[i].sched_score);
 		if (r)
-- 
2.47.2

