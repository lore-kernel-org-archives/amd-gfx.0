Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FA9D2F7DD
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 01:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF64D10E1BB;
	Thu, 17 Oct 2024 01:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0gaN87Cn";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E377910E1BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 01:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6vNI3ai/JXlc84a1pSwbmu9B+5GxREd8tbAku+D5GoLUjU6tObXfK9pVtdc7sV/D++9FKWiYtlemhHGJZ0W8EJP8pjmhgu2HFhQtzd6Z5CC1LlzVDj2shFtIR6QrqTblSAYT9s5QHT826suKoLDYG3b/9NoFWQZbtCBHWu93tMkFCkh1R2QBIfTiWDb9i8otCs/Gt6rM3qTbdBrH0Th0y5odFnUO9NDlAHLWAFC5uIpxjWIjNv03VhnLv/hCq4rMod7UE84OoJTGODgtiSXheALAj3xDSrGoXMslmF0zFkXc4924lBfkJmzNen1sQYno1xtZuROdIAsM9cgfN5umg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyElfCxQ+IsiQuRvmlFf41ytll4CHTqyOLgNe4bLNkU=;
 b=UgbJiiXF4eDvEDJJ9tiZlLxvhxXrh1L5xIiCeowtZnREm6X0AaUhhYfir73TmkQ2HMnLG9zOw5T3ZMaYi3OCYQA5xgBHTjNmpIVcwcUCd/C2VO1diOm2qFFK8RIDAfkUsA9ZstjEDJJbG6dXZ/P7kUHY7w22tZ3lWmo1NRmZS7R8yyLXhQE4Hwj8Z3wRhBKOhPiYUb+D6/jJNubirbSxUIhEtUmQ+tDP8FSu3/BJoxQdJ/wrXihxZleEhR0SP4+SPR0Hh9xMR+7aINOM4tHtdxg3726WnmgCfTz9tgj3/+T1Owbhlux23UGJQLGvN0euhEY6SvmhoWhz84QSN/D5tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyElfCxQ+IsiQuRvmlFf41ytll4CHTqyOLgNe4bLNkU=;
 b=0gaN87CnRZgIzvjrl8mLKQ42DQ0fM15Cn9NLQvgcoH9HeTbV+9XnSo+kWB/l2DnLH839NknJlejHKNyvwMBoJbYhcU0BosWlJOzSxXf4L/K3FvAUmkO4YcoaTyjgVp+gcQNV8yN0oISP+lzlhCXAv3b2RHjUzH981ZbgLPBaZjc=
Received: from IA1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::10)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 01:45:04 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:464:cafe::7d) by IA1P220CA0016.outlook.office365.com
 (2603:10b6:208:464::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Thu, 17 Oct 2024 01:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 01:45:03 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 20:45:03 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/amdkfd: add/remove kfd queues through on stop/start
 KFD scheduling
Date: Wed, 16 Oct 2024 21:44:49 -0400
Message-ID: <20241017014449.643036-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c4810f-b763-4005-3f23-08dcee4d522b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l/kxUZlWI/1agX9a0pVCGiNxPeuDKLJb8w1cHeqZMWqs+ei38Yc8tSJBdqeM?=
 =?us-ascii?Q?/Z4K58dJ6uxzFM1CN5dV1fu1uMejMekC0rtpwFDK7oKENvr3Ax+9hTWGPehd?=
 =?us-ascii?Q?l0uDEPu+9Ro9EsHeNTa7eJk4TUleeZ0EBsxuZpprDLRRLWyQr7cRUa1V8F4C?=
 =?us-ascii?Q?EAu2+vq9LEB5ubo2lbXncCRvju2pIL29B335J0RsdYem0b3Bu96ODnj3Sai5?=
 =?us-ascii?Q?R9mDfT07znYM4VffWGKZXCujq5Fy4Cj6TMx59k9QmaezHdDPqqpXbU/WIApm?=
 =?us-ascii?Q?uww2sdpqxBLDD0HBadUHgLMgc9kvLLR4UKJq6oMQlhu6S5GHdKVxkY3z8lmV?=
 =?us-ascii?Q?46VY9KUIHSbR5oT38ZuaNH2tHalDAGyd8xE5FlXYZgYtspj7YewiHUqXcN1Z?=
 =?us-ascii?Q?D+7eVHPOs0lcTqA7/2ZEWY55pe9ovOBDzTMjn9HZV1sx9jh7Y+DZ2qNKZFYn?=
 =?us-ascii?Q?BR21sZp/m7VCm4hN7ZpPFXdxMuAGiqTNfNyTPT8pZ0h+MBmdy4xnUIZkGSq5?=
 =?us-ascii?Q?p8oSZ8vjtxXBlddYJPYAUTomNwxapc2sm+anmgKrv7U/fiex5hb+/pyfRi+W?=
 =?us-ascii?Q?TIJ3xUqctWxolTL+p35oNPOebvGdl4Glhof/8Cbz2PPa6+C7krEMKEqUs5hB?=
 =?us-ascii?Q?BuoEJhq2+MH/33deJ5Y/q3pJk/D4ABl9x0Zyhj3A2aFzdQxW8XlEhxe6kqok?=
 =?us-ascii?Q?0o8ebVmtZ/LVK8Y9Y+LLcH1B2xZJZmqy7YZYxhJ3XmrKyVAZBBNh96M6Gave?=
 =?us-ascii?Q?DiWcLmFv3TbEchcaeWytQG288wrg0/DXlv26HGa9FrVqPJkLUp66t3EVjKgp?=
 =?us-ascii?Q?i1xKlVRB2ic7+PZ+u5B9JMDEb5E0CJx0qQ9+IhymNyWE+hDpmak9RS+4xz3n?=
 =?us-ascii?Q?O7SaiA5lJfwWfih/Rr34ivixNG+e06093gkC+iY2jU7MgxKkYWxizCZAMuD2?=
 =?us-ascii?Q?9/pKxg7bjps25jYNCHfqyrCTNnho4ELslYyCS9mKUO/34ZnCDip+smIuC9/4?=
 =?us-ascii?Q?1gm/jUANxWfN87nKrVH7uMFPMHxXYcxbkBtTdWuaal7ttS1Zu0sWOhklHFo5?=
 =?us-ascii?Q?Idj5icwC/encPt+an2MjjTRvonvtXO2aSNUqgv4EcDwBD3+w17KpaKfKchao?=
 =?us-ascii?Q?wZtwoCEEUVyxf/LhyZuOV3qadlx4koBgMFPxiVlK3dLQh9CrgSo1DQM6fItZ?=
 =?us-ascii?Q?oLFYl1uJalkBnrFQ5kmEaan7w09sq78SvND5AxEjEHC0iaBGrWxxBuxg1ptu?=
 =?us-ascii?Q?aWXCkg70vIP3AzUaadcNSvlmWONagh1ttQ1IxFl2hCjvev3ZPfymq8wi1T8C?=
 =?us-ascii?Q?MxA4+fLG6Nwh4Bw0PUHokdUl+sbvI5yTIgreb4NxQGSm1kQwsYFobc2Svd5b?=
 =?us-ascii?Q?6VL073rqQbih401ZJisDVy+Mbm8yritVMEoqMmmTAL87bB/ySmyecXcpE/cj?=
 =?us-ascii?Q?/IEcKefNRsM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 01:45:03.7444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c4810f-b763-4005-3f23-08dcee4d522b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 40 +++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b2b16a812e73..437ed0ae6e76 100644
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

