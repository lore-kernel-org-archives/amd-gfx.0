Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0C8CD5BB5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AB7810F483;
	Fri, 22 May 2026 00:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Imd1jK8g";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013013.outbound.protection.outlook.com
 [40.93.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7D010F481
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1LYbq1DtaS5sCsHaKPxkEMxZZezzX9varaWB+sz2GqeJxwYRixlH1t4XXC7BFvFbIzJSt3MuL5/JQxiwGtDuGhWY3p1I55Ebhf56hi19Ukx29LVAGeFj0EJgtjAR2KZ+4HMV8ptCRA39eiCeoyrvHAWpnXkCTixPjGvT0buBA0hJnjzuOgHRyIqFEynyDbti+JdLdhqLheFoJutd36bmbIHg/iFOc0mZF3rMDB6bTj844ifuI5QbI1RY67EsbOb8dZf0Sk9F9cZJ+957V1fdIPLXgI4Fo2k0DesWsVgZ11WwCd2C+1EEX6TDZRkUN10/60EVIcZ+pOVGI/3AWA1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCzWuKAFSmeo+05JCdnIKcgQgfftzPHLLgYQnI9lhkg=;
 b=MHR6lJTCfON1HKGTRKfy/Ts8dzk9DK02ZxL3EOVdSMKzlhkkp/nuJsMK7OCTvIiYfw1Lssl7VIcO+z/IjBLKhfX/eRkgAEgb0ZcPkw7FVh0RHQM/mlp+lF62W9xp9Odpk6M/kbgFBNcaT1NLNBV5fgXN82LwXxSq6P0kl6BjQdvN86sMciyT381jVjARSIeuC/4wrSLyhk45w9a91XTASDGRgRF5DDGz+CtEngmowAI3hJNoO3IgHsrE+n2Vvc9ZZHHeDLKg1LRqx9xk3DLSWAYk/EbmN4Tv4g7317tAs0B0TEwutnv48ZEA3Efgr1mNNXeUH3wc1iQcdQntUBkySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCzWuKAFSmeo+05JCdnIKcgQgfftzPHLLgYQnI9lhkg=;
 b=Imd1jK8g4YEi3HiRQiPRDOey54k1nAUCmylN/noXyHRiPAbxaRiGTqrXyOE39dj0uhe10hoNSh07ZZ88hMuNbYdCt6jZNzcwzav9e6/QmUJykwizfjXyIEeNeW+OQFhWUAa35qXymdhdJgAjOMQalJquYxn8HiQtpvk9Keoy4mQ=
Received: from DS7P220CA0055.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::7) by
 DS7PR12MB9549.namprd12.prod.outlook.com (2603:10b6:8:24e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.16; Fri, 22 May 2026 00:22:15 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::93) by DS7P220CA0055.outlook.office365.com
 (2603:10b6:8:224::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/42] drm/amdgpu/gfx12: use the new MQD helper for queue reset
Date: Thu, 21 May 2026 20:20:35 -0400
Message-ID: <20260522002048.98506-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|DS7PR12MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fbfb2c0-6afc-4587-d4cc-08deb7982d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: 7f6cjuZXb4rNHxTtNNNp6wdzqvdT5PtYxUvgKTedQegA//43ZBlmKJXf9MtbhWxGZgMjTWfQY3S7iv02LDRyPn7knpfLPF3L9ybW8oNKXTV9sjbRIb4O57GsHl8Iuk8lnZrV0PRy8u8x9JprJkmX0qaSJ32CCB/+DbofMH7UABFVUqEjndj/Chv8NGf/ttwvwNHJVKopcXeZWsk77BOMCGydUoLhs+rGdfu4/BrOIUhKeBQvKtiSy2bNkCLHZA/d+xedvEKwOcm6J045QnYokho+o0AEReV+4M84uORHegmyu2NSCyLHQA69roiTuh55hVU62NU/E0Dn61TzLQlOrJZv51gpvSB0m6ubCTlwbj2fbn+GV5pektcC/A/7ea2MECkwusoHHxz3Us6xb2YXTKW6p5xzIwcr6+CvJdch0fOS2KgUzJzMYkQ5IpGDlhkeJ08oGb7GpO0ZTFzX9BLA0x6AVi16tnZwOmo+EwaH2om1x+qfj+9EBCEv+eSHYiqlY/oAwsIMfeFRdmdWfzqi0Di5NPhV+OTXtnFPa0855U/xq6kcKH6e1f9gwCNxQ24qhd3+gAuuRq1Uj1dNbo4N4jWa1FXO4J8cj4xUCn0q9D9F4QDAefETxt9fwp8fXchTKZ71CAhKxyOvNLGwRUqvrcP3gXke97YfJIa3S54lcxvGDnqEgCb0akPEiKkgSxumES0eWgPQXo5r8zaHaKXKhUirWkYGg1gPkMZEtm+THJE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vIpSF3pPHDvCnrcjNRw4G+0gR2sD/qscV7ia/O7a5bUkvqUT21B94xDpqIgh8GShgD1kKxpV6n5YRks04aqYjMhoUIT43g+JZoQGntH6AL0HEcQ8K8lGtg3bsvWlVVb+M2d84q4440hBMA7ncxeJyjvdNyhye4lT8yU/qOEh0Wr0ZxNK5q+KJL/UzdaSfqKIauJdp9SUHmjGifH7eYvYH34KuUPUrky2l0nnkVuQe/7SrLxtDt87WEW5CEeObxbmthSPa0IIYGDGuHnH8a2F98ARnOgrJT7QtFFz3FBSG5WtNGghkoq5/jKa7m6+L3fcsYwDuYQbDLisq+1rt+SsbmeOXgoNPX78Jc5fPkfAfpwcP2nUm3sOf3xbNL9nKqQ+voRcLYzS9BMyrlyCkiszUizjkiEQ68t0JgzTdhixmq2Y5eMFJmn/+00ZgWBmvE3n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:15.3200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbfb2c0-6afc-4587-d4cc-08deb7982d25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9549
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

And while we are at it remove the reset parameter as it's
no longer needed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index bc282958fa372..375621f657bc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3071,13 +3071,13 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-static int gfx_v12_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
+static int gfx_v12_0_kgq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v12_gfx_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.gfx_ring[0];
 
-	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -3104,7 +3104,7 @@ static int gfx_v12_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	int i, r;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		r = gfx_v12_0_kgq_init_queue(&adev->gfx.gfx_ring[i], false);
+		r = gfx_v12_0_kgq_init_queue(&adev->gfx.gfx_ring[i]);
 		if (r)
 			return r;
 	}
@@ -3441,13 +3441,13 @@ static int gfx_v12_0_kiq_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
+static int gfx_v12_0_kcq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v12_compute_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
 
-	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -3485,7 +3485,7 @@ static int gfx_v12_0_kcq_resume(struct amdgpu_device *adev)
 		gfx_v12_0_cp_compute_enable(adev, true);
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		r = gfx_v12_0_kcq_init_queue(&adev->gfx.compute_ring[i], false);
+		r = gfx_v12_0_kcq_init_queue(&adev->gfx.compute_ring[i]);
 		if (r)
 			return r;
 	}
@@ -5226,11 +5226,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
-		r = gfx_v12_0_kgq_init_queue(ring, true);
-		if (r) {
-			dev_err(adev->dev, "failed to init kgq\n");
-			return r;
-		}
+		amdgpu_gfx_mqd_reset_restore(ring);
 
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
 		if (r) {
@@ -5257,11 +5253,8 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
-		r = gfx_v12_0_kcq_init_queue(ring, true);
-		if (r) {
-			dev_err(adev->dev, "failed to init kcq\n");
-			return r;
-		}
+		amdgpu_gfx_mqd_reset_restore(ring);
+
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
 		if (r) {
 			dev_err(adev->dev, "failed to remap kcq\n");
-- 
2.54.0

