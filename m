Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D0BC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 07:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B6610E2AF;
	Fri, 22 Jul 2022 07:35:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C25F10E2AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 07:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRslMtgo5L+2dd2cBvmuhQl78KNs11r8aXwMy66G6Y/io8ZA5HlLEFmaeEOEXsxLDsJDT5RyQ+DTt+WAoNd3AM/I9BUggDjjpBGj8uU1A7i18PpINfZODa2YVRhPhCIOROSYEUec8tLoLdWRssNYtDXGaj4EztE1POMO/1UhUixpFS0nUOkUx/OYAcvH5+hEY7HlIm8RiDrEb/5Zzb3mcIro7G0FOrsLc3BR4GQceBlg090h82znmcEkPBhdwAYLIubMV1jiE+taICSUG4st6pH0EQoTs3a0zz+o/ZiC8jh0xdTl77Cmezht2S6D5Az3OhGO6YUZj8iyKIRonkhm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsHVmus9ijMekVwOXnAMeXqfutAKXbouHF4EbccQ240=;
 b=Vl48Hp03vU0esphSoqMucX29pkAxsRuSkycISSlBsoJfDiKqzj//boUD7Xm/cTqdrL2exSWyAGeIX2dvdh3x9jDnp7RuiKjll2b6KZoQyyxdvag/SpV7UaSQ6Nx6/Xl4CSRoeY7+BPuWJG1LwPtycav8Vfh2SisoWIO4HGsmWer+MmwQGvWzbpIJoAgLj2ZgMWRvl5Rt4scQgEBU9yzXO7mvTH5ad9fsKwmpGOptyw1zS72t/9vG0WuDU4eD97+lWdNFJvG9z2awPUskOx8wJq6vlUZwX4Mfm9xJEKd0SGlZP4DAXF6DKlgCW+Maah3ZElq5jHNQhDzrqjTRusdMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsHVmus9ijMekVwOXnAMeXqfutAKXbouHF4EbccQ240=;
 b=r9sIbvcPRX8lKXmBHx6F2yrkOhxK2og+yu74f8rruzeOujbNBqGe0OqljaKuocgtQmd+eE7fJcJ9TUrOA9gcKMz0z3jOAYX/3DrtPY7FgxPpZDx8vjEQvju2by46Q82C/BDaRzsF5gH7BR0x1/i5YO1wsD/pC+os1QL5CfWUBLg=
Received: from BN0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:e8::25)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 07:35:06 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::1f) by BN0PR04CA0050.outlook.office365.com
 (2603:10b6:408:e8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 22 Jul 2022 07:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 07:35:05 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 02:35:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 00:34:55 -0700
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 22 Jul 2022 02:34:54 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: revert context to stop engine before mode2
 reset
Date: Fri, 22 Jul 2022 15:34:02 +0800
Message-ID: <20220722073403.5171-4-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722073403.5171-1-Victor.Zhao@amd.com>
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 006e40a5-3c91-44cc-e178-08da6bb4b25e
X-MS-TrafficTypeDiagnostic: CO6PR12MB5443:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5K+YiQ3QqRfAb0o7kkJ7h/Un8tiT+MW3WjK5qgG01P1ZHXdpPUKj++o6f+RtxHWyr4meSC+ztkKCEAYbdHTp1V5xDfe9bkrgQrG+5YeJw3nHIrVK+9MbcLqhZwmFLNP9MfCkJOkdgru/DJXgGgNEzoT/UMOGuau14WQ7it9hzMvfuU4SVBgUNNmwAkiNGG+dSOpiIceryyo3qmAK/tLvlhKJh1W1oV1ZRGJhFvVgNM/5TvE+jDWPhSgdzRHEEByd5J3C4LvxTOhXSulrv0AR6/eHZ1RvDCjkr5oyL37LUzsb/lSywZNN6ydmDAo7gysORwNwi5UCZQlqPunJ3+MtqaWWgw43jFBFTBiNHsTVo7rqV8aVqVcX/qr+AdWF2+kc06hkOEjW9mUVKHB0izDiDsahc4jlfQveNHfotzXzOdKiwgPkx/O9w56XN439Hncsi7QuzYm3rn1eCJ7QNpJouwFKAiLqgDTDoEGget26rt3co3pT3Kv3R3He3ouw6D0ZOtDAHjAFNMrNgjwqsER/IpUh3E2ZeZmxD6HZsUE2mhFyJNbXWy7awoTt/n7FXcdUOyHVXbRtu+6prJkGpzr9Sk/WRidW5D1RYs7/YzjwDZUsP5XuNc1nR3UTDVSlNWdfdYCXExleltzwztBjIBWtLQfYjTnsByQVie1dmQyIsaQBRAHJ6Xk9Mm0tQLjVEjAHyoJAZ+Nf2IxPbdYoVjYw8HhWw4KIk6InAZiAxm457VXxvi4YDzr+dBQwrDlymVoietk3mD2DV3HIcVoq9ymATGm+jkjYjbOiOdnwG0ip0HAu9bEUt+e/Tv8PAp7a4ZvKlgj53R1/4R0x7NpyNZtZFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(54906003)(6916009)(8676002)(4326008)(86362001)(70206006)(70586007)(356005)(82740400003)(81166007)(478600001)(316002)(5660300002)(8936002)(41300700001)(83380400001)(2616005)(82310400005)(7696005)(6666004)(2906002)(36860700001)(26005)(40480700001)(186003)(1076003)(426003)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 07:35:05.6569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 006e40a5-3c91-44cc-e178-08da6bb4b25e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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
Cc: Alexander.Deucher@amd.com, emily.deng@amd.com,
 Victor Zhao <Victor.Zhao@amd.com>, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For some hang caused by slow tests, engine cannot be stopped which
may cause resume failure after reset. In this case, force halt
engine by reverting context addresses

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 36 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c |  2 ++
 4 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5498fda8617f..833dc5e224d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5037,6 +5037,7 @@ static void amdgpu_device_recheck_guilty_jobs(
 
 			/* set guilty */
 			drm_sched_increase_karma(s_job);
+			amdgpu_reset_prepare_hwcontext(adev, reset_context);
 retry:
 			/* do hw reset */
 			if (amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
index f8036f2b100e..c7b44aeb671b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
@@ -37,6 +37,7 @@ struct amdgpu_gfxhub_funcs {
 	void (*utcl2_harvest)(struct amdgpu_device *adev);
 	void (*mode2_save_regs)(struct amdgpu_device *adev);
 	void (*mode2_restore_regs)(struct amdgpu_device *adev);
+	void (*halt)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_gfxhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 51cf8acd2d79..8cf53e039c11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -646,6 +646,41 @@ static void gfxhub_v2_1_restore_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, adev->gmc.MC_VM_MX_L1_TLB_CNTL);
 }
 
+static void gfxhub_v2_1_halt(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	int i;
+	uint32_t tmp;
+	int time = 1000;
+
+	gfxhub_v2_1_set_fault_enable_default(adev, false);
+
+	for (i = 0; i <= 14; i++) {
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+				    i * hub->ctx_addr_distance, ~0);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+				    i * hub->ctx_addr_distance, ~0);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+				    i * hub->ctx_addr_distance,
+				    0);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+				    i * hub->ctx_addr_distance,
+				    0);
+	}
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
+	while ((tmp & (GRBM_STATUS2__EA_BUSY_MASK |
+		      GRBM_STATUS2__EA_LINK_BUSY_MASK)) != 0 &&
+	       time) {
+		udelay(100);
+		time--;
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
+	}
+
+	if (!time) {
+		DRM_WARN("failed to wait for GRBM(EA) idle\n");
+	}
+}
+
 const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
 	.get_fb_location = gfxhub_v2_1_get_fb_location,
 	.get_mc_fb_offset = gfxhub_v2_1_get_mc_fb_offset,
@@ -658,4 +693,5 @@ const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
 	.utcl2_harvest = gfxhub_v2_1_utcl2_harvest,
 	.mode2_save_regs = gfxhub_v2_1_save_regs,
 	.mode2_restore_regs = gfxhub_v2_1_restore_regs,
+	.halt = gfxhub_v2_1_halt,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 51a5b68f77d3..fead7251292f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -97,6 +97,8 @@ sienna_cichlid_mode2_prepare_hwcontext(struct amdgpu_reset_control *reset_ctl,
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->gfxhub.funcs->mode2_save_regs)
 			adev->gfxhub.funcs->mode2_save_regs(adev);
+		if (adev->gfxhub.funcs->halt)
+			adev->gfxhub.funcs->halt(adev);
 		r = sienna_cichlid_mode2_suspend_ip(adev);
 	}
 
-- 
2.25.1

