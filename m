Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8488FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2913064E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2913064E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866426EBF6;
	Wed, 24 Feb 2021 22:22:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C3446EBB5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4b5kMKqpgFS0ShD/WnCwHTY8rYbb6DGPCPAhwBbhCjfAI/aUOYL+gBumqXtojSMnwGE+5kknPF+KMbhaG9BoGSzcV7iuLpdLJWlg2pveWl6m7+sxzhotPq8pZJdyg17uneevJ0DgIo5ahrDcot+38Re25puwAVKF3P+bu08syCngvZ7MkWCZtqjt7K/eSpX5IbUpQL/UL2IMrrw6JtCfkxTibrQzHGlOfWwownTBU5c5MyfONX4vaWuyTsL6w/UvxHg2vYFH3FwsNeif4YQLl+i5+IfxBcLTWwJI3Axj0+pivhjEo2MclfQBvo4OrSEtWreASBErbfDmYDl+0l0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spgmAYcdRErE5hs/97ylI1cdtyss0JyAY4WBQvc4mFQ=;
 b=X/kfPodUsosLVUF5a7pMrhhAHTRKJYtW7lfxMr6LpBDC4qHz717HQrWkRaHTY42mdmM+kDNc/kPrr6WAlKwfaiIf60JPrpqPgKzQ6U4KjeNOMgVvtvVFkZfGoCQqMq+4gjYVR18gWDJ8sr1FgAQV/vV1qFQMyWDR2r6sMeCxMl1CYytb2fUkaxKHTzmvyFfEdPzLQ+V/kkfHhEFcPCgS4+kbQEOlAzAbhKvhVGg5k1//U6e2alVI4JHz5wUMXF6FDh8UU3qUdOwXcisTlOkeF21TPCMg7oB6hfgfv/Mg0M/wAUyVI0FkkOcEp5YIBxBPrZyF98LV6brN48nFWPzL5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spgmAYcdRErE5hs/97ylI1cdtyss0JyAY4WBQvc4mFQ=;
 b=J5fNjk/wEGJ4kCP/g3yQ37gGsgkgRHm43zzE+Z4Xg86p3omAbA06+wSXXilxxKS4gQSy1cSY/4gK7MiKojyD/IE2R5b35shOgOKVnkUB0qPWbbsl6PsPrHi2RMMJ+KXsZ57ZhXoUHEp5kUvF6aP9iWF/jRFskIPqg3w+bOS9Wik=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4831.namprd12.prod.outlook.com (2603:10b6:208:1b9::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:22:36 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:36 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 147/159] drm/amdgpu: restore aldebaran save ttmp and trap
 config on init (v2)
Date: Wed, 24 Feb 2021 17:18:47 -0500
Message-Id: <20210224221859.3068810-140-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:21:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45a61cf7-aaf5-43f7-d18c-08d8d91277d1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB48312494524B4B98BE569D91F79F9@MN2PR12MB4831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GkAmhcetroxkho4e13DoTE9rclXEWsDxDdxxxP3DlDlBvrDK0UmQMQvSOJ1KNV6O+LE2M42TfuY12hQ0noGA/q3G35+dNs+1pzf1BQWTa0vAxUuL6NQXTsWDd95jqILjwa9Qfk7cijModiHDTcEoA4ysRv+heuZK+RjcrmJ+7Rkr/A5PcC6L/T2Ltf+AleOrRcmhgyh6s2umipP4GuUnn0R0I+WycFxNdzwlH4w7Pl7qAwfBsIgCmf8E9yzbrmbw89pBzJQdpz+ZTFMe/p2fLw12R0pNzx7KJgJL7fvLWVm1vLhFRct66v9FeFkIdQoPdhNFkbFd10l4t5qLeQpxcLcyubAwhhUg2nrIvrnJHf34rHoDIvGW6A6t5ZVBkDJYNgNFmg+xLdJNobh/hdnj0GJLD7MKPGXx5rgrouGfe45U77hg3U/jf9anBvV1BpZIQtlN61WBK2ho0cV2/FDk5Ti5SleOecaPzQmI8Aw8ar8cuapJLVXdSef+mANSCeFVc9XA12D5onDwglFWKUr71HKq7da2WQmT/MZ1huW0tpvbGL6fyvI2ajDIMyvW03TeruEjDbIOjFdbmxcCMrieg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(5660300002)(6506007)(6486002)(83380400001)(316002)(6666004)(1076003)(52116002)(86362001)(478600001)(54906003)(6916009)(36756003)(8936002)(6512007)(4326008)(8676002)(69590400012)(66946007)(66556008)(956004)(2616005)(26005)(2906002)(16526019)(186003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qC27JF533T6T/hoV1P7oo5Z2EMafOpvsISP04pjmh0VtSQ0hBHYBftnVgAtr?=
 =?us-ascii?Q?YmYBXm1Pg8qnT4aA1J3QsWD9WpjuV218FimYEWA0K5Ut/YMBlkjnkHiPrkqy?=
 =?us-ascii?Q?Sb/KmdroVXT+HDiwYmuk0a0WefLvInJtFDfnTqaE49j1ZR0dVAQHyOqyXeHn?=
 =?us-ascii?Q?sD3apKWxpcKTevoPFqGJIf4XFSMsXrnYjUK0p3J+vnJEUROU+iQqLa8VxAAb?=
 =?us-ascii?Q?7Fimg9taSJEmhWdvG2ShpfdRFYACLnsDWLYQkHj+jO51XEcYAGB5SbChy7XD?=
 =?us-ascii?Q?Dyojeos4d+mtBFMAHhLHQGB8/9Dp8hxAhid3OWyyEbtnRQ8WNS3pBoPHm0Ry?=
 =?us-ascii?Q?6u5rNt8yavCz8teWUyAr7P+KoKrAssiDzv5GGpGy9UfR9q6mY0UVDj12/RCl?=
 =?us-ascii?Q?3rNogRdWxuLrRipMvcYVttL1R7j2lPg3+zk7DAuKVhUSUDhrBX3dv9/nEhgK?=
 =?us-ascii?Q?GNRniJu+hTRm6Rr9i86futjbBcSj/mg71tKMF20pyxd9ffeZvNLZu1AuSjOa?=
 =?us-ascii?Q?PalYU0JAhNhkSNncpfgWO1U2f77mjCKxjCV0C6uvC4BzxR7tNBddlFz3Kr6S?=
 =?us-ascii?Q?SoE/g2d3lEOpl8RKE8IFPna51/TSlWRqJ5555XCdL0ECir/lzVJlWY0mw5CK?=
 =?us-ascii?Q?CXD6bP1mJHUgGRRtuSqbmBKbQO8oRUNtw1UpMeu8W0QvdHkxobJmUiTnGn8/?=
 =?us-ascii?Q?vABxgrM88Y6+ueq/3Y/8URn8LnMmGS7O0NI382t5F4YuTnCd1ksUNOdjniFo?=
 =?us-ascii?Q?UJqCTaizeNSCbKHUv9bv2bEvIw3mcfTW3yO1rDyL4TH/uiIP+FGMu8LQJ/fR?=
 =?us-ascii?Q?tVs3TTp9sQNgnepdP9K9e29KzvtO1uJxuk6xAXiiFWq3vSoZOafPfyM4nPBF?=
 =?us-ascii?Q?UwqNVHk/yNo5ARYQ7VncBPvhOztFOabzjIJgeFdnVcfHui2AjgHUaiGWOK1p?=
 =?us-ascii?Q?Mtq1DmNuOcrlBLudQaN8vqvgOJHxV7ccRlVEuaPnOzORDOanAV6NiQOnPuME?=
 =?us-ascii?Q?bUdM63Qr9jEtrWapsRAVLa/eQiTEcmgM9R92hX/mLH/lTJUxWOA/GI1mBBP/?=
 =?us-ascii?Q?vwSzjVvtgt6ZMSljOwvTu8OCGl4z2vpdkQR6a1+k1HM7iydSErncI3UfKtNg?=
 =?us-ascii?Q?zQouLrdl4t9OLhFtHoYSjF7iQHGkdj/e0zDoKSI+AV5hVc9OEGDiSgm1Mrhv?=
 =?us-ascii?Q?F2yFtaLlz045Gomo2rOBSYVvrM4tcO2b11qLLlSG6qJUtHRP6PrkSxD0lV8s?=
 =?us-ascii?Q?ZOZX2LZBj864p4N491p6bsHEJnTLSnoUX55eOVUGuje+ighPNFcRG0UicnG6?=
 =?us-ascii?Q?IUIIJIbH3boOawrRtUG4lBfn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a61cf7-aaf5-43f7-d18c-08d8d91277d1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:01.7456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ueUvRLSzzHjVbNCoKraJ3d8yjPzuDEn3f3S9zhUPJwFM1V1ZPcXm+CqTancnj2qumaEKKmtwk/qEBUq+yUXXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4831
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <Jonathan.Kim@amd.com>

Initialization of TRAP_DATA0/1 is still required for the debugger to detect
new waves on Aldebaran.  Also, per-vmid global trap enablement may be
required outside of debugger scope so move to init phase.

v2: just add the gfx 9.4.2 changes (Alex)

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 50 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h | 30 +++++++++++++++
 4 files changed, 82 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c5ec926bc6d5..741b68874e53 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -123,6 +123,7 @@ amdgpu-y += \
 	gfx_v8_0.o \
 	gfx_v9_0.o \
 	gfx_v9_4.o \
+	gfx_v9_4_2.o \
 	gfx_v10_0.o
 
 # add async DMA block
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5bac5659e707..78bb4e28c27c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -49,6 +49,7 @@
 
 #include "gfx_v9_4.h"
 #include "gfx_v9_0.h"
+#include "gfx_v9_4_2.h"
 
 #include "asic_reg/pwr/pwr_10_0_offset.h"
 #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
new file mode 100644
index 000000000000..0c2ccbe327ab
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -0,0 +1,50 @@
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
+#include "amdgpu.h"
+#include "soc15.h"
+
+#include "gc/gc_9_4_2_offset.h"
+#include "gc/gc_9_4_2_sh_mask.h"
+
+void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
+				uint32_t first_vmid,
+				uint32_t last_vmid)
+{
+	uint32_t data;
+	int i;
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (i = first_vmid; i < last_vmid; i++) {
+		data = 0;
+		soc15_grbm_select(adev, 0, 0, 0, i);
+		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
+		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE,
+					0);
+		WREG32(SOC15_REG_OFFSET(GC, 0, regSPI_GDBG_PER_VMID_CNTL), data);
+	}
+
+	soc15_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
new file mode 100644
index 000000000000..5b175c10de23
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
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
+ *
+ */
+
+#ifndef __GFX_V9_4_2_H__
+#define __GFX_V9_4_2_H__
+
+void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
+				uint32_t first_vmid, uint32_t last_vmid);
+
+#endif /* __GFX_V9_4_2_H__ */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
