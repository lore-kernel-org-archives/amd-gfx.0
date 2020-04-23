Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4AAC2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CFB208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LuEafzHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CFB208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A6B89DB8;
	Thu, 23 Apr 2020 07:01:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EEB889DB8
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKgVATGYtC1O7oemosNDbJWXD9vxyxsrihLZ1uXs88W2DSsBeS2Ibi+y+2ic5plYE4psuooZ848MFXeHqDWgw9eypZurAn0LEtCVs6bf1w1IpmI1+/lkFRAPF/YTMgqrVgucIa37+T00vRVM4/oKjn7vNXMVeuOUgr6h1640fY3wsxIkDnnrXgkVR4QqKznn/DMP0nXqkJmZTZyFkWJjey45m/A4RFWmjEyHu2V+W4yJbLBc5ChNLfRwZ6CurEWHEuwHxdA6El3hxERNMom675pPybQiPm8kzlqTtoeuC4k+TPkHQWttr1ZqFh9hpIPcBuYMCtjGIdaAgUWZGpXvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/lbRPc6mc6Q7YobvBb2U/LySWIh7T4aj4e6tNUyUl0=;
 b=bxcBx5z8h1F4X/UfQA06JPqBMEegxM/bCuIZrcklpnOkmsFQiOIKN8UQlWE4j6JD+kcQemO7GupFqvb4NckRcG7b3UJfJFgyu1vNsisOANnTtVlIK4wZRa0pJveD9EBCAHF1WK2yqhBcJiELnIqNYPdysnI5CyKFzzPvTsLaAAhVfYSlcc0pzRakLLp8I6eWSVLl/lQml0bYafBl65y7goczqg6USMBBAKH5XipxLjDYWlnoNM9ljSFc5IFjBI3PAFOP+cQrOQgjDZ9MPpwFbXRJd8eiek+ID6rVIknL8wvF7/HMFqiSy/e2tLPZRMxVIdg8Hx6eAqtyi8WYXe9s7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/lbRPc6mc6Q7YobvBb2U/LySWIh7T4aj4e6tNUyUl0=;
 b=LuEafzHPn28xFb0Cdt6jaiv0xhUd/MG1ePhwq0RExuTG7BJMLB6XGu7koKCdJFHI2k8H5Uj42J1zS5SBUXaY3jtHudzvEuZx+Uvjztr54SJOcy3PAujaz1rnOHWD7zdegV2ZCFhqpyXmDwcuCTm3zyvBi1eWXSJ4nYzTdMtmtIg=
Received: from BN6PR1701CA0011.namprd17.prod.outlook.com
 (2603:10b6:405:15::21) by BY5PR12MB4225.namprd12.prod.outlook.com
 (2603:10b6:a03:211::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 07:01:51 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::1) by BN6PR1701CA0011.outlook.office365.com
 (2603:10b6:405:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 07:01:51 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Thu, 23 Apr 2020 07:01:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:50 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:50 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Apr 2020 02:01:49 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amdgpu: ignore TA ucode for SRIOV
Date: Thu, 23 Apr 2020 15:01:39 +0800
Message-ID: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(428003)(46966005)(8676002)(8936002)(81156014)(47076004)(82740400003)(36756003)(186003)(86362001)(4326008)(478600001)(2906002)(81166007)(70206006)(70586007)(316002)(6916009)(7696005)(426003)(6666004)(2616005)(82310400002)(26005)(336012)(356005)(5660300002)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e05995c-aef7-4e9b-8c09-08d7e7543284
X-MS-TrafficTypeDiagnostic: BY5PR12MB4225:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4225840C8CD3867A1214D55584D30@BY5PR12MB4225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBOWoYj/LhR/5Aa4M6jcAa19lPSx+oD78FlKoMk705RjMqX8adqTVhrOGUNFxH1XyVLKfAA4ZALmbJeUAOCRFNHxeoaVJZ5lCMqliwy6IB6v0YrrWZyIGmdx1Qh9opuSnuEVb0fqB8fIYTqyzks8tgo3r41n6odSshFc6N46CAMV4FRA6fPaug6sq1zv0lEQ4G6YgTYZ3b4S9VJQXrt+j4M8QGtgx5rYjm/ibATcz9JF9zvKO/iZ5G5bFDNGn4WMmWW1eXeekYYydAIgvkseldRNbPbtqcQorW7pkYTqcC6oPploeSSVaS81ImrUCOnYgfXCwNAszb7tJkJislUa8cs2PO5hHqZ0ewSdRVO3MaKJPCu6jR5Mcb6URiX996t9RkVxpS2QsqOozCnlHEFfffXaZvLqoeDg7R52ssTg4pAcSQUHNOyzo5LJVCvDz85npcqLZ1jZHyW5FTJDT3SAiBViNr024SOLXrWxtFJzQI5A2q6Rx8g2mlGv/8Q+rg/bZmIO2IXzukk1gtZrpDVfWg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:01:50.6601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e05995c-aef7-4e9b-8c09-08d7e7543284
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 0afd610..b4b0242 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -194,6 +194,8 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+		if (amdgpu_sriov_vf(adev))
+			break;
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
 		err = request_firmware(&adev->psp.ta_fw, fw_name, adev->dev);
 		if (err) {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
