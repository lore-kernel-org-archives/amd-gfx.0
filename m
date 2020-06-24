Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DC3C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 11:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADBD2082F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 11:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lk0BOuod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADBD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12FB46EACC;
	Wed, 24 Jun 2020 11:50:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770044.outbound.protection.outlook.com [40.107.77.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247376EACC
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 11:50:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oS/5Wo95a01u1+S2xuO8kMLL8mhv0whTosih/zwutYVtiqt/wp89RmrqhadL+lKoS3nLVcdvOOMaQmEfnGuQ4PeJa5mCr8ozFzTFeIn1Rw0cSdbZATSGUSCaS9AfqEn2aG5vYYT8AQcr2dNrnKF/myT3qXEO7m4/oyI9gBZY8QyvdJ17xhVd2CfZZHoW1yg7JHbIjAHAeJYNHxxxMmqHuUHMfg2CbTcWUUTtWw/fZmF3X7zwVj/WLf0pBFu6D0+eP77jpKpLBZb12mty4KH53KNE+0Wz9sahT3gonl2CrxJJntu8ZJFPYWnHaZ4t31GJ0WPu3NWnrqltRYKN0pditQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NSDvHN3PxuQgRp8OipNPgT+5WkiLLa9HT6DcNIX84o=;
 b=hyiMnt8nx+d9dXn1G9lHPh9f2qEx0ceratbLkfwHSH448Qe/TRx9+DxrMiv1TJHgBkia0ljXNWIJLrbUs8UTXYY+wqcd1Tw2D6Lptj6xg4tWZMW1fTubMmS02RoJfqL9Bvi0UhPsY9edzGFUn3F98E+CdXyVWbG1YLYWqFlXV5W06YbHUkhbsSClXe03NuISyQlKc847ET5xp6yC+QwYYFEZiITB5Hb5fhdWafO8QKEdhzDj6wBKgFMQy/eR2/CIK4BrETz7gFGE/7C8+uFt5CMQ2w3sED64TlbFRNeKMiGRT37pg//EtLrCLh9MewcCXXsFGO895vj0qplTc6qKhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NSDvHN3PxuQgRp8OipNPgT+5WkiLLa9HT6DcNIX84o=;
 b=Lk0BOuodtbfAx7tcaA2d7YB6HyokE5MLFKxvU0KRcopABrXPiBJgGzMskma7RJhQYdzv6bxWXAy1OrBSMuYWQVysTXlTUBdmjXTZOW1tRZG/gmZu73IudWBxGGAyTMKUOmKnq9GkpP+i+AzuVrh5Qfj6TCsoV+ODO/KVzJMpVJs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2422.namprd12.prod.outlook.com (2603:10b6:4:b9::27) by
 DM5PR12MB1562.namprd12.prod.outlook.com (2603:10b6:4:d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.23; Wed, 24 Jun 2020 11:50:00 +0000
Received: from DM5PR12MB2422.namprd12.prod.outlook.com
 ([fe80::2107:be9e:d79b:34ee]) by DM5PR12MB2422.namprd12.prod.outlook.com
 ([fe80::2107:be9e:d79b:34ee%3]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 11:50:00 +0000
From: Alex Jivin <alex.jivin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: SI support for UVD and VCE power managment
Date: Wed, 24 Jun 2020 07:49:48 -0400
Message-Id: <20200624114948.30948-1-alex.jivin@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::49) To DM5PR12MB2422.namprd12.prod.outlook.com
 (2603:10b6:4:b9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.151.153) by
 YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Wed, 24 Jun 2020 11:50:00 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.162.151.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88b7843d-9c86-478e-f417-08d81834b983
X-MS-TrafficTypeDiagnostic: DM5PR12MB1562:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1562247F20D3C33077F21C7391950@DM5PR12MB1562.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmXZH2OGI4bd5WT4wRCdsczKepz23JcM8GWIfG3ZqujMdYhddMocUE9l3XHL7gmCaXm4zcPiqaxar2HNHgyc63LE9tNR1dfBH+mqLFPZKnsMA/NN2vyRGDcZstj1Y6Wlf4SjTgP9nuWG1AFl2TxTVqRWmKaudhN8R4wGFHbi66UQ0WOYqPSo8nGSGSJQVLor/t3vMAH2XukABMwmCWCxKoMJxoAmm6Y5Ph7T0FR1gCTnDVYQWg73I7T/pK1lpKATtXQ1675148DLR3oGfHn7eNvZX982fFaSG1bXGPGgKRhrcbGzEHvUO6m33x40nw9fQitJXRbz0K3Y5I7d5XVG/Ot0WMA1aT0l2blROnHb3HQd3hukkNgmETSm9BXVrGAI/hFUM5GZMyguwJqBa2wwgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2422.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(6486002)(956004)(2616005)(69590400007)(36756003)(44832011)(6512007)(8676002)(52116002)(86362001)(16526019)(6506007)(55236004)(316002)(186003)(4326008)(26005)(478600001)(8936002)(1076003)(30864003)(5660300002)(6666004)(66476007)(66556008)(66946007)(83380400001)(6916009)(2906002)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0KJo1v7gIlU73KGKzBAhPwsyajkWRABDT3TfbJWCKbE62PC77fsKxa53Kx8+kUfDeBE9kUUzroEBmAY21JK0ZOAaGs79xcpSjVXR++UBVVBEB5jzvfUtJhA035iWkWJ1ON94dLWDI5GrHQGrDmjl9AL5LbUu5DSTNV2wGvmfTFoN/acXLfm6IZps12zJrma00LK05BRAbTc5e81Zgql4I1qx2aweNJCmsqvx08KVipVZtOzmQwS6OJEipjwqY627PSOOetnCG0icJiH5oJD1sZzVH0YpWA1y3s4a1JN0SRY73nRbztYuI1VUlLZbegsQQyWpv3snFWnzf4LEbq4pUOnrt6xNVFrDyVhGBiXL3zuwwEZZbrypcfveQ9ukoYHRshFQHL5mZCa8FQzy3kHgFE2//bHwReLfi226/8eMxbbhU86owZMe9EJIoBWNVPInZ0JQtjbfK2ZHE0FNZhyNoV+xQrekp41UiWe2WGAVN6bBfQusqDzt4hvgsKkRCQTz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b7843d-9c86-478e-f417-08d81834b983
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 11:50:00.4762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKiS3AF2VVN5j9T/9QZ2We9ZmDw3gr7rlpb2znKbP5+kiROJubxTZpCVwyKOM1oNOcVPqKP3kxkDQ1EkKTO9SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1562
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Port functionality from the Radeon driver to support
UVD and VCE power management.

Signed-off-by: Alex Jivin <alex.jivin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c |  67 +++--
 drivers/gpu/drm/amd/amdgpu/si.c        | 361 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c    |  19 ++
 drivers/gpu/drm/amd/amdgpu/sid.h       |  32 +++
 5 files changed, 462 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6c7dd0a707c9..4b5a9a259a21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1083,6 +1083,15 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 		tmp_ |= ((val) & ~(mask));			\
 		WREG32_PLL(reg, tmp_);				\
 	} while (0)
+
+#define WREG32_SMC_P(_Reg, _Val, _Mask)                         \
+	do {                                                    \
+		u32 tmp = RREG32_SMC(_Reg);                     \
+		tmp &= (_Mask);                                 \
+		tmp |= ((_Val) & ~(_Mask));                     \
+		WREG32_SMC(_Reg, tmp);                          \
+	} while (0)
+
 #define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_device_rreg((adev), (reg), false))
 #define RREG32_IO(reg) amdgpu_io_rreg(adev, (reg))
 #define WREG32_IO(reg, v) amdgpu_io_wreg(adev, (reg), (v))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 347b06d3c140..26c8e39a78bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -3558,21 +3558,36 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
-	if (ret)
-		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
-			  enable ? "enable" : "disable", ret);
-
-	/* enable/disable Low Memory PState for UVD (4k videos) */
-	if (adev->asic_type == CHIP_STONEY &&
-		adev->uvd.decode_image_width >= WIDTH_4K) {
-		struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
+	if (adev->family == AMDGPU_FAMILY_SI) {
+		if (enable) {
+			mutex_lock(&adev->pm.mutex);
+			adev->pm.dpm.uvd_active = true;
+			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
+			mutex_unlock(&adev->pm.mutex);
+		} else {
+			mutex_lock(&adev->pm.mutex);
+			adev->pm.dpm.uvd_active = false;
+			mutex_unlock(&adev->pm.mutex);
+		}
 
-		if (hwmgr && hwmgr->hwmgr_func &&
-		    hwmgr->hwmgr_func->update_nbdpm_pstate)
-			hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
-							       !enable,
-							       true);
+		amdgpu_pm_compute_clocks(adev);
+	} else {
+		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
+		if (ret)
+			DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+				  enable ? "enable" : "disable", ret);
+
+		/* enable/disable Low Memory PState for UVD (4k videos) */
+		if (adev->asic_type == CHIP_STONEY &&
+			adev->uvd.decode_image_width >= WIDTH_4K) {
+			struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
+
+			if (hwmgr && hwmgr->hwmgr_func &&
+			    hwmgr->hwmgr_func->update_nbdpm_pstate)
+				hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
+								       !enable,
+								       true);
+		}
 	}
 }
 
@@ -3580,10 +3595,26 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
-	if (ret)
-		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
-			  enable ? "enable" : "disable", ret);
+	if (adev->family == AMDGPU_FAMILY_SI) {
+		if (enable) {
+			mutex_lock(&adev->pm.mutex);
+			adev->pm.dpm.vce_active = true;
+			/* XXX select vce level based on ring/task */
+			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
+			mutex_unlock(&adev->pm.mutex);
+		} else {
+			mutex_lock(&adev->pm.mutex);
+			adev->pm.dpm.vce_active = false;
+			mutex_unlock(&adev->pm.mutex);
+		}
+
+		amdgpu_pm_compute_clocks(adev);
+	} else {
+		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
+		if (ret)
+			DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
+				  enable ? "enable" : "disable", ret);
+	}
 }
 
 void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index cda9aa5e4b9e..471489436b49 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1266,12 +1266,6 @@ static u32 si_get_xclk(struct amdgpu_device *adev)
 	return reference_clock;
 }
 
-//xxx:not implemented
-static int si_set_uvd_clocks(struct amdgpu_device *adev, u32 vclk, u32 dclk)
-{
-	return 0;
-}
-
 static void si_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 {
 	if (!ring || !ring->funcs->emit_wreg) {
@@ -1427,6 +1421,358 @@ static uint64_t si_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
+static int si_uvd_send_upll_ctlreq(struct amdgpu_device *adev,
+				   unsigned cg_upll_func_cntl)
+{
+	unsigned i;
+
+	/* Make sure UPLL_CTLREQ is deasserted */
+	WREG32_P(cg_upll_func_cntl, 0, ~UPLL_CTLREQ_MASK);
+
+	mdelay(10);
+
+	/* Assert UPLL_CTLREQ */
+	WREG32_P(cg_upll_func_cntl, UPLL_CTLREQ_MASK, ~UPLL_CTLREQ_MASK);
+
+	/* Wait for CTLACK and CTLACK2 to get asserted */
+	for (i = 0; i < SI_MAX_CTLACKS_ASSERTION_WAIT; ++i) {
+		uint32_t mask = UPLL_CTLACK_MASK | UPLL_CTLACK2_MASK;
+
+		if ((RREG32(cg_upll_func_cntl) & mask) == mask)
+			break;
+		mdelay(10);
+	}
+
+	/* Deassert UPLL_CTLREQ */
+	WREG32_P(cg_upll_func_cntl, 0, ~UPLL_CTLREQ_MASK);
+
+	if (i == SI_MAX_CTLACKS_ASSERTION_WAIT) {
+		DRM_ERROR("Timeout setting UVD clocks!\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static unsigned si_uvd_calc_upll_post_div(unsigned vco_freq,
+					  unsigned target_freq,
+					  unsigned pd_min,
+					  unsigned pd_even)
+{
+	unsigned post_div = vco_freq / target_freq;
+
+	/* Adjust to post divider minimum value */
+	if (post_div < pd_min)
+		post_div = pd_min;
+
+	/* We alway need a frequency less than or equal the target */
+	if ((vco_freq / post_div) > target_freq)
+		post_div += 1;
+
+	/* Post dividers above a certain value must be even */
+	if (post_div > pd_even && post_div % 2)
+		post_div += 1;
+
+	return post_div;
+}
+
+/**
+ * si_calc_upll_dividers - calc UPLL clock dividers
+ *
+ * @adev: amdgpu_device pointer
+ * @vclk: wanted VCLK
+ * @dclk: wanted DCLK
+ * @vco_min: minimum VCO frequency
+ * @vco_max: maximum VCO frequency
+ * @fb_factor: factor to multiply vco freq with
+ * @fb_mask: limit and bitmask for feedback divider
+ * @pd_min: post divider minimum
+ * @pd_max: post divider maximum
+ * @pd_even: post divider must be even above this value
+ * @optimal_fb_div: resulting feedback divider
+ * @optimal_vclk_div: resulting vclk post divider
+ * @optimal_dclk_div: resulting dclk post divider
+ *
+ * Calculate dividers for UVDs UPLL (except APUs).
+ * Returns zero on success; -EINVAL on error.
+ */
+static int si_calc_upll_dividers(struct amdgpu_device *adev,
+				 unsigned vclk, unsigned dclk,
+				 unsigned vco_min, unsigned vco_max,
+				 unsigned fb_factor, unsigned fb_mask,
+				 unsigned pd_min, unsigned pd_max,
+				 unsigned pd_even,
+				 unsigned *optimal_fb_div,
+				 unsigned *optimal_vclk_div,
+				 unsigned *optimal_dclk_div)
+{
+	unsigned vco_freq, ref_freq = adev->clock.spll.reference_freq;
+
+	/* Start off with something large */
+	unsigned optimal_score = ~0;
+
+	/* Loop through vco from low to high */
+	vco_min = max(max(vco_min, vclk), dclk);
+	for (vco_freq = vco_min; vco_freq <= vco_max; vco_freq += 100) {
+		uint64_t fb_div = (uint64_t)vco_freq * fb_factor;
+		unsigned vclk_div, dclk_div, score;
+
+		do_div(fb_div, ref_freq);
+
+		/* fb div out of range ? */
+		if (fb_div > fb_mask)
+			break; /* It can oly get worse */
+
+		fb_div &= fb_mask;
+
+		/* Calc vclk divider with current vco freq */
+		vclk_div = si_uvd_calc_upll_post_div(vco_freq, vclk,
+						     pd_min, pd_even);
+		if (vclk_div > pd_max)
+			break; /* vco is too big, it has to stop */
+
+		/* Calc dclk divider with current vco freq */
+		dclk_div = si_uvd_calc_upll_post_div(vco_freq, dclk,
+						     pd_min, pd_even);
+		if (dclk_div > pd_max)
+			break; /* vco is too big, it has to stop */
+
+		/* Calc score with current vco freq */
+		score = vclk - (vco_freq / vclk_div) + dclk - (vco_freq / dclk_div);
+
+		/* Determine if this vco setting is better than current optimal settings */
+		if (score < optimal_score) {
+			*optimal_fb_div = fb_div;
+			*optimal_vclk_div = vclk_div;
+			*optimal_dclk_div = dclk_div;
+			optimal_score = score;
+			if (optimal_score == 0)
+				break; /* It can't get better than this */
+		}
+	}
+
+	/* Did we found a valid setup ? */
+	if (optimal_score == ~0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int si_set_uvd_clocks(struct amdgpu_device *adev, u32 vclk, u32 dclk)
+{
+	unsigned fb_div = 0, vclk_div = 0, dclk_div = 0;
+	int a;
+
+	/* Bypass vclk and dclk with bclk */
+	WREG32_P(CG_UPLL_FUNC_CNTL_2,
+		 VCLK_SRC_SEL(1) | DCLK_SRC_SEL(1),
+		 ~(VCLK_SRC_SEL_MASK | DCLK_SRC_SEL_MASK));
+
+	/* Put PLL in bypass mode */
+	WREG32_P(CG_UPLL_FUNC_CNTL, UPLL_BYPASS_EN_MASK, ~UPLL_BYPASS_EN_MASK);
+
+	if (!vclk || !dclk) {
+		/* Keep the Bypass mode */
+		return 0;
+	}
+
+	a = si_calc_upll_dividers(adev, vclk, dclk, 125000, 250000,
+				  16384, 0x03FFFFFF, 0, 128, 5,
+				  &fb_div, &vclk_div, &dclk_div);
+	if (a)
+		return a;
+
+	/* Set RESET_ANTI_MUX to 0 */
+	WREG32_P(CG_UPLL_FUNC_CNTL_5, 0, ~RESET_ANTI_MUX_MASK);
+
+	/* Set VCO_MODE to 1 */
+	WREG32_P(CG_UPLL_FUNC_CNTL, UPLL_VCO_MODE_MASK, ~UPLL_VCO_MODE_MASK);
+
+	/* Disable sleep mode */
+	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_SLEEP_MASK);
+
+	/* Deassert UPLL_RESET */
+	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_RESET_MASK);
+
+	mdelay(1);
+
+	a = si_uvd_send_upll_ctlreq(adev, CG_UPLL_FUNC_CNTL);
+	if (a)
+		return a;
+
+	/* Assert UPLL_RESET again */
+	WREG32_P(CG_UPLL_FUNC_CNTL, UPLL_RESET_MASK, ~UPLL_RESET_MASK);
+
+	/* Disable spread spectrum. */
+	WREG32_P(CG_UPLL_SPREAD_SPECTRUM, 0, ~SSEN_MASK);
+
+	/* Set feedback divider */
+	WREG32_P(CG_UPLL_FUNC_CNTL_3, UPLL_FB_DIV(fb_div), ~UPLL_FB_DIV_MASK);
+
+	/* Set ref divider to 0 */
+	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_REF_DIV_MASK);
+
+	if (fb_div < 307200)
+		WREG32_P(CG_UPLL_FUNC_CNTL_4, 0, ~UPLL_SPARE_ISPARE9);
+	else
+		WREG32_P(CG_UPLL_FUNC_CNTL_4,
+			 UPLL_SPARE_ISPARE9,
+			 ~UPLL_SPARE_ISPARE9);
+
+	/* Set PDIV_A and PDIV_B */
+	WREG32_P(CG_UPLL_FUNC_CNTL_2,
+		 UPLL_PDIV_A(vclk_div) | UPLL_PDIV_B(dclk_div),
+		 ~(UPLL_PDIV_A_MASK | UPLL_PDIV_B_MASK));
+
+	/* Give the PLL some time to settle */
+	mdelay(15);
+
+	/* Deassert PLL_RESET */
+	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_RESET_MASK);
+
+	mdelay(15);
+
+	/* Switch from bypass mode to normal mode */
+	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_BYPASS_EN_MASK);
+
+	a = si_uvd_send_upll_ctlreq(adev, CG_UPLL_FUNC_CNTL);
+	if (a)
+		return a;
+
+	/* Switch VCLK and DCLK selection */
+	WREG32_P(CG_UPLL_FUNC_CNTL_2,
+		 VCLK_SRC_SEL(2) | DCLK_SRC_SEL(2),
+		 ~(VCLK_SRC_SEL_MASK | DCLK_SRC_SEL_MASK));
+
+	mdelay(100);
+
+	return 0;
+}
+
+static int si_vce_send_vcepll_ctlreq(struct amdgpu_device *adev)
+{
+	unsigned i;
+
+	/* Make sure VCEPLL_CTLREQ is deasserted */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
+
+	mdelay(10);
+
+	/* Assert UPLL_CTLREQ */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, UPLL_CTLREQ_MASK, ~UPLL_CTLREQ_MASK);
+
+	/* Wait for CTLACK and CTLACK2 to get asserted */
+	for (i = 0; i < SI_MAX_CTLACKS_ASSERTION_WAIT; ++i) {
+		uint32_t mask = UPLL_CTLACK_MASK | UPLL_CTLACK2_MASK;
+
+		if ((RREG32_SMC(CG_VCEPLL_FUNC_CNTL) & mask) == mask)
+			break;
+		mdelay(10);
+	}
+
+	/* Deassert UPLL_CTLREQ */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
+
+	if (i == SI_MAX_CTLACKS_ASSERTION_WAIT) {
+		DRM_ERROR("Timeout setting UVD clocks!\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
+{
+	unsigned fb_div = 0, evclk_div = 0, ecclk_div = 0;
+	int a;
+
+	/* Bypass evclk and ecclk with bclk */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
+		     EVCLK_SRC_SEL(1) | ECCLK_SRC_SEL(1),
+		     ~(EVCLK_SRC_SEL_MASK | ECCLK_SRC_SEL_MASK));
+
+	/* Put PLL in bypass mode */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_BYPASS_EN_MASK,
+		     ~VCEPLL_BYPASS_EN_MASK);
+
+	if (!evclk || !ecclk) {
+		/* Keep the Bypass mode, put PLL to sleep */
+		WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_SLEEP_MASK,
+			     ~VCEPLL_SLEEP_MASK);
+		return 0;
+	}
+
+	a = si_calc_upll_dividers(adev, evclk, ecclk, 125000, 250000,
+				  16384, 0x03FFFFFF, 0, 128, 5,
+				  &fb_div, &evclk_div, &ecclk_div);
+	if (a)
+		return a;
+
+	/* Set RESET_ANTI_MUX to 0 */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_5, 0, ~RESET_ANTI_MUX_MASK);
+
+	/* Set VCO_MODE to 1 */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_VCO_MODE_MASK,
+		     ~VCEPLL_VCO_MODE_MASK);
+
+	/* Toggle VCEPLL_SLEEP to 1 then back to 0 */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_SLEEP_MASK,
+		     ~VCEPLL_SLEEP_MASK);
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_SLEEP_MASK);
+
+	/* Deassert VCEPLL_RESET */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_RESET_MASK);
+
+	mdelay(1);
+
+	a = si_vce_send_vcepll_ctlreq(adev);
+	if (a)
+		return a;
+
+	/* Assert VCEPLL_RESET again */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_RESET_MASK, ~VCEPLL_RESET_MASK);
+
+	/* Disable spread spectrum. */
+	WREG32_SMC_P(CG_VCEPLL_SPREAD_SPECTRUM, 0, ~SSEN_MASK);
+
+	/* Set feedback divider */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_3,
+		     VCEPLL_FB_DIV(fb_div),
+		     ~VCEPLL_FB_DIV_MASK);
+
+	/* Set ref divider to 0 */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_REF_DIV_MASK);
+
+	/* Set PDIV_A and PDIV_B */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
+		     VCEPLL_PDIV_A(evclk_div) | VCEPLL_PDIV_B(ecclk_div),
+		     ~(VCEPLL_PDIV_A_MASK | VCEPLL_PDIV_B_MASK));
+
+	/* Give the PLL some time to settle */
+	mdelay(15);
+
+	/* Deassert PLL_RESET */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_RESET_MASK);
+
+	mdelay(15);
+
+	/* Switch from bypass mode to normal mode */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_BYPASS_EN_MASK);
+
+	a = si_vce_send_vcepll_ctlreq(adev);
+	if (a)
+		return a;
+
+	/* Switch VCLK and DCLK selection */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
+		     EVCLK_SRC_SEL(16) | ECCLK_SRC_SEL(16),
+		     ~(EVCLK_SRC_SEL_MASK | ECCLK_SRC_SEL_MASK));
+
+	mdelay(100);
+
+	return 0;
+}
+
 static const struct amdgpu_asic_funcs si_asic_funcs =
 {
 	.read_disabled_bios = &si_read_disabled_bios,
@@ -1437,7 +1783,7 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
 	.set_vga_state = &si_vga_set_state,
 	.get_xclk = &si_get_xclk,
 	.set_uvd_clocks = &si_set_uvd_clocks,
-	.set_vce_clocks = NULL,
+	.set_vce_clocks = &si_set_vce_clocks,
 	.get_pcie_lanes = &si_get_pcie_lanes,
 	.set_pcie_lanes = &si_set_pcie_lanes,
 	.get_config_memsize = &si_get_config_memsize,
@@ -2228,4 +2574,3 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 	}
 	return 0;
 }
-
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index c00ba4b23c9a..ea914b256ebd 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -6953,6 +6953,24 @@ static int si_power_control_set_level(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void si_set_vce_clock(struct amdgpu_device *adev,
+			     struct amdgpu_ps *new_rps,
+			     struct amdgpu_ps *old_rps)
+{
+	if ((old_rps->evclk != new_rps->evclk) ||
+	    (old_rps->ecclk != new_rps->ecclk)) {
+		/* Turn the clocks on when encoding, off otherwise */
+		if (new_rps->evclk || new_rps->ecclk) {
+			/* Place holder for future VCE1.0 porting to amdgpu
+			vce_v1_0_enable_mgcg(adev, false, false);*/
+		} else {
+			/* Place holder for future VCE1.0 porting to amdgpu
+			vce_v1_0_enable_mgcg(adev, true, false);
+			amdgpu_asic_set_vce_clocks(adev, new_rps->evclk, new_rps->ecclk);*/
+		}
+	}
+}
+
 static int si_dpm_set_power_state(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -7029,6 +7047,7 @@ static int si_dpm_set_power_state(void *handle)
 		return ret;
 	}
 	ni_set_uvd_clock_after_set_eng_clock(adev, new_ps, old_ps);
+	si_set_vce_clock(adev, new_ps, old_ps);
 	if (eg_pi->pcie_performance_request)
 		si_notify_link_speed_change_after_state_change(adev, new_ps, old_ps);
 	ret = si_set_power_state_conditionally_enable_ulv(adev, new_ps);
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index 75b5d441b628..6156a795ad6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -47,6 +47,7 @@
 #define SI_MAX_LDS_NUM           	0xFFFF
 #define SI_MAX_TCC               	16
 #define SI_MAX_TCC_MASK          	0xFFFF
+#define SI_MAX_CTLACKS_ASSERTION_WAIT   100
 
 #define AMDGPU_NUM_OF_VMIDS 		8
 
@@ -2479,4 +2480,35 @@
 
 #define	MC_VM_FB_OFFSET					0x81a
 
+/* Discrete VCE clocks */
+#define CG_VCEPLL_FUNC_CNTL                             0xc0030600
+#define    VCEPLL_RESET_MASK                            0x00000001
+#define    VCEPLL_SLEEP_MASK                            0x00000002
+#define    VCEPLL_BYPASS_EN_MASK                        0x00000004
+#define    VCEPLL_CTLREQ_MASK                           0x00000008
+#define    VCEPLL_VCO_MODE_MASK                         0x00000600
+#define    VCEPLL_REF_DIV_MASK                          0x003F0000
+#define    VCEPLL_CTLACK_MASK                           0x40000000
+#define    VCEPLL_CTLACK2_MASK                          0x80000000
+
+#define CG_VCEPLL_FUNC_CNTL_2                           0xc0030601
+#define    VCEPLL_PDIV_A(x)                             ((x) << 0)
+#define    VCEPLL_PDIV_A_MASK                           0x0000007F
+#define    VCEPLL_PDIV_B(x)                             ((x) << 8)
+#define    VCEPLL_PDIV_B_MASK                           0x00007F00
+#define    EVCLK_SRC_SEL(x)                             ((x) << 20)
+#define    EVCLK_SRC_SEL_MASK                           0x01F00000
+#define    ECCLK_SRC_SEL(x)                             ((x) << 25)
+#define    ECCLK_SRC_SEL_MASK                           0x3E000000
+
+#define CG_VCEPLL_FUNC_CNTL_3                           0xc0030602
+#define    VCEPLL_FB_DIV(x)                             ((x) << 0)
+#define    VCEPLL_FB_DIV_MASK                           0x01FFFFFF
+
+#define CG_VCEPLL_FUNC_CNTL_4                           0xc0030603
+
+#define CG_VCEPLL_FUNC_CNTL_5                           0xc0030604
+#define CG_VCEPLL_SPREAD_SPECTRUM                       0xc0030606
+#define    VCEPLL_SSEN_MASK                             0x00000001
+
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
