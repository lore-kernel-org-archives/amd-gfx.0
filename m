Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D42C2D0CF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 09:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBDF206CB
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 09:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SQLv39SI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBDF206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C63CC6E087;
	Tue, 24 Dec 2019 09:29:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111296E087
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 09:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vci1LCNLIQTS7Wm2wmx5KC5qeBL1BDOA90i54z/GQirm50pyABAplWbJn44Y3df9gaqhSwKqUI832wMVmkTVcSI2bm25y5S432f6XZjta2ERjFUrClbJcjgE/i5YVE2JL3AYNbnTbwnSKg4/N7v36mLBEr0DKr7vPASeG8v1qbXt+ykw8NBSjJhJ0KmoULYHFbvmM+EUpi1s7CR8BwdfglJ74NIL8oE51qhBUxey5veomheFKchkKgOwuW9Co8gTx1wFmvaYLjuwVRiNnI3GDoZqhmcvwjkY3Umipp/bRHrn3aDF8grm3sXAB3QFvSetq5zggMwCaPY5xOTHcTkbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAPcqD9H+B4B6fb6QDx/R5pqD7reInwmiqQYcXIYs4Y=;
 b=gx6Gg9lqKAAkszzGbMstghS3wStN8Oqcn8ObdkJWuYTK4EKfJgDdKnN9y7e0dQa3aCuJ0axpx7+PeJ+/dnFBuOBR6kVOuIebs7J8tR/BHI0E51K0gUGE0AuMokReuLJuOfroyrVOgOv+jR1tRbR1OIlvzCSWxEhkZ8eS3DsBPAFs4Sehq6iin2gAn5cvEuG66siHQPAI3SMDcQNiP6gcprc7Iu9la143cby4V5VkgQuOj0Zod+/htYpaJUyz/wM39EeGDJmBuzpK6tyaOowuiLUlcVyCidqw9gIkB9fH+auzSsC1VJZmSwZqPnnZ8j8QCU5Dr07sO7srb55qKYWCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAPcqD9H+B4B6fb6QDx/R5pqD7reInwmiqQYcXIYs4Y=;
 b=SQLv39SIcrdMP5+9W7zP+VqGvbunlqS1wBubvRaXP8KjpRQTDJ8oqA5xlGBgVRYj7aoDOvmMUo7oUXW7LaQ961M/3qxMHHT8pmrm2aD+y3f8zN4pK3Qr2Wd9E+uSMuzCRy2OM4xaQrACLPwRVBtGlIeoAuAoJr8WK9XZqrakfBc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3261.namprd12.prod.outlook.com (20.179.84.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Tue, 24 Dec 2019 09:29:11 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 09:29:11 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: add check for baco support on Arcturus
Date: Tue, 24 Dec 2019 17:28:48 +0800
Message-Id: <20191224092848.8259-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Tue, 24 Dec 2019 09:29:09 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39cd9755-a789-4aab-6db4-08d78853bb94
X-MS-TrafficTypeDiagnostic: MN2PR12MB3261:|MN2PR12MB3261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32619A3FC1BB806D0E275A05E4290@MN2PR12MB3261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 0261CCEEDF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(186003)(6486002)(5660300002)(8676002)(81166006)(2616005)(956004)(6666004)(44832011)(81156014)(316002)(52116002)(1076003)(7696005)(8936002)(2906002)(16526019)(26005)(66556008)(6916009)(4326008)(4744005)(478600001)(36756003)(66946007)(66476007)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3261;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDnjpKVxrOCzKDvWp1gmFV2+veD7yGoPn3N0GiNJ0hMjy9Cpfnp2YBI/++qsgEgSakR+Xch6XahR81k/ebmr19+7cC84ijgd92HcDcp0Z1hcQlNsM+DQ8PGxqADKfLIcjSWa+w5sUCgNBUQSDg2yHM4acQ+Mzj/PgafLaUUSY97Z9ztNFYQ68Hrs5cxtRarcwukJZN9RSfFhsXB8bkIKS/JVogjopWXuyJ7sZ5P7twXdnCoqpAAl2pOMKU/E9BWjU+WPW3bXfR1YH9KTvkHHcqr76lQt5r8jUPJNGPehOLSyH7vvjI0BY3rTWrOlKk54jh5UnF5nE1cn4S6tVHi38vsH/Ax0AJZH1s6rFOi1E/3GlHGyz9gY/H1Q4/pj5i0FwZG+3F+74E0QabDNR+l5eDwuUxb04lQHHdNFV1Cg9yR3ucUxHibnt/ZkIGoQOxVe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cd9755-a789-4aab-6db4-08d78853bb94
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 09:29:11.3170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1n19CI5dbO6pOSmmrxeKnrRoSPuIHi+lmk5I8xKBtFVwrUM1ewIH45MmzvfMwS+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3261
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is used to determine whether runtime pm can be
supported or not.

Change-Id: I0b6452ae56094d768ece23ba62476f410f19e57b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index b53d40177e93..a0615640082a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -613,6 +613,7 @@ static bool soc15_supports_baco(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
+	case CHIP_ARCTURUS:
 		soc15_asic_get_baco_capability(adev, &baco_support);
 		break;
 	case CHIP_VEGA20:
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
