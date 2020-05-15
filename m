Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CCAC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCAC20657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DRKCVSiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCAC20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200EB6E193;
	Fri, 15 May 2020 18:13:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B42056E193
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwlroODoGAgHZBDYcO4zTuf6aEnFkuz/sr8peU6bBEcdukaE3QD1XGOOsfsJKCZ8gpA2qcMcXaOT9V2RF43f5WgjvhQPF2qH7C7oP2EOeBZhFdvVs1X96TQ26sgDgqP7qW7LpJxMUhu587F6Sh0DivsM5mS6TFw04FGfGOwrn7RaNm7WCc/KouSGj/mvDOsefkV6r+inzUia6j2Zbu0Qkz6zZMAVCJ+skyUPYNlOSx/GlclY2F5phbvFCb8eJpONm0MoqDgLHkr0RMKpdVYpz/oORus/9qLkgSi2KWIv6jsqTurgrmxJ39xe8z69JDilqyer+nRVUtzQUnpqa9Gs+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvrr6qcQ+wHNEFk4bwaVxZIIYmJCWawyGUxIldI/9tQ=;
 b=mftYbwQG8+8njpa0TB763poXX9d/1TIZrKcFs8fvXdbTmd93LJ1oNWw4upSQvw9udiEBxVUwq7VmzbcxfWkmp2FEIqHkUGMiqPzEgzbXuNzO06LqlpcccwgvKch8ynEgN0D3Zvwv1hB/qEJoYUBUNxYzGdtkGEjVNhHem60CnTR8nx3TlwmnjYakjhbUQF77JcSPpJQFN9DLxmQtaGlJ9awjFoFLWOGyN3iaW/Bq52VBtWZbmKXeIf8VLa5/lTZ/FbaTtuYlLOZzJiNqLToeHg/ILWnW8XpZX25hDmKY5YecQ1NoKELfNCTERCRGxQgpAFPaUmsWRAmQuzQSkxnw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvrr6qcQ+wHNEFk4bwaVxZIIYmJCWawyGUxIldI/9tQ=;
 b=DRKCVSiVSmdXF1CIcBGMG93GRyYZij6brMmlm5ZsfSSTiBIKUmSUQJI2QFdr94EGy57Bk3dgtL0aMN2nsxWz4K3J0FsBgujavp7TxdnT71nbqU5TjThA656Hotx3Ppi4cjkLXYwMxEU7ftycFPJwhxt3fiLUt7v2MGP1UvQotxI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:13:37 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:37 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/27] DC Patches May 15, 2020
Date: Fri, 15 May 2020 14:12:47 -0400
Message-Id: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:36 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2171107-937d-453f-ba72-08d7f8fbb009
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB39742AF21C4A6865BA08AC2D98BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/iqr7MyXcort1qubDLk3kMpBavq9OIP22L5phQy+7iJLNfgQVRrONLLzWYAOd5XZRaJEPbAozxke+0Mk6v3pcBraRmcB+b7X8sI9MeGekqBcrUQF+J+OErT/SDN0KYcbbBkeyRw7qVSz1HIcTs7CjmvelenCUNEP00x2syj54QGSFL+doCv96wmkNKIEowSXEhjgmA/E1xVDYIcaH5Qs7MBNxXuT3gyxGaB/yHE4iQenbZPnwdJFy8vVKzFpEowL/AjP/j4In7YtIAM6s5vFZ8AprFGIOYGr+Bum0H/+ilNVlNsgCZ9yVkiKQ7vZa1onDQrDN4Z8RCW7tBKyWaN/HVLkVFEq83eRVCk5SgFFCPMEaG7lmN19gFuq7B5VAYo7WrAqOXq8zI8OuPBieveQmBfCQezRRGW9ZNPozsPvjkf4d3TS0rviSupnzXCiNlH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: G5oxmZ6OhDaC8TyyrOW5/H1RBXlItEvX9uo303it7zduyLmGFO2iach8hDhQFSAmGgfCo/r1Y3o260yB27JHBw7fz5epMCRqFOaEoP0/q+z4RbsR4d1BbwtAno/yoxsEawh0A4HMm/XdiwkWixJ37ZfwRMF6kSqHq7aufOO0zJ+bzjgwJBVD4IkiIgk56CSCG2Yk+5KnsDRz81wxhSvZJQlafg1TuoZ2RpDfZO/Ka+ZouYyxC5/waesupETSvKWSK+1EkhWIxpZWEraaRJU+17XnBPbtobjxrNk/mY7r0GyOOT7Uo78rtOYCrovb1WR8He/bkWF+tq8BICeOrC3TwvPICjHn8IR4tpS006Mx8iVLL3HTHOHE+bk5kenKNUKuxf2UBazcCs+xuK6m6Q6fF3CQF3ddpMTcYFod2wJvxdHl8KpCmvcDDRGt2r3b5NWi7BECQ0s27C64HRM1SYTWFfQEDpQ4tiLfT4u1zXz8Xa5Pe4BIyN5rBsopSN+mxJ/trLCAO1zDBDmJ2leF1/obFQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2171107-937d-453f-ba72-08d7f8fbb009
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:37.2083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+EQvF60sLr07hdZiInpKs+jLvI+X05f4L8A3kNwnZnYhngX/TYACyVRCDZeYZqQCYKhc+7+KQt5c6XE1HyY9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
 Harry.Wentland@amd.com, Aurabindo.Pillai@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:
 
* FW updates;
* Fix issues on DML, modes, ABM, and others;
* Remove file that use FPU unit;
* Improvements on DMUB, DM, DP, and others.

Anthony Koo (2):
  drm/amd/display: FW release 1.0.10
  drm/amd/display: FW Release 1.0.11

Aric Cyr (1):
  drm/amd/display: 3.2.85

Dmytro Laktyushkin (5):
  drm/amd/display: fix and simplify pipe split logic
  drm/amd/display: update dml interfaces and variables
  drm/amd/display: correct rn NUM_VMID
  drm/amd/display: fix dml log2 function
  drm/amd/display: fix dml immediate flip input

Jaehyun Chung (1):
  drm/amd/display: Handle persistence in DM

Jake Wang (1):
  drm/amd/display: vbios data table packing

Jinze Xu (1):
  drm/amd/display: Set/Reset avmute when disable/enable stream

Nicholas Kazlauskas (6):
  drm/amd/display: Check bss_data_size before going down legacy DMUB
    load path
  drm/amd/display: Don't pass invalid fw_bss_data pointer into DMUB srv
  drm/amd/display: Defer cursor lock until after VUPDATE
  drm/amd/display: Avoid pipe split when plane is too small
  drm/amd/display: Add DMUB firmware version helpers in DMUB service
  drm/amd/display: Support CW4 for DMUB ringbuffer inbox

Nikola Cornij (1):
  drm/amd/display: Minimize DSC resource re-assignment

Rodrigo Siqueira (2):
  drm/amd/display: Add bit swap helper based on endianness
  drm/amd/display: Remove dml_common_def file

Stylon Wang (1):
  drm/amd/display: Fix incorrectly pruned modes with deep color

Sung Lee (1):
  drm/amd/display: Do not fail if build scaling params fails

Vladimir Stempen (1):
  drm/amd/display: DP training to set properly SCRAMBLING_DISABLE

Wenjing Liu (1):
  drm/amd/display: DP link layer test 4.2.1.1 fix due to specs update

Wyatt Wood (1):
  drm/amd/display: Fix ABM memory alignment issue

Yongqiang Sun (2):
  drm/amd/display: Implement some asic specific abm call backs.
  drm/amd/display: Remove nv12 work around

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 106 +++++---
 .../display/amdgpu_dm/amdgpu_dm_services.c    |  25 --
 .../drm/amd/display/dc/bios/bios_parser2.c    |  98 ++++++++
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  21 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  11 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  13 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  86 ++++---
 .../drm/amd/display/dc/core/dc_link_hwss.c    |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  28 ++-
 .../drm/amd/display/dc/core/dc_vm_helper.c    |   3 -
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  92 -------
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  11 +
 .../display/dc/dce110/dce110_hw_sequencer.h   |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  72 +++++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   5 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   2 +
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.h   |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   6 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   2 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 193 ++++++++-------
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   7 +-
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |   7 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 121 +--------
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |  89 +++++++
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.h    |   6 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   6 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h  |  69 ------
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 -
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  33 +--
 .../dc/dml/dcn20/display_rq_dlg_calc_20.h     |   1 -
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  33 +--
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.h   |   1 -
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  36 +--
 .../dc/dml/dcn21/display_rq_dlg_calc_21.h     |   2 +-
 .../amd/display/dc/dml/display_mode_enums.h   |   6 +
 .../drm/amd/display/dc/dml/display_mode_lib.h |   6 +-
 .../amd/display/dc/dml/display_mode_structs.h |  11 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |  60 +++--
 .../drm/amd/display/dc/dml/display_mode_vba.h | 229 ++++++++++--------
 .../display/dc/dml/display_rq_dlg_helpers.h   |   1 -
 .../display/dc/dml/dml1_display_rq_dlg_calc.h |   2 -
 .../drm/amd/display/dc/dml/dml_common_defs.c  |  43 ----
 .../drm/amd/display/dc/dml/dml_common_defs.h  |  37 ---
 .../drm/amd/display/dc/dml/dml_inline_defs.h  |  19 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |   2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   3 -
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   7 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   2 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  11 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  16 +-
 .../drm/amd/display/dmub/inc/dmub_cmd_dal.h   |  35 +++
 .../drm/amd/display/dmub/inc/dmub_fw_meta.h   |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_rb.h    |   6 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_types.h |   9 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  28 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   8 +-
 .../drm/amd/display/modules/inc/mod_stats.h   |   8 +-
 .../amd/display/modules/power/power_helpers.c |  95 +++++---
 .../gpu/drm/amd/display/modules/vmid/vmid.c   |   7 +-
 65 files changed, 983 insertions(+), 879 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.h

-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
