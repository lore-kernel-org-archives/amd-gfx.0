Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E48EC5AE59
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 16:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1494210E6C6;
	Tue,  3 Jun 2025 16:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4D8quh76";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EDF510E697
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 16:29:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCuAqAEBNnhbhYiy3WQdcENdXT6GeAuegNTjJSciDkjbbHK1j7bYbBajuKfelic6nu2YWZuAzPM1IU79UM/tnTyXT0bLeiBP48Gl2O75FpOP5N4IKxfSn9hD4lo8JnPNV5xNV/1vkDVjjw7Ysu5dWiDGdx6XS3wjguSgGT3+Zhc0TRZztzW9cVP0aURaj8SRyIFL0wQB785gqy9EzkAfEDlMFWWzZxOomrCJMFHsrc2r4DfQRZKJJhPPoF+kIa9cuGfd3VAFWWM3RAfS3NMUFN2fTHLvB/XkVw0Zbt8xsLhhYsqIvIxHd8BJeDHdi8RfTJzZn9ojMCHbH8nqKqNCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2Ne2CSMPaPVANmwVL7mOEJfvDWPyrdKX2e4Z4q+2/w=;
 b=dnUf78J6DkhUtyZzfzFLKddkNDA+ldE93QbNogDxCgRDVrvpc1vYzmUlIfOuflcFXprPabJbI3S7zjDKMDjck9LsWyaoPYQM6GnlRX6IwJ1uNOyCXDzv/EvNvdXtq3bbZgN7nHzxwrQHsUZRU7+QSSGvr9hN1xO2Z5RYwZNrF7nKrfyA8HJTWNEwstIcbSRIfqPg24rCbb3rjDXqUVBCupiskQ531iVKniC7gWUb71RHs/q6cT8GzxORr5+WgjsgEjqiaIc0y28dzaf2s8LpcVsZGauFKvTujQwXEOMmbapekDISElzUKe/l+6ujH3ebcy/o6GaH23IVyhL7Ucnjhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2Ne2CSMPaPVANmwVL7mOEJfvDWPyrdKX2e4Z4q+2/w=;
 b=4D8quh76p6qstGGUELM0q+pRTBtX6z+ErsnuJcfzZuX+gmNe6bHn2A0KV7fAE1ng92EPu8EO1F21qkFODfetfKxOzFW0A04jpT8rO3cUxQkkHC9aaTvSb4PRR6NxJKc7jkr9QDuDfZPDBsbL068T0v050I31w0BIWs6DtCH8MrA=
Received: from BN0PR08CA0016.namprd08.prod.outlook.com (2603:10b6:408:142::35)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 16:29:43 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::c1) by BN0PR08CA0016.outlook.office365.com
 (2603:10b6:408:142::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 3 Jun 2025 16:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.2 via Frontend Transport; Tue, 3 Jun 2025 16:29:43 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 11:29:42 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Mukul.Joshi@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: fix mes based process evictions
Date: Tue, 3 Jun 2025 12:29:34 -0400
Message-ID: <20250603162934.154349-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 965c95e5-6905-4431-517f-08dda2bbd8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JwIuyi0HrB7Xe6SVRBtq6aRyMFHT9omLw7K+Cf5zYRRUXX/X0NYbVfc8thIs?=
 =?us-ascii?Q?PTWpLkFbWTWsLgYf0sZfZJizAfWRmjks8evj/4areE/LOnH0IEYALAQz318h?=
 =?us-ascii?Q?tzPSuQY6qC0XWbqGCzo5o+Gky4lkaos4uhJaqa/pu/gvXuP1gRqnpHJ7KOxz?=
 =?us-ascii?Q?66CdVim7cTGunvq8ca+q0rDHHbWaKpXFmKHe28Nw+ctd/S0OR01xP5pSidHd?=
 =?us-ascii?Q?RhkWQ+4bJ4v3myO11ihUakdYAH9+yJe9ZkcSZKPAsav+ZFH7pGwdgTmX0d1f?=
 =?us-ascii?Q?a/outsEHshgaOy05KIBLR2rzGesgUqVnzLNzZdcYqT1UGnbzNwhxPZrR5bjC?=
 =?us-ascii?Q?b/P1gJno89qddYm3QmY92mnFI+vWKJPqhwhZKmSxW8XT6Y1hHnWlhKoSsm/x?=
 =?us-ascii?Q?jek5T0MbY6isekBtb7qhITaI/T1S2uZg90x3a+Q620mLHtCeCz96mir4RjRS?=
 =?us-ascii?Q?iyAk4RrFDJJ/F7JlPw/fygPGBPApXnov6dfGL4edWEXpnbTr3jH1licuhQ8V?=
 =?us-ascii?Q?w5Le5GLyCGTj0W/jdeq0SCOmEESEpMw0dPAUhXNoYmXWcTkFWrgZ/je1BHnQ?=
 =?us-ascii?Q?e5x8RAivl77xhKU0Q0Wof4igGs/FgNL6HwTQc2T/C19ii70pJFofGvqaMo3s?=
 =?us-ascii?Q?omKdDZt6mbOVcRlh7wUcyGxQqvinqFeCbjJ7K+uqdybug1gLU13TsWfLzh70?=
 =?us-ascii?Q?iIHMfzj609R5JFICgo6BM2Q/dlMH7gsj2ga0PDy557xpcXHFvbp0AQnIxe9/?=
 =?us-ascii?Q?aDEXmq8BB0jeE7bq0ugsdPEPxkQDuSaRZn/p7zB23Ne7q5/8Usapu9TsswhF?=
 =?us-ascii?Q?+NundhuMvGkVNo8+Biw3Jr9EgZgX1fi5lziigPY9svSx0lLZqLFfTNy/byYB?=
 =?us-ascii?Q?6KDunDCph7ZZdyBTD/AUREIGQl7ASaTqU6OAHTwTLMZt48Fg5vYPxZ3PaglB?=
 =?us-ascii?Q?kChpoKOYBGs2JEfd+JYJOXCaByq/tkoUCc908wd/TZww6b0ygtQkcm9rh2Qj?=
 =?us-ascii?Q?nLYvx8wFCsLhqX9S8pMQXCeclpIl41O3625JRYuEcq60ljPumyEINvwNaMK0?=
 =?us-ascii?Q?QcoGzJ9P2kKoXxMFrXi756Pi0mk5lQiAFjvvt8xT914FNqWsw23Dwc2kvzCu?=
 =?us-ascii?Q?Tm17JcFccXsHtrE4jc0QU5stAkZ2nFldkm+1Zy3BwlLbHoDX4SES+rrxtIXu?=
 =?us-ascii?Q?KLsD6rriLG+yYDTAPc8syJz2LQs8vQg0/z62MF9nkV2C4DYkAtpqNmfRINjA?=
 =?us-ascii?Q?YMvwIaQ++plusi10zlkcbLkBKQFCkv5So17py4Tb5xpieit/1SvOcnUW2N4Q?=
 =?us-ascii?Q?G0mItMvQjwEm9Ap5rhqBt3u5fPrMgYwY2nVvvGWOUeF6WU8tYGeNSsmA9Hoz?=
 =?us-ascii?Q?Myj2g1Q0es/dG/dV96gqkb37UnXGWop1qZhVQRPXIvZXsQp3fiZePH+/IC1N?=
 =?us-ascii?Q?pscKLC81kZKzg7RQyO/HCrxBA+NFSMdNjceBlGinViIK3x+uLO9ZM2poErAN?=
 =?us-ascii?Q?FIqV2NLDrqlHcx4byxgYX0xxyb69bgVmsKPI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:29:43.5765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 965c95e5-6905-4431-517f-08dda2bbd8ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
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

First, MES suspend/resume calls should be consistently held under the
KFD device lock (similar to queue invalidation) so consolidate
MES based eviction logic with F32 HWS based eviction logic.

Second, save the last eviction timestamp prior to current eviction to
align with F32 HWS timestamp logging behaviour.

Finally, bail early on failure to remove a single queue as something
has gone really wrong post-suspend and a GPU reset is going to occur
anyway so it's more efficient to just release the device lock.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 73 +++++--------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 76359c6a3f3a..c1f0207eeb9e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1219,25 +1219,36 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 
 		q->properties.is_active = false;
 		decrement_queue_count(dqm, qpd, q);
+	}
 
-		if (dqm->dev->kfd->shared_resources.enable_mes) {
-			int err;
+	pdd->last_evict_timestamp = get_jiffies_64();
+
+	if (dqm->dev->kfd->shared_resources.enable_mes) {
+		retval = suspend_all_queues_mes(dqm);
+		if (retval) {
+			dev_err(dev, "Suspending all queues failed");
+			goto out;
+		}
 
-			err = remove_queue_mes(dqm, q, qpd);
-			if (err) {
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			retval = remove_queue_mes(dqm, q, qpd);
+			if (retval) {
 				dev_err(dev, "Failed to evict queue %d\n",
 					q->properties.queue_id);
-				retval = err;
+				goto out;
 			}
 		}
-	}
-	pdd->last_evict_timestamp = get_jiffies_64();
-	if (!dqm->dev->kfd->shared_resources.enable_mes)
+
+		retval = resume_all_queues_mes(dqm);
+		if (retval)
+			dev_err(dev, "Resuming all queues failed");
+	} else {
 		retval = execute_queues_cpsch(dqm,
 					      qpd->is_debug ?
 					      KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES :
 					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
 					      USE_DEFAULT_GRACE_PERIOD);
+	}
 
 out:
 	dqm_unlock(dqm);
@@ -3089,61 +3100,17 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
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

