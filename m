Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A01D374B8
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 16:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2C0E10E176;
	Thu, 17 Oct 2024 16:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e0X6wOw2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D6F10E176
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 16:12:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3tjRY4XOpC1phvKAFlRUCxFgPrIaDa8Ttj16Z3OsGSdX390f+rrh9UnUPRAbrzO7xONpLcwz/C9TPewiJxsKDGystaFiVUL0hSGxttDYpthfVxeygrIMuv5M7EY11NHaSsrE2lkn9Gs7Wzylb5TOZcQwLB1F3LD1XeRETP4OsC4XptLCx6arbRs8DBvuVzbAODnTQj4TV5uSJN75OM3we5w3CKlCOmfzgjU3S8XUsHeIv77MGkk6xgu8z/mbi6/2sVE3MvcrN3vpTN3b4scTEFxG32Amxn/JwfsqntnrImXgGyavbgFqD/PAl8UkXMlOjshkVVy7eAh6yuYF46mFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/hdX+lo15kdWPGf11f1TfECzLBq2UzQ5Pf6jjbWq8Q=;
 b=EVQJFKRBkD3SB27lGEIN9DuL2RqFRW0Pq2QhEJtZmOBJCyIhNk/lUxJ7MHtP9anXEka4bS+Xbx0NHwujNqcDXRU09FQkq6UmCKu/0bB2qB+0dNBiXXkOLgY3CWDrfobLWu0evVd4kPht22ITTjhjdQlbN5S2RZBqZ6fMT022H8nqzJLSWU9bCJDfaXqvvDTgZXyB1N0Gxkucn305wiPu1uk+0Vt0zZwTMO5VCUjJtRGZweq5LRPUegNoT+nlhh1YyJ/99jA0sqxACWQJfCvoAr9NGSNGtkSLIlwGnDD9L8ojXSoCTS5BmweB4JeGzx93FYcLq06sRguBmE/G47CBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/hdX+lo15kdWPGf11f1TfECzLBq2UzQ5Pf6jjbWq8Q=;
 b=e0X6wOw2wUft/HuqjBAJ4OvAPuMrS5XEys0/HFiovP+vnisuGKO6Xmego5Kcw4qBt+Js7l8ih70J4p7O0Qbqk9+zOphlVAkTyBZ6YUXOcaF75xXZM4hNyIVPPi7U2xJr0oWg9ACXnZiCanCsdkTsxhX+HpOmWteen8c20WpY2IU=
Received: from CY5PR20CA0020.namprd20.prod.outlook.com (2603:10b6:930:3::20)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 16:12:30 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::1d) by CY5PR20CA0020.outlook.office365.com
 (2603:10b6:930:3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 16:12:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:12:29 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:12:28 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/amdkfd: add/remove kfd queues on start/stop KFD
 scheduling
Date: Thu, 17 Oct 2024 12:12:16 -0400
Message-ID: <20241017161216.739111-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: c7438bca-94f2-4364-3503-08dceec6801a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ng/IlXkciPY28knT+b8SLgly3njlSebajNGT0hhHrqDomvn8FDck+uNo4B6N?=
 =?us-ascii?Q?ddaONNdb3OHIGIKaRkCZaHfGQWTdx7Wa654yTJ2Pfn/FCHoSU9szFBA494cV?=
 =?us-ascii?Q?r4MA3ZBfA9PWRQa/JfrFFCM/UMdmWDpm1lIn53N3dYQrBGmPBp9XEpaA2ND7?=
 =?us-ascii?Q?YsEqRuTjNxgEuE0FkriudQBEhGUUEtQhQ5uNo+BVHEh8iiH5TeyaPs5pLPVq?=
 =?us-ascii?Q?hawxk9HuK92EUrMFZaNapc8ttxD3Q7C3j/IiDh4nUA14fY7ONjX6KYgIKX6Y?=
 =?us-ascii?Q?OZ6ekgJyOJ1A3ZwNMN9PlyHpyfQKJoQBcTbBSEri8d+p1pQk6ZsVkpfUwB05?=
 =?us-ascii?Q?F0zgV3qKIFuk3WTKiclLznmhPrb21AfuiYTP3CtLygmVEV8WPqT7ZOHSc70I?=
 =?us-ascii?Q?T3YWK4hxyFPo6O515aSSAICiRYR1N7+59j5Ls3czn1a9AGyF48qjSgoewXNw?=
 =?us-ascii?Q?OUl6Fc+GkZfGOsu14fQL1E6s3erSgobXAugWAqjVE1yztey//7gMHgz/gP7J?=
 =?us-ascii?Q?la/9yCPpcowB+eif/Fr5IjibiV7AL/ZGjkc4I5/2mjG4tmqj//tap08TTZ2M?=
 =?us-ascii?Q?ETGzOD2Hb9C/Dq5u9Gu/ZXhuIvZuFmwcqBD4V3K+yTZEBNfRrt8liNMahsxM?=
 =?us-ascii?Q?90D6xQdo2yhpFXRKGe7AT7KBgkQPckJIedI2bDF4HhBVtzoCEs+XParzGNzq?=
 =?us-ascii?Q?8FR5XIiXrTwjeuF82zDVM1bGlUBC2B7kVveVr6neIZanUzbxKx75bUleaZ6t?=
 =?us-ascii?Q?AvPaTqlUtBPvSe3FclVAlL5LpmrIJVcyRwSKaftzJROeCJtIv6TFYMqCiAXj?=
 =?us-ascii?Q?q+MTuz6hpeFKfBglYT2wD65OT+y+DTOcKXWZvEs3SZH5vSQZa9L38KxkMt1K?=
 =?us-ascii?Q?fEE0Uqtv5xes3yPvxBFtYjDdWiIt8r2McuUwCA214FM0EcYhQ8j0VrYJh2ur?=
 =?us-ascii?Q?0fGmLwUYZi/zBqPl1YCYOIdVWSIe544UgV5VuzDp1k9BAU5eStcsOE56+6jf?=
 =?us-ascii?Q?0TzcQ7/vrmCCjXV0Q/pjtZcKV39jez7D+M+9gdpFmA2kJj6xJbOhPKuX2s5G?=
 =?us-ascii?Q?9f5UvnQurKJncqtyya8LltFMLh2yzF9n8NBmY/M37DiUTgHXiz1jXGw+zKly?=
 =?us-ascii?Q?JfTBtygWJBJZvCHo+amr3dV+CALk1auRmuePTZE46aemuF4syVkjNapJrcqq?=
 =?us-ascii?Q?yyRGVAWW5lrsvyT07yUDQqDIRg20LqAdSI5/+FRCc9Uu7s8X/jP2EYTBRzNL?=
 =?us-ascii?Q?i/+uMqEg7O1YTvJtPYhAZ0dnz6y09VEuwTQbvMqsugeUzhads5fojYpoXN4P?=
 =?us-ascii?Q?H8dJny9CNMf7b9OJhT2j3fo2b03QOGKoWRPGWute550G2Vx/D82LhoFTBli3?=
 =?us-ascii?Q?KNMQ9XDq6MnaxTGxdhZt/+gbhJXUO+byol2wXu5DTHbi98872Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:12:29.8341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7438bca-94f2-4364-3503-08dceec6801a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444
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
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 40 +++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b2b16a812e73..542363b4712e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -204,6 +204,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
+	if (!dqm->sched_running || dqm->sched_halt)
+		return 0;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
 	queue_input.process_id = qpd->pqm->process->pasid;
@@ -272,6 +274,8 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
+	if (!dqm->sched_running || dqm->sched_halt)
+		return 0;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q->properties.doorbell_off;
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

