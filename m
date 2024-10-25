Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A2FD116E0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC3E10E9DC;
	Fri, 25 Oct 2024 02:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JUsY9C9C";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC8E10E9E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCk4Op1OB+m1yuB9tln7yLvbV2hU2VeeWZRlSwBL/veZkjWkOamAK1c8vwoHwPzo2EQf3rxJze2Dz5FV5hAEYzlnj5tcPsSmxfc1CdmQxvWehiWoKS2ZcaRH8e3chXk/iLLT1btCcyXCcXRzSFLx84NwoOYqI31o1jBlktBdi1awoDShoiMxSnXYAtxIMSoapo/M7kZk9CvatJhj/ehuwOW0kftfI2tzTX0UrqjFaumueosxJ0L/Lod3pmQvnhRJ/1MGkIL8LjVHGvC0F652CalkgbSx3AESPRKJs+HGRKKubu7c5JH9J4k3c1T94LHx78HMP53om/20aezcnzaT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqWHPHp41YooixyPT9bOZu64Afk0ps4Cfe2XfGph1X4=;
 b=Na4KACC+fyke/a7zhO9e4sKNYFGXMiMqlCR5nr7fQUr8RJB7asNYk4GvM/2Y8IvYh46MCw45w5XtDz/fgC3OHY5TzCVamoyd9+bOAOpdJSdmA2em8ZbNHwkwYr48+TUg4ohPhmeGSBXpSinWorY8gpie5kyICHxjD9WJ4C3hE9Hk38/UF2ZRl3on6nIDo9OU8uHxA7RIsy4ikeEO7JLn+Sr+N2IayBrEEOWgPrENpJr3zMUIHOQNx3Eg1YqgDm+1yfjOFczND39HNOG+LyNf6X9II5bCBm/yXZCCeBVu93mxEbXBlh4TjuDz2hE20+/v72/miycHtfVLedYqsuc+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqWHPHp41YooixyPT9bOZu64Afk0ps4Cfe2XfGph1X4=;
 b=JUsY9C9CwrxZuOTio+xKMXeaOF+Coaff+BH7spCotwmW8EZ2YAYaSfCPUYqkVI4W/w8PyBbl3KLC3kkifJarkgPi5XCxkic8NTiH1N+pc4ujez2WeuggqunBLYhsVTTURG8DZS3r6KyRl67CuUjcQmyeH5w00/zZzbkdDXjxinY=
Received: from DM6PR18CA0004.namprd18.prod.outlook.com (2603:10b6:5:15b::17)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 02:36:25 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::de) by DM6PR18CA0004.outlook.office365.com
 (2603:10b6:5:15b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:25 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:21 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 26/29] drm/amdgpu: setup_ucode for each vcn instance
Date: Thu, 24 Oct 2024 22:35:42 -0400
Message-ID: <20241025023545.465886-27-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 457a7f82-2900-4e80-9a2e-08dcf49dd264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RRzjvTRrFrXama7VqwaLuQHDVsvG0VWKyvEX6lzCxxTK3cIcQtaYnQTRYb1Y?=
 =?us-ascii?Q?2EVL7Emvd7F+D2sf4PDpHn6xMTxEq5ZzzK8WcovO/PcqavrpMRuukEbkdDI7?=
 =?us-ascii?Q?8vexk9RnoZmwEDhHgJgafM5Wl2RhGs+u+C5/ExFzyKBsHBZoRqm5Kbw7F4lo?=
 =?us-ascii?Q?yGZUTh3Njl4ZQypuZRUtIZA3zKJnit297FFZOwEPCAF/TamAnqde0sX+vkb1?=
 =?us-ascii?Q?97tf9/31e1ZzEkG2T5n6v8cCG29BE0UP+F/kygDSXdu0yBTBARQrI7c/P3zF?=
 =?us-ascii?Q?C6uMyntMAJLOe4vqIbzK+cUC8mweAHN6FNCy6NmuXwrkTOlVLg/Nn1KnPl5h?=
 =?us-ascii?Q?rQokds+dePDF3SPq0pSPWTmB1/DVH+tgfoir5Zr4GFf/PW/jvpBywjDHuoic?=
 =?us-ascii?Q?p/onfs6nFL2PAAjHx4YlNHdf+UYtMr7Ydz4R+zE8eCVKZ2oloZmP0BDT5PeZ?=
 =?us-ascii?Q?eG4TscG1gTV6VsZDMlX1niWHH6UyfSrKnw68XOYxeOaAWckS7a0bqBJYxmoT?=
 =?us-ascii?Q?5iKIyhmBOlwlvkw6SxNEoy/TJzdd7VKDOIw7KNAwjVn7td1cXYW1b9eUiVHs?=
 =?us-ascii?Q?X0SxEYpCnVe30JuGsLs4h8Fse4qfcXhE/rNVnyCK0msBR+LWRgNKyClu5n6m?=
 =?us-ascii?Q?VCyZSkKXowpnTzeT9W1hcgS+BuPo/lRXQLxzRC++cfW2agQaC05CFHXcNV5Q?=
 =?us-ascii?Q?MUh/rQmAMGXPgUklJF0/2Hf6ZWWkfDRMMYCxEfqOomD7Xwqbne2WnnCSzpul?=
 =?us-ascii?Q?nmegqR5042gCFAeeg283bbcY4XnrE/yTxcG357DHLaPy4Tofrfmrkchy13YS?=
 =?us-ascii?Q?3dnIfFGtEUK1QHIrzyihVhWQvD49okkfIrjZOZJD2m1LeRWNUH7Q5+iZmCyr?=
 =?us-ascii?Q?JXJe9vIdqsrt6RbybJ73DajcGisRho7t7CGbLMSfswU6Fw7TtkfWDqhmy9Ck?=
 =?us-ascii?Q?TxMC/di7wsfnG1Wh6qKC+lsVUzSkFga2oTC+NUnIbeisErj9++1TDeIwKrUb?=
 =?us-ascii?Q?v5AhmcSWh9brI9ld9fmfkzCiDIpFMICCZQeqL/XFgvOOKCuDL7tnNloSwDyL?=
 =?us-ascii?Q?2ca50kI0fQMB1zpd2uS6eMAN+0p4qNhINzwzo2BiQQxXVfql7aCkbQFQemAB?=
 =?us-ascii?Q?5w8cvkdVyilzFvF3vr/jOuIJtbKX2Jv1W8CYaKVwrEnPKQzSiZmdWzZOTU8R?=
 =?us-ascii?Q?VI+FjT7xJQ2gcJ2Z3E8QGwsbuJmFozC83JbQ3b23yGrh65JpeKEbnG+6t6rY?=
 =?us-ascii?Q?X6B3a3/Oh6/0gkrNzzeogqtmPe/QZv9DOArxY/kz/+hfUVtuAvZNmGZq6nBR?=
 =?us-ascii?Q?yuWRXICSMn3/maiSuvQFIw8MJK5lHd0lJ2wiESK9dK059uPpP8REDm08tVC4?=
 =?us-ascii?Q?TUBjMlDytKPXGXxKtH+kZJNLD3DqfCor8LGcSWCEMG1ZlVai0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:25.4744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 457a7f82-2900-4e80-9a2e-08dcf49dd264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_setup_ucode(), and perform
setup ucode ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 37 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  2 +-
 10 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c4e1283aa9a4..29f6a2b76919 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1049,34 +1049,31 @@ enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
 	}
 }
 
-void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int inst)
 {
-	int i;
 	unsigned int idx;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		const struct common_firmware_header *hdr;
 
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		if (adev->vcn.harvest_config & (1 << inst))
+			return;
 
-			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
-			/* currently only support 2 FW instances */
-			if (i >= 2) {
-				dev_info(adev->dev, "More then 2 VCN FW instances!\n");
-				break;
-			}
-			idx = AMDGPU_UCODE_ID_VCN + i;
-			adev->firmware.ucode[idx].ucode_id = idx;
-			adev->firmware.ucode[idx].fw = adev->vcn.inst[i].fw;
-			adev->firmware.fw_size +=
-				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-
-			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
-			    IP_VERSION(4, 0, 3))
-				break;
+		hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
+		/* currently only support 2 FW instances */
+		if (inst >= 2) {
+			dev_info(adev->dev, "More then 2 VCN FW instances!\n");
+			return;
 		}
+		idx = AMDGPU_UCODE_ID_VCN + inst;
+		adev->firmware.ucode[idx].ucode_id = idx;
+		adev->firmware.ucode[idx].fw = adev->vcn.inst[inst].fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
+
+		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
+			IP_VERSION(4, 0, 3))
+			return;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 75cfdb770672..6cd094ee8218 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -505,7 +505,7 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
 enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring);
 
-void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int inst);
 
 void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn);
 void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 77f9f34eaca8..7638ddeccec7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -154,7 +154,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* Override the work func */
 	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 87293bb777d4..a327c3bf84f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -159,7 +159,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 62266db72531..0d84cb4279e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -189,7 +189,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index d29c49d061d7..03fc50b3aa05 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -172,7 +172,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 509dc6b5f43b..c52ed8166d9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -180,7 +180,7 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 070cf516f365..2468a5e409c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -137,7 +137,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ad9e67d9134d..f43604d7fb1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -142,7 +142,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 9999c8094920..d61428c75c88 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -126,7 +126,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
-- 
2.34.1

