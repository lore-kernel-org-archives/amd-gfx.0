Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB35606A32C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TDe7rbrf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F21210F0CD;
	Wed, 25 Nov 2026 06:55:33 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013057.outbound.protection.outlook.com
 [40.93.196.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 836CC10F120
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyaW+4c2d8JNyD8FQyaiOXj4leSnoi6LRBGAI7kmI82vlkdDYubK+H+f2J8c3di7J4vOKbj85uSUExGltoqVMIuv5Sn8//NHC+6iww656qkh6XpOc+NkE3qrHigLdKjPsRZYyOYiGddb2Yc+u9CwZtZ4hsR6VX2Hxk78nOQFbWZkB9bgTzjmvrarBFYa72yeyQXZoXoZb6frjhthc7wOnVVOwThMuBWIP5Ny3LFiAhmtHtms2qIyDurBqEyKj/L8k/GfoufE0u0R0gyzBtqsVC4NLBHsAH2GDLRKOEfzjuw7JILgk7BWdcX/lo4mDxlN/bSBBP3OtYi82Vb5yUCeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yfhfl7LqB+5mAQpUqr9NqL7FxA/wXjKyyyVGHMzEKo0=;
 b=RI8cxL6NzOmQT7B2qLRaQMKxYBKpmndwynVeDg4NcQuivD2vppQO7dJYI2k92SHmrbOEIBefvYeWsAXjMqL/K31jw4d9nbIYKnVT0qftTY2AeBsxNObzY9JNh5mfftk5lGLRxvd9oUcxn24YH3BC1nWx/WiHONBuhi1mkxEyyJAASoJqKzJ2CyYBl5M8lbX3pblsktFZZE3xnXw+IUeCfsgQf0J3ao9ioBmI9FzC8kCpN/zewMa0roy1/SNLhvN72JgS5UXW2Sp+H0de4XyKUsrDwzW1AfVmuUHeqWNV2TW4ulV3iomAfGNFMAxfFSb5JUcAr0nqvgpsfapZAOVEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfhfl7LqB+5mAQpUqr9NqL7FxA/wXjKyyyVGHMzEKo0=;
 b=TDe7rbrfvcZFQCVrRBczhfGjtzk0bLXbwz4hcH3kSCt1EMEfV7Gj/oo2jeFhb76gTNLBwFIaVUfQ0FmDvjOkh/9IZh8yBbBIxOI6qWKCQ6vp5m/+11i+csq+F0XzJOpp+a/urnLYeGocyJAyeJnYheZfV/lNNys6vyK58gded9M=
Received: from SJ0PR13CA0096.namprd13.prod.outlook.com (2603:10b6:a03:2c5::11)
 by DS5PPF8B1E59479.namprd12.prod.outlook.com (2603:10b6:f:fc00::659)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 25 Nov
 2026 06:55:22 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::2b) by SJ0PR13CA0096.outlook.office365.com
 (2603:10b6:a03:2c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 06:55:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:55:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:55:19 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:55:19 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:55:10 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alan Liu <haoping.liu@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 01/27] drm/amd/display: Avoid per-entry long division in
 __drm_lut32_to_dc_gamma
Date: Wed, 25 Nov 2026 14:54:50 +0800
Message-ID: <20261125065631.3889665-2-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DS5PPF8B1E59479:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9d2b38-73e7-4479-92d8-08df4ac1133c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|22082099003|261009223027099003|18002099003|3023799007|11063799006|56012099006|261102130727099003|261021123027099003|261026121527099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: apcDmVy53D4eb+BaT/mLb1M/5Mtk1yZO5dD2LMr5KqF/blNktPMAuTQJ6XN+mZGYTxoDh2Y4kY6eVhav5yYaFKZxVh0eY0ev8UyVQgOehuD8FYCDrtN0aclHzBeEsNwOY2Go2f7OuUsif8QOEFVf2RjGiEnzbMYvyobg4ht5e1eJnaHPNORgdkPladKCr/HcQB1xRYHW5wnZwBUHBSbp8LQ1RG2BBPGQf4E7dGtvrgWhQQJN8lfDpQXW6FPIH1HrhusfITwQ26BS0f0NK5LfTjTISDwy2901ZiA5vUFJs6whgoUuFuV9+RR4mGVHHiM8h9HJeqXqr+8Y7j0vK23rrlkT2OPAZLKWqmWSYJFb1LnmIu48wyuMrQwnxq2Ifr8RWNN4aHBLw2PnJ8DuViCi4jB4lj2tsfSGylieEnM3sQwHsrVZwIYXPFKUlL8pZNLIJO78R6YvsMnIcrR9o38PxhgEOh3bMcQsKDMrW9IltlRI96byxQoIowKKUuh59uWbQyUHKCQySFWlYgD6uCL4IXXWN9eIsevYXJEXnTsAVnW7ML2igBu6Ugts16IFhbtXiVqczUbA9WEaHgt9eiRSaiR0PRO5f6NiUt4PeKeGfFxyRp+JjAcC+J6tspwZUF7yb8WwpvtBsHTATZbHjQPQic6EGjb9EU1A1lRH6LixvP1u3pWBUyWKxOYN9NQ+nnx6kXLUouqCTSzK7sJcphjtaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(22082099003)(261009223027099003)(18002099003)(3023799007)(11063799006)(56012099006)(261102130727099003)(261021123027099003)(261026121527099003)(261021121427099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O7JM7QwoXYVghqS07wrAR3fieBZMUHYA2t+2f6pFq+3dCG6In0OyEN8xDJD+0p/KcV2H3KrFk9kbE0A2kKK9wEpUGdUtJrjcP4NMM8cJ+2QdIdAe4KngvlcbqVwkLDAnVvaUvQktYl1IFcGrVh3E9Gyf/dJGA0DQ5wmNkkgvJXW3i9TEoX/GfYbPnnpYMp0MwKQQ9S2Tg0/PT1xg3PoMBvl/QMDpVptwkwRwlOQG3dC+Ga7DLBaxsRWJhYgSUwrHsrhv6Wlw3p7O1Zy4fbv2ckkidUG7ztfkW1sxh4ARw5FFq7hbyu9nCbV+hN7upsRb2dz6k3dLFBCM1aWLN2k1AARUECn8EMa8KfD2nqFKbd2vMpTy6iflc09jvKRFR+Jdy8zCyI0aosLEaPjkxT6NFsDdrl9o9pn/n+nIoqr7vTu02ue8qacav9ZE77bhxhOB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:55:22.0519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9d2b38-73e7-4479-92d8-08df4ac1133c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8B1E59479
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alan Liu <haoping.liu@amd.com>

[Why]
__drm_lut32_to_dc_gamma() converts each entry of a 4096-entry 32-bit LUT
with dc_fixpt_from_fraction(v, 0xFFFFFFFF). That helper does a 64-bit
division followed by a 32-iteration bit-by-bit long division, so one LUT
costs 12288 such calls.

When a plane with a 32-bit LUT colorop is recreated in atomic check (for
example on every plane size change), this conversion accounts for ~97%
of amdgpu_dm_update_plane_color_mgmt() time, and it runs for TEST_ONLY
commits as well.

[How]
The denominator is constant, so the result has a closed form:
v * 2^32 / (2^32 - 1) = v + v / (2^32 - 1). The fractional term is below
1 and rounds up exactly when v >= 2^31, so the result is v + (v >= 2^31).

This is bit-exact with the previous dc_fixpt_from_fraction() result for
all 2^32 inputs (checked exhaustively in userspace), so there is no
functional change.

With this change __drm_lut32_to_dc_gamma() takes >99% less time, and
amdgpu_dm_update_plane_color_mgmt() takes ~95% less time per recreated
plane. KUnit amdgpu_dm_color results are unchanged.

Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 45cea72111c7..e09a8a686ec9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -534,6 +534,21 @@ void __drm_lut_to_dc_gamma(const struct drm_color_lut *lut,
 }
 EXPORT_IF_KUNIT(__drm_lut_to_dc_gamma);
 
+/*
+ * Convert a 32-bit DRM LUT value to S31.32 fixed point, i.e. v / 0xFFFFFFFF.
+ *
+ * Bit-exact replacement for dc_fixpt_from_fraction(v, MAX_DRM_LUT32_VALUE),
+ * which does a 64-bit division plus a 32-iteration long division per value.
+ * With d = 2^32 - 1:  v * 2^32 / d = v + v / d,  and v / d is in [0, 1], so
+ * the rounded result is v + 1 when v / d >= 1/2, i.e. when v >= 2^31.
+ */
+static inline struct fixed31_32 __drm_lut32_value_to_fixpt(u32 v)
+{
+	struct fixed31_32 res = { .value = (long long)v + (v >= 0x80000000u) };
+
+	return res;
+}
+
 /**
  * __drm_lut32_to_dc_gamma - convert the drm_color_lut to dc_gamma.
  * @lut: DRM lookup table for color conversion
@@ -547,9 +562,9 @@ void __drm_lut32_to_dc_gamma(const struct drm_color_lut32 *lut, struct dc_gamma
 	int i;
 
 	for (i = 0; i < MAX_COLOR_LUT_ENTRIES; i++) {
-		gamma->entries.red[i] = dc_fixpt_from_fraction(lut[i].red, MAX_DRM_LUT32_VALUE);
-		gamma->entries.green[i] = dc_fixpt_from_fraction(lut[i].green, MAX_DRM_LUT32_VALUE);
-		gamma->entries.blue[i] = dc_fixpt_from_fraction(lut[i].blue, MAX_DRM_LUT32_VALUE);
+		gamma->entries.red[i] = __drm_lut32_value_to_fixpt(lut[i].red);
+		gamma->entries.green[i] = __drm_lut32_value_to_fixpt(lut[i].green);
+		gamma->entries.blue[i] = __drm_lut32_value_to_fixpt(lut[i].blue);
 	}
 }
 EXPORT_IF_KUNIT(__drm_lut32_to_dc_gamma);
-- 
2.43.0

