Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAAAC2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728EB24073
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fraNeqyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728EB24073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA8856E927;
	Fri, 20 Nov 2020 20:20:43 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680059.outbound.protection.outlook.com [40.107.68.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A126E921
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjErT72E3dzLznag8bWbMrL5qaVw17x3ht5fpf1ONIRA8LczSKN1AMZWZKxM/e8qhOe9JDO6o4YW5zm8OiSlYdK2I+W7t/RjVJgTac8J7axBrG2b95m+G9NGfS+EibX++qk9SF3qcaGq6X7buvm75o0LmBjQDgYKPz0xwQbh5E7ElmfNE/lMwsGI2YxeXUi2I7gVQK/olwelIyQG8CBg1eDRy0NQsofTwIuYvrcwO+2Y2iNaGEXlenDBBR27/REXc8UMI9JB6MemH10Uji0GEtONiky1tVjHoupuodqJMYJhL2EpUKpFQaIf4pNVOiGzTqEdtan3wM40ktJP3ZL0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUN8rxj6rYOXIjp/LFPUk+VLRrbP0/oiKyEmmCm1wVw=;
 b=KrgiYWpbl4Yrdnok5GoRN3lCe8GvSb5d2zExEsfc6t01EKX/eXiOgYGwEzOpKlLwLnYdBog2N+sLX39vJJknMhKMH7tg0pH/eIfMwvE+dKhySrybgz0zJQOypdTJp46fbHcl3ZG88oqvRLf/qk9UjvEkETaj4b5+gYI/D0f2dOSTKyH+fENZnVl85OoCC3XeMMxiax/ugqO4C08kWTAEeQXOZ7xHbZF0yJa239lmKtMMwlR/a/ib5vxHR1OUtKGkE5QnbYcOf+gc8BhUkVgl2rITJDNGZ8tl5BB/3KidBFE2V8u7I1uYijAFqKxkUYUflCnu8ExnPouOdgnlNqE2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUN8rxj6rYOXIjp/LFPUk+VLRrbP0/oiKyEmmCm1wVw=;
 b=fraNeqyAABe2f19naZYsFLuCiLKSsON93ZshkcEs1QWkXPH2xwurdzuDlyI3DXo7EbJmId0g2t8z03ZtYJjTRLN8LwUCYsPCQX6jDCUv6NZFdoccCT/8xDjeuPsSMJGFG+1Qu08xlOOvy/V61NSxRA787kN0irrEYSHO3C0t92I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 20:20:34 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:34 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/18] drm/amd/display: 3.2.113
Date: Fri, 20 Nov 2020 15:19:56 -0500
Message-Id: <20201120201958.2455002-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf4646ae-e89a-42de-d530-08d88d91bc01
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB371712E707A5E64E8F753FB898FF0@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOpotVWU9LY/rvg5YjpdD8M170GQCl3moC+/wff/rnKV1xdrDriwKGW4EZAEIFc97RwxXoNAEwBI1dTQ283LIzoVx8z7lYuwVR9c4dStOQUh047FX+Ukm45mmku4eVKM1rWDykVS6oBxVLttT8uJsID5o116GBrwq/0R9BuqWyxvYd8jLPZHevc0w/8QtmKxhavNGeoyr2qF5I2He3JV7ik2qXx2r+7LajLiXwN9r3QbaIAl1II4Xur8CC3KIlqjd5BRueyc098bYjYUZR+X60uoL7j0rhSbVB21kJZH0HjK+uCEgtJfON1a7jmhHONiXDARoKxXI7vOyfSQ/TYU5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(86362001)(66476007)(6916009)(8676002)(54906003)(6512007)(8936002)(66946007)(4744005)(52116002)(6506007)(16526019)(83380400001)(5660300002)(2616005)(186003)(1076003)(6486002)(36756003)(478600001)(66556008)(316002)(4326008)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: M5pDO2VbRfia4qS+Rx06Mm+CyIqS9qA0gJeOhC8M5+Ded3umBQGy9j2zUxNrznr9kJOzcGuW1zV/PpH/iapAqCS6ITnZaqalRyDpEObNczuDeZrT3ewxta/IovLj0Gjk1TqScEq0ciQViTUAw9dwsM2Z46CxGbcGicXnkYiZYiO5MevJ+gt4itrkheJYXKCdqsiulu0IDKaMj33KyvQnGKiRhtilS06gi37GWTh2+jnoFfIO6/8j1FdXuLp3Q5pctngNjtvSc4YYBYvEjMChOkt7ScIasnD9aMDcQ9f11y/HZPa+760zEixhH//b5RUmJoeU4krpGruni8VFF3NJII4hlCGfk1h60VO8bS8ZVyo/eD4FKTxqV1ulq70mix3nRkWC76GVv8zptVgt4v/7HmAOdm4fgoRMQWsRxFUHYyX4bWuSLkQkU212ZvkYnIvlRSEM36N9vugnOf6PgTqkCg80jGlChcL3SJYtZwIKPoKNCJnVAOn3aRZuv9pYY4k6zfAtY+lPXFZVgLPZfLY5jSNuxdldEaWG4oCbbvfAxLiGrJAEVCJD++Jej26LykFzr0/C7pvZVRidzSd/S9m7gW21wyIOG5esBBThBnzND9z2kh2Vf+c0opDcdJgxaIOwjyF5GQwa3nAyjsEsD8GJjYks1QqTVYRUR1O1kjUSF9WzWiTnWsw3AqyhWPUqob7kzVyO58NreURlA4u5qn9vNO9blYbd0oLwy3wD2W5kbtGXnk4DDxrx+bTDy3/q+5uEMHbXhX3fJY3vYNqmq6INaw4mB4kTMulRTl6NjkGI2B6RpGrLkpvOpj4LF8mLOVArQ+YwGY1idvAU/fmufh4MFNYBI7QInOuXVKcoyw3fBg6SCPZ5r7b4Ls6FiX2jzX1vH3R3UVP9Uj29JvbX6B7I746UUcOUrSFVc1XlCnAefVOmhOgIp0+sr2n3vpYAE1KY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4646ae-e89a-42de-d530-08d88d91bc01
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:33.8605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSJGmH2H84fMDXfk/gKZqjwHONDw0PYwgoIdhhxf88NoaqX19AlvnzJw+12hqrIQwIKxMLOS0K11zYWnRjgxDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 115468d3f793..68a192e64418 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.112"
+#define DC_VER "3.2.113"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
