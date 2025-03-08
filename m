Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659D8C282EC
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Mar 2025 14:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D773210E1D4;
	Sat,  8 Mar 2025 14:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="VzgzqdxU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E422910E1D4
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Mar 2025 14:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ONXnpc0csUhq+8tINyPARHAWK6z1fCYVi1oA5YzElrM=; b=VzgzqdxUvsx+rScFgepxHu9pP1
 uYEx5GIGvpSaLQFB9p9I7db0Pld2OoqsWgfwmkmopjojk8nCGI23vvOBSwhWbcoi5hpeVbV/9noCw
 DY9CeyugErkfo1VsAaZAbEA5jwnhAH5iL+Gqf5lFX1e8HPcKwI1shOm+SGV9HyfmoYTdnUq4Ay213
 3U793w8kDwtbV2ufVivFQ+NcTCSqtIeUvE/pnKOhZV4nd5rQIOjIGACGTOBaGLpJK97lAG6m9sbdF
 sqVB8gjbDcL830LcF6MZMkUaSXMJNj/O8/uRhSokOX88y3YwTnKSCx+E3YaPLPY2yZVladdIfuYJ9
 /I+clW+g==;
Received: from [189.6.35.67] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tqv8k-005pIP-OR; Sat, 08 Mar 2025 15:27:05 +0100
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, mario.limonciello@amd.com, alex.hung@amd.com,
 siqueira@igalia.com
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: [RFC PATCH 2/7] drm/amd/display: start using drm_edid helpers to
 parse EDID caps
Date: Sat,  8 Mar 2025 11:26:06 -0300
Message-ID: <20250308142650.35920-3-mwen@igalia.com>
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

Groundwork that allocates a temporary drm_edid from raw edid to take
advantage of DRM common-code helpers instead of driver-specific code.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 2cd35392e2da..7edc23267ee7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -108,6 +108,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
 	struct edid *edid_buf = edid ? (struct edid *) edid->raw_edid : NULL;
+	struct drm_edid *drm_edid;
 	struct cea_sad *sads;
 	int sad_count = -1;
 	int sadb_count = -1;
@@ -116,10 +117,13 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	enum dc_edid_status result = EDID_OK;
 
+
 	if (!edid_caps || !edid)
 		return EDID_BAD_INPUT;
 
-	if (!drm_edid_is_valid(edid_buf))
+	drm_edid = drm_edid_alloc(edid_buf, EDID_LENGTH * (edid_buf->extensions + 1));
+
+	if (!drm_edid_valid(drm_edid))
 		result = EDID_BAD_CHECKSUM;
 
 	edid_caps->manufacturer_id = (uint16_t) edid_buf->mfg_id[0] |
@@ -139,8 +143,10 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	apply_edid_quirks(dev, edid_buf, edid_caps);
 
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
-	if (sad_count <= 0)
+	if (sad_count <= 0) {
+		drm_edid_free(drm_edid);
 		return result;
+	}
 
 	edid_caps->audio_mode_count = min(sad_count, DC_MAX_AUDIO_DESC_COUNT);
 	for (i = 0; i < edid_caps->audio_mode_count; ++i) {
@@ -166,6 +172,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	kfree(sads);
 	kfree(sadb);
+	drm_edid_free(drm_edid);
 
 	return result;
 }
-- 
2.47.2

