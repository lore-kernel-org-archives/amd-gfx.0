Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4029FC25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 936A610E258;
	Mon,  3 Jun 2024 01:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vD4KlKuR";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4242910E251
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMub7nx+rK4xl8TSQvDP7+plq3G9LSbQxdwpOuwG1OAs+cx825bm8H4+nZJqMdvXPfkewRGfcHr0lFLejSnGaqD5r8h9Bt5qjXqDex3EbaUcv3E58i5KjyKNmYRg/xRK22cBX5st1n0BaRGDGEa/tFRSiOilr0Az4KAPsNNWfgaG5zggezdSPqFbNMrZ5c1JCA9AwrsYHbhOeiOzjYcyAXiySVG1xncLZmAn7ygiK0EXBqzXVtk/E8XkoJ+Pm8NziY6HpBIIgzha38vCpP38DGem2EU4GrFvepUCfZzMwjy3sQXKn32JTSDo8QQkJzSXSvEHlfHn25aJvmPmtv1ayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viZg8SI8wF7xKy4CjlbkuGCyNi0jrPD5z8xmHTrwmnk=;
 b=WObfttsajNoWwIK0h8kMF0hN/omTIBC+KwiGxVQu18wU9aBc6ROQvNz1jmlp/ulbaanF2BRuVxxWwuAbyFSgo3+KgOEdmFSDegQKmlwLRc9WRjrALBwTYRfibd78J4pvi24KOfEU2/nE+o7eGwVk3VSlArLCgXhl0f//BonbvC5Dc0gdun1wPb+209JVv1oCfjEN+QJB4Zpow1iGVk6XuWd4njdPXoukOZPzF83t+393yRytqB5Fw6TnIAn1HHB1/chwLvet7DPXUKG6pK7qRX8EJ5q4HXqDGImQLUySUId3MFEGqO8ZrdFISon8zS7WjhmRvcNVN5uRwZEnlGbKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viZg8SI8wF7xKy4CjlbkuGCyNi0jrPD5z8xmHTrwmnk=;
 b=vD4KlKuRIjVVUMA3vkb+lcOBHyiBlkTYqVi9ygNY/hyZ4VEqymURyn/JTI3fmM/LlR5Jea914283gfEXtCm+eu8/KpJi3L4DN4Y1esXi5MCa7fm/fuT9E5gZ7ktjC8UsG7KB1B2aAb8E0y3jjFme7CdYHuEAh6l/Sk0IHr13WVk=
Received: from SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.25; Mon, 3 Jun 2024 01:43:12 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::4a) by SJ0PR13CA0176.outlook.office365.com
 (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 01:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:43:12 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:43:05 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 18/18] drm/amdgpu: refine gfx12 firmware loading
Date: Mon, 3 Jun 2024 09:42:12 +0800
Message-ID: <20240603014212.1969546-19-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DM4PR12MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbf0e93-87a0-4ffb-c3f9-08dc836e8774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9JVcP2FbjbyKSj6dxWrtttCD7PbJRCIewBYfSapBXu4y9ZjUu8lDpqXF9OUB?=
 =?us-ascii?Q?6+JBrfQkyigffGOqtWE6xENIG3y9H4VZaDvyqySQTYTuwIPCr4nINmzM8LBv?=
 =?us-ascii?Q?G/ZD7IywGO70qMAgyIiqrGs6sOc3V0cFrtGujN2HG6C1X02RDHz+Nah1X/Va?=
 =?us-ascii?Q?Y4peiF4UBlBgNBonm46m8RvfdNP+JsQ8BZ73aDwj0xkBflJ0de23eAtGZyzq?=
 =?us-ascii?Q?Ol9N8hP31kJ3GzgoaYWppuJe/01etsd37xLQQJBqBkuE9eiRpL25K99QlXLE?=
 =?us-ascii?Q?fuwgnvTExXEZOPVt+4yajiY8eWhAsU7Y5EF6eWDr+MbhDISlkzFee3Ppa5wz?=
 =?us-ascii?Q?B6pO6R0zU8Sov/NA5ZDK/7FUxcT2YhEkaVJ8z6BPtE6Zav3hMMAihB162dGT?=
 =?us-ascii?Q?l8AWnF+0amp+BrO1t/2VHG+hXS3Q2oIjilsiKQh0pJMRX5mOxlOUE+g4bl2L?=
 =?us-ascii?Q?tV4rq4q9yJphzkEkca117EBUKNecQ8glsSxXL5gEEWsAhIv/0EjuGxExiqjk?=
 =?us-ascii?Q?nHrS2baPud6B11dilB6O+aBwIY9uAA+EjSJZcAWi70DNA+g6OB5hKTP90pUb?=
 =?us-ascii?Q?kaJlp+qSKK1p9PytwLrW5g9I/AP4+yw9iHxkLKG2qUbjbrPq3IC+aL2++05I?=
 =?us-ascii?Q?0WjXQRr56e6m9KuVv8+G+o03RW5VBhMpu5lAA/EcO34pmIzttuFoadWum15D?=
 =?us-ascii?Q?00ECEb5198fDGIAaReMNofLCEvs181UdFwOaYFupwhNVmhpwJ8hn2nIipQDB?=
 =?us-ascii?Q?i0nHJgdXp3ne2Dyc+2jyYFIiKvV2QC9OlAbW4omHiJmw/Z/Te9NL7JUZHHbD?=
 =?us-ascii?Q?KbsXSDutqHiJM+00Zr32kmxWtGbhbaBWPMD+6ddyeC4zTw97jmIzuLYgWIyH?=
 =?us-ascii?Q?ypb/Vm4VL5DGaIBLE4DHE2aq4IoXElXS6oJmDEApunGnofdSRGbtEbxE8cMc?=
 =?us-ascii?Q?ie8cbE0gwm5mMa0IhBWKmUNtmbmqnQrXvzBEmH1VzET2zgZIIl+ufUTEr/FI?=
 =?us-ascii?Q?7qa0O6SAWB5mfFjzMAhY0XzrNgmfgRUobl2Z464e1/sJUKvkMrmWubhlB0ct?=
 =?us-ascii?Q?EPb9yNMrpZZ//slv+8UFWkFkjrUQwcWQzxWPKEBtbsFMZjj9dCghiFszbIOX?=
 =?us-ascii?Q?Z1ORKbCturZA4ljNaOwMWHnEhHf99LO/5MfeTXNsl1261gmHdL8DsmwiVpbj?=
 =?us-ascii?Q?dT+v3lYQQfmZPqpAp6aOzSKKaRqqjs74m082JhtnNrNm3ng+Ok7P1h1GEiDQ?=
 =?us-ascii?Q?0xFVdVNwgBJodTtMlWWwjiOct/VadF6ozTDtr6WDfhyACu7fM5yuhpwCXq63?=
 =?us-ascii?Q?GIS+ELME8MknUbWW/AxjztO1LkU5kchwbjFFtIgy9LOl1vCZEMdC+w8nEAZA?=
 =?us-ascii?Q?1cBG1TU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:43:12.0735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbf0e93-87a0-4ffb-c3f9-08dc836e8774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061
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

refine gfx12 firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6419f98e32b6..f37cfa4bfb22 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -386,10 +386,9 @@ static int gfx_v12_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 {
 	const struct psp_firmware_header_v1_0 *toc_hdr;
 	int err = 0;
-	char fw_name[40];
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_toc.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw,
+				   "amdgpu/%s_toc.bin", ucode_prefix);
 	if (err)
 		goto out;
 
@@ -407,7 +406,6 @@ static int gfx_v12_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 
 static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[40];
 	char ucode_prefix[15];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
@@ -418,23 +416,23 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   "amdgpu/%s_pfp.bin", ucode_prefix);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   "amdgpu/%s_me.bin", ucode_prefix);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_ME);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_ME_P0_STACK);
 
 	if (!amdgpu_sriov_vf(adev)) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
-		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   "amdgpu/%s_rlc.bin", ucode_prefix);
 		if (err)
 			goto out;
 		rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
@@ -445,8 +443,8 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 			goto out;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   "amdgpu/%s_mec.bin", ucode_prefix);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC);
-- 
2.34.1

