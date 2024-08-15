Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3D6C531DE
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3596310E331;
	Thu, 15 Aug 2024 00:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FRnp/euU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3521210E326
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEmWcmHOmNjTzphn8+KfKx/uattltQyfYrI/9l9dKvGLQU+b9A+MD/UXJNi5CfGiWzY3oo2kkek1a3JrJ10lMhOHVSgXO4QErB1+NUH1LEOIBuAKPWM2LxrKJM3upodxt3fxfZ6d2PfA3U5s9/HUAgpgWITXXLuISZZ7DynbapUPLYyO2MHGSx2SYKOqy0UM2HwCGIIYF81xfFOs15G5xLFjtWiYtBDLN5R0YQFG4hObY/lwEelbEicQbwkCZmizXB6J8+dUAXBLGGlxtq5ngjge6j9WmS6PJ6/8MqxWzCenF2969uxzT/bbPrWKaNixM31x3bu2ohbHnvlid9hkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g0pTyt2YkrxpOnBf8fCGbu9ohHeKiPufT+w+s5/y1o=;
 b=gKYTuG2bKQjne2FVrNxMSJF6i37TXVci9L4inTkMSjDUmW0RYSciNwRCpvv3VMuNzcpdcMPYxojk9A2QLNBmojJjTcf8QuV2lGq9ZRH5FEsX/Xdqo8c2d7RanIUTNhdqDvfskfRULrOPRqmqy2GX4oVwTC0GrPiN/2KfaBYNH+yrTLHfFKGboQfS9/ucC0mSx5BgPSiNqJyPaVPbohNI88wA/5OmBQx2+8WTZwHN0eld+WegM3oJm7bYxvJjM96cMHzTCIIg0YjQPUT1eBZzVpbYqoILmgu+MzQGLPnk5u9u0ogls9s/alFw7TMI80FdQTx2tyJHw8xF0MiYD/T8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g0pTyt2YkrxpOnBf8fCGbu9ohHeKiPufT+w+s5/y1o=;
 b=FRnp/euUihWMj/xkVye0irbHTTvZzLoEkqjxJk795Ov1vRKT3e4ID1TbkIkDMjVPx8oehs+gmB6QqHkoK8cRosm37KUq/nrQnNGDj3ZaKMQiNh3FD74iUYy7fm3Sbmv9BdgsBc9gOAHH6WEahPFgVlGJhJhGTUtiMq9XhZGyirM=
Received: from BL1P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::16)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 00:05:21 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::6b) by BL1P221CA0022.outlook.office365.com
 (2603:10b6:208:2c5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 05/17] drm/amdgpu: Enforce isolation as part of the job
Date: Wed, 14 Aug 2024 20:04:49 -0400
Message-ID: <20240815000501.1845226-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3ac08a-0535-4f75-aa8b-08dcbcbdf445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHdadjFRU1lpNEhRajYzU1U4NkVPSC9pUWRUakl2RVhyT0UwTE9PRFplUHRD?=
 =?utf-8?B?MDk0cjVGdDFoOUUyaVNBWU9DZ3hIUW5EV2Y3YTlGcXNOdWNrTU5YVGh5K1ZK?=
 =?utf-8?B?Y2MwT2pzRWtUT29EY0JuMlhERUdRWnBZL2czSnpiU0g3c3c3SnhMM1hYRW52?=
 =?utf-8?B?Q3BxY29EUjJNamdidUVtQW1PWG9POHUvdWJNbG01bmNSRUFydUNTMkY5QUdH?=
 =?utf-8?B?ZDdTNWxsVmZ2T3k3Q2tIRVlzb01WYyt6T1pGcHMrSUtnK1VpRU9sRzRIb0lD?=
 =?utf-8?B?TUVBRmdXNEF3aWltbG9ocmZIMUYwWlhWbmQ3UzA3SmRxL2QwRlRsMWg3NEVZ?=
 =?utf-8?B?U2h0MUtneTBwc1JzdEJERGFpSE9qaE9uaHBnSC9zd3dpYkNDWGFDODZIUWR4?=
 =?utf-8?B?SmRMcVJiVFpSanRBZEx3R0wzUks2T2RmSVhxR3QrS3M4bXM1ZklNSUhlYXZn?=
 =?utf-8?B?Ukw1WmpmZStLTUNOcllQT1pTSzNVL2xPZFM3cUg0bEhkcytNd3lKTXhoUklL?=
 =?utf-8?B?VnhQVURUbFE2KzRRdGhQalJRbWpGWTY2alNNaDhYeCtaM1BsbUlwc201UXlN?=
 =?utf-8?B?anhGblAySnN5VzlSbVo2T3ZKR3EzOEhmbmdzZkpBVTZkelkvVzJMbXl5d3hW?=
 =?utf-8?B?aXlzZjVxUHROY3JMMjlkaDJ0dEV1ZUpobVIyb1h1bW94aHdQR0w0c1FYdDlj?=
 =?utf-8?B?cENVNGpFcmFydmJ2b213RVJKZEN5UW4vZ2RyYlRuU3dWaUwvak14N3NheEZN?=
 =?utf-8?B?VTFPRmF0eXR1RkYya0tiR2hBZ0lZUCtweDhLc2dxcnI4ZWdCNXl2aHFDTUZs?=
 =?utf-8?B?QUs1aEFiWFFzTzhCUUdXWGQ2OTZwakl6dHo4SXE3VGY1QVQ1aVZ3a21rOXF0?=
 =?utf-8?B?d1RRdlB3ZVJwNWczaEd4d3lhOGU0VU4yRTJlTnplK1hjL2I1OWkzb09oZUc0?=
 =?utf-8?B?bDFERHBDODIrb2daa3pSRm5pcklNNDZJWDVzV09Ra3lMTzFuNkpFWURtZzhi?=
 =?utf-8?B?cGJkYStZSzBYS1VDSWc3L2ZmNk1MQ3J5cjQvY01iaVJidVF0U1d2Mk9Lc2Rs?=
 =?utf-8?B?QWlRZTFQblV3MWJCOGhjbVRZeFRyS2MvQldlVVpQZUIrcStBUVdFSW5LODlI?=
 =?utf-8?B?N1RHTkF1M3J6UVZxTEpWTEgyME0rTG5DSE91VnJXTExnYVFRTVpiMlA0TFBx?=
 =?utf-8?B?V1ZJcWt3OFFXditTZ25aaktjK3NXVjVJR1B1b2FXYXlSNzNtZTVlQ3BudkEw?=
 =?utf-8?B?cXlObkdKRm50eDZCV0tDb2UwWktoZE1HeERGSzAwZW1OM0k1VFFjQXB6ZWNw?=
 =?utf-8?B?UXRIR3Z1UzhLalN5dGhGd0lCV0dxMFBTSkJjWDNLYk1qNFNpZVgxc1NSSVYw?=
 =?utf-8?B?M3Z1RlBHVW1ZYTFEaytVemxzTVlLUFJ3US9IZU5DTEdudjV5N3JPK2dLZmZk?=
 =?utf-8?B?VWtseGhNQzE3YjV5VHYyMzgxc0tBelI0aXhxdnZQeTBXK2d2bWhUK2VweGRQ?=
 =?utf-8?B?NUplWTVPNVpUeFJOdmF6bXF6aERaS25QNUVseGVNSXpDSlN6QzFpWFoycE1V?=
 =?utf-8?B?ZjE2WURjUE9iM3ZaNjBtL1krcWtaWnlWVVRhM0F2STNEcVZLY2F1blAzM3BW?=
 =?utf-8?B?NjdYTHI3b2VTU3Y2bFdpak0zbXF4YXMzZzJVTW9MMTZHbDdJaHFmSHhUVVEv?=
 =?utf-8?B?cjEvRUJpMjZnU3VjcklsdE5mc0VrbjdwUUtIZEVkWGxDb3BZekV2Um5UM0ww?=
 =?utf-8?B?ZDRtbWtncHBuMTl0RGpPNU94MllQa1BCZElZSmwrMUJZVzJHYnBFbkpkZEdS?=
 =?utf-8?B?aUYrRGlLeTU4K2tiQXl6ampTN01hNjhsUHFtSWhPWnFsZi9HcHZaejRQcTU1?=
 =?utf-8?B?SjJXd0NBYUx6YkZUZjJHTUVaMEwybVR5NzNDN0JtOERNemRDTElZeTdKWmtG?=
 =?utf-8?Q?/n0htfq9hZb8xBzJHHRW5ll22+PSb9x5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:21.2033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3ac08a-0535-4f75-aa8b-08dcbcbdf445
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This patch adds a new parameter 'enforce_isolation' to the amdgpu_job
structure. This parameter is used to determine whether shader isolation
should be enforced for a job. The enforce_isolation parameter is then
stored in the amdgpu_job structure and used when flushing the VM.

The enforce_isolation field of the amdgpu_job structure is set directly
after the job is allocated

This change allows more fine-grained control over shader isolation,
making it possible to enforce isolation on a per-job basis rather than
globally. This can be useful in scenarios where only certain jobs
require isolation.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5d5ba1e3d90f..1e475eb01417 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -296,6 +296,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 				       num_ibs[i], &p->jobs[i]);
 		if (ret)
 			goto free_all_kdata;
+		p->jobs[i]->enforce_isolation = p->adev->enforce_isolation[fpriv->xcp_id];
 	}
 	p->gang_leader = p->jobs[p->gang_leader_idx];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index a963a25ddd62..ce6b9ba967ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -76,6 +76,9 @@ struct amdgpu_job {
 	/* job_run_counter >= 1 means a resubmit job */
 	uint32_t		job_run_counter;
 
+	/* enforce isolation */
+	bool			enforce_isolation;
+
 	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 71ef3308be92..1468222ea0cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -682,7 +682,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		ring->funcs->emit_wreg;
 
 	if (adev->gfx.enable_cleaner_shader &&
-	    ring->funcs->emit_cleaner_shader)
+	    ring->funcs->emit_cleaner_shader &&
+	    job->enforce_isolation)
 		ring->funcs->emit_cleaner_shader(ring);
 
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
-- 
2.46.0

