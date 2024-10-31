Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBB3D767F7
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 18:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC5110E8FF;
	Thu, 31 Oct 2024 18:04:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k9e42Vkt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 482C810E8FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 18:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgrsiN2MYtAbillcfyrw94qSmjdNLRd7fO5x+gZeYBbX6XLd64ljQdQScsNbSlbU05lreHuHhDq1x4w8choVXCbTxtGaYpwS2BmwkTHgBZ3RcO/WrIa1+CMmd3RbIw9G+cUT0xpgwzYNy6APXjQZIerannTsGXTg45ILfjS/RFqvviRySFWXkThc/vTbI6dmVt19OoIFS2MNv3nCcWqRDE/3Lqj5H4nWyTjoUDbCacfsMQdm6MoNiXqgIg0wXsTyVQUm6+tE2WvTH0WMbWD6Vpt4Km/cwyvTB+l15uBw7d918RRr7jEkv7IJiqfsl/pT3GTU4v5CKVredIVUZFrTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dq7bAFcWcte/ayE/oT37w8fAUL2BIGD0I4kbKdQnkkU=;
 b=DWLI20KIpD0EfYsgVSZCbR55J2Mt42xWCpUJociJxnX+IOiQ13F7kcTtQkkEEIqIitdI4X6dhgY5rxz1gNwEKG9FoNR4Xcv60zvcJzfGFrPqhCZ215jlQ/BRPdMzgRlDkU7h9Hx6VnkZacmGsz4seLLCbpNIvqbTepxzUyXcQZF89peGRYuXRe9go+WrJ/a6g+Krs4jGDhl1HYeqH4GxqM1oh38UV7CpQBDFpV/SST56Zf2IngWOHOMPwl/j7Hn1BIEijBNkVK3wG++2HoTfS46Mg8J5/nYKDiABs7eoeHu4xjEUYzX24DhiJCh6EVA08kwO9Qjjd+7CEyKpWoZQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq7bAFcWcte/ayE/oT37w8fAUL2BIGD0I4kbKdQnkkU=;
 b=k9e42VktzOcqGvt5axQ7IngQ7XRU3uhAAkvbliUezKGkW6L8TkKvEPNS6wO3jbJ6r6mAkXLMDPfbGJ8F3ON//EBaol3tPvt633lpIOoO3GXTJOff4YWyYOoEqauS+LzmABd7FITOpFeuLjBg2HlEK3afAmdNbxr4d0Uo+pjsw4s=
Received: from MW4PR03CA0170.namprd03.prod.outlook.com (2603:10b6:303:8d::25)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 18:04:51 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::d9) by MW4PR03CA0170.outlook.office365.com
 (2603:10b6:303:8d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 18:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:04:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:04:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amd/display: add non-DC drm_panic support
Date: Thu, 31 Oct 2024 14:04:30 -0400
Message-ID: <20241031180430.3993389-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031180430.3993389-1-alexander.deucher@amd.com>
References: <20241031180430.3993389-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: c30034e1-2ad8-47df-78f6-08dcf9d683f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qBKBQZXrIagYaZwk4d0ykeWVfTatH2wBVg5MsxRrIafDtC6MjjoN5k9gEHta?=
 =?us-ascii?Q?UPmcyMCBQ3N6n1WOD8ihUEQHsYISAPefokrNEwc1Vb2fBAoceg8Q9Ednmyyq?=
 =?us-ascii?Q?2durnuti7+Z7/VJs6xGRCVeKz1n7o1NslJb5PhNKFKOM6pZ0t+InVmSLa86J?=
 =?us-ascii?Q?er6aLnBz4Fu0gipMmHZd4iTBCFop07pYbDEjovcGz/179b3okGzSy+KbB/zY?=
 =?us-ascii?Q?Pdu6qzYCSp2gopdx51MyOXUmsRU5cyEeYIX5WcVs0xEw/Twrdp8dclqvfaZg?=
 =?us-ascii?Q?qSGGxJSLPlKetdKvJSvYZt1d34bXjgMSBrtluv+KZZX3J5INCwGSBD+4eqZ0?=
 =?us-ascii?Q?uv37or7eWpVz+P4xStId7bpm1wqRKNfhk+s2fZSrgXqhINFHJkRCcTfXQLxj?=
 =?us-ascii?Q?8lC3GxfDOOn4/wDqcO0WjcnFmI6psyZI9MsDkOV3d6otIzvb7s6dpw1rV3Ft?=
 =?us-ascii?Q?A1t2q3WSElnhFbnLns1NMBwpkBdoKr1Jn/m8EGg4rgTymmguZ67X++S7z299?=
 =?us-ascii?Q?dD19os1uMTBBmbTnn+ym+fEScgwp23/bAdmawmNpEKHrMKaHJXoJYMhAne+5?=
 =?us-ascii?Q?4A7Gy9i0e6hvRWWx1qhW0vyrjVz//fEPjc8BtgqAKGj8v5Fj6wpVErGN/dRs?=
 =?us-ascii?Q?YciLJBDBWvnD1RM1maVZKPsO8eDMgR5pKzs2nwKq3+M9sycyiY00944DfRXD?=
 =?us-ascii?Q?v3VVBGSQmG+zPrFCtB6IMrICDKTj/6yYcp9HVsUlksQSB5UCimxA0m82UgML?=
 =?us-ascii?Q?2IAdFq40e4/nCYIhPo+UQffHN0WKqYRRsl7SSi3Fib+IGYaGyzFEqKUEby3i?=
 =?us-ascii?Q?gq/Q5dIS6SaWewPSLKjKCxRzl3syDv8Ns/u8A2GMsThBhgooyl3VSpE1vfU3?=
 =?us-ascii?Q?YNITLtiLPYgLV7LExBYbVidJjlpFqBqg1Euj3XNiL1ErKOAB6afo6NYrACUm?=
 =?us-ascii?Q?ZuBcoys6xZr3dU5xVPC5LuzWasFlEUp39bzJ0lb4JqvhJuVBYQO3qoMdi0HR?=
 =?us-ascii?Q?F491L03twXXjtRoFJnAVhEmoBmL3C5mzz/NQrPOa0vKVKcR96DCQouzVO+9H?=
 =?us-ascii?Q?XevFdNDKtezISMI01LGU23g5A/S8/l0apXYnxEk2hwfi2jo9UC2KrIUzHzfj?=
 =?us-ascii?Q?GCU+pkPUyfe7spzFu+7K1/XWNq5rntMbqGTsusWxu3iyjCUsL9+rfMJb9/Ie?=
 =?us-ascii?Q?f2W0U6ZKmdk3Zzxuawy5muN1gNm7SdiES5XktCL1Hft6d8tnCW69Yo38T//h?=
 =?us-ascii?Q?zIyADm5r2Deo+jMDpnFWDiad1mgpMC4d1xBCPDHZX46EEFMDP+HCmuFq7Gyg?=
 =?us-ascii?Q?KKvTYfO+RoU+euron2nNLvMNu4VYGkCwHDjKkjqgtiDsegGz4PnzMnH8RgrO?=
 =?us-ascii?Q?ox4cXP39f1MHb4Im8kMqZTbGXTL5mq0u4ZgSBG0m7CgA+X/Lgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:04:51.0556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30034e1-2ad8-47df-78f6-08dcf9d683f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
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

Add support for the drm_panic module, which displays a pretty user
friendly message on the screen when a Linux kernel panic occurs.

Adapt Lu Yao's code to use common helpers derived from
Jocelyn's patch.  This extends the non-DC code to enable
access to non-CPU accessible VRAM and adds support for
other DCE versions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lu Yao <yaolu@kylinos.cn>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 27 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 27 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 27 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 26 +++++++++++++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 5098c50d54c8..a26f2381504b 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2687,6 +2687,32 @@ static const struct drm_crtc_helper_funcs dce_v10_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static void dce_v10_0_panic_flush(struct drm_plane *plane)
+{
+	struct drm_framebuffer *fb;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_device *adev;
+	uint32_t fb_format;
+
+	if (!plane->fb)
+		return;
+
+	fb = plane->fb;
+	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
+	adev = drm_to_adev(fb->dev);
+
+	/* Disable DC tiling */
+	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
+	fb_format &= ~GRPH_CONTROL__GRPH_ARRAY_MODE_MASK;
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+
+}
+
+static const struct drm_plane_helper_funcs dce_v10_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
+	.panic_flush = dce_v10_0_panic_flush,
+};
+
 static int dce_v10_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2734,6 +2760,7 @@ static int dce_v10_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v10_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v10_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index c5680ff4ab9f..d02c754a92b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2800,6 +2800,32 @@ static const struct drm_crtc_helper_funcs dce_v11_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static void dce_v11_0_panic_flush(struct drm_plane *plane)
+{
+	struct drm_framebuffer *fb;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_device *adev;
+	uint32_t fb_format;
+
+	if (!plane->fb)
+		return;
+
+	fb = plane->fb;
+	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
+	adev = drm_to_adev(fb->dev);
+
+	/* Disable DC tiling */
+	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
+	fb_format &= ~GRPH_CONTROL__GRPH_ARRAY_MODE_MASK;
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+
+}
+
+static const struct drm_plane_helper_funcs dce_v11_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
+	.panic_flush = dce_v11_0_panic_flush,
+};
+
 static int dce_v11_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2847,6 +2873,7 @@ static int dce_v11_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v11_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v11_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index eb7de9122d99..fab1145254aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2602,6 +2602,32 @@ static const struct drm_crtc_helper_funcs dce_v6_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static void dce_v6_0_panic_flush(struct drm_plane *plane)
+{
+	struct drm_framebuffer *fb;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_device *adev;
+	uint32_t fb_format;
+
+	if (!plane->fb)
+		return;
+
+	fb = plane->fb;
+	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
+	adev = drm_to_adev(fb->dev);
+
+	/* Disable DC tiling */
+	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
+	fb_format &= ~GRPH_ARRAY_MODE(0x7);
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+
+}
+
+static const struct drm_plane_helper_funcs dce_v6_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
+	.panic_flush = dce_v6_0_panic_flush,
+};
+
 static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2629,6 +2655,7 @@ static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v6_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v6_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 04b79ff87f75..a130d49da8f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2613,6 +2613,31 @@ static const struct drm_crtc_helper_funcs dce_v8_0_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static void dce_v8_0_panic_flush(struct drm_plane *plane)
+{
+	struct drm_framebuffer *fb;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_device *adev;
+	uint32_t fb_format;
+
+	if (!plane->fb)
+		return;
+
+	fb = plane->fb;
+	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
+	adev = drm_to_adev(fb->dev);
+
+	/* Disable DC tiling */
+	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
+	fb_format &= ~GRPH_CONTROL__GRPH_ARRAY_MODE_MASK;
+	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
+}
+
+static const struct drm_plane_helper_funcs dce_v8_0_drm_primary_plane_helper_funcs = {
+	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
+	.panic_flush = dce_v8_0_panic_flush,
+};
+
 static int dce_v8_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
@@ -2640,6 +2665,7 @@ static int dce_v8_0_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
 	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v8_0_crtc_helper_funcs);
+	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v8_0_drm_primary_plane_helper_funcs);
 
 	return 0;
 }
-- 
2.47.0

