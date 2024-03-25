Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4D6C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 05:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB9610E512;
	Mon, 25 Mar 2024 05:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FRVOF4T/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 003CC10E512
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 05:36:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIgvR64cQf2sZu8GHp8t9dlhaZ8jYEEhM2EXU8c0I6yhgN5tGLVCSGRAMHAV8N7h6N4nHoqda4yChlRVjuPdhUj+0WDBp//oTlAyb7k7r0gNkQeaLABT7vJGc1N15BBu8k3NzBoQAjjuvrVpyhsm+joNUoWndBgNrIbUuA2Or5BJ18lEpj8JAflMG9O3IHzQv05p31uTRO84ndo01QdsKWfNpA8q0M4aP5Z942NML07qXLt8r/+VPkQl8NgnY0MLfUf+kXkrYbXum6t2Y196ZnVWCSJVOYTIXeSCDg/klWLNR3DtkAINGauFnTkxAyD6VLEp+hMmsaLPKbyXw7bqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZQOR9/oVSaRc3a/dn5IdZa7PoheAHfooHCThTzczcI=;
 b=jXshWYZx4sIzhKA//MR4hWsLM/GP4nFWTXgDQngH2/5f93tgWZ9YZ2zVTPiKUv2uUfzg+5akQeDOzJQyzIGvaj4i0YEAt9B8cAqXrmsrpHAX1RZ3X+Dz4oJ68DXF0CRGe03x9MJPFZ/MWj2xHfTJMDSwa/ZX6zSYqa9dYUT0yn7IeiMdUvWfFqGFwHdlKbUpkbtUu3SiFPWc7dBIgI4SssDeR0LGwuYbHywOGUwnvaE8+zpS1M5P4L7H5D1rNqt9bbL23gXxEOqYdRh4OrymlGvkROYJFQvz3t4P7RnUZRy5u8sFCH8DUNV3kvQsXs5eS9X+JV0BlM6nE3gh2wIqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZQOR9/oVSaRc3a/dn5IdZa7PoheAHfooHCThTzczcI=;
 b=FRVOF4T/2ExTrBvzKtFHvz5xWerAZeNRXXyFfktrOOgO9dgaTVaHZHZEZxr9RKN1VMMS8GHyBhTtBdU9YRzoSo4jkpLJFp01fgLsUupyINaBhjNaqVDt88JUF69pCqYRvdmg4xfMGUnbuwGRU6PokxTwyCQibbnm1AMwj3rGmJA=
Received: from BN8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:ac::24)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Mon, 25 Mar
 2024 05:36:13 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::a8) by BN8PR07CA0011.outlook.office365.com
 (2603:10b6:408:ac::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 05:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 05:36:12 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 00:36:10 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: use CPU to update VM during GPU reset
Date: Mon, 25 Mar 2024 13:35:58 +0800
Message-ID: <20240325053558.3183164-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 75fd9045-3de2-48fe-259f-08dc4c8d7b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pn6ntyS1q6IOGgtXJxa0lE7JYYRsYhfynXyYPT9hKt52sI6ai6ED+0XMBKOBrP4I9Ie9DAGZoNm6aIDmPTrXz4WzsIj5uF2GK3ADIxXQ2HZ15Trv8N0GHBzD01rXozcsGK7HGl9Fd6RzoorTYCgx8WgoPdxIQA59Vk963kidKtwn2WpQAkK8G/4fBJFLazqAi8YoGmra4btpBU5qaE2z1EISaCfbtCVSGgrCe8LSnkv6AKJtDsZcK4qK/bAYG+vpGnwnsLtDba5AcOjK8plRFF/g20uujUb1fnyZ2aS0HTGDcMPp5aIUVBbr7942rBEdVVH0kEHW+sSEmnh4Ty7wfcAyqDPqR/VnWVF7SU4IpBgwQPezrKCGzFbdyrqascGNbHsLqx8YhIPqNklSthYqiE4ivxdjxUnADvym2OZdl2+O9cOL6N45T9pqf4w95/SAUKGsF0Ev+/yQdVyNv6VsQ7M28IyUBDUj7bb8WmLeKavrZvGD8TUFu0rV0/GCaT9FfBMa+0vTExdMNmpkJFmqu0hysWXvNhyxTiN6noca8GXKPtTDQFYiXE33pSq+9vwoglv0ce9EKD5ivN5+x2Q27XEWKU++SBY8z1DWwjnOzAGeB633wXbRw1q7/ff9ld/dtL2ElLlyCggJxfzcLMTAX5CkGgegVSp2e/eEDATqxVb5sc/dOYHxq5FUGIrsV7lI2h3gbi+yPYDLSFCD7rhcaFb8OrvYOsh7h3kBB446Kb0KCLfskWvwj8SFgzKllQNa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 05:36:12.7360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fd9045-3de2-48fe-259f-08dc4c8d7b9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
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

drm sched is stopped and SDMA mode is not available,
while CPU mode worked well in such a case.

Use case,
amdgpu_do_asic_reset
amdgpu_device_ip_late_init
umsch_mm_late_init
umsch_mm_test
amdgpu_vm_init

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8af3f0fd3073..af53f9cfcc40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2404,8 +2404,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	vm->is_compute_context = false;
 
-	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
-				    AMDGPU_VM_USE_CPU_FOR_GFX);
+	vm->use_cpu_for_update = !!(amdgpu_in_reset(adev) ||
+		adev->vm_manager.vm_update_mode & AMDGPU_VM_USE_CPU_FOR_GFX);
 
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
 			 vm->use_cpu_for_update ? "CPU" : "SDMA");
-- 
2.25.1

