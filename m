Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCAE606A881
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NXzcK+34
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB56310F136;
	Mon, 16 Nov 2026 16:57:50 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010046.outbound.protection.outlook.com
 [52.101.193.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E3510F136
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 16:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/0/PRqGGctDHQVhIQp7XYfuVX/K9bX7ghDl4QSFZ/PECta+pbptIqN/RW5UUp/Qmxam8rxqX0+NlE0NKF6tkzhMFw8HT75+ajRe3HoYrrwmJAh/q0u0pZlQ50wDtzNzf5YjmnYF+c3frdd0o+krdW9Bb+VltrMfqi68FVVmDCuaVfv7sKf18Uq7xE3fjJagxlLc1teQFtLXu0YRNCf7x2CQMo8WumxGXHdNpdkBlajyj1kfd3Il8Y/LniKq1tnfgBDGKXVf9T6+4MPFhUfP0a4/aJN0UEzMpVly1KywcsUVBfK89vmY3Ery5gVpN/YIzj+WDp8N3mHajDHOsYmhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3Wiaw2JCDGXPaRMFi9DEVrSvqM2V6Ba8Wh/XFcw5o0=;
 b=POyovdSVOCuSwrMvlSycvGMuQw2AV0v+Z1GPGLg5D1aibvnU1l4BFwfm5uainCLFGCRSM9jg5oeOsdvrfZmmBp4T4apfJfhqYKmjDLNOitpb/Iz2JqRr2qJo9+w7D8Yc1WjPX0qLwx4CEZZHq7hW7jbLqrNp5GqDVO3E/fAaxNLQNHru5aV368LJUbPjjS5nClCbv2UxaQEzNLaXDRnZil0b7JiINg1rR0NkQ49ftg2wMTtOZDqmKAxAlmGt4oy2D6SElI6AkHqjq+ef4X3cWnrvCVCY0HbxS/om+YMOVA/mCgLZljRE+Ko9q0PowuDYxMa40WU1LapCjiM2fFUErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3Wiaw2JCDGXPaRMFi9DEVrSvqM2V6Ba8Wh/XFcw5o0=;
 b=NXzcK+34P2elOw5m8B7hGQ3DwPWD34lCjfPDUPvaUBZC1b5FUNAs03+7U2iMZ7MseIseCK8ganzGtgunZ6GAZtyFmPoKcyug92GzDGPZOpjdN83mQCFxovW9LXhNxUiBFIx1Yf1wf8pNpO/I1TH9w4u5bLL/UpYfD6fNU0b6tWM=
Received: from PH7P220CA0125.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::18)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:57:29 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::2f) by PH7P220CA0125.outlook.office365.com
 (2603:10b6:510:327::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Mon, 16
 Nov 2026 16:57:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF00059619.mail.protection.outlook.com (10.167.243.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 16:57:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 10:57:27 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 10:57:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] Revert "drm/amdgpu: re-enable SPM updates in the the IB
 path"
Date: Mon, 16 Nov 2026 11:57:09 -0500
Message-ID: <20261116165713.1945549-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|IA1PR12MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1fd2dc-015b-4230-bc00-08df4402b257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|6133799003|261009223027099003|56012099006|11063799006|261102123227099003|261021123027099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: PtC+qznXFKEmkUxQxCBQSpnzGcqDqjX7hBHKZHndePA0JKqSBOktAQMjOH+e/XJdOGntubUrMFgZgWKLOi3wZWDHyfKvIjJwzfp9XHMx59uvej14ee9Vmqb6pQxSAgChOCQ0X5H/6AF9eskris8rfQWA57r66BJazbfi6qTLhjqCzbLOJYDVraGIAdio1wPSLGbA8jsZpqT81lipk2mnut9OXQHlOEXvxnLBHFlB5x7kz+DvBGOHXipNimrt/xWAVXJPqKCY5KsEU+Q8rA41yMCMo5lxylPanKP3R9hlw8LfFRNFNO2fAmwXFOso6bhCpllexsAESOfXqkEC6CJqpi5jPJmnAgda4lo1OQjLQjmXRP/dbVVfDKIG0qxPT3147PCW7XXQHvlA+EippZfEEJJFL5wxiIykYSg1ZZkJ+to86VtAZwPvpc9qh7QVJtTjXEFUgq0o5aO/9lVEBsEs6DRGS/r0CqHYHlCdLjv9GZ944Tu/oH3HSeN0NfaBXSrwgLG06BlyGUW2CjmN/pEO0e1aAyOB7QQ2ONZATyR0/ANzAo8GSNLGj7LqJzUh4v3/hZVFF+wn/WX5ewC719tzv7mA8h8FBBJMH6vcSNqVBGkDQqFBRuYmZOxZvGTmtCV+lqgiTonBgdD5OsFZckgW5xJBp9B4SRqnx4mzZ4BqLFTTaG5w/mVlCaqz+2NjfkTFwyr35OMWVlQKUm4LUqhJVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(6133799003)(261009223027099003)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gC9Msw0IXYTy2i7d/r5jyjJ98cw2EFGZn1j2nZY/1yJA1YKAlQHLowwqiT8Y0qjTKfpa0aekVywlgw99/X4Ki05RlZUuIfNjlia99OfUGoKTsYPgq6lLegcQlSotw645gH0BxGCqg4eg7yeLO2212dzhd64KiTy0fHKEnWGK8IFpcXUd0PZrMT0JVIBlnTumt8df0q/cd/HZvQDLgziBwo36Su3S5a+7817oFrVLPH/HuqNR8gzMaGK3UeMD3SByfiulFL3aJadaL2iensh7/nVJxAphwQmtNTaokIYKCFAP8+Mh6xDLXZG5rn6MkPQSQ9hIUN+jEXBwa5wls4s8pPRUbNE09P6TbiX+5FkkLbANlV8/MVVoKVAx7izCFK6/2wt80fadV7TPRoXCQhG/KeDyS+EOiqZpMnYO7qo5Rq9Be/isk8xwT1lt3/yJx+CL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:57:28.1484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1fd2dc-015b-4230-bc00-08df4402b257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This reverts commit d44428868e5b9f97c6216eee1b4f82aec7a6e8d2.

This causes flakiness in gfx11 CI tests.  Revert.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 6210edf1937aa..f98a7c6797b3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -121,9 +121,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		       struct dma_fence **f)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool emit_spm_needed = adev->gfx.rlc.funcs->update_spm_vmid &&
-		(ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
-		 ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	struct amdgpu_ib *ib;
 	struct dma_fence *tmp = NULL;
 	struct amdgpu_fence *af;
@@ -212,10 +209,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (need_pipe_sync)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
-	if (emit_spm_needed)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
-						     adev->vm_manager.spm_vmid);
-
 	if (emit_gds_needed)
 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
 					    job->gds_size, job->gws_base,
-- 
2.56.1

