Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A59C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 15:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DF7910E6F0;
	Tue, 18 Jun 2024 15:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E5DwJ21K";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 913DA10E6F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 15:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezI0KH3j5Tcj7S5qEyPjK/dHVWMeVSuiT+e+ARovqvViY/G7bEDs+PQIyPHThFhm3HGVe9r+SBN2i2alxg4qDt7+u0dbUx+wUL7aAg265Fnft64uSjiSpR/6bownHsA8pzaYqGggepC+dK09bHdUX0NV4npI+RG5ydOKv/Ssn8XKgaiMDlvEf0fwVvHqcLo0GMiYOFXZZVfv9mNWKVyz+jYq55hTB/8X0yARZWvuWb9/WKn/QSNBqsQ+CEXCbfnFQb5uyaLfRxnXlE59qgIBIQdXgu5NfRPNZ8loaGsdQqPaBGSWtaX0zktZD/vr+Cl2lINI6jQxzRlaWj866O1UGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dccipPhsfyVZdyqaX9cQdXg5vVuFIpTxdIsJ3x6/3P8=;
 b=S3nXEdCEp3Pg2ohDsm+7wyexvokgm3tp7Zdr0Zv3UsSCl/HhLHqzffRCnYPkWctSKUOev6VAvR/V4kZTizKuUqpoFXOKYgCCauz9lRKXb9WuXon+TrPwoItFa09Hi/Avpfb6i9RKHF7nlyrlEWBsj9i+TZQ9YMGeFLVt0vfZcv+MjjRdsBG9lQK2PnkHpiCfsW9NjdoiJDM070bU6K3QN6peCfY35+u16UgMSxOjtik176hRrPJVufKrOVAJU13XOH1/WfH3omjJf1wt6QTewAlXkWDl5FcC7vHETlNYEQAXaKDvtGJUAY9/7gwzllThaTXTbFO4vZHnGoVgPwwQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dccipPhsfyVZdyqaX9cQdXg5vVuFIpTxdIsJ3x6/3P8=;
 b=E5DwJ21Kfm1btl52cFei9Xso2p7n4lnoNuYNJyEcuKt0RV3LER0YNBGjouPE48FZg7cm5QNEJH7Xs17MU80Ax7UyI9gu5i89AHJb/dqFIQTYig0GF8eRX5pJq56Kv2hEkoTV+z4XxjXFwAaWXFGkuPkBtdhvkBPD6j8SzlZqKiA=
Received: from MW4PR03CA0287.namprd03.prod.outlook.com (2603:10b6:303:b5::22)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 15:30:51 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::8) by MW4PR03CA0287.outlook.office365.com
 (2603:10b6:303:b5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 15:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 15:30:50 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 10:30:48 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: cache mclk/sclk min/max values
Date: Tue, 18 Jun 2024 17:23:26 +0200
Message-ID: <20240618153003.146168-6-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: b3784146-1325-4217-c543-08dc8faba24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aycbtIjSBxzSeIbuxQ41cTtooHZH6oxzE1dHdJVar6Xj92b0GSKaJd2Q8e4e?=
 =?us-ascii?Q?mT6nesYb6WBc6nDMO6SoQ6MEuU62WhSoeO8Y/HNqdjgHIOnOannm5ROxzks5?=
 =?us-ascii?Q?XNUzwtbNi0YLfcuiMh5nZmYTTGSaFmLPRypsAQL522gzWf1dRjcsdUSw+qHS?=
 =?us-ascii?Q?63CIbAnG7MA5L3Na+jXAwxXmfV/OuUfxb1ShpJA2iae5wKqMYIB4DvEE29qY?=
 =?us-ascii?Q?Cl6yDXnPvJBrq1CjXYGiofM6LYC+lJI+FP90jfwehDvj3JePU40/HZyMX5gO?=
 =?us-ascii?Q?eIvy2h1S+dBWy8jlvD1Q8ZrOXoPQ2oF4QX5t48iLyXOtO4Xfsnbiy42pzOta?=
 =?us-ascii?Q?9eYy5m4d/MRYkaVkxJ9cNF8V2H7qojy9JncOW53dC49KL07ufwQt9PqSlU+s?=
 =?us-ascii?Q?zmG2LOXE2HUy4HVWW1B3hzJa5jQP7pHGAoPvc3/biKP5IalGJOv1DRNXKSqr?=
 =?us-ascii?Q?ocsAGuJiwuWvfyPAM26Ow7zCJMcrkXLy7oLOCweq677S+85uOQ33cR1GxYuy?=
 =?us-ascii?Q?jbCsQgdQAuXVGATMFvEAGc4UzJrtPuh1vXBrdGYuj/FVuw2tH682PaT/3KgB?=
 =?us-ascii?Q?P5D+r+qAMJsa5ChgmWOvO58VEQh1j1kYRTZ1rgu70QB4FT08DCWQyfq0xCtN?=
 =?us-ascii?Q?zH2gDI6cuDL3abT7yimpo+fehF0nys/B7XUfPSmdr+Ody4SKdWPz5iv23J2V?=
 =?us-ascii?Q?ukd4diULWH9poGDeFnTiyOnK9kInokxNVWIyfeGxOYmw4/XlswPFPu6peLkY?=
 =?us-ascii?Q?dU5KurnIST+f51rU1MpM5rI5gCsDeFHEE31D3fRHgtDZstcGtyU4SuMzhvCg?=
 =?us-ascii?Q?PmpWCnQPM5cYofAxPLtbYbBsNkzyzyzdx5h8iD3eou8WJv40kFrmFvp0hy7T?=
 =?us-ascii?Q?MBaD0P2hTmtEisZ7AGcc4P4YecYCJRBd0++etiMDcl0a+HiENtwXLz1/KcbJ?=
 =?us-ascii?Q?Tix1z+kKit9DhK9a8aEH1Tg2j3HR3cRbYc6Nsg1Yz14hGwjE35Uwo4RNdUCP?=
 =?us-ascii?Q?7ZTXx16HK2ZqHyRK5jxlnm1h/Qt1fGZ03kiNn2ZYHiwRY0fbhuVvgBogwBPs?=
 =?us-ascii?Q?wpsDdWyqzfOXmn4XrSkjZQlMZ1++odecNUNlcIVq1Ed/wZEI1SLzmji2WyLw?=
 =?us-ascii?Q?vayenRYlGqzbPo+Rsw0VFASxWZjnPzQldjjHy8ZyXNilJQLq9zyeEcE4Z7ER?=
 =?us-ascii?Q?lFwwAYwMEAI84TM9JhyKPEy7n+FKcpwaoIkxUGcK4StDxh14IyOlDyEZSco7?=
 =?us-ascii?Q?jOE881WdG76ijIJlY7zj+ZBp8vs3aI0hOBUjLx84+GN96PYM3z5+o1encNSZ?=
 =?us-ascii?Q?/l9BC3KuhL2Ml8Ms45BwWJ4qPCkUzktFmC++RWkoIHrBAr3xEwSsYqIMN/cq?=
 =?us-ascii?Q?mM21M1r/DkX/GblWLBMVTi9SAfJUjg9lxr+Td1aJrQsVrDssxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:30:50.2831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3784146-1325-4217-c543-08dc8faba24e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This way these values can be returned directly when using
AMDGPU_INFO_DEV_INFO, without waking up the GPU.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  8 ++++----
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 19 +++++--------------
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  8 ++++----
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 12 ++++++------
 7 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 083f353cff6e..75db8eba73d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -418,8 +418,16 @@ struct amdgpu_clock {
 	struct amdgpu_pll spll;
 	struct amdgpu_pll mpll;
 	/* 10 Khz units */
-	uint32_t default_mclk;
-	uint32_t default_sclk;
+	struct {
+		uint32_t min;
+		uint32_t max;
+		uint32_t def;
+	} mclk;
+	struct {
+		uint32_t min;
+		uint32_t max;
+		uint32_t def;
+	} sclk;
 	uint32_t default_dispclk;
 	uint32_t current_dispclk;
 	uint32_t dp_extclk;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 7dc102f0bc1d..f2c2b05233f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -658,9 +658,9 @@ int amdgpu_atombios_get_clock_info(struct amdgpu_device *adev)
 		mpll->pll_in_max =
 		    le16_to_cpu(firmware_info->info.usMaxMemoryClockPLL_Input);
 
-		adev->clock.default_sclk =
+		adev->clock.sclk.def = adev->clock.sclk.min = adev->clock.sclk.max =
 		    le32_to_cpu(firmware_info->info.ulDefaultEngineClock);
-		adev->clock.default_mclk =
+		adev->clock.mclk.def = adev->clock.mclk.min = adev->clock.mclk.max =
 		    le32_to_cpu(firmware_info->info.ulDefaultMemoryClock);
 
 		mpll->min_post_div = 1;
@@ -699,8 +699,8 @@ int amdgpu_atombios_get_clock_info(struct amdgpu_device *adev)
 		ret = 0;
 	}
 
-	adev->pm.current_sclk = adev->clock.default_sclk;
-	adev->pm.current_mclk = adev->clock.default_mclk;
+	adev->pm.current_sclk = adev->clock.sclk.def;
+	adev->pm.current_mclk = adev->clock.mclk.def;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index f932bec6e534..6eb125b1bd08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -719,13 +719,13 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
 			(union firmware_info *)(mode_info->atom_context->bios +
 						data_offset);
 
-		adev->clock.default_sclk =
+		adev->clock.sclk.def = adev->clock.sclk.min = adev->clock.sclk.max =
 			le32_to_cpu(firmware_info->v31.bootup_sclk_in10khz);
-		adev->clock.default_mclk =
+		adev->clock.mclk.def = adev->clock.mclk.min = adev->clock.mclk.max =
 			le32_to_cpu(firmware_info->v31.bootup_mclk_in10khz);
 
-		adev->pm.current_sclk = adev->clock.default_sclk;
-		adev->pm.current_mclk = adev->clock.default_mclk;
+		adev->pm.current_sclk = adev->clock.sclk.def;
+		adev->pm.current_mclk = adev->clock.mclk.def;
 
 		ret = 0;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3fb02f5b91c9..03417e7e8961 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4422,6 +4422,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_device_check_iommu_direct_map(adev);
 
+	if (adev->pm.dpm_enabled) {
+		adev->clock.sclk.min = amdgpu_dpm_get_sclk(adev, true);
+		adev->clock.sclk.max = amdgpu_dpm_get_sclk(adev, false);
+		adev->clock.mclk.min = amdgpu_dpm_get_mclk(adev, true);
+		adev->clock.mclk.max = amdgpu_dpm_get_mclk(adev, false);
+	}
+
 	return 0;
 
 release_ras_con:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index dbb05d51682b..781851cf8dc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -827,19 +827,10 @@ static int amdgpu_info(struct drm_device *dev, void *data, struct drm_file *filp
 		dev_info->num_shader_arrays_per_engine = adev->gfx.config.max_sh_per_se;
 		/* return all clocks in KHz */
 		dev_info->gpu_counter_freq = amdgpu_asic_get_xclk(adev) * 10;
-		if (adev->pm.dpm_enabled) {
-			dev_info->max_engine_clock = amdgpu_dpm_get_sclk(adev, false) * 10;
-			dev_info->max_memory_clock = amdgpu_dpm_get_mclk(adev, false) * 10;
-			dev_info->min_engine_clock = amdgpu_dpm_get_sclk(adev, true) * 10;
-			dev_info->min_memory_clock = amdgpu_dpm_get_mclk(adev, true) * 10;
-		} else {
-			dev_info->max_engine_clock =
-				dev_info->min_engine_clock =
-					adev->clock.default_sclk * 10;
-			dev_info->max_memory_clock =
-				dev_info->min_memory_clock =
-					adev->clock.default_mclk * 10;
-		}
+		dev_info->min_engine_clock = adev->clock.sclk.min * 10;
+		dev_info->max_engine_clock = adev->clock.sclk.max * 10;
+		dev_info->min_memory_clock = adev->clock.mclk.min * 10;
+		dev_info->max_memory_clock = adev->clock.mclk.max * 10;
 		dev_info->enabled_rb_pipes_mask = adev->gfx.config.backend_enable_mask;
 		dev_info->num_rb_pipes = adev->gfx.config.max_backends_per_se *
 			adev->gfx.config.max_shader_engines;
@@ -1315,12 +1306,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	case AMDGPU_INFO_MAX_IBS:
 	case AMDGPU_INFO_GPUVM_FAULT:
 	case AMDGPU_INFO_GB_ADDR_CONFIG:
+	case AMDGPU_INFO_DEV_INFO:
 		need_runtime_pm = false;
 		break;
 
 	case AMDGPU_INFO_TIMESTAMP:
 	case AMDGPU_INFO_READ_MMR_REG:
-	case AMDGPU_INFO_DEV_INFO:
 	case AMDGPU_INFO_SENSOR:
 		need_runtime_pm = true;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 6bb42d04b247..75c262acb704 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -2996,10 +2996,10 @@ static int kv_dpm_sw_init(void *handle)
 	adev->pm.dpm.state = POWER_STATE_TYPE_BALANCED;
 	adev->pm.dpm.user_state = POWER_STATE_TYPE_BALANCED;
 	adev->pm.dpm.forced_level = AMD_DPM_FORCED_LEVEL_AUTO;
-	adev->pm.default_sclk = adev->clock.default_sclk;
-	adev->pm.default_mclk = adev->clock.default_mclk;
-	adev->pm.current_sclk = adev->clock.default_sclk;
-	adev->pm.current_mclk = adev->clock.default_mclk;
+	adev->pm.default_sclk = adev->clock.sclk.def;
+	adev->pm.default_mclk = adev->clock.mclk.def;
+	adev->pm.current_sclk = adev->clock.sclk.def;
+	adev->pm.current_mclk = adev->clock.mclk.def;
 	adev->pm.int_thermal_type = THERMAL_TYPE_NONE;
 
 	if (amdgpu_dpm == 0)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index a1baa13ab2c2..e72eb59af6a5 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7232,8 +7232,8 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
 	if (rps->class & ATOM_PPLIB_CLASSIFICATION_BOOT) {
 		u16 vddc, vddci, mvdd;
 		amdgpu_atombios_get_default_voltages(adev, &vddc, &vddci, &mvdd);
-		pl->mclk = adev->clock.default_mclk;
-		pl->sclk = adev->clock.default_sclk;
+		pl->mclk = adev->clock.mclk.def;
+		pl->sclk = adev->clock.sclk.def;
 		pl->vddc = vddc;
 		pl->vddci = vddci;
 		si_pi->mvdd_bootup_value = mvdd;
@@ -7733,10 +7733,10 @@ static int si_dpm_sw_init(void *handle)
 	adev->pm.dpm.state = POWER_STATE_TYPE_BALANCED;
 	adev->pm.dpm.user_state = POWER_STATE_TYPE_BALANCED;
 	adev->pm.dpm.forced_level = AMD_DPM_FORCED_LEVEL_AUTO;
-	adev->pm.default_sclk = adev->clock.default_sclk;
-	adev->pm.default_mclk = adev->clock.default_mclk;
-	adev->pm.current_sclk = adev->clock.default_sclk;
-	adev->pm.current_mclk = adev->clock.default_mclk;
+	adev->pm.default_sclk = adev->clock.sclk.def;
+	adev->pm.default_mclk = adev->clock.mclk.def;
+	adev->pm.current_sclk = adev->clock.sclk.def;
+	adev->pm.current_mclk = adev->clock.mclk.def;
 	adev->pm.int_thermal_type = THERMAL_TYPE_NONE;
 
 	if (amdgpu_dpm == 0)
-- 
2.40.1

