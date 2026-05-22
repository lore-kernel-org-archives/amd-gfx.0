Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A0FCD5BB1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EFA10E219;
	Fri, 22 May 2026 00:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="om4XR2MO";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013057.outbound.protection.outlook.com
 [40.107.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2963210E219
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxiOSie9olOFnWmCoX4LZacqURGtwlA9wIExAcvdmLsFhKQ+UH00Wc8aql/HQO1P89TJso/kBPw5qtFs9AOQWRYCU1PqialAHOFP97kmYJ0zAZZm4tbfzgQ1li1B/nVLo8RTtk8MNJ5EpZU2QFhXC5V2D+r6HFxLTUs+++Fu4Re04d+fLnkdvYw8jHgzBbztaOsXuan9HV9yB6XR/gmrT2Z1rIvN/k7gsDDkw2dop5R0ddNGZrz7UDGXXj5dLV1sw8++LnHKKJUwlJzR2TwLPekHBk6oCFZz99pjlLFC8/XWIDDOeWk73SHjx91h2oiJNLRzixb1iiZBSyXl7f9+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO9Vscx9UShsB8128P12549f4w/jKZ9Z+TqTVOietXI=;
 b=PP+jlLGyf47rq87kq3RBv3YptFLPMV6W3RUjZ/8HFW8/rX6QTJjg4WZuR4mlK/jPOQOWTnNN4DPg2/r8Dto+e+qwvb0NY3L67BZRuDADa/Z36+omBeEXYyJ0v+ot+DxailhX0DxJ0T+bJcv8FttYnZIFg/DPTDFQK8jQPa/4Xzgz4EbVzn5rqnHabZwdvDMlEd65GIDz6ob4KmI7+w2MmhBomT3kFYfmFjdCFqkZ4DKTsEJgMCi705DT0+6Z52uo+GEH/dbu/LyCb7x0xiCJI8LjebQmOxMDbxqYBYi+Xu0uD/ZqX3Xr6WlBfwMoAXzmk8IMNtqprqTBX606kS94ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO9Vscx9UShsB8128P12549f4w/jKZ9Z+TqTVOietXI=;
 b=om4XR2MOSx6OIi18rkpmtbmQ/n0TGVuxHTrwWcCcbAQYV1tKdbPuA+aiqCVOGU7ywYO7YdFuaKXezhvUI64Dh/Dykg58BTWZbXh/e0g2a4vRoBOwqRkljTmIDh+j/SFbM3xMxbCHoNYpIZqJXJ/MNP/uHPx99VnpgbT6fLwVGsw=
Received: from SJ0PR13CA0168.namprd13.prod.outlook.com (2603:10b6:a03:2c7::23)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 00:21:21 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::7a) by SJ0PR13CA0168.outlook.office365.com
 (2603:10b6:a03:2c7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Fri, 22
 May 2026 00:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:21:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:21:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/42] drm/amdgpu/gfx11: only need to remap KCQs when reset
 via MMIO
Date: Thu, 21 May 2026 20:20:15 -0400
Message-ID: <20260522002048.98506-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a838047-0698-4044-daa7-08deb7980cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: E8BBp9nCsKTw7M9K0UYggl6F9cLoc9ovQPRKJNh7gMYH7YfY3a5mHapWnFT38sHYUqwp1BpRpL8SGMa4xjbBaRy5OkfwEOHVcRw/Tn/vRtXMoXpC+hd0r9Geok7rvjMIcxJc4oVh/YLSBB5U9hHiYkXx6RywizNtBUK69zz/xK6W+qLqdbeNPmnA45f3D0niyPj/O6fI4JBkiZmQ4FceS4jSdLA/fy2fh9w3Xuu2oP4xgA5AMN1ScLhuCtf9+lVstvINN1efiAxTG0f0yKapQ6azN4/15gVX+022PX/VC780cctthxaoC0Tr3Qy2A7RVwMxGUrsrqxjvwQrODI70QVaKmQAGIu6mrYedZ8VzajCqR7HnL99E9jCLhnZGqeNstekTKkcyMTSmhIzMrn7n5GmCf0sMZNOaRmrJZ/bvmQvxFgBXNmrcQ79TkgG0eTcQ/ullL0R8FxWwOV3DVSHLDRep9l4+dGkzXtlRkJDtK3PBVo+ijn5nnyqCe/ArmOTsFbW965l6ICLNFqcOj+4eIjMfQZB1uURW4a6mKW5/a4ouFa/Ueyk1rJ+tJU7+VyJ3ybA5demUEDFcFT/YdX/XoBw2uI8u37okNtRox6yTbbix6bRAbBVlJAwStPTaXVlf3rQvVWmKR03yXjqi4Qs9al4qusgdc8wqxFASx6Vuxn5CuDm8rxsv+BviJwdw+mjCyZTDO6RwY+/3vLkoxNHEsxVIRQdmpuBOy8kvc4yDiIs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XykklSenEtak35gyiORL7k5jYG42s5xIBy8ZBimQSs7r6oMdR7KPedM7MC3u+2oga4vpCEQPa48W8uBfLot22DLDM1pc8dy32ur/2tUb/naoEmunce40eDO3FxrFPauL/S3eupxPMLTNX05l/Ow2Ag0AZQ5K+xAebPYwD26KqQcnHsF6FqiE/ckkve5mKatFsP2/Ej/c3T94VUqWYpJlwfB/qvmjMvZN2yzdtzk2va40rLywe2VDaLz8M9JfKlEpz2+pBsZCL+iX8AiIM3ngrbMqnEWNgQh+yJtndGE9D36kqHdOSlZhFynIhDi8YPm0l+jaRxRSe2HOBT89M0cWF2hzhA0iqt8yd7GM1QSJb21dIDslYboz4Va9CXsmm7FUOaRAjOe1dljpDvBSdcIeSu2mRoQB1x9uhmv/AThR3cpFYJE6xRMJfac0gyzTZfdn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:21.0701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a838047-0698-4044-daa7-08deb7980cd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
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

MES remaps kernels queues as part of it's reset sequence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fabdbbd0abb7c..dd4f33d2ce45f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -7009,11 +7009,12 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool use_mmio = true;
 	int r = 0;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
 		r = gfx_v11_0_reset_compute_pipe(ring);
@@ -7021,15 +7022,17 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			return r;
 	}
 
-	r = gfx_v11_0_kcq_init_queue(ring, true);
-	if (r) {
-		dev_err(adev->dev, "fail to init kcq\n");
-		return r;
-	}
-	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-	if (r) {
-		dev_err(adev->dev, "failed to remap kcq\n");
-		return r;
+	if (use_mmio) {
+		r = gfx_v11_0_kcq_init_queue(ring, true);
+		if (r) {
+			dev_err(adev->dev, "fail to init kcq\n");
+			return r;
+		}
+		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
+		if (r) {
+			dev_err(adev->dev, "failed to remap kcq\n");
+			return r;
+		}
 	}
 
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
-- 
2.54.0

