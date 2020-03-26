Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB190C2D0E7
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 02:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9F120737
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 02:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zBtKjUTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9F120737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD786E886;
	Thu, 26 Mar 2020 02:02:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA896E886
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 02:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McDL24homhktxgYyyLBKKF5gE8qJbgR1LMllWCbUARoMZbkA4HoTpf6sCjmk9M7BcsTsvnTLiKbBbrfbKs/aPpjfEK1q2TkzXQkEn7YOWDblpGf8IKXIEKl2hNcm5QNVGrEYpNoNJgLaUko7zyvxuUrJR6PYGuFIsdzUT/MeSJ2FY/VLyB6BvW1ms8jGmzyJmSlfnACh7dck8G8ngYqtIgxbxPKdBa/+5LQgq5qE42WFokXc5/oDf8BtIfWq+jM/8RvnuWYgRKyT/tHDiRxT7KJOmZIoMakkkSwDq6a95LFyEZ8sgcmyV5+lPO2pmIE0fiHBdlDKgdloadMSnsxa+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFB8MGHKSYT50Mw4IX/HNBvifhMny8rNFeP0iiWDmOc=;
 b=ArD2wP6yVi8DlgnSCTt2MJLahJQL3Q1m9M7n7Z0hikOLbRA0G9ItdAhn0FjIDa0KeIDXgSXd+RwKEBUUMDNj1F5i7HoX6H86txUngB6HRMX8JQAwHuRUBWld82BwITb2oNg+AF+eJDtdvzVO9amdnva3VoELZVeEMp9oElAbSKijdHGPkL7PB/Chy1iHlJKFa9r7sOX7B+l6K6oHhxQfCGhremcw+uOPt2xSa/odpwHv0n/MiV2jsR9YNMh4kO6vtcV8TM86JYKRuEP83lZri/XC5kl5roXf9IroMmrByE5QIVut4zEHNKBFwv96AvHegfpTqwmO27INGV+Rp+x3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFB8MGHKSYT50Mw4IX/HNBvifhMny8rNFeP0iiWDmOc=;
 b=zBtKjUTM1PyvpEGyqFPhSa/o42UGeWUTTmgxW3g6Tipplq/Xbw2o4ZkT1lZ6G8sXpJjBHFJDv+kEGrquzdrXCfsGkSN8MSRoAsefREPuXM9ZSflJygpNJZV1hzbZmLxelMTof65RcL5fRDXR9R2bre+owvomsO81zQHTXSBJIn0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2655.namprd12.prod.outlook.com (2603:10b6:805:72::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Thu, 26 Mar
 2020 02:02:09 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 02:02:09 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 1/2] drm/amdgpu: add direct ib pool
Date: Thu, 26 Mar 2020 10:01:43 +0800
Message-Id: <20200326020144.5953-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326020144.5953-1-xinhui.pan@amd.com>
References: <20200326020144.5953-1-xinhui.pan@amd.com>
X-ClientProxiedBy: KL1PR01CA0104.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::20) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 KL1PR01CA0104.apcprd01.prod.exchangelabs.com (2603:1096:820:3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Thu, 26 Mar 2020 02:02:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81aadf7f-faab-4a19-0aa5-08d7d129b159
X-MS-TrafficTypeDiagnostic: SN6PR12MB2655:|SN6PR12MB2655:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB265578009F446A88E51A7D9487CF0@SN6PR12MB2655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(86362001)(2906002)(2616005)(26005)(186003)(478600001)(16526019)(956004)(4326008)(6486002)(66476007)(66946007)(5660300002)(7696005)(52116002)(81156014)(8936002)(81166006)(8676002)(36756003)(66556008)(316002)(6916009)(6666004)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2655;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9oLO0IkycYUFpdjvHI9zOheND/WwNiPFD0pvjG/Zwwpi4XDj9uNHVFPPTiR604I03IpLLuxo/eY1/XIB6ZxnVrvmjO4qxii1d1xcnc4l9KQDCGgHgNOmq006+Su1xvhoyEZ2y3G4grfLknnRH58P0oEFh428ySMIvPcnBE+zwo707JUZjRNxJfo0n6zhEjhpKlR8KFDrMe7hwldXyqq0I48PkdVS0T9yrF04mwF6BbWKDsTT5zehHYXVJUaO2XENKCurROt8i12YIOFJTxUVLFMrCTZLJ6RugMfH300rntd7GArKMHAjHum2pQqBG5mCK3nr3CpsKqG+mk5qP9192Tz/cCp+7gWyyp915azVSP4Dwy5zoKb7xWFwU0+F+10bwXraEFlQtGKCnrP/+Cta791tD20HOksWNR1x3Gl9Pm7v9ewYAJMHnPdsiCSmFNR
X-MS-Exchange-AntiSpam-MessageData: sgcxl47biSxgmrO5nZUGJI68F+ao+kbM3FYhEaqFZpksb/gZPvtbdmSDBAGlzdv0i0idbpqqzY5bhWE7xccTp6rul+aTkM2XoVnflpbdtFxcq2eMRoMX9ByVVS6EqxZAt3vtS5KkuLd+WgKE9Sz6Xg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81aadf7f-faab-4a19-0aa5-08d7d129b159
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 02:02:09.7650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTKskIx4TPJL6cdfy13iXei57ykyO1FUuGblbFbgRv+VKuYA7M646tHBsouLvL75
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2655
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

Another ib poll for direct submit.
Any jobs schedule IBs without dependence on gpu scheduler should use
this pool firstly.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  3 ++-
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7dd74253e7b6..c01423ffb8ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -849,6 +849,7 @@ struct amdgpu_device {
 	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
 	bool				ib_pool_ready;
 	struct amdgpu_sa_manager	ring_tmp_bo;
+	struct amdgpu_sa_manager	ring_tmp_bo_direct;
 
 	/* interrupts */
 	struct amdgpu_irq		irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 8304d0c87899..28be4efb3d5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -920,7 +920,7 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
 		parser->entity = entity;
 
 		ring = to_amdgpu_ring(entity->rq->sched);
-		r =  amdgpu_ib_get(adev, vm, ring->funcs->parse_cs ?
+		r =  amdgpu_ib_get(adev, (unsigned long )vm|0x1, ring->funcs->parse_cs ?
 				   chunk_ib->ib_bytes : 0, ib);
 		if (r) {
 			DRM_ERROR("Failed to get ib !\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index bece01f1cf09..f2e08c372d57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -66,7 +66,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r;
 
 	if (size) {
-		r = amdgpu_sa_bo_new(&adev->ring_tmp_bo,
+		r = amdgpu_sa_bo_new(vm ? &adev->ring_tmp_bo : &adev->ring_tmp_bo_direct,
 				      &ib->sa_bo, size, 256);
 		if (r) {
 			dev_err(adev->dev, "failed to get a new IB (%d)\n", r);
@@ -75,7 +75,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 		ib->ptr = amdgpu_sa_bo_cpu_addr(ib->sa_bo);
 
-		if (!vm)
+		if (!((unsigned long)vm & ~0x1))
 			ib->gpu_addr = amdgpu_sa_bo_gpu_addr(ib->sa_bo);
 	}
 
@@ -310,6 +310,13 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	r = amdgpu_sa_bo_manager_init(adev, &adev->ring_tmp_bo_direct,
+				      AMDGPU_IB_POOL_SIZE*64*1024,
+				      AMDGPU_GPU_PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_GTT);
+	if (r) {
+		return r;
+	}
 	adev->ib_pool_ready = true;
 
 	return 0;
@@ -327,6 +334,7 @@ void amdgpu_ib_pool_fini(struct amdgpu_device *adev)
 {
 	if (adev->ib_pool_ready) {
 		amdgpu_sa_bo_manager_fini(adev, &adev->ring_tmp_bo);
+		amdgpu_sa_bo_manager_fini(adev, &adev->ring_tmp_bo_direct);
 		adev->ib_pool_ready = false;
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 4981e443a884..6a63826c6760 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -88,6 +88,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
 
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
 			     struct amdgpu_job **job)
+{
+	return amdgpu_job_alloc_with_ib_direct(adev, size, job, 0);
+}
+
+int amdgpu_job_alloc_with_ib_direct(struct amdgpu_device *adev, unsigned size,
+			     struct amdgpu_job **job, int direct)
 {
 	int r;
 
@@ -95,7 +101,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
 	if (r)
 		return r;
 
-	r = amdgpu_ib_get(adev, NULL, size, &(*job)->ibs[0]);
+	r = amdgpu_ib_get(adev, direct ? NULL : 0x1, size, &(*job)->ibs[0]);
 	if (r)
 		kfree(*job);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 2e2110dddb76..be9dd72b9912 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -67,7 +67,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
 		     struct amdgpu_job **job, struct amdgpu_vm *vm);
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
 			     struct amdgpu_job **job);
-
+int amdgpu_job_alloc_with_ib_direct(struct amdgpu_device *adev, unsigned size,
+			     struct amdgpu_job **job, int direct);
 void amdgpu_job_free_resources(struct amdgpu_job *job);
 void amdgpu_job_free(struct amdgpu_job *job);
 int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
