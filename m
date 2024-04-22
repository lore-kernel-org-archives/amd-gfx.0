Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673E7C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2604112BFA;
	Mon, 22 Apr 2024 15:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wkN+6e7P";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B19112BFA
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOzPAGoz3iS290vR1V81gA+jZF+fQ2u6c41hiFRIVZd9Ec9TcBBedkvK5sDNjmw5CmqpLr/dR1tTcqlEiV3etg2I1R0CxAEjOUpsT4HeiPbrT+eTkee6Hv54U88qcHNsejHJZ92fqZ7ZvnAYGSFqki/nfb0k1TdX1twJA8j3H4Tj+KgbnQpefbNSiT1Dz68ZySjlZjV1HYXFXJv2eoOl2bS31oxbAbD3iA0IPzYB1ZN+O1GkJcHo/zuUEVKBEh02WbtwjvmQ/wRBz6piwOFgUAScaQYLoJeAuux502uPa5sjl31LlQNEWTlbSaty0yPhZf59L6j8Sj1OW4v4KLaqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nTLfPSZ6isDz10jESQrJtECFlwu1hFlMsGtN0FD7ec=;
 b=DJxPh+y7Wz/2tl4VlaVlPk9pjsblKgMkGWDVYMFQzyJWPV6YhldNKJjpgm7UHc/i4RDmmxFGmQn43yOA/aAx5CMJoPkj2M6/m5/sdfnmtsWotIC9CRYUMoMiCzHSntB6in+fGXKZZ5qpVhpmKlscwy2hYwwdXI3zB9uqRxpQO8oogRfcREfOyFzT/XiwLJMuqLa3e+OWIEil/JkcUg41iNqndAVEXWLQloGuXri6mDSV6Ya4Ih+iknZuK6W3rF+gfGex2/WJO4kr4AORtCsLlDipxxsP6u2OGjpGJ5fS8wnopV5zL2QMeKcLgBp0PXf83E15wwAhucoK7butjDgbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nTLfPSZ6isDz10jESQrJtECFlwu1hFlMsGtN0FD7ec=;
 b=wkN+6e7Pzb5VbgJCzAq7iqhMxoL/be3iJfwtMEopZ3u9LCoB87hU1VY1qXnqii0ej7SORUbD5OQdCOOEtJO9ECpcMActVDeRp4EBd751quocmKZDXSe4xFCgPGSyAif6/ChAwRc+Xmim0LcchXthgdAuGGYmtsfxVMjEKbJznLA=
Received: from SA0PR11CA0091.namprd11.prod.outlook.com (2603:10b6:806:d1::6)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:30:19 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::cc) by SA0PR11CA0091.outlook.office365.com
 (2603:10b6:806:d1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 15:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:30:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:30:18 -0700
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:30:12 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Gabe Teeger
 <gabe.teeger@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 21/37] drm/amd/display: Atom Integrated System Info v2_2 for
 DCN35
Date: Mon, 22 Apr 2024 11:27:30 -0400
Message-ID: <20240422152817.2765349-22-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fba5e9d-2d3f-4640-bfae-08dc62e11e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f5I9Wlb7CDTioGSwzEb0W2lFxi8qp10wx+WefcwLVGyGnq2M4axssVhVXA3/?=
 =?us-ascii?Q?hW95IGYY04Rnd8ao+3OWm8KDiIzmqP9ItBjaDe56FOEq+d5BDDwbxwoljlCD?=
 =?us-ascii?Q?1s0ZcR/W9sFKXVpWtjT+Xu8O/hhwB6LC/TLe3aURqRnuypXlMSpPJxMDhupY?=
 =?us-ascii?Q?LcVGyMZ+DX05vEFEVI+LmKSKi1NqVlTICZ2Eaevs+2GGld6CmTYuKySxmGp9?=
 =?us-ascii?Q?IiYs/krOFgBQ8aANZlUBsj00Yby3u0gGaPIypvYbTJ6t/CXsDWBDxjJc7O+b?=
 =?us-ascii?Q?9lMJQE4dVl1gMzqHuG5ppmaX+4DxdLXF/SnVQ1MzyRrauKHgWdFgWoPex1us?=
 =?us-ascii?Q?g75JVi7V089aT9+d9lI/ng5O9hPGtdmdasF8TP1HlNzlkbtK1TWI5VU9kZBF?=
 =?us-ascii?Q?sl4Z+jhsB/GN2yKQbKgBGhoRw5m4W/7hmE+nv86awyccUAiEDxIbe2ceBfgT?=
 =?us-ascii?Q?gjW1tAbUbUIH1L/wpip2w7oHC9HOF7R4v+0nsQ4gzcBR+31KFGiq/g3ms9NN?=
 =?us-ascii?Q?z1uHF8SwUrLzYru8gz90ZWANs9rO+I+mGDDPNj29sE4SHqOsmMHgLe3DvPCO?=
 =?us-ascii?Q?sDa/sCCZ+fX+1mrcK21IcxD7yYKqQZ6RwA9VaKZU8taGVOWY2EdL3mJ1mzQV?=
 =?us-ascii?Q?PfyTWjVSebkVIgo96fhKYu+Wj9+W4XsDjfy3Mc0bKv8P0bLA4jyVWFIlE85k?=
 =?us-ascii?Q?DNXjZIgqJq4rL7O6lU9FZ68cjbb17iWYQYFQvvz41TBkcJyhoIW5LtCYOSdg?=
 =?us-ascii?Q?Pp5elpHPWG13FTUFeoqI0SMM6ZMP7JYPBtBNMoTMb7+Wrk0T83oogZNl6deG?=
 =?us-ascii?Q?Ps619JqjQugqukYVlKk23h3nAsqxdWbK37GRfWuDnJNyAMgSoCviu08zT8Qj?=
 =?us-ascii?Q?2+NiR6VI/Cwf9+nGE7OYGKmo6O5FRXtZV7WnmX6D/CnO1ggz2GeQSliND0zu?=
 =?us-ascii?Q?4jy3MPUhPj8D7pGNgrg7iO9jLyoclHZHg/wIINUz1RaeU2mGo3t1LmV0hBTS?=
 =?us-ascii?Q?hXkJRNRfA3Ac9Jth21/oGYk4lt+zJOpkpQy2lyufrG+VxqaoMC0l9VapbXOX?=
 =?us-ascii?Q?c6smeA1sqlpApq8RmPrwQB2adkRAhfTOC/gID4GvfDWZc30Tva0JbjIvbAvM?=
 =?us-ascii?Q?gnELj/5yiyekRggKH4vFQLOO9TWc/ubDa8LiXMsKBHFdKvOrlbTZUpqGzjlN?=
 =?us-ascii?Q?17DBZjMUYjRh4FYHlxHzGe7YunQm2hXZi0vPIyklSQbDlWimdMbU6xZR7+Um?=
 =?us-ascii?Q?geTS+qZVUsPfTltywWozOOEsabnWAslc1FZeZV01p2h117Tiu1uowxoEDmhK?=
 =?us-ascii?Q?ZHhYIxpV0Gq1l36/SaGG5+ryzFc56IkC2+vr+IxcJkdxpXdzoDRMYGHwDhXy?=
 =?us-ascii?Q?o1wU8rDYB+N2kBJPMCFiV4pRq7JO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:30:18.9999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fba5e9d-2d3f-4640-bfae-08dc62e11e05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291
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

From: Gabe Teeger <gabe.teeger@amd.com>

New request from KMD/VBIOS in order to support new UMA carveout
model. This fixes a null dereference from accessing
Ctx->dc_bios->integrated_info while it was NULL.

DAL parses through the BIOS and extracts the necessary
integrated_info but was missing a case for the new BIOS
version 2.3.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index bafd3801de34..4d7006fdf345 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -3029,6 +3029,7 @@ static enum bp_result construct_integrated_info(
 				result = get_integrated_info_v2_1(bp, info);
 				break;
 			case 2:
+			case 3:
 				result = get_integrated_info_v2_2(bp, info);
 				break;
 			default:
-- 
2.44.0

