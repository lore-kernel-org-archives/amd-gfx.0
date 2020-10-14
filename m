Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF12C433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 11:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0072173E
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 11:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ixQQGJih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0072173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1195D6E0A6;
	Wed, 14 Oct 2020 11:51:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4310F6E0A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 11:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EN7MLGQu0D6xHZ7TuSnJaH8rLasEmCasHCUtn6JBfUGd5XMFmrfb/3UPqyKhl8sBeuvd6Lp4dj4ZcfOAGs59+rCAadiW2nusUZKZl3OO4HGlJery9NkziD6nKKS7ScGv3M7nIOIlobTWhdu2M718gYmuhJohAzvCBERPRLnkRbILsp458iHUP4PZeEQPPgD5B8L38m+pjBkM7gIbom3O7l1J5PFGxtmyBsK+z0WoJGk9oaUtkKrPPOUBvDPY+GW+3Fe5dCmN/Yb9EwhtPS+PBbRuYuhk7DRoozZIAzx2J39hzg3TPRl26cwndoIzBhEL24Z69ux4E1O6qOw9oWjeVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3XCaxVityWsTffM3Xv3Sg7JAN3f7aLjVpIMUaFJRso=;
 b=jM8+pvbljWQUnuONPRfyqGZUI3GmfoJbU6NURd445gXbLasGr2REU46dU4k0eST5Uw8dXHhnfPRsx+P/rsVXzVdSIHuiDVSc+9355Pgit8yZ46R0/S2Ik4HaVeDiZ+ihNcBnUBQcZF91Mb7ZEAe0y8tHLe9ECYP2I3o8UncCzIR535QrKPtbVV6/vbzXfcJja5vKaU9AAp3mSaitmAX7HZa5qKPXK5vEh+pT6X3r/tlipu1C5IMWXGyBr1BLsDUZtiPDfPij2hg89XaACPik68Oc6KRX3PDNx+6NwCQ5vMa/nPezRsagpowtnGhioQql1eAvO9h2kuJH4KmoJFi5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3XCaxVityWsTffM3Xv3Sg7JAN3f7aLjVpIMUaFJRso=;
 b=ixQQGJih7lualtjyHSIK2qA3iC8WhiIHM2Bfqkg9j+GGKkoZNhv88g2YXtgSd4R585P0Y/eUVasBr0iDJcXay+ZzCBs2xlOXlFpaZKhdyMtngsGaFutOG4OKBlljkLsWHva6lM/LoyzGEsljw44CIEmcAHkHZtuNYU19j0JRa2Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3052.namprd12.prod.outlook.com (2603:10b6:5:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 14 Oct
 2020 11:51:43 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 11:51:43 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Use kvfree in destroy_crat_image
Date: Wed, 14 Oct 2020 07:51:31 -0400
Message-Id: <20201014115131.6367-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::16) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 11:51:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 378c099d-c337-4a5d-982c-08d870378563
X-MS-TrafficTypeDiagnostic: DM6PR12MB3052:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30528341697510200ED8DB5085050@DM6PR12MB3052.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMZPbwL4ktIxjahpE0hXEdZViRwp1+qat3nvC8IB4edNWq6n0XYbfVmVsNvW8l5l5RuNiEWW6aupPbrHTqI2qWBUso63UxXslRb2YIOouIGQ11WfRaT5tzSIRkLBU4tLT7cs84yd3xs8bKx8SwlBBsvFhM+YSlvMf1YDpm0N3UUdEJuekwBLajiHzOVVBe7L90OVB78bA6ra26YzD3C4RBgtdRpYlb6eJPWRYhsyZSB7rUfzMskxGGM3G8Ex70HWB36iXp7Qq4MYCsemv/Pbv1Z0oD3UUlIKHWqg0SMnELPaEQ48QzqbSBTm8ChukB6wyw0RYjb6OKkxRSAMkYyWTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(4744005)(8676002)(5660300002)(1076003)(36756003)(6486002)(956004)(2616005)(6666004)(66946007)(86362001)(52116002)(66556008)(66476007)(7696005)(44832011)(478600001)(6916009)(4326008)(2906002)(16526019)(186003)(8936002)(83380400001)(316002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: e50KzZ6sIzs28D0MGu1FYSPtewd/S2fCIaSp4PuLIn4RjUfgY9CwcibYdBATOvuUCpRHYxaOm/EFhmJEjZhdkBGkVFPp/TaufN1Y1CtrsYG+WnAacsCmAMOCWlMabzn9wWpE2jtsim1i/i03O038cM+rCOxf9FBWmtrB9F98SdU2mkw5/q7cAHD9VhGp1LnUhy0ZxptZHRLmMWIvQl5T8V5/GDWhGuyDMtB2I0N9Atdyg7Bro3o4ho7gcJ/5a49h9G5YlA8KA7V6UJuaMAYTTXmN9cLT4vXEymupQ3lxxiQa9/5MLG5RJltyLTjwdzqDsSE1g4CQOOEq6peYCQvTG8qQsXPmFmv+yIBBz8iHf3MEbbykDicZyRDMtK6Hoe3IzcEVczqOHpjBsi06Pbv9/gMDCfM5e/IO3e3BJOm5fPfjclr7+830qTibJir79xb7A/jEPbYNeKWvwTUx5Abqx4NQKcqrdDR7g0cWuiR59zsaDT6NTUw1dxK7nLKIpsu9nHs/okungxpsbaaJjYdTnJYCB4+qNGUQipT2FqKlpRlD6AeZ32wqfXaBlADoUV2kcJkBj+P2EsQBDlyMlSJkClhPPCWHH6YjV2YMI8+ladEZ9OeM0ztwvdTtqKRfD/RyHpeIWh0Ot+mMk2AYT6nQ4Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378c099d-c337-4a5d-982c-08d870378563
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 11:51:43.8782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F74dOD6NHdJk2sZe4RLdSA/BlLq15bzQD0iIpjr+ZGlbRCX+RFAq+p1ETRD+bbrCpQKxE8vSZeLWK0XI6F57kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3052
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now that we use kvmalloc for the crat_image, we need to use kvfree when
we destroy this.

Fixes: a522a06f8044 ("drm/amdkfd: Use kvmalloc instead of kmalloc for VCRAT")

Reported-by: Morris Zhang <shiwu.zhang@amd.clm>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 7a071b4f76a7..cdd5032d5c0e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1432,5 +1432,5 @@ int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
  */
 void kfd_destroy_crat_image(void *crat_image)
 {
-	kfree(crat_image);
+	kvfree(crat_image);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
