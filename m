Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D951AC2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD3C21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H/Na0yB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD3C21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B8116E347;
	Thu, 16 Apr 2020 23:41:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CE06E357
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfuPp9L6Rmj6vGjjTHOrX1Pgl64uq4HquYYBKyz2b4OjshgdRienIZetawv3jW1qq/PEQSjvoEQE7NsQHd7kDrPSL+tx8bvk0muU1qMMp+TBhWlUm1Fp5ysaZ5+nz0XJ+SOJdxDkgUTBcqwun+xbfnsL1fNICIEO9/wa2qxWpl5nletGNcy8UZxDCq7eVtodnuddjJIyAM1VeY5pYO/ApXnDGvxfeo9hQ/z2U8YAS8AXmXjVrMhFU4iSnTz2r3RKABqnVFn5VT656BkWqim+tGcs7UEr/wS0SZcQXaLLtUMpbsa6rKW4DkpDTrkgN3hglAMyaziUahezx4XJIKNyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTF+pGUqpByw9q5NXfhQ69iVFCCmyVxzuyuO1XjYHCM=;
 b=PCAFs9R9h4tVk9jxSgvSb2AiIvV0VowSRJzjt80O60/3cWcZjcVO5sCGlIEZpWcfTWXm0YiYG2kksJI7RzaVfEqfvf3dQffPFeILokWxkIvyQ7TF858RbVxhqNdcOTIALPZK1UJs/nybSGcO+iI4rGz0YEbTIcMFDjilRarAuqjBrOuRtKN1KKKbYVk+A/y7ktOn9WYSptC3TEAAL/WtX+5o7MslkNv7O4wBVLe7rFCi/EfAKrKcBmvKCLCuRQ1AChxj0LYrsQ46zeh3k686Iv5m2qcH4OBAAQsB0pxsNJ9F+16qQO5A+dsQ5IFfCKtrwg1ewIUrQ8dNpdMNSxPb/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTF+pGUqpByw9q5NXfhQ69iVFCCmyVxzuyuO1XjYHCM=;
 b=H/Na0yB56frNoNdOIz9AMmjIWJKZL4DJseBONST9584aMVnSMl2nVMtyQI5Y93l/tc2X3AkeRuMmkk551SnFn5ULQF+rum1tTpB5eGof4s164QjYEQKK0ZXHOzPxwE00lIBCut0YYNdsqqGvRwt8WSS5PzsJ47WBXZjHjZbu6Hw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:46 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:46 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/35] drm/amd/display: destroy panel on link destruct
Date: Thu, 16 Apr 2020 19:40:35 -0400
Message-Id: <20200416234044.2082886-27-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:45 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97e290a0-b3a5-43b7-3a14-08d7e25fb99e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459BC631DD5F33BCF5B2F9898D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:47;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(4744005)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMkA/lgJAsLp2ljHsjpRQKMWd//i5Wiuv6IQTAcFeaQPTUMoXbU4QESTR97hscrBDC3HDD27x3ECnwuGb/RD7U5e4x3sRhOvKONdnrkEZmyFBhU97lajDVg7gEEU2HuME9/x4Kjg5ZZ7W+SF/oTfiUxQeEwKj1aNC1doKe0cqDxT87BRCoRUQ5vBdiRJ8YxOHjEyyufdRwGPjweQKiUJKaazPHm0pHrYg64874igSvgpsTM3nApfj+14gpe/ggta3RbbtQsQ2TfnItbB0GUJ4FrC/grNJqLG4xeDVTsylc0NUxezmhcL+nbt4bakRGcNPHjS9gDGks0fHLI8CA/JmRoG2MzHZAwv7qiU5G8unoTuV2og+hvpFViR1NsbP9sK3Bv9S2bGjJZ0VjF/nqfH7Zuk6mhwesZiUnGjWhyQhfg9nReqsYcwktP7wbAZpSCo
X-MS-Exchange-AntiSpam-MessageData: UxZ7B8p1s9nxfZnve9UQxBYTsETKssQUj5k7lxTBT40O3YYKnuPQNcopt+lvtRgtoeSmDKcj/m0B75oi0hFblGBGqgcTEyMJeS6t3E/pY9XxzyaIoKpg4Vk7kWyUMjCXVuAl5Kq7DkJQb0zH2q8yBwNTU1RFH0nvnSaZy9L0blk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e290a0-b3a5-43b7-3a14-08d7e25fb99e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:46.3287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czN7cfVO+9e7C/RT/nYXCjj440QVI1UbRn+ZuyHjz94swh88hKaoxcyXuKefk1REs5mgHFSZYyDN1YYLm6Y8PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wyatt Wood <Wyatt.Wood@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
without destroy it is causing a memory leak

[How]
destroy panel on link destruct

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Wyatt Wood <Wyatt.Wood@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 2e5a97190ce3..b38abd0c362a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -88,6 +88,9 @@ static void dc_link_destruct(struct dc_link *link)
 	if (link->ddc)
 		dal_ddc_service_destroy(&link->ddc);
 
+	if (link->panel)
+		link->panel->funcs->destroy(&link->panel);
+
 	if (link->link_enc)
 		link->link_enc->funcs->destroy(&link->link_enc);
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
