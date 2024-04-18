Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD58C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 635AD113945;
	Thu, 18 Apr 2024 03:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kj8x0i7p";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02F2113945
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/yocQlsbgYBuPRbyAH4tmrJQK1/004K46FdAX6Co9mGZJ04W6Q/TZIvHKZ+e7YC+tMzN+sFDNqSLgLXtn1/2rtcQHT5TdnzGsTNUivptzl17a3QWFsLWHSBdvEXmbtZArR5ASAnfQKCBeMW1cLd9P/XACVBBg4f3girfU9bfLcHs9MWJS0q5vsk4weV3l5VIuXxDw21iB6llUQAjy/DI+gj2mBwWVJ8UzCQLXljbVV6y2RIazLsytkkKpUrbvDwpar+cV9orM8+aoT+xRjOhWg1xC2QiNWmx1a0alFDZ2SjC/EgTMDC6olMoH1/1mwR0edggJ5bTlu83z5XfR5eFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzvNVvTTX5DBtP0jaRgIhE07kvlbZKX5Umxy9apimjU=;
 b=Q3nu0x4mxksfhTsmECjJhyLDXyC0jgYncnidZ7wY09iMM5QX4lseh5K2Exsz+MQA0MVDNiMsqv+twGINQolNLzGhbRTnt69P1EfPLPkxCxCmfhWMYh0Cad0sAJyRf+sy8iu7l5VaMleP+1hnq7Rej0LrIV6SLLfajxM08qOoSC23BtOvmo8KcnYHs3kiE4CVAVBdc0xPLhYKBtjyWRSWPvZEQeZvsypmsFzcZGXZMdwPvB4v4mMzW1YxsU5LMXy+iAg9HE4hJAvRNyCRS4GoOkENqV2PjR0U3garMr8HCMdYpxYo5uMrZ4eHeQLmA6OfIloqkUN9KXhpmHdtPwgHww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzvNVvTTX5DBtP0jaRgIhE07kvlbZKX5Umxy9apimjU=;
 b=Kj8x0i7p+07XYkN+JmZcMXQmeSTX0FwEj5yuHBSv+f6h/Q4yP5hVdzsHnvWWJ55I722Y0d4ylJXiPJh60jG9LeVBTGX4e1MpThxOxcX1Ab1/Md6wZboZ+N2oDo7UkBNe62XN0O6yu8UTOUAIQUjQvW/dUkJdAN9gf4MWQFBVRLQ=
Received: from BL0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:2d::23)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 03:01:50 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::aa) by BL0PR03CA0010.outlook.office365.com
 (2603:10b6:208:2d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Thu, 18 Apr 2024 03:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:01:50 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:01:47 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 07/15] drm/amdgpu: umc v12_0 logs ecc errors
Date: Thu, 18 Apr 2024 10:58:28 +0800
Message-ID: <20240418025836.170106-7-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418025836.170106-1-YiPeng.Chai@amd.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: c47daa9c-5b76-4ffc-b67d-08dc5f53e4c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5YG0UOkTdogLSBwc8Esso01lyNZpBPHc/X6zES+59vFb52G+GnHKGDbEWmoLx0n2QcDtO+0o2JUegt6o/fww/GBMqrXkdPXET7a1mWkRkNtsHgiaMz2X+5GunpYKo2PJQpt8RbKpgnFJ9D3Aaiw8P9pxwH9viX1AJhBcJ/aIvhYbOoJ0PjBil3EO0Cfx6FXxE2vBaBD9Hl5MmaSsu3LPwvMjX10wN0bbAwERn++EUTwh2EWjUU6VmsBxlUnWcUTQleJxM9sHgvgJMruu4EP6Zy/R39p3M83z8FM7N6r84nqN6gYatPleDg3AlB+/yjz+OhtjkIATiH8npb6czzF7UILU1aYJ01AWz1X6Ksqs69RrmiiIClShq5r5HGx4adJX3Dna4jL9+GSIoSa9w1xeO895Wbzgapo5+5S09eE0NuuSPUwAwxS5lLQHjPqtl1W8cQdcxatsRQ0cZckoV2FvDrIrrtbRkmXmBPM/3b+6UuKhta9lHtrfu7qtRioPX5vQ2eYpDZAa6WxnZ8SP/HrYjnSzRC89h4a8zwvf/yXEV9rr9rNs4ensuEHj4EA1ahzar53/uTO2fMgN13PherrMiKa1n+EvaXmx+rQJ5zTdWimfi6XvizA4JrAf2qQUI6z3GLubl/odAdvIXrSUI4Z4ss5ewYQomd1x8wPet2cS1gB6e5UrQNBXWz1iDFvgKbzFKgedUYTDHuH3muvFH9AsEfg0/LeGy2GuGl2n9XV2Jq+FVsQ/2tGSw77Lf3OunS5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:01:50.3226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47daa9c-5b76-4ffc-b67d-08dc5f53e4c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785
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

1. umc v12_0 logs ecc errors.
2. Reserve newly detected ecc error pages.
3. Add tag for bad pages, so that they can
   be retired later.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 67 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  7 ++-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 41 ++++++++++++++-
 3 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 7006a57277ef..0f2d765c4e2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -21,10 +21,13 @@
  *
  */
 
+#include <linux/sort.h>
 #include "amdgpu.h"
 #include "umc_v6_7.h"
 #define MAX_UMC_POISON_POLLING_TIME_SYNC   20  //ms
 
+#define MAX_UMC_HASH_STRING_SIZE  256
+
 static int amdgpu_umc_convert_error_address(struct amdgpu_device *adev,
 				    struct ras_err_data *err_data, uint64_t err_addr,
 				    uint32_t ch_inst, uint32_t umc_inst)
@@ -446,3 +449,67 @@ int amdgpu_umc_update_ecc_status(struct amdgpu_device *adev,
 					status, ipid, addr);
 	return 0;
 }
+
+static int amdgpu_umc_uint64_cmp(const void *a, const void *b)
+{
+	uint64_t *addr_a = (uint64_t *)a;
+	uint64_t *addr_b = (uint64_t *)b;
+
+	if (*addr_a > *addr_b)
+		return 1;
+	else if (*addr_a < *addr_b)
+		return -1;
+	else
+		return 0;
+}
+
+/* Use string hash to avoid logging the same bad pages repeatedly */
+int amdgpu_umc_build_pages_hash(struct amdgpu_device *adev,
+		uint64_t *pfns, int len, uint64_t *val)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	char buf[MAX_UMC_HASH_STRING_SIZE] = {0};
+	int offset = 0, i = 0;
+	uint64_t hash_val;
+
+	if (!pfns || !len)
+		return -EINVAL;
+
+	sort(pfns, len, sizeof(uint64_t), amdgpu_umc_uint64_cmp, NULL);
+
+	for (i = 0; i < len; i++)
+		offset += snprintf(&buf[offset], sizeof(buf) - offset, "%llx", pfns[i]);
+
+	hash_val = siphash(buf, offset, &con->umc_ecc_log.ecc_key);
+
+	*val = hash_val;
+
+	return 0;
+}
+
+int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
+		struct radix_tree_root *ecc_tree, struct ras_ecc_err *ecc_err)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_ecc_log_info *ecc_log;
+	int ret;
+
+	ecc_log = &con->umc_ecc_log;
+
+	mutex_lock(&ecc_log->lock);
+	ret = radix_tree_insert(ecc_tree, ecc_err->hash_index, ecc_err);
+	if (!ret) {
+		struct ras_err_pages *err_pages = &ecc_err->err_pages;
+		int i;
+
+		/* Reserve memory */
+		for (i = 0; i < err_pages->count; i++)
+			amdgpu_ras_reserve_page(adev, err_pages->pfn[i]);
+
+		radix_tree_tag_set(ecc_tree,
+			ecc_err->hash_index, UMC_ECC_NEW_DETECTED_TAG);
+	}
+	mutex_unlock(&ecc_log->lock);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 4f3834fa10a8..c83d24097c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -52,6 +52,8 @@
 #define LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) \
 		LOOP_UMC_NODE_INST((node_inst)) LOOP_UMC_INST_AND_CH((umc_inst), (ch_inst))
 
+/* Page retirement tag */
+#define UMC_ECC_NEW_DETECTED_TAG       0x1
 
 typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst,
 			uint32_t umc_inst, uint32_t ch_inst, void *data);
@@ -127,5 +129,8 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
 
 int amdgpu_umc_update_ecc_status(struct amdgpu_device *adev,
 				uint64_t status, uint64_t ipid, uint64_t addr);
-
+int amdgpu_umc_build_pages_hash(struct amdgpu_device *adev,
+		uint64_t *pfns, int len, uint64_t *val);
+int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
+		struct radix_tree_root *ecc_tree, struct ras_ecc_err *ecc_err);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 085dcfe16b5e..6c2b61ef5b57 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -546,8 +546,10 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	uint16_t hwid, mcatype;
 	struct ta_ras_query_address_input addr_in;
 	uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
-	uint64_t err_addr;
+	uint64_t err_addr, hash_val = 0;
+	struct ras_ecc_err *ecc_err;
 	int count;
+	int ret;
 
 	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
 	mcatype = REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);
@@ -589,6 +591,43 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 		return 0;
 	}
 
+	ret = amdgpu_umc_build_pages_hash(adev,
+			page_pfn, count, &hash_val);
+	if (ret) {
+		dev_err(adev->dev, "Fail to build error pages hash\n");
+		return ret;
+	}
+
+	ecc_err = kzalloc(sizeof(*ecc_err), GFP_KERNEL);
+	if (!ecc_err)
+		return -ENOMEM;
+
+	ecc_err->err_pages.pfn = kcalloc(count, sizeof(*ecc_err->err_pages.pfn), GFP_KERNEL);
+	if (!ecc_err->err_pages.pfn) {
+		kfree(ecc_err);
+		return -ENOMEM;
+	}
+
+	memcpy(ecc_err->err_pages.pfn, page_pfn, count * sizeof(*ecc_err->err_pages.pfn));
+	ecc_err->err_pages.count = count;
+
+	ecc_err->hash_index = hash_val;
+	ecc_err->status = status;
+	ecc_err->ipid = ipid;
+	ecc_err->addr = addr;
+
+	ret = amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tree, ecc_err);
+	if (ret) {
+		if (ret == -EEXIST)
+			con->umc_ecc_log.de_updated = true;
+		else
+			dev_err(adev->dev, "Fail to log ecc error! ret:%d\n", ret);
+
+		kfree(ecc_err->err_pages.pfn);
+		kfree(ecc_err);
+		return ret;
+	}
+
 	con->umc_ecc_log.de_updated = true;
 
 	return 0;
-- 
2.34.1

