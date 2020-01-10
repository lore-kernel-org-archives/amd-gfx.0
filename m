Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F17FC33C99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E0620721
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g/B6x+Yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E0620721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046316E995;
	Fri, 10 Jan 2020 06:37:48 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700075.outbound.protection.outlook.com [40.107.70.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D7B86E992
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 06:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRNUO2PSofklxalzgruASJgPa/FgIRkmPyufVnYtuVRCSe7S26blFjT1MXchCiQedh2DhXrDTgofAJxtDjrLEwzGkcpY8pnJxxLfqg9WEkAHkGC4ne7lMEN5Fr0qk6O6Dp8W+CBxyUffJQmDVSlH5nyEvZDSD6XVWOK+sve1fUBPOAn25GZLg2FyrM3Ax8j6jPzs21tVvSNTnasUcqCj/4R158jy46vHwVGZX/RIkbPUNuZ5IUrNKQ6ja0hHTmuNaEajnsyO7zc2K28BsnDKDLlJCLbzUyDDPGnoYGyxpWEFyZ60NvTPUCSL7CeCB06M+HWSpIxc53SpO6OrK4f8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPpQHMiu/eGjdGLgPpuZ5jwxlLHkC3ee21Ebc2RyA+I=;
 b=DKxXGCssW5xIp68J3qDlS7ftlUUVcynAayPR98+gWdNP5FpVtzKrQLjRVbPIQegYC3KPe54c58qt3UFCBoLe02NVBpb3crMzx7/lxhDyYi9Dpy7Zfl5Blr6kNxwmizi8t3vfdqVk1M+7Ia/zB2dtPIJ9IMr82GhUBGsSNRYxvGC79yR/LzngJRe3dLI+H6hTEkOgcYg/dQT1NfY29y8QvAH9O2dX6a0H1goTM/DOX3ffmikrYLBYZqGtIBXKD8XcpK4r1QXK2Mj2m/yntnGiU39CKXpmoOhdxNmcyPG5sZuG1EsN4edHtsd5Qsp9k5Xle7+y6PU3nahxjOeF5HERag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPpQHMiu/eGjdGLgPpuZ5jwxlLHkC3ee21Ebc2RyA+I=;
 b=g/B6x+Yo9V8bhSMondhBJvFIOnWveZqLJqLFRGAlei0Bz+40mDjUrwZKuR+qAQzSgbjSvI0FGiE8iCY6+ytaeJkax6WGeqRzwby4hzTKSlrBzn/XxA0b8mSGJKVGb2DY7BlxW0jiLa2SUIMdQ5ybcNzQHVKkAOA+xCAdwx9vaJA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB2974.namprd12.prod.outlook.com (20.178.240.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 06:37:44 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 06:37:44 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH 4/5] drm/amdkfd: use map_queues for hiq on gfx v10 as well
Date: Fri, 10 Jan 2020 14:37:12 +0800
Message-Id: <1578638233-9357-4-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
References: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from hr-intel.amd.com (180.167.199.188) by
 HK2PR03CA0045.apcprd03.prod.outlook.com (2603:1096:202:17::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2644.6 via Frontend Transport; Fri, 10 Jan 2020 06:37:42 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee4e96db-3642-42bb-0320-08d79597995a
X-MS-TrafficTypeDiagnostic: MN2PR12MB2974:|MN2PR12MB2974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2974CB0E54F4FB277A61E2E7EC380@MN2PR12MB2974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(199004)(189003)(51234002)(86362001)(54906003)(8676002)(66476007)(478600001)(66556008)(6486002)(8936002)(66946007)(6636002)(37006003)(81166006)(81156014)(316002)(2906002)(4326008)(956004)(26005)(6862004)(2616005)(7696005)(52116002)(186003)(6666004)(16526019)(36756003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2974;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcW+nY1lokmt/j/Wk96zfA0MzqNWYeN+HhIdHZf9MHQQnc0oXSyQBQXGT8hfdO4Dy/L4gNMyB7VplhVz8denRIp6hK+N+AsCGOF0sdzyAPolzP3Mj/u+uLTHIrAsO4znotzbfXWxGEzf9tjSyZpZ3Uu+ySXMfeUdK37Y1n/rKCoHXDtwNvx2esZq0cgH7oGFQ5TIL/wt00U9ttsNcLktuKleLtl3hfubz+RCq8pzChJk6nMB5Lvdpr2qd7swyyl582YF3KF4O+aha+1v5kV2TyRSUMhtuIgUYoYPM/lV0Gc6ViCgd5GdIcxqNmgkpNPq9PbOnlIMAeGfb9shVOD08q3Ci/iBASOS7hJSX/f19LArUxoM3/WsUn4UsKRhSrcpibIRFFX8bBL1DrW+GakZd3yYUlxe/46u62ha8oObpUEv1Q2LUw8oj7HNleYBoROJYj2SHADHeJCVlyzNiATBxsJ2EdemuSidFSR+w7ltsynkusdhTmtTEijLTNZy4//O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4e96db-3642-42bb-0320-08d79597995a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 06:37:44.3826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fV2Kh1b8l/bz1gpnW6kBkujRJhMhrP/p6PApXSBwEHRS0T8XGr+tsJDUtSBe0nRcRlS0qXa4PkK8mjyxPwaisg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2974
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To align with gfx v9, we use the map_queues packet to load hiq MQD.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 82 ++++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 10 ++-
 2 files changed, 70 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 61cd707..2a60f73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -107,13 +107,13 @@ static void acquire_queue(struct kgd_dev *kgd, uint32_t pipe_id,
 	lock_srbm(kgd, mec, pipe, queue_id, 0);
 }
 
-static uint32_t get_queue_mask(struct amdgpu_device *adev,
+static uint64_t get_queue_mask(struct amdgpu_device *adev,
 			       uint32_t pipe_id, uint32_t queue_id)
 {
-	unsigned int bit = (pipe_id * adev->gfx.mec.num_queue_per_pipe +
-			    queue_id) & 31;
+	unsigned int bit = pipe_id * adev->gfx.mec.num_queue_per_pipe +
+			queue_id;
 
-	return ((uint32_t)1) << bit;
+	return 1ull << bit;
 }
 
 static void release_queue(struct kgd_dev *kgd)
@@ -268,21 +268,6 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	pr_debug("Load hqd of pipe %d queue %d\n", pipe_id, queue_id);
 	acquire_queue(kgd, pipe_id, queue_id);
 
-	/* HIQ is set during driver init period with vmid set to 0*/
-	if (m->cp_hqd_vmid == 0) {
-		uint32_t value, mec, pipe;
-
-		mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
-		pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
-
-		pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
-			mec, pipe, queue_id);
-		value = RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CP_SCHEDULERS));
-		value = REG_SET_FIELD(value, RLC_CP_SCHEDULERS, scheduler1,
-			((mec << 5) | (pipe << 3) | queue_id | 0x80));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CP_SCHEDULERS), value);
-	}
-
 	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_MEM. */
 	mqd_hqd = &m->cp_mqd_base_addr_lo;
 	hqd_base = SOC15_REG_OFFSET(GC, 0, mmCP_MQD_BASE_ADDR);
@@ -332,9 +317,10 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 		       lower_32_bits((uint64_t)wptr));
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
 		       upper_32_bits((uint64_t)wptr));
-		pr_debug("%s setting CP_PQ_WPTR_POLL_CNTL1 to %x\n", __func__, get_queue_mask(adev, pipe_id, queue_id));
+		pr_debug("%s setting CP_PQ_WPTR_POLL_CNTL1 to %x\n", __func__,
+			 (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
-		       get_queue_mask(adev, pipe_id, queue_id));
+		       (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
 	}
 
 	/* Start the EOP fetcher */
@@ -350,6 +336,59 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	return 0;
 }
 
+static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
+			    uint32_t pipe_id, uint32_t queue_id,
+			    uint32_t doorbell_off)
+{
+	struct amdgpu_device *adev = get_amdgpu_device(kgd);
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct v10_compute_mqd *m;
+	uint32_t mec, pipe;
+	int r;
+
+	m = get_mqd(mqd);
+
+	acquire_queue(kgd, pipe_id, queue_id);
+
+	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
+	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
+
+	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
+		 mec, pipe, queue_id);
+
+	spin_lock(&adev->gfx.kiq.ring_lock);
+	r = amdgpu_ring_alloc(kiq_ring, 7);
+	if (r) {
+		pr_err("Failed to alloc KIQ (%d).\n", r);
+		goto out_unlock;
+	}
+
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
+	amdgpu_ring_write(kiq_ring,
+			  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
+			  PACKET3_MAP_QUEUES_VMID(m->cp_hqd_vmid) | /* VMID */
+			  PACKET3_MAP_QUEUES_QUEUE(queue_id) |
+			  PACKET3_MAP_QUEUES_PIPE(pipe) |
+			  PACKET3_MAP_QUEUES_ME((mec - 1)) |
+			  PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type: normal compute queue */
+			  PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) | /* alloc format: all_on_one_pipe */
+			  PACKET3_MAP_QUEUES_ENGINE_SEL(1) | /* engine_sel: hiq */
+			  PACKET3_MAP_QUEUES_NUM_QUEUES(1)); /* num_queues: must be 1 */
+	amdgpu_ring_write(kiq_ring,
+			  PACKET3_MAP_QUEUES_DOORBELL_OFFSET(doorbell_off));
+	amdgpu_ring_write(kiq_ring, m->cp_mqd_base_addr_lo);
+	amdgpu_ring_write(kiq_ring, m->cp_mqd_base_addr_hi);
+	amdgpu_ring_write(kiq_ring, m->cp_hqd_pq_wptr_poll_addr_lo);
+	amdgpu_ring_write(kiq_ring, m->cp_hqd_pq_wptr_poll_addr_hi);
+	amdgpu_ring_commit(kiq_ring);
+
+out_unlock:
+	spin_unlock(&adev->gfx.kiq.ring_lock);
+	release_queue(kgd);
+
+	return r;
+}
+
 static int kgd_hqd_dump(struct kgd_dev *kgd,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t (**dump)[2], uint32_t *n_regs)
@@ -817,6 +856,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
 	.init_interrupts = kgd_init_interrupts,
 	.hqd_load = kgd_hqd_load,
+	.hiq_mqd_load = kgd_hiq_mqd_load,
 	.hqd_sdma_load = kgd_hqd_sdma_load,
 	.hqd_dump = kgd_hqd_dump,
 	.hqd_sdma_dump = kgd_hqd_sdma_dump,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 7832ec6..d1d68a5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -153,6 +153,14 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 	return r;
 }
 
+static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
+			    uint32_t pipe_id, uint32_t queue_id,
+			    struct queue_properties *p, struct mm_struct *mms)
+{
+	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->kgd, mqd, pipe_id,
+					      queue_id, p->doorbell_off);
+}
+
 static void update_mqd(struct mqd_manager *mm, void *mqd,
 		      struct queue_properties *q)
 {
@@ -409,7 +417,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 		mqd->allocate_mqd = allocate_hiq_mqd;
 		mqd->init_mqd = init_mqd_hiq;
 		mqd->free_mqd = free_mqd_hiq_sdma;
-		mqd->load_mqd = load_mqd;
+		mqd->load_mqd = hiq_load_mqd_kiq;
 		mqd->update_mqd = update_mqd;
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
