Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD41D3C52A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D90810E689;
	Wed, 10 Dec 2025 07:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QnjYCd1D";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FAE10E681
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgV4/EEk/+djytpGSeDhy0VxyBO1+zVEyqJM+TMGoKEE95giOnKiWa+IUlQTicPklU23HHbrSBrTfSPCq4NGMGv1IUUPXgnxYYPZovXrVqamLteu16PgzTyU0khew5GQyA+TO8Fpj/+NzBgC+zjOGx0mLC+S4oJI9XTvckbbMo60ClIfR1BpBYYASwd9Igd6kgzcbMc8a9MfX9fi2wJ02PTNW3hYX/wD5FsM2bzlShrBlzgtQkBNbbOVB9sWm/3MNs1Au3E1KUTEYAYbFo8FA+JNOY19NCIoJCsDEWmv0kcjU0U5ZBfo3JHw/iDtdb8AY1UP6KdavHNPyJJ3QvCnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yxd1S+FD9VI0NrOwHgW2h9xs31PpLu8Lqlx2Ffu39mg=;
 b=LIAQ8lPhrkd9uqmKy6y8hkt5obd66RpWhNEv92Eu5U8+7dNQa1yg1MqYwETGWLqvSLOiNQjuCBsMDo4b97bm51pTnTSFJK5T16F8hRUXA5N81TK8EGnbeeHs0QEPds5JKtwS4KYrlvpIUGL13sAzngrU0HayYLI/UULZX/uHk6Kz77hE/mUcsi1o4828jN+4jbCJmsXgx3oKM8DUFIfh8CmhLAA7O848zjzVGhcAGPdaGW4WmZXA5gL5lyJppF8TfsIGINBZ4SnV+7S0gU3iqfiO3X2YeAbw4clIWa74ZLWnymC4j8hsj3hmoiBkDvDM7yqyNIFhUhbQpwqManUEnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yxd1S+FD9VI0NrOwHgW2h9xs31PpLu8Lqlx2Ffu39mg=;
 b=QnjYCd1D9W0u5mur4XsGyK4oZyrY1gJxm+rSdtvfkhUGuU81zJqCQSREb0TqY+XBgfF22fyBpKpIBZyA1b8Gw5oyGDnAc5Mw4rHtlMU5sTplCzJf6RTt7kG8iwKsn/LMcYhphanUHVarGgouFwasFu9oR/rbBoW9oToeDEizFVo=
Received: from SA9PR13CA0040.namprd13.prod.outlook.com (2603:10b6:806:22::15)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 07:14:36 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::e7) by SA9PR13CA0040.outlook.office365.com
 (2603:10b6:806:22::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 07:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:36 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:33 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Correct inst_id input from physical to logic
Date: Wed, 10 Dec 2025 02:14:07 -0500
Message-ID: <20251210071415.19983-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 91cd02b0-0043-4e77-85d9-08de37bbc6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xo7I0VlCuF6NxWY57SSK+QRAX11GMQ+HFR2mYlvVNAFrTjIaf3Kpj6WR/2eM?=
 =?us-ascii?Q?4yfucd6dKTfxFoMGjjGGiZsNO2UH08e9bhyfCJqmEXsu4qO1nd8hARC89azv?=
 =?us-ascii?Q?30lYukUkCb9EQVuqd+vwIYMJpQc3/bAozD6Ao+gOmLpJ+fGuGIIbPG8YRkVj?=
 =?us-ascii?Q?Acj38+kVp4t3KeB7ciQD7B88192TgWPtzBjKhBNqNsAC7B1ZS5KlfCvI9JqV?=
 =?us-ascii?Q?TAZ7gxPCGtymD5TIo4jIU5nyRg6Aub66fzj1uggoqLPI9UaOB8KEAglZ9l31?=
 =?us-ascii?Q?GT6kZLirfw6raOcAZZe50/YDC0a6hCKX6hNVcac1Dg9tb5/hdCXFzRSoDUw3?=
 =?us-ascii?Q?zlSh3W/z6VGOqPzSqWdY6Exh3whye1M3FwuHfUH8JFJQiQRuFYX2YSew1DfS?=
 =?us-ascii?Q?rMApqxMzKUD2NsJOmvK/jSKE9ydS3i336K+9r+rDVY2eF+O7BZ+GOp8vF0cC?=
 =?us-ascii?Q?MgEXi41L18C3MUzf8pgmO/P5RIsFYMsvvDb3WQOuQYMguoRxSiyXuKEJMlPE?=
 =?us-ascii?Q?G/6FlH1Uoa6/j/dnbzR0AiDsILg2FbRwARCnzsLQf0kRoOs6/bWJ47p55Xz4?=
 =?us-ascii?Q?8rQAqVW73KgwHT5SrYGHYILbKEdE7btBU7jVK1uFSYk5MRYRvKiTiDeoeMzh?=
 =?us-ascii?Q?4C2bSr1pURMDRZUOrQulhS+aUyW++gVjCz6SyYGPuNc2PTQhsGgHsbeiZmf2?=
 =?us-ascii?Q?zft1LyMiBAgeHwUJ6WjXgG1/C7vq7B+LFecZzs+S35N6yHYy3UYWIjcuzsC7?=
 =?us-ascii?Q?ykiDfDk21fMP228xGVCNghiNCnSkQxdCFAKHKRn/0SLkTaZvKtOpq/kNvmAq?=
 =?us-ascii?Q?A42tjzNhsiiv3muB9sVHXQstVIXWn2njci8p69RD2XpVbVD8ESqEFOzXi7X1?=
 =?us-ascii?Q?k38m8Vam7uctY7nwk450mjA8gfTJehEJALhCVLM8yESPI/mL1C7LDUWEyt2Y?=
 =?us-ascii?Q?2CzEmmLXMiBFEvIv3GY74Lf5goqqIovW8DiyTv7Jf65aAnrIlrSHRf/BdTiw?=
 =?us-ascii?Q?Lq8mTb92jd8AI+7pm8jJ5fmWfreUKFzYMN94zZIrw3oi9mSBFeZcdDR1Mjq2?=
 =?us-ascii?Q?mHhgih2cxCwZ3WUME6uu3ezY65VenNqIbOeKlUeEPo19I78YyuRNpGWM260m?=
 =?us-ascii?Q?ZueHavMwSzYtmgJCTyHqg5M+oOVoqqv2oXcjw339xpAbVgUtUSuHed/4gtHz?=
 =?us-ascii?Q?I47aR8KZmfs84UCJwQs+0+rAjP+kHhrCd/aWHBQkO8k5sYsKVobFHYCge/vW?=
 =?us-ascii?Q?234H/312ZjfptCmWMYVPXjeo/G/d6A3J43juv7FfjP5GuUHbVmfeqEPKrJbg?=
 =?us-ascii?Q?3EHzBRSvRhNFxQZ5seEoX3A2ZxOQ+iscjwxfW3xxzLJVMgRU8eCoXGfleYn+?=
 =?us-ascii?Q?E48qJIT2UFkTnalFJPh80KphJD+MgDYDixBaK6QTG2Lr71diZVIshFTm1m4h?=
 =?us-ascii?Q?19lMNaD8UHkdcoraSla+DWC3Nj7ZSe26HbQ29XLkx3newSZox8rcKSUqv61p?=
 =?us-ascii?Q?9fts3X4zfemEJUO2upfcwMiFLTrbf4+K6IK32so21OL1ITc5yiT8gW9MuMYT?=
 =?us-ascii?Q?iYtyaYnZFFoex6COxRo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:36.8086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cd02b0-0043-4e77-85d9-08de37bbc6e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371
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

From: Likun Gao <Likun.Gao@amd.com>

Correct inst_id input from physical to logic for sdma v7_1.
V2: Show real instance number on logic xcc.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 50 +++++++++++++-------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 446b7527f5c62..e3963675bfac0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -369,7 +369,7 @@ static void sdma_v7_1_inst_gfx_stop(struct amdgpu_device *adev,
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	for_each_inst(i, inst_mask) {
+	for (i = 0; i < NUM_XCC(inst_mask); i++) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_ENABLE, 0);
 		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_CNTL), rb_cntl);
@@ -436,7 +436,7 @@ static void sdma_v7_1_inst_enable(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	for_each_inst(i, inst_mask) {
+	for (i = 0; i < NUM_XCC(inst_mask); i++) {
 		mcu_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_MCU_CNTL));
 		mcu_cntl = REG_SET_FIELD(mcu_cntl, SDMA0_SDMA_MCU_CNTL, HALT, enable ? 0 : 1);
 		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_MCU_CNTL), mcu_cntl);
@@ -617,7 +617,7 @@ static int sdma_v7_1_inst_gfx_resume(struct amdgpu_device *adev,
 {
 	int i, r;
 
-	for_each_inst(i, inst_mask) {
+	for (i = 0; i < NUM_XCC(inst_mask); i++) {
 		r = sdma_v7_1_gfx_resume_instance(adev, i, false);
 		if (r)
 			return r;
@@ -647,7 +647,7 @@ static void sdma_v7_1_inst_free_ucode_buffer(struct amdgpu_device *adev,
 {
 	int i;
 
-	for_each_inst(i, inst_mask) {
+	for (i = 0; i < NUM_XCC(inst_mask); i++) {
 		amdgpu_bo_free_kernel(&adev->sdma.instance[i].sdma_fw_obj,
 				      &adev->sdma.instance[i].sdma_fw_gpu_addr,
 				      (void **)&adev->sdma.instance[i].sdma_fw_ptr);
@@ -686,7 +686,7 @@ static int sdma_v7_1_inst_load_microcode(struct amdgpu_device *adev,
 			le32_to_cpu(hdr->ucode_offset_bytes));
 	fw_size = le32_to_cpu(hdr->ucode_size_bytes);
 
-	for_each_inst(i, inst_mask) {
+	for (i = 0; i < NUM_XCC(inst_mask); i++) {
 		r = amdgpu_bo_create_reserved(adev, fw_size,
 					      PAGE_SIZE,
 					      AMDGPU_GEM_DOMAIN_VRAM,
@@ -744,10 +744,10 @@ static int sdma_v7_1_soft_reset(struct amdgpu_ip_block *ip_block)
 	u32 tmp;
 	int i;
 
-	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
+	inst_mask = adev->sdma.sdma_mask;
 	sdma_v7_1_inst_gfx_stop(adev, inst_mask);
 
-	for_each_inst(i, inst_mask) {
+	for (i = 0; i < NUM_XCC(inst_mask); i++) {
 		//tmp = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_FREEZE));
 		//tmp |= SDMA0_SDMA_FREEZE__FREEZE_MASK;
 		//WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_FREEZE), tmp);
@@ -1288,10 +1288,14 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
-		xcc_id = adev->sdma.instance[i].xcc_id;
+
+		for (xcc_id = 0; xcc_id < fls(adev->gfx.xcc_mask); xcc_id++) {
+			if (adev->sdma.instance[i].xcc_id == GET_INST(GC, xcc_id))
+				break;
+		}
 
 		DRM_DEBUG("SDMA%d.%d use_doorbell being set to: [%s]\n",
-				xcc_id, i % adev->sdma.num_inst_per_xcc,
+				xcc_id, GET_INST(SDMA0, i) % adev->sdma.num_inst_per_xcc,
 				ring->use_doorbell?"true":"false");
 
 		ring->doorbell_index =
@@ -1299,7 +1303,7 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring->vm_hub = AMDGPU_GFXHUB(xcc_id);
 		sprintf(ring->name, "sdma%d.%d", xcc_id,
-				i % adev->sdma.num_inst_per_xcc);
+				GET_INST(SDMA0, i) % adev->sdma.num_inst_per_xcc);
 		r = amdgpu_ring_init(adev, ring, 1024,
 				     &adev->sdma.trap_irq,
 				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
@@ -1334,11 +1338,8 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block *ip_block)
 static int sdma_v7_1_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	uint32_t inst_mask;
 	int i;
 
-	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
-
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
@@ -1346,7 +1347,7 @@ static int sdma_v7_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
-		sdma_v7_1_inst_free_ucode_buffer(adev, inst_mask);
+		sdma_v7_1_inst_free_ucode_buffer(adev, adev->sdma.sdma_mask);
 
 	kfree(adev->sdma.ip_dump);
 
@@ -1356,24 +1357,19 @@ static int sdma_v7_1_sw_fini(struct amdgpu_ip_block *ip_block)
 static int sdma_v7_1_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	uint32_t inst_mask;
-
-	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 
-	return sdma_v7_1_inst_start(adev, inst_mask);
+	return sdma_v7_1_inst_start(adev, adev->sdma.sdma_mask);
 }
 
 static int sdma_v7_1_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	uint32_t inst_mask;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
-	sdma_v7_1_inst_ctx_switch_enable(adev, false, inst_mask);
-	sdma_v7_1_inst_enable(adev, false, inst_mask);
+	sdma_v7_1_inst_ctx_switch_enable(adev, false, adev->sdma.sdma_mask);
+	sdma_v7_1_inst_enable(adev, false, adev->sdma.sdma_mask);
 
 	return 0;
 }
@@ -1493,7 +1489,7 @@ static int sdma_v7_1_process_trap_irq(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
-	int instances, queue, xcc_id = 0;
+	int inst, instances, queue, xcc_id = 0;
 	uint32_t mes_queue_id = entry->src_data[0];
 
 	DRM_DEBUG("IH: SDMA trap\n");
@@ -1518,8 +1514,12 @@ static int sdma_v7_1_process_trap_irq(struct amdgpu_device *adev,
 		xcc_id = adev->gfx.funcs->ih_node_to_logical_xcc(adev, entry->node_id);
 	else
 		dev_warn(adev->dev, "IH: SDMA may get wrong xcc id as gfx function not available\n");
-	instances = ((entry->ring_id & 0xf0) >> 4) +
-		xcc_id * adev->sdma.num_inst_per_xcc;
+	inst = ((entry->ring_id & 0xf0) >> 4) +
+		GET_INST(GC, xcc_id) * adev->sdma.num_inst_per_xcc;
+	for (instances = 0; instances < adev->sdma.num_instances; instances++) {
+		if (inst == GET_INST(SDMA0, instances))
+			break;
+	}
 	if (instances > adev->sdma.num_instances - 1) {
 		DRM_ERROR("IH: wrong ring_ID detected, as wrong sdma instance\n");
 		return -EINVAL;
-- 
2.52.0

