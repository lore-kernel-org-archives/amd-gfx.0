Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30E9C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC5764F4C
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC5764F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F09D6EA50;
	Thu,  4 Mar 2021 17:41:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6890A6EA53
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 17:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeOiqjGG5DTnllok4Mo57nMMQRic57roVJ+VzZ3FQNIJQEvMGYEccMWoDFB8UujbuN9EdIGMAtaWvNeisow+h/Sm9uNSDgRJLPvnUe9WptaWzErZrl2anqR+sIt7RuJ66Gf7hFXkF634VKUZria3djikHWWJD9nXDH4HW9wST/Wg5dof7kO+bNdzl7w+in5IVfT8vO3woEsPr3FcSgppAUdrW4LypfGCRi9VVqqKMg+/feoacZiUUAZ/BNLWu6i02NMJINvaUYzCgb/6n79SvCIBhKhgFtcRx+4gRS8vh4eCwUmfQtO7PHqynRVpNfd6MPlR1C/dYI1LBgNBTlykMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ4/QuGdZMIDMR6WPCL4R1CFa+VN7kUO2yUDJfI4CfQ=;
 b=QEXyYSppyOvpqVeURJfEaqpUy59YNWGEpLdS7aV3FRTmv5uUVji7QPCi/HfplHPe4Zc7Fcyn/YXwfE1qKYqz8Othwr4yGZQ1TPAZWj8DiivKYjYanwoAn5xlqpW2X8X2BRIn6mDivTVAWAI7TRaDtnr2lPyFa5sVQA45JgXwYAemx7TGU/AUQX3AsNEN6QpRUMIyiPrpj+3qpPTfRPsLNBKl9tjYh3ssCDpAoUjN4KCVVnBSnKz95hHQmFoB72Es9FhbbU1dlQpX8JJzDwD/wm9PXrVKrIKeBuq4ObzF1XJ06mDruRcJCATlaXJKPrp5FDKWxhBmI09Yp9RLmgTRzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ4/QuGdZMIDMR6WPCL4R1CFa+VN7kUO2yUDJfI4CfQ=;
 b=fTJRXQT7XkZ9bxCF5lyqIVJjUq1Xj5McKquJPmPG4A4W3pejXQEdD7zNEo3TIm3YM7PkWbi7802KwbAOJWXWRbib34q36mPkU6x0hx2B4XRf50OTzUkasn5I0uMyRyvFCJbKj3Lyd/PHpi8va4XLiDXZ48HeYlJGfSnKVPR6AAw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MW2PR12MB2490.namprd12.prod.outlook.com (2603:10b6:907:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 17:41:21 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::e0fc:4c91:e080:7b]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::e0fc:4c91:e080:7b%3]) with mapi id 15.20.3890.030; Thu, 4 Mar 2021
 17:41:20 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, tiwai@suse.de, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, nicholas.kazlauskas@amd.com
Subject: [PATCH 0/4] Backlight fixes
Date: Thu,  4 Mar 2021 12:40:59 -0500
Message-Id: <20210304174103.202272-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:208:236::18) To MW3PR12MB4491.namprd12.prod.outlook.com
 (2603:10b6:303:5c::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:208:236::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Thu, 4 Mar 2021 17:41:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1cfd8a0-b4e3-49cb-baf5-08d8df34b8de
X-MS-TrafficTypeDiagnostic: MW2PR12MB2490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24901EA4DE93041285BE32ABF7979@MW2PR12MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GoA7njDo2UAJjLZr914hiqb8OpOoYPuek1Zd+VY0ah9/zhLh5WjuqA0VwX1KEp2JRGsR0Zb4tlBwviem4bbFVqS7h1GBDvFU+lKt20GFponXCu2vv7wpmJEtc+YCFpL04x71JURakxi+yIPPQnLcl5KUhjL1bPWG6MrLRHxVoobMZGFI9N2u5jtP45fyEGPHPbdR3TsNilLcPgzWggdr8ERwpS8sUmnpIEMYHj2A2s8lkD1vLOnel7MGPE6Ly9wynnR5Ob+1eLf6+xmXYnm5yR59mTOdLyort7jEb7Nc0glVN0cboiIlPDeTjM/Mj3wTeMyoeoPNbFgG/FjH++o1HykWWqlihpI+Leme9P0LSiMoslD324Qnz7X4kQkMPbkZvms1eVTXmoijXEfLa8rRrXqt++x8WYHGAxlBk4ZAbKJII0C7YSM3+3Cf35es8GUKb1JhMKHD7dNgl7w/5IjXCkjsInHwbAU6DugTqujsRScHI69aWGYiqRlG0q97gRKOhcsXbUJuQMw8k5U/l6eea4FZpIPJm9LnRdsy1/NkHEJqhIJY4XN8MK+axKYiNObNDdeW12Kw5pLg0kKRxHtMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(69590400012)(186003)(26005)(316002)(4326008)(5660300002)(1076003)(66476007)(66556008)(6636002)(66946007)(52116002)(6506007)(8676002)(8936002)(83380400001)(478600001)(16526019)(6666004)(2616005)(956004)(6486002)(36756003)(6512007)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YoD/XUNy2CXJyRLXmz9Gqef10Eg34Tlwhw6A+FYuFwslANVZu8lWKZzUr2sH?=
 =?us-ascii?Q?hUhpRCDSt4UGswR5M03tgMIjPuxFY3SqkJkPLT/DvdlBGegR7Pewic5xoln+?=
 =?us-ascii?Q?cF8IPejOkArHCl8Lg0yWH/SqBHZpu/3QcnjB0j3YDNsyxkx3aHoW5YndAaMw?=
 =?us-ascii?Q?WKQUc+zdhgSui774ss6IL0O/ZruCFIuRM7sNyuIJmdbIkWQQ/rHdIvyDsibL?=
 =?us-ascii?Q?CbwkqC+DTek8w9XnOQWBRkNBNseqX78/hFirDYdeeOqUCPu15SuxmaQHzQVZ?=
 =?us-ascii?Q?FRoAvV6/CYd9KVfHdSh5E0r2aGAbMQnGWo3UQMmjVEeyrCR89FcGpyTKzlS/?=
 =?us-ascii?Q?1+beX3+Yic1RK8SyYGOlIllVfIJRxsP4YRjQIq/fsOP8caqZ4hfdy+QIKNYm?=
 =?us-ascii?Q?UH1zqpAChg/iGwNXi3Ebh3YHQphkz/f36PpcjPUmlf1uQummk4EJJKW16fDv?=
 =?us-ascii?Q?wHDnNgy3Dqk1JSe6+lQGB5aVRfM/gj2lQEXjfUVtc6YMYiH1rRiEdoGn4DpD?=
 =?us-ascii?Q?8Swzgq3JCnnN3LDAKS1xY+Ui6vll9Q0pBqooh9J4D1oj/P3dpUkAnT+2W9Cp?=
 =?us-ascii?Q?xNAnTDEbb52wpWc3N4jv61lxTf40a6hF/nZHFxWv6i0FFIBkOBj0KJvPy7Nj?=
 =?us-ascii?Q?Ux02QmQOiLmyeopUk7dDwJfFb1b5Emvz2s7AVCczYFQp17hBo39r9+5JwUC6?=
 =?us-ascii?Q?8Xo5zn1qjR5Y6PqeQrFNExCrrQNKg+/41uBfC+3AfQRdeY6tTabNCner7m+0?=
 =?us-ascii?Q?80C5hI+KTrx4xrcloqMTyGbGyKWPaizGpCBqpmrtrYa0H8tcuk8iDYgrGOxX?=
 =?us-ascii?Q?Kh/ZdhGtV3LOtsnD7MWsEzFQgsxutTp0xlNJXwiaNWosDTCzW8QmL7QgwpUM?=
 =?us-ascii?Q?JorAiNLZ8vI/EBi+ktiQ7P+VKTjbBrAbenlA8XujmBeOCnTPxXU/DT//PJqH?=
 =?us-ascii?Q?NW0swyhCMFbd34GIvIpUQ6Rf1QhfEfgsn2+/XTBUYD1Zq/tL9o0TWmKi9PFq?=
 =?us-ascii?Q?66kf2J+tY4ZxLOrxxvSGjjvqC6tzUEmzggGtg7u8opox1NWmptzMNIzgp40O?=
 =?us-ascii?Q?CBXV2hjcFSvOnwjIvA0QVTW7600aoWn32nFnDumnE856+krZkdRhffz+P3BH?=
 =?us-ascii?Q?6uoZsUyY5NHBA/kx3SVKE0oXliUibd8YEwKcXE9VstQSFFlhz5rmIB+hx9dO?=
 =?us-ascii?Q?Vj+IYkb7Y9D74xrQWjtqMXt8XrZsWHmDxYWr1RZnBNyid+HeTF7zKl/hFbrn?=
 =?us-ascii?Q?GB2KQWNcxrAJMq3EO93uqV68GKqNIpLn7+npUIDLlELwlvvRxSDFyjSjjydB?=
 =?us-ascii?Q?HXnE6aJgaMvPBEGAi501HONe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cfd8a0-b4e3-49cb-baf5-08d8df34b8de
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 17:41:20.8909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HD2qnHViAVmFqUrclTKBQq/ybc1L4g+q5c9W73ooI4aczsytAspEUYKv4JNicXfAm2jVU3Sx0M3yQtzGCb5dJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2490
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This builds on the debugging and patches that Takashi did on the
bugs referenced in the patches.  It seems some latops claim to support
aux backlight control, but actually use the old pwm controller.

The code also currently warns in the backlight control function
if there is no pipe assigned, but this is a common case if the
display happens to be off when the backlight level is changed
and it just spams the logs, so remove it.

This set wires up the aux controller to the backlight control,
cleans up the code an bit, removes the assert, and adds an option
to override the backlight type.

@Display team, can you check if there are any quirks or differences
in the backlight control detection on windows?  Presumably this
is properly detected there. The systems in question claim to support
aux backlight control in their DPCDs, but that doesn't seem to work.

Alex Deucher (3):
  drm/amdgpu/display: simplify backlight setting
  drm/amdgpu/display: don't assert in set backlight function
  drm/amdgpu/display: handle aux backlight in backlight_get_brightness

Takashi Iwai (1):
  drm/amd/display: Add a backlight module option

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  4 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 49 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  1 -
 4 files changed, 34 insertions(+), 21 deletions(-)

-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
