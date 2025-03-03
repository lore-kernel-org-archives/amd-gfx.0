Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE6EC282D3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 09:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E47AC10E527;
	Tue,  4 Mar 2025 09:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="ljOeIPFo";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F54710E2E5;
 Mon,  3 Mar 2025 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=zcWTq0+tIXCR7i1Bn8SpUwbeuy7hHsMrsLtvUfkNYic=; b=ljOeIPFoWhayaeSJ
 rHzpOtXpgkuRPEiKmG2zVC85wjomyNbcZ6lGe2Luo+7Vs5YvEcwxRqVn3fNs+ZJ048QDCVk7+g22f
 bvlZCLpvIaz19Atyeix5qtly+EMyojwJOzjHhe+gzVPNPPsvK3w7QHwE0c/fBu3Q7iwYLIQXVWp7z
 0KLfyg1j5o6Zrt1p5GBJ0r3x76+D/r8wRSWGJEZFaRSYxtcvVtMIm7U3RTwtDeGnYaEQUEf6PbpVe
 g7LjIQQ1uvnHNRfpSwXhfbs1Gx+Q/yGZoHUrxFdF7/tRdKv2nQzRpBPxp2r0cnn70NqZvnWLo0vjE
 rNw364LqKRK1RqZdlA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <linux@treblig.org>) id 1tp6x3-0028PG-0W;
 Mon, 03 Mar 2025 14:39:25 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com, austin.zheng@amd.com, jun.lei@amd.com,
 kenneth.feng@amd.com, linux-kernel@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/6] drm/amdgpu: Remove phm_powerdown_uvd
Date: Mon,  3 Mar 2025 14:39:18 +0000
Message-ID: <20250303143922.36342-3-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303143922.36342-1-linux@treblig.org>
References: <20250303143922.36342-1-linux@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Mar 2025 09:21:05 +0000
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

phm_powerdown_uvd() has been unused since 2017's
commit 47047263c527 ("drm/amd/powerplay: delete eventmgr related files.")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c   | 10 ----------
 drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
index 90452b66e107..a59677cf8dfc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
@@ -149,16 +149,6 @@ int phm_apply_clock_adjust_rules(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-int phm_powerdown_uvd(struct pp_hwmgr *hwmgr)
-{
-	PHM_FUNC_CHECK(hwmgr);
-
-	if (hwmgr->hwmgr_func->powerdown_uvd != NULL)
-		return hwmgr->hwmgr_func->powerdown_uvd(hwmgr);
-	return 0;
-}
-
-
 int phm_disable_clock_power_gatings(struct pp_hwmgr *hwmgr)
 {
 	PHM_FUNC_CHECK(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
index f4f9a104d170..915f1b8e4dba 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
@@ -396,7 +396,6 @@ struct phm_odn_clock_levels {
 };
 
 extern int phm_disable_clock_power_gatings(struct pp_hwmgr *hwmgr);
-extern int phm_powerdown_uvd(struct pp_hwmgr *hwmgr);
 extern int phm_setup_asic(struct pp_hwmgr *hwmgr);
 extern int phm_enable_dynamic_state_management(struct pp_hwmgr *hwmgr);
 extern int phm_disable_dynamic_state_management(struct pp_hwmgr *hwmgr);
-- 
2.48.1

