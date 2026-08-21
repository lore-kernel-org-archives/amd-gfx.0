Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB9CC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8890110F330;
	Fri, 21 Aug 2026 16:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YBLR3vuk";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B1910F32F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7mdo9n/FQtWK5kQYtbqpu33BqIqsoZuTNywMuUMnKoXccmqed0OQbHElPRFHjGDd4qPnd4h48q1exOQzfKZx/xSdBzWeU2oHyD1VWtwoJ+vZNjBG1EsS58UI0mOeBnXh3Ocy21KHghXCB9WVQqrKVbnBkgzJc1HHam2CQRTMeuWRfxClC6pTBodqble7c23vGfCv/SHg0bghxhZ9pEd3xZYA0Ai5SzfB7o5W5GARZquZ2jug0vx36vjYh54OjFWQC4LkD/AQhL0ZuKY31PpoT/kgos0j6cAAt0sdZjGQ8xGrvc3TT1XvtVyQf58Zrq3Xv1kaHqa53cKudw3JlrUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf5FkCEXpqRljdh7+9Mf1cyynRisd+Hau7XH36wsaEU=;
 b=VXR35NdqIRVgJw+wS2QKZslaYwTPgffrkGohnJjCtZOlFiOgrwWdyMDuNk2UiBvOVoLxhDvcEmCtXNsiC8rpCN6udQQUF6CdXTv5m+cJDejAgKg+k4ZiY5yuq01F/qAHnyb0UXAetpEHfk3Sr+6haG+aag3vAZb7cbAYsodxZKCMYResZmY443IPyaexr0LBZ3PsH306h8Fvaj6YFZS4rmv1hWfBrAtqMKsA6A5Kokd6TJmANN74AQZwPP8hr2CBm6tlXL8V9/ZILLramj9WpBvPSpzOOgoRKDJZ2Uqx/16aasIKrjkMn7DyM5F24KRbIQl0EJxtdY3I9m4ELq0Hsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf5FkCEXpqRljdh7+9Mf1cyynRisd+Hau7XH36wsaEU=;
 b=YBLR3vukpTjwBB6mSTsDuq6KAZzyB+PxfIxH0CiDn+72xSZw5k7Glt81ZZxW4hwVRLOJjBSENZMRwUvnrFxBO1qiQ3YRP+lNuRlAYrkoTlakJAX56pCtxZ88gGxlP5DtktR4q3019w7bmUhsqDhEhMBzzpqm+KTNPjPXOFffEfA=
Received: from MN2PR05CA0039.namprd05.prod.outlook.com (2603:10b6:208:236::8)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:03:18 +0000
Received: from LV8PEPF0000005C.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::60) by MN2PR05CA0039.outlook.office365.com
 (2603:10b6:208:236::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Fri, 21
 Aug 2026 16:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000005C.mail.protection.outlook.com (10.167.245.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:03:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:03:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:03:16 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:03:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Boyuan Zhang <boyuan.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/jpeg: fix jpeg_v5_0_2_is_idle detection
Date: Fri, 21 Aug 2026 12:03:01 -0400
Message-ID: <20260821160303.751422-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005C:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8ebe8c-5959-4e85-9ef0-08deff9db6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: TkJ5JqCNmpfAvpsLl8Zi9eA5epFxGTkRiSj1GBifygFSbpVM2lzxAT1jOU6MLI412FxBEoj4kIBHpsRKsFZwvaaATeAUQ7/bKwW6gQAoOzyd+16zpY4H5hezxLOn7toDFmwpdcfWt8erOtqClqG2q+BYsU76M6Jnd/E6rMFmoeWjhEGaBAsGGrETXJWfxYdiH984nD5cFKO+mbtUsr4Uso/oOpD7pcBlpRhM3wPqunFLgLnsPWvYe9rctyDMaPgbKDYPe9j07u1jvV9+LFSlkcY9P5qNdCR8BtKYDJqkTT07NX2W+A8YIQ3Znk9xcjR9JW2bamOQF8RGudQ7ANUF8g397W9325gLgQBM0nfIWonxNsLT0Rva9hvOcl+0AadZTq2HOV/3+nAhzqwSzVyIiwCP0Kw8VFyo5h2Qg8TVdYINuQEiMGtemSnwrhW+zgBlMgpUEtxotItoDQvyQQAzwGeWThSPCT+fPS/xYkPw5kTS2uKWP3qqIp1gD9YaPl3HW52qJd0C5JLUxrz9be7KW/cEARNrZlWv/tAGM80MS/0HM9eiVygzlef4I1A/8dUGR81Bq8p7NEDSraipcVQ3SERtrwWI7SazPNmoBVmWGERz3yUlI7gF7ybIEXEkob0ItASLZDDz286I5FS+bYt8kT4sDtcWo1V0AXNd1qA7tmNXxmQdgwNrJulcE7VSosPlDmyj922yVojoy1lm0MMYpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Jy+ro/vjkOCjW/0Ru9TWhbQ8A9M9a+GXK58wsYOHK/cde7v6ktf642h6+lJsEtC/Ta/yMKHtEB06CFQIOva3MyeuROqgjy7U46ktw+bfqmO6+1Ts+1bmSDPf3wydNusCsiNeOI8v4t/YbNGsqNJxBVerVoB0tzZEsHC8/iRYJ54tfOKabhGXmD1yuNEp07H1BI3TcFNILxOY7KSg1iACj1S5sx3zjeG6lBZp/LOwhEMJsABs3qlADTBjY2/gad+z7TPh7mrhGnFXvLu6ITcd66iCJ+5yGtZzFef09FWWxzmzRpmmt1ja/lMb7i2wWrS6Vw/qVsh6y5MT9/HuhavRXpYppGCMvYjD8R1mThrkKW02UmqJIRRNyYl1ETLGgdejHQlHEJcS3OJrqYkaI6TJ/Rs7jXyDmbVgkoDH5cEUTeEa1kMBbTznSyqFMXBCowY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:03:17.2454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8ebe8c-5959-4e85-9ef0-08deff9db6ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

jpeg_v5_0_2_is_idle() initializes ret to false and then accumulates ring
idle status using &=. Since false & condition always remains false, the
function can never report the JPEG block as idle.

Initialize ret to true so the function returns true only when all JPEG
rings report RB_JOB_DONE.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index 1a31f3a180e2f..e79ffec251d75 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -505,7 +505,7 @@ static void jpeg_v5_0_2_dec_ring_set_wptr(struct amdgpu_ring *ring)
 static bool jpeg_v5_0_2_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	bool ret = false;
+	bool ret = true;
 	int i, j;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-- 
2.55.0

