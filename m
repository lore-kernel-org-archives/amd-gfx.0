Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAA7CEDDA9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 01:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C69010E24D;
	Thu, 10 Oct 2024 01:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ASrVklCj";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6550510E217
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 01:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnZnf8wjagkz7zeyYGfjEPY+ZMG6i9zvjkRRkurBB/6KpfDOaGyPUqXH01uu43z7fULyG9P4038uikha5gSicqBOsq4geaPB2eGJQa+vM8/0aCZThfR05ShPgjgC0i3oT5kox2jv6+8vOhaaQJ4cxGx4sdrHDWUvWRsqwPFqsvppHVYkZrDevEsTgEGG21apmqP4ExVH1P2g4ZlxrHERqeiB80j8520MLlYqJFjFUEf65NLNoblioQ7gkhlYLYQGyAGNCmRegfA1VKgfEa5dTjvYkQ7+sVCVBRpRLKOMVZAlcVpSX3Y8P6Vcfiyw0QaqsgZp+eW+KX3U2Rn8qMG95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJuZayAxgO+dtqaEZGo+X/7notYYjrFgJ267UKOWfXg=;
 b=F3Ck+BzcFyC+56hIM8D56IijHIo378PMTVf37TpT23p3g60t0gRuG9Xn4vNFWgqxppyROna+7Uu51J1c4NFkPMJ33KmaDunPNMI1zkj7Xttoypx3c6eBptxJdTw7hovm8lyTfIp+ROJQesoW4uvTyQ45fpNBwq00vkLji4id74zmfP5pIr/6EId2qENJKlBXF/TchStTKdhoxLt6Ftzv3q9eqdYERTu37liMJr8wWzw5EpxwNSLMAAjGpMwBMzAg5Eq/GAa6caaPYgzvHy0fQVS2vcQ+AynlOVORVbdqErWPjabOdZGQoAXRQTTQ2I3ewFoEhi6z5tj/bi5FYaYeRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJuZayAxgO+dtqaEZGo+X/7notYYjrFgJ267UKOWfXg=;
 b=ASrVklCjKvClv5qb7MYKI9kF9s6qoXmC1muvPRzNftEDwTFWpLKFRQI+FlJBJNQE2cLANJ5L7IqE59/pl3rFMCWIJpCXNf5wrbMKryRyG/vdaHKcZSfETblvLU4h0EKMoSjoHieBIdHR2bZ9r2xtGsxz9xAt9empA8W/HIXT4jY=
Received: from SJ0PR05CA0174.namprd05.prod.outlook.com (2603:10b6:a03:339::29)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 01:30:59 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::28) by SJ0PR05CA0174.outlook.office365.com
 (2603:10b6:a03:339::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Thu, 10 Oct 2024 01:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 01:30:58 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 20:30:56 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <lijo.lazar@amd.com>, Jiadong Zhu
 <Jiadong.Zhu@amd.com>
Subject: [PATCH v4 3/3] drm/amdgpu/sdma4.4.2: implement ring reset callback
 for sdma4.4.2
Date: Thu, 10 Oct 2024 09:29:32 +0800
Message-ID: <20241010012931.548798-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 714f7e3f-3524-48fc-0280-08dce8cb3185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sNxwHQzUsHLlg6JuFjRIct/HZ+8kAUWFjBHKS3CQBtcpLcOE1CiQHeoV9pHg?=
 =?us-ascii?Q?hP8QJrNCZp0wsUOMdXo6LjkDbE8J63aUv+t0QDtawVW6+/qqzTqBlUQgSnaT?=
 =?us-ascii?Q?ALF94ulDU/O4gbXoyb1SIo54enhp1XbUq71xvwFYo67szAMiw2i3TsmnN33d?=
 =?us-ascii?Q?IH6Foncp/1D1pilonrhcsldZpgPXLblIZDaqczpMyE8oAm/pueIvwnDfbgo6?=
 =?us-ascii?Q?kYD4R9F98LWAM+EFHhXIK9GKylELXzRpdQnaBHGiI5S8+3LSZnLIXvs2nWuM?=
 =?us-ascii?Q?pZfBZ+Hxo1YPhbxBWlu1MX7Tqs06mUtcgufVjPrILF5NwbbtNB7IhECghiJV?=
 =?us-ascii?Q?NCZbGJsRMz3q1BZrxzUm0LVkdx9N7xx6RLP77t8wDAsf34DP1J8TV1LWlxV5?=
 =?us-ascii?Q?WpwO6vE3W0IELRCSacXKQJFf6LiNoA4UILhUT5S+YgQmRQHRDNVUjvUSxNAT?=
 =?us-ascii?Q?pOp0zqbpxUovJl+9bxxskMRrPFVDcQkEI595ZnnkeGUaGDVG3GJPk42nfHbX?=
 =?us-ascii?Q?UsRwMa4HfrBY5ijT5z/ux6YgpHHfOA1UNvs4bAEvCmzzuJG+nx378Lc9Jz3f?=
 =?us-ascii?Q?HOOJa9OfFf8v6BK2gd+TIuFfmeJNAthnvjCiJr4VTy20MnKwyrjdDrvPucKi?=
 =?us-ascii?Q?dz61L4Fr5gcytkyRdKR0iJ9MZBUccA8oI+uNccAj+nhLg2bKZYkiepdfkGRn?=
 =?us-ascii?Q?wTYVicHtNdPFeOaY7ol6S1I+ZRcoOt0ww0yvcuZqFmB+nGdzX/WlwmgVXms4?=
 =?us-ascii?Q?cCnuBOOL6xaoL4bjjQGPVDatidWYBvxXQf+OqEqN+Zs2PfK9KO3MFm48TW5Q?=
 =?us-ascii?Q?qf1CehUHJUgo8Q8FwqFD7qZIIVrrC/B5R9NevYQkQZh4G7t22Gd258I97KoT?=
 =?us-ascii?Q?ZCEUE79KZiiA8Ko6R3mkfoA02onhIyYwdak0XIc47BBjB/+wJ8/SGE5ORYp/?=
 =?us-ascii?Q?8RSlOwwggzGf+RBURKpHxf7zJdwNcMoyp3C57hWhMQVWu8Uw2Zn2+Pp6aHgG?=
 =?us-ascii?Q?xeUT3/o01jzviFjeKWYtO3QdTzz/4lujlbgTJh76+ixxEVmjaeL0fXj5I6I2?=
 =?us-ascii?Q?gq4TKkr4qqB2GUrRFZOXhP0KS03RSlBX6jOiPd/Qf0CNSplXb27FWfrGvfV/?=
 =?us-ascii?Q?cRvQ2I0LDDLpltyt+cE9f9jfvX2KT4qLqyb4yvc3fLcC9JCpMfc9aPlU8Vx5?=
 =?us-ascii?Q?4OKgeaDa4rinVijDetHpZ57kbkeDv0svu57b/XBxgF5w8aS4WmZC0+t1WW6O?=
 =?us-ascii?Q?ue1k5TdQ+hVgSz1uPf37C0sj88WKAHF7QWaToo9kPlHCZP4GY1o0/xuD0fEA?=
 =?us-ascii?Q?AAr7bIGW7Dp4mhQHpzUKj1DsZxq+1uFdBEImzNnKKQ6Ao3h3PjbRjVyRbCWl?=
 =?us-ascii?Q?v/XY1W97skOgZUEIsczqmczQXNKs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 01:30:58.4698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 714f7e3f-3524-48fc-0280-08dce8cb3185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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

v2: Leverage inst_stop/start functions in reset sequence.
    Use GET_INST for physical SDMA instance.
    Disable apu for sdma reset.
v3: Rephrase error prints.
v4: Remove redundant prints.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 95 +++++++++++++++++++-----
 1 file changed, 77 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c77889040760..92c643299ac4 100644
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
@@ -916,7 +933,7 @@ static int sdma_v4_4_2_inst_load_microcode(struct amdgpu_device *adev,
  * Returns 0 for success, error for failure.
  */
 static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
-				  uint32_t inst_mask)
+				  uint32_t inst_mask, bool restore)
 {
 	struct amdgpu_ring *ring;
 	uint32_t tmp_mask;
@@ -927,7 +944,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		sdma_v4_4_2_inst_enable(adev, false, inst_mask);
 	} else {
 		/* bypass sdma microcode loading on Gopher */
-		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP &&
+		if (!restore && adev->firmware.load_type != AMDGPU_FW_LOAD_PSP &&
 		    adev->sdma.instance[0].fw) {
 			r = sdma_v4_4_2_inst_load_microcode(adev, inst_mask);
 			if (r)
@@ -946,9 +963,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		uint32_t temp;
 
 		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
-		sdma_v4_4_2_gfx_resume(adev, i);
+		sdma_v4_4_2_gfx_resume(adev, i, restore);
 		if (adev->sdma.has_page_queue)
-			sdma_v4_4_2_page_resume(adev, i);
+			sdma_v4_4_2_page_resume(adev, i, restore);
 
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
@@ -1477,7 +1494,7 @@ static int sdma_v4_4_2_hw_init(void *handle)
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
 
-	r = sdma_v4_4_2_inst_start(adev, inst_mask);
+	r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
 
 	return r;
 }
@@ -1566,6 +1583,47 @@ static int sdma_v4_4_2_soft_reset(void *handle)
 	return 0;
 }
 
+static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int i, r;
+	u32 preempt, inst_mask;
+
+	if ((adev->flags & AMD_IS_APU) || amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	/* stop queue */
+	inst_mask = 1 << ring->me;
+	sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
+	if (adev->sdma.has_page_queue)
+		sdma_v4_4_2_inst_page_stop(adev, inst_mask);
+
+	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0*/
+	preempt = RREG32_SDMA(ring->me, regSDMA_GFX_PREEMPT);
+	preempt = REG_SET_FIELD(preempt, SDMA_GFX_PREEMPT, IB_PREEMPT, 0);
+	WREG32_SDMA(ring->me, regSDMA_GFX_PREEMPT, preempt);
+
+	r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, ring->me));
+	if (r)
+		return r;
+
+	udelay(50);
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!REG_GET_FIELD(RREG32_SDMA(ring->me, regSDMA_F32_CNTL), SDMA_F32_CNTL, HALT))
+			break;
+		udelay(1);
+	}
+
+	if (i == adev->usec_timeout) {
+		dev_err(adev->dev, "timed out waiting for SDMA%d unhalt after reset\n",
+			ring->me);
+		return -ETIMEDOUT;
+	}
+
+	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
+}
+
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -1948,6 +2006,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = sdma_v4_4_2_reset_queue,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2160,7 +2219,7 @@ static int sdma_v4_4_2_xcp_resume(void *handle, uint32_t inst_mask)
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
 
-	r = sdma_v4_4_2_inst_start(adev, inst_mask);
+	r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
 
 	return r;
 }
-- 
2.25.1

