Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4137EC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031D1206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mFnzWPaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031D1206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98DD36E2A5;
	Thu, 30 Jul 2020 19:11:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA546E2A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:11:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQYDa5KfB24PEfhw5L160odrw4sbD6s1eFBOl5uklAxC+1oEBudG5c4TcwRB2tYh7oEb/16wX6Cc62qt+//zdwnuv8S+/Dx6Sub5uP/dZi1p8MH/Yw+1cqE9hTDdBE1FfHEpbhb/5icd1D/Om4tXjk/Qu3ZM7Uasl9U3JPkXPRzkZ/QTrXT3NCHpU3GGEVntu/Pz38NyTbp6Uee0CGBph76aHqEatbiid/eSP9b9DHW87qSXM00Znn00RTveMYlxV/CrgC+Al/nIePc3PnaX6kQDwfE6fCVhOGN+k4yNXAqOkzbQvM0PtVp0Ra5YD1lW3zjj+xMS2WlVyuID1g7Xhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X+rwn7Y670OFWuDteftxjszVhyxhHcNhE8lmZKi91c=;
 b=j0PzYhMg4KxES87khmx5SI07SXtZafD3LZkQmNnMOsWzkrZzFb8GNARY3PjFsQ0NN0uM5ngZPaVTtSL8n72waHyafiAFMd/6FSHe/0p22v8OqdDBQTmdjCCJ8uI4PAdj5HJZ2Q3RqsPto58MNMpyzAASFGUh8+HDZdrhWZNeU6ejM82LAKh2J/gbsHkVX6wW9otWsEWd2DDZGCTzC1dJyD01M1r9c0U4jAQE5R9iLBM3gR2XE3GQs47M86seih+7T6BClMwzKoY4i1+kfIC8dh7WRkDmexOEizO3QhQwE9Ne0WFeOq6Yo4xujGGU18IXxDYvs/55hOoL32Swb/Dkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X+rwn7Y670OFWuDteftxjszVhyxhHcNhE8lmZKi91c=;
 b=mFnzWPaXwFM0w/CZfkzvDrWx1na/QQMV50hXw+SgeI4gL8HJDCrgO0NlbPzkynktj9AB1ZkHywGvBaNIEIlce5fne1t8I+Y2jjYRi9gbVi9Rlv/Wg8V5rWvQJgqZDh7EbA5t/gv3paLJXNaF2rc/ZVYqnrK51EP9y7X1hbNAntY=
Received: from BN3PR03CA0102.namprd03.prod.outlook.com (2603:10b6:400:4::20)
 by BL0PR12MB2562.namprd12.prod.outlook.com (2603:10b6:207:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Thu, 30 Jul
 2020 19:11:48 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:400:4:cafe::c5) by BN3PR03CA0102.outlook.office365.com
 (2603:10b6:400:4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19 via Frontend
 Transport; Thu, 30 Jul 2020 19:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.20 via Frontend Transport; Thu, 30 Jul 2020 19:11:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:11:47 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:11:47 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:11:46 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches 2020 July 27
Date: Thu, 30 Jul 2020 15:11:30 -0400
Message-ID: <20200730191146.33112-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60d894a3-d0c5-4dc9-262f-08d834bc685d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2562:
X-Microsoft-Antispam-PRVS: <BL0PR12MB256220D241C86893BE804BDC8B710@BL0PR12MB2562.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6eGy19fBd3RcI2PMcw5um/l0Ek9+mzmmKS49JPH/aSmnLpurATo9J4+622DxHFFsXWwQ8HzgPRRQbRUvM2jPS9G6Y3CQ2b4Xi1YCDjh94Zi/eY/AAfHRWziTjTNGhbE9+owema/blLqZQrVR3I2CM+2lyyYnwdM5CxrR9mjyK5aVocWBy2tPAeFC7eFZEmTgM9F7S10k99X/q/eMLSdVSN1OQEEbUU6oJFIVAoFWxLkdVXfc/CIfc8vyAMvL4e5Q6FE7PQHoTV5HU0nCLm7sZJdrlgbnWPJEpSRp5dTZxXRzGXsXa4ePQXKP5TB3gG9FdtEahNB3bwG60SNm4Qn01xGp6ajYZGIfgCgOETWzz2hi/CaLkCeYU31fx9D+M2EVUTxcYVdizCpuRf7WK7bxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966005)(5660300002)(316002)(1076003)(86362001)(356005)(6916009)(2616005)(426003)(8936002)(336012)(54906003)(83380400001)(4326008)(478600001)(81166007)(82310400002)(8676002)(7696005)(82740400003)(186003)(26005)(44832011)(36756003)(6666004)(70586007)(70206006)(47076004)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:11:48.1926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d894a3-d0c5-4dc9-262f-08d834bc685d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2562
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Display Core version 3.2.97
* New firmware release
* DSC improvements
* Bug fixes across DML, pipe managment
* Regression fixes for DP

--

Alvin Lee (1):
  drm/amd/display: Separate pipe disconnect from rest of progrmaming

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.27

Aric Cyr (2):
  drm/amd/display: AMD OUI (DPCD 0x00300) skipped on some sink
  drm/amd/display: 3.2.97

Dmytro Laktyushkin (1):
  drm/amd/display: populate new dml variable

Eric Bernstein (2):
  drm/amd/display: Update virtual stream encoder
  drm/amd/display: Use parameter for call to set output mux

Eryk Brol (3):
  drm/amd/display: DSC Slice height debugfs write entry
  drm/amd/display: DSC Bit target rate debugfs write entry
  drm/amd/display: Comments on how to use DSC debugfs some entries

George Shen (1):
  drm/amd/display: Change null plane state swizzle mode to 4kb_s

Harry Wentland (1):
  drm/amd/display: Fix logger context

Igor Kravchenko (2):
  drm/amd/display: Read VBIOS Golden Settings Tbl
  drm/amd/display: Display goes blank after inst

JinZe.Xu (1):
  drm/amd/display: Use helper function to check for HDMI signal

Victor Lu (1):
  drm/amd/display: Add debugfs for forcing stream timing sync

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  36 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 259 ++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  16 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |   2 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |  81 ++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  23 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  12 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  16 --
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   4 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  14 +
 .../drm/amd/display/dc/dce/dce_link_encoder.h |   4 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |  10 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 114 ++++++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   7 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   2 +
 .../amd/display/dc/dcn20/dcn20_link_encoder.c |  14 +-
 .../amd/display/dc/dcn20/dcn20_link_encoder.h |   5 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   2 +
 .../display/dc/dcn30/dcn30_dio_link_encoder.c |  53 +++-
 .../display/dc/dcn30/dcn30_dio_link_encoder.h |   2 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   2 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   3 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   3 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   4 +
 .../dc/virtual/virtual_stream_encoder.c       |  13 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  15 +-
 drivers/gpu/drm/amd/include/atomfirmware.h    |  54 +++-
 31 files changed, 740 insertions(+), 43 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
