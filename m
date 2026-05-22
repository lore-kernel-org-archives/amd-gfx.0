Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022B6CD5BAF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4DC10F48C;
	Fri, 22 May 2026 00:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NOwU9+2r";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010030.outbound.protection.outlook.com
 [40.93.198.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C341710F487
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOUPkICmM0wc7vKXeCvrlBYMj5lZQ3FxhUNjHTZ2hadnIvM+AP7FLI90XgMAWQNsJQTsmnsQk7ubMGG3RkIEooaygFpl8YAenP7VfPJ4USwWWon9GNEJ/uWJTTM+Xm1a66FiDl/Q7+dPVBW+O74R/zTc9Wac4NTYs4vXMNTws06F82WnpcRX2vF96MIZ+GJFlc8kr0VTjxuhVSD3Kor6d2kVV/D+M7PxlemD40ssBGvMY+Vvr/i++3VZeYgKwGeCtxk9ZDRU8PzF37BECSbFfJwliEmE1SqOaWun0N7X154GHHx4k3UEkJtiY9cBZbraNhmVLj8uQifDSAp1zjTfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYA0moBasutak/RGzayGEqtX7MJt/ZYC0XqaD784jL0=;
 b=AVMNpbHJwWZqf43ZFohL6SqVg7Pma/Q3AzXUlxdhSi8bDgmd3KcEzUmibJCE7he2B1mT9qD5x5i5nwPGsJlu9G5R88AzJHGQrkDIpfTj5QGPbEfPraUn4ObkRP81PKStxtqUp33yN8/q5s2EDZTKwW1WYOanA6rXfprGADU1tdlAWOakONSGZYWLcq2t2O5W9WJNMIf6u/5PdCPOI7OegYr7Z90J4AkVXn2u/kxDERAWC9/WeglONa2a3iZ6F3tiLKVFSRS4ilt6jubL4memhogAP5ORb4sPJlmT7EgxuwVE7Hm1zzZ11J7iqZmExAABlchbzpeSKNdJvM8Y7ETJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYA0moBasutak/RGzayGEqtX7MJt/ZYC0XqaD784jL0=;
 b=NOwU9+2rb5bfReJ8W6nfo9qgoYg9H0fhddxaSsmDH4zdAWgyLNjqvJtwYLsrGEq0JU5pMM+Vz8ClNATgVDC2kxQSoUu31rfxHbc/yhb0mvPhm2+cDQhVmpfGzby7cUbdYFcl86b9X4GTosERuxPz+Xx9AEJ+EgoCBnpwkAEcpPE=
Received: from CH2PR15CA0016.namprd15.prod.outlook.com (2603:10b6:610:51::26)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 00:22:19 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::59) by CH2PR15CA0016.outlook.office365.com
 (2603:10b6:610:51::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:22:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:22:17 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 37/42] drm/amdgpu/gfx: add a common helper to handle MES
 compute resets
Date: Thu, 21 May 2026 20:20:43 -0400
Message-ID: <20260522002048.98506-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 851622a9-7ee2-4949-c48a-08deb7982f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: QyYWuBTFLZ59F4iosDHSrt1rIfWhyLVFWKIQhqED7IEiSzQAXvqzGoIDLhE/lNbnTpZwgzNUQCoqYvr3MZ50Gvtj1T9sLkL7m/Dbl/QbmpEZnEoKF7MAqwabPAEOw5nVlBlrqnOiJoejhp+vUHe5M/txTyil+3McVeEI0mq3j34zrSHcS9DYgYZUY1vOXZnfiwIJ8N0MViF0IapYjuhzFAGIBaRYKfpwYN0CTLKKDutiB8JEB0yAE+Y001bm0z5XPwdei1xLrd3a98XgwijeWvHYOMFM4A/gdeU6jBmN1CUaf+wrwW7HFszIpC5VIpEOkkCjZfmNT3LdClb23oy74a6vuCktbxlODlBPvbCRN9E2DdvKMyydTQ38Lr+FxkInqJ82AMNq1v6TOQlCABbZbaTKEaHxbKzcVH59PqwiiGCsY6q5OOOjXyfNa7L4fGaz6DNZJt6KKDB6GgNokFUgBPYl/NnZMKalFVIjOueSc/eq1XrWevqDauXujBvvFzoJT+K8iTurtzSHiPIJrvI1rfrW83UZ2SEpbZUqeJM1Z4JbxkRa0CCiQhc2O1/fhNf+Uw/5DNz0Ifua6/WMLS38OR3wWnBZHimp/CGXq6HovNqhgBKaYEABF4SfyNm9CezM+eAJx94o3haf7ZszLzhoBWMpWRxyRdBRIpUU43C4ZO89XkbeQGbvdk1vKBYROIjf3QGjGEPcvHmZyIOijV10Zbj4O+sjfSHGkLiOLuPxT4M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /7MFlLGwf3quEC1ZxqtBhMCW2xmne2XeSBynkPdgK+WOa75sWx2++iVO6R0ymqspgMChwlwykuiXY6FopYc4OJZR61/4uRQ+Nk/MuHSZeHmKxGvjuAhB4kI8DLmi4ereJjqqUqNdVg269VexdRh5AGXEJU84khfdyaaSKeRO6Pr+JHRPzuzJ70RFzwB3sk7rlxG7fLwtirbjvTF18h+KJhIhf1jdIO4GoOtz5PfqZrIONxwZRg3nJvEZ/6PSx6OHj9OGl+h1ciim6U2MZ4RIujiesgzuTgx7+YvMUORqcL4XVIUWIMERy86/411IeP6+ECeLn9/9sYFtTecd8KI2tGErc9ZLRRCqOmQiN9Hkak6ayvlX7NX/T4tPJhDACLlp4qDUC2J++MnadcH/BWmcg/jh8oWlFKF7+Qe5sLIefALKlAb2tCD7HaRjBWp5mIE+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:19.4253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 851622a9-7ee2-4949-c48a-08deb7982f96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168
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

Add helpers to handle MES compute queue resets when multiple queues
are affected.  Can you be used by both KGD and KFD.

v2: sqaush in updates
v3: squash in userq updates

Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
Co-developed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 140 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |   6 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  |   2 +
 6 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index de8c85dfc4c62..960d192076de8 100644
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
index f9175faa64ab7..8ef2ef394e9af 100644
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
index 370e8d159b6fe..ec4d9a1e029a7 100644
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
index 1a214c274ad02..32e01eb311c3b 100644
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
index 5beb0ae980d0b..247bcb7034e19 100644
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
index 033f15e21ad33..7f8e43130bd28 100644
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
2.54.0

