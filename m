Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB5EC2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E62E611CE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E62E611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB0606E8C4;
	Thu, 17 Jun 2021 08:40:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C16736E8C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 08:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFoKUPp2KgG1bYODiFc6EJnlgjPVYGl1F0HrDSxgxr4qFvBltAen5i87unxnke9PMq123ZUdBdPoc8hmfsLNhe+nvHaS8875iylR2Dv3xdxYX1CqA5nQ4qLUrzVuzWweQgw9loPOsVryPgKwQb6Zgsb8/JYQPVsXSkCmIDfsibbo4vA4Eqbm20SMtDqhGUJ7G/mQuJ8weGlwBHYfnmdd4FeeQ4CGE+3Gm8R+vKEC/ekiJaQaF2yijqZj8I8bmhfeCRmW/453dkENNtbl8MvEvL7WaLHzvO2efGrxMWNUP8BvGwE2TVYfId8Z7ELuIdX2Sm5SSEeHyqs+JN7dEMirzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yFGKIxzzg6QGRthVUS+d5CpvB/0npCpM3kZ1G86sno=;
 b=gR9U/ZbMYJs8slv1nmISvB1EGXoO1ZmcXUQORBqLPMTp07n9vPorF6GKVzUeGMwmOSV2GcS43kUZdq7ZwXq75lxQYbmer0OzyD3c19IYLmO1oCaHaIbVVqiPu6qy3TgPljfXtwp37rxYvD54Jw1/4rG73bwfJLJFqAueuxMTqWWqNqV1miRStpXdLVZxIejPC2sdy95lbgFG3rmwCkShgQIzsayPYHRMcgCzXrjCy18Woht8BWbti57Et3ZMQiL1tBTHSvcfl9a4Xf+q+DFfo3OzFdzytnLUXkKlAnQnAMY12LPJjSt1jgJvqdD/roaond0NDKc+FnTGJx9cQj2Mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yFGKIxzzg6QGRthVUS+d5CpvB/0npCpM3kZ1G86sno=;
 b=Dn2BGis3l2TRqliTkLxbGsc4Xi/B2XUvDRk0S3/yMXRLzp9eLoFH9BXiDwoaNsWFg+phNgPyUOxXQnft0v69DrqprpxY0MmXpF9oJtnEOb4FUT77ffnEgZ6btd+5AXaY5iEUkv215yJIoG0sIzGwMUbUBUJ4PP6QPWiQra6FnYA=
Received: from BN9PR03CA0213.namprd03.prod.outlook.com (2603:10b6:408:f8::8)
 by MN2PR12MB3518.namprd12.prod.outlook.com (2603:10b6:208:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 08:39:59 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::28) by BN9PR03CA0213.outlook.office365.com
 (2603:10b6:408:f8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Thu, 17 Jun 2021 08:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 08:39:59 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 03:39:57 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 6/7] drm/amdgpu: update GFX MGCG settings
Date: Thu, 17 Jun 2021 16:39:22 +0800
Message-ID: <20210617083923.421052-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210617083923.421052-1-evan.quan@amd.com>
References: <20210617083923.421052-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0257c7b7-d7c8-414e-b0ee-08d9316b7dc4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3518:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3518B4728CACBC185B414AE8E40E9@MN2PR12MB3518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v525rhyjQI+BoXDgCUOq7c9KL1o8Lx7nhD49753pcdKKCfWMxd8q9sCah9t7kFPgoTGJCKt7tT6GAIEcKPrusw74dxKGz7W2B/t1iw+cZiMBsL5jV43guISBP5C0su184MPgO/BZ6boAVtBnteWu7LW1c1TxtduXR4bCqEqS6Xo0dqVPBQ7Zo7c8w0lBSJ1QeJc1tL5C1zNxUcrMswkY5JbjVs2/taLyeftdvn1qOLFgaZ4Lgq4Qds9OgxrRZs8ZHY2H24EwAZE3OE6piW7EvsE5eZuVzlHFQs85hhOUsxkWbQ+BilAFY9Y/dm1yMUZw5wwtmeuXd6PETc2q8Ho8zMRl2dEjBAITeb40bwLDYonf+inQk+4eI/cjCming1EsLFXLxLR2tvrV6aL8jsy7JNrgojInJ2jBUU6rnu3JDGleMefDNIvvFab3f+MDO/nHcnnsh859gtxx9HGVgoW0nxWSSOicFvYbWDKAMqGmSjk+fb022ioeuAqCOBw78kzx9AySQMikPZ/eaariQ7EfCGMzUDmebV/+6aJbpKmczythSq7e7uC+SxXP/kkPy9qsm80E4x9I7wN3M3HbR5A7hQ4xnusskhb5g+Rn45d26fmtDxvMI8Ghx009CYBSLEpZ0BLeul2vWHXrPz+T5Ra//ZrLW3c7EjUUbqcnRhYC5OSbCxHiz1780buh8PbtSCTq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(36840700001)(47076005)(36860700001)(336012)(426003)(316002)(6916009)(81166007)(54906003)(356005)(8676002)(8936002)(36756003)(478600001)(7696005)(15650500001)(70206006)(1076003)(186003)(5660300002)(4326008)(16526019)(44832011)(2906002)(82740400003)(2616005)(82310400003)(6666004)(86362001)(26005)(83380400001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 08:39:59.0500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0257c7b7-d7c8-414e-b0ee-08d9316b7dc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3518
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update GFX MGCG related settings.

Change-Id: I0b7b8e7c97859f99db5f52026abbb4d226c179df
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7d9464611d26..73685492d36a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7786,11 +7786,11 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 {
 	uint32_t data, def;
 
-	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG))
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_MGLS)))
 		return;
 
 	/* It is disabled by HW by default */
-	if (enable) {
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		/* 0 - Disable some blocks' MGCG */
 		WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, 0xe0000000);
 		WREG32_SOC15(GC, 0, mmCGTT_WD_CLK_CTRL, 0xff000000);
@@ -7803,6 +7803,7 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 			  RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK |
+			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__ENABLE_CGTS_LEGACY_MASK);
 
 		if (def != data)
@@ -7825,13 +7826,15 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 					WREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL, data);
 			}
 		}
-	} else {
+	} else if (!enable || !(adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		/* 1 - MGCG_OVERRIDE */
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		data |= (RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
 			 RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
 			 RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK |
-			 RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK);
+			 RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK |
+			 RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK |
+			 RLC_CGTT_MGCG_OVERRIDE__ENABLE_CGTS_LEGACY_MASK);
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
