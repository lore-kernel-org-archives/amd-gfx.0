Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B00D2ECF9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB4710E569;
	Tue, 20 Jan 2026 07:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jByBH49+";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011003.outbound.protection.outlook.com
 [40.93.194.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FB510E569
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqitda1VN8XcfJRLqAz3EdTccegqoheLrqoMg9OaXAwhtDI5+Vhsc2D02DQGM0JzfD4LYnMbBZ6Wg12oodXSWOkHhr6tTtdw5C2Xn97WHhHAuVO3OT4/c/EPOGwzj59uX7t729pSpI0CuWoP0FCLzALTBvJztMWVGOsMUgWu45n3D5c9qDf8jX7eQn/B1VDZKjL8LDN5OVbOO5UVjzR7MmWvpFDmcZ7WwkIlP7m/aQfwxALbNzHZh+SvRB+X6BIB0j3qRUHsO4V/qJbywEgEdh7QjTfp9wBuULYlnnkmCd5nQJvNV2USxTsAkQmQwFwcZ8C9MZAUqVjQTeIbDcDLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4tzRdSMlPcXECoSWYLmaZ1XxGH83VO6GaGrxu4HY/0=;
 b=lTlXXvS8FU/Zugs3g9k/DdqvjGrT8ycSURUgTpAH7iI5H/NNAfy0RfejpQDa5jg94+XV+QFW/RagpjUqdj15xgwBOqWgnWeAUWullsvvAHRPoCK5gFCxh2JI9afkLRzI7WI3ZT2AaHr6YHroevai0VdsxrRS8VZ3c9qZUTct1gWDq0JmQRndmNHpm895/W1WuG1ndQcH7aa59+nZMfajSijFL7Dg5kq4PUUok47ddNV6XeMuLHsH4Z73pxmTLuVJx9EEdnsfX0LIRjvdWBVurCKSh5Y+QudYm151oVLIU6N6J3d8OxmAzsNq+C1kRCTlyes/yNtWpZMUKlz54/S3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4tzRdSMlPcXECoSWYLmaZ1XxGH83VO6GaGrxu4HY/0=;
 b=jByBH49+79Tl9si2ojZFl4owykMFkbN6e58GLr2x3Nx0h4uNn+/5taUxKFU/dMDfe1dDVK7RlQgfJpOqwnF8WEHr0elVDdQEBWfMnF5gtUe+fLFiXqWDed4FCJ4iZnJIevzBGL2RdOm+9kbdasrj/kSn3Fzuc3n14EW8PZY3F90=
Received: from SJ0PR13CA0223.namprd13.prod.outlook.com (2603:10b6:a03:2c1::18)
 by BN5PR12MB9540.namprd12.prod.outlook.com (2603:10b6:408:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:00:20 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::1d) by SJ0PR13CA0223.outlook.office365.com
 (2603:10b6:a03:2c1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 07:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:00:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 01:00:16 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 15/15] drm/amdgpu: Use get_smn_base in aqua_vanjaram
Date: Tue, 20 Jan 2026 12:27:49 +0530
Message-ID: <20260120065931.1300054-16-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260120065931.1300054-1-lijo.lazar@amd.com>
References: <20260120065931.1300054-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|BN5PR12MB9540:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3ca0ee-c12e-4bfb-2470-08de57f192b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sqRYDyHjZky1urw+7TGuerNy2ntDUOIRSV2yo0DY832STsyaUVS7MCo4PMPn?=
 =?us-ascii?Q?RnbwkTzwaKrpui9GZH35G64tFByyxnlaZ0l2ypPAaxI27io8oesCc/CWhpyn?=
 =?us-ascii?Q?BZcxp9gdi8jZ1pPFT9N/a0RmClPgqKRVLBptpR5ZSThXPd1kdiCjliyBDuTP?=
 =?us-ascii?Q?ze5rrxWC0FECl2AfvZ0CJaQ0+YzGE6AiW1ngGwg2cAJ1nn+wscA8qJsoud2h?=
 =?us-ascii?Q?bSYL1yBz3+JCenuHLw1m/bvdApZJSqgsuPt/iITVm+dg72iaetzBFPYqHHvu?=
 =?us-ascii?Q?HJK8T+yMgzlwto2ApTJJ5J6QJPesCY4NmyszCBFGkdibcjG8iwY+KP6Ql1NE?=
 =?us-ascii?Q?Rc9UB8/6g1hWMk/8eGT/WPVjW5OtKw3Njj47w5vRQi9e8Zx0Mzz53hoEUuuP?=
 =?us-ascii?Q?zAxom6iT+vSpHsG6lT9qn4kvj26jcOTGAT0i40ETQfM39locytMjG2eK0mYk?=
 =?us-ascii?Q?Ry1IAW5PwX0CGb4p4bSpQNYtzinPzNHeac5IX9nxfC7bExzWg/Pp/E1WwOWO?=
 =?us-ascii?Q?LHpK9SxpBv7tKKJU7Pf6preUaRB8iXmnIib6odl+TSjMI2K+LZfQkicpx4ny?=
 =?us-ascii?Q?KqnUARs4pu9pCHyjry6nPujfuFCOOHk7odF1+7EWDwrUusWLHADMhGHXD2OD?=
 =?us-ascii?Q?+6VmM47znXEi2BGxvI6g3d/VUgNryLOhZ8WxyNoZBGYN9ntMzZiX180oeWjJ?=
 =?us-ascii?Q?gn9aNVaOhhvD+Ze8aUCEP11uAOtjR+gatwsHvyyoP0XSxOykq456b4EAlJtv?=
 =?us-ascii?Q?M+Zz0ZBOnYO/NW3RAkvmCCvwjBH7M44ejAAr1RUUfQtV7YsgHg8BsOQSz4xZ?=
 =?us-ascii?Q?Kdp4Q0colUnqScf/LsiCmDHWBn2FujzJrZqmGTo5QXXtSSVYL4yjTEKerA+g?=
 =?us-ascii?Q?Da8YaVXqVQ8Kks6PJIFF3KMaxidJTau8oIBS51WF5akrZ/KxIOhNhC7jPcZL?=
 =?us-ascii?Q?yaEzFF63quplPP51LN/U7FiW4Ft99VBGwR8yx+FaaI1SN2H98MCv+rxvciaC?=
 =?us-ascii?Q?SqrhQPADaM/b+XzvuP/vasT+OOPvpGQTeSwg+PKtoOTDOzYbzyU8iSDngZyh?=
 =?us-ascii?Q?k0ZbrUL3ylwOI1ONXeFmKNHYMqHOePPyxSvqQvBPKa8cYuGTpJ9HZ+L2/oZY?=
 =?us-ascii?Q?/vo+ZXgpshGBomnjPSRxGvCi6e5+NcyDvgCcMpSyvGZbCL48rA2HeZ5f8/gM?=
 =?us-ascii?Q?KbYuLJ4LXrff1PLtnZVy9wMAPbpo89iiUB9DbnGUz3kyx36efLL+uYKl0/i/?=
 =?us-ascii?Q?6eqlrq7zZ3DwFBm5+WqNbaCF+Thp+D2kS0j4zVt4vObunf6nkC3/YHxdzUEA?=
 =?us-ascii?Q?2w0dSkRp/TZ3iLfSeUji3XkxwSk5lzNDP4E5AWH970IW6FxCgRCR6rbJVVTu?=
 =?us-ascii?Q?X22rHp85LucH6hOAQPMVZG9wpD5TDQBVGakJxptmuJR6BiqJF8Zsr8kLky8Y?=
 =?us-ascii?Q?dqKwU78PT/W4ET393NRc2JTuipjHRSOm/LnztWta/snYlXaorO6M83w3MUvZ?=
 =?us-ascii?Q?7nA+93BLYAWJhS5znBukA/pvR1NkAR3JvnUJyMeOwnPMCbASc2sWrLwc1t7B?=
 =?us-ascii?Q?Sb2SaKiK+KcuD4iFXmNRHvmMmiPgThfcn26W/6BPSpXyqd8QZCcgl1WWTHd+?=
 =?us-ascii?Q?71vTdvRVdTNxMuNIRylk5vP+hiAX1DoMgW1woU01EBp/brRkzsYLqOuO3cqq?=
 =?us-ascii?Q?b3M1Yw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:00:19.2315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3ca0ee-c12e-4bfb-2470-08de57f192b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9540
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

Use get_smn_base interface to get IP die instance's base offset in
aqua_vanjaram. encode_ext_smn_addressing is not used.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 56 ++++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      | 12 ++--
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    | 21 +------
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h            |  1 -
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     | 31 +++++-----
 9 files changed, 90 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0c84c7ab36d1..5d0083822c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -21,6 +21,7 @@
  *
  *
  */
+#include "amdgpu_reg_access.h"
 #include <linux/debugfs.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -5509,11 +5510,11 @@ static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device *adev,
 	 * is changed. In such case, replace the aqua_vanjaram implementation
 	 * with more common helper */
 	reg_addr = (mmMP0_SMN_C2PMSG_92 << 2) +
-		   aqua_vanjaram_encode_ext_smn_addressing(instance);
+		   amdgpu_reg_get_smn_base64(adev, MP0_HWIP, instance);
 	fw_status = amdgpu_device_indirect_rreg_ext(adev, reg_addr);
 
 	reg_addr = (mmMP0_SMN_C2PMSG_126 << 2) +
-		   aqua_vanjaram_encode_ext_smn_addressing(instance);
+		   amdgpu_reg_get_smn_base64(adev, MP0_HWIP, instance);
 	boot_error = amdgpu_device_indirect_rreg_ext(adev, reg_addr);
 
 	socket_id = AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_error);
@@ -5579,7 +5580,7 @@ static bool amdgpu_ras_boot_error_detected(struct amdgpu_device *adev,
 	int retry_loop;
 
 	reg_addr = (mmMP0_SMN_C2PMSG_92 << 2) +
-		   aqua_vanjaram_encode_ext_smn_addressing(instance);
+		   amdgpu_reg_get_smn_base64(adev, MP0_HWIP, instance);
 
 	for (retry_loop = 0; retry_loop < AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT; retry_loop++) {
 		reg_data = amdgpu_device_indirect_rreg_ext(adev, reg_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 4f58e9e81670..bf8645390bdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -283,17 +283,71 @@ void amdgpu_reg_pciep_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	adev->reg.pcie.port_wreg(adev, reg, v);
 }
 
+static int amdgpu_reg_get_smn_base_version(struct amdgpu_device *adev)
+{
+	struct pci_dev *pdev = adev->pdev;
+	int id;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EOPNOTSUPP;
+
+	id = (pdev->device >> 4) & 0xFFFF;
+	if (id == 0x74A || id == 0x74B || id == 0x75A || id == 0x75B)
+		return 1;
+
+	return -EOPNOTSUPP;
+}
+
 uint64_t amdgpu_reg_get_smn_base64(struct amdgpu_device *adev,
 				   enum amd_hw_ip_block_type block,
 				   int die_inst)
 {
 	if (!adev->reg.smn.get_smn_base) {
-		dev_err_once(adev->dev, "SMN base address callback not set\n");
+		int version = amdgpu_reg_get_smn_base_version(adev);
+		switch (version) {
+		case 1:
+			return amdgpu_reg_smn_v1_0_get_base(adev, block,
+							    die_inst);
+		default:
+			dev_err_once(
+				adev->dev,
+				"SMN base address query not supported for this device\n");
+			return 0;
+		}
 		return 0;
 	}
 	return adev->reg.smn.get_smn_base(adev, block, die_inst);
 }
 
+uint64_t amdgpu_reg_smn_v1_0_get_base(struct amdgpu_device *adev,
+				      enum amd_hw_ip_block_type block,
+				      int die_inst)
+{
+	uint64_t smn_base;
+
+	if (die_inst == 0)
+		return 0;
+
+	switch (block) {
+	case XGMI_HWIP:
+	case NBIO_HWIP:
+	case MP0_HWIP:
+	case UMC_HWIP:
+	case DF_HWIP:
+		smn_base = ((uint64_t)(die_inst & 0x3) << 32) | (1ULL << 34);
+		break;
+	default:
+		dev_warn_once(
+			adev->dev,
+			"SMN base address query not supported for this block %d\n",
+			block);
+		smn_base = 0;
+		break;
+	}
+
+	return smn_base;
+}
+
 /*
  * register access helper functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index b3b941cc7b7c..4d88e5cd19fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -122,6 +122,9 @@ void amdgpu_reg_pciep_wr32(struct amdgpu_device *adev, uint32_t reg,
 uint64_t amdgpu_reg_get_smn_base64(struct amdgpu_device *adev,
 				   enum amd_hw_ip_block_type block,
 				   int die_inst);
+uint64_t amdgpu_reg_smn_v1_0_get_base(struct amdgpu_device *adev,
+				      enum amd_hw_ip_block_type block,
+				      int die_inst);
 
 uint32_t amdgpu_device_rreg(struct amdgpu_device *adev, uint32_t reg,
 			    uint32_t acc_flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index aad530c46a9f..75d3dd98d069 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -340,7 +340,7 @@ static u32 xgmi_v6_4_get_link_status(struct amdgpu_device *adev, int global_link
 	if (!(adev->aid_mask & BIT(i)))
 		return U32_MAX;
 
-	addr += adev->asic_funcs->encode_ext_smn_addressing(i);
+	addr += amdgpu_reg_get_smn_base64(adev, XGMI_HWIP, i);
 
 	return RREG32_PCIE_EXT(addr);
 }
@@ -1292,7 +1292,10 @@ static void amdgpu_xgmi_legacy_reset_ras_error_count(struct amdgpu_device *adev)
 
 static void __xgmi_v6_4_0_reset_error_count(struct amdgpu_device *adev, int xgmi_inst, u64 mca_base)
 {
-	WREG64_MCA(xgmi_inst, mca_base, ACA_REG_IDX_STATUS, 0ULL);
+	uint64_t smn_base =
+		amdgpu_reg_get_smn_base64(adev, XGMI_HWIP, xgmi_inst);
+
+	WREG64_MCA(smn_base, mca_base, ACA_REG_IDX_STATUS, 0ULL);
 }
 
 static void xgmi_v6_4_0_reset_error_count(struct amdgpu_device *adev, int xgmi_inst)
@@ -1502,6 +1505,7 @@ static void __xgmi_v6_4_0_query_error_count(struct amdgpu_device *adev, struct a
 					    u64 mca_base, struct ras_err_data *err_data)
 {
 	int xgmi_inst = mcm_info->die_id;
+	uint64_t smn_base;
 	u64 status = 0;
 
 	status = RREG64_MCA(xgmi_inst, mca_base, ACA_REG_IDX_STATUS);
@@ -1518,8 +1522,8 @@ static void __xgmi_v6_4_0_query_error_count(struct amdgpu_device *adev, struct a
 	default:
 		break;
 	}
-
-	WREG64_MCA(xgmi_inst, mca_base, ACA_REG_IDX_STATUS, 0ULL);
+	smn_base = amdgpu_reg_get_smn_base64(adev, XGMI_HWIP, xgmi_inst);
+	WREG64_MCA(smn_base, mca_base, ACA_REG_IDX_STATUS, 0ULL);
 }
 
 static void xgmi_v6_4_0_query_error_count(struct amdgpu_device *adev, int xgmi_inst, struct ras_err_data *err_data)
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index d9842aa25283..72ea37dbfea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -58,25 +58,6 @@ void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 	adev->doorbell_index.max_assignment = AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT << 1;
 }
 
-/* Fixed pattern for smn addressing on different AIDs:
- *   bit[34]: indicate cross AID access
- *   bit[33:32]: indicate target AID id
- * AID id range is 0 ~ 3 as maximum AID number is 4.
- */
-u64 aqua_vanjaram_encode_ext_smn_addressing(int ext_id)
-{
-	u64 ext_offset;
-
-	/* local routing and bit[34:32] will be zeros */
-	if (ext_id == 0)
-		return 0;
-
-	/* Initiated from host, accessing to all non-zero aids are cross traffic */
-	ext_offset = ((u64)(ext_id & 0x3) << 32) | (1ULL << 34);
-
-	return ext_offset;
-}
-
 static enum amdgpu_gfx_partition
 __aqua_vanjaram_calc_xcp_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 {
@@ -590,7 +571,7 @@ static void aqua_read_smn_ext(struct amdgpu_device *adev,
 			      uint64_t smn_addr, int i)
 {
 	regdata->addr =
-		smn_addr + adev->asic_funcs->encode_ext_smn_addressing(i);
+		smn_addr + amdgpu_reg_get_smn_base64(adev, XGMI_HWIP, i);
 	regdata->value = RREG32_PCIE_EXT(regdata->addr);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index af4a7d7c4abd..98630e576726 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -162,7 +162,7 @@ static void psp_v13_0_bootloader_print_status(struct psp_context *psp,
 			bl_status_reg =
 				(SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_92)
 				 << 2) +
-				adev->asic_funcs->encode_ext_smn_addressing(i);
+				amdgpu_reg_get_smn_base64(adev, MP0_HWIP, i);
 			at += snprintf(bl_status_msg + at,
 				       PSP13_BL_STATUS_SIZE - at,
 				       " status(%02i): 0x%08x", i,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a3c9a557c284..02b001426dfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -952,7 +952,6 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
 	.query_video_codecs = &soc15_query_video_codecs,
-	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
 	.get_reg_state = &aqua_vanjaram_get_reg_state,
 };
 
@@ -1198,6 +1197,7 @@ static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(9, 4, 4):
 	case IP_VERSION(9, 5, 0):
 		adev->asic_funcs = &aqua_vanjaram_asic_funcs;
+		adev->reg.smn.get_smn_base = &amdgpu_reg_smn_v1_0_get_base;
 		adev->cg_flags =
 			AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS | AMD_CG_SUPPORT_SDMA_MGCG |
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index c8ac11a9cdef..46a6477b677b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -118,7 +118,6 @@ int vega10_reg_base_init(struct amdgpu_device *adev);
 int vega20_reg_base_init(struct amdgpu_device *adev);
 int arct_reg_base_init(struct amdgpu_device *adev);
 int aldebaran_reg_base_init(struct amdgpu_device *adev);
-u64 aqua_vanjaram_encode_ext_smn_addressing(int ext_id);
 int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev);
 ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 				    enum amdgpu_reg_state reg_state, void *buf,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 242b24f73c17..a7b5a95ebebb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -195,19 +195,22 @@
 	__RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, AMDGPU_REGS_RLC, ip##_HWIP, inst)
 
 /* inst equals to ext for some IPs */
-#define RREG32_SOC15_EXT(ip, inst, reg, ext) \
-	RREG32_PCIE_EXT((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) * 4 \
-			+ adev->asic_funcs->encode_ext_smn_addressing(ext)) \
-
-#define WREG32_SOC15_EXT(ip, inst, reg, ext, value) \
-	WREG32_PCIE_EXT((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) * 4 \
-			+ adev->asic_funcs->encode_ext_smn_addressing(ext), \
-			value) \
-
-#define RREG64_MCA(ext, mca_base, idx) \
-	RREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8))
-
-#define WREG64_MCA(ext, mca_base, idx, val) \
-	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
+#define RREG32_SOC15_EXT(ip, inst, reg, ext)                                 \
+	RREG32_PCIE_EXT((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + \
+			 reg) * 4 +                                          \
+			amdgpu_reg_get_smn_base64(adev, ip##_HWIP, inst))
+
+#define WREG32_SOC15_EXT(ip, inst, reg, ext, value)                         \
+	WREG32_PCIE_EXT(                                                    \
+		(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) * \
+				4 +                                         \
+			amdgpu_reg_get_smn_base64(adev, ip##_HWIP, inst),   \
+		value)
+
+#define RREG64_MCA(smn_base, mca_base, idx) \
+	RREG64_PCIE_EXT(smn_base + mca_base + (idx * 8))
+
+#define WREG64_MCA(smn_base, mca_base, idx, val) \
+	WREG64_PCIE_EXT(smn_base + mca_base + (idx * 8), val)
 
 #endif
-- 
2.49.0

