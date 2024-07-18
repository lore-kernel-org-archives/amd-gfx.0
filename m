Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C60C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86AB310E91D;
	Thu, 18 Jul 2024 14:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bDX/ysIs";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB88410E906
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QO9dUqOYgVMG3wCErGvgGKWK4yOZlH9/ysS4cuGf1U4ccP2QXFndXcsE/PCjjwVBazKIRsetvaqwvoqEhy3Bh6DShRd4ZlDtflt4vAtZaTP6AypVVl8ENAkerdfD2Y0WN0s2y7HcBG++zE2oDsGx7dDUNRCwxCY22lx3YMXCUG8vxgnlnxRalz6s/ayN1G4Nxofrq7TWJKXQmaGDzy5epLFiMLzfbucE5G3dNvepoPYm6DlcBUCcxs8hkX6rqFhCFp+NIn2KwJIMoCUDSy2es38Y7wbYcMkVJLYwJYICRQgsADV3kI/8KMdeJFz+4rpw1fUhADQzVZLaJffqxXrAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2gfFF3fq5qw+iyEUiEsWHr/rF+pz2GHlJ5eb+Thjmg=;
 b=FZO/QCEepNK2YeivE1PnrOY14mD+8LsCs+Uv5S/sjwjeIT7/jVyBC4u+3MrByBa2O/KHILpAPUzEQ2f2Gct+WBSGXm1En2E3aq9xIDB8Ot8rF6/M7q6c/QTTP5K4wuuiwQ5WebqZ45fJWeLZW7mXFo5R7r0Xz/5hLbCnUGBLJYC5uk2RgkEyV80Rx1yAGoEZ4h3VqZt0p7+AxFQg8vVPIizikLQP50aogUXiq0M4F7psfCkt806ITcRijFv7tcdcTU4h5Gi3NcczK8rlw2tLeSta71+S27g4ddVlBXApo7FfnMFRrDEtbKGfdo7hqrugusGZGafrZQi9DiuN8EfOwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2gfFF3fq5qw+iyEUiEsWHr/rF+pz2GHlJ5eb+Thjmg=;
 b=bDX/ysIszQQ52k0ba/CI1k428q4S5ovrlpIhX3wAP8hznVbBrcdTT1ai7L/oZ64g8F1dO37IRdPP10paAFN4JElrGvRMVd041pu5GOEPGJwjpm/KQsn3C6/F5nsgnPt+gxwwCJOVHCoG1aL8kkw+mNP03Lv7gymbAZt4uSct7R0=
Received: from BLAPR03CA0039.namprd03.prod.outlook.com (2603:10b6:208:32d::14)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 18 Jul
 2024 14:08:04 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::8b) by BLAPR03CA0039.outlook.office365.com
 (2603:10b6:208:32d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/34] drm/amdgpu/gfx10: rework reset sequence
Date: Thu, 18 Jul 2024 10:07:16 -0400
Message-ID: <20240718140733.1731004-18-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 5039b5f5-8c3f-4879-56cb-08dca7330a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qreH8kyAvX68NBvBegVV48tfwY9T5wafHgtZvSp2DvBjQnAn2R+f0yEVoOUn?=
 =?us-ascii?Q?g18RoQ/d18uPLFXnJCdYfFpszLW74/HO+qMQ31JFRm0RvYcoj3zFgQHmo8Z6?=
 =?us-ascii?Q?MGCvusR8U9aheGEebTyNEn6jiYuyzvnvagBjO/c8q9SK5ayKpCPiVTNXaQDm?=
 =?us-ascii?Q?GSbU38crT4K7F37v8U9bm96kpm14veIaYHJI4mtO3/HpyFKGQAm/0iNS7ll2?=
 =?us-ascii?Q?7HIs5rHMJSUzk9v6agWLKVYbsvgFhiSerjPntdlHUbC0ikJ14YTQmjTYGzQb?=
 =?us-ascii?Q?akb1c6NQI/m7nthSwTeW1/zvUBZ/lbR0/RFGfltH4BqCEJoUdloTvCb9B9dA?=
 =?us-ascii?Q?w1p6MCdeZll8QWnQlLE/fnWWztzOeuLS5WkP/qiQCsou7CfQQ+5jORLPITPt?=
 =?us-ascii?Q?I6UhI5eXasjXaXXCI7O94UqEL/MUU0NPNu01atO+zwf4RpW4UrqrlPEmB8VD?=
 =?us-ascii?Q?qBVZu2XsTgPzoY97Huu9tOTsfN3XoaUAXDNqjHnOfo9MUx/nuXZqfHKG8OTt?=
 =?us-ascii?Q?4jvOPdJ13yScVI5oZ2RdIik7G4MHgkpo2CgvClMVkam3yP+ybA1A8iQFVfd/?=
 =?us-ascii?Q?ptwH1W2xrgCjFU04nuzOvN+ibvr65neF9uFLcWBbYlipoED5oBVAWoeXhgX4?=
 =?us-ascii?Q?ax7MB+hoDYM5imAL6vglaHcmpJOJeKc6OB4HZHWVRTeE95qj1bPp8qiZBjGx?=
 =?us-ascii?Q?VUdTp0+MwZg+eNN9sMkCt3SYgBMpvIWUdWA3xQbLJPMh9LPA/BRIAXtGPxx6?=
 =?us-ascii?Q?mDDTxmJ28QYOlbNbW5QP/JxznoUPnRY5V64kQwJL3h2Kzz//c04k5bUipXDn?=
 =?us-ascii?Q?RMU0Z8MP9r6u8+jfHLi/at1ntjDoD4Hd022AfCZOHZ+hSQcXOwoRUHdNq93f?=
 =?us-ascii?Q?olmit55k+VF4Tkgd1JcmJ+7Pan8O8tYC7Ur6ozUE28AYWsIlqLJG8RUaeb2z?=
 =?us-ascii?Q?6/hjMcE3sUSKdoj7jbnBLpXO/KSYVD6TUyBmfOL9QThH1cyOAHhhRuOOzr0s?=
 =?us-ascii?Q?5RKzs+KD2cmWMpIqW/eqbYgJglA75rEDBRt3Y3lnTED32raLTxTqdvSzQ0ft?=
 =?us-ascii?Q?WhtJSHVTKJMt0JNV2x93C8h+QYI1/TxU/Gw9IqVKt1WrG34VafeQfGb+4U5i?=
 =?us-ascii?Q?AshkJQ6L/Ewz/5P5uoA3PP7Ph6rzz2SQg4qdpzeIcFfSRJa0rktB9hC8ujlw?=
 =?us-ascii?Q?l5kjSW/sBlolgU3v6vuQHqrTn3lkw2DDyePoShzqALwzIH/JiLBzRzSEn9Uw?=
 =?us-ascii?Q?XXEUug2sF1XJt7g9yZMOSqh31WN3Ol1Di0j1PUl3pyxXXGvvUYYc8g/XmlLS?=
 =?us-ascii?Q?Z9ZzaT8Ap44QADAwgeS3LfhVe+xOi7O5WEH6RDydwb+JeAcunxB3sOzMV5xa?=
 =?us-ascii?Q?U5aZOn1sh18eGKkdKZIqjKthRkmfSByhMq6KpHsHq/lR1xXbVD1TebbHBt7f?=
 =?us-ascii?Q?C+Pz1xPNR4c10a6H885i81d1YGH7Ckos?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:04.0824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5039b5f5-8c3f-4879-56cb-08dca7330a85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805
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

To match other GFX IPs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e9d93bf909db..b833943faa53 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6748,13 +6748,13 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
+static int gfx_v10_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v10_gfx_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.gfx_ring[0];
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -6806,7 +6806,7 @@ static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v10_0_gfx_init_queue(ring);
+			r = gfx_v10_0_kgq_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -9498,10 +9498,22 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	/* reset the ring */
-	ring->wptr = 0;
-	*ring->wptr_cpu_addr = 0;
-	amdgpu_ring_clear_ring(ring);
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0)){
+		DRM_ERROR("fail to resv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (!r) {
+		r = gfx_v10_0_kgq_init_queue(ring, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r){
+		DRM_ERROR("fail to unresv mqd_obj\n");
+		return r;
+	}
 
 	return amdgpu_ring_test_ring(ring);
 }
-- 
2.45.2

