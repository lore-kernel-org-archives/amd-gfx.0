Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4DFC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9462361164
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9462361164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 411786EA6C;
	Thu,  8 Apr 2021 10:22:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE456EA70
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 10:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gvt9wSVl/AWbGnMbjG9iyQ5FRpFFwtk1I5F1Wza/zCQjMhwT/TM9s3eSi6Bf8gcF83VSTdO9M86jHPlkTv3774x3SM8Wc+HduGZsD0y9ahCs2IhXBGBxiVgphiJhz8p53KV2akJ2wGZFVM1KBNI7gTk6X7Zf6N1zx6vdaicQ4JEpNaLh3DBQBk0jkwrPm2DWvwCP335wsbUOJRdEkAXIPSCM/CpMpX1wr2Ny8ApC0bEn2tWJ9zyGD2XR1qPQxcrt4NoM+LjYjM+mjK6qaFf+pqC37HPwq8zVNymThYgFRbtBRWhPGlGDCfqmrznJ6USsHwYO0EoYN6siKuSmNUMiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAUafYIBpM3ocyE0hDo0pUINH+ktw8RKSr9iv1BeSGI=;
 b=TM1TEQML7tS1cxdqABsJD4Eh1IDKU08mGrAqJrWuPogqyfPT8cCzmSPk1mGPgQo0NvWXRER9jyUwo3aj7/dRvq4d3hMGESLD+aADow//izgK1PC4dHRLnGZ22Ohgu+MaGnnWjRUXPjBHogOb+kvcle+nHDyJs4osP5olv7QB7UkucHiEANSvneZqeaN0lLtNb+bhkM2iNSoqLBkrTo4dXw7xrvGPk+WyoOJUPP3TMP1nhhXEBe6fazKD5doIe0gO48Ug915MSWEJ1led3tKuilCTauP+/wMO/zSHDq3Ds6ejswPTl90k088AmtrDXa2oG2qzHAPGVXBYqX2N/XNPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAUafYIBpM3ocyE0hDo0pUINH+ktw8RKSr9iv1BeSGI=;
 b=eiBs00L8lyVxyOwzazmbDB3AJJoE6tcE/ObVWjJRGrHfHKWRLqxKUmdgMuWWvmYlRnjOvkBCMoNqDOCjlPVk7y7aF4vZ2mHLXA51+nvFFqW69el3ifNLXRKBUm5YcEEoMMBa5abMD02GEbDzkVdlWo6/NTxNk2TWnm2Ojdd9vKY=
Received: from MWHPR22CA0016.namprd22.prod.outlook.com (2603:10b6:300:ef::26)
 by BYAPR12MB3558.namprd12.prod.outlook.com (2603:10b6:a03:aa::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 8 Apr
 2021 10:22:20 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::b7) by MWHPR22CA0016.outlook.office365.com
 (2603:10b6:300:ef::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 10:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 10:22:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 05:22:18 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 8 Apr 2021 05:22:17 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amdgpu: Change GC(GMC/GFXHUB/..) register access from
 MMIO to RLCG
Date: Thu, 8 Apr 2021 18:22:02 +0800
Message-ID: <20210408102205.911-5-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408102205.911-1-PengJu.Zhou@amd.com>
References: <20210408102205.911-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f32604c7-9e0b-44d5-d169-08d8fa783107
X-MS-TrafficTypeDiagnostic: BYAPR12MB3558:
X-Microsoft-Antispam-PRVS: <BYAPR12MB355851F72314D59B0626943FF8749@BYAPR12MB3558.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4G/pglYif+FRydglpx2X9GEmiFa6SrlmKtvNQpG0l4ywL1aEEckdp/E9NUeBHgJtz23dxx9nlWghVIKVQJWZ5lVhsDD0+PQE8KsQLyDCXOLeX7VVxlQWC5eg5coF+YPPFku0Mg6ozgKAqhsnA9Bh6090e2TZxIxVhL0i6ZkCoeaByaBS5TwGDrQDCDf04eJgxPVb7Qq4/w9GuzAsI1GsO/V1FuxvWdDIrf427k9pqtDT9jl0BpMOcIuWLmoSc89VF06JDWHz8jDpYoxhLbTSmR064mDhxis0VrhnJJqGi//kyWPXMkSLm2pj/fwQA2ye9pKPBxAgUZAfJOJMqEJ9+gcF6YlGWBc9fq4/fvJXipIQSOfqADu+pSRxgk1tbwNRtJlT7aW9G0+MW3micClGrNv29fYLNvp6afUR4FUnSMz8An1DhGhF8l/o5VOPseS5UgtCZCA7vJ6kPXp6GVJS4KA+u5lMlWj6g7xoWlcVJnmFS7bjFbq5NGWXyVi8Eigw+mK8C+0pPWcM5Mynel1+KQVrMfS9PRkfIIXOQgv1LxszkGq+0QNb00GhCoI6TmcJR8nZYJsvlgx+AAb622Wipe2mb8CT5u2dtRxpdVUNv/lfo8KVykNS1Qcmd9p4xizd0MLyWED8MmzN7+zjrPC6ZgIbLNOqAmdigZNpb6p+/7WAiPa9vznpv7C7Ss8ON3c
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(36840700001)(46966006)(5660300002)(8676002)(70206006)(4326008)(47076005)(316002)(86362001)(36756003)(70586007)(8936002)(82740400003)(478600001)(82310400003)(6666004)(2616005)(1076003)(356005)(81166007)(336012)(26005)(83380400001)(186003)(426003)(36860700001)(30864003)(2906002)(7696005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 10:22:19.6981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f32604c7-9e0b-44d5-d169-08d8fa783107
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3558
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Change GC register access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 44 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c      |  8 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 22 ++++------
 drivers/gpu/drm/amd/amdgpu/nv.c               |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 13 ++----
 7 files changed, 47 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 9394dbf504de..7dcb94364448 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -239,7 +239,7 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 
 	for (reg = hqd_base;
 	     reg <= SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI); reg++)
-		WREG32(reg, mqd_hqd[reg - hqd_base]);
+		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
@@ -365,7 +365,7 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
 		if (WARN_ON_ONCE(i >= HQD_N_REGS))	\
 			break;				\
 		(*dump)[i][0] = (addr) << 2;		\
-		(*dump)[i++][1] = RREG32(addr);		\
+		(*dump)[i++][1] = RREG32_RLC(addr);		\
 	} while (0)
 
 	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4d32233cde92..10e2fbb0cb5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -578,13 +578,13 @@ void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 	for (i = 0; i < 16; i++) {
 		reg = hub->vm_context0_cntl + hub->ctx_distance * i;
 
-		tmp = RREG32(reg);
+		tmp = (hub_type == AMDGPU_GFXHUB_0) ? RREG32_RLC(reg) : RREG32(reg);
 		if (enable)
 			tmp |= hub->vm_cntx_cntl_vm_fault;
 		else
 			tmp &= ~hub->vm_cntx_cntl_vm_fault;
 
-		WREG32(reg, tmp);
+		WREG32_RLC(reg, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8a54d5f27671..b1d5b08e4f06 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1435,6 +1435,10 @@ static bool gfx_v10_is_rlcg_rw(struct amdgpu_device *adev, u32 offset, uint32_t
 	    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH) ||
 	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL) ||
 	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX) ||
+	    offset == SOC15_REG_OFFSET(GC, 0, mmPA_SC_BINNER_EVENT_CNTL_3) ||
+	    offset == SOC15_REG_OFFSET(GC, 0, mmPA_SC_ENHANCE) ||
+	    offset == SOC15_REG_OFFSET(GC, 0, mmPA_SC_ENHANCE_1) ||
+	    offset == SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG) ||
 	    offset == SOC15_REG_OFFSET(GC, 0, mmCP_ME_CNTL)) {
 		if (!amdgpu_sriov_reg_indirect_gc(adev))
 			*flag = GFX_RLCG_GC_WRITE_OLD;
@@ -4935,8 +4939,8 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   acccess. These should be enabled by FW for target VMIDs. */
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_GWS_VMID0, i, 0);
 		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_OA_VMID0, i, 0);
 	}
@@ -4953,8 +4957,8 @@ static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
 	 * access so that HWS firmware can save/restore entries.
 	 */
 	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * vmid, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * vmid, 0);
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_VMID0_BASE, 2 * vmid, 0);
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_VMID0_SIZE, 2 * vmid, 0);
 		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_GWS_VMID0, vmid, 0);
 		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_OA_VMID0, vmid, 0);
 	}
@@ -6810,7 +6814,7 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 	       mqd->cp_hqd_pq_doorbell_control);
 
 	/* disable the queue if it's active */
-	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
+	if (RREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE) & 1) {
 		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
 		for (j = 0; j < adev->usec_timeout; j++) {
 			if (!(RREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE) & 1))
@@ -6887,7 +6891,7 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 	       mqd->cp_hqd_active);
 
 	if (ring->use_doorbell)
-		WREG32_FIELD15(GC, 0, CP_PQ_STATUS, DOORBELL_ENABLE, 1);
+		WREG32_FIELD15_RLC(GC, 0, CP_PQ_STATUS, DOORBELL_ENABLE, 1);
 
 	return 0;
 }
@@ -8625,16 +8629,16 @@ gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		cp_int_cntl = RREG32(cp_int_cntl_reg);
+		cp_int_cntl = RREG32_RLC(cp_int_cntl_reg);
 		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
 					    TIME_STAMP_INT_ENABLE, 0);
-		WREG32(cp_int_cntl_reg, cp_int_cntl);
+		WREG32_RLC(cp_int_cntl_reg, cp_int_cntl);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		cp_int_cntl = RREG32(cp_int_cntl_reg);
+		cp_int_cntl = RREG32_RLC(cp_int_cntl_reg);
 		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
 					    TIME_STAMP_INT_ENABLE, 1);
-		WREG32(cp_int_cntl_reg, cp_int_cntl);
+		WREG32_RLC(cp_int_cntl_reg, cp_int_cntl);
 		break;
 	default:
 		break;
@@ -8678,16 +8682,16 @@ static void gfx_v10_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_RLC(mec_int_cntl_reg);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 0);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_RLC(mec_int_cntl_reg, mec_int_cntl);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_RLC(mec_int_cntl_reg);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 1);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_RLC(mec_int_cntl_reg, mec_int_cntl);
 		break;
 	default:
 		break;
@@ -8779,7 +8783,7 @@ static int gfx_v10_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
+		WREG32_FIELD15_RLC(GC, 0, CP_INT_CNTL_RING0,
 			       PRIV_REG_INT_ENABLE,
 			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
 		break;
@@ -8798,7 +8802,7 @@ static int gfx_v10_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
+		WREG32_FIELD15_RLC(GC, 0, CP_INT_CNTL_RING0,
 			       PRIV_INSTR_INT_ENABLE,
 			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
 		break;
@@ -8883,20 +8887,20 @@ static int gfx_v10_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 					    GENERIC2_INT_ENABLE, 0);
 			WREG32_SOC15_RLC(GC, 0, mmCPC_INT_CNTL, tmp);
 
-			tmp = RREG32(target);
+			tmp = RREG32_RLC(target);
 			tmp = REG_SET_FIELD(tmp, CP_ME2_PIPE0_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 0);
-			WREG32(target, tmp);
+			WREG32_RLC(target, tmp);
 		} else {
 			tmp = RREG32_SOC15_RLC(GC, 0, mmCPC_INT_CNTL);
 			tmp = REG_SET_FIELD(tmp, CPC_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 1);
 			WREG32_SOC15_RLC(GC, 0, mmCPC_INT_CNTL, tmp);
 
-			tmp = RREG32(target);
+			tmp = RREG32_RLC(target);
 			tmp = REG_SET_FIELD(tmp, CP_ME2_PIPE0_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 1);
-			WREG32(target, tmp);
+			WREG32_RLC(target, tmp);
 		}
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 30ff10953831..a96be9acb9b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -316,14 +316,14 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
 				    i * hub->ctx_addr_distance, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
 				    i * hub->ctx_addr_distance, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
 				    i * hub->ctx_addr_distance,
 				    lower_32_bits(adev->vm_manager.max_pfn - 1));
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 42818c40d08c..c3a45682847e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -243,8 +243,9 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	if (use_semaphore) {
 		for (i = 0; i < adev->usec_timeout; i++) {
 			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem +
-					    hub->eng_distance * eng);
+			tmp = (vmhub == AMDGPU_GFXHUB_0) ?
+				RREG32_RLC(hub->vm_inv_eng0_sem + eng) :
+				RREG32(hub->vm_inv_eng0_sem + eng);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -254,10 +255,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	if (vmhub == AMDGPU_MMHUB_0)
-		WREG32_RLC_NO_KIQ((hub->vm_inv_eng0_req + eng), inv_req);
-	else
-		WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, inv_req);
+	WREG32_RLC_NO_KIQ((hub->vm_inv_eng0_req + eng), inv_req);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to be cleared
@@ -265,12 +263,13 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if ((vmhub == AMDGPU_GFXHUB_0) &&
 	    (adev->asic_type < CHIP_SIENNA_CICHLID))
-		RREG32_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng);
+		RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng);
 
 	/* Wait for ACK with a delay.*/
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_ack +
-				    hub->eng_distance * eng);
+		tmp = (vmhub == AMDGPU_GFXHUB_0) ?
+			RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack + eng) :
+			RREG32_NO_KIQ(hub->vm_inv_eng0_ack + eng);
 		tmp &= 1 << vmid;
 		if (tmp)
 			break;
@@ -284,10 +283,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
 		 */
-		if (vmhub == AMDGPU_MMHUB_0)
-			WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + eng, 0);
-		else
-			WREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng, 0);
+		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + eng, 0);
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index ce04bc6dea21..c848b9470f66 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -440,7 +440,7 @@ static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
 	if (se_num != 0xffffffff || sh_num != 0xffffffff)
 		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff);
 
-	val = RREG32(reg_offset);
+	val = RREG32_RLC(reg_offset);
 
 	if (se_num != 0xffffffff || sh_num != 0xffffffff)
 		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
@@ -457,7 +457,7 @@ static uint32_t nv_get_register_value(struct amdgpu_device *adev,
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
 			return adev->gfx.config.gb_addr_config;
-		return RREG32(reg_offset);
+		return RREG32_RLC(reg_offset);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 5c5eb3aed1b3..06449b325783 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -579,7 +579,8 @@ static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
 			return adev->gfx.config.gb_addr_config;
 		else if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmDB_DEBUG2))
 			return adev->gfx.config.db_debug2;
-		return RREG32(reg_offset);
+
+		return RREG32_RLC(reg_offset);
 	}
 }
 
@@ -632,18 +633,12 @@ void soc15_program_register_sequence(struct amdgpu_device *adev,
 		if (entry->and_mask == 0xffffffff) {
 			tmp = entry->or_mask;
 		} else {
-			tmp = RREG32(reg);
+			tmp = RREG32_RLC(reg);
 			tmp &= ~(entry->and_mask);
 			tmp |= (entry->or_mask & entry->and_mask);
 		}
 
-		if (reg == SOC15_REG_OFFSET(GC, 0, mmPA_SC_BINNER_EVENT_CNTL_3) ||
-			reg == SOC15_REG_OFFSET(GC, 0, mmPA_SC_ENHANCE) ||
-			reg == SOC15_REG_OFFSET(GC, 0, mmPA_SC_ENHANCE_1) ||
-			reg == SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG))
-			WREG32_RLC(reg, tmp);
-		else
-			WREG32(reg, tmp);
+		WREG32_RLC(reg, tmp);
 
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
