Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C9A1073CBE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7AF10E667;
	Wed,  8 Apr 2026 13:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nl6TVWDX";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C78510E667
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3RI6ZBl+GfU8uojy026ZSpzzUeLzvN0CJZFov9pKZT6fB6Be56/lJeBy9Q6jso0kEBVaQrMQ7C14x+2wfN28u8+e0U3O6ZrwUREc1GejU0HmY6DGOPEJGA7Ul1dqOmLWK1AH7V4yPeCLZKfBtff+eBOVVb/KGYKSgJpQjPVj4NX3DTWCYCR7G93H2OBRfR8wIBfN0BNaIIILqfO/4rtGNGxarK+d1WcuvktnL8ikTYSLs33/SnyaVghAQF3cyil83n7vOCFsxgbO+TQpMb1dGI8a4Ysf+KWeFSiPcXBUWYzfgVEkFoVK9hxtnQlyAv76jpM2IdubRGNT+XTK382Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUZ5NQyeZJN2dyJP5rQt5XXq3lmB7NtbcpqiD6pNWCY=;
 b=Hbv4TYZ12+AYQyZwc3S9kZ3m+HYpd30d5OV8BnyoKOxs71gctPAf0hYOD3DUeHOGfExxil+CrPFGX0SZysogGRPxHBWJZ9FQATpHZxh4qPVmEnMTAv6Fh4ZVV5ezfteZahB+5Jba3VxyqTD0RQ7wNE0MC4IETaGKg6nC/U52Pz7LdKeXFezMd5RqsL+pXU+mIlxnhI0xk/GqILybSHhC2FKOz5COB24m/6BDjA97oOzUW4cpw5aY8xpyRhp+2YHFjdN8GdP5z59ywpMmhJBkWpiZCtv58bFLf+w99IKdFKEPn+qdoKrnS19PePwVZnM1o4a7v8ELoBg9pcQRhgZZog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUZ5NQyeZJN2dyJP5rQt5XXq3lmB7NtbcpqiD6pNWCY=;
 b=nl6TVWDXTf++m3xdXravVoyjq402+5Kfkn9xSxNA2JKTnD5/6odpkd2EdOGq3YaXS1sr899UyWKmM2yrt5TL1CSgElgTwEnoemSNzykbB5kLb495/LlEjITVCDPuRQkVtOGigMoaxemlIueJvtPNSeVKzmUz1f/V0vOZUCPrmb4=
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 13:44:22 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::f5) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 13:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 13:44:21 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 08:44:19 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Felix.Kuehling@amd.com>,
 <Alexander.Deucher@amd.com>, <Chenglei.Xie@amd.com>, <jeffrey.chan@amd.com>,
 <zhigang.luo@amd.com>, <Christian.Koenig@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Victor.Zhao@amd.com>,
 <David.YatSin@amd.com>, <Lokesh.Dhinakararam@amd.com>
Subject: [[PATCH v7]] drm/amdgpu: gate VM CPU HDP flush on reset lock
Date: Wed, 8 Apr 2026 09:44:14 -0400
Message-ID: <20260408134414.459833-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f95d4f1-9855-4a73-8bbb-08de9574f0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: JZvA3fvdxeOOrlhH+FA+G1AmrlT0DTUatRof4qDfwv6pXK8bfdB0Pz7glioVRUdhrI62OU+2HhbbzxHOxVfzo2+I9kGmvyeNg/UXbL1vpjqSwR9MCK2Cql5Ff32+QFHLoFqLNVCyZnPGdQctzy1pZ1aiUjJhjwQOWKKQyJ1rsafxg4u0qCaCGo9jJ35jnZUAVZJc3s4RaozMY3Z0IMtuc2p29YJ8L3b+gYDqdC+6VgXqs+3eKlW+8NLI0vNL1PbDSEGvEWCsz+EjKowAOOLhjvb+lWbic18ccXCJgcnhBYqjp8PhQ+VH5RXERnchhULHlCpsTSUXaCeW3xl3ZS9TPqN7KTdzXxApvrV9La2JHF27zyS7opqc2YMDT9WqubA9IWRfKINJpJZIS/kw/Ec0M4y5marEbrf9nytWe72eqKaHttsDBcznHrbSvsj1Dcksm4bxoEqSCIsXESJy2zoODeh3fo3t5tMP+HF1nANHfH6wdwkdztgP559lIFbTttpCzInFuv6Kdv1Y3AZl0SsMtmPQFbVK+TfWeS9BzrIQZVW2TCXLeKtLO4CtE4SxhIxjyz6yrpTYXefVCxjQbLAN0j6getbowDyvojzsyVI+TEX2Abf4SInqz0M8pDN0R8KF6tJ3DDaabQw2q9caAUNLLmPSbsw+a98xmrqB3zt6rM4ijcwfFRbf4Ej7s0ecY7g+AguIEtB+bmeAtCYsjqsE6jlJseITlpZAFMSjQkRM30H0zERx7Dc5+KIfUz4+4DpxmCSEIEzi1kmpLU5HLu/SJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y2LLVYNJXOa8Q6XxQFIEBbiE2LQwq4cxx7W5CSk/C9QOsqkO82eox0m7xNYl/ixvwoBJb5BHwY6zEaYzpZxkN0kboe7slhiJVDF5ZJZNhtq2QOY+/Mn4IJVwuIekR96Ky4wSZSgBxi7vczfK1f/obsMyMzumks4m/VR0I/GIWhrJrF32wtjqBeK0PMXNb2g/YE+W1DWEa5VRe+AX7zIsNxQc7eEP4lKD4WdamXsL2ZkrBxnS+A9WzWW0KECOsI+7QRQAeDJ0X7/fg+E1jcKzMXkBI4R6HAd7MjaPKC4CCN/GfpyLvOzDkC66k5daZNLzWTYR37u+VNBbTJAT3JRHRGJypBy3pfeBRAK4S0M5l+KfoKCs+NmGOKQ46IOASjjVsmwvsxJE9H7pmC0G+dEJqHuliQqMDftT+HqReEiPWEYFN8ZO1FGtMYFvVPssX7Zl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:44:21.9098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f95d4f1-9855-4a73-8bbb-08de9574f0b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445
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

During GPU reset, the application could still run CPU page table updates. Each commit called
amdgpu_device_flush_hdp(), which on SR-IOV sends work through the KIQ ring.
That can advance sync_seq while the GPU is being reset,
leaving fence writeback out of sync and causing amdgpu_fence_emit_polling()
to time out on later KIQ use.

Fix:
amdgpu_vm_cpu_commit():
  Reset will flush HDP anyway, the HDP flush in amdgpu_vm_cpu_commit() can be skipped
  when a reset is ongoging.
  Take reset_domain->sem with down_read_trylock() before amdgpu_device_flush_hdp().
  If the reset path holds the write lock, skip the HDP flush so no HDP-related HW
  access (including KIQ) runs during reset; state is re-established after reset.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I938bce0cab93a794dbdb02fe3ca9e041f9ac1424
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 22e2e5b473415..f078db3fef79e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -21,6 +21,8 @@
  */
 
 #include "amdgpu_vm.h"
+#include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_object.h"
 #include "amdgpu_trace.h"
 
@@ -108,11 +110,19 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
 static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 				struct dma_fence **fence)
 {
+	struct amdgpu_device *adev = p->adev;
+
 	if (p->needs_flush)
 		atomic64_inc(&p->vm->tlb_seq);
 
 	mb();
-	amdgpu_device_flush_hdp(p->adev, NULL);
+	/* A reset flushed the HDP anyway, so that here can be skipped when a reset is ongoing */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return 0;
+
+	amdgpu_device_flush_hdp(adev, NULL);
+	up_read(&adev->reset_domain->sem);
+
 	return 0;
 }
 
-- 
2.34.1

