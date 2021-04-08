Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3F8C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 05:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BCA61151
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 05:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BCA61151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 129F589D2E;
	Thu,  8 Apr 2021 05:33:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9015C89CCE
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 05:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkwtfKJI40FxtS1K8oFwQeuI4tC2aGNFP0VaGzX0Si43vSd1qaQTJ3bf28kcFRIdBdiV3SCI0k+1aV9XpOnrfnryLJdoy+ko3MSM9kaU1g2JfcZrar/u0dZO8RDJenvUXDiJiPd5lpERK7sVTD78X5OCd0dN1nFtMMS/DeD1x5OYreeuyg10x6/2xX7VBoRlhQ1sOWkQMEVye1+as3xFSFEfErdmQ0vKqhm06lDPkN9g1l0TU19FJAxQCJ6kTRh7Wyzg14RdI+EUlDe4hb8UtAKwXkekwC1t4Fbb1ghU7ZQtGc3tkgnoC17H3Ql/3DucOow3RecsfSLABeErtVkyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAUafYIBpM3ocyE0hDo0pUINH+ktw8RKSr9iv1BeSGI=;
 b=Q33doLOvi8TJIaVegv4EOLn5hDXcgDyQXmcFPJzNkfl1tr51V/9aq1akAjwfySQsr6o54g+MDldKDffqAo57Hj04+9/8HLImeG4SHIF7AzIlTF4kMwOGm0iKIbWwDfflf6gNI848cAQheeHysbXCYZUxH7qwteuRqnVq9SePPYdf4fzoawJbdF70yAC4wdNehMUaQXyDAoFgtRFhPU+lFpo/nrLAiL5CZ/k/59cuX36XJxCE1IsoRby1/JgeVcK+D+iMXETyQa6GDR3Fil7VDIFctDVo5gDAK/okPPjR40ZR6muxbE5qy3NJNN8msCQroWR7VfirAjJ3TYzaAp+fNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAUafYIBpM3ocyE0hDo0pUINH+ktw8RKSr9iv1BeSGI=;
 b=pD9y1A9lkixlf/H83p8TVbfX3BDNj5Ou1VlgWVhlIdiXEAO8m8Hmuhjm+eAnfYCuDd1dUOR9XB7yjpA3v38bblAwXvSjraASnkB/xIQ7f4ktUD/o+13nyqsQDolFMW8bokzGlfR6lH6Bp76UIkQAHQrbc9qQ6TdQocVbdZCsDjA=
Received: from BN8PR15CA0053.namprd15.prod.outlook.com (2603:10b6:408:80::30)
 by CH0PR12MB5220.namprd12.prod.outlook.com (2603:10b6:610:d3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 05:33:17 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::2d) by BN8PR15CA0053.outlook.office365.com
 (2603:10b6:408:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 05:33:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 05:33:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 00:33:16 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 8 Apr 2021 00:33:15 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amdgpu: Change GC register access from MMIO to RLCG
Date: Thu, 8 Apr 2021 13:32:33 +0800
Message-ID: <20210408053236.30762-5-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408053236.30762-1-PengJu.Zhou@amd.com>
References: <20210408053236.30762-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09cb9957-aa2a-4bf1-cede-08d8fa4fd023
X-MS-TrafficTypeDiagnostic: CH0PR12MB5220:
X-Microsoft-Antispam-PRVS: <CH0PR12MB522074001D50E8344CA81742F8749@CH0PR12MB5220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BWr/nrTgkTedzNIgS92ixShHja1j93Mm2lNo6LcCs+JxM2obYh4tOBaNk38Cg8PToGLqFvZoWv1QXSkbc4zHuB02+J4iMP3xxpEE1sJkoFbA7HobFXw3HEdIVk/8yQgTviwSqHGXva8PEHFTJzDq4krbIjODvrn1UuAcghnj/84zaWH2pPRUC9fbQHxFX5f5YHB9kPWfVY9w0qc8rwIFYuyIjHBChytsTsQFat9YlRmVAYMytHy1FS9zkE7rsQt6pzsVUKb4Isz/f6Mm+wfo59tp/8eVdegJnAmqJIYHbpTHtQlKzKNwgINkkhPu/P7OiGqkfzotuip/WkEpq6O8L5fseKqF/zucWQVOT9bkMhg1UMuazW0z1RujT+a4iFrzciTZShIUjaKy6vHK7PF1/ah7jP01GN95hz2GUPK1QmzjALXZKJwqJpbEKxW0jYcfZL6TbbZk+6cZGbPBDhKW6fHBPbKkXNFbubSJD82iQ6ucOHrTTA2PkFpZhN/cmwPX+WIXk4T4YQzzswbaNTqGuFvLn3Z6i1GI2McZQf1Z76vVFa/iDLK61Uzz4bPEVOXenlcol/1qOMPRcaNobADVik4AzvMfoN6YJwRofsZCvoNsSA+he78RmMjA+bpAtYI4zpRVMGvosEXmJHlW2USo97S6dBkFCR/PEt35Jp3EEb+08CdOVoH5S+5yyLkhXUBv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(36840700001)(46966006)(8936002)(478600001)(6916009)(47076005)(8676002)(336012)(7696005)(426003)(36860700001)(2616005)(54906003)(316002)(30864003)(4326008)(81166007)(83380400001)(26005)(82740400003)(6666004)(356005)(86362001)(2906002)(36756003)(70206006)(82310400003)(5660300002)(1076003)(186003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 05:33:17.3843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cb9957-aa2a-4bf1-cede-08d8fa4fd023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5220
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
Cc: jane.jian@amd.com
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
