Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A25C44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D5E10E953;
	Thu, 22 Jan 2026 08:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="powR07wC";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7129510E954
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 08:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UD08s67WMZwMq3dPnATQcIY20PeCrN1ImhS1iYrBZ+2IcJ/gKiNTRXI0e3Yqt7hXzvqeQH2mMz/Z6bqv9IGQRy48mAnLi69UJbY1euflSzO3Wi9xJGlINwwgj75+c+y96x5PkFIyISuHSG76znvSsfFFkR7HDKPXDsXdb9LLo8WFlExf3dNO76Ih3fMSFn9VnvtHzCzRmm1DlV5LzQMuegwl4+9YAZvEbk+M27fwRbOLhA3tagn32XRpQxO10W8XRkQ/mjO2UXz7UIeAryKwugZj8GvomNXJFK7s9T5JquXqStvQo3tK/xIkbP9fJdzAHzsNtkYWbWkv461+hrD0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOziOhLVGXM9BBMJfyy5523c9JH5FvdLe2UUgjibykc=;
 b=Nz/SLigVN9ldzu7jbheUM/iUZtBTwq73Fa/YCbsWGxiOXlU/CpdmSzB5wSt6T67IcEh8muEwUeSzabKFAernx+6JYEnzJwnQLIbgVfw3ClPtabsnrltvGLKnIqmceVCiEY1NW+Mv584/lnAC4KpRmrLM83t1ej0C5wkeQY/uTULAWSXN/kbwW6at53B5DX0Xo3OutDcMJb1x6mpKagDMT5qZgA4oIEALdyYG96G7p7Rs8NNs/3Q3bg0qKCYEtGnoASsSxZKWXrIaxSUpOee/+oNPpF4/mgHRPQXXpFem0zzpXZm9O8dyYFka1ldbGZMaglj6jnx1NWAm0Zd6dNojiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOziOhLVGXM9BBMJfyy5523c9JH5FvdLe2UUgjibykc=;
 b=powR07wCPiLS0zeiLcYO9gCiZPAdlVKekANvYJsp2lUCM/3JVUWTCX9JYM45a3/qqRiHxjceZbxo3++zb+WysWrDAuI7N6qTA8AmoumGACClHdSICmFyLtOYXwyww7dcG9mweWMSqGBPJctn3jEVDC8W0iEDFBZ/ed4IH2krxo8=
Received: from BYAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:a02:a8::21)
 by CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 08:58:19 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::81) by BYAPR03CA0008.outlook.office365.com
 (2603:10b6:a02:a8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 08:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 08:58:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 22 Jan
 2026 02:58:17 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Jan
 2026 02:58:17 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 22 Jan 2026 02:58:11 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 5/9] drm/amd/amdgpu/gfx12: Implement GFX12 MQD update
 callbacks for GFX/COMPUTE IPs
Date: Thu, 22 Jan 2026 16:57:15 +0800
Message-ID: <20260122085738.1542800-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
References: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|CH1PR12MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 700b8493-e316-4523-6485-08de599462eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mwKyTxcanufbZrGwEdM2eHO+K35gXN8QhTkBh4yUq+0cZ/knp0YAVqkgIi78?=
 =?us-ascii?Q?1gIg/yQxjOhZb/kwlQIJ4WehrZtJjj7kP1dhR4UFxuuEkpchRmi4Xm2VAyON?=
 =?us-ascii?Q?6jJ4lG8k6GeHvSIGFduM3hgQ1zJqx3UuIjM8q1Cohy/aZ8eEyAzyOiNv94uL?=
 =?us-ascii?Q?s6b9srz6psiW+wvGF+2gZrUTtwyjVXM2sDixx5PkOTXFzrRWzh+w4futieP5?=
 =?us-ascii?Q?eqCk4wQxitUTinhyPmCHGnU4TZPWFbUJT1kY2PueFb3ykQg9Ve3hSyQm8T/P?=
 =?us-ascii?Q?vouOchChhSJMsGU6ivhTW+W1EDuLXL3cf5F8nATV1BcisG+AZMS+wBKYLwjm?=
 =?us-ascii?Q?4Gz6TC8C1nwoG3sLzZG8hXvPKbK77e/lRT/67QbaOM903lAxECU9biE3WA0r?=
 =?us-ascii?Q?3dpOVYT9B/oO+39fNRjMao9m98NPxMMpM26g/1IHGONeXtjCDBeL+HLopY0J?=
 =?us-ascii?Q?ElbjT+29fS1ZwLQuYo9OxORTgXfuJwE34YtiMBqcPTV/LPMqa2IQj+0WLJKq?=
 =?us-ascii?Q?pycHI7jwhBCpDw0xuen0jGNJBCbOTm//i53i6gQ60nXxQasWL0XFNMX6z8al?=
 =?us-ascii?Q?nUDZsA7LYvBw/bN1p947RzBcaVD/gfnYY8KqpVw2usPsrES3CwmzecYaz7vU?=
 =?us-ascii?Q?4J74kyD0Uc8sEh+orgxtqiFb5EMlR2E9yDMrd2rMN6hV0KVq2Esv5qRVU6GO?=
 =?us-ascii?Q?4LO78qwT0yHx1vGem2BgRJX/smjaIkwM3pnoqC1zMrQ708Abh3vm5fC0MTsp?=
 =?us-ascii?Q?zrXBFngLU4dNE7BHjnfZ4Sb+b2qL6aJFfrxmLhgmx71VzC3LGjulM2kPpU76?=
 =?us-ascii?Q?LUsyvPHOm1Ig1L3/LfTw00X2GaX2WfXrQ/dA1s0hsNryfluDr5+YAxOXs6wa?=
 =?us-ascii?Q?buaDJOOSLF2CKBXkqWNV6vfeinfmJ0Sdm8dfZSXPl30pNs/SJtNZsYQgtYC2?=
 =?us-ascii?Q?fwPosJaWr+lEAfxxOFzu9cUKXIgqtQtgeLY62DKDLw7cLiymWOqJGAZhbpPx?=
 =?us-ascii?Q?xNqVZo1VsGTkRG8WscXaGQEibkALxTAz9MJIKeCtqpk3pkUVunVzHJInRrtf?=
 =?us-ascii?Q?zE38ueRlvI/mJz5yMLh+vw/k/ORbngpRfxK96FmfEgiPBz6Ce9eK7cAeI9bd?=
 =?us-ascii?Q?cXeco0GLMF6TWlnQHK/8kKyoK+ktJdK2I43pbpipD7EQ3KO1x+8kdF+zPWEw?=
 =?us-ascii?Q?tsrTv9TT1A6EG+pV7a2ZVUdQsMhrq5yunYDqkzmGP6Xk4xSxmg9x+fq79l0R?=
 =?us-ascii?Q?ozQW0ymmpwBi+0nXuVwAZzen/8yh0uYkFi8hu763T049WOxWkGmltphhfCrK?=
 =?us-ascii?Q?OuaGD3b1Gmq0kwX8d5kMNBy3RQaWQNdydvg0lVK9TdhM9I0++0wlopevTsVd?=
 =?us-ascii?Q?OaGs8uIYvgtYcojErIsXAYOcr5v7j/kNA9husCMCHg6OQDvVB0Po/THJQ7AN?=
 =?us-ascii?Q?/5+bVlaFlRt2XzJYFa6KoOWWhGxU9AWZRyqP1k4CN2SvAQv81kesSUlL1icL?=
 =?us-ascii?Q?4h6sj6r34jGUFLNQ4vON/PIXTXS4xaE/NaqP2xoD3lugeBjZ3kuORkNUDuSl?=
 =?us-ascii?Q?RLvlLSRISqStTaScIYIsK9q4jPEgUr9FoCpAu0arJBpRT3BwHzCaZyJSCO1O?=
 =?us-ascii?Q?syPh1eq6sJMfQhyXtQ5rjlXsjDZlroZ8cTBqju+0kiG99f7XI4Wv4HK+eXBb?=
 =?us-ascii?Q?WsKlxg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:58:18.1476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700b8493-e316-4523-6485-08de599462eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9576
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

Add architecture-specific 'update_mqd' callbacks for GFX12 to support
runtime MQD priority updates.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 74 ++++++++++++++++----------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6cd16f016c37..a0180699e492 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3110,11 +3110,54 @@ static int gfx_v12_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	return gfx_v12_0_cp_gfx_start(adev);
 }
 
+/**
+ * gfx_v12_0_compute_update_queue - Update runtime-configurable queue parameters
+ * @adev: amdgpu device pointer
+ * @mqd: MQD structure to update
+ * @prop: MQD properties containing updated configuration parameters
+ */
+static int gfx_v12_0_compute_mqd_update(struct amdgpu_device *adev, void *m,
+					  struct amdgpu_mqd_prop *prop)
+{
+	struct v12_compute_mqd *mqd = m;
+	uint64_t hqd_gpu_addr;
+	uint32_t tmp;
+
+	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
+	hqd_gpu_addr = prop->hqd_base_gpu_addr >> 8;
+	mqd->cp_hqd_pq_base_lo = hqd_gpu_addr;
+	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
+
+	/* set up the HQD, this is similar to CP_RB0_CNTL */
+	tmp = regCP_HQD_PQ_CONTROL_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
+			    (order_base_2(prop->queue_size / 4) - 1));
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
+			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
+	if (prop->kernel_queue) {
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	}
+	if (prop->tmz_queue)
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
+	mqd->cp_hqd_pq_control = tmp;
+
+	/* set static priority for a compute queue/ring */
+	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
+	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
+
+	mqd->cp_hqd_active = prop->hqd_active;
+
+	return 0;
+}
+
 static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 				      struct amdgpu_mqd_prop *prop)
 {
 	struct v12_compute_mqd *mqd = m;
-	uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
+	uint64_t wb_gpu_addr, eop_base_addr;
 	uint32_t tmp;
 
 	mqd->header = 0xC0310800;
@@ -3170,27 +3213,6 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
 	mqd->cp_mqd_control = tmp;
 
-	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
-	hqd_gpu_addr = prop->hqd_base_gpu_addr >> 8;
-	mqd->cp_hqd_pq_base_lo = hqd_gpu_addr;
-	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
-
-	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	tmp = regCP_HQD_PQ_CONTROL_DEFAULT;
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
-			    (order_base_2(prop->queue_size / 4) - 1));
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
-			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
-	if (prop->kernel_queue) {
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
-	}
-	if (prop->tmz_queue)
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
-	mqd->cp_hqd_pq_control = tmp;
-
 	/* set the wb address whether it's enabled or not */
 	wb_gpu_addr = prop->rptr_gpu_addr;
 	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
@@ -3234,12 +3256,6 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;
 
-	/* set static priority for a compute queue/ring */
-	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
-	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
-
-	mqd->cp_hqd_active = prop->hqd_active;
-
 	/* set UQ fenceaddress */
 	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
 	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
@@ -5669,6 +5685,8 @@ static void gfx_v12_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v12_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v12_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].update_mqd =
+		gfx_v12_0_compute_mqd_update;
 }
 
 static void gfx_v12_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.49.0

