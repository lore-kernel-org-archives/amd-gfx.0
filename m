Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D06C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 14:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C580E2076A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 14:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lOQOIMqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C580E2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7AE06E44F;
	Fri, 16 Oct 2020 14:52:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6B96E44F
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 14:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClIrajLjlsglZN2TIdsHvp2SagoSuxtg6MSDL4DUMWjPIL9aGaCX2gPnI4Jp5s2xPvCQj5rrDU3dSDjPJV833YRokQ2aGnQZHy8u+uxqdxMFHv96FRK1jkpd2NgqXSzoflwGA9A4fOabggMQxNh5NjE/koojrk8OCI+2vdDY0LiJVYDsfKuKcB6ZqUAcdNuXEnCsO+Rm0vmZscE9pHiyT6E6EZYUs2Q5Qn6ggfwMrIgjiO6xabfDMIqi1f8YF/lc+R9pzh6mXTTedHOmxHxrV1yQ4gkeoMBeg2/JpZXpeOd5RfCiQwuFOD4g6l7heGrXSxioEoK768MfNgfvgoHcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9MWBmM5WYiY+JRNGodrZmI0Mlul3i5NZWpMSqRO4xA=;
 b=nGkGoFCAiBkMb+RYVEnkDXwzgGMIBNFVSuyweOejuCj6/QhAs7DQcZ/hpToeMwVhc3EEqQIu2GgXGsK2nSJy6TY7dZUGxvL0sQE4W00KIsC+bCSBlslcOSN1Y7w5+ROuVvJbEKqd6UFsW3hpPmq/TM3knnd3NKvR/lpziYMZu5cqHkxwJjOcYC5rucRnvHY89+al7F0kXmPUtrCvMRS733GO8NTMNeae4qqin8Q/wEBD41N/uOdJQTaNSHwOVCvkYiQDwF101Eiu4ydS+IFoiZtDC2Fzr8eXusS+NuUuz0SVCnFYGCtffq1Zh4QnXqmnPaWpUL9RfmS62dASuIJa4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9MWBmM5WYiY+JRNGodrZmI0Mlul3i5NZWpMSqRO4xA=;
 b=lOQOIMqrPQqnzVdNrAx4xEiTDy9enLtEddG8rK2xLwY14+P5k6funMnl+Ewx9+asp/wwsLbkSXPxV45kuUa2zo8HK7EfIx0wRm77EMFkGMKlfRJMTfk++c37AC1goluhA28RAa7Q+kvMZ/XZ0TzWNffMO9o3d8vbbjuFgdxaqg8=
Received: from BN3PR03CA0085.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::45) by DM5PR1201MB2506.namprd12.prod.outlook.com
 (2603:10b6:3:e7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 16 Oct
 2020 14:52:22 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:7a4d:cafe::d3) by BN3PR03CA0085.outlook.office365.com
 (2a01:111:e400:7a4d::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Fri, 16 Oct 2020 14:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 14:52:21 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 16 Oct
 2020 09:52:20 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 16 Oct 2020 09:52:20 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/psp: Fix sysfs: cannot create duplicate filename
Date: Fri, 16 Oct 2020 10:52:17 -0400
Message-ID: <1602859937-30214-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 630056b1-7d45-44ed-d70b-08d871e31639
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2506:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25061C88AC592161DD642451EA030@DM5PR1201MB2506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZKAdM2VBDaPspYU45cEQz6sK/KWSa+u62dQjtBriLsfdkj+FLQZ6wTTvL6weNX4F4wVfXGmKXYwjhyckRZ08WUsdI8nBtcepEufKFO34v1iyG1/ySqEYNssVkfkpGdSBfspuGQKBDD+4732X7gPTtkHmDpJJYmx7j4eEN/5QVANGzccioNSi5DiGT73HgEAe+IKbVrzBcB7/vQQy0XXspY4PNazfOgv1N6RIkKWflN0WMJi+UIQj9IQ2WaZpVjwgiE1vL8VUAuqVBcfqIvc/nWBah1/U1iA3UriZYywyF3Rww7Ag0FKxjyNp5UslZ7qqKFEB1uSVElwuEEmoeafjn4kr2bR9Es3GY/ZhEW6kCI0xQNNDHq4U9LVdNqy2PLDmcUkfRDtFB/xrmzTnAyzBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966005)(81166007)(2616005)(6916009)(7696005)(70206006)(70586007)(356005)(6666004)(186003)(2906002)(336012)(8676002)(26005)(4326008)(36756003)(478600001)(8936002)(5660300002)(316002)(86362001)(54906003)(82310400003)(83380400001)(82740400003)(4744005)(44832011)(47076004)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 14:52:21.6889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 630056b1-7d45-44ed-d70b-08d871e31639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2506
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Jack.Zhang1@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

psp sysfs not cleaned up on driver unload for sienna_cichlid

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 803b3ab..675b14a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -210,7 +210,8 @@ static int psp_sw_fini(void *handle)
 		adev->psp.ta_fw = NULL;
 	}
 
-	if (adev->asic_type == CHIP_NAVI10)
+	if (adev->asic_type == CHIP_NAVI10 ||
+	    adev->asic_type == CHIP_SIENNA_CICHLID)
 		psp_sysfs_fini(adev);
 
 	return 0;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
