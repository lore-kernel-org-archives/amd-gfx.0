Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBC2C71136
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F6B10EA58;
	Fri, 13 Jun 2025 21:48:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iR/heW0V";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A893210EA6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ON2lTjFNFzOMc/1N00ElaInwTbn0WrO8KaxbKsIAya+57IWvVktu/OfpMeCffnBYVn01rI1JXD/Xjk5bKuUzfxGLeQd5p/2+kE/vwBfXKECxKlB6/Z0UtF+4rK/efBn1lrDxwwJTEQU+PIs2wqyKAKRO+NmpsA/tziQfWFLlmQSsNdVBM423ebFkPyXvFH6V6beqsFTgbUuUNWYurp1tj45bdRu+thSeAj6kknVodn8mTdVX4ffZZfsf/fjkqdNgFKfJRdUbK5MD8/+xd0g3JOr1CnVFkrxBEHTGn2GV4f50uFx60dR7PMzEVj7zWWIQV2U0VkOaLrpN8236XEk9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3tuwNrxjJhhTAZAApWsluIbgnd1t/VHWoN3bkU57TU=;
 b=VUujenKmHln/vOIWFuvgjusMLv+RuOfvouzm8liwherOd2yQGEr7ID+LsA2bi31b9B6ALx4XOcCB3ZozPgMFATwhtUWbsFEOH2pDk4nFI0U8eja690kO8iefiYVFpjuja7GqUrTgflOV8jdAzBrHaiB+F79sPbk3fHX0h67/xIMkH0S7Rs25srMrlDTQk500fBYe+g9BVdOyu5Aw8oOVPj5KJdxSyvMowgvjI6emywuhsrLuUwqhke5fi6QXVPyAHfcZEmjVLrXQiSEmiISLMkPxFNIolfXI9SdmxWqH+q9/wPfsIb9mOjrCQoUwrpStm84yiCe0xopnFDJSdxcXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3tuwNrxjJhhTAZAApWsluIbgnd1t/VHWoN3bkU57TU=;
 b=iR/heW0VbyWw3bIe8OhjtYqHQpNwgckb/NdgE4Gjs8Du9swWa7O0QLMq+wazBe4FBUxCqlERmbi87ICdEl9UNbYngVx1qdfItO5AI1WY/ZlejxBoDntCbiLwPaZ5tAAx+eMamzFsCndcTwiu6FHUKQ6F5dVzJK6nctoQJ4Ys4XY=
Received: from CH5PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:1f4::17)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 21:48:18 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::97) by CH5PR04CA0017.outlook.office365.com
 (2603:10b6:610:1f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/27] drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring
 reset
Date: Fri, 13 Jun 2025 17:47:46 -0400
Message-ID: <20250613214748.5889-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fe98f4-82e7-49be-bc0b-08ddaac401d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c+2b6dRDiKUr59Ft8WfVva2jFXfIoY9MkDPWssFhOwF5guIMHC1iFFjsO12b?=
 =?us-ascii?Q?dJ9GFfxKu1CuHbVvO3CLIV7YDnqd0V/Uc1Qn5qqLG1fiXwq24XZgyoRUnik6?=
 =?us-ascii?Q?wS2RHzOr3bjZhDswqVHf3wQumnz4zsbbdVw5mSyviYe269worFWmfy9Je0Hm?=
 =?us-ascii?Q?8Gwy6mk/HGD6QDVkrt9pHhRWQjvQyQ39Dma4EYHCwxkN+R59DB/XvB1evxir?=
 =?us-ascii?Q?AkCnuZ7tyQytB8kwL209g3uqDKYz97FZvA+GvOPUHYf0hcoa1XkIsSR7OI5u?=
 =?us-ascii?Q?ZgWKf1L8R7C/Cg1Zo5tsLNMiNS6xTGibli8Azues847tQRxHpYTMyQJ8CugC?=
 =?us-ascii?Q?WobKutfQ9PrbiYhriCBswRLv1JviM2NRw8XGSq0DeSp2uA9FesGnrn4RJqeb?=
 =?us-ascii?Q?O2hnUfed2wYgtKNFHSThmP7+zcQr3SAj14u9dJqL6fy8AdqS3a1mmHzJ799O?=
 =?us-ascii?Q?XUsZ1jaf0t2aESQ35c0N6P6we/z4e/IzvB8ZrPIRXb+t6oh1zcqZrKvK3pQK?=
 =?us-ascii?Q?9ym/t+nlZLxCTygG0Oq32+MHvmxNC37xhR1yvuoj4tpl3051oc72uazw/MdM?=
 =?us-ascii?Q?CMzqGXtoh+NIxoPaYTYWjTAEvWTH4cOp2yCGCAgiof9RGn3ZsXJNmj1rN6/0?=
 =?us-ascii?Q?aidDxJBW3Ss9ZIoL3Fm+nX0LirgprpmVmIWP8Ni0iW6Q+lkD78REITuakRRN?=
 =?us-ascii?Q?Daa7FUXmhlsf4Ow/ooa8i99LsXQXasxVWQ9gEZSclIyrahKXfiowIA7OwrjO?=
 =?us-ascii?Q?Zac83rZLwYGm0Ovc9QUA1hvjyKX0S93F55QFwnjAc1qnjxev4QpYy4t2I+I9?=
 =?us-ascii?Q?+Ee72TAlDVUDhtdz5WVmc42w5vEsKTbVVHsE0dhip877x0RDDyYu+fbJT02z?=
 =?us-ascii?Q?K+K+RY3nLcY1u4lcRJLF1agCFTh/OcKjCsECk91kpcKxUKMQGS/cDfkGxiee?=
 =?us-ascii?Q?1hvaLM9qJmQas9ycxMDinDAjoISTRiQOWAAU4zcpgRC/NHj1HmwxiQG7W9jV?=
 =?us-ascii?Q?5+w6tOlOXi9zjif7h6QYxY/cPLZyU2tqe1AzLpetd/cr7vwICO6qmuJOyw/x?=
 =?us-ascii?Q?lMRrq6d7fL9oquZPbNJBolPLx+Z6JF3RUQ7dKntXPQfkqJeeHKGtpOzLVLiJ?=
 =?us-ascii?Q?Rd1+w3glKyaRbHDbzaw5G411IAndvf37PASR5g0sVmAO2yvKIDHXcz3uYGp1?=
 =?us-ascii?Q?hVTBhiwB5hfYihbDlcxz0xxJl8VIgVRw5u8mI0wumwTRbR2FockpIc52YTI8?=
 =?us-ascii?Q?Lsn0qxuOssIH9glZNyLw9pFr8EisJr2DZ1Hi1pHPNLx/19TE6ruZBMA1nJbT?=
 =?us-ascii?Q?Sr5WUKRLxMgXpc8VYkVZ4BGv40E87U09sqlGwyMi7L/p8vDQs/PFNl+T/HEE?=
 =?us-ascii?Q?kt0gFIL8SBNuhmD3bN/X4N9FWrUj5o6WkFiOCY7BhOi4eHi7H4VWt8IKCmlg?=
 =?us-ascii?Q?9ah+j4GdWp3WEjD+1pvE5S4fh9Tjfwc2IKZ43oxAo0InSSw4wbrw5u95yi+q?=
 =?us-ascii?Q?wpK1ESQfgSMiSINFKRGRTdzdCXfEbZxjEdBb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:17.6778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fe98f4-82e7-49be-bc0b-08ddaac401d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index c7c2b7f5ba56d..6cdd49e9ef07a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1609,6 +1609,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+
 	vcn_inst = GET_INST(VCN, ring->me);
 	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
 
@@ -1622,11 +1624,18 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

