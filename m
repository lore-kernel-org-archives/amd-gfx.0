Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BE5CAC58D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B253A10E84B;
	Wed, 10 Sep 2025 05:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AvZrsspl";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EF8F10E84A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:27:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agowYoXII2WapUDF3cEpDCnVPf8a/95dvrAvBFyoOC9gFT3x5oGyPrt42b3McPnkPD5qHaFu0w22EKi0+FvZV+61pkCuyPGtSA2s7mHxRxt3EEncTtFlxPnqtHUDiinmkFAehAMMvV3YnysO2Wmkd+Aipokatt5wo03ss6T4gPfIQUL9FTHcP4UDsT3QiAHF4zFqxyoYB7vM0pqdt3HmqTadK25f/8Ob86f2y3FzrbWeLbkL7Hg5SsRB3ojoJ4IINXgRGCe0etXUOF3Atp6ZpJjdhDsT+wALDRKcYSfYoNezMbxGQkxOK8R1XtPlJ4/ZVrxbkH6cHKmhdG1xgnzHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ89d6Wt7cDiA7TjmLfwSt0w8COqzr3V5gUAmiaSL68=;
 b=wWU1H7ITZJGe8Cr+NrNNfJBcQkX1zyL3E32Gk4shgy/Elu2fWhNovBUUePfnQOGuIE8UoJN+UIb0rWS7Nt8Qh+2Hr3ouyEbSmejzAOevwCfYEPhnKrJc4fMrUBsXG8h0CftVUHLvW9WmjC8c6Jax6x1GkOn/5VGJCKJ38yNKjjanS6KzqfCuLe4I0NDY4auYNmC8WD9IX+Ytsh0zGRC0JpC+fYXmDiGbCCwtbO4KOZbInlsYH3T9yDOoe/Iw439qHtCZHP06BBgoDSYHG7+tevS2v2qJ5PRibJmyL9Hltoezg7rnzNE98jz0fWCESd3qDd3W+g6isF7OIqsVwarnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ89d6Wt7cDiA7TjmLfwSt0w8COqzr3V5gUAmiaSL68=;
 b=AvZrssplQ6PLDtWm8Heh+dLClgKGrzblOFcKdUA8pCuL281l3hPs6xz88jBwjH9Ge00KQqWi02QYJAmb4aDzsSLBglEklxohdROYDUcQ4oFojWUaYZzIWqldvYdY/YYOIrrbuz/BlpogNKV4Nva4H7Jrn/dKS3wqGWXen/pD+pw=
Received: from BL1P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::30)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:27:30 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::35) by BL1P222CA0025.outlook.office365.com
 (2603:10b6:208:2c7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:27:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:27:22 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:27:22 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:27:19 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Mario
 Limonciello" <Mario.Limonciello@amd.com>, Mauri Carvalho
 <mcarvalho3@lenovo.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 11/15] drm/amd/display: Set up pixel encoding for YCBCR422
Date: Wed, 10 Sep 2025 13:22:13 +0800
Message-ID: <20250910052620.2884581-12-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8ee510-8dc8-4339-cc13-08ddf02abd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JqoH/p10ghb7AKV8t+VGDLJO/qfJze/jwc+AOl+sFNhVPfxhmHb5ZHsS3abG?=
 =?us-ascii?Q?opOkdo7PyfrHZ3ViKYSVZmEL+gXJS51cUfftAuJe0iokYfrdupAIfLChSC2W?=
 =?us-ascii?Q?Dg6sTW3KlkhZexN3Lr+IjhQsnonguQNTBdLMrrKMhKBrdPdBomRsInCPIvN1?=
 =?us-ascii?Q?aeL36mQJ9UDLR+D/alxBxEv0M4nOqfa11O/+qFVR4+d6xlQ+6lwPzZu5wKYW?=
 =?us-ascii?Q?+r4Xva2SGRVGNYTN0jj4d2nvtcS2HXMVV0/EPZWbZeS8zC2LvdUIFYhX0mzM?=
 =?us-ascii?Q?a1R7TUSiTowOaIDe25yJVKAtT3clXPnk3WaHyyGzqYD5NFNafXYkh5P2aysI?=
 =?us-ascii?Q?bq5Vo5S8kioSb3NypzefM141JStSIu1M4ApraCZhYbuHcm+nA0IcYyivz3kg?=
 =?us-ascii?Q?VeH+tQ+YKl/ygIWssksOZouaKwUWLLenRpn9uFbF0kWSf6Ux82djyJNjXQ4n?=
 =?us-ascii?Q?uNJBDWnmN4qgHnC6+NuVauKW0RFkI1/58Fr/J482HV+hxS2omvGicdwlAvtN?=
 =?us-ascii?Q?J6VJlzNYENOLfbc377LrhhL6ioNCOOlz+2b7nzvwRjJ97HnVWL83FU7buK5H?=
 =?us-ascii?Q?979izXEl2pBm2MTz5iZbxEwByePfnglsA8MIMKTD+1flLfAYpSrvTO6XPEo9?=
 =?us-ascii?Q?0O9dqIKRGVsolURIqqqMTDOGFgqv7DrZjfdj2Znqk0ayU0w7eed4CO7X3s8v?=
 =?us-ascii?Q?vpHj7HznH4iyTomZ9H03zqEUrEroU1Os5HAxqbu1FTz4revGkMVfVRKTx0AO?=
 =?us-ascii?Q?r0w/vnzRcpBbRRz4aWKNA/Vi6P8Y08v88eI/icWmCHfsDmTMniW3AM2r3E+K?=
 =?us-ascii?Q?QtIYfFfJnY438Oa9l6ba73B5idgxYW4RD4IbIdwXpeb1+LEFQC6+4QvftC33?=
 =?us-ascii?Q?NRwp/uwL05u3tLd4rLtAf1Gt3glgGZsNWBPGr8VA7WPpc5hLcQP7jR1Zo//N?=
 =?us-ascii?Q?lvoa7Dz2nadGk0wcJP5KJswGx3Ctu/HUdUUWELYbG03I5rkw9KTEIg3+5Uoe?=
 =?us-ascii?Q?AZAUu/js9NaO0JpyFeIVlW+nj2ohKwjs9eZvVXZB7NdagwM8bq6duUqeHkO2?=
 =?us-ascii?Q?ccEamZpW1jbYKYLjsuNn7K9YELWvV9xRHKnBJf6xjH8lODIXtEpgS0IjsKTc?=
 =?us-ascii?Q?wkY3kUx/bJrJ4l9mpaYDihOwUsY1LKBas8gEXNvUi2DoKHLAIVFbZN6bIgNU?=
 =?us-ascii?Q?2skj0VcKmxOAItqMuKlKVPpFJrFSOwMl6J9AycDVETnzLUdOjxqynPlrFOkV?=
 =?us-ascii?Q?37RQmAJUcuYqKpZE+xLdkL2yktrjMONeov4tIW12Iod+NjsOYBsgstsXJsst?=
 =?us-ascii?Q?TCX+P6gXaHY+bAhFrJcbGdrJPOU4WvfVEPFt/g/KfbJ3/nkBnM1q3/Yh5Slf?=
 =?us-ascii?Q?fxtaTLULLfu7VJ/rbzIl4oY5rM10czZ19jgxnDEynnK7X7wBVByXShs3h1Qy?=
 =?us-ascii?Q?qJ8bW3T+TNs56DEDKxm0Z3qKb1y46C83ygFYpt+q/G2NjVzC5RybLbE8FBjv?=
 =?us-ascii?Q?3czbjHVpLs55rG/gye2Y5xwuWTiaoLAn1g6h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:27:30.6694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8ee510-8dc8-4339-cc13-08ddf02abd06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449
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

From: Mario Limonciello <Mario.Limonciello@amd.com>

[Why]
fill_stream_properties_from_drm_display_mode() will not configure pixel
encoding to YCBCR422 when the DRM color format supports YCBCR422 but not
YCBCR420 or YCBCR4444.  Instead it will fallback to RGB.

[How]
Add support for YCBCR422 in pixel encoding mapping.

Suggested-by: Mauri Carvalho <mcarvalho3@lenovo.com>
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 849c45d10ad6..1f9c56c288b2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6405,6 +6405,9 @@ static void fill_stream_properties_from_drm_display_mode(
 			&& aconnector
 			&& aconnector->force_yuv420_output)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
+	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR422)
+			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR422;
 	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
 			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
-- 
2.43.0

