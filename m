Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFF5C52D6F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9089B10E844;
	Thu, 25 Jul 2024 15:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Be6OfBQn";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7528010E850
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZHVw40zcyeW7biv6wB0bqrkfhl2NBD7aBmq3uZp6SqgeDt0NfxdN+WfZwFh3udHZ83ssJ9koW9CJHJZelECEiBciWSFbMcWs+26F1oWSegcwnAvQ+3wYugZXAlIoLSGyXW7/wGVy2SYtlPq/dPK/gGW9VDCuANr9mM5+G3ScAJrsIwHD4U3oLHbeA9SEfSytFMD6WFuNWx6Q4LAmdrxR1/M5HIiIQkO8PIY0zbo54Us3RFbJM73GyVhVWbZPgeDxNHrDsZVtNbajR2pxMjpj+CncZHCfqPZwaT8xdfHKOqjP1EYJmnsYi57B9FCvu5nkz6d6+w+q6cSujvC/smwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPOlCxTcVXL7m9i1YOXsMnGH1Uka+WM/cjEeMytoaVk=;
 b=xgM0TmizaJETlOy86jgZY8AwBenivUIQyzeYXD1LIY7E1lj+4KPNFKU+wnCJ7WlgnkE9AuLLtp+qmT/3OQAXpkgPlCQ257gSDR0DMSz65UP08p7DgK6v+F0noZXjFOdjoLEUmiGs+bqCpKV/mHgbSceYy8YeAwpKs2n8hHCagR3qBU4+qKIPzEcJ0ZpHhCULSPVw1vik85wyNnxyoU+Ar7H/MShyhHPSUjMLWIUltHS6JYXXAr/FDugRLKIgyP0quy89ZaMrWmxvWDmzQkCoXtO5ebolZRa3cP2SPejqZ13ui9Ak4aSIy66CnRz0oNCxwfOjH2frWyH7f+i+jFYLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPOlCxTcVXL7m9i1YOXsMnGH1Uka+WM/cjEeMytoaVk=;
 b=Be6OfBQnON5BDJpPufxwuMsZtVgS8MtpJj6g0NK+m/8wHClB0wR9B0I543gn4d3cLMNTuTU5dAX8A7//D3YbQla9YkfiWe5JAM3jbj9c4Qe/JGw3XHmaK3ErqrUmme8QoAMVKg8YwMJkX3K0ME2Heoux9QyXWFCa8lZ8aaanASg=
Received: from CYZPR10CA0020.namprd10.prod.outlook.com (2603:10b6:930:8a::20)
 by CH3PR12MB8996.namprd12.prod.outlook.com (2603:10b6:610:170::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 15:01:25 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::2e) by CYZPR10CA0020.outlook.office365.com
 (2603:10b6:930:8a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/53] drm/amdgpu/gfx_9.4.3: wait for reset done before remap
Date: Thu, 25 Jul 2024 11:00:27 -0400
Message-ID: <20240725150055.1991893-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CH3PR12MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a3db27-4cad-4f06-6545-08dcacbaa780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RBvxn1cXl44UrAnKFEfao0gV0WOsduPNErYJAgUAPPDEXASXmxeggQqGJx84?=
 =?us-ascii?Q?u7BKVx1HicSEHHBF4ntMfNXnixFJ47ZJsedZj9+3F7BvNlRb5Hj86AKXwjIa?=
 =?us-ascii?Q?EYz0581YM7uAt4o+oR9CMwDmEkEHq3gQX21sMtP8K2KlpBLsed0eqTJeqzcV?=
 =?us-ascii?Q?yyuvmSEMpV7G0mmK1H+2kYaLe9hxkhmomCLKbTxfMm8F85CRGRFT0MMZvarl?=
 =?us-ascii?Q?ILLyQSX1kPlC0VhZrSF3DHQOKTsRb1pFDE9Z6CkcjmbNb1LMKoVr1GtVYJM4?=
 =?us-ascii?Q?c6q7wCWiNSr7j5wMwkZye4/za5+4xZzUYjXE/beQ3iTsuJ13s40YNZSWLAo+?=
 =?us-ascii?Q?bSToys6VuOZEJdM1aDD5XtpTOEsbaxdOSwvippAg/r+/KH/gfPuf3l6X6ofY?=
 =?us-ascii?Q?Mqq6BjYGfctVTcRlyI+eZuP7eFb4ceQQ7A87AVGcFCgKohvqjaQ7Rj2h8o32?=
 =?us-ascii?Q?Qkm9gcYjjnmfowkyC6jexG5fqjx33ClHYoOcoAhY7RKaAoUgmf5DTREa+uQx?=
 =?us-ascii?Q?2hSI+sojgSnS3VbdEU7ARzEgSb88ZgNmlNrnGou5/HKcUp9/NIUMirUwR/mE?=
 =?us-ascii?Q?nCXdPpLJfObSQ0IfkOOg6vLnVZ9apWM2Kw2dySV+DW7DqbTL392TEO6lajtN?=
 =?us-ascii?Q?n+1sYCh34DONjHcpUhZozm7/1e9YbdMiFfIhnZ49xuFkAL7WRzz85ZCVy8HW?=
 =?us-ascii?Q?t8OyNRIoUIYu1rKZupRi2txbp65yisfZSLce9g2Femc8lPcm+lqbwFz4eBv8?=
 =?us-ascii?Q?O+DxYJ/BsQ15weVDT/vBDIcv49kOwzW3lv8A/p9g4+jngKXJ5gtxCcT5tCZd?=
 =?us-ascii?Q?m0t52r8cSxyGaXo4MI7VxxF6l83+00sTYNjdOR3GMN+anIRIc2YxzOzQlZtu?=
 =?us-ascii?Q?qQu9o0kBrmgFhCiD6KfR6ZYHKsQL8S6DmCkXsfm365N/4PR4nLjI9TY/2zcS?=
 =?us-ascii?Q?Pg7YG+/U4V9gUnvK/WsvcjWUHPsmnLamr1/kMIvI/OPbioH5r0qM2LXIYgJs?=
 =?us-ascii?Q?IWrkPPYqj/t1fmlWmi2TiwWd528tXtPiUN43g0IYlqDT0lu6wBaWrVmy5FuV?=
 =?us-ascii?Q?xLlTeXacRLWOd5QRsKjPgK9lFC4f0J22Tqbf6D/kYeN3+DalMW5n4ElwCl13?=
 =?us-ascii?Q?ObKyoupyq0xoECsR0RaR1J6TFkXOEO5731W77uUgT8I3fNXbefiozyryzaUi?=
 =?us-ascii?Q?q+lOVV3vZnDyob3mmZLHGPFGtRM7ib4n8tMRjk7ZIBsWQcVIlAyXk+7YU3Zy?=
 =?us-ascii?Q?g/rteNNGn5SLvGOliKRw0slKTAhCXCXTz/wIaIpFmV4E0gb3FhOOF7hYLSkr?=
 =?us-ascii?Q?WcWZmolPD2QMrKQOihfGRapqy9Udy2w7Aew+xVjzhiG7780V2V3hlPuRvO+u?=
 =?us-ascii?Q?z5+7F8L1L9o5Qye6tz1INtlhvsp18Vgi2k5QoC6G1zqCh3eDun2v8/kzdf9M?=
 =?us-ascii?Q?v5W35myJXI2MRA76T/z86kcOqVUt697Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:25.2153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a3db27-4cad-4f06-6545-08dcacbaa780
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8996
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

There is a racing condition that cp firmware modifies
MQD in reset sequence after driver updates it for
remapping. We have to wait till CP_HQD_ACTIVE becoming
false then remap the queue.

v2: fix KIQ locking (Alex)
v3: fix KIQ locking harder

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 39 +++++++++++++++++++++----
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 394790d00385..a0ff18dd4acf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3270,7 +3270,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
-	int r;
+	int r, i;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
@@ -3292,9 +3292,28 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
+	/* make sure dequeue is complete*/
+	gfx_v9_4_3_xcc_set_safe_mode(adev, ring->xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, ring->xcc_id));
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v9_4_3_xcc_unset_safe_mode(adev, ring->xcc_id);
+	if (r) {
+		dev_err(adev->dev, "fail to wait on hqd deactive\n");
+		return r;
+	}
+
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)){
-		DRM_ERROR("fail to resv mqd_obj\n");
+		dev_err(adev->dev, "fail to resv mqd_obj\n");
 		return r;
 	}
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
@@ -3304,15 +3323,23 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		ring->mqd_ptr = NULL;
 	}
 	amdgpu_bo_unreserve(ring->mqd_obj);
-	if (r){
-		DRM_ERROR("fail to unresv mqd_obj\n");
+	if (r) {
+		dev_err(adev->dev, "fail to unresv mqd_obj\n");
 		return r;
 	}
+	spin_lock_irqsave(&kiq->ring_lock, flags);
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
+	if (r) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
 	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r){
-		DRM_ERROR("fail to remap queue\n");
+	if (r) {
+		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
 	}
 	return amdgpu_ring_test_ring(ring);
-- 
2.45.2

