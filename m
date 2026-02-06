Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D9AEE20AB
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF1D310E79D;
	Fri,  6 Feb 2026 14:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cfpSRTTq";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 744A610E798
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcaEyMWYBSjyoubzWQ9RZml0Dl1GHNDXExRQrFIHVrGg/NlKBy8DwZfcSLGkFc/lkgj0uO1mSwFfYbaErLhHqeynBJ6th+q+Jy1XjZwzG0z/bh8VCfaBBPh/0x78bos9YgRaUWIp1stDiN9bzUgct3GLqaZXnYCzLASkymwMsz5vqYMBgu9w25Vf0r51rc2t/Kx3nZ9rg4DiXdba0JvAM974xzFlNll8IajBqQV+11hHQuWS6mbbz36oJk8eHNjZJ3hzxWkPZDHAA+G3zOx2x2sFJNauLO9NrPPc/jlog4O6uxgqDtqV2jywmb3k49/gZE+y12qtWEeLCS1mKEarrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaJvLdKM8U2XS6MCY6PXvYB9DYf2MfppSDL/AH09UFk=;
 b=rJjhqiQvrdQgOZ7msrjjJlrSCieQZoXQBigVYAZw3aBKqX64wmOpyizyZkUDj9Q8aFpeVstKH29l3kfosi8Df07/VpbLfekWw5HO9PeRZ2aNjYXzgbrnQw1dl6g3FiFcBFC3/XcaNCCKK/ArW7nsSzCIIgv+2RJcPST/qc/demeOADURc3SbQ3j2RMvLWIx0iOjcuZYg7tHSq4zF2mA5IxyE0KI03nbjLWR/ls+s0GatRYWBHgkPiD5ywgOekVPVtge6K3DOB+9auxfVU9z8brNXCoV2qWFrCHZ/xyf1+DZS4tAi4k42EkN64jI9p4BAgQyGVNGbawVDYFiiKfxUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaJvLdKM8U2XS6MCY6PXvYB9DYf2MfppSDL/AH09UFk=;
 b=cfpSRTTqYlorN39XnBPIX4zGskcWSKzfbHlmx7xj4lsHyu0rA7afjF/Epi3QWgFnwbKcxF+OKYx78U7vHyr0PG+akJVxy5T9EYjtiXcmD2lQMtQPRdNVFsRbRtItPpZ+zUOWxTLH5A9zeVy3nbN7H+xcgBPdsri1/IbLuUM9bWY=
Received: from BLAPR03CA0156.namprd03.prod.outlook.com (2603:10b6:208:32f::29)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:01:12 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::5c) by BLAPR03CA0156.outlook.office365.com
 (2603:10b6:208:32f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:01:09 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 08:01:07 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v5 03/11] drm/amdgpu: Add support for update_table for SMU15
Date: Fri, 6 Feb 2026 14:00:40 +0000
Message-ID: <20260206140049.105294-3-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
References: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: a13222fd-3024-4382-16f4-08de65882e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y3vywqehh2nJnfWyA+5kbvcsVQ+QpD0Vpp4kNpJkoi9VAm4MVcFnRnvlYkKC?=
 =?us-ascii?Q?X1jxZmxDRIoYgaGlci3K/39zC+c9efPSpTNfU1P9sKUK7tK9U3mLUDGYbHG1?=
 =?us-ascii?Q?0Eisxwcl3Dd3QDDeC7mbGt94RYy1v57Nu+saqNDPgo6t6RDW/hEB5BBEmy4f?=
 =?us-ascii?Q?bCNmuBiK8WpAxK8qxUdGbOm7xmXl0ns+DfI7UhxAeU9WyEFWmeMCSyCWtHQ/?=
 =?us-ascii?Q?yWGCMTPWQNaJ1VmUwYGWa0fIEBNcWriuAB5AZQADqj7ZUWYYHXxAOmOkr7QF?=
 =?us-ascii?Q?JOYWkn44CQW/LiIEY5W/0MOs2TYT5HeJHfNa5jpLj67daIx1qu4IJ14NvZce?=
 =?us-ascii?Q?eNkf0jbVw1RjK8nnl9iCLYrfjVuv3kGdqkfn0ed/040g8AwpL/TemvdmLs0q?=
 =?us-ascii?Q?TvhBKO5qN6O1PgQnIR05AzSqnaHnsCtE392OGLMUCAH2bthfDSoV55mkckU0?=
 =?us-ascii?Q?duSSZ1EGhANYfPMKatYW68F9d5fqpYoAH5cJm0PXWa+SzMicyov3GZ4Z8L7i?=
 =?us-ascii?Q?LPeZjsj8rMSWKCruCGvSdV6C4py8Gw5BHrRzErOVTRWZlzb7OOwABpoKwQDt?=
 =?us-ascii?Q?VCXVWinGoGFbBIz4Rw/ZQWNGDzZ1he24uGVgJnSDunUUdMc7BGKCUgD9e8/X?=
 =?us-ascii?Q?EVCVo3d8d//uQu4IOrUOIT0uNablj3D0KMFPX/vj158YW0tNUbScCe9qLfgh?=
 =?us-ascii?Q?JHkQd5nbvhEA2Mcc7dWzWWbSFX3UAoGmUH3rgKdgzq1GLTwSy7kexTcCiZnF?=
 =?us-ascii?Q?2EqqrYtmJ8mH90wW/X9OhxmDL94Vbboo1s5MZWZKD8LuVjj7FLLcss+7Xa/m?=
 =?us-ascii?Q?dI9TjHZzuBWqc5u6tAMhE976u1BYnIUUwhMW0Jwbm4zgHZ6hMG3q0D0GK5Xj?=
 =?us-ascii?Q?eGJDcRpY3R+Uej+3DeHXRv4+PvYPcO+oM3Rmf1FU0Eh6SDnxxj6jrQNFZCxj?=
 =?us-ascii?Q?C6LCpSwxCc3nNZLFWFZv+6sNHkO7jOReqeZ7u3eX0z/G+nflaeFOPFw0s3C+?=
 =?us-ascii?Q?51nlvxza3FqIgL7R9LBvBy6q0ItdErcAKBXvIaEKTzEvp6/zCu1Too9B3Pk8?=
 =?us-ascii?Q?M0qAW5/mpOthp8Fi992tIdtUTOpN3/te3Wqlo2nRga/pk5r+ufRtCSaHQ21i?=
 =?us-ascii?Q?Z0htG/wZj3Hxkc4DKGL9c1hSZguEVI0oCN/93v6tDegfsKQ+/m8NzA+iaoW5?=
 =?us-ascii?Q?WXs56B3aQE9reV6NhB39qR4japNXKrAeyrn0iQRfphIdoexH1fUB7ni8jYi7?=
 =?us-ascii?Q?7RkL+z34c5SiyKSsAVTqDRs+yxxc/HUUs8bfgJaI3UkDOnIvY+Y7WmNZujTK?=
 =?us-ascii?Q?jSh8nzYfDXUkeVFoC1PHyAXcbc3GbB4fYbdBUCpNcyNrnAPMFTsEcXJ/B7WN?=
 =?us-ascii?Q?z0vobaL2fxv53ux2Rlr6z59vXXnCcfCtMem0Ew1Xs2RwtrrYXZ8oPXeMu0mC?=
 =?us-ascii?Q?QI7mZgIWJD/n0Yokhue6QgUwn/csACw2axGcfbv3A362CRjybc0+wjrHIMF4?=
 =?us-ascii?Q?mWmZniS5N7H9sQvuWEgd5NawiF6NREl0hKtjGOUqqwp87sUuR/Rs17D/5MDS?=
 =?us-ascii?Q?W5G61EDNdjnrGrRRxSBXCTNXg2xtyIfE7sUcHXLx2axT/XayuI+CPwHozrCQ?=
 =?us-ascii?Q?klb44s43PLpDkcqPWV85IQJ++JknE735FLSa0mEydzJLUpu6BQ4fp7qH2nc7?=
 =?us-ascii?Q?hWNs7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RdKgRACFV3KUik2iTVVWDTONXSS4HeAquwkKrsXujyPGQ5DXIDjNqSbDHreVHu/Eu607qUvMfqfYjjkczRaytoeNwzWXoe9pOTBqgAAbF3qrQMBzAJnZTMA52Pr/66jfAm991xMYuwvVuFFdCot58BrI44nOfAMw6Gkqu+f/rpvL2h1pMumCGTqWapgcno/UyUf/+ILGJiC0LfxW61jXwzszu1iC6Z05DI6pvVe2TZkUucEw8i2Ykrry7DefytZwAIjj8Sa25fpkHLhIa5f5nC4hWwi7ocCOQaQNNNI3t4QY11UOaEXhBUsKICdxWLCu3DgpaOPOYkVvU5eVsCdc0PKVhU2ujXwWWxmJdPTlEFNQz9nRu3Vp+cO+ipVexkW81fFpqTRE00ECFxjHQs7o7Ye/Yd/tUCcsc0YKd2anQS37pKkRGg+o9Jhl7slTZNPE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:01:09.8239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a13222fd-3024-4382-16f4-08de65882e3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558
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
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 60 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 38 ++++++++++++
 3 files changed, 103 insertions(+)

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
index a2854d528bab..70dd5586c53e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1726,6 +1726,66 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
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
+	uint64_t address;
+	uint32_t table_size;
+	int ret;
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
+	ret = ctl->ops->send_msg(ctl, &args);
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

