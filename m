Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C6DEEB560
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 17:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7765B10E0B1;
	Fri,  8 Sep 2023 17:46:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E7510E0B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 17:46:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2NAcEJ1nWsacT4vCmNIdFFBc9abP+pI4co0io9GSjVheRtGkfgeW+8h2+1L359+HJNXwk5fA8RbsgIpTAQFxqGtL/EN4QcqxrEz6+jbSsM/FXMo5DNaysdTgE9giyVwd1l7QnkgBmd4uAYdVd11LxU1Y4nxVR0wAKxS8kzFO4Rles4XiymTi7JVNf4OtX70GMLwnYapkKoa5pT4fqB6GChjmnxlzu8vkq1aR/Tjb0KvBhgj6JGpLKMI53zwfbB+MedaacVPkEw689lUxowd92hLoLN25BfIyC/JDyalCNX7fTP+rho5oJa2uKN982iN2sd4YXJWxmkhCT1CVffdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5cE8yU9cZfv4q9GBpDQ5GC4UAofb2fVFmJNc4z93Y0=;
 b=ZQdwJGsbEqnAs5OXvo3Q/UZ+6hT/dQKaJ3rO+5CisiBIeKalx7mNyI5piplZOY9rYulAlUsvacY077yNEE8ZihjGvd6pHNme8nTRwjaIsdbZSdBNHDGJU1Wvn6z1tsjsgW89gNYNhoiJXGXQtEPSEwIjaAmLM6IHzQpul4JgXKT3rSJEOwPwWIo9iGQfFH3X1l5iF0rYDGBcEOCC54atL2+5rXYZ9s1s55QDtMkqDJsbDhOFboqupcr5hoP6ObtFHn1aVpzSaMsvGkevwv+n75JQ5H7x29OcW+vrwkJhe7qMWJc0k77+vrSJ61+lV5R2QbG5YGCW6V+o5kInh+OmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5cE8yU9cZfv4q9GBpDQ5GC4UAofb2fVFmJNc4z93Y0=;
 b=lHXOV4z790iz1PtXNYQyP/Oxr9yUpju0VUUImtoCD2gos2iBErAy2f4fQPAK5SAxkLJmdQIfW7jQs9OBPJEVITSePdTtpREDagoEHrBlFfQfmqMJMCmt1Enk2V3Tz5ldLpdA17ACS9rt39Rd6PPaH3Xq6B2zIQ6mZlfGwvOTp2o=
Received: from CH0P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::17)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 17:46:51 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::4d) by CH0P221CA0034.outlook.office365.com
 (2603:10b6:610:11d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31 via Frontend
 Transport; Fri, 8 Sep 2023 17:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 17:46:51 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 12:46:50 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Move dma unmapping after TLB flush
Date: Fri, 8 Sep 2023 13:45:48 -0400
Message-ID: <20230908174548.21591-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 08bc44c3-1169-48cb-5dab-08dbb0939552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjNYo88eAQ8BnfJUMEP3YWJyDjIaLNkatotYLgx8LLMvGeUQeCwg7j7XtWgaK+3bmkjBjb7cE5m2qqeKuZji8pAR8wCe4vEvO9pQtRXHaVGeEWVz4NZ3+XURo/4UQKuGdrF0OIbaWpOJHQE7ZAvVoa2E8C0d/H0ieMnV+ADP+iZtC8UvjZ5/lq4+IvdvsIo7RzfcZiHyaNav2pC99ZhS+CV+KxEehV7Qc2k2KB5Q2Y5ndEvDahcCU7a71S+oYrsatsKvLDLSl+aoglzcJ4o5rXVgXmihmIwdk25olu++9fJfZB87S1sw3tlkE7OwpMKWcYYtvioWYsV630bYoA08v7725PJxUW0EzF59MgviWsYhYx49D9I17lwz4i8SW+oYLJxWUc1UM0fR98Js1VFsayDOItXPN8uwVrLVdJs3/Q/EHD+/Jc36PYf3ZF6JglNSKAb8go7PIhWyLxubQjyqpnkhIratRVQJ+lntjOUnt6dQ+zRcQ+i8MeN9QzSWfC2+hcRS/eDyqErpHnwJesLEDKwcpCWD5kMnoct36VjpW6a0pGKwIJL0NqO9qewsJ+Vq2SCh0N4H4ic4xBKSwZuIhQecVZUw40hIVYHmJgUmwTfzki/r172j986fY7EmRy1zhsaGP7YgiXhC2khGZ0bknJnc+OYSkoEZzdroE0uKk/8wa9dxb2MPzxpC40Ny1NxoYERgLUJbw2lR0DiuLPhhr9IweKJ3XGX5NmnUpJw3euQ0ccLMwXCHJeXzxEK1oQG1rbSJ85TEnvLTuR5OKGZPJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(8936002)(8676002)(4326008)(41300700001)(6916009)(54906003)(70206006)(70586007)(5660300002)(316002)(2906002)(40460700003)(82740400003)(356005)(81166007)(47076005)(83380400001)(40480700001)(2616005)(426003)(16526019)(1076003)(26005)(336012)(86362001)(36860700001)(36756003)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 17:46:51.4160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bc44c3-1169-48cb-5dab-08dbb0939552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise GPU may access the mapping to cause IOMMU IO_PAGE_FAULT.

Remove dma mapping before free the mem attachment, to fix potential dma
mapping leaking if failed unmap from GPUs.

For queues restore path, because FW already flush TLB, it is safe to
leave this unchanged.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h     |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 18 +++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c       |  4 ++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 559f14cc0a99..9a1f8d09b1e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -304,6 +304,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
 					  struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
+void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
 int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b5b940485059..3c566050bed8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1249,8 +1249,6 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
 	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
 
 	amdgpu_sync_fence(sync, bo_va->last_pt_update);
-
-	kfd_mem_dmaunmap_attachment(mem, entry);
 }
 
 static int update_gpuvm_pte(struct kgd_mem *mem,
@@ -1910,8 +1908,10 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		mem->va + bo_size * (1 + mem->aql_queue));
 
 	/* Remove from VM internal data structures */
-	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
+	list_for_each_entry_safe(entry, tmp, &mem->attachments, list) {
+		kfd_mem_dmaunmap_attachment(mem, entry);
 		kfd_mem_detach(entry);
+	}
 
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
@@ -2085,6 +2085,18 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	return ret;
 }
 
+void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem)
+{
+	struct kfd_mem_attachment *entry;
+
+	mutex_lock(&mem->lock);
+
+	list_for_each_entry(entry, &mem->attachments, list)
+		kfd_mem_dmaunmap_attachment(mem, entry);
+
+	mutex_unlock(&mem->lock);
+}
+
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 08687ce0aa8b..fdcc55e324ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1443,6 +1443,10 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
 		}
 	}
+
+	/* Remove IOMMU mapping after tlb flush to avoid IO_PAGE_FAULT race */
+	amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem);
+
 	kfree(devices_arr);
 
 	return 0;
-- 
2.35.1

