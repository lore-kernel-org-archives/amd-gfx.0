Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750C6E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 16:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E42E10E72C;
	Tue,  7 Jan 2025 16:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cwiuu9b1";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F81910E19B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 16:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4FTdLT1waR+H03ZJr0jiCWRCawD1mAA6ZNeN6bECxSra4jKSFBTeI1mGuHcpiql6m8rVplk+o/6FVKZfgZ6iy17thQyDwpjTuU8mzlWxIYwXVWFUO+eKeNH1yw7Lecg+rGvTZ+Sj3OLT6Rm5E88Yv1aWp1g1e5E/x1n1xe23QgiXTClVK2q6sHMoKO5QspIb4bX69xU1LAUM2cMaaN1H/0lfce4kSTlZk4rb+XYRpaJGIUIhPe+BG6BPNd0FPyFo/TX7FyomsgDJfZLFzZJVsKroQlrmJHfkOHrgAiujil+nnxusT9RnL3rmGGAhrIkMAOOoNKVg26Zr+DxJ8yrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axhTq1MMyA8PkkyRBiJcnCwj18fVVorhrqcySL29iR4=;
 b=UbWl+/lVHXfSgBhv8zIGsQTF8s7SmWSraqu8E9jqoAOdEAeZbyAnRFZnCUKSPo92o8hNrDhvzzEuDpvJdCG5QGwdQYLTLkeZ3PojFZ3vDbMYE0cdy/C0tvv7mS24LqxdoLLWNztCsrkxyOBTgSaVWvNzROiuYbjsKiHxG6GhZ7Jdh+7PuO7N4/wcFSy/EeWiUKZvdxnGgWzjCuuH02M59HeIobFOEdFEaQlbmhrxVMzCgwqw5zDJpVp/IZANu2x3720ST7daFHz/Uy7CBUoSxuir7MA+FrMO/B96wfziOxBOotkK8dFdHvNWknv90XrtpgNb50XPhp1V1nCUnSkf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axhTq1MMyA8PkkyRBiJcnCwj18fVVorhrqcySL29iR4=;
 b=cwiuu9b1qFtuMjn6HQcJVzJ6f87t8ugBx8GCdqLllTHnvTf40RJ53JZH59vVJTyJymbWcO4kZuqboCyy90vnZ08N3oaqY1dz4A3bSiwIsqyI4qRyy4QNPSr7HZBkzB/fQRk2xluhKPpvQk0CpH+B5X1FrMX7Z2GJYyVRaeHKRUw=
Received: from BN6PR17CA0054.namprd17.prod.outlook.com (2603:10b6:405:75::43)
 by PH0PR12MB7861.namprd12.prod.outlook.com (2603:10b6:510:26e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:30:20 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::d1) by BN6PR17CA0054.outlook.office365.com
 (2603:10b6:405:75::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 15:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:18 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:18 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:14 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Yiling Chen
 <yi-ling.chen2@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 14/24] drm/amd/display: Remove unnecessary eDP power down
Date: Tue, 7 Jan 2025 23:28:45 +0800
Message-ID: <20250107152855.2953302-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|PH0PR12MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 40239167-c4eb-4474-ab02-08dd2f3031f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?loP9uZbMbnYmnkVxZNtqHLC6/PQxMgeItWxqEHpQeIDQrdWDtNsHBYfDRmSs?=
 =?us-ascii?Q?zRu9EemNJPa2PeotWo5iNzayeODm9jmLMxotytFRikZEcJby4KMYrlqe7I0G?=
 =?us-ascii?Q?e1wVuv1mPuhDX47H2p+z3GzM25a2bzIQ3wGabPqHoe9MeT7FBF9+Ej4JjFwh?=
 =?us-ascii?Q?bRZcWf3Iq5TLARSk6XCfHx0ECM2LkOey8oigNm10l8f/YPpHhMBoEpl6DtTp?=
 =?us-ascii?Q?VZi/1kFuc97AYfd53DTEV6a8h3G+W/Y7xLnZOkkM4lRQDQSDdpPvJfUoqbAC?=
 =?us-ascii?Q?Jt6eyRWsgiHvj4hm6Em/3bstwp81Bij865JkvmkTwi0R41Q+afbHmo0Z5Cu0?=
 =?us-ascii?Q?ZJ9teaMihzNn/A2cJtDOCxRBdR+Qm/y2UojLcWz+MwbUjw9Bu3S1ge2RX5b/?=
 =?us-ascii?Q?in3sFqQkx2ffXg2w8Eiz1kTDEjqM3iJCl/EMJAJZeek9r2Imuc3rWOw49Ymq?=
 =?us-ascii?Q?6tPTcFUPHrprCI8JG5zypu4PEbEog0cwp0rEW/HUDAfZqPS9yIeAIyEArowH?=
 =?us-ascii?Q?5z9/syh4Ma+dl+eIqfkk1MqYzPKuf00TQ+cSnf2+SBQKn39nsJYXVa+2hIEX?=
 =?us-ascii?Q?b5Q0GkPaCqWi8mh80+0bbAynfOeyMyWC/shVtprI5Q6GFIUCq6GQ9/v9pwlg?=
 =?us-ascii?Q?lBuxgfy44DiOqGH1JrXKtuXC3R9pixZTH9MctSK7d/AsQFuIseRoRXD5zxGO?=
 =?us-ascii?Q?XnTN19i773bhKppnIAt1EEXz38yPTmiyrkXoKxfmNleJtlbtykMhZc+Qi9md?=
 =?us-ascii?Q?S2Cy7VIz3LOpsAhRFnkbFAznr5BOpvtdLY3xzduWVKun7uthVAosIlBKg6wB?=
 =?us-ascii?Q?BrAF5W5kOZjUPP67/aKPHlIL33HbBF77i9xHwNfrbqz7z17sIEZGjD8Rairn?=
 =?us-ascii?Q?P91Vc4NINlo2GTiYzCz3xfItAMjmV4lPtAW66GyNh+mVYm14V4BqO771pOmh?=
 =?us-ascii?Q?1QRdHZ4Xd80YKugFIV4P2ALcsJFfic8ybOXAyhGbK3NAyzbxybBtZPVX+mEG?=
 =?us-ascii?Q?HWF8YcmpcJ/0dbZN2VZkY3kDrdlWd/89yvT/6E3sS4gV7c0pOmklmI5EiMYo?=
 =?us-ascii?Q?zqR+WvAdD/6IX7BMAgJSxJv5LftA+XAldkpW5fNGKjrLXOuURKy9RBY6MvZQ?=
 =?us-ascii?Q?eGA545NOt97uo7bhEwcF05FQjj3SRMrWWynUAbqlpFm8ITqioP+3m54Ohh7R?=
 =?us-ascii?Q?FPktQuO7WThfp78/HVZTxnthTfMQun1KcARPEf9xTe6koAhZ123i3UlBTpsJ?=
 =?us-ascii?Q?XZOwTygvYmAaGQc10SaNmWsUjmOJ/tErGwxt/dh7SjhKmd6W/X62rG+Yz93q?=
 =?us-ascii?Q?BoOv5RlI5qk4Hlh538eV0AjUNNQndBU/v8E8wQTMuXSFPcFig6qGxNMC0L4s?=
 =?us-ascii?Q?2xOUNNwmve/5QvEKMSkCE0KE9ZTinRNLmV4tZ/hvd1U1S6rx7OJt+0tNcMO1?=
 =?us-ascii?Q?ffEEn6rK2KI1c0+mbxTRkqtd2V3WF36tfr9b5jNp8dQOMQs/Y9JrsQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:19.8751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40239167-c4eb-4474-ab02-08dd2f3031f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7861
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

From: Yiling Chen <yi-ling.chen2@amd.com>

[why]
When first time of link training is fail,
eDP would be powered down and
would not be powered up for next retry link training.
It causes that all of retry link linking would be fail.

[how]
We has extracted both power up and down sequence from
enable/disable link output function before DCN32.
We remov eDP power down in dcn32_disable_link_output().

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Yiling Chen <yi-ling.chen2@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c  | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 2e6ecf939fbd..ee4de9ddfef4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1399,12 +1399,12 @@ void dcn32_disable_link_output(struct dc_link *link,
 
 	link_hwss->disable_link_output(link, link_res, signal);
 	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
-
-	if (signal == SIGNAL_TYPE_EDP &&
-			link->dc->hwss.edp_power_control &&
-			!link->skip_implict_edp_power_control)
-		link->dc->hwss.edp_power_control(link, false);
-	else if (dmcu != NULL && dmcu->funcs->unlock_phy)
+	/*
+	 * Add the logic to extract BOTH power up and power down sequences
+	 * from enable/disable link output and only call edp panel control
+	 * in enable_link_dp and disable_link_dp once.
+	 */
+	if (dmcu != NULL && dmcu->funcs->unlock_phy)
 		dmcu->funcs->unlock_phy(dmcu);
 
 	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
-- 
2.34.1

