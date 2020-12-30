Return-Path: <SRS0=0XED=GC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8E5C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 11:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDA5207B2
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 11:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDA5207B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73A288FD4;
	Wed, 30 Dec 2020 11:50:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D3C188FD4
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Dec 2020 11:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRP86eiiVVSI0s+grelQcLFhiacdktPSQbI/iloSwf6ivnd15pF6n/uyt3jCAskHc3jfZ850qam7oePPMgdYYMFkOqmhbtNycW6GPV1uCI3Y1myl1QHR/Mc/MRGQh26NxSI9aIiY6UcR3HOVwr4ZbtFkf9lKtYFIiBN4m80W2OaXoTqRNeII8cpSqkI20/UHjkNr+h2ufmKU1j56xoqJUCnYcN7UDmEeuqnhOguPfkTIjrhcWnn3v7bR/kDWdcFVC9ylKbatpCxJmxcZ/BycJlQrCf4iqbOo2gOfrKD1Gz/h4Q0HCT2sJk2/0IxOXGDjEnLQFByn09gKOFJ0gCS6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RqKGhJcP4ANgg/o+c2Bk4Hr9Z3X0ViudIcT638TpbY=;
 b=Sus1QPKjvjNGLNT9/gIgB5yQ9f6cWkr5RtmSE2L9us230hhar2S++t2Uugw9QHdHDv+S5q9Lqx2hShNimpLo4xiv5+5Q8R2N9aASz59Qlu2Vb386aRyjJ9NkYIHypowgntFxGmHEuGfyKvK9SjSm8DeshhlJQS8jxkVrhEnSaxfh9kA3KGU3iBr/jcxMV9OfJJ9DjFzg1StcY2SfxEQMTr5/buw4YfGoNmDiczaGfFf1JYdy1RS9EnKLWeCLnPSfIVyMUrvuUdxYR/nEl6H37O0naHjkY5AnrWGTIxMz21arzlO/9pE1WrDnC0b5JsCUyTiT3EXf2CB0GXaAR+nY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RqKGhJcP4ANgg/o+c2Bk4Hr9Z3X0ViudIcT638TpbY=;
 b=hxJeJviFPkUd6VBnTViUY0FgwLaZRJP4xUBdgO69ML4/tlAhlesYtRDRFTxj2wwgAXLyGoCnz+17hqHMsPxnzIawVD8EPd8Wgk6hKZEBH9lac/l1dFAKOzswF3A0IuYtX/soZcMjsDIJ+/GHo8nwScTOFObkF5sIaa8n9jlejzM=
Received: from MW4PR03CA0181.namprd03.prod.outlook.com (2603:10b6:303:b8::6)
 by CY4PR12MB1671.namprd12.prod.outlook.com (2603:10b6:910:c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Wed, 30 Dec
 2020 11:50:11 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::a3) by MW4PR03CA0181.outlook.office365.com
 (2603:10b6:303:b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Wed, 30 Dec 2020 11:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3700.29 via Frontend Transport; Wed, 30 Dec 2020 11:50:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 30 Dec
 2020 05:50:06 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 30 Dec
 2020 05:50:06 -0600
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 30 Dec 2020 05:50:05 -0600
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove unnecessary asic check for sdma5.2
Date: Wed, 30 Dec 2020 19:49:53 +0800
Message-ID: <20201230114953.2803-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 878498b7-1e59-4e30-f588-08d8acb90f85
X-MS-TrafficTypeDiagnostic: CY4PR12MB1671:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1671E8B7379E16A28D30C268EAD70@CY4PR12MB1671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gq0PR5lhIeq4UU+aRzPtBMyCJDEWUUlpGzarvitWECpRa3ZnMkNtdbTZepqJYLBDplyFvuqFWOVirUbeYmL9CO/cxT+n8a0QO4QbeDXkZaoXFdFB2pHwRKqrWtZEilsrtG9fRomgGESV4WIrZIHrrllkcRFeqnh/uef4Sfx9uUwIiB/eNA4ldT1WPh7MoouhkDVWMWuHwuRFJEiXo2gRL+rCMx3LhvM69WOXFNd07yBVeNGPwLlX1gIsscjgJVLdfUCKS88tnmhgNxGfqK25Q/b509NHgOYQ+SSKUN4XKQKAKYrhGFVxRXQWlwNUnsM4/FJkr7+A3StVJEw3zZq1cNFQAWVzOQ6f9pfw0dKHPfme6RpcNOUils+a8l7mWzip4K+hZk5tRzJCBOUYJ7K+JH424FF+fnrJeIlxhO673cjw8M61NXj7fHBCt3Owsvx4ZNYHXN85poEZ7oMMaV0Akw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966006)(478600001)(7696005)(26005)(316002)(70206006)(186003)(356005)(86362001)(83380400001)(2906002)(81166007)(6666004)(47076005)(8936002)(5660300002)(4326008)(70586007)(82740400003)(54906003)(2616005)(36756003)(1076003)(6916009)(426003)(82310400003)(336012)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2020 11:50:10.0690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 878498b7-1e59-4e30-f588-08d8acb90f85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1671
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
Cc: Jiansong Chen <Jiansong.Chen@amd.com>, tao.zhou1@amd.com,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For sdma5.2, all sdma instances will share the same fw,
remove unnecessary asic check to be more generic.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I8b67dd588de9e7d54618404092a77b768bf0ddbd
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 31 +++++---------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index f1ba36a094da..690a5090475a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -119,15 +119,7 @@ static int sdma_v5_2_init_inst_ctx(struct amdgpu_sdma_instance *sdma_inst)
 
 static void sdma_v5_2_destroy_inst_ctx(struct amdgpu_device *adev)
 {
-	int i;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		release_firmware(adev->sdma.instance[i].fw);
-		adev->sdma.instance[i].fw = NULL;
-
-		if (adev->asic_type == CHIP_SIENNA_CICHLID)
-			break;
-	}
+	release_firmware(adev->sdma.instance[0].fw);
 
 	memset((void *)adev->sdma.instance, 0,
 	       sizeof(struct amdgpu_sdma_instance) * AMDGPU_MAX_SDMA_INSTANCES);
@@ -185,23 +177,10 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	if (err)
 		goto out;
 
-	for (i = 1; i < adev->sdma.num_instances; i++) {
-		if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
-		    adev->asic_type <= CHIP_DIMGREY_CAVEFISH) {
-			memcpy((void *)&adev->sdma.instance[i],
-			       (void *)&adev->sdma.instance[0],
-			       sizeof(struct amdgpu_sdma_instance));
-		} else {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma%d.bin", chip_name, i);
-			err = request_firmware(&adev->sdma.instance[i].fw, fw_name, adev->dev);
-			if (err)
-				goto out;
-
-			err = sdma_v5_2_init_inst_ctx(&adev->sdma.instance[i]);
-			if (err)
-				goto out;
-		}
-	}
+	for (i = 1; i < adev->sdma.num_instances; i++)
+		memcpy((void *)&adev->sdma.instance[i],
+		       (void *)&adev->sdma.instance[0],
+		       sizeof(struct amdgpu_sdma_instance));
 
 	DRM_DEBUG("psp_load == '%s'\n",
 		  adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ? "true" : "false");
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
