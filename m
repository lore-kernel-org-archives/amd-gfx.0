Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C643C33CA4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123FB2077B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v59TR3vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123FB2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B9BE6E990;
	Fri, 10 Jan 2020 06:37:43 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700052.outbound.protection.outlook.com [40.107.70.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B50A36E98F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 06:37:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/yQlbIDnWVs/5MMP90zCtHakxE36V9ZfdiDd7cHyirpWWx31LIkpP173dMGLdydg/HT2pSSBC/UXtHY3URl5fVlpUM1WcQbjLJetk52rrsOP0QHoHsxESwx2ArZx49PxFDUOte8JHhI1kzZ+FsTcTpCoCc4Q6CTviQ9eMCp30MplZitkqK/WwTKD+pns6cW66sqlYUb22dwOVucaMbTWRctFLU18t0iQjHKm3ieGTnwthsq6Y/KPvuEf3XB4E+NSQ4I8KJCRWTG+9U9/PbJVEdtyFJIEJnqwq5GwnDXT8KQHJizevDSR9fRBc2lBUuclnUcZsXfwZcOMLxwbUGx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3nXm3aWEKXOMAyiq2Z9MVGmd+z1F6/7qPE2yQWYUF4=;
 b=Lf3OJtj9/Jpynk+O09yrHrOmlHXF2IC08ZWWaQYD93W02WwQEW4+abBTkQzQbc0El5BEH1Ne5t2ozwCjKYEK418yQ5cBWLknpdFWm5h6SeNPun150BNKTKfAkTGNga00sptRQYFPWpaa/4t6dlbJu865jEVwz4L6O+h/Fvevlg/x6lETO1SIVPxtYqQLwAvf5auOwsJAqkKG8WLq9GmwsvcWW5B6TqNQR6giQFmkTc+Oirv6AOEaGLHEQEI4FuAod3tteNPYLZXGUs07akGj6NLyqtSvATRves93x/6xZe8I2FIH0TbBkcy4jbeMG5hkuWFhoK00wK34WY2vg4ayRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3nXm3aWEKXOMAyiq2Z9MVGmd+z1F6/7qPE2yQWYUF4=;
 b=v59TR3vh/pACWI9xqkEqCueZ4daG4Q6fUqN3ov6/CwsfBFLdc6yYroV/k56PGq3Z8UYC14CAMQxVWPWx1ysLOB/+2HlxaDJV0/hiyr3KQ48C4ckF/3o+427jwvqcgDdD2rIqDJjIbZWvrsw9xFYlSjitUNmLc6iBWrTtf3ZAdA0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB2974.namprd12.prod.outlook.com (20.178.240.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 06:37:40 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 06:37:39 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH 2/5] drm/amdkfd: use kiq to load the mqd of hiq queue for gfx
 v9 (v5)
Date: Fri, 10 Jan 2020 14:37:10 +0800
Message-Id: <1578638233-9357-2-git-send-email-ray.huang@amd.com>
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
 15.20.2644.6 via Frontend Transport; Fri, 10 Jan 2020 06:37:37 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c0dc3a4-cb91-4794-f6ca-08d795979693
X-MS-TrafficTypeDiagnostic: MN2PR12MB2974:|MN2PR12MB2974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2974F40058D919093A01C7DEEC380@MN2PR12MB2974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:295;
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
X-Microsoft-Antispam-Message-Info: zoO03JL75DvLIJVvGGNk18hh7Hp44uPYv1WP9Nyzye5fmd2QaI3uUrypaq0X84Vj6lcrAS7preYTVAx8bBpZ3WYFUy+Xad/cbYe29UjzUlS1Ebn8WHWY8kGZvvcEee6ZIpVi8mU+gYPD93zq3ag0v74xsLUKPQuT43jodefPWijFObvVum/Ns9HToGo7HhwfrfYii92LEunNc2WkwN7XgMcAhreTz2JyroVBTSlFd4jStTHOv2X0BAX5HXJuFEl02sOe5v+tG7UQ0LWii/Zf5dq+yRQQ8cTZD4IAGN1AapfuSufb+nT/74T5jkdUfVDhEHc1wK0Yu1dBb5RfOBuypaCrJQVIR9E+PEPasKxROTzowmu1/SgTjfhQ9OVLwL1llbWcte26Y1KgnvIL95kxrdKe1GLgm8zUBofl3n2cQdnxP8zqEj6TbdGeuwWXqcy7njbe/eHwWMe1BUdevNbt6wKH01tVjoqiOKIE+bOn93lHHH5pCdDyTYLjirPDR82s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0dc3a4-cb91-4794-f6ca-08d795979693
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 06:37:39.8882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3sHfsonXfOy7xErxGVlAiqpPkvIEOCwd+8W2rN1qOPGFO14v9eZ84xU2U/FF+ic22DKJt3DLXeLYnGugc8JRw==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

There is an issue that CP will check the HIQ queue to be configured and mapped
with KIQ ring, otherwise, it will be unable to read back the secure buffer while
the gfxoff is enabled even with trusted IP blocks.

v1 -> v2:
- Fix to remove surplus set_resources packets.
- Fill the whole configuration in MQD.
- Change the author as Aaron because he addressed the key point of this issue.
- Add kiq ring lock.

v2 -> v3:
- Free the lock while in error return case.
- Remove the programming only needed by the queue is unmapped.

v3 -> v4:
- Remove doorbell programming because it's used for restarting queue.
- Remove CP scheduler programming because map_queue packet will handle this.

v4 -> v5:
- Remove cp_hqd_active because mec ucode will enable it while use map_queues.
- Revise goto out_unlock.
- Correct the right doorbell offset for HIQ that kfd driver assigned in the
  packet.

Reported-by: Lisa Saturday <Lisa.Saturday@amd.com>
Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-and-Tested-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 79 +++++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 10 ++-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h   |  4 ++
 3 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index e7861f0..ab8c23a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -103,13 +103,13 @@ static void acquire_queue(struct kgd_dev *kgd, uint32_t pipe_id,
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
@@ -258,21 +258,6 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 
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
-		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmRLC_CP_SCHEDULERS), value);
-	}
-
 	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_MEM. */
 	mqd_hqd = &m->cp_mqd_base_addr_lo;
 	hqd_base = SOC15_REG_OFFSET(GC, 0, mmCP_MQD_BASE_ADDR);
@@ -323,7 +308,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
 		       upper_32_bits((uintptr_t)wptr));
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
-		       get_queue_mask(adev, pipe_id, queue_id));
+		       (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
 	}
 
 	/* Start the EOP fetcher */
@@ -339,6 +324,59 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	return 0;
 }
 
+static int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
+				   uint32_t pipe_id, uint32_t queue_id,
+				   uint32_t doorbell_off)
+{
+	struct amdgpu_device *adev = get_amdgpu_device(kgd);
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct v9_mqd *m;
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
 int kgd_gfx_v9_hqd_dump(struct kgd_dev *kgd,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t (**dump)[2], uint32_t *n_regs)
@@ -778,6 +816,7 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
 	.init_interrupts = kgd_gfx_v9_init_interrupts,
 	.hqd_load = kgd_gfx_v9_hqd_load,
+	.hiq_mqd_load = kgd_gfx_v9_hiq_mqd_load,
 	.hqd_sdma_load = kgd_hqd_sdma_load,
 	.hqd_dump = kgd_gfx_v9_hqd_dump,
 	.hqd_sdma_dump = kgd_hqd_sdma_dump,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index aa90109..436b7f5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -191,6 +191,14 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 					  wptr_shift, 0, mms);
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
@@ -449,7 +457,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->allocate_mqd = allocate_hiq_mqd;
 		mqd->init_mqd = init_mqd_hiq;
 		mqd->free_mqd = free_mqd_hiq_sdma;
-		mqd->load_mqd = load_mqd;
+		mqd->load_mqd = hiq_load_mqd_kiq;
 		mqd->update_mqd = update_mqd;
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 2cd217e..e3831e6 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -256,6 +256,10 @@ struct kfd2kgd_calls {
 			uint32_t wptr_shift, uint32_t wptr_mask,
 			struct mm_struct *mm);
 
+	int (*hiq_mqd_load)(struct kgd_dev *kgd, void *mqd,
+			    uint32_t pipe_id, uint32_t queue_id,
+			    uint32_t doorbell_off);
+
 	int (*hqd_sdma_load)(struct kgd_dev *kgd, void *mqd,
 			     uint32_t __user *wptr, struct mm_struct *mm);
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
