Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD7AC2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 09:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5F161003
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 09:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5F161003
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 257DF6E461;
	Tue, 22 Jun 2021 09:41:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E696E461
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 09:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9f3kPZ7rpwFTs1+U6PWiwZITba91O8ksIVNkcewqJll7hKWpPQqa3rZlFTwiZ7yKfrqptDsTazHAl6xj2jTj+Z86fMXEcPrcI0ef05/Zz8JObcp1w76YjneKy/dimyVQpBbS3DSbseSijVpFWtSHYp7ze/RwCNYEr0zqCMhxwDfyMgKvYGkG5yen/hfD7tkQWDlSoMFUCr3XCHiBaxjPcIZ1kMcDCHuGa1kYdEdYLqOEkQ3NJmO2jfgjeslp6y4wFfTf4qD6rOPD71l8sZ62xKbAmY8JTikQDaPmBivjK261A4oMy+rJuzZkmT0tJ7R5iWtztif8pckeBzrdAGWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM4wCIbG79t4NchcoM2TRqkeIqjOmrvEJZzHekd33JE=;
 b=SOVhqjCBYMpmKqlEB7VdD0AvIFHHt2vCr+lbOC2bxQNqLx2Xi2j/oVpPNTKQQgEuDOx2aUBZb+JvDFD29UgBDN+6WDkl6HSwOynniWtSNAJQq0KTpn42ckP+SfHrUa3/ud3LT1SpTmqNrQoqayqaoerc1PTRhBftlfxeHAZS9+Gw6cU7SC/A4w98zD4dLegK+I0EN7YvBPaaph84ojcQIW8vDzt0CuFLLq+Yxwe6Aodwi7NPlZ3ucoZQr6ngWbGsb/0WpCHlDOW6VgDbqPr7ElTnQRjvH62lvgCowOYeAyBhW2eEi5mwqRG6C+8VAQTW02ZhLOt55pKy1Dx74O9lZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM4wCIbG79t4NchcoM2TRqkeIqjOmrvEJZzHekd33JE=;
 b=2TwcFpMG/o8qbQQ/e9Ekw8BzfZz8ZfRRlq5gskDOFDudbaJg5jEgY7Jtg+tydUc8bj2xgeudfv5oTGe26Dwug6f7T1kAJYG5GIrVZqt+yevWFtnNc4LNRHYQ4lSk3IsExY0OLpT60kuENk6Y8oTFHfvD61fBJrftOaXU9+iEjIU=
Received: from DM6PR17CA0033.namprd17.prod.outlook.com (2603:10b6:5:1b3::46)
 by MN2PR12MB3662.namprd12.prod.outlook.com (2603:10b6:208:164::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 09:41:08 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::e0) by DM6PR17CA0033.outlook.office365.com
 (2603:10b6:5:1b3::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Tue, 22 Jun 2021 09:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 09:41:08 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Jun
 2021 04:41:05 -0500
From: Huang Rui <ray.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: move apu flags initialization to the start of
 device init
Date: Tue, 22 Jun 2021 17:40:51 +0800
Message-ID: <20210622094051.445023-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6da129d5-6d29-44e8-36cb-08d93561dcd3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3662:
X-Microsoft-Antispam-PRVS: <MN2PR12MB36624EADAEC3EBC10A8D697FEC099@MN2PR12MB3662.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CCa5zfTx2+rAIjs76SbvFDhSaiM0a77Bz6tGuKiL5BGiGUulE5qqd5yvVzza95sHvUrywgo7K6XzlsQIM3cwtwR/xMG1slr3OhoKGGZwFN2Y2bZW4KwMitxRn8zxgFJRWJeLtpblXiLORx4d/4WCt9apkBhAZgBc2BSOZ6mFSDeiBonyiy8p1f1ofheb9deGvbjP8XFsJcygL25QXmmyLYSEF6RHDUuK7DNl8fHKIOhQIWMl4jR5aKuEOZmAyx2DygsP6bcIQdzV/5sdjh8muNWKCJMo5UvIrW292A8mRtdPsEL4tjekNaMRuWSjGMnSL3vw2DH1WHGN0jxAXTaSQcDLKnIv1Edz/zaZlqACBkF18f+Mk37O+8VdWSqMaA7Ovbpi6j+yYtg/UD0KKKiUPgBODyHheKRMPZfOVPEzPdUDQRnUWoFJIapjI5RcZZqinxGSewjHCff5tEqWxFWRdcYmvEIwnhfHMR6chyenl/FUOre8/HZdbVaJcg2LIgu2d2o6BnBk+eEJt4zFh8IV3TAmdv3UMPk9iewpoXLRu+uyBHvTqXezyWLL7Ni6giJTY9lS4HGgKo/V4XZmeO5rR5AKh7mWEv3GRpsdHsHo4LlqAz5kyvcvqR+6vodcMs2mjveV8bfdbrDeWMvdB+Onv4Bw7O2eeu8Qj1cUIDgiIft8/qlO79Cb1g3as7JP/bmmn8+l7nwC2lkp0CCn/Eel5uAaw/pr1YsYb+41RmYWtU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(5660300002)(8936002)(47076005)(26005)(1076003)(186003)(478600001)(16526019)(82310400003)(86362001)(70586007)(7696005)(6916009)(2616005)(54906003)(36860700001)(8676002)(70206006)(6666004)(336012)(4326008)(82740400003)(426003)(356005)(81166007)(36756003)(83380400001)(316002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 09:41:08.1485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da129d5-6d29-44e8-36cb-08d93561dcd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3662
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
Cc: Chen Gong <Curry.Gong@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In some asics, we need to adjust the behavior according to the apu flags
at very early stage.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c            |  1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 10 +-----
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3f51b142fc83..e6702d136a6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1359,6 +1359,38 @@ static void amdgpu_device_check_smu_prv_buffer_size(struct amdgpu_device *adev)
 	adev->pm.smu_prv_buffer_size = 0;
 }
 
+static int amdgpu_device_init_apu_flags(struct amdgpu_device *adev)
+{
+	if (!(adev->flags & AMD_IS_APU) ||
+	    adev->asic_type < CHIP_RAVEN)
+		return 0;
+
+	switch (adev->asic_type) {
+	case CHIP_RAVEN:
+		if (adev->pdev->device == 0x15dd)
+			adev->apu_flags |= AMD_APU_IS_RAVEN;
+		if (adev->pdev->device == 0x15d8)
+			adev->apu_flags |= AMD_APU_IS_PICASSO;
+		break;
+	case CHIP_RENOIR:
+		if ((adev->pdev->device == 0x1636) ||
+		    (adev->pdev->device == 0x164c))
+			adev->apu_flags |= AMD_APU_IS_RENOIR;
+		else
+			adev->apu_flags |= AMD_APU_IS_GREEN_SARDINE;
+		break;
+	case CHIP_VANGOGH:
+		adev->apu_flags |= AMD_APU_IS_VANGOGH;
+		break;
+	case CHIP_YELLOW_CARP:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_device_check_arguments - validate module params
  *
@@ -3358,6 +3390,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
 
+	r = amdgpu_device_init_apu_flags(adev);
+	if (r)
+		return r;
+
 	r = amdgpu_device_check_arguments(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 455d0425787c..1470488a18e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1275,7 +1275,6 @@ static int nv_common_early_init(void *handle)
 		break;
 
 	case CHIP_VANGOGH:
-		adev->apu_flags |= AMD_APU_IS_VANGOGH;
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_MGLS |
 			AMD_CG_SUPPORT_GFX_CP_LS |
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index de85577c9cfd..b02436401d46 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1360,10 +1360,7 @@ static int soc15_common_early_init(void *handle)
 		break;
 	case CHIP_RAVEN:
 		adev->asic_funcs = &soc15_asic_funcs;
-		if (adev->pdev->device == 0x15dd)
-			adev->apu_flags |= AMD_APU_IS_RAVEN;
-		if (adev->pdev->device == 0x15d8)
-			adev->apu_flags |= AMD_APU_IS_PICASSO;
+
 		if (adev->rev_id >= 0x8)
 			adev->apu_flags |= AMD_APU_IS_RAVEN2;
 
@@ -1455,11 +1452,6 @@ static int soc15_common_early_init(void *handle)
 		break;
 	case CHIP_RENOIR:
 		adev->asic_funcs = &soc15_asic_funcs;
-		if ((adev->pdev->device == 0x1636) ||
-		    (adev->pdev->device == 0x164c))
-			adev->apu_flags |= AMD_APU_IS_RENOIR;
-		else
-			adev->apu_flags |= AMD_APU_IS_GREEN_SARDINE;
 
 		if (adev->apu_flags & AMD_APU_IS_RENOIR)
 			adev->external_rev_id = adev->rev_id + 0x91;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
