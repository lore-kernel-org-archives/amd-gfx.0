Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F13EC6379F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 12:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C384110E1E2;
	Tue, 14 Feb 2023 12:14:17 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7716C10E89D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 12:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8DSoxSqkKqUbKO1/ORrdwwxc3Lx4jnHZYHTAPvzg7VY=; b=f+YuEReuWxUIYcFvpURBouyOp7
 13Qs+oPIjf803D05z+Ge4QqVQHI+9/2Ej6mc4WdGShPG7dz0Pue9qd9cZASdHubMm+NRB+zyoHt0T
 EylJIR3eLFtKrSd3NHWGz0nRBOvrnGmFCAnGJNOq4KCKfQM7U5XwJu6x6hqTDwd7nmSFgYsorRA2z
 4FjGJWVT1ugiEfUV4ArydfqnREoEBohz8oQlrQIyqLhHJlSz/E45bEIs5MNSkqRDQO2vEuoygWjSF
 KHF6XNBx5tmXlF2ICd5UP3TNVOST2o20yLz0qu4TPwz5v/Or4DLIqS4dCcuuWh+JapPv3DONyM4cK
 f6ckiNmw==;
Received: from [38.44.66.31] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pRuCK-0022pF-62; Tue, 14 Feb 2023 13:14:12 +0100
From: Melissa Wen <mwen@igalia.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amd/display: remove unused func declaration from
 resource headers
Date: Tue, 14 Feb 2023 11:14:05 -0100
Message-Id: <20230214121406.97750-6-mwen@igalia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230214121406.97750-1-mwen@igalia.com>
References: <20230214121406.97750-1-mwen@igalia.com>
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
Cc: sunpeng.li@amd.com, Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
 kernel-dev@igalia.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function resource_validate_ctx_update_pointer_after_copy() is
declared in resource.h but never defined, therefore, remove its
declaration from headers.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 4ab029e3326d..fa6da93caa88 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -165,10 +165,6 @@ bool resource_validate_attach_surfaces(
 		struct dc_state *context,
 		const struct resource_pool *pool);
 
-void resource_validate_ctx_update_pointer_after_copy(
-		const struct dc_state *src_ctx,
-		struct dc_state *dst_ctx);
-
 enum dc_status resource_map_clock_resources(
 		const struct dc *dc,
 		struct dc_state *context,
-- 
2.39.0

