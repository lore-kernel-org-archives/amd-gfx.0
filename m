Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49156E8B39B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 04:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39D210E254;
	Wed,  4 Feb 2026 04:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xEKjq59s";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C4110E14B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 04:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i64SAvrcEi3aF3of5lFvwauhP2wcYiwYfcVWqlydjh1SxqqW/Jp8p6i3JWx0JK0nb8GeAZC6FYtW3G3jL59MQgYgnyoCErSu6NWGfojJEhardMtUjh0gvtUaMw9QX8nFbnJxJWMmSowmCp08hhqWHBvV5t25+ENVrr1p50XlZofYZ2xTLllLmjCq7gh7pXkTbv08obN8mpoTdEnPsVcA0dS4kJKlMB188fc6RA5TSPc1I2Bg4sLkmWrTu1et2GDGTRLmFwh+It4XzentzkZU8i2N9vWIYUPXlv9HgQhnAfpzQC+OqTkyiwIcdP1imxGU51advNQTvh4NXLWs81IYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPog3nzgHllTqdbr3yD8yI2zh4sElCTvqk45eO0vTcY=;
 b=N0IiL0n9+Dbj5yaOgs31N9CYXDSloJamIUZuFznW/jMf0MJV/DBuiJ06OGVbhxgR52IfvNlxQnkND1WTEt4TW0jD/+FqT7xQxDIxy+ADwBMygZM02gD2K43jS+Aj8143dHw0//fajFE0HpieGj/i6LE76xQX4fQwq6ZV7dV5Q9LtGCBVyZOhdWb0iSVsjen5joryERfVq84er7uE481kxEOQptUha7e0sLlpAbCOW5CQ3rYEciJ2lImL6mfVD+sCWJYKklGZK0rvdAxNJx57iRJJJtq4cpE7KWN3l8yCB8q5jdPx4Gu108lg+yszY9QxqYRv4LkHX62mGX16aoj1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPog3nzgHllTqdbr3yD8yI2zh4sElCTvqk45eO0vTcY=;
 b=xEKjq59sK1vZoSWUy0WItWGxnKYALxyjyjizFdtRkKxn+p+qvZIbeY2V64D3L9A/rZvdd39WydX2xVZP29q8WkDDkjnWqvVJLBgKhCiGTCrIjztmsaEJz4biFpTdTwuWu98dJ4Rl8kAmLXfjkv+R9jjOpW99bptOhijDOKWdPvk=
Received: from BN9PR03CA0407.namprd03.prod.outlook.com (2603:10b6:408:111::22)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 04:44:00 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::1) by BN9PR03CA0407.outlook.office365.com
 (2603:10b6:408:111::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 04:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 4 Feb 2026 04:44:00 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:43:58 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v2 03/11] drm/amdgpu: Add support for update_table for SMU15
Date: Wed, 4 Feb 2026 04:43:30 +0000
Message-ID: <20260204044338.96093-3-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: 6879cacc-57c5-4cd5-3186-08de63a803b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aF+g4BmhfnInL02AzzM1uma42A/XTU2QjWZjA6C2bBAgVmZio9hREO+PZUma?=
 =?us-ascii?Q?bq07sH3mPNyNiqPVZzUT9eZzmpe93TuXwsXG0qwoGGMY8dyA0DYlr6f9A0Fk?=
 =?us-ascii?Q?nE0OXxmxYXJNwkUU8ndfA/2e4Kh1sSiBP2BktNaod0SYmHNmRTtl76zMNH4J?=
 =?us-ascii?Q?bUzzHO8l9l0Ncx7yLtBLVuGj0hWSliX5abllZH7BV1MNO0bzicAinAavS4er?=
 =?us-ascii?Q?W/zqrInyenFa8O533gBed4u+oHEPUHBcu5TCap4bS0S615Io+ja/PJ/ky28a?=
 =?us-ascii?Q?eBTvSGplOWI7Ov6iWacy4CS6cUSxWZTZVvedKAOUHivaEbXaivq8bBQf2eam?=
 =?us-ascii?Q?kCitV7XuD8YCe/6ZH2UGFeGXmE0JeE/unslJ40xH+Vx7heoFifaWl6LGihdr?=
 =?us-ascii?Q?TGuHxaDYZdEvj71W058YtfrlyLE/gbjh19hH1eZ0w2rcOR4qsRCMpHY7qOGM?=
 =?us-ascii?Q?1weAlh88N8JX+kBGVvffevNB9IALB0nHepXIA3hiejMMZgUT49fXazkSf670?=
 =?us-ascii?Q?WfrnnXM55EzS9ZEDrcx9Yt/31bkbtoGQtUZBikNe7JXFrZrllC3BFPu05D7h?=
 =?us-ascii?Q?4gh3LLktEmp97vdAJGnnPRsI5vx3Se0H2sbvEy1B8ydgWvt9IIXwILXRebMu?=
 =?us-ascii?Q?mzn/EWwUZrkUuSi4Qdn2V/hBkFbDzKY1bN3qEQHV7iL9txwDGqgcmq716Vcz?=
 =?us-ascii?Q?O9/5wvez9Eme9K4zyPOXqRtDXjLDoG6GRXGfmI83+ct1RpOZL3HfCzD0sWnC?=
 =?us-ascii?Q?89bNOd/LN7Qu9UqYBxtkY3OC/mzmPfwlSGsxMRCcAT8/rS/Rj4cJ7eoFoAA9?=
 =?us-ascii?Q?o5pmuwCmXfsVbzjelOv8eJw3jUJINln8F/F8QbbY5zNCTZUaoK7iwcyMCNck?=
 =?us-ascii?Q?apYxXH1MJo7+IIflYilHcG5g2G7lEHOQLcxfbdKQQ3YOXgXhcIAuynSLd+Oa?=
 =?us-ascii?Q?2TZ6scP7Grn2UCsh9ujTpUFDt1845WsikTePz4At/15NhYY5AI6GpcmwfmLy?=
 =?us-ascii?Q?BEj7bEQM56h+hT4qYcsdxNYg8LUryEdeBSO2VkyhBpkaIWda1tRQro8tHVkH?=
 =?us-ascii?Q?Zjpfxvia5+FCGIdotHTxpP+f9S+CEw3DfT3jjdyEa1oRvXmGWki3iBeQ6g4N?=
 =?us-ascii?Q?VBWrSS2bEceWE+yZ8KroVg8/2OYJ9sZrEJe3Z8GSg+rPSb2KddR9NL0eYTBI?=
 =?us-ascii?Q?pCZu+sCt+x9jvd6mJ25M6HeO/RqhlHU4ld71z1jzsBM6dV+mkw4A9CcJhaEq?=
 =?us-ascii?Q?c2soMGrmejh+gZ14Wa7SwGs/P7kEW6iUC0xZXEHQV+TI+jDMSJ8bUH8OiEsT?=
 =?us-ascii?Q?QGD9lwd4EivXVKriLj/Cny2lwYtWB+YOaW1O8hioLSmS17cSVKmrn3wAK9bz?=
 =?us-ascii?Q?XfRrlgLFN2pPpJSc2xdc3+tGIpB81KyNTEX1K8BkBBfHblVS3JKhtMlZxgpN?=
 =?us-ascii?Q?cKLYkbpntErO/rNIJ4zfgWK3NG2NbhjxOJOrqH0xTfDTq7s4W4WvdPj0xLlN?=
 =?us-ascii?Q?K/S8QioxH5enRWCvrSaTbb8zZsyl2czlBMgTGYQwQlXDsFw4q9hjbOFA/y3o?=
 =?us-ascii?Q?Ou7DIKg5VosnPdmwsQyJISeCrFzI8WQUg4vNKiXvMD1ngdlt/09XS5qtKCR1?=
 =?us-ascii?Q?wjKn3z31Qwnd8bUdBEyAkmVTJpOP1UE3b5gYSyXb4vXcdIJrmuTih9NSc50U?=
 =?us-ascii?Q?n+uqsg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RNpKauuCs78gGYN/Fzupa6r19eed0y08yWuZZQ/yd3jl68Jdsqz1/dKVMpqnrWkBv6ZsaLv7EwuisGytsk/lXLC0n1WbOftZ5BY4kQARxgFOTgU+qOeL5X+//V9GhNqF32fb7qP/zuySXlcuceT1rCxvdGpPGiuv6YAYybz9jwQoPCtqXq0voMnr4CWRdznSjIL0vd+uBrmo0Ve+gXI0oDR7Jhj8hvY6qG7VSKuhnB48akG2zELMFIPXZoZkHWNO+GCvMqTuvtK8V8mC4bADZ40rXPRoAo7Ay/C4Gnyu8lC6GjtuWoUWs2TrhMYWJJQ1bgPmZMNCu6V02P8DqGOaTLQ6iV37IwS58VUWVYRHGRqLXwyJrrKXJZAZygTm5BTQhbqcWevbiu0GDMsI2cycWv98s5iRWK7T1IH/rgHFLpriZj28hOh+0O9PXMOMGw4n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:44:00.0835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6879cacc-57c5-4cd5-3186-08de63a803b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
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
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 68 +++++++++++++++++++
 2 files changed, 73 insertions(+)

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
index a2854d528bab..d3dc7583ce4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1726,6 +1726,74 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
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
+	struct smu_msg_args args = {
+		.msg = drv2smu ?
+				SMU_MSG_TransferTableDram2Smu :
+				SMU_MSG_TransferTableSmu2Dram,
+		.num_args = 3,
+		.num_out_args = 0,
+		.flags = SMU_MSG_FLAG_ASYNC | SMU_MSG_FLAG_LOCK_HELD,
+		.timeout = 0,
+	};
+
+	args.args[0] = table_id;
+	args.args[1] = (uint32_t)lower_32_bits(address);
+	args.args[2] = (uint32_t)upper_32_bits(address);
+
+	ctl->ops->send_msg(ctl, &args);
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

