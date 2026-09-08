Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BADC79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DE710EB37;
	Tue,  8 Sep 2026 11:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JzBw8hKY";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C89A010EB37
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:35:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/kslpzuy8xUtIIl/dx93DX9f67EXDwF1kJiwkUqBi1GXt1iEvo+CkUS/JHdMRGORwnWoLsNDWpT/fkFUNaIC47ceWa2/tWJ6i8FsCrhamJvfPOvZeuRhiZ9wxaQC2J+Ovg/lhgq+3yS0TXxMrE7iEDnyqCy7YlIpghlu2lsoV2wXOgBe5Q6MkrO2nSYLuFg+LdOcs9dzAQFhbD0ZRlZnv8OCFYwbbXEmu6DeFgK1ZN+AddEj5aPY4uhEJxd91M+3kl+No2tBxs2TwW79ASZCFkFkKUFNyL314gdP/WgmtRbQryCaqRtjrQUG4vQNVdlW4g0BJ9yhEm25VI/G8Sb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgXqsR/auaARdwD3aGmYBZDeSb4cWDG7F/dnIZnCteY=;
 b=rJkd01Ox4dWIecaM2GkpVnUvHpHLncvBamp4jpg3hjrwZNuXbZMgBL8r45Xd264nySLd1WKshi6l5QCivdBAvrfAJ2LefUkS5EiuabGMn4BY/BGM3UkNUHSYEnCSyzcasAknqkK5/clSxkG6qlZ4TNYasgV6n6fgjP7mVC2y4RFEOpCl/ZgQWsjjqSQmvPMUt+wZpXi1M1cXz3pdgfFNzPfgFvBopWVy7iXgmseTWrJ02FwTNxfY/kG65gX+TnQ+5E+FMzh/tNyijMzwc9R+NmY5nNn99Mp2kqY7qGePrBTVoO65M+03cvjWbU+J/nvo5s3cr9PejIsMHLAmwIi0iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgXqsR/auaARdwD3aGmYBZDeSb4cWDG7F/dnIZnCteY=;
 b=JzBw8hKYU46Ji+4n/lc8Rhm2FtzWVuD9ytNL6KS8GEZ5aJjvW5GLzc2W64saIvA682N53OO5YRQTRgIwtPSoftL68ov2EQ0EAhlTR7RiQ5ZR+gbwnhaube8eDihq5aJKa79T8B7eIdQfMdhggNoZ8mR6oqaPlGqL1YWfRp1Qi1g=
Received: from BL1PR13CA0217.namprd13.prod.outlook.com (2603:10b6:208:2bf::12)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:35:24 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::a5) by BL1PR13CA0217.outlook.office365.com
 (2603:10b6:208:2bf::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:35:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:35:24 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:35:15 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 11/66] drm/amd/display: Test DCC reject for multi-plane format
Date: Tue, 8 Sep 2026 19:31:04 +0800
Message-ID: <20260908113338.2433445-12-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 25347fa0-fbe6-48d3-8188-08df0d9d4617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: o2ElwApPDnq33bBvk+kkdOtOpDWEa0PgbnzfhxC7Pq1M5yyYwp/TU0Ht77FdbcGppOgxpeRBDicqDEz3M0vBn23z9WqyvexehUgWlT39EZplNyUkwwLZu6wdYC6rx1q4P0bbuUSP3oVxeSb3h/AiJKPPH2/bEKJjor1GAflzJaEmHqnVRowM2vnhV4AKZIF0aqELEyapyvNTgT+EpAna54VC6iT9A/wse/+sVbUqzT/EYKOEC3/HYKjKXocWNAXBs/d99uQvLy3/CjfhPaDCfONcUZfJHGyKRLSe0TTcNd5sGRyI4fzZiKlxKGPNGPQLS6Qz5UBzj13YsZcWqzeGJICGbHcjh+VNCDbLV+yHPYNLKsK9BDsKjM24h1P5ydpYynl90iNGtxpSRGrIGBMTjdoSmYQsZCqW2SFuxgiRWj504PTGv12JxZ8+pj3XrnAzt8K3xbsq0kK0iK6Bq1eCFThiOtIUJRMjAm93k7pu6J0TSfao8J0kEksoCbetY6aXl0KXjvw+L/At2OmpvlF+sPAy/5UccFdXm/2M20h+MatdBZCGFfowHniIc9/nbszggNyhibeA0keU91WvPzOzUuQQChrEky8X6TxYHYPBEr5WQslfzzMusXs22mQdpDLgffwk5u5LqB3IPrXV3RIneE5kdNsAa6JvGwBlwfUbfIO1GCOtqJkl77RbPp1Qw17JqLpWag2bPaJqSpeJcvxdUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FxBVTxzKhryFCwST4CcW1WaZV2su8TjtmWpu/L6WKXa/0cPIUCpnrcpJadVhlmhR/ywnX9bGWXoOCXN7jBgnWJzemnzgoauJafWaIIKXBHXSu5QKc1j0oUKq7Az+1mQRPdO87jaRXafExZjPuxvWohJkaJrIUjdNDqF7bgsbGgmfoDGQiryom8nYD0PHOlcleraDB/HHF/nqsxtrRLVTw8IPCYkih4rANVDf/A6jKOtvu4YMkjfFNw4Rtp2f33XKBQl+UM3BOrK8AcTqUi+RHej2QmCNrLGDcIg2T7PpPiJfGQEV67Z78MbHozThA+1nFjFW4vj6Q3lfo7Q6D60GRnl85Rsjr7PTcsG+7LysFgze55dSBBUpC5Sx2utj/wYYPabP2NWCRdChm/6IcPic63pJ/C7L1tV4kblO7dEwxHWam8uMZSfRCxI2qaGEm+lQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:35:24.6441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25347fa0-fbe6-48d3-8188-08df0d9d4617
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Extend the amdgpu_dm_plane_format_mod_supported() test to cover the
rejection of a format that carries an extra plane alongside a DCC
modifier.

[HOW]
Reuse the existing GFX9 DCC modifier and ask for XRGB8888_A8, whose
4 bytes-per-pixel main plane passes the bpp check but whose alpha
plane collides with the DCC metadata plane.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c   | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 1b39f41c8414..939f79422d7e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -506,6 +506,11 @@ static void dm_test_format_mod_supported(struct kunit *test)
 
 	KUNIT_EXPECT_FALSE(test,
 			   amdgpu_dm_plane_format_mod_supported(plane, DRM_FORMAT_NV12, listed_mod));
+
+	/* 4 bytes per pixel, but its extra plane collides with the DCC metadata plane. */
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_plane_format_mod_supported(plane, DRM_FORMAT_XRGB8888_A8,
+								listed_mod));
 }
 
 /**
-- 
2.43.0

