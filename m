Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D090CA0EED
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 07:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F75D10E23E;
	Wed, 20 Aug 2025 07:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wPQQDV3r";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F101610E23E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 07:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KolTEGXnUuvdaib7iZoLRaJ2Rs8gDbR2YpYE0khjnCG8JBvynUSoRemIavQF68mRHUK0qksMTyQlp/pXWIMt6tKVPu9Fcd5lLhpaJzKNDZfuRQB0lwbMbm9jNUz0/rI87vh6fgcM+ME1CQLEniiHUBnEAh4M79q95Mc+cm8kmI/qHdf7oey4XemKtlR1/8UOCrhuOmQ4wcfC2S/M35Zhio8H40RzIOVgPNwoza9jnNFtn1MkLBL134cDeSkfNGoHQFZDhPh3O+5kUMif8ZSjOMSm8Y/gzFDIPRMb+uRx8KfA9/PMCJfvrKnd60MsDEY/dKps4+FiTDzXUIviKEydIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoHYlKzWCUElb8O531ZstSY/YJ/bbdINqSBKWpeJUBU=;
 b=qIK2Ck9mw0e/+JCT64cOeMfVmM71+tT2OkvIpWtYIfNGZpZYXamrmA57mTABSNeQURoFiHHOG7U5oFrqjhdqM8R9lBUnyvGTrbDRUDWo9QCE2NSpuDBzsfmD5vKhZJim4mtoFZfKtHUu3qF46HTPAelxHgieNExF7vz4y8Zv3NXIg2eGlSxb3cmJSG0kIJxJL6gZsNi1jz0V33yE+M7UkVkQFaCzkkUAC2H+AxkoiceC2vQrZScEFH6n/Sa0dTWXLC9NlXqRbEh7jC1iBO5SooffFrE6JJujEAjizWgnwhOa2ujLqx19naVJViL06UfuBP9Bezo9qi6erb93gFuehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoHYlKzWCUElb8O531ZstSY/YJ/bbdINqSBKWpeJUBU=;
 b=wPQQDV3rp5ucgDkSWwAb+K0Mg7aoIfopPDckAp1VZwDdcDSMbRK95osS6cmeK1XBfEIe+0kxPM4T88gvWgbL8axrYk9E4m7w5hPbnPFbFwkSbKn+4qeIRurMl9Jr++ZPUiRJj82OmcVoGX5wcbjoS6489hblAOmVGeHlfqOfNtE=
Received: from BL1PR13CA0322.namprd13.prod.outlook.com (2603:10b6:208:2c1::27)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 07:32:08 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::89) by BL1PR13CA0322.outlook.office365.com
 (2603:10b6:208:2c1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 07:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 07:32:07 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 02:32:03 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: replace AMDGPU_HAS_VRAM with is_app_apu
Date: Wed, 20 Aug 2025 15:31:00 +0800
Message-ID: <20250820073100.3500205-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb97ebf-baf1-48a1-4861-08dddfbbab14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qunJZbUSoJauItZoIwhYqbXyuVvAPqUGRVf05PzqCshEnWtPtt4ndYULgRHy?=
 =?us-ascii?Q?Q2AmKdBO5kJY94LIVK9WR5C818vGK0jQ82KDx2Knuo+lDUReZ9U0dulnBobH?=
 =?us-ascii?Q?94UM0GeNa9aQ91B0mMBvflDzgb0sFUDFRSj3QoJxm/z1q5HV6WNfVswhgWB8?=
 =?us-ascii?Q?BhYH+3KZYhPf15wAKX8mMY01DetCDVnHPHkAkNuEGmLt5wD/IunlmotKwpFL?=
 =?us-ascii?Q?zpBde8/wwjONHH6VNRIgIo2I24RpV75d9D0pRPdUC93hIS+INLJEgEzAJ0Ir?=
 =?us-ascii?Q?HgfIoruhC8v5coG/rHCsxBY4QmwVInE3iJH6HDQ3YEaofQEFsYOivqOylNmU?=
 =?us-ascii?Q?c9YiozHyNMn/O5ntZB4zbw58Qc2vpJscO5t9fJOWo0CCx+Oae92Jndeqwqyv?=
 =?us-ascii?Q?F56KqrSOhlRFME8h9D8tdktMyHzTp3WWOlRwrxfNBBJZR831QKeE5O7hDBE0?=
 =?us-ascii?Q?qFeEJzaPT4YJzQFMrLj89TRDQyN9Ry7unw6NQyegViR0NRrR9NY4VFMRgLE0?=
 =?us-ascii?Q?dHKsJfPBa2yH/O4aXH6IKY4TPghiyUHXN9MRyjvdeFIjcFrUcM+4oQQphiK1?=
 =?us-ascii?Q?XBhBSaJa08KH2YeZTGxgRvtk6E2lBvhwDCqYD6bgo3YyBDMxmrEZL38XFNMN?=
 =?us-ascii?Q?k9onZuKeJKnt8PdtLnnJJ+76cVeRn81/6R6rK2GY0DW8vYfYTt2NBi6Wv7Mm?=
 =?us-ascii?Q?X56GTHo7mpGwzbg4AXdhIyGHwy7vL+evDb4PMcKzxSI4/+1p7iJrMZhlgd+I?=
 =?us-ascii?Q?nhVvqzAVFv4JKXSPBvNmsfPfSYVhKC9L7lp8e2W85Fh1OusHCCT0k+mMjCuK?=
 =?us-ascii?Q?Ba4VDtQ6gjQgeCf0ZTQo/mXSrhwfoUAylh/YrfyAkKLnQTc6YpthUZE6zW38?=
 =?us-ascii?Q?WWo+HCQKdoed/m2Z/9OKHqvA/Hp1iLOjWesjPXHlEM/Fng8K8rBTl0k7e/vl?=
 =?us-ascii?Q?BZfRCIj2ocPbA2JCeu+yqG9XQZ4jKz3+DT2hzZRLHbvhwM3AmeR3VhuOdMjk?=
 =?us-ascii?Q?xUARcuNJzeXmmVuCEM7WSsGPRU7NH1hnCKyb4f6U3y+SX0PEKvkHYSRy3Wqa?=
 =?us-ascii?Q?JIVtUAV8Sgryql8O2/v9LLr70oLf4smjDWi+IfHgTsND3JFmK3gDnoKKJoWX?=
 =?us-ascii?Q?7K0ExCXb7omU3zV+CYEjuikeYNA7XEWHUj9edj3OAUifOB0PFA7kv3+lm0vc?=
 =?us-ascii?Q?vqgo0NVfGqyQshtS6gKnZKZcm9QksL9zHUtd0FzrtOLAtzRrOAjC5o/3lgvJ?=
 =?us-ascii?Q?U0V5CjBqgKMldEKZAPLgs5xCY0RF2R24WRe7i2llTte0qrPezi/HelUPbUP4?=
 =?us-ascii?Q?HbVHDlgDF4EWV59FG1PhERNfrDZBuSpp806/ACqGQ3JlJvzTuCLz14yaPLL+?=
 =?us-ascii?Q?wIlKQ7Hu5ClAQ1URLKaf5C7NtcKs0Tkxlk6uuW5+a/40B/xj5jrvHGbFLTCB?=
 =?us-ascii?Q?4XDOlM3L1ZHJfrajf0o4tV3ro75YfxBB3c1XYJsBP+9kox1nSc2Y9LAyv+nk?=
 =?us-ascii?Q?Ecl1tdhsNm0fce6nMsdcIFKdzlr6tVSDRmX6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 07:32:07.8143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb97ebf-baf1-48a1-4861-08dddfbbab14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
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

AMDGPU_HAS_VRAM is redundant with is_app_apu, as both refer to
APUs with no carve-out. Since AMDGPU_HAS_VRAM only occurs once,
replace AMDGPU_HAS_VRAM with is_app_apu.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ddd472e56f69..01f53700694b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -946,12 +946,6 @@ enum amdgpu_enforce_isolation_mode {
 	AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
 };
 
-
-/*
- * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
- */
-#define AMDGPU_HAS_VRAM(_adev) ((_adev)->gmc.real_vram_size)
-
 struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index fa3e55700ad6..4125e73a0647 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -880,9 +880,9 @@ static int psp_tmr_init(struct psp_context *psp)
 		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
 		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
 					      PSP_TMR_ALIGNMENT,
-					      AMDGPU_HAS_VRAM(psp->adev) ?
-					      AMDGPU_GEM_DOMAIN_VRAM :
-					      AMDGPU_GEM_DOMAIN_GTT,
+					      psp->adev->gmc.is_app_apu ?
+					      AMDGPU_GEM_DOMAIN_GTT :
+					      AMDGPU_GEM_DOMAIN_VRAM,
 					      &psp->tmr_bo, &psp->tmr_mc_addr,
 					      pptr);
 	}
-- 
2.43.0

