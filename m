Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CBFC27C6D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E103410EB10;
	Thu,  6 Jun 2024 21:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M4sMv2Sq";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46A510EB11
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLdk9Z339a/nIAxfBbUmY+5Anb//63lwh1W6tn3W39kWGA0MFLhOv9wrQgnuQpA4L2s57x/EpJ5/2mDdrXd/eokTvwkoC9OdgkCKbX4Uh93veBqA6iGzIxFh7pbL1vxRNSI5Alo6FUED7maxjPGt86AIhrWye/ezThq71WvAFg1/OWACjk5R1e+uhIKqY0LUzNOp6pnqR5CaYfLCXhUfVYQAdtVtwHTCsXI3KSJaMCFk2/aVqvTUN2uNrtmvA9oOeqokx3jioaKV1EKAnRBAYDLa6g/WnvcBII+QBRSV/RJz2A5UtACJFQCa2188FymWMPbnTqaZ0sl1tEq+R3IhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WklIxVA766Holza7w6fM5zH1BtLGI3s2dKMkpSRHwDQ=;
 b=Gdx1I2axsNODCYp4Kzj/pO8opgWCheJAuB53RnjKj9UG+2o6CWyRxawBpQdZMlgFI8iYcHSv6C2g1Uk9Gbu4xfuy6fQ8vvjiRkmSAWuqPaGHyCwrFJX96CWBuhIg4911dcjfrLUFe5Sl4LjK7c+lcK/8jaWxLL254bAfhSrKfghoB1RCOd3CSba/92Z63+RUW6Gy8cpovnOzQ2mVQ9TM4WsVFE6nHttu44B720gTds2J5TWzHbn9bl5U3dGNme+QYxexfkDlDWckenvpRwwE3XryRD9TOnG06oo6u5nAeXGykxTvhoO6buAybenoc6Ef03a8qex3nmVF4Rzx8NIAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WklIxVA766Holza7w6fM5zH1BtLGI3s2dKMkpSRHwDQ=;
 b=M4sMv2SqAgTskobGi1FVOX8DyvmySlqZ4GHm8vV0ZnaHIS07vBHBBKzvys0UlaxzoLQR1R8nGkda9JY6R7bIclQMLUp+BXi3fZGtr4PYgNCYBfePMN+wt5cv/PV9q+F8LHOycWaeoGTiQnHEYji57QMXLAwTVmMwujcm0Wxe3oQ=
Received: from MN2PR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:c0::38)
 by LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:59:15 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::d3) by MN2PR05CA0025.outlook.office365.com
 (2603:10b6:208:c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:15 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:13 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Daniel Miess <daniel.miess@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 67/67] drm/amd/display: Disable PHYSYMCLK RCO
Date: Thu, 6 Jun 2024 17:56:32 -0400
Message-ID: <20240606215632.4061204-68-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ca156f-df80-4ca0-d452-08dc8673e81e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2fbKy02u3z1R2gdyF4WVgWrO0HDF2osOdWMoVGgxwBM84xE6xG3g3ITOTY0r?=
 =?us-ascii?Q?iqdG+H4qD3Hrb5NFXUnDjGExD58OYiVhUNS4o76b7Fny/BGoow3z5pQX2/pw?=
 =?us-ascii?Q?pJxUf/XDE8xKU5F/YPcjdtL0+M8ZHLJlzBmvNN+dncRWuCzZJy/dZsXLqyZr?=
 =?us-ascii?Q?YmyVyMr48bm+XnnfzKeQ6Q9MNu0ST6nuEeVcMDIMbVyK9x5+3Nvy2I0fbDRG?=
 =?us-ascii?Q?V/q05OjXc6/6ZPcIyX3RGOJGU2DKJblOilrHy+i9h1QL+IBQlVGomaBP5NYj?=
 =?us-ascii?Q?tJ5Bd05hlDAmVBJaf4kbPvOHLl29V+hjJQevm8bl3Aq+GCS7eDIarnzlSYov?=
 =?us-ascii?Q?xvOo8lwi6CYoskxrKzohTC9Y6ewwEx6Zek0idauNYiWmMLZe7wmzfq6aJ11Z?=
 =?us-ascii?Q?7iBN+ho2hGfA3xxKmqaQXMasf40xhRGH3keICBeBL4qUb+STJ0wxjFJHrmrJ?=
 =?us-ascii?Q?UHFc3rxhIZoh66WFqHtzafj1XcGivwv5c0YiRA3SLunx1U0gqyprPKjec54h?=
 =?us-ascii?Q?WkAaHAVwG6RnxmUT2YwQAlumJC/SaGWvGynVTdD63yXBY9IoMzY20EjCSuel?=
 =?us-ascii?Q?tobglzIZBOBRX4Qf3fPNEcx6SgaShFZ23NTUGKO3vsAT4PbcI7qw6zVT6DED?=
 =?us-ascii?Q?Mz7DZpoylhJZPG8ScNpyvgdgwjhWMgsjiBdE+CV3U5ExiZ+gnfPDBDQ7ZO8j?=
 =?us-ascii?Q?WZsyzhaf9MypeXVXRHj+maJElj1KyZhTWoC2+SEGnwbuP3aVFeeGG5FcJw6O?=
 =?us-ascii?Q?BA4PJOM89cW5heLXiwFbHdkrNg3BZmx5jvzMuj4Yzvpov814ZBodpOA2cXJG?=
 =?us-ascii?Q?InNd2PgikYp7TAVOk+pvOLZNaVEfplbJwOZmkHVM4u1/l3DvyWc4/V4DrpeE?=
 =?us-ascii?Q?IDKW90f27nJAzx/BRXsiQzlfxq2DXsc1Q+BB1wSJ4me2byEYsuIWrYvBofMP?=
 =?us-ascii?Q?mfmKjwlIEUK1DUgEc0edDmwxkDOx0DfAJQKUebmjeFyW5jLrPv53XpLhVLlr?=
 =?us-ascii?Q?8jhDu7oyrBLx0Xsk7JxxSgJHhR8oBl+jl/+6jHK6n65/Dm6wI1iJDZo4sqMU?=
 =?us-ascii?Q?oHLZUZ39Ciahr+u2T8A3gVzbtKt07Hg+7H/jhogsG9TqAWl6xyJnmxjP6iPx?=
 =?us-ascii?Q?aopDZ5OXX7X8Lw48c517Xo+wQ8w7ebjP1P8xD1/HYXpnrs371l+xwiC9RqOG?=
 =?us-ascii?Q?WUTBAopeQGaRa98k4GIEqksBAaxn9KmfQ6vl4UV1Y6QRXJ8YXwBxatwEH/C5?=
 =?us-ascii?Q?Cyqem3/XZhl/xJpke56sk/eo53xmiMWGsuG1IxMs2OgBW/Gr/Sh+p4hDHv3s?=
 =?us-ascii?Q?omQ8c1wFyQLvx8zL+C0IbPSTW1lLWBEzI7c0MJWIzrKy0vI+eLrs4At2FL3G?=
 =?us-ascii?Q?M71Ol5KC2+ILRIFoihCcgYcCPunV1iytTp/mcXerPRCbkko9Uw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:15.2682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ca156f-df80-4ca0-d452-08dc8673e81e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134
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

From: Daniel Miess <daniel.miess@amd.com>

[Why]
PHYSYMCLK RCO has been found to lead to crashes in some
corner cases

[How]
Disable PHYSYMCLK RCO debug bit

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 5edccd565b05..0094ef223c5d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -758,7 +758,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.symclk32_se = true,
 			.symclk32_le = true,
 			.symclk_fe = true,
-			.physymclk = true,
+			.physymclk = false,
 			.dpiasymclk = true,
 		}
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 203fd4aaf9f9..30b40ba0c324 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -738,7 +738,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.symclk32_se = true,
 			.symclk32_le = true,
 			.symclk_fe = true,
-			.physymclk = true,
+			.physymclk = false,
 			.dpiasymclk = true,
 		}
 	},
-- 
2.34.1

