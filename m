Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3106C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 10:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A196058D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 10:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0A196058D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2E26E118;
	Thu, 23 Sep 2021 10:05:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C62AF6E118
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 10:05:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXv+POqQmJaftEeRB9gjMvq3GWwOO+mBhl5Z1h1nYIFsizG1IRkLPoXadvRBBoHo27bFSfdf6SC99MwFHsMSKmSEndDKsQUX/j58nr8klU4QlEYyYtJQQBLYv2E+RUgdne6/TmudPLIiVhEed/6Sod19g736lso6kJOrSdJ4Uf3uWrbfNU0VOSEBdz8AeC14FwRiaJ3AOeeiDaiaUd1rO1MNSLxv4QRyJjDdGFg/4xFnLVIl2ngErvakdHlN4BvvoOK6goLJiGKV2cceFGZjbo6HH1CXqElSpR7CKmp8AiIgeBU8KMPfVMOROecraURALB427Sk8c4SivLVbcMqWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=TA1ZnTjDf18kp1qZ1M36rxUpqZpReLT/5xgnu7+Zxwk=;
 b=dQGPYSn1+tuQMNnDyZ+ZqYbozW2y/CFXaLGu4/g/Enw/Te6STWdvnLLs5+4IFZFJepqWoiMvVDzqy5ugiV07e0gQNHjH19SHxudEpWwNWGX0q6L+k4tGmrVW5sHOMT0L8qaAkD0MOsMkBigaS8du/HlgLmkHHGiyMNXBdxZh+qn1zi5MKDu2EY/HzslRTNnZGlI4f1J6HLvVGE7f5WcLNKPNAGH/HEFOh7IxY0xay9Do2DYupD+Pldk8M2jhrnOTMoTr/vO4OZ6euBicgPdp8swPnCmhQHLLJLM7nvJnNvjvCl6sjYv/bmBl8sWzNFpQGt7iUFYAmLlzKvPnJAvanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA1ZnTjDf18kp1qZ1M36rxUpqZpReLT/5xgnu7+Zxwk=;
 b=Jwa03+jw+bcEqpyXYswh8fOSdDYQHH67fYSCV8IG+uvzptLWih/6OxV5TnY7bodEVkMpQWKU2OHT4uB7ycdoPpZv4Hdon+HNF1cqbwjcGUQj+LWUJVqwXlhOgxmxosJqL0QZnstzg4V55riaTSvTla4KFuSLpPOb6ckk3+7P0qE=
Received: from BN9PR03CA0156.namprd03.prod.outlook.com (2603:10b6:408:f4::11)
 by CY4PR1201MB0104.namprd12.prod.outlook.com (2603:10b6:910:1d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Thu, 23 Sep
 2021 10:05:41 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::b2) by BN9PR03CA0156.outlook.office365.com
 (2603:10b6:408:f4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 10:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 10:05:41 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 23 Sep
 2021 05:05:39 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <john.clements@amd.com>, <stanley.yang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
Date: Thu, 23 Sep 2021 18:05:29 +0800
Message-ID: <20210923100529.10807-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96d32b00-127b-42f7-7b06-08d97e79b319
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0104:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0104B9A6EF06539E3D979D32B0A39@CY4PR1201MB0104.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKNv3EHC4/oxKgjYXikK7fO1Cww1odlZFzOhXeen2/+ANnPNql6r1pvcrjb3Xx0cbL7i2/zxYu+7E3lZUe4072goRkKwy+QzI2N/A+MA07gAmEdv2qVQ63NJFYI4owbeBgaX9/fDPDxQ3hfS4Oyp8/OmmU909q8mzTJNPCzaHF4aRopi+qcmGW71xZDXgk38lTigBzgM1qhRgpBGy3hcmAgQ5NoW5VOJp2nD8x2Z1ttR7bJb5HhjnpdYqhIm/++r3UiZ5PCIwYYvWqNVtBFPZfsDZTfzi4yR+cG519VqVGBi/Kdi9uHmxk6Nqylwad9ML1AjsldxWAl/1Wh8S4+PEQ24KjtIOKSqcK2glhlpV+lHlU24M5T/tuTiPz0nbkcWWUDjgIsmcFdZLrDkG/tuTrLvDHgBWMvOgttgkot446MNHKXTIgaJ5Var4MyICe8ywoJOyQzH98jYzF0zQiK1Is/H+64b6kmsUQdZZxcaokIrFj0zuvZ3oTYQTqR8EJFOyiMhJRxSvG5OwOg9YYi6DM6URhk48bpamnx0klzvuNNaBCpq9a/jCcLdhZKnkiscOMY+5eM41+IWJPMH2GLuwpy5qIJdFo1n5nF0XrOp8L8TyhdlbSwEV/vVFJNE7ctHDfv0u1F8cwOul1+1ZKXykTt5IUIoxABC6oSQ7Xij8ipbWpYec7LRc6YmIbLy91mT+YLJqgkt4lj8q1f1uuRXkO5KuzIou8JYkNErBiMo1ok=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(2906002)(70586007)(86362001)(508600001)(4326008)(7696005)(83380400001)(336012)(36756003)(16526019)(6636002)(186003)(5660300002)(70206006)(26005)(316002)(82310400003)(8936002)(426003)(110136005)(356005)(8676002)(2616005)(47076005)(6666004)(36860700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 10:05:41.0140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d32b00-127b-42f7-7b06-08d97e79b319
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0104
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

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c    | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c |  6 ++++--
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h |  2 ++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 46cd4ee6bafb..27fc4e52aba9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -23,6 +23,20 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_arcturus.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
+#include "amdgpu_ras.h"
+#include "amdgpu_umc.h"
+
+int kgd_aldebaran_ras_process_cb(struct kgd_dev *kgd)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+	struct ras_err_data err_data = {0, 0, 0, NULL};
+
+	/* cpu mca will handle it if connected_to_cpu is 1 */
+	if (!adev->gmc.xgmi.connected_to_cpu)
+		return amdgpu_umc_process_ras_data_cb(adev, &err_data, NULL);
+	else
+		return 0;
+}
 
 const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
@@ -44,5 +58,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
-	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.ras_process_cb = kgd_aldebaran_ras_process_cb
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 12d91e53556c..4a48b78f918e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -231,7 +231,8 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
 					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
 					kfd_signal_poison_consumed_event(dev, pasid);
-					amdgpu_amdkfd_gpu_reset(dev->kgd);
+					if (dev->kfd2kgd->ras_process_cb)
+						dev->kfd2kgd->ras_process_cb(dev->kgd);
 					return;
 				}
 				break;
@@ -253,7 +254,8 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
 		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
 			kfd_signal_poison_consumed_event(dev, pasid);
-			amdgpu_amdkfd_gpu_reset(dev->kgd);
+			if (dev->kfd2kgd->ras_process_cb)
+				dev->kfd2kgd->ras_process_cb(dev->kgd);
 			return;
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index c84bd7b2cf59..828131415901 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -301,6 +301,8 @@ struct kfd2kgd_calls {
 			int *max_waves_per_cu);
 	void (*program_trap_handler_settings)(struct kgd_dev *kgd,
 			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
+
+	int (*ras_process_cb)(struct kgd_dev *kgd);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.17.1

