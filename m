Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03319C71159
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C0D10E47D;
	Tue, 17 Jun 2025 03:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aEW9Z6Qt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E32110E47D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbxVFlRai04jDfQs89lQSSUofOcFVXab3RYoHngzvsh3RNgFfn2V7zPqXBZV2jfiXv7BKrThaD3Vsv5isygFzkVKlSB6dX/+3zqgjDiRuKrufAdtKH5MwCTY24SDI5t8V/T3JaFBmmQunr6ThcH81JFiFCsftk69ic1x/or0bp83BJ/SWSY/NleMC+cZQl9gHJqPP8NdL/Y6cZYoTMEPruJRVcjEVRrfk7lDOcg+MuKSDt2kW6Et+bHxm/cGGOUtS/g+nGmORgXxfrFs1aIAcCzx4ln72ZcLnR8XbM7b83YtuRfid7KyXkFlS+vju/1D65hXk1OFoPNLt8ftZIxqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbQ+VuY6frtPLZtVCCXdV4+R29b3FUoxOuReUe/FICQ=;
 b=FoVBLidJAHfYjWoPh0H5V4U8zCPKyNbLrjmqfG6IKW4btY8dCQ3x8CT7ufyVxXUq/vrAOe4U/wwibaQlrJNa+NlNE7CExaLqXSELjC8NFd42FGJZI2T4NXYQTu7NIJgynjAxnQlABXKGVZOVGZfs5KXJOfgIKaN6+wy8PVM6PQFKZ1qgJTBg+oVaET0FopB62C77KrNd/hQki4SfudKyAu7y6guW8sPSczdrZGzp8tH/+xB2TRJ6sj+Qxl8Xr6w/UJuVsAW7Jl4CqkDhdKx8eXelItFJ/n5muHWWqiBYZuF8JFG5SMIZakzb/Ma03qj/ehVoea7QkHVNJ0HPWafo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbQ+VuY6frtPLZtVCCXdV4+R29b3FUoxOuReUe/FICQ=;
 b=aEW9Z6QtsIeN+njgsRrC0EFKFcA9a55yNWhjaqWqv1T5qGl2VP7+0V3hjfXdBBVEL4I+v6WIJfiJlpu9yaY7UPPbpnm8r72EPP5JbDRF6jODlBDrPNc1NRToyyfd1DSqjEs6pDylLymqlE0Jd99JzsUPVPFVCm7i9zG7fgZwJDg=
Received: from MW4PR03CA0008.namprd03.prod.outlook.com (2603:10b6:303:8f::13)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Tue, 17 Jun
 2025 03:08:39 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::30) by MW4PR03CA0008.outlook.office365.com
 (2603:10b6:303:8f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 17 Jun 2025 03:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/36] drm/amdgpu: update ring reset function signature
Date: Mon, 16 Jun 2025 23:07:47 -0400
Message-ID: <20250617030815.5785-9-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: bba778b6-1f4a-44ef-8fbc-08ddad4c41bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2UH7yG/F3KAIIyOWP0vdgSIOTaN6hlDNut0kYorrQoDkCHLrlokRYD5dXs91?=
 =?us-ascii?Q?m6VDG0bU56d088ySXC4gL0nkplzJFaVFUtg7cWKHfuEeYmBkpIsfpnZTO7Iw?=
 =?us-ascii?Q?kHf2wuDE3boiJYBs5wbtiV2qz7cXLqFnyvLnTZWzne7gBBBUniTYmi1DnlJ2?=
 =?us-ascii?Q?/mhifao4FUkzbniKER3yCRYxulvquHDnRfB19X78dNjCGiJHBD9IAj3L2Inu?=
 =?us-ascii?Q?9id+7kgjkg8p+ZA+Mh4R8P+h2VdQwbcc3ekVo//v7S9BNN/bkEedbT5bbSO6?=
 =?us-ascii?Q?X4AaG7dxexIEgxtsVx0gChz7nzFfalwJqwkAMK4JaVBqxyjPScbwQ/aFIfwQ?=
 =?us-ascii?Q?nBy/RwogiEIFIGTTUgd1XbQZ2N/WKApUPSsLaR/FDdUnsLKi4j5CSyYuHlxg?=
 =?us-ascii?Q?PCKldQ3LDh97iBy4ntEjU0uhRJY37ULte3cw7glEsx3k17MZhqcH8Dkscdtp?=
 =?us-ascii?Q?TQoh06dmW0O8JkX5ViISxCfsAbWXoX6o0NtVIdREKqFolI+IUQrxWflrVTYB?=
 =?us-ascii?Q?897DlYDLU8LRIg2R1hs7PittHhYOfeHxHvkcxf3qNiKkf9y8wbwl+E2Qxg1B?=
 =?us-ascii?Q?cTzNWOJGcJUQW70VBEHHuSV/4kM9C3Rj/vkOWTYI1GogrUkeUceF+rVf0+kI?=
 =?us-ascii?Q?oUNbU6lS3oUsAOfOgL2pNlSrbc8PGcI2O4X+HYzHW3Bh9LQ7DkpiwNkK/jfd?=
 =?us-ascii?Q?elCTmFrcCM2ow8AcPsNJJ01RJZnQOpj2bW7FBPluDZv84Dy845t2cU+iNGt3?=
 =?us-ascii?Q?5uaRfebNvsmjd5/o1hgeDVcW0jC879ArudVJ7Zo8kLhkfOqXYDJ1IzmPlc39?=
 =?us-ascii?Q?E8VbTn8cbwwOcsAexEjMu+R+Rpra9Eg8d2/Gdb+Jq8sZjDGSiW/ySoL26hAF?=
 =?us-ascii?Q?232WambSRLF1tbUIwXoUbb42GYy1jk1NkEl+riGD6J7ccPsVswJh4oZMeP9M?=
 =?us-ascii?Q?daPI9SJ54ieCXWSCVnq8d/OMQfxmhMn6ynrEcIHyBm97gVDyIVdnI/LNURKi?=
 =?us-ascii?Q?G2KuyvawnXIxGcGCJPxueJFSooe0rC8JttuJiYLs7ssqo+dqnw/tEm4TwTZJ?=
 =?us-ascii?Q?Vc/M/fOguG1MRprxiB1s8JtqxfdHdNoCFhIAMrayRmOR1G3lqTF4uoGApL7f?=
 =?us-ascii?Q?t6RotALsXpS1x/7lxysqLowKKKJLaog4JLsv5kAmG0mysQGn2+DF1eFSkjtU?=
 =?us-ascii?Q?nVs03BWKGfIso/06PuJ8iuCgRELHuYqua8HOKzEfX5zS+SeZopVCSJXCb33g?=
 =?us-ascii?Q?k8UPLPFxsP26jtOXGhg8si0yHwKeQSJxUrMbEddyXKpfpUn6hbCmo6rsLDIS?=
 =?us-ascii?Q?6GhE+IaVflPJHE2Uq8+mmOKzL/qR/xaiI2DhpXWjD77R0Ltb8sr/fF+RV31p?=
 =?us-ascii?Q?FN3BaW25HKZ/DBTnHEsTXBi9WYVu/HD3+MvYz6UR9N+h7VE6yQghoVOeufXF?=
 =?us-ascii?Q?eF5ZgtNGqZOqIgXe7sKkqCXlCbBmb4RImmP8FexGAW6K6aNCZdJ5ns+8MnCI?=
 =?us-ascii?Q?s7ccfTbP26I3qKRaBdNsOlb6ZNPK2Kuu76or?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:38.7327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bba778b6-1f4a-44ef-8fbc-08ddad4c41bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
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

Going forward, we'll need more than just the vmid.  Add the
guilty amdgpu_fence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 4 +++-
 22 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index ddb9d3269357c..a7ff1fa4c778e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -155,7 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		if (is_guilty)
 			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
-		r = amdgpu_ring_reset(ring, job->vmid);
+		r = amdgpu_ring_reset(ring, job->vmid, NULL);
 		if (!r) {
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_stop(&ring->sched, s_job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 9ae522baad8e7..fc36b86c6dcf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -268,7 +268,8 @@ struct amdgpu_ring_funcs {
 	void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
-	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
+	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid,
+		     struct amdgpu_fence *guilty_fence);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
 	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
@@ -425,7 +426,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
 #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
 #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
-#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
+#define amdgpu_ring_reset(r, v, f) (r)->funcs->reset((r), (v), (f))
 
 unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 75ea071744eb5..444753b0ac885 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9522,7 +9522,9 @@ static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_insert_nop(ring, num_nop - 1);
 }
 
-static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
@@ -9579,7 +9581,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
-			       unsigned int vmid)
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ec9b84f92d467..4293f2a1b9bfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6811,7 +6811,9 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
@@ -6973,7 +6975,9 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 1234c8d64e20d..aea21ef177d05 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5307,7 +5307,9 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
@@ -5421,7 +5423,9 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d50e125fd3e0d..c0ffe7afca9b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7153,7 +7153,8 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 }
 
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
-			      unsigned int vmid)
+			      unsigned int vmid,
+			      struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c233edf605694..79d4ae0645ffc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3552,7 +3552,8 @@ static int gfx_v9_4_3_reset_hw_pipe(struct amdgpu_ring *ring)
 }
 
 static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
-				unsigned int vmid)
+				unsigned int vmid,
+				struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 4cde8a8bcc837..4c1ff6d0e14ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -764,7 +764,9 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *guilty_fence)
 {
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 8b39e114f3be1..5a18b8644de2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -643,7 +643,9 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *guilty_fence)
 {
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 2f8510c2986b9..4963feddefae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -555,7 +555,9 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *guilty_fence)
 {
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index f17ec5414fd69..327adb474b0d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -720,7 +720,9 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *guilty_fence)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 79e342d5ab28d..c951b4b170c5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1143,7 +1143,9 @@ static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
 	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
 }
 
-static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *guilty_fence)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 3b6f65a256464..51ae62c24c49e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -834,7 +834,9 @@ static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
 	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
 }
 
-static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *guilty_fence)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 5b7009612190f..502d71f678922 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1674,7 +1674,9 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
 	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
 }
 
-static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
+				   unsigned int vmid,
+				   struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 37f4b5b4a098f..6092e2a9e210b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1539,7 +1539,9 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 0b40411b92a0b..2cdcf28881c3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1452,7 +1452,9 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 5a70ae17be04e..43bb4a7456b90 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1537,7 +1537,9 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
-static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int i, r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index ad47d0bdf7775..b5c168cb1354d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -802,7 +802,9 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return false;
 }
 
-static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int i, r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index b5071f77f78d2..083fde15e83a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1967,7 +1967,9 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
-static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 5a33140f57235..57c59c4868a50 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1594,7 +1594,9 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	int r = 0;
 	int vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 16ade84facc78..4aad7d2e36379 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1465,7 +1465,9 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index f8e3f0b882da5..b9c8a2b8c5e0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1192,7 +1192,9 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-- 
2.49.0

