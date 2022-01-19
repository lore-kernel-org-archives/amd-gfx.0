Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA01DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 03:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592D610E402;
	Wed, 19 Jan 2022 03:16:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F1C410E364
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 03:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkJqpmm15QZh4X2z+eORwoF38iPZ03i01haurxpKpJBKez8ZRoJlsO6ZndTabaw1B/jXHaAFtYB/FWI0eH3Xt7NGTXkxuwVmK6dKf4Z5AHeOTCOyEAIgGsXtaA211jvCBDs/DPYmft631469D6tvR13I6FDUdtBkjI0y2Xf4S6ngFcxggQLaoL6wJnZbpFSttpduQ4ZdFu8nAzlAjogx0IQZbNPlmQT8PL3+jSWQMDFwSu84aVZQI9M/QQg/ql36oFA3fJVg/0A8ATofP1aQJCMbpUtWOXP1Dr978CdOj6BgJtTMsgIbY1sa/LLNQEs8YttDoy+z/TLEtukdOEzA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFkIoUuGF3EjpPXOZVFl+VpAyBuQWTRClFUgHrW0zbg=;
 b=KvLGtp79qxw5aU4MBoK12ICSFPUnNKD69EtGyJ2EzmSK8CvtanJ3fc9Jc5HjN4xKYWUiPcOWAgxu5o6YJK1fkCbJk/JMUCwApY/8bovaMlMBNnfkvK/OJI6NJVpyPcCdVDsrIzBwt0h5BBk42nnK8D1Q090myEP7ypmU34qbTztMp+R5U+oaM0w+fey5C5PsnEGgxzHc5wx6YAkx7/5t37eWv2qWXwGmgQH9XwGPqzrz9kNcpel+ksMDUZe4q1dG9qQebD57kXoVZP26zCsHfD43GtuGQLKcVERM6nAAKCSn2DW3ZMoElTDNDZ0XC8rppw7gXFhxcMm4Y6bXNBuQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFkIoUuGF3EjpPXOZVFl+VpAyBuQWTRClFUgHrW0zbg=;
 b=TfW/50iA16QDpfvL+jX1os+Fr2fbqMMHF6coMnqeKLlSlFMLqZKsQb8oo7cf8J7sgsj4B9/L1KY0hFBVLAzmb5zoYNHYl3Y7RNlG3/SIwzc9iKtezptITnoxw4rQyoEDfC5IrU8pPOKWLSQ4URdZzRjs2+l1N9Mxr9Glg7t1m+M=
Received: from BN9PR03CA0321.namprd03.prod.outlook.com (2603:10b6:408:112::26)
 by MWHPR12MB1374.namprd12.prod.outlook.com (2603:10b6:300:12::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 03:16:25 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::4a) by BN9PR03CA0321.outlook.office365.com
 (2603:10b6:408:112::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Wed, 19 Jan 2022 03:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 03:16:24 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 21:16:22 -0600
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: force using sdma to update vm page table when
 mmio is blocked
Date: Wed, 19 Jan 2022 11:16:10 +0800
Message-ID: <20220119031610.832211-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6becdabc-501c-4433-bbc0-08d9dafa1345
X-MS-TrafficTypeDiagnostic: MWHPR12MB1374:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1374606118512AC299FCFAB082599@MWHPR12MB1374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rCTA2JQvD+NgxnGtvPGA9MeAZaQaxxirNg0ILnPT2G/86dvlpq4lzMkdjP6eNZr+ncjWl5401Ig2QvTBaBpcZ0gmK33T6l7z98Jc8Ygx7cQQO+FIqH31GDG7BU0I2IG5KI/ldExyjkPQXeK/eVDLd9mdLIwXogBeCZVhtYM5QkKZqFtBomnehJq2aowKWesaV481CmEM8ZD9t2sWoKZa6Axhr9l2kFdjGNG0Ggdj3kf/6vcXdzLY00NC4lI5y1yLhs6snUGJWvgF0bbdMgLkWqIM+VaZ+XatZQaqP/IB2CzfnYpWLlp1Ba2v6A3qsOEO3VqjKOHdk1Imt113ZZpCya00HG9G/sV2LhbBknbXat/cajm6wdVRQi+88Snz8tNDRX1WyLaT3Hu6Ke6UfJzl1olWNbcSgg3klzMFdZjta7aKoBaiLw9YSbH1NPJeqHFpx2rCArcA515lyWTgv3GPiyaH4alvoOmXQ2BKhZcxzBgW2+m5xOk4ojLPueZ9znhzm4Cs5CiTvVhjdXRmJdxc2djNYmHb489uC0wFbdOvklw6FKQdxjwrbwlRrvqG5iMJoL9fRLJYCwC41vZqnYn3Ovk6I63bNKAYl3PddCiqpCKHymjUyaJJO740TxUrMkO0wdF5m5J8WrKEtRzyHApM5cvC2YYoQNCs8zAT3PtrYPtTVQKpDze/uh0qTwf8KPwclAtrc3xbcQx2TuvM0yW/UFk4IeJ3KeJtO8oaOJ/2A1r9SQDcMd28UPR2NubYSLS5fz9vGsm4/XZsGCtoPJuKFSAMiCEBvm4zQ1VOU3s+ng0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(5660300002)(508600001)(16526019)(316002)(54906003)(7696005)(15650500001)(8676002)(426003)(2616005)(2906002)(186003)(1076003)(70206006)(70586007)(36860700001)(8936002)(336012)(6916009)(6666004)(81166007)(47076005)(83380400001)(26005)(40460700001)(82310400004)(36756003)(356005)(86362001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 03:16:24.9339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6becdabc-501c-4433-bbc0-08d9dafa1345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1374
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
Cc: horace.chen@amd.com, Frank.Min@amd.com, Yang Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

when mmio protection feature is enabled in hypervisor,
it will cause guest OS can't R/W HDP regiters,
and using cpu to update page table is not working well.

force using sdma to update page table when mmio is blocked.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b23cb463b106..0f86f0b2e183 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2959,6 +2959,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
 
+	if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && amdgpu_virt_mmio_blocked(adev))
+		vm->use_cpu_for_update = false;
+
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
 			 vm->use_cpu_for_update ? "CPU" : "SDMA");
 	WARN_ONCE((vm->use_cpu_for_update &&
@@ -3094,6 +3097,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	/* Update VM state */
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_COMPUTE);
+
+	if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && amdgpu_virt_mmio_blocked(adev))
+		vm->use_cpu_for_update = false;
+
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
 			 vm->use_cpu_for_update ? "CPU" : "SDMA");
 	WARN_ONCE((vm->use_cpu_for_update &&
-- 
2.25.1

