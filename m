Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA585C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA25F206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R3jpCFCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA25F206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590EE6EA0A;
	Fri, 24 Jul 2020 21:08:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE6156EA0A
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKOoa6gL/5sAculsPc18Z4/OgkfospPp+eLOTx8SwbdgkDbXr8wD3l9btA9hCgZzKX6j07Ber99BjxSZoCU1bx7zYcssZ01vDQiL65up77NL55og+sixrriLX4S/MMfj1geHIrBCTw/u41qenYy55tcwL0PFE0r/1rXAU9n6+q05oiF0yT1BNQBuFaRoF8yTUgR1e5gvtFr+05XlSLQUs473/Y3XS/dqqkeNZiKYP0tvwD4H7ZBm00tEFgNFOKhej1MjLWNApKvO1IiQm8BgMoHB6SQ3ersAKvJdVxF5rEaO0YvQlSp4KX0QkGhpxH3S+ZbrzZlsX0iIEwsxM4yf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgXK1zONl8D2DI+AgqRmokF2X7ptlP3lCcKfHCsA7QA=;
 b=fHnnXRrBqC+1KtXeKkJ4q6J7loZW00hHnqgE7fvHIdUy4g39LdiMs7mzQUwd4n+n6WGavlZxkkFCxVBS7lXp3tz0JN++RmLJgXmHqTdBAJzU4DincBx26SOh3tMMkrfzwvhH0NPqR2KL8qQFVnmBz32n61W9D2c4Peh0rIoJg1SyvoNXx6bHbOiOWKggzqRJVSINjQvkew0mtqB5td1R02C8SFTaI/6mb7Wzt5kHvUrMhrYFQs4KBawT2Bsai+zfzzg9tzHvuse7z3LX3s6mBkcbJHWMTQpdLRJeEv97TB4S2xXfY8fDZmmnZeUZMVDMF+Y2w5ESQCUtDFAqhkfeCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgXK1zONl8D2DI+AgqRmokF2X7ptlP3lCcKfHCsA7QA=;
 b=R3jpCFCg/ugFFpBDp1HGyc77naFqRkd5olwvpiz/Sqzb0/GEHPE9EPMdyYcKlsosvN3LJLHFFIULzYtaftqodEQ82n7/yksjlLsJm0wYujrOoR69z9cdsF26DnRHw+LvWgM9E7scy+vmhiTvpbkshPcUhMYWufzRkdAu5bLAJRI=
Received: from MWHPR1201CA0021.namprd12.prod.outlook.com
 (2603:10b6:301:4a::31) by MWHPR12MB1197.namprd12.prod.outlook.com
 (2603:10b6:300:f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Fri, 24 Jul
 2020 21:08:29 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::eb) by MWHPR1201CA0021.outlook.office365.com
 (2603:10b6:301:4a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 21:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:08:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:08:28 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:08:27 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:08:17 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/15] drm/amd/display: 3.2.96
Date: Fri, 24 Jul 2020 17:06:17 -0400
Message-ID: <20200724210618.2709738-15-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724210618.2709738-1-eryk.brol@amd.com>
References: <20200724210618.2709738-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad473fb6-6655-414e-798f-08d83015b70b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1197:
X-Microsoft-Antispam-PRVS: <MWHPR12MB119743480D502F3703646363E5770@MWHPR12MB1197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/QLD8QuN+gVkGDPGIn4VIRTy1ozji2t8B/tP4QsG6xzPwExJO+Z724BQOw6DYdnzr4nnhKZSStvNBaqTtfOoPIcoWc6D6ISElu9R3E0+z0qykiEfoic05LIIMma/EAaLPwG8fGlp7K6kU4WH/XHAmQEwsjXMWOaFGjAedJ8mUFS/YyEdRGSBjGCZrc0MuPVnBvQ2CP/lMAtUan6KanOqyBAgUIMvVqeWee9EbLT9dt2JEtBzEPU16T/8aJ/q/wfbLQOLwRMYpJX5cpVLVV8yJ9C9BcnoAQyMP9iGiUTFIQaWQ0W9HtCLRWpavJQbvZtj2nY7LU0pa6lqyPIhvtMU4DHKRczfDGI1IkUpaBZ91qIXmkd/hjLNGNO1X81Ce1eBsDQzIEDkSp7VtXCtyt06w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966005)(8936002)(26005)(4744005)(47076004)(82740400003)(186003)(82310400002)(1076003)(316002)(356005)(81166007)(426003)(2906002)(83380400001)(54906003)(86362001)(70206006)(70586007)(4326008)(6916009)(478600001)(2616005)(5660300002)(36756003)(44832011)(336012)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:08:29.3915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad473fb6-6655-414e-798f-08d83015b70b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1197
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
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
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
index f50ef4255020..ae0e27c67ef9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.95"
+#define DC_VER "3.2.96"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
