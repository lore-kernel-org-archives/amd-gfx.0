Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD23FC2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBFF22D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZQxj1NXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBFF22D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA4E6E91B;
	Fri, 20 Nov 2020 20:20:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0059289C54
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UO6NVtwgMmO3hKO/+KpPxUW9vZnFzE3p2fEAFIfC68xRMvYQotmr2FTvJcp7D2oicPp1cf+/F7OJtcJ7X9GLEFlyAoyUBeQwRhQ84+dnsdOyXTpnwX66IK86iIflZA+9DdEndBhCWw+30ocdYtDT5xcmTrEDCF5wZWnSwR1c9ydcPekAC5tXE54Bk/SswYQyAurwwqs87zNvBPQQKdJ3rToFNM77ZGgCiipCFKjekEipaQ3+ixX+8T3lz6kpw7abnF38Tr1NGOHWYgpevnfkJD1fbXElJGMLJ+Fs0OdPgiERv9CFZd6vzEFJjQLBuC+AECbS+PPmSYA6GH9erRqB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJa0lt2VHyWv9d7Zo/+2Q92m+n1WPoqfDS1ys78L3bA=;
 b=UhJixfTr0IO0DderWFvRHFa+PnkUEfMwth87sRuMyQR81UxWJWQv2WXWbD7AjWoXi4yZL4Br5aF8oAO0iym3INUy6rdYzciqb2W7+DL3cFfbbi2YTCUktkCfw+z8gPyyDJbWfDL1plOBIV3OdYrwRrJPQ/y7WYDBdDtB1rlWurWz5duLXvm2T8HG6N70fkwm8d2EQE7Ain6s/hKLme7hmL/+nMEelAbg+p8SlKrDOy2pD4WR67NxVB63j8AvvrTcC6uB7GBTX6mtOT1Ipj1Hu/6lBMRbq1diQ6hMoXCBo87bf4+PwIQhp5dmbT7vkLiF6syZo7vfWVC8OorGuMnpIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJa0lt2VHyWv9d7Zo/+2Q92m+n1WPoqfDS1ys78L3bA=;
 b=ZQxj1NXfi4MubDBaviVqaXD53lO+Pf7+veQNG7RdjOpnJpBBm16rRezAprgN/sHVluI93vd93ivzMJh0mnW9MWJ3G83zQ9zbjVg5TU1BIZErdXo6mYy/UtkQICIDGhQjSsCrRXUI9aKuhudQDtxj8trRBmQTtZuOcrtwAZahlyU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 20:20:21 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:21 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/18] DC 3.2.113 Patches, November 20, 2020
Date: Fri, 20 Nov 2020 15:19:40 -0500
Message-Id: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c73722db-d303-43d8-d18b-08d88d91b48a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4216B0DD01A79999B80E03CA98FF0@CH2PR12MB4216.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsOQe+qvPcffs90QaYUZ7yrDj/ZjCfq79iw0KpEaBzVbVP1cISXINPBjCX6yDvIYCVGKOfEtT/cxM2cjBGtDFxEi7NJDaGkC+qa0bE8OkmV18hCH9y1CDZNlgsu5ojLk++kW4O/ta55Fj1vL6hFdG7VLeFnKZrL8y3hFwC2CXubDrtRZCx5nVXMszqxy9v/ROXgkA+NG3IxznYOE+QzY9Z6Uhs0YiT226RedDA2ba41/WX+vIoSgrqSt2C51TLInSP9YUvzJL0YACIHVy7uaQBUjOHuWfxbeDh1HIetY4q+r7zYkvablhB+IDYgWooITNaCto1yuis7Pu8laiGmYPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(8676002)(2616005)(66556008)(66476007)(16526019)(66946007)(6486002)(186003)(6666004)(316002)(478600001)(6512007)(83380400001)(8936002)(86362001)(6916009)(36756003)(4326008)(5660300002)(6506007)(52116002)(2906002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uJOet37SKChaaZTwES6aMGVNho5U5HaLbaIK4k0oJ8zMmj2uKGEBeMJPSesbc7eEv0viJ+4sYk8EYv38zjGf3r7m4uWZWDLYrRSO8OykLeW0kOvPrJOrppZoL2oxemx7LBa9YW87RHzGgrzvE/yabJsJAB8CLQh36JCAtt/zyPbAKyrbyKo1MJ31dCelgKtLMc+axAheLblGCTRmlvwtqDpgA/xzei8PTtqAn7wfBGnD2vVRmDXI2pJ8XWxt/8gz/b0YA9FssI17bl0JIKrZPr8wcOPF7UEbrvav483K0qizZ843Xde9p7Q1fooZ817aEuhzNv4g0hE8bylLW8HXI5Atpvx+k3OGF+sSdS0Csl+FyEHHLFXkyyblKEaSpPOZNxfN3bssQntysT5QwejfiRP6hpclOJIetgtkroP1egRECyx2Yb10XeiULhSFvgicaleDa4AZT1SOOV7JyiO0dpKAJByL5mP7ZaCfFYVCnhotFqYmC4vm1L7NkKppdP6a/YwcmX/qsi4A53NZAexLkHJqEUJhszOjYcmDG45+ijmOYi8GwJc79uqk/gjG/PPR+OhhH8lk8shhtDQ07Cu+BcSrVuRSYTcUpvhiE3VqcoqQuCqvHho7gFfBl8tmtGzqGav0xpz5r8qMv7tabrfCKiPd6NeZtR5pvUg0T1j1gwcc0uhlPfnHIi33RWe5SDy/04Ri591fpVMl/8UynVzP4XdfJVIXStRlI5XCW6TJ66E4wts+qa0zxjsN8jWKtWn52BFYOLKlFWhzu6jIu4sH9eM+JxWJfODe425VJF2vYtJJJX6FaQihOFdJDaeb3DXFrlXibfW0CJBEj86M+YVzZv94rrcnBpfkQ5Pr40DYWoXYqWXuOutFh6Y5ySCVtA7MFOMm/p/B2snWBy2Mqwz/BYZ0LOfQ5QBF7XaDK7jCrAY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73722db-d303-43d8-d18b-08d88d91b48a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:21.3974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 846RSz/Rt+Tsn1iA+46ebvvdi6m47nt2Vpj2fGwn+eLnrGGFy4zcRN1v3qD5uI2sxE5bvAx8UrAW3lIi9fqc7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
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
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:
 
* Power features and optimizations
* Code cleanup
* Enable stutter for DCN3.01
* Bug fixes

Best Regards

Aric Cyr (1):
  drm/amd/display: 3.2.113

Ashley Thomas (1):
  drm/amd/display: Source minimum HBlank support

Camille Cho (1):
  drm/amd/display: To update backlight restore mechanism

Charlene Liu (1):
  drm/amd/display: add i2c speed arbitration for dc_i2c and hdcp_i2c

Chris Park (1):
  drm/amd/display: Update panel register

Eric Yang (1):
  drm/amd/display: expose clk_mgr functions for reuse

Jacky Liao (3):
  drm/amd/display: Add DMCU memory low power support
  drm/amd/display: Add BLNDGAM memory shutdown support
  drm/amd/display: Add GAMCOR memory shutdown support

Sherry (1):
  drm/amd/display: change hw sequence

Sung Joon Kim (1):
  drm/amd/display: enable pipe power gating by default

Tashfique Abdullah (1):
  drm/amd/display: intermittent underflow observed when PIP is toggled
    in Full screen

Wyatt Wood (1):
  drm/amd/display: Clear sticky vsc sdp error bit

Yongqiang Sun (5):
  drm/amd/display: Enable stutter for dcn3.01.
  drm/amd/display: Add internal display info
  drm/amd/display: Check multiple internal displays for power
    optimization.
  drm/amd/display: remove macro which is in header already
  drm/amd/display: init soc bounding box for dcn3.01.

 .../drm/amd/display/dc/bios/bios_parser2.c    |  68 +++++++++
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   8 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.h    |  10 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  16 +++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   7 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   5 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 +
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |   7 +-
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |  36 +++--
 .../display/dc/dce110/dce110_hw_sequencer.c   |  13 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   9 ++
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |   4 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  |  13 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  |   4 +-
 .../drm/amd/display/dc/dcn30/dcn30_dpp_cm.c   |  12 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   7 +
 .../amd/display/dc/dcn301/dcn301_resource.c   | 130 +++++++++---------
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +
 .../amd/display/include/bios_parser_types.h   |   5 +
 drivers/gpu/drm/amd/include/atomfirmware.h    |   1 +
 22 files changed, 263 insertions(+), 103 deletions(-)

-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
