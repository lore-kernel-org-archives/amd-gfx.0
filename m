Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3867C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 03:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E2D610E0E0;
	Fri, 18 Jul 2025 03:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DBldXUq3";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B79410E0E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 03:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOtyibLYRv7hOnOA7uzRBqJ3IQdZx+GVV8vdBsByIlZFXgpoYoiNuiV4TxsVtMlKy6nKA2Pa6if1v2mJY1zcgx5wOkYMeR6xCqKWoH4uteWcwh5VEQOYgCSeTfqJJPmrjb5yPMyP3sY7XmzjIgKACeX8ttkxRlAg75W2SFsLknp4ycsEfS8j9hEyawbAHAWL/CA+Qalebw3qyqMC25t/cXazWyDEqyzXk2rY1qb0M4SEseK8R9RJqZIA2h9l8tYH7pQOy8iwjDJpTSvJoR12RS3y0G/VTZMx4xzZdn1SVVdMAhvYpIzMOm93T68n245Umc3WRoR5S1qBNuVe3bRv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wv/QgL43vREJh/4QYnWX8bsLGJgivcmLdSe525pra4g=;
 b=QhnNlDD723Jz5CVJlBa717IvBYnh07wPJqju/7n0ihEuNne65hVfUGd1rab5OrP2hggAVjcJpveAISE5Kd00C61xXxQssxG6OS/kg4Wf10Jq0TroNnhF00ayB8Zp286OAgQUYQFcxAWVh3NOhimSHUfb0tGViVBxj+aZ8uNF5hdcUNHh2Zrc4hwVH/RCnfXgEDIEbTXyaYa5/3tZT9Cn1ArkTdtUr0bBi27YU8DRdTjawccTyfWzabBhoeza8SnY7+JlgOKODQbWjvrikNcfRkMgoW8Y8FaewjCneTh0wDlFcXWN45EX+Dx1pTqbHT3zpCGOUMaUDrUEpdb/1g8CqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wv/QgL43vREJh/4QYnWX8bsLGJgivcmLdSe525pra4g=;
 b=DBldXUq3IK+JKFNqTJULXSd3Z/u7K2tYxahAjTW2JIoEAATQMU2jZs3zyMIGFAPeaH9wA+q1fBI60z/1YJdrh807sqWx0A3AKcrcX9FFwSUCyGdWyMoubRAKmRj/nEDekiyPHdL0kRFX7yCn8EO6ZQyuWDCDGjHdtttYEwTxrCA=
Received: from BN9PR03CA0707.namprd03.prod.outlook.com (2603:10b6:408:ef::22)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Fri, 18 Jul
 2025 03:26:40 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::e3) by BN9PR03CA0707.outlook.office365.com
 (2603:10b6:408:ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 03:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 03:26:39 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 22:26:37 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, "YiPeng
 Chai" <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amdgpu: add command to check address validity
Date: Fri, 18 Jul 2025 11:26:09 +0800
Message-ID: <20250718032609.1363340-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d9a440-62bb-4200-4b8b-08ddc5aae87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KIlyuX4vUXLO4UJURTgs0ZLblr4PHBuHYZEX0zvqbF02GYvU6Ihh/ntBrskE?=
 =?us-ascii?Q?/AttngobP4hqcA/PhCQPJcVCiP03Vz8tQIQr7d1MW/y0/giC7EIjx12EHVid?=
 =?us-ascii?Q?MxU78pR7J5iY6UhcE+HGvc5CGthA24G7IlIlmGjlrD++RbF/rbr2kIaqk0F6?=
 =?us-ascii?Q?PkqXhLEXbtP+SRRCpyjX5LoxGT1lkEaiHotTT28OluC27f3DlCE938p7Pqpz?=
 =?us-ascii?Q?lBWXT21RBffJ1mohDDFujMI2ot69F/qc0xkgBPZsqptuu/mytm6snLJ5dfTW?=
 =?us-ascii?Q?isPhZdI5krRCE0AaJvwMwM7J3r+CuEemsHk9lx9PS1eo/WI4APzwFbVt8ym9?=
 =?us-ascii?Q?K4288CHaAFYOGBXQdAdAqZTs8629LdkQbW9R7o5oL9bTJpON8nmNnyQpylWt?=
 =?us-ascii?Q?XR7MZ1i3XcWVDwuCz8UTADe5NeMS4jk4RR6xCnsTV/Sk+D29ZexIj/7TGRYE?=
 =?us-ascii?Q?Vgdqxlf8sMV/26PXa6/YH/7KJhavRLOLR8rbCiQ8gpPHYoyNPlQalACv2IDv?=
 =?us-ascii?Q?cZuaVMGim23B49ttdTBVifdye3HhQwEKowWh7xnPVkhWRHSepPlEM3CGR64c?=
 =?us-ascii?Q?MAqC1AH7kWTt6pe8LdIpl8Pher20WqI/x+jlE7YqvvFB2ddP/09UOPANw+IM?=
 =?us-ascii?Q?MZgmDYSHM09RXRuD/HwssJDLv8m7vRRAs8mqwy5mnS2GKPfAX4xQ9XLWvJBH?=
 =?us-ascii?Q?WENnirhHTi0JIuo2B/tTdD3FRU9a5+J1Wn71NYa7aznFnVh/HiZLOSap/rht?=
 =?us-ascii?Q?Uow3tQbuCBWksAY/Yprg5PA0BLKCYkjz0QB7hRqotvqeblD/AacA3xCiLHwy?=
 =?us-ascii?Q?lBIx9F1J4vajTCMkim6Gmpjjm5qmveMu18qMmu8YQ3Ozw/ZTaHrVRYMHFWRp?=
 =?us-ascii?Q?Uvk31/HshbuZ9WFsjR9ac/aBlLB+3X/afdT/G0XawUEaVjINUgTc+s/imGLe?=
 =?us-ascii?Q?0//qj2WoE1E3bT/RSF8KLQOsS6WuviaeRYFcF5lMl1Q+15TFRYv4TtBev6Gi?=
 =?us-ascii?Q?WigIux9nLC7oPG4FXdRsJHcRCv9aazO/hk+RyZV2yErQRWPPj/Ou151cFTuj?=
 =?us-ascii?Q?N3fWnuzxeKkImvWGVgcdvUI500DnDOwiq8ltTYRresJD/SKmEGLudF0r3b3f?=
 =?us-ascii?Q?ZN4/K900vfcS50WKI4mh6VjCuBlmigytzW/MS9LqC5XhRxfpI8cvAc5hBBIg?=
 =?us-ascii?Q?1lm96Xe1jAp1p0+RfpTjXUCmPsDRYVX/b+hXiusKbeK9lG8UKeLljNgojGKe?=
 =?us-ascii?Q?hxAMxtEaqhMEAPTvjf9lk4QOsmkz9JYQZ8m9c4MPny+/cL9TyD8tLzKcQa/r?=
 =?us-ascii?Q?b9455F3jyr9AzPqTP9oiDMXubIH+y/5FDbhraF9u005M1xMe4Yp7wW21ACBI?=
 =?us-ascii?Q?zmOOt46Kh2bflTd/M7COmiy5OEzE/W4qekYQy41rR+F8s5dvbsQECT7W+vyn?=
 =?us-ascii?Q?FwZH1QWTJT18SzwnjLtc1l1QRilZO3Yww68cN4taFck0wz9tgQ7s37JhYUVH?=
 =?us-ascii?Q?tZk664Jea7uICH7xXJIscDZDHUEz5duvaUfy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:26:39.1557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d9a440-62bb-4200-4b8b-08ddc5aae87b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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

Add command to check address validity and remove
unused command codes.

v2:
 The command interface adds new parameters to support
 multiple check address strategies.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 63 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 ++
 2 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 15bde4904996..185b9e538f98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -128,6 +128,9 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 
 #define MAX_FLUSH_RETIRE_DWORK_TIMES  100
 
+#define BYPASS_ALLOCATED_ADDRESS        0x0
+#define BYPASS_INITIALIZATION_ADDRESS   0x1
+
 enum amdgpu_ras_retire_page_reservation {
 	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 	AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -207,6 +210,49 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 	return 0;
 }
 
+static int amdgpu_check_address_validity(struct amdgpu_device *adev,
+			uint64_t address, uint64_t flags)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_vram_block_info blk_info;
+	uint64_t page_pfns[32] = {0};
+	int i, ret, count;
+
+	if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
+		return 0;
+
+	if ((address >= adev->gmc.mc_vram_size) ||
+	    (address >= RAS_UMC_INJECT_ADDR_LIMIT))
+		return -EFAULT;
+
+	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
+				address, page_pfns, ARRAY_SIZE(page_pfns));
+	if (count <= 0)
+		return -EPERM;
+
+	for (i = 0; i < count; i++) {
+		memset(&blk_info, 0, sizeof(blk_info));
+		ret = amdgpu_vram_mgr_query_address_block_info(&adev->mman.vram_mgr,
+					page_pfns[i] << AMDGPU_GPU_PAGE_SHIFT, &blk_info);
+		if (!ret) {
+			/* The input address that needs to be checked is allocated by
+			 * current calling process, so it is necessary to exclude
+			 * the calling process.
+			 */
+			if ((flags == BYPASS_ALLOCATED_ADDRESS) &&
+			    ((blk_info.task.pid != task_pid_nr(current)) ||
+				strncmp(blk_info.task.comm, current->comm, TASK_COMM_LEN)))
+				return -EACCES;
+			else if ((flags == BYPASS_INITIALIZATION_ADDRESS) &&
+				(blk_info.task.pid == con->init_task_pid) &&
+				!strncmp(blk_info.task.comm, con->init_task_comm, TASK_COMM_LEN))
+				return -EACCES;
+		}
+	}
+
+	return 0;
+}
+
 static ssize_t amdgpu_ras_debugfs_read(struct file *f, char __user *buf,
 					size_t size, loff_t *pos)
 {
@@ -297,6 +343,8 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 		op = 2;
 	else if (strstr(str, "retire_page") != NULL)
 		op = 3;
+	else if (strstr(str, "check_address") != NULL)
+		op = 4;
 	else if (str[0] && str[1] && str[2] && str[3])
 		/* ascii string, but commands are not matched. */
 		return -EINVAL;
@@ -310,6 +358,15 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 			data->op = op;
 			data->inject.address = address;
 
+			return 0;
+		} else if (op == 4) {
+			if (sscanf(str, "%*s 0x%llx 0x%llx", &address, &value) != 2 &&
+			    sscanf(str, "%*s %llu %llu", &address, &value) != 2)
+				return -EINVAL;
+
+			data->op = op;
+			data->inject.address = address;
+			data->inject.value = value;
 			return 0;
 		}
 
@@ -500,6 +557,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 			return size;
 		else
 			return ret;
+	} else if (data.op == 4) {
+		ret = amdgpu_check_address_validity(adev, data.inject.address, data.inject.value);
+		return ret ? ret : size;
 	}
 
 	if (!amdgpu_ras_is_supported(adev, data.head.block))
@@ -4103,6 +4163,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			goto release_con;
 	}
 
+	con->init_task_pid = task_pid_nr(current);
+	get_task_comm(con->init_task_comm, current);
+
 	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
 		 "hardware ability[%x] ras_mask[%x]\n",
 		 adev->ras_hw_enabled, adev->ras_enabled);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 927d6bff734a..7f10a7402160 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -570,6 +570,9 @@ struct amdgpu_ras {
 	struct ras_event_manager *event_mgr;
 
 	uint64_t reserved_pages_in_bytes;
+
+	pid_t init_task_pid;
+	char init_task_comm[TASK_COMM_LEN];
 };
 
 struct ras_fs_data {
-- 
2.34.1

