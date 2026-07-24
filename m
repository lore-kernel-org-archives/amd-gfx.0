Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9E2C531F9
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 13:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA2C10E55B;
	Fri, 24 Jul 2026 13:27:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TiMObvVh";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010008.outbound.protection.outlook.com
 [40.93.198.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DCF010E55B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 13:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6t3hvug/r9sosbo9d0UOhFa4+0uaQzfnzIv+D69O1kBf+W63NZ/EqpXbPX4FUH2+pAsS4HwnX+EEWdUofwAgpoQTD4zWPV6vJRsKYEJVbazKOTP3Wtkz2QyjEgmdgk4KZUYOsqVRY7G07iEPLoSKvVQHZBk/6ZGQRpZ89A7m0wCGCiT6QFNEW4udZ2HdA5kWbCM2nAsi7tY4JSsSTr3tTuXYBu2ph/2bHULea6K+YQjAa00swVQlcS6UsHKSts4d9qt5j3ejKwsy02d/kRQFSHUg9DlUfZbVCsjkEXCHllJy4c3rtF+2fbWv213w+HrCvku/k7YLcVNTqYmIpyZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SQsp8HZljSfwJr3ggO3nobCFdAecqiNOf7Ge2mxjkw=;
 b=nt8pA3GSSK69Pn9Gisi9EVL1iTCZtqHw8dWBmeRpoxfDxaFWhwuH8gvMgr00ipFj8cVVGzdR9wOrcB/Gvq3tPS5+PkiKMAFbDmjyaeRPgUQS/xJITau3lE6BgHSs917Vy/qkdWw1D/ATWVDTmgqf5NTQceYQud0V8X+p4f5EwSndFkN1GUtquMWUPMYJKQgbWVbOgXgDXMf1UDPF5NlfI7IzBa8ikpYzJwsFHhYnmoqKG1qawBCJ9J2GzrGdrdjIXl+eHbwuTrPr5k8NHP+iYeWV4nQ2C9WvKFGSXnEWrT89+iulmHjZr5uJnXow59rfAgpAWsWQh1X0WKY+dMWUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SQsp8HZljSfwJr3ggO3nobCFdAecqiNOf7Ge2mxjkw=;
 b=TiMObvVh88ValAIIgo1JSg1bXhIT8riLuAXugy+I1/BE2Dc1RLHeIDajwltZO2NM1XSsHBBrTan3OG3VD2GnEpdR/1DVB+Vl1lBHXoyxLUWVrUiKR2jpR5e5J0Yg0GcY+npvuQAjeSZ5vPqG15ZKw2ma3ZUeW5ilxDZX2OlfxiA=
Received: from CH2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:610:50::11)
 by CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 13:27:02 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::a6) by CH2PR16CA0001.outlook.office365.com
 (2603:10b6:610:50::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 13:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 13:27:01 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 08:26:59 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: restore UMD profile pstate after runtime resume
Date: Fri, 24 Jul 2026 21:26:44 +0800
Message-ID: <20260724132644.3006596-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH2PR12MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: adad9084-281a-4ff4-9fc8-08dee9873ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: oSTp13XoOVRw4tY/qrKrWC2n5vdMG8h2zQwAdWfXjZMGcylKpjFe+dQlTCOJVEwv9/7bQCb6CKnp829ejA6EsSEuvjcxqn8CIXGP68UbxtkUntE7i62Y/4G7d8EzPUnsg61yct+3psv8bp93wvG9jOeSJ0hbt/Rc6GHM3+cEskYXRSrJJpaVt37FXP6w5n281kCfbwCaQ7UvZPvJaPiBB2ExSMcm/TeWONaf1VjtdNdlgq3q4Nos4FWm2My1aweXu37N21XZ1TmNddgLErqUwYfk6tSN723r3ONZqXWqC5/S1P1lUMDM1EJUldtOgwKnRShAz4Pn0koD9JNp8vJrT+sjpnH8y/KxsgXBpiZlGSIGdXtctJNykVhpPz2k3TdzNvUQLGiMK6TAPk45ZwqbQunVZi/+fE5QL3qli96RY1zK84iz+Z4xls1AUU3LrN+IE+Ush4EReNxBAzAc3lj7DhyGFuFRR+r73XLVZOKqh90c5O+3OeD1n37DTz36T8KRETkPER7A1ZG9v2IPdkhDMyJ9EkA1FOd8xfj6A6mGLbJnt2Jpi5r2V/xjeuOpcJ7ScllLIwaHkfbnaGXUh6dndw8HfMO+ZCeIFmNn2xz1TP1ozSU6srRJNLw1RyKEvv1rmX10NTs3PetTMYWiLujIW2TZJE2r3kW2CORyOA5GEraVuWhUZz4SWuvoACPlXSndDR6JPPkgT4ru3jW7/VjbRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DBkFKb+tmda8+q4yqVJnj0Azt6VumvPbhb8A3dJQy/zEuF9s5CB92fx62i0bQVyFCEQrAQ79xK0jJX3tnJ2w3CiCM+qdh5AG2idOKJpdu4tAnKvpE1uaOXKQ6l+Uh9hmjuVg8jYLCQwZ7n/obKNT9OAkQf2qUWde7ubkGCMfkbdc761rgwYsnUfIKqV76dImPzk4AfIcTIo/4XgAU0IGF8e0JgtzIVPrGBuwCkDeEQ8sPElJ/kxPbT78sH1YTHBr6VtyBsJAvzQorQ01rxMtVQncqMl66fzcARiDTN1Lu2/NilIT0gpSROJBcn5NLEjgS9Jq/WpT1uV31YtXsGt3o6fp9t76PHDdb150DnqXaozCsXOGDsNM2DB2BrShR4upeerP5orQ8LXzWIrVozB3SU627XqL+VATRs8O9KhicCDUmK6xC4AH7wkicJr+TbKS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 13:27:01.6281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adad9084-281a-4ff4-9fc8-08dee9873ecf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541
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

Runtime suspend runs GFX hw_fini and clears perfmon clock gating while
the UMD profile DPM level remains set in software.  Re-apply stable
pstate after a successful runtime resume when a profile mode is active.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5362705143bc75..356e44d54d0024 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2920,6 +2920,19 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+static void amdgpu_restore_umd_profile_pstate_after_runpm(struct amdgpu_device *adev)
+{
+	enum amd_dpm_forced_level level;
+	uint32_t profile_mode_mask = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
+		AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
+		AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
+		AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
+
+	level = amdgpu_dpm_get_performance_level(adev);
+	if (level & profile_mode_mask)
+		amdgpu_asic_update_umd_stable_pstate(adev, true);
+}
+
 static int amdgpu_pmops_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -2964,6 +2977,8 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
+
+	amdgpu_restore_umd_profile_pstate_after_runpm(adev);
 	adev->in_runpm = false;
 	return 0;
 }
-- 
2.25.1

