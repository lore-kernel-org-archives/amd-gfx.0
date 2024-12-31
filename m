Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA4CE77188
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Dec 2024 20:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE3410E154;
	Tue, 31 Dec 2024 20:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wLHDVbCK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E883710E154
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Dec 2024 20:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JW4HY2h3S7N6jnmc25r1Y5omCmUEHJ75y4n0lL+bbMY+cTKri2WMWBvHPdiytZ6riy2T2aUOrzQVXF97hGob6ahq5RXqJuoootWctKPPP7IKpW9Hu+s+f19kXr+CH9kIVglqkYUYObzdaRK9T+JnmTc+zj7JnmhdyJRCptFv4eVsvvAH7OSyDnotQq3HDh6g613nBspAj4SM9llfBuWnp1Fq/Ie8jkUR+pp9UAdpzhBlz4beQVlV9O/VDlNwf9h3R76WtIDhiDUd/7G5eKWsTh1MlcFJWw5YEkn6h/7/nf1mmptvfTIFAyM73oQSCco8Ib6xHLvYTJvytoj8I8mP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/etx0BEUehzcAsJCFVIldXudBiQxo6xF1fPbvcZNVE=;
 b=QOxnLH3JKxtrtxU+KJeK9FVLqAfUC7UEkC6Fgu/oY3RWAGOiFglNbUzvQ+idBlob18p1MJHYP0fDD9c3rjzQ+go0WVZpfeQo/Jdmk2pOG6dugNaAAp+7hKJxAz24AgAR1ABmY/eJk/SzW2x+75weGAlE4Th7uAjJpg/IIpNJ/SujxhVLs9NdbfH+Lf27RA+7EIiGQZpkX2geTsand+XHPvBW8pWCVwSptpc2ub7slFUm0ves8p+afmbVbZkCC1LBedUNYwv9o5BsH0B0TphwdWLqH5KPpOJ7Ns8eFwixmMWzVBBQK2xvmKBGUTB8yOoQ5VqwM5eyBwMDbvcsCo4aBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/etx0BEUehzcAsJCFVIldXudBiQxo6xF1fPbvcZNVE=;
 b=wLHDVbCK4jEFTOuzQaK1kgTZLpVr31xRuxYRHxB1RkQhIb27aTyAODvhjYa+c6Zw57qNpNEJKRZ9dyYS9L5B7fdKIuaekD2OXgaTSzfT/tD9EYGCHCciKjOSQ1A+aa7meZMvZVGkluBlYtJqPhZlDUlsVUNuxoW+trfi2iLxkME=
Received: from DM6PR02CA0083.namprd02.prod.outlook.com (2603:10b6:5:1f4::24)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.17; Tue, 31 Dec
 2024 20:41:31 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::6e) by DM6PR02CA0083.outlook.office365.com
 (2603:10b6:5:1f4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.18 via Frontend Transport; Tue,
 31 Dec 2024 20:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Tue, 31 Dec 2024 20:41:30 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 31 Dec 2024 14:41:30 -0600
From: Andrew Martin <Andrew.Martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kent.russell@amd.com>, Andrew Martin <Andrew.Martin@amd.com>
Subject: [PATCH v4] drm/amdkfd: Various return code cleanup
Date: Tue, 31 Dec 2024 15:41:17 -0500
Message-ID: <20241231204117.881674-1-Andrew.Martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 1abfa858-63c5-45c3-c181-08dd29db81db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DDLVhOC2g+/4el7kr5B6Y/L2GmoGl2YavbfY0emuB1qAG9TPQKqimTv5BupG?=
 =?us-ascii?Q?EXHMOktf/0PY/FFvKZO+WyCPQsIAcZx4dTvW8jCifajDe6lwy86OAccIyIe4?=
 =?us-ascii?Q?sRjNpeiV9hbAKT9K2rudykq0FyQkkDkeYwKNP1E9rkRNIy2ARolq+arTUlNK?=
 =?us-ascii?Q?ucI3I52fm0f6LNFDHnYRPaGDXoAg7YN4axzMLgd+RMF2ZQ1c1gwTgUaNt5pl?=
 =?us-ascii?Q?TT4q1oq3hjWkKLMs3tgDNx92LAD71AU+6SETqey6Dgz4tke160X05y0lWbQ0?=
 =?us-ascii?Q?A7KWb22KGIs9/UvHjfJm0W7n0dVVRpTffwLl/tWcbDTyDvdvF1UJr9lDiRMJ?=
 =?us-ascii?Q?8TM5xXr/3xt8HuJxk4eH68sjpsGnGmK7Xlg6537AeHWXBQl0BccLXCGn5yLR?=
 =?us-ascii?Q?cWUXi1xBaZIR3aDgQDtscL3W3d6tTwQVzTIEZZoUOv2JEM1dYyelD4E7LxFh?=
 =?us-ascii?Q?WBFjZPqWr+KD2U5Iky8W0g4R1EYWEWAXMPQxYutk7krvD2P6EghBYBZd8bpI?=
 =?us-ascii?Q?VWIlq8Sv/PHVhhZwChODg3BlMjYpXzRgNd/S2GdX1/Z9ltUBS0ntHbB+13wM?=
 =?us-ascii?Q?q6kmdDywIzEkkOATyC5Uot7H0ecJ7Do9bCKHRKRDBZzCO9uOCI/nMVbvPfeh?=
 =?us-ascii?Q?8uLWGpNtntOmFynJOtJObGm6lZKi8FCQT7KiSXC6Sj/9hHsjRP7CmZTyR9C9?=
 =?us-ascii?Q?LPjv4qg0Wkw+oqoGyJpK4SjlD6Wou+e77hmwiHO0rxO6GJnFrklIKHrI+Gx7?=
 =?us-ascii?Q?CRawZGQESDYgvUxcWHEOXYylHK03aJ5eMq4pGqZaRI0xKBuM0wJyzaMKB+la?=
 =?us-ascii?Q?nRK6kt05ixDsmc78kx6gmPeDJlC0TgQG9+pFHbgHcJp8nDCTM23bj8E2v3BP?=
 =?us-ascii?Q?NDQ7Lxfx8+jEUHBLhZ9hMT1mkvtI8xUTCzajA/CaBTTkOp8pCRP7EJdwjOrr?=
 =?us-ascii?Q?7s3hfaELXJtNENPuVKFI0izEgWzxlyG/OlNC7bY9p24BTxeKFChoGnuHRfGI?=
 =?us-ascii?Q?9FHo/EPHo4CvcKlXzcTAqcAI1uZjgJBy0jRCjkQ3kYV1CFuta90Ovb7ZP2LW?=
 =?us-ascii?Q?Xu40LWhE5SIfsJc3ATjon28kVyIt13qCDevfjn2b00Kly2MdNfbL40XkNwgU?=
 =?us-ascii?Q?9MN1ru2uVqgL6xCWw7E39AouVYKSCKMj4iqGGo8np9+iI2yqdAl65/XR/M3b?=
 =?us-ascii?Q?G4whHjbG3/GX7HiT2j/cm4rHy05MgkZ0DJXL1LoQ8SvAunV276uytvgZMeuE?=
 =?us-ascii?Q?AfzWAgCsgBSc6IYzFO3jH+VmoK4RwzV/bfWF1VSt6G0ldAwbcXAWGeYYkf4U?=
 =?us-ascii?Q?OsLAAKYRdCe5P8BiWFoujrLX2JuLLnSfAdPmxgH+ouYn+3Q/b0+GLGChilx8?=
 =?us-ascii?Q?4y+16Y80Nxzhpm9ET/na0JhmRbfYzRFAXWtl3uRW4XlFgf+zsLVkmVrzrXce?=
 =?us-ascii?Q?N2yzZRgfU3KVeBnjbp6wYNjGKm7S+XT2H/Y6kHlrvU3LJqT0AxdCcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 20:41:30.8780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abfa858-63c5-45c3-c181-08dd29db81db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
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
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 ++++++++++++++-----
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++++----
 4 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 065d87841459..f2424c62d1e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2772,7 +2772,8 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
 		 * saved in MES.
 		 */
 		if (pdd->dev->kfd->shared_resources.enable_mes)
-			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
+			if (kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev)))
+				return -EEXIST;
 	}
 
 	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
@@ -2864,9 +2865,9 @@ static int runtime_disable(struct kfd_process *p)
 					pdd->dev->vm_info.last_vmid_kfd);
 
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
-				debug_refresh_runlist(pdd->dev->dqm);
+				(void)debug_refresh_runlist(pdd->dev->dqm);
 			else
-				kfd_dbg_set_mes_debug_mode(pdd,
+				(void)Kfd_dbg_set_mes_debug_mode(pdd,
 							   !kfd_dbg_has_cwsr_workaround(pdd->dev));
 		}
 	}
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
index 1405e8affd48..b3ae7baa3b89 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1907,6 +1907,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 
 static int stop_cpsch(struct device_queue_manager *dqm)
 {
+	int ret = 0;
 	dqm_lock(dqm);
 	if (!dqm->sched_running) {
 		dqm_unlock(dqm);
@@ -1914,9 +1915,10 @@ static int stop_cpsch(struct device_queue_manager *dqm)
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

