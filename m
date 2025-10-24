Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDC4CCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 17:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F033F10EB23;
	Fri, 24 Oct 2025 17:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DJssi2KK";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012040.outbound.protection.outlook.com
 [40.93.195.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D3CC10EB25
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 17:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXi55WCXc6M3yS70T7PeUdY4ovc6KLyh2sPrj5hhaP1fOOxdsKZUi806huUCz+I1balPRW/xptPeDNamUWXxdcMW+gLS7rilzhIrHukv0IS6a4p4H2G66VRpcOFtE3mKJXGJMRTQOhw1DFTe2EeLuN7wJ8jq7NbXQE8SR6SLHMFdiZGEJ8wACnjtLmm3KLegY5sPwYRzHfklnSc/jehq2BDIkrLQcvQkP/HMGyu2cKBmyvpvIg0A7NlM6LszO8wo0ZIwTuoEBqjV5BrDvTMcrmvInjv+TtAY6NSnFpv/ljiXM5Jvjs09idpV4QL0TdqhCPkS0WV6NdiCHbLwcEiSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3G095JjeAq76UH7EkVV4QGOPzUsD7vf0rAmEpaw9plU=;
 b=pcGYKa7vM1hFe+Sr+dreO4hKsbJRV421oryuvgJsu0OIGaj7cIjvyUEi5L7DHMtZrhcnbxO/gZHeWiLiv3mpgr0hn0ydwL1BZ/I8AsRiHF7Oqbe/rIHbZ/SOvMUKU3I/k2N9t9R38obFZmxkpuswFiCuSqa2+oFrwqKv4fSB0fDnm/arKIZRGF517Z7DyWE0NhGB7rgSw3kH/OG3hEGM5YtAZxIhUx0zHd482j3uOrFXu7djZ00xtO/nXTdmeJi594Qm95fERqN2uLzdmOZ6eB97daqxv0GbZcUYjzHH4yYkEEcHL3kwRs4wkhyhsHS6XoVnYR0HridKk9k0DpyjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G095JjeAq76UH7EkVV4QGOPzUsD7vf0rAmEpaw9plU=;
 b=DJssi2KKQaj+6oFoYE0zi2HFZt6dd75NcJUuYgxeuCCuC5c6YNElGctkbNFsPHMjm1fkrExoPvxJqWwfhwbvwdYWvLovf2rQMehS58e9Kv2d+26rZia40rUwqcEWd/OL0kSpOVUtIzglRCm7ltfdZMKdPS6hAC3exhapQqRdENc=
Received: from PH7P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::13)
 by CH1PPFDA34A4201.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::625) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 17:08:29 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:33a:cafe::75) by PH7P222CA0030.outlook.office365.com
 (2603:10b6:510:33a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Fri,
 24 Oct 2025 17:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Fri, 24 Oct 2025 17:08:28 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Oct
 2025 10:08:28 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lkml@antheas.dev>, <bob.beckett@collabora.com>,
 <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: move PMFW rlc notifier to where it's required
Date: Fri, 24 Oct 2025 13:08:10 -0400
Message-ID: <20251024170811.57760-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|CH1PPFDA34A4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 166e4f89-c824-4184-6204-08de131ff3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n20E9BjOBrELX0bVXHFFIfD4dzvdRRuNZCbrdqoIfLZT296CMhBSCMsI+wba?=
 =?us-ascii?Q?9hNotpQzHawou99IyIgp7Y5ZLoXV+bkWwfWu6qtSmN/XDq7bnH4rbobAz3ru?=
 =?us-ascii?Q?3K8ZlDvLgQI14EuuyiyMzqO2ikC8SrqTaZtYuIZl1WpEspaAszjj08EbhceZ?=
 =?us-ascii?Q?Verk7oDa1DZrh3RIBmRS1lWhahsvHQPcZ/k4shyiYVuYDyRbjaF37KsqWpjR?=
 =?us-ascii?Q?Rk8YWeqlALo5yI+1UyMbKa5SINlhQ4XzcBy9JBWvH0hVccxgu3VdlzB/nVh/?=
 =?us-ascii?Q?FhKr4u25pOdrdJEwQwXeA581WLHHUyQ+F+IyKOpjwT21BYj652vqlH3whIzC?=
 =?us-ascii?Q?vyctAk/SSW8kLRoyB6oRnogSRgbNzkEUBj3IpDGVe0tYNX1mSpwahbwokEi9?=
 =?us-ascii?Q?1uGCj6DDJUhpyhFWBx4sbP2enzxZK4TG2eObTedW/JgB3hWPIyUW1XLxrbaK?=
 =?us-ascii?Q?evaXVVtVyXuajoIhiPPuMpG4iv8ARjTtWYRNd0lJ0bN6L+s2sJ0+FBLtPXdt?=
 =?us-ascii?Q?RcH2WLrD5kVIPUrjgrQlbSQdIY0f2Vh3+UIta/NVS1N9013zeibEmWAkfqMe?=
 =?us-ascii?Q?OEC1c2pMtQVz6c0huPfICc+rrrgh9/JBnr0kNFMCr5+OjG1T6MVOnZZUOKOS?=
 =?us-ascii?Q?czjeaKAramTCeX9hyW7kt03vWLzcXqC2SEsVA9nVXcZEHS/skkhoNhDcN8bO?=
 =?us-ascii?Q?bKGwfe8D8O2ubi3pkOuYfLdPywz5QnAEJdrGY1QplsdP0Pd7WMlgAPXYoCBO?=
 =?us-ascii?Q?akc7vFMnf35uDv9tHW4YXsLFsYaGLDHuKtHNt8RYLLAazR/XiL0gZFc5Brjf?=
 =?us-ascii?Q?Mwxu5/ag+AZ5gr9Dbk0+SDwv1deeR9SVgep/yiUoJmnKMvihwZ6suMf0JARi?=
 =?us-ascii?Q?uQvEtYhTWxgmathLN//Eg+H/sIjkp04bBeZKw6NzIKeXJKd7+/uiA6rsDuBt?=
 =?us-ascii?Q?Lh7tapUjdHLjAqmWPHp3Y7YX6jpVyGQhXu1Jr7llprXBVyyMKOuDwPrqowR4?=
 =?us-ascii?Q?AwN6PU5tDt6LotpmbgT94qdkh2AtEnrIxHOT331BvnZl7Vl2qLnICz65gTZ/?=
 =?us-ascii?Q?TnjYk/hT8JoLs0nEhT7Z9tojlzhyaD8HJ5ky+QX12pqwBpTM1Nc8A8MsFPI+?=
 =?us-ascii?Q?+HJYI9mlQCZJ0FKpl9QLY3l3jda4XdVy4CAI75qj8AkGVG3FK7tUK8laClSq?=
 =?us-ascii?Q?i55ICPHu37H1jn+UBXcvLsqm/1Sw6Oa2U6YFbrpIp9ttD3+OKooTzSv7R4Id?=
 =?us-ascii?Q?DE/0naKdtd7Za2p8mx/u5KAKhhVtPr1bK6cPmPb1ERJrF1V76Kjaqip+/Xhd?=
 =?us-ascii?Q?DzhIlKN+fwQZfMI0rmTTZIE+u0wfVtiltXO0fyQWeV3xpjYtn/0NToWxgaHV?=
 =?us-ascii?Q?DMIlfH7cM8n+qtKwQ2Gj5y3/EhBf+DWwG479MVncikqZAeT9P6lBGq45Tagy?=
 =?us-ascii?Q?XtHiYSbjuS3Ca5Dz8V5LdplfWd8r1BOWYKZ3Lm1zkon2ML2ae8BGGONWFjas?=
 =?us-ascii?Q?jZ067sNL717Gk7rT3uNcN3EyA+a68XZebJ3w?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:08:28.7745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 166e4f89-c824-4184-6204-08de131ff3d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA34A4201
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

For S3 on vangogh, PMFW needs to be notified before the
driver powers down RLC.  Move this notification to
the rlc stop function so it will always get called bfore
stopping the RLC. The call in amdgpu_device_suspend()
seems to be superfluous so remove that as well.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ----
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 12 +++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 10 ----------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5053c5f475ba9..78c0fc3a50ae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5283,10 +5283,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, false);
 
-	r = amdgpu_dpm_notify_rlc_state(adev, false);
-	if (r)
-		return r;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 39b8adf23a9fa..d64579f5fb1f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5470,8 +5470,18 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
 
 static void gfx_v10_0_rlc_stop(struct amdgpu_device *adev)
 {
-	u32 tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
+	u32 tmp;
+	int r;
+
+	/* Notify SMU RLC is going to be off, stop RLC and SMU interaction.
+	 * otherwise SMU will hang while interacting with RLC if RLC is halted
+	 * this is a WA for Vangogh asic which fix the SMU hang issue.
+	 */
+	r = amdgpu_dpm_notify_rlc_state(adev, false);
+	if (r)
+		dev_info(adev->dev, "failed to notify PMFW of RLC powerdown\n");
 
+	tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
 	tmp = REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
 	WREG32_SOC15(GC, 0, mmRLC_CNTL, tmp);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4317da6f7c389..10d42267085b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2072,16 +2072,6 @@ static int smu_disable_dpms(struct smu_context *smu)
 		}
 	}
 
-	/* Notify SMU RLC is going to be off, stop RLC and SMU interaction.
-	 * otherwise SMU will hang while interacting with RLC if RLC is halted
-	 * this is a WA for Vangogh asic which fix the SMU hang issue.
-	 */
-	ret = smu_notify_rlc_state(smu, false);
-	if (ret) {
-		dev_err(adev->dev, "Fail to notify rlc status!\n");
-		return ret;
-	}
-
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2) &&
 	    !((adev->flags & AMD_IS_APU) && adev->gfx.imu.funcs) &&
 	    !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)
-- 
2.51.0

