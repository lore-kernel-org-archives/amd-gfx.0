Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6399CA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 01:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777BB10E5AA;
	Tue, 26 Aug 2025 01:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dTJ6/V1B";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D81410E5A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 01:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TL7+lifZ5cwLhuelXIcEyz464gVVcfoBzGdHrk1NpV3lsDDzpTQGX2Pvap76i5+jHOWYGXk4HqFO+ryLSdwCs0IPqDNIxYXT7ovzbuvAithgwEtLE3v+ar2fAUhNpc639ejMpAXwCov0V0yRrzmpnLTkUIZ7vj/Kjs4Q5zILMfH8hQeUj/6Fb/S0XoqpAzP5zfF+7ZpmVaVeMX5judQChAxbqopc1OCUBxSi1t4D31mnb/UGH3ELxbVQklG32kQBy2rYLNgltkIC/avEWd7sZORgJEJXDerrUTikWmXVJN7O11x0+sZmkq/ZupbzZAVRU0BuJxeskUo11MyUYLaivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0kPzbWAe1gVTxMOucFfR6KfWoapfkMxFvxyCNZWkM8=;
 b=rL2KaExZ10ER3fcRxx/dyZTwSOuqfvn+RxhTVKbcK+kL2szAE6knXj7wO2cNflwEkP0Uoq9FIyNLow0d1caRsV8PvAcrWWwkOaYZ/CFXMQ3dvIK6C8FA2GjCP8OMDGTSqViLPCxTQS/G1wZ2++MqlUugbnsMI0qESDk53RSksAyPXGLGw8GykH6cDiLCxbbgQZ4Zsqz/uBKIPakWKe6TOyvkPAccriqm9Dq2SaXHBZN8++NO3JrFcnYDvaerlU6fqZmuUX5vn1aF4q8nq18iAJ6r/D2LDiRinJ4NqItFYHvvMM5GKdo+o7A2MnoenifHT0s9EAyyCcae8fMhCnMXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0kPzbWAe1gVTxMOucFfR6KfWoapfkMxFvxyCNZWkM8=;
 b=dTJ6/V1BeZ9oSG5YqGUGsNdiCeptqOt89FtKszW7pvaMY5rT2JXLK8eEvBoe0WWkooBjfBoHPhiM3xNOzN5qguFIEEvn4+8HxsblSzzEAfFM+OLVLfpCzWxprpHciGA2VsP2gOF7rLXcimCpv0e5nuwxS8XYNhanhyMz2J0qKCU=
Received: from CH2PR20CA0018.namprd20.prod.outlook.com (2603:10b6:610:58::28)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Tue, 26 Aug
 2025 01:48:09 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::94) by CH2PR20CA0018.outlook.office365.com
 (2603:10b6:610:58::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 01:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 01:48:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 20:48:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 25 Aug
 2025 18:48:01 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 25 Aug 2025 20:47:55 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v12 10/11] drm/amdgpu: Switch user queues to use preempt/restore for
 eviction
Date: Tue, 26 Aug 2025 09:42:20 +0800
Message-ID: <20250826014648.1711926-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
References: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf454ec-a25f-4b46-3def-08dde4429c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?21DoC7hSz07aUisbi+9IBiZgyXNLGycpF57zZImA6d7bj2WdLpZpD/UTVM26?=
 =?us-ascii?Q?0HcX8IOAOlTPPNHPgGiEfJfXT6nM3fm10aVea8fyFThE/lKftlwqBmtel8Mm?=
 =?us-ascii?Q?IzuaaU7b2aNTRKr1mslIrbqzbAelEh+4H04foHLVPlDS0PrZOpe36rXA7/q4?=
 =?us-ascii?Q?x79Yby2JYCannmJc0QSCDsUxuBKGgBAMr3s2TRToochaWIVouCgOF6VzT8HR?=
 =?us-ascii?Q?44zzid1xmIF+ui2hKROOXo0xlVjoBUNsjx7q/j0X0Q2nay0bUawOg4sDFXH6?=
 =?us-ascii?Q?stq2tbYUsfUGevBhroSzcGy8G7r24HIbkIxRU6WHhUhUt8nFn3cn3u27Ifxu?=
 =?us-ascii?Q?bMIfDXW7nHjVS1F+Zjkp9gVtR9UMDy/er3pfHv9HKLGQqXdgdoRMI4iMqGkM?=
 =?us-ascii?Q?aQqspHZKiHr8at7qMfKNaqvZ3zwT0QAOp7lkDOgfC38Cs4BP6IIGitqVXJyW?=
 =?us-ascii?Q?KYuPZEq+rJXvdSHlsud6qipzbv6h9vR2tFHpYAuK9EWvrxG8eijS6Q0Ie+F+?=
 =?us-ascii?Q?4B553XK3Nq7LrrxDgCikcQwxTt+6NipycficDQOj8iobvJjSbv1RFl8LyZhS?=
 =?us-ascii?Q?vmIw8g5W+1GIjMpouNrAuIzvM2myQtpl9AAoL1z12sBzRUeos3zVf0i55cZY?=
 =?us-ascii?Q?xLW0dkBdZuKM5iCuc4si/CvStt3c1qSpJeDXFLOw4ccjELrz62d3A3IE5HGP?=
 =?us-ascii?Q?j2L6cazbVKrcCZ1gL3ZsQEpSMKAGpvZDmM7T+OAKx6WTg4+bhgVdHpgdAzjR?=
 =?us-ascii?Q?9iYdZZh45Bo/Fsw+pC91+YEUw5ioGM8yioJj2sFRmzTAJDcrEttVtiraZ9m3?=
 =?us-ascii?Q?3rBOhAczpeoHJyqoNkHb9iYqjWJDy8ZTPETwX+Q3Dz8c39TpCcji1Vd+bni2?=
 =?us-ascii?Q?DL3T4zX8jV/OlBgyCqQ/TXZSwYxS44vyA09lXUd015NfOEHFu9aGp0aX9Col?=
 =?us-ascii?Q?7qNOc5IDjwvWnZLfuaonKzco+ihWBwwWTqmOfz67b2c5Y12eIPkdoiqjq/NS?=
 =?us-ascii?Q?M3IV3qLfY7x2EBNABtHqLPSYoz3oTp1vyIztUwCSJzltd1fbLD6qHWSyWdfj?=
 =?us-ascii?Q?NsCG4aRohmJVHv5aoa7nE0bMoLLXCs6zbIhGR7j9hLbulyjozTEgu7Fhy1GP?=
 =?us-ascii?Q?IAIxeOczPS8frr10L8bwVaYOmY6T2JUkAkURVrb17sbVZsqhZc/a52W9vGDA?=
 =?us-ascii?Q?BI/+eE3ftX1m4BesOgNrgCa9Sxoe1lit8l1wt3vmuBJvOfC/mUlB91Jvx1UT?=
 =?us-ascii?Q?TaEjMiQ2z2GWf4Oij2l9V631o0m3OM2REwC4cCsn7IwSRdRED0jom1ESGTyY?=
 =?us-ascii?Q?eWgp6F7HmjBZO8xzYoqPny20EvC3kfvI95DE0HsvyrPOl/sxPCoMDeDUVyRW?=
 =?us-ascii?Q?T376N2SIQMJsvjVSqtxlHhKmmWP6PJSHA6NHAWUS6MVzRRMSgZhJFa/k1oXv?=
 =?us-ascii?Q?5TiucF4y/dF2CdhiRmrlEpcIPLRQqTSgDBXb24XLDIsap3RIIezfKkvy5kTz?=
 =?us-ascii?Q?O0IoiT9XEgZ1YAOoUFO9iMwsCjuDibLOVakP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 01:48:09.3805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf454ec-a25f-4b46-3def-08dde4429c19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
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

This patch modifies the user queue management to use preempt/restore
operations instead of full map/unmap for queue eviction scenarios where
applicable. The changes include:

1. Introduces new helper functions:
   - amdgpu_userqueue_preempt_helper()
   - amdgpu_userqueue_restore_helper()

2. Updates queue state management to track PREEMPTED state

3. Modifies eviction handling to use preempt instead of unmap:
   - amdgpu_userq_evict_all() now uses preempt_helper
   - amdgpu_userq_restore_all() now uses restore_helper

The preempt/restore approach provides better performance during queue
eviction by avoiding the overhead of full queue teardown and setup.
Full map/unmap operations are still used for initial setup/teardown
and system suspend scenarios.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 49 +++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index aac0de86f3e8..decedf8057ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -45,7 +45,7 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 }
 
 static int
-amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
@@ -54,6 +54,49 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		r = userq_funcs->preempt(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userqueue_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		r = userq_funcs->restore(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_MAPPED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+			  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
+		(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		r = userq_funcs->unmap(uq_mgr, queue);
 		if (r)
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
@@ -536,7 +579,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_map_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -693,7 +736,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
-- 
2.49.0

