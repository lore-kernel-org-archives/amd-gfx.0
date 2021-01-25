Return-Path: <SRS0=8/fv=G4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8ABC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC48E22240
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC48E22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 221DC89E86;
	Mon, 25 Jan 2021 13:44:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEF2589E86
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jan 2021 13:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDsbrqz236VTAkkvwHH7VT/6mhp8hoDSfa5MyNdQYEEYR6zfDSOLjFMyCJKXYLlDo4P54u3P5/X3OLcvpvfc8UyF3ygB9PouP97NX0skLH7B4SFCgRZc6MLJVAnWucJVEmHe8e9Kvev2aHcqgU2bGO0EP/kBZyCENVpUXZAPZ3VB0ujCVkfHhjNO6HSrWMmNSlV4IdjAxdx95K9x9k0UPXohBVoUZciHfNZtxYMHbBdh23WxN0aLohcFNNKy16M7SDWFxAEeggeZcpy/fwKMAPp+rNiCrMFK6bxQnFe2pYFPU4ThO7tjxoaAGbNh95xqgrHLQMk2p8phTJ99htgcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FG5bf0mX20BqM4fLyCXAopesOSlN2r721AnzrgkLa0s=;
 b=RNu8WlX6p5V0Cn8JKo/N3RSXrWLxloepp42cQ0dERYHeWiHBz8dSNuAU/NL26XvLp9DE/b8xkzAevJOPbaLCG1VZDdossQHtjDreVpccHrUCD4ikRJnn49HZkmwfAy85UL7kaRNbF8hCR/IyLtzBxa+iy/6E8n3ZdVHH1ZzDpow5FBE5/Sg0aH138mM5/0dT6A5zbVfW+aebxO2N9OXrmCk2c+zTHodlhS5pUlqDP6g/wCyg2Q6sD/ZgoFUqIgDKZovvM41TVjqbrNvpGaOywh8WnQul37UuM9txgt04g/vWaC3uqvehikUoNpx3ALuWNUZPvqMynolDCs+z9R/EfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FG5bf0mX20BqM4fLyCXAopesOSlN2r721AnzrgkLa0s=;
 b=DkGTjTqM3d8ZWBT9lDc9TAIj/m8duANn+sCxtwCKUpGR+cnuokW81rysNCbszMllvUmGwZIgKxiVAvgHKyOn+YiswCo+IuVIEOcWeGdGyp4JvQ/ui8S+OpMoUiHDiPcEj/ItayVEMXLwuNvkrWCVJ4yGdV+9E9QyUfpcg3jS0Ok=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.15; Mon, 25 Jan 2021 13:44:16 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 13:44:16 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC 0/7] Proposal for isolating FPU operation
Date: Mon, 25 Jan 2021 08:43:06 -0500
Message-Id: <20210125134313.305184-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:56e0:6d60:7f86:f3af:1efb:628a]
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:7f86:f3af:1efb:628a)
 by YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Mon, 25 Jan 2021 13:44:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a50a743f-d8a5-40c0-9a28-08d8c1374e80
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4041FEE4947BCAC5FF6E9ACD98BD9@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcksOyMRFGbWyCadTkjcyjinEFNBomvNJLIPNovhwgFll16gjazEVdC96PD02Z5sTop1SJgUMGkUGjt+iZUi5JWjhBIa1Vx8cMROKHCRhNeSpzfVGv894wpAJ5NO0OHWy+XdTT7jk4oRacBx6+2EXRdAOW3HAJaToH8tUB+GnLL4ATcsQwg7MP4usagwTNkmG3lyqpq8vEJPDs9S0hv8EP9XXhYPy/9LBA2gGz4Zk0ESnpIBDCAr6tsnsvny1rDfYZrOdtTLvbovfFkqITJEIjgEQF6wtDN+8KZaP9jXiCknVZGJqful9O0ajcNDuv3IUfCEzELxwdpW9GiRuHOik16cd1dqj4lNzmkEXIjtRFgI6c6VmwVAVudWoSbJgmiJwnOCgXnJSR/7TcRtuHHWLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(2616005)(316002)(16526019)(4326008)(6916009)(1076003)(66946007)(5660300002)(66556008)(478600001)(66476007)(54906003)(6506007)(6666004)(52116002)(36756003)(8936002)(6512007)(83380400001)(8676002)(2906002)(86362001)(6486002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?APZLwuyx4CJuiHzPxP+ShW/OSfa4DAt1brwc9UMLpYmaPuxQ/3L35J07Y4q2?=
 =?us-ascii?Q?AbX1cow09YBciC1b6VBoCHVe+UP4RXh9PYkiWD9mdSWGHgrd8Xg5KeKI9CjU?=
 =?us-ascii?Q?fzNzeNypX0lqbiIeVHbdV7hqEgzJb1tl07iI8j1hDZ0ztyZhezmFLtIYlMDi?=
 =?us-ascii?Q?5QcSmVKnScSK3qCOeEbUkUuBlE+hBCQceNGpe6zDpi3XXRWjrA9KN7TNSIbd?=
 =?us-ascii?Q?hGaavOY5ERxITcCbfZROt8ktTv8+bn4hDF8xIwJ75/Sas74StaxiKMoUdmz/?=
 =?us-ascii?Q?/GiW5dMemsHSaOMGsqoaGQ861X4ABBh3zMBekYWIwhQvECPatCbfuZ98I3C3?=
 =?us-ascii?Q?7F3seaeHlcmvs1BrkfptUjU9Fmi8rO8w7GRvti/SmV6mFCP0bsTUW/6SlyXK?=
 =?us-ascii?Q?RT/UzYNprKkIbTwJovU4xAUooXMChUTQF8nkK6bRaL8URYDDiM2H1+MRg4K2?=
 =?us-ascii?Q?GxRSyxHAMCSpPKHlxlhFwV59bc3X8j9vIQeJrAFWETkqiDfFVuXyfTBGVBLl?=
 =?us-ascii?Q?pg/9VMmkkDTAlKXEnUwdZdNHGDyo1f+L9t94e5k9LFenPhfC1XIvysNBjB7k?=
 =?us-ascii?Q?2q6sFeEyR3taAlSGWsFPJwDQoXsu92gPv5abv09F/GxtUdv5VtDxBPe6FyBw?=
 =?us-ascii?Q?a+/9ptLYySOl1O4+xb27wGVRmRwRQukVMf5HSCoUfJ8fTuvz2gH+GDighrr/?=
 =?us-ascii?Q?1weXX4v0LKLPUIgIdkvdbBfHxFqWP4Y5Y56sop2iu85I0q17g4fJ4NrtHLvs?=
 =?us-ascii?Q?vOuDoFwRrNkPbbT5u8ne/Sm8OcA5jl8np+qd79Peq2VQhDuwUGXa2Xmk+Ow1?=
 =?us-ascii?Q?CVH9ftOCW0Cu+WGgOVWFK6QQ/pjloJ3ITHUgw9CP47tZDBwVi+UND0VRrmLQ?=
 =?us-ascii?Q?+1bAfTEtOxlnu0hcxZ8v/QGM865E8rr5iHZbGws8CDw7IL3MuUlVW4ecTwxn?=
 =?us-ascii?Q?/Hb8FWw9ByByP18D3sXW+1482+dXZGTllwqyU6E5CBt19qq7u2JtAU+Od6bM?=
 =?us-ascii?Q?U+MTgNZ/Qfto0sDNUUCzUnWBLfEbneLgdrzFQCU0fQwZ3kwXjGiUcVY1Iu3E?=
 =?us-ascii?Q?LxMj61SaN/afq/gFHOcqqG53+Jh4pHgOWt/c3dWXx1M30uRTZHT4ggXUEOi4?=
 =?us-ascii?Q?eqUJDqb8AwijNAoLzLNpPtFBW8hE+Kp90w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50a743f-d8a5-40c0-9a28-08d8c1374e80
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 13:44:15.9856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6B1TzzcEfiuIgT/XF4TIOy+5/zEhyI6ouBbba+9BWZbz2jwT+Hzexo4e7TqXRNpK5tNK/TLuFzsKc9d7OGbn2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

In the display core, we utilize floats and doubles units for calculating
modesetting parameters. One side effect of our approach to use double-precision
is the fact that we spread multiple FPU access across our driver, which means
that we can accidentally clobber user space FPU state. As an attempt to fix
this problem, we have the following proposal:

1. We first need to move functions that deal with FPU to a single place in
   order to make things more manageable;
2. After we isolate these function in a single place, we want to remove any
   compilation flag that deals with FPU from other files and centralize it only
   in the files that need it;
3. We need to implement an interface for safely calling those FPU functions.
   The idea is to add a thin function layer where FPU functions are invoked
   under the protection of kernel_fpu_begin/end.

One of the challenges from the above steps is identifying which function uses
FPU registers; fortunately, Peter Zijlstra wrote a patch a couple of months ago
where he introduced an FPU check for objtool. I used the following command for
identifying the potential FPU usage:

 ./tools/objtool/objtool check -Ffa "drivers/gpu/drm/amd/display/dc/ANY_FILE.o"

Based on the above command output and the step-by-step approach that we want to
adopt, I decided to start this work focusing on DCN3 and DCN302. I believe that
the best way to see this RFC is:

1. The first patch introduces an FPU folder inside display/dc, intending to
   centralize functions that deal with FPU. Note that I introduced two new C
   files named dcn3x_commons inside a new folder called fpu_operation; I used
   the name dcn3x because some of the functions inside this folder are shared
   with DCN301 and DCN302. In other words, all FPU function which is shared
   across DCN3x will be placed in that file.
2. The next set of patches, start to move some of the function that requires
   FPU access to the file dcn3x_commons. I did it in a small chunk to make it
   easy to bisect in case of regressions.
3. Note that one of the patch touch DCN2, the reason for that is the fact that
   the function dcn20_calculate_dlg_params is shared from DCN2 to DCN3. Because
   of that, I create a new file named fpu_commons for keeping functions that
   are shared across multiple ASICs.
4. When we move some of the functions, notice that I also add an API for
   accessing it via fpu_kernel_begin/end.
5. At the end of the series, I dropped the FPU flags from the files that I
   initialize refactored.

We are also working on test stress for validating this change from the user
space and kernel perspective.

Keep in mind that this series is not done yet. I'm looking for feedback about
this approach because we have plans to use it for trying to fix our FPU
problems for the next couple of weeks. Finally, we want to do this work
step-by-step because it is easy to introduce regression when dealing with these
FPU problems.

Best Regards

Rodrigo Siqueira (7):
  drm/amd/display: Introduce FPU directory inside DC
  drm/amd/display: Moves dcn30_set_mcif_arb_params to FPU folder
  drm/amd/display: Add FPU file for functions shared across ASICs
  drm/amd/display: Move calculate_wm_and_dlg to FPU folder
  drm/amd/display: Move patch bounding box to FPU folder
  drm/amd/display: Move bounding box functions to FPU folder
  drm/amd/display: Drop float flages from DCN30 files

 drivers/gpu/drm/amd/display/dc/Makefile       |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 106 +--
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   8 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |  30 -
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 683 +---------------
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |  20 -
 .../amd/display/dc/dcn301/dcn301_resource.c   |  10 +-
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |  25 -
 .../amd/display/dc/dcn302/dcn302_resource.c   |  10 +-
 .../drm/amd/display/dc/fpu_operation/Makefile |  58 ++
 .../display/dc/fpu_operation/dcn3x_commons.c  | 743 ++++++++++++++++++
 .../display/dc/fpu_operation/dcn3x_commons.h  |  44 ++
 .../display/dc/fpu_operation/fpu_commons.c    | 145 ++++
 .../display/dc/fpu_operation/fpu_commons.h    |  37 +
 15 files changed, 1051 insertions(+), 871 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.h

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
