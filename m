Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BBCC10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 17:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FAA7112D6D;
	Tue, 30 Apr 2024 17:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FpWn+X3u";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1CB112D6A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m0gM1BsSN8d5JNbmbUE5skZMjP5f4frFV+uiiaY/BbQ=; b=FpWn+X3u19fWpqeW6UU29Sw+N7
 kMo7cIclroKrny24tqdKnjclK+AqNaJ3hr6Z/+be8I5scPJwvl3q9GdVm5kCPbyM3wW4tQBMPeqP0
 WAmJM+G3/x9rLpnGB1uTDCz8aELfVZfnJhx4ZmPVHWWmvfN+LvqdSMMGbNr6pCF1vcobqdmXb0bAV
 1QpluajNEShGKNpyjhaYLG6SHT0mDXQVVnBJ4kKsILPFCc1TZUFSYFfd0+xzDrYwVVUjuE68thlsI
 hVe9cLO/U8C2s+Bij6MfuIb9LehgY2d9452z7Ms1SApgYl84hJFk+1IysxJvjZdjMtl9BCo2T222z
 HheVNr/Q==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s1rGm-001sRk-Ci; Tue, 30 Apr 2024 19:27:56 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 5/5] drm/amdgpu: Only show VRAM in fdinfo if it exists
Date: Tue, 30 Apr 2024 18:27:48 +0100
Message-ID: <20240430172748.61576-6-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430172748.61576-1-tursulin@igalia.com>
References: <20240430172748.61576-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Do not emit the key-value pairs if the VRAM does not exist ie. VRAM
placement is not valid and accessible.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 29 +++++++++++++---------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index a09944104c41..603a5c010f5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -83,25 +83,30 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	 */
 
 	drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
-	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
 	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
 	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
-	drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
-		   stats.visible_vram/1024UL);
-	drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
-		   stats.evicted_vram/1024UL);
-	drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
-		   stats.evicted_visible_vram/1024UL);
-	drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
-		   stats.requested_vram/1024UL);
-	drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
-		   stats.requested_visible_vram/1024UL);
 	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
 		   stats.requested_gtt/1024UL);
-	drm_printf(p, "drm-shared-vram:\t%llu KiB\n", stats.vram_shared/1024UL);
 	drm_printf(p, "drm-shared-gtt:\t%llu KiB\n", stats.gtt_shared/1024UL);
 	drm_printf(p, "drm-shared-cpu:\t%llu KiB\n", stats.cpu_shared/1024UL);
 
+	if (!adev->gmc.is_app_apu) {
+		drm_printf(p, "drm-memory-vram:\t%llu KiB\n",
+			   stats.vram/1024UL);
+		drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
+			   stats.visible_vram/1024UL);
+		drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
+			   stats.evicted_vram/1024UL);
+		drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
+			   stats.evicted_visible_vram/1024UL);
+		drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
+			   stats.requested_vram/1024UL);
+		drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
+			   stats.requested_visible_vram/1024UL);
+		drm_printf(p, "drm-shared-vram:\t%llu KiB\n",
+			   stats.vram_shared/1024UL);
+	}
+
 	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
 		if (!usage[hw_ip])
 			continue;
-- 
2.44.0

