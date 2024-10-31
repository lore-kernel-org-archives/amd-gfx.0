Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942BDE68974
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 10:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF8110E28C;
	Thu, 31 Oct 2024 10:47:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FSV7P+l4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D90B10E28C
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 10:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e08zzw2497ozjHz67VWZGReMKLzqKMD797r+bic/1u3qSTgbJaKmAX3EKicYibYcDmBbgECTxOnPeMxjPF621tl5YmYmd9iXEzMs4Jl/DBL6bF2Ro9/EKr2SNxT70hFjizR6AQARoX3PMyrR/MDIup6kITCo4MzMcRZCXDSf9+12BZrFRsY136YZin2P8TrbgpU/uUW9egrdjPKeDnfxrJszKshBbXZTolpeZmYbFmKO5QK6wRLuwRX03BC1wPPP8E1hEDmTYPxN+TKGIH+knbWfvMfK8+8ObjgnAM1pC0cGEX864hbvJSLMWVDEtkNw7XTtxSfWN2cqQtYFTW+xHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaV/3Ot1SvoUD8aFW+07sYo+HKJ/r2y2EcpDWlJd6t4=;
 b=dvqHe9t0Vqga8PDjomNTjNlf0qabSnmnABZMDU8GF8cvUx/7Yeo/9/1B8etpv4zTgT3Nxnq+e/B/2OOaL1gLbHQLhP6i+7C3VclelkwCATgnFUhXfRgdUU27C7317AezmKlrltHimK3beFX7nutJ0zClTTLCVGQ/BmlOh6mJn9upqsAzeEx9o0KpWbxQHlEU3ZfXeF91rCUC11c2q1dG1WSYegLC61CEKjXr12LWQaG+0LlT3dSLVbjEVHBjzwLUthH+ynC9XYwWwDca1jacX5vqmop0TZygoj/F/vVdA3XyPSM7EBqCLCMXTUCYVjPVUfXgzt/Le/UrO+NJ54gF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaV/3Ot1SvoUD8aFW+07sYo+HKJ/r2y2EcpDWlJd6t4=;
 b=FSV7P+l4GUQsDP9btxEyoQJSRyklGUJVS0tz2tyJIsPRxvL3cZZSKc3cUkG6eBiROYGuIGYO6V12YT21v03J+tNaa8BG7CdIcjR5kG8ssh+pJzdRpzkabH3tNIhry5MtbFyYnvbg3WhGlsT17xAS9BnC1atPM8AGiKUz5GRdcvs=
Received: from MN0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::32)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Thu, 31 Oct
 2024 10:47:16 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::a0) by MN0P220CA0003.outlook.office365.com
 (2603:10b6:208:52e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Thu, 31 Oct 2024 10:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 10:47:15 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 05:47:13 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [RESEND] amdkfd: always include uapi header in priv.h
Date: Thu, 31 Oct 2024 18:47:01 +0800
Message-ID: <20241031104701.248234-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: ba00b1e7-b724-425a-c040-08dcf9996280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/vH8NP9ij1oq6l6sFHUkv2cW19IPFt/y3fDnMCpe1YP8zAf0nSaWlsVB0o7C?=
 =?us-ascii?Q?0MI8C1bAs2sHqHyOpMgL/H707xaB8nBjAY/LJWsd4ULA7KMc4c2+T0mybHPR?=
 =?us-ascii?Q?sKaN/am/Iw1xPpoJoqRGuHfyyzfvbpBYbrWMdnsWnlGgvcOZJs+LvadpPFiJ?=
 =?us-ascii?Q?uTTEdb9uJ5x3bj7/zmfxvlVpoU9yiKPqAuPzMVqEAmP/WUqPp6n4WlWrrHdg?=
 =?us-ascii?Q?RDinFZ1sO/ZISRIR0Cg6FIYr+JbL/nKN5Xz6OzCZQOLY1XXSU/yonvboSwPp?=
 =?us-ascii?Q?l6KEsQ+7400sSMgmnCUHXGvR2IS/saOuWuTEXoSVvn84DRcr2iMo7Pr7b18+?=
 =?us-ascii?Q?XurDz4m4WmERRsoBDz6o8Pdj91qmuTp+aQrT1F5S5e/GIKvko/KXQlaFoC2W?=
 =?us-ascii?Q?S2qIyIKMDop0vXNHLa70pGhDE0Fwuq1f7miRhvFq1fSKeCZC/BFoK2UBg9RG?=
 =?us-ascii?Q?NeL380XD315rvdcSQu2fK8ROFCh2ut/oHnGbSfN4U/5ThXC8CoH5h/uZ2Bfp?=
 =?us-ascii?Q?iYP1SUswbqvoSIckUhyCnmdCisGFM+tKxy4DbW7Q/V2Hs2VQ5ZwmV7jzTpBW?=
 =?us-ascii?Q?HO+VDOslN8HDrnCviKRnBpEX3huNqee6xxJ6R7E8awOV14+lJyvo6uhgspc9?=
 =?us-ascii?Q?d24qveO47osM+PK9RhCk7Ar7Ee8khJVLL8UpjwfekGF6gBO9/6NBSME1cyIn?=
 =?us-ascii?Q?w9rqjatQeZkmjhVpfGK/nKuH+QWvUy+iQDAjEBYSfK+bM/Ye+f5C6UB7q2YL?=
 =?us-ascii?Q?UsHFS6tbXQw5uJKbPhxIp+tSM8eO10ZTcpvf4vysc1QMtCuK2DrREw71Z2M9?=
 =?us-ascii?Q?1CWNM7+QZgK6av6kiuodODauwpmnPgM2QpfLohnHhDgldtzQxXVaoj1rvD3g?=
 =?us-ascii?Q?DNCzpiTw77uVMXH8PIi4PYLiFxoXHZJvYJif1nZq9FWf/L+Is31iyNzQE2L4?=
 =?us-ascii?Q?tYbTALkUlFAf0rIPRRNeUSlDtpY/QtbZCQK0GdUzwAa2NPid2rRdjtwDfp5H?=
 =?us-ascii?Q?Nc86tlE5THF8PRp3s9OVbji0DnnLgr/4SMPuNmpv26tdJtMoeH6Nm8gbs3tg?=
 =?us-ascii?Q?V94JkBSKHQv97qQ0YloAhCH5uheTQaLr0Fe8D92MNeN6cbEE+5yp/ORJsY8B?=
 =?us-ascii?Q?bCkXiSP8yfNAUM8z9LkS8S3OAPFZXDUkW3ZQMX4ylKVC0Nbr7WM5jQD6bVZB?=
 =?us-ascii?Q?xiCdlr3bHqn38HjuMwd68mfizokmU1HdWEGA/kMmnXspkNpyWYr9N2UMqVdK?=
 =?us-ascii?Q?oar1XeIv7fc8XNLXaXsUP1jwwK7bPaAvUe0be1QGLhEoGdwH532d8LNtsHph?=
 =?us-ascii?Q?z849kvTHAn0+r9odIvqPt78NQzTygEGrvLjOGwUwrlk2T2+xl/Xh64qXR3o4?=
 =?us-ascii?Q?XmcSq9g9hTZFxsDMqucaivAnVCnduOnjvcs+XTFR/tFP+0TwGA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 10:47:15.7060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba00b1e7-b724-425a-c040-08dcf9996280
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863
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

The header usr/linux/kfd_ioctl.h is a duplicate of uapi/linux/kfd_ioctl.h.
And it is actually not a file in the source code tree.
Ideally, the usr version should be updated whenever the source code is recompiled.

However, I have noticed a discrepancy between the two headers
even after rebuilding the kernel.

This commit modifies kfd_priv.h to always include the header from uapi to ensure
the latest changes are reflected. We should always include the source
code header other than the duplication.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 26e48fdc8728..78de7ac09e8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -32,7 +32,7 @@
 #include <linux/atomic.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
-#include <linux/kfd_ioctl.h>
+#include <uapi/linux/kfd_ioctl.h>
 #include <linux/idr.h>
 #include <linux/kfifo.h>
 #include <linux/seq_file.h>
-- 
2.43.5

