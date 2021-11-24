Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2E0C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 16:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E966EA9B;
	Wed, 24 Nov 2021 16:36:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819176EA9B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 16:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPjYiHP6oG4Kn2EN9HfiTuOGxahagRqSnflQoa901IaChBxcGQLmAX/3pvvi+Ig7R4Fz73k6xFVJvN9aQYn/ftbokMV9YJ1sJhSPpxvTdWpFcWw3q2c/0qqA6rTPT9ox4mw6iv1yFMSyPrz1q6Q/3cKArUObDOlyFXbCkSXpeZVQIMQGQppuJoz28PJM4bTNnXmWMHA8ikmhyIBpsXecNcvaLVFlc1GPYdQCzqt/wCSo2eegcf1jxkH/ZptPzKTKl0ZLHLjXWdF58D8kR63rKFc1vLEKUG22c3jtsMovRkE1UM695KLdcHKWMnXirI41rW/HYJHwD2s2cnXfmeGxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu0uYwdhLEt8D4GLsz3qPtCLKh3pGW0cVwvFEnFEtzk=;
 b=X61lDZk33QUeEUdIhpiKGZ5zPaBgNy5Yn5nlRcwuLE6DAqaoDBRCfE4LghrybX1lpNMu++nHU8WVMHQNAOEImSBFPzFB9AsMPEsMjTP73Qn0c6gzwcy0JUeK3UWZqPlNcfH793ssoaxoZaqcDP3huFUct47ejU+IxDWXL9qE3fWlVkOvotqXp37afa7OBOYhXCxCf8aXowhI+mCvcGrOTeghdN/wBaLP9Q4jIywM+fI42DMFVggIp4j5eE3zW5wwu87i7rP22s2B65Ndl09qW7MqpXII3EPlxdZmyMxyWdvG23lJhXgLwTTku04mN08rs/PNVk5iL8ekLNFM/fHBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu0uYwdhLEt8D4GLsz3qPtCLKh3pGW0cVwvFEnFEtzk=;
 b=s/AqB11OHDBzZ+J0Gq4YJ2D+x3+fWPYu6dMTG8tDn/iK5X18PDmo4QdVp59/s5Sj0zPCfvDqQ6ixDN8M3sduZuaPD1Y9kfDVcI5PvOMFvpT4lQ2ab27VXWUMGojRzpnNtXSQBbyODSEyHJ0tF6nu28hOT/WHFsf30al8YwSCcKQ=
Received: from MWHPR11CA0043.namprd11.prod.outlook.com (2603:10b6:300:115::29)
 by CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 24 Nov
 2021 16:36:28 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::59) by MWHPR11CA0043.outlook.office365.com
 (2603:10b6:300:115::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Wed, 24 Nov 2021 16:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 24 Nov 2021 16:36:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 10:36:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: update bios scratch when setting backlight
Date: Wed, 24 Nov 2021 11:36:11 -0500
Message-ID: <20211124163612.2728640-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6c42913-1e87-4292-064d-08d9af688ee6
X-MS-TrafficTypeDiagnostic: CO6PR12MB5394:
X-Microsoft-Antispam-PRVS: <CO6PR12MB539456C6209E681382D761D8F7619@CO6PR12MB5394.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMGGxJGjMHDZ488/izk8Zn8UZ6PgbTrS+d60I0y+PtH6g+BCNgVnkbiqoIr5OvYjFu3AB+PczdGQsZnLDX+TyyMjRkr+jMa3VjOtsY2VttP75ueQ4Z6MVBeOwEl0qt5OyfUTVz80WiW57qSHUrZFT52eD3RxhamOKSYzkDsGfn/jvLlsnSA2ELw6ZuSL99SODWGEeurfF0snGftHPwXdyG9Qu3Y1Uy1uYQEPKDPdtzngspynfgH8mnIjcACjI34ObHOzlTBhlZk1v8Y5x19qUiRec2qO6a674fLbsk75CfCQg/NurDaT0h2PU8czJAi0XDPuAMVBXsdL0A8i7fjKYO4wdLGvsEhZ9C6oNWsfaVEVsrA68UprFO+ubo4id6URtrK64isnzs2PbxSXa+VH+j18nT5F+3eY4Onft9R+g0IDFrNhOdfjk45EnfxgJr7W/oMzjg9X+FTBw0x2MjMu0bG8KJt1d3Dc8HK3IPKMwxH/bZKL96Ml1APQOUOja/aJ835h0oskZXjDNkL9vkguUdGWCfVuF/qn+5D/pCvlMnr8qHtEMAeX7gVAkJIf7aKN+woZOAtMOD7WgWXukmt6uNtbb+qF+BfPKNbrczrRY/1y0QKSkrUt++mZzlC5qiTkfnlL27IQmmvJyCoDzEMdXPZsgqJpipMh5GhKOdKcEPdlkIifaCiykaEXhWLMAHZmQltULLpAB/WqjxVOAi9e60usJQjy4nH3OTe+5y4s8dM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(966005)(4326008)(2906002)(186003)(336012)(2616005)(316002)(86362001)(70206006)(1076003)(8676002)(81166007)(70586007)(6666004)(15650500001)(26005)(83380400001)(356005)(508600001)(6916009)(36756003)(47076005)(7696005)(426003)(36860700001)(5660300002)(82310400004)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 16:36:25.6955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c42913-1e87-4292-064d-08d9af688ee6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the bios scratch register when updating the backlight
level.  Some platforms apparently read this scratch register
and do additional operations in their hotkey handlers.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1518
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c      | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h      |  2 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 96b7bb13a2dd..12a6b1c99c93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1569,6 +1569,18 @@ void amdgpu_atombios_scratch_regs_engine_hung(struct amdgpu_device *adev,
 	WREG32(adev->bios_scratch_reg_offset + 3, tmp);
 }
 
+void amdgpu_atombios_scratch_regs_set_backlight_level(struct amdgpu_device *adev,
+						      u32 backlight_level)
+{
+	u32 tmp = RREG32(adev->bios_scratch_reg_offset + 2);
+
+	tmp &= ~ATOM_S2_CURRENT_BL_LEVEL_MASK;
+	tmp |= (backlight_level << ATOM_S2_CURRENT_BL_LEVEL_SHIFT) &
+		ATOM_S2_CURRENT_BL_LEVEL_MASK;
+
+	WREG32(adev->bios_scratch_reg_offset + 2, tmp);
+}
+
 bool amdgpu_atombios_scratch_need_asic_init(struct amdgpu_device *adev)
 {
 	u32 tmp = RREG32(adev->bios_scratch_reg_offset + 7);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
index 8cc0222dba19..27e74b1fc260 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
@@ -185,6 +185,8 @@ bool amdgpu_atombios_has_gpu_virtualization_table(struct amdgpu_device *adev);
 void amdgpu_atombios_scratch_regs_lock(struct amdgpu_device *adev, bool lock);
 void amdgpu_atombios_scratch_regs_engine_hung(struct amdgpu_device *adev,
 					      bool hung);
+void amdgpu_atombios_scratch_regs_set_backlight_level(struct amdgpu_device *adev,
+						      u32 backlight_level);
 bool amdgpu_atombios_scratch_need_asic_init(struct amdgpu_device *adev);
 
 void amdgpu_atombios_copy_swap(u8 *dst, u8 *src, u8 num_bytes, bool to_le);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 40a4269770fa..05e4a0952a2b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -51,6 +51,7 @@
 #include <drm/drm_hdcp.h>
 #endif
 #include "amdgpu_pm.h"
+#include "amdgpu_atombios.h"
 
 #include "amd_shared.h"
 #include "amdgpu_dm_irq.h"
@@ -3918,6 +3919,9 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	caps = dm->backlight_caps[bl_idx];
 
 	dm->brightness[bl_idx] = user_brightness;
+	/* update scratch register */
+	if (bl_idx == 0)
+		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
 	brightness = convert_brightness_from_user(&caps, dm->brightness[bl_idx]);
 	link = (struct dc_link *)dm->backlight_link[bl_idx];
 
-- 
2.31.1

