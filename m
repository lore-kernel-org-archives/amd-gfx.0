Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B826606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Rd5DlGEJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2AC1123F1;
	Thu, 22 Oct 2026 08:34:04 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010033.outbound.protection.outlook.com
 [52.101.193.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7EFF112406
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:33:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYPJZU7iiWL2Z6eCWo5GxaI4Xvs0iBpFQadLQub3TBlRVNPbshIsKrqBG/4BanMvptg5Av/gJlVYXK27eZw+jdk/sbhIgflCeIhepxoArjR+ZpwPKfYgTzJonCHEE5iDqMrJlO8k+VwKB4IoDeNyfHoYGvQK1m3yzSLBTUEkAR4D80qHbMBo/CC0yk6LPvH/oH7SyPxa31CaV6Nb7sbLB2zD8bQJnCYNzocK4AAqiWyL2RPKehokVIH+nKRe9Sf3kkSpRvKledIRgktJ6cmOP2+K6E/33EGGg5hTWvQYSAT9eXpfkDDgvdRp+QDtIQ/jaYLWBl4GOXJMsPx4Bkh+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12nrlpHNFLiAL/5GHektMOYAu3nUhlgVLSkZVNIWmlY=;
 b=R2IXrpCLjZO5yQFYDIsKM7qeBSjsIJ4Y5HYE2cKxIHlZpkPO3HdLq7Zmpp3+TJom2iJJsOHVxevYPoi2NkO6NhvqizRihEijsrdvaVnpl/EPWKdS1o1p3xGQrx5nG7napbXGk/gKb4SzvzSWlrg3a3hkWmnqA44MX/fVGdYqLnJxRd5nw+7lKWqu8lBfXvR/wsZhMceiscsc6u2srGHii5yyP3iZUWtqPc4F/jywHVKJSokYu8+3bwCK7r0hbzdsQLpkzbZwGnWS0gWRfFsWnwIp9zUuxbOIL7Op+fmNbNfMIWnqc3IdRKeaBYs4GmGewpISefZb1AtjN8SiLkplqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12nrlpHNFLiAL/5GHektMOYAu3nUhlgVLSkZVNIWmlY=;
 b=Rd5DlGEJq9T4qAF7pOrIAMgLSx1IqbwKsF47EDHOzq7rCuBkYp+oMCVvqpd2RIfG8UqB7SO1ar4N9wTiUvrigSmTlsECI4CIl9BSqjOJLmmtWsnrRf/c//o6PvhQNB7W/OwwGS5mKe9Tnrz5ma1Iy8k04/Hohe+ZFYJTfJN9uPc=
Received: from CH0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:610:32::8)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 22 Oct
 2026 08:33:54 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::8f) by CH0PR07CA0003.outlook.office365.com
 (2603:10b6:610:32::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:33:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:33:54 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:33:51 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 7/9] drm/amdgpu/userq: wait for GPU reset before mapping or
 unmapping queues
Date: Thu, 22 Oct 2026 16:33:29 +0800
Message-ID: <20261022083331.3019779-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022083331.3019779-1-Prike.Liang@amd.com>
References: <20261022083331.3019779-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 515f7c81-1e35-4979-72b9-08df3017352a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|261021121427099003|261009223027099003|56012099006|11063799006|18002099003|22082099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: gZK/01O1IgKstIKVVPjfAoKWwl7dvVMSypC4FSYs9LA3pZMmoyZiIQe654K6ch0msJHVPcMQD70+yNlAzo21sYikc9da2CcdaoC98O472twKQD9bUwLgxCL2qxzTrajm5TC5nPbklruWN9Pd8Mu3kykoHuuyWe4aJ73tmf73bUO3GdYMoLgXMnLNi091gN8bYSRoqRjokcPfpxy+LVHXim9/JW2m4Y8OCNJ70qyh47J09CWCJF3k8PRrz598m4CS7UhwGmtmuwoNLZcOxhkFT1+lNNpV7RCA3m/ff5WjvXAh7DAWFAWddgRDi6yJeFxK1xY0XCDzNPRpHi1eyFIfiKOBErwpgSt1ATOSeYm5e3nDgl0DIAFOZeo82xPboK7eVIYeI0Z/Y7aKAOKxFrwCWU5dODrU1R6jV+00aw/uxsbZF4+OLL/POMZtHAjECJWrx9NxSKltD5Di11zDvWLoHxld+d5K6l3B4RHe+s89W+hInu76begNUhdE1zv0AHT7q/eHGLBxNGABdMHA1RwyRdM+5K/yJaT74Ac+617KzLHqtcV9Aisb+Wc4Ox6SjaYRQVGZJ8pVs/HeuWaTgJHwRNG4MSIqrIy6KfpDEOMAVzoyLaYKXotG9bS0PgPj3D8hGeHqAhISfGDG/jhKmIQnfto+X59yb9kMRXVQ3afDHAgHUvIxcf+xuD9bJatba5Itmo4KUc46815VBjY/WDe5Gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(261021121427099003)(261009223027099003)(56012099006)(11063799006)(18002099003)(22082099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tlGr7jaRaaRNuZdMf96n8Rf1EbTR9xGJUD/87xHKrMAacK2OnVIqN9ItufBxIPUFmCaSp2sCV2b7mb3ADHzA9lFymV2DCGtVlLidrNptlD2TSFzlLl8UDxSAEJytDqgm+ZfKRewbhiyr7tjcTrsMP4Bn5nCyOoFgcuUyhE0i0fhZSy5oWdRoIDQrG7YAIcjJub1RcOJw40nu98c2w+l6dfPXbFq7fC66+/rZMv8sb3cJreYwBw4bPXstpadnA5+t1sKSvOvLzQFEiQsIktAAn9SMBX1I5CUzzJVaQL+EJ1gLcV+NW3ZFnGFWx0iav8m+ZsBokiCGNa3s3HEYHsXyGmA2XjFTRHA9mlNd4EspsZgs+f0bbcGk2R8S/k/NIX39/hoQvY7uQ1ip4IrcgQh9Umt7Ri8Ky9zQpBaKKI8obPoVpVjuVXrLsawzN/1x3rWZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:33:54.3963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 515f7c81-1e35-4979-72b9-08df3017352a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
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

The user queue map and unmap helpers talk to the MES, but only the
create path holds reset_domain->sem around them. The eviction, restore,
destroy and suspend paths can submit to the MES while a GPU reset is in
progress:

  WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
  Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
  Call Trace:
   amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
   mes_v11_0_ring_set_wptr+0x71/0x80 [amdgpu]
   amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
   mes_v11_0_submit_pkt_and_poll_completion.constprop.0+0x207/0x520 [amdgpu]
   mes_v11_0_remove_hw_queue+0xd9/0x100 [amdgpu]
   mes_userq_unmap+0xc3/0x140 [amdgpu]
   amdgpu_userq_unmap_helper+0x67/0x280 [amdgpu]
   amdgpu_userq_evict+0x52/0xf0 [amdgpu]
   amdgpu_eviction_fence_suspend_worker+0x55/0xe0 [amdgpu]

Take the semaphore for read in the helpers instead, around both the MES
call and the queue state check and update. The reset changes the queue
state from amdgpu_userq_pre_reset()/post_reset(), so every caller now
waits for a running reset and acts on the state it left behind.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index c074b562fbee..96e338fa72e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -362,6 +362,8 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	/* The reset changes the queue state and the MES is unusable meanwhile */
+	guard(rwsem_read)(&adev->reset_domain->sem);
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		trace_amdgpu_userq_state_start(queue);
@@ -388,6 +390,8 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	/* The reset changes the queue state and the MES is unusable meanwhile */
+	guard(rwsem_read)(&adev->reset_domain->sem);
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -769,12 +773,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (!adev->userq_halt_for_enforce_isolation ||
 	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
 	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
-		/* Serialize the map against an in-progress GPU reset (MES is
-		 * unresponsive during recovery), matching amdgpu_userq_detach_doorbell().
-		 */
-		down_read(&adev->reset_domain->sem);
 		r = amdgpu_userq_map_helper(queue);
-		up_read(&adev->reset_domain->sem);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
 			trace_amdgpu_userq_create_end(queue, r);
-- 
2.34.1

