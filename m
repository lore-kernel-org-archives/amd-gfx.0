Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D200CCD3442
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 17:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BEC910F631;
	Thu,  7 May 2026 17:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MCQTWRM0";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 353BE10F631
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 17:30:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYblU39Mu2+NsWXUrZ//nSxpnxejvU5alG0E9qUA+gMWHi8fwR6Vyhb8C4IkQQB7xbfDPfMdmcBRI28lOuCr2lXp4XRtfGpvwZkeNrczSxMfxaaIc+equt0iq+sTLPRlX9+lOnLABlm8N6elyeDc4atpSF/2YOM4cSByGcF+AB9IWzD6iOTvSMFpObEjj2eh29U6uXxqeiivvZN0jdOTRzGihopipLKmUL2X6IjWWUH7jDm4N8/7XmtB6IbTTwwTDX/mlJx6VbXrv+PWDd1X8Ax5ruOAutTMadGHH2FIH5XD1wIbrO5vMvUIDTN5z3ecWPmyTtoR15ahfX5gn6Xcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJffpvQLG8v/DQxqcUbr6R3llCMvfSjtWhwBYCOgkqY=;
 b=dWJ4zQ7R9nf2/i+McUGafeG1Gm26ldqv2UXMODmxco36brKWzOhrYUvnpjeUvewcM+YkUg5blj+wSLsqFiZiX9EmiktM9stlRUfqB6EtberxEU8vkqyUgcFs8HQtZxfqm2VeRV3ZqN+xxDrAoZ7EvA3oqsYq/whaweWIgX+UsGyCPsw8VPjvU2qt2T8kYTVm8oE3sup29sxtLYX4wxPph9pl0eApJOSnUGEJ/XnS5rXIUYXy2iz+Dyu/Dez7D51l79B7M73YOERjTXwotl9VGLIWx4J/nVD1gu4DaqSryiez2ZQx2zy1dedy0VgsrrARyEZ8OwK3SG6LceBHiGd+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJffpvQLG8v/DQxqcUbr6R3llCMvfSjtWhwBYCOgkqY=;
 b=MCQTWRM0a1B44gHXmyNOp1f+LZsrQGm3GMXXEWNyPW2OQ1Xr93dDcIgkJBqTE++GsVu/cYw9p9y4+9Kl+AVys9b8P9ZdDiUgQa6j3VhQmJDlvGT+XBw6gBZFS0fKt626emlvqQCFYytVOmVD1awoKZAAM6y7m8bwzHpHG7yCL/8=
Received: from PH7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::34)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 17:30:04 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::4f) by PH7P220CA0002.outlook.office365.com
 (2603:10b6:510:326::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 17:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 17:30:03 +0000
Received: from amir-devpc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 12:30:00 -0500
From: Amir Shetaia <amir.shetaia@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, Amir Shetaia <Amir.Shetaia@amd.com>
Subject: [PATCH] drm/amdgpu: reject non-user addresses early in GEM_USERPTR
 ioctl
Date: Thu, 7 May 2026 13:29:46 -0400
Message-ID: <20260507172946.2048931-1-amir.shetaia@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f2aa82-4465-4ba4-d066-08deac5e45e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Npd1qzmXvrp9lrOJr5qvLkiwFWSIg5izIJ0yr/a6wkGmOXTbKOaKnveIsCIg5oriBGRy+t7ff5GR+I4/IlNZRecaoTVaXy47WELvWOwJ6tvS7QnVX8N2dOKJk0WALAFsfvG7dqjq+Ed4d8ZJwNaLk0JD1OreQspua11kXGPn5bGmpuJ26I6G+HQoLnxBbUato0BsEprmlNq/UThH46Ok7/DGth9DOKc89QTzZjneRcIm1zfG8Z2n3jbBox8Mu9I5DufwN/TaBCzeTJZW5ws9UWJdOSDNOZq4tLeSiF/hxKL+RZy/fl06Whct0L0KFDgbKxKY//q2Z+TPP+3eKpPmBJ9/4ATCPcmbMRi1faEKHbfuoZ65EB2RG95HTk7nuStQtJylEHJ+0dG1F3m/j8t4pnXgTl/4moEQVx4TMDIzCN7vusvotFOQGWPPnIr0GSVEPAIsuF3iOuVrgtTrCKmAkOt16MT/RglsmtCePuy/DfcxtzkIV6Y5VsgKT7ywqoXd5IMu7iJbRk/MM0ZP4u1W9Kx98oxXszf+tCI6/uUt77FuEJTABldcPZMCuwW3Zzs3HVAoLItpWVtNdr3NC77LBI7EdN3hpYxKefQlwF2IJRKQbQNIuejmlYRP87MtSRzkH4kUF+yE4zdfztbV+NHVNFP4gwiejHZQXU/2xK7NeFBS90OefWOp2OZm5UBr2K8a9TPpac2mkUF8csg4GED69GkB3wjmTFfhjJrAs8Ukxsw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zdvPl7Nnf0R5Dk+rgwMZaPrrTFbTlmNzipEE1X/PxFf2RpxlDyhh69C9wF2CSQ3UhIDHC04DOFoWuR/GOMXhNK1tnrcX69x8yLpZO6L9fGS7J7T+EPvhLwqFocL/dpFwbN0XWqIPbK2c3AH8uJMMYnTtQ/iHRlulXhhf2WgksiD49DypOfmKy5hr+3Gn146KA80F/Tb6RZ96NZj11PHF4wLWQTYX0g39KmUcPxtdU40dBVC6M2pr1YAzlhWgTzcUICJMWY0+jgbbuE2cU58vxY7HuFeOsOikUxjpDMWul1jvF9mgI9PnJslRo74pl8rcsO4jnurE7df3MzSSxWJghNyB1+C+ZE1fJAFXIQY98q3Lg/2gtCqx5Ce0rRvKjiAI8xxwFNRjmHXucNqZLX/0hAyI86IIt34Uzz52iC0KYnWpvkJn2K/eHZH7B6aMqfBL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 17:30:03.1712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f2aa82-4465-4ba4-d066-08deac5e45e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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

From: Amir Shetaia <Amir.Shetaia@amd.com>

amdgpu_gem_userptr_ioctl() currently accepts any value of args->addr
and only discovers an out-of-range pointer much later, inside
amdgpu_gem_object_create() and the HMM mirror registration path.
Userspace can drive that path with kernel-side virtual addresses;
the get_user_pages() layer rejects them, but only after the driver
has already allocated a GEM object and started wiring up notifier
state that then has to be torn down on failure.

Add an access_ok() guard at the top of the ioctl, right after the
existing page-alignment check and before flag validation, so any
address that does not lie within the calling task's user address
range is rejected with -EFAULT before any allocation occurs. No
legitimate ROCm/HSA userspace passes kernel-mode pointers through
this interface, so this is defense-in-depth rather than a behaviour
change for valid callers; -EFAULT matches the convention already
used by other uaccess-style rejections in the kernel.

Also add an explicit #include <linux/uaccess.h>; access_ok() is
otherwise only available transitively through other headers in
this translation unit.

Signed-off-by: Amir Shetaia <Amir.Shetaia@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 0071d6957828..ad3d371ad7b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -32,6 +32,7 @@
 #include <linux/pci.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-unwrap.h>
+#include <linux/uaccess.h>
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_drv.h>
@@ -509,6 +510,9 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	if (offset_in_page(args->addr | args->size))
 		return -EINVAL;
 
+	if (!access_ok((void __user *)(uintptr_t)args->addr, args->size))
+		return -EFAULT;
+
 	/* reject unknown flag values */
 	if (args->flags & ~(AMDGPU_GEM_USERPTR_READONLY |
 	    AMDGPU_GEM_USERPTR_ANONONLY | AMDGPU_GEM_USERPTR_VALIDATE |
-- 
2.43.0

