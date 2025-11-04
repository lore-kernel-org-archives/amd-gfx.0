Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673C2CCFA00
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 06:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E612710E248;
	Tue,  4 Nov 2025 06:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5NWT8z9a";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 590A510E248
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 06:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pC5P6g6yeiAarKUJ6V3tIw1uiqC+OwYe0KdvqAKWwrC5shKuh3yBf8ON7PtCO5UFjpz4ieGSn63kfEGcu3uFZokekgH+KX9DVqX5v+zqRjBK9di4Rpl8zJDuD4n/nIkZpE/l9c2N0B1eIGueTXQgQngZhbi7WqgfTvAVfhIdUkjHaH7h/Ien9iXGHfDXyPZDDnsZbV57s/5kmNvu9xkEWlDxSwnYg5Az/Tx2S4tmFHO/xhuQcPXzETB7IwqoZ9v8e5Gvg0U0ZDWfVQ90xUKFTn4WbZIVhUVStyBLRzHg4fbohmSVmOoF6cqLAVeqfd44mvhXpe2ZjY92EebUlyHglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pwjnpc3B8usIsBLUcjR6ZBS26iWuE3DflrZc51L01tM=;
 b=KfpFUOHUOoGvKJ8UvOn67FvifANOeAaqjfcBPOWsZ552pg2y//xa5RFXidg8EJGxPcDZrJAb9TIyZb1JBEY2vqESRonQtr+7Zjes8ulbmPCdcF9QadPliar6tv++F4HSpPjmZjHet6CmxEGJ5/ZRhNAvlT8649MVkHZucu53udYptycBGx6l4M0Bhp76n7KbO/Ne/ecje7p7llkr4yPB/tlW3lY/HCu6wLQIMUAqHc7usdnAUrROq3JsIYpzbn01Fe5n3hKkarzXZzHfyvPq4mk4iXrmMooOEJ6Y0nWxCpM8vp0XTS0tGBSpgVoVlXSFL7rdhPI8dejD38JvDiYnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pwjnpc3B8usIsBLUcjR6ZBS26iWuE3DflrZc51L01tM=;
 b=5NWT8z9azmpvBBrkcszSiKZmRxLPpB9JmG+j9uskPQYXJwY3BvFBzkDxy22SGum4xeP7qhmJRCxb9VUJlJgI/DRzW3e0++En7Po9Dyqxqn2evcS/fuEgJMuxNZJhxMToFoxpV94ewg5yBtwVtOh3ToQ56hUSagNGDL/Y9A8du6A=
Received: from MN0P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::25)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 06:58:16 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::2a) by MN0P221CA0021.outlook.office365.com
 (2603:10b6:208:52a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 06:58:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:58:15 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Nov 2025 22:58:13 -0800
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH 02/10] drm/amd/pm: implement ras_smu_drv interface for smu
 v13.0.12
Date: Tue, 4 Nov 2025 14:57:37 +0800
Message-ID: <20251104065745.1737050-2-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104065745.1737050-1-ganglxie@amd.com>
References: <20251104065745.1737050-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: 09610cf4-0add-41f6-2d61-08de1b6f8704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KiQHDPjUftOaj1thrm40U33Io+2jfBQPQHe7c2J41zyeDAJmu2ArbY8QvjW3?=
 =?us-ascii?Q?VSUguptbadmD0hcKoqwpAcUOSyyjH65hZoIJOF8HM1TkNAtDyie2rHXWIStJ?=
 =?us-ascii?Q?gF/0PoN1zAdE+0t533sI2sF1BQxWsrUFrl76O30Y/GG5Pmacfp4c1VPWE3MO?=
 =?us-ascii?Q?U35voN70bY36XmsoYvlRD1Z+Zt4ARkcHQt2qr+r3cJMppHMr8xUV2sFpSTMA?=
 =?us-ascii?Q?1AXob36EWLzUi9zDGMulagQVhFfQ1+lowqrMu8bl/JB2x5joHDqd3IGlyP04?=
 =?us-ascii?Q?ZxQfboKB1qOI3bJ34notpMqItCt1F00Kbrn9xRzuxNTTRysv2rEvKrSp0Y6x?=
 =?us-ascii?Q?vPA0bdWI0DrnRLxNKqs0jkVYyVVj7bRVeDtehh6re+l3nmtfnYW4DcFw8qa/?=
 =?us-ascii?Q?hApPjw5m1MyzexDk2TPjP8LcRIN3KC4W0Fog2ZPpIVrp3eTbMDMuyX2PGSkA?=
 =?us-ascii?Q?wKabpv581hXywxuzaYlzIjtmM92Y6Bofu55BjNJgT89adT+LUJgwU0u0kUI5?=
 =?us-ascii?Q?1c7hi5RnCQoG094XBUBaek8pjLnitaEZIwbH/K2lEjcoC2Ljo+BRnbaLBGr3?=
 =?us-ascii?Q?QL1QpaeG9OrHO76TsIZFrzlF5CNkvvhgagmjnI80HF2oc3MXHlTE/OVKfjun?=
 =?us-ascii?Q?+YDraapHNG28kPCuJftyw/0U+pVAfijWV3FyhuH8/xYBBhn2JTWcbyszFpyK?=
 =?us-ascii?Q?kn2nmRqyfGuU4i382OuKK/WQwP1Rt3qYMH9eZOEmFSp0FZj3idbBf8yM70MB?=
 =?us-ascii?Q?dbo3Uwe6WOe0sp+Xc17hakN7vKCvVDDKMwBSmjSzCsapiuUTzlJKN0P20gTq?=
 =?us-ascii?Q?PJa8J68G4J15MHk60JTbZ9gMgX7JL3pYNNb9Y5lCny50V4FW9+nOUn+UBFWt?=
 =?us-ascii?Q?R+kQujSqNWdam1fAwonsMRHOoA3LSQ02JBU3wGzXRZLShYLXNb7o9gFBnf5t?=
 =?us-ascii?Q?7RiwgIDv1Bcx7KFkFmdELS7tqKnaHutv1pm0nayhsGTYFx0fOcln6XX24JUm?=
 =?us-ascii?Q?Fv+KqJizsYfdrA2vL9gNi7oYQ4gOxAu078NbF8B4paJlVTLd10SECpZ83SFZ?=
 =?us-ascii?Q?/SU17f57G0Z/oB9zfvrTweP6+42ObxrfGQwiuvaGeH4Ve/3V8qFWqz/gWaXN?=
 =?us-ascii?Q?WSS9uhIMiiyGCefM9oJPe5uSJvFZ0keLAcgmhZAk9rxsW55/6F3qbHZ4I4xQ?=
 =?us-ascii?Q?itnbexn7Y+zFqwLCFjHOe7p9GyCmEyd3lpF5/mmUdawyfnvBWq7t7fMgKu/4?=
 =?us-ascii?Q?PHcuP+JuUqJdCIcnBMUkVdaasIsyag95MDXh2ooaIO/qO4UMNlhhzxhj6QnS?=
 =?us-ascii?Q?LIw6XraHoyE4vOIe7p88xuuPb2+JoaqlR/64HHWKR9r8GPK+MwL9JAeIhnWo?=
 =?us-ascii?Q?gmrcSfqIss9HQckGN4qXsDp7ba1khvUIfRJa/32ImD6uCTOJONrnOPdVHRWv?=
 =?us-ascii?Q?y4HP0DJKo+ClGuqShWA7KkNlyIBfa+lJg9yk0M2VOFUv4giyMG7MUeVsY7Ge?=
 =?us-ascii?Q?uXso4z/6JzMj7kyq33Cw+aj08vf6hERYPuXOvsztLq4cmF6WE4d0bY05jx7w?=
 =?us-ascii?Q?zpaEjhO1+w6+Xyh0dOQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:58:15.3281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09610cf4-0add-41f6-2d61-08de1b6f8704
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
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

implement ras_smu_drv interface for smu v13.0.12

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  26 ++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 129 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |   1 +
 3 files changed, 156 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 40c0bf85f1d3..3c0b36dd37bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -503,6 +503,32 @@ struct ras_critical_region {
 	uint64_t size;
 };
 
+struct ras_eeprom_table_version {
+	uint32_t minor    : 16;
+	uint32_t major    : 16;
+};
+
+struct ras_eeprom_smu_funcs {
+	int (*get_ras_table_version)(struct amdgpu_device *adev,
+							uint32_t *table_version);
+	int (*get_badpage_count)(struct amdgpu_device *adev, uint32_t *count, uint32_t timeout);
+	int (*get_badpage_mca_addr)(struct amdgpu_device *adev, uint16_t index, uint64_t *mca_addr);
+	int (*set_timestamp)(struct amdgpu_device *adev, uint64_t timestamp);
+	int (*get_timestamp)(struct amdgpu_device *adev,
+							uint16_t index, uint64_t *timestamp);
+	int (*get_badpage_ipid)(struct amdgpu_device *adev, uint16_t index, uint64_t *ipid);
+	int (*erase_ras_table)(struct amdgpu_device *adev, uint32_t *result);
+};
+
+enum ras_smu_feature_flags {
+	RAS_SMU_FEATURE_BIT__RAS_EEPROM = BIT_ULL(0),
+};
+
+struct ras_smu_drv {
+	const struct ras_eeprom_smu_funcs *smu_eeprom_funcs;
+	void (*ras_smu_feature_flags)(struct amdgpu_device *adev, uint64_t *flags);
+};
+
 struct amdgpu_ras {
 	void *ras_mgr;
 	/* ras infrastructure */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index f2e3cae43fda..24aaef1494a4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -34,6 +34,7 @@
 #include "amdgpu_fru_eeprom.h"
 #include <linux/pci.h>
 #include "smu_cmn.h"
+#include "amdgpu_ras.h"
 
 #undef MP1_Public
 #undef smnMP1_FIRMWARE_FLAGS
@@ -925,3 +926,131 @@ const struct smu_temp_funcs smu_v13_0_12_temp_funcs = {
 	.temp_metrics_is_supported = smu_v13_0_12_is_temp_metrics_supported,
 	.get_temp_metrics = smu_v13_0_12_get_temp_metrics,
 };
+
+static int smu_v13_0_12_get_ras_table_version(struct amdgpu_device *adev,
+					      uint32_t *table_version)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetRASTableVersion, 0, table_version);
+}
+
+static int smu_v13_0_12_get_badpage_count(struct amdgpu_device *adev, uint32_t *count,
+					  uint32_t timeout)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint64_t end, now;
+	int ret = 0;
+
+	now = (uint64_t)ktime_to_ms(ktime_get());
+	end = now + timeout;
+	do {
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageCount, 0, count);
+		/* eeprom is not ready */
+		if (ret != -EBUSY)
+			return ret;
+		mdelay(10);
+		now = (uint64_t)ktime_to_ms(ktime_get());
+	} while (now < end);
+
+	return ret;
+}
+
+static int smu_v13_0_12_set_timestamp(struct amdgpu_device *adev, uint64_t timestamp)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_SetTimestamp, (uint32_t)timestamp, 0);
+}
+
+static int smu_v13_0_12_get_timestamp(struct amdgpu_device *adev,
+				      uint16_t index, uint64_t *timestamp)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t temp;
+	int ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetTimestamp, index, &temp);
+	if (!ret)
+		*timestamp = temp;
+
+	return ret;
+}
+
+static int smu_v13_0_12_get_badpage_ipid(struct amdgpu_device *adev,
+					 uint16_t index, uint64_t *ipid)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t temp_arg, temp_ipid_lo, temp_ipid_high;
+	int ret;
+
+	temp_arg = index | (1 << 16);
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_lo);
+	if (ret)
+		return ret;
+
+	temp_arg = index | (2 << 16);
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_high);
+	if (!ret)
+		*ipid = (uint64_t)temp_ipid_high << 32 | temp_ipid_lo;
+	return ret;
+}
+
+static int smu_v13_0_12_erase_ras_table(struct amdgpu_device *adev,
+					uint32_t *result)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_EraseRasTable, 0, result);
+}
+
+static int smu_v13_0_12_get_badpage_mca_addr(struct amdgpu_device *adev,
+					     uint16_t index, uint64_t *mca_addr)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t temp_arg, temp_addr_lo, temp_addr_high;
+	int ret;
+
+	temp_arg = index | (1 << 16);
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_lo);
+	if (ret)
+		return ret;
+
+	temp_arg = index | (2 << 16);
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_high);
+	if (!ret)
+		*mca_addr = (uint64_t)temp_addr_high << 32 | temp_addr_lo;
+	return ret;
+}
+
+static const struct ras_eeprom_smu_funcs smu_v13_0_12_eeprom_smu_funcs = {
+	.get_ras_table_version = smu_v13_0_12_get_ras_table_version,
+	.get_badpage_count = smu_v13_0_12_get_badpage_count,
+	.get_badpage_mca_addr = smu_v13_0_12_get_badpage_mca_addr,
+	.set_timestamp = smu_v13_0_12_set_timestamp,
+	.get_timestamp = smu_v13_0_12_get_timestamp,
+	.get_badpage_ipid = smu_v13_0_12_get_badpage_ipid,
+	.erase_ras_table = smu_v13_0_12_erase_ras_table,
+};
+
+static void smu_v13_0_12_ras_smu_feature_flags(struct amdgpu_device *adev, uint64_t *flags)
+{
+	if (!flags)
+		return;
+
+	*flags = 0ULL;
+}
+
+const struct ras_smu_drv smu_v13_0_12_ras_smu_drv = {
+	.smu_eeprom_funcs = &smu_v13_0_12_eeprom_smu_funcs,
+	.ras_smu_feature_flags = smu_v13_0_12_ras_smu_feature_flags,
+};
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index ba865ae7eca2..ecec7af8a64f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -105,6 +105,7 @@ int smu_v13_0_12_get_npm_data(struct smu_context *smu,
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
+extern const struct ras_smu_drv smu_v13_0_12_ras_smu_drv;
 
 #if defined(SWSMU_CODE_LAYER_L2)
 #include "smu_cmn.h"
-- 
2.34.1

