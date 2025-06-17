Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CB5C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F389710E498;
	Tue, 17 Jun 2025 03:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wnJJoatH";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 606A110E48B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vs0YxqsKlQlfR1ahyFTHQ3z4BZOWoL6Awn+kCLnXi+tnh3gfkKXMf8VuVu3Wq/WHrFSDlcl6wr3smcILhiXeGBlnstBusGpl1vk2k+jPV+VTi11mA3KIKraHyLOjlFsWim0yFXwgZOmha3XSsjAq1YzmpxGg2IKPAfVckB4NqLgA5380UatIHWvsL6nl9S8jbpkesPow0vWnx3h/oaBLno2WQGegWaYtgt+h+jhgsohah0LwnSk1A5xUmGEMoqxRR8RXbMgUilT+4nmezkwSl/clipIooXwmRW9xwQ9iYji3P6oA3BCwMTihD2eHsWwzkIo+OFKBeqAaB32wITrDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyVBTYknp0h9G1T1J/DJJAvM2yAweOC5e/5uL+pvsDc=;
 b=O65zeoTUuZPtNFATGEVHfuE6JOZGOkuqnYSo9Db/SJ9grM85TjgIl4r/u2sT0HbrJQXZjbTwgOB7ycVyNCdcX1IldEmeMM1OdEt7vLn2w/pZJvzYiKxY1hBSLoCjRK7WQ0e1YFfbWvFzi5FkzK3089JAqie6FZowr6i1ZkHo+6o3vZUdJoURmohe1NifxWkcTDmhVGTkbpE3+xiGb2ikafUBLIq7v+fheEySTIhxAbg+nIaMV2oNOLoIOLRRF/azeCKEAehdKvJL32amY+oRYjbKWXkALCJx1yX4+lL27UrAJS+H7VtHH3l/5KS8ILBwTMYwU0BpPUTFwplERi+pEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyVBTYknp0h9G1T1J/DJJAvM2yAweOC5e/5uL+pvsDc=;
 b=wnJJoatH/D7zEozRVzuIez1a3S1VjzKbUOLITarGfi1jsAqbd/66zTZ0C/vyEdUOyKVOtw2xhW6zkbGXm0ITS4gd0n+UFEP0ISqaw+TpUXvibKvxTkjTihEo+XQ1PegcTxfJfYvC4Rhys4zsRKIMh4jM1bFV7rl7m0DGUl7lX48=
Received: from MW4PR03CA0162.namprd03.prod.outlook.com (2603:10b6:303:8d::17)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:08:44 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::4) by MW4PR03CA0162.outlook.office365.com
 (2603:10b6:303:8d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 17 Jun 2025 03:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/36] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq
 reset
Date: Mon, 16 Jun 2025 23:07:54 -0400
Message-ID: <20250617030815.5785-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3f2fe2-ab17-4ee1-fc64-08ddad4c4517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U6Xj2bsgfKto317hBch/DQTSB/DG2LA/7hj1ulodPe1720J3YwDBT4U5KwPV?=
 =?us-ascii?Q?l5J81CmpZGiWPYBmjMEolnfMZ+IYsFfe9Gq1w5/yVgc0XQXAuRxmW+nFns1g?=
 =?us-ascii?Q?dyuwzVAo1BQT8YyO57U2/ZGp43WO26n8YAfNppbL4OjR6f2FUvUxTRdWZrpT?=
 =?us-ascii?Q?RONeg6d04jJs85U390T1/G4aH/6zfm76FsVqRNBWHEaYVbAgixA/Uv5E+T9k?=
 =?us-ascii?Q?B7MzQ2Xf3tE5pCRfuzBJqfQLstnNAjBmlesiqH7H+CMfvHcB7mGwxMh6mo4a?=
 =?us-ascii?Q?+JSuqmqbEUgv9J+UlEPggglAuTOVOKri14YDOX8gL8NzoJYaQTuw1nwInOi0?=
 =?us-ascii?Q?Xzx9FEdFeEDSt0wTmWNwci2cPVxlA1pC3HhDlet1GSuD3gNKcPByNBQMuGRK?=
 =?us-ascii?Q?sQWABp7ClW0Yas3a+0SuYIodb3vS+PqW4UwJ6llOlrHgJfS7Y21MaBxlLSuz?=
 =?us-ascii?Q?iXzHbTdv+teMjds9f0pbeY81Yi2T4F7FxzU0rOkrJS3TTZ9GDzilArDxYCde?=
 =?us-ascii?Q?z5UbbDm8R/AFp9wBpe8Zt6UYKonmYwBoHu1Gmy1Sw/1+utu3gWgqGbEzoe/o?=
 =?us-ascii?Q?QTkuKu9Hafp2Gmi6a+GOMApK4QtBeTeJySGv2+pYjDZoi2fpWTp0tQPuFCDB?=
 =?us-ascii?Q?Ynx2TRHw9HAznvyYxLTsomen0ukP4FRNlfF/TKbx5HfMV3vl95iF0Qr1TtRT?=
 =?us-ascii?Q?xYVnacHXPzgNbl4AIcqfqc+QL+zWGc/xe+qbE8WkQIoiu3kP1r76wcitlMwN?=
 =?us-ascii?Q?y41dTwtRZpYnKqjML6yH1jIM8fcJzYz6YBvxdZL4fE32//9ziaqk/xSP+pnF?=
 =?us-ascii?Q?9/NwVJ1nYxvrJ71bXH26Iyk01rjnHjK8ADqoO/3E8SslFrrwGKfsZrxP6GMG?=
 =?us-ascii?Q?fW/KLkgrlXtLMfBwCLf8Yf2/pCPnqsGx2frI/qa3q1kjsjp3c7v88OBFys72?=
 =?us-ascii?Q?iAmU6uC6bHjVaE53M4VRfjHIpAJmWsSW/vdzt4ep1T8s7Tm/+D1rGn2CBVia?=
 =?us-ascii?Q?8PFhgqJ7kN9IDaxlr6LZYh/6ynucfPerE3Kml9fAMc7aSKpR01S4yCwkrNRw?=
 =?us-ascii?Q?heHJ5HLwBGO7he5nOczTGHOO49CNNJBbH0ekdyNxUBLxuTkP0/UQk7DHm+uy?=
 =?us-ascii?Q?LmzNbZ/EzU15xgqSu21Qls6Gq6Xa5iet0EDoBwhYVqf5bArymSbcTFQuVSDY?=
 =?us-ascii?Q?3id/ihgoVADHDOpc18yLsDKfyonpvu0CUTpVz/KQct64jQx2U71t3v+1p71C?=
 =?us-ascii?Q?6iM48B7g88BHsYcnt6+Em1SRd8aBaUrcX1oyTKG03LWgfAeLj//xqnqC3G/4?=
 =?us-ascii?Q?iEucNFTFACWvONhVltQNIYFmCrVSQo4y8XmBrUBH4Fvfk2HJgMHxAQBfKCRs?=
 =?us-ascii?Q?zH8FmsJjd/LkavP5/pLTagweLWdl2w9f1Tw6FdGN9l7fXT7qY5BJ4Z7r/pCA?=
 =?us-ascii?Q?i1putwql1dHl8PUwbzZozqt8SaR2eWmK+LfdbKvwOLO3gStYXMQjNyEtrtmt?=
 =?us-ascii?Q?qgPyW/Uf/kuxut7QR0xkVLghLANVEnZpNbIi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:44.3457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3f2fe2-ab17-4ee1-fc64-08ddad4c4517
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 08f01f64e1c24..e4b84a9a1ef3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3567,7 +3567,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -3615,20 +3615,14 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 enum amdgpu_gfx_cp_ras_mem_id {
-- 
2.49.0

