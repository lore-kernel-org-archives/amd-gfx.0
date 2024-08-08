Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0695C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 17:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A0410E7AB;
	Thu,  8 Aug 2024 17:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EsENS41s";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B426010E7AB
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 17:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTbWUJBxt3+j5xNtOa9W2eyDVBYpWqk/xOmhYuex/wU25aSteSIF3ecFlsmS4WpaFEEsSrZtlS9nvAgOVRtAk+BFZisYGEciCjtu5oxwtySaraemnBjoNGvU62MdEU1gWYHGM6KNIS+x73IslhU7IPFuJnO2pZgqQb0upZefUzhGAB7WUH0/pG8nnKF/4L3oKSfuw0MgYuj2DpS8L+q4rTeb+xs8q5mBaM7MGMT/smDTSKkx+/p1lpYy2CvEQcYpmCnk66cvcA/T7OMjoXQ0AjAw6AuttVnDYSPoTWwJ4F3ghKYQxy9C/Oybh0qXsQgVpohW7+rx0qnxBEqVDmX87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s97V/TZXVgQZp9IrZR5pfTbcukQPiBz35uTaI3fulO0=;
 b=frOtmuHVkAyP1jh/mZGHQ4XqCAhGXABw2PS4ZeYufQmP8o0Pm6f0WsNrtKX3RqvqOK2qFvPe/N/iQQfZiG77kmRXVReNJrfPYFD0MNnpJN5Qh4ShIa4ICRHtWNgixmhK1nvreZHkLYFIdgCkRoVnwfUk7kFti33y9p6TfkshmvAxwCT3qhyP850bb82n73yobtSSNAry9qrRJFcLV6HamCv3+crsbK4uziHjE4Yif3Y5KhWBNEI1aQSuj6eHsJdnSfimm7fqaVgM7du3J97jRNdFLBzlwrti4DvcyZhcKfieTigsT9mZLq16ySAvK0JgMc/MZNSyVLuikO3nQXkeig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s97V/TZXVgQZp9IrZR5pfTbcukQPiBz35uTaI3fulO0=;
 b=EsENS41ssDhNDIn5vCmPbXNKMI5+DCZ/nDP02yL5dQz7F/IRrOi0ru26t1xnlmrSpNIfy3TjvG/5H/B3JkE0xW+nGXQR23/MU0yoAQ3bkKUlGBFdBjdmxko9N7MAVwN+azMQFS+GCo6KCxD0aAgP35jnYsmJryh3xvC64OcLAmw=
Received: from SJ0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:a03:33e::26)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 17:27:19 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::81) by SJ0PR03CA0051.outlook.office365.com
 (2603:10b6:a03:33e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31 via Frontend
 Transport; Thu, 8 Aug 2024 17:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 8 Aug 2024 17:27:18 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 12:27:11 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <zhigang.luo@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Disable dpm_enabled flag while VF is in reset
Date: Thu, 8 Aug 2024 13:26:53 -0400
Message-ID: <20240808172653.56503-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 39144b65-6438-4176-becc-08dcb7cf5a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H0p6xSeWlvHIWyjuxGk4krtItBM111C4HeyHiaX/3Ap/lPEKaKx7D+1LyCSO?=
 =?us-ascii?Q?WtWkmrFMnIJ18Yjf2Gxuwfdfu3Ma8yyia0FpG9bqKLXUbh+CwJm74sgYP80j?=
 =?us-ascii?Q?0KngIxMylWQ6oH/4OIoi5raDwJJelx1A6/FGHM4q14Janrvh/c4X0j3XJ3Xd?=
 =?us-ascii?Q?BUzWtC5jIVVQMzRwwKj6o6rk+NAnMUxlrOWGXqvv39fjm2+Htq/HYzUCYf6t?=
 =?us-ascii?Q?ftiCWwlEbdJfSHoiJsAt4Bd1x//bu9ZG2whP8Y3ufKfm9RB1VjmxG3Gw/KGE?=
 =?us-ascii?Q?wJcfzopBoaoNim44+vli2mdU9Pb0igLio8WIAoPPltYC6azVT8qpvOQMk51Y?=
 =?us-ascii?Q?kjnQS+jHyGb3JZz/I/dVvyW305zl2EwC4BiK1RoZ6IMTV1hDzO40ZANKe7Pt?=
 =?us-ascii?Q?cq062yGia6yKPjUsIWnxRq9n3i2ac2w87AOjPq7BDATZc5SN/udGa5EQ8f+B?=
 =?us-ascii?Q?lPJkNQed0e61h/ZqeKTQExzeJ5ASoJ5OGx8wTauP91eoXdhwfLy45iVdrfa/?=
 =?us-ascii?Q?4oOmlSdcvUNQEEMJ1uBi3sVHTXbSbcuXgAakjscbgeKBxdpWHEjKIzWABWzZ?=
 =?us-ascii?Q?MGAxJxAgeI8XRnaiRx0AgtoWEfptC573HqMGizqUXYUvooFejk6ApXOQ0Vz0?=
 =?us-ascii?Q?5e3Id0KOZQu0uQgaC1RCasU1dUlgFlWu9lw3gMlp+SbpCL97yW6fsr14u3rg?=
 =?us-ascii?Q?rMFsFPnM9UgR7PGsQc2hIcCYcwqWAGh+HlxvAab6kU08XXcR6OtmCARjn6wH?=
 =?us-ascii?Q?5rPCsTqa1Iy+mzPE1BE6sblXz1NJTGl+FVUqNqKyF/mbL13uhcALBH0ROWaP?=
 =?us-ascii?Q?gLii2ftZWfa7dCxf8MDN/MNQKM9ZZOQUcmokNgo3oEJmJv9UzprU48U3gaJ7?=
 =?us-ascii?Q?miWeca7hJGAqd64IEq0uzMmmcS8NGcYOskfqrLsZTm5AlW3bE0m8fHEyxPzh?=
 =?us-ascii?Q?oI1coXPEaXesZfG+brCyX5t2xSmbN05SBzya420i7xRg9s/20g8QtfyUNACX?=
 =?us-ascii?Q?We4VJMfVWgi5RpFJsnwREaKO2ddGCF9TK3oLSDzz/iF6HJVceVAsSDLYjezD?=
 =?us-ascii?Q?TMx+mLtPzBlV5yHwC8fzF1pmCgNWB0QbNRgiSHjR6/LFyRiP8Zg942KGtj+k?=
 =?us-ascii?Q?xKz4v4CmIdMJ7yTD5Y/KEYQcC8F145s41AomKPbCDzG+ONC29ssCGFDJX4No?=
 =?us-ascii?Q?ZH+25qAhx+mni2+YUZU02/sEgrjY+WOR8oT8LGRL207MeeFsdHUsJNgC4eVW?=
 =?us-ascii?Q?PleD54usmZDb1IOoXpGnd4d9GiBValncEEuiRfAMvpdQ8M4/okD5q51pO63B?=
 =?us-ascii?Q?q+RLl52zjlgvnwTe74tMK/ZJK+UGtAqf7kEbIWclpskmxfq+ZTQu7ElybzfL?=
 =?us-ascii?Q?obr+3oujDuBb+zFEK22nobxsRGVNkRyd6elVcunynKMNJsh+YlLnofpb/46P?=
 =?us-ascii?Q?DDvdl7khWK0cTgRX4WolBh4eezN8NmJ7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 17:27:18.3663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39144b65-6438-4176-becc-08dcb7cf5a91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569
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

VFs do not perform HW fini/suspend in FLR, so the dpm_enabled
is incorrectly kept enabled. Add interface to disable it in
virt_pre_reset call.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 10 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  8 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  1 +
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 21 +++++++++++++++++++
 5 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 730dae77570c..1be5699f4190 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5288,10 +5288,8 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	if (reset_context->reset_req_dev == adev)
 		job = reset_context->job;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* stop the data exchange thread */
-		amdgpu_virt_fini_data_exchange(adev);
-	}
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_pre_reset(adev);
 
 	amdgpu_fence_driver_isr_toggle(adev, true);
 
@@ -5561,6 +5559,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 
 static void amdgpu_device_set_mp1_state(struct amdgpu_device *adev)
 {
+	if (amdgpu_sriov_vf(adev)) {
+		adev->mp1_state = PP_MP1_STATE_FLR;
+		return;
+	}
 
 	switch (amdgpu_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_MODE1:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 111c380f929b..456a685c3975 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -33,6 +33,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_dpm.h"
 #include "vi.h"
 #include "soc15.h"
 #include "nv.h"
@@ -849,6 +850,13 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
 	return mode;
 }
 
+void amdgpu_virt_pre_reset(struct amdgpu_device *adev)
+{
+	/* stop the data exchange thread */
+	amdgpu_virt_fini_data_exchange(adev);
+	amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_FLR);
+}
+
 void amdgpu_virt_post_reset(struct amdgpu_device *adev)
 {
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index b42a8854dca0..b650a2032c42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -376,6 +376,7 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 		      u32 offset, u32 acc_flags, u32 hwip, u32 xcc_id);
 bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
 			uint32_t ucode_id);
+void amdgpu_virt_pre_reset(struct amdgpu_device *adev);
 void amdgpu_virt_post_reset(struct amdgpu_device *adev);
 bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev);
 bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 4b20e2274313..19a48d98830a 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -218,6 +218,7 @@ enum pp_mp1_state {
 	PP_MP1_STATE_SHUTDOWN,
 	PP_MP1_STATE_UNLOAD,
 	PP_MP1_STATE_RESET,
+	PP_MP1_STATE_FLR,
 };
 
 enum pp_df_cstate {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 78c3f94bb3ff..b85478b1eaa7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2638,6 +2638,26 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_v13_0_6_set_mp1_state(struct smu_context *smu,
+				enum pp_mp1_state mp1_state)
+{
+	int ret =0;
+
+	switch (mp1_state) {
+	case PP_MP1_STATE_FLR:
+		/* VF lost access to SMU */
+		smu->adev->pm.dpm_enabled = false;
+		ret = 0;
+		break;
+	default:
+		/* Ignore others */
+		ret = 0;
+	}
+
+	return ret;
+}
+
+
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -3283,6 +3303,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
 	.send_rma_reason = smu_v13_0_6_send_rma_reason,
+	.set_mp1_state = smu_v13_0_6_set_mp1_state,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

