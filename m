Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771B2E74AE0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Dec 2025 08:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE8F10E051;
	Wed, 24 Dec 2025 08:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x7BSqgke";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C26B10E1FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Dec 2025 08:25:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcXwDop7b6lF3h+MfAmCkUBoKhx4G4L2FE9xcT0ZwRxlO7fDceqMmNVq8GQKozrjwcW/BdwHF6SqFt7vwwcrkF0HLjVmnmuuswfVBYuUQciQVCW/qnQnlWmUvILgPVH7GTayhPwZb0EYVtlHSY6Ms1jW3zmGvoCPrSNS3QLRXV1ZF9noxX6e2vMz6NjUfw/135BDYkwChinYM0HPkwmKCkjXUpuM6O9A2wB4DCCZ+hSN3RDnzF26e1ga7ivyW5+ozZlKv5zlcUm+c7j3uJ4pWa85oA3whZ/oNkhNp4w+TXICnDdEw4be4z3NVw6r7CU8HKhk0kmIYGoHRptycOuofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVTqIsDHvBK7WjeRkvGY26MMDUz3HEa6Jz9bog+naAo=;
 b=TM0XieQxRU8SJkGY0HE43Cy55USeI+kMHCiD04SFlEequgRz0AIEwM+fhJIpVcNk85GfA/G3jvObxFghygR2p7bpE/j2NSXDKyWk8TiH18dGjgpPufEARHD71Xc5D5juFWc6bck1N6INqVQ3fOY6gf7pbV/fjUHsIjV71LxxPYKvIZdaBUKudZJ6GHjTpDeDpZ0PLMYqPtvRFu2DcUCb91QnyMFSQ0n9Ke3/uiVKeovcXyEnGtF3T34S0qSRcpo7xmzQAKCPedzclYOer0VoNlJChtUypoSwK4Hgw+ITrmIpr74r3iFNawwW1QsPwhTadhDCpYUOsDkFViec5A0CtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVTqIsDHvBK7WjeRkvGY26MMDUz3HEa6Jz9bog+naAo=;
 b=x7BSqgkeupwouapTglcdf6CMo3U6Hw7v7YWYkCftMx1v2Ep1GtGzDX5lHA5M/J76rDpLy4JhXizaOkPm8OShZwpZ/OC2qqCfT46ksZ653gdzzL0OUdbJbVfi9yQtL+AC4FCYsfPiC2Qy7PTktX80+b/46CftZdkmjedPrDmxW1U=
Received: from MN0P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::16)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:25:47 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::74) by MN0P222CA0010.outlook.office365.com
 (2603:10b6:208:531::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Wed,
 24 Dec 2025 08:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Wed, 24 Dec 2025 08:25:46 +0000
Received: from bingxguo-Super-Server.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Dec 2025 02:25:45 -0600
From: Bingxi Guo <Bingxi.Guo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Deng Emily
 <emily.deng@amd.com>, Bingxi Guo <Bingxi.Guo@amd.com>, Emily Deng
 <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Force-signal fence when job is submitted to
 killed entity
Date: Wed, 24 Dec 2025 16:25:35 +0800
Message-ID: <20251224082535.527138-1-Bingxi.Guo@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd7c999-dc88-4f84-0f12-08de42c609d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/gUKL3pBz3gLL9ijUw3YWMfZZ+2zrHNkS7Yt6D3adNuFL5XWGqCoKlN15GJT?=
 =?us-ascii?Q?m0aYRhpzhhOZOj92IpXLKBPTgSkyqeNoK6Mdyi1Hr8Zerg7WqRL3mB1eUDje?=
 =?us-ascii?Q?TBxW8BYEuw78D/s+5mCseOmlqGgJZ232cpTnKA1RCA0JXR+4H/IPCxLhhU2D?=
 =?us-ascii?Q?a52TaXxgbF3VWJppWdESBvUC9JVlhMkDJMhvrhErI9Yfk/GsnSF86PeANA9R?=
 =?us-ascii?Q?7Jbg5db9/A5x56HWSuGJFM/rwE5Z2ZdFQTUitvK4CgndFkcAXDfObZ2g87wd?=
 =?us-ascii?Q?nmKx5b4rr/f7EqDw5AkIjERd9C97MFPgepesFgjYg8gVCRldJoi0onnyZc+4?=
 =?us-ascii?Q?nfsQee2PtLIPpNzlVuL2YoiDMxr9Dj1YaSpTLGcsXH1rCu66wObrHl+u2PR7?=
 =?us-ascii?Q?+r8JsUPeeNe1IGO7QuwbAa3KJcF/uyl43+FJHeEktbVOH2rm4clLCovk6hb0?=
 =?us-ascii?Q?exp7nIJhTniHkMgGn5leukCmZ37GR4QKpmnYGYm4EFFPuKEb64ohUmIWuT0d?=
 =?us-ascii?Q?rZw3GTVHKeGYmfk4LucVgM04NzxLl6aOnuLtLr3DmIdCoJtDdx0w50y9DQBU?=
 =?us-ascii?Q?gMwz44hfjOvJ8GQbFupQoXei1HtpzenEaYgBPNeLk0XDr1IKFRVhASbL3mIs?=
 =?us-ascii?Q?BrXJ1jqzBH7KLwXoItjf0icpx8l9krIUBTbz89Qogslw4OvFxurxWNlxmvKm?=
 =?us-ascii?Q?MbCrx7weuRMC/0S04mwl3tCr+25NXH/2QvU5P2Ljk0CmQknHR7adL6LEAeJJ?=
 =?us-ascii?Q?j4yLF5NVjdGYV+/e2+5DJaUnGUEfl63xymsBUZSaVwbHnvXs31zDQ1yt7IaV?=
 =?us-ascii?Q?o7FlPHjBpHJtbhr1IUAHYFlnVpOxn9vQVeqiOwXb55tsFOIATyabCxprVOA6?=
 =?us-ascii?Q?brOeKS/gqv3ngOxjBMG/B7EDlyxZDMb5fi5iHClyBl2CkO+93obBW8aLzYpv?=
 =?us-ascii?Q?R8N+PJ/GpY5g9OaU/7AKPk2844qVxuXKwzUgBzouIFgHsqhB6ZGmEx8vDI+K?=
 =?us-ascii?Q?Z2psldSHlbUpQwgltitk7vmDAIWii/uiJAYiOAPqDuLGmWkPO9S/ALL4QeJf?=
 =?us-ascii?Q?wsIZjSvX2rlekfmhG+ISIGGgCRsYDGFbUIvHaL2zRIgzHxlh8LbC+51XYpWP?=
 =?us-ascii?Q?Faa09O6wYqeymh5pOzq37pWLOpy3+mpB4BxMgF06IuOLr6330UeiPu/SIF03?=
 =?us-ascii?Q?s08XZuIz3vP6bNUXC9TYhhJE2C43A6WoMRHG2dUtXx/xIJ6XyKgFd8mJPth5?=
 =?us-ascii?Q?kdsRooNwkgBtTPkg//jTIeIz+RwF2n/zQHppqj/CHUTHApzPHghd8t8XckBn?=
 =?us-ascii?Q?e3KWlJU3kfTOMmM10kTsHGqTO9bFBIRy6PZL1hhJ1V1GXLA4JXvCpzmjLXae?=
 =?us-ascii?Q?4DQFUoKlMgDgmXzEOsOLuBqEg9mi97jlbrYq6o2fBakU95aCEb2BBBhScd0E?=
 =?us-ascii?Q?7QYIFHjAHgp4AFB8YDd0TBLpoaYswnEpHS1jiuv03cb756JJ/C/x3wAJw7Z0?=
 =?us-ascii?Q?e4P4tLKPH6ejNqpHzWDiXuLQkUw+ZmHHYuu7z+73/oODomqxYjqk45JeQF9W?=
 =?us-ascii?Q?KPxLlFBZpiWDjFyHqkM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:25:46.8541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd7c999-dc88-4f84-0f12-08de42c609d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571
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

Issue: jobs submitted to a killed entity can still succeed, except for
a dmesg error when the job is the first been pushed to the killed
entity

Force-signal fence when job is submitted to killed entity

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Bingxi Guo <Bingxi.Guo@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 8867b95ab089..998e35a1a261 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -570,6 +570,14 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 	bool first;
 	ktime_t submit_ts;
 
+	spin_lock(&entity->lock);
+	if (entity->stopped) {
+		spin_unlock(&entity->lock);
+		DRM_ERROR("Trying to push job to a killed entity\n");
+		goto error;
+	}
+	spin_unlock(&entity->lock);
+
 	trace_drm_sched_job_queue(sched_job, entity);
 
 	if (trace_drm_sched_job_add_dep_enabled()) {
@@ -597,12 +605,6 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 
 		/* Add the entity to the run queue */
 		spin_lock(&entity->lock);
-		if (entity->stopped) {
-			spin_unlock(&entity->lock);
-
-			DRM_ERROR("Trying to push to a killed entity\n");
-			return;
-		}
 
 		rq = entity->rq;
 		sched = rq->sched;
@@ -618,5 +620,12 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 
 		drm_sched_wakeup(sched);
 	}
+
+	return;
+
+error:
+	dma_fence_set_error(&sched_job->s_fence->finished, -EPERM);
+	drm_sched_fence_scheduled(sched_job->s_fence, NULL);
+	drm_sched_fence_finished(sched_job->s_fence, -EPERM);
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);
-- 
2.43.0

