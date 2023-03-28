Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2554C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9492F10E923;
	Tue, 28 Mar 2023 15:14:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E1110E90C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyF7If4O4/t2dymBpeOn04tcFvsweq565p5ch8acQMQVmEIUfF3vRoUV4JVI16uA2paTYNjmER1JWcBbqVyP2h4lu26GrwGDrtvxKMK4Fsgr3PT3rax1ruJBdHKejw7OxGlEtjPq3+gyJ6q3BLkuUHp7Ngn5Iyxzpk4zi2Ho2JSgNqBHYvNmV0zB2jhLKrSnyqUSMFQZudfEI0mYwHLeggHordrn6gL0vHfmC9fJqJUE2/iZoHQ4Zq4i0MhsnxgN1XtUXHz1UjsSn6b9U7lSinY7kI75fGGNI77JbX6kw1xwKoc10x5DC3mpaKhRsw8h8epOzbeD/uWCzA2nOIuPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsKLZjpnxmF27VA+3Bujz02rSpbI0hfqP3fEhuR1xhA=;
 b=XjxYe7BvDwai06+b/NfBl8QM1Fjdx2hPXtNdwi4CRTk5b+DFnIdWwl8S81o0PpwkaKil2zRBKJcTEQAnrFxiFrlL6lIF7jxY/7mM9POUMObxwh5Bz3r4h1fW3r6f2vymHzATjKHnjTL4tRxIVvzGC2ZeJ9FMwc8V1ilr00q4+kg1fz6t3v6DPZJHpY/EpC/XVvV06CzhclIrrZ6J4hNGvI4M1xEZb4HPHb5dmrd+eQ0HFF5QMknQQoDTcOPHVgveRaq2tFtsWMs6xPNXcKbYDDnojHF07BH6nLukWVC35CjzfP5WtM3GgAxLMxGIa+LHmm+DuTuDql8PZcdrR4csQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsKLZjpnxmF27VA+3Bujz02rSpbI0hfqP3fEhuR1xhA=;
 b=4b6iyF+z+i9jgHEk+4HAAnWqkETJdXLuxWL4mFyc6qHrLy/Yi/icBLzeBIpjbbQs6qrR9bd40GCwX2L7GUWGjvHkJ190mq37wwkJThSIQrfi42cg2lNsr9hbs4l0BIdj3aOSeatLZw9fl00BqbLaI7Iblun00F6X5kVHD8NF3VI=
Received: from BN9PR03CA0076.namprd03.prod.outlook.com (2603:10b6:408:fc::21)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Tue, 28 Mar
 2023 15:14:37 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::74) by BN9PR03CA0076.outlook.office365.com
 (2603:10b6:408:fc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.9 via Frontend Transport; Tue, 28 Mar 2023 15:14:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/32] drm/amdkfd: Add XCC instance to kgd2kfd interface (v3)
Date: Tue, 28 Mar 2023 11:13:22 -0400
Message-ID: <20230328151344.1934291-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b02a4f-039c-483e-19b8-08db2f9f24ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tTRKJi2jyzxAgSnbHBeoA1IEIhN/AgpQNELF55uhT7qkEvPfirOatCrqibyCWGZQfWNfDhqFyDTTvPs7IsDp4o3bX9L3u980E39S1RO8WgpCKL/wKC+KhhssK8lp4RhHd3bMGz05y9GHCNwYdLsIqlr/2zdGAp+Ko69pKSDSvPJXbzg9GCrGn+SdXWV0U+Yjc98T7L4kWzUZp/5U72X+Nb9JHxcrKnCjyoX22GEB1CTTuksQIOiLTnyWn2nES9eNjs6mPs0Byovg8q4hfj4q9O85A3GmSt6lqmyhue27mdQDP2lP/woiP5NGWc5oJR7wxIYKB+KzuQrjuDw/PXu2bPbrSmuzcQULByAsn+vbqemYEPMvRQxfBzkV9SOahJ5/hPcKo7fywC/Vd+Bx+dr2AWux/FPXQegX5PeKn1/YDL4stVfovyqFukhVDPPw1bMewr0dvFUyYu+3WKrBfccVez3eXuULYZmVzKl7veE44Dt0AAldqGzpxXBeYn+Zhn1qe7NL2bvrxue5HLIAnN5U0iRpL+0cYVZtLpjFUN1/L1UcKQXNZhm15yJq08fFVCt0IdQdCmANOM0NDdLnon4aTqacImuKPGn9hBfReU7KYAD2rw4vsrZ3Ayuwy6RtldHdfunWQijZw/p0cKmrCo+LBPcGLh4cO5cOe+d5pTKHGsCfTZnBb1MOcogPQ4+WtGrb0XixTPBDvOZGF7OjdKQbXGH+4UotUA1B3GCrtBIyuc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(8676002)(81166007)(6916009)(70206006)(54906003)(36860700001)(70586007)(4326008)(316002)(1076003)(83380400001)(82740400003)(8936002)(356005)(5660300002)(41300700001)(30864003)(186003)(26005)(16526019)(47076005)(2616005)(426003)(478600001)(336012)(6666004)(7696005)(40480700001)(86362001)(2906002)(82310400005)(36756003)(66899021)(36900700001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:36.9592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b02a4f-039c-483e-19b8-08db2f9f24ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Felix
 Kuehling <Felix.Kuehling@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Morris Zhang <Shiwu.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Gfx 9 starts to have multiple XCC instances in one device. Add instance
parameter to kgd2kfd functions where XCC instance was hard coded as 0.
Also, update code to pass the correct instance number when running
on a multi-XCC setup.

v2: introduce the XCC instance to gfx v11 (Morris)
v3: rebase (Alex)

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Tested-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Morris Zhang <Shiwu.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  38 ++---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  22 +--
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  27 +--
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  19 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |  17 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |  17 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 160 +++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  29 ++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 103 +++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   6 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  15 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  25 +--
 17 files changed, 270 insertions(+), 218 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 562e1a04160f..49d8087e469e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -33,7 +33,7 @@
 #include "soc15.h"
 
 static int kgd_gfx_v9_4_3_set_pasid_vmid_mapping(struct amdgpu_device *adev,
-				u32 pasid, unsigned int vmid)
+				u32 pasid, unsigned int vmid, uint32_t inst)
 {
 	unsigned long timeout;
 
@@ -47,11 +47,11 @@ static int kgd_gfx_v9_4_3_set_pasid_vmid_mapping(struct amdgpu_device *adev,
 	uint32_t pasid_mapping = (pasid == 0) ? 0 : (uint32_t)pasid |
 			ATC_VMID0_PASID_MAPPING__VALID_MASK;
 
-	WREG32(SOC15_REG_OFFSET(ATHUB, 0,
+	WREG32(SOC15_REG_OFFSET(ATHUB, inst,
 		regATC_VMID0_PASID_MAPPING) + vmid, pasid_mapping);
 
 	timeout = jiffies + msecs_to_jiffies(10);
-	while (!(RREG32(SOC15_REG_OFFSET(ATHUB, 0,
+	while (!(RREG32(SOC15_REG_OFFSET(ATHUB, inst,
 			regATC_VMID_PASID_MAPPING_UPDATE_STATUS)) &
 			(1U << vmid))) {
 		if (time_after(jiffies, timeout)) {
@@ -61,13 +61,13 @@ static int kgd_gfx_v9_4_3_set_pasid_vmid_mapping(struct amdgpu_device *adev,
 		cpu_relax();
 	}
 
-	WREG32(SOC15_REG_OFFSET(ATHUB, 0,
+	WREG32(SOC15_REG_OFFSET(ATHUB, inst,
 		regATC_VMID_PASID_MAPPING_UPDATE_STATUS),
 		1U << vmid);
 
-	WREG32(SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT) + vmid,
+	WREG32(SOC15_REG_OFFSET(OSSSYS, inst, mmIH_VMID_0_LUT) + vmid,
 		pasid_mapping);
-	WREG32(SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT_MM) + vmid,
+	WREG32(SOC15_REG_OFFSET(OSSSYS, inst, mmIH_VMID_0_LUT_MM) + vmid,
 		pasid_mapping);
 
 	return 0;
@@ -81,7 +81,7 @@ static inline struct v9_mqd *get_mqd(void *mqd)
 static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t __user *wptr, uint32_t wptr_shift,
-			uint32_t wptr_mask, struct mm_struct *mm)
+			uint32_t wptr_mask, struct mm_struct *mm, uint32_t inst)
 {
 	struct v9_mqd *m;
 	uint32_t *mqd_hqd;
@@ -89,12 +89,12 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 	m = get_mqd(mqd);
 
-	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id);
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 
 	/* HQD registers extend to CP_HQD_AQL_DISPATCH_ID_HI */
 	mqd_hqd = &m->cp_mqd_base_addr_lo;
-	hqd_base = SOC15_REG_OFFSET(GC, 0, regCP_MQD_BASE_ADDR);
-	hqd_end = SOC15_REG_OFFSET(GC, 0, regCP_HQD_AQL_DISPATCH_ID_HI);
+	hqd_base = SOC15_REG_OFFSET(GC, inst, regCP_MQD_BASE_ADDR);
+	hqd_end = SOC15_REG_OFFSET(GC, inst, regCP_HQD_AQL_DISPATCH_ID_HI);
 
 	for (reg = hqd_base; reg <= hqd_end; reg++)
 		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
@@ -103,7 +103,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
+	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, regCP_HQD_PQ_DOORBELL_CONTROL),
 				data);
 
 	if (wptr) {
@@ -133,29 +133,29 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, regCP_HQD_PQ_WPTR_LO),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, regCP_HQD_PQ_WPTR_LO),
 		       lower_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, regCP_HQD_PQ_WPTR_HI),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, regCP_HQD_PQ_WPTR_HI),
 		       upper_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, regCP_HQD_PQ_WPTR_POLL_ADDR),
 		       lower_32_bits((uintptr_t)wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, 0,
+		WREG32_RLC(SOC15_REG_OFFSET(GC, inst,
 			regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
 			upper_32_bits((uintptr_t)wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, regCP_PQ_WPTR_POLL_CNTL1),
+		WREG32(SOC15_REG_OFFSET(GC, inst, regCP_PQ_WPTR_POLL_CNTL1),
 		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id,
 			       queue_id));
 	}
 
 	/* Start the EOP fetcher */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, regCP_HQD_EOP_RPTR),
+	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, regCP_HQD_EOP_RPTR),
 	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
 			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, regCP_HQD_ACTIVE), data);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, regCP_HQD_ACTIVE), data);
 
-	kgd_gfx_v9_release_queue(adev);
+	kgd_gfx_v9_release_queue(adev, inst);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index f599e1e74fcc..7b60268d93c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -79,7 +79,7 @@ static void kgd_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
 					uint32_t sh_mem_config,
 					uint32_t sh_mem_ape1_base,
 					uint32_t sh_mem_ape1_limit,
-					uint32_t sh_mem_bases)
+					uint32_t sh_mem_bases, uint32_t inst)
 {
 	lock_srbm(adev, 0, 0, 0, vmid);
 
@@ -91,7 +91,7 @@ static void kgd_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
 }
 
 static int kgd_set_pasid_vmid_mapping(struct amdgpu_device *adev, u32 pasid,
-					unsigned int vmid)
+					unsigned int vmid, uint32_t inst)
 {
 	/*
 	 * We have to assume that there is no outstanding mapping.
@@ -135,7 +135,8 @@ static int kgd_set_pasid_vmid_mapping(struct amdgpu_device *adev, u32 pasid,
  * but still works
  */
 
-static int kgd_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id)
+static int kgd_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id,
+				uint32_t inst)
 {
 	uint32_t mec;
 	uint32_t pipe;
@@ -205,7 +206,7 @@ static inline struct v10_sdma_mqd *get_sdma_mqd(void *mqd)
 static int kgd_hqd_load(struct amdgpu_device *adev, void *mqd,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t __user *wptr, uint32_t wptr_shift,
-			uint32_t wptr_mask, struct mm_struct *mm)
+			uint32_t wptr_mask, struct mm_struct *mm, uint32_t inst)
 {
 	struct v10_compute_mqd *m;
 	uint32_t *mqd_hqd;
@@ -286,7 +287,7 @@ static int kgd_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 static int kgd_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
-			    uint32_t doorbell_off)
+			    uint32_t doorbell_off, uint32_t inst)
 {
 	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 	struct v10_compute_mqd *m;
@@ -338,7 +339,7 @@ static int kgd_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 
 static int kgd_hqd_dump(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
-			uint32_t (**dump)[2], uint32_t *n_regs)
+			uint32_t (**dump)[2], uint32_t *n_regs, uint32_t inst)
 {
 	uint32_t i = 0, reg;
 #define HQD_N_REGS 56
@@ -469,7 +470,7 @@ static int kgd_hqd_sdma_dump(struct amdgpu_device *adev,
 
 static bool kgd_hqd_is_occupied(struct amdgpu_device *adev,
 				uint64_t queue_address, uint32_t pipe_id,
-				uint32_t queue_id)
+				uint32_t queue_id, uint32_t inst)
 {
 	uint32_t act;
 	bool retval = false;
@@ -510,7 +511,7 @@ static bool kgd_hqd_sdma_is_occupied(struct amdgpu_device *adev, void *mqd)
 static int kgd_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
-				uint32_t queue_id)
+				uint32_t queue_id, uint32_t inst)
 {
 	enum hqd_dequeue_request_type type;
 	unsigned long end_jiffies;
@@ -673,7 +674,7 @@ static bool get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
 
 static int kgd_wave_control_execute(struct amdgpu_device *adev,
 					uint32_t gfx_index_val,
-					uint32_t sq_cmd)
+					uint32_t sq_cmd, uint32_t inst)
 {
 	uint32_t data = 0;
 
@@ -709,7 +710,8 @@ static void set_vm_context_page_table_base(struct amdgpu_device *adev,
 }
 
 static void program_trap_handler_settings(struct amdgpu_device *adev,
-		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
+		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
+		uint32_t inst)
 {
 	lock_srbm(adev, 0, 0, 0, vmid);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 5c4152ae44da..52d0d35fb58d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -80,7 +80,7 @@ static void program_sh_mem_settings_v10_3(struct amdgpu_device *adev, uint32_t v
 					uint32_t sh_mem_config,
 					uint32_t sh_mem_ape1_base,
 					uint32_t sh_mem_ape1_limit,
-					uint32_t sh_mem_bases)
+					uint32_t sh_mem_bases, uint32_t inst)
 {
 	lock_srbm(adev, 0, 0, 0, vmid);
 
@@ -93,7 +93,7 @@ static void program_sh_mem_settings_v10_3(struct amdgpu_device *adev, uint32_t v
 
 /* ATC is defeatured on Sienna_Cichlid */
 static int set_pasid_vmid_mapping_v10_3(struct amdgpu_device *adev, unsigned int pasid,
-					unsigned int vmid)
+					unsigned int vmid, uint32_t inst)
 {
 	uint32_t value = pasid << IH_VMID_0_LUT__PASID__SHIFT;
 
@@ -105,7 +105,8 @@ static int set_pasid_vmid_mapping_v10_3(struct amdgpu_device *adev, unsigned int
 	return 0;
 }
 
-static int init_interrupts_v10_3(struct amdgpu_device *adev, uint32_t pipe_id)
+static int init_interrupts_v10_3(struct amdgpu_device *adev, uint32_t pipe_id,
+				uint32_t inst)
 {
 	uint32_t mec;
 	uint32_t pipe;
@@ -177,7 +178,7 @@ static inline struct v10_sdma_mqd *get_sdma_mqd(void *mqd)
 static int hqd_load_v10_3(struct amdgpu_device *adev, void *mqd,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t __user *wptr, uint32_t wptr_shift,
-			uint32_t wptr_mask, struct mm_struct *mm)
+			uint32_t wptr_mask, struct mm_struct *mm, uint32_t inst)
 {
 	struct v10_compute_mqd *m;
 	uint32_t *mqd_hqd;
@@ -273,7 +274,7 @@ static int hqd_load_v10_3(struct amdgpu_device *adev, void *mqd,
 
 static int hiq_mqd_load_v10_3(struct amdgpu_device *adev, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
-			    uint32_t doorbell_off)
+			    uint32_t doorbell_off, uint32_t inst)
 {
 	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 	struct v10_compute_mqd *m;
@@ -325,7 +326,7 @@ static int hiq_mqd_load_v10_3(struct amdgpu_device *adev, void *mqd,
 
 static int hqd_dump_v10_3(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
-			uint32_t (**dump)[2], uint32_t *n_regs)
+			uint32_t (**dump)[2], uint32_t *n_regs, uint32_t inst)
 {
 	uint32_t i = 0, reg;
 #define HQD_N_REGS 56
@@ -456,7 +457,7 @@ static int hqd_sdma_dump_v10_3(struct amdgpu_device *adev,
 
 static bool hqd_is_occupied_v10_3(struct amdgpu_device *adev,
 				uint64_t queue_address, uint32_t pipe_id,
-				uint32_t queue_id)
+				uint32_t queue_id, uint32_t inst)
 {
 	uint32_t act;
 	bool retval = false;
@@ -498,7 +499,7 @@ static bool hqd_sdma_is_occupied_v10_3(struct amdgpu_device *adev,
 static int hqd_destroy_v10_3(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
-				uint32_t queue_id)
+				uint32_t queue_id, uint32_t inst)
 {
 	enum hqd_dequeue_request_type type;
 	unsigned long end_jiffies;
@@ -586,7 +587,7 @@ static int hqd_sdma_destroy_v10_3(struct amdgpu_device *adev, void *mqd,
 
 static int wave_control_execute_v10_3(struct amdgpu_device *adev,
 					uint32_t gfx_index_val,
-					uint32_t sq_cmd)
+					uint32_t sq_cmd, uint32_t inst)
 {
 	uint32_t data = 0;
 
@@ -628,7 +629,8 @@ static void set_vm_context_page_table_base_v10_3(struct amdgpu_device *adev,
 }
 
 static void program_trap_handler_settings_v10_3(struct amdgpu_device *adev,
-			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
+			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
+			uint32_t inst)
 {
 	lock_srbm(adev, 0, 0, 0, vmid);
 
@@ -765,7 +767,7 @@ uint32_t set_wave_launch_mode_v10_3(struct amdgpu_device *adev,
  *	deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
  */
 void get_iq_wait_times_v10_3(struct amdgpu_device *adev,
-					uint32_t *wait_times)
+					uint32_t *wait_times, uint32_t inst)
 
 {
 	*wait_times = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2));
@@ -775,7 +777,8 @@ void build_grace_period_packet_info_v10_3(struct amdgpu_device *adev,
 						uint32_t wait_times,
 						uint32_t grace_period,
 						uint32_t *reg_offset,
-						uint32_t *reg_data)
+						uint32_t *reg_data,
+						uint32_t inst)
 {
 	*reg_data = wait_times;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 5cdb7289d35b..7deff8a547fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -78,7 +78,7 @@ static void program_sh_mem_settings_v11(struct amdgpu_device *adev, uint32_t vmi
 					uint32_t sh_mem_config,
 					uint32_t sh_mem_ape1_base,
 					uint32_t sh_mem_ape1_limit,
-					uint32_t sh_mem_bases)
+					uint32_t sh_mem_bases, uint32_t inst)
 {
 	lock_srbm(adev, 0, 0, 0, vmid);
 
@@ -89,7 +89,7 @@ static void program_sh_mem_settings_v11(struct amdgpu_device *adev, uint32_t vmi
 }
 
 static int set_pasid_vmid_mapping_v11(struct amdgpu_device *adev, unsigned int pasid,
-					unsigned int vmid)
+					unsigned int vmid, uint32_t inst)
 {
 	uint32_t value = pasid << IH_VMID_0_LUT__PASID__SHIFT;
 
@@ -101,7 +101,8 @@ static int set_pasid_vmid_mapping_v11(struct amdgpu_device *adev, unsigned int p
 	return 0;
 }
 
-static int init_interrupts_v11(struct amdgpu_device *adev, uint32_t pipe_id)
+static int init_interrupts_v11(struct amdgpu_device *adev, uint32_t pipe_id,
+				uint32_t inst)
 {
 	uint32_t mec;
 	uint32_t pipe;
@@ -162,7 +163,7 @@ static inline struct v11_sdma_mqd *get_sdma_mqd(void *mqd)
 static int hqd_load_v11(struct amdgpu_device *adev, void *mqd, uint32_t pipe_id,
 			uint32_t queue_id, uint32_t __user *wptr,
 			uint32_t wptr_shift, uint32_t wptr_mask,
-			struct mm_struct *mm)
+			struct mm_struct *mm, uint32_t inst)
 {
 	struct v11_compute_mqd *m;
 	uint32_t *mqd_hqd;
@@ -258,7 +259,7 @@ static int hqd_load_v11(struct amdgpu_device *adev, void *mqd, uint32_t pipe_id,
 
 static int hiq_mqd_load_v11(struct amdgpu_device *adev, void *mqd,
 			      uint32_t pipe_id, uint32_t queue_id,
-			      uint32_t doorbell_off)
+			      uint32_t doorbell_off, uint32_t inst)
 {
 	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
 	struct v11_compute_mqd *m;
@@ -310,7 +311,7 @@ static int hiq_mqd_load_v11(struct amdgpu_device *adev, void *mqd,
 
 static int hqd_dump_v11(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
-			uint32_t (**dump)[2], uint32_t *n_regs)
+			uint32_t (**dump)[2], uint32_t *n_regs, uint32_t inst)
 {
 	uint32_t i = 0, reg;
 #define HQD_N_REGS 56
@@ -445,7 +446,7 @@ static int hqd_sdma_dump_v11(struct amdgpu_device *adev,
 }
 
 static bool hqd_is_occupied_v11(struct amdgpu_device *adev, uint64_t queue_address,
-				uint32_t pipe_id, uint32_t queue_id)
+				uint32_t pipe_id, uint32_t queue_id, uint32_t inst)
 {
 	uint32_t act;
 	bool retval = false;
@@ -486,7 +487,7 @@ static bool hqd_sdma_is_occupied_v11(struct amdgpu_device *adev, void *mqd)
 static int hqd_destroy_v11(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
-				uint32_t queue_id)
+				uint32_t queue_id, uint32_t inst)
 {
 	enum hqd_dequeue_request_type type;
 	unsigned long end_jiffies;
@@ -571,7 +572,7 @@ static int hqd_sdma_destroy_v11(struct amdgpu_device *adev, void *mqd,
 
 static int wave_control_execute_v11(struct amdgpu_device *adev,
 					uint32_t gfx_index_val,
-					uint32_t sq_cmd)
+					uint32_t sq_cmd, uint32_t inst)
 {
 	uint32_t data = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index e83cb1c09610..6bf448ab3dff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -78,7 +78,7 @@ static void kgd_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
 					uint32_t sh_mem_config,
 					uint32_t sh_mem_ape1_base,
 					uint32_t sh_mem_ape1_limit,
-					uint32_t sh_mem_bases)
+					uint32_t sh_mem_bases, uint32_t inst)
 {
 	lock_srbm(adev, 0, 0, 0, vmid);
 
@@ -91,7 +91,7 @@ static void kgd_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
 }
 
 static int kgd_set_pasid_vmid_mapping(struct amdgpu_device *adev, u32 pasid,
-					unsigned int vmid)
+					unsigned int vmid, uint32_t inst)
 {
 	/*
 	 * We have to assume that there is no outstanding mapping.
@@ -114,7 +114,8 @@ static int kgd_set_pasid_vmid_mapping(struct amdgpu_device *adev, u32 pasid,
 	return 0;
 }
 
-static int kgd_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id)
+static int kgd_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id,
+				uint32_t inst)
 {
 	uint32_t mec;
 	uint32_t pipe;
@@ -158,7 +159,7 @@ static inline struct cik_sdma_rlc_registers *get_sdma_mqd(void *mqd)
 static int kgd_hqd_load(struct amdgpu_device *adev, void *mqd,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t __user *wptr, uint32_t wptr_shift,
-			uint32_t wptr_mask, struct mm_struct *mm)
+			uint32_t wptr_mask, struct mm_struct *mm, uint32_t inst)
 {
 	struct cik_mqd *m;
 	uint32_t *mqd_hqd;
@@ -202,7 +203,7 @@ static int kgd_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 static int kgd_hqd_dump(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
-			uint32_t (**dump)[2], uint32_t *n_regs)
+			uint32_t (**dump)[2], uint32_t *n_regs, uint32_t inst)
 {
 	uint32_t i = 0, reg;
 #define HQD_N_REGS (35+4)
@@ -318,7 +319,7 @@ static int kgd_hqd_sdma_dump(struct amdgpu_device *adev,
 
 static bool kgd_hqd_is_occupied(struct amdgpu_device *adev,
 				uint64_t queue_address, uint32_t pipe_id,
-				uint32_t queue_id)
+				uint32_t queue_id, uint32_t inst)
 {
 	uint32_t act;
 	bool retval = false;
@@ -358,7 +359,7 @@ static bool kgd_hqd_sdma_is_occupied(struct amdgpu_device *adev, void *mqd)
 static int kgd_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
-				uint32_t queue_id)
+				uint32_t queue_id, uint32_t inst)
 {
 	uint32_t temp;
 	enum hqd_dequeue_request_type type;
@@ -494,7 +495,7 @@ static int kgd_hqd_sdma_destroy(struct amdgpu_device *adev, void *mqd,
 
 static int kgd_wave_control_execute(struct amdgpu_device *adev,
 					uint32_t gfx_index_val,
-					uint32_t sq_cmd)
+					uint32_t sq_cmd, uint32_t inst)
 {
 	uint32_t data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index 870f352837fc..cd06e4a6d1da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -72,7 +72,7 @@ static void kgd_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
 					uint32_t sh_mem_config,
 					uint32_t sh_mem_ape1_base,
 					uint32_t sh_mem_ape1_limit,
-					uint32_t sh_mem_bases)
+					uint32_t sh_mem_bases, uint32_t inst)
 {
 	lock_srbm(adev, 0, 0, 0, vmid);
 
@@ -85,7 +85,7 @@ static void kgd_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
 }
 
 static int kgd_set_pasid_vmid_mapping(struct amdgpu_device *adev, u32 pasid,
-					unsigned int vmid)
+					unsigned int vmid, uint32_t inst)
 {
 	/*
 	 * We have to assume that there is no outstanding mapping.
@@ -109,7 +109,8 @@ static int kgd_set_pasid_vmid_mapping(struct amdgpu_device *adev, u32 pasid,
 	return 0;
 }
 
-static int kgd_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id)
+static int kgd_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id,
+				uint32_t inst)
 {
 	uint32_t mec;
 	uint32_t pipe;
@@ -153,7 +154,7 @@ static inline struct vi_sdma_mqd *get_sdma_mqd(void *mqd)
 static int kgd_hqd_load(struct amdgpu_device *adev, void *mqd,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t __user *wptr, uint32_t wptr_shift,
-			uint32_t wptr_mask, struct mm_struct *mm)
+			uint32_t wptr_mask, struct mm_struct *mm, uint32_t inst)
 {
 	struct vi_mqd *m;
 	uint32_t *mqd_hqd;
@@ -226,7 +227,7 @@ static int kgd_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 static int kgd_hqd_dump(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
-			uint32_t (**dump)[2], uint32_t *n_regs)
+			uint32_t (**dump)[2], uint32_t *n_regs, uint32_t inst)
 {
 	uint32_t i = 0, reg;
 #define HQD_N_REGS (54+4)
@@ -350,7 +351,7 @@ static int kgd_hqd_sdma_dump(struct amdgpu_device *adev,
 
 static bool kgd_hqd_is_occupied(struct amdgpu_device *adev,
 				uint64_t queue_address, uint32_t pipe_id,
-				uint32_t queue_id)
+				uint32_t queue_id, uint32_t inst)
 {
 	uint32_t act;
 	bool retval = false;
@@ -390,7 +391,7 @@ static bool kgd_hqd_sdma_is_occupied(struct amdgpu_device *adev, void *mqd)
 static int kgd_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
-				uint32_t queue_id)
+				uint32_t queue_id, uint32_t inst)
 {
 	uint32_t temp;
 	enum hqd_dequeue_request_type type;
@@ -540,7 +541,7 @@ static bool get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
 
 static int kgd_wave_control_execute(struct amdgpu_device *adev,
 					uint32_t gfx_index_val,
-					uint32_t sq_cmd)
+					uint32_t sq_cmd, uint32_t inst)
 {
 	uint32_t data = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index d36219ecd3dd..7918a00cbb5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -46,26 +46,26 @@ enum hqd_dequeue_request_type {
 	SAVE_WAVES
 };
 
-static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
-			uint32_t queue, uint32_t vmid)
+static void kgd_gfx_v9_lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
+			uint32_t queue, uint32_t vmid, uint32_t inst)
 {
 	mutex_lock(&adev->srbm_mutex);
-	soc15_grbm_select(adev, mec, pipe, queue, vmid, 0);
+	soc15_grbm_select(adev, mec, pipe, queue, vmid, inst);
 }
 
-static void unlock_srbm(struct amdgpu_device *adev)
+static void kgd_gfx_v9_unlock_srbm(struct amdgpu_device *adev, uint32_t inst)
 {
-	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+	soc15_grbm_select(adev, 0, 0, 0, 0, inst);
 	mutex_unlock(&adev->srbm_mutex);
 }
 
 void kgd_gfx_v9_acquire_queue(struct amdgpu_device *adev, uint32_t pipe_id,
-				uint32_t queue_id)
+				uint32_t queue_id, uint32_t inst)
 {
 	uint32_t mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
 	uint32_t pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
 
-	lock_srbm(adev, mec, pipe, queue_id, 0);
+	kgd_gfx_v9_lock_srbm(adev, mec, pipe, queue_id, 0, inst);
 }
 
 uint64_t kgd_gfx_v9_get_queue_mask(struct amdgpu_device *adev,
@@ -77,28 +77,28 @@ uint64_t kgd_gfx_v9_get_queue_mask(struct amdgpu_device *adev,
 	return 1ull << bit;
 }
 
-void kgd_gfx_v9_release_queue(struct amdgpu_device *adev)
+void kgd_gfx_v9_release_queue(struct amdgpu_device *adev, uint32_t inst)
 {
-	unlock_srbm(adev);
+	kgd_gfx_v9_unlock_srbm(adev, inst);
 }
 
 void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmid,
 					uint32_t sh_mem_config,
 					uint32_t sh_mem_ape1_base,
 					uint32_t sh_mem_ape1_limit,
-					uint32_t sh_mem_bases)
+					uint32_t sh_mem_bases, uint32_t inst)
 {
-	lock_srbm(adev, 0, 0, 0, vmid);
+	kgd_gfx_v9_lock_srbm(adev, 0, 0, 0, vmid, inst);
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmSH_MEM_CONFIG), sh_mem_config);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmSH_MEM_BASES), sh_mem_bases);
 	/* APE1 no longer exists on GFX9 */
 
-	unlock_srbm(adev);
+	kgd_gfx_v9_unlock_srbm(adev, inst);
 }
 
 int kgd_gfx_v9_set_pasid_vmid_mapping(struct amdgpu_device *adev, u32 pasid,
-					unsigned int vmid)
+					unsigned int vmid, uint32_t inst)
 {
 	/*
 	 * We have to assume that there is no outstanding mapping.
@@ -156,7 +156,8 @@ int kgd_gfx_v9_set_pasid_vmid_mapping(struct amdgpu_device *adev, u32 pasid,
  * but still works
  */
 
-int kgd_gfx_v9_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id)
+int kgd_gfx_v9_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id,
+				uint32_t inst)
 {
 	uint32_t mec;
 	uint32_t pipe;
@@ -164,13 +165,13 @@ int kgd_gfx_v9_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id)
 	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
 	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
 
-	lock_srbm(adev, mec, pipe, 0, 0);
+	kgd_gfx_v9_lock_srbm(adev, mec, pipe, 0, 0, inst);
 
-	WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,
+	WREG32_SOC15(GC, inst, mmCPC_INT_CNTL,
 		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
 		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
 
-	unlock_srbm(adev);
+	kgd_gfx_v9_unlock_srbm(adev, inst);
 
 	return 0;
 }
@@ -220,7 +221,8 @@ static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
 int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t __user *wptr, uint32_t wptr_shift,
-			uint32_t wptr_mask, struct mm_struct *mm)
+			uint32_t wptr_mask, struct mm_struct *mm,
+			uint32_t inst)
 {
 	struct v9_mqd *m;
 	uint32_t *mqd_hqd;
@@ -228,21 +230,22 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 	m = get_mqd(mqd);
 
-	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id);
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 
 	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_MEM. */
 	mqd_hqd = &m->cp_mqd_base_addr_lo;
-	hqd_base = SOC15_REG_OFFSET(GC, 0, mmCP_MQD_BASE_ADDR);
+	hqd_base = SOC15_REG_OFFSET(GC, inst, mmCP_MQD_BASE_ADDR);
 
 	for (reg = hqd_base;
-	     reg <= SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI); reg++)
+	     reg <= SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_WPTR_HI); reg++)
 		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL), data);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_DOORBELL_CONTROL),
+					data);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user
@@ -271,43 +274,43 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_LO),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_WPTR_LO),
 		       lower_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_WPTR_HI),
 		       upper_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_WPTR_POLL_ADDR),
 		       lower_32_bits((uintptr_t)wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
 		       upper_32_bits((uintptr_t)wptr));
 		WREG32_SOC15(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1,
 		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id));
 	}
 
 	/* Start the EOP fetcher */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_EOP_RPTR),
+	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_EOP_RPTR),
 	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
 			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE), data);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_ACTIVE), data);
 
-	kgd_gfx_v9_release_queue(adev);
+	kgd_gfx_v9_release_queue(adev, inst);
 
 	return 0;
 }
 
 int kgd_gfx_v9_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
-			    uint32_t doorbell_off)
+			    uint32_t doorbell_off, uint32_t inst)
 {
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[inst].ring;
 	struct v9_mqd *m;
 	uint32_t mec, pipe;
 	int r;
 
 	m = get_mqd(mqd);
 
-	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id);
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 
 	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
 	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
@@ -315,7 +318,7 @@ int kgd_gfx_v9_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
 		 mec, pipe, queue_id);
 
-	spin_lock(&adev->gfx.kiq[0].ring_lock);
+	spin_lock(&adev->gfx.kiq[inst].ring_lock);
 	r = amdgpu_ring_alloc(kiq_ring, 7);
 	if (r) {
 		pr_err("Failed to alloc KIQ (%d).\n", r);
@@ -342,15 +345,15 @@ int kgd_gfx_v9_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 	amdgpu_ring_commit(kiq_ring);
 
 out_unlock:
-	spin_unlock(&adev->gfx.kiq[0].ring_lock);
-	kgd_gfx_v9_release_queue(adev);
+	spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+	kgd_gfx_v9_release_queue(adev, inst);
 
 	return r;
 }
 
 int kgd_gfx_v9_hqd_dump(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
-			uint32_t (**dump)[2], uint32_t *n_regs)
+			uint32_t (**dump)[2], uint32_t *n_regs, uint32_t inst)
 {
 	uint32_t i = 0, reg;
 #define HQD_N_REGS 56
@@ -365,13 +368,13 @@ int kgd_gfx_v9_hqd_dump(struct amdgpu_device *adev,
 	if (*dump == NULL)
 		return -ENOMEM;
 
-	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id);
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 
-	for (reg = SOC15_REG_OFFSET(GC, 0, mmCP_MQD_BASE_ADDR);
-	     reg <= SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI); reg++)
+	for (reg = SOC15_REG_OFFSET(GC, inst, mmCP_MQD_BASE_ADDR);
+	     reg <= SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_WPTR_HI); reg++)
 		DUMP_REG(reg);
 
-	kgd_gfx_v9_release_queue(adev);
+	kgd_gfx_v9_release_queue(adev, inst);
 
 	WARN_ON_ONCE(i != HQD_N_REGS);
 	*n_regs = i;
@@ -481,23 +484,23 @@ static int kgd_hqd_sdma_dump(struct amdgpu_device *adev,
 
 bool kgd_gfx_v9_hqd_is_occupied(struct amdgpu_device *adev,
 				uint64_t queue_address, uint32_t pipe_id,
-				uint32_t queue_id)
+				uint32_t queue_id, uint32_t inst)
 {
 	uint32_t act;
 	bool retval = false;
 	uint32_t low, high;
 
-	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id);
-	act = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
+	act = RREG32_SOC15(GC, inst, mmCP_HQD_ACTIVE);
 	if (act) {
 		low = lower_32_bits(queue_address >> 8);
 		high = upper_32_bits(queue_address >> 8);
 
-		if (low == RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE) &&
-		   high == RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI))
+		if (low == RREG32_SOC15(GC, inst, mmCP_HQD_PQ_BASE) &&
+		   high == RREG32_SOC15(GC, inst, mmCP_HQD_PQ_BASE_HI))
 			retval = true;
 	}
-	kgd_gfx_v9_release_queue(adev);
+	kgd_gfx_v9_release_queue(adev, inst);
 	return retval;
 }
 
@@ -522,7 +525,7 @@ static bool kgd_hqd_sdma_is_occupied(struct amdgpu_device *adev, void *mqd)
 int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
-				uint32_t queue_id)
+				uint32_t queue_id, uint32_t inst)
 {
 	enum hqd_dequeue_request_type type;
 	unsigned long end_jiffies;
@@ -532,10 +535,10 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 	if (amdgpu_in_reset(adev))
 		return -EIO;
 
-	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id);
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 
 	if (m->cp_hqd_vmid == 0)
-		WREG32_FIELD15_RLC(GC, 0, RLC_CP_SCHEDULERS, scheduler1, 0);
+		WREG32_FIELD15_RLC(GC, inst, RLC_CP_SCHEDULERS, scheduler1, 0);
 
 	switch (reset_type) {
 	case KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN:
@@ -552,22 +555,22 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 		break;
 	}
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_DEQUEUE_REQUEST), type);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_DEQUEUE_REQUEST), type);
 
 	end_jiffies = (utimeout * HZ / 1000) + jiffies;
 	while (true) {
-		temp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
+		temp = RREG32_SOC15(GC, inst, mmCP_HQD_ACTIVE);
 		if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
 			break;
 		if (time_after(jiffies, end_jiffies)) {
 			pr_err("cp queue preemption time out.\n");
-			kgd_gfx_v9_release_queue(adev);
+			kgd_gfx_v9_release_queue(adev, inst);
 			return -ETIME;
 		}
 		usleep_range(500, 1000);
 	}
 
-	kgd_gfx_v9_release_queue(adev);
+	kgd_gfx_v9_release_queue(adev, inst);
 	return 0;
 }
 
@@ -624,14 +627,14 @@ bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
 
 int kgd_gfx_v9_wave_control_execute(struct amdgpu_device *adev,
 					uint32_t gfx_index_val,
-					uint32_t sq_cmd)
+					uint32_t sq_cmd, uint32_t inst)
 {
 	uint32_t data = 0;
 
 	mutex_lock(&adev->grbm_idx_mutex);
 
-	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, gfx_index_val);
-	WREG32_SOC15(GC, 0, mmSQ_CMD, sq_cmd);
+	WREG32_SOC15_RLC_SHADOW(GC, inst, mmGRBM_GFX_INDEX, gfx_index_val);
+	WREG32_SOC15(GC, inst, mmSQ_CMD, sq_cmd);
 
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
 		INSTANCE_BROADCAST_WRITES, 1);
@@ -640,7 +643,7 @@ int kgd_gfx_v9_wave_control_execute(struct amdgpu_device *adev,
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
 		SE_BROADCAST_WRITES, 1);
 
-	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, data);
+	WREG32_SOC15_RLC_SHADOW(GC, inst, mmGRBM_GFX_INDEX, data);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	return 0;
@@ -685,7 +688,7 @@ static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
  * is being collected
  */
 static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
-		int *wave_cnt, int *vmid)
+		int *wave_cnt, int *vmid, uint32_t inst)
 {
 	int pipe_idx;
 	int queue_slot;
@@ -700,12 +703,12 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
 	*wave_cnt = 0;
 	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
 	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
-	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, 0);
-	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, 0, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +
+	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, inst);
+	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +
 			 queue_slot);
 	*wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
 	if (*wave_cnt != 0)
-		*vmid = (RREG32_SOC15(GC, 0, mmCP_HQD_VMID) &
+		*vmid = (RREG32_SOC15(GC, inst, mmCP_HQD_VMID) &
 			 CP_HQD_VMID__VMID_MASK) >> CP_HQD_VMID__VMID__SHIFT;
 }
 
@@ -756,7 +759,7 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
  *  Reading registers referenced above involves programming GRBM appropriately
  */
 void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
-		int *pasid_wave_cnt, int *max_waves_per_cu)
+		int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst)
 {
 	int qidx;
 	int vmid;
@@ -772,7 +775,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 	DECLARE_BITMAP(cp_queue_bitmap, KGD_MAX_QUEUES);
 
 	lock_spi_csq_mutexes(adev);
-	soc15_grbm_select(adev, 1, 0, 0, 0, 0);
+	soc15_grbm_select(adev, 1, 0, 0, 0, inst);
 
 	/*
 	 * Iterate through the shader engines and arrays of the device
@@ -787,8 +790,8 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
 		for (sh_idx = 0; sh_idx < sh_cnt; sh_idx++) {
 
-			amdgpu_gfx_select_se_sh(adev, se_idx, sh_idx, 0xffffffff, 0);
-			queue_map = RREG32_SOC15(GC, 0, mmSPI_CSQ_WF_ACTIVE_STATUS);
+			amdgpu_gfx_select_se_sh(adev, se_idx, sh_idx, 0xffffffff, inst);
+			queue_map = RREG32_SOC15(GC, inst, mmSPI_CSQ_WF_ACTIVE_STATUS);
 
 			/*
 			 * Assumption: queue map encodes following schema: four
@@ -808,10 +811,11 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 					continue;
 
 				/* Get number of waves in flight and aggregate them */
-				get_wave_count(adev, qidx, &wave_cnt, &vmid);
+				get_wave_count(adev, qidx, &wave_cnt, &vmid,
+						inst);
 				if (wave_cnt != 0) {
 					pasid_tmp =
-					  RREG32(SOC15_REG_OFFSET(OSSSYS, 0,
+					  RREG32(SOC15_REG_OFFSET(OSSSYS, inst,
 						 mmIH_VMID_0_LUT) + vmid);
 					if (pasid_tmp == pasid)
 						vmid_wave_cnt += wave_cnt;
@@ -820,8 +824,8 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 		}
 	}
 
-	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
-	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, inst);
+	soc15_grbm_select(adev, 0, 0, 0, 0, inst);
 	unlock_spi_csq_mutexes(adev);
 
 	/* Update the output parameters and return */
@@ -831,27 +835,27 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 }
 
 void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
-                        uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
+		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr, uint32_t inst)
 {
-	lock_srbm(adev, 0, 0, 0, vmid);
+	kgd_gfx_v9_lock_srbm(adev, 0, 0, 0, vmid, inst);
 
 	/*
 	 * Program TBA registers
 	 */
-	WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
+	WREG32_SOC15(GC, inst, mmSQ_SHADER_TBA_LO,
                         lower_32_bits(tba_addr >> 8));
-	WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
+	WREG32_SOC15(GC, inst, mmSQ_SHADER_TBA_HI,
                         upper_32_bits(tba_addr >> 8));
 
 	/*
 	 * Program TMA registers
 	 */
-	WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
+	WREG32_SOC15(GC, inst, mmSQ_SHADER_TMA_LO,
 			lower_32_bits(tma_addr >> 8));
-	WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
+	WREG32_SOC15(GC, inst, mmSQ_SHADER_TMA_HI,
 			upper_32_bits(tma_addr >> 8));
 
-	unlock_srbm(adev);
+	kgd_gfx_v9_unlock_srbm(adev, inst);
 }
 
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 491273a02e30..a241299f4fbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -25,41 +25,42 @@
 void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmid,
 		uint32_t sh_mem_config,
 		uint32_t sh_mem_ape1_base, uint32_t sh_mem_ape1_limit,
-		uint32_t sh_mem_bases);
+		uint32_t sh_mem_bases, uint32_t inst);
 int kgd_gfx_v9_set_pasid_vmid_mapping(struct amdgpu_device *adev, u32 pasid,
-		unsigned int vmid);
-int kgd_gfx_v9_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id);
+		unsigned int vmid, uint32_t inst);
+int kgd_gfx_v9_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id,
+				uint32_t inst);
 int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd, uint32_t pipe_id,
 			uint32_t queue_id, uint32_t __user *wptr,
 			uint32_t wptr_shift, uint32_t wptr_mask,
-			struct mm_struct *mm);
+			struct mm_struct *mm, uint32_t inst);
 int kgd_gfx_v9_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
-			    uint32_t doorbell_off);
+			    uint32_t doorbell_off, uint32_t inst);
 int kgd_gfx_v9_hqd_dump(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
-			uint32_t (**dump)[2], uint32_t *n_regs);
+			uint32_t (**dump)[2], uint32_t *n_regs, uint32_t inst);
 bool kgd_gfx_v9_hqd_is_occupied(struct amdgpu_device *adev,
 			uint64_t queue_address, uint32_t pipe_id,
-			uint32_t queue_id);
+			uint32_t queue_id, uint32_t inst);
 int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
-				uint32_t queue_id);
+				uint32_t queue_id, uint32_t inst);
 int kgd_gfx_v9_wave_control_execute(struct amdgpu_device *adev,
 					uint32_t gfx_index_val,
-					uint32_t sq_cmd);
+					uint32_t sq_cmd, uint32_t inst);
 bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
 					uint8_t vmid, uint16_t *p_pasid);
-
 void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t page_table_base);
 void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
-		int *pasid_wave_cnt, int *max_waves_per_cu);
+		int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst);
 void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
-		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
+		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
+		uint32_t inst);
 void kgd_gfx_v9_acquire_queue(struct amdgpu_device *adev, uint32_t pipe_id,
-				uint32_t queue_id);
+				uint32_t queue_id, uint32_t inst);
 uint64_t kgd_gfx_v9_get_queue_mask(struct amdgpu_device *adev,
 				uint32_t pipe_id, uint32_t queue_id);
-void kgd_gfx_v9_release_queue(struct amdgpu_device *adev);
+void kgd_gfx_v9_release_queue(struct amdgpu_device *adev, uint32_t inst);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0f0a7d73fad3..a49ac19ca12e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -127,12 +127,16 @@ static inline uint64_t get_reserved_sdma_queues_bitmap(struct device_queue_manag
 void program_sh_mem_settings(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd)
 {
-	return dqm->dev->kfd2kgd->program_sh_mem_settings(
+	int xcc = 0;
+
+	for (xcc = 0; xcc < dqm->dev->num_xcc_per_node; xcc++)
+		dqm->dev->kfd2kgd->program_sh_mem_settings(
 						dqm->dev->adev, qpd->vmid,
 						qpd->sh_mem_config,
 						qpd->sh_mem_ape1_base,
 						qpd->sh_mem_ape1_limit,
-						qpd->sh_mem_bases);
+						qpd->sh_mem_bases,
+						dqm->dev->start_xcc_id + xcc);
 }
 
 static void kfd_hws_hang(struct device_queue_manager *dqm)
@@ -405,10 +409,14 @@ static void deallocate_doorbell(struct qcm_process_device *qpd,
 static void program_trap_handler_settings(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd)
 {
+	int xcc = 0;
+
 	if (dqm->dev->kfd2kgd->program_trap_handler_settings)
-		dqm->dev->kfd2kgd->program_trap_handler_settings(
+		for (xcc = 0; xcc < dqm->dev->num_xcc_per_node; xcc++)
+			dqm->dev->kfd2kgd->program_trap_handler_settings(
 						dqm->dev->adev, qpd->vmid,
-						qpd->tba_addr, qpd->tma_addr);
+						qpd->tba_addr, qpd->tma_addr,
+						dqm->dev->start_xcc_id + xcc);
 }
 
 static int allocate_vmid(struct device_queue_manager *dqm,
@@ -671,6 +679,7 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
 	struct kfd_process_device *pdd;
 	int first_vmid_to_scan = dev->vm_info.first_vmid_kfd;
 	int last_vmid_to_scan = dev->vm_info.last_vmid_kfd;
+	int xcc = 0;
 
 	reg_sq_cmd.u32All = 0;
 	reg_gfx_index.u32All = 0;
@@ -715,9 +724,11 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
 	reg_sq_cmd.bits.cmd = SQ_IND_CMD_CMD_KILL;
 	reg_sq_cmd.bits.vm_id = vmid;
 
-	dev->kfd2kgd->wave_control_execute(dev->adev,
+	for (xcc = 0; xcc < dev->num_xcc_per_node; xcc++)
+		dev->kfd2kgd->wave_control_execute(dev->adev,
 					reg_gfx_index.u32All,
-					reg_sq_cmd.u32All);
+					reg_sq_cmd.u32All,
+					dev->start_xcc_id + xcc);
 
 	return 0;
 }
@@ -1229,17 +1240,32 @@ static int
 set_pasid_vmid_mapping(struct device_queue_manager *dqm, u32 pasid,
 			unsigned int vmid)
 {
-	return dqm->dev->kfd2kgd->set_pasid_vmid_mapping(
-						dqm->dev->adev, pasid, vmid);
+	int xcc = 0, ret;
+
+	for (xcc = 0; xcc < dqm->dev->num_xcc_per_node; xcc++) {
+		ret = dqm->dev->kfd2kgd->set_pasid_vmid_mapping(
+						dqm->dev->adev, pasid, vmid,
+						dqm->dev->start_xcc_id + xcc);
+		if (ret)
+			break;
+	}
+
+	return ret;
 }
 
 static void init_interrupts(struct device_queue_manager *dqm)
 {
-	unsigned int i;
+	unsigned int i, xcc;
 
-	for (i = 0 ; i < get_pipes_per_mec(dqm) ; i++)
-		if (is_pipe_enabled(dqm, 0, i))
-			dqm->dev->kfd2kgd->init_interrupts(dqm->dev->adev, i);
+	for (i = 0 ; i < get_pipes_per_mec(dqm) ; i++) {
+		if (is_pipe_enabled(dqm, 0, i)) {
+			for (xcc = 0; xcc < dqm->dev->num_xcc_per_node; xcc++)
+				dqm->dev->kfd2kgd->init_interrupts(
+							dqm->dev->adev, i,
+							dqm->dev->start_xcc_id +
+							xcc);
+		}
+	}
 }
 
 static void init_sdma_bitmaps(struct device_queue_manager *dqm)
@@ -2455,44 +2481,49 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 	struct device_queue_manager *dqm = data;
 	uint32_t (*dump)[2], n_regs;
 	int pipe, queue;
-	int r = 0;
+	int r = 0, xcc;
+	uint32_t inst;
 
 	if (!dqm->sched_running) {
 		seq_puts(m, " Device is stopped\n");
 		return 0;
 	}
 
-	r = dqm->dev->kfd2kgd->hqd_dump(dqm->dev->adev,
+	for (xcc = 0; xcc < dqm->dev->num_xcc_per_node; xcc++) {
+		inst = dqm->dev->start_xcc_id + xcc;
+		r = dqm->dev->kfd2kgd->hqd_dump(dqm->dev->adev,
 					KFD_CIK_HIQ_PIPE, KFD_CIK_HIQ_QUEUE,
-					&dump, &n_regs);
-	if (!r) {
-		seq_printf(m, "  HIQ on MEC %d Pipe %d Queue %d\n",
-			   KFD_CIK_HIQ_PIPE/get_pipes_per_mec(dqm)+1,
-			   KFD_CIK_HIQ_PIPE%get_pipes_per_mec(dqm),
-			   KFD_CIK_HIQ_QUEUE);
-		seq_reg_dump(m, dump, n_regs);
+					&dump, &n_regs, inst);
+		if (!r) {
+			seq_printf(m,
+				"   Inst %d, HIQ on MEC %d Pipe %d Queue %d\n",
+				inst, KFD_CIK_HIQ_PIPE/get_pipes_per_mec(dqm)+1,
+				KFD_CIK_HIQ_PIPE%get_pipes_per_mec(dqm),
+				KFD_CIK_HIQ_QUEUE);
+			seq_reg_dump(m, dump, n_regs);
 
-		kfree(dump);
-	}
+			kfree(dump);
+		}
 
-	for (pipe = 0; pipe < get_pipes_per_mec(dqm); pipe++) {
-		int pipe_offset = pipe * get_queues_per_pipe(dqm);
+		for (pipe = 0; pipe < get_pipes_per_mec(dqm); pipe++) {
+			int pipe_offset = pipe * get_queues_per_pipe(dqm);
 
-		for (queue = 0; queue < get_queues_per_pipe(dqm); queue++) {
-			if (!test_bit(pipe_offset + queue,
+			for (queue = 0; queue < get_queues_per_pipe(dqm); queue++) {
+				if (!test_bit(pipe_offset + queue,
 				      dqm->dev->kfd->shared_resources.cp_queue_bitmap))
-				continue;
+					continue;
 
-			r = dqm->dev->kfd2kgd->hqd_dump(
-				dqm->dev->adev, pipe, queue, &dump, &n_regs);
-			if (r)
-				break;
+				r = dqm->dev->kfd2kgd->hqd_dump(
+					dqm->dev->adev, pipe, queue, &dump, &n_regs, inst);
+				if (r)
+					break;
 
-			seq_printf(m, "  CP Pipe %d, Queue %d\n",
-				  pipe, queue);
-			seq_reg_dump(m, dump, n_regs);
+				seq_printf(m, " Inst %d,  CP Pipe %d, Queue %d\n",
+					  inst, pipe, queue);
+				seq_reg_dump(m, dump, n_regs);
 
-			kfree(dump);
+				kfree(dump);
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 074f6075ccc7..d81125421aaf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -190,7 +190,7 @@ int kfd_hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
 		     struct queue_properties *p, struct mm_struct *mms)
 {
 	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd, pipe_id,
-					      queue_id, p->doorbell_off);
+					      queue_id, p->doorbell_off, 0);
 }
 
 int kfd_destroy_mqd_cp(struct mqd_manager *mm, void *mqd,
@@ -198,7 +198,7 @@ int kfd_destroy_mqd_cp(struct mqd_manager *mm, void *mqd,
 		uint32_t pipe_id, uint32_t queue_id)
 {
 	return mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, mqd, type, timeout,
-						pipe_id, queue_id);
+						pipe_id, queue_id, 0);
 }
 
 void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
@@ -217,7 +217,7 @@ bool kfd_is_occupied_cp(struct mqd_manager *mm, void *mqd,
 		 uint32_t queue_id)
 {
 	return mm->dev->kfd2kgd->hqd_is_occupied(mm->dev->adev, queue_address,
-						pipe_id, queue_id);
+						pipe_id, queue_id, 0);
 }
 
 int kfd_load_mqd_sdma(struct mqd_manager *mm, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index ca1966466759..eb11940bec34 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -167,7 +167,7 @@ static int load_mqd(struct mqd_manager *mm, void *mqd, uint32_t pipe_id,
 
 	return mm->dev->kfd2kgd->hqd_load(mm->dev->adev, mqd, pipe_id, queue_id,
 					  (uint32_t __user *)p->write_ptr,
-					  wptr_shift, wptr_mask, mms);
+					  wptr_shift, wptr_mask, mms, 0);
 }
 
 static void __update_mqd(struct mqd_manager *mm, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index c9565ea99df5..d54c6fdebbb6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -151,7 +151,7 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 
 	r = mm->dev->kfd2kgd->hqd_load(mm->dev->adev, mqd, pipe_id, queue_id,
 					  (uint32_t __user *)p->write_ptr,
-					  wptr_shift, 0, mms);
+					  wptr_shift, 0, mms, 0);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 65dba460d041..e7acde3a849b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -177,7 +177,7 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 
 	r = mm->dev->kfd2kgd->hqd_load(mm->dev->adev, mqd, pipe_id, queue_id,
 					  (uint32_t __user *)p->write_ptr,
-					  wptr_shift, 0, mms);
+					  wptr_shift, 0, mms, 0);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 6bfa9b9d75bd..89f8ba8a127c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -217,7 +217,7 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 
 	return mm->dev->kfd2kgd->hqd_load(mm->dev->adev, mqd, pipe_id, queue_id,
 					  (uint32_t __user *)p->write_ptr,
-					  wptr_shift, 0, mms);
+					  wptr_shift, 0, mms, 0);
 }
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
@@ -500,13 +500,15 @@ static int hiq_load_mqd_kiq_v9_4_3(struct mqd_manager *mm, void *mqd,
 {
 	int xcc, err;
 	void *xcc_mqd;
+	uint32_t start_inst = mm->dev->start_xcc_id;
 	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
 
 	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
 		xcc_mqd = mqd + hiq_mqd_size * xcc;
 		err = mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, xcc_mqd,
 						     pipe_id, queue_id,
-						     p->doorbell_off);
+						     p->doorbell_off,
+						     start_inst+xcc);
 		if (err) {
 			pr_debug("Failed to load HIQ MQD for XCC: %d\n", xcc);
 			break;
@@ -522,13 +524,14 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 {
 	int xcc = 0, err;
 	void *xcc_mqd;
+	uint32_t start_inst = mm->dev->start_xcc_id;
 	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
 
 	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
 		xcc_mqd = mqd + hiq_mqd_size * xcc;
 		err = mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, xcc_mqd,
 						    type, timeout, pipe_id,
-						    queue_id);
+						    queue_id, start_inst+xcc);
 		if (err) {
 			pr_debug("Destroy MQD failed for xcc: %d\n", xcc);
 			break;
@@ -640,6 +643,7 @@ static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 	void *xcc_mqd;
 	struct v9_mqd *m;
 	uint64_t mqd_offset;
+	uint32_t start_inst = mm->dev->start_xcc_id;
 
 	m = get_mqd(mqd);
 	mqd_offset = m->cp_mqd_stride_size;
@@ -648,7 +652,7 @@ static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		xcc_mqd = mqd + mqd_offset * xcc;
 		err = mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, xcc_mqd,
 						    type, timeout, pipe_id,
-						    queue_id);
+						    queue_id, start_inst+xcc);
 		if (err) {
 			pr_debug("Destroy MQD failed for xcc: %d\n", xcc);
 			break;
@@ -666,6 +670,7 @@ static int load_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
 	int xcc = 0, err;
 	void *xcc_mqd;
+	uint32_t start_inst = mm->dev->start_xcc_id;
 	uint64_t mqd_stride_size = mm->mqd_stride(mm, p);
 
 	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
@@ -673,7 +678,7 @@ static int load_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		err = mm->dev->kfd2kgd->hqd_load(mm->dev->adev, xcc_mqd,
 					 pipe_id, queue_id,
 					(uint32_t __user *)p->write_ptr,
-					wptr_shift, 0, mms);
+					wptr_shift, 0, mms, start_inst+xcc);
 		if (err) {
 			pr_debug("Load MQD failed for xcc: %d\n", xcc);
 			break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 8736a3cdbe1e..ebf963f42b51 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -165,7 +165,7 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 
 	return mm->dev->kfd2kgd->hqd_load(mm->dev->adev, mqd, pipe_id, queue_id,
 					  (uint32_t __user *)p->write_ptr,
-					  wptr_shift, wptr_mask, mms);
+					  wptr_shift, wptr_mask, mms, 0);
 }
 
 static void __update_mqd(struct mqd_manager *mm, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d96f7dadde0d..a56b8acc051c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -290,7 +290,7 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	wave_cnt = 0;
 	max_waves_per_cu = 0;
 	dev->kfd2kgd->get_cu_occupancy(dev->adev, proc->pasid, &wave_cnt,
-			&max_waves_per_cu);
+			&max_waves_per_cu, 0);
 
 	/* Translate wave count to number of compute units */
 	cu_cnt = (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 5cb3e8634739..8cb3dbcae3e4 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -230,28 +230,30 @@ struct kfd2kgd_calls {
 	/* Register access functions */
 	void (*program_sh_mem_settings)(struct amdgpu_device *adev, uint32_t vmid,
 			uint32_t sh_mem_config,	uint32_t sh_mem_ape1_base,
-			uint32_t sh_mem_ape1_limit, uint32_t sh_mem_bases);
+			uint32_t sh_mem_ape1_limit, uint32_t sh_mem_bases,
+			uint32_t inst);
 
 	int (*set_pasid_vmid_mapping)(struct amdgpu_device *adev, u32 pasid,
-					unsigned int vmid);
+					unsigned int vmid, uint32_t inst);
 
-	int (*init_interrupts)(struct amdgpu_device *adev, uint32_t pipe_id);
+	int (*init_interrupts)(struct amdgpu_device *adev, uint32_t pipe_id,
+			uint32_t inst);
 
 	int (*hqd_load)(struct amdgpu_device *adev, void *mqd, uint32_t pipe_id,
 			uint32_t queue_id, uint32_t __user *wptr,
 			uint32_t wptr_shift, uint32_t wptr_mask,
-			struct mm_struct *mm);
+			struct mm_struct *mm, uint32_t inst);
 
 	int (*hiq_mqd_load)(struct amdgpu_device *adev, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
-			    uint32_t doorbell_off);
+			    uint32_t doorbell_off, uint32_t inst);
 
 	int (*hqd_sdma_load)(struct amdgpu_device *adev, void *mqd,
 			     uint32_t __user *wptr, struct mm_struct *mm);
 
 	int (*hqd_dump)(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
-			uint32_t (**dump)[2], uint32_t *n_regs);
+			uint32_t (**dump)[2], uint32_t *n_regs, uint32_t inst);
 
 	int (*hqd_sdma_dump)(struct amdgpu_device *adev,
 			     uint32_t engine_id, uint32_t queue_id,
@@ -259,12 +261,12 @@ struct kfd2kgd_calls {
 
 	bool (*hqd_is_occupied)(struct amdgpu_device *adev,
 				uint64_t queue_address, uint32_t pipe_id,
-				uint32_t queue_id);
+				uint32_t queue_id, uint32_t inst);
 
 	int (*hqd_destroy)(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int timeout, uint32_t pipe_id,
-				uint32_t queue_id);
+				uint32_t queue_id, uint32_t inst);
 
 	bool (*hqd_sdma_is_occupied)(struct amdgpu_device *adev, void *mqd);
 
@@ -273,7 +275,7 @@ struct kfd2kgd_calls {
 
 	int (*wave_control_execute)(struct amdgpu_device *adev,
 					uint32_t gfx_index_val,
-					uint32_t sq_cmd);
+					uint32_t sq_cmd, uint32_t inst);
 	bool (*get_atc_vmid_pasid_mapping_info)(struct amdgpu_device *adev,
 					uint8_t vmid,
 					uint16_t *p_pasid);
@@ -290,9 +292,10 @@ struct kfd2kgd_calls {
 	uint32_t (*read_vmid_from_vmfault_reg)(struct amdgpu_device *adev);
 
 	void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
-			int *wave_cnt, int *max_waves_per_cu);
+			int *wave_cnt, int *max_waves_per_cu, uint32_t inst);
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
-			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
+			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
+			uint32_t inst);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.39.2

