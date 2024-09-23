Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64329CF9C6F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 09:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B91510E194;
	Mon, 23 Sep 2024 09:13:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="szU3EWxE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C70D410E194
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Sep 2024 09:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2JHS/s9j9ADs5GW9qFJijNuVmU2KQyNYVemzV3s9RAxxpDdHGwNZU48U8zSmMU9uA8JrXscwbEL2hDsbzZJoPfsCtwTmyk7N40g2bPTACG7Df5VY6Cqk2BsnM57K8r9bLjFfIw7NdDVdRFbHmuumELvinEod6PaGb4Q4HzOyPCMlGrasZMRz0xtOhfMrcBFKo7c/mG0A2f9FTTMxI072Ld3EXLUsVC6toqcBSiVizzn7ic/8f7MUoqVx6oV/I62le5hPoo3ySJBHy+K1qzognK/O6LOK6XjUPe8oSnuonf4j+Pfwcm6fv5r4tLNJmN3H63VjcQl5c+/Ok9E/VT1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lplUe1mS2zVj/8Qvw152JuP+Xxr2rnSeebiWqJZpQ7o=;
 b=ge2LggtCQpvpg5edH4zoI1urzzharjAYDRqjVnPCmb35AdwKISYX9D18fF2q9rAhiaYtfeP+Icwcsxf/Yo48laGvOi6QlM332+g3FPamP90xKfjxF1fVwsYV/fvZigHJb/o6dAQbiN8vJwHsk+uceqxuGAHqeBfZn+rQiIup2iDxRDtiy2xkO9ew127pK8k5wwv0HmkdUPsy4NtvWbQGT2g3jmi0V69TQNArXwrijpFNSLLl+XSZ3gscFMDbwdN9MHTnGCiY2dcxcEKGfVcmLRydiwoBByhBn+z3j71w+/wCX0FEhFfNZnE3A9Tw1retoCXRcUfYjF67NiWBVgEjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lplUe1mS2zVj/8Qvw152JuP+Xxr2rnSeebiWqJZpQ7o=;
 b=szU3EWxEkH25Pe00DrR1MPNrkjt1ktq28l2ikePJ8Kzuc60u2BL9SRNBFfDMOZY0y9UThUu5KbwcTD6YK7RAmaDDIXtNPamqeEGqGqS/v2vg2UqZXWi4WlBpgAK8bHU2tHunkdp+SqzR1Ppy9PkpWwCAPYk8QDlVFLKiNFyxE3w=
Received: from MN2PR17CA0013.namprd17.prod.outlook.com (2603:10b6:208:15e::26)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 09:13:46 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:15e:cafe::ae) by MN2PR17CA0013.outlook.office365.com
 (2603:10b6:208:15e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Mon, 23 Sep 2024 09:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Mon, 23 Sep 2024 09:13:45 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 04:13:43 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdkfd: Remove an unused parameter in queue creation
Date: Mon, 23 Sep 2024 17:11:17 +0800
Message-ID: <20240923091117.13949-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a5ecdc-f78f-4de4-46c2-08dcdbb006d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qFEZugZyIQEtpDEL6FCAVneV2R9P2MXwUCblUCOAYVrlSaUvMtobsAv8vfOy?=
 =?us-ascii?Q?d1I2g6Nn/Iw/llvdKbLmQDZXIdh+skjpMSYkgCs//FGmQHIrF+1OBpDX+8hq?=
 =?us-ascii?Q?Euh0RoFDCy3KR8hL464mC/yIivhyNY7hy4qWB7MBuJYV+Ifdd3XI89hfSO29?=
 =?us-ascii?Q?55XuUIz6wMiM4xFFNYso5a379AYnotDQ2118Hkg6iGyzSZbzTALK6uUhGIt3?=
 =?us-ascii?Q?QeJvPkDomIWPvyXKxCaYpmkajYBWI1bmqdAzbqQ3X/50REBMM8/RlHe37gza?=
 =?us-ascii?Q?/sjK2y0GXIJmUd90nX2vHvmLP84BFIXk1AKOMS+2kul5VHnh9HF93ejKQYwz?=
 =?us-ascii?Q?IuuaAHtwB8/U4Zq7AUmTDXMQGjYX0+MBEwP7I+cjUVUM5zitaqLRbAWduC7Y?=
 =?us-ascii?Q?UKgDD0DXp0Pknc1XoUzHLony83QH+tXgsw//VriOir7dL2K/eRoDXd43VgHj?=
 =?us-ascii?Q?XcnR4XHfa1GZvcZRkFljW4FYZKJGRskE90Xy4gStM3JTGdv6gFJ3+ronqG+d?=
 =?us-ascii?Q?eki7DABmyrF7vPH0n4GSJ8ABt+HbvQJOZx8zHAzGERoughJdCqs+tyIEsdk0?=
 =?us-ascii?Q?4rV9olSOdDO56ChyzA0feFBU0umR7tpAGJ0eNMu96ftIFR9pbE6xxp1JP0sd?=
 =?us-ascii?Q?acMv+5UvD9AXJ4qQ84zYYy2XVfDBwTK67rbtuF3KZVlGC7meVqrjkWNos1Jg?=
 =?us-ascii?Q?W+AnO4vqgcKv4ip8+gE7ec5fz6AQFzkwqYA+mJe0b/BvuzuJNo42zhdyh/DT?=
 =?us-ascii?Q?qUAhIRbo86IQRwlyXzVLSgpLVXqiwln7mBKkjtPIBOvaPE+nrefMoGYNh4/D?=
 =?us-ascii?Q?5v0+4kRbg1iUivrGE3PGyVE94+sZg4966oXbBLvuEZMtU2Z/Rf1tQfooJMah?=
 =?us-ascii?Q?O1wVdC5AC7Pa9i5iTmfHbqNeJ9fZUw42RXFDNCVl3k89UvNhxjFeKwRdVhmK?=
 =?us-ascii?Q?TvybDzZfi0iLxld7Tm18/tCoTcX3oKY2ZhHgEUlzroe5wdvYRyIkFGEE+n1A?=
 =?us-ascii?Q?c6A8F0THToCGBU4tv1wr74/eUqSv+CUwomTU614CHzt9RBJh+lUmeb0+Rvjq?=
 =?us-ascii?Q?deRyf9xpiM/3kVpe6VQAW5q4nYcR6vKU9pm6i5hHXRHu8O3tPMtUOc9hXtvj?=
 =?us-ascii?Q?l0HhAZLCKlt8jS+pYksqQV1xka5NzR54Yo3p5kR70AI+M13D5L4P8loa/GhG?=
 =?us-ascii?Q?vBf9Kkd8Uau0gNqyHla0jtgcaP/MgSDCaPvPjageM5xEqh5Z9OuIwZjtkloo?=
 =?us-ascii?Q?uIB+SDUY2mQN/DTeZ4xITbM3k0xjQmX3LGP//KeKL8zhpJgK2VYNPPtyLvc0?=
 =?us-ascii?Q?myAV625Dcwgba8ygEw6wEtolFyqy/Bs29t/EUmFgQepNyWqVg+gIMn1O8Uaj?=
 =?us-ascii?Q?ZMRWQ3vuND7GoeNu5UUawkjC1aQu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 09:13:45.4313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a5ecdc-f78f-4de4-46c2-08dcdbb006d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
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

struct file *f is unused in queue creation, remove it.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10 ++++------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 9044bdb38cf4..a1f191a5984b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -365,7 +365,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 			p->pasid,
 			dev->id);
 
-	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id,
+	err = pqm_create_queue(&p->pqm, dev, &q_properties, &queue_id,
 			NULL, NULL, NULL, &doorbell_offset_in_process);
 	if (err != 0)
 		goto err_create_queue;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d6530febabad..6a5bf88cc232 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1347,7 +1347,6 @@ int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p);
 void pqm_uninit(struct process_queue_manager *pqm);
 int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct kfd_node *dev,
-			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
 			    const struct kfd_criu_queue_priv_data *q_data,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 01b960b15274..c76db22a1000 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -235,7 +235,7 @@ void pqm_uninit(struct process_queue_manager *pqm)
 static int init_user_queue(struct process_queue_manager *pqm,
 				struct kfd_node *dev, struct queue **q,
 				struct queue_properties *q_properties,
-				struct file *f, unsigned int qid)
+				unsigned int qid)
 {
 	int retval;
 
@@ -300,7 +300,6 @@ static int init_user_queue(struct process_queue_manager *pqm,
 
 int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct kfd_node *dev,
-			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
 			    const struct kfd_criu_queue_priv_data *q_data,
@@ -374,7 +373,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		 * allocate_sdma_queue() in create_queue() has the
 		 * corresponding check logic.
 		 */
-		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
+		retval = init_user_queue(pqm, dev, &q, properties, *qid);
 		if (retval != 0)
 			goto err_create_queue;
 		pqn->q = q;
@@ -395,7 +394,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		}
 
-		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
+		retval = init_user_queue(pqm, dev, &q, properties, *qid);
 		if (retval != 0)
 			goto err_create_queue;
 		pqn->q = q;
@@ -1029,8 +1028,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
-	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack,
-				NULL);
+	ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
 		goto exit;
-- 
2.25.1

