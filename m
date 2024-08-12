Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48BEC3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 14:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ABDF10E236;
	Mon, 12 Aug 2024 14:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qXZiMVCv";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4211B10E236
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 14:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ2Vl3YwnsyV6EX+IH5vYfi8mdiEeoTXOACoKATATKSeS9mabAc2fXcKEixe6PragkLWEarVkFOf81Othe3FS/2YWjWUXG7Wbq4FeRLzXb1CAI86ecj73asvFWwL3Edcv2wHbMkYSAZy16Am9Qt1ZVi6Nxxfu9G+vA11jsli730N0mYX2lzCDOIcYXcSm16Xve7XkiN3v5qjC7J+jW2N/ZKmc+6DsnlALqA1KpcQC2rxIw0I0WyNScfu8TEsBxNM61djvrCOYrp+nlgcp7lkMBSPrJFdEImvJQfyfP3f02A5TxOesG1qxAwh99XcIjZAkTeacA9TnXPcsffjn1Qq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/isqnd2pySDeg1AFSqyUVUAoliPtHvJ2/U0+Kj7viKs=;
 b=DGP7DpeXCcPOkqNek8ms479cTK7ej/RrkZGByTFEI3tQqkxKIHtxhQySh52RgszTg2afnv+Zh9TQVgPDIB79HBgKph1iOGp2H9+PlsXgNUbnKFg9m+30P0GUpwW+nGr5ioASClZQdMUTiyfjZAE0lpNpXqNShgycI6RBmo8l9epyim0xmxeDLDJmm8yqgmUs5pdyAdZYiuz7kYkglMby9QX4WQ64CH61sWTU9BZ1Y8Q9mOG6PGY/VgxT36g3uSpwjJyMgbTQdX3X3QigVdkjV5/OV4rYxjeoK5+2m9CVd5HuqLuL58tCRM3q0ujrYj6v/L7KiukYaAw1b0Y96LN5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/isqnd2pySDeg1AFSqyUVUAoliPtHvJ2/U0+Kj7viKs=;
 b=qXZiMVCvI+Dfg5yokgeS8oHUfIbARmvjQCfKArGT94IQI3Qypn9cO+lCYrdxYcqYEFJt1cB7SQMSaPvK/5IY0LkUYzWjlruwvoewI8Jw3u9eLZ/qrgwtjpqw9KHP+Zcjk/4Qla2hx0nlNMBY7i5Z8X1dLmkbU48mUsMu0cgNG3k=
Received: from SJ0PR03CA0077.namprd03.prod.outlook.com (2603:10b6:a03:331::22)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 14:23:21 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::9b) by SJ0PR03CA0077.outlook.office365.com
 (2603:10b6:a03:331::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Mon, 12 Aug 2024 14:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Mon, 12 Aug 2024 14:23:20 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 Aug
 2024 09:23:19 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <zhigang.luo@amd.com>,
 <lijo.lazar@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH v3] drm/amdgpu: Disable dpm_enabled flag while VF is in reset
Date: Mon, 12 Aug 2024 10:23:09 -0400
Message-ID: <20240812142309.1539884-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c267c19-f8bf-4307-284e-08dcbada513c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZdhV92opx8Z6O4rzbLgtpfllLfK0lgdmny/IfTbfk4DcOSWIO9Pd9gkmDAHa?=
 =?us-ascii?Q?Rqpv1yInpWuCEgYCI3rjAMw2e4WMD7//PBt8Bw/w4AcusUQUpoLfw1iSiS2e?=
 =?us-ascii?Q?RSBurEEIQD353cQ2SWYLNJMNZG1BR+O2Ziq5dqOL+voNZOy04pd2ehH9jdHF?=
 =?us-ascii?Q?UK2vpfmp/gagvS68KBaVGjkMEV7C2x6fGNnsgmJIENwdi7uRg/CSBlUB+toh?=
 =?us-ascii?Q?KEzv41ZZGsNpEut0Da7KsNnCgWWEpVRjDcc4E/ovMAkyLvcTFKt9tNkZTXQS?=
 =?us-ascii?Q?GGjLZz8QffGbSN8ek/W13fwaTzU+79rSXigwHJvfGTfxJu03wEtMezz45oKE?=
 =?us-ascii?Q?5/v96Ke3V4qpyC1TT6cvm38kz/4OSjpGyb12QgJsoe65YSn3rryjBrB9Smdq?=
 =?us-ascii?Q?+KmwV96cvhaZH073Khv4rPtiEaTxVfxDexZCCx+E12or1pF+dewnugoOZg6z?=
 =?us-ascii?Q?mugahsTt5xTS9b4OTTJbX3E49cRRj2T12QkXiScKDFRBOksU3HqkR2qzCURf?=
 =?us-ascii?Q?0bF+AR8yebNhFN28sq9O3RAMCcpYW+d8+J9U6LsxdLaHRbP0ake3aUxscBvn?=
 =?us-ascii?Q?QaFxuEehILH16sVNX3Oyn9qGOCkCKqUilhMG01B2busi9Yw8G5ofgwxkGI1K?=
 =?us-ascii?Q?1fceUPeaBDufOfuKNQCFxuiuF3CyduDGoEeyU0tdyUQudbzn5/reEEEE52vi?=
 =?us-ascii?Q?ectte7lr6QRvTSbkoMOY5FE55u+3U6UvsDVLf8BKsPKrO7vlhcZ3sB/eXWlS?=
 =?us-ascii?Q?eSRjdgToAzhQOm4kieDFbN9yvN5jrObKYzcNac7tep/8OD0dp0CnU7NwtQGJ?=
 =?us-ascii?Q?rIGAhHFLdfHC31hsB73drlHN9DGRl4ue2LzmGIErPQl0VX5xwcrluZQXbfVq?=
 =?us-ascii?Q?is0aZnZSCc/ptZlOitddcvzkVAQG4XO7pVc6TV4jOWpQF8FA1ZQPggLy74Nq?=
 =?us-ascii?Q?IZemyRAsU6ehJlN4ikxZIe/rH7ulJIbHNlHe3rcrLabH5ldjBDc7VcaRsfSG?=
 =?us-ascii?Q?toOv7kAVlowDsBlOK9sd74I1sPBcrdFeawtLYcj2xFA9QZAmksRGRjquU76d?=
 =?us-ascii?Q?MCH39cfu80uSWJrdIinkskHBpG8VrJikKGOyn2syEknYq4PQIzDfXrq/4rbT?=
 =?us-ascii?Q?JHosYsS7DLt59W21bl5olrf/jFRV1dlmXMnBJFa6Zbg9N0cbv+KO1EsjYr6r?=
 =?us-ascii?Q?DUYC5W1rYEVC18JJhLrUeCGx8x2RYR1ARwA1EWnblUDOnqwlPYU25BIzMzX7?=
 =?us-ascii?Q?QP8U7TB3GBxaoZfIIdhs4QCC46SpKA4/duSF5l8D0GEmK4aiyZPorFN42c/P?=
 =?us-ascii?Q?KVpBsetMRpGnR1ybwlH/uNehjyfP4TgKHstObDVEV7QErqoWh0nF4ErwJ0bL?=
 =?us-ascii?Q?aSa5SnFxYw2nrUIb3wYu5Zvu01emA1o4vdaY9w/TlSKWflc3uA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 14:23:20.6739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c267c19-f8bf-4307-284e-08dcbada513c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
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

v2: Made implementation generic for all asics
v3: Re-order conditionals so PP_MP1_STATE_FLR is only evaluated on VF

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c       | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h       | 1 +
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 6 +++++-
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 29a4adee9286..a6b8d0ba4758 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5289,10 +5289,8 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	if (reset_context->reset_req_dev == adev)
 		job = reset_context->job;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* stop the data exchange thread */
-		amdgpu_virt_fini_data_exchange(adev);
-	}
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_pre_reset(adev);
 
 	amdgpu_fence_driver_isr_toggle(adev, true);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index b287a82e6177..b6397d3229e1 100644
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
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 8b7d6ed7e2ed..9dc82f4d7c93 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -168,7 +168,11 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (pp_funcs && pp_funcs->set_mp1_state) {
+	if (mp1_state == PP_MP1_STATE_FLR) {
+		/* VF lost access to SMU */
+		if (amdgpu_sriov_vf(adev))
+			adev->pm.dpm_enabled = false;
+	} else if (pp_funcs && pp_funcs->set_mp1_state) {
 		mutex_lock(&adev->pm.mutex);
 
 		ret = pp_funcs->set_mp1_state(
-- 
2.34.1

