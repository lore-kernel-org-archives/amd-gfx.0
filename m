Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F0CCD4F5E
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149A110EE19;
	Tue, 19 May 2026 18:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3//F9eUD";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F7CC10EE14
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb/LGCf47nQb5MlieaG6bYqQPfShYpAK8ZEQZvyebvHHCCD2zm40iFAvYQJr1dX/mi4RYlbbYKP2KYRX1qsgkFQpik0uFYVQPVP8h50EgAXPwZk5GbFgR+9C0R5p1yD2PI6Rck2OTvMRbLyd5v1AFR4aWPTouUszPid3Qc3+umMjgQu09aYtfYz5BpNDjBEJhLguGDmZKfkJkisoLH+4sqaph6JCM3sqBb/xhIhpQ1tDRyF31z0O4PDwctw/66lYcUuD3yAgq+jJ+DtczB/rSH8Llc2dfMUAy2xT9Z2Q0YOdIiIdkG7tUZVLF2oTy9YuuKmGfTkk8J4VJVOdpDSdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQxlCAta+Z6kCv3WaIJdR48+fB91sHgyQtm9mN2Im+4=;
 b=NTWSC1s0CYbkDijwF4w2XIYHjkVUK9J0ifgkKANt0TofsK66MoRsEZxzmOyrbNwRVY/ZDXRjg5zaUoQ4PFU8jZcNP67z4Wjp+c+dbO3H0D5Sk7bsLd/yqZnFKlm4LVcnfGKlrNSbwxKdaVnuOl6zr50orAP8OZzmoUHUKKCJM/YH7/rC6SRKH1jdFB8d+7Q4qBfagucBMkAOBHaHz4YnuR4AbJnCs2/xm7iQ2HTty2GzzNJdSAJiHkPCWtdn2TCmJh+CRu/Tjnd9ktHtheUHfh/Ln0BxJkwQ0XaS+e9U1H9w+iNIeNLPMIlfEBE25sAmm46Wo54Sv3k6H8hjDNuVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQxlCAta+Z6kCv3WaIJdR48+fB91sHgyQtm9mN2Im+4=;
 b=3//F9eUDb0QEPSm97jgHnXw2IU74uHhVA0JlhYhV8RR3kWrR4cxlUqi5ABdeRCC9C/5QqDGrcDTYK+NkjtJlz+0asOgHNlh53c9clr8S5vJCFuAG+q7b1QUYQMXLwoHegaZ1c+joMzd+b2XL9lL9CHqtc4EFZ5mPNtQqKVLwG6U=
Received: from SN7PR04CA0120.namprd04.prod.outlook.com (2603:10b6:806:122::35)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 18:32:06 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::aa) by SN7PR04CA0120.outlook.office365.com
 (2603:10b6:806:122::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 18:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:32:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 13:32:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 13:31:21 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 13:31:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jesse Zhang <Jesse.Zhang@amd.com>, Michael Chen <michael.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 5/9] drm/amdgpu/mes_v12_1: use mes schedule pipe for legacy
 queues on unified MES
Date: Tue, 19 May 2026 14:30:51 -0400
Message-ID: <20260519183055.22275-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519183055.22275-1-alexander.deucher@amd.com>
References: <20260519183055.22275-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed78b2f-084d-4278-dbd4-08deb5d4ede8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|11063799006|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: EuemBvWT3P2m/8DwYpaVuUKErLDMqGuWNQZLWqh6hO0zucuEQP6289GKfG0cx2Qtk7SkElhjc4YJ7aqiEbhU6Pu1PkNZTxr2EKmBMDsrH6wI15JN6LZl4UX8mGFG3ZbkoM/ruJm8MZCDp4k0Y9SmFHgRiMIGrbW2ti91ddyx7mWyGrB+WaULdbNX0Iulh0dEpxSuuVVpvSp3/KLAxMowWZZEduejE+fRYyHzv0wVYDsrEZ+dXEcbBXC48VYPprfw01H19OZhuJcOrHCOCZcmmxoJYei5ptpsi7QB5oxHCz7PiGSNZmOHhIA6KXjd+j1keHhEYPrqNmIdr8mxDJEp2PQbt8GjCgtIyrj3G8pRHDOLKPnj9iZNNmPFLjy9m7vZkLwhjGqPYJR0OUIIyXrNWyrTgvGgH8jLzNzT83ySrcUofXAwPV1HNeW/OYkWMf9cLySR8+7c8uXERBQSt+uhZDprJXJDfTl/5k0ryD3xWK4DMhp3aS5wegsjx9JD0cWaHkmeQfhy3CqILoJsuKMFryJrLpYlBpkstaA+cfOri0rql1+QaYCRVPA56FnayOM9AeeGkiafXsX7+7fap+4GgvurlHtdLMj3AN9u6A+Y2LQb+kTejAaRkpDZctO/kV1Ui00oCAM8C/um1pqfhbDHsQeyu39BG2qJABb+YkoeeCEypNL5Xzvi7Wx6BgwOr+Xjzkm/Xx5yFA3AKMaSjg0qBOjZA+bgvdJP4LvK0g7f+go=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(11063799006)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4PsTkaOE01hYadLTDSPLX3ICH8oGQqBB3UFxPywRHESwNMmq6Yl8qr9oLlxdyZd1KpR3mpmuZBFkJWED78Y/1c6L2xiOwfCoyMzFr8hxaN531DqZdb9FXsri52ysRrVZ851nBn2UXDL4CVZsYUscmJNsXf+10rPLTsvI5J+Q0hgnKoGOnNDZshaxtW8e2FLiFRN7LlKYsX6OqiXYVVBcR4NsrGFjUFPx8XlGybP0/FQdbyjtm1zy5IqhXFnBvlGULcCC1eNHEhjcTceh42sPl/1XDMX5nlhGoPn5nmCUFvTiOH9QfQxpp3rSP3wcZwCPPWu5TPQC/fahwgWGuxSnLJqm6C0UfS2qRDr1ZvcGxE6EJ/VSzMz15gQ9CxKkxWiNLsEZMHepLRtjs6zxhPYv1MH8lonCNnPolgtu2eGIobYArZvIOEndIIueKmUVXDRu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:32:06.1679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed78b2f-084d-4278-dbd4-08deb5d4ede8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
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

From: Jesse Zhang <Jesse.Zhang@amd.com>

when suspend_all_gangs is issued to pipe0 MES during system suspend or runtime PM, pipe0 can only suspend and resume queues it has tracked.
KCQs registered with a non-zero pipe slot may not be correctly handled, leaving them in an inconsistent state after resume.

v3: fix the schedule pipe issue

Suggested-by: Michael Chen <michael.chen@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index b169e577e5838..2099beedd5755 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -417,10 +417,15 @@ static int mes_v12_1_map_legacy_queue(struct amdgpu_mes *mes,
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.map_legacy_kq = 1;
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			input->xcc_id, pipe,
@@ -457,10 +462,15 @@ static int mes_v12_1_unmap_legacy_queue(struct amdgpu_mes *mes,
 			convert_to_mes_queue_type(input->queue_type);
 	}
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			input->xcc_id, pipe,
-- 
2.54.0

