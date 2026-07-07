Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C67C43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E6110EE2A;
	Tue,  7 Jul 2026 15:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MRtjXmWa";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A6210EE2C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7BVI+SuWdFJ5rp3WE4iX57ljGJueYEr1dMOgwTwU0mN0K3ATX08fOutXXw2+qr7AweqrlXV3vz0N/2/0vCpEdFEwcr1ll/AN9gc9CziP/ast02Iwx0GzBcb1SKdYgolMhgmUbaqoZkYbLOqDC5+FP4vCZD54QQa6yjmgsqgCm37ASXlQ5pZuwL/hpYzv2kVfULmP4derLfFi9B6TkQ69QRKY1clD5Tbi/qeE9R3R1p/OtOJaplIywN/3TRlavovndmbqA8OIBzvy1gxY6saLjd/+rBM/RhtEkqTYhUa8PwcizMsmnrY78zBFROv1yDZ+mPdBt8wqiVaiEoH5xzMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAAplT/vJ9OuG3C6ksZWPdvDhJiAiWsDwfvcOxdYQ1o=;
 b=DM+1lVEkvUj0CRYBek/5TXKu8aAAnSnEL8TtCFfwNFUY4p+51TneUFqJ8TOYy2DcPXSbUdRu8VDGF8NTyNJ7DKzpklF4dFtFIYyDbjn3pdi4q1ms63eopbq1nnbYib62Ni1vj+B5oP4ri5q9qXV1I38UWWZiYrkEjmQbJbzKwl4CW6iKSrX3kfEZofncuFHExCU/WGoIYXomZ+NW+SmUBGnhjcZaCp4LPw/K0mFgfMdRRCqGbUVSG/RcF2XHEfU3NSsHZFQ3ZqSzOQOlDRXiMb+zlUhgRZliay1E1CIKoN9EkRu+piKWtsyYVnSGYtKssGNN2l8UO91sxAq/YE9jdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAAplT/vJ9OuG3C6ksZWPdvDhJiAiWsDwfvcOxdYQ1o=;
 b=MRtjXmWaz9dMvmrThc0r35w9yEqe77vg/fTzCntQ1Do7DC+F3yc2K7te1x7lskI/y1hy5XPX3L8u9+VCUEGhdBefk0ktMQiMSxcBNNwgRnvFY7VOgc5HD8T24ccbaJzwSUv7up72TuXxVjeYQhQwQ4cBj5C8o1GjulyBj0gD0yk=
Received: from PH1PEPF000132E9.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::30)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 15:42:49 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH1PEPF000132E9.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 15:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 08:42:37 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/30] drm/amdgpu/gfx12.1: drop all BUG()s
Date: Tue, 7 Jul 2026 11:42:03 -0400
Message-ID: <20260707154203.2603209-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: cb92d6fe-f4e2-4cb7-ddaa-08dedc3e658d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HqtiJRMXx3Yr/X5DMFNGBUdMrD2FkYD1vujsqucu15U60sibNcGFYPFDIFlgggVOHfUPeFggYYdtzskEPC2j8ou44uyhdSPlB6bWhuNNIRl3oqxrWybdsyviRrj0uQeq811mkCk1c1EF0AEfGuk6Pxs89nMA2r/6jqjFqN5qcBRuezXeCtwGtDd8Gny4mdCqnN4l1dBqQx1yWVCIpZmg+qHCpkF1A8kBO3lWsmXVVl6FEcP3QTgQyuyv7wn4wQJ/DUP/yFqKXZdg0EKYH4SDZqtzqM3kJxCt/RyGIsILmBj+XuLzOKmoC6RoQYAJ2qly+a7RetcsdAfsFTpNSIQtAcqwysTDsfsHE0GRWfhZWWpE0f5jVmVSTFr/ftDPlv44X4g02a+/zdRpZbWgy+Gsp7wQ7SwFA8yd7xdbTLaUReaw+iOfWUBVBy6W1jvurYbuqenr1gm++BOE62U/5rD9YjCnms1JiLJnRUnHwsClbfMG6zcE5+CMadRXv29kmLiBh3UNMoEUOhbNlxNar7BMX3UagdzrFjhd7bB28zlSA/yR0GtGqP2QPexRx1jpGplXcKV5zO+D6D0WFMIks/V9/sJpXY3yzsuBTu8p0LWF+bXCdlNTClvL3CKa9WRQCOKP+fpRp7QlH1H3AHwm3JXUeZMpPAxiwwm7QqKMSOaQX/dN/gZmXHcITVSlJVcKskMgSvFKPTnxC6naRU+AI4+NLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jvf8NuL87yWelZltxyaysooKXcnqvVI/aIp1uusrefJJED+caqrPGTxzHn30dteb0H/pyHjBXnIY2QoJ3u4jLgsHGlwPHTTS7I2ssaPprC7vdrbDmKV2UbhYek1GLL1rUc8wIJSV6BQ5OVULr+/KwVHia55hubhhFEcwJ5i6AWrUNmvTelU4DjAc0WZNMoRI1PRl0PzTBMqo6C7jNanNO7f/9AUlTVRSerPROUW1+gJMj1vxgj6oBiKbTb7ih6GEcemgIT7Ou07p11tDyc2yKbQ8X5uhncMuaTeUHKlcQwL1g1VJd8H4nDMQUPS4BeYZFTAuYCDtrBQ/CmGxsch1No7x2X3qzYtHecUxvcHBMJJFPhZwVHfxohBZl02Wkl05RgvsPANuhPpU+mhobhymKFEo4RwroWRq2wjehDULL0s1vPJm9OXU0tNZbTr9WjcL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:48.2254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb92d6fe-f4e2-4cb7-ddaa-08dedc3e658d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index b73f2c7d88be5..cefc2d03f0c69 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -891,8 +891,7 @@ static int gfx_v12_1_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
 		break;
 	default:
-		BUG();
-		break;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -3671,13 +3670,16 @@ static u64 gfx_v12_1_ring_get_rptr_compute(struct amdgpu_ring *ring)
 
 static u64 gfx_v12_1_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "gfx_v12_1_ring_get_wptr_compute() requires doorbell!\n");
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -3691,7 +3693,7 @@ static void gfx_v12_1_ring_set_wptr_compute(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG(); /* only DOORBELL method supported on gfx12 now */
+		dev_warn(adev->dev, "gfx_v12_1_ring_set_wptr_compute() requires doorbell!\n");
 	}
 }
 
-- 
2.55.0

