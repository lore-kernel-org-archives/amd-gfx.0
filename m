Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF7BC3ABCC
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFA0F10E507;
	Tue, 13 May 2025 11:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tMjNIXMu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F67F10E507
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au0Vb3LuxfmXpf6fHop51JbF0z+qQgKmONhMgWSmNaOSl6kTllbst4jli0EkXJWUXRjPEyKJwskbzwBW3BTwPzRQ3MsJtrzZWqJNXXcKOuB4ts8YJSiy2UnTgsABBkCuz6x6GbrbpwU0w7/bKTRaO/whjurQ4We26KQXlLrflXGYef9F7XdMNiTMkZcdeDbBZyCJp/iIVn2jSu9fzmFRVdA+EktrMG/MAFuf8TrAhLstbQNEkL8XE2I1HveoRzTMHftaSBad+Tg0+tdg/sAnEPvE9p6u/rznOOJr3vkCmeQe8PBHNWEVRWUkLAc96Wl/+KKARtIM1iCzze1AAEyGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4GMkOP6vvrVPCmBFmPJ0zwq0J6fUSdrsaiT76Q7VCg=;
 b=bp+9mZAZUMnTrl46YxBlh6QLrSitMtIyBtsDGBrI5V9nC50nkZP10p85p2KHAzNrDzO8QD9gmL6gZfgk7OEZ2Xi7rnpMEu704NMvzNgf/mtGfKfxjAvZKZPVNk7ha/INHpzIvgPNnHTOYWVUn/CuEOjU3YJ2EsGOnUyp0JOPylZ9VVpcqCnYF2Ewo2ToO0WdDs4sxHn0Aikrnh51ezAZsKkf3eJtnK53JAfrxkY3quywceGuvXLGNSKkxeGq2DcwlxqHv4Uos/P7d2Yy1DCUFYQ6jsxZJNrWxNPf9w2Di1p46sICeU29mstQ0zEKxpUPT6HSYd8NqJGn1Vzw0kEuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4GMkOP6vvrVPCmBFmPJ0zwq0J6fUSdrsaiT76Q7VCg=;
 b=tMjNIXMuZYseWQT2HypTUhh3dPk8KnYOdRzCr/NPNCtn8QrrdPzUkFmlmksvBgkddN+hqGa+Xxh56rZE+OEWpBEqdvSLQSx6L6CI6u7XjAsxrH38OiIMvwJsra58X2dZRdPYlf18BDToIUC8tS8Hf6YA3ZumBTX8qiTmDMc1Xvw=
Received: from DM6PR02CA0107.namprd02.prod.outlook.com (2603:10b6:5:1f4::48)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 13 May
 2025 11:25:26 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::85) by DM6PR02CA0107.outlook.office365.com
 (2603:10b6:5:1f4::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Tue,
 13 May 2025 11:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:25:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:25:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:25:25 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 13 May 2025 06:25:22 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>
Subject: [PATCH 10/11] drm/amd/display: [FW Promotion] Release 0.1.11.0
Date: Tue, 13 May 2025 19:24:38 +0800
Message-ID: <20250513112439.2295366-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
References: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: fea17e9a-5e51-4925-788d-08dd9210dbb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zQ9oq68LpgTc/6UMbtmwscMT8eLvAGUKoF3b74GvgH6JoOFsgUcXsmqJ2/YE?=
 =?us-ascii?Q?+sVuaWiDe24zFkn1BXb1xvdZh1Lgk6A8jupNwQmr1K18mHybeeYLUnDlKxKP?=
 =?us-ascii?Q?gZy8vuFVon3hukZdf7drcFrMdhIIr5AAB/Tj6hCg3jNVuYtbVzeP95ociBKN?=
 =?us-ascii?Q?0Y2XUAwxGW8/D6fC+4zrbghSnHOnK3L161NH9BrvUpKHIgE85Mv4JKTMfbqo?=
 =?us-ascii?Q?t3ctDtwJYB1mdBVWLodFfi6GGtUPQWXEni4cNQTzkOlK8hxCsxJ6je/N07GZ?=
 =?us-ascii?Q?JLWgYyN3Imu5AY8RfdhamB9oLUgmhuBEGP5jy4uKfZVNEF1Xv1xG26MxEQ1h?=
 =?us-ascii?Q?i1wJRMJyOGEV4spa6I6ILmW1uRl3N0gkLg0upw5jyzn5ISP3xNKo9VsbQ3FO?=
 =?us-ascii?Q?Z8nuFMEzA31zOr6Lj07mMHBeML6pUSTrlDLlj3LMxz3OWg/E6ul4NVbACuZl?=
 =?us-ascii?Q?gcmec27aNEs6j8tEtKIamtadbUwwHXK25D0WOY97JfvzFEmO+ukR+z95Zw1X?=
 =?us-ascii?Q?vZRHGTKD2RsDyssHpXFgx+OQq4Azy1xrowdidtD1FyE1qcL15kYQpo62LHzL?=
 =?us-ascii?Q?w7a7RcMvZlknOrnJ5MfT9nRkmVRT3I7QfqIPrwMSYohUx8rAEOu1buTC7w0R?=
 =?us-ascii?Q?6Fia3h5dxBeVu3jE10YZ0Zl4LgSpoIjImtISBvQdSlmAlkyeRmG6tmXsPxdv?=
 =?us-ascii?Q?Gymo2h2TD7AzWQUdJoJ3cPkxff+fCbUpvFCaRofZhr+UIwXVGiTVI+gZGFvZ?=
 =?us-ascii?Q?nee0XuFGeqyudVCCmvmQgaFOkVSf/dj1Y6XtcnWDyiB4wwHTyUo8vfrydZ/e?=
 =?us-ascii?Q?dxIq5QGn5mapLFhAXxIqdymmwADqNgT5LcH2nUtXDPvaCCuMH1G0MOP8/New?=
 =?us-ascii?Q?xmksN+LK6BIhjHaEStarzi98Yd3cexXVYiE2dWMo3EOGopRR5yVjzH1lYkst?=
 =?us-ascii?Q?j4O3w5Vu+gP86az8/UoCGNyQUIDarPlxnjFFNJ79mTEjQcb3l5DqGZeJXT9H?=
 =?us-ascii?Q?8R4ICN9RMUF5G6/zwVmGT45/0ZS+wXlVwSU0DBM9+hlxi/BCmPDV0kgy4M/z?=
 =?us-ascii?Q?6DPxXYFEzRxHPnEkfl/J8UeLp4ejJibFFX4XZMhs6+MW/pD5Ry4gdvfXQX7T?=
 =?us-ascii?Q?uB/ED4xbom+ICGKypvlJuDNwrlhSZBg9uNMjoUyu/AksKnOcgEMRJcSSG4e9?=
 =?us-ascii?Q?I10xHSUWev74z89OkFk2RHgsLzmo4FI1WP8UnIilkYCDSaBEUoM2cldRe8lD?=
 =?us-ascii?Q?IllHWTpAEMdmUZHWKuL0moWhi6QwKSXXSmio66NJIlDYs6B3Q15kGg3chgOl?=
 =?us-ascii?Q?tZIDI9UbVGCF/hSLal0UWBLrcVVYZop1F1A+9GUypBvnBSIgAyEyNmstfw13?=
 =?us-ascii?Q?8gePzkfu6nKfIQRJ5Xs1S2J+nRjPm410pfQrib+Ftc1YGdEXD1vyxS3obxRr?=
 =?us-ascii?Q?esahBQwkLLwVw0xq/9pv76fCu1bmewVcAYSqEFCh7xXm+88tC4FCh9HqKrW+?=
 =?us-ascii?Q?qYsiFg+fa/h2WRzv/R+jKGXl0yamp2P/NOp2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:25:25.8635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fea17e9a-5e51-4925-788d-08dd9210dbb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Refactoring some DMUB related structs and enum.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b66bd10cdc9b..57fa05bddb45 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2139,6 +2139,11 @@ union dmub_cmd_fams2_config {
 	} stream_v1; //v1
 };
 
+struct dmub_fams2_config_v2 {
+	struct dmub_cmd_fams2_global_config global;
+	struct dmub_fams2_stream_static_state_v1 stream_v1[DMUB_MAX_STREAMS]; //v1
+};
+
 /**
  * DMUB rb command definition for FAMS2 (merged SubVP, FPO, Legacy)
  */
@@ -2147,6 +2152,22 @@ struct dmub_rb_cmd_fams2 {
 	union dmub_cmd_fams2_config config;
 };
 
+/**
+ * Indirect buffer descriptor
+ */
+struct dmub_ib_data {
+	union dmub_addr src; // location of indirect buffer in memory
+	uint16_t size; // indirect buffer size in bytes
+};
+
+/**
+ * DMUB rb command definition for commands passed over indirect buffer
+ */
+struct dmub_rb_cmd_ib {
+	struct dmub_cmd_header header;
+	struct dmub_ib_data ib_data;
+};
+
 /**
  * enum dmub_cmd_idle_opt_type - Idle optimization command type.
  */
@@ -2170,6 +2191,11 @@ enum dmub_cmd_idle_opt_type {
 	 * DCN hardware notify power state.
 	 */
 	DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE = 3,
+
+	/**
+	 * DCN notify to release HW.
+	 */
+	 DMUB_CMD__IDLE_OPT_RELEASE_HW = 4,
 };
 
 /**
@@ -2931,8 +2957,9 @@ enum dmub_cmd_fams_type {
 	 */
 	DMUB_CMD__FAMS_SET_MANUAL_TRIGGER = 3,
 	DMUB_CMD__FAMS2_CONFIG = 4,
-	DMUB_CMD__FAMS2_DRR_UPDATE = 5,
-	DMUB_CMD__FAMS2_FLIP = 6,
+	DMUB_CMD__FAMS2_IB_CONFIG = 5,
+	DMUB_CMD__FAMS2_DRR_UPDATE = 6,
+	DMUB_CMD__FAMS2_FLIP = 7,
 };
 
 /**
@@ -5926,8 +5953,11 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__PSP_ASSR_ENABLE command.
 	 */
 	struct dmub_rb_cmd_assr_enable assr_enable;
+
 	struct dmub_rb_cmd_fams2 fams2_config;
 
+	struct dmub_rb_cmd_ib ib_fams2_config;
+
 	struct dmub_rb_cmd_fams2_drr_update fams2_drr_update;
 
 	struct dmub_rb_cmd_fams2_flip fams2_flip;
-- 
2.34.1

