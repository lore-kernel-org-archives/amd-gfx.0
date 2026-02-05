Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36CCE9126B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB0010E386;
	Thu,  5 Feb 2026 06:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yHUs2vaQ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A14C10E388
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krHjzJ/T0GrQ1NWxFgy2Bs6bmo7CjUPj70JRxArRAnZNf3q3SSKq+jAuc8ejzvb1cVAx+bByf19YDEvUYpb/NkOiPyhERqC6aUp3Ju1L3tVKl+1EJlf8hL5RCcxo3Ou/xOxgXW6qLvewrgujG8p+hJ/mU6BghOod5ZinKL3OBTYvywUC49CvGXhIALmpC7TKY9/3wmdFdgB/+G4+TFvhRs7dukplpjX6aVXj3ULqDL6xjSLRvG7wd+2vlk/rALleDbRsrDJjvq5o3PpkZoN21lbZuGbT/4qI0Bp55J2CS7ZUsclrXKPDnCez+0OjmYEaAuAJFNfzoLutNI3oBXah0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ4xAbvU9xdD5WY+fVsl4HZC43lTEa9G/cBTHhfvejw=;
 b=Oz7ygq+LRHbmZK5Y6/haTmc1Dl9df5DPL5W/32oY9ELQkmkUeLiMKkEoke+YcqS3AU0UJY5CSRYHgWQ+NzSxET8vQpBRcYYiQdGGSGf32m5DRVimFQQtmhQ3QX0pQiND0p3NWZPhgv0ajJ+gY4Wr5xVM4n+4DwWmiZj+l4kUtMJ17re7MEWf3jgXTYnIGCJaoE5RZXH6XtNlppLYrU/2oIhXII3juvCxJAF/avytoJjdJXWyahAAPRoXEPRrwM5sSD8Lb7/he9sMoo6ktEYrkA5f/ztWYyCmZvJHl0edOGHkPJbBCcbOAB2YuT0NF1D+puVfphQBNG9jJCKaMe6d5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQ4xAbvU9xdD5WY+fVsl4HZC43lTEa9G/cBTHhfvejw=;
 b=yHUs2vaQNvtkI7whuz16YHFeoc4l5XQOKbryFRBjesodWffnHM78DE0YR/tRKzrSd/p3/qhBcxtt3QEmMDWXw9116juPbE/WoeZT8qLQzxdHC0EuER73ckEX5ktQitosPMQiHaInbGJQMH49lbrUA6SZqPDjweA9Yu/4dOxsYDs=
Received: from PH7P221CA0057.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::20)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 06:51:47 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::5f) by PH7P221CA0057.outlook.office365.com
 (2603:10b6:510:33c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 06:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:46 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:45 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 06/22] drm/amdkfd: enable PTL while kfd_process profiler
 release
Date: Thu, 5 Feb 2026 14:51:14 +0800
Message-ID: <20260205065130.654921-6-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 10985436-5190-4d9e-2dd0-08de648307f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4cLqZ/D+mbTpu53dWnXB+dkF9G21htE08LJ0PC+kt1BV1yM4QaSHtoX+LK0z?=
 =?us-ascii?Q?icPFu12g0Glwzxfms2q9KTz97IMQJ2Qa9zqcymEjY13JhtnlRhEPI8h0iKCq?=
 =?us-ascii?Q?aetz1Menv/UQp/YfIQy/Cgp8BM0k/GGdpdrNcb6g6t33im+gec6yD1abihWq?=
 =?us-ascii?Q?JW7/TWlsSxuSkH/9x40U7VWaCVd3mr9zSD6ct+EiZyhK9bN2fQ7FuUrwnTXc?=
 =?us-ascii?Q?bMnlIpdaDg4B1cvas6/zQpiNSuSzYifPjIi3oMmG6zO4vHqfBs19a63x7LdN?=
 =?us-ascii?Q?9GKYUfZtZL1AWfpCH7CHG045hASyWAzw6NZc9nkoZ5RbV95g6ODo4Av0uEyP?=
 =?us-ascii?Q?sJbXEez7TghKFeuWXfbgjaZIe2GNm43kqr1BFm12KNCIebrYTX9eUWfE3M8p?=
 =?us-ascii?Q?th+n305nIad5X0w+YesukU1B3se0IAenzLZhJbbijdWXxZjBCE0XxjUbfHsv?=
 =?us-ascii?Q?5e9f70wUZ2AqpaOryyNGHAiOzej5JdfHLCPKczoYIKi6GWD8k1LNY7pAD3b9?=
 =?us-ascii?Q?07UQPpfRq+D/4urcgojiPcmSXwRBCod+1OYYtFd0S6NdgMXreqcTOqvJ/slq?=
 =?us-ascii?Q?NPNRa+qtEqGhVRJYo+NN9zl+K3Ev1eBA4d3yiZnHhm2hBmqfNI76LsVEWYJC?=
 =?us-ascii?Q?/NbHl7beFJv5tr+zmqaru1xsUzLFOE2iiZbQIGHIZDJnQi+GQZltwVQNwUi7?=
 =?us-ascii?Q?jZKM5gA9CVv/gCCRuYOozGjEiPK8ioOFhORmRRvUu0hHi78Rl1ik+qTzRpsD?=
 =?us-ascii?Q?MBVzhEf80YT+35xlosf3bLY4HP6Y78wiBgEP755B4OOPQ1JtNVY2x4czmcDL?=
 =?us-ascii?Q?Y4L1qUKwN44Kqs2b+rpsC6TikNumtb2pDejhp7E7slxm13V3oWgeYyYEUqmt?=
 =?us-ascii?Q?5Ae2kKrwG2+a1OZ11S+3SIiKN4eZC14f/f9mZ4AEix96qHvwOvQ+CfsUrj/i?=
 =?us-ascii?Q?pxSqhiEG3h24PbVHKm1bcauKGeP8uhkyhh/+yMZ1UCMoeUZKSLUVB501754C?=
 =?us-ascii?Q?6gn9umT4XFNOXtaJIDQaXk2T/EdU8Mt4ZrD/NC3VwybQN7+dEI0JTigZJo39?=
 =?us-ascii?Q?qGlOAR6wXeQycG/RmaAsWj2ePzJRRHowLi9RlW9gHEyOrVK88++fEYUPkiX/?=
 =?us-ascii?Q?RuJsxzhOh/wLX4GPMdbQrQGmlvdsdEZ+ym9F+AucABfjoAwM5VXkrEUsP9aR?=
 =?us-ascii?Q?9OeCWkWrCTtYMTYaMRICF9v57SJ+8ao/i5SJQmVC04Y6o9cJqn/SrZsQ61nb?=
 =?us-ascii?Q?if5djBb6g0NQ2MILliVcB2WkINbAwo2WN7Td1DmRjXDmVwddKhowH5MSv4Er?=
 =?us-ascii?Q?/EwCXKHUBxd67BbgY+Vqee17xxnmo291wFo2rKYdHzmpZQ6enSvAckYPIxdW?=
 =?us-ascii?Q?i/ogstsDtCokZilof7BMiGZhFk8QBy7kyXk+fQVGbWM2RtEl6oC8JqAUnclw?=
 =?us-ascii?Q?rPxpbhtxJF+h6BAreorVMuhXbojz+dBqETHhRB8dkn1SZDAQjUbWenP/1Ef5?=
 =?us-ascii?Q?UK8S2aS3zasg9QKl0lwnhBpqrhq8Lbs9/ngu8TtwbzS8bXGvN7a1xydZperC?=
 =?us-ascii?Q?+3ZRADmE4c38GIS1foQ8Y8fkvZQV4iMbv69SC0gRSinxT353UvZtWP2a49uF?=
 =?us-ascii?Q?HGUCJLhT4BXtjTLqWv+/7DQQKT3DLPPos+4juiivqhhYmGVRs5INOPGXB8cl?=
 =?us-ascii?Q?w/Z7ng=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1zSIKPzd3MeYZK40bWvuzXvPaffOsL8ZU+aQnm1mctLJNmVzFxkKhMbXskIcDGHQy73BQ5G1z72+cDuoX508SoCMgMRJLxi5NWZacMZHRS4PN2Im8mJFSwxt8tTXdl+AjG+UJ0z130mtMETMz0OikAyhs0L8F47Yml0D/MN5sxFk4lINw+vRAWqnAvoFH+pyl7Yc5JbFqU5RGAP7gXC/76Wiq0TDMpiEnhyPRyapzLEXkGi9aywrrm6tVrDxwxejhrgsJikfQZ3t2PWCrCX2607MP6a5D8VKW7wdEqkq1WRdfkKCUZJis6s0T1EOaLtnWaggxypHeHXKkqpafRWlRny5J8Qlo4hE9y+/FFZ2P9wISRObC8R/moKa+d0aD+0dEs0kIgpl9nSxkZEz6A1DU7egL0ai/73lyKoAk6ZIE7B/2AV4Y9WLlX+VrW/Slx0M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:46.9123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10985436-5190-4d9e-2dd0-08de648307f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338
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

When the profiler is released it needs to enable PTL again to make sure
PTL state is restored to preivous state.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1e619eda8433..285219781939 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1764,7 +1764,7 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 }
 #endif
 
-static int kfd_ptl_control(struct kfd_process_device *pdd, bool enable)
+int kfd_ptl_control(struct kfd_process_device *pdd, bool enable)
 {
 	struct amdgpu_device *adev = pdd->dev->adev;
 	enum amdgpu_ptl_fmt pref_format1 = adev->psp.ptl_fmt1;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 8983065645fa..164f69924a3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1607,6 +1607,9 @@ static inline bool kfd_is_first_node(struct kfd_node *node)
 	return (node == node->kfd->nodes[0]);
 }
 
+/* PTL support */
+int kfd_ptl_control(struct kfd_process_device *pdd, bool enable);
+
 /* Debugfs */
 #if defined(CONFIG_DEBUG_FS)
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index deca19b478d0..5114ac4da5b9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1115,6 +1115,7 @@ static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_proce
 	mutex_lock(&pdd->dev->kfd->profiler_lock);
 	if (pdd->dev->kfd->profiler_process == p) {
 		pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
+		kfd_ptl_control(pdd, true);
 		pdd->dev->kfd->profiler_process = NULL;
 	}
 	mutex_unlock(&pdd->dev->kfd->profiler_lock);
-- 
2.34.1

