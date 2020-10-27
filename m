Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C884C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07EF120715
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UPPOa4JW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EF120715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C4D6EC4E;
	Tue, 27 Oct 2020 20:52:50 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700063.outbound.protection.outlook.com [40.107.70.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624766EC4E
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlHveTN+iEsj65LXE5Y6JTejmLCz5q2wIMTR9m1qPwp7nUjgEbBlQwZJ8etmfBsNhrqr7i0ShjAmY3xGIPVrmSB64dNF3YbvR2WsRS/hFBV4sq5n2PCdZ2RTU6hUBsJKQ8TmhqEKUKB1lFQ+8GB5MC/XMOJ8jLXklYkE6XQR3wpRqjdJbuCZ9/+VLhIWP+ebT38GQLUFMOLoTM3JfA3ucbxCzazi3bw40KEhmXZLWKo3gWISB9t7w3/jUpNzvRcWFFZcT5+2lTIdSOqRtychnM94AUiPEwfCEHGIH/eJIg9Ijsj41IApEIsTlD2csabX/948eChEiVUcM1WA+J8TFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRZ6dqj5uuMCtbwg+nPSIEOYg2C7VAXCWEEl4c/UubI=;
 b=B1XLH2ZAfZvyNAhX+EbxAoVZBQQPdla90n8vGEOA3oNvLOULzQDVrFP914M32uyIBemP6utJc/rhnE0gZ8RkN73uygOHtEr/uJsSwjgeC2mk7E1Z2FpAcE1N+I25pR9K7NNMWKSzYUehmvi+dbLGbepUgMpLEMiMnSAJmO6zMUzDRAoNwHXPCbKgHoRQwHNXnl4aCLWwT+JBiy9IQReH+cxRR14M8YE38CDe+r/Jg2Dq1v1QxigvCdvQq9TNAlqMv/Ckj8CZ1/fD+LMV/AsKkAGHN+u1Sr5IEGna6ib9a8kYJOtox1qu0OQUig3ZTmDZcj8eFst3pEmXoJFOrANFvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRZ6dqj5uuMCtbwg+nPSIEOYg2C7VAXCWEEl4c/UubI=;
 b=UPPOa4JWnzQSHY3IG8guj8QYQ0hun+b1X0nGF57MMOwdvTlfoqzpMDKbShgrDANj7UUzPl3sNE3w/vx9NtQkRORHi+hSXCkca8lCk8qeAVzJfNz/x/gFj7mqcwjOG9HXz1XWVnIvy+r1y9859Ngo0KIsKs0t/8ei5RD+xrxEIlc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:52:46 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:52:46 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/25] DC Patches Nov 2nd, 2020
Date: Tue, 27 Oct 2020 16:52:09 -0400
Message-Id: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69fac8fe-d7e0-4e64-0f19-08d87aba4141
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595C728D2DD56F4E1080008FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzlyw6h9ZJQiXub6UGPw1HL7YRKSymwhAWiA3Jr+tpBNXme7kOhA6PzmqryEHbZDl/jIDMIYDvKzzeg3XxImyR7KaWyYv4CuKrggHxurngzT/OJvxBoHzPnqBSzisKm+qL103BHM0f4C0/5tFb8oqNar8jqHok5YyojbOlmE2rRZuGlnVP9mqAJcH0H055J4EfYQC5dlSpF8ZsRA3gGj2fWpNU4WGUZPTmZ+zC5XVhdoEfdr/v9fX42T0ISnMKkVLd1IS+KtaNGzBUJbmf++eAIophgCF/M3nQWYuOt8tru+jGmlkCmVLOksvHAQsDqc56hLL4yH87n2RxYtWkMvR/+ziZzVPvJDlzMP7RJzStKZehEIUhMxsZgnUbO4ymv6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: x5NcivUqiIAgBxQQ242isQ/KDGadUX1NbXgM09PZodAvdkN8B5D85WI3pBQZgxgupNX0ephjCPjU+WtkwmPKp0xN4/volMUleBMEE9XdVcDy8684jYj1eCOt5rFuNgNe6BegGTbcUgBhDRjiO4fmvFbVEh8F8v7AfSuqI9IJKMB6Nu6gTGGUuhyUj7/D++xlyLe02Ie00AmQB7EbccBnWaZaaiCFmEZ5YP/FI9fixZu58cG3k2EMBrTZyETqCtqwM9GtaGwIM9l6++S6q6MFl8NYLdnpnq5CkI0sz/l5dAMpjEP35W6K5gkhvg8FaNl5OitiGyn2GNln0IzyeYL7jhg6egk0yfMZGH0dqG6bnxK2iQMPhMujxl5xT0LAy4miGxeJ+NChfxBseZ0Efc2YuIVwMIqPeVBwnrcuVSVUD9rD7/lsd2KGoGbThety8wIByRiODrdGAxmZ8wFrLlU4JmyCv+kUf4kS5ajVI48mJ5a+ZC+27JF9qBvya9JbrMoVllDUKC6co/CDr6HeH0M3MaSnS3ojP8XBLiMVz5kHZuqPzbNIaKgWPJVj7XozzpSs5myJKIH0R6/AvcCuIyhnAkdVDYseDEbCSAby3gb8+LB0KzgYSQI2f0aZiVmNN8IeZmgHZINg2V0HHLT4nl4ywA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fac8fe-d7e0-4e64-0f19-08d87aba4141
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:45.1862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DVdUzZu4WQS9q09Vea5HmGFanNRQjFiPrWxkp2lPebtn+VXDY2ABKBVID5cccKg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
  * DC 3.2.110
  * Firmware release 0.0.40
  * Enable CRC calculation on specific frame region
  * Bug fixes on GSL, recout calculation, missing pflip irq and more.

---

Alvin Lee (2):
  drm/amd/display: Keep GSL for full updates with planes that flip VSYNC
  drm/amd/display: Reset flip_immediate to topmost plane

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.39
  drm/amd/display: [FW Promotion] Release 0.0.40

Aric Cyr (2):
  drm/amd/display: 3.2.109
  drm/amd/display: 3.2.110

Ashley Thomas (1):
  drm/amd/display: fail instead of div by zero/bugcheck

Bhawanpreet Lakha (1):
  drm/amd/display: Add missing pflip irq

Chris Park (1):
  drm/amd/display: Update panel register

Dale Zhao (1):
  drm/amd/display: WA to ensure MUX chip gets SUPPORTED_LINK_RATES of
    eDP

Dmytro Laktyushkin (1):
  drm/amd/display: fix recout calculation for left side clip

Eryk Brol (1):
  drm/amd/display: Update connector on DSC property change

Hugo Hu (1):
  drm/amd/display: correct eDP T9 delay

Isabel Zhang (1):
  drm/amd/display: Force prefetch mode to 0

Jacky Liao (2):
  drm/amd/display: Add MPC memory shutdown support for DCN3
  drm/amd/display: Add OPTC memory low power support

Jake Wang (1):
  drm/amd/display: set hdcp1 wa re-auth delay to 200ms

Joshua Aberback (3):
  drm/amd/display: Blank HUBP during pixel data blank for DCN30
  drm/amd/display: Blank HUBP during pixel data blank for DCN30 v2
  drm/amd/display: Revert HUBP blank behaviour for now

Lewis Huang (1):
  drm/amd/display: stop top_mgr when type change to non-MST during s3

Tao.Huang (1):
  drm/amd/display: Fix compilation error

Victor Lu (1):
  drm/amd/display: Do not warn NULL dc_sink if forcing connector

Wayne Lin (1):
  drm/amd/display: Calculate CRC on specific frame region

Yongqiang Sun (1):
  drm/amd/display: only check available pipe to disable vbios mode.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 124 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  21 ++-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  12 ++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  72 +++++-----
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  13 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   1 +
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |  12 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  16 +--
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  42 +++++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   9 ++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  18 +++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |   8 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  56 +++++++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  |   9 ++
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |   4 +-
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   8 ++
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |   1 +
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  11 +-
 .../display/modules/hdcp/hdcp1_transition.c   |   2 +-
 34 files changed, 418 insertions(+), 72 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
