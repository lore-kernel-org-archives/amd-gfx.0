Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246E4C3ABA9
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 10:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE1910E301;
	Tue, 29 Apr 2025 10:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZ5uuNM0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798D510E278
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 10:30:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbzVzo0pwDGh42TsWaRP1Fh+kLqIGycZ3i2Tksic90NPVVaFaMaDksCsuOxK/z1+HCKa1svNGqwAS6uEsthfnKoHNpeuGkLHD7Kmkxb10RlF0IVS7pW0eoUhfGS9vhA7JdAAWytwcRE1MayYbQd2gv5jZTOJ+yQpxfuTINBSX5NcbWS3DgUD4IDJeaC5AWQTXyxFpSNukEFvaOe0DxiA6fK6n6rNMd515EanbR1iWDg/+crK75pDXcC1nSXwU2p6+2u9/PM6rrmivnzcmHwA+jgp2bt7LqPZcXrtShcMz1hP0s/FJ0P/IF2mK8u+6ZmJTGEaVNGnNx3Rn02SAS5qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3EbujpCwcNcm1fXhfa0a6MNuegqFMvIO9HfxoDjjsY=;
 b=LPzWAHjRmw03Fh/1MQCBHqzg4AKdsQvWRnxu7qpnT/BWJ2r0WNGjGlKmB121Pu1YbYEXfrGGS2L82jOSyXvshTPGaYH2KtvpsIPb9BFkLGMm1kwzebHMFZ65msx7FGpyPOrLX1D5BknPCcliu0eTU2Z7edbdMr5SRMKeXaPaa9owypXrBMMXkdNLS+Ndbh5ZUgKjhItxOYSTLljGlH6B+ks67vQ3OWhUpYhkIHUCdrgE8gDXh11z7CgdUCHfzwSbqfXNBgRFXVjK0OEIvMg1u98yv5tLIIQVOQ2Edvbj//z9s/Zv7puJF/CjDY2dXdoJ1bi9m3b7sCWxaWq/60p+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3EbujpCwcNcm1fXhfa0a6MNuegqFMvIO9HfxoDjjsY=;
 b=hZ5uuNM0kqwFNmKFix4Vm715Sm7vU3IKerUNOoOzc5f094DpHTzO4ifp5WaXj+Sl7tEYgoVJXMywcqDIlKkvOaKftQQtdI/F1aIEKoM5tH5Nu2S+rKlcF9gvP1owSPJZMkL9bAeJCafdwhteyo89whjTu23VFwnuAITjXyfWWiU=
Received: from CH2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:610:4f::35)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 29 Apr
 2025 10:30:18 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::fa) by CH2PR18CA0025.outlook.office365.com
 (2603:10b6:610:4f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 29 Apr 2025 10:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Tue, 29 Apr 2025 10:30:17 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 05:30:15 -0500
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Trigger Huang <Trigger.Huang@amd.com>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: remove re-route ih in psp v12
Date: Tue, 29 Apr 2025 18:29:53 +0800
Message-ID: <20250429102954.3913983-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: aa83d852-259d-4801-52cb-08dd8708d5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/B4uX4nu2ZyI8GU1T0+1yvOy665mtQCwhAe2L+e2bwKc2zZx4gH1MSSq65hn?=
 =?us-ascii?Q?ymNZcOYfsnTq/bl7OaWHcDIMzjRPgwGllqBK/V6X4Yz5/7kHOoudXjuHj6Kv?=
 =?us-ascii?Q?uXBC5I7z1ZP+k0mqwFXNhhJMFQqEEywLRtJweVlZlWzwPUfnD8ndVJ4WRFk/?=
 =?us-ascii?Q?V2hvUPBQ9VsRAhykjQV2LK73aMVJ4P/cEUeHNRtYXOyGic8cMWhVtrh6okG5?=
 =?us-ascii?Q?BAFJytAezrxOPIhmd9Kr+/IWzm+hXzZ2Cl9NRnU9VfaeiawQEWeeG3OvSwe3?=
 =?us-ascii?Q?0JTGY3cowH4DYY3S+oPnRIdiCi517xftR0AAzmhKGX9j3DxNKrHfKaKFIgbg?=
 =?us-ascii?Q?fQyQWvCwn53do0IS35zz5nXZKrUX+QQAlvenZmiBdlVMHVlvio4nKWwOeA95?=
 =?us-ascii?Q?uht32+5DGvgmwCIf2U9I3hmc4z3IucYRScZb4bMdb5230XyFJWICdozA5Mud?=
 =?us-ascii?Q?NouXS/Ogf/K51eNOqsWoyhEX1wOvTTvHRG2saql66XRPW8KxnJmxKfl4gFKg?=
 =?us-ascii?Q?latfdnlAeMFYTCvag33PjnsFWg0blrGc4FaPJudynynv3Gm82N+DwiCrGAoH?=
 =?us-ascii?Q?msp5lS8eeumy36KBUuT/6/jtUAfBuqF7bjyN/StAhbEz5tTdhOSNCjAQIAsq?=
 =?us-ascii?Q?19WmH2+YfCrOXZcBZlXIEwTvaA8u3iUqfKaNlVSHKUQckVd8QZEmMIvrOiJ1?=
 =?us-ascii?Q?LenvkFO/wzqLxyqeAVfH3DzhBH/wVstgu8mpqnLoqzU/TzbZLS5+KLWuU1Ix?=
 =?us-ascii?Q?/HEaO04XYJsxo2ra6l1gExZr9tsT48ty3mBGD1rIgkW7hiYStkTml3/kxbw7?=
 =?us-ascii?Q?PLz73xJ0yhgofQjRyMzQVgNO6Abq6y8TZOrZWG2y7/dyIff8yCU3gsNXMtFx?=
 =?us-ascii?Q?J0yuApNH4h0beuiYdonTZ76K6B+319F2+D9Di4NouKdh3eRlq9RnvtDhCLVK?=
 =?us-ascii?Q?2VWScV+4Df8ggGF6owX4oV8ZhPzmoe7MHpUDcrB7dN5Tr6V4fHyISexYFQlg?=
 =?us-ascii?Q?Hk8f0JXg8K4L4s1G9qqEiewuBuNjftG8MfBLVSvFP/e/fzaU4HR6jNjqe6WE?=
 =?us-ascii?Q?vgLiMLmIKf+Sm961OTUKu8xfv6VsvW07k2mabtm2Z4sg/defmCqCNxrHouqm?=
 =?us-ascii?Q?SHN4C2ZoHRl+WdmnCF+JB9OKoDUooO5oHinbMLkcwr9aLflwxq+FfZOHnCHa?=
 =?us-ascii?Q?zG0oFtGST239yep/Yr0YB6Ri8ETCS/2uOAgz9hwy0uMxA6rD7JNmbJzSy/uR?=
 =?us-ascii?Q?vkziAql1AGcNLH5OHPAgeCTF6b1r9vVSIK1BpBJZjsVSMSd0EAUCS8kXJjZU?=
 =?us-ascii?Q?aL2L+l45Hy9vVwcmpXLId01xBjfKZQTFGIfKtz4/vo6oGsdDYQ8WnlXjPQMf?=
 =?us-ascii?Q?0fxhBvxVZkTOynTPqSKRJbq/pRfaS5P9bQ1QLadKGwMa5MxFpQhB6vIzNgr5?=
 =?us-ascii?Q?S6run3/s0kJoT7Y3LAl3cB46alCi39h/bslFmytOyQzdMz4gKphbJbcSSnTd?=
 =?us-ascii?Q?yeNMNESkitzmZ8FZg1DgRSU2a0qz9oP1j9k6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 10:30:17.5396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa83d852-259d-4801-52cb-08dd8708d5fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750
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

APU doesn't have second IH ring, so re-routing action here is a no-op.
It will take a lot of time to wait timeout from PSP during the
initialization. So remove the function in psp v12.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 34 --------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index 6331941440d9..ed24f61e1ab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -34,9 +34,6 @@
 #include "sdma0/sdma0_4_0_offset.h"
 #include "nbio/nbio_7_4_offset.h"
 
-#include "oss/osssys_4_0_offset.h"
-#include "oss/osssys_4_0_sh_mask.h"
-
 MODULE_FIRMWARE("amdgpu/renoir_asd.bin");
 MODULE_FIRMWARE("amdgpu/renoir_ta.bin");
 MODULE_FIRMWARE("amdgpu/green_sardine_asd.bin");
@@ -142,35 +139,6 @@ static int psp_v12_0_bootloader_load_sos(struct psp_context *psp)
 	return ret;
 }
 
-static void psp_v12_0_reroute_ih(struct psp_context *psp)
-{
-	struct amdgpu_device *adev = psp->adev;
-	uint32_t tmp;
-
-	/* Change IH ring for VMC */
-	tmp = REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, 0x1244b);
-	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, CLIENT_TYPE, 1);
-	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
-
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, 3);
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);
-
-	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-		     0x80000000, 0x8000FFFF, false);
-
-	/* Change IH ring for UMC */
-	tmp = REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, 0x1216b);
-	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
-
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, 4);
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);
-
-	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-		     0x80000000, 0x8000FFFF, false);
-}
-
 static int psp_v12_0_ring_create(struct psp_context *psp,
 				enum psp_ring_type ring_type)
 {
@@ -179,8 +147,6 @@ static int psp_v12_0_ring_create(struct psp_context *psp,
 	struct psp_ring *ring = &psp->km_ring;
 	struct amdgpu_device *adev = psp->adev;
 
-	psp_v12_0_reroute_ih(psp);
-
 	if (amdgpu_sriov_vf(psp->adev)) {
 		/* Write low address of the ring to C2PMSG_102 */
 		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
-- 
2.25.1

