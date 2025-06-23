Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289A0C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B556A10E409;
	Mon, 23 Jun 2025 16:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zyrY69vL";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C08B210E408
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/9th+iTqnRqJNw4rGwYitDY8icwXzbdSfwKj2e+V3snv9fFhs1Lt4F1zixcu7Yj3tnRsYFsce+y/s462HJDEokcydBoVGTxTd1g1TIqRea6zi2u96QDHyI4fNAuHq5uQCTsYVRRRbQr/+varEieHGb2u1goLtd9tEMYk8vDZualcffIGvQ3TGE+CLlJNfbZ3lxj872XWC2aBvNTzpk9Eftrs36Uj/rC55cKNbEBl1EyD6cqxf42viSb2gMH05L7QII4T5WfwOQeIy2yj0VToR2IkxCDd/YFHUJl66MkDDwT933a3QV9vF8pbmA1/tMIflX09ueRN/YS/jGK326ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAEaglmaQpf4F/NZ9tpFVWnKdrtiiBTtCbsJcZejMmY=;
 b=k5JYac0q6QvaDmTj0QEwWpoAJahJpr0ZX0zWosBrzjIMSk22prFGaXboecyVFL7kJXPNmg8X47FyCbZcjbcpWnme48h+jLI/oDwaWTOEDn3K+xxqO5jxTKdtEPaSsiyBybizLNDJXsBwi1tmH/JB6MmcmZ+ebnqeF9WpkNbu6FoioeuhIGOuDA3j8S2jewGCEAw5Ig4lwJ7lRV+whj3uaK/DfmXsibzz7XBQ7CDrw8+oMcGey40cgcDF//ag4hE4Rl34AyoC6a82eFDw0ymXzRjKWBnNUj/HjiofBnZRZv9HOcKgbhQZEm90gb5KxRg71jqXZ8aLSIRynu/fcYS1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAEaglmaQpf4F/NZ9tpFVWnKdrtiiBTtCbsJcZejMmY=;
 b=zyrY69vLvFIojpOsoJH8aMsbuAQqzcsrqiT5noc3jowIpEtvgipPb+Yba7clzcpY76QytVwWuKG7sIRuuDmCwAJHSfDft5BAVzExWFNx9J9hvBHRsnmaTWUeoZAcXVw+xkqNc4LyaKxt466B7Smsr1Lf0LMne+DUxUI2QCEnZ/s=
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 23 Jun
 2025 16:14:57 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::e5) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 16:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:14:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:14:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/31] drm/amdgpu: update ring reset function signature
Date: Mon, 23 Jun 2025 12:14:09 -0400
Message-ID: <20250623161438.124020-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd2760e-a053-43ca-a626-08ddb27118f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0MraVdldTBQUkpyeWlvcDBYcHlva2RNcW1UTGVWbUd1b3UxVG9NVlZaRnRx?=
 =?utf-8?B?em5TL256K2NLaFNCZ1pPS1BhYWRKYnViSUZWRmpYdmhmYUozY011NHVTUUZu?=
 =?utf-8?B?TFM0TThWYW1XRXN0RzdrSzBrVlR5ajVZaFZZc3g4MCtudkh2Tmo4TGd0N1g1?=
 =?utf-8?B?c1NhMnFSdUVQbTJrT3JiTGhTRnl5cUc2ZGdtV09pcGR4UFkrbWxrU1lEM2tw?=
 =?utf-8?B?MXFJZllXaGJuMXdxNEFuc0l0QXhQK1BEdFlyMDNwZCt5c0M3aDJIUUt2NWJj?=
 =?utf-8?B?cVRKYkhZTktpWXNycnRTV2pES0RUR2pZS3EzY3c5MXczbmwvdnVVZDhmME5q?=
 =?utf-8?B?Z3JUdTM5YzF5TGVMTzJVamJ5dFFyTi9kaTMvVno0THlFV1ZBZ2pVN1NiamZp?=
 =?utf-8?B?a3NDanZETEJGc0VsMzEvOEJrV2xFbDNodlBEVnovV2dsZUJjd1JqM3JsTXBt?=
 =?utf-8?B?VU81U3RsbjFHVk9BVWVnVUNNY1NxRnhkOVdjNEg1M1dtSHZBSGR5WFhaNDZJ?=
 =?utf-8?B?bVA0ZGNDVlFqNU5UcWdacEFJQzg4M3N5VURSMVZOYndMcndZZXNiSUYzSDJr?=
 =?utf-8?B?dmdsazF3T0QvdUhTcVVJZWNyMldOd3N4Sy9oNGp1VXp5cENGSnJNWWRtNGNC?=
 =?utf-8?B?VlNsYXVTakdPalo2SW1vQlVna1B2WEVWb0FsRVQvVXhaSkx0cWF0eWsxRTNv?=
 =?utf-8?B?MThxVWhGQzl0Nk85V3hIS2plbmc1TU1pU0dsb3JMR2RWTWNNdWVEeXdNL1pG?=
 =?utf-8?B?V2Ivcy9MVDRZeE5VazVOQjF5QlhOVWd2ZllZZ09uczdNSjZYdlo5QlAzQU4w?=
 =?utf-8?B?V3ZKenVZQWZGN2hGSFdQVUxoV0NjSzdEWERocFkzSkc2Y1RubzhENU5UbGdw?=
 =?utf-8?B?WXkzb2NvcjNyS2xTSVdBYzlNcEtDODBnOFZnakdIZmNyMXdJbisyOWx5VmFh?=
 =?utf-8?B?eDRSVFJNb1VpNUNsR0dpMzk4R0NtZmdqN2QzTkVyOEljOUd6NG9ybEpWZjJW?=
 =?utf-8?B?RWd6NnpFa2NtbnQwbHlrc3RKUTkrMitUclhCQjV0ejFhT3NRK3hvYTNlK2gv?=
 =?utf-8?B?NktYamtlYVFpdStLSGI0bFpVeTRXc01YWnkrOE53MldGS1p4b1loVWhZVXo4?=
 =?utf-8?B?clhQQ0JCWS8rMlFwejRkeW5MQ0R2b0pjMUtpU1VnMHZKb1I3M3UrS2d1RUJy?=
 =?utf-8?B?bmtuaC9FWERVTnNCUUU3Mm9MeDF6ZnhTQ1lqMTFmTmR5bEUvVHR4T2Q4T0Yz?=
 =?utf-8?B?MGNTeXBMOFJIOUNyNHplSGp6WjEyZjc3NFVjOElESHlIa292MC9GTFZNV0ho?=
 =?utf-8?B?L1FjN2d1VTBhMG5seTFtcnFQQ1o2QkhZa2VMcUdSRzZ4dVpHNVp4NGpuTkR3?=
 =?utf-8?B?a1JSNnZqMmpNS1pxN1BBQTlnTUJ3L1gydGpzdis0WlhpTjdjTnAxRWx1KzU3?=
 =?utf-8?B?YUF1QVJnRGJSbGp4RnFBQ1J6eFlGazgwU1BKWm1TNGkzRHZvRTNDQUdpN2FP?=
 =?utf-8?B?d09NZFNrWit6N01lRm1QNVZuTjdaUWZla2RHanFiTHVjRnhOQVVxU1o4R1hS?=
 =?utf-8?B?aWNwV3VMZXZMMFJqQ0pCWjNJa0JRS3ptcHNSdVNwWU5MUTJTeXRWSzlMby9k?=
 =?utf-8?B?OGU4WXA0LzFUZnJ6SFlPRW8zMWI4RFEzNzdDdW9pZzNhMmVqMmFwYUw2dk1H?=
 =?utf-8?B?ZHhpVE5CT3VUV0owWlI1MGRCK3J6WnJWdmxKUnc4VW00MFlQYU1HU3AwUzA0?=
 =?utf-8?B?aSs2MXNUTkpWWDcvSDgrRTVyanRBWmZFbFFPM2Rrd2ZvOVgzN2RpZWh4REM4?=
 =?utf-8?B?c0Z1dUx2Z1AyQ1ZDRlFLdWYwMmVyY0tKN2I4Yit6RG4xV0tIaDdZamR3QUpj?=
 =?utf-8?B?dDVsSkI1NldpMyt2T0JTYTY3RGNqRllQaXpuVlB5aC9qZmp1ZDFTSy9jaEtk?=
 =?utf-8?B?Q3o0NmVERzVUNGh4TnRMcDlvdTFyYTRJSjltSmR2cXJwVGpwRUtrME1BL0VR?=
 =?utf-8?B?b2FmUitqMnlyclVXUHZqSlNUYVhvQVc4amtEVTNPMXJpRXRwZGl4V25MSHdx?=
 =?utf-8?Q?K5Yc2H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:14:57.5594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd2760e-a053-43ca-a626-08ddb27118f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099
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

Reviewed-by: Christian König <christian.koenig@amd.com>
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
index 9ae522baad8e7..de972f69d96e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -268,7 +268,8 @@ struct amdgpu_ring_funcs {
 	void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
-	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
+	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid,
+		     struct amdgpu_fence *timedout_fence);
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
index 75ea071744eb5..4b2af95203b26 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9522,7 +9522,9 @@ static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_insert_nop(ring, num_nop - 1);
 }
 
-static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
@@ -9579,7 +9581,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
-			       unsigned int vmid)
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ec9b84f92d467..8d5c0ab016d2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6811,7 +6811,9 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
@@ -6973,7 +6975,9 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 1234c8d64e20d..795bd353a9cea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5307,7 +5307,9 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
@@ -5421,7 +5423,9 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 866e39f6fab3f..d91e0423c4820 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7172,7 +7172,8 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 }
 
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
-			      unsigned int vmid)
+			      unsigned int vmid,
+			      struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c233edf605694..272f0f8e41d45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3552,7 +3552,8 @@ static int gfx_v9_4_3_reset_hw_pipe(struct amdgpu_ring *ring)
 }
 
 static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
-				unsigned int vmid)
+				unsigned int vmid,
+				struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 4cde8a8bcc837..93eb71d2ce304 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -764,7 +764,9 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *timedout_fence)
 {
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 8b39e114f3be1..45b8702d20ad9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -643,7 +643,9 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *timedout_fence)
 {
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 2f8510c2986b9..9bd0ae4a24a1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -555,7 +555,9 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *timedout_fence)
 {
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index f17ec5414fd69..4fc1ef85b2945 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -720,7 +720,9 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *timedout_fence)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 79e342d5ab28d..bdc7612ba56a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1143,7 +1143,9 @@ static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
 	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
 }
 
-static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 3b6f65a256464..aee4f50a0f52e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -834,7 +834,9 @@ static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
 	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
 }
 
-static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 5b7009612190f..a54b2b7f04b20 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1674,7 +1674,9 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
 	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
 }
 
-static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
+				   unsigned int vmid,
+				   struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 37f4b5b4a098f..2fd72c85cf014 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1539,7 +1539,9 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 0b40411b92a0b..21421f1bd2095 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1452,7 +1452,9 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 5a70ae17be04e..8684529166160 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1537,7 +1537,9 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
-static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int i, r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index ad47d0bdf7775..56f0a404c8e35 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -802,7 +802,9 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return false;
 }
 
-static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int i, r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index b5071f77f78d2..244359fa4aacb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1967,7 +1967,9 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
-static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 5a33140f57235..75c07ebf7fe4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1594,7 +1594,9 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	int r = 0;
 	int vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 16ade84facc78..731f7762c3e0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1465,7 +1465,9 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index f8e3f0b882da5..f975994b3ff44 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1192,7 +1192,9 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-- 
2.49.0

