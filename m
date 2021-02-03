Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E48C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 10:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E5564E2C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 10:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E5564E2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C836E3B2;
	Wed,  3 Feb 2021 10:47:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7129A6E3B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 10:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKP2lPTJcvwIwbXnJyvkpDJ6La6LCjRNa5RW0KGDXRZgoNOpUISQlxjrAch6D6Ur1119KX9+QwHtQfBUM40xuZDzEMzhe4T3tzbo9TdQMh+3enflVLtZfh2eq7gtGvA7iyJGh8x4172M3/jXYGEuiW3Aj7UfSqxltKL3TB33USZXnXrqS2n71Dz8/WxO94ZqzhhuKIvEPm8ci58zHDLuzZJ16QHIhgyYlLBdDHoYDoJtEqREqjTKLj++mh/NuD9U2Kfw3X/i/5x/zZnvs7q74Hm9wuPvp2Pk5DYQHOlJ+jgftizJ4oUj3yv1raDTTt/l2mpz62JnalgZmVIFv683AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioy1NPCmjn+0HBrUk53VKHnus79nHFN/b8ic36OdCrw=;
 b=Ncvs4MYYxN/ZxZxeGimF5slmVlNWmNmK+R5VnD+KtWz5Z6KqELzuW2uqtMkOhDcQGtH534ZgobK2bOKNyZ5WcNETwKRXpSPYk2B3soc4XXfSkGo61N8rnZm+B94BpYr2TY1zDieH8YJ6Ln0TD1+qqggVCePSwCpeKM7Xejm7ogDRAltd6s0M+BxVepRLDSzgIKCFWt2kWhrbg+q7Mz8Dz8q3xq3KCFVJHf3NvMjSaTIVG/giqzRhGJnBX1ciFakQOkTdjpRF5hFqdZ9hfMhQRdED3Lsu4dL+8h729L5OqTSAGJ399UKFUFDu9dA5gxMTgHEH+G7X0EPUCX4qRvcOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioy1NPCmjn+0HBrUk53VKHnus79nHFN/b8ic36OdCrw=;
 b=eYshO9rAq3rJt9kma+2VY93NaNtJpRZ4Yca52IL1P5oohCT1sKvvrk/eulCI0zi7f1VRr3q1wyg7kTbfci1yby/tXdxJhsPqVbd/Cv/wcseRTG3NEvoirrbTPaoo8YV/NPfJOAMyrkqtoyodLfRUdzL+FgTwTkO7y8+3vUHE2GU=
Received: from DM5PR12CA0005.namprd12.prod.outlook.com (2603:10b6:4:1::15) by
 MWHPR12MB1262.namprd12.prod.outlook.com (2603:10b6:300:12::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.23; Wed, 3 Feb 2021 10:47:32 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::cd) by DM5PR12CA0005.outlook.office365.com
 (2603:10b6:4:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend
 Transport; Wed, 3 Feb 2021 10:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 3 Feb 2021 10:47:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 3 Feb 2021
 04:47:29 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 3 Feb 2021
 04:47:29 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 3 Feb 2021 04:47:28 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd/pm: enable DCS
Date: Wed, 3 Feb 2021 18:47:25 +0800
Message-ID: <20210203104725.2000-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f980f12f-b9e3-4515-f3f4-08d8c8311b1c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1262:
X-Microsoft-Antispam-PRVS: <MWHPR12MB126299EBDE323872BF0F695D8EB49@MWHPR12MB1262.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylY5GcdugZ1MZ74wSByR0O1GfH0OCUWK9EXTMAFPXMcTBH8hdI3OlakZqFRMePu+ajlv7F6kpqxGCSiG3b87V0Qw6FOYVyljLOPLp27VVcc2XNhWszkMjpjREND+oH4X6y4G4QZDo7d1funEftmToUKYRL9hFJg/ibOwH4sB2Yaq5t/NqMYbvYWHS0unt0w2Bg+B4MtRU0sa30OXoGnV6tZiHPSCyPuJsTL75Kb0cFoU+lrp7ceSvpqaM7o5WJSXng3W7FAk9qU8VB/UWLbt9zhjG6aqkuFAFll4gOX38STONpb1mD4rc4SVKzFNJLcJ9Z/Ha0qgLrWeXLR2tH4JPe8W13Oq50rBZFHV11/SYKeB8pFequSK9hp9mAFGjSS5yaWEc7zKDj+ePdjgEIHaDU5oqEY68bF00z4PeVCPXVfiD4s9J92kpHOGol4um56bTT7pUCvZhQeE4SnOjXTntN5tRz7a8BwdTjuslqIu6/k619WAm8H0N8khG8qnsECzP5QPvY1IoeMqd/zXDGYUOo45/ULKITF4JqlBNq3tU6qXbJj0JOOiCLbXFy15C2WWESTUSPJen2xXJgvR6AOctmFlZQhFb+LZnmOgosjnESj8GQgOvGz2iw+Enr7cFODt7hGO/RyUjLHaPOH92iUEVaub0Bj8e5Sho2C+PeQao6hZil442CA3OERavCJcZdps
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(36840700001)(8676002)(47076005)(82310400003)(36756003)(478600001)(426003)(5660300002)(4326008)(356005)(7696005)(8936002)(44832011)(82740400003)(186003)(81166007)(36860700001)(70206006)(83380400001)(2906002)(86362001)(2616005)(6666004)(26005)(70586007)(316002)(336012)(6916009)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 10:47:30.5700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f980f12f-b9e3-4515-f3f4-08d8c8311b1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1262
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

Enable Async DCS

V3:
1. add the flag to skip APU support.
2. remove the hunk for workload selection since
it doesn't impact the function.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                 | 8 ++++++--
 drivers/gpu/drm/amd/include/amd_shared.h                | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 5 +++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2fd3a80bb034..ca3dce6d463e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -131,8 +131,12 @@ uint amdgpu_pg_mask = 0xffffffff;
 uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu = NULL;
 char *amdgpu_virtual_display = NULL;
-/* OverDrive(bit 14) disabled by default*/
-uint amdgpu_pp_feature_mask = 0xffffbfff;
+
+/*
+ * OverDrive(bit 14) disabled by default
+ * GFX DCS(bit 19) disabled by default
+ */
+uint amdgpu_pp_feature_mask = 0xfff7bfff;
 uint amdgpu_force_long_training;
 int amdgpu_job_hang_limit;
 int amdgpu_lbpw = -1;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 9676016a37ce..43ed6291b2b8 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -213,6 +213,7 @@ enum PP_FEATURE_MASK {
 	PP_ACG_MASK = 0x10000,
 	PP_STUTTER_MODE = 0x20000,
 	PP_AVFS_MASK = 0x40000,
+	PP_GFX_DCS_MASK = 0x80000,
 };
 
 enum DC_FEATURE_MASK {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index cf59f2218b7e..fd090d057d26 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -261,6 +261,11 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
 	}
 
+	if ((adev->pm.pp_feature & PP_GFX_DCS_MASK) &&
+	    (adev->asic_type > CHIP_SIENNA_CICHLID) &&
+	    !(adev->flags & AMD_IS_APU))
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DCS_BIT);
+
 	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
 					| FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
