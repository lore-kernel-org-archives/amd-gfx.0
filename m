Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A09C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C6B10E1D4;
	Tue,  9 May 2023 22:14:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3309910E1D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8aAiWBwRfB12cuHehJ4tr59XEF/NSNFaG6tXiSrgijAFINueT/dvX56+BBsarhAuNbtK1scH2oNnOZiokPqzYGVx9yqI/R8G3ijaXyrW4L150AYMbCZVXqrYKiOCEniiA1TJUNTSI1oJJk3yuZPbmYwkJ/s5FyXAoCcmNzE6dBpNlnmp71BZHtwzv2W6wrbIOosTpuhCWX6CWsuWwP8LiMLHdTaxuxsoJUGsbdP/E8UFlOKBtECWR8hlpV5FxFbEaMdDJWAsXNbU008989SYxRyG612rDL17nYmIY5zpnXhbrNhB9M179kPXnTSrOORPyIFg+0KhGpbxEo0EMSLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1mclE7x0LqwytsegOVWwLQDnA0qwSMpM7WUiGaAqKE=;
 b=PDD+pZecjLAczWYBxatgCbRfpKNThpglvknPGujBKKW7cEc5E1sCsrZdq6YI44mvSMEx7MJSPK7uURBPOnMf8J9XslVacTCqj6Wh4qlVu1X4ZhauulrAXkgaEFk0SNU+erJaDAiUuTtptZakpmbx/8hgkCH7cP0D1KIcQ/pHMIQtfnaSGgZhFXFcCiqv2safzJkoZwz+0/zV3wlarIbdLAuWKNKnlz7wD0PyMe2L3xnbsvzsSrrm9/qg6wBKzk1H6sN+SqqSn1gETFPPgBoygJAcIz3MAj/q4Y3nrwX8lRzK6h9ZEuQyjKNgYfCT41eaiQBWA7q2cvZBhAvlJvCI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1mclE7x0LqwytsegOVWwLQDnA0qwSMpM7WUiGaAqKE=;
 b=J6Lkm9CAMeew6Fc1Gc5Fgd+tdXbN31KUBv7LfTw1qF1svOEuVnMULhqg6rcfSHrK17gUSlFB8rQjuFlw7APPsasI+fLMcIorcTkUskhWfE9VlXNsDn0iU8Hk4gFpUwSAUS1wKaF68DtHNVim1xyNfxQDEVIEnAKA1d7LRglcxfE=
Received: from BN1PR14CA0012.namprd14.prod.outlook.com (2603:10b6:408:e3::17)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:14:23 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::49) by BN1PR14CA0012.outlook.office365.com
 (2603:10b6:408:e3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.19 via Frontend Transport; Tue, 9 May 2023 22:14:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amdgpu: Move memory partition query to gmc
Date: Tue, 9 May 2023 18:13:56 -0400
Message-ID: <20230509221408.476829-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221408.476829-1-alexander.deucher@amd.com>
References: <20230509221408.476829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbf56b7-76d4-4094-6a3c-08db50dabe8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LiCb+m3C62HHYypGwShHkSFNL5oClr+H0KUJTFaTqqRrkSgswzjGcUc6jxRipXesixxzeyx+XUJS2k1SH98+H17kqG60E/QpEiC7aJ5qSmY0cB5ELeMVt/tNEknndvgbmMLv1LJ1SLHVaSjQ3GALnR3rk3XWhlgm5WcNpKPADnztJqu1QBf7KXyj95uQoyPkuLbbQdaTPDqytMp8TesHM2eUpYc9nAukVlfK1UU9ViJU1eZmc/K6hibel3Eta5vQjiRBHwbomQqBnLdhqnLoWXaySVrNft6XqSoxm+2etfhJ2JB12FrNBzSY4i4CwuXza52/+W2Yhems7FWQYykAgDvpgbrv9RMIUrrgaQJjMyN8//zQcqywJmAica3ehWFtNWkDg8X0Qb6YYzFzve07ZumovrfxfEaA8Fe9GQLcKPK8LkMima00cXB0hzGM3ifamMuDbx3u1T7ajMJpj/Y/VVlmqHKZqfIG4iHLIEuO+189LAwXt3O0uScz7V7rOQS27OAg5A7a7ra5FEDD5x79TSt7VIETWPcCh6ZhWOycfXqYGx7cBLKM1JP7gKsL77n+3iAd5b7cOFSW62dgKgXnyEZtO1UNIZGFwoIqS1FVAC3j6SXP6l1bsooNmfiBtvZyPqagF+KJe6ZDNPMUYgVvUF/Qmdr68rw8xYgS7mEiQD4/e+pO9vZVZdVKubAiRyJnVxww+BqGXMviYMPw2/hZ84SI6+8QP8NOVVp9/VgsnI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(2906002)(8936002)(478600001)(316002)(5660300002)(8676002)(6916009)(54906003)(41300700001)(16526019)(6666004)(70586007)(70206006)(7696005)(1076003)(26005)(186003)(40460700003)(83380400001)(82740400003)(47076005)(36756003)(2616005)(336012)(426003)(40480700001)(36860700001)(82310400005)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:23.2554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbf56b7-76d4-4094-6a3c-08db50dabe8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

GMC block handles memory related information, it makes more sense to
keep memory partition functions in gmc block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 30 +----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 44 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 16 +++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 10 ------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 18 ++++++++++
 6 files changed, 79 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a939ffe2969a..817e7b7d32b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1198,24 +1198,6 @@ static ssize_t amdgpu_gfx_get_current_compute_partition(struct device *dev,
 	return sysfs_emit(buf, "%s\n", partition_mode);
 }
 
-static ssize_t amdgpu_gfx_get_current_memory_partition(struct device *dev,
-						struct device_attribute *addr,
-						char *buf)
-{
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	enum amdgpu_memory_partition mode;
-	static const char *partition_modes[] = {
-		"UNKNOWN", "NPS1", "NPS2", "NPS4", "NPS8"
-	};
-	BUILD_BUG_ON(ARRAY_SIZE(partition_modes) <= AMDGPU_NPS8_PARTITION_MODE);
-
-	mode = min((int)adev->gfx.funcs->query_mem_partition_mode(adev),
-		AMDGPU_NPS8_PARTITION_MODE);
-
-	return sysfs_emit(buf, "%s\n", partition_modes[mode]);
-}
-
 static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 						struct device_attribute *addr,
 						const char *buf, size_t count)
@@ -1299,9 +1281,6 @@ static DEVICE_ATTR(current_compute_partition, S_IRUGO | S_IWUSR,
 static DEVICE_ATTR(available_compute_partition, S_IRUGO,
 		   amdgpu_gfx_get_available_compute_partition, NULL);
 
-static DEVICE_ATTR(current_memory_partition, S_IRUGO,
-		   amdgpu_gfx_get_current_memory_partition, NULL);
-
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -1311,19 +1290,12 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 		return r;
 
 	r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
-	if (r)
-		return r;
 
-	r = device_create_file(adev->dev, &dev_attr_current_memory_partition);
-	if (r)
-		return r;
-
-	return 0;
+	return r;
 }
 
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 {
 	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
 	device_remove_file(adev->dev, &dev_attr_available_compute_partition);
-	device_remove_file(adev->dev, &dev_attr_current_memory_partition);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 81b4c7e684af..728977f8afe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -71,14 +71,6 @@ enum amdgpu_pkg_type {
 	AMDGPU_PKG_TYPE_UNKNOWN,
 };
 
-enum amdgpu_memory_partition {
-	UNKNOWN_MEMORY_PARTITION_MODE = 0,
-	AMDGPU_NPS1_PARTITION_MODE = 1,
-	AMDGPU_NPS2_PARTITION_MODE = 2,
-	AMDGPU_NPS4_PARTITION_MODE = 3,
-	AMDGPU_NPS8_PARTITION_MODE = 4,
-};
-
 struct amdgpu_mec {
 	struct amdgpu_bo	*hpd_eop_obj;
 	u64			hpd_eop_gpu_addr;
@@ -276,8 +268,6 @@ struct amdgpu_gfx_funcs {
 				   struct amdgpu_gfx_shadow_info *shadow_info);
 	enum amdgpu_gfx_partition
 			(*query_partition_mode)(struct amdgpu_device *adev);
-	enum amdgpu_memory_partition
-			(*query_mem_partition_mode)(struct amdgpu_device *adev);
 	int (*switch_partition_mode)(struct amdgpu_device *adev,
 				     int num_xccs_per_xcp);
 	int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_node);
@@ -414,7 +404,6 @@ struct amdgpu_gfx {
 	bool				cp_gfx_shadow; /* for gfx11 */
 
 	uint16_t 			xcc_mask;
-	enum amdgpu_memory_partition	mem_partition_mode;
 	uint32_t			num_xcc_per_xcp;
 	struct mutex			partition_mutex;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index efb08b4d093b..3f5dd9e32e08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -890,3 +890,47 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+static ssize_t current_memory_partition_show(
+	struct device *dev, struct device_attribute *addr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	enum amdgpu_memory_partition mode;
+
+	mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+	switch (mode) {
+	case AMDGPU_NPS1_PARTITION_MODE:
+		return sysfs_emit(buf, "NPS1\n");
+	case AMDGPU_NPS2_PARTITION_MODE:
+		return sysfs_emit(buf, "NPS2\n");
+	case AMDGPU_NPS3_PARTITION_MODE:
+		return sysfs_emit(buf, "NPS3\n");
+	case AMDGPU_NPS4_PARTITION_MODE:
+		return sysfs_emit(buf, "NPS4\n");
+	case AMDGPU_NPS6_PARTITION_MODE:
+		return sysfs_emit(buf, "NPS6\n");
+	case AMDGPU_NPS8_PARTITION_MODE:
+		return sysfs_emit(buf, "NPS8\n");
+	default:
+		return sysfs_emit(buf, "UNKNOWN\n");
+	}
+
+	return sysfs_emit(buf, "UNKNOWN\n");
+}
+
+static DEVICE_ATTR_RO(current_memory_partition);
+
+int amdgpu_gmc_sysfs_init(struct amdgpu_device *adev)
+{
+	if (!adev->gmc.gmc_funcs->query_mem_partition_mode)
+		return 0;
+
+	return device_create_file(adev->dev,
+				  &dev_attr_current_memory_partition);
+}
+
+void amdgpu_gmc_sysfs_fini(struct amdgpu_device *adev)
+{
+	device_remove_file(adev->dev, &dev_attr_current_memory_partition);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e408abfc2daf..2bd3b9665ebf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -63,6 +63,16 @@
 
 struct firmware;
 
+enum amdgpu_memory_partition {
+	UNKNOWN_MEMORY_PARTITION_MODE = 0,
+	AMDGPU_NPS1_PARTITION_MODE = 1,
+	AMDGPU_NPS2_PARTITION_MODE = 2,
+	AMDGPU_NPS3_PARTITION_MODE = 3,
+	AMDGPU_NPS4_PARTITION_MODE = 4,
+	AMDGPU_NPS6_PARTITION_MODE = 6,
+	AMDGPU_NPS8_PARTITION_MODE = 8,
+};
+
 /*
  * GMC page fault information
  */
@@ -140,6 +150,9 @@ struct amdgpu_gmc_funcs {
 			   uint64_t *flags);
 	/* get the amount of memory used by the vbios for pre-OS console */
 	unsigned int (*get_vbios_fb_size)(struct amdgpu_device *adev);
+
+	enum amdgpu_memory_partition (*query_mem_partition_mode)(
+		struct amdgpu_device *adev);
 };
 
 struct amdgpu_xgmi_ras {
@@ -375,4 +388,7 @@ uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
 uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
 uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
 int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
+int amdgpu_gmc_sysfs_init(struct amdgpu_device *adev);
+void amdgpu_gmc_sysfs_fini(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 69867294117e..81ab3cd2f229 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -607,16 +607,7 @@ static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu_device *adev,
 {
 	soc15_grbm_select(adev, me, pipe, q, vm, GET_INST(GC, xcc_id));
 }
-static enum amdgpu_memory_partition
-gfx_v9_4_3_query_memory_partition(struct amdgpu_device *adev)
-{
-	enum amdgpu_memory_partition mode = UNKNOWN_MEMORY_PARTITION_MODE;
-
-	if (adev->nbio.funcs->get_memory_partition_mode)
-		mode = adev->nbio.funcs->get_memory_partition_mode(adev);
 
-	return mode;
-}
 
 static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 						int num_xccs_per_xcp)
@@ -660,7 +651,6 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v9_4_3_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v9_4_3_select_me_pipe_q,
 	.switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
-	.query_mem_partition_mode = &gfx_v9_4_3_query_memory_partition,
 	.ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index d95205b4277e..17459c4951fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1330,6 +1330,17 @@ static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
 	return size;
 }
 
+static enum amdgpu_memory_partition
+gmc_v9_0_query_memory_partition(struct amdgpu_device *adev)
+{
+	enum amdgpu_memory_partition mode = UNKNOWN_MEMORY_PARTITION_MODE;
+
+	if (adev->nbio.funcs->get_memory_partition_mode)
+		mode = adev->nbio.funcs->get_memory_partition_mode(adev);
+
+	return mode;
+}
+
 static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
 	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
@@ -1339,6 +1350,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.get_vm_pde = gmc_v9_0_get_vm_pde,
 	.get_vm_pte = gmc_v9_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
+	.query_mem_partition_mode = &gmc_v9_0_query_memory_partition,
 };
 
 static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev)
@@ -1901,6 +1913,9 @@ static int gmc_v9_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
+		amdgpu_gmc_sysfs_init(adev);
+
 	return 0;
 }
 
@@ -1908,6 +1923,9 @@ static int gmc_v9_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
+		amdgpu_gmc_sysfs_fini(adev);
+
 	amdgpu_gmc_ras_fini(adev);
 	amdgpu_gem_force_release(adev);
 	amdgpu_vm_manager_fini(adev);
-- 
2.40.1

