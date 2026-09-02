Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22319C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81B5A10E4EC;
	Wed,  2 Sep 2026 12:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ICreUFSN";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010016.outbound.protection.outlook.com
 [40.93.198.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA3FD10E4EC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TS02sUUbeqaYdm3/RBUSYTo2eAnt/1ah+cnBZwFJbU4Z/KQbWEHcxrnhl3GNg1SHG4PHwA+EkWkeTlBgmZ7+zOO0Wm8hlHWyi7ZqMs3n4RvEbfqdEtAhCHAE8YVB3Zx4ZAGJEm0ncaENLqsppUiNsFGKv4d3PitT4R2MyUyu9E5ZP6Jy5nN0WNCBi+OhDCjcyySos2u0Jq0DEeHSEeAy4c3QWmZ9S+HwjIoyZZjjzpnUx+7q3O5dfZ3n1ISw4n0cahvy2Td8XBNBQZZsrnmUUkRN7wopF4o3G8wcMSpaKAbBLxdVAUHp8FxWqqxIqqLoB4/eQNVUzdMx7Ul/MI88iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCgaeqrfyqQtJxqULlKKK9TEzaTqNzU4SPyRLhBXl8w=;
 b=Xw8SxE6syo0qK5XJ3M0d0EqogCIq+jqPBwCdX7RTTZhFganNKcq6DRRENC5B6Rw0Ap7yaWWtdmXZfpQESqcST08gsnmuPc+f8Szc8VIJg5AcNCIuXEKtMoO/EfmTjgtCQrnmVG6vAMijb1CNGp3mopxnda91n+e0wf4NaLvwn2EuuxU49Pki8pQt4KV7G5QC7ZK0mMOGgQ8SWO9VCrDw2qwKYC8HRlEuQETQ3ncqOwIgnvZnpwEjeg0pjVKyGZFB1qcZ4IVHBOBpCOXVPeZR3CeBSV74qYV+8JfMp1iS/GuKr+QR+U3SUOfC8k8Zqw/pGmHQgM0YyLPoU3m5t90DSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCgaeqrfyqQtJxqULlKKK9TEzaTqNzU4SPyRLhBXl8w=;
 b=ICreUFSN29XT9HWGkHsg0MTe+uso+cxZndsDESk6C7li+4seIHvJeldPy9mviCM+tVUplakw928QO0eUM0xm52X/fD07YLEZVZALeeE/m8kJ81OwOJ3XtXOeruKYPqoJlJJEsy3sc7KygoqUikCQUbqg8NNYVn/yE/eoKCkoNnQ=
Received: from SJ0PR03CA0145.namprd03.prod.outlook.com (2603:10b6:a03:33c::30)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 2 Sep 2026
 12:50:26 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::1e) by SJ0PR03CA0145.outlook.office365.com
 (2603:10b6:a03:33c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 12:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:24 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:20 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 07/18] drm/amdgpu: serialize userq eviction with GPU reset
Date: Wed, 2 Sep 2026 20:49:50 +0800
Message-ID: <20260902125001.621629-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: c27e4468-bfda-4499-1167-08df08f0c20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|22082099003|18002099003|56012099006|10067099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: ornVwDmfc6kduHdbTO0GJCDlQ8vGR17087UlpBvK25Ahu6NmIhHIKqJztdqxH43XPf842Eev4wzF/ba0zMdCTb6wfGN18oO87VE/0cwVqnhUEIWPBasWAb5xYTVkgjraO5paJTmhCLhRVK3F2XsUcA6q8L9HLhT5ZzTaU+PQ6sSzdqCB/Jww/hxI9M5FM3BXZ0j71DIH0pdNOQGrMuANWvqDN4mX9ChOxubUouxdJAj5OvXaK0LaeX6BqCANcjVxzw/xSysM2Z9m+rCFWR5s2fZZXqSxtG1d6xjU+MgthFNOSzR1IUVxMOLTEj/dNdz/KcsVlMPheFpEnahqn75rD1ycPmelshC0q4fDZPE8Ujv/rJjIEKVjd+NJIubzxLF1kqBUnyVeV0EdquAxKP3LGG1V2mcwptEShhNFxA61LRhCEFym8omrvOgNwPXPu6//Tm61kjvbdEm1NnzSQalK/HCIB8pMQCUIyoqHA+r79h4wdmr/rDqlARcwdxb2/q/I8CQkUrVw0e7OM2yJmD3zh3xk/R1ogLFJPXHuuPJ9Mcsbt3a/80y46TxxQmirqBOSlhUUPTn0J8UHCaszaMnnJ9DUSeEyzPfeNTROS+MFKN+bKyP+qk2rxZDUUfIhaUiv1VFwRPmuTSkBkgVcxsgB6lZRTq5sKR32yeN5F0O1oCuy7P7AzTuPs7pgIi6TlHccD637P/AshxGYi3AXWaTSMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aar/XceizbGUKAal7sllWW7V+Oc3o7WxBGUOJD9u3toaVyCckCG6ETHlWvU0XgU03eMbcYPhvkjBWLvnbvxpSgTEbE80rUci0jyzl2Y5ZrwsyP0opGRRpQ6djmBLDGusfV3Hv28IV6Y5UxelhXDdnqAcF7LmGcd7MZDaugXlRR0dAYQqdNVTszsiFLru2nQP+7aYJpu6zsXoDr3YHYd8FW0Hf8kGvJxJBLib3gBlPvLCDthnyCrrcJHv+r3b7fYKZno+LsHaEfDZBu0r6wdPxNpzALtF4ag5xzWxhYPepx2Bqx6UfPQiTjI08ZFcV0RhJWOEHffyE4wsf4GQB6fI73BwQVeWQBcgGWLhDURmpWepufiNMMDsPRAUTBZfesfhv9COd3h+vM61X0/JGR+4zWnp+IM6Uuxc0t6x4r1FzNQcSOIV9ixyETQlUeDceD/S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:24.9500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c27e4468-bfda-4499-1167-08df08f0c20e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
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

The eviction fence suspend worker can submit MES REMOVE_QUEUE packets
without holding the reset-domain semaphore. If GPU recovery starts while
the worker is running, both paths can access the hardware concurrently.
This triggers the hardware-access lockdep assertion and can submit a MES
packet while recovery is resetting the device.

Try to take the reset-domain semaphore for read around userq eviction. Do
not block on it while holding userq_mutex because recovery takes the reset
semaphore for write before acquiring buffer reservations and userq_mutex.
Instead, drop userq_mutex, wait for recovery without holding any other
lock, and retry the queue-state checks after recovery completes.

This makes recovery wait for an in-flight MES eviction, while an eviction
which starts after recovery waits without introducing the reverse lock
dependency that caused the reported circular-lock warning.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 2ea8553c82f0..93307cbf55dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -67,10 +67,18 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	bool cookie;
 	int r;
 
+retry:
 	mutex_lock(&uq_mgr->userq_mutex);
 
 	/* Fence waits are not allowed in a fence signalling critical section. */
 	amdgpu_userq_wait_for_signal(uq_mgr);
+	if (!down_read_trylock(&uq_mgr->adev->reset_domain->sem)) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+
+		down_read(&uq_mgr->adev->reset_domain->sem);
+		up_read(&uq_mgr->adev->reset_domain->sem);
+		goto retry;
+	}
 
 	/*
 	 * This is intentionally after taking the userq_mutex since we do
@@ -81,6 +89,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 
 	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
 	r = amdgpu_userq_evict(uq_mgr);
+	up_read(&uq_mgr->adev->reset_domain->sem);
 	if (r)
 		dma_fence_set_error(ev_fence, r);
 
-- 
2.34.1

