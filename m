Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E9CC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD63208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PPLbqEyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD63208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267A76EA50;
	Fri, 19 Jun 2020 20:12:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 880546EA38
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZubPt0sG125s2ahnpcYMd7EEN5aPscfZW9WBW3dM0VuI5MnZwnEv0UxWBFdwzjKsI6fCyzacrMgngt8mPgsUnIR3wMLZkXXicjehDUcsUPQc3JELG1zVCkobvExx8X3sauAyfc4RZKSCCPCXvIs1dt2/uZbI6KViSGshO09/bvbOeGeXas4eiq712GcbPBAR4AoYIO89ryyu4FZ2K+kBdZ1vu2U0OYQ2W8mL0Br8UaDQKCiImR2y9uarf4RTx1W+OusX8/TDdK1Adt+BEafIl8xqx/aw5VYQ4VMrcUe2jt7K9VMBw2wISNbTaqU8vlfXz7PchBJXDG9czYBXOXMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZc+njAN5ziLZUyV2+xMPxF53yZCKgxiS3AhByeCYJA=;
 b=VKsXNyQWWGmdGZcpTEN2rQite3poqRt+xr0a9l5f9LdP5yX4Y0qxXGDcssl07J0xiRCW8O6V5b2Jozrj1XSt8IEi/VoLD3FtdK6yWUZMaWfaSKL/wa+LHrXHA6YE1d5Vohi5oI7nI1Zutkiur8ntNa+Tkmny5OA+ucImn02pI3lpxZl5PZ5aR8+iKsxx0JlgzOkf+W6w6kUIpKWO/QOUM1rLy9qll8K17/jZCaHuk3SDMIrKirt4jIeaGh286q6zo+zpaG2Vgt27VJyZ+mENLZ50Yi2DuPKV1SjA8WP174uiBV3izBU5zWUtqhHYDQGS0X3C9FS4qTQjmDt3Hptfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZc+njAN5ziLZUyV2+xMPxF53yZCKgxiS3AhByeCYJA=;
 b=PPLbqEyji18WYw+k0MHvkzaxLuexIRK/nCx5jyAsEK3qzJcPOOACfpR59u3xxCRCHpcl7y5X9z4qmJhKnTTxS0x9pzmEBGqtyQdNXX9eT7v9QQAKjKkD1DIHgGQe0V/c8kgzbLZ45/qBKhD+JPvdSjsk0oGeCCx+h8Yt57dVtvw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:48 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:48 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/30] DC Patches Jun 19, 2020
Date: Fri, 19 Jun 2020 16:11:52 -0400
Message-Id: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:48 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86be36f4-40cf-4fd1-76e2-08d8148d22f4
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3717D6DF68985241AD32C0C498980@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rjT5h0Gv4VuxMbGE/jbKCSckopdeLmsTmg1NKCun9S0X35vFx5cXxf5IjdBR/3MRBnPCGIo4qRtfnbqBDNx4o+lUueUGgAt1WMtE7U3EQMqiKBMN+ZleH1x/2xvSKm1oq4v0/6SyPMVr/drvDcQHmfpL47H7yepGthZbImRULkw5TiYD8wWX4l578yyaWSJKcyXdagVqfW92sIfWimq10bkjMV2FJadoeiIuKXFvwKxp9n6M1FWMSNXSnl3I5TZIhb9j5slmCYxUGemggG4Ut85CqANO+vdxEX14RjiyVbEl9vLwT8BEqWysDQ07QlP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(5660300002)(66476007)(16526019)(86362001)(6916009)(83380400001)(478600001)(66556008)(66946007)(8676002)(6512007)(1076003)(6666004)(6506007)(4326008)(52116002)(8936002)(2906002)(316002)(6486002)(36756003)(186003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NKf0hvwTCRs0wyg8Oi/uNh5RmPjFA6KWPPRYpjZ3lV29mXeBFWrxA5ToL8HR6PY292CCNpqrq58CwGbseEHAVRquCUl9bbiywxf/4ispPkIiUPMb4LIIG/h3yepPhI2UxDTV6h1mdrwYpoYqi6beEgmZGt19A4IBstoDMsUcRfdzKs1hODaGpWFnB6vwLrQnTymg7euwAs+/fAuUXhGhh7FoHJE1/CH5rnvXW0yAUQFpmzo7FgidoA6dju9fQXgtXicLpeNsCQFmlDub1jmvJh9UsGWFc4fMlbAEByaokeje1Acixp7MGmG+WsLM6fRIgyKTbfi+wPDFKz3thyHziAkACWldP9u8B+EDnOxhQsBRWFNe9awSaHgD9BGkUUDHv64T6p+ECBEEe8HiPVpu7WBizjn67VRBKPQZmSlOOdokIkAr2v9A6F8JNYNl+0r1RjuOKKydFwGZncOhA2CyTq9lhVf3NJQyeFzk4M0kUQvoHPCsw99Dc/LbXc88jNco
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86be36f4-40cf-4fd1-76e2-08d8148d22f4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:48.4083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaBCiwtzpPKdrjzoiydk4m1PudUju3NXxoeOrrh80HRcGXJTr6enhOHZlzYNXq2380o30+2QV5bAjHf7pe+Sew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* DCN3 improvements
* Fw updates
* A series of improvements and fixes

Anthony Koo (4):
  drm/amd/display: [FW Promotion] Release 1.0.16
  drm/amd/display: [FW Promotion] Release 1.0.17
  drm/amd/display: [FW Promotion] Release 1.0.18
  drm/amd/display: [FW Promotion] Release 1.0.19

Aric Cyr (2):
  drm/amd/display: 3.2.90
  drm/amd/display: 3.2.91

Aurabindo Pillai (1):
  drm/amd/display: clip plane rects in DM before passing into DC

Bhawanpreet Lakha (1):
  drm/amd/display: enable assr

Brandon Syu (1):
  drm/amd/display: use dispclk AVFS for dppclk

Camille Cho (1):
  drm/amd/display: Correctly respond in psr enablement interface

Chris Park (2):
  drm/amd/display: Force ODM combine on 5K+ 420 modes
  drm/amd/display: Allow 4 split on 10K 420 modes

Dale Zhao (1):
  drm/amd/display: fine tune logic of edid max TMDS clock check

David Galiffi (1):
  drm/amd/display: Compare v_front_porch when checking if streams are
    synchronizable

Derek Lai (1):
  drm/amd/display: VSC SDP supported for SST

Dmytro Laktyushkin (1):
  drm/amd/display: fix 4to1 odm MPC_OUT_FLOW_CONTROL_COUNT

Eric Yang (1):
  drm/amd/display: add mechanism to skip DCN init

Jake Wang (1):
  drm/amd/display: Added local_sink null check before access

Martin Leung (1):
  drm/amd/display: enable seamless boot for dcn30

Michael Strauss (1):
  drm/amd/display: implement edid max TMDS clock check in DC

Mikita Lipski (1):
  drm/amd/display: Fix calculation of virtual channel payload

Nicholas Kazlauskas (2):
  drm/amd/display: Fix DML failures caused by doubled stereo viewport
  drm/amd/display: Fill in dmub_srv fw_version from firmware metadata

Peikang Zhang (1):
  drm/amd/display: Red screen observed on startup

Stylon Wang (2):
  drm/amd/display: Enable output_bpc property on all outputs
  drm/amd/display: Fix ineffective setting of max bpc property

Wenjing Liu (2):
  drm/amd/display: allow query ddc data over aux to be read only
    operation
  drm/amd/display: DP link layer test 4.2.1.1 fix due to specs update

Wyatt Wood (1):
  drm/amd/display: Use dmub fw to lock pipe, cursor, dig

Yi-Ling Chen (1):
  drm/amd/display: Fixed using wrong eDP power sequence function pointer

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  34 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  37 +++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  19 +-
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  11 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  18 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  40 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  14 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  42 +--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 121 ++++++---
 .../drm/amd/display/dc/core/dc_link_hwss.c    |   8 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  28 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   2 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   3 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  57 ++++
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.h |  39 +++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  25 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   7 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  20 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  13 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 245 +++++++++---------
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   8 +-
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   1 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |   5 +
 .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |   2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   5 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  51 +++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  15 ++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   4 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c |  10 -
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.h |   6 -
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  50 ++--
 39 files changed, 649 insertions(+), 315 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h

-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
