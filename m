Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADCEF53D81
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 18:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A7D510E3C9;
	Mon, 16 Mar 2026 18:17:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cm9W7yLq";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46B4B10E3C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 18:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ar7CmLqqYpDsNI3n+GCdzy5GgTTkgKRH32r8QUiVY2eaFLcW6vYQL44Zs677EOkCfMZlRFs3CiHnc5r8el48sJWPdehRdbxUJApbDu3WFaUiK4SsZ87OZ231PsrPxD3sZd4GIZ4SCc+RbzcfD2YOcNAzmMCnuMzumr7ysiDFGnatckR+5CPc+JmSoEHUnWmeH7grt03SUpJAY4jvzvpB6/LXw+axE0720JsLGrI/1X9GuYkoiHqLmgswXQ3AQ5vDMgvP99n2b9SPKpNsnmUtebLRCuvD//Me1xUQ0MltspunkYokAID22pKUtXw0xXM6IKsODTcIG8I+mKpYzCz7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2tlXtyjhRBIcxWrDBODmI603IRG+muZg4XeY5wk1+o=;
 b=S7wmw/eFqkh4yPgwpxrk1UZGn4Uj35VXAHILGD5ES40vmEue9XV/UkGihTnDAYB7gYKeWLCOWc4AUyX0xNuJ4KruTNAJ9bT7vjLKt8ZU0MKyDQ8N+1OGZ1iZuav96sTswreiGLvai4iRXptipo0z0LuLYjPmLd/Qv9wwSfzAA8x30SOeNAvoC+uKOg2Dh3q2UvfzOjkY0/ZE7e+3jUZhF3iGNyckQyvQhXMcHeAbiNjh/J28MZx5r94XKIt6zF+YgQzqCfhHlESTxILT8C+8cbtpPCrIC7Mzx2vu9gRMKLDOMhmR77PzkaHYYnNYQ29IEeXyRRKfnJ9Dd6VWihTIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2tlXtyjhRBIcxWrDBODmI603IRG+muZg4XeY5wk1+o=;
 b=Cm9W7yLq0c0bmMXWsALHCDzaoYesaxvr5RbN98of0DO/21eF17q2m+plF9jq58NbgqJe1aAhqsa9Y5oa8VJoBIeP8LbT4bBtD1cIRc4OXRL5CrGnSj+Wb0x3Ie6xpLjQY7afSU+qN5lY7pX/K+NK4KpJ1wLyQApC1wPEvha+xBk=
Received: from LV3P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::22)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 18:17:02 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::86) by LV3P220CA0003.outlook.office365.com
 (2603:10b6:408:234::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 18:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 18:17:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 13:16:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 11:16:59 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 13:16:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: Call drm_sched_increase_karma() for ring
 resets
Date: Mon, 16 Mar 2026 14:16:48 -0400
Message-ID: <20260316181648.2005897-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316181648.2005897-1-alexander.deucher@amd.com>
References: <20260316181648.2005897-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: a82573f9-77eb-4b3a-2549-08de83883778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: DQ1/9iXaDR2NMfq7dyWqUl+udClAaBHyfChiZ20X6HWvgxwR+xXBy1s5fyvbq+IlsCRHKwEKHWrl45Zfn5ME08j/L3MzCHc9GhfxdKYW2d8GQ0NtytQfFIYf34i/qgljszA5ArtbrfN9/J7n7gMY1vE6Tq4cm61IwLEmoMMQ14okfdgBWMFI5MWPojrVeHs+MiOa4ULO/vMnPvGuiPsnq4g7adaxspEJ5CULJcANQOMJeUcK6m7mLNOO2vhZWZQb7Xls0Gy9tPdyGlVw3ui5hnXxOoeVOuS5UtOBJUEstYXu5Gg120wIxx0RAYe39fTtfqw7SJYXXjuynAXFZaCTnXPxyAHyNT0VhY/I8mycxJ3mXswBUdFc63iERai020Z724NZ+03QwJQuRmzPGer/YUZkvT2RZdqkzVnJOJgkEUzS38kHFnOIoON6UFAXKjEj70/Y1hrtUUAQzN0fwZwDWZM/sj8IicgsfQGijh/HVtJuvSoII5gBbA868rETk/bEMUdu0t4H6FT21G2CzaremNyS4ACiXV8TroN52ZXrJpoydBD+WOoC/ktvbWSq33OAuKdgPJCPy5rpaJpuAQ5XrflYB1RPfZVFOrpdxkNHcPIekFSl7PaxbPT2M8B4x+3vFX9km60Z+KK9W3yg3k38w2OCqeShrv0kAEfr0Ov73sg3i/mwIuYCOP17zONrwu2rA0tSLaiPErGe1cv2lkAbW21vAJ78IgNRp0BlPqtO54y+ff4IXjAIfZH/ykbjP5GD+euZoUXac+vgsBuhjE8DXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pGYTBa43ONXmfXOvi8H31QBAfEChdH2N4iyngOyI1fLHYu6uJAZZzygSo84S7+/f5rPCvplRXUETULHzNVm8ShZnbzprZO0596k2tb4go/YKGFouSmZmnFuvssD1RBMK6dyJ7fJ17XpMg1kUNCFrqNFI2gyBGX3nNbaWTajkfmbsHVuz63N4QOafeKqtj6DV/EvsNWY1McbYwYFGOTYEXPka1CibLWxZGy1jhASTInl805prTr2aEZKhzOvTt2JlqGKNJhrDNS2HOloxVTOGXJauzjkLmH/vOedTNm8LjPcatU1mtfIzbgcZspadRUdniwj2UhGHHYvRFfYgiackR0avLaA6uWyi9pAb8MLABvYWiDjLQ6BKW4HiHW3PtQvC0Phnv1BMHumBNEqApRu8DwRPsv/sWC9vm+S7UeDSVDl9HDjb8hFK3M7SeeyhiIxm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 18:17:00.2140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a82573f9-77eb-4b3a-2549-08de83883778
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
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

Mark the entity as guilty.  Align with adapter resets.
This only makes sense now that the CS IOCTL returns -ETIME
rather than -ECANCELED.  Without that patch, this would
break userspace.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index cd0707737a29b..dd9b649cf88e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -137,6 +137,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			s_job->sched->name);
 		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
 		drm_sched_wqueue_stop(&ring->sched);
+		if (job->vm)
+			drm_sched_increase_karma(&job->base);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
 			/* Start the scheduler again */
-- 
2.53.0

