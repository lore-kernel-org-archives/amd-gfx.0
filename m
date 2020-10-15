Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB38C433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 02:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBDD2222E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 02:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1P0/IE6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBDD2222E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2767F6EC13;
	Thu, 15 Oct 2020 02:47:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46CCE6EC13
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 02:47:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0R1KrNdNI8sxVB7lehID2KflCwvfLyj2dumJIHRRyW/Rfhp7W7KQ9P5seRA2p6gypE0VII4uvu/5/qxDkfi2gFmOl8bXAJ4uXpCAr11H1gw4ZlfmaIOnMYKY0A7IsH62np5nQMmlEh7inDSzYRrKIrWagZeQOXm+ULX5thQ7ZZERi5oS7OOyMib3REAylH/kQqAjyWFY9PZIAQMEEMbfqT60RL/fqeZp1xfzMlIMM6y/Kzgons24Bfxki6mzncYXCrvIgPlHSl07tmG5kuz9Hu4gC7NZ1hUpZ9uXAFzUimJMfYLCFFBVKVsMHHpBfcKthRh1328GW9Jgr4mognNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF71IVCcqB0crFT1X3Vhub45XjlEJrXZ1I0YtEO2n5E=;
 b=IUeeTmTp8XsErWeLqgzOIUJYOlrmD0PdcrPlM7t9UUWyyYAu/aX6PO1++bKi80KpjfSwudmWakYMfcf4NPtT5Xl7rADZ4X9SFjnVFp3PN/yToFIpbkfvyT+Uq5dKo+kqRkmcdandu6/cqOjIdChT4Be7TNOvRT4l6ySlFCRLEO1F3X6iTxz5X81dirrDOrOVPHrWRD2UJl/n3i5gr6jZWfUCN0DjZJs8R8xd85fr4MV1oY0S7yxwxN85iRsHzyHbA2PameMujd5ScYHb1+kIY+kmH5qskdlF0nmXl1pEACk+BqzUb18Bljs/cqmstMks6geq/A5X5MZxHPkiMe19Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF71IVCcqB0crFT1X3Vhub45XjlEJrXZ1I0YtEO2n5E=;
 b=1P0/IE6cF7uQipgxTCSpbz5MuXHrBuKampXbd5+U4Rd5Z6MpR5ZXlxqGsEoQ+E3vuK4SmAc/WX4EFBulzo95SqkNTKgB49Suleo5bPfk2jXKfJnkJhd8uAr+eQqYIiCItmPiWFAU2rrXCHwrx2OJUFKzuQXenbsd7eqcV+eAKJ8=
Received: from MWHPR19CA0076.namprd19.prod.outlook.com (2603:10b6:320:1f::14)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 02:47:07 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::a2) by MWHPR19CA0076.outlook.office365.com
 (2603:10b6:320:1f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend
 Transport; Thu, 15 Oct 2020 02:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 02:47:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 14 Oct
 2020 21:47:04 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 14 Oct
 2020 21:47:04 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 14 Oct 2020 21:47:03 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu: disable gfxoff temporarily for
 navy_flounder"
Date: Thu, 15 Oct 2020 10:46:53 +0800
Message-ID: <20201015024653.35436-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b98fd78-b588-4b35-d5aa-08d870b49a9c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41162C5DE8848559EF1FE1B2EA020@BY5PR12MB4116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:192;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HUWNYRHXiWOYRYMZOxbYIpnBvp/FyYG6tIZub3Bz3R/Jd+oZ9YqgtNEqfra8s8JJ0rwAJpNn0OciZdmllzAa/HZZLBRLO1AL+oO3JKcut0zOMcO9qFvmeO0a1LnJqUZEJxTcVbCfLmf1B5B747wR8qHFhZCNpRIvLS2kvIR5cmoSlOJU3UBHH1WCiHzSJjVpBKzf6ZQwDBON9HaB1zGFUcrw5TzKmVabhKM7al4M1Edt6CYOvvf91spcmS58VVJ/2D7ZNLtife0cEQHBUCNWmkZOuosWxbMRvFvwpcqwhlfmgRebFwjCuwOWv4x+xaaxe0ZdLznxAEDjZfevPFqa20w/3aE5hRBA9RAHfJn4ZL8bEQ6yQbjzZ2meu869McM0jUkSXrXvUXupRA6ytKSvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966005)(4744005)(1076003)(47076004)(5660300002)(83380400001)(356005)(81166007)(426003)(336012)(186003)(2616005)(82310400003)(6916009)(7696005)(54906003)(26005)(2906002)(82740400003)(478600001)(36756003)(316002)(8936002)(70206006)(4326008)(8676002)(86362001)(6666004)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 02:47:06.1520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b98fd78-b588-4b35-d5aa-08d870b49a9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116
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

This reverts commit 7e59138e97574e8dbecd1f259581277fff555d00.
TDR issue has been resovled by pmfw update.

Change-Id: Ia04709c4ba13835abfdec56558738bf6fbfac20d
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8fc69c208adb..be13495b97f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3723,7 +3723,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 		break;
-	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 		break;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
