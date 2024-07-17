Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C54C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 08:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B7710E9F2;
	Wed, 17 Jul 2024 08:16:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dzpQm9CZ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AD98911F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 08:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIHr94uwm4jo04ujz0aCCMjT3j13wFq5oIa/+CXN/6C182Yf69wP6xGO6PUHWMQM/vt58KtYXKNbzG5/ukAujyWoEM/HEcr20xHzWuX+8hynSATh1D7ivwVuhk9zc3pf6opwB6LYnPsKypaFrxIR4xN6TTGhOhUW4N9s20Kug6Q8AttEait3zbcnPrF5Y2DY7xJ/obx9Fx0cIj6GiYLcIMidLHwCn6yeHCkDAL91cwgizf7Paq0NGdeu4KO0tozfg+V0F78QEMKgdd0xAGtVFow5pvOYWz1Lt3tPAQ4dqcx+xepT1Q+YBjX+wK4Y9W+4l3cYOXTE3uODwqP83viv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhWlWbxHlL2o+JUjSd4hm5kk7KljqyoJW5rgSLZQHx8=;
 b=UPKXMYKZXg16Wa7DRdl2EsOe8UkCKWMd97W0ckwXQGE4sdJS+Vki3BuHB58vEw0tFbJMxcKIrXz9e4MzEiOAYFfUIZ2CqK0D6koP/e/5D9y4ZtJFseXAuy6IGYd868QhFnRbEAJ3uyABKt1PxT8ksclljKXKFitTsQkZJlRFfEFakSzuXI5F8sxHUsZSIG66NYeCKYcNdWYtvklDzK1+b4ANC5UJgPs0rRpYbyrknTTPJraT+h748VnaTnuoLIQBXYQPOTZBulzutMBiOrWQ2NaH7Xui+P6pWEC40Qrm7hNChASvCzpSrwpVA5GW+wCZkV53x4okWUe8XXTTVm8i4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhWlWbxHlL2o+JUjSd4hm5kk7KljqyoJW5rgSLZQHx8=;
 b=dzpQm9CZfPRRIsunoYtdrLiarwvrPj2U6pFazfgvvr/s/Vm/ir3D8TEG7tukEOcxUQLXRiqAf5Yg9VPJf+RMQMA3xUQ8A6i7DOZs6cd5R+hfrf5LAyyvu2KVUe0/Zax64wTxNVf6cQBvB2NmxG1khOyVPOvd8ReUbTOCT5Au3kI=
Received: from BL1PR13CA0250.namprd13.prod.outlook.com (2603:10b6:208:2ba::15)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 08:16:16 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::e1) by BL1PR13CA0250.outlook.office365.com
 (2603:10b6:208:2ba::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13 via Frontend
 Transport; Wed, 17 Jul 2024 08:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 08:16:16 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 03:16:12 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
Date: Wed, 17 Jul 2024 16:15:46 +0800
Message-ID: <20240717081547.224193-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717081547.224193-1-YiPeng.Chai@amd.com>
References: <20240717081547.224193-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: af1cc99b-e36b-4388-12ae-08dca638bb14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l1wqh/Hq6M9qfAhvmatdq4i45CaC+6IiNCU37K5uEemoJcN1Wl0lAwKvB+wv?=
 =?us-ascii?Q?DmaY8cDYo2aAkiiE3xYfwiYhZwwZEZ723qVQjDKTCNB7HBaPyfB20vAMgGru?=
 =?us-ascii?Q?RiHbY8gyYGeLYvFEPndKD0k4zVaIw8yWj/YKmOp4QLZnp0eUYkT/v158hdVE?=
 =?us-ascii?Q?7vZII8pwN3XvPYr3MlViVZYnpExvwOOvq9/ZJPJnML7ER+Ri1vxdJ9vGhRDw?=
 =?us-ascii?Q?Mv7H5XAhzClokK3NW5oCjutHuqD7qBXFiAT3qNdA8aJhkaoKQf/krDi/y1kV?=
 =?us-ascii?Q?qk2Mp4DTPwL8TwQle2boemLLAZVEfJILLTkfM7XJ3djtqINJy/DaaMmLb0+m?=
 =?us-ascii?Q?V+Y3soNKCx4EnJ48wUBLjNTXT/fbAp2ActFfK4eEzLg80zW2LchnGc0ifn8F?=
 =?us-ascii?Q?3MguHuVceLdnWsSEF0aeusaDj8T6RpceVULHcei9AGfXV+l33qWsxSZQ6W+3?=
 =?us-ascii?Q?KVQTNBywYuVDDGUTzTcoL39TsNfMKe2F/liZ1aj9brR/bGhr/QA44OvGaR9d?=
 =?us-ascii?Q?pCgvjsDXB8bEenSF5JQ7q6zInZb3LykVN8YTzICxFKUx6L4+MIT78RPxBHiI?=
 =?us-ascii?Q?4YjjyAX/jpgOWzrOHg57D5vkiUKPIS7ySuEnKZL7pIT7afQGaVop5HTdrfb+?=
 =?us-ascii?Q?UFtT6RYQcbe8SYxRsj5Cz1eypcFDTXArCJQWrsTmDM4HhYvl8As+04knXgPS?=
 =?us-ascii?Q?VXGa43AXAUSw4qi6EDXyYFtYzGI2LM7x20/qPXR1yzp4zv4IOjwqecYKGP1+?=
 =?us-ascii?Q?DVzfg8XDiVbbjcGFqDXmW5/hDhySXLEnCTsGqXO+9fwcsXs4ojqGn2Dwe0rJ?=
 =?us-ascii?Q?YqzO2ZkCgBI5PXEmY2dvghegLM6OfFhF8I38fBS2rqvGNdpRZa0w3z35YlgS?=
 =?us-ascii?Q?ELWDdWl4WOBT0INzXUJTEKYSIdw0lglp2+68rb1JIJDDwPa/j23+0syDr1EX?=
 =?us-ascii?Q?+LWZJrr9tmP4+El363n/1qY4W3G3hODAl9fjLdiakCsDrM2lRPAr8MrzKG1x?=
 =?us-ascii?Q?tBrLptAQVIzKO8tdU03YBfd6coDB0itFc5UI8cHuUOIEDWPCFqOd27qfoSxJ?=
 =?us-ascii?Q?LRoMTEH55Cyh/w9lwAwkeaMCaty+yk4nJbiBLKWpd/pkOQsJ1T8SuME8Zbep?=
 =?us-ascii?Q?s5lCazJ44lYjh2chC5es7gEPcGcUo2PCwSWOI/Tz/p+oALLSoLitMCabk/M2?=
 =?us-ascii?Q?wwdH5b+vLraxyha0XMVAZW3bi5Uu+FDRtffyDBTRLCWOmtSEjn6++KntO2Yv?=
 =?us-ascii?Q?uC9umHKfXIxmFOgfIZFvoq3iMLWPE1bGVRQgGEUrCBclXFg5iT2ub273BthY?=
 =?us-ascii?Q?TXmw4Oxuo5v439tGL8c/X8HUAnd1qhMAiSNsLoAUXrU4Yrw5omqRdyhSrbbS?=
 =?us-ascii?Q?yN9FCKuezNBTweddNYj3kRi8Ohqs5e7TrSgTn48iUKC2Q0n/yULV8yExM166?=
 =?us-ascii?Q?kqwvnHSmdBIzwjs8p5Hi1SuQZLymHhUD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:16:16.6177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af1cc99b-e36b-4388-12ae-08dca638bb14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415
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

1. Use pa_pfn as the radix-tree key index to log
   deferred error info.
2. Use local array to store expanded bad pages.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 14 ++----
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 65 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h  |  5 ++
 4 files changed, 40 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index dcf1f3dbb5c4..f607ff620015 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -476,10 +476,10 @@ struct ras_err_pages {
 };
 
 struct ras_ecc_err {
-	u64 hash_index;
 	uint64_t status;
 	uint64_t ipid;
 	uint64_t addr;
+	uint64_t pa_pfn;
 	struct ras_err_pages err_pages;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 5d08c03fe543..2fc90799bf8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -523,18 +523,10 @@ int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
 	ecc_log = &con->umc_ecc_log;
 
 	mutex_lock(&ecc_log->lock);
-	ret = radix_tree_insert(ecc_tree, ecc_err->hash_index, ecc_err);
-	if (!ret) {
-		struct ras_err_pages *err_pages = &ecc_err->err_pages;
-		int i;
-
-		/* Reserve memory */
-		for (i = 0; i < err_pages->count; i++)
-			amdgpu_ras_reserve_page(adev, err_pages->pfn[i]);
-
+	ret = radix_tree_insert(ecc_tree, ecc_err->pa_pfn, ecc_err);
+	if (!ret)
 		radix_tree_tag_set(ecc_tree,
-			ecc_err->hash_index, UMC_ECC_NEW_DETECTED_TAG);
-	}
+			ecc_err->pa_pfn, UMC_ECC_NEW_DETECTED_TAG);
 	mutex_unlock(&ecc_log->lock);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index eca5ac6a0532..f2235c9ead29 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -524,9 +524,9 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	uint16_t hwid, mcatype;
 	uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
-	uint64_t err_addr, hash_val = 0, pa_addr = 0;
+	uint64_t err_addr, pa_addr = 0;
 	struct ras_ecc_err *ecc_err;
-	int count, ret;
+	int count, ret, i;
 
 	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
 	mcatype = REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);
@@ -559,39 +559,18 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	if (ret)
 		return ret;
 
-	memset(page_pfn, 0, sizeof(page_pfn));
-	count = umc_v12_0_expand_addr_to_bad_pages(adev,
-				pa_addr,
-				page_pfn, ARRAY_SIZE(page_pfn));
-	if (count <= 0) {
-		dev_warn(adev->dev, "Fail to convert error address! count:%d\n", count);
-		return 0;
-	}
-
-	ret = amdgpu_umc_build_pages_hash(adev,
-			page_pfn, count, &hash_val);
-	if (ret) {
-		dev_err(adev->dev, "Fail to build error pages hash\n");
-		return ret;
-	}
-
 	ecc_err = kzalloc(sizeof(*ecc_err), GFP_KERNEL);
 	if (!ecc_err)
 		return -ENOMEM;
 
-	ecc_err->err_pages.pfn = kcalloc(count, sizeof(*ecc_err->err_pages.pfn), GFP_KERNEL);
-	if (!ecc_err->err_pages.pfn) {
-		kfree(ecc_err);
-		return -ENOMEM;
-	}
-
-	memcpy(ecc_err->err_pages.pfn, page_pfn, count * sizeof(*ecc_err->err_pages.pfn));
-	ecc_err->err_pages.count = count;
-
-	ecc_err->hash_index = hash_val;
 	ecc_err->status = status;
 	ecc_err->ipid = ipid;
 	ecc_err->addr = addr;
+	ecc_err->pa_pfn = UMC_V12_ADDR_MASK_BAD_COLS(pa_addr) >> AMDGPU_GPU_PAGE_SHIFT;
+
+	/* If converted pa_pfn is 0, use pa xor pfn. */
+	if (!ecc_err->pa_pfn)
+		ecc_err->pa_pfn = BIT_ULL(UMC_V12_0_PA_R13_BIT) >> AMDGPU_GPU_PAGE_SHIFT;
 
 	ret = amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tree, ecc_err);
 	if (ret) {
@@ -600,13 +579,25 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 		else
 			dev_err(adev->dev, "Fail to log ecc error! ret:%d\n", ret);
 
-		kfree(ecc_err->err_pages.pfn);
 		kfree(ecc_err);
 		return ret;
 	}
 
 	con->umc_ecc_log.de_queried_count++;
 
+	memset(page_pfn, 0, sizeof(page_pfn));
+	count = umc_v12_0_expand_addr_to_bad_pages(adev,
+				pa_addr,
+				page_pfn, ARRAY_SIZE(page_pfn));
+	if (count <= 0) {
+		dev_warn(adev->dev, "Fail to convert error address! count:%d\n", count);
+		return 0;
+	}
+
+	/* Reserve memory */
+	for (i = 0; i < count; i++)
+		amdgpu_ras_reserve_page(adev, page_pfn[i]);
+
 	/* The problem case is as follows:
 	 * 1. GPU A triggers a gpu ras reset, and GPU A drives
 	 *    GPU B to also perform a gpu ras reset.
@@ -631,16 +622,21 @@ static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
 				struct ras_ecc_err *ecc_err, void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-	uint32_t i = 0;
-	int ret = 0;
+	uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
+	int ret, i, count;
 
 	if (!err_data || !ecc_err)
 		return -EINVAL;
 
-	for (i = 0; i < ecc_err->err_pages.count; i++) {
+	memset(page_pfn, 0, sizeof(page_pfn));
+	count = umc_v12_0_expand_addr_to_bad_pages(adev,
+				ecc_err->pa_pfn << AMDGPU_GPU_PAGE_SHIFT,
+				page_pfn, ARRAY_SIZE(page_pfn));
+
+	for (i = 0; i < count; i++) {
 		ret = amdgpu_umc_fill_error_record(err_data,
 				ecc_err->addr,
-				ecc_err->err_pages.pfn[i] << AMDGPU_GPU_PAGE_SHIFT,
+				page_pfn[i] << AMDGPU_GPU_PAGE_SHIFT,
 				MCA_IPID_2_UMC_CH(ecc_err->ipid),
 				MCA_IPID_2_UMC_INST(ecc_err->ipid));
 		if (ret)
@@ -674,7 +670,8 @@ static void umc_v12_0_query_ras_ecc_err_addr(struct amdgpu_device *adev,
 			dev_err(adev->dev, "Fail to fill umc error record, ret:%d\n", ret);
 			break;
 		}
-		radix_tree_tag_clear(ecc_tree, entries[i]->hash_index, UMC_ECC_NEW_DETECTED_TAG);
+		radix_tree_tag_clear(ecc_tree,
+				entries[i]->pa_pfn, UMC_ECC_NEW_DETECTED_TAG);
 	}
 	mutex_unlock(&con->umc_ecc_log.lock);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index b4974793850b..be5598d76c1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -81,6 +81,11 @@
 	(((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
 	 (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
 
+#define UMC_V12_ADDR_MASK_BAD_COLS(addr) \
+	((addr) & ~((0x3ULL << UMC_V12_0_PA_C2_BIT) | \
+			(0x1ULL << UMC_V12_0_PA_C4_BIT) | \
+			(0x1ULL << UMC_V12_0_PA_R13_BIT)))
+
 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
-- 
2.34.1

