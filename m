Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA5CC61DB2
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B952D10E96B;
	Fri,  6 Jun 2025 06:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UluJAzRE";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A188410E95F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0/GhrIrhbpL3rR7iDKGCkDr9JtzSQ1QJVqlIHTESaCi9eW2Xz/mBb9wpsHliqOrSuqOF0EQrvn0CUyaCDLOqGCWWMmdljKPP1C6N5hluNUdMeNv1VzzqnjpqFv5MZcM0/Gx1q2Y7iQjalwdRquxqISkpvTyGziToC+HR+F2T2/VSXKP02nJJoFtkI1Y7Ar06vooDZQgT4qwmMIiT0To9B846KX6aOkQccK2X/4Wr1rwafKhmd/FLSyFWdDnKCDYkdyAhXShzteYlgAPlTfZvBWNxvkgEFN5c5AxpyDbrTmuKT0oSmyEYKvB4NmLtZRfiE3YiihuUIo7P6jCHTnE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvlt2bgNY+mQ9T6Z9XRRIB4EpXcI2jXy75MfyC4E7W8=;
 b=sCIzU7cl2ni6tR7bTiA5pZ7nxZt2SwlumesoIxVKFMNTHmqNsZ2kxquZr8qoho9ux+o9NL+rW/8yxG5NLRzLG1/fY6/dKTwMfsoNUyaREtYD2eunJTL2in4C2WQ4FhXBWMtkKKfr794b6Z8kU9s4IDoJb4pfd7m5gHou7GdoZuXcTcvOiF36jlxUncwQSQw5ikD/998gl6fu+xIw+e77oWdvuXZ2kRDdXciRmcHDkCbd3BiK9akE84cPYKcMLt77AvrnKZsBfcT1L0cqSlo3pFniD6OXpzK6gu2sRq/LFsLSgdsVPauXhJrwnqfNKTrgifSl27Yn9WueFd/sNOqh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvlt2bgNY+mQ9T6Z9XRRIB4EpXcI2jXy75MfyC4E7W8=;
 b=UluJAzREegGfgyPEHj2aIAFeYkiU9LEtOTiw22Q77CLuWNsaYxCU4FzjYCFjIw+0iepwlDsyx6JM7z12K8w/TEXRC2DvRW7esScnRl1DKNKSevQ1hcf0OajD/QDYDnUop66OII6qSUuVmj7SsNzb+o0YUwaonMM8sRoupS6alQQ=
Received: from SJ0PR05CA0127.namprd05.prod.outlook.com (2603:10b6:a03:33d::12)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:44:25 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::8d) by SJ0PR05CA0127.outlook.office365.com
 (2603:10b6:a03:33d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Fri, 6
 Jun 2025 06:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/29] drm/amdgpu/jpeg4.0.5: add queue reset
Date: Fri, 6 Jun 2025 02:43:48 -0400
Message-ID: <20250606064354.5858-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: d7680f96-0c7e-4575-fa35-08dda4c593b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8SRafu65Vwt2Wp2kg+BtwBKLH92TwTC4w5lxHT35rn0PaQsaUUDKOhOGqUfE?=
 =?us-ascii?Q?+NmrC0ScpmwCmreWrN0n1vhHXovECphmRD4TpmpsRljAoscyJWShagNjjwnu?=
 =?us-ascii?Q?tVsYs1ughsDIz6UotBGVFHhxbrW+caQxBV6gSXeJby/esKFAFt2EuHkpNAdr?=
 =?us-ascii?Q?DSzkhRiBuWGSdl3R36ca2CdD98EMWiFRaURdoeoSzDVBZshSymHns1XrTT8M?=
 =?us-ascii?Q?gM+uAYCCRdt41E4rqJrj23yqCm5PA3tzY59prY1YA3lub2tqpuOnRoV741sA?=
 =?us-ascii?Q?fxGFcfkIQdoCnCtKhZ+2IYLqARnw4YhQPzkZbLACTLBvRA2tFDwMvjxX83TM?=
 =?us-ascii?Q?KXSeTg9FS6omWqotO99cEMFCi3nCqHTzorG/fWbLMMepV0rdokWnl2jy666F?=
 =?us-ascii?Q?iqXHTu2I7wgKlDDMRGb1+D3YFStL3gNWKq2xK6EONcfF8vgnUAZ+G07YlQxc?=
 =?us-ascii?Q?7dZF3CpglOQpyN8E+qnwWjFZxcCYHZX0pNSJSkYqEM5/arh+IC8OvBPL/FUz?=
 =?us-ascii?Q?JslQUSP6Dn98oqDQTP7NOo0lNRcFSpmZVJoQyYhp+Sr1+Al9r8Q/7lhyPugm?=
 =?us-ascii?Q?AvGonpP9JYUu/m27IbbvC29LFbLHXeKouyU4vM3fAZ2ekuhx6BTJ3zihayof?=
 =?us-ascii?Q?NS1Tmn5FhF/KPwMlwV6wMcCpg6kxxVEiTLPOfADzdusdIpjm55C6zrde/qH3?=
 =?us-ascii?Q?IAwSIoOzYVG6BziTm1bRSxDq8Sgwi6HBhJe1zyGZksbzeaTUAOGJMMYV/8By?=
 =?us-ascii?Q?N/NsY8PF5bR/rdbV0FXA6jlaijjLNu6IKFFYzushnpE6giuRVjpj8Cv7hDLx?=
 =?us-ascii?Q?NH1Lq/uGjlHtSVc4rfrC581r1E9Tup6Tf/ITYri21TtrdXMueZQF2PTb8ZIk?=
 =?us-ascii?Q?7yTqz+joSeA4k7mZvrU/F8Lu+hFzhiD3K9CJgekAVnTWCBMcLSyaCqwyE1+M?=
 =?us-ascii?Q?mZVWILFkaZ4XP3UuX1VmgZDaw/QI/K1Av9bueJbXAnassKGX6rVUQDyCdqwc?=
 =?us-ascii?Q?T7mC5ZYua5IyjI/KwT2c1jVdtmglXeeKt/KSieen0ROrsAF5boEmH6JyQlzE?=
 =?us-ascii?Q?ewZzzliXub1crHHaoLXTqBHotQAHeDpuHYwEjj5ybWro0RMHrYSFu7wudJq9?=
 =?us-ascii?Q?XFs+j85B5L7I/1v7BIgsfDrpfwh6YD/YY9FpLVet18MPp5Jrhb0kn2Q6oVpL?=
 =?us-ascii?Q?F4dcUIxY5ezLPnJBeBVWfWt4CuvAJ1KAQkye5w5+eU5qOUHw4UoDhruwFRHH?=
 =?us-ascii?Q?EJFQapoLiPUEXi6OP833NiFG5O3Yt/mJSueqVHfwlUQuvf4SZRrtyXQ0jGrI?=
 =?us-ascii?Q?HVUXUCvJb5cUE4amRj1o+qDSCQUx772lWW2nDY8tRrJHTcMXX7ycQ3h1x2jC?=
 =?us-ascii?Q?roc61WWN61Pqsea9Z+76TQLH8NNkZcVQRK1MXRCR7Z75CjXrW73HjsXsLZD9?=
 =?us-ascii?Q?y6oxjdH5oB4Wmt1hEADpz3a4gZIHfrzBnl913axKuOTXwDzzVtLr/kIKFpPn?=
 =?us-ascii?Q?xUEM8nYoc7MZG+KxZcREWTGjWqjojKYpbn9c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:24.8972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7680f96-0c7e-4575-fa35-08dda4c593b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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

Add queue reset support for jpeg 4.0.5.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Untested.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 974030a5c03c9..2bd2660b47d51 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -767,6 +767,30 @@ static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				  struct amdgpu_job *job)
+{
+	int r;
+
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+	jpeg_v4_0_5_stop(ring->adev);
+	jpeg_v4_0_5_start(ring->adev);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
+	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
+	return 0;
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.name = "jpeg_v4_0_5",
 	.early_init = jpeg_v4_0_5_early_init,
@@ -812,6 +836,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_5_ring_reset,
 };
 
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.49.0

