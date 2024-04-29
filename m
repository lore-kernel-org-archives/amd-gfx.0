Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B7AC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F146E112CB4;
	Mon, 29 Apr 2024 14:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1D+OlJ0j";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD43C112C9E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyJTC54bjj7zZgLzyJfrVwUCrUiV5NeZayjW7uiT48rn41EiC8+3gPc8yjQEC7LdHLls16DlSLw3l1uqGYEpnivJ/ZmY+eC9vuZ9Y/BbGYQwnT33OvfG6cPV137kZkyKKGgL+sNLEX3KV1voqzSF7ePJor0GOItpZnwjLzt5nxJgOGOw2GybDkQm2drkoy+UHkohSa0QEmEdAGU1HxNBYIcI/xPJmHSy6SUjcMpfjDJfabHqIC1z3T3HLjLk1WXXbVgg6/YHr0MyIkvjswoZqWsk9hh36OaxbnjBLWK3wdxtp5yuRTXF1aG9cJf9vceSIwNKsbv/f616ysKegXEWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyp6+E6M2ohokcVe4btEMXz46EeGqW+I5tZ2esA9vuA=;
 b=Uf6PA4InK5jD6PXbY97UtgSm1cvRqLSd/P1MN5bgKtRqoG0ct/rw45sINLDkP5X6aLetHhqDY/o7JaSTSS5fVsANbySZ/ynWr5waa0NcnRy6+HxOui8Y7GUDOofUdXjoyVmAa0CnURo2CzjnI9+rDs3RwsfBpDeMyGksRqKCu2uywMB9ogl+vPCrnC65YnmP4jykyIbmAA8kwlSROupk20g6jYZ0hmYukRa6B6sr2i2Iy35pP0wLLEhZtNedMbBFEjuQ/8SPz28RQs/ZLy1Sa/+drDU+8DTZElIKngMsp0uXqhHTiDxuEh/CEYCzIhkWskxtHYw3MyytBYA/YvztAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyp6+E6M2ohokcVe4btEMXz46EeGqW+I5tZ2esA9vuA=;
 b=1D+OlJ0jRCeryuFm6ZE0NSoqaEyFFb/6TEB6abx1vXQCTDoub39XLF46s4vU3OFJ5b3Xh+b4bAQAhM61MWrX9qH9tadvPbRa6jEHVl++U25EyQ6NMscDdeKIJBgPTcwal8ydCZQLd+CtmkYRa4ZIk8Ll+Xl5p4rWiCj4gSoQjFY=
Received: from SJ0PR03CA0340.namprd03.prod.outlook.com (2603:10b6:a03:39c::15)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:34:22 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::97) by SJ0PR03CA0340.outlook.office365.com
 (2603:10b6:a03:39c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 22/31] drm/amdgpu: set different fw data addr for mec pipe
Date: Mon, 29 Apr 2024 10:33:30 -0400
Message-ID: <20240429143339.3450256-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 622e8e0b-35fa-46d9-eee7-08dc685975bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xZnUNUjM1JZcw4Vgdm3IEqwidZoYEs0+Y127khFMEeVms9njNu4tTs5cvdnn?=
 =?us-ascii?Q?EtnSDp8hgX2IWNN5AIXaXhPgGVway0w8BZFijuhd6yU1iZ+EYXiHQPCufaFw?=
 =?us-ascii?Q?CK3p96O8l92MhQ7zLJmPlta1psIem9SXMv0O+F0mbsuvtTQNcfkx/0rMcuxR?=
 =?us-ascii?Q?eb7BWDav+dGh8gWH1IRp0RFdzuSw5v0jb/6cLh429rvaL4kFKFjCsltm+3Bq?=
 =?us-ascii?Q?yXhIJAsUqGy2U7RI8VwjZfNgGd1l3RlwreyTYhhG382InsPIndTdyDQK4p8V?=
 =?us-ascii?Q?wXiCa+4IS5pwDkIi6QdS8q2QrR4vcUCUIXfqwFlfrwsdlXxJSTwt/io3Ihzz?=
 =?us-ascii?Q?UUcUaFO9qAXLNIE1GbNcXrk4XBE2x2EEwoPBRn9qylXbhKCRj3V2ESw2YB1s?=
 =?us-ascii?Q?/Z07imVH9q0YIzpL0sWY3P95rwDbD6c35UmZxaQIMa0Y9aj3plB6c0d9oddN?=
 =?us-ascii?Q?A5CZNg1CfmpC2V+4xS7Bw8HnLhM3P2vROK4/cs/YsySfs5kzhIY3QpDdzRlE?=
 =?us-ascii?Q?z6jKE3dqOGmvc9q9Z5o0wZ5V4tfslAuCf11H/sdkRIIQN111A5IKobj7n9sm?=
 =?us-ascii?Q?Lx0C/LkUnvlxTywkMdWjxfKwlSizlNAHPG+pM3J85S8ecIKRpbZOXEWCLhZ/?=
 =?us-ascii?Q?FJ1gPfi/Cop1q4dtXsxQdPlEuZt4+g/X0ZunSUL8iiVJnfk7k9BiWEPBChkr?=
 =?us-ascii?Q?+4nThMPy2izj60W63OWW7RNQO5sgOnT60Unk/I0YO37CSZR4oA//trLXGpFf?=
 =?us-ascii?Q?0v6g6Ad00hlafEupnd0nKWDsGS3/6hMUOdpXZY1trhffuKe3aOteW0sdBv3B?=
 =?us-ascii?Q?ufAgZAi5iR7sp8skFG1lNQwnVAswR0rYBLlSpH6KLGMJCgPS9SOzYP5ltECm?=
 =?us-ascii?Q?f0+aLf91csAvM9HLkyTwhDPTbVE5nxAVHEHREP3pLRmEJqo5k9R3ECeXNCNM?=
 =?us-ascii?Q?3340KDbMos5YxLKrGi3THK1WDaxGWMgsAPK8fNdouO7mkAvVJH+oMxmZLitJ?=
 =?us-ascii?Q?sR/6B8eN4F9nKrnU4aFl6x+wNgT0zDaZPWZ2CgXjiSSimlzOvGUaM7XNByPY?=
 =?us-ascii?Q?kSmF0Jaz2vKx+Qmgsh/3BEmAjZmxNpiAvpGOlGzvdJHZPPGSDD+YtvB2SvFS?=
 =?us-ascii?Q?r7TgDq8qIDsR2BG6ZJa8w662bay5abdoltcAbFn1kYwhhj94i9t8NePkv3z1?=
 =?us-ascii?Q?e8/tM7DSjVi8o9tXlwn0lA3LRsaR5eyrqqjkfGt/BCkNjketiXrzbo3l9i5I?=
 =?us-ascii?Q?u6N58XgydRlyKI4rp5cIBlzyXiR7w7/919ttGmE0R2kGmtNkyY+f2uDXJTyL?=
 =?us-ascii?Q?Fe40eIw45CC0w8/2wOOv+Dpfj/0HjQEv49dnFMHPjALzn5J3f+OAjMOjwl3E?=
 =?us-ascii?Q?Cb2KV4k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:21.5277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 622e8e0b-35fa-46d9-eee7-08dc685975bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
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

For MEC fw data, different pipe should programed into
different address.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index e8505c77e12e8..68a66ccb0100d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2432,7 +2432,9 @@ static int gfx_v12_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 		return r;
 	}
 
-	r = amdgpu_bo_create_reserved(adev, fw_data_size,
+	r = amdgpu_bo_create_reserved(adev,
+				      ALIGN(fw_data_size, 64 * 1024) *
+				      adev->gfx.mec.num_pipe_per_mec,
 				      64 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
 				      &adev->gfx.mec.mec_fw_data_obj,
 				      &adev->gfx.mec.mec_fw_data_gpu_addr,
@@ -2444,7 +2446,9 @@ static int gfx_v12_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	memcpy(fw_ucode_ptr, fw_ucode, fw_ucode_size);
-	memcpy(fw_data_ptr, fw_data, fw_data_size);
+	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
+		memcpy(fw_data_ptr + i * ALIGN(fw_data_size, 64 * 1024) / 4, fw_data, fw_data_size);
+	}
 
 	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
 	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_data_obj);
@@ -2467,9 +2471,11 @@ static int gfx_v12_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 		soc24_grbm_select(adev, 1, i, 0, 0);
 
 		WREG32_SOC15(GC, 0, regCP_MEC_MDBASE_LO,
-			     lower_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr));
+			     lower_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr +
+					   i * ALIGN(fw_data_size, 64 * 1024)));
 		WREG32_SOC15(GC, 0, regCP_MEC_MDBASE_HI,
-			     upper_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr));
+			     upper_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr +
+					   i * ALIGN(fw_data_size, 64 * 1024)));
 
 		WREG32_SOC15(GC, 0, regCP_CPC_IC_BASE_LO,
 			     lower_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
-- 
2.44.0

