Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2017C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 02:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9BA22255
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 02:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pMq45wC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9BA22255
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 920016EC07;
	Fri,  9 Oct 2020 02:34:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B936EC07
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 02:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mbqamjinfxpg8WEN07Yy4N/il6FbEZ1mTrPbM1S/MxZFcv/Kkt97LRnIjRxAUyyRNtZwfjvSUoglsg03QXBh9kWpYGBDO2njOsryi3H8Qv5K3bOA+14yfx3bNNyZK/e0P5fo9jIB73MYE7G4xP7qrE8CLGlCpl0TZQRIigQYWvgy2ld9IW4WY4kTHfTzQqt9Ar0cRIc9jp4Am+5izg4Lze4P/LHFZ32b/RxbSd4okEURpVDfVPhLJ8obluVcH2mFHLEGkSfNDjDTiXrzAMoiU8RAt2IrYKMtB/Dm1Xtc2B5kjuGkQ/54vyEqRn/dpDtbL6uk3Bh8t8+1cai+Z7JeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+8W4cN8W8sq5YnCzqNusk/a9iPY9a4iksUPQgOU2DY=;
 b=jd+vBf+sVpus6ZrouXJTFO9NE2eO1DZaAAilDjVKMu72AZj7NQnJIt6aXgEmtSTtMqpVnUf1OLcJKOa2JMzvWwNErzL2ofSOFg6rfGccDCzmYAu/+kpuelh3YQQXVPbolBp4OPuSbiilVLoi3vbHNOpvPZByXYU9pIh5Lfjl0ia8vipz2JGXg0MbSwfjKKDPVxooiEkXnurMLU/0lRbICL+e3ci8rDGSDHkRMZO3tj/D19zzKsscSnTXCBx7tj5ugIp9syQdGW9LRSJxPtAsoQw8AMXRE28OmIeJT0WTu3FHsu6HBkNH4m2qnCrNutiki2MqtnoEgIG4Qexp2u0cNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+8W4cN8W8sq5YnCzqNusk/a9iPY9a4iksUPQgOU2DY=;
 b=pMq45wC1xOq5E3kXnLfqfABL1UJLWH4A+n6RmNYDkhZ4CQ91kfT7aK1yGitnUzVTlkyoJHLg7TkmdAA57B6n8J6y3JbV76mz6coFZAcvXrffJtOcOjv+YNxsLUUiayMWqpauxEczGmuahaOzAZQwT0QqVRk1OaQsGNeyzUOFxE8=
Received: from MWHPR12CA0042.namprd12.prod.outlook.com (2603:10b6:301:2::28)
 by MN2PR12MB4030.namprd12.prod.outlook.com (2603:10b6:208:159::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 9 Oct
 2020 02:34:10 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::67) by MWHPR12CA0042.outlook.office365.com
 (2603:10b6:301:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Fri, 9 Oct 2020 02:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Fri, 9 Oct 2020 02:34:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 8 Oct 2020
 21:34:08 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 8 Oct 2020
 21:34:08 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Thu, 8 Oct 2020 21:34:07 -0500
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove warning for virtual_display
Date: Fri, 9 Oct 2020 10:34:06 +0800
Message-ID: <20201009023406.809601-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 502961e3-e5f3-477a-c527-08d86bfbcd10
X-MS-TrafficTypeDiagnostic: MN2PR12MB4030:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4030C5EFE1DCCDC7026B68708F080@MN2PR12MB4030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:313;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqn4ENEldlOqLOxwGkpYm7XdnximrVvH/bvJBJOJbz88hz8jaEUtCIldoR4arPbXgUMGS2wxYzRSszWTX9CFWjYj55LJPXwm3uWD3PIooaq1cS1DUV90gRn0d1WoZEbPkbrcIHnsS16HdChBLGHXGP8NRvpLv2Y+fqvhGVpxvied/PZTtkMjwEEEc2reEo0HCUqEeyLb1t/Lhmqg+28AlXiJU9tPJG5gBkd6FE5bElza52gyAoZW7vVmsKpIuXiT20X5reSMSn5asZT9hBvFJvKzjrMZFV7fC0c350b0733meojZrQHaw4muCaljtG/otxx00IhqkMDU9uXSl2cuNPMz4nGqSs+IBBxHCSSNprSq/F2FBhNUaNWYkhCh+nu/9LVWKYnznILlgipbDeitvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966005)(8676002)(26005)(7696005)(4744005)(5660300002)(426003)(83380400001)(82310400003)(478600001)(186003)(336012)(2616005)(36756003)(356005)(81166007)(4326008)(82740400003)(47076004)(8936002)(1076003)(86362001)(6916009)(316002)(70206006)(70586007)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 02:34:09.2627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 502961e3-e5f3-477a-c527-08d86bfbcd10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4030
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the virtual_display warning in drm_crtc_vblank_off when
dev->num_crtcs is null.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
Change-Id: I755150a32478d8c128eed7ed98a71175d2b3aefc
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 469c05fd43d5..b4d4b76538d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -174,8 +174,10 @@ static void dce_virtual_crtc_commit(struct drm_crtc *crtc)
 static void dce_virtual_crtc_disable(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
 
-	drm_crtc_vblank_off(crtc);
+	if (dev->num_crtcs)
+		drm_crtc_vblank_off(crtc);
 
 	amdgpu_crtc->enabled = false;
 	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
