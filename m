Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A725CC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 11:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5994561408
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 11:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5994561408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D8F66EE46;
	Fri, 14 May 2021 11:48:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32666EE53
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 11:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YO8N/mVbY3qqaxkKKjiGvKlI4duTbiU2HCQfIeq3m5DfQzPJks2166BZw0BMHOInCPK8bVLwjasnNM7pA8OYhrxkrp0MPCyVcM8aUMFNV3+WOatPXCn3BG8zfLVMtR+Q+c+1F0cXoj/0Bcekn8tKvkVLJiNqKBGNFq6GBL2LgAVMVa3fB8H0FJNJgohkeyopToR9N+52fPJSmTcvK0op4isxXbjMH9XI4XKMtSjLTIlMpq925M7F8+QTAv5w7ao4n5dNQ6TBaVgehm0BOyWNR284yRhMnhYkuskzVZDkXzf7uo7i8Z1sRhie7apxhfpoIMVl86OKRigCiAjmFshZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+L/eU3VsYQEEjUr6/oMXX4a5i2hnXrzzA/OU6/YC5E=;
 b=JFNS2JOv6znOiEbTRfVbD8Jb6qEvBmzgT4PcGqIoyD13kWxoF1XOlDo4JPpop8TOT/ScDrJcAZep58EvtaOau8ocdvsEzvbLxDOVmoC+uRjYjXKJNU1MPvFjAx84As+TSWcLuxEQRKu5JLebWkpb1rgfSeA9Jk11HUTkYJHsW2b8mUMNoVybkqBpSFDp5zOjUsJs37EWExayyf9r9v129WJaZ8v5pZMqaIYwFtbxqElzsUZpDJU593zF4LjNk0FZpaBJlQAdje1QDoBzu6ex4SYfBVgpkiHzKdmHsnpcO9FF1uhQpuInVMuM9D3lICx5bLDGRcpnARKhG8Z/JYuFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+L/eU3VsYQEEjUr6/oMXX4a5i2hnXrzzA/OU6/YC5E=;
 b=sOWpcokURffuSxLxtdT8xvafgEfKlf/C9VFyjFKPqvIR1N2Vk+7L4JmsXgNISq+SAKQy9V22H+DaEdye5Bsu2t0P5L0x+xkSuJncy0zHVgIqjMzkoQG19NNvsVNns/F46OL42gy2DpuuvkTk0gzss1DoMSrU6n5ez3W28rCLP+o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Fri, 14 May 2021 11:47:59 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101%7]) with mapi id 15.20.4129.025; Fri, 14 May 2021
 11:47:59 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix overlay validation by considering cursors
Date: Fri, 14 May 2021 07:47:34 -0400
Message-Id: <20210514114734.687096-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:56e0:6d60:cd4d:5c52:6e7b:a3a4]
X-ClientProxiedBy: YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28)
 To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:cd4d:5c52:6e7b:a3a4)
 by YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 11:47:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd390e5a-2f25-4b95-e155-08d916ce1f05
X-MS-TrafficTypeDiagnostic: DM5PR12MB1516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15166E833395FB992D95C48E98509@DM5PR12MB1516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cee8V1PjaHWVFR6mV2RDnAqt/abQTOarrNRSTJQ0NXqEC0XDeoyGktL9qDr1ZZMcuI0GGzYYH8bj+USjCX5v5NSmJVOUIw/7vz1f07YqZY7bdufkblex7E9GFNnurGshQUDUd4YH9sUgsoLpUDDvOf0RAcEQUx5kHxfLvRF59Ltjvq0aRkmdF1ufqHKCeG2T+z0Stnr3naEPm4iTgrs59ounAkmEUXksxJVUSYJFKVdB0D2XjpnsCjZ5w4GTSTWKnGpQnjKUZ72dZgoS1x+iX04Z2qKnXaW+V6ngP5p48lNEUMz7ihTLhx003F2Qs9BWEiWmZFA/831SgzJMexg4HVoqVe1m5V+lksnGgPwW5aHGR9sbzqFB3SE8if6HVjtQC7I1CaJ5JRmUGjSVn+kchi3Qs17WSs/uyf69AY7P619/8FZSeoSGnotJk5gLP4OVDumm024wZsee96Vi19unu/mITmv+v+h7vUz4LWX37MZneN0Sc0/IkrsUSL0uGzXrtxVfy875DBVzJ6q1ZeOHYqpbQIqwP/RjUvBEiCIE+nfW0IJTaHaPa7LWgGW7YoaXlm+5a2rufZu9DQWNTdbPt9Y/ONOF36rmdNIWGgPWQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(396003)(346002)(136003)(376002)(1076003)(8676002)(6512007)(6506007)(36756003)(16526019)(66946007)(4326008)(8936002)(83380400001)(52116002)(54906003)(2616005)(6916009)(5660300002)(316002)(38100700002)(478600001)(86362001)(186003)(6666004)(66556008)(66476007)(6486002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dAiXh/HAl1hBTDA6WSgj4TCZQXMXvMnlpwWBla0pM960Irt+cs+LRFMUjA+7?=
 =?us-ascii?Q?HdLgy8h4PLINxaqX+cQ+8xYlX54F/ZtGnvSra939OSru6+7U37su2S7Es7Dj?=
 =?us-ascii?Q?F7dh6IRL1qL8Uvajh1UMUdEJOXVL0SbSC60pbyBOYS5OI2fL1T8mg+ah5lUw?=
 =?us-ascii?Q?a5TbuagekZBr4J6iryeu8hjTAvn9CH9wCDSm1ITErxzX+r218UF64dJOuYZE?=
 =?us-ascii?Q?CAduH1IyOxqBVJaf7OzxB1dZcxzkkVlDbLkAcS3e+KQJx9NBmN9YlaYcY2na?=
 =?us-ascii?Q?JMw9ii3J3f9MeQR1Vp1Rn4QK1a4G5XJvNK911NtjVusEMzDws64bfVSUJRj3?=
 =?us-ascii?Q?j3Owb7qY0N/DvPO4JSwBA1TgBKHmC5a3SgelUQzMEihtnQGm5bNd/QwlsD2S?=
 =?us-ascii?Q?IIJUQQ2q1+AfkxEBHJbtkH/8azXw4k1sp95amcBdwAvg/c8A5V1h7jcU6tiE?=
 =?us-ascii?Q?Chyoy4xugJXtNMxHi42nIVeFPV20Hc4ijHzCuO8zaUK3ClONSs5KlcBL8c6f?=
 =?us-ascii?Q?dNDtFzGTDzSmthFckHuipnHJm2RkwoENYCQFt+R8f4uwY4CJx7SKga8w8byA?=
 =?us-ascii?Q?yU7ckCibCO+goa4uk4b9IaS/7hqkNcUvGIEzM6pALTtZYfnkr62bFiZxjt8D?=
 =?us-ascii?Q?3tS2AiRXlDsi4RbadR5W2LiXhPkzldfPJkUvMDXK1xSbvNWdnTKy+QvPOMtZ?=
 =?us-ascii?Q?biXjr2Czasqyc4RGrlVnCECQV5xAxPZasBXUGPF3qQcw/1QnCTWHdDn4rK+9?=
 =?us-ascii?Q?1phbhjfwLkgglcWfwK08ZUaXvMmeKbDBdtzBqbCC/zw8ps7bWslbdZiZ8pj6?=
 =?us-ascii?Q?ZomMk+aiN1VsbQx0ocjQyn9Rw2PR8158CDUhSYzqGpHUy1YyMEIQuqmGAPF8?=
 =?us-ascii?Q?HzUdiW+tqdsbvHIUVmf4HKCZ7VCw8jq3aGgJPhPof7bcA+EYB4ZPrzwX0+fg?=
 =?us-ascii?Q?DpXLH+5ULIWYDwtnH3P9g8okfDgvS5nftXXfxNvB2gkVPcvYvSML3Bo1mrN2?=
 =?us-ascii?Q?JJLBkImH+cN2906hyZ+6/tnj1B0WGGYB67uil5ctLPUu+YFC2JLvRxWyCCN0?=
 =?us-ascii?Q?65Cx2vxLc/Fs62npvEkoBZFFPhuAImXdsoShXZkY3s9Phj0ixMCm1/lUJr+v?=
 =?us-ascii?Q?4fnLak2Rla/wEuwZFwBJwkljNwFOQD9v/mGVsElsS8EPQSMREkF+w8PJrkxR?=
 =?us-ascii?Q?Pk8zKaABNnHSgcNeBiux2l0TX1L0PrZrEUKSabvD4SyP05ET4dNQUhD1E7c9?=
 =?us-ascii?Q?0TJ87aCZ0yOboy4iXMvWdyESWWxV3oeyklhUG3Q66bDXMjdKaH5FNgXPsCka?=
 =?us-ascii?Q?gjXwO8+kNqO6T3ocD6rkdOFGPZ8X+L+U1Wlv6SozNTREp1wxbNx6AGMsnS//?=
 =?us-ascii?Q?JJZ7ZKqs+IFNexcqoxnJo///3H7b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd390e5a-2f25-4b95-e155-08d916ce1f05
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 11:47:59.0917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27eptxEtxzZee426cWYKylhDaTOg/vAzE94ozmStPEo8Iwf0UCxe4IJHLf2VyuvOKHisqzzLcYqgb7GKFr+Weg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 "Tianci . Yin" <tianci.yin@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Nicholas Choi <nicholas.choi@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A few weeks ago, we saw a two cursor issue in a ChromeOS system. We
fixed it in the commit:

 drm/amd/display: Fix two cursor duplication when using overlay
 (read the commit message for more details)

After this change, we noticed that some IGT subtests related to
kms_plane and kms_plane_scaling started to fail. After investigating
this issue, we noticed that all subtests that fail have a primary plane
covering the overlay plane, which is currently rejected by amdgpu dm.
Fail those IGT tests highlight that our verification was too broad and
compromises the overlay usage in our drive. This patch fixes this issue
by ensuring that we only reject commits where the primary plane is not
fully covered by the overlay when the cursor hardware is enabled. With
this fix, all IGT tests start to pass again, which means our overlay
support works as expected.

Cc: Tianci.Yin <tianci.yin@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Choi <nicholas.choi@amd.com>
Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Mark Yacoub <markyacoub@google.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ccd67003b120..9c2537a17a7b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10067,7 +10067,7 @@ static int validate_overlay(struct drm_atomic_state *state)
 	int i;
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
-	struct drm_plane_state *primary_state, *overlay_state = NULL;
+	struct drm_plane_state *primary_state, *cursor_state, *overlay_state = NULL;
 
 	/* Check if primary plane is contained inside overlay */
 	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
@@ -10097,6 +10097,14 @@ static int validate_overlay(struct drm_atomic_state *state)
 	if (!primary_state->crtc)
 		return 0;
 
+	/* check if cursor plane is enabled */
+	cursor_state = drm_atomic_get_plane_state(state, overlay_state->crtc->cursor);
+	if (IS_ERR(cursor_state))
+		return PTR_ERR(cursor_state);
+
+	if (drm_atomic_plane_disabling(plane->state, cursor_state))
+		return 0;
+
 	/* Perform the bounds check to ensure the overlay plane covers the primary */
 	if (primary_state->crtc_x < overlay_state->crtc_x ||
 	    primary_state->crtc_y < overlay_state->crtc_y ||
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
