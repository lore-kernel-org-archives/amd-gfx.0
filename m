Return-Path: <SRS0=eRNB=F5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33C3C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Dec 2020 07:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5974322AAA
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Dec 2020 07:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5974322AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C616A89B46;
	Fri, 25 Dec 2020 07:02:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB6D89B46
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Dec 2020 07:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oK4gbMqiGvFn75gDF5tigtjhTFAIikMPmyuY2wK5/dnAz0YRbXUcVtIRhNPlHpXG++mz7UHssXnd5bcUtkUrq6ZVT+7JEb8NOPlVz/tkfeelJFS4SIfMSVT6bluY6K2WI4WeuUoIKz1AfucAcLtdVZyA0vopCwgm5ZFsT9S5FpOnUmBRRrQ/3wj33joHPpVaZIXqfULKSWi+hgHdt7FmULOMix5A3lEDvo+xIWtl6zZbY6oFU2K+SSAEEYq1lTMU+msGVdC6LfG5PCiWqkWPGpKe4nkD23nxE63h7sCTG0F1+mcb+9Euvot57zGx8/9olaWaIWp8fYXdUkFq1HK0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHXijRPtUam4STVXywx1lX7hngMMBIMR0jLc8okVY/A=;
 b=Ia2/axs7O+F/gsf5deHUPVfepzMHtwMKiDGI6cV8d1PkW5LA8a5OoTQDefWKyat2DUn/N1IIVPpk4o8bQvE9BdjeMRz+YL/vu9PCn5mB0o0ixrIfSjTxj9AW4nd431LSnfx6EFVrzcLGDSpS+czHA0qJnnIsGK8ebIS84JdRDqOssX+eaYk/GnYvKpCM2HX1EjF50lDdh9tcGD0hDzFXpcGcvmrmk5o1097OKRhfpO0irnc7OzCzptHSSCXO9xVppVQ+0xoN6Sr34keJYrCwGFndmIuvVORRsfCxcCHCzgN1ACelyPPlwWYEKveJKbLONIztQH7mPpdGG0uonwKMQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHXijRPtUam4STVXywx1lX7hngMMBIMR0jLc8okVY/A=;
 b=pDJkktpAxoreTdtGPqQGap8XHStnXldlc+1QczWOBebW1yPRXYEkF2z+84vWxAyAASePDIpNqFwJ/VK0VzEioLESSsTxO8c5LUrkY5MclIAZQ2a8I+8HJtUpPwYOqhpq4wQ2AV1hCVZj6TF9Sv5povaXw19xLrWTqvNa+44QOzw=
Received: from DM6PR11CA0066.namprd11.prod.outlook.com (2603:10b6:5:14c::43)
 by BN6PR12MB1635.namprd12.prod.outlook.com (2603:10b6:405:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Fri, 25 Dec
 2020 07:02:12 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::eb) by DM6PR11CA0066.outlook.office365.com
 (2603:10b6:5:14c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Fri, 25 Dec 2020 07:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 25 Dec 2020 07:02:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 25 Dec
 2020 01:02:08 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 25 Dec
 2020 01:02:08 -0600
Received: from build-u18.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 25 Dec 2020 01:02:07 -0600
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: do optimization for psp command submit
Date: Fri, 25 Dec 2020 15:01:58 +0800
Message-ID: <20201225070158.13066-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54513186-777e-48db-5f0d-08d8a8a3002d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1635:
X-Microsoft-Antispam-PRVS: <BN6PR12MB163558838FA5C22F11C40E1BF8DC0@BN6PR12MB1635.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nF+IPnscpCbZ3vPfKkZl8RnG8buLB7Xz4eQTwXh2Ng6qW95EOfrKHeIsH3TRU63sSqdRVIURRkgdev3Y0EiOQrmTq+m8rLHiTMnrMVnOjXUyMgZNk3cyAVk+FaZgTdVZb8zVGDce9QJz6dIE4qcZsz3Mtbq2OHUJmgs8wXyTqf9zNWXtVeelu2KGUGpJH6c21i20JprDXHTPvAUJWmoHlp+IfxdHEfLkrVLVB4M6LOhMN2E2UoaK8Imqxc6OF+vjJgHyiQRYmISzTq7t38NkjnVRFomZD41ztWnhHUp6J5dq1as7p5Rjf5gZlljWcj497lIEYq/e7f64G2wHe5GycXsEQLgIUIk28i3yP/nMde4caZCJX54HqPqZHePQl187W3E8I0GuVxNBSL/XGXJykayJYrbhFJEhIc8xkfHnndPFiuaxnycYbPHQ//WegtjL2xRA+DbgZH46XYxtRdbzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(6916009)(356005)(83380400001)(2906002)(36756003)(81166007)(1076003)(47076005)(6666004)(316002)(4744005)(26005)(426003)(478600001)(8936002)(70586007)(8676002)(86362001)(2616005)(4326008)(82740400003)(7696005)(82310400003)(5660300002)(70206006)(336012)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2020 07:02:10.8084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54513186-777e-48db-5f0d-08d8a8a3002d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1635
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

From: pengzhou <PengJu.Zhou@amd.com>

In the psp command submit logic,
the function msleep(1) delayed too long,
Changing it to usleep_range(10, 100) to
have a better performance.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 523d22db094b..8d11b34fe40e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -249,7 +249,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 {
 	int ret;
 	int index;
-	int timeout = 2000;
+	int timeout = 20000;
 	bool ras_intr = false;
 	bool skip_unsupport = false;
 
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
