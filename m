Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4AEC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5966A10E442;
	Wed,  7 Aug 2024 07:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TIL7Ma3C";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB51B10E442
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3c+ZslZIDOoQoxtVL4UKJ+OQmx7cWhcYriFfwBheFa+ukk6NdcLM2JYFp9l7xvpS2/ukxRLMZnCtnLLOvmW669+XEChx8RDQxrjNeKc1hntzDC39xder6Qzfx3qUaa+FvOxVMBmFxranW1WZ4wx7PAsFS92wAUjjyQIYnE63QzdkXseycxNf6zdYZtx3vINmNI5ZEfqjP1HKbUgS0SGgMD6SAus/BNiQNPYCTGQpA8pQ3Y97MPy8sFTTQgWCYYrG9S/OROPM0LtSlkEo4LmJpZtwp7Ds40DAwu5xl91KwDQPQg9Sfys+zb65VCtoYtn2sXvO/8xtkNhjfA0C8zy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msOYqtQLNKN+Ta+k062WVKaOY5DCxeUJyYwUWRm13cU=;
 b=xk/zFfJrrUR+d24of+VdaJ3DyFp7aq585sMEnl6NJKeqasYxUdERsg0T1QXP7g7UZLHeBZGTgeAQPVUYMSbZ/WCsDrndIZayW4WHIOK32dKLUw+s+ktVOFSdXiKdde0rQDGcnQIFXF1So1yPraLmLr7A6pMrNGYpKvwzTk7z/n9B6wd1h3hjA1O4oQHAv7edzsDuiL3D2El1b5PqRXkid5EAwad41TO/5iQv+ssgqzbi9CJr+pfBSHGzyKx4Xp37f4ngsj6TohkhDesqGR+XFqIKJ2jzRQQ9ucjHz7ORbsxODYF3FN6vw1bfgT+VZ61p2nke2D+RTCKErID+DA4BpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msOYqtQLNKN+Ta+k062WVKaOY5DCxeUJyYwUWRm13cU=;
 b=TIL7Ma3CS2J6Ss363c5J9dtcvlkWB08YXKJt48K7mgwWj2xneDgqJ6tXv5NkAs4nN3U0v8jkVZpZQ9+H7r7i944RKqJ+c812+1nN3GiyCq9j30TFHe9EVdXcMJUWSKifEeFLd5vaPRmK4fgWZyXrsFgxi1pGevYUFNARG6v8z4E=
Received: from BN9PR03CA0481.namprd03.prod.outlook.com (2603:10b6:408:130::6)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 07:56:58 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::e4) by BN9PR03CA0481.outlook.office365.com
 (2603:10b6:408:130::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 07:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:56:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:57 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:56:54 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Robin Chen
 <robin.chen@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 12/24] drm/amd/display: Optimize vstartup position for AS-SDP
Date: Wed, 7 Aug 2024 15:55:34 +0800
Message-ID: <20240807075546.831208-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 43619eca-5e8d-487b-3261-08dcb6b68321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IMk/UnE1oTfOXA1THu0QWj7I2TRpEnqMYwJXDmzU3sB6hZ9fx4K3G2nzNV3l?=
 =?us-ascii?Q?HbVXjFzdjrEDmUGCIEW5aR/M28IGBA+HhOCKCpaubpLRqr8NhZEh1+/aLq/s?=
 =?us-ascii?Q?bT9RONK3PvBSpiKWg2EuNrElbqlLGoQHCq3ps8xvARHDOmWg3Mvsv0swqeiN?=
 =?us-ascii?Q?1IrPtWfNn4D2S5TJQOQMN4aH0i0xenyEwJaVOMW+OfUiXSKkgmf17ir7u7ik?=
 =?us-ascii?Q?GC+TZDYaTeqP8o9Qt8BRTSmH2SRpFjRto0qTLuSDlMA5Yc2cC0FVkAq2+8Bp?=
 =?us-ascii?Q?h6stMBWzIimGfaDbgAKv6go4p0CY1Pf//AePqs91h+pbhJ5+tHnVEIVopUR+?=
 =?us-ascii?Q?Zq1f9tPQM2LUQwhQaRQZgbcVqjiJra3IUCBArwu5zxOeajlzKlWa7oPQkJM1?=
 =?us-ascii?Q?COpdaCOwAkr8FPBP7+ZY3m+wDAFQZVctrtaSpx6SbVk6Wdxhq+3mE9IGNlFQ?=
 =?us-ascii?Q?1JS/1oEpc5+W+s6WHrNCVdLe70ODFv/hfT3FSWr1UQxgakfjdcBXz7SsPYv2?=
 =?us-ascii?Q?BKGgL2N868Ds24hekYV8GDGGCgoPybAwpyNxtPClgp8NrrAKh8/dqPQxXRq1?=
 =?us-ascii?Q?IS77Q1jOEHQLddWZ9V4zpuBHhRySraMkAXGZCSLZwSVnFzWpoglWps7vUHYa?=
 =?us-ascii?Q?guKMA6nQSMqcE8HUTWs+Zsg9cXyDeW2qRvfVeAX/lFCrnmbEEKzNNuVd4raa?=
 =?us-ascii?Q?56YDiRKwxtDTpq7x45EpLx80pQrbuy0vdmLA3KNp8iAMDi6HJTqOmC0MaecP?=
 =?us-ascii?Q?sPzxe6k4exhxRmOMA0DQWy+TJn820PnWyMZ4pjbqHnOKXQq8DiJVIYrZ7oBQ?=
 =?us-ascii?Q?OOqXMRV4T2WLjA9UXWMe3k/QERwBKt689Mo3u3AEQfArAa4GOqtRwhZNiiSV?=
 =?us-ascii?Q?wSosSN37Sp9ct+tp+nbA2tud9LcvGkLoamKWWNkeODSZui1KI9JEivDyaUSN?=
 =?us-ascii?Q?aT+D+ccKnN/eaGFqkEyc97NO4WPzc+ePBS/k/uyc6CQcZzRu2BaOg3VV834T?=
 =?us-ascii?Q?iE1CyU+FO/oaQgDGJ0T9CCrocNW/4r2tSxXDH7/FGZIw5FjJWnLPH5vBwgD2?=
 =?us-ascii?Q?9NMxV3369uB8tpTU2Ai/UjVFDjs579nZcyuWaPwa916e7YThHsqU8+jGPc1d?=
 =?us-ascii?Q?8D+FktsLQlTZL3i/1ps5S0kxCUBZQUxEjgjmmZD1r6+SZNn+sBfRBKmiK6wA?=
 =?us-ascii?Q?NNZHxBKZ2+mZBQEeIuqlx9VEys0lSmQDbu9q6oy0cpIqKXwPD1GduckMlnSY?=
 =?us-ascii?Q?/iOXRbDZugPIh4RbTSqBZWx8DoXNKKoO0Waowa6LGWdVipU8O+vqxh3cywyX?=
 =?us-ascii?Q?xiw1MdNdiyYuDl6vfmII1AhdqsdMBWXxZGFkH0p41URLHT4PwxxH/kkt7R0Z?=
 =?us-ascii?Q?wRqR69SB8pZvidE82rho7TatFD2MxSdJqK1Yx4TH0bKzLUlvXXOLtGA6Dwlz?=
 =?us-ascii?Q?suYtizksH1gIajjj8SN4JhB/oLPg1tsZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:56:57.9280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43619eca-5e8d-487b-3261-08dcb6b68321
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
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

From: Robin Chen <robin.chen@amd.com>

[Why]
In current design, the vstartup position is adjusted to
vblank start position when AS-SDP is enabled.
However when the vblank length is too big, it may over
vstartup boundary.

[How]
To adjust vstartup position to 1 line before vsync position.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index efe337ebf7c8..e9fea9c2162e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1132,7 +1132,8 @@ static void dcn20_adjust_freesync_v_startup(
 					patched_crtc_timing.v_addressable -
 					patched_crtc_timing.v_border_top;
 
-	newVstartup = asic_blank_end + (patched_crtc_timing.v_total - asic_blank_start);
+	/* The newVStartUp is 1 line before vsync point */
+	newVstartup = asic_blank_end + 1;
 
 	*vstartup_start = ((newVstartup > *vstartup_start) ? newVstartup : *vstartup_start);
 }
-- 
2.34.1

