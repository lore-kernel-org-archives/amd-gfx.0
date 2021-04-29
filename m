Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F263C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8D36140C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8D36140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492E96EDE9;
	Thu, 29 Apr 2021 10:27:21 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2042E6EDE7
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 10:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1Y0b1LArNCxxDH0NkMcou8KgpsR4AjvzzCAUInYfgi2NgaN922/RrxXKE1FqAeiPwzEu+UispIfaOpYkz54AELH6e1Zh6+YPVrqwSB+6oDVXm+BObPPpcpozi2jEHTFp7IdYjWw219knRFjlhfd9jlvpTTIlgoICQ51OQmARpvKeTEGKg+k49enAd6eTEKNNMOi2ivYeUH/yLqe/6Iu2kHwuTYG6doit0TsAeOsSp4L/L+3WM4C5AgBwfkQpIQJlWJqOsG4aU5Rm3nTLBQcMRXs3ZfkDaZgtXcNhLpMVLi6yTKU3drRAj3GKGCpkYRYiHV05Es0XPDhLClrcgLcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpptAnVKiSXOJUq+hCCqxP6vAG1zDxOuUfbfJIpBgxU=;
 b=H3MfH4U9E77rcJcbkKL3d3VcTFPjd5vbWJGyo/NYA4e7puv7oTk+iakIu/cjCbX/i5s02+Me8P0viZtm6ixtEnOV1PB/rOq4F5AgmlNpSgT49u8wgU7REZm6z1AKec7CmAHzotVfDB9/gTC9Vws3yfFfNfgmVJJQfaITJmfILfzCiGaR+1c1bFbRuHHdKoFnnYgUKJzUzW+F8wtE0tsrzPSaSP1xjOc2k88XIRcPRDaUsJsIi03WHr4GxQcUpIPnqXc9r01HmdeqQ1mHmj3z6YQsAeOVf9uusuGSFljeQkWWV6oTg5g350biPYYasc8dVNCcAzy27riVHyTBz6i5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpptAnVKiSXOJUq+hCCqxP6vAG1zDxOuUfbfJIpBgxU=;
 b=UJOOLxzA5hziT4H5QpA+Ns2PWYkU9BuBPylmlFIQy+woWkopGLJtkoBYdM3DLnBI2OK5393cpo9WXvFm+KXYi9Ct3uzIAdW4wKn8ggU5R0+JXGUBz8nWQs1wnP4B36hd1leiyGFnZTArtVCqndUCT8zFde9PSBKpICsfD26msZs=
Received: from DM3PR03CA0003.namprd03.prod.outlook.com (2603:10b6:0:50::13) by
 BN8PR12MB4769.namprd12.prod.outlook.com (2603:10b6:408:a7::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.25; Thu, 29 Apr 2021 10:27:16 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::9e) by DM3PR03CA0003.outlook.office365.com
 (2603:10b6:0:50::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 10:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 10:27:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 05:27:15 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 05:27:14 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 10/12] drm/amdgpu: Skip the program of MMMC_VM_AGP_* in
 SRIOV
Date: Thu, 29 Apr 2021 18:26:42 +0800
Message-ID: <20210429102644.31172-10-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429102644.31172-1-PengJu.Zhou@amd.com>
References: <20210429102644.31172-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acb1e824-f693-480f-6fd9-08d90af95c82
X-MS-TrafficTypeDiagnostic: BN8PR12MB4769:
X-Microsoft-Antispam-PRVS: <BN8PR12MB47696719383AD1E0608201A4F85F9@BN8PR12MB4769.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ia8W/pjDh2Vyft+8yXYfdaCkSTwTDAsgtEKjFHdE6nS21QqacUPLNHArlcsTEe6vMALiy5pTkA9q6o+YcBYcxxHjqdv6AeDrnmHKg0AconO9cr3D5gme4yEnJY9Shoi+GIzZzu/L6EHOTS8kphYpKN/ucXTRSF2VX5Sg20FJdqCatyKOZhO5e/O+R3mzH8QbhuxcL3I7JZxGMpIdDGSIciHq/pM9mOArxTNapJnLKS6c9PtT1SoLeqkoj2r81vDB08uZQlR28AKI/RFnKd25rXXJ2dQ6dBrcdtZbKb/3Q+Wba8gIsm4pZIiXj2/xX3sOBT3tDJy14Z7gN1hS+hRkM7Q1X9+JETyhFWA830tcAWpcXrxvybDAMGNEjnR5RYm05hnKP4WXsHHDOt+525rw7xDc963Jy8LOk8Hs9mqEGBMSJcoiKACtksGS6b9Y7IXhYOAvleveQ7kirhOc/g+UlpAg3hl/xsOK1QOc7QaqVjr3Z5+dpGt2xxGzQ37dRsN51/DjU1QEsdukL+EvYyJFy4pKKERxBJbiQLcqUFGsC0zVzh3KQbZJXbXkCtHyIVOsi8x6zbaDsdTAZ5f+V6BO3+z2WuGogOxxLICO+lxEd/grK+xWcldL2jG5F4gdNKE7Fhw5oQBD50+DqMmZTsLzpJJkYYq4+h+j+W+LN0bsY5tBhd59m8DKIbgZkTrlJSr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39850400004)(396003)(136003)(36840700001)(46966006)(8676002)(356005)(6916009)(1076003)(7696005)(426003)(83380400001)(47076005)(2906002)(86362001)(8936002)(36756003)(81166007)(186003)(2616005)(4326008)(70586007)(70206006)(316002)(336012)(5660300002)(478600001)(36860700001)(82740400003)(6666004)(26005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 10:27:16.3783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb1e824-f693-480f-6fd9-08d90af95c82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4769
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
index e24225b3d42a..422d106a650b 100644
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
