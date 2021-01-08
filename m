Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EFFC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C8323A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C8323A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1BFB6E8E3;
	Fri,  8 Jan 2021 21:50:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB3A16E8D2
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCBYFhMqLVsNkUYTwU1vPk71Jc4yO1kVzdUcIbtIcKBgzYueJ1mHx8B/ujiUeBRPIFu5Piy6M31zNz4TS/cUY6IjJGZfBL/f0oLQdT2PV1Dxx99i3Ji3GLyombiQokgpQPwOTRnJMkmVroE7eg/rSq9+0e0RWiIBYiUymsGEs5dutafViQujZ8Th9slVFKKkk9q7i9wagrWHFYeSdH+/zmm6gsGC8HC3kvuaf64p1mPEg+siJ2RZ+/UOVQkkMkERUuajPGViNPeKSZgbih7a5ANm7mgj86vJpqBAyfk3g7g/NWmuAr2T0OU3J7rxpKQBn0EslaSe4S7tdwE+on96/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B787f6lx/QFnkRQpltXAQdbBAHHawEbvjGq2mgDUSwo=;
 b=durD3L9QjHLZbVzJfmvIWgbvRi3i2wQO8MViXCysMj4ydkhrsfZ3ohyFtLPgKvUrynUwwGOHxETgBBtE8crIlqNosy9T1Cte161oHTVHKz+aSbrJW0eVkrcVsKjWswL3diumk7perfR2EySQUwMQsFh1YZp4fWd5p7BgifSeX4b2Ew3aRjZWCi+WwSpAITJeKQUVhBxEJm3Qm7HzJQdMVVTULNdxC1jAeU3zkPKJyXNhaKj8z4Q9ElDexJMGehfKTybIGIeiN1kAHl0Xl/tPVE+9fBI7BPdCYVU0srnXxfiX+Nm2WuPJ4jFORb5FTaEiWfArWQOMXIshC2yJN3T8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B787f6lx/QFnkRQpltXAQdbBAHHawEbvjGq2mgDUSwo=;
 b=I5Xj1BCdysLhe3gwAoAWaQlOuztWIpSwk2gBefJoYwIeCDYKSnX5HwEgMiT4ao1Kkmk46ToBgXYQ9K8lqEZmEFo/zlxW0gJTwXIo92zp+DrtUM8/m813ccgPuaerBQXlFUvDcZfw8yHIdi0PGEcjm2V55i30dNnNQpwnB8F1Wxw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:29 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:29 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/21] DC Patches January 08, 2021
Date: Fri,  8 Jan 2021 16:49:46 -0500
Message-Id: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2b1e3a6-186f-4b62-7897-08d8b41f6a70
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882EBAAB4D602D090D5C79298AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y50zt7X7ppDLE8vVq/e4yQVdalNjrheBdP6i3WbUFfv4DQRelrnTz8qJ8TO3VUvzdq6lg6Qtv/xwKejjfFNkIO12BVCvDVC4mMx02WPKYosB5Jngz6wfXXhGEPg1ObGWh5B4tXRUPsFSkxbnYbCLXOWdOU4mko2CdwuR1jAq1ki1QvY6HJzCV2oITqCrOKHEoinIngmeMjrpRUBKZ07KoVPY8jIi3fAEfSg+tfMaB1RpFgZz9CwzMWQF9dWbUbdpMKzK/LSJT1ATfd5Vy5F896oviA5hpIrn6IjXPIasmFeeRPVCsQGHvY8bgXzjTWx7tW4e6rKIM8EokqQhjpwoD0doxPifQDaee1MlaOtShIsRFYHZCWiSRzYytxRYepG8A3zxpPs4pgtvsa+yG/TrIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nTzWsXSIYCh2WRCOpZdU1fY1A/eqDPd0mkr4XE5wcc1FiMpzqanH7OuUvb+e?=
 =?us-ascii?Q?CMtV310m8LAEOLDV+ip7zFgZfcpDy6jAtBD0qNYZuQwn2v2BCP6FGuozlfJ5?=
 =?us-ascii?Q?ZzW2MLX/8tQZezx5VnsX1SVhXCjGAgklheLBOy0+pmx94Bi6G2I3nL8JtNBD?=
 =?us-ascii?Q?KcvM6pUd6u9gh2z+AhakT+VPLDBxzpkvByGH3IdGOOi60N8ITnruNuz4JhDJ?=
 =?us-ascii?Q?bjoiAKaUXLtyAmXkEGyBMRFGPJ7gpVCYb8+Onxzv0UFNwe0hfw/lpbMhYYvC?=
 =?us-ascii?Q?vUKn+r6yWd3vNOaoJjtSPjpHeEaqRiAzwINK8L0Cg53qfkzB3eBOPP9ETZbb?=
 =?us-ascii?Q?f8lZM329/Ic9mUk5RSvzkRg6QxcePRLH0J2Dv0r5eCAvD9c1uJlF9D4CRBVn?=
 =?us-ascii?Q?cysGjL6d6iLV0lSZgJu5eppJWifdC/HP/AxUC+SQs6RnwkoJQpM+NTtXjr5J?=
 =?us-ascii?Q?+3DYZ1mtVwynWCQOWu0775nslAKPJqSXehcimnAT4eVfCmDAjQIcwFGEDjDW?=
 =?us-ascii?Q?te4BoLTVkFahPuLE7d++xW9GUuros7L0Dh3P0Vggn0T1fKjnhwZhvYpPTeGv?=
 =?us-ascii?Q?D00yCKv+JQ8v8Hys/lygy/AtrCyk0wsJ/m5dznuyBm57zBfnxEbTmPJmxu9p?=
 =?us-ascii?Q?eSUCUCTPq9aC/H85rs1pKrN6N6m0gzjApuxNBng19pYn8gxkCPEFUOlk97ij?=
 =?us-ascii?Q?nCh5FJu9lBE4NmJ8bIUNGC60zXtdZhhHws3LS+oKoWcYVhVtn20zeNUasCt1?=
 =?us-ascii?Q?b+galu+JQj+N2H4k2FeDIHo3D+GV8ilg+3n1y37y5uU0LBDyxmDU5uqudp01?=
 =?us-ascii?Q?km2K4PBSXWLm7CPv9/x7j+qliUduMw8d/Eibl72sxksC4RYP1SaRkYA6QsMP?=
 =?us-ascii?Q?nel4tVzmX5HtdVzmAri+0jWYTb7auKedyUq2zdiKG/150MkW6r4HXcMM43tW?=
 =?us-ascii?Q?M9zAK4jxJZUqetmv9UV4QvspU5vDk9+2wcH128BZHgFD35asGcE10vyfmbPu?=
 =?us-ascii?Q?ZKWDOYzBPUOFshoYlB/VeaY9F878evp5BAyieB97LoqE64isHioNoqfBl9Vt?=
 =?us-ascii?Q?0wPAOwDf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:29.4297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b1e3a6-186f-4b62-7897-08d8b41f6a70
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yo89hzx0XdCVQ22d7F9N5jZtopb7d2IeYrSX/L4P7XeA0eerJ/x8DyKe/ibqsOVCqIQsfWP/3uQXMGngvEL4WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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

Happy new year, this is the first code promotion of the year; for this
reason, most of the changes are related to fixes.

This DC patchset brings improvements in multiple areas. In summary, we have:
* Multiple fixes and code refactoring.
* Updates on HUBP operations

Best Regards

Aric Cyr (2):
  drm/amd/display: 3.2.117
  drm/amd/display: 3.2.118

Bhawanpreet Lakha (1):
  drm/amd/display: enable HUBP blank behaviour

Charlene Liu (1):
  drm/amd/display: change SMU repsonse timeout to 2s

Chiawen Huang (1):
  drm/amd/display: removed unnecessary check when dpp clock increasing

Jacky Liao (1):
  drm/amd/display: Fix assert being hit with GAMCOR memory shut down

Jun Lei (1):
  drm/amd/display: implement T12 compliance

Lewis Huang (1):
  drm/amd/display: Separate fec debug flag and monitor patch

Li, Roman (1):
  drm/amd/display: disable dcn10 pipe split by default

Mike Hsieh (1):
  drm/amd/display: Remove unused P010 debug flag

Nikola Cornij (1):
  drm/amd/display: Add a missing DCN3.01 API mapping

Qingqing Zhuo (1):
  drm/amd/display: NULL pointer hang

Raymond Yang (1):
  drm/amd/display: fix seamless boot stream adding algorithm

Stylon Wang (1):
  drm/amd/display: Revert patch causing black screen

Wesley Chalmers (6):
  drm/amd/display: Initialize stack variable
  drm/amd/display: HUBP_IN_BLANK for DCN30
  drm/amd/display: Remove HUBP_DISABLE from default
  drm/amd/display: Unblank hubp based on plane visibility
  drm/amd/display: New path for enabling DPG
  drm/amd/display: New sequence for HUBP blank

Yu-ting Shen (1):
  drm/amd/display: doesn't reprogram AMD OUI

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 -
 .../gpu/drm/amd/display/dc/basics/dc_common.c | 20 ++++--
 .../gpu/drm/amd/display/dc/basics/dc_common.h |  4 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  3 +-
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 12 ++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 31 ++++++--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 49 +++++++++----
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 28 +++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  3 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  8 +++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    | 11 +++
 .../display/dc/dce110/dce110_hw_sequencer.c   | 31 ++++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |  2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 ++++++++--
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  5 ++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |  2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 11 +++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  1 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h | 22 ++++--
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 12 +++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_dpp_cm.c   |  7 --
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 70 ++++++++++++++++++-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  4 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  2 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  1 +
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  1 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |  1 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |  2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  5 ++
 38 files changed, 332 insertions(+), 68 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
