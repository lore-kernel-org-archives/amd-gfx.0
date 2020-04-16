Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAE0C352BE
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3432C21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZjYh0NU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3432C21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5AEB6E0EC;
	Thu, 16 Apr 2020 23:41:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C19486E0D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3JEdgLF+3TSj6vRP3mF3uSmfgHk52uPwFpfN8P+mgmkEQ/LCgD+mOd74JjYSXR8ojHxIXRx9Iul1JV4uG2NRyPPx0TwB1Vo2BwB7bz8SeqtBqag+JIzuUSMMHWlbrwXOiUHP/CsP7ILN0nhp6mx1DyAZdcxX/t0ACBWzRWGSzzJEbIJ+QI/jMfFLHgOq4yrDWTsCPRmPHl4lNLFQEknPsNKxkQNIonmMPRedBm81yA3SjCbrKMfZAfgQdJL57kUbZNjVy+cXuLotiMuRQ5464uBpTxG71UizPa9Wd53nnWrrMk5rQU0hXdCdgVVBujvkGvR7E+EjNNNQCIgHlMR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNZ4VYPrPl/UiVji5rgjzdqNKnBRsRdaS+LgaMA/dbs=;
 b=Hg65Y69kv0qxo0owHR2iV3lwIOWkTh6D6PZWOuIrlSQ5ux/R9wTess969P1JNQiOXJAzpmrYjeyNHS3LcFNy3ES9TIEpo84BVF+bLVF3ImplOH/azytT751WP1y546JPzkMSonmqD2cjKS7g26i6YU4UzBEbxn1qmlRTnHXNlxoKY27hcdErM3gtUdkjmXTw1OLqu6IaqZA+Q3HaAqITYFUdleL+xn3BDxo4aWdMsHHx3GK3+tnk4lbVXJhmUa4Ak34d7hESSzYJrN8c39FeGS0HzibQYw/etA1WHbRMghYFnXRRtO94k8lEWR2Pq0fHBIP0r1xy6VtVFtk6KcQcbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNZ4VYPrPl/UiVji5rgjzdqNKnBRsRdaS+LgaMA/dbs=;
 b=ZjYh0NU6QYBtVoZ6sJm9As7tZ5qz2lx4u6tkDO+CX+qTIxesfEBiUA4JYwXbBxeRPwr11rdkZvtnI6FrNhA0ZxbMc/lfcFqzUyaE72nC1ZOrnbMyS7SHzdRErD+5u63n2emmpydf+kQktvNtzraDjk9CGl1FKzjL0Eoehzip0K0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:08 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:08 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/35] DC Patches April 16, 2020
Date: Thu, 16 Apr 2020 19:40:09 -0400
Message-Id: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:06 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffe88edb-13d8-4e2f-90f6-08d7e25fa2b4
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24599E353E1A50AD81DE0E7398D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(36756003)(6916009)(6486002)(1076003)(478600001)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002)(357404004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2c2FsOBBz2EA4QL7OpRHGJtBuesCbEXvCf1ZIBdMKnySCmVFSOVEPhLEBBITC22crJiI3TdyxffoMeWdF+vOjF+U149bdOdfvXz07faauZOwSiTeodGdzag6znRROOdVudg/lOTF05H2Rd2orbuo53p3oxmx8zYgiPkis1F/gsMJKZFuD5q4khQNPMpeELhjtr0+3n97t7dv3Z3DAXZw4NfPaB4Ik/wVPLblk7cDsoQhtXdObmmvCj3ID8FduKhjYhwHm9AYEGvVGaDmmEWW63eXjPzDYT6W60f1ufL0NC2VRtJxWvbywIH70H+BrXsSYG6RKY37juFtiaIlxCB6xIkYgug3VsF0j8DS8TGN5Mo93DdSiRZ97cHkSajF1hkdvouA7Gi4rM72NMaaNexBOgI0EH2jMQtphJ3fKuJLXao0VGNUh7xBwEhipa7vA/WY7oOV3qprQvGQud6TH7CGwd0zQikE1On3uJrYcX1sQJVCTjgzavgHnWdtWkJrJt/Q
X-MS-Exchange-AntiSpam-MessageData: phT/dwcLCdYKoAlSvfeOFPtUGby06rBB3ZGNc6DDGGeptIAicWRhS/hPAYDtkAAMcwc9B2VhrrIqz4w8YLkL8w23IPUCQOljkEuoziazl/R/oVBq1gYEYYcI615f5rZcpaNyLCf9fXc3Ihrb1x6yR8cJ6hm9uBzyZQ4D9UE/Www=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe88edb-13d8-4e2f-90f6-08d7e25fa2b4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:07.8985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zbaKE+aRTr0W+GwI0EVUFf9VgyJislGFHwYnzl+DJVMPCyQLurYkznlilWh+RKZJ1C0rQ7jNmRTgAGazNFwvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Improvements on:
  - DM color management
  - Backlight panel
* Fixes on:
  - Suspend issues
  - Virtual signal dsc setup
  - HDR visual confirm


Anthony Koo (4):
  drm/amd/display: make all backlight calls link based
  drm/amd/display: move panel power seq to new panel struct
  drm/amd/display: destroy panel on link destruct
  drm/amd/display: change from panel to panel cntl

Aric Cyr (3):
  drm/amd/display: Fix HDR visual confirm
  drm/amd/display: Update MPCC if requested
  drm/amd/display: 3.2.81

Aurabindo Pillai (1):
  drm/amd/display: DispalyPort: Write OUI only if panel supports it

Dale Zhao (1):
  drm/amd/display: Correct updating logic of dcn21's pipe VM flags

Dmytro Laktyushkin (2):
  drm/amd/display: fix stream setting for diags on silicon
  drm/amd/display: fix virtual signal dsc setup

Haiyi Zhou (1):
  drm/amd/display: Change infopacket type programming

Jaehyun Chung (1):
  drm/amd/display: Add HW rotation cursor changes to dcn10

Jinze Xu (1):
  drm/amd/display: Workaround to disable YCbCr

Joshua Aberback (1):
  drm/amd/display: Force watermark value propagation

Nicholas Kazlauskas (4):
  drm/amd/display: Check ramp != NULL before applying lut1d for degamma
  drm/amd/display: Avoid NULL pointer in set_backlight when ABM is NULL
  drm/amd/display: Use the correct input TF for video formats
  drm/amd/display: Factor in immediate flip support into DLG
    calculations

Paul Hsieh (1):
  drm/amd/display: dmcu wait loop calculation is incorrect in RV

Rodrigo Siqueira (1):
  drm/amd/display: Fix green screen issue after suspend

Stylon Wang (2):
  drm/amd/display: Support plane-level gamut remap in DM
  drm/amd/display: Adjust refactored dm for color management only

Sung Lee (3):
  drm/amd/display: Set meta_chunk_value to 0 in DML if DCC disabled in
    DCN2.1
  drm/amd/display: Cast int to float before division
  drm/amd/display: Cap certain DML values for Low Pix Clk on DCN2.1

Wenjing Liu (1):
  drm/amd/display: add optc get crc support for timings with ODM/DSC

Wyatt Wood (6):
  drm/amd/display: Add user backlight level reg write
  drm/amd/display: Move enable fractional pwm call
  drm/amd/display: Remove byte swapping for dmcub abm config table
  drm/amd/display: Add SetBacklight call to abm on dmcub
  drm/amd/display: Unify psr feature flags
  drm/amd/display: Various fixes for PSR on DMCUB

Xiaodong Yan (1):
  drm/amd/display: blank dp stream before re-train the link

Yongqiang Sun (1):
  drm/amd/display: access ABM from stream resource.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  99 +++++++++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  25 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  10 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   2 +-
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  |   3 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  28 +----
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 104 ++++++++++++----
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  29 ++++-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c |   1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   6 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  24 +++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 -
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |   4 +-
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |  65 +++-------
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   | 105 ++++++++++++++++
 .../drm/amd/display/dc/dce/dce_panel_cntl.h   | 117 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  38 +++---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  58 +++++++--
 .../amd/display/dc/dce100/dce100_resource.c   |  31 +++++
 .../display/dc/dce110/dce110_hw_sequencer.c   |  43 ++-----
 .../display/dc/dce110/dce110_hw_sequencer.h   |   4 -
 .../amd/display/dc/dce110/dce110_resource.c   |  31 +++++
 .../amd/display/dc/dce112/dce112_resource.c   |  31 +++++
 .../amd/display/dc/dce120/dce120_resource.c   |  31 +++++
 .../drm/amd/display/dc/dce80/dce80_resource.c |  31 +++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |  18 ++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  20 +--
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   2 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   7 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  31 +++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   8 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   2 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  14 ++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.h |   7 ++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  33 ++++-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   2 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  38 +++++-
 .../dc/dml/dcn21/display_mode_vba_21.c        |   4 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  17 ++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   2 +
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |  53 ++++++++
 .../amd/display/dc/inc/hw/timing_generator.h  |   3 +
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   6 +
 .../drm/amd/display/dmub/inc/dmub_cmd_dal.h   |   1 +
 .../amd/display/modules/color/color_gamma.c   |   2 +-
 .../amd/display/modules/freesync/freesync.c   | 101 +++++++++++++--
 .../amd/display/modules/inc/mod_freesync.h    |   3 +
 .../drm/amd/display/modules/inc/mod_shared.h  |   5 +-
 .../display/modules/info_packet/info_packet.c |   3 +-
 .../amd/display/modules/power/power_helpers.c |  74 ++++++-----
 57 files changed, 1089 insertions(+), 311 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h

-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
