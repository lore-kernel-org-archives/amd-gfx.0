Return-Path: <SRS0=M7yn=F4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BCDC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Dec 2020 06:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9BA22AAC
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Dec 2020 06:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9BA22AAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF668961D;
	Thu, 24 Dec 2020 06:04:55 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F8D58961D
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Dec 2020 06:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+5/pq7gqQ/4sxrLAwyXnPUXRb9C5hyUOurWGpFM6MrNivJhufO+gVzKy819WV08yEzN2b6poHDtvPtQvT7diKIKRggnpMbrmgh9cRjdg0aiPaMr+62NgznURTRPdpJ0r9b0biZbfHQ6aVX6XQhMvuKx01Tf5vaUVadcTFsWeIPrSpknFlGtk+6B5fBSESbQLPN31i9vbLlpCMYOpww61POeQfoAm0YjM5ioX3Y7IINq14deTlZ2eCGFWnt0tjo8zOp2G81gFy83JUkAgGAQgnT+OD4RIgxovEJU4z0gYJT4hrvAP3JFsZy+o3mE6+pWd/HgYNQ7IYVQj6r0tE8TGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmLAWPDLhQiiUKSZ7g5c/90B9knWDmcfvOZrFdE2eak=;
 b=hlngJYilNMclyrCAM21Fon482uy+a+gm/+2wCsGBpirVQBa27jUod10SvAv2NuUWwysjryHpXCzpfglW/rrW8CKTuW/yJSg/u+ms6PpbdxQpNBdb9MFtRus4hjasxiOkdML6OtVblApTHoKfb6eV49OhMGIhUef6krsiHMm7onCPDE0A02ZJbzvM9wdEwPtdHv2C2m5Lp0ILOJbhNhK1RFwuGL45wED/WlNzGEeketz4l3Iu7B0ZrV+syxcF02bj3aj5O79Vvj6a8ITRVrwcmeFfakmi6KIocLQwDxlKlWxZgL8l6EqWJjojesqb8actgggG5eFwwP+sQwDWk5KmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmLAWPDLhQiiUKSZ7g5c/90B9knWDmcfvOZrFdE2eak=;
 b=cSOxQ0HRJol//uqp74f1pMpALnhdpSYwVZQiJAJ0h7KXrfIyqdVIDd7fgs61MYcIoSyv48m+K4WB+DZ+WuAvZ15r2KTg7Zexp3Tyuc80anMTsxhxhRgPEmofl3QZ9Jmv+btr/j2KOQbv4l+jmboKMuaCyioh8GoST5FUEDkK4K0=
Received: from DM5PR15CA0054.namprd15.prod.outlook.com (2603:10b6:3:ae::16) by
 MN2PR12MB3888.namprd12.prod.outlook.com (2603:10b6:208:162::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Thu, 24 Dec
 2020 06:04:51 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::1e) by DM5PR15CA0054.outlook.office365.com
 (2603:10b6:3:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Thu, 24 Dec 2020 06:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Thu, 24 Dec 2020 06:04:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 24 Dec
 2020 00:04:48 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 24 Dec
 2020 00:04:48 -0600
Received: from build-u18.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 24 Dec 2020 00:04:47 -0600
From: pengzhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: reduce the full access time by about 50ms
Date: Thu, 24 Dec 2020 14:04:34 +0800
Message-ID: <20201224060434.18144-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13d49b35-e18b-4198-6bcc-08d8a7d1d2a1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3888:
X-Microsoft-Antispam-PRVS: <MN2PR12MB388802494DFE0E16A3DE216EF8DD0@MN2PR12MB3888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Q10Hau6o+NPG7zOINjHAa9AVrxp6tNe+KsHXklbWjGpu0WNDkmsnITwm4bMYIwdQRCu3xxi59O7k57NJlmI58HzfQMUwje8dJxS+Gnki4idOdE/FrlqBUpl63PDPohSDPJpHGWFcfgbevm81wI7oem+MugBj06VaHe0orz6GKsgRfHO090TSHndMuKFsOimQ3IXDD8TeFfdpcPaTnDNwf3hVADs3eyICxl79Piy8zlllvZvUT91fPZkP/ff3b+xD0I4s80r8xPHCUxrty9iAM0WlEte7mgQ8ePSFEmJr0rUL2vDuwfb27sHIc4CCBh+2Lj6ldKPsZDCwwkjq8sr7labu2jnntPCNb6TifJ0qH6mAMR2W6w1RUYOoQ17ig1MT6a8dA/qciaAh/UquarnQm8ZbEfOLr6lB8gEQ4Omozvn4YY/qgL2RqfPfRshbKWap0VSr6YBkxUtuavNKma66m5wn8Xx9huf1BRbJLHy+yo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(1076003)(6916009)(316002)(47076005)(2906002)(426003)(8676002)(478600001)(70206006)(70586007)(336012)(4744005)(26005)(2616005)(186003)(36756003)(6666004)(7696005)(4326008)(356005)(82310400003)(86362001)(81166007)(8936002)(82740400003)(83380400001)(5660300002)(43062004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2020 06:04:49.5713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d49b35-e18b-4198-6bcc-08d8a7d1d2a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3888
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function msleep(1) can be delay to 10+ ms sometimes,
which contributes a big delay during the full access time.

Changing msleep(1) to usleep_range(10, 100)
and it can reduce about 50ms delay during full access time.

Signed-off-by: pengzhou <PengJu.Zhou@amd.com>
Change-Id: I151a07c55068d5c429553ef0e6668f024c0c0f3d
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 523d22db094b..ef69051681cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -282,7 +282,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		ras_intr = amdgpu_ras_intr_triggered();
 		if (ras_intr)
 			break;
-		msleep(1);
+		usleep_range(10, 100);
 		amdgpu_asic_invalidate_hdp(psp->adev, NULL);
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
