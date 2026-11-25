Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC0606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xUi+3efq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F5210F5A9;
	Wed, 25 Nov 2026 06:57:10 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010045.outbound.protection.outlook.com
 [40.93.198.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3390810F5A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjLG9z7s7v2yhR1KPDIvl6Y2jj2LF11462wp0lgn3Ax9YaWAESVUlY3lF6z0uyP34oi/myCqW1F3CC/E+SypvPG6n+sFrXMo4YGWIMUOFdCR7RyD0ukVdQlw700+aqa+6pYK/fw12fqm6KZ+hRCIzYPeu3x8vWRaoaHsGVeAfT1jxd9AedgZnR9m9KzkgsQJG1SHvQ7eQNSesLpJw0ULbFPVcbpqAQUTVYtP6mhz+tnSoyDp9IOLh7VB1YpmlfWFARaxpB+RUQvBWYZQevdkY8ZcNIPeQ776tESt3HW7aG39t6simkVifmPTRLBW4Yq2tAcxmyk2f7XtwF8s97d3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTL7rW7z6lAE4xFCpDccRPjVjdbdQRcS0AQT3Xbrzuk=;
 b=XxnUYc/lb/hUf53yG0mw/D+DG3Ro71av8BzXegVuDIFYLzZ1L3QoLm/lVQ7NaQLRj7dmTslAn0gy0mSo1hFe0Bo3J4JG2YPanIs1k0bytGtsGahtAxLPjGjyvsVcgStKWVEEu5FSgmMrM5dYMSiigqRcPAKt2FMaTZlsDvLBDWdf2aahuL+q+nW0COasNoKQ+zig/nh6Q5YlXgcvTZGhwKWjti2/1TaVefXjF+DGR+ScSTj3Kle6zdzk+sqtB2O5uNXKfePiFqZj+CTHCeADf+xWNgJfG/uPPn0dPVrvoF3jwHTyI2FXkM5FFAhyR8LQfypW697wOAC/zPIy609AVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTL7rW7z6lAE4xFCpDccRPjVjdbdQRcS0AQT3Xbrzuk=;
 b=xUi+3efqjGQQ+YoLEctqy5V8a9Z1L4fcJYV2xSQs3QS93nM8W9I2vqPzFXh1cDngdfWRa2Irj7mnHtLZoFWC9VosdL0dI7YVQDk7WlAKr/KyZ1Xub5B0iqxNW+eHQhvu0nG8Dz4L8TIInHFUCbV+9CnzNEiixfIWZPQZth1Cy3U=
Received: from MW4PR03CA0212.namprd03.prod.outlook.com (2603:10b6:303:b9::7)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Wed, 25 Nov
 2026 06:57:00 +0000
Received: from EA8PEPF00000006.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::22) by MW4PR03CA0212.outlook.office365.com
 (2603:10b6:303:b9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 06:57:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF00000006.mail.protection.outlook.com (10.167.249.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:57:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:56:59 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:56:59 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:56:50 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 12/27] drm/amd/display: Preserve bandwidth floors in overrides
Date: Wed, 25 Nov 2026 14:55:01 +0800
Message-ID: <20261125065631.3889665-13-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000006:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: 667a383e-ecec-4131-06d9-08df4ac14de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|30052699003|261009223027099003|18002099003|22082099003|3023799007|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026135527099003|261026121527099003|261026140227099003|261026130827099003|261021123027099003|261021133027099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021135927099003|261021130227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: D+/xLb9vVIaDY05NT2TP6nK1UbN39KmHbUQrBYsLyIG0j9smAqQ6Bf7Mufb+2xy7FiLIrbMGBhcxkpquMyj6AItaddcZxVDQ/Yamlq6yiVMcRS8cW8N4zyvYfFNwlD4L3CuvpRBKM9a+b8SujEkk2YgoxZcvVlgGw/gripPxvek8RPmoHDrh/jzw2kFq5tFT3U7ZMiRFiYeNmUY9koagMtN6y7VzPBO7CgDMo99bl18tv9aRa0hcHPf0Sm7SAYoloizJKy8hnFnGu7tQW4BU8IrLqmma661fAIvDdht5LZ3VrlkpR4yKhXvs+0PSVmI0ivB5GgioYWKKMX34CVtlaNdi+h3olyfW6hrfdDkYCf+NcPqmjADMmlJ5XRVCuuH8BYqUTD+EMjOBoP3icvgmHAmur2wsgsOJ4Hc1ORywgBJ7Pkt+aYc1TZ2a61JAcfa94mvLw7ptqABOjzSb6G8WRGJWLlZ9+CzdOjLufi289RV1nPopSgE/ULIbe8yABVEc/ugr8eoeWbe8NY2u6zvoZjoCxElO1Q8AUJKQFhjKNuyy+TJbcune4I/EEUAwazK7bNhOTAtwAixOx5C8XoYGu3PyhN9Ix3JLT9sYXzH6rLil+M5c8cT9rVZX+Czf5kuuB1o1LMujxUj4JX+y1zkEnQkS4d3CzkJZTHibkvHTZbMl6PPLRbkBVFJ2/4nKwyVtJ6Eul66hJFKPeG87/jw+Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(30052699003)(261009223027099003)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026135527099003)(261026121527099003)(261026140227099003)(261026130827099003)(261021123027099003)(261021133027099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021130227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ujfds+K0ECiorEyJiNuNMINqV4D3tH85rOjnqMyj9c9v5Qr1ZCrnnYhZxj5dnGN6iRYCqAj9Jl+nZ+q9Vc+bqnXNArKh0ZuNExjszr1wDN0fLjZKWJmuQjuQ7OszNSitYEo3HrdlVOeicKXiGfrlZ0kFTjTQS7tz5lWPIl8iiA+tkSVnYx9d1lg0MEUK06r+dRgS32xSfpL1wZhCls/BDtYdgKpx+CnRi2h4vyA/aHe8MHwOOuNx8SSdELyOdgLIax/lyPGD3gmD5XHP94nRTMBXmd/hN3h33sHhL0DB+LwM8KaFjAUiWoBqvEoYfX57fnkdtT77CX8l0bwqvRB3PZQFRLTT1hLd/NXUIO8y0vk/SLlHZ9mQDwMnvt6/ZlVgoYne1GJ5NOcjr43atCcNvgqn4JV6gQnCeapVePohh3TE1oJsOe51wIpAOd+sqQyH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:57:00.4549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667a383e-ecec-4131-06d9-08df4ac14de5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000006.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URG_BIZ,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
Bandwidth overrides must respect each current-state requirement
while allowing descending requests to release previous peak votes.

[How]
Recompute nominal and urgent requests from their corresponding
current-state floors and the capped input on every call. Restore
the state values when the request is zero.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c   | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index f801f3337e5d..9556da79cdce 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -1614,23 +1614,27 @@ static unsigned int dcn60_override_memory_bandwidth_request(
 	struct dc_clocks new_clocks;
 	unsigned int max_bw_kbps;
 	unsigned int capped_bw_kbps;
+	unsigned int original_nominal_bw_kbps = dc->current_state->bw_ctx.bw.dcn.clk.utm_nominal_bandwidth_lb_KBps;
+	unsigned int original_urgent_bw_kbps = dc->current_state->bw_ctx.bw.dcn.clk.utm_urgent_bandwidth_lb_KBps;
 	int num_steps;
 
 	memcpy(&new_clocks, &clk_mgr_base->clks, sizeof(struct dc_clocks));
 
 	if (bw_kbps == 0) {
-		/* Clearing the override restores the request of the committed mode. */
-		new_clocks.utm_nominal_bandwidth_lb_KBps =
-				dc->current_state->bw_ctx.bw.dcn.clk.utm_nominal_bandwidth_lb_KBps;
-		new_clocks.utm_urgent_bandwidth_lb_KBps =
-				dc->current_state->bw_ctx.bw.dcn.clk.utm_urgent_bandwidth_lb_KBps;
+		new_clocks.utm_nominal_bandwidth_lb_KBps = original_nominal_bw_kbps;
+		new_clocks.utm_urgent_bandwidth_lb_KBps = original_urgent_bw_kbps;
 	} else {
 		max_bw_kbps    = dcn60_get_max_active_utm_bandwidth_kbps(clk_mgr_base);
 		capped_bw_kbps = (bw_kbps > max_bw_kbps) ? max_bw_kbps : bw_kbps;
 
-		new_clocks.utm_nominal_bandwidth_lb_KBps = capped_bw_kbps;
-		if (new_clocks.utm_urgent_bandwidth_lb_KBps < capped_bw_kbps)
+		if (capped_bw_kbps > original_nominal_bw_kbps)
+			new_clocks.utm_nominal_bandwidth_lb_KBps = capped_bw_kbps;
+		else
+			new_clocks.utm_nominal_bandwidth_lb_KBps = original_nominal_bw_kbps;
+		if (capped_bw_kbps > original_urgent_bw_kbps)
 			new_clocks.utm_urgent_bandwidth_lb_KBps = capped_bw_kbps;
+		else
+			new_clocks.utm_urgent_bandwidth_lb_KBps = original_urgent_bw_kbps;
 	}
 
 	num_steps = dcn60_build_update_bandwidth_clocks_sequence(clk_mgr_base,
-- 
2.43.0

