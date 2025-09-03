Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C76BCA1007
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 06:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B6D10E0F2;
	Wed,  3 Sep 2025 06:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UpsKULpE";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B655710E0F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 06:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJzlf3BdWHkJpC9TAnVw0eE+BcLvGdS3IqlJFxkefIU0AKom0FdzbgXNITnoJUomNNQNwNGBv1d707B9j2062SFKuHNIol7xpPtAQaBjevJHuWBxVr+Qpf6OudgzzeWK7PLY8hpTc5Qo658PaWzbI7DXifFTyTpHVSB5uwx3qwGAYanQxkNFiEZ2tDvr8RkX4bSmeu2pLVsLG2WOLLXkiky8EYRXKcJrpfRPL7nebutGgyDu3BJpZjqkPtRZxu/kwSYHABw35+q4nJfZpbj3j0QIofEA9LyUgrHapaMCHCjQGQKPNcEzAlkeN4hFgiaB6jGoOAXupmAujkByQJ5Tdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7VRlgLes4/vHwzJUsdg4PPPxYICfp/GamZqKiiD4KA=;
 b=Vo4NMmGo10otd0VsxM61tbT/ZQXWFW8B1pFmkKJPaGgcDoX49BVCy7Vjg/+uleWbkmaLRzdzzqktglxwoE1Y3fLJVCL3hPm7hMWcdGIsijuNgr0NO/PmmULA9gaAA8MZqXqItOb0HP1DNB7/AAp72YhNfNZumQ/GHdQ4mqW1Eoiequ8Z0V2fXjrWrs0rfE6GW87b1nHeeRC3+RrTbisbjBLuTp53emuB8gWro6ks9uoXNVFT+dZHGL9L0uvg6PKAtWiSXn1wTQw/1MzXRilN8/nikLvEVR3VHyG3ksounCYDBvvb2Dl0j0OcMjsBElYw/ww+fPUrYDS86gpVYz1FNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7VRlgLes4/vHwzJUsdg4PPPxYICfp/GamZqKiiD4KA=;
 b=UpsKULpE832carCXb40tctCSR5w9nG3dmkKFBMgFyaTNIQbiziFzgPk/WBDso9r6LfzMNeQM1NQNYPUzS1TUMKBwbUFmMuAfQOm8RRN5x7si+JoHb36P0K6hEgBHUvazIfnULNq8JcpPVVHHFozxvtnWnpSe7inVMd5pCigZFnM=
Received: from BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::7)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 06:35:28 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::b6) by BN9P221CA0012.outlook.office365.com
 (2603:10b6:408:10a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 06:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.0 via Frontend Transport; Wed, 3 Sep 2025 06:35:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:35:28 -0500
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 23:35:26 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/pm: refine amdgpu pm sysfs node error code
Date: Wed, 3 Sep 2025 14:35:17 +0800
Message-ID: <20250903063517.1352079-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: b6aae8a7-b251-41e2-f27c-08ddeab412b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?972YECG7DS/fhah+fCTPD4hvZ63QqJURhyaLCNNSs8HPLAmx3Gtcfx5X3JQU?=
 =?us-ascii?Q?VxKet2yz/Ouy0YIFNVcr3e+pb3SVmtyQ2zHjfP/1D8Uo9iN2WBnLQPzvUgZC?=
 =?us-ascii?Q?l6e3NCughnouJPGw4GuYL2PR2iG6qG47bB5SMMS+dVnvL5gJv0irqg+MrWAg?=
 =?us-ascii?Q?cWl+DFLpC1kVse+wn6il78jL+uSlfHbWbzMXExHUOecrPqUZcfNLzW4SEOPy?=
 =?us-ascii?Q?4VfQemmQgMSZRbW/Zpte45phrkxUe8MJGlqkloeUdtLScg4nZrgOu5xRgxX5?=
 =?us-ascii?Q?3fdFO6w2ijQQD3IiyMERH2fTIE3fZb3LYn0V4JtXOzIK/1DN2cnlAjcbBha1?=
 =?us-ascii?Q?j9B+/zaPihX6/sUR431lpS9+5JwyldbQZQyyl0z+1TpyW/xVNdOSBIN49ZZl?=
 =?us-ascii?Q?AXXx/vVZDqg9QhDx5QrXOAjQAaNSXyYKULDxxyFeZKnT/3RgkrexI0GvXZuM?=
 =?us-ascii?Q?7n8xKh2ooXxnUeiRmmzvS6BgWD8l1+Ox+PGvp0WarjflCsePK2w5AbowzkPS?=
 =?us-ascii?Q?qK6iG+9rX6jKAEP5xQG6GwMmxTDIOsEMbGQKCeCGFt/1yQgg7o/vKDrbTSEm?=
 =?us-ascii?Q?PXPSTh/j5axWisc80cP/UGyMKXu0PhM+xAgAyOg9MTfx89c/Zz8ICR9iPmKZ?=
 =?us-ascii?Q?lBKVpbOC0XVjBabTfonljlNzgJ8scLUvLXDe54igPpwa7GC2xPOxQkCwFz0X?=
 =?us-ascii?Q?z8/5RYIMUNDHXSJIMSu2O03MHnmVT5m0nkTQjc55dlwjxhqP047D1B4sf/UD?=
 =?us-ascii?Q?QIdP6ajCb7oNguGV4rzQBAUH1Ty1QnU3vdNMVl4lrfhnvKHR+G4i1iWb9q57?=
 =?us-ascii?Q?NuVuuD4e2wtWwsrAfpnG7JjZvc3fYiY3wDQxEkIqcp0f9wwhACA4OPiuXUc4?=
 =?us-ascii?Q?ZuRnwFIyPeET9KbwFfHr6alIfJDIdV8880sUTfDasbG+Qtgo4lWeRUBLnA+N?=
 =?us-ascii?Q?H706JSojNOti+UWvOWA0aChi5RdpJu+9S6j20vNPxjn6pWlNd1xlof/tu06U?=
 =?us-ascii?Q?/92Gzo1zsfJYccLaGrvZw7Fvi/FZN1gCxxN98ya9K2CRdny7VQoTMw5BwzGp?=
 =?us-ascii?Q?ujdz8D8E1xRWoGiIi4kvuuVSH2LSuZZbUJC+5jOUdbaoD7Xd08lgyeTbiq9O?=
 =?us-ascii?Q?Lj1N8uOQuKQ71UbRcOWIZvY7pN8bUAQD/0XwPIC1BqLFxbegtxIV3pTYmUrK?=
 =?us-ascii?Q?3KL2J+6sq5yMpUuACfVtRLP++QpgI0Fz5tGX8lZlLXqH/PI4frXWyBCgqhcM?=
 =?us-ascii?Q?nx6eA0eKiaVD8A6zbQbWix+4fyvoxx9EaV9Ihslg9I9f7fb2Swqjvw3UFVbm?=
 =?us-ascii?Q?Ph0K/4clSJqtWI2aakldQTGvQfaT6W2YIbbjQYedP+Nwgz6Eisu/6wq+mFYi?=
 =?us-ascii?Q?JVt0OPEm9icdw5CJcwF8xeQkmu+nIv1IA2t6r4/qFxrqUdly9ittYkc15RVe?=
 =?us-ascii?Q?ACyszggW/ZQ8LtglXHo8SLpbbJ0lgMaK7CrMml08zfo7yxMNic6SV6PwMrxG?=
 =?us-ascii?Q?WtaC9T2YM6Y9/0NPvWCKhFyKDtZqfJjO2spt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:35:28.5176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6aae8a7-b251-41e2-f27c-08ddeab412b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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

Returns different error codes based on the scenario to help the user app understand
the AMDGPU device status when an exception occurs.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 0906bff864cb..6b1de23c26e3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -110,9 +110,10 @@ static int amdgpu_pm_dev_state_check(struct amdgpu_device *adev, bool runpm)
 	bool runpm_check = runpm ? adev->in_runpm : false;
 
 	if (amdgpu_in_reset(adev))
-		return -EPERM;
+		return -EBUSY;
+
 	if (adev->in_suspend && !runpm_check)
-		return -EPERM;
+		return -ENODEV;
 
 	return 0;
 }
-- 
2.34.1

