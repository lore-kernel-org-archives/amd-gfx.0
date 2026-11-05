Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CB606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JivsPML6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F7E10E6A8;
	Thu,  5 Nov 2026 09:38:47 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013014.outbound.protection.outlook.com
 [40.107.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA7C10E6A8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 09:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTI6eex42JYLhGQdJnoT3oOqKf14uOXql9XzQ2iJE9GbMiU93/opSA9Xq3ccI6eHwwgjTUPlyDyDaUAiVTsr8/ywLlQ1XWNhL6jpz+zammBxYSH4yoKqnEyGvvohtjbOV8JQmFyjqrBah9OYjbAfX9TplQt2S89d5KdSyrWTV+JU5EFawOPbASgjvNKK7N6mWos+CfzSKFz4vW8/Kn2SDmeWvj4ZvTUP0NnEtvCKnW4O1Pzdps4r6K2DQqTJRbQt4IlGHxRlaAEeBMeYvks1NyRCurMF92nBQv0RMecgbmH1KMlcvxfcySPVzTTDxHlF7k4dwW9sN+zASIUnNqSNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIUI08OOjgqbcsQhlLQ2B29gNiLojsy7+gev6NE2qyM=;
 b=OTvhOT33tbnuKQ5lULDFlugBbvv7ION2gMJCUolFKacyrXiFQ2cz/zaJPWyxDJ6yrrSWT+zg0aKcjPl90xIZpTQ2V9GXfrfD4rAgQNnYlflPL8nzdRQWTd/7ZFFgLwdmWcU4CgLRg4TEKwPe5XOgQN5RTpqVgjpysxXFnb6TyF3lzwehp9TVKH9DMsEbE+aFvQkkmxp6+huIguXZ3kCcNzLmNacxd+TqqiSvCNDCuLYQlIu8DwRY+eiXhC2BErTcXdDMVSXmX0BnBegjN7aHIyhDxH16zYfg1DZoebzazSDUBtTMkW172sxVSKKgVGNAsYsdNU7os3S9NY4A7FlZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIUI08OOjgqbcsQhlLQ2B29gNiLojsy7+gev6NE2qyM=;
 b=JivsPML68a2Wqq+6HnnMbZA8ycjuyddPW4uUX/VHr6uUPO2iYQTzKQtDEeTvNa0ApjOmDQ5Wr7XoZPUBB75J++0Tmj/xGSc075SCp5Ue793pccn4Q9SayOyrNCxO4tbBVyAzv4YagmajRC3MFhrgHLwcnWVbz0TKXbDPv5SWsG8=
Received: from BY3PR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:39b::24)
 by SA5PPF916D632A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 09:38:36 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::1a) by BY3PR05CA0049.outlook.office365.com
 (2603:10b6:a03:39b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 09:38:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 09:38:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 03:38:36 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 03:38:35 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 5 Nov 2026 03:38:34 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix the error handling of
 amdgpu_vm_init_entities()
Date: Thu, 5 Nov 2026 17:38:27 +0800
Message-ID: <20261105093834.971607-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|SA5PPF916D632A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 11548f30-7fa4-4ec3-4709-08df3b2090e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|261026140227099003|10067099003|261021135927099003|261009223027099003|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261022075727099003|261021123027099003|260925021311599003|260925022911599003|260925021911599003|11063799006|261022105027099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: u36dGl52tPqJUCYXpyCspGOZmFKuog6CcRF6ONSx3AG3hIHaO9OSLldbC6yMfspwQBarH3lKCvCZkK1El+RkCUAR15E8jBZ1i3f6zY28fJZ2YGu6gc5p2HrA8UK3sT3vBYvtDYuw/4B+3cupusFYi+fCO//ig0fuYYK0KlndXac/sSUCzbHXSxKdUDIfwJwC3Ny+bni/BGlGy7FOFvzUZiAf6MP0LhHIh/572pydMIAwTtbF1RIVh2Ojm3ru67YdQVZN3tnQl8+Ugcj04iImlJU9TTH4Z7uBPITb3TXufQTYnZOXx1AOCTPucKICY8szNbTtWKnEigBxvzpGKdqgV4lSQ3TTBBDccVNi3YTlLFn/8+aBrgSGx+/rz1mIkItN2PvOV4JAq4wVmFweOQ6nvBfQ35+NyQGARXLMrFlr+fjw9HPXS2rK+WAwdTCJ0X8vU94p2ZVZC11f25lRXGdyrWXxo8t4pewh2zzorxtmD5oBmXi3sAFFmzKDg0LW55j6A0DvplrbnmhSsrOdEBJoRowGVo112QzgLvdUhqvmnNi+W3QSi8B/sEimig3VcUY0pLCAAJ4rA8TZlcHPnQB1e6T1YtLWZy0qSwn/IJ1mj5hqOvTZXjSG9fuRFa1yXSV2Y1+CAga/GCFyx6JNGEe/9Qrj8AVRPTAo42J9kb5clzH5sDjby4yDsgeAVioLT5n/CkdIpUOtcNl8c9LBeHhTfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(261026140227099003)(10067099003)(261021135927099003)(261009223027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261022075727099003)(261021123027099003)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(261022105027099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0sKj+lPdGipp/J8dqodKvdqxPkWbVIK6ZLjfT1RySMonNNfeUECMLuW4SfW2MBEnY3MpjESRPPomf5FjdKuoPtfG9VzlRiYuIyTptFL7QKUbr6FzcycpBC0SO4piC8DYrSYm8j53ABRb8BCansx3OeMRL3y6UZ3sfvCqtNOojTWSZ3M+u3innHQnhOc4KKhBZExKKPvyJvmh8Phqtq5Ko5PDnNDBpSKsGuiSCRbfnlbS6nKNAxiIb8xy0HKRmoDqKaLsFPmD5A1rXOtL+8Skp0I94Pkl/4izH5AYHf2dyT31lHIc/OQ+JaA+Xz44X5M6qcuMEgM6a3aGsyXkYbVlVrqikD3EylLqKwzobH2bHYq99SG7ddFxkzSt82edvU5Oyr+V3VP8SrCNzliU4XGA4mDexyRINCiRj9yl9wP/4/uFmTCF2mroYbG8y3GGXP3X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 09:38:36.5070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11548f30-7fa4-4ec3-4709-08df3b2090e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When initializing the immediate entity fails, amdgpu_vm_init_entities()
destroys that entity which was never set up, and when initializing the
delayed entity fails, it returns without destroying the immediate one.

On navi48, with the allocation of the immediate entity's scheduler list
failing through failslab while opening the render node:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:do_raw_spin_lock+0x7b/0x280
   _raw_spin_lock+0x3c/0x50
   drm_sched_rq_remove_entity+0x90/0x2a0 [gpu_sched]
   drm_sched_entity_kill+0x86/0x5a0 [gpu_sched]
   drm_sched_entity_fini+0x23/0x270 [gpu_sched]
   drm_sched_entity_destroy+0x24/0x30 [gpu_sched]
   amdgpu_vm_init_entities+0xc7/0x100 [amdgpu]
   amdgpu_vm_init+0x5d1/0x1480 [amdgpu]
   amdgpu_driver_open_kms+0x2b1/0xd10 [amdgpu]

Only destroy the immediate entity once it exists and the delayed one
failed.

Fixes: 55bf196f60df ("drm/amdgpu: reset VM when an error is detected")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2ba33212d507..11d8aae223c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -533,12 +533,16 @@ static int amdgpu_vm_init_entities(struct amdgpu_device *adev,
 	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
 				  adev->vm_manager.vm_pte_scheds,
 				  adev->vm_manager.vm_pte_num_scheds, NULL);
+	if (r)
+		return r;
+
+	r = drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_NORMAL,
+				  adev->vm_manager.vm_pte_scheds,
+				  adev->vm_manager.vm_pte_num_scheds, NULL);
 	if (r)
 		goto error;
 
-	return drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_NORMAL,
-				     adev->vm_manager.vm_pte_scheds,
-				     adev->vm_manager.vm_pte_num_scheds, NULL);
+	return 0;
 
 error:
 	drm_sched_entity_destroy(&vm->immediate);
-- 
2.50.1

