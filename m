Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE45C5B558
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BADF10E55B;
	Wed, 28 May 2025 04:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AJ5qc94X";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B29A810E570
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6Vsma8mjFdIYy0Fxz/NZi/WcZD0qVl2l/O66IKV5MNRy5G/yff8YU2xJXHOqKL0H7edT66R2lndvBhZBfWbnMNIAjRunKHJU31W4tlbFTDekXo/vF6IyjcwLxH3lCz+ZW09d9/RIVwoPgv46mEr1gEcnr4QFXXBDeSwRTYgQXKDuM+HUGjIDtEOUqL8VzAvYU/4Mo0tS9WbBE2LaU8GWJuNgOFmMqAaAtG0u0gbAk003D7RttMSTtNi8O9cZgiEL84GwxODYF3NvpZjBE3LdBhll2LGIsxm1wU7LFhPTo8/RCLGOxl7axVDUzpscMovmjkelYLNsS+4b96QnAbacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwP+iJc1MRmis5bpelfXPz8MlEzahEqFkzi4Sbsv+Uc=;
 b=cEzCAVuF5GRsJJezvaYnIcfZYXHDg4Cqrlvw3KWcdpQALLy5EoJTGADQQLLiUrsPxx6AlN7F0ZlbyX35GR/IVag5Jnkv567jd0/GuqclbiPFWQ8EFI+m5Wp2VGxtJcBjuJqMuI7qusqXrmP+vyThz8IJiZK9os+PPweHa7TQ2/7k12ouSC3Pf2ZzmpGHaV9rgRbX8XcpncGYJsCkuc1j1a0N4MeJkuAOImRVZdXAiW/iyK9h3eXrpigF8KPLLCkBTMT07dONLYiRhVxkZfmG/3AyOvGP2mQ7IA2IDMcWVAXXUoszVrALvRzAjFu/rZw9aL4TyLCfKiVUGtUA1vpeCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwP+iJc1MRmis5bpelfXPz8MlEzahEqFkzi4Sbsv+Uc=;
 b=AJ5qc94XXepWWYM2HKfW53y1tbUhxnK5GqelhaBN2F3H49O/ttrDCBX/Qjgd4rU7vnw3bftIPLEhhp82VOE2D6m0Lh//6+LVkXFJydahk1Pcf7wkRBB99RxMFoe1gz0zcNVaLF7ArALMupYmNbUUE5lrhmVDftIMEmnuPbUGvu4=
Received: from DS7PR05CA0057.namprd05.prod.outlook.com (2603:10b6:8:2f::21) by
 DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.26; Wed, 28 May 2025 04:19:38 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::2e) by DS7PR05CA0057.outlook.office365.com
 (2603:10b6:8:2f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.15 via Frontend Transport; Wed,
 28 May 2025 04:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/19] drm/amdgpu/gfx11: re-emit unprocessed state on kgq reset
Date: Wed, 28 May 2025 00:19:08 -0400
Message-ID: <20250528041914.5844-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f4bb5e-28d2-42a6-d68a-08dd9d9edc7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lQu8afvlUHcgKSFuteiTsdZ5CEJglQzLoplWEv1k1Y12xbnkOqA4vr/qz1c6?=
 =?us-ascii?Q?NbK6mzNlbHeIsgN26fpgc+QBVLfO2uQF5kOgmnYD2n2EAEeclMwuyivQIW91?=
 =?us-ascii?Q?IID6n/dMPp/ieeIjxrGtDbb4orf17dv1UOm+D/KUIy27WlZuQGAxT8yPe7ox?=
 =?us-ascii?Q?myt+jf9zcsaFB09wSufekKr4FnnkgPehVgtlMuhw3iJ3x8gUipQbGTFfzZYe?=
 =?us-ascii?Q?Ew4BwlSeyt2HDkH90+600QiAiKFv0V1obWYWy7fAidalTcYQuUhi9yFaG5O3?=
 =?us-ascii?Q?PVnsSWIPBxkzQ3Z6Gh/mgP+H9BlDpG/ya2B54xBr7mi40cuSsKAzTVbbHxK5?=
 =?us-ascii?Q?I83NczM58JqcgCl19KQQBWwHquYZnCAIsR1UGrFwGXKHkxwLNOIz1WFWIqSU?=
 =?us-ascii?Q?+zlRFcJ7rFqQwf1yjWVQjAuQsQunELbDgHVCg+YqIUqCLHj0X8LOrefAkqJj?=
 =?us-ascii?Q?/O5OjwBFOOKUcjszjK/jqFJ4PnFfeL1pWkha/Gn8cDK3NNOOsxbR2ax3SxbD?=
 =?us-ascii?Q?55mAfyWqxhi69lsesImFhmjE4SOHgMlHhwoLmXexS7sAmLEmWMQ0D+OS4kYG?=
 =?us-ascii?Q?u307LV8PpIkLS50GU1Cl6oV0OMvF7FLy7G3arPUgUjPqCltK3MInuHIW1DMH?=
 =?us-ascii?Q?pegaKhGH3wb03gaC8D+RGbLJShnjaigHxbgsRULdJ3IHgu7JpCY2lnjpzKTe?=
 =?us-ascii?Q?ozTzid2Yy42/VxUaobJDYYI+cKwe7p98wH/xhcWaBrRpvsI0Gwq4y8B0KMoA?=
 =?us-ascii?Q?PdEQBduB1BRvA+hzUehiWL9F1fPTl8Rlr/1oQh0OlC5AkfPHEaoVGiwsZkc2?=
 =?us-ascii?Q?bULqjKrVD03ENAajKH5F3QzkL/S12M6hoIdRvepF9KHrHn5x3Fdkp93nKmvY?=
 =?us-ascii?Q?INcoH3RyImdJo/bJOvlOCBsG0CV97JQsVEQS6YkApYcazmUqrFwaLN6+n1RU?=
 =?us-ascii?Q?TQmkjvFjPhcZqmIwyma0iNs+U46LdwF/id/dyrdlYRsVv3IG8C2/wtSsRyCd?=
 =?us-ascii?Q?U2VyJlYHSwvLIpkNEHjwvG+ITWXbwcSjiPJMJWuvUaCPvXEy1WuN0G+RnYaY?=
 =?us-ascii?Q?7IXNLUr1Qim7a+qgij5W0+voSGioEkFS7TRv6N/DqBNoTVS8Dk5r/DRtHBlm?=
 =?us-ascii?Q?u+OluzG9AR27tczRK2hK8d4EaL2l2HeTm4xWyW6o1qbqTULdSC407yIfWaOV?=
 =?us-ascii?Q?gHF3aANZ62sDPWxWw9b6n22XnuTwd3jLZaq45fRZ0n28cGSCKKSIoxhtzn0Z?=
 =?us-ascii?Q?f/QZHUUBsYycXXkmRJRP0P2laGDc0hs/YQkPSdfPYnXLD7UKFfcbOkskuIMy?=
 =?us-ascii?Q?iqa8oNmnBBUvyc6xtxu35zxk3p6ey0fpm4O6l5FJbAq3X0Sh1zwv/lovQqdf?=
 =?us-ascii?Q?gWqRQEt8WXJ0o0HXw+U3ogxf8RRlIJZF63mPj9IQjShH/91TXyV1GQzCCOwS?=
 =?us-ascii?Q?0s+ShZE+Fg1Y3QgxhdLFjhuLpw22c/245/yHIQsbDi44bKke+tswwDEC3IQq?=
 =?us-ascii?Q?+DDYCoCHvYaa/HreqHvPbaQmAteLxom9xwcj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:38.5188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f4bb5e-28d2-42a6-d68a-08dd9d9edc7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 39374c87738b3..b801cb0fa2102 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6818,6 +6818,7 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
+	unsigned int i;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -6843,8 +6844,15 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		dev_err(adev->dev, "failed to remap kgq\n");
 		return r;
 	}
+	if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
 
-	return amdgpu_ring_test_ring(ring);
+	return gfx_v11_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -7240,7 +7248,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.49.0

