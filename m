Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EF1CA0FED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 04:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A20A10EB1B;
	Fri,  5 Sep 2025 04:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JpnoJNfQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B2610EB19
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 04:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EodG2EkMa2Sl3hxibNcVtFHSUJKM23mmHS1bto3PSvF2o1nkrLdZwX4TD/Tp/bR4LTmj3XjHTn9GDxJP9SYJyoxWVxPpTRl7pItvZBGSnGxrRejHwEAwZq73RaUPoUXSSjM61dBLciastlgoQO51/HZ2J72woa2/wfE2bBr8eVY5n6dm3MxfeEdM1vb2QRfuvM++z3J9pqr7NFXKq0iCCL5rIV3ieveh6e4KuDYX1Z98lUmAzgpNsjHNgMXpC9IgacqZ/jZD/A6nZLztmqqW7osoOBwhF/vYi6v45Zpks0GyCFYBJUmA7k9JHVslJ+m/PBIT0hQ/WNvzMbYgK0v6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqGe8oZU+kxibdUlgqULzQvMyQ/hireS6h2lOo2ooh0=;
 b=Ps207KEGe45SpWeMs5cLWghCxNXamamI/58jlBfPD9jamg70v5XCzcy/kNHgDv3UBwatxHB4/TemSXqMIIo/pff6abY1uZUcFXDjHm5HWlyKO233KmLh1y8CXwej1R/fm3e6iLzBeStOl0TiWj+5zrJQfA+vxhRipo+dD8tdLRfOKxPYje3KrxXaN086KhB23Sn2KUw2nArlxJWeW5iKLstmWZS0GDvhO8dKWHHRBEI3r+sa/NNmf0zEkiZlK9h759NMmX+kKWpXTHatUcbanjSsYepb9CJrOjeEKTuhuud1CH76XDOyPh6eoCTuL4zWIjD6bDL2WrEDUaQ+yw5u3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqGe8oZU+kxibdUlgqULzQvMyQ/hireS6h2lOo2ooh0=;
 b=JpnoJNfQ0jbxX3j/ZqwtzYoH/1yxzATkeK/84wJ8FnnrFBK3wH7cVZTheGbhTdTzPdVirod6ZpITCwtylRUuwohRkRekU9ugEKMPVChy1v7q11F0NUPN8xdZ+Mrn35BTmK56jDClL8vCV4eX45itU4efKEcWw8Kup5uctyIz3Hc=
Received: from BY5PR13CA0021.namprd13.prod.outlook.com (2603:10b6:a03:180::34)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 04:43:26 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::5d) by BY5PR13CA0021.outlook.office365.com
 (2603:10b6:a03:180::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.7 via Frontend Transport; Fri, 5
 Sep 2025 04:43:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 04:43:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 23:43:25 -0500
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 4 Sep
 2025 21:43:22 -0700
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Allow to set power cap in vf mode
Date: Fri, 5 Sep 2025 12:42:41 +0800
Message-ID: <20250905044301.1947978-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250905044301.1947978-1-asad.kamal@amd.com>
References: <20250905044301.1947978-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: b7798b1c-c178-40a5-4537-08ddec36c080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lcXXMPNgS5pNw/DWbuS5xh5CI2qYydErHzukUr8yRfaPtxDodGMiKMIw/KoM?=
 =?us-ascii?Q?k5HzQSfXf3/8thcHdIn0BEcS88RP4oe+RxufeHcrDHUj+Ridq3m50RM73467?=
 =?us-ascii?Q?K5C7dq6PB3MUoNBu+ViOs/uiN/0TXnzhluyxCIBGJ/AQB13gGaeiahnCrm5x?=
 =?us-ascii?Q?psrs4GLdp4wjtuf6MoOgkJX3ofDQbjgBWbqmlzPaFqxI30VuI1rxjEKvW47L?=
 =?us-ascii?Q?JNEg3i9ZDxrG/STX8rwsfcGAq1mbQYiU+DgGRJeOm2BxZ45R7zJrcyamOtHl?=
 =?us-ascii?Q?Ebn5QOigGXP8VpoDSXCRghpQiR2i3oXeos0jv7rBjQ9VpqtSJriXgWA26XhD?=
 =?us-ascii?Q?WIhoZ3kw1rfxCgV4JIoUbRNlCwiGSiJ2cekskjh2fGhw2fFXoJX+bS1UF/Yo?=
 =?us-ascii?Q?fLgPmpAyA0AbHVqwlL1eSB9fyPnGPZj3NvW4/j5qwU2XeE6yPviMcF+4b6lP?=
 =?us-ascii?Q?i7f7T/xgCMLx3c6aJ7eaFpaTkb2nlkwKrqChnJ+8pBdHyEtcyDXhg9hpiSkQ?=
 =?us-ascii?Q?vZtxDB2i02q2SJVDoZnsZ/R00UPE4MqWUJS0//at2SiTC10IPRGrv+eSNf7P?=
 =?us-ascii?Q?E3QlYYAMnMfa2zuw1Lnihj1vdSSBMANYtRLIqGpB1O53yKxVUzpU6rBYe7Ct?=
 =?us-ascii?Q?1AdKtVkem5vOXphlPxqL2hLjhkxjb1bSao1mwkCVt9Xx4NN09dQfSeObKfJ1?=
 =?us-ascii?Q?McghTBMAysxQ2N3TbxlzMjEpJKykga9WElfIRk64VQCjslRidVOxt56NbrF1?=
 =?us-ascii?Q?dsLfdIAvMqT0RJ4exZWKMMSf+cHFx4uAq0SkbkagPCkm2hZKIFgj8OVIkoFG?=
 =?us-ascii?Q?GG9NAmiNfiMn8Ss1LyCyFVOLWDGLVkwcl/fas1CGk/iAepQ39gamZD5SjqAn?=
 =?us-ascii?Q?or4YTuLE/tD0SXkm88UevBcihlCz6WlAEYlx6l0s7SQBrt2pSjMc9dV8nJyD?=
 =?us-ascii?Q?qOyRrckmnx3CsBffpr0JHw1GY/jGfygYjyrzHZOfNYcxrZK1YXQ+c3nr6ZkK?=
 =?us-ascii?Q?vQkQdo5uNueknaiWAx6O1qqRCJsGHlgntoq4kpEShbxq3C01im9pabZfhQD5?=
 =?us-ascii?Q?RjEwGThhWhTyjp0Cwkbk7y8CCF6xnp2ehJe1TMs4oyNq7Y89H7+RNRa1iQrR?=
 =?us-ascii?Q?faUbs5IsD7POT2o8BIXOVAdFUWCozoeF2Em2dqViGgTpdqIBt/DEcDOh5iS7?=
 =?us-ascii?Q?7X3D0Hw0ZkIguNqIggrjoB9FbjIpG6Lyqs3ml+pBO2q43vW7yfdUnszzRbff?=
 =?us-ascii?Q?ZKcpa3ss3GySGm8N5FCRK44pOfc0tAZP+MGvHusxmrx0A6R6PF18H9VoZyzI?=
 =?us-ascii?Q?AWSvzbHSony0xJgioAOUXELpCXAf5VfBzverHO9VrfVtf2/otRDO+KJanKX6?=
 =?us-ascii?Q?IOfqudC7/vZZBScQhDQ/MDTkijz06/RTBLEkTHoSquh/2LXgk+3xxvt7TsOr?=
 =?us-ascii?Q?F6+uGp8mets0/AXPeb4CBa/pKpyMWws9qmJq0zCOwgA61EmvRby0rgR+s3AK?=
 =?us-ascii?Q?Cn47XqPz+wGiFPQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 04:43:25.7536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7798b1c-c178-40a5-4537-08ddec36c080
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
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

Allow setting power cap for smu_v13_0_6 in 1vf mode

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                   | 7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 +++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5230276628a3..3c1346085c3a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3253,9 +3253,6 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 	int err;
 	u32 value;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
 	err = kstrtou32(buf, 10, &value);
 	if (err)
 		return err;
@@ -3597,6 +3594,10 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 			return 0;
 	}
 
+	if (attr == &sensor_dev_attr_power1_cap.dev_attr.attr &&
+	    amdgpu_virt_cap_is_rw(&adev->virt.virt_caps, AMDGPU_VIRT_CAP_POWER_LIMIT))
+		effective_mode |= S_IWUSR;
+
 	/* not implemented yet for APUs having < GC 9.3.0 (Renoir) */
 	if (((adev->family == AMDGPU_FAMILY_SI) ||
 	     ((adev->flags & AMD_IS_APU) && (gc_ver < IP_VERSION(9, 3, 0)))) &&
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index e37b7b5358ea..0acf574930d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -143,7 +143,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(GetMinDpmFreq,			     PPSMC_MSG_GetMinDpmFreq,			1),
 	MSG_MAP(GetMaxDpmFreq,			     PPSMC_MSG_GetMaxDpmFreq,			1),
 	MSG_MAP(GetDpmFreqByIndex,		     PPSMC_MSG_GetDpmFreqByIndex,		1),
-	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			0),
+	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			1),
 	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),
 	MSG_MAP(GfxDeviceDriverReset,		     PPSMC_MSG_GfxDriverReset,			SMU_MSG_RAS_PRI | SMU_MSG_NO_PRECHECK),
 	MSG_MAP(DramLogSetDramAddrHigh,		     PPSMC_MSG_DramLogSetDramAddrHigh,		0),
@@ -413,6 +413,10 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
 
 		if (amdgpu_sriov_vf(adev)) {
+			if (fw_ver >= 0x00558200)
+				amdgpu_virt_attr_set(&adev->virt.virt_caps,
+						     AMDGPU_VIRT_CAP_POWER_LIMIT,
+						     AMDGPU_CAP_ATTR_RW);
 			if ((pgm == 0 && fw_ver >= 0x00558000) ||
 			    (pgm == 7 && fw_ver >= 0x7551000)) {
 				smu_v13_0_6_cap_set(smu,
-- 
2.46.0

