Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E66CCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 410AC10E706;
	Wed, 22 Oct 2025 07:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NazeM8Hj";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 234D310E705
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=op+8wcGcoBtldwAul9ikWlzjV3b1c8bulzmTrpxMu7G1L9PWa7DoDK816M42lm1YrPzRrRhfnrhEpp6uM4nYUsttF31YXhZKMX8EXvoSrfeY8ObFDdiu9g8wGpZ+P/VpuARitYwB8tgJVAX28bwUs00tFAn/Ebdm7np7skRQIce3dsCho/wos34jKyjB9uvlu5a9ZutN9lCAp0w7x9JkSCVTgAqYcv/IzQ8wt9Qg8RNNFeaUHHg8Le/ydCnMTsywtM+sIPGLR5SGNiGIcaTNVeA0vzwKkPhsJ4mw9pW+2sTAUr6JwhZ0jCAPJR38p2/hmuiCUeI5VLSM60DY1DwJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OF9+ofXK8IlPMeXzPhe8ec+QpviMW51rW3a5V7I9osA=;
 b=Zf2E/UBH9lmaJ2yPTaFpN5zyXbRc0mkxjbGYZ/sXkVGIwRWAjbRbBCgEROTVCB2+G+EaSKaWJSISdPHuStqTsX7EpJ31tfSrnfNu1deCKldrPoamWmb+Gcw+du6dK6NbE6GXq4EQEEwmgRFUruyvFlwSBdj9nkE3EXsRr9y3ffVCYi3VTQRXhI6WNdswZ/0xcx9LZ+1AMTRmaKaEr+P3cxA8XsUyj1HhDdRlu63CgcXGZh9nn7r+tFYcc5ZApD9PQjVZpK9eF4CBjoRQWOwWVl+KSIAtr7UZWnplG8yPlJ9nKXQ3FkKW6SQO6bZpGWi2j16KHqrkN/DVoJ/uWxblHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF9+ofXK8IlPMeXzPhe8ec+QpviMW51rW3a5V7I9osA=;
 b=NazeM8HjevpjsZoWRO9f7Ijew9EjyyXsvOk2MNYIgC4hx3WNIowkUWg+acwtpNJQW6soXM441smQKIjgvoScZNyXykUD1nlaD2Fo0JSw8wAYED77kOTgYeYQoY8tbVwTp0fWmgiaL5Nks/Gz33QUkVKjkKL/ktr8fcjcFEemlbg=
Received: from DM6PR13CA0031.namprd13.prod.outlook.com (2603:10b6:5:bc::44) by
 IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Wed, 22 Oct 2025 07:35:32 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::9b) by DM6PR13CA0031.outlook.office365.com
 (2603:10b6:5:bc::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:35:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Oct
 2025 00:35:11 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Oct
 2025 02:35:10 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:35:08 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 17/20] drm/amd/display: Add HDR workaround for a specific eDP
Date: Wed, 22 Oct 2025 15:30:29 +0800
Message-ID: <20251022073332.666119-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 9128bfc8-7e52-4d1e-62e7-08de113d94aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C0N4sGJK96lFR6afcGCwywt8RGunqXBA2rvx09mVNtTh+gT9uEeMD61EonjV?=
 =?us-ascii?Q?Ca72JCfjCdGsp5ePyi/TgDlfZDSWs7r4CUqrNbk44EReldyRXcd3RLmky9qC?=
 =?us-ascii?Q?WN3Q8jP5FUOFjBQP+WaUMX4dPTf0AKvpyhOOhhvg+UH+eSr8CLMfPvafMjAT?=
 =?us-ascii?Q?nlX65YujiPZsuVUyavckLIHBILeZwbvbhAiNb3g4KnUWvD5zag2zrq207Sb8?=
 =?us-ascii?Q?3/JULUlxVx9gH4RdbMo5K+c5ZbwZVWsHxACjOFWdI9P2kuWRcm806s+dsq27?=
 =?us-ascii?Q?XjQWwFIiGD84NvLeMC5Xg+RRspcT5AiKZC0khRv9ZlON1YMs1LjRmOjwOJgY?=
 =?us-ascii?Q?kNpc+4UWDnL1PD7xdrzMeALPzbGaY8KIiYXIphWv9z3MiZ5+bBchaci4aM2Z?=
 =?us-ascii?Q?1epIyuZ+DUp8uyrXirjUIU5M8pqYDBzw/My1IaI9pUelzaJzWgZe+paHfurc?=
 =?us-ascii?Q?7oA2hp/hZoEPPCagknuz6fbHnFVxsp++5sSAGQZZea3ZWm33m2fMSTOZnIyq?=
 =?us-ascii?Q?PYAy1YMYz55m0AiJyCRTlFaneN+NQ5zsa05mpLcXZn+mXqFotqYwEpb0TQwP?=
 =?us-ascii?Q?rPQF4W2nnqhFaU6FvYydWYyN/MuCKTFksFPq/ptHDyL9FnfK6aRzbeGdWoDM?=
 =?us-ascii?Q?+nBA8VBn6YhwVkw6oFs6c8e9C/FAXkSxECXFQ8v9p3vSNJti7Zto4b39AQ8Q?=
 =?us-ascii?Q?PFoYmCd2JGVObvjWRL6zXY9Ru1ecdvmK0YnFZLWxJ3Q5R3UJHUHDJhuD6zmG?=
 =?us-ascii?Q?FaYGobBtG1BbUCsRGB5VgHxpiqM3qIkj3C901MtVzmuLrQiInjuwvKTXK/kM?=
 =?us-ascii?Q?PaVh6kepDrYZA1R4jl37o0WLLIwtyegGIK+zSFsx0D4banqUbMdQt0ZJFoqT?=
 =?us-ascii?Q?T+mseumjreAUmXD31PU31B5VJU3hflqECp87NWWiakzLKaWIX2E6W2xCqCej?=
 =?us-ascii?Q?ZZ98G8UZXOuMTojz7kAD+L24yQkWhSrLLrWHg5zUMkUXLJphXc7pNzOsi8Yx?=
 =?us-ascii?Q?6Q+7vbXDnTzS4TFRGljqVBdzepwOtzWiv5VjKBVjnaWPZBKiJtEo6iZ1BITP?=
 =?us-ascii?Q?1wnmPZTI3rWsAzQmqnFKkvtUMVdqhG3lVCn6KMvyJe8miwj4MU9whSaPDrnO?=
 =?us-ascii?Q?Qm0WK3PlUejEIOnLliqhfTThh4QQCB4QGWpK7AInfBdQ+zOzJKeJ3ysG0DNv?=
 =?us-ascii?Q?x7quhoH0YfBuPDjrlovG6EuD7wiKCTYBFvY+9w+S5a7TZRCc7DaXARcXtp3k?=
 =?us-ascii?Q?fqNbX5Yz9+xuvFwt1ZQIwogt6FTLV+R7/EDOj+tdmttbJL0PgO0aGVNgFQUr?=
 =?us-ascii?Q?vflay3HZJb9XwhbCh1L526InHRq6WPU0MjBnXxeoOXaKGhD0J/9q3alI9jG9?=
 =?us-ascii?Q?yaFyhQlHAfYJBtFPWoWOKpoz6CDgA44SITjglwa4cj3z/uq9jPv5N5Iu2Iu8?=
 =?us-ascii?Q?Vk0JJGDwakk20v0o0zpg0+WzrXE919o0vwRFo8WzuJ63hoqAKcpi6IL354l9?=
 =?us-ascii?Q?kDnvp4ZRMmXD21QYZhTyHJUAGJrvMt4zSFjdqukivjdqs/5PFe5hLkQsVQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:35:31.7373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9128bfc8-7e52-4d1e-62e7-08de113d94aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539
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

[WHY & HOW]
Some eDP panels suffer from flicking when HDR is enabled in KDE or
Gnome.

This add another quirk to worksaround to skip VSC that is incompatible
with an eDP panel.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4452
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index fe100e4c9801..cc21337a182f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -83,6 +83,7 @@ static void apply_edid_quirks(struct drm_device *dev, struct edid *edid, struct
 		edid_caps->panel_patch.remove_sink_ext_caps = true;
 		break;
 	case drm_edid_encode_panel_id('S', 'D', 'C', 0x4154):
+	case drm_edid_encode_panel_id('S', 'D', 'C', 0x4171):
 		drm_dbg_driver(dev, "Disabling VSC on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_colorimetry = true;
 		break;
-- 
2.43.0

