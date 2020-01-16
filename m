Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D49C33CB6
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE84206D9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="prowa1ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE84206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A266E47A;
	Thu, 16 Jan 2020 20:14:35 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750079.outbound.protection.outlook.com [40.107.75.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 838506E2B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB0zbgYgmFHRGdIDdpmdLBfFtO4r8l82HudUvANRnlleX425AGLE56mYlYvJkC2xjFspuar95CSJhRvSsdJggwxhP/+iyWbjM8c/xvd07qnAIsLOr4lYZ7JijeUu1lqCu1mL2VpBgh6CvOyPrvFbyfej3dlnHWLZjhUONc93deg1xMSzqL3T44kTMVpcOjfu+giQdK5mpSKqd4EepFpgAbN33Pf64dnabiMmOIE7teNZO/R/n+RFl5rW0+9yjuQ+d7DFKxR2d5QSA95IEwfXCZIQhx7Oq03/h/9mZ5qenYGN75lVCkCOG7NVFWFWD3V7xaJdKPtwvI8X5+OQ9G/eHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG1JlcYxJ74+Q6baokx7nsyCgZEcgolGVrymniqTErU=;
 b=oKq8/q0bRO2oKr+m6lBoGJZWjMWcalNPDamWWtYKtOYG7uC7VN9/3vEnORrt0dxwtvEjIaGr27DJMpjLg7fDH+m+UfTXta6TRF6u2Q6u1noohRgUNDQuwgqgnb3Z4BSkH03a+aydq7ddY52mbk93IhAufEA7y3SsHOYFrDiP/dK7zjdNJ9w6KmnMOwoHkN1WYOO+l5yNCSHrbtF5J9mHVmtp7rPpxDp4TR39FNGLimrEkiKlkNQ6gShGbxuS8/mEDWi3C/ZtSHh3xvC+TRTiEYhcbEF6JuLvA97Aj1VD23VZkCwjm2FJKXWrrxcI/AsplSLd/+hbVpnBHu8hXwDYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG1JlcYxJ74+Q6baokx7nsyCgZEcgolGVrymniqTErU=;
 b=prowa1iifeIzlwLSa8anDbnxOAZZTcIoy7QhZTtaZk2wtLFOjwrM4oWU5D0UmTNjtk6wTbsJhD4hX+evmGMfyST4CVCMitXMyzTybHksRVQkoYEQNkSZRg1GMvjsktNs1Jh0AbojnU99QRXhfZ1a2D5xyGeDXcS4y77uAFBOwrI=
Received: from DM5PR12CA0007.namprd12.prod.outlook.com (2603:10b6:4:1::17) by
 BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 20:14:31 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::200) by DM5PR12CA0007.outlook.office365.com
 (2603:10b6:4:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:31 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:30 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:28 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:27 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/22] drm/amd/display: 3.2.69
Date: Thu, 16 Jan 2020 15:14:08 -0500
Message-ID: <20200116201418.2254-13-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(428003)(189003)(199004)(5660300002)(36756003)(70206006)(478600001)(2906002)(4744005)(54906003)(6666004)(356004)(70586007)(316002)(6916009)(1076003)(186003)(426003)(26005)(2616005)(336012)(7696005)(86362001)(4326008)(8676002)(8936002)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4308; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e08270d-b6cf-4d28-8529-08d79ac0b212
X-MS-TrafficTypeDiagnostic: BY5PR12MB4308:
X-Microsoft-Antispam-PRVS: <BY5PR12MB43081FA7CA5DF0E67549E62FF9360@BY5PR12MB4308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtUwVhXx6+akGahF60aZAXjX/XwdeZKEeOT1F8uosPD5Gu+wM7cPkPyABWYlYRMVeVff6fotq0dEq37p0Tq1RO167nIEh+kIFwzUv16r236fOA0bgKMHt8Lm+u8/F+7h74UsIWsgXfh7JN0LHs75Hh4kYvyyUmzpXONSFDdJYh0JaD1cgEnbZHAXNOPrbF7GBttuucPBGVSjy1lOLaNJlb2b0mJ8NE0HTYqBGSCeLTlMUu9hKIt2WwYFUwJB6OUNxKuAKgj8tbLBb2pY4PaV+74bvtGcDkKPXQvSaX1i0rJT7Hyawz0m/nccwbJRTkSAWwgDe3/+SGK3T4/kX5UAJS04o7qFnGgk+3hUFhC+kwStHYkJItY0IK8EpHawOZJ+/RXetcG8YA+EeCS3YJ+ife0xMscd/U76CvP1P4pQPv3Ur2KbCWB6cvV2XFUXweX/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:30.7130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e08270d-b6cf-4d28-8529-08d79ac0b212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, Aric Cyr <aric.cyr@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7d31dcb9e37f..8ff25b5dd2f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.68"
+#define DC_VER "3.2.69"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
