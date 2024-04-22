Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B899C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 09:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB7D8112911;
	Mon, 22 Apr 2024 09:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FPP/Ee5T";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C05112908
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 09:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FirPfX+J6UPvNptLKsrzoR0F0B3rwEjIcOYQ61sR0+/triEBSjqSMIdgN4gpgSWCZrv04ceWzrYS48gwYxSaaLTGR+AoLai/PrnXmAKbP+xjuzBNtWhbLqzVm2phrtLlncjM0ZlhxvoaqaCdRTXgTyW/0Aa4AlgR4SRy+Gve90uyoS2rW5FVhwQym3RGNrcV48sWuTpwdNjzNj2M9QYx2AYmoiO/+u1ykou3FB+icx+gxXbwectyLYEyv+RN7pV7kHr7if0FxSEMtMlcDfI6h3gIFuyhG2w5v38DHm4Vs69KlaV2n9Qyn2cPbZ1JwFn8hUjejOTnKTEWNLkAf6Sq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ol+hbJVZBKb64Phd5JqiGPubE6PhvekD5Y7lSWd2ys=;
 b=Qv+o4A00xfLUROxS7tjbRwSyPVPeo8BEd7Hk/C/+mpdh+K/dvT5UiZkOAfYw7At6hP0gcPVj6cewbPxoIOHnU0GI8XMCspgUoKwhIxjYtJ9vGyejsBLuPtBtkygU5cwsq3OU0BtOQxFS44evhCikmVPRc6JCjtEWh8unH0wNtiR0sb8D2bMcz92lW542Q9jQk+0FikkkxS5CEzrG0hXfRbMulczb1tTxFVJEN73bQlEVY7YT7rJh8vGi75/dKDpkAIPc/Namvuz63W1Kgt68fa+htEpqkBNFHIuOyAIK1FNOWa3ninW7WgcGLB3F0fTCiBWQvnarxfyBtAFEuKSfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ol+hbJVZBKb64Phd5JqiGPubE6PhvekD5Y7lSWd2ys=;
 b=FPP/Ee5Tb/XFSn7eeIli0Gk2uEsJzsNRhbhKqIiq93tGdmSbxx58mhL4FXp2kb2kTZVU/e8jWLlDcu8ejJ3kkyvnTNs14juQGiUb/WoGtp463d6BE0EzLg9B0fsUnNkjwp+0lWA6Tllap2LI4l1hJaSWQVFY+Zm7+W2bFN5N9Jw=
Received: from CY5PR15CA0222.namprd15.prod.outlook.com (2603:10b6:930:88::17)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:10:18 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::2d) by CY5PR15CA0222.outlook.office365.com
 (2603:10b6:930:88::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 09:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 09:10:16 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 04:10:14 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Christian Koenig <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdkfd: handle duplicate BOs in reserve_bo_and_cond_vms
Date: Mon, 22 Apr 2024 17:10:01 +0800
Message-ID: <20240422091001.254640-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbc6137-c6d6-4621-ee13-08dc62ac06b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NM8W4HQusv4lcvE6ABjOGH256xqo6Pz5+dETvfJpZYsDmKwRcUidM2UWYPED?=
 =?us-ascii?Q?cLAp3IGqgBgTdfsqAsO5ppV+Efj0ulRkwsoCW1KC0iR3TRCw+bwAVEHs/w1r?=
 =?us-ascii?Q?4ct6axq+AMYU8IMhRqIm9qy3KTtZT4L6LYPbmwS/nJqftIwxkEI9AMsB8sNU?=
 =?us-ascii?Q?Y+JUXQUW0A9QERoNSV2/K74h6F3ZyAoSb/8e6lFko6rR0UcUYgoVC45xD4te?=
 =?us-ascii?Q?VcFd06dKkgrQiXMd+WXTc6FVgO5fyXwjo/KUFJ6DJExSXbIXGgc+4022jAuu?=
 =?us-ascii?Q?MtF3eimOMxW3I9wQaVY75h4kmI5iFi4Bvk4ucxFFXsYWyx0KKh25Oaggkupg?=
 =?us-ascii?Q?IiCW2WgHQSBGH5kaZpvOynjq+ri1dpOadzUo5Txd4L9CY9ryti5Y57boLqrc?=
 =?us-ascii?Q?z/T48lWE7d7761dxLcZaEyA6kJXcn1xCaLBviNfnQoxnStyCkPwJioXsG0Mf?=
 =?us-ascii?Q?opwbTiYXcn0yVfbmsrNgw4ZNHSGFnqOx0z0Of5rdk9YTlag1ktC+DB/13/kG?=
 =?us-ascii?Q?gRy/XQVlWPfzSkDDcds+ms0mqPrgnXcGdAtaSTktT8khKUHRqP2mVB5yQh1r?=
 =?us-ascii?Q?qDb4fZ//zHiCmd8sgVE3faDji4dgECyw5X2YEDu6GEev/dcHPYpwW72Tn0g1?=
 =?us-ascii?Q?S2znCquGEGX47d6NG1Y+wQYxPsN7kQpkB/2/jFZ6kJRZqwWoHuvscCXKnUEo?=
 =?us-ascii?Q?bLyWfM/RUxXaS9UV+6hLUsdLBf0H6Ckx2mmAveR4xqttm1XQ3kH7IpGF5I/1?=
 =?us-ascii?Q?OZCaKBv8yEt2eGdopkPY2EGz5e7Ltom09XUAeZkuh8mBkQ9xENt+JWuSUicW?=
 =?us-ascii?Q?vKUZU43O6qEpqiV3wNXKqbf7TjSi7k6Zhct7ThxK5zhOQGJ369QH7Gc9J2RR?=
 =?us-ascii?Q?9WAnQmtTtrqE633VOT29qrOTww1MWNkKLtnxB0O59twgHUOZs0eUTxTiLpyT?=
 =?us-ascii?Q?05HXHcWw2TWa4VQqnvLHYhOPcJ2So7bYYKF9fHLxFQND/8p5WxIKWtGZGXI0?=
 =?us-ascii?Q?W8yMdqOXkCgYjpwaS3fdeCq+6pzF+eIWehEj6Wkyz3hWHWze7CpTT2XUiPaB?=
 =?us-ascii?Q?NqivJpIcgsAzcwYXsRMmE7AjgQKI1mQ4UfhSdfNiXiI8+ldipVkk5Jka6TtP?=
 =?us-ascii?Q?kzDcW2A73Mj6mvQEGrYfykNtyMlMYYzwni2p8IgcPSWA1G0JC8S3+iH9b9TX?=
 =?us-ascii?Q?5Ys43lrak3ODhubTUSMoPtPjMED6npBWlduXZYFqo1j1CwTrkWGLsGjJyUs0?=
 =?us-ascii?Q?vkjPaP4P+Hxvo6ovXgvgrUmzg1ivz2cFN+CZ7Gj0VsGHGTztu6GeTPqJeidB?=
 =?us-ascii?Q?kX5X6OmDZbSTbriQkDo4ZPZdF+0quOaQroxbSuRzN9Qa5aODnSngXLdximgP?=
 =?us-ascii?Q?0Wbz4V4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:10:16.4960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbc6137-c6d6-4621-ee13-08dc62ac06b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542
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

Observed on gfx8 ASIC when KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM is used.
Two attachments use the same VM, root PD would be locked twice.

[   57.910418] Call Trace:
[   57.793726]  ? reserve_bo_and_cond_vms+0x111/0x1c0 [amdgpu]
[   57.793820]  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x6c/0x1c0 [amdgpu]
[   57.793923]  ? idr_get_next_ul+0xbe/0x100
[   57.793933]  kfd_process_device_free_bos+0x7e/0xf0 [amdgpu]
[   57.794041]  kfd_process_wq_release+0x2ae/0x3c0 [amdgpu]
[   57.794141]  ? process_scheduled_works+0x29c/0x580
[   57.794147]  process_scheduled_works+0x303/0x580
[   57.794157]  ? __pfx_worker_thread+0x10/0x10
[   57.794160]  worker_thread+0x1a2/0x370
[   57.794165]  ? __pfx_worker_thread+0x10/0x10
[   57.794167]  kthread+0x11b/0x150
[   57.794172]  ? __pfx_kthread+0x10/0x10
[   57.794177]  ret_from_fork+0x3d/0x60
[   57.794181]  ? __pfx_kthread+0x10/0x10
[   57.794184]  ret_from_fork_asm+0x1b/0x30

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 101a2836480d..c4aaf9c394e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1188,7 +1188,8 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
 	int ret;
 
 	ctx->sync = &mem->sync;
-	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
+		      DRM_EXEC_IGNORE_DUPLICATES);
 	drm_exec_until_all_locked(&ctx->exec) {
 		ctx->n_vms = 0;
 		list_for_each_entry(entry, &mem->attachments, list) {
-- 
2.25.1

