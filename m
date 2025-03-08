Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFC0C28B25
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Mar 2025 14:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB27E10E222;
	Sat,  8 Mar 2025 14:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="kxrE79oN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C8210E222
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Mar 2025 14:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/Dpkwv60YqPSc/sqQub6/quzYXUFfts6/GxccOSodZ8=; b=kxrE79oNIjFYqWAgBacrtz/vwr
 AN7cCN9YcSRAXr8j0CHnisgfb8/HosraPB9Z0yF/Rn+CjPYPyyBTpYGyWjy+odFg8OKdOHqEZKFt4
 QuBX41Zs7dEFRBFcd97EHIPVYTN47vKXvhSomnks/4U+IFRN2p7J4So4DU+Qq62qsQFYv9Aq71YTp
 sP36GAc2u1g0iKoVkLfuS4hG6WltvMviF5vvsClj0L0X1M4OD2lLfMIyJC9GHPgB8k0TJVQW81X3o
 3Zi12wF5lp2Ag0FT7aTSVLsy2PhZZpx0qIeQAMDdVTd4cY0LHOXJ9wdWcME6SPKruqaZbt10NGV2+
 DD7xQ9Sw==;
Received: from [189.6.35.67] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tqv94-005pIP-De; Sat, 08 Mar 2025 15:27:24 +0100
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, mario.limonciello@amd.com, alex.hung@amd.com,
 siqueira@igalia.com
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: [RFC PATCH 7/7] drm/amd/display: get SADB from drm_eld when parsing
 EDID caps
Date: Sat,  8 Mar 2025 11:26:11 -0300
Message-ID: <20250308142650.35920-8-mwen@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250308142650.35920-1-mwen@igalia.com>
References: <20250308142650.35920-1-mwen@igalia.com>
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

drm_edid_connector_update() updates display info, filling ELD with
speaker allocation data in the last step of update_dislay_info(). Our
goal is stopping using raw edid, so we can extract SADB from drm_eld
instead of access raw edid to get audio caps.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c   | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index a84363ad3c9a..f7f592fa98da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -106,13 +106,10 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	struct edid *edid_buf = edid ? (struct edid *) edid->raw_edid : NULL;
 	struct drm_edid *drm_edid;
 	struct drm_edid_product_id product_id;
-	int sad_count, sadb_count;
+	int sad_count;
 	int i = 0;
-	uint8_t *sadb = NULL;
-
 	enum dc_edid_status result = EDID_OK;
 
-
 	if (!edid_caps || !edid)
 		return EDID_BAD_INPUT;
 
@@ -158,19 +155,11 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 		edid_caps->audio_modes[i].sample_size = sad.byte2;
 	}
 
-	sadb_count = drm_edid_to_speaker_allocation((struct edid *) edid->raw_edid, &sadb);
-
-	if (sadb_count < 0) {
-		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sadb_count);
-		sadb_count = 0;
-	}
-
-	if (sadb_count)
-		edid_caps->speaker_flags = sadb[0];
+	if (connector->eld[DRM_ELD_SPEAKER])
+		edid_caps->speaker_flags = connector->eld[DRM_ELD_SPEAKER];
 	else
 		edid_caps->speaker_flags = DEFAULT_SPEAKER_LOCATION;
 
-	kfree(sadb);
 	drm_edid_free(drm_edid);
 
 	return result;
-- 
2.47.2

