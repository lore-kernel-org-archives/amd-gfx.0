Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBBFCAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 08:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC68910E66A;
	Thu, 18 Sep 2025 08:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CzuT+7lZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012015.outbound.protection.outlook.com
 [40.107.200.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122A410E66A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 08:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZUcZHijVlbQ0mrqWo7yTzBeEm6qMD5/ptpfn9Mc8OOCVfB+YjCCMDvIBDShqfrVX4PHAmD+n0lH3oK2kXiRvEWYVMmHOWEIfuhyXZRbWiJXXo47EFYWBm3qYxVjQhP4uAzNhGh7e6nBG9AtLdlp2Q+LdoBVkT9v/UZ2r/AeFe4Y6ARhYDalvaVdvUHdMJrrAXgtzA8aKTL54+7xsGtWPiY0Lo7m/xN/y0JssYPYIv8Se54NFNVzfYEMLiOYuv8s60BNXlwyZEX3gQt63ZpoJGyYGixFwUc6wrBwzvE8WwHnTuv4Gxgerud0wzcfK9gtAW2eKIb6Ic1cUx8ULKXY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+kwl3SgsTK1vHXXRyDzrdAALhqbEmB0DwAC2IffV/s=;
 b=GDCqyQ3ZZO3pJYH6Xwe9Xp43jE0vF8Vjk8Ujx3H+kwL4QfgkpWJm0u7mnxNC0SOcy3/fv6otAyRgefW6nuIlHr5arAtCNZgsIXK6XhWhA7JXiEWy9TyWAjoo2Ebj2u1BveNTG5yrsTG9WJKWjdZOzIWj7al4rZ4n+niMDepwV6TT9+d7llXKqjT8XCqzQaDSwaTqXss+S8h8gLR4izi5tWHbzIfNOxOMY/OyGhOQoBOA8YOQu+xRCT9udeCYZiPnjHPuaxuZchM7uXVAUHOX6fo0gzOuDbEFb1GZTccupjkCDhtu/PKVNZVQyPoGGeyKeaPTz5wp3eCcF6I7333SJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+kwl3SgsTK1vHXXRyDzrdAALhqbEmB0DwAC2IffV/s=;
 b=CzuT+7lZHUAvW/ZuD3nXnG5wKiU2OCTkOihRyhLQ1degBaIKJ8bNjgVpF11vRLhraIHirziDyAhVx2NReUMqsGMu85UyNQpnZ6Z1pACVzc8/luRJ/RhXmpCX/B1IBZiBe7LUy/BgSjyiztFFl1bD/YHCnYEtLxm+WN8NJ0v9v/I=
Received: from MW4PR03CA0269.namprd03.prod.outlook.com (2603:10b6:303:b4::34)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 08:18:43 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::45) by MW4PR03CA0269.outlook.office365.com
 (2603:10b6:303:b4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 08:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 08:18:42 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 01:18:27 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 02/10] drm/amdgpu/userq: implement support for query status
Date: Thu, 18 Sep 2025 16:18:07 +0800
Message-ID: <20250918081815.2755437-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918081815.2755437-1-Prike.Liang@amd.com>
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 19898631-1429-4036-d04e-08ddf68bfb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FgjnFNTExp5zERuklG9DeBlfg7v4aLVKcrn3WUK92WxJNcxQG2UZXv+I90vB?=
 =?us-ascii?Q?ythnCnfLkNsyWBd7FOGYDnqLlqSNhOMF5nzE/gtmJbNZQy8xELiYkecNLOpK?=
 =?us-ascii?Q?khp3MQcLKjhdjG1fCj/PPoLc6Y/X+7lsETyir1YTrCwlnGl9Y7vVZOyjR0/h?=
 =?us-ascii?Q?QyBC+wz9Mf49eJRuOoiOWlBeqVY0hcWX8h6dPA1vO0rvCJwkbrB0pyYi4dSu?=
 =?us-ascii?Q?bqtsB7YPK7B7bmbLLH2KAqfQarFJUcFsaGP7NyuYZF/jhM4jIjgHK9Za3S9G?=
 =?us-ascii?Q?q2kgl0j7xVQ2Xpj6dHvK+NuwoO0sABZ+ACdVCKR7XAv97F6Ueck1blSWS84v?=
 =?us-ascii?Q?wCP++HVvPiKlQm4mMzx2eyAw6ToFUP0+GUpTgLhyrS6BLpIfAU5I6HJTB5P8?=
 =?us-ascii?Q?+ylC7e8WYN+7qOXzIoEAMp5o41oSP0m8Yf+iVW4hRPCQVInSkpqsFerZbrLY?=
 =?us-ascii?Q?gU9STqJXaFCib+UFBOHWTeYOuAMFFhtopqbmTTeDiW5oTkFCUlaRJuC5pg49?=
 =?us-ascii?Q?tgAH1pf7kOyBWD9HZK4TcqutDwH6ipN3CdsOuro5B3sE6L++7OPQVmZX/3nm?=
 =?us-ascii?Q?LuJKSR5FWpbDzGvuZHGosgYWHnCoOblXNpvHKRmwWxRyWFSNHv8RfJ12h93Z?=
 =?us-ascii?Q?oXeOFCIIKjksvrOV6J+Tdc6EfT2FhNH9zjU1hmbsAnWfv2hoBQvjXivzGo2I?=
 =?us-ascii?Q?LoS1WjGkMfzi9Fo2qzOLU4Z0TXqby8v6IEgef3K86LfcpM71x06FTDMfz1mo?=
 =?us-ascii?Q?l4UHGdcLb5NG03prOMLHRrAY0fLow9cpT97zdoCekRYFKWHjbl99gTt6k7CV?=
 =?us-ascii?Q?5wu+vNSf0XJSiwArGrLWHodbqP6GSOVpDiCv6gUyxP1Or66IjitQ2BwIwmcg?=
 =?us-ascii?Q?5jTQbYqQLdhgu99R/DIWNFMdTDluO0I/EZA+RW3fBjyusM354OF3+QpdSC1y?=
 =?us-ascii?Q?1UmF87geNa5LcIVPCc5oIAmku8y8hxcv0RPcB1x/ebQ16mJZMEA5JqffZX0F?=
 =?us-ascii?Q?5r0yFuOqw90QfvF3/cAMPRdOk6vhNIl+HlAwEfXskCVB+jservtnvPDYfek0?=
 =?us-ascii?Q?8LRCS3BfcH7vxqFC12hPPzqQ107jTstJ9uSxbajyY2gxvxkuxA3jRIYd9iJz?=
 =?us-ascii?Q?DtuHZa0bg4WDKIAFJDX/O6pHokEi7sdMqp99nRPiTxa0xGvMwazxTyC7oXkZ?=
 =?us-ascii?Q?9Wor7btFG572im6Sy1aiJty3uQS7srqX75BA2MpJf7bUBSfLX6cbPHI75aLO?=
 =?us-ascii?Q?XWmvj5XRz1NstXQDj/+VJYutYsYzr7WEHocNFrbQJ6cTb8ooO4r8dtrdvOgU?=
 =?us-ascii?Q?SJS4PYll2pO8TmKefyX8HdUqdSMp3gR7+PLtErt3POn4bqh9OkDyIwEixKzn?=
 =?us-ascii?Q?CHEQZ1H/4d6qjL8mWGTymPvsfqggMKNfgRTMP3LUFwiwBPPGAv9Azxd+KvOd?=
 =?us-ascii?Q?s6BvMw2IP5dtE8VgDhEWB9La6ENP3WKeCyGVDAcYYvOfUh4rqR5PZjG8S0aP?=
 =?us-ascii?Q?lsCvIy1NrVdsms+vmKcp3Yjz208Tho61tAT2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:18:42.9978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19898631-1429-4036-d04e-08ddf68bfb2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212
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

From: Alex Deucher <alexander.deucher@amd.com>

Query the status of the user queue, currently whether
the queue is hung and whether or not VRAM is lost.

v2: Misc cleanups

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9608fe3b5a9e..83f0ecdaa0b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -472,6 +472,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -553,6 +554,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return r;
 }
 
+static int
+amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_usermode_queue *queue;
+	int queue_id = args->in.queue_id;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	queue = amdgpu_userq_find(uq_mgr, queue_id);
+	if (!queue) {
+		dev_dbg(adev->dev, "Invalid queue id to query\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	args->out_qs.flags = 0;
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
+	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -633,7 +662,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			drm_file_err(filp, "Failed to destroy usermode queue\n");
 		break;
-
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
+		r = amdgpu_userq_query_status(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to query usermode queue status\n");
+		break;
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index c027dd916672..2260b1fb8a22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -66,6 +66,7 @@ struct amdgpu_usermode_queue {
 	u32			xcp_id;
 	int			priority;
 	struct dentry		*debugfs_queue;
+	uint64_t		generation;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.34.1

