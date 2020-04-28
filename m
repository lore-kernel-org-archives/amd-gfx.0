Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4922C83000
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 13:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678E3206B9
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 13:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YcwTNLgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678E3206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B436E4A1;
	Tue, 28 Apr 2020 13:58:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E9576E49C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 13:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDv7RU1Bsaq8oWuI9tRVZ0xg4ObiaOC3yYVd91kuA8h+oVc1RL1iDqaYSTeEqps97du7NHXzYfKH32+TwL3sNLW3a2L44ikHhbxrJHOTdX4vOWWoQkBnc7DoauLq8JXT1ZwAwqJD0rCSA1UqkdqrTTBsPens1HKJsFXznXX9ikL86A5GVMv4lIh7r+Ghyp2guPLVj2ZiHkNKqeXGDNdbxiHZFSUFdp6uSlRJzjFPrm8BtPibafuz/bMY7EzDiuOa9kwe19wvIlrQxdS8vgoDJrjkPTIx7x5ORxaoaFkSrI1irlOzOe0U5ib/619F9qYWPBY+UBAZ17h47Hn6m4PD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nk8zq7RWtPcHaZx2r8Ax+ULnsIfSXqE48GyrslRqTo=;
 b=kPSI12Gy/d164orxWFobB2m2VBKiQZnPHPr93wA/0H3RWEc4KYqFNOOEzgqhZLlYoVXLN+m5lwkdApHaaS1yk4OJrbnMy4mEwajIHbHXncfqecX5IhrSX2F9AyrZ2KOrHsD3IjXWnzxJgEQ9jz1mKmWMhkpuT8E6fW9zDqpoQa4UhVwWmCphEFz1PQY6q9zDJgHPs9n9dc+Vz04QbEJ4VDq6cbLl06NjdIA7tcR0OG3QgRbbsFATEpuA2gkf4Dqu1KLIopllstwV0n2WeJO3TWIfQLceNKUuHR3HzahPB2clThccr1UHQRM1wNyN95BCkPUM2if/mtig6+GYw/OjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nk8zq7RWtPcHaZx2r8Ax+ULnsIfSXqE48GyrslRqTo=;
 b=YcwTNLgi94SAxEHduuDv7KXpBdb0A0arKVeAY7LJI2aiWsxUSlK4b0VmlrZYaCL6pc8pBP1C+B+D6/r8qfKgR2vCNp0S/RYl/jmwLTBBq9Dx7CF7ywQN3xVQrBMxO9I4QyMwypraETfyfQYlWjIyf4dg/Z7hly7reJ17g2ah+7g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3290.namprd12.prod.outlook.com (2603:10b6:5:189::14)
 by DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 13:58:26 +0000
Received: from DM6PR12MB3290.namprd12.prod.outlook.com
 ([fe80::f5f8:6c00:6763:a2d2]) by DM6PR12MB3290.namprd12.prod.outlook.com
 ([fe80::f5f8:6c00:6763:a2d2%7]) with mapi id 15.20.2937.026; Tue, 28 Apr 2020
 13:58:26 +0000
From: Gang Ba <gaba@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd: add Streaming Performance Monitor feature
Date: Tue, 28 Apr 2020 09:58:14 -0400
Message-Id: <1588082294-21523-1-git-send-email-gaba@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::17) To DM6PR12MB3290.namprd12.prod.outlook.com
 (2603:10b6:5:189::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Devmachine.amd.com (165.204.55.251) by
 YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2958.19 via Frontend
 Transport; Tue, 28 Apr 2020 13:58:26 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f0815c3-699b-4790-1ec9-08d7eb7c3935
X-MS-TrafficTypeDiagnostic: DM6PR12MB3914:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3914F0090577B69BF352EEEFFFAC0@DM6PR12MB3914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3290.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(6486002)(66556008)(5660300002)(81156014)(8676002)(478600001)(8936002)(66946007)(30864003)(66476007)(186003)(36756003)(316002)(2906002)(6916009)(16526019)(7696005)(6666004)(2616005)(956004)(26005)(52116002)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VUJrUd1E3cGIacSlZzf1z4xygUDFx4Gp46JFX6lJOpkPJ7AuMABrYhU0e9NOniGwxslCDHLOAf6yvpRjAk2VR86kC05IQLslvXi8qcBaSefdw7CjrmPGIlXPsdiGdfXQiGf1BGGX9V/oTnn7mWLUITkQej7fK6xsdoAeNb7iuFfRC4L/MfpoQ9Uer37pO18uvAGbp1Pxch6qhC9OJ3NszO2DHdlGBz5jMxGcP3W1VsVbroj1wayz7v5vBq1+iVwOLfc10RvRqF2T/y00asmVZAE0McKp03GmxE5Y8EmCmEn1mLUhBublCSH4qX67lxI2IAeiu9waYZg5NyYKl9lgrIX5Zl04r/u6keM5Uqn4EV+5D4zwpURbYG7iv7HKyTV4IFXMRdeMbw5+3kOVP7yECz//oiINIadHAOiDr/pMpWF71/ZrbgqKj6cvLR7MnfZ
X-MS-Exchange-AntiSpam-MessageData: arHHCtYnu4hoPdDpX2n7mddN38uP4iN7amAKNucZKuegsQJvMPgcXm8a+gNOR93ndqWgyqcgPMEuQr+lcVqCRuNafTxgoIdPzm2JjWLnKpsgb9C/guDbkAXa3Za+qgGUoL3tyFqdbkBLoBtyyL9RozBKiNpeQj3CJLkI+ExXXSr2wdg54BO3IJQRPEYBp2qobgyu2iBo8hbtnvb4xcHuK9xSScpfSKu7rDCy/+W7fKlMEybJ25KRa1hnSRogcXnxWr74PybwoWBObAld62O96x1HUl6z3sJCbi47067nH4pHkPPdyemqQ7zyxlGF3zZKvdEHr2gp81Oxwm3df30XLrAaTO2w7kxl69NedEfNcjBoB5PYKLzzkghG4dNaGwpK/6xXkS32JWgJdsJ/O7v//q94hXel27iom3tiZQmUDdbQj4k4zGaRPdr3dqHIs4N7/b0mTYZ+DPasY0anN0sUoh9SDyOARLM9yEeIkwYTTWxrilN/1ZiuEKUSTHKy9XRM3pMu7nhXNrzxCtHh3TVSC7UItC50RLtDhUz4/cYGb53UCuHO7FLkpbD+kYzBQ5Jq/AN/n54jF17blDfKcuR4pu3l/cOxag0Fl8EUEWxc1G/nNtxKkufqfERZzpKPAHajORHwQzS7/yzDBqddDL1HI6mAZJ08/2CVZyw6VuFnCCtWao/revadsnqW2t8gmewfMIIv2At4cgwJIYAtOH5c0YemMGrjp6SLv7Smw4eZtOdwIUNrT6fmbSVOM2ZjU13RC5HX3DSBzcLITQtV49o1h2hulrO//TCe3ba2LEJesfg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0815c3-699b-4790-1ec9-08d7eb7c3935
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 13:58:26.7597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M11oV8d8Kj7EbNGuiG3BJgA53PWjBDcpNsB+XzEftoI+WwkqBbSoji4+hMsvgtfY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3914
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Gang Ba <gaba@amd.com>
Change-Id: If83ee0a14ef834699de6733eeab0f140159bbd6e
---
 drivers/gpu/drm/amd/amdgpu/Makefile                |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c | 165 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |  27 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 175 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              | 176 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 168 ++++++
 drivers/gpu/drm/amd/amdkfd/Makefile                |   3 +-
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c   |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  17 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |  11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  20 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_spm.c               | 577 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/soc15_int.h             |   1 +
 include/uapi/linux/kfd_ioctl.h                     |  55 +-
 16 files changed, 1413 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_spm.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 210d57a..1498b18 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -177,7 +177,8 @@ amdgpu-y += \
 	 amdgpu_amdkfd_gfx_v8.o \
 	 amdgpu_amdkfd_gfx_v9.o \
 	 amdgpu_amdkfd_arcturus.o \
-	 amdgpu_amdkfd_gfx_v10.o
+	 amdgpu_amdkfd_gfx_v10.o \
+	 amdgpu_amdkfd_rlc_spm.o \
 
 ifneq ($(CONFIG_DRM_AMDGPU_CIK),)
 amdgpu-y += amdgpu_amdkfd_gfx_v7.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index d065c50..fdc438a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -246,6 +246,16 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);
 int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
 				struct tile_config *config);
 
+void amdgpu_amdkfd_rlc_spm_cntl(struct kgd_dev *kgd, bool cntl);
+int amdgpu_amdkfd_rlc_spm(struct kgd_dev *kgd, void *args);
+void amdgpu_amdkfd_rlc_spm_acquire(struct kgd_dev *kgd, u64 gpu_addr, u32 size);
+int amdgpu_amdkfd_rlc_spm_release(struct kgd_dev *kgd);
+u32 amdgpu_amdkfd_rlc_spm_get_rdptr(struct kgd_dev *kgd);
+void amdgpu_amdkfd_rlc_spm_set_rdptr(struct kgd_dev *kgd, u32 rptr);
+u32 amdgpu_amdkfd_rlc_spm_get_wrptr(struct kgd_dev *kgd);
+void amdgpu_amdkfd_rlc_spm_set_wrptr(struct kgd_dev *kgd, u32 wptr);
+int amdgpu_amdkfd_rlc_spm_set_reg(struct kgd_dev *kgd, u64 uReg, u32 value);
+
 /* KGD2KFD callbacks */
 int kgd2kfd_init(void);
 void kgd2kfd_exit(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c
new file mode 100644
index 0000000..b492c1e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c
@@ -0,0 +1,165 @@
+/*
+ * Copyright 2014-2020 Advanced Micro Devices, Inc.
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
+#include <linux/dma-buf.h>
+#include <linux/list.h>
+#include <linux/pagemap.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
+
+#include "amdgpu_object.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_amdkfd.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+
+
+void amdgpu_amdkfd_rlc_spm_cntl(struct kgd_dev *kgd, bool cntl)
+{
+    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+    	struct amdgpu_spm *spm = &adev->gfx.spm;
+    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+
+    	spin_lock(&adev->gfx.kiq.ring_lock);
+    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+    	cntl == true ? adev->gfx.spm.spmf->start(adev):adev->gfx.spm.spmf->stop(adev);
+    	amdgpu_ring_commit(kiq_ring);
+    	spin_unlock(&adev->gfx.kiq.ring_lock);
+}
+
+u32 amdgpu_amdkfd_rlc_spm_get_rdptr(struct kgd_dev *kgd)
+{
+    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+    	struct amdgpu_spm *spm = &adev->gfx.spm;
+    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+    	u32 rptr = 0;
+
+    	spin_lock(&adev->gfx.kiq.ring_lock);
+    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+    	rptr = adev->gfx.spm.spmf->get_rdptr(adev);
+    	amdgpu_ring_commit(kiq_ring);
+    	spin_unlock(&adev->gfx.kiq.ring_lock);
+
+    	return rptr;
+}
+
+void amdgpu_amdkfd_rlc_spm_set_rdptr(struct kgd_dev *kgd, u32 rptr)
+{
+    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+    	struct amdgpu_spm *spm = &adev->gfx.spm;
+    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+
+    	spin_lock(&adev->gfx.kiq.ring_lock);
+    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+    	adev->gfx.spm.spmf->set_rdptr(adev, rptr);
+    	amdgpu_ring_commit(kiq_ring);
+    	spin_unlock(&adev->gfx.kiq.ring_lock);
+
+}
+
+u32 amdgpu_amdkfd_rlc_spm_get_wrptr(struct kgd_dev *kgd)
+{
+    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+    	struct amdgpu_spm *spm = &adev->gfx.spm;
+    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+    	u32 wptr;
+
+    	spin_lock(&adev->gfx.kiq.ring_lock);
+    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+    	wptr = adev->gfx.spm.spmf->get_wrptr(adev);
+    	amdgpu_ring_commit(kiq_ring);
+    	spin_unlock(&adev->gfx.kiq.ring_lock);
+    	return wptr;
+}
+
+void amdgpu_amdkfd_rlc_spm_set_wrptr(struct kgd_dev *kgd, u32 wptr)
+{
+    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+    	struct amdgpu_spm *spm = &adev->gfx.spm;
+    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+
+    	spin_lock(&adev->gfx.kiq.ring_lock);
+    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+    	adev->gfx.spm.spmf->set_wrptr(adev, wptr);
+    	amdgpu_ring_commit(kiq_ring);
+    	spin_unlock(&adev->gfx.kiq.ring_lock);
+}
+
+void amdgpu_amdkfd_rlc_spm_acquire(struct kgd_dev *kgd, u64 gpu_addr, u32 size)
+{
+    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+    	struct amdgpu_spm *spm = &adev->gfx.spm;
+    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+
+    	/* init spm vmid with 0xf */
+    	if (adev->gfx.rlc.funcs->update_spm_vmid)
+        	adev->gfx.rlc.funcs->update_spm_vmid(adev, 0x0);
+
+    	/* set spm ring registers */
+    	spin_lock(&adev->gfx.kiq.ring_lock);
+    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+    	adev->gfx.spm.spmf->set_spm_porfmon_ring_buf(adev, gpu_addr, size);
+    	amdgpu_ring_commit(kiq_ring);
+    	spin_unlock(&adev->gfx.kiq.ring_lock);
+}
+
+
+int amdgpu_amdkfd_rlc_spm_release(struct kgd_dev *kgd)
+{
+    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+    	struct amdgpu_spm *spm = &adev->gfx.spm;
+
+    	/* stop spm stream and interupt */
+    	spin_lock(&adev->gfx.kiq.ring_lock);
+    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+    	adev->gfx.spm.spmf->stop(adev);
+    	amdgpu_ring_commit(kiq_ring);
+    	spin_unlock(&adev->gfx.kiq.ring_lock);
+
+    	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
+
+    	/* revert spm vmid with 0xf */
+    	if (adev->gfx.rlc.funcs->update_spm_vmid)
+             adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+
+    	return 0;
+}
+
+int amdgpu_amdkfd_rlc_spm_set_reg(struct kgd_dev *kgd, u64 uReg, u32 value)
+{
+    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+    	struct amdgpu_spm *spm = &adev->gfx.spm;
+
+    	pr_debug("[%s]\n", __func__);
+
+    	/* stop spm stream and interupt */
+    	spin_lock(&adev->gfx.kiq.ring_lock);
+    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+    	adev->gfx.spm.spmf->set_reg(adev, uReg, value);
+    	amdgpu_ring_commit(kiq_ring);
+    	spin_unlock(&adev->gfx.kiq.ring_lock);
+
+    	return 0;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ee698f0..ba4da52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -105,6 +105,31 @@ struct amdgpu_kiq {
 	const struct kiq_pm4_funcs *pmf;
 };
 
+struct spm_funcs {
+	void (*start)(struct amdgpu_device *adev);
+	void (*stop)(struct amdgpu_device *adev);
+	void (*set_reg)(struct amdgpu_device *adev, uint64_t reg, uint32_t val);
+	u32 (*get_rdptr)(struct amdgpu_device *adev);
+	void (*set_rdptr)(struct amdgpu_device *adev, u32 rptr);
+	u32 (*get_wrptr)(struct amdgpu_device *adev);
+	void (*set_wrptr)(struct amdgpu_device *adev, u32 wptr);
+	void (*set_spm_porfmon_ring_buf)(struct amdgpu_device *adev, u64 gpu_rptr, u32 size);
+
+	/* Packet sizes */
+	int set_spm_config_size;
+	int get_spm_data_size;
+};
+
+struct amdgpu_spm {
+	const struct spm_funcs *spmf;
+	u64              spm_gpu_addr;
+	u32              spm_gpu_size;
+	u32              spm_ring_rptr;
+	u32              spm_ring_rptrsize_to_read;
+	struct amdgpu_bo *spm_obj;
+	void             *spm_cpu_addr;
+};
+
 /*
  * GPU scratch registers structures, functions & helpers
  */
@@ -256,6 +281,7 @@ struct amdgpu_gfx {
 	struct amdgpu_me		me;
 	struct amdgpu_mec		mec;
 	struct amdgpu_kiq		kiq;
+	struct amdgpu_spm		spm;
 	struct amdgpu_scratch		scratch;
 	const struct firmware		*me_fw;	/* ME firmware */
 	uint32_t			me_fw_version;
@@ -292,6 +318,7 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		priv_reg_irq;
 	struct amdgpu_irq_src		priv_inst_irq;
 	struct amdgpu_irq_src		cp_ecc_error_irq;
+	struct amdgpu_irq_src		spm_irq;
 	struct amdgpu_irq_src		sq_irq;
 	struct sq_work			sq_work;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 63ac430..9c507d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4121,6 +4121,13 @@ static int gfx_v10_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* KIQ SPM */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
+			      GFX_10_1__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,
+			      &adev->gfx.spm_irq);
+	if (r)
+		return r;
+
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
 			      GFX_10_1__SRCID__CP_EOP_INTERRUPT,
@@ -6603,6 +6610,7 @@ static int gfx_v10_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
 #ifndef BRING_UP_DEBUG
 	if (amdgpu_async_gfx_ring) {
 		r = gfx_v10_0_kiq_disable_kgq(adev);
@@ -6768,6 +6776,126 @@ static void gfx_v10_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 				    (1 << (oa_size + oa_base)) - (1 << oa_base));
 }
 
+static void gfx_v10_0_spm_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	uint32_t data = 0;
+	u8 se;
+
+	for (se = 0; se < adev->gfx.config.max_shader_engines + 1; ++se)
+	{
+		uint32_t mux_addr_reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_GLOBAL_MUXSEL_ADDR);
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+			INSTANCE_BROADCAST_WRITES, 1);
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+			SA_BROADCAST_WRITES, 1);
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+			SE_BROADCAST_WRITES, 1);
+
+		if (se < adev->gfx.config.max_shader_engines) // SE else GB
+		{
+			data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se);
+			mux_addr_reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_SE_MUXSEL_ADDR);
+		}
+		gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
+		gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg, 0);
+	}
+
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, 0);
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1);
+	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
+
+	data = 0;
+	data |= CP_PERFMON_STATE_DISABLE_AND_RESET <<4 ;
+	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+	data = 0;
+	data |= STRM_PERFMON_STATE_START_COUNTING <<4 ;
+	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL) ,1);
+}
+
+static void gfx_v10_0_spm_stop(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	uint32_t data = 0;
+
+	data = CP_PERFMON_STATE_STOP_COUNTING;
+	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+	data |= (1<<10);
+	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL), 0);
+}
+
+static u32 gfx_v10_0_spm_get_rdptr(struct amdgpu_device *adev)
+{
+	return RREG32_SOC15(GC, 0, mmRLC_SPM_RING_RDPTR);;
+}
+
+static void gfx_v10_0_spm_set_rdptr(struct amdgpu_device *adev,  u32 rptr)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+
+	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), rptr);
+}
+
+static u32 gfx_v10_0_spm_get_wrptr(struct amdgpu_device *adev)
+{
+	return RREG32_SOC15(GC, 0, mmRLC_SPM_RING_WRPTR);
+}
+
+static void gfx_v10_0_spm_set_wrptr(struct amdgpu_device *adev,  u32 wptr)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+
+	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_WRPTR), wptr);
+}
+
+static void gfx_v10_0_set_spm_porfmon_ring_buf(struct amdgpu_device *adev, u64 gpu_addr, u32 size)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+
+	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0,
+			mmRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_addr));
+
+	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_BASE_HI), upper_32_bits (gpu_addr));
+
+	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false,
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_SIZE), size);
+}
+
+static void gfx_v10_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, u32 value)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	uint32_t grbm_cntl;
+	grbm_cntl = adev->reg_offset[GC_HWIP][0][1] + reg;
+
+	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, grbm_cntl, value);
+}
+
+static const struct spm_funcs gfx_v10_0_spm_funcs = {
+	.start = gfx_v10_0_spm_start,
+	.stop = gfx_v10_0_spm_stop,
+	.get_rdptr= gfx_v10_0_spm_get_rdptr,
+	.set_rdptr= gfx_v10_0_spm_set_rdptr,
+	.get_wrptr= gfx_v10_0_spm_get_wrptr,
+	.set_wrptr= gfx_v10_0_spm_set_wrptr,
+	.set_spm_porfmon_ring_buf = gfx_v10_0_set_spm_porfmon_ring_buf,
+	.set_reg = gfx_v10_0_spm_set_reg,
+	.set_spm_config_size = 3,
+	.get_spm_data_size = 128,
+};
+
+static void gfx_v10_0_set_spm_funcs(struct amdgpu_device *adev)
+{
+	adev->gfx.spm.spmf = &gfx_v10_0_spm_funcs;
+}
+
+
 static int gfx_v10_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -6776,6 +6904,7 @@ static int gfx_v10_0_early_init(void *handle)
 
 	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
 
+	gfx_v10_0_set_spm_funcs(adev);
 	gfx_v10_0_set_kiq_pm4_funcs(adev);
 	gfx_v10_0_set_ring_funcs(adev);
 	gfx_v10_0_set_irq_funcs(adev);
@@ -6794,6 +6923,10 @@ static int gfx_v10_0_late_init(void *handle)
 	if (r)
 		return r;
 
+        r = amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+        if (r)
+		return r;
+
 	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
 	if (r)
 		return r;
@@ -6860,6 +6993,7 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
 
+
 		/* MGLS is a global flag to control all MGLS in GFX */
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGLS) {
 			/* 2 - RLC memory Light sleep */
@@ -8018,6 +8152,39 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+static int gfx_v10_0_spm_set_interrupt_state(struct amdgpu_device *adev,
+					     struct amdgpu_irq_src *src,
+					     unsigned int type,
+					     enum amdgpu_interrupt_state state)
+{
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 0);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 1);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int gfx_v10_0_spm_irq(struct amdgpu_device *adev,
+			     struct amdgpu_irq_src *source,
+			     struct amdgpu_iv_entry *entry)
+{
+	u8 me_id, pipe_id, queue_id;
+
+	me_id = (entry->ring_id & 0x0c) >> 2;
+	pipe_id = (entry->ring_id & 0x03) >> 0;
+	queue_id = (entry->ring_id & 0x70) >> 4;
+	pr_debug ("IH: RLC_RPM_INT, me:%d, pipe:%d, queue:%d\n",
+                                         me_id, pipe_id, queue_id);
+	return  0; /* This prevents sending it to KFD */
+}
+
+
 static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.name = "gfx_v10_0",
 	.early_init = gfx_v10_0_early_init,
@@ -8189,6 +8356,11 @@ static const struct amdgpu_irq_src_funcs gfx_v10_0_kiq_irq_funcs = {
 	.process = gfx_v10_0_kiq_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v10_0_spm_irq_funcs = {
+    .set = gfx_v10_0_spm_set_interrupt_state,
+    .process = gfx_v10_0_spm_irq,
+};
+
 static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
@@ -8197,6 +8369,9 @@ static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.kiq.irq.num_types = AMDGPU_CP_KIQ_IRQ_LAST;
 	adev->gfx.kiq.irq.funcs = &gfx_v10_0_kiq_irq_funcs;
 
+	adev->gfx.spm_irq.num_types = 1;
+	adev->gfx.spm_irq.funcs = &gfx_v10_0_spm_irq_funcs;
+
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v10_0_priv_reg_irq_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 14790f8..1125b91 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1955,6 +1955,12 @@ static int gfx_v8_0_sw_init(void *handle)
 	adev->gfx.mec.num_pipe_per_mec = 4;
 	adev->gfx.mec.num_queue_per_pipe = 8;
 
+	/* KIQ SPM */
+	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY,	VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR,
+			      &adev->gfx.spm_irq);
+	if (r)
+        return r;
+
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, VISLANDS30_IV_SRCID_CP_END_OF_PIPE, &adev->gfx.eop_irq);
 	if (r)
@@ -4927,6 +4933,7 @@ static int gfx_v8_0_hw_fini(void *handle)
 	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 
 	amdgpu_irq_put(adev, &adev->gfx.sq_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
 
 	/* disable KCQ to avoid CPC touch memory not valid anymore */
 	gfx_v8_0_kcq_disable(adev);
@@ -5291,6 +5298,126 @@ static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q
 };
 
+static void gfx_v8_0_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
+				       bool wc, uint32_t reg, uint32_t val)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
+	amdgpu_ring_write(ring, WRITE_DATA_ENGINE_SEL(eng_sel) |
+				WRITE_DATA_DST_SEL(0) |
+				(wc ? WR_CONFIRM : 0));
+	amdgpu_ring_write(ring, reg);
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, val);
+}
+
+static void gfx_v8_0_spm_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	uint32_t data = 0;
+	u8 se;
+
+	for (se = 0; se < adev->gfx.config.max_shader_engines + 1; ++se)
+	{
+		uint32_t mux_addr_reg = mmRLC_SPM_GLOBAL_MUXSEL_ADDR;
+
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+			INSTANCE_BROADCAST_WRITES, 1);
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+			SH_BROADCAST_WRITES, 1);
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+			SE_BROADCAST_WRITES, 1);
+
+		if (se < adev->gfx.config.max_shader_engines) // SE else GB
+		{
+			data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se);
+
+			mux_addr_reg = mmRLC_SPM_SE_MUXSEL_ADDR;
+		}
+		gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmGRBM_GFX_INDEX, data);
+		// init addr
+		gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg, data);
+	}
+
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, 0);
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1);
+	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmGRBM_GFX_INDEX, data);
+
+	data = 0;
+	data |= CP_PERFMON_STATE_DISABLE_AND_RESET <<4 ;
+	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL, data);
+
+	data = 0;
+	data |= STRM_PERFMON_STATE_START_COUNTING <<4 ;
+	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL,	data);
+
+	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_INT_CNTL ,1);
+}
+
+static void gfx_v8_0_spm_stop(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	uint32_t data = 0;
+
+	data = CP_PERFMON_STATE_STOP_COUNTING;
+	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL, data);
+	data |= (1<<10);
+	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL, data);
+
+	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_INT_CNTL, 0);
+}
+
+
+static u32 gfx_v8_0_spm_get_rdptr(struct amdgpu_device *adev)
+{
+	return RREG32 (mmRLC_SPM_RING_RDPTR);
+}
+
+static void gfx_v8_0_spm_set_rdptr(struct amdgpu_device *adev,  u32 rptr)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+
+	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_RING_RDPTR, rptr);
+}
+
+static u32 gfx_v8_0_spm_get_wrptr(struct amdgpu_device *adev)
+{
+	return  -1;
+}
+
+static void gfx_v8_0_set_spm_porfmon_ring_buf(struct amdgpu_device *adev, u64 gpu_addr, u32 size)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+
+	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_PERFMON_RING_BASE_LO, lower_32_bits(gpu_addr));
+
+	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_PERFMON_RING_BASE_HI, upper_32_bits (gpu_addr));
+
+	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_PERFMON_RING_SIZE, size);
+}
+
+static void gfx_v8_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, u32 value)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, reg, value);
+}
+
+static const struct spm_funcs gfx_v8_0_spm_funcs = {
+	.start = gfx_v8_0_spm_start,
+	.stop = gfx_v8_0_spm_stop,
+	.get_rdptr= gfx_v8_0_spm_get_rdptr,
+	.set_rdptr= gfx_v8_0_spm_set_rdptr,
+	.get_wrptr= gfx_v8_0_spm_get_wrptr,
+	.set_spm_porfmon_ring_buf = gfx_v8_0_set_spm_porfmon_ring_buf,
+	.set_reg = gfx_v8_0_spm_set_reg,
+	.set_spm_config_size = 3,
+	.get_spm_data_size = 128,
+};
+
+static void gfx_v8_0_set_spm_funcs(struct amdgpu_device *adev)
+{
+	adev->gfx.spm.spmf = &gfx_v8_0_spm_funcs;
+}
+
 static int gfx_v8_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -5298,6 +5425,8 @@ static int gfx_v8_0_early_init(void *handle)
 	adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
 	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
 	adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
+
+	gfx_v8_0_set_spm_funcs(adev);
 	gfx_v8_0_set_ring_funcs(adev);
 	gfx_v8_0_set_irq_funcs(adev);
 	gfx_v8_0_set_gds_init(adev);
@@ -5338,6 +5467,10 @@ static int gfx_v8_0_late_init(void *handle)
 		return r;
 	}
 
+	r = amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -6845,6 +6978,41 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
 }
 
+static int gfx_v8_0_spm_set_interrupt_state(struct amdgpu_device *adev,
+					     struct amdgpu_irq_src *src,
+					     unsigned int type,
+					     enum amdgpu_interrupt_state state)
+{
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		WREG32(mmRLC_SPM_INT_CNTL, 0);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		WREG32(mmRLC_SPM_INT_CNTL, 1);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int gfx_v8_0_spm_irq(struct amdgpu_device *adev,
+			     struct amdgpu_irq_src *source,
+			     struct amdgpu_iv_entry *entry)
+{
+	u8 me_id, pipe_id, queue_id;
+	struct amdgpu_ring *ring = &(adev->gfx.kiq.ring);
+
+	me_id = (entry->ring_id & 0x0c) >> 2;
+	pipe_id = (entry->ring_id & 0x03) >> 0;
+	queue_id = (entry->ring_id & 0x70) >> 4;
+	pr_debug("IH: RLC_RPM_INT, me:%d, pipe:%d, queue:%d\n",
+			me_id, pipe_id, queue_id);
+
+	amdgpu_fence_process(ring);
+	return 0;
+}
+
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.name = "gfx_v8_0",
 	.early_init = gfx_v8_0_early_init,
@@ -7005,11 +7173,19 @@ static const struct amdgpu_irq_src_funcs gfx_v8_0_sq_irq_funcs = {
 	.process = gfx_v8_0_sq_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v8_0_spm_irq_funcs = {
+	.set = gfx_v8_0_spm_set_interrupt_state,
+	.process = gfx_v8_0_spm_irq,
+};
+
 static void gfx_v8_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
 	adev->gfx.eop_irq.funcs = &gfx_v8_0_eop_irq_funcs;
 
+	adev->gfx.spm_irq.num_types = 1;
+	adev->gfx.spm_irq.funcs = &gfx_v8_0_spm_irq_funcs;
+
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v8_0_priv_reg_irq_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2767c6d..bfde274 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2249,6 +2249,13 @@ static int gfx_v9_0_sw_init(void *handle)
 	adev->gfx.mec.num_pipe_per_mec = 4;
 	adev->gfx.mec.num_queue_per_pipe = 8;
 
+	/* KIQ SPM */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
+			      GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,
+			      &adev->gfx.spm_irq);
+	if (r)
+        return r;
+
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_EOP_INTERRUPT, &adev->gfx.eop_irq);
 	if (r)
@@ -3907,6 +3914,7 @@ static int gfx_v9_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
 	/* DF freeze and kcq disable will fail */
@@ -4617,6 +4625,121 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	return r;
 }
 
+static void gfx_v9_0_spm_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	uint32_t data = 0;
+	u8 se;
+
+	for (se = 0; se < adev->gfx.config.max_shader_engines + 1; ++se)
+	{
+		uint32_t mux_addr_reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_GLOBAL_MUXSEL_ADDR);
+
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+			INSTANCE_BROADCAST_WRITES, 1);
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+			SH_BROADCAST_WRITES, 1);
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+			SE_BROADCAST_WRITES, 1);
+
+		if (se < adev->gfx.config.max_shader_engines) // SE else GB
+		{
+			data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se);
+
+			mux_addr_reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_SE_MUXSEL_ADDR);
+		}
+		gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
+		// init addr
+		gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg, data);
+	}
+
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, 0);
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1);
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
+
+	data = 0;
+	data |= CP_PERFMON_STATE_DISABLE_AND_RESET <<4 ;
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+	data = 0;
+	data |= STRM_PERFMON_STATE_START_COUNTING <<4 ;
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL) ,1);
+}
+
+
+static void gfx_v9_0_spm_stop(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	uint32_t data = 0;
+
+
+	data = CP_PERFMON_STATE_STOP_COUNTING;
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+	data |= (1<<10);
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL), 0);
+}
+
+static u32 gfx_v9_0_spm_get_rdptr(struct amdgpu_device *adev)
+{
+	return RREG32_SOC15(GC, 0, mmRLC_SPM_RING_RDPTR);;
+}
+
+static void gfx_v9_0_spm_set_rdptr(struct amdgpu_device *adev,  u32 rptr)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), rptr);
+}
+
+static u32 gfx_v9_0_spm_get_wrptr(struct amdgpu_device *adev)
+{
+	return -1;
+}
+
+static void gfx_v9_0_set_spm_porfmon_ring_buf(struct amdgpu_device *adev, u64 gpu_addr, u32 size)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0,
+                               mmRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_addr));
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                               SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_BASE_HI), upper_32_bits (gpu_addr));
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                               SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_SIZE), size);
+}
+
+static void gfx_v9_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, u32 value)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	uint32_t grbm_cntl;
+	grbm_cntl = adev->reg_offset[GC_HWIP][0][1] + reg;
+
+	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, grbm_cntl, value);
+}
+
+static const struct spm_funcs gfx_v9_0_spm_funcs = {
+	.start = gfx_v9_0_spm_start,
+	.stop = gfx_v9_0_spm_stop,
+	.get_rdptr= gfx_v9_0_spm_get_rdptr,
+	.set_rdptr= gfx_v9_0_spm_set_rdptr,
+	.get_wrptr= gfx_v9_0_spm_get_wrptr,
+	.set_spm_porfmon_ring_buf = gfx_v9_0_set_spm_porfmon_ring_buf,
+	.set_reg = gfx_v9_0_spm_set_reg,
+	.set_spm_config_size = 3,
+	.get_spm_data_size = 128,
+};
+
+static void gfx_v9_0_set_spm_funcs(struct amdgpu_device *adev)
+{
+	adev->gfx.spm.spmf = &gfx_v9_0_spm_funcs;
+}
+
 static int gfx_v9_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -4626,6 +4749,7 @@ static int gfx_v9_0_early_init(void *handle)
 	else
 		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
 	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
+	gfx_v9_0_set_spm_funcs(adev);
 	gfx_v9_0_set_kiq_pm4_funcs(adev);
 	gfx_v9_0_set_ring_funcs(adev);
 	gfx_v9_0_set_irq_funcs(adev);
@@ -4677,6 +4801,10 @@ static int gfx_v9_0_late_init(void *handle)
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+	if (r)
+		return r;
+
 	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
 	if (r)
 		return r;
@@ -6657,6 +6785,39 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
 }
 
+static int gfx_v9_0_spm_set_interrupt_state(struct amdgpu_device *adev,
+					     struct amdgpu_irq_src *src,
+					     unsigned int type,
+					     enum amdgpu_interrupt_state state)
+{
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		WREG32(mmRLC_SPM_INT_CNTL, 0);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		WREG32(mmRLC_SPM_INT_CNTL, 1);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int gfx_v9_0_spm_irq(struct amdgpu_device *adev,
+			     struct amdgpu_irq_src *source,
+			     struct amdgpu_iv_entry *entry)
+{
+	u8 me_id, pipe_id, queue_id;
+
+	me_id = (entry->ring_id & 0x0c) >> 2;
+	pipe_id = (entry->ring_id & 0x03) >> 0;
+	queue_id = (entry->ring_id & 0x70) >> 4;
+	pr_debug("IH: RLC_RPM_INT, me:%d, pipe:%d, queue:%d\n",
+			me_id, pipe_id, queue_id);
+
+	return 0; /* This also prevents sending it to KFD */
+}
+
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.name = "gfx_v9_0",
 	.early_init = gfx_v9_0_early_init,
@@ -6825,12 +6986,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_0_cp_ecc_error_irq_funcs = {
 	.process = amdgpu_gfx_cp_ecc_error_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v9_0_spm_irq_funcs = {
+	.set = gfx_v9_0_spm_set_interrupt_state,
+	.process = gfx_v9_0_spm_irq,
+};
 
 static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
 	adev->gfx.eop_irq.funcs = &gfx_v9_0_eop_irq_funcs;
 
+	adev->gfx.spm_irq.num_types = 1;
+	adev->gfx.spm_irq.funcs = &gfx_v9_0_spm_irq_funcs;
+
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v9_0_priv_reg_irq_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index 6147462..43edba0 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -53,7 +53,8 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_int_process_v9.o \
 		$(AMDKFD_PATH)/kfd_dbgdev.o \
 		$(AMDKFD_PATH)/kfd_dbgmgr.o \
-		$(AMDKFD_PATH)/kfd_crat.o
+		$(AMDKFD_PATH)/kfd_crat.o	\
+		$(AMDKFD_PATH)/kfd_spm.o
 
 ifneq ($(CONFIG_AMD_IOMMU_V2),)
 AMDKFD_FILES += $(AMDKFD_PATH)/kfd_iommu.o
diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index 9f59ba9..cd394cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -24,6 +24,7 @@
 #include "kfd_events.h"
 #include "cik_int.h"
 #include "amdgpu_amdkfd.h"
+#include "ivsrcid/ivsrcid_vislands30.h"
 
 static bool cik_event_interrupt_isr(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
@@ -37,6 +38,11 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
 	uint16_t pasid;
 	bool ret;
 
+	vmid = f2g->read_vmid_from_vmfault_reg(dev->kgd);
+
+	if ((ihre->source_id == VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR) && (vmid == 0))
+		 return (kfd_spm_interrupt_isr (dev, ihre->source_id, ihre->source_id));
+
 	/* This workaround is due to HW/FW limitation on Hawaii that
 	 * VMID and PASID are not written into ih_ring_entry
 	 */
@@ -49,7 +55,6 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
 		*patched_flag = true;
 		*tmp_ihre = *ihre;
 
-		vmid = f2g->read_vmid_from_vmfault_reg(dev->kgd);
 		ret = f2g->get_atc_vmid_pasid_mapping_info(dev->kgd, vmid, &pasid);
 
 		tmp_ihre->ring_id &= 0x000000ff;
@@ -95,6 +100,9 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
 	if (pasid == 0)
 		return;
 
+	if ((ihre->source_id == VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR) && (vmid == 0))
+		kfd_spm_interrupt_wq(dev, ihre->source_id);
+
 	if (ihre->source_id == CIK_INTSRC_CP_END_OF_PIPE)
 		kfd_signal_event_interrupt(pasid, context_id, 28);
 	else if (ihre->source_id == CIK_INTSRC_SDMA_TRAP)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f8fa03a..bfc83beb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1732,6 +1732,20 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	return r;
 }
 
+static int kfd_ioctl_rlc_spm(struct file *filep,
+				   struct kfd_process *p, void *data)
+{
+	struct kfd_ioctl_spm_args *args = data;
+	int err;
+
+	err = kfd_rlc_spm(p,
+			(void __user *)args,
+			 args->buf_size,
+			 args->op);
+
+	return err;
+}
+
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
 			    .cmd_drv = 0, .name = #ioctl}
@@ -1827,6 +1841,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_ALLOC_QUEUE_GWS,
 			kfd_ioctl_alloc_queue_gws, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_RLC_SPM,
+			kfd_ioctl_rlc_spm, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index e05d75e..481f0ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -24,6 +24,7 @@
 #include "kfd_events.h"
 #include "soc15_int.h"
 #include "kfd_device_queue_manager.h"
+#include "ivsrcid/gfx/irqsrcs_gfx_9_0.h"
 
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
@@ -35,12 +36,15 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 
 	/* Only handle interrupts from KFD VMIDs */
 	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
+	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
+	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
+	if ((source_id == GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT) && (vmid == 0))
+		 return (kfd_spm_interrupt_isr (dev, source_id, client_id));
+
 	if (vmid < dev->vm_info.first_vmid_kfd ||
 	    vmid > dev->vm_info.last_vmid_kfd)
 		return 0;
 
-	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
-	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
 	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
 
 	/* This is a known issue for gfx9. Under non HWS, pasid is not set
@@ -95,6 +99,9 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
 	context_id = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
 
+	if ((source_id == GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT) && (vmid == 0))
+		kfd_spm_interrupt_wq(dev, source_id);
+
 	if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
 		kfd_signal_event_interrupt(pasid, context_id, 32);
 	else if (source_id == SOC15_INTSRC_SDMA_TRAP)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 43b888b..707d672 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -309,6 +309,9 @@ struct kfd_dev {
 
 	/* Global GWS resource shared b/t processes*/
 	void *gws;
+
+	/*spm process id */
+	unsigned int spm_pasid;
 };
 
 enum kfd_mempool {
@@ -740,6 +743,13 @@ struct kfd_process {
 	struct kobject *kobj;
 	struct kobject *kobj_queues;
 	struct attribute attr_pasid;
+	/* spm data */
+	struct kfd_spm_cntr *spm_cntr;
+	bool is_spm_acquired;
+	/* Work items for tranfer data to user */
+	struct delayed_work copy_to_user_work;
+	/* spm-related data */
+	struct mutex spm_mutex;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
@@ -1045,10 +1055,20 @@ int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process *p);
 
 bool kfd_is_locked(void);
 
+void kfd_spm_init_process(struct kfd_process *p);
+int kfd_rlc_spm(struct kfd_process *p,  void __user *data,
+		       uint32_t buf_size, __u32 op);
+
 /* Compute profile */
 void kfd_inc_compute_active(struct kfd_dev *dev);
 void kfd_dec_compute_active(struct kfd_dev *dev);
 
+/* spm interrupt */
+bool kfd_spm_interrupt_isr(struct kfd_dev *dev,
+					uint16_t source_id,	uint32_t client_id);
+void kfd_spm_interrupt_wq(struct kfd_dev *dev,	uint16_t source_id);
+
+
 /* Cgroup Support */
 /* Check with device cgroup if @kfd device is accessible */
 static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index fe0cd49..338868d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -746,6 +746,7 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
 	process->last_restore_timestamp = get_jiffies_64();
 	kfd_event_init_process(process);
+	kfd_spm_init_process(process);
 	process->is_32bit_user_mode = in_compat_syscall();
 
 	process->pasid = kfd_pasid_alloc();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_spm.c b/drivers/gpu/drm/amd/amdkfd/kfd_spm.c
new file mode 100644
index 0000000..773e2ee
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_spm.c
@@ -0,0 +1,577 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#include <linux/device.h>
+#include "kfd_priv.h"
+#include "amdgpu_amdkfd.h"
+#include "soc15_int.h"
+#include "ivsrcid/gfx/irqsrcs_gfx_9_0.h"
+#include "ivsrcid/ivsrcid_vislands30.h"
+#include <linux/delay.h>
+
+#define SAMPLING_MAX 4
+
+struct user_buf {
+        uint64_t __user *user_addr;
+        u32 ubufsize;
+
+};
+
+struct kfd_spm_cntr {
+        struct kgd_dev *kgd;
+        u64    spm_gpu_addr;
+        u32    spm_ring_buf_size;
+        u32    spm_ring_buf_mark;
+	    u32	   spm_ring_rptr;
+        u32    spm_ring_wptr;
+        u32    spm_ring_size_copied;
+        void   *spm_obj;
+        u32    *spm_cpu_addr;
+        struct user_buf ubuf [SAMPLING_MAX];
+        u32    buf_count;
+        bool   is_uesr_buf_filled;
+        bool   is_nowait;
+        struct task_struct *thread;
+        bool   thread_ready;
+        char   *name;
+        wait_queue_head_t spm_wq;
+        int    wanted_cluster;
+        bool   is_timeout;
+};
+
+static int kfd_spm_data_cocy (struct kfd_spm_cntr * spm_cntr, u32 size_to_copy)
+{
+        u32 user_buf_space_left;
+        int ret = 0;
+        u32 bufSize;
+        uint64_t __user * user_address;
+        uint64_t * ring_buf;
+        
+        pr_debug("[%s]\n", __func__);
+
+        bufSize = spm_cntr->ubuf[0].ubufsize;
+        user_address = (uint64_t*)((uint64_t)spm_cntr->ubuf[0].user_addr + spm_cntr->spm_ring_size_copied);
+        ring_buf =  (uint64_t*)((uint64_t)spm_cntr->spm_cpu_addr + spm_cntr->spm_ring_rptr);
+
+        if (user_address == NULL)
+	        return -EFAULT;
+
+        user_buf_space_left = bufSize - spm_cntr->spm_ring_size_copied;
+
+        if (size_to_copy <= user_buf_space_left) {
+		ret = copy_to_user(user_address, ring_buf, size_to_copy);
+	     	if (ret) {
+	        	pr_err("copy_to_user failed, ret = %x\n", ret);
+			return -EFAULT;
+              	}
+		spm_cntr->spm_ring_size_copied += size_to_copy;
+	} else {
+		size_to_copy = spm_cntr->spm_ring_buf_size - spm_cntr->spm_ring_size_copied;
+		ret = copy_to_user(user_address, ring_buf, user_buf_space_left);
+		if (ret)
+			return -EFAULT;
+
+		spm_cntr->spm_ring_size_copied = bufSize;
+		spm_cntr->is_uesr_buf_filled = true;
+	}
+
+	return ret;
+}
+
+static int kfd_spm_reag_ring_buf_polling (struct kfd_spm_cntr * spm_cntr, long timeout)
+{
+	u32 size_to_copy;
+	int ret = 0;
+
+	pr_info("[%s]\n", __func__);
+
+	while (spm_cntr->is_uesr_buf_filled != true){
+		spm_cntr->spm_ring_rptr = amdgpu_amdkfd_rlc_spm_get_rdptr(spm_cntr->kgd) & spm_cntr->spm_ring_buf_mark;
+#if 1
+		spm_cntr->spm_ring_wptr = amdgpu_amdkfd_rlc_spm_get_wrptr(spm_cntr->kgd) & spm_cntr->spm_ring_buf_mark;
+#else
+		spm_cntr->spm_ring_wptr = spm_cntr->spm_cpu_addr[0] & spm_cntr->spm_ring_buf_mark;
+#endif
+
+		if ((spm_cntr->spm_ring_rptr >= 0) &&  (spm_cntr->spm_ring_rptr  < 0x20))
+				spm_cntr->spm_ring_rptr = 0x20;
+
+		if (spm_cntr->is_uesr_buf_filled == true)
+			goto exit;
+
+		if (spm_cntr->spm_ring_wptr > spm_cntr->spm_ring_rptr) {
+			size_to_copy = spm_cntr->spm_ring_wptr - spm_cntr->spm_ring_rptr;
+			ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
+		} else if (spm_cntr->spm_ring_wptr < spm_cntr->spm_ring_rptr) {
+			size_to_copy = spm_cntr->spm_ring_buf_size - spm_cntr->spm_ring_rptr;
+			ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
+
+			/* correct counter start point */
+			spm_cntr->spm_ring_rptr = 0x20;
+			size_to_copy = spm_cntr->spm_ring_wptr;
+			ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
+		}
+
+		if (!ret) {
+			if (spm_cntr->is_uesr_buf_filled == true) {
+				/* stop */
+				amdgpu_amdkfd_rlc_spm_cntl(spm_cntr->kgd, 0);
+				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->kgd, 0);
+#if 0
+				amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cntr->kgd, 0);
+#else
+				spm_cntr->spm_cpu_addr[0]= 0;
+#endif
+				return ret;
+			} else
+				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->kgd, spm_cntr->spm_ring_wptr);
+
+			if (spm_cntr->is_timeout == true) {
+				/* stop */
+				amdgpu_amdkfd_rlc_spm_cntl(spm_cntr->kgd, 0);
+				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->kgd, 0);
+#if 0
+				amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cntr->kgd, 0);
+#else
+				spm_cntr->spm_cpu_addr[0]= 0;
+#endif
+				break;
+			}
+		}
+	}
+exit:
+	return ret;
+}
+
+static int kfd_spm_reag_ring_buf (struct kfd_spm_cntr * spm_cntr)
+{
+	u32 size_to_copy;
+	int ret = 0;
+
+	pr_debug("[%s]\n", __func__);
+
+	spm_cntr->spm_ring_rptr = amdgpu_amdkfd_rlc_spm_get_rdptr(spm_cntr->kgd) & spm_cntr->spm_ring_buf_mark;
+#if 1
+	spm_cntr->spm_ring_wptr = amdgpu_amdkfd_rlc_spm_get_wrptr(spm_cntr->kgd) & spm_cntr->spm_ring_buf_mark;
+#else
+	spm_cntr->spm_ring_wptr = spm_cntr->spm_cpu_addr[0] & spm_cntr->spm_ring_buf_mark;
+#endif
+	if ((spm_cntr->spm_ring_rptr >= 0) &&  (spm_cntr->spm_ring_rptr  < 0x20)) {
+		spm_cntr->spm_ring_rptr = 0x20;
+	}
+
+	if (spm_cntr->is_uesr_buf_filled == true)
+		goto exit;
+
+	if (spm_cntr->spm_ring_wptr > spm_cntr->spm_ring_rptr) {
+		size_to_copy = spm_cntr->spm_ring_wptr - spm_cntr->spm_ring_rptr;
+		ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
+
+	} else if (spm_cntr->spm_ring_wptr < spm_cntr->spm_ring_rptr) {
+		size_to_copy = spm_cntr->spm_ring_buf_size - spm_cntr->spm_ring_rptr;
+		ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
+
+		spm_cntr->spm_ring_rptr = 0x20;
+		size_to_copy = spm_cntr->spm_ring_wptr;
+		ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
+	}
+		if (!ret) {
+			if (spm_cntr->is_uesr_buf_filled == true) {
+				/* stop */
+				amdgpu_amdkfd_rlc_spm_cntl(spm_cntr->kgd, 0);
+				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->kgd, 0);
+#if 0
+				amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cntr->kgd, 0);
+#else
+				spm_cntr->spm_cpu_addr[0]= 0;
+#endif
+				return ret;
+			} else
+				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->kgd, spm_cntr->spm_ring_wptr);
+		}
+exit:
+	return ret;
+}
+
+static int kfd_spm_sched_main(void *param)
+{
+	struct kfd_spm_cntr * spm_cntr = (struct kfd_spm_cntr *)param;
+
+	while (!kthread_should_stop()) {
+		wait_event_interruptible(spm_cntr->spm_wq,
+				spm_cntr->wanted_cluster != false ||
+				kthread_should_stop());
+
+		kfd_spm_reag_ring_buf (spm_cntr);
+
+		spm_cntr->wanted_cluster = false;
+	}
+	return 0;
+}
+
+static void transfer_data_process_worker(struct work_struct *work)
+{
+	struct kfd_process *p;
+	struct delayed_work *dwork;
+
+	pr_debug("[%s]\n", __func__);
+
+	dwork = to_delayed_work(work);
+
+	/* Process termination destroys this worker thread. So during the
+	 * lifetime of this thread, kfd_process p will be valid
+	 */
+	p = container_of(dwork, struct kfd_process, copy_to_user_work);
+
+	p->spm_cntr->is_timeout = true;
+}
+
+
+/**
+ * kfd_spm_init - init driver ring struct.
+ * Returns 0 on success, error on failure.
+ */
+int kfd_spm_shed_init(struct kfd_process *p, struct kgd_dev *kgd)
+{
+	int ret = 0;
+	init_waitqueue_head(&p->spm_cntr->spm_wq);
+	p->spm_cntr->wanted_cluster = false;
+	p->spm_cntr->kgd = kgd;
+	INIT_DELAYED_WORK(&p->copy_to_user_work, transfer_data_process_worker);
+
+	/* Each scheduler will run on a seperate kernel thread */
+	p->spm_cntr->thread = kthread_run(kfd_spm_sched_main, p->spm_cntr, p->spm_cntr->name);
+	if (IS_ERR(p->spm_cntr->thread)) {
+		ret = PTR_ERR(p->spm_cntr->thread);
+		p->spm_cntr->thread = NULL;
+		DRM_ERROR("Failed to create scheduler for %s.\n", p->spm_cntr->name);
+		return ret;
+	}
+
+	p->spm_cntr->thread_ready = true;
+	return ret;
+}
+
+/**
+ * amdgpu_ring_fini - tear down the driver ring struct.
+ *
+ * @adev: amdgpu_device pointer
+ * @ring: amdgpu_ring structure holding ring information
+ *
+ * Tear down the driver information for the selected ring (all asics).
+ */
+void kfd_spm_shed_fini(struct kfd_process *p)
+{
+	if (p->spm_cntr->thread)
+		kthread_stop(p->spm_cntr->thread);
+
+	cancel_delayed_work_sync(&p->copy_to_user_work);
+	p->spm_cntr->thread = NULL;
+	p->spm_cntr->thread_ready = false;
+}
+
+void kfd_spm_init_process(struct kfd_process *p)
+{
+	mutex_init(&p->spm_mutex);
+	p->spm_cntr = NULL;
+	p->is_spm_acquired = false;
+}
+
+static struct kfd_spm_cntr *allocate_spm_cntr_data(void)
+{
+	struct kfd_spm_cntr *cntr;
+
+	cntr = kzalloc(sizeof(*cntr), GFP_KERNEL);
+	if (!cntr)
+		return NULL;
+
+	return cntr;
+}
+
+int kfd_acquire_spm(struct kfd_process *p, struct kgd_dev *kgd)
+{
+	int retval;
+	int count;
+
+	pr_debug("[%s]\n", __func__);
+
+	if(p->is_spm_acquired == true)
+		return EINVAL;
+
+	if (!p->spm_cntr) {
+		p->spm_cntr = allocate_spm_cntr_data();
+		if (!p->spm_cntr)
+			return -ENOMEM;
+		/* git spm ring buffer 128KB */
+		p->spm_cntr->spm_ring_buf_size = order_base_2(128 * 1024/4);
+		p->spm_cntr->spm_ring_buf_size = (1 << p->spm_cntr->spm_ring_buf_size) * 4;
+		p->spm_cntr->spm_ring_buf_mark = p->spm_cntr->spm_ring_buf_size -1;
+		for (count = 0; count < SAMPLING_MAX; ++count) {
+			p->spm_cntr->ubuf[count].user_addr = NULL;
+			p->spm_cntr->ubuf[count].ubufsize = 0;
+		}
+		p->spm_cntr->buf_count = 0;
+		p->spm_cntr->is_uesr_buf_filled = false;
+		p->spm_cntr->is_nowait = false;
+		p->spm_cntr->thread_ready = false;
+	}
+
+	retval = amdgpu_amdkfd_alloc_gtt_mem(kgd,
+			p->spm_cntr->spm_ring_buf_size, &p->spm_cntr->spm_obj,
+			&p->spm_cntr->spm_gpu_addr, (void *)&p->spm_cntr->spm_cpu_addr,
+			false);
+
+	if (retval)
+		return EINVAL;
+
+	memset(p->spm_cntr->spm_cpu_addr, 0, p->spm_cntr->spm_ring_buf_size);
+
+	amdgpu_amdkfd_rlc_spm_acquire(kgd, p->spm_cntr->spm_gpu_addr, p->spm_cntr->spm_ring_buf_size);
+
+	if (p->spm_cntr->thread_ready == false) {
+		p->spm_cntr->name = "spm";
+		retval = kfd_spm_shed_init(p, kgd);
+		if (retval) {
+			DRM_ERROR("Failed to create spm thread %s.\n",	p->spm_cntr->name);
+			return retval;
+		}
+	}
+	p->is_spm_acquired = true;
+
+	return 0;
+}
+
+int kfd_release_spm(struct kfd_process *p, struct kgd_dev *kgd)
+{
+
+	kfd_spm_shed_fini(p);
+
+	amdgpu_amdkfd_free_gtt_mem(kgd, p->spm_cntr->spm_obj);
+
+	kfree(p->spm_cntr);
+	p->spm_cntr = NULL;
+	p->is_spm_acquired = false;
+
+	return 0;
+}
+
+int set_dest_buf_polling(struct kfd_spm_cntr *spm, struct kgd_dev *kgd, void __user *data)
+{
+	struct kfd_ioctl_spm_args __user *user_spm_data =
+			(struct kfd_ioctl_spm_args __user *) data;
+	u32 i;
+	int ret = 0;
+	unsigned long timeout;
+
+	pr_debug ("[%s]\n", __func__);
+
+	timeout = msecs_to_jiffies(user_spm_data->timeout) + 1;
+
+	/* if buf = NULL, stop spm */
+	if (!user_spm_data->destptr) {
+		amdgpu_amdkfd_rlc_spm_cntl(kgd, 0);
+
+		user_spm_data->bytes_copied = spm->spm_ring_size_copied;
+		spm->spm_ring_size_copied = 0;
+		user_spm_data->spmtptr = (uint64_t)spm->ubuf[0].user_addr;
+
+		for (i = 0; i < spm->buf_count; ++i) {
+			spm->ubuf [i] = spm->ubuf [i+1];
+		}
+		spm->ubuf[spm->buf_count].user_addr = NULL;
+		spm->ubuf[spm->buf_count].ubufsize = 0;
+		spm->buf_count --;
+		if (spm->buf_count < 0)
+			spm->buf_count = 0;
+		return ret;
+	}
+
+	if (!spm->buf_count) {
+		/* First time save user spm buffer, then start spm sampling */
+		spm->ubuf[0].user_addr = (uint64_t*)user_spm_data->destptr;
+		spm->ubuf[0].ubufsize = user_spm_data->buf_size;
+		user_spm_data->bytes_copied = 0;
+		spm->spm_ring_size_copied = 0;
+		spm->buf_count ++;
+		spm->is_uesr_buf_filled = false;
+		amdgpu_amdkfd_rlc_spm_cntl(kgd, 1);
+
+		ret = kfd_spm_reag_ring_buf_polling (spm, timeout);
+		user_spm_data->bytes_copied = spm->spm_ring_size_copied;
+		user_spm_data->spmtptr = (uint64_t)spm->ubuf[0].user_addr;
+		spm->buf_count --;
+	} else {
+		spm->spm_ring_size_copied = 0;
+		spm->is_uesr_buf_filled = false;
+		amdgpu_amdkfd_rlc_spm_cntl(kgd, 1);
+		ret = kfd_spm_reag_ring_buf_polling (spm, timeout);
+
+		user_spm_data->bytes_copied = spm->spm_ring_size_copied;
+		user_spm_data->spmtptr = (uint64_t)spm->ubuf[0].user_addr;
+		spm->buf_count --;
+
+		for (i = 0; i < spm->buf_count; ++i)
+			/* Repeated dest buf */
+			if (spm->ubuf[i].user_addr == (uint64_t*)user_spm_data->destptr)
+				break;
+		if (i == spm->buf_count) {
+			spm->ubuf[i].user_addr = (uint64_t*)user_spm_data->destptr;
+			spm->ubuf[i].ubufsize = user_spm_data->buf_size;
+			spm->buf_count ++;
+		}
+
+		for (i = 0; i < spm->buf_count; ++i)
+			spm->ubuf[i] = spm->ubuf[i + 1];
+		spm->ubuf[spm->buf_count].user_addr  = NULL;
+	}
+
+	user_spm_data->bytes_copied = spm->spm_ring_size_copied;
+	return ret;
+
+}
+
+int kfd_set_dest_buffer(struct kfd_process *p, struct kgd_dev *kgd, void __user *data)
+{
+	struct kfd_ioctl_spm_args __user *user_spm_data =
+							(struct kfd_ioctl_spm_args __user *) data;
+	struct kfd_spm_cntr *spm = p->spm_cntr;
+	unsigned long timeout;
+
+	pr_debug("[%s]\n", __func__);
+
+	if(p->is_spm_acquired == false)
+		return -EINVAL;
+
+	timeout = msecs_to_jiffies(user_spm_data->timeout) + 1;
+	spm->is_timeout = false;
+	schedule_delayed_work(&p->copy_to_user_work, timeout);
+	return set_dest_buf_polling(spm, kgd, data);
+}
+
+int kfd_config_spm(struct kfd_process *p, struct kgd_dev *kgd,struct kfd_ioctl_spm_args *data)
+{
+	struct kfd_ioctl_spm_args __user *user_spm_data =
+			(struct kfd_ioctl_spm_args __user *) data;
+	struct kfd_spm_set_reg *spm_reg;
+
+	pr_debug("[%s]\n", __func__);
+
+	spm_reg = kvmalloc_array(1, sizeof (struct kfd_spm_set_reg), GFP_KERNEL);
+
+	if (copy_from_user(spm_reg, (void __user *)user_spm_data->destptr, sizeof (struct kfd_spm_set_reg))) {
+		pr_err("copy_from_user Fail\n");
+		goto exit;
+	}
+	amdgpu_amdkfd_rlc_spm_set_reg(kgd, spm_reg->reg, spm_reg->value);
+exit:
+	kfree(spm_reg);
+	return 0;
+}
+
+int kfd_rlc_spm(struct kfd_process *p,  void __user *data,
+		       uint32_t buf_size, __u32 operation)
+{
+	struct kfd_ioctl_spm_args *args = data;
+	struct kfd_dev *dev;
+	int r;
+
+	dev = kfd_device_by_id(args->gpu_id);
+	if (!dev)
+		return -EINVAL;
+
+
+	switch (operation) {
+	case KFD_IOCTL_SPM_OP_ACQUIRE:
+		dev->spm_pasid = p->pasid;
+		r = kfd_acquire_spm(p, dev->kgd);
+		break;
+
+	case KFD_IOCTL_SPM_OP_RELEASE:
+		r = kfd_release_spm(p, dev->kgd);
+				break;
+
+	case KFD_IOCTL_SPM_OP_SET_DEST_BUF:
+		r = kfd_set_dest_buffer(p, dev->kgd, data);
+		break;
+
+	case KFD_IOCTL_SPM_OP_CONFIG:
+		r = kfd_config_spm(p, dev->kgd, args);
+				break;
+
+	default:
+		r = -EINVAL;
+		break;
+	}
+	return r;
+}
+
+void kfd_spm_interrupt(unsigned int pasid)
+{
+
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+
+	if (!p) {
+		pr_info("kfd_spm_interrupt p = %p \n", p);
+		return; /* Presumably process exited. */
+	}
+
+	mutex_lock(&p->spm_mutex);
+
+	p->spm_cntr->wanted_cluster = true;
+	wake_up_interruptible(&p->spm_cntr->spm_wq);
+
+	mutex_unlock(&p->spm_mutex);
+
+	kfd_unref_process(p);
+}
+
+bool kfd_spm_interrupt_isr(struct kfd_dev *dev,
+					uint16_t source_id,	uint32_t client_id)
+{
+	pr_debug("[%s]\n", __func__);
+
+	if (source_id != GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT)
+		return 0;
+
+	/* Interrupt types we care about: various signals and faults.
+	 * They will be forwarded to a work queue (see below).
+	 */
+
+	return source_id == GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT ||
+		source_id == VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR ||
+		client_id == AMDGPU_IRQ_CLIENTID_LEGACY ||
+		client_id == SOC15_IH_CLIENTID_RLC;
+}
+
+void kfd_spm_interrupt_wq(struct kfd_dev *dev,	uint16_t source_id)
+{
+	uint16_t pasid;
+
+	pr_debug("[%s]\n", __func__);
+
+	pasid = dev->spm_pasid;
+#if 0
+	if ((source_id == GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT) ||
+				(source_id == VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR))
+		kfd_spm_interrupt(pasid);
+#endif
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
index 0bc0b25..fb4ad60 100644
--- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
+++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
@@ -30,6 +30,7 @@
 #define SOC15_INTSRC_SQ_INTERRUPT_MSG	239
 #define SOC15_INTSRC_VMC_FAULT		0
 #define SOC15_INTSRC_SDMA_TRAP		224
+#define AMDGPU_IRQ_CLIENTID_LEGACY	0
 
 
 #define SOC15_CLIENT_ID_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[0]) & 0xff)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 4f66764..f7cb7d4 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -442,6 +442,56 @@ struct kfd_ioctl_import_dmabuf_args {
 	__u32 dmabuf_fd;	/* to KFD */
 };
 
+/**
+ * kfd_ioctl_spm_op - SPM ioctl operations
+ *
+ * @KFD_IOCTL_SPM_OP_ACQUIRE: acquire exclusive access to SPM
+ * @KFD_IOCTL_SPM_OP_RELEASE: release exclusive access to SPM
+ * @KFD_IOCTL_SPM_OP_SET_DEST_BUF: set or unset destination buffer for SPM streaming
+ */
+enum kfd_ioctl_spm_op {
+	KFD_IOCTL_SPM_OP_ACQUIRE,
+	KFD_IOCTL_SPM_OP_RELEASE,
+	KFD_IOCTL_SPM_OP_SET_DEST_BUF,
+	KFD_IOCTL_SPM_OP_CONFIG
+};
+
+/* Don't wait for previous buffer to fill up */
+#define KFD_IOCTL_SPM_FLAG_POLLING 1
+
+/**
+ * kfd_ioctl_spm_args - Arguments for SPM ioctl
+ *
+ * @op:     specifies the operation to perform
+ * @destptr:used for the address of the destination buffer in @KFD_IOCTL_SPM_SET_DEST_BUFFER
+ * @buf_size:size  of the destination buffer in @KFD_IOCTL_SPM_SET_DEST_BUFFER
+ * @timeout: timeout to wait buffer get filled
+ * @gpu_id: gpi ID
+ * @bytes_copied: byte copied from streaming performance ring buffer
+ *
+ * If @ptr is NULL, the destination buffer address is unset and copying of counters
+ * is stopped.
+ *
+ * Returns negative error code on failure. On success, @KFD_IOCTL_SPM_OP_ACQUIRE and
+ * @KFD_IOCTL_SPM_OP_RELEASE return 0, @KFD_IOCTL_SPM_OP_SET_DEST_BUF returns the fill
+ * level of the previous buffer.
+ */
+struct kfd_ioctl_spm_args {
+	__u64 destptr;
+	__u64 spmtptr;
+	__u32 buf_size;
+	__u32 op;
+	__u32 timeout;
+	__u32 gpu_id;	/* to KFD */
+	/* from KFD: Total amount of bytes copied */
+	__u64 bytes_copied;
+};
+
+struct kfd_spm_set_reg {
+	__u64 reg;		/* to KFD */
+	__u32 value;
+};
+
 /* Register offset inside the remapped mmio page
  */
 enum kfd_mmio_remap {
@@ -546,7 +596,10 @@ enum kfd_mmio_remap {
 #define AMDKFD_IOC_ALLOC_QUEUE_GWS		\
 		AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)
 
+#define AMDKFD_IOC_RLC_SPM		\
+		AMDKFD_IOWR(0x1F, struct kfd_ioctl_spm_args)
+
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x1F
+#define AMDKFD_COMMAND_END		0x20
 
 #endif
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
