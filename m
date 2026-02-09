Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D9CE81BB1
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 13:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4E810E3F2;
	Mon,  9 Feb 2026 13:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a0rMZTRq";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013015.outbound.protection.outlook.com
 [40.93.196.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEAC110E3E9
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 13:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQmmG3gyWhmXfEnbmaBzjuDnWtYDtPOlEnY3kuuCYI4merzNiNauIb5krz6KuSW1IIipV6aVMPLSZ49umbOSUowyRQGAm5zK98oq92PECxQS3PO52cLA91muf6WgEQj+5//WDWwzHSdMCGR6Kg4+/isKxpPj+I3JknlInqn2WsauBUv+DvProGuNSoUuI6tiyHPVCCmqPJbuOwu+38jPxTN9uW0N6wl64GRf3S/g76P3mimk6uNM6NPMrOrLUQF+z+FvfieJxY9vEJKM8A18wdpcFGjGLjEQXs3zPa0hyg0Zx7mr84v/ess5AlvPct+niPEo9RZeve8T3BbjFzDB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FzjyCd37euD5NxvRFFPLNBfnOGKlkkIKKO5zVTElPI=;
 b=ALdRJtA/exfxE95nQ/p8jusoNzoQfZAHlBphgH+6RVYQVAEDXzmXM+D2fQBTysIqAu7sqkp4jP6KA9uu0lisOByQSPjFBpvPdBbBgIbMPgUcY2aQhFOzeRwNRJHV1MEGFlqkFgC4n+9V3p5vyb+4nWMhaH3ScJXFWcHpOsIMLTl79wZ3bBtf/8XUqX1tQhjerMb45+GvkSeSKKdWlGWmggqAr5W543CG391oxl9UBK0fsLz1vz9ohZKnuJNgpP7hrp6qVCwe2VJvMvvJBDAiv+GCKc5X7e8m2LEwcQxfHJdnA4apAALa0EkXdALj1oE47T4it3g7773mWg4X/Qy6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FzjyCd37euD5NxvRFFPLNBfnOGKlkkIKKO5zVTElPI=;
 b=a0rMZTRqPUMzpHChJvMhIbl6Ase234XTroPgC9XyNvR0pJhiyIG3EDddt1puk/mwOOZOcK0X9z4ds3Jv5tBHsu4Uzyrmupej/v44zraO0DtNuI+37wu6dXd+Cu5uPBrFiZ8PaqbEEXiwcF4zZnscfSJAiD7hlqZPz7aq8FZYFKI=
Received: from CH5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:1f1::19)
 by DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 13:04:42 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::29) by CH5PR03CA0003.outlook.office365.com
 (2603:10b6:610:1f1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 13:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:04:41 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 07:04:38 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v7 03/11] drm/amdgpu: Add support for update_table for SMU15
Date: Mon, 9 Feb 2026 13:04:05 +0000
Message-ID: <20260209130413.118291-3-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
References: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DS2PR12MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c8c868-4622-4101-93dc-08de67dbca1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uA8d04UDlqkt2BPPZQ2soNdZANWYtOgEEJhEP5qy+CzcTGW/rI7Wgw/Nz7NX?=
 =?us-ascii?Q?3c/r1xULTLXdyDu3quAf5/9iw32XqJciJFrNd9T0ydxhugol5gQ5FT209he9?=
 =?us-ascii?Q?zAwRQssOxxZo2ynFXiyJ7E1CV/78zI6fK7YamPo3Ssrs+S3KnLvxGel2fD23?=
 =?us-ascii?Q?U7eQ6JZ9nQDGM8LwXcX1J2wKeRqkt1ZpqfuibN9Thrgk5frgjLVZKQff58w5?=
 =?us-ascii?Q?U3+xUMLB0vRg9o7LxO4G9Q1nSdBw3rcysgdWQetTaGRc9c7tuuGop8IvhX7y?=
 =?us-ascii?Q?L9JxXKj6GcXCFNVStPuJA95xUF6aXg2YFWO1njRPm1S2QKE8Bpq4kv0jx7Ni?=
 =?us-ascii?Q?Wp3Hy6PZhEE2LlsjCwpbDydYTXLeo2dZrNzT1xT9eFdK5cvvcjlTAwDOikQd?=
 =?us-ascii?Q?oU50SzwSHho1K6YdoI20+VEOMSDueorkAvTkQxRDUeLYHWsuGS9jesoR0yle?=
 =?us-ascii?Q?GgVCvlCzzEgwyOSO0tj0RuGDb89eIJTtHWjJDqh25Nz+s9V8T5EmXh2A3B68?=
 =?us-ascii?Q?UmIr5gt1c43eoLSLJoEaMEmwuvKiPKeY98ikhVS+YEV1elf/Hzwzz9NgkPqY?=
 =?us-ascii?Q?IBvZnZbVf3S9Pg5OMgSNPpBXjyThWEBbrMTOkiv0xocW4uzwQHiJ8bvo4Zks?=
 =?us-ascii?Q?k12TCkv5UhyPgmqqsP9eBHnG6EwiMyshTCLPCaDYcNJCnlySFTdbOmTGYWQJ?=
 =?us-ascii?Q?8SmCbxH+6L8HfHuh6urJoz6v66imx12bNEeJr5r/7sSTcpdWwkWuUBji8r5E?=
 =?us-ascii?Q?YTiF41llp4UUeNGjHRSV81S/qlx9vKSrV0NGjiYF84Htt9hn0r+ODipeYS+u?=
 =?us-ascii?Q?LsqKCfG+JQtVQ1qtPHFgQ2fm9v/Fb0ANCKOowuTyi3izipYi45puWjuDrLMa?=
 =?us-ascii?Q?Evqv5i5qhxgUjLX/k4MPmwwPncshWImPI4ErWIRyp/YTDAe10enIWf58xlEf?=
 =?us-ascii?Q?BeB3XTE/DSOfEgLFchg27/dxnRl5nd1xiKPpJHCpuPmQAsKMCN/6m5oOv5QG?=
 =?us-ascii?Q?qOPrycIsJoZQLvY9lJaGq5RMwyZf9NCx46ygI3jeRe+nqqOx4oeuYS4JcuX5?=
 =?us-ascii?Q?VoZjNgTaCwPl+vRItXWmPa4sx5zmgQJQUO4drbjdLZC5RPhcwA1qjY49xTz+?=
 =?us-ascii?Q?rw9aQ3QLzd304pbc6rGbYTF5H5J1Y67+rEe+FKTpgSuNW6jAy4ldga2aenDm?=
 =?us-ascii?Q?ypb0PX5GVSGzzvxclsfFoY52isbxKL1/KlL/hGhMo2O3qPZaPYcX0AEFOnoE?=
 =?us-ascii?Q?qdzaKoKn9sIRSDJocbtu+IVanWjpEOjdR7gWgg0S52EmhsTFKvQWYSFNCcA1?=
 =?us-ascii?Q?QEOF09gGNVkXf36BbuxCW0k6zWoFaltRffIqKybY76u2jJvrS56m5uAanM8H?=
 =?us-ascii?Q?kb1yhWRJv4DD7tSmlMzQoXI32yGGJ7oiCsfH/ms+KDt8q875IU8WXjRFHFHS?=
 =?us-ascii?Q?FdVUeTGby/MFMV1n00UVVodd/0kcpu6ssZr+Mg4pmZVwoaXruJ8OObZwdN7n?=
 =?us-ascii?Q?9OMteM+AJXH79yYIqODDX8HYCIlRVegEIOzzxOdkB2wFpr0SyUVEV+CfjHmG?=
 =?us-ascii?Q?qjP610sm7Ncz49l81hms/PqIQTMN+Vr6hUvyR8zRTOpRitg5tGCoS9IdtrzG?=
 =?us-ascii?Q?nU5mMBGktrXlSzzT9LBYECrL+gJzrJXQgnIAb4SxJk1xMEE0pq8SwqC0+8Nl?=
 =?us-ascii?Q?jle27g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hdH6GOqvsRWHpulgXDai9bIgh6zNAlezaUTSMDVW9xntmVdENlh176gKB7GR1kNHQfEyX4aEs3ZmflxX2rwYVVP8II3Vl25aTJsVmXFVwTLKOKYDdm8ShFG3GvGxohRDLXhkXSWbmTXvfVxE+uCiXgbHq47+yPVJQI8TuWyaxx6dNhznj5zEHPfDYyTIsFtp3QSQ+xOSRNHYqYuL+8g/pRV3uBjK3mFxupicPxwhx6D+Nms1pHf613pyQJzy7GpL6H5TmVa/S5do0EaPf1bF6EDNHQWty3yZxLEbzgOwd47J2WxJgW4s9nN/UNdZ+fWI19J3YCQQqTosxbW4HA1ZgaDsix6TzEcqsDx5+bbb9YSUvhKiXm0M3P2PUCeKghmXMCSSNsx6ayDrI7Zbrp1mi9m0nEokm1VqGQnaiOZ1GTyPUBchlZBMM7GLKEdCqxTy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:04:41.8898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c8c868-4622-4101-93dc-08de67dbca1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9567
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
index a2854d528bab..d7a4d5d6cc8d 100644
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
 int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-- 
2.43.0

