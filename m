Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB172C05027
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Feb 2023 06:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1213D10E080;
	Sun, 19 Feb 2023 06:33:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5A310E080
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Feb 2023 06:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDlKv3elQA1M0xIkcs/WFaj0d0leeqqv4EFHvsZAN+fLu3mJIIxdCwnUHb985Ip3iRc5kuegmvYUTKPlvqdxE9SrgonueggYcgRLc3BPTTvx9WKAIL1NDQwz36Jj5VRzoPkM6RRfhS9Lo/UbvI2kaW9uIADg26x3Yx/e9PCO74wkePxhLUxLYnNW1pQgE127axCGjKOPEDICQf0buQcLTSslvKWWi/ErC5iAoaGsyq0KPfltXUg6bAn4bQcLAgw/YkyCQFEiy/YBzBKmEQD5mtpk1dfx+4ViYfJ7oeYfHqchjU7mHCA8M4WoowkxzAa68nqAyZmACCQOOCgT9uy8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94WrvI3xwextWgipDuhfdAXG6NQ18mGX2wkly5ULFPA=;
 b=AFFQLc4t0pr5aZKMvX/X9YAF35d3ma43+F8OAWS3aBnyc6sjwBcZxhCis5Y+cVZwvWtvrW1CxxxqrVWcObqC9EJ+uL/uXlpOLVaepUPZtjIsFvd3+N9M50KKcVKJfPiT8vhq2pfDfyUrioEjtIm5zu8vwRiFAqqyeRZoW+1wYxxsw8q4RPwY5R5PhV/sAqO4DjRREkJ/Kwix6Yfd4RG9QLXodHu3r+NZIrPMF+TEeDfjrOJxeXn+hhrDlFIEmiJm9cvzhPb1AyFmD4zgrXpHWQl4PyWLaH4zTpNXbU4CofgliWQSIqupvwLpx/K/TXAZhtsV5e6TZcivPTjxxmYL7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94WrvI3xwextWgipDuhfdAXG6NQ18mGX2wkly5ULFPA=;
 b=0yJ2KsYHcLjUkdKe2nP+/1M0O6mkoblhCHF/Ig7Eh0n5/TvI9gcnMX38CI2eOLNTfsmtidIKbgsAqlVTNvKDhK4d4nSENOxvtnSddp3gGVUINddZmBsohYyZztcUAp2b+iyg81obNHeALJQjnLcYBVrlXHyEfG2VWSrR6wiGUuo=
Received: from BN9PR03CA0336.namprd03.prod.outlook.com (2603:10b6:408:f6::11)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sun, 19 Feb
 2023 06:33:48 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::b4) by BN9PR03CA0336.outlook.office365.com
 (2603:10b6:408:f6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18 via Frontend
 Transport; Sun, 19 Feb 2023 06:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.18 via Frontend Transport; Sun, 19 Feb 2023 06:33:48 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 19 Feb 2023 00:33:46 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Feifei Xu <Feifei.Xu@amd.com>, Likun Gao
 <Likun.Gao@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix incorrect active rb bitmap for gfx11
Date: Sun, 19 Feb 2023 14:33:28 +0800
Message-ID: <20230219063328.13184-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd08d6c-0f60-42d8-f25b-08db12434210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4QqDu0kJ0iDq+pLGzZ1v6bfRFuRB03YTzY+bnPVtJ24Iw+p140ncdNinf3QOi2K3iUhSUCjUQmGMYi2TfdfkNOWBrUU1lqnmrHz04gCg4G+j7OjV/t38zwIkMGFzdpQLh2/vOTKA/JpYU/gSooqkeFOZtqNulg/dow/mLfAWT2lZZZJHF/az0LyViA1cjkdK995mIlnFI0UJZ7MpNYNThnLcmgBXTrcrQfW/t8aN3Gl83oIcfxOhVI07UrsqE6jU8MAe20rskLggLyMcpJZhUig3LRhE2J/BwviIdX5ZeL7vlQ3Xd0qPLr2ujVt+KS++IfbsxA2SC5J8Pr5yX90YXquMxLxcJCQMHaJnvF6v0wqJc89S39WbPoUZQI8pq0h0XnLVMInaeCqawenNmRL7v7VO+DECm0OGIGif0YXiAdRg8yxv9kNRDhyAgmuHwel5pXrNschNnUq6Sd6a6/695+tsOBWjxs5pY0I1d+1Ey9dvvT+q8PXxSE5k+7oDm/ki+0ws8hnMujdSaaPlns2b12b5GRT9z/8txMJ7jK4fd0tC0LlBJMmXlm2Z8oAHbOGYNjBDWog12tcMhgsOctkxcdcALsuKeANVvNPgJfDzewGqSYRxRZP6h6cgBsES8RV3wj8fG5iGtXvTAdzjnlhjyZ1n6HS6/Ct/Mu7Mwhc0AT07ZkwlXy2X4o0FJIxtIKVs1FPsGSWpKyMRl+4lweHL8ruoib4N7q+voNw8k3fvqQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(36840700001)(46966006)(40470700004)(2616005)(356005)(81166007)(82740400003)(40480700001)(1076003)(40460700003)(41300700001)(6666004)(186003)(26005)(16526019)(6636002)(426003)(47076005)(86362001)(82310400005)(110136005)(478600001)(5660300002)(316002)(36860700001)(36756003)(336012)(8936002)(83380400001)(4326008)(8676002)(70586007)(70206006)(7696005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2023 06:33:48.3104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd08d6c-0f60-42d8-f25b-08db12434210
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX v11 changes RB_BACKEND_DISABLE related registers
from per SA to global ones. The approach to query active
rb bitmap needs to be changed accordingly. Query
per SE setting returns wrong active RB bitmap especially
in the case when some of SA are disabled. With the new
approach, driver will generate the active rb bitmap
based on active SA bitmap and global active RB bitmap.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 75 +++++++++++++++++---------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e7e5a2c31896..87a6cdac3d45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1503,44 +1503,67 @@ static void gfx_v11_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 	WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX, data);
 }
 
-static u32 gfx_v11_0_get_rb_active_bitmap(struct amdgpu_device *adev)
+static u32 gfx_v11_0_get_sa_active_bitmap(struct amdgpu_device *adev)
 {
-	u32 data, mask;
+	u32 gc_disabled_sa_mask, gc_user_disabled_sa_mask, sa_mask;
+
+	gc_disabled_sa_mask = RREG32_SOC15(GC, 0, regCC_GC_SA_UNIT_DISABLE);
+	gc_disabled_sa_mask = REG_GET_FIELD(gc_disabled_sa_mask,
+					   CC_GC_SA_UNIT_DISABLE,
+					   SA_DISABLE);
+	gc_user_disabled_sa_mask = RREG32_SOC15(GC, 0, regGC_USER_SA_UNIT_DISABLE);
+	gc_user_disabled_sa_mask = REG_GET_FIELD(gc_user_disabled_sa_mask,
+						 GC_USER_SA_UNIT_DISABLE,
+						 SA_DISABLE);
+	sa_mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_sh_per_se *
+					    adev->gfx.config.max_shader_engines);
 
-	data = RREG32_SOC15(GC, 0, regCC_RB_BACKEND_DISABLE);
-	data |= RREG32_SOC15(GC, 0, regGC_USER_RB_BACKEND_DISABLE);
+	return sa_mask & (~(gc_disabled_sa_mask | gc_user_disabled_sa_mask));
+}
 
-	data &= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
-	data >>= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
+static u32 gfx_v11_0_get_rb_active_bitmap(struct amdgpu_device *adev)
+{
+	u32 gc_disabled_rb_mask, gc_user_disabled_rb_mask;
+	u32 rb_mask;
 
-	mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se /
-					 adev->gfx.config.max_sh_per_se);
+	gc_disabled_rb_mask = RREG32_SOC15(GC, 0, regCC_RB_BACKEND_DISABLE);
+	gc_disabled_rb_mask = REG_GET_FIELD(gc_disabled_rb_mask,
+					    CC_RB_BACKEND_DISABLE,
+					    BACKEND_DISABLE);
+	gc_user_disabled_rb_mask = RREG32_SOC15(GC, 0, regGC_USER_RB_BACKEND_DISABLE);
+	gc_user_disabled_rb_mask = REG_GET_FIELD(gc_user_disabled_rb_mask,
+						 GC_USER_RB_BACKEND_DISABLE,
+						 BACKEND_DISABLE);
+	rb_mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se *
+					    adev->gfx.config.max_shader_engines);
 
-	return (~data) & mask;
+	return rb_mask & (~(gc_disabled_rb_mask | gc_user_disabled_rb_mask));
 }
 
 static void gfx_v11_0_setup_rb(struct amdgpu_device *adev)
 {
-	int i, j;
-	u32 data;
-	u32 active_rbs = 0;
-	u32 rb_bitmap_width_per_sh = adev->gfx.config.max_backends_per_se /
-					adev->gfx.config.max_sh_per_se;
+	u32 active_rb_bitmap = 0;
+	u32 max_sa;
+	u32 active_sa_bitmap;
+	u32 global_active_rb_bitmap;
+	u32 i;
 
-	mutex_lock(&adev->grbm_idx_mutex);
-	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
-		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v11_0_select_se_sh(adev, i, j, 0xffffffff);
-			data = gfx_v11_0_get_rb_active_bitmap(adev);
-			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
-					       rb_bitmap_width_per_sh);
-		}
+	/* query sa bitmap from SA_UNIT_DISABLE registers */
+	active_sa_bitmap = gfx_v11_0_get_sa_active_bitmap(adev);
+	/* query rb bitmap from RB_BACKEND_DISABLE registers */
+	global_active_rb_bitmap = gfx_v11_0_get_rb_active_bitmap(adev);
+
+	/* generate active rb bitmap according to active sa bitmap */
+	max_sa = adev->gfx.config.max_shader_engines *
+		 adev->gfx.config.max_sh_per_se;
+	for (i = 0; i < max_sa; i++) {
+		if (active_sa_bitmap & (1 << i))
+			active_rb_bitmap |= 0x3 << (i * 2);
 	}
-	gfx_v11_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
-	mutex_unlock(&adev->grbm_idx_mutex);
 
-	adev->gfx.config.backend_enable_mask = active_rbs;
-	adev->gfx.config.num_rbs = hweight32(active_rbs);
+	active_rb_bitmap |= global_active_rb_bitmap;
+	adev->gfx.config.backend_enable_mask = active_rb_bitmap;
+	adev->gfx.config.num_rbs = hweight32(active_rb_bitmap);
 }
 
 #define DEFAULT_SH_MEM_BASES	(0x6000)
-- 
2.17.1

