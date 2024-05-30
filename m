Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C868C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 01:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB5311A7CA;
	Thu, 30 May 2024 01:34:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="shEfY1wx";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6EC511A7CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 01:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npIBqqa6h4g7dT5vRavseoDREI4Rquh2FnLlXrYgu9l1sfgqR7IAPv5PRdGQbC86QWdwRWS/Hs+sDINYfI0c63X05mUiFTomSM9S1DwdtBoJ6cBg4WvKppkZwsIux25KkEpBdmnUk+L7lxOtSwta/PIOiwMxxf6z6GxG0tOIC0mMN//1JqAhpRsKyKPSyiAXKH4oB5Rgfd4SkJZxQggxTmtkYBm48XO9dXM8RclO/bAhLHmGaiLcLM4XrZ1mqRiXmrpTHd+DVesyJFto0+tHpVvknVw3bj6ETjpVp3Sr5UOCJL2j9WYiGKZuJlKyLlZAhWzdqwV1uQPpG+0OlGycAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV7YFlGQg1V3QYPU7wyb94Me44CbSY2XLkVWkdHykG4=;
 b=hChxIn57KrIwAKZwbsBxGTYgzDay5niR77krY3IHThuldqicVkVwoW4jrNPC/DtA+QiE+EnngqLI5y25XKOyQcNR+7DZcup9nSE6Czai9/5wGf0aGBLYf8sHoSneu7FA2xeaF4SDbuchl5osT91+UMfIvx7eb3rSn8LNfE7jFUmaE92sxO/avjQDAxkjIEfkRk9zh72eQWOoBtLqo905PW4Z6raJdmOdp5IUOkgdqgYQT31NY6NtakH5ZNc2YdUN65H61HDkJ53GZUdYVGKBd1IJq/YEAM2sbwi239EtxMQvw4zcQ94I6mPPcICPTjxayG1ZWykD2LXQxapLESw1gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV7YFlGQg1V3QYPU7wyb94Me44CbSY2XLkVWkdHykG4=;
 b=shEfY1wx6lKJH0Ty4xttshDTH6SGOqqkk8G0f8+pcyCFqxMuGmUoO0pElKVuBfmaC1lVxjsJ4Z+R7T57+bEH5F/i6RqW5Aa6jwrnWUyE2NGmqCia7BdlRcWQd9SrsTXLkoQfwB/wvS34uyjQer6tV5zCCAyK9/uOXrVFW8AMhUY=
Received: from CH0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:610:b3::13)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 01:34:30 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::f4) by CH0PR03CA0038.outlook.office365.com
 (2603:10b6:610:b3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Thu, 30 May 2024 01:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 01:34:30 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 20:34:22 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Pratap.Nirujogi@amd.com>,
 <Mario.Limonciello@amd.com>, <Bin.Du@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: init SAW registers for mmhub v3.3
Date: Thu, 30 May 2024 09:33:35 +0800
Message-ID: <20240530013337.20776-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 554a9ece-51af-4772-0ef2-08dc8048a6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?47CRHos7qE3GcraehatGC8uB6VJsY6G/aQXUB4m9TuywA00FC2vMXWz3N/kW?=
 =?us-ascii?Q?6ojWWpCXkwBtgL2OMsvRHx9FsXkHIqBbhlFOvEwZwW3Fvf96n30AidgCEu6E?=
 =?us-ascii?Q?FytJEWmBRKj2L41XFTnpJd2qh2j1RfSJfoKTfmTaa5zBdp2c/QBA9AchzIfM?=
 =?us-ascii?Q?BqjRWLb/3LQPvSFzBrN8yMXm/TDfujm7WqyhgTEeTKJoCE5rsG49ZPFPXxXF?=
 =?us-ascii?Q?Te6Xc3O8aMhBUHqEKi5stkHDSy2MbJyG7eQspKkB2HFsubvq+kGIUCi++5Fb?=
 =?us-ascii?Q?pBbbBfnQ7n69QHgOgzyru+QquWPfH63+N5XdmcFb1FFCMWyZDVrG7Zks3Wb1?=
 =?us-ascii?Q?vFMoGBY96mb+I4X5sx/Tj/UoqcJOWG+UNHocT1YHPxXAncqWOxRPrnzrvYYq?=
 =?us-ascii?Q?JdA5r/SX7gkENZRDJzanKqsxhJeiLmNZALJxoh7C+xNnYBj74H2kPijHgjJo?=
 =?us-ascii?Q?JfxCpr0DJR9cTwOBKudmGuSBtGtoTPEkDa7I7SHb2ODGMdSBNXKoXwgncDvy?=
 =?us-ascii?Q?OzibduBh7lLb409STGceqRvE9tQTyikIQkSL88pdgNqOemJ/CxNcWmh9s0nG?=
 =?us-ascii?Q?ff57JRyoree94frvU2JenZuoTIwo4j/lpG1EiqGXf22tR34CPrD0b0yXgAVv?=
 =?us-ascii?Q?V7nHK8NRw0HosHPic8DG+WY9mnLKUruHTxOaoRnS7RgpUDqGc58L2v1N2OGa?=
 =?us-ascii?Q?2uYcN2JdDDeXvpaXFph+EiEp/ZUPxcH/MSW1lJbq2O76DuzXm9vUDM+k2e6e?=
 =?us-ascii?Q?CaiTCE7r9UF0VdojZ+nEHZOl7awdWtebXj7mXpvXeu5Hxp9W2BcQkpTOYuCK?=
 =?us-ascii?Q?LoJoM+yO3eA3/Fi2AQRT4rL2KrcvcB+SrHt0egWz4A1sS3DSKVUb1S7L2eyg?=
 =?us-ascii?Q?TiQc9PPLqilb/xjNq8r8YRtmiN0rztZb9A+4rjJFLL/XJeRFL6MT+yH4hhBL?=
 =?us-ascii?Q?XR7Re9vyImSLXo+zXXGP64yAAz24CtWCUTZTRDznYLEI3WwWLSlT3D0rL4Xi?=
 =?us-ascii?Q?YhvGrgXPu2fPRYyslTv0g7Ran9WK49BY1+FxAzvB+YU4a6OkqCDBwZLW5NiR?=
 =?us-ascii?Q?KRRzMbHbY0Kyp2LcOoexkBhZvcoYvl8/BetMzPX2gU8P70jNX4rudCw2U2/q?=
 =?us-ascii?Q?P6AY2865uPjswFuVucNuCzL7LnKPtba0nnRgHrdVrfFNrj+ARGayScy6RIiN?=
 =?us-ascii?Q?X4EE4vyxV8nB5Gk7NCWLavboZjADUA2thurfnIv7HqtGMBkJ1CAb2Fu5x0QC?=
 =?us-ascii?Q?o2SnpQeNiylEULSo1kwimOXZjLko/+rgSGFwbH1EvXAGc2Q5l3aHeG46TRZL?=
 =?us-ascii?Q?4Bn0xX8LW34h6emTUA8MUIVZi3UndPbLz8pMTcOIBsOmIkb26NDacLQIAa3S?=
 =?us-ascii?Q?mRKgFE/KBTa70QxxYDeRFKvjO9oB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 01:34:30.2435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 554a9ece-51af-4772-0ef2-08dc8048a6c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777
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

This patch to configure mmhub3.3 SAW registers

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 40 +++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index 238ea40c2450..b22751a25c9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -359,6 +359,43 @@ static void mmhub_v3_3_program_invalidation(struct amdgpu_device *adev)
 	}
 }
 
+static void mmhub_v3_3_init_saw_regs(struct amdgpu_device *adev)
+{
+	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+	uint32_t tmp;
+
+	/* Program page table base, gart start, gart end */
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+			lower_32_bits(pt_base >> 12));
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+			upper_32_bits(pt_base >> 12));
+
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+		     (u32)(adev->gmc.gart_start >> 12));
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+		     (u32)(adev->gmc.gart_start >> 44));
+
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+		     (u32)(adev->gmc.gart_end >> 12));
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+		     (u32)(adev->gmc.gart_end >> 44));
+
+	tmp = RREG32_SOC15(MMHUB, 0, regMMVM_L2_SAW_CONTEXT0_CNTL);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_SAW_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_SAW_CONTEXT0_CNTL, PAGE_TABLE_DEPTH, 0);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_SAW_CONTEXT0_CNTL, tmp);
+
+	/* Disable all contexts except context 0 */
+	tmp = 0xfffe;
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_SAW_CONTEXTS_DISABLE, tmp);
+
+	/* Program saw cntl4 */
+	tmp = RREG32_SOC15(MMHUB, 0, regMMVM_L2_SAW_CNTL4);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_SAW_CNTL4, VMC_TAP_CONTEXT0_PDE_REQUEST_SNOOP, 1);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_SAW_CNTL4, VMC_TAP_CONTEXT0_PTE_REQUEST_SNOOP, 1);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_SAW_CNTL4, tmp);
+}
+
 static int mmhub_v3_3_gart_enable(struct amdgpu_device *adev)
 {
 	/* GART Enable. */
@@ -372,6 +409,9 @@ static int mmhub_v3_3_gart_enable(struct amdgpu_device *adev)
 	mmhub_v3_3_setup_vmid_config(adev);
 	mmhub_v3_3_program_invalidation(adev);
 
+	/* standalone alone walker init */
+	mmhub_v3_3_init_saw_regs(adev);
+
 	return 0;
 }
 
-- 
2.37.3

