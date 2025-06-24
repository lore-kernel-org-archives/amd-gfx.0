Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EE1C7EE31
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F0310E533;
	Tue, 24 Jun 2025 08:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jLMSC6do";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01C510E524
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 08:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTpHHM2p6ygPjILU37BC4TLgJ730WaLnBlwJu3AIz3p+ss1Qfnd39b3sUslUPpkVLBulLf9IVWrm592dueVyJYm4P+bd0VmUVSpmTPRLQLF6rtq5EwJw4uYmxiLWAplk/wjSff+lTd9H27SdDZAsxD+CbDCqh/z8Sbw+Sh9Ptz1HDVtL3Hcs9gTCbrdq8EsUvNxywoL7T3BwISiZr1Xihm007o/SaWVvliKIRS5cotN8KzCh2NJ+BKHFC6Pj0yNS3+VJfQN9928s6vVp0C/HWkFkUmNdPV/4JluTYYcgowtbrl3GyU9s1A9GPokAbNCTqeJpeqspWw79AETouIvx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb3hqHMnrK+26ly0oqZn4wyFrSDA9P8sPHAXTL1yY20=;
 b=Uzxx/poiQyAOPvtLboFvM/SGpqsTFKG3BuXL2wxNZycjgTZshOkLXAM9Mdpn+swCvoMt57u7AWrYEAQTUU2d1XQRP4xWmuP7HznvrcMMT97QKgkiRs37PWN7dehnH9To/ranOL3AEEOb72QAlQflV/Ho8C4UFzB4oxLYdm32B7IxsXHzPwgAqPojM+lWo1aktYNYnYtoy0fb3Y3VUgV9QifPkHXt8Reb2lGssaC1vqQZoDJnvmPvNn+19EDy40uitCTOs7TiDyf2TcYhPRD6u2nA76YzvWOjn+p25ZSCXmpiD6crtwmjssQppJOaNLBxPOxGKKpJ0xqB1GSzGuWU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb3hqHMnrK+26ly0oqZn4wyFrSDA9P8sPHAXTL1yY20=;
 b=jLMSC6douxUgGxfzlnWQT8vyhmKFZyIuOBMrpf0avbYtTu6gj4BlXVhWTvnfXlZQzlehCrZWOlv2HZ17Rq6CVjBJ8ivI20xoLBiMFcoLTY8MoEJQ9RbBCQk9Q+ga4wCYHwDdXxTH3bP2r/3okJi0C1b+RuZpP9YMryn8lNH3ROo=
Received: from PH2PEPF00003852.namprd17.prod.outlook.com (2603:10b6:518:1::77)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 08:46:01 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2a01:111:f403:f912::4) by PH2PEPF00003852.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 08:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 08:46:00 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 03:45:58 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 09/11] drm/amdgpu: validate userq activity status for
 GEM_VA unmap
Date: Tue, 24 Jun 2025 16:45:33 +0800
Message-ID: <20250624084535.1178476-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624084535.1178476-1-Prike.Liang@amd.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 18bc42f8-cb23-4ead-cd96-08ddb2fb8bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CxktXgkBWWwYIMMfH5eWdvXQ9ocsJ1TP5uqrUoJEf5NpI4ZxkGyRCLvvKsMl?=
 =?us-ascii?Q?enAFq9qkXeyPedxb/YwfeXRJvC+ypUJyqKGSR+Od/qoMYWtci8K3IKpbdsy8?=
 =?us-ascii?Q?p19MQYGxIlgGl93qJlL+tVwWL4+McuWAc85Dfh4TM+8stFdbqavAB6Lke1uR?=
 =?us-ascii?Q?elZPbf8OIMh2FGF1HP8xbGm5EMndSfHO/96ywS7F2+gFI4Gr4EpB4cfiDrmT?=
 =?us-ascii?Q?kHk3cdSd9bsgSnMDE1YIxAzTY7hS7lV0JqIhGXDVM0D5cdj4sIPVYzCBvWE5?=
 =?us-ascii?Q?lQvQlJ2A52bfAQw3ozFw+lcEVBzT7unHfXBrFg7mLK5EvQUOa8pO8UjjlJJg?=
 =?us-ascii?Q?UIOA5hxpS7HHs230tW7HGWW63aplhQYMkjk4UyYWQ0laAb612QaDasjjdYRH?=
 =?us-ascii?Q?z+WeL740I4j3xVXcC0M7bTBMk7NWvjVIDvKgDl9DzIe5Xkc+LsbQctPpoBrV?=
 =?us-ascii?Q?q0/5W57ISKGSF3uvMJSOdnfSWxIIVxfxVoPTRyzbJ6Ym+gYRuEVfzsu8Tozq?=
 =?us-ascii?Q?qC0L5Lay/efrkgxNhMK6Yq+IHg6S4gIq1/LDrf4t2iRQlscOSt6zrtYzZxbl?=
 =?us-ascii?Q?fuS3Ax5BFTcW0LpB2ZRt46H6PS0PX5rhDrFQ/WOiQjwwvTQ2veWisqlRSog4?=
 =?us-ascii?Q?ySLgKNxMCUX7KH23hGf0ZHqvDS8/3yf4+ihRgqmnutQDMMHaV9RZ7lPCPdAg?=
 =?us-ascii?Q?6zAiJTAJhy/fJu/H3ByZzhSULRFA57vFgKR5I7Ull//XzG46snbWHfvH4mbz?=
 =?us-ascii?Q?izt8HMiYmVvmrm7v9exVMpF3s/aUOsMxs2Obp2HLqgqoRaRgUnD6tUf8HYVv?=
 =?us-ascii?Q?nPnL9d7dWiqoXSqajDSXXxGEgA70hkrXxzVbZp2m0tK9Px3ZWO1jNrahSHwn?=
 =?us-ascii?Q?qeXes/DScPYWtLCU/+yJ91L3LLnbXaI0Prdzfulm1U1Y5AGPft3YFCfqNNux?=
 =?us-ascii?Q?t5AprxVjJRZf/c6WUM7ubRwRNCZez4u6+J5hfwn4mHNZzbmK7lzxz//6XPbl?=
 =?us-ascii?Q?UX7T4VT+CH3AaqooWIvT30giSFVwREvJqmjP/kJLIfxvGD0hv6/nkMjQ65Wu?=
 =?us-ascii?Q?VniaeDisB0bK21AhwV9QlAyYautt56IjPKck+B87YFQdj9mrPFG4x/g6XLFW?=
 =?us-ascii?Q?tZYac/qUYZT/Kbs/aKZQZsfHmEoxQjti0vnln2YznyxS6bfqSY+MphK8gK0n?=
 =?us-ascii?Q?kZTVUlPGA2I3/NHeQDFPYK8sbtMDUgAGAYL2REBGVQ0rPB+1iZ7OwpLjlf2i?=
 =?us-ascii?Q?vcWvOFahTXXw88io4Z/CCAYVnMEbggktyo3WB/QjTGxv2c1uE7oRYoh67g0R?=
 =?us-ascii?Q?Cr72+49H4KEZnXNnXVTf1EbB89mjIGZLt2z3n3dLUv2jqEeFQ/Ji74yq69qa?=
 =?us-ascii?Q?INHEvfS/RTxpC1QzX/wmG16rafgjtvp3u1cggHL679sgnWGDeAqRwtkZKdBG?=
 =?us-ascii?Q?cUJ6YHujS0N+Zx48NUKaq47NYYg58qJlTFusvCG2lRuy2OlHrZeIqohomK1o?=
 =?us-ascii?Q?eU6cUMKcjLfexDU5cJa4HlFwUMyrKnIiCQ4r?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:46:00.6647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bc42f8-cb23-4ead-cd96-08ddb2fb8bbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
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

The userq VA unmap requires validating queue status before unamapping
it, if user tries to unmap a busy userq by GEM VA IOCTL then the
driver should report an error for this illegal usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 534a9c98c011..5243512c9cec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -243,7 +243,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -252,10 +252,14 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 
 	if (f && !dma_fence_is_signaled(f)) {
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			return -ETIMEDOUT;
+		}
 	}
+
+	return 0;
 }
 
 static void
@@ -471,7 +475,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
+
+	if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy userq\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
 	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
 	if (!r) {
 		amdgpu_bo_unpin(queue->db_obj.obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 5e075e8f0ca3..afc493f43256 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1929,6 +1929,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
+	int r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1949,6 +1950,13 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 			return -ENOENT;
 	}
 
+	/* It's unlike to happen that the mapping userq hasn't been idled
+	 * during user unmap vm except the vm unmaped forcely from user space.
+	 */
+	r = amdgpu_userq_gem_va_unmap_validate(vm, saddr);
+	if (unlikely(r && r != -EBUSY))
+		dev_warn(adev->dev, "Here should be an improper unmap request from user space\n");
+
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
-- 
2.34.1

