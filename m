Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEFCC5320E
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 09:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14EC10E23B;
	Mon, 19 Aug 2024 09:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UxU/KeU1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5565C10E23B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 09:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIQF7P+WMb19y0wKMlJn1VXBa8vSO94ATo/6ii+nqtRskCGUu8WwVocULLVnpxTaNo11ZX0BDFAqod9np5aG8lPJlstH5ybL2kYmee+gHDXrENxRUBMpfmLQaRkO8vwIAskmnCdxgWZdGXW6qbJosb4WyTg/0tZOjXM2Xc2Vw1DTuPnkLS1hHm+xhmMEyZC6isULoubmnn9DVWReVbMgWO87mM4rR4E2/NSHq77s3455jhVTM3lnZwBQzOKQ2BJAr/3quumSa53LtPHLU6C+FGzdnn+mVV9C+G8FReh0Z+5s2fq9L1HEFziimdsr02IOWvgDMMthx1GslHCGpmlPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beqk3DLlrDIfQ32VHSmivzpoF4NaRIKtDqF9r2TU7Bs=;
 b=oLm165ddiPhP4mV5FeLsLsZrs0NGqhDMU3up+AU2yqg7g5dzfjBjuXLPOzIAQW0sPNq5TqvaTc42MaU5PUfIi6Ch0H8PAbNGgqWWV54sZLNF5Z/ygKwFcDH71DtW8/7ILB3uNRB2I6KvpSHkHachKK/0xNKhIG1rAshnYoJGakI4LMsFdBw1J++KQaU6PjgONI68IE7ZXkm3CL41Fuw2+QsweYLbk1IswgDceUpgAjxUmTsQag81vu76KyFu9g1W/vljiaFAltrLSSIMArzxJCaSHqgXvbhVAiOzAZoHunaxEhoBCOzaCXPfFDf+9DExfX4AKkGEthvsRc3ls8sScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beqk3DLlrDIfQ32VHSmivzpoF4NaRIKtDqF9r2TU7Bs=;
 b=UxU/KeU1fA/X2HnMgk9pH3igDB7FNT8WCSv2cpVTRHNkCm/jfUZ6TnfPS8Xuss1s7VAGkkzkyaXGfNi3hlsWalMcg1seQOp9qjjNptCvWKoLroMg7e/BUPv/BsQ/HzqIh02aiTzcrz6khyobn+/dk7hPU4F1i/uLoJwgOAbEPaw=
Received: from DM6PR04CA0023.namprd04.prod.outlook.com (2603:10b6:5:334::28)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.20; Mon, 19 Aug 2024 09:53:48 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::24) by DM6PR04CA0023.outlook.office365.com
 (2603:10b6:5:334::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 09:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 09:53:47 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 04:53:45 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: skip printing vram_lost if needed
Date: Mon, 19 Aug 2024 17:53:30 +0800
Message-ID: <20240819095331.460721-2-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819095331.460721-1-Trigger.Huang@amd.com>
References: <20240819095331.460721-1-Trigger.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 1216d2b1-31cf-43ec-87c5-08dcc034d269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QTkNco4QkQMwp82Um/WHwclH9hfREYiQMrtFojPxsl++Uu2aqnTEj6TewxGV?=
 =?us-ascii?Q?X21duhLJG+J9s7RHClaMGX2Q+DUhEnX1GjG9zVP1F62qSDrgnG12Y1xt9NAB?=
 =?us-ascii?Q?gqtZgL+SlQFhH2bV9VwioSkl/tb6tx31dUAhzdvFdIwEcdMzE3lTmAEbTWgq?=
 =?us-ascii?Q?bW2Pfpp7yhPPXPU2mS+IEGa1caDewCxoVWNwrg4r8E4R5QPIPwivjGxvUBpK?=
 =?us-ascii?Q?G04DfRr/wFHUuCd3XhUPaRhqL3rrR/BdMpFjOx+HInrQG2Uldxx9ExH/C/MM?=
 =?us-ascii?Q?dmT094IPfZdWY324vGOEDTQxTpGgA/Vl6JgkDq7/BtozFLzYuPxigghrUeBp?=
 =?us-ascii?Q?j/DB/3a7UaViHT2eF6dVxnF57R4ob7q93cwI3Rp7W8MyzPEUN8cEwLw9DNMQ?=
 =?us-ascii?Q?6xY4x1XiTrk6lC4oiynEpB+NRgip9kjvWCFyNZWNGL1D/ndvgOHES7MA8nHd?=
 =?us-ascii?Q?3gF+q04DJCANq3yxcXtcVzEESwXB4D+cnyRknC8s1qmpsg60Yp5dTu0UqN/m?=
 =?us-ascii?Q?0pt55Nyd3AXqccB4vzSEGu0C9/f/FBgXY2KpwSPiU9OMvWqdHtPuT+IQFWLD?=
 =?us-ascii?Q?Sjr2p+uJ38Qz2CWhzg6/K6jnerjPTXzKc7O36CrA7sw0BtNYiIJ+QQgTayLR?=
 =?us-ascii?Q?Y9Qvi0U24sepCvxR05n8qKS/NF6S0qVq7zJRuR7spibbc3kA4nUj4k0BYNnG?=
 =?us-ascii?Q?sjIcfK9ZDeEWc95rjVxwG6IajM3OFlzsqIU0+hNJhVWQ1AKL7ULvQUHGXYE4?=
 =?us-ascii?Q?rCFgqku2qLi6QxCd0VSNSGGW2rBN+vMObNPB7+21plBWP7VWRBVqk2D6U0/I?=
 =?us-ascii?Q?etGV7OpTeXbDRSjq6kcGRWkuSO5/SdxwFYDMNepieLzbNaG114K6qZq1MalO?=
 =?us-ascii?Q?Qhsc1KCur3wGGtYHJABcdD7HkzzD2ESGRqcAs02y2LxTguudDiI6b7IEYdvS?=
 =?us-ascii?Q?8B76IoYvEgFtlezkjIFu+YZ2Y0dYKXBXZPr1/u1kGHhbezU9fcsEDGripclJ?=
 =?us-ascii?Q?9c6qw8fJbzxwmY52eNTcKSerOPWhAYy0HSEV8yv+s2S34LA+TIUDiX+WLoBM?=
 =?us-ascii?Q?U/CV7wLoc8CJahZF6blPnX5CXpPp7kT7+fVvhbnqNiq52ZGJSKsupzYEmbvp?=
 =?us-ascii?Q?+Pz6EkB3fDISeTXEIdUMdWJcofFgkDFo+Omo24A0LzsynJX/wn/5m6icVrXE?=
 =?us-ascii?Q?hYk+5FOASbeoeH4vNq8xG7Il3kFfrFk9sXtcLO82kMAU7XO6yGC0iDvlroT1?=
 =?us-ascii?Q?hAFcqhR9Tma6J78mlvFW957g+Iz73vaZhYN/R/jw5E9GHx5Qe/oAzNgm0zYD?=
 =?us-ascii?Q?6qYqfn7WdOYjWDOnM6vuogFe9Byqyn95n/CZAqJxr56topc+L6/5wu/HBUj7?=
 =?us-ascii?Q?p9yiMvAtSNcwEmzaVGgUOV7S6rAEvgyyKtyPEJtcTCbW/EvLFJJOBpbZ/S5o?=
 =?us-ascii?Q?xMFyICkR6N8sLVEHzEY7NCWdiKS8kLCW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 09:53:47.9637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1216d2b1-31cf-43ec-87c5-08dcc034d269
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
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

From: Trigger Huang <Trigger.Huang@amd.com>

The vm lost status can only be obtained after a GPU reset occurs, but
sometimes a dev core dump can be happened before GPU reset. So a new
argument is added to tell the dev core dump implementation whether to
skip printing the vram_lost status in the dump.
And this patch is also trying to decouple the core dump function from
the GPU reset function, by replacing the argument amdgpu_reset_context
with amdgpu_job to specify the context for core dump.

V2: Inform user if VRAM lost check is skipped so users don't assume
VRAM wasn't lost (Alex)

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 20 ++++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  7 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index cf2b4dd4d865..5ac59b62020c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -28,8 +28,8 @@
 #include "atom.h"
 
 #ifndef CONFIG_DEV_COREDUMP
-void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
-		     struct amdgpu_reset_context *reset_context)
+void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
+		     bool vram_lost, struct amdgpu_job *job)
 {
 }
 #else
@@ -315,7 +315,9 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 		}
 	}
 
-	if (coredump->reset_vram_lost)
+	if (coredump->skip_vram_check)
+		drm_printf(&p, "VRAM lost check is skipped!\n");
+	else if (coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
 
 	return count - iter.remain;
@@ -326,12 +328,11 @@ static void amdgpu_devcoredump_free(void *data)
 	kfree(data);
 }
 
-void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
-		     struct amdgpu_reset_context *reset_context)
+void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
+		     bool vram_lost, struct amdgpu_job *job)
 {
-	struct amdgpu_coredump_info *coredump;
 	struct drm_device *dev = adev_to_drm(adev);
-	struct amdgpu_job *job = reset_context->job;
+	struct amdgpu_coredump_info *coredump;
 	struct drm_sched_job *s_job;
 
 	coredump = kzalloc(sizeof(*coredump), GFP_NOWAIT);
@@ -341,11 +342,12 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 		return;
 	}
 
+	coredump->skip_vram_check = skip_vram_check;
 	coredump->reset_vram_lost = vram_lost;
 
-	if (reset_context->job && reset_context->job->vm) {
+	if (job && job->vm) {
+		struct amdgpu_vm *vm = job->vm;
 		struct amdgpu_task_info *ti;
-		struct amdgpu_vm *vm = reset_context->job->vm;
 
 		ti = amdgpu_vm_get_task_info_vm(vm);
 		if (ti) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
index 52459512cb2b..ef9772c6bcc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
@@ -26,7 +26,6 @@
 #define __AMDGPU_DEV_COREDUMP_H__
 
 #include "amdgpu.h"
-#include "amdgpu_reset.h"
 
 #ifdef CONFIG_DEV_COREDUMP
 
@@ -36,12 +35,12 @@ struct amdgpu_coredump_info {
 	struct amdgpu_device            *adev;
 	struct amdgpu_task_info         reset_task_info;
 	struct timespec64               reset_time;
+	bool                            skip_vram_check;
 	bool                            reset_vram_lost;
 	struct amdgpu_ring              *ring;
 };
 #endif
 
-void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
-		     struct amdgpu_reset_context *reset_context);
-
+void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
+		     bool vram_lost, struct amdgpu_job *job);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ad97f03f1358..59a443abc11e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5468,7 +5468,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
 
 				if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
-					amdgpu_coredump(tmp_adev, vram_lost, reset_context);
+					amdgpu_coredump(tmp_adev, false, vram_lost, reset_context->job);
 
 				if (vram_lost) {
 					DRM_INFO("VRAM is lost due to GPU reset!\n");
-- 
2.34.1

