Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0731FC54EBD
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 00:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87EB910E0F6;
	Tue, 10 Jan 2023 00:01:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14AC10E0F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 00:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnzeU/2h7AtcuoDq19Ornvz4c2HbnJ9lCJPgSdtL/eH6rCliCXLwqdXspykIiEwGeaC0rsPIWDZM9tKmMZql5mbesHdCRcOHXSY38Xl2GoX3j1NANzzyxCURcHGCdUjLWSsRpNBbGOibptQTAq2AmwT2Te6/Y6FI+L8LHpZuI47U0Z82kdyYf2hV1qs97cNXdkLJbIa7Uaw+gPaLUR6+SMQm2sfm6G+4cdZCV+s+aFjXSq02sve35u6tkVIO7fJ5LG+G83J0LfQMBjU3EJ0Ia2oJJvDTXwbGWxKJi3MVRrDx3EjWBVxq4SYXHDBAj1kmGwuJtuLMUy4fGipc+FNbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0auookZf22b+U4wfrf611UeIt+UKDWTt9VQp66Vn2Q=;
 b=RvVT42YJiWjKndwXfwIEfmClRWj5NFY1Vu1AW0kS0FIZZhrQ/X2F5dTSafgv9eB2l/3Pegx2kd09qecaNO4KpNggnkWNIhfIPsD6ktQIT8SHJIfQLpigyGMG/KWTHSp/naa3qoCdwuKh5KtLWKV0lbgLP1GHvHf4YyR8YSFd1iE3dpn4rhvJdEOSNHVkgjQxa+SQuiILe9wL65cdmTBS69NlFBKOPPFjmsqleAeTL1h1xHllB5mu+OdvKAGr8GUEZf3BB1FjYsvSJY8U9Sdqk8/eX2JmOKVtple2otJqt64zKBW/ZVQhraWtwIbBahCmS//jknrEqU72K07p8dxMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0auookZf22b+U4wfrf611UeIt+UKDWTt9VQp66Vn2Q=;
 b=uZaQGYYz+v9ytwV9MJLe+ETcphGHh/wZ8M9CUZ8ETexyR2cLI+n7ak3UDxwOBXpFxfR8QBvuJzk3+oxUbk92lBfq8XSux1l2iSkkY08xbWJwDwGZlmLUw3uKzeB1TgasFl3Xl7eSo/rjNH6HSSDAEUlfwFuGWe+bAxD6xQUR08M=
Received: from CY5PR16CA0003.namprd16.prod.outlook.com (2603:10b6:930:10::7)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 00:01:52 +0000
Received: from CY4PEPF0000C97A.namprd02.prod.outlook.com
 (2603:10b6:930:10:cafe::4b) by CY5PR16CA0003.outlook.office365.com
 (2603:10b6:930:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 00:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97A.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Tue, 10 Jan 2023 00:01:51 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 18:01:50 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Page aligned VRAM reserve size
Date: Mon, 9 Jan 2023 19:01:12 -0500
Message-ID: <20230110000112.29730-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97A:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 9948102d-3ecb-4938-03e9-08daf29de092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhQ61XW2zQW84rWVqNMVdOoKtL5CPhg94zVOSI5qETW62cZCXaKHilr6YPpsKCt8VUfU03d3rWunkRj9reoHzS8o8drqHhjq0tDiJD6oBYRzkxa8+vQxmgjxBbd5QI5JEKW8RjSc0KnspiYQD7Pxe61qwj7+lMUNO09pIUE1zi7ew93jjQ3kUZkVQy4Vmwn5LokYLeG57SAGPLu2GwmVMmViCOLJsWorhF2+n3TZojAIgFcn3DvM5H/SS2vzQQy5A8bA6kx9Fq/CmV4485xbc8IPSOlc4Vy1Yag/9YY04xS31C0rzJdpeAzEl80K+MUbaLifvykzLw6TztSIKSro0Uxc1tGs7FJKQC6p2Sr9sM+/Z++hg8fxLs2cnCBVccbtNbeaDkmaII1SZfHzwzvnZ4jmBlYNPlJZF7Oyv0uP75zvFvOAOD1q51GsUZpDjyV0Bfd/t8wmeDkdjYivark1S/9QeWAhKJKu4Affc5CogVtsOIVLQN2hugFJFtUn91/o6hIdMLd+14nfCCtTi4VyNAVeo1Vp/mIxmYuKaCdwRQQdbfnBOcEbOAaXcErtTxgHQImF9bQwf2PYG60flRHi1Y3XH2J8iBWXSQ/ojLM1F6IzC3eYh5iYLYrKYPU87Ala9P19yYqMLOxFdBFs5WkyHbHwIPgrPxv95Ck9i2ERQRAAzJOEppef/oin5ykKHVEukBmZCxUhoO2oL+rBiFFhecbEn3916A9tnukR3dvTriM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(186003)(8936002)(26005)(6666004)(2616005)(1076003)(81166007)(54906003)(16526019)(7696005)(5660300002)(40480700001)(6916009)(4326008)(316002)(40460700003)(356005)(86362001)(82740400003)(478600001)(41300700001)(70206006)(8676002)(70586007)(82310400005)(47076005)(83380400001)(2906002)(426003)(336012)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 00:01:51.6705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9948102d-3ecb-4938-03e9-08daf29de092
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use page aligned size to reserve VRAM usage because page aligned TTM BO
size is used to unreserve VRAM usage, otherwise this cause vram_used
accounting unbalanced.

Change vram_used definition type to int64_t to be able to trigger
WARN_ONCE(adev && adev->kfd.vram_used < 0, "..."), to help debug the
accouting issue with warning and backtrace.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index fb41869e357a..333780491867 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -97,7 +97,7 @@ struct amdgpu_amdkfd_fence {
 
 struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
-	uint64_t vram_used;
+	int64_t vram_used;
 	uint64_t vram_used_aligned;
 	bool init_complete;
 	struct work_struct reset_work;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2a118669d0e3..f23d94e57762 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -151,7 +151,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		 * to avoid fragmentation caused by 4K allocations in the tail
 		 * 2M BO chunk.
 		 */
-		vram_needed = size;
+		vram_needed = PAGE_ALIGN(size);
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		system_mem_needed = size;
 	} else if (!(alloc_flag &
-- 
2.35.1

