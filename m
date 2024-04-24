Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DCDC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1E6113958;
	Wed, 24 Apr 2024 08:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P0sGGZKt";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6461D113958
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRo5TyrGeLKjmYqATLYhp8001l4lpDVwRlFoLJbPG+lbw2LtkwqObOuVv8E2K97w+GiZzbDHJCie8Wuq/HkR51oLkAttq9WhSE00XID64xuBhA2FyNVeqA7of5Pd7Bj2+mU0u75Pt2LETS29YPTOwLVvcI7TD4NUnaVI7F+v84TdPovi5O+Kew7+2TDiNxWyHIrPC22rkzZX3psllr8oPulWA1bGh1VeTf3nYgKrq1VjaP7fgxuwUVFeyiCXlSmz0jwt9flaG0fhswAkMazMeSETYZTPyy7QzdEmP0d1KQ3XL7KUGWM4ENMWAlmXA9OK0dbyIa0R7Wx0YnFjPHz+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BATmrmtFa6qebfCet9xJknDoYfQRW6f1bTbzyCwQcp0=;
 b=njLH8IFSzm2BVpI7BC2j4LicQY4QG9DnUYTIMpfKjGmUrw478uaHJ1UPHa+/ZkWh6qhKDN2ndzJUvsOYLzhcRu3ijy4ykJ8tARyXMvhRgcaKseUrJkoSd6MzfCkIG58XegSRfDiAMfLgaYBe/sodV/SnK8GxIzQfwdKianv4vB+1hzn3iUZCqqQcP2tyz517fFqILo5w5rxA5SV8LLZpnBkcWr2Lwm/W8iwmAgcLF0nI8kJ7xuHebxwfEMQ7H7pMoU7DKJmj6gEilpMG9jrFYX4BwBBbp4OsCl6/3cw4s1Y6MXRwHomlkwmD74H0O+H97nF/JJrL3AHTUYtimjG94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BATmrmtFa6qebfCet9xJknDoYfQRW6f1bTbzyCwQcp0=;
 b=P0sGGZKtUiRHkrYhEZ+HOZy0zMZLLfmy3h1sYHp9nopi6J5v8NSQJm9dDF1+Vp6hWrxvcOoCAfVo46wAMkRs4kdxKuK8wJm6lnOKk090R3JtD+KQmQMyOKnqITkr+w2nLKVUeHJW/Ho+7XXtrmsC8GCbIEfzoj4MRcoiRh1oN3g=
Received: from BN0PR02CA0048.namprd02.prod.outlook.com (2603:10b6:408:e5::23)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Wed, 24 Apr
 2024 08:51:30 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::b5) by BN0PR02CA0048.outlook.office365.com
 (2603:10b6:408:e5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:51:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:51:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:51:29 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:51:20 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 10/46] drm/amd/display: Remove unnecessary files
Date: Wed, 24 Apr 2024 16:48:55 +0800
Message-ID: <20240424084931.2656128-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a66ae6-47c8-4e5c-6de9-08dc643bbc6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V9zyI+OUnbTblJgoEDG42dGxWbx3GSSiCsEYuxUGOBuWYVTO71NsuOYrG7WR?=
 =?us-ascii?Q?Xf52Z/Q/8dk0AByTtsAritSyF44VL0Yr/WEJ4Ylbf77mMbpY/TTrvGdBY4a9?=
 =?us-ascii?Q?sfYsDVGpHlR4K8yJ6PBC02tOEXkNmkbN2HR4afJP0ae4nHpzzSGjO+kAfFyv?=
 =?us-ascii?Q?eywB8BDHzHHSC6Brp90fFgtrVkVSYRGeShrA+9Jj7q2jpZBpCAvfT+SKiMIe?=
 =?us-ascii?Q?nBp1pZ0BGAIfcRtWywOA80Xq5DuEgzrsAUTt36gk7bNjWnjEe4GmDy+BrvGK?=
 =?us-ascii?Q?UtriPkFaPHP8AR+1bw3Il19OBHj0US6tOcim0mB5+RF+1WM8g07MsilLK/kE?=
 =?us-ascii?Q?hoxu+cnyF11wpgrC9ae78oG553ODzuHMWx5jZWOpXDkLhwCOd4PZmnmw8AjF?=
 =?us-ascii?Q?vYehOlFTE15Yu4LjMgADfdQure6m2yz6KaAaZJ/5ZDwpxCdzEMQkAh6yZPGu?=
 =?us-ascii?Q?McuqaSC3f/jIQzD2fP1VA34LwRPQ46WQZdqTpaHM3tSAR2gj3r7nxUiZO5J6?=
 =?us-ascii?Q?my7twwf1H3HgG1Mlhec8ls9fEvzE7SRCUMrhxsOqXMJSBm2HEVJP4jHs+hsh?=
 =?us-ascii?Q?xMHwCOTrM1xK29RJFII3Q56oS4qAH1vEl4SccjQVG5J5GWVSsgGwPLOuK2vx?=
 =?us-ascii?Q?Itix4KNsgPx6rMg17hEWvLWRQAlefuD0tO+zbLlomPNbl8biXAYnHjY4Wvgo?=
 =?us-ascii?Q?tZ6CM3IGiqGat7YHMxP5w/iPCT3bHb/wAkF9nHA6Enmave7thwI+5hbyxRhd?=
 =?us-ascii?Q?Pkstm0AylnT3XnMVLW/JlaGx1eprfyjtI50lmcjSynJgcTQr8B8QExmoMy8j?=
 =?us-ascii?Q?lQIf2K2WIt13t3+JtQTia57cG5TWJL9rHnc0ylWjJFFoIOwRnEj8GTnYRbtt?=
 =?us-ascii?Q?KvhW5OKVkH6+XondsHX//AuW+Ep5gkPBYGRtax+9pVEcsi41MsyP9Pq3rox4?=
 =?us-ascii?Q?lQs93jKJtGJ02DyEj2JgJTYpEe0yIn/DlmP83fXQ7pJHZqTTTX7IRkH+voI7?=
 =?us-ascii?Q?zrgYetZq/zwWyzoRviZIthRliqPByGnRvaa0SJAEHDYaxxay1inoZu4pIlKZ?=
 =?us-ascii?Q?VQF2WI2WgbrJmBBGyHp7kNpO4S2pZ7sJdHg6Oe9h9Z+zoTtuLarp1BEjrMbt?=
 =?us-ascii?Q?YgL8dgrnfFdiXmPk2/LfCtvvdLzIoOo1Kyy/i0ZdzKIl72fxdTb6JXQJbdff?=
 =?us-ascii?Q?WccCPKbUGOTVZgZW8nl+t9iY65WYWiL0Mh16CIWWpFliju4YI8srgZLxkGvZ?=
 =?us-ascii?Q?GRMtH/EtGddwLwq0kNnwEH8f+MF8pDnhl0XmndbkKAvgd46ckX7KB73mmaB8?=
 =?us-ascii?Q?Eg3wmwfF2xcIS2NQE1JShFO9YrHNTa5zIqKrzKdAQJ6Rd9ndNmxSJ+EsxPZ+?=
 =?us-ascii?Q?97Zg6pu23zQhW3X+tjTRvlxOySrn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:51:30.6566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a66ae6-47c8-4e5c-6de9-08dc643bbc6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
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

[Why & How]
We accidentally upstream unnecessary files. Remove them.

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt     | 6 ------
 drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt     | 5 -----
 drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt    | 4 ----
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt     | 5 -----
 drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt     | 4 ----
 drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt     | 4 ----
 .../gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt    | 4 ----
 7 files changed, 32 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt
deleted file mode 100644
index 1318c6fba3e7..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-dal3_subdirectory_sources(
-  dcn10_dpp.c
-  dcn10_dpp_cm.c
-  dcn10_dpp_dscl.c
-  dcn10_dpp.h
-)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt
deleted file mode 100644
index 9c2d7096348e..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt
+++ /dev/null
@@ -1,5 +0,0 @@
-dal3_subdirectory_sources(
-  dcn20_dpp.c
-  dcn20_dpp_cm.c
-  dcn20_dpp.h
-)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt
deleted file mode 100644
index 7711cd3c47a7..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-dal3_subdirectory_sources(
-    dcn201_dpp.c
-    dcn201_dpp.h
-)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt
deleted file mode 100644
index 0faee2a1e32b..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt
+++ /dev/null
@@ -1,5 +0,0 @@
-dal3_subdirectory_sources(
-  dcn30_dpp.c
-  dcn30_dpp_cm.c
-  dcn30_dpp.h
-)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt
deleted file mode 100644
index 7743edc4599f..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-dal3_subdirectory_sources(
-  dcn32_dpp.c
-  dcn32_dpp.h
-)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt
deleted file mode 100644
index 91df5db26435..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-dal3_subdirectory_sources(
-  dcn35_dpp.c
-  dcn35_dpp.h
-)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt
deleted file mode 100644
index 19dd73bc9ab0..000000000000
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-dal3_subdirectory_sources(
-  dce80_resource.c
-  dce80_resource.h
-  )
\ No newline at end of file
-- 
2.37.3

