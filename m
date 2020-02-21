Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADA8C35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32032067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VoWAH2m3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32032067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D0EA6F495;
	Fri, 21 Feb 2020 16:03:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F3C66F495
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+IqchcUIJu7FWqDmUeqWAp2ZRCbSXVbunniCzZe5AtdFVqHlNxC7GCA8rpfLCK9QUIFIGsiq3iTC3qMWD55uVdaoZNzpi35sEIYAMxAHLYfohpNepCKj2dF07v+zQJwNwKy4h0HZ97C2zwFVhlt1d54yT1uJAQlWTDCEBgisdNXUIjKw1zagqlD1cjPE2sB8BfzgsaZZ17ZfWRRJ6TeDNbYdHEVIU/sHJ20KkH6+Gc/ae4WTTEeLDXDmbObjf2wxmZrX/pmyAppI0cnD5cAxEbPb5/xoMg2k6J+e8x8VgcaEQ7o7ldei4rHtjRFfXKuDozli33961/W1HlUP1N7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDNV4shDtDqomwN8nsV7aFOeWxTGPmOh7NcPOjra5Zw=;
 b=FptjrdKvTv8Cm562JIirntqYtAt2dI7CWJZkaaZlWEzPP47bDEuRQx9vrbgf4NJVhk5mkkL467ds8Z0OkDL3VNlg1HvoafqXKAudwm+DORHgGwZuY3aNY8vvcrDquYDYYmNjqEBsE91lrCo8V2EU8uykRwb8DtQk8g5kACfSdZLHWWruKiabQe8Zz589ebTBiN40ur+bV9dzpmuv1SmU0Jvq3BPGEte5kR1Tpl3jwAQSz1XStyFmscle4QCQUMkKb6bRT2J9Km9jwVxN7Ok/w5x/pm6Y3ZJD4qBNdwXxHsis29VRt7YFbkTzgfWb6GeS2WqFmr6DLXtMk7dOwknzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDNV4shDtDqomwN8nsV7aFOeWxTGPmOh7NcPOjra5Zw=;
 b=VoWAH2m3neFotgZuAhEybtGuMv1FsVgWVAVJDj8oOJJtqXMv8h+Ajw8xoYl9CiVfdMiZCbwlHJFL/XzH5Lt/CxXmyLA0I+wz5neR21TbZuLelNIoHt4RKCCmRU1yDEAAY1NiJGo4Taddnf6nJBrF/oPTGJ/ShreC8VVJE6Xy+0o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:43 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:42 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/35] DC Patches February 21, 2020
Date: Fri, 21 Feb 2020 11:02:49 -0500
Message-Id: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:41 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b9ac1f2-b0c1-4591-5ca8-08d7b6e79f50
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572CDF740EFD96CE56EC1B098120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(316002)(186003)(26005)(6916009)(16526019)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSGWSkof1IIb71xRpauhYq5kQ95L4fCmJ8ZznctLJbSaCo1mH29X8O3GXPuKbYWGpOTurg2qRoA3fPEjqUoyHH5SivJ/PfXOtQ0AHupvamuGBSD9A880oQWH5aJMetAWv0SSBYP2uSuUqk3KqF9t/zTGh5Lw2HeC85QGodQsaS3SzZEfGr+mgKFjuSZstuE8wlTj19gUg+88E4KgWnDCq9qna99zCIKzGM7gjL9KuNcEd/WwEIO/ogMmudBcQVwxJHZNLdcVWAt4Z2BE3Az0fKnWr1sbX5mULpJS45Cy3tW9efs2OtZY6lMDwnT+xyY0MWSBaxA6ifhVD2zjP/FvXu9IbUBX+jrDpQ5P2KpJlmR9kmkMie9QQipaOx91PR8YJcvdqrfVBjtKxNUWhsGOj0HK6GL69cKeoCOks7gMb/hr40ejDE4q8MHJovoZt7sd
X-MS-Exchange-AntiSpam-MessageData: 7Wl+2HJNZP/7v71R2F/l+Kc9DKDL2osL85bli7PleGtMg+GbgcQBqQArPZip4+PRtoBgML7N4SgjPcMTUN8TPGKsGwLV0eKPaUbCemV2ze3X5xGrWmWNgOutak93HZeUI3dGfOkV82Xed3IYKrcaPQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9ac1f2-b0c1-4591-5ca8-08d7b6e79f50
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:42.5527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qM4UCHGntv0pD49hK9Du4UklYU1uSwAtDTpOBWrVjcGahmDhACrYRJDu5L2wdntWful4qLQx9Rue2NSSkzmkCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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

* Fixes and improvements on:
  - DML
  - ddc
  - i2c
  - tx mask
  - link training
* DMCUB improvements
* Clks optimizations

Alvin Lee (3):
  drm/amd/display: Update TX masks correctly
  drm/amd/display: Disable PG on NV12
  drm/amd/display: Update TTU properly

Anthony Koo (2):
  drm/amd/display: Add function pointers for panel related hw functions
  drm/amd/display: make some rn_clk_mgr structs and funcs static

Aric Cyr (4):
  drm/amd/display: dal_ddc_i2c_payloads_create can fail causing panic
  drm/amd/display: Only round InfoFrame refresh rates
  drm/amd/display: 3.2.73
  drm/amd/display: 3.2.74

Bhawanpreet Lakha (1):
  drm/amd/display: Fix HDMI repeater authentication

David Galiffi (1):
  drm/amd/display: Workaround required for link training reliability

Dmytro Laktyushkin (4):
  drm/amd/display: update scaling filters
  drm/amd/display: update dml input population function
  drm/amd/display: remove unused dml variable
  drm/amd/display: correct dml surface size assignment

George Shen (1):
  drm/amd/display: Temporarily disable stutter on MPO transition

Hersen Wu (2):
  drm/amd/display: dmub back door load
  drm/amd/display: DMUB Firmware Load by PSP

Jaehyun Chung (2):
  drm/amd/display: Monitor patch to delay setting ignore MSA bit
  drm/amd/display: Access patches from stream for ignore MSA monitor
    patch

Martin Leung (1):
  drm/amd/display: Link training TPS1 workaround

Michael Strauss (1):
  drm/amd/display: Fix RV2 Variant Detection

Nicholas Kazlauskas (3):
  drm/amd/display: Wait for DMCUB to finish loading before executing
    commands
  drm/amd/display: Don't ask PSP to load DMCUB for backdoor load
  drm/amd/display: Add DMUB firmware state debugfs

Peikang Zhang (2):
  drm/amd/display: System crashes when add_ptb_to_table() gets called
  drm/amd/display: Add visual confirm support for FreeSync 2 ARGB2101010

Roman Li (1):
  drm/amd/display: Add dmcu f/w loading for NV12

Samson Tam (1):
  drm/amd/display: do not force UCLK DPM to stay at highest state during
    display off in DCN2

Sung Lee (2):
  drm/amd/display: Revert "DCN2.x Do not program DPPCLK if same value"
  drm/amd/display: Make clock table struct more accessible

Vladimir Stempen (1):
  drm/amd/display: programming last delta in output transfer function
    LUT to a correct value

Wyatt Wood (1):
  drm/amd/display: Add driver support for enabling PSR on DMCUB

Yongqiang Sun (1):
  drm/amd/display: optimize prgoram wm and clks

Yu-ting Shen (1):
  drm/amd/display: limit display clock to 100MHz to avoid FIFO error

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   50 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   27 +
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |   20 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   26 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   10 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |    8 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   10 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |    7 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   52 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   25 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    7 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |    1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    1 +
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   16 +
 .../drm/amd/display/dc/dce/dce_scl_filters.c  | 2204 ++++++++++-------
 .../amd/display/dc/dce/dce_scl_filters_old.c  |   25 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    5 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |    3 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   15 +-
 .../display/dc/dce110/dce110_hw_sequencer.h   |    4 +
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |   13 +
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |  101 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |    8 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   58 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |    2 +
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   |   11 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   45 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |    2 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   38 +-
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |  138 +-
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.h   |    8 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |    2 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   19 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |    8 +
 .../amd/display/dc/dml/display_mode_structs.h |    4 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |   11 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |    4 -
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |    4 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |    2 +-
 .../amd/display/dc/inc/hw_sequencer_private.h |    5 +
 .../drm/amd/display/dmub/inc/dmub_gpint_cmd.h |    1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |    5 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |   12 +-
 .../amd/display/modules/freesync/freesync.c   |    8 +-
 .../display/modules/hdcp/hdcp2_execution.c    |    4 +-
 .../gpu/drm/amd/display/modules/vmid/vmid.c   |   16 +-
 47 files changed, 1878 insertions(+), 1169 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_scl_filters_old.c

-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
