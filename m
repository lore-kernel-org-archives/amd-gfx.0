Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65889C4361A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C5222AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C5222AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D029E6EC83;
	Fri,  4 Dec 2020 21:31:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCFD36EC83
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hS+OTwI9z4HlsT0M4C7+AspwqHcBcGMN1l5g0Q/joWXHT/0iWms0JrnNjfl/urpPBUXRh063TrAq2ebQ71aXgKfwRQ0bF8VoAkRhcYXk8HNZktvOsTLTun2kp4L22p4Z5BeazI2IG/5TLEMXx3CDJgHKvqnON/5cdz7Pb14Dv68vpqYNy4oLVgXb0hwm4EJuMQVRjwB5wQ4l55+bCwUKOSAngoA4pu6ltTzrv+BStB0D5EeMkuU+Pi/iyhqZNtuSLkrZAgCQeFbOw0qy2bSxUTozgHUUjmb4OMyY6IhWvgs0oxVMA9j+Ed7X1STioWydZkK2yz4ubyJdPQjDC6NXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIGWNiDtkLHTa3Kg3M8le4BoY89WxWPkKubW4wIgpt4=;
 b=LHqN9s//mH06gHxpYvsIrrp5BsNSTi1b/B2ntMqFpNvi3uXvuJGAgZEGXaWH/nIsE9KkLyTfGRURWikW3a41m0g+ae4TCjxCgCeAObkASqG6xxVwZ4pFoF7043SVAo43wqKc/KSM6HIipBoYd3IVu8KWQNJjtHDMWmcdzgNm3Esd2okOS6xmVVLPTV+EfdXn4TdUxBq5Xepe3d03V08GzUq+A8ZiLhitBgj0CLuvMmDOb1Plx2a9+kZxGKSf3r1x+X9sqS1fUsC7nSj8EnTfMDOswZNXf8IZ3l6ktQ+RVFghvCmy0qlNcLhh9QhoLGbjecSaOi8pSbgXZiMKbBxOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIGWNiDtkLHTa3Kg3M8le4BoY89WxWPkKubW4wIgpt4=;
 b=jLmJhnTxTIcthRGV1VGRsfJuPC/YszF9GfuzVstJ52Hs7bZXWJLPMnsf/Ntx2/OpOj+/XJvm3+eFWqr1FWMfSRxQl+cTNhX9WG9W2Gu3ZgPJmF6HyteAiPhMiBt4L0d2+B1+ElM5zSIWbvTul5nGvEFNOXGjACyyVTM9S9NjhB8=
Received: from BN6PR13CA0003.namprd13.prod.outlook.com (2603:10b6:404:10a::13)
 by BN6PR12MB1745.namprd12.prod.outlook.com (2603:10b6:404:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.20; Fri, 4 Dec
 2020 21:31:34 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::ea) by BN6PR13CA0003.outlook.office365.com
 (2603:10b6:404:10a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend
 Transport; Fri, 4 Dec 2020 21:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:31:33 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:31:32 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:31:22 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/17] drm/amd/display: 3.2.115
Date: Fri, 4 Dec 2020 16:28:50 -0500
Message-ID: <20201204212850.224596-18-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4a6f348-d557-409c-caa0-08d8989bf8e3
X-MS-TrafficTypeDiagnostic: BN6PR12MB1745:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1745CD7A776D5F5101142A4FE5F10@BN6PR12MB1745.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0r8BgTVhfp7TjUPmBUosHx6yaNY1eqM9/lwD6GaWSsdxDFErmBPKVcgZhyHhmQRxQ3dzgKN3uJHF8Jt6u1oG1NlMM5EqPMy4T1ldTyK8YxyWoPj0wqk8KJYmjdu/pIY2zeF3yr3KsTelNtpR2VMCtskPMvXBf5MBH1Tga6ti2JQQzYms3f1qijU/ZWtGjjFrQyKWSodHaASI7QrZW8skrJVBzj+0X/Iv5ZZ+tqT4UrSeWxzPwDJ4hneIRYpZ6gbCWzUAHulHgYsNhvhZUFugmczLc1Dh0sqg/5VRlblIPZ8wS0RlLv/g/9IbXaWCbpsC2Sq0plTZq7Ofhh4c7H3hOPkKJSmKKuOq3fH/0b/hVVS33LywyXwmizn4uZfZS2vGHvkyVXPOSkVeOetYJWZPTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966005)(54906003)(426003)(6916009)(83380400001)(5660300002)(316002)(44832011)(336012)(8936002)(70206006)(2616005)(36756003)(86362001)(186003)(82310400003)(4326008)(70586007)(2906002)(8676002)(478600001)(82740400003)(81166007)(4744005)(356005)(1076003)(26005)(47076004)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:31:33.5396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a6f348-d557-409c-caa0-08d8989bf8e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1745
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 54a829f95346..b8f1e2d33423 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.114"
+#define DC_VER "3.2.115"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
