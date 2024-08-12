Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EC1C3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 13:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00F210E0B5;
	Mon, 12 Aug 2024 13:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gbZKKOea";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E18210E0B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 13:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc/FM9VScoIhrWjhgQNfHiYQOBXZaUKshEp8nf2PksmW3o9nB3K+e2ZvMVmSSH4RHRSphaoZycfpzD4D5ZOe6u3zR3IAb0dmeoREUTz0gTXk6sEEMURpfzF6u6/CN/68I69S55O1MUgIADB54+LCeedNwXAquCuIxQdMKYExJlYguk9gVJ7wFHn54BM65hRvTcxxgt9Sh883bD1VR+0f6K+kvWFCwpJ3qXByDTbQ1eRWSWF2HLL5uQPcmkQYzD/KcBPbQjV7o/czKp4UwjzhjQCK9Fk2XbzVuUOudHgK1peorfGxpbSPiGwFrLNilG0ybqdZxIuK4I3v0pepZjel/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aEimvRQmOAoa7uc0DVuAsivFiQfyZ2XZFrJdcASdkI=;
 b=vQZlft+M8oS6ens0NpSnML3XOmVggPra7W35wEorkVweMwMjeQpBPfnhnMYHvJk+WYPDLJM5O7yLqWZocVPwtw1PDPkd7aO44KmHhpFZbQSE7pTt3N+c0nIRVPgyhGn5LlEln3ubHBMoq4jxEs1kgGF6Vv+UsHz0OB+vyBweva21iEhWvok4QNs/MhcAtnwhXq5w+91KkjUENEShPZA5a8I8UFYodildwOtrDBx0iIZzcaDZcmmNGETl0lKR3bc4T0mhD0WSJC7mBMaIPR+5INQDK8DvFocxCCpnduF3BMmtyLBtrM4XdokCcjHcttAVqHSXJUovlzRcbBMAG/5bkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aEimvRQmOAoa7uc0DVuAsivFiQfyZ2XZFrJdcASdkI=;
 b=gbZKKOea3mFuS7X+SXTrfTtHUNh2eUUf06+v6F1f3bKXFCgAI/ifnFxVFBTa3zbIuzLhE2x3SXFO/G2eWbj+NW8omFsEGpjZM9dEDlI16NfSJdy8/TPdcUNdjc/NghTpfCGUizIjH5s5LpStNkgwmsHnyDSzS3NCn1ZlQ7z+CF4=
Received: from BN0PR04CA0207.namprd04.prod.outlook.com (2603:10b6:408:e9::32)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Mon, 12 Aug
 2024 13:09:28 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:e9:cafe::48) by BN0PR04CA0207.outlook.office365.com
 (2603:10b6:408:e9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Mon, 12 Aug 2024 13:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Mon, 12 Aug 2024 13:09:28 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 Aug
 2024 08:09:27 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <zhigang.luo@amd.com>,
 <lijo.lazar@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH v2] drm/amdgpu: Disable dpm_enabled flag while VF is in reset
Date: Mon, 12 Aug 2024 09:09:09 -0400
Message-ID: <20240812130909.1011463-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6414c0-eb05-4380-b7f8-08dcbacfff26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W0aqq4PNR4kildKwS0A0H+K9aqx5rcbCvr11vGIIKOihZD2YGtZffaTBJF7B?=
 =?us-ascii?Q?ImZO91L6fff4OLCiwbod1e/4RqZGoLLdT/1Qvzm/34D4NV1QZYzgYMHNSJ2d?=
 =?us-ascii?Q?1kT90NAm/qsnzsLk8uIR/giQs+aPYl0iSFs09LBUhFaYgPBfqzRfSN8wqB46?=
 =?us-ascii?Q?csL8ALoZVhiKZq3kzQY/SNq9sZCUui9AY9bbBtVCfzdHjmk7dJtNTrDQp+Fr?=
 =?us-ascii?Q?a4JQwDp8wuNeyXc+3Q5KWnqNpQzdfQxesLjOt9zb76DsK4yukuVJzm4Ex3YN?=
 =?us-ascii?Q?rwjDI6X+G/uMkIXNOuipK2pwvmE6ZpV8PLNNNLRxB0Zx2MXkbwgCLbEVl/DB?=
 =?us-ascii?Q?ecNhNyzmAJj2vjAHN9BGV6jciYo7BZ6ufUSfcmhaQ703/H+SU7rZbI0w1gde?=
 =?us-ascii?Q?JiihtquWvQluyuirXy9JHlTY1RR8xX+jae00iD4OCROJ9Cbpt9u5yY31sKnb?=
 =?us-ascii?Q?PhSfsqLN4SB3K5dWJHYNznSgypdkM9bpOdUWDFtSvuqB8SGdA/vWBVtB92Vk?=
 =?us-ascii?Q?X5GU6Z/s7vseGg57WYnptUngTHO0fzy0YEmzwtz9y1TGYJU3ftgHL7EbksPl?=
 =?us-ascii?Q?Rmu3RMmYVuIF0NysJVIu/lBMdvbeo+R0+wfGpZagq88eCDLx/uLDzwy/L/Vp?=
 =?us-ascii?Q?N27c37cLO20Fikxf1I3E2hBDhPkpesS21UXAD6wN9LIhQYkRnXRoSdMdPT8J?=
 =?us-ascii?Q?0xrjReUvysJ2qzlNj6tRkYqkfKI5CQ/zSvbLI/IrGcy791/CNn9wiAceL+Dy?=
 =?us-ascii?Q?nIT755NtU6yKwUv1bUoCk68HsVWEprgyehS72v7FCREm6NLcrZkotKj+sJWI?=
 =?us-ascii?Q?+/2VkwoiVij06NnJBjLjIjJ+d7mGevB0StrCoY9dfsQFYP3e7hsfqjexWfDT?=
 =?us-ascii?Q?10IxexDRmhi/JCVsZyRoKQ6EdhFfZ3V2fsz8gq0XGLGndfoVnb0VljW4JWX9?=
 =?us-ascii?Q?+1waF67nl/jyJiBazqXu6VArlVNZod/z13OLsT19Zw1/p1KteMNZHsOkIhoe?=
 =?us-ascii?Q?2Vzvh/6vtzEBbsRv7d7NzuIa8RLe26HGl0FzmcFMAKgI0/DgBzHIaWVMUrDs?=
 =?us-ascii?Q?vE7gLd/e7n9QeqpjlVQRn4Bl+Sf2sEf0eJ0iOGVXKTg3rJKwwAVaKvv9uqwd?=
 =?us-ascii?Q?+QOVllACqxNZJN1QHOW2WMEkghsfauJBxKi6xFNc1VeW8eiPllYpIvjhAZRM?=
 =?us-ascii?Q?PtKxYHejNaW+yXJMUbyvVByCROO8vcDu5sRGcAxhv8xigrHTFNbahkM9F+LB?=
 =?us-ascii?Q?CHX82mxBMLDznvYr2jQpLCenR92XGixuLGwFOHaAiCPNC0Bxx8sS45wWFkIj?=
 =?us-ascii?Q?DCbwIc+8JWLx6Ggfu0XVimVPv9lqDUDyOD95wnAlsoF1x3+8GLKZVb2EkyQK?=
 =?us-ascii?Q?+KYfy4FazbvnYvHcXc/sESUblqZOAmmY+4y95tygi8Pjwy6lehc9KZeLd7wk?=
 =?us-ascii?Q?Z8QN6f+ZiyVG59rjU0yPtY4ni80OSaye?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 13:09:28.0866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6414c0-eb05-4380-b7f8-08dcbacfff26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
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

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c       | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h       | 1 +
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 5 ++++-
 5 files changed, 16 insertions(+), 5 deletions(-)

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
index 8b7d6ed7e2ed..af39206a2c5f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -168,7 +168,10 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (pp_funcs && pp_funcs->set_mp1_state) {
+	if (amdgpu_sriov_vf(adev) && mp1_state == PP_MP1_STATE_FLR) {
+		/* VF lost access to SMU */
+		adev->pm.dpm_enabled = false;
+	} else if (pp_funcs && pp_funcs->set_mp1_state) {
 		mutex_lock(&adev->pm.mutex);
 
 		ret = pp_funcs->set_mp1_state(
-- 
2.34.1

