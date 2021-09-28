Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5BDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 07:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA99611C0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 07:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFA99611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C7889BA9;
	Tue, 28 Sep 2021 07:07:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 219C489BA9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 07:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlMLkZ6vMWD3utOT5mJaXHdBVYkEuIfMW1qBxv/FIL4PXhpvZoLEn5wFmr/d+VsidVAJwb64PUFAl7yRAzn/rixNeOP/t2EJ5aBLP2aLI/pLLzEPqTawH3AzjQH7GwYA8PFFISBizvVMCWYMW0aIEgXWmivoBt1Z+bmdFUmUS0V6l2rAO+41fYfXoZvpEV2GkoWGGH7a5UCGugVLVcteZOXY/CbZTlnz7ONT7x8HIXJKF8oxcI+MsVh1MnYJJM60KYicX3KOKnxfkTP/bUpX3t/ouTBwRVKckX7hVSbOQywXarfaUCRSPzmZPMu8rINKXeS9nTlHrhFDDdRp91FwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/khq0MmFRCL96Utd0YYFS6S17mQg4ZioZf8rJ+MQOHg=;
 b=Hc19EDFdAARKosC808hRf2GXKyqE+3rXrZGUjgqvw10lX/YxMBZ+/eHVA/L6MeGGCxYCmm4woti2B6bEHsZa/HlfaI1VtD+JSUHLqZCjpF+pcee3a/QZZ5GFyySmyU1t3r9LyPHJJN5bRKnAablM5dymiAOQai3M3CthGbrCvYta+B8d68t5BixJqI2lvxNoy9TXqTaU9sUJj6eRqFeOUkppsq/y4Oeigr62vtXr6vhtEB9Eek1S74JnfcqLeSqwKCPagvL/14poF6XVcEzEMFgBpwmvhIe2MXe7Pd9VMy9A4U1J6TmplVAM4nGCHP3wi4P/6/Za2hhPRa2eyk2u6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/khq0MmFRCL96Utd0YYFS6S17mQg4ZioZf8rJ+MQOHg=;
 b=4UCFYXjiU1DpRK2S+a6NtYtxgnYp8YKizXJv4WpAxhSD3rjAxujBjuTqhiGNKEWBlK2cQp+99DUa1QUFBqGVx5gT2V7iqDue2SD5RrjCHmxUFLl/xZOnRLNs3azKfveMaLNIJnm88xhDIFMfqofdp9vy0XtFGvS/jY0OYdrXVXM=
Received: from MW4PR04CA0054.namprd04.prod.outlook.com (2603:10b6:303:6a::29)
 by MWHPR1201MB0190.namprd12.prod.outlook.com (2603:10b6:301:55::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 07:07:54 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::75) by MW4PR04CA0054.outlook.office365.com
 (2603:10b6:303:6a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 28 Sep 2021 07:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 07:07:53 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 02:07:51 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <mukul.joshi@amd.com>, <felix.kuehling@amd.com>, <stanley.yang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma (v3)
Date: Tue, 28 Sep 2021 15:07:41 +0800
Message-ID: <20210928070741.30861-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9114d08-18c8-424f-5926-08d9824eb119
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0190:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01900725A54A23832A1A6884B0A89@MWHPR1201MB0190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ru0QSGhy9r8Q7N8Qt2M5S18Fg8Sgp+6oijh1l/xShvopfjeUOWCo5BdmpWeFZlf2qv5O4169cmBYou0npEOm90MbnhJMcn6cMduDrEZmCsowZGnxtZ85gJhiBFcfD2JyQ3gSVTIub+s+cZg5p9vcZ3mRBAI9NvUZVuNCzzd3cb2MlVND8eRvje9w6VX2bIKgmnRmAqsF9Muccf71IVcbhK2naOWUIfCvZPy6OqFjeUs9J1UPBODt4BpYrmQUgpoQxjP3UCOPlE1k9+dFdmDedlBrYZzvoTlzCTMG/62crF/GLTfmde/ME2WRpQJclsI4P9rr+98LLM2i2ovrGxrdSHJqiQEhfzoJ9lKotGVayuEXM2fPLeo2LXV0Oqo9oj6DbTBTBg5oHe5BqLGYFeELt9tv4p+YZHkMF4hzZFDBAk73vMB9OqHGlh0vRR8qctPUo9G6V3ieL2+JqiJUhj7acSM9dgv7L79Tcb5m13vZwayc1z4/OVz4e65isZuK93sfIF23oJLsFJ+MkSgzFU+3szyZ9OBoePNA4IOW3rYxvbEf9b3CEg1sWilbWRI7YQohACXGHGRJ6lPf+IpkGwNN6uUQ9zy5orrmXjIgEcsqvCooYcqWQw8gWttPioi+HdF3o3viCzttPaVMCefIO+ID/Sdj4+17d3MHHiH/u9KpPcRhr6sYpVERx8/V4sJf9oQvfBdXkNmbOBQqvdFVUjNPCflQjz7Jwbftih7ZUqVSbV0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(1076003)(26005)(16526019)(6636002)(82310400003)(426003)(5660300002)(4326008)(86362001)(36756003)(36860700001)(7696005)(336012)(8676002)(47076005)(316002)(110136005)(356005)(8936002)(81166007)(186003)(2906002)(2616005)(70586007)(70206006)(6666004)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 07:07:53.8465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9114d08-18c8-424f-5926-08d9824eb119
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0190
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

In ras poison mode, page retirement will be handled by the irq handler of the
module which consumes corrupted data.

v2: rename ras_process_cb to ras_poison_consumption_handler.
    move the handler's implementation from ASIC specific file to common
file.

v3: call gpu reset for xGMI connected mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c |  4 ++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 1d41c2c00623..7505f1b9d3f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -31,6 +31,8 @@
 #include <linux/dma-buf.h>
 #include "amdgpu_xgmi.h"
 #include <uapi/linux/kfd_ioctl.h>
+#include "amdgpu_ras.h"
+#include "amdgpu_umc.h"
 
 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables
@@ -780,3 +782,15 @@ bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd)
 
 	return adev->have_atomics_support;
 }
+
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct kgd_dev *kgd)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+	struct ras_err_data err_data = {0, 0, 0, NULL};
+
+	/* CPU MCA will handle page retirement if connected_to_cpu is 1 */
+	if (!adev->gmc.xgmi.connected_to_cpu)
+		amdgpu_umc_process_ras_data_cb(adev, &err_data, NULL);
+	else
+		amdgpu_amdkfd_gpu_reset(kgd);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 3bc52b2c604f..7db37e2016df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -290,6 +290,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 				      uint64_t *mmap_offset);
 int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
 				struct tile_config *config);
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct kgd_dev *kgd);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 12d91e53556c..543e7ea75593 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -231,7 +231,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
 					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
 					kfd_signal_poison_consumed_event(dev, pasid);
-					amdgpu_amdkfd_gpu_reset(dev->kgd);
+					amdgpu_amdkfd_ras_poison_consumption_handler(dev->kgd);
 					return;
 				}
 				break;
@@ -253,7 +253,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
 		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
 			kfd_signal_poison_consumed_event(dev, pasid);
-			amdgpu_amdkfd_gpu_reset(dev->kgd);
+			amdgpu_amdkfd_ras_poison_consumption_handler(dev->kgd);
 			return;
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
-- 
2.17.1

