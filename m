Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECA5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8854A10EA5E;
	Fri, 28 Jan 2022 14:04:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7860A10EA5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/edNrKqSf6WeCOu6tnGPdgoR66/WX4Ha933Rb9BzGlhZ3W9K9XW0Q8Q1ikUqwz9zR5NnK/5xWrH1RywqxDCaXvI+CDlRxVS/OFHIOAudkekm7KV3ttxdQwVMAExkGoRbQ0qcpUvkvLbyyGHxtAj7oKysJqxm/RV66t3HtZvZ0o9c6h0GdV6Y1FBbyFMkk5YXdpvRluLn2Su0kPfEXHr11xu8OniY+mB+ZAOAK14le2Ptit8KFHswfjdAh5YyPZWlGj4V6BzolTB92fO1pAD305sinU+6H5pKtduaFli9eZyRBZv0AZbu0XnuqpjypFYVsLZwKgsXFRthKZlQxY/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7+v55npn/isfagvKT0wfg2Pw5mEhzv4kYo786Q3n5A=;
 b=hSIT6wzt9KlFq/o7xC3V19OWdDPCpzrOl2U/nrh/PnT2DcOs55/DcVts9Oer3f9onPwVkbrhn+rnXM7PZp6gfDSOJGHtCfQxbMXMRRqC4UhAcLUlf3I61Xmw/zX0IjU5V2uKeIYlBG5u6OrCf+luKOC2T6MXEMrk/aGZzo0HDnvY3J9QYBFC3ghWKuZngk91niT4Pl6K64HynKKrDQX8MivexfNie02LWbKI5794acfjnt4DZE36E08Qn7I9DOco5i8uMPXkYRNNo/YkzkQyoB27TYYNkMAHNYCYL6SP4OD+cmkIoAIaCrq6taTcaB7Ts+sNAD+yqaDHN9DtqOor/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7+v55npn/isfagvKT0wfg2Pw5mEhzv4kYo786Q3n5A=;
 b=2Tr2v2qPdrBkgGMwrvAZVZAfQAK32glPhl9NHGbA83vIP+apdKZQnNGMz4EVBrAFu5E/9gIs4EH9wSFDGKs7tjRIl9SaR/FPPNWfZUJDEZfpyFE6IrQd75nwg8paCjMr2hSkx46VuCdT/r0LUCr5cjq4v4APtgj9C4mrSz7PgLs=
Received: from DM5PR21CA0019.namprd21.prod.outlook.com (2603:10b6:3:ac::29) by
 BN8PR12MB3282.namprd12.prod.outlook.com (2603:10b6:408:9e::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.18; Fri, 28 Jan 2022 14:04:53 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::99) by DM5PR21CA0019.outlook.office365.com
 (2603:10b6:3:ac::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.6 via Frontend
 Transport; Fri, 28 Jan 2022 14:04:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:04:53 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:04:48 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/17] DC Patches Jan 31, 2022
Date: Fri, 28 Jan 2022 22:03:54 +0800
Message-ID: <20220128140411.3683309-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96e33cd1-6a83-4edc-ce4b-08d9e2672843
X-MS-TrafficTypeDiagnostic: BN8PR12MB3282:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32824DB269B4CBA36554B83BFF229@BN8PR12MB3282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MocHbVsskdSHm6avLfbyWA2f2mipsqgrqwhOkwIEJIwU4BL9lu0xCAIdSTvgbO/D1ZF4eIT4xcfvNt+PVtDnGSC68IDmw76G32gBN8zo5YZ44YuwuD52n11Uod9NBLwUr1+1u/P4Q3nI3Xbr0IivEFY4e0iI3WYoEXclX7EPfbR5Z+ndz4fRYcWlHZKHWWqzdqcLzisG8TJoO4bKdsl1gUlcYymK7gLDzqubNmYOKUGik0bzw+nzntxnla7knglBJnU4neIAEv7MgdIJmYBOiNF5Bmri3+EV4jHhce5WCyi2Rlrm1tR3+qoO8QXfVqzw+Ayyvu92v1bnrk0lwCi7UVsZoQG1sM+d/guTrdUS4c+unEpejUKoZreJPn9jFp8duA5+GKT8kLS0NLFy78D7/LyR12lGbwGhxcfwXrb4NZc3gTAHJTIzol3ELvoh+VO0Q+J6keZD43IQtQP3YX+k4VIVIPeIuXJ5j62GcAvuEXC8vflC+8Mgw/HDnC1bY4Ndg2B4ypJvyIEGOML7bCvmHegVVIfAFYov3ZBnTuxz2JlkQE52tuoa9UmoJxpcAQU+nocNBR53xfL6+PaBMPlpEkWRHe4jUEoDKECU2Z8wXIjxENESIPfsiiHxWjSOUoevKbfL8EtCcdj2vKsnZ9KU4CIZ7hFhMZi6ERJc47zOehTc95AmcU4D5C2IypyKnnxtCWJgCaUB+D0F4Ed5oJkwag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(508600001)(82310400004)(426003)(336012)(47076005)(54906003)(2906002)(16526019)(6916009)(1076003)(186003)(44832011)(40460700003)(6666004)(5660300002)(26005)(70206006)(8676002)(4326008)(8936002)(36860700001)(70586007)(86362001)(7696005)(83380400001)(2616005)(356005)(81166007)(36756003)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:04:53.3583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e33cd1-6a83-4edc-ce4b-08d9e2672843
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3282
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

- DC refactor and bug fixes for DP links
- Bug fixes for DP2
- Fix regressions causing display not light up
- Improved debug trace
- Improved DP AUX transfer
- Updated watermark latencies to fix underflows in some modes

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.102.0

Aric Cyr (1):
  drm/amd/display: 3.2.171

Fangzhi Zuo (2):
  drm/amd/display: Trigger DP2 Sequence With Uncertified Cable
  drm/amd/display: Add Missing HPO Stream Encoder Function Hook

Leo (Hanghong) Ma (1):
  drm/amd/display: add infoframe update sequence debug trace

Paul Hsieh (1):
  drm/amd/display: watermark latencies is not enough on DCN31

Shen, George (1):
  drm/amd/display: Add link enc null ptr check for cable ID (#2597)

Wenjing Liu (8):
  drm/amd/display: add setup/reset stream encoder to link_hwss
  drm/amd/display: refactor destructive verify link cap sequence
  drm/amd/display: add enable/disable dp link output to link_hwss
  drm/amd/display: add set dp link test pattern to link_hwss
  drm/amd/display: add set dp lane settings to link_hwss
  drm/amd/display: temporarly move non link_hwss code to dc_link_dp
  drm/amd/display: move get_link_hwss to dc_resource
  drm/amd/display: move link_hwss to link folder and break down to files

Wyatt Wood (1):
  drm/amd/display: Improve dce_aux_transfer_with_retries logging

Zhan Liu (1):
  drm/amd/display: revert "Reset fifo after enable otg"

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  26 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   4 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  20 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  87 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 778 ++++++++++++--
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 959 ------------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  59 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   2 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |  17 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.h |   3 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  49 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |  17 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |   3 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  15 -
 .../display/dc/dcn10/dcn10_stream_encoder.h   |   3 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  41 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   2 -
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   2 -
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |  11 +
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.h    |   9 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  47 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   3 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   4 -
 .../gpu/drm/amd/display/dc/inc/link_dpcd.h    |   2 +-
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  90 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  10 +-
 drivers/gpu/drm/amd/display/dc/link/Makefile  |  30 +
 .../drm/amd/display/dc/link/link_hwss_dio.c   | 137 +++
 .../drm/amd/display/dc/link/link_hwss_dio.h   |  53 +
 .../drm/amd/display/dc/link/link_hwss_dpia.c  |  51 +
 .../drm/amd/display/dc/link/link_hwss_dpia.h  |  34 +
 .../amd/display/dc/link/link_hwss_hpo_dp.c    | 254 +++++
 .../amd/display/dc/link/link_hwss_hpo_dp.h    |  35 +
 .../amd/display/dc/link/link_hwss_hpo_frl.c   |  43 +
 .../amd/display/dc/link/link_hwss_hpo_frl.h   |  34 +
 .../gpu/drm/amd/display/dc/virtual/Makefile   |   2 +-
 .../display/dc/virtual/virtual_link_encoder.c |   3 +-
 .../display/dc/virtual/virtual_link_hwss.c    |  43 +
 .../display/dc/virtual/virtual_link_hwss.h    |  34 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   8 +-
 44 files changed, 1726 insertions(+), 1308 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_frl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h

-- 
2.34.1

