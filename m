Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1233C88E7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEBBA10ECA7;
	Wed, 16 Sep 2026 17:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ELyb6tND";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010046.outbound.protection.outlook.com
 [40.93.198.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2580B10ECA6
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5DD1SI0sDmncMu88j+RUaH/ITWXeeTu44ngP+wsUS2Y9l0hT4ptX4C5+fnSaXS81M8Bvrs3V2PEtn40OzM46k0e51mm9v38aZo42QsjDEH+GeT26sCWijC9kUbPnGLp8Rd/PPnKgS7NSn4r9yr9nInO6yruiX2Bw+gnC1EoKnqFqGHKwjEgryIVySTPuq9A2zN8AfMVzYbMZx9CK81UPHHLx83rPKVFV5du+wn13j5WtF+vNpOv3ox4043qlAQv9GaWr50ErF/TwnBjTL/KSx9gSGXWcBl1Lg8IHs7iG684zWvb7TlgPfth4WgWago/KPCkdyPzPAtSNg5yv0eBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vh8ax3Eq6XQBHQ+sOHeCCxGX8n1yA2Omi4YM8rHSukE=;
 b=vJEt89m9fP/adcgvnKhz+GbpRvDwfSNrGjF0Zpxskq/baYwq/rI+ZyzwbSOdV6l7CVq69kbFIC9wgoXw8EiJCdIWIM9Dia0TVXl6bqXf84sxfw+cdgiXR9r6sFs0AlUxoQ0VnYciyj6c4uSxfZJH1uPU2JQnRK+qIH3TOIhubY/bmYLINCM/FN/t1J9Mu7t37Txvqn30dV1ePiMOBGs5kDDwQ84tydgI+q1dFXxhRwOzdfTUJIRc8Q3WqARIrPHX7eAZW3QV6XN+7MCYsAZzk8NFhlQDl3zOh5T5wZq0ysk5BRPtBeobHS9L9JLnyhsTs0CW0ex1ZqDJdeWCCqkxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vh8ax3Eq6XQBHQ+sOHeCCxGX8n1yA2Omi4YM8rHSukE=;
 b=ELyb6tNDPQqxu1gavYLeSjAGVqGmb4slq698v4CPPX1VPZSjrlHZYgqxg/3sd32PxQUKssZnKA4M5DuoYJHkIXHixOOIOIqUvY7txrhnlE12NSMnk4qj34+0oHRVQ8vzvX9GPyu8c/X6TPM2/5XmbqKLf8jVpPFVRUS5/4zWqUA=
Received: from CH2PR10CA0015.namprd10.prod.outlook.com (2603:10b6:610:4c::25)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:43 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::1a) by CH2PR10CA0015.outlook.office365.com
 (2603:10b6:610:4c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:43 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:32 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, kernel test robot <lkp@intel.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 25/64] drm/amd/display: Fix amdgpu_dm's kernel-doc warnings
Date: Wed, 16 Sep 2026 13:51:40 -0400
Message-ID: <20260916175301.368306-26-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 493837c0-af66-496b-0003-08df141b4f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|6133799003|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +eSIqtlwHvJ053rCZ2BzgbHLWQCbCFMmcemycXlPHoSaWO3W3gABaqi1bgouoTbCLA88qtQS8V7HiBkR6k9la/JXg6GA+F8idEuY0vBpo1KqhsOwGNclRt2z5CI6V+qw3ZsfxJlO8bSnwtFJkG/w5yD4/gYTil3YSS5gJ+0041iyO36BCUnPhW+1JA5sedgJnNTmPB/rfwUfd5i878zvfe/j9k+5cRfyTlZkkt4jfMZTRfARnM9GY/NQhH/bqm53vRpJ+JMDPve214qLOU5hdsdCG9tw1hU4ONxOr+vm1Czi/9dq784hACDZjOy9I9ppcXQmCUymy3ORHxylyoLpByn97JFGemST/p7YM9RP67jQnBw5NxqXMeqf+gn9p0UT8VfW+bg65M31dBNLvWe6z5ww3bWwUK4I4Z77G5wtN+9lxO5uDCN4DJvhkeM8b03ueAA5Memlku+bh0h1lYPybkRR/aYtrv7rRJGKTkDwumbYe8U9vCquaVS31LQqpP7QLt05utRPm/wSLa+q2dF9LayZZ5+xYR8QEk0Ujrb0GLeq8zU7kjUI2HzK7glXqAKkg4Wq+Eb6+nW1it2RsKQEG3FstOcvnj4xWSNc/itWmQaN17Ts4ub2TkAOQbi/NWooYoTMIumnnPrbOnbMTj+66A8F6JxjkP59pl5V6EfX8gbZIWqznvlJaA5yE71a/uueAo1MOTGDvQPLZtyFltsWzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Up3I0i/w3tnKYyyzcFLBT8DOyDjyJNH5Sji9ORGzxVoybWmGmvKbs+WQrhUH8PIJAnDMC8HFgjRS3sLK6L9Fu3OfVKTFAYIozDTdzPOxD3ZlR/4VaOZEEVRvuibPMgowWpcmGWDFBtj94nRPr2mG2xM/wNTzfuVOk79cBj3syCvyttE0SiNUA1GMbpPHp87TLj34ka9d737u1iEVYsFzaKHV0vY80iGWFc+gL3tfXuE9HnkAv9rL10neWWPIZkEwdeQ2kOynfWx+KpFq1reGlkt53bhNph6dXKmCHXqbBcFNuVHin2XuxkeeVOz/IZY9lfbM1G8FPlwe9oNKDDDbBALKX5Khk9nCduu03hnq9kAlyiEcfSrhf3SJW0DzQ+BCVg/po7jE93ishyRNJVnji40cQG1wZdsa//vdy256Fi2MZreOnR+6rN91PaZhyeYq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:43.7586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493837c0-af66-496b-0003-08df141b4f5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Document the amdgpu_dm struct members and function parameters reported
by kernel-doc. Convert non-kernel-doc prose comments to regular
comments and clarify the HDMI FRL polling fields.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609051521.dVjPj9Zw-lkp@intel.com/

Assisted-by: Copilot:GPT-5.6-Luna
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h        | 7 ++++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h    | 9 +++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h  | 2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a02e906178b1..2ead9bc8e439 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -593,6 +593,11 @@ struct amdgpu_display_manager {
 	struct amdgpu_dm_backlight_caps backlight_caps[AMDGPU_DM_MAX_NUM_EDP];
 
 	struct mod_freesync *freesync_module;
+	/**
+	 * @power_module:
+	 *
+	 * Power management module.
+	 */
 	struct mod_power *power_module;
 	struct hdcp_workqueue *hdcp_workqueue;
 
@@ -734,7 +739,7 @@ struct amdgpu_display_manager {
 	/**
 	 * @hdmi_frl_status_polling_wq:
 	 *
-	 * workqueue for 200ms frl status polling
+	 * Workqueue for HDMI FRL status polling.
 	 */
 	struct workqueue_struct *hdmi_frl_status_polling_wq;
 	/**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index bc16ecc67329..6ba567df5f0a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -44,6 +44,8 @@ enum dmub_notification_type;
  *
  * This function should be called exactly once - during DM initialization.
  *
+ * @adev: AMDGPU device.
+ *
  * Returns:
  *	0 - success
  *	non-zero - error
@@ -55,6 +57,8 @@ int amdgpu_dm_irq_init(struct amdgpu_device *adev);
  *
  * This function should be called exactly once - during DM destruction.
  *
+ * @adev: AMDGPU device.
+ *
  */
 void amdgpu_dm_irq_fini(struct amdgpu_device *adev);
 
@@ -82,6 +86,7 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_device *adev,
  *	by amdgpu_dm_irq_register_interrupt().
  *
  * @adev: AMD DRM device.
+ * @irq_source: IRQ source to unregister.
  * @ih_index: irq handler index which was returned by
  *	amdgpu_dm_irq_register_interrupt
  */
@@ -126,6 +131,8 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev);
 /**
  * amdgpu_dm_irq_suspend - disable ASIC interrupt during suspend.
  *
+ * @adev: AMDGPU device.
+ *
  */
 void amdgpu_dm_irq_suspend(struct amdgpu_device *adev);
 
@@ -133,6 +140,8 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev);
  * amdgpu_dm_irq_resume_early - enable HPDRX ASIC interrupts during resume.
  * amdgpu_dm_irq_resume - enable ASIC interrupt during resume.
  *
+ * @adev: AMDGPU device.
+ *
  */
 void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev);
 void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 4436d256a2ae..21fedc5f21bd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -37,7 +37,7 @@
 
 #define DP_BRANCH_VENDOR_SPECIFIC_START 0x50C
 
-/**
+/*
  * Panamera MST Hub detection
  * Offset DPCD 050Eh == 0x5A indicates cascaded MST hub case
  * Check from beginning of branch device vendor specific field (050Ch)
-- 
2.55.0

