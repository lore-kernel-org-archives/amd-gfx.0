Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB59C4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF7E2072D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gd/D09d1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF7E2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C856E160;
	Fri, 20 Mar 2020 15:11:49 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750042.outbound.protection.outlook.com [40.107.75.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 182526E160
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaoB2OwZRhEBQLLL8OA59SBAFCe+L+FXhf6e0xGYkc5nl0fSrCKEcCkXvTgShKmEBkfMOHiEYGdbwV+HRhl7+UOOwqfS3+Bmb1DywPknK7AvNwHfNs1cL55tfc8bndyF4u5/EVQPk64Fo24aoKlxfapcAXKJmHsncycH8q4HBzOHbCXMx+gBINMHJ22BsnUGBkvW++Epl73IlSNESotSLPRzK4jsIntYGNpHbGg50hZqr9bbko60TugyLBVF6n0wLKC5Us7+ByNQVtQAKAis8FJlm4hDBgfxeeT/TTsVmlw5gEbeeiXY2uK25Lvjz8FgL6VAE+fq6VNEcHzYUdGssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EieH16+N3BwdzYO+00a9SEXoKl6eYV4bamLOw8Bv10=;
 b=kkQueXABkc74t78yGfj6+KbElEvlcLHlikJxW7J5AREAogEhfHEE8dUEceadLdPtqGTA5J3e3TFB7tQiMNacmttZtp9CjMVEWc7SWUavqe6PZd0QqelDCPcNxaG4jO9fNnm0+4yUIzsNpejA1d/bhquF4rjrkvxfajF+4+VHsPW7ojBgSFDrVeQn8SutlR6vIdOZt0oNu3v1uOnHzL2sneHA2sSyafT9gXMn6cU2sGQcg4sycRYXas9C43/3THjjfDVh+vThMQQS4bfpyFoLdplxwZ6aVFHVTcBLQ7Z6Ghq6cwLI5mb+H1E8DsU7EviKctjGD4ZEkIahwRjTkSJ02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EieH16+N3BwdzYO+00a9SEXoKl6eYV4bamLOw8Bv10=;
 b=gd/D09d1xVoY2BMfWOvklKpW+V4NDHEMmgwRbK0HllgUq4rofqSIFdb7zgNKUegm7LtVEcAXWLJBI4FwkwsB5czvGsHn9fcAEitjxVXc+gC8iIipY1lHx3zdbs3KTanHJwhokfwNYOIzkS74MPHcdrhaTh7dtgDelR4Cw+zOdLk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 15:11:46 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 15:11:46 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/12] DC Patches March 23th, 2020
Date: Fri, 20 Mar 2020 11:11:16 -0400
Message-Id: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.2
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Fri, 20 Mar 2020 15:11:45 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac3be03a-df37-4ebc-8b16-08d7cce1014c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25721C7AC4A953B888B6883898F50@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(81156014)(66556008)(6506007)(4326008)(16526019)(2906002)(8936002)(186003)(81166006)(52116002)(2616005)(1076003)(8676002)(86362001)(66476007)(316002)(66946007)(6666004)(6486002)(36756003)(5660300002)(6512007)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vR90KneiR9mGA03JliRKiDkVekTfMoUvNRbx2zfYzYcokjO//ZcoeGyF4uBFVoSDgdVyLjwUY4Sy7DCBPn5iZ+t3lMdynDjjZnWvTNQ/79xSv0STECZU+PdLnjm39AcSsTfAmVHeakTwFzCT84lQYpu4WPpTU0UfD866GOwYx5VzQFW5w+SWEF2qYuOFc7PjHTbh+5oLmgh1Imb81p3EhfgLCURGuxZFaAiAnbXIJcFfBu+qgFGBcTzH8omu03JWUNq/Pt/Sarqq9gU+aIE5sSRKPX6pt8mMq9kfMocAm0Ndr8f+GghBJt6Eg/boQeEn2SOIG0TGHznJJZPjvL7VuPy2cVLJOld2MigA/o6qRCVPK0ltz/P265uaqsiyEEhQcDO7ghSVwNnl/7uZ3cNFcdsHUsi9KiXrkInOZVO8fZ0UJLUkGiNLNB0iAhgzXfDC
X-MS-Exchange-AntiSpam-MessageData: GBZ15ouF69U0wTjwDWCEiAr9Pzm1wLPaQU9XwbrPL3rGRyPBoU1k+xcKNpPvj4LWHKo1m6bZTmQvsghUasRdbVnkYFa+p8QAg4DjQC+aRBtWiu/7Xj++7r1qbdrrIk6iSRdPLsoLGdB31sRgESEOhxvZC0FEVisB1NpxDG0e6sw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3be03a-df37-4ebc-8b16-08d7cce1014c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 15:11:45.9155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrUbYJOguu5aqhU2wpqCJIDDDcNYi2kY9KrTn7sLCEq6lk8UM1XnRcnCazlhuNasA6NADXc6zX09ldNZec4bXw==
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:
 
* Rework part of the backlight function call;
* Support plane level CTM, and P010 pixel format;
* Get optimal number of taps;

Aric Cyr (2):
  drm/amd/display: 3.2.77
  drm/amd/display: LFC not working on 2.0x range monitors

Dmytro Laktyushkin (1):
  drm/amd/display: Fix dcn21 num_states

Eric Bernstein (1):
  drm/amd/display: Update function to get optimal number of taps

Isabel Zhang (1):
  drm/amd/display: Revert change to HDCP display states

Nicholas Kazlauskas (1):
  drm/amd/display: Use double buffered DRR timing update by default

Stylon Wang (3):
  drm/amd/display: Support P010 pixel format
  drm/amd/display: Support plane level CTM
  drm/amd/display: Enable BT2020 in COLOR_ENCODING property

Wyatt Wood (2):
  drm/amd/display: Add ABM driver implementation
  drm/amd/display: Move backlight pwm enable function call

Yongqiang Sun (1):
  drm/amd/display: Not doing optimize bandwidth if flip pending.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  12 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  33 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 417 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h |  40 ++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  18 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   3 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   3 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   5 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  81 ++--
 .../gpu/drm/amd/display/dc/dml/dc_features.h  |   2 +-
 .../amd/display/dc/dml/display_mode_structs.h |   7 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   4 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  11 +
 .../amd/display/modules/freesync/freesync.c   |  34 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |   5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  28 +-
 .../display/modules/hdcp/hdcp1_execution.c    |   2 +-
 .../display/modules/hdcp/hdcp2_execution.c    |   2 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |  39 +-
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   1 +
 .../amd/display/modules/power/power_helpers.c |  21 +-
 26 files changed, 680 insertions(+), 103 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h

-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
