Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7948C04FF9
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 13:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5417910F091;
	Tue, 16 Apr 2024 13:34:36 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A212D10F0A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 13:34:34 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 43GDYR2s003402; Tue, 16 Apr 2024 19:04:27 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 43GDYRnh003401;
 Tue, 16 Apr 2024 19:04:27 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 3/5] drm/amdgpu: Add IH_RING1_CFG headers for IH v6.0
Date: Tue, 16 Apr 2024 19:04:21 +0530
Message-Id: <20240416133423.3346-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416133423.3346-1-sunil.khatri@amd.com>
References: <20240416133423.3346-1-sunil.khatri@amd.com>
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

Add offsets, mask and shift macros for IH v6.0
which are needed to configure ring1 client irq
redirection.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../drm/amd/include/asic_reg/oss/osssys_6_0_0_offset.h |  4 ++++
 .../amd/include/asic_reg/oss/osssys_6_0_0_sh_mask.h    | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_6_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_6_0_0_offset.h
index 8b931bbabe70..969e006b859b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_6_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_6_0_0_offset.h
@@ -237,6 +237,10 @@
 #define regSEM_REGISTER_LAST_PART2_BASE_IDX                                                             0
 #define regIH_CLIENT_CFG                                                                                0x0184
 #define regIH_CLIENT_CFG_BASE_IDX                                                                       0
+#define regIH_RING1_CLIENT_CFG_INDEX                                                                    0x0185
+#define regIH_RING1_CLIENT_CFG_INDEX_BASE_IDX                                                           0
+#define regIH_RING1_CLIENT_CFG_DATA                                                                     0x0186
+#define regIH_RING1_CLIENT_CFG_DATA_BASE_IDX                                                            0
 #define regIH_CLIENT_CFG_INDEX                                                                          0x0188
 #define regIH_CLIENT_CFG_INDEX_BASE_IDX                                                                 0
 #define regIH_CLIENT_CFG_DATA                                                                           0x0189
diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_6_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_6_0_0_sh_mask.h
index f262f44fa68c..a672a91e58f0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_6_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_6_0_0_sh_mask.h
@@ -888,6 +888,16 @@
 //IH_CLIENT_CFG
 #define IH_CLIENT_CFG__TOTAL_CLIENT_NUM__SHIFT                                                                0x0
 #define IH_CLIENT_CFG__TOTAL_CLIENT_NUM_MASK                                                                  0x0000003FL
+//IH_RING1_CLIENT_CFG_INDEX
+#define IH_RING1_CLIENT_CFG_INDEX__INDEX__SHIFT                                                               0x0
+#define IH_RING1_CLIENT_CFG_INDEX__INDEX_MASK                                                                 0x00000007L
+//IH_RING1_CLIENT_CFG_DATA
+#define IH_RING1_CLIENT_CFG_DATA__CLIENT_ID__SHIFT                                                            0x0
+#define IH_RING1_CLIENT_CFG_DATA__SOURCE_ID__SHIFT                                                            0x8
+#define IH_RING1_CLIENT_CFG_DATA__SOURCE_ID_MATCH_ENABLE__SHIFT                                               0x10
+#define IH_RING1_CLIENT_CFG_DATA__CLIENT_ID_MASK                                                              0x000000FFL
+#define IH_RING1_CLIENT_CFG_DATA__SOURCE_ID_MASK                                                              0x0000FF00L
+#define IH_RING1_CLIENT_CFG_DATA__SOURCE_ID_MATCH_ENABLE_MASK                                                 0x00010000L
 //IH_CLIENT_CFG_INDEX
 #define IH_CLIENT_CFG_INDEX__INDEX__SHIFT                                                                     0x0
 #define IH_CLIENT_CFG_INDEX__INDEX_MASK                                                                       0x0000001FL
-- 
2.34.1

