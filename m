Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E191C77B6D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E2410F00D;
	Thu, 30 Mar 2023 19:49:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 572F210F008
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2cwQMR6jeU/HxIzo7zjYmYcNtd/0yANXXOGZruL8c+JD1lwNdswMNA8HmAWyEANdTJGehK/x9tzM8PAu/UnzROGZzVoVjlPkTb6D6kbRDnU4N3QCuplFwCuVrzDfvPlHpShoFIOE7bh9Y2K6MLGmXOfNxjCZqU/pSlNzCwjHKB6DamAyjnS5g7QCKBxSyHrHvXzBodRDDGAWK3vnaNbNjKweJegSBM52plXEq6/iLLMYfTE+NmuO9+vf9DJ6lAvP3K1nUSF0nlRaGb/TBo9CqoOTEiaMqpNT2rm49jhVJM0htnMkn5eFcOE8BiZZjqGmgA68UnG/YLAryv/3/Sm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6ElPBiy1k/4N5qslP0plMm61NNfU8hPOwJE+ygIArY=;
 b=FeWl1KQ0VY+fLidJMJhQgOSVwZ5oszmpX8BfJn5LB06cIqxnIP+VIRthmjpiTlGY/0a5wR0N0fJk5+/cQAxhcrHVt3jCcTKeJKIQ1F+qjtbbdCWF9tjuyorlvuoq6uHRghbdGWFpnnycIRimEJQ6Pxwu2wp5f3frXHRCmKdmsSWF/jqqPY0aw5amyQT9CZgPtfQzGvaB7S0uLTIDS4GWrEEYANg+X2TMzHXgTIBtprcP3b9/mRjMlGbWGq0/9o1vlrvvMi7sfYfSjzvs3AAQwsBkM81boMrLzqpb51ZhrOonPzhJKYhH0hdf93vhnZMJQOOGX20ygHRrgijwKYhfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6ElPBiy1k/4N5qslP0plMm61NNfU8hPOwJE+ygIArY=;
 b=mRHKjHZ5HlvL9KbLMS86IzNPXUgYhThtq2R5/YyId1JP43332Oj7d1A2YGFG8LHm9hmYX//e3C8BoxuHFH7PaLaU9Fd16L1ODaoTF8zA7oh5AqloQlia6PbKgHMFSLnlBmeIIl8/GGhfvHVoGd3RQWEHSkPMBT70V3Fe3O25/4A=
Received: from CY5PR15CA0147.namprd15.prod.outlook.com (2603:10b6:930:67::16)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:48:59 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:67:cafe::9a) by CY5PR15CA0147.outlook.office365.com
 (2603:10b6:930:67::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:48:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:48:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amdgpu: Enable CGCG/LS for GC 9.4.3
Date: Thu, 30 Mar 2023 15:48:41 -0400
Message-ID: <20230330194843.1136162-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194843.1136162-1-alexander.deucher@amd.com>
References: <20230330194843.1136162-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c458465-7c2e-410d-b78a-08db3157ce35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgzCcrLt8cPCSxcG7IsLnivSy91tR1u25dDoWtJyYfdmZK9wCjEt7H+JcvP6K3SbbvBHmxvjl9wgQwbiE47ny+r0de8R448wjEmFMRI30nZq0kE3dW7F1idYZON46mbQQdl/w6TUsry2kCc3DC1AYQ2O7rv/rbwIZxg/gUObhCvfmPQJgqI/njmdyTvJSv4syQgfVqPH8/X/kG9l4992XDX8a/jeDlkH3sAT5tv91BBXknEEd0EkU1ioatDQl+Mrq/HlD7rBSLDKcOF7y/U7Sd6qtDOtRCtiD1okEknvxufQG+vmseuo4sTCxz7kkkFGL8v+MC0Lf94jlMfGVWOgqD2qBNssgUIipeC/qxHM/xB/r4dIl9PRd0vbwDIa7yRC4+/EG/9xmuHsmR44IQTP7W9bSPVaGY42QKHiXKl3k8gCinX5Lg1WYPIjLDLCowDJe2zMSuzNbI7lP4vHJgAXpx8w8q14PuJ6TLEqR5TtvZsmG7fNxn0Beq0TXq3ZdN67bZCc8PBfxTgMjKUJSCgshohMxkh17IqdjTFPrknDfUHt0457fi+GCskZ1lBTlhsAdX7tnkG3mu+ubNBMtip1+v3iOZKubPiJhor6lCWTzu6y7YR71RLwQv+Q3s9xebEVpPTsLu3B5UDaD/GMiHd36Vk2ys9AkXRZlCZ3qkvC3H4VRVBrsjbkyBO0/pMnpPlkxfKAbe5OUz1RbX9FMemn9qrlgaP2vFPyBfUgv7Bk3QQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(316002)(40460700003)(86362001)(40480700001)(82740400003)(6666004)(5660300002)(356005)(81166007)(54906003)(8936002)(47076005)(70206006)(41300700001)(4326008)(36756003)(8676002)(70586007)(6916009)(16526019)(186003)(82310400005)(2616005)(26005)(36860700001)(1076003)(83380400001)(478600001)(2906002)(7696005)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:48:59.3505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c458465-7c2e-410d-b78a-08db3157ce35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Enable coarse grain clockgating/light sleep for GC v9.4.3. Remove
programming that is not meant for GC 9.4.3.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 14 +++++---------
 drivers/gpu/drm/amd/amdgpu/soc15.c      |  3 ++-
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 3cd24651b96c..2a271cd6f477 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2256,11 +2256,9 @@ gfx_v9_4_3_xcc_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 
 		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK |
+			  RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
 			  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGLS_OVERRIDE_MASK);
 
-		/* only for Vega10 & Raven1 */
-		data |= RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK;
-
 		if (def != data)
 			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
 
@@ -2317,6 +2315,7 @@ gfx_v9_4_3_xcc_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
 	uint32_t def, data;
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
+
 		def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
 		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
@@ -2331,12 +2330,9 @@ gfx_v9_4_3_xcc_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
 		/* enable cgcg FSM(0x0000363F) */
 		def = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGCG_CGLS_CTRL);
 
-		if (adev->asic_type == CHIP_ARCTURUS)
-			data = (0x2000 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-				RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
-		else
-			data = (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-				RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+		data = (0x36
+			<< RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+		       RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
 			data |= (0x000F << RLC_CGCG_CGLS_CTRL__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
 				RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 3838c82f105a..d767a8834ef1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1129,7 +1129,8 @@ static int soc15_common_early_init(void *handle)
 	case IP_VERSION(9, 4, 3):
 		adev->asic_funcs = &aqua_vanjaram_asic_funcs;
 		adev->cg_flags =
-			AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS | AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
 			AMD_PG_SUPPORT_VCN |
-- 
2.39.2

