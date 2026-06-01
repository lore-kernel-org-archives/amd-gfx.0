Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE1ECD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E023A112DDC;
	Mon,  1 Jun 2026 05:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vOrKs88D";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9871C112DDC
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbUGuoFmoIoUv0Uk7G4RXt92M5Uhqt0XmBj/m6wEgTyFpC78evj4lvG9TNnsoX653TCu6VV1dG6lT21JWJTrGWqg6iofx713aDUsJI2r0z0eA2YQ094Va/OhPFHBmZ4rfkpXCWpvTWF3VttW/lkXHg6gbjRYqePJHp/gYfOBxu305VDj9ezp34uzSG9M7Q6gprxL67UNDtTZAl9UjWpWI95RjCchDvN7X6cHMAHuEdsyJooD5hApBYk9ryBh41RU7Rh+3UdHmjIkz5xqRkyVZh00llvoT9OFp34ORZTAyOk15vq79bcWAsgFMJN4QMJxfa2X+IvPEIfwH2p1lWlELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2G/eq9ZJWoCyc3mJ3QP0IJxYrd0coUWmdBZRUzl3JjA=;
 b=LPmtxRsj30QwzCZNlxGRIHmC3sPyJfNuFEirxxJXa+YePl7vDT9zPicgzIR04LrjtEbPj76xx7O57SmZW9UeF1U0pv/tg0JjUUVZtGjm9R8ILFHr7pr6Z9Gbt1V36RybCvEuvy31sKOx5JsVetyIXEanUbmDZpTPCknOuINbCvF2E8Z0/+IR8PQDd1GSygLDv6Scbzc1cm5moz21VNT7VaqSAUJv4OpNzAls0HMLrUS0dVmuJ1J8IZ3B2qm5M5rri8ukVUfc42uAodkvbV3spSp8ymVs6c9mJS1BSDzx1zMM1f46U38WNcu+qV/VJfbP9gOndry5gnQAacvzuZ7pfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G/eq9ZJWoCyc3mJ3QP0IJxYrd0coUWmdBZRUzl3JjA=;
 b=vOrKs88DlaPsE0HSt7bDEdn1WM9TeOngubRTcWv2XbWFomYK87B/BF3WczYg6QOJ5/L7AZzxJHdXmMbrNU/0IP+j32BPrRuTCDaCUN50G+NCujqx31O/70gh0ieUKu0cC4Fu8eewtuyynNjgm86/vOMaw8F1fSb/COs5/QdsjrU=
Received: from BN0PR04CA0151.namprd04.prod.outlook.com (2603:10b6:408:eb::6)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 05:55:08 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::9c) by BN0PR04CA0151.outlook.office365.com
 (2603:10b6:408:eb::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Mon, 1
 Jun 2026 05:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:55:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:55:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 31 May
 2026 22:55:07 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:55:01 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH v2 37/42] drm/amdgpu/gfx: add a common helper to handle MES
 compute resets
Date: Mon, 1 Jun 2026 13:49:23 +0800
Message-ID: <20260601055034.3700921-37-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b32c57-ab61-41f0-a640-08debfa2561e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4rehM5PbX9HP1UVIORYvmAStWG5m1r2l3O0oFKaiPzVcdHc6eWeTfUh/KfWQgIiHMnih00cEotpUApndnVZiEv1Y7PXp+azGoBdGHFY8prnA45awAX7XaQa2j9ZZ9IMhIpb5CiijG/oO+k1zk0Zhop9Uluxr8IK6u8H6M55KuS4AD5FxYUy440I+7HYbDiIfzwr1AUwt0DVHE0xt7x828yU9kfuPnDkweE8RGs8CbFRlrF0t+uJUnw+Iw52hAKGHmSaGtq5e92XNu+5OxSmkoUE1tpT7ikObjU8Xpis1S/CkTE4Wsui9ONkMr/SW1hpj7zMfIKDmvbueVtOCAIZ39gfldm7Uy2ezv0xt/+EkUOy0L2mbF9ieg7Fbhb9+NTAy4Alcf+2AQjvZ2unrMQbf050ye1qsexiTaXZK6bUjKniAenepM03xPaoZG0h/HIBeY+NBcV2j9rCejbWivXPqs/Xi1ozgb0c5C2mUwuiP2SRGURiDOlSlnlOgCFXyd79AFOgjZIdfZtoImZHUtP9kl+XummfIGj+CCJbX3sUjQWebA9QhtVZSZw4wYZQIvXd3b0E97e3DcpCEgZY5FYDO5TcddD2amMmkiNrE6UjLZ8SMLvgKrDTdRE9JmpqGMkTIyFcVbikDG8ZmhFgwzqvTLDNOmawAnjgITI30S7uaol2lPjARCivckN/JpmHS4vXHGVDzjuweXN+5IM+Dg5GCVnBb1KVxFDHwE1k+RDys8J8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O92nItWLfGujJK9h7g/B6+ZK7Yfwsndbljz5RBG5/oBOZyST9jxcrMeKkANadEQL4eM4LilFjLrAkMhy8+vzLsFia1QBiODFTemaRhZsVvfQQfsJ4Q8BVFxeCZyTDuMXTdyYy0l97QvpeVUMxt7AlsY3PLLdo7jvEf1gWUU/IVFV+/OfB0MLNqWDGB79ZqaAJwv9Yatr4Bz7/V30g34wBBt+WE+6x3D0rvV/9IjzzLdyioHLqBC1tWqz/N+k9JWFlTf+6Kh5DunnE6aeMmx3XTv9LtIPCuXcnEEhXgmMlRbO7LaGd3lzP9yUHn6Noch17ZHBJCm8DosXqu0575i25pjDviKT2DHyXLem6r2pUMu5NMQgS6M7JIQ1vV1zQoF0SdCaF+uzHs7UNTWq65L4Uw2MU5edf7G7bE61h60NF3LpFUmyZVELPz/t8pAUjbdz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:55:08.3254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b32c57-ab61-41f0-a640-08debfa2561e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
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

Add helpers to handle MES compute queue resets when multiple queues
are affected.  Can you be used by both KGD and KFD.

v2: sqaush in updates
v3: squash in userq updates

Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
Co-developed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 140 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |   6 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  |   2 +
 6 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index de8c85dfc4c6..960d192076de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -34,6 +34,7 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_mes.h"
+#include "mes_userqueue.h"
 #include "nvd.h"
 
 /* delay 0.1 second to enable gfx off feature */
@@ -1976,15 +1977,25 @@ int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
 			       bool use_mmio)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool reinit_queue;
 	int r;
 
+	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) &&
+	    adev->mes.compute_pipe_reset_enabled)
+		reinit_queue = true;
+	else if ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) &&
+		 adev->mes.gfx_pipe_reset_enabled)
+		reinit_queue = true;
+	else
+		reinit_queue = use_mmio;
+
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
 	if (r)
 		return r;
 
-	if (use_mmio) {
+	if (reinit_queue) {
 		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
 						  RESET_QUEUES, 0, 0, 0);
 		if (r)
@@ -2159,6 +2170,133 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 	}
 }
 
+static void amdgpu_gfx_reset_start_compute_scheds(struct amdgpu_device *adev,
+						  struct amdgpu_ring *guilty_ring)
+{
+	struct amdgpu_ring *ring;
+	int i;
+
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		ring = &adev->gfx.compute_ring[i];
+		if (ring == guilty_ring)
+			continue;
+		drm_sched_wqueue_start(&ring->sched);
+	}
+}
+
+static void amdgpu_gfx_reset_stop_compute_scheds(struct amdgpu_device *adev,
+						 struct amdgpu_ring *guilty_ring)
+{
+	struct amdgpu_ring *ring;
+	int i;
+
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		ring = &adev->gfx.compute_ring[i];
+		if (ring == guilty_ring)
+			continue;
+		drm_sched_wqueue_stop(&ring->sched);
+	}
+}
+
+static int amdgpu_gfx_reset_mes_kcq(struct amdgpu_device *adev,
+				    struct amdgpu_ring *guilty_ring,
+				    unsigned int db)
+{
+	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
+	struct amdgpu_fence *fence;
+	struct amdgpu_ring *ring;
+	int i, r;
+
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		ring = &adev->gfx.compute_ring[i];
+		if (ring == guilty_ring)
+			continue;
+		if (ring->doorbell_index == db) {
+			fence = amdgpu_ring_find_guilty_fence(ring);
+			r = amdgpu_gfx_mes_reset_queue(ring, 0, fence, use_mmio);
+			if (r)
+				return r;
+			break;
+		}
+	}
+	return 0;
+}
+
+int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
+				 struct amdgpu_ring *ring,
+				 struct amdgpu_fence *guilty_fence,
+				 struct amdgpu_usermode_queue *uq,
+				 unsigned int *hung_queue_count)
+{
+	struct amdgpu_mes_hung_queue_hqd_info *hqd_info =
+		(struct amdgpu_mes_hung_queue_hqd_info *)
+		&adev->gfx.mec.mes_hung_db_array[adev->mes.hung_queue_hqd_info_offset];
+	int i, r, pipe, queue, queue_type;
+	unsigned int num_hung = 0;
+	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
+
+	guard(mutex)(&adev->gfx.mec.reset_mutex);
+	/* stop the drm schedulers for all compute queues */
+	amdgpu_gfx_reset_stop_compute_scheds(adev, ring);
+	/* suspend all will determine which queues are hung.
+	 * reset detect will return the array of bad queue doorbells
+	 */
+	r = amdgpu_mes_suspend(adev, 0);
+	/* if suspend all success, it should no hang queue */
+	if (!r)
+		/* always reset the KCQ/userq since we need to signal the fence
+		 * and we could be stuck in a loop which is preemptable.
+		 */
+		goto fence_reset;
+	r = amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
+						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, 0);
+	if (r)
+		goto out;
+	if (hung_queue_count)
+		*hung_queue_count = num_hung;
+
+fence_reset:
+	/* reset the queue this came from if specified */
+	if (ring) {
+		r = amdgpu_gfx_mes_reset_queue(ring, 0, guilty_fence, use_mmio);
+		if (r)
+			goto out;
+	}
+	if (uq) {
+		r = mes_userq_reset(uq);
+		if (r)
+			goto out;
+	}
+	for (i = 0; i < num_hung; i++) {
+		pipe = hqd_info[i].pipe_index;
+		queue = hqd_info[i].queue_index;
+		queue_type = hqd_info[i].queue_type;
+
+		/* reset any KCQs */
+		r = amdgpu_gfx_reset_mes_kcq(adev, ring,
+					     adev->gfx.mec.mes_hung_db_array[i]);
+		if (r)
+			goto out;
+		/* reset any KFD queues */
+		r = amdgpu_amdkfd_reset_mes_queue(adev, 0, queue_type, pipe, queue,
+						  adev->gfx.mec.mes_hung_db_array[i]);
+		if (r)
+			goto out;
+		/* reset KGD user queues */
+		r = mes_userq_reset_queue(adev, uq, queue_type, pipe, queue,
+					  adev->gfx.mec.mes_hung_db_array[i]);
+		if (r)
+			goto out;
+	}
+out:
+	/* resume all will enable the non-hung queues */
+	amdgpu_mes_resume(adev, 0);
+	if (!r)
+		amdgpu_gfx_reset_start_compute_scheds(adev, ring);
+
+	return r;
+}
+
 int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
 				      unsigned int cleaner_shader_size)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f9175faa64ab..8ef2ef394e9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -36,6 +36,8 @@
 #include "amdgpu_ring_mux.h"
 #include "amdgpu_xcp.h"
 
+struct amdgpu_usermode_queue;
+
 /* GFX current status */
 #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
 #define AMDGPU_GFX_SAFE_MODE			0x00000001L
@@ -117,6 +119,8 @@ struct amdgpu_mec {
 	u32 num_queue_per_pipe;
 	void			*mqd_backup[AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES];
 	bool use_mmio_for_reset;
+	u32 *mes_hung_db_array;
+	struct mutex		reset_mutex;
 };
 
 struct amdgpu_mec_bitmap {
@@ -642,6 +646,11 @@ int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
 bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
+int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
+				 struct amdgpu_ring *ring,
+				 struct amdgpu_fence *guilty_fence,
+				 struct amdgpu_usermode_queue *uq,
+				 unsigned int *hung_queue_count);
 void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
 		void *ras_error_status,
 		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 370e8d159b6f..ec4d9a1e029a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -252,6 +252,10 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		}
 	}
 
+	adev->gfx.mec.mes_hung_db_array =
+		kcalloc(amdgpu_mes_get_hung_queue_db_array_size(adev),
+			sizeof(u32), GFP_KERNEL);
+
 	return 0;
 
 error_doorbell:
@@ -279,6 +283,8 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	int i;
 	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
 
+	kfree(adev->gfx.mec.mes_hung_db_array);
+
 	amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
 			      &adev->mes.event_log_gpu_addr,
 			      &adev->mes.event_log_cpu_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1a214c274ad0..32e01eb311c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1908,6 +1908,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.me.use_mmio_for_reset = false;
 	adev->gfx.mec.use_mmio_for_reset = true;
 
+	mutex_init(&adev->gfx.mec.reset_mutex);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 5beb0ae980d0..247bcb7034e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1606,6 +1606,8 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.me.use_mmio_for_reset = false;
 	adev->gfx.mec.use_mmio_for_reset = true;
 
+	mutex_init(&adev->gfx.mec.reset_mutex);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 033f15e21ad3..7f8e43130bd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1287,6 +1287,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	mutex_init(&adev->gfx.mec.reset_mutex);
+
 	return 0;
 }
 
-- 
2.49.0

