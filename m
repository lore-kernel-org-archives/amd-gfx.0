Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6F9C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 21:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FB1510E57B;
	Thu, 24 Sep 2026 21:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="L3rr4ISO";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9CD110E1F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 21:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=BotAbiiqRZXmJkNo41Q2GXEcj2IA0qV9fMw14eKAaCc=; b=
 L3rr4ISO6xmdMOSlqtJxug27EcxSmXn3+vUFuV7ceOwSnqKdec1GeVvawHrq3bNqEsvxVhNKVCPs3
 fMAmEREXGPrjMZa52n//x8QficiECO4pAtV37C3/UebFHjkqx5JAcQJnltMcD4eKa7rXUHfdee8Qx
 xPt5CnU8tQ+2rm89mJgMKmukIybuYqiHferInEbvc2nwj2kmjDch5MKrawS9PR1Pd69TwOa/SCUXt
 YHEBwzrDcsPk1/xxN8u+WBJnDBwl8mAmVtZ3oYG6cFbgkrKg9Dv+GYA09RV8QZBoMB3EUAOjvfWeX
 brPrlysQFRosXevUO4/Q8/Ui14rME58Elw==;
Received: from 113.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.113]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9qlh-006qf4-Ob; Thu, 24 Sep 2026 23:14:13 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 Aurabindo.Pillai@amd.com, christian.koenig@amd.com, David.Francis@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] drm/amd/display: fix vready offset assignment in
 dcn_optc_lock_unlock_state
Date: Thu, 24 Sep 2026 23:10:06 +0200
Message-ID: <20260924211410.867686-4-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924211410.867686-1-mwen@igalia.com>
References: <20260924211410.867686-1-mwen@igalia.com>
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

vready_offset is captured by optc_state, but the trace point entry is
wrongly assigned to vupdate_offset. Fix vready_offset tracepoint field
in dcn_optc_lock_unloack_state to record optc_state->vready_offset.

Fixes: f1943a51f0f9 ("drm/amd/display: Add events log to trace OPTC lock and unlock")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 887ebac8c97e..f5c2f589f691 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -701,7 +701,7 @@ TRACE_EVENT(dcn_optc_lock_unlock_state,
 			   __entry->vstartup_start = optc_state->vstartup_start;
 			   __entry->vupdate_offset = optc_state->vupdate_offset;
 			   __entry->vupdate_width = optc_state->vupdate_width;
-			   __entry->vready_offset = optc_state->vupdate_offset;
+			   __entry->vready_offset = optc_state->vready_offset;
 	    ),
 	    TP_printk("%s: %s()+%d: optc_instance=%d opp_count=%d max_h_total=%d max_v_total=%d "
 		      "min_h_blank=%d min_h_sync_width=%d min_v_sync_width=%d min_v_blank=%d "
-- 
2.53.0

