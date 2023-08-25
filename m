Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5273C6FA8F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 00:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE1810E5B1;
	Fri, 25 Aug 2023 00:34:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7451710E5B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 00:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpBf+5o3MYUPX/APDzzwgGPIjH36FFsNEYpJ3paXm1TeZtI2Cnx0Z6VZwBLbi7EPznPpZsD6L+FuPyXVR1krAMVvLFUbIue+IaPnL4soqzT1bNPU5CiQiO2fsifJsdE/vjhWSqPDpYQWfYXfiRQBHEflXUAHSLvctHXwApkpmXiu1l9XdpExddwkrbV8qqn6UISufTJspSbp0H0/1ADUsZCow+kvlxU4F3ESOPXEzGFQSiqAKkeVKgL9HFr5kJcWdG7Kmn4gTtf0lvxZ8diGGDKemAOIsEHfB+h5+kVv/4zoHJb6UYsxr73hmxI2GLWXs+wuF0knTKTNbDXmjASdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJvQp5+bPicg1ii263ucJ6Uu339gRJNBN1Yn8fH8v0s=;
 b=ZOzhgxaizMBDRRF9NjAb1txxj/etTZf1iThuN9AuWgiu0owBW3zFgWixZ+etualn680GjSurrGQq3MDdrefKQ+oGGUgA9YOqkS+ft6ILEtevtdmcgqkcsrLQJ+4rBIerQPXvfgHU2rvl0ph/N7Cd6u7ZcmL+RNb0kVOBAKYb0PYTeK8SWG3h5y579VDFlUus0+eXvZw/r9ZOqwhuvIvY+9wQyiZfj5/FVVUBX2FvwbzVcW5A3Her0E3gs2+WnUwaz3i8M86/5vX11gQLTA6Xi9HJXZhrnpkuQChdCG/6p4tqMTg2I+UL9o+8xvXsHfwCcyqoPig2+JqcU5yDUtFyXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJvQp5+bPicg1ii263ucJ6Uu339gRJNBN1Yn8fH8v0s=;
 b=bJeL+8Utc9f2AwKXV5P/2NLM4tECnO3Yz6fyG+waCTZZeB19YewmvLTWoiX4rksA1Ht0EoW2606rio0/RDgGxmWT0A5dGmO4SsbuPX9R1SKMMknrmV4m6uG7FT4DDUU6UU3hGZ2PXcB3d7zMfKbY+UxDrY7D3PyFI/yIn5eh1Zc=
Received: from SN7PR04CA0213.namprd04.prod.outlook.com (2603:10b6:806:127::8)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 00:34:30 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::5f) by SN7PR04CA0213.outlook.office365.com
 (2603:10b6:806:127::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Fri, 25 Aug 2023 00:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 00:34:29 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 19:34:27 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/2] drm/amdgpu: change page_table_base_addr caculation in
 mes queue property
Date: Fri, 25 Aug 2023 08:33:47 +0800
Message-ID: <20230825003348.3978418-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d5caac-b7cd-4177-a383-08dba5030b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGGjAEq2NaAT+YWhF71btI6kuI85unDI7KX4/6TxnHlczPW6hhVZSN0HpEqPoVv+7Bive9Ash/Pw8QTbiyZZ6ohXwJbIDjkPS22ZbB51jwEHsFoXQFlSZ0PKEC95Mb9PV8OwUnHEvQ1oddqonIvPD847vNyNbj2P2vNDnwWfFxzGP2d3TzsEoYY76tBa+dW+8i0Y6+vVPYUq/p6a8CUC6V5v0BQ1xntylth15VWeLxLS4kTlMaseSzLvnx55cZGhYiF4I53BJ5YGh6sUwJm3v57M3b1aMRNCOO9R+25DNpaq2kBzLjgYCwpQBMsFtIFktQJi4Gyt65Dz84cBOAQQUINPqun6Z/2ThAZP3HdkwkILXnItE/nCWst8M3jkhrtHUofLO7gtTPabw1P7oBDGXuzA7zqFaO3I0Eu30QGmNHdvNSQOVNuZmlQ6yVqa0pe2ssbk9EderfR05N+7tophFO8gPxEM1z0O1kTkayRgcIFaImyPb3l8sl0MzKVoUZOlTElYp+h6Kz4FRlB6+VGC3JZWx7EwpWVJIY8fbINFTy7ncDwFS8wE3f4NAaC8EAJg87HjmBgnocQeD5ua0Kbsr2BuD3sTt2VEJnLI3byAuEK9R5+HtF/NPKBu9PeDwk01OIi+R6HtX8u1oTRtZZNXAzdlANLHdUUkdUDFYL9fTXCAQVmIgWuVOfred+Wa0q7esi+8ElZDGukmI4zswXnoFn5iHRNwBQ/PKePHmBLdWNDJ3pe/mVjx+8vWHsZF1d3tlF9FVgrOO7M2V5x58XmhAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(36840700001)(46966006)(82740400003)(81166007)(356005)(40460700003)(8676002)(4326008)(8936002)(54906003)(41300700001)(7696005)(316002)(6666004)(36756003)(6916009)(70586007)(70206006)(86362001)(40480700001)(47076005)(26005)(478600001)(16526019)(336012)(1076003)(36860700001)(83380400001)(2906002)(2616005)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 00:34:29.7717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d5caac-b7cd-4177-a383-08dba5030b6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

current method doesn't work for GTT domain page table, change
it to support both VRAM and GTT domain.

v2: rename member for pde (Christian)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 10ce5557bb11..06a178dde38c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -259,7 +259,7 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 	process->vm = vm;
 	process->pasid = pasid;
 	process->process_quantum = adev->mes.default_process_quantum;
-	process->pd_gpu_addr = amdgpu_bo_gpu_offset(vm->root.bo);
+	process->root_pde = amdgpu_gmc_pd_addr(vm->root.bo);
 
 	amdgpu_mes_unlock(&adev->mes);
 	return 0;
@@ -621,9 +621,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	/* add hw queue to mes */
 	queue_input.process_id = gang->process->pasid;
 
-	queue_input.page_table_base_addr =
-		adev->vm_manager.vram_base_offset + gang->process->pd_gpu_addr -
-		adev->gmc.vram_start;
+	queue_input.page_table_base_addr =gang->process->root_pde;
 
 	queue_input.process_va_start = 0;
 	queue_input.process_va_end =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index a27b424ffe00..01ecbfd57ba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -140,7 +140,7 @@ struct amdgpu_mes {
 struct amdgpu_mes_process {
 	int			pasid;
 	struct			amdgpu_vm *vm;
-	uint64_t		pd_gpu_addr;
+	uint64_t		root_pde;
 	struct amdgpu_bo 	*proc_ctx_bo;
 	uint64_t 		proc_ctx_gpu_addr;
 	void 			*proc_ctx_cpu_ptr;
-- 
2.37.3

