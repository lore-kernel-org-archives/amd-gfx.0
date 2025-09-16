Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45E4CAC59B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21AFC10E3DC;
	Tue, 16 Sep 2025 19:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NcFNF+jL";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56FEC10E3D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diU+UdC8++aqFyC6tumVa3dnsXTPzX8qdbbxr9PT/LtukXp8KfLfsBn72zpITP/ch9Oay7DTxmq5Qynai+QGjAIA0cQgfkuFUtLE+N02GL7Ra3wDAJHra3ixybqm922q2cXHcrcSE4bAG2OWeifWjftFyiBMEGATFNHlUdTdZUM/8nRc9tYFr/WjdhAHXAvOvfv+5q0w6Ok0ROEeiZrjBF3kswmTr1cP5pdxAAFiH1vXJn/dweqw9kf8HLYaMl2UiRKzap+VkpNXmgdazirqAaihCUZfRbxZd6YGyOAjlhcpx1DyLirGc5p+jAnw1Dv8w9xT6plqGKaCVwo+7yYHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Noijvb0im2OOIQd6rXAvLGpGmG9Em8nUGIPINRAyIA=;
 b=F9SgKpYCVtYH7DWBJauGm7D0DI4Me9af1mJx/MklPG9Q+iwnMaV48GEZ5TQDdmnNCsh9KYwp7p/iQJU+9Pa5T9JDI9rVA2BbNw35i6s/Aoa+4rbuZCuTHr9a5iATQhL/bjzkJNBCx6tnIMV9gfDcmioNyKC+S00UcxQ+PNgWzWaPJFsoiFC0Jfior0bwbuxTqUqTnYaqvQ/5VG/2Pz16+vUKC0B1CAxbhkegJWEpPjFh7X6kRwdiQRJoVGrzzqlHcN5Fr4G/cmn+5EYWG9V1iYBQMQCcf/9zYEQHN9TouAPxuJQHNMCb5/UCNzoVKteoEC3hQkbR3LZmvF6HaTi1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Noijvb0im2OOIQd6rXAvLGpGmG9Em8nUGIPINRAyIA=;
 b=NcFNF+jLFarAlkaclIX/GvrTAg9E/8HYXckknw7D3Xl2aXEy1GJXCv4UyoAfaEjDL+ugiiSfy56c89AFHfwX9ZOgQkUI/en6caQwsG/IMwO2Si6LyCkCQzIxaLr/w9zmnWyq52rIPpkNuAzyABS1rBwdPGWhqCZPVba/TNW+hwE=
Received: from DS7PR03CA0340.namprd03.prod.outlook.com (2603:10b6:8:55::21) by
 CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:12:10 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::eb) by DS7PR03CA0340.outlook.office365.com
 (2603:10b6:8:55::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 19:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:08 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:08 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Paul Hsieh <Paul.Hsieh@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 04/20] drm/amd/display: Add monitor patch to read psr cap again
Date: Tue, 16 Sep 2025 15:09:24 -0400
Message-ID: <20250916191142.3504643-5-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4f45f9-9454-43f8-43af-08ddf554eff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ny9tNzc4VjNMV0V3NS9UUUdoV2F0Tnl5ZmNWcE95RytKeVFpQnRkVDFwSXZT?=
 =?utf-8?B?a3NMeGZXbGlEQy9oTnE3cVgzYXZnRFhNVTNtV1ErTzBLaUZhaWFIMVNxZUlz?=
 =?utf-8?B?NHJuMEVtZ3FyaGdkVG5iTkpMT1ZJSWdVN09lS3lzaGw5M3pyN0ZXQmlJb0Yx?=
 =?utf-8?B?ODFnZENRYzgrWDhnYU02RkI4ajYvVUpVNFNrTi9UQ1NLNVVWcEFKUG9waFJp?=
 =?utf-8?B?TWhadEU1L2MvNm9FeWpVSktrQlNnNENJeWhuU0pPMVFHRmxxTVc5Tm5naXI0?=
 =?utf-8?B?bE40VlN1eG9uRy9jVk5wRk9yOVUxU2lZKzNsZ0F3R1pJamhCTnFTNzhRS0RO?=
 =?utf-8?B?di9VNUY4RUxaSzlaY1ZuSzI2S1htSVZ0NDd4cFhOSFdpandhUXdCMVlvSHpT?=
 =?utf-8?B?Z21HN1I1WUs0RHdqVnpqQWpSM05SOGlSaDVVZFhsWnV0MjU0czFOUDFGTFZL?=
 =?utf-8?B?MTVLOEZoT05XL0JZZ3d0UnE3ZDVBU3hKWm5jWUk5WHc3MzI0c3N5SzhwL3Uw?=
 =?utf-8?B?d01xeUZqMmkyeVM5UnJSQkphcVRhYUlXTVVQOVJCdG1sU09kQWFLZVBIUWVr?=
 =?utf-8?B?eHdaZkIrVlZkdmxyVG9VVTZubU9yMlNNamtRVW1Wc0NqcGQ5THBYV2pob1Fh?=
 =?utf-8?B?SytUeklKYTlIQ2xyWDJyUlgrMnhDOUg0M0FQcWo0N1ZhN3l1N0l1NDBtTlgw?=
 =?utf-8?B?UHJyeVpZekhCVlZNbElzZjc2NkNkRXM0cVJHRHJxV2N4TURwTmk0b2pNNkNT?=
 =?utf-8?B?NFAyb2JJTGNhWjlSMXBJMDVxT2NBbGNCTGsyelVkYWRHVjQ4RVk3SXlqWGJC?=
 =?utf-8?B?L1owQzhINkN4OTYzTEFiaCtlQS9zMmkrSGliQVRqYk03bGtkcTZtK0lSMkNt?=
 =?utf-8?B?dmd0V1RMSmhwWi9tRngvUEpCNVNnTXg4dlZFcXJYZWdLaU0zSFM3eFpPNk5N?=
 =?utf-8?B?S3psdUJXMVBhRDFiYUprbmdLZlNndlNRUXBsb2ZEOWZwTHpZRm1URDZLS2Jq?=
 =?utf-8?B?UlpONWZKRVRhakZIdzZoWnJIYlJHbVNTazZyQ2FCc3VuWlpLblpsdkZkQWEr?=
 =?utf-8?B?eVRtTDNuUTlFTktNQXkxQ0FpTlpvR0diWnFTekJJUDh2ek9DcWk2NG04VW5I?=
 =?utf-8?B?M21KWWRiZnYwV2NFZzlsTGRaWWh1b2NyWWhJVjZvMWg3UnJOMW40eUpyeFFB?=
 =?utf-8?B?aDhBU000UldOWW1ndSt5OWZyRFNpY2RvbDRuY2tjNmx0cjc0SnJpWHpnQjY4?=
 =?utf-8?B?aHhMR0FRdVhaU3BNT2J1UGN2eWpSdldKYldGNGNrSFpYZmRHUkhDRGNIZ2VY?=
 =?utf-8?B?U3BlTWdMaU1QZllWamhEQ0FxOXl3Ym1jWU1tczlKL0tCNXBWRjErRlZTdjZJ?=
 =?utf-8?B?VTRFaVRSTW1JNFlPMlNaTHkxN2tBUzNKTGVpbkFrOTVEdHZWMjA3UkV2bjVQ?=
 =?utf-8?B?Q3ZrWGtROWZOTkRWTEF4MGNHM3hRSG15L01IcEFUY0MyMmtTNUJhNXUrTlBu?=
 =?utf-8?B?SVF3UTMzTmZ5VWdNOXpIakROeDFRL05hYVVGc3h6Qk1tZGlzcEJoYU9XMks4?=
 =?utf-8?B?V3VObDliNjFZbUYvc0lMMFVBajVHclBKMTh5b3ZFMkcwbUxncytKNXZvUFN0?=
 =?utf-8?B?b3JVRkJHa3BuS2t3MDMzaUM2RlQ1R2Q4MGtnMUdPcXVmcjVTOFc5Vmw0ZXdH?=
 =?utf-8?B?TkszMEpoKzlES25sb0llaFBRL09RVGtzM1NtZmhtSUw3WEZaSzNoRVE5cEU5?=
 =?utf-8?B?cHExL2VwMHhJQWVXVzV6bUlzOVBNeEVBWWhEa1VmSXIrakd2R0RYa0NkNk1J?=
 =?utf-8?B?UG5kSlpJOU5pQkxNNmpvVjE0aC84TUNLaGJvV2VkcFhadXZnQldhYWVVNDFI?=
 =?utf-8?B?WndLVkw5M0dja0FlcHJsT1ZpdkhleFczVERYdmw4SjhhWXJ4L24vd3RkTG1k?=
 =?utf-8?B?UVZGZzc0UTBSRERDN1htV0djbHMyanZRaFAvN1VpMzRnNGlkdE5SMGt0Sm5N?=
 =?utf-8?B?dUNCWlJuMkdEWUQ3eitIYnVVZE8yR1grMEgyMzZFcVcvclhkenhac0F5VXNl?=
 =?utf-8?Q?aX9mu+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:10.7228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4f45f9-9454-43f8-43af-08ddf554eff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461
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

From: Paul Hsieh <Paul.Hsieh@amd.com>

[Why & How]
According to the vendor’s requirement, after each OUI write,
the PSR cap must be read; otherwise, the vendor will default
to using PSRSU. But its PSR cap indicates that it only supports
PSR1.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Paul Hsieh <Paul.Hsieh@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h          |  1 +
 .../dc/link/protocols/link_edp_panel_control.c     | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 619834a328a3..b5aa03a3e39c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1217,6 +1217,7 @@ struct dc_panel_config {
 		bool rc_disable;
 		bool rc_allow_static_screen;
 		bool rc_allow_fullscreen_VPB;
+		bool read_psrcap_again;
 		unsigned int replay_enable_option;
 	} psr;
 	/* ABM */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 8b7b87b21c2e..5e806edbb9f6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -703,6 +703,20 @@ bool edp_setup_psr(struct dc_link *link,
 	if (!link)
 		return false;
 
+	/* This is a workaround: some vendors require the source to
+	 * read the PSR cap; otherwise, the vendor's PSR feature will
+	 * fall back to its default behavior, causing a misconfiguration
+	 * of this feature.
+	 */
+	if (link->panel_config.psr.read_psrcap_again) {
+		dm_helpers_dp_read_dpcd(
+			link->ctx,
+			link,
+			DP_PSR_SUPPORT,
+			&link->dpcd_caps.psr_info.psr_version,
+			sizeof(link->dpcd_caps.psr_info.psr_version));
+	}
+
 	//Clear PSR cfg
 	memset(&psr_configuration, 0, sizeof(psr_configuration));
 	dm_helpers_dp_write_dpcd(
-- 
2.43.0

