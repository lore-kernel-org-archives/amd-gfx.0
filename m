Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66351C52D6F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 02:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD97710E3A5;
	Tue, 20 Aug 2024 02:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EAsbyfOW";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E4C510E3A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 02:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBrWyNfQ0DOmkT3LDb/1DhQp9TcvPjUvOE9P+gATT6eJ7I/+OX0BLkINEvPS5e/lXxeRBuZwhf+itz3qpykYRZFi2cdMf529IEFfbD0RAEAyEyqkmRRRi3NmRupFoL/jyDKpt/gRgBIhgq/HCs0w+iRbiwJl3DJ++0PeWoo24R3t0nBMrKKiePBC64i8fuzqAYBjjwv1rKzvxq1IWH6E0fmF3pbq+nlMLT1/3pMKfO6JWz1PW+IxUjxfrS6KMCTnmRCsAfaTN/cS4jEbiSzSHfJbqbpzH70JOo3ghjBFcw3+XpWtkU8wSPKcrAwWGC5wAV9P6QQWvWtYVIN8xbjNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sZoAvubwmEFJUAOl1tjRt7PL/gJ0+CbCCkKezEojE4=;
 b=ATYBpDfwzxr0ibmZ3U4M79+LyZh/R53UfW+5yHCc0ksKaUsA0AFLUVxO7h6rWisyNolj4hAykIdPXnTQvv7N79fNaviGGXKCPqwoaILhu8808Ga5SxF1ugpshL6iYMjg3SljsKU5564wCq3n15z39KQiUwBgE2rFCe7G2w+DMQ+Qdp3yHbFcHB6X7qiT3SLBJTh7y9Qvo2XXuCds6RhSb1IGZY6zJxrJSKqB6wPR6Imml+CF3YMLwrLmrW2DeIXxK4DqNUU/FfT5fZ1s3iYfvmDG6b0+3p6Mve2SAZ91hbCV3QV01I14RJ/PBj136pB3OD09M1pNRYuMkVgMgikmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sZoAvubwmEFJUAOl1tjRt7PL/gJ0+CbCCkKezEojE4=;
 b=EAsbyfOWl8ayIo7O47+n36dbC1fBCSVG5q4A1HxIjz/dspKMFlYgEadKuCc3i2EjGbECKLwYGsncczYhmwJDqsA0pC7lv21Eg1ue9TG5gMUmPSipghdh0Puxkm5ZJ6HQOZvCninYeKCHGjvhTceH1lvKXCvh089YWSTP3jHMe6U=
Received: from DM6PR21CA0021.namprd21.prod.outlook.com (2603:10b6:5:174::31)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 02:10:09 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::84) by DM6PR21CA0021.outlook.office365.com
 (2603:10b6:5:174::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Tue, 20 Aug 2024 02:10:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 02:10:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 21:10:08 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Mon, 19 Aug 2024 21:10:07 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: add guard band interface on smu v14.0.2/3
Date: Tue, 20 Aug 2024 10:10:05 +0800
Message-ID: <20240820021005.282444-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: f3be74fe-f455-4c89-b732-08dcc0bd37b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n1Sy/ixJJQKtJh6gPBJNljkx8St9QQiZCO/DILv1fJVOh73fv3LT7THK6S3g?=
 =?us-ascii?Q?X8YMxKsZHnQsGLG8/A7ue7XMPut48iGx4+qpjXF/RX2WRlpK+1zNKppGDivx?=
 =?us-ascii?Q?k5V0jQ3gnJ9Q5L58pbM9P3A8Bf4h+jBqKJKhBybImJGXP8eD0NoHIZj6Ra+T?=
 =?us-ascii?Q?+tGKvrRSRuXPJAew2LZhRtvTE+gbqlD+zghM6FyzZO9y2UNGI7fVz6n7ytQN?=
 =?us-ascii?Q?fq3ix4x6AmEPJvzE7dWwiiDcsF+0WaW4qjkXTjcX8ZF6r0KdwIPpL2eJFfL7?=
 =?us-ascii?Q?S3EgVcK/d8tTyUPMy0xqe/T5JkaXkZoqT9Fpqr/qV4vEgpXsdAbk7iosxGad?=
 =?us-ascii?Q?fnHnxndcgGu/nzk3JWkwL63PR13nk1Fq/435wGSgS4dD6PXOk9/dQdiX5lBy?=
 =?us-ascii?Q?Xz+Lil+JfOP+sHzrRjCDaT6ZEpAW5VdHL+Eq/d/eqi5Ey3Uim3j+3E/nk9Md?=
 =?us-ascii?Q?+jdKENuPTwyzCd1q8OvBZfP76G/vvU0zYO13N7aKJ9pZ+TOApq3kll1D774W?=
 =?us-ascii?Q?3hMJunrKS5YFVvCbc13wUjdC2HmGmBf9SH5eYJAfgzMd/85llb3Ltl50Fj2C?=
 =?us-ascii?Q?LcJH7mC91YvIFXcOrV9c5XEI2XKbeF+BXL556x/nn8UdnJXHSBKDnIBUekum?=
 =?us-ascii?Q?OQb3+mHqzCWvYyKKKk+yRq0w8kxu7NEso15blXq3bbcHioz/1DGyoccf9lYY?=
 =?us-ascii?Q?n+XKIV5gULSIyUAIrAstmYy7A8w3Srj+2U+k0MUeitsfhCVi+WAx2l7tkdf2?=
 =?us-ascii?Q?26keRYMDcJhCkZfJjQKrEpuEffjV6nphDksdswaunXeYCURY/oh/5YLnlfX/?=
 =?us-ascii?Q?QLPDKWwz7Z+5xFssjkwzmOoLelDezVeEO2sqAYu6d0drUWVa8UahJ33dQ4qM?=
 =?us-ascii?Q?58jfLXXvzKjIXC2pZ18AhxpEnBQleXqKQYnQDBs1ZkI6ThAPUlEP80TFefsx?=
 =?us-ascii?Q?ud7YunZNW49ZbPJo1722RFBwxAfxerIqJHWvxsW1n2EKVenlDTmLWuCSNYQ1?=
 =?us-ascii?Q?R0Gu9VqMllAZzmrsnybA2nLNOIs4asJjG/izOk/6nYj+i+CTjI1tgzcEL1s7?=
 =?us-ascii?Q?QZ2yWQECP++wdluhbIV161uMrMC3CpmkC6d9kgx6Y4PKZLydF7P+t/ucoDwL?=
 =?us-ascii?Q?cQaqB4W/YWqAIMo50X7q+C7OIyDnHDDCZEtOQC7qZaG232Kdre2a4KPj/uNw?=
 =?us-ascii?Q?uOV3RzTAdJlUN3vzl4082I2COBm5n4XNoRMOzLfX1h5SnwpSrcyINJNewb6w?=
 =?us-ascii?Q?7IOBi7qFKR9YQoIMziGT3gi2MPeb34J7WI4hT8tYSG5IFdXfBVreJqv64LkQ?=
 =?us-ascii?Q?E/ryyToez1I3yAIE9cD/XPL1Wzu0cYoaN0BladW0wIJup7gquPxqZ+hBu1Rx?=
 =?us-ascii?Q?HJNhchR16qpBt0KGFgPw4BetptOpaFMRbnJUNaAi+8nMbDRdrKqKmDw6elXN?=
 =?us-ascii?Q?b5W6H5cHiCfueKusQdEuYZKur1FvqIxe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 02:10:09.5125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3be74fe-f455-4c89-b732-08dcc0bd37b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
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

add guard band interface on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 13 +++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 10 ++++++++++
 7 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 19a48d98830a..c1dfde17d48f 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -388,6 +388,7 @@ struct amd_pm_funcs {
 	int (*set_pp_table)(void *handle, const char *buf, size_t size);
 	void (*debugfs_print_current_performance_level)(void *handle, struct seq_file *m);
 	int (*switch_power_profile)(void *handle, enum PP_SMC_POWER_PROFILE type, bool en);
+	int (*add_guard_band)(void *handle, uint32_t gfx_gb, uint32_t soc_gb);
 /* export to amdgpu */
 	struct amd_vce_state *(*get_vce_clock_state)(void *handle, u32 idx);
 	int (*dispatch_tasks)(void *handle, enum amd_pp_task task_id,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 9dc82f4d7c93..30f09e4db46a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -340,6 +340,25 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_dpm_add_gb(struct amdgpu_device *adev,
+				    uint32_t gfx_gb, uint32_t soc_gb)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	if (pp_funcs && pp_funcs->add_guard_band) {
+		mutex_lock(&adev->pm.mutex);
+		ret = pp_funcs->add_guard_band(
+			adev->powerplay.pp_handle, gfx_gb, soc_gb);
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+	return ret;
+}
+
 int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 			       uint32_t pstate)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f5bf41f21c41..804bdc39d855 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -406,6 +406,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 				    enum PP_SMC_POWER_PROFILE type,
 				    bool en);
 
+int amdgpu_dpm_add_gb(struct amdgpu_device *adev,
+				    uint32_t gfx_gb, uint32_t soc_gb);
+
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
 
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 9d7454b3c314..8795d5b9bfe3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2350,6 +2350,18 @@ static int smu_switch_power_profile(void *handle,
 	return 0;
 }
 
+static int smu_add_guard_band(void* handle, uint32_t gfx_gb,
+							  uint32_t soc_gb)
+{
+	struct smu_context *smu = handle;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
+		!smu->ppt_funcs->add_gb)
+		return -EOPNOTSUPP;
+
+	return smu->ppt_funcs->add_gb(smu, gfx_gb, soc_gb);
+}
+
 static enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 {
 	struct smu_context *smu = handle;
@@ -3637,6 +3649,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_pp_table            = smu_sys_get_pp_table,
 	.set_pp_table            = smu_sys_set_pp_table,
 	.switch_power_profile    = smu_switch_power_profile,
+	.add_guard_band    = smu_add_guard_band,
 	/* export to amdgpu */
 	.dispatch_tasks          = smu_handle_dpm_task,
 	.load_firmware           = smu_load_microcode,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b44a185d07e8..032f99c64a16 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1440,6 +1440,8 @@ struct pptable_funcs {
 	 */
 	int (*set_wbrf_exclusion_ranges)(struct smu_context *smu,
 					struct freq_band_range *exclusion_ranges);
+	int (*add_gb)(struct smu_context *smu, uint32_t gfx_gb,
+					uint32_t soc_gb);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 12a7b0634ed5..74709e2da853 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -275,7 +275,8 @@
 	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold),\
 	__SMU_DUMMY_MAP(SelectPstatePolicy), \
 	__SMU_DUMMY_MAP(MALLPowerController), \
-	__SMU_DUMMY_MAP(MALLPowerState),
+	__SMU_DUMMY_MAP(MALLPowerState), \
+	__SMU_DUMMY_MAP(UpdatePolicy),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index e000ac7b4c0e..40ea4c1d044f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -135,6 +135,7 @@ static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] =
 			    PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel,   0),
 	MSG_MAP(AllowIHHostInterrupt,		PPSMC_MSG_AllowIHHostInterrupt,       0),
 	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       0),
+	MSG_MAP(UpdatePolicy,		PPSMC_MSG_UpdatePolicy,       0),
 };
 
 static struct cmn2asic_mapping smu_v14_0_2_clk_map[SMU_CLK_COUNT] = {
@@ -2828,6 +2829,14 @@ static int smu_v14_0_2_set_power_limit(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v14_0_2_add_gb(struct smu_context* smu, uint32_t gfx_gb,
+							  uint32_t soc_gb) {
+	uint32_t param = (gfx_gb & 0xF) << 16 | (soc_gb & 0xF);
+
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_UpdatePolicy,
+					  param, NULL);
+}
+
 static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v14_0_2_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v14_0_2_set_default_dpm_table,
@@ -2902,6 +2911,7 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.gpo_control = smu_v14_0_gpo_control,
 #endif
 	.get_ecc_info = smu_v14_0_2_get_ecc_info,
+	.add_gb = smu_v14_0_2_add_gb,
 };
 
 void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

