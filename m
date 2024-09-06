Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9138FCE7AB8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 08:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3960A10E998;
	Fri,  6 Sep 2024 08:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IMKIp7+4";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3248410E998
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 08:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VX3c3xiHZpmrTv0PZ4zxadY5K+m0L8K/MMrdhJuCevLSXzKihZ8HHGMqgizavqH0Q7SkEy3rXsyBM1EQknnouC/aNgIrAoIM9KjNkmrXgzIrU0fw9QKz/jR+YJ/8X2eQh76QiSyXaeB8yNyGRa0vBTeYCChHI8pMug2MXFn6tJXGMjMDPUUUu1QtUdZt/7rAJEnH3YMnvj0bORFkCpjUpI8l8CdPD0PxJMSvUPte05em+e+a6GeXjAp445+3t/17IEpTfJjz8Wyr3TvzrQPve/fJwaRgNGnosBgothNpl2Hz4RlScImtDy9jyr4Byq+EShkiTXVjoQeIg3f8gP1uCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B+LfOW4SVjV/Xcq7+WZB8AfxqXEH2Kgc72/YQ63n6o=;
 b=Xkyd5TORHuGFQg1hUJBiUF+0uAQcjJ0+obXQ2AKc7USR9i6NLVo87flVGfUfpZYR7MWy87JAakfnqTq7O0x/WIyl6nMaAGxlPSakTTDUa0ciI1Xl4j+D6npejYjMfLUHDtRJnvtVN9DZuARK2ylFaU8SKl1u/Kb+mnEPs+s99VRkpR+5NFCoAtULn47ihJbko8Bgz5duWHCeEUCdJWPHrEUszyf6nQ0bWySsh5DwKRCzaottRKcIXs5t4g+h47zdIHmSWZ271q0ec8n5KaS3gTLtkVPRV1qIukzdRCw7A6EQiFU5qLR0iD8v/glMUp2jZ1BWAxfukWKW0BBXrZ6vxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B+LfOW4SVjV/Xcq7+WZB8AfxqXEH2Kgc72/YQ63n6o=;
 b=IMKIp7+4NY0+bMhsULZp26kW0ZPHYUDWWgKCN6Ne1x8CkrfeSnVO8DG3n6mJjMar+jUr3hJhdOzUyQH0PsRkWD5xqFKVIxkIPsziVv0E55XLeKn180omJMsCVm3aJlBT2n0v4eiIReaEp9X1wlrvLGgas4w75N3aTADbGnrE4pw=
Received: from BN0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:e7::29)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 08:12:56 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::26) by BN0PR03CA0054.outlook.office365.com
 (2603:10b6:408:e7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Fri, 6 Sep 2024 08:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 08:12:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 03:12:54 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.39 via Frontend Transport; Fri, 6 Sep 2024 03:12:53 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: Select reset method for poison handling
Date: Fri, 6 Sep 2024 16:12:51 +0800
Message-ID: <20240906081251.31139-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c868456-be21-4edc-ff2c-08dcce4bb62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KXrAXXR9XWbEhkO+YK246lv7L3eZrfK8EbMAgAFJbA1PgsB2ZzU9WhG1xCq3?=
 =?us-ascii?Q?cQBofwLzwi5SuuGGY759loxERam/ikxJqO+Usbbv9y6lvpRs5DbPyBgfX9lF?=
 =?us-ascii?Q?+vxRkWYfAUN3uAhk6oES87uoHkZzx4QTrCts/OuTXNFQqMkiAOKOql6VLEEL?=
 =?us-ascii?Q?zN3WafLwHagBtg8SDTeuWaTqJg/i/sEUZsFYqGiubciqU3ObD2QTsdwfK5LG?=
 =?us-ascii?Q?QAkKK2Yr2axebh9BGLyFCQvBoF7bJSeQupzb9X2x+KejhxAWNzRq+364eeZU?=
 =?us-ascii?Q?4ZqArrJD28LPSyHnXwF82p06b9I4MuPMWLNnWikT5fKOfoIL7MLw36WMmggn?=
 =?us-ascii?Q?TKT32M/WgU0X/6UVT2meK/GWJV8kuUxImbFO78WfbMW+exSgzuznKvLEHspy?=
 =?us-ascii?Q?TWDiEusBwWg8TgRDE9J6J/XarX6YjcUoYMwDPrSp8fER90uqAgfEn1ZerQSU?=
 =?us-ascii?Q?D1DEPm/hhVCc3WHB7tQjn77u/00+UJ19Q6qOzqQg/7NsP4LZTQeTcvAYmRPS?=
 =?us-ascii?Q?T+0GC2N40fbfhCxd9qpy1288prCOu9Kh0OiCouW8q6veiGHgTx0/stlWlBGM?=
 =?us-ascii?Q?nEXFC2y/27aR1a6genLJ0lSh3AC6VrQAgcmtPcxbL7sfxPr2KF2CjZq/csL8?=
 =?us-ascii?Q?05TLCEZJqP7U+vHcD/Y8j7HG+AxYCFF0vqVFYHxgj8JjTlqzAJfljc88ZKPp?=
 =?us-ascii?Q?lB5rTz6oiJNdElUDjcAcXMfftDcsb75Gi2jgNBKRfclSBrnkytZxTPHW6zL8?=
 =?us-ascii?Q?LPxeoq/K5dkR/iXhRpWSj3cLS8G7X4EBJaDi3zJiJNEV+NU1JY+PJUh3ulzu?=
 =?us-ascii?Q?J2xUGiucOdDZ/RZLtlP9xiABc4lomqUFUALlcuJFp0svW/JgmJArxG74xmMK?=
 =?us-ascii?Q?4IeM4BVkTExWuruvTik+8G84ozhZrgvzPGgr1IqEz9RPFCBQ2UCCU8KX29km?=
 =?us-ascii?Q?9qTgdJPYxOLL65SjIzQLUWc5Rnc/+Z5JqxdVj2p4ph+pHf5EOjtug2l13T3O?=
 =?us-ascii?Q?7aYM9lCJ1MVXSFt6P5FJfXgPSN26L6oeBAj5IZC0F20kbpbwPYhRmirKGQPS?=
 =?us-ascii?Q?dzeCJTpq6OPc1EZcr2HqovvpG8tITNuvfkSluMNBmniqVcP+NyX+gOI5Dz/n?=
 =?us-ascii?Q?kXfASo0eOVlyMv45H2gtrF4KblIQdQrUoXl0uX08kzsVmmdvAY1sQjxndpgo?=
 =?us-ascii?Q?+yz4MjDKSS6j/HlBSxgdA92blGdeW7sravraL4Hr2My3EQpfQ88kW4zkEaJ6?=
 =?us-ascii?Q?mOGavXhKX4+yQpYoFifWdyHfFn3uc+E2qg8I+mQXJOYSk/1c6qbAY60ddDKo?=
 =?us-ascii?Q?TtW2KjjEqZhB+mOo26iAtaIU+9kjKv7w1e+rQNz4npwA43O/jE/U2io2CDLn?=
 =?us-ascii?Q?YCJYF7SO79yeG07jZ5sEw25c60vmJS+DlF1NFg/7YTuI5+fA1rEIvqX5q7gP?=
 =?us-ascii?Q?5Mrgf0siafZIdRUEZwZBaFB6XgMYjay+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 08:12:55.3388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c868456-be21-4edc-ff2c-08dcce4bb62e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
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

Driver mode-2 is only supported by relative new
smc firmware.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 40 +++++++++++++++----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index fecdbbab9894..d46a13156ee9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -167,11 +167,23 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SE3SH:
 	case SOC15_IH_CLIENTID_UTCL2:
 		block = AMDGPU_RAS_BLOCK__GFX;
-		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-			amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
-			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
-		else
+		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) {
+			/* driver mode-2 for gfx poison is only supported by
+			 * pmfw 0x00557300 and onwards */
+			if (dev->adev->pm.fw_version < 0x00557300)
+				reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+			else
+				reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		} else if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) {
+			/* driver mode-2 for gfx poison is only supported by
+			 * pmfw 0x05550C00 and onwards */
+			if (dev->adev->pm.fw_version < 0x05550C00)
+				reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+			else
+				reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		} else {
 			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		}
 		break;
 	case SOC15_IH_CLIENTID_VMC:
 	case SOC15_IH_CLIENTID_VMC1:
@@ -184,11 +196,23 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SDMA3:
 	case SOC15_IH_CLIENTID_SDMA4:
 		block = AMDGPU_RAS_BLOCK__SDMA;
-		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-			amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
-			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
-		else
+		if (amdgpu_ip_version(dev->adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 2)) {
+			/* driver mode-2 for gfx poison is only supported by
+			 * pmfw 0x00557300 and onwards */
+			if (dev->adev->pm.fw_version < 0x00557300)
+				reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+			else
+				reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		} else if (amdgpu_ip_version(dev->adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 5)) {
+			/* driver mode-2 for gfx poison is only supported by
+			 * pmfw 0x05550C00 and onwards */
+			if (dev->adev->pm.fw_version < 0x05550C00)
+				reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+			else
+				reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		} else {
 			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		}
 		break;
 	default:
 		dev_warn(dev->adev->dev,
-- 
2.17.1

