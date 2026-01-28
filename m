Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54701D35663
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE81110E605;
	Wed, 28 Jan 2026 02:00:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kBVYy/T9";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C7E10E60E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiSIMVSZZWo9V8cZhWRP3xT00k4ihPrOoAqc2zEMAK4/gVpq7Km4/wMIbkLFggBRNuw0+HTe2yZu4iwPhZ0uKwq2r/JGwjDQCo/hj02rMjStFsSbtftWgnRHGi/6PGnu941om5vomj4vy6YstsmgT/Qkt0uZRfq/Wb5TP0RD9D5bgCiZF6Yb3w6ikT9A7Gt4VKFb0lvac9ZsCdEgeP2San1cupeGj+hHxad3ElOqPnu4rJ0sN1msG4Nddqte39vgiT1vTsTxPCwaaFJtzRcuHgWlGGxO+I9lfh3REewtAe1+mBNP+EuEK5xV9r4x/9ZGP6miN4mfyuDQUJ6b/OLkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKe77K4YlxwMmOckWCl7GOp1vhgrN+bPPDtzPg4Gngw=;
 b=qJBYhwa9FhDGiRskWmqaeer/DB/S+LGrTDtNQ18ZUn9HG9roiedEJjzgt4w4D36fpgiKCbW3H8wFzk+q6bI3D3FToGWOuWZECf6v9MRayvWGyXNouBD4DrIq65kqSTjh776mENflogifO/7/od8zD8VSQtPoLwt72zhLQmKPBgHVaRRpvbxZHR5VfNt24FKrTo/D79jciQh6B5ABcjRF0flZJC0R2JXyFKsubMi3WC0TgKba6anOZqeNTL7Sq547hB4bFhWxTiwAP3SAhmazeIluVz8NMQ5tMm4VOXvA0pMiTsbmSaEZdbKmaY+xjZ5edBex5x+No4uFX74aDvD5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKe77K4YlxwMmOckWCl7GOp1vhgrN+bPPDtzPg4Gngw=;
 b=kBVYy/T9ANKz+Xp48h5ZqIekzqSxNklXr/9TJwxfZiJoN1BZTJFgDXSanEU1rOSFrNBqghxcuLowfAt6WkyrwVpkgjdLf+DkgLQkc9F1DASQ/LSPcrBOIytnm8x2dBplY52chbUlIagHB826puu5x4yYZRYT9YS4+b0u25D6LhE=
Received: from BY5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:1e0::31)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 02:00:41 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::55) by BY5PR03CA0021.outlook.office365.com
 (2603:10b6:a03:1e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 02:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:00:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:31 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:31 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 20:00:28 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Carbones <ncarbone@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 19/21] drm/amd/display: Add Handling for gfxversion DcGfxBase
Date: Wed, 28 Jan 2026 09:51:44 +0800
Message-ID: <20260128015538.568712-20-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: d044d150-4a17-42a2-b4ec-08de5e110a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pSyj6BYtu+fpSmjgBa4mdc6fAbmM5mPQXzyL/q3Y8E8d5FnHGOG//lBt6bx1?=
 =?us-ascii?Q?llZYla+IZ/eTtMF5pugS+P6Enn5/kULxYzSoT5ODriXNoOlcPxtfv3jWKYKR?=
 =?us-ascii?Q?+47m/DqWa5qNSjP+4IeCsayFo/NE7XMKdH3EhVsjNy1w6q2I9lvar3BnyeHW?=
 =?us-ascii?Q?H2lWpNv3QLyTYCqKGYKp/CwaDwWDW8DAjFWtytIfC2yADseBByB3rxghMk/Q?=
 =?us-ascii?Q?c37mL97eKv1+bSda9Ab5MIOY3b1vl03w+HiKbA21H82s/Y9M4HGODlK7bR8j?=
 =?us-ascii?Q?yA/g71bdnLeKbzVH4rvgqbGeFcw953fdrZq8k3xPprRJ4Yf5sn0g6Yx8UexA?=
 =?us-ascii?Q?FbHlVqEJRFnLNW4NkkUe3WF2ChR1j9mYXEoOhNQcvo1s7k05MGz2bwmAEHGu?=
 =?us-ascii?Q?0PWKhtFJdmTj4GJtTFS4zHwaJYdoSfb7FdIHkAl75saZrxEAkYOM8jD0+0Ng?=
 =?us-ascii?Q?1niv35Q1YA465hDVMNL0JVwowgcOA6DfdsT7dhFXgYsP4Y8N8wlzNbUMOGOm?=
 =?us-ascii?Q?kVrayjBdBNdKiREeeaQUtnb6hTp8a83LWzWGoSDjY9njaNRYS1YYEY2gcFd6?=
 =?us-ascii?Q?Xb4CPqj0HrzLnXRfgTXJf5O0pjV4rj/9F4hB5ccLBZdHZpJPypLW6c7RM/dg?=
 =?us-ascii?Q?V55rgkfp+ZFsZ++HCdKiBHuk5pU1KLgOqoRi0U0hrO48FtmRLiMHXdbqd5vH?=
 =?us-ascii?Q?tTtldh9Z9iidWFnVpkjy8v8PJAHJBTDRwRkZlG151bIFAstRakEOK1N994fh?=
 =?us-ascii?Q?Tcc/4VUe9mTYKstiuGkfrOrQlSpt10HJ9sJdL5L2TTnNcKuh6z0bjkgbH5sc?=
 =?us-ascii?Q?+6gwYeNao0HTmKl3q8Wr2AychcOa4lIaOKMhEwCfjl6ZTq44Tm2sdHYx/lUW?=
 =?us-ascii?Q?sJ1P1FtUnkXDbtTgdV8EfZXZFLXheojswH8/j4+S14s5bF0mDcmf9rlO4avf?=
 =?us-ascii?Q?NvWlV3HAxyL9ITgVvQkSh3/rqwnwZcCQ4hpOrqzfyCacRkbauwg9i0pBGrpX?=
 =?us-ascii?Q?xLP5+ufZpXavbJOZJ+a/XxmiX9gwQ6OZL04oh8CApJTltN5JJ6WJCdr3J2RH?=
 =?us-ascii?Q?rvLqbSCP6wnNk02bm2wDgWSecGB9n2sd5vSA3SO8C5tf3mO+pH7n12QNSgf4?=
 =?us-ascii?Q?CAAcH0+bv/vZCZftQxbE+Daj8aHynglY1Rbv/HCRigehNsxEWUD4hiA+FktO?=
 =?us-ascii?Q?VpIV54A+pMNvXuTGi6vejvsHZUCfS55LRBzee4sa79iekO2EJGf4JRO/Vo5+?=
 =?us-ascii?Q?mBkq3ni7Z2t2Q1IYLzSKRTs/1IlGmlOoGAMPR49tXYNpffE8IUlMF5L/HSw+?=
 =?us-ascii?Q?TLAScNANBLIfPCiJbGc7UW1rtRCB3oS6MOw6jOBwNi6PvES1QqhyOwTdD3Xz?=
 =?us-ascii?Q?NMVUTBcEp5+kfnCpVk22kN7LG+1FObQo8Ne3SkB8DUWtMzHuDyQwY8+9fPPb?=
 =?us-ascii?Q?tAxaFSjXiUaYcqZNP/dKB9LCnsTkO24NrWvG/TsQNbgCu+iTkhCTumwbbxlr?=
 =?us-ascii?Q?3Hu/kxirH99DnBkyU5kJRihcUhBTs3srn+oaQLlWE9g1AxIeQjdhoZW0QJSA?=
 =?us-ascii?Q?b61v4k/D1fFCiahvjWrJjOL+uhsTTCf7pROHAiPeP4MY+WY4Nemj1gHGlWYa?=
 =?us-ascii?Q?CIHdr1Q5sUaS1POEkUEnb0gAkLyD2CW6DwOCY4wYMMQitl02VyI6vbWcULkt?=
 =?us-ascii?Q?msVdFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:00:40.9147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d044d150-4a17-42a2-b4ec-08de5e110a1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
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

From: Nicholas Carbones <ncarbone@amd.com>

[Why]
There is no way to set tiling in dml in the case that gfxversion is
DcGfxBase.

[How]
Where tiling is updated based on Gfx, add case for DcGfxBase and set
tiling to dml2_sw_linear.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Carbones <ncarbone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index bf5e7f4e0416..3f4963ce3a00 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -460,6 +460,9 @@ static void populate_dml21_surface_config_from_plane_state(
 	case DcGfxAddr3:
 		surface->tiling = gfx_addr3_to_dml2_swizzle_mode(plane_state->tiling_info.gfx_addr3.swizzle);
 		break;
+	case DcGfxBase:
+		surface->tiling = dml2_sw_linear;
+		break;
 	}
 }
 
-- 
2.43.0

