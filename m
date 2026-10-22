Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F8606A31F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 07:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E845C1129E3;
	Fri, 23 Oct 2026 07:49:55 +0000 (UTC)
X-Greylist: delayed 526 seconds by postgrey-1.36 at gabe;
 Thu, 22 Oct 2026 15:11:56 UTC
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 834741126F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 15:11:56 +0000 (UTC)
Received: by sym2.noone.org (Postfix, from userid 1002)
 id 4j9Tt33phyz2Ftly; Thu, 22 Oct 2026 17:03:02 +0200 (CEST)
From: Tobias Klauser <tklauser@distanz.ch>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amd/ras: omit redundant memset of already-zeroed buffers
Date: Thu, 22 Oct 2026 17:03:02 +0200
Message-Id: <20261022150302.27962-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:49:55 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Both of these are allocated with kzalloc() right before memset(), so
the buffer is already zeroed and the memset() is redundant.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/gpu/drm/amd/ras/core/eeprom.c                 | 1 -
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/ras/core/eeprom.c
index 40430f0b4d2e..cfefbe848033 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
@@ -1091,7 +1091,6 @@ static int ras_eeprom_sw_init(struct ras_core_context *ras_core,
 		return -ENOMEM;
 
 	mgr->ras_eeprom = control;
-	memset(control, 0, sizeof(*control));
 
 	control->mgr = mgr;
 	control->max_read_len = param->max_i2c_read_len;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 1e83cb5064ff..f021719ff0a8 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -298,8 +298,6 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 		return RAS_CMD__ERROR_GENERIC;
 	}
 
-	memset(out_buf, 0, req->buf_size);
-
 	for (i = 0; i < req->cper_num; i++) {
 		batch_id = req->cper_start_id + i;
 		if (batch_id >= overview->last_batch_id)
-- 
2.55.0

