Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B967DC531C7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 09:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A70C10E557;
	Thu, 23 Jul 2026 09:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bdxUC7mu";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593B910E557
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 09:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMO/Bg5uDDuaIXBne0R43rQhk8Qr1Ox11DsrWwRSZQ3dtTYyPjLhpcau+0afNphh7CYdL+cwwDvKTnBGhjJzPm/SPUw1Gb/dioeMZkIIsUHUYlAimU2KirOyKfaBgm+oaL8CStmIwq0TKBIxlib4Y3xNwt8zhndsAbynk1yUHnf0ny/iKzYqyHVNvvd+PWNjAZ+yIUCzoJFcJcBZBqdTeFcFuz/jR4pC/gHyZOFPsyOyVBK12C+3zgur1SMoTzwlWXVQcJk20juvS3efG0pfjyvv4EYwtEIJ3X1+3SKH5v/ouoBbiuxfyJt5e4VvERAS4SSPakHMoJeP76Wwlpz0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjG8sTFE0imtuKhpi4TYv+m0SqVq2EjCjQLgAaygVTU=;
 b=XqNQ7LFDFJNIb012YlzDYG6S/hR0qeZaM9YjbiRqbrH7+QnJDW7L+R6+S++TuCUZIujm9l4KrqnVCO9huzzA1o1Ou5VCZFMzDM2KQIqBNuPzWHF/34n/KOno7kxj0zeleaIsW0RNAGJzCccNa0OtV6mFxGEezJ6yTYb9VbArgHC3kOMdRM/se4Un3kh2RsSN19i7SJNQW9tVVC5fdu2gnmLicFPCAO7vR4N6Ndass/ECYwL4QusMT2naBAwu+7gwWZ1xiWsKJK46iqCsu4vrO4ro2vwOGHj46Xe9RTsrOroCzkT+g+aR3foUwkkUVXP8zZWurmSwQMu81tTlF0V7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjG8sTFE0imtuKhpi4TYv+m0SqVq2EjCjQLgAaygVTU=;
 b=bdxUC7mugx/GHgBWb/14TkwZvv+wieoWwIVuxEvuk3OxEX8MVwybfga3rFPt9msYVXKxDUG64BLNcm/RJRZJ0RpljgIoFLFMIpXl2jz3uKArPZVNn8GnbDXX0JFJbU/t6Bl80fLvIgrw3f2eudP2Y/KU3x403121PKpuX4uBrKM=
Received: from BN9PR03CA0322.namprd03.prod.outlook.com (2603:10b6:408:112::27)
 by DS7PR12MB9525.namprd12.prod.outlook.com (2603:10b6:8:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:55:20 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::2b) by BN9PR03CA0322.outlook.office365.com
 (2603:10b6:408:112::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 09:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 09:55:20 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 04:55:12 -0500
From: Qiang Yu <qiang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>, Qiang Yu
 <yuq825@gmail.com>, Qiang Yu <Qiang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: read TRUNCATE_COORD_MODE on gfx12
Date: Thu, 23 Jul 2026 09:54:31 +0000
Message-ID: <20260723095431.2831513-1-qiang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|DS7PR12MB9525:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bb035e-487c-4621-501c-08dee8a081bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 2Ca5uqgMUmKQ++anDB7UbXna8e4YYgRse7BGfwOiF9q6Kdg4FEfyN4OpoC3G7TbF3EK1c4Nh92vNZUes4KrkqUJnaMG1/E2q2SFS6S+tC87FOgKdEJ7Y7OV6nvtOfufMZApvI/e1BgdEM/gpkZkywx2C1O6VdwqFKy4y4DgNgiX8tDTMuLFVYE1iehiq+CoPTSg/NzHlYWd4GxNlGuf0Jt8PcExdlMBPeVLO8CCG+C/fPulAno0l24/fIJki1eiwjfrT0fJsk2GhnqnRMhIUJAP7N2MDVgpeCvsE+t03GT7FRFdkyIlsU2njaL/7GwiKfxns83kX1F9FoNEPkrgFCk6xeqaWcW78z8g51mr9r0obijZfAQhDlIkljTrYIqv/CRjHjS7pJ3GEp2Q7gkdd0LJxlhZZIzA+AbPfFqd7AfjmtEnd67QhjMrLXjwPsZBd/Dibw6HnfMtgZ1DSCMwww3kQ8+jEn5Nv9Zk7pmikh68b+UHEB45s16DoqErM0o5BZwEPppE8zTgsE8V/Svkmo/JV2OXD0Gvt8KTl2cDwSyXzOEdEWrayOaWtSZ6JJ/W/PslJMe7ASMpzjPJpM9ZPk4SCmcsguCbqSr1aLiow3eIqQYdH3fayZcuoEfP5QGrCQ9o1y3m/Svi25N5xIP0y8osScL7WQfFlF8vIFzi598zl9/eujPXdtkI2XHq7lWf2auobAIGFQh1werkYRKrNxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xBn2bq++SAtFwyjqCaCEXfT3Bvo9mgfCLilk5cUnKJP+vXdHljcKlKkcXFDX8pXKsSGFg7PdSqlvYL7m+Z2A+vVx/Leg4ANm8mM2j/K8r5iO+EIBufcXnY0dnAO9KhYj1M1nJwgs/DTXM2dfUUh9Rp9tOgQA1DyNnVYRv72XO3PJeLxm9h8jO6TcAG1n9m481TUNh9eZz50W5OG+Be8bVo5TUNcWievTXOUvVdhUGrma54/uwTIq5wAAvbQWiPdhQnY+861qQCzvKSDt+fe6sGTP0o8aUkAPYnGFJy+Co7qC2QUvzMZOvT+GWew0up8QuGZ8azqwX3BYHnU3APdDEpWVyzDHRlHmAJ6Llyv+msVHbwZYMhsKSQ1k19+RaBjwh5pxNHBILqvwwqHAYNPBHG+b38cZtcdaKp6MQCb5qU/0cHc/kmjsXHAs16xs8QIO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:55:20.1706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bb035e-487c-4621-501c-08dee8a081bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9525
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

From: Qiang Yu <Qiang.Yu@amd.com>

TA_CNTL2.TRUNCATE_COORD_MODE selects whether texture coordinate
truncation is D3D9/GL/Vulkan conformant. gfx11 reads it and reports it to
userspace via AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD, but gfx12 never
read it, so the flag was always reported as 0 and userspace fell back to
the non-conformant path.

Read it in gfx_v12_0_constants_init() like gfx11 does.

Fixes: 52cb80c12e8a ("drm/amdgpu: Add gfx v12_0 ip block support (v6)")
Signed-off-by: Qiang Yu <Qiang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b3887c5262a0..d109fa06e32a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1827,6 +1827,12 @@ static void gfx_v12_0_constants_init(struct amdgpu_device *adev)
 	gfx_v12_0_get_cu_info(adev, &adev->gfx.cu_info);
 	gfx_v12_0_get_tcc_info(adev);
 	adev->gfx.config.pa_sc_tile_steering_override = 0;
+
+	/* Set whether texture coordinate truncation is conformant. */
+	tmp = RREG32_SOC15(GC, 0, regTA_CNTL2);
+	adev->gfx.config.ta_cntl2_truncate_coord_mode =
+		REG_GET_FIELD(tmp, TA_CNTL2, TRUNCATE_COORD_MODE);
+
 	/* Program DB_RING_CONTROL for multiple GFX pipes
 	 * Default power up value is 1.
 	 * Possible values:
-- 
2.43.0

