Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E779AC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B909520829
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oYT7tIhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B909520829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 865606E0C2;
	Fri, 31 Jul 2020 02:12:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04EC86E0C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPCI/74Pedw4c6W+KEfHRe30iGd6IeM9wbKLhf59lHjRk7AA7xswg87N2VwY3Jn2EzNIIuwfxEqicD/aYkdo0bsaeyYb5W/Hdj8V6meL5Gxe6eilAlejacFaV9YYBWsIhmE/vUCjgMeGWvzAwJCk0QvK1xd+fIovyCmmhzK7+YUX0QXWDCRjNq6GwbU+GcWp4K2i0XVw6Q47G2Sv0AdNu+PpsUnj0hgmVRXiQOI45zyMKptJwGhU9mNhZrChxY7A2jsriF3NTN7vH+MXHrjG9RQSfXngeYFYnSgjp3SB9d9DXnwTBwRk/8IsD4L4qawOusmooVM7RFX5/ZsUosQiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04NBpcgDTELScyrGiRBgPXK9dJpywHCgj8RGEJJ/XH4=;
 b=D14G5XOaTdgjNTztqHk1L6cei2vNuAYEIQqj8hu6GKPKDPsOLpm2aSoGAmFNgm3KEbbWK0eYWqeF6MCNZ+a/zOK/ma13UdnxdCYgwfY23MsQxAgeKvt9n9VfGmUb0KhA8XFLAGgaaaoyzEz4d/PgHFMnCmncXJT0DYD99BcqMT+HAqjCicQot7NLCYpj04G6FrkeZakGJuYNIxrQce+/eh4rv+ldRVOGoMstvNozjNiSca3NukhvOJN4GHSIYbIWcDAAI3B/PQVxjnjafKflSdq8AiuqVpIhHkyuLT8xI6p5v+ylPXAl+kmSyFqO8UhQanFY9g162Q/DPemxajlgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04NBpcgDTELScyrGiRBgPXK9dJpywHCgj8RGEJJ/XH4=;
 b=oYT7tIhNZ0Z349josihOiGxpEelqe/m6BO4H1Qz3XobocTOxrQHzFn4kTDIbdqq2Tv23VSGVbQuIJielM6IpnolATMD6KBB9V/8yMeolNQRlAtrijIhZdjVk8F9nRI34vkfWyBUAuOLBpZjZgix2XwhDAhUqjDf9epeiP8EgPxU=
Received: from DM5PR08CA0057.namprd08.prod.outlook.com (2603:10b6:4:60::46) by
 CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Fri, 31 Jul 2020 02:12:15 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::9) by DM5PR08CA0057.outlook.office365.com
 (2603:10b6:4:60::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Fri, 31 Jul 2020 02:12:15 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 02:12:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 21:12:13 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 21:12:13 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 21:12:12 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: introduce a new parameter to configure how many
 KCQ we want(v4)
Date: Fri, 31 Jul 2020 10:12:09 +0800
Message-ID: <1596161529-26984-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87b46205-abc7-406e-8552-08d834f7242e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4165:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41651144A2BD34F5DD4614E4844E0@CH2PR12MB4165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ty++MgN2cGAx7pSLE5e8KIeFLaSPIHdmjEf8mYE567gxh5OqZtFsXlj8eKnwbqAqaIEAVfbRd3vQpCeFCINLxrSKgl7c0tOSY56/KgeFVov1/BG0TTUsRCSEUIr6GnAII7OK5u6ILHgZwm14M67C9QqM4d76S81JRQMddjwuM4bDUy9S7YoIyV1svTxDDHvvCwlzzIIIyxrpOc3aW89ynHCHcK0rv+w5Oos2U9ricv+Fgtq5d5F/iL/nSWwqXLP1F2PHG5xfEvWFYG/1Bz1FpXe5CfQpbCHztcnaZ3e3+tFhjrlOdz1wzYwFwfmhrHn4jC6NIqjETpvlDBh5oTIb9B7sQQqrd9SPjKuKePJJgfX40cVlNdi5LpTFYzm4NuZOEbeDlvmdhpKcmYuIoJBKlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966005)(478600001)(186003)(70206006)(6916009)(7696005)(70586007)(26005)(36756003)(83380400001)(336012)(2906002)(4326008)(2616005)(426003)(47076004)(8676002)(6666004)(5660300002)(82740400003)(8936002)(356005)(86362001)(81166007)(30864003)(316002)(82310400002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:12:14.0430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b46205-abc7-406e-8552-08d834f7242e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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

what:
the MQD's save and restore of KCQ (kernel compute queue)
cost lots of clocks during world switch which impacts a lot
to multi-VF performance

how:
introduce a paramter to control the number of KCQ to avoid
performance drop if there is no kernel compute queue needed

notes:
this paramter only affects gfx 8/9/10

v2:
refine namings

v3:
choose queues for each ring to that try best to cross pipes evenly.

v4:
fix indentation
some cleanupsin the gfx_compute_queue_acquire() function

TODO:
in the future we will let hypervisor driver to set this paramter
automatically thus no need for user to configure it through
modprobe in virtual machine

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 52 +++++++++++++-----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 30 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 29 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 31 +++++++++---------
 7 files changed, 80 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e97c088..de11136 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -201,6 +201,7 @@ extern int amdgpu_si_support;
 #ifdef CONFIG_DRM_AMDGPU_CIK
 extern int amdgpu_cik_support;
 #endif
+extern int amdgpu_num_kcq;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62ecac9..cf445bab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1199,6 +1199,11 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 
 	amdgpu_gmc_tmz_set(adev);
 
+	if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
+		amdgpu_num_kcq = 8;
+		dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid paramter provided by user\n");
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6291f5f..b545c40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -150,6 +150,7 @@ int amdgpu_noretry;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = 0;
 int amdgpu_reset_method = -1; /* auto */
+int amdgpu_num_kcq = -1;
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -765,6 +766,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
 MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
 module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 
+MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
+module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8eff017..24b3461 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -202,40 +202,34 @@ bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
 
 void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
 {
-	int i, queue, pipe, mec;
+	int i, queue, pipe;
 	bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
+	int max_queues_per_mec = min(adev->gfx.mec.num_pipe_per_mec *
+	                             adev->gfx.mec.num_queue_per_pipe,
+	                             adev->gfx.num_compute_rings);
+
+	if (multipipe_policy) {
+		/* policy: make queues evenly cross all pipes on MEC1 only */
+		for (i = 0; i < max_queues_per_mec; i++) {
+			pipe = i % adev->gfx.mec.num_pipe_per_mec;
+			queue = (i / adev->gfx.mec.num_pipe_per_mec) %
+				adev->gfx.mec.num_queue_per_pipe;
+
+			set_bit(pipe * adev->gfx.mec.num_queue_per_pipe + queue,
+					adev->gfx.mec.queue_bitmap);
+		}
+	} else {
+		/* policy: amdgpu owns all queues in the given pipe */
+		for (i = 0; i < max_queues_per_mec; ++i) {
+			queue = i % adev->gfx.mec.num_queue_per_pipe;
+			pipe = (i / adev->gfx.mec.num_queue_per_pipe)
+				% adev->gfx.mec.num_pipe_per_mec;
 
-	/* policy for amdgpu compute queue ownership */
-	for (i = 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
-		queue = i % adev->gfx.mec.num_queue_per_pipe;
-		pipe = (i / adev->gfx.mec.num_queue_per_pipe)
-			% adev->gfx.mec.num_pipe_per_mec;
-		mec = (i / adev->gfx.mec.num_queue_per_pipe)
-			/ adev->gfx.mec.num_pipe_per_mec;
-
-		/* we've run out of HW */
-		if (mec >= adev->gfx.mec.num_mec)
-			break;
-
-		if (multipipe_policy) {
-			/* policy: amdgpu owns the first two queues of the first MEC */
-			if (mec == 0 && queue < 2)
-				set_bit(i, adev->gfx.mec.queue_bitmap);
-		} else {
-			/* policy: amdgpu owns all queues in the first pipe */
-			if (mec == 0 && pipe == 0)
-				set_bit(i, adev->gfx.mec.queue_bitmap);
+			set_bit(i, adev->gfx.mec.queue_bitmap);
 		}
 	}
 
-	/* update the number of active compute rings */
-	adev->gfx.num_compute_rings =
-		bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
-
-	/* If you hit this case and edited the policy, you probably just
-	 * need to increase AMDGPU_MAX_COMPUTE_RINGS */
-	if (WARN_ON(adev->gfx.num_compute_rings > AMDGPU_MAX_COMPUTE_RINGS))
-		adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
+	dev_info(adev->dev, "mec queue bitmap weight=%d\n", bitmap_weight(adev->gfx.mec.queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES));
 }
 
 void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index db9f1e8..3a93b3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4022,21 +4022,23 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *adev)
 	amdgpu_gfx_compute_queue_acquire(adev);
 	mec_hpd_size = adev->gfx.num_compute_rings * GFX10_MEC_HPD_SIZE;
 
-	r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &adev->gfx.mec.hpd_eop_obj,
-				      &adev->gfx.mec.hpd_eop_gpu_addr,
-				      (void **)&hpd);
-	if (r) {
-		dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
-		gfx_v10_0_mec_fini(adev);
-		return r;
-	}
+	if (mec_hpd_size) {
+		r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
+									  AMDGPU_GEM_DOMAIN_GTT,
+									  &adev->gfx.mec.hpd_eop_obj,
+									  &adev->gfx.mec.hpd_eop_gpu_addr,
+									  (void **)&hpd);
+		if (r) {
+			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
+			gfx_v10_0_mec_fini(adev);
+			return r;
+		}
 
-	memset(hpd, 0, mec_hpd_size);
+		memset(hpd, 0, mec_hpd_size);
 
-	amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
-	amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
+		amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
+		amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
+	}
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 		mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data;
@@ -7159,7 +7161,7 @@ static int gfx_v10_0_early_init(void *handle)
 		break;
 	}
 
-	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
+	adev->gfx.num_compute_rings = amdgpu_num_kcq;
 
 	gfx_v10_0_set_kiq_pm4_funcs(adev);
 	gfx_v10_0_set_ring_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 8d72089..eb4b812 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1343,21 +1343,22 @@ static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
 	amdgpu_gfx_compute_queue_acquire(adev);
 
 	mec_hpd_size = adev->gfx.num_compute_rings * GFX8_MEC_HPD_SIZE;
+	if (mec_hpd_size) {
+		r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
+									  AMDGPU_GEM_DOMAIN_VRAM,
+									  &adev->gfx.mec.hpd_eop_obj,
+									  &adev->gfx.mec.hpd_eop_gpu_addr,
+									  (void **)&hpd);
+		if (r) {
+			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
+			return r;
+		}
 
-	r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &adev->gfx.mec.hpd_eop_obj,
-				      &adev->gfx.mec.hpd_eop_gpu_addr,
-				      (void **)&hpd);
-	if (r) {
-		dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
-		return r;
-	}
-
-	memset(hpd, 0, mec_hpd_size);
+		memset(hpd, 0, mec_hpd_size);
 
-	amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
-	amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
+		amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
+		amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
+	}
 
 	return 0;
 }
@@ -5294,7 +5295,7 @@ static int gfx_v8_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
+	adev->gfx.num_compute_rings = amdgpu_num_kcq;
 	adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
 	gfx_v8_0_set_ring_funcs(adev);
 	gfx_v8_0_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e4e751f..43ad044 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1938,22 +1938,23 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
 	/* take ownership of the relevant compute queues */
 	amdgpu_gfx_compute_queue_acquire(adev);
 	mec_hpd_size = adev->gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
+	if (mec_hpd_size) {
+		r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
+									  AMDGPU_GEM_DOMAIN_VRAM,
+									  &adev->gfx.mec.hpd_eop_obj,
+									  &adev->gfx.mec.hpd_eop_gpu_addr,
+									  (void **)&hpd);
+		if (r) {
+			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
+			gfx_v9_0_mec_fini(adev);
+			return r;
+		}
 
-	r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &adev->gfx.mec.hpd_eop_obj,
-				      &adev->gfx.mec.hpd_eop_gpu_addr,
-				      (void **)&hpd);
-	if (r) {
-		dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
-		gfx_v9_0_mec_fini(adev);
-		return r;
-	}
-
-	memset(hpd, 0, mec_hpd_size);
+		memset(hpd, 0, mec_hpd_size);
 
-	amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
-	amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
+		amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
+		amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
+	}
 
 	mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data;
 
@@ -4625,7 +4626,7 @@ static int gfx_v9_0_early_init(void *handle)
 		adev->gfx.num_gfx_rings = 0;
 	else
 		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
+	adev->gfx.num_compute_rings = amdgpu_num_kcq;
 	gfx_v9_0_set_kiq_pm4_funcs(adev);
 	gfx_v9_0_set_ring_funcs(adev);
 	gfx_v9_0_set_irq_funcs(adev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
