Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C262C433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 13:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FF361186
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 13:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FF361186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C0766E8B5;
	Mon,  3 May 2021 13:47:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758896E8B5
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 13:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F572uIlTyXjUYortWmYWotuJ4hQFmya2f+3WegCnwPbpVtwosqooDpolNJfY+YAqtuWNozq5UCOlus0/4L/xVGhtVWzkBWdfNW3dR1RaOwakjxDWD4CHTrwpOtOVFXPB0a0hoEuZeTdLlEPS+z6/LGYqE3+yWvMfkqbJMhm6bEbsqzF9Hs71feyvwNqH6p9SrBtz8ygPybhupJRj6giTDiwxT1I1EEBNSGUWzT6LCMQLeFfjmoQtwRPetAzUQTPRCFq21D5rtZeOZVZaBfasoVU0rWska2mNSiZQI/Xgt0qWxBM5+eaDK8fYq7xlkyWUHGCp7UBtvwLmOTMLem/Zxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDijDoa7xpEpDI5+lvTUe9uEhRV2qsLM1HDX5wk9QU4=;
 b=GW8mP91TCf0t5NJpN4+R2JN8+56uTw1xp/KWLo20Tv/BBIQaZziKsH+JuxHzRkz4+hiVMwjWNL4Dx6MzMi9f1MvsHV2gEtV+Hk6SWevJ349lyrCwmt7dYtVwbmrPWwyaC/x6to8apCHE8T2i+XKFg0o4t5sFiWTQIpWoCctOJYB+hJMTODRzoktvP/oVKy/AGgUNEYR5gqCoMOLi0tQqDibO8QxEKPVRd2/vU/TxOfpOUr1VHibuqxijyeZNf50XX4QloVdahm+I36tToupOKWY0W+WwFsuiWd0v3UbgzagAo/bjunkAuznid6d0R5WBL9KCthAZ2DgvTFb5Nav3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDijDoa7xpEpDI5+lvTUe9uEhRV2qsLM1HDX5wk9QU4=;
 b=Q4OoR6olD2YH8JJ2PAMsIm7TY/uEz4hHGFHAW/7kDXryYmOXG3VusihT1FvvH6XxbkXWXKQl83KxSrIf0BIZh3x7R16T8UV+q/9gDzTHPvxdteAfFYaZqGJz/yGfwpOvczaFYLBtg2MmuroioGqaQSSETeen7kLuE9/5k455gLY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39; Mon, 3 May
 2021 13:47:54 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 13:47:54 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] MAINTAINERS: fix a few more amdgpu tree links
Date: Mon,  3 May 2021 09:47:36 -0400
Message-Id: <20210503134736.1467003-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503134736.1467003-1-alexander.deucher@amd.com>
References: <20210503134736.1467003-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL0PR02CA0126.namprd02.prod.outlook.com
 (2603:10b6:208:35::31) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL0PR02CA0126.namprd02.prod.outlook.com (2603:10b6:208:35::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 13:47:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15b4c375-8dfe-4e9c-93e1-08d90e3a0cfd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42886E31091C624295D77FF2F75B9@MN2PR12MB4288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/tSsxsIIQ1ejxHu7Gq1W/BMdSqVuZ0nhn1K4xIluEUJG8OPNqCNgH22PBs30xDgFecgpUyEXLG7nnTLR8TAzB+Fb1kZeX33YBN3B2nGQxkyyM730yBD7nM2+b85F/l+O/bBgpOYLZg4o1/EN/RZFOOu40nzlA7nl69vStHDwbiAYqUVWkJYfUJCFzGscXfBlze98i/OFCmrvvRMGHVhn7SgxJp3ojzhDfKAzhdXGi5GXgUqyTJQKkaZdbhMikTaxX/T9qt7N67QFzWcYriGEEfEfKosXrs9iDY7krN0pojHVlr/8J8jZlwtrjKU8iGRKxVc6kibGVXSnw+QEsdreQznmq4JAmyx6C3Ok9fUXCQM2jsDL5OA5aA28m1ScT1zUIbhMaUQ1sfxJ3+QBlBWQxNubdEdfEPGTar+OH9mPjwDfsNe95wX3iJC5O/wC8h56YAH++aj44SOckd/lua2KxGqDsAxsJGHj+VESqt4j/ccQBIy9Lvixr+mch2flQzZbOFhVooKWsSXrq7U9px9OPHwaEy/9V5eRC2LGFvYmtbHLTzGJA5YrP8PIZBe6XIuqdbbu7/2rLm+h88sFpm9z22bLVWmLzpzSGzfIcN/o/ZPd23+9SO9CH3V1De1UfVHgW9LruS1WhHp3Z63CL+g47dDLYgst76xPv9FQfbHkT6gHQ6JwMu+qxDWA+V5om/qa8MUOVPYZfyvg/urdAWYBfkYaaDgp9bJ/3McKIPIZwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(6506007)(5660300002)(4326008)(6666004)(6486002)(52116002)(38100700002)(2616005)(86362001)(956004)(478600001)(8936002)(4744005)(6916009)(966005)(186003)(38350700002)(54906003)(1076003)(8676002)(316002)(66946007)(36756003)(2906002)(66556008)(66476007)(26005)(83380400001)(16526019)(6512007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?68VO63JHJTA/zjK2C+AT/WJiqXzSNELEdYkzfFFQlIan9FxqLIkc5cHyS4ca?=
 =?us-ascii?Q?BN0U3qleIO7z7BIxGco0BipQPpc2eFQ1He5t2pmbJtwTjfMjEqBr8XTFOt7K?=
 =?us-ascii?Q?R9PEKXSGxN38DF3esaI6+hTRRVr5Sc+JA36rUgFlM1dgOQQ0NVCQALO5DWBc?=
 =?us-ascii?Q?MvkEL95BuTY5+9rmjpnKMuALkeptk8P3FVb9f3AwcsCC5w4/K7MpyYTS5Thj?=
 =?us-ascii?Q?nVIB8bhkJgEvxUH0/wPvpQ8ZSOtdvB2Iop5kOkkIRGfZ9dhAdF2Cb1EtLBLt?=
 =?us-ascii?Q?+tZfc6VQA3OnBkCgavlMwmxZ9Tq2pmJC3liJdHG5RfJ9RdTNE/QbvtPtVxeT?=
 =?us-ascii?Q?JhcJR2I4MCQhFZWE8LTGbPGP0tGM2/KFqWSkJMpwpzgwU46Lz9VkYl5o83uo?=
 =?us-ascii?Q?lnjZHMi3iydoQunkZt8vGaCeh0zqHaytLUGMX/G0Ik3APfvgegtTz129Oyc+?=
 =?us-ascii?Q?R/2IoU+zKcGCW+bLpGkEwSxiqJnx31eUoUXz8qX1oC292qat425wq6rRovG+?=
 =?us-ascii?Q?WjTKa4jR58pQMzEB061HLocpwd79GZg6HlruAt7MOZbKJ7CepfuUp1i1wOgz?=
 =?us-ascii?Q?o1icY4DTyL9SjJvT4dkPF7R6sDbXfrlep9GVVcOpBQASGUf/71pU51gM9m6K?=
 =?us-ascii?Q?N4itmea6xaYvCzJWrFulTnUFuNTvvvfsA7LiTi6sWar5bIXC2qzAo3cUVpkO?=
 =?us-ascii?Q?5TGnqu/eDyPTjjBRPZHFcvpaZ/39dbB0xGTx8+iskUuvLrhGVv8xGbyPup4X?=
 =?us-ascii?Q?CaBbYQFTLHQQu7tHyFtJdyA05IO4JVtfitiUcTl+MV0yG0K73NL05/9cw1Q9?=
 =?us-ascii?Q?blV9TO8NloKaJv8b26DVvbR3NVoGFebMEEUXQe4Uc8PcGzEKJjmYuPeTxOuH?=
 =?us-ascii?Q?uS67vj+ewSo2fqtTSrxcjsV6qOi3JHcmdSMbDdcMX6uxTtrDFQ46AFI5FDfn?=
 =?us-ascii?Q?Wa7dBYHdVUzSVW+fHEBG3TN0xEVzy4iz3fKZOXaqOLs+M/hzlrxz+PlDLt1b?=
 =?us-ascii?Q?p4QMryA9HUYNPk7W1iIyIcVRMtht8Dt5R1YIJqaEFDGNJfwpiBCnJ3Q3ikm5?=
 =?us-ascii?Q?LUKlLPyx+KKPTFCV2A9j0Ibc3+oHj8jBodufw7nN6dPJVn8chC2kXY4cHoRx?=
 =?us-ascii?Q?xe+YO9UfC0/iDX+991iWGO0Lg0NppvfAIAB01q3JUdFMGw4WlW3XYC7tOO5q?=
 =?us-ascii?Q?EWr8W/PV9PZ85qFtZmptFD9hezsh8gEbkyII5ehSdI6lH8Yq6Nucqrd9CL5+?=
 =?us-ascii?Q?7/3bWl/g5vrXhMo4K3yG8Fhg1U3IJlINruYDDvNyrInpyxyLKPFZSkh1m7Hx?=
 =?us-ascii?Q?NlUXUwXzK3+FXlxfl7QstHc5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b4c375-8dfe-4e9c-93e1-08d90e3a0cfd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 13:47:54.2634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IVnMIbumGS2uAmhOY+Y50rY2Yz5QsKCU2zb+ZPwYtd/iEncPi9NBBkBVBaDhcnghOlfsxc8+cZ5z28C77U2+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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
 David Ward <david.ward@gatech.edu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Switch to gitlab.

Fixes: 101c2fae5108d7 ("MAINTAINERS: update radeon/amdgpu/amdkfd git trees")
Cc: David Ward <david.ward@gatech.edu>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ee2a659867..3ea29032e5dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -867,7 +867,7 @@ M:	Harry Wentland <harry.wentland@amd.com>
 M:	Leo Li <sunpeng.li@amd.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
-T:	git git://people.freedesktop.org/~agd5f/linux
+T:	git https://gitlab.freedesktop.org/agd5f/linux.git
 F:	drivers/gpu/drm/amd/display/
 
 AMD ENERGY DRIVER
@@ -950,7 +950,7 @@ AMD POWERPLAY
 M:	Evan Quan <evan.quan@amd.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
-T:	git git://people.freedesktop.org/~agd5f/linux
+T:	git https://gitlab.freedesktop.org/agd5f/linux.git
 F:	drivers/gpu/drm/amd/pm/powerplay/
 
 AMD SEATTLE DEVICE TREE SUPPORT
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
