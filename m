Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94086C5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CFC210E5AB;
	Mon, 24 Aug 2026 22:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OG/a6DAL";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010035.outbound.protection.outlook.com
 [40.93.198.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D24B10E5AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOpoB2oMzfHU8D2tOnasGQF0LuhVeUQTjHA0RTbrmW4CQQFR3Ga8sWBy9kfmYKJxrUWuKBqxFovCk8C7x5lISaZXovXn+FpvaK1R9duP+QYh3BlIagGjQxCxlB3EQ+o9O7NMQB49NLGVqwDvHMoYDwzUlt6zS2FzncCWzI4E14UGkuvZlAVNY8Q1B4ShahUAEi/4sEnOLZfEa7rMyJKYgDZ4N+AFFbfbPl4SyZW5UQdE76T4/hd9r0gkBhQForky+SeIEeO9z+yR6XvoKQM/iROddo5V9rfBR3NjmRcwymD3dYT1H3jGcw6dUHjljh5+NQSNLkJ1KvzoVduG9R2Rqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM8Rm3DFo8p6GRVJK4BF7+zgwhG91EQZBVreW9NUv1U=;
 b=rTVgXNxzRkWGBTJsCB1pt1nSBwIA5ywCPyQwYYM9D4orCH6g7kddvxgT036SNjScit2UDsSI3CzmOx0DRUYOCgPthuXYNrvXaDLXy3sK9nHElsnrcoJ6cZouYaW+v5/NArncTwjcOhHWGSSCmI1IFjMnjHMfWKn6tWDMvkgS8rJ5VzcZL5lDfzcZ7g2RHfit4aH09muMgTFnEqUsqKpPb/iw1r4hUznye1R8Or3uSS+OnynKVgPTrrIDcxQtYxyS6dz5wFW0saTsCHyO1mXw81kcgsSjR0tArRQKQBcJfAk1wgF0ftJ+RV15tQOz77H62OxIisjVqbpEVbNOA34ISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM8Rm3DFo8p6GRVJK4BF7+zgwhG91EQZBVreW9NUv1U=;
 b=OG/a6DALoD3b2WWBajoOS/fUDU56V9D3vDtDvx0nVHwM2bkxedLHaKfcYwR1Kaw+WR5pajH4sUcJt6CDnMGcFKJ3kTfd0ikWQFsbe32yxXYtnpyBrt4DudTelaeSoIHufbt6AO1u1p1xhPu3mkXwQNSVW1w+71TUbYCxXikN4AQ=
Received: from DS1PR03CA0015.namprd03.prod.outlook.com (2603:10b6:8:233::10)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:09 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:233:cafe::44) by DS1PR03CA0015.outlook.office365.com
 (2603:10b6:8:233::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/30] drm/amdgpu/gmc9: use MMIO for TLB flushes
Date: Mon, 24 Aug 2026 18:13:28 -0400
Message-ID: <20260824221352.1793542-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 4792cffb-ad32-4ab2-171a-08df022d04d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: cRnrvmWpSPIFZiruc9oWD+7kxiLcwfuTKvh+re0GVZHuYuQ44sxEdtg+7xP0SAUqZW2tDy8j6tHNuVKZwRKiqGAjIJlXSGrFZelBS5qKn54dqJ8p/IxEfzZEKT9hwKkv7RFWxTYzL1SieLVJSfbKdb9Tv+5bZ2h62odGvp1OXJI22KuFQFEw1UWrpYOJTfTqT0X73dPiJKJ02RXYHzLArJUXxhPHFJLuk9CsT+v6bLzSXQl6cIMy/lwxCNfZjqBoCzzIqiX0TXhzFemC9W/DNSC5/BlHqvStHD0cne/XXU+mCibP6TMlh0CjuG8+ojitKpC7IszeBcgY8+/SMwnkq/hPKk9eX3J+fZ5Iv4aCtIFPdWyBjJ9ar4FUIVQLiDitmralmiDAb2vS2Hp1whBB3cSKs7Biii10T+P0ZiGDyUN0he366BJwlrQTSfwgRIsaa32L1oUhkz7pLvbwel8PSyiYv2T8RmEIX8nMWmNiMTO0v+jtIg7z3CAqIBVXC2HYsE2DsfLpGVGRaplCKfLP6EGbBuVlUWxkxV9lUsZWmTLrV4vCa800SJJ/iRMmTJabP0qjTxHf3U+FVctzNAOWYF4FebhLgtXoBj1BPRYsfuSeO0+vFFAuEnTooLhO7RJxDHZ14OW25xRNLzyFRXXMMDP457My62VN9wGSMy2M5RhETd3w8fwkwWzOeJW+49tbkC+/Yu0/dXCX0UGd+gKW1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YbXHrw1AUiNbwmVGXXWP1+S4qVoEBRZFydI7I7WxjlSHu/PzjUZ1l08rO0TsRYp4nAmKvIjClgMMQv5ehMVhoDcSIdWYida+moya2d/etLd0BdhdXDvGtzVH6bnMlofqQojze1lmlVESiW7/lkbYlmlWyOppnvChyFwW417HOsFJAn1BOlVeIuVBm8Ep+NmysHHbv5AqqzE5WUbjro40P2dYzKrrl4vwslOZCU/wPT8Dg5IvWjkoDw5RZyDSg5CaZ54xikeD+y/Nu+dEVRnFiXRQuz82ubSJvXS/XjN14rxNsr3AdMN/2ju93Qd8ROTV+57rh/BSR0YdDlDI8TkAR/GEizRFNfUVEqYszxc075S+b/javyc4Y83EZsbOUQabNUJayfTlnk8pnRvKIhZFFQAnUK9Bo3S0kDh5Lbcoo6Jzhua0zWWqFQo7QatoiUGi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:08.6860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4792cffb-ad32-4ab2-171a-08df022d04d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
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

KIQ handles scheduling on GC 9 so it can get delayed if
there are a lot of queues active.

KIQ was used to avoid disallowing GFXOFF, but since the
KIQ will wake GFX anyway, just disallow it when we
flush and use MMIO on vega20 and older.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1ff1d2ea02b3b..8edaa54fca82f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2057,7 +2057,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_gmc_sysfs_init(adev);
 
 	adev->gmc.use_mmio_for_tlb_flush =
-		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+		!amdgpu_sriov_runtime(adev) &&
+		(amdgpu_ip_version(adev, GC_HWIP, 0) <= IP_VERSION(9, 4, 0));
 
 	return 0;
 }
-- 
2.55.0

