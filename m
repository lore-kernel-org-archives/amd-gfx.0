Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D934C0015E
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Jul 2023 15:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D741D10E168;
	Sat, 15 Jul 2023 15:27:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA6A10E16A
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Jul 2023 15:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9wGAStHIO+9iDhZWgxv4XtAPQZ/iYVnLx8DCVZRG3Xl6FAb01FYdPvp66XcBfGi45/BEFSSCW1fHPvYiKF6QvvLF5hZyXKCa6Q4ULEnc8/4ediH0miPc8PcQImClpH/oqHorplPy+7kuVIEnPp5vElfU3J8Kqh4tNlJE3U8csMrA2jQdyTpqbT77jlshMVB5tf/WwR5/8BPCrKnOBPpio9kqHfXw72OrQy+hEBs3eZ3y/dcZTcRxUJxu0hznVUc+UkxmZv1UtYMdlfh5Rt9QjTEKAxvYu/cxIjXcuNKfKuaE19dzS8ZrbkP/1NWJo2LXz6h7D9W6yEzwVR3JL0f+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b4TVPL56PNEI/+YkbYmVPPHw89zwuuzbtsS4BbjIBQ=;
 b=Q37Nybdh3vZFTmmmR9umJftNq5OK3dbRtzQwfVCiiOUyJ3bIo180VxkY7mvQC1/KXUpdDK7YZEkGBg3bAk/bhzUZNHx7AlQWZXRyyvbTQPOYbJmuneMJpTSjJ6vR9igcYj/v8eyWvYW6oG8S4GfOOTpdRJIP246FgEZwXaAV9baywgC22C84IVnS1rcE2eptV2ikr8NJOsggqogddCla3n6HDnoE/A82O4uYbww6T8eFidkEqB+HUB44CicS3VBh+Fe0Din2otHYeQ5h1d63jXnnX8EunOHBS8B7uznL5/Oj1GFSWbifAndwA5sUcbN1jxgG+P/czUh8Mf4fkpaA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b4TVPL56PNEI/+YkbYmVPPHw89zwuuzbtsS4BbjIBQ=;
 b=s4xCrEoU9xr+Xn7QIGh0v5odSKhFXPQeg2uKtibkl6AeR3QM32TpT8IKQCUV/+wQ1pubu/MHM3FsuFhklEmqwVb0pwz+mQToB+XBEItMZgr2XPI4bnqM/9CfutYKpvpp6VwBd2BilWGLiVIMHgoMIluKxP7RsuQCXoCO36JYpiI=
Received: from DM6PR02CA0116.namprd02.prod.outlook.com (2603:10b6:5:1b4::18)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 15:27:14 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::36) by DM6PR02CA0116.outlook.office365.com
 (2603:10b6:5:1b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28 via Frontend
 Transport; Sat, 15 Jul 2023 15:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.28 via Frontend Transport; Sat, 15 Jul 2023 15:27:14 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 15 Jul
 2023 10:27:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/radeon: Fix style issues in radeon _encoders.c & _gart.c
Date: Sat, 15 Jul 2023 20:56:57 +0530
Message-ID: <20230715152657.946783-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bac3b8d-9faf-4982-dba8-08db8547f787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UN/F6P5/p1B5iLa9pAUkGihqhlm6j6O4AbppdEpAOc4JYKI+aJq9tey7JvfelWuXiGDkHK7V0kbbFitBI+JSNrXhIrgbT9voFyqaQWr05tGiqoBkxSOa4os1gieQl3f98WlhXdsFVR/uukm0DeUZnXe6pysIzHejHuHM4PPuCCCZ3vJof7L9H0c0b6nbHu3L2eKESE/tZUPtNEa7EuK0xM174CasXwZdXyhMU5NCkiwGywMrujP33Fz4m5kxRRQbp6i2FWQIcGCkEVkolpVKAXtOH/As7j52qKLmjdVuD+Ykswm1Xylp2Ys5pTYJ8bbjMRha1VZzT21mIFRDpXyq1LIB5oPAjMjhX75lJwfV8vjcy4RFGKTWmDNcd0L+He8RCuUg+qGeNIy6KiuH3UUW+lM+eQeMAP1Lcnnhor3qjqnj/scnHhf+qpjsuyxn94o4LSpR3RDZgzIbQa6upRJbBtpmWCTYL2KjXZc2TNjzBOKMlsHqB9K4eq1bLLROwt6E43EEQlQijrh/l268zzPkGT5evg9I9STQXbroMJu8bFWXAvAar1wtmiQheV6TsChW9RDCHucEE4VmHf5yT5bycsfCeQpwnrYggL6XKNNcklg+yoR4V0qxUf8C/1CP1cFRndMCZDtNWFnrbtheVVoBukpywYg/1cLbjXtD/n0sLftDISAXOm9Nk+HtiaWTY54YTfQeojAOSChlmIWO+3noNkxkXDtjOGPPNbBaSUHf/ZI7vpGxDAqrNgvGQTRcE7dkdl51RVyXi94EkEFrcvlrgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(40480700001)(2616005)(40460700003)(7696005)(6666004)(356005)(86362001)(478600001)(81166007)(36756003)(26005)(1076003)(82740400003)(316002)(8936002)(8676002)(41300700001)(44832011)(54906003)(110136005)(2906002)(4326008)(6636002)(5660300002)(70206006)(70586007)(186003)(16526019)(336012)(83380400001)(36860700001)(47076005)(66574015)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 15:27:14.4324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bac3b8d-9faf-4982-dba8-08db8547f787
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Conform to Linux kernel coding style.

Fixes the following & other checks in radeon_encoders.c & radeon_gart.c:

WARNING: Missing a blank line after declarations
WARNING: Block comments use * on subsequent lines
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: braces {} are not necessary for single statement blocks

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/radeon_encoders.c | 22 +++++++------
 drivers/gpu/drm/radeon/radeon_gart.c     | 39 ++++++++++++------------
 2 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_encoders.c b/drivers/gpu/drm/radeon/radeon_encoders.c
index b3518a8f95a0..9cb6401fe97e 100644
--- a/drivers/gpu/drm/radeon/radeon_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_encoders.c
@@ -58,6 +58,7 @@ static uint32_t radeon_encoder_clones(struct drm_encoder *encoder)
 	count = -1;
 	list_for_each_entry(clone_encoder, &dev->mode_config.encoder_list, head) {
 		struct radeon_encoder *radeon_clone = to_radeon_encoder(clone_encoder);
+
 		count++;
 
 		if (clone_encoder == encoder)
@@ -108,9 +109,10 @@ radeon_get_encoder_enum(struct drm_device *dev, uint32_t supported_device, uint8
 			if (ASIC_IS_AVIVO(rdev))
 				ret = ENCODER_INTERNAL_KLDSCP_DAC2_ENUM_ID1;
 			else {
-				/*if (rdev->family == CHIP_R200)
-				  ret = ENCODER_INTERNAL_DVO1_ENUM_ID1;
-				  else*/
+				/* if (rdev->family == CHIP_R200)
+				 * ret = ENCODER_INTERNAL_DVO1_ENUM_ID1;
+				 * else
+				 */
 				ret = ENCODER_INTERNAL_DAC2_ENUM_ID1;
 			}
 			break;
@@ -234,6 +236,7 @@ void radeon_encoder_set_active_device(struct drm_encoder *encoder)
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 		if (connector->encoder == encoder) {
 			struct radeon_connector *radeon_connector = to_radeon_connector(connector);
+
 			radeon_encoder->active_device = radeon_encoder->devices & radeon_connector->devices;
 			DRM_DEBUG_KMS("setting active device to %08x from %08x %08x for encoder %d\n",
 				  radeon_encoder->active_device, radeon_encoder->devices,
@@ -320,12 +323,12 @@ void radeon_panel_mode_fixup(struct drm_encoder *encoder,
 	struct drm_device *dev = encoder->dev;
 	struct radeon_device *rdev = dev->dev_private;
 	struct drm_display_mode *native_mode = &radeon_encoder->native_mode;
-	unsigned hblank = native_mode->htotal - native_mode->hdisplay;
-	unsigned vblank = native_mode->vtotal - native_mode->vdisplay;
-	unsigned hover = native_mode->hsync_start - native_mode->hdisplay;
-	unsigned vover = native_mode->vsync_start - native_mode->vdisplay;
-	unsigned hsync_width = native_mode->hsync_end - native_mode->hsync_start;
-	unsigned vsync_width = native_mode->vsync_end - native_mode->vsync_start;
+	unsigned int hblank = native_mode->htotal - native_mode->hdisplay;
+	unsigned int vblank = native_mode->vtotal - native_mode->vdisplay;
+	unsigned int hover = native_mode->hsync_start - native_mode->hdisplay;
+	unsigned int vover = native_mode->vsync_start - native_mode->vdisplay;
+	unsigned int hsync_width = native_mode->hsync_end - native_mode->hsync_start;
+	unsigned int vsync_width = native_mode->vsync_end - native_mode->vsync_start;
 
 	adjusted_mode->clock = native_mode->clock;
 	adjusted_mode->flags = native_mode->flags;
@@ -424,6 +427,7 @@ bool radeon_dig_monitor_is_duallink(struct drm_encoder *encoder,
 bool radeon_encoder_is_digital(struct drm_encoder *encoder)
 {
 	struct radeon_encoder *radeon_encoder = to_radeon_encoder(encoder);
+
 	switch (radeon_encoder->encoder_id) {
 	case ENCODER_OBJECT_ID_INTERNAL_LVDS:
 	case ENCODER_OBJECT_ID_INTERNAL_TMDS1:
diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/radeon/radeon_gart.c
index 04109a2a6fd7..96de98be65f4 100644
--- a/drivers/gpu/drm/radeon/radeon_gart.c
+++ b/drivers/gpu/drm/radeon/radeon_gart.c
@@ -74,9 +74,9 @@ int radeon_gart_table_ram_alloc(struct radeon_device *rdev)
 
 	ptr = dma_alloc_coherent(&rdev->pdev->dev, rdev->gart.table_size,
 				 &rdev->gart.table_addr, GFP_KERNEL);
-	if (ptr == NULL) {
+	if (!ptr)
 		return -ENOMEM;
-	}
+
 #ifdef CONFIG_X86
 	if (rdev->family == CHIP_RS400 || rdev->family == CHIP_RS480 ||
 	    rdev->family == CHIP_RS690 || rdev->family == CHIP_RS740) {
@@ -99,9 +99,9 @@ int radeon_gart_table_ram_alloc(struct radeon_device *rdev)
  */
 void radeon_gart_table_ram_free(struct radeon_device *rdev)
 {
-	if (rdev->gart.ptr == NULL) {
+	if (!rdev->gart.ptr)
 		return;
-	}
+
 #ifdef CONFIG_X86
 	if (rdev->family == CHIP_RS400 || rdev->family == CHIP_RS480 ||
 	    rdev->family == CHIP_RS690 || rdev->family == CHIP_RS740) {
@@ -133,9 +133,8 @@ int radeon_gart_table_vram_alloc(struct radeon_device *rdev)
 		r = radeon_bo_create(rdev, rdev->gart.table_size,
 				     PAGE_SIZE, true, RADEON_GEM_DOMAIN_VRAM,
 				     0, NULL, NULL, &rdev->gart.robj);
-		if (r) {
+		if (r)
 			return r;
-		}
 	}
 	return 0;
 }
@@ -197,9 +196,9 @@ void radeon_gart_table_vram_unpin(struct radeon_device *rdev)
 {
 	int r;
 
-	if (rdev->gart.robj == NULL) {
+	if (!rdev->gart.robj)
 		return;
-	}
+
 	r = radeon_bo_reserve(rdev->gart.robj, false);
 	if (likely(r == 0)) {
 		radeon_bo_kunmap(rdev->gart.robj);
@@ -220,9 +219,9 @@ void radeon_gart_table_vram_unpin(struct radeon_device *rdev)
  */
 void radeon_gart_table_vram_free(struct radeon_device *rdev)
 {
-	if (rdev->gart.robj == NULL) {
+	if (!rdev->gart.robj)
 		return;
-	}
+
 	radeon_bo_unref(&rdev->gart.robj);
 }
 
@@ -239,11 +238,11 @@ void radeon_gart_table_vram_free(struct radeon_device *rdev)
  * Unbinds the requested pages from the gart page table and
  * replaces them with the dummy page (all asics).
  */
-void radeon_gart_unbind(struct radeon_device *rdev, unsigned offset,
+void radeon_gart_unbind(struct radeon_device *rdev, unsigned int offset,
 			int pages)
 {
-	unsigned t;
-	unsigned p;
+	unsigned int t;
+	unsigned int p;
 	int i, j;
 
 	if (!rdev->gart.ready) {
@@ -284,12 +283,12 @@ void radeon_gart_unbind(struct radeon_device *rdev, unsigned offset,
  * (all asics).
  * Returns 0 for success, -EINVAL for failure.
  */
-int radeon_gart_bind(struct radeon_device *rdev, unsigned offset,
+int radeon_gart_bind(struct radeon_device *rdev, unsigned int offset,
 		     int pages, struct page **pagelist, dma_addr_t *dma_addr,
 		     uint32_t flags)
 {
-	unsigned t;
-	unsigned p;
+	unsigned int t;
+	unsigned int p;
 	uint64_t page_base, page_entry;
 	int i, j;
 
@@ -307,9 +306,9 @@ int radeon_gart_bind(struct radeon_device *rdev, unsigned offset,
 		for (j = 0; j < (PAGE_SIZE / RADEON_GPU_PAGE_SIZE); j++, t++) {
 			page_entry = radeon_gart_get_page_entry(page_base, flags);
 			rdev->gart.pages_entry[t] = page_entry;
-			if (rdev->gart.ptr) {
+			if (rdev->gart.ptr)
 				radeon_gart_set_page(rdev, t, page_entry);
-			}
+
 			page_base += RADEON_GPU_PAGE_SIZE;
 		}
 	}
@@ -332,9 +331,9 @@ int radeon_gart_init(struct radeon_device *rdev)
 {
 	int r, i;
 
-	if (rdev->gart.pages) {
+	if (rdev->gart.pages)
 		return 0;
-	}
+
 	/* We need PAGE_SIZE >= RADEON_GPU_PAGE_SIZE */
 	if (PAGE_SIZE < RADEON_GPU_PAGE_SIZE) {
 		DRM_ERROR("Page size is smaller than GPU page size!\n");
-- 
2.25.1

