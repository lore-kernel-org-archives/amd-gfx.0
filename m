Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352E7C43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F186664E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F186664E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF8736EB44;
	Wed, 24 Feb 2021 22:20:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6256EB3E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVfpZJcYozUEU2xS8i73EieMLMmdUIYtmFg+ZHS+JpC6mHLG/+d8M/Y5ApjIcJbvSc0i8cLEvGZ6XP9kLV50Z0aADqDo/K5NNVzcgqLD/s8Xok47QLQuxBQAU9G0DlWQW0BcLwySQsoxBH43SSrllaOVWQ3m7BzDRnJzUPGnRItpkAW603XlfIJfuaoTjJCD4H+1r+1WtGJTaS3uaFGDVTU4ZwMyO0bVnNHi3kzqQbeks8yR9IRIxXsQLYVddcGmaLHMHQAOXzqYEBLyduDWzt/5Srx3JuK/nwQ5F+l/qVRcvhtOuWfLwWJBIXTovqUD+oKg7cd4UULKs1tEwM5W0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjBQEWiEZc1mReXg4f58Fdufm1IKeDwVSALniyy9grM=;
 b=RwKLu+jdvOLG4dcPzrh9dlcwGFtF4T9Q1jIjv+XrZZTJb4H/zbHavH91oEDkFxedWvpiPPXx5fnY3vpmjvuQyiCbpfxnQ3bZqT5TUzeL6Bl++KDj1IPaa7EeQ5i9DpX7aDJ3J2u5EpLX866s4G9iU0zk5G8qrRx++aJ0hzbsJdf1c3hkghF/YFGn3S5zf0pC048gbXiOFVOugn3XVPwOgcITo7PYOF90CNYly4NFRJfLlC38Mu7r4QYmM7E6L/OeXQxHj37xAYZ2IiH0gtrCphwA5Jfcb+vQDGffSFdyogqQzuJ5kzn8GhHFxWtk/GTR0THipkbDIUgyw2TJx1NCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjBQEWiEZc1mReXg4f58Fdufm1IKeDwVSALniyy9grM=;
 b=K9xkdDM1xxyIJpRQasBNzpTpqXeu1/wy+ggafrSKVLx2/gxARpAt9jxCWpXjo6RK4BA3GadZkuV23e98W6s5G78QKmBNFYWxQeSg2oZz8jzJO/x2VxL76qvqzfXe+vMaaCnq6dwbPHKSmDxqCq4xpWU+A08u/9L56Vgg1Td+efM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:20:20 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:19 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 047/159] drm/amdgpu/jpeg2.6: Add jpeg2.6 support
Date: Wed, 24 Feb 2021 17:17:07 -0500
Message-Id: <20210224221859.3068810-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ae5c73f-d6ff-430d-d948-08d8d9124e81
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB48659EE24DD2F15AE4C441F9F79F9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4hOSPHnskk8yMV5sYJF+W6iH9NEoOxxfNyxoCYj6ccKdady1Yl+I3KGhQHvm8OMNLI1qeZk6xCkg+WWKr/1lgKzsD4N7AcqvpLUifkO9X5ObKes0s/vt+2zumuRb4/GT4/pjCLSr+fA75fzj5DyHbt141ZIk7fr4Fl8zSOGsGCigIyEpBm5Osc/8rYuG+orjvslxXiJ1Ytz9zDcmb0odtM3KmFMyubnN9OKpYbE7hq9ghUNEUCK8NUcyartNmc/YjePMDImO7+TKq0dGCYSbVjJWy+M08GbhUR1cpO9NCOHjxQ4+BIskTECr+6yqz7C3hUZBBWw/u5trrDFTT4K6QxG3e9oCqVIMqs4TUZgoPL9+fZUH9UeoXHgy53H+SP6rWpkUVUXNT2J0BIMXzMA7fYWqWImnirx6PXgsjBVn7V1EqBuF8pHEMHGYw2T1jT1zxyDCep4bwpNEL91XdeTGVfMnRBJH9iMuJqQxEc9XfBjQenyiE300O1ooE0Bh8ju+UlFIduJFSsA3/77/mZr+IbpwRKPSUG8lAHKkbjYsqpdi3sOtF1CuReeBdwCzJj0Huog/XFYpvGOSnjKxThTcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6506007)(478600001)(316002)(66476007)(66556008)(86362001)(2616005)(5660300002)(6916009)(8676002)(956004)(36756003)(1076003)(2906002)(6486002)(6512007)(26005)(4326008)(52116002)(186003)(66946007)(69590400012)(54906003)(8936002)(16526019)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B3h4/vkQpm+ajKGdMvjZ+k3zKwk87YPamhN9FGlSGq1shzprEsOwz345qc4/?=
 =?us-ascii?Q?lh5QfevxkdfZQ5QstruKgUATdlxjcUvo1UlQnpE1Wmzv4UFqv3m6Cp18uGb9?=
 =?us-ascii?Q?SY0JOc6qohp3JiHsB02U+ogXR9rgoAmkM3OvL5k+8qXgfd/EizVHk8swCqPz?=
 =?us-ascii?Q?/j7XtXsRVaUhH2XWBqXTAl+8pYyU5+kHkd+Xc/Wjns+EoNk38n38gaKhsOTY?=
 =?us-ascii?Q?9+zBwM1nDkydKE4cz18ZjAFqpdl1ltND9PiWcv+ktmh8+1TlMZ1GfAH+3gZ2?=
 =?us-ascii?Q?KvFBzPOjKx4gSUybyfhMjwAgBKx+nJpvrV7soGe/TGAOog/V8V59rWL0CIKC?=
 =?us-ascii?Q?gL/oSN7g9rPzTwzoTbWTzCW1lJUT76pY1jznBbyMgiDrP78dE2UBzIqCT0Ws?=
 =?us-ascii?Q?abrqy/fjMr5TsDZO1q0qobUz9fMN6cuqZQUKKJW0Ic9V6qfhc0Z169uQ6mMI?=
 =?us-ascii?Q?4Nje26o/TI+KUx0sxg0TEt2Jv0m/xS6r78H15hATTu54C33BkIbFESkC94Bf?=
 =?us-ascii?Q?f2vuI1B6sSz4ToCGxSp2BqE0bV3DZ/u0MDzS98SMcLovL4CceA2ESeW8mux2?=
 =?us-ascii?Q?3FZpJWj9q3Ms0TCDufbP+aviARM8wg8/fJr5OkQSQWOHPpq7FQh4Tzy/DqfR?=
 =?us-ascii?Q?J3jAQ8sV2qDEFYttFCYJwis2oUNHLlFQWxN86KzTW4jm8x6pmHA/ORc13EV3?=
 =?us-ascii?Q?n+wZQdBDhu0HDV1DfVbNgDg5GbKm9mN0AZO6j64xjTZt4htnvBClTJCq6EG9?=
 =?us-ascii?Q?0uLBDErI0EGjFRJdKevNrZV0XcstTp6tlSkECn50PTWmJbDO9EoonODaZHJE?=
 =?us-ascii?Q?R//vwi+sjO9cAwsZVDPssTJYYeijQQWdtXPZsQVMq3eiyKQjB4nlyLBmCO31?=
 =?us-ascii?Q?aV38xyviwpRSkKLiXsujBIJr+qedE2+9M0jbf12LdDBzbg5hObR27JzEpeKo?=
 =?us-ascii?Q?x6KET1IJ9rC8AnFiBb4AwZxV/Tu9nn9HQ6G1UOt8kQ37NE5Z2lrgglhLiozJ?=
 =?us-ascii?Q?Zl0EzERK7LB+lE1o8cmlCarTp71ZpIJNnpnHy/RkkOic6u8tWFP4CDfmFZQh?=
 =?us-ascii?Q?4LLO2XZJljG/aJkDoVi/6kF4X1d8piGQzRJiBPCtsnUa5HNkVSPRBMNMT/yt?=
 =?us-ascii?Q?xAOBixru4b30f2hTum5bfqmzEJQPDQzmHRdXqOg8JMNaoWn2bIfbE0E2Cyz0?=
 =?us-ascii?Q?nPsB4VNVnVXvFs4fM563dN2gPGpTdI6IgoILzoD0He6K05wwv4rwTCZ3SssO?=
 =?us-ascii?Q?AzMfg5uHzpwzjpJ5dHzVpnpJEJeV+/KaRoGLPeDCmfq3itpQMPFY97+zar8v?=
 =?us-ascii?Q?fNVZpaIz8WKpsAP1lfxTaM8c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae5c73f-d6ff-430d-d948-08d8d9124e81
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:52.4737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nviCj5SVmvoy/hzXpz1BBmwcNxqjHlfgLwW4RW6tJYSc9KFm4v/6ePjPu3xBw24NYtZvwfCt0hu+wbMR8RgNzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Aldebaran is using jpeg2.6, and the main change is jpeg2.6 using
AMDGPU_MMHUB_0, and jpeg2.5 using AMDGPU_MMHUB_1.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 65 +++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.h |  1 +
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index c6724a0e0c43..072774ae16bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -565,6 +565,26 @@ static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 	.set_powergating_state = jpeg_v2_5_set_powergating_state,
 };
 
+static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
+	.name = "jpeg_v2_6",
+	.early_init = jpeg_v2_5_early_init,
+	.late_init = NULL,
+	.sw_init = jpeg_v2_5_sw_init,
+	.sw_fini = jpeg_v2_5_sw_fini,
+	.hw_init = jpeg_v2_5_hw_init,
+	.hw_fini = jpeg_v2_5_hw_fini,
+	.suspend = jpeg_v2_5_suspend,
+	.resume = jpeg_v2_5_resume,
+	.is_idle = jpeg_v2_5_is_idle,
+	.wait_for_idle = jpeg_v2_5_wait_for_idle,
+	.check_soft_reset = NULL,
+	.pre_soft_reset = NULL,
+	.soft_reset = NULL,
+	.post_soft_reset = NULL,
+	.set_clockgating_state = jpeg_v2_5_set_clockgating_state,
+	.set_powergating_state = jpeg_v2_5_set_powergating_state,
+};
+
 static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
@@ -595,6 +615,36 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
+static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_JPEG,
+	.align_mask = 0xf,
+	.vmhub = AMDGPU_MMHUB_0,
+	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
+	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
+	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
+	.emit_frame_size =
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
+		8 + /* jpeg_v2_5_dec_ring_emit_vm_flush */
+		18 + 18 + /* jpeg_v2_5_dec_ring_emit_fence x2 vm fence */
+		8 + 16,
+	.emit_ib_size = 22, /* jpeg_v2_5_dec_ring_emit_ib */
+	.emit_ib = jpeg_v2_0_dec_ring_emit_ib,
+	.emit_fence = jpeg_v2_0_dec_ring_emit_fence,
+	.emit_vm_flush = jpeg_v2_0_dec_ring_emit_vm_flush,
+	.test_ring = amdgpu_jpeg_dec_ring_test_ring,
+	.test_ib = amdgpu_jpeg_dec_ring_test_ib,
+	.insert_nop = jpeg_v2_0_dec_ring_nop,
+	.insert_start = jpeg_v2_0_dec_ring_insert_start,
+	.insert_end = jpeg_v2_0_dec_ring_insert_end,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_jpeg_ring_begin_use,
+	.end_use = amdgpu_jpeg_ring_end_use,
+	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
+	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+};
+
 static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
@@ -602,8 +652,10 @@ static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
-
-		adev->jpeg.inst[i].ring_dec.funcs = &jpeg_v2_5_dec_ring_vm_funcs;
+		if (adev->asic_type == CHIP_ARCTURUS)
+			adev->jpeg.inst[i].ring_dec.funcs = &jpeg_v2_5_dec_ring_vm_funcs;
+		else  /* CHIP_ALDEBARAN */
+			adev->jpeg.inst[i].ring_dec.funcs = &jpeg_v2_6_dec_ring_vm_funcs;
 		adev->jpeg.inst[i].ring_dec.me = i;
 		DRM_INFO("JPEG(%d) JPEG decode is enabled in VM mode\n", i);
 	}
@@ -635,3 +687,12 @@ const struct amdgpu_ip_block_version jpeg_v2_5_ip_block =
 		.rev = 0,
 		.funcs = &jpeg_v2_5_ip_funcs,
 };
+
+const struct amdgpu_ip_block_version jpeg_v2_6_ip_block =
+{
+		.type = AMD_IP_BLOCK_TYPE_JPEG,
+		.major = 2,
+		.minor = 6,
+		.rev = 0,
+		.funcs = &jpeg_v2_6_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.h
index 2b4087c02620..3b0aa29b9879 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.h
@@ -25,5 +25,6 @@
 #define __JPEG_V2_5_H__
 
 extern const struct amdgpu_ip_block_version jpeg_v2_5_ip_block;
+extern const struct amdgpu_ip_block_version jpeg_v2_6_ip_block;
 
 #endif /* __JPEG_V2_5_H__ */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
