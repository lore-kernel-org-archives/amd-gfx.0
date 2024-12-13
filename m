Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7430E7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 20:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D69F10E1C1;
	Fri, 13 Dec 2024 20:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dLHrVypf";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B792010E1C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 20:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY8nK8omHYtUp23wgvfBWsYUdycua60KGMX9WHoV4gATCyQkiRurwRXMed+938RbbvD1JQ+9aAYUh8MSJdRF0IBEmfRc3G+O/H9YI7GAwy4OXTYLLhC4X+ZZKsIlz9Z7uXg2IbmuOu3dRNWfG+vjFiPKm2TsamkKJpIOvQX28qefumevXSXP7jAyP0WoNsvOCeIgovzLUKVJHi5GHQkbxs/hnpfcsg0tP0CyIsKF/LETZ8xQJLM/K7sWkJw81ExRDaCxNbzWLVB19XcoamqlWtK/w+wa6GuSlLOui2q3LCYrbh42uG1hninrNfCkrUd2b6VyytfowfwlyMlbsofCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxbcjiMhzzJAooqRcLvMW5Cf5hQNp78s+hmejGZ1SSY=;
 b=W94MUOOuxe+4LD4U2oyyqpzvMD7B8X8MNm0xEMUPpgEcduZHFdu6SOESf1USN68c4FoqYZIJzMgegsgtJYvp+TPpYQzylUzg32z6L1jTKDgPVZjtprxJMUesr1dqHDg2oqdNifo9ZXuD2POhVpfJppadFYI0Z4V95ziWuXhgnUvNDgSwMi0q2S8uyREsaPwjkIZ8b2Y2uoLtXKCHmCuwauSEbGdV6AGvNqANVmpmVy2Q5cH51iSQokYVtDjopzqAn7q1kezwX8NUMxmGXrDrFe/JG+1yPZxg4tl1g5NHf7qUbsm62tfYlEBy9jipvqBLSuNIybU/yTTaKqPOkN/lug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxbcjiMhzzJAooqRcLvMW5Cf5hQNp78s+hmejGZ1SSY=;
 b=dLHrVypfhxV4dELUE24ZtikRP7E19K4A8PJH7HLEIsa4E9QAM8l2LDllcDCaEl9rXogcejJwMjm1VT64gOLHEIrLteEhg1hkJ+DS6dpeeWgDIgw/afZWUSPPU9W36nm93dbVj5KxDC5C0O7Eo0RyDlJwDwkVubIStGKJcTxZWjs=
Received: from BN0PR04CA0202.namprd04.prod.outlook.com (2603:10b6:408:e9::27)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 20:34:05 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::76) by BN0PR04CA0202.outlook.office365.com
 (2603:10b6:408:e9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Fri,
 13 Dec 2024 20:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Fri, 13 Dec 2024 20:34:05 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 14:34:04 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <jay.cornwall@amd.com>, <Hawking.Zhang@amd.com>, <flora.cui@amd.com>, "Philip
 Yang" <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: Don't enable sdma 4.4.5 CTXEMPTY interrupt
Date: Fri, 13 Dec 2024 15:33:26 -0500
Message-ID: <20241213203332.18165-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 75105e8f-ad19-4d1f-d85d-08dd1bb57cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Vh4HPXayG/Jl1wcfoKsRJJhLRUKaN3lsbNEN+vMB6WAUxdgG3kNn1fVSJbW?=
 =?us-ascii?Q?PKjS/liOgredVtpbQyuqQi4eCmM7GvCuGwZFFLcbNfzYQg/6WiJ8vpOlDBcn?=
 =?us-ascii?Q?fRKgVT8u0Fzx8o/998PbOrhlCwmbf/eBhEcXJjahdILL/v0yf2EkDweSeRUI?=
 =?us-ascii?Q?lb7WtH1b8a5paVuAj0XO5LrovqQ/747bNeSX9p0VY3oEu5R5vGSr5wQE9kbl?=
 =?us-ascii?Q?IIbuDci9TEV2aMN9TR9Z15xVUDmXpFmtbi4bJTKQNHzTUuM6o4PVZvFrBdWy?=
 =?us-ascii?Q?8ksr7oiXGjFon4DRXp2yMKHRd6ZwN50T6Ux6G7371bK8xPzU9jaa2TbiE+Fd?=
 =?us-ascii?Q?oD4tr12wFmd15DJCx21jASqcAjTqwYKvINFSDzaFT7wB9S2mbSF8YY4Sg2nv?=
 =?us-ascii?Q?CInOVMbGpkDLUIclUqXE9JmOyCY77BEB/2DDQ321B23FGEqN39jtWtbIh83v?=
 =?us-ascii?Q?5WGpefQ2tKO11ieAxU9f2ORktDbOTFGepubWQMPaAo/A9mFM0vx/8xWJ4KsU?=
 =?us-ascii?Q?VoiELZ+McX/HaylWDFQ2d8uEzzrue5YAzfQUe68UsYch5BRbHqu37TN4eztN?=
 =?us-ascii?Q?QSRcFQjx0Ef1DAVzBFFcHZZrX+sfcckLqDi2r9AmRwj2NXPIuyZkR+NB7ot0?=
 =?us-ascii?Q?4prQ+4Bmp0VqMAV2UJOr26jcrCDo0jYgM+15kdI4yMXikz8G0/5bEYfATeDo?=
 =?us-ascii?Q?6Rkjwehdjg1ofXBcaEduNcNh38HbCXBQU+k6zLWORuXJDhd4E8roUWomUQbJ?=
 =?us-ascii?Q?xdL1MOViSMFDUSjb25maCKgwo5ULORsd/IdEVgqUIHMCTKH6Pq9zDVeP57ds?=
 =?us-ascii?Q?2XBx28tPIRiPjF8jP6NvcxKPE8X3MPRbWxieOWXwJJ2CJKcIrFC3w5xF6WJC?=
 =?us-ascii?Q?/JzXHWLod0+ty8wUiGGg+C/IcCi3fzA6g90FN5Y+JKcuVTXimW0UanQ/hV5y?=
 =?us-ascii?Q?mTZFAUn6Ibs6+4ApGs06pQ0Q5RpaWWgivEb2TvAxmzeLSfjbwbxmW3r7gCAA?=
 =?us-ascii?Q?7HbhoCCZDrLVNYQQVExr3Dam8ncOri6wbnR3ovab1CzLYHDasxg4scBDVKTc?=
 =?us-ascii?Q?Omi9cbTXscjfPABoVneSgOOQ5AcSX//jZ4XrIQBl2hmk4t644W8eoCK+YPdl?=
 =?us-ascii?Q?TGRDnYW5HHrhX0IAEgr2OPVvaL4vQVtmJNKcKE8XhKwOjFXHC1neAoVK7Akb?=
 =?us-ascii?Q?JNczMpAt2zajmbWkZES9NlZvi67iCBgRBghrpy8CCMbbhsLF5GcxP8r+f9WS?=
 =?us-ascii?Q?NkagFDCJ7Kgjbh703njPtGpfKZB0ATyA6ZETyJQROy3OxWVYi5OSR8SWtwzP?=
 =?us-ascii?Q?U1Aqlvu9OSuswuI9F7mvExvW1kCGnQzUWcOhi22w5iI6f2sj5yPEvdux/qPl?=
 =?us-ascii?Q?Jy72OCfidARBpsTy9raeHMRBd5NhqHv4wSNgr45xQrp98VixKbEdSGL7TYho?=
 =?us-ascii?Q?NpKOG1QHzdlBTNycgwJA4Ml2omoLrmEg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:34:05.1569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75105e8f-ad19-4d1f-d85d-08dd1bb57cbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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

The sdma context empty interrupt is dropped in amdgpu_irq_dispatch
as unregistered interrupt src_id 243, this interrupt accounts to 1/3 of
total interrupts and causes IH primary ring overflow when running
stressful benchmark application. Disable this interrupt has no side
effect found.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 4c8308b2878b..56507ae919b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -973,10 +973,12 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
 		temp = REG_SET_FIELD(temp, SDMA_CNTL, UTC_L1_ENABLE, 1);
-		/* enable context empty interrupt during initialization */
-		temp = REG_SET_FIELD(temp, SDMA_CNTL, CTXEMPTY_INT_ENABLE, 1);
-		WREG32_SDMA(i, regSDMA_CNTL, temp);
 
+		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) < IP_VERSION(4, 4, 5)) {
+			/* enable context empty interrupt during initialization */
+			temp = REG_SET_FIELD(temp, SDMA_CNTL, CTXEMPTY_INT_ENABLE, 1);
+			WREG32_SDMA(i, regSDMA_CNTL, temp);
+		}
 		if (!amdgpu_sriov_vf(adev)) {
 			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 				/* unhalt engine */
-- 
2.47.1

