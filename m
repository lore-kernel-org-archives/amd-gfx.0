Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A167CC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F7E10EAEC;
	Fri, 21 Feb 2025 16:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ovjFA9K0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C9C10EAEF
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmxEk4xmn4JW12RYJmnUmlEZgvacUE0eQSKVtThaF5gzlaAszWR72E9W9ynzfS29VVHtjVMMLsi0W+pUB29i6GFGqW6136e45nnN0yuuPV7IARxwk5ahP8UIYOpOMhwiwVXJB3PWnqBjja+SiTUW9KVnZGg9Xe4NP2QOU4gE5upRA+GrkZgjicdqm1bbMLjjmgrFdKQIHvOZUQvDuLTP6D2Y6yYJlVWd0Y0qVgnx0Grj2VHjwXz4Va4k5FGTpsneuJ80tAtOkoegzYp1JibnciAAPGrZXl+MMOG9jM7YeEFCHx89U0k4Xk5akRXmjleyPLhMO5eA9JG+3TwpypGY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktSDZKA1Mio12KzY0TAKNKjxfuIXj9t70SCO2FGp/RY=;
 b=pFJaHBZTCbNpTiyxmcNpTsrY4vJoHeytf1M2KcuzyBmpB4JaPifpTF8VJcIwOqB/fjl6jB2z0IZtUx8uU2D+oRre8oofhYUjHHSvd1JnR5XW32qQi/xWlssDjmiPJPsIzS+UZf2v2kWpRA16ShgJzlSZuAnHIWI4qCOTSmfgIVurM/Q99fJyUC4yw8zZAsACYOuDsxkgm+h+iz7IMFH+iUwsgrmx4VGBTd5fjt+E9noIH7vwMbBeUvQn12BA1YPIZp57PWcM5TtyDb1CMAjrqQTXveYCsI6Y0WlWYSVpGqPu5uiz1mwvShIieB8McQWJ9fa1NVvh3TsN9x85Sb7m6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktSDZKA1Mio12KzY0TAKNKjxfuIXj9t70SCO2FGp/RY=;
 b=ovjFA9K0GnSBkqr6ST+9Gax56Px7Eswm22fjCLx9B1kvp4vvxw+wV6kiD2P7qhI6tK+Wzje6dAwYx7JHw+mbGVq0xw7kq6dPNh2VJQArM5XKKvQMshnskoYmCufQ0jyCS/KjjAlj8MDssT/2v9FW7ADoOi/tUF86KFmJwR0YlPs=
Received: from PH7PR17CA0051.namprd17.prod.outlook.com (2603:10b6:510:325::14)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:02:33 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::f0) by PH7PR17CA0051.outlook.office365.com
 (2603:10b6:510:325::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 16:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:32 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:21 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 16/24] drm/amd/display: fix dcn4x init failed
Date: Fri, 21 Feb 2025 11:01:37 -0500
Message-ID: <20250221160145.1730752-17-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f10978-ff0c-46ed-f9d2-08dd5291269c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r9Q2Z26RE3SOHJt73hejVIsNR35RgPWmZpEk22ssK9j3krHymwKrajEAMRzX?=
 =?us-ascii?Q?flbxFgeZs1LyopewoIMGUEx1m7JJ5x0xWh85x4ord//KwTH3ZlaSOigy3bx4?=
 =?us-ascii?Q?x2ETu1janm9D7v9l94xj+T67OU58aSGpRFcJl5z8t0ngmiE0tpzK9vrPTKEA?=
 =?us-ascii?Q?aT14RMstG7iVckB4jMBVgF3hn1lNvT1EW7G+O9D3XAhH4T5kvVvjJxbATMN8?=
 =?us-ascii?Q?C7ngOhV4F9NCMuiW8qJaYsJ4pSxmVOfkR8QDTamLM1ntO5A0Gy2OooAIKsHM?=
 =?us-ascii?Q?Asv8YKwzXFEbTM/gBqfmeL5BpGcuRudh+wskOpJkvubfAfy+lRO06cJLToYr?=
 =?us-ascii?Q?HEh+gQa2N4cu9gqPV6e5CBhF+Ulaq12tJwChKkNfxUfGMmXc/SmJ5/cELct1?=
 =?us-ascii?Q?0xUbCusAHcbbP4MA8Fa1ANYORAtu1ljwstZyhOrbOwIx2c1rFn+jUWx9FFVO?=
 =?us-ascii?Q?aPj4/j+vNl7rN6Jo44bVRFBruqZ9myaitBKV5O0YCw3esH7QgMdu8h0LEc2E?=
 =?us-ascii?Q?WveqZnUSq479AJYOWVt/VflEoZQ0TcO2pqo0c+YESho+vkUOps/hb98Oz6iP?=
 =?us-ascii?Q?nZIwBscYGiRnNF++snNYqsYY0WfOyTVUVSEGicaX55rFfNQK48rgNLWimXpk?=
 =?us-ascii?Q?twhCZ/N0Fb0RbWpLuzROZb4hmUv/08fdY6QOVnrTiInXmQvxSUphIhyNzWLK?=
 =?us-ascii?Q?boMbasIKS8h1cmfTAqMtV3AViwv57qR6py19/smDQx3RGg1TUkyHmP4BtvnC?=
 =?us-ascii?Q?XEvpPLskc48jwbs6wRVXGFKCNXBO9zIbeTptOLTXoYIiSq+xwIf6cGMaHkmA?=
 =?us-ascii?Q?6l3GP63iifrVGaAcVleuUwLSbvbo+ZJLs0Vc1O6SOls0vHe1uLmHmEPOvZzv?=
 =?us-ascii?Q?prTw2Jzx7I0KULLwT2CqxTY3wO/HcMG6AKHuwotV6wcM5taUCnUHOsnc1DpH?=
 =?us-ascii?Q?URd9/eZn6cH6ElUQmLzSzWYzF3/mKCPV6I9rSOpqvRIrNinqrZnEls1pKRdZ?=
 =?us-ascii?Q?0gtkiNVjYCqF/+/1roC+ho9TDLNqbW9yq6I/k4BIwvwkRkxp1jhdfs9amLYh?=
 =?us-ascii?Q?JQz5rqsL2o9fjE/W0IrOPe4+yGbnKkgf4a1Ek5iarGXxx+hvkwhEBlaX2Efz?=
 =?us-ascii?Q?WcvEdJMplbHZ5yturKJ+1luaybd+PLMXr3ME6JSKHphhmU7iGDJQ0II3xoz6?=
 =?us-ascii?Q?ObiYIn/8bcBGqlEqMKIuso24WyAnWFvaGg+VTDR4bpVYYmcnxScnFTCha4uB?=
 =?us-ascii?Q?1zUXTRF+EB+VLtJU6OAjqT3chGXYL6Jrw8ZIJzmWsuTspjDmMrvYcaItAp7v?=
 =?us-ascii?Q?HtKmLzupmmU0Tp7lbwK3kbNCVjNZurrLK/EmfGyunUDGuc9L8CcouHeo/o6f?=
 =?us-ascii?Q?Ff7YIeSb7zMeo+OEUv2YNvNUYXjr7nrhuUDRwb5RKsCskFqX5vEkNc2FEL8N?=
 =?us-ascii?Q?IULsuYhxoY1Q1E/xiFqLOG1szUGxw29jZky/IjlMjPo7InRS8HrkV5PG8ksz?=
 =?us-ascii?Q?0lLA63mT/rLozlY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:32.6317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f10978-ff0c-46ed-f9d2-08dd5291269c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
failed due to cmdtable not created.
switch atombios cmdtable as default.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c     | 9 ---------
 .../gpu/drm/amd/display/dc/bios/command_table_helper2.c  | 3 +--
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 2c96a5e64567..2c645dffec18 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -101,7 +101,6 @@ static void init_dig_encoder_control(struct bios_parser *bp)
 		bp->cmd_tbl.dig_encoder_control = encoder_control_digx_v1_5;
 		break;
 	default:
-		dm_output_to_console("Don't have dig_encoder_control for v%d\n", version);
 		bp->cmd_tbl.dig_encoder_control = encoder_control_fallback;
 		break;
 	}
@@ -239,7 +238,6 @@ static void init_transmitter_control(struct bios_parser *bp)
 		bp->cmd_tbl.transmitter_control = transmitter_control_v1_7;
 		break;
 	default:
-		dm_output_to_console("Don't have transmitter_control for v%d\n", crev);
 		bp->cmd_tbl.transmitter_control = transmitter_control_fallback;
 		break;
 	}
@@ -454,8 +452,6 @@ static void init_set_pixel_clock(struct bios_parser *bp)
 		bp->cmd_tbl.set_pixel_clock = set_pixel_clock_v7;
 		break;
 	default:
-		dm_output_to_console("Don't have set_pixel_clock for v%d\n",
-			 BIOS_CMD_TABLE_PARA_REVISION(setpixelclock));
 		bp->cmd_tbl.set_pixel_clock = set_pixel_clock_fallback;
 		break;
 	}
@@ -600,7 +596,6 @@ static void init_set_crtc_timing(struct bios_parser *bp)
 			set_crtc_using_dtd_timing_v3;
 		break;
 	default:
-		dm_output_to_console("Don't have set_crtc_timing for v%d\n", dtd_version);
 		bp->cmd_tbl.set_crtc_timing = NULL;
 		break;
 	}
@@ -717,8 +712,6 @@ static void init_enable_crtc(struct bios_parser *bp)
 		bp->cmd_tbl.enable_crtc = enable_crtc_v1;
 		break;
 	default:
-		dm_output_to_console("Don't have enable_crtc for v%d\n",
-			 BIOS_CMD_TABLE_PARA_REVISION(enablecrtc));
 		bp->cmd_tbl.enable_crtc = NULL;
 		break;
 	}
@@ -910,8 +903,6 @@ static void init_set_dce_clock(struct bios_parser *bp)
 		bp->cmd_tbl.set_dce_clock = set_dce_clock_v2_1;
 		break;
 	default:
-		dm_output_to_console("Don't have set_dce_clock for v%d\n",
-			 BIOS_CMD_TABLE_PARA_REVISION(setdceclock));
 		bp->cmd_tbl.set_dce_clock = NULL;
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index bad4e4711b4f..268e2414b34f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -88,8 +88,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 		return true;
 
 	default:
-		/* Unsupported DCE */
-		BREAK_TO_DEBUGGER();
+		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return false;
 	}
 }
-- 
2.34.1

