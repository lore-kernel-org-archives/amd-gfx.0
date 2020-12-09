Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E0DC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 15:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77DA23AC4
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 15:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77DA23AC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979A06EA93;
	Wed,  9 Dec 2020 15:29:24 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700042.outbound.protection.outlook.com [40.107.70.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99DC6EA93
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 15:29:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYkgXO3V2TFpGZ09tYYbLIVgVzatPVajuSS0xS/R3w/m8luHm5i1OgAdEjDGKXPR7+FJiUk/ZkVI02MHnUt0NuhoMRRo//nVxwZUwAtlkl2VZjrQySFgab9iilbMzibMTQgqD6JqRM09n4ctJVI6zi2wz277JoGW6hYh6csTU7EBeb9FNWB1EnwmrQqy1hfUayWYteFgOwN490WqB1SFzT+xZ/s7a/f8PS+Ewq+QHUobOaqirK8znco9kx3i6a82wjSQqwSjnbDeuE04/GKK1SNWnO72rnt4sMUO7v+g4cc1jHC49SYcIQsFZvJKhgp4nc9JCc6XGT0beV8xm5vp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuvyJE+kuI0BsiPRJlETNERrZ7GMkdCmEWEhTihtc9I=;
 b=nCFTUxXEnBHhbbAIuUr+lAgOduGMQaLHvkBlygCfU1CWCTiXobg64Lt1uBzECHNgGjE3IFK+7oWbo2fi5lQFhXQ/RDmJOY+gzxHZOGojuLVx7kaUwInlKSQgSpRjcjhsWAWTU8NS4rF3PtW3T27IEhyT1gX66rDYdbSAziRymncKbjdFOlsYG9Wo564QESpoO9mp/iGxzbTqLT3gzDQ4NFGB7ZPw5EFuy4iNJAF/OEflET1psESLufvR+VhwhKOk/0uYcDI+Mf4vekVZG6EtLvZPWJ/3f5NIOE+6/ti/rPyKe2V4xzU8sPc4N87ftpSpyg40EVqD04DauHPd5h1exQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuvyJE+kuI0BsiPRJlETNERrZ7GMkdCmEWEhTihtc9I=;
 b=ulAPobVx/8XQxmbdj8Sj6GSqBtuI1uGivz4Ib9Ljq0f/SKwIBW/4WnfvRLsRrD8zssgEdd0ArJIugR8w8gSW1QF4Nt6cuHfMuaCmynfaun7smkgOK7LqLFOOtNpzL41hCHykOapzSBhXs/sbkMaRvkDuuNs8TgHvVD2mC8PuejY=
Received: from MW4PR04CA0028.namprd04.prod.outlook.com (2603:10b6:303:69::33)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Wed, 9 Dec
 2020 15:29:20 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:69:cafe::6c) by MW4PR04CA0028.outlook.office365.com
 (2603:10b6:303:69::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Wed, 9 Dec 2020 15:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Wed, 9 Dec 2020 15:29:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 09:29:19 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 09:29:19 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 9 Dec 2020 09:29:18 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: check gfx pipe availability before toggling
 its interrupts
Date: Wed, 9 Dec 2020 23:28:12 +0800
Message-ID: <20201209152812.3215-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209152812.3215-1-Hawking.Zhang@amd.com>
References: <20201209152812.3215-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 871aab1d-b5ce-443a-9bb2-08d89c573300
X-MS-TrafficTypeDiagnostic: MW3PR12MB4460:
X-Microsoft-Antispam-PRVS: <MW3PR12MB446001A0EEAC20AEEAC9CAAEFCCC0@MW3PR12MB4460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8Optw7TyKekFKZfL+qfnbUt2mH203PH1sKvvLpxh0bmUCC2D753Y3+o+zq7qoI9MVfL5lQCTkfZzCyDa4H2x/v8GeEhIYT4mEiGfBtZGufR8fJq6S0GhylP3bfjnd2n0S01Zhc5yxNPxf9sVb40xB4qYlYP7KNRdbzRMODqkMWA+uk/8Y53COhj429o/1I+ydn4+3HjqOLRGGosJAkRimULMSihsFIEITrab5mI2y8lK4SqzLLWvZEX56nRLrsAPvTbiVSxQMsgvyYzrh2LKaR6+OZ80EyGDs+XvoSzHv2p5RP636qec8+iCZHryqsoBvJStxO0bmOyIWbC2Cuw7xsAFDAIgT+1RwCY1oZCHUctPY/a8KUUJKFIjbz5j7U7M+roUvsAHAutu604iS+0YQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(46966005)(110136005)(81166007)(7696005)(508600001)(82310400003)(70206006)(8936002)(4326008)(356005)(83380400001)(426003)(8676002)(2906002)(336012)(6636002)(1076003)(47076004)(5660300002)(26005)(2616005)(6666004)(86362001)(36756003)(186003)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 15:29:20.3091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 871aab1d-b5ce-443a-9bb2-08d89c573300
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GUI_IDLE interrupts controlled by CP_INT_CNTL_RING0
are only applicable to me0 pipe0.

For ASICs that have gfx pipe removed, don't toggle
those bits.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ef430f285472..5f4805e4d04a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2633,7 +2633,14 @@ static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 static void gfx_v9_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 					       bool enable)
 {
-	u32 tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
+	u32 tmp;
+
+	/* don't toggle interrupts that are only applicable
+	 * to me0 pipe0 on AISCs that have me0 removed */
+	if (!adev->gfx.num_gfx_rings)
+		return;
+
+	tmp= RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
 
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE, enable ? 1 : 0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
