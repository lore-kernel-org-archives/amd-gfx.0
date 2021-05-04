Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09236C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 18:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FEB0613B3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 18:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEB0613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D706EB59;
	Tue,  4 May 2021 18:43:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A5A6EB57
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 18:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALDrTNv8xaih68PY2Thjjf1rQ2EEbgcYpbpGCth1FVc9OWLJcuDfQX7abnujTm690nX/IoqGgSqMcCJF33gOqRFLq5eWwvClFjH2SSA/vOTQQMpJa9FgrG3k+CBfQVEjSFalpA+CnRRqMTMamiLihViArlwQWsauQOez4vZMpxK1kRgSeHhtdDEYHMePgvg4iPYhqq1dI8M15eusaMmCi1c6mX9rnDbhuDcVdGNRMsDSrBaEh5VNK5YgVs9HXNTw8mjlsnUf96CJpXTbqNK1OM5wYjU+MA64uI9nM70JPUy/5oK+htPqOwYpDo1qYqC6ANdju3LQApvbr/qJHfJ9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9REQ82jJyvvbYZEXqsiMlfkMtLGSzuNE3F+7+cwBqI=;
 b=dTBaWQtpJLBFqP3KumX6cW6gxosUfBQsTVlqXtw+AAz1xhSpwAeDtPSrzzroyghwjJ1YpjZcm+A2HoGTbsab8CBmyzt6B0fGhh+SVFg+5Ws7Wq1ZQctfFxNwkJ5Z4h3ycW5hRnRbt93EXFo13cRk1WYvi29lsb/Vu/alBtZRczdg7WoHHOszkd2FD39bvG8dnTeCrzYPhbuq+bIgMz0+ZbIXzS12aovET+sHkdrHdATwhrau+ZEptVMbvtkt7uJi/GFfHj9wp7eUlpbqBXVHct3th7J/XYxSmzv5WabscMOXDbr8I88LSyHxUs2lhou5k4W+ITmyTdhluIxQhdoFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9REQ82jJyvvbYZEXqsiMlfkMtLGSzuNE3F+7+cwBqI=;
 b=WQN6Wl/FCcyUwFLbX15wxbzkGbK5ViRz3y1dz8h/F+h38AZdS1WI++Xphd1oGXRzp1foEiNID2j9sCL5E60xdLdml8Ok9mAqxXIaNkUcP87kP3vtSWXGhl6Jb9LmsFevgpLjQdNA5iNHd99H4mOp+OX2DzC3iKzFUkw70FaumbM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3759.namprd12.prod.outlook.com (2603:10b6:208:163::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Tue, 4 May
 2021 18:42:56 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 18:42:56 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/radeon/si_dpm: Replace one-element array with
 flexible-array in struct SISLANDS_SMC_SWSTATE"
Date: Tue,  4 May 2021 14:42:33 -0400
Message-Id: <20210504184233.2350976-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0390.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::35) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0390.namprd13.prod.outlook.com (2603:10b6:208:2c0::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Tue, 4 May 2021 18:42:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6a1d759-64ec-4485-af07-08d90f2c6e7f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3759:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37591B4F026ABDE3B9DE701BF75A9@MN2PR12MB3759.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTar3/qW0E4990lvNWW6yyM5xroyq6xWcsHb3fTsFIXWKDb47sXbiAS3WI2jTQ910QQnHcv9OeAEFMkW1GsZaLpMzgZcx/hKyyvwPnqzAX7p9Hf4okRzilTFqkKm2H+8JO57+Gd1icpdzURun4FWWwY2dfKwlKZCJRTLYYSTOmWZQ7/6XcRvhPZDPG4RTAMb4+CbcaZG2bxA+QdqEfMNnpalKh3DaItOhQzM1BaBw7kpagwp0I9ebocYbTnGQj0CaepDH3BLvGOIx+p6pyiwq7sj0uxYXTPJAiJl4xVoo61qQEeCR6To7C0O/UpE6ALCLtvDvAxKNaDLVLoEO/EcNQ7ubQ3xgk64kLtMSjWxigjeN1pMSHSrpsoNTpIxg7vBKtvG9o3L22La3xD2tZHoawO1HStqSZTBj8GvvXH6Oyq4JOP/CupVyVUk9n0+nbvXFPBDU6zUsIJLn4I/RYpiJ6dOUU654l5Ge9Qu4Byhb8wyBweHINR7uiNGqR9QQ82j/p/9G6Gm+DsLXT9zheIVI6/4f+5yoX3dSaK+YkZbskrwkSsuz7YeFgnQmk9qpZ56fu6KsShkoOk0sqWbcD2kJwn+wgM4d2hVynyDzV5GIo1RzSPiBvrhDerWhLDNhwLsoWbsHLq835kH4rJ9T4YkiSwhzsAdw5EbFY0chgxlEQZGBc7L6qniW3wXekA+IamYFLbEwHejWSENs4wIBQ6ap2OWkF7I0rAspzQUrH/BYsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39850400004)(346002)(376002)(1076003)(478600001)(956004)(16526019)(5660300002)(4326008)(8676002)(6486002)(66476007)(83380400001)(6916009)(6512007)(66556008)(66946007)(966005)(316002)(36756003)(6506007)(2906002)(86362001)(6666004)(26005)(186003)(52116002)(2616005)(38100700002)(8936002)(54906003)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WaLUimHPHWqxFfCpvwkvo5yjlRqPMEM3a59vixsPXyGg6QQQGFoAnL7fUOCl?=
 =?us-ascii?Q?JlqLp/FEqCxBZ5a3W+RVjm6hEsHz3MOma9S7BKpqkEVogZibaNQmcY9QaQmd?=
 =?us-ascii?Q?L7o9tM5Br95lJfrEvRyUAwB82KzJLyE33Y2am9oecwj1J1aDlDPw0SmWSCFq?=
 =?us-ascii?Q?piVeh7sjFzx5ZD6ff5wI+5lnEIvSGrB5/x+ccLYKBr4T809JCmz04pDWoQvi?=
 =?us-ascii?Q?6lpjZQNyrCHlhtEFrwwQatlBmBvi4+UsyXgVXfYDJYKWSaBhgrzUUsCQv3fc?=
 =?us-ascii?Q?EKjjfhQ6xKX17crnVsuQoIPRXNJmIBOn9XcE7Qi/UaNsSCjqrQkid1XkKvPT?=
 =?us-ascii?Q?Fq5SvoW1uH8aB5sdg197m89ds01AOEjfNqbLFywgdi8DPPsxiriD+U3hl+wH?=
 =?us-ascii?Q?TzG6wcB6uhuba3adFfvVBn+NbFzv23OQdkcsHyuQ5VgarDfUgCYCxjZ21OI1?=
 =?us-ascii?Q?d5Ub8wEJXxgLjdqyx2U1JcUxXqdwRM4MINUCKgeGIJThxKz68XDlCyv2D/y7?=
 =?us-ascii?Q?7p0xY76eTs7pHPtKGgpOYJTsqdZlo3wa3aqZhAlTNOe4G86pmBNoCxOvsfBF?=
 =?us-ascii?Q?0zLNU6yUkdvCnZnQsC/iEpwHVCHXLC2CROtnslihzcgeCYENX5tma6hW7i3D?=
 =?us-ascii?Q?ozweyQ5li8IMi6d+CRVvAC0ACmuU37XGHy9Zi/ZM136rgV9hpTuOzvyoP3lf?=
 =?us-ascii?Q?YdRvAv663DTgQWDfoXkpkLWv9q27oXx0JGBWlN3NzR9f7szW4X5OAOvRl5Na?=
 =?us-ascii?Q?v8+Yrxr+gsqASyFve0Cm2+OMA9JuELdOhMGG+pVDOVz7F240rAAAVf0hpfXw?=
 =?us-ascii?Q?DrqO8+l5QY92WYCmWxKHlQ2a7aM5rcWXVHvnjP3DOYgcd/JNw/pngmK3hUB4?=
 =?us-ascii?Q?Rof5X14rNgul58dT0I/+hkNoomkHIfveE1e6oZtBJI1P3prfL7+s2dbwTptX?=
 =?us-ascii?Q?KBuLkHzun5Oxgnta+2lr4rB00vEAm6eQoqBYI23qv3SS1BF0UlyevI5/v3xM?=
 =?us-ascii?Q?q3CdL8PwOLX2VIULn/TF/wNqTwlg45TkH/Z4jWe+gXy5S5PFqQPFaSpm0YDp?=
 =?us-ascii?Q?HXCLEJKm0+vmTd4PKWfmE05ktufqSpYJIgdUBgnxZ+dk3Q8VLB0BNlxYUSF3?=
 =?us-ascii?Q?X5EtcsjdFDaKKIsEeoq6PSrlyWmM43w1dIID6uFadzML+R/o8sp5xYkFMI8X?=
 =?us-ascii?Q?01Gq3YDhJHSMbLjJewHlgTsws5GbGEDEqV3WD0NbRBPj1WdRqF1XvPd0+dgR?=
 =?us-ascii?Q?5CsdSjXGORitJ2agxeuDp5f4rSOEEjglOEsPxn5IutiiJvuLWY/9/ja7gg9K?=
 =?us-ascii?Q?ZKNg/QmBQC9taKM8rhk3TLXg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a1d759-64ec-4485-af07-08d90f2c6e7f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 18:42:55.8954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otue1iZz9gAB0YfiWT/aK6D+uXXxJHTax5QFRfa3RgNZ1erKeJqiPhSJP4gN41kCtciKlIzDFDU/1ncPBkGdIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
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
 "Gustavo A . R . Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 96e27e8d919e52f30ea6b717e3cb70faa0b102cd.

This causes the SMU to fail to load the power state.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1583
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/radeon/si_dpm.c       |  5 +++--
 drivers/gpu/drm/radeon/sislands_smc.h | 10 +++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 918609551804..91bfc4762767 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -5250,9 +5250,10 @@ static int si_upload_sw_state(struct radeon_device *rdev,
 	int ret;
 	u32 address = si_pi->state_table_start +
 		offsetof(SISLANDS_SMC_STATETABLE, driverState);
+	u32 state_size = sizeof(SISLANDS_SMC_SWSTATE) +
+		((new_state->performance_level_count - 1) *
+		 sizeof(SISLANDS_SMC_HW_PERFORMANCE_LEVEL));
 	SISLANDS_SMC_SWSTATE *smc_state = &si_pi->smc_statetable.driverState;
-	size_t state_size = struct_size(smc_state, levels,
-					new_state->performance_level_count);
 
 	memset(smc_state, 0, state_size);
 
diff --git a/drivers/gpu/drm/radeon/sislands_smc.h b/drivers/gpu/drm/radeon/sislands_smc.h
index fbd6589bdab9..966e3a556011 100644
--- a/drivers/gpu/drm/radeon/sislands_smc.h
+++ b/drivers/gpu/drm/radeon/sislands_smc.h
@@ -182,11 +182,11 @@ typedef struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL SISLANDS_SMC_HW_PERFORMANCE_LEV
 
 struct SISLANDS_SMC_SWSTATE
 {
-	uint8_t                             flags;
-	uint8_t                             levelCount;
-	uint8_t                             padding2;
-	uint8_t                             padding3;
-	SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
+    uint8_t                             flags;
+    uint8_t                             levelCount;
+    uint8_t                             padding2;
+    uint8_t                             padding3;
+    SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[1];
 };
 
 typedef struct SISLANDS_SMC_SWSTATE SISLANDS_SMC_SWSTATE;
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
