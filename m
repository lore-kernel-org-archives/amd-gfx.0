Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E66C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EF2410F2B9;
	Fri, 29 Apr 2022 17:47:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A90910F119
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVvf4I3Zskl2iNBmAQKbTvn7hZOEAI4CLop7yemGucM3BO9UU9Snkyhb4/akeTUHPxsvN1jWp7li5SUkSGRDwQmylImlZbojow+qxjMpCZjiaJE+BjOGPgkKKsWhriJAcqdfuy1pBdgmxbuh3umVWW7X51O5VOM2XC7QhCK5QyXyiTJQ0WC/TMuHzmd4nxWw80ywIWeoyWsQoev5EMC/9fMHajb8WbR/U7bQCfbPJzgd+ggGSFXNnBjmn96tnsc7TL6NlpZObAZYU2RrGt9ZRWMCWOahkBtQYezA1EipTsZFRh4uYMfLojtY3tjg1exCzkqPnbXFH9u92ljnpb4y4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBeB+I9qsnHO2xJ7U93Hl+hECLnb978Lsa2MlhmRWTM=;
 b=jxDGgpoDnXnCNnPCCdKNJU4nhMn7epGNn6gy+9NZnz7vZMGKeIRFqBMeZaiw7q8IRnqCp2prMZlp4mDGIab9WlOIJOW6ehcI3B0cQj6/zZtC87xouG38xLaQTvtiqL4eGirMDlffraXL4Qwz2Y/FKT0Ti9zyrmJxcSAEcTWrgB8aR5RhImZSjNUHzSLgRPQW0WyihZM0DNNHUj+icFkY3Lbt7S3owO2NVo5P5rfbJeEsxnz0T5CQ8qCe6E1UkEDwcRpMIyl0LDzsbVtffi3ox3SXP3gbY/LRZ26TxdHWwBavwvSdyRyoY/Q6wwLNYX7uyqzS0rjxyAk2mERv/rluPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBeB+I9qsnHO2xJ7U93Hl+hECLnb978Lsa2MlhmRWTM=;
 b=upLcmz8V5AaXXRHSDsLGveia0yatkuZ7cQ4emtsXxPvdwq7BN3r7j7GE1RM0I/N9udgiUqmeqRUwOlOIcuIaDtexzfuMQEYGeRGb1iAXk5dcIt4K6VyvMLaM75MB+oafKbVGpIK6Cvg1YfB/LATrMfmcN3uT4upOVWDcs1fxQE8=
Received: from DM6PR12CA0023.namprd12.prod.outlook.com (2603:10b6:5:1c0::36)
 by MN2PR12MB3150.namprd12.prod.outlook.com (2603:10b6:208:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Fri, 29 Apr
 2022 17:46:50 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::47) by DM6PR12CA0023.outlook.office365.com
 (2603:10b6:5:1c0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/73] drm/amdgpu/gfx10: add mes queue fence handling
Date: Fri, 29 Apr 2022 13:45:32 -0400
Message-ID: <20220429174624.459475-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7075cf8f-408a-4953-07bd-08da2a083d0e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3150:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3150573FAECC6109A640A0F1F7FC9@MN2PR12MB3150.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AIBn54thibfyeIQcnabBEd/bvGulefQlzj8hDKSxq7AMjZ9uc3pbM+ZowJHlBJG3tsgfd1Q/Ct/KO3V7dmBimMRBGSM+/A2tErIC7G1M08udeThlslEgpunCIZWVrNZIyqy+KPyd1cP64lKRoqqAb0sNoSGwHRKVB72iEFYsWXTGHlZVhFxlB1rWXuLb25arKrja7TGgmdJUx0oGh0GfY6y6OYSdR445tcNtCGBjEM42WjQ3Zi9f8rUAnxknOvNv87aVVtD9g/50UqZ+bEgyaa1sfRnsZtUDsRQCsgfyUH40mwKsUNdLsvEpdUgLR1qSqU3+qLZiIkpFDeeevr/BTFz1jyy1IH3OLYru7eIG9CQLqR716AOtbzjyk0Huj/Y/V2zIPSbk5akvVl3SoKYYmba4f7f2gg/1tbnrtVF/N1jP6YDwy5l+qGSdlhw+ONDAEOIc354+ubK9efJHrs1HWe0qOcEiqu29QKC1x//hri6SvjCyyYZMx/pyw+TVjsWzhmdTQRJeyp/4sHoNvp7ndF+6s+kSQIIkC1O9xVDr9z9aaHCiAjKx7ByfYXt3g8lihtpPU+/zQ6VpPxbbQaqK+vkROGi6ivVXCNnV4Wr8l28af/FY544L0bbXEzFyadu+hjoniO0252On2lpb77MTqPbruhrQDbLw7C9hd+/onW9lW6mlCfJ3X5JW68l7OF3B7uI2srSiXACa9a6Qs1R+MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(316002)(6666004)(47076005)(66574015)(8676002)(70586007)(40460700003)(81166007)(508600001)(86362001)(356005)(70206006)(6916009)(54906003)(426003)(5660300002)(336012)(7696005)(2906002)(36756003)(82310400005)(83380400001)(26005)(16526019)(1076003)(8936002)(186003)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:49.7687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7075cf8f-408a-4953-07bd-08da2a083d0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3150
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

From IH ring buffer, look up the coresponding kernel queue and process.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 60 +++++++++++++++++---------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2ab5259c7305..0e009bd69a9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9188,31 +9188,51 @@ static int gfx_v10_0_eop_irq(struct amdgpu_device *adev,
 	int i;
 	u8 me_id, pipe_id, queue_id;
 	struct amdgpu_ring *ring;
+	uint32_t mes_queue_id = entry->src_data[0];
 
 	DRM_DEBUG("IH: CP EOP\n");
-	me_id = (entry->ring_id & 0x0c) >> 2;
-	pipe_id = (entry->ring_id & 0x03) >> 0;
-	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	switch (me_id) {
-	case 0:
-		if (pipe_id == 0)
-			amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
-		else
-			amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
-		break;
-	case 1:
-	case 2:
-		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			ring = &adev->gfx.compute_ring[i];
-			/* Per-queue interrupt is supported for MEC starting from VI.
-			  * The interrupt can only be enabled/disabled per pipe instead of per queue.
-			  */
-			if ((ring->me == me_id) && (ring->pipe == pipe_id) && (ring->queue == queue_id))
-				amdgpu_fence_process(ring);
+	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
+		struct amdgpu_mes_queue *queue;
+
+		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
+
+		spin_lock(&adev->mes.queue_id_lock);
+		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
+		if (queue) {
+			DRM_DEBUG("process mes queue id = %d\n", mes_queue_id);
+			amdgpu_fence_process(queue->ring);
+		}
+		spin_unlock(&adev->mes.queue_id_lock);
+	} else {
+		me_id = (entry->ring_id & 0x0c) >> 2;
+		pipe_id = (entry->ring_id & 0x03) >> 0;
+		queue_id = (entry->ring_id & 0x70) >> 4;
+
+		switch (me_id) {
+		case 0:
+			if (pipe_id == 0)
+				amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
+			else
+				amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
+			break;
+		case 1:
+		case 2:
+			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+				ring = &adev->gfx.compute_ring[i];
+				/* Per-queue interrupt is supported for MEC starting from VI.
+				 * The interrupt can only be enabled/disabled per pipe instead
+				 * of per queue.
+				 */
+				if ((ring->me == me_id) &&
+				    (ring->pipe == pipe_id) &&
+				    (ring->queue == queue_id))
+					amdgpu_fence_process(ring);
+			}
+			break;
 		}
-		break;
 	}
+
 	return 0;
 }
 
-- 
2.35.1

