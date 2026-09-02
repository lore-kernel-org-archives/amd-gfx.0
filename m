Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B305DC61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4737F10ED42;
	Wed,  2 Sep 2026 05:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f+hajV3W";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74DE10E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsp3LzxlOvV+tPXXQUPPPWUONTPtQgX7EJ0XeC4wio8KMKoo6/IDyPIooqv9rlO2DTkb7BbrXcPDlu0IP8d4UrgO9L/TItYIIuOUF/CH1gr35ZssX6mJlsSUoX+3BGhsU9o91BXapPFFXqX2vSfhg8CDSZ/oER9s72jHFNqGN+efvJwWlPUA+VRtxEvQlAn24VgKDYVyxjAL1D7RVTh71aXgNAnwvwHrmXF5vLDh0s7pg3YQ1bQNxM1o36ZlFqbBh02xug3GdaASzgP/G/FEJIkEg19c2bvHzjg18bWX8aec906A38nPYScchkquPABOQohq/z+k+HTvpYsXIOnBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba9UkfjPTnIDulluo7T9WQ8jmDOLOnNGLD1OFiUwgeo=;
 b=onuGr6w6HIrmgwNMO3K/g7ZS7/tmDQXOoeBXpscQphPOErzRLDx748n3hxsxjUHaLBdor3KHjO8jKIMK7B9Gd+n1y3PMogq7W117P7xtoqonwemgxMvgQwTtR+08pDAVPQziu6+jdGAMMDhtQLTt4rcPiJvHpudCCypJewhrYGJMNdZTto9gTz5U+tIeBpqBbm9MEdEwMK3NPvnV1S0IGp9r+pv+YwJd1zPHjbdweB3rX2/nHOfy+BVo5nvP8utTBYhPh2dju+RtuRpz5Ljnu2IaeoJ/O49oqkpVhBjcP9ZzsxF4uY0ES+fgslk7AI9iGI9GNsj0rfB/xsF4JO6Vxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba9UkfjPTnIDulluo7T9WQ8jmDOLOnNGLD1OFiUwgeo=;
 b=f+hajV3Wl8TAzyE19fc9XLMC4HiA7svb2jMl5g9rnbx6l0/iqVo+MT/7S4JvSlCJ7iAYcWg5mxjVs2ihCzRft6fx5cJ+7Xn4ExuuEegfoVrKNAR2Dl6PP8HL4buQjTj1yBxfdU4Jk9hyuCV7s+1FQa0Y71A9g4iYX60wIZk4ltA=
Received: from CH2PR19CA0029.namprd19.prod.outlook.com (2603:10b6:610:4d::39)
 by SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:06:39 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::8d) by CH2PR19CA0029.outlook.office365.com
 (2603:10b6:610:4d::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 05:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:06:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:06:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:06:37 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:06:28 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 15/40] drm/amd/display: Remove unnecessary includes
Date: Wed, 2 Sep 2026 12:58:37 +0800
Message-ID: <20260902050411.3473916-16-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SN7PR12MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: ee66e4dc-222a-44eb-ce83-08df08aff886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: y3aO9IZOBBQosDLACJw56hHPw4mjKSQ40B5oNQfQmI/1E3HhPxS+FZHsXm8bJjIrSnSFbn/3AqKrf4+Rq32mFdMLMzdAVrRHSsteXgJTuO+fIOWVAe79Hy7gsDBe497gdhICa9R0c3/2rxT+YhCHgreHKN+NXB5Ai0+Fg+Fh43IpfMiS7GyQ/RCmf3PWbFDZpK5dowKUG/pBWwS3cOUPLmZFgdKL+YGI7eWweBglfu2NPlN4PzCLzOPJDx3tLlXuSQUKMYqseKmkBstF2+3hL3UaVBoFZMSkx037yMS6Hiz42izuN6MR3mTIi9yLWKWuZUY7GBK9HCgVz83qcRzK+k7cXgeYNd6zaJcW/1PorHSUVyf1XCyCMypbdXBF1N/eGQBtbCqBjhpQAxuHJoe7/ia6Xyb8rs/9JDlDWbDKNSMi66o1ITPrmEQvsgAQyZd5e/hF+jnUJI6m9bjKHSPksaxrVIxfW0fbHmBAJmc6zUkDneBeOdlSNzitP+CDAjwitlJPfbxMrlNPueV85R3Mh5b9eWZXWSoGqCJg470r7gENRPn67UZX5fQ2xROR8wMNQc4Y01BYf0C3TqLr7Mk/D8Pej84wkIWbrT3QS5ntmLNWuGEIPqgYstuWZWBtUcCA85QLbDbfRXqM/96HFFyBN9QyHZDb3mZshrA2fe5OffaU9QMhhaqlcWC9EKlbecPnQJtm/ILoBOB/cH5HcKYBPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: phnuSqJgi+Mag80pgv2VYr3i53uK+aaYD/Wc+i62OOplhNr5ZToAXSlUIGjapJbYwnL8hBKLLGp9Qwdo+DnqJK+eilgCT6rELhfoBBoelat0icPkQEHKBUQnVbvB9ALXCPUsXLwrrb4fMjkNkCCO/n/YZQNj6rVPPPFXn05jo+8fOQcEEeA1L2Y8p2If0zN+ShktrDHqBiWocO3IHDHEtuHEO1LmbuqbRv2vOuENIN9sBbIwoHVcipPJpQDijgQkULSn1FaBHmqT0saZsJaqxs1jicxyFSFSRD7941UFIumMgRkmG7AMrkKziDKNsdwRVLDjBgOVAZPo3RAkLNtAFHSqm78NI5TQp+MBI3rzo6q1lTb8kSc8EUx2ANjLlG+OHHYsKsRqbgdLJrtUE6q8LUH1Y5obNP/eeSt9iDFNxBH8AK7dorrWxTrYgkYldSJz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:06:39.1360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee66e4dc-222a-44eb-ce83-08df08aff886
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why & How]
These direct inclusions are unnecessary as the relevant headers
are taken care of by the broader inclusions in these files.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c | 1 -
 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
index 5679b79d6f53..ae6b2d47f379 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
@@ -28,7 +28,6 @@
 
 #include "dcn10_fpu.h"
 #include "resource.h"
-#include "amdgpu_dm/dc_fpu.h"
 
 /**
  * DOC: DCN10 FPU manipulation Overview
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
index b8fc27a5361e..71eedb3301e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
@@ -26,7 +26,6 @@
 #include "rc_calc_fpu.h"
 
 #include "qp_tables.h"
-#include "amdgpu_dm/dc_fpu.h"
 
 #define table_hash(mode, bpc, max_min) ((mode << 16) | (bpc << 8) | max_min)
 
-- 
2.43.0

