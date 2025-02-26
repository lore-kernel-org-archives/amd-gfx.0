Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6C6C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 17:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9A510E03C;
	Wed, 26 Feb 2025 17:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZCCRkGWe";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE4410E2DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 17:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVo77ftJRFjRgULVo85nqLhj2MNJZOhvMO9xPM8To91Ad1hgteC8+haJWIXBFNgxpZoQbkjuWB2gYwBUid+C1JfNjH0dYiND2+T/2+Mk1CBXfOYmSsytK8F9ZTEvlCMnXwXhA0GPyRpEdOAL+FV9H4ShVe4yLjXvtGYeD73kq5yJtcsUWrDskfEXfAt5xKUz1XMs76sNEWTAcjnxjIRWPGHbf8Wxi/8NkgI28xvXBbmsK3GzQiU8S2JBH18dCR9n41Vcy+M0XJ9/j/devcRQxp36XdE2YHhKFbyu4Hx6aiDgcKyuQtvH94dRDHTBFE02uR5F2nySiSIvGAj682c6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYqmhFVuMXv+mbLXBqSAfooLmKPnZO/l9TA2ep8ADX0=;
 b=aJnMHLaGF0GFMoRTD7jkjUW7fJCpurysR6lb5BG410EIvOzOBL3SMojN7Icl2ncpntCj+rrw/GBZQuSJwNToCQg+CkHcxqGW8WLR3H8Oy/ZBTaUA1pXWYhCN1VUQbigMgRy2XLDESR0/xGJVSRQZWLI5/CfVFgkdRKiMIDNCqHW+DNdP2C/2mfUJ0Eet47zLSEiIbwSph5tMsj7wWgY7BgSntQ54q7pJAIZVWBZH7oMW3UyPosV9cJJsQg4DSr+LxKiUvx72jvzi4S0GX18r+Glk/YAhFpCnqHC5LbW9YiLyTEbMhCBSMExLlEkJBqnIPxhBdn0QI5DnApgcjNDNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYqmhFVuMXv+mbLXBqSAfooLmKPnZO/l9TA2ep8ADX0=;
 b=ZCCRkGWeFcd7OLXQo0n8YQjRAdO6DC9+q6QntkSalQh7Ju/4yWa+mlLssM3on30HQtVFelZq2pu3fZ37qD5ZuLFCElgoH8QMAcF8NJ3upBapHnzge4sYbL5C3f9Bcwr92PXR6OeTibDwEDRtr3HKims89fqV+zF/1YpwBq/fM0I=
Received: from PH7PR17CA0061.namprd17.prod.outlook.com (2603:10b6:510:325::11)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Wed, 26 Feb
 2025 17:15:20 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:325:cafe::16) by PH7PR17CA0061.outlook.office365.com
 (2603:10b6:510:325::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 17:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Wed, 26 Feb 2025 17:15:19 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 11:15:15 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 4/5] drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
Date: Wed, 26 Feb 2025 12:14:20 -0500
Message-ID: <20250226171421.14436-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226171421.14436-1-Philip.Yang@amd.com>
References: <20250226171421.14436-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: e64a50de-193b-4a19-df33-08dd5689257b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kxa/4E+yFRDdlR7pGBgFHd+6tZwot9ZWG5QnWchhg1y/UA7jxX7Pvjcp6Hm4?=
 =?us-ascii?Q?hgucSbIqs5UPNgDwvjAQ7bg8yUkJ7FRBVXRAugLX3MJ8vLpg0s7Fu+3AjD70?=
 =?us-ascii?Q?q/gMEioyXXYbA/1+rxGvpZ/n9ThsgeUFXPajxlLb4TTEUuHFbJk1VEThqaDa?=
 =?us-ascii?Q?t5OJ8e8yO7cddi9cm649tW3xUYe+qwAYBCQHy5qb6XTvGvcypM+Jo9w9KUOC?=
 =?us-ascii?Q?DDkG5YM86QJiRPDLZWxWFKSY5s/CifKbHDcvDH1adH9S+zWhmoSopgclPicp?=
 =?us-ascii?Q?sxANMB+P6AVlP58kI804f7wzlZh8tfWrZU/gA9kbH/QtIe6Z9OM65EgSaym9?=
 =?us-ascii?Q?p6HGgOeq7bbYwJCgCoppQCVavr7LpV912jFvxvfxsaEMwaRn6GkP3flV5pT3?=
 =?us-ascii?Q?vy/yO56GAy+AsUVyc3UBmb1C/IkJPRCwpLrZAP7TBlDEnbX5F56njm3egJrx?=
 =?us-ascii?Q?wuN/A5fYaJbJK2rVMrlR+FJqJSL0LnKIr4yap5rhSRAAKG8WHO+9Lia+G+KJ?=
 =?us-ascii?Q?vL89IlOdqbtLRNAaV3dDG2ehDEwh2NjD/k3BCm59XdIwvILWwI78N/18iqSV?=
 =?us-ascii?Q?XbhHKIOjlBSd2+yff1+UTYE+NWqu6f7gmq35uBo3JswVtomqilQL+XxR+fFu?=
 =?us-ascii?Q?6dsuzX3cFsajE/mJPHoZyiX/ODLkcx0CwSs6b09h/yFqRIrJcJizLmn2cg86?=
 =?us-ascii?Q?ZVnCSNGjo3M47nnujEV1qRkGAuOyZMRrGQSAw+sHt62RmE8Z/aEy1IhX63Ae?=
 =?us-ascii?Q?4y5/jmc6bG0PiBiH1XSfVzwCLX5vgE19Je81Tm9WIKyzoqZsK5CJrZSJ1ues?=
 =?us-ascii?Q?CM7xf1DM7rwOyMDmJv8/vWJChcmZc3duF4DD9mt0jgUVbjX51pCAC9gG7juV?=
 =?us-ascii?Q?iXKSw9fEOipi2tlm5BNNgXx5qMDOQa38czZKVHbDgMFhfC16C/hu1sCz0PR5?=
 =?us-ascii?Q?8gea8KNADjAyzqB2qYnZZTH//P34gJPv1eEDyS6IC4l9vrxWYM2nIxEc1kO3?=
 =?us-ascii?Q?OM09/9QP+qu7H73OsKN5m2aEyd15//gxzSqMkLn4PPNiGqQTy+NwOqIQQKTE?=
 =?us-ascii?Q?T8u6/ReE1LI0vcJ8w0oy/Hk5twCpLqeDvXVjITC/tARsY/1++8shaTshQvHL?=
 =?us-ascii?Q?nfWvVNCUHRvn78tUfdd2Kv9ySyrOk96NVJ/Vi9yCj68/hymyYaVN7NXUydL7?=
 =?us-ascii?Q?Gqkq3F8n5eKLeweZMoJbqw9lHBoCYl9d/iKV4q/BV3HRJhsNjwDRzWmIGAPw?=
 =?us-ascii?Q?XHj39VIu4gA8UYOTANobZwSU0LMW6403lnrkubHHO5mOPR/4Ea7Xh7nZWaj7?=
 =?us-ascii?Q?a+oNVi8BdlniGFDyEhGWUHZsZ7mH4U1Wc0Frohz0DHEPqhy+ko9VM5JXelwk?=
 =?us-ascii?Q?kprwQBD4imuj4/DprdPJI9ATOLpQ/SFhHWGWIL83D7nPMuxX9uxH/R+MrueE?=
 =?us-ascii?Q?WgTR60zrJ84ucNJ7AXRthMkGDNME7Zp0pBfivj/A/4l6xolE8EwFyQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:15:19.4299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e64a50de-193b-4a19-df33-08dd5689257b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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

If GPU in reset, destroy_queue return -EIO, pqm_destroy_queue should
delete the queue from process_queue_list and free the resource.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 93647ee27325..662c595ce783 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -548,7 +548,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pdd->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 		kfd_procfs_del_queue(pqn->q);
-- 
2.47.1

