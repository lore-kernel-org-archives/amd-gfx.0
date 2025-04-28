Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B49C36005
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 10:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AC810E1A4;
	Mon, 28 Apr 2025 10:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JRlJjt6L";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 354CF10E1A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 10:10:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFvgeb5M5UM6pvRT2Aj5Rm9qQwvLZfYYy2oC9hYriKbMildNnl59+Le+kDVqf45sk1oyj9OGg4AYQxRT4Nan2oDmKr17K3RnWB00dLSiqTKLMhus0m86xxhE1kEFpt529ARHz+ZERwQdq/eWdODz+Y2sNG2A8cyYBG2WMUDNE355tHSbb7QhG1RdKOnzsG7JzAP0SG1J3JLipTd1kja0jOOp/ell5QKGlTlmEL9wsSJZwMj2v++9FbYp2RAs8fbOaqGju1RU3xO/iZvxAY7XhqVi7Q8EnvrFDCGPNam9M35KeejzgzeIfkWubOSlC18ndGzMVZvqvzgoV0bRdgb80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sFFXRZxo1Ct3zZFLTEuNFSm0exr5e225gqDfKo69mI=;
 b=aaY0y0iitNHp8E2Bzjm6SIw6whB+KZKrj87vqqLVLjeqZy+CWa0kvoh0oZ/SuKw5P84aeiEmj5gK/bM+ePk8M+AVOI/4GJqAAfonuHC9WHQAUgKs0zUaTX/j8keAGyrhC4ksWgzKtuJgZFex366W/UzRjyDwJrXmwlEENZpPzTFL7E2S7XtOXowVH1xRjwVlMnTfhun6RIkY/Wcpy/KSf9jgZvsJUwHnTiDQxJbnaDEAGfZ/AGIGsFoLdaFRabrTE47xghLg+jkueGyOWLK8raJkScXMRlcrzesr9ZZCPgpSWig1ttCOuUjO6/GKjh7S/MQ6UZGv56/ioxcDjqXroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sFFXRZxo1Ct3zZFLTEuNFSm0exr5e225gqDfKo69mI=;
 b=JRlJjt6Lbz+UJO5/NP8sHD2KGapudGEBuYj2Rxe/KTn+equ3MQOPgeJmEWoo3Z2O3jxtdUJzeFm/atzlaXDaigfQB1GWlNEgEIZIK6Qpd/DFPJYpT6dIZ+8SMSOFPOZ6Hj4Vt2sBlqfu0vcALlPa+cXP6NMDDQmliUHDNFLfHSY=
Received: from BL1PR13CA0349.namprd13.prod.outlook.com (2603:10b6:208:2c6::24)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:10:04 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::46) by BL1PR13CA0349.outlook.office365.com
 (2603:10b6:208:2c6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.23 via Frontend Transport; Mon,
 28 Apr 2025 10:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 10:10:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 05:09:58 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: Print bootloader status for long waits
Date: Mon, 28 Apr 2025 15:39:43 +0530
Message-ID: <20250428100943.959357-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|CY3PR12MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 540596e2-f0ae-42ca-1a02-08dd863cd862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5pvA06U3BpZg/ApW4sk/o09XmnCgNAPeezdj5QfCsSYDV3cUlC82miPO/uPF?=
 =?us-ascii?Q?9ChJmgsSkj+4X+tFLqhPet7JA8buFYX5P/FJDdv1cpLQjdsE1DemJafHmV8D?=
 =?us-ascii?Q?K66F0fOCPwbIjz5TwlzLwJcg2pby3PIcftRxaoHG6MU3YbY8hosoIscRHLDC?=
 =?us-ascii?Q?0ts3HAyDBYpPjeu3ITlMIH6AEbGuDeygl++RwM8ZXmVObA96JVxhPiO+PCXk?=
 =?us-ascii?Q?/YTzfMaMADCBTsV0CkKZ5TshBHXFhAel6Z7bvAedclNoRD7WBjVYa9g5S/nN?=
 =?us-ascii?Q?voSQ50UU1pmPn18FBGnguMjrW6cfNO+EdW9fuGswv0dBLH+xfCjAe5S4XWmy?=
 =?us-ascii?Q?NCJ7Yao6jq0CsX7oOenvU1E7Bj7JwxIZYrA6vKs+JVk6iU5HICPs8GM/HskZ?=
 =?us-ascii?Q?0weDND439EcTTDJ+U6uFD2b93lVnpUPxI63vY43f+D7FC780GQJXE7y/YdiW?=
 =?us-ascii?Q?Vq2Io0E1H+bTZ46DJow+nTyOyPA48Vk7cvTIeDprPf5SiEADuLYhaJPavvae?=
 =?us-ascii?Q?YD8QzTWx+FuzwXYx/9xqtX/IfM9bVL0Em6nFOJUjKzLXxfRgj/w4hG0qFbYM?=
 =?us-ascii?Q?nwSefhK+4c3iG5rX2dUML5EZgDsT4F9v0io38uI6jbKsbeGmfuN+L0H+tWin?=
 =?us-ascii?Q?QpbO+z1yG8pQkejbM7hq8FTE36qObuItSC2+gLnixMFRT8SgkG7jpxtf2lLi?=
 =?us-ascii?Q?og4NrwiJgEJ9Hu3yHoz8igm/A04998Y0Vp45rN4JWVBKQvLga5bRsgoPl1j+?=
 =?us-ascii?Q?rbrCWnCxsfRAbaGAr9cLK/9gu8+F7qFRSI1XI7hMUT/yM7fLBPNRVa5Bs6xq?=
 =?us-ascii?Q?uhMonjlcPlpkRGiN1Rk3lohPmGlSyGLXRa8R+ue+wjUSRsnorMKOAYxRX2oy?=
 =?us-ascii?Q?ECIQ1eebnvmACWRXLQl758RIATND4AUBGdAgGwj8SII3oMybSV9k4ULvkwEe?=
 =?us-ascii?Q?yI40bz89qPWHJnD5Lo+Fw5AORW/1jGWe11rgs62KaZYG9WArdRP2YWdaucgE?=
 =?us-ascii?Q?0aApZ+eVN6EVIDdq63tXXKv8lSd26F/pObUP7cvW8Jre92p/YL4NssYs3tJF?=
 =?us-ascii?Q?ltOzWtRhq/2NdrZ6hXPwVHo6i3Bs/Kd/o+868oPUys43FNFZPnsOtrxWuonR?=
 =?us-ascii?Q?T2AhP6Pt9Ahdm3YPkGHqRNG48I0G5CsBlQJOhtGZfc7EtIgK9H4cvgFKJXRb?=
 =?us-ascii?Q?a/qdi4G+7nardbMEhG9kkAcy4YJBMJueg6ZCaz6A6LTUXmiW1x7aCrNKCq9z?=
 =?us-ascii?Q?RzlFQg+bXY/8nP6FxsVNpTnSEOyzxw+dlmKWadLrymJ8Gmf/vqwUiz4ldpGm?=
 =?us-ascii?Q?9zu+EcFUKQEB+bC7zWQfxHAtDEapcAodIgL7yX/aEsr/50jqTiUTPlxvJHlN?=
 =?us-ascii?Q?hNkte6uuTrzxPlj2C+TTwzNBAQSrOxuzUS+ry6rTcq1Ua6oo59gUzfKZEo8E?=
 =?us-ascii?Q?rHn86awgFlkV5pz9Ku7pKUd9oJs3Gm6xskAXIgYTR5l0nrE2LIkV9s/zaJTl?=
 =?us-ascii?Q?OaY1Vlm/Yyx/22lyf4yRnX+oFDk6VCMDkVOf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:10:04.2525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 540596e2-f0ae-42ca-1a02-08dd863cd862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578
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

If it needs a long wait for completion of bootloader execution, report
the status in between. That helps to know if there is some issue during
bootloader execution.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index f5f616ab20e7..f8af2cc63446 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -85,6 +85,8 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
 
 #define regMP1_PUB_SCRATCH0	0x3b10090
 
+#define PSP13_BL_STATUS_SIZE 100
+
 static int psp_v13_0_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -151,6 +153,32 @@ static bool psp_v13_0_is_sos_alive(struct psp_context *psp)
 	return sol_reg != 0x0;
 }
 
+static void psp_v13_0_bootloader_print_status(struct psp_context *psp,
+					      const char *msg)
+{
+	struct amdgpu_device *adev = psp->adev;
+	u32 bl_status_reg;
+	char bl_status_msg[PSP13_BL_STATUS_SIZE];
+	int i, at;
+
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14)) {
+		at = 0;
+		for_each_inst(i, adev->aid_mask) {
+			bl_status_reg =
+				(SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_92)
+				 << 2) +
+				adev->asic_funcs->encode_ext_smn_addressing(i);
+			at += snprintf(bl_status_msg + at,
+				       PSP13_BL_STATUS_SIZE - at,
+				       " status(%02i): 0x%08x", i,
+				       RREG32_PCIE_EXT(bl_status_reg));
+		}
+		dev_info(adev->dev, "%s - %s", msg, bl_status_msg);
+	}
+}
+
 static int psp_v13_0_wait_for_vmbx_ready(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -196,6 +224,9 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 
 		if (ret == 0)
 			return 0;
+		if (retry_loop && !(retry_loop % 10))
+			psp_v13_0_bootloader_print_status(
+				psp, "Waiting for bootloader completion");
 	}
 
 	return ret;
-- 
2.25.1

