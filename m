Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FC7C43618
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7503761418
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7503761418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11A4F6EDA9;
	Thu, 29 Apr 2021 08:14:23 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 488356EDA9
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY/i65N4+/S8OJ4Qhc5bsLOFF3gp8opajXpG5Bo7gQFpXUd89npzKM63XuNQnK7PuEp3RgGjDtBdYFcKjzNkauj65e2mgHA8WMhklULT3D5/pmHk0cGRg8stif5Lo3MVNgkEjaMksbq1r+9wspcTgmvRGXmnlc0w5TPRS5ROFl+mQgE/4NFJG8j25gKcF6b2M4JLpa9tdoaZPBIRUzkDKwnETfssducCMTJcLjoWDVX9LuAWbJ9+vySnY7bWzx4MxP9ehNpUFjTfjBvM1sKeaewBUAMGzXaeC0D7xNSUy6AZsjqgzOQUiXFaiUiABicTfBH4o3BsLUPnP6HmN2YOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgqkrRFxMC5/t6SgeTpcVPTUESfMdIGMtvAqDQQUWXA=;
 b=NTrgXW3rYEqbhS/yVBlCtsXcFiRneVztCsT/h/QJ9wgzQa5FnPoEb2td3L4gSUxxwYnHegspMBKi7e/K8X4PYnc0L0607lbTiPB8cpEGv5Fj7l+/ROe1X5i/eemRE0c8tZ5psFb9FJw8e62ARkToqyZ9MDGkYbSn2FwRZOTz6ASuU60BZ4tfjn2Lf9OtHkd7TL52kGBehLdZC2Yp7kZVa1ykA8BLkpxFQCWlQ/OQg6fHreNZlR84OTnUZuiKMr4rY3vpwuMpd7vBZ0sSwtr5oDurET73Y6M/bxB7/da/DGhm7XdQ/817OSM57IR+ZaPvqy1ye9giCNOEsPSxcPyLnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgqkrRFxMC5/t6SgeTpcVPTUESfMdIGMtvAqDQQUWXA=;
 b=YEi9g4k59fVqNrJSQ3BImbnMY0n8VO5d6d9g+PnRVSU1+RXv6VpLrtHYqP2ys+OHOx6yEW83zLI7ToCbnL8864IVpqcu0r7UQHLPnEHez5cbOgEkWVsOfkpVTM7dTI0xEjGH+IWb5EN816VoG8G6G+RFiS/9C+QRZlT+JAg6izg=
Received: from DS7PR03CA0194.namprd03.prod.outlook.com (2603:10b6:5:3b6::19)
 by DM5PR12MB1643.namprd12.prod.outlook.com (2603:10b6:4:11::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.25; Thu, 29 Apr 2021 08:14:19 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::1d) by DS7PR03CA0194.outlook.office365.com
 (2603:10b6:5:3b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 08:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 08:14:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:17 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 03:14:17 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amdgpu: Skip the program of MMMC_VM_AGP_* in SRIOV
Date: Thu, 29 Apr 2021 16:13:43 +0800
Message-ID: <20210429081345.24217-10-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429081345.24217-1-PengJu.Zhou@amd.com>
References: <20210429081345.24217-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2119795f-8d99-415c-664b-08d90ae6c9d6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1643:
X-Microsoft-Antispam-PRVS: <DM5PR12MB164348EAA653F3E1778F235DF85F9@DM5PR12MB1643.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJysWBcpM5AsbT7gFF42V0NHtVvNNQBJdu+8Elcf/+xjQyS/tolxTSp4m9ot/DxGjMHWcbJmmT5GZREMQ+BL9F2iNmzXcDmsf7iWCPf19/2TZQpjBWSciW8LRPxpfT6PQ55/9eGmmZAKqHIChcA8dQrHVajLoNK0uc6DZUpGX0ajUICUyk/oDymyD7qNcQX2IgjaCq9aNZsdIy3FEtyOhgfF+qW0MqI56MMDWvuxQKppRdGjo66v1PMNiXwCgAx2jSKsBffoNrq9ViTTM82gsz/x1q6ndhBk0bcYu23w7vFMRrI5Nf1t/yNVLdcJR/voCfAty68M76+LBIMYVupS+zKtssaZ2Z7MGKuWvWyHAVkdjeKIklI785SjQN5k7PuQsrr6HfcoLjJYj+l0+LB9mLscyzumAxjov/Mtaf9ZKk6DU5Dmdlh6h0MOrFZEIbGclil7SesxIJX3eZkhrZBcaXdNhgBm4pSYVK+BaQYjwP5SfXDHxOzxpdRB9JMFEY8ELMfGGakoeMpgB3I486rEGqdDwIAknNpxaziXkQuFjpdmLm3JW/WxBNspb0XfYUG+OgQjzqs8ajuw7xN1rBYpCtp3YNcTVTnXfFC4mk2h06QS+/KR4Z/waRslwDB5tv3/PIPmmEJqjXpg/hVaAXFoJ2UxNC8J4EYuQTxo862RhOFFv4K5U3V9ohasCOmp0STt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(36840700001)(46966006)(478600001)(36860700001)(5660300002)(336012)(6666004)(82740400003)(82310400003)(26005)(81166007)(2906002)(47076005)(86362001)(36756003)(426003)(356005)(70586007)(1076003)(8676002)(6916009)(83380400001)(7696005)(2616005)(70206006)(316002)(8936002)(186003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 08:14:19.3623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2119795f-8d99-415c-664b-08d90ae6c9d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1643
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KMD should not program these registers, the value were
defined in the host, so skip them in the SRIOV environment.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 630334bc3a74..468cf76053ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -197,12 +197,12 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 	uint32_t tmp;
 
-	/* Program the AGP BAR */
-	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
 	if (!amdgpu_sriov_vf(adev)) {
+		/* Program the AGP BAR */
+		WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
+		WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+		WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
