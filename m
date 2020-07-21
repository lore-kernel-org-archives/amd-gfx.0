Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79384C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 05:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47441207DD
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 05:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SxDgkwhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47441207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18CB56E42F;
	Tue, 21 Jul 2020 05:21:09 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760049.outbound.protection.outlook.com [40.107.76.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 046E06E42F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 05:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3lBOr0lNW5c33Xu0WXt7xnyZ/a3olmqfEDIfIwKfsWADdvqMpKd1UXjuOsr/GlWarDJhn8uvaFtrlRA+FNqT8SvDaNxshJS9ph1XIClSPG/cR0PdJRuEp9wmGNU2vvDxVXyUjgXLLX3nbeFsjfnPmTEuIcGhwQQ5eTK+9FWv1xdvajhQuLyYrQHPjxpY32PlmOHYEruna6LamYojObIuKvefuy0coTGAMENk7j3iy/cdne+o+cXQqBR3KoXAz/AURuCjKfrT5zTJJUDv+BVf6yvA3C8iPvq8GziilhA3Oep3MtfXpt+oZQW/npZ5hNijJQWz2dEU7aPtSyBCcw9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1///qA7jwBKX8hPDOEi2+D+R1v1AvlMEiYwuJT1phg=;
 b=AlWVxv6VJ3rpXA4dWMIe1OivXMpsZb/agAE8sak/VAjgzG+GOKtBS1GTjojnRbzMm6lYeEKgefPREtYMus7O7o9wYsPutVZDgyGJYtmqqXToRLRIk2maXX/EJPlJbD0hIm/7iEU7i9d1eM3+sVEokPGIwasjgWu8TOoPFcsPW2g8iST9a67y+OKU/VjcnNBxgRpjb+fI3KSk6CKTUO11VybR+0ir4kDzqZdhLiAYbEBth+GX/87u36T550ZbzVhlng7L5DMtk5vrm6iYtu/Kz6R/j1FkRLztPODbwInSYB8vU9QhSZT0mr5NjYAgI/UKLN4PakG9otMJi5igVF7MWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1///qA7jwBKX8hPDOEi2+D+R1v1AvlMEiYwuJT1phg=;
 b=SxDgkwhLQHZxEcYd4xZDO4i/phyIUrFiH26Eh9p+J7oT3gu1+qsMTGle0g5poHEbxO5Hq/Tt8xZQH0huK+UmY8T7hSEO73pbRlDPJ9WmogDlO0qQu68pFp7h4aowyp2KTsaTBLZTQoDUkV5ECDT4yO8p6tD/3kYLrqPM7Juiwzs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1310.namprd12.prod.outlook.com (2603:10b6:300:a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Tue, 21 Jul
 2020 05:21:00 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3195.026; Tue, 21 Jul
 2020 05:21:00 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: add msg map for mode1 reset
Date: Tue, 21 Jul 2020 13:20:39 +0800
Message-Id: <20200721052039.1246295-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:202:2::13) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR0401CA0003.apcprd04.prod.outlook.com (2603:1096:202:2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Tue, 21 Jul 2020 05:20:58 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae060d52-9051-4e43-ca92-08d82d35dab3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1310:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB13102CED9BDBFE02272E346CEF780@MWHPR12MB1310.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8aWXU/qpl8bBGCjYC1bIlER/87XHw3bWZOzxI9vXhfaW492fCwTHeJ1hXpqcGNzirmS5FGUvItV/WP1xnPr7GhwTbYTLX3jQ2NClj/OBR45VsZiq61sLiN54JKpoMe0HMBNEG+7MX1dax4WQbTpW8sueu9cHrjLHDtQQJIS1+VBZ2i3c9F036Mw7hT8H5FdKXhXUFsDSxnRP8v8MDYUvTk9wiRsCFU4AU5MRPkoye+sBBBhsSFgSBfMMvOrMzbQVZzriBtXcdshwNiQJ4fPMn+8shqYfmo/j+5yweYWCusgowWR/gnNQvCfsbNhDLD+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(4326008)(83380400001)(52116002)(8936002)(7696005)(186003)(26005)(6916009)(478600001)(8676002)(16526019)(86362001)(5660300002)(66946007)(66556008)(36756003)(66476007)(2616005)(1076003)(4744005)(6666004)(44832011)(956004)(6486002)(316002)(2906002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0cgH3vnIhVPIG1RiGCYp5Fmr9L0KCyZB2Lcp/bvl/Uniz1kileR6LXP0rqSIXK4g47/mv4ucWbkqydIDy8gqQukEXKG48KZd5srFJ/+91aoAabvqpQdcut91znevv+wTTPDqHjdjSeiuBvxH4hqyzmXHME0xOfqwavhPUJkPfqH1o2WXYYWzHEgk3YBxE87R3ymVwneYN6wDYQYsp9/Sr/dlbPY0sY3Xo0wBXXvUflUwISHDI0jL8Pw1dx46TvUw2cyae1ypdPcrghesIU6tPym35rBrUL8fkGBEk7GEFcCyWtfb+kJ1OshoPNP8/0QKaXgZIfQDjkjOl15VEoxOiIlXYiyGz3iAqCik+fY9zQJPGJ6wdQhcWme/Pko5U5CTdcNJ4sOyhNvNh/ZpaYrnFSkvHGJKHQ8kn7LU3mE4ErOgXtBODtWlqVa0jNJ32bzX6tWjGhEJoYPRaSZJoLi52qMdsKuymMB5x/FAVLtL0UbL7Ku7bWgtM5C/l8o09rwO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae060d52-9051-4e43-ca92-08d82d35dab3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 05:21:00.3015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkAFmA9CSxGeqbzz8VCiNBm3GqdPkb8ALvWmUcibKF6sBQpfiOG+A6or5RErtmgR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1310
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
Cc: Likun Gao <Likun.Gao@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Mapping Mode1Reset message for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I9b8d39b10c7723af4589577fdbfa4acd5af6e85d
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index cae8e776fafe..bf3d6bbba930 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -118,6 +118,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,               1),
 	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME,              1),
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       1),
+	MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,		       1),
 };
 
 static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
