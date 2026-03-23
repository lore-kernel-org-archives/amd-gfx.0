Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2598BEC01A4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 09:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB38F10E3D1;
	Mon, 23 Mar 2026 09:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wUwxIEKZ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EA3F10E3D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 09:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeN8rkx3ibBnMH2mGo0edKOfPfSPqcoeC4PuV/NeafUMwO6d5NyzGbSjfn5DFLhLCCQPCmAi2O9BZe7CmMoQDmGdYsBAXvk2Db2G9+5J0KnnyZ2Qg+kBEbiKrNSbir5mW6WPQJPMwQKC71y7I8KK5Yk4kVAJNON0luCs59aZfzVxCaKpe99w8kUN4gjdTzUvO3qSYeAvWyqJt0jormdo2VUv1jsYXSZDyizEGtwQxIhOsDU5PdEj31XuU7CfsezYhAQXKpOQuP+E+sSuDvT8P5rDcDBbgVmOnzJjoZIMQRgQfR3UI711bJyWOv4n42uGWP3QFopuASEsGV/Ebsq+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77sl7K1+ZHbl33qkBs8QQvTYbPKCgyrWXEqEJzRMuVI=;
 b=meZluGiof/lC8KyUE2qJXdjANtuQS2Sv2T6RgA2vypcVYu5cOI6RS3bzR9lOsUMyygSNJ9tPQxcdCPRkvQq6y0mr8Jxq7cnW4CC1GT+2B4AN2qOZ0P2izfpA9eJyKXjSc7BfgtTKPoKBr69X0A6+lg0zMBDakaKnHuLuOC05FuJfaMh02/ibjWIZni7edXVBXKJ7AQ92vrmkRttglUESl29lyU+MlEbDNAUYwcWzuAkNEHnBb3kJrrvCrxfRRHuHnmyRbI51Qj7I7k1D8jIhS0gYsb2IGFtK1e/Tj/EfFYVPq6wV6Mh8RjOehjtJFQK2/Gr9U7jPgJQMTAmaAaxajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77sl7K1+ZHbl33qkBs8QQvTYbPKCgyrWXEqEJzRMuVI=;
 b=wUwxIEKZ0luDBr8KvjJv8XfLu7ZET51T4cFl4NxtkkuGnjm0Hs8SHp0qqkeyIjs56yZtzxPqhSSBR3Q6aBY1pTtyE8OFbvkJxHgFDLb0fdsthp4+B3hQEmeWVcrzpaV1j56pZQ8DStZ1bfnHrtJEGfLwvZoqAO/KcjEKvYnzDNA=
Received: from SA9PR13CA0097.namprd13.prod.outlook.com (2603:10b6:806:24::12)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 09:00:15 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::4f) by SA9PR13CA0097.outlook.office365.com
 (2603:10b6:806:24::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.33 via Frontend Transport; Mon,
 23 Mar 2026 08:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 09:00:14 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 04:00:11 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amdkfd: Fix NULL pointer check order in
 kfd_ioctl_create_process
Date: Mon, 23 Mar 2026 14:29:53 +0530
Message-ID: <20260323085953.2047082-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 0135fc0a-605f-48a3-052f-08de88ba9903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1qKhnigqu5VRvQqUs9wcy7XzSo0KhwXkkJWWwck5cOOJcidde0H3KvKhlUNqjV0MOwC7CNjvGDkftTPczj3JBAbwrVahQ4Vo8XaBaCTDhoFGtzBo+RubRbjHOOubgKAHQmOl8NyE+H+vBB0wb8ktBGXsf50ub6p7M5in8sAsqTaevyp0XbOqh1o0k2pM58IwUjtYSIbYAH4FaO5IeP0pImIVxttTcJq7+UXl3WLdWz3+Kf2ue4CFtu/Vuw8Cj/wW0JMz8nyUkvA8H0CHkY4LtywyzfOJW5TJBIGXpoKnYAlo3efb43zBhl/mvnLQiIsqXMAT8KsWMWcAs72GmxQGm4gpEs2OSX2pCzPncC/Fh90hUJnbZIc3nSm5rqoNbVnhx0NxAdTWBAvoHCXS3kCaiOyKK11Pzl2NUsW2f8/4js3KMSc0jBh1q+GgIS9MgPZA/qzeoyRITSYdRE4nE/N+/QZOiFNKYWc8aEUKkBvYrXpqKUZStTyayogI9/Lti86ZFeAUBlLvpIUKI269lUOU9TReC0ry2aIvpUvfjn1IV8htKEVRq3ewoH3CtmmVeNckffKZTsASgkcGmlWnw19V5996Oj4uPUmbbzRI7xMSH3ndlsnXNejglPdHCRYsc0Cx5EIiP1fc9d6BVncFL3JjFt3fpYxXT/sTGemKAoWA6Mvkwct+J2Zy5l6Cc+j/USJiKnq/oESvPPiPwWYR8OKoOyD0HKNYPfWHocuEkz0uuo1lX1JXaUsFnZBnNT/aNfMFmXrZ4zowlBusryt8ej7lXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X+5pKuYfXjvwxoLPjmKD81BU/VMxkDhkmAotG6JPXEdmrbmYr3Sg7EdzK4RV5dmMH5/FbVBuX+p7glryXFbh40JXZae3W/cl9468Gtj+5RQyk9BfkMDYhKmc9HTEfjh6u/SgaAXhQj6cYZvhS/WZOI+AQFTGqAH4oJP9oGcbMLD2wYrkUtOJDLtN5ImnogSd1ax9aQgAyNlL0EupXN1VkOkZzDpwuBEfGy+B659UA32oWMNAHq3QKHDmAIiL/5h5ZaobebpdDFIV12s3x6+4Dau+RtEi+hspbBmolp+qt22JJIQhP3ts9pfTGlUzggPS2HU7E+yEYnwGZRlZSZIBYBvtS4QLB5AAeMRpqEk/55uNIXeUD0C8SL0ahxzzbTPoAnpGiMQUBgBZYmWtUKnBMLnGhsPexC/YK7+LFUQJUcy5eejC7JDQzQnD8QrHWNpE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:00:14.4917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0135fc0a-605f-48a3-052f-08de88ba9903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889
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

In kfd_ioctl_create_process(), the pointer 'p' is used before checking
if it is NULL.

The code accesses p->context_id before validating 'p'. This can lead
to a possible NULL pointer dereference.

Move the NULL check before using 'p' so that the pointer is validated
before access.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:3177 kfd_ioctl_create_process() warn: variable dereferenced before check 'p' (see line 3174)

Fixes: cc6b66d661fd ("amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS")
Cc: Zhu Lingshan <lingshan.zhu@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 732ad1224a61..1db565442c48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3170,11 +3170,11 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
 	struct kfd_process *process;
 	int ret;
 
-	/* Each FD owns only one kfd_process */
-	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
+	if (!filep->private_data || !p)
 		return -EINVAL;
 
-	if (!filep->private_data || !p)
+	/* Each FD owns only one kfd_process */
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
 		return -EINVAL;
 
 	mutex_lock(&kfd_processes_mutex);
-- 
2.34.1

