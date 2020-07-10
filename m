Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E1CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 08:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8817206A5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 08:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0TZqgAHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8817206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5456EB94;
	Fri, 10 Jul 2020 08:21:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCBF56EB94
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 08:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZil9zfWRsYuJvQliqk6wKjpWj6GtN84bM/z76U6drJQwEMdkW6ZwrhiZvxKmYlYGEuJ98OlhhyqSM58uoSpMGmUoECBMrN7KhLJrNRFPKlFaHdlRH0Qxqjtelb8BALXL/WsR2Gv9EmJXlpZQFh02EsgDse8/iU6AszZUnEhlQ78ZHjO3vyWE9pMYSrQLtNfbDt3aPeY/c8+STxBPJMvXOap3CLsrAe5Nxd7pqLk6qPU78a+EjONI1dRduFyx2w0BNrXfceoCmSYkYRmTSwBRTePoX29x1tN4WwKSVHsZ4w40pVMswCmHQBvStX1Zdzlboqk7UfT49zZpzDWK1TStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7zEfq0WjveegVx2XTQG4PO6m8Bs6i2pBUKnDSYm7Yk=;
 b=gEDjsLTO6yL/oG9YjxDbQYb6zdFaVxY0a/g9i2iUUutUBfyySBUFNKlfrDw5bj5xOhWA5hiUW14RG4ZXweb8X8IOCu49H0tStQSB4c+sZKzbQXI18tUhWtjnAVb4vRQ8ik5vjYESdHK7uqzC3hr0pbkYRZ1cThKOmorZPfu93VzklAhxnj22KsGt+fPUR9GSgRKxyThx6FBtZg1ClzdC3j6jz7VI+BHuDdPAgx/1a/pA7xedcmgptf7DZoTY7h5p8JxVBcCvBacjswAmV/ARvoXIpmGcUzerIusoa3UUq2CGOQfqQRRIfY1l1YT1y3K3HNB822S0fr7AhY8OdZjjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7zEfq0WjveegVx2XTQG4PO6m8Bs6i2pBUKnDSYm7Yk=;
 b=0TZqgAHcXWqnD3eIJyDDgjYhtow/1zSKmEDLOWwjEunANw3ORgfNlj8xWM4groO0abn8EjrcoViXPtOrVdGjHRB/Qj4BFIzFQQK60LIkU94GJUmh4GEmD4Pcbc8xe+cQ00parh5AzkjsfIMHxFL9jn747WkRfud3fAmbDZX1rkU=
Received: from BN6PR10CA0023.namprd10.prod.outlook.com (2603:10b6:405:1::33)
 by BN6PR1201MB0083.namprd12.prod.outlook.com (2603:10b6:405:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 08:21:23 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:1:cafe::b5) by BN6PR10CA0023.outlook.office365.com
 (2603:10b6:405:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Fri, 10 Jul 2020 08:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 08:21:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 10 Jul
 2020 03:21:23 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 10 Jul
 2020 03:21:22 -0500
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 10 Jul 2020 03:21:21 -0500
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay: Target power profile mode should be the
 second parameter of renoir_set_power_profile_mode
Date: Fri, 10 Jul 2020 16:21:18 +0800
Message-ID: <1594369278-7808-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966005)(8676002)(5660300002)(36756003)(54906003)(70586007)(6666004)(316002)(70206006)(4326008)(86362001)(6916009)(26005)(8936002)(478600001)(82740400003)(47076004)(81166007)(82310400002)(83380400001)(2616005)(426003)(336012)(356005)(186003)(7696005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 683a9f19-3034-4d13-a2b9-08d824aa3b8c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0083:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0083117CE263935BC7569D8C9D650@BN6PR1201MB0083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXs/O3Ue1I6TH33Z5nR0A5A4tNqiq4+KMQapbo2EH66ou4pwKKYtAYWR3QH1ugcypkJV8N1XU0YdjmRq409zIZ4AJNXAvD59HFuulC1LcUgOgdN8C5/RYfjr3jyqsiHfpRKINhFaEm6Wm0W8BeOeLo92wxPnePKqSpj4gGLLG48V57o9MYMHTQR1E44RAvUqG8jNPjmnAj0e21R2cn12h2MTtxkf8LvaZ8q0gkc7vhh3inhX3W8PELs4IEShBBEny0SuvRzVikEvWMk7dQOGIlt84xOX7bWBdAYEXR629kqBNrjbuUB066v1pWUo6Tj+T/qSueMWNWYLaJ2h/2FnERvp6UJWhGgZxMvkAqrBHpvsuvfVnb7xPVYAYSG4eYxPI0Ykw4VfhUTlAjdXnOf3Rg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 08:21:23.4598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 683a9f19-3034-4d13-a2b9-08d824aa3b8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0083
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
Cc: Evan.Quan@amd.com, chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A small mistake

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index f286c1e..ae87c46 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -683,18 +683,18 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 	uint32_t profile_mode = input[size];
 
 	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_workload_get_type(smu, smu->power_profile_mode);
+	workload_type = smu_workload_get_type(smu, profile_mode);
 	if (workload_type < 0) {
 		/*
 		 * TODO: If some case need switch to powersave/default power mode
 		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
 		 */
-		dev_err_once(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n",smu->power_profile_mode);
+		dev_err_once(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
 		return -EINVAL;
 	}
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
