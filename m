Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744D5C624C6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 13:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0EFF10E2B0;
	Mon, 31 Aug 2026 13:32:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fee2WGKw";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E76210E2B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 13:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2DlbGIrX3JurtDmraRu0byJPfQS45Zy2egyMfD4+bdX/0aYc1h92zYKUh35jeq8FWapqXNuGSdIYyQwxuyceDr4mdqN0t+CgMNI7rnxUWxDYHAVgsL6EEmnHj0SGzks0RmCboirAx666b6rWSTXQOkWTAKKQjngFvgztIXKHcCCwd6cMxfMejTqpPQ8vn1H16d225Z6afNe33pkN0sgjXQaGNQMGhGC1P/FL6PSkYlBrhgJCo6pG9usZlN5C8cT04BqEaGKXv1GhKuZRdgWXkQvyh8mwT3tMZh8kSigN4ZQ4pfUOYqbYijaiSWCRVJzGwhlcb6uofrjbdF1LpKEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Y2t0zSb0q9fbiE7SndZ9N2v5erj5pdLaP91OytYjds=;
 b=hatsbUyjtg8CftQVqTqpDEKRe1mdZEJjUuVGHA17DKBvoULh2PD1utiJeSO8ur07TOfGrvbY3NC198lEJgixhk01OOi+DlZ7TmpblFDPi7gJ9y4I8M/R+1ke0aBCZxlgWa3ay/S21H4arFgboFmN6+hyo6BqYNjmPbzgwXyqBb247LQiU70OeBIBxwcpaOMJOl0qa8uuzaS6cPhKQk3q8b2xjFv7UiJ/UmmSmg8Xf++sUUBz+6Q5qhYatfA44smR019+s6IdT6WF0+hOvR7v44Ejqh5fN6qNw3F+Si1xwh2fTLvbcmJ90+A8pckBHj3+eCmcwNZb2Wlr70c+d5h0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Y2t0zSb0q9fbiE7SndZ9N2v5erj5pdLaP91OytYjds=;
 b=fee2WGKwnRWkZUUyaiXiJhZFAJmRZRTncEOAF5pRtaSBIcETLunpRNJDn+elKHqZhhYxjmLXOUnMy3xEGG6si0Qa0FtUcX4fl/2UKmBWC69Z6ivdN7sqH71q3iSJCRoGm7aEMlyeqkrvvGtrRcWWrYXZS7Td5BkQuypO4X6suOg=
Received: from DS7PR03CA0032.namprd03.prod.outlook.com (2603:10b6:5:3b5::7) by
 SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Mon, 31 Aug 2026 13:31:57 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::75) by DS7PR03CA0032.outlook.office365.com
 (2603:10b6:5:3b5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 13:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 13:31:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 08:31:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 08:31:46 -0500
Received: from jenkins-5800x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 08:31:44 -0500
From: Horatio Zhang <hongkun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Shiwu.Zhang@amd.com>, Horatio Zhang
 <hongkun.zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: skip IMU microcode request for GC 12.1
Date: Mon, 31 Aug 2026 21:31:44 +0800
Message-ID: <20260831133144.65852-1-hongkun.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: d72e2146-5b95-41b3-8605-08df07643a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: o/Mf+rNDhI6ySK7SEW0Y/Q6J1lSymPMBMeLMX8NZNFhqRLSrRFAuklFLUIdB6572hXjrhIYZ+XlRBjDRS0CxET2wt8MJx7yx/Irs3la8/KcT7DYMMnQsiwTjWSoDx9fBCoc2ANM+Q+T+8L/O5bItBZ7wFo12MjH6BSIZMGK8kEO2tpH+PAy++1EUQftxTc4qHDfJ3YOy+JMJjDFbhQ9POb/fOXDZ1bw8UHpDK5qvptHj0Ssmf38FI72/0RL06aiopUFmQT8ZaH3+lQmR+fkTfGO8o19mWWkYDklGTG0GNwIOQM2Vg68HJv1bbwek76Jj+ExFFW+0R1zbPJFYnQhzpml4S4EhF3mmMDDie/YKQqvvliEnvR3RyVsiN4bFgCks5JxVCLDlLNF5ZkvXIPgwakMBOORdr72AQfWUNcX2AHNDwbsG/3XrPQ12q/3e42t3x8Ty8bRWRkhkCj0Hl514nYyYmPftMwZpic4INmEuVHTTva7bniTwa7sm5C2jfhAsRpEB+XpNZ8yeoquYF0Gr6r2xzzpSlbsWikgHC67DSWUTXvly3JkiZb8Jo65hwVpl2Kkp7ULLfydAaqrmcA1jllIt1g9GfKYZilb97rbSYWIzMA3UY5YWx4frajsqKnJqYvFBTKAwmQn5ASecofgKb4hwAr2lvZBDgC6rRYDdefAVHr4W1pRrFgPZfXkQHGa8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EYvSBA3y9DNVHAkZV7IyoZVLqXRGnDUa2p+/DsvOpkIE63Gr2uM3MP35/l7crWfyKpWL3iZtKYeG0HYzfaKiRPONX5QJ2ABceKuJk+dzomsKDff1c2loYDAQH+V5UbSrsNLd/OGDCWnmOPMwVfFpnwLOTJGTVm5JoGO/KN9c4J3cMvC4TJlE3y98+1LN7uiEDuaHhGZq0fnC5CDnbbLxEAepqrTUKO/QqFjte1dW0YDfQ9Xwtsnu0Vib0UU8aDrXSaGBJnbt/qhppGSKwTyTmeITs+iX+m9TpvqtSlxEK7jF3EDliunbmFSAR7z33DZVFKGaiAGnscDEZ/y2h6QvcEEMiYg/IEUIoeNjN08f4Q8vCbW+R2URvCMq+pkoMjAvYmHTBBWYeGoVIQTVToT8jHhCTwxAcmCh0KD0FmazluyciepDjuZTxb8qKBNvywYn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:31:56.7025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d72e2146-5b95-41b3-8605-08df07643a5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462
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

vBIOS has the support of IMU firmware. Requesting it now fails and
aborts GPU init:

  amdgpu 0001:01:00.0: early_init of IP block <gfx_v12_1> failed -19
  amdgpu 0001:01:00.0: Fatal error during GPU init

v2: drop the MODULE_FIRMWARE declaration.

Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 1188e91c66ec..3273be640600 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -582,7 +582,8 @@ static int gfx_v12_1_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.mec2_fw = NULL;
 
 	if (adev->gfx.imu.funcs) {
-		if (adev->gfx.imu.funcs->init_microcode) {
+		if (adev->gfx.imu.funcs->init_microcode &&
+		    adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 			err = adev->gfx.imu.funcs->init_microcode(adev);
 			if (err)
 				dev_err(adev->dev, "Failed to load imu firmware!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
index a124abe44724..33fe0a127c50 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
@@ -32,8 +32,6 @@
 #include "gc/gc_12_1_0_sh_mask.h"
 #include "mmhub/mmhub_4_2_0_offset.h"
 
-MODULE_FIRMWARE("amdgpu/gc_12_1_0_imu.bin");
-
 #define TRANSFER_RAM_MASK	0x001c0000
 
 static int imu_v12_1_init_microcode(struct amdgpu_device *adev)
-- 
2.43.0

