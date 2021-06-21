Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F187C49EA2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E2A600D3
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E2A600D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DCF89CBC;
	Mon, 21 Jun 2021 07:01:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D8889CB8
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 07:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvPdERQdGEzZO23pUHVgO758Je8otsa54uaJFyJCUGV1qkNwHjEDi//xVvj7T+MQEPH/vF2U8T/dga9Nr+qM/nx0W/M7pXY8EZQ/8Jslu/MzrebfpzLe3KVMTiCSzua71ekEUTRqELyy/1VgBcjzghP579pLubtQKuc10dQgENiodYef+uheNWuyWRb8rtotF8PUgRG241lzW7H6dh4usf3OOv0x5jGqLkDKCiVZblTYF3r7ckRqXmhFG2NEH1EIs7CAtqQNy0Rxt71Vn2NU85nq9NvZjO6gyHPiaNfjOc+WXVMJdBbUhabF8m4Nx0dIvQYzH5Ubr3RR2Tg1v494pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQalRZFrzXMXfRY0pMB8yQACCnPDfqGKPpjDi43+AWo=;
 b=ZpXJ463DXHDoF0Zf38Qsn77y5eEDQ5dbhlfUeEHIYLL9fd5Lgj1thabHovPhs5ahO+6Lb4iElkFbKg4G4KeIfmct9KSW+r9wKYXbmJ+9HWAMnb9b//ReeohGUox/KcOs3WEXXq7L95qCuYTyjgw+948g6U2DkhVOmrHYQHbZg+ZVZQQcYnVkAdOh73OdGRlLgrmIxy+XQHQskd3nHk+ZkKt6qLvLdBiqjVO57BM8HnKLMBrH1P1mTqbTZ1C003hBl8V8wgfvbZSOEomCNPYjdXVm+16UOS8uVLbUtgfaGRymu/UoOQanfFNZlP93zbR9pCNmRrrmf9xp7eAVSEsdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQalRZFrzXMXfRY0pMB8yQACCnPDfqGKPpjDi43+AWo=;
 b=oJ8bSE3UE2+KYYYPjyDuI9yODR3RTcpDJrJSqbtzWzXF8DLidUR4RM6yGjOVNnPdFW8bwGl9AZSlyUBYLoNnzAFYhMecO5KOf1xuHSXx67HeY2mJyjoN/wlEpQrRFf4zfpvIYdwIHxEpzsCceQoFutJfFAXMRbT0vB1igfzT1wA=
Received: from DS7PR03CA0254.namprd03.prod.outlook.com (2603:10b6:5:3b3::19)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Mon, 21 Jun
 2021 07:01:17 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::b7) by DS7PR03CA0254.outlook.office365.com
 (2603:10b6:5:3b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Mon, 21 Jun 2021 07:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 07:01:17 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 21 Jun
 2021 02:01:14 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 6/7] drm/amdgpu: update GFX MGCG settings
Date: Mon, 21 Jun 2021 15:00:39 +0800
Message-ID: <20210621070040.494336-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210621070040.494336-1-evan.quan@amd.com>
References: <20210621070040.494336-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e904612-a76e-47d7-9a31-08d934825df6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4997:
X-Microsoft-Antispam-PRVS: <BY5PR12MB49975E6C755A15808BBEF505E40A9@BY5PR12MB4997.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TbgjHPDn3VHhqIwo6s2IdOmSCWBVv9hfBgU0MLBzj9kAweMOz49JcvO71hA5Zgf1YkjpDU0pjPuAoNWMZ9ZF4FHEVADZ4Jh82lTU9YWGHPmXtXYLqaLn03ney1zSfDyPQNCc4opSOW1SiUAYZEEQg4jXK8J5S3acX5oy5PIIez4p9a3hs7FrXCr55XdMO69SM/pQNoINsmQgvfAjt69eYZihcWEZUwr3lcM/5DxqRwW/lm5baeo8UxN2IkQrqyLQeoZHwl1BbtVgYFVXWkEQ1aGNSKU1MHKbpi8fB2FtkjMrAwmJB83iaHX83LgKJsHW8c7pDU/UeXV+uZ5QxXovbGdk4lCn2llf42Rq29SzJ4w6nP+e+bosVTXAqLIJi6NKKDi+66xyV9xM8rk1RV6/ewT8myY2xkOpc9Xrhr4OLUqgXj6RxKS0qP1EmN4D6chsK4IHcniq2bhuKw96ApOazKfcyJV+hHtlskJesjOw0af/J3Ds297L/LuAzUbJNbwQBCXmz3xcDmXY4hsh5CgmGguCACLgfquPAYTrimSvz2rkrN/t6iSRqiRKJOGWq0a8sWmS8cxj/WfhGl4fXHKCmV1EWLvA0cJaAgRHFu8ORHbFwPcyz2MHt9Zpj+VosogKAuBF/WSSrkTUhArjpJ3kvhd5+oO9TlKGgMk/lsTR/mFWtQVju6S2gMLvV6QZrZ5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36840700001)(46966006)(15650500001)(44832011)(54906003)(8936002)(2616005)(81166007)(86362001)(316002)(26005)(6666004)(426003)(336012)(186003)(16526019)(36756003)(7696005)(8676002)(2906002)(1076003)(356005)(4326008)(47076005)(478600001)(70586007)(82740400003)(83380400001)(70206006)(82310400003)(6916009)(36860700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 07:01:17.5371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e904612-a76e-47d7-9a31-08d934825df6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
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
index 5d0062f820c1..b855a7c5bc4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7787,11 +7787,11 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
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
@@ -7804,6 +7804,7 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 			  RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK |
+			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__ENABLE_CGTS_LEGACY_MASK);
 
 		if (def != data)
@@ -7826,13 +7827,15 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
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
