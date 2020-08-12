Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB82C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 08:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED2F206C3
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 08:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="stQ0w9NZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED2F206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 739E66E3D2;
	Wed, 12 Aug 2020 08:44:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 982426E3D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 08:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0KOwxellXqYVclpYnQn15yIrSlKqj1uIGemBxbJYPm6RzDlXRKz+CqwrycUQ2fzY3VwHEGvhbp5Q+L2iJlehqshAr8NIXiCRn1rmqNyvh+lHyuNVCBdnyQ/H92z+B+EV0ri9kRlqOsN3Yhv+ZsMSESYtr0nVFhmDNerqxECL/P9D2sQm8eI1+nJsEer7d1JAEF31nSk2SJJmiJGMURmUIb/FQfJM8vFDrGIGgIsaiuasIjUqkEjaU5FuDIvmPMM4NMThYAnguG44FdwO7d7BbOd+5pdVNcWNcn4oZ54skiniCum1oqyHirvjnvi6iv93N0VegSF8vGMTkm/AYXoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0qvuCzWRG7kGWplUKwN87cVo5dvEkvuovZH1Pg9Z1w=;
 b=KNPS5eRHLFrQiEFeL66Zqutiqa/McYabClzps3ghEUK09hVO3s98D76sbbVCnMPkzHH12tiWTRTaglWpq+pCRI5EBRlqakk7EH59EvNnQShCmNBHHsa2aNrnRcEGGkL8iRE8VS93okw1QIOptJ8lDhGDRHhx4p8CXWoSm0TDbObpFHt3KtGUpz3MdTj5mt2BQUszZmW6jdpGG3X9AIPsx8wDEcPrC4KTpuFft9uKRb1ocsTnwGZmnQyW6RxR63cfuUSfIbXjZRSCEu8xsP4meWVebGxaDb2/vWcfjrsL7rX/4Xxsdn01kVGOLo/B0df2bDrcpdR6scBM0MdC1T4o3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0qvuCzWRG7kGWplUKwN87cVo5dvEkvuovZH1Pg9Z1w=;
 b=stQ0w9NZElJK+waH4v9NIiTYaP6BzRXS2SWP5lpeTMbbFgLQrm+89AW6ELBCbHQkxy0iI9YIgujynB29WC+R9+Tc/FIPXb2caqnsliJ6I0qcKQYHZi7j0TCZgTWrzAsbukGvdAwnzcdL4eri5rVHvutedM9TzLqwGjIrpGPldvw=
Received: from DM5PR22CA0007.namprd22.prod.outlook.com (2603:10b6:3:101::17)
 by BYAPR12MB3047.namprd12.prod.outlook.com (2603:10b6:a03:d9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Wed, 12 Aug
 2020 08:44:34 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::5f) by DM5PR22CA0007.outlook.office365.com
 (2603:10b6:3:101::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Wed, 12 Aug 2020 08:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Wed, 12 Aug 2020 08:44:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 12 Aug
 2020 03:44:33 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 12 Aug
 2020 03:44:32 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 12 Aug 2020 03:44:31 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable gfxoff for navy_flounder
Date: Wed, 12 Aug 2020 16:44:22 +0800
Message-ID: <20200812084422.106781-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a59148e0-6525-4ca3-6df9-08d83e9befe5
X-MS-TrafficTypeDiagnostic: BYAPR12MB3047:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3047FB71B64D60A9CE78DC92EA420@BYAPR12MB3047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: reaT7r4Jo3ScrgDtPm7ILS8hUeQjz9yVRd9qFI/1hZF8PrNGp+3zNkzbENI6oqkaU8xw8u6uYal7rQ+6VCkmmwu6rlKrsaPRoLayZGwGp9fVhPwcjSskTWL+gA2nXytGTtD5de1P0ZiOVplCd3fIppb4gFZTPoTBGy6g29GSYDu1YIp24uOwBEnBohKU8sIe0leFFZuod8fBySNWAFRk35jgW4u0OuVQa2YNDv2vYgcLZV4p6hgOP0IQyKNae3AG0xGOH7QJRqTP7G39EMIa3SgUqaWTSaUd+yiBMxIjnkcVZdGPQ2uERUEc9QcwQKDcyy+9rqT4pH/EMPq0BhirOPpDv8QjYz9bTay2l9L4hf0++dmSfJ4iYMDUzrt66EAk/+LJQcvwxzRJZLiK+uXWFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966005)(81166007)(2906002)(70206006)(70586007)(5660300002)(356005)(82310400002)(82740400003)(47076004)(83380400001)(4744005)(86362001)(26005)(8936002)(36756003)(478600001)(426003)(336012)(54906003)(186003)(2616005)(6916009)(1076003)(6666004)(8676002)(7696005)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 08:44:33.7729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59148e0-6525-4ca3-6df9-08d83e9befe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3047
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
Cc: tao.zhou1@amd.com, kenneth.feng@amd.com,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gfxoff is temporarily disabled for navy_flounder,
since at present the feature has broken some basic
amdgpu test.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Icc030370997a66fb9f01cdd4b1c45816e3c88584
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d851fe80eaf4..de6e6de41867 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3610,6 +3610,9 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 		break;
+	case CHIP_NAVY_FLOUNDER:
+		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
