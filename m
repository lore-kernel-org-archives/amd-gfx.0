Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC1EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 06:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC5710E496;
	Wed, 29 Dec 2021 06:33:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB7A10E496
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 06:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+7eIqHsaOgVew2g1WlqwQJNt99L6KjvI/Yx1bJKPgpo9KbMFRxfutxA1gRIyNcncs9wYb6XZKCJ4F2DE1LM7QonClzDdNjmbBFFiavAqYPDL4OL8GRmNg+1uk2uycW4x4jmvCj9niZJuVqwFaQHJAlWr7UiCdXtm1OM2LDfkdNkwRsIDW3jx+eT2Wi3nwYlDdyELadhpLCjeYzD7s/7/+0Nf0Glrh+hmR9q20TtL6LWyrj/AAYaAyvuIww6eOT5/p6KWLKYKtnHmjede2d5hfcawtfE6ERJdk1YnxWn25CO4tDypjAZ3bhBXgDe8TwcqErx8gaSeD1Nul7g6hFBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LdKU1L1v190KFSvSYUOoEzQCECUFAr2c6zyQEfq9Cw=;
 b=RrMSPwIXXlOnU3x8TNAjnO83Ubiwkacf7/JlAXlAN6iFMcAekiJNdVhTDb6G0dn2jGAxzB5cijng2LScqQwnNvvPJny+WEl/bECOjx8f3RJyut0MllcvexnwWSpbTmp6/da9eNdngGNnfPXL34l8pOaA1dHhnsTkKA9/AxudUjHnS9K/XhOyuBCZslSE1fI9ZatT6/9BSgU8jMCr+Zzz/at8mZxYT0Xhz7UW8cNk2dF2l5iyIMUMoPlFxKoOfd8eaotmoNlEum7aVP76guXVod653H86o9eiaZB1Aqmp0jjexahHMbIPUGmnYcf5zZHQmrkoV0isScxCbwAswXQQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LdKU1L1v190KFSvSYUOoEzQCECUFAr2c6zyQEfq9Cw=;
 b=ps/4RmCcfhE9Te3E9NRMc0MntNBSo26lPNaKcKCbEaI3rKEO9p92jSGFXOEwAr5qXER4DsqzjSOLUuOUET3VvofOqTNFwmfDjKKoHqTMHUB5OvzLaBMcfOtENSUUxnWIzFlAOoPkbAcepAtfHEJ0ybvwu6oG3iNYuSrI1HxCr8Y=
Received: from MW4PR03CA0029.namprd03.prod.outlook.com (2603:10b6:303:8f::34)
 by DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Wed, 29 Dec
 2021 06:33:15 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::7a) by MW4PR03CA0029.outlook.office365.com
 (2603:10b6:303:8f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18 via Frontend
 Transport; Wed, 29 Dec 2021 06:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 06:33:14 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 00:33:12 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 12/12] drm/amdgpu: Removed redundant ras code
Date: Wed, 29 Dec 2021 14:32:11 +0800
Message-ID: <20211229063211.43840-12-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229063211.43840-1-YiPeng.Chai@amd.com>
References: <20211229063211.43840-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07db412c-285d-431e-1e8a-08d9ca9517e3
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2502918C25F97214DF85860BFC449@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:94;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAcubATMPG/ZC0FZequOMd+ZYiOtdHwpYHyXE2pdCvoaeG8qTqvmGkSuetWKtL2S6Y71sFYVJlfIoJ9w9cvp/aHs9h25KtgaTutD7v6NTBOyG3d1QA+AjfDP4soEel1OD63TnbcAznk/PoHT9QR+zCi/wSWEwLP+v37Vod+ToMWOdN/Hw9t9v1zeQA5gV1HT3qFmvKYEKSJs70laHGz5oq2KbpRprDBQvZ3ZqqU20JinZyHWQ/QZgbI3ZpiQnmPW2uenSP0NE/bZK8J+HFgQ5Bci8yPoyDy9f3x5gaZ1yNzu7XjnWSw3W/6PBhaun/INjegmnniVuyPApV1zFIT+t/J+Sb9Ho+2B83sgSuUIWExh0egLL7xu3vYcNQPfReOfOz0YgC+UVRXrCtb9P1B1chy006C0TNoI4Riu3Au7R5JWeNkY5itpql0nUfW0SZS0UAiVe2aj3rHpwho+yBjUd92kIwqe5qZFP7TDbWDbNfBpmQS2gq2nwsXCgs9iyt7OFrklMzOemL/hiP/vDltfJUS2++FQRK4rzaE//9g0BxuIQTOBCsO+VnGxCVwS8gUu11EvvY8q9D/6jmO75qxvO5xO96o51CcOKxogCSjle8PPeMkHRzS8QAeGH2sGCubh1bJZMOiN6njq5ifshyFQkY80GrDddZfGVVv/Mq69lazJzqg7/hmP1myUtvxKzKaDzCMAVHV5x0upNopg3EqEzQ3O19fcceukDukw/GrfaAZrmhAlq7KZ5KwrYnO3b+js5vpSlvfoiqQRVEyhKPEPe/gFF22h3a4rBkhKEjA3GEQD6+0MmfFZrPmXsexWNSPdnk0iSgfkwkkIQrx+TvboFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(316002)(4326008)(6916009)(336012)(1076003)(508600001)(70586007)(54906003)(81166007)(2616005)(36860700001)(8936002)(2906002)(70206006)(7696005)(36756003)(16526019)(186003)(86362001)(26005)(8676002)(426003)(82310400004)(356005)(40460700001)(83380400001)(47076005)(5660300002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 06:33:14.7771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07db412c-285d-431e-1e8a-08d9ca9517e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Removed redundant ras code.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 82 ++++++-------------------
 1 file changed, 20 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 21765e05b003..17de79be6d8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -910,51 +910,23 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, 0);
+	if (!block_obj || !block_obj->hw_ops)	{
+		dev_info(adev->dev, "%s doesn't config ras function \n",
+			get_ras_block_str(&info->head));
+		return -EINVAL;
+	}
 
-	switch (info->head.block) {
-	case AMDGPU_RAS_BLOCK__UMC:
-		if (!block_obj || !block_obj->hw_ops)	{
-			dev_info(adev->dev, "%s doesn't config ras function \n",
-				get_ras_block_str(&info->head));
-			return -EINVAL;
-		}
+	if (block_obj->hw_ops->query_ras_error_count)
+		block_obj->hw_ops->query_ras_error_count(adev, &err_data);
 
-		if (block_obj->hw_ops->query_ras_error_count)
-			block_obj->hw_ops->query_ras_error_count(adev, &err_data);
-		/* umc query_ras_error_address is also responsible for clearing
-		 * error status
-		 */
-		if (block_obj->hw_ops->query_ras_error_address)
-			block_obj->hw_ops->query_ras_error_address(adev, &err_data);
-		break;
-	case AMDGPU_RAS_BLOCK__SDMA:
-	case AMDGPU_RAS_BLOCK__GFX:
-	case AMDGPU_RAS_BLOCK__MMHUB:
-		if (!block_obj || !block_obj->hw_ops)   {
-			dev_info(adev->dev, "%s doesn't config ras function \n",
-						get_ras_block_str(&info->head));
-			return -EINVAL;
-		}
-		if (block_obj->hw_ops->query_ras_error_count)
-			block_obj->hw_ops->query_ras_error_count(adev, &err_data);
+	if (info->head.block == AMDGPU_RAS_BLOCK__UMC)
+		block_obj->hw_ops->query_ras_error_address(adev, &err_data);
 
+	if ((info->head.block == AMDGPU_RAS_BLOCK__SDMA) ||
+	    (info->head.block == AMDGPU_RAS_BLOCK__GFX) ||
+	    (info->head.block == AMDGPU_RAS_BLOCK__MMHUB)) {
 		if (block_obj->hw_ops->query_ras_error_status)
 			block_obj->hw_ops->query_ras_error_status(adev);
-		break;
-	case AMDGPU_RAS_BLOCK__PCIE_BIF:
-	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
-	case AMDGPU_RAS_BLOCK__HDP:
-	case AMDGPU_RAS_BLOCK__MCA:
-		if (!block_obj || !block_obj->hw_ops)	{
-			dev_info(adev->dev, "%s doesn't config ras function \n",
-				get_ras_block_str(&info->head));
-			return -EINVAL;
-		}
-		if (block_obj->hw_ops->query_ras_error_count)
-			block_obj->hw_ops->query_ras_error_count(adev, &err_data);
-		break;
-	default:
-		break;
 	}
 
 	obj->err_data.ue_count += err_data.ue_count;
@@ -1016,32 +988,18 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 	if (!amdgpu_ras_is_supported(adev, block))
 		return -EINVAL;
 
-	switch (block) {
-	case AMDGPU_RAS_BLOCK__GFX:
-	case AMDGPU_RAS_BLOCK__MMHUB:
-		if (!block_obj || !block_obj->hw_ops)   {
-			dev_info(adev->dev, "%s doesn't config ras function \n", ras_block_str(block));
-			return -EINVAL;
-		}
+	if (!block_obj || !block_obj->hw_ops)   {
+		dev_info(adev->dev, "%s doesn't config ras function \n", ras_block_str(block));
+		return -EINVAL;
+	}
 
-		if (block_obj->hw_ops->reset_ras_error_count)
-			block_obj->hw_ops->reset_ras_error_count(adev);
+	if (block_obj->hw_ops->reset_ras_error_count)
+		block_obj->hw_ops->reset_ras_error_count(adev);
 
+	if ((block == AMDGPU_RAS_BLOCK__GFX) ||
+	    (block == AMDGPU_RAS_BLOCK__MMHUB)) {
 		if (block_obj->hw_ops->reset_ras_error_status)
 			block_obj->hw_ops->reset_ras_error_status(adev);
-		break;
-	case AMDGPU_RAS_BLOCK__SDMA:
-	case AMDGPU_RAS_BLOCK__HDP:
-		if (!block_obj || !block_obj->hw_ops)	{
-			dev_info(adev->dev, "%s doesn't config ras function \n", ras_block_str(block));
-			return -EINVAL;
-		}
-
-		if (block_obj->hw_ops->reset_ras_error_count)
-			block_obj->hw_ops->reset_ras_error_count(adev);
-		break;
-	default:
-		break;
 	}
 
 	return 0;
-- 
2.25.1

