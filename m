Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C04C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 09:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85192070A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 09:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QjWQD8u1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85192070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971C28997A;
	Thu, 26 Mar 2020 09:47:30 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690046.outbound.protection.outlook.com [40.107.69.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA728997A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 09:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+9rUKFlVX0v/U3g/phYtZYImi8+d6ipICtf+hVzF5z+lO/lKaGA2abid9dN55VRQhmKXdbidMeB4X8FvYM63NSBAH2LZ6sg8lp9okjZsx1FArt1CQTjqmWE+bAmSG2DfOImteSpo6gC+G/2RuPO0uvz+HTqzWREwKvBUA/OOLMY7OzQ2DR/sBVAgHQxSDeVfv518xMNhLPjRJsZjwssfFRWnL1j6PDrVSb0o6LVIhXpLAnAetOAACZDbXRvlkWJJ4H0WZgj+V7zZYc4v38QHHtKKVGWuLXHJmLvAAq74w+xB5hCvkws0LAQ5Qe45LzBMkTv2Mv3vzb7vW/Muy/dAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXdSSLWtRiZug8T7dB3uIZkvE201LjMHzxJPc6yB+RI=;
 b=VLIV9nCT9nfWFV6vaZXBtHeTUtuZ4MrIyzhjTD5nBb1GWwlzEGYus6S7Eik9pEtRJJVEtAhgmM5fTHIqc/DqMLD8594UB9kRc4IwvLjBS87XQTJINGBsMYMn2ON2pjA3P18AAI4PovYuZ+d5erflghaujqzOZKSs8m4zrHCR8K2pt0Y5bfjdL5YlFuSiaLTxE7cMsyXLAq8vO65TqBj47LFzdf1muED0Y43J+8/jfgzhkR4KTDBCLKKkTgRHmaLHu4Tx2XUjZ4jlswrZmscbSZaVdcSuPvMipue4CQC8zj3L/q7o9ppy5KypNR3IN/zkgQdlbKXGmilBa3tK1UBJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXdSSLWtRiZug8T7dB3uIZkvE201LjMHzxJPc6yB+RI=;
 b=QjWQD8u19m/Xaf8W+DXwvnGDn9pT1eYUY/Tizh31q3/epdb7WRqO2ZBKbLor+oB2S4m8DfcN+TU4Mf7C8ViQ8i8hZPrjB4ZwlyhZJKY0+cYLD2LZ8HJt+H3yJvprrfi3b0Se1AQmKKJUC5qpCQ+DKWOWIcDOaT/vibhirI9Lm4A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2623.namprd12.prod.outlook.com (2603:10b6:805:6f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 09:47:27 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 09:47:27 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 1/2] drm/amdgpu: implement more ib pools
Date: Thu, 26 Mar 2020 17:47:07 +0800
Message-Id: <20200326094708.4253-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:202:16::16) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR02CA0132.apcprd02.prod.outlook.com (2603:1096:202:16::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Thu, 26 Mar 2020 09:47:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ca44bce-53c8-4cdb-db7a-08d7d16ab1c9
X-MS-TrafficTypeDiagnostic: SN6PR12MB2623:|SN6PR12MB2623:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26234F5B9C10A4A23F672ED987CF0@SN6PR12MB2623.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(478600001)(36756003)(16526019)(316002)(66946007)(66556008)(66476007)(26005)(2906002)(186003)(6916009)(4326008)(2616005)(956004)(8676002)(81166006)(81156014)(8936002)(5660300002)(86362001)(6486002)(1076003)(7696005)(52116002)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2623;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3Nfr31F+Xks2llthqzkOQRZsZFUzG+otOmdlPOgE64+2CP9aPl1H5TXUzHqRbtXFGcpkukcCyHh+KZS0tfN++MUMx2vcoA61YD5bHmgr6TLcs5FnEAXGDKEJgnIbj3vrbSpJYbZWZ1turkVTNZI4XfZe/AgvZg3Is+I2j7MnyHfn4tJYrE381jOJUcP7lnBhnrOr5/W90XI/2ZJPdkzyrHBnLosCLLkvETKlUHl+7Om9tRvhLeLbJ7utDYS0dTreZAknAFXwt5CIX/aXRS5jnws7GAT2JthkArf2oKBBzj91/W9YRwP7le9SuT5fgGa9eMc+PxHg/YCHhtcyd5WGu0rPH1DgKQCbxMuA8XDMcqicMZH/4YSeopBvHbwkmgJ+W3YpIHfbR1GdE/Z//Gt8fSEIgrfU4IoUyFtbiVnr+2A/kzZm5la8Rb3UhPbcn1U
X-MS-Exchange-AntiSpam-MessageData: WDvt9TIXlapfSWMQFm+sChIlOJaeFb2/0/wCA1fHxURNzbshfHKzcW6FT4I9X9eXFO03dsEPJv0NWxElskluSjH3vJp7qjPbHpNOb8dj/N2N8nrRMQxBm7GlzIOyc1bsozgIGINfQGEys7gAOsLQWg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca44bce-53c8-4cdb-db7a-08d7d16ab1c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 09:47:27.7438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehYqUlZKIYCdxm5A7f9YFsr1sH6zeYgJRtw5NjNRkNGXlBwX70BYO5atd3viXD5O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2623
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We have tree ib pools, they are normal, VM, direct pools.

Any jobs which schedule IBs without dependence on gpu scheduler should
use DIRECT pool.

Any jobs schedule direct VM update IBs should use VM pool.

Any other jobs use NORMAL pool.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 11 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 41 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c |  8 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  4 ++-
 5 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7dd74253e7b6..3d70c113c205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -390,6 +390,13 @@ struct amdgpu_sa_bo {
 int amdgpu_fence_slab_init(void);
 void amdgpu_fence_slab_fini(void);
 
+enum amd_ib_pool_type {
+	AMD_IB_POOL_NORMAL = 0,
+	AMD_IB_POOL_VM,
+	AMD_IB_POOL_DIRECT,
+
+	AMD_MAX_IB_POOL
+};
 /*
  * IRQS.
  */
@@ -442,6 +449,8 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
 int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		  unsigned size, struct amdgpu_ib *ib);
+int amdgpu_ib_get_with_pool(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		  unsigned size, struct amdgpu_ib *ib, enum amd_ib_pool_type pool);
 void amdgpu_ib_free(struct amdgpu_device *adev, struct amdgpu_ib *ib,
 		    struct dma_fence *f);
 int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
@@ -848,7 +857,7 @@ struct amdgpu_device {
 	unsigned			num_rings;
 	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
 	bool				ib_pool_ready;
-	struct amdgpu_sa_manager	ring_tmp_bo;
+	struct amdgpu_sa_manager	ring_tmp_bo[AMD_MAX_IB_POOL];
 
 	/* interrupts */
 	struct amdgpu_irq		irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 59ec5e2be211..182c7ee439cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -920,8 +920,8 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
 		parser->entity = entity;
 
 		ring = to_amdgpu_ring(entity->rq->sched);
-		r =  amdgpu_ib_get(adev, vm, ring->funcs->parse_cs ?
-				   chunk_ib->ib_bytes : 0, ib);
+		r =  amdgpu_ib_get_with_pool(adev, vm, ring->funcs->parse_cs ?
+				   chunk_ib->ib_bytes : 0, ib, AMD_IB_POOL_NORMAL);
 		if (r) {
 			DRM_ERROR("Failed to get ib !\n");
 			return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index bece01f1cf09..460b50a5f875 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -62,11 +62,17 @@
  */
 int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		  unsigned size, struct amdgpu_ib *ib)
+{
+	return amdgpu_ib_get_with_pool(adev, vm, size, ib, AMD_IB_POOL_DIRECT);
+}
+
+int amdgpu_ib_get_with_pool(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		  unsigned size, struct amdgpu_ib *ib, enum amd_ib_pool_type pool_type)
 {
 	int r;
 
 	if (size) {
-		r = amdgpu_sa_bo_new(&adev->ring_tmp_bo,
+		r = amdgpu_sa_bo_new(&adev->ring_tmp_bo[pool_type],
 				      &ib->sa_bo, size, 256);
 		if (r) {
 			dev_err(adev->dev, "failed to get a new IB (%d)\n", r);
@@ -297,19 +303,27 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
  */
 int amdgpu_ib_pool_init(struct amdgpu_device *adev)
 {
-	int r;
+	int r, i;
+	unsigned size;
 
 	if (adev->ib_pool_ready) {
 		return 0;
 	}
-	r = amdgpu_sa_bo_manager_init(adev, &adev->ring_tmp_bo,
-				      AMDGPU_IB_POOL_SIZE*64*1024,
-				      AMDGPU_GPU_PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT);
-	if (r) {
-		return r;
+	for (i = 0; i < AMD_MAX_IB_POOL; i++) {
+		if (i == AMD_IB_POOL_DIRECT)
+			size = PAGE_SIZE * 2;
+		else
+			size = AMDGPU_IB_POOL_SIZE*64*1024;
+		r = amdgpu_sa_bo_manager_init(adev, &adev->ring_tmp_bo[i],
+				size,
+				AMDGPU_GPU_PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_GTT);
+		if (r) {
+			for (i--; i >= 0; i--)
+				amdgpu_sa_bo_manager_fini(adev, &adev->ring_tmp_bo[i]);
+			return r;
+		}
 	}
-
 	adev->ib_pool_ready = true;
 
 	return 0;
@@ -325,8 +339,11 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)
  */
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev)
 {
+	int i;
+
 	if (adev->ib_pool_ready) {
-		amdgpu_sa_bo_manager_fini(adev, &adev->ring_tmp_bo);
+		for (i = 0; i < AMD_MAX_IB_POOL; i++)
+			amdgpu_sa_bo_manager_fini(adev, &adev->ring_tmp_bo[i]);
 		adev->ib_pool_ready = false;
 	}
 }
@@ -423,7 +440,9 @@ static int amdgpu_debugfs_sa_info(struct seq_file *m, void *data)
 	struct drm_device *dev = node->minor->dev;
 	struct amdgpu_device *adev = dev->dev_private;
 
-	amdgpu_sa_bo_dump_debug_info(&adev->ring_tmp_bo, m);
+	amdgpu_sa_bo_dump_debug_info(&adev->ring_tmp_bo[AMD_IB_POOL_NORMAL], m);
+	amdgpu_sa_bo_dump_debug_info(&adev->ring_tmp_bo[AMD_IB_POOL_VM], m);
+	amdgpu_sa_bo_dump_debug_info(&adev->ring_tmp_bo[AMD_IB_POOL_DIRECT], m);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 4981e443a884..2e98ce568a3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -88,6 +88,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
 
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
 			     struct amdgpu_job **job)
+{
+	return amdgpu_job_alloc_with_ib_pool(adev, size, job, AMD_IB_POOL_NORMAL);
+}
+
+int amdgpu_job_alloc_with_ib_pool(struct amdgpu_device *adev, unsigned size,
+			     struct amdgpu_job **job, enum amd_ib_pool_type pool_type)
 {
 	int r;
 
@@ -95,7 +101,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
 	if (r)
 		return r;
 
-	r = amdgpu_ib_get(adev, NULL, size, &(*job)->ibs[0]);
+	r = amdgpu_ib_get_with_pool(adev, NULL, size, &(*job)->ibs[0], pool_type);
 	if (r)
 		kfree(*job);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 2e2110dddb76..c34516bf9278 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -38,6 +38,7 @@
 #define AMDGPU_JOB_GET_VMID(job) ((job) ? (job)->vmid : 0)
 
 struct amdgpu_fence;
+enum amd_ib_pool_type;
 
 struct amdgpu_job {
 	struct drm_sched_job    base;
@@ -67,7 +68,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
 		     struct amdgpu_job **job, struct amdgpu_vm *vm);
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
 			     struct amdgpu_job **job);
-
+int amdgpu_job_alloc_with_ib_pool(struct amdgpu_device *adev, unsigned size,
+			     struct amdgpu_job **job, enum amd_ib_pool_type pool);
 void amdgpu_job_free_resources(struct amdgpu_job *job);
 void amdgpu_job_free(struct amdgpu_job *job);
 int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
