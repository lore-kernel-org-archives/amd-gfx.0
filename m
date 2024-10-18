Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FA9D30011
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 15:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE3010E946;
	Fri, 18 Oct 2024 15:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ypHykgli";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A248D10E944
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 15:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKhY3wk+QRq96QsAdYDbBKAxJ/Z57btety/Oz8sEO0JLlVy0D2V8PYRjsz96glezH4NX6Jz6xg18J0KjotCDI5L/ZzeTS5D5m+ASKrlFWPUd+uGyEJhzFDRJ37sbfSRffvdb+T+keBbsCdES7X/z7QvBumWZh5yGPATif22y/j0iaImXApnMrsdckR7pILekoJ8egSKfPfVki0nhLDfX/8LuoZjsiVmEMn/sPnKG6IGC0krSUovyBP36hWmxHovk+rhluNwNdGe3bgKOnTK783FsUs0RqrpnQgmR0oC/pLDMtkDzH+dYntsHvEaAL318nmh7+FFnAx6j6x2lHV67fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxYR4l6N6pT1FA2EUqwXvBJDoee3XU9NbWmqDApSh7w=;
 b=bOeCldO2uxl3+7URXtrxpKKGfAy9XsLh0kxnTO4loj3pdK529nbl4QgYq197rIR9nBCe2TL1CEwvLFCyuubK0BIrrRJ+6+rg1AFgyKqfxiuLCEGgsRd1KHvtWbq+GuQsycGJVowszsj9x3Isk01zLtXe3Ke//cQ3a4rnondhTqXJBGJlzFPIIRz1dx2Up8a5os0mYpiaMkQM+Jq0dJSmwMQdOn8xe0+XGL8164OUJ4VzVCE93FpME0iGAFdMwhROR0MZrpYy/fNmPKZ9Y274auUMgQu9x70KMQZZuGVJ4UmgYSIpUBzIxznPLxStUTRqKe6p/MsWGe5GULRMEl4SLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxYR4l6N6pT1FA2EUqwXvBJDoee3XU9NbWmqDApSh7w=;
 b=ypHykgli/OOjNheQ9FuXeW8ock3NwAXq8M6dlhHJMZruYeQB5IP9ECl4U5fBYdYfXWkwe/bk4kDau74ooUoK15FQdkNXP0WhMSrWmGeV/zRBGWZW7v/wO9h6qRt/Jj292DFMC8BxCANl8QMgNJUgb5Wsyv3xjIG8LGIeTzpomYA=
Received: from CH0PR03CA0430.namprd03.prod.outlook.com (2603:10b6:610:10e::15)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 18 Oct
 2024 15:10:20 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::d8) by CH0PR03CA0430.outlook.office365.com
 (2603:10b6:610:10e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 15:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 15:10:19 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 10:10:18 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH] drm/amd/amdkfd: add/remove kfd queues on start/stop KFD
 scheduling
Date: Fri, 18 Oct 2024 11:10:05 -0400
Message-ID: <20241018151005.743103-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2a9f66-2edc-459a-c14d-08dcef86fb34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WF5ojYX0UWotnCNfXUgMn2FTkWRSCTImv7yfnQk5pRD7+LV5tuak2lrAOqLA?=
 =?us-ascii?Q?TvpLSg9kWjlUxfAje0wXihjt5321xTkl23ScLKawT/mziqHtSUttVlw4SAq+?=
 =?us-ascii?Q?Exjbb6i/de6DWJHP6bQOrYngXsSVD9fTOyrGYlJfRsg1ldtcV9iiZZxMTZdP?=
 =?us-ascii?Q?2a9qC0BszH8iUMRvosIbsMndJ5RU9Q1W3IFFbARDIIn6/Z9GC7e/u5bXLkj2?=
 =?us-ascii?Q?QY4JlI9Sf/owHTwxlnG5aBhlMRcvBw3hH29vrrevp/bsvkNKTuK11j79nFaO?=
 =?us-ascii?Q?n3S3sL8i6BU4bgkHlq1LpJx//14BWq8/Ct2JA5nKmWOvwwDqRUyX2WTQkgqa?=
 =?us-ascii?Q?K1fMYenmZJqI354r2gxSNWEtNzBGEKSw73xzc0+TDx2G5ff/Jxj6mk3SXaxV?=
 =?us-ascii?Q?fNQBQM5SqTuYI8nmGk37VrRoDNbtKkM+CCB7hVB+jUKP7n8KNbyuXIBjFcLw?=
 =?us-ascii?Q?DQxnuv4PFDgHITrnwLAVT35NnVftZ3fR3+WscTJzlnqEkSMU+1/pepxEBPd+?=
 =?us-ascii?Q?cXIwRYgj6/uf1Lq3/cHZj5dNcDCvA5YuRGvxpP0jDbY217rBOaYKTcrsvzuU?=
 =?us-ascii?Q?fu3JibJHfRWOYxDHUDwO25Cgml7VWam3qHK+1i/OsTgr9WKTBdJt6E2VqtKz?=
 =?us-ascii?Q?Z/a2UdXWHnaS/r1emuyT7D0KwUdbHsCXSlhmgSZxlwIkrHQ6qg18nRIvrQzD?=
 =?us-ascii?Q?9ro2IeKZK0wcx78M7YpxNP+GKqW5kYiHAPggiWuCgD2pVQbfxeFJb7KmTKEw?=
 =?us-ascii?Q?PVwx42DO7oWZVkLDlSSNmCHEh7YzT3lHFrHpmvRGc/JJIdhuEJ4Pi5N+5ea4?=
 =?us-ascii?Q?yFXX9/VBkeWCXg5OQ4QKnViwm93/L8lC1gHJJeio17UdfEK4bvugliIjSZbS?=
 =?us-ascii?Q?YrUhkzD7G3p/m1Ag/+ltG8jiuBJX9iWHtJo+DN4ejpiPc1Qg5TrfQOOOO2dC?=
 =?us-ascii?Q?HU/wdiDC5mJAX/uKMwoQ4eBIukJpSlqH4efmW9eyJ2EIcB80vyw8PdtC+kov?=
 =?us-ascii?Q?wMuSMsjxe8xw/M2saBD1ldVwa4nfO1jpYwtxqo54FfR61igghWeYAN8JNbj4?=
 =?us-ascii?Q?lA0JgkD29QlP17BBsWw7JapxqKf/66em12xkiYKgTWEMMd7Gmt8CmynNT4Rh?=
 =?us-ascii?Q?CNQFqw/jL88eLGFC2zq8OKyFORJ4tKIZajUaRLJ6HMeuUTx/y7EZugPymj4J?=
 =?us-ascii?Q?BfRoMLdWdxIkRqw0wYqSf2oPG4zjMAE87idqrnyXiTTFwAQimucanqcBcszt?=
 =?us-ascii?Q?6cbl+FuHpvx4aboiepyMLGR+ZbZIXKbwfnzC42KGar1fCDxkJO6FpVYF/fi7?=
 =?us-ascii?Q?g7qYzIy9OahJqugjCGjiIcXVPur8PYUynsFyPIzUz/Burff7etbgUcVQb1Ud?=
 =?us-ascii?Q?3wYUysE0WzbTtRN5yVLK0w7cWPcuLnmKLEDVxvM0K1XUWdFzmQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:10:19.7867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2a9f66-2edc-459a-c14d-08dcef86fb34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842
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

From: shaoyunl <shaoyun.liu@amd.com>

Add back kfd queues in start scheduling that originally been
removed on stop scheduling.

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 40 +++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b2b16a812e73..edfb9f98555f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -202,6 +202,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	int r, queue_type;
 	uint64_t wptr_addr_off;
 
+	if (!dqm->sched_running || dqm->sched_halt)
+		return 0;
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
@@ -270,6 +272,8 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	int r;
 	struct mes_remove_queue_input queue_input;
 
+	if (!dqm->sched_running || dqm->sched_halt)
+		return 0;
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
@@ -292,7 +296,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	return r;
 }
 
-static int remove_all_queues_mes(struct device_queue_manager *dqm)
+static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
 {
 	struct device_process_node *cur;
 	struct device *dev = dqm->dev->adev->dev;
@@ -319,6 +323,33 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
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
+			if (!q->properties.is_active)
+				continue;
+			retval = add_queue_mes(dqm, q, qpd);
+			if (retval) {
+				dev_err(dev, "%s: Failed to add queue %d for dev %d",
+					__func__,
+					q->properties.queue_id,
+					dqm->dev->id);
+				return retval;
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
@@ -1742,7 +1773,7 @@ static int halt_cpsch(struct device_queue_manager *dqm)
 						 KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
 				USE_DEFAULT_GRACE_PERIOD, false);
 		else
-			ret = remove_all_queues_mes(dqm);
+			ret = remove_all_kfd_queues_mes(dqm);
 	}
 	dqm->sched_halt = true;
 	dqm_unlock(dqm);
@@ -1768,6 +1799,9 @@ static int unhalt_cpsch(struct device_queue_manager *dqm)
 		ret = execute_queues_cpsch(dqm,
 					   KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
 			0, USE_DEFAULT_GRACE_PERIOD);
+	else
+		ret = add_all_kfd_queues_mes(dqm);
+
 	dqm_unlock(dqm);
 
 	return ret;
@@ -1867,7 +1901,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
 		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
 	else
-		remove_all_queues_mes(dqm);
+		remove_all_kfd_queues_mes(dqm);
 
 	dqm->sched_running = false;
 
-- 
2.34.1

