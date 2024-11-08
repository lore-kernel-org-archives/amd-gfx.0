Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B461D5E15F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FE710E96B;
	Fri,  8 Nov 2024 11:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DmwlanYq";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B6AF10E971
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PePQvFxzXHN6Tij50ww8t6pelgh89J8meoouYSsz/jq91zswhhEN5NxBPjpuDIbgMZtjgMtLeItd+4mIlM4Lv59kcu3yHSbYen2xMiIt8ypCf9BF49XSKeRqKeVtHJRqC7oE2dI45EdljUeVVjVG/iZUXkRkG2ggh8ML8KBe54ERtTjRX3Kbz/Hg1Nl9YUeNAB7glxO/VvC/1vv0mjsgKdTnjbRtH9dn1nw8fL0Gk877GtS5TvWecHTo5tW32CimVhOkm4vLH/uenCQQX3pbWpM1QF72ZCYmgnJMlBWT4WbErbeE58q7PZ+L9Yv4V/9VBX32l/SLu2SRQVYt5yD9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdq2C+hIpxNoaEIL+eSBG5XFvr23Zwy3diCX5AGLIvc=;
 b=prVjWkckV/IVcrIG3uwXVjjrnMzI1Z82a74ECqsmyJ7Ok9I/X/m8juO1ZKECbOD9xtVcqA5+3DNT6mKnimRhdgZAiW6G8y6EXuZkChVo2pM7ytDgqDlBka5bY+b4grCroilsMsbh+LRd3WNsxnOoj4xLoei/3sG/OkzqHB4gGE+WZLLHoGT+wmyo6xFAJdEZndMxc9bZY7JPeLAynI8abcwBJdZl4HR7yjbJbM6rQvsJZK9rSh6kffpi/XdPgCRTHjtZgarz1IqAxXih/I19LlGRXyzakfWgpqQmOEZlvgf+itkKASP427B7Dr1JTr4SffucrzoGiVZbw1qLIEt8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdq2C+hIpxNoaEIL+eSBG5XFvr23Zwy3diCX5AGLIvc=;
 b=DmwlanYqcGFn91irx8T4Gw0bDZ1hkU6RHrLneJnRoCRVLWS3ypyn72YkplZjK5C+24ftSvp36LAdqYFt54p0gmMxAP6PYH39H0ENo+aS3uKEnSHESYkbZEeMeyFrREcgkijKDn0XvZW0FLH0Ur94hAWewYduY7SJxLDeqvvwrdY=
Received: from BN9PR03CA0261.namprd03.prod.outlook.com (2603:10b6:408:ff::26)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 11:14:59 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::6f) by BN9PR03CA0261.outlook.office365.com
 (2603:10b6:408:ff::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:59 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:58 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 23/23] drm/amdgpu: set UMC PA per NPS mode when PA is 0
Date: Fri, 8 Nov 2024 19:14:23 +0800
Message-ID: <20241108111423.60169-23-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c66f17-7bcd-4575-bec5-08dcffe69593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/pSpdR1Of3PWI87q/LR7r0DtxMWJ09yj6KDirJ7ktiL46A5byDBn0RV1epDR?=
 =?us-ascii?Q?mOxED62N+ZrD4K7p6qALLOlNMJBIytQ43mMea0cTrDS/i7Xl27rzvH1XXGV9?=
 =?us-ascii?Q?ZZ4cNABPQYsU2qr13X4Ril2Vk8wcoPZBQdt2hmz0q58McYvlsnA9WB1iyH3T?=
 =?us-ascii?Q?iEWfZOOTKnCJ+2MvtSKNiPWbefm5s192MnOpFf3ixVDzE/oTDR+zcSC+17Df?=
 =?us-ascii?Q?mKC7fNf1mKcRkAp6g8wFmou0zuhFoujpMZefLutP+NBNoGGm1v6f/v4LCROe?=
 =?us-ascii?Q?UmPYClBk+zeokTNB06/prGaUoOKs/nbPOxy1st8vj9pGGhszRW1dAZz2/ccz?=
 =?us-ascii?Q?HculPx8rLhEvSVTizRJux4+Sb2QiL+1kcKOcnKNozLQ0s4uCR30FGJvvou5R?=
 =?us-ascii?Q?nxCCnT97YGHKcuV6qjClrR7GmG7bX1U47hT7y+qPg5x5aTPl0v8NCdhvkVMC?=
 =?us-ascii?Q?H04PdoA6wZeAZTHv9rUeZvHN0AC5nMN2guKrwUsLr+/WpAAgvJKItZBUerax?=
 =?us-ascii?Q?KB34RPaPZc0eNuey9RJPwSaJ89+sP3BtCJK9fiopzGtd9KOol1tXx30/TTqu?=
 =?us-ascii?Q?ANdeaTzy1pe+1X+IRGu7fqkwmoYrjCyUB3Ppzzb0bLUYTby8dQLmf/cVaCcJ?=
 =?us-ascii?Q?BjNMuhqwTEcTa1fMm+giILJhaAeYzw7qVxAAHu5B1L+ckp+0rfJGdFT/p90w?=
 =?us-ascii?Q?l8fs4SGxUW+rgJtAOXF5vU0HiDigUAnJjjIOtFHnzV4jC7IVJyhW/3f42cZn?=
 =?us-ascii?Q?gZFzWFhQhRAD0tO6NP9zOuo92GpFjdCeKGacEE0iWLR5/5rC4/tepxHIIvwU?=
 =?us-ascii?Q?G/5Ef3VlZEHckkA1tpkkNEVeC3kGVctZS5SErRNW7FNE5iS4A+NwfahWTr7J?=
 =?us-ascii?Q?v5Qj4W6mOaqMsptnG7Bf7iPDIXLoGVMl+BZ/jJAOG9w6PbSHR+YU2d47eQMZ?=
 =?us-ascii?Q?dKKgWRGPkUW7ywtAG2OEZ7UEbVEzFit6z1yOY/Il7gpJptPmfSfff0pf+4rr?=
 =?us-ascii?Q?F9y9o0QYTvVZTEDaj2Yr9UDFEhbci88zuw6A0yY75b+uXtUmiEZi7glxsEpf?=
 =?us-ascii?Q?2fikV/LYNvkQHHYvVgNNy7afmUoxbA3orHsgSQg/+0bON2xa/CTl4bx78SRy?=
 =?us-ascii?Q?j3s1wOr1JzQNSofVCLCieyPibZzh+PaxXczQR39Bod+vxAqGNKODNVz63hd4?=
 =?us-ascii?Q?5r2H0qkD4RUdA+yaMyeO25sW8cSm8xHgx61z/E4W7AFwEZcweBYh+nubctk9?=
 =?us-ascii?Q?lphj3u13sKcLOKMPpO16XLiX+TLDvRScJHyudHgKLGUK03fLxavQJTpkFh0T?=
 =?us-ascii?Q?Lqeksna5fJH0U93UudGVpxihNdgDEAB+LirmUJnlsOpmPCXKsrGKbZ5pWIbN?=
 =?us-ascii?Q?KcqKIynXM39TccI+0aDdfEkUg7Ei0lv7eCONiC6nC3jfTMc8dg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:59.6191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c66f17-7bcd-4575-bec5-08dcffe69593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877
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

The shift bit of PA varys according to NPS mode due to
different address format.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index bcce7a304d6d..8ce81fc1fb1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -467,6 +467,8 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	uint64_t err_addr, pa_addr = 0;
 	struct ras_ecc_err *ecc_err;
 	struct ta_ras_query_address_output addr_out;
+	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
+	uint32_t shift_bit = UMC_V12_0_PA_C4_BIT;
 	int count, ret, i;
 
 	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
@@ -511,9 +513,14 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	ecc_err->pa_pfn = pa_addr >> AMDGPU_GPU_PAGE_SHIFT;
 	ecc_err->channel_idx = addr_out.pa.channel_idx;
 
+	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
+		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+	if (nps == AMDGPU_NPS4_PARTITION_MODE)
+		shift_bit = UMC_V12_0_PA_B0_BIT;
+
 	/* If converted pa_pfn is 0, use pa C4 pfn. */
 	if (!ecc_err->pa_pfn)
-		ecc_err->pa_pfn = BIT_ULL(UMC_V12_0_PA_C4_BIT) >> AMDGPU_GPU_PAGE_SHIFT;
+		ecc_err->pa_pfn = BIT_ULL(shift_bit) >> AMDGPU_GPU_PAGE_SHIFT;
 
 	ret = amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tree, ecc_err);
 	if (ret) {
-- 
2.34.1

