Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4183D73E86
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5774510E25B;
	Fri, 30 Jan 2026 02:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jws5ZG9M";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E095E10E1FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWCYLSs9dysWmzn9dMY8oRNHQjjRWY0tO8dCCTCn6IXhrDC1WGdbuu2rUV0QVQJn6K1wfbBKVlnt4yo5oyZbG8PZb0OjrsMocaVqP/pJAeId8BS05XiKL1cf+JSjZ/6fOAQCxSIawfzLu8kXuR/S4B9xRrRC84/Qw7zwEm3wcn1DIibOOoh4yMTNMqGRFnD7tBqMkvqBspV7ei1s+dAVHNhvh+RIMu+rEbVFygJpYNAxBE6r6TVIzW7ltqCFbjEysy7nSjOTy4I9pwIqWNWiL4MugCHz54ik6wAo9s53oYJfnM/c62ofv8rSmXwbG2FhK/ETmeUCpfatmbdQbGlpsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnMA5AoEwq/EW6u9CeWXMIlZw4aelPFw8qS8RvftlF4=;
 b=jZ0kLU8YuP+J1E3vQruHXQuYSggapDzc60jmEjnkgWR737f0xDKzI3neAvfvZm4x0M5Njo98uCuffJZmCXGidWdFQGbv4DGXXzIGIh/gz//CjXEjwBOEFFvEr1Q7vilbvNL1LBUrm7KgNjdH3YZ0LkUKSYnJ1ZXa3mGErn1ueFsAptbgD1hxEv0Pi90f4rjUtu+48bUxHR6EEiyfHqzLA1JKOUoSO1qUY5oVcUl2kuaXvRRfr3Ay7neaH9oOgPozSaG7KmgflKDWZKHvka2ACXhTZpr69Z7x13oWqNau+68RFX7Wx0xP2kVa/BugIiC2L9cH0sPZ882cbTpEOUbsuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnMA5AoEwq/EW6u9CeWXMIlZw4aelPFw8qS8RvftlF4=;
 b=Jws5ZG9MTIzm5B5IQkgBlBrYsTNvIHbG/JK/1s/Lfq9Jh36WVPHBL6YEgTbgS+/9EGcS9Z0IFQ1IuXnaHPXxUrLrg93YP4DgvAIX7U9Pm70AKeYqLlzK2O42F130U83wVAGxbmG90rxW7vBQOCb6jM7Dc1skKN+vtHujnb2F/so=
Received: from SJ0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:a03:39e::28)
 by CH1PR12MB9719.namprd12.prod.outlook.com (2603:10b6:610:2b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 02:30:22 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::1e) by SJ0PR03CA0293.outlook.office365.com
 (2603:10b6:a03:39e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Fri,
 30 Jan 2026 02:30:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:22 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:20 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 03/14] drm/amd/ras: add pmfw eeprom smu interfaces
Date: Fri, 30 Jan 2026 10:29:39 +0800
Message-ID: <20260130022950.1160058-3-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130022950.1160058-1-ganglxie@amd.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CH1PR12MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: a900e4ec-9503-4b7a-a536-08de5fa7848e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KmEtb+jCqVeIY1mjdGuA8s+Z5ZbAbdhKuhhUU6eqRj3S6SJ1uVuiU1wytKtT?=
 =?us-ascii?Q?UQDoz26paHEEBZYdPYnse8CNukpbMaoiphd+/2zQsVfDASiVZhodvB8/uSyq?=
 =?us-ascii?Q?xZCaAjUNTUiVrJII0rC/eXpXsjLC1FlcDejLgI5Xe5pCAC3fcfzpulXSFQVC?=
 =?us-ascii?Q?aQPNcRtOoNRKpZ8FME6CjdCQrj+0EfQk9gTe7mUCRshHj3BMijPqv/Df++ZI?=
 =?us-ascii?Q?DT6QTWX+3j6qsHQ93eJ1EwyO6aZwqpzbxdVB3HXhqh5uwF2AJqVSifDoahqs?=
 =?us-ascii?Q?akl1STgejlxYnfplozXLbZbv2cS7r4LxOSoEJ2VJjWU0fg0i0RhKe4ZfQ137?=
 =?us-ascii?Q?xMpm5SiQ8+Z/4FNrGSIGpnB4T14OhFryBS+rGrhYBQY49uI5XheQ4X3HAsfH?=
 =?us-ascii?Q?1v7x/jGX3X5KVfU78+xCFH3fxDa4mbBJiAG8VSVaaAGFn+bvbpWW7PMd/51X?=
 =?us-ascii?Q?TqsZQP/FlZ98qbYR1FD9B9LSrtqv3HbcNaFFX1sQlxhN/2Bh4ksPXA2QFldD?=
 =?us-ascii?Q?elxsGMjAmAneO27EsI9LhelVsI3tG6vhnGz502y+/QmaMyio/JPe0EIptjOL?=
 =?us-ascii?Q?uScPl/DtDlcqYZI0rJEvME3AzzQZCr5AvcSnFSxt+6aLkc0v3qj2LdwZY6mK?=
 =?us-ascii?Q?xA1UAbTWCOdSMR9+2mJDW9r/Qe/OrmuMjS6UETN0IyifNXyA3WN+FEx7G9B9?=
 =?us-ascii?Q?cVOE+jRNxxgLWzvsu+2YXXh+UehMbZ7YtgdczV41qhwB8PEp6V1BK/I9mXjR?=
 =?us-ascii?Q?8tsNPzdEGjmh+oTu9i7YGxBPaLLUhd9bXENvocFKG4QJH/hNfzaJk3e9NFCO?=
 =?us-ascii?Q?/hWQ5qmqpVD5wzLBCNjFaO+AoR49vOHBr2VqFk1EcwykLJJPcgf/+b03axpW?=
 =?us-ascii?Q?wXdu2zVvClhPIOH4KrMnoEWQeJJ1tutGpgAjrlcwjc7WuMSrhI6GO+xYSFI5?=
 =?us-ascii?Q?LsYgegjirIvCpHabxZPvBMLqBqk8+2G3iAK3atO/th7g+dqrhfo5W0GMlwJ8?=
 =?us-ascii?Q?vweF+QQC1HZT+ewoW4H9BXoje58kH/nOJoJfCT36n6fCVQLgE29FFNcvpi+M?=
 =?us-ascii?Q?SnHW08Im/ISxjqHsg6WSDTDQIkxyyYBEdlE3xaMVyFUs5Dn9TMDpoBaPLA3u?=
 =?us-ascii?Q?A18vr5jcSvzGKZ8QZH+4byybxuBdbn1G0yEawSSxLoxWvUcaE8k8G4tXbZ5m?=
 =?us-ascii?Q?UZHEnbRC7LFbwsXV25YODtCbtd6pkW9UNhX9Qf/5Qf//FOFVpPTnhzw16Wgl?=
 =?us-ascii?Q?E8hJ5tR/qp1ZpFtEc98rVzYGh46ECz+CpEnistVvceNe/SZiVN2rVyKeQcQc?=
 =?us-ascii?Q?+o+n0/81g3p7Dy3JbB7umgHhx9JvFnpKaw0A7NcXcpub9uapq+TzuAyEqEtz?=
 =?us-ascii?Q?gIv9o510jVCX/Czpilv5JfKirw6wuEN7uieAxFy6LIxUGBR9+xFztk7DDPI+?=
 =?us-ascii?Q?/ST12oJ/8RKVHqQX7njf3nqEbGeyUp05D+NI9TNe+vl1yhQ8ycWdSu0mHtzY?=
 =?us-ascii?Q?uqgQhSx9zzwxBOxWRqAxzYVuwWwZme8cJwvSN3Gpv8m2lLbzC5ZKgOQqFQj2?=
 =?us-ascii?Q?M6rI0cSPk/wVbyNw9l8SpGmnQzwNu9i2lklJrED8C2wGwXdV36btCz5ZxV51?=
 =?us-ascii?Q?bo7AB7Wjoo+8YdHbybr34m4ILIeD2nutUMDHMYWLC1voWp0IwfzcbuT64j5y?=
 =?us-ascii?Q?PdHuBg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8Mb1jIhfZOqNyGCV0Evc0VS6ea42jglbd1xXLydgmmkWXyqYCOmzt5eNY6Odh5jAAf5IXypVszaNIbC1QsKwi2XqGPSwIfBUcTD8JdAJ0QichJ8R0zg1/oNnsEywRCRPi3RCOqwxkYXDBkMod1EOwtnV6ozVXJhS3QSp4spP+qHQSsNiu6RzkEa5Ow5L9usvv/18vG9R8BbFLQza6301iZAfvK6095cU9TYUUoj3PyZzFeCQ3X0nqdFrXCvsjMajoU+e+sM8p5tqVOw767lkuNlwgBWLjSeCByAql1eRczBATyWsbfGwiJnWrOfG+KmCy5piEA6bYqZ0ah/lPSqwMvcxSJtjv/6dCzXjOX/SkGqrBL3cOfx/dwD32U9Iym7wqi4JARPLocCOTLCFdPcZonExLRLMPkz0pQuyUW174asEq1SWQHJDBVCg2bweGDT2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:22.0216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a900e4ec-9503-4b7a-a536-08de5fa7848e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9719
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

