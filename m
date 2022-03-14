Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BFBC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 05:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B4A10E1AA;
	Mon, 14 Mar 2022 05:52:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60F710E1AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 05:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3U439syZptWAf59YqgSb4Sxk01SlBHFL2HPz0wdIU1glc+VQessibZhIJI8jGyfJ3KWVP0aPI/h2W3eaOWNNy8kLA4GY8a2aC4jFkcV5i2mPmWFKyW4fHr0ZAqLUjuEr7gaVX46gtI2FgkvpE12JzaGztJZofMNuuJCPGfU65aXhAaYTNYtzZI2W/0Uj1Nnc6BuD7QshWgCerCRAQ0BY0flMEiHdyMjBOl1HigaxBi8VwWH0/7M6hW5CBA6Ss7AT9sIS4yfvm77L5O9+E6zPTfmaz8tPVrgKRprLH+S7wZnssrNV88gbh2RLbkn0+RWwLmZtaSkgGQyDxsJGU0hTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqLA1fAuVtGIrMgdvOlRvqn3qNotd/mxgh9hazqouqo=;
 b=cz0ILRjQB2GsMYwZpBY7HVafLhc5q2ytuh60GeWX8uc/1LXDWqOkN4bCpNOKy/Vr7MPgwBffacu8GkpJb1YsdfSxEaXmqndfMWSL2SuPj8I8PzkXpfhzXqNkAuCgwqvVeVNCeMmT5tcaRooxEvR0e77lvPC2VT6AoC4/ESk3kCNUPT3bR3xWuhV+4SrEhLsAiojOEyGS03D9U8eG6zm52tppAO8/nXdJrhFoSGeQ/WScS1oTigtH2vuzNwzwkXyjEXUIDWsaLONvXMIgcBl8qwe6LbyMqCwGjCo5xtUuDyqnAfuyTgIvwEd5DXjptoQ8lmNVyurC4Dc0gLvMwerNBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqLA1fAuVtGIrMgdvOlRvqn3qNotd/mxgh9hazqouqo=;
 b=cym3zlOrLnxuBla7A3/5It12h+txbtB1707GKzcLqUtZvHTqc/nFVxDqxh8ap3/7YQHWdUu9uIvdcoeOYWqnIdsr0DKe0NNHLXmlUTnHU19vBeyUsmFyd1PIsXZ6ORvFgf5KOAb+vcOabRc7SXfo8xEJUDGAIy90dIEJp8NaDA0=
Received: from MWHPR21CA0064.namprd21.prod.outlook.com (2603:10b6:300:db::26)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 05:52:48 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::59) by MWHPR21CA0064.outlook.office365.com
 (2603:10b6:300:db::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13 via Frontend
 Transport; Mon, 14 Mar 2022 05:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 05:52:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 00:52:46 -0500
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 00:52:44 -0500
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fixed the warnings reported by kernel test robot
Date: Mon, 14 Mar 2022 13:52:21 +0800
Message-ID: <20220314055221.3100329-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB05.amd.com
 (10.181.40.146)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f350d03c-bc3e-4d93-ac5c-08da057ede36
X-MS-TrafficTypeDiagnostic: PH7PR12MB5878:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5878205BBC902A04AA5F39BAFC0F9@PH7PR12MB5878.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxeJMrmEIj7groVvTSUGiiszEibSQO+3v3Vn5rPfiR7t2nDoUElfcaoiJJmw19kd+fIN/UIN7AMDP/YOuP31qHZdy/pvSZUb2rQ0ZDLWhBlpd34H0ZSJhwNmNSvsBg4qR2IsoS9BWnFP9uCaVzW1AdYka2lBe0cUh1y6HL4zO02wkaloIzizz6cwcsk/MYIUF540bqMCDOYijR9UclY1mVEHM2rSdFk31T5DCEKrZPgC3YOZ0D4fuzfRmvXFH7hD9zL9lrzO9VLqCoCQflUjM8nsSkkTTNlzcK8IBqKGPmSHi5ArgVkgjDUa5nK9exMrGr8MCUECzyL2DAp75mGMV+/SxbphLz+Z4IgyqB/JHfL3eYsxj+uDb1am1FdH4o3O+v7XcMGM7eDF+4D3Hh8vvuJSIETxmViolEaAgN6Oq+3GZjO8I9UzDzTWeUcoPdeKm0VsmN9RjN2g7GBI894Pspmxyu6LVJqskTaR0PNWWOH3yzPK/GBQoeBuKKULa2J6NAlPnjtX7TkR/jTiqy8lsACDguayoyPyVhqkBJWX2p13byASZ8CTD3DlU4SI/65iR18ptNzucB2xGEz7CwPziAa2METoT3fzJxUNdO+gGU7vqJ6vHcJc0CqXZsNRtHvsJNu7GM5RReIev+3wMssFXbvTCXxEF1zbSKQA5Y29UFXxdatcsq+00LeeaQz/Y/XwMqvCQetv9geVmmxEcm5w/9CE8a6u8lfdta6pJ1TCkuk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(186003)(81166007)(336012)(426003)(16526019)(356005)(2616005)(82310400004)(86362001)(6666004)(7696005)(2906002)(1076003)(508600001)(47076005)(4326008)(8676002)(70206006)(70586007)(5660300002)(36756003)(36860700001)(8936002)(83380400001)(54906003)(6916009)(40460700003)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 05:52:47.6614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f350d03c-bc3e-4d93-ac5c-08da057ede36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The reported warnings are as follows:
  1.warning:no-previous-prototype-for-amdgpu_hdp_ras_fini.
  2.warning:no-previous-prototype-for-amdgpu_mmhub_ras_fini.

Amdgpu_hdp_ras_fini and amdgpu_mmhub_ras_fini are unused
in the code, they are the only functions in amdgpu_hdp.c
and amdgpu_mmhub.c. After removing these two functions,
both amdgpu_hdp.c and amdgpu_mmhub.c are empty, so these
two files can be deleted to fix the warning.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile       |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 30 -----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 30 -----------------------
 3 files changed, 2 insertions(+), 62 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 5dfe08cb045e..40e2c6e2df79 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -53,11 +53,11 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
 	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
 	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
-	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o amdgpu_mmhub.o \
+	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
 	amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
-	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o \
+	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
deleted file mode 100644
index 3f3d92e16c2e..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-
-#include "amdgpu.h"
-#include "amdgpu_ras.h"
-
-void amdgpu_hdp_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
deleted file mode 100644
index 8f2fa247d605..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright 2019 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-
-#include "amdgpu.h"
-#include "amdgpu_ras.h"
-
-void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-
-}
-- 
2.25.1

