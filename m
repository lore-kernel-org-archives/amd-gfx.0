Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EACCCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 08:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF05C10E76E;
	Wed, 29 Oct 2025 08:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aifw6/zz";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D68310E767
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 08:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F573J7KSAGf9UOvzqFvXOHTkfhRun3Ji35VBUF/f9xqHuLtBGXPgJg+BV44zLi+8m/6fQiEv1zflExtIe0tXcVw0W7k7akbkobd/ljGXEsl/mPGU4ydo7OoBTa1eYp6gyLbKCD2jZm3lHiLtLyCOLq2wNtLtNtaNMCFgM8KZJUK9U/WYHkb9iUJ1wHaMfNAsQfb2H3wnMFyX5TRjvDvvgK/jV0Ny+oFws96ZZXO6CLsnC2l8C6LtC0oYfaDTZzzffmPZUnlQCE452DFx2MJJDunmnv4E+hyiiELdOI45Hr2JpFoNWbnWiatBfhurZ/Vc6y6WyDN5ulx1NCEa8OlM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iryaGPsZPSrF/sbeHPTp9IxqnHCnSjdcpP7afCmfAvs=;
 b=KMW82sW5VcF5fAsiBwp80vPiXzK3k7/PEZLIpYDhFICb0dXiDtdkMsxzBeOtJA3d1rBAF28YlWd8WyCgMNJcaI8KWJfI7AfK3NtVNte0c5RLyZdjeYGtvJPWFPBH2xp8Xf9+AZVhoZnKB5k+SMAuEaI0cqHA+kU/QCgsuZ9baWpFS+VnpfxZqitMvYm2rib0Zgo3QKr8zzbE9OlfkCL4hdTSLrDNBAV5CeCsmH8FXl8AQ56k3eOGoV4zZ0o2mXEli3RCk+3lwofaNqzAnxdRQBEcfCdOYIizFMkNI6M0fwgl8opG3IGq22uxQHHFyii2c1lS8pJEHYuzRXSOxVBxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iryaGPsZPSrF/sbeHPTp9IxqnHCnSjdcpP7afCmfAvs=;
 b=aifw6/zzmDFlgeO/qcbRT26NVDkTfOnlCtm3Udwbq9iD1Hn/IUwsdgg5ZR4005Pyu+G8eYcJPdu8EfotA2jw+I07sYriqwkaPPQCw8djp4s8V3o3S1SA38yxTN/9tE/T5qucBuANq/jNmv6cN/bumJSDLz/gUrzb/jDS0WqZwM8=
Received: from BN9PR03CA0733.namprd03.prod.outlook.com (2603:10b6:408:110::18)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:48:27 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::10) by BN9PR03CA0733.outlook.office365.com
 (2603:10b6:408:110::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 08:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:48:27 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 01:48:25 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 10/10] drm/amd/pm: check pmfw eeprom feature bit
Date: Wed, 29 Oct 2025 16:47:51 +0800
Message-ID: <20251029084751.1701305-10-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029084751.1701305-1-ganglxie@amd.com>
References: <20251029084751.1701305-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea2a7bb-fb34-4a32-ca30-08de16c7ed97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?99ASWAeTuMMR0Yq0I+QN1OnwuSZ5K4h2xLSL668EaPX6/IYHodVyZrqRkKmV?=
 =?us-ascii?Q?0W++Zf9z4v29TxMUTlCnkv/05jhbq7Smp+j66cBeaoKwfKvrXCzj1sjPAwA+?=
 =?us-ascii?Q?ebfR+YwqxrxaZypIxIZSEauOsSrxsVWja8fnDspz9d7t4RZXNqMoB8QxkuIm?=
 =?us-ascii?Q?gXq8lXlkosLa+ddvTjMcooqnix4UVRaBKHvGJWDQLA7F/wKsRjmoH9+nUwHX?=
 =?us-ascii?Q?UrVDlrkA74/ndVmTkgqIwfAapXZoTEBHJY51ZSoSWtKFe53LAxxPuQSKGkT+?=
 =?us-ascii?Q?fkS07yhc/EBNlPmXvm3xbeiOT5daH2qo4orzfjIHy/3zD0Ldf6+06XIWLkJL?=
 =?us-ascii?Q?FkvVOC+5JGjk7eXWCSpOPup5NdxeQrkdywz6+y6ekQQJ02Dl5E7fEYAefp50?=
 =?us-ascii?Q?rek1Q5Dnp3it0zGMUPUPo/rlloy7eT+SXOc2icz3ZafvQTr4PgcTxaomNO63?=
 =?us-ascii?Q?H/GnW0hCNHqiurB74oQlPcpJg2C2E5k7uiqOwDkBDw/0JzIo/w59WQuzfKO3?=
 =?us-ascii?Q?m1B+BsqqDLhQ/nq87TM4PZDZFa3jnUGbXh1UcdjeazhEGL2NQfXGW3aTwaC4?=
 =?us-ascii?Q?17D8/baNFemZmvj+9DuEa+BK1NcLv1L7hFiVd4R39PW5sbS51VzqyNVp6HUA?=
 =?us-ascii?Q?n94xKrIfXF/52fp2YLGtfS72ixPuJLxrh8SDykG+srK6LD7tL328ozvlDxZl?=
 =?us-ascii?Q?DMXxzxAb3f0FgvceYyMlRqRXpqHMwbxoVfOPe0/fFFXa/gr2hsZO8dbD8EDa?=
 =?us-ascii?Q?CsQhFLO0mIjx/UvILlklI/ZEJ8NNKw1l86FWonDXHUpMETskYKM1R1QYpK/D?=
 =?us-ascii?Q?gPKHZ07lHw8NJ4K+4QiyVIlYaF/rXZM6pNxO6nXtWrBjNtTGhGDolgjhg7WE?=
 =?us-ascii?Q?pBg/E5BzYoKH6aDIayNN6kbHeY1smA3BTG9cjxYQ3JcV1OZGKK7omT7cdJ4Q?=
 =?us-ascii?Q?3zCMhr+7ZOZ3C7prmUNsCZYu8000DK4/SceZ88Vk1nkyFd5TJCdgV4YdJYpz?=
 =?us-ascii?Q?Zvi2ozryfNBYlry0yGtjoP2QZqO4YIKwD7eJWb24YPpz8SygODfA7YaJcO1Y?=
 =?us-ascii?Q?VBiZaKW7HT97MmZR2jp3/NfGKBV0VKHfYrQWVK9mIN7u5klHoBVEpLsH1Vk5?=
 =?us-ascii?Q?pARiM0ORMrz7qlESZS0jeaCqp0Jge2+cr/aEhY4PGiV7Gty9BpFEuBB/L1GZ?=
 =?us-ascii?Q?wB+euPlV+qOYU/hfYpEvK1C5AZbZ/fkWGN/mRxFOBTzGx2SnMdtpXNogv6rL?=
 =?us-ascii?Q?3NgwAHLl7FqHSyRDYh83WurQrDE0acSP590rEJwldumwbL1axLP40Hc8jNA1?=
 =?us-ascii?Q?YBU5Ru2BSgvc96x9aJV7M+kcTbQR//A5GbEF1Wt3bcgutpoN0Onhw/7FoLXK?=
 =?us-ascii?Q?2Sc6T52MezPHuiC9yUCsy1+sAoWTGQ7Wcb3P61RQx+E1roSl2X5R/wLMGDKJ?=
 =?us-ascii?Q?5Sm3uulSPP0GA8/GDZwt/V1+cLo6dP0mizKr043aU4v+TjGhJi1/l4Hn7aMd?=
 =?us-ascii?Q?8c1JhCY2mzXuy8oenrXYcoQT23eD19aTpOBMXEG+tN55ZdQWIWlneNzTUTYJ?=
 =?us-ascii?Q?VNyXdTGhUWYAimePT3g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:48:27.3177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea2a7bb-fb34-4a32-ca30-08de16c7ed97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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

get and check the pmfw eeprom feature bit to
decide if pmfw eeprom is supported

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h   | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h               | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c      | 7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c       | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h       | 1 +
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
index bf6aa9620911..fa43d2e229a0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -87,7 +87,7 @@ typedef enum {
 /*37*/  FEATURE_DVO                         = 37,
 /*38*/  FEATURE_XVMINORPSM_CLKSTOP_DS       = 38,
 /*39*/  FEATURE_GLOBAL_DPM                  = 39,
-/*40*/  FEATURE_NODE_POWER_MANAGER          = 40,
+/*40*/  FEATURE_HROM_EN                     = 40,
 
 /*41*/  NUM_FEATURES                        = 41
 } FEATURE_LIST_e;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 9315ce49b396..3a3930ef7ed9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -465,7 +465,8 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(GFX_EDC_XVMIN),				\
        __SMU_DUMMY_MAP(GFX_DIDT_XVMIN),				\
        __SMU_DUMMY_MAP(FAN_ABNORMAL),				\
-       __SMU_DUMMY_MAP(PIT),
+       __SMU_DUMMY_MAP(PIT),				\
+       __SMU_DUMMY_MAP(HROM_EN),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(feature)	SMU_FEATURE_##feature##_BIT
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 14b46e110730..be6f0f196699 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -82,6 +82,7 @@ const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_COUNT] =
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MPIOCLK_BIT,			FEATURE_DS_MPIOCLK),
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MP0CLK_BIT,			FEATURE_DS_MP0CLK),
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_PIT_BIT,			FEATURE_PIT),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_HROM_EN_BIT,			FEATURE_HROM_EN),
 };
 
 const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] = {
@@ -1060,10 +1061,16 @@ static const struct ras_eeprom_smu_funcs smu_v13_0_12_eeprom_smu_funcs = {
 
 static void smu_v13_0_12_ras_smu_feature_flags(struct amdgpu_device *adev, uint64_t *flags)
 {
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
 	if (!flags)
 		return;
 
 	*flags = 0ULL;
+
+	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(RAS_EEPROM)))
+		*flags |= RAS_SMU_FEATURE_BIT__RAS_EEPROM;
+
 }
 
 const struct ras_smu_drv smu_v13_0_12_ras_smu_drv = {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 32d98a43ea3d..f52b825f1e3f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3891,6 +3891,9 @@ static int smu_v13_0_6_get_ras_smu_drv(struct smu_context *smu, const struct ras
 	if (amdgpu_sriov_vf(smu->adev))
 		return -EOPNOTSUPP;
 
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_HROM_EN_BIT))
+		smu_v13_0_6_cap_set(smu, SMU_CAP(RAS_EEPROM));
+
 	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
 	case IP_VERSION(13, 0, 12):
 		*ras_smu_drv = &smu_v13_0_12_ras_smu_drv;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 1506594b03dc..bf9d0b2285e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -72,6 +72,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(PLDM_VERSION),
 	SMU_CAP(TEMP_METRICS),
 	SMU_CAP(NPM_METRICS),
+	SMU_CAP(RAS_EEPROM),
 	SMU_CAP(ALL),
 };
 
-- 
2.34.1

