Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8FCCA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573BE10E84C;
	Wed, 10 Sep 2025 05:32:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tCFNS6xs";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39F910E84C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbdKp1dtRWjpWO+4CPJLzqy1krdatUoyk/Pb0AdmygWHmLxcCjVzK9qAv5WSn3+dRoKDtVPZ5drCDtgnAvPoJYfZVpJhPsAiun7zDhD/9dBubjBhuQv2d6vz8GaobQWn2ulUPMAKm4Hmpbcx64A4SD4uHF8f6aBvprNmWa27lZDG3YMjoZlXHyk2zD8+uERhlZ7Fwvnm9xAKci2zHhSth9bqTvslDQIZ2e53eUP4mOOKV3wi+a6C6a+K5McG3Jj81xwMig3+jk08nhUPpduSLc+73yQQ/zCSXWmVAEz/+zzWsR/ppXq6Jq+wR6AUSYHMgy1hjLMeysg/nXDPBCaUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01XWouB21VWjscZF3/MoPeiJSQj9o5vCv/yx9tFCzRQ=;
 b=MR7+vlOX1lJheRm+XzI7Ob+P3yeZjwNZUnBlaZm9A5Y4FtC1uCh7f+N8CPESjH4N/slo6aNtxRButpFR8roQFDWI6pE0vzGHYjDRBPXlhDafDCg1oevnw8UxQjhmbdfoCuUH26Dl17AdLp2Brf6xn/C5IRA/h8mbLeFOh8WNzIqjhKwyI6r7WRPT+BTMj6xeUX6ZhR8e+mgerWJfQy/Ahru92MLY198M1Ti4Z63u+a1nAZKAaaiNf0Qg7BUmnxynh0qJed5XhE1CwnpDuLC2WxIjTfvNmU4AheJGVMlDmkdJT7KUL4YQgpoap7cikbr9LE0DklM4x7Ip/9DHahuqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01XWouB21VWjscZF3/MoPeiJSQj9o5vCv/yx9tFCzRQ=;
 b=tCFNS6xsJoPoO2IJQcQIH9CtIeTBO5cxb4IlyBksrdSkc4H64smEju4tXAClE+xPTL/qMKKNP1ypSbjLlOeZMfTuv6TMog0bHWAus0Eiwj2Qhjf07eVrvzvbS3f7rHCMECJezIW260NirpxUdJ0jvdwmW2rjZrSOxCXg0m0R4S4=
Received: from MN2PR05CA0056.namprd05.prod.outlook.com (2603:10b6:208:236::25)
 by CY1PR12MB9628.namprd12.prod.outlook.com (2603:10b6:930:105::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:32:45 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::a2) by MN2PR05CA0056.outlook.office365.com
 (2603:10b6:208:236::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:32:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:32:41 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:32:41 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:32:38 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 00/15] DC Patches September 15, 2025
Date: Wed, 10 Sep 2025 13:30:23 +0800
Message-ID: <20250910053222.2884632-1-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|CY1PR12MB9628:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5e5076-e4e9-4991-46c1-08ddf02b76cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nDRjTW+1PRHqEgykyq08jaLfeTAc/gDCDYMMs26i17NJ6hn5l1NHHZ9IKDNk?=
 =?us-ascii?Q?WWiX2zPi1cqiqIS8aicT2az64ou+pVeiDsss9xLWGFLZLrhdWKX38q4sEx4+?=
 =?us-ascii?Q?ERkPFc4MVBkbdRHlTJBJx2X50oDt1k2z5v+388cq84xt2lD8wahNYGFEDzet?=
 =?us-ascii?Q?Ss76CNY4VDCjNW2jyv/e5ZtDibKluhCR0mnjYI1rRDqIZiw+v+U568x8NC3M?=
 =?us-ascii?Q?5Zd/kIGki17fE/yuC/CFkKEWI0512RSs9ze9rk/UEhzTkxjqrze8S7WzgmDl?=
 =?us-ascii?Q?l0fZsi6VO2Oq6ifzwd20Ly1YCXgxvap4QuRGv0J9jxFCMDqpXqU9VPLeyKy1?=
 =?us-ascii?Q?HIO9HrjS95ADLsWqcVV4tSyqncCULy1PMsboqXWSkNNXXFApWdATX9H8iSGL?=
 =?us-ascii?Q?hLX7BygIMznTOk7BorlVLrZzvzBI1f5KdXXuqJvYa/mQ3f8ZrYhyG0kV0Sz7?=
 =?us-ascii?Q?4tDat/eP2Gq/a/vmcPdTIkVR5IAuGJQWCyVXMexDjo8yIcFKHB/XdVDqo6X/?=
 =?us-ascii?Q?j1lvXZ/MC1kxGMxo5nyO6ZWSk+XWocpBD33dUp5q2U7v6VOlB+XKJTz4JzpU?=
 =?us-ascii?Q?snBmFwJye4hDWSB/r0pOz29k8410ViH99MP4YormtO+cxNJvTkjiLaTtaHZf?=
 =?us-ascii?Q?mppbxaj/IWJyxyqJNa/faBH6XluXOC2zS+6drOTj66644I7McyYYT+pLYerJ?=
 =?us-ascii?Q?XMYNryTzsLml40lr0DJ8WwGWmr7imhL4aJGoQGUzC0jNgdZUflSAlKZJMj9P?=
 =?us-ascii?Q?h/D05ySfkt5Z1X89eFvAhV+djDnWN5Pz+93JECOZwSXeUki4WBHpL9Tn4yj/?=
 =?us-ascii?Q?JMcInV8U1VsyufrjBcRGzT789alp4J3q3TtmMvsVpDLYeScAXcT2zawwPFL5?=
 =?us-ascii?Q?0kqgAp5GjjBKjsWr4CjLANoZrhCBan+ZnmlSsvJxsggrD+GUbHtt9M3EaKb2?=
 =?us-ascii?Q?Q5GJeXTlO5u9qqUgUbKAQITdwiJBZvnLpyHpF0XaBYmrVx85y0AfgU3iFsW+?=
 =?us-ascii?Q?8Puj8Dh4Bnsvn/5i3oLJ3Ku4gLX40gpsrtHcO8QMXuyzvn5uCo+lSoeOFJH6?=
 =?us-ascii?Q?2HMDvz7FwdzPkXx2J1utIEtSNUnJyqT28w8UURfNFvT1w9XY7kGKezgpNx3y?=
 =?us-ascii?Q?f4ItKjUI9ShtM7IjftGfIPQkkL9dRzmzHzr+P6RbrLyqOaoZLkBateQyvj48?=
 =?us-ascii?Q?P3eUpjtxYqpTuIFBwWESudw+2if98DK99k595e05F2NfV+A091fwCoSh83qM?=
 =?us-ascii?Q?ZkTEkEtbxGUGNGEZcAkvuy21IT54/ioCtCNg1l0ThucAVxjQOxtZx0LX83Uw?=
 =?us-ascii?Q?QC8gaYGa7hfy58u0IrJ7YwrL5dFZEBitTcpcMJ/m4J7qo3M5h/KAYI6GRquN?=
 =?us-ascii?Q?z+24SQNG2mRJeq1MjgtGi/P4NrYGT02TklPdc3pB9wcmx23kT/zRA95cs9y5?=
 =?us-ascii?Q?NWXoB2NygouYQ+6cY9SZmrmnJI6HsoVHCgIBgyf0W0Vvz645gB7VAoXV87s9?=
 =?us-ascii?Q?ZDKpWUnZJwxzeJ009UY44bqrH61QAWqYADHF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:32:42.3617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5e5076-e4e9-4991-46c1-08ddf02b76cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9628
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

