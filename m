Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD3BC33CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955D520721
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N4//Nj45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955D520721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F326E996;
	Fri, 10 Jan 2020 06:37:49 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700052.outbound.protection.outlook.com [40.107.70.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8ED06E992
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 06:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5aHkseqbNTCPeQ40F5HEwp5KYag9tiw/+ZCjdCi55gytJqLj9rPCXFlkMQZpJGPk4PA5NEjIqc+qp1h6q1dFalrZwfhbNr9yCw4fbl4IRbljeEmqN3MwWrrmNm6DHpz9zsGQ/gniobWNpc9yPRvgJNRqR1nNalTFtvbsgR8mfCO9/g09FMryooJMWFh38g6CyfhH9B2Wt0hyIzOiSBSVZWzQOQCt2HaauEHR76IeWiEP6yRQZCPvEw70qiFvwWIxUroNNQnx1dH4DDVqukpBFAjHbnmDAnRHX5aNgmPT0zAo0PgHoizX8LdlgYWhJglAcq2i3JyQ64i1t0nE5aKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZREjB+7aI0RU7KlnLWgnviaI8KCCmOBCEvVg83pqoY=;
 b=BeVWhdP9AwtBT0LTnJ3+el0jK6QiJ/a6m3ESFP0yagoSfPqOoCEoce//Aqy0DHsIiS41cjG7CqQ4S/WQt7dpptUem/pMKqeFoA21+uy+9yTrjaisgQvODY7m/QV4Y+r+D3dMuEgSVhsStdhNWtAX9FGLoKExBNZPXmVYxOgD58ecVsy1a0gLeORBVfHHWKzZUbGO6/ODW83x+kPlrlgC63+NuBr76HMBGu9yhqUcpZqfM5+3wYa8Zxo5MOMm/bUiyM62vU1m6Bw8LAVCvSfdwshynJGWoTd0AJnEnAdEhFlL8beiaB/IqqGow600VK1/ygOhn+q6LTs0yzOvXI+x8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZREjB+7aI0RU7KlnLWgnviaI8KCCmOBCEvVg83pqoY=;
 b=N4//Nj45wa/aD0YCF+lUDYVi3K7A7rEeXCifI/AvyC9U3ngZ1NLYnB6I7oZaUOjevSnmVydRBHe4h/XUosieNrzm+vjFfpRraHCKOEOk61jjCo3Q4hLQx16r/WToG7Zpw7E+2YK0QUPtUI6InRS0vWxWGHxF1cdAeEtkGyIqs3c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB2974.namprd12.prod.outlook.com (20.178.240.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 06:37:46 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 06:37:46 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH 5/5] drm/amdkfd: use map_queues for hiq on gfx v8 as well
Date: Fri, 10 Jan 2020 14:37:13 +0800
Message-Id: <1578638233-9357-5-git-send-email-ray.huang@amd.com>
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
 15.20.2644.6 via Frontend Transport; Fri, 10 Jan 2020 06:37:44 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2353583-65d8-447d-a230-08d795979aad
X-MS-TrafficTypeDiagnostic: MN2PR12MB2974:|MN2PR12MB2974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2974CF8728D84C4485EB5001EC380@MN2PR12MB2974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
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
X-Microsoft-Antispam-Message-Info: JXO3aUjXpTQO78hQiYdNIU8JaR+wN04HXKDz1j7Gmuz98nfeozsYBBfGhuABUe8yXssdXQ11AByxNE1REoOiO6/72xCXLiwEY28aNuR/GxeggvUqrSuREnC1WGnlQdHOifwb84kTAt8N701vV8JxTCZmqnCP0W7dldhNZKa90xkR5kEM+NL35POno+sGdtYN5DzjFSx3QCEUDWHaM+QcxL1YGe3Q1vSd2MZRUBSq0DYzzflkIMbD3pormwHZ4PmurAr5ZBYXXcBXZ000Y0Gu62Lpax0Eb6ByO13wyQXQBQMsE3r7yhh/a8whfjnsj2XSo0TLRKN3LvJS9EM9BNImgPGepVPV3Rihx6k0IIsyTszWTHp1iNwPq4MD7sI2h/PZgPMYJ3/gU4fALk2RN4SJhO85oQ2/oJDibtPOYbAQb1O1XWUWLp0KKwrYWgDK+w4KNzRFmvwRI4cW86lNaQiLzLXBWwPstuN1MqX9XI2xWNHKMedmm2ocdWRI7dokZq4y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2353583-65d8-447d-a230-08d795979aad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 06:37:46.5934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfgPJKCWXRWDctXAZx/7ALd7rYGkUL8vuLFy0b/fr6QZs2S/I6Ei2YVk7yUUcuEmijZSXCDtoG3ecWxmLSh2Qg==
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

Align with gfx v9, use map_queues packet to load hiq MQD.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 69 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 10 +++-
 2 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index bfbdded..6adac95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -207,21 +207,6 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 
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
-		value = RREG32(mmRLC_CP_SCHEDULERS);
-		value = REG_SET_FIELD(value, RLC_CP_SCHEDULERS, scheduler1,
-			((mec << 5) | (pipe << 3) | queue_id | 0x80));
-		WREG32(mmRLC_CP_SCHEDULERS, value);
-	}
-
 	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_MEM. */
 	mqd_hqd = &m->cp_mqd_base_addr_lo;
 
@@ -267,6 +252,59 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	return 0;
 }
 
+static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
+			    uint32_t pipe_id, uint32_t queue_id,
+			    uint32_t doorbell_off)
+{
+	struct amdgpu_device *adev = get_amdgpu_device(kgd);
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	struct vi_mqd *m;
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
@@ -701,6 +739,7 @@ const struct kfd2kgd_calls gfx_v8_kfd2kgd = {
 	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
 	.init_interrupts = kgd_init_interrupts,
 	.hqd_load = kgd_hqd_load,
+	.hiq_mqd_load = kgd_hiq_mqd_load,
 	.hqd_sdma_load = kgd_hqd_sdma_load,
 	.hqd_dump = kgd_hqd_dump,
 	.hqd_sdma_dump = kgd_hqd_sdma_dump,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index a5e8ff1..15cbfd4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -166,6 +166,14 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 					  wptr_shift, wptr_mask, mms);
 }
 
+static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
+			    uint32_t pipe_id, uint32_t queue_id,
+			    struct queue_properties *p, struct mm_struct *mms)
+{
+	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->kgd, mqd, pipe_id,
+					      queue_id, p->doorbell_off);
+}
+
 static void __update_mqd(struct mqd_manager *mm, void *mqd,
 			struct queue_properties *q, unsigned int mtype,
 			unsigned int atc_bit)
@@ -438,7 +446,7 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
 		mqd->allocate_mqd = allocate_hiq_mqd;
 		mqd->init_mqd = init_mqd_hiq;
 		mqd->free_mqd = free_mqd_hiq_sdma;
-		mqd->load_mqd = load_mqd;
+		mqd->load_mqd = hiq_load_mqd_kiq;
 		mqd->update_mqd = update_mqd_hiq;
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
