Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4FCE77188
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2024 15:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0170610E504;
	Mon, 30 Dec 2024 15:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5cnEAu+h";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA0C10E504
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2024 15:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BruSCvKi+fi48rJQI/AHKvjprakbmDXEp2hKLgwC8PXrOpHvg0RuUtjAUBh2UAIObYpQuuOVXnqK0+R8r+gLJRGXG9PmhaMaRPfSbuioNrYK9iuRBRIwQqcmOG6vC7xgpukVN+qgIXJt+X9XygzHACruZtFdtIRMXPY1NKEWXP89SqE1ZqKPBgvHJ1tf0hiuycjkIEiysRHNsTjpzh6n5QudN0FXUGa2TrVzWg1kRyq3Eby/o8QxDXPpel/foImk3RQaeLk2lh79aphqUAe6+ebgZPR+a6wo0YOj1LZtjSFfBXT0HBboieywn2M8uuAYyyZ7Pk+iEKiwDIBRE8V8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGXyqFYOKtGWr7TUQ9FyTPNOAAlOEJx2L/S7sD/keDg=;
 b=TcTTdPaC5YxeSYqJ1FXihDKNfUDf2KDFcXhICxJaUkMp1/uWO08/Neo9I2A9OFnchVkqzOyRuQH2+7n4u06gXjfbsWZIXaK4ALAv3PufA1wAy3hQV80HlgjJOJK7ImM0tkwKVERQs4smf+MOZAWC4qI3V1X+WVqtE4FslERqbtCsR/z+OPHVCj49OIEdWklmiUUWogiDwHFXIfhf1IRSNAZbdn/nHITNtmustjRNBaeheaufD3aEc4w1X9DOeV8P+RB58AjPUa21DJoL6uBOa+d4fGbiTZbmS+esecZNddoPJh7byw9WPGYjwMUdgWZHKOhun8cwDAcnGBsSwor/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGXyqFYOKtGWr7TUQ9FyTPNOAAlOEJx2L/S7sD/keDg=;
 b=5cnEAu+h9q+JTHBDPnGHaE97JzVNJ9bdzV9yDdmnyy6PvdfwJYQnOmzxIyFrC0rJybeN9l7Zw5NcRd7KA65pIMYAtYDzXMwMXPnxbuAlfpTrNTgIRDDEddVeoqNKIFCmMKg0hSvbTZFJjQyaq4FUoPI8ZvbMGw7b2PhrAnR5q6o=
Received: from DM6PR12CA0005.namprd12.prod.outlook.com (2603:10b6:5:1c0::18)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Mon, 30 Dec
 2024 14:53:10 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::4f) by DM6PR12CA0005.outlook.office365.com
 (2603:10b6:5:1c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 14:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 14:53:09 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Dec 2024 08:53:09 -0600
From: Andrew Martin <Andrew.Martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <kent.russell@amd.com>, Andrew Martin
 <Andrew.Martin@amd.com>
Subject: [PATCH] drm/amdkfd: Ignored various return code
Date: Mon, 30 Dec 2024 09:52:55 -0500
Message-ID: <20241230145255.251661-1-Andrew.Martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ecad2b-dc15-4f48-cb58-08dd28e1ad85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0RQvsYorIYgA96D5ejUQ8WmT/QlPLc3sTyOtsnluMaaCLOgvTRdhVAIcUzMs?=
 =?us-ascii?Q?Vf57JbKcKv3HKmLRZ47so86cmTYS6aazL7nTgYnjdmSZXVmEEe6YJD8OJYZW?=
 =?us-ascii?Q?RF4PR6GLSze6uEyfk1agj+ycUDq9qw1V5y1P01gMbHTUcD5uuA0yyilWDok+?=
 =?us-ascii?Q?u1XBYxjOUHG2NX9TgEv9N1FviW2/i7ez3Lms9Sd/8VeMnBUBcX0JpKoT/Atv?=
 =?us-ascii?Q?GtVeZZTHtLTjKMi2vEWYwYaMSrhbI0vSPkmDqAnM05FNfAyvnBWHRjgNjKZ+?=
 =?us-ascii?Q?sBmAwqKY7m7ZvB5ucz2LHeTc5L/p8gUKutQNLTlu815Bt5Ou5vweIP/YONE5?=
 =?us-ascii?Q?v/0CJBiEfC15MQo2h8VKSk62q/77/hNlzeia36WFwrbh5F0sBCyD9tWlFJFO?=
 =?us-ascii?Q?tCuUlzVilScDkJnQrddugWbzozIah6DyQMvkzeYN7SSARGUo3r+Ogi4KGXt2?=
 =?us-ascii?Q?a9xSSgYtzbeDztXX1IWfL1a9A/eqSL6awGVT+4qm+GfFpEFSj8hsaR0PevyQ?=
 =?us-ascii?Q?us0ieHklQZ3VMvzPCNpqHEj88Y6gpvwmwhve0N9vAHf791wOj6tXFja4Bnmj?=
 =?us-ascii?Q?2XqOxn7ZXi0uKUj2wkz0Cu3EYEbmerQVHmLf2DMIKJrkvBSmrBSyrG9bOkAt?=
 =?us-ascii?Q?sKqZ3N+aqpP9duVZPOHuAzJDOjLJoNwUekMGolld2oVNSUXFEHmas2+vsCON?=
 =?us-ascii?Q?ATQ7oY67hAri6fhJY+pfRe0KEYc2KbET3ADct9mBOYdNER8Cu6caRU5G7l2M?=
 =?us-ascii?Q?OhMVh/R4LnDuwTBEUoefgVhAwBuJxz7pwaAJXi5XGGV/hgYI7Vk37lAQToLB?=
 =?us-ascii?Q?MJN8NSQWEqg3MlNLGdxszNOs7KaYeCbdKpCUbDHlOD3Xmxe/HV/u9uie8zva?=
 =?us-ascii?Q?+chIuNswljnXzqmud2lxKoaLYn1BR+Meh0ZSIuzUdRPOjXbEbZLFiHkkfoHT?=
 =?us-ascii?Q?Hwub0IfF+vKhOqvECTd/ktIlVPGoqaCTcnwT6lPbPeo0ImZNi/Z9KKeP1hI9?=
 =?us-ascii?Q?VE/xNB6TRwbQNwRF5J/EkYWrOKQk3StxMxLWKNZr626pZZeEbrBN3T90VedG?=
 =?us-ascii?Q?fuOwXu+b87XWeOMmMp+abs3pOJwQOHrM5IDOO3Dy2j+QjHisAOEJ7i/9y8h4?=
 =?us-ascii?Q?pWFR2O+KjMioWxI2fN8jhTgzILB3ejINt2HoD2/2aSyWI9Z3f9XeTaY3fHdm?=
 =?us-ascii?Q?G15Ch4abfnLfuqGkdeglKY7NoU1N2mXE9fWJhXUUZubHppLNAYBAxbO1q+vZ?=
 =?us-ascii?Q?Ol7aQKxjugr28bpoyvildqRkrZXYzpUQLy+VGW3R7VfmcvhcY/Jae820yrKp?=
 =?us-ascii?Q?qJUf402RADslDflY8NluHEaS+wcFii+fMVGka1unCIH5a/1yy8NijOznQre7?=
 =?us-ascii?Q?QD5vhu9LYrJSym4gFDfX8ITOzMf8q5vjCaNhO94g9z7Qw9IdjYU7oR0AaakX?=
 =?us-ascii?Q?FBgw8mF3EUGQafdglK4jpluTVDNa9HULf0HAtZNpGfm+TVBV+Z+g6lNah0bu?=
 =?us-ascii?Q?FaWo3V1aF09TRM0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 14:53:09.9207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ecad2b-dc15-4f48-cb58-08dd28e1ad85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
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
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 ++++++++++++++-----
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 11 ++++++-----
 3 files changed, 22 insertions(+), 10 deletions(-)

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

