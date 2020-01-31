Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8E8C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE732082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4SWUC5xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE732082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E6446FC51;
	Fri, 31 Jan 2020 22:17:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0526FC40
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnKGDBhdQm4RGKr66/YrlKAJt3h0PbNVrOP5sECknDI+raEwebnVqrIUrTWAh5qu9aKfowjSpW1OCJjx0HfeeuPpho6AMmEBTJKqUedY5WOsQzF28IHln6K9+CDdW4wG42whavPIM4hPEQ+StBBwuwuPpn2GRq2/gZosY9RWGNxw7wOCLzj6jo2Gkk39V/DfEOYqH6nYxdIMF8yFAILmGi1HNz9LwoLqXL9l2o2vNijoOkX0lCJSjOZzjqUs1HnNWtBQhnGodG+n75XG8e4GBZAKBrLl6WPpxiJyUhnWA3VEaulFNTW3nYdOZ9BuztQxqzEwuYW2mSHPexW1SQ0bhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WbEG3FJv2zHhi3BLKUrICPCAYUaySVMiCghkP27pcs=;
 b=d9NhE0IS3/I/thRpJ72qbcwziT9hZaNXBvElQQWO2B2vyYU9BeV4O26wV3yiBNiuXcFrLb/yNJo1WnwOfTf4f4Svnh/zf2GyBZOMHZCxcRzX9T7LEXqPwNbUOz7ybcj9DxFMtyKNkisKzeCeNFX0/z63PtTDdq8o+sDpDuPuZhe5rzO3+OOWmumwRAoVZp6enHdXDtPHFdbjjjzfNzTbo73qkE7Vrx5UM4PBquahGCjtq1LmbiPtBsDxmTLvCubCrXvYq5OYzOv5x1Lznhe/RJg+WlA4jlzqDuOBN+xGjK2T3QEEUVIRYtPsioYiOwOhkLK0V9qa7xjjiPTecbXtdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WbEG3FJv2zHhi3BLKUrICPCAYUaySVMiCghkP27pcs=;
 b=4SWUC5xq+LieQmL2FRPtmTcv0iPkRc/UxzLVO9bUAlsZdejC2L3P0DrC2be4OXe2fPJFYBSlA7BlpCJsjA/gGXt985cIc71b5AfULka5Bmsr1c2IHB8hetYPyDLJ9xiUuQM/TRBvTE7eKWLTeryW9K9q3EBuJrH0Eyl2ZczyJbA=
Received: from DM3PR12CA0084.namprd12.prod.outlook.com (2603:10b6:0:57::28) by
 MW2PR12MB2458.namprd12.prod.outlook.com (2603:10b6:907:8::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Fri, 31 Jan 2020 22:17:20 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by DM3PR12CA0084.outlook.office365.com
 (2603:10b6:0:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:20 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:19 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:09 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:09 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/33] drm/amd/display: Check engine is not NULL before
 acquiring
Date: Fri, 31 Jan 2020 17:16:30 -0500
Message-ID: <20200131221643.10035-21-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(428003)(189003)(199004)(6916009)(4744005)(70206006)(1076003)(2906002)(70586007)(478600001)(81156014)(81166006)(8676002)(8936002)(4326008)(86362001)(36756003)(6666004)(356004)(54906003)(426003)(5660300002)(316002)(336012)(186003)(7696005)(2616005)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2458; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad22baae-1660-4760-1e89-08d7a69b56ac
X-MS-TrafficTypeDiagnostic: MW2PR12MB2458:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2458916AF256B51B1984C0B1F9070@MW2PR12MB2458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93uRGrYza+ieTnsaaXwWGocO6a+4wXdTH1zkv3cvMaEL3jXlRZH4BlnJvbTkGUL5m4+2Ef9mS9Ht0qy0GCNiN17xKokxaTWVon+uvAGsOQWRik/u5AMve2oCGVR2MG8FS+EfZ6s+q52nhdJ5raTweUea0D0/6yJUqhe2ABMkVntsddssru3YuetLACZZGSTCI6IN7lrMsRbTX5nUFMxFX0y5jryQDBszNbYKP4VBeH8bzWBSOWdAV077hsc5spyTTR99Eqpb+vJgwkLsqmoneoAxWzcEZzl6YosJ5nTtLltPcV6DD5LCcHMRem+cXMhoHvK+L+aj/oDjuDqcKN8SEKkm2dk4nhq1j4E9MVk/a1OpemSCSmnrxU4CokXPANjmxg4fAaD68kjqfLh69Llk0U8QUHRj4GB7FFnYxxvddYQNLRbnfAjJxHSUvMFfYjtr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:19.8865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad22baae-1660-4760-1e89-08d7a69b56ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2458
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

[Why]
Engine can be NULL in some cases, so we must not acquire it.

[How]
Check for NULL engine before acquiring.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index f1a5d2c6aa37..68c4049cbc2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -400,7 +400,7 @@ static bool acquire(
 {
 	enum gpio_result result;
 
-	if (!is_engine_available(engine))
+	if ((engine == NULL) || !is_engine_available(engine))
 		return false;
 
 	result = dal_ddc_open(ddc, GPIO_MODE_HARDWARE,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
