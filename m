Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9077CDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FEB110E0E3;
	Wed, 24 Jun 2026 18:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3zBTrsBf";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F00A410E0E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZYwIbWo1aTZT1J+H4WPP+ofuvpO5gkB1eIKTJMMOVYn0ap7aXO7kJXGb2G1TxNzjBsXFiOLf1ypWuGs0tZx3NfeBSQP4k3YpWcDFqqj9RR3qK+JHk6fLQI/WYIQYZ9Y7wYgtB39yFSk0HTyzKl6g63RKr5DMZ8UHv+y5lkalwwKG2h9s0d9dlrNxIg7uSTTyQ2cnaFar5kck2JfzCE4HJLZDOiKOucLZC8D4KICXjbQKe0Ulk42vpwpo7Afp5N5GeFezr814c46sQCL1GPOTxCmSkBZugfk1zOmP37KhDVXoNNe0Yd3+wz/hWdF6w97qYMraE7xts7ZkI3LqnZ/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sx51wHTgtAusAc5DFbb2fAyUWUQuYibfkU5hFDb6Ezg=;
 b=LrGk467DwQfSMYbsnvXfmE7MZJD0p6nUdBQJVj6XE0OWLwb5AW7NXEzZlkFSIrJXvicFDBJ0bTn+X348gW9QYLv0WTYDG6OlSIP/Qo9cRk5hcAPOGIIwdUTOFjV5equ4rDR0oKBtXGr2lzb5EZs0sKOJ1yJOdw36WfwNQySVnzZSIgsiO6Jom1Vd92wEBz622Avq2bBC1XOJyPEipvDxX7822cHUlGdSUaDRtsxc/N1bmzz1bcP7lUW0gAzD0bx8NkzQuNoUsu8t6xedqNwIsYX4A/rIwLMwqT+J8oNvlAYuZJ3QcUKJpy3yWYe2LWVsSPPZCtFg5RvEMDJWKjGllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sx51wHTgtAusAc5DFbb2fAyUWUQuYibfkU5hFDb6Ezg=;
 b=3zBTrsBfZCGzWnC8/yzmGKAF+ff+tcKHxd6C2XhYMt7evVbpI7O8yytF+IpU19OQ2WaFaenMOU/L1FULdcG7wYTdwZa9aPkYWJwbJn5X4rtyJwJBkHCosK3Hry3C+c6iBC3ftNLeJJTBQbMTTib2bym2bPvTMdenahSWZ1Q333Y=
Received: from MN0P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::35)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 18:34:22 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::38) by MN0P223CA0018.outlook.office365.com
 (2603:10b6:208:52b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 18:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 24 Jun 2026 18:34:22 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:34:21 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <philip.yang@amd.com>, <Hawking.Zhang@amd.com>, <Bob.Zhou@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <jamesz@amd.com>, Vladimir Indic
 <vladimir.indic@amd.com>
Subject: [PATCH v3 2/2] drm/amdkfd: move TBA/TMA from system to device memory
Date: Wed, 24 Jun 2026 14:34:09 -0400
Message-ID: <20260624183409.2038354-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624183409.2038354-1-James.Zhu@amd.com>
References: <20260624183409.2038354-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 33050903-1076-42db-6bcc-08ded21f35e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: GPVn8ZHjSjmM9S+C9GB+Z7M5RWTbKCJdOpK/QINZHe3dk3reW6A40Uo8sf4/dDss1XG1YNGF1VdJoA/QrxrludhNVIg+CJuZbcThSgIpKgnbdQRlWsEdo9VD+AHL1A66aI5xnpp6FX7tOvNiY0lo3EYFqgjWuNhv471sdbVyYlo7d0T8cW9xpnlGunPwtytmul5H0NLMZFvs5xZ5E3Ukq5RD1ySR1LTZ0lwQ7xJjSbw3liRx+zEdRJfTXu3PzN5snRvhkf0b4mH0QScx/qsYOkbiNiKNnnTXn5o4qVPM2h+i1lhqtK3CZVpPR2cNBZPo1cgdmqyfXWCx1adCJYavMArDFekWsD+USugy7Jefyvn9g0rfX0LLSFGoat1U3VbNDtr+oOfuNuk9oKZmaHijgfgDJbQ6VAt9Uj7PU3sQUZ7CiPqgHAShdtwmBk9l5Nsbb9U8A58DdScl9OUZlfcw8Q2JabutrnpRnfBGzzNzRio2AsCirw43dAG2prs99BiFMpqWuqr1/146RWwWSBU6mHJZq82V4JU3NtskF0fLXXObK7gPsRlny48387E6nbAAFKftHUYEbQGz6mi8FFe3UNtnMLsh9dC3zsmlMAxCrgQeLUdvkYW3UEaeuu4Z6oggUOFJLNIO/WpddHRH63NWSil7I43BgO9ObKj5H8NiiHk9OjS9/uYO4v0nmQ4O6zSmp5ECAgTeX/s5+OA8hUCOqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TmtSrFumG7L7rJSem75x2qHFQ3JMFiEPRQiiTAYpfaN2oXu1KPa6VfVZguZkxhZVqTZ/Vs7ehMqp16aqSGqQ1qMWqBL6J453bkgV6K/l3m37QMwQ6cbv5rfr6DjZdmqKwHkaURFpYrmu63Q08oGG+qlGWX4w76PAMkYvTlgikkh848c6O65o/mPDttoGLvsFebkXIA9SmP/5pJDYOwaTPbuy0qQprDJnYDOh/LqFZH0K8j2OLI9IHCPgDcesj2gbGDOgoEC4xj4ZC4wm2dH2UVwZXXU5dnFetKD2z99OQ6rntW+9QBHukiX4/K+UfcdBE6fDtfPvO98Iur5kJy3guTSWsAOKR4L/u3mqjQv3O9yJU7Q8JhR1/e4zRgAoZFs8L/KRlWKS0+5lCo5xZAnsx4ASYiCA+nTWQF4/BfVmTMnXLxp9bMnCGhFolj+MVgm8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:34:22.3038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33050903-1076-42db-6bcc-08ded21f35e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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

for GFX9.4.2 and above.

-v2: keep APU with GTT allocation
-v3: use dev->adev->apu_prefer_gtt instead

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Vladimir Indic <vladimir.indic@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 08f6db864bf9..8e701dcda8ec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -776,9 +776,14 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	}
 
 	if (kptr) {
+		u32 domain;
+
+		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
+			domain = AMDGPU_GEM_DOMAIN_VRAM;
+		else
+			domain = AMDGPU_GEM_DOMAIN_GTT;
 		err = amdgpu_amdkfd_gpuvm_map_bo_to_kernel((struct kgd_mem *)*mem,
-							   kptr, NULL,
-							   AMDGPU_GEM_DOMAIN_GTT);
+							   kptr, NULL, domain);
 		if (err) {
 			pr_debug("Map BO to kernel failed err %d\n", err);
 			goto sync_memory_failed;
@@ -1490,8 +1495,7 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 {
 	struct kfd_node *dev = pdd->dev;
 	struct qcm_process_device *qpd = &pdd->qpd;
-	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT
-			| KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
+	u32 flags = KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
 			| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
 	struct kgd_mem *mem;
 	void *kaddr;
@@ -1500,7 +1504,12 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 	if (!dev->kfd->cwsr_enabled || qpd->cwsr_kaddr || !qpd->cwsr_base)
 		return 0;
 
-	/* cwsr_base is only set for dGPU */
+	if (KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 2) && !dev->adev->apu_prefer_gtt)
+		flags |= KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
+	else
+		flags |= KFD_IOC_ALLOC_MEM_FLAGS_GTT;
+
+	/* Allocate CWSR TBA/TMA buffers */
 	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
 				      KFD_CWSR_TBA_TMA_SIZE, flags, &mem, &kaddr);
 	if (ret)
-- 
2.43.0

