Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8D3C43470
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B35561445
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B35561445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42646EC8B;
	Thu, 29 Apr 2021 06:26:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA456EC8B
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bp7j8zTJyxnh3xlcWGXCf6enHSOx7/QotJEyq/GR/vusm8ESxOzBpVk5OU1rhtmVTKAxKJz76LCgxc1DhYV3hPR7T7r1Tw4vei2mubRYV9tJyUSULMNXJ3rEyS+tYjzFCQ+KYvOGRTMmvjdsdAqXliCnKuMfC6vQbohzm8BUvXUD08ywU75wNZFi2Zx6pj0iD1LN0+vluMFqSW1P9NFc/taVOVvMcSx3RrKDjOw7z3bfYN1slr0OTGaFj+X+8TCFel+YjakSUExScxvjvyjdl/DUamIEay6YACL9bvs0r3yqYKiIN7yWlw3DJ5qfU/Lxn0boCrMe6RzwuiX0wMzwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJPPPtb3tfTT3k98QLCT74XBuLiJpCVsXFri6niPpxA=;
 b=bE0q9NCZk4zhJ3FAtW6at9XRIrRxF2VLX76OhnmIXo7jXqAt/dTlZrhbSRLqsQ0U4jKoFCwDvJ6b9OxVZgn7F1WAnqhHBSaGKSZisFR+ED10I/xQx0eDPVlucySlBHoMBRAL8I102MhEbv/gu///1a23tF59OCtAcOHkvrhoydTXhh0GQj2g9tveVDVOUBk8fo2/8/2FraBUGBGnkMhRCF4AnUvM8W2WxbNO3BiNStRQiS1hOzpwmOtGVdHoqU6PAfGXWusAwRao4oLZecA2eOjCWif0dKRq2N6Bpe+bKbyrtpunXPkawBjtB7/l6dR3uySTCQ1spn0qTOM6bt5EoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJPPPtb3tfTT3k98QLCT74XBuLiJpCVsXFri6niPpxA=;
 b=G0a4weZl+W6H50iAaAOMYsJTUcrssqDZ7T9Ss/EJdYLH5EbB3v+0c2hzDpy9YtIsp4E99waIHUaGzU7JFIQeZQr8dSvSziwsNa10Q21gvYfkDWnuat04AlOufBQ5HZUJjk2HV5KEpOgJCt+6k75T1YQezs0NeATve25+gqtTYOg=
Received: from BN8PR04CA0027.namprd04.prod.outlook.com (2603:10b6:408:70::40)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 06:26:09 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::c0) by BN8PR04CA0027.outlook.office365.com
 (2603:10b6:408:70::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 06:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 06:26:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:26:08 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 01:26:06 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 John Clements <John.Clements@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu: enable ras error count query and reset for HDP
Date: Thu, 29 Apr 2021 14:25:45 +0800
Message-ID: <1619677546-2630-6-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bea15d8e-df7d-462e-a3c5-08d90ad7ad00
X-MS-TrafficTypeDiagnostic: DM6PR12MB4059:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4059896E2D2F1D98645CE48AFC5F9@DM6PR12MB4059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIazs5drrVKpofFFCgjbg8SrNLGAXSNYty/klZPQbQeZ8FD7OY8v3gi9+hlkYs3pJz2OIWARwIBfrDR2wLjnO9Y1EJ8+FvYhh9fS61F5JpVrATIFlyX+HoKzBwELudBW4xzr8WyManz+I7Um0bYRGNzOMHv3W6B+AcizKmSbJzuVEnKoQJliHlU5mCuG9pQcFy8ZTXVPRD0oC8+yfplE7PElu2YIchBQ0Zql/w2Xi0PueARafVVtY8Qp9Zje1zG78STd3S4lbynpaG4nOXJJf0K404FY96QmvGP0wAFcAQO5SIVSQJJ8zTwRskD+YCfZMXgjcNvXka7Ann+Vxqur9yJi350K1GIXwlAxrk9ZEBkpKWBJXN4vEULetPgdhQK/oN1cEjMpup4+XnRMoJyVRo145B2h0ELEew/smwPpidReYKUxH/5z9bwUl3ilscNK/BKQg3LYJL+IAgnR3EdXGjEe4w3f3jO4DLAdbdIsSKT4wZUSsS2bUc70MsbRdhSV4SMjpl2SqDzgqacLD8MSmgjyCvef28q+hrX4WYLuYtc0dyzKgD8LBE2aGd3p3jgs/9LLG5LfYGnORSfQDnohmjLzphbWApLqUsXoboK1+ULj2Mcqd5mNFLkn70bBw6eNXlYlKA1wBNS/BxMelbIoyKKueqj/7KT7s3gSoaI7p1s0t1oy7fKHJ3ZWoJYyoiDX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(36840700001)(46966006)(478600001)(110136005)(2906002)(47076005)(186003)(316002)(356005)(4326008)(5660300002)(426003)(70586007)(86362001)(82740400003)(2616005)(70206006)(36860700001)(8936002)(82310400003)(6666004)(336012)(8676002)(26005)(81166007)(36756003)(7696005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:26:08.5952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea15d8e-df7d-462e-a3c5-08d90ad7ad00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add hdp block ras error query and reset support in
amdgpu ras error count query and reset interface

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/soc15.c      |  3 ---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ae9fb20..984e827 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -890,6 +890,11 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		    adev->gmc.xgmi.ras_funcs->query_ras_error_count)
 			adev->gmc.xgmi.ras_funcs->query_ras_error_count(adev, &err_data);
 		break;
+	case AMDGPU_RAS_BLOCK__HDP:
+		if (adev->hdp.ras_funcs &&
+		    adev->hdp.ras_funcs->query_ras_error_count)
+			adev->hdp.ras_funcs->query_ras_error_count(adev, &err_data);
+		break;
 	default:
 		break;
 	}
@@ -967,6 +972,11 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		if (adev->sdma.funcs->reset_ras_error_count)
 			adev->sdma.funcs->reset_ras_error_count(adev);
 		break;
+	case AMDGPU_RAS_BLOCK__HDP:
+		if (adev->hdp.ras_funcs &&
+		    adev->hdp.ras_funcs->reset_ras_error_count)
+			adev->hdp.ras_funcs->reset_ras_error_count(adev);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8e0cab5..3daf806 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1276,6 +1276,10 @@ static int gmc_v9_0_late_init(void *handle)
 	    adev->mmhub.ras_funcs->reset_ras_error_count)
 		adev->mmhub.ras_funcs->reset_ras_error_count(adev);
 
+	if (adev->hdp.ras_funcs &&
+	    adev->hdp.ras_funcs->reset_ras_error_count)
+		adev->hdp.ras_funcs->reset_ras_error_count(adev);
+
 	r = amdgpu_gmc_ras_late_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index d80e12b..28e9f6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1521,9 +1521,6 @@ static int soc15_common_late_init(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_get_irq(adev);
 
-	if (adev->hdp.funcs->reset_ras_error_count)
-		adev->hdp.funcs->reset_ras_error_count(adev);
-
 	if (adev->nbio.ras_funcs &&
 	    adev->nbio.ras_funcs->ras_late_init)
 		r = adev->nbio.ras_funcs->ras_late_init(adev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
