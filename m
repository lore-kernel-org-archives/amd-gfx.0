Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B93EA8118
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D7D10E580;
	Tue, 10 Feb 2026 13:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IjUSXcV/";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012054.outbound.protection.outlook.com
 [40.107.200.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9370910E581
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:55:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffOdog7Q2Hdhjqgbqu/lh+uL8evjfC/pKu8u1HMPTB2u/mXmijgGpsbYmelqfFLW2S/mebDVcyHkC5GMirpmJZifNIznXyyhEqBWAdwuDX60zaXmccYWy2suxllunnhfEHGq43zUoGdB2F8UzUEPpA+d52G23Kr4406SBZ1TCeTI2ptNGS2Z9MxM9UYldDL5+nSlYomF0tNpJPZxHXnFhtXqxhzO4B9qi9K0X05v1Mc9EjdSs8o9Su5GhGectKy1vlr6kF2jHpfeVQS8/aD3brg3Wr44Baica3IH6ELd6pZPJTAnm891CzRi0npIbvgzAMsxx6sF54/9RhLTXC1iMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w/txDiiAqnSg7gKuta6FwKO4fuEKPqyOHn5sLs2hs4=;
 b=VyB8Skw79vbKpo4eHE2Lun7b9aHXNp+cWl/byki9OwdPKmk616HP0bEVgo2EPDVX37s6mznUXEvKMtydo1QCDHAdmcIyQNGmTKOjv28EaqOalNIZG0VUyz/o3UiQSyedxlHjd0kdPQewPBcFe++4DqX3C7pDSgzIZH3ssiH0zlhvhHeyQDjXBSxiP57SZJMNI/LzWaUkzd7LsrGWCVSuSYbLFMTomSZF26IWjwXfQ3YJmQ8Yoq1m7FgIIhYaheUZYTwTMQvwdrxUdTQdKytixHFfKJWsXXxBEVmJFrUILMMtOaTKvkOvDiWQwrgVp5cRARMd6N1py3ZoZBZb2T9zpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w/txDiiAqnSg7gKuta6FwKO4fuEKPqyOHn5sLs2hs4=;
 b=IjUSXcV/aegxe8NgkBOWlBJ8kTaaCVnxa73NviCpkAuLIfDaY9IvIdqsaLOUyF2XpTrp0prMkceFUS0wY7k0eufLD481wIb2uO5uqwfKid992gMG8j40Ya5lFlHj2TG5dAI718tofbjISVAHf6rixMiaNr6bZGmva+hqDvjNto8=
Received: from PH7PR10CA0024.namprd10.prod.outlook.com (2603:10b6:510:23d::13)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 13:55:37 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:23d:cafe::f) by PH7PR10CA0024.outlook.office365.com
 (2603:10b6:510:23d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 13:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Tue, 10 Feb 2026 13:55:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:55:35 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 05:55:34 -0800
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:55:26 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Carbones <Nicholas.Carbones@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 09/18] Revert "drm/amd/display: Add Handling for gfxversion
 DcGfxBase"
Date: Tue, 10 Feb 2026 21:50:02 +0800
Message-ID: <20260210135353.848421-10-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 25df9d6c-0b5f-4661-8f3a-08de68ac113b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zpuq3aU9EtpQC+or/CMlDEhnulMXsWFZGHpetEBNpqs5yRphXkykBvh0bXLw?=
 =?us-ascii?Q?MxOqZzh5tQ+WI+LP5rH8u1lQn6sZmQtFqMKiolJRYD+MESEQ8EnouLCmv0eK?=
 =?us-ascii?Q?CsOvKxFQbZKpRw06YpIwrsL1uT5HlwoAc/EgYry3FYFDKAYoYYwh2Dn2WZb4?=
 =?us-ascii?Q?wLhyM76OSMmvPo4eeI24wfc1sHAQXvA74VEAM7ccMchCDq2GWvRpMvbIeCPZ?=
 =?us-ascii?Q?crRJevGTmdDK6NPZJeWKvjDb/QL9lVhztt/NeQnUSSuWG3iBmpXYEuX3hmUO?=
 =?us-ascii?Q?8w1fJuZ/4awIV0CLA7k/LAzNFekuGX4UREVn79Axs9HWxPMykrAkDEmWFLQc?=
 =?us-ascii?Q?Ouii+NIeA7BSBYGWSRrBw/AzAkV5OKOn/7cem3MmFWnuzykWEXaQlWHRKCX2?=
 =?us-ascii?Q?fqXRNG1fNmDhtx4sP2ejMdMFSc0d1czcMeT+zVmBKfEFD3rkD+wgSNxDLog6?=
 =?us-ascii?Q?67ORscXCcl9pLElTBZU8dVm4rF00Zdk6od8IZV6x9miFYxbcaQsaVo/aYZQO?=
 =?us-ascii?Q?gLIqVnz2eLg9m+AccGvA43f8ViYsSxksmcAPBzqTCFmwvSE5zrowMdc++qwt?=
 =?us-ascii?Q?5Au+bCenKptudyNRfb7l7O1SGVB5mmOPjTPgLBWSgD3RqXcpyQrj1XtL7fD8?=
 =?us-ascii?Q?5gP79Nkj8IhvrlbHbXcOITpcez9JZP8C8w8XWXVSYD4K+RwCAD4ACxgiLRBA?=
 =?us-ascii?Q?uQ0BLTkmjH3M8rJLkclLwqRoK2pwx/aepHeWGamhaae+D9yvRDOAB3Cgkn4m?=
 =?us-ascii?Q?2A0NWx9/zOBpz7ySDNL8EKRh5TUQw/6XeAerXdgjdu889l5MCSvKULwlS/ek?=
 =?us-ascii?Q?p3fTI2G8iHwkyDc24cOyBaMb/rwHP/pNUGyok/ivgzMnlqjDrF0u8hDhVJBg?=
 =?us-ascii?Q?yBpTP5rzeEpwnZ6dTohKN2sFlVlgu9Gjqu4bngoj9MMbF4mJHSbn9gS5SOai?=
 =?us-ascii?Q?U5GlJh6xSaMgEuiNISg1AdQOzBXRO+EDUbHk7mrgtSgdO6rS9tTXuiOLNReY?=
 =?us-ascii?Q?1wDA/G+gAsiRRZvQNXtGlzoqOgV3C5zyccnB1B/tldoMaduH9bvnY3nijCk4?=
 =?us-ascii?Q?xRXzcioIVbo+kK5ZVNlfCAb7qVzdc99+2ecIfYD7nXZ/gMGy8VfM0oXSWNx+?=
 =?us-ascii?Q?YY5M+JeQVcfcNGhi/EsTFV2B50zMcvEMDMTBqk4vclIwMRGYnJuEXPhpXsuG?=
 =?us-ascii?Q?0EhrCCuZ5m35laxgtNokGx9Q02WhulXWgxVHLJnOJMuoYfI8OZ8OwtPPFg4d?=
 =?us-ascii?Q?TlxKY36knAVlmIl+XBhrWituehwjAVcW0a4+zkJW9MflAADuJKWHUyzCXv5W?=
 =?us-ascii?Q?yPn5pnf/xGIXgOaFFDmVbIp2Qs0swMV4BfZXaRl35Q95NLyPLbTa6iPww1SV?=
 =?us-ascii?Q?HutFUFRjuJHESFJ6yNfHu+XwMGbhgPTlvLHTbde6nwr9dUImMtYjtbCkCw+7?=
 =?us-ascii?Q?HrVPV8X9YJz0n1pK8H4OdJf4NcOcdoA6ps7G6vf8KoMxhMhii1gRX5v4ew3P?=
 =?us-ascii?Q?8DqsZQGzG84U/zrDoD1+2MOAMmtklELyv8MLW2/YpxLf/xU/iB+mDHi0iG91?=
 =?us-ascii?Q?/eAO5qLCFR+GIS00B7yPMyIFKVDWLcpF9mEpD0M3i2aLna1xVsmvzjBOtXVr?=
 =?us-ascii?Q?wD02APNc3QRzM7F6ccyKtGlEUQ6VWQeeVnFdpojkeQ5KFGA919CX2HIUCv4p?=
 =?us-ascii?Q?v81OTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uOmDyBGi+jerdZ0MmTTk27l14SHlF5Njka1DHV/Mb4aK/F3KlGxYYCXJ9tTDXE984ne9kv6G02y4sijZZSxao1kaz2tyTiTaFUyOLezSwwSSegHtCgIZ9jBNoAUngFu8sJQMDAXFVwJIOxRJwdFVoHv+NHwA5BC6jDOYYqfOskn0e5EOdkDnjeE68iu8f7/9Zh/Q0PVyav7iirFvDd7kqhIxvQqzfDvDv2Pa0QY/OgdJdJQSdtKkOpZOSrwAC0mdNjn3X6Bl6ePvXwVEEfGAUE8RXozdogz2yJEs/0ioNnCeVapY0Hl/K2FHPg4D2hffZV5SR5t1jB7J9+L5UBimM6f2r+Q2PxBVP1ImE4Vtr16Y8sMiuL5OOB0Q2bH54k78F0rrzS203UQdRO/+mU9PAAmgMtlV6HgbnurWUco4ahgfHrcsIsOe6DbhWhAoHxs8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:55:36.5154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25df9d6c-0b5f-4661-8f3a-08de68ac113b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274
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

From: Nicholas Carbones <Nicholas.Carbones@amd.com>

This reverts commit e563d5a20036 ("drm/amd/display: Add Handling for gfxversion DcGfxBase")

Reason for revert: Cause some regressions

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Carbones <Nicholas.Carbones@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index f4bcebd7ec7f..75a279997961 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -460,9 +460,6 @@ static void populate_dml21_surface_config_from_plane_state(
 	case DcGfxAddr3:
 		surface->tiling = gfx_addr3_to_dml2_swizzle_mode(plane_state->tiling_info.gfx_addr3.swizzle);
 		break;
-	case DcGfxBase:
-		surface->tiling = dml2_sw_linear;
-		break;
 	}
 }
 
-- 
2.43.0

