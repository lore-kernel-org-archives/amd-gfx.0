Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291AFC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E512364EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E512364EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E396EBA8;
	Wed, 24 Feb 2021 22:22:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770040.outbound.protection.outlook.com [40.107.77.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BF76EB9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdlnbdfnqapZZHlszlM2nMn84XOFOGQbJhqy+f3OHq5gstGAsY2/VYm3h7/iD9/k9MPegu+vNOAYL485zav4H2EayzItGsR46oME9BGpTe8kfowfyJdelunQEveAGa6M+r6jnQRXVRoXynVhcYORxPqQnkPdaLqea0So0im8c8wQ/Blprg6pVQN+8ZKQcyM3fZYRY+jKtKi5oBrfNFaPvt0iFguZaUTgpj8Enk/4WWddgwU1ADwvoxuLr0/Bgh0tSSEojCdkC1ZYp+rvjRuiNuDv6tILqGKkYeX5FPkBAryCUTk0v44qXSYjJjayshNUHsaYUojl9rT7wo2hT6WReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikGXadn/rm4ijjaQwIYuBHzgcgPo8X5CtFIxE57Krdg=;
 b=A4DXlH01t91wvUUNj6SCWxQrJEbRJG/TdGkOv8bwDNmu129A/BQhd56eMaz/u4OiSIyJF+XT+/DOb3AvlG5llYThfjQ5OTorPAteOjF6AbuN/2leNiUNMC+KxNSx3thrUQ9+6NfsPXug244n3BjP9JoC4symJ8/uaJ0eJ3xV/o6gl402IUGut0bLjtDdwtbdovUW853MJqdfry7bAPY7mzvTPalNIEE1I4gdWo//CX/+lt+0PNBtoyPEWiEk/pOWD97XTOSlpkgE4NGyRE9Vhbx2Qf2+x8CnsDMq43yjuEfS+erARhzO5ZA/8pvTMCXTVe7pTywk140QvRAxOs4JNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikGXadn/rm4ijjaQwIYuBHzgcgPo8X5CtFIxE57Krdg=;
 b=zxqWJKyJ7nHnonDmZHbb5t2urIT1u6q87bYl/sfo1SXrUN3HQYGvipcVDxgOBEEHlnye4MVwdDbwD1kgtF/zsIEYBjrtx5+6dlttep0FHV6GGTTu22QOzxXgJhoWwZJJ93gcrPA6v2PG5PNEXypIUh8KCJ0OjoFBrBTaTiu4nfc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:22:35 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:35 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 146/159] drm/amdkfd: add aldebaran kfd2kgd callbacks to kfd
 device (v2)
Date: Wed, 24 Feb 2021 17:18:46 -0500
Message-Id: <20210224221859.3068810-139-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:21:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 940a1ceb-82fe-4047-f549-08d8d912777d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3807B9C54023EB9F081B7F8BF79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tb6XNeM/BOtsdBE8qJiSvx89v+ex56bDrsh0vTpes6Bo/VzxHKQ6GiDSfdjUQ6fjyMFa36sdmPRjcbcgZDAUDQl2SF445D6o+CapBiir7O+fKdgF8RyO85JN5K9/+eKKhIr03IOLQ7hxz3jv+n+H3b3lDJtlBSzea9K4frAE5wcW1TElLB++99Zzh3RHPbC59AMQqvimoA8GRzmhotRbxQUPhWGmt0g+6QOV3auPVGmUEuNz72G2sB317nmtkwG2q6k9hiLPTPyWzs7paHcBwczScGC+qFb72WG4tvGxZj1iN1ANjgpMFDL1DEnB3Q/VaqAn7QJU6B3ls9MkNFmqcYgY8RjGKd0gA/vN7XFpl/fpGTXPlmlK1B/LN9k3zBpJIxXbEAfyAh9F0n8xMQtmT7pwsBGRcjDFAjRpbpqkICOSLI1WgDeRYKvnsBRG0kEL+Eixf5d/M3hNA1lMvbdsfVFVLk7Eu3753Qhm3blj/AKPFR/btII75tNRsgh73KFu3E5pZ//swwwk3vC7NVJLAQFnXiwZtJ0thmXs6w0IYWZj2+opP6DV+IPjGIkw77832V4g5+cchQSskF+CtI+WmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?o55ao69hyDQd+yoEy3bGWvrGr4nk89FZ6izxk9E3q3Fg05CnTJ4BDogel2Nv?=
 =?us-ascii?Q?pAL2kFTUCygmy1vOOL74ifRDXfmH3diEmStL49vAxKy8DeZhcrSIT5Ss+zRB?=
 =?us-ascii?Q?6ZheLF4t2HgtGiHbuMj5KdTWHjohy9u4jVszHsvG635nEVbSIzme6NF7p+32?=
 =?us-ascii?Q?Zt0gGbiF7sYRfcTqRn5XqAk//aXXVYSApHBtexW3ra1KQ2JDiPoUB/hme+tz?=
 =?us-ascii?Q?Rqd4+jW7CpIkwT6+KqtyvQ94qxOlQus4VxW0dqXOw6QxbimLR0jbBy/jFXUp?=
 =?us-ascii?Q?OhFZqWmSKlDIJL07Eb/MdIBqFvo6iq2JFMtm/Vrywe36nvxoclD4OpJeo8HG?=
 =?us-ascii?Q?B0GYuKCVU8JesOerJXrYWtCYX9iDjwCwb662KA37HHYxr/G9tHFnHLf25Q5R?=
 =?us-ascii?Q?JGjcbxF1PMAwfMEXuD4ONhfoa6jngdvP95jWnm/yvK3oe+MGjiA8jBkF9qZT?=
 =?us-ascii?Q?3XHCKw61cjUTmEcnabIvIQt5WifIz9G9YlDdOb398/AsI4CVKkTj2bcJRPYa?=
 =?us-ascii?Q?chkHvNHjK6fB/LKEg6STAbRZ1oBSQAUrvifrxilzK/reJOTH1n2jONeFt3mL?=
 =?us-ascii?Q?D6U4T3QrSf7rlUGcrHqrhP+g7aOvByP2pimcAp5fQm2pxyJZQMmDgra36nG5?=
 =?us-ascii?Q?9ZVtoZwVg/gdrV48Mpbsam/zOAeOQcWX/N6zY4y7FJ9ITBMfsBpM0wFXTC4j?=
 =?us-ascii?Q?VUYw8p/Pq8lj8v8Jx7Z09y33TJaaOUOnoOSBER/BVuT4y7vTPJ8lylLkNSdo?=
 =?us-ascii?Q?bwx9QvsiZPhEYd1StRYrtKKTf6qFszZCKPcrOpzY91rgbiUgvg/y4Tvyx1vh?=
 =?us-ascii?Q?hXMf7V/FtrsdrcgqvY/CbuNQg/p/z9X0hvOx5lTDLXfIXPAXF6e0i89yqpMd?=
 =?us-ascii?Q?jec9cNU251E/92AWvpwq/vXTv18r6bh3sBQ0wdGbReL+xkekXuycFcI8mI94?=
 =?us-ascii?Q?Ff35X8FEbAYsBndAvM4o2Fnj1XzRi6yiJw6lOzo2CFuALZrlnVV6KTAuMFLE?=
 =?us-ascii?Q?R+W7IF/p3Kba9X+NnFFdDY6pHIuTh+UtDsOABm57YBU6s8l8a8/kIU75+46e?=
 =?us-ascii?Q?PZjzcfodfNXdHOjNLAmgxjNrZzC0RfypPqP/9AOIbtw0bfGOlNXrfeKZDvFe?=
 =?us-ascii?Q?SjX8QAECsa/D7fC2uIqubtiS874nO85DE6xfV0JPPgov5mGchSYjSArovds6?=
 =?us-ascii?Q?RGtjyf7l2w/oaysyVeP9MNaKpFzi3Esfeo4B4Z24PCiwJ6LKZOIjUOhHw+cL?=
 =?us-ascii?Q?bjIVfpsvpxpD/v4uIA1oiSJppPyRLj0K9Xl4+37MhbvMO0kPc5jx2Ujd35Lt?=
 =?us-ascii?Q?xy/TYur+CUEmC7nPtOx3lUQE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940a1ceb-82fe-4047-f549-08d8d912777d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:01.1980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTPk+EfflTe9SATJ40ODBoq/8BPXOwSw3ApP6Km66QoAeo20cGcaFM+RUu9HmOpKW8C3gcG3pTSN80n0iVrSqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jonathan Kim <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <Jonathan.Kim@amd.com>

Create dedicated Aldebaran kfd2kgd callbacks to prepare
for new per-vmid register instructions for debug trap
setting functions and sending host traps.

v2: rebase (Alex)

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  1 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  | 47 +++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   | 17 ++++---
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h   | 30 ++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  3 +-
 5 files changed, 88 insertions(+), 10 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 17d9a3e798e2..c5ec926bc6d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -191,6 +191,7 @@ amdgpu-y += \
 	amdgpu_amdkfd_gfx_v8.o \
 	amdgpu_amdkfd_gfx_v9.o \
 	amdgpu_amdkfd_arcturus.o \
+	amdgpu_amdkfd_aldebaran.o \
 	amdgpu_amdkfd_gfx_v10.o \
 	amdgpu_amdkfd_gfx_v10_3.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
new file mode 100644
index 000000000000..a5434b713856
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -0,0 +1,47 @@
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
+#include "amdgpu.h"
+#include "amdgpu_amdkfd.h"
+#include "amdgpu_amdkfd_arcturus.h"
+#include "amdgpu_amdkfd_gfx_v9.h"
+
+const struct kfd2kgd_calls aldebaran_kfd2kgd = {
+	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
+	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
+	.init_interrupts = kgd_gfx_v9_init_interrupts,
+	.hqd_load = kgd_gfx_v9_hqd_load,
+	.hiq_mqd_load = kgd_gfx_v9_hiq_mqd_load,
+	.hqd_sdma_load = kgd_arcturus_hqd_sdma_load,
+	.hqd_dump = kgd_gfx_v9_hqd_dump,
+	.hqd_sdma_dump = kgd_arcturus_hqd_sdma_dump,
+	.hqd_is_occupied = kgd_gfx_v9_hqd_is_occupied,
+	.hqd_sdma_is_occupied = kgd_arcturus_hqd_sdma_is_occupied,
+	.hqd_destroy = kgd_gfx_v9_hqd_destroy,
+	.hqd_sdma_destroy = kgd_arcturus_hqd_sdma_destroy,
+	.address_watch_disable = kgd_gfx_v9_address_watch_disable,
+	.address_watch_execute = kgd_gfx_v9_address_watch_execute,
+	.wave_control_execute = kgd_gfx_v9_wave_control_execute,
+	.address_watch_get_offset = kgd_gfx_v9_address_watch_get_offset,
+	.get_atc_vmid_pasid_mapping_info =
+				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
+	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 6f6dfd950e01..9ef9f3ddad48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -47,7 +47,6 @@
 #include "amdgpu_amdkfd_gfx_v9.h"
 #include "gfxhub_v1_0.h"
 #include "mmhub_v9_4.h"
-#include "mmhub_v1_7.h"
 
 #define HQD_N_REGS 56
 #define DUMP_REG(addr) do {				\
@@ -123,7 +122,7 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 	return sdma_rlc_reg_offset;
 }
 
-static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
+int kgd_arcturus_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
 			     uint32_t __user *wptr, struct mm_struct *mm)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
@@ -193,7 +192,7 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
 	return 0;
 }
 
-static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
+int kgd_arcturus_hqd_sdma_dump(struct kgd_dev *kgd,
 			     uint32_t engine_id, uint32_t queue_id,
 			     uint32_t (**dump)[2], uint32_t *n_regs)
 {
@@ -225,7 +224,7 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
 	return 0;
 }
 
-static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
+bool kgd_arcturus_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v9_sdma_mqd *m;
@@ -244,7 +243,7 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
 	return false;
 }
 
-static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
+int kgd_arcturus_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
 				unsigned int utimeout)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
@@ -290,13 +289,13 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.init_interrupts = kgd_gfx_v9_init_interrupts,
 	.hqd_load = kgd_gfx_v9_hqd_load,
 	.hiq_mqd_load = kgd_gfx_v9_hiq_mqd_load,
-	.hqd_sdma_load = kgd_hqd_sdma_load,
+	.hqd_sdma_load = kgd_arcturus_hqd_sdma_load,
 	.hqd_dump = kgd_gfx_v9_hqd_dump,
-	.hqd_sdma_dump = kgd_hqd_sdma_dump,
+	.hqd_sdma_dump = kgd_arcturus_hqd_sdma_dump,
 	.hqd_is_occupied = kgd_gfx_v9_hqd_is_occupied,
-	.hqd_sdma_is_occupied = kgd_hqd_sdma_is_occupied,
+	.hqd_sdma_is_occupied = kgd_arcturus_hqd_sdma_is_occupied,
 	.hqd_destroy = kgd_gfx_v9_hqd_destroy,
-	.hqd_sdma_destroy = kgd_hqd_sdma_destroy,
+	.hqd_sdma_destroy = kgd_arcturus_hqd_sdma_destroy,
 	.address_watch_disable = kgd_gfx_v9_address_watch_disable,
 	.address_watch_execute = kgd_gfx_v9_address_watch_execute,
 	.wave_control_execute = kgd_gfx_v9_wave_control_execute,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h
new file mode 100644
index 000000000000..ce08131b7b5f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h
@@ -0,0 +1,30 @@
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
+int kgd_arcturus_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
+			     uint32_t __user *wptr, struct mm_struct *mm);
+int kgd_arcturus_hqd_sdma_dump(struct kgd_dev *kgd,
+			     uint32_t engine_id, uint32_t queue_id,
+			     uint32_t (**dump)[2], uint32_t *n_regs);
+bool kgd_arcturus_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd);
+int kgd_arcturus_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
+				unsigned int utimeout);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index f5a290999eb5..f860cd705961 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -46,6 +46,7 @@ extern const struct kfd2kgd_calls gfx_v7_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v8_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v9_kfd2kgd;
 extern const struct kfd2kgd_calls arcturus_kfd2kgd;
+extern const struct kfd2kgd_calls aldebaran_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
 
@@ -71,7 +72,7 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
 	[CHIP_VEGA20] = &gfx_v9_kfd2kgd,
 	[CHIP_RENOIR] = &gfx_v9_kfd2kgd,
 	[CHIP_ARCTURUS] = &arcturus_kfd2kgd,
-	[CHIP_ALDEBARAN] = &arcturus_kfd2kgd,
+	[CHIP_ALDEBARAN] = &aldebaran_kfd2kgd,
 	[CHIP_NAVI10] = &gfx_v10_kfd2kgd,
 	[CHIP_NAVI12] = &gfx_v10_kfd2kgd,
 	[CHIP_NAVI14] = &gfx_v10_kfd2kgd,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
