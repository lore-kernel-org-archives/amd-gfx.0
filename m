Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6E1C56201
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 16:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC62A22269
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 16:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tbSjM7wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC62A22269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24EEE6E93B;
	Fri, 20 Nov 2020 16:04:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770085.outbound.protection.outlook.com [40.107.77.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D07756E932
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 16:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaIqYwpm6N/aJk9Pfvd204PlP0g7F6f8vBSC1aOaWuT47h9yhLzJxRjAF57RhjMECilVgATgSowEzzTtHv4kM2SVL/fAxFZN66gZwiTEtq/LhRan0BZFITWv6ESwqDGHa7ulFt6Hw3FNanzFB5ws956O466gyOlMq1ctuvfrxMXTCvTv4K4lQt603FngqnVHWs0XYaCYtSdGS50FtfdhY1mttl5z30iyhPgqcmgyQS7UaI+WHolDa5ASPFYCGeCVBD2Bky8YoAQvyoLMH0fDankX33XydTKcMW1fTOx6eeiwM2jBxtKRGRfb+AvU7frrs5FQfJtSec9/HY3EMuXEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocADUU2XxMKu/voC8FlEQI7vXxTkfBeprtLPtOzlrg0=;
 b=ixtOIpWnHAv2q0iDWKVJGvS8z8hDzFBWY6578f8oDPMBXIGDHo1rJG0KOfPExkr3G6cC25TOwJwoM25ChWnWCFxnTXhJfbTBD/uabOrXCgwdHMiVNhqZx+EIpt4PTY2Qqufz4aPFKWwVF/3pdOnk4yIKn0m5AOjnma/BquUnGv42xfwN3NyuPZ4qFA0e4H1zrkRzDm6QLeSURsQBace5p4VvkmaxoC9O9ZFWNCyJQBNRrxEzLBol5+cagTBUqJxT9LxHE9KgCuJgQC9gnR9rFaPjjkeB5dYk3oFxwud4yklQEItbgdzKCtK+K3EfKSjy8GGlXUJUf+BSWf3BYjvcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocADUU2XxMKu/voC8FlEQI7vXxTkfBeprtLPtOzlrg0=;
 b=tbSjM7wt0h9ZHFIDBISCnBu7iyCQ7rMYu1AaDAkeqYBee3xu+AVTdxpEcZymFKChskHvxUdYG1clOhGuAjxJRndYT3EOI4DgmSv9BPElnRSwXg7CWW9cRoj6ysQbRcflVBntbzZgavXnls+co45atbC7art8iNm2vWe/Fa75Nm8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2454.namprd12.prod.outlook.com (2603:10b6:4:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Fri, 20 Nov
 2020 16:04:39 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3589.021; Fri, 20 Nov 2020
 16:04:39 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/radeon: use generic DMA API
Date: Fri, 20 Nov 2020 17:04:12 +0100
Message-Id: <20201120160412.48148-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120160412.48148-1-nirmoy.das@amd.com>
References: <20201120160412.48148-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.122.114]
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.122.114) by
 FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.13 via Frontend Transport; Fri, 20 Nov 2020 16:04:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c724cd96-650f-45f2-1ac7-08d88d6dfba9
X-MS-TrafficTypeDiagnostic: DM5PR12MB2454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24548A9039460484B9FA2E868BFF0@DM5PR12MB2454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t39/wVSJOCqsOzME70W6tiVB/sXNlQ5LvobT64lApPtOFlr9IewU0ZgPi1j0pTz+dSJPR7bHV6k4Ul8kIDLjeM1q6m5Txp5ITwKoJzsZvAJIXjStpZnHiNz25oL6xQtgB3ATk9DsCNOtCTrlh88Rx11wozliCb0/HSzQTL5pDkLyfKr36SyojKmPdgoGH8kq6UmGW0SiYhsgy64qjx44KYRMUuFWm+F3djuTEwfa/vBoJoOgg16TrJrA6tYCdER6PjTX/VBEgRcBLmwE7FMfLE+lSMG0JDUn/Lo6f23MnWwlUs1UMjhmOXv+ivRHkDd9hynZudTZok7XZIUqwzpdlWOVFIZIuxRjJhwY3XDeT16k7GADshU8Pw8PiKse6Sm2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(66946007)(26005)(186003)(6916009)(6512007)(16526019)(66476007)(52116002)(6486002)(6666004)(1076003)(4326008)(83380400001)(8936002)(6506007)(8676002)(66556008)(956004)(36756003)(86362001)(2906002)(478600001)(44832011)(5660300002)(316002)(2616005)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uLWFLlq12tkMPcjKiDMNqzkVrB+UrU0Zi0oFNyNJGb9gry1Roz76e2cOJkm+tCEnknsXeh/qetBqlPuO1mkGYcxnhOnQYRA9lVkiH89QmH4A8MnjHFOShFQReSXBxx5jGW1gwCHI6y+Ec8jmqcqMksWtU29AP0FoHjVXu5MY6EHf17IkOl4ZJg+oWHgKcimZtoJ181wt9I18/w92BQ9vj6UTH5eh3wYE8BaZ5W1OH11l4VRrh48pM8c9eshBe1lInjFP0Sjd7G6As9dhmjOd0BBObF1QHac8JwZTmyrywgnzegKDhLcuy+exC8D/VJta20C2FWTbdgZrjj4s2zBJFH1sv5LRId4x9Icaw6kMxvbIznSg7CXOsJ5wHUHCY2rzIm027hhBH7aJx/E6wtygOE5OW9ld1fS0Zb8dFey64bL4rcJWYFWPYLKCdfccCQsmivT7JA689al7132/F2nIXE4RsGrxGu+In8Dw2yAN/fCpgDcA37HHuGysiozDbKgYs6kqmLanDj+bl4N55N7PQh7mOfsgk1p9RGHE/bzodvmD/c0Cphg7dq5QxssVw6pHD6J0iW90ykbdds9g+a2XtpePU9COB10x4FgGU4OfSEvaakzj/R3k4JI8+ggyH+ECFS3widuI8AAGLvUfScmZFtZnD4lFCUExOkUrS4AeOPeZR3NA72llX1a44wqj+9alxPBoOgBa0mf5zdJgDA5WDS2jVDaBO+e++hqLpGB6EjNwLBGHRnMREtizegcRdum2KZt8zYHu7MJ7f1BQY1DtoZ6apbE/nojJmDZna0fyqqxnYabUwWxYIiwLDbwIfZ3jjETi9uUMrawLssJnd8a7YshV/vDG0A4U1JfuRiLU8mDIPWGsq7jQPA1HMbev/PzewFcBoIy/iKTwwcN2dJRONw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c724cd96-650f-45f2-1ac7-08d88d6dfba9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 16:04:38.9268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qT0VwAGKSeqxK2qyUI3rQQrHTYH0K6jSGm6gEJjAVt0E2hB40V8EOvWTgeFIij4TCjs7fdfrZ5Q3s1HdOatqcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2454
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use generic DMA api instead of bus-specific API.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/radeon/radeon_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 7f384ffe848a..a5588b0a454c 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -784,9 +784,9 @@ int radeon_dummy_page_init(struct radeon_device *rdev)
 	rdev->dummy_page.page = alloc_page(GFP_DMA32 | GFP_KERNEL | __GFP_ZERO);
 	if (rdev->dummy_page.page == NULL)
 		return -ENOMEM;
-	rdev->dummy_page.addr = pci_map_page(rdev->pdev, rdev->dummy_page.page,
+	rdev->dummy_page.addr = dma_map_page(&rdev->pdev->dev, rdev->dummy_page.page,
 					0, PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
-	if (pci_dma_mapping_error(rdev->pdev, rdev->dummy_page.addr)) {
+	if (dma_mapping_error(&rdev->pdev->dev, rdev->dummy_page.addr)) {
 		dev_err(&rdev->pdev->dev, "Failed to DMA MAP the dummy page\n");
 		__free_page(rdev->dummy_page.page);
 		rdev->dummy_page.page = NULL;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
