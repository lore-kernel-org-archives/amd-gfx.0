Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12195C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 08:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977BE10E5E6;
	Tue, 16 Jul 2024 08:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Q0Naw4b";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E28D10E5E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 08:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAeh9xAao6poGnfnEPeOSOHna6UAmsyh4JCtrxP+CtzWjGMoKe6wDyA3Vie4v9XRUqy/bhvzM3NL0FOvkZs5opy6/6aJfLVs9H7e8gtLpBzGw7q5r3Rf+dMoMmb8Zru7ALtv1DoNuVl7hcOETNAE4qFStsr8FUuv3teyKEm9RdhaSyJGGiRAkx8WDbZFryMX16iJLxDQK2YtJ7Sqgnyp5hB/RIBiaGgtp1aGXHEbSu95/jn0NfZQQhVV2VuUXPUB9/clqYXG9dxHwJQuVIydef5hQJsc0DUZQn7bA2XpqUuNddkCYeMuYHdtwAYAbzWyNEfFmHkWyk0Lzw9/rF0ivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgGMOjn7Uj5BwQRQLppDeIfDZmakPDoy5EaCY4HBTRM=;
 b=sqvz0jH0T1zFgPeUA3Q7ark1g2SKvMdVtDHBEDqVC5FP/ZlVv0ec0BVjx+1+CifnzISqrCGmbPWjTqmMYA74e4NScSDfSHBxl+wR348hbr/CSgJh8hWTGk8jj9/vnOBMrvq6oXYhvktAS9dTGAzeu5RMWvodn/A9TuxDyTPZRs0DdhXlTQQuGRP92uULebKCfz+ChdKCV0kIn/riVYtBd7IjZXEpas5ExT8KPukl1bncX3oZeycVfDkb12sR6G2uN2bRA6KVDMYb5uvLrXXwNHBqwJPxDKjhzlZna+5C9mRTBUniyMODkqCtEjoFU8VK8OLQAxNAmDT26LZGifPgHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgGMOjn7Uj5BwQRQLppDeIfDZmakPDoy5EaCY4HBTRM=;
 b=3Q0Naw4bVhxskJBNTrhvCibAETkyiUI8C8De+oieej7ydWiIhOFASubZrSDgF1Q19zpXtZerL59agsW0N53dxYThgnpH+IIYDqzJ0Xt9ArPj5N28MMXlIWtMJvIWRowcxUMzTJ34seGoKqEWmsRV0IZOw3SJDdEaSzUX8ZzTUW0=
Received: from MN2PR15CA0055.namprd15.prod.outlook.com (2603:10b6:208:237::24)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 08:47:14 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::1) by MN2PR15CA0055.outlook.office365.com
 (2603:10b6:208:237::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Tue, 16 Jul 2024 08:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 08:47:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 03:47:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 03:47:10 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Jul 2024 03:47:09 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Haijun.Chang@amd.com>, <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/vcn: Use offsets local to VCN/JPEG in VF
Date: Tue, 16 Jul 2024 16:47:03 +0800
Message-ID: <20240716084703.196194-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6653ad-0c6b-419c-1d6e-08dca573e43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Dn12hRj/skOEnLSKYRhNdlsgbddG5DsSJ+066ITQG3IF81cgDGxDBldYyC1?=
 =?us-ascii?Q?a2WOlKCqQocGPClUfLLZSX8CLpeQyDZHFchbD0wNi2F1t85NauwRX+bhDWzS?=
 =?us-ascii?Q?E9XTKdGAq/RqODbPI+j7LePNeiyt1iCW3FGNe7aAQZW3C2XMynJ1pHJTexC5?=
 =?us-ascii?Q?XNsqFeVmSFHNeA4eO+l9wetPv1t+ga23EJI30Cc3L/g/MvzJCPOWKS3x7/u9?=
 =?us-ascii?Q?gtvckIeffiW6BFfn91Txm/kByGS9fpcavnkwg/hmgtyXc787WbGTNvx9JMkQ?=
 =?us-ascii?Q?1g97xgZaGXzKKUW+8wY5ZhBqLKZpYsNoIDzdwbvfNGWHLYyKQBol02KK9/Tg?=
 =?us-ascii?Q?1hF5S5JFcIokIUUrML0sWQZaQK9mw8VDi15NlygPYssvp1lQgAm8Mt2CfTA7?=
 =?us-ascii?Q?pJKXmC0RqFNxW2e+vZgm9q9yg21YUKZFpw9SeX7ulCk+wqWD/OoekaiUnqIW?=
 =?us-ascii?Q?4oxCXWtNc35xytB7L1YZYVWdhuseIpObe4KIj/vmtQUS2FyPUwkS2HR85LQt?=
 =?us-ascii?Q?SUF55FY5D9lvNXRVK3furjQZp92ByBBGG03172s2UkEaSLyRvdiSFReceJ+Q?=
 =?us-ascii?Q?oWTTzzjUiHKzUFjx8I99NjCI8WMyHmTLAaMV30nnwRpcLc/boj7/lJeLF35o?=
 =?us-ascii?Q?z19AnA+aqf0kirI4cJ+3AgRRACeyQfXutwrou7XAGjgd9fta6xkVjLG2opDD?=
 =?us-ascii?Q?pZgS1NDCK+zn3L4CYUEw6X/2aaJ9TWkIHMDf1vLuLj7IAyC8uadnkHE7VRji?=
 =?us-ascii?Q?VuAZPClCtYdxgDhs7Kz+E10ayNY4rnIme7ghHp2n1cUFUOWb2lUFsyN2yRgg?=
 =?us-ascii?Q?3GFmmgTszzK+nKZf0YqHGVZL1ISbUKNtzX4m3vZepNY1pbnZSww1XOs7qNfI?=
 =?us-ascii?Q?EtF4gOfqaqqzZ6R2sHm6CrQlREyXT59JEudl667oqsKllsre3K1g65PwIjF5?=
 =?us-ascii?Q?Cysj6P4Zl2XResxUFqhTIXp/F05GMcK6vHblFxb5d30Ft9E1URS5fofXT2rZ?=
 =?us-ascii?Q?AB+JRS99B6e0Cl/IIxfHiamLV91zTXrQi4NT3KJs+DfX/sbn3/DZzxp4WE8Q?=
 =?us-ascii?Q?esOjPapOorbPCrsAF6/7nv37gC8kVxWzdeLdvCRk5NuZK/CbUBMJAdpwrjga?=
 =?us-ascii?Q?RA35lJLE9XfAblYaUWgMHDz9HVsX12UUOePFXQnmAqSryMD1VobONqcn8DXT?=
 =?us-ascii?Q?QnMgEmHS5TpMpETmqiSkEScXDC4t9MLSjk9ylnW8uq86g94CC7DBEvqxpBAw?=
 =?us-ascii?Q?ZMUTwEFT9Ud73X+7g+F05a/VkEnZIlb70uOdIx4nJC0z2DGJwrO0x/sDkei9?=
 =?us-ascii?Q?g1G5mkg0eko+LkmWsfJhf1TbNhIncpBDku6+0KGSLz8ESnmbkNumYeC0gIA+?=
 =?us-ascii?Q?kJCCBj9O+r9y9g6yjs/C74IE61G/VFAXCjKOcPji9TqZF0OAJ07CMN/TyeBN?=
 =?us-ascii?Q?t8zigPXbsLlTG1Vuv9QAaKUtFoTNORZm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:47:14.8084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6653ad-0c6b-419c-1d6e-08dca573e43e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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

For VCN/JPEG 4.0.3, use only the local addressing scheme.

- Mask bit higher than AID0 range

v2
remain the case for mmhub use master XCC

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 19 ++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 46 ++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 30a143ab592d..ad524ddc9760 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -32,6 +32,9 @@
 #include "vcn/vcn_4_0_3_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
 
+#define NORMALIZE_JPEG_REG_OFFSET(offset) \
+		(offset & 0x1FFFF)
+
 enum jpeg_engin_status {
 	UVD_PGFSM_STATUS__UVDJ_PWR_ON  = 0,
 	UVD_PGFSM_STATUS__UVDJ_PWR_OFF = 2,
@@ -824,7 +827,13 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
 void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 				uint32_t val, uint32_t mask)
 {
-	uint32_t reg_offset = (reg << 2);
+	uint32_t reg_offset;
+
+	/* For VF, only local offsets should be used */
+	if (amdgpu_sriov_vf(ring->adev))
+		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
+
+	reg_offset = (reg << 2);
 
 	amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
@@ -865,7 +874,13 @@ void jpeg_v4_0_3_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 
 void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
 {
-	uint32_t reg_offset = (reg << 2);
+	uint32_t reg_offset;
+
+	/* For VF, only local offsets should be used */
+	if (amdgpu_sriov_vf(ring->adev))
+		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
+
+	reg_offset = (reg << 2);
 
 	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 101b120f6fbd..9bae95538b62 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -45,6 +45,9 @@
 #define VCN_VID_SOC_ADDRESS_2_0		0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0	0x48300
 
+#define NORMALIZE_VCN_REG_OFFSET(offset) \
+		(offset & 0x1FFFF)
+
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
@@ -1375,6 +1378,43 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
 				    regUVD_RB_WPTR);
 }
 
+static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+				uint32_t val, uint32_t mask)
+{
+	/* For VF, only local offsets should be used */
+	if (amdgpu_sriov_vf(ring->adev))
+		reg = NORMALIZE_VCN_REG_OFFSET(reg);
+
+	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WAIT);
+	amdgpu_ring_write(ring, reg << 2);
+	amdgpu_ring_write(ring, mask);
+	amdgpu_ring_write(ring, val);
+}
+
+static void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
+{
+	/* For VF, only local offsets should be used */
+	if (amdgpu_sriov_vf(ring->adev))
+		reg = NORMALIZE_VCN_REG_OFFSET(reg);
+
+	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WRITE);
+	amdgpu_ring_write(ring,	reg << 2);
+	amdgpu_ring_write(ring, val);
+}
+
+static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
+				unsigned int vmid, uint64_t pd_addr)
+{
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
+
+	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+
+	/* wait for reg writes */
+	vcn_v4_0_3_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
+					vmid * hub->ctx_addr_distance,
+					lower_32_bits(pd_addr), 0xffffffff);
+}
+
 static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
@@ -1421,7 +1461,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
 	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
 	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
 	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
-	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
+	.emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
 	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
 	.test_ring = amdgpu_vcn_enc_ring_test_ring,
 	.test_ib = amdgpu_vcn_unified_ring_test_ib,
@@ -1430,8 +1470,8 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_vcn_ring_begin_use,
 	.end_use = amdgpu_vcn_ring_end_use,
-	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
-	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
+	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
+	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-- 
2.34.1

