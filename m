Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572D8C2BB55
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 15:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D7B20771
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 15:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iD/s2zCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D7B20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959EF6EA18;
	Wed, 15 Apr 2020 15:43:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3956EA18
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 15:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC8JrPukxgMXu0DMR97tC0sNtFejYXi0NE9QufyjGani0CNFZXVaJFGtVPBI7q2U5qLMjJJyDWZEE+PyUXMssJjKy4EjV2xHKTq3vbhv6JFfwBXwT/bLzbryHyjL1BPNeC+hlYRxxYaxWhb/lVWMAOBN++dEMG57cenWIZlQ4Uor8ET+VtPKIbFlyzpMQuYy0r1rrKU3nSpTskILn3E6MRi0F3RpiSvSNPSXsLDcxSp8LkXx+uoq4HoImOkkgbiLl9WbS/s6ALs1Lyrr16/weX0uh6DbfnLN+FADM4mxjNDMpwj2jsA3U34ESA4hWxOnOAvDDGHGvNbxnv7mbMh9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEbJpuJBfa645ra9eGKBQlWeg3zLiX6T8YG/S1qB5n8=;
 b=ingfe2FRAUhOaba7oT6l+qvlv7l2s9FgcoPmMsB/2VUJ9lZ7fXmwPJ8LqggpRO52h68okwJqt4bD0X2xm0JWEIGMJPqCyZlvBTb3z366KyTwWv1IW4dmSLf9/NcrC+Mlg6l3tPJETecmyAYSh0RQftbgYv053mavSh2Ch9LQH2AcRvqT2EzMmtkoxoTOnz4cCV9dlLDzXFU/kJol3MdSwfbFVf/ZO3Nxff4ZqdNZxqL8ZLpYspWQLUMCSVRLGAJ+bNbBn0ozJaQMgzmuf1H7YGNSwl5smF2OvPvYn7YMZKJbKgKdlEeEI8ZLoTIOv9MhJUynnZSRd5MRtDqTkeR9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEbJpuJBfa645ra9eGKBQlWeg3zLiX6T8YG/S1qB5n8=;
 b=iD/s2zCkseD4y5wvCZZKRRzLXj6FRE8MBQlUE13SX8F8H8svz+A0AgH7xkAMiDyy1960LYnXuyOAJv6ic8yxXAI72OqRn6THvAifeVQQHt89CXKl8NEqMIkABmzLNabzeK8LOgbQJyUFne32TCgw5hdfAgspQGJUWEU3e/9qaSI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
Received: from BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Wed, 15 Apr
 2020 15:43:37 +0000
Received: from BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::c8:8aec:d08e:8bca]) by BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::c8:8aec:d08e:8bca%4]) with mapi id 15.20.2921.024; Wed, 15 Apr 2020
 15:43:37 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: fix resume failed as smu table initialize
 early exit
Date: Wed, 15 Apr 2020 23:43:24 +0800
Message-Id: <1586965404-31922-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR02CA0173.apcprd02.prod.outlook.com
 (2603:1096:201:1f::33) To BY5PR12MB4307.namprd12.prod.outlook.com
 (2603:10b6:a03:20c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK2PR02CA0173.apcprd02.prod.outlook.com (2603:1096:201:1f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2900.17 via Frontend Transport; Wed, 15 Apr 2020 15:43:35 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72733c0c-94cc-4379-464f-08d7e153c326
X-MS-TrafficTypeDiagnostic: BY5PR12MB4258:|BY5PR12MB4258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4258B278838C2D2710CBD10CFBDB0@BY5PR12MB4258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(5660300002)(8676002)(26005)(52116002)(81156014)(7696005)(36756003)(8936002)(4326008)(2906002)(6916009)(4744005)(66556008)(66946007)(66476007)(86362001)(6666004)(186003)(16526019)(478600001)(316002)(956004)(2616005)(6486002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5u0098CdlQqvA2STIJ+OOAgdIinLVieHi58zABjSG0rs0+tOUJKVm6O5cdRBVzn11ot15diMeeT0sbfsAChrxkM+BHaLpdamtDxebhAxEiRP1kStOQyUulyhdRKUU1vlJd2omildfqztGpXPOApwXqa/2W+q6ZsI7LC78S1xdmLxLhb2ddsA5UO1GNz8Jz90ikYWpB+oIjIefHEHvPqX1F+0+ZcD+cwrvmIoFD4BkvOpEUkFK0nOAQotnj7ihnr7itsp9gxDoD5+SZLo9GRbD+rsp+UOsEXkRzDlIngSwg0U4FCMweD12WopKxBTMVLmDOF2BoG5RimXXWFiMUD8z4psYwZt20QDE9OXIe6Kvr7bGzbDyCNTGlxmHYfVKRYg6KolnzWEAs6ByZfGJYRkYnYLWJBVF1EoUKnZFtjW4c8jzrpxJFG0z3mXyyOEnXyB
X-MS-Exchange-AntiSpam-MessageData: bxv/rPA7bVOJ3euzEfELDHRgfMjMoRK4Vc88/SIZ8hV9fv5ikw0SWwQzodoz6fyRRMFG2DBL0w/OQxLxzH1xaj/YmutO6RQcMYZYiFriWFHOe9is7q3JMxR7INyU7RAku3mTp7dDxB1WRI5wVLUGdg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72733c0c-94cc-4379-464f-08d7e153c326
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 15:43:37.3345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nv6MihgL9KuTCs+NzNcFn/2hI7Pa23w8pfuqbxtBvZn9GpX2VROnafAujJGEbpxQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
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
Cc: alexander.deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 Ray.Huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the amdgpu in the suspend/resume loop need notify the dpm disabled,
otherwise the smu table will be uninitialize and result in resume failed.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 95eb445..7ddaea8 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -895,12 +895,17 @@ static int renoir_read_sensor(struct smu_context *smu,
 
 static bool renoir_is_dpm_running(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
+
 	/*
 	 * Until now, the pmfw hasn't exported the interface of SMU
 	 * feature mask to APU SKU so just force on all the feature
 	 * at early initial stage.
 	 */
-	return true;
+	if (adev->in_suspend)
+		return false;
+	else
+		return true;
 
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
