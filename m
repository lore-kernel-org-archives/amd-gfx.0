Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0961D5CCB3
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 372A210E7AD;
	Tue, 16 Dec 2025 09:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LWrt4ncW";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012032.outbound.protection.outlook.com
 [40.93.195.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96AD810E6BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOGnui/u1BJujtEb4hfvliexNzIMvjeYiabKD1W8TVZmMrhfpKBHbAN8Or86XVOHh6fX9TzDsPoSmE4yeFWLJcApI0V5QHGEmDb7xy+vVZZMFMyziXKJYEgIwijSm8JL+XBxwH0D3qhnVD9ec+G6rbQzXnt8D1akn5iX3WcGTLz5zWbmgNG4gtcErs4eWOI4rSsmTkfiSsoyLSUEs5k94ZLwCXeJ7DJvpoL+cWsrhuXeZhY45E+/eiFJGyreB0CH0LXmqwaSrqJ+4IhqWg8DdKhzm6ZTdaOmPN7LMh40jYvvo/UHBiHzQepRDUdbxFYMMfUkZqK7KQdmFVtSmDS63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUckAXy8FS1UvHeasunDDmyxHPOSdoFYbJjs7SHAzm8=;
 b=pRfT1sbXY4M25DkFZBhZME2YpHd/V/h1Fl3tynwfeKEL2o3H5oecXAyaxVDDFSwelbvcNuOhEG8C8yMmOH4TyCZKSVPAYuV+UWdsxm/+07+Za2szwN78Qz6leHFp3iMA9s5jipJ2Fnz6KzFFnc8Q5JvjvttL95biMTmnLbBU7i/Uwk9xtdOtlXFj2cACSPimtPXacC7mEvwDDyCltZcaDtI7LTV57tnV21jR0zX4jFEIXfELU4b4VEWyhqvU17UleyIkGNq9SdHSj2cReX9l7tRGIBSWqarM8jjwjX5b9Mi3lHAcVovT7fgkBSVMLgrBjbS3wt+wbR3Wvk5a5H83Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUckAXy8FS1UvHeasunDDmyxHPOSdoFYbJjs7SHAzm8=;
 b=LWrt4ncW83TFR24oGW5jjCvm4QKq8LXCMPSLGyKw6inuIsGalIvl+TE7UZ4YSId5AhVyloLpH9HAZIHLpsU9cRi0fMriX6pck2pPDTy9KFsL3EL0tRhWVv3LrV+p/fhmfaOSvufC3P7BW04HmdQP9Th+SRcsapAFc++JvCCllBE=
Received: from CH0PR03CA0385.namprd03.prod.outlook.com (2603:10b6:610:119::20)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 09:58:06 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:119:cafe::7c) by CH0PR03CA0385.outlook.office365.com
 (2603:10b6:610:119::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 09:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Tue, 16 Dec 2025 09:58:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Dec
 2025 03:58:02 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Dec
 2025 03:58:02 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:57:59 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Clay King <clayking@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 09/16] drm/amd/display: Update timing source enums
Date: Tue, 16 Dec 2025 17:56:09 +0800
Message-ID: <20251216095723.39018-10-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb08a63-bb4f-4e95-ab9d-08de3c899bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xAvSofutlGFs+oL8AYAoXTbVX5y+SMF67A0iMlsYtXRxuLA/ZVpaQGTXoQc5?=
 =?us-ascii?Q?GJcRkzp6WlGwk3XhPjUu7My2/A68zACBmJN5jYhpuGS34HBs8l8Y23iBzLNw?=
 =?us-ascii?Q?GvVx18JA+k3pz4SHjv52HBWpgrroIDmMUes2jALuRxtF+MpUIgXvW3iOWKms?=
 =?us-ascii?Q?9O2sjX/KeSL713Cd9ZJoaTCfFiwE+sRaG7arXyHg/dcNaHVPb15gJ6Dd82ea?=
 =?us-ascii?Q?4ts4zWA1eizbbswisC4o26clWJWpJczLZz+jEICqbkBlgb3f2gKlp1gYstqp?=
 =?us-ascii?Q?RqglheJZC3oboVeDo6ZSMFjtGrEoW7N330CoKkcsE7A5vhRwhveQv7YjRa0w?=
 =?us-ascii?Q?msHE4mbCCKNbe5gg74WwcQfv1Wv0nItMigPC2t34Mrr9udBHG33cuTpFM/Aw?=
 =?us-ascii?Q?RNRWYH7V1S2WQnmfmBBogWvb1A/pMozaNyIO8n3brGsF8LoERi8LWvgxtDUD?=
 =?us-ascii?Q?cR5+N/KB3/HcSheFMAJ+KCELcjlrz/VZ9C+htIsBNhftx3yT8zWKMrqc+B2F?=
 =?us-ascii?Q?ay7hUTxGz4CWH+ko+G/xao+9rtlw9vTP88KoN25j9HAo6Gey9Ba5yBg8SvOG?=
 =?us-ascii?Q?H9GwtczN+P11nr5415Uo96A0D6eZFWVIF2lXXotm4YpSsrV94VfqWjdeiY3y?=
 =?us-ascii?Q?A4+UcSHfj4Fzenu+zzoRs4OZ4DmfKLIIzE3mfPZvRn9qSVxs+NBaABGry6n0?=
 =?us-ascii?Q?3KSucZrg1gdZVJ+hWT6GYa4fTWvBry1x8jE/V8eyLbDimY0YM764F4WYEhaZ?=
 =?us-ascii?Q?FRjEHiXlBYRYFsrG6pF/ooLyoS0DEV8SYnTvSa2n70fXgWdiqhGQGPSro97K?=
 =?us-ascii?Q?pwtc9xL0cenKYVnGXpPu15QZ1Emvh+2jafTYh7xsdRVq+lyZfVqwsJc3LdVm?=
 =?us-ascii?Q?4Uq40xeXT/2g9RYpuNXE4V+mdzjEnLw4xlDHEKeBGSLCRoGUYepV5qmYaymM?=
 =?us-ascii?Q?YNmprmPsDz5A9UrpK6K2Z62x4yJCIy+U+hkQqz7mqUeKoSELfYHZ08w/aX2e?=
 =?us-ascii?Q?5HnxJReGRTJQ41WzHCsNdx8OzDTFaOOpvJXBweDJ+RDwfUYqB/ZM/TRSV1yj?=
 =?us-ascii?Q?OXH1Ld9QWLoCa1zeuilRRN2zt/pACjD3q5Ft8exxeV4k3UK1OygOHMglhtQ7?=
 =?us-ascii?Q?RAleGQ+DXSwrF5SMkYBEc2cl0vend0+0YHDBU3w9/EYTjrXwCC0M0UGNeyv5?=
 =?us-ascii?Q?g7D0qBlzQP4+elgnwfyvpAO+tJAVrl9am2fbM3/G2vqAaN1xXuVUTCqUXdcS?=
 =?us-ascii?Q?Oc9bSMsohWXWxJ4AnwtuYg9m5TquWxsIi8YlNTDDDXWQhI3k2KViyt7hYUVw?=
 =?us-ascii?Q?nwvZgmqOf7he+RlGuBF1BHracNn4w/d0AKP57kelKB2WMRfhblrDaGQ6giBi?=
 =?us-ascii?Q?2d3kBcMEYmyyn/K4sTlLJrkwliGnMFPhhHuwsdzRVNi1wXUiZ8GKHFI2+TFH?=
 =?us-ascii?Q?aHiNeYbSMBVV2q4CgMcHEROMLLXeuP2Did5jjN+Enn2/1cFT3jGvdLSaNGCY?=
 =?us-ascii?Q?+z6wahRzdRDtOupx/0ffKAZJEAlLk07k9s6uqEWDypi0gypodXU/iluGz+HY?=
 =?us-ascii?Q?gaYLYHYxtCCSIyl2/4k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:58:05.8008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb08a63-bb4f-4e95-ab9d-08de3c899bfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
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

From: Clay King <clayking@amd.com>

Added missing enum for CEA VIC

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 455b22350ae8..3e924ee0811d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -275,6 +275,7 @@ enum dc_timing_source {
 	TIMING_SOURCE_CV,
 	TIMING_SOURCE_TV,
 	TIMING_SOURCE_HDMI_VIC,
+	TIMING_SOURCE_CEA_VIC,
 
 	/* implicitly specified by display device, still safe but less important*/
 	TIMING_SOURCE_DEFAULT,
-- 
2.43.0

