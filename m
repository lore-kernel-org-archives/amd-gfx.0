Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615A1C0219E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 23:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D70C910E3FA;
	Mon, 10 Feb 2025 23:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QgPhToO2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9BDD10E3FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 23:31:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiU1mJT7TeIWGq5pS9v7RIdqE0hrWMe5ulZkkKpJF2xj/rAvXGjnwVdCXzzfyyM9paVjMCwe4gWr1h71WOqRgWvUlelw02Lu9XH6vPn8DZTxH8Fn8VRNKSQFzkf0xo5C+xdSfO+aFPE27wA67YhWbiw5AHMa3A60S92UKRDPNVA/k0G3eV5BZ7JVVmooqQL4bv5pmrw2y2CoWGKgNUf7EuIoj4OUMHOOVXvvvHRRFQ945rak8NAGUhiJy/pHHrTdGmgDB1xJOY5HnhgPt0xBhvDDrvMWnOhGXE3QrYBlfVrsrCGjEN5Sr02F1HCt0Ps9TIJ8ctUFczEY6f1jrtROVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8cI564mUpjW617yOa71k6Qh1cbyD7s77VZvLBfzIKI=;
 b=kMtLwn8Pk9M6FWpFReGSMwGkhsJQW+88Q5kupMswrWmxyxslCEgjwGj8rfVQkjyMXwvE+bY7kHIlPHZmDHWgsKO4sGEEdN8Bj4bu9k7XUqInNzPbjBd8dkonDgi+JpbVX+RHAeaYoTPP04REwBt5OK8p5zWOL1NnFlV7B+ERIN1wM/hEdLIAi6zMqKOBedBA8lKG6eeMY5Z0yi6pBBX09Lcee043i79fVVWKo/Q/HUMVowXV/qv2yyFMjEJS8AniICSBPFaugGMompkGEjVXrDhygkknrNF+oFHCracdgDDLWCRd7h1HfY+9orRzsVCAoiPH1XpSGqhTckAyOcF6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8cI564mUpjW617yOa71k6Qh1cbyD7s77VZvLBfzIKI=;
 b=QgPhToO2XX4eK4IDQ2GL6Fz6bp6gw4OEiiO0tuNWmV9HkJ1Z6CD6F+V5DIvStOhrW3+HK4AC/qXe+luAJkbO5A/sF9enMFX40XIrFzvz6NTZVkPQ4JWYAmdC6DLlSZLvKfx7KZff6t12RHRR/bMCFo8Js7FAO33IQDVNc7HJA70=
Received: from BYAPR07CA0055.namprd07.prod.outlook.com (2603:10b6:a03:60::32)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 23:31:51 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::42) by BYAPR07CA0055.outlook.office365.com
 (2603:10b6:a03:60::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 23:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 23:31:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 17:31:49 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Boyuan Zhang
 <boyuan.zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/pm: store power state per instance
Date: Mon, 10 Feb 2025 18:31:32 -0500
Message-ID: <20250210233132.583035-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210233132.583035-1-alexander.deucher@amd.com>
References: <20250210233132.583035-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: e50dded1-d332-4c75-9a20-08dd4a2b1898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BEq34uiGhf1L4+ZUtKszkoTPyVIT0e3Gfx9Va3/WF0kO3HwVOyndwfDpqyZQ?=
 =?us-ascii?Q?ggnGmGzpeN1RoGJKkFtwgXLlfa7ylAk2dTs+BtExAAfNebHsLpSWivRE6Hk5?=
 =?us-ascii?Q?BoC9FTRyhoF6lasX/l3iwES1p6RCEXKxcobUyq5gO0LyFFSOxlpk6kjHu7bN?=
 =?us-ascii?Q?t2ixwGuaJKmaiuPNKHE7aPh3bKURw67BWGOAqeMpPLjbWr2gDFXEOgFdAi1z?=
 =?us-ascii?Q?nmDIKWS0nC8BKtcKCmNWIvLHQjdTEf3a29v3VNFc8fq0K/3SUjc/J3gpPQu2?=
 =?us-ascii?Q?qQg1O6fHkgU5Y4yfx9lYxnRyO0gAei+lM/WtD8lOCHhLRMH0xJ8W/Auclxje?=
 =?us-ascii?Q?WezdGTLsJj0oBIqoVxtin9fTqVz2V1+Mpl8oyoNcFuqKns/mS6s19zubdkr9?=
 =?us-ascii?Q?SxdGeeBecTjQHn6ZDV5uIvxHkVrW70m2XI3DLoNBPA44BGX+22jemXf/5ZSd?=
 =?us-ascii?Q?i5sfNdVXzsVjJzjIQ2EU5Uxc+kSMZel1VMMMRv/nHPYrUebMXrWWn2FvhnT8?=
 =?us-ascii?Q?zLVlcIa1H2+isYAO0mWG8w23+G5sbETdQKya6UjU2X4VYMPDCL0QIPH5okXR?=
 =?us-ascii?Q?lbKEvXiJp0xYQ04tVcpjvqTdtN+R46+VnbMwSZ9r3H5poaRiEvumhQXKaeGt?=
 =?us-ascii?Q?VJd4rh0tjUCi0vrsz32ezEybn5cWprPQOsOG2hWqLh6+sBwzgnYONThYktoN?=
 =?us-ascii?Q?M+wa2y9O/trRsQ+8d/px+riIcEIMDLaBSFvbVWS9Wne75SOr2oF9Xs3XXyCD?=
 =?us-ascii?Q?BHXWt8/CAwzWW4BalesWeWyL+en6VBtewmrJscqn5wPHAtIG6Rj0SczIOAe6?=
 =?us-ascii?Q?/31VMdA1dxDp+6kbm78G+2K+jJUSQWdQSes0VbsEhEjKwuBB/cozcS2FIl56?=
 =?us-ascii?Q?5S3KGd3GkUdqCSWNVpTpm1eF+w6HSpEMJEMzuHvaa7RK9ks2GMOKp52zXQ5Y?=
 =?us-ascii?Q?diJInOx5y3OMzsNN9i9zXxcrL0iLV6fyZL/skw5pFDc1kI/MUiul4OwtTCNM?=
 =?us-ascii?Q?81dzu/muQyC7PfQqrmxX0u2FYBOhXG492Ut5+n15VphdcppqlOVr7qc9MOWF?=
 =?us-ascii?Q?2DHm4Z3ZYrY9cpX9uNiUyTs10+Iz7iKUlPQul9JI6poZuWPRrECuw3p5Yuwu?=
 =?us-ascii?Q?P85TsvrGPQQic4+RF6jWFOerii5eZfsuAfopEqMGiahvynQO70Nl9rQzeLof?=
 =?us-ascii?Q?wj73utokpV700SNLjkCRqbeQK8CNvN/CssAFc9f2qkuTTHgxfgNfKQcObvhd?=
 =?us-ascii?Q?XxkraQWAah7D2+Tk0vTyat9jU4zudbCLMYRuyEf23Z4Gu/vHC2KhjGXScQdd?=
 =?us-ascii?Q?9uIl0F90myKzH3a7M/uJbA6pynM5qRW91lGN3cTL3tWHc+iPxnIaGVcyeVZ2?=
 =?us-ascii?Q?IvRI2mLgMupL2rPPgxaC5S87B1WuFBHAMVdKp9TbWeQ4QH6yVgcM5e/KErvh?=
 =?us-ascii?Q?fZxjTs5FmQtufyEbclgVgdj/wrLSRmEfEixWRyqDwB82i6488p0mpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 23:31:51.1619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50dded1-d332-4c75-9a20-08dd4a2b1898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
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

Simplify the driver logic.  We support multiple instances
now so reflect that in the driver state.

Fixes: ff69bba05f08 ("drm/amd/pm: add inst to dpm_set_powergating_by_smu")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 ++++++---
 drivers/gpu/drm/amd/include/amd_shared.h   |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 16 ++++++++++------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  2 +-
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 32926458d50ce..7325c21d60fc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4184,7 +4184,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 {
 	struct drm_device *ddev = adev_to_drm(adev);
 	struct pci_dev *pdev = adev->pdev;
-	int r, i;
+	int r, i, j;
 	bool px = false;
 	u32 max_MBps;
 	int tmp;
@@ -4338,8 +4338,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		adev->rmmio_size = pci_resource_len(adev->pdev, 2);
 	}
 
-	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
-		atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
+	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++) {
+		for (j = 0; j < AMD_IP_BLOCK_MAX_INST; j++) {
+			atomic_set(&adev->pm.pwr_state[i][j], POWER_STATE_UNKNOWN);
+		}
+	}
 
 	adev->rmmio = ioremap(adev->rmmio_base, adev->rmmio_size);
 	if (!adev->rmmio)
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 6dccee403a3d1..5dee173485c9f 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -112,6 +112,8 @@ enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_NUM,
 };
 
+#define AMD_IP_BLOCK_MAX_INST 8
+
 enum amd_clockgating_state {
 	AMD_CG_STATE_GATE = 0,
 	AMD_CG_STATE_UNGATE,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 7a22aef6e59c3..d2f1b27d22d4f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -78,12 +78,16 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
-	bool is_vcn = block_type == AMD_IP_BLOCK_TYPE_VCN;
 
-	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state &&
-			(!is_vcn || adev->vcn.num_vcn_inst == 1)) {
-		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
-				block_type, gate ? "gate" : "ungate");
+	if (inst >= AMD_IP_BLOCK_MAX_INST) {
+		dev_err(adev->dev, "IP block %d inst %d invalid!",
+			block_type, inst);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&adev->pm.pwr_state[block_type][inst]) == pwr_state) {
+		dev_dbg(adev->dev, "IP block %d inst %d already in the target %s state!",
+			block_type, inst, gate ? "gate" : "ungate");
 		return 0;
 	}
 
@@ -112,7 +116,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
 	}
 
 	if (!ret)
-		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
+		atomic_set(&adev->pm.pwr_state[block_type][inst], pwr_state);
 
 	mutex_unlock(&adev->pm.mutex);
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 1f5ac7e0230d2..cbb110f0cb898 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -370,7 +370,7 @@ struct amdgpu_pm {
 	struct i2c_adapter     *fru_eeprom_i2c_bus;
 	struct list_head	pm_attr_list;
 
-	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
+	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM][AMD_IP_BLOCK_MAX_INST];
 
 	/*
 	 * 0 = disabled (default), otherwise enable corresponding debug mode
-- 
2.48.1

