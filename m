Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A29D69112
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 14:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10AEC10EC97;
	Thu, 28 Nov 2024 14:30:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nW1/UAM0";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2CC10ECA4
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 14:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rylAmclcb0reqDNjAfmEY+ErDZXWXPbdnvOnm9peQDerPss14sooumpmUboueCUf4ZCzjJheUDbVwDVcoYLJSTwKJ+LyyLuwWI5tZeGvJ57X+h7Ew2K+Fkje6aMIpam98PyI/fOFoesUPtVO+S45YG2GtAT4uClqwZUYwdlgpeR5f+jjfP4rXYojNXZXXx0nTURKp/HGDZfZpr0c2643n9b9cdMniVb8+5zFFuo1fuVAaLEHcXp+7Fb4UO9jwN1WFeXsZawljLQ0jrqTWGfYbOhNK4CtmyuLkjDdNj8p7+gPg4HESvKcqMQmlS+Ouwta76Jl0lLVcgHpYwQ84A/siA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaYh4Y+1PKhxzcF5xRzIvvvdEu3ceYmxtZK1AfXNd6I=;
 b=F3w0sRRkz83IAq1PlqTXXnq3/z83Jx6fkeyxttmy+cPM1LCQGmzxdcRtutRYMw2KdtOhn012olqzIAKV4A9ExwFNu72pW0bvaP0ryMljwaq8HmEFEVG8byCC2nxB3c2ZRXvcaUPSmvBRsOgOYsWJFWc0MLhM9vMh/qjSorESiqYldbCYGgKa1+AmejSrtBG/uxyd8tfhPphIT2P3x+5bnBveE8qfwlt3vr/bGXntwEeBtB76ZTc+OWKIPfvO14q/4AKfL3ZuTywLdPUX885wRxK2mWraAPil0JlIozFxwhrm9cC1Q92gWjbPtR3BytLh6TvQqsRWnVpLNoL4O9PEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaYh4Y+1PKhxzcF5xRzIvvvdEu3ceYmxtZK1AfXNd6I=;
 b=nW1/UAM0hLFLtdM8iqoidllWs8QhjdnzE2t2HHrpnWKZVpnsY0PjxIbOCgqrABzW1ga7zULE3mlztvGOERMseGlo/9sgxXhbn0fWjPqbvhHn5QGTTORwCzx/p0D9PI2Bzf1coNq1ZPaEJc1CIy2LC5u4eQdSP6IVaQOoYTEGF8E=
Received: from PH0PR07CA0020.namprd07.prod.outlook.com (2603:10b6:510:5::25)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Thu, 28 Nov
 2024 14:30:23 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::70) by PH0PR07CA0020.outlook.office365.com
 (2603:10b6:510:5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 14:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 14:30:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:30:22 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:30:22 -0600
Received: from jzuo-linux.phub.net.cable.rogers.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Nov 2024 08:30:21 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Cruise
 <Cruise.Hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 6/9] drm/amd/display: Adjust DPCD read for DP tunneling
Date: Thu, 28 Nov 2024 09:26:28 -0500
Message-ID: <20241128142958.28370-7-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128142958.28370-1-Jerry.Zuo@amd.com>
References: <20241128142958.28370-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: d969f2d5-c4b5-43ce-194e-08dd0fb93180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MBPkZcYs1v/BMVDN02JZ/IOOUhzt7bOui6tVSYIU/xJdeWmL0vamUoKATc20?=
 =?us-ascii?Q?ckYpu9gRzVif4w79c3Zc0LapS0axGor3mHzkOdcTCAjhiUolMF/SmAlKDmlM?=
 =?us-ascii?Q?zLewW5bykNqJOOqQQGgIJt7rhijpQN++5WypnRZF9L2RG8kMSq08P2m1M+WK?=
 =?us-ascii?Q?jreQO3YTHs04UcZFfYPcGq9e89pBy31b2558xAZI1YeAwi8X8kDKOUmJ0MJw?=
 =?us-ascii?Q?SX6prdiPlCRFeA53yJMHRA1WKaD7EDjaBBNT9dHWzYM0gKTix2G3tVHGnoAt?=
 =?us-ascii?Q?tyAWc2gZzqk018ooUfQnyyvXgMpy/vr2Oa4x7h3Duw1xuluWvPXMykR8bRCZ?=
 =?us-ascii?Q?5AZi6MhbFmNJx+yCOcWYkNJB29r7lSoMY8PtlOl5kohP9t7hIDrIeile0fUi?=
 =?us-ascii?Q?OsSOU4ABAv3OU9v9fBqP5mBDNNrQRiKVqquQbxGfIjZQw6ZOHA/YLE76vnWZ?=
 =?us-ascii?Q?elbGNSvEsGIjSlrTq0+m2rd4vPe8sOuJ4YDa/PpXVAM1X+D3zp3bIRpT8Kra?=
 =?us-ascii?Q?rEW2mTQDdzW1D74XFQDWUchG45RwAJ5+r5iVeHfQU/F9unhhXoicLTBlMEkH?=
 =?us-ascii?Q?3fZEJYXKwHNNfKjHSNE6UD19bQriNwVeMakcB+e117CpMZ7zfiBMYhzB6B/n?=
 =?us-ascii?Q?GXAC820l7vxik63K1P31NFyV+YP3+6GBqqR1KON/qYJrVP31iB7wJeWTy59g?=
 =?us-ascii?Q?2nDrOpsllMExG31Wa5rBn9H/o8NxaVrc0NNdjXQ48rtqUulRAp9uqU/d/bC2?=
 =?us-ascii?Q?PLNfzuXOv1H1shpqgYAH2HwJmdIIQEXo0FY8eHRjo7nnKq2c7+kxXJV3MaNg?=
 =?us-ascii?Q?fqwA0xetGddiOi6y/0p3lrKEvRTwtzYhKCTcB5bD0b+A6/G1H9dtN6dtXI7W?=
 =?us-ascii?Q?/iVGp7JtxCCKBJP0ZJXAM7Ro5peXqyVUEmnMhMp7FgC9NGb6fBltfZCXTxzb?=
 =?us-ascii?Q?DlDjnc0EWuUsMI/SuXCetU2sP08l9ga8swsnSwEo9etnHCa7so98RW225ZRd?=
 =?us-ascii?Q?ICda7snsx+IVtydWoAamyCD2U3PZQ+4naOmSiJfsD5mZ7e8s0SCcFTwnmgdu?=
 =?us-ascii?Q?00k2l5XzV7STvhipaW9EutFbmO7GzSUHr343ixSIXIMt/bDFZeQaAQLFnRU/?=
 =?us-ascii?Q?fd5wZFoNA+mg5F1b23zBa9Q6/w/QTbR9KMVXpgPkexcHgzcrsqQIcoKAvxwU?=
 =?us-ascii?Q?471eXDkeEZE9gUDTS+H70GI0jqa3wQVj2dSMmgORJ0OytHs3/wk4IjO6LRYP?=
 =?us-ascii?Q?kmuEqEWXgCZ5uBJbAKh9HrUL5HHd4zMQelgB2jA3XtWnWmpaYoxmNE6YokDp?=
 =?us-ascii?Q?q10QwBJ6XjjfV/LSAxeIMoRdCwdbeY3B5DlPOeFqtLdNpHSMRHAWjhTZwq0M?=
 =?us-ascii?Q?9yE5B7fEV7phPvSyrH+Br9bpmw0qsZ8vt001yUDRSxgj/Uf6K4nDBrzAWaNR?=
 =?us-ascii?Q?GUy6iCmkcMwxDbLIcLhYAvL+A/LNqW5x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:30:22.9542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d969f2d5-c4b5-43ce-194e-08dd0fb93180
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795
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

From: Cruise <Cruise.Hung@amd.com>

Move DP tunneling field DPCD reading after all other RX caps are read.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Cruise <Cruise.Hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../dc/link/protocols/link_dp_capability.c    | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 9dabaf682171..ce9d799d2386 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1632,13 +1632,6 @@ static bool retrieve_link_cap(struct dc_link *link)
 				sizeof(link->dpcd_caps.lttpr_caps.phy_repeater_cnt));
 	}
 
-	/* Read DP tunneling information. */
-	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
-		status = dpcd_get_tunneling_device_data(link);
-		if (status != DC_OK)
-			dm_error("%s: Read tunneling device data failed.\n", __func__);
-	}
-
 	dpcd_set_source_specific_data(link);
 	/* Sink may need to configure internals based on vendor, so allow some
 	 * time before proceeding with possibly vendor specific transactions
@@ -1711,7 +1704,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 		link->dpcd_caps.dprx_feature.raw = dpcd_dprx_data;
 
 		if (status != DC_OK)
-			dm_error("%s: Read DPRX caps data failed.\n", __func__);
+			dm_error("%s: Read DPRX feature list failed.\n", __func__);
 
 		/* AdaptiveSyncCapability  */
 		dpcd_dprx_data = 0;
@@ -1726,15 +1719,13 @@ static bool retrieve_link_cap(struct dc_link *link)
 		link->dpcd_caps.adaptive_sync_caps.dp_adap_sync_caps.raw = dpcd_dprx_data;
 
 		if (status != DC_OK)
-			dm_error("%s: Read DPRX caps data failed. Addr:%#x\n",
+			dm_error("%s: Read DPRX feature list_1 failed. Addr:%#x\n",
 					__func__, DP_DPRX_FEATURE_ENUMERATION_LIST_CONT_1);
 	}
-
 	else {
 		link->dpcd_caps.dprx_feature.raw = 0;
 	}
 
-
 	/* Error condition checking...
 	 * It is impossible for Sink to report Max Lane Count = 0.
 	 * It is possible for Sink to report Max Link Rate = 0, if it is
@@ -1918,6 +1909,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
 		DC_LOG_DP2("128b/132b encoding is supported at link %d", link->link_index);
 
+		/* Read 128b/132b suppoerted link rates */
 		core_link_read_dpcd(link,
 				DP_128B132B_SUPPORTED_LINK_RATES,
 				&link->dpcd_caps.dp_128b_132b_supported_link_rates.raw,
@@ -1965,6 +1957,13 @@ static bool retrieve_link_cap(struct dc_link *link)
 			link->dpcd_caps.max_uncompressed_pixel_rate_cap.raw,
 			sizeof(link->dpcd_caps.max_uncompressed_pixel_rate_cap.raw));
 
+	/* Read DP tunneling information. */
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+		status = dpcd_get_tunneling_device_data(link);
+		if (status != DC_OK)
+			dm_error("%s: Read DP tunneling device data failed.\n", __func__);
+	}
+
 	retrieve_cable_id(link);
 	dpcd_write_cable_id_to_dprx(link);
 
-- 
2.43.0

