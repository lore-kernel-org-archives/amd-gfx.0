Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171E1C7EE33
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D22E10E423;
	Mon, 23 Jun 2025 16:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="prMibCBg";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E432C8984C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZ49I4ggjZD0cNZpVfHeZt9IaencOyR+qS0HDHFJJXd8srvNap6viBz9IDqbUnIgpJscnnkOdP4s8sY0jLGUM7ia3BijdT/qaW+7h/1hiOVmTLr2POQhN1BaR1uuFYPdxdr8fhUixYqmFTS1glbGogIoE3Vy5Mj1oEPsow0HThTkXx61DbOFuoXQXn+rByxSiQ43+JW4+PiKvMn/E/dPb51n0tAtCcqHkA3Wip6dCraOUzvUFXXuMcRMiqd/8s676wtRmMwyXvh9weQTul56nC/zc+X2E+z0HwzYac+zrSyQLnKaGTJctf8QT8qJoOJGRby8mAfWKqtv8x+K4dbRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I053VWUL6dNi2iUGqZnj3zxiKh4Ivbh+YjEgxiOhw5o=;
 b=NgDaTlRS6Z2BVEeIVf/PMhgCC/Vb/D3E8N6a5y3x8h5xCvN4aB4iz//T+HnzsB2blQbUWqvf9hLtywIMBmUXYlzXXCe87PKP7NQXq18U0+EEHVkHXhjFfVXygxdTa2vUWZ8xgnQKkFdesBr9PCqA4kgKpb64kX9FuVI+Ja4/qLD7SCr1/4IfW+CASjNyQ4ouRIaydR5bBpojzL9gV6DC8z9i5QV59BPFaalJDU0VeIuEOy1Cpe2+2m9+4McCZ4745My2KEKUcqQTCX7wJ4JRf0qpr4rV4WgGaSH66D5MFMBb34JTE7X5jEVeKA9lCAjJ1eS4c0Sug2lE9VCVdEdcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I053VWUL6dNi2iUGqZnj3zxiKh4Ivbh+YjEgxiOhw5o=;
 b=prMibCBgmd/Dyoa3EcCK3dPgHKqnlXO60/WI1QsedEvafJmnJKoA4f6M0wr2LvP8HTB3ZEgwId+HAmRCHKTUJbztXFZWA3NL4jNTjEWF+YmZ4KM95CNY5S8x05eTWN2t4Su7RD0VjAMygVLksIf8GoTWCntd44xg9Uykp6bJR9U=
Received: from BL1PR13CA0222.namprd13.prod.outlook.com (2603:10b6:208:2bf::17)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 16:15:07 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::e3) by BL1PR13CA0222.outlook.office365.com
 (2603:10b6:208:2bf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Mon,
 23 Jun 2025 16:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 16/31] drm/amdgpu/jpeg2: re-emit unprocessed state on ring
 reset
Date: Mon, 23 Jun 2025 12:14:22 -0400
Message-ID: <20250623161438.124020-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 1945edf8-be94-4820-f658-08ddb2711ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sv5irbVJL5LJt9tOpIA1nCQYt+xaPlEUld6OiF90HXju2Vr23VcdsAGn9BZz?=
 =?us-ascii?Q?Nsfr7VZnW6l+Ct7wq+WjDX0VQag/eoNaEd+dIwsWa7Ag+hPXuineD4h43mSF?=
 =?us-ascii?Q?l++I/Wurv9XiqlMQu3H2AIZnQKcqQaNMifx2IFByRylkgSHTI26yO0v6b3s4?=
 =?us-ascii?Q?TcNf9EFsoXQGZa6dZa3gf35s1MB7az+UsLSb9E9Tw+y7B639D74PCWpptGdN?=
 =?us-ascii?Q?aucsNeyTuN9xr/uuJXHEXN/WZ/7W/Jpch56hmG0hjjgoVkwrp1RMgla1k5G2?=
 =?us-ascii?Q?nYnSYeEYCwEGnv8PvlcJXYred44QgrSUuGJZKQWV8s60zexGZBS/XqA4Higr?=
 =?us-ascii?Q?Y3qth5EwLnpCy1It9sgNZ6ql+vOPGA6ddFdNcipX5SWtS4FLtWFdBYx6jGEj?=
 =?us-ascii?Q?dtz0F3S5mssfxcoePYN4JE1JMZ25gl5PA0mSuIZkQcZF4SRFemqhMCS8N/2C?=
 =?us-ascii?Q?QJFa7Np9mkRfI7ZOWIAHcXUbcBYx0KLStBDRNLfSIb08iSoK/hV2OxuFTxVX?=
 =?us-ascii?Q?FDe80qpFBgUJtOJnj/fVFwPDExM9AJ/fKGzzTLHVTrwl1BJe6BGN27Oie1n4?=
 =?us-ascii?Q?OvL5+jZ1boVi6bKtI4au5z5M/vW/lAMp67o/aCnH38mUNNIlSUhS/u/MQvWp?=
 =?us-ascii?Q?Z1Y8c026TQctcZOXy+Fk58RnBXI92W16j+sG4n7DebkTNqGPxKfbcV0I2hA+?=
 =?us-ascii?Q?hdDjNSl6DRJfaZNCRtz1bbWZ6X/zXzpVU8ElBnPOilMr+SZgI7NLTxVlSL6z?=
 =?us-ascii?Q?uEMnf+4lnwmjmQxUJawVZ/TctwBQNAOa5TuFGtRqToLQLkwn6Nc508G18VK2?=
 =?us-ascii?Q?EQHuKEp0slvJwoaiHnwiXhsm2uGft9x4y8b5X5KQAKY6YfoGovtxiic6FX/E?=
 =?us-ascii?Q?vAQGugPDY/8EsrFMJsp/eIdAxtPQGN3OW2plQsMkKWNGrkyCy/2gPFFvqi63?=
 =?us-ascii?Q?NUVdCaOKOJSqPHrmrsOgRVDluIMmKziLx5CqiUAZbzf6Zh8CgpxsJbY+09Dk?=
 =?us-ascii?Q?XbFCDKIqJpUfBlJRKq96edHbmChLnUiVsfHgc4xn7LzFBrcLu7glzr+GMFGc?=
 =?us-ascii?Q?VwbyEpnIDyRrNsycExg7X8TjWIL16LFZ24FiBkaRb8MwoxJ6I52OpyqhkhOt?=
 =?us-ascii?Q?HFzOvZcfQNQd1oaAm0BrPECT7f7VmXWIivePAxiLZePabPcszFAaDC3aH332?=
 =?us-ascii?Q?R4IoODchPDU+Fm+Fz6remO/drA602ESOqIJuANS4O6+HQ966sNu9RzkydSmE?=
 =?us-ascii?Q?kRcztGlAGv3tw1duDTB75BvLt0fL2J109OKyBA2e5RTHvXtcSTl4SLj3lwo/?=
 =?us-ascii?Q?4+PiIGp7kS+CnJNJHA3Et6c8QLgj3xNuuDDlC514s+ORNN73NCZqIS96Qdfg?=
 =?us-ascii?Q?/8Se+Jh54rGXqf3NjAIw9Ww8ImXeeXP86jkHFHt7yPpB3pJ8z+m6WluZk+lP?=
 =?us-ascii?Q?ifXPGy1NEzOFaFB9a4wHKUhNx0ARA5CIHQMQLUVZifZXCwKGfwhbRdl+VjNq?=
 =?us-ascii?Q?JH/Xr/1x8n+91B+tMOFxo/5u18ro5yZYVLpf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:07.6802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1945edf8-be94-4820-f658-08ddb2711ef9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 781a5a8a83614..cb66eff499662 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -768,17 +768,10 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
-- 
2.49.0

