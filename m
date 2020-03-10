Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9450FC10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 14:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660AA2464B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 14:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XQBp0fOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660AA2464B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFF56E2E1;
	Tue, 10 Mar 2020 14:07:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1683B6E2E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 14:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afz1OgrLbtDvLmG3FshdrSLbjdSKKV0SYzFV6mA3mA8uEA0wDi+Wh7v5CS4+pgZ+sRquzArGbJVd15l1ZlA6yO10NBdu7/Qbc13GLyXWTacb2ehzKid8lklI1wk4/6AqOgdzohzJiOsdvItzjHFKLfFBlinFl0VFa4B+V1vIcCt3Q2pn1Cea2ico8PXwFI+z+Hhx7BIZuWlWFbTltBv9xkrYQpS3FBha+EERnwWmoOlPNH16h4lfHo/y8AKRaqxTgK2vNb+Gx3QF1zIg1+Vf1BeWvZqdVRv56QvWHzhjl2H6PkznXpsa45iMJh3TxBA2qARQ2tYGhDFyoJsJ2qLEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpQx1qX0wR9A9zbhlmaB9/Q4RTrhkW7PSNPQ6Ix9aC4=;
 b=m2/NPhujLDVg+e8FWU0PQ4PioDqBVXVzchFsNYADeF/TqvNaHLE4H5O2OzZeJRoqx6rq0y982TjAzB1K6uXBH7SaGzuzjBI5aZJk4iT5Iw4kJKi9pxURQ/ixChDIUNKOlG/EiP4Fcg8lZFf7c9XJ4JNuPg5oMc+KjD0nd5f0JTvQ8atrpdLoDLeae6dl/HibFdql9eFhvmcLqxv44ZXEVr87W7nAYEsNrAg1VbYT1CRdabHnOnnX93FjD3ft+07qkgQZtRqI35jUe4Ciy8F5tcEB+KfF7RJ9XWoFNa5+BXF7vTEFmyt5UrvOHzW6hT6a+hGRcu2E5LLqNA4mFRWwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpQx1qX0wR9A9zbhlmaB9/Q4RTrhkW7PSNPQ6Ix9aC4=;
 b=XQBp0fOT58yQ4Hr7khEUEMddcGuGyZhv5+z8drZMRab6xrtdc/kvMGRuUHz8Uet7JrMmKfKn0bYRxRBfiNjZxCVQWvaO6vAaY+ULG+JG3HgL9Nh4LAioqu/cW6/zPpqUHlLHaMJommuPwUD4j7Gx/U+Q+CurpXDXozOCjfcWii0=
Received: from CO1PR15CA0056.namprd15.prod.outlook.com (2603:10b6:101:1f::24)
 by DM6PR12MB3866.namprd12.prod.outlook.com (2603:10b6:5:1c6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Tue, 10 Mar
 2020 14:07:25 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:1f:cafe::b4) by CO1PR15CA0056.outlook.office365.com
 (2603:10b6:101:1f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Tue, 10 Mar 2020 14:07:25 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Tue, 10 Mar 2020 14:07:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 09:07:24 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 09:07:24 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 10 Mar 2020 09:07:23 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: refactor RLCG access path part 2
Date: Tue, 10 Mar 2020 22:07:17 +0800
Message-ID: <1583849237-28789-2-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583849237-28789-1-git-send-email-Monk.Liu@amd.com>
References: <1583849237-28789-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(428003)(199004)(189003)(26005)(30864003)(336012)(70206006)(426003)(86362001)(4326008)(81156014)(2906002)(5660300002)(81166006)(8676002)(186003)(70586007)(6666004)(7696005)(316002)(2616005)(6916009)(478600001)(8936002)(356004)(54906003)(36756003)(21314003)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3866; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d94756e-1cbe-4c8f-ef32-08d7c4fc5c40
X-MS-TrafficTypeDiagnostic: DM6PR12MB3866:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3866D781EA5DAF516BD3471984FF0@DM6PR12MB3866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-Forefront-PRVS: 033857D0BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDjTNxItgbjwNcMikW2GDrHZ4OymXMRGBlxOE0w0DAEAits50VfIpSoDO2/zCQRMCr3O/oYHdgLFLT1pqKnmHtjriJRVT9axutVvPHSNA3AOrWW7G1/euQLPMVM+h5zsMaUG2nq4hxjDwbo6ZMUgDchVv7oK6V3xU6C97hK0faO7Z7TOoNsIhC8EOnE4cMQ9lulMUsZIdeAl43KwRhvEtvvZK0HVur6Hg6OlyDf7ooAKbuHpOEY2i+jJdMZ+OcJofC2aMJ3VDG8EdmL8tqZ4iG512uVmf+0ijxLsBsswzmQkfY16IOlbxNjYYnRALpJwFBkuGIpHMySDbDtGoIpTlcRrwch1f3aEtcVuBhd3+ie0awYY4bSs1hlEJ9LfFz/1Q2Z6OG8WfBqrXBz4u+SiUzt3SMbIfj2s+28IaHTlXlkCmr6gc/f069YL6tn3w7AT2hA1SufcdccIzWwoykNTEvQc09YFfKlwx0TCTMQ7WpH3o3AeTDWYEnatkj1EzTnW9dGtGSbqCppLza108o8huw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 14:07:25.3147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d94756e-1cbe-4c8f-ef32-08d7c4fc5c40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3866
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

switch to new RLCG access path, and drop the legacy
WREG32_RLC macros

tested-by: Monk Liu <monk.liu@amd.com>
tested-by: Zhou pengju <pengju.zhou@amd.com>
Signed-off-by: Zhou pengju <pengju.zhou@amd.com>
Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  30 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |   5 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 104 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c          |  28 +++---
 drivers/gpu/drm/amd/amdgpu/soc15.c                |  11 +--
 drivers/gpu/drm/amd/amdgpu/soc15_common.h         |  57 ------------
 8 files changed, 93 insertions(+), 152 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index df841c2..a21f005 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -105,8 +105,8 @@ void kgd_gfx_v9_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
 
 	lock_srbm(kgd, 0, 0, 0, vmid);
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
 	/* APE1 no longer exists on GFX9 */
 
 	unlock_srbm(kgd);
@@ -242,13 +242,13 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 
 	for (reg = hqd_base;
 	     reg <= SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI); reg++)
-		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
+		WREG32(reg, mqd_hqd[reg - hqd_base]);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL), data);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL), data);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user
@@ -277,25 +277,25 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_LO),
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_LO),
 		       lower_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
 		       upper_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
 		       lower_32_bits((uintptr_t)wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
 		       upper_32_bits((uintptr_t)wptr));
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
-		       (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
+		       get_queue_mask(adev, pipe_id, queue_id));
 	}
 
 	/* Start the EOP fetcher */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_EOP_RPTR),
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_EOP_RPTR),
 	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
 			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE), data);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE), data);
 
 	release_queue(kgd);
 
@@ -547,7 +547,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	acquire_queue(kgd, pipe_id, queue_id);
 
 	if (m->cp_hqd_vmid == 0)
-		WREG32_FIELD15_RLC(GC, 0, RLC_CP_SCHEDULERS, scheduler1, 0);
+		WREG32_FIELD15(GC, 0, RLC_CP_SCHEDULERS, scheduler1, 0);
 
 	switch (reset_type) {
 	case KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN:
@@ -561,7 +561,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 		break;
 	}
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_DEQUEUE_REQUEST), type);
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_DEQUEUE_REQUEST), type);
 
 	end_jiffies = (utimeout * HZ / 1000) + jiffies;
 	while (true) {
@@ -656,7 +656,7 @@ int kgd_gfx_v9_wave_control_execute(struct kgd_dev *kgd,
 
 	mutex_lock(&adev->grbm_idx_mutex);
 
-	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, gfx_index_val);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, gfx_index_val);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CMD), sq_cmd);
 
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
@@ -666,7 +666,7 @@ int kgd_gfx_v9_wave_control_execute(struct kgd_dev *kgd,
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
 		SE_BROADCAST_WRITES, 1);
 
-	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, data);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 572eb6e..9029407 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -328,6 +328,11 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
+	if (amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs &&
+		adev->gfx.rlc.funcs->is_rlcg_access_range)
+		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
+			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v);
+
 	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	else {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 3222cd3..78291b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1835,11 +1835,11 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
 	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
 
 	/* csib */
-	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,
+	WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_HI,
 		     adev->gfx.rlc.clear_state_gpu_addr >> 32);
-	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,
+	WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_LO,
 		     adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
-	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
+	WREG32_SOC15(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
 
 	return 0;
 }
@@ -2447,7 +2447,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 			adev->gfx.gfx_ring[i].sched.ready = false;
 	}
-	WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
+	WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1fc430d..57d370a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2500,7 +2500,7 @@ static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh
 	else
 		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_INDEX, sh_num);
 
-	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, data);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
 }
 
 static u32 gfx_v9_0_get_rb_active_bitmap(struct amdgpu_device *adev)
@@ -2568,8 +2568,8 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 	for (i = FIRST_COMPUTE_VMID; i < LAST_COMPUTE_VMID; i++) {
 		soc15_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
-		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
-		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
+		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
+		WREG32_SOC15(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
 	}
 	soc15_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
@@ -2623,7 +2623,7 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 	u32 tmp;
 	int i;
 
-	WREG32_FIELD15_RLC(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
+	WREG32_FIELD15(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
 
 	gfx_v9_0_tiling_mode_table_init(adev);
 
@@ -2642,19 +2642,19 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 					    SH_MEM_ALIGNMENT_MODE_UNALIGNED);
 			tmp = REG_SET_FIELD(tmp, SH_MEM_CONFIG, RETRY_DISABLE,
 					    !!amdgpu_noretry);
-			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, tmp);
-			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, 0);
+			WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, tmp);
+			WREG32_SOC15(GC, 0, mmSH_MEM_BASES, 0);
 		} else {
 			tmp = REG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_MODE,
 					    SH_MEM_ALIGNMENT_MODE_UNALIGNED);
 			tmp = REG_SET_FIELD(tmp, SH_MEM_CONFIG, RETRY_DISABLE,
 					    !!amdgpu_noretry);
-			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, tmp);
+			WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, tmp);
 			tmp = REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE,
 				(adev->gmc.private_aperture_start >> 48));
 			tmp = REG_SET_FIELD(tmp, SH_MEM_BASES, SHARED_BASE,
 				(adev->gmc.shared_aperture_start >> 48));
-			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, tmp);
+			WREG32_SOC15(GC, 0, mmSH_MEM_BASES, tmp);
 		}
 	}
 	soc15_grbm_select(adev, 0, 0, 0, 0);
@@ -2721,11 +2721,11 @@ static void gfx_v9_0_init_csb(struct amdgpu_device *adev)
 {
 	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
 	/* csib */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI),
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI),
 			adev->gfx.rlc.clear_state_gpu_addr >> 32);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO),
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO),
 			adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH),
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH),
 			adev->gfx.rlc.clear_state_size);
 }
 
@@ -3197,7 +3197,7 @@ static void gfx_v9_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 			adev->gfx.gfx_ring[i].sched.ready = false;
 	}
-	WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
+	WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
 	udelay(50);
 }
 
@@ -3395,9 +3395,9 @@ static void gfx_v9_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 	int i;
 
 	if (enable) {
-		WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL, 0);
+		WREG32_SOC15(GC, 0, mmCP_MEC_CNTL, 0);
 	} else {
-		WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL,
+		WREG32_SOC15(GC, 0, mmCP_MEC_CNTL,
 			(CP_MEC_CNTL__MEC_ME1_HALT_MASK | CP_MEC_CNTL__MEC_ME2_HALT_MASK));
 		for (i = 0; i < adev->gfx.num_compute_rings; i++)
 			adev->gfx.compute_ring[i].sched.ready = false;
@@ -3458,9 +3458,9 @@ static void gfx_v9_0_kiq_setting(struct amdgpu_ring *ring)
 	tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
 	tmp &= 0xffffff00;
 	tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-	WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+	WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
 	tmp |= 0x80;
-	WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+	WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
 }
 
 static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *mqd)
@@ -3637,67 +3637,67 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
 	/* disable wptr polling */
 	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
 
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_EOP_BASE_ADDR,
+	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR,
 	       mqd->cp_hqd_eop_base_addr_lo);
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI,
+	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI,
 	       mqd->cp_hqd_eop_base_addr_hi);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_EOP_CONTROL,
+	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONTROL,
 	       mqd->cp_hqd_eop_control);
 
 	/* enable doorbell? */
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
 	       mqd->cp_hqd_pq_doorbell_control);
 
 	/* disable the queue if it's active */
 	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
-		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
+		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
 		for (j = 0; j < adev->usec_timeout; j++) {
 			if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
 				break;
 			udelay(1);
 		}
-		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_DEQUEUE_REQUEST,
+		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST,
 		       mqd->cp_hqd_dequeue_request);
-		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_RPTR,
+		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR,
 		       mqd->cp_hqd_pq_rptr);
-		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO,
+		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO,
 		       mqd->cp_hqd_pq_wptr_lo);
-		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI,
+		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI,
 		       mqd->cp_hqd_pq_wptr_hi);
 	}
 
 	/* set the pointer to the MQD */
-	WREG32_SOC15_RLC(GC, 0, mmCP_MQD_BASE_ADDR,
+	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR,
 	       mqd->cp_mqd_base_addr_lo);
-	WREG32_SOC15_RLC(GC, 0, mmCP_MQD_BASE_ADDR_HI,
+	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR_HI,
 	       mqd->cp_mqd_base_addr_hi);
 
 	/* set MQD vmid to 0 */
-	WREG32_SOC15_RLC(GC, 0, mmCP_MQD_CONTROL,
+	WREG32_SOC15(GC, 0, mmCP_MQD_CONTROL,
 	       mqd->cp_mqd_control);
 
 	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_BASE,
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE,
 	       mqd->cp_hqd_pq_base_lo);
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_BASE_HI,
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI,
 	       mqd->cp_hqd_pq_base_hi);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_CONTROL,
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_CONTROL,
 	       mqd->cp_hqd_pq_control);
 
 	/* set the wb address whether it's enabled or not */
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR,
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR,
 				mqd->cp_hqd_pq_rptr_report_addr_lo);
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
 				mqd->cp_hqd_pq_rptr_report_addr_hi);
 
 	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,
 	       mqd->cp_hqd_pq_wptr_poll_addr_lo);
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
 	       mqd->cp_hqd_pq_wptr_poll_addr_hi);
 
 	/* enable the doorbell if requested */
@@ -3708,23 +3708,23 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
 					(adev->doorbell_index.userqueue_end * 2) << 2);
 	}
 
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
 	       mqd->cp_hqd_pq_doorbell_control);
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO,
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO,
 	       mqd->cp_hqd_pq_wptr_lo);
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI,
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI,
 	       mqd->cp_hqd_pq_wptr_hi);
 
 	/* set the vmid for the queue */
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_VMID, mqd->cp_hqd_vmid);
+	WREG32_SOC15(GC, 0, mmCP_HQD_VMID, mqd->cp_hqd_vmid);
 
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PERSISTENT_STATE,
+	WREG32_SOC15(GC, 0, mmCP_HQD_PERSISTENT_STATE,
 	       mqd->cp_hqd_persistent_state);
 
 	/* activate the queue */
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE,
+	WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE,
 	       mqd->cp_hqd_active);
 
 	if (ring->use_doorbell)
@@ -3741,7 +3741,7 @@ static int gfx_v9_0_kiq_fini_register(struct amdgpu_ring *ring)
 	/* disable the queue if it's active */
 	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
 
-		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
+		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
 
 		for (j = 0; j < adev->usec_timeout; j++) {
 			if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
@@ -3753,21 +3753,21 @@ static int gfx_v9_0_kiq_fini_register(struct amdgpu_ring *ring)
 			DRM_DEBUG("KIQ dequeue request failed.\n");
 
 			/* Manual disable if dequeue request times out */
-			WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE, 0);
+			WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
 		}
 
-		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_DEQUEUE_REQUEST,
+		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST,
 		      0);
 	}
 
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_IQ_TIMER, 0);
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_IB_CONTROL, 0);
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PERSISTENT_STATE, 0);
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL, 0x40000000);
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL, 0);
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_RPTR, 0);
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI, 0);
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO, 0);
+	WREG32_SOC15(GC, 0, mmCP_HQD_IQ_TIMER, 0);
+	WREG32_SOC15(GC, 0, mmCP_HQD_IB_CONTROL, 0);
+	WREG32_SOC15(GC, 0, mmCP_HQD_PERSISTENT_STATE, 0);
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL, 0x40000000);
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL, 0);
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR, 0);
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI, 0);
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index 17f1e7b..6b9127b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -114,7 +114,7 @@ static void gfx_v9_4_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 	else
 		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_INDEX, sh_num);
 
-	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, data);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
 }
 
 static const struct soc15_ras_field_entry gfx_v9_4_ras_fields[] = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 1a2f18b..9360d61 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -71,13 +71,13 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 
 	/* Program the AGP BAR */
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+	WREG32_SOC15(GC, 0, mmMC_VM_AGP_BASE, 0);
+	WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
 
 	if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
 		/* Program the system aperture low logical page number. */
-		WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 
 		if (adev->asic_type == CHIP_RAVEN && adev->rev_id >= 0x8)
@@ -88,12 +88,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 			* aperture high address (add 1) to get rid of the VM
 			* fault and hardware hang.
 			*/
-			WREG32_SOC15_RLC(GC, 0,
+			WREG32_SOC15(GC, 0,
 					 mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 					 max((adev->gmc.fb_end >> 18) + 0x1,
 					     adev->gmc.agp_end >> 18));
 		else
-			WREG32_SOC15_RLC(
+			WREG32_SOC15(
 				GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 				max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
@@ -134,7 +134,7 @@ static void gfxhub_v1_0_init_tlb_regs(struct amdgpu_device *adev)
 			    MTYPE, MTYPE_UC);/* XXX for emulation. */
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
 
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
+	WREG32_SOC15(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
 }
 
 static void gfxhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
@@ -151,12 +151,12 @@ static void gfxhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, PDE_FAULT_CLASSIFICATION, 0);
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, CONTEXT1_IDENTITY_ACCESS_MODE, 1);
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, IDENTITY_MODE_FRAGMENT_SIZE, 0);
-	WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL, tmp);
+	WREG32_SOC15(GC, 0, mmVM_L2_CNTL, tmp);
 
 	tmp = RREG32_SOC15(GC, 0, mmVM_L2_CNTL2);
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_ALL_L1_TLBS, 1);
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
-	WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL2, tmp);
+	WREG32_SOC15(GC, 0, mmVM_L2_CNTL2, tmp);
 
 	tmp = mmVM_L2_CNTL3_DEFAULT;
 	if (adev->gmc.translate_further) {
@@ -168,12 +168,12 @@ static void gfxhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
 				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
 	}
-	WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL3, tmp);
+	WREG32_SOC15(GC, 0, mmVM_L2_CNTL3, tmp);
 
 	tmp = mmVM_L2_CNTL4_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
-	WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL4, tmp);
+	WREG32_SOC15(GC, 0, mmVM_L2_CNTL4, tmp);
 }
 
 static void gfxhub_v1_0_enable_system_domain(struct amdgpu_device *adev)
@@ -275,9 +275,9 @@ int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)
 		 * VF copy registers so vbios post doesn't program them, for
 		 * SRIOV driver need to program them
 		 */
-		WREG32_SOC15_RLC(GC, 0, mmMC_VM_FB_LOCATION_BASE,
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE,
 			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15_RLC(GC, 0, mmMC_VM_FB_LOCATION_TOP,
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP,
 			     adev->gmc.vram_end >> 24);
 	}
 
@@ -313,7 +313,7 @@ void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev)
 				MC_VM_MX_L1_TLB_CNTL,
 				ENABLE_ADVANCED_DRIVER_MODEL,
 				0);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
+	WREG32_SOC15(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
 
 	/* Setup L2 cache */
 	WREG32_FIELD15(GC, 0, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a40499d..9800f0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -297,7 +297,7 @@ void soc15_grbm_select(struct amdgpu_device *adev,
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, VMID, vmid);
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, QUEUEID, queue);
 
-	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_CNTL, grbm_gfx_cntl);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL, grbm_gfx_cntl);
 }
 
 static void soc15_vga_set_state(struct amdgpu_device *adev, bool state)
@@ -459,13 +459,7 @@ void soc15_program_register_sequence(struct amdgpu_device *adev,
 			tmp |= (entry->or_mask & entry->and_mask);
 		}
 
-		if (reg == SOC15_REG_OFFSET(GC, 0, mmPA_SC_BINNER_EVENT_CNTL_3) ||
-			reg == SOC15_REG_OFFSET(GC, 0, mmPA_SC_ENHANCE) ||
-			reg == SOC15_REG_OFFSET(GC, 0, mmPA_SC_ENHANCE_1) ||
-			reg == SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG))
-			WREG32_RLC(reg, tmp);
-		else
-			WREG32(reg, tmp);
+		WREG32(reg, tmp);
 
 	}
 
@@ -991,7 +985,6 @@ static uint64_t soc15_get_pcie_replay_count(struct amdgpu_device *adev)
 	/* Add the total number of NAKs, i.e the number of replays */
 	return (nak_r + nak_g);
 }
-
 static const struct amdgpu_asic_funcs soc15_asic_funcs =
 {
 	.read_disabled_bios = &soc15_read_disabled_bios,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 19e870c..7f46a0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -70,61 +70,4 @@
 		}						\
 	} while (0)
 
-#define AMDGPU_VIRT_SUPPORT_RLC_PRG_REG(a) (amdgpu_sriov_vf((a)) && !amdgpu_sriov_runtime((a)))
-#define WREG32_RLC(reg, value) \
-	do {							\
-		if (AMDGPU_VIRT_SUPPORT_RLC_PRG_REG(adev)) {    \
-			uint32_t i = 0;	\
-			uint32_t retries = 50000;	\
-			uint32_t r0 = adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0;	\
-			uint32_t r1 = adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1;	\
-			uint32_t spare_int = adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT;	\
-			WREG32(r0, value);	\
-			WREG32(r1, (reg | 0x80000000));	\
-			WREG32(spare_int, 0x1);	\
-			for (i = 0; i < retries; i++) {	\
-				u32 tmp = RREG32(r1);	\
-				if (!(tmp & 0x80000000))	\
-					break;	\
-				udelay(10);	\
-			}	\
-			if (i >= retries)	\
-				pr_err("timeout: rlcg program reg:0x%05x failed !\n", reg);	\
-		} else {	\
-			WREG32(reg, value); \
-		}	\
-	} while (0)
-
-#define WREG32_SOC15_RLC_SHADOW(ip, inst, reg, value) \
-	do {							\
-		uint32_t target_reg = adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg;\
-		if (AMDGPU_VIRT_SUPPORT_RLC_PRG_REG(adev)) {    \
-			uint32_t r2 = adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG2;	\
-			uint32_t r3 = adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3;	\
-			uint32_t grbm_cntl = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;   \
-			uint32_t grbm_idx = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;   \
-			if (target_reg == grbm_cntl) \
-				WREG32(r2, value);	\
-			else if (target_reg == grbm_idx) \
-				WREG32(r3, value);	\
-			WREG32(target_reg, value);	\
-		} else {	\
-			WREG32(target_reg, value); \
-		}	\
-	} while (0)
-
-#define WREG32_SOC15_RLC(ip, inst, reg, value) \
-	do {							\
-			uint32_t target_reg = adev->reg_offset[GC_HWIP][0][reg##_BASE_IDX] + reg;\
-			WREG32_RLC(target_reg, value); \
-	} while (0)
-
-#define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
-    WREG32_RLC((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
-    (RREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg) \
-    & ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
-
-#define WREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset, value) \
-    WREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset), value)
-
 #endif
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
