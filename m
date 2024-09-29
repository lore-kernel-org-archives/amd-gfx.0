Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8F7CF6495
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Sep 2024 10:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3DFD10E1C6;
	Sun, 29 Sep 2024 10:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KBmIRBhb";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D6D610E144
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Sep 2024 10:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xwcg5Ee6V/u6XzbUNFWeV3kO6auVmoQ/02X3HeXf3lI1QIlAWFQOFGPMJST0BvnQ6BMaRNsg23tc3cMhn4QMZnKQBMYEbPfewGNeqwZEpZTTRrJ0enzmuXG02OxSW2Nb8lHIDEu18UcXjtcG2860A4JwibMC8d1DlSx5KnVNt0SfJ6nckLKpEFZhU1ABlp9EOwNMDa9ff733+rBqjoa0Vv5aqxlmYe3xr85ch0HIbxwS8HTNOFogcNU7yuRIr9PildBLoeoxW2de2aKv45hm5jZ8vV2l1WfY+W6SDwAfDDsP/IBZU/Ef4rZOIS0G96cslAB3kz3RaTMMjrf9jhDLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFQAe14+388YhhEZ5WqkpGGeOmEsJNrdi6lCg07XT1o=;
 b=Nl6aa/dG+97LMt2y8Tl+qReoJOAr/liJlWTFLOConr06Rm+vmZpPQjiFl7i/VSGA7rEU6cQzfMxvbr4C+qPJXF7WBjHYc0MLfVCNOzaYlcEaQrBFAra9WwEe59LJcXRphwzn9fz/MOHP2ZtaHZVwY0SOfvrQ9jbmuTH/zRYJfF3NxOvBfJsgiNSgF16cYzIjk7RhBfqTE1paBybehvbZfLuIeNKErYK3kPIzOSTZhngYuO8In26z/3Z3LPJBzQqO/jqvfnoFKz34LXznPJF22eTyUn5ipsyLXlsSOBlX6TS4CJhkomTfQB/QZqT4UYjcHIuw4jmFfpLkCGrWoepYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFQAe14+388YhhEZ5WqkpGGeOmEsJNrdi6lCg07XT1o=;
 b=KBmIRBhbl09O5mjrmHZoRP5qacC6DXPxLrD4IloYujLPocy1YYfmSeisJowDCVvBvHDCYkJOuKaemdPue2sBywJJZsRfgvR9n0pDakr6ZlVIzMmxfAH69yBbpUT+7Sxx3S0L83uCZXKj2E+66ESCa+WUZEIKNDY6p0VWNfjgRRk=
Received: from SA1P222CA0170.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::26)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Sun, 29 Sep
 2024 10:49:16 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::4f) by SA1P222CA0170.outlook.office365.com
 (2603:10b6:806:3c3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Sun, 29 Sep 2024 10:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Sun, 29 Sep 2024 10:49:16 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 05:49:14 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/sdma4.4.2: implement ring reset callback for
 sdma4.4.2
Date: Sun, 29 Sep 2024 18:48:56 +0800
Message-ID: <20240929104856.46010-3-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240929104856.46010-1-jiadong.zhu@amd.com>
References: <20240929104856.46010-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c4e270-5eba-4a75-1885-08dce0745d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QKxFsYIjhamO6fXt1buoG8HyHbDiYTUozsCES0ZVcYMtiLqNqlEZ8XdFyJzY?=
 =?us-ascii?Q?XcruLZ4bxwtdcMdQXLS+tMbtLQZTs+8v0hidNhECmZ3Yw98BJlGxl9H2foCd?=
 =?us-ascii?Q?hohoeG+czaqMPB7Ye6E+yrECwCLx6aMDicb6mTOePLlsptS1C3k095sZucxx?=
 =?us-ascii?Q?63g97vhpNB93vtFCZDXNb4SseGp1Gx6TphWQp/z9F7gnNQdSHQdO/rbyD1oN?=
 =?us-ascii?Q?QqR9n2DlYvAlBBDfVEMjXQCal4kJFzXZWkyk2n5/QseIRTf5mh+CFpl8xslS?=
 =?us-ascii?Q?W2wtv9atvKVxHHLxLT76Z60su43IrPg4SIz/RHkTL9T/SLDRVU87BpHfLs16?=
 =?us-ascii?Q?I/3GsSzF1XZizaBvDkXucmyZn0NlEWVyVBftUsoGvQvUL5akvid65d4lc+Gk?=
 =?us-ascii?Q?zyUFKBP8mYTwaeR4yr4qV0AjcRdZ+W5mwTZXrmkA+f++LGXgGtvhLBIqiwSi?=
 =?us-ascii?Q?2Y1VG1HSMjgBl7dqQXNm1vvcYbBDrTs1/xDoVZjZ2wansB6nAWn+d3DIrO0y?=
 =?us-ascii?Q?hJNbXWZvRKCEZyrdcKUr/9ATZdBA2PkX+ybb8nwJWOfujhPrC/y/y7fxA9xc?=
 =?us-ascii?Q?aR0NP43jZ+o/64y1IiwVgZouYE1CkFmvqatymPRYMx3gqHdVFfWW6wCchWcl?=
 =?us-ascii?Q?BNQsif6p0VM+Pg9+vExdJ4gi9rnm4OncXFfChByN19GJopQLK8vXkYMOId9W?=
 =?us-ascii?Q?Kv3AEW51msBNnBhgTutb7tEL5KBnf5tJ4+AI9WiWJDvGiI8gNzt/DtkekQad?=
 =?us-ascii?Q?E2yzq+XMCyqmLHj5nicAkwCpmFZo1B7a+PwqkLUlawXqd19oRNsHsTpNws5t?=
 =?us-ascii?Q?WtGrR5MyYk6atRMs9gNbQ6CsAZPjib1LAqWFK9FtQiRe6cCgBm8Kfd8E/wNv?=
 =?us-ascii?Q?2b9vUyRXbyiiSE/LHISpUHcLsJ4QsYZr8GZj1qlyUqihZOnGX4FTMHdNWP5o?=
 =?us-ascii?Q?BDyV89hoNv6nzBEalpgJjdPu8CfXNL8vEEsBcYbZ/1xBC8ywrgoPWBt3KTmF?=
 =?us-ascii?Q?7dvwkrUX+QWzB3xu65Bokqy+3VdPASc1DtaY4AtQL+1OONxryLRg4R2tvMTb?=
 =?us-ascii?Q?tqdctT6cqRZ8kTpuGCCfxNDDjZXhLO4X0EA+SGAFb7cADO1P93wZHakgSCgr?=
 =?us-ascii?Q?+tcDN1SEigctNm6e0ZWeDGLRJ92ZKqj3i6mrRrph5VAdbPn3lHhlhCrTNR/L?=
 =?us-ascii?Q?8BKL3pGb+ing3tZhORHz/6xYyNUAnEwY3ElYOckrDlIjhyzrfiAJX/cBGpBb?=
 =?us-ascii?Q?Xg897XxhhLGUGsjola3/OZaCCSHsb6nmo4mh5OJKKXE53PMSNYHDOuMnhu5X?=
 =?us-ascii?Q?l7brDPewcPhYIwJr83JgqaKi0sBm5Xyj3u+ULFzRHtRsBZIKRsXt4gPffRSN?=
 =?us-ascii?Q?TPfqeK/moIoL2A/lCrtlY4mZaClf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 10:49:16.1256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c4e270-5eba-4a75-1885-08dce0745d14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Implement sdma queue reset callback via SMU interface.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 137 ++++++++++++++++++++---
 1 file changed, 123 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c77889040760..9485f1a1986c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -667,11 +667,12 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
  *
  * @adev: amdgpu_device pointer
  * @i: instance to resume
+ * @restore: used to restore wptr when restart
  *
  * Set up the gfx DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
+static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -698,16 +699,24 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
 	WREG32_SDMA(i, regSDMA_GFX_RB_BASE, ring->gpu_addr >> 8);
 	WREG32_SDMA(i, regSDMA_GFX_RB_BASE_HI, ring->gpu_addr >> 40);
 
-	ring->wptr = 0;
+	if (!restore)
+		ring->wptr = 0;
 
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
 
 	/* Initialize the ring buffer's read and write pointers */
-	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
-	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
-	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
-	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
+	if (restore) {
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+	} else {
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
+	}
 
 	doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
 	doorbell_offset = RREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET);
@@ -759,7 +768,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
  * Set up the page DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
+static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -775,10 +784,17 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
 	WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
 
 	/* Initialize the ring buffer's read and write pointers */
-	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
-	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
-	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
-	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
+	if (restore) {
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+	} else {
+		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
+		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
+		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
+		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
+	}
 
 	/* set the wb address whether it's enabled or not */
 	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_ADDR_HI,
@@ -792,7 +808,8 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
 	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE, ring->gpu_addr >> 8);
 	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE_HI, ring->gpu_addr >> 40);
 
-	ring->wptr = 0;
+	if (!restore)
+		ring->wptr = 0;
 
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SDMA(i, regSDMA_PAGE_MINOR_PTR_UPDATE, 1);
@@ -946,9 +963,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		uint32_t temp;
 
 		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
-		sdma_v4_4_2_gfx_resume(adev, i);
+		sdma_v4_4_2_gfx_resume(adev, i, false);
 		if (adev->sdma.has_page_queue)
-			sdma_v4_4_2_page_resume(adev, i);
+			sdma_v4_4_2_page_resume(adev, i, false);
 
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
@@ -1566,6 +1583,97 @@ static int sdma_v4_4_2_soft_reset(void *handle)
 	return 0;
 }
 
+static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int i, j, r;
+	u32 rb_cntl, ib_cntl, cntl, preempt;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (ring == &adev->sdma.instance[i].ring)
+			break;
+	}
+
+	if (i == adev->sdma.num_instances) {
+		DRM_ERROR("sdma instance not found\n");
+		return -EINVAL;
+	}
+
+	/* 2 instances on each xcc, inst0, 1 on xcc0 */
+	amdgpu_gfx_rlc_enter_safe_mode(adev, i >> 1);
+
+	/* stop queue */
+	ib_cntl = RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_ENABLE, 0);
+	WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
+
+	rb_cntl = RREG32_SDMA(i, regSDMA_GFX_RB_CNTL);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_GFX_RB_CNTL, RB_ENABLE, 0);
+	WREG32_SDMA(i, regSDMA_GFX_RB_CNTL, rb_cntl);
+
+	if (adev->sdma.has_page_queue) {
+		ib_cntl = RREG32_SDMA(i, regSDMA_PAGE_IB_CNTL);
+		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_PAGE_IB_CNTL, IB_ENABLE, 0);
+		WREG32_SDMA(i, regSDMA_PAGE_IB_CNTL, ib_cntl);
+
+		rb_cntl = RREG32_SDMA(i, regSDMA_PAGE_RB_CNTL);
+		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_PAGE_RB_CNTL, RB_ENABLE, 0);
+		WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
+	}
+
+	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0*/
+	preempt = RREG32_SDMA(i, regSDMA_GFX_PREEMPT);
+	preempt = REG_SET_FIELD(preempt, SDMA_GFX_PREEMPT, IB_PREEMPT, 0);
+	WREG32_SDMA(i, regSDMA_GFX_PREEMPT, preempt);
+
+	r = amdgpu_dpm_reset_sdma(adev, 1 << i);
+	if (r) {
+		DRM_ERROR("amdgpu_dpm_reset_sdma failed(%d).\n", r);
+		goto err0;
+	}
+
+	udelay(50);
+
+	for (j = 0; j < adev->usec_timeout; j++) {
+		if (!REG_GET_FIELD(RREG32_SDMA(i, regSDMA_F32_CNTL), SDMA_F32_CNTL, HALT))
+			break;
+		udelay(1);
+	}
+
+	if (j == adev->usec_timeout) {
+		DRM_ERROR("waiting for unhalt failed.\n");
+		r = -ETIMEDOUT;
+		goto err0;
+	}
+
+	/* queue start*/
+	cntl = RREG32_SDMA(i, regSDMA_CNTL);
+	cntl = REG_SET_FIELD(cntl, SDMA_CNTL, UTC_L1_ENABLE, 1);
+	WREG32_SDMA(i, regSDMA_CNTL, cntl);
+
+	sdma_v4_4_2_gfx_resume(adev, i, true);
+	r = amdgpu_ring_test_helper(ring);
+	if (r) {
+		DRM_ERROR("sdma gfx resume failed(%d).\n", r);
+		return r;
+	}
+	if (adev->sdma.has_page_queue) {
+		sdma_v4_4_2_page_resume(adev, i, true);
+		r = amdgpu_ring_test_helper(&adev->sdma.instance[i].page);
+		if (r)
+			DRM_ERROR("sdma page resume failed ret=%d.\n", r);
+	}
+
+err0:
+	/* 2 instances on each xcc */
+	amdgpu_gfx_rlc_exit_safe_mode(adev, i >> 1);
+	return r;
+}
+
+
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -1948,6 +2056,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = sdma_v4_4_2_reset_queue,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
-- 
2.25.1

