Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028B6EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 09:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E57B10E42C;
	Wed, 21 Jun 2023 09:48:08 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0314710E42C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 09:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngdJiWBBBzjx+v1SivsY81NXGeJsRFFJq9Z2790juIWfYRPxMU6q/fEEz2W8QG0RoSBM/f7f/Iz0FTz0IvOBoX3p8iwqbc0K3htQSoIpGLPB20x2jnVb8O450QWHMH5Wy8/39amK+8VWgPg8Ydhh9+NrNccFiZ4lVMh8jiwHR3bxJfcxu8BVO4K/agJ++ZQR9dWX42C1kECFS5eFX0hedLGh5i3SKdjh81TZ0txaK+PCam1GkKwFEeItdjT8/DfPuxR8FVguqOEAtQFb7J9Y9w7LtleQfWW5O/JOTeuV9eJqdbY1Kj41iTxdeDLVpQlPVrnpZPaUiG94c5jnWHqiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGssk6WRBbox7nIzmeskAKdbG0y8IxBkEEQq8xTXfpY=;
 b=QlGLlnltmqGQAEvVC0sicfbGEkfB8VRnxg06T8zvIuqQsFllinpK19uI169fB2N3RkiIQl/rjkhIu9N6IHqVEJqMx7VF73ZcfufDsE2EXmgvftSAzb6JWqN49ijzECQiH9qaB3LMobfXrCI8u6Hv16R9caxhQKap02J/UK+4aZzWHXXoNhlxtg8jgFTwPZdO1hGX3C06kjK0VOABPk3SgG/JC7vjko9D3ftKv2Mv7QkZii+Ajo45ZJhYPJFCkXTjIR48dCVciRF5G4Ou/kzvH2mJx2NPeXnIYNQAKC2rBP54X0x3v9Tz6arAWszFeYJLsbLMjDQ5Y8xU3QLRxQYXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGssk6WRBbox7nIzmeskAKdbG0y8IxBkEEQq8xTXfpY=;
 b=OTyO2IwUOkYzLzhzH5zDqU+L0hqrTHAtCvJ9p3sQ5VuXVkQ1dlJ6vlmVkNKLeo6Aq3jzd6mknva5NLwGwObemUBH7iUDoRfUa0N152NMdVD4UMPixHt0SZpBw4iZ+ByD3g2svGBzPYE16YznkbaZjLNRWdABSy1FZx6xaB8Hox4=
Received: from DM6PR14CA0053.namprd14.prod.outlook.com (2603:10b6:5:18f::30)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 09:48:03 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:18f:cafe::a6) by DM6PR14CA0053.outlook.office365.com
 (2603:10b6:5:18f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Wed, 21 Jun 2023 09:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 09:48:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 04:48:02 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Wed, 21 Jun 2023 04:47:59 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Forbid kfd using cpu to update pt if vm is shared
 with gfx
Date: Wed, 21 Jun 2023 17:46:24 +0800
Message-ID: <20230621094623.1357399-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 6628d923-a4e3-42ec-fc80-08db723c9b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/05n+oksboi5KbQD09N0O8gVqk5UwVhZ4neXkYPZ9PNLnpkpuY/xK6GFk+E3rTcyDisH/jrNxG/4IlTLkFK9vlIRFMM8bqFVw5J9LCzJO2lNjwsBe774TWMbVsU3klTMzaaQOyUpMuhEef59G2SgnnadAH1qm09wr3guSji74qUJOa5g8h0ZABR8lZhWmVPLsBLYu7FEQiCYDdcf0r0cM9/67W9uL+bEy2X/W15tj9Swr+YVroBp/EaYvr/7gTAW8NEFD9+8iRMwcQHMFuY9KyB8YuZrige05o8y9xorLbiZLSs4V3Gt0oeLprWPHwTBS/DmLPV22AevzDH55L1OCzRV6j/C94B8diSG7wlm+temc3J6bfUluTEiNBi+bb7pxul/oISUWNz/Aup+2o/is3tZoyejGSmptGw+YJOsY9SSu4wB1sRBkQ0x6NcOCym+FtiqmTKJU5pGAi5M6VRp8900WRRs+QKjh9/6mKCEjNGXb5we5kCbPsVmyRD0ZLjpPS3MlLade1YP3H37D1ED5BAoKIT6lK6/2d6QUxNwJTiVzwZvgOHjges0RXp/WTZPlbpcB0WZ8JWKtzG1XhF61XtU97z4x2tr5W/uk5EKQGninCqzbt+kRCiLSn5bMTn2M1t/P/mcXkNAaKIee4DifTMW1E2ax0lvKd2DXjj/VbzFeRgjbywVT80gl6qNAjk2leXKpHkkZiNl1PIT0k0xHMrC7d9rxYJJLZpjjyOFPPYKqEz/5eiKNH7FT6x2ZEJcRAZRyEU9n8NwEZwioqLTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(83380400001)(426003)(336012)(2906002)(15650500001)(186003)(47076005)(36860700001)(6916009)(70586007)(6666004)(54906003)(4326008)(316002)(7696005)(70206006)(26005)(5660300002)(478600001)(1076003)(8936002)(41300700001)(8676002)(2616005)(40480700001)(81166007)(356005)(82740400003)(36756003)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 09:48:03.3047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6628d923-a4e3-42ec-fc80-08db723c9b6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>, Xiaogang.Chen@amd.com,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


If a same GPU VM is shared by kfd and graphic operations, we must align
the vm update mode to sdma, or cpu kmap will fail and cause null pointer
issue.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 291977b93b1d..e105ff9e8041 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2239,6 +2239,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
 	bool pte_support_ats = (adev->asic_type == CHIP_RAVEN);
+	struct amdgpu_bo *bo = vm->root.bo;
 	int r;
 
 	r = amdgpu_bo_reserve(vm->root.bo, true);
@@ -2265,6 +2266,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	/* Update VM state */
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_COMPUTE);
+
+	if (bo && !(bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED))
+		vm->use_cpu_for_update = false;
+
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
 			 vm->use_cpu_for_update ? "CPU" : "SDMA");
 	WARN_ONCE((vm->use_cpu_for_update &&
-- 
2.34.1

