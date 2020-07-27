Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D6EC433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 08:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7C120759
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 08:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AsOSPX8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7C120759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD31D89B9E;
	Mon, 27 Jul 2020 08:21:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A0CA89B9E
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 08:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9gsKC0zgy9jXjeMDOAUAtBq4n2+gFL2317UJbgwSv+MML3bz1gpZdHlJbmTksVRAZVjg0WpzMT7d4tOgYmifQPHPx9SH73UscX8xZzNUb/zRxx/6ruKbinxjX1iGYaZop2upFdlyGNkVC+ttHaeXP83jRIRfuTr55Ylwz8xbKdIrZVWVB+zf4QtnNTXRPfnTSgb3vg58/OPemfDAsp/byF9jqQyCG+trUvwtq5mJLGJFQMt0qTIWK35/Jtjj0Uf4/1uqQ1BG8/USlZ6v6b/vb4nGDxCG09gIU5w/4PrvvPyNOgk/cVKOyYCRFdcYrQz+BJP1H+RfMZE45/LzwpYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU5cuwTbBVjNzOtt6MUUDaNJ4VBy/DE4qpmH8RpQ8rs=;
 b=FhmYZ6J7OzRMVQ5G5Ij16waF1MFVxIu+bDjdGq9M9EqfwDtsqyR+L5g6+1EAqmbuLoYdlRLBBhWvo91sHyZaOCd+OtmcIG1+PCWTmB1z8e08QO2W2XRnUvYpybqzS+Y+FD6IY4vuCDhcEq2Rjn9dTHXkevrXHVtUqkJUiJRPl9Mqd2WiPSeTGvsI+XJqC87o7H42IbxJobw7tgosUL3wkm+vcpv/NGzO4WMvn7qaTXZJF1wace+M6kO3nWT+PxGFy8ofQQBTBMXKtXRez1QU0gQ/DyLWFY0Iq2s9zkyGifc0evXCbLFqtfr2p20xitEdrvUCwvuk8zWQ3KDvhkScLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU5cuwTbBVjNzOtt6MUUDaNJ4VBy/DE4qpmH8RpQ8rs=;
 b=AsOSPX8J6OEijn/a9vbvx7KOODxgwHYfvWpw1Y9hYzUcZd3Oi6VjwFkhg7f+esgslQwzJw07cqaaDUu30lBpe/YgWZcFgz52nsM3Sa7AurmE7FNtGQj4OSH6WhfLz2sejD6wSQKDXPEmb0NeXQcZKiOHe0Xed/bEJhlxSrY9BEI=
Received: from BN6PR14CA0004.namprd14.prod.outlook.com (2603:10b6:404:79::14)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 08:21:44 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::2f) by BN6PR14CA0004.outlook.office365.com
 (2603:10b6:404:79::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Mon, 27 Jul 2020 08:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Mon, 27 Jul 2020 08:21:43 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 03:21:43 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 27 Jul 2020 03:21:42 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: introduce a new parameter to configure how many
 KCQ we want
Date: Mon, 27 Jul 2020 16:21:39 +0800
Message-ID: <1595838099-18627-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96ef2543-830c-4711-2978-08d8320618c4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4248:
X-Microsoft-Antispam-PRVS: <CH2PR12MB42489A445E8F72B15D0414C784720@CH2PR12MB4248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4a+jlFSt8zuPPLq+upbdRi0grT9qzPJqE3mk5Lha/jgsroILHuJ3TnCWHqjfP6U+oYkG8IOeYYWtLV9kPVmXygvRuNGJ5Hf6MxeS3sixIEC+j6c1Ruj8TW+2ADCz2klQLbtqoeAdHv7M4AfYmSeEOZAUn4j+yYp+ddQjQXPi9/vev6dw0GHJWvfAfil9ymIK9rLXrGkCrlmfO6yBEHIiNzh6ORnH/2eFUS/dXELsFpJ60vrWNUYh7wqbyH77lXW1Ph8zTIaOZ2PmeDwkOEUruhwfRU+ikPWoZ9gL0NlLcZAYHnOfMbxcTFkTkc7+M3UUY7QJp7PAI1OTABLEv3H27K7Du69Pq+9FOZRRBvg++n9AoKRy8mIltRB3vDwADp8ADaf8vHzBB6E1/4RqD8CNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966005)(82310400002)(356005)(86362001)(336012)(4326008)(2906002)(478600001)(316002)(186003)(82740400003)(8676002)(26005)(6916009)(8936002)(5660300002)(70206006)(70586007)(6666004)(426003)(36756003)(47076004)(83380400001)(2616005)(7696005)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 08:21:43.9196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ef2543-830c-4711-2978-08d8320618c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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
KCQ cost many clocks during world switch which impacts a lot to multi-VF
performance

how:
introduce a paramter to control the number of KCQ to avoid performance
drop if there is no KQC needed

notes:
this paramter only affects gfx 8/9/10

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 27 +++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 30 +++++++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 29 ++++++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 31 +++++++++++++++---------------
 7 files changed, 69 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e97c088..71a3d6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -201,6 +201,7 @@ extern int amdgpu_si_support;
 #ifdef CONFIG_DRM_AMDGPU_CIK
 extern int amdgpu_cik_support;
 #endif
+extern int amdgpu_num_kcq_user_set;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62ecac9..61c7583 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1199,6 +1199,9 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 
 	amdgpu_gmc_tmz_set(adev);
 
+	if (amdgpu_num_kcq_user_set > 8 || amdgpu_num_kcq_user_set < 0)
+		amdgpu_num_kcq_user_set = 8;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6291f5f..03a94e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -150,6 +150,7 @@ int amdgpu_noretry;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = 0;
 int amdgpu_reset_method = -1; /* auto */
+int amdgpu_num_kcq_user_set = 8;
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -765,6 +766,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
 MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
 module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 
+MODULE_PARM_DESC(num_kcq, "number of KCQ user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
+module_param_named(num_kcq, amdgpu_num_kcq_user_set, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8eff017..0b59049 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -202,7 +202,7 @@ bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
 
 void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
 {
-	int i, queue, pipe, mec;
+	int i, queue, pipe, mec, j = 0;
 	bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
 
 	/* policy for amdgpu compute queue ownership */
@@ -219,23 +219,24 @@ void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
 
 		if (multipipe_policy) {
 			/* policy: amdgpu owns the first two queues of the first MEC */
-			if (mec == 0 && queue < 2)
-				set_bit(i, adev->gfx.mec.queue_bitmap);
+			if (mec == 0 && queue < 2) {
+				if (j++ < adev->gfx.num_compute_rings)
+					set_bit(i, adev->gfx.mec.queue_bitmap);
+				else
+					break;
+			}
 		} else {
 			/* policy: amdgpu owns all queues in the first pipe */
-			if (mec == 0 && pipe == 0)
-				set_bit(i, adev->gfx.mec.queue_bitmap);
+			if (mec == 0 && pipe == 0) {
+				if (j++ < adev->gfx.num_compute_rings)
+					set_bit(i, adev->gfx.mec.queue_bitmap);
+				else
+					break;
+			}
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
index db9f1e8..2ad8393 100644
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
+	adev->gfx.num_compute_rings = amdgpu_num_kcq_user_set;
 
 	gfx_v10_0_set_kiq_pm4_funcs(adev);
 	gfx_v10_0_set_ring_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 8d72089..6d95b4b 100644
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
+	adev->gfx.num_compute_rings = amdgpu_num_kcq_user_set;
 	adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
 	gfx_v8_0_set_ring_funcs(adev);
 	gfx_v8_0_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e4e751f..43bcfe3 100644
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
+	adev->gfx.num_compute_rings = amdgpu_num_kcq_user_set;
 	gfx_v9_0_set_kiq_pm4_funcs(adev);
 	gfx_v9_0_set_ring_funcs(adev);
 	gfx_v9_0_set_irq_funcs(adev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
