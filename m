Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EC8C02198
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AADBA10E3B7;
	Wed,  5 Feb 2025 18:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Epn29HmG";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0821110E387
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/5PL4homdNgZOoKz345gm578Bf/k/2blnW4OrtmjAXuph5dwXNdxZN1yOe2hz9V5WXYDJIAbqiSfvHfwDQnsQ4+TTAEXUAixJ8huG1OjVscMj9+iuyycO2QIxzPt61TpG7U2ntc5B5RFAx8/ofeUOEAIF9JTTafu3ATH31D0hm8c46ozHdkBorYtAEdbnqGVblHtFEUwYGB9Vyk2bhza9YzuZp054PWEn9/azlweUcbL8CPX2aeIqtQsaATXXXnbx3a8NoXmtI4NJcxehnGDCJ+0w359kyYJGfvh6niaMdoEtJD6xO6jH5/mqBXm2cAwTOkT1DxYW1UiYAVMllirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rv2dACzWXvhecwjYFZZIbhK+iVYteYRAdQHrTDZEy4c=;
 b=KCpXlZGcgULDNUbFgi+/jwBW7uYYjr9Y6pH0Kx8chrlVPbL96Mqr1qJ18XlHv3FZD+1GBspxO4mmO9VkNPEWRZEiLmqcHbpJySFnvHBhW9O2aBxWSkVcJb/mf4yWMoyqaaFGHOBCoJlGh0WOrli3qDZ3cLP9foUCekcjyo5km3EisqvR71stfblxpfPrlKfkjbCE1Wh1c8m7ATGvOWZS2VcFTJ2/4Juews1kCOfjVFistkkfWeHf0JnGlcwReKOR7N4lypTrpkhIWvL6TpRHkkk2At+hdBHsOKuJ2DeYn0h8WWlOpwx1aIfqUdFJV3WbwENY1MPqE25I0doO1hsnuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv2dACzWXvhecwjYFZZIbhK+iVYteYRAdQHrTDZEy4c=;
 b=Epn29HmG6EmArRGD4ae+43dTrYUe1FAUsMGklh0lG3OJBbHykRWifosnH7Vk7gckhvDyno5q3s6yGj999br6KECqL+4/AD2LU4XrqPZwMTuBWgX50YSxXacqEQV2wUiI+w5SNS2vz+iTTQBMBX0uxkdU1HEkPmgqKgfKVztgAyQ=
Received: from PH0PR07CA0057.namprd07.prod.outlook.com (2603:10b6:510:e::32)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 18:40:57 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::4f) by PH0PR07CA0057.outlook.office365.com
 (2603:10b6:510:e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 18:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:40:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:40:54 -0600
Received: from aaurabin-cachy.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 5 Feb 2025 12:40:54 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Ilya
 Bakoulin" <Ilya.Bakoulin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 03/14] drm/amd/display: Don't try AUX transactions on
 disconnected link
Date: Wed, 5 Feb 2025 13:39:18 -0500
Message-ID: <20250205184036.2371098-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 8326c918-1d14-4926-d5ad-08dd4614a111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0fNHs5VVVS5T9TcOfx8kvnyF9Og4kerPS7g46JM7OB0oMv/41QfwTO5JUvHM?=
 =?us-ascii?Q?J+XYPhXgJaFcInStdq5kA8P/MNR2cn/npgDXo9xblDOobWFJARra9DgPRYaj?=
 =?us-ascii?Q?Bgd3cEw2lLcAMMUVMKOCCnaDxq2CY4xpgtaS8TJNv3gRmC5BW2pZM9O+HdfQ?=
 =?us-ascii?Q?filHy23Z22mSutZs7L+K60JI82xGUPCFJtY1LCb/9ietL0jsu3HDeDFuhi0w?=
 =?us-ascii?Q?sqBv3U6SPH7c8BcO6UVhRZyhexpLLYogIHO2uIvrvEJSJOpgXN7aT29WwLpp?=
 =?us-ascii?Q?Ji8oSbQd67oQUmhIEOZIdRDpPY1yw6R2k8gq7gODXgL7o23TFNY/pLbsLICG?=
 =?us-ascii?Q?ZZJbQtYLCD0+Eno6urZ4mALG1pVTqIKfmFmX5UUc6TMnqWYuhjqjIOd+q9H/?=
 =?us-ascii?Q?+1Y0mNRriihQ7k5+LLmPRsIMsOz2Zon8ArE0Wq1qPtafodZSeUcqHw61Y8fE?=
 =?us-ascii?Q?U92UGLMrODh4CV07Vy3qFgUfAd80W2Yjs8cwIAytF8KdQ0cM0IynuZ1s1sVG?=
 =?us-ascii?Q?1DL2fDThORV3Z9w2/vJj/WRxs7sM8a+6YwIK98MEal1tY/5OH6Sjx+hhgQfn?=
 =?us-ascii?Q?v6AB7SaFgNYEozZZIibYFJdC8dPBDtsrUirnIIgAdaWVsj3/g63hikRX1QI7?=
 =?us-ascii?Q?MLLQSoKlxmyXjNYCKGV2lkWF2u/2n2tUaXKxsdd7iJ2eOoF6cBI6lCIuxFvH?=
 =?us-ascii?Q?07/TH0joL33XZ79Eq+ZK9VPD5OzZYqOI/3MWd+OGyfGVd8a+E2ktR9OisCXG?=
 =?us-ascii?Q?WpRlMKWV81ZL4of3bkt222E+ZAx0B0RUVoutpP+fC9huRN4Ih73iHuQux2zZ?=
 =?us-ascii?Q?pDfGkO3hq1KUdRz6dL0Yt00ckM/Wa+bRKgkXwxYFyvK8AmzoKLxtUVeAYEbl?=
 =?us-ascii?Q?CCzwY03Kmf5lSDHPOAR8hqPae70AGn7uEQoBOBPMnj9GdVKzvvlxyzb+PS8j?=
 =?us-ascii?Q?2QJ6vs3tkA+10hdbyTXUNIZ4ooh3NWyQ6Uc4u3JBXZrDY5EzMWXKAATXIHs0?=
 =?us-ascii?Q?euEfZYyIE9dbMU8yKClBYnq4mju17zrprQ1/3ys3PEKhMH/kVvQz7A7R7rXp?=
 =?us-ascii?Q?7gJcZr0SyEDu5wBwBVpvvZO3iHrtLGddJE50R5wAXrEXiCQB/OJHWqRK7gkv?=
 =?us-ascii?Q?WIaMs7/rVSDDBtGvJk/IcNL4mGVBFz9scWdxqGIGtX8084RtuE7HXkiGZyTU?=
 =?us-ascii?Q?7vlEwk/h9qqNSuxIXEEQ+/qnqOG4E8snR1GyPIVKwML4stFwxZTxPAY7sIwC?=
 =?us-ascii?Q?CHWXwadlt1tUfV4s9jDiVQ+Xc7R95NLAvAbJhaOzn/WZjuwQMHway1HvnLpX?=
 =?us-ascii?Q?hpTCAPQzgEa1mvuv4SZPcdnRu1zkBLAnrWW4tWLusdXMR7NYsJFiucvUhbJL?=
 =?us-ascii?Q?hXY/MnNNJEyUSbwC7hqYvEW3e1e2k+zT67BU/RtvPVuejUm2XZBfRgTsd6pw?=
 =?us-ascii?Q?gFqWJkBIlTSIz/JjIHTcVzQP934VBbQmaANntcivk/X/DpyIXAv+WqpiHOWF?=
 =?us-ascii?Q?FVwjwjtPKHkaies=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:40:57.1288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8326c918-1d14-4926-d5ad-08dd4614a111
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
Setting link DPMS off in response to HPD disconnect creates AUX
transactions on a link that is supposed to be disconnected. This can
cause issues in some cases when the sink re-asserts HPD and expects
source to re-enable the link.

[How]
Avoid AUX transactions on disconnected link.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c   | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index 2c73ac87cd66..c27ffec5d84f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -75,7 +75,8 @@ void dp_disable_link_phy(struct dc_link *link,
 	struct dc  *dc = link->ctx->dc;
 
 	if (!link->wa_flags.dp_keep_receiver_powered &&
-		!link->skip_implict_edp_power_control)
+			!link->skip_implict_edp_power_control &&
+			link->type != dc_connection_none)
 		dpcd_write_rx_power_ctrl(link, false);
 
 	dc->hwss.disable_link_output(link, link_res, signal);
@@ -163,8 +164,9 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, const struct link_resource
 	} else {
 		if (link->fec_state == dc_link_fec_ready) {
 			fec_config = 0;
-			core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
-				&fec_config, sizeof(fec_config));
+			if (link->type != dc_connection_none)
+				core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
+					&fec_config, sizeof(fec_config));
 
 			link_enc->funcs->fec_set_ready(link_enc, false);
 			link->fec_state = dc_link_fec_not_ready;
-- 
2.48.1

