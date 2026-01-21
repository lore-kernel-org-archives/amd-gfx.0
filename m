Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96141CA5FBA
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 03:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D04F10E6B8;
	Wed, 21 Jan 2026 03:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TJqz+rUK";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD11B10E69D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 03:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nj9I5xfoeXCfGhNWdIMDF0Li30ybJEfXC0fdz5nHWPPIHW+4S9zT3sTPkCU9qWizfIMda7e5/DAegc8Lx4gFdaNozahRBSOT0mBVMjPr859yqxeEfmPOwozeavEocUR7FOHpN/T2Edl1p0dpcHr7S6ZxGLlhfn0uCk0OinKiFsOvDUFVT6I8aOY/rCWmJbCuDcdIVYRiMAoEB+q9+uMASZjUIcdOSeA0pIMoX9lgJKi3i7WIb0Rvzu+vzICnzbIH6VgDSNzU8ePiFyXgehm+skcgzearg5b/PejaNsUEo2S2L/af9NaoRhXvLs7Vw7hjGYTJuHHCRf0FS5Gqb2U+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQBUTPex+wLXzSug1A5R/EVq8YtzhW7g6eth1voshIc=;
 b=hHCI3JxibRETyppd0y6flpRCEpXKCVs09zLWHJUWBQNC9QJtBFMgXFTLoTOMAGeh9UDVKs/MDhZnvCGmWwNVH20p5ROpJ8aPfgs50o3GgfBhE5ex02Yljwz5vUpp9PsLhImI9Pj/b/1B9S/s1DATzMr6b7xeGWcuaLYThqpBbFunRdb2n5A5iVMavKPTla0xLg8qrpshuiqUkwYiQc3FVu5PnU7sPmayFwzfdTlefTN0mkHTydN1LN0PYgjjA+O6BSLtsdOHiMJ5WWcqwqNg2EctgVU3pqrr0oSpmUDdHyT28kCBbLFy4bVhDdqfa3U3IKlpf2RgawyU3W0eZ8kyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQBUTPex+wLXzSug1A5R/EVq8YtzhW7g6eth1voshIc=;
 b=TJqz+rUKQioKbNpm44Y1bnhd2ldfW63imGgjNm59ARFIg2YsPaIQmMPSHQhcnC7ZiVhs+rRWG7m+u2Y3Csg6fyCY1RhBJs8kuSYmog/GbTW0Fmdn7bm815toQA0K78DazlTmDZru6fWFRSFmZmmqdcqQHem0aoUvZAUt5ZUbP64=
Received: from SN7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::8)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 21 Jan
 2026 03:01:30 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::39) by SN7P220CA0003.outlook.office365.com
 (2603:10b6:806:123::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 03:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 03:01:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 21:01:30 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 20 Jan 2026 19:01:29 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 08/10] drm/amdgpu: simplify VCN reset helper
Date: Tue, 20 Jan 2026 22:00:55 -0500
Message-ID: <20260121030057.1683102-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121030057.1683102-1-alexander.deucher@amd.com>
References: <20260121030057.1683102-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 563ece2f-b2f9-4742-048c-08de58996079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O8GDnfI+SuBcWJ6Vq9mxIBHltH1ZNgKL16kxgGiACwfgyVNyqfisOcL2Z4I1?=
 =?us-ascii?Q?1HrqCeOBje1flNdAC0+lpEZPid2kDLcdlakyLM0lTuKMeSSKsL07/w3v/QRC?=
 =?us-ascii?Q?/vWks6gQcf4tj7tthEsb/OODz7j+zw5aSnCOnHZC/xVXnwN6VilYR6WPUC3y?=
 =?us-ascii?Q?lb9eyzk6hpVKYVNamZf5854qSwii4m9Cdo6vS2R8K3BGPEbm42Kj7cM57NO6?=
 =?us-ascii?Q?3SeLIZTVS3OebOXZURcsZfkO+ycMbnq24XqCJiz50RgH3VKm0K4ro/nCZv3Y?=
 =?us-ascii?Q?iplfxBqsVuLK4M/MOe9kBZjwBEo/j+mV/czDtEl2bsKS+ncuLtmRDo5SklEo?=
 =?us-ascii?Q?mTb8/dZ64E2K5fgqzVVyzq7pAW/T7a+OIs2VpOpT2tlxtVmkR4LH64GYwOxa?=
 =?us-ascii?Q?kVtEke38YZWipDO5Bu1QaccfJoKJzcWhEjgH/5jV/QcnSdd+S5gvfGGaVPbH?=
 =?us-ascii?Q?dpQTN+oE52j0Mb1H2JHj1gjhnwDTw35Y08rnocRuFC34DS+v59WhH3JxvOcl?=
 =?us-ascii?Q?Ar04ALLPa2fW5c5YybYNit3UVjSvWyORfKYOe380I2e9bewmW/IE2X3SsWML?=
 =?us-ascii?Q?0DpuVsXFtSzsaU26RSofKlt2UEC5M7KP5dwYtCO9vMNhPnptvEy33CR6m0M6?=
 =?us-ascii?Q?B2G7rJRor602bhLFFdiS/v30+xSnWRzxHTX1pfRRhbei+aGnZiNpIm3jXzfB?=
 =?us-ascii?Q?7+5wlzbfAB46fwkmVAVMxmCqiUaKyKlVU6JocKHDR0aihBA1PQkz+cYSeooZ?=
 =?us-ascii?Q?VroHO+xidagdrjwGrd4aYEuHrRBlTKyG4p6VKQYmSxtFMxSAmaepGqJGDq3n?=
 =?us-ascii?Q?p4oOKFHiiZzLl0FwIgGcskmoJrudTNFwt+Y4q1OB2LYUWSPAv5HolR4qOkvT?=
 =?us-ascii?Q?CWCmjzI1sB1ajlpVdICFRwjr9CTA/ZbahiRO6tb3gOskwN2XYrnePbAUBxk1?=
 =?us-ascii?Q?78IT4rb5lIyphlSUj4F16764tcuM59UEsTMQmS5g8exDk7PuGXR74TZdTuNS?=
 =?us-ascii?Q?ad2GcpQ62IdlA7FTZihW8+OMdAV3GTcf6g5/WkMPKW1DwWKR0Jup3/qtp9Y6?=
 =?us-ascii?Q?gbKfe4T8dGYsDpumDfN1n03cNvYjDTvEsTZRVfjTVM0Ki7DVoZxp/B/0ceUN?=
 =?us-ascii?Q?4GDw03HjFkYhSk6cTQiKgGUJU9GniGvEdrH5jKJSwtKnMyd3+tNQOUqJB05n?=
 =?us-ascii?Q?4VBf+tKngkdQGe+wGsK7Zs14mg2A1TLw6STGyj5+F4vBlx0QFTiGVLR0MxFr?=
 =?us-ascii?Q?DYrhwu48MV38i+AhiQRukVrQ7qOX92kJ9lI/+skhehQ/PbSXrn4tQWkwxSyU?=
 =?us-ascii?Q?2NDWXTMna95Twnnv4JijWG4VP63M/OG9bMiXxpJu+SoBUgS5m+uQLWMHRjGZ?=
 =?us-ascii?Q?zZXSw60gTBCUUdoN8/Guf9yBhRaylHlvruwF5lzfRemRzXXI+cWXMoBBRo1l?=
 =?us-ascii?Q?UvgOiRkbFRaABPlduVVxxlW6yNfotPr7bfbkn1jP5lie0EyMpAdsDxY8upuL?=
 =?us-ascii?Q?yadqXC/vOW4ycGBH2ZUHA77O7VhXAQIDsFmZNnJG32U4gLNTVnJ4BGJ7OsxE?=
 =?us-ascii?Q?Ki2Nvdu6tunLDoDvVUmNYNP/UHq1EeZMU8g8QLJbEs9jDO9zIhCGUKACT7Ue?=
 =?us-ascii?Q?EPYN1ZDwr46npSQAMpwsDI8lQtcISfzyU2Q8gbD+Vhby?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:01:30.4330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 563ece2f-b2f9-4742-048c-08de58996079
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA
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

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
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

