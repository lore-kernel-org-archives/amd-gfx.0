Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A22CCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BA310E80A;
	Thu,  6 Nov 2025 06:08:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a3g0oAUZ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57ED710E33D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3d2eIXgCy86lg9pw6RbJKK7XyMZPHA6RyxZa51yp8DdQ9J74Vlu/VZdVJvYSFELLa/PHVcI+GiMS5uRse/zJCLHSoL0/zQWtyKs+nLzO4DKuthNHLgbCYkesvlDAe1SLNHvf+hoR6qrAXZR6aDXalNEfQ0DdFSqmK6oXzFt/p4KM6C5DC0wJu8YtViRMRDFJ95ZwYXdC7Oi3rvAKQ5ZCTuhdhlQN1tEQ+ogUCsCyDaHs77egJ2effYgkYYs2udfKI9O/F9j5qlumq1sm06rGFZqUwXdUvQydZDDMZAF8Iu0RAatEcpFjYbV2KXgWVHyoFaDyE1z3knUmd75xUqWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75EPQJrca93QVJSU9GM3gLMlunZm2RozQEz+SMF8MjU=;
 b=lWdcnvOjVFU2FilE1oFduzbWzjnZ+kIT9wg6pTYmcezEPDtjzXcJFV7HpX8sJNGLrD15nP4QU5vtefNpuE6tw0YMxFvh4THB/aDMh6I/IY20OHHkXQIznum4uq2PnzH9Hkx+5G+tk3j8QQHcThdn1CV5QLftFs2Y4Tnh67+O+MbAh7zjq+9AvPNYdz+IfwL8eBBlcT1E5Q5VC21RjJi970tBLoGfuu7i8RD97ktvt+h4FjyBFX8J/oTzSSxuzwbop4ypsLdu/nZPw5kE/u/SOZfaNA+LsWaB4X82983k/2MjGZZJ0wYN2HyVACix2spwPwz+4GfpIqWbrQVXNpfr/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75EPQJrca93QVJSU9GM3gLMlunZm2RozQEz+SMF8MjU=;
 b=a3g0oAUZTTa8XZjsJdUMHL2vROyfXTCJl4/8OrCBUCvLf36G0WXhUIM5bCXnExb2N/vTSMCn9+oMdZ+zPqfxZPimhBopNfWBd8P6FtYI18bPBfWlKrdIridqFDF2Iaqv7ThUQyHRknlBizPowaSqPuCHVxoS8AzXDxze6KHSyrg=
Received: from SJ0PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:33f::6)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 06:08:20 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::b8) by SJ0PR05CA0031.outlook.office365.com
 (2603:10b6:a03:33f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 06:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:17 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:15 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 07/18] amdkfd: process USERPTR allocation only on the
 primary kfd process
Date: Thu, 6 Nov 2025 14:07:28 +0800
Message-ID: <20251106060739.2281-8-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060739.2281-1-lingshan.zhu@amd.com>
References: <20251106060739.2281-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: b1751140-7671-4fa2-12ce-08de1cfae0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nCNDSm97ALrEhXEczd8oCgXD13p5GiWe7y9O8HBGVC2gRkLLXW8YaJrw6PGp?=
 =?us-ascii?Q?6jD2gTiVnCUTU7enfggUV/SacJXS8UVLaUHrymVbwCyV6DFsaVTKIIbWc8nX?=
 =?us-ascii?Q?752dnl6X62B3zApxgBBPxNiF5I5Mrbk0Ofut0q6fFsZn+hcyxBiLYV1BZdOM?=
 =?us-ascii?Q?TXxyHAuOoWpDSXvKoYQSd4ClnXVRWY5ff9y88q8Cb6/fiW2N9hLHp59TubkB?=
 =?us-ascii?Q?qvVB8g0baO9ol3FbyBF30l8K+re8lskf7rwr88K4l7npkekQayt6Fa5UTtcT?=
 =?us-ascii?Q?bU+6+qFrL76ovL5OWWvmsfUovC6GS5b8sw301P1DnwtF9B2iiyMZRq91ve37?=
 =?us-ascii?Q?zTDSYlR/ZM5kdpXH8CxoeLmzlzgxI6MVWEpe3FzCCTsZbWPzH2ZGyPUjrAEo?=
 =?us-ascii?Q?zT8Yvj30BgPKbVMosuU3rq8m/q+pVrVWG1iPPFnW7eW0OlClFdY+Nlanhv3N?=
 =?us-ascii?Q?vuBxr2XcTFQ9/0Lvsp8y6unEQRxcm/FiM9iY5ypyFzBgVc1iYw7RgwNb0a65?=
 =?us-ascii?Q?8T8nz2u5vTHHNSbjIpCliZ4i0kLrFx6e2hth6xZutXWe7y51z/ysORuAOQYZ?=
 =?us-ascii?Q?uuo6ngdg26vsJRTiECNgYhTHoi4NtZ/t0XaJBFYLIKlFLq3W7Krw8+TkWAcQ?=
 =?us-ascii?Q?gCI2dm1nSMk4bwTkack85/Odw0BNBsD+8u0LQLQ+Kz/ckeVPhwtRcmtxnD+s?=
 =?us-ascii?Q?Pmh10kzS/eUD+rIudUxsMPpEYd/jSIN1w3q5k/12ACrBoAbxfH7gXFAcaxnt?=
 =?us-ascii?Q?qt7QVH0tNBrWGy9t0W6zyLRblEGNi4C8fwYo0AGnsVZ8Xol9HomFkiew2w7r?=
 =?us-ascii?Q?tz8mrsB6rCmI39PS3GTvucJXpz/0E39jf5xMH5UB3hRdxxC8/kJ2qM2A692X?=
 =?us-ascii?Q?LTTVJfHdm8h5s+nMSCM8Ki3NCCT4mK4rt8lbadgij1NA963VK2nxGFeaHtmE?=
 =?us-ascii?Q?5FZUkKD6CEQ6doFKkipeB2158a/Yj91T35JvM5p+IyH1Oxnzkvahs4BDSyTL?=
 =?us-ascii?Q?0aWSnfqiwU0M6FdVzgvjCMj0a0xaJ2wMzKtMCd0wUmWPCx5fs3DyviwaYb6r?=
 =?us-ascii?Q?TB0+pOiBKvvTiCIsngtDTx4XZF0mZB6W0IPK6iK4BAHKlyw7v2cFQOladZSo?=
 =?us-ascii?Q?rZ3xPhwBFmuncAxb0Aa1n3IMeb1PAXHxxMPEBlWgFeWkrAVZSZt7VWl4QfQX?=
 =?us-ascii?Q?IYUNB3etVDabxtnMPljYQ6NMOhrS1x+u4LIz90fkwAQi1ZN4ZpJaT167ktzA?=
 =?us-ascii?Q?ZwhMqZKbNddshPgg+9MrIYp7QS/pKKIf+eFQ/VA3mrMZf46kZmKsxmgAqppx?=
 =?us-ascii?Q?U/LPM0bbMELxeK5GlUTFxXFogrwvMDkfCDhVPD7tPhMJ9OlSxFx130nCnrYR?=
 =?us-ascii?Q?Pjf5wAC0uhE2gynYP5t6Vce09ANX7zjKqZd8HUwAA3bAa4VpooFmR2RXb8rC?=
 =?us-ascii?Q?it0ZYtAIcm9hGYOH/iMH/fhJeXtdX0SGKb7YN6B6fuYUlPWF2wVUOkE3tB6b?=
 =?us-ascii?Q?RAZAIjakNKRMNGPmOlmwq9k4pC/4f59jmTmDrUr0NzZ90m90EaVh+FwPS0mf?=
 =?us-ascii?Q?QhNJHPNpm2j9TkALing=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:17.1188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1751140-7671-4fa2-12ce-08de1cfae0d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553
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

The lifecycle of the primary kfd process is tied to
the user space program, all secondary kfd process
would be destroyed when fd close. Thus only the primary
kfd process should process USERPTR memory allocation.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 58d90bebdff7..d1cb22f48b00 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1062,6 +1062,12 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	if (args->size == 0)
 		return -EINVAL;
 
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY && (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
+		pr_debug("USERPTR is not supported on non-primary kfd_process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 	/* Flush pending deferred work to avoid racing with deferred actions
 	 * from previous memory map changes (e.g. munmap).
-- 
2.51.0

