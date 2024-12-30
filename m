Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B131E77188
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2024 20:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5CA10E013;
	Mon, 30 Dec 2024 20:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0C1jM3OV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC61B10E013
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2024 20:39:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bsk2VwSs218v5DR/C9sZRM35/vtPceWajsW3fYDUoZRxH7sNXPMk+SYKeX9sZx93XNR6PhFYwbjgP/5GCX6a/ox5QpN1GaPvOY6MOLgxJeqToWquVgbPknHTa3h3XcTNGtXfKJKNvWMXwmnNJ9favC+XR1eaXbuBc9qBp2KQc/JPgA0SjeTEmSZv4HxTmqrr7PLGlZ0CnCg4kfKFvuvDN3clPWS0je6cIoPWVPdB0OMh+EzEiM1V271A97mUF4aaBUEs3L6qMB0FmTifp1TL0kEMp6apqQWgXGwArXHO57J0iFlQrFUUKbWp4u1Bg8gt5nLNY4+efW+z11kVw+CsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxCiuhUWBfkC0kxlHIAHPOZjveUJ9e/TxKoTKHiJhAk=;
 b=qvQcc0tZ0r1cbUJST5sCC1Ee8a6m4Py+D652I3ADHWQZgkNdluADG8EzXavInQKfOcwTZqwPBXIo5Ki9jm4ncvMY8tmAH7qXWhRxDLXkWNaOHC8vzR7OYgDmx4pXsHavQo/SwFvyXnh2fcZtWgwEMgSL0/gdxDtsJuCZNSOHfKPk9cxOg8ACB0W2KUQTIlilbBe+fFyB20+b+kefgQ5HxfKfdoMmM3i2uZCY7u+CmT9gbuwfikhMSqrZaxQ0KctJQwVC10wYzlQyCtI7sRT45c9UBpArpVckBqLb6vM3AgMEEZMkpcoq+RKIsXy3e5LsFbBx7u+mqQOhBfqyujHXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxCiuhUWBfkC0kxlHIAHPOZjveUJ9e/TxKoTKHiJhAk=;
 b=0C1jM3OVMmYCc5PYH0eUXovcWgkUx7c1n4AYNKj0W5L1frVssOhYYwp+W1f3aW7McMNlYm9wNImY+IOXEbyWJKbXBISyUtFtQIykqgT5j+cn9XCID6oDXr+BfJKpv8ozqOD1xyvpYsepWx8IrgYViVKlTl4oEtTGu7LpOKn4NRU=
Received: from CH2PR18CA0039.namprd18.prod.outlook.com (2603:10b6:610:55::19)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 20:23:55 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::70) by CH2PR18CA0039.outlook.office365.com
 (2603:10b6:610:55::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 20:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 20:23:55 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Dec 2024 14:23:54 -0600
From: Andrew Martin <Andrew.Martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kent.russell@amd.com>, Andrew Martin <Andrew.Martin@amd.com>
Subject: [PATCH v3] drm/amdkfd: Various return code cleanup
Date: Mon, 30 Dec 2024 15:23:40 -0500
Message-ID: <20241230202340.579098-1-Andrew.Martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba7aabd-393d-48a1-36e7-08dd290fe23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wKeC4skQs8kBOesGpB0njPqn6IYezr7+aCN3RzVQxZs70c7/LoIZIZrl73uW?=
 =?us-ascii?Q?j5x3ByfL2E9jWmVVPKDgDGx1yvXtI6JoI1BYkoAP9aZXXSGGg0KEQdGHHprC?=
 =?us-ascii?Q?mCnUDoGtL+gIeELEuZ9H/XELmCKZIAecXetPCWJam+VX7kBdAVOsXA5TWv1Z?=
 =?us-ascii?Q?S7uX8FN76YtVszlR5VOiMqjDKRrsVdFgaNltsCdBz1Ux/Hi4KALMsx0Tc1EV?=
 =?us-ascii?Q?mJS1edrn0n+dAgqFN7L7mvPHjAeUHlw+H2ecOObR/fqwzbqd9jFbSQc4H/22?=
 =?us-ascii?Q?3T2+DGrp8hqyrS1kSn+1KZfmtUBR77PTXOEPtFycpB/E/mYYSLqXGtt7x/4t?=
 =?us-ascii?Q?rQcY9W/1OxGaloT1q9XqikWomV+MaCvc/o7iPMpfCguwYNShIBOgQMyuQBA3?=
 =?us-ascii?Q?sLoqqZgEt2pQ9FLgq1egkJMylAl+MLs3K5AUpc+Tbu6uLsUbzt8pwzNPNPTH?=
 =?us-ascii?Q?BTF1+NC5R6vZMMatGgxzmdcH3WYae/K66nSWhPVqN7ueTqf/wlJYKR3fUO+a?=
 =?us-ascii?Q?4hwm/QPAsCkVeC6dK+IjP91DZzJqInJ4hK7OD4gcxQaEsipA2xr7XPiFFLVB?=
 =?us-ascii?Q?gVWL35yDOay8z3eng8Xygv6C8S9Hft6ROVm8RMO5znhrgCG71YKfMahqgHam?=
 =?us-ascii?Q?rJ8oaYgI+LATO6SCPGbWf/1Uv0NepY+RpEKJ44a4HIo3xEEwjGyr/M8/tqKb?=
 =?us-ascii?Q?EZ1UQNNfPHwyeRBNmgfj66CudUN3oj2kHZFSefzR7IZl4+axK8/UHn42EuQg?=
 =?us-ascii?Q?0cSaI0uyfoIOfIumbURSJp1XSWE9GT4+T4HtCXzGIYIMC8pHcM21r4NsdPsf?=
 =?us-ascii?Q?wawP/InoSwVlTdeBdIAnH6qfPMNgdrP6BTFF3DFqJs6py92PF3EN8hdcOX4Q?=
 =?us-ascii?Q?KiQzYVd1B7bOZr+cMok0NIUnAlxv33oesQwV24SzBY8KGE/u0kivO+qNZe2b?=
 =?us-ascii?Q?deTojvKAVhgfaTkpXmQOY3Jkv9WX2btGz0ndks79jOLZtVnP+Cb7GlETWqkU?=
 =?us-ascii?Q?JHuaEBCA9zYt5N7nukP96xtL7o4smqygq4nH/qqls4H7TM5mp5esFYaZd/Tz?=
 =?us-ascii?Q?PTA4ZOyCrwPmrS+11xvj3yJcAmeQvH390t5SpF9O1zHaQ/34L+kHmO750gN+?=
 =?us-ascii?Q?gxrl8Qs5rrF2xmvVhA+kRcuKNA9bBJyRGca6385gfE6sp39AUT5LplMDmqCq?=
 =?us-ascii?Q?VUt/DOO/cqH7SYadK3A5wNfmucue20igJ/ae2i1mGWNNllTpWH3ERF7iZcQn?=
 =?us-ascii?Q?fczmdgLXNeJDL5blpDwPLLLLuVDeHFgI/i1egVExrb2SMOm1uDWVrhsiO47n?=
 =?us-ascii?Q?nctvogdXyTy6yDNrevAgm8IkvGsMe4w3ekZvUnTyff3CWz4LtNaUDWbR3pUy?=
 =?us-ascii?Q?4gAX0BQo8HBWLphlCcf/dIb7duGu6f6GKmLzj6PPRa2PXYISXsVJpmMNOSns?=
 =?us-ascii?Q?tUT0uywQtRJ9qTvOHHnCDO6c6hPhhDViZKi6DNM/KXmnUJpQ9zzi3paq7BqI?=
 =?us-ascii?Q?vC6XbfZ+QYidcfc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 20:23:55.2673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba7aabd-393d-48a1-36e7-08dd290fe23e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624
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

This patch checks and handles the return code of various functions.

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

