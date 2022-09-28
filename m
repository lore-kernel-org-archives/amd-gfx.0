Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F76C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2575910E9A8;
	Wed, 28 Sep 2022 19:40:52 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3146B10E4D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acYk+QZ57YGpCpOFwhknJJMvtO0GHUZEdab5Ba3H4inhiVhsnygIiz3OAk9yrmGeNY320C9A8e/9WBgzzUMkyVdwVBLXU9ypJTyUBZeIKrq0/QHp2tjKINC9v5q/ksHnhvcfuZN/41l/Rx64GCOEVoAdicilrsUCzEh/rn7cq1rVHKb5SvhR8oi2YfS5f5n3Qv5kRNYnsnWILkuRogLZ0+OEr0PakBACh2IXxs7GyTDdv1GOKSKhUo+Ihf7IPBDyX8KkWH92PBdZjVwF34EnmP7QNtCQuOhzsGszSrZkkIrJfGxA1SbDe5UKXOzuOSnqb1Cfklkl/90OLox2lAeIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0upRWj+x06B1K0mJZj2FuLvI891qHW7oMhuGLA4JDk=;
 b=ja5qCc6hrUbTRajPOAeye9N9/kA3RG9NH48L50Kkc/ovxub+rhl8PT83FXTWL26Wa/RQYoWq/y58CO2hTw42Iv8weeTS4hsuLFs4kwcaVkPOWeNdPkMSVC3D5by7kNfSbO4w+5SJV/WosuPKJL58zijos7Ia0+wGoeTBLJ8ZseW9dBAh+jTjvVe6Vod3wPSa8IOJSZGiezSZ0qbFqL6sakRGmYI612WWLBgdWUuCOwbl0mnnfjF+gP5c6O9gwIyUl0ZLNqKxgIZ3qtMv0oFVARWPrMxYuK27z7KHsA5OVw3i8xFVVmiUrzI4i6kjkZrhdDEBvYhht9SqXH7v1dkBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0upRWj+x06B1K0mJZj2FuLvI891qHW7oMhuGLA4JDk=;
 b=JNAb4jeuPn/bzfmOkYjl+/eU4kGxymSoKYeQXpV8VlsThBax1xKYiM5xsNbA6gWrJ/36b6BGfJkYsxV/1V3s0fkaSszMp2J8guYHI0Ytdz+KfUmG8dH69W0Ur7jVK7QwwNhkI20XnD0NlOrenzSPtPm7KKlQFQEhy2C6yt0ctFg=
Received: from BN9PR03CA0744.namprd03.prod.outlook.com (2603:10b6:408:110::29)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 19:40:42 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::b3) by BN9PR03CA0744.outlook.office365.com
 (2603:10b6:408:110::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:40:41 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:40:40 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/36] DC Patches September 26, 2022
Date: Wed, 28 Sep 2022 15:39:52 -0400
Message-ID: <20220928194028.144879-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7e7315-69bb-40a1-3987-08daa1895410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySO5aGsdz3k8he5isoSfe2NITXXaWBv1c8QlatH9444cg3tm2eMnyhXy/QDnnpaIk/Hp3PTgotFukaN0AKXmSX+gl8deS3MVXCnqD9axlkWCCk9Lulh+mukmTlPW/kHkkrH4Q7SrImGGrYdVhzD1uzoJpBnLtlGudb4NLWpFUbvNL7GpyHqniwW2oLd5DIDi4K/Qqf/DKw1QejGPL5heCkNU1fcqZI1s57SLQ97GLANHBrTZ8oghGHbG9hdaAEgLnLGUXSms/o3wXIIKQNZGrfQ6GYTprfWi5tw15b2OylxSyC4jHhUTZhnSFMOWxi0l2a+F5P8uIHz9KB3LTVZc1dZ1vRLiHJBQqlRVuyWNveWvj8BGK5K6IMJ+QJ+ax3VsdiXCLVb43a7lr5NleSpA/9usdI6yas6ST5FugFKdbBA2FfWOPQYsWa98MCb+BE2YoZot5BVFqvobkrzImqFkkalxZKaZ0CHNOzT7pvm8KpjtRjj/B33QsHzOYSFgBdU7oQlq1ImRquPyC9wGFepeqdvIcVeM9UolrGbme7VTA60ZHQoUSZpJ5nSH6+7YOiPXl0Mv9Fy54anxFiyeOMpaxjQ+Qww0xgkjMIgHjAm31175QAy13ZHaQH73SjA8/s1EuTtKepvODtPlFCDNkQKGnwUdFoGibkG/FB7Zp7hIaSJf4DR/gXT/lan28a4HbLeXZdIOK9sdp6C8yMA7HKdkHLyQTyGFsMHZqoSbKavFCFdxBBgdBIcgunA4hQdXgYOptUmirFTAae9d7vltkt3QCM26x/HCE96MgvbfFnIZywPYx/xW8gzDf2jzU+Wcy6THQ6Z1ynAWQHc24kb2V04xwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(36756003)(16526019)(336012)(1076003)(426003)(47076005)(81166007)(82310400005)(40460700003)(82740400003)(40480700001)(36860700001)(86362001)(186003)(66899015)(316002)(70206006)(356005)(70586007)(41300700001)(478600001)(6916009)(54906003)(26005)(8936002)(6666004)(44832011)(5660300002)(2906002)(4326008)(8676002)(2616005)(7696005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:40:41.8662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7e7315-69bb-40a1-3987-08daa1895410
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patch-set brings improvements in multiple areas. In summary, we
highlight:

* ILR improvements;
* PSR fixes;
* DCN315 fixes;
* DCN32 fixes;
* ODM fixes;
* DSC fixes;
* SubVP fixes.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (3):
  drm/amd/display: Block SubVP if rotation being used
  drm/amd/display: Disable GSL when enabling phantom pipe
  drm/amd/display: For SubVP pipe split case use min transition into MPO

Aric Cyr (3):
  Revert "drm/amd/display: correct hostvm flag"
  drm/amd/display: Fix vupdate and vline position calculation
  drm/amd/display: 3.2.206

Charlene Liu (1):
  drm/amd/display: prevent S4 test from failing

Dillon Varone (4):
  drm/amd/display: Program SubVP in dc_commit_state_no_check
  drm/amd/display: Reorder FCLK P-state switch sequence for DCN32
  drm/amd/display: Increase compbuf size prior to updating clocks
  drm/amd/display: Fix merging dynamic ODM+MPO configs on DCN32

Dmytro Laktyushkin (2):
  drm/amd/display: add dummy pstate workaround to dcn315
  drm/amd/display: fix dcn315 dml detile overestimation

Eric Bernstein (1):
  drm/amd/display: Fix disable DSC logic in ghe DIO code

George Shen (1):
  drm/amd/display: Add missing SDP registers to DCN32 reglist

Ian Chen (1):
  drm/amd/display: Refactor edp ILR caps codes

Iswara Nagulendran (1):
  drm/amd/display: Allow PSR exit when panel is disconnected

Leo (Hanghong) Ma (1):
  drm/amd/display: AUX tracing cleanup

Leo Chen (1):
  drm/amd/display: Add log for LTTPR

Leung, Martin (1):
  drm/amd/display: unblock mcm_luts

Lewis Huang (1):
  drm/amd/display: Keep OTG on when Z10 is disable

Martin Leung (1):
  drm/amd/display: block odd h_total timings from halving pixel rate

Rodrigo Siqueira (10):
  drm/amd/display: Drop unused code for DCN32/321
  drm/amd/display: Update DCN321 hook that deals with pipe aquire
  drm/amd/display: Fix SubVP control flow in the MPO context
  drm/amd/display: Remove OPTC lock check
  drm/amd/display: Adding missing HDMI ACP SEND register
  drm/amd/display: Add PState change high hook for DCN32
  drm/amd/display: Enable 2 to 1 ODM policy if supported
  drm/amd/display: Disconnect DSC for unused pipes during ODM transition
  drm/amd/display: update DSC for DCN32
  drm/amd/display: Minor code style change

Wenjing Liu (3):
  drm/amd/display: fix integer overflow during MSA V_Freq calculation
  drm/amd/display: write all 4 bytes of FFE_PRESET dpcd value
  drm/amd/display: Add missing mask sh for SYM32_TP_SQ_PULSE register

Zhikai Zhai (1):
  drm/amd/display: skip commit minimal transition state

 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 44 ++++-----
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 91 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 11 ++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 70 ++++++++------
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  | 13 +--
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 60 +++++-------
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 11 ---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  1 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 25 +----
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |  8 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 13 ++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  1 -
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  4 +
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |  4 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |  1 -
 .../drm/amd/display/dc/dcn31/dcn31_resource.c | 15 ++-
 .../amd/display/dc/dcn314/dcn314_resource.c   | 13 ++-
 .../amd/display/dc/dcn315/dcn315_resource.c   | 15 ++-
 .../amd/display/dc/dcn316/dcn316_resource.c   | 13 ++-
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |  7 --
 .../display/dc/dcn32/dcn32_dio_link_encoder.h |  4 -
 .../dc/dcn32/dcn32_dio_stream_encoder.c       | 57 +++++++-----
 .../dc/dcn32/dcn32_dio_stream_encoder.h       |  3 +
 .../dc/dcn32/dcn32_hpo_dp_link_encoder.h      |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |  1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |  5 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 37 +++++---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 24 +++++
 .../drm/amd/display/dc/dcn32/dcn32_resource.h | 22 +++++
 .../display/dc/dcn32/dcn32_resource_helpers.c | 88 ++++++++++++++++++
 .../dc/dcn321/dcn321_dio_link_encoder.c       |  1 -
 .../amd/display/dc/dcn321/dcn321_resource.c   |  4 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 91 +++++--------------
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |  1 +
 .../dc/dml/dcn31/display_mode_vba_31.c        | 15 +++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  8 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        | 19 ++--
 .../drm/amd/display/dc/dml/display_mode_lib.c |  1 +
 .../drm/amd/display/dc/dml/display_mode_lib.h |  1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |  1 -
 43 files changed, 522 insertions(+), 291 deletions(-)

-- 
2.37.2

