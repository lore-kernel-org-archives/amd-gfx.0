Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3015FEE20A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B513C10E707;
	Fri,  6 Feb 2026 13:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lwDbXNd1";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 050CB10E700
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkJclE4DZKJ2D/aq63ql6bUjelKVZQkRq3RZSmT7yj+CL7ft6tL7qy68M/jQq3EN9udITSA71/iUblrzV4074/0ZeG37jvsdGh8tOTyN8m78T6Ct7zopPmV8T0X6YDsme7Rirt6TH7UzMVtMUe6Nea9pw/l+g+HPhk3y3iA1PYsB+TMIU1IebNvaKza1TNLdJ1E+IATw1jU7ROWR+gCWRGJL6Febg/NKc5ZFaTNlxcdg2F+ksbKQo3+d4dq3AqEZbUQBBTsvv6YUH+hLQfQfkp8gEM0UtDP+ccoLaO8DkNTtq2X0RPh5ziEDwXstM6Pi9rBdnxyHuVM5dGagfyae5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLfYwGyc6fwHYG/jXzfhm+71FoXBjhJBdTuxS+TzTNU=;
 b=DD6aMCnuB2PYi8GQkxTR4fw4OyDlGgIAKRcpEABIAxIYmotHEUN9a17P9NJ2qfJ7Wo8cgT8E3XM5hY45QAanWWH2Qy8HFhMApaJzPX/1rTmr0TZhrU+41f1DK66BCVaXOpEViJ/2Cwjo8hf8Doceerpi+lNzySOVcICOapu5wNjnSuU5x1O1P3pdiwxvK0OkS9osKbY83Inp6mSV45rEFWnbF1PCe7huH2RXNTFSdimmwqmF7Mct6UyeHdInzvtpk6yKch1/O91VLnLhkLL21FC1qXN0wIPpfZnuiHBm699VTTSusRjCrmLBOV+ZZV8UEOMOs+oMSeCjzC/UA5NwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLfYwGyc6fwHYG/jXzfhm+71FoXBjhJBdTuxS+TzTNU=;
 b=lwDbXNd1/52zSoZYxCIuSa/rNB/msz/LMrmvkTsJx9mPL/2724WioHaLXLfUHq2B1Jd5hkfydQrzu72YJm8AhpjtnemwIIzVC3MsU6kh8tJK6uQ2tyOc9IgM22uyjaY8HQml4WCEU3X2KQyor3VWoQBNVEQrVaBcZzSfxkz6S9c=
Received: from SN7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::17)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 13:36:27 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::cc) by SN7P222CA0007.outlook.office365.com
 (2603:10b6:806:124::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 13:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:36:27 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 07:36:25 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v4 03/11] drm/amdgpu: Add support for update_table for SMU15
Date: Fri, 6 Feb 2026 13:35:59 +0000
Message-ID: <20260206133607.91047-3-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
References: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efa7c9d-d1a2-46ce-0c04-08de6584bab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WqXsPvI0ftUDs6mpd+i+lvTw5AEp8zrmT8XqrYDE1U7Rk7r1vBOGTKFkyZu9?=
 =?us-ascii?Q?Ofanv1w/jl24I0wLJSjyLkJag75+ZZU/SFK5QWdeH+D9XHBPdHo/EwNohXiO?=
 =?us-ascii?Q?8jVcXOV26h1PmdWicFq1fepaH7bqZDdJ+U8cu3aBkmjnTgZhImaosPmTeaCu?=
 =?us-ascii?Q?AyJT1MU7Xd5pxSvLPWEIq0uUXp+w8Db8UvQ2GEIctTymmab260FtzvZr5qZH?=
 =?us-ascii?Q?SUrC/4iAwppfzlYkMIQ7tbYQYleyDQFXXMaIcA6keoKLIJHxtzka+xW1jYAR?=
 =?us-ascii?Q?u+ZSI5pBR2r3u1fkMLfX46yz0oBUE5HTJDRafzl+uCreOfoG/vlRCTLM6V/8?=
 =?us-ascii?Q?rX+q2GbGk7yHqZC2pZc8bR4opQwFjYfGrRWdYVN4t2qgh0QrqDZWlhHQxHPg?=
 =?us-ascii?Q?TiIKWWuU3dIqYWSBwxZX+kxaSMrN7ryC2a0bRObop2ZbiGY8xK5b4wdQc1II?=
 =?us-ascii?Q?jrPzNav5UmViC4UTYy9gxOxi0+BrBleE19f86cTuyPeAjME5XMjmABMKCRrx?=
 =?us-ascii?Q?szon49mgTNTkZkKiUSiglgBlTdEDqJ/tc8Dx2QOmOD2km/Q0vLbBIDF5Vgqj?=
 =?us-ascii?Q?ZANevkshveAlxt5sgL40RFkTDVkWs6BNwRNy951iOIVXNq4kRLhXhuL6qneP?=
 =?us-ascii?Q?dO6z9lZlSu1XLyUV+umz6ofmAl3AhFTv1GeSQvhujpJ+jbUqclXjMHAE2VmV?=
 =?us-ascii?Q?lLKJufZ2OahiYIQvZJLloVAKRgCbxLNkyDjDvCMMD5Tlj6XBQ5aWcFfib9vk?=
 =?us-ascii?Q?/rPBQx4OTxMsL+V8FwBIoEiLO508WzdICZqn6Tgyy5Id1x9FK6qdfLLU8+gY?=
 =?us-ascii?Q?TSs2i91I5Wcy+w7CDRkZbdp/ucW/uuhMqyZ53J1T/CRX513xxx0rgGKar0NQ?=
 =?us-ascii?Q?Tq+TKFZ6fr5nP5xfOmM3MT4Y1WBWp19X7YiRYgX9rdNOnXhBu4i+0iLEli8L?=
 =?us-ascii?Q?OzTcPphCm5eXuxYFf+3gQ6U70ts3c4a6hjM0SRwOe60NyNdEa5N08ckEoaDc?=
 =?us-ascii?Q?utP1g1hCuYOHQN1Nb36EXsQUp2PJPdr/gYST5UsI9lFjfWiqHbbEjK2JHqnF?=
 =?us-ascii?Q?MjqfTefoQk3871rDoBItczrpULWJme0xQfxIkZ1VZsQOwqZgJkoHBMxEwV9g?=
 =?us-ascii?Q?09MU2vIsAtlqXffx1etbni3C5XsaGwy50qiOtUIeVEBMYMoWqtIfyshbzCl5?=
 =?us-ascii?Q?I7+LMgsqJtAo4BN9XRu52Mt58uEorHxaJ1hjN8MhuIoTf2hb/vTaVnT8DrOY?=
 =?us-ascii?Q?oP4Lx+8EnSN++edwig1edIET5ZCfWAV7dQ/fTWxDI7tZnKbJrVyQ5bjeSr/X?=
 =?us-ascii?Q?DMamy51pOoPNkqY/x8bVaRGlk/0O0kt9km9SxfP9zw679HG9k5dkJhQxmQDR?=
 =?us-ascii?Q?xXMtRsPXjd5fra/vRO39ijH4pKKYVYhhnS9d7nKuLLL+Y0dF3AzFTYF1ckoS?=
 =?us-ascii?Q?zaPx8DN5MZZK/OCzbMYzLiSrPibUqBZDRyZyfksk5UFro8XAwWkBANMHxdSR?=
 =?us-ascii?Q?g9uVPtGCM9SWf1yd9bpUTvq+qLpbx8pTAmq0c8aGQujyjxh7YrsevNOo/Pnx?=
 =?us-ascii?Q?8F1RyJAroOJDCeITVlc6X77AVtduExVmiLdPTNqMRO9onbVDZO/7o2FT4a4f?=
 =?us-ascii?Q?kUb6SPpxYbGD5PwGParTm1kbxdd3OeH6wtLMbTtpeXdg29RWK0Jse7QXix0/?=
 =?us-ascii?Q?hOqtEg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fcjKnAwH3k/MtaYx2o2NUZJiUXJLbfg6Fxk9ZOlE7v+92GxTSvTriPUFVbNFMiFAVQhmey1lqp5hvqprPtvh8f42/z4j2XAnww/i2KhGweX4eEkfbvXpao07zpo6M012wuFKkntoD4YDsJOOshhm/osF7WE1kp6QnrInwPCJo4iex7a7yHY3GVXQ1NylfHAE9csVBrJQ2CgBM1gGlujb2/cbg/KphkRANdcmdInoKsK2iFF5nl3ShTFshGHlF5ggVgnr26UPIkXZGCYBTB1yKXz9ivzQECQpQ1jpW2zTHPAXWXzTcH82Uge6WjRObGERfJBB3WhdSuKbG6O5LkWjpWoZtN+fJwn567qrN83RN3eL/LcQlxkR2/lQwdrAXMVQ8DlfAjlOFRgdK0EupaujT6z+iCxLELlyBW2UxJay3q1Y2qqRJ6YzUTXgnpHFZDzL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:36:27.4915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efa7c9d-d1a2-46ce-0c04-08de6584bab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315
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
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 61 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 38 ++++++++++++
 3 files changed, 104 insertions(+)

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
index a2854d528bab..7ab6cf2367df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1726,6 +1726,67 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
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
+	address = smu_table->tables[table_index].mc_address;
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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index d58b0bc2bf78..9a2e2c2f4e06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -190,11 +190,38 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->metrics_table)
 		goto err0_out;
 	smu_table->metrics_time = 0;
+	if (tables[SMU_TABLE_SMU_METRICS].size) {
+		ret = amdgpu_bo_create_kernel(smu->adev,
+					      tables[SMU_TABLE_SMU_METRICS].size,
+					      tables[SMU_TABLE_SMU_METRICS].align,
+					      tables[SMU_TABLE_SMU_METRICS].domain,
+					      &tables[SMU_TABLE_SMU_METRICS].bo,
+					      &tables[SMU_TABLE_SMU_METRICS].mc_address,
+					      &tables[SMU_TABLE_SMU_METRICS].cpu_addr);
+		if (ret) {
+			dev_err(smu->adev->dev, "VRAM allocation for Metrics table failed!\n");
+			goto err0_out;
+		}
+	}
 
 	smu_table->clocks_table = kzalloc(sizeof(DpmClocks_t), GFP_KERNEL);
 	if (!smu_table->clocks_table)
 		goto err1_out;
 
+	if (tables[SMU_TABLE_DPMCLOCKS].size) {
+		ret = amdgpu_bo_create_kernel(smu->adev,
+					      tables[SMU_TABLE_DPMCLOCKS].size,
+					      tables[SMU_TABLE_DPMCLOCKS].align,
+					      tables[SMU_TABLE_DPMCLOCKS].domain,
+					      &tables[SMU_TABLE_DPMCLOCKS].bo,
+					      &tables[SMU_TABLE_DPMCLOCKS].mc_address,
+					      &tables[SMU_TABLE_DPMCLOCKS].cpu_addr);
+		if (ret) {
+			dev_err(smu->adev->dev, "VRAM allocation for DPM table failed!\n");
+			goto err1_out;
+		}
+	}
+
 	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
 	if (!smu_table->watermarks_table)
 		goto err2_out;
@@ -220,6 +247,7 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 static int smu_v15_0_0_fini_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
 
 	kfree(smu_table->clocks_table);
 	smu_table->clocks_table = NULL;
@@ -232,6 +260,16 @@ static int smu_v15_0_0_fini_smc_tables(struct smu_context *smu)
 
 	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 
+	if (tables[SMU_TABLE_DPMCLOCKS].mc_address)
+		amdgpu_bo_free_kernel(&tables[SMU_TABLE_DPMCLOCKS].bo,
+					&tables[SMU_TABLE_DPMCLOCKS].mc_address,
+					&tables[SMU_TABLE_DPMCLOCKS].cpu_addr);
+	if (tables[SMU_TABLE_SMU_METRICS].mc_address)
+		amdgpu_bo_free_kernel(&tables[SMU_TABLE_SMU_METRICS].bo,
+					&tables[SMU_TABLE_SMU_METRICS].mc_address,
+					&tables[SMU_TABLE_SMU_METRICS].cpu_addr);
+
+
 	return 0;
 }
 
-- 
2.43.0

