Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEFFC369D7
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 04:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6332110E138;
	Tue, 22 Apr 2025 04:17:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lsArHWwd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7265610E138
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 04:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIB7C5wmRaZ2fWnNucYMFvWa8j/x8NSCfZ0x1GYRodGyjZ5c5a+Tr/6kPVgG4bqO/E35Mw7ZLqnMvi1HzKDqWPngdr8tqdy+UGJsfQhcQ7hrrp1vrivWs38zigY6Q54BQR4dBiNX72Wkqde3YmTfKBeiRkyvjYwOXo6PMi7UuIeuT03IgWSbOmg/eBZoWpjnJzHZgixDRBrVmRrbSneUaGbSNHOfX1n31Y26W/xrvLZOKUPa77T5hYN29aAieUFItv2g6KBeNLGf4/LsM74gD8/RISG7sdYAxtH9TpMXsZxKbfgwUCiW6Rt9guX3S/4wXG8iOs7ZuR9aY5Sb1EWakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3r+FJnpI8UzTtB/pBa1XYqy7xmxuj0t6WstCS2yVocM=;
 b=B87CepxsikVChS45EBAOLSs90U7qvy7DUseu8n4OwTGqfjlq0I6QQcLokRDaSUTj1YZl/Yc0MzWHuvkPn5fFlLyJ3T3mP8Gzvgrr5rwcjv37vR0xSTwgahkxRloS9E2jDIt02mvftB1lS3caEme24V/lndmalGS5tsn8nhd8joz1FSCx8+pQwp0f6pIFcE9JaNQtjU9V1atIK333IGumVgSaMUOOEeJIVHdrrGeNIfkzHxgJz/KnsxYUwAIO0waO4OaQKT3Cthm7Fg8Ecpbi23DYGSb+ntki3us+o2aVge0H1XBh0OmAtCj+FvHUHnyBqEJ8TukoSv/FwhJAK9UBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3r+FJnpI8UzTtB/pBa1XYqy7xmxuj0t6WstCS2yVocM=;
 b=lsArHWwd8HgMmRblq2/yaL4H2G2jy2eX7LbgmqPTOcI4554u/3wGTDSLfFQCRivIywmn0Dl+n1MHZBNqKhWEa2k0/kSbYuUAbHGisMFTkO5mzyIq/eUvt57jsH5L/Ig5QVHwxp2td71Yl/Q9slH9lf1LHH89QZWvg5ZnzGTaESg=
Received: from DSZP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::14) by
 SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Tue, 22 Apr 2025 04:17:05 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:280:cafe::4b) by DSZP220CA0006.outlook.office365.com
 (2603:10b6:5:280::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 04:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 04:17:04 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 23:17:02 -0500
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Trigger Huang <Trigger.Huang@amd.com>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH] drm/amdgpu: remove mdelay in psp v12
Date: Tue, 22 Apr 2025 12:16:29 +0800
Message-ID: <20250422041629.1938342-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: df61b7a3-2593-4541-baf4-08dd815489fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vsWhMa/Lq0u361Emh5YMXXW+lgXxAlzpvcZ46ns54Hb9sGFO02iMgFcBbQlx?=
 =?us-ascii?Q?8VMHrUo/PSb862eiy8Uh8IGRsPbjWeH6iWCzrRcztghTXSl2Hs8HPH9DPN/v?=
 =?us-ascii?Q?APdIrhpncANlc42sUQe+ZVk4ftFg2XrSuj4SLsY3hw4e0wnG3V3KV3+JbEUG?=
 =?us-ascii?Q?wsFwXCymDkopRN/QRSL0oNHzawKoEWi7u8L2lJUJge9/w/SLol5vHvUIV2lU?=
 =?us-ascii?Q?zJY9MOcRYMCDkOlMHaWD1ZQDFlS+BzFI/G4ZmPD2HP8UE9JbghLnAvSgmYnh?=
 =?us-ascii?Q?8qNof98mLens7KMH8tbips7bhRdTfdAfLOIKoEgGGStqCppew4XUUQePtR3S?=
 =?us-ascii?Q?mYX0u5eArSsKEhBbY8Xk6yIMMexRxJrT8nCvFADicw2PeI2Mim76PhtAiCeJ?=
 =?us-ascii?Q?tOB23lcALssfFqOpn/L3UHfVpy2LWQVncfN6Cr0LHWtDsZAcc0WteGr+yUxm?=
 =?us-ascii?Q?eEniq5jVR356cF+6FoScFSmoovb9Rj3KILDVLMdv/80Z+oHcCiw23L2pBtLo?=
 =?us-ascii?Q?qktjcHib7sTjU9dhwM1V03SllV43NnDsuReUUFaY77QGhNULAhYc7pIRrdzk?=
 =?us-ascii?Q?Jz5puIsjeZz78adkEIbpMdp0GXzP3C8XTSG7tENfOtOECIpo0M6XNiKWt4j5?=
 =?us-ascii?Q?MA0LFrZ02YW+7H9WcBQbBLNZyJlyJj9RjLNMa3kX5w50xeeAiJsAbpgaZrpl?=
 =?us-ascii?Q?kaBs5vktaw/O/OBhF4Dxx9pOMEjcX3PNOAV/vYHlg+9t501xhvG3flV+A3+s?=
 =?us-ascii?Q?9pwN2mMKhwZeeMfCaNps9vbShc6TX2M7uxElzys+ZobbveVd6JSUTnrmG0nl?=
 =?us-ascii?Q?alOfaWPNoEsaYMTUqSSSL1glysIARv5+R6rhBqachB6z9nUtlxFFzAd7lK8T?=
 =?us-ascii?Q?XRkXtX0oNqIvfX4YyEVgDFShDOlTQj5MqK4mnEA670CpComC2kk9RsVA2uuy?=
 =?us-ascii?Q?rJtS6FZ2rWgksLmhgqeOvJoRmkaiMLZg1Sms0YmSK0w1Q+a9MjZ6+U7cKtYn?=
 =?us-ascii?Q?mqJvNeVkw4JZw7Y6E9P3gr+ah2hrrpQLQsbw56wKFOH12j+IPvfbwwVzJZu6?=
 =?us-ascii?Q?XxG7i5846rHEfB2syNj0IDQI27Ucn1io7kYQY0vLd+bdWdVvI5tN0Rs3GQfM?=
 =?us-ascii?Q?chtayCh5Byho6CWv0QnePL1XouLt8uj4Itk6nWxR3yhN01Saqyjanm2L4Cp4?=
 =?us-ascii?Q?OO0fJjL490P15OEwmX+IGuP6QKo+8+spWhmoFGUcjFIleR1XQeSU5/7mv+KJ?=
 =?us-ascii?Q?UIR3oKj8+c4zNraBrTOsLghF8dU+p7BASyChRDtSA/2EV2u8/+/ErRgG+CpQ?=
 =?us-ascii?Q?simmDVokw7rw1fBR6M3J753ZR+AHlqvPyWol6X5EJ0FI7sfSBFlBuW3cs5DW?=
 =?us-ascii?Q?4sFE6seG0Xp8Zv2pYblUR5345JK+gigvAqdsvXztGlLHw3O70hJLZ2CGvzLX?=
 =?us-ascii?Q?DQNz2+kw/hyyxXjefw+5Jsx/w06zQfrXyD8aWdZoRy8Lj+n9Aq23DEp2MPO6?=
 =?us-ascii?Q?B/OepNs9oW0E83dMvHh3sYCTqzFp3Rq3oncj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 04:17:04.7860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df61b7a3-2593-4541-baf4-08dd815489fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
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

Since secure firmware is more stable than bring up phase, I believe we
don't need such mdelays any more before wait PSP response on PSP v12.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index fcd708eae75c..6331941440d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -99,9 +99,6 @@ static int psp_v12_0_bootloader_load_sysdrv(struct psp_context *psp)
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35,
 	       psp_gfxdrv_command_reg);
 
-	/* there might be handshake issue with hardware which needs delay */
-	mdelay(20);
-
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
 			   0x80000000, 0x80000000, false);
 
@@ -138,8 +135,6 @@ static int psp_v12_0_bootloader_load_sos(struct psp_context *psp)
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35,
 	       psp_gfxdrv_command_reg);
 
-	/* there might be handshake issue with hardware which needs delay */
-	mdelay(20);
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_81),
 			   RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81),
 			   0, true);
@@ -161,7 +156,6 @@ static void psp_v12_0_reroute_ih(struct psp_context *psp)
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);
 
-	mdelay(20);
 	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
 		     0x80000000, 0x8000FFFF, false);
 
@@ -173,7 +167,6 @@ static void psp_v12_0_reroute_ih(struct psp_context *psp)
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);
 
-	mdelay(20);
 	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
 		     0x80000000, 0x8000FFFF, false);
 }
@@ -200,9 +193,6 @@ static int psp_v12_0_ring_create(struct psp_context *psp,
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
 					     GFX_CTRL_CMD_ID_INIT_GPCOM_RING);
 
-		/* there might be handshake issue with hardware which needs delay */
-		mdelay(20);
-
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
 		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
 				   0x80000000, 0x8000FFFF, false);
@@ -222,9 +212,6 @@ static int psp_v12_0_ring_create(struct psp_context *psp,
 		psp_ring_reg = psp_ring_reg << 16;
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
 
-		/* there might be handshake issue with hardware which needs delay */
-		mdelay(20);
-
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
 		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
 				   0x80000000, 0x8000FFFF, false);
@@ -247,9 +234,6 @@ static int psp_v12_0_ring_stop(struct psp_context *psp,
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64,
 				     GFX_CTRL_CMD_ID_DESTROY_RINGS);
 
-	/* there might be handshake issue with hardware which needs delay */
-	mdelay(20);
-
 	/* Wait for response flag (bit 31) */
 	if (amdgpu_sriov_vf(adev))
 		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-- 
2.25.1

