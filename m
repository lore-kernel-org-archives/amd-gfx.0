Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5880EB597E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 09:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8274710E060;
	Wed, 11 Feb 2026 09:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dHpNmKVj";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8221E10E0D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 09:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGJ627KuPdPvTOgtipm9WJqJ4Mks8nC1vADbbZnfn5v45yqKQAXOvs4IECRnPPw0nu6jD0+to9I2L623M99mp7iDb8LNraFpDXZjofhCKrm+50pouenAMNEVAOz5eV+P5UQePgmzU8bvX6bxlidRSlbCBZy/vx9UbteBT2gjTAOtPV1j3eDJXXUbcI8fF/7WzM3/ps9pio1nLGuc8aBCf/fAC3j+pWzts79j/cMOz2Uu4yviNsACZv1NyxtWJY3gEgdh3FvI+0Ooi2SMPen3Lx3s2TO+oQamg0l3uyV5huMuB327Fs23N8xtd10a6s9BuLpsSIXzRb13XDiMDsLuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zVxXqoOP/FDpg/cYvl+IdQ/mHeNfL52NXQaCfNOsZ0=;
 b=d0xLVOs9e/VMf1DEzzLvvxbwS0F22zCwhQqPPQ2cJFmgIkflgmsh2W+IUBAfD5lrHJvh8n0MnIiH0GVtnHDRNKBg3+ut2c3Uk5ecaUic0KFup2MAoY3DLzO7LPmdabX9lWkJVlPvZY47YukBPOJX60vXuKsH3PckYG+mRynY+uVIk5R2r7pjlY32+MI2R7In1FytI3Jl6rPYuxkCi6XoYzOY4hXFd+E4ph880hBtSzYDxz1W+wBkX/7isS+l08NjbhsvpzOxlBwEu+WHz0175+hhCX4i+AZ/fGZaROtQI0xMqDa5BdkvTz8D1Od1GRd0hKsytt7kTjBM8m9W4MmBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zVxXqoOP/FDpg/cYvl+IdQ/mHeNfL52NXQaCfNOsZ0=;
 b=dHpNmKVjMzp13E8aEANkuGIO7GcLz4avg5BD20fiP4NjQuJnKE0ATvn9hlnRtFQ46PVQExD7LYVXXT0up3eWfCLZwnlI7hcQAGVB5koYaajxSEMONPSX4sw21Lg8p7pwUGL2TW6+p2aTo9spiQSvbdBELtX0klugBDUGsedONVo=
Received: from BN9PR03CA0083.namprd03.prod.outlook.com (2603:10b6:408:fc::28)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 09:13:14 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::fb) by BN9PR03CA0083.outlook.office365.com
 (2603:10b6:408:fc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 09:13:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 09:13:13 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 03:13:09 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Lijo.Lazar@amd.com>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH] drm/amd/swsmu: Move IP specific functions
Date: Wed, 11 Feb 2026 09:12:55 +0000
Message-ID: <20260211091255.125037-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbfb9f5-4234-4d11-f589-08de694dc911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gzPsHbqTLHLKx6BmWHrsP/4UOlWjhFMjhUDsHfu74npSXDGT7YyX7Tng7W8+?=
 =?us-ascii?Q?OTOBAjyzgXzvor2P+SPW13ugyUYqXJagv3FqNt2mAu3EotnG/iCK6l6EtwJ4?=
 =?us-ascii?Q?5Z2regBKgUfUH+GVrKIgMhW3/uo87aYNcXE98e1bitTFbJ/jGdO3+nBhKeB0?=
 =?us-ascii?Q?degfpYkZPbL87fbEoOMDUuPsv3im25ZHFYqm++M2tfJqaD7QZm0MdVkRM9TO?=
 =?us-ascii?Q?NYuev3vzu91kGa81pmQG8RF4U8Fby92/8Ppj73l64w3R8qrNiWU9KaedqIBF?=
 =?us-ascii?Q?Lxu4THAfwMe6QND+k9zwEPjwQ5U4lwX5JHYBYpdf2uJBuDawIv2OvXhvZdXL?=
 =?us-ascii?Q?ccMnRDvl1AfH+kF2J34mAZJycZBMqCVLH/khRGMmp2YSPXu0KSs/KSNEFwyl?=
 =?us-ascii?Q?bkIdMJcsN7TIkPCOUUaAA3uJqeC8RzvzQJD3ZFLmOe7tx6kn5LVN1TJKbkiU?=
 =?us-ascii?Q?Oq757pTZOqx6apCmNd0H8j1s1qx9zkF5WqEI57IsovayysIAxex9Y1zmP9od?=
 =?us-ascii?Q?obOSa6FWUBqA7EcDsJrbpzD6C04dMNb1qdzJk+/wvH+KQkgyElLPKzOdkCXg?=
 =?us-ascii?Q?ShucZNKXY7t9dNI15fM6WacSWV7YJapyKBLtAGVBP0+N4gU4qikGAsO5X9Yh?=
 =?us-ascii?Q?ThYh9z5BDT0xY8u8aTt+9eZGua2NWUUQztWcN3g5ED71zeh9rn6EN5m9xlzS?=
 =?us-ascii?Q?58mVVlk/JmTxNseVSgVU6iCBp0CAB055v07o7A7e1xBdKAP82q1JBFo6sIeB?=
 =?us-ascii?Q?W4o/ohA8MGVeJmFido/EC/CSOEDcYT98n6qqYkrR8jKv3pGKDjyvXG5bBZWU?=
 =?us-ascii?Q?WEYZOQ0V0A2TaODUZSinzMkdnV1ugkE4b33GY+d8CyQLc9L71Dbpa2zIewsQ?=
 =?us-ascii?Q?vtHRrJNQeHk+wIaTR1bpgCWpZEWtWZ/fMgOVSPkzkjj7k3DDZRWyPsI1oE3l?=
 =?us-ascii?Q?jUVfm3skDzSV2AjrZfwIEMG/l+Xw0v8uKJlWhWoNKISECsQbHJPHJHk/Oq2h?=
 =?us-ascii?Q?rubb+rxiAvs74hyjWInWoqj2Dpx8dbVhhwSDK5xElHJKhRieXyuStgx6q/Ev?=
 =?us-ascii?Q?48DYJXlSeDc4BE3d4DtCdLHA6C/8Wh1LTPLmjr65+MgiLkjl2guoEfD3w1sE?=
 =?us-ascii?Q?A8W1Gfg5la2hsABLts3pNQ9HWHIMNJ3Wf6kOZs37p7feBYZNOU5TorYKHNUq?=
 =?us-ascii?Q?pVIz4cmpbPa8Q1koQLT6DvVg47zKDn8e4Gzh3Zab5afgRUrZ/agyYppvgv1t?=
 =?us-ascii?Q?QUzEPv9lIUkkbERZwEw2TiMCByhlWvbRF2JBdgA7f/6N+iO3O9qDFpyjZqVs?=
 =?us-ascii?Q?XslTbi68imwoFpEm9WZ+83qFC9BkofW2/dx8+LDdtoIdC2uzGVx9xGJke0o3?=
 =?us-ascii?Q?jWUqlHlbJBQtITauXavXWupUYwNYl++1LVCUbTZLKH4mqLh/sJLYIJ0xA3CC?=
 =?us-ascii?Q?HiHZ9vVIZevo4WjPxYaq8o/PE2H97kYhM+279H7Fe9IfDIBz9PKJJA0EfPzW?=
 =?us-ascii?Q?4MNrBwt2YmUAqVf8p25PolngL+ShdUunI8lk+Q5oLl46q+3aYx2b5ReIEZOH?=
 =?us-ascii?Q?ai/A1h7Xrdxp/aj4I0gXKYOMX1ibHxKXxdc8CMGckwrvpukGKl6XdIe3Dpzh?=
 =?us-ascii?Q?YeM24PhavszVl0NByQHWU0qnj8S24FTAWYVbAeS0Yy9C05a4xzbq0LOYOnao?=
 =?us-ascii?Q?/XuBwA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pv+1smq8B1N3PAX7yP4Vu8H3mX77f1LZ+Hmsfn/8fFecmkT/wqKS/OvImuxKktahObKaZr9PLnAkaNpb3xjOpxoHQGwX4dxRH+fgWXMm4CDrdJGt9IzDImzDe5kSCQKaoowfP8lefaHWeXNP+hGAWk1niLqCoTlkcESwSNeHFEoKp5SRawCJoc3KQw7ybqeYS2nRucOxxG/S8oowXgOWxCbhT8m2X2NLgGydRFE34SL/KyJj4qD5h8YOzrEcwxO3H40kYaV68ewvPMmw57xoc+JX/JnFTRvIkGzVFrNMVyiiWv2pH2IIF0Ep8FdklhZaK3GeuZGJIPEiBpQ1CGOPqSyid/KcK0BPQYeb0ZdC6qY12eihi8y/jhoWMxsmXhrAazGO0t4c+wb1YI07JT0/90tQkSqgW4eqdGRXOWI8FTSTAUoCEYTWTiZEDg7wWEzE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 09:13:13.9561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbfb9f5-4234-4d11-f589-08de694dc911
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179
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

Move SMU v15_0_0 specific functions to IP file
- smu_v15_0_0_set_default_dpm_tables and
- smu_v15_0_0_update_table

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  7 --
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 66 ------------------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 68 ++++++++++++++++++-
 3 files changed, 67 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index af87c31ca9a4..ab4a64f54e79 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -226,8 +226,6 @@ int smu_v15_0_deep_sleep_control(struct smu_context *smu,
 
 int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu);
 
-int smu_v15_0_set_default_dpm_tables(struct smu_context *smu);
-
 int smu_v15_0_get_pptable_from_firmware(struct smu_context *smu,
 					void **table,
 					uint32_t *size,
@@ -241,10 +239,5 @@ int smu_v15_0_enable_thermal_alert(struct smu_context *smu);
 
 int smu_v15_0_disable_thermal_alert(struct smu_context *smu);
 
-int smu_v15_0_0_update_table(struct smu_context *smu,
-			 enum smu_table_id table_index,
-			 int argument, void *table_data,
-			 bool drv2smu);
-
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 37fe4c1bdbd9..a2f446d38be8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1726,72 +1726,6 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 	return ret;
 }
 
-int smu_v15_0_0_update_table(struct smu_context *smu,
-			 enum smu_table_id table_index,
-			 int argument,
-			 void *table_data,
-			 bool drv2smu)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-	struct amdgpu_device *adev = smu->adev;
-	struct smu_table *table = &smu_table->driver_table;
-	int table_id = smu_cmn_to_asic_specific_index(smu,
-						      CMN2ASIC_MAPPING_TABLE,
-						      table_index);
-	uint64_t address;
-	uint32_t table_size;
-	int ret;
-	struct smu_msg_ctl *ctl = &smu->msg_ctl;
-
-	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
-		return -EINVAL;
-
-	table_size = smu_table->tables[table_index].size;
-
-	if (drv2smu) {
-		memcpy(table->cpu_addr, table_data, table_size);
-		/*
-		 * Flush hdp cache: to guard the content seen by
-		 * GPU is consitent with CPU.
-		 */
-		amdgpu_hdp_flush(adev, NULL);
-	}
-
-	address = table->mc_address;
-
-	struct smu_msg_args args = {
-		.msg = drv2smu ?
-				SMU_MSG_TransferTableDram2Smu :
-				SMU_MSG_TransferTableSmu2Dram,
-		.num_args = 3,
-		.num_out_args = 0,
-	};
-
-	args.args[0] = table_id;
-	args.args[1] = (uint32_t)lower_32_bits(address);
-	args.args[2] = (uint32_t)upper_32_bits(address);
-
-	ret = ctl->ops->send_msg(ctl, &args);
-
-	if (ret)
-		return ret;
-
-	if (!drv2smu) {
-		amdgpu_hdp_invalidate(adev, NULL);
-		memcpy(table_data, table->cpu_addr, table_size);
-	}
-
-	return 0;
-}
-
-int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-
-	return smu_v15_0_0_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
-				    smu_table->clocks_table, false);
-}
-
 int smu_v15_0_od_edit_dpm_table(struct smu_context *smu,
 				enum PP_OD_DPM_TABLE_COMMAND type,
 				long input[], uint32_t size)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 4dc8f0095713..660335d7bda9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -233,6 +233,72 @@ static int smu_v15_0_0_system_features_control(struct smu_context *smu, bool en)
 	return ret;
 }
 
+static int smu_v15_0_0_update_table(struct smu_context *smu,
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
+	address = table->mc_address;
+
+	struct smu_msg_args args = {
+		.msg = drv2smu ?
+				SMU_MSG_TransferTableDram2Smu :
+				SMU_MSG_TransferTableSmu2Dram,
+		.num_args = 3,
+		.num_out_args = 0,
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
+static int smu_v15_0_0_set_default_dpm_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	return smu_v15_0_0_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
+				    smu_table->clocks_table, false);
+}
+
 static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 							void *metrics_table,
 							bool bypass_cache)
@@ -1357,7 +1423,7 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.system_features_control = smu_v15_0_0_system_features_control,
 	.dpm_set_vcn_enable = smu_v15_0_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v15_0_set_jpeg_enable,
-	.set_default_dpm_table = smu_v15_0_set_default_dpm_tables,
+	.set_default_dpm_table = smu_v15_0_0_set_default_dpm_tables,
 	.read_sensor = smu_v15_0_0_read_sensor,
 	.is_dpm_running = smu_v15_0_0_is_dpm_running,
 	.set_watermarks_table = smu_v15_0_0_set_watermarks_table,
-- 
2.43.0

