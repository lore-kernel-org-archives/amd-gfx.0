Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6204D2ECEF
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 01:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB1210E1D2;
	Tue, 20 Jan 2026 01:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0MxmkFGG";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010054.outbound.protection.outlook.com
 [40.93.198.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9200810E545
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 01:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6/L00QYfoPWCyOQKtplVkLN8NVfK3kj4Yp8jpHsA5SRokLxifaB2t4//ye5hM+tkCJ28WFIID5xCmHHv1Ccb+ObPdnTnek7lS4W8RFFAvuvN53H1oMCSoD3HsPw3ekcADsFA9n3sB2fxNqPCmOgpJ8fxjokGSluj5bRbCYAe3eMs+ADo+gOsCDDwCVsI8VvSuRoh1+4vA2eXX3ldmrRm69ug78jfyo6kxfoXBelGtUs5taPmwCh1sbOLktw7ucoKo55jDES7jjxNY/+HXqVNJuQnB+TWZlK8m411fesOXig3GVTFOW+mq4lypgl1Q1ky3c7KzeYy4bVO/a4UucGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrZ+KM+v1+iAoxCIGeFlgKrkCEYG5WJxAWBix6NbgXo=;
 b=UrFykSg2MxZeqUmEhCqN/BGqBbd2WiXHkxdw/zrIqvmnbSdBWeKE6e+cR2STv6AwLdNdl9xAy6ZkuNKRCMbrGrLPdqkHVt12K6jG3UQdJiMQuz5PIe7myHKOeHRfJiGHnJ63pNvjB+uwoRN2m32FdeVJ5z4r7b5t/n2x3A2Kla6PR1znGuUEKPHQGeciovugrx3mRXbsNiZD6Z/B0J6aaTmFsRERevZzscmFhgJzXjsnbpyASwCEIqkBnmjspHE2T2ctefbm4fSohAnvd9oPAuF1Zey+n5zAcyoajY/ogFHHz2PKJ8R/hJTYHRgAPRuNLbO0hIusgVT4UaVUnBiL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrZ+KM+v1+iAoxCIGeFlgKrkCEYG5WJxAWBix6NbgXo=;
 b=0MxmkFGGFF5h7VNMbBg9U9og40K8wje+EVwoNpHOva9Vakq4IMJSWkOzCgd0p80QlWm2E5xUeZPIBGsPu5FiGei3lBznSsPugkUf6sXk393sBxIRMieetplmY6G4pYUYNMeP/XmwIu9K23jVMMlzGxqqrhAHbeuFCEzT2d0CMLE=
Received: from BY3PR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:254::13)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 20 Jan
 2026 01:34:26 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::84) by BY3PR05CA0008.outlook.office365.com
 (2603:10b6:a03:254::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 01:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 01:34:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 19 Jan
 2026 19:34:22 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Jan
 2026 19:34:22 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 17:34:22 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/10] drm/amdgpu: simplify VCN reset helper
Date: Mon, 19 Jan 2026 20:34:09 -0500
Message-ID: <20260120013411.15659-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120013411.15659-1-alexander.deucher@amd.com>
References: <20260120013411.15659-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: e5db3373-bbaa-4e9f-9c29-08de57c40bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TaRImWfPGdD/LEvKX+rCA8tBxzZWTgdjJ68RKrCIDV6yGbqIc/8p5m2ObdJC?=
 =?us-ascii?Q?SYI/BEUT3RdLsmIaphvf/Af8yPCSYl9KFwJiFnVzVsbBJgtg8MDv9bhwWAXG?=
 =?us-ascii?Q?1vEw6/9NXli/0I1Fy6yauIxbyxK3mJKMuTQHd4+Mbh0G5QeP8L6EPddzsuvX?=
 =?us-ascii?Q?RQzuc+PekBQpM9ZJPA2KVSRalOVzof4nsOzT85yvTEtBmfTEgcEm6iKBUgxW?=
 =?us-ascii?Q?vQOyiFB+qIHAsVbWpd/SDOvFd0SyvFZrfiXINOOpOJ7s/dQGtj0FbrKGHM/m?=
 =?us-ascii?Q?2QfD1hK+DwYWIbpUG7kZKsDwtM2nXO8NsNlqRN0OTEdOp97drCwJeBd8A1r6?=
 =?us-ascii?Q?NTXXLe5iPgIYfxHo3htPzj1SeFYDEvNYzm0w2Rt1t8Xf1BEt96xcn8kYrNrK?=
 =?us-ascii?Q?S9dIqlmRQwE2zp2ruAKpwL9jOf+Av78k82i+p4nP1OsgO6Zf736eeu5Osytc?=
 =?us-ascii?Q?KkkMDqgYBV9jwq88zdYGpjb2jE8ZeLMuPhcJ3om3wm4FsSp/o8CEuuSfztGQ?=
 =?us-ascii?Q?SiAnXGUydxiHwvVD3oIPC8lKhUuI4ewRTKzg6FV0yw9nKGNs7k2W2GbaPbAk?=
 =?us-ascii?Q?rP1JtHTnVjo0SXsyMnKnrIjZ54U1sI2OXYmdXsvsZiXIJt0c6ekhodlWFzQ2?=
 =?us-ascii?Q?REOmO/b30pDDVJrDjfq++SpSTniLvQsQG+Pkv23z0qs8E7sPwcUsOOYTDr7x?=
 =?us-ascii?Q?NYc4fYrccbF2K/qo1MHpeX8T3FmBo2/YyCffCkT3x3+CxACTgOD7vu+rlTet?=
 =?us-ascii?Q?6O9qjz+iLUfJRHWEs+bFPA7sUwB4UjCM22Ou36g4fwHwfrrHB5W5oi/QrXki?=
 =?us-ascii?Q?Imaxix9CkA6cfWPc3mo7lP6C+nILD4JcuWdxKlSRZtuwzYBwTuE2y0TmBSkZ?=
 =?us-ascii?Q?jtVr3NuBHUGZMBjyoZaqTsCBPGJJKsHg0V9QZCSRjZeKFZnHfPn9cjs7WwMe?=
 =?us-ascii?Q?SI/6pnnlHazsoBFIGL43pY0NvhIxziHEN6DoH/iJx/WoPJMxNG7iEA3hhsMv?=
 =?us-ascii?Q?MQhiaIDpHFHQWrkFJLfmBExMAc1jDVBNrODoORPoFj9veZXWQzL0/MdO6ros?=
 =?us-ascii?Q?1Vxhl65FDiXvwGfBlU6+IMStmuvFAcekBU0tI6okKiz69xjl04C98zU63hEP?=
 =?us-ascii?Q?WRwQSJCD9XjiJJTIBcCT4/Ng8Wmp7FIBXRHr0WV40Qur5zXyEmFQRBTP+SOl?=
 =?us-ascii?Q?wryroBL7DaldcQLqyA/uRywhfpodnA3HcJfHHQtk8dnuEspUIv2k0Y8doTy/?=
 =?us-ascii?Q?3GdFuhrDtRIHPtcTTJcTKAh9AE6MEafPIdYilZlKEm7eDfXurZZZFFz0kVBj?=
 =?us-ascii?Q?3VGucbwC3woJyEddUAfwzizhl74Mc9XikeWvHPA7OL9UshbSj1U+rtLthfZs?=
 =?us-ascii?Q?uhgps/PTsILMfvjiDs7iqi/PveTgeIW2OsHbhPMKVBXy7Y7as+flmXXkqw3A?=
 =?us-ascii?Q?ADD8Ww42/zXIPlD4c321yKMJx+0rH5d8PnnIOO0hfalPUiUvSO8/toGkBnqA?=
 =?us-ascii?Q?cQ/MDruqXr7dIZxQcAmboNx0RXYNREOmBAEzqjnJgoJydq5Sei5ykfg+l/s8?=
 =?us-ascii?Q?t2Kn/bOI6IZxswXYvhmNXZDNYVmhDaM1Lm5GIjANjuK4d+l3GBhWWHKAebrI?=
 =?us-ascii?Q?qyvjTCF8f5MxKXgh7BgipdyBnfYealElAZ9giAQP6J6q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:34:25.8281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5db3373-bbaa-4e9f-9c29-08de57c40bfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
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

Remove the wrapper function.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 41 ++++++++-----------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d22c8980fa42b..4de5c8b9a4cc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1481,19 +1481,27 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 }
 
 /**
- * amdgpu_vcn_reset_engine - Reset a specific VCN engine
- * @ring: Pointer to the VCN ring
- * @timedout_fence: fence that timed out
+ * amdgpu_vcn_ring_reset - Reset a VCN ring
+ * @ring: ring to reset
+ * @vmid: vmid of guilty job
+ * @timedout_fence: fence of timed out job
  *
+ * This helper is for VCN blocks without unified queues because
+ * resetting the engine resets all queues in that case.  With
+ * unified queues we have one queue per engine.
  * Returns: 0 on success, or a negative error code on failure.
  */
-static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
-				   struct amdgpu_fence *timedout_fence)
+int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r, i;
 
+	if (adev->vcn.inst[ring->me].using_unified_queue)
+		return -EINVAL;
+
 	mutex_lock(&vinst->engine_reset_mutex);
 	/* Stop the scheduler's work queue for the dec and enc rings if they are running.
 	 * This ensures that no new tasks are submitted to the queues while
@@ -1537,29 +1545,6 @@ static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
 	return r;
 }
 
-/**
- * amdgpu_vcn_ring_reset - Reset a VCN ring
- * @ring: ring to reset
- * @vmid: vmid of guilty job
- * @timedout_fence: fence of timed out job
- *
- * This helper is for VCN blocks without unified queues because
- * resetting the engine resets all queues in that case.  With
- * unified queues we have one queue per engine.
- * Returns: 0 on success, or a negative error code on failure.
- */
-int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
-			  unsigned int vmid,
-			  struct amdgpu_fence *timedout_fence)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	if (adev->vcn.inst[ring->me].using_unified_queue)
-		return -EINVAL;
-
-	return amdgpu_vcn_reset_engine(ring, timedout_fence);
-}
-
 int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
 			     const struct amdgpu_hwip_reg_entry *reg, u32 count)
 {
-- 
2.52.0

