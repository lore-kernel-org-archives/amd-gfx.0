Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8F3C3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 13:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42541898F0;
	Mon,  8 Jul 2024 13:21:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GeXxw9tw";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01479898F0
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 13:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehpmbMPAa56Px+yGCfmAOJxY7uPZVjTNRCHnaothCL1l5BmRdyoI2unUhaMg5n/H6kw6nscwUe8G3oJEsDgB73MDwME4/illPy2aqEo5wBfKGBNbIhvGS6cnTgRdDUy4x4w4Ovy1aBcBpc4UNu/K2cud7bJyAZVFWwC8V3+jo2vbUTveookePt/PWWppwp49ucxXTS99Tb6jZwbzFbMFgUbd3MIIbk+TMglB4ntrdSFJ/pezwxeLPApH6LvO3A5wKXtpkCNA1tKSDRkl9Ozn/mejaW0zwKT5MAsQs85Yr6502L2wvFpgPS+vTighMHO1EtUrol+18he2kaPuH2gFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb7ZyhaM+AOO44Oy0VrRG3q+Ozxl5Trt9CyLJaPJaZY=;
 b=cgHeXSP+GOKt9e2imhzVfrJhOoGzch3Y0Dsd/mPJLo+eiQgobGl+nvoClI7jQaQCEv3PfiVvIR7plOc5kfPXvONwRt3Xjk+PTThfyiz6XZJ/G/3NHlCD/g3vciJRIFSrmMEiJbSjrVqV8MC1gS7pQScimSZoUWm3RNEKMYRxNCFAoIn0JbUIIiDBpvnseV5AcEhcmGQPpmwzKGgHLnah6TDefAQfKZ2fPWHuslNbJ6phZmwyM2gVS3u53ER1Em1ZnfYIEq71CnOaiiv6lcPYMPyrXAXzoO8lAwtJj/zl7IrVAod+NS1HYhpafnWZwKNUzCqFF3E6zQnnrWSshUZNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb7ZyhaM+AOO44Oy0VrRG3q+Ozxl5Trt9CyLJaPJaZY=;
 b=GeXxw9twCPNDHZwYzj6DerDhNygfaQHHsPWUt0/hyFbWeW/qDDVERl3Dl04ZSafUHLAQpBNVn7XuLCFXF44cpRY29uVXFt2SiN8RL38GCbM1SKtf47zBAxBXzEI8ee6dOCq1zQSyaKaURChIKpmmSX/YeGmLmp1KHndBBRo19Gk=
Received: from BN9PR03CA0124.namprd03.prod.outlook.com (2603:10b6:408:fe::9)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 13:21:42 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::e2) by BN9PR03CA0124.outlook.office365.com
 (2603:10b6:408:fe::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 13:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 13:21:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 08:21:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 08:21:41 -0500
Received: from sriov-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 8 Jul 2024 08:21:40 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Danijel Slivka <danijel.slivka@amd.com>
Subject: [PATCH v2] drm/amd/pm: Ignore initial value in smu response register
Date: Mon, 8 Jul 2024 15:31:06 +0200
Message-ID: <20240708133106.36933-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: b3615f34-8887-411b-732e-08dc9f50e873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZzK71qiAypo9w5qAYt8F/eyMQtwnHuSwtaY/9eE+VjgZqFFitOuDwdOOaxEE?=
 =?us-ascii?Q?PG3sbsqn2j6DicgJCC5JpfzIWFb9vJCOvzEkNwcIJfZouKygk+9hPl0Jd8Vk?=
 =?us-ascii?Q?bL+GyJwUYem9VVWD3OxTvu45w3O1g29zblA9ECM7oPHWOiisQAGOJwOxz4OW?=
 =?us-ascii?Q?sqvTyYHKqRa2FT9ssgl+5lzO/ITaOorkoBu2LBpPVdtickms2Tn/FeU5eyUD?=
 =?us-ascii?Q?gZ+sO8cp0uuuE2zTdEoBPpui0rkVbmn+sRGJXMnluc1sx0Dhn9RMJR6AZsyy?=
 =?us-ascii?Q?Q+1e24Yc5NtBktK6NXyoXpuQc6UUQrMz+7asB4HwAl02y7MR1PJLABMCyp2O?=
 =?us-ascii?Q?4vG111Xts1A2z6Ja2DMqbpf5L6U0B64VWiQQ4JtNgwlW9unmoiTmKN9qqCSr?=
 =?us-ascii?Q?e6AIlWchRC5a6r3aCC3Qxa0hm1dsO2anmUTGlJibYAyx10c0wGwNRWSIFNHY?=
 =?us-ascii?Q?JIVgxf7CDLBCmWnbpfVQ42tWoocHEf2HxCcTOkpzHbVW6+BUGS6wObVYjnuo?=
 =?us-ascii?Q?eZoEww/ZsISDkb/TXob5p1/HseYodwxwxQJU/a7YrzvoqoX8KxAPyPA1zMX3?=
 =?us-ascii?Q?UbHiri23YIcHIXW01n09IsXMkpkNW9BzH2NSrfWfotsgdqYgjptiFWOFttNH?=
 =?us-ascii?Q?I4qGv2IZwtvxzIeAiecWAuSp4VOiGTebU8cBdgehmwZcmyMDdntCZlnfFTRE?=
 =?us-ascii?Q?V0zgs9mQWklAaD4yhkynjAg3a/QvPe19WiIwF7n4s/yicIvoN/SbwoMI5ku4?=
 =?us-ascii?Q?4ii6r3VIjzGt8qCWeuvtg6fRVDq4axyoor1MtNPM4fMLbY+fr8MSDhJCMQ2h?=
 =?us-ascii?Q?t/UupkIqpKL7M0ZdUlHqb8r43hah4ZN152x71ntJEJEc1HJJ5E9lXWMXpxWQ?=
 =?us-ascii?Q?2wB8H7K/UOu24mZDTp7c287QD/7HDYHrs+dASSh0j+JxLG6fcdRxJqZWdmm1?=
 =?us-ascii?Q?DJSlI6jBp3FoPOfKCuDZx4DViUFDOHQnzF8LGyHalFd4ydjR2JqFSPOszHlk?=
 =?us-ascii?Q?HZfxdSb0QqA3di6Ai/BBrt3Qd6QFREjGQAX5jUOatQmbvaLVa6wwZB73hLge?=
 =?us-ascii?Q?NIKiNuOjKBWtBQC7hTN/Xd2MHZM7dcrMSaQV+uzqLN918xC9trf8bTPDJagv?=
 =?us-ascii?Q?i98dBuC9YSuIcES9wbCjztHky8mdiTjmblbOhyNTc0CRao0V0RYgNzQ8vqEf?=
 =?us-ascii?Q?HBnchjPQhpFLISJ78lD3kvdKtLqD5sKAz+gFYNgIf04vIrm00ukxmDH22WTK?=
 =?us-ascii?Q?DecoN9Egv3oHfcwFcMZY0nQsp5febWLU6Vkz+373KrpsTwKYmDi1yFC7B0rF?=
 =?us-ascii?Q?pwlwVJWN5zCYu8XwM9zP/Tgm5BZqwUovjO64pNwRMViDdM9uftO/CgJu1tYE?=
 =?us-ascii?Q?Hx7CRcgfa5zyGPsdk3YZFcO/VQpuhxut/z+DhBk6Ov1n4eb3iqN7IoB6kbMw?=
 =?us-ascii?Q?UhpgKbZv0o0I1jXQBm95Edf1buYGxE0z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 13:21:42.5223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3615f34-8887-411b-732e-08dc9f50e873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
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

Why:
If the reg mmMP1_SMN_C2PMSG_90 is being written to during amdgpu driver
load or driver unload, subsequent amdgpu driver load will fail at
smu_hw_init. The default of mmMP1_SMN_C2PMSG_90 register at a clean
environment is 0x1 and if value differs from expected, amdgpu driver
load will fail.

How to fix:
Ignore the initial value in smu response register before the first smu
message is sent,if smc in SMU_FW_INIT state, just proceed further to
send the message. If register holds an unexpected value after smu message
was sent set, smc_state to SMU_FW_HANG state and no further smu messages
will be sent.

v2:
Set SMU_FW_INIT state at the start of smu hw_init/resume.
Check smc_fw_state before sending smu message if in hang state skip
sending message.
Set SMU_FW_HANG only in case unexpected value is detected

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 34 ++++++++++++++++---
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d79bdb1e8cdf..fb8643d25d1b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1755,6 +1755,8 @@ static int smu_start_smc_engine(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	smu->smc_fw_state = SMU_FW_INIT;
+
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 		if (amdgpu_ip_version(adev, MP1_HWIP, 0) < IP_VERSION(11, 0, 0)) {
 			if (smu->ppt_funcs->load_microcode) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index a34c802f52be..b44a185d07e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -495,6 +495,12 @@ struct stb_context {
 	spinlock_t lock;
 };
 
+enum smu_fw_status {
+	SMU_FW_INIT = 0,
+	SMU_FW_RUNTIME,
+	SMU_FW_HANG,
+};
+
 #define WORKLOAD_POLICY_MAX 7
 
 /*
@@ -562,6 +568,7 @@ struct smu_context {
 	uint32_t smc_fw_if_version;
 	uint32_t smc_fw_version;
 	uint32_t smc_fw_caps;
+	uint8_t smc_fw_state;
 
 	bool uploading_custom_pp_table;
 	bool dc_controlled_by_gpio;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 5592fd825aa3..d7c983a1f3f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -315,11 +315,20 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 	if (adev->no_hw_access)
 		return 0;
 
-	reg = __smu_cmn_poll_stat(smu);
-	res = __smu_cmn_reg2errno(smu, reg);
-	if (reg == SMU_RESP_NONE ||
-	    res == -EREMOTEIO)
+	if (smu->smc_fw_state == SMU_FW_HANG) {
+		dev_err(adev->dev, "SMU is in hanged state, failed to send smu message!\n");
 		goto Out;
+	}
+
+	if (smu->smc_fw_state == SMU_FW_INIT) {
+		smu->smc_fw_state = SMU_FW_RUNTIME;
+	} else {
+		reg = __smu_cmn_poll_stat(smu);
+		res = __smu_cmn_reg2errno(smu, reg);
+		if (reg == SMU_RESP_NONE || res == -EREMOTEIO)
+			goto Out;
+	}
+
 	__smu_cmn_send_msg(smu, msg_index, param);
 	res = 0;
 Out:
@@ -350,6 +359,9 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
 	reg = __smu_cmn_poll_stat(smu);
 	res = __smu_cmn_reg2errno(smu, reg);
 
+	if (res == -EREMOTEIO)
+		smu->smc_fw_state = SMU_FW_HANG;
+
 	if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
 	    res && (res != -ETIME)) {
 		amdgpu_device_halt(smu->adev);
@@ -418,6 +430,15 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 			goto Out;
 	}
 
+	if (smu->smc_fw_state == SMU_FW_HANG) {
+		dev_err(adev->dev, "SMU is in hanged state, failed to send smu message!\n");
+		goto Out;
+	} else if (smu->smc_fw_state == SMU_FW_INIT) {
+		/* Ignore initial smu response register value */
+		poll = false;
+		smu->smc_fw_state = SMU_FW_RUNTIME;
+	}
+
 	if (poll) {
 		reg = __smu_cmn_poll_stat(smu);
 		res = __smu_cmn_reg2errno(smu, reg);
@@ -429,8 +450,11 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	__smu_cmn_send_msg(smu, (uint16_t) index, param);
 	reg = __smu_cmn_poll_stat(smu);
 	res = __smu_cmn_reg2errno(smu, reg);
-	if (res != 0)
+	if (res != 0) {
+		if (res == -EREMOTEIO)
+			smu->smc_fw_state = SMU_FW_HANG;
 		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
+	}
 	if (read_arg) {
 		smu_cmn_read_arg(smu, read_arg);
 		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x,\
-- 
2.34.1

