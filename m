Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9294DC433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE3461456
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE3461456
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B38D6EE47;
	Fri,  7 May 2021 14:58:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5CD06EE4B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSz9hZyQQN0q3AYW8HDN5hVK0oKHb24+m3Li/6OnAHRWDtSZMsh1NSvAjmVEcr/WxXXkbJOAw8q7gOhlxpRRbKgSXfsE2KhAe7yyiOPR04Wu+HDxWMSThYc5zXX5VQbI859THTtoZvqt3u+BwWohBGMf3EnHdfzJtf4C64K9pPXA27ZSP0Ki7hAkO1bbp6Dl9Ti+W9HSk5oj8Vu/iWOel2e6mwwHfXeR1FayoxJphE9U8/NDHFYDQtTM34rrF1/4CV4Bajkl6Ui4r42tnYGI12xRFcM3pGCFXLJsbrQe9Iyz3rE6V9ZVUpFHitjp837PAIkJGSldpMgSnywES6Jw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dQ5kZF15qPk/h/qnT3SAzCAVx+ij5hNjesktZQXI4E=;
 b=dBdjnvH7XhDdzdUEpYg5eiOSoBAzLkwv2O7UedNKTNDhwa6dNQWFH32R1LuKuGevRdljyvkdBxJXMOYxfRjduzbPFoNKnR/aTOx938Fw5GX6jFP/85dDptkALnSKqzsJSTxrmBnmEeJwW99ZvWSFM0AeMUfRvL9tZ34feImI63crXkTHzcC+3GOx2o1knKl6jPeiExyYw6cJ/CwltbFbmx0XayXJeKwvozt88KcMsk4iKwgFKpPJu+boYSTSkNBPpdRTDADA09bVL/8ltdpHy4Mg0Jbb90m8Z2niAlRrDd/ocfJf+rAu8YdxHxK4jtKJRV6E+o0wZOMyv2VJXrk5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dQ5kZF15qPk/h/qnT3SAzCAVx+ij5hNjesktZQXI4E=;
 b=KYwYjj25dQ5uH7di/2bNZT3pjh+zJpnYxA2py1UJx5UNSIOmRXGLciuRM2qE99NnQgsNXnKdh6HFCLGExz5kFNkU4F3NbzxVt96gi+7lqcgEcwipZcP/jHkdPjUYMMajp1Tgsp/T6cehtUT3ojkQL9NmOgC+2C4IxXeVQxKtoJc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 14:58:53 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 14:58:53 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/14] DC Patches May 10, 2021
Date: Fri,  7 May 2021 22:58:08 +0800
Message-Id: <20210507145822.248029-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR04CA0045.apcprd04.prod.outlook.com (2603:1096:202:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 14:58:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 786d10eb-0c97-48e9-8bdf-08d91168a155
X-MS-TrafficTypeDiagnostic: DM5PR12MB1786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1786C513E34D2CB443DC947AFF579@DM5PR12MB1786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAU0+N1c7jgKK5XbWr328/o7aGSpJJxr6T2m0S3oCwqzS9IjoVkhn53TYJTb3zabRG3fzBfbQ+PeTxzTtZA1AhdHRF3cl7xmcNaJYmgScb5ULtQJky+yPie7oB+wK/J1klKueNSSgO4XRZScLEF4EHkZGZQtqViDHC+3sN3nyHH53weGpRRupf+n0lbaxM6u03yND6kBB/C8x20S/BfyFAdrVOQOYR/3STHVq9xS+b+07hojP9bV6bVPURlsd9MqB78LSImlCzL9mHFX8uE/f+Hv+K7MqbMb5KUEEZwR+vZL7x1e+PGV3GJiIeYR2dgeB3NNJqPq5xerMB7vXNY4x1dnOpNiMINOsrs0rBbP+vSJ1Eb6CIoMt28bCDXCoJeAoBgr3wyQTfJcSggPHTkmNd6X7Qbcv8auuZrGZOX+4Gova0fzMS6NqPNz372hPgGAbsjItwxCw+l5zDD5LkILOgT+LvSD2J+6+jqs+dtOdFePhkjIl2ii4TY8KfCs+7qDd1sFh5TcVT6gACboMOHX/0WkHng7wkfn/llKNGtwYsT3piJBaaX6qyyQwRMTwBGkI2UwORtZGS73InGCOOUtYZWVg0Wpua/vDc0MLkqCVuGpLu5mLMD1G98Vrp5ggJh/cX5wB5TNTuVEh5nmLHTLNbDrJGW929rJhIqzdwMifdc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66556008)(66476007)(66946007)(6486002)(83380400001)(26005)(6666004)(16526019)(86362001)(956004)(38350700002)(38100700002)(316002)(4326008)(186003)(478600001)(2906002)(6916009)(5660300002)(52116002)(7696005)(8936002)(1076003)(8676002)(36756003)(2616005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tgLtJZ0cLDlXpb97hdout4YOjx7wsFfoD3AdLzyogOYCY8bIr99NEqgznANI?=
 =?us-ascii?Q?MEUzf1oFg79hE7zUq/s2rIvltV03Od2+aB3/FhZHt4Ht/1yqtY1S6T0vXUyb?=
 =?us-ascii?Q?YGbohUzeGXkZAt3TW+TrD+4gv5CbD/7tRgJBlvEg77J5QTpg4s2mrYD5ZHJy?=
 =?us-ascii?Q?cgcUI3tc9EvSf4TLJYsHdgjpjtEs1xIBmR4zwG/jWPFwkHD5PXFl+swpSft1?=
 =?us-ascii?Q?Vjo8oOqmVT0YREHfUNTeI5Q4q40u9wW8JRCaWuoXDMGVnjsn88KX9xwIciPQ?=
 =?us-ascii?Q?KmI0SFPAyLpb72C9xVK4zXKjUVJjpIwegdksfNf78SUnZUWKaWgjStWjLSR2?=
 =?us-ascii?Q?AS2BBLRCnpmDH8L5xJDJsHU7lXO0iFmltyrXTR2nDRHNNYBc6TYGUCl6l/Pc?=
 =?us-ascii?Q?ajFPFKXw/wJx9IdlJxZAQGs5b9shp7zNB8w5OXAw2OYJFHcEmsQqWblK0cDc?=
 =?us-ascii?Q?XxeTJa5KGPV3V/gG6UUxeIQ5aLcnsuR6owSyqy+VrrS1IkiKDjQgTH29CMHS?=
 =?us-ascii?Q?LBG2rD4lw9L303hKyAOdvyTP7/nk3opwyqb9ARy254GnWXLepP8my8rIG124?=
 =?us-ascii?Q?RfWvucuwgS4G2mImc18U8aemKeXx4xhd1gR3qm/+HsZFH8mBivjVj5aBUfEc?=
 =?us-ascii?Q?APhZedLBZujKbDRdVn5AL9crAu1wD+4OiX2jpAJKBfvzhIj0fpAPBz6FyAL7?=
 =?us-ascii?Q?L01uQ+Q5c998cHSSiDpIDQh1icWJmxyiZvj1bd1d3vmUUDkKZUDXo+Dz9lq1?=
 =?us-ascii?Q?6ZnmOevqmsQBOFbHj3ZyuqXIuVqOp7YSQ7i81xSMgq9mKY2Vk4u8exXmJItO?=
 =?us-ascii?Q?hgmwq0z76ReeNsef0hCZysiilpQgH/OA+NntRluyCNEvILGiLEGMNdVZYIcD?=
 =?us-ascii?Q?nU1Xbid2VhtWvWnkwrx3/ZHUXBOq5RUouhPwmOttKbYwVTW/+KrMJvpk0hdw?=
 =?us-ascii?Q?XdErDa69pZ5XA7P4/s5L8Zs1m1EpZR2c9anEs4GZltb8svUvx2BxZLDmkyrN?=
 =?us-ascii?Q?srvZgRx9o35d7GoxApTPZF0oxts65BFQvnHwBUgKXAvGRgfL1A2e5sTq76Ar?=
 =?us-ascii?Q?iod5K9tEZVt6AT4syzPpSqFyu6g6Q6I9/WWt4XpYt9tJHJVsM8y3+Yw01bt5?=
 =?us-ascii?Q?yPWAg6TTtPkmL/W7moWh1XGI6/0NtYjbl1rXPykvmae1lIsFGeFMSZfk7DUt?=
 =?us-ascii?Q?PzHCHmBfmK7xh9LdFSOu8GnulIcM9sH3tpb3agjrg3qS6gH0pPalelgV3zFF?=
 =?us-ascii?Q?bDdUSG/gnpur7pAXF40nhXxuhuvEbFwKpn5VWmYh/vXDxha31+uT0F7P+JRu?=
 =?us-ascii?Q?6YWlnk0s0yw2AfMWICg40mMJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786d10eb-0c97-48e9-8bdf-08d91168a155
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:58:53.3033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQtVNGeEl76OWfwJe+LLoGppTvgR5/T6vIBIsKQOEbghHhFKUz6C7ijnHHMlPMLNuzTO+BaNzvuL8gKNmMv6Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* DC v3.2.135.1
* Improvements across DP, DPP, clock management, pixel formats

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.65

Anthony Wang (1):
  drm/amd/display: Handle potential dpp_inst mismatch with pipe_idx

Aric Cyr (2):
  drm/amd/display: 3.2.135
  drm/amd/display: 3.2.135.1

Chaitanya Dhere (1):
  drm/amd/display: DETBufferSizeInKbyte variable type modifications

Dmytro Laktyushkin (1):
  drm/amd/display: fix use_max_lb flag for 420 pixel formats

Fangzhi Zuo (1):
  drm/amd/display: Add dc log for DP SST DSC enable/disable

Ilya Bakoulin (2):
  drm/amd/display: Fix clock table filling logic
  drm/amd/display: Handle pixel format test request

Jimmy Kizito (4):
  drm/amd/display: Update DPRX detection.
  drm/amd/display: Update setting of DP training parameters.
  drm/amd/display: Add fallback and abort paths for DP link training.
  drm/amd/display: Expand DP module training API.

Wenjing Liu (1):
  drm/amd/display: minor dp link training refactor

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  86 ++++---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  49 +++-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   4 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 211 ++++++++++++------
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  22 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |   3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   7 +-
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |   9 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  33 ++-
 .../dc/dml/dcn20/display_mode_vba_20.c        |  26 +--
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  26 +--
 .../dc/dml/dcn21/display_mode_vba_21.c        |  58 ++---
 .../dc/dml/dcn30/display_mode_vba_30.c        |  48 ++--
 .../drm/amd/display/dc/dml/display_mode_vba.c |   2 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |  14 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  10 +-
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |   7 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 123 +++++++++-
 .../amd/display/include/link_service_types.h  |   8 +
 22 files changed, 525 insertions(+), 230 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
