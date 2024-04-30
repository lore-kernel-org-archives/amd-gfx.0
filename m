Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33025C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 18:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2CFF112E68;
	Tue, 30 Apr 2024 18:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mzYJdXUG";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD19C112E68
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 18:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNf+4/SiJzbTKG1REZsXi2Z4JyT80SQeGKUwr7FiPHPcMnJgohr1Zj9MJHTk0bi5Bh1EWvQMJ97jbKlWfJACucY2xUCwNrVNnpIs2ysN/GfQXfaeG7ilqWt+14EDKhR/gSiRWJeGiJcsFLQQ+01iQvC2xXYGNf2E0DyjgW5SxhGap5+jAqTE6uDzJQco2m4pkOyuAubmsqdEFZRZhVS/uLu0ZbDSm5K44E1aQ+cC62EAGANLICiulfTmfKXqJUA2fmhit/jZGAQ8luKMOm3GYD3/dsMNvvXPPwfq/xpWxcTo1ud+j4d0C7p3XtnHjTqwadcEGa9iI073gFaryfku9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAK5EgbUp9tpoSWrGxeI0CvSm8huAYuymGMEn8PHNp0=;
 b=C2qvKjm9UsbPwIHVhzxTMvNfAKMUkv7p9ydTgqHAV6NyTQs14KDGuMt9kuG2R6Xr9c07J3LCaabEEbpHqDEf+A+YaATVyEf7YvCEgirAyYovg1pDlqvsOqHnmceXM5uPHppIeEkEBFXRiQiYs43FH+ldOOjVPHUUBdmpOiBTaR2MFMZx/oajF2YvsgGWoAtKK3zudl4uxOsTgXNRF8TGOC/yEuz/1weZS1KNgswGCGOFE+0TN11fh7Jt4oKwWsN3asp6RC1BiD+YShmwo1lCjXfwo4gqLzW/87T1GnUlCBVE0VZtDL0H0x7hgnvzywCzzGhr14ylYJLji0tTj3JCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAK5EgbUp9tpoSWrGxeI0CvSm8huAYuymGMEn8PHNp0=;
 b=mzYJdXUGLT0eg0Et3/NMPpyZIKpjEg5pDuExs2/24B0ulbL3ZOaVwvaO6/NWe+bGJ+R10dkNSx5tNYqtTLyKW6iHI3rgQzoOWfjf2Q+0nDwgqvecof4wV1JusmEwa3DQRX3wT2GM5gnpc2YWYTavMHbd2e7gLP3VwoBny907EQ0=
Received: from PH8PR22CA0024.namprd22.prod.outlook.com (2603:10b6:510:2d1::15)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 18:58:33 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:2d1:cafe::7c) by PH8PR22CA0024.outlook.office365.com
 (2603:10b6:510:2d1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Tue, 30 Apr 2024 18:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 18:58:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 13:58:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/jpeg5: enable power gating
Date: Tue, 30 Apr 2024 14:58:09 -0400
Message-ID: <20240430185810.750572-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430185810.750572-1-alexander.deucher@amd.com>
References: <20240430185810.750572-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb90ff4-7b39-4a1b-9020-08dc69478862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qO7ZB4dTFs9w3+BqjSVcSY0tIVFAL6uJv3+rR0AdAgfBp1B5M0/RQv5mkUs0?=
 =?us-ascii?Q?rvyj8E2IhUHL8Z0xxC8fTeHsnpnDWCRLKSIJ865Cd3hwB9ZeOOab31i28DvF?=
 =?us-ascii?Q?vrI4KLNSV5coy1UCnjy9/oZQu90JMq8vrqg4ovH8URoUOCMbaIiYKPgJQMmi?=
 =?us-ascii?Q?p0bDgUG8ChjO8APEf738/u9hiQo0Mpnmn5RyKexkTlp+ghu/ft7jdyaBWE6v?=
 =?us-ascii?Q?j+SuedB7O+/FgpFTMXze185ll9nZRy8unqYy+HdZEisi8T1LXlZQmBtZD2rT?=
 =?us-ascii?Q?moWuE6VBkLCL+RU3DQPKTmJurCLeQT0S/Wb4Y7JruANE5o7Rx54Ms1Syj6ih?=
 =?us-ascii?Q?dIwXB0qTmFaVy+kGZrSjX9iDbqtIpHiT0y4/jB9FEz6OVMPINZ/TQPMqzMRo?=
 =?us-ascii?Q?L1EJHY3I2nmlYQzogGFkXi1tPh6dmoBGAyLhezp7ZvAkARjcXJ1iOUVyPuYy?=
 =?us-ascii?Q?BoHnwNU8jsAxRgeNM3NvY8GPkyDP9rylMsuZ+f2U9o7NQ4RENI0WfybJIV8b?=
 =?us-ascii?Q?6fno9jz2En8HkKvbCbZuI8e4+e8FdywlRY3rlZdaWRaGt2+iCT5DqmwaTZr2?=
 =?us-ascii?Q?q6NlgzP42pQxOxX0EZVZ/eiU4QuDD2HXgvE+sKZbCVis/clwOaCmRiLmbsc5?=
 =?us-ascii?Q?gUH/OBVprnQ349Y5ykmZ9T5A61xE5InmY2Ol4bmRbPUOtwRXlEDkEinrMbRo?=
 =?us-ascii?Q?RaLJGwDyFhdnc5DzmkYg03hSItlIlxpO2AIQbnBVRSg+trVaccQjC3mmXQQN?=
 =?us-ascii?Q?U3IF9NwzKZ5ZNsi4N80wY6vAFFqkpbdNw5ROkFyKKfbFLTSatepXVHM7N3CT?=
 =?us-ascii?Q?4B4D1ibX5uRmbFlWPUlzwMZl8LBFFSopoIwvonOmfcRoR7eqCpZHZJo+wpeu?=
 =?us-ascii?Q?127zwJSbYGKY1H3TvVA5P/nDsczqwamgz3NwtfNV0w+AiMZpsBHHw21eVGTU?=
 =?us-ascii?Q?sXNil9rTib3terEXyvEgx1xBaHK3X/ePRs371AzGjpxlum6k7AjsSTHnOJqw?=
 =?us-ascii?Q?CLkSqWIEzC+RIp4PFNuEI+3Xb2dVtT7sum8149D7hcYWb3UzvbLb0z8dsFrJ?=
 =?us-ascii?Q?iSyZibrMHjn69lHG47LE/4yOZGLEKpLdgtUj9SwRfHHUIknWXODmTo9Mbjfq?=
 =?us-ascii?Q?GRaXfT3uJObg+dT4QzBu1UcRgHqM08vn5AfHbT1uRmsguiagwuoySfRkW0Ed?=
 =?us-ascii?Q?W6ScbLVATdIYtQ4O5ZImISAOCjolpYAGuMwSDWl2LB2Fv6evFr2cnKY4jHX/?=
 =?us-ascii?Q?UWYPA50ejtphHfJHARxMBDg4RzOjI51jJpDYO751B4C/zHwQPjPG0joDAVWX?=
 =?us-ascii?Q?6ZfUuSmLw6NdT23u7EgF1Rrdivc3G0DcoT7SkCHed3SNZQYavxvgSp5sLMuh?=
 =?us-ascii?Q?xKu0GdFl7xeRLVGnWRGatDhOaabj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 18:58:33.0116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb90ff4-7b39-4a1b-9020-08dc69478862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
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

From: Sonny Jiang <sonny.jiang@amd.com>

Enable PG on JPEG5

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index c8cb255b6cf68..9c14f81c88a7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -359,7 +359,8 @@ static int soc24_common_early_init(void *handle)
 		break;
 	case IP_VERSION(12, 0, 1):
 		adev->cg_flags = 0;
-		adev->pg_flags = AMD_PG_SUPPORT_VCN;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x50;
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
 				AMD_CG_SUPPORT_GFX_CGLS;
-- 
2.44.0

