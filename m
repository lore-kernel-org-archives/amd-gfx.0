Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D13CD98F2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A3210E0B9;
	Fri, 19 Jun 2026 13:32:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IqNkOMh4";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3874F10E0B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBYAEKkfGdmcAs46URO/Bc0UomMk6DQKVpuUbynJZjMcJ7ECh2a4cAFLkTRj4VC+uSM8eBedD64iNAXUtGjndRNwiFtltT4Gyr7pZuxMBQWiPWbJZyea1OuYcz+B030nr6hiuPhlCkOlyf3X8ORSd9pSzwcBWaAreQs3kvSeHGCyGa0NBXQsg2bd/M1u4pcMp/j1sEh4AeCm1KU4oRUuTGTKtkn0Yub5VmW8eqIwJXpFCboJzu0rwXRJ3MsaR18warogW/noy5S49eW/riffcExL50lLeU/m2NHd1FA8jPh1MZsUAjgTel6QbJlRvu36G+ogWqgKoNEXZqo+pivBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqS5JsAbCSsq5OnpygdgQiigbebd6DvPeeulvRS2U1U=;
 b=EfYp7oye4OT32/nHpkyRpOI23VYRZAnME/bKHmnkNOOl9tZkwvmViAdwAN+ykdKG2FHMqLR7AeFyff1QW0onEWkFt/wZCMf63fuAQrerNxiMZVhwsNG1CGm0dgFmcSW22blKQrXeGH9tyJTexNywFNjmfGB9H/yLpILOw6bWIAqNewpMELc+9fgYHUM6ExMnH3VLcgnbCXsmq2orrJ8G638OudALAj2G7pB+8/9aFuy1hxkoTkh2dTYwQguJ65rzDNJJpENRE3jf9krrvu5XnlhV0D808+5Gc6ZRNLvPpd3YKxLy2jaCnGvS0/w1Ia7tPJuQvgbyp/y3U01AeqgMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqS5JsAbCSsq5OnpygdgQiigbebd6DvPeeulvRS2U1U=;
 b=IqNkOMh4y+DATUfnYgwNFyXtN0zq6aZbu4EWGoZFK//TkD7BAAGG2Svb/kRaM5Ub1PDQWaiSDpSZYlmS2McPwLMXLmf1mnRAFw7QLzpFwF0ujM8cSvrfU6QRrHPInSuO15VuvgnwcrmuiyDkP9j+STPg5jevGxXyaySEf0i9Ym0=
Received: from BN9PR03CA0852.namprd03.prod.outlook.com (2603:10b6:408:13d::17)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 13:32:06 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::5d) by BN9PR03CA0852.outlook.office365.com
 (2603:10b6:408:13d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.16 via Frontend Transport; Fri,
 19 Jun 2026 13:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:05 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:04 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 00/24] DC Patches Jun 19, 2026
Date: Fri, 19 Jun 2026 09:21:15 -0400
Message-ID: <20260619133154.116746-1-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6a37d5-64d1-4861-4aff-08dece072786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: nEkkzw7Ci2CGu4oxEO/fKp0HInfwINXJPvU+E+HrJoNAN9stHYr2ilvdJrwxuTwRgVj5KtThAPFuBGVAcrzHPiliDsmcccczmBM3fKCvX9jX6SFvUJ2pLIhLIJ1Y5HvRmPuItZT8jiggYdGbEqWLIcB4fTPOWp31K40iBzqiaWCs85oKXSsqHZhmUfQ10p5FRD8VHYH/8UnOsUMc/0E+KIPxLy69IyqKgLRXLS48oq0Y1amPGCd5ZNHIKHdR5ppoE0orFRKzzAhIxo0u8T4Ad9xmoTp/Y5e+dSUWwa++IS/4Ngihv77Z88YXcBgNtDrlAVPFABWPj6xiDf55zxPYpPOb0+Sun/JufR6cG7zwZoSBwWsJSLDsr6R1JDjbbmzqfUtrVVB1kEyaCz5kR5Wht6bh4Y8w1LFtVJEh+2l3k50PXeFAyjp9UL1dehphF2lL77djIUhyWyK6nnyxU84Tl509ZCb5/VuWPv2IQofgCHNUgS3IEEqmaXQaLjVmGpVNq5rDoNLL/wABd5nhX4AF6fn24NSYsBQhEsLa+MJdQJHaTZWZTotLHmbWQF/eQsqfeM3DEnppON90ot+rhZwzfaE0FiNPbIxTbbxGxOpDK9QA5TAY5XXRQuz3hFrWm1V/IJEYtvN9IRc/+u04ZZvcl0gA9GQaWpfOSu9oa+0PuVJQS59fEYoampIHkNCWMK8on5pDyRxt3s85veHuyoxPEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lec7pprnvGHCXe1l2jK3XBee7s9xWRKubzOLv60ExdmBTIulHPxuUZZKZ2vbAHNQnTc8CfxRq5R2vjx+AkmAHNfW3UHqBmcL+jQYpjpa0B/y2rtasf1aaI65phWu/nrk2GmgQPJ/BvURYz0UbxQYnV94uvlzlfrdXoXrX/vNAplu/M8umDLkXkphG3s5Ko93uftxfPyf4xUGssqX7JPbrcVC3T99YdmjQSDPqsSqrMgwhzXUW7+jchYIvHKtufA6bhZeiWJKQskQJzMImv7HWmUy+lz6VfmeMTrqBKv4FjW8OzehJEIgehLyMVWul7vfLYKnruPvZC0XDIeP03Wtlpq64OSejAvlava/D/wPkrrjpnz0zlSQo93ohU+tmqkvBwCxuF+KIbscRT0Mll2z3e9tTNjvtwmBzZFlnNunIlJjNshEkgW8YvSUw/85v6WV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:05.5966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6a37d5-64d1-4861-4aff-08dece072786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
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

This DC patchset brings improvements in multiple areas. In summary, we have:

* Fixes on DCN4, cursor, and others;
* Improvements on DPM, DCN4, DCC, and others;
* Code cleanup.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Remove redundant IPS mode case for DCN 4.2

Alvin Lee (1):
  drm/amd/display: Update LSDMA commands to explicitly handle DCC fields

Austin Zheng (2):
  drm/amd/display: Allow Per-DPM De-rates Instead Of A Single Global
    Value
  Add Debug Option To Enable Per-DPM De-rate Usage

Chandana G B (1):
  drm/amd/display: Fix intermittently CRC open failure during active
    rendering

Gabe Teeger (1):
  drm/amd/display: Enable PSR and Replay on DCN4 variant and fix AUX
    instance

George Shen (1):
  drm/amd/display: Add flag to disable dynamic expansion for 12bpc

Harry Wentland (2):
  drm/amd/display: drop redundant colorop type and TF checks
  drm/amd/display: split TF/LUT colorop state lookups into separate
    upfront phases

Ivan Lipski (1):
  drm/amd/display: Reintroduce "Force validation link training on all
    ASICs"

Karen Chen (1):
  drm/amd/display: Disable DPPCLK RCG to fix cursor disappearing

Leo Chen (4):
  drm/amd/display: Update ONO PG Workaround for DCN42
  drm/amd/display: Remove unnecessary DSCCLK enable during DSC PG
  drm/amd/display: Enable HUBP/DPP power gate for DCN42
  drm/amd/display: Refactor Driver PG's skip PG logic

Lohita Mudimela (1):
  drm/amd/display: Integrate power_helpers.c functionality into power.c.

Matthew Stewart (4):
  drm/amd/display: Add dcn42b_soc_and_ip_translator
  drm/amd/display: Fix DCN42 null registers & register masks
  drm/amd/display: Rewrite dccg42_init
  drm/amd/display: Remove DCCG registers not needed in DCN42

Michael Strauss (1):
  drm/amd/display: Add 12bpc Color Ramp Support

Piotr Maziarz (1):
  drm/amd/display: Explicitly declare unsigned ints

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.64.0
  drm/amd/display: Promote DC to 3.2.387

 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  96 +++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   4 -
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     |  18 --
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  11 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  29 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  34 ++-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |  53 ++--
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.h    |  63 +++--
 .../dc/dml/dcn31/display_mode_vba_31.c        |   2 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |   2 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |  38 +++
 .../dml21/inc/dml_top_soc_parameter_types.h   |  13 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  41 ++-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   1 +
 .../drm/amd/display/dc/link/link_detection.c  |   2 +-
 .../dc/link/protocols/link_dp_panel_replay.c  |   6 +-
 .../link/protocols/link_edp_panel_control.c   |  11 +-
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.c  |  51 +++-
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   | 258 +++++++++---------
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.h   |  22 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   1 -
 .../dc/resource/dcn302/dcn302_resource.c      |   1 -
 .../dc/resource/dcn303/dcn303_resource.c      |   1 -
 .../dc/resource/dcn31/dcn31_resource.c        |   1 -
 .../dc/resource/dcn315/dcn315_resource.c      |   1 -
 .../dc/resource/dcn316/dcn316_resource.c      |   1 -
 .../dc/resource/dcn32/dcn32_resource.c        |   1 -
 .../dc/resource/dcn321/dcn321_resource.c      |   1 -
 .../dc/resource/dcn35/dcn35_resource.c        |   1 -
 .../dc/resource/dcn351/dcn351_resource.c      |   1 -
 .../dc/resource/dcn36/dcn36_resource.c        |   1 -
 .../dc/resource/dcn42/dcn42_resource.c        |   4 +-
 .../display/dc/soc_and_ip_translator/Makefile |   3 +
 .../dcn401/dcn401_soc_and_ip_translator.c     |  16 ++
 .../dcn42/dcn42_soc_and_ip_translator.c       |  18 +-
 .../dcn42/dcn42_soc_and_ip_translator.h       |   1 +
 .../dcn42b/dcn42b_soc_and_ip_translator.c     |  42 +++
 .../dcn42b/dcn42b_soc_and_ip_translator.h     |  17 ++
 .../soc_and_ip_translator.c                   |   5 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 111 +++++++-
 .../drm/amd/display/modules/power/Makefile    |   2 +-
 .../gpu/drm/amd/display/modules/power/power.c |   5 +
 .../amd/display/modules/power/power_helpers.c |  39 ---
 46 files changed, 658 insertions(+), 380 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.h
 delete mode 100644 drivers/gpu/drm/amd/display/modules/power/power_helpers.c

--
2.54.0

