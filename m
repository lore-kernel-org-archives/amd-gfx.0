Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC381D591C4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD0510E5C4;
	Tue, 19 Nov 2024 06:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mrnlp/5A";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E22D10E5C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxkwfKBdgi6Bz47G126pK+uNEU7IJ90tra5T23rlPolLyv6hqTQACpW1u07GhfEzs+Ik+TRVVtskKne6VKKK/wccfsd6+O9jsnKKvy41U9CsNeXZWAGH+/jsxjPaLXENQEparvgf5ApzbnhXUK95/r1T2sm3xW0WPCr94nJAsf2HOIIJcJ8YHwJ/PDPavJ81eDzDTiXulfHeIYe43dDuIJBqcRkXIBiia0QTaDTAfSuJvbdlFPJ+BCaNdUU1B7FhN3Xm6qL+Eek7U/VLfanWYyWrDQMSRMyaTYjA2WGtm9GkF4miegz0IAtatC/KJRZg4giIbc94vFeNZ77b9FVp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYcbjaanTtQsdRIYLu6wJSd9Fe8bkEVS8c08IRIvOmY=;
 b=L5dCS0Xw0b60hHprD8Xgb8EAU0ueUW/TMGKtXtMIa9UHVETJFgfP2VU/fcOXQ0y56aF8MLnDPxRc1xu9UdEYg2wLHeYBzgUIMNJqdyDs6sBaFaxKdziwuX6SlPpJpeBC+UxqPiX0q4/vI9t+qwmzDWxCLsQPPr+cC6xa06nBj0lw3sWy9Ns2dCWElViau0YePHL76M6lO4ijAIRLwTaMaNYXp2SHmZsjaI1KgEvLUMqDsgDuIBNH/67yxu6trpFpyLm/v35GncAWCCZ+EEvfoI+ch6CB1tYtHcNRgFylr0CYV+MfScmbox1rNjOFSvDMHmV3B8BsALyl8JhYVA+7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYcbjaanTtQsdRIYLu6wJSd9Fe8bkEVS8c08IRIvOmY=;
 b=Mrnlp/5Aibl3UvYNFZ63XCGdjyUf6AFeA+hziC+Y6/8upiMD+emhxYtmIYZ0kA1iH+XBz50JWyV+HjSvIbtelx114EA4zK6Ub/d7w8fc3I+ERUaXjCzzYzCsNWtKjlAQ4e+PJSfEya0VnDMHb64t4QQY7onqQAINQxsVJK8zH7k=
Received: from MW4PR04CA0083.namprd04.prod.outlook.com (2603:10b6:303:6b::28)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 06:36:26 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::b8) by MW4PR04CA0083.outlook.office365.com
 (2603:10b6:303:6b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:25 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:24 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 03/21] drm/amdgpu: store PA with column bits cleared for RAS
 bad page
Date: Tue, 19 Nov 2024 14:35:46 +0800
Message-ID: <20241119063604.81461-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: bb504a24-f820-4c96-458b-08dd08647e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eg/jmym8Mcz6X0AsuUZsfGexR9/XK4JbW968W9gxbpINkYs2inEGRa+zQkR3?=
 =?us-ascii?Q?iNJ/DU2B/v4MBlNsgq7KxCHbC3SLwY7mkXlIHPuNDITMqy2Kf0TROEHc2qCY?=
 =?us-ascii?Q?RxeKJqy35pbWZc/6BHx0dkjb1RKReFGQDT05O9yyHLKIwwcJd9Mj6LdM3ekL?=
 =?us-ascii?Q?zcN4EBnkORAByX9zq+aSEyF3IwuuvSKy8E+e2aduUwXutqj8oUkCtZRznD4K?=
 =?us-ascii?Q?vRALfVJkPUfFoJZXUp0fVecgAxrpy6m+2yJ4dAPhAFBWkPFd1p4FfisZEj1/?=
 =?us-ascii?Q?Q4AeJM+7VidmcWfVdCoXR0UA+3G3I7ktkhPvNn97GVzU7TVkZZRkQ/i6wNht?=
 =?us-ascii?Q?ubA4c/8wJ636Qw8ITdbhPEZhTGM7YBo1HksCiMGzj6eC5OihHKo5snSLGOVW?=
 =?us-ascii?Q?44PHKusmDJmtaGNEh9xCi8bEH/jUcS4K8IG4qAZkLftNh+AHY8REQzCYnCbs?=
 =?us-ascii?Q?UU7K/zmywznTxllzYYheL24m6Gez26NtTMx6aK9OnlEhbDgBCD0JYC0SGudt?=
 =?us-ascii?Q?xU22GUmca07WQhR1nLiGL1yUtkHrXF5pKaCz9dubTX6Eni6h0mnQl3MnrLH3?=
 =?us-ascii?Q?8Fk7qKQNaikQbSJ3fyqizVKwWq/6W6urR2TmbHepNN9DiGmSvCpPQ19hlNc3?=
 =?us-ascii?Q?8xUL83BH+B9+cM3EOuoWr/ILTR8PDRnvmIpMRuJheolrTzL84qKCfWEyHSVB?=
 =?us-ascii?Q?YGUFwMsjjiNwICBaI0l83nPk7B641KFlIoOhZws3bY4bhmkjqgDQHGZcIXLV?=
 =?us-ascii?Q?Xdt4yB5PdfaiFPAqxplay64qMroEti9iaMsyX2tnEuPfX+oIQnWQP+DsX4Ng?=
 =?us-ascii?Q?Af4knhS7AOm+HrqRNt5b5E2StASgtoRKdHPff7PZ831+AClz3GczTtECAdr7?=
 =?us-ascii?Q?pX5YhBD13deJ6Yqp9Ik6getIuOwsYbLeeaRB6m4VsZBhNp5+iUaW1mxKpLWt?=
 =?us-ascii?Q?f23cyG1PlR/7f9pKlIbqlsDtp4PYE47LVGUOuKyENsweTN5ijcad/riG6tpN?=
 =?us-ascii?Q?u0qcqGArbcXm3tZCTBHSzDOIISVFP61BZgXvQAGuHsB9xlbMEvwiXC0b1maL?=
 =?us-ascii?Q?XAHEiw2sOnRcxGWVLkSJ5w+Tza8VDR3F9XNWDX7K+XeWM02W3JAVzpPz7BXm?=
 =?us-ascii?Q?/HlRh3mjkWpSfkaqFK+djyQ3RN7F1qQ83SyL1ll59YMu9ah2VKjYntOmOwEB?=
 =?us-ascii?Q?08j0nEiZ9BTEaIIm/5lALseE1YbNXpsKQAikADXSmTWGCYnmNUYUVD3mJpcA?=
 =?us-ascii?Q?maYmmJ2C9RYhZczrTqJC+EyOdZ7xlXJdgl2rofasV3ef9Dypxxddo+mG3ntQ?=
 =?us-ascii?Q?ka7OEBXvXnkKS4xOFSQ41+thGgzkRRzUByuQB6Bo3/Qfj6IC8tgw9facew1A?=
 =?us-ascii?Q?45cfhqx8a9HUjirLhcl4FsSAbwhh8BN2Yp2h4J6p/rRglR+Xxg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:25.9008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb504a24-f820-4c96-458b-08dd08647e06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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

So the code can be simplified, and no need to expose the detail of PA
format outside address conversion.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h | 5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index a030fed16c5a..65336ae12585 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -219,6 +219,8 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	/* clear [R13] in soc physical address */
 	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_R13_BIT);
 
+	paddr_out->pa.pa = soc_pa;
+
 	/* loop for all possibilities of [R13 C4 C3 C2] */
 	for (column = 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; column++) {
 		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
@@ -537,7 +539,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	ecc_err->status = status;
 	ecc_err->ipid = ipid;
 	ecc_err->addr = addr;
-	ecc_err->pa_pfn = UMC_V12_ADDR_MASK_BAD_COLS(pa_addr) >> AMDGPU_GPU_PAGE_SHIFT;
+	ecc_err->pa_pfn = pa_addr >> AMDGPU_GPU_PAGE_SHIFT;
 
 	/* If converted pa_pfn is 0, use pa C4 pfn. */
 	if (!ecc_err->pa_pfn)
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index dea42810fc53..f0074abb5381 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -82,11 +82,6 @@
 	(((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
 	 (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
 
-#define UMC_V12_ADDR_MASK_BAD_COLS(addr) \
-	((addr) & ~((0x3ULL << UMC_V12_0_PA_C2_BIT) | \
-			(0x1ULL << UMC_V12_0_PA_C4_BIT) | \
-			(0x1ULL << UMC_V12_0_PA_R13_BIT)))
-
 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
-- 
2.34.1

