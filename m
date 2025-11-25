Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BECFD0E6F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 14:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D06210E41D;
	Tue, 25 Nov 2025 14:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="clpcXoCF";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010007.outbound.protection.outlook.com
 [40.93.198.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B31310E41D
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 14:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bx297Gy0SamvACgpaB1DLbWGkm4n7STA8dJyuUzQEbgSejAjvrsnjUH4U0jDVdXVhDTGttHL6CkuGY9iGPCP3UWegFiL4QJQ5o/L1l9floZUuSAxN+liDnS+2Khxgp0nF7cMRFWDUiC1TtfwB5pbGuoZdJKE2AYP1IVuKLENpuzWIeLR0dTdQZKi9KhFZi/Lf9EZxWsHTY0qG/Obp+QRV2Kdbh51xqHYMVKWyIRdSP45LfdSRYCBBkLU10HwqP1R3AgC7MSrLjF5qFSfh1k+bcFVFUMPN1kCQwPNW1SZJVx/TiyZARjBb9Dubye53Ly/zqeqtSjnywtpwGV2++uiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRwQH1N1Hg+e42lMK2vxeeCkIc7E43e3nP/m4keyT4g=;
 b=QFb0zeBb+EkUfKoMx7I9MNnXrgcYUzCThpbATz3c1sDRQq2nc3j7y5dHMDzawW7eLU7riDZd4hvMagyqlWmHnOeTJFg+QIlnWu/n5efN/9TqVHEqhkXsNO7QVCUO55zHW1Sr/KsjQFrwYsvqCfceNYGEF2D7bqYaZj3k4jGBZtGdkhwKru1UMSlJUMSwIWWpiNHpO9E2y7vXxuFeo2MT1urey07curXH9dM384BvhcKZy642Hua7rOaue/gPmHG9HhN3bNyaWodtAZY2CHgDwFWCPyEv+VQwUba7Jv3HQO630AkGZfFhBRXdnUkswPKC/Cyc67VbPFr9v7XC2k8Gmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRwQH1N1Hg+e42lMK2vxeeCkIc7E43e3nP/m4keyT4g=;
 b=clpcXoCFHpcFmv5KUuz5E0LPOo7dTnXsas7T4N3G1e6xquy/7seQm46XeSA3Yt3QOveLaiHH3re7yxOlqxCmXemAACkAOM9B6EMBgotuKXwGeOSbt2uyxzy3qcyxUam1Eg/qPsdc/EOrBWpKN+vTAMUncsbiSO0M2EY3fo1WFMY=
Received: from SA1P222CA0063.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::12)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 14:57:43 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::15) by SA1P222CA0063.outlook.office365.com
 (2603:10b6:806:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Tue,
 25 Nov 2025 14:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 14:57:43 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 08:57:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: update rlc autoload function
Date: Tue, 25 Nov 2025 09:57:23 -0500
Message-ID: <20251125145725.2045485-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2bace1-e03b-497b-08e0-08de2c32fc93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nrKxkgdqQCjltdZ2D9scBw9zHnGm61/3a5X//sVh4ih78cTdRdB9QZLw2OPh?=
 =?us-ascii?Q?JCqqtaJERl+MJes7oPi2WjFK473/Ur5ux/AmeOGf0UXE+gJk2xGAakNEt9pQ?=
 =?us-ascii?Q?Sgw4WHDm74FB0q7IpYzGbNbK5xVFaus32eJn1ureQSvdxhfGaJpmnfVFvRid?=
 =?us-ascii?Q?xIexmY0mczgay+vDqzDPFMJ1zQS2zJ18wIksb+VBAx4ErPqCmesCcoR3VEFr?=
 =?us-ascii?Q?xIwHmYgLAzcM7UJMJBbwmpt8tZ6aPjgeOE85vGE9gZJ7ZVjgcjN8ZJsUewuO?=
 =?us-ascii?Q?hwyQ+Cp+KCChpTlkKDYqAqyDOT5EDsGxziDUumSW/jOeQG4INUXwUzmDXMoP?=
 =?us-ascii?Q?8Jzs0r7lsbftVeQjo/DqzDYncjW2tGRfTmNrh1rwvqjWT8Hz+ceHp2+LQ0ZC?=
 =?us-ascii?Q?0yze77Qfdzk7xyW5E8Lk1+kTJB/tnB8t3xQusdCEkVzxpwJXYufjdyW45SGt?=
 =?us-ascii?Q?tYeksX3Xi1kCo0i0U7EHj3OhWwaCytjbPl4efCEyMx1QTlyDwgjXnpWccFHs?=
 =?us-ascii?Q?nTJ+KIMVztNNQ1jP8enOPquD295J+77icRow+jTGeV1ooOoklsfKqwTaH4tq?=
 =?us-ascii?Q?TqeZjH/glZt+VtynhKzPJiFjryrtEzAQtEyxvNLXF2EmVlOnizeriXoM5nFD?=
 =?us-ascii?Q?Nh2h/sFnMrFTfrAGWh1wb3zQloY0brc/rMkP+HwsFzlDjJvAQcOvfFRR6wz/?=
 =?us-ascii?Q?uNSbLfuwCUKwb+bHPxqz/kpHupYE4wZKKF6NnoNDfKgg0r5UNOhaFiNHLV1+?=
 =?us-ascii?Q?L960VR2YXcUYO2Qc4y/aXvYYbJi2ZqZFSSKpVhFoPtFQlcHSqnJN296d9ON/?=
 =?us-ascii?Q?UmbJNCUV4WtpJyWdBSrXywvAJMqiSO5Kt9sapWkxrM42G3yJMelU0oQYFaLC?=
 =?us-ascii?Q?PAicLXHzRplLFUDbgvlZSr2irGACrOweT+H0Jq7rutWNlE1o5FcMxgNZ7gmh?=
 =?us-ascii?Q?ohS7CWR2Fkmp8ln0v8DZrmY3KJX73ereEGjmMSNOi7Pp/zYmSZ4q5/CkphYk?=
 =?us-ascii?Q?rPIGFyTlz3JgNr1FNsLOKMU/xl6+LGHV4/93w+eIg9WBFUPS8c3vTlbx3Y1n?=
 =?us-ascii?Q?OFCL6t8bE2Dpk7WlXUWT1APsxkObAJzBSW/GiTUX63FkzcBdJnXSa6j6KL9f?=
 =?us-ascii?Q?qXb7KCXe06rlCZ3GqekdHhSX4puBkAfgHSXy9oHSQdDf092hUhwGnvZ/y4Qg?=
 =?us-ascii?Q?iuC77hjjoiUvUXK4e+0E1N6zUom1oeEhgYQUIZFyK9usV0Xjq4IWxxofuitr?=
 =?us-ascii?Q?yRj4ilFm1FsXDK9cq6FkiSw4wqA7CZdCGvCPTBFxWGD0YRZBvi9HeIENTo+4?=
 =?us-ascii?Q?LRQEAgUzfRe70WLrut0PRDknE0vY0ZH0qPSt8JReBLF6go9O3a2geBveKLb5?=
 =?us-ascii?Q?27DjGe5awWJtzKbGd973nTNo6hd2aL87OaYNC0Xm0ke2xeiwAMafIKvJHBiF?=
 =?us-ascii?Q?hvnCEcpu06R17DfxL1OtFVdSsIb9grceSSpB7GxwnfcN6J0qVK3JEfk2z0lW?=
 =?us-ascii?Q?SrJTdhhlgwcvl57OLeWy5A3QV0ewnCpPqRc85UF5icD9Dwfk0D/o3uGbOIs0?=
 =?us-ascii?Q?Wkj98JJFuSPeuGtQN30=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 14:57:43.0286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2bace1-e03b-497b-08e0-08de2c32fc93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
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

From: Likun Gao <Likun.Gao@amd.com>

Update rlc autoload function for gfx v12.1.0
to support muti-XCC firmware autoload.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 48 ++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 194d66c0b4271..ae7e2c254da2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -768,6 +768,7 @@ static struct {
 	unsigned int		offset;
 	unsigned int		size;
 	unsigned int		size_x16;
+	unsigned int		num_inst;
 } rlc_autoload_info[SOC24_FIRMWARE_ID_MAX];
 
 #define RLC_TOC_OFFSET_DWUNIT   8
@@ -775,6 +776,11 @@ static struct {
 #define RLC_TOC_UMF_SIZE_inM	23ULL
 #define RLC_TOC_FORMAT_API	165ULL
 
+#define RLC_NUM_INS_CODE0   1
+#define RLC_NUM_INS_CODE1   8
+#define RLC_NUM_INS_CODE2   2
+#define RLC_NUM_INS_CODE3   16
+
 static void gfx_v12_1_parse_rlc_toc(struct amdgpu_device *adev, void *rlc_toc)
 {
 	RLC_TABLE_OF_CONTENT_V2 *ucode = rlc_toc;
@@ -786,6 +792,28 @@ static void gfx_v12_1_parse_rlc_toc(struct amdgpu_device *adev, void *rlc_toc)
 		rlc_autoload_info[ucode->id].size =
 			ucode->size_x16 ? ucode->size * RLC_SIZE_MULTIPLE * 4 :
 					  ucode->size * 4;
+		switch (ucode->vfflr_image_code) {
+			case 0:
+				rlc_autoload_info[ucode->id].num_inst =
+					RLC_NUM_INS_CODE0;
+				break;
+			case 1:
+				rlc_autoload_info[ucode->id].num_inst =
+					RLC_NUM_INS_CODE1;
+				break;
+			case 2:
+				rlc_autoload_info[ucode->id].num_inst =
+					RLC_NUM_INS_CODE2;
+				break;
+			case 3:
+				rlc_autoload_info[ucode->id].num_inst =
+					RLC_NUM_INS_CODE3;
+				break;
+			default:
+				dev_err(adev->dev,
+					"Invalid Instance number detected\n");
+				break;
+		}
 		ucode++;
 	}
 }
@@ -837,25 +865,31 @@ static void gfx_v12_1_rlc_backdoor_autoload_copy_ucode(struct amdgpu_device *ade
 						       uint32_t fw_size)
 {
 	uint32_t toc_offset;
-	uint32_t toc_fw_size;
+	uint32_t toc_fw_size, toc_fw_inst_size;
 	char *ptr = adev->gfx.rlc.rlc_autoload_ptr;
+	int i, num_inst;
 
 	if (id <= SOC24_FIRMWARE_ID_INVALID || id >= SOC24_FIRMWARE_ID_MAX)
 		return;
 
 	toc_offset = rlc_autoload_info[id].offset;
 	toc_fw_size = rlc_autoload_info[id].size;
+	num_inst = rlc_autoload_info[id].num_inst;
+	toc_fw_inst_size = toc_fw_size / num_inst;
 
 	if (fw_size == 0)
-		fw_size = toc_fw_size;
+		fw_size = toc_fw_inst_size;
 
-	if (fw_size > toc_fw_size)
-		fw_size = toc_fw_size;
+	if (fw_size > toc_fw_inst_size)
+		fw_size = toc_fw_inst_size;
 
-	memcpy(ptr + toc_offset, fw_data, fw_size);
+	for (i = 0; i < num_inst; i++) {
+		memcpy(ptr + toc_offset + i * toc_fw_inst_size, fw_data, fw_size);
 
-	if (fw_size < toc_fw_size)
-		memset(ptr + toc_offset + fw_size, 0, toc_fw_size - fw_size);
+		if (fw_size < toc_fw_inst_size)
+			memset(ptr + toc_offset + fw_size + i * toc_fw_inst_size,
+			       0, toc_fw_inst_size - fw_size);
+	}
 }
 
 static void
-- 
2.51.1

