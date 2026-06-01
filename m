Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA18CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365A7112DD3;
	Mon,  1 Jun 2026 05:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4oeyO9Sc";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761A7112DD3
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNM5tkArN4rRlCjCqgG45afmI9JA590WXDRXuyMR188T+q/3pFCbSrzPQSET0ZW8ZlLqxc/DfL0HPdgANIYu5y/QUMm2/vlWCegtlhUEMHBUWuDjGZ7ZRIaS9nk1tGxsnHB/ykadStWMTbb0sQdLnsZR7aDr5KPIUm8szr1InQXCBlD8bcLctWoDefuajli/c6Nl1zfOJuzGRaSnrRnpg+k3+bcQFAXdfwSFi51pseBo3IDN2QBRftm7P3HcBKhqoMXzCNQlN430JGa3S4J3/sPxQiZShvmkdTuxqtGVAO7OBHyDPfepNh8L2g118YgmNX7JPwdnWkn2g9tuNLgY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxGbhH4MBdMgDhyaPzhzea+1godEBWvZ7Dep4bmaqI8=;
 b=D7ajr3TYGYnTO2Glno+lxs8CdlKoTQ2LgFTIg5B/j06pwlCDGZ1PIGDDVLTHrttAnjdX2MJTIS8QcQGcUx3TQJRfNHMETCUpSx/MU5Ng/lHERJT9ivt6rMiDK2Bal8NJ1UprXmW5/MUwZI7ijhVW/EsEdcHR+fX0SUxtN+h5p5RuqFF8/MWNdxs+lIfYMhPkpfjiNMD7w2zZ0c8F+Xm+GqQjk4Llw0YDafEL+nmcYNQF+SY6RJUI64ThI6cTKbkXjV+oImK2gDxTpToPETksRQVSrDWqePTn4M2wmt9MYRBQcDnpRru1KGg68uLO7nD28JqNazf6E4QRMy5q2+1J1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxGbhH4MBdMgDhyaPzhzea+1godEBWvZ7Dep4bmaqI8=;
 b=4oeyO9ScRIljQUGiX+/+4TwTjyIXrcLl8KwM33IUIw8Mg7GWN5wHFQkCF4WvD4hHyUC0sJjl1n2I6lveBgdopDxGAPvtddVmZFkClM7jn+ZaoWtF4WID8mmLM+p9dGSBufls5b1gr8JlUee/iD+O+vH9uRKdvOLDvYDQJVlraxs=
Received: from BL1PR13CA0067.namprd13.prod.outlook.com (2603:10b6:208:2b8::12)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:54:14 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::9e) by BL1PR13CA0067.outlook.office365.com
 (2603:10b6:208:2b8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 05:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:54:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:13 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:54:07 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 29/42] drm/amdgpu/gfx12: use the new MQD helper for queue
 reset
Date: Mon, 1 Jun 2026 13:49:15 +0800
Message-ID: <20260601055034.3700921-29-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c558493-0022-4aaf-e0ba-08debfa235aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: uK5S1bri4YUsVsoUIfArjp7u77uERd8eTORZox+BbsHrphFizzDaQih03zlhu4we0HsIpRt6fxVR2+0R5GrCOVcYFoVFqg+MF7QwZqXQ3/9BJLjhucMO+o7Uh1v/bKFx3bOJG9JKMV064hIvV1/B3b4wQ97JXSuMKyjXN/PNtHFdhCw/9CBXoSKyD3nYFe6vfIHdMQDDZSvB+Y10m/DlgQmnkIzfVc56NZUiHq2cf71OZzxgtAI7Q5BnoSsqbpw1qodwD3V4jnHt93g2N6Lp7L01pg4nScC5SKPOBoI8JrWwnrSxur87k/S2Ux3f4m9zzO0rN6axAOSgZAHerXq/oRjB7iMo53BXSkVyE9OKjwbAzOs4EmH3yks1c5aGdKDHSicRwV6eAvdBk5iBUFwtG5O+eFFeV581oXliD4K/JaF+oyII0I99p+XYV63OQBZB6fat8gg8gj0k5lsV1E+WG04KcxGzeRTZJlT1k3qC4GPwefqQdsBZFDz60dsfTVkuZRieWQp8jRKWst+okJGR7oXvdr0wpb6EKHRhNfoR8lgqxc0X/I8mfmxF1LuKfWOzvaOgUR7gC47XBrxfiT3/LOZcPFvANX2E8N7hUJXQiUYmoQ8NOtVvGlHrRv7lzr5EDkkw+9ayXwodXGCvsg6UaDpjJhsmaaGLxQxknKRDAsTZhzcjqThXxxs0Ag9SpqRWvfbG8xF0Fs6kLBQuOJ7co9ti/n7ujOtvffZEosribKs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wd5VbamDLkeygRtDZGdktYX1lDmwFNwyrR87z29VRv8TEEBjSAZrdngH2jnM3/r6tB3y0fhy+9mkq/+3z9pBr+fvX2BfAvemYBqG1PlMgZxobAhPeYa6sYLHns02/xP9pvI44583wv3ff8/0T0XF0lVYnf1TiZTXitydFnnQll3szGw+tcL9ekB4G4KvE/81n85powffkMp1/PgRZwKMnPRdzBjhJ68wbDnW07kbgiWlb+nZCgTLJ+8yln0mLiR9Ty8R/ye0cB1Zl9I+YZgrXR7jRdrFi3QschHqyTVpBn2PYcBaHj+AFexDHsJxn6NQLrT8+73qe5I2VN2UN8bfW+DEOGXNOITuAj1MpkSAMRqMjw+ovlfmGObY/UiPv2I8l5NemZrFaLyrfs4sOiT1kHQL8m5IRv4860UEUHCDzbJb0h1afM7wUZGyiSoseXnv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:54:13.8756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c558493-0022-4aaf-e0ba-08debfa235aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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

And while we are at it remove the reset parameter as it's
no longer needed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index bc282958fa37..375621f657bc 100644
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
2.49.0

