Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139CDCC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 14:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A3B710E8AB;
	Tue, 13 Oct 2026 14:55:46 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E5410E8AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 14:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsCzq/+XmoAFo2e/leicYwUgaKI4972Gn9G46ou1SGl9LlMS9cQPByinRztQAw1lrNYFE7VQVoihOoAb48jT+y3fbgOodufQjhkjgkB7+kezPHgjpzKZI4kr1e4GuPquGL9cRJSumjJ6cUUUOcQ83zpayaqvUXxJHipGNmCPWYhcEq5LynwYtyq8iJ/ySpe1uX4QzY4QYwe5mEsM1M9chIkCL8MwRldKSnYKDKOFEEb6x6QG3VB8lPuE8oh0uv9Pbsf02DAS58yHaI3SWhfgpO96zf8CqD9kEGfOGq2QyykhLOe5QmDoG7f4T+0L0fha8w7ScHtHgYoLW5TBYE8v4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAJiblv0XDzlCyhpklCGfw0HCplZ6/tZ9rRrlRayaww=;
 b=kT8mRco8Ldl1zWob2zIqIB0vh+yaFIDwfd90lZek2cK/9NnP2HfmvoEGK3L5j+kUrJBJzUndqHIjRTqr/4v7MpmZLzsnqVBbixyeOJLivlzdi3/3zlK1Bjp85BFLH0P6FFw4yYtqwxPtSXufSLdGKAF0u0+0Vnpd2PNm+/hSfi44SkCDIJ/j0YbCeGLcfo/7yq8XO3vN98YLj+5OiKXSK2HO4ccrDkBf62fprdtdxCZ6SYNBV8ucR6hezrCA7v7kYdkC37yw1kDXk6DO3mds5DatavUs8vDRR6+XV65LcsJSOrZD5ZsbTx83acj8vjvhPg10yzU/RHJrFI9XCVmbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAJiblv0XDzlCyhpklCGfw0HCplZ6/tZ9rRrlRayaww=;
 b=O6q1yPzC+P1uWI5nYIm8wAR4oCnjAJvbIYzjjuRxR+/l5vCFZvOR6SBSRuc0iwIqrfOK52LWJ8VYxf4EjX4J1lLsF4+cTqD059fOSvQsNEBpDFVf/pMlzHZ7deoSnQ9fX9xWBKYHY+EBsoo0a5c03uPC7co4kXGa7EQ8n65//qE=
Received: from DS7P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::19) by
 CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 13 Oct 2026 14:55:36 +0000
Received: from DM3PEPF000265C5.namprd03.prod.outlook.com
 (2603:10b6:8:25c:cafe::ab) by DS7P221CA0016.outlook.office365.com
 (2603:10b6:8:25c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 14:55:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C5.mail.protection.outlook.com (10.167.23.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 14:55:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 09:55:29 -0500
Received: from RSNDADJELK01.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Tue, 13 Oct 2026 09:55:27 -0500
From: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, Dejan Andjelkovic
 <Dejan.Andjelkovic@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Enable IP discovery via PSP mailbox
Date: Tue, 13 Oct 2026 16:55:24 +0200
Message-ID: <20261013145525.1251002-1-Dejan.Andjelkovic@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C5:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ca141a-37d3-4587-f816-08df293a09c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xGxhcJRnjvL2vX6j0YMUAb6Z5r/o3n8qxZFlCUWk+1IUMV/pUI7OuWaKq8+wep4ft+bYJOw256yIpkeaSY/e7ZQn0mcJ/yMkkVNsKpj41BA/eEwqGZBmCjfDDJBU+LEFU1RA9CMzkm/fZkSVwsaaNr6zVTRUY++Ay4S8gVuRW0PqD0qxL5lmCUxACexPrW1FJyDuVcsnwUJVbZUeOb1HEoNx9SK/B3xWflISiLPn59XN3O9d+GQUBgtPkDN4kSZx9o82btBXVPjrFddqsZUqJg2MD3Zp5Fi9gVIJWuzZ19MMrvB1m7hg6t3f5iPuIjYIFh7LgqvAiHgoMZnhx+i1e8yqI5aO/sjd/g5NniVxhZdRxMEBv3msx73ORygotARk60xbP7Uxy+2S2RBdjdaUwEQeVxbUt6uhEkRdW6lSwJSH+/hPreqf2o58pixS4vNjAlEQMYu2veKiEubm0bkykFEoFO+Ym+2ZRmXLGxh08a1jQxgaWI0QpItbRzKMm5OKoOiAR96oVLjKBQzgiQmcUaPkcnY+ZmJgGgTmMsFdhrVyHu8zC6hr/zPm1GEKhOGJSrNokPn+c2BG/HP4mWXbZOU8uSIG3f8ZOFsfBiz4qjN1FoPaZdGFuDzax3JaqStXYSkiLtpDZJldZa7iBxE4Kyi6l96Ro8mdFr4tlyR/7CKvfLxNNogEAgWgua1nE1w7QLeAaSR2EWJeJk7/KSYFNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F99HWVAMVEbFavHxt5O1uacKUjVXBVrtpR69jg86g0Dy9Y6QM5fSdm2flxg8PPcbvyh6xfgOSBBkq7UMX/VnnkzKGzP4TnMYpbdeiYCcqSA67mWOTvC/36KWwRAERbaZIKlecybG+vXzEzsYOMr6wUj2O0xx5ut6N4wxQz+ZdRGBoEtnYKcPUP2hszOyK4wRVs+gQIpfVlK8NnbbKmtKP/OLr+ZoZ2EBvwvfBz98p67xyd1DjxuFS9igsoR51kuin/91nIT6yTyACsPQ4vesCn20H+JbQe9ExgDuG8v5EmvJmto9Vm7/58K7o3ZOWJphz33pfOo6y/xpfTxaMMs683ldgrTEGWzCUBpY46n0PANiXia58ArN03owHMwKqtJaBPc2QkxsMW4Lv+3yZwQlHvdN/nkg/9pmjzdVlXLudLpgklFnj4m2v+5tNedxkQms
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:55:35.8114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ca141a-37d3-4587-f816-08df293a09c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250
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

Adds support for IP discovery via PSP mailbox using guest phys
addr for passthrough A+A.

Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 58 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  1 +
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5564850e3ff4..3372de34149c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -28,6 +28,7 @@
 #include "amdgpu_discovery.h"
 #include "amdgpu_ualink.h"
 #include "soc15_hw_ip.h"
+#include "psp_gfx_if.h"
 #include "discovery.h"
 #include "amdgpu_ras.h"
 
@@ -149,6 +150,10 @@ MODULE_FIRMWARE("amdgpu/aldebaran_ip_discovery.bin");
 #define mmRCC_CONFIG_MEMSIZE	0xde3
 #define mmRCC_HW_DEBUG		0x10c01
 #define mmMP0_SMN_C2PMSG_33	0x16061
+#define mmMP0_SMN_C2PMSG_64	0x16080
+#define mmMP0_SMN_C2PMSG_69	0x16085
+#define mmMP0_SMN_C2PMSG_70	0x16086
+#define mmMP0_SMN_C2PMSG_71	0x16087
 #define mmMM_INDEX		0x0
 #define mmMM_INDEX_HI		0x6
 #define mmMM_DATA		0x1
@@ -410,6 +415,46 @@ static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev,
 	return -ENOENT;
 }
 
+static int amdgpu_discovery_wait_psp_gfx_ctrl_resp(struct amdgpu_device *adev)
+{
+	u32 val;
+	int i;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		val = RREG32(mmMP0_SMN_C2PMSG_64);
+		if ((val & 0x8000FFFF) == 0x80000000)
+			return 0;
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int amdgpu_discovery_read_binary_from_psp_mailbox(struct amdgpu_device *adev,
+							 uint8_t *binary)
+{
+	phys_addr_t phys_addr;
+	uint32_t length;
+	int ret;
+
+	phys_addr = virt_to_phys(binary);
+
+	length = adev->discovery.size;
+	length = (length & 0x0fffffffU) | (0x4U << 28);
+
+	WREG32(mmMP0_SMN_C2PMSG_69, lower_32_bits((u64)phys_addr));
+	WREG32(mmMP0_SMN_C2PMSG_70, upper_32_bits((u64)phys_addr));
+	WREG32(mmMP0_SMN_C2PMSG_71, length);
+
+	WREG32(mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GET_IP_DISCOVERY);
+
+	ret = amdgpu_discovery_wait_psp_gfx_ctrl_resp(adev);
+	if (ret)
+		dev_err(adev->dev, "ip_discovery: PSP wait timed out\n");
+
+	return ret;
+}
+
 #define IP_DISCOVERY_V2		2
 #define IP_DISCOVERY_V4		4
 
@@ -768,16 +813,21 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		drm_dbg(&adev->ddev, "use ip discovery information from file\n");
 		r = amdgpu_discovery_read_binary_from_file(adev, discovery_bin,
 							   fw_name);
-		if (r)
-			goto out;
 	} else {
 		drm_dbg(&adev->ddev, "use ip discovery information from memory\n");
 		r = amdgpu_discovery_read_binary_from_mem(adev, discovery_bin,
 							  is_tmr_in_sysmem);
-		if (r)
-			goto out;
 	}
 
+	if ((r || !amdgpu_discovery_verify_binary_signature(discovery_bin)) &&
+		amdgpu_passthrough(adev)) {
+		drm_dbg(&adev->ddev, "use ip discovery information from psp mailbox");
+		r = amdgpu_discovery_read_binary_from_psp_mailbox(adev, discovery_bin);
+	}
+
+	if (r)
+		goto out;
+
 	/* check the ip discovery binary signature */
 	if (!amdgpu_discovery_verify_binary_signature(discovery_bin)) {
 		amdgpu_discovery_log_bad_signature(adev, discovery_bin, fw_name);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 49aa95c76745..bc777f53a193 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -49,6 +49,7 @@ enum psp_gfx_crtl_cmd_id
     GFX_CTRL_CMD_ID_GBR_IH_SET      = 0x00080000,   /* set Gbr IH_RB_CNTL registers */
     GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x00090000,   /* send interrupt to psp for updating write pointer of vf */
     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy GPCOM ring */
+    GFX_CTRL_CMD_ID_GET_IP_DISCOVERY   = 0x000D0000,   /**< Copy IP_DISCOVERY_DATA to host-specified address */
 
     GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
 };
-- 
2.43.0

