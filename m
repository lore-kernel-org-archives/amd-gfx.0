Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F42CC02192
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 21:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42B710E578;
	Mon,  3 Feb 2025 21:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tMuzcTuM";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903A210E1A1
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 21:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAg+jlmNtz2j3S9cPIQnXQ2LwzUbP7xUGeESkjMDpZcO0wEVEaYLb8Yt54SUHP8qwOq3LpmBM4VqjIWb6fJcUoivaw1TFUZf2NOdGrWtuCpmuh5jT0fUEpU8NNtrJE5ihNpvrBqOcDBzHABtPEvu1dQu5gYwxfE+dlkGLLkpq0Slw648dUC7o8N1H6zdxwo+AULS05ZWe73ZRbR0RUeVzm11zHxBBmi1eqq5Jabln0091o+KF6S/VK3YnfhCw60F7AyPK8Sk0aJHjsoVhpK7E7OkeC01A3C8aaP3IPPnUkX5XOn+mFtTSt1vTcFFxLpMfjADiX/QGodFWqEsFmrhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdiM7/QNCS2eoM0ibMrNvqosFyKHn9RHT7BMLIl+wLE=;
 b=amhpy/Eq5qwadpN3usDQUkPj0094vmZc4kH0HcRivzuUOF51ddNDWVx/SDU+jWcoUGGnUSKsv+OE7pysS7oaO2uOBqLJcqLuj9iCpTsDYkjObjr8NX9epsGjIwhhSgvwlWIi9Jhl5wCUz9ZZQlpvURJ/FSNRmtVmS3tKaZKMkoYgYCs1N80gllwJjuXo+Bfb9ik/FTn8HGz/b70a/lvI8cBgxw87z1sl3Dp1tziQvdDGc2uaAZOXgzlR3sR9flDzz4ZvkAfH3NmDP6oQswzi5NTXZfgoXzuAEuP5rZ1pYoxOnGHyRnY0CxAd9sBKD9sSufzseuMMZi7ZaV6Jl3l3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdiM7/QNCS2eoM0ibMrNvqosFyKHn9RHT7BMLIl+wLE=;
 b=tMuzcTuMvFCwOKM0f1FQDN0qLDkxoH1dWtVGN/N5lqQZnfVRSzXub08PPvNINQYNsxmCmyJbpEIcLEzWgGBl+wQ9iOOyac1cNXsa5SCyRLtN37KEux2M9jIznSxA8V/w50qCdDQ0GNuu/oWKlHLY+/rCd9jEuqZQxfWVdIuxUkA=
Received: from MN2PR06CA0006.namprd06.prod.outlook.com (2603:10b6:208:23d::11)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 21:44:06 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::24) by MN2PR06CA0006.outlook.office365.com
 (2603:10b6:208:23d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 21:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:44:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 15:44:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/11] drm/amdgpu: bump version for RV/PCO compute fix
Date: Mon, 3 Feb 2025 16:43:39 -0500
Message-ID: <20250203214349.1400867-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203214349.1400867-1-alexander.deucher@amd.com>
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 8193fd79-ce9e-4bb1-ebca-08dd449be212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PF285pPsz6Fr48OHfAIaKPGK1zEsznBME4yqBZsvkHzLbOYx6hrQU1wMv5C5?=
 =?us-ascii?Q?0fgWihPdK4jHhdIyHQwKwKvzZO4EniL2bfG95X+xQiIggFHSXdR5VSOWrfGR?=
 =?us-ascii?Q?+S/psukgde1Bi0/xf2K8OYYYqa+GGAGEaEKWJlmPHc+HnzIqh/Kob7LWKb/I?=
 =?us-ascii?Q?H+O8somy71Zhoh5wC1MaYybQXXgN1Vik+WXtdxa61pqrCXaeQPXazlmTQbvD?=
 =?us-ascii?Q?m+C7mBoPRqvoFWzYE+ZVnYck7DwXo+ZMR8kj+gLqb5/0PZ+Kj7BPNgMDd6aB?=
 =?us-ascii?Q?kVmeo1UibO0NfuRYXnjU39vqBeifvv/f50PN+rbKr0oFuKrznghIYz/KS40A?=
 =?us-ascii?Q?XFO8iYtrgCDo5R9tLOkT/Av3nYmfhuIcxTZqPz5iLQWXLDbuZCfJ50kkO+Uz?=
 =?us-ascii?Q?HAksiO2apVpfUvC2YivH36rbMrxxm4tghScgxUrcahoJw8rPrT1T3ECdswge?=
 =?us-ascii?Q?ngMeJhYVpKFG2a3GE6yP53NhlsYQTPALe5Dm6xOS4TQkidbymZap6KZFEoPq?=
 =?us-ascii?Q?/bM4MXSM7WWAjb58hAylpHAZ7G7jS/jjQQaMW1xGS0AnhmwRAGbYov+Ag5Ar?=
 =?us-ascii?Q?3Q9QU+nPRzywKTsgWPc9YHiFQ+d9Mlb6iiQ2bwoGjlpDAyzslK3VVaC5CyZY?=
 =?us-ascii?Q?P6x9vGf+8KJroHkfNYpr55GZP5nD4ESvtkqxZbJoWZSP1WF2y5eQzQsiW5DF?=
 =?us-ascii?Q?FasfoJM9Zwyl1ob5mus8S82tCSXF2vzwvUE8Oi1tnxgs0/94QgwRnTeiTRmu?=
 =?us-ascii?Q?FlNxM9pw2v5OUIh6gLFwypri+pS9TQrJGaBLvDOIvyPOxzv32efavwQnkD9G?=
 =?us-ascii?Q?PxDd+WieQuqx4EqfIwHvVknCsxeAVewl7rqN98rhKuTpPufgLyOYJzKUezBb?=
 =?us-ascii?Q?sujyZ/YUWsOnWTTVquTBwqgbaCurlKcp5woOLfoJBfEfDQBvCfaAc44wGDBU?=
 =?us-ascii?Q?dnr1r9RdBN59B2eoRl4lZncCNk7thTy6YwyO65DkVFLi+2ZCM6Dq5n1TyC/p?=
 =?us-ascii?Q?qV+5A9BJIq1slIG1vo3+jg6HfZ051qGu35f3gZ53gPEL0huDCDQ3f6HRkwsu?=
 =?us-ascii?Q?y3CrCaS+TV0GUg/d9xLlv5CxljDhBsyukOtSRkAqf+Tg7fKmnW0lw5/NHCAX?=
 =?us-ascii?Q?cQPBWewpiq7esLlUjUpDNsyoLuuxbL7/ak1JzSI/cTPfHvwgn3jqW90+a8Mq?=
 =?us-ascii?Q?dGQ0bOo42nsryAnStc1sBiApN2+3ubLhimBIlFGOI5/rn4m4PXggkh155RDR?=
 =?us-ascii?Q?jsNyXHUu76MUFf4jQwWvLsr9eVSse9Am/ab9bN92YUAVTIAitpbutiUmOEvd?=
 =?us-ascii?Q?5hTpyC8ZZgXRu0lrvz/OknAuLC5gPLwFO6aaxkJI2aK7ACY4H7dlo4dVs17T?=
 =?us-ascii?Q?hc4AT5WvIcKexbo340OH1R9LnwWRswoez00SWCntYNV6YyIOI/btAqlq7s42?=
 =?us-ascii?Q?N/ni0Vi0+OLlR9utx3AQZLeyLAiuSscg9C61zAhgjRVtxrEBe0Kz2aqM5CTM?=
 =?us-ascii?Q?IDTABnJT6/ZhPm8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:44:05.9207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8193fd79-ce9e-4bb1-ebca-08dd449be212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607
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

Bump the driver version for RV/PCO compute stability fix
so mesa can use this check to enable compute queues on
RV/PCO.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 69e532e34950e..95dd2fbc26c54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -122,9 +122,10 @@
  * - 3.58.0 - Add GFX12 DCC support
  * - 3.59.0 - Cleared VRAM
  * - 3.60.0 - Add AMDGPU_TILING_GFX12_DCC_WRITE_COMPRESS_DISABLE (Vulkan requirement)
+ * - 3.61.0 - Contains fix for RV/PCO compute queues
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	60
+#define KMS_DRIVER_MINOR	61
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
-- 
2.48.1

