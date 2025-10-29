Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D12CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 08:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B10F710E762;
	Wed, 29 Oct 2025 08:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eKuexZ0b";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF64A10E75D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 08:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcYbBzUGAnJhB6S7bcjTFk6i89vArz98C7Uvs7UOxZKxizpbaY2R8UCAFUQpEqBTGilsGcf3h37yhaJdiRJDcuoV3zO2Tfdl6j2YU0bNPwu7NkuRyPb/zz5QSq0xoF9KmC+T28zuXnv42WxMxtK7yXltzD4uuic9H9GBMWMN7SZgESUupPWfsb6CcDMj53guet14cLAXxxyvDLvwNIyX518F1E9CCjMXaX463vOpc/Ukfehn5p0NMAtJ6JYfm/QpcvbWDS+OvHtaRUK+kwCotvzOWBDD+rMyaoKU33G3t573m1XFCgoL+ttDH0MLhTuJupBwJes/tUnGgR5bLVLn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DolKB3sYqgGxbAwFo1Q0L9DyJegei97S1g1oCyVmro=;
 b=dOPy4FoMm/Hibfziw4sgek0Etr4ax2Fi/MZK81Ir9BR7JnkhSnGSbrVyf1dBFEp4Ubv490VUz3zpe17NllEjdzqolnFyBQMCf9wePWgohJed/IljPqaciE+n9gSZ+Xx2JoF/kA4PBjmJo6UTF4RdV7q9mqLvOJgJUxi5dN+byrluTSxy0ht6QUoSMSuLTICLHDNEZPYQ5j4sO4CNon+QdzY6rX58zdre3uZMC9NcXVBAcNmdKgTAPvFYYLZGQ+0g5U5d4EHGMai3JLvV8fVJ2QJhmwoYCOw6FYDVU3vkGyINPRy9EuLvei5lYACthAG4RlfU9Sapy4TrtaNIceZqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DolKB3sYqgGxbAwFo1Q0L9DyJegei97S1g1oCyVmro=;
 b=eKuexZ0bWxPMGR3E6JRikmy2lh881qpzv5w+Cftsq5TIc/ae/xMC5LOnXtzHRE22Pmyl9FTurnYFFyocn7uLmNs6qaTBOhK/5ro9R7HsQsUGhBhg5YfUfzfz2yWWNJvgJxIioFQGOBUQwnfX+q3/72SHIVlqy1vUaJzQZOzwiuI=
Received: from BN9PR03CA0670.namprd03.prod.outlook.com (2603:10b6:408:10e::15)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:48:15 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::ea) by BN9PR03CA0670.outlook.office365.com
 (2603:10b6:408:10e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:48:14 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 01:48:11 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH 03/10] drm/amd/pm: implement ras_smu_drv interface for smu
 v13.0.12
Date: Wed, 29 Oct 2025 16:47:44 +0800
Message-ID: <20251029084751.1701305-3-ganglxie@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 057fea72-8195-497e-1fef-08de16c7e63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CYg9ghbLCqQUFoxW0CWwB4dHBxYoF0FT38HjnMfFDjEVAW9dQ4hzHHqRMEGx?=
 =?us-ascii?Q?sLpAm2LT03w6Tv2sWwa7ygvTQVEgyC5mBrTKiQh5ZqrKbsHI3zGitToM5KFE?=
 =?us-ascii?Q?G+1XL2QkjHWkdIk9fbcNZyLTHszHPS2ariPpNIrb+M91MsnPhBGcabXOde9f?=
 =?us-ascii?Q?T1MVkJg3xZcoro1+W04A6t3pjW0z72O8ap07cuI0up/yKWol0crMAwNkkZZ/?=
 =?us-ascii?Q?BZxb8bPs/F7HPh4LUgu2TGSqmN7Q2wJ9d3nybobNrhFWV9Wt2pUv1tKtVW/3?=
 =?us-ascii?Q?sViT1MDkXR5afJ/r1GcAQVGt4t7KTT6C8Skk8CBbaO/TwYg/MUczB04ABeEE?=
 =?us-ascii?Q?TPIts6aj3VbNXqm0AtMF+MMGRV3/Szz2fV16kcaea8sao4mptAoTv8zYsIQX?=
 =?us-ascii?Q?R9vVGo6AfTp+bgwDe/6IDzbsGYpDGs1jZ+IJo2BY/c8ooysoGWHHYqPvSp7Q?=
 =?us-ascii?Q?NbRwHwaLjaLg2/4Sg/Y692raX5JGgjfmyX/3T/a5/HjLXA3CbPcRPrv8dF0m?=
 =?us-ascii?Q?4Xu68k6Q5tt1pnNhE8VZgmWstgWuvmnhU9eQP425t9/SE4oKZ4oXhFNTm4ac?=
 =?us-ascii?Q?OF5m3qb4T6HoTs9G06fsEJfqFGZ1tdqAlir/9oFi8ZgKbp9jYxix8bvUKIpU?=
 =?us-ascii?Q?9NL6AEDynWNtAhpsWU5NysxUgQzTD7zHkreljOGDq/OphbtzbqxtkHyyF/Sj?=
 =?us-ascii?Q?O0ZpGikCYT5/VpYrQmmaHTFK1qzVLQEPqUclQUk8suEHx9RWfStLTS27bwZq?=
 =?us-ascii?Q?rMCkpMZY2sb7UEQKaG6fPGIv/BzG/0oTdHXkX+ELmqLFZZxqd83SDvEwHnjm?=
 =?us-ascii?Q?VyWfbVHm+pjvzTjkFKR5WvtvyWFk96E8eRx3uS/VPXM52+F8eniWhystTzII?=
 =?us-ascii?Q?AEuVAtdqxdTpCXRL454vft5DS/Nom4uS9j0M59/gTRwbwDWApKivEGQx+rNN?=
 =?us-ascii?Q?QwXkIiAyb/MzyOMw2gdpilZKK3ow1TXOlrepAW4ww5yadaVTI9EkWs60VZ9q?=
 =?us-ascii?Q?LsPt5SbumVJl03v+15hZFNb0Ef6Wg01X9QDnRhSJ+YmN74Uz4kX6dqZQyeAB?=
 =?us-ascii?Q?tCNsV92ENEBRu3CZjfJpAR2VtR6rabHvpOPLrGhp91zAZdbHEuTXwTn7LTyN?=
 =?us-ascii?Q?1VzuWz3hfVWhRr9JQkHG9bNQPja6YklirhtDXJmkw9JnM2mawARL+EPrwABA?=
 =?us-ascii?Q?lGb7wHf67RCgg/wZDXAdyi7/bA6CWSI84mISL5cqJLlMKLE04mNGwHLyCiKh?=
 =?us-ascii?Q?+AlTkLS472G85gNAOktBdeeQONzwF/e5pdh9G6cvVJZah2yN4uI5oLZDpcu3?=
 =?us-ascii?Q?gFORAcreC7pjzw39+XrybqjS3Ku1YAJjv9BBSQ9evKZvvmN0r4ewjdVwg+eU?=
 =?us-ascii?Q?uEq7l9s5h9vrv1yw1nD/nxD9lALDhKfgqxHAf78TWmeEhrdeXrSDPmt3M5Om?=
 =?us-ascii?Q?SotnMC0idvkeNFcHyIRzncl77FvdjNVIYLP3faIIw4QmuDdCupDrpLhDqonQ?=
 =?us-ascii?Q?DnNmK88geXJ5FaMe1ZxpDoGNWTM9C/bExBjpmUph9Oqwhqna4MAzcciecHNx?=
 =?us-ascii?Q?cQIH5M4uTKwzz3yTkeU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:48:14.9904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 057fea72-8195-497e-1fef-08de16c7e63e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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

implement ras_smu_drv interface for smu v13.0.12

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  26 ++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 129 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |   1 +
 3 files changed, 156 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 556cf4d7b5ef..076e2280d375 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -503,6 +503,32 @@ struct ras_critical_region {
 	uint64_t size;
 };
 
+struct ras_eeprom_table_version {
+	uint32_t minor    : 16;
+	uint32_t major    : 16;
+};
+
+struct ras_eeprom_smu_funcs {
+	int (*get_ras_table_version)(struct amdgpu_device *adev,
+							uint32_t *table_version);
+	int (*get_badpage_count)(struct amdgpu_device *adev, uint32_t *count, uint32_t timeout);
+	int (*get_badpage_mca_addr)(struct amdgpu_device *adev, uint16_t index, uint64_t *mca_addr);
+	int (*set_timestamp)(struct amdgpu_device *adev, uint64_t timestamp);
+	int (*get_timestamp)(struct amdgpu_device *adev,
+							uint16_t index, uint64_t *timestamp);
+	int (*get_badpage_ipid)(struct amdgpu_device *adev, uint16_t index, uint64_t *ipid);
+	int (*erase_ras_table)(struct amdgpu_device *adev, uint32_t *result);
+};
+
+enum ras_smu_feature_flags {
+	RAS_SMU_FEATURE_BIT__RAS_EEPROM = BIT_ULL(0),
+};
+
+struct ras_smu_drv {
+	const struct ras_eeprom_smu_funcs *smu_eeprom_funcs;
+	void (*ras_smu_feature_flags)(struct amdgpu_device *adev, uint64_t *flags);
+};
+
 struct amdgpu_ras {
 	void *ras_mgr;
 	/* ras infrastructure */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 27b950c126ab..14b46e110730 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -34,6 +34,7 @@
 #include "amdgpu_fru_eeprom.h"
 #include <linux/pci.h>
 #include "smu_cmn.h"
+#include "amdgpu_ras.h"
 
 #undef MP1_Public
 #undef smnMP1_FIRMWARE_FLAGS
@@ -941,3 +942,131 @@ const struct smu_temp_funcs smu_v13_0_12_temp_funcs = {
 	.temp_metrics_is_supported = smu_v13_0_12_is_temp_metrics_supported,
 	.get_temp_metrics = smu_v13_0_12_get_temp_metrics,
 };
+
+static int smu_v13_0_12_get_ras_table_version(struct amdgpu_device *adev,
+					      uint32_t *table_version)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetRASTableVersion, 0, table_version);
+}
+
+static int smu_v13_0_12_get_badpage_count(struct amdgpu_device *adev, uint32_t *count,
+					  uint32_t timeout)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint64_t end, now;
+	int ret = 0;
+
+	now = (uint64_t)ktime_to_ms(ktime_get());
+	end = now + timeout;
+	do {
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageCount, 0, count);
+		/* eeprom is not ready */
+		if (ret != -EREMOTEIO)
+			return ret;
+		mdelay(10);
+		now = (uint64_t)ktime_to_ms(ktime_get());
+	} while (now < end);
+
+	return ret;
+}
+
+static int smu_v13_0_12_set_timestamp(struct amdgpu_device *adev, uint64_t timestamp)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_SetTimestamp, (uint32_t)timestamp, 0);
+}
+
+static int smu_v13_0_12_get_timestamp(struct amdgpu_device *adev,
+				      uint16_t index, uint64_t *timestamp)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t temp;
+	int ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetTimestamp, index, &temp);
+	if (!ret)
+		*timestamp = temp;
+
+	return ret;
+}
+
+static int smu_v13_0_12_get_badpage_ipid(struct amdgpu_device *adev,
+					 uint16_t index, uint64_t *ipid)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t temp_arg, temp_ipid_lo, temp_ipid_high;
+	int ret;
+
+	temp_arg = index | (1 << 16);
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_lo);
+	if (ret)
+		return ret;
+
+	temp_arg = index | (2 << 16);
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_high);
+	if (!ret)
+		*ipid = (uint64_t)temp_ipid_high << 32 | temp_ipid_lo;
+	return ret;
+}
+
+static int smu_v13_0_12_erase_ras_table(struct amdgpu_device *adev,
+					uint32_t *result)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_EraseRasTable, 0, result);
+}
+
+static int smu_v13_0_12_get_badpage_mca_addr(struct amdgpu_device *adev,
+					     uint16_t index, uint64_t *mca_addr)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t temp_arg, temp_addr_lo, temp_addr_high;
+	int ret;
+
+	temp_arg = index | (1 << 16);
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_lo);
+	if (ret)
+		return ret;
+
+	temp_arg = index | (2 << 16);
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_high);
+	if (!ret)
+		*mca_addr = (uint64_t)temp_addr_high << 32 | temp_addr_lo;
+	return ret;
+}
+
+static const struct ras_eeprom_smu_funcs smu_v13_0_12_eeprom_smu_funcs = {
+	.get_ras_table_version = smu_v13_0_12_get_ras_table_version,
+	.get_badpage_count = smu_v13_0_12_get_badpage_count,
+	.get_badpage_mca_addr = smu_v13_0_12_get_badpage_mca_addr,
+	.set_timestamp = smu_v13_0_12_set_timestamp,
+	.get_timestamp = smu_v13_0_12_get_timestamp,
+	.get_badpage_ipid = smu_v13_0_12_get_badpage_ipid,
+	.erase_ras_table = smu_v13_0_12_erase_ras_table,
+};
+
+static void smu_v13_0_12_ras_smu_feature_flags(struct amdgpu_device *adev, uint64_t *flags)
+{
+	if (!flags)
+		return;
+
+	*flags = 0ULL;
+}
+
+const struct ras_smu_drv smu_v13_0_12_ras_smu_drv = {
+	.smu_eeprom_funcs = &smu_v13_0_12_eeprom_smu_funcs,
+	.ras_smu_feature_flags = smu_v13_0_12_ras_smu_feature_flags,
+};
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 7ef5f3e66c27..1506594b03dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -99,4 +99,5 @@ int smu_v13_0_12_get_npm_data(struct smu_context *smu,
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
+extern const struct ras_smu_drv smu_v13_0_12_ras_smu_drv;
 #endif
-- 
2.34.1

