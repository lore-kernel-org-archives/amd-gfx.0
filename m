Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38DE606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fSmURNCU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F26A112A21;
	Fri, 23 Oct 2026 08:34:56 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43535112A21
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 08:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBMwfN/knsllQ7QvCod4LgxH+7x09kUMJ88e5Q9qVYyOBP/RPVbgkYCkV5GFXL8W8EFKL28zptk4bXCub5z9eIGHZi61OC0n7z/2n1wwIaBjnem1LQf0zNHPxVuEJWp+GWHtXF7V1BcJRcpwMSa/27gmAKct/8zRWJ+5owrX7u18IvI7PAtHuasVIkB0csz2mn8eDyMb3JT9LoPxC0PheAoKqaelz4g73fdufAyfKKzh7QPcrwlcBHllAF0/7MrOMvobqZprXHglcrUQ1a/0iPBed/IhmAY2WS1XG1qzRA5V2xmraUWwcWxOn1yT1P+V4jgvrk1EVgdg4HKqyox7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12nrlpHNFLiAL/5GHektMOYAu3nUhlgVLSkZVNIWmlY=;
 b=Go9EgeGz41gI6uimg2MZK2+MV+q8ij/g1Q9mL2RmUwECG01BY4V/NlNBpykEeWg2dykWAlgo6y/RQYqLXc2ZDNZdAuJEAvoeLbIJHiCVuGCzxgpy1duqUBbNbi1Kgx22IMwmEt7rzScaegyw2PFBI0pHvrKyEApQs4KiQnci0IJzXP+6mKSrJNds5w+gWOwTZmdbT8mElHVxlwx4M5Lrn9AOYuMR/Zyj2vnhOItRE9ZHphJAe8iOMHVBT5VB0IBQkarfhG2KapRRqu8ULbjWAUFuNwNBRStGzPAL/KoPPpkU/SE2ElstJEv6aGIx2IFNlrXzWxlsSAMdg/mG47Mt2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12nrlpHNFLiAL/5GHektMOYAu3nUhlgVLSkZVNIWmlY=;
 b=fSmURNCUQU4dSzEUwAF0HNeWp5KJidjmQ/cxlatAsLNroy0FTxYJEj9J6fb6rGWcjBQNlwflz+EsQb3CXiBO62bEwZvaPNgTS1ah3964wk5pY1y9G6iB2ACwJ8eG0kUrofns0W0qwAc5mVT03bLMHcA9jl+bfuMcTX7ISCqCyxg=
Received: from BY3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:254::7)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 08:34:44 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::12) by BY3PR05CA0002.outlook.office365.com
 (2603:10b6:a03:254::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Fri,
 23 Oct 2026 08:34:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 08:34:44 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 03:34:42 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 6/8] drm/amdgpu/userq: wait for GPU reset before mapping or
 unmapping queues
Date: Fri, 23 Oct 2026 16:34:20 +0800
Message-ID: <20261023083422.3049246-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023083422.3049246-1-Prike.Liang@amd.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ee61e5-7bb2-466f-9fac-08df30e07d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|10067099003|18002099003|261021123027099003|22082099003|261022105027099003|261022075727099003|11063799006|261021121427099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: dhW3LegfjS7X0AL+YoqL2x42et2WvlRAJ6Ypnfj/Irf/ofgCIx/7wLXXR2xn8JS0vGIO27mbjVS1KTWMvaBOAWrK4ZOSlQgb3LMZSuSdn0Fk9x6vLtlHjOHcWO5tFm7tU8EHvor6TOz7rHXs5H3fbEUz4dry3oz4sO0tSkXYsw7HqxSXpF+bZt9OxCFYSogikuWSwsuStLd+yyvAg1RuUmkjQCyvgHuxj2Wyo8fvsX/OJndjxwDdUM68wWriTVCCNp29hAUfNw41j+HhOmwEint3ofeAZH8zb8i1/00L8zhTkdk4f+r4egjvSlvscU0ck3Xa7QuLhpcYcXH1Ewxm2xBuUqxmzQKQzGw8Foj+zLqcglpF+NK9rEXucqEiHIvftfkngwAuapGKi+dnC/V8z0j04JaTzjxEluTR/zJoRMisSx1EB+q3l4sbb+vAXJp/EZ18CntJ5cWmcZiFrHOSACPacDiDnEoqWFr2jR7P1z+V6JO9mBa39bz8ZWZgBKgS8e4tt2XK3Z+3nRd81dHKRd9zHwxELrzV1DSsHmsp7T1rEO28e1U5iLcf+KSozUjzNI+O9eV3o01h7A+/9wOkRiVUEUAKzxrlO8RVmS0MMig8TY5da8pqVSah2JcWtD+B8HRXAUAz5ocYq2sE99/JOBhKX1ogRixO4B0os5CtyXKwRCXFsC3fV5dwpvBd+zdQJstNezQTkDcMY77z0vh9pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(10067099003)(18002099003)(261021123027099003)(22082099003)(261022105027099003)(261022075727099003)(11063799006)(261021121427099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7hW3YHIHfKECOfTGnnG2Ylilvzez08+9KNPIcsII2tHAM7vLrZws+By2n8DYY3CU9jkq2gFcZwGso+JoSvfqdE/RYQlxKH606eWiii/fdvuJrZuXPytAHeoZuSbEC5HIFidU+Eywl1ypqREmbWeaZ7gURiHN0Y5k4rEwEVK6qFjQcl3OpEn/o0NivUreoov0Lrwa8HTJtJ57/7RQZoP9AAHxop6JoTIwgjfHSyIkMCT+9cLMhlSLj+biTtza8LWpSu/RoQ0i37Cf6URTJ0pMm8iXJZGHGNljgyGYrTx0esJv+xyqZhtnwCavp5qiOpQqoanshYlqXHZXRilsVhEXKY5H7cd15BP81BKReU4HZs0+CR76qMLmZs+F5Hbc7OCkDzgA6au2RYDM0i66bznuNVqr/Vd1arFPDXpDRPLGl4TCEqq0YdaIcyh33oQJpM/o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:34:44.4986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ee61e5-7bb2-466f-9fac-08df30e07d75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

