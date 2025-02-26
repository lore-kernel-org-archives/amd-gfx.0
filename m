Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45373C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 07:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E995E10E867;
	Wed, 26 Feb 2025 07:32:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VEGSS4mg";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCFED10E867
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 07:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLK7LZUJq8T41zQPS1AwT43ZeJob9Rlu2n74VAb2E9HCxkerubDr2D/oA57G4Wz+w4gepoh5b49ucqw3Kr2B/Xj4jwricGb7Su1pjRGCf984Nncyd3fitsapEhjaCEJKCtjslARGlr9Nrc0o6CpPisadLrjKemBT1OoqYnZVjEJt5xo+OagjgpA+d2G2qFXVE5qn+IzjXzHIjzJCCuEbUcFxxNN41AD2/LP+zmV8IDuwpU7nstl3ApRi304uG0L037DRvLvf/pSin+o6ADFTDqiBWiFTzcZhgqJzrCiLjd4CZoYMSkcvoDKR1bTpz1yZHW1Hsw6XNekPKQX5LXBKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMNVHLO9U3XVd9v0ty1j9rnzj3MH4Lm+xSwLnWoh4Rw=;
 b=NoAmxDd+c9GG8HcmAQAU1A/ey8Txe6sej+fltV2v1NYCtR/CQRCdzqFAb2oyu4JeCIh0lf8qzNiPiLPmPw9j8gMqP7sWF9EgFTqcn5ryozkVigrm0J5DJeLC1ZRwEH7TbZB8CxJUJGqQsVPhrdLfId49aYheoSojew/yP653fbICfWyDYfi7pPsmQvHh+boj1/RpvgLYTI1VfWKb4eNVX0W148a/IV82CF6PGXGlQEFlJksYAS1nAzXPNHuhhCANGHP/iWQMlTNEmOpW5ELRmEDIdJJyUL41FXppZqVerWiHIbfeBdm41o9gp9F6Y9FhttOR/N3xKsBfvsUn3s3h9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMNVHLO9U3XVd9v0ty1j9rnzj3MH4Lm+xSwLnWoh4Rw=;
 b=VEGSS4mgXZPO5gwPv8oimayeJlpSCXemlGgu45ikjzSi6kvPZKYnvqKYmRDDeynTjKNup1a10EKp/Ux2WrUs3iM1G38P7Y0pxyya8Cjjohhb2SH1w/hT2Y4W+n7+jIsnjGApDagMcPZ72clWY/DwHTRafgb/bAgH1K2g3PTUGvs=
Received: from PH7PR17CA0065.namprd17.prod.outlook.com (2603:10b6:510:325::9)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 07:32:40 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:325:cafe::33) by PH7PR17CA0065.outlook.office365.com
 (2603:10b6:510:325::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 07:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 07:32:40 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 01:32:38 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <leo.liu@amd.com>,
 <sonny.jiang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Use the right struct for VCN v5.0.1
Date: Wed, 26 Feb 2025 13:01:31 +0530
Message-ID: <20250226073132.142539-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 918abc2a-2601-43b8-904f-08dd5637c026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MCPxRJFKyq0jPXTTJUSYWQao9Uy++8txuME9MC1HmmtreyQ5qA45ndkFhU/9?=
 =?us-ascii?Q?Xm5WPvfB9B5DgBy6WO0VmwwzBWuoC3lfLua/k9JsA0htxwL6zEwHolROd/cB?=
 =?us-ascii?Q?mqM8fsP4BnkHPDMACgwgT8mwE10OpAPLtYau9NrzyU7LMglIT9wSmn2iCflI?=
 =?us-ascii?Q?+7UlddKy2SdZqC5kITrPbkQ2YEoPWp4vx/qr6tq71GNpJu9UclKjOddtVws1?=
 =?us-ascii?Q?kdC4MrRXCIcvU3kYoSG8S2uhbkZDC8nTcIbENx6ZjI44Jenm94kfxhLb2rj1?=
 =?us-ascii?Q?8drwuQrnuZXwktu09e2Vnv1liz77WzPwbNBoVQQpUaPWyTSNs+2hJBStgFkp?=
 =?us-ascii?Q?c9mR2rcAakLtnnmLAKK6IGJkrEMxf4BcJpFh9LFEz+tIIBGcqZHLlyRjQln0?=
 =?us-ascii?Q?G3FEDowoMj058PQFULnnSRiDobdIgq8kc3v7Z5pJzGzXHqpiLZe4xWWhJAIn?=
 =?us-ascii?Q?IvUpCJqqLJj5a+pnMYH4GbVy6Lbqvc8UMEEACcNMB6ke4x9t+pAdsFFh2kVs?=
 =?us-ascii?Q?1hNOgod6vEWIySEUopfQ68jsRVI54Eoa/TfFCI98JC50qHrQsL+KjHlgbfzM?=
 =?us-ascii?Q?Ey/j2maoXS64IrF18Vy6RaVp4L0LXxs8WcQqn8UWvGL9CvEtRtAolW8prdCI?=
 =?us-ascii?Q?gNaNJEQQLMM2h6lU7pASRVAfhGFr4lSEXXkUtbSpvP1rDg3UxMcKx1a/fjwG?=
 =?us-ascii?Q?0Utg0S8+nSU5n7djmqxpaqjElddMtmtxJ+jchdSIpvuJagAfEWI81I9Oxxl0?=
 =?us-ascii?Q?l2Wzjq9s9bDUsy2cuynOg8p/sLZdoW86e2zw9WdrsSPa4WYQ4gqW0L3q+iyO?=
 =?us-ascii?Q?LoTKkV72/z/SL4qjx9NJVdipmtj/D1x77jFIG6ZbzSibxR35DlMpQqfxiVYc?=
 =?us-ascii?Q?BCjpY6/U1FS++RVyIAxGz4pT3CrGA9AMU93hhBxkNeqUROmMK+cP95mU+bV9?=
 =?us-ascii?Q?R0yJdOeFjQE4P9LJq85GwsmqsKeVie/MEs8PFKYOb8oNWrEvxs7Qdzx0OyEN?=
 =?us-ascii?Q?A8M3/Q2/Tzkf26tjk8rbOWk+pcKhL/PUlNKUpg7JTVBMDC13zemGZWNIkYdk?=
 =?us-ascii?Q?XPGPGt/OMWDbvct0DyS5sCxvFHEIMSzU91WuH5JVS7WgKK/WsNTopjpGkxMf?=
 =?us-ascii?Q?G5J5A+fIPejRFnWhiskFEPmErWAgmafb+xvTSWQ3NvlBJMHcm1OlfCxeYt2p?=
 =?us-ascii?Q?ZGdCQPoSFPexLFjyI/HIpFioF+Qb2PmA1lvYzR3ZxRD/28UtW5mbxpYU693n?=
 =?us-ascii?Q?BYnTaVzUhRC0skTumMXqZXPk6YIbTXeVD/lldsyYC4XCk35/WW9KjY57/aBE?=
 =?us-ascii?Q?cv+ao1s5qxCETMFtqeCjSLCaPiGBApW4sH/MVlktgXomLA9hSHvIf5JJShxo?=
 =?us-ascii?Q?blxRxSxzNzUa1k1npnOgceClsrf2zL1+446+PqR9u3DeckqD8WsVB2QxSeo7?=
 =?us-ascii?Q?Yz7p2X9qWCjwBkktW7tpWl0+bg8m2lhF9kiq3eSVwTMzo8LfZxNNPti2KMnM?=
 =?us-ascii?Q?Ye2SJTfUOa8O3d0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 07:32:40.1858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 918abc2a-2601-43b8-904f-08dd5637c026
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326
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

VCN IP versions >= 5.0 uses VCN5 fw shared struct.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index d29e8d685194..7ef83c9346e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -153,7 +153,7 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+			volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 
 			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 			fw_shared->present_flag_0 = 0;
@@ -341,7 +341,7 @@ static void vcn_v5_0_1_mc_resume(struct amdgpu_vcn_inst *vinst)
 		upper_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
 	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_NONCACHE_OFFSET0, 0);
 	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_NONCACHE_SIZE0,
-		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)));
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared)));
 }
 
 /**
@@ -451,7 +451,7 @@ static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
 		VCN, 0, regUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
 	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
 		VCN, 0, regUVD_VCPU_NONCACHE_SIZE0),
-		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)), 0, indirect);
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared)), 0, indirect);
 
 	/* VCN global tiling registers */
 	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
@@ -493,7 +493,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int inst_idx = vinst->inst;
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared =
+	volatile struct amdgpu_vcn5_fw_shared *fw_shared =
 		adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	int vcn_inst;
@@ -602,7 +602,7 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
 	int j, k, r, vcn_inst;
@@ -780,7 +780,7 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
 {
 	struct amdgpu_device *adev = vinst->adev;
 	int i = vinst->inst;
-	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0, vcn_inst;
 
-- 
2.25.1

