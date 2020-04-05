Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2DEC2BA1E
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBDC20644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s9kIB/kZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBDC20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A9986E2A5;
	Sun,  5 Apr 2020 20:41:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 492B86E2A5
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jx5B9HZKvjaXFEIJNr5afWnfHp8Z6ETI6PJgA9+w0J33QW7WKzXEPq1ZQeEAo5/44pOP9JMauxbY4GT84PiyTH5qw4TDUrVu5m/f9AsTXjiQddageZwt5mOppfvmjBeQwMlY/XJGip4aeAZs/hAycjqwgOL84I6xZCBjUkGRv71jRG3n3JVKGNv/1inG6N9Ck4pRnt01XAFes65ekSxxT0Jk3q/48vMo0OqeVgrbrUv+kfmp2v0hAJPDvd/VMGMV6KNvR+QETWEOIFeR9pzXvDfUCu6R4UBj2j/JJo28ZEnvCmub4nzCkfsB4BmP7Ryqz6wHUOlZsDK9sQc9Su3ybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDjvXL4ZZMjROte78FtZSHOJ4xFiYC6d0p9Aejdw5fY=;
 b=Y+vs8tHunyXmga820zqjb0hQljLx8Vk/vrOuB0e+kHPBz8PdC7tjO+B2Gv24BcZjiQujGmwYGSm1dhlUrEBVrO7+Q5wre0bn0iVawcG5s43PGOmHA0KkBRzfa9zgO6+q1Qd2eflLIw3iDWxuw1Kb4Cp/jpY54r+FyPjFJaN7Z21zz/TFYZtdq7CKaE2P+AGf4qh2AbzcNS+uPn46wss9+mDdrHccqlxB102yiT/yLeGpITxXJ6fSnFsmDxFKEaY87Uoj36eBPy/fME0mnwGYSnE523Scbn9sFb4O6O9tZEct16IMTR/PJqsoZ9UDkUZ5PLCGUy5rE5ytTAlUcBuhig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDjvXL4ZZMjROte78FtZSHOJ4xFiYC6d0p9Aejdw5fY=;
 b=s9kIB/kZr5xkAwBuvFfmq3kGIKNuqQHkWzGnn2zpwRGoiDfKeyEnGmMT2pzmzmSuo3XTAXngLlgIh/CtXTSZgZ8s7kASOANhrRaSV6aM8qBgqXGhjXFJAUCwTNjzMs9w6LT5Wdk5Hii1XNwR3AUr7oTkKpD1cWNdDvUgRXpzIFs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:55 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:55 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/36] drm/amd/display: Fix incorrect cursor pos on scaled
 primary plane
Date: Sun,  5 Apr 2020 16:40:55 -0400
Message-Id: <20200405204115.683559-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:53 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91215215-e2b5-4d3c-d3ec-08d7d9a1c6cd
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255534989025B720C27BDBB498C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jW04XEzIrZtubH5FY7+9RtTN6u2WFnBxwEtf0g89U3wLC8R6cQAhzSKuGCIjuh+mqxUjT5umZckcjwMOl62pQAMz/+U4twso9qDIktdZ0G/OdAb/l7CcOSp+thNE6TfW43wNtB1dY445FBI2I4Blvgbpkhp3LkOpKxZXikQBue/Nnd20af4ODKHjSSm8qaRhLdFSwqppjf8qxZ5ntnQl/2pNWOrGl2me4blwIV9WIbuaZmL57L8H4yg4XZzzrsoyZZCFCjHaju6FWxUMlWHrC2gDlal1clbRU0lUOv0bSJMUfV60F9cBGEU0X3iiFpIQZh3J4zAv3AFAmXzJfH05rtmTrpVPpyUFr8StYBTVIinldRrcBbDzhXdEutZluX4pKVSicW9ROTf4QkdqOj8AbTR/mIa+kLE6bJEhlDANudKVstgde8Jv42m8E1Ipahev
X-MS-Exchange-AntiSpam-MessageData: 5LJEJX8wZyaanfcHCP+E/GnezrKOej0vgZgBv/1Fpg0EPPkxczzZA08COqOcPW5mAd36pf9Wnrv6M326eSe2ShhUYcsioAwR5b5WDrwIam2VUxsFl2GtwUO0TusuDh/6Q8iASv1r8fbpwd7B79u2sCgPBAZKJKIZG1z/hykqIzM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91215215-e2b5-4d3c-d3ec-08d7d9a1c6cd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:54.9211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nl0Z740KQ5VmDiHBt7mQ75FGcRLSY3oqgzYSH38myMLHkFOXWVg2xs+TTy7x9CMmMoyjNBmWXnw+1wx0s1tgWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Zhan Liu <Zhan.Liu@amd.com>,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Cursor pos is correctly adjusted from DC side for source rect offset
on DCN ASIC, but only on the overlay.

This is because DM places offsets the cursor for primary planes only
to workaround missing code in DCE for the adjustment we're now correctly
doing in DC for DCN ASIC.

[How]
Drop the adjustment for source rect from the DM side of things and put
the code where it actually belongs - in DC on the pipe level.

This matches what we do for DCN now.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     |  6 ------
 .../drm/amd/display/dc/dce110/dce110_hw_sequencer.c   | 11 +++++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 355686178b1a..3dcd4de0b2b3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6370,12 +6370,6 @@ static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
 	    y <= -amdgpu_crtc->max_cursor_height)
 		return 0;
 
-	if (crtc->primary->state) {
-		/* avivo cursor are offset into the total surface */
-		x += crtc->primary->state->src_x >> 16;
-		y += crtc->primary->state->src_y >> 16;
-	}
-
 	if (x < 0) {
 		xorigin = min(-x, amdgpu_crtc->max_cursor_width - 1);
 		x = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 0976e378659f..67f7ca346696 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2685,6 +2685,17 @@ void dce110_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		.mirror = pipe_ctx->plane_state->horizontal_mirror
 	};
 
+	/**
+	 * If the cursor's source viewport is clipped then we need to
+	 * translate the cursor to appear in the correct position on
+	 * the screen.
+	 *
+	 * This translation isn't affected by scaling so it needs to be
+	 * done *after* we adjust the position for the scale factor.
+	 */
+	pos_cpy.x += pipe_ctx->plane_state->src_rect.x;
+	pos_cpy.y += pipe_ctx->plane_state->src_rect.y;
+
 	if (pipe_ctx->plane_state->address.type
 			== PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
 		pos_cpy.enable = false;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
