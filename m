Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897F6C761A6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 15:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2357B10E9FF;
	Wed,  5 Apr 2023 15:42:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8870910E9FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 15:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esS3crQos0QypOu2mY2zPrCYNfHYPveemETwbmuCuTNKgNKUDYqcwq/YFRDmfMnSLkMyfQpvaE9b5rz9ptam6glInq4BVPs0jz3WQW4s/FYmiXnJczXIMXV/mi8UCw05EDi6UERTF40okXe/dGiwLfzSy98dkBID4ToSyn4gkgvuglzNgh9sOX9/Y04g2tuBEMyecLUlZJfkY430x5PDYCZWt3h0NDcrMoESXSPMgLXg0dx7z3VZNCYLPYqu2eQN0YQAaKr5agCx8moJqlHzojbVenwrnHv3WyaYscasRmBNwiuZYDFzU1Q77HaNdk4lhUEoiWKXM8/WQEJL/ns/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vWMGAxVrFmTuSUmFSqYAE2D13rVaLDunc9lLBkxwvQ=;
 b=EMJiKUWhXrTQMUsPER+wZIBPJSF1QxsSfXaVSmru75tDULFCzeh23R7YNzUDssoun0ERUV8FBRrbYCesMRZVAq1EJHwB9hmTSRDH8TeIlHuMf5V6bOvsNYvHYevpwvUNsIDiHaLPpfY5vjyQ6B93Bb3O/Lk0UATcjrooeAM2/FzteQZHsz4o/D0xahN8t0UczTYkWEvx4ff/Bqth5QyX+X62bfv4yad54CPPCc6WGjI7IegUNa0DkzkS89Q81tfzey4sRmuiTwRv6wqSMGUyoa72TB+smo5/n6cHHZMdWyVi0VsWWiqgIynXqJxjFPJ5bGkkFjspaMbaqJzzoxDlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vWMGAxVrFmTuSUmFSqYAE2D13rVaLDunc9lLBkxwvQ=;
 b=xZVJYFWOz1Cy/AYhcenr6PX6wNry7DDDi9qbrP83hHgnmOhT2j03MhNyvhnL68OsxLjD8vLKjvjWU1LLivhzf/GAFcB1HU+HgaAYbgj1N/QmXFPK4RIiWtEkfBHr/zYBaoWV9rA+Y8MYNi13ABmrg5WkeCefGklNgtyt6/n6S/4=
Received: from MW4PR04CA0113.namprd04.prod.outlook.com (2603:10b6:303:83::28)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.29; Wed, 5 Apr
 2023 15:42:23 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::21) by MW4PR04CA0113.outlook.office365.com
 (2603:10b6:303:83::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Wed, 5 Apr 2023 15:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.30 via Frontend Transport; Wed, 5 Apr 2023 15:42:23 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 10:42:22 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable GFX11 SDMA context empty interrupt
Date: Wed, 5 Apr 2023 11:42:03 -0400
Message-ID: <20230405154203.3899014-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1008ba-a351-4c51-048d-08db35ec596d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YtEspG1YzQIEndRCpgDKlpuyecL7NTlzMLC+3ixe8+SDN9tToxb+1oXn9Dp89Njue2YM7nWlyytfxIdBng2CfUI3YPutkHRc20Ajcnt3LeoJ1s5mLqtPw/rUsiedxIiJGzLrgdMkhJXdlTn1YC8rjbFFOJXSmaWhs1IH8db7cKKNnzIqXRVwntoyL2TY9RSVXrqjwFxzUaEiAL++f0339DGZBn01E+e7GUpz8aUA7J34Y+JbtmSRB6TXyfrIlXTy7IKHtqs73S7QcfzHFtjZswPugkMlkUwAYpjLBV2MF7fCD69FQMuolXOLwIGIROXDxMqdTavqR+EPrP8RfBUayGwtFKzHRrpXffABAy22MsL6DYvNryu70uV1rWvkUINTMX8WHLgc5ZfdE4m7PTwPvHJB+9m4Yb3/+YbN/gBecfrbaoEareiL+wknRkNA6wU3wLwCyZKzPLorGQy1ELlqV/aw2QZxAGHiNDpjg2NddtIJGa5tEwKbStVwBIJ5rc+JF/jFoheIGegLO7T2xW1lbq5orsAkRx7rnj5T72CWs1ZJBQASuTXu8eHTQE+ox0XMhQKrynDveY+MsH855rmDXl2p8T1l2JSZq+ucDb/LKwnXyu01RQVXFeS+UsntUxGKGQn5rklY8IW0ZMjxbWeng5wtAN4shxTa6ha4Lz6ohDRSHrRaU7ywAmEjPBXcOCiuEJcJc+K1SYAr9sMpSRNE4XNu9weZBoGq88/s9+Gonh8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(316002)(6666004)(2616005)(40460700003)(356005)(81166007)(36756003)(82740400003)(2906002)(40480700001)(5660300002)(8936002)(47076005)(82310400005)(41300700001)(8676002)(4326008)(70206006)(70586007)(86362001)(426003)(336012)(83380400001)(6916009)(36860700001)(1076003)(54906003)(7696005)(26005)(16526019)(186003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 15:42:23.0365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1008ba-a351-4c51-048d-08db35ec596d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
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
Cc: Stanley.Yang@amd.com, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable SDMA queue empty context switching. SDMA context switch due to
quantum programming no longer done here (as of sdma v6), so re-name
sdma_v6_0_ctx_switch_enable to sdma_v6_0_ctxempty_int_enable to reflect
this.

Also program SDMAx_QUEUEx_SCHEDULE_CNTL for context switch due to
quantum in KFD. Set to amdgpu_sdma_phase_quantum (defaults to 32 i.e.
3200us).

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 28 ++++++++++++-------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  4 +++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 40e6b22daa22..f45f7469dd32 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -403,15 +403,26 @@ static void sdma_v6_0_rlc_stop(struct amdgpu_device *adev)
 }
 
 /**
- * sdma_v6_0_ctx_switch_enable - stop the async dma engines context switch
+ * sdma_v6_0_ctxempty_int_enable - enable or disable context empty interrupts
  *
  * @adev: amdgpu_device pointer
- * @enable: enable/disable the DMA MEs context switch.
+ * @enable: enable/disable context switching due to queue empty conditions
  *
- * Halt or unhalt the async dma engines context switch.
+ * Enable or disable the async dma engines queue empty context switch.
  */
-static void sdma_v6_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
+static void sdma_v6_0_ctxempty_int_enable(struct amdgpu_device *adev, bool enable)
 {
+	u32 f32_cntl;
+	int i;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			f32_cntl = RREG32(sdma_v6_0_get_reg_offset(adev, i, regSDMA0_CNTL));
+			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+					CTXEMPTY_INT_ENABLE, enable ? 1 : 0);
+			WREG32(sdma_v6_0_get_reg_offset(adev, i, regSDMA0_CNTL), f32_cntl);
+		}
+	}
 }
 
 /**
@@ -579,10 +590,8 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 
 		ring->sched.ready = true;
 
-		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
-			sdma_v6_0_ctx_switch_enable(adev, true);
+		if (amdgpu_sriov_vf(adev))
 			sdma_v6_0_enable(adev, true);
-		}
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r) {
@@ -778,7 +787,6 @@ static int sdma_v6_0_start(struct amdgpu_device *adev)
 	int r = 0;
 
 	if (amdgpu_sriov_vf(adev)) {
-		sdma_v6_0_ctx_switch_enable(adev, false);
 		sdma_v6_0_enable(adev, false);
 
 		/* set RB registers */
@@ -799,7 +807,7 @@ static int sdma_v6_0_start(struct amdgpu_device *adev)
 	/* unhalt the MEs */
 	sdma_v6_0_enable(adev, true);
 	/* enable sdma ring preemption */
-	sdma_v6_0_ctx_switch_enable(adev, true);
+	sdma_v6_0_ctxempty_int_enable(adev, true);
 
 	/* start the gfx rings and rlc compute queues */
 	r = sdma_v6_0_gfx_resume(adev);
@@ -1319,7 +1327,7 @@ static int sdma_v6_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	sdma_v6_0_ctx_switch_enable(adev, false);
+	sdma_v6_0_ctxempty_int_enable(adev, false);
 	sdma_v6_0_enable(adev, false);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 4a9af800b1f1..85d5782eccd2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -350,6 +350,10 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdmax_rlcx_doorbell_offset =
 		q->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
 
+	m->sdmax_rlcx_sched_cntl = (amdgpu_sdma_phase_quantum
+		<< SDMA0_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT)
+		 & SDMA0_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK;
+
 	m->sdma_engine_id = q->sdma_engine_id;
 	m->sdma_queue_id = q->sdma_queue_id;
 	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
-- 
2.25.1

