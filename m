Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58FAE9A04B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 16:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5025F10E601;
	Wed, 18 Feb 2026 16:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t0pXnM+c";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51B6510E601
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 16:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJ1MU3IyAX7+VWBA8hs97t0/ZYxiIzl8ZP2wp4MQRe4Vrjxzeq27j/8qfkAsxteZBeJkM30sek/kmp3ZWgPMMQoegdtDKqU8j6mQCwDUWni8PQiFB5u10T/ze5L+AGomfSJSBMTmNzy9W1e/kNjWt/LH7hBXMvQFK81RNsY52KQ3k22XOTWD7k+GEnmOleqlRZjIT0WxBzabS8qtHVBeP/FgFJroM5buCvhhekyuB+Sv1EVZ95osB3A5fNu5wF3hXLX1D14SM9mWvtwYaHzYofrcl29/f9Zi1BlMo0nT0oJJusPRRHku80at/r7OTQk3BgVJojFVq5mMbyd6a+oa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0XrXT6xukpGphecRMe0lTi6z8O3bdhZ5/a0HVZUYHM=;
 b=cRm0GyZlPpairr4eKceBlViW1UIDdTo5yGxOa89bsX/vADLZ+rGK19Wpqu5UdMykhF6sr1GvHLBOCjixyu+eLoWEiYkL06dwSEQS+tX6mGkSxmK1ZKpnhYHP5rFCSTE4fwtx7+JEWfmNqMWRQYoHNZ1dzQVU0Q1IFiDLWpYS6boawj6jGszxjd316DPRp9WyXEUTOdJBxxW6ScdysRUr/rtOFRdBo6XKKoWWbtBWQVWdaRukak2xpj0J+ssaBo0UMIg3+Pz0a6r33VAIgxaT0whJtt8Wy7p/8yFzxkwIjN1wdk0fbzJtt62L4VjNpWL+F5ifvIeHLywevPM67tfiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0XrXT6xukpGphecRMe0lTi6z8O3bdhZ5/a0HVZUYHM=;
 b=t0pXnM+cPo4vFw0OLJ/CbbC+mBo3iXXmAuzGKSpsQzglj4DFcHDf3JPcJXIZLcB7PA0G5/DMYClBxrRYVDvshASa1HGz/RN4QrIXzQWIhHJ9exayZmHpWu7QykY6kTKc1pOJLtxtxwqX7eRRuYUlAQu6Ls2rsRjhOgDUNrqY2xc=
Received: from BN9PR03CA0639.namprd03.prod.outlook.com (2603:10b6:408:13b::14)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 16:51:30 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::52) by BN9PR03CA0639.outlook.office365.com
 (2603:10b6:408:13b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Wed,
 18 Feb 2026 16:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 16:51:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Feb
 2026 10:51:23 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Feb
 2026 10:51:23 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 10:51:22 -0600
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Cruise Hung <Cruise.Hung@amd.com>, "Meenakshikumar
 Somasundaram" <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 3/9] drm/amd/display: Fix DPIA number and driver ID field issue
Date: Wed, 18 Feb 2026 11:48:04 -0500
Message-ID: <20260218165116.155001-4-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
References: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 592fcdbb-e58b-4d5b-60ae-08de6f0df6a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zpL3f06i8WtuskHaGraozWVBF47gWW0LqLFqhllfsL4Jv6kb8ARtybsJZC/O?=
 =?us-ascii?Q?2couSZSoefdUV9aw4FC+J08jbCtS6PfaaJLQCOcW9QwICyNMz8XbS0uFCByo?=
 =?us-ascii?Q?AIjqTNdnuuuHhuQxLdjf+6C5wxVgeqxxGMHGFsrS2TV/srsWKIGUxDMM3n0L?=
 =?us-ascii?Q?5H/17ev0+N3cfyV4rlWEbKWu/fRI5ayhFE5wgtg1UAYQCg7o7uV6nbkMq3/X?=
 =?us-ascii?Q?SBt4hcBGpe2AHIESRFfBMC+at6GXlT2Jxl+sn3WObKO8jmboO74adUowg/xZ?=
 =?us-ascii?Q?JfpjMg1e8r/XnUv7SEqY1log2I9P3XE4hfSdp0lPlCzE9xeC4DaFlWo+cVgs?=
 =?us-ascii?Q?FsypM7QRMO8y2OMM/X3itcLlzSq1oG3lbxIfnCztQvhIeipfjdTfTroOr0bL?=
 =?us-ascii?Q?OAikMg3Cv0D6GXYV+/yw7qb+vhAwMTBSIMdm8Zp2EDwPPMtyoyVt0WDL3tH8?=
 =?us-ascii?Q?5I7EET/L2x2gVC1XdyHK+ZAMsKlMefOAknqIx2MsmuuHiPO5VriaZ7Lm0uaq?=
 =?us-ascii?Q?U7KyXKXJlGNxMUj752gKbCOGXbkDLNgOQLrA+t7pZNTSYQzOWiE99hHKv+e5?=
 =?us-ascii?Q?UB7DyaPm+5f48TvUbKgVDlqHjuNkINyEkfD9T0xX49i7Wp85/yqykSHckvq/?=
 =?us-ascii?Q?AFXM2dnNdHE9c/Z6J4w8fyVDDfwXNXg+3Wy+cGTX1NMmxLXRdDo1JcDmCRNN?=
 =?us-ascii?Q?r+upFm5KZfyk8sBTYmLZG/B2qnaH2Y7oe8HJqTlJL9xHkp/O3Cl7rjFFDIVQ?=
 =?us-ascii?Q?TKlLJCvL0A0JI1gfGMTJ5R1bhk8q15jRVpmNsarxG4ghx76hNpG/zB/3/2KJ?=
 =?us-ascii?Q?wdYYAmQuEp2dezo9ft7yn+/FNQBuhRb+M55zhNtSd85Xm0g4NnZDy33IYbNU?=
 =?us-ascii?Q?BNTN7ttv8SR9uYCVK1v1PEc8O8o6X8QqmRGYDKmrsUueo/vzrUZgIYN/8Sfy?=
 =?us-ascii?Q?aHAwIRot8AJVK7LUo5FWoyG24eyWIrdOLB40aLdt3Bm8iMzkfMWUU3Kbe2Ax?=
 =?us-ascii?Q?3eWtRxLeIdYCm2+UeNwDTPU1xEEYfgw4Y+9QhCODupIMOeCoNBcWdESTpkaK?=
 =?us-ascii?Q?xnUTmKGdciGwtcOwBgTx+tPIYFilIz5DN7/0lhPFu1fgUJvH9/C0KzwwuvTw?=
 =?us-ascii?Q?wbacvCmRevzTYq2zBTbr2uejSR0vJqoiDNQkXnDDvsiGqL9EWUzNvnRT9IwV?=
 =?us-ascii?Q?9zpcmJbm8TJruUcAPXgunIQ86fD8w4+XHiarEmqaFN/LkRN0LqQg9paVpb8w?=
 =?us-ascii?Q?EOewGGDxOW5jOeuV/FfT0YsXV74QhTAUT32VP4weasPcFkXdfW69nyoXKFVe?=
 =?us-ascii?Q?jHfrc1q0zafA5wUmrIJZ/Zmc/a8ZPdb7MegoA3PSBsRfs1MwvUPn5dP65flD?=
 =?us-ascii?Q?iaTsGplgp+q9c8LzV6GHVTHQn9M3ShP7RcpmN4Ck20lj/lUTPTiQQW4LiVlV?=
 =?us-ascii?Q?v4FFWDTcpPKUGYw8JsPxu9KJpeZTjMTgJts8k/cCIPRPbB8cFhquHiEmTjoM?=
 =?us-ascii?Q?TlOYrjEHXX7cWqBuA+zC9dASfRMxJ45/lRMagclvjh0GxewF6k8cVdA4JeFV?=
 =?us-ascii?Q?w2lMekiZJ0XDJ2bTfDT6Jkn1S6wMyljGL/l49IKRtfFQMNr7hOMaPf/H2uM8?=
 =?us-ascii?Q?d9hRP5FA4OGo8MOqmP4TglK6j6A2OW1ZRGWZLzh0W5v8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z4guZcWwrN5SlFpg7qZF2EkSdvOEngnvocQqCqm7Azs2NacxWmXZ17N6MTCbfvmAt3iG2mPa7E4eleiDpML9AptjFmhR5Vu979J8exuCsbtCnq3gHRTI7g3ZqUdwhl/huqOHMNAszA3Mx6MTAWLwAMKhfhhXX0w//K7UyAOl5qDg4bud0OVi64+1hCwTQEERkbKyH19Nbu7WIrkv6/yFPxDIvDP0KCVX0H/6QfKgitSY8vTNb+m1CQ+CjgDrxV3W+twH4P4Vw3gTFxDxZ31J1sfn5xAx5Zzr3fl7aYPtHUXAC5Nk0xWy56yd7ivVbO5zCdr6BopSF1WJE+aQLOZQl4M2SQCwPbHjFvaaXM32No8PkeuloLDrq9I/xPNniQdt7l0hhfDdLzJY7lHnRcyHZQAZND6b9iRYU8uPGAxcQrN4pfSbCxYbOhrfFNwACSH/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:51:29.6269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 592fcdbb-e58b-4d5b-60ae-08de6f0df6a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
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

From: Cruise Hung <Cruise.Hung@amd.com>

[Why]
The DPIA number field is 6 bits in the spec.
In dp_type, it only defines 5 bits.
The driver ID is only 4 bits in the spec.

[How]
Set DPIA number field size to 6.
And only update 4 bits for driver id.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h                 | 4 ++--
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 5e3646b7550c..9540f0ead279 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -947,8 +947,8 @@ union dp_tun_cap_support {
 /* DPCD[0xE000E] DP_IN_ADAPTER_INFO register. */
 union dpia_info {
 	struct {
-		uint8_t dpia_num :5;
-		uint8_t rsvd :3;
+		uint8_t dpia_num :6;
+		uint8_t rsvd :2;
 	} bits;
 	uint8_t raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
index 9b2f1a7da1d1..766b54631c79 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
@@ -71,7 +71,7 @@ enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 	link->dpcd_caps.usb4_dp_tun_info.dpia_info.raw =
 			dpcd_dp_tun_data[DP_IN_ADAPTER_INFO - DP_TUNNELING_CAPABILITIES_SUPPORT];
 	link->dpcd_caps.usb4_dp_tun_info.usb4_driver_id =
-			dpcd_dp_tun_data[DP_USB4_DRIVER_ID - DP_TUNNELING_CAPABILITIES_SUPPORT];
+			dpcd_dp_tun_data[DP_USB4_DRIVER_ID - DP_TUNNELING_CAPABILITIES_SUPPORT] & 0x0F;
 
 	if (link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.bits.dpia_bw_alloc) {
 		status = core_link_read_dpcd(link, USB4_DRIVER_BW_CAPABILITY,
-- 
2.43.0

