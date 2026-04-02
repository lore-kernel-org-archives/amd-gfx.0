Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E7DD6AAF8
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 270E110F2E6;
	Thu,  2 Apr 2026 18:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oIrp3eCX";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD44410F2E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qdtrax09KbB4rIRyW96zTvMTiDl5YcDMTMIrRTa/mBJ6KzgDiUx9dD3djm4g2N20QnkmRgrd6gmPl4pp0Toln1h5DnriTbQ+MxrNNcNkmFF9k58+1APrwNjLtmbvqmDpvi4uahxWvSrYmXzNFsv6e7cIcZEQxT6ZFW7lkqvOoEZGSmvbcSZHiM+ncgOOsK6ki1r3qqX3A+PCYl+7SqOIkhIzPzMhme7QkFSPI5rVgHET/rYnNX9aC0Z0Cix1VtkLjY+4Ax6JCCiBdL8FQItu3TqagZz5CmhwKHj6f6RIEojof6jlKXEwhfmnbK1AmijT1FUhTcPmTjXmcNDpQL/rSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mx7vNcCu9mSRp5Hnve2j9FvA7AcV0QBn/PjiBT+03W0=;
 b=SXxoWde0SUJysX7N/K5Q0DVRfW1Qlbs29+/t+avty5rBUfs600F/6jm2USRxzNmaSp+WPkXvf12qW5MZLFWZb5CW+hTbMyz2ARmz2JE7cSOsrTBXb+xssbrpAqHwYP3DmNXt2rniaWIVuFNuwdWdfpFR6oz/fODle6bes1qkS6O0bWZ8NXjgJfgPjlrvNclPh4RnAEoxSDA1pASsMCg5yXKxpJzVBZJRBVxJJqkY513wCXDtzKTqDIENvEjB47y13p/QICF7/CriLwjl7NlTxUk0X07hMv8qfIVnmMFcN+ZwMBIU1heB93Y5y1UbAMmjhdqbSV6h+DRrt9GYssTiGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx7vNcCu9mSRp5Hnve2j9FvA7AcV0QBn/PjiBT+03W0=;
 b=oIrp3eCXW7wJnN8XwE5n4widoe9fMM81rEmtDdL829WuaCxNzbVD0fVFf1oERHodZOrdEW/Gdf/2J9nuP39S+qgGhvRoviwiLLQHbu8/HopChQWxflBay005sj7l9aOQxG1sKVR6JfU7P3ODAgXNF0FjYyuWhgHKEtEZ7MmvKOo=
Received: from CH2PR07CA0039.namprd07.prod.outlook.com (2603:10b6:610:5b::13)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 18:33:40 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::70) by CH2PR07CA0039.outlook.office365.com
 (2603:10b6:610:5b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.34 via Frontend Transport; Thu,
 2 Apr 2026 18:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:33:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Apr
 2026 13:33:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Apr
 2026 13:33:36 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:33:35 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, George Shen
 <george.shen@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 05/22] drm/amd/display: Remove unnecessary Freesync w/a from
 DCN32
Date: Thu, 2 Apr 2026 14:32:57 -0400
Message-ID: <20260402183314.1388755-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 3562d015-c37e-45ac-4751-08de90e65c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: eJza5gujlC977fInxqGB/G2K2sJe+ajGSXZQTlTcaAXKE3k1fVoxBNM/5pI1WG3CBJHyz2icFLCpLQ6dUMggCd3blAFFIhyuRPS0FG32xn+iz/ETvAAqO+HAvr7ophmHVtzv0RXT+0v12m80Z/Xige1BjxcMVIWzyNYKteK6x+tpRbyST77yauNSDJjm5NlTaXAJMBDGM0tfKixgceD09Q6HRSxjPTKzMHuWO273lneSlP90iFHe7C1u6EeLwnFgisskPlB9N5dH5bcy+wvtz7K2UklIibOWeJbJgq/U1t+wfN54WmU/scoEzoje2yLpQk5nmoknTC6FkMXoXcgCamwl3G/mj3kNEWGhPnaZyQHLx5SJexdcvEaYDAc8mfyHl7srhxlb1n068ksywSYxavQuZyKXjISwyjs22T0/Wu1EE0aT9N5+yV2UrYc5MVREblTuTPsUxRdAmASiot8Pj7/qcc0Tr8pH9NhiRW62ZWilF9WsRy0/j9NoNM6mElOnjnyesfvP+cw4Lnd5gYZc4OawOWOe5iRCu9KU6AxeUlDshFbIAxLsr4voNMu1IUI4qWd01dHSN5Ej5t3EcNYCpDVZ8upH0h07XIN4GZidHEjapZ/C0NGvWyyaYaI0an0TbJWecLI6f9iN6yq/NlmXVa3zImASl31K9r7NGUYF5bMvHA5Sgy/R1N7RO2AHj5+mrgoIOdaWUtrCWsxZLaFeojOS22lkbR/Y84pQjpabawr5b9hJfV8+mpCEalWQx7IeJBozWLaNTQwe3i3vW/v+MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V3wyqGr3yHT9G+Zge7yOSJt8TA2etLwW6b4lBQ7Nt3EUx8YCb5IFSRnUlGUpWd8ZXSoztwsRgoPiAvofC8fVR/HIpm/7oCdsXDmoGd9JBm6r41fHqGtef3DlnVSB2ZvCPLKmP+sQrkMzI2nWAaK/IDqU4Xej1nQUaPHg2CcBCVe8dg5Y3y3N+UJNVcCd6wU7fRl7wYWY9NcRMBIcR673wSQqInHTca9RWJyiqQf3D7oE9frIwqUZK7LtSMqHg6BvLXJF1Men7wpauIzhcgj5qYnJ9PLNSKk+9JUN+Gs3ydDxOOPfbAFJCx5h+nomzqidcoPZP2YLHgXVEPusP+xfRvXVQPWcFwsupcUXTFLtooxt7LgqTXPGdiPdqJDemho8BbrPrb31Yth0Ggx69vTLA8523hM6fiypqsVExt2ocUgZ9KD4jild3yt3oIWUut1b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:33:40.0836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3562d015-c37e-45ac-4751-08de90e65c73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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

From: George Shen <george.shen@amd.com>

[Why/How]
A workaround was previously used for certain Freesync cases that would
override the vstartup_start value from DML to position the SDP
correctly. This is no longer needed in DCN32 and above, so remove the
workaround.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 37 -------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index e29497204df7..eb199215d298 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1610,38 +1610,6 @@ static bool is_dtbclk_required(struct dc *dc, struct dc_state *context)
 	return false;
 }
 
-static void dcn20_adjust_freesync_v_startup(const struct dc_crtc_timing *dc_crtc_timing, int *vstartup_start)
-{
-	struct dc_crtc_timing patched_crtc_timing;
-	uint32_t asic_blank_end   = 0;
-	uint32_t asic_blank_start = 0;
-	uint32_t newVstartup	  = 0;
-
-	patched_crtc_timing = *dc_crtc_timing;
-
-	if (patched_crtc_timing.flags.INTERLACE == 1) {
-		if (patched_crtc_timing.v_front_porch < 2)
-			patched_crtc_timing.v_front_porch = 2;
-	} else {
-		if (patched_crtc_timing.v_front_porch < 1)
-			patched_crtc_timing.v_front_porch = 1;
-	}
-
-	/* blank_start = frame end - front porch */
-	asic_blank_start = patched_crtc_timing.v_total -
-					patched_crtc_timing.v_front_porch;
-
-	/* blank_end = blank_start - active */
-	asic_blank_end = asic_blank_start -
-					patched_crtc_timing.v_border_bottom -
-					patched_crtc_timing.v_addressable -
-					patched_crtc_timing.v_border_top;
-
-	newVstartup = asic_blank_end + (patched_crtc_timing.v_total - asic_blank_start);
-
-	*vstartup_start = ((newVstartup > *vstartup_start) ? newVstartup : *vstartup_start);
-}
-
 static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 				       display_e2e_pipe_params_st *pipes,
 				       int pipe_cnt, int vlevel)
@@ -1756,11 +1724,6 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 			}
 		}
 
-		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
-			dcn20_adjust_freesync_v_startup(
-				&context->res_ctx.pipe_ctx[i].stream->timing,
-				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);
-
 		pipe_idx++;
 	}
 	/* If DCN isn't making memory requests we can allow pstate change and lower clocks */
-- 
2.34.1

