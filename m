Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DC2CD98C6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 03:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8DDE10EC90;
	Thu, 11 Jun 2026 03:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tvj2ZR9A";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805C910EC90
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 03:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1rM0O/mtvsXAprXs6G03hybDkO2KoPjRuRfrFbZk6zlaynFupQNOS0DPBYM5JBzYPA6SL7kf7wpRpO7bkH3u7r6BXLjxXmwRwau2hflmpCi5BLkgFGoy/JALOJy/ee2c9e7eoIWod8bnDo1po2GZiFkgIWsSkwXwi9diMt47OjnqfR63dfLEniwHk5ll3nxwYfnHcNnhFc3DZsmUIM76qjhA6QXALDfT1YIExoy3Sf6+RoIUrQ1+9QtQeJ3NqdV34xsPDhG1sD7fuMY63NPBhcPYLrdsQb/KVa4Ye2JMInPrqOn/xTeu4QWCx0fUTfSNy34Iiln/BYi/fjxFYy8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w169kT9zAWbXY0l9Y0g7UDsBhVn8T9cLn2dO20Hitp0=;
 b=BjmWf5cZPxmujJel/Ky+ReIToTFf3IcEDT6OXbtU74MmhxD7wsqbRszzv6m4J6KV96Lx9ZqyAF6g9I3KRTyVS7zvJZJzX9hAKbW/hM0qdNAMmyiXMvhAdsM60LjFpxWM2LpeUWKH4ICMX3r4eNXmxy2qquS7Ss6wc+8NP0vYF/Lsb/fY12HVGZLKvtf9Qdoi84T9LeDjv2jmyZ942FHClw94visqVmDaOWVGmAVjiev1sk42buCKix8fvrHM1J0seaNdmjAqlXqXZq5UbP1C5lEu4OHCMD5dqTNyAs1zbE8CDGtINhw0liAmDsYN+mOYkcpW9VQWD3Nr+CTnKx1Pqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w169kT9zAWbXY0l9Y0g7UDsBhVn8T9cLn2dO20Hitp0=;
 b=tvj2ZR9AlKfSCatuMKH0+fZ6Ig6PQvg6zJWMyaCZ2QcheLZDdHSRmE89zu3JQ11SRE3TRCF+kCrrpg4ou41Nbal0Kvtu2czA1uktL+mi6E/llh3Aj29yWMdcR4k2htHCcsLz49oEVbaQOrlX6J0uHTKdd+a2RDrTeXBqV/w9FeY=
Received: from CH0PR03CA0106.namprd03.prod.outlook.com (2603:10b6:610:cd::21)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 03:58:09 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:cd:cafe::24) by CH0PR03CA0106.outlook.office365.com
 (2603:10b6:610:cd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 03:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Thu, 11 Jun 2026 03:58:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 22:58:08 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 22:58:01 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 3/7] drm/amdgpu/gfx12: handle error interrupts for userqs
Date: Thu, 11 Jun 2026 11:57:30 +0800
Message-ID: <20260611035747.548780-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260611035747.548780-1-Jesse.Zhang@amd.com>
References: <20260611035747.548780-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 336937ee-2205-415e-cc2d-08dec76da630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PDDFNDnyY6MZNlce9yOKlGGM0I7w45BleErKw9UP024cHVynUPWZEGsEEuWH93kPhbBPGXLe2+2l2pS2EB+wwZframUxiWcKV3FcHe8Ei6AZar025cO349ToT8qjIwR1FypGGSiRw9JU8xFSz9fTWnPlbGxG4elRrMQWN0QGvp9wW6PJDZraSH3VuICBVTC3s/M+gLQIQbKyZD2mMLxEEMyndLpNTdrA24J2yyRVLDGgTWREW12O8+nRmwFemnea7JdwJBwExCD1KIBfEZ1lNO+K9amnqjj9fPDins40+oyUtd9LPs7BAuE1kWd/OLhkSp4WNuXvhyfJGvtzy8OsSFwD1MbN5bWXTgdybXodo4v5gZfM3SnD8Ki29cUYS0j9BUGC5YVGQpFTexknpiuEn00t1mPA6wB9XnpExmkJYoQSK1ETY/ROQejLYnarpnTKgP4zNeG4sbvuiKdDKCOxmHJxI/ti6YPF4RN2ys/lSELMuVIVAyNJlWOeJKX5iqE9cO+rwm84I0jLHR7H+F1P2DWLXTtEHhXQXbC6dDn1jnYllHVXAv2Adozf32yyG+FZXmBTuD0cIJv+GW7cVCG4m1VXDTA0R8Wy+YRg+Q6LfB6QmPaqi+4dBYQd5klzI4OUEZyGKBn6QtTqG5PgLQnGCfrmcWn//mKhfmeMS/WgP4pIIGUJaaQxK+nnVxbp8GgdjEOc+6Pf19awH1nZonU7Ogs9o/dkglRC+kvNdVQqS6U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yvCCo4BJWQr5oZm+6nA85EgWxe7EAnybZpxUPTGq/CAKjPO0pwIrt67LtpAA/vJ2vFos4AtFXEzph1Mo0EcKvaLDivc2/1SMeNSaxqj4ZfS5b+DDuaZdyfIUHd4hGNBHyN6QMYWv+W9XdpUGeSm3pGagwZCrXw8M4JUsK8rF9uNmcvUfSFy6DWroeFfgbDFj8mHxCBRggYlePJC7Bs4gcjqwIlHcdDIQ0gWh0qgeKbnJdHPpihz4l6afjIIC9nTQhIwo9A9fXis438Gbik/bfOYy9Pc0b4RndQi8E0RmFIn/H56p+yucLRAk+F6BVKr5Eo01gLm9s2HGccMEeGm/abfkxklaVDTeeaM2vYpi2dMV82xewEsS++uTOTHMaO4UBSCVUU1mVWeLDRx1f3rJ3SEKeszcv3jFkD2L2+RaDiBFzAx9rL/zZX+JLcACYxRX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 03:58:08.6222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 336937ee-2205-415e-cc2d-08dec76da630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
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

Call the new userq reset helper, and dispatch KQs first by ring_id
before falling back to the user-queue lookup.

v2: squash in fixes

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 33 +++++++++++++++++++-------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 380ba062134e..cb4d84c5f52b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5009,22 +5009,30 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
-
-	me_id = (entry->ring_id & 0x0c) >> 2;
-	pipe_id = (entry->ring_id & 0x03) >> 0;
-	queue_id = (entry->ring_id & 0x70) >> 4;
+	u32 doorbell_offset = entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_MASK;
 
+	/*
+	 * Try KQ first by ring_id; UQ as fallback. KCQ and UQ never share
+	 * a HW slot (compute_hqd_mask contract).
+	 */
 	if (!adev->gfx.disable_kq) {
+		u8 me_id, pipe_id, queue_id;
+		struct amdgpu_ring *ring;
+		int i;
+
+		me_id = (entry->ring_id & 0x0c) >> 2;
+		pipe_id = (entry->ring_id & 0x03) >> 0;
+		queue_id = (entry->ring_id & 0x70) >> 4;
+
 		switch (me_id) {
 		case 0:
 			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 				ring = &adev->gfx.gfx_ring[i];
 				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
+				    ring->queue == queue_id) {
 					drm_sched_fault(&ring->sched);
+					return;
+				}
 			}
 			break;
 		case 1:
@@ -5032,8 +5040,10 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 				ring = &adev->gfx.compute_ring[i];
 				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
+				    ring->queue == queue_id) {
 					drm_sched_fault(&ring->sched);
+					return;
+				}
 			}
 			break;
 		default:
@@ -5041,6 +5051,11 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 			break;
 		}
 	}
+
+	/* No KQ matched: HW slot is a MES-scheduled user queue. */
+	if (adev->enable_mes && doorbell_offset)
+		amdgpu_userq_process_reset_irq(adev, entry->pasid,
+					       doorbell_offset);
 }
 
 static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
-- 
2.49.0

