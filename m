Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B43C36010
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 11:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D4BE10E2DF;
	Tue,  1 Apr 2025 11:25:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Q2dd1WV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D6F310E560
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 11:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaQDhrAZ0dAeChdaHXAfoPpvLibcAYZcCTqf4XIj2nFIl9mCEQ2XLv6qvvGrzJ3heFQOo+0FO3FbXvY24Cg2PZ6mRiahDtzMx5yuvL9nwsijEBGzxIpUgejH7sQDhsWFnJviBr0zjxnns/I98K+JXFDomx+G43V7baLq0nAPYQNISJtosgioVLZuSrJRGG+F0WCw0m7mYAHiuXEvmmqCbAaFaxhADEZzRPx14pHoIbe0OLJ+Cwa+qS3ctWvwkOBVHHXjmleXChVDX3V9Z4htnxsWNlnZdREk4pqP9d8u9Tny3BccvJC1RLrGpK/XH6PqrggIi0uEGBG0hN1cT9Rfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c1O0wwfowOCq+IjguHL2dj29ARtrxHT3v2KEb6RxEE=;
 b=kyLMnHdvT71QggOEGw7HYoi0OpXcUHlBkPUn75pmYmpszPu0iqtrz15keOJ0bKlmaDkwoMLSLRWWiELQ6GrV3U9bI/K0+C0Sf+CnmikZpXjxW8avaXXfV4UkVe5lqcrGWceMtBMd5oUmaWNMgthjrNNizQRPWPbULy9OlNeMNkDtCRiSF4tXafd8Y0iCWfR/MAYo/l+W08TIItFRhs2zymcIKlxfz29+eqxbY9AS+TDXO1aVhs3SrPtgrzNOxv3msLFWj5V6AoPmvqyxDOw3vLrgebicXyyFJjRCLyDQn9ptgHAj8Sh/nZ05sgvaKHIYu8nDHEO0ToM2PH/DLsbB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c1O0wwfowOCq+IjguHL2dj29ARtrxHT3v2KEb6RxEE=;
 b=1Q2dd1WVl4jTr4H1f3gzZRuhhmdWXWOaCQAoZn0UXEKX/vkz+BO9rf8zOzmZJEwaC0g7ZlgVR9cnwxauBGMePWs8l+y0SziLppvbKsLilytipPgnrz4EcVgdfJnPzs7EEZDE2ev39j3Z5lYR2Xy4Us9PFbPOiHGaaMYuP9m4hWk=
Received: from PH0PR07CA0104.namprd07.prod.outlook.com (2603:10b6:510:4::19)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 11:24:55 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::34) by PH0PR07CA0104.outlook.office365.com
 (2603:10b6:510:4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Tue,
 1 Apr 2025 11:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 11:24:54 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 06:24:52 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Fix xgmi v6.4.1 link status reporting
Date: Tue, 1 Apr 2025 16:54:35 +0530
Message-ID: <20250401112435.461473-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: b02ef708-73ef-4151-4fc0-08dd710fd38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UtXD0Kwulj5jvLfqZTW64x4r47tnVmHp+Ao7PJoKo+5Vpr3hzLvYfbSakN9s?=
 =?us-ascii?Q?wIWSVEHdwfKUEGMdppsyn/1Z2N5Xt1BQE8odJmOEu/1jew3ty3R3+1+t2hOb?=
 =?us-ascii?Q?ebAJ/f7Syp8g0YkF0FxU3zQstKIZBhXaQixvAGUlGva5ulJaHQzsol3MGcF8?=
 =?us-ascii?Q?GL0ZxOVGlkw4I0rWKt1w4hVrHUpO239cy3+svES9f4GaiyjfY6sV8tdJAq81?=
 =?us-ascii?Q?OhGLHmH4BVMkrh+Kb+N+VletMdg8KEmAPT4VGZpxiYmXsolUf+q0uvyNja2a?=
 =?us-ascii?Q?CmGGel8PJVky9hNnRpguv9xGot1ZXkmwJR2kI6HxiZOFBeiX9fTe9ler89v3?=
 =?us-ascii?Q?65SGAW09ZsePc0m2n7YyoVtbjHWbrYPmhqNpBiWTs+OBUD0Js2DviJNrGLNi?=
 =?us-ascii?Q?uyKbc7LZMsnKFObwhc86PinAgswz5Wq/Y+FCUVzfv249sWsbJKu2y8uikmez?=
 =?us-ascii?Q?0F/unMTJqA+0RcXl8Wodl3R9XrD1oxFTyX/ZPloG85wtYZEm+SvNbs8Y47jd?=
 =?us-ascii?Q?1a3nq3pc1+ebgpi/1O9CNRtMyO/aH72/oJP+923sj+/ErLxguXwa2uYPxMHu?=
 =?us-ascii?Q?9O8VE7oBwRapQwX4xIOrTmuOhddeyr7mAz0jQqSnKuGKCy2qlRlRiJSkySeb?=
 =?us-ascii?Q?plmAvqALl9MA+qNRkRXDc4JQJKqCWaMv5rWkCHU26u08kwVsLy15bSiF2yM/?=
 =?us-ascii?Q?bP+QlfpG5018PyF+OMDkX4T3JTJVZdq+CPPXQ35owEE8CeW4/5irz1X9DQ9E?=
 =?us-ascii?Q?SlVXVzSqu0M8SXJI2ybgH/hEHh17CUMXfy+lUCDc5BmUGrjQG0M7n1L+XzAa?=
 =?us-ascii?Q?3KfSIXSxmPFCB1pMWLSyCNI7p2paSGLPF0MFMXk1Ff6PZfRwsyyU58+lzXkl?=
 =?us-ascii?Q?mAINwTaLXjg7IQNmFONMT/FJ4LL0Y0niipJw8xe14ph4PWVxYhoNeRGGXWNF?=
 =?us-ascii?Q?pxj3bLH/PtJIXZe35vUQWV26fGHwQfWpKuEC+3fRY04QCajsX4wp414IhGXB?=
 =?us-ascii?Q?uhywM9ZgiIiTqsrDEdIwATp5Bw4fCM6ddbVyzDOl/3TZtwx9uZ20tY3sMBH1?=
 =?us-ascii?Q?FHukir2CrtECcCYSRV4wsrLuV9is5Z6oxORW370SOj5390xdh1VY+xxBJQpi?=
 =?us-ascii?Q?rs+1qWGlODym27fhvHxGlX8gpXQa/92v05stsGgKrTo+ydFbFJAd+w+RyIH7?=
 =?us-ascii?Q?6zoav6pc9J/sQS6A55dviXPYhjcvJwzMnAnucIlpJJFIFwJemLaa3YNt6OXT?=
 =?us-ascii?Q?ardqFd1xsEDh+Qgk0C3FD1ReWk6qiH2EjeMiSg5jHJEf3LvUO1esI0zX8w3l?=
 =?us-ascii?Q?jyzNAMr5lsBbXWsEMNdtkGenwnhaBS3+Rn9FTD10HQfd/Y4klHaXpnqFvxQj?=
 =?us-ascii?Q?Nd0UlTNUTzXUFoQOf57G9j0SUkmOwS97gM9CgWIaWyhDxxDqrbYRVzlG3S/e?=
 =?us-ascii?Q?LZkIuq9vb6g0Z9cTeVehBfqk9jhWiZSUs7O6EremDpQkjYlZMhyJAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 11:24:54.3620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b02ef708-73ef-4151-4fc0-08dd710fd38e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
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

Use the right register offsets for getting link status.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 477424472bbe..95231de26cb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -296,15 +296,27 @@ static const struct amdgpu_pcs_ras_field xgmi3x16_pcs_ras_fields[] = {
 
 static u32 xgmi_v6_4_get_link_status(struct amdgpu_device *adev, int global_link_num)
 {
-	const u32 smnpcs_xgmi3x16_pcs_state_hist1 = 0x11a00070;
-	const int xgmi_inst = 2;
-	u32 link_inst;
+	const u32 smn_xgmi_6_4_pcs_state_hist1[2] = { 0x11a00070, 0x11b00070 };
+	const u32 smn_xgmi_6_4_1_pcs_state_hist1[2] = { 0x11b00070,
+							0x12100070 };
+	u32 i, n;
 	u64 addr;
 
-	link_inst = global_link_num % xgmi_inst;
+	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
+	case IP_VERSION(6, 4, 0):
+		n = ARRAY_SIZE(smn_xgmi_6_4_pcs_state_hist1);
+		addr = smn_xgmi_6_4_pcs_state_hist1[global_link_num % n];
+		break;
+	case IP_VERSION(6, 4, 1):
+		n = ARRAY_SIZE(smn_xgmi_6_4_1_pcs_state_hist1);
+		addr = smn_xgmi_6_4_1_pcs_state_hist1[global_link_num % n];
+		break;
+	default:
+		return U32_MAX;
+	}
 
-	addr = (smnpcs_xgmi3x16_pcs_state_hist1 | (link_inst << 20)) +
-		adev->asic_funcs->encode_ext_smn_addressing(global_link_num / xgmi_inst);
+	i = global_link_num / n;
+	addr += adev->asic_funcs->encode_ext_smn_addressing(i);
 
 	return RREG32_PCIE_EXT(addr);
 }
-- 
2.25.1

