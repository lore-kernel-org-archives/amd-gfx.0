Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A90C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5D920FC3
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vF2vNT/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5D920FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2BE389EB1;
	Fri, 19 Jun 2020 20:13:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2608F89EB1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxTdG7Lom2XqFCfjBc594N7lMNaqDWxCyWV3XX04Xjdsvqq6IK45M2FyrP2lM9ETVYvYeU6tUcci8RnsFF4GydR+MOG8M8lrsN05TrZ6v4EkR0ik7nKdOTwBsO/MPODlbJ4M71HxiZCbJTh4esBFGcbtanPMldHWD9h3rpdXPC1/URK6yXMZbOArvvULwUa6IwlzSbCPLA1cz4h/fNmUEnyrqc4jkk9fdfhvpj7s3+Ao/yplAl9ZMvHccCCdgV88evkN0upLCGctdCJVkVJeNQPKY4oSeaaiN3gIk+GGRbBXkpzCHv++r+Ogm23rYFq1lQNMYQfIVT5W5X6HoUNxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhg4/3UthTc8Ci3+PwQ7+oPCaOJvsNusrwhzCM6K3Es=;
 b=f4yPBBh2YbwAguuctQ3S30I0cgCYTOI1YL7k8F93VdhypyERdbMyRZ9pkNdU60dvYKIMT+AkLqiZ2+ctVTtPhAXj7s5+Om5tHIOstY5CIGPRZxgxXY3qvBA/bhCIaMbfbDJz5cG7MLrT4YEEzsSyakzbPGqpjLsY+Tl0IWziy6bJrYXLHBY9OPOoOU2CUyfWFWkF+NAW2wkqU46R8LPV27fo5pU6RlNMH3kgjTGTvf9SBaweZ+UMgiu0GWEAQGnZRuMf4Vz3LZQ+7xuUW/N3eSzbjfOHLyjhT9f+3bFxOoXOnTfdx0w7DjoasTrWT0MZteLRn0id1EtufEaFFBlkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhg4/3UthTc8Ci3+PwQ7+oPCaOJvsNusrwhzCM6K3Es=;
 b=vF2vNT/iFWlaa8JTpFGyV5WopcXp6AB+MKVfsBzTDN/WHfa2bUZzYqCO9X6a7JBD/QXBsq8MVymch7txf8/3B/TzmI8HdZdWdjuMu6wxRIucZY1SvV3OrAZua+YSGaeGk8q9Ar374QgogXgsu9I8CN5YdNw8kDofZn3NEiY/720=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:13:39 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:13:39 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/30] drm/amd/display: 3.2.91
Date: Fri, 19 Jun 2020 16:12:22 -0400
Message-Id: <20200619201222.2916504-31-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:13:08 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79d52d7b-8e1d-463b-ab0c-08d8148d2efa
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB37173550220CD75627FB32E598980@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z08esFwxGOVOh0HNmak1Vw30Ll78DdB1lH46VYxwMrex+e336d2yaOvKQoKow+B7hnaQybi/wpxT7Q85pRPDnlyvh94N3EDZAu6k1B/IW+YCe3PSGdylFx0M8BR2A5KcImnEJ0W7Vn2JP9ztGBcrAhF3QJNgUSGtlt9CPaGRqfXEubQCh2NAN0GhB0CY7QsYJNGcI2A+1eVrSj3r+5Iffkjzy6ceZI0cK4/Kut/GvZsbaaM5pND6DgzRDk33AGg7o612frRJuGqmIQ2fsFAHT2hIVxR/D3VESRxQfFXiiiiRmvIjbW8o1IFYoWK/ZOT7WaW2r/UkWZQZTpGFHRGUmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(5660300002)(66476007)(16526019)(86362001)(6916009)(83380400001)(478600001)(66556008)(66946007)(8676002)(6512007)(1076003)(6666004)(6506007)(4326008)(52116002)(8936002)(2906002)(316002)(6486002)(36756003)(186003)(2616005)(4744005)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KzHEqgqVHNdCTK/dP9mDgT66mWYUk++M/3JIN66WWAZyoJOl0P8Vmfew+pDy0PogkThlwrgaZZalKuVB6HGFdkxZejJrCv5mQi8GAnehuMphbFZKZd0fhVaggHCaHeFiWgUW4EORQrci3W26sPUVNvCR0mpf8/3egtMk31B5UmlOTT3bxfBIxWejPtqDUnhGMHDobJJU5Fed1uRGttVDbTH9DVtBKU+YQcnLE2ljoXBrpc8+KY5rw6D1K/xt+Tdae92In3dr9U9BhEZMFWa61cWDy3JDZA0EhxqcX3WBCw2y0JoTh86FLy6PMn7Bx3D0FVzOSNN01UIHzNRkdJVqwOA7gePUtC88bLVHrDkFMqK6PizHgejKz7ZT8nVMK6uSW8vlliJuEoZBECq9fWM0p0UfUCK/c1qb6GzP7pFQv5RMTe5mOaxXVURFuR7wH+M9+jRr6Hbxk3w4I6kxTB9fFVSMmdbZU58F7a/ETvHPEEW0loW6XUQtK10Zke3vB9CKrai+p2K9zQEUv5RpnPOWig==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d52d7b-8e1d-463b-ab0c-08d8148d2efa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:13:08.6349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stzL5Vx72HZAluOTH53+nKgLXEvdCrTcwIWXwulUse5p/KMkhtQhDaebkKxtMxsz6IIT8s9nAe8wYfOw3tVoVA==
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
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
index ceba626bda2f..f7cb1354a635 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.90"
+#define DC_VER "3.2.91"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
