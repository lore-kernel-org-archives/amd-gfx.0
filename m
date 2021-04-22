Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD52C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 09:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C667361458
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 09:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C667361458
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2817989C56;
	Thu, 22 Apr 2021 09:33:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 566EA89996
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 09:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMMwzxIRx7bwOg/AwulYVeCYVHIO1eOMuEZDy924H/Oa5jv3Wbp3Cj58Tkl2y20loifLB3kUuoKlBhd5Xg0H89aSbE/IXxZvnzOvoBR8vUspmviqYEBvXgDjWEYKWj0EYGO2ygzx9t3kJDvmBPaVVqIX7uGVo0GyDXRrouUuEJ+UNBVbV+EpeqvKgLRxRCogovsYF8qoR2Qf1fquxHShEnpltJ2XgOHHhYBBzmWIPRfR9HJvX8iAUWb2a4RBm4bH1UjX99ilfwkKGaQwNG13YhYMtWqgWK5tjjTDt/CeMemCsjJMXDbk5uC7cmDZvTxtlNWIzU1jLhVXSgtRCP/A+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ubHYQzqdh1BvMoMj/n0A9FJevzOmy7RDFwbj+w54D8=;
 b=iens+O5r5D9pFPcgU5gSXJkvfg2X0sa6N4hbfXN1LyYREdkIA/qbrTKYxi0gVZ6qFlKHyVKmKQeVog4VP4m691ZKIeSLq0NErWhwdpfo/Uip4u5AaynCSs+RAXotkk5CJ6rhKcurGWDnIDyKRWchGHWGlx6yiNvZHOMaI5kmME7C9mnisXSxHtVND4KaU5PxWPlSemZmJIF54pnQSalvQAVsDCWET2EQkCZbpFViywH4qxdSjwP5D6IiQUFmPJ81vX0lqNbUou+yOdPmcc9WfmEN/8egt5fNAMo15CxcXE/kI54L6DEFoKlUnfYnJhm8ilKDMdxBN07q7+tQ+JB+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ubHYQzqdh1BvMoMj/n0A9FJevzOmy7RDFwbj+w54D8=;
 b=uM4QzEYPghWnwPcWjqp7z4k1g4KMVzgQqVJR4jmCA+SGxKiZeprU4V3bD5Tx3sdhKKQnUTJLO9FUWkOwlQglPgmDH4TjavUUZ6kaxPc1yrdMAZcC6tzfgxmaR4cw5mHTqJBoL00MT/wsEbCgvaIJdfHW3TW8NZ+5F5Lakz5gnh0=
Received: from DM5PR20CA0046.namprd20.prod.outlook.com (2603:10b6:3:13d::32)
 by BN7PR12MB2801.namprd12.prod.outlook.com (2603:10b6:408:2d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Thu, 22 Apr
 2021 09:33:06 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::bd) by DM5PR20CA0046.outlook.office365.com
 (2603:10b6:3:13d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Thu, 22 Apr 2021 09:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 09:33:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 04:33:05 -0500
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 04:33:04 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: add cgls
Date: Thu, 22 Apr 2021 17:33:01 +0800
Message-ID: <20210422093301.922-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7fecba4-fe9e-4c8e-05fb-08d90571a29d
X-MS-TrafficTypeDiagnostic: BN7PR12MB2801:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2801648CEE069FDCC79908A28E469@BN7PR12MB2801.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqopKecjdOq4Z5WxFhAYQe+1TGuFQ3hyhg0CKOZhao5MkXsJeuGH140CBRC/PZVzVaHq3n5poBR3pBY0lN3DGNDDgNL5k3B9CXmfmJtEBAPnYIaZCbyrhzbnS/Z+PdUtKf0Me8+oQqF4v+dDLmYGQwZaZtSW584bBvggOQ2+qRrhV9hNP8nLaOmSebdD+L/UgIcoWoDAh+20vW0VQYgt3ZPceohBSwCf/LKy7sV/n5Pn2jTHTPyY7/8uXfo5QiNaSez12pWSmyf8u/Hh9Pg2u6sdtXuouK2cXJz7zq6jGKgpU0jR5eBusUu13QA96ielGGNyvMdtLxZNoFdaRzTvOgU/jq6gJN4+nX668RNbPDCZUsH3aCS7/MRWgPXUol1sPfUqcCx9cHNeJZKPdTOTC77OzI8BOnadFz5qD6wuwmNJKdQJiVBoYb7xluk+aAsWbilLO7bZEardoc3urgPmTjBIi2RVSCVhLG6SfxEZtbgmNmOrPHUBY5HptaKxM7JvC6Z6dB54AyhUOyHdX2lZ3p5g6a8mP1PbPOeBfqaL8kwudPIsM/3tr7XCVNpK7yx8FXmPEt5OteymvE2xkT1zgOEzylP2PqwCIWiTDcSR1A3cnTvPxHj8XckDhX5+u9fH1tZfX8WCCELFJEnL4XNrkTLLWT1Kot9niqLMeRXgJLORMenhvIdK7eqAHjtDK7dN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(5660300002)(356005)(316002)(186003)(8936002)(2906002)(36860700001)(336012)(6916009)(81166007)(1076003)(44832011)(82740400003)(8676002)(26005)(47076005)(6666004)(70206006)(478600001)(70586007)(36756003)(86362001)(2616005)(426003)(82310400003)(7696005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 09:33:06.6229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fecba4-fe9e-4c8e-05fb-08d90571a29d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2801
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable cgls to improve the runtime power efficiency.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 0142f6760ad2..9c4f232e81c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1065,6 +1065,7 @@ static int nv_common_early_init(void *handle)
 	case CHIP_SIENNA_CICHLID:
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
 			AMD_CG_SUPPORT_MC_MGCG |
 			AMD_CG_SUPPORT_VCN_MGCG |
@@ -1088,6 +1089,7 @@ static int nv_common_early_init(void *handle)
 	case CHIP_NAVY_FLOUNDER:
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG |
@@ -1130,6 +1132,7 @@ static int nv_common_early_init(void *handle)
 	case CHIP_DIMGREY_CAVEFISH:
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG |
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
