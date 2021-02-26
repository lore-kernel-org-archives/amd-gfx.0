Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42469C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92E364E38
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92E364E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2986E446;
	Fri, 26 Feb 2021 22:37:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EBB56E446
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 22:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2WauGSYvZQVOoXPEgTjlF5p8yaOT4WZqvkpSq01mxsIm971RAWcbsd2HkjI/1PNeiTRj5GOBkESEccTE/5TLbnbvHkPSqjZx2NQxUNiOXeUS2ci/IEiSaVVe5/B0JbfkfquDsdbJaCfpKY4uXl/hEiqNSio3k01IIIhsG6mbX7pruQzv2bt/G/vyzIS9CQ0GqE/Ge5ENj80LlV+9ckPuTr3k3GsojdA0JPmblFohGztaJ9Y50nEmXnsp4u+o9xNbh8NPVts5nyANn7BFl12DUjGK1feWUYCf7jolz8b8nFSa0tq+JdMOX/SWuXv1NM8RagbYUhfN4tYYNsnpFnHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syEgduH+6O9aDxi2cjlvb0apF4r6AUrRwQsMWo0LJ+s=;
 b=j//UtAgqj/VJR3kBqzg6Z8ljseCmn9NfFmFHhi3cMO6MP1Pq2A9sHq3r3NZPU3gnfZRjWjmho7/AZUPXGinZpx2Ab69KA/fHP1NCMDYokym6W0HLu1cnK54fS/JKJJiW86LDdjCuRKAQJXFYYr/iU/3Aa2qeb91Ke73rRYDKHBVbYIRXBsFifGhPJcVE4HSwcw68zQWwhws8kc/fyKWDtn+eAC/5D8mJpharen6bwqCoX13sFGyNjO3IVy7AO/YsHucaYVfG85cUvAKrYpbugzIdfCsmBxdoZ4qVWd1DtEBnf1T33d7vit7Y3xWkNNVSAL9dDJA42VzEAW3vRn7MbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syEgduH+6O9aDxi2cjlvb0apF4r6AUrRwQsMWo0LJ+s=;
 b=1cRY12BK48XNSJIX3PZ4rb5GUBZZSxnJymiZZNVOP7Thv17N7DMMr1n6uvbOgy1qx8bPyNxM22lUKJGKdt7HpjifWWcBHkLFdDjP8NAFtJrnoAW9EkNshSVJhd3abyZL41wAlIRt+FpUzKq9UImNMgajczo79Qxxns3aHeAYl8c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 22:37:35 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 22:37:35 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/11] DC Patches Feb 26th, 2021
Date: Fri, 26 Feb 2021 17:36:53 -0500
Message-Id: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf]
X-ClientProxiedBy: BN9PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:408:fc::12) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf)
 by BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Fri, 26 Feb 2021 22:37:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95782461-5b71-482e-1c03-08d8daa71c96
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18833F6E4A054F07C21D26AA989D9@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6lcw4VAPwWdStRSw0kwmg7JkzHI8GpopN1RRRblDpFmbqvpv1iSVqj8aACaqF4zDnpe8aMOpOz3MblAxNP/ZOS7qpxMjX8la+OeNIJjIqB7MRBMjV36A1ffsyUX+tz/KmluwQA7tM1DtvZZut/eQp46UetLjJitSupJH6FAiHApALJ09yYrxT5P3XvGMNhWCl+9UsOp+8TdL5oSOIjcjTip6AAKd5qNEPuevl0zAF3WBE/wcl2TcWh6pDjwdyz7PWkdM4IkJYwXsLyHf4pgVGIwyS32YZgekUsoxg+/Mih+GmKUiSNoT+1IVUm6NxNsNiufh5fmq+Akxo5E/WwSG16rJ8oe/wyMBKKmpmHCUWmnPRFKQkJoIfimLZ82xFh3AU84pwePMEUIPe7/dzKVv7ugsfa+CNGlMo3Q1xWIN51fwclq5s9y/dvgridJRuOo6tnGyHd/8/Bop3xE00doLl/I9nRtWAESDbk2W6/7DZnrm74FtFynYUSy23ymSr+DTT8ruc9wSQTo//sArGrgRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(2906002)(6916009)(2616005)(5660300002)(66946007)(316002)(16526019)(186003)(1076003)(83380400001)(36756003)(6486002)(478600001)(66556008)(52116002)(4326008)(6506007)(66476007)(6512007)(8936002)(8676002)(6666004)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iZS5dFKtN6tWh8Aca6yT24arfN1jqq2oX25RtfvXqiY6Q64+5ShNuqwteGEb?=
 =?us-ascii?Q?0aZx1DLI5WLTpRliOf+aZ2t7scg/umIpGbdsiDAai3dEhh6AysJV7VghfuiG?=
 =?us-ascii?Q?yyvNx7eTv3VKTlvxfox5WeSi5g8Akw7DKTYpQ7VKFGI90PTmiIhonTmOaYIZ?=
 =?us-ascii?Q?H5015DOvpkDx0e+5tfBleaIfOeYVjjhDVyghJHnNvLY5QGxq0XAX8AejkOPb?=
 =?us-ascii?Q?iWKlWBqbI17dCwX91XEIAsAHiclFg6TggvmvTmaRoH4MH9fag5eu9WBkd5Av?=
 =?us-ascii?Q?J6fG1ZcNHjw3Sbxir5YaUnscXqvQ2bf2p7ORQiJvA5mTSUf3Vjx4MuHQ4sLc?=
 =?us-ascii?Q?jBzrvrXufsM2OksGfLFi0JL/2nTiJaXFw7sgPFUvv05PtcyHVr3gpH0n3eJz?=
 =?us-ascii?Q?jhEciC8FC8IRi7V0w8yDS1D6AtHgbXch7xLTZXLF4lHWJAqzk1ESMtQMMjt6?=
 =?us-ascii?Q?gJMd9v5IAacFwh03YFw6uW9+gv/KjXLNXsfc6FJncW9B/SXWsaKMCElkBx3t?=
 =?us-ascii?Q?JN3mJrF1C7AFdFTlmjpGLB+Ytv6rUrZos04i1aJ9T4+s5NmwFldjcEXNAMU2?=
 =?us-ascii?Q?8mwdCTj06J3PZlq3at7IVBvFd1jQscfEkQVqpTVj3zN2dYNdX+hUrsuYUpoa?=
 =?us-ascii?Q?waffirjj1SV0QBIqmwOMihh8OBnpRq+nPm/02XaQiaMGXGUMFCwCnb7ZZVgT?=
 =?us-ascii?Q?7czUp7gkpgq5y80ykR6bsM+lYQxzfSxvHtErlZLcuyyVojdHXwfhaVMiWzLI?=
 =?us-ascii?Q?2wkwuCF4BrojpSnHUHZTlTLJFLANbYR/UwbcCHaB9kA4Sfx7ZVULW7QAzIYl?=
 =?us-ascii?Q?xnXbRsXIicznXzsyD6r8ta4E5J0K9rUzqKmVkX1GSmZRMg38qubfkGAxOJCV?=
 =?us-ascii?Q?CJHnE7wIqdQzViOxcncYWDFOoUXT7lDPX6vFyPp0FA7+hT+hXVCDxNce0Xcz?=
 =?us-ascii?Q?j2//qrB873/hhVAGn/Wv61MMj3xQ55ga/KPiO1vOHezCec051wfeMuDWRAvH?=
 =?us-ascii?Q?O92DxsYbWVenG7hj44M7k8FHeCHFfXJ863O7h1gkhg4cVLyyuBwXk7pWhl80?=
 =?us-ascii?Q?Hl6P737eEAEHy3YXkvDBoNUSIJPvTgfC25DNXi66R8p8K/rDnn+a/eKzjJhG?=
 =?us-ascii?Q?cMfBdr2z9a3flGGBgZ6ZKMsTwUfGLJ/NM6c1VhC+2xX9NNGrPpdY9ARK3St7?=
 =?us-ascii?Q?HfVDl3awCgXPammetjdItJ6tuBH4wbvl+/HueAtOZ19Q9g71uxbacEjfmWin?=
 =?us-ascii?Q?60hOyfO3/Pl7B6TUZlJpcQcaOLDnq1//to+GHR3ll1F+xnbUTIQKxOQGh31n?=
 =?us-ascii?Q?8xsVJU9Omr/RTCF0AQaEkzpEJFQDd11KlDKTXWVylHgoHSBSB/+dvPQrZT6E?=
 =?us-ascii?Q?lgvK/w6Gu5IGwZtIu5FUWwHNewen?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95782461-5b71-482e-1c03-08d8daa71c96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:37:34.9666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FjtzL90S1C9twSCBVLWKWn7Wp86XtzG3OrLQhq6Iz/3+Th7weoc7zc46MoGOi8QRasrNAsFdNz+pCcGfnhAGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DC version 3.2.125 brings improvements in multiple areas. In summary, we
highlight:

- DSC fixes
- Firmware relase 0.0.54
- eDP interface refactor for multiple eDP 

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Best Regards
Siqueira

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.54

Aric Cyr (1):
  drm/amd/display: 3.2.125

Dillon Varone (1):
  drm/amd/display: Fix HSplit causing increase in DSC Slice Count

Eryk Brol (1):
  drm/amd/display: Add max bpc debugfs

Hugo Hu (1):
  drm/amd/display: treat memory as a single-channel for asymmetric
    memory

Jake Wang (1):
  drm/amd/display: Refactored DC interfaces to support multiple eDP

Jimmy Kizito (1):
  drm/amd/display: Update link encoder object creation

Max.Tseng (1):
  drm/amd/display: Add flag for building infopacket

Meenakshikumar Somasundaram (1):
  drm/amd/display: Support for DMUB AUX

Wyatt Wood (1):
  drm/amd/display: Return invalid state if GPINT times out

Yongqiang Sun (1):
  drm/amd/display: Implement dmub trace event

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 153 +++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  17 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  17 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  48 +++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 112 ++++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  14 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |  64 ++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  17 +-
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h |  10 --
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  16 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   6 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  19 ++-
 drivers/gpu/drm/amd/display/dc/dc_stat.h      |  42 +++++
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  40 ++---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |   3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.c  |  60 +++++++
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.h  |  33 ++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  16 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  72 ++++++---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  34 ++--
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  31 ++--
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |   2 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |   3 -
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  13 ++
 .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |   3 +-
 .../drm/amd/display/dc/inc/hw/aux_engine.h    |   4 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   3 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  55 +++++++
 .../gpu/drm/amd/display/dmub/dmub_srv_stat.h  |  41 +++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   7 +-
 .../amd/display/dmub/inc/dmub_trace_buffer.h  |   3 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  50 ++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  28 +++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  77 ++++++++-
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  | 105 ++++++++++++
 .../amd/display/modules/freesync/freesync.c   |  28 +++-
 .../amd/display/modules/inc/mod_freesync.h    |   3 +-
 46 files changed, 1135 insertions(+), 137 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_stat.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_stat.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/dmub_srv_stat.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
