Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CA3C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 09:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6099510E318;
	Mon, 16 Jun 2025 09:39:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g3616bCW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB5E10E318
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 09:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCrY3+qo9uZ9RWF/VaV+HmjF2hHf7UGOkJzRmM7vPbeVTc4yQ3Is0VHYV5Zcz7d2yA4qjsc29JLeQrsw2CXjAONPYEv92N5HumiqmBVPpNMtfuaAhz5YzHGsZRgkHkfMpZFPHqbcnwYk75/FkmVQuUPy0Vdc/hLBg0KTgOF5xRwiJFKNVuKeC3xLJwVFutOVU69VDieRZqre+ktwdw20kJgvMFh8q3sqpiJyQgCIvYJihHA69Q/xggSMR+3M5lbXY44QO/3vkYZLis3X4i64DxLbpcK9lXAcBaGyi/Ebsb/qAWdQu/R8LOQKBU2xyBjDikrSjMtUgGvATX5QCc6s8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mkq3zxFwJnB0jlpL9tbqHyQfEpZ2d0wEB0NWizTn50=;
 b=hOKHi+9z7UlVd+y4V4Gq1A31zOT4FkETlfH5S1TxsvxBmnwpUPwmoqfxI+YZts/G3LsbIOZ/Im8AX9Dja0m7XBkVAzfmiDCftLi6V1LeoKdBsqT4jji+BpUh8yx/6+YfGtmk6/ZMq9ApnkpTG1zE9+XQJ8DA6sOpy51zCncB9MNN2f6lLSI7ISIEpIZwxY8wDRjAntduztgXUkL1EO2yQQXxrf/bD61oQ5LK6WL50R/jzzj+6rs6Z71a7w9AY/W0VUk7fajXCaa+bRhQXdCIzR/DRkcYxRCr3GCoIoEnl2R4uqSrOEaF0BRLPga+lCFUNzwrjAst1ooOpKFw2PRUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mkq3zxFwJnB0jlpL9tbqHyQfEpZ2d0wEB0NWizTn50=;
 b=g3616bCWgUNqAi5mW4blUG5+yeCsUTY/EvG55U6xv5oGrunNhBXQoWYn6e8yfm620Bld+H5cqpwmlm74OWbAVaAd8InNA+XVg3ARSrej1TAoxbqX4aI+zlOcgZ0q9lp4y2j9gEciTN393U19H1AgeWLkzPTlssFN+ddqkte3Zyg=
Received: from DM5PR07CA0090.namprd07.prod.outlook.com (2603:10b6:4:ae::19) by
 SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.27; Mon, 16 Jun 2025 09:39:18 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::eb) by DM5PR07CA0090.outlook.office365.com
 (2603:10b6:4:ae::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 09:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:39:17 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Jun 2025 04:39:15 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Le Ma
 <Le.Ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 09/10] drm/amdgpu: Generalize is_multi_chiplet with a common
 helper v2
Date: Mon, 16 Jun 2025 17:37:55 +0800
Message-ID: <20250616093756.16200-10-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250616093756.16200-1-Hawking.Zhang@amd.com>
References: <20250616093756.16200-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: b0feb663-748c-402e-db58-08ddacb9aa0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FkgHH190V73rhYWrleMYOaNPURsZ/5WhO9jPZmszpesODGxBnzgziXJWQJyi?=
 =?us-ascii?Q?zLeH26GEDeEOa6KoIAwpAxse8sRl9wQxnsfCDwFD6xwdZVc3rRXipKpZuKyB?=
 =?us-ascii?Q?nj31MktZuKUec/8GxEty3Axn1h0rfoGcF0aJSIimb7dYDcpQzOUMw59zmWcj?=
 =?us-ascii?Q?N9WXvYPOCYfQdhtLSyCH9rDQX268zLb6sXm6ZfSkMynArFKKBS7Fe+mYHsKb?=
 =?us-ascii?Q?jzE9dOh5AUyf1nWt4neuYhnw39muOlY9tDQlkBEqEaIGSbz77GHMkliCGay7?=
 =?us-ascii?Q?JGBmLHmAjGKuz+cI5qX9aXqzS5Ff2Eu8jukGpRQHnbCdvQxLnNHZlObe4vXX?=
 =?us-ascii?Q?YRzYonKOJXW3khfmIIrkEHcsOIXVakTwno5ajpwn3ZSaO2MzUHTQday8uEmR?=
 =?us-ascii?Q?fvz5PRnQm8ijVFwvCMXRuocpN1I6HTCz/sax0Il+hl0msRNPOd5/b5A9izup?=
 =?us-ascii?Q?lt0GKbgNOiaY2gOf06Sf/Jhg00xv7Qe+6HZ8YbNi/q/zj1oT1CgMlbYN0vF2?=
 =?us-ascii?Q?gYale6Ri+Ja28iNXp2zcnYqHhOk0ZXA+MLxE3QAzWyx08WEGi59OLfTIT3H4?=
 =?us-ascii?Q?QSNNYu+uUO9v7LhNJDggzArxPUFHqrXS6qr+DN9gMSZ3yYe+VEVMfYg0sSvn?=
 =?us-ascii?Q?4NySY1YORVc6liS2CclQJ6rYHhDCQUIlq0ucN68tuMu1vZz1KS7JJg55k509?=
 =?us-ascii?Q?M25O4yIs6IJDgHTkB9R/Af0EPlUmITNxiH+WfTyyCEjH57Vf+r8rBRhg2pTl?=
 =?us-ascii?Q?Yepk4ewnyfWLfc2VLbigYzsNBm0LI2VU1p+7VwZieHx636Pp6YUGp8sylzLn?=
 =?us-ascii?Q?2Hv4jIU2miimWGtZb9lXfpBb7Um/shBsX8FGyrdtvvlCPbLajx5zNwnqB9nh?=
 =?us-ascii?Q?D8W2Sywrn+ZhPoOAHiGx9ZtwDLgim0MEea5NjBVYklzpItLD1DosUfoJksVa?=
 =?us-ascii?Q?4onEm/ALpFvV7LpKWFgfUrp7rJufWVBDYwAZqLHpFRavujVEa/qbOZIRbQ61?=
 =?us-ascii?Q?zQdMlJdtKvST7lRzRMft9DeTMYlrfDcCp8x8U34uKlH2W9tgV8e5alRrcPMV?=
 =?us-ascii?Q?IzJKubPVqR404voJuZxynBxLcv4LOMfzdQTaa9zlEimhwQUbcikhAU6t6RbD?=
 =?us-ascii?Q?z0V8Mg9UqzDfdZFocC9iO3annmW77otg+tbC8AJaCFO9mNSHVrOO36uXFF8p?=
 =?us-ascii?Q?EOUFB7PnKAFhgL6zkq1MYgVD2OH7FyUiGM+pcoMxADycprx4NrmKK8d0F4bZ?=
 =?us-ascii?Q?jQ+xg6j5AI7Bkmt3FoXBkzVTJn4sluRM+Vu7zRpvfGR8vCiSkDdv1EiRxbnm?=
 =?us-ascii?Q?2X1PF6SIQvj2/KnFFW6FflodYSrJ1xSuND9mohcNmwwWPLF2gothlnqIpCbn?=
 =?us-ascii?Q?O6QQcfX9QEAEpCYI05DXcRJUY37xBwSvpIADVTDkjJBGBdH+PQM+BD1kve9D?=
 =?us-ascii?Q?8TyPRVnilYelFEItThQfLycRvK3wuGe6YodCzy+aJpqDAMNipiv/L//WeU0b?=
 =?us-ascii?Q?fOf8XYck6G5kQalfKNMssgfkL/jfpCv0x8cJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:39:17.7683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0feb663-748c-402e-db58-08ddacb9aa0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047
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

It is not necessary to be ip generation specific

v2: rename the helper to is_multi_aid (Lijo)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 23 +++++++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5e2f086d2c99..066532bf5e6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1337,6 +1337,11 @@ static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_device *bdev)
 	return container_of(bdev, struct amdgpu_device, mman.bdev);
 }
 
+static inline bool amdgpu_is_multi_aid(struct amdgpu_device *adev)
+{
+        return !!adev->aid_mask;
+}
+
 int amdgpu_device_init(struct amdgpu_device *adev,
 		       uint32_t flags);
 void amdgpu_device_fini_hw(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3cc2d5c21f49..fa897ced71e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -409,11 +409,6 @@ static const uint32_t ecc_umc_mcumc_ctrl_mask_addrs[] = {
 	(0x001d43e0 + 0x00001800),
 };
 
-static inline bool gmc_v9_0_is_multi_chiplet(struct amdgpu_device *adev)
-{
-	return !!adev->aid_mask;
-}
-
 static int gmc_v9_0_ecc_interrupt_state(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *src,
 		unsigned int type,
@@ -650,7 +645,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		addr, entry->client_id,
 		soc15_ih_clientid_name[entry->client_id]);
 
-	if (gmc_v9_0_is_multi_chiplet(adev))
+	if (amdgpu_is_multi_aid(adev))
 		dev_err(adev->dev, "  cookie node_id %d fault from die %s%d%s\n",
 			node_id, node_id % 4 == 3 ? "RSV" : "AID", node_id / 4,
 			node_id % 4 == 1 ? ".XCD0" : node_id % 4 == 2 ? ".XCD1" : "");
@@ -799,7 +794,7 @@ static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 				       uint32_t vmhub)
 {
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
-	    gmc_v9_0_is_multi_chiplet(adev))
+	    amdgpu_is_multi_aid(adev))
 		return false;
 
 	return ((vmhub == AMDGPU_MMHUB0(0) ||
@@ -1511,7 +1506,7 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 {
-	if (gmc_v9_0_is_multi_chiplet(adev))
+	if (amdgpu_is_multi_aid(adev))
 		adev->gfxhub.funcs = &gfxhub_v1_2_funcs;
 	else
 		adev->gfxhub.funcs = &gfxhub_v1_0_funcs;
@@ -1593,7 +1588,7 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 	 */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
-	    gmc_v9_0_is_multi_chiplet(adev))
+	    amdgpu_is_multi_aid(adev))
 		adev->gmc.xgmi.supported = true;
 
 	if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(6, 1, 0)) {
@@ -2046,7 +2041,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	if (gmc_v9_0_is_multi_chiplet(adev)) {
+	if (amdgpu_is_multi_aid(adev)) {
 		gmc_v9_4_3_init_vram_info(adev);
 	} else if (!adev->bios) {
 		if (adev->flags & AMD_IS_APU) {
@@ -2196,7 +2191,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_gmc_get_vbios_allocations(adev);
 
-	if (gmc_v9_0_is_multi_chiplet(adev)) {
+	if (amdgpu_is_multi_aid(adev)) {
 		r = gmc_v9_0_init_mem_ranges(adev);
 		if (r)
 			return r;
@@ -2225,7 +2220,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->vm_manager.first_kfd_vmid =
 		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
 		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
-		 gmc_v9_0_is_multi_chiplet(adev)) ?
+		 amdgpu_is_multi_aid(adev)) ?
 			3 :
 			8;
 
@@ -2237,7 +2232,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	if (gmc_v9_0_is_multi_chiplet(adev))
+	if (amdgpu_is_multi_aid(adev))
 		amdgpu_gmc_sysfs_init(adev);
 
 	return 0;
@@ -2247,7 +2242,7 @@ static int gmc_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (gmc_v9_0_is_multi_chiplet(adev))
+	if (amdgpu_is_multi_aid(adev))
 		amdgpu_gmc_sysfs_fini(adev);
 
 	amdgpu_gmc_ras_fini(adev);
-- 
2.17.1

