Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41143CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B34E810E847;
	Wed, 10 Sep 2025 05:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MPxtLUf5";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5572A10E847
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoaoQOcs2swHMBFAXnCW17wMrfvqQB0FWTvU1XjBI8ykRANXgYPrbWfhU+KKdAO+wP+cUNteJU6Xb3o3A/5Ib0RBLJoL9okLk6dSUBkyXRRGpj+95dBCTa/0Q9KVK3lMV4ORLgtoIjXZmU5UFgM8Zc0lTUrtblQoNnIdKVefhgKl4jutLkkHjBOCtU3BSxpGhQmO5yRxAlujMDZKwr6e4EAp5gTK9Y1Y73uGGRNdMyYmaXipq73KzU7Rw43HfSSbF1ngkOdv1WMV8wEc6LuRTKyYwUqCSQU5cr9QJ+DEY2DuyKiKrhGUZ0L86JnlEpb7xDss62aAvdqfswsAM3m2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HX2lzheraoOGwccS4AltJp50dUuWxR56J78j5ky/2E0=;
 b=Qzl4sbdVipPPOSNUXnTVpKRY/8AH/LK2uGHyy4CrfwK2PA25TcXzp0253Gr6DG5P0TE+Z54FmaiD1YllPTYxPwImNqwiliWH02jXY4p3a+DtaGFkMn7PXOw5a/G/dccEBn5E0MMjj8QYex1mU/mWtoARkNDZYQiThEydkT1w2x1jlRlCxs7O2SiHOuELZ3MkoKHdziG3So4K10rP9E/qRx4ZrH/88ZMsk3jbA55r7cEdQrGeSZ8DWMXP3sPvMNrEpREBi/F7PwBJTPYKLLF/PZgYhSM6wolHIqCdLeNHdHYsrdcz3oSUwyH3XC48P42eaByf0ZuVUD52914yd1C+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HX2lzheraoOGwccS4AltJp50dUuWxR56J78j5ky/2E0=;
 b=MPxtLUf5WGQZ1o6EICOAqQmWlyc5RPaXmZ0m2mOn6nFQ9fhz+fBGPrfRPVOayCL/8qbUohbV90xD2n5N7+1WXETswwbMNQkaeN2LyDKdWOVHKJjwo08+US4Lq/AVWUl0mEuORAZbPXRnTI0MLDLY40GQ7EL6Ptihkwl+1HrCfTk=
Received: from BL1PR13CA0379.namprd13.prod.outlook.com (2603:10b6:208:2c0::24)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:27:49 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::6f) by BL1PR13CA0379.outlook.office365.com
 (2603:10b6:208:2c0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:27:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:27:47 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:27:46 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:27:38 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 15/15] drm/amd/display: Promote DC to 3.2.350
Date: Wed, 10 Sep 2025 13:22:17 +0800
Message-ID: <20250910052620.2884581-16-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e51969e-444e-4d0a-7941-08ddf02ac7ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CLaNhXRjcMq0ee9G+5ruBc0raDtkcIt5AktSMO6QfJt4+ShcX/GRg4MbnL8A?=
 =?us-ascii?Q?UhC95oPur29PG41Br3xUxIA8hnfLP2x5xxOC04TECWPSrazteckNdUsyJWJs?=
 =?us-ascii?Q?kLFwTo3cOTiOuVxKZ9aYXboc/m2Q+RHHQ4CRkA/Tm6kii099rUYoqIQo0e1Q?=
 =?us-ascii?Q?ujGrDpKcDmlb3GGrzcBCBdqaOaf7RXja74XxtgeSaW8fPEQt05ugTvRdnkn1?=
 =?us-ascii?Q?gUEsipCftIl/+zFBptauZXILHdFmqr/JyUMYv6QyHM4H9wmXfoPMUTwktWzp?=
 =?us-ascii?Q?m5d+NV+GYyFmvp9kS61kUXrfYcKgos5GjQq7zqc8HxuxA7BZbXpqLLkKTOHl?=
 =?us-ascii?Q?mTxyVLxVDSrDwgn5b4AHYYd+fW4ztcXw33xltCev11E5OPdPUpstZjst8M8l?=
 =?us-ascii?Q?OQeooQ1UEMS6iVQjRs9DbMJ0VV+d0HmipAYjx4a7rk+rDuHE4H+itfwMbqtZ?=
 =?us-ascii?Q?JvUG/FOv3/gz+kKZFZ5CNGFVt3iAITu5ElYrYWb0rkiOv0TcPDWYMFgp1rs0?=
 =?us-ascii?Q?xQdYNT9WOEcO48vGdlGkkoT6EWNTn24W6Y1UKHfkOsSUc5ZznlDqenfwk8cD?=
 =?us-ascii?Q?qQMUCUhPzmr0tcgd80WcaVc0HwAUlnpbLRJ8+XyNhWsCah6BbJSzJw4Vwtm+?=
 =?us-ascii?Q?qjBiFlav0ijlqnDRyu3z5g4RMsthVaLSFyKCOfflOd3NA/TfNXYKgSqkSAF+?=
 =?us-ascii?Q?/892sG4RFp5zzRXjE15Tjxc9BaL81TZF/OA01JHc4lQBlJkAqA9yfwrPiWGY?=
 =?us-ascii?Q?6uQP+lFK4Qx5dmwDqKRPHJ0wZwTWLVgpJYHq6va7qOcEO0XQGXsp4IzFRa1D?=
 =?us-ascii?Q?24tiJAseSZmrkKLK1fofyZbeDy90wsR0Us3ddnZcl7y0LXg3C18UgQkdC0fX?=
 =?us-ascii?Q?+FHwUA1BEmfSA43oK/g71AXTlN0SCCEtWyWWk6bivOlyP4AeKXKZMOss994m?=
 =?us-ascii?Q?6UXrX2Way/lqthk7suGxhS3ammwGns/AAS88su5H4dsFpApP2qqC5YzUnHVx?=
 =?us-ascii?Q?gdQcrVWO4jOg4VSO0S6bZi6QPOQxjrFFSXMoG8YSFPwj5nAzgcV7dcq6cjNi?=
 =?us-ascii?Q?iVYkRWuPQhkKKOkANWPUONkt7awkXK5ZkK4qLWMpU8RuIuWEGuoU44sw5CTs?=
 =?us-ascii?Q?j+8vXY2OGZh7AJFuNO8m4efFa/3ahZIVJl1t7Ist6iRVWThnSIrL9g/Qo4bp?=
 =?us-ascii?Q?uM/7JOQCaizHg1W6G5D35I057fSNpNLpWJGEYM+AL4FqbJX0F2h0pktHPysb?=
 =?us-ascii?Q?ogfnOZ2N5guV6pG/hwgBth0V/v1me1SBqSKmcXY+tyNzHkpP4DCOBC1OXuFh?=
 =?us-ascii?Q?8d10DjEqBXw8xCFLeWdMu178tX8C0TeGBtj+5g83nQxVlnOqk7B5C/BSZNha?=
 =?us-ascii?Q?8Ily1v7B4DsfZY32Wyylv1zSrgqqEqZJfqVuHTP4WUdl6xFcaX6BnR7i5cuD?=
 =?us-ascii?Q?QPokE68iWiWEVJTbmXDlCuGEPBq8f5IKX8HWsv/tyez5YZbjvfWQa2WXOHIJ?=
 =?us-ascii?Q?Niy1Qf6KPCs8odoTH//khVyhwaU7Ai1WYGA0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:27:48.7540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e51969e-444e-4d0a-7941-08ddf02ac7ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
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

This version brings along following updates:
- Add DSC padding for OVT support
- Setup pixel encoding for YCBCR422
- Fix dml ms order
- Rename header file link.h to link_service.h
- Fix DMUB loading sequence
- Modify link training policy

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fec056d43535..19c74f56aa5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.349"
+#define DC_VER "3.2.350"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

