Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3F7C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 21:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2996D233FB
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 21:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2996D233FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C053C6E432;
	Thu,  7 Jan 2021 21:23:52 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760044.outbound.protection.outlook.com [40.107.76.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAAA16E432
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 21:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xw59r92LNq4dAHfSYZtc5EXekAOr7D2HsHIuYuLt7JnzPzExKRZuQZLkTDsJdtDhfcGVMwlki9T4C+A22pe9GC9KW1NFYkKRYDMkLZjGaqeXJBA2c2OZSC0CEPXJRnLWEl3j4h9+Gf+70DUiVlu0KtsTv7L18vEdaWhcgCmEmQiQtMXTUo/nMZ+techfi8LGGlBewJCey7g9ZW7L0fssgmJUxxSzo9KPhrJdBCgGmqfuIKBG0JF8HnFBj4O6ABXSMFDQh6CHI24X/24JdBuetpu6Nadc4JkUqtj8wX19v/ZY/fByIaIdcEtVTVMGM1WI6IFN4YEk3wnIiHf/4rHLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3dzn4FHRioaMZMdyyUstrIjfqaUE7saLEgWRm7U3Lw=;
 b=OwJ9dd1eRoAC0KIcV9N+eh0BpFsIE7U8/M+dwZ/YVT0EpMFKmwSZEn1RC866wRK8yApqRzFEEwlWyQ0/lGhjG9MBOWZuu0VkbNtV7BVV6XvjHBRuemyol4MTjgKssXiXKGUoYfCVKJiwNrv29NaqTk7gm0UT6ClrpE+eWwHf7BWvgM90u2xeugdW1Npl1Vo/4FOwhfad0DcxzWuznp/cI13QDkPq5yyV7NgVZgpUmF4DeA9FJIAl5DL7kO8y+YMzAj82kZ6Z5Eb+tRItpeZo0EJK6vsBqE4qeOF463gKsUNfcu39gWwh5HF/Nso0Y9FT11Ec9DCp3xRVTBOPJ83oFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3dzn4FHRioaMZMdyyUstrIjfqaUE7saLEgWRm7U3Lw=;
 b=BjPPHJGuhYu1lpCcdJLJkyDelx83zKP7UudesM5qzksuUlX7T0CMqqwMxQ7YZhjV8vKc2KHsX+ZOjswQqA3eKOQuaa56+4Fp3W0NcjqBFIlK19ilNOOLFwYQ25VLbX0Jw+sQAOkJI3fAae9rldgqejpwYNy5P6fOJzZIB9f5PP8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 21:23:50 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 21:23:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amd/display: Fixed Intermittent blue screen on
 OLED panel"
Date: Thu,  7 Jan 2021 16:23:36 -0500
Message-Id: <20210107212336.170054-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:56e0:6d60:2ddc:b09e:3e2e:10b3]
X-ClientProxiedBy: BN6PR14CA0029.namprd14.prod.outlook.com
 (2603:10b6:404:13f::15) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:2ddc:b09e:3e2e:10b3)
 by BN6PR14CA0029.namprd14.prod.outlook.com (2603:10b6:404:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Thu, 7 Jan 2021 21:23:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 485c4546-1966-4b34-6bd5-08d8b352868a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1242:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1242EE54CF6822B27FE236E898AF0@DM5PR12MB1242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7t9HD2uCQ1lMKBqqblyGjHOUmaj6lhbm6VPqCv1enFSeAUfpW6tfhftsU5PfAdtOflQoQ0n+/hfJeulHu19CzKMmyVZsY/2LMQVHlmqFOlPKdYL2l6vDmeGMJpZ1rPQ0KuTRVBXp8X+9KmEB1rwcDv+BHaDj2obfSROCOOayC9YKbixRZEY5Yr9N6/dPPWuXneeHW3eMnsD20T2D+wEd6zqTKrVKPpW0XzCf9uxmTYYW5ITHxComcJUIgh0T/tqbN94eVHcQNzmBYTjjXRtzOHCoy5gb91IXShRovcsKKa9QtWg0wG/C2vIkNGZwIMHHhL3VZUZqV5C1vhnKdgYHSA8I0689nGRRCQN+A6eXkrlRsldjoLpUtYnwyeVADx930/FJBUR33c9Q9Ba7hIDiWLc37nu1t+wQcHsl86wwnis=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(316002)(36756003)(478600001)(54906003)(2616005)(1076003)(6506007)(66946007)(966005)(5660300002)(8936002)(6916009)(83380400001)(6512007)(86362001)(66476007)(186003)(66556008)(2906002)(8676002)(4326008)(52116002)(6486002)(16526019)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ywNTKWS/h0+vQeKuaAXpwqfMLGteaEwyHxJWAKpiMn4D3VuRxzKZBrdAAC2D?=
 =?us-ascii?Q?ID1NSgplVL+hOEHf5PPO7Z6rSgWdZDqpZlSQjLW0j2eSmWwd/0rTcX2WoGfX?=
 =?us-ascii?Q?73YN/FD9yTFHcWNdL7pHywK4Rfp1rl0g9CN8e5DY9VItLJpFW1xKbbyLiclM?=
 =?us-ascii?Q?MJ+HsKBfe7TblpqHXiwWQDgc78k1iNSQTY5ANCAITTOIcfLuBfSEube4rehQ?=
 =?us-ascii?Q?kQjcL5nKcmi0QN+//98lg5jNWDm1lxBWeCVCcwPWutNc5OQRiEVkqFXZwt5p?=
 =?us-ascii?Q?5BdfxMuD0kOnbSxn0EVYC96un2hW0gZOIL9s5tHD6OkRuCvjFTqHGQ/4K0jn?=
 =?us-ascii?Q?558KGTDoUsPHcgd50yTZsA9p179Ay36inFE4WP6o1HwqE+iCGnrGSdBb+mU7?=
 =?us-ascii?Q?9QKDnrHFiqAL39dxda6u0I4hbjPOuar4I9wohNyeY2SDCyRbvmN/cDFVMFOc?=
 =?us-ascii?Q?SLgt8sTiUnu59GF27XM465RowDNi1gW0dpmiojif6S6aGQpmB7OVE4dn5hMT?=
 =?us-ascii?Q?7PQZssoIIKCbAmUw2zrNdS+G/2fG+PtFrgfJiJaeCfa4RmsruAQYWQTkrjr/?=
 =?us-ascii?Q?kH5ahjzhGUpsLs5NGKCR1KN6pfOTK4A16hFqGnDhwJiJa6OEB5oswwiiYqus?=
 =?us-ascii?Q?//MYqufo2gYZOpVm3n+L6a6eH3yawpFLg9664Ad6mAJ8ZZOp8h3Iig5JWhm0?=
 =?us-ascii?Q?SbnEgcvfd1TxBDLkLYWd0bK1OPyCv8eBLC9yLCsuMFmECZfDibcYa0hVaiOx?=
 =?us-ascii?Q?/PH7jMobJQbdk6JFNwb3aGmjQo0eVp/UDf3iAxD52vVPi2fpghLknLKre+C6?=
 =?us-ascii?Q?lcQZGwttJvwkXNn4b8yw8ScApBaNXBMp0Zn7VtiVJCjv4+4SvZDwygiWt5Dc?=
 =?us-ascii?Q?uFJbfaKZzu3vRJZBt5SVXlN8MPyKGCLeNG2iIKzv1d1EAjzOdclqMZSrLJ3Q?=
 =?us-ascii?Q?jthBqBgVdSmwe+3eKO50s8fRmgfALCIaNZncFNJqpY2zUxEqFd4Q23R7+geP?=
 =?us-ascii?Q?lvhOZP71qIYG5pjfMkFDfcMXyRFbmCZURar5GRWGJ4d6gNhkH3kjSLRLTk2G?=
 =?us-ascii?Q?gQJ4OHjH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 21:23:49.7024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 485c4546-1966-4b34-6bd5-08d8b352868a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKDdIbDrmCNs9BPq7e03yo1zJvYpwyHdREGuYi+lWa8YMdqT7xvg8PWFhF/MWvDaBIJabRpSdxFrzjHPqyQzKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1242
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
Cc: Naveed Ashfaq <Naveed.Ashfaq@amd.com>, Roman Li <roman.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The patch

commit a861736dae64 ("drm/amd/display: Fixed Intermittent blue screen on OLED panel")

causes power regression for many users. It seems that this change causes
the MCLK to get forced high; this creates a regression for many users
since their devices were not able to drop to a low state after this
change. For this reason, this reverts commit
a861736dae644a0d7abbca0c638ae6aad28feeb8.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1407
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Naveed Ashfaq <Naveed.Ashfaq@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Roman Li <roman.li@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dml/dcn20/display_mode_vba_20v2.c  | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 860e72a51534..80170f9721ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -2635,14 +2635,15 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 	}
 
 	if (mode_lib->vba.DRAMClockChangeSupportsVActive &&
-			mode_lib->vba.MinActiveDRAMClockChangeMargin > 60 &&
-			mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] == 0) {
+			mode_lib->vba.MinActiveDRAMClockChangeMargin > 60) {
 		mode_lib->vba.DRAMClockChangeWatermark += 25;
 
 		for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
-			if (mode_lib->vba.DRAMClockChangeWatermark >
-			dml_max(mode_lib->vba.StutterEnterPlusExitWatermark, mode_lib->vba.UrgentWatermark))
-				mode_lib->vba.MinTTUVBlank[k] += 25;
+			if (mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] == 0) {
+				if (mode_lib->vba.DRAMClockChangeWatermark >
+				dml_max(mode_lib->vba.StutterEnterPlusExitWatermark, mode_lib->vba.UrgentWatermark))
+					mode_lib->vba.MinTTUVBlank[k] += 25;
+			}
 		}
 
 		mode_lib->vba.DRAMClockChangeSupport[0][0] = dm_dram_clock_change_vactive;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
