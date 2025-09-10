Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EEFCA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9473710E841;
	Wed, 10 Sep 2025 05:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HCCBIYLu";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60FC10E841
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKX0ddobu0QQzopjoQoUSKFJeGa/T+RmCFKx2Bn7/vDHikCzhoXJLatHhM+ABgufnE7A2FrM0tEa+319sohlHwGthTX/mfgVaHlon8CPyXJb6k/dzN/h9LReNcrthA1YBa7rrZzzcYE7WzN7/nWgKA4rTJX73PLq1JdFV/sR2ooxtAMvNEKtECZQuVSIFHi4kMGiMXY7dHpzKBhFe+YdXp5yrfKxgYdCGJyYce1xqgu8mcq+ae9veXEXGB2mGkW105EGHpOgW18Ta9wn/cKT6DD36qIvZJJaPSCT611eq7MLN6l6whDqtx1xx5Bxvbc+Xi9Xjc5n5+tGbO6RPUwf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmgEA6H4ltZQm3FjF/WZtTjzALQts9h4RMvoiP72wbU=;
 b=Gs2Gs5h5Vaj6tenI/0CKOoaW7aPf/7L0LxK3x0YEZpLpmaKHBUVHnLz0ViS18xRPIHkPFe/btCqXI9qOcwXk48HA2bhkLt1buGxDWjQzsbNm4csUuOtxEwO3h3X9QnInirg+L7R6/Q6Eg4GPBJhuW1Wc9vNKBWKEWPOHrC9smG5si+y07CIYwLGCb/4eiyNbnnwY7l6r6Gxed4NmcnHJUm29hcH4D86dA144QwlI/1a4UVrxPrgFhYBQHwHdkYJF7pNS56YEXqoj81ReWrgDpXCwNTiTExcOaExhGjgH9XIYsi+hAn3F5YU2gE+OA11+rJUO01Fo5jNtHV3IV+YZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmgEA6H4ltZQm3FjF/WZtTjzALQts9h4RMvoiP72wbU=;
 b=HCCBIYLuY4/P6GmvRE5u6GTAhLy9KjjHT6L7HJ18+xt7Old4oxiMpVxCcLEUlGLzLsQQg9gzKjV9eORYcLu1oe0LedTo+LUVhJMYhg6YsxCkHR38qRljeQTk4LYqB07KlbU8/56Qc5ECbGqjwjrzXBCe9YO1ei4wnuNoYiM74K4=
Received: from BL1P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::21)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:27:02 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::c9) by BL1P222CA0016.outlook.office365.com
 (2603:10b6:208:2c7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:27:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:27:01 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:26:58 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 05/15] drm/amd/display: Allow RX6xxx & RX7700 to invoke
 amdgpu_irq_get/put
Date: Wed, 10 Sep 2025 13:22:07 +0800
Message-ID: <20250910052620.2884581-6-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: add90954-b97b-4175-fdc8-08ddf02aac1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iMZ2nrcXn2OGi7IpZQaJVtCfWAcKKjWT6Bh2fu7icHJD0L3jmGsheSpkYJeF?=
 =?us-ascii?Q?kbphh2rfsmOQkH9Gx+EoKMXhgekiUBrzkDs7UjZdelOd3Agb7GkUeFtNStVz?=
 =?us-ascii?Q?fKKV4Rw8ORWGt1ps5GGP5wPVC1JtETkM0OKDvLNG4pfccWShwwKhDIEMruj8?=
 =?us-ascii?Q?aZdmdbklgBjysnxnAoRG5+CjhyFFt3RZIsre1T8gG/nmObGYYtgrSsqcnlYO?=
 =?us-ascii?Q?ForVZvXBgLgw/HNvR7S7Kl+Z2DJpm2MmxbsInXCFXz5JNfAWwbZJ/r1gPmjT?=
 =?us-ascii?Q?kz8QfAWo/5d6CTI8x/3rEsFdLRKO06jamZhyhzAUXKDI6BPbAXIZBTQfaNwP?=
 =?us-ascii?Q?vk/NWfo91klRf+MF8FRjikSHtnnUEmycXvl4zIkcVGgVGvK2LuhP7jUSQ0xV?=
 =?us-ascii?Q?y8Xok3VwvHnzpSraFYvWG+btBF3uzwnfGylSl0GOEsuz6YSpz6+DXyW8/TnX?=
 =?us-ascii?Q?taR+/CBvrgA2OlD7qLu7Adkv3uQkWk83Zw3TfcDig4y96vKIuFuA1M//COWp?=
 =?us-ascii?Q?velerGDFfInedvhlxg58J7gauzAyYrnKm6MI9CmtVjJ76xM/QDT3OVfs4iUx?=
 =?us-ascii?Q?RAoXHe6QvhWro0mH4kI+nOEr9YMZXn7+QjCU47QsddDT3Q/AYvz33Kkg5tzj?=
 =?us-ascii?Q?iZGrZM8uFXU5BnzujOBTzf755tMvuz47KDgdL80R7YR8UG8QOl6hZjV63WhS?=
 =?us-ascii?Q?LfnxtXJi+rhgI2PAwG/bMXo63e6baee1iKfHwKhg+fX+fcfKS0fX1EtwMu9D?=
 =?us-ascii?Q?lm9A8mdLfNJeEitjw1bM6AaOBe+k4XhnUoBjhSnKGZG/y+8t1l16TeLEZrEr?=
 =?us-ascii?Q?iw9tRVEWqh0kqSOlP70zeeKXI5h2T2DcWg3mVTCmpia7YxjP6VXMdXw87CBs?=
 =?us-ascii?Q?0uSUqmm/oi9u68nq9Ylhw1tJmCudaMUUesCYR2GPMQ/7nmlhP35bmb7iXpSP?=
 =?us-ascii?Q?2FgYT0LzY9DwFMgpb1xu3LVe8OHfyJ2ujU55Yy35uKzDLyQ2i3ddEvALETc6?=
 =?us-ascii?Q?DZ3hf2RkPuRfjrDgDIzvFCVya+DZNsmhMaaY5nPUN84rNRARGdzNuzhXkHKL?=
 =?us-ascii?Q?z9aqynWaUgdH2ZV/UgkZat8h7DSgOyZIOqzVLb+/wL2PGcCW2nD/WNzueNpf?=
 =?us-ascii?Q?9VV1eNIIn3/3BiDv7rDkuHge3SqEqS7tt0B1qXtRPNqP7Ihv91NlK5V4tFbG?=
 =?us-ascii?Q?JxS+fotPdEMryBmtSH7ycOGEpypzsxyCmfuVC7u3nWZh6XX9dxWSJaDeXtWN?=
 =?us-ascii?Q?mwsVl1hpOn08JW997yHAwtAUmzspuc7tj5P+eOQavKSJxjzYQC0SCdcNj/FM?=
 =?us-ascii?Q?EtUUBZTZRI64Yd+ZaT1/7kVNpy9aPRQbIEKf3u+wRalWUTPR38hnLxIjcwU/?=
 =?us-ascii?Q?vB8WjW+S2OFzBkAa5g3ArZpjl/Vl8PB918PUrKMapvUtzdss7ToLOTKEITTY?=
 =?us-ascii?Q?k9eO12T7GQ5zACBx0f2BOb3KB01m0l11DYjXDT3zMHmy4cL1RTopGw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:27:02.3106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: add90954-b97b-4175-fdc8-08ddf02aac1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
As reported on https://gitlab.freedesktop.org/drm/amd/-/issues/3936,
SMU hang can occur if the interrupts are not enabled appropriately,
causing a vblank timeout.

This patch reverts "5009628d8509 drm/amd/display: Remove unnecessary
amdgpu_irq_get/put", but only for RX6xxx & RX7700 GPUs, on which the
issue was observed.

This will re-enable interrupts regardless of whether the user space needed
it or not.

Fixes: 5009628d8509 ("drm/amd/display: Remove unnecessary amdgpu_irq_get/put")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3936
Suggested-by: Sun peng Li <sunpeng.li@amd.com>
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fadc6098eaee..b088cb8ae780 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8796,7 +8796,16 @@ static int amdgpu_dm_encoder_init(struct drm_device *dev,
 static void manage_dm_interrupts(struct amdgpu_device *adev,
 				 struct amdgpu_crtc *acrtc,
 				 struct dm_crtc_state *acrtc_state)
-{
+{	/*
+	 * We cannot be sure that the frontend index maps to the same
+	 * backend index - some even map to more than one.
+	 * So we have to go through the CRTC to find the right IRQ.
+	 */
+	int irq_type = amdgpu_display_crtc_idx_to_irq_type(
+			adev,
+			acrtc->crtc_id);
+	struct drm_device *dev = adev_to_drm(adev);
+
 	struct drm_vblank_crtc_config config = {0};
 	struct dc_crtc_timing *timing;
 	int offdelay;
@@ -8849,7 +8858,35 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 
 		drm_crtc_vblank_on_config(&acrtc->base,
 					  &config);
+		/* Allow RX6xxx, RX7700, RX7800 GPUs to call amdgpu_irq_get.*/
+		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+		case IP_VERSION(3, 0, 0):
+		case IP_VERSION(3, 0, 2):
+		case IP_VERSION(3, 0, 3):
+		case IP_VERSION(3, 2, 0):
+			if (amdgpu_irq_get(adev, &adev->pageflip_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot get pageflip irq!\n");
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+			if (amdgpu_irq_get(adev, &adev->vline0_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot get vline0 irq!\n");
+#endif
+		}
+
 	} else {
+		/* Allow RX6xxx, RX7700, RX7800 GPUs to call amdgpu_irq_put.*/
+		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+		case IP_VERSION(3, 0, 0):
+		case IP_VERSION(3, 0, 2):
+		case IP_VERSION(3, 0, 3):
+		case IP_VERSION(3, 2, 0):
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+			if (amdgpu_irq_put(adev, &adev->vline0_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot put vline0 irq!\n");
+#endif
+			if (amdgpu_irq_put(adev, &adev->pageflip_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot put pageflip irq!\n");
+		}
+
 		drm_crtc_vblank_off(&acrtc->base);
 	}
 }
-- 
2.43.0

