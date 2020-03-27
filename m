Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9998C43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F6B20787
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kMXWfr8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F6B20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F536E03B;
	Fri, 27 Mar 2020 03:08:36 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700063.outbound.protection.outlook.com [40.107.70.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 410066E03B
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 03:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+FON34Unf51XHUM1WCZzPnehOuIlIGm2d+rHRDtPlxvRb+DO4ATo6nJiXvTHZBFWiDSAsYaUSEfPVH4m2fZ3+/rLq/kdB3wVrFgeEml1nhqAXK1J0Nim8EYK49i14vigzzkQGl1IDUO28DkJAHsHkBA6JsDdG341Z2rDPiR1f7P1Fw0G1UO7n1OSftcQQOidwDU2EL2ttFP6yseZmh4ws4uX6iS+7NoB//gCJ8thmPYy7xxVdd/PJtUhXjlWx57zeOK35GuVtAoqGQHX+rFmiGRjUK9PpIArebXfKaR0TORSOgOVT5FkFcUtQqCXoD4mGdWsJ8PHPOF3qVhl80POA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+a3YdeTqS+lVcCSQqKto/WR1ymuMJVXKHpptJyffbag=;
 b=V/JBVsqKNwSz+AwzPxkTfqI6XoYn64NYr4KXhaVqO86AodVCRHAbkKgRafmN1iu+QEUGfCDnrWd1z4PDWX1fU0TNr4YlhBz4cot6OhNr/OrobM6wvxz4Ccp6CNKPYNLyy24lMS+M/5JTDMzw5hoc1T/rYcKd063iLPcCSARCobU5vk38y/q5NV/1VjC3WjrorMdB0hGa7A7Mt6u596xQZ1dq0ADpgVq8hm/8BuN+/2nJiIJDfd06G36VGsi3wVMc8Iz9pqD2fkphKzj6ch57/wR4f1WxHcyn3L48LeaD90Z/JCcjBWB5kEp0KZ4eizNhaMCC7vD8hYe1mnsE0fFXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+a3YdeTqS+lVcCSQqKto/WR1ymuMJVXKHpptJyffbag=;
 b=kMXWfr8arsXBYfo5AIdcD9UBESKqmWRc47/al+Aj7FxUo5vb+OS6X5V5FXTXQwbBLQckzzbZKekKXx706Xtof0ZDHsJz2lp0XJORMO98flAiPwmr2ogOMFKFuarRbIUWujv60qk0OVuloHJffIPgQvLTrc02L8eJVlJs+E+Jkzs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2654.namprd12.prod.outlook.com (2603:10b6:805:73::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 03:08:31 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 03:08:31 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: implement more ib pools
Date: Fri, 27 Mar 2020 11:08:14 +0800
Message-Id: <20200327030814.7607-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK0PR01CA0050.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Fri, 27 Mar 2020 03:08:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e8d55de-bfa9-4678-c6f8-08d7d1fc20bd
X-MS-TrafficTypeDiagnostic: SN6PR12MB2654:|SN6PR12MB2654:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB265496227E28FED9778582FE87CC0@SN6PR12MB2654.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(316002)(81166006)(81156014)(6486002)(6666004)(86362001)(8936002)(478600001)(2616005)(956004)(26005)(8676002)(16526019)(186003)(6916009)(30864003)(66946007)(2906002)(36756003)(52116002)(7696005)(66476007)(5660300002)(1076003)(4326008)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2654;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1P4SQ9eX3BM4QGcjgtEaYRTGLDmomWSPsWa7aBvAFKar8U9cseyID/A60JAN+8lIJ6gxvOSBy9sPcC3qd15AkhiX5y+RJ25HTeeAIygHpWuQneB4MKM/OjMFr5XofXRhA4h4qoPB5dCFbnrwpv6fHixmyVVLdjmUW7/Pvl7BAoeU2OeT6h4YvFwboB4wceL1ZxPf10/WVVfYtudf2E7n9wYuJSP6/Rm106ulwJn+Ha+yB0mNALgxZtP+vt2+1pBm20EK9Wwg+hZ7oGGbBXSap6FPVgIIFhtO07u6L1LdVWiXnI66zQeT/GbvSXZbCLWSdbnvsPrflrm8MZsSo2KTw23HjhD1RHBkomWYkGVrDFvoioZ8BGzmfml8qqM4xOB6yHkQMyE8MMwkHFsKIHVPkBGW878P+/OUL9o0vyAP2Exg5+HjybNGUXjzLVYaKOP
X-MS-Exchange-AntiSpam-MessageData: oshiKm+ojt3dB+cGBsNHFxCN24s3T0YtmaIrQcckU2P64b3dtKvIJheXEfG6OK/AH/Y6RgPS78Fkt/mNx10yM6v6YhGyjG4y/M8lpgs3oq0Gzk9//1947q3pyVdebCjjyXUhcuqV4DaLJvURuLvXUw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8d55de-bfa9-4678-c6f8-08d7d1fc20bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 03:08:31.1294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gy0AabCyCl9+xe0cCOt4C7d34NNUtlHZSw/7ZoDHMsVBVSwHhEZQ3qn/rb71UEBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2654
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

We have three ib pools, they are normal, VM, direct pools.

Any jobs which schedule IBs without dependence on gpu scheduler should
use DIRECT pool.

Any jobs schedule direct VM update IBs should use VM pool.

Any other jobs use NORMAL pool.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 12 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 41 +++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  8 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     |  6 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  9 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  6 ++-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       |  6 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |  6 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c         |  3 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |  6 ++-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c       |  6 ++-
 25 files changed, 103 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7dd74253e7b6..649bf5b8ea4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -390,6 +390,13 @@ struct amdgpu_sa_bo {
 int amdgpu_fence_slab_init(void);
 void amdgpu_fence_slab_fini(void);
 
+enum amdgpu_ib_pool_type {
+	AMDGPU_IB_POOL_NORMAL = 0,
+	AMDGPU_IB_POOL_VM,
+	AMDGPU_IB_POOL_DIRECT,
+
+	AMDGPU_IB_POOL_MAX
+};
 /*
  * IRQS.
  */
@@ -441,7 +448,8 @@ struct amdgpu_fpriv {
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
 int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		  unsigned size, struct amdgpu_ib *ib);
+		  unsigned size, struct amdgpu_ib *ib,
+		  enum amdgpu_ib_pool_type pool);
 void amdgpu_ib_free(struct amdgpu_device *adev, struct amdgpu_ib *ib,
 		    struct dma_fence *f);
 int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
@@ -848,7 +856,7 @@ struct amdgpu_device {
 	unsigned			num_rings;
 	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
 	bool				ib_pool_ready;
-	struct amdgpu_sa_manager	ring_tmp_bo;
+	struct amdgpu_sa_manager	ring_tmp_bo[AMDGPU_IB_POOL_MAX];
 
 	/* interrupts */
 	struct amdgpu_irq		irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 59ec5e2be211..0f26668ae6f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -921,7 +921,7 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
 
 		ring = to_amdgpu_ring(entity->rq->sched);
 		r =  amdgpu_ib_get(adev, vm, ring->funcs->parse_cs ?
-				   chunk_ib->ib_bytes : 0, ib);
+				   chunk_ib->ib_bytes : 0, ib, AMDGPU_IB_POOL_NORMAL);
 		if (r) {
 			DRM_ERROR("Failed to get ib !\n");
 			return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index bece01f1cf09..0bfcd30df051 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -61,12 +61,13 @@
  * Returns 0 on success, error on failure.
  */
 int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		  unsigned size, struct amdgpu_ib *ib)
+		  unsigned size, struct amdgpu_ib *ib,
+		  enum amdgpu_ib_pool_type pool_type)
 {
 	int r;
 
 	if (size) {
-		r = amdgpu_sa_bo_new(&adev->ring_tmp_bo,
+		r = amdgpu_sa_bo_new(&adev->ring_tmp_bo[pool_type],
 				      &ib->sa_bo, size, 256);
 		if (r) {
 			dev_err(adev->dev, "failed to get a new IB (%d)\n", r);
@@ -297,19 +298,27 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
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
+	for (i = 0; i < AMDGPU_IB_POOL_MAX; i++) {
+		if (i == AMDGPU_IB_POOL_DIRECT)
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
@@ -325,8 +334,11 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)
  */
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev)
 {
+	int i;
+
 	if (adev->ib_pool_ready) {
-		amdgpu_sa_bo_manager_fini(adev, &adev->ring_tmp_bo);
+		for (i = 0; i < AMDGPU_IB_POOL_MAX; i++)
+			amdgpu_sa_bo_manager_fini(adev, &adev->ring_tmp_bo[i]);
 		adev->ib_pool_ready = false;
 	}
 }
@@ -423,7 +435,12 @@ static int amdgpu_debugfs_sa_info(struct seq_file *m, void *data)
 	struct drm_device *dev = node->minor->dev;
 	struct amdgpu_device *adev = dev->dev_private;
 
-	amdgpu_sa_bo_dump_debug_info(&adev->ring_tmp_bo, m);
+	seq_printf(m, "-------------------- NORMAL -------------------- \n");
+	amdgpu_sa_bo_dump_debug_info(&adev->ring_tmp_bo[AMDGPU_IB_POOL_NORMAL], m);
+	seq_printf(m, "---------------------- VM ---------------------- \n");
+	amdgpu_sa_bo_dump_debug_info(&adev->ring_tmp_bo[AMDGPU_IB_POOL_VM], m);
+	seq_printf(m, "-------------------- DIRECT--------------------- \n");
+	amdgpu_sa_bo_dump_debug_info(&adev->ring_tmp_bo[AMDGPU_IB_POOL_DIRECT], m);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 4981e443a884..ad427d4de5e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -87,7 +87,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
 }
 
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
-			     struct amdgpu_job **job)
+			     struct amdgpu_job **job,
+				 enum amdgpu_ib_pool_type pool_type)
 {
 	int r;
 
@@ -95,7 +96,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
 	if (r)
 		return r;
 
-	r = amdgpu_ib_get(adev, NULL, size, &(*job)->ibs[0]);
+	r = amdgpu_ib_get(adev, NULL, size, &(*job)->ibs[0], pool_type);
 	if (r)
 		kfree(*job);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 2e2110dddb76..6295f49c35a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -38,6 +38,7 @@
 #define AMDGPU_JOB_GET_VMID(job) ((job) ? (job)->vmid : 0)
 
 struct amdgpu_fence;
+enum amdgpu_ib_pool_type;
 
 struct amdgpu_job {
 	struct drm_sched_job    base;
@@ -66,8 +67,7 @@ struct amdgpu_job {
 int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
 		     struct amdgpu_job **job, struct amdgpu_vm *vm);
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
-			     struct amdgpu_job **job);
-
+			     struct amdgpu_job **job, enum amdgpu_ib_pool_type pool);
 void amdgpu_job_free_resources(struct amdgpu_job *job);
 void amdgpu_job_free(struct amdgpu_job *job);
 int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 5727f00afc8e..07af4ddae9e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -144,7 +144,8 @@ static int amdgpu_jpeg_dec_set_reg(struct amdgpu_ring *ring, uint32_t handle,
 	const unsigned ib_size_dw = 16;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e192557db421..be74bfa2fc05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2062,7 +2062,8 @@ static int amdgpu_map_buffer(struct ttm_buffer_object *bo,
 	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
 	num_bytes = num_pages * 8;
 
-	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4 + num_bytes, &job);
+	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4 + num_bytes, &job,
+									AMDGPU_IB_POOL_NORMAL);
 	if (r)
 		return r;
 
@@ -2124,7 +2125,8 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
 
-	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, &job,
+			direct_submit ? AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_NORMAL);
 	if (r)
 		return r;
 
@@ -2213,7 +2215,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 	/* for IB padding */
 	num_dw += 64;
 
-	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, &job, AMDGPU_IB_POOL_NORMAL);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 5fd32ad1c575..55b2e3dc6abb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1056,7 +1056,8 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 			goto err;
 	}
 
-	r = amdgpu_job_alloc_with_ib(adev, 64, &job);
+	r = amdgpu_job_alloc_with_ib(adev, 64, &job,
+			direct ? AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_NORMAL);
 	if (r)
 		goto err;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 59ddba137946..deaf253743ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -446,7 +446,8 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
@@ -524,7 +525,8 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	struct dma_fence *f = NULL;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job,
+			direct ? AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_NORMAL);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index a41272fbcba2..c3006a9efa73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -390,7 +390,8 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(adev, 64, &job);
+	r = amdgpu_job_alloc_with_ib(adev, 64, &job,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		goto err;
 
@@ -557,7 +558,8 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
@@ -610,7 +612,8 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index d30d103e48a2..7ebbe869c28c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -64,7 +64,8 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
 	unsigned int ndw = AMDGPU_VM_SDMA_MIN_NUM_DW;
 	int r;
 
-	r = amdgpu_job_alloc_with_ib(p->adev, ndw * 4, &p->job);
+	r = amdgpu_job_alloc_with_ib(p->adev, ndw * 4, &p->job,
+			p->direct ? AMDGPU_IB_POOL_VM : AMDGPU_IB_POOL_NORMAL);
 	if (r)
 		return r;
 
@@ -225,7 +226,8 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 			ndw = max(ndw, AMDGPU_VM_SDMA_MIN_NUM_DW);
 			ndw = min(ndw, AMDGPU_VM_SDMA_MAX_NUM_DW);
 
-			r = amdgpu_job_alloc_with_ib(p->adev, ndw * 4, &p->job);
+			r = amdgpu_job_alloc_with_ib(p->adev, ndw * 4, &p->job,
+					p->direct ? AMDGPU_IB_POOL_VM : AMDGPU_IB_POOL_NORMAL);
 			if (r)
 				return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 4274ccf765de..dfa8a9613c35 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -679,7 +679,8 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, &ib);
+	r = amdgpu_ib_get(adev, NULL, 256, &ib,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		goto err0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1d37db0d4595..dcd4680ee56b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -557,7 +557,8 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 16, &ib);
+	r = amdgpu_ib_get(adev, NULL, 16, &ib,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		goto err1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 31f44d05e606..194694cc43be 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1914,7 +1914,8 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	WREG32(scratch, 0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, &ib);
+	r = amdgpu_ib_get(adev, NULL, 256, &ib,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		goto err1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 733d398c61cc..3db2bda2393e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2364,7 +2364,8 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	WREG32(scratch, 0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, &ib);
+	r = amdgpu_ib_get(adev, NULL, 256, &ib,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		goto err1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fc32586ef80b..e3c107827fe9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -888,7 +888,8 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 16, &ib);
+	r = amdgpu_ib_get(adev, NULL, 16, &ib,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		goto err1;
 
@@ -1550,7 +1551,8 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 
 	/* allocate an indirect buffer to put the commands in */
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, total_size, &ib);
+	r = amdgpu_ib_get(adev, NULL, total_size, &ib,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r) {
 		DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fb567cf5671b..b76e34ac6a74 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1082,7 +1082,8 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 16, &ib);
+	r = amdgpu_ib_get(adev, NULL, 16, &ib,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		goto err1;
 
@@ -4485,7 +4486,8 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 
 	/* allocate an indirect buffer to put the commands in */
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, total_size, &ib);
+	r = amdgpu_ib_get(adev, NULL, total_size, &ib,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r) {
 		DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9775eca6fe43..91c50c0d7081 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -369,7 +369,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * translation. Avoid this by doing the invalidation from the SDMA
 	 * itself.
 	 */
-	r = amdgpu_job_alloc_with_ib(adev, 16 * 4, &job);
+	r = amdgpu_job_alloc_with_ib(adev, 16 * 4, &job, AMDGPU_IB_POOL_VM);
 	if (r)
 		goto error_alloc;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index fd7fa6082563..01b3d6c7720d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -614,7 +614,8 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, &ib);
+	r = amdgpu_ib_get(adev, NULL, 256, &ib,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		goto err0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 4a8a7f0f3a9c..5c3cf7426193 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -886,7 +886,8 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, &ib);
+	r = amdgpu_ib_get(adev, NULL, 256, &ib,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		goto err0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index fc664ec6b5fd..9096a835027e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1539,7 +1539,8 @@ static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, &ib);
+	r = amdgpu_ib_get(adev, NULL, 256, &ib,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		goto err0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 013e9c05bba5..d6b997472972 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -948,7 +948,8 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, &ib);
+	r = amdgpu_ib_get(adev, NULL, 256, &ib,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r) {
 		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
 		goto err0;
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 7f64d73043cf..20dedcb0ddcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -267,7 +267,8 @@ static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, &ib);
+	r = amdgpu_ib_get(adev, NULL, 256, &ib,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		goto err0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index e0aadcaf6c8b..fbddac3fdb38 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -216,7 +216,8 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
@@ -279,7 +280,8 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 20f10a5617ca..a3da9ac7c511 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -224,7 +224,8 @@ static int uvd_v7_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
@@ -286,7 +287,8 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job,
+					AMDGPU_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
