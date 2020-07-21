Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F101AC433E7
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C697E20714
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q5bBCGeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C697E20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 823126E122;
	Tue, 21 Jul 2020 10:29:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B8B6E4B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 10:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gf/7Bm6xEB8Xjfda2mpQjOleMTWtMSD8a02nfjeU7J5bSrot8OTR1knz37ixMe5Zmq71PkkeW+c4LwwiI2kZAONF3rrpGXuNgYauYWcFt0hUOIqinPJNSE9zAOze/H6FCOdTk5jGIiIRGc8bGJdTsp0cErCEDdwD2E2JLtkAZRyrA16WPBLLi8G4ZAQrGXYcsszohUuKfIGnGOzhTP3mVDrNEuyUBYU2rIqG8Pf7SQD+73EPsAn9AE6KbepyN0hL9ZXVZn9e6PuF4GZvvKsp7mDdin7VyOIVC/lLykJOJmSeH4/eXGX9dAbzFLkj/7mmR9sqGI1fwJyxXb1Rlhn6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbAdMARkDEE/wkH7oobUkTM6EEbGgQSfgdHkV48GAhI=;
 b=BLM0krAx0micOjH9EuOmXozcdYENJ9XsCIPJ9jHyil08gLkgESBLQ/qfNBgE2YxxmTi/1+zwS8v/JjKE1UgV1fikL9EVVedwh0y77WWN66Eca637O1xOEWwl4G6TRBmdNa8U8oEXDk/rzkS3nHBuJjMAGIZo0FJ213/+WViyal0GGZOactUuIjD2sFlxtN0yXnQAorlyFfFqbVgBwwgPte9aM/WAEzGmKtXGPWY9qqDmdxz4YTrOE2hz1qruxU2WTPBe+OKHOmRxFuq6BdZ9RX2aO6XE4Ygx+4Pt1YnJaR8OAuUNu7K414INXTRVC8SpsIICz0KfFy9VYd15Sx64Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbAdMARkDEE/wkH7oobUkTM6EEbGgQSfgdHkV48GAhI=;
 b=Q5bBCGeHz/+3aGIeZjkQSXBcOuOE0kWODe8CXjkGaznTP6ICjKyyq3n5QUSN2yrN8k/u045LX7+7PnNL2DV3C8VivN++0N0NWZrPJg13s1DyXpFd6i5EOTrqSCMzVVvc/zyKq5G3eUC47fUEL56ixP5LZaIVMQn6NdTlxED4knQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 10:29:44 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3216.020; Tue, 21 Jul 2020
 10:29:44 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu: won't include gc and mmhub register headers
 in GMC block
Date: Tue, 21 Jul 2020 18:29:19 +0800
Message-Id: <1595327359-120379-6-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
References: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
X-ClientProxiedBy: HKAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:d0::18) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-intel.amd.com (58.247.170.245) by
 HKAPR04CA0008.apcprd04.prod.outlook.com (2603:1096:203:d0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 10:29:42 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9fd0745-5b9e-4b45-4758-08d82d60fba1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB414459E51CC24CBD6EB12CF9EC780@MN2PR12MB4144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPiiHAAl15pcWp9ofNsOh/MgAYO0V+AXqjJZAzE7OWSQ2WFHVwhA+6wSbrr7rFvtEZkXkIbNebswuh55cTaYRlrAp1G0D/2hYmSZ5w9KTrjeLY+Vi9KbgOdpuiXb+Ooi2jAxrubpv3KlxoICtclnTNsaUAEDo7cNmcH9E+mbGdOxnZbvEBquCBnjx8GIbJ+bvXVuxY802zzIosrBXv2+FFVrKkgo+CBlpNLUcntowT6Ndyglpz+JJB58aEug/stHgXYNOfyoKNrTaP8aJZl4+uwJzv8sOugv8cPSfkGYYTcgYJAF8vDKvanCNL7yzWYARA7YxuW4393VOFtMVgv6mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(956004)(2616005)(7696005)(26005)(478600001)(16526019)(186003)(4326008)(52116002)(6486002)(6666004)(2906002)(4744005)(66476007)(66556008)(36756003)(83380400001)(5660300002)(86362001)(66946007)(8676002)(6916009)(8936002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DqYQz8z/YkU0eAqdu1TOIuhjgKgc55M9V/qsqU0R90mPXMHPByjim9Hzuh5+3aTVW1Vpmuy83FI82uhtqnEPIH8VsK/rCmrhBGgIFZP1X/zlAoHVHK0aVeemYTLB1ffNpINvouFo+IhUGeI/4TTy0APVStGr3419+4UiydVvwG/mzSJmbjRHE+ACr9xV/myNcKFoYXVNRPBCnUemUk0LEt9pW1fPOkqtcdskm6oZg4WZyOby0AuRZ7owMMB6XUwO9aH/7XMMqHYsS6UNmy9s82t8vTzexOAtyIPIPS9xicq+xUYFwlUFysAV40Tg5ZmBjnBR/4MrKpuLMUFpeNhpcaA+f/ahYCUlWLcof2Vb47aA1Ie3iw/7KWqxQb035qk52KfvwGqM2bmHWeptr5C2hnJgGv6Gs4OEytb9T5Mo1x0DupGPAjbWls6Mke+B54cQQuXmOJfZSbKVisJGEZrkuvPxfUExNFoN3E7ln7Ikrw4xmeudwpYT6t0bIKQOUR8v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fd0745-5b9e-4b45-4758-08d82d60fba1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 10:29:43.9403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuMN5G8kyM82t/6t+O6860qc3aCd5PCtXUbdaiVIDQdAa0TrTaKwHqIIzm2jBrxfrXQIUbyzG5pjXMKuct088Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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
Cc: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

All gc/mmhub register access and operation should be in gfxhub/mmhub level.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index a1798ec2..19051ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -28,8 +28,6 @@
 
 #include "hdp/hdp_5_0_0_offset.h"
 #include "hdp/hdp_5_0_0_sh_mask.h"
-#include "gc/gc_10_1_0_sh_mask.h"
-#include "mmhub/mmhub_2_0_0_sh_mask.h"
 #include "athub/athub_2_0_0_sh_mask.h"
 #include "athub/athub_2_0_0_offset.h"
 #include "dcn/dcn_2_0_0_offset.h"
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
