Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDCDC52D1F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED15E10E915;
	Thu, 18 Jul 2024 14:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RNdJ5S+x";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E26E10E90F
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4ZNeOjFbYs13sXzucgEXnLN8XhQ5Ql4RL4BBjzJWMnaHE+V67The2ajIJjOSra7JAgZQkUzu5SjAPhI8ehTzhFSoraAhR94QT/sbpA20EIPfib6GEOrnXLFQTFjCr9+9SduE7FFGIM4bPYLyPz/Ai7zfLWBxH/BCVy1h/XOQg9HS9nbe33CvCFrmnyoBQ3Y3tgP9dAqxskcYEjV4Npq8BweB1d7jEcah1eE16Go+bpw58pgNyXOK5GjpUngVQlMFnOwAuj/0CsWZXcmrkZFrJUCSuBOHSalK7c+DKDqaTxRR2aKswNcUyjLQOdsX995INWzJ52rhg1EiaOrsrTNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8ludb2xP7Ia2CDy3zIr7SP/HqQf1S7ujlVjeCwODtA=;
 b=VcUaG415qps522nw2RQVOLOVHY3txRjIl/xf1hXSh/AbKn9QTSMgvb6nDz6XX9uTORunRRClbFYtdzktRrOr8PO0zYBa6Zn9T9UwiU8br/e2zlMrpbE6S1v4qt2TkdIyuyBWXQ7CoeiJYVr3dtddSqh1XCQTv9vO7+cZYAV/7iBFOa+dcj784W1c8hGXoto3AKdTYebL3MBV7GBUrvjnb+uqeXTvv5an0wbzMCKWcZJxPK/9mOMQcr4siRsssD9JUvoSHFjsByth/n3Qh7vnE7jU046zTgGmNrf1MrSUd3ElK+vr7MZ1AeP4hb1Noz1axRDcIeUnQ2GZn4CBpykPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8ludb2xP7Ia2CDy3zIr7SP/HqQf1S7ujlVjeCwODtA=;
 b=RNdJ5S+xhdcoc8iLD+9Cfa5DLhgH6pGRyn8cN92cC3tPWJNJskRWwrA/1Me/jAe6Oujg2DJOldW730X5s5FpWcUIl1uG1fKXPLhm5hS/D35oZqlhpDQxKjZHARj/F27hUV7HMAwrVW/BiJoxD2nNUU4N3wgGrztaZ+ds+8l72Yo=
Received: from BL1PR13CA0072.namprd13.prod.outlook.com (2603:10b6:208:2b8::17)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 14:08:08 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::ef) by BL1PR13CA0072.outlook.office365.com
 (2603:10b6:208:2b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/34] drm/amdgpu/gfx9.4.3: implement reset_hw_queue for
 gfx9.4.3
Date: Thu, 18 Jul 2024 10:07:27 -0400
Message-ID: <20240718140733.1731004-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: e4af1f91-9c55-4ca0-2dc6-08dca7330d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j1+qA103GK6sSM6MF2fh3DWdE2nhwvvQLzeLY6UpkVuky1xKk3Uz17hRyUrV?=
 =?us-ascii?Q?l1h1UI4K21HOXp588jybsgGXQTas/QcCDE3d+aFPG/r++pNcA0Ve2nG44q9d?=
 =?us-ascii?Q?Jp9VqAs5Qpu0Wqc4Khtcjhp4neqJvEU4kOGPdG8vWURTtivRhvq1cQq67AHq?=
 =?us-ascii?Q?12T8ekv0yTfnN2FlS5czoxWEcQw82qktzc6QeFAP0AIqN/dC/cB3hkHn/Msv?=
 =?us-ascii?Q?KqzMg3opovp4pRsTT5sR23tgWrvLg+RS1ka93uXag+D00skZgG536IWeykhQ?=
 =?us-ascii?Q?e+AUoLUEVSB70aXfR532RpciV7mUuEfQ02MCk49QZMsj45h6aw381VkCYcXx?=
 =?us-ascii?Q?XwBvLaWXUTmUqh/gAKO1cgotp5Y8H6UZHOKBIZ+qR2LjhuQD2xauEQb9HltQ?=
 =?us-ascii?Q?X2+kbFY7llcexlNvnH8qB7hr61LJSvhF2gF/H4yWJ3Qd9xDQiVETcxoGf7QK?=
 =?us-ascii?Q?ntVTFUzEVfvziUpGRMcudEqI9xwf0+8t1Bn0PRRbMMOiT30BP/k+S6GujWh1?=
 =?us-ascii?Q?g+AZ1azVJlK/Zfv82oJnBy0P3wG/LKmbYJI4kUMBPin9IgkM6lGfdlCaP5Nl?=
 =?us-ascii?Q?VFv1IqYtCR/IxMf8f69NjmCjb2GWwrLANxfj0TDeL3sCuDgmmrcQ3hVxMXEv?=
 =?us-ascii?Q?QBQW9HqgaNTwtV6dCzmlAedteXqyIa+zsbY/D6mQvNQB0JAbcFWI8NyFR8wW?=
 =?us-ascii?Q?vjL3wBxHpZ4xlTUxxZwJMUZQgI38Q9+B0OPY8oic73WHxmVf+4uHhzljdLlA?=
 =?us-ascii?Q?NNuJzG+LrRWmWZn7jHvCdVI810ICDm/0Lje9tKuTl7W4sqI0k/7ZjgslRlXe?=
 =?us-ascii?Q?DWl3QkpAOqznlDg/9+WAUX4gcbfOUs3tptc2bGm7kG3O4KcVyetKdCeXleex?=
 =?us-ascii?Q?by+NisHvZJtVo6AvSmM61rtRZySqfcJfXHsYFtLM/1b9iUXfbPLxWuRnkWQK?=
 =?us-ascii?Q?w6G9wCd3Jnk3z9O2TvPNtWJBYiEQ0Gr/7crGq10GLxxfQ8dsR61UiU9IwXRj?=
 =?us-ascii?Q?yJ7vWWLziyzj6PRD2cq/5cN2/gT4dOBRY7n6N9rPp8rxGftpPV5XBgjnO9uP?=
 =?us-ascii?Q?ez8ItVopm6l6Ly5B+CxapkI+IyG7SL6cyi+uoxa0j8Yq2GVoR50Q6gqL4L8X?=
 =?us-ascii?Q?mpUrGlNg+HHQcNS3qldeQZXo8tM62q3Mv+x74iafv8pavjjg7DSQu3AqWAdQ?=
 =?us-ascii?Q?JS5IaiL4b6yQGGLG7KrQu9fnRFpy0vTWzv1H9LSnD+yJZREX+ue+ZITm3FUc?=
 =?us-ascii?Q?2n205ZVvagPeiaNoa/V6XFlHjsQJIQfdh1dM7JJM8jfkPBfL1u5vaeHAAjhX?=
 =?us-ascii?Q?vnToJc11bbMR8yEtq8oND76X/nisP/rWGyAR7Cx6rHfMD79FN+vcR63W2uFb?=
 =?us-ascii?Q?eHt3Us4tvIiRdo+GygS9XurQ8mxCYXVBd5p/T20dEFe6Khoy4Mjz2rMv09rt?=
 =?us-ascii?Q?/yH4ZiES0canU4tdHTq4UMasoJ1tUerm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:08.3911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4af1f91-9c55-4ca0-2dc6-08dca7330d19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Using mmio to do queue reset. Enter safe mode
before writing mmio registers.

v2: set register instance offset according to xcc id.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 717320d92e68..267d5998bb80 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -71,6 +71,8 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev);
 static void gfx_v9_4_3_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
+static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 
 static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
@@ -182,12 +184,46 @@ static void gfx_v9_4_3_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
 			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
 }
 
+static void gfx_v9_4_3_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t queue_type,
+					  uint32_t me_id, uint32_t pipe_id, uint32_t queue_id,
+					  uint32_t xcc_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = kiq_ring->adev;
+	unsigned i;
+
+	/* enter save mode */
+	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, me_id, pipe_id, queue_id, 0, xcc_id);
+
+	if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_REQUEST, 0x2);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSPI_COMPUTE_QUEUE_RESET, 0x1);
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout)
+			dev_err(adev->dev, "fail to wait on hqd deactive\n");
+	} else {
+		dev_err(adev->dev, "reset queue_type(%d) not supported\n\n", queue_type);
+	}
+
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	/* exit safe mode */
+	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
+}
+
 static const struct kiq_pm4_funcs gfx_v9_4_3_kiq_pm4_funcs = {
 	.kiq_set_resources = gfx_v9_4_3_kiq_set_resources,
 	.kiq_map_queues = gfx_v9_4_3_kiq_map_queues,
 	.kiq_unmap_queues = gfx_v9_4_3_kiq_unmap_queues,
 	.kiq_query_status = gfx_v9_4_3_kiq_query_status,
 	.kiq_invalidate_tlbs = gfx_v9_4_3_kiq_invalidate_tlbs,
+	.kiq_reset_hw_queue = gfx_v9_4_3_kiq_reset_hw_queue,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
-- 
2.45.2

