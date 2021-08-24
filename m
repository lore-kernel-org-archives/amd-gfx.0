Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29594C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 10:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC36661265
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 10:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC36661265
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8099F89E2A;
	Tue, 24 Aug 2021 10:18:01 +0000 (UTC)
X-Greylist: delayed 999 seconds by postgrey-1.36 at gabe;
 Tue, 24 Aug 2021 10:18:00 UTC
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (unknown
 [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177CF89E2A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 10:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNucvNsSsTwnG2SiEY84/M3iHDiFcscA+8Sn842N0aEyqK9GUDQch0dM6oWFt3gXSmoCmICsa5W36d+Hv6e1vqtmaCzW4pM4s6DJBP3SMFuUYPzwB7FfqnytIKJEOD6R9S1cSFt+1xMvlZAc9ul6Lr6a7/d0epyd/7dpMr7opmwjY7ubgP8p/eeH6gm7d99wfAsY6dWQ4a0LyHl2JU5GewOWRn2ieX42fWuDjMkCC3VVW95XBSZK5RtAqiYbqFiTAVQtyT7r68kUBXmQZTSI/vCzPc1xNVDXLgwJ9YMJTBjxXsYFzbixug9ElrJ4WuGPz53a98IeaT3x8nV0/MuQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0u4urdpuqqOkkPxl1VCOBkCCXpPMTxT8BN/YLyUbcE=;
 b=QbadJYVtTafHS5oP1kC+3lpQJHGBaWIOOy6Y7GP+bjJlTrk9t+CGf5fr0Z8DYAevFiHe0s4RxmhZ3vfSlkpf+E5qxrWda7Ug7AKJ/v7VGr9Sf1tM+Kmzs9lHkZLqONT1h+PworRqKTWeyleR/3ooRksDA2qVULkwtZJT5tTn4mbZY+PRUtrOTBaM1ozKcP/sMO2JGz49SzYm54d7mqmLqrB9jl4da3yb9FgstyZyd8AfSE6587M/Lffym/yh9UBq6WzommK6AynrHCGe1hwc26GjaRcLTQYJuGK7wNkeJFjBCcniAe2rJsifGFYl0SAE9xjqyEJ8au57YzM45VR4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0u4urdpuqqOkkPxl1VCOBkCCXpPMTxT8BN/YLyUbcE=;
 b=HptfaBsTnb7geYj1yIZ8fTHqmZx2Mf1iHGCuz0mo968aNIFOzgeQ+CBRR3jmbNhMIezzOkGA8Sw5OwzNeAcjeShiDKx/GRtgownGaP3M+DBYUCwpD17lIkrQv/cvVAcOd/MUc2DTgut4z5lLyGwfcCjfltzYQKFX922IEb7Aj4s=
Received: from MWHPR19CA0010.namprd19.prod.outlook.com (2603:10b6:300:d4::20)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 08:43:14 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::4d) by MWHPR19CA0010.outlook.office365.com
 (2603:10b6:300:d4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 08:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 08:43:13 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 03:43:10 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <john.clements@amd.com>, <felix.kuehling@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
 interrupt
Date: Tue, 24 Aug 2021 16:43:00 +0800
Message-ID: <20210824084300.1882-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c0d3782-a190-4ede-3d4f-08d966db35d0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4503F5B4961C9F27A8EF52C3B0C59@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9jClG6Q4T6kUZ6j3IEjHeGRybMG6j7UzW8ynAsmKIKTQUbWntKEY5TfbtE5yK0BVzBVIAdo5mBmlUvdz8mt9Tuw4sS9pt4TWfChtN2wSgjOyWyZEkPUzf/+iBbYc7vlYYjosATx6Sikp+0Vv85B8AmiU/e+h1/UOisViM8KpH/XETlzAHvrkUD0JgrLhkVsKJgpwcgWQfGYb8l+N1FWALMEFMVb5ZfR8SQUo9T+jg9m54ZHziHIfaviCcLEJyH6T5Iu/6r0Z67GUmlOTIpmWVETqf8gij38vTgkNi+5MP9G8iKOGfDbVNc7qq9V5xGuPu8g+0VVQgRlwqL4qjeIcyu6A8IkYAYWO3M87zzq+DCmzMhmXL6JrJtrzclytnYZohybOQoXeAUH6hBTWpE6EIQ6nMd0+8Hm2TyCqNGiaj+GgKkCxf+XPHh8rYe+bdKOBGA8E5fEwl1iEXUMQ1o8pc194ywOJ4RuKetAFgkG1ArytaOVVdmBIZHGX230fkGzRAmkR7j6KTF2TYvggOunB8vuD7fHnxIaihvYCHJtsVPuf3AEdIGl0zi1fg2aeQLbtfhXyGky5jZ4AhUQ4fklIsMOhj/i7WFrD2kf9iZqdvHEvjcrdPuIvitYUSrKuHLyKZYGCyGtskcPfs6zTnhlrP9iToz1jcqjz1oaysCqiuzOrfkSe1sid7dqefBgkaHpdlIUyvo5rSLqD7Dwv1CN5EL3W7iA/wyL+q8XPfPeaTklzSOSlVt2ubIeUw4gY95FPmKHKbXUHwG5p0es4Vc/Ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(356005)(47076005)(6666004)(2906002)(5660300002)(8936002)(70586007)(81166007)(86362001)(186003)(70206006)(8676002)(6636002)(336012)(426003)(83380400001)(4326008)(316002)(16526019)(26005)(1076003)(82310400003)(34020700004)(7696005)(508600001)(2616005)(36860700001)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 08:43:13.4707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0d3782-a190-4ede-3d4f-08d966db35d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c    | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c     | 10 ++++++++--
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h     |  1 +
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 46cd4ee6bafb..eb5e9c1b1073 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -23,6 +23,16 @@
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
+	return amdgpu_umc_process_ras_data_cb(adev, &err_data, NULL);
+}
 
 const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
@@ -44,5 +54,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
-	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.ras_process_cb = kgd_aldebaran_ras_process_cb
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 12d91e53556c..851b5120927a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -231,7 +231,10 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
 					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
 					kfd_signal_poison_consumed_event(dev, pasid);
-					amdgpu_amdkfd_gpu_reset(dev->kgd);
+					if (dev->kfd2kgd->ras_process_cb)
+						dev->kfd2kgd->ras_process_cb(dev->kgd);
+					else
+						amdgpu_amdkfd_gpu_reset(dev->kgd);
 					return;
 				}
 				break;
@@ -253,7 +256,10 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
 		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
 			kfd_signal_poison_consumed_event(dev, pasid);
-			amdgpu_amdkfd_gpu_reset(dev->kgd);
+			if (dev->kfd2kgd->ras_process_cb)
+				dev->kfd2kgd->ras_process_cb(dev->kgd);
+			else
+				amdgpu_amdkfd_gpu_reset(dev->kgd);
 			return;
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index c84bd7b2cf59..9e6525871ad4 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -301,6 +301,7 @@ struct kfd2kgd_calls {
 			int *max_waves_per_cu);
 	void (*program_trap_handler_settings)(struct kgd_dev *kgd,
 			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
+	int (*ras_process_cb)(struct kgd_dev *kgd);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.17.1

