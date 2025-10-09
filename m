Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50BDCCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 18:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7425610EAE0;
	Thu,  9 Oct 2025 18:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mBfApRaH";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013027.outbound.protection.outlook.com
 [40.93.196.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B04310EAE4
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 18:50:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2KNkp3Qyx4fq0EHNgVPvt41Pe9W4cENU+0IF77FcHhJqGN4gIAI3QuyzxSyMTZWycl9D/6vNk5dds6bYE2qvgnAHQwRQgExgd1FEz5i3scauAtBD+4qRzKcCI59Hmem38SaVigHQTGytdIlQ64ZWzCXT8ure1UNoKd/eA9XNV3GaBmqvUdAyVDtoLG9q6LOTJclFDSzO6Diwh6m8tpbn80IRDw3VBG1ixygkDgZ49+9goeWZ4cIDM3Fsepf54JTdOZ6yNgxMLZKlqsAKMofDy8rZQHgIkJYIDWgbjSHU3hLANNuCFQUb0wY1tpDd8YB1iAWmuU7wylHTArLg+QPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TyDY14yQ19tRrM34znuvHobNVZOFD02wd9IPA78epA=;
 b=JWXup8TvWe7sZXUzUuRSTEAltvr7BqGln2ftM21K/Bv8p7Bp+7rQiPSVEB1QHTPY/matjyZJ7tMkJA3Xz+sMyiSN0eHOyCqavaDeiFQZM3e2V8zCV+y48dI1BEzWjjrxmQyVl7A0+mRtcRWitBkkzsAu6TUsAmzUq3Znhlnunb/+v4RtUKuMg4WMbbnNgxYOqSH26s0ARNZF17iMB8TyMo7ZPebD6a6rDia5RCh0jWNx591K5D6YT1BactHs4KVxyyaI3wsb3Z6oqy1TaNvkzj7XZhDXRD4AiM5Gos73nu8dKdBT5rXygpEbKEJtbWy+GBF/8ar1Lq6mB3Txn/YJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TyDY14yQ19tRrM34znuvHobNVZOFD02wd9IPA78epA=;
 b=mBfApRaHfbcgXfFwtxdC/6CWXsdUDYWDBS1tbgUv5OvcTe3stkv356qsnIfXRtamoHvHZ2TJHx2vWZjqA8nD3m9ykDvNArUoNjQyuGINXmejdsa6mbmDmJji70MEqFkp4+a4CqEwQ2RbOTRv+7tSQVp1gP0+3iEQpWNAiveS/4o=
Received: from MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44) by
 MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 18:49:58 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::98) by MN2PR01CA0031.outlook.office365.com
 (2603:10b6:208:10c::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 18:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 18:49:57 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 11:49:54 -0700
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexdeucher@gmail.com>, <Alexander.Deucher@amd.com>,
 <Shaoyun.Liu@amd.com>, <Harish.Kasiviswanathan@amd.com>, <Amber.Lin@amd.com>, 
 Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 5/6] drm/amdkfd: fix suspend/resume all calls in mes based
 eviction path
Date: Thu, 9 Oct 2025 14:49:28 -0400
Message-ID: <20251009184929.1038298-6-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009184929.1038298-1-jonathan.kim@amd.com>
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 553bb704-25a0-4d8d-0952-08de0764a4ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R75rj1y8/4QJKNeYTQLko5hdZWzMZiPuMPv6eosyxL+XpPTn5A1A/sI4Iyhi?=
 =?us-ascii?Q?OtXsjPMh84vG6/NFG/09SHRya997OIToK11/JS06uQ488w600ckQrwAKAGai?=
 =?us-ascii?Q?WCj27x/yxWDQKOr4YTjNGpfUOMBJTiVVTgur+jbWZENY+TlT1kwOpMw676X3?=
 =?us-ascii?Q?WsxszCaFTGOPJ7/hRGwGl+Lq5L3vz+00JiLaPn5jTHwIBykZBzkshue9Z/nR?=
 =?us-ascii?Q?OeMgqpjJSVnPinGwPMR0rwzEFFneuRKPVW/5r+Nv8ARvovRuYNGHmnMcZ2qP?=
 =?us-ascii?Q?gnT+/XM+oz2X+VChB3IXkHWLSKRLWcnMMzXKZ8vslYG6wuVUg8kRnNJ5oXRc?=
 =?us-ascii?Q?uG6d9dpaO8aUKJRd9sfEuyFpmpmHVYLSYEXu/3IMRK3zG95tYE4FYNrx7+1H?=
 =?us-ascii?Q?jVh3e1cPK6qdwIbtGJMh5o/LpNWpkXGAmJ+h6hDHcKppeiYRkB1TAkg73Yro?=
 =?us-ascii?Q?K1l4u93mSusWtZxapX7JVngBPvWmbCwu+DTmvzQrLb6xxxw8ORmDAjaNrajV?=
 =?us-ascii?Q?pyU773Sz0ojg0ByeoSqYO9AIvhOpsyU0+5Xex8sokMzK6VBPXzQV8yCh9LyD?=
 =?us-ascii?Q?zvkBgjrMJLY3mLjtKjSEw+uTW1qTihIYVRQQMg0zGWKLyskPN+Vo/M8IJNdA?=
 =?us-ascii?Q?0yBLy0TQecZ8Rjespo5s+aR8Nsaoowyrnbsubw3Vb7daxcNMbQ2NV7bNETFd?=
 =?us-ascii?Q?QfAK44u4v09bbTQz3WAcO//dcdTKJVF/kaTY3B9wDq/7lkSmsJ30z7Ocj+ua?=
 =?us-ascii?Q?e4I1PDBg/IbNcaUBKouUP9T6yGNKpiZuNbbjv4HCaj5RjvzvXGoiIFAnR6q0?=
 =?us-ascii?Q?eRFHk5YATh4fuXnt3fs+NyUWLrfYGh+EogOEYQDtnWV3yoaUJ8qqb2KtOUB4?=
 =?us-ascii?Q?ipqsN2t+Mpp6xV5BQGuDx1A30AdQKzEpFRuJvWYNUxp3Zrc1bJ3qcP3KPlSQ?=
 =?us-ascii?Q?Hm8guU0tYMBiEccTA0RDFfnaoca+Me5WfdGSsNpoKJYuTieQ+lkTbdecGDL0?=
 =?us-ascii?Q?wpbCaGSoRXjgHHGuC1OmKzMiQZDrrqI5aFFgGiGHQ+qeWjeSL7M1MLTTrZkL?=
 =?us-ascii?Q?dT5rO/ZxH/I3PbgHHrP4KJQ6rZiKj27XHXzmjkYSqlerzAYV41Z9dfvZiUGu?=
 =?us-ascii?Q?9SnGytehlL8ez4qE27Ck1Uc6vRl7TpFFc8zdzL3aFHE618JQRy30sNG5F6QO?=
 =?us-ascii?Q?gt/HWDyjaKySkW57DuMq+y4/nsYiTubmnBGWSPlqEnMlhJ2YWc7yZKNyqwQM?=
 =?us-ascii?Q?1no1DyGCnXpF0xoALzDLY27io68eJSXtT6egLzNQDhE+K7ST9O3gCgmGJFrE?=
 =?us-ascii?Q?F7xQj1OmIY+doWRg2zGTVco3Midxnej4TnlMrdFB7I+5PwkbhE1cY7lrPRL0?=
 =?us-ascii?Q?Vo/xsKDtA5WKlWSj/VGBjB/B/CYPT4LvX8fq7oUzNA9mcqsx9WfbR/kgQ50M?=
 =?us-ascii?Q?wDmQaw49c25tfzfIqPCDwxBId8rhoV9R0eYL1rGhTZ74CUAvI0YyS5eVMZKn?=
 =?us-ascii?Q?e7Yh2FZ2KEkYvo0VzTpu+PNf3gPZ1o9VDJsNWDqA72xI8vtMgwXNC4p2TvgU?=
 =?us-ascii?Q?skokqzAQaIYQa4DtTDo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 18:49:57.7801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553bb704-25a0-4d8d-0952-08de0764a4ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
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

Suspend/resume all gangs should be done with the device lock is held.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 73 ++++++-------------
 1 file changed, 21 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 6c5c7c1bf5ed..6e7bc983fc0b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1209,6 +1209,15 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 	pr_debug_ratelimited("Evicting process pid %d queues\n",
 			    pdd->process->lead_thread->pid);
 
+	if (dqm->dev->kfd->shared_resources.enable_mes) {
+		pdd->last_evict_timestamp = get_jiffies_64();
+		retval = suspend_all_queues_mes(dqm);
+		if (retval) {
+			dev_err(dev, "Suspending all queues failed");
+			goto out;
+		}
+	}
+
 	/* Mark all queues as evicted. Deactivate all active queues on
 	 * the qpd.
 	 */
@@ -1221,23 +1230,27 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		decrement_queue_count(dqm, qpd, q);
 
 		if (dqm->dev->kfd->shared_resources.enable_mes) {
-			int err;
-
-			err = remove_queue_mes(dqm, q, qpd);
-			if (err) {
+			retval = remove_queue_mes(dqm, q, qpd);
+			if (retval) {
 				dev_err(dev, "Failed to evict queue %d\n",
 					q->properties.queue_id);
-				retval = err;
+				goto out;
 			}
 		}
 	}
-	pdd->last_evict_timestamp = get_jiffies_64();
-	if (!dqm->dev->kfd->shared_resources.enable_mes)
+
+	if (!dqm->dev->kfd->shared_resources.enable_mes) {
+		pdd->last_evict_timestamp = get_jiffies_64();
 		retval = execute_queues_cpsch(dqm,
 					      qpd->is_debug ?
 					      KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES :
 					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
 					      USE_DEFAULT_GRACE_PERIOD);
+	} else {
+		retval = resume_all_queues_mes(dqm);
+		if (retval)
+			dev_err(dev, "Resuming all queues failed");
+	}
 
 out:
 	dqm_unlock(dqm);
@@ -3098,61 +3111,17 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
 	return ret;
 }
 
-static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
-				   struct qcm_process_device *qpd)
-{
-	struct device *dev = dqm->dev->adev->dev;
-	int ret = 0;
-
-	/* Check if process is already evicted */
-	dqm_lock(dqm);
-	if (qpd->evicted) {
-		/* Increment the evicted count to make sure the
-		 * process stays evicted before its terminated.
-		 */
-		qpd->evicted++;
-		dqm_unlock(dqm);
-		goto out;
-	}
-	dqm_unlock(dqm);
-
-	ret = suspend_all_queues_mes(dqm);
-	if (ret) {
-		dev_err(dev, "Suspending all queues failed");
-		goto out;
-	}
-
-	ret = dqm->ops.evict_process_queues(dqm, qpd);
-	if (ret) {
-		dev_err(dev, "Evicting process queues failed");
-		goto out;
-	}
-
-	ret = resume_all_queues_mes(dqm);
-	if (ret)
-		dev_err(dev, "Resuming all queues failed");
-
-out:
-	return ret;
-}
-
 int kfd_evict_process_device(struct kfd_process_device *pdd)
 {
 	struct device_queue_manager *dqm;
 	struct kfd_process *p;
-	int ret = 0;
 
 	p = pdd->process;
 	dqm = pdd->dev->dqm;
 
 	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
 
-	if (dqm->dev->kfd->shared_resources.enable_mes)
-		ret = kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
-	else
-		ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
-
-	return ret;
+	return dqm->ops.evict_process_queues(dqm, &pdd->qpd);
 }
 
 int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
-- 
2.34.1

