Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D865AC021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8190410EBF1;
	Fri, 14 Feb 2025 08:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BKsVb5Ej";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A6110EBED
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpyfQ9Mem0qIEaBNCsjnnIrtz+KB0riZM0NZAf8gzrbAgOoy2IOZNUr+To2gaVrAgsUH09ZztNCbuxvjvdzwefvLqLaAVKJlAWsw+lrw4lIyEtZpXeH287DZPfTz2wahyTA4QlQaD2ZZqz54vkeASMB62+1EmKZcOLOdF079MQPdTGaKcbq63613EPHVjBpeU0Irk/2ejL0QgU6Nx8a5CfZ4UAe7soFnd9sQVQ0xoUWQjhRKKTZZgNiJCAtcsu3KPnz1SSfruU0zGm0PrsyI18gRJtvs++Bpk6HDSZ8gUnirdD38/MtPg6eOFrLMFyZ7yrnYkF/SCir2xuzYxaHI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3dBk1c6yTijw+WbRN2l/PKwghcvXuU6eRcjU6JZTis=;
 b=p50WRygUlEz4wthmYx+nr5qg4rDf515HUGUfSGRUj5b0jE0XZmSZSkjAapRlPxHAEm6KMya9jtlXzdi8IGSna8ajZubA0z7YkgBLEmRnPEKdTLJuwJqZcRNr074AyZln1yF1F2A3FAhjTfG2LO81GX9ewlk6k4EpWZnap64bMRIL8KpTYJcVn4KvN9CDg6iqpKIrmw8/Pym3IZ07c+LtvDNxRbHmq+2T/UpoCui5ZGUtdyXyXk2uIgwRHWKWzZU4a/qQIlUbkkH1hEbBX73lNoSME4yUoYwVe6rd0kTmN3clr0o2koApofqLAWrcJ8m3NtZNeEkE/HduoglfLAH17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3dBk1c6yTijw+WbRN2l/PKwghcvXuU6eRcjU6JZTis=;
 b=BKsVb5EjpJSfU7Qs23UoBF0ogSx9KBfIyN9WTk6NvvrLvsfZBQu2Svh9uZu9mbnQ3wTrC5oyuu1pe9t1BsQCpUp67YcYZ8mnrBgjVUaPvKhukE6AELkuLYxsWQSXgxYSkCOA6eK2Zhy8dFTMcnCf3ARI/BT1Qb0Ea4sIrZuZW/Y=
Received: from BN1PR14CA0018.namprd14.prod.outlook.com (2603:10b6:408:e3::23)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.16; Fri, 14 Feb 2025 08:07:56 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::9) by BN1PR14CA0018.outlook.office365.com
 (2603:10b6:408:e3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 08:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 08:07:56 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 02:07:53 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu
 <xiang.liu@amd.com>, Yang Wang <keivnyang.wang@amd.com>
Subject: [PATCH v2 04/12] drm/amdgpu: Introduce funcs for generating cper
 record
Date: Fri, 14 Feb 2025 16:07:11 +0800
Message-ID: <72f60dbccd74c2e40d66f3d622b8a68c96e64c6a.1739519672.git.xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739519672.git.xiang.liu@amd.com>
References: <cover.1739519672.git.xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fa7ff0-5964-4e3a-3d33-08dd4cceb058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RBY3tjydrp9lQu8Pue3GFoB2abi3jHDwvIvtQa0E36tCYP9/ZbBIwKKv6WPw?=
 =?us-ascii?Q?YunoFsb3tBIbiYReMNtkUbbp/KyltamXedtfRqNVf3uenXvooCrxt5mAjhWc?=
 =?us-ascii?Q?W9XDszaFyCDd2j4e69N2uy5o2gVnlZIAh+KhqbdY51SD1LAgrmT2VbB7GO1G?=
 =?us-ascii?Q?AdZZahpu6djoc0HdzXw8UedAW7ZVz2udg4jg1v2wMLKgmKXJfEOIZjRBHTZs?=
 =?us-ascii?Q?FYmS6w1Iss1dwTsx5Jtw0MK2zQIv9lmw4L9+fNTyQTiz6xj/ECZBn08ZScQx?=
 =?us-ascii?Q?gV/fjyur69nLEngumpYn0sLXUGRIDm1CUkB1OYtw/HpTtpVnGq9fnlIQEqqX?=
 =?us-ascii?Q?YDfHs0nYxY/4nxqwzHlxjWTBay2t4wCT9Hy53BjcmPXb78XLoPdkoRkRfpqz?=
 =?us-ascii?Q?6qJFkbClQo4VSf71dyZLGzCk1jr7DpbTVmFydu6K8pRw1la/jKA0vNIas5Up?=
 =?us-ascii?Q?YHoASnLw4sHu/viTUoFxN9kZ5QOglJ4kf39jqLegOM2WHXdDrdfkReKh/9NT?=
 =?us-ascii?Q?SmHbcuww0eKplTbiyYpoMCnNgvkVtQsG75vUotSoRp+IXjbg96f5aJ3WZLXg?=
 =?us-ascii?Q?d2hPVxhKQjfyUBJDKuFhVbjFySHGHKj5b+ZtduZF0pDvQp3m+OUFIETuuCW4?=
 =?us-ascii?Q?zUIGfTpI5FXS5NIu17lfy4F3E1wYQMFtk+UDUiQrtILSlRR4kdxKN+YhtNDv?=
 =?us-ascii?Q?2Z1UNRSvQ/RPnylAhNn93dc9AOJgWWQaRos4YbpS/QJtd9Tl8ZNkZzMyAv91?=
 =?us-ascii?Q?OSda1iKL8WPfwxotPKEYzwSeLGU8RoPwjj0f0dhWBZIiJ8abGImnZjuvMBvd?=
 =?us-ascii?Q?MPoIav9dGlP3hnEyr8/0+1eeRbhv7S3gxdU343uiyyHAXUs5JY5J2A2t/Xqm?=
 =?us-ascii?Q?ZqWX9XetZGaf0ymsrkuPid8saBI9Lu+zDnRjukG+hnf2tO/WqLTg2gmGzTO+?=
 =?us-ascii?Q?xLQpZKAZoCwgjXEHM76SKGIxL+DXUs9uxcZ/Ti+dzjGEwXF76w8EMg+d1cCW?=
 =?us-ascii?Q?qR87rK2alCeyF211IQcZRpS04vFlo6dTiQcMEwjR7b7TUoorM3jcLFyYM5u5?=
 =?us-ascii?Q?uF/HajnQB7NzDXRf0i0EzB2VSUHlI6ovnvEWDo2MhSq5JWKtqtCmPAk+cNGj?=
 =?us-ascii?Q?Tf3ajX7sqqZvf2qjJwEbHRphVlIc9z8GwvCh0ke0oaaU01BKTsVBD4gvvZoV?=
 =?us-ascii?Q?QWKVQpWD5yRsUtn0q02f20xctmp9nP5bfJqBAKl7gPfRW2NmD0TqXUiOCnUO?=
 =?us-ascii?Q?sk4CP0Da/jFS9DZtyTQCjXLg6FibvtIaPB/OaPcAnSwSSaHsqK9ZpXF0Up7x?=
 =?us-ascii?Q?k51xJDHvaiG5/HMt3C/AKtGlkYanw5d/GrX93YqfzQee3JxrM9clXCo0/umt?=
 =?us-ascii?Q?unqSdRM5quRXHf/9Z6PKXUyGY7XK/lzQPYU7fK/vgyDjiTrLgnz80Z6U1dMX?=
 =?us-ascii?Q?VhKYs/3lJvYf9FkvsNXAQx/39e9kI9X6MJTCUK+q++OUk+cAtfizZSC5l4BZ?=
 =?us-ascii?Q?472uvwOGco53q9I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:07:56.1244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fa7ff0-5964-4e3a-3d33-08dd4cceb058
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Introduce new functions that are used to generate
cper ue or ce records.

v2: return -ENOMEM instead of false
v2: check return value of fill section function

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Yang Wang <keivnyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c  |  12 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h  |  12 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 108 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h |   9 +-
 4 files changed, 128 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 1a26b8ad14cb..ed1c20bd8114 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -30,16 +30,6 @@
 
 typedef int bank_handler_t(struct aca_handle *handle, struct aca_bank *bank, enum aca_smu_type type, void *data);
 
-struct aca_banks {
-	int nr_banks;
-	struct list_head list;
-};
-
-struct aca_hwip {
-	int hwid;
-	int mcatype;
-};
-
 static struct aca_hwip aca_hwid_mcatypes[ACA_HWIP_TYPE_COUNT] = {
 	ACA_BANK_HWID(SMU,	0x01,	0x01),
 	ACA_BANK_HWID(PCS_XGMI, 0x50,	0x00),
@@ -111,7 +101,7 @@ static struct aca_regs_dump {
 	{"STATUS",		ACA_REG_IDX_STATUS},
 	{"ADDR",		ACA_REG_IDX_ADDR},
 	{"MISC",		ACA_REG_IDX_MISC0},
-	{"CONFIG",		ACA_REG_IDX_CONFG},
+	{"CONFIG",		ACA_REG_IDX_CONFIG},
 	{"IPID",		ACA_REG_IDX_IPID},
 	{"SYND",		ACA_REG_IDX_SYND},
 	{"DESTAT",		ACA_REG_IDX_DESTAT},
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 3cd0115b0244..b84a3489b116 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -81,7 +81,7 @@ enum aca_reg_idx {
 	ACA_REG_IDX_STATUS		= 1,
 	ACA_REG_IDX_ADDR		= 2,
 	ACA_REG_IDX_MISC0		= 3,
-	ACA_REG_IDX_CONFG		= 4,
+	ACA_REG_IDX_CONFIG		= 4,
 	ACA_REG_IDX_IPID		= 5,
 	ACA_REG_IDX_SYND		= 6,
 	ACA_REG_IDX_DESTAT		= 8,
@@ -114,6 +114,11 @@ enum aca_smu_type {
 	ACA_SMU_TYPE_COUNT,
 };
 
+struct aca_hwip {
+	int hwid;
+	int mcatype;
+};
+
 struct aca_bank {
 	enum aca_error_type aca_err_type;
 	enum aca_smu_type smu_err_type;
@@ -125,6 +130,11 @@ struct aca_bank_node {
 	struct list_head node;
 };
 
+struct aca_banks {
+	int nr_banks;
+	struct list_head list;
+};
+
 struct aca_bank_info {
 	int die_id;
 	int socket_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 8ce5dc6efcf9..f82aa12a88f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -21,6 +21,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <linux/list.h>
 #include "amdgpu.h"
 
 static const guid_t MCE			= CPER_NOTIFY_MCE;
@@ -257,6 +258,113 @@ struct cper_hdr *amdgpu_cper_alloc_entry(struct amdgpu_device *adev,
 	return hdr;
 }
 
+int amdgpu_cper_generate_ue_record(struct amdgpu_device *adev,
+				   struct aca_bank *bank)
+{
+	struct cper_hdr *fatal = NULL;
+	struct cper_sec_crashdump_reg_data reg_data = { 0 };
+	int ret;
+
+	fatal = amdgpu_cper_alloc_entry(adev, AMDGPU_CPER_TYPE_FATAL, 1);
+	if (!fatal) {
+		dev_err(adev->dev, "fail to alloc cper entry for ue record\n");
+		return -ENOMEM;
+	}
+
+	reg_data.status_lo = lower_32_bits(bank->regs[ACA_REG_IDX_STATUS]);
+	reg_data.status_hi = upper_32_bits(bank->regs[ACA_REG_IDX_STATUS]);
+	reg_data.addr_lo   = lower_32_bits(bank->regs[ACA_REG_IDX_ADDR]);
+	reg_data.addr_hi   = upper_32_bits(bank->regs[ACA_REG_IDX_ADDR]);
+	reg_data.ipid_lo   = lower_32_bits(bank->regs[ACA_REG_IDX_IPID]);
+	reg_data.ipid_hi   = upper_32_bits(bank->regs[ACA_REG_IDX_IPID]);
+	reg_data.synd_lo   = lower_32_bits(bank->regs[ACA_REG_IDX_SYND]);
+	reg_data.synd_hi   = upper_32_bits(bank->regs[ACA_REG_IDX_SYND]);
+
+	amdgpu_cper_entry_fill_hdr(adev, fatal, AMDGPU_CPER_TYPE_FATAL, CPER_SEV_FATAL);
+	ret = amdgpu_cper_entry_fill_fatal_section(adev, fatal, 0, reg_data);
+	if (ret)
+		return ret;
+
+	/*TODO: commit the cper entry to cper ring */
+
+	return 0;
+}
+
+static enum cper_error_severity amdgpu_aca_err_type_to_cper_sev(struct amdgpu_device *adev,
+								enum aca_error_type aca_err_type)
+{
+	switch (aca_err_type) {
+	case ACA_ERROR_TYPE_UE:
+		return CPER_SEV_FATAL;
+	case ACA_ERROR_TYPE_CE:
+		return CPER_SEV_NON_FATAL_CORRECTED;
+	case ACA_ERROR_TYPE_DEFERRED:
+		return CPER_SEV_NON_FATAL_UNCORRECTED;
+	default:
+		dev_err(adev->dev, "Unknown ACA error type!\n");
+		return CPER_SEV_FATAL;
+	}
+}
+
+int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
+				    struct aca_banks *banks,
+				    uint16_t bank_count)
+{
+	struct cper_hdr *corrected = NULL;
+	enum cper_error_severity sev = CPER_SEV_NON_FATAL_CORRECTED;
+	uint32_t reg_data[CPER_ACA_REG_COUNT] = { 0 };
+	struct aca_bank_node *node;
+	struct aca_bank *bank;
+	uint32_t i;
+	int ret;
+
+	corrected = amdgpu_cper_alloc_entry(adev, AMDGPU_CPER_TYPE_RUNTIME, bank_count);
+	if (!corrected) {
+		dev_err(adev->dev, "fail to allocate cper entry for ce records\n");
+		return -ENOMEM;
+	}
+
+	/* Raise severity if any DE is detected in the ACA bank list */
+	list_for_each_entry(node, &banks->list, node) {
+		bank = &node->bank;
+		if (bank->aca_err_type == ACA_ERROR_TYPE_DEFERRED) {
+			sev = CPER_SEV_NON_FATAL_UNCORRECTED;
+			break;
+		}
+	}
+
+	amdgpu_cper_entry_fill_hdr(adev, corrected, AMDGPU_CPER_TYPE_RUNTIME, sev);
+
+	/* Combine CE and UE in cper record */
+	list_for_each_entry(node, &banks->list, node) {
+		bank = &node->bank;
+		reg_data[CPER_ACA_REG_CTL_LO]    = lower_32_bits(bank->regs[ACA_REG_IDX_CTL]);
+		reg_data[CPER_ACA_REG_CTL_HI]    = upper_32_bits(bank->regs[ACA_REG_IDX_CTL]);
+		reg_data[CPER_ACA_REG_STATUS_LO] = lower_32_bits(bank->regs[ACA_REG_IDX_STATUS]);
+		reg_data[CPER_ACA_REG_STATUS_HI] = upper_32_bits(bank->regs[ACA_REG_IDX_STATUS]);
+		reg_data[CPER_ACA_REG_ADDR_LO]   = lower_32_bits(bank->regs[ACA_REG_IDX_ADDR]);
+		reg_data[CPER_ACA_REG_ADDR_HI]   = upper_32_bits(bank->regs[ACA_REG_IDX_ADDR]);
+		reg_data[CPER_ACA_REG_MISC0_LO]  = lower_32_bits(bank->regs[ACA_REG_IDX_MISC0]);
+		reg_data[CPER_ACA_REG_MISC0_HI]  = upper_32_bits(bank->regs[ACA_REG_IDX_MISC0]);
+		reg_data[CPER_ACA_REG_CONFIG_LO] = lower_32_bits(bank->regs[ACA_REG_IDX_CONFIG]);
+		reg_data[CPER_ACA_REG_CONFIG_HI] = upper_32_bits(bank->regs[ACA_REG_IDX_CONFIG]);
+		reg_data[CPER_ACA_REG_IPID_LO]   = lower_32_bits(bank->regs[ACA_REG_IDX_IPID]);
+		reg_data[CPER_ACA_REG_IPID_HI]   = upper_32_bits(bank->regs[ACA_REG_IDX_IPID]);
+		reg_data[CPER_ACA_REG_SYND_LO]   = lower_32_bits(bank->regs[ACA_REG_IDX_SYND]);
+		reg_data[CPER_ACA_REG_SYND_HI]   = upper_32_bits(bank->regs[ACA_REG_IDX_SYND]);
+
+		ret = amdgpu_cper_entry_fill_runtime_section(adev, corrected, i,
+				amdgpu_aca_err_type_to_cper_sev(adev, bank->aca_err_type),
+				reg_data, CPER_ACA_REG_COUNT);
+		if (ret)
+			return ret;
+	}
+
+	/*TODO: commit the cper entry to cper ring */
+
+	return 0;
+}
+
 int amdgpu_cper_init(struct amdgpu_device *adev)
 {
 	mutex_init(&adev->cper.cper_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
index 0ae845420983..6860a809f2f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
@@ -26,6 +26,7 @@
 #define __AMDGPU_CPER_H__
 
 #include "amd_cper.h"
+#include "amdgpu_aca.h"
 
 #define CPER_MAX_ALLOWED_COUNT		0x1000
 #define HDR_LEN				(sizeof(struct cper_hdr))
@@ -84,7 +85,13 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(struct amdgpu_device *adev
 struct cper_hdr *amdgpu_cper_alloc_entry(struct amdgpu_device *adev,
 					 enum amdgpu_cper_type type,
 					 uint16_t section_count);
-
+/* UE must be encoded into separated cper entries, 1 UE 1 cper */
+int amdgpu_cper_generate_ue_record(struct amdgpu_device *adev,
+				   struct aca_bank *bank);
+/* CEs and DEs are combined into 1 cper entry */
+int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
+				    struct aca_banks *banks,
+				    uint16_t bank_count);
 int amdgpu_cper_init(struct amdgpu_device *adev);
 int amdgpu_cper_fini(struct amdgpu_device *adev);
 
-- 
2.34.1

