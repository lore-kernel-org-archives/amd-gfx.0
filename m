Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14207C19F28
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Aug 2022 18:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C69210FC34;
	Wed,  3 Aug 2022 18:56:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C18BF113CFA
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Aug 2022 18:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjlgbYPe2l5DzNtugBIqyiCC6+4baSClm1fR03IOhgVmYvxlFzjZLuLM67eWanTfNV93qVxDyAUSraGNLCk7gyWCTfacMqmQhbx3rKRbYtGfeoeg/6mdyF4CLlTm8RNqbuJMezh0aULzdWRGIfwTKybCX2nF1xE2427N5CRH5mDY+Z62OvX6/cm0uCGOd4d8AJbFVIx2bRZlkbo9IXnXgeIz8qRHYu1dWMjaCcNc7lSc6Z39ISvkQypYxC910xbU6cBci78tP0AQfFD023mDuWbbrGvo4Md+oBDZ+4FyumFDoQDnfLaYG2PRmh/q5Nu59Obg47vUOYss8B81LABBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ3+ZY4yhYKVDyG3fYnRwS4UtLzU1AToTP1AuNFusy4=;
 b=c/irbDPbYRq3wc1wR0ZR63OHb2pY/Mo64sMMdBXjvvwDqnsIrD7bOBP1oeUvEH9jE6qBBHFP3XzRHpvLSfxYOZjT6/0iyNuTPqTTC7txu0VB7+7sjHufq2gG76qv97e87AsmK1PmXNq3s9Bbo94wfzEuN2J+oARX5Nwwt/Pk0yd2h1JI4CrXu4adWcxf+aoKpEXNqFojVGTVi5euTRMxYTBTmxvep2lZ2TzBB34d+/bgVD9s1geM0GY6knTatFcTrQBmNVbMGdARCc3MRUSnIHvHIOcKa9Tga+KopX03DBgzkjz29IAtnZ0h9/FBJDGgSx1TOF4wGNMpdd83hsq3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ3+ZY4yhYKVDyG3fYnRwS4UtLzU1AToTP1AuNFusy4=;
 b=bovCLhamtXE6Zn70fVogfkW26CbTjPED9HmJPNyrfYrMLsAOICPUJgb3KSSvVLtkaH+KbaxaFkN3uDYCIuHmd9YlT5LcQHf6U73TV5YQfH4+h+vZFT5/JnPFRvcw9iJQwJRSp9C6UHLTpoxSxhOUy+2gZLTSObVUFVYMbInIfxk=
Received: from DM6PR06CA0063.namprd06.prod.outlook.com (2603:10b6:5:54::40) by
 MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 18:56:05 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::91) by DM6PR06CA0063.outlook.office365.com
 (2603:10b6:5:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Wed, 3 Aug 2022 18:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Wed, 3 Aug 2022 18:56:05 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 13:56:04 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Allocate doorbells only when needed
Date: Wed, 3 Aug 2022 14:55:43 -0400
Message-ID: <20220803185543.36786-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38a14ea5-2bab-4864-9cc1-08da7581d1a6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4159:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5e4zxlIjkRwKCUoLv28CaGZO0HfYnb/dLW2lWTh1g12MEZRzq6goTo7+YeTgB0KdHdyfNNSTXpkyEedjUEPHbo1sImm4/4UvRZMEDKbeKtRGRUv9rf5MC/4QarYVnBA3VD43G2dR6jzqQAwIIV8yxTT3EMehuOkXSdpCH3taLvPGa9cTaaA/rk/3JbkuPu2K2/yPlnXEnx3U7NkouvkAC/58J/dATGL1J4jFIVQggYL4JkJ/2/Rz2kA53uYonw9xezSawdhN7dJEMOXGmgvmYYA5xlFRYoVRsb06Q7AuGmyzNChP6NGtus16ZUhXP5e9R0Ah83xr2GBf4inCiVcEUigwEoS1U5uozrnW8MYwOrSG+TXbeVTPGcgriwuZk7LofIO1cavfesrAO82m80GmlokuT7GIeZoUKBg4zK1asbeJkltstAr/sky1fXFtkRcYlN/5qSs1teTiTleBlzmen/z3Tm1VSJ7OQyOrDW7FYhsBGCx8yVHo8/zO4fvMWHI3fJMPPqexGayyFbC7N1+sc0pdfoo9m4OC5on5QfjFA0ZmPpCbZFIKYeetwvd9KgHy7D15+FhG5njHCsaUCeUazqpTOOahGYMXKME8IosubXu58tQMINXTkpcIoHWH980APwdTH4Mp3ny5ubnknGxp5O4YQsHfdPuUvJcGLc+Tip96tryFYnit3+yj7TDj1O6oiwk+xzXrIePxMYKBuwLp4ZGYMhzHxy/JaepF2oheyeuhbems4HuInpJT5jNtxtRm5et86mFVam5ZaWEhS4W5o7QJxMe9cd/6/JQtsucKUkRgmNvnE/axZcPbAKKuQGSsYkOWO0EtWqEb8ap2EZtMRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(40470700004)(46966006)(36840700001)(70586007)(36756003)(70206006)(8676002)(36860700001)(82310400005)(8936002)(5660300002)(316002)(6916009)(478600001)(1076003)(16526019)(2616005)(26005)(47076005)(186003)(336012)(426003)(41300700001)(6666004)(2906002)(7696005)(40480700001)(81166007)(356005)(83380400001)(82740400003)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 18:56:05.3997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a14ea5-2bab-4864-9cc1-08da7581d1a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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

Only allocate doorbells when the first queue is created on a GPU or the
doorbells need to be mapped into CPU or GPU virtual address space. This
avoids allocating doorbells unnecessarily and can allow more processes
to use KFD on multi-GPU systems.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  | 13 +++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c |  9 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  5 -----
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 2b3d8bc8f0aa..907f4711abce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -327,6 +327,12 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		goto err_bind_process;
 	}
 
+	if (!pdd->doorbell_index &&
+	    kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
+		err = -ENOMEM;
+		goto err_alloc_doorbells;
+	}
+
 	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
 	 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
 	 */
@@ -404,6 +410,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	if (wptr_bo)
 		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
 err_wptr_map_gart:
+err_alloc_doorbells:
 err_bind_process:
 err_pdd:
 	mutex_unlock(&p->mutex);
@@ -1092,6 +1099,10 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 			goto err_unlock;
 		}
 		offset = kfd_get_process_doorbells(pdd);
+		if (!offset) {
+			err = -ENOMEM;
+			goto err_unlock;
+		}
 	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
 		if (args->size != PAGE_SIZE) {
 			err = -EINVAL;
@@ -2173,6 +2184,8 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 			return -EINVAL;
 
 		offset = kfd_get_process_doorbells(pdd);
+		if (!offset)
+			return -ENOMEM;
 	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
 		/* MMIO BOs need remapped bus address */
 		if (bo_bucket->size != PAGE_SIZE) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index cb3d2ccc5100..b33798f89ef0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -157,6 +157,8 @@ int kfd_doorbell_mmap(struct kfd_dev *dev, struct kfd_process *process,
 
 	/* Calculate physical address of doorbell */
 	address = kfd_get_process_doorbells(pdd);
+	if (!address)
+		return -ENOMEM;
 	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
 				VM_DONTDUMP | VM_PFNMAP;
 
@@ -275,6 +277,13 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
 
 phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
 {
+	if (!pdd->doorbell_index) {
+		int r = kfd_alloc_process_doorbells(pdd->dev,
+						    &pdd->doorbell_index);
+		if (r)
+			return 0;
+	}
+
 	return pdd->dev->doorbell_base +
 		pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 6c83a519b3a1..951b63677248 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1499,11 +1499,6 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	if (!pdd)
 		return NULL;
 
-	if (kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
-		pr_err("Failed to alloc doorbell for pdd\n");
-		goto err_free_pdd;
-	}
-
 	if (init_doorbell_bitmap(&pdd->qpd, dev)) {
 		pr_err("Failed to init doorbell for process\n");
 		goto err_free_pdd;
-- 
2.32.0

