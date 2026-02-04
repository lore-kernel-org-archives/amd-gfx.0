Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CEFE8B395
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8265F10E56B;
	Wed,  4 Feb 2026 03:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KX5SK1SK";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9385F10E360
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmlzLpwk76cRyA/AoQu8BnlzHOKADneyCee3QmckjvJo1nVfhbOztpYYt2GkGl3PmhdD2ynVZor2+wlnpzEeeB58vnnDi06czMWyjfLb9fv0mpq+vhU4U55s3aCWCMpgrLhLVMluq/XFCGbHfU3al2VvKLfuk0AOyK91fcKXtXcWlMUVfLsEzeZqnD7MZ2Qncc7o3SQVvutdX/PgF+OLbteToShVhjohFMxpstkCyB3W64oxkd/gZF5X1d/PhdnSXmcB1Gi865p2Kuw2gfYoOesPBOQTiyoEYPxEdVYzMaMx/WMk8JeMjrCrueL/UJPBnz+m2qZ6bOibIadeZr9xeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW1opYZQIaRSK2pPK0woEXgVYIKnWZl4tjP38nhxmGM=;
 b=rWqcBHjOBq4VKHMicuztgPHr/shW6EBDOrUeLmEkqcliLqL9g63jAlPJrjqejenHqDUvEmRnUFjMJ/nkesl6iJzcp9RigG4DToRFG9MHqrMTWjQleTUZqKvtHhfMORgSsU40p5cNewGpbVttRE33cpv4dKD8T0UhZlaGIJhIvqsZpNP9FbJEhj85fvYimQcvmTyhofn+ixA+l9eXoumW85KjcWSwKiZcW2Sg1P6fqrcEQJxE9JEE9Y4EVYjoa5M/qgAO/CJ9Z/GtSsvg9J5ZnSKJ0vEGaj9bkF2DmynskpKupYcBTRWXsmcwFJQMdNxUOaohzoDDdEr7W8hTi/Nncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW1opYZQIaRSK2pPK0woEXgVYIKnWZl4tjP38nhxmGM=;
 b=KX5SK1SKJ1Oejwp6AfwYZsZQwMldhcGII/Z9WQJt8XKKwCl/pz39WjtkNlj0GSoLrFH8lvr6pyH8LzPlZ1FVDRP2RB3PuMTEljMHaS71R85d/yYJPTZJ0XCBx+OR1LCxSam6yTHk1xDDWTpNhpF+Izfv2yQcWJa3tFv+Gn1nW1E=
Received: from CH2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:610:4f::36)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 03:06:53 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::2e) by CH2PR18CA0026.outlook.office365.com
 (2603:10b6:610:4f::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 03:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:06:52 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:06:51 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 05/13] drm/amdgpu: Add support for update_table for SMU15
Date: Wed, 4 Feb 2026 03:06:12 +0000
Message-ID: <20260204030621.33369-5-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: ab070dfb-dbcf-4c8c-d063-08de639a7273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xHEneeig4DaF1oMPdi8c+wPWUp/+1Z3pXDKSE7UuKemFB6/FBI/fRA1MyXRs?=
 =?us-ascii?Q?Itvq2TdNVvrpljDFCySvNtBcpkRFGNG6UY0onigTdCRlBJqYwPlP45EmSwYm?=
 =?us-ascii?Q?UnT4tJBTPjF8L2CQCvcmj5Tv2LI/fc6YEWUpHF3zcNjnuK8+UOYcSFnd+MSw?=
 =?us-ascii?Q?RQVPUfRs6AXebF/OzBZBRJDTm+cNcCW0M6w0gV3TtY7I+M9ce6LWspkymhaR?=
 =?us-ascii?Q?9X+tYritxr9M1MYkrKuLKkjwP4iJeRTOd+p71X97A7yflSN/e/z4EAiOkGcQ?=
 =?us-ascii?Q?Mt/VbHexFJz5CCDsIJFkESj3DkzyJKYelbLXGQhrfPSoHtcz7TF2PM35Peuw?=
 =?us-ascii?Q?SaSqBHX9DDeNMRkr3WT4FYHufhwNM8bslWfYOVEUi3jglqMDOormh5mZbP8z?=
 =?us-ascii?Q?c682LJobb5Nf1Ry+nQgvc18g6CZ4QLwlU4hDnllWR2TLe2aAU0knEo+qGFHn?=
 =?us-ascii?Q?dLx2RUB1bvkfOSwIbJ3r7WODDm+3r4CJlwJ84XB/ZCeuepl1KLATtiCqo18H?=
 =?us-ascii?Q?CbB2zQKxJuH4TnAjE0fAAS8TVF+rcroy0LXss1Ps53ThgufUTzqXs/1Tu2ts?=
 =?us-ascii?Q?LfwqVY8lwnbH/AnwufdY8QMheKpaFae6Fy1zXkL/F4n0TYgFAjVYuL6fRQ7D?=
 =?us-ascii?Q?VQcDEjVdFuzG4aFBcpgY0amasekSUYpRoSmJwJS34T1vzGeQQXqQhD54GE8m?=
 =?us-ascii?Q?UgvZyEHUWbS8GtMEscQBVT6YL9lkfF90z/SGF+JC4pf5hAz0gkZfQfXRrmo3?=
 =?us-ascii?Q?hnMkBw9BeIdFqVSixepQTp9C886hYmu/ghw0DBK6UjrRcCYn6pqGmg8NZzMI?=
 =?us-ascii?Q?tpRU2n8vDNynWl6dJzrHEvZfec/Ss9Lw7J3Myvv5ym5kEOmRwGu9yeMAcUli?=
 =?us-ascii?Q?BVNfP3l7diiRG4y+ldeEBX5+3DJn2ey6yuKsq8qM4fNZmbo3OIsvWQxXDiXA?=
 =?us-ascii?Q?nbYRO12F8VjnXgcxQYQ2LUapIoGOczK8Sy9MBlZwkMiyLGSlhVOWtT2bQksx?=
 =?us-ascii?Q?jd19PhZnft8PLBc7Usoa3ZR2C9MkLG7w0zBfo2oVh3WAxgpYlM/FVX5LKaJh?=
 =?us-ascii?Q?XP3Fj3T0tGtSB0ELkq6oLycvstfIRfwntzJqRNFQtArmBbdsSidxaoLpd9vv?=
 =?us-ascii?Q?1Wv7ZR5ttptJvqkX0qYrpTdDQuPioFIZu6rdG0F9AGkFD5b1hV8Aef4t9bdA?=
 =?us-ascii?Q?KMcVzYk2bdnAgqsCxXiwbKosJ/4TPsBNg2zL63x6OxNo+LGsEH73mGYInrKG?=
 =?us-ascii?Q?5EDQFBWVnF4JxsmlRj1SwIz0V0UcWdPQTOBxaDLD0wqZWCI6aEMdT3Zn3rqu?=
 =?us-ascii?Q?Ppwff8VG47aausMB3du/iUkFmdzuKqa1MqhA3agGGsje/MTxlNEDDUnv7yxd?=
 =?us-ascii?Q?l+WFhkBXLFvAg8gVroSDBTcHFPY673U26sZllR5Xuuq+Jy1DQ3PxboRX1UJ6?=
 =?us-ascii?Q?GjlMLRvPB6+acN//bK5SHak1EpFQ2tmjGrl2WMpd4V4hItDGMnVtU0rFewsQ?=
 =?us-ascii?Q?5ZmmSJZVEd/FDpBNXBaQA7rn5+N5kxsvgDy8+bmiQhpxww4ntsVXncLKfkuv?=
 =?us-ascii?Q?F/ZJdu174rMOdOQ4eiytD6Sr/V83ULNFzoLJCOUkHUuvRn5I+xZMpwvFMSQB?=
 =?us-ascii?Q?Y5+qns7TD4fj2mxM4mRB13j5ZChNRw2cH9lPQ9GDufrnae5GHbRZYJG3gEmo?=
 =?us-ascii?Q?/Q87dg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hj6d1rGVsR79o6j1lWwpq0+xn7MYjHFjRQsAF/mZiQigX5O/yD6s+cuIhN3oVVIq880hARaplzOsZBR/jiibCiABrzjKLwyJb18jSLNZoAKnryIGOXC+mz4DPaK07oAZHdydu0gb58Uc/Bqxp3amSrSdg7Y5gufQvEj5JV53m/YPozcYMk8i+SgiEBq/K1zGOeZIVW4l1BN2DNKtKO18j7dRsXrihaiSM4STDqpDy/0kkLZxmCwyO+/HH4GO5qoEJPctClHbtsJs/0MZeodG04pAKFrtRZjaasJwgixx9ZZL1VopoW4UlIgBZYtjB2Fq9rvSJ9zinw66qmUTuhUGhW0XdvTRL35qtx/F4T3v96lQPaXupAP8PL74g0GB1gTNu3O/9wzmnnpnTi71OjFRL70OzElzfkcQ3Wl3NjycToeQzNZAy9fg9Cybu8/kRjBn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:06:52.8956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab070dfb-dbcf-4c8c-d063-08de639a7273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659
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

Add update_table for SMU 15_0_0

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  5 ++
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 58 +++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index 14e8d8c7a80a..af87c31ca9a4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -241,5 +241,10 @@ int smu_v15_0_enable_thermal_alert(struct smu_context *smu);
 
 int smu_v15_0_disable_thermal_alert(struct smu_context *smu);
 
+int smu_v15_0_0_update_table(struct smu_context *smu,
+			 enum smu_table_id table_index,
+			 int argument, void *table_data,
+			 bool drv2smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index a2854d528bab..8d05d589c45e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1726,6 +1726,64 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 	return ret;
 }
 
+int smu_v15_0_0_update_table(struct smu_context *smu,
+			 enum smu_table_id table_index,
+			 int argument,
+			 void *table_data,
+			 bool drv2smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_table *table = &smu_table->driver_table;
+	int table_id = smu_cmn_to_asic_specific_index(smu,
+						      CMN2ASIC_MAPPING_TABLE,
+						      table_index);
+	struct smu_table *memory_pool = &smu_table->memory_pool;
+	uint64_t address;
+	uint32_t table_size;
+	int ret = 0;
+	u32 param[SMU_MSG_MAX_ARGS] = {};
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
+		return -EINVAL;
+
+	table_size = smu_table->tables[table_index].size;
+
+	if (drv2smu) {
+		memcpy(table->cpu_addr, table_data, table_size);
+		/*
+		 * Flush hdp cache: to guard the content seen by
+		 * GPU is consitent with CPU.
+		 */
+		amdgpu_hdp_flush(adev, NULL);
+	}
+
+	if (memory_pool->size == 0 || memory_pool->cpu_addr == NULL)
+		return ret;
+
+	param[0] = table_id;
+	address = memory_pool->mc_address;
+	param[1] = (uint32_t)lower_32_bits(address);
+	param[2] = (uint32_t)upper_32_bits(address);
+
+	ret = smu_msg_send_async_locked_multi_param(ctl,
+				drv2smu ?
+				SMU_MSG_TransferTableDram2Smu :
+				SMU_MSG_TransferTableSmu2Dram,
+				param, 3, 0);
+
+	if (ret)
+		return ret;
+
+	if (!drv2smu) {
+		amdgpu_hdp_invalidate(adev, NULL);
+		memcpy(table_data, table->cpu_addr, table_size);
+	}
+
+	return 0;
+}
+
 int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-- 
2.43.0

