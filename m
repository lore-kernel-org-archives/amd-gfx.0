Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03174CEACEF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 18:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB3810E0EA;
	Mon, 17 Nov 2025 18:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WX8RGpRC";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FFC10E0EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 18:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pImWFZfRA549UsQVC4aiq++j8kOMdpdK68Kw5wQfZcrFy+bV7ImrGvvCLU3Wi6Z9ffXUqN9xZKXsjQq3Y41Ps900IL/kLqnHYaRCQJH3Ti5wYouHlCB7yV4Wme289EnY4FdtzM7Y1mHDl2MRloSycwSXcoe/31Zd+JssmhlPTkLtvEaW2jqABpG6WZQxAYOU69LufDmo2eC0vSKO/lyVuQVAwfoAbC9qG4ox9LhAO5C3vQagZMoMZoKWj2VxRnZAukcPNlq9JOkKsTqfl/IDq8OZ9YnRi9rm7taU+gEZdfgIWp3n0xNNQfkf5po/D/0aQebM+F9QENaUmhPN9u30Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lbr917dzuQ7D/OTK7mV7ABHY5J38+RuO/vg4Nr4KeEA=;
 b=EK9u7n5YqoCojKXHVpbva7in2ANfn4GOA27nXnQFvx19X7+C/KxLMqvJ4L0YSZdH7Tms+rNxvSICCg6dw6RND0P9p1Wc+hoYUgwBYmo+NT38ytFXiHFKk2f3vUjklrLkvDEV6vrhpjTEJNxlFy5vKQFOWhywdR24z7BCXH0M+ksy7nXNwwiQPhYfogIsYMHtQ3+vAEi710CXl5Xrrj0vb5NJ/14ljBB9NVhPiqn+5y7ZYNEW3K1WuxAJ3fCZU0vzFb+mFglSZORIb8+7gSAv5xyvIfDdflBXN+sn7yv5YGGffLbb5w7DJQGvm1Z6//qNtf4F4Fum3Wv3P2RVo/RkeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lbr917dzuQ7D/OTK7mV7ABHY5J38+RuO/vg4Nr4KeEA=;
 b=WX8RGpRCjpaSM02LnCVJoRFz8GLr5ljdl9jZrTUqqQ9viq9iYJ26vNAVBoomHebmIlCOlVMH9LUD5FDKxcGwVK0lUgbB8qPZv+cJzmVdwtcZ+x+fSY1I9mJjdKCM/Gp5RH8BnWHp38q0lXKP5NTo63GbJfsl2KaHbq1v+XUA6G8=
Received: from BL0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:91::24)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 18:14:23 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::a2) by BL0PR05CA0014.outlook.office365.com
 (2603:10b6:208:91::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Mon,
 17 Nov 2025 18:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 18:14:22 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 17 Nov 2025 10:14:22 -0800
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH v2] drm/amdkfd: FORWARD NULL
Date: Mon, 17 Nov 2025 13:14:02 -0500
Message-ID: <20251117181402.1908666-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: a77e72c4-9243-4bc8-fdb1-08de2605227b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OVfKsTuip4Uo2Gy6eSB5WQWxxRTxEiO3d2UtDrWzYYSkiTO4Jv/p7KOxdRkK?=
 =?us-ascii?Q?c/3ZyULfiEdM1WXByIpHRMf9E5QW8YY5AdovKe0VludyTCIDM+hCMcsjvhLi?=
 =?us-ascii?Q?ZwWuqNWL1G06REQidEm9qb8Wg5kHPErsfDnEqkjmJiNflN3h2ImmTCjuZIgV?=
 =?us-ascii?Q?x9lqsdFHQ4IHkiHHVthMt7ET70ZnqYhez75wQUG2YC7x3T/c/pegaA8BkiwE?=
 =?us-ascii?Q?JcQRbcQY892YuifnPoGQF6YgMH32D/ICoZcO1TOrNiKFagun0RZybXzRfv3p?=
 =?us-ascii?Q?Zu/euSTmjAJZcS6jvlRD+xmqtZHtA2XUx05mWrmFhovjqtrxtyzyLfxFFT1y?=
 =?us-ascii?Q?EctKf2HtksB7F+RduzjLlyGzfumaW8sA61wsMAKNqmkhsrb5+OXveYpFM+Gm?=
 =?us-ascii?Q?J9UB8T/EIyuHpxFNlWNMyDsdqNxMfuxypEY/VB8vMVjTI7hmFRr607LFCP3k?=
 =?us-ascii?Q?V+gxnTE50MQwQqff8Yqhm8pRYMWdA3a1OrugxTAm9RU9OPciCfMGMw+AM8+S?=
 =?us-ascii?Q?JwreVo3zgIFd2QsDE3WneEr4YWahqvgFW6hyjma3lSgKc9mpmgJ0A3MRlVGH?=
 =?us-ascii?Q?x4w9AKr/L3In42d/ukJpcdG8L7ukNK5Mj8sh03VrRjWDUGcR9MANUn7QMPiP?=
 =?us-ascii?Q?Pl5oqYZ8Wp7CFZahevwUA4RuCXcIhoCJSWXxDu57NLdWd5fP29umr0FiOfzV?=
 =?us-ascii?Q?N3XqJcUuASCDmlFgCSVLw+3fK2bnhOprtk21M3zKLSiMBLv4M/EsPWcj7tIy?=
 =?us-ascii?Q?L0tLexXvPnarndZqAPfmMvYWuFhH6+IPGCUT4ElA4uD2/Ck9hrQWGq7E/PYk?=
 =?us-ascii?Q?g+ptdJ+wT9A+t8hl3CBmxAv/2aBlBhpUDemfQ5Eal3KE0+6hbXYBJ2NYgPuN?=
 =?us-ascii?Q?gGNhAK4owkJDB93GVGJ1jrkt758mwzPGnpaSL3idntbrAzn6s/tNsoU3pWYS?=
 =?us-ascii?Q?02xG4y/0GZA7KrUxUGz7FDYWV3j6Oxp9dDwnrTpAbt2WTe2jsaoSVzW9FQQy?=
 =?us-ascii?Q?4Mdy9IV5fwWVxjwNM1ZtL0d0FmUPYjI4u1BnDDDthxFB6Wy+PkUyYe+hKvKd?=
 =?us-ascii?Q?o5dFyOt7ZAjgct6HxP9KaVF0VBN3J1clrjRI2Odt2BsqG38gEZkKN6gc6GWv?=
 =?us-ascii?Q?C7AlxfRFXEmFMeigT562+ab6KtLu0fw7Wi5paQ0s+TL3v3ErkId/tieqJfnv?=
 =?us-ascii?Q?1wzZH6Gx4y0tOHa9SVzXlsO4icmfnvYpJnWqt1DFLx/UkqCTznN6kYjlyr6v?=
 =?us-ascii?Q?VL9yYQASjxwLlddzb5oqOJdDgeHynd2p7QLXElm34UJ75i7eg2kL7c5kWPeM?=
 =?us-ascii?Q?Nsjd2/Zk7vXXWCOmMgQDIcNnnWZmZhs8mINWL1M8VkHILOWPGGIICfUIDve+?=
 =?us-ascii?Q?2e2lMub/5y4tiJ+nzWasNeUejzbEcenc/XY6wRSbe1VqmUcMO4g+GZJvcNjJ?=
 =?us-ascii?Q?qYfX1Avdi47Ddvop/cEPDEDktjbRc9f5FJxvxRNvcg2PZefa1p/CB9LfE2Ys?=
 =?us-ascii?Q?ebn65kErhhb8eVuizVRL1nlKFcfwpr2CIZCl9fbGE1KsP+NAxCIY35hbN/o3?=
 =?us-ascii?Q?egysS3FiZ4YD3oU/5zQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 18:14:22.7997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77e72c4-9243-4bc8-fdb1-08de2605227b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
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

This patch fixes issues when the code moves forward with a potential
NULL pointer, without checking.

Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c            | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c           | 7 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 3 ---
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1ef758ac5076..73c5749d4243 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -105,7 +105,7 @@ static const char *amdkfd_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
 
-	return fence->timeline_name;
+	return fence ? fence->timeline_name : NULL;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 4a7180b46b71..b3ced2f2ea1e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2357,6 +2357,8 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	if (kdev->kfd->hive_id) {
 		for (nid = 0; nid < proximity_domain; ++nid) {
 			peer_dev = kfd_topology_device_by_proximity_domain_no_lock(nid);
+			if (!peer_dev)
+				return -ENODEV;
 			if (!peer_dev->gpu)
 				continue;
 			if (peer_dev->gpu->kfd->hive_id != kdev->kfd->hive_id)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ba99e0f258ae..11af0c1cddcd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -517,7 +517,10 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_topology_device *topo_dev =
-				kfd_topology_device_by_id(target->pdds[i]->dev->id);
+			kfd_topology_device_by_id(target->pdds[i]->dev->id);
+		if (!topo_dev)
+			return -EINVAL;
+
 		uint32_t caps = topo_dev->node_props.capability;
 
 		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
@@ -1071,6 +1074,8 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 	for (i = 0; i < tmp_num_devices; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 		struct kfd_topology_device *topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+		if (!topo_dev)
+			return -EINVAL;
 
 		device_info.gpu_id = pdd->dev->id;
 		device_info.exception_status = pdd->exception_status;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f5d173f1ca3b..888b1c24c2a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1685,9 +1685,6 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	struct kfd_node *dev;
 	int ret;
 
-	if (!drm_file)
-		return -EINVAL;
-
 	if (pdd->drm_priv)
 		return -EBUSY;
 
-- 
2.43.0

