Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95A4C3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B2B10E8BE;
	Thu, 25 Jul 2024 18:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kq9nY9Kd";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C89D410E8BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EE8JeqlUtzMWbI2Q8WjPJU6k380glY9I4eWX1iglwJUloDFjHU0cT0RhlnnNKJF9d9RU2I2cYw3atRQme4qPghEOLS1W3HyOxsB75GeqEnZnBYSTc1L0GrlAIe/UNVb7EtjJyLuyBt5uIdLP19g78P95SYjirulLvndf10yMF0yVpre/z5fbOc3ehi1DyuRsAVz2/SgaYcfSkkfLClSXyhIxDoJdOXl2LZxdmDNMsa2YoLoUY1q4lwLfUt7r1wWtaVGdDtNqqMtuFcFDdyQsG6SWceNfsxLnszyr0vjm0qkUk9am+w+30/PzNasT5y8OVXq9xjAsNr2/OzpmPfI7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a9BWTdUXUh03N5u884as4B0xMmUrKlUG+0HN/3NCQ8=;
 b=tc3RDzsKDvVxni3ez+xMWOrZyAFM4cW+CEEMVue4t5z5O6S9Cy7KDPVkzHKe9lgy+WLFy41235//hiN6UINbdSzJjJHdPKh4RkP0m6ZzOLKy+UAbSA6FEZJjjpnZh/IMHJI2IvWAdJ/Fec7lgrZfP2HIyWY+L5jEnzlmNaZx4pzgJ0ExI7OWhioQMCESncZMc93FXRioQugYchxohaoO0yck8eFT3YxFMcfmXbrYmc/ZFboOC5iD1l61XbghWXONvYlDLXrzYdNbm9h59fOGpeCgXiJ55NwERRZdhA77Yhi6NTwel6TBtM0m8jI98vXQI+WRqZf8WM5z9aS8dlrc3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a9BWTdUXUh03N5u884as4B0xMmUrKlUG+0HN/3NCQ8=;
 b=Kq9nY9KdF3jTsoCy1IL+uOBKLWs9x3UyJ+K1D5ODlDDEmTwMgY3SZeuiphxoYWUm1J0xLzAPD0jcj4Y/E/41pouxpiZLnl7w/F5uO0i0GSRgKiabcguM2PqvP5qYMfxPn8D6KNAbLKIZb7ECXGPsczbPFhGAOG3KqC9SduKMIN0=
Received: from CH2PR02CA0014.namprd02.prod.outlook.com (2603:10b6:610:4e::24)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 18:04:41 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::92) by CH2PR02CA0014.outlook.office365.com
 (2603:10b6:610:4e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:41 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:35 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 36/39] drm/amd/display: Add dcc propagation value
Date: Thu, 25 Jul 2024 12:01:20 -0600
Message-ID: <20240725180309.105968-37-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: d3be017a-4b34-4f74-8320-08dcacd441b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vxw9eJYaWJSyhv0Qi54wmbBiP7lQzn7D+gQYlDWtPvHr3GyJjCMiJr4S6ZZS?=
 =?us-ascii?Q?D5cTtjD6VrKcSF7Vl1l0E3v3hFNccGF4gt9etLEMSAGwAlyLyd7Srgac3tUL?=
 =?us-ascii?Q?PvnRIOnMsRja1FVHJPYZofxfiRyAz84ZGWxUMq8S6MIInrw6OvUbXSh1oXbz?=
 =?us-ascii?Q?ZOFOMlXXFtzl4lDk4NQqBIUkHPlGl7GVsxJo/GA4jhG26gL4/dBP1VgCuu/f?=
 =?us-ascii?Q?vlWW4fSZ11IcOp3RbNpHTRL7M2rOUOF1XS6suBsapHO79TCvs/CYJjW3Q80E?=
 =?us-ascii?Q?jRL+Css12d+VlXdM7zMQ+dRjvlD3B9Q2lMBxZ/OLgstNxp7iHv3wLGcNDF2v?=
 =?us-ascii?Q?79Tm+wHbRlHE/xXx8C2oIwrmAjK7pjDc0hZ6om0Cs5kMkm6udnzlpeLcZzqo?=
 =?us-ascii?Q?42kpOBles/+1EwkEzXeJHdArIpi15m984wUbHf54ZpoD3RqRKD+HmJ/CAkSO?=
 =?us-ascii?Q?+64+EwA8Ev63wYn2SpICD4NxIBN25IrsBv3zdhpsA+CvvEX8qcyQpRH4L6Cm?=
 =?us-ascii?Q?BFe9CfM4Ru0d3Q8vrjvvjw2veGpRnuCGVb1q9L643kbLCYntQw9kKQkzyMR1?=
 =?us-ascii?Q?Ljw5KUl4CkFDnjSpLD00KYxnmO3KXJYI8tlFYsBya/0nqZQEs5g17fVuxx1z?=
 =?us-ascii?Q?74N1or2VHnWXVQu1BqScT465dDfBpqoMbom2do0egqRaRoCCLHvgLtne4REa?=
 =?us-ascii?Q?18xuS0N+PesifDtCf+VoBsZz+r3q2z8nw6JIm6ooc2rjtUhAd3erUqLW94YH?=
 =?us-ascii?Q?awZZNVzM4v4zBYnbbbFxMfIpKvV2V5g6EHWcNobzPLLFI1P+BKYgL6GedF9/?=
 =?us-ascii?Q?C/fnVtAj2AQBO4GaMMSVY+k3bJ6NaBqVNB/dqzb0OteMdWYyyPQyPeSdSpOd?=
 =?us-ascii?Q?6nckvkSjuP8bX6qA/TbZeym1GoP4eWmscIqOv6WzdWa/VmbEElE3tcGI/Rkt?=
 =?us-ascii?Q?SWH5a1zJJRAh2kgRTAMC1joKWFgpB48RmMSylIFxWuUfsBIFTkjtGSXWcODl?=
 =?us-ascii?Q?u6RgWTkadGqvsUefl+I8b/JS1HjxXbg/FVPdLCO23gDmim/+zyD+Zua8gAK4?=
 =?us-ascii?Q?EWsi8x+szyyx9SJ0Mv1xOsSMnAlGs+HehGlR8Or9/jdQMVljsOgMUG9u5e/N?=
 =?us-ascii?Q?wQCyKGnJCvD0B9BW6DpL6o0PxvfOXHgBCv13yg5u+4JRT6D2/5qZ8+hnRg/j?=
 =?us-ascii?Q?ODCuJPGhNQjw+NlNU/hBdrCoPVxdR9yzWZ7wGaI64SDYc0GyFJctQCmFGapp?=
 =?us-ascii?Q?gC1iTt24PRe3jpIEHDgL1KV7Vjh1dzYLXvkzT06jn6LsJttTtisJD7A/JiwG?=
 =?us-ascii?Q?VBG7W69WQmyr19aDJX7yHztCYDGMgeSvdWvIaSHEO1uory+NzFWCbwhh3Dlp?=
 =?us-ascii?Q?a2Rt7c9UTqXgPRy3gvp65CzI8/M/tAn0YLlWvLJiavY/EOiZKCvcF2jgA91e?=
 =?us-ascii?Q?hbljT9/2/QJ1c3R7OPeKXQSd9HFkqXBw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:41.2464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3be017a-4b34-4f74-8320-08dcacd441b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127
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

Initialize the field dcc_meta_propagation_delay_us with 10 ms.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 9fcdf06d6aa4..3e76732ac0dc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -723,6 +723,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_prefetch_in_strobe_ns = 60000, // 60us
 	.disable_unbounded_requesting = false,
 	.enable_legacy_fast_update = false,
+	.dcc_meta_propagation_delay_us = 10,
 	.fams2_config = {
 		.bits = {
 			.enable = true,
-- 
2.43.0

