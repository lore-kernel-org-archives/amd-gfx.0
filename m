Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A446CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2368510E036;
	Wed, 10 Sep 2025 05:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JuMXidmD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7E210E036
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d66SISfJeBqxHa1tBR9h+CaA9b6i2SOLnY2DA3oftIpiAZVcujB+fP3aLBr6jz5KsawPitufsyyE/mncd0+SJQFTIxc23vMjiAv4jjt0vlsRXXezKUG4WS4UaCCRwMIAB/y8um3pZQSWH8OUNUFuWgg1LC44/FzAJJqLARwUne+3vjtv+yS416q1MTUfpgWcPeuIEe40494hcPkAvuVL2RrvOFay62z/RuNATiFNZdTCXYwnSC7v+GPUZ0QQyDHfulTQ6TfUcoT0MnpP5Zz8XHsPpZD3HBpPEpn6MIzE1Cur6XxtDe5tfSbawW9eEG6neFU3ReXLnHXmcxuuxnYtyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01XWouB21VWjscZF3/MoPeiJSQj9o5vCv/yx9tFCzRQ=;
 b=SwkUpTt5ARWqP1RK73+6FiapvG/YhZGpPNtTzK6N/s1cFcpFQOQCfgWdoZytGgO6Dl4d+O2i9OAT5z8CMXmnToqy7i+MT4ZCSwgA1zCJDFhcMcMTQd5GCKiLoOGiQNKZXF4Zdtc6I2H5T6v7CQb47pbq3oT1u8CJEyppXDUBF50n6O0QMz9Kx4k8juRPOgRlTj+L2ddN0Uo19uq15iPDv+o1PK5FVlfxAI9fOG0KgkHb7myqy18CIkBJRqawItdeYotQpE3P0kP/+uTqVnxvZR6gSgbbKmahqw/P0Ub711iC6iJbdo2xdPXWz0ENNW1E9rKH1Fk1a1R0scvNlEMBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01XWouB21VWjscZF3/MoPeiJSQj9o5vCv/yx9tFCzRQ=;
 b=JuMXidmDzDXHEcSc0ldcXCRCEWsOd2Oo3+vSFKrSkLFeH1CbKbOygJneTxFgf3M0PI3YaQg0v6wH/II9j1r8xSpm3hXAH9woIoamaWGW78DFg5tqzdE6nqVw7kL2Wy2dn3rZtveFnzLIc7pxYCKrc5vruXF8xwz20qjb5XIndxk=
Received: from BN9PR03CA0633.namprd03.prod.outlook.com (2603:10b6:408:13b::8)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:26:40 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::16) by BN9PR03CA0633.outlook.office365.com
 (2603:10b6:408:13b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:26:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:26:39 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:26:39 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:26:36 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 00/15] DC Patches September 15, 2020
Date: Wed, 10 Sep 2025 13:22:02 +0800
Message-ID: <20250910052620.2884581-1-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: 3240c20a-f510-431d-ee6d-08ddf02a9ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kT5FAskvOT5PgW3tTm+v/v10qy3yZfwmR5KWg+JYfA9J3oGUktfPriexWDsY?=
 =?us-ascii?Q?dZ9GpH+39TpYGWTSB81SZOw8AVKhP8LVdgp//iarc5UUJsH+uzbqxVZKnFu5?=
 =?us-ascii?Q?bqAJkI4JcHLyIKRBOj8bQqDxkNUa5cYq4zjYyp1vIxs9eWrhYvZc5wuZwR0W?=
 =?us-ascii?Q?jm1KRsBrd9VGv3kq/FtgcvR4AyCXCObZvS88WEyDV5kTzwkypdofgvPUf2oo?=
 =?us-ascii?Q?xlyf8qZO27j60r/CLMxSwyADE/3bq/ZVoyb9wmnqiI+1toRiveUT/e9Ef6b+?=
 =?us-ascii?Q?Fvw/+DXKTQb7VKOQWYIogrZ/BcoJGhKdA9i0doJmADTxzARPL54EZB48FtFi?=
 =?us-ascii?Q?3twFDyAnQKi/HeEhC3EPVrQ3qT+GMAs4TUw8o8f8eHGnGPD5FrYBpvp8LKe0?=
 =?us-ascii?Q?HPiJ4qRVKDkiHwgMXBcyEwxd7iwXCWWXZbh1sevDTYuzfeGzWiooLUA0w+m6?=
 =?us-ascii?Q?/fDm+G+cTC96f0LyiDzvgwGQUCoqgqhxlVsXQu5pX/PqRcQlqIJuR9wu+XDE?=
 =?us-ascii?Q?kw/MlBqjrtDReF+SrAWFg1wDbMzw8l+UH/7Fqhm2rtVTstX9Z0cJiFbd77cz?=
 =?us-ascii?Q?J+OEtgQ6ftpoxAFDivK0fDOjteKotUcLGz4SAUMuLjh2yn0bdG0RepVGCsFd?=
 =?us-ascii?Q?mcGHp/Xj+i6IAvd0zaOBh5IoSmWhMs14CRBiALOMqlhIEQZDoCvi2gH+FOkC?=
 =?us-ascii?Q?0/SgiBLts2et2dX+OmjNRw1RSv2/05VmfFnng6YhcQdvkI1Qya14Zz4oLDJl?=
 =?us-ascii?Q?PuqFn7MtoaoyN8aoh4/x6MLEp5uEGkE8zflfdhlGBX/diYyiTT2YxdzYewug?=
 =?us-ascii?Q?j0h5pMo8YzROjVCZl6Oywc/sWEhNDK8E3uwEtTK5tbQlzbf6989n28cg+5X6?=
 =?us-ascii?Q?bxfZZ5GKoO7k47POmr4/bEgw91+T+2++W1qAbff/CWrI91Uo/HZbW6hVKKp2?=
 =?us-ascii?Q?r1/DxqU94qQHs2rENm82RoZfoNM+M1ND439Hgs96rz49Wq/Rrmu5i2cot/tJ?=
 =?us-ascii?Q?v9sjRmrAmSzOqMdb3FnjfLCpKY//Kb4dE63yykaoHu3bCeEcfMZH1zZ2UPpl?=
 =?us-ascii?Q?ZXoIdJw09k/03578Vw1OP2feEyxULrkG9WgLEUkwEKmRiToMn9awP5kIkfpV?=
 =?us-ascii?Q?bErXgy+SrSePWBXH4E5HfA+LghCPPMf5yuzkx6GGX5BFGr9rVhuFMVGJ8wBt?=
 =?us-ascii?Q?OCEgdysm0R+bsE+ErmZPxHF9UhOhaXvbJgtSL7mg6q9/eMG6H94z1CGM6wQT?=
 =?us-ascii?Q?h8X2Zen0DKBcRFSDBquLjXC5o48qLvHN0ZLJvCALZr9VQgPoT06GPi8rbrNM?=
 =?us-ascii?Q?qJCJrtln+TRIzOzgRuR2luBuMPeUWj0VN5b2BT26MFukTKEwU9KnXqfrVwix?=
 =?us-ascii?Q?pVooYKbCLeGz54Oe5v44mjlRBLx2NA9HvD5nejrE92p2flkXFgSNkD/8uqBW?=
 =?us-ascii?Q?txlJLz18b6RRPuy+9/1I63lfSWkVzap04ZiAU3vBOqXnoUyjOWm9LzVhf0ZA?=
 =?us-ascii?Q?jcLoKBMBc3W5FyR1cRgXObIU+HOoqpn8KVWP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:26:39.8400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3240c20a-f510-431d-ee6d-08ddf02a9ebb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:
 
* Add DSC padding for OVT support
* Setup pixel encoding for YCBCR422
* Fix dml ms order
* Rename header file link.h to link_service.h
* Fix DMUB loading sequence
* Modify link training policy
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Ausef Yousof (1):
  drm/amd/display: fix dml ms order of operations

Charlene Liu (1):
  drm/amd/display: limit one non-related log to dGPU

Dillon Varone (3):
  drm/amd/display: Disable stutter when programming watermarks on dcn32
  drm/amd/display: Add missing post flip calls
  drm/amd/display: re-enable disable_stutter_for_wm_program w/a

Dmytro Laktyushkin (1):
  drm/amd/display: prepare dml 2.1 for new asic

Ivan Lipski (1):
  drm/amd/display: Allow RX6xxx & RX7700 to invoke amdgpu_irq_get/put

Mario Limonciello (2):
  drm/amd/display: Set up pixel encoding for YCBCR422
  drm/amd/display: Add fallback path for YCBCR422

Martin Leung (1):
  Revert "drm/amd/display: Reduce Stack Usage by moving 'audio_output'
    into 'stream_res' v4"

Nicholas Kazlauskas (1):
  drm/amd/display: Fix DMCUB loading sequence for DCN3.2

Relja Vojvodic (1):
  drm/amd/display: Add DSC padding for OVT Support

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.350

Wesley Chalmers (1):
  drm/amd/display: Rename header file link.h to link_service.h

Zhikai Zhai (1):
  drm/amd/display: Modify the link training policy

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 88 ++++++++++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |  2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  2 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  2 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  2 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  2 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  6 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  2 +-
 .../drm/amd/display/dc/core/dc_link_exports.c |  3 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 37 ++++----
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  2 +-
 .../dc/dio/dcn10/dcn10_stream_encoder.c       |  2 +-
 .../dc/dio/dcn20/dcn20_stream_encoder.c       |  2 +-
 .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |  2 +-
 .../dc/dio/dcn314/dcn314_dio_stream_encoder.c |  2 +-
 .../dc/dio/dcn32/dcn32_dio_stream_encoder.c   |  2 +-
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c   |  2 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |  2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  3 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  2 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  2 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |  2 +-
 .../amd/display/dc/dml2/display_mode_core.c   |  2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  | 41 ++++-----
 .../display/dc/dml2/dml21/inc/dml_top_types.h |  6 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |  3 +-
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |  2 +-
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    | 37 ++++++--
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 34 +++----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  4 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 11 ++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   | 15 ++--
 .../display/dc/inc/{link.h => link_service.h} |  6 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  1 +
 .../display/dc/link/accessories/link_dp_cts.c | 13 ++-
 .../display/dc/link/accessories/link_dp_cts.h |  2 +-
 .../dc/link/accessories/link_dp_trace.h       |  2 +-
 .../amd/display/dc/link/hwss/link_hwss_dio.h  |  2 +-
 .../hwss/link_hwss_dio_fixed_vs_pe_retimer.h  |  2 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.h   |  2 +-
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.h    |  2 +-
 .../drm/amd/display/dc/link/link_detection.h  |  2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |  2 +-
 .../drm/amd/display/dc/link/link_factory.h    |  2 +-
 .../drm/amd/display/dc/link/link_resource.h   |  2 +-
 .../drm/amd/display/dc/link/link_validation.h |  2 +-
 .../amd/display/dc/link/protocols/link_ddc.h  |  2 +-
 .../dc/link/protocols/link_dp_capability.h    |  2 +-
 .../display/dc/link/protocols/link_dp_dpia.h  |  2 +-
 .../dc/link/protocols/link_dp_dpia_bw.h       |  2 +-
 .../dc/link/protocols/link_dp_irq_handler.h   |  2 +-
 .../display/dc/link/protocols/link_dp_phy.h   |  2 +-
 .../dc/link/protocols/link_dp_training.c      |  9 ++
 .../dc/link/protocols/link_dp_training.h      |  2 +-
 .../amd/display/dc/link/protocols/link_dpcd.h |  2 +-
 .../link/protocols/link_edp_panel_control.h   |  2 +-
 .../amd/display/dc/link/protocols/link_hpd.h  |  2 +-
 .../dc/resource/dce120/dce120_resource.c      |  2 +-
 .../dc/resource/dcn20/dcn20_resource.c        |  2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  2 +-
 .../dc/resource/dcn302/dcn302_resource.c      |  3 +-
 .../dc/resource/dcn303/dcn303_resource.c      |  2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  5 +-
 .../dc/resource/dcn31/dcn31_resource.h        |  3 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  5 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |  2 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  2 +-
 .../dc/resource/dcn36/dcn36_resource.c        |  2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 53 +++++------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |  8 +-
 90 files changed, 332 insertions(+), 206 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/inc/{link.h => link_service.h} (98%)

-- 
2.43.0

