Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5938C3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 18:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73DB010E2A4;
	Mon, 22 Jul 2024 18:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VJ3nB+SE";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F5310E2A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 18:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLANr8Ap6lL8Ie0Fc+pFuWyv692oWIafOzVXynjGhbnXdSc1GKCJCH9ZvjEwu0296edkMOmGliQLC/R8GXsOsXmVBdWpZ7WIoQa7LDPr17cl1Arw3CQ/aCodBS37MZtAgaPQLnvnXYL7jUKAElzT8MzTuJcsvBOvpYQy2Fspm1Ekejl03fUI8Ue6Kzy+/7QcdKVxV7aP75a/W6HqHdjhj0ki4jilxg2s+SOPoRaD2OP7GHViFt+vRIsCHzpLun1XJJmKWEdld7wayRrr5UNkNWu3tNpiUGy8CNVJD7km4VpgPMEifrG10PEQkUimw4zQRAgQrYXRQZxh19DNiyMhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBRMcpdC7hmOa7Ro02MvhQlzjRD4shgYqn/NdpBfCA8=;
 b=ZfgpagI2Cc8aBBfF5/XWWIGiw8TbjaAgu9HAh03N7IJp4ZELoOFwcx4SMyeiAsaVsACadAu5buCBYT55eWp+/Nw98rSYzuEZvL8IxEChcooyf+7caUK6l0WqvuZBiP/YuI84ZDiu2m9Q2FZFFMnCAeZ/B6leJpPqYxQQlaEDG51oFpApoOIjvcnHvvAYxNYZl8xBQ30PtUKuH+v6OVREpLPt0ORU7qE6A9s/fciev8AwZ/kCO9ypPYanRyV3muaVuoibaf6Sv3th87POCUlHcnKzm8hhRmOxXVYr4RDGomvV7uSzLxG/Jm/VE0xwtSw91PikyZgWFQ2GxBllpUciaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBRMcpdC7hmOa7Ro02MvhQlzjRD4shgYqn/NdpBfCA8=;
 b=VJ3nB+SEZ4FtmgdRBvaeY14Qf6WXhGzDYBjWwvZUUfbetk+4VuUs6D5YVw+dSkORzljk0xs5O4Tjr8E7wL3NSSBVBuYjDSnhbVfpwRCxD9wQMiEHcDMIaEe+PHB04AitB3DT97jq87OSbP6W/Diqwmv3VM/DQcFUWWxw8vbW48k=
Received: from SA1PR03CA0016.namprd03.prod.outlook.com (2603:10b6:806:2d3::18)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 18:57:20 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::db) by SA1PR03CA0016.outlook.office365.com
 (2603:10b6:806:2d3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Mon, 22 Jul 2024 18:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 18:57:20 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 13:57:19 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <Jonathan.Kim@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: fix debug watchpoints for logical devices
Date: Mon, 22 Jul 2024 14:57:12 -0400
Message-ID: <20240722185712.1046232-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d19e75e-42be-41ba-86fa-08dcaa801d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z35EatSZ9M7emRt1/kcy7eV719vHhDTq8RhB9tPibFzoeJA22qFkrHno8Sie?=
 =?us-ascii?Q?XFEpUcPY4v1MfB/iAxYaCVoUJok0RunnBx5cjR/P915KMHw5AE4sGi5pt4FG?=
 =?us-ascii?Q?+K+LQnwwdKU8swWdzkSEeWqtHkbImJYFJn9eZqVmt0xMLGvOteFhTZiQ5mUE?=
 =?us-ascii?Q?DYSvhrQ/N/yq6MrI9agtP+UcGrNW2A90J+xG0Ma7vyhZtnrRriUJiCTHomZv?=
 =?us-ascii?Q?pwWYFhgclXWO3TA49egar+79ZjDPXJClayUz9azJVWOR9yo1JA5mX/SM3Mlf?=
 =?us-ascii?Q?SvV/YBJP/RNqI5joShjOox20AX7RTD8L67B3RRO6rGjJ+BKMYX+s2RiCso7O?=
 =?us-ascii?Q?hHoqL1GBTcxbEMzdz8l/5aJqIF9U9EUBcWHrDu2Ys4I+qmooTl4l4wyojbr2?=
 =?us-ascii?Q?BMEZr3TjlY6vKxd+udDmHcc5454W4hscJ0nQm+xXgFd28pH/gjHDnpmFnfPK?=
 =?us-ascii?Q?nDXweuhYfcamSRzf1j/+P9wE62aScujvjEwTYEsSoGrgLl/gPpTwbN4UjeKy?=
 =?us-ascii?Q?6A46qv0yUjFdHqfWvw5NBhIvT1jiDF8Rj+3IjlupTyoJUxI0v/+YkHr2u0YA?=
 =?us-ascii?Q?N5qubxznxYRIzUX2+7zoY96tzj0SRFVM+OmN8mJSIaQK6KkZk7qcB9xhf9Ar?=
 =?us-ascii?Q?PW553Cwa3PH4Xu8SGvE8JItfVChNzkgtXcuTPvNmB2s1DwvuHrhRNaAFtb9n?=
 =?us-ascii?Q?OIhQoiammEerygp1AX1gCIsE0R7RrYkyBj6wAbR7oFNpoy3hYfpSOXazDCnh?=
 =?us-ascii?Q?SlfFwZ4h0piJ0e8vMspBswVO9brnd/Fk1BLlW+/iYFkk7L1Ak3zn4InSBgE+?=
 =?us-ascii?Q?SFhMvwisVhaBDCc2P1Rbt/vK0RJWE5KGiOWxcQt1gt0AKl3f+VZ3ZhaSgavY?=
 =?us-ascii?Q?m8opcfClAMu5mnMtGhJCJ12kA/HMO/c6msXeVLt0k3r/NIs5zoU3J6g/m2+8?=
 =?us-ascii?Q?OEBYRqtMONmCWZXHh5IiZdQZ7/xfeAmnx5Ty9dcLt0lXrRY/xqYhm2NhVxtk?=
 =?us-ascii?Q?qSJq+nmd2xbgtGSLLpzte6Ox4mhm/iltSnApsy/GX3SvHSLwEzEB9+Pe5axu?=
 =?us-ascii?Q?MDI/1R4J1aG58CmFpUKkU/IWvQYNuCo7WZtziYLgEdZ5qlH4I8EOTPxnceeD?=
 =?us-ascii?Q?0ciIBo3yt0dO4ay4uW3OGU+GOtCOOVjF3daVji3xeT53PTnMh6V9gGVs0fY3?=
 =?us-ascii?Q?v8DNaHcxPHxBCHJ3I0BR7lk5sCKXQiA06sjyr61my41QWZGgJiSOvKJIHJZ4?=
 =?us-ascii?Q?FLrMSBb6Nk5kVeLjOyk+mHg1u03PLHVzmgKKmN97Lr4SsyyQqrMBpDVK89cG?=
 =?us-ascii?Q?jDw+Pg6Ij2Xp59fpWRZLcGJA35vs51umhyDtvvtUVA5diUpZ4HETfIoFIADH?=
 =?us-ascii?Q?qapG2Dupos2mGGFkNPQuPrMpxl5jrj2T0NHzzvKaVu2ryfJfffqdXioYwws2?=
 =?us-ascii?Q?B1lt+FMxUv5AoS+vDyypbmqAFWxydqy8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 18:57:20.3404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d19e75e-42be-41ba-86fa-08dcaa801d51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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

The number of watchpoints should be set and constrained per logical
partition device, not by the socket device.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c  | 20 ++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_device.c |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 34a282540c7e..312dfa84f29f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -365,47 +365,47 @@ static int kfd_dbg_get_dev_watch_id(struct kfd_process_device *pdd, int *watch_i
 
 	*watch_id = KFD_DEBUGGER_INVALID_WATCH_POINT_ID;
 
-	spin_lock(&pdd->dev->kfd->watch_points_lock);
+	spin_lock(&pdd->dev->watch_points_lock);
 
 	for (i = 0; i < MAX_WATCH_ADDRESSES; i++) {
 		/* device watchpoint in use so skip */
-		if ((pdd->dev->kfd->alloc_watch_ids >> i) & 0x1)
+		if ((pdd->dev->alloc_watch_ids >> i) & 0x1)
 			continue;
 
 		pdd->alloc_watch_ids |= 0x1 << i;
-		pdd->dev->kfd->alloc_watch_ids |= 0x1 << i;
+		pdd->dev->alloc_watch_ids |= 0x1 << i;
 		*watch_id = i;
-		spin_unlock(&pdd->dev->kfd->watch_points_lock);
+		spin_unlock(&pdd->dev->watch_points_lock);
 		return 0;
 	}
 
-	spin_unlock(&pdd->dev->kfd->watch_points_lock);
+	spin_unlock(&pdd->dev->watch_points_lock);
 
 	return -ENOMEM;
 }
 
 static void kfd_dbg_clear_dev_watch_id(struct kfd_process_device *pdd, int watch_id)
 {
-	spin_lock(&pdd->dev->kfd->watch_points_lock);
+	spin_lock(&pdd->dev->watch_points_lock);
 
 	/* process owns device watch point so safe to clear */
 	if ((pdd->alloc_watch_ids >> watch_id) & 0x1) {
 		pdd->alloc_watch_ids &= ~(0x1 << watch_id);
-		pdd->dev->kfd->alloc_watch_ids &= ~(0x1 << watch_id);
+		pdd->dev->alloc_watch_ids &= ~(0x1 << watch_id);
 	}
 
-	spin_unlock(&pdd->dev->kfd->watch_points_lock);
+	spin_unlock(&pdd->dev->watch_points_lock);
 }
 
 static bool kfd_dbg_owns_dev_watch_id(struct kfd_process_device *pdd, int watch_id)
 {
 	bool owns_watch_id = false;
 
-	spin_lock(&pdd->dev->kfd->watch_points_lock);
+	spin_lock(&pdd->dev->watch_points_lock);
 	owns_watch_id = watch_id < MAX_WATCH_ADDRESSES &&
 			((pdd->alloc_watch_ids >> watch_id) & 0x1);
 
-	spin_unlock(&pdd->dev->kfd->watch_points_lock);
+	spin_unlock(&pdd->dev->watch_points_lock);
 
 	return owns_watch_id;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index f4d20adaa068..f91a9b6ce3fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -885,12 +885,12 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			goto node_init_error;
 		}
 		kfd->nodes[i] = node;
+
+		spin_lock_init(&kfd->nodes[i]->watch_points_lock);
 	}
 
 	svm_range_set_max_pages(kfd->adev);
 
-	spin_lock_init(&kfd->watch_points_lock);
-
 	kfd->init_complete = true;
 	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
 		 kfd->adev->pdev->device);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2b3ec92981e8..653e1f934107 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -310,6 +310,10 @@ struct kfd_node {
 	struct kfd_local_mem_info local_mem_info;
 
 	struct kfd_dev *kfd;
+
+	/* Track per device allocated watch points */
+	uint32_t alloc_watch_ids;
+	spinlock_t watch_points_lock;
 };
 
 struct kfd_dev {
@@ -362,10 +366,6 @@ struct kfd_dev {
 	struct kfd_node *nodes[MAX_KFD_NODES];
 	unsigned int num_nodes;
 
-	/* Track per device allocated watch points */
-	uint32_t alloc_watch_ids;
-	spinlock_t watch_points_lock;
-
 	/* Kernel doorbells for KFD device */
 	struct amdgpu_bo *doorbells;
 
-- 
2.34.1

