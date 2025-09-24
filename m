Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447ABCAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 18:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C6C10E7BA;
	Wed, 24 Sep 2025 18:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RREEqU64";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C7710E7BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 18:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYbeel0jov3fQX41yl3YqWTcbyfXybJYGso274zOraG5UheVAhNomL7atW36LtdhIUvRt+wRxr5lHu/DGVmS2mMX1J1AYD6qI394vm4HVfzWQyDVHuj3onljwERYXmSEX5uzoF9SrTs5Aq0fdt29v3nxe3mQ/giBGJRGe+yw8uAZaMIaj0VKMuL0dWjMl67k72iXi5HXsftspsKWEIdyO7hx/2dHwW+8smtJKgJ7fr5Is9K3P4c9MF64Rg+PsbzoWsDqHmmwy4cSBWBIOClC1dO/aMW6RSsjXwPdNBVG3pKoZoQoPEdhm3Wif6+M6eVov2iRABCnH8GFYjfQ335Lzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDRSDlBkWEec0o+AUn/qvYs0tqlKmJn9ZvrQ56UyWtQ=;
 b=PZQ5DqERKRF9qUOIgOk9FDo2QOSIWxXPu5JheI9hYQGTHbW+/AcfX6mA3JoEzgqvX9y9BhTSbgUjF1db/1AXMTfLI79oeVkJ+E5PeMXenIvLs/irFerGzkCgcBYQB1LSowvYxkzsVeyPGs2R6U7Uia+FzV+Df2qp3aEGr4dYNePKVAAFm5jZxvJxzwiHjIHOLYuBsVFOPd7gt0apowgpNcDkrEoFO3bwbio3bGOvXFXB8LJ0bGAucQdDQ7+z5p/DCFUEiO/zd7cwN7ehY3se7i+feUHXokEEaA/QBiXmDZZ3imvPreCBwegYs7A9EaNjCJiy2UIGMyzB0tjOtpwUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDRSDlBkWEec0o+AUn/qvYs0tqlKmJn9ZvrQ56UyWtQ=;
 b=RREEqU64SDyfO6Ja0WxeXVD7PqTxrMg272KKV2A6w2KdAbhV26Je+7BUWrz3oxanYJ/HkguyF/2lJW3ehB9mjGUYbNtn2FKxC+xd05wNl4ChUFqXG7ONddZTLCREby58mkAseW39X2vDmzx9fr9aRIx+1nRMfmYC0i3dwVTRqw8=
Received: from CH0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:610:b1::24)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 18:22:58 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::b2) by CH0PR13CA0019.outlook.office365.com
 (2603:10b6:610:b1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 18:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 18:22:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 11:22:31 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 11:22:31 -0700
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 10/10] drm/amd/display: Promote DC to 3.2.352
Date: Wed, 24 Sep 2025 14:22:01 -0400
Message-ID: <20250924182201.1049389-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924182201.1049389-1-Roman.Li@amd.com>
References: <20250924182201.1049389-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e357e7-40d3-4c6a-1a7b-08ddfb9763ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?coU6gPgXFXDcD43kxBUwHp1qDxxlvLeXz6Lcl1BqKx+FPWvx7HQZ21qOFKly?=
 =?us-ascii?Q?Y7iWxNxRxfkQ00Zh9C00p3mRtmiZieOxpRPR4MHPudODt8kz1olsHwkzXoa/?=
 =?us-ascii?Q?PaUB9Tj/sPXqOsQMKCZFwF/SatX2tkO/VfizbCxKLz454YtTK3uLK3xbmNae?=
 =?us-ascii?Q?HNNvtPCNT+Rc/qVsFUEiwmMTGHVhqzoLxgdiGWKs/Vn/n/OHta96LCh1rdHN?=
 =?us-ascii?Q?2Yngs+imn6pgNvixVSib4Lllb1SSWMd3WWFogocz2qKn6yaSvh3kRFJV5PYs?=
 =?us-ascii?Q?h6z/wymr0fXtWfoh3oYbaEFTBlAVKwloQ88vlyuBUecYM2Mhy6Ls1BXnav18?=
 =?us-ascii?Q?MnTiPrExkpmEuVG/yqpg0t9RRzQZMTgMay9Sr+NqvbE8r7UX2k7KvjJbWYeb?=
 =?us-ascii?Q?egt8JPeuYL/J8tfmcy4vJLKYJ16RoNwTr6aqohxGV3+Um55XIQJo/BiU+MDu?=
 =?us-ascii?Q?e0yfYDVXz+PslqdFQphNP/siw7sv3k/dvrpX2mYs7R3Mcs9Ve7VL27iIKKkF?=
 =?us-ascii?Q?D1xfG/zFFdzMIRAJJ2qKu3TRt8d7K0iCLfAq68rO2j+L24WNIp8TH4uXICvZ?=
 =?us-ascii?Q?4mhEn+ey4Lex3GIrqwYbg9Yb+J5heNK9unE0YQirU+iaodO8nMEk8DWzczc2?=
 =?us-ascii?Q?nPTilVGEPniMk9kBB5aCbyPDb8un8/ilYolv9vLcHpV2jQYqwJeS3rxhElEX?=
 =?us-ascii?Q?8FmfNTW6d9402jgnafjJGazSIkX8ZhSeCXM516dQ33+/7+um8NDRREunqinH?=
 =?us-ascii?Q?RHB3+JQdpWw6t+/aPObBn4Pw2VVdWqJbhoPLyIcKzgwTubs3lo5JAN4TBra/?=
 =?us-ascii?Q?EbfCTvYUFBOOqBLRf4ds0qmRiHtAUPdmevPM28pKYorpE29m85xc1Jbr3Ici?=
 =?us-ascii?Q?sd50t1S3rzyncrumOKgAdADV6xnK1Gf45IJsuOVwp+2QRLMJH8DCHj/t7Tx9?=
 =?us-ascii?Q?IgSIMTKH4RNDcSCWeCy9PbLFvbstJwztoct/4cuA35ymcqFBsHMbEYkvOYs3?=
 =?us-ascii?Q?Lu6Lr/esX0sq+FcWKXQd/Ntpu6WYikgpu8oWu4Y2yyKynnj8vMBmjwTVtKov?=
 =?us-ascii?Q?u/L4eyB9tOsB/O0ha5HPWupFxGC5/KsNFTxEjefmpa5EUe3TvkIt6QVT7+S+?=
 =?us-ascii?Q?b8GhcaCXl+fGmkjBNPRkb6d0wGIJEBYw4rI2obU+gii6FM8TJvZTyr4UJezd?=
 =?us-ascii?Q?xf+s6PyH4k6yKvo7qcvmPTrf01yifqMMibKix4OLOgzzD0ISRz8t59c5VvX4?=
 =?us-ascii?Q?YTA4CD3jKVlJtfzQD6S7SNVg0R/ZgQZadM1U/sgvC+X7gwIeD0L2ZEWcrIAd?=
 =?us-ascii?Q?m+BXZWPgZsN/AKt6eu9Sj2oJrnghbmVROI3IYmbQQ4k2AYcLTK00nFgLQPbB?=
 =?us-ascii?Q?FZZYVO63t5yCcIebCqvms9CjWKSwp1H7NKr8sTaKTKw7Y6p5+40n3TI7FSLj?=
 =?us-ascii?Q?V1hgUsfKNwPC3Z02uRGV6crkI2N87RBHHUbWo7/wwEk3adRefZoCq/zjKakm?=
 =?us-ascii?Q?ZdF7uusyGWq70sieOcsa6lCd7HB3tDbxvg2p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:22:58.6600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e357e7-40d3-4c6a-1a7b-08ddfb9763ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
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

From: Taimur Hassan <Syed.Hassan@amd.com>

- Fix slice width calculation for YCbCr420
- Fix DTBCLK gating
- Use NRD cap as lttpr cap
- Consolidate DML2 FP guards
- DML2.1 Update
- Firmware Release 0.1.29.0 changes

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1617c7a13916..b429ef5831bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.351"
+#define DC_VER "3.2.352"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.34.1

