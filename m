Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B155CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6AA410E899;
	Wed,  8 Oct 2025 18:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cN4KhcoF";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012067.outbound.protection.outlook.com
 [40.93.195.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED7510E894
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+ZOfrgcGup/QMHMLbAuooFO4cC2A/9i0pqOCU2BwnZa0yenAR7lszsLL7v6Jna18hK+q5I0m2VDB+4JyAZ8AJ5iRsoxKhMsDHI83rF0AehdOtwnbrvKbyWbBYRgK/RxD7kdtK4XkIsPmifNl+oYJcUDZpqc6coF9dn3Hi5pQ8lBW26YtNZoFUMO6nqRdrirR/It68OXHpUUkui1JONhdJ4lsxSOUm1RnegI3Gj9rYG2DtS4T+3mWz73l2hY+q/TjH+MQ9APl/1DDWMYAy6oa+yx8r2Opya+VP1a8rxZ+XZu/f7JMJB++VpIlMCiO9fSvlK14wJSAnENYjuVIDC7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckaUdv/uWiADMgpsByAWC2W7Ri2awpNv1odIqciNkBM=;
 b=UTp7gWmwZGyyxzNpDI+wXQ0/0eQvyS/jk98nCh0WnJntxtbSSWqiTz0I/rmoEZ1lR/oHhvS29z43mNtUq4ibClju8yzIPEWywhc1KfSExL3HXpgGhvcrxwQ6Sjq4prTM749+Cup0TrGnvlFniic8Z06mA8GynsMezif6A/bHSa0WaWNpiFBKCmGDbEqJEWFA2n/1VAihKeq1lIdXpVf/CLkeB1LqfvAIllVuV7KgjADcxV7oi4DDJHZuSQ2cZ68IJZsUWkuJ8w3C9H+3FjN9U362nn8mxMTv53OOFWljSFm+EDyDgYd15isT5D4XPL9sy6hzV3f87+f2n3fN2dEitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckaUdv/uWiADMgpsByAWC2W7Ri2awpNv1odIqciNkBM=;
 b=cN4KhcoF/LUeEGX+r90gAXXCxx6kyPuLOlQVrmfb8PTyUiIaf3rkDKBsvwGPnfx9AfekM2l27bW4fkMjA3Gu5xLs25FlEXQ0PLhlYwYaVNtgjZPQ5YsdiOkVEf21qwPcSRaSLEC/YvLIb+/eUOvkLMvDM5PI2GJIAAknvZaNsV8=
Received: from SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13)
 by BN7PPFFC4F04B28.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ea) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 18:48:47 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::40) by SJ0PR05CA0128.outlook.office365.com
 (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 18:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:48:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:39 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:39 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:39 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/22] DC Patches for 13 Oct 2025
Date: Wed, 8 Oct 2025 14:46:54 -0400
Message-ID: <20251008184839.78916-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|BN7PPFFC4F04B28:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b57856b-7285-487e-6c8f-08de069b4da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vx+fUoB7OlmwCib5dAyBDoNPatJLMDVV2/vFDvmnnNdFTfp0PkkZYilM/Bwn?=
 =?us-ascii?Q?n6aF8ZAzff8Jc0a6TyvY3YuGufIJ2h630m8GrKyy7HyhLZnM5PW9DK1N/q/u?=
 =?us-ascii?Q?exaVrrtMWAx2MCwNISvzCq5DGibL7Ix5j8p6kc/kR5/qIEVcf5YipNJNc+3V?=
 =?us-ascii?Q?qJhi0nc3zWderxayTU8pk9UqcH9dyvEW0oDZj6iSBQEydWI5YLGMen9neusm?=
 =?us-ascii?Q?JULg3Z3zMkNTAag4MpbbNvMXyB0fG4AFavYdHqLwEcJHf+NYzfIPPvwAPCet?=
 =?us-ascii?Q?M3hzgNnT+7CZ+WS4+d4x5DqYvTpcaQRlSGeieu9LQdQ3qMBtUH6JA8KLpwbH?=
 =?us-ascii?Q?M8qPZXFJ13cY7VY1/MXgfX0MdjhvVcLRorhKVN4d/1soJpNH/gyNSsLEZD4a?=
 =?us-ascii?Q?OlBIc5k8svF5UFiQV46lEIvAfByD0yXdhi0ZusDI6i6jfFwHTsOaoA3N1zru?=
 =?us-ascii?Q?ujF4te13N9SfTSr27YxYXHZ8SHrOEVJLDo5zHkZ+rehhe8wVg9jfcyK7Puio?=
 =?us-ascii?Q?GlSD382zwnQaY0buDoPHs90EjNbx2CNTHGHjKdbRHr7xEjpNPboDKwjE8tFu?=
 =?us-ascii?Q?zAicGMIOInjs8gXKnwmJfr+nKws/vyHgoZtEuLnUaRDTdLutuQzEWcZuFbaH?=
 =?us-ascii?Q?Qr3Bhu8rgxpVdDc/UHO8fF1nSDlFFPJHPVudz8Z9qVdKsbgyPaDuAaGdf4Sc?=
 =?us-ascii?Q?Sur2Xvpa93/DEtWGJ5sKtTiJXfjMsb0QRIr/TX/UQiVuozI+z/o5rfyj6J76?=
 =?us-ascii?Q?oDPflLrWDnO18y9WjaI7l35kKimQ+d4QF2B3CR6QUztZ8m8q0vR1Fy+fHaN5?=
 =?us-ascii?Q?IPtYNq2C87qiCVnOf6n8BYK6taKCR/zEZpKQBDyykYaRGVEbwtO+PBnUI4Q3?=
 =?us-ascii?Q?PhTOT9zIs2EZFr72K1YXyywtGE+K2/s5xKohZ7cGDzseP77ZdST6ayvGaFkH?=
 =?us-ascii?Q?NxF9UaVVRF/XW6h4rpcVjxdZn6Oq/JO38gnwJWj9NeryJ1eGpFFoVGw8BhpS?=
 =?us-ascii?Q?83au6nLA+zkOCeJcluXzPFCTCw5USeTQTetdieDBDD2sh/9sdHtTwazuvUW2?=
 =?us-ascii?Q?6yG3GSzjIoVB9LhFf3jFA1AaWtfJKNQkgh0eA8BECYnXQBqBGtUtR8LN+ASx?=
 =?us-ascii?Q?XYoEBm1SZOZmdDO29UtRGeFo+5HMMsydlVMAp3mfEKa65JqhDqEoGzyPrymq?=
 =?us-ascii?Q?VeNXAByQd05q+u6X9D6Aqsg2DaHLODY0sx/shD+ScUM4a+cQkeuPchm7Nnii?=
 =?us-ascii?Q?frVL+tV2JkafV497KeJXqmZYT/7E/hKZLhMcyBPkDx+ZGRhYMF672CSRXNQg?=
 =?us-ascii?Q?URIWLKRgw9ARFY8xX4F86PhXQ9w4NaWEpEZ1pDZS/oPIUAGKOtUGGfjZHoX7?=
 =?us-ascii?Q?ygjFPuTQMeMu92qOv1KGGEHRxoBRpC578Vn7rscYTxPvvBwRCNybTJTtTgyv?=
 =?us-ascii?Q?yNMYUndUV+4UzKwnalvBtK8O71hEKsfU5J+VIcHOuyfQfD+XIlW6BTqRvDFN?=
 =?us-ascii?Q?Q8Xs2avLNe56QRbG0Jf+ZMLO0Q3S1Ww26a2FVrX7itxmNpckeOj7U4dD40JA?=
 =?us-ascii?Q?Cxs37esE6Xp4DdxE4zU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:48:42.4166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b57856b-7285-487e-6c8f-08de069b4da4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFC4F04B28
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

Display Core v3.2.354 release highlights:
    
    * DCN35 dispclk, dppclk & other fixes
    * DCN401 cursor offload fix
    * Add new block seqeunce-building/executing functions
    * null ptr fixes
    * DPIA hpd fix
    * debug improvements
    * Fix performance regression from full updates
    * Firmware Release 0.1.31.0

Cc: Dan Wheeler <daniel.wheeler@amd.com>

---

Alvin Lee (3):
  drm/amd/display: Remove unused field in DML
  drm/amd/display: Update DCN401 path for cursor offload
  drm/amd/display: Update spacing in struct

Aurabindo Pillai (2):
  drm/amd/display: Add sink/link debug logs
  drm/amd/display: use GFP_NOWAIT for allocation in interrupt handler

Charlene Liu (3):
  drm/amd/display: add dispclk ramping to dcn35.
  drm/amd/display: add dccg dfs mask def
  drm/amd/display: increase max link count and fix link->enc NULL
    pointer access

Dominik Kaszewski (2):
  drm/amd/display: Remove dc state from check_update
  drm/amd/display: Fix performance regression from full updates

Harry VanZyllDeJong (1):
  drm/amd/display: fix duplicate aux command with AMD aux backlight

Ilya Bakoulin (1):
  drm/amd/display: add new block sequence-building/executing functions

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix NULL pointer dereference

Ovidiu Bunea (1):
  drm/amd/display: Move all DCCG RCG into HWSS root_clock_control

Peichen Huang (1):
  drm/amd/display: not skip hpd irq for bw alloc mode

Relja Vojvodic (1):
  drm/amd/display: Rework HDMI data channel reads

Samson Tam (1):
  drm/amd/display: Add debug option to override EASF scaler taps

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.31.0
  drm/amd/display: Promote DC to 3.2.354

Wenjing Liu (2):
  drm/amd/display: update perfmon measurement interfaces
  drm/amd/display: add additional hdcp traces

Yihan Zhu (1):
  drm/amd/display: fix dppclk rcg poweron check

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   77 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  131 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 3161 ++++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |    6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |    2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   23 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.h    |    8 +
 .../dml2/dml21/inc/dml_top_dchub_registers.h  |    1 -
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |   70 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |    3 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |    5 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 1356 ++++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   98 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   17 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 1409 +++++++-
 .../display/dc/hwss/hw_sequencer_private.h    |   36 +
 .../amd/display/dc/inc/hw/cursor_reg_cache.h  |    6 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   36 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |    1 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |    8 +-
 .../display/dc/link/accessories/link_dp_cts.c |    3 +-
 .../drm/amd/display/dc/link/link_detection.c  |    4 +
 .../amd/display/dc/link/protocols/link_ddc.c  |    3 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |   19 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |    4 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |   15 +
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |    1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    3 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |    6 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |    2 +-
 .../display/modules/hdcp/hdcp1_execution.c    |   13 +-
 .../display/modules/hdcp/hdcp2_execution.c    |   19 +-
 .../drm/amd/display/modules/hdcp/hdcp_log.h   |    6 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   14 +
 36 files changed, 6245 insertions(+), 325 deletions(-)

-- 
2.51.0

