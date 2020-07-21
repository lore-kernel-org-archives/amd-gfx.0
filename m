Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE9DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633C8206F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nx1RSK7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633C8206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0CE6E040;
	Tue, 21 Jul 2020 18:07:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 289AD6E040
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 18:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSEOGNhpsdQX8M4Sf4Hn0/ZxAU2sRZ5IcMqb+UfPZ+vUPCjJUN4pSiumY74bON+JblI5EU6Dyl3BEPbFO5hqtSZXWHdsxciMwbJyx0J73hbN2XrpAT8R22ZYOKHUMwgLLl8GzdwwIeBu850CXqtBNscAGUDYxGNveoDOCTTuMns7+TSrs+UC56q3RRzWhQJhbY3rUYiaeJAEf3m+kCh+7gUPKUV9tqKZ2NSYiSjeaSnKxKyZ4NXmX3t1sjgagk9hPOyOa9LQDYuF3Sp5jO0vM/82nVCNf19YJR4MNeZOBtECQ4tzzqUObbP8td6mzStqqdlEosSqf6nb4v7H1And4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liZDQbvj1MZcRBFurKpBes6klqmJmCQkbJoAqv9WDN8=;
 b=masfFQW9nBh9q0UG60BEyXan5Wn6iEhafnIuTUEd0mkUbCwXcKCJnvHWhh0+ZraQDll1pjQFnGBrGr/6gMPgaEuJNgGkLMRkzeg7gSNNr44UENl7x/9QfghK1E3t9NxOQE1UCPcKhdl1/ebcMvHj75xN1tHXfSZ9K48Yg/IRR2d7OIrPq/UPrLC1QQstkK7ca/+U9e0MvEW5ebOXwvqgyQwcTsLOTs2ZEw1UZFJ/fuJfChTTXd39kIlJH3FL/Q9Eyb47Zi4NjDX3TL8n5skI63QbKyL9OTyiRXmoHoovUT/kdvkseROz8+puccWEhLCTFrpMXXLk0bieMRmBS/TGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liZDQbvj1MZcRBFurKpBes6klqmJmCQkbJoAqv9WDN8=;
 b=Nx1RSK7G3RwPnXtqibPWpIdX7Kna+lSsM9Wwkj6Oy00to40GCcZemgr/7bsBcH+W7M6kmuYf6ivHkYou0Y/870/M7CnaMS3gz8yPFFE0BszpdSp6TbVSZrtg/c4zwu4NWHzBufpGVjAK98uOL3RRcoOGo7o02Aztf6eZyDg9PG4=
Received: from BN0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:e4::27)
 by CY4PR1201MB0071.namprd12.prod.outlook.com (2603:10b6:910:1f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 18:07:33 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::c5) by BN0PR02CA0022.outlook.office365.com
 (2603:10b6:408:e4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend
 Transport; Tue, 21 Jul 2020 18:07:32 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 18:07:32 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 21 Jul
 2020 13:07:31 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jul 2020 13:07:29 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Use seperate dmcub firmware for navy_flounder
Date: Tue, 21 Jul 2020 14:07:22 -0400
Message-ID: <20200721180722.6344-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966005)(70586007)(70206006)(2616005)(356005)(7696005)(82310400002)(83380400001)(86362001)(2906002)(36756003)(336012)(6666004)(1076003)(8676002)(81166007)(8936002)(426003)(82740400003)(186003)(26005)(54906003)(110136005)(47076004)(5660300002)(478600001)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b46dac98-acc8-4421-2e12-08d82da0f0a4
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0071:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0071B4F44D00EFE56D768446F9780@CY4PR1201MB0071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PX/NzC2a2JRHYGywdgPNwW6t0i9l61g7gCmsevq3aOnHqzVbnMvlxjC556JTxx8qEQQ2S8+O7DnHBykA+8qRrzpkwgMBXo91hBsc7HiU7KyTU+zZkG1BdBv7hKknOm/ApWgLXk29A/1FA6YakLIPrYoS8PR6Q7n5hSnV/obWFqwa6GKZs187z+Wf4lD15L97MPdoO6X/1xBE+wO8PwK1sc6HPNz8HXgS2mQbJ6ZTJCfEBU8DHI3vHTzhWhZeNCcpdrIT3KH8El/+zHmOw9MWOhbXu3vG/PrAiYX2dmnbxw0yOkts0AlM7wSyRQrD03w7th1r7ApMSU8tYrjlN9m2GCL7CLCH41s8HP0oGzj7UhVaEKzaT8NoiKIP+7KRMu5KrKVhm0BmxCeUZCgjPWyzFA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 18:07:32.7794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b46dac98-acc8-4421-2e12-08d82da0f0a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0071
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
Cc: alexander.deucher@amd.com, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Currently navy_flounder is using sienna_cichlid_dmcub.bin.

[How]
Create a seperate define so navy_flounder will use its own firmware.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 95185cc58fcb..268eb7ddf364 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -97,6 +97,8 @@ MODULE_FIRMWARE(FIRMWARE_RENOIR_DMUB);
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 #define FIRMWARE_SIENNA_CICHLID_DMUB "amdgpu/sienna_cichlid_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID_DMUB);
+#define FIRMWARE_NAVY_FLOUNDER_DMUB "amdgpu/navy_flounder_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER_DMUB);
 #endif
 
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
@@ -1185,10 +1187,13 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		break;
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
 		dmub_asic = DMUB_ASIC_DCN30;
 		fw_name_dmub = FIRMWARE_SIENNA_CICHLID_DMUB;
 		break;
+	case CHIP_NAVY_FLOUNDER:
+		dmub_asic = DMUB_ASIC_DCN30;
+		fw_name_dmub = FIRMWARE_NAVY_FLOUNDER_DMUB;
+		break;
 #endif
 
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
