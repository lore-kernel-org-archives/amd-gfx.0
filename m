Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C25AC5478C
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Feb 2024 18:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 090F210E7EC;
	Tue, 27 Feb 2024 18:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T2lfNEH9";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B0410E7EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Feb 2024 18:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baGtScnQdFAwZpEFIYPHo8xyeY4tLFJdmNiEe6uJcPtd9bLptU94UEUAukqxE7cTIAQNSd7/HmgM7/iCfkMM+Q8i/z9C8seqIyGZeZD5yrLjwUbfvIHEVw9B6etuarHobXuNmwWCS/bER7dzcyXdzZn7ArbcuQsDOW0qaktjIT6ZgoKW2PuWjp94btlkRfQtvLWwbtM/qWAbZYz2G2UWZRJY/yaEGpFWcbAV+bnUeHnOOzDq8Bg6SIOIJlFAApXY+rmp/kmDvNeZD78AINxr44YtnHDL79FcgLgDVrInPscgnFlG8i+SsGxqYRigaex5SJKi17xyEoY2KPiuPfFpag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfdLY8pl5xohtRNz5cK5amKMvlON6u8md4z9Q+T5zio=;
 b=AKWi6rfZ51sYwED+w8jIPH0EDBdbzaHZabhrlIMMx+/c3b6lv1MhVJJfHhJRLMEzJwhuihzMIybOazp2tQRjLT/xdYbpK24PnY5GJ6LlqCRwzNslcVXAbagwj+Q21FRCMchKsUPpfLQkFp3mJQ8j+7cqDOIHGiuebrS3BHj1eivzJiGeVnJjwCWc2GppFblZRDOUeJipGsCtHz28+89GuwA2Trl1Ujjfkg7ybUBslKzdhkqy3Hmd/s2TFHdaGudYcaSFZkO7uBp/cWBcAS71EOo+qkYOxdhh4oCdND0rbwm6XO1O9E0QXTwJ/ezOhiNq4INSgeET5Ah1w5wBZJycPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfdLY8pl5xohtRNz5cK5amKMvlON6u8md4z9Q+T5zio=;
 b=T2lfNEH9NLB+lOyNyB3530tBQ9Y0S9NoTogP1qDXxmxFtwe13GNZCJxwtohUBeAEWluCND1AeDAR/7v/kEfwoyIoBMdMxTIr6zP99Tazhu701llwzwkT28mvJlXg3Lgxt4S/Z4QSwwVQNr+gKp7rG2543rlNOcqwwNym+DgyFJI=
Received: from BL0PR0102CA0047.prod.exchangelabs.com (2603:10b6:208:25::24) by
 SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 18:49:01 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::e5) by BL0PR0102CA0047.outlook.office365.com
 (2603:10b6:208:25::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 18:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 18:49:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 12:49:00 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd: Remove freesync video mode amdgpu
 parameter"
Date: Tue, 27 Feb 2024 13:48:46 -0500
Message-ID: <20240227184847.3078099-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 35720dbf-52d7-4a08-0740-08dc37c4c3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HA2f3/Q5skrQx9oDnxmclX923J1phaHYPj5WU49ssJ3zSodgWHRR37eOhlma+Q7s4FvKiyKF3PfHQSkImt+buJ5/+0F5dWu5Hw4v0lM5XfBzV5to/MwXDeGCzIILaZWVJeuRZ2olpHAWYRGhGg0qJ+erzwWfEjb1yCZVCmno+StXi47Eswd4oLM9enbM7bbpvhLOJahUu3Xc/Jg1FC5M36C/dFWr6pmIXM8tTwt7thm8UKL8ZZKgxP11iTkBa76Eh7hB+DSazEQ/6m3zmlfuyI6g9mN95FslOhMTT3JbZaGtih63WHpcpmYppGjYeLQbHRpqlwz0UOie8STAt6eOg8CTT7UAPgTOhTqd/mLXUx4Cjl1BvPUaJGOrqKtSGU1Bb8WVhrdFMCQAcGJ6WbNNP1b7xtZPsu/Vb/YMuTbr0QCjizR2zoLE7tq3VupZ0ms2RZADQpkiv0aypecEcO+Q7GOM9IPfXQeORUVnFTKRZsTYENLbbWwWlPkMsBOn9yfQoCAWi8ZY4YlW7N+teWRojBAoev7/pArkm6jePlUK0726qqHCXWCjwTdjJPe7KS0J/KrKJlpL0nIMBtaoGRhKIbFQ8c7P+fhoXBdqM0sjcQqBCY0GF8xf2TOP9cQYZU+6PRhaZgZLR0Chvqdgbdue3o2P+FMSFGpv1KvlLRkiPJ+rHWslj61jtRnlF/0t6X7AkhMgLNBU0IrG+WeHqhorKUhXtbGFFVZIK43/er7ALYM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 18:49:01.5247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35720dbf-52d7-4a08-0740-08dc37c4c3ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
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

This reverts commit e94e787e37b99645e7c02d20d0a1ba0f8a18a82a.

This conflicts with how compositors want to handle VRR.  Now
that compositors actually handle VRR, we probably don't need
freesync video.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2985
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 27 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0e365cadcc3fc..925026c183f41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -194,6 +194,7 @@ extern int amdgpu_emu_mode;
 extern uint amdgpu_smu_memory_pool_size;
 extern int amdgpu_smu_pptable_id;
 extern uint amdgpu_dc_feature_mask;
+extern uint amdgpu_freesync_vid_mode;
 extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dc_visual_confirm;
 extern int amdgpu_dm_abm_level;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 15a8a64fc4e28..82b154b103f43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -199,6 +199,7 @@ int amdgpu_mes_kiq;
 int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = -1; /* auto */
+uint amdgpu_freesync_vid_mode;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 int amdgpu_smartshift_bias;
@@ -883,6 +884,32 @@ module_param_named(damageclips, amdgpu_damage_clips, int, 0444);
 MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto (default), 0 = off, 1 = on)");
 module_param_named(tmz, amdgpu_tmz, int, 0444);
 
+/**
+ * DOC: freesync_video (uint)
+ * Enable the optimization to adjust front porch timing to achieve seamless
+ * mode change experience when setting a freesync supported mode for which full
+ * modeset is not needed.
+ *
+ * The Display Core will add a set of modes derived from the base FreeSync
+ * video mode into the corresponding connector's mode list based on commonly
+ * used refresh rates and VRR range of the connected display, when users enable
+ * this feature. From the userspace perspective, they can see a seamless mode
+ * change experience when the change between different refresh rates under the
+ * same resolution. Additionally, userspace applications such as Video playback
+ * can read this modeset list and change the refresh rate based on the video
+ * frame rate. Finally, the userspace can also derive an appropriate mode for a
+ * particular refresh rate based on the FreeSync Mode and add it to the
+ * connector's mode list.
+ *
+ * Note: This is an experimental feature.
+ *
+ * The default value: 0 (off).
+ */
+MODULE_PARM_DESC(
+	freesync_video,
+	"Enable freesync modesetting optimization feature (0 = off (default), 1 = on)");
+module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
+
 /**
  * DOC: reset_method (int)
  * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
-- 
2.43.2

