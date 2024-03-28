Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCD9CD11DD
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAFD410E677;
	Thu, 28 Mar 2024 19:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AFJDXyCq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ABBD10E4F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDTLrdel3qVQNZVMTvkMjB8n251upW5Oxj8F4y8iFNQFlVFSpQOjeThey4CLbBudPWB54PrnrHU6CR8k59mGUgP0UL2v7nZJgd/v5ZjBOhbIYl/a7P4EtpjSGDYxPqVW5aAcOT27cPyh4DqQohEkdJJMnETsrWe3uq1qIPbFwjt18+BZsz+ugU9FRNoye1kvXIGa01tIjXLS1rqCtVJLaGwjU5P09HIsIhU9WeipnmzKfm52mFM/eodMAivma5wPR+Z9P56eF6+awPyRtBMH9ZqwuCKPK8EkYF0WDtSlG19QRt+LYQlJg3ypWrBe7XccFCe4fwl9hK6c6LMOM0URnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxB1EY8pYMiKDhC1OgQ2aHegbOdJ+Zj74nU4NBiJGpY=;
 b=bC1DA/hXC84R+wpKsdTWH4ic7AC14iC2I+DlswUrpzPkGJiCMAyuHjHbf6/KK6GEuvGuTegGfd8RB2kUgGDH50g4JM22JpgURFTR4i+YFKFyzFATkB/toFryOW4qyrisF8AIFUZns0ThQlfu8NSCYjkUSWXIZKcZGWc8lD2J0ToVqd86x6WDPsQxWATkjU93+a+IlCr3Hvz2ShgcobeoSG2hh4+uCBgRA7Nak99c1Z+KcP0kzGB1dm+ElhIF0OuhtrShTWzlUTTLWqBGO6TFACOnx5fz7SrkKk6Aks8t0lzFuMaluhaJAtRdltyOihmzh/O+R5gxAMvFSNsTddLkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxB1EY8pYMiKDhC1OgQ2aHegbOdJ+Zj74nU4NBiJGpY=;
 b=AFJDXyCqWfnCEIc9Nswh3Wil+4ED1AhZIWbXAAu80S0h6J+M9SjbI18M5Y6cWJWHOhJIe13XXLWmleWRQmYoyxEIBTMGXuLYQdI3KBFxJVWIPRvHHqmcSFaJKmXu+6hVLdmQXuDZOG2TB5GxpANjBnsewZ9QsInozfnzZhtOIZA=
Received: from CH2PR14CA0052.namprd14.prod.outlook.com (2603:10b6:610:56::32)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 19:51:28 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::62) by CH2PR14CA0052.outlook.office365.com
 (2603:10b6:610:56::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:26 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:25 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>
Subject: [PATCH 02/43] drm/amd/display: Add timing pixel encoding for mst mode
 validation
Date: Thu, 28 Mar 2024 15:50:06 -0400
Message-ID: <20240328195047.2843715-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: d628bd9a-ddbf-4935-5ce6-08dc4f6074ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKHROZFL28xNZxjbtzkhsXS7sjX+VsW/SkBvyTT9YbsjydaWaYzTcrINydmmlO9UbSjRGjVrIzFmcskcAMKgJHB4fxdyVQn/3IXpc4IJZCtQrI2altry4325IkmV8rj2OnL98whkzRiVstlmhEVWNjfN/D13hKJUX8mKFnKutaWsHI7Gf98TQSQoCfHpTRIMqytT1lXCH9VUkHKuM73aZZwE8CB2Jx35G2KMAUiE0qiJjsQswjcOFXDwDMcK7L1a63MhnuJIn0An9f0jNTJQuP8OG7oWkRaYe4VrmXCbjrJXUP+mbmJ5jYUG8Y9rDgjSeHIHvoHc6snWUh0PSIWngtGaAuxQIFmCi6ATr3ImcELUHwowBFY+YZIG0waj15ts35I82VDDXlHHt+LKRrd8V0d/ITtG9Q/KBaK/yYiBPeYZVR67GDndOQXR1GhKzpY434DCU/xuAj92Xcfbk52VfmXhaRqnFoMc0sJEs6CEzZ5+9XNMxf6oVRiXuk7smzvslrDpyjywq++OfxZ2AgpCVRaFDRajtlV1U1u3kOLt+ypummf5SMfgyJgoYEpHzHshhWg9EsR/e0jjv30GDT3XpEte24cMGDvHCrDFVzvSilWMcSoXldSiehGnaGnL2fArQKCYzYH7o1g3ZaC8fbNXdzwvTVeQQ/3iMomEGmHqE2feSpOQ+NFzlUGsa9bKVdx31U9hW8gg5I+37hYPuQnt1wI3wY0ojXmnfmCuBfqAwzdSS6hxgpxJSXJw4O0IHQyy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:27.5660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d628bd9a-ddbf-4935-5ce6-08dc4f6074ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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

From: Hersen Wu <hersenxs.wu@amd.com>

[Why] Mode pbn is not calculated correctly because timing pixel encoding is
not checked within convert_dc_color_depth_into_bpc.

[How] Get mode kbps from dc_bandwidth_in_kbps_from_timing, then calculate
pbn by kbps_to_peak_pbn.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 35 ++++++++++++++++---
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 941e96f100f4..ad3170b72a47 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1601,7 +1601,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 	struct amdgpu_dm_connector *aconnector,
 	struct dc_stream_state *stream)
 {
-	int bpp, pbn, branch_max_throughput_mps = 0;
+	int pbn, branch_max_throughput_mps = 0;
 	struct dc_link_settings cur_link_settings;
 	unsigned int end_to_end_bw_in_kbps = 0;
 	unsigned int upper_link_bw_in_kbps = 0, down_link_bw_in_kbps = 0;
@@ -1651,11 +1651,36 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 			}
 		}
 	} else {
-		/* check if mode could be supported within full_pbn */
-		bpp = convert_dc_color_depth_into_bpc(stream->timing.display_color_depth) * 3;
-		pbn = drm_dp_calc_pbn_mode(stream->timing.pix_clk_100hz / 10, bpp << 4);
-		if (pbn > aconnector->mst_output_port->full_pbn)
+		/* Check if mode could be supported within max slot
+		 * number of current mst link and full_pbn of mst links.
+		 */
+		int pbn_div, slot_num, max_slot_num;
+		enum dc_link_encoding_format link_encoding;
+		uint16_t fec_overhead_multiplier_x1000 =
+			get_fec_overhead_multiplier(stream->link);
+		uint32_t stream_kbps =
+			dc_bandwidth_in_kbps_from_timing(&stream->timing,
+				dc_link_get_highest_encoding_format(stream->link));
+
+		pbn = kbps_to_peak_pbn(stream_kbps, fec_overhead_multiplier_x1000);
+		pbn_div = dm_mst_get_pbn_divider(stream->link);
+		slot_num = DIV_ROUND_UP(pbn, pbn_div);
+
+		link_encoding = dc_link_get_highest_encoding_format(stream->link);
+		if (link_encoding == DC_LINK_ENCODING_DP_8b_10b)
+			max_slot_num = 63;
+		else if (link_encoding == DC_LINK_ENCODING_DP_128b_132b)
+			max_slot_num = 64;
+		else {
+			DRM_DEBUG_DRIVER("Invalid link encoding format\n");
 			return DC_FAIL_BANDWIDTH_VALIDATE;
+		}
+
+		if (slot_num > max_slot_num ||
+			pbn > aconnector->mst_output_port->full_pbn) {
+			DRM_DEBUG_DRIVER("Mode can not be supported within mst links!");
+			return DC_FAIL_BANDWIDTH_VALIDATE;
+		}
 	}
 
 	/* check is mst dsc output bandwidth branch_overall_throughput_0_mps */
-- 
2.34.1

