Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B49CD98F8
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 04:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C8E10EC55;
	Thu, 18 Jun 2026 04:45:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m91T2zpk";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EF1710EC55
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 04:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPzwnX5Q56xTa9x/tDzWjcZgADqucybKZ2zWHWMjlVL2Mzmf69HV6QPuIYvFzZ7+UZcL41hmWNWN+Xu92tbIKRUfEqdX0uheww8srQXgG9ZVIo2RMUCUEe0I4tg3niVK4R9sSf77dcTChHYML4ceETa2Y3NN1hlzJWEALj5YLSyXoj/gUhzBem7bclQKHcuyctRy8/sfmGU0FfmKwd/Q3zhtdF3fHgUmfyIsh7BE2nJ998yOiubGX3gEf67rnuWmKo3j/zCu8Vs0yt+8NEaWsxfZvM7b0rXu3TdEb/WPFIpxPD824wWDzVn1exn41ZN9ScJVBZ4VegTU34TJj43bvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnsVevQpUOdfidDyM/EmaLj8iBy1uuNPb+DIYFj1sVA=;
 b=tw8kxtd72smDH2a/rft0R8r5BkR2BjPDCdqRKGip4rImVi8C+0e9J+0zN5xlKrGnFv6RE/lwOrvbNS0RZjAXrHBc1dfKXuEKInUlq2AHwAVuq7Vk4yGNRVhVmAWxmfH9OM3yIz7ELbJ5AxbhIwYz2txjaO45Qo7GBep8Fyhhxl5jWXDG4tynMSwQnBUjU0Eq4483Cty3sLWpcizJe81fLIlaDanrUS8DULwJn0M17Dko8wMuBlgx/SGx+rkjWtDpDYL6h1E3MOAMhWOZupuRiJrv8LeRHLBNuHw4g5Z3M1085yqnZJ6zHHuZAZGIA4vTitBhnz24gHORDfFPAFw8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnsVevQpUOdfidDyM/EmaLj8iBy1uuNPb+DIYFj1sVA=;
 b=m91T2zpkrAOJT7Ax0l+4mNTKm24dek3ikFw72F5bP/gn7raVMf+4QuOqFnqkRmvUBoBBUx4g0z4qNgmHVgqjMUk3PK3uXcV66RmHd5r7YUDiGY6QRW7Wg5vk+QwcERWr5LL9GV/80/Is+awCVjyFQfPM3mNJF0tB11tIZXQgwow=
Received: from BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 04:45:07 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::51) by BN9PR03CA0067.outlook.office365.com
 (2603:10b6:408:fc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Thu,
 18 Jun 2026 04:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 04:45:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 23:45:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 21:45:05 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 23:44:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 5/5] drm/amdgpu/gfx12: fix EOP interrupt routing for KQ and
 userq
Date: Thu, 18 Jun 2026 12:43:40 +0800
Message-ID: <20260618044405.1724370-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260618044405.1724370-1-Jesse.Zhang@amd.com>
References: <20260618044405.1724370-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: bb575ab6-2eee-4b1e-c5ad-08deccf45eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: +UFjB07RklvC32CpDulGyER0vTzQ5aYIOAcqHZ4KVvKdb9BCvpC9Bh92f1eGfl7hisYYmjo5LYk5Dn+0fRSpu3NwWmGoATzKjhpDgOlS32Gm3HXbcAtkyOUZokBSxOMaQJqB1r/EQBw4rz1sSN8dnWCWSCiaq/mtleD9ISVRp//ATaG1hkCWBuYUw9dhDSx5tYyiixWXDI3C/893MhG2DuIbmAJd6dYbI5h2hmgEcjFYdIvD6s7dbv7XE9yx4IGMA2w/uYyuJFqOGl7x2UUcdPgkQiquR3BYMwXyS2OofieEAQt9jU6E9uyclVs7s47pIt/KnZp4PLl+PgmuhUqWE2ZOtDA9iGE96DRzkpucl/r+wbHeF7ATTe/LJFHrUhCfEFgm2d8ETIX37FIXdXGZCf9uN8vOCBr+1MPSy1aIzoX6xinYhlQO4ZS5y7NlE4EcYqCc3xjKO0Jg3XFhbJ4D/TWZQAHyQSD1UJOrtU3nl5Si29mHemPZ993EFIZedYpKiwxNHNfjgoGLj/IUo7ozlPkHavub2XJJQcxUiXbAIucD4RUEYZfvhio7MItyFGkrh2E0y3LxKCcjkVgS/X9REYWuhZrHfAGEP0T1d+oXzX8ZELJbB+eqoBQ7Ak7LJLIcqzRHoUrTFnb4VhtbuSU09x9RkW7TvrONvPQMoD9m09tJRfkPQoEAxvo1zeWB06tg6ABGtKpSE5l13qPdSurBXVPV6aN5Zx1qRhjcPaPSopY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: neYchc+BafccoM6GMghF9C7caLzfE8HhxFMX9IKTfZMIBkr4YrWUWS7mfMPTehOPOBb3JUDvJF02X7ekfUfs0PV9mtknraP3b4yKYG00qL5fYOelUI1MEK0dLmeZDahVB65dipcFHagXN9L58KgclBiIkElzxpXIOClDQU8b72wmq2anmVdSsDUlUmmHK79sLtiSyNmk0TmA/BgA6/plbgf6JQfvJdNFxsOGP72NSIq6fBjCSryq+qJCfxnFYP2tANL8Y923azQOYtnx4S+d5AgKvb0Cl0IyyKvtKH8tDWfbuziF+2PrkWRDPWwjCaFdFENPUbbP/bw1VK2Wb4HIygjgqQdK5hhHoCVARlzbap5TzQkSbWDImUSsnTfDL/9P1O5i6Z4TSaG3a3kQwf8/8SRicKOn09yBDpsQ9pc2rDqNh44et0n8flKVpbX0LaeK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 04:45:06.5632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb575ab6-2eee-4b1e-c5ad-08deccf45eb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
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

Try KQ by ring_id first (KCQ and UQ never share a HW slot); fall back
to amdgpu_userq_process_fence_irq() on miss, since KCQ EOPs were
misrouted into the userq fence path when enable_mes is true.

Require a strict (me,pipe,queue) match in the gfx case, then userq gfx
EOPs fall through to amdgpu_userq_process_fence_irq().

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 43 +++++++++++++++++---------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3d8975a32e4b..0a672e9df26e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4845,25 +4845,33 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 			     struct amdgpu_iv_entry *entry)
 {
 	u32 doorbell_offset = entry->src_data[0];
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
 
 	DRM_DEBUG("IH: CP EOP\n");
 
-	if (adev->enable_mes && doorbell_offset) {
-		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
-	} else {
-		me_id = (entry->ring_id & 0x0c) >> 2;
-		pipe_id = (entry->ring_id & 0x03) >> 0;
-		queue_id = (entry->ring_id & 0x70) >> 4;
+	if (!adev->gfx.disable_kq) {
+		u8 me_id = (entry->ring_id & 0x0c) >> 2;
+		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
+		u8 queue_id = (entry->ring_id & 0x70) >> 4;
+		struct amdgpu_ring *ring;
+		int i;
 
 		switch (me_id) {
 		case 0:
-			if (pipe_id == 0)
-				amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
-			else
-				amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
+			/*
+			 * MES splits gfx HQDs per (me,pipe): KGQ owns queue=0,
+			 * userq gfx owns queue>=1 (see amdgpu_mes_get_hqd_mask).
+			 * Require a strict (me,pipe,queue) match so userq gfx
+			 * EOPs fall through to amdgpu_userq_process_fence_irq().
+			 */
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				ring = &adev->gfx.gfx_ring[i];
+				if ((ring->me == me_id) &&
+				    (ring->pipe == pipe_id) &&
+				    (ring->queue == queue_id)) {
+					amdgpu_fence_process(ring);
+					return 0;
+				}
+			}
 			break;
 		case 1:
 		case 2:
@@ -4875,13 +4883,20 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 				 */
 				if ((ring->me == me_id) &&
 				    (ring->pipe == pipe_id) &&
-				    (ring->queue == queue_id))
+				    (ring->queue == queue_id)) {
 					amdgpu_fence_process(ring);
+					return 0;
+				}
 			}
 			break;
+		default:
+			break;
 		}
 	}
 
+	if (adev->enable_mes && doorbell_offset)
+		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
+
 	return 0;
 }
 
-- 
2.49.0

