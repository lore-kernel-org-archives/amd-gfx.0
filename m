Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACADC3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 954EF10E440;
	Wed, 17 Jul 2024 20:39:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TF3OVqBH";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05BDA10E44A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npBYDK8M486lrJon6x8pt2YVAQwWGdF7yP/pwdelsqgWNn2xsfMc1CjVRcsrvxpA3c9+vRNDHzK7hzLSNd9EksHTPY6xecQIF0DLnNdNCBvY5clWfkfbdi47RTxUNBpwjl6Kz9sNAZ3F53np/p03RUsT5ltslVqXz3E32WveEwnrbpbLXs516GTHympmFbZqHFEYhj0lUpeu4Uos6fJoqmDqrCgN5il5L7826cbjdso8o4qxIbtH2sBbWW4OYzxpJxjaEiWZA8iPsuIV8ZYz+zgLg9Mqzc4UVSDKuRWYzBFv9APm1/cBwt1bt2r8cdR+B/P0rgO9LjFC8Lc7EStO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2jbTDqjhc6hjY6FSlu4eMqy+QbikRR4EY3FDN2TSTU=;
 b=S3sxQh0zqySDbDAc/snTLIROzHo+NLfA+3jBdJIrASjoYL2fl7haEq1bDhtP0pDn69aez8fqZrnYBPeX7mzUnvBJ5OqLsh94CCgVWjzpjee177Eh+9JEARndabJIZ9F9v+xpMb7Q0f7OoACpy9IscvWvYvt3fYb5+60gHf3iBwp9EQYJ0mZCE3roAc5LvA/C2l2a2OZ5msXxZcEpyhOiz0e0pilfYE9NUlWiZDTp0mMN4xZqdmI/B1CfIRw3eIbSp2k8/7XAewxNaVF1SHhLPWh64fzqkEVEYp9QDjsTGW9/WTTSWDBOgq4WIFwINl5DnXSNh3jtmFfS9RFftjVgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2jbTDqjhc6hjY6FSlu4eMqy+QbikRR4EY3FDN2TSTU=;
 b=TF3OVqBHOBodOFuoYLqVV45F+ay9RyWqiskJi4nOTpYXSl5TMfhY0qwDuQd18E033lbdotrxytiqn4CtyFUrRZU/wpFjItnocnESWwhCLzUUjmuquUpoz2AcWElM4tV7vvsqLJZVgR3l377eXOfr6GXEvwXVQx2xXomiYpsobTA=
Received: from BN0PR02CA0031.namprd02.prod.outlook.com (2603:10b6:408:e5::6)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Wed, 17 Jul
 2024 20:39:11 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::e1) by BN0PR02CA0031.outlook.office365.com
 (2603:10b6:408:e5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 20:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 17 Jul 2024 20:39:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:39:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/gfx9: properly handle error ints on all pipes
Date: Wed, 17 Jul 2024 16:38:47 -0400
Message-ID: <20240717203847.14600-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717203847.14600-1-alexander.deucher@amd.com>
References: <20240717203847.14600-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8f2c0d-1e91-44e2-0cfb-08dca6a08378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VJgUGIoh86m7Br8T0e5MEGbKv6MRnaccHQ5xh8G9B3Pu63ZV/VkKlOLoUCHM?=
 =?us-ascii?Q?3LjyT/Bz9XZudeP8kGxW4bNyEylgLzA8xfqa9WQlImL9dKgN/CQgFHPP9C/8?=
 =?us-ascii?Q?cyaXd8fBMx+WVaPHKYR33DbvALjDDkqNsZwjiuL6TRd6+O+djN7zCQ6jNu3I?=
 =?us-ascii?Q?HsyjaIS6bPmsCogQ8xkBhTds12cMrsmeRWmU37PveH+q044CKfMs65yDw1Je?=
 =?us-ascii?Q?PyreJ6J5e1QGdmYs47N9p2KRRm81XY/cz09no57a/rAaRgpeKk/RoXXhYeuY?=
 =?us-ascii?Q?Uo91a0bxfZc9nWHFTI/o+pVHstU8qDpwi8d++qq0+Ag1dfA0yzcKMeL68EN3?=
 =?us-ascii?Q?8Sh8ev+jQejuvWKCxUDjH7WFNCFoFunI4NiSphsXH/9JQL9u8ZtgJDbmSGkh?=
 =?us-ascii?Q?Ddmz5BPQmnePK/7u/ivH5Ta+M+97Z49Ot2+ByMtL2ranE1tZUE1fPv6wdxQJ?=
 =?us-ascii?Q?PVsKCkMZxp6uZnMFiAtT569zUgur2NiMjH6hV3fYSlpFkDDge5B4VXOLI+Xv?=
 =?us-ascii?Q?w5Z1dRx4f6uHxUxwabVMqTqeHIKiDSlKHayRwR1rPqWTKG/KE3Ss5EVnftDK?=
 =?us-ascii?Q?JHFYEzYqPDtC5iJ6640wrCS5/f2rX3B8xVPQDGSvOE6JFjbgbQKL8BV5niBU?=
 =?us-ascii?Q?8qFUPPuql83mF7E77SCzbfCIHMFOdb5igAEPOMqK6nwyYvlG0qIrKS66bCXZ?=
 =?us-ascii?Q?Q2jOvr8GJ2cyJ+v3A9+vzI6dpiqLgd5Ys9tzMk4emPdAouJkYN3pLGnjCVbM?=
 =?us-ascii?Q?vOFVcEM7QOZRiB18xJ3eKlfub4fmZcFCBjm2ZmQ6ddJRZGIgvx5lY2yK/5A5?=
 =?us-ascii?Q?7JgTjBUPBE+uajJtNm9ayTgDzB/+4n7pq4HzYFzI0t5LXyoZhznDO+1tWtwl?=
 =?us-ascii?Q?jkmzY9M9ggkhH2yzZu14HCRRUUfO74wAPPTNmrjPiBfTfu/SDICtvKOFByvU?=
 =?us-ascii?Q?F/hJ5LNDuc7xrVQ8e3MzC18xqUGedePv9KakBNgDPYfbfH/1ywm0ksJFrNDA?=
 =?us-ascii?Q?PAHRB7mZV8MajVhzFAeQX+jRrQKq+w4PI9F4ltFymmRcQ3t3ofi9afn+s4ZF?=
 =?us-ascii?Q?GmH85NpZhzr44PIC5ABo0UoLeLH+m8iHepXsZQPVuM6OUa6E2RpF1VVG7/0v?=
 =?us-ascii?Q?ZNXYXowkYp5Xry0PL3XV+7osVxG1bChgB6VBgRbpdTa7e96sWQGWCDyXDxZR?=
 =?us-ascii?Q?1JZFWf6WDS7LgQXAHZvkK+wJrlyWlj0wVvgyqHxx0O/WUebza84fkUrLBi5D?=
 =?us-ascii?Q?44Zo9X2qhxHI/g5MEN27jlkTCOe3tC1NUUYK9avI6E9X7n3dfKRajqj0jE2/?=
 =?us-ascii?Q?Gn4pO7N4+CUaELTu5/Ystgvrggx0NlE3Dy/etu7hIcol9IkkidgaHydR6nEP?=
 =?us-ascii?Q?lPM/2D0cj+IyD43laqcWNBWQIt0JJ9KFCEaDh/jdm0HZ7aqJfpD7zQsOMSEc?=
 =?us-ascii?Q?FZVgSDSM0prdR4rqg/WQvrZdvdN8HY61?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:39:10.9803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8f2c0d-1e91-44e2-0cfb-08dca6a08378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
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

Need to handle the interrupt enables for all pipes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 44 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 50 +++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d4e38edc9353..97476fb2ca40 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2634,7 +2634,7 @@ static void gfx_v9_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE, enable ? 1 : 0);
-	if(adev->gfx.num_gfx_rings)
+	if (adev->gfx.num_gfx_rings)
 		tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE, enable ? 1 : 0);
 
 	WREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0, tmp);
@@ -5929,17 +5929,59 @@ static void gfx_v9_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev,
 	}
 }
 
+static u32 gfx_v9_0_get_cpc_int_cntl(struct amdgpu_device *adev,
+				     int me, int pipe)
+{
+	/*
+	 * amdgpu controls only the first MEC. That's why this function only
+	 * handles the setting of interrupts for this specific MEC. All other
+	 * pipes' interrupts are set by amdkfd.
+	 */
+	if (me != 1)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE0_INT_CNTL);
+	case 1:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE1_INT_CNTL);
+	case 2:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE2_INT_CNTL);
+	case 3:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE3_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
 static int gfx_v9_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *source,
 					     unsigned type,
 					     enum amdgpu_interrupt_state state)
 {
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
 		WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
 			       PRIV_REG_INT_ENABLE,
 			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				/* MECs start at 1 */
+				cp_int_cntl_reg = gfx_v9_0_get_cpc_int_cntl(adev, i + 1, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+								    PRIV_REG_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2ac398184e12..43a3ef276b5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2899,21 +2899,63 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
 	}
 }
 
+static u32 gfx_v9_4_3_get_cpc_int_cntl(struct amdgpu_device *adev,
+				     int xcc_id, int me, int pipe)
+{
+	/*
+	 * amdgpu controls only the first MEC. That's why this function only
+	 * handles the setting of interrupts for this specific MEC. All other
+	 * pipes' interrupts are set by amdkfd.
+	 */
+	if (me != 1)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE0_INT_CNTL);
+	case 1:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE1_INT_CNTL);
+	case 2:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE2_INT_CNTL);
+	case 3:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE3_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
 static int gfx_v9_4_3_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *source,
 					     unsigned type,
 					     enum amdgpu_interrupt_state state)
 {
-	int i, num_xcc;
+	u32 mec_int_cntl_reg, mec_int_cntl;
+	int i, j, k, num_xcc;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		for (i = 0; i < num_xcc; i++)
+		for (i = 0; i < num_xcc; i++) {
 			WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), CP_INT_CNTL_RING0,
-				PRIV_REG_INT_ENABLE,
-				state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					      PRIV_REG_INT_ENABLE,
+					      state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+			for (j = 0; j < adev->gfx.mec.num_mec; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					/* MECs start at 1 */
+					mec_int_cntl_reg = gfx_v9_4_3_get_cpc_int_cntl(adev, i, j + 1, k);
+
+					if (mec_int_cntl_reg) {
+						mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, i);
+						mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+									     PRIV_REG_INT_ENABLE,
+									     state == AMDGPU_IRQ_STATE_ENABLE ?
+									     1 : 0);
+						WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, i);
+					}
+				}
+			}
+		}
 		break;
 	default:
 		break;
-- 
2.45.2

