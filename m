Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E88BC47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 05:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCF56121D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 05:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCF56121D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD476E104;
	Mon,  7 Jun 2021 05:55:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D0D76E104
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 05:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fw0TVgTSAwFm3A/cYXD59vMqLwpl5A+0X7WDrdJ+zVnA2R/GtCKr7R+8T4qAg6BEs6es6fVOerFSGWyLwHCbA3D8/2KXFJnC1Ius3a9lOry0ZH7kVlcFNmDMfYof4U31gnt9n/B253LGrS/ycAKIu/1DCJRXTxCSqXEzjjMn6lZJX/90fcHgLYd68cIreZDBRH5wT20DIfG6/21QBXK7d32gf74GZgR4DWqAs2q6NboWiSRKeGpMMB3lL7C1deDNW7ziX449cDbyntUSu1a5jMi2M1ubNRlAxg0GiPBMz+mSZZfBGEyS6Ppd6Jg519AWwlBskPXZb0QWwAXRFDdDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMa0fvubpsRyaaJYV0wfiTHhQaXpTfoDS8ACQGfx5+M=;
 b=oGFbdw2L4Rwgvf5IUTzp6kD8v6VjvKviHs87TcvgXkUN9XsCNRa29dxJLzenEzOMCXrE94xz6gorXGszwMQWShH2/55isxNOgFsYIz6w2XlQ4RuPFbHzSj95yslJs8cVIZxZuXlAcEqv0kiYxyV6InbLMs4igUP0M9Y0uq+B+ffLNnHSXmBB8WsdOiXimdMFmoA7Lg96hOFWm4uHl7sbtyMa2j3v+eQ7wmDT8bHhb9lErph69ux2ToPdXZEuLWJrM89z8aIcndEhsR1HG4NwI+Ufnun7QSS0Z83p1zuXyyy/QvtYeBnTZ020XeJ7G/m9bPADEHLrdou9QNX4iV5grg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMa0fvubpsRyaaJYV0wfiTHhQaXpTfoDS8ACQGfx5+M=;
 b=1NJs10iyifxK7godVwPnt1MsuEQ4XSh+dT29dAHYU2Yq5Gb3e+eprBTnAZIcgMh9N/m+UYXZwjEPdXgVW4BmF0BrCNhb9NytiK0HU66qxe9Q+CZWxXiKKfxdyP5mJjmY96i7rBvlTduVrMcBqNIsgewEX4KMv95f2h/yyppL+60=
Received: from BN6PR17CA0043.namprd17.prod.outlook.com (2603:10b6:405:75::32)
 by DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Mon, 7 Jun
 2021 05:55:19 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::6c) by BN6PR17CA0043.outlook.office365.com
 (2603:10b6:405:75::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Mon, 7 Jun 2021 05:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 05:55:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 00:55:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 00:55:18 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Mon, 7 Jun 2021 00:55:17 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fixing "Indirect register access for Navi12
 sriov" for vega10
Date: Mon, 7 Jun 2021 13:55:10 +0800
Message-ID: <20210607055510.24988-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e834d3e-837d-43a0-0c47-08d92978d4ab
X-MS-TrafficTypeDiagnostic: DM4PR12MB5341:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53417865B66B2B3DEB25C832F8389@DM4PR12MB5341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZxjQFCfD3mECvcGGC8DKbbnZ6t2DeMbx0TnFGDVI3Cwj8m3OgRr/k7M0G+pDLPEyThPpETsuCKSniL0zUrzYILK2M55/AZwIZyN4Hd24/rCim/aEYYz6lgeMTJSvPNbsMLQLyVHBAo+qnNlt5nGS7cNdCsqesH+7ivRGa/gXB6CRwu/SokvAeCd2IBLXbmmT41P3azslCY004YkbxGvB4f2HkEWdPbhJMvqnc5naQZnXJB5o6BFbGUkcUVchokxOSZobHB+H/OmtpT3slGfa8U+u3jfhSFL6lgHJlBuI5a3JIM/1lXEXac4ac3V6axDrNronfd9yVwPU3dpRWwfyFY98Qhvy3KiTLxsVqhJqu21gsqobmxB9j1qW0p3heUlk8l7I+bCgcaTt95LjKb2WANbEZnIajnxjfStr5zOsJZeRwggPrsL8zraencxcgUlxhoSvRhmCHpm84ilWHp/tR8LI1IUt/SGtlLat0PeSkN5BhBqaVXfONAotGUxKoQ4DlxfgP32PnXrgzQq2nEKXkNyZ4HHIx+hwWdin/st609MjO7T7KI4a9b2hA9UUIE3rMBJ8Hq9tqFpseQUMoHVQbJbmoCA/LfOxFSADB58dhzAdSJ9dVfy+ppI+LC+hjWp2F0Nledr7bNHpourek7gqsY3UbjL6P5tr708Kb1+kSTu4GA7bo6BJHEInLyOhn68
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(478600001)(2616005)(36756003)(6666004)(426003)(336012)(36860700001)(82740400003)(47076005)(6916009)(4326008)(356005)(5660300002)(81166007)(82310400003)(7696005)(86362001)(316002)(70206006)(70586007)(8936002)(83380400001)(8676002)(26005)(186003)(2906002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 05:55:19.0010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e834d3e-837d-43a0-0c47-08d92978d4ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
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

The NV12 and VEGA10 share the same interface W/RREG32_SOC15*,
the callback functions in these macros may not be defined,
so NULL pointer must be checked but not in
macro __WREG32_SOC15_RLC__, fixing the lock of NULL pointer check.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 3 ++-
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fe5908f708cc..044076ec1d03 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -790,7 +790,8 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
 			       u32 v, u32 acc_flags, u32 hwip)
 {
-	if (amdgpu_sriov_fullaccess(adev)) {
+	if ((acc_flags & AMDGPU_REGS_RLC) &&
+	    amdgpu_sriov_fullaccess(adev)) {
 		gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);
 
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index f6cf70e69cce..0eeb5e073be8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -28,12 +28,12 @@
 #define SOC15_REG_OFFSET(ip, inst, reg)	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
 
 #define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
-	((amdgpu_sriov_runtime(adev) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->rlcg_wreg) ? \
 	 adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
 	 WREG32(reg, value))
 
 #define __RREG32_SOC15_RLC__(reg, flag, hwip) \
-	((amdgpu_sriov_runtime(adev) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->rlcg_rreg) ? \
 	 adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
 	 RREG32(reg))
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
