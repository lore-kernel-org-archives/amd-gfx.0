Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB35C2BA19
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A143120644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OchvE+16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A143120644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132066E20F;
	Sun,  5 Apr 2020 20:41:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B8189EB1
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHLNJj5cIlkttuheQL1RbXcfj5BQyT3+sb/YS/612Kee5HvPU72ZCz8dWQ4Ufpjr1GphOLPrtkeEAqeoTMwj/p5cnxgDxQ0x6krW3livSvpHn/e6G6PppVrwYZpFv+3Pvd68KJ7Cpa7+yHYqbZrqva0TT7jF45QmaL4P50nqwDgxn+FYy2hd8jw1l//KDHOxsbDR5XOm67uNoQqfMEkqDGDlmg2RNOElSKzyIHuCAMGgwaDi3Ieg2H4R0QxaHJNHxnXUSgmVkes791JK5YBJW4DZMp4+huYP4EhkQyZva0m1LykP1DmVEldV7T9xdxLAdkbm6V0pZ626J12zNvugPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZh8+kksyPJJs51H6CSCPBsYYvTx5tTkYexqMidl4dQ=;
 b=Ylw6/f63Yl1U8/B7ThmHfaDtPQY6hAiMJ1PX7DaKNrpZdZJbdmxPDhJhxT3ymInFgMjSW9Rgt4WxaF8Y5yuhAWBaa7hgs0MszYPhVs4OLZHl/GcUo16fOtIIOnip4mdl8fNcM95GG7SOVD0cf1YlJuQCGT3ofyw/eQqmCPftkVz92GcsY8QxvSI/XMmpI4FCQpI7K/ce7qfDIyPNewfaB56gUF/sM7PYN70NtuL4SDIlgmD/EDK6DFQvpd7VjCIu2KA1+xEj7OntM9/oC96pXz95fBRvoEizEz8LunkEvH4Flvr/IJSiaqh4pRiUqHRVS4FUtRbITnDQ9EykLYN3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZh8+kksyPJJs51H6CSCPBsYYvTx5tTkYexqMidl4dQ=;
 b=OchvE+16uSituIKYoPW1qtonA6Q7rRKAgtbON0Ep6r0MkLIQAJzmKYrcxmINhzL5W63AbkwAotk54FnJgew/B//rQfI4EHN4MyLNe/RVK8dvR8cNKf+zBiTxvdyCuYlZRyFG5yUi9SCtIN5n3xDwnLrU9rXkFvwIA2UtsbeWBOw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:39 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:38 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/36] DC Patches April 5, 2020
Date: Sun,  5 Apr 2020 16:40:39 -0400
Message-Id: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:37 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2c8d3d1-0eb8-4cc5-0c22-08d7d9a1bd13
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555E4B6A2C199F22F98660698C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHkX63FLDSZzMihDA9nhTMLajtefS0KtqaWG3exRsoAdrW1wIYUt1UF7GGInONQg484SAOvpFLJGEpQ5R+7l+Q1cWJE1lxtpMvQWVHLfIV+t/uhZKuJA3EFy0HnFKOmtU6RIhU3j/3/Q7OvlSrVpH5y8918frEpxpZl78hs3ZT3RI34MQ2kUEnW/YhapZQxE06yMR2JOp1wELhoN0ucoTdFtkG0/MLJOgk7EaQljHJpSGwpgjjViPI4vW5HD921dpgtoZQFw2x4WRHoEGxpZ4I+8idBrBcF/IyDF+GUiwOzbrfbAp3rS3LpDFURqwNZSXYZBCWKXEvX04TeyAK0/SKinMd+2moPOJQSBPt8WTmJLx4UTa9e+hZjbVi6cSYQOcPdHrfATc8SmE6RSOdLo9OAHoWH6S6j88qqh631HmSXA2xW2qeueCIWaFUG9tS6Z
X-MS-Exchange-AntiSpam-MessageData: QQXQjdQ/pcdQG5Brg1hIh9eNqXHgOORYwwjrRnSzJz0xfRHXwvpQOeQ1o/+KjxfKdLNvtC6nyGQQKmZUDD7JGXNgyIPnGNYDLMfGagYk9pM9EpUiyq3t76MLOizqchUtKr5RErMQ98eEidU4I1tYKifp4T7Xbai94WJPJl2eBL8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c8d3d1-0eb8-4cc5-0c22-08d7d9a1bd13
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:38.6715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ixYOdaDdh6Z9ct11lmAMPggWqWD7yZWMtQDb43efQy6PkDHgLaZKnuxQsh9tSvEmPxMb2v/ipIwDnTLEftpkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:
 
* Properly map audio to engine on NV14
* Improvements on DMCUB and DML
* Fixes on MST and DP

Alvin Lee (1):
  drm/amd/display: Revert to old formula in set_vtg_params

Aric Cyr (3):
  drm/amd/display: 3.2.78
  drm/amd/display: 3.2.79
  drm/amd/display: 3.2.80

Charlene Liu (2):
  drm/amd/display: initialize get_max_link_cap
  drm/amd/display: Properly map audio to engine on NV14

Dale Zhao (1):
  drm/amd/display: Don't verify DP caps again

Dmytro Laktyushkin (1):
  drm/amd/display: fix dml pipe merge logic

Eric Yang (1):
  drm/amd/display: change default pipe_split policy for DCN1

Isabel Zhang (2):
  drm/amd/display: Remove hdcp display state with mst fix
  drm/amd/display: Update stream adjust in dc_stream_adjust_vmin_vmax

Jaehyun Chung (1):
  drm/amd/display: Update DRAM watermark before checking to update TTU

Jerry (Fangzhi) Zuo (1):
  drm/amd/display: Avoid create MST prop after registration

Joseph Gravenor (1):
  drm/amd/display: fix typo

Joshua Aberback (1):
  drm/amd/display: Acknowledge wm_optimized_required

Josip Pavic (1):
  drm/amd/display: prevent loop from occuring in pipe list

Martin Leung (1):
  drm/amd/display: Properly map audio to engine on NV14

Michael Strauss (1):
  drm/amd/display: Check for null fclk voltage when parsing clock table

Nicholas Kazlauskas (7):
  drm/amd/display: Don't change mpcc tree for medium updates on DCN20
    hwseq
  drm/amd/display: Translate cursor position by source rect
  drm/amd/display: Fix incorrect cursor pos on scaled primary plane
  drm/amd/display: Program viewport when source pos changes for DCN20 hw
    seq
  drm/amd/display: Calculate scaling ratios on every medium/full update
  drm/amd/display: Make cursor source translation adjustment optional
  drm/amd/display: Make DMCUB bss/data firmware blob optional

Nikola Cornij (1):
  drm/amd/display: Program DSC before enabling link

Stylon Wang (1):
  drm/amd/display: Refactor color management to take dm plane state

Sung Lee (2):
  drm/amd/display: Power down hw blocks on boot
  drm/amd/display: Check power_down functions exist before calling

Wenjing Liu (1):
  drm/amd/display: determine USB C DP2 mode only when USB DP Alt is
    enabled

Wyatt Wood (4):
  drm/amd/display: Implement abm config table copy to dmcub
  drm/amd/display: Use config flag to disable dmcu obj creation
  drm/amd/display: Fix ABM config copy for dmcub
  drm/amd/display: Remove unused defines

Xiaodong Yan (2):
  drm/amd/display: blank dp stream before power off receiver
  drm/amd/display: only blank dp stream which will be powered off

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 47 +++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  3 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  8 ++
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 20 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 35 +++++---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 15 +---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |  2 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c | 20 ++++-
 .../drm/amd/display/dc/dce/dce_link_encoder.h |  3 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 25 +++++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  3 -
 .../display/dc/dce110/dce110_hw_sequencer.c   | 17 ++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 89 ++++++++++++++++++-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c | 20 ++++-
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |  3 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  6 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  7 ++
 .../amd/display/dc/dcn20/dcn20_link_encoder.c | 40 +++++++++
 .../amd/display/dc/dcn20/dcn20_link_encoder.h |  4 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 12 +--
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../amd/display/dc/dcn21/dcn21_link_encoder.c | 27 +-----
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  8 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |  3 +-
 .../gpu/drm/amd/display/dc/inc/hw/transform.h |  2 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 +
 .../display/dc/virtual/virtual_link_encoder.c |  9 ++
 .../drm/amd/display/dmub/inc/dmub_cmd_dal.h   | 14 ++-
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   | 11 +++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 24 +++--
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 25 ++++--
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   | 28 ++----
 .../display/modules/hdcp/hdcp1_execution.c    |  2 +-
 .../display/modules/hdcp/hdcp2_execution.c    |  2 +-
 .../drm/amd/display/modules/hdcp/hdcp_log.c   |  8 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 44 +++++----
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  5 +-
 .../amd/display/modules/power/power_helpers.c | 30 ++++---
 .../amd/display/modules/power/power_helpers.h |  3 +
 47 files changed, 455 insertions(+), 202 deletions(-)

-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
