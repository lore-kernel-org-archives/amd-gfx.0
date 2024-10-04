Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA20CF8840
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 16:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4ACF10EA3A;
	Fri,  4 Oct 2024 16:08:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m7fNQP1a";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC5510EA3A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 16:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzDeK9tMOQejqUDF9Y0VBMIV1KpagjadtKIJJ5KuwjxSqHbK+WZgZmrygLSfSS7dW50YBFbeERiizIWzBNJuHmgGQggEUdli8Jx3UM9VEo439J6OVHOY8mTuXMPES3t95K0ralgYi6U9hezBdbjql3OoAXhUCZy6DhwkjgWpscuh9PHgP9Z9wKOv2Sy33kmPMS38NXbkD/r33G69kXm8ziuUr8K3ud3mwTcXW4HyO4GQtPVMCEezxlc52HBbcK/H2wCs8JEAU7rmjhQVzzBC54Y4vRRu2saLZ6pK8F/R05eFUrOlcFId1KTIHRIDH7cfk5EJqvRJct4T7enTX0ZAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNqwjvINZYtTrM4v7hxBeTZCvfMqvCMBzXurecyyWNk=;
 b=dtmujUeb/zk9vEczx0TsC59LN76bs098su2R95rxYQZx4IxJNRkckJ55aaudnJ6SCq5nx54RObhiBHONvu6FE7xULnYbPeKboN47afa3iBno5Ki4YQ1pE0qaWazQCf7NpuyoWTdBbz1JgVe48WaLTRh0kT10nKwSRL17oGXZfpKWbcCixzidSt4N70kyKNglh3iYhAG04NUTTnxQjsyh63nWF97HOZ850dD6aFqiutoVmhU0/HtC5URujtAYeDXig/JT/rPs+CNv6Qgfinxlh7Egvd0SolB8k3ph0IweeRun6nsmMgUquKQv3wfJKRTh2gjqBnEWpoart9rse6nfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNqwjvINZYtTrM4v7hxBeTZCvfMqvCMBzXurecyyWNk=;
 b=m7fNQP1aVEwuvE90ya9vEowFNfW6rTcz9uubAeMukW2Z+i7okImWlhPbBv2iPLb13UlRhyPY5GPUMRIQmf56+0BHIhAXMu42iY30Tw/1ko8NjPgEawF/rYFqsLD7wGy2oANTSLHMW/he37yC+tImS2hAgGjPYAMM3DjW0jWvNdw=
Received: from SJ0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:a03:33e::25)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 16:08:01 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::8b) by SJ0PR03CA0050.outlook.office365.com
 (2603:10b6:a03:33e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 16:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 16:08:00 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 11:07:59 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdkfd: add/remove kfd queues through on stop/start KFD
 scheduling
Date: Fri, 4 Oct 2024 12:07:45 -0400
Message-ID: <20241004160745.5282-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: beccafa7-756d-4868-f747-08dce48eb84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AAJCK4v9QqHkvyqzUOnz71w4ipKJs7tC7xykVoAe7OM+iFmnRdFLhDMYh4YA?=
 =?us-ascii?Q?w6uhnwkiVYtUCRPEF2yxWLyntyzOq4atURHPmHibToc6evB1XraSlF2CUa3g?=
 =?us-ascii?Q?fss9GwVlY0olzE40Y2ImAAMrSiROzrUpthWjh377Y7DV2k/+Fx+5uyZR4Ful?=
 =?us-ascii?Q?0OgGOP+r5ggkb54oTxezH4Hphnkn41AW8dzZp3GjnWc3AsRf0IwY0QhJ4KLi?=
 =?us-ascii?Q?FXrHroKQrpBi/595UyHNLEhngmokRRvx9bKl2gU8tzZKizinyDBh68qKPqk5?=
 =?us-ascii?Q?Ob8zLGNe8re2GAOwoXnpvpNSKiDCCossV2rTGVZAePhbXg5+VjVwQLM6qu+s?=
 =?us-ascii?Q?RHsdXhflbwk/hYQGyswQ5cx9MB0GEn8BuoPgYNAvp0N3yBK3h1a4t0I0bv6r?=
 =?us-ascii?Q?d4YKxFEeCkCOCXGG5SR5Vpmm+mGa65+tU3Zh9T+DR2pZL/IAr6jTx8k2Mm9F?=
 =?us-ascii?Q?AHClhT8gllGiadiDi/7h4+V/7o0I4alml3lqM0hxpUVS9yWp+/YSsYqNsrxJ?=
 =?us-ascii?Q?ioUUQIt5WJmn3grgNF3/CKabhh5AY313djmqnX5kiiMWg/9Oy7pZh3FmzT2b?=
 =?us-ascii?Q?nYXiX+uONUBi/Da0Jf5vwiZNbfauCwMAPEta5BqYg/u4/Rsoslf7UHJx/A5A?=
 =?us-ascii?Q?12xvP2EHW3cYnsO+hUvnlxCN0A3NHwT8NT4fa6cDwAGwBnMVgoWMwqCOWUI0?=
 =?us-ascii?Q?XKp176e99jWgbdmDdem3bbEYJZWcFqh6Io6UzSYT3KwJdLrKrFZyU6Y3NkVI?=
 =?us-ascii?Q?3glK5DG8V3taByUNN8H7yO3BvvGisoCcdrZ5ybOYuEnM6HgBUi0c0/hXE8d1?=
 =?us-ascii?Q?aXtTWdwn3TaBIJPgLfW65yhW4Q3cMo++zwjCWcqBNAhoN1Sofuc9486oq44T?=
 =?us-ascii?Q?F8IM3zwhJgCjoa9IYnY/3meEiEqRMquTGsJWnhbHVhK+/35lZpsndn8R0uoi?=
 =?us-ascii?Q?q+X9TKkuLJnFfdki4Be9uiPjLgvFsdGz5qmbLAsUoIOzXq345c8SmpmTzhc5?=
 =?us-ascii?Q?hhBYMPwMGXg0W1BvGf8pFh8aSASWkpYBgU3qxkEdRYN9esDGFAOd+wz6brSY?=
 =?us-ascii?Q?NJFHQvvufzKUCpPVRWAEJQDfS/aWWshQU3u1bXxmL7F6h7s3dG32rEKa50BC?=
 =?us-ascii?Q?5VLJZIQQfNGo1iNALhdjl4+74JtPd6MWcPgQKv8zaEsGF/bs7ui1pZGX48/K?=
 =?us-ascii?Q?A+nRh4X4XBiGtKmSwIHqLImY422P8j3mlInrsrWQ9pExqJgpBPL/C5ofxda6?=
 =?us-ascii?Q?QEz8Ged5wtMSe9qQyPr5T0A5vVVojo2LEEOMquNEyBdFxqGOTlAm6kmNec5X?=
 =?us-ascii?Q?tbG5Z2z/j8jiCVktGgzwWbmyw1X3rnnpxEIBQMTunl+ef6s6KM+cJY3bjOfp?=
 =?us-ascii?Q?lSW4kTfWCWBlCLdo0IwTscIj0E3Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 16:08:00.6564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beccafa7-756d-4868-f747-08dce48eb84e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464
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

Add back kfd queues in start scheduling that originally been
removed on stop scheduling.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 36 +++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 648f40091aa3..82a2404e8a7e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -292,7 +292,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	return r;
 }
 
-static int remove_all_queues_mes(struct device_queue_manager *dqm)
+static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
 {
 	struct device_process_node *cur;
 	struct device *dev = dqm->dev->adev->dev;
@@ -319,6 +319,33 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
+{
+	struct device_process_node *cur;
+	struct device *dev = dqm->dev->adev->dev;
+	struct qcm_process_device *qpd;
+	struct queue *q;
+	int retval = 0;
+
+	list_for_each_entry(cur, &dqm->queues, list) {
+		qpd = cur->qpd;
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			if (q->properties.is_active) {
+				retval = add_queue_mes(dqm, q, qpd);
+				if (retval) {
+					dev_err(dev, "%s: Failed to add queue %d for dev %d",
+						__func__,
+						q->properties.queue_id,
+						dqm->dev->id);
+					return retval;
+				}
+			}
+		}
+	}
+
+	return retval;
+}
+
 static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
@@ -1742,7 +1769,7 @@ static int halt_cpsch(struct device_queue_manager *dqm)
 						 KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
 				USE_DEFAULT_GRACE_PERIOD, false);
 		else
-			ret = remove_all_queues_mes(dqm);
+			ret = remove_all_kfd_queues_mes(dqm);
 	}
 	dqm->sched_halt = true;
 	dqm_unlock(dqm);
@@ -1768,6 +1795,9 @@ static int unhalt_cpsch(struct device_queue_manager *dqm)
 		ret = execute_queues_cpsch(dqm,
 					   KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
 			0, USE_DEFAULT_GRACE_PERIOD);
+	else
+		ret = add_all_kfd_queues_mes(dqm);
+
 	dqm_unlock(dqm);
 
 	return ret;
@@ -1867,7 +1897,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
 		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
 	else
-		remove_all_queues_mes(dqm);
+		remove_all_kfd_queues_mes(dqm);
 
 	dqm->sched_running = false;
 
-- 
2.34.1

