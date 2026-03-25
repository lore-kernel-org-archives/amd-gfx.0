Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D63FEA817
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5437510E7B3;
	Wed, 25 Mar 2026 07:10:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yG45Av6p";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010024.outbound.protection.outlook.com
 [52.101.193.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC01410E7B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngtu2QyrThRazazReS7wmIkRrmYkQyYvv2clyoqWU9Wtn09Jh7sxAggUFZAC296XbTdRaQN6H90aXtCsC3bjfVIDZgIgdX64nc0TS+rl9dUuX0G1b/dUG4ik9/PV4N5iZRlYy/6sb86qcSxsIGx2sWJj8Tg65TuI22ycxF8rO1TYGzEREfxLdxJabKixSbY9ydq8UDme4W3E1GwqYn7BdjcKu+wBYpRICoqp+8VRaTtHGYdnhwUYbNtRFl8bP6IrF/mJ7zQKa5c1pYJ7EX3k4cRR4qbGnK159iixsNW/9EWGQJcDHLm9GLRsNeh8OiNLeQjPQzRqfr+yHoorTa6ocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OnpAgFvNOTr5QGjL1mwTDvAGlpfOIWS/txQLip8X/g=;
 b=bNvlj1RhlsiggxeKObKJWVXsxWj7nqn4Kn131gbcBIaXl7bzfSw6QMch4QUuzniuqEdkOKQa79a8iuRdQyR/N5WFqPVfn4vmlznig2ecINAyIkGTcqTLRcN2QHJtwVPvM4Bs2XvENP2QUjgbC+Oddj2kkKp2z78FCiUGyVQeo088V58CiWOT4cZeOZnF1+6peoJM/IOV47mVOXBbRh4ebyX+knF11O6MyO8Gxp+8Srty6wn3AesTXzuoZIrsdXuQ/lHdl0IKVN/13A24c6MWweUh8Uks1LEPjSl9P2lAK4CQu9SjHhRIkyzKupkUdeWPubzkcXAu4UbjjFofJz74vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OnpAgFvNOTr5QGjL1mwTDvAGlpfOIWS/txQLip8X/g=;
 b=yG45Av6pZCo23YGmon0/jDuG541940HrgaFSVO+t8RMUliBj+r1U+MwLTlGZ2IrzFSVWZB2BVtEjyUzGwrfFCyUOndJWbCpQ9GdFLJZtrw644eBoR0RLtpBP+I0adEi0XJ0BEq2acb1uH25WidcRynNujtLqj8xvp12Uv7wWQzI=
Received: from BLAPR03CA0130.namprd03.prod.outlook.com (2603:10b6:208:32e::15)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 07:10:43 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::d3) by BLAPR03CA0130.outlook.office365.com
 (2603:10b6:208:32e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 07:10:43 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:10:17 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Austin Zheng <austin.zheng@amd.com>,
 "Chuanyu Tseng" <chuanyu.tseng@amd.com>
Subject: [PATCH 25/29] drm/amd/display: Fixed Silence complier warnings in dc
Date: Wed, 25 Mar 2026 15:06:31 +0800
Message-ID: <20260325071003.4022594-26-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f1c177-b723-4a71-795e-08de8a3da149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: n5/9IZ+/u4cbv/Jf5Ylj80CoHOFJXMjbZANH8QrhppEynNz8hOAnB7FguHTPPYQUWPO3hzYnQYvjAvRvdSvVups60Q1snliBK210DsH9Gr9bVrJ/CnnMr42mQRrv6JgYLDxCEcy1TVoWNMMCEnCfzE9ud7+yTISGDGyAzg2sDJ7cJGMqyIPDsP6XbaJxvI2/9+deH2QbDWJwkhP0BHNSBm8Y5+sq5Wc1RpkSCiNS1wvd6UnlSUHVfMMF+22PO9SqQwl5/Wc1jfwM8eNPkUYkQMmg6dSDjgOApDYdwIgUvTk0KykR72fQkkCdhNncS3A2cTymbXn5RZSlLTox/XqAzuLo8iGWsYM3d97NjUQS7uaboQHnN2aBbus2PZcXEfBdGASSKAwpau40B34LwqA6MILEndcppCKmFpZ2QLNjWUnmcQ1RfJfkinUQ+THJRz8MDvC2lb38TRsh7yX50Hn+6fCQIB97v3C7p2f46p2re3rYGgqLuTKPv8iL9FSJ4Nvmn/fLrrIhlmOWU6d8K25ff3BMNCst6w6k2RAAkh6AKwKBQJEelRT6sW+XUxKo80L8JWqFjfNGlkude/VjHwbHNNHbxZJPbEM9OrK+iSYFL/pn5hjKr+OdsKVBwTgvXvtFQz+nQhzCFn/VIb9VUJ3l6/2eKiwi2Hcyigpy2pwzTZ/JcVmONwDsKRsWkeNdnXmGQCpWvZf6qpd9V3pY/JI+p0bI+/JgBpIHtMEiFILh/+YOo9rPWMnRIvYoNXiIT42wlXpVmBLyBIOeG4LlDmDATQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iJ7yqwkoBl6aRb/JCu/N6Nw+4hqdj249aDt84WD2FsnRbOEfQmUFEJM/M008mRI1ZqyCV04zQSylmGrXJ4je0zwUaZOmQmUVqb8jXIV8w9F5H9Qtoco5vP8enNmy1TRAUBdpqlwSu8AXZYT0OqYGvbfbH5FbcnLaUmOmypLstSl5nfg4+WjntW9yyi2WEUSPLZ1l2P41f5ZVUWPQvGA5h3A+yjVUon6DhO4Q4xmvDLGnXqUtdWBUhbIHYGkXic86J7Oks74scDk/bMaD3PbhbuvPN7MC1bytGbHFpvGDqa7/HpL28j3RGV7Lq+nUC2IHyl3s3VIs5REQ9bMPijjTR3A8eviUfkF4UHIoIoChlxYD0xo2Yk7bXzy+CO+3iIGPL/R4UJK7yhN72iv5yiOwcw2UDXLGjp0W8ZkQCx6tZIw6qw1bPfVPSPhZzZ4CF8qc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:10:43.6302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f1c177-b723-4a71-795e-08de8a3da149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]
Resolve compiler warnings by marking unused parameters explicitly.

[How]
In .c and .h function definitions, keep parameter names
in signatures and add a line with `(void)param;` in function body

Preserved function signatures and avoids breaking code paths that
may reference the parameter under conditional compilation.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../drm/amd/display/dc/basics/fixpt31_32.c    |   1 +
 .../gpu/drm/amd/display/dc/basics/vector.c    |   1 +
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |   1 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |   9 ++
 .../drm/amd/display/dc/bios/command_table2.c  |   2 +
 .../bios/dce110/command_table_helper_dce110.c |   1 +
 .../dce112/command_table_helper2_dce112.c     |   1 +
 .../bios/dce112/command_table_helper_dce112.c |   1 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   1 +
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   1 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   3 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   3 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   3 +
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   3 +
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   3 +
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |   5 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  12 ++
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   1 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   7 ++
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   2 +
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   1 +
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |   2 +
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |   1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   2 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   4 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |   1 +
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |   3 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |   4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c  |   1 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |   2 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_sw.c   |   3 +
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c  |   1 +
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   1 +
 .../drm/amd/display/dc/dce/dce_mem_input.c    |   4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c  |   1 +
 .../amd/display/dc/dce/dce_stream_encoder.c   |   4 +
 .../drm/amd/display/dc/dce/dce_transform.c    |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |   1 +
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   1 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   1 +
 .../display/dc/dce110/dce110_mem_input_v.c    |  10 ++
 .../amd/display/dc/dce110/dce110_opp_csc_v.c  |   1 +
 .../display/dc/dce110/dce110_opp_regamma_v.c  |   2 +
 .../dc/dce110/dce110_timing_generator.c       |   9 ++
 .../dc/dce110/dce110_timing_generator_v.c     |   9 ++
 .../display/dc/dce110/dce110_transform_v.c    |   6 +
 .../amd/display/dc/dce112/dce112_compressor.c |   1 +
 .../dc/dce120/dce120_timing_generator.c       |   7 ++
 .../display/dc/dce80/dce80_timing_generator.c |   6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c  |   2 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  |   1 +
 .../dc/dio/dcn10/dcn10_stream_encoder.c       |   2 +
 .../dc/dio/dcn314/dcn314_dio_stream_encoder.c |   2 +
 .../dc/dio/dcn32/dcn32_dio_stream_encoder.c   |   2 +
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c   |   1 +
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |   3 +
 .../dc/dio/virtual/virtual_link_encoder.c     |  65 ++++++++--
 .../dc/dio/virtual/virtual_stream_encoder.c   | 111 +++++++++++++-----
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   1 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   1 +
 .../dc/dml/dcn20/display_mode_vba_20.c        |   4 +
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |   5 +
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |   5 +
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |   5 +
 .../dc/dml/dcn21/display_mode_vba_21.c        |  19 +++
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |   5 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   2 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |  23 ++++
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |   5 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |  24 ++++
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |   8 ++
 .../dc/dml/dcn314/display_mode_vba_314.c      |  24 ++++
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |   8 ++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   2 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  23 ++++
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   1 +
 .../drm/amd/display/dc/dml/display_mode_lib.c |   1 +
 .../display/dc/dml/display_rq_dlg_helpers.c   |  14 +++
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |   3 +
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |   1 +
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c  |  11 +-
 .../amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c   |   1 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   1 +
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |   1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   5 +
 .../drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c  |   1 +
 .../dc/gpio/dcn42/hw_translate_dcn42.c        |   1 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c |   1 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |   1 +
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   1 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |   1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   4 +
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |   2 +
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |   2 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |   2 +
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |   2 +
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   3 +
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |   1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  22 ++++
 .../amd/display/dc/hwss/dce120/dce120_hwseq.c |   4 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  21 ++++
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   9 ++
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   3 +
 .../amd/display/dc/hwss/dcn303/dcn303_hwseq.c |  11 ++
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   2 +
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   6 +
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   2 +
 .../dc/irq/dce110/irq_service_dce110.c        |   2 +
 .../display/dc/irq/dcn10/irq_service_dcn10.c  |   3 +
 .../display/dc/irq/dcn20/irq_service_dcn20.c  |   3 +
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |   3 +
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |   3 +
 .../dc/irq/dcn302/irq_service_dcn302.c        |   3 +
 .../dc/irq/dcn303/irq_service_dcn303.c        |   3 +
 .../display/dc/irq/dcn31/irq_service_dcn31.c  |   3 +
 .../dc/irq/dcn314/irq_service_dcn314.c        |   3 +
 .../dc/irq/dcn315/irq_service_dcn315.c        |   3 +
 .../display/dc/irq/dcn32/irq_service_dcn32.c  |   3 +
 .../display/dc/irq/dcn35/irq_service_dcn35.c  |   3 +
 .../dc/irq/dcn351/irq_service_dcn351.c        |   3 +
 .../display/dc/irq/dcn36/irq_service_dcn36.c  |   3 +
 .../dc/irq/dcn401/irq_service_dcn401.c        |   3 +
 .../display/dc/irq/dcn42/irq_service_dcn42.c  |   3 +
 .../display/dc/link/accessories/link_dp_cts.c |   2 +
 .../amd/display/dc/link/hwss/link_hwss_dpia.c |   4 +
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |   6 +
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |   1 +
 .../display/dc/link/hwss/link_hwss_virtual.c  |   6 +
 .../drm/amd/display/dc/link/link_detection.c  |   1 +
 .../drm/amd/display/dc/link/link_validation.c |   1 +
 .../dc/link/protocols/link_dp_training.c      |   2 +
 .../protocols/link_dp_training_128b_132b.c    |   1 +
 .../dc/link/protocols/link_dp_training_dpia.c |   6 +
 .../amd/display/dc/link/protocols/link_dpcd.c |   1 +
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c  |   4 +
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |   1 +
 .../drm/amd/display/dc/opp/dcn10/dcn10_opp.c  |   1 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |   4 +
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |   2 +
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |   1 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   1 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |   1 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   1 +
 .../dc/resource/dce100/dce100_resource.c      |   5 +
 .../dc/resource/dce110/dce110_resource.c      |   6 +
 .../dc/resource/dce112/dce112_resource.c      |   5 +
 .../dc/resource/dce120/dce120_resource.c      |   1 +
 .../dc/resource/dce80/dce80_resource.c        |   1 +
 .../dc/resource/dcn10/dcn10_resource.c        |   3 +
 .../dc/resource/dcn20/dcn20_resource.c        |   6 +
 .../dc/resource/dcn21/dcn21_resource.c        |   1 +
 .../dc/resource/dcn30/dcn30_resource.c        |   1 +
 .../dc/resource/dcn301/dcn301_resource.c      |   1 +
 .../dc/resource/dcn302/dcn302_resource.c      |   1 +
 .../dc/resource/dcn303/dcn303_resource.c      |   1 +
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +
 .../dc/resource/dcn314/dcn314_resource.c      |   1 +
 .../dc/resource/dcn315/dcn315_resource.c      |   1 +
 .../dc/resource/dcn316/dcn316_resource.c      |   1 +
 .../resource/dcn32/dcn32_resource_helpers.c   |   1 +
 .../dc/resource/dcn42/dcn42_resource.c        |   3 +
 .../dcn42/dcn42_soc_and_ip_translator.c       |   1 +
 173 files changed, 750 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
index 6073cadde76c..fa10f85df3db 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
@@ -503,6 +503,7 @@ struct fixed31_32 dc_fixpt_from_int_dy(unsigned int int_value,
 	unsigned int integer_bits,
 	unsigned int fractional_bits)
 {
+	(void)integer_bits;
 	struct fixed31_32 fixpt_value = dc_fixpt_from_int(int_value);
 
 	fixpt_value.value |= (long long)frac_value << (FIXED31_32_BITS_PER_FRACTIONAL_PART - fractional_bits);
diff --git a/drivers/gpu/drm/amd/display/dc/basics/vector.c b/drivers/gpu/drm/amd/display/dc/basics/vector.c
index b413a672c2c0..d4dcc077854d 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/vector.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/vector.c
@@ -56,6 +56,7 @@ static bool dal_vector_presized_costruct(struct vector *vector,
 					 void *initial_value,
 					 uint32_t struct_size)
 {
+	(void)ctx;
 	uint32_t i;
 
 	vector->container = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 82877f7b3b6f..9344a3e4a2fc 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2696,6 +2696,7 @@ static enum bp_result update_slot_layout_info(struct dc_bios *dcb,
 					      struct slot_layout_info *slot_layout_info,
 					      unsigned int record_offset)
 {
+	(void)i;
 	unsigned int j;
 	struct bios_parser *bp;
 	ATOM_BRACKET_LAYOUT_RECORD *record;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 550a9f1d03f8..d2fb9c0162e5 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -205,6 +205,7 @@ static enum bp_result bios_parser_get_src_obj(struct dc_bios *dcb,
 	struct graphics_object_id object_id, uint32_t index,
 	struct graphics_object_id *src_object_id)
 {
+	(void)index;
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 	unsigned int i;
 	enum bp_result bp_result = BP_RESULT_BADINPUT;
@@ -765,6 +766,7 @@ static enum bp_result bios_parser_get_device_tag(
 	uint32_t device_tag_index,
 	struct connector_device_tag_info *info)
 {
+	(void)device_tag_index;
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 	struct atom_display_object_path_v2 *object;
 
@@ -809,6 +811,7 @@ static enum bp_result get_ss_info_v4_1(
 	uint32_t index,
 	struct spread_spectrum_info *ss_info)
 {
+	(void)index;
 	enum bp_result result = BP_RESULT_OK;
 	struct atom_display_controller_info_v4_1 *disp_cntl_tbl = NULL;
 	struct atom_smu_info_v3_3 *smu_info = NULL;
@@ -897,6 +900,7 @@ static enum bp_result get_ss_info_v4_2(
 	uint32_t index,
 	struct spread_spectrum_info *ss_info)
 {
+	(void)index;
 	enum bp_result result = BP_RESULT_OK;
 	struct atom_display_controller_info_v4_2 *disp_cntl_tbl = NULL;
 	struct atom_smu_info_v3_1 *smu_info = NULL;
@@ -977,6 +981,7 @@ static enum bp_result get_ss_info_v4_5(
 	uint32_t index,
 	struct spread_spectrum_info *ss_info)
 {
+	(void)index;
 	enum bp_result result = BP_RESULT_OK;
 	struct atom_display_controller_info_v4_5 *disp_cntl_tbl = NULL;
 
@@ -1604,6 +1609,8 @@ static uint32_t bios_parser_get_ss_entry_number(
 	struct dc_bios *dcb,
 	enum as_signal_type signal)
 {
+	(void)dcb;
+	(void)signal;
 	/* TODO: DAL2 atomfirmware implementation does not need this.
 	 * why DAL3 need this?
 	 */
@@ -3536,6 +3543,8 @@ static uint16_t bios_parser_pack_data_tables(
 	struct dc_bios *dcb,
 	void *dst)
 {
+	(void)dcb;
+	(void)dst;
 	// TODO: There is data bytes alignment issue, disable it for now.
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index f2b1720a6a66..17ef515c6c69 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -783,6 +783,8 @@ static enum bp_result external_encoder_control_v3(
 	struct bios_parser *bp,
 	struct bp_external_encoder_control *cntl)
 {
+	(void)bp;
+	(void)cntl;
 	/* TODO */
 	return BP_RESULT_OK;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce110/command_table_helper_dce110.c b/drivers/gpu/drm/amd/display/dc/bios/dce110/command_table_helper_dce110.c
index 3099128223df..cec61c9d7263 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce110/command_table_helper_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce110/command_table_helper_dce110.c
@@ -94,6 +94,7 @@ static uint8_t hpd_sel_to_atom(enum hpd_source_id id)
 
 static uint8_t dig_encoder_sel_to_atom(enum engine_id id)
 {
+	(void)id;
 	/* On any ASIC after DCE80, we manually program the DIG_FE
 	 * selection (see connect_dig_be_to_fe function of the link
 	 * encoder), so translation should always return 0 (no FE).
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
index 349f0e5d5856..478465fba224 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
@@ -93,6 +93,7 @@ static uint8_t hpd_sel_to_atom(enum hpd_source_id id)
 
 static uint8_t dig_encoder_sel_to_atom(enum engine_id id)
 {
+	(void)id;
 	/* On any ASIC after DCE80, we manually program the DIG_FE
 	 * selection (see connect_dig_be_to_fe function of the link
 	 * encoder), so translation should always return 0 (no FE).
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper_dce112.c b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper_dce112.c
index 1a5fefcde8af..6b8a87f2c49e 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper_dce112.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper_dce112.c
@@ -91,6 +91,7 @@ static uint8_t hpd_sel_to_atom(enum hpd_source_id id)
 
 static uint8_t dig_encoder_sel_to_atom(enum engine_id id)
 {
+	(void)id;
 	/* On any ASIC after DCE80, we manually program the DIG_FE
 	 * selection (see connect_dig_be_to_fe function of the link
 	 * encoder), so translation should always return 0 (no FE).
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index f1a639328ab0..0340f6b9f157 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -78,6 +78,7 @@ int clk_mgr_helper_get_active_plane_cnt(
 		struct dc *dc,
 		struct dc_state *context)
 {
+	(void)dc;
 	int i, total_plane_count;
 
 	total_plane_count = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 4ad09b877b6e..c7c849b04a50 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -521,6 +521,7 @@ void dcn3_clk_mgr_construct(
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg)
 {
+	(void)pp_smu;
 	struct clk_state_registers_and_bypass s = { 0 };
 
 	clk_mgr->base.ctx = ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 051052bd10c9..deda0efe18be 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -329,6 +329,9 @@ bool dcn31_are_clock_states_equal(struct dc_clocks *a,
 static void dcn31_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
 {
+	(void)regs_and_bypass;
+	(void)clk_mgr_base;
+	(void)log_info;
 	return;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 0cb37827a62b..f677cfdafe4d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -395,6 +395,9 @@ bool dcn314_are_clock_states_equal(struct dc_clocks *a,
 static void dcn314_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
 {
+	(void)regs_and_bypass;
+	(void)clk_mgr_base;
+	(void)log_info;
 	return;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index c49268db85f6..7350406ffe63 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -247,6 +247,9 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 static void dcn315_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
 {
+	(void)regs_and_bypass;
+	(void)clk_mgr_base;
+	(void)log_info;
 	return;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 1769b1f26e75..6c228059be3c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -255,6 +255,9 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 static void dcn316_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
 {
+	(void)regs_and_bypass;
+	(void)clk_mgr_base;
+	(void)log_info;
 	return;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 36d0c1e2014d..f427154a54f8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -872,6 +872,7 @@ static uint32_t dcn32_get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mg
 static void dcn32_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
 {
+	(void)log_info;
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	uint32_t dprefclk_did = 0;
 	uint32_t dcfclk_did = 0;
@@ -1145,6 +1146,7 @@ void dcn32_clk_mgr_construct(
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg)
 {
+	(void)pp_smu;
 	struct clk_log_info log_info = {0};
 
 	clk_mgr->base.ctx = ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 306016c1f109..fa284523d8a4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -333,6 +333,7 @@ bool dcn401_is_dc_mode_present(struct clk_mgr *clk_mgr_base)
 static void dcn401_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
 {
+	(void)log_info;
 		struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 		uint32_t dprefclk_did = 0;
 		uint32_t dcfclk_did = 0;
@@ -525,6 +526,7 @@ static void dcn401_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr
 			struct dc_state *context,
 			int ref_dtbclk_khz)
 {
+	(void)ref_dtbclk_khz;
 	int i;
 	struct dccg *dccg = clk_mgr->dccg;
 	struct pipe_ctx *otg_master;
@@ -614,6 +616,7 @@ static void dcn401_update_clocks_update_dentist(
 		struct clk_mgr_internal *clk_mgr,
 		struct dc_state *context)
 {
+	(void)context;
 	uint32_t new_disp_divider = 0;
 	uint32_t new_dispclk_wdivider = 0;
 	uint32_t dentist_dispclk_wdivider_readback = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index 97f182bfc9ca..ec888aed207d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -158,6 +158,9 @@ void dcn42_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 		struct dc_state *context,
 		int ref_dtbclk_khz)
 {
+	(void)clk_mgr;
+	(void)context;
+	(void)ref_dtbclk_khz;
 	/* DCN42 does not implement set_dtbclk_dto function, so this is a no-op */
 }
 
@@ -835,6 +838,7 @@ void dcn42_set_low_power_state(struct clk_mgr *clk_mgr_base)
 
 void dcn42_exit_low_power_state(struct clk_mgr *clk_mgr_base)
 {
+	(void)clk_mgr_base;
 
 }
 
@@ -937,6 +941,7 @@ unsigned int dcn42_get_max_clock_khz(struct clk_mgr *clk_mgr_base, enum clk_type
 
 int dcn42_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 {
+	(void)clk_mgr_base;
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	uint32_t dispclk_wdivider;
 	int disp_divider;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2f938379aec7..bbd5891ab77f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1134,6 +1134,8 @@ static void disable_all_writeback_pipes_for_stream(
 		struct dc_stream_state *stream,
 		struct dc_state *context)
 {
+	(void)dc;
+	(void)context;
 	int i;
 
 	for (i = 0; i < stream->num_wb_info; i++)
@@ -1145,6 +1147,8 @@ static void apply_ctx_interdependent_lock(struct dc *dc,
 					  struct dc_stream_state *stream,
 					  bool lock)
 {
+	(void)dc;
+	(void)context;
 	int i;
 
 	/* Checks if interdependent update function pointer is NULL or not, takes care of DCE110 case */
@@ -3008,6 +3012,7 @@ static struct surface_update_descriptor det_surface_update(
  */
 static void force_immediate_gsl_plane_flip(struct dc *dc, struct dc_surface_update *updates, int surface_count)
 {
+	(void)dc;
 	bool has_flip_immediate_plane = false;
 	int i;
 
@@ -3286,6 +3291,7 @@ static void copy_stream_update_to_stream(struct dc *dc,
 					 struct dc_stream_state *stream,
 					 struct dc_stream_update *update)
 {
+	(void)context;
 	struct dc_context *dc_ctx = dc->ctx;
 
 	if (update == NULL || stream == NULL)
@@ -3889,6 +3895,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 
 static bool dc_dmub_should_send_dirty_rect_cmd(struct dc *dc, struct dc_stream_state *stream)
 {
+	(void)dc;
 	if ((stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1
 			|| stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
 			&& stream->ctx->dce_version >= DCN_VERSION_3_1)
@@ -4689,6 +4696,7 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 		int surface_count,
 		bool *is_plane_addition)
 {
+	(void)srf_updates;
 
 	struct dc_stream_status *cur_stream_status = stream_get_status(dc->current_state, stream);
 	bool force_minimal_pipe_splitting = false;
@@ -5543,6 +5551,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		struct dc_stream_update *stream_update,
 		struct dc_state *state)
 {
+	(void)state;
 	bool ret = false;
 
 	dc_exit_ips_for_hw_access(dc);
@@ -5852,6 +5861,7 @@ void dc_lock_memory_clock_frequency(struct dc *dc)
 
 static void blank_and_force_memclk(struct dc *dc, bool apply, unsigned int memclk_mhz)
 {
+	(void)apply;
 	struct dc_state *context = dc->current_state;
 	struct hubp *hubp;
 	struct pipe_ctx *pipe;
@@ -6526,6 +6536,7 @@ void dc_query_current_properties(struct dc *dc, struct dc_current_properties *pr
 void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
 				 bool powerOn)
 {
+	(void)dc;
 	if (edp_link->connector_signal != SIGNAL_TYPE_EDP)
 		return;
 
@@ -6652,6 +6663,7 @@ void dc_get_underflow_debug_data_for_otg(struct dc *dc, int primary_otg_inst,
 void dc_get_power_feature_status(struct dc *dc, int primary_otg_inst,
 				struct power_features *out_data)
 {
+	(void)primary_otg_inst;
 	out_data->uclk_p_state = dc->current_state->clk_mgr->clks.p_state_change_support;
 	out_data->fams = dc->current_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 5b3695e72e19..db86e346307c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -249,6 +249,7 @@ void color_space_to_black_color(
 	enum dc_color_space colorspace,
 	struct tg_color *black_color)
 {
+	(void)dc;
 	switch (colorspace) {
 	case COLOR_SPACE_YCBCR601:
 	case COLOR_SPACE_YCBCR709:
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index e95d5b269738..66597a1f5b78 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1748,6 +1748,7 @@ enum dc_status resource_build_scaling_params_for_context(
 	const struct dc  *dc,
 	struct dc_state *context)
 {
+	(void)dc;
 	int i;
 
 	for (i = 0; i < MAX_PIPES; i++) {
@@ -1825,6 +1826,7 @@ int resource_find_free_pipe_used_as_sec_opp_head_by_cur_otg_master(
 		struct resource_context *new_res_ctx,
 		const struct pipe_ctx *cur_otg_master)
 {
+	(void)cur_res_ctx;
 	const struct pipe_ctx *cur_sec_opp_head = cur_otg_master->next_odm_pipe;
 	struct pipe_ctx *new_pipe;
 	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
@@ -1846,6 +1848,7 @@ int resource_find_free_pipe_used_in_cur_mpc_blending_tree(
 		struct resource_context *new_res_ctx,
 		const struct pipe_ctx *cur_opp_head)
 {
+	(void)cur_res_ctx;
 	const struct pipe_ctx *cur_sec_dpp = cur_opp_head->bottom_pipe;
 	struct pipe_ctx *new_pipe;
 	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
@@ -2941,6 +2944,7 @@ enum dc_status resource_add_otg_master_for_stream_output(struct dc_state *new_ct
 		const struct resource_pool *pool,
 		struct dc_stream_state *stream)
 {
+	(void)pool;
 	struct dc *dc = stream->ctx->dc;
 
 	return dc->res_pool->funcs->add_stream_to_ctx(dc, new_ctx, stream);
@@ -3023,6 +3027,7 @@ static bool add_plane_to_opp_head_pipes(struct pipe_ctx *otg_master_pipe,
 		struct dc_plane_state *plane_state,
 		struct dc_state *context)
 {
+	(void)context;
 	struct pipe_ctx *opp_head_pipe = otg_master_pipe;
 
 	while (opp_head_pipe) {
@@ -3615,6 +3620,7 @@ static struct hpo_dp_stream_encoder *find_first_free_match_hpo_dp_stream_enc_for
 		const struct resource_pool *pool,
 		struct dc_stream_state *stream)
 {
+	(void)stream;
 	int i;
 
 	for (i = 0; i < pool->hpo_dp_stream_enc_count; i++) {
@@ -3634,6 +3640,7 @@ static struct audio *find_first_free_audio(
 		enum engine_id id,
 		enum dce_version dc_version)
 {
+	(void)dc_version;
 	int i, available_audio_count;
 
 	if (id == ENGINE_ID_UNKNOWN)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 4b2d5a174fa9..dbee34935c2f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -410,6 +410,7 @@ enum dc_status dc_state_add_stream(
 		struct dc_state *state,
 		struct dc_stream_state *stream)
 {
+	(void)dc;
 	enum dc_status res;
 
 	DC_LOGGER_INIT(dc->ctx->logger);
@@ -785,6 +786,7 @@ struct dc_plane_state *dc_state_create_phantom_plane(const struct dc *dc,
 		struct dc_state *state,
 		struct dc_plane_state *main_plane)
 {
+	(void)main_plane;
 	struct dc_plane_state *phantom_plane = dc_create_plane_state(dc);
 
 	DC_LOGGER_INIT(dc->ctx->logger);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index 5d3a8a63b7cd..56b21059a663 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -57,6 +57,7 @@ void dc_plane_construct(struct dc_context *ctx, struct dc_plane_state *plane_sta
 
 void dc_plane_destruct(struct dc_plane_state *plane_state)
 {
+	(void)plane_state;
 	// no more pointers to free within dc_plane_state
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index d6a08064456b..9f5886d235e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1082,6 +1082,7 @@ static void dc_build_cursor_attribute_update_payload1(
 		struct dmub_cursor_attributes_cfg *pl_A, const uint8_t p_idx,
 		const struct hubp *hubp, const struct dpp *dpp)
 {
+	(void)p_idx;
 	/* Hubp */
 	pl_A->aHubp.SURFACE_ADDR_HIGH = hubp->att.SURFACE_ADDR_HIGH;
 	pl_A->aHubp.SURFACE_ADDR = hubp->att.SURFACE_ADDR;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 04b8b798dfff..77299767096f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -108,6 +108,7 @@ static void set_reg_field_values(struct dc_reg_value_masks *field_value_mask,
 		uint8_t shift1, uint32_t mask1, uint32_t field_value1,
 		va_list ap)
 {
+	(void)addr;
 	uint32_t shift, mask, field_value;
 	int i = 1;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
index c647dff5234a..42cb8b29dd47 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
@@ -165,6 +165,7 @@ void dccg31_set_dpstreamclk(
 		int otg_inst,
 		int dp_hpo_inst)
 {
+	(void)dp_hpo_inst;
 	if (src == REFCLK)
 		dccg31_disable_dpstreamclk(dccg, otg_inst);
 	else
@@ -644,6 +645,7 @@ void dccg31_get_dccg_ref_freq(struct dccg *dccg,
 		unsigned int xtalin_freq_inKhz,
 		unsigned int *dccg_ref_freq_inKhz)
 {
+	(void)dccg;
 	/*
 	 * Assume refclk is sourced from xtalin
 	 * expect 24MHz
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
index ce697c3249fb..d2752dd8f81f 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
@@ -265,6 +265,7 @@ static void dccg32_get_dccg_ref_freq(struct dccg *dccg,
 		unsigned int xtalin_freq_inKhz,
 		unsigned int *dccg_ref_freq_inKhz)
 {
+	(void)dccg;
 	/*
 	 * Assume refclk is sourced from xtalin
 	 * expect 100MHz
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 943ec1983076..33418ee1fa62 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -558,6 +558,7 @@ static void dccg35_set_symclk32_se_src_new(
 static int
 dccg35_is_symclk32_se_src_functional_le_new(struct dccg *dccg, int symclk_32_se_inst, int symclk_32_le_inst)
 {
+	(void)symclk_32_se_inst;
 	uint32_t en;
 	uint32_t src_sel;
 
@@ -2373,6 +2374,7 @@ static void dccg35_disable_symclk_se_cb(
 			uint32_t stream_enc_inst,
 			uint32_t link_enc_inst)
 {
+	(void)link_enc_inst;
 	dccg35_disable_symclk_fe_new(dccg, stream_enc_inst);
 
 	/* DMU PHY sequence switches SYMCLK_BE (link_enc_inst) to ref clock once PHY is turned off */
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index f4ead86c9a96..72aaf057e775 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -161,6 +161,7 @@ void dccg401_set_pixel_rate_div(
 		enum pixel_rate_div tmds_div,
 		enum pixel_rate_div unused)
 {
+	(void)unused;
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	uint32_t cur_tmds_div = PIXEL_RATE_DIV_NA;
 	uint32_t dp_dto_int;
@@ -353,6 +354,7 @@ void dccg401_get_dccg_ref_freq(struct dccg *dccg,
 		unsigned int xtalin_freq_inKhz,
 		unsigned int *dccg_ref_freq_inKhz)
 {
+	(void)dccg;
 	/*
 	 * Assume refclk is sourced from xtalin
 	 * expect 100MHz
@@ -721,6 +723,7 @@ void dccg401_init(struct dccg *dccg)
 
 void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst, uint32_t num_slices_h)
 {
+	(void)num_slices_h;
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
 	switch (inst) {
@@ -838,6 +841,7 @@ void dccg401_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint3
 
 void dccg401_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
 {
+	(void)link_enc_inst;
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
 	switch (stream_enc_inst) {
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
index 19dfc3fe5c3a..b813310763e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
@@ -186,6 +186,7 @@ void dccg42_set_pixel_rate_div(
 		enum pixel_rate_div tmds_div,
 		enum pixel_rate_div unused)
 {
+	(void)unused;
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	uint32_t cur_tmds_div = PIXEL_RATE_DIV_NA;
 	uint32_t dp_dto_int;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index 2dcf394edf22..07023199fd21 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -57,6 +57,7 @@
 
 static bool dce_abm_set_pipe(struct abm *abm, uint32_t controller_id, uint32_t panel_inst)
 {
+	(void)panel_inst;
 	struct dce_abm *abm_dce = TO_DCE_ABM(abm);
 	uint32_t rampingBoundary = 0xFFFF;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 1276f19164b3..8af8e2c17134 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -350,6 +350,7 @@ static uint32_t calculate_required_audio_bw_in_symbols(
 	uint32_t av_stream_map_lane_count,
 	uint32_t audio_sdp_overhead)
 {
+	(void)channel_count;
 	/* DP spec recommends between 1.05 to 1.1 safety margin to prevent sample under-run */
 	struct fixed31_32 audio_sdp_margin = dc_fixpt_from_fraction(110, 100);
 	struct fixed31_32 horizontal_line_freq_khz = dc_fixpt_from_fraction(
@@ -1027,6 +1028,7 @@ static void get_azalia_clock_info_hdmi(
 	uint32_t actual_pixel_clock_100Hz,
 	struct azalia_clock_info *azalia_clock_info)
 {
+	(void)crtc_pixel_clock_100hz;
 	/* audio_dto_phase= 24 * 10,000;
 	 *   24MHz in [100Hz] units */
 	azalia_clock_info->audio_dto_phase =
@@ -1043,6 +1045,7 @@ static void get_azalia_clock_info_dp(
 	const struct audio_pll_info *pll_info,
 	struct azalia_clock_info *azalia_clock_info)
 {
+	(void)requested_pixel_clock_100Hz;
 	/* Reported dpDtoSourceClockInkhz value for
 	 * DCE8 already adjusted for SS, do not need any
 	 * adjustment here anymore
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 993a25c39aa9..c9722ecdbb9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -539,6 +539,7 @@ static void dce112_get_pix_clk_dividers_helper (
 		struct pll_settings *pll_settings,
 		struct pixel_clk_params *pix_clk_params)
 {
+	(void)clk_src;
 	uint32_t actual_pixel_clock_100hz;
 
 	actual_pixel_clock_100hz = pix_clk_params->requested_pix_clk_100hz;
@@ -847,6 +848,7 @@ static bool dce110_program_pix_clk(
 		enum dp_link_encoding encoding,
 		struct pll_settings *pll_settings)
 {
+	(void)encoding;
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 
@@ -921,6 +923,7 @@ static bool dce112_program_pix_clk(
 		enum dp_link_encoding encoding,
 		struct pll_settings *pll_settings)
 {
+	(void)encoding;
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 
@@ -1070,6 +1073,7 @@ static bool dcn401_program_pix_clk(
 		enum dp_link_encoding encoding,
 		struct pll_settings *pll_settings)
 {
+	(void)encoding;
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
 	unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
 	const struct pixel_rate_range_table_entry *e =
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index 5f8fba45d98d..e7a0d3b7c2cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -71,6 +71,7 @@ static const uint32_t abm_gain_stepsize = 0x0060;
 
 static bool dce_dmcu_init(struct dmcu *dmcu)
 {
+	(void)dmcu;
 	// Do nothing
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
index f5cd2392fc5f..f5261e8d7678 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
@@ -31,6 +31,7 @@ bool dce_i2c_oem_device_present(
 	size_t slave_address
 )
 {
+	(void)pool;
 	struct dc *dc = ddc->ctx->dc;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct graphics_object_id id = {0};
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index 365dd2e37aea..fe239a96121e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -69,6 +69,7 @@ static enum i2c_channel_operation_result get_channel_status(
 	struct dce_i2c_hw *dce_i2c_hw,
 	uint8_t *returned_bytes)
 {
+	(void)returned_bytes;
 	uint32_t i2c_sw_status = 0;
 	uint32_t value =
 		REG_GET(DC_I2C_SW_STATUS, DC_I2C_SW_STATUS, &i2c_sw_status);
@@ -631,6 +632,7 @@ bool dce_i2c_submit_command_hw(
 	struct i2c_command *cmd,
 	struct dce_i2c_hw *dce_i2c_hw)
 {
+	(void)ddc;
 	uint8_t index_of_payload = 0;
 	bool result;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
index 2d73b94c515c..52e05b9185f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
@@ -67,6 +67,7 @@ static void release_engine_dce_sw(
 	struct resource_pool *pool,
 	struct dce_i2c_sw *dce_i2c_sw)
 {
+	(void)pool;
 	dal_ddc_close(dce_i2c_sw->ddc);
 	dce_i2c_sw->ddc = NULL;
 }
@@ -76,6 +77,7 @@ static bool wait_for_scl_high_sw(
 	struct ddc *ddc,
 	uint16_t clock_delay_div_4)
 {
+	(void)ctx;
 	uint32_t scl_retry = 0;
 	uint32_t scl_retry_max = I2C_SW_TIMEOUT_DELAY / clock_delay_div_4;
 
@@ -469,6 +471,7 @@ bool dce_i2c_submit_command_sw(
 	struct i2c_command *cmd,
 	struct dce_i2c_sw *dce_i2c_sw)
 {
+	(void)ddc;
 	uint8_t index_of_payload = 0;
 	bool result;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
index 34bff9aef66c..ee55ec21d270 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
@@ -43,6 +43,7 @@ static void dce_ipp_cursor_set_position(
 	const struct dc_cursor_position *position,
 	const struct dc_cursor_mi_param *param)
 {
+	(void)param;
 	struct dce_ipp *ipp_dce = TO_DCE_IPP(ipp);
 
 	/* lock cursor registers */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 2ba3d3a3aac5..b95c5866a10c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -820,6 +820,7 @@ bool dce110_link_encoder_validate_dp_output(
 	const struct dce110_link_encoder *enc110,
 	const struct dc_crtc_timing *crtc_timing)
 {
+	(void)enc110;
 	if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 1c2009e38aa1..168c2d0a5eaa 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -317,6 +317,7 @@ static void dce_mi_program_display_marks(
 	struct dce_watermarks urgent,
 	uint32_t total_dest_line_time_ns)
 {
+	(void)stutter_enter;
 	struct dce_mem_input *dce_mi = TO_DCE_MEM_INPUT(mi);
 	uint32_t stutter_en = mi->ctx->dc->debug.disable_stutter ? 0 : 1;
 
@@ -370,6 +371,7 @@ static void dce112_mi_program_display_marks(struct mem_input *mi,
 	struct dce_watermarks urgent,
 	uint32_t total_dest_line_time_ns)
 {
+	(void)stutter_entry;
 	struct dce_mem_input *dce_mi = TO_DCE_MEM_INPUT(mi);
 	uint32_t stutter_en = mi->ctx->dc->debug.disable_stutter ? 0 : 1;
 
@@ -656,6 +658,8 @@ static void dce_mi_program_surface_config(
 	struct dc_plane_dcc_param *dcc,
 	bool horizontal_mirror)
 {
+	(void)dcc;
+	(void)horizontal_mirror;
 	struct dce_mem_input *dce_mi = TO_DCE_MEM_INPUT(mi);
 	REG_UPDATE(GRPH_ENABLE, GRPH_ENABLE, 1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
index f342da5a5e50..61d478cfca6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
@@ -600,6 +600,7 @@ void dce110_opp_set_dyn_expansion(
 	enum dc_color_depth color_dpth,
 	enum signal_type signal)
 {
+	(void)color_sp;
 	struct dce110_opp *opp110 = TO_DCE110_OPP(opp);
 
 	REG_UPDATE_2(FMT_DYNAMIC_EXP_CNTL,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index 87c19f17c799..ed407e779c12 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -271,6 +271,8 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 	bool use_vsc_sdp_for_colorimetry,
 	uint32_t enable_sdp_splitting)
 {
+	(void)use_vsc_sdp_for_colorimetry;
+	(void)enable_sdp_splitting;
 	uint32_t h_active_start;
 	uint32_t v_active_start;
 	uint32_t misc0 = 0;
@@ -901,6 +903,7 @@ static void dce110_stream_encoder_dp_blank(
 	struct dc_link *link,
 	struct stream_encoder *enc)
 {
+	(void)link;
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
 	uint32_t  reg1 = 0;
 	uint32_t max_retries = DP_BLANK_MAX_RETRY * 10;
@@ -951,6 +954,7 @@ static void dce110_stream_encoder_dp_unblank(
 	struct stream_encoder *enc,
 	const struct encoder_unblank_param *param)
 {
+	(void)link;
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
 
 	if (param->link_settings.link_rate != LINK_RATE_UNKNOWN) {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 1ab5ae9b5ea5..c1448ae47366 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -282,6 +282,7 @@ static void calculate_inits(
 	const struct scaler_data *data,
 	struct scl_ratios_inits *inits)
 {
+	(void)xfm_dce;
 	struct fixed31_32 h_init;
 	struct fixed31_32 v_init;
 
@@ -1240,6 +1241,7 @@ static void program_color_matrix(
 	const struct out_csc_color_matrix *tbl_entry,
 	enum grph_color_adjust_option options)
 {
+	(void)options;
 	{
 		REG_SET_2(OUTPUT_CSC_C11_C12, 0,
 			OUTPUT_CSC_C11, tbl_entry->regval[0],
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 2764125d63b3..c8077905ff9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -173,6 +173,7 @@ static bool dmub_abm_set_backlight_level_pwm_ex(struct abm *abm,
 		unsigned int controller_id,
 		unsigned int panel_inst)
 {
+	(void)controller_id;
 	bool ret = false;
 	unsigned int feature_support;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index a641ae04450c..806b5709c9e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -188,6 +188,7 @@ void dmub_abm_init_config(struct abm *abm,
 
 bool dmub_abm_set_pause(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int stream_inst)
 {
+	(void)stream_inst;
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
 	uint8_t panel_mask = 0x01 << panel_inst;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index fd8244c94687..fbb7ee44c589 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -216,6 +216,7 @@ static void dmub_replay_set_coasting_vtotal(struct dmub_replay *dmub,
 		uint8_t panel_inst,
 		uint16_t frame_skip_number)
 {
+	(void)panel_inst;
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
 	struct dmub_rb_cmd_replay_set_coasting_vtotal *pCmd = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
index 2c43c2422638..b265a72eeb70 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
@@ -40,6 +40,7 @@ static void set_flip_control(
 	struct dce_mem_input *mem_input110,
 	bool immediate)
 {
+	(void)immediate;
 	uint32_t value = 0;
 
 	value = dm_read_reg(
@@ -165,6 +166,7 @@ static void program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
+	(void)pixel_format;
 	uint32_t value = 0;
 
 	set_reg_field_value(value, info->gfx8.num_banks,
@@ -642,6 +644,8 @@ static void dce_mem_input_v_program_surface_config(
 	struct dc_plane_dcc_param *dcc,
 	bool horizotal_mirror)
 {
+	(void)dcc;
+	(void)horizotal_mirror;
 	struct dce_mem_input *mem_input110 = TO_DCE_MEM_INPUT(mem_input);
 
 	enable(mem_input110);
@@ -927,6 +931,7 @@ static void dce_mem_input_v_program_display_marks(
 	struct dce_watermarks urgent,
 	uint32_t total_dest_line_time_ns)
 {
+	(void)stutter_enter;
 	program_urgency_watermark_l(
 		mem_input->ctx,
 		urgent,
@@ -970,6 +975,9 @@ static void dce110_allocate_mem_input_v(
 	uint32_t pix_clk_khz,/* for current stream */
 	uint32_t total_stream_num)
 {
+	(void)h_total;
+	(void)v_total;
+	(void)total_stream_num;
 	uint32_t addr;
 	uint32_t value;
 	uint32_t pix_dur;
@@ -1009,6 +1017,8 @@ static void dce110_free_mem_input_v(
 	struct mem_input *mi,
 	uint32_t total_stream_num)
 {
+	(void)mi;
+	(void)total_stream_num;
 }
 
 static const struct mem_input_funcs dce110_mem_input_v_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
index e096d2b95ef9..cf63fac82832 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
@@ -110,6 +110,7 @@ static void program_color_matrix_v(
 	const struct out_csc_color_matrix *tbl_entry,
 	enum grph_color_adjust_option options)
 {
+	(void)options;
 	struct dc_context *ctx = xfm_dce->base.ctx;
 	uint32_t cntl_value = dm_read_reg(ctx, mmCOL_MAN_OUTPUT_CSC_CONTROL);
 	bool use_set_a = (get_reg_field_value(cntl_value,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_regamma_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_regamma_v.c
index 9b65b77e8823..a4e76db46c9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_regamma_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_regamma_v.c
@@ -551,5 +551,7 @@ void dce110_opp_set_regamma_mode_v(
 	struct transform *xfm,
 	enum opp_regamma mode)
 {
+	(void)xfm;
+	(void)mode;
 	// TODO: need to implement the function
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
index 61b0807693fb..b015b27cd1c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
@@ -66,6 +66,7 @@ static void dce110_timing_generator_apply_front_porch_workaround(
 	struct timing_generator *tg,
 	struct dc_crtc_timing *timing)
 {
+	(void)tg;
 	if (timing->flags.INTERLACE == 1) {
 		if (timing->v_front_porch < 2)
 			timing->v_front_porch = 2;
@@ -1115,6 +1116,7 @@ bool dce110_timing_generator_validate_timing(
 	const struct dc_crtc_timing *timing,
 	enum signal_type signal)
 {
+	(void)signal;
 	uint32_t h_blank;
 	uint32_t h_back_porch, hsync_offset, h_sync_start;
 
@@ -1490,6 +1492,7 @@ void dce110_timing_generator_enable_reset_trigger(
 	struct timing_generator *tg,
 	int source_tg_inst)
 {
+	(void)source_tg_inst;
 	uint32_t value;
 	uint32_t rising_edge = 0;
 	uint32_t falling_edge = 0;
@@ -1959,6 +1962,12 @@ void dce110_tg_program_timing(struct timing_generator *tg,
 	const enum signal_type signal,
 	bool use_vbios)
 {
+	(void)vready_offset;
+	(void)vstartup_start;
+	(void)vupdate_offset;
+	(void)vupdate_width;
+	(void)pstate_keepout;
+	(void)signal;
 	if (use_vbios)
 		dce110_timing_generator_program_timing_generator(tg, timing);
 	else
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c
index 9837dec837ff..ba22c93acd81 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c
@@ -442,6 +442,12 @@ static void dce110_timing_generator_v_program_timing(struct timing_generator *tg
 	const enum signal_type signal,
 	bool use_vbios)
 {
+	(void)vready_offset;
+	(void)vstartup_start;
+	(void)vupdate_offset;
+	(void)vupdate_width;
+	(void)pstate_keepout;
+	(void)signal;
 	if (use_vbios)
 		dce110_timing_generator_program_timing_generator(tg, timing);
 	else
@@ -621,6 +627,7 @@ static void dce110_timing_generator_v_setup_global_swap_lock(
 	struct timing_generator *tg,
 	const struct dcp_gsl_params *gsl_params)
 {
+	(void)gsl_params;
 	DC_LOG_ERROR("Timing Sync not supported on underlay pipe\n");
 	return;
 }
@@ -629,6 +636,7 @@ static void dce110_timing_generator_v_enable_reset_trigger(
 	struct timing_generator *tg,
 	int source_tg_inst)
 {
+	(void)source_tg_inst;
 	DC_LOG_ERROR("Timing Sync not supported on underlay pipe\n");
 	return;
 }
@@ -650,6 +658,7 @@ static void dce110_timing_generator_v_tear_down_global_swap_lock(
 static void dce110_timing_generator_v_disable_vga(
 	struct timing_generator *tg)
 {
+	(void)tg;
 	return;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
index 28d3b2663cd3..6be18665b1f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
@@ -371,6 +371,9 @@ static void calculate_inits(
 	struct rect *luma_viewport,
 	struct rect *chroma_viewport)
 {
+	(void)xfm_dce;
+	(void)luma_viewport;
+	(void)chroma_viewport;
 	inits->h_int_scale_ratio_luma =
 		dc_fixpt_u2d19(data->ratios.horz) << 5;
 	inits->v_int_scale_ratio_luma =
@@ -619,6 +622,8 @@ static void dce110_xfmv_set_gamut_remap(
 	struct transform *xfm,
 	const struct xfm_grph_csc_adjustment *adjust)
 {
+	(void)xfm;
+	(void)adjust;
 	/* DO NOTHING*/
 }
 
@@ -627,6 +632,7 @@ static void dce110_xfmv_set_pixel_storage_depth(
 	enum lb_pixel_depth depth,
 	const struct bit_depth_reduction_params *bit_depth_params)
 {
+	(void)bit_depth_params;
 	struct dce_transform *xfm_dce = TO_DCE_TRANSFORM(xfm);
 	int pixel_depth = 0;
 	int expan_mode = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c
index faae12cf7968..6b08cab32ee3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c
@@ -284,6 +284,7 @@ static uint32_t align_to_chunks_number_per_line(
 	struct dce112_compressor *cp110,
 	uint32_t pixels)
 {
+	(void)cp110;
 	return 256 * ((pixels + 255) / 256);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
index 31c4f44ceaac..70410ef0c291 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
@@ -304,6 +304,7 @@ static void dce120_timing_generator_enable_reset_trigger(
 	struct timing_generator *tg,
 	int source)
 {
+	(void)source;
 	enum trigger_source_select trig_src_select = TRIGGER_SOURCE_SELECT_LOGIC_ZERO;
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
 	uint32_t rising_edge = 0;
@@ -701,6 +702,12 @@ static void dce120_tg_program_timing(struct timing_generator *tg,
 	const enum signal_type signal,
 	bool use_vbios)
 {
+	(void)vready_offset;
+	(void)vstartup_start;
+	(void)vupdate_offset;
+	(void)vupdate_width;
+	(void)pstate_keepout;
+	(void)signal;
 	if (use_vbios)
 		dce110_timing_generator_program_timing_generator(tg, timing);
 	else
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c
index 88e7a1fc9a30..53c03364f5d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c
@@ -115,6 +115,12 @@ static void dce80_timing_generator_program_timing(struct timing_generator *tg,
 	const enum signal_type signal,
 	bool use_vbios)
 {
+	(void)vready_offset;
+	(void)vstartup_start;
+	(void)vupdate_offset;
+	(void)vupdate_width;
+	(void)pstate_keepout;
+	(void)signal;
 	if (!use_vbios)
 		program_pix_dur(tg, timing->pix_clk_100hz);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c
index 365a3215f6d5..e9efbb49586e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c
@@ -44,6 +44,7 @@
 
 static bool dwb1_get_caps(struct dwbc *dwbc, struct dwb_caps *caps)
 {
+	(void)dwbc;
 	if (caps) {
 		caps->adapter_id = 0;	/* we only support 1 adapter currently */
 		caps->hw_version = DCN_VERSION_1_0;
@@ -63,6 +64,7 @@ static bool dwb1_get_caps(struct dwbc *dwbc, struct dwb_caps *caps)
 
 static bool dwb1_enable(struct dwbc *dwbc, struct dc_dwb_params *params)
 {
+	(void)params;
 	struct dcn10_dwbc *dwbc10 = TO_DCN10_DWBC(dwbc);
 
 	/* disable first. */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
index 05aac3e444b4..4c7e4fe3c680 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
@@ -77,6 +77,7 @@ static void apg31_se_audio_setup(
 	unsigned int az_inst,
 	struct audio_info *audio_info)
 {
+	(void)az_inst;
 	struct dcn31_apg *apg31 = DCN31_APG_FROM_APG(apg);
 
 	ASSERT(audio_info);
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
index d928b4dcf6b8..d913f065ecca 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
@@ -249,6 +249,7 @@ void enc1_stream_encoder_dp_set_stream_attribute(
 	bool use_vsc_sdp_for_colorimetry,
 	uint32_t enable_sdp_splitting)
 {
+	(void)enable_sdp_splitting;
 	uint32_t h_active_start;
 	uint32_t v_active_start;
 	uint32_t misc0 = 0;
@@ -783,6 +784,7 @@ void enc1_stream_encoder_send_immediate_sdp_message(
 	const uint8_t *custom_sdp_message,
 	unsigned int sdp_message_size)
 {
+	(void)sdp_message_size;
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 	uint32_t value = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
index 3e85e9c3d2cb..d1fd5462dca5 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
@@ -394,6 +394,8 @@ void enc314_dp_set_dsc_config(struct stream_encoder *enc,
 					uint32_t dsc_bytes_per_pixel,
 					uint32_t dsc_slice_width)
 {
+	(void)dsc_bytes_per_pixel;
+	(void)dsc_slice_width;
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
 	REG_UPDATE(DP_DSC_CNTL,	DP_DSC_MODE, dsc_mode == OPTC_DSC_DISABLED ? 0 : 1);
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c
index 3523d1cdc1a3..edafa3808455 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c
@@ -356,6 +356,8 @@ static void enc32_dp_set_dsc_config(struct stream_encoder *enc,
 					uint32_t dsc_bytes_per_pixel,
 					uint32_t dsc_slice_width)
 {
+	(void)dsc_bytes_per_pixel;
+	(void)dsc_slice_width;
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
 	REG_UPDATE(DP_DSC_CNTL,	DP_DSC_MODE, dsc_mode == OPTC_DSC_DISABLED ? 0 : 1);
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
index fd5d1dbf9dc6..de24dcd27e6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
@@ -369,6 +369,7 @@ static void enc35_stream_encoder_map_to_link(
 		uint32_t stream_enc_inst,
 		uint32_t link_enc_inst)
 {
+	(void)stream_enc_inst;
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
 	ASSERT(stream_enc_inst < 5 && link_enc_inst < 5);
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
index 99aab70ef3e1..2d33ed0c062d 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
@@ -57,6 +57,8 @@ static void enc401_dp_set_odm_combine(
 	struct stream_encoder *enc,
 	bool odm_combine)
 {
+	(void)enc;
+	(void)odm_combine;
 }
 
 /* setup stream encoder in dvi mode */
@@ -710,6 +712,7 @@ void enc401_stream_encoder_map_to_link(
 		uint32_t stream_enc_inst,
 		uint32_t link_enc_inst)
 {
+	(void)stream_enc_inst;
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
 	REG_UPDATE(STREAM_MAPPER_CONTROL,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.c
index 2655bc194a35..5b2bba0eff0e 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.c
@@ -30,52 +30,92 @@
 
 static bool virtual_link_encoder_validate_output_with_stream(
 	struct link_encoder *enc,
-	const struct dc_stream_state *stream) { return true; }
+	const struct dc_stream_state *stream) {
+		(void)enc;
+		(void)stream;
+		return true;
+	}
 
-static void virtual_link_encoder_hw_init(struct link_encoder *enc) {}
+static void virtual_link_encoder_hw_init(struct link_encoder *enc)
+{
+	(void)enc;
+}
 
 static void virtual_link_encoder_setup(
-	struct link_encoder *enc,
-	enum signal_type signal) {}
+	struct link_encoder *enc, enum signal_type signal) {
+		(void)enc;
+		(void)signal;
+	}
 
 static void virtual_link_encoder_enable_tmds_output(
 	struct link_encoder *enc,
 	enum clock_source_id clock_source,
 	enum dc_color_depth color_depth,
 	enum signal_type signal,
-	uint32_t pixel_clock) {}
+	uint32_t pixel_clock) {
+		(void)enc;
+		(void)clock_source;
+		(void)color_depth;
+		(void)signal;
+		(void)pixel_clock;
+	}
 
 static void virtual_link_encoder_enable_dp_output(
 	struct link_encoder *enc,
 	const struct dc_link_settings *link_settings,
-	enum clock_source_id clock_source) {}
+	enum clock_source_id clock_source) {
+		(void)enc;
+		(void)link_settings;
+		(void)clock_source;
+	}
 
 static void virtual_link_encoder_enable_dp_mst_output(
 	struct link_encoder *enc,
 	const struct dc_link_settings *link_settings,
-	enum clock_source_id clock_source) {}
+	enum clock_source_id clock_source) {
+		(void)enc;
+		(void)link_settings;
+		(void)clock_source;
+	}
 
 static void virtual_link_encoder_disable_output(
 	struct link_encoder *link_enc,
-	enum signal_type signal) {}
+	enum signal_type signal) {
+		(void)link_enc;
+		(void)signal;
+	}
 
 static void virtual_link_encoder_dp_set_lane_settings(
 	struct link_encoder *enc,
 	const struct dc_link_settings *link_settings,
-	const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]) {}
+	const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]) {
+		(void)enc;
+		(void)link_settings;
+		(void)lane_settings;
+	}
 
 static void virtual_link_encoder_dp_set_phy_pattern(
 	struct link_encoder *enc,
-	const struct encoder_set_dp_phy_pattern_param *param) {}
+	const struct encoder_set_dp_phy_pattern_param *param) {
+		(void)enc;
+		(void)param;
+	}
 
 static void virtual_link_encoder_update_mst_stream_allocation_table(
 	struct link_encoder *enc,
-	const struct link_mst_stream_allocation_table *table) {}
+	const struct link_mst_stream_allocation_table *table) {
+		(void)enc;
+		(void)table;
+	}
 
 static void virtual_link_encoder_connect_dig_be_to_fe(
 	struct link_encoder *enc,
 	enum engine_id engine,
-	bool connect) {}
+	bool connect) {
+		(void)enc;
+		(void)engine;
+		(void)connect;
+	}
 
 static void virtual_link_encoder_destroy(struct link_encoder **enc)
 {
@@ -86,6 +126,7 @@ static void virtual_link_encoder_destroy(struct link_encoder **enc)
 static void virtual_link_encoder_get_max_link_cap(struct link_encoder *enc,
 		struct dc_link_settings *link_settings)
 {
+	(void)enc;
 	/* Set Default link settings */
 	struct dc_link_settings max_link_cap = {LANE_COUNT_FOUR, LINK_RATE_HIGH,
 				LINK_SPREAD_05_DOWNSPREAD_30KHZ, false, 0};
diff --git a/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c
index c5d2e9404d94..5be18cf54a13 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c
@@ -31,80 +31,127 @@ static void virtual_stream_encoder_dp_set_stream_attribute(
 	struct dc_crtc_timing *crtc_timing,
 	enum dc_color_space output_color_space,
 	bool use_vsc_sdp_for_colorimetry,
-	uint32_t enable_sdp_splitting) {}
+	uint32_t enable_sdp_splitting) {
+		(void)enc;
+		(void)crtc_timing;
+		(void)output_color_space;
+		(void)use_vsc_sdp_for_colorimetry;
+		(void)enable_sdp_splitting;
+	}
 
 static void virtual_stream_encoder_hdmi_set_stream_attribute(
 	struct stream_encoder *enc,
 	struct dc_crtc_timing *crtc_timing,
 	int actual_pix_clk_khz,
-	bool enable_audio) {}
+	bool enable_audio) {
+		(void)enc;
+		(void)crtc_timing;
+		(void)actual_pix_clk_khz;
+		(void)enable_audio;
+	}
 
 static void virtual_stream_encoder_dvi_set_stream_attribute(
 	struct stream_encoder *enc,
 	struct dc_crtc_timing *crtc_timing,
-	bool is_dual_link) {}
+	bool is_dual_link) {
+		(void)enc;
+		(void)crtc_timing;
+		(void)is_dual_link;
+	}
 
 static void virtual_stream_encoder_set_throttled_vcp_size(
 	struct stream_encoder *enc,
-	struct fixed31_32 avg_time_slots_per_mtp)
-{}
+	struct fixed31_32 avg_time_slots_per_mtp) {
+		(void)enc;
+		(void)avg_time_slots_per_mtp;
+	}
 
 static void virtual_stream_encoder_update_hdmi_info_packets(
 	struct stream_encoder *enc,
-	const struct encoder_info_frame *info_frame) {}
+	const struct encoder_info_frame *info_frame) {
+		(void)enc;
+		(void)info_frame;
+	}
 
 static void virtual_stream_encoder_stop_hdmi_info_packets(
-	struct stream_encoder *enc) {}
+	struct stream_encoder *enc) {
+		(void)enc;
+	}
 
 static void virtual_stream_encoder_set_avmute(
-	struct stream_encoder *enc,
-	bool enable) {}
+	struct stream_encoder *enc, bool enable) {
+		(void)enc;
+		(void)enable;
+	}
 static void virtual_stream_encoder_update_dp_info_packets(
 	struct stream_encoder *enc,
-	const struct encoder_info_frame *info_frame) {}
+	const struct encoder_info_frame *info_frame) {
+		(void)enc;
+		(void)info_frame;
+	}
 
 static void virtual_stream_encoder_stop_dp_info_packets(
-	struct stream_encoder *enc) {}
+	struct stream_encoder *enc) {
+		(void)enc;
+	}
 
 static void virtual_stream_encoder_dp_blank(
 	struct dc_link *link,
-	struct stream_encoder *enc) {}
+	struct stream_encoder *enc) {
+		(void)link;
+		(void)enc;
+	}
 
 static void virtual_stream_encoder_dp_unblank(
 	struct dc_link *link,
 	struct stream_encoder *enc,
-	const struct encoder_unblank_param *param) {}
+	const struct encoder_unblank_param *param) {
+		(void)enc;
+		(void)link;
+		(void)param;
+	}
 
 static void virtual_audio_mute_control(
-	struct stream_encoder *enc,
-	bool mute) {}
+	struct stream_encoder *enc, bool mute) {
+		(void)enc;
+		(void)mute;
+	}
 
 static void virtual_stream_encoder_reset_hdmi_stream_attribute(
-		struct stream_encoder *enc)
-{}
+	struct stream_encoder *enc)
+{
+	(void)enc;
+}
 
 static void virtual_enc_dp_set_odm_combine(
-	struct stream_encoder *enc,
-	bool odm_combine)
-{}
+	struct stream_encoder *enc, bool odm_combine) {
+		(void)enc;
+		(void)odm_combine;
+	}
 
 static void virtual_dig_connect_to_otg(
-		struct stream_encoder *enc,
-		int tg_inst)
-{}
+		struct stream_encoder *enc, int tg_inst) {
+		(void)enc;
+		(void)tg_inst;
+	}
 
 static void virtual_setup_stereo_sync(
-			struct stream_encoder *enc,
-			int tg_inst,
-			bool enable)
-{}
+		struct stream_encoder *enc,
+		int tg_inst, bool enable) {
+		(void)enc;
+		(void)tg_inst;
+		(void)enable;
+	}
 
 static void virtual_stream_encoder_set_dsc_pps_info_packet(
-		struct stream_encoder *enc,
-		bool enable,
-		uint8_t *dsc_packed_pps,
-		bool immediate_update)
-{}
+	struct stream_encoder *enc, bool enable, uint8_t *dsc_packed_pps,
+	bool immediate_update)
+{
+	(void)enc;
+	(void)enable;
+	(void)dsc_packed_pps;
+	(void)immediate_update;
+}
 
 static const struct stream_encoder_funcs virtual_str_enc_funcs = {
 	.dp_set_odm_combine =
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index 74962791302f..61553e24d53e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -525,6 +525,7 @@ static void split_stream_across_pipes(
 		struct pipe_ctx *primary_pipe,
 		struct pipe_ctx *secondary_pipe)
 {
+	(void)res_ctx;
 	int pipe_idx = secondary_pipe->pipe_idx;
 
 	if (!primary_pipe->plane_state)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index ae34982b1b1c..887744d56d6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1316,6 +1316,7 @@ int dcn20_populate_dml_pipes_from_context(struct dc *dc,
 					  display_e2e_pipe_params_st *pipes,
 					  enum dc_validate_mode validate_mode)
 {
+	(void)validate_mode;
 	int pipe_cnt, i;
 	bool synchronized_vblank = true;
 	struct resource_context *res_ctx = &context->res_ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 0c8c4a080c50..f5f636afe33c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -501,6 +501,8 @@ static bool CalculatePrefetchSchedule(
 		double *VUpdateWidthPix,
 		double *VReadyOffsetPix)
 {
+	(void)mode_lib;
+
 	bool MyError = false;
 	unsigned int DPPCycles, DISPCLKCycles;
 	double DSTTotalPixelsAfterScaler, TotalRepeaterDelayTime;
@@ -878,6 +880,7 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *dpte_row_height,
 		unsigned int *meta_row_height)
 {
+	(void)ViewportWidth;
 	unsigned int MetaRequestHeight;
 	unsigned int MetaRequestWidth;
 	unsigned int MetaSurfWidth;
@@ -2953,6 +2956,7 @@ static double CalculateRemoteSurfaceFlipDelay(
 		double *TInitXFill,
 		double *TslvChk)
 {
+	(void)mode_lib;
 	double TSlvSetup, AvgfillRate, result;
 
 	*SrcActiveDrainRate = VRatio * SwathWidth * Bpp / LineTime;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index c935903b68e1..95b0a3501880 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -495,6 +495,7 @@ static bool CalculateDelayAfterScaler(
 		double *DSTYAfterScaler
 		)
 {
+	(void)ReturnBW;
 	unsigned int DPPCycles, DISPCLKCycles;
 	double DataFabricLineDeliveryTimeLuma;
 	double DataFabricLineDeliveryTimeChroma;
@@ -592,6 +593,8 @@ static bool CalculatePrefetchSchedule(
 		double *VUpdateWidthPix,
 		double *VReadyOffsetPix)
 {
+	(void)mode_lib;
+
 	bool MyError = false;
 	double TotalRepeaterDelayTime;
 	double Tdm, LineTime, Tsetup;
@@ -938,6 +941,7 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *dpte_row_height,
 		unsigned int *meta_row_height)
 {
+	(void)ViewportWidth;
 	unsigned int MetaRequestHeight;
 	unsigned int MetaRequestWidth;
 	unsigned int MetaSurfWidth;
@@ -3026,6 +3030,7 @@ static double CalculateRemoteSurfaceFlipDelay(
 		double *TInitXFill,
 		double *TslvChk)
 {
+	(void)mode_lib;
 	double TSlvSetup, AvgfillRate, result;
 
 	*SrcActiveDrainRate = VRatio * SwathWidth * Bpp / LineTime;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 9c58ff1069d6..591d9618bdc0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -126,6 +126,7 @@ static double get_refcyc_per_delivery(struct display_mode_lib *mode_lib,
 		unsigned int delivery_width,
 		unsigned int req_per_swath_ub)
 {
+	(void)mode_lib;
 	double refcyc_per_delivery = 0.0;
 
 	if (vratio <= 1.0) {
@@ -1538,6 +1539,9 @@ void dml20_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 		const bool ignore_viewport_pos,
 		const bool immediate_flip_support)
 {
+	(void)vm_en;
+	(void)ignore_viewport_pos;
+	(void)immediate_flip_support;
 	display_rq_params_st rq_param = {0};
 	display_dlg_sys_params_st dlg_sys_param = {0};
 
@@ -1588,6 +1592,7 @@ static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
 		unsigned int cur_width,
 		enum cursor_bpp cur_bpp)
 {
+	(void)mode_lib;
 	unsigned int cur_src_width = cur_width;
 	unsigned int cur_req_size = 0;
 	unsigned int cur_req_width = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 570e6e39eb45..d4dddc9d535a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -126,6 +126,7 @@ static double get_refcyc_per_delivery(struct display_mode_lib *mode_lib,
 		unsigned int delivery_width,
 		unsigned int req_per_swath_ub)
 {
+	(void)mode_lib;
 	double refcyc_per_delivery = 0.0;
 
 	if (vratio <= 1.0) {
@@ -1539,6 +1540,9 @@ void dml20v2_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 		const bool ignore_viewport_pos,
 		const bool immediate_flip_support)
 {
+	(void)vm_en;
+	(void)ignore_viewport_pos;
+	(void)immediate_flip_support;
 	display_rq_params_st rq_param = {0};
 	display_dlg_sys_params_st dlg_sys_param = {0};
 
@@ -1589,6 +1593,7 @@ static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
 		unsigned int cur_width,
 		enum cursor_bpp cur_bpp)
 {
+	(void)mode_lib;
 	unsigned int cur_src_width = cur_width;
 	unsigned int cur_req_size = 0;
 	unsigned int cur_req_width = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 48905ca39b70..11570a0c9427 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -695,6 +695,9 @@ static bool CalculatePrefetchSchedule(
 		double *VUpdateWidthPix,
 		double *VReadyOffsetPix)
 {
+	(void)mode_lib;
+	(void)XFCEnabled;
+
 	bool MyError = false;
 	unsigned int DPPCycles, DISPCLKCycles;
 	double DSTTotalPixelsAfterScaler, TotalRepeaterDelayTime;
@@ -1290,6 +1293,8 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *DPDE0BytesFrame,
 		unsigned int *MetaPTEBytesFrame)
 {
+	(void)SourcePixelFormat;
+	(void)ViewportWidth;
 	unsigned int MPDEBytesFrame;
 	unsigned int DCCMetaSurfaceBytes;
 	unsigned int MacroTileSizeBytes;
@@ -3040,6 +3045,7 @@ static double CalculateRemoteSurfaceFlipDelay(
 		double *TInitXFill,
 		double *TslvChk)
 {
+	(void)mode_lib;
 	double TSlvSetup, AvgfillRate, result;
 
 	*SrcActiveDrainRate = VRatio * SwathWidth * Bpp / LineTime;
@@ -3187,6 +3193,7 @@ static void CalculateFlipSchedule(
 		double *final_flip_bw,
 		bool *ImmediateFlipSupportedForPipe)
 {
+	(void)mode_lib;
 	double min_row_time = 0.0;
 	unsigned int HostVMDynamicLevels;
 	double TimeForFetchingMetaPTEImmediateFlip;
@@ -5294,6 +5301,15 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		double *StutterEnterPlusExitWatermark,
 		double *MinActiveDRAMClockChangeLatencySupported)
 {
+	(void)DPPCLK;
+	(void)SwathWidthSingleDPPY;
+	(void)DCFCLK;
+	(void)UrgentOutOfOrderReturn;
+	(void)ReturnBW;
+	(void)GPUVMEnable;
+	(void)dpte_group_bytes;
+	(void)MetaChunkSize;
+
 	double EffectiveLBLatencyHidingY;
 	double EffectiveLBLatencyHidingC;
 	double DPPOutputBufferLinesY;
@@ -5885,6 +5901,9 @@ static void CalculateMetaAndPTETimes(
 		double TimePerVMRequestVBlank[],
 		double TimePerVMRequestFlip[])
 {
+	(void)VRatioPrefetchY;
+	(void)VRatioPrefetchC;
+
 	unsigned int meta_chunk_width;
 	unsigned int min_meta_chunk_width;
 	unsigned int meta_chunk_per_row_int;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index f549da082c01..8a611b3bec33 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -102,6 +102,7 @@ static double get_refcyc_per_delivery(
 		unsigned int delivery_width,
 		unsigned int req_per_swath_ub)
 {
+	(void)mode_lib;
 	double refcyc_per_delivery = 0.0;
 
 	if (vratio <= 1.0) {
@@ -1647,6 +1648,9 @@ void dml21_rq_dlg_get_dlg_reg(
 		const bool ignore_viewport_pos,
 		const bool immediate_flip_support)
 {
+	(void)vm_en;
+	(void)ignore_viewport_pos;
+	(void)immediate_flip_support;
 	display_rq_params_st rq_param = {0};
 	display_dlg_sys_params_st dlg_sys_param = {0};
 
@@ -1702,6 +1706,7 @@ static void calculate_ttu_cursor(
 		unsigned int cur_width,
 		enum cursor_bpp cur_bpp)
 {
+	(void)mode_lib;
 	unsigned int cur_src_width = cur_width;
 	unsigned int cur_req_size = 0;
 	unsigned int cur_req_width = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index e5f5c0663750..0cdd60869ce1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -571,6 +571,7 @@ void dcn30_fpu_update_bw_bounding_box(struct dc *dc,
 	unsigned int *dcfclk_mhz,
 	unsigned int *dram_speed_mts)
 {
+	(void)bw_params;
 	unsigned int i;
 
 	dc_assert_fp_enabled();
@@ -720,6 +721,7 @@ void dcn3_fpu_build_wm_range_table(struct clk_mgr *base)
 
 void patch_dcn30_soc_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *dcn3_0_ip)
 {
+	(void)dcn3_0_ip;
 	dc_assert_fp_enabled();
 
 	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 1df3412be346..634982173190 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -778,6 +778,8 @@ static bool CalculatePrefetchSchedule(
 		double *RequiredPrefetchPixDataBWChroma,
 		bool *NotEnoughTimeForDynamicMetadata)
 {
+	(void)SwathWidthY;
+	(void)SwathWidthC;
 	struct vba_vars_st *v = &mode_lib->vba;
 	double DPPCLKDelaySubtotalPlusCNVCFormater = v->DPPCLKDelaySubtotal + v->DPPCLKDelayCNVCFormater;
 	bool MyError = false;
@@ -1233,6 +1235,10 @@ static void CalculateDCCConfiguration(
 		unsigned int *IndependentBlockLuma,
 		unsigned int *IndependentBlockChroma)
 {
+	(void)SurfaceWidthChroma;
+	(void)SurfaceHeightChroma;
+	(void)BytePerPixelDETY;
+	(void)BytePerPixelDETC;
 	int yuv420 = 0;
 	int horz_div_l = 0;
 	int horz_div_c = 0;
@@ -1595,6 +1601,7 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *DPDE0BytesFrame,
 		unsigned int *MetaPTEBytesFrame)
 {
+	(void)SourcePixelFormat;
 	unsigned int MPDEBytesFrame = 0;
 	unsigned int DCCMetaSurfaceBytes = 0;
 	unsigned int MacroTileSizeBytes = 0;
@@ -3068,6 +3075,8 @@ double dml30_CalculateWriteBackDISPCLK(
 		unsigned int HTotal,
 		unsigned int WritebackLineBufferSize)
 {
+	(void)WritebackPixelFormat;
+	(void)WritebackVRatio;
 	double DISPCLK_H = 0, DISPCLK_V = 0, DISPCLK_HB = 0;
 
 	DISPCLK_H = PixelClock * dml_ceil(WritebackHTaps / 8.0, 1) / WritebackHRatio;
@@ -3086,6 +3095,8 @@ static double CalculateWriteBackDelay(
 		long         WritebackSourceHeight,
 		unsigned int HTotal)
 {
+	(void)WritebackPixelFormat;
+	(void)WritebackHRatio;
 	double CalculateWriteBackDelay = 0;
 	double Line_length = 0;
 	double Output_lines_last_notclamped = 0;
@@ -3199,6 +3210,8 @@ static void CalculateFlipSchedule(
 		double *final_flip_bw,
 		bool *ImmediateFlipSupportedForPipe)
 {
+	(void)mode_lib;
+	(void)HostVMMinPageSize;
 	double min_row_time = 0.0;
 	unsigned int HostVMDynamicLevelsTrips = 0;
 	double TimeForFetchingMetaPTEImmediateFlip = 0;
@@ -4968,6 +4981,10 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		double BytePerPixelDETC[],
 		enum clock_change_support *DRAMClockChangeSupport)
 {
+	(void)DCFCLK;
+	(void)ReturnBW;
+	(void)DPPCLK;
+	(void)DETBufferSizeC;
 	struct vba_vars_st *v = &mode_lib->vba;
 	double EffectiveLBLatencyHidingY = 0;
 	double EffectiveLBLatencyHidingC = 0;
@@ -5212,6 +5229,8 @@ static void CalculateUrgentBurstFactor(
 		double *UrgentBurstFactorChroma,
 		bool *NotEnoughUrgentLatencyHiding)
 {
+	(void)DETBufferSizeInKByte;
+	(void)VRatioC;
 	double LinesInDETLuma = 0;
 	double LinesInDETChroma = 0;
 	unsigned int LinesInCursorBuffer = 0;
@@ -5575,6 +5594,8 @@ static void CalculateVMGroupAndRequestTimes(
 		double TimePerVMRequestVBlank[],
 		double TimePerVMRequestFlip[])
 {
+	(void)dpte_row_width_luma_ub;
+	(void)dpte_row_width_chroma_ub;
 	int num_group_per_lower_vm_stage = 0;
 	int num_req_per_lower_vm_stage = 0;
 	unsigned int k;
@@ -5857,6 +5878,7 @@ static void CalculateSwathAndDETConfiguration(
 		bool ViewportSizeSupportPerPlane[],
 		bool *ViewportSizeSupport)
 {
+	(void)HRatioChroma;
 	int MaximumSwathHeightY[DC__NUM_DPP__MAX] = { 0 };
 	int MaximumSwathHeightC[DC__NUM_DPP__MAX] = { 0 };
 	int MinimumSwathHeightY = 0;
@@ -6039,6 +6061,7 @@ static void CalculateSwathWidth(
 		unsigned int swath_width_luma_ub[],
 		unsigned int swath_width_chroma_ub[])
 {
+	(void)BytePerPixY;
 	unsigned int k, j;
 	long surface_width_ub_l;
 	long surface_height_ub_l;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index 4fb37df54d59..472ac5ee165f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -50,6 +50,7 @@ static double get_refcyc_per_delivery(struct display_mode_lib *mode_lib,
 	unsigned int delivery_width,
 	unsigned int req_per_swath_ub)
 {
+	(void)mode_lib;
 	double refcyc_per_delivery = 0.0;
 
 	if (vratio <= 1.0) {
@@ -804,6 +805,7 @@ static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
 	unsigned int cur_width,
 	enum cursor_bpp cur_bpp)
 {
+	(void)mode_lib;
 	unsigned int cur_src_width = cur_width;
 	unsigned int cur_req_size = 0;
 	unsigned int cur_req_width = 0;
@@ -896,6 +898,9 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	const bool ignore_viewport_pos,
 	const bool immediate_flip_support)
 {
+	(void)vm_en;
+	(void)ignore_viewport_pos;
+	(void)immediate_flip_support;
 	const display_pipe_source_params_st *src = &e2e_pipe_param[pipe_idx].pipe.src;
 	const display_pipe_dest_params_st *dst = &e2e_pipe_param[pipe_idx].pipe.dest;
 	const display_output_params_st *dout = &e2e_pipe_param[pipe_idx].dout;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index ed59c77bc6f6..9833467722b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -873,6 +873,11 @@ static bool CalculatePrefetchSchedule(
 		double *VUpdateWidthPix,
 		double *VReadyOffsetPix)
 {
+	(void)mode_lib;
+	(void)HostVMMinPageSize;
+	(void)SwathWidthY;
+	(void)SwathWidthC;
+
 	bool MyError = false;
 	unsigned int DPPCycles, DISPCLKCycles;
 	double DSTTotalPixelsAfterScaler;
@@ -1491,6 +1496,10 @@ static void CalculateDCCConfiguration(
 		unsigned int *IndependentBlockLuma,
 		unsigned int *IndependentBlockChroma)
 {
+	(void)SurfaceWidthChroma;
+	(void)SurfaceHeightChroma;
+	(void)BytePerPixelDETY;
+	(void)BytePerPixelDETC;
 	int yuv420;
 	int horz_div_l;
 	int horz_div_c;
@@ -1823,6 +1832,7 @@ static unsigned int CalculateVMAndRowBytes(
 		int *DPDE0BytesFrame,
 		int *MetaPTEBytesFrame)
 {
+	(void)SourcePixelFormat;
 	struct vba_vars_st *v = &mode_lib->vba;
 	unsigned int MPDEBytesFrame;
 	unsigned int DCCMetaSurfaceBytes;
@@ -3365,6 +3375,8 @@ double dml31_CalculateWriteBackDISPCLK(
 		unsigned int HTotal,
 		unsigned int WritebackLineBufferSize)
 {
+	(void)WritebackPixelFormat;
+	(void)WritebackVRatio;
 	double DISPCLK_H, DISPCLK_V, DISPCLK_HB;
 
 	DISPCLK_H = PixelClock * dml_ceil(WritebackHTaps / 8.0, 1) / WritebackHRatio;
@@ -3383,6 +3395,8 @@ static double CalculateWriteBackDelay(
 		int WritebackSourceHeight,
 		unsigned int HTotal)
 {
+	(void)WritebackPixelFormat;
+	(void)WritebackHRatio;
 	double CalculateWriteBackDelay;
 	double Line_length;
 	double Output_lines_last_notclamped;
@@ -5566,6 +5580,9 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		double *Z8StutterExitWatermark,
 		double *Z8StutterEnterPlusExitWatermark)
 {
+	(void)DCFCLK;
+	(void)ReturnBW;
+	(void)DETBufferSizeC;
 	struct vba_vars_st *v = &mode_lib->vba;
 	double EffectiveLBLatencyHidingY;
 	double EffectiveLBLatencyHidingC;
@@ -5831,6 +5848,7 @@ static void CalculateUrgentBurstFactor(
 		double *UrgentBurstFactorChroma,
 		bool *NotEnoughUrgentLatencyHiding)
 {
+	(void)VRatioC;
 	double LinesInDETLuma;
 	double LinesInDETChroma;
 	unsigned int LinesInCursorBuffer;
@@ -6213,6 +6231,8 @@ static void CalculateVMGroupAndRequestTimes(
 		double TimePerVMRequestVBlank[],
 		double TimePerVMRequestFlip[])
 {
+	(void)dpte_row_width_luma_ub;
+	(void)dpte_row_width_chroma_ub;
 	int num_group_per_lower_vm_stage;
 	int num_req_per_lower_vm_stage;
 	int k;
@@ -6350,6 +6370,8 @@ static void CalculateStutterEfficiency(
 		int *Z8NumberOfStutterBurstsPerFrame,
 		double *StutterPeriod)
 {
+	(void)ConfigReturnBufferSizeInKByte;
+
 	struct vba_vars_st *v = &mode_lib->vba;
 
 	double DETBufferingTimeY;
@@ -6649,6 +6671,7 @@ static void CalculateSwathAndDETConfiguration(
 		bool ViewportSizeSupportPerPlane[],
 		bool *ViewportSizeSupport)
 {
+	(void)HRatioChroma;
 	int MaximumSwathHeightY[DC__NUM_DPP__MAX];
 	int MaximumSwathHeightC[DC__NUM_DPP__MAX];
 	int MinimumSwathHeightY;
@@ -6823,6 +6846,7 @@ static void CalculateSwathWidth(
 		int swath_width_luma_ub[],
 		int swath_width_chroma_ub[])
 {
+	(void)BytePerPixY;
 	enum odm_combine_mode MainPlaneODMCombine;
 	int j, k;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index bfeb01477f0c..dfa1bc31eb0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -51,6 +51,7 @@ static double get_refcyc_per_delivery(
 		unsigned int delivery_width,
 		unsigned int req_per_swath_ub)
 {
+	(void)mode_lib;
 	double refcyc_per_delivery = 0.0;
 
 	if (vratio <= 1.0) {
@@ -785,6 +786,7 @@ static void calculate_ttu_cursor(
 		unsigned int cur_width,
 		enum cursor_bpp cur_bpp)
 {
+	(void)mode_lib;
 	unsigned int cur_src_width = cur_width;
 	unsigned int cur_req_size = 0;
 	unsigned int cur_req_width = 0;
@@ -859,6 +861,12 @@ static void dml_rq_dlg_get_dlg_params(
 		const bool ignore_viewport_pos,
 		const bool immediate_flip_support)
 {
+	(void)cstate_en;
+	(void)pstate_en;
+	(void)vm_en;
+	(void)ignore_viewport_pos;
+	(void)immediate_flip_support;
+	(void)dlg_sys_param;
 	const display_pipe_source_params_st *src = &e2e_pipe_param[pipe_idx].pipe.src;
 	const display_pipe_dest_params_st *dst = &e2e_pipe_param[pipe_idx].pipe.dest;
 	const display_clocks_and_cfg_st *clks = &e2e_pipe_param[pipe_idx].clks_cfg;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 9f3938a50240..033fde774337 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -891,6 +891,11 @@ static bool CalculatePrefetchSchedule(
 		double *VUpdateWidthPix,
 		double *VReadyOffsetPix)
 {
+	(void)mode_lib;
+	(void)HostVMMinPageSize;
+	(void)SwathWidthY;
+	(void)SwathWidthC;
+
 	bool MyError = false;
 	unsigned int DPPCycles, DISPCLKCycles;
 	double DSTTotalPixelsAfterScaler;
@@ -1508,6 +1513,10 @@ static void CalculateDCCConfiguration(
 		unsigned int *IndependentBlockLuma,
 		unsigned int *IndependentBlockChroma)
 {
+	(void)SurfaceWidthChroma;
+	(void)SurfaceHeightChroma;
+	(void)BytePerPixelDETY;
+	(void)BytePerPixelDETC;
 	int yuv420;
 	int horz_div_l;
 	int horz_div_c;
@@ -1840,6 +1849,7 @@ static unsigned int CalculateVMAndRowBytes(
 		int *DPDE0BytesFrame,
 		int *MetaPTEBytesFrame)
 {
+	(void)SourcePixelFormat;
 	struct vba_vars_st *v = &mode_lib->vba;
 	unsigned int MPDEBytesFrame;
 	unsigned int DCCMetaSurfaceBytes;
@@ -3471,6 +3481,8 @@ double dml314_CalculateWriteBackDISPCLK(
 		unsigned int HTotal,
 		unsigned int WritebackLineBufferSize)
 {
+	(void)WritebackPixelFormat;
+	(void)WritebackVRatio;
 	double DISPCLK_H, DISPCLK_V, DISPCLK_HB;
 
 	DISPCLK_H = PixelClock * dml_ceil(WritebackHTaps / 8.0, 1) / WritebackHRatio;
@@ -3489,6 +3501,8 @@ static double CalculateWriteBackDelay(
 		int WritebackSourceHeight,
 		unsigned int HTotal)
 {
+	(void)WritebackPixelFormat;
+	(void)WritebackHRatio;
 	double CalculateWriteBackDelay;
 	double Line_length;
 	double Output_lines_last_notclamped;
@@ -5660,6 +5674,9 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		double *Z8StutterExitWatermark,
 		double *Z8StutterEnterPlusExitWatermark)
 {
+	(void)DCFCLK;
+	(void)ReturnBW;
+	(void)DETBufferSizeC;
 	struct vba_vars_st *v = &mode_lib->vba;
 	double EffectiveLBLatencyHidingY;
 	double EffectiveLBLatencyHidingC;
@@ -5925,6 +5942,7 @@ static void CalculateUrgentBurstFactor(
 		double *UrgentBurstFactorChroma,
 		bool *NotEnoughUrgentLatencyHiding)
 {
+	(void)VRatioC;
 	double LinesInDETLuma;
 	double LinesInDETChroma;
 	unsigned int LinesInCursorBuffer;
@@ -6308,6 +6326,8 @@ static void CalculateVMGroupAndRequestTimes(
 		double TimePerVMRequestVBlank[],
 		double TimePerVMRequestFlip[])
 {
+	(void)dpte_row_width_luma_ub;
+	(void)dpte_row_width_chroma_ub;
 	int num_group_per_lower_vm_stage;
 	int num_req_per_lower_vm_stage;
 	int k;
@@ -6445,6 +6465,8 @@ static void CalculateStutterEfficiency(
 		int *Z8NumberOfStutterBurstsPerFrame,
 		double *StutterPeriod)
 {
+	(void)ConfigReturnBufferSizeInKByte;
+
 	struct vba_vars_st *v = &mode_lib->vba;
 
 	double DETBufferingTimeY;
@@ -6743,6 +6765,7 @@ static void CalculateSwathAndDETConfiguration(
 		bool ViewportSizeSupportPerPlane[],
 		bool *ViewportSizeSupport)
 {
+	(void)HRatioChroma;
 	int MaximumSwathHeightY[DC__NUM_DPP__MAX];
 	int MaximumSwathHeightC[DC__NUM_DPP__MAX];
 	int MinimumSwathHeightY;
@@ -6914,6 +6937,7 @@ static void CalculateSwathWidth(
 		int swath_width_luma_ub[],
 		int swath_width_chroma_ub[])
 {
+	(void)BytePerPixY;
 	enum odm_combine_mode MainPlaneODMCombine;
 	int j, k;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index 04df263ff65e..40a916c2a9c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -139,6 +139,7 @@ static double get_refcyc_per_delivery(
 		unsigned int delivery_width,
 		unsigned int req_per_swath_ub)
 {
+	(void)mode_lib;
 	double refcyc_per_delivery = 0.0;
 
 	if (vratio <= 1.0) {
@@ -872,6 +873,7 @@ static void calculate_ttu_cursor(
 		unsigned int cur_width,
 		enum cursor_bpp cur_bpp)
 {
+	(void)mode_lib;
 	unsigned int cur_src_width = cur_width;
 	unsigned int cur_req_size = 0;
 	unsigned int cur_req_width = 0;
@@ -944,6 +946,12 @@ static void dml_rq_dlg_get_dlg_params(
 		const bool ignore_viewport_pos,
 		const bool immediate_flip_support)
 {
+	(void)cstate_en;
+	(void)pstate_en;
+	(void)vm_en;
+	(void)ignore_viewport_pos;
+	(void)immediate_flip_support;
+	(void)dlg_sys_param;
 	const display_pipe_source_params_st *src = &e2e_pipe_param[pipe_idx].pipe.src;
 	const display_pipe_dest_params_st *dst = &e2e_pipe_param[pipe_idx].pipe.dest;
 	const display_clocks_and_cfg_st *clks = &e2e_pipe_param[pipe_idx].clks_cfg;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 8a0f128722b0..e29497204df7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -3488,6 +3488,7 @@ bool dcn32_allow_subvp_high_refresh_rate(struct dc *dc, struct dc_state *context
  */
 double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *context)
 {
+	(void)dc;
 	double max_vratio_pre = __DML_MAX_BW_RATIO_PRE__; // Default value is 4
 	int i;
 
@@ -3593,6 +3594,7 @@ bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, stru
 
 void dcn32_set_clock_limits(const struct _vcs_dpi_soc_bounding_box_st *soc_bb)
 {
+	(void)soc_bb;
 	dc_assert_fp_enabled();
 	dcn3_2_soc.clock_limits[0].dcfclk_mhz = 1200.0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 19b142412a84..5e72966a8daf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -457,6 +457,7 @@ void dml32_CalculateSwathAndDETConfiguration(
 		bool ViewportSizeSupportPerSurface[],
 		bool *ViewportSizeSupport)
 {
+	(void)HRatioChroma;
 	unsigned int MaximumSwathHeightY[DC__NUM_DPP__MAX];
 	unsigned int MaximumSwathHeightC[DC__NUM_DPP__MAX];
 	unsigned int RoundedUpMaxSwathSizeBytesY[DC__NUM_DPP__MAX] = { 0 };
@@ -716,6 +717,7 @@ void dml32_CalculateSwathWidth(
 		unsigned int			swath_width_luma_ub[], // per-pipe
 		unsigned int			swath_width_chroma_ub[]) // per-pipe
 {
+	(void)BytePerPixY;
 	unsigned int k, j;
 	enum odm_combine_mode MainSurfaceODMMode;
 
@@ -2304,6 +2306,7 @@ unsigned int dml32_CalculateVMAndRowBytes(
 		unsigned int    *DPDE0BytesFrame,
 		unsigned int    *MetaPTEBytesFrame)
 {
+	(void)SourcePixelFormat;
 	unsigned int MPDEBytesFrame;
 	unsigned int DCCMetaSurfaceBytes;
 	unsigned int ExtraDPDEBytesFrame;
@@ -2745,6 +2748,7 @@ void dml32_CalculateUrgentBurstFactor(
 		double *UrgentBurstFactorChroma,
 		bool   *NotEnoughUrgentLatencyHiding)
 {
+	(void)VRatioC;
 	double       LinesInDETLuma;
 	double       LinesInDETChroma;
 	unsigned int LinesInCursorBuffer;
@@ -2900,6 +2904,8 @@ double dml32_CalculateWriteBackDelay(
 		unsigned int         WritebackSourceHeight,
 		unsigned int HTotal)
 {
+	(void)WritebackPixelFormat;
+	(void)WritebackHRatio;
 	double CalculateWriteBackDelay;
 	double Line_length;
 	double Output_lines_last_notclamped;
@@ -2977,6 +2983,9 @@ void dml32_UseMinimumDCFCLK(
 		/* Output */
 		double DCFCLKState[][2])
 {
+	(void)MaxAveragePercentOfIdealSDPPortBWDisplayCanUseInNormalSystemOperation;
+	(void)ReadBandwidthLuma;
+	(void)ReadBandwidthChroma;
 	unsigned int i, j, k;
 	unsigned int     dummy1;
 	double dummy2, dummy3;
@@ -3447,6 +3456,8 @@ bool dml32_CalculatePrefetchSchedule(
 		double   *VUpdateWidthPix,
 		double   *VReadyOffsetPix)
 {
+	(void)SwathWidthY;
+	(void)SwathWidthC;
 	double DPPCLKDelaySubtotalPlusCNVCFormater = v->DPPCLKDelaySubtotal + v->DPPCLKDelayCNVCFormater;
 	bool MyError = false;
 	unsigned int DPPCycles, DISPCLKCycles;
@@ -4145,6 +4156,7 @@ void dml32_CalculateFlipSchedule(
 		double *final_flip_bw,
 		bool *ImmediateFlipSupportedForPipe)
 {
+	(void)HostVMMinPageSize;
 	double min_row_time = 0.0;
 	unsigned int HostVMDynamicLevelsTrips;
 	double TimeForFetchingMetaPTEImmediateFlip;
@@ -4287,6 +4299,8 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 		bool *USRRetrainingSupport,
 		double ActiveDRAMClockChangeLatencyMargin[])
 {
+	(void)DCFCLK;
+	(void)ReturnBW;
 	unsigned int i, j, k;
 	unsigned int SurfaceWithMinActiveFCLKChangeMargin = 0;
 	unsigned int DRAMClockChangeSupportNumber = 0;
@@ -4655,6 +4669,8 @@ double dml32_CalculateWriteBackDISPCLK(
 		unsigned int WritebackLineBufferSize,
 		double DISPCLKDPPCLKVCOSpeed)
 {
+	(void)WritebackPixelFormat;
+	(void)WritebackVRatio;
 	double DISPCLK_H, DISPCLK_V, DISPCLK_HB;
 
 	DISPCLK_H = PixelClock * dml_ceil(WritebackHTaps / 8.0, 1) / WritebackHRatio;
@@ -5166,6 +5182,8 @@ void dml32_CalculateVMGroupAndRequestTimes(
 		double      TimePerVMRequestVBlank[],
 		double      TimePerVMRequestFlip[])
 {
+	(void)dpte_row_width_luma_ub;
+	(void)dpte_row_width_chroma_ub;
 	unsigned int k;
 	unsigned int   num_group_per_lower_vm_stage;
 	unsigned int   num_req_per_lower_vm_stage;
@@ -5321,6 +5339,11 @@ void dml32_CalculateDCCConfiguration(
 		unsigned int        *IndependentBlockLuma,
 		unsigned int        *IndependentBlockChroma)
 {
+	(void)SurfaceWidthChroma;
+	(void)SurfaceHeightChroma;
+	(void)TilingFormat;
+	(void)BytePerPixelDETY;
+	(void)BytePerPixelDETC;
 	typedef enum {
 		REQ_256Bytes,
 		REQ_128BytesNonContiguous,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 6713cd8ba86a..7f40048dd67d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -202,6 +202,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 
 void dcn35_build_wm_range_table_fpu(struct clk_mgr *clk_mgr)
 {
+	(void)clk_mgr;
 	//TODO
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
index da0cfbb071e6..684779ee54a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
@@ -162,6 +162,7 @@ void dml_log_pipe_params(
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt)
 {
+	(void)mode_lib;
 	display_pipe_source_params_st *pipe_src;
 	display_pipe_dest_params_st   *pipe_dest;
 	scaler_ratio_depth_st         *scale_ratio_depth;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
index 12ff65b6a7e5..3f27293a41cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
@@ -49,6 +49,8 @@ void print__rq_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dp
 
 void print__data_rq_sizing_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_sizing_params_st *rq_sizing)
 {
+	(void)mode_lib;
+	(void)rq_sizing;
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_DATA_RQ_SIZING_PARAM_ST\n");
 	dml_print("DML_RQ_DLG_CALC:    chunk_bytes           = %0d\n", rq_sizing->chunk_bytes);
@@ -64,6 +66,8 @@ void print__data_rq_sizing_params_st(struct display_mode_lib *mode_lib, const st
 
 void print__data_rq_dlg_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_dlg_params_st *rq_dlg_param)
 {
+	(void)mode_lib;
+	(void)rq_dlg_param;
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_DATA_RQ_DLG_PARAM_ST\n");
 	dml_print(
@@ -107,6 +111,8 @@ void print__data_rq_dlg_params_st(struct display_mode_lib *mode_lib, const struc
 
 void print__data_rq_misc_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_misc_params_st *rq_misc_param)
 {
+	(void)mode_lib;
+	(void)rq_misc_param;
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_DATA_RQ_MISC_PARAM_ST\n");
 	dml_print(
@@ -124,6 +130,8 @@ void print__data_rq_misc_params_st(struct display_mode_lib *mode_lib, const stru
 
 void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_dlg_sys_params_st *dlg_sys_param)
 {
+	(void)dlg_sys_param;
+	(void)mode_lib;
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_RQ_DLG_PARAM_ST\n");
 	dml_print("DML_RQ_DLG_CALC:    t_mclk_wm_us         = %3.2f\n", dlg_sys_param->t_mclk_wm_us);
@@ -144,6 +152,8 @@ void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, const struct _v
 
 void print__data_rq_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_regs_st *rq_regs)
 {
+	(void)mode_lib;
+	(void)rq_regs;
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_DATA_RQ_REGS_ST\n");
 	dml_print("DML_RQ_DLG_CALC:    chunk_size              = 0x%0x\n", rq_regs->chunk_size);
@@ -179,6 +189,8 @@ void print__rq_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_
 
 void print__dlg_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_dlg_regs_st *dlg_regs)
 {
+	(void)dlg_regs;
+	(void)mode_lib;
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_DLG_REGS_ST\n");
 	dml_print(
@@ -316,6 +328,8 @@ void print__dlg_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi
 
 void print__ttu_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_ttu_regs_st *ttu_regs)
 {
+	(void)mode_lib;
+	(void)ttu_regs;
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_TTU_REGS_ST\n");
 	dml_print(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
index 88dc2b97e7bf..cf194bcba455 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -104,6 +104,7 @@ static double get_refcyc_per_delivery(
 		unsigned int delivery_width,
 		unsigned int req_per_swath_ub)
 {
+	(void)mode_lib;
 	double refcyc_per_delivery = 0.0;
 
 	if (vratio <= 1.0) {
@@ -133,6 +134,7 @@ static double get_vratio_pre(
 		double vinit,
 		double l_sw)
 {
+	(void)mode_lib;
 	double prefill = dml_floor(vinit, 1);
 	double vratio_pre = 1.0;
 
@@ -174,6 +176,7 @@ static void get_swath_need(
 		unsigned int swath_height,
 		double vinit)
 {
+	(void)mode_lib;
 	double prefill = dml_floor(vinit, 1);
 	unsigned int max_partial_sw_int;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index 0e70ffc784b1..ef605e0a75e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -288,6 +288,7 @@ void dpp1_cnv_setup (
 		enum dc_color_space input_color_space,
 		struct cnv_alpha_2bit_lut *alpha_2bit_lut)
 {
+	(void)alpha_2bit_lut;
 	uint32_t pixel_format;
 	uint32_t alpha_en;
 	enum pixel_format_description fmt ;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c
index c433f4b876e9..8d5000790904 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c
@@ -92,7 +92,10 @@ void dpp2_power_on_obuf(
 void dpp2_dummy_program_input_lut(
 		struct dpp *dpp_base,
 		const struct dc_gamma *gamma)
-{}
+{
+	(void)dpp_base;
+	(void)gamma;
+}
 
 static void dpp2_cnv_setup (
 		struct dpp *dpp_base,
@@ -369,7 +372,11 @@ void oppn20_dummy_program_regamma_pwl(
 		struct dpp *dpp,
 		const struct pwl_params *params,
 		enum opp_regamma mode)
-{}
+{
+	(void)dpp;
+	(void)params;
+	(void)mode;
+}
 
 static struct dpp_funcs dcn20_dpp_funcs = {
 	.dpp_read_state = dpp20_read_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
index 31613372e214..26f9485f165d 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
@@ -1016,6 +1016,7 @@ static void dpp20_set_3dlut_mode(
 		bool is_color_channel_12bits,
 		bool is_lut_size17x17x17)
 {
+	(void)is_color_channel_12bits;
 	uint32_t lut_mode;
 	struct dcn20_dpp *dpp = TO_DCN20_DPP(dpp_base);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 8a146968ee15..e7880fc61b4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -1307,6 +1307,7 @@ static void dpp3_set_3dlut_mode(
 		bool is_color_channel_12bits,
 		bool is_lut_size17x17x17)
 {
+	(void)is_color_channel_12bits;
 	uint32_t lut_mode;
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
index 3284084ca7ad..8170a86ad0ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
@@ -80,6 +80,7 @@ static void dpp3_program_gammcor_lut(
 		uint32_t num,
 		bool is_ram_a)
 {
+	(void)is_ram_a;
 	uint32_t i;
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 	uint32_t last_base_value_red = rgb[num-1].red_reg + rgb[num-1].delta_red_reg;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index 62bf7cea21d8..821d5173b59f 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -132,6 +132,9 @@ void dpp401_set_cursor_position(
 	uint32_t width,
 	uint32_t height)
 {
+	(void)param;
+	(void)width;
+	(void)height;
 	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
@@ -237,6 +240,8 @@ void dpp401_set_cursor_matrix(
 	enum dc_color_space color_space,
 	struct dc_csc_transform cursor_csc_color_matrix)
 {
+	(void)color_space;
+	(void)cursor_csc_color_matrix;
 	//Since we don't have cursor matrix information, force bypass mode by passing in unknown color space
 	dpp401_program_cursor_csc(dpp_base, COLOR_SPACE_UNKNOWN, NULL);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c b/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c
index bc058f682438..0ee4f83a02eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c
+++ b/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c
@@ -45,6 +45,7 @@
 
 static bool dwb3_get_caps(struct dwbc *dwbc, struct dwb_caps *caps)
 {
+	(void)dwbc;
 	if (caps) {
 		caps->adapter_id = 0;	/* we only support 1 adapter currently */
 		caps->hw_version = DCN_VERSION_3_0;
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
index dcbcf6b85abf..e7e1d9979876 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
@@ -45,6 +45,7 @@ static bool offset_to_id(
 	enum gpio_id *id,
 	uint32_t *en)
 {
+	(void)mask;
 	switch (offset) {
 	/* HPD */
 	case REG(HPD0_DC_HPD_INT_STATUS):
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index f3d562c8df4c..d81a71ac00d2 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -60,6 +60,7 @@ bool dal_hw_factory_init(
 	enum dce_version dce_version,
 	enum dce_environment dce_environment)
 {
+	(void)dce_environment;
 	switch (dce_version) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
 	case DCE_VERSION_6_0:
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c
index 660510842ecf..f0d400972897 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c
@@ -199,5 +199,6 @@ void dal_hw_gpio_construct(
 void dal_hw_gpio_destruct(
 	struct hw_gpio *pin)
 {
+	(void)pin;
 	ASSERT(!pin->base.opened);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index 1c977fc4d0e3..e6e36a912b13 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -64,6 +64,7 @@ bool dal_hw_translate_init(
 	enum dce_version dce_version,
 	enum dce_environment dce_environment)
 {
+	(void)dce_environment;
 	switch (dce_version) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
 	case DCE_VERSION_6_0:
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
index 5a03758e3de6..3c298192f359 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
@@ -943,6 +943,7 @@ static void hubbub31_get_dchub_ref_freq(struct hubbub *hubbub,
 		unsigned int dccg_ref_freq_inKhz,
 		unsigned int *dchub_ref_freq_inKhz)
 {
+	(void)dccg_ref_freq_inKhz;
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 	uint32_t ref_div = 0;
 	uint32_t ref_en = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
index 43ba399f4822..82d4e3e0e5e8 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
@@ -259,6 +259,7 @@ void hubbub35_get_dchub_ref_freq(struct hubbub *hubbub,
 		unsigned int dccg_ref_freq_inKhz,
 		unsigned int *dchub_ref_freq_inKhz)
 {
+	(void)dccg_ref_freq_inKhz;
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 	uint32_t ref_div = 0;
 	uint32_t ref_en = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index b0a4b68cf359..3b9542c08f3d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -70,6 +70,7 @@ bool hubbub401_program_urgent_watermarks(
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
+	(void)refclk_mhz;
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 	bool wm_pending = false;
 
@@ -188,6 +189,7 @@ bool hubbub401_program_stutter_watermarks(
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
+	(void)refclk_mhz;
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 	bool wm_pending = false;
 
@@ -287,6 +289,7 @@ bool hubbub401_program_pstate_watermarks(
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
+	(void)refclk_mhz;
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 	bool wm_pending = false;
 
@@ -414,6 +417,7 @@ bool hubbub401_program_usr_watermarks(
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
+	(void)refclk_mhz;
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 	bool wm_pending = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
index a436fa71d4b4..73b6b0ffcb74 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
@@ -488,6 +488,8 @@ static bool hubbub42_program_watermarks(
 
 static void hubbub42_set_request_limit(struct hubbub *hubbub, int memory_channel_count, int words_per_channel)
 {
+	(void)memory_channel_count;
+	(void)words_per_channel;
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 	uint32_t request_limit = 96; //MAX(12 * memory_channel_count, 96);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index 6378e3fd7249..7c97a774141f 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -143,6 +143,7 @@ void hubp1_program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
+	(void)pixel_format;
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
 
 	REG_UPDATE_6(DCSURF_ADDR_CONFIG,
@@ -563,6 +564,7 @@ void hubp1_program_surface_config(
 	bool horizontal_mirror,
 	unsigned int compat_level)
 {
+	(void)compat_level;
 	hubp1_dcc_control(hubp, dcc->enable, dcc->independent_64b_blks);
 	hubp1_program_tiling(hubp, tiling_info, format);
 	hubp1_program_size(hubp, format, plane_size, dcc);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index 92288de4cc10..ceee5165fd6a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -313,6 +313,7 @@ static void hubp2_program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
+	(void)pixel_format;
 	REG_UPDATE_3(DCSURF_ADDR_CONFIG,
 			NUM_PIPES, log_2(info->gfx9.num_pipes),
 			PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
@@ -557,6 +558,7 @@ void hubp2_program_surface_config(
 	bool horizontal_mirror,
 	unsigned int compat_level)
 {
+	(void)compat_level;
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
 	hubp2_dcc_control(hubp, dcc->enable, dcc->independent_64b_blks);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 0cc6f4558989..e2708e30eb1b 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -321,6 +321,7 @@ void hubp3_program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
+	(void)pixel_format;
 	REG_UPDATE_4(DCSURF_ADDR_CONFIG,
 		NUM_PIPES, log_2(info->gfx9.num_pipes),
 		PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
@@ -418,6 +419,7 @@ void hubp3_program_surface_config(
 	bool horizontal_mirror,
 	unsigned int compat_level)
 {
+	(void)compat_level;
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
 	hubp3_dcc_control_sienna_cichlid(hubp, dcc);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
index 79c583e258c7..c879f4901c7d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -179,6 +179,7 @@ void hubp35_program_surface_config(
 	bool horizontal_mirror,
 	unsigned int compat_level)
 {
+	(void)compat_level;
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
 	hubp3_dcc_control_sienna_cichlid(hubp, dcc);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 263e0c4d34f6..5a816442deee 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -657,6 +657,7 @@ void hubp401_program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
+	(void)pixel_format;
 	/* DCSURF_ADDR_CONFIG still shows up in reg spec, but does not need to be programmed for DCN4x
 	 * All 4 fields NUM_PIPES, PIPE_INTERLEAVE, MAX_COMPRESSED_FRAGS and NUM_PKRS are irrelevant.
 	 *
@@ -671,6 +672,7 @@ void hubp401_program_size(
 	const struct plane_size *plane_size,
 	struct dc_plane_dcc_param *dcc)
 {
+	(void)dcc;
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 	uint32_t pitch, pitch_c;
 	bool use_pitch_c = false;
@@ -709,6 +711,7 @@ void hubp401_program_surface_config(
 	bool horizontal_mirror,
 	unsigned int compat_level)
 {
+	(void)compat_level;
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
 	hubp401_dcc_control(hubp, dcc);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
index d85a4ab957a4..ad6badcceb12 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
@@ -301,6 +301,7 @@ static void hubp42_program_surface_config(
 	bool horizontal_mirror,
 	unsigned int compat_level)
 {
+	(void)compat_level;
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
 	hubp3_dcc_control_sienna_cichlid(hubp, dcc);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 8f56f164d567..5273ca09fe12 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -201,6 +201,8 @@ static void enable_display_pipe_clock_gating(
 	struct dc_context *ctx,
 	bool clock_gating)
 {
+	(void)ctx;
+	(void)clock_gating;
 	/*TODO*/
 }
 
@@ -284,6 +286,7 @@ static bool
 dce110_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			       const struct dc_plane_state *plane_state)
 {
+	(void)dc;
 	struct input_pixel_processor *ipp = pipe_ctx->plane_res.ipp;
 	const struct dc_transfer_func *tf = NULL;
 	struct ipp_prescale_params prescale_params = { 0 };
@@ -607,6 +610,7 @@ static bool
 dce110_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 				const struct dc_stream_state *stream)
 {
+	(void)dc;
 	struct transform *xfm = pipe_ctx->plane_res.xfm;
 
 	xfm->funcs->opp_power_on_regamma_lut(xfm, true);
@@ -1539,6 +1543,7 @@ static enum dc_status dce110_enable_stream_timing(
 		struct dc_state *context,
 		struct dc *dc)
 {
+	(void)context;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct pipe_ctx *pipe_ctx_old = &dc->current_state->res_ctx.
 			pipe_ctx[pipe_ctx->pipe_idx];
@@ -2728,6 +2733,7 @@ static void program_gamut_remap(struct pipe_ctx *pipe_ctx)
 static void update_plane_addr(const struct dc *dc,
 		struct pipe_ctx *pipe_ctx)
 {
+	(void)dc;
 	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 
 	if (plane_state == NULL)
@@ -2814,6 +2820,8 @@ static void dce110_enable_timing_synchronization(
 		int group_size,
 		struct pipe_ctx *grouped_pipes[])
 {
+	(void)state;
+	(void)group_index;
 	struct dcp_gsl_params gsl_params = { 0 };
 	int i;
 	DC_LOGGER_INIT(dc->ctx);
@@ -2889,6 +2897,8 @@ static void dce110_enable_per_frame_crtc_position_reset(
 
 static void dce110_init_pipes(struct dc *dc, struct dc_state *context)
 {
+	(void)context;
+	(void)dc;
 	// Do nothing
 }
 
@@ -3154,10 +3164,13 @@ static void dce110_post_unlock_program_front_end(
 		struct dc *dc,
 		struct dc_state *context)
 {
+	(void)dc;
+	(void)context;
 }
 
 static void dce110_power_down_fe(struct dc *dc, struct dc_state *state, struct pipe_ctx *pipe_ctx)
 {
+	(void)state;
 	struct dce_hwseq *hws = dc->hwseq;
 	int fe_idx = pipe_ctx->plane_res.mi ?
 		pipe_ctx->plane_res.mi->inst : pipe_ctx->pipe_idx;
@@ -3178,6 +3191,9 @@ static void dce110_wait_for_mpcc_disconnect(
 		struct resource_pool *res_pool,
 		struct pipe_ctx *pipe_ctx)
 {
+	(void)dc;
+	(void)res_pool;
+	(void)pipe_ctx;
 	/* do nothing*/
 }
 
@@ -3187,6 +3203,10 @@ static void program_output_csc(struct dc *dc,
 		uint16_t *matrix,
 		int opp_id)
 {
+	(void)dc;
+	(void)colorspace;
+	(void)matrix;
+	(void)opp_id;
 	int i;
 	struct out_csc_color_matrix tbl_entry;
 
@@ -3331,6 +3351,7 @@ void dce110_enable_lvds_link_output(struct dc_link *link,
 		enum clock_source_id clock_source,
 		uint32_t pixel_clock)
 {
+	(void)link_res;
 	link->link_enc->funcs->enable_lvds_output(
 			link->link_enc,
 			clock_source,
@@ -3345,6 +3366,7 @@ void dce110_enable_tmds_link_output(struct dc_link *link,
 		enum dc_color_depth color_depth,
 		uint32_t pixel_clock)
 {
+	(void)link_res;
 	link->link_enc->funcs->enable_tmds_output(
 			link->link_enc,
 			clock_source,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c
index 2a62f63d0357..0689bbf12ad8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c
@@ -154,6 +154,10 @@ static bool dce120_enable_display_power_gating(
 	struct dc_bios *dcb,
 	enum pipe_gating_control power_gating)
 {
+	(void)dc;
+	(void)controller_id;
+	(void)dcb;
+	(void)power_gating;
 	/* disable for bringup */
 #if 0
 	enum bp_result bp_result = BP_RESULT_OK;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 29673a7b92ec..f1fd372e3826 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -86,6 +86,7 @@ static void print_microsec(struct dc_context *dc_ctx,
 			   struct dc_log_buffer_ctx *log_ctx,
 			   uint32_t ref_cycle)
 {
+	(void)log_ctx;
 	const uint32_t ref_clk_mhz = dc_ctx->dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
 	static const unsigned int frac = 1000;
 	uint32_t us_x10 = (ref_cycle * frac) / ref_clk_mhz;
@@ -252,6 +253,7 @@ void dcn10_lock_all_pipes(struct dc *dc,
 static void log_mpc_crc(struct dc *dc,
 	struct dc_log_buffer_ctx *log_ctx)
 {
+	(void)log_ctx;
 	struct dc_context *dc_ctx = dc->ctx;
 	struct dce_hwseq *hws = dc->hwseq;
 
@@ -450,6 +452,7 @@ static void dcn10_log_hubp_states(struct dc *dc, void *log_ctx)
 static void dcn10_log_color_state(struct dc *dc,
 				  struct dc_log_buffer_ctx *log_ctx)
 {
+	(void)log_ctx;
 	struct dc_context *dc_ctx = dc->ctx;
 	struct resource_pool *pool = dc->res_pool;
 	bool is_gamut_remap_available = false;
@@ -813,6 +816,7 @@ void dcn10_log_hw_state(struct dc *dc,
 
 bool dcn10_did_underflow_occur(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
+	(void)dc;
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 
@@ -1181,6 +1185,7 @@ enum dc_status dcn10_enable_stream_timing(
 		struct dc_state *context,
 		struct dc *dc)
 {
+	(void)context;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	enum dc_color_space color_space;
 	struct tg_color black_color = {0};
@@ -1284,6 +1289,7 @@ static void dcn10_reset_back_end_for_pipe(
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context)
 {
+	(void)context;
 	int i;
 	struct dc_link *link;
 	DC_LOGGER_INIT(dc->ctx);
@@ -1551,6 +1557,7 @@ void dcn10_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 
 void dcn10_disable_plane(struct dc *dc, struct dc_state *state, struct pipe_ctx *pipe_ctx)
 {
+	(void)state;
 	struct dce_hwseq *hws = dc->hwseq;
 	DC_LOGGER_INIT(dc->ctx);
 
@@ -2004,6 +2011,7 @@ static bool patch_address_for_sbs_tb_stereo(
 
 void dcn10_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
+	(void)dc;
 	bool addr_patched = false;
 	PHYSICAL_ADDRESS_LOC addr;
 	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
@@ -2030,6 +2038,7 @@ void dcn10_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 bool dcn10_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			const struct dc_plane_state *plane_state)
 {
+	(void)dc;
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	const struct dc_transfer_func *tf = NULL;
 	bool result = true;
@@ -2472,6 +2481,7 @@ void dcn10_enable_vblanks_synchronization(
 	int group_size,
 	struct pipe_ctx *grouped_pipes[])
 {
+	(void)group_index;
 	struct output_pixel_processor *opp;
 	struct timing_generator *tg;
 	int i, width = 0, height = 0, master;
@@ -2537,6 +2547,7 @@ void dcn10_enable_timing_synchronization(
 	int group_size,
 	struct pipe_ctx *grouped_pipes[])
 {
+	(void)group_index;
 	struct output_pixel_processor *opp;
 	struct timing_generator *tg;
 	int i, width = 0, height = 0;
@@ -2641,6 +2652,7 @@ static void mmhub_read_vm_system_aperture_settings(struct dcn10_hubp *hubp1,
 		struct vm_system_aperture_param *apt,
 		struct dce_hwseq *hws)
 {
+	(void)hubp1;
 	PHYSICAL_ADDRESS_LOC physical_page_number;
 	uint32_t logical_addr_low;
 	uint32_t logical_addr_high;
@@ -2666,6 +2678,7 @@ static void mmhub_read_vm_context0_settings(struct dcn10_hubp *hubp1,
 		struct vm_context0_param *vm0,
 		struct dce_hwseq *hws)
 {
+	(void)hubp1;
 	PHYSICAL_ADDRESS_LOC fb_base;
 	PHYSICAL_ADDRESS_LOC fb_offset;
 	uint32_t fb_base_value;
@@ -2724,6 +2737,7 @@ static void dcn10_enable_plane(
 	struct pipe_ctx *pipe_ctx,
 	struct dc_state *context)
 {
+	(void)context;
 	struct dce_hwseq *hws = dc->hwseq;
 
 	if (dc->debug.sanity_checks) {
@@ -2821,6 +2835,8 @@ void dcn10_program_output_csc(struct dc *dc,
 		uint16_t *matrix,
 		int opp_id)
 {
+	(void)dc;
+	(void)opp_id;
 	if (pipe_ctx->stream->csc_color_matrix.enable_adjustment == true) {
 		if (pipe_ctx->plane_res.dpp->funcs->dpp_set_csc_adjustment != NULL) {
 
@@ -3586,6 +3602,10 @@ bool dcn10_dummy_display_power_gating(
 	struct dc_bios *dcb,
 	enum pipe_gating_control power_gating)
 {
+	(void)dc;
+	(void)controller_id;
+	(void)dcb;
+	(void)power_gating;
 	return true;
 }
 
@@ -4052,6 +4072,7 @@ enum dc_status dcn10_set_clock(struct dc *dc,
 			uint32_t clk_khz,
 			uint32_t stepping)
 {
+	(void)stepping;
 	struct dc_state *context = dc->current_state;
 	struct dc_clock_config clock_cfg = {0};
 	struct dc_clocks *current_clocks = &context->bw_ctx.bw.dcn.clk;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index a673ab0803a8..288e4edaa9a2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -75,6 +75,7 @@
 void dcn20_log_color_state(struct dc *dc,
 			   struct dc_log_buffer_ctx *log_ctx)
 {
+	(void)log_ctx;
 	struct dc_context *dc_ctx = dc->ctx;
 	struct resource_pool *pool = dc->res_pool;
 	bool is_gamut_remap_available = false;
@@ -379,6 +380,7 @@ void dcn20_program_triple_buffer(
 	struct pipe_ctx *pipe_ctx,
 	bool enable_triple_buffer)
 {
+	(void)dc;
 	if (pipe_ctx->plane_res.hubp && pipe_ctx->plane_res.hubp->funcs) {
 		pipe_ctx->plane_res.hubp->funcs->hubp_enable_tripleBuffer(
 			pipe_ctx->plane_res.hubp,
@@ -1175,6 +1177,8 @@ bool dcn20_set_input_transfer_func(struct dc *dc,
 
 void dcn20_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx)
 {
+	(void)context;
+	(void)dc;
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
 	int opp_inst[MAX_PIPES] = { pipe_ctx->stream_res.opp->inst };
@@ -1297,6 +1301,7 @@ static void dcn20_power_on_plane_resources(
 void dcn20_enable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			       struct dc_state *context)
 {
+	(void)context;
 	//if (dc->debug.sanity_checks) {
 	//	dcn10_verify_allow_pstate_change_high(dc);
 	//}
@@ -2652,6 +2657,7 @@ void dcn20_init_vm_ctx(
 		struct dc_virtual_addr_space_config *va_config,
 		int vmid)
 {
+	(void)hws;
 	struct dcn_hubbub_virt_addr_config config;
 
 	if (vmid == 0) {
@@ -2670,6 +2676,7 @@ void dcn20_init_vm_ctx(
 
 int dcn20_init_sys_ctx(struct dce_hwseq *hws, struct dc *dc, struct dc_phy_addr_space_config *pa_config)
 {
+	(void)hws;
 	struct dcn_hubbub_phys_addr_config config;
 
 	config.system_aperture.fb_top = pa_config->system_aperture.fb_top;
@@ -2799,6 +2806,7 @@ void dcn20_reset_back_end_for_pipe(
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context)
 {
+	(void)context;
 	struct dc_link *link = pipe_ctx->stream->link;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	struct dccg *dccg = dc->res_pool->dccg;
@@ -3245,6 +3253,7 @@ void dcn20_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset)
 {
+	(void)dc;
 	pipe_ctx->stream_res.opp->funcs->opp_set_disp_pattern_generator(pipe_ctx->stream_res.opp, test_pattern,
 			color_space, color_depth, solid_color, width, height, offset);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 34d4519b3a17..2aa0f1de8103 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -75,6 +75,7 @@
 void dcn30_log_color_state(struct dc *dc,
 			   struct dc_log_buffer_ctx *log_ctx)
 {
+	(void)log_ctx;
 	struct dc_context *dc_ctx = dc->ctx;
 	struct resource_pool *pool = dc->res_pool;
 	bool is_gamut_remap_available = false;
@@ -1183,6 +1184,7 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset)
 {
+	(void)dc;
 	pipe_ctx->stream_res.opp->funcs->opp_set_disp_pattern_generator(pipe_ctx->stream_res.opp, test_pattern,
 			color_space, color_depth, solid_color, width, height, offset);
 }
@@ -1237,6 +1239,7 @@ void dcn30_get_underflow_debug_data(const struct dc *dc,
 	struct timing_generator *tg,
 	struct dc_underflow_debug_data *out_data)
 {
+	(void)tg;
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 
 	if (hubbub) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c
index 3bc56ac346f3..6e1877a8682d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c
@@ -45,20 +45,31 @@
 
 void dcn303_dpp_pg_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool power_on)
 {
+	(void)dpp_inst;
+	(void)hws;
+	(void)power_on;
 	/*DCN303 removes PG registers*/
 }
 
 void dcn303_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on)
 {
+	(void)hubp_inst;
+	(void)hws;
+	(void)power_on;
 	/*DCN303 removes PG registers*/
 }
 
 void dcn303_dsc_pg_control(struct dce_hwseq *hws, unsigned int dsc_inst, bool power_on)
 {
+	(void)dsc_inst;
+	(void)hws;
+	(void)power_on;
 	/*DCN303 removes PG registers*/
 }
 
 void dcn303_enable_power_gating_plane(struct dce_hwseq *hws, bool enable)
 {
+	(void)enable;
+	(void)hws;
 	/*DCN303 removes PG registers*/
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 1fba44aecdd3..b4afb2bc4493 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -484,6 +484,7 @@ void dcn31_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool p
 
 int dcn31_init_sys_ctx(struct dce_hwseq *hws, struct dc *dc, struct dc_phy_addr_space_config *pa_config)
 {
+	(void)hws;
 	struct dcn_hubbub_phys_addr_config config = {0};
 
 	config.system_aperture.fb_top = pa_config->system_aperture.fb_top;
@@ -511,6 +512,7 @@ static void dcn31_reset_back_end_for_pipe(
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context)
 {
+	(void)context;
 	struct dc_link *link;
 
 	if (pipe_ctx->stream_res.stream_enc == NULL) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 3e239124c17d..858a06b03b57 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -172,6 +172,7 @@ static unsigned int get_odm_config(struct pipe_ctx *pipe_ctx, unsigned int *opp_
 
 void dcn314_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx)
 {
+	(void)context;
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index ef08c98b11e9..b45ceb570a5c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -570,6 +570,7 @@ bool dcn32_set_output_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_stream_state *stream)
 {
+	(void)dc;
 	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
 	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
 	const struct pwl_params *params = NULL;
@@ -1143,6 +1144,7 @@ static unsigned int get_odm_config(struct pipe_ctx *pipe_ctx, unsigned int *opp_
 
 void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx)
 {
+	(void)context;
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 7c25911089b8..f133b52ea958 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -428,6 +428,7 @@ static unsigned int get_odm_config(struct pipe_ctx *pipe_ctx, unsigned int *opp_
 
 void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx)
 {
+	(void)context;
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
@@ -816,6 +817,7 @@ void dcn35_init_pipes(struct dc *dc, struct dc_state *context)
 void dcn35_enable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			       struct dc_state *context)
 {
+	(void)context;
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 
 	/* enable DCFCLK current DCHUB */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index f28a522ea6cd..bf28aa704532 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -551,6 +551,7 @@ bool dcn401_set_output_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_stream_state *stream)
 {
+	(void)dc;
 	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
 	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
 	const struct pwl_params *params = NULL;
@@ -612,6 +613,7 @@ static void enable_stream_timing_calc(
 		struct drr_params *params,
 		unsigned int *event_triggers)
 {
+	(void)dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	int i;
 
@@ -1389,6 +1391,7 @@ void dcn401_dmub_hw_control_lock(struct dc *dc,
 		struct dc_state *context,
 		bool lock)
 {
+	(void)context;
 	/* use always for now */
 	union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
 
@@ -1863,6 +1866,7 @@ void dcn401_reset_back_end_for_pipe(
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context)
 {
+	(void)context;
 	struct dc_link *link = pipe_ctx->stream->link;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 
@@ -3238,6 +3242,7 @@ void dcn401_update_writeback_sequence(
 		struct dc_state *context,
 		struct block_sequence_state *seq_state)
 {
+	(void)context;
 	struct dwbc *dwb;
 	struct mcif_wb *mcif_wb;
 
@@ -3443,6 +3448,7 @@ void dcn401_enable_plane_sequence(struct dc *dc, struct pipe_ctx *pipe_ctx,
 				 struct dc_state *context,
 				 struct block_sequence_state *seq_state)
 {
+	(void)context;
 	struct dce_hwseq *hws = dc->hwseq;
 	uint32_t org_ip_request_cntl = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index ba1813eb3c6c..46f2f9833d9e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -386,6 +386,7 @@ void dcn42_program_cm_hist(
 	struct pipe_ctx *pipe_ctx,
 	const struct dc_plane_state *plane_state)
 {
+	(void)dc;
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 
 	if (dpp && dpp->funcs->dpp_cm_hist_control)
@@ -1000,6 +1001,7 @@ void dcn42_root_clock_control(struct dc *dc,
 }
 void dcn42_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc)
 {
+	(void)dc;
 	struct crtc_stereo_flags flags = { 0 };
 	struct dc_stream_state *stream = pipe_ctx->stream;
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
index 1994a5f40ee9..65a98400c486 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
@@ -183,6 +183,7 @@ bool dal_irq_service_dummy_set(struct irq_service *irq_service,
 			       const struct irq_source_info *info,
 			       bool enable)
 {
+	(void)enable;
 	DC_LOG_ERROR("%s: called for non-implemented irq source, src_id=%u, ext_id=%u\n",
 		     __func__, info->src_id, info->ext_id);
 
@@ -328,6 +329,7 @@ enum dc_irq_source to_dal_irq_source_dce110(
 		uint32_t src_id,
 		uint32_t ext_id)
 {
+	(void)irq_service;
 	switch (src_id) {
 	case VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
index 8c8fc1c6b4ec..7dff8731f414 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
@@ -42,6 +42,9 @@ static enum dc_irq_source to_dal_irq_source_dcn10(struct irq_service *irq_servic
 						  uint32_t src_id,
 						  uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
index 59516b6f84a3..34f9e8a9f488 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
@@ -43,6 +43,9 @@ static enum dc_irq_source to_dal_irq_source_dcn20(
 		uint32_t src_id,
 		uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 8253a5f7adcb..05f7877d2d6c 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -42,6 +42,9 @@ static enum dc_irq_source to_dal_irq_source_dcn21(struct irq_service *irq_servic
 						  uint32_t src_id,
 						  uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index cd128b6fab73..3a7f76364000 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -50,6 +50,9 @@ static enum dc_irq_source to_dal_irq_source_dcn30(
 		uint32_t src_id,
 		uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
index adef0e4ae2bb..f4dfc96310c7 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
@@ -37,6 +37,9 @@
 
 static enum dc_irq_source to_dal_irq_source_dcn302(struct irq_service *irq_service, uint32_t src_id, uint32_t ext_id)
 {
+	(void)ext_id;
+	(void)irq_service;
+	(void)src_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
index 639d649915e5..fdc7624461ac 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
@@ -38,6 +38,9 @@ static enum dc_irq_source to_dal_irq_source_dcn303(struct irq_service *irq_servi
 						   uint32_t src_id,
 						   uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c b/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
index 18049aa0dbd2..5fecd03f9499 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
@@ -40,6 +40,9 @@ static enum dc_irq_source to_dal_irq_source_dcn31(struct irq_service *irq_servic
 						  uint32_t src_id,
 						  uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
index e86f3c03d4d4..a214f13c5a97 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
@@ -42,6 +42,9 @@ static enum dc_irq_source to_dal_irq_source_dcn314(struct irq_service *irq_servi
 						   uint32_t src_id,
 						   uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
index 5f9d90f37ffe..dc2dced7db85 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
@@ -47,6 +47,9 @@ static enum dc_irq_source to_dal_irq_source_dcn315(
 		uint32_t src_id,
 		uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
index 436461730db3..3090ceb66433 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
@@ -41,6 +41,9 @@ static enum dc_irq_source to_dal_irq_source_dcn32(
 		uint32_t src_id,
 		uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c b/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
index 8d252ccbb297..27289279b21c 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
@@ -39,6 +39,9 @@ static enum dc_irq_source to_dal_irq_source_dcn35(
 		uint32_t src_id,
 		uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c b/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
index 3e2f53308cde..7404b572a4e9 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
@@ -18,6 +18,9 @@ static enum dc_irq_source to_dal_irq_source_dcn351(
 		uint32_t src_id,
 		uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c b/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
index 2540e8dc93a0..3dd47a99f568 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
@@ -17,6 +17,9 @@ static enum dc_irq_source to_dal_irq_source_dcn36(
 		uint32_t src_id,
 		uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
index dcfafcee0587..42d9d42ba0b9 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
@@ -20,6 +20,9 @@ static enum dc_irq_source to_dal_irq_source_dcn401(
 		uint32_t src_id,
 		uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c b/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c
index bdf733d37a76..f4d1ce9079de 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c
@@ -19,6 +19,9 @@ static enum dc_irq_source to_dal_irq_source_dcn42(
 	uint32_t src_id,
 	uint32_t ext_id)
 {
+	(void)irq_service;
+	(void)src_id;
+	(void)ext_id;
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK1;
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 693d852b1c40..060460abc377 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -66,6 +66,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 			struct dc_link_settings *link_setting,
 			bool skip_video_pattern)
 {
+	(void)skip_video_pattern;
 	struct pipe_ctx *pipes[MAX_PIPES];
 	struct dc_state *state = link->dc->current_state;
 	struct dc_stream_update stream_update = { 0 };
@@ -483,6 +484,7 @@ static void set_crtc_test_pattern(struct dc_link *link,
 				enum dp_test_pattern test_pattern,
 				enum dp_test_pattern_color_space test_pattern_color_space)
 {
+	(void)test_pattern_color_space;
 	enum controller_dp_test_pattern controller_test_pattern;
 	enum dc_color_depth color_depth = pipe_ctx->
 		stream->timing.display_color_depth;
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
index 5d708039c7cf..2a87b23582f3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
@@ -81,6 +81,10 @@ static void set_dio_dpia_lane_settings(struct dc_link *link,
 		const struct dc_link_settings *link_settings,
 		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
 {
+	(void)link;
+	(void)link_res;
+	(void)link_settings;
+	(void)lane_settings;
 }
 
 static void enable_dpia_link_output(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
index cec68c5dba13..dbbedeeed298 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
@@ -110,6 +110,8 @@ void enable_hpo_dp_link_output(struct dc_link *link,
 		enum clock_source_id clock_source,
 		const struct dc_link_settings *link_settings)
 {
+	(void)signal;
+	(void)clock_source;
 	if (!link_res->hpo_dp_link_enc) {
 		DC_LOG_ERROR("%s: invalid hpo_dp_link_enc\n", __func__);
 		return;
@@ -160,6 +162,7 @@ static void set_hpo_dp_lane_settings(struct dc_link *link,
 		const struct dc_link_settings *link_settings,
 		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
 {
+	(void)link;
 	link_res->hpo_dp_link_enc->funcs->set_ffe(
 			link_res->hpo_dp_link_enc,
 			link_settings,
@@ -170,6 +173,7 @@ void update_hpo_dp_stream_allocation_table(struct dc_link *link,
 		const struct link_resource *link_res,
 		const struct link_mst_stream_allocation_table *table)
 {
+	(void)link;
 	link_res->hpo_dp_link_enc->funcs->update_stream_allocation_table(
 			link_res->hpo_dp_link_enc,
 			table);
@@ -178,6 +182,7 @@ void update_hpo_dp_stream_allocation_table(struct dc_link *link,
 void setup_hpo_dp_audio_output(struct pipe_ctx *pipe_ctx,
 		struct audio_output *audio_output, uint32_t audio_inst)
 {
+	(void)audio_output;
 	pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_audio_setup(
 			pipe_ctx->stream_res.hpo_dp_stream_enc,
 			audio_inst,
@@ -218,6 +223,7 @@ static const struct link_hwss hpo_dp_link_hwss = {
 bool can_use_hpo_dp_link_hwss(const struct dc_link *link,
 		const struct link_resource *link_res)
 {
+	(void)link;
 	return link_res->hpo_dp_link_enc != NULL;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
index 55c5148de800..6d5b7450b205 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
@@ -74,6 +74,7 @@ static void dp_hpo_fixed_vs_pe_retimer_set_tx_ffe(struct dc_link *link,
 static void dp_hpo_fixed_vs_pe_retimer_program_override_test_pattern(struct dc_link *link,
 		struct encoder_set_dp_phy_pattern_param *tp_params)
 {
+	(void)tp_params;
 	uint8_t clk_src = 0xC4;
 	uint8_t pattern = 0x4F; /* SQ128 */
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_virtual.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_virtual.c
index 64742c24f7e6..3aa1375cec71 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_virtual.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_virtual.c
@@ -27,20 +27,26 @@
 
 void virtual_setup_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
+	(void)pipe_ctx;
 }
 
 void virtual_setup_stream_attribute(struct pipe_ctx *pipe_ctx)
 {
+	(void)pipe_ctx;
 }
 
 void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
+	(void)pipe_ctx;
 }
 
 static void virtual_disable_link_output(struct dc_link *link,
 	const struct link_resource *link_res,
 	enum signal_type signal)
 {
+	(void)link;
+	(void)link_res;
+	(void)signal;
 }
 
 static const struct link_hwss virtual_link_hwss = {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index b761f330311f..59851924bfcd 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -823,6 +823,7 @@ static void verify_link_capability_non_destructive(struct dc_link *link)
 static bool should_verify_link_capability_destructively(struct dc_link *link,
 		enum dc_detect_reason reason)
 {
+	(void)reason;
 	bool destrictive = false;
 	struct dc_link_settings max_link_cap;
 	bool is_link_enc_unavailable = false;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index acdc162de535..eb791285ed06 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -391,6 +391,7 @@ static const struct dc_tunnel_settings *get_dp_tunnel_settings(const struct dc_s
  */
 enum dc_status link_validate_dp_tunnel_bandwidth(const struct dc *dc, const struct dc_state *new_ctx)
 {
+	(void)dc;
 	struct dc_validation_dpia_set dpia_link_sets[MAX_DPIA_NUM] = { 0 };
 	uint8_t link_count = 0;
 	enum dc_status result = DC_OK;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 08e2b572e0ff..ddff0db4ce70 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -554,6 +554,7 @@ enum link_training_result dp_check_link_loss_status(
 	struct dc_link *link,
 	const struct link_training_settings *link_training_setting)
 {
+	(void)link_training_setting;
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	union lane_status lane_status;
 	union lane_align_status_updated dpcd_lane_status_updated;
@@ -1387,6 +1388,7 @@ bool dp_set_hw_training_pattern(
 	enum dc_dp_training_pattern pattern,
 	uint32_t offset)
 {
+	(void)offset;
 	enum dp_test_pattern test_pattern = DP_TEST_PATTERN_UNSUPPORTED;
 
 	switch (pattern) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
index 11565f187ac7..1a6bfc45927d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
@@ -158,6 +158,7 @@ static enum link_training_result dp_perform_128b_132b_cds_done_sequence(
 		const struct link_resource *link_res,
 		struct link_training_settings *lt_settings)
 {
+	(void)link_res;
 	/* Assumption: assume hardware has transmitted eq pattern */
 	enum dc_status status = DC_OK;
 	enum link_training_result result = LINK_TRAINING_SUCCESS;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
index 603537ffd128..34fa76d97b83 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
@@ -172,6 +172,7 @@ static uint8_t dpia_build_set_config_data(
 		struct dc_link *link,
 		struct link_training_settings *lt_settings)
 {
+	(void)link;
 	union dpia_set_config_data data;
 
 	data.raw = 0;
@@ -290,6 +291,7 @@ static enum link_training_result dpia_training_cr_non_transparent(
 		struct link_training_settings *lt_settings,
 		uint32_t hop)
 {
+	(void)link_res;
 	enum link_training_result result = LINK_TRAINING_CR_FAIL_LANE0;
 	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
 	enum dc_status status = DC_ERROR_UNEXPECTED;
@@ -457,6 +459,7 @@ static enum link_training_result dpia_training_cr_transparent(
 		const struct link_resource *link_res,
 		struct link_training_settings *lt_settings)
 {
+	(void)link_res;
 	enum link_training_result result = LINK_TRAINING_CR_FAIL_LANE0;
 	enum dc_status status;
 	uint32_t retries_cr = 0; /* Number of consecutive attempts with same VS or PE. */
@@ -585,6 +588,7 @@ static enum link_training_result dpia_training_eq_non_transparent(
 		struct link_training_settings *lt_settings,
 		uint32_t hop)
 {
+	(void)link_res;
 	enum link_training_result result = LINK_TRAINING_EQ_FAIL_EQ;
 	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
 	uint32_t retries_eq = 0;
@@ -730,6 +734,7 @@ static enum link_training_result dpia_training_eq_transparent(
 		const struct link_resource *link_res,
 		struct link_training_settings *lt_settings)
 {
+	(void)link_res;
 	enum link_training_result result = LINK_TRAINING_EQ_FAIL_EQ;
 	uint32_t retries_eq = 0;
 	enum dc_status status;
@@ -991,6 +996,7 @@ enum link_training_result dpia_perform_link_training(
 	const struct dc_link_settings *link_setting,
 	bool skip_video_pattern)
 {
+	(void)skip_video_pattern;
 	enum link_training_result result;
 	struct link_training_settings lt_settings = {0};
 	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
index 584b9295a12a..e4c2aa2bc364 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
@@ -180,6 +180,7 @@ static void dpcd_reduce_address_range(
 		uint8_t * const reduced_data,
 		const uint32_t reduced_size)
 {
+	(void)extended_size;
 	const uint32_t offset = reduced_address - extended_address;
 
 	/*
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
index 8b398b9a2b6b..4c7bb0522a8c 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
@@ -117,6 +117,9 @@ void mpc3_set_out_rate_control(
 	bool rate_2x_mode,
 	struct mpc_dwb_flow_control *flow_control)
 {
+	(void)enable;
+	(void)rate_2x_mode;
+	(void)flow_control;
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 
 	/* Always disable mpc out rate and flow control.
@@ -908,6 +911,7 @@ static void mpc3_set_3dlut_mode(
 		bool is_lut_size17x17x17,
 		uint32_t rmu_idx)
 {
+	(void)is_color_channel_12bits;
 	uint32_t lut_mode;
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
index badcef027b84..1f15ada109b6 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
@@ -884,6 +884,7 @@ void mpc32_set_3dlut_mode(
 		bool is_lut_size17x17x17,
 		uint32_t mpcc_id)
 {
+	(void)is_color_channel_12bits;
 	uint32_t lut_mode;
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
index 45d418636d0c..b49bd155cad4 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
@@ -250,6 +250,7 @@ void opp1_set_dyn_expansion(
 	enum dc_color_depth color_dpth,
 	enum signal_type signal)
 {
+	(void)color_sp;
 	struct dcn10_opp *oppn10 = TO_DCN10_OPP(opp);
 
 	REG_UPDATE_2(FMT_DYNAMIC_EXP_CNTL,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index 6f7b0f816f2a..9e66b9b97c63 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -164,6 +164,7 @@ void optc1_program_timing(
 	const enum signal_type signal,
 	bool use_vbios)
 {
+	(void)use_vbios;
 	struct dc_crtc_timing patched_crtc_timing;
 	uint32_t asic_blank_end;
 	uint32_t asic_blank_start;
@@ -855,6 +856,8 @@ void optc1_set_early_control(
 	struct timing_generator *optc,
 	uint32_t early_cntl)
 {
+	(void)optc;
+	(void)early_cntl;
 	/* asic design change, do not need this control
 	 * empty for share caller logic
 	 */
@@ -1249,6 +1252,7 @@ void optc1_get_crtc_scanoutpos(
 static void optc1_enable_stereo(struct timing_generator *optc,
 	const struct dc_crtc_timing *timing, struct crtc_stereo_flags *flags)
 {
+	(void)timing;
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
 	if (flags) {
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
index e7a90a437fff..39ce4d4a61a1 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
@@ -181,6 +181,7 @@ void optc2_set_odm_bypass(struct timing_generator *optc,
 void optc2_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
 		int segment_width, int last_segment_width)
 {
+	(void)last_segment_width;
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 	uint32_t memory_mask;
 
@@ -261,6 +262,7 @@ static void optc2_align_vblanks(
 	uint8_t master_clock_divider,
 	uint8_t slave_clock_divider)
 {
+	(void)slave_clock_divider;
 	/* accessing slave OTG registers */
 	struct optc *optc1 = DCN10TG_FROM_TG(optc_slave);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
index ee4665aa49e9..d72574db1f07 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
@@ -218,6 +218,7 @@ void optc3_set_odm_bypass(struct timing_generator *optc,
 void optc3_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
 		int segment_width, int last_segment_width)
 {
+	(void)last_segment_width;
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 	uint32_t memory_mask = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index 893d2aff1f82..5f53f8747812 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -43,6 +43,7 @@
 static void optc31_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
 		int segment_width, int last_segment_width)
 {
+	(void)last_segment_width;
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 	uint32_t memory_mask = 0;
 	int mem_count_per_opp = (segment_width + 2559) / 2560;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
index 43ff957288b2..a7cf34937b2f 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
@@ -50,6 +50,7 @@
 static void optc314_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
 		int segment_width, int last_segment_width)
 {
+	(void)last_segment_width;
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 	uint32_t memory_mask = 0;
 	int h_active = segment_width * opp_cnt;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 3dcb0d0c931c..60e546b69a05 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -45,6 +45,7 @@
 static void optc32_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
 		int segment_width, int last_segment_width)
 {
+	(void)last_segment_width;
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 	uint32_t memory_mask = 0;
 	int h_active = segment_width * opp_cnt;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 5aafd0eedf66..a880e4a6d165 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -58,6 +58,7 @@
 static void optc35_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
 		int segment_width, int last_segment_width)
 {
+	(void)last_segment_width;
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 	uint32_t memory_mask = 0;
 	int h_active = segment_width * opp_cnt;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 82d76e7276a3..f5bbfbf42691 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -633,6 +633,7 @@ static struct link_encoder *dce100_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dce110_link_encoder *enc110 =
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
@@ -852,6 +853,7 @@ static enum dc_status build_mapped_resource(
 		struct dc_state *context,
 		struct dc_stream_state *stream)
 {
+	(void)dc;
 	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
 
 	if (!pipe_ctx)
@@ -869,6 +871,7 @@ enum dc_status dce100_validate_bandwidth(
 	struct dc_state *context,
 	enum dc_validate_mode validate_mode)
 {
+	(void)validate_mode;
 	int i;
 	bool at_least_one_pipe = false;
 	struct dc_stream_state *stream = NULL;
@@ -929,6 +932,7 @@ enum dc_status dce100_validate_global(
 		struct dc  *dc,
 		struct dc_state *context)
 {
+	(void)dc;
 	if (!dce100_validate_surface_sets(context))
 		return DC_FAIL_SURFACE_VALIDATE;
 
@@ -964,6 +968,7 @@ static void dce100_destroy_resource_pool(struct resource_pool **pool)
 
 enum dc_status dce100_validate_plane(const struct dc_plane_state *plane_state, struct dc_caps *caps)
 {
+	(void)caps;
 
 	if (plane_state->format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
 		return DC_OK;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
index 7c09825cd9bd..1971237585e4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
@@ -668,6 +668,7 @@ static struct link_encoder *dce110_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dce110_link_encoder *enc110 =
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
@@ -971,6 +972,7 @@ static enum dc_status dce110_validate_bandwidth(
 	struct dc_state *context,
 	enum dc_validate_mode validate_mode)
 {
+	(void)validate_mode;
 	bool result = false;
 
 	DC_LOG_BANDWIDTH_CALCS(
@@ -1043,6 +1045,7 @@ static enum dc_status dce110_validate_bandwidth(
 static enum dc_status dce110_validate_plane(const struct dc_plane_state *plane_state,
 					    struct dc_caps *caps)
 {
+	(void)caps;
 	if (((plane_state->dst_rect.width * 2) < plane_state->src_rect.width) ||
 	    ((plane_state->dst_rect.height * 2) < plane_state->src_rect.height))
 		return DC_FAIL_SURFACE_VALIDATE;
@@ -1099,6 +1102,7 @@ static enum dc_status dce110_validate_global(
 		struct dc *dc,
 		struct dc_state *context)
 {
+	(void)dc;
 	if (!dce110_validate_surface_sets(context))
 		return DC_FAIL_SURFACE_VALIDATE;
 
@@ -1130,6 +1134,7 @@ static struct pipe_ctx *dce110_acquire_underlay(
 		const struct resource_pool *pool,
 		const struct pipe_ctx *opp_head_pipe)
 {
+	(void)cur_ctx;
 	struct dc_stream_state *stream = opp_head_pipe->stream;
 	struct dc *dc = stream->ctx->dc;
 	struct dce_hwseq *hws = dc->hwseq;
@@ -1358,6 +1363,7 @@ static bool dce110_resource_construct(
 	struct dce110_resource_pool *pool,
 	struct hw_asic_id asic_id)
 {
+	(void)asic_id;
 	unsigned int i;
 	struct dc_context *ctx = dc->ctx;
 	struct dc_bios *bp;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 294f3f5016b8..2879df2febf5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -629,6 +629,7 @@ static struct link_encoder *dce112_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dce110_link_encoder *enc110 =
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
@@ -852,6 +853,7 @@ static struct clock_source *find_matching_pll(
 		const struct resource_pool *pool,
 		const struct dc_stream_state *const stream)
 {
+	(void)res_ctx;
 	switch (stream->link->link_enc->transmitter) {
 	case TRANSMITTER_UNIPHY_A:
 		return pool->clock_sources[DCE112_CLK_SRC_PLL0];
@@ -875,6 +877,7 @@ static enum dc_status build_mapped_resource(
 		struct dc_state *context,
 		struct dc_stream_state *stream)
 {
+	(void)dc;
 	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
 
 	if (!pipe_ctx)
@@ -892,6 +895,7 @@ enum dc_status dce112_validate_bandwidth(
 	struct dc_state *context,
 	enum dc_validate_mode validate_mode)
 {
+	(void)validate_mode;
 	bool result = false;
 
 	DC_LOG_BANDWIDTH_CALCS(
@@ -1037,6 +1041,7 @@ static enum dc_status dce112_validate_global(
 		struct dc *dc,
 		struct dc_state *context)
 {
+	(void)dc;
 	if (!dce112_validate_surface_sets(context))
 		return DC_FAIL_SURFACE_VALIDATE;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index 5dd80d2279d2..88c9bfdc647e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -713,6 +713,7 @@ static struct link_encoder *dce120_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dce110_link_encoder *enc110 =
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index bf889f40d9ff..08bd879e00ce 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -735,6 +735,7 @@ static struct link_encoder *dce80_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dce110_link_encoder *enc110 =
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index 70d7ca0b0f86..691bd31ca087 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -738,6 +738,7 @@ static struct link_encoder *dcn10_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dcn10_link_encoder *enc10 =
 		kzalloc(sizeof(struct dcn10_link_encoder), GFP_KERNEL);
 	int link_regs_id;
@@ -1051,6 +1052,7 @@ static enum dc_status build_mapped_resource(
 		struct dc_state *context,
 		struct dc_stream_state *stream)
 {
+	(void)dc;
 	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
 
 	if (!pipe_ctx)
@@ -1085,6 +1087,7 @@ static struct pipe_ctx *dcn10_acquire_free_pipe_for_layer(
 		const struct resource_pool *pool,
 		const struct pipe_ctx *opp_head_pipe)
 {
+	(void)cur_ctx;
 	struct resource_context *res_ctx = &new_ctx->res_ctx;
 	struct pipe_ctx *head_pipe = resource_get_otg_master_for_stream(res_ctx, opp_head_pipe->stream);
 	struct pipe_ctx *idle_pipe = resource_find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index e8d232006dbf..bb7d66b46f61 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -916,6 +916,7 @@ struct link_encoder *dcn20_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 	int link_regs_id;
@@ -1310,6 +1311,7 @@ static enum dc_status build_pipe_hw_param(struct pipe_ctx *pipe_ctx)
 
 enum dc_status dcn20_build_mapped_resource(const struct dc *dc, struct dc_state *context, struct dc_stream_state *stream)
 {
+	(void)dc;
 	enum dc_status status = DC_OK;
 	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
 
@@ -1537,6 +1539,7 @@ void dcn20_split_stream_for_mpc(
 		struct pipe_ctx *primary_pipe,
 		struct pipe_ctx *secondary_pipe)
 {
+	(void)res_ctx;
 	int pipe_idx = secondary_pipe->pipe_idx;
 	struct pipe_ctx *sec_bot_pipe = secondary_pipe->bottom_pipe;
 
@@ -1682,6 +1685,7 @@ struct pipe_ctx *dcn20_find_secondary_pipe(struct dc *dc,
 		const struct resource_pool *pool,
 		const struct pipe_ctx *primary_pipe)
 {
+	(void)pool;
 	struct pipe_ctx *secondary_pipe = NULL;
 
 	if (dc && primary_pipe) {
@@ -2160,6 +2164,7 @@ struct pipe_ctx *dcn20_acquire_free_pipe_for_layer(
 		const struct resource_pool *pool,
 		const struct pipe_ctx *opp_head)
 {
+	(void)cur_ctx;
 	struct resource_context *res_ctx = &new_ctx->res_ctx;
 	struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(res_ctx, opp_head->stream);
 	struct pipe_ctx *sec_dpp_pipe = resource_find_free_secondary_pipe_legacy(res_ctx, pool, otg_master);
@@ -2344,6 +2349,7 @@ static struct _vcs_dpi_ip_params_st *get_asic_rev_ip_params(
 
 static enum dml_project get_dml_project_version(uint32_t hw_internal_rev)
 {
+	(void)hw_internal_rev;
 	return DML_PROJECT_NAVI10v2;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 959001d0a578..10f02d357930 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -1300,6 +1300,7 @@ static struct link_encoder *dcn21_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dcn21_link_encoder *enc21 =
 		kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
 	int link_regs_id;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 0c70677b4544..f1155a6db96f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -926,6 +926,7 @@ static struct link_encoder *dcn30_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 97b6c4ee8532..969409f8746d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -882,6 +882,7 @@ static struct link_encoder *dcn301_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index bb3edfe86a1f..f87a3c05712e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -894,6 +894,7 @@ static struct link_encoder *dcn302_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dcn20_link_encoder *enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
 	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index db627b4aa76a..3989a2fd2a55 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -839,6 +839,7 @@ static struct link_encoder *dcn303_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dcn20_link_encoder *enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
 	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index e14b00cba962..295ff6366462 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1092,6 +1092,7 @@ static struct link_encoder *dcn31_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
@@ -2247,6 +2248,7 @@ enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 	struct pipe_ctx *pipes,
 	struct audio_output *audio_output)
 {
+	(void)link_setting;
 	struct dc_state *state = link->dc->current_state;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index ee1d48158d3c..4df38d9c73f8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1150,6 +1150,7 @@ static struct link_encoder *dcn31_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 999fef8879be..63a84b37c854 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1091,6 +1091,7 @@ static struct link_encoder *dcn31_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index cab523733ce4..66616848ef6c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1084,6 +1084,7 @@ static struct link_encoder *dcn31_link_encoder_create(
 	struct dc_context *ctx,
 	const struct encoder_init_data *enc_init_data)
 {
+	(void)ctx;
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
index f5a4e97c40ce..4808c793590f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
@@ -41,6 +41,7 @@ uint32_t dcn32_helper_calculate_mall_bytes_for_cursor(
 		struct pipe_ctx *pipe_ctx,
 		bool ignore_cursor_buf)
 {
+	(void)dc;
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	uint32_t cursor_size = hubp->curs_attr.pitch * hubp->curs_attr.height;
 	uint32_t cursor_mall_size_bytes = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index b9532ebcced4..c0d37f00fed9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1698,6 +1698,7 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn42_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params)
 {
+	(void)bw_params;
 	dc_assert_fp_enabled();
 
 	if (dc->current_state && dc->current_state->bw_ctx.dml2)
@@ -1774,6 +1775,8 @@ static unsigned int dcn42_get_max_hw_cursor_size(const struct dc *dc,
 			struct dc_state *state,
 			const struct dc_stream_state *stream)
 {
+	(void)state;
+	(void)stream;
 	return dc->caps.max_cursor_size;
 }
 static struct resource_funcs dcn42_res_pool_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
index 1c04171b296c..146a6e47934b 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
@@ -159,6 +159,7 @@ static void dcn42_update_soc_bb_with_values_from_clk_mgr(struct dml2_soc_bb *soc
 
 static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
 {
+	(void)config;
 	/* Individual modification can be overwritten even if it was obtained by a previous function.
 	 * Modifications are acquired in order of priority (lowest to highest).
 	 */
-- 
2.43.0

