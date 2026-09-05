Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACFCC624DB
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 04:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB7010E1CB;
	Sat,  5 Sep 2026 04:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ePHpkoID";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C27F10E1CB
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 04:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyBUJ0ab4O39wFiC9bDj8oQyx3RYkJEsiHEx3ahSLPxZSo8DoLi/Xlnc2uGCayNLgm4uzXnt32XhVRWfmKoM4vD6hStGBdVKlipCOea509/5M1Q63yRVULbkM8zw0/31wLMSH4/oXTlKf0uZpbWJoJt3IAhKYi7AV3v33Bd5huEVwJ7V6kvjwtXqxf7+tlE9NDpwk6kwRziVzwdA5KL7NWb6beXzexWiWO37bsrjshEsLBQwopSGy3IuoOji0a0LyMeoWkUra1N0SrGnydey+prQnLQWUyQHgTpEqHpz5OImUhsQ3jMjT/jI+/vbhjZth55GlLwzjAY+X+0pIEo9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3IUqLhz95s8JlG52Gl2EbLq/oEfj2u5ceKi0z+3TR8=;
 b=EjwJA4u67KczS/OSB6dRxvDbboW1s/2cdH/x/4HyTvo30FacvM4f9GlQW4qGRf8T0WUB6OvityqGnzxkuBzJrsuSUPKK4Gd2/5HvrDV5KbHMBBP+I3XWYzSQNtG9jRPiecgPUhf8OzlcDtwgxz45mjZog6AzfcggRPXPxin5W+uz5/wyEHbthsSnf0Szbvh+epXmchGpC3m+C1p5vZfbSfLQgR81mIMuo4SUzSZVDiCgUnolisGm+CqST/DEvDzAmtVERezI8kD7nSA3JS/FfzQ0cfW7xDAkTHIbQtn3Ugmd8S67YZw8U0QVLgNfaGm1uHb75woaVpdBFr/czvoztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3IUqLhz95s8JlG52Gl2EbLq/oEfj2u5ceKi0z+3TR8=;
 b=ePHpkoID+S6ME/ubmLT9nnzEcp61zWlPXjGbR8NUpXKeCp3x0dmCbQNgAYVw/uqLI4ShhPlC4ynbeTY6UzvQxINGQ7DkXqHyaArbL61blthJmtELi5maG5znUscF+pCxwZInPy2saL8fzXHcSTWpInnWYjULMq8XMOvf96aPHMk=
Received: from MN2PR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:23a::18)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 04:30:54 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::2f) by MN2PR03CA0013.outlook.office365.com
 (2603:10b6:208:23a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Sat, 5
 Sep 2026 04:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 5 Sep 2026 04:30:54 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 23:30:52 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: balance KFD suspend reference on partition
 switch
Date: Sat, 5 Sep 2026 12:30:30 +0800
Message-ID: <20260905043031.1015676-2-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905043031.1015676-1-xiang.liu@amd.com>
References: <20260905043031.1015676-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: d536ac2c-01c2-4a10-dd70-08df0b06795c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: a84zEViYvBvsszz6Ptu3qH0iZn8GJ7o+PGfMKhslgWpHKz8zEBiWhIRY6nfkaAF7H6HsIOMU5QNnQrtZeMiR5w5WVluojqDsF6BqpP3kenrNh13edPAVDTD2FoOZQaoNvFmu9Zv/dVUcmkqVF+rWQNMVtJrawC+8b6QDjW5U8/Bq1BFgCnLmTxuzEmLbpnpHDRZEKDZy/2Zqxdotcgmibfey+aHUtxAYEARI8bPDZXAxzAxlKAs71iQVprFLjGy9Xq9DoPlsgxnSCljpAifGeiFhqHPXbVsyyb4DgCLUI6epjwjodvL9siU16eTmwDQsK4lT+tkFfRoQaEt+Len55RbTxaQ3AUTPRAiNL+GAQ7KMhbJOQurMoxWILJa8UwW4dBsC5BIG9xbtWgOhLYYo9sH9nWkhJtIiERrx9MLYgLObg3pQI/0T1gBrnuIxxlfn9sgX+o0eBao+09n9MOHuXmgMB0Y8p8DeUx9AbsqSJkvCnPtkL8EKVyA2/dDALd1G3gW9JTppcoX3QemJqjz0Q6Yjgsn4fIrRB8N0Y/0xwQ10AEqxOX3PiNdHNNr+FRPqVrkJEBNoRI4lRTD2fGSxHx7P483qPyYYDp1K9cHZsUH2hFU6RljBAx4YCOoNp634t7qbmaQKKAeAi9aWqeahebKxPucYfdyWrpawta4eD0xJVsMuVoRcI/qO0F7f4sEMRrQiS3YLwoPj0dSi7N789A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mnj2ih1KlnY+vARKHm73QFet37ryAw4F9vEKosKlJ3YKve9VRYJhw77Gy4Ljblc9A2xdoDzgsO8aPkpCKYzLMhuOuQtmp6+S4YcwjhH0Jt/Y7RjqFRbsV4b9Euss1jPDqUIMPVB09wR47NEjYOj9m1FXu4sRKxHmjBIisxLKdDs1Erc/PVakTVvlDHWDCqqUub1aHgSkvxYJeBpuX2fA8MISUYUa7K8dtsRMROOjn4RYpZUdr1HLE2szAQZw0IAJ2LTw2LuBgC5xl+XXPZ0T9r3kdgJ8IFCB5zzhZkQlA96AJKvoz8kulOWu7PpxV7vw347Zr40uYGewDMoPpeqMGnz4F1zUlBugFb6TtMKZN9vxkmMMm62nSodcmk/Hx+AAn31BwcALy6X1SLCbTxwu4Gq7nOAnXD7+1kKtd8wByNZuEToKHdVGIez3X30E2+7Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 04:30:54.3304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d536ac2c-01c2-4a10-dd70-08df0b06795c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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

A compute partition switch tears down the KFD device through
amdgpu_amdkfd_device_fini_sw() without suspending KFD first, while
kgd2kfd_device_exit() drops a suspend reference. Every switch leaves
kfd_locked one below zero, so on a hive the counter ends up deeply
negative.

kfd_locked gates the eviction sweep on "++kfd_locked == 1". While it is
negative a GPU reset never evicts user processes, nothing restores them
afterwards, and page tables torn down with VRAM are never rebuilt, so the
first queue mapped after the reset takes a VM fault.

Take the reference in amdgpu_xcp_pre_partition_switch() so it pairs with
the one kgd2kfd_device_exit() drops, and only drop it for a device that
finished initialisation, matching the early return in kgd2kfd_suspend().

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index b4ebc157fd06..e2e7d101b3c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -698,8 +698,11 @@ int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 	 * Stop user queues and threads, and make sure GPU is empty of work.
 	 */
 
-	if (flags & AMDGPU_XCP_OPS_KFD)
+	/* kgd2kfd_device_exit() drops the suspend reference taken here */
+	if (flags & AMDGPU_XCP_OPS_KFD) {
+		amdgpu_amdkfd_suspend(xcp_mgr->adev, true);
 		amdgpu_amdkfd_device_fini_sw(xcp_mgr->adev);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 729b35841e3b..d76920adc466 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1014,12 +1014,12 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_gtt_sa_fini(kfd);
 		amdgpu_amdkfd_free_kernel_mem(kfd->adev, &kfd->gtt_mem);
 		mutex_destroy(&kfd->profiler_lock);
+
+		/* pairs with the reference taken in kgd2kfd_suspend() */
+		kgd2kfd_unlock_kfd(NULL);
 	}
 
 	kfree(kfd);
-
-	/* after remove a kfd device unlock kfd driver */
-	kgd2kfd_unlock_kfd(NULL);
 }
 
 int kgd2kfd_pre_reset(struct kfd_dev *kfd,
-- 
2.34.1

