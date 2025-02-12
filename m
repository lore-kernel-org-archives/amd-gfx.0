Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8B9C021A0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 22:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5815610E158;
	Wed, 12 Feb 2025 22:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LXhGJ+nH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A9EC10E2EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 22:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xn7nxLmO5jfYXtRGsMwU4ea/P3v0uZ741b141fYvLkevBRP4euLIB3hMDbQNGX9DjsfwEaaKC6JgJudGPf287sCv+mamjh2rWLujM6XyYQX0yJ1vCd1iz5/C6Hfc+UL7n1Z8/dFrQvdVcXc8H/Wdbsg2AGA7ECpXj1Y6yY+8FGhvb4wBCbdE9yaZVHXfKA7kUCKuPRHXzefPusVmfBqk3wnLe+lvyHLlxkTqA0UoKzONiaUFW+ty7fjzSe8Q9kExjq12rKc9EWqbJVHHO7+jNts4i9739k5Siqse4iJP4M1MRLw6XoI4PR7jNfaj1RhQeKGzV+AkOOAFr/IbLUns+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXC8H1jiv9x/oeRDdRnNjNmcAUI+eZP3sPbDZGavI/I=;
 b=KgT/cvFTtKlp+6xpkex8xRyjNehZIqplsWZ8UW8hck7dmIB2rGyOhN+PHGnz1W+0zlyZiOJbI/py23NIb4CDiZvJNVs3C156vyG98fBGLgG/reuwQzpzNOlDYzPX+UE6km/Ed+1Szm3/7MyuZlBF7T/AJNo8i0c9AGZPDLcv562Sqr4fRcgyOw1mMqSw3lAX1aZFlfAosvOdog96Alz1/gka89qR3qrQ63M4Ar7kBY1QHd+zFz7T7SCJRPqFhcFYzjaE9+cGifuh8Lg7hc/+gxVdLcKaHsXoXklmmWDO/V8ZRGDvJ/OwCLMR2qzKiGEZaGefbkQNg0q8p7HVzXv1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXC8H1jiv9x/oeRDdRnNjNmcAUI+eZP3sPbDZGavI/I=;
 b=LXhGJ+nH0htVPSvn6yHHX+yZZryP3eEZpfP1ywryYaH7KoRn1b9j70UzQs8G+a0xn/yVdOhCglEI3pNs9tK11euWsKc/GNvYv0fUw/qa//xCtXKizFpv4jw1sSDuzk5hp28eZfhBTsIWaVrF8VAGIHjIf4ypS4meoe7huKUz8Wg=
Received: from PH7P221CA0051.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::21)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 22:04:07 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::b2) by PH7P221CA0051.outlook.office365.com
 (2603:10b6:510:33c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 22:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Wed, 12 Feb 2025 22:04:06 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 16:04:05 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 2/4] drm/amdkfd: Use asic specifc function to set CP wait time
Date: Wed, 12 Feb 2025 17:03:39 -0500
Message-ID: <20250212220341.373072-2-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212220341.373072-1-Harish.Kasiviswanathan@amd.com>
References: <20250212220341.373072-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8589db-7824-4aee-4ddf-08dd4bb12b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TmosN0QFK8rEmk9o2bZp281Na93aCPbzwP+Jh023lbtsHfVhGF2MfF2hxHWW?=
 =?us-ascii?Q?BuGQ2z4ijnS8OgdzWv3mOrnDgNQA9uLTLRGssv5ABvTzVCAjl2VoNH9FlYxF?=
 =?us-ascii?Q?2tRGA5SgUyiltzxQE8WN9FV2UqAEfphRMNdRAhqEn9m0mDgnHpaE3qCZ03RC?=
 =?us-ascii?Q?LusSaZ6+yu2bgqEtaEz2KQoDntknQwltQoIlAMXCOwUzX3sDr2OWuqMiMU4q?=
 =?us-ascii?Q?Zh/0G+/cSVeLs4hNjOljaQ6QLhzZHILkxgx6Av+AdjJYsElD9w501Q9h1Tbs?=
 =?us-ascii?Q?x4OdG9asa6NcQS6+494x9Q9nANBo0pCNGdLyet/op6Cq/VoSE9xLTEB0SNWn?=
 =?us-ascii?Q?LfXjc41qQ5tR0/1edSVJ5vNHrn1MjnyAESrOSKpfsAgSvOaSrsHYPsK3JzAo?=
 =?us-ascii?Q?LFtVxnyGkyO0NXW0gR+onMv1qguJY2jeVafp5ixwLGqkfYTxgTKy40I3/Tag?=
 =?us-ascii?Q?M0pUNSZ/Q0JvucBpcozW++Ior6adjoBmdI+RCs8R7jvgkSBXRO9QNYFG0ilS?=
 =?us-ascii?Q?1BlpcBAkiAukrb+xrDGlXSQ3QL2GC//5w9/Y0oxVJccPc+lYsUBv9iQ5ZBLK?=
 =?us-ascii?Q?G0iM6dACbe1GcfWk9LhR0UIg47EUWDuysPl7pajoApf0Mov4QLThd8beHAGf?=
 =?us-ascii?Q?NPQQ06s7GCF8cuJTVcw+oMHUZt9y0n4t0YBCRtX3m2ZVnl999sPnaMguuhij?=
 =?us-ascii?Q?cOn5q/vN/yXEgBLNwCvNqNSjB0SEoWetMvbC1MZ8XARvCB7KsC18vGXkxPEV?=
 =?us-ascii?Q?JTxFsFL/r9EowctlR3+lLKUYtEVjLGaILfXjG3Emrp2YgBpYRnagmmM6mO/F?=
 =?us-ascii?Q?ngbO6VlVmHXctwUg28dFuaIyEA4u909T+PnC9j3rF9CKMj9pMJ7tjUZZjaJX?=
 =?us-ascii?Q?+Gv1d7k23S9WdeFn8aMRU4tjc41J8u4H4NP4JWJ0rBW0b561o7lnx0d7HLWZ?=
 =?us-ascii?Q?mpnzwkH+aK8xdy2Mb8oHfaY8A59qs/rwjUfUUT/ik3sloZVQEaQCofDPRSYv?=
 =?us-ascii?Q?rAPqZJNBx1RwwVV0KquHZEqUjVTJBexN1afeg1ArNXWbcUbL5mheA+l+CYIR?=
 =?us-ascii?Q?L7boyx2K1eqzkxrl5CXnCxwpswwC88ur2g5d+yRFT6nSSlTYMO7rZxnYywtx?=
 =?us-ascii?Q?v4yulzYGB2/e2yEeTnENllpLzRn9PYNC2rCyD3c9RNhH/JIGTIdp3TCMc1vB?=
 =?us-ascii?Q?s4euPIt9B/ocvvGMyXlZgNWyiKJFTvsUoFOyQWhn/UHHTcQaq/WArJrToUqI?=
 =?us-ascii?Q?2ERNCxMtY2uoGMVwYuPGA5g0L1IqaHdboHZZ2o/TmnVu2UN3YHVjvKEO6U76?=
 =?us-ascii?Q?2y5uLj8s7e4uf66XcUJqsKecthZvFisESCOVMNYzj8w6O2WAGEWLT/NsIK9Q?=
 =?us-ascii?Q?8PQ7HAOnHo9QbDKYzRi9gVyStveRPXczG5FB8iCVul4t2MkLS6eUHpdoPPmj?=
 =?us-ascii?Q?p6mCOCTvHm+L4zQaRpeY+thKY1iLZqD+oNksXAr+RgAQky/lubxYnZjWrKPd?=
 =?us-ascii?Q?KCDobaNJ1t4AmxQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 22:04:06.2697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8589db-7824-4aee-4ddf-08dd4bb12b4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361
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

Currently, grace period (SCH_WAVE) is set only for gfx943 APU. This
could change as other wait times also needs to be set. Move ASIC
specific settings to ASIC specific function.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 28 ++++---------------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  9 ++++++
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  8 ++++++
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 10 +++++++
 4 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b88a95b5ae0d..3eaa44d0410d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1760,10 +1760,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 
 	init_sdma_bitmaps(dqm);
 
-	if (dqm->dev->kfd2kgd->get_iq_wait_times)
-		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
-					&dqm->wait_times,
-					ffs(dqm->dev->xcc_mask) - 1);
+	update_dqm_wait_times(dqm);
 	return 0;
 }
 
@@ -1859,27 +1856,12 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	/* clear hang status when driver try to start the hw scheduler */
 	dqm->sched_running = true;
 
-	if (!dqm->dev->kfd->shared_resources.enable_mes)
+	if (!dqm->dev->kfd->shared_resources.enable_mes) {
+		if(pm_set_compute_queue_wait_counts(&dqm->packet_mgr,
+					    KFD_INIT_CP_QUEUE_WAIT_TIMES))
+			dev_err(dev, "Failed to configure CP wait times\n");
 		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
-
-	/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
-	if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
-	    (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))) {
-		uint32_t reg_offset = 0;
-		uint32_t grace_period = 1;
-
-		retval = pm_set_compute_queue_wait_counts(&dqm->packet_mgr,
-						grace_period);
-		if (retval)
-			dev_err(dev, "Setting grace timeout failed\n");
-		else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
-			/* Update dqm->wait_times maintained in software */
-			dqm->dev->kfd2kgd->build_grace_period_packet_info(
-					dqm->dev->adev,	dqm->wait_times,
-					grace_period, &reg_offset,
-					&dqm->wait_times);
 	}
-
 	/* setup per-queue reset detection buffer  */
 	num_hw_queue_slots =  dqm->dev->kfd->shared_resources.num_queue_per_pipe *
 			      dqm->dev->kfd->shared_resources.num_pipe_per_mec *
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 273c04a95568..8a7d9b2a135c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -38,6 +38,7 @@
 #define KFD_MES_PROCESS_QUANTUM		100000
 #define KFD_MES_GANG_QUANTUM		10000
 #define KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES 0xffffffff
+#define KFD_INIT_CP_QUEUE_WAIT_TIMES	    0xfffffffe
 
 struct device_process_node {
 	struct qcm_process_device *qpd;
@@ -359,4 +360,12 @@ static inline int read_sdma_queue_counter(uint64_t __user *q_rptr, uint64_t *val
 	/* SDMA activity counter is stored at queue's RPTR + 0x8 location. */
 	return get_user(*val, q_rptr + 1);
 }
+
+static inline void update_dqm_wait_times(struct device_queue_manager *dqm)
+{
+	if (dqm->dev->kfd2kgd->get_iq_wait_times)
+		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
+					&dqm->wait_times,
+					ffs(dqm->dev->xcc_mask) - 1);
+}
 #endif /* KFD_DEVICE_QUEUE_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 8d2f63a38724..e94ed478bf5e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -402,6 +402,8 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
  *  @wait_counts_config: Parameter overridden. Could be flag or grace_period
  *   Possible flag values:
  *     KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES then reset to default value
+ *     KFD_INIT_CP_QUEUE_WAIT_TIMES Initialize compute queue wait times with
+ *      best values for each ASIC.
  *
  *   If not an above flag, Wait Count for Scheduling Wave Message (SCH_WAVE)
  *      is set to wait_counts_config value.
@@ -415,6 +417,10 @@ int pm_set_compute_queue_wait_counts(struct packet_manager *pm, uint32_t wait_co
 	int retval = 0;
 	uint32_t *buffer, size;
 
+	if (!pm->pmf->set_compute_queue_wait_counts ||
+	    !pm->pmf->set_compute_queue_wait_counts_size)
+		return 0;
+
 	size = pm->pmf->set_compute_queue_wait_counts_size;
 
 	mutex_lock(&pm->lock);
@@ -440,6 +446,8 @@ int pm_set_compute_queue_wait_counts(struct packet_manager *pm, uint32_t wait_co
 
 out:
 	mutex_unlock(&pm->lock);
+	/* Update dqm->wait_times maintained in software */
+	update_dqm_wait_times(pm->dqm);
 	return retval;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 8b693a9446e8..6a5ddadec936 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -302,9 +302,19 @@ static int pm_set_compute_queue_wait_counts_v9(struct packet_manager *pm,
 		uint32_t wait_counts_config)
 {
 	struct pm4_mec_write_data_mmio *packet;
+	struct device_queue_manager *dqm = pm->dqm;
 	uint32_t reg_offset = 0;
 	uint32_t reg_data = 0;
 
+	if (wait_counts_config == KFD_INIT_CP_QUEUE_WAIT_TIMES) {
+                /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
+                if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
+                    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))
+                        wait_counts_config = 1;
+                else
+                        return 0;
+        }
+
 	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
 			pm->dqm->dev->adev,
 			pm->dqm->wait_times,
-- 
2.34.1

