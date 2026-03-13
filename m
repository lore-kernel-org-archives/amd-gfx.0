Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0334A107BCE6
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 22:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8612E10EC40;
	Fri, 13 Mar 2026 22:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RV+Ab5T2";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBBC10EC40
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 22:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dw7B4nw47KNP+BPZ2hsXgRLCDE45/cb4eZ7f3chdCd+SdYgh4Zhnd0jnmFiZ1UOS7w6cNScM3vyH+F+Vv66ZbaqHqYFVhfasVGeBY/IYDFRsT3JAoqtqcvpnhPv5hnYHHIjItKFVaRDbb0FklHKDxHZ3H9KCPQp5ydhRzzInANPdGwOpZyml+pZ6QlnP6P6PiJqsCyzwOMNAr/v0rB7yyEEM/oXJnQh01uRrOMgAzErJwTLLo+8KWLTKP+VWXu3KjzoSppq7/3Ltz/yLJqkySvNGP5MwUNIBGfPzNaAwM03ToMZQGo149obBodjKehLrQvpyP0CNwAV7QQFaBUNimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jymNzjwmpdzxbtcu4mu0Ks8o1iuHdd1VnHJWX27mT8s=;
 b=mbUrwXkLObFZ58lmM9M+8igp4jQdlqMneAN/EUxqbcSGw//BmHoewW6dgZQ+EXEsloRcuoVUo80awXPuvIbGVDk2i8t3TSpyDPk6qwRhuzuVaZvShMk4yWm6iwWrw0b+/EcmqwmwvZFKeDp7NODHXetKRJG8szm2S0ad2A4w8VNIfLMVx/BoU2uLtdITzaV4YYGbu6oDLYGQnG8lKRQkfR8ea/q7R1DqGDABnMFdtMuOFzbDPL6fDC0YCTNuRbyBXP1EMormYXgN7RqDFg1eyseZto02BfHKQCaZPfKN4/bR3H5iSUchs7Q46SaGrMLzjbjqo8GkxV8Ct60oFWcPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jymNzjwmpdzxbtcu4mu0Ks8o1iuHdd1VnHJWX27mT8s=;
 b=RV+Ab5T2MIPdxkS2dA8HrrCwxV3hni4K18ETnyla3mhm5/w215vItLusU0weFXYDFvzGulm8Sp8aN6hw7PQQz+/CXyexRqt8apdzoXiKTIWcS29+yU9pWHeHeJ6yvmWPGAxZJcA36fxXP2R3azawEORnN0R3ZCcxCB21Gi3k58A=
Received: from CH0PR04CA0056.namprd04.prod.outlook.com (2603:10b6:610:77::31)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 22:34:28 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::bd) by CH0PR04CA0056.outlook.office365.com
 (2603:10b6:610:77::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 22:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 22:34:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 13 Mar
 2026 17:34:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Mar
 2026 17:34:26 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 13 Mar 2026 17:34:26 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v2] drm/amdgpu: add an option to allow gpu partition allocate
 all available memory
Date: Fri, 13 Mar 2026 17:37:35 -0500
Message-ID: <20260313223735.3391865-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f28537d-bf94-445e-74f5-08de8150afa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: HyqAmYmBxsM7Ny4DI89vQG3QMzbwXe9kLkp+ijpZ70wh0YAQqALyLDjE3X5poQz5I+tgOuVO5onK218xEMTb+Fpqvj5fR09glqMmP29/WHrKPLCFylxG7tSSXN+da1LKSKMAPyrU3Z/X4ViR8gg4cX8yo/CtoouQ2dzVEag2gA6suePTWQmhKiSL42jaCRjOWZXJ7XXVsRMsrTsY6tNvVy6hZ4vc1k+zrvcJtuJxLRv3xF3byK8fePDcEom9LwscfgK6qInBF1qiNUD7JSt7B3oV4oWR68E/jEPnjMVJWtz8cU7GeTsH/etH2k7zW5BidXTUm6+GDTvdkq+yOZeUBlBD6PWEOsSbvVQLuRcoQyBMPa7mEzDE4WjOXBOHsjAvPlnKAveIaLkdrzU+GIc1nF1NrgDQIOjYZrXklZ76OA9MryNXsfd/BT1sHEb/CWmDUA/nmYEAzPglSllgPJSDdMz+lTZeRF12MGTV9b9AS88wISKL8dQqsEe55q2B+OsjfmXZXp3wmuGei4xIiwlkbkycRtbGO9GY2KDr22cknnFXAY1DCwOV2RBCqTzvJlCvFtMIuQLDt4N6PyJe+xM7s570xdFfEwkvxDPgHBfVFMLBStrPsGKYZ5TvdIdaaLJC0ZyxgyoNkPzq0JUYij0UxDeRGIgn8wA8hO4Px6UNL7ZZW+irZsqb25st1LDwFSksc9FW8Jws67e7XNGYrryRA84EtAyEtkHgFMN1IjEItaXLCibdysa+eFKXQZ0BYIz4tc8Goz6O3v5yZHfuO6jYLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PSLq/rBPWxRxZAN++sY65C+HesQpGZhmKSv6V2grGKjCRevRCmSn+KDm7Sr4X9VmLdmzvKkY6EX5mskOiemnN53F/lGMqS+F6PYMthlwaDG8EtGbKNfHaNyct4bnzQzp+TWSrt9KDbAXjjoaF4f0Ajml94bkHu68Q/j/cQ+nuJHhNrK+sBtGWKIwmLyeqspMM5Yh0M+OCflMX0OylecbhRun/PRK/lHZmB31mcgxopM5YVcy7gg+KTXEbOBdC/UFiwhSmsAZIOvsdAh6PCj8FEjCtY9i8Pxi/WDSoJj5Rb66mbFloJaFGDfy5o4q20GR771y/smQp2+yiwrK3TWv/u5gp0/tNyQfMyqPuG27A8AImlTEI0U9JBraw36QQiwRtuCtq8tWtIVWGliVIsLJhKQxM+/g2pFjKQXjXeMfx1EHlA2eTy6jVK4th5xpLmcs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 22:34:27.6869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f28537d-bf94-445e-74f5-08de8150afa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Current driver reports and limits memory allocation for each partition equally
among partitions using same memory partition. Application may not be able to
use all available memory when run on a partitioned gpu though system still has
enough free memory.

Add an option that app can use to have gpu partition allocate all available
memory.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 43 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 17 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  2 +
 5 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3bfd79c89df3..fc6613058af8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -805,7 +805,10 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 		} else {
 			tmp = adev->gmc.mem_partitions[mem_id].size;
 		}
-		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
+
+		if (adev->xcp_mgr->mem_alloc_mode == AMDGPU_PARTITION_MEM_CAPPING_EVEN)
+			do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
+
 		return ALIGN_DOWN(tmp, PAGE_SIZE);
 	} else if (adev->apu_prefer_gtt) {
 		return (ttm_tt_pages_limit() << PAGE_SHIFT);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index cab3196a87fb..e202ba1eadce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1580,6 +1580,40 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 	return count;
 }
 
+static ssize_t amdgpu_gfx_get_compute_partition_mem_alloc_mode(
+						struct device *dev, struct device_attribute *addr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int mode = adev->xcp_mgr->mem_alloc_mode;
+
+	/* Only minimal precaution taken to reject requests while in reset.*/
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+
+	return sysfs_emit(buf, "%s\n",
+			  amdgpu_gfx_compute_mem_alloc_mode_desc(mode));
+}
+
+
+static ssize_t amdgpu_gfx_set_compute_partition_mem_alloc_mode(
+						struct device *dev, struct device_attribute *addr,
+						const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!strncasecmp("CAPPING", buf, strlen("CAPPING")))
+		adev->xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_CAPPING_EVEN;
+	else if (!strncasecmp("ALL", buf, strlen("ALL")))
+		adev->xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_ALL;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
 static const char *xcp_desc[] = {
 	[AMDGPU_SPX_PARTITION_MODE] = "SPX",
 	[AMDGPU_DPX_PARTITION_MODE] = "DPX",
@@ -1935,6 +1969,10 @@ static DEVICE_ATTR(gfx_reset_mask, 0444,
 static DEVICE_ATTR(compute_reset_mask, 0444,
 		   amdgpu_gfx_get_compute_reset_mask, NULL);
 
+static DEVICE_ATTR(compute_partition_mem_alloc_mode, 0644,
+		   amdgpu_gfx_get_compute_partition_mem_alloc_mode,
+		   amdgpu_gfx_set_compute_partition_mem_alloc_mode);
+
 static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
@@ -1955,6 +1993,11 @@ static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = device_create_file(adev->dev,
+			       &dev_attr_compute_partition_mem_alloc_mode);
+	if (r)
+		return r;
+
 	if (xcp_switch_supported)
 		r = device_create_file(adev->dev,
 				       &dev_attr_available_compute_partition);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 720ed3a2c78c..afcc98d26f45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -71,6 +71,11 @@ enum amdgpu_gfx_partition {
 	AMDGPU_AUTO_COMPUTE_PARTITION_MODE = -2,
 };
 
+enum amdgpu_gfx_partition_mem_alloc_mode {
+	AMDGPU_PARTITION_MEM_CAPPING_EVEN = 0,
+	AMDGPU_PARTITION_MEM_ALLOC_ALL  = 1,
+};
+
 #define NUM_XCC(x) hweight16(x)
 
 enum amdgpu_gfx_ras_mem_id_type {
@@ -676,4 +681,16 @@ static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 	}
 }
 
+static inline const char *amdgpu_gfx_compute_mem_alloc_mode_desc(int mode)
+{
+	switch (mode) {
+	case AMDGPU_PARTITION_MEM_CAPPING_EVEN:
+		return "CAPPING";
+	case AMDGPU_PARTITION_MEM_ALLOC_ALL:
+		return "ALL";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 73250ab45f20..389f69c7d5c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -181,6 +181,7 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 	}
 
 	xcp_mgr->num_xcps = num_xcps;
+	xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_CAPPING_EVEN;
 	amdgpu_xcp_update_partition_sched_list(adev);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 8058e8f35d41..878c1c422893 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -132,6 +132,8 @@ struct amdgpu_xcp_mgr {
 	struct amdgpu_xcp_cfg *xcp_cfg;
 	uint32_t supp_xcp_modes;
 	uint32_t avail_xcp_modes;
+	/* used to determin KFD memory alloc mode for each partition */
+	uint32_t mem_alloc_mode;
 };
 
 struct amdgpu_xcp_mgr_funcs {
-- 
2.34.1

