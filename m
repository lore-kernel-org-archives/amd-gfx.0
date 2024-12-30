Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35A0E77188
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2024 17:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 470E410E528;
	Mon, 30 Dec 2024 17:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PTROvht7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD03510E528
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2024 17:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vk8kmeeuU2Xd0no+Ig1VqDYgZJoVMpFTXGSL2YPZB5uk/VGafcfMp2qJSC2qPoOp7qCdANz3/fbRxtfpLskNsMbVLcdaJLdyrUWorJOWxcHuG1oSx38lBbRJ/N3vAC2uOt9wgaE7WBZkGctrO2sAEvh4QRTs8ofcK2ssLJyD+/KMYkMjzkrsfRd7o6Wx2VppyOuuIsNT403G8WiK1P7aqVuwchIx/Au7GVYnvp6p0qRg6+9lkGsDD3sREnNtFToUiINZEtOIP69Ovo7WW+cuZri+KLj6ixqOSQnuJ42474f8XQBaAngGTro1i5qXOSkyZNSixMqCcaF1DSiJoaXO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfvubLggPFxBIteQls/J6Y4j1L6roWgjhIjKY5xqB2Y=;
 b=VVnXXjc3W3bPp2/dazSsXyNuYHzAYXa1a/DIJs6ApQ0y6GUdoiXpRRLH2CRxNyYLFX9JPzKIZ3fz0FXSclFwll/fg1slQadytGExV4D/Pgf3aVNr33zGYuShTOgAdiI95dCgUgu9f/0cgZyvZ/oYGpcmpOGyB7f75NSTb4r6WFJbjdPfUu5b+bv1e8lomfhYUyMyhSK5KXY8BQAIU7rJ9wK6wm9mjasm5xmxVkxJFBO8xOVf0FRiT78Hxh56M2v/dphHdi700txTJRMk6XruV4lWv4RbvcqVhs6IiIPvGN9Vzw1DhN0mBOIvmsNuj/fYsKzFWTHy+OglfSleM8JPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfvubLggPFxBIteQls/J6Y4j1L6roWgjhIjKY5xqB2Y=;
 b=PTROvht7Wm2HmYID37yjKuWvSZZUE+XD/qTJ2w0xPcuKgnB/hC6hGAhaTmlVbADSC6vErbap06Ue20KBm2GlCi1mY9ASUE/oRejLpnj63tk0SMgAMO6sMHAHWzlVEKK4xXH6Y59904g/ma6LiMd9J9GB5ShaAk2CGfBPvUTfALc=
Received: from MW4PR04CA0252.namprd04.prod.outlook.com (2603:10b6:303:88::17)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.17; Mon, 30 Dec
 2024 17:03:52 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::1d) by MW4PR04CA0252.outlook.office365.com
 (2603:10b6:303:88::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 17:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.0 via Frontend Transport; Mon, 30 Dec 2024 17:03:51 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Dec 2024 11:02:49 -0600
From: Andrew Martin <Andrew.Martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <kent.russell@amd.com>, Andrew Martin
 <Andrew.Martin@amd.com>
Subject: [PATCH v2] drm/amdkfd: Ignored various return code
Date: Mon, 30 Dec 2024 12:02:23 -0500
Message-ID: <20241230170223.574547-1-Andrew.Martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: ce571c7e-5f56-4a12-07f2-08dd28f3ef7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LLNEDKO2q+iNzUUqNu3rUJmVpn6x/nkMDFz7+kzErBfJeQkvh805+CgOZkyK?=
 =?us-ascii?Q?724WxOgsLFdUodV/AZgabMwcYl2S7jof8A+sVEQtzjFXAE8oVUn2m2Gcwl1J?=
 =?us-ascii?Q?ZemgAawTCOtQ7cNzVWWIQa0y69AwgRCvsDwJ9EeYa0iWOdIL7hbz6el9h0gO?=
 =?us-ascii?Q?kL4q9sh9/1Ui7MldxaMwZ3gHC6ULj5nuZ4sgreBpCC9XXw3Fs/E7uPxA2w0n?=
 =?us-ascii?Q?OGQdqcBo15UZE0HR+iC62p1rYJkWUn2WKwZJ4f79ZUm4Nv+0qRfFxLdbUUYJ?=
 =?us-ascii?Q?ucD970gqlDwsw82l1b/2mSXK4X5UfQ1cWjsqV4KdAeUqXeKjGrjEsveqYVce?=
 =?us-ascii?Q?YC7o3EvEc95axFrpUZf49pX1ef0Mhkj1s2kZAGTc1bzkO79zsgZwqjImpkfd?=
 =?us-ascii?Q?TD5F31iC1dAICNthrtBS8t/YqiRNWgJCLrn+S+D3eKDuJr7PXBBuEpI3AP9q?=
 =?us-ascii?Q?JeQfX42fc/GLY2b2h1ZTTa6z4/elPs11nc2txPhCvoFevApPCRKUU/vbRmrL?=
 =?us-ascii?Q?feEhctEHx7Xq0oFiqbAn8fMI53C18tzXpum82wlkiqGlXi4nL3HYVm3NkV5E?=
 =?us-ascii?Q?4OwABIoSZUW1AEiStgKlYsmwdEnX7D7BYMLQH+1YI7HJ8QtiowFYStTKSHCY?=
 =?us-ascii?Q?XxrGLjhDLSOG4UYvnaHYzUWtUJkEPB0dnyYE7xh6s/5gnoRdcBLzh95VFcUl?=
 =?us-ascii?Q?2XD0qnXmmWjhoTOY5IPmz+lXQuEJVSgLm7nWZtv/4DOL0UFhLNfRO0sRPgks?=
 =?us-ascii?Q?xue9r7GowmCEtU1XjDVTn2C6YoSHAtS0vU1YbGZlTyfd6m9YjuzLmeBaIUWm?=
 =?us-ascii?Q?VoM4LPAnFn7a/qwJIheK1/HpqGMz4TxFQRROwlEuE/cU4gDsX70UXmK3B0AW?=
 =?us-ascii?Q?pNVuV5r/WmI+J7cLvgnCXe7w9gs2OLHdz1aQE+QIojXN7xylQD+3Cjbm2IWA?=
 =?us-ascii?Q?J2D4lUNzOGev8Nf9uPqVVMQAtphUZd697T7VAtL1lIuYeYoAEr7U0IWKFVyx?=
 =?us-ascii?Q?mi0yRhPvKzC8NAIQh1NsZ+437as7CzDTeXoCzrN09EU0dSlgMJfQbXzxQR6Q?=
 =?us-ascii?Q?IWR6Tdpwq16gA1k/i1O8tRQIQuzpojxuX+07HU8Bv20537Ui3pAjIESYhUC3?=
 =?us-ascii?Q?SyizTUf6SqX9U5flXonRwhNTVBSu4V93wGJFNK7qln4wAewFdhHsNOKWZYqd?=
 =?us-ascii?Q?giq34Zz1znsw7GacbePOjFjlr9pwrLIjouqgYM1T0UB3vj7L2RQLVBmP/mdy?=
 =?us-ascii?Q?+Tf6g0xYGmUSeXg/bV31plap/oLmqJk+6wpJr/nAtUU7f74Z53pWvWpom4kl?=
 =?us-ascii?Q?rYb9kL24D7Q8XY4ZuJDg6viGQqxKbZ887YP6+RlZstBex9LYmKB8UDLcH7TO?=
 =?us-ascii?Q?V8NdnM15kCu5Bm2f3HQ/n1NTSN2Jv7Ae3uHqjg3iCY+nyLyouyhQYHh9JnzQ?=
 =?us-ascii?Q?cVaVTeFsIihEwUwSjUyQVGzLkaGsWnykuiBqwT9cj3NazvAwU/YZtbAlPTwN?=
 =?us-ascii?Q?KlJnXIaUjGmYCJs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 17:03:51.5003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce571c7e-5f56-4a12-07f2-08dd28f3ef7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
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

This patch checks and handles the return code of the called function.

Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 ++++++++++++++-----
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 11 ++++++-----
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 065d87841459..52a11dc01422 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2864,7 +2864,7 @@ static int runtime_disable(struct kfd_process *p)
 					pdd->dev->vm_info.last_vmid_kfd);
 
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
-				debug_refresh_runlist(pdd->dev->dqm);
+				(void)debug_refresh_runlist(pdd->dev->dqm);
 			else
 				kfd_dbg_set_mes_debug_mode(pdd,
 							   !kfd_dbg_has_cwsr_workaround(pdd->dev));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 693469c18c60..f335ed9e0b3a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2351,6 +2351,8 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	if (kdev->kfd->hive_id) {
 		for (nid = 0; nid < proximity_domain; ++nid) {
 			peer_dev = kfd_topology_device_by_proximity_domain_no_lock(nid);
+			if (!peer_dev)
+				return -ENODEV;
 			if (!peer_dev->gpu)
 				continue;
 			if (peer_dev->gpu->kfd->hive_id != kdev->kfd->hive_id)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index a8abc3091801..b4db409d90a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -518,6 +518,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_topology_device *topo_dev =
 				kfd_topology_device_by_id(target->pdds[i]->dev->id);
+		if (!topo_dev)
+			return -EINVAL;
+
 		uint32_t caps = topo_dev->node_props.capability;
 
 		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
@@ -565,9 +568,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 				continue;
 
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
-				debug_refresh_runlist(pdd->dev->dqm);
+				(void)debug_refresh_runlist(pdd->dev->dqm);
 			else
-				kfd_dbg_set_mes_debug_mode(pdd, true);
+				(void)kfd_dbg_set_mes_debug_mode(pdd, true);
 		}
 	}
 
@@ -584,8 +587,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
  */
 void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count)
 {
-	int i;
 
+	int i, r = 0;
 	if (!unwind) {
 		uint32_t flags = 0;
 		int resume_count = resume_queues(target, 0, NULL);
@@ -627,9 +630,11 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 			pr_err("Failed to release debug vmid on [%i]\n", pdd->dev->id);
 
 		if (!pdd->dev->kfd->shared_resources.enable_mes)
-			debug_refresh_runlist(pdd->dev->dqm);
+			r = debug_refresh_runlist(pdd->dev->dqm);
 		else
-			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
+			r = kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
+		if (r)
+			break;
 	}
 
 	kfd_dbg_set_workaround(target, false);
@@ -1071,6 +1076,10 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 	for (i = 0; i < tmp_num_devices; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 		struct kfd_topology_device *topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+		if (!topo_dev) {
+			r = EINVAL;
+			break;
+		}
 
 		device_info.gpu_id = pdd->dev->id;
 		device_info.exception_status = pdd->exception_status;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 1405e8affd48..250aa43a39c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1907,16 +1907,18 @@ static int start_cpsch(struct device_queue_manager *dqm)
 
 static int stop_cpsch(struct device_queue_manager *dqm)
 {
+	int ret = 0;
 	dqm_lock(dqm);
 	if (!dqm->sched_running) {
 		dqm_unlock(dqm);
-		return 0;
+		return ret;
 	}
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
-		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
+		ret = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,
+					 0, USE_DEFAULT_GRACE_PERIOD, false);
 	else
-		remove_all_kfd_queues_mes(dqm);
+		ret = remove_all_kfd_queues_mes(dqm);
 
 	dqm->sched_running = false;
 
@@ -1930,7 +1932,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	dqm->detect_hang_info = NULL;
 	dqm_unlock(dqm);
 
-	return 0;
+	return ret;
 }
 
 static int create_kernel_queue_cpsch(struct device_queue_manager *dqm,
@@ -3439,7 +3441,6 @@ int suspend_queues(struct kfd_process *p,
 					else
 						per_device_suspended++;
 				} else if (err != -EBUSY) {
-					r = err;
 					queue_ids[q_idx] |= KFD_DBG_QUEUE_ERROR_MASK;
 					break;
 				}
-- 
2.43.0

