Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C18C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 07:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C8FD10E068;
	Wed,  5 Feb 2025 07:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P5qaecuL";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E117F10E068
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 07:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRv0oJcqJo3AmTZQaTxhmTHA4hGi42izdqJhWYRJkJWyYCFarq0wMFAfxDznGc4toyVQ6q4vidFXlITBnebArXhTD3Xm8pLvlwr/yN2DKZ/0a27Jzb728n/2p8w4xra5FobUsJMRFCfBSpr+sjfJ29N7+m5OoAI/pdeUy6RzHT1h0BDfDD8GrGJ3pGpI3t/bAGubAtYxOjPtlPoI3hZbSiz+JnXSFeJlTFi5p8cIfgLJpWg8y3zUTV3Rz9W4XNtPbQs/SjlY4RoQvI65thXLXl2eZNNkD4BzHBybcW/5clQlKyGuvuFNOI7kDVXhWz+vBRvKzD1QVMEBiKo8MYYcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PLfobZ6INBacK3vGOkXAdhZR8Eznft7Uc2R3G8Znx4=;
 b=hsVqjPTgvzWP5asN7tFTpI0oBrCHd6g5le2Adv/1UIt8t01pUD3OdDNz0nek2Fsy7FtO94dCYWVzNglaGdT9n45Y0GFqEf4lUnzYeGgGEa/PNSsCi7RvZRol3A2NXc7MOFAkrANd1o3R6SuGpwREZFLCKPo/7qrgk/K9zhX/QPX8A0KMb3hdAHjNzBtRCXn5VZ6Hqp8AJbL1AxReuzmXWlt1xA5lV78oFCa85G7f++8YATj3gylJW1Zcwqd63UxKaXMvAC3JsGa6DPUXvYR5u+i2Vc0uUlWVyy+36C5jfzNeoKmDKO43PUhKXvg4kDXeL8fYxBl1+YojpI4qpr4sQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PLfobZ6INBacK3vGOkXAdhZR8Eznft7Uc2R3G8Znx4=;
 b=P5qaecuLQDrG1PG/bW5/Ft1uo0A417JaTtkz0r+xNeMYw5NYM5IhkEYG+h0tkFl5ZSra+326ECQsE6+1IEFHbzxRAksiU11Agdzy/UudLmjygjaOWzV7WK+IUjWtX7IdFalxSI0QJExuj1FHPzzDzDJeVmt4SRi1r/KY0b2mQ78=
Received: from SJ0PR05CA0185.namprd05.prod.outlook.com (2603:10b6:a03:330::10)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 07:51:04 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::d6) by SJ0PR05CA0185.outlook.office365.com
 (2603:10b6:a03:330::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 5 Feb 2025 07:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 07:51:03 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 01:51:00 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Clean up atom header file inclusion
Date: Wed, 5 Feb 2025 13:20:44 +0530
Message-ID: <20250205075044.1896764-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 45018e98-baa0-4b5f-d570-08dd45b9d747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hwOwI3Q6nXmJr2pzsISdvZRV6JrsLqJZZmcfHkHPzuDdra7kNpvmfAGlOV5c?=
 =?us-ascii?Q?ntfY8reGue1KqAgjYjN+1dERxypuyrdusEffT3w/KmDRio020l1DO5bSbY2g?=
 =?us-ascii?Q?eU6k/U+/Cv4bFUvrk1Pz/aP6HsnwgT9h4EydIWSp63rXe8+3yP2UEbv5NUHm?=
 =?us-ascii?Q?HS/Z1vJd+M9xIH+ceWjgrbhCFpiVMSU23pRBZc58hGgeK6y2malhLOw/Xjru?=
 =?us-ascii?Q?+fkLyx9UyjZEc/0AVPN5j8tHNoNv4BR42W5ndPa/ZdbSBAYth1xhcdjXvkQD?=
 =?us-ascii?Q?wOVUbXPtdduHMDAKto8us+ab0DyLrXUblznnCKp3MIAE00CY82W2XEsz+yGG?=
 =?us-ascii?Q?D5Rx2XH8W6wehyq8SGmG9xyf7l5tXSl3yJJScwBwbhwRbF9+PUKNDX+JbmCX?=
 =?us-ascii?Q?Vg/Jbc5gr6bJ3WzvZoOUfaVOc5mOtHuQyvAdALbeaXDrCGkbWCBfHmpkmvql?=
 =?us-ascii?Q?PaeqrrlIbOB3M8lsFN5Eqop7CGANkWVnzjexRi4WmzYNweOW/FSH9IixZI18?=
 =?us-ascii?Q?w8fZINpmRy1vZajRQi7dFmrAG0Yi0pBshQ4EDKEGtc8+LRPZC3/5G523haz8?=
 =?us-ascii?Q?rEMT3nWpjLRMJqLGFdkkP73MoUN3n5EXf0OZk4p9WoqFkv2Y3K649mFMR0pG?=
 =?us-ascii?Q?zXGE6lWY0VagAMvV2ic65yjeMC5czsDdXiBkLVXGt8RpHXAqG+iUuaU422gO?=
 =?us-ascii?Q?L2NC6BdX/io4dNTm5EJX8evWKrRHGz/f9azOULv6lz59GEFDvpMKd0j4rXCY?=
 =?us-ascii?Q?4x4NkZUjz8Gx3KEqlCXBvWfb7dzbTm+oEzUzxPb4Yt8j16c3ov37m4fBsqGU?=
 =?us-ascii?Q?sqso/c/eVLKjUrXHznVKai8IHGA48iZSsqYXyG7gHga9bwSbxon5cwr1KPG6?=
 =?us-ascii?Q?IvD7XK+eh4lOOOS1M1v9ngAvY9Z+SkqYoa128sU+XbDo/FE2n2mLTQABTRS6?=
 =?us-ascii?Q?Tp4dUx3TRdtkwtkeWFJkbi7guNify3weAQDXRoyalllJb8Yh3wv/Es0YqS2q?=
 =?us-ascii?Q?hGQWA2Nvf3DtKhGMyMSWUEuUxUVRhpO7OHqXeBbfEYwYSso4QQh1SSLsKkxn?=
 =?us-ascii?Q?3LRXB6N6bT0moDY3xRge99PYzDNUfqR8pyCpaEbBGfvOCNppcj6OBgYf40uA?=
 =?us-ascii?Q?lzsj6TQw3XisBcGBNe5z6n3tbdhjtGI63eIBrwteXbVvhSHuNlvBw9UboeSC?=
 =?us-ascii?Q?AWLoHjNgCDGNJb71ExURlE3YXJ6CgBeCHrIwpfIo8gTibqfj4q+4b5a4Rpox?=
 =?us-ascii?Q?WifK4w9rn0tg99Rn6gx3LJ4jzAjJdtCb/9NOLahjrRfi71gpo2qVYpH+hbaS?=
 =?us-ascii?Q?6BMZPj/kkJwNOhY3g6Hx4tBUh3kRbs37bCAZyjQlVyP6DdT1WTXY7OE7PYM9?=
 =?us-ascii?Q?wy+5p7QXOyLfzpqD8oTh/lHST6HkZkydEe/RSVfJOHky6KuKAFNVgdQtI4Bf?=
 =?us-ascii?Q?2iSDL3t7NY4tuC2X0ulol5qU4y8cK8eJFNETKGCQQVhwYlseBwGeMA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:51:03.7991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45018e98-baa0-4b5f-d570-08dd45b9d747
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276
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

atom bios header files are not required in these files.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c        | 1 -
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c        | 1 -
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c        | 1 -
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c        | 1 -
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c        | 1 -
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c        | 1 -
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c     | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c      | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c       | 1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c           | 1 -
 drivers/gpu/drm/amd/amdgpu/soc24.c           | 1 -
 21 files changed, 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index ff5e52025266..6da8994e0469 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -28,7 +28,6 @@
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_res_cursor.h"
-#include "amdgpu_atomfirmware.h"
 #include "atom.h"
 
 #define AMDGPU_MAX_SG_SEGMENT_SIZE	(2UL << 30)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 89d17750af04..aabc5bacd154 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -29,7 +29,6 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_smu.h"
-#include "amdgpu_atomfirmware.h"
 #include "imu_v11_0.h"
 #include "soc21.h"
 #include "nvd.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index db5cc060de85..638507422f9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -29,7 +29,6 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_smu.h"
-#include "amdgpu_atomfirmware.h"
 #include "imu_v12_0.h"
 #include "soc24.h"
 #include "nvd.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index f53b379d8971..6028afd81690 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -27,7 +27,6 @@
 #include "amdgpu_gfx.h"
 #include "soc15.h"
 #include "soc15d.h"
-#include "amdgpu_atomfirmware.h"
 #include "amdgpu_pm.h"
 
 #include "gc/gc_9_4_1_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 194026e9be33..f1dc13b3ab38 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "hdp_v4_0.h"
 #include "amdgpu_ras.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index d3962d469088..43195c079748 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "hdp_v5_0.h"
 
 #include "hdp/hdp_5_0_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
index f52552c5fa27..fcb8dd2876bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "hdp_v5_2.h"
 
 #include "hdp/hdp_5_2_1_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
index 6948fe9956ce..a88d25a06c29 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "hdp_v6_0.h"
 
 #include "hdp/hdp_6_0_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
index 63820329f67e..49f7eb4fbd11 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "hdp_v7_0.h"
 
 #include "hdp/hdp_7_0_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index c92875ceb31f..9900fe5c3bc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbif_v6_3_1.h"
 
 #include "nbif/nbif_6_3_1_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 739fce4fa8fd..04041b398781 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v2_3.h"
 
 #include "nbio/nbio_2_3_default.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index a54052dea8bf..f89e5f40e1a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v4_3.h"
 
 #include "nbio/nbio_4_3_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index 34180c6070dd..e911368c1aeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v6_1.h"
 
 #include "nbio/nbio_6_1_default.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index d1032e9992b4..1569a1e934ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v7_0.h"
 
 #include "nbio/nbio_7_0_default.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index 41421da63a08..2ece3ae75ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v7_11.h"
 
 #include "nbio/nbio_7_11_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index a766e2d90cd0..acc5f363684a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v7_2.h"
 
 #include "nbio/nbio_7_2_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index a26a9be58eac..d5002ff931d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v7_4.h"
 #include "amdgpu_ras.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index 3fb6d2aa7e3b..2ee60b8746a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v7_7.h"
 
 #include "nbio/nbio_7_7_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 8a0a63ac88d2..f23cb79110d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "nbio_v7_9.h"
 #include "amdgpu_ras.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 0e1daefd1a8e..6f8d867b290e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -28,7 +28,6 @@
 #include <drm/amdgpu_drm.h>
 
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 6b8e078ee7c7..69c5c8769395 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -26,7 +26,6 @@
 #include <linux/pci.h>
 
 #include "amdgpu.h"
-#include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
-- 
2.25.1

