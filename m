Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E934CCAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F76610E5FB;
	Thu, 18 Sep 2025 01:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="39dLgk8d";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D254810E5FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6SJkD73V3/RuucCeqibwX8VINGMKEOXe9VFvvpBUepecVi4NGz6jlHAcFVbxD/0bx7odmTZ3Kgrd49vXijLPbTE6HQHh3Q2JaJPWE1ZwAGOR0bJKlMggywGt9ePUkPh2aQmPj6/L3xeMuCFeD+1eW9iAH9WUYVQsMqaAUXFPAuy+T9CjUptpVasg+t2PxWbIBUALXXdOI1IIPIK+URUXze7iJZBFKip5oHM3yjkdiMKgcOKRoIvX6WOiKjuFioesHQmGak3txsqTy9mDNNh9Sr5WAMSUaXN4ed0L65AlFJMoygN2baVHNKh+8JKMbak3O90ZgbKJSqYsxCC472yNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o16hUnxk0lnbdjEA6uuW8Q1FM3G7PmoPxcnQhZT4IJ4=;
 b=hzLWl8rpnEBxs3LjDn7nnNNWxSrfqhTUA0QmQePr/GNx0O/iAS+0fmgGwwBfRrJqnZyFU7xNBOfR6TeR37V/AFOlALPZbYbWHFSZVjMm+mLYmx/8gHKH5JLkO9yILJyqmdEI+q+8QayLpbdLc5s+MYuUE44DnZVRPdb27wPjTbq2IamwMuBTEmPcKL541dN993cwrC1EqA+KcC0/QfVIWGKCjROWUJMjDqBVe6HCw0aWB7zMkWPmH0XbmwtyBvZzUzlByWLvm9hX2joe8zSVIa5JkRIzvjhCxV0/mKDRPL6tvwVjX0u89v5tuGBP+AYBXK3jTbPBEdZq5XY2YJWexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o16hUnxk0lnbdjEA6uuW8Q1FM3G7PmoPxcnQhZT4IJ4=;
 b=39dLgk8dIfJQGyIJcuHO4gADc5odm7GGU0w63z5SF7Cp0xYFVCTPE6RFV2makB5qERS4fcqsrwXnpphNo4kkqNORvEVk2j9ASjayXwyopHLNQIVSiUKAXTqPd6PfVPliHFLb0+Tn2fm4BvRZ5SoqwV+zWeyuIiA16pymIHCl+yA=
Received: from SA1PR02CA0008.namprd02.prod.outlook.com (2603:10b6:806:2cf::13)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 01:36:52 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::24) by SA1PR02CA0008.outlook.office365.com
 (2603:10b6:806:2cf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 01:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:36:52 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:36:49 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 05/10] drm/amd/ras: Amdgpu handle ras ioctl command
Date: Thu, 18 Sep 2025 09:35:02 +0800
Message-ID: <20250918013507.2629620-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e93e40-9037-4bc0-03c2-08ddf653d803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?znyGtYqCuF8OIXPXALWkjDNNcZ18T1WHQUY3Kk7K0wttDP98CGFnYD4s91n/?=
 =?us-ascii?Q?YKik1D4MC87PoBJCe69iJsJd7PBUrXUDvUadZgXk+muvJog4L7WcRwtSSw/g?=
 =?us-ascii?Q?cQv6uIlk9lY128IfNKcqidSV5VZ5eJtjDDIUsXxFYQKan+PALsr4xunFGRvK?=
 =?us-ascii?Q?HOFE8Mlnzt9r738aQxe57TIOuJ3PDBEKfvYsOKpYlyzDZ5cV1moZbFITJLNy?=
 =?us-ascii?Q?PLzQ1TlKzlcyZ6d5kQ5qepdAOMhgedSzdEMRZ3ka/8TRDvm3Cl7h2CXSdrhP?=
 =?us-ascii?Q?k/BhtPxrcrJTptfU8SVDD4E0H0Gji4iz5nbzyzIFDOkYlOzxh4oMsWzCjLa5?=
 =?us-ascii?Q?Gg6YkUDEXF6BZHIpqmd4HcDgiZVK7uL8vwbAb4zB2WSWfdipnqLrizt4TF9J?=
 =?us-ascii?Q?sCnhCmdDNsXnECAJ/xFxVImRvi7hbRAq9HfWw4d72KuuRcgal++yXBktjImh?=
 =?us-ascii?Q?tyytHFo4s4MPg44OmRve8aqm+CL/MLC8VfSVfg0gPK+eokAZ31OnYVd1v+5y?=
 =?us-ascii?Q?iaq6Jou4lw+90V2PidwvnI0aiOtAw1Q0WdGIAooVPuwshDfjHN4sffkE67bI?=
 =?us-ascii?Q?AWft997K8kKqjf2mT3B9vft3bOPCz9VofGqkhUk6EIFw48aG4WDGtBB2MBXv?=
 =?us-ascii?Q?EPE+VEcELWSHLD0sECKNJW1q02H8V3SdXsiRFv/+BnU7VSczuNNu1CJBeoy8?=
 =?us-ascii?Q?1YIhRgTq4ovXwHHoEpTniYAz3p982DS5+aXC0VB1bvplh/8tKY5xsL9BslAe?=
 =?us-ascii?Q?TPETbE9ZGIaDwS/xmTG3zUWVsT/O/UGr3as3amA2DvgtiPtj2Hd3FYRp8H1+?=
 =?us-ascii?Q?oX6cyRLv3VvfeeywUrGOAvMQx2XuEeStTMcAaYZpMtUacPmehKH9WMu3pHF5?=
 =?us-ascii?Q?+d0ty47JohQ5A8I8juMkvpLuk4PE8J+ZU+vRoQ15D9Za8FLUVZNR6dPyh/nk?=
 =?us-ascii?Q?IhGQFvUYgkP7rhSCzHGiX6jQNnC0J/UZCIF41G0g0mPNvRvxj8fOgNfdrW1H?=
 =?us-ascii?Q?RtU+P2JCR74c1ehksga62Zswu7bNvaH6etYoFU5uK9TR+YVNnoUJT4hgvmaQ?=
 =?us-ascii?Q?QQcjwedWxjDNMXNTgPwTvSrRt7I+z+s077lLeuSlJSC7LZLO6riLW0RAmHAB?=
 =?us-ascii?Q?RGPuPUHGqOdlR6qI72v9tklQU0i5E3GxN/ZjqN2ovXOK04gXsc4GDPrx2ks9?=
 =?us-ascii?Q?9Usly6/dCNJbeFgfjD5Dlh/+gEndSm6wj2rrZoyAwH4j+h6WpQUhEaBOCfzk?=
 =?us-ascii?Q?efB8YDgudIejC8S2I0RjIjTgTg40NlLV20defdH02HrOZ/m5dZm/nl4YbGLZ?=
 =?us-ascii?Q?NPNLOAHZmXHnnPava+5DWYjEeiDFEqVU/eGCLQPX1S/3d54PgeVkW+dwFy4q?=
 =?us-ascii?Q?iAn3LVNdEjbowJChXvKGyLoMI9ZWDTyjC7o4YTEdmZloZyiYWf9ydKzusjzT?=
 =?us-ascii?Q?BY7+6gAe/Wjg7+xb4rCshljMDr3GTmLrRiJEsOW7upQXb3UVhMaVHVh462Ra?=
 =?us-ascii?Q?87lt/KftJWPEOF0h8B7l+7+lPRHMOUDEy4Ii?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:36:52.2628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e93e40-9037-4bc0-03c2-08ddf653d803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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

Amdgpu handle ras ioctl command.

V2:
  Remove non-standard device information.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  | 363 ++++++++++++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h  |  55 +++
 2 files changed, 418 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
new file mode 100644
index 000000000000..195ca51a96d5
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include <linux/pci.h>
+#include "amdgpu.h"
+#include "amdgpu_ras.h"
+#include "ras_sys.h"
+#include "amdgpu_ras_cmd.h"
+#include "amdgpu_ras_mgr.h"
+
+/* inject address is 52 bits */
+#define	RAS_UMC_INJECT_ADDR_LIMIT	(0x1ULL << 52)
+
+#define AMDGPU_RAS_TYPE_RASCORE  0x1
+#define AMDGPU_RAS_TYPE_AMDGPU   0x2
+#define AMDGPU_RAS_TYPE_VF       0x3
+
+static int amdgpu_ras_query_interface_info(struct ras_core_context *ras_core,
+			struct ras_cmd_ioctl *cmd)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct ras_query_interface_info_rsp *output_data =
+		(struct ras_query_interface_info_rsp *)cmd->output_buff_raw;
+	int ret;
+
+	if (cmd->input_size != sizeof(struct ras_query_interface_info_req))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	ret = ras_cmd_query_interface_info(ras_core, output_data);
+	if (!ret) {
+		output_data->plat_major_ver = 0;
+		output_data->plat_minor_ver = 0;
+
+		output_data->interface_type = amdgpu_sriov_vf(adev) ?
+			RAS_CMD_INTERFACE_TYPE_VF : RAS_CMD_INTERFACE_TYPE_AMDGPU;
+
+		cmd->output_size = sizeof(struct ras_query_interface_info_rsp);
+	}
+
+	return ret;
+}
+
+static struct ras_core_context *ras_cmd_get_ras_core(uint64_t dev_handle)
+{
+	struct ras_core_context *ras_core;
+
+	if (!dev_handle || (dev_handle == RAS_CMD_DEV_HANDLE_MAGIC))
+		return NULL;
+
+	ras_core = (struct ras_core_context *)(dev_handle ^ RAS_CMD_DEV_HANDLE_MAGIC);
+
+	if (ras_cmd_get_dev_handle(ras_core) == dev_handle)
+		return ras_core;
+
+	return NULL;
+}
+
+static int amdgpu_ras_get_devices_info(struct ras_core_context *ras_core,
+			struct ras_cmd_ioctl *cmd)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct ras_cmd_devices_info_rsp *output_data =
+			(struct ras_cmd_devices_info_rsp *)cmd->output_buff_raw;
+	struct ras_cmd_dev_info *dev_info;
+
+	dev_info = &output_data->devs[0];
+	dev_info->dev_handle = ras_cmd_get_dev_handle(ras_core);
+	dev_info->oam_id = adev->smuio.funcs->get_socket_id(adev);
+	dev_info->ecc_enabled = 1;
+	dev_info->ecc_supported = 1;
+
+	output_data->dev_num = 1;
+	output_data->version = 0;
+	cmd->output_size = sizeof(struct ras_cmd_devices_info_rsp);
+
+	return 0;
+}
+
+static int amdgpu_ras_trigger_error_prepare(struct ras_core_context *ras_core,
+			struct ras_cmd_inject_error_req *block_info)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	int ret;
+
+	if (block_info->block_id == TA_RAS_BLOCK__XGMI_WAFL) {
+		if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+			RAS_DEV_WARN(adev, "Failed to disallow df cstate");
+
+		ret = amdgpu_dpm_set_pm_policy(adev, PP_PM_POLICY_XGMI_PLPD, XGMI_PLPD_DISALLOW);
+		if (ret && (ret != -EOPNOTSUPP))
+			RAS_DEV_WARN(adev, "Failed to disallow XGMI power down");
+	}
+
+	return 0;
+}
+
+static int amdgpu_ras_trigger_error_end(struct ras_core_context *ras_core,
+			struct ras_cmd_inject_error_req *block_info)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	int ret;
+
+	if (block_info->block_id == TA_RAS_BLOCK__XGMI_WAFL) {
+		if (amdgpu_ras_intr_triggered())
+			return 0;
+
+		ret = amdgpu_dpm_set_pm_policy(adev, PP_PM_POLICY_XGMI_PLPD, XGMI_PLPD_DEFAULT);
+		if (ret && (ret != -EOPNOTSUPP))
+			RAS_DEV_WARN(adev, "Failed to allow XGMI power down");
+
+		if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
+			RAS_DEV_WARN(adev, "Failed to allow df cstate");
+	}
+
+	return 0;
+}
+
+static uint64_t local_addr_to_xgmi_global_addr(struct ras_core_context *ras_core,
+					   uint64_t addr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct amdgpu_xgmi *xgmi = &adev->gmc.xgmi;
+
+	return (addr + xgmi->physical_node_id * xgmi->node_segment_size);
+}
+
+static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
+			struct ras_cmd_ioctl *cmd, void *data)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct ras_cmd_inject_error_req *req =
+		(struct ras_cmd_inject_error_req *)cmd->input_buff_raw;
+	int ret = RAS_CMD__ERROR_GENERIC;
+
+	if (req->block_id == RAS_BLOCK_ID__UMC) {
+		if (amdgpu_ras_mgr_check_retired_addr(adev, req->address)) {
+			RAS_DEV_WARN(ras_core->dev,
+				"RAS WARN: inject: 0x%llx has already been marked as bad!\n",
+				req->address);
+			return RAS_CMD__ERROR_ACCESS_DENIED;
+		}
+
+		if ((req->address >= adev->gmc.mc_vram_size &&
+			adev->gmc.mc_vram_size) ||
+			(req->address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
+			RAS_DEV_WARN(adev, "RAS WARN: input address 0x%llx is invalid.",
+					req->address);
+			return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+		}
+
+		/* Calculate XGMI relative offset */
+		if (adev->gmc.xgmi.num_physical_nodes > 1 &&
+			req->block_id != RAS_BLOCK_ID__GFX) {
+			req->address = local_addr_to_xgmi_global_addr(ras_core, req->address);
+		}
+	}
+
+	amdgpu_ras_trigger_error_prepare(ras_core, req);
+	ret = rascore_handle_cmd(ras_core, cmd, data);
+	amdgpu_ras_trigger_error_end(ras_core, req);
+	if (ret) {
+		RAS_DEV_ERR(adev, "ras inject block %u failed %d\n", req->block_id, ret);
+		ret = RAS_CMD__ERROR_ACCESS_DENIED;
+	}
+
+
+	return ret;
+}
+
+static int amdgpu_ras_get_ras_safe_fb_addr_ranges(struct ras_core_context *ras_core,
+	struct ras_cmd_ioctl *cmd, void *data)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct ras_cmd_dev_handle *input_data =
+			(struct ras_cmd_dev_handle *)cmd->input_buff_raw;
+	struct ras_cmd_ras_safe_fb_address_ranges_rsp *ranges =
+			(struct ras_cmd_ras_safe_fb_address_ranges_rsp *)cmd->output_buff_raw;
+	struct amdgpu_mem_partition_info *mem_ranges;
+	uint32_t i = 0;
+
+	if (cmd->input_size != sizeof(*input_data))
+		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+
+	mem_ranges = adev->gmc.mem_partitions;
+	for (i = 0; i < adev->gmc.num_mem_partitions; i++) {
+		ranges->range[i].start = mem_ranges[i].range.fpfn << AMDGPU_GPU_PAGE_SHIFT;
+		ranges->range[i].size = mem_ranges[i].size;
+		ranges->range[i].idx = i;
+	}
+
+	ranges->num_ranges = adev->gmc.num_mem_partitions;
+
+	ranges->version = 0;
+	cmd->output_size = sizeof(struct ras_cmd_ras_safe_fb_address_ranges_rsp);
+
+	return RAS_CMD__SUCCESS;
+}
+
+static int ras_translate_fb_address(struct ras_core_context *ras_core,
+		enum ras_fb_addr_type src_type,
+		enum ras_fb_addr_type dest_type,
+		union ras_translate_fb_address *src_addr,
+		union ras_translate_fb_address *dest_addr)
+{
+	uint64_t soc_phy_addr;
+	int ret = RAS_CMD__SUCCESS;
+
+	/* Does not need to be queued as event as this is a SW translation */
+	switch (src_type) {
+	case RAS_FB_ADDR_SOC_PHY:
+		soc_phy_addr = src_addr->soc_phy_addr;
+		break;
+	case RAS_FB_ADDR_BANK:
+		ret = ras_cmd_translate_bank_to_soc_pa(ras_core,
+					src_addr->bank_addr, &soc_phy_addr);
+		if (ret)
+			return RAS_CMD__ERROR_GENERIC;
+		break;
+	default:
+		return RAS_CMD__ERROR_INVALID_CMD;
+	}
+
+	switch (dest_type) {
+	case RAS_FB_ADDR_SOC_PHY:
+		dest_addr->soc_phy_addr = soc_phy_addr;
+		break;
+	case RAS_FB_ADDR_BANK:
+		ret = ras_cmd_translate_soc_pa_to_bank(ras_core,
+				soc_phy_addr, &dest_addr->bank_addr);
+		if (ret)
+			return RAS_CMD__ERROR_GENERIC;
+		break;
+	default:
+		return RAS_CMD__ERROR_INVALID_CMD;
+	}
+
+	return ret;
+}
+
+static int amdgpu_ras_translate_fb_address(struct ras_core_context *ras_core,
+				struct ras_cmd_ioctl *cmd, void *data)
+{
+	struct ras_cmd_translate_fb_address_req *req_buff =
+			(struct ras_cmd_translate_fb_address_req *)cmd->input_buff_raw;
+	struct ras_cmd_translate_fb_address_rsp *rsp_buff =
+			(struct ras_cmd_translate_fb_address_rsp *)cmd->output_buff_raw;
+	int ret = RAS_CMD__ERROR_GENERIC;
+
+	if (cmd->input_size != sizeof(struct ras_cmd_translate_fb_address_req))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	if ((req_buff->src_addr_type >= RAS_FB_ADDR_UNKNOWN) ||
+	    (req_buff->dest_addr_type >= RAS_FB_ADDR_UNKNOWN))
+		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+
+	ret = ras_translate_fb_address(ras_core, req_buff->src_addr_type,
+			req_buff->dest_addr_type, &req_buff->trans_addr, &rsp_buff->trans_addr);
+	if (ret)
+		return RAS_CMD__ERROR_GENERIC;
+
+	rsp_buff->version = 0;
+	cmd->output_size = sizeof(struct ras_cmd_translate_fb_address_rsp);
+
+	return RAS_CMD__SUCCESS;
+}
+
+static struct ras_cmd_func_map amdgpu_ras_cmd_maps[] = {
+	{RAS_CMD__INJECT_ERROR, amdgpu_ras_inject_error},
+	{RAS_CMD__GET_SAFE_FB_ADDRESS_RANGES, amdgpu_ras_get_ras_safe_fb_addr_ranges},
+	{RAS_CMD__TRANSLATE_FB_ADDRESS, amdgpu_ras_translate_fb_address},
+};
+
+int amdgpu_ras_handle_cmd(struct ras_core_context *ras_core, struct ras_cmd_ioctl *cmd, void *data)
+{
+	struct ras_cmd_func_map *ras_cmd = NULL;
+	int i, res;
+
+	for (i = 0; i < ARRAY_SIZE(amdgpu_ras_cmd_maps); i++) {
+		if (cmd->cmd_id == amdgpu_ras_cmd_maps[i].cmd_id) {
+			ras_cmd = &amdgpu_ras_cmd_maps[i];
+			break;
+		}
+	}
+
+	if (ras_cmd)
+		res = ras_cmd->func(ras_core, cmd, NULL);
+	else
+		res = RAS_CMD__ERROR_UKNOWN_CMD;
+
+	return res;
+}
+
+int amdgpu_ras_cmd_ioctl_handler(struct ras_core_context *ras_core,
+			uint8_t *cmd_buf, uint32_t buf_size)
+{
+	struct ras_cmd_ioctl *cmd = (struct ras_cmd_ioctl *)cmd_buf;
+	struct ras_core_context *cmd_core = NULL;
+	struct ras_cmd_dev_handle *cmd_handle = NULL;
+	int timeout = 60;
+	int res;
+
+	cmd->cmd_res = RAS_CMD__ERROR_INVALID_CMD;
+	cmd->output_size = 0;
+
+	if (!ras_core_is_enabled(ras_core))
+		return RAS_CMD__ERROR_ACCESS_DENIED;
+
+	if (cmd->cmd_id == RAS_CMD__QUERY_INTERFACE_INFO) {
+		cmd->cmd_res = amdgpu_ras_query_interface_info(ras_core, cmd);
+	} else if (cmd->cmd_id == RAS_CMD__GET_DEVICES_INFO) {
+		cmd->cmd_res = amdgpu_ras_get_devices_info(ras_core, cmd);
+	} else {
+		cmd_handle = (struct ras_cmd_dev_handle *)cmd->input_buff_raw;
+		cmd_core = ras_cmd_get_ras_core(cmd_handle->dev_handle);
+		if (!cmd_core)
+			return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+
+		while (ras_core_gpu_in_reset(cmd_core)) {
+			msleep(1000);
+			if (!timeout--)
+				return RAS_CMD__ERROR_TIMEOUT;
+		}
+
+
+		if (!ras_core_is_enabled(cmd_core))
+			return RAS_CMD__ERROR_ACCESS_DENIED;
+
+		res = amdgpu_ras_handle_cmd(cmd_core, cmd, NULL);
+		if (res == RAS_CMD__ERROR_UKNOWN_CMD)
+			res = rascore_handle_cmd(cmd_core, cmd, NULL);
+
+		cmd->cmd_res = res;
+	}
+
+	if ((cmd->cmd_res == RAS_CMD__SUCCESS) &&
+	    ((cmd->output_size + sizeof(*cmd)) > buf_size)) {
+		RAS_INFO("Insufficient command buffer size 0x%x!\n", buf_size);
+		return RAS_CMD__SUCCESS_EXEED_BUFFER;
+	}
+
+	return RAS_CMD__SUCCESS;
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h
new file mode 100644
index 000000000000..7017198f1bac
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __AMDGPU_RAS_CMD_H__
+#define __AMDGPU_RAS_CMD_H__
+#include "ras.h"
+
+enum amdgpu_ras_cmd_id {
+	RAS_CMD__AMDGPU_BEGIN = RAS_CMD_ID_AMDGPU_START,
+	RAS_CMD__TRANSLATE_MEMORY_FD,
+	RAS_CMD__AMDGPU_SUPPORTED_MAX = RAS_CMD_ID_AMDGPU_END,
+};
+
+struct ras_cmd_translate_memory_fd_req {
+	struct ras_cmd_dev_handle dev;
+	uint32_t type;
+	uint32_t fd;
+	uint64_t address;
+	uint32_t reserved[4];
+};
+
+struct ras_cmd_translate_memory_fd_rsp {
+	uint32_t version;
+	uint32_t padding;
+	uint64_t start;
+	uint64_t size;
+	uint32_t reserved[2];
+};
+
+int amdgpu_ras_handle_cmd(struct ras_core_context *ras_core,
+		struct ras_cmd_ioctl *cmd, void *data);
+int amdgpu_ras_cmd_ioctl_handler(struct ras_core_context *ras_core,
+			uint8_t *cmd_buf, uint32_t buf_size);
+
+#endif
-- 
2.34.1

