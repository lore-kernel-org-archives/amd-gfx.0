Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F03C47427
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C998B206CA
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qQVgvovM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C998B206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE15E6ED12;
	Fri, 25 Sep 2020 14:55:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A1026ED0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edsZVxX5R9p59tz9D65CvZJ8z86D2lqJzIBo0Vyy8EHxR99HxyT1AaaJEvR0+2RK8/sl0h86nsrqhNwHhrSL9WzFys34kLILE9sdghTTnxttoWNz029LphZKSaiwg/Tb2YrkpVhuKmFUdV6f6+uj1LggIgr5RtuRXsGYkgFLnk001uh2F86dXRAzBPuwivtCYFqYhOjNvjK/73KBIp+7FRUInys4RhbM9W99Fw4Bxgi938aFwsQ69ywPWfALWDx7tCguIusW3Rai0KJubMwOzln1jTpVvTcEUCpXfL6GdtuvhFM93fOIMBU3lA3s0mBeswfhXXvuoZY3kAStlKjp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGIYt7uEIvuFRPNcggCZkYJOpKPzUwiSHmFj0ZDMX68=;
 b=hzjjjgV/ZUlM2KGPwXf0jgDL6BX3wT9cgK37uqEg+fJ60el0NReN/tLIdL76wlo5CRwm6hAEugpk075vvfmYGP9UDG4rG199J8uHZZ3Cwqh5V3ea4TXWTjCNoxFKxQQCR7y/lwui/moPZu64RBS3aqeTJnssQySMvd9Qk424IAnOVMr4TBL5qlzvmKgF9AcjQkFZRR4ZjpmF1/5bYqmuFtPrj2o6wIINxLfn8Hl3OsXz9Kh9lXMHPfCYFuwpo6Mx4xEZLWEnErV2tT8887yoStSF69tkO+XdXhALc7GBQGOHSXtLiEUxdM6g2gymx0gFJ5vNZw5BDvBhvqrK7vm6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGIYt7uEIvuFRPNcggCZkYJOpKPzUwiSHmFj0ZDMX68=;
 b=qQVgvovMlMhhcf+pkZ+0PrzZRsOxUJWc2xuonndMKQVYi3ISMVhn2p4AW8RTZbkf7gJaqobyGDxYNbXnj+4SMISHmoFAWdplHd6z39bzio4401MFEEBNeyf55CjstASvkHqliWSQp+lRSn33iJlpFuNc0VCOdIIE7CTMMBfqbrI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 14:55:09 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 14:55:09 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/9] DC Patches September 25, 2020
Date: Fri, 25 Sep 2020 10:54:46 -0400
Message-Id: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::980e) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 14:55:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 057beb10-732e-4161-7388-08d86162ff61
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42192D96E817491CB1B3DB4A98360@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+wD7MGsCokuDZ2yrlzWpIZCXOuYrFOvGb/O5xabm94S6xyhmwAfOyRr4ownmVQLo+TuglJSEZfEid6FmBB0l37hSugzRhIY2Qkm1QMr+QojsZxsj4bxY58c6VQF2wrS091szR5X5XGBW+HzVoP/cqcILwwJVjP/HAYsdB2j9wWC7Th30jJ4s3rlcNEgRwvk6uRX74zdso9MxFUYTwje9lwD4UrYzQEhtfpU9iJAS5/bU85VP64WbWWxJEu1vAelxpJArgFH+pBMg426shDEkRhRbHGCJPtsgsLNQ4SKl2sblioA2eXbY/JbbVWopBF7D/RC4oRD/ZFuw4FYs5ICTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(6666004)(36756003)(16526019)(4326008)(6506007)(52116002)(2906002)(86362001)(2616005)(478600001)(6512007)(66556008)(186003)(66476007)(6916009)(1076003)(5660300002)(316002)(8936002)(83380400001)(6486002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lw2AuxdYvBtaPlbXCcNho+hZYMWG2YccZ8mr033L5jsHguspOQyhyIXlHMUblGC4iC/dGPsQSoxThzjE0atgsJatzyD1mHz130t1ZYJZvZ/VUERoceqQBcMoHQ1zayr5Nc4ZglHIZTXNsOZFmmUWjQi3k3BkHJ5x4Cj7Nr4GE8cTF6OMq7zOPDwGWsixcWCU6s8H/yWM75V3RMlLmiZVpB4g3gXQSYiu+NLnQ0F4aDZXw6nenHTnSkrBLb2lfJuNNbkY5XOU1+hiuMWQvfG695zNhLJHxbNs8fpp/tuoYF88QjRiLGuyzn9ujZ/BEru42CdfD0iqumF53iOKPFsQJeVmMrCc23t9RrQcur/G15WfPeUlhsiznaBVyQ5ZeMsTeQwmh7L82L1vJFwELiXz9V8mc9XHh2dfbOgWMZw3ZnRU7JwCoEWwyZyW/XmbCAwAT/TN4hKGOTYuY5PjKJEs4WZ1elrU+dXiNbZg1+iYDK470FpCOcvxbi0LOSKZIVeIZGv4GiqdH721OIgCLJ9DgpIUng1FKvQ+p/hEGMD3jYC5Vzx3aEVAEOGpBqq5ryNIoFsduQT1ACdo3dUiXZxYcNP4a4GjsphB7GndSqDFiIlA7NGI6s2unruF8LCya5MhIcnwzGpTxFYnccoMVLC7yCY3hOpkeCNq/qqGwznu6teXM5sbbaf1GXPWsvSPQegA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057beb10-732e-4161-7388-08d86162ff61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 14:55:09.4232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUn9fwfURYwcZRycPAuhuLlDy5tvBCCWG5q3NJaKFvl1TkUmYecPxXabG3eP3X88PvHakdjVktF5rKdEN9PyBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:
 
* P-state refinements;
* Improvements on DSC
* Updates on NV1x

Best Regards

Alvin Lee (1):
  drm/amd/display: Update NV1x SR latency values

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.35

Aric Cyr (1):
  drm/amd/display: Revert check for flip pending before locking pipes

Chiawen Huang (2):
  drm/amd/display: disable stream if pixel clock changed with link
    active
  drm/amd/display: disable stream if pixel clock changed with link
    active

Eric Bernstein (1):
  drm/amd/display: Add dp_set_dsc_pps_info_packet to virtual stream
    encoder

Joshua Aberback (1):
  drm/amd/display: Calc DLG from dummy p-state if full p-state
    unsupported

Wesley Chalmers (1):
  drm/amd/display: Add debug param to force dio disable

Wyatt Wood (1):
  drm/amd/display: Ensure all debug bits are passed to fw

 drivers/gpu/drm/amd/display/dc/core/dc.c      |  74 +++++++++-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  21 +--
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   5 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  12 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   4 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 114 +++++++++------
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   5 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   2 +-
 .../dc/virtual/virtual_stream_encoder.c       |   7 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 132 +++++++++++++++++-
 14 files changed, 305 insertions(+), 79 deletions(-)

-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
