Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8262C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 09:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5ADE6113C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 09:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5ADE6113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0F96E167;
	Wed, 25 Aug 2021 09:28:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3D046E167
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 09:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE05feP62dM9b5ck/gxKAopdx7ZwYKx16rdG+OXbkpieZW0JeB3RHY038984zCKXoH6gRXLUM4DguinKBhlWvpHZaoxhQsl42DYnifV8+jn7JGovuzb0RI2p5mjW8670DnGsMPMV8BdiItX+hcCcE4XStb/jHV9cMNfzCnRJAdLVf7mEMKyTdKa/YuSPvNoZBGVRwhJ4Emk0nPAVl73/MTu43bAwF9q/o78WbrFLj2hFJZ9y9b8FvW3nNCSYdVVR2APhwD5d+Q7iOB8LcKpSuz+XtVyJk69iGqfFiVHUd7cNPbTExyyBwbofxzh9RRLzSOMUwJNYiiEpeoe8MHEStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE4kVXpH6UJivWjTjpMpO++39i9mX6EMeAb3BPI0s/0=;
 b=eDjhXPBUkdTwTER6WBeR6FXCaTKQJrOYX5i9RYkgbLS01FeEiEP81xxeBmurmJ+KHXa2tarOfATQ/KtCIENjqB41hS/f4mPNipd+i/hPkWQjnPUI0AwIxkPxCkX0g+RZ0U/mg9FztGHxmNy/H7i6D7DAmKLCWFLV9VTxYhUzsMwXAA36zeiWbL5FLALDH7DiZqxOBvrn8g+Chwrj5LIpEGro7ndSuzxbbJXH6iI9Ab1f+ixYJED3zxIhpdtgLO8gqrdkMyE2JQJnbNwbhmdvJ1aKv06LLwAXYLG5Nx8T/8d0yh30JZFBt9iE8XYAlzi/zz2iECi07UmTTinHsZG1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE4kVXpH6UJivWjTjpMpO++39i9mX6EMeAb3BPI0s/0=;
 b=gccA0jx20KHulXeye2HaOfXxhPjcohu/8iJWfgePG7qJC+p4hTR17SVXfRG9RI4e6VaAdR/M3jobrnmUkC0gPfrkgVr5gyEex6/Vt4nubiQibLy+wjAJRTAfqKTx3xTKDYUYrfSuUL3LbasrYkqRBuu7lAmHUMk1Ynab8gy5d0M=
Received: from MWHPR08CA0037.namprd08.prod.outlook.com (2603:10b6:300:c0::11)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 09:14:47 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::ce) by MWHPR08CA0037.outlook.office365.com
 (2603:10b6:300:c0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Wed, 25 Aug 2021 09:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 09:14:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 04:14:45 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 25 Aug 2021 04:14:44 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: rename amdgpu_bo_get_preferred_pin_domain.
Date: Wed, 25 Aug 2021 17:14:34 +0800
Message-ID: <20210825091434.693149-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b68bb73-5986-4ec8-1178-08d967a8c88b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2812:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28123A1ADE5392B78C57B61DC1C69@DM6PR12MB2812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7jNKWk1ukzLT1zQ8/xIH01wxZ4ILztRlQB1/0sYBm0/wDXoL5Havl9r8PthnXlrbgKrD0VKLiFuIq5hQ1nNu1CCNlO2PyrqK8RM8XRLSndT5HjUHHRfGEK+BMwmD0qiOy9aSZ+kuhgwMoW1Nfi02wJ1wgp7/ENRmuSUwgytIkTMD/75tKy+VTWawz2wD675zOGTSCallUcCN6jsBoTD05cC65rMfXNFw+3lfYjf6ltwFEB/hbiM90e+XjZtNJnl18a1RhjSTTBfSOF7MWvAyj9BjBA8aoKlMarECFIPWhxEKJyQWCdSDXZxTm9mYGfhP/+lctthUqtRi1FNzHyXsxujfIaMCrm7eF91CL+TATEB3yHl8YdHC3OMM/rfxGI1ChpTcY8OYfwP6Swk5YwnBpLSxjxmLBxPHYzf1Xsb/OKDqNLADbnDM5Kea0Uavw8wNTNRzIHIs64OLk+lfPM78Oy7VPhGSusn9UeUYFzh+6YVZU+DyKFxVX4jXAVFmZ/GLTt1zlGGHVNq4W7j5avnwJT9jAI6rvdYPZ1o6ebH04/hPn6DLA0Z0KmJNZ6ohLSzPteb86Ytki4zrK/QV8rDZ/YGZtq+wu98ogH5rbvjv3T4qJB/48+TwU+yvuk7hCR4dWiyexhA1vHwipmeLDPz87EsSzDTFpJVJyj6pM0RjTgQ+J6QGLudQm2LIRSTjEcTLAvVbX9ICu29nDcigV2dq/0Mq3MAPYw7inbgNv5CKY8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(5660300002)(36860700001)(7696005)(47076005)(1076003)(2906002)(36756003)(26005)(82310400003)(82740400003)(83380400001)(70206006)(54906003)(70586007)(186003)(2616005)(8936002)(356005)(8676002)(426003)(6666004)(316002)(86362001)(6916009)(4326008)(336012)(81166007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 09:14:46.4640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b68bb73-5986-4ec8-1178-08d967a8c88b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_bo_get_preferred_pin_domain is used for page tables
creation, which is not involved with page pinning. And it is used in
more cases than display scanout, modify its documentation as well.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9f952b7fc197..85b292ed5c43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -903,7 +903,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 					 DIV_ROUND_UP(args->bpp, 8), 0);
 	args->size = (u64)args->pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
-	domain = amdgpu_bo_get_preferred_pin_domain(adev,
+	domain = amdgpu_bo_get_preferred_domain(adev,
 				amdgpu_display_supported_domains(adev, flags));
 	r = amdgpu_gem_object_create(adev, args->size, 0, domain, flags,
 				     ttm_bo_type_device, NULL, &gobj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 22a1344082d3..65a9b23f0a46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -947,7 +947,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 	/* This assumes only APU display buffers are pinned with (VRAM|GTT).
 	 * See function amdgpu_display_supported_domains()
 	 */
-	domain = amdgpu_bo_get_preferred_pin_domain(adev, domain);
+	domain = amdgpu_bo_get_preferred_domain(adev, domain);
 
 	if (bo->tbo.base.import_attach)
 		dma_buf_pin(bo->tbo.base.import_attach);
@@ -1518,14 +1518,14 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
 }
 
 /**
- * amdgpu_bo_get_preferred_pin_domain - get preferred domain for scanout
+ * amdgpu_bo_get_preferred_domain - get preferred domain
  * @adev: amdgpu device object
  * @domain: allowed :ref:`memory domains <amdgpu_memory_domains>`
  *
  * Returns:
- * Which of the allowed domains is preferred for pinning the BO for scanout.
+ * Which of the allowed domains is preferred for allocating the BO.
  */
-uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
+uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
 					    uint32_t domain)
 {
 	if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 38c834d0f930..5d746007b317 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -334,7 +334,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
 void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
 int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
 			     struct dma_fence **fence);
-uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
+uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
 					    uint32_t domain);
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0b893aa21ffe..6b15cad78de9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -926,7 +926,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	bp.size = amdgpu_vm_bo_size(adev, level);
 	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
 	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
-	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
+	bp.domain = amdgpu_bo_get_preferred_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 
-- 
2.25.1

