Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DBCC55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4465710F401;
	Fri, 31 Jul 2026 21:15:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kwn+Px3B";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C0010F3F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flG7gZW+WFQglfsfwVdSrEKoUBp1JiDcBOG1cDTQSR5y1joyLNrgURqifI1G9nwvsJkDhOfExkTKnAFSllLTKIxsfJ8xetVII7QYW4DuiZNais/sCFWVyRa/t68KhWp10KeI92Bb9SOL6V99ED3yYNQS7KqoRBu5i7XpRMDro1GKcdrXHr6A77DzM8BY+rNkf7RNXCAWVsP3QmTWoIdLGhYAa/bhdcKigzr5SS8fLEaldbVCQ7lN04BK2gVXk4UI0dwbo+o3zWDh00A3eCfKEXQ49HBpd6s1FDJoKDK7gDYFwET6dmfjugEpRYAjIH1lnGeLQ1ujnjVBEeRDameXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHNxD2YIG6lKclWQsR47ubidgM4Ahi52Aafq5xTDPzE=;
 b=gLg5+ZdGZJ/BXraWz12GL1Vh1pGKCyVePwN77WC8CcdRlkT9KO4aVGYsE9fV+SbZRYG17M+jbJpmYmyp00Y4U2XHD/6P1P9XxPdAozdyN8VshQF8u/f3h47b5epBt7SfH8Xj3/2hDHxmTOAd/KRcZlsdBlfwu8iYH7LBQ6cgQjRq8w7wUH5jI4Fjc9qB73WHoe/Dzn1am9f2OfB/WgRx5wWdGfskgt471/2/8jhJtUQQcCjlZDrRZ8N2bagRPhqL8JIGwhPUq9G+sKlXUYx/7uXR01qxsMnHHMBThP8vEp3mx+paR+teqcC5JrVpudo3r8W0RF8V25R2Tbl8McLijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHNxD2YIG6lKclWQsR47ubidgM4Ahi52Aafq5xTDPzE=;
 b=Kwn+Px3BDCrqdL/WVI4OtpBYZL8O8UIfrOReq9PH7wYOSATNeVBAa8096k/po3q6Kjm3OQYRbrmNmGVolP3GxOspSErXdcCcXUg8DYL7ox1Yj9Z99ccq/1pDPL5BRaa6wVMO+M31Ak+QxG7HEAor2VGH74a62D+xXohbb3jOUK0=
Received: from CH0PR03CA0229.namprd03.prod.outlook.com (2603:10b6:610:e7::24)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:15:42 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::a) by CH0PR03CA0229.outlook.office365.com
 (2603:10b6:610:e7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:40 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:40 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 12/41] drm/amd/display: Fix wb_info leak and NULL deref in
 writeback
Date: Fri, 31 Jul 2026 17:12:33 -0400
Message-ID: <20260731211302.3040343-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: b920b1d3-ccd0-4f22-775e-08deef48e0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: r0UdH+eBuyCH6KWnJOxgQvmPRcjCCEb+WdO/hineWLb/hUQee2kIY4MLV6xwKm40jwcUxptzJIqPySzE0PNW9hMHl6JLugVOXl5OZXV8SgwQajkqbYYe8q4Tyb/5CLaeQk8sSFAAbYV6XVCxeG+W1vNLtolHw7F3HEGGpCYYGLlCMW1LqzetM9uT6rEZrFS3j2f+1UjSi1Mwf8yB3ckYXvRncwF1z+cRsuLbbkILjlnrffSTSGoEo/zKKbwca25/Hi0UmMgOdoP/5JZ6RyuM2LWrZboigL8IvbGm2wIdU2EEmIsCXZ0JM3Og5WO3Z9v5ouTHDVWlz58mTYXutguErHg/kkr64p6pAUoyVKpkyOelwoDFeDrr3Aq2Xvo5N5+PfwKfoD1Bo1ABcvXbUJRN+5Z6IaLcTUqJXE0rjr58wDsfR1i+uIQcLKPOeHQQ5AIAfMqAeXV6YZ76TIxQHfzqgFU+vm4/SpIH3QMYuZEOHXortEI+WK/j0cgEU7qyItonppkmWyVhmLsRpVKvqDmdctfaWiznXXVHBSZL+0KQvcKm5OdJEBtaJM44ZmfDGeMQbcVrVv+063K/cXF6dcUFfV/lzR1C1Tl88Dah3zjUsgkIj/pLItphN0p0aiBXDdoHqkcl2R4tS23OOl8cAnHYy2DeFj2bY8NOVa1RFJ4eQqptaDKKi/E4KAWqfFSB//YG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j1mMlRsyVQ1sQ2nLYr36MCYGWOVJE5IteAGj5tUs54lfUj7Ez/RG2goiI2us/9usSJuryUhletCLpJ+65af0DcKP+3bwoNwdJ7VS6PypXYdylA0xnX2BfitSYB/TEzi00cCY/WZ7Bn0krp19KVWlyjd/aTlDY4j7zcxHZy2YUiYTCq5Z317bRFqPFWwQFSCB0XR5QHBDxLiQ4RC0J18CxxzG/RJQDvSmnrrnAn9SjH6fRkHPNMulhFE8QEwEoHmy6zx1DTeKjo2dniQkArkP+5JIduW/Qy8MJOP/dGjiijr3ayDqeGKW+Kh4sQGQXmih2DNmjVWzHupPveSfpH53HrnCAq2cO/4pCKwcvzSnn4PeSy0fR90D+OAumnwwWNbieme2xkqdka6Il2/A4N2I2pJ9GsKLJiUVq7M/m91Bblo7offFFh5Zsrgu2hP7Q6XH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:42.1942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b920b1d3-ccd0-4f22-775e-08deef48e0dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
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
dc_stream_add_writeback() copies wb_info by value, so free it on all
paths via a single cleanup label. Also bail out early when no pipe_ctx
matches the stream to avoid a NULL pointer dereference.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0dcf829c1d07..52c1ffad985b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4647,21 +4647,19 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 	wb_info = kzalloc_obj(*wb_info);
 	if (!wb_info) {
 		drm_err(adev_to_drm(adev), "Failed to allocate wb_info\n");
-		return;
+		goto cleanup;
 	}
 
 	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
 	if (!acrtc) {
 		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
-		kfree(wb_info);
-		return;
+		goto cleanup;
 	}
 
 	afb = to_amdgpu_framebuffer(new_con_state->writeback_job->fb);
 	if (!afb) {
 		drm_err(adev_to_drm(adev), "No amdgpu_framebuffer found\n");
-		kfree(wb_info);
-		return;
+		goto cleanup;
 	}
 
 	for (i = 0; i < MAX_PIPES; i++) {
@@ -4671,6 +4669,11 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 		}
 	}
 
+	if (!pipe) {
+		drm_err(adev_to_drm(adev), "No pipe found for stream\n");
+		goto cleanup;
+	}
+
 	/* fill in wb_info */
 	wb_info->wb_enabled = true;
 
@@ -4744,6 +4747,9 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 	WARN_ON(drm_crtc_vblank_get(&acrtc->base));
 	acrtc->wb_frame_done = false;
 	acrtc->wb_pending = true;
+
+cleanup:
+	kfree(wb_info);
 }
 
 static void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state)
-- 
2.34.1

