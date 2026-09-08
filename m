Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A6CC79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B914310EB57;
	Tue,  8 Sep 2026 11:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3sDIvEAx";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A34E10EB56
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOHJcEaRWz/bIo6jke/MkEysaPReWHsgiNP8IpIDasetzO8tO2UHwkS4Diq4ftSowOtlXn9Dza3CV7w7xZMY9gK0BEZG9ifXyNOSSdZ+zMxXEzj6y9+voBEMJ1QejTuWtywLt/WKFpfXW6fNsEv4uQkf+bENSqDgD+2fbYErB1lWG7iYrxVfLzGYGWu1e4o15uQqSAYEdijqsApGmEOK7hJEhZ7riyjhnen3bcbfP3SJDGQQHokMCrd3UdpbIIbC1Z8X7UCwO5CFFC9VBDQT/JP0o2ix6+S7P6KLmSNacz5IiupI1/AaILcqdyVraNiibx3gcsS04MNqIl8z7B+/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lg9b4Kf3JxFJkTpB8V31o9fb4fLPmKA3+SZPVVxiuQ=;
 b=D1F7cj+cpZYNvWZO8UtQoZTIIlJeU2GxFvhyfwOD4ls/xYWw8WxHNNdFQJ0C6/hpHXStCQLih5NxwcK2TDiwIXirx3+QCElQBTxW+4cM1Cb7GXASqxPTtOqD29N082AqD/xgzkmpxuEvuETytxmA1g+UHfOjy2Uzpis6+iI/fExZcAE2dA59LC6FoIh+qmhQvDb4/q5lhWf2ITzk1Pw5iydIqy9mDH+5inz6kV3ibUadTXbrG4Q8NWHtzhKk9PU7SjDz7EgIsYHfIHkAAAu0vuZwYHX4pE2slJ9PEnKpVAYeV9irx7OQlKLzVOR3UvXVYT0RlunT2A7rrd9CGM4v9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lg9b4Kf3JxFJkTpB8V31o9fb4fLPmKA3+SZPVVxiuQ=;
 b=3sDIvEAx/rEZKBJjX/5VKyEiHM9S8kqU+gA4ejtRPrvGHqsbhI+To/ohVt7uMPBLes/O9K3p4HCQX682k1r6g+uibue8DU5z837gEhQc40L3NIZpelApv8LLZQHtos6/AHxWERiegh3ubjzTCKUYu0KSzADVhmBW49DT3jWqxZc=
Received: from BN0PR04CA0091.namprd04.prod.outlook.com (2603:10b6:408:ec::6)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:38:58 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::70) by BN0PR04CA0091.outlook.office365.com
 (2603:10b6:408:ec::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:38:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:38:58 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:38:50 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 35/66] drm/amd/display: Force DSC to 8bpp for MST DP tunneling
 over USB4
Date: Tue, 8 Sep 2026 19:31:28 +0800
Message-ID: <20260908113338.2433445-36-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 106d7e2a-438a-4a01-fc7d-08df0d9dc59f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9jtiiwkIbVGTM3I/rS3BavAnwMr51EhSvve1oIuzhcYBS0dlmmgdh8QTVrko8oRx6SS2biGxroHz3QCeaxrNzVRhnOYkUXiXeUeNRUJs9yoA6BpoiSu+cODS5zz/JoB3PWqls6raS8/l7ECtTaf1mF8UXjlvyX+kJWfa4HWEsmsLme5NVRBkuW1Zk4nnykTqHSnjceTUtJRo8mjAt8sNCDRL5Gmnn1pJvcfM7CfDxBy3eiCTIsinHgr0/QxXW4I/jNh0liS6JXuoQuUiR514K0lVo1y1F8SNV4cl2EqL7XMlP7CsXjYfcSLtmmHAlH42JMjlLj8+izoHGlMXZv5TJepyXyJ8yCaUOQ2h9azEPjNa9urL9Jn4iry2e8M50ktKTWJcdN/AeyMLwy9s9qdVba8IzCdYyesAl5qG9yrzyLuiPHeb31JmMhzZC5WrhShcwRxi5Zw8ugag9JvOi/V2WdXweDtXxdVEHxHXEXIJHfcGW3X72ywsHAa8ZZYnB5HN3ZeN4nC9Xa7OLA5Rlwval7yy3CvVX7mVVxdERwRZnafPv+L43MKgD94Z18yT6VGOQ6rOGaqKJeaNo25OwvXj7ulWJzuOdjAoJ7c80TLlTuUF/yDrXln3e5o3mVsSOGxHF3ypenh5MADzj41S5yx/Ig8AMLgyx2hO6GiPoJEUbFRNSFim6ppl4NceUbWCKD7RlH2ir1DyjgPdn4H1eppHdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aHsdxF3nmkq8pDckMdk6b+ZBTNYHE9q/7ZtclyL14UYXOymGzVwQjYInIOMBA1lxZ9waT/JlBi1q+Mht4xFwce1I+rlK9mNCzb1W26IgZ31hxfD3qqsmtlqKDJBR1ySbVK6nYMGArCnSVq73XqXfPEMuWHMDgBGY7hRaeDMie16kwv7UNA+Jr38Ta5hw3xANPJGSotDNwiP15G9rMtB8hb2qTfw2eMQXFDcFSpRZACJm1veD/6qMKwbOg98GB/30PshJduJ7ziWUvF87c/lPSfLvfpsve0DJwBOH++7HJTyibV6GL7dr+Eo9VVocb1BbXH16BsxQ2Y6xWioQk/g8uUudNDVWsk4LwOYlT9w3bbmcoYfa/UTLT5MWUWt4Ic4xIOD0NAQqKste/DSICMtzXjRzvRR+fur/IedqZ1Mia6qrjUye0npujP/uqcyFNdgN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:38:58.6135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 106d7e2a-438a-4a01-fc7d-08df0d9dc59f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

Commit "drm/amd/display: Force DSC to 8bpp for SST DP tunneling over USB4"
forces DSC and caps the target to 8 bpp for SST streams on a USB4 DPIA
link with bandwidth allocation enabled.  The MST DSC fairness path does
not honor that policy: it derives the bpp range purely from the timing's
DSC policy and picks the highest bpp the native DP link can carry, which
overflows the smaller USB4 tunnel budget on a dock that fans out via an
internal MST hub.

Apply the equivalent policy in compute_mst_dsc_configs_for_link(): when
the link is a USB4 DPIA with BW allocation enabled, force DSC on
(so the fairness pass does not leave a stream uncompressed just because
the native link looks large enough) and pin the target to the minimum
bpp (so the compressed stream fits the tunnel and reserves headroom for
the other tunnels on the same host router).

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index b6b7fd7f8bca..a5b15bef8aa0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1375,6 +1375,10 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_commit *state,
 		params[count].num_slices_v = aconnector->dsc_settings.dsc_num_slices_v;
 		params[count].bpp_overwrite = aconnector->dsc_settings.dsc_bits_per_pixel;
 		params[count].compression_possible = stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported;
+		if (params[count].compression_possible &&
+		    dc_link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+		    dc_link->dpia_bw_alloc_config.bw_alloc_enabled)
+			params[count].clock_force_enable = DSC_CLK_FORCE_ENABLE;
 		dc_dsc_get_policy_for_timing(params[count].timing, 0, &dsc_policy, dc_link_get_highest_encoding_format(stream->link));
 		is_frl_endpoint_present = get_conv_frl_bw(aconnector, &frl_conv_bw_in_kbps, &frl_conv_dsc_bw_in_kbps);
 		if (stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported &&
@@ -1386,7 +1390,10 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_commit *state,
 				stream->sink->ctx->dc->res_pool->dscs[0],
 				stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
 				dsc_policy.min_target_bpp * 16,
-				dsc_policy.max_target_bpp * 16,
+				(dc_link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+				 dc_link->dpia_bw_alloc_config.bw_alloc_enabled) ?
+					dsc_policy.min_target_bpp * 16 :
+					dsc_policy.max_target_bpp * 16,
 				&stream->sink->dsc_caps.dsc_dec_caps,
 				&stream->timing,
 				dc_link_get_highest_encoding_format(dc_link),
-- 
2.43.0

