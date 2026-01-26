Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD5BC88E43
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E42E610E1C5;
	Mon, 26 Jan 2026 03:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V3XVOgZJ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012046.outbound.protection.outlook.com
 [40.93.195.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC6410E1C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhTnQWmILHpc0wxdcWLaDqvkasMzKLsmYz72/Ct2uGP8MPI+MwFTgOzh4UT4J3w5kwy5oQq23wBAN5e9+PlatcNl4oPyeX6gCS/l04xtbVZHkTC61QadvFgCEjEPtpJKTviOJFk1/iYmmz7mCftYbRtVZX1AcrCZElO2A3CvWfthfW1LDAW38gpXMVX4qc7vzkCyAOPXPezaxnxCaioM64b7TtUImRSM/jr7OIGpU6EZlgc/Xak+byPCVXpGUF6wla5yrs6a2dIgIl6Ww9UVh10y8Xh4d2c8qq+zGLB0/DW33Hp2lPiO1pMATJWEstqFEUqpByrBpihdl7OrCwKsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnMA5AoEwq/EW6u9CeWXMIlZw4aelPFw8qS8RvftlF4=;
 b=TaifMme8GM14hTDZZDZJ+DbDYv4psEA94Ddgwa6L+MHmPK0yMq59dlp0azSwKF1bpD3MiLl7JHhcInXumFZQq5aJbb+CcWDCNsxaZ2paH/SuqbT4+2O8y52kR/NwRC3dgBs6wuUZtGOBqzZ7Q5Jn0prMI3NcT6O7djFH/PmhFEafue1g3S6z4AZrx7fwrM4OyJvfZWb5/Opj1/9CX3zhbCArmHzdEesDz9Cox8TA219kmiz56ISYe7GO61RbYAcH+19n4WahdzD1KGyK2fR5dj5ekXNYg4VB000IbaKNd5s41qqBo/Fu+8kwElezJpY4QR0yqxPvXTuxR3zllc+LPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnMA5AoEwq/EW6u9CeWXMIlZw4aelPFw8qS8RvftlF4=;
 b=V3XVOgZJDcpBbOvaF10tPDWu5+2bjV6UOOIWAToOMsOp0NCVnvDgVplfVRkBTcrnyAlUn0tKqvOopugZZA+LFQ8BbnJbDii9ycIUMpH/EWO0q7Pnbf9VUk6thL4DkgsQRqcW4cFTgvXbdP2XbqHhe1iwUoE0fDDEr4fP94L6Vfc=
Received: from DS7PR03CA0199.namprd03.prod.outlook.com (2603:10b6:5:3b6::24)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 03:55:51 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::57) by DS7PR03CA0199.outlook.office365.com
 (2603:10b6:5:3b6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 26 Jan 2026 03:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:55:50 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:55:48 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 03/14] drm/amd/ras: add pmfw eeprom smu interfaces
Date: Mon, 26 Jan 2026 11:55:16 +0800
Message-ID: <20260126035527.1108488-3-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126035527.1108488-1-ganglxie@amd.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ad3e6b-d0db-45d6-2636-08de5c8ecbc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+L9bsBHcAhgy58bnSS7L4lk6uk4/2FDowqwIq2wfLU2ssWxRFWvpttcvSBsB?=
 =?us-ascii?Q?v3PJ3d1pFexecWvSg8AI0JXEpv/ya6wUJ/HalcD0QyiixAWu4MY8eKo0poY+?=
 =?us-ascii?Q?Mb/aJW7/N/gwZAzBwScbm/U/lgjXsMLOJ47vkKP+vXz+9Rol2FIHDm5b0UGb?=
 =?us-ascii?Q?J55DsQ8P7Lbvz/N5P7h/kR2AUvSiWPZcf31opvYzj0LVwyi6LDCyYAIYajFE?=
 =?us-ascii?Q?pKkuqR7+GmHrIegLK83w8bHWVnOxPnrlLkYWMn3XVw5HTBuUmyYAv085EIcO?=
 =?us-ascii?Q?Cj5e2LAiGxy072oSohV+j6pafZC3KEXpntGNJs6Km4K2hP/x0lZ7aAuTaHMG?=
 =?us-ascii?Q?vlKjfzpdcBe+3MQzWLQyXdbxrI+ZKLDj6qN+Y0acSwvjOUlw8FLN4AWoX3zT?=
 =?us-ascii?Q?KABf80NIdJgPLj9xOc09aRc6qEOTgG5tIxqEqVetCLo+zf3wSpAbGq1qKnaA?=
 =?us-ascii?Q?d/RXfMd8tMxrQWLB7mSZZKt/4oA127j57dSma3y4K8d+TLeieTyjKARsbP2k?=
 =?us-ascii?Q?dGMZcKou5rHZi8so2xobmIi4hQwK/NHOBBefQ+Oi/FmU/PoChs8J0OSqaE2e?=
 =?us-ascii?Q?L4jtXmRXbq+3vDXMrKkI3VjiNOgAXHz8A3wfQ52e4G04sCSpfeQlwiAaIHct?=
 =?us-ascii?Q?To9qB7Yzijl9gcqgw8XLJgi9UFxonKvjXo9oeYW0ktopSeeCNHPjM2i1LJLx?=
 =?us-ascii?Q?ndDwIIVJz2A9GvPJeoJJQz8ZijW1+0dGIOQOuxNeHjEbXnJhvkxP5KiiiXNC?=
 =?us-ascii?Q?R5pGK+/i0d8jaTC09Wxn31nqpS2/crHpjgaSmrtLaErIchceJElTm6h3us2B?=
 =?us-ascii?Q?1pluQTn2ch/wtU7dczCXrmTvABsbc6QKdoJdPHsHVUJXAiZeYa/oB8kNqeuI?=
 =?us-ascii?Q?lkoEJZCWAD3A4Dq6bb7OBPTijCeURjPbZkF+SJ6VUAaknhsjOOoObAtVsIM1?=
 =?us-ascii?Q?wVm/zaBMEyzsNi6rwIhwHO91Dgo9J+YC5OITcS3giXlQSDiTtYiv67UWoXEW?=
 =?us-ascii?Q?UZzD8qWCm1xQ4UqBypdaaE6ZV0MwldUTJ8qJbNYEohiKi/AfnHRBws1fpcL0?=
 =?us-ascii?Q?fxKBTlfVqJXhRNPGzk1vVthOr6PcUmcB5xxSdBfgnT/VCbLEbe0KFGKu0vtf?=
 =?us-ascii?Q?Br+8bR3LWjvFZcnvUSocX6cJyqx7GH2u9EZshj7ttq4ZklFAzLKxrg7hi0ok?=
 =?us-ascii?Q?qgawOkpxbetTw19nMv4ksel7eiAQAsq4tUsMPqgKeWaocJey2G4ewnZZhmRf?=
 =?us-ascii?Q?VoiULRLIGqWNed6v0Fr3cY+2BptRnV2aUd8HdtzQJEkVCxxvxim/YHtCX9ud?=
 =?us-ascii?Q?a3nxVZ1lp/21ZYpjxb2yzEw5Wo8jAPSbSkNyoRnaA/5/sO7wpO3XWSvglLqv?=
 =?us-ascii?Q?GD/LWSE/ShiGqZpaPoc6TVNR1/cRWSLPEFDQvVp0BECk5Iv2HwJM0Bb6DVdD?=
 =?us-ascii?Q?XXZGwz/Wq9Yx3LaqCv4x1tZhwhG+gAO/R78kB6JZUjl0RogAoN8IbL18mPOZ?=
 =?us-ascii?Q?dASHg3213ftyXQ3rYG7c/UehpaE3eL6ZXP5Vt1ZN9cqd5q0nmijlQfGtbnXR?=
 =?us-ascii?Q?X09smbSEQ1cAPlTgUsE5DBSPDGxMPn+k6gd6Yp7ISFDGHBGrph5F3eBSMZ8+?=
 =?us-ascii?Q?Mxbn7yL/MH2b0IIBLDh1liwVQ5TU9LOKc15duyF2Z+2nXiEMY6N7MEjpRpgi?=
 =?us-ascii?Q?Asvz/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:55:50.6634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ad3e6b-d0db-45d6-2636-08de5c8ecbc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF
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

add smu interfaces and its data structures for
pmfw eeprom in uniras

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c    | 46 +++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras.h         | 18 ++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
index 79a51b1603ac..03922aa03417 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
@@ -28,6 +28,16 @@
 #define RAS_MP1_MSG_QueryValidMcaCeCount  0x3A
 #define RAS_MP1_MSG_McaBankCeDumpDW       0x3B
 
+static enum smu_message_type pmfw_eeprom_msgs[] = {
+	SMU_MSG_GetRASTableVersion,
+	SMU_MSG_GetBadPageCount,
+	SMU_MSG_SetTimestamp,
+	SMU_MSG_GetTimestamp,
+	SMU_MSG_GetBadPageIpid,
+	SMU_MSG_EraseRasTable,
+	SMU_MSG_GetBadPageMcaAddr,
+};
+
 static int mp1_v13_0_get_valid_bank_count(struct ras_core_context *ras_core,
 					  u32 msg, u32 *count)
 {
@@ -87,8 +97,44 @@ static int mp1_v13_0_dump_valid_bank(struct ras_core_context *ras_core,
 	return ret;
 }
 
+static int mp1_v13_0_eeprom_send_msg(struct ras_core_context *ras_core,
+				enum ras_fw_eeprom_cmd index, uint32_t param, uint32_t *read_arg)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	int ret = 0;
+
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		ret = amdgpu_smu_ras_send_msg(adev,
+			pmfw_eeprom_msgs[index], param, read_arg);
+		up_read(&adev->reset_domain->sem);
+	} else {
+		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
+	}
+
+	return ret;
+}
+
+static int mp1_v13_0_get_ras_enabled_mask(struct ras_core_context *ras_core,
+					     uint64_t *enabled_mask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	int ret = 0;
+
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		if (amdgpu_smu_ras_feature_is_enabled(adev, SMU_FEATURE_HROM_EN_BIT))
+			*enabled_mask |= RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM;
+		up_read(&adev->reset_domain->sem);
+	} else {
+		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
+	}
+
+	return ret;
+}
+
 const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0 = {
 	.mp1_get_valid_bank_count = mp1_v13_0_get_valid_bank_count,
 	.mp1_dump_valid_bank = mp1_v13_0_dump_valid_bank,
+	.mp1_send_eeprom_msg = mp1_v13_0_eeprom_send_msg,
+	.mp1_get_ras_enabled_mask = mp1_v13_0_get_ras_enabled_mask,
 };
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 3396b2e0949d..2db838c444f1 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -49,6 +49,10 @@
 #define GPU_RESET_CAUSE_FATAL   (RAS_CORE_RESET_GPU | 0x0002)
 #define GPU_RESET_CAUSE_RMA     (RAS_CORE_RESET_GPU | 0x0004)
 
+enum ras_core_fw_feature_flags {
+	RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM = BIT_ULL(0),
+};
+
 enum ras_block_id {
 	RAS_BLOCK_ID__UMC = 0,
 	RAS_BLOCK_ID__SDMA,
@@ -127,6 +131,16 @@ enum ras_gpu_status {
 	RAS_GPU_STATUS__IS_VF = 0x8,
 };
 
+enum ras_fw_eeprom_cmd {
+	RAS_SMU_GetRASTableVersion = 0,
+	RAS_SMU_GetBadPageCount,
+	RAS_SMU_SetTimestamp,
+	RAS_SMU_GetTimestamp,
+	RAS_SMU_GetBadPageIpid,
+	RAS_SMU_EraseRasTable,
+	RAS_SMU_GetBadPageMcaAddr,
+};
+
 struct ras_core_context;
 struct ras_bank_ecc;
 struct ras_umc;
@@ -141,6 +155,10 @@ struct ras_mp1_sys_func {
 			u32 msg, u32 *count);
 	int (*mp1_dump_valid_bank)(struct ras_core_context *ras_core,
 			u32 msg, u32 idx, u32 reg_idx, u64 *val);
+	int (*mp1_send_eeprom_msg)(struct ras_core_context *ras_core,
+			enum ras_fw_eeprom_cmd index, uint32_t param, uint32_t *read_arg);
+	int (*mp1_get_ras_enabled_mask)(struct ras_core_context *ras_core,
+			uint64_t *enabled_mask);
 };
 
 struct ras_eeprom_sys_func {
-- 
2.34.1

