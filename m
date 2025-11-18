Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79719CF2562
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 22:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22A2610E53F;
	Tue, 18 Nov 2025 22:58:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fsjX5yiS";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E982510E53F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 22:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=defeUXVXjx1SsHvf2nGQPDkCNaZVVfUr0N2K/n3++k/b3VcFARPINwxNL1nVg4j7skLpLnDfMWb88qT0hLXtkZhXI8x+VJC74z9axqbUBow2O2PMo/TpmdWzQzR9pC72/e8YeQFJfZItoGdGigSFQicpHYDl94rVPl6j9bVx+216OMKCFOY7zQLO2JL7XcHkh8Q+HCH6vnSv1qmuZOm/XfdqwuWkGodSDRcrglLXp7a+HyFbhEUTjaSfDbw2KhqT1pEiNaoGQyEAfb7c+btlcMdfWjrRtjCicuKZ0P+kmUj9VVpOTd8bWcgoDW3+XfrWSVULmTo8dEOJ1djEkn+8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89JamfB4UVmx5Rt1mt9L6+1qYbRBjeGoqqN1cYlsAfo=;
 b=QHu1f5X0L9IRnCQYzLDhGqN9w9x/WkPuWCybjiSVPnOqOtbgaUPwkDOOAJdiI5V1ge2uilZLbMD/BA2IF7XwlgVySR56o9cnzEPH4I2PzrwrQgBt1FV3Bv4Ys58xjG8WmqhJS28ICOUW7jcwvCpfXFP3nes+OedN14TWrYFtYTzHFzypE3BuoocvYh89/FeJMyoWXYVMAtnf6WKaWrQ/eTn5wJ/8cwTT03yZHL1IOsruPU79Od2jLyT2OZJL5aBr4EKf8U+erxG/dDWKtoWlJHhKERnoimrfOeAURPpu57XVE/TjstbGTodurqpbHdgUIFLq4S78/Hh3vSm8dfC8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89JamfB4UVmx5Rt1mt9L6+1qYbRBjeGoqqN1cYlsAfo=;
 b=fsjX5yiShkDHkLHZ3J8HVpoH0C1+jG3txHYtcczUh0ULU1PQ3pnMr/1OwrAdjVUzMPUV45J6bF77hIX97+1pZ+JbVkAxsN+Zjh/MEkdmRFRlSujT0MkODvxDl6iOtzIfvGJ/TzlGsgoQo5mjV/E+79EQ23mmFj0p6OSxV+Zhn5c=
Received: from CH2PR17CA0028.namprd17.prod.outlook.com (2603:10b6:610:53::38)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 22:58:09 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::7c) by CH2PR17CA0028.outlook.office365.com
 (2603:10b6:610:53::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 22:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 22:58:08 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 14:58:04 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao
 <Likun.Gao@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: Set psp ip block and funcs for v15.0.8
Date: Tue, 18 Nov 2025 17:57:50 -0500
Message-ID: <20251118225750.3613219-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118225750.3613219-1-alexander.deucher@amd.com>
References: <20251118225750.3613219-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: a5adbe9d-4a39-4024-9acd-08de26f5f100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yo49qeNdi/c0eQqct/gXrPg4BAhKxVGdZZ4h2ExsPOk+q7PHkHtbMN5ZSd6n?=
 =?us-ascii?Q?+3KfQlh1kaYfWb81K0NnBAh52XYyE/jt8+adJKefqYRJW2DBJXGbXg71RoLO?=
 =?us-ascii?Q?57lq9b+BlknDjBf09Bol70L40cVD6G/DLoLd1jhDiZ0jZuTjdI1Jl6ehrya4?=
 =?us-ascii?Q?2e605BxEUa2c6vfOz/axvJfGFzYkz6zCAHdD/L3y7rzyupVjTBH3G+1xp7Tq?=
 =?us-ascii?Q?hEBw9WNdxvnkMGweAgdlEIAF4AJZ4UV7qEMnlBFyoYrmfsbUXx1+LAfq/yo/?=
 =?us-ascii?Q?MWKdxXfJVmbpjK8bQBb7D7XOi4e9bI/SYg/AP7WuV+sKO4qhUOkYfQS/FKF0?=
 =?us-ascii?Q?Gvzcoisk1yokDdFi4gGXeXKhb8ce+rn8oaSxKgi/B4YQe5arNm4Gv5EZC9gp?=
 =?us-ascii?Q?kiegJzG5XR3GMmGkqP4KGslj6grxCya3PgUikYgJQ3pzOUi0yVsDuEAcjzLl?=
 =?us-ascii?Q?ZdRX1MZoJnt/8U9woWrH+wAopVQzTUy639+QpRNaZbnlw2icZrxKiANWCexO?=
 =?us-ascii?Q?IM+1vuXZRoxgj8/0xhs+9d74YRlbBxz43gpr1pS2hMa3PzXUDpQ25PtODXbd?=
 =?us-ascii?Q?rwliegE9w7T3WEVNQTSxRCE1FHgE3WHZsu0Q/o5cRmkJrljvyudydlI8oYL1?=
 =?us-ascii?Q?S4bEZLBz7lD1TK+pUTbT51SKsZo5mu503NaSIAICyUv6IKSk5g8284lUfouc?=
 =?us-ascii?Q?qxLNlpxda0Z4C12VGxmm/q23tG2F6qmdIwf8yEXx9I4CN1Yt3+aiGQ8EOIBV?=
 =?us-ascii?Q?UP1PNyIydl6dXoh6B/EHB6EChw7rD5mKqVlHx0JPxAk/mlAYRNsX1pza8JE/?=
 =?us-ascii?Q?CtQcApRgU8Gfb09EnSn9sjEwgohAFIADTw/XN9TnfdIk9G0h52U4okAv0Fyw?=
 =?us-ascii?Q?FLbwlCK2jMq/DCY7JUbTni5vjvhQAOAsVEpegbpeAUyW62681ASeAuGqels2?=
 =?us-ascii?Q?i1rQzvD4t8JUZVlkS5bQTkt9FMC7lk1BPgGUVNWwDd0hP92J0dFOIapq+jQs?=
 =?us-ascii?Q?ZDDuVKPXoAhS4suJT/KB/TmtGdWG+qCSKSZ035Wr4f2LSMyGie0fbA+CWcsG?=
 =?us-ascii?Q?pvZVwywY56vw8k0vZeHZrJF+Eiawe2/EQ7Zv8T1LsnOjIYGGqJL67y0SX+8w?=
 =?us-ascii?Q?j30gQjTlTWebyqZLBbgBuhubz2zTPhWZuOdMW7zJ7pOTlx5uC9jbzYi8tXxS?=
 =?us-ascii?Q?tSoDJrOzNoeGW4eiZHmUTZ7DI11lI4/wG4GpsMGKZfXWYC+B+np/g8kJ8gEo?=
 =?us-ascii?Q?2ZlpE0djvMINgmSSZEjR5K3s5JJa9Lc4o5hbaqQlVeuS3UMJEsw2GKSRRSFI?=
 =?us-ascii?Q?PHdDCCWGpsa6DvUeyaHy6tPUZLl7mq1iW2bN4T29cBTpmPvXWpUWgIICFkWd?=
 =?us-ascii?Q?4oPQL6tA4sO7izl/ihC4Bs53IjqtAVbxDxmSIA27kjHbOhUeKqZOHfze1MdE?=
 =?us-ascii?Q?05vQoRpU1nDnZywD2MMYMLXT0p/LsSSEpy7YKqvVHo34r0Ig7oUIDVekjhpI?=
 =?us-ascii?Q?Qw1etyFaK+7HcB6rCWqClh4JtHSh/U6VoV/xU8kLWwZ0liiHrYEIn44jpQPn?=
 =?us-ascii?Q?xpcpMVYWv5Kqwzcj2x4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:58:08.4590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5adbe9d-4a39-4024-9acd-08de26f5f100
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
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

From: Le Ma <le.ma@amd.com>

Set psp ip block and funcs for MP0 15.0.8

Signed-off-by: Le Ma <le.ma@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 959136c163ffb..b184e183c1398 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2154,6 +2154,9 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 5):
 		amdgpu_device_ip_block_add(adev, &psp_v14_0_ip_block);
 		break;
+	case IP_VERSION(15, 0, 8):
+		amdgpu_device_ip_block_add(adev, &psp_v15_0_8_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add psp ip block(MP0_HWIP:0x%x)\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9c1c8b4125fc0..a4ddb14c1bec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -39,6 +39,7 @@
 #include "psp_v13_0.h"
 #include "psp_v13_0_4.h"
 #include "psp_v14_0.h"
+#include "psp_v15_0_8.h"
 
 #include "amdgpu_ras.h"
 #include "amdgpu_securedisplay.h"
@@ -259,6 +260,9 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		psp_v14_0_set_psp_funcs(psp);
 		psp->boot_time_tmr = false;
 		break;
+	case IP_VERSION(15, 0, 8):
+		psp_v15_0_8_set_psp_funcs(psp);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.51.1

