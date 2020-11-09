Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4EFC2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266652084C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ekNIgXX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266652084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E41894D4;
	Mon,  9 Nov 2020 08:17:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4691894D4
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 08:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAGo+rXxQKhyLfI/IqxFMUv1sZB4chc/CkvgHHqevacC/UPQZbDQoTMIO1RY+IzTKdC0BiZ52VQJ5XGVTKdxQBlEX9fJw7ayebt64PM8r6s8LwxR6KkZUwSbAv90rLzUAP0vvSDhGw244sRP2x4r+79HfDGll9cVjxzCJdhxBfompUqeCTtxG7Z8rFQtNJiS56iXx7tPGgOcE81euYxsdQbMOTFeKTmcd3iGD5LAs5pttK2bpZnAkTJoutBn1dBNAqdn2Z7DwhW83EOTd5/X9Q+fPTtdoPPr+jWSKAAeVgMDyJRM091iK9gIZGZgQiVRAV+n3q48+FyhGGBkJBm2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmGSAxFlH1IG9x2ThfpjaPcs3WMbkqS2oWLaK28mCpo=;
 b=Wj5Q7HeUTAT265IJkWhiqgEECjRItm1UqWcXp9fA+SBTpV+eu8WAboaaYxher235JQIe2zEESBvhBkHoAJRd273woejLlspTeVjYkn5a90jNYGDxtbV581jJTO189CDaFeusuiw9nz3EeMj6bD2ibs8rCnHNtDBKNP65JzS8pXlwNoDftPo35zoMf6fxp3X7a1H/k2El6ggJ6jm7nLx4zE8zJCB6auSvAnfcEj5rGw1k+b/wn2RgAstcAFEtA2DaVtTl4iuPe9Z6XJJ4G8+z2znbhg0o3i4wSx0zSr4XaTpClq47W9BczfXErscADiAe1S0D2VFA0WlaSSPGESZMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmGSAxFlH1IG9x2ThfpjaPcs3WMbkqS2oWLaK28mCpo=;
 b=ekNIgXX6Yx/ieFfW/9lZ2limW/gg1IW5lk2dVLSkApoXFgMFQTZJ5yT5Tevth2+UuAoEbBQcoxpNXMyCtA0NlTgWAexxEPAVj6mPYgm5/TXLA1wZkELoLoPn9OPklRNOGlyasGESqVoSzqGgYQ6EJvBwWyzAhlPBDGZGRYeVZ1k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.24; Mon, 9 Nov 2020 08:17:12 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%8]) with mapi id 15.20.3541.022; Mon, 9 Nov 2020
 08:17:12 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: add amdgpu_smuio structure
Date: Mon,  9 Nov 2020 16:16:48 +0800
Message-Id: <20201109081652.1964-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:202:16::13) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (58.247.170.242) by
 HK2PR02CA0129.apcprd02.prod.outlook.com (2603:1096:202:16::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 08:17:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 607f0111-bf64-4ff9-3e83-08d88487dc35
X-MS-TrafficTypeDiagnostic: DM6PR12MB3274:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB327442B62FCFB81525F3DB52FCEA0@DM6PR12MB3274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KsgS41UmeGmUEP3T6HxvR8/b4kWnG0wonpk9ht+wdK/zLX7/VKuBYk4qner22myzwcOvMWpGOr+0akmgNyM9+kRdAWrnPRKDm/cxBxmQIive1qnPsbPgX3nccbl36YB5lqRIOAIDjYvrsWMZWqDVl/6G0wZvQgLDqeofbaCNXiV2f6QHkjiHkEBK0DSNEy0zE8tW6uisWflmy54ucfJK5V51NuDmsCMQuqAzZoZ2A4MHAohBQpkPMckUXBrvIDikPOYVTv+yoFbr/RVmMmmWFsUXHBWeBenr9tJKg6D83gvQb/TRP4SLYUTwvbZbFhSVrwr2V2mCsYqceIZeGXCwWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(66476007)(66556008)(316002)(66946007)(6916009)(5660300002)(8676002)(8936002)(4326008)(1076003)(26005)(2906002)(86362001)(83380400001)(6486002)(2616005)(478600001)(956004)(186003)(16526019)(52116002)(6666004)(36756003)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LgTo0nLBPf+lETD6LAqVBARSJvORDS92vXAkQxFhByok6GYASg2mDHBAJ5wSG0lLrpIE9PDDg3OF7R0IWQZs3bWI3cVtlU9TKpIbik5bjy4j0+EEW9R78EufLq3Q+4P9MCNInhdNA8ZPyDAe7uCz4IjFzu9lwG+kOI4XhyX4tNRxUsqgBzjNdm3iKtSCcrUyAH0pgYI4jnW8c/uqQTQJOMYfdfg43ZoEpy8PVnOD7vKtnLfZZMB69PnOX7vNx/6oltB0AMrYgMDDmWaULo2IgPOiC9hJksewSlcVN6Gl8En+Um2Dx9OU80fKwJVwVaIo3g9zzjCOsnltpSrMmIVXuDQwUNkFH18MmfbTPugjiIOR3regL6AobXgIbD2EBKYvL38Kv2+c1MmxlMBVhJQ99Zgvts8VK7uShK7Gi4uK9O1uAJho5+QMYNJZeQoUkwD/XGtI1VyoIvkGTZj0215Sz+3n3J8BDlCi0zedddURFWGTYWte6ndMptd1OfS/QYrd0UYUh37Xn5uYemxYC8k+YZwdHRZT55RW0xtx3a9KkBXRtKYGKgABT3BPD3k53kiYlMP2ZwTaGedNQLJXHcTrCRnOFEfCOKRrLQEHXh9blPkVyS75FRr6HeIAJc/Te/5fPKfz4i9VwTqZ+TToJfVZMQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607f0111-bf64-4ff9-3e83-08d88487dc35
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 08:17:12.4745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjKAN3PiCaZETRMm7sbzD16yeb5vw8dd+5Dm30IMKTJHJvTQoRrP3X1eqqH21Ck1O4LTnPsty2AyrTZsCrCEyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add amdgpu_smuio structure in amdgpu_device to
provide various callback functions to support
smuio ip funcitonality

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h | 37 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ba65d4f..696e491 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -106,6 +106,7 @@
 #include "amdgpu_mmhub.h"
 #include "amdgpu_gfxhub.h"
 #include "amdgpu_df.h"
+#include "amdgpu_smuio.h"
 
 #define MAX_GPU_INSTANCE		16
 
@@ -923,6 +924,9 @@ struct amdgpu_device {
 	/* nbio */
 	struct amdgpu_nbio		nbio;
 
+	/* smuio */
+	struct amdgpu_smuio		smuio;
+
 	/* mmhub */
 	struct amdgpu_mmhub		mmhub;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
new file mode 100644
index 0000000..0300915
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
@@ -0,0 +1,37 @@
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
+ *
+ */
+#ifndef __AMDGPU_SMUIO_H__
+#define __AMDGPU_SMUIO_H__
+
+struct amdgpu_smuio_funcs {
+	u32 (*get_rom_index_offset)(struct amdgpu_device *adev);
+	u32 (*get_rom_data_offset)(struct amdgpu_device *adev);
+	void (*update_rom_clock_gating)(struct amdgpu_device *adev, bool enable);
+	void (*get_clock_gating_state)(struct amdgpu_device *adev, u32 *flags);
+};
+
+struct amdgpu_smuio {
+	const struct amdgpu_smuio_funcs		*funcs;
+};
+
+#endif /* __AMDGPU_SMUIO_H__ */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
