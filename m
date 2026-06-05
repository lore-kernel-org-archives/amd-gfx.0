Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6F8CD6E74
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 10:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E1211A710;
	Fri,  5 Jun 2026 10:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="26nJF/71";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013044.outbound.protection.outlook.com
 [40.93.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47BB11A710
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 10:32:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsLWnp/A2wsrG+hZM6VRdxSwyY/3sS4nmoNQn4vOZAP3XACn/Yo//9aLXggn6qzOXu+n80QHbKc7a09zfISDtYi3Sf/gsCUre7fzHxJH2xx0Z8oe0Adnh/aSvCd0woY5+m5br4XRfQG3QlQiHCFUQa/e9aYa9Y2GMJQvxuH3BujnahC1UiPsz9Dkk9LUOIO8zc276TVKEW/deZrEBUfEOgXc/qFzEfTAobgKVbwS717kjQAo+u7m4s7jNJdOLHGJxThO8FM+lA6t3iPhRhe1N3I2moQH0AkLVFP9migil8Cs5QV0/PBatjQajGReVA7ZNWco6FbhToxpldC72fwm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdoACxCBk3lYGeRSWTy953Y3oeNKsf5Y9WrXdXhSy0g=;
 b=f9AYdsYkdBgrDn0iyqfX6DSQ4sDdicn2kFwwjRd1Kxu8sDvzIvtOuENCIg4L4+DLSrHIwdbxPBeZ3lgHWsZzRkVCkq+LBvs1jkYltjdtvh1/2DVYKnzj8LqJGgbVk70/xVR1j0ts7UmXoMk5fLErn6WW6A0cglH0AbQzoN+TYIS2VgtmQR2ApLExwRIRY9PnZIszb47SDg1RUmaZzIIPw+zMyVy+iV1BtWCa+1Hq2DG7ffYd9FSRoH2p1f1kv9CMdL9ATsni4qb6MD2QrTScaHfdt39X3DlkW1ag/Kt0rI6p3Ydjo6kVi//KTnpe0gcOnsyfz57yqZW2hQcj7SQAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdoACxCBk3lYGeRSWTy953Y3oeNKsf5Y9WrXdXhSy0g=;
 b=26nJF/71A9e/0zG3nhjazNA6RB2g+nHN49P4g9h6tDMlvpOEqLFdxQ4Cmpn7hGppyj8p/AcCMfQbzhN8S/20QZ+Ed+HrpmP8lfsYUKVFg/195Ic/RcL5UCYZyJGxy+zHN7OjKdV4Pi8JRMdTKBz+AWrEZW2/DXEHcoIZZojSAZM=
Received: from DS7P220CA0080.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::13) by
 CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 10:32:26 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:8:259:cafe::46) by DS7P220CA0080.outlook.office365.com
 (2603:10b6:8:259::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.21 via Frontend Transport; Fri, 5
 Jun 2026 10:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 10:32:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:32:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 03:32:25 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 05:32:18 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/gfx12: try KQ ring_id match before user-queue
 lookup
Date: Fri, 5 Jun 2026 18:30:52 +0800
Message-ID: <20260605103144.2537331-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260605103144.2537331-1-Jesse.Zhang@amd.com>
References: <20260605103144.2537331-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e82c791-9a7c-45b0-7076-08dec2edbca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 4rqii+gVE7s/DwXb5HxyQl5Pi4XoTw97Bw9KDOqAzVGXJ0UCLcvLkPSxX9OVdz3Uq5LGAGarfQFTCs+vV9vCUDrp5jh6VSgr19mnm4rM07g+chmxdgRRsFdhOi297yXv16Xv1LytcQgG3AaB474izIL48j4m09bUiG+QUwd8LN880fnwD9kUtQR0EOwENGCuZk5pMyheBF38/e9h07Uicqxekt71UC+QHuOCmcdBxGmNWwKEItp8jgaMHFb0EwEzBWdeuyTK+ktEs/iTxXmRe9ghIzZ/G9dmlpEcKwOV2v3HQrDk/gufmYJpM/2wVDyGXMYzOeLimqZMCpDhpJxPfWuipo1kW6f9QWty/lDSINHLXmy80JTRmujSkJ9sjVp3IG6V6JG58NZOP+FDCOyMkGXan/LrbXTot3U+42smY/WmfTlqDtIjDRWVp7BxqJ75phZeDFqnGhZPOKWsDri70rpZfqZFqddui8EwUVYsemX7phe8/NhDAYUR4gCBUrBUNyFEwzsGn1WpJt0a8hZZ0gLvd5+Ww0FavcigHcTE0zRLuhdTuoT544qV4S6AEdDROtZyn5qW/lScXRA//o6oPvIlk4jHmFHRb0La/5e7U2QakbExJhlEpULFkbOEiJfqkbs3KLsz2x8p/n7Lrk090EKF5eGCqrNmBHs8ym/O1rO99UUFxW43ECjwOrcmVeOL/OiLKi4KNj9gG+50PXKzcu+ou5CYuMhHIRwS664vO80=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xKJHGGMLauf5MhAiLche+X0cLMUxPWs9iWNx60VhoAIDIw/PSEwTd0H2JR2qIQYb8TqOKuU1uN/r++YndCN81mn2YvLAAjWEldIW+osTPGeGM7UPVq/eSv3JSyipdt+scCaVEtDALNDXniVD6Nrp7soac3/LdoZLv9Wo0cvZrtfW9b/17A1WU9sMhLz4bQU+UkDbu1bJKoHaNJnaCrVbHsYbYC57oc0WECUVjOpdFJVa7eETVkoNU0bILICQnExrc9CxIbdfKj3t3VQxGhR/wJlkznK3UGsE5muQ1LUiXwket/s5S5aTrIyHjrKmlOYmaBVFUlBjFBStYakboi+alUhR/LEG6MeZ/5BmXwbs36YiVc/VgtLC628dUXFHzVP8Qnzx5LFuf6XaDc+IByEqVDXAXSvH/Kv/kS6bkXFrfWRVJk9KYK8EIm7T2J46in6+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:32:26.0328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e82c791-9a7c-45b0-7076-08dec2edbca5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
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

KCQ and user queues never share a HW slot, so a KQ ring_id hit is
authoritative. Match KQ first; only call into the userq path when
no KQ owns the faulting slot.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 7c269cb75e07..e32dfc654ee7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5016,10 +5016,11 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 	 */
 	u32 doorbell_offset = entry->src_data[0] & 0x3ff;
 
-	if (adev->enable_mes && doorbell_offset) {
-		amdgpu_userq_process_reset_irq(adev, entry->pasid,
-					       doorbell_offset);
-	} else if (!adev->gfx.disable_kq) {
+	/*
+	 * Try KQ first by ring_id; UQ as fallback. KCQ and UQ never share
+	 * a HW slot (compute_hqd_mask contract).
+	 */
+	if (!adev->gfx.disable_kq) {
 		u8 me_id, pipe_id, queue_id;
 		struct amdgpu_ring *ring;
 		int i;
@@ -5033,8 +5034,10 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
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
@@ -5042,8 +5045,10 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
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
@@ -5051,6 +5056,11 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
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

