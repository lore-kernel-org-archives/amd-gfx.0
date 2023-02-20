Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3C5C05027
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 01:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499E410E10C;
	Mon, 20 Feb 2023 01:10:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D744810E10C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 01:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNJwDsDfj5MvHInUsYusK6UphyGPjWDsjG0KoAjw+SZ/YFDigut+4KPplUQAqH8TpcwXmByHUe5VtxJSFEMNbQF1i/SdQiirGpBu3b2Ls+enqpbgHbZ7rH76Oie58q/YVtkKqDDa686AIV5k+Zr4uMq+cqWWhv6cr9HpQ+hZW2WGPyGbAhIMzy4ulaGm8n0sH7Jb9LxBDhkL4X59wvw5zhto7RRAkSBlx+a2MSokaYh9DbQAGqDAZnuIp+1mFYbHq2K8v7S+8B4et2ycqAUpE0eOutqCIxeadMwl3DLElV8Dmt4nbfhm5eDlsTDFL3X2insLTkmHRE0hReD8UBB9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Vapg28BfnhM0DkcjLvmqG9Vg/+DcMG+XkpKudse3AA=;
 b=U3fNoi485ynm/cK/kFCrqtr1wDASYanh8UGh0E7Hj/bgiE6kicgdPHH55SP/8Za2DSMbjLc1lXoU2BFR2lNwXZG5Vw8mPGJ1KQu76HicadfPMuAmWcPAByWpEvHhJPfo/R+btHwZv6tDt86Ci0RdvWNZnCS8ea+MOE5P7JwMFa2bp1uWzhsNQeksErmx8zlfjBWLIm5hmEm2dwUibuACVDh8/vLGs53UQRKhswnb/ZqvFcffJMwKdLjnE4wD4VBvdtFrNPmr0m8n7/qITkY0iOPSgPZwlsqz2xMVyeKqT1aIsA1U6AMQZ+NScbNdItpbw1S0y/TECb9gZTE2URC2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Vapg28BfnhM0DkcjLvmqG9Vg/+DcMG+XkpKudse3AA=;
 b=gBMqp8Oyu5nJ4gK2oNMm70sq55fVL3J8Y2xGk5KHUqgteAOnS1JrnleMFRb6ZL97V3EYwqIuw8UN9tNa7TgYiZTc4Fdx1XqHp3Qur8qjI2fMHk/Xt4zKaHiZJB/O+gjJvBodHIriV8TmucHcDzZLpC+wfl2qqZd1SVX6mNO9+qU=
Received: from MW4PR04CA0207.namprd04.prod.outlook.com (2603:10b6:303:86::32)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 01:10:14 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::bf) by MW4PR04CA0207.outlook.office365.com
 (2603:10b6:303:86::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19 via Frontend
 Transport; Mon, 20 Feb 2023 01:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.19 via Frontend Transport; Mon, 20 Feb 2023 01:10:13 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 19 Feb 2023 19:10:07 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Feifei Xu <Feifei.Xu@amd.com>, Likun Gao
 <Likun.Gao@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix incorrect active rb bitmap for gfx11
Date: Mon, 20 Feb 2023 09:08:40 +0800
Message-ID: <20230220010840.17333-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 775dd650-99c2-4813-51c5-08db12df3856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5EJ6dCDKFlRLRMzCvv9kMxnS6cMutdv/OPSmy5Vvplz3ggHsZRRmIH/PrgpxJUHZ7WueAjjJgv5taw6JwrJ4Qv2XFZN8i89fskn0iGZaOPRieeny/Fv7INavBaH3nkMdcmNovYqpTCDbffHiQ5wajjrlN+91ATAk0mstWHLv+3J1xBPg4v1fKD39iLyANWeOYF66txYEop3L1xoym5Htopz2Xd7IBup/ybaXMTo3OkyLajPf+jDogg/8G7ILYEa7Ue987q2TrwSn0iDaF8C0qjX5cMKXhBIuOjKcwJy2cLfNUouPCg/G0HBmPLlHLvbRS4XrkBqPd2j6NORx5nrQplpfvD73I9lvnu7FvFGUKczPFCj8HJgNtwli76AtqYI4IbcYRH0uo0XRqOxNCg8Lqcpc5HNIuimqJDO2JedCc74CuIwrDkK3d5HdpgaOlNe/Y6XOXlW2bFybmQ7Znnvupdrap+XoD1WIVJStMyOkXYiyIx2hGJGtcgqyy7TVAEjA2eDutN347A61IOGzvdFP03ko4BhAKz3c28iqHu6rUAYMin/H/FHumqGtc/vVoZS/kiZyEVZSxD5MlE16a6vrKSLYW0htlmd3Z6jd9/y5xJJT7o/niKy+8znCPVIBjfQKJ13x5b3h0fDYSmx50qVRKT1HImJN7vA3PjRkzumwk5aBPi8Sq5ETEj0T7Wu3k+txGEy/+7PcXpDtoHU5agNQvVDr0Vfqe0Zzk+jydiT2EU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(426003)(478600001)(47076005)(316002)(6636002)(36756003)(110136005)(2906002)(82310400005)(86362001)(82740400003)(81166007)(356005)(36860700001)(70586007)(70206006)(40460700003)(40480700001)(4326008)(8676002)(8936002)(5660300002)(41300700001)(6666004)(7696005)(2616005)(26005)(186003)(16526019)(1076003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 01:10:13.3526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 775dd650-99c2-4813-51c5-08db12df3856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
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
rb bitmap needs to be changed accordingly. Query per
SE setting returns wrong active RB bitmap especially
in the case when some of SA are disabled. With the new
approach, driver will generate the active rb bitmap
based on active SA bitmap and global active RB bitmap.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 78 +++++++++++++++++---------
 1 file changed, 52 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e7e5a2c31896..7b7f01b304cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1503,44 +1503,70 @@ static void gfx_v11_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
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
+	u32 rb_bitmap_width_per_sa;
+	u32 max_sa;
+	u32 active_sa_bitmap;
+	u32 global_active_rb_bitmap;
+	u32 active_rb_bitmap = 0;
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
+	rb_bitmap_width_per_sa = adev->gfx.config.max_backends_per_se /
+				 adev->gfx.config.max_sh_per_se;
+	for (i = 0; i < max_sa; i++) {
+		if (active_sa_bitmap & (1 << i))
+			active_rb_bitmap |= (0x3 << (i * rb_bitmap_width_per_sa));
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

