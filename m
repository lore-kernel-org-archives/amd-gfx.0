Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A66C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 07:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 616DA10E17A;
	Wed, 31 Jul 2024 07:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fT43mU2w";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1E710E17A
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 07:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ues4j/hy5rcozIz3Wn2I7BkZxKjwdkJPuX+1GjNb0joFxyxEJtBMMkrDpiU4HlyZAeb8QeWvwIn1PgixNXmWGBKpp3fTjm7CJ5QP+nwLaYAymSFAicljs+cdPu+U1JhXaKbY4/UM9x2qeAMqI9qnq2RGfMp4CDQCx5ypuqknU/D/Yq3j4SuIq/rung7MS8a/Le2fg2NOhAN8ljAzXik825XyoKPEqmrZXYIH71bYLO1hv3pRjrDMX981RISNdVt2TGcKBXehMU4Zs4SSAsFCFBKXNDMaSyD8hygwW5IweD5A10pg+0SyHQXN0PeAMgVxcklIS12b+7QARlCEKfPXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tnj0nzGUEwyLCsczrHqQyym3YZM6Ynt89PLz2fSsTwk=;
 b=pwiAso/g2yrV+5bHCu6i4qlE1cKSu1sLyfoQYM8u+qbWrryQhAXqOO2jWaILTggwsUdj+bM1jmccEl8E0aCybfV79vXJpB6g5+IJwdXafy/OtaYdEtRtguTBbYoOXZxfsoz7CR84eVzJtBDYw4Vts4ZDLfn2hk4opYHEVJKa0ntD0YQRV2LcEQ3vKs8JF6e4G7L3t8/FWy/CNf9VS6Sm8631TRcB3ZvuZnaY2wyD9qkRrFbQhhW7rx1nLdh+Y2mZH8sol7vleP7nvXuya7VAeNUnUnZnpsOZOgsmzFgbOtIhLF2gRPOdpdtExbjiySX1yCSHENInkSafOdfeArg0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tnj0nzGUEwyLCsczrHqQyym3YZM6Ynt89PLz2fSsTwk=;
 b=fT43mU2w41KnNBqa5N/Dl9Ta0SQr5fIR9M6IPLFNiKr5mX6tHj0SkP94/aAACA2leceAohuiIkBPFPZiKdciIswqZnvgvnuCZR0gxaylQHt94vEGaIy2MPrju2uPkW76VexUVqiMQqrJ5fTZvNooEhJ7SkX6dEXX8zuz/JQ280g=
Received: from PH8PR21CA0019.namprd21.prod.outlook.com (2603:10b6:510:2ce::9)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 07:57:56 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::7) by PH8PR21CA0019.outlook.office365.com
 (2603:10b6:510:2ce::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.5 via Frontend
 Transport; Wed, 31 Jul 2024 07:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 07:57:56 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 02:57:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 3/3] drm/amd/display: Add NULL check for function pointer in
 dcn401_set_output_transfer_func
Date: Wed, 31 Jul 2024 13:27:33 +0530
Message-ID: <20240731075733.1025866-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731075733.1025866-1-srinivasan.shanmugam@amd.com>
References: <20240731075733.1025866-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a20b5d-7474-44b4-aca1-08dcb1367d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Or7pyd4IyQoUi+0wnqU3bkXJczGfeejIyovEW10eaAtvln9vnrJnzM2tMx7s?=
 =?us-ascii?Q?dG5KGVpU2O4udc3YOSM90GfkTKjbGPoekY8sQeaFxfSn7mceriG+3sv9MwIy?=
 =?us-ascii?Q?iibhkNpZ0P7tftcc9gMRUdjIPzVEuq5vkaVcuIIZJRUYoxbXBq/TEPXEEAOo?=
 =?us-ascii?Q?hdZiynmeLn3htrW/N0yaPJUD+lWydKPKW9f9QseWJjIEOukLViuHHCM8Au6Z?=
 =?us-ascii?Q?dfwthPqLmSIet0O0cxDTNt0gEv4JSAso8Wk0DR+TljakQoIfmBIl/qQx1xrJ?=
 =?us-ascii?Q?1rfj/yfBlFM/pFLX19sVI5G87IM4qqVzeIffhAsKUw1DOnxEPAxKBT/g3XdQ?=
 =?us-ascii?Q?stfpRHZhv1HicW6JPy+AoVT8H6KMOXKAqHfe1xFJUAGWdkinqXJ3HO1ozHHh?=
 =?us-ascii?Q?HVH8X0nawuL4efWBnk+JHE6b41NPgPqy7T4I2BMO95oE8/nXds551kToJPcE?=
 =?us-ascii?Q?4Pv//XQ7YHy4HjgxHDKMfOt4SddSaCneXDuSvN2wzJbooClyffkFCqEXTNq6?=
 =?us-ascii?Q?0UwYLrTLU1Lm1q0VYRgKrJSQ3uzlXTtQJRcuDltlueQ3MtHnp94uLj5swBkA?=
 =?us-ascii?Q?++HuqAy9OFeSYJlh6lCySv8ZmWnyjByD+uIguAUZVjPU05T5m/zbl/CFZ8lA?=
 =?us-ascii?Q?4XsS9A3JjEWKbL1AGfuQPau5eYaPi8+x3ZGpgeDxlHz2w05jVx3V6L8KK8hU?=
 =?us-ascii?Q?dqbMfKoQoJG9+FiRu1wf9xq8puA4NOTWd2hKjIOkrbEZ/U/tcTDN29+mDYgx?=
 =?us-ascii?Q?0fAXLR8E37lvkmU4YVon7WEAw3C0AfmIcFoe1F3wa56xZv3hvvEIp+KKusCX?=
 =?us-ascii?Q?oSzResDn05r9DwufDpvkX0gTcvBkdizMmRUj3lFFBThMLydbGYzazR4i0lQi?=
 =?us-ascii?Q?7H1I93YPtxlhGRLmW9yA+gIbLYECYxbqi3bobaJdVOViNS4zh/IqcXZSS6oc?=
 =?us-ascii?Q?bruhJkaE4JANirGCFXi1a6gFFAF2aNFxyffnuyzHR/tqDTmGwJ7F6UwddfMJ?=
 =?us-ascii?Q?loGNEnDUmUQCp/RjakXj1RjSn11knI4vZXIl+/MlNVE3DxEfY73yo/PrBFBG?=
 =?us-ascii?Q?h8XAW0CUuZkTre8oqtFNXMt4zUOdOsSP23aN9i8xRWfkxG5xaTshqw5/fuxd?=
 =?us-ascii?Q?aj5d/7ej7jn8a1W0wHiz7pdkWG9OhpDNLaYAMRD88U3/uYk8mRO8j1x4Aiau?=
 =?us-ascii?Q?/D4EFgJ5APPtomJmQJaapcTUBo04FNBv4g4KLY0Uqnjz/tS7YnJvvCvW36Na?=
 =?us-ascii?Q?avgGX9nzvXxRJO2rXazY694fGRkpCM03pUeJ2R/ZExeEUmrxve9V0zrZ4c5w?=
 =?us-ascii?Q?WTmdpLwz3PEj9C3CvlCw7TUfjX+eHBd+Df2mvBfHnxzDjRzQb9Bb9yXLCYnf?=
 =?us-ascii?Q?kjwd8cacVPjlxPNpWGSszWwGQYtyDlWjsVb3MEaMEJ4XvL4dsQbxGZ4GceJq?=
 =?us-ascii?Q?M/Pojf5MpSiw+CZE9f11NYAPq7Xojb8o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 07:57:56.3637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a20b5d-7474-44b4-aca1-08dcb1367d18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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

This commit adds a null check for the set_output_gamma function pointer
in the dcn401_set_output_transfer_func function. Previously,
set_output_gamma was being checked for null, but then it was being
dereferenced without any null check. This could lead to a null pointer
dereference if set_output_gamma is null.

To fix this, we now ensure that set_output_gamma is not null before
dereferencing it. We do this by adding a null check for set_output_gamma
before the call to set_output_gamma.

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index ceaaa8df3641..77489bbcda02 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -743,7 +743,9 @@ bool dcn401_set_output_transfer_func(struct dc *dc,
 		}
 	}
 
-	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	if (mpc->funcs->set_output_gamma)
+		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+
 	return ret;
 }
 
-- 
2.34.1

