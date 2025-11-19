Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ACFCF58E8
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 20:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B6A10E0ED;
	Wed, 19 Nov 2025 20:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N9Nc4xl4";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012045.outbound.protection.outlook.com
 [40.107.200.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA2910E0ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 20:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjA/Rp42cNCdgkjG8TA+Xnei6cuScNVKpvP8rVV9G+cKolVcBla7bIUZKCM4VM8c6A2sb9lTD1jwNmVfaJzFaWmdA0i8DV1f1tJMKAofMXopThiN1rdX2rFS39RJYhkMExz0/Mfsm2f3x2P6n490DKQ4HzIOtQT6y74SwgizUIEvXSHKanTJ70wMCQT/yGftJQjmtNBE6TG273xrE7jrwQ6PYLbZM2Qh0LxiVuf+eONz27nCAISdPKl4W+LPzmnhUvK9v7pDear8Nh2s0bTXzeDzmzheJ5c8zD668m2S8Km93mfGVBko56yyQ4Hl+m3cZvyAnU6uVCuyBcgCAzFr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWd1d70pQ9qUdsgtU9JSSiqTWSZ3PjsxvgTzzx93L7I=;
 b=AUKs7ekQvaI8GBhvKSth2XJuoVU2IQN5iHBxIUT0dTuZfSPAUZFsq419ud4p+DX8mh55rNv0ueudHQ6cSn1rm69xaqNBJVEGnpUWYlzegNJR5jJrTMnJ5mtr/ax49GIEfuGkNB9VWAN+d1c5cdT8pL0mnSQdsyW3zH56MmBj8giVchpEY/XwkXHYDVR18XUke6ja481ffQ/BJvu60HbeVUE/p0BP5QFQR3b0V+EpkuVpLg0igIkt9+XppkTBOi7SVDriaaQWg3xt92orZh41jF32MOdSzG8NvsM5N1dHCeec8bA9T7c8gDQtLLaK1aqre/65TLaaZBFAgzjO1jQz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWd1d70pQ9qUdsgtU9JSSiqTWSZ3PjsxvgTzzx93L7I=;
 b=N9Nc4xl4vPHMVmANb9MacTmUY2EJ82fcLsK/W3E9QYSt1QKgS1Y0bbOwOH53UP50Ni+htXDocCa/c1Nj9rOwncssgxSdoyhxpN3Awv4R4NZSZ75+BAkj/s2yDtDIUPVXsasgGfC72VO263iUiopcKucTosrb/SyVzbL0rKc0LCw=
Received: from CY5PR15CA0103.namprd15.prod.outlook.com (2603:10b6:930:7::26)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Wed, 19 Nov
 2025 20:30:25 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::64) by CY5PR15CA0103.outlook.office365.com
 (2603:10b6:930:7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 20:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 20:30:24 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 12:30:23 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: don't reemit ring contents more than once
Date: Wed, 19 Nov 2025 15:30:03 -0500
Message-ID: <20251119203004.22742-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: faeaee6d-9179-4af2-1e27-08de27aa781c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bdFoXWztk7kf5B9a+L7C7JvbvwaD/KEYIHX64Fd0a1wIRvOXre2PgUypX5Vu?=
 =?us-ascii?Q?BEV0rlZD0tj3ALoQbVzkFeVdnmulu/Sr615dGHyafWob1eTNwrn0RFAQuH18?=
 =?us-ascii?Q?qyvxd5FU7ranc1nj50+DMfpecYNv96/8McxHyaDuredyvgkBtIw22BzgT/bn?=
 =?us-ascii?Q?x53z0cbof/7s1v+Hb1tXdd5HXUQlpTDwE2VjD0koL1I8YicKdETkuWHxncHw?=
 =?us-ascii?Q?bpABbdutvHaKBIjeF78ygZmEyonclmuHJfawz8np01nWw+htznkqzdp8vtNK?=
 =?us-ascii?Q?p+CsbxbkFgIwvJ7meVTq9pJYpYVYlNPkENi4xDE/aHOTLTQh4k9acR32aa+3?=
 =?us-ascii?Q?Br7XZTLMT7q6lhbtcERDSvhFi1zgvBkJVZhX4fIsUd3p6RkollTOEadJxofe?=
 =?us-ascii?Q?X8R6pCg7Mmy9tlLyeyjNUE5xGv6WJnaVzl3GEzMnw7OQzEILUfCNkQql4v9o?=
 =?us-ascii?Q?Mcr5qrXVXqgul0Pa4LWHbuSP5SJBslXeG/0r6Xm7dp/4kZNg4+NLiacBWgM1?=
 =?us-ascii?Q?Ajk1Brwgvih0ePV6R6KEw2EfZfad+7+ZYoQKKNJ0FmxXjpgv/sJyqtZChYj6?=
 =?us-ascii?Q?z6LK+JWTI2PZrevm0IF3BQ/qdx50bD+4k8d9TVDMPfRl7JS9G3rP7QU0efQE?=
 =?us-ascii?Q?J/ejndPOq0Sj/w60IefT1jtu2cIA19Ew6OUlV2tIUrwO4ipsdrwEhRe0yguZ?=
 =?us-ascii?Q?RE0E2uroDGhr38KO77E2GSTJVUN4VukaGIWn1ZePfbV5FN2+43SqRku1sw29?=
 =?us-ascii?Q?t8LlFFtJ5chTpUwAZyHuGMpAbviPKi4sFBfxWpDFRUCqn3zF3pqdZHbGuJhA?=
 =?us-ascii?Q?Y1p53nifS32m3kR1V63a9ObIa6g3++kXmDvqgjy9MuzkCgz2GsOVIUbXaLRw?=
 =?us-ascii?Q?JT54qvMqVQygKkh8NAfwa8QxjX601KCzVEMUHdDZkryukARXbuKMFAy/U+JD?=
 =?us-ascii?Q?pyJ8btbB3ltdpE9Akh1AJU08TN+76G19YaEH4lR6TUVCOjNKQXqtOHmeTXOI?=
 =?us-ascii?Q?O7OMJVNiPmHaEm25jNl3QLEpWe+JqOoRrByVG+smQPzWmnERYHd50i5wkQxg?=
 =?us-ascii?Q?yrYPl4Xe1P/owFJ5fA5cP5TmxE/DwCwmbBN3+nNap39osq1jJ22TV28FcbdI?=
 =?us-ascii?Q?8luEpzsMEAuqsCHOahhv/kKUgbR6iXvgZ6JMAFa8hGTFlP2M5otX++tzjXmH?=
 =?us-ascii?Q?FZjaL2weF9KuR/NLp9NMw7X0a3eS9IIrLBmzhSFVL4l9roAVLl9mOYR6+fQ6?=
 =?us-ascii?Q?4NimC60c1oCnhNC8UZRPMm5oHdk2zvmB/fR6k+nhs5sef4NQu0qcs+OaBSrl?=
 =?us-ascii?Q?rwui759Qf4+y79eBaIWQ3zhmEWm1BDzKlmYNMcR9MEfHYhFdbX2anWzmD1E5?=
 =?us-ascii?Q?U9aEpB4chY+6lU+NmMJIyZ8E+DNjWzbvD0IM8E92qOzdYgn6+nMZS7ZUDceX?=
 =?us-ascii?Q?xJn86H0AW15T7Gtd8a6E9p6NRUuvu6hevfJzLiftrFYOFObOjvcWZ1ZhZ/EK?=
 =?us-ascii?Q?z8PFahuCYOQqmAfwSsD+yAGMgGVrilvpRVmUGuQoUUFN/3LmpHsH6gvqVi4+?=
 =?us-ascii?Q?4CXMcrARQ9befE1BqJo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 20:30:24.5356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faeaee6d-9179-4af2-1e27-08de27aa781c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213
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

If we cancel a bad job and reemit the ring contents, and
we get another timeout, cancel everything rather than reemitting.
The wptr markers are only relevant for the original emit.  If
we reemit, the wptr markers are no longer correct.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 ++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 1fe31d2f27060..334ddd6e48c06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -710,6 +710,7 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 	struct amdgpu_ring *ring = af->ring;
 	unsigned long flags;
 	u32 seq, last_seq;
+	bool reemitted = false;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
@@ -727,7 +728,9 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
-			if (fence == af)
+			if (fence->reemitted > 1)
+				reemitted = true;
+			else if (fence == af)
 				dma_fence_set_error(&fence->base, -ETIME);
 			else if (fence->context == af->context)
 				dma_fence_set_error(&fence->base, -ECANCELED);
@@ -735,9 +738,16 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		rcu_read_unlock();
 	} while (last_seq != seq);
 	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
-	/* signal the guilty fence */
-	amdgpu_fence_write(ring, (u32)af->base.seqno);
-	amdgpu_fence_process(ring);
+
+	if (reemitted) {
+		/* if we've already reemitted once then just cancel everything */
+		amdgpu_fence_driver_force_completion(af->ring);
+		af->ring->ring_backup_entries_to_copy = 0;
+	} else {
+		/* signal the guilty fence */
+		amdgpu_fence_write(ring, (u32)af->base.seqno);
+		amdgpu_fence_process(ring);
+	}
 }
 
 void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
@@ -785,10 +795,12 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 			/* save everything if the ring is not guilty, otherwise
 			 * just save the content from other contexts.
 			 */
-			if (!guilty_fence || (fence->context != guilty_fence->context))
+			if (!fence->reemitted &&
+			    (!guilty_fence || (fence->context != guilty_fence->context)))
 				amdgpu_ring_backup_unprocessed_command(ring, wptr,
 								       fence->wptr);
 			wptr = fence->wptr;
+			fence->reemitted++;
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 52c7597870eb9..f93bf83f7f5e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -155,6 +155,8 @@ struct amdgpu_fence {
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
+	/* has this fence been reemitted */
+	unsigned int			reemitted;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
-- 
2.51.1

