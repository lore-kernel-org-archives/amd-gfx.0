Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB43D111A7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F22D10E730;
	Wed, 26 Nov 2025 23:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v1ow7Vbf";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF4310E72F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+jE584RvQnq6lEgYwnYT0Q0CYDjLnZLzq99nwSsDAda8szpnuHQxp7mwkqUn73rUCGSqZD272tnP89vEhMDXrqvKwyBwwJINqL675/oak1a1rLH4lusY5V8/1wc3P3veTH6WJis4FZkpPag8KY2ezxjcEpdC/2oLsTm7TPaoXjexc7GZRod2csQTa1RRkREeJUNvlrUS2MWqyXoA2oAxCQ3RlCOArXWiFbCUDV0W0EVwcrHlheCeu+wCPZqm5MKmLH/wdIsbTixjHAhlGOhvdp8/0PeowzMZaVUD3SP4vdl74UdCLVl4L37pxLiWnlmr8IEJhTz8GB2abg7XkO7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Zr8zh128zXDzCAURiZ+8V84RultuCWURcX6nUyWNrQ=;
 b=q+9/7crGN6vQXbH64z5vbPCNlVN4iEBS2GGLJVZ0U8EhWOK5Vzw+Zd61of2q3eZ/qx+HuOaUFhbIza/K8numnaXG4fJ+M4J6I1V7JdYdR1uKtLKWC7xd/4//QP7OWMhjhNnFnrhJuVGEu4rwRPbEek2ezJ8xpxzdUR4W4XlSp0ezzNLr/2w9xXxRXdvoy8AWDU+3knW2E1S6c/J1OnTooRsXQWjrvMOMG0S+0aJ4wBcwEantgo1bEBTikYLf1pil8gcPOELyNS00DTHRFP4cttZK/uuRNYRQdDWeJc6Le/Jr3ceIqVmgNqk/sZhGoTjD4oy8xFqz+eACznP0MF/k4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Zr8zh128zXDzCAURiZ+8V84RultuCWURcX6nUyWNrQ=;
 b=v1ow7VbfEXwjsiEk55o6OD05mdqaihD/GgXAn1xON0UVqJLfgA5D10weHtjwTmGOzU4i/1DCwURXfi40EqulOQMh0Mf4RJ9uYHcheCx7//LPnlDv0M4eKqVTjt5m8cfqhmyGzRHrzEq2/PstT3A9i+SnzCd+ViM6FMt2jqWWmlU=
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 23:06:35 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::7e) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Wed,
 26 Nov 2025 23:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:33 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Nov
 2025 17:06:33 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:27 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 00/14] DC Patches November 26, 2025
Date: Wed, 26 Nov 2025 18:06:00 -0500
Message-ID: <20251126230614.13409-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 1742bf04-18a4-459f-037b-08de2d407236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?92LM2EYjQDl7BYG9xFRfQRtPPxL1G8kx8sZq1+mgRMGEZ9zfSb96CqnRN91q?=
 =?us-ascii?Q?vafp9zWw3/olOR/gKa90iI4rkBJWANkdLsdAaz5i6tHFZTrL0xokVr6eh20Q?=
 =?us-ascii?Q?ozgVHPEIJUG/Gg97ADTb+Cyb8P0qRgTgNQ9+JBINibCb+6cN4gk7G9sP1A4/?=
 =?us-ascii?Q?rv8Aob3lorzbCLiygjv8i9GmrJlkxacia56YoMpnjDrROPOy5dBfHCCx21U8?=
 =?us-ascii?Q?zfMYZCsCz8/YImotQYuwp4MAETpkTQGVSLkpYFR48RlHNUPvI8k1LS1wr1Lt?=
 =?us-ascii?Q?4UV5JvUbsUjeVY8zSuVbb9SCuWkHldof0ftCwQBqcKIameDkINlNkaQLiwQm?=
 =?us-ascii?Q?XgGuSO3XRUncoDsRJZVPmYDCK4GOx2LaBOWNIDCgHxppP7U+J5mamDMgg8ZJ?=
 =?us-ascii?Q?eXJ32h+9dYu/uwdcJua4s6j4RKLvGPtznh62b3O6qXENCo6j4Lsej2RSs+VP?=
 =?us-ascii?Q?dGapBEZYrLxiRnITqYAcnN5j5jqSVNbrqb6iqDvQjTPKiFLOGICE93L1CDRG?=
 =?us-ascii?Q?XS978j1SKuOgaykUYVH047Kvkqk/5G4nKoXgcCaglGk5HPUBeubVuVsk+0+S?=
 =?us-ascii?Q?6wcUY5J3S8ij4g1XD/xDy4VJNeUr3yOTzo4CIs8gELv6KX+7fWpTYo5GWEQW?=
 =?us-ascii?Q?c3+WR6m0ZZb+BsFTmwKzhEeBuYNdNNdlFvGkbKGl9KaDpGE+0tg8QtR1jufT?=
 =?us-ascii?Q?rge89xtOf7JrXOPk/zxf24qvbmd75vxJEGCJ+L899OdAZpa0K/hEaMLMqz+m?=
 =?us-ascii?Q?/qx07011THp5VCVkB5Dg9Tn92KDpDqTT9X9+AHNbPOlz46Ci2epbAucYP6Ou?=
 =?us-ascii?Q?E7XjXZ3AQwxdyZOqbayAdxGfWww6vipLe6xxy36MpvRKfnKHXFB7IxaAchYM?=
 =?us-ascii?Q?B7bCp1dFUWa78MArwXsy4+7jKuz0ARStkdzkPIAL2iHhVYmGlzf8eGDx5AB4?=
 =?us-ascii?Q?4SbxMheQzIgxM+4YernQCiFyq/asP2aqp2JAjaTFmfJgr1O425eeOPYMepkY?=
 =?us-ascii?Q?s5NZJfXox/DdEDirM2yYfcRrsot9OemibpfHkPbKo6nGsl08PPgPl/dClz5h?=
 =?us-ascii?Q?YlYqQrJKmEJnQ+GC1zzjR9hRH/Kfzz8NMtsNlNS3aOi3Fmcy6gQPjN3rTQ5m?=
 =?us-ascii?Q?8spK0aWuruALCdnWSh55ZFdGU8q/VkIDlnVq2Hkhx12z8fPrDdQicpcBDR+S?=
 =?us-ascii?Q?UMxee44PoUglX6HE7Z1ExWc7x0dVr6ps90H1l83kQmM2ZUQ6MmtqkfX2jK2r?=
 =?us-ascii?Q?AKHDggoIbKMz91IGlZuCKuBn5xdubjgax5HwxjP2bUy2D9fusbkCO6wD5lXB?=
 =?us-ascii?Q?Zks+XzqRgu/Ihg7oSN7ajDKWkuguZ3zwWXagV9vnHeVeXJ/qekgQ5FkxB11g?=
 =?us-ascii?Q?OJ/SQHg82QHYvY8GP1elidrfrMcdIIy/NOucewm753cUwd9VE4qM4sbcw4OE?=
 =?us-ascii?Q?HYshian/9Qi81HUvByd+AZ080DcNes07ukQwXK/HtpXZQMG8reKeNCBybxtD?=
 =?us-ascii?Q?8mVOXbdC7vR+HhGgoM0dAFmQF14/u8TgxEBDeW2b88sJbWLo5jnnpkDo1hI8?=
 =?us-ascii?Q?xPmkGDRv9wH7qRCepG8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:35.0124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1742bf04-18a4-459f-037b-08de2d407236
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
* Add configurable SPL namespace prefix.
* Add register definitions in dcn_hubbub_registers.
* Add additional info from DML.
* Add dc interface for query QoS information.
* Fix wrong x_pos and y_pos for cursor offload.
* Fix Smart Power OLED not working after S4.
* Fix double cursor when switching between hw and sw cursor.
* Refactor HPD to increase flexibility.
* Remove unused encoder types.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Charlene Liu (1):
  drm/amd/display: add register definitions in dcn_hubbub_registers

Dillon Varone (1):
  drm/amd/display: Guard FAMS2 configuration updates

Dmytro Laktyushkin (1):
  drm/amd/display: refactor HPD to increase flexibility

Ian Chen (1):
  drm/amd/display: fix Smart Power OLED not working after S4

Ivan Lipski (3):
  drm/amd/display: Remove unused encoder types
  drm/amd/display: Use local variable for analog_engine initialization
  drm/amd/display: Move RGB-type check for audio sync to DCE HW sequence

Jing Zhou (1):
  drm/amd/display: Correct FIXED_VS Link Rate Toggle Condition

Navid Assadian (1):
  drm/amd/display - dc: Add configurable SPL namespace prefix

Nevenko Stupar (1):
  drm/amd/display: Add additional info from DML

Nicholas Kazlauskas (2):
  drm/amd/display: Fix wrong x_pos and y_pos for cursor offload
  drm/amd/display: Reset pipe mask at beginning of cursor offload

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.361

Wenjing Liu (1):
  drm/amd/display: add dc interface for query QoS information

 drivers/gpu/drm/amd/display/dc/core/dc.c      |  30 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |  39 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  18 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |  47 +++-
 .../drm/amd/display/dc/dce/dce_link_encoder.h |   8 +-
 .../display/dc/dcn201/dcn201_link_encoder.c   |   3 +
 .../amd/display/dc/dcn21/dcn21_link_encoder.c |   3 +
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |  43 ++++
 .../display/dc/dio/dcn10/dcn10_link_encoder.h |  11 +-
 .../display/dc/dio/dcn20/dcn20_link_encoder.c |   3 +
 .../dc/dio/dcn30/dcn30_dio_link_encoder.c     |   3 +
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c   |   3 +
 .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |   3 +
 .../dc/dio/dcn32/dcn32_dio_link_encoder.c     |   3 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |   3 +
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |   3 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |   3 +
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |   6 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  14 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  25 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  17 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  37 +++
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   4 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |   3 -
 .../drm/amd/display/dc/link/link_detection.c  |  10 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   3 +-
 .../drm/amd/display/dc/link/link_factory.c    | 240 +++++++++---------
 .../link_dp_training_fixed_vs_pe_retimer.c    |   2 +-
 .../amd/display/dc/link/protocols/link_hpd.c  | 165 ++++--------
 .../amd/display/dc/link/protocols/link_hpd.h  |   1 -
 .../dc/resource/dcn32/dcn32_resource.h        |   5 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  | 186 +++++++-------
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h  |   8 -
 .../drm/amd/display/dc/sspl/dc_spl_filters.c  |   4 +-
 .../drm/amd/display/dc/sspl/dc_spl_filters.h  |   4 +-
 .../display/dc/sspl/dc_spl_isharp_filters.c   |  31 +--
 .../display/dc/sspl/dc_spl_isharp_filters.h   |  16 +-
 .../display/dc/sspl/dc_spl_scl_easf_filters.c | 155 +++++------
 .../display/dc/sspl/dc_spl_scl_easf_filters.h |  37 +--
 .../amd/display/dc/sspl/dc_spl_scl_filters.c  |  27 +-
 .../amd/display/dc/sspl/dc_spl_scl_filters.h  |   3 +-
 .../amd/display/dc/sspl/spl_custom_float.c    |  11 +-
 .../amd/display/dc/sspl/spl_custom_float.h    |   4 +-
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.c  |  78 +++---
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.h  |  56 ++--
 .../drm/amd/display/dc/sspl/spl_os_types.h    |   9 +
 47 files changed, 777 insertions(+), 611 deletions(-)

-- 
2.34.1

