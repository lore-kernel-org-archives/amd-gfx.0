Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9359C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 23:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA0A611CE
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 23:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7FA0A611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09839739B2;
	Thu,  4 Nov 2021 23:05:45 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D68B0739B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 23:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1qSXgBdrTPJoRbQkM6Bs1lG8MSS1H3p3dP/uY/1ri3OZLeFvct1amgG5dhFxHyMBvxzddfp+q7xoX/5/ykiEhUAVcjVJxT4D8gNoOrYxC8EiTW6eYGqVknXG2i8xg1zYCy2lW1NOrZRxv+BstOmjqMFRoj/2o2PqXvQpClYP5LxOa3mpHCrJPS48Ik4fP6TJuTRnFQX0Ez+55SsRqZI6YwD8eOFtSj4zrfJpiz/PamU1LVjHVX7/k9sEpEZFY3cQXkxVl59YCS1yLZIfQodY6x7ZYmGLA5MyBIOkOUREM0emlIDm0aZggg5cnnQIKWeb/VlPpJuhAoZyuX16MH4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvhMmJ8PwRCD+Yi1gxuWNTBOrxCbQvCNpJvxlSlO0+E=;
 b=IN4PK10vHnlOiQDIy/2jFMcBG/YmqKAmRtieb2z+eb1ErqUrUiFVCc7kHg9fI9/TbBue+BLP3852fSRiUvF9zNeySfR9SNSX74g7gcWtR4RyJ830LmcCJ+WfT7+KsOAcdkMM8AjuZfDerEnyJKpJ03pXIzo+U4iYDNZM3EDmRLLjul2MdR9iLvoT8EipIXa1w/GjfcNo8LZekmICU1S37Gg+wQIPEoJlbpI/FAo1+x+QAqc1j/0tIserQXBv/4QgM9tzQSmftcyKBssXsQHOc4nyPrrULA7jhB5LjUfK2qAzc/15zpolvOYFMFgNqId/QTCWpjhIcMsugT9eNUMqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvhMmJ8PwRCD+Yi1gxuWNTBOrxCbQvCNpJvxlSlO0+E=;
 b=ZLwh9vYK/5cXlWS3fOVdQK5naxVWZGPm9CLQvg/Jb1Jyfln4Ff1BMRcnpJZqIi91JeZm2EAE4fvIzHsW5H42dxH1hEiKA+UaGdTDQf/pBTPtomgeSoE+7Lgru8tpxhiwstZOTSVs2GTTtJc6qJDpZRwnHADQCFZm+QdqYZNKoO0=
Received: from BN0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:408:e4::10)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 4 Nov
 2021 23:05:42 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::3b) by BN0PR02CA0005.outlook.office365.com
 (2603:10b6:408:e4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 23:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 23:05:41 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 18:05:38 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Fix dangling kfd_bo pointer for shared BOs
Date: Thu, 4 Nov 2021 19:05:13 -0400
Message-ID: <20211104230513.1531770-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44015bf6-ce1c-49b1-c265-08d99fe79fc0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5088:
X-Microsoft-Antispam-PRVS: <DM4PR12MB50886CA29C8C98A68DEFAA81928D9@DM4PR12MB5088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxtMknzMrq97SUASBf6sNAbvbqCuwfFYzuCOcIXIX1DBPJNjl/gb5AFGgwo/rPd4TmyMVI2yUcTZ5eoHB2ufnpjgOl49pKx7RKbZcliZvHOY0soLSJOG3yQKDaFYcG/ek1LbcaoNfz71eSRpTIJbnbVe1rtWi+M5idVrJY/2R1N69NrNX8QT9DeH0zjcVCtiw+AQTNQihALBjkB3qY0S44Opsa1+C93HZ0e3ludzFVRmnapIvoUfVQ6YUiJdXVdZxW9/zMQgwdcKA4RgSyiHVcJfOXktIMbXEToieZQV5BRX+kr5WCAC7Ej2CquViXx9f3omGoBlCI69kt3Wc5n3AiwqxCbGJvwHnqPCzFlVSCIkOVmvqbUqP7sf/YP5OPQ7VcMpQzl0OPL7LtOJxTf0YDxp6hv3ysjXTI0hfcBzEtio8Fl5ThqpdCQ4d89Jw86/bQ0d2yf5sOc+wDuXi4cvyfIdjolcHK5B17Y6lrcXGn9jNRaaQDWkM83p/Kb2uEMQvQ+OqVbmEY0uKVOmjyGf+8hjEIRkiG7Nz2OWrRmzr1ruhXTRkmisSgmKY9maELs2fPuiwonnXBRqDnFL6ILrIxTsCMAyHAKIADXS15Q8fMFPz8co7u2AI2nQQ+hCbwel/LWmxX+Z8kJl3xov/QOVq/iA1TdqG0QLFkeKerGI6DatgXZvpLZflzaf0l9Qa16rJylQuhE939Ht6JvOa0TyxORfb5Im26u14Ot3CpYFxGY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(7696005)(70586007)(6916009)(81166007)(86362001)(70206006)(336012)(36860700001)(4326008)(356005)(36756003)(316002)(426003)(16526019)(82310400003)(186003)(8676002)(508600001)(26005)(5660300002)(2906002)(1076003)(2616005)(8936002)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 23:05:41.5657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44015bf6-ce1c-49b1-c265-08d99fe79fc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
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
Cc: ramesh.errabolu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If a kfd_bo was shared (e.g. a dmabuf export), the original kfd_bo may be
freed when the amdgpu_bo still lives on. Free the kfd_bo struct in the
release_notify callback then the amdgpu_bo is freed.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c       |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4accd584886b..5f658823a637 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -307,7 +307,7 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev);
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
-void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);
+void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
 #else
 static inline
@@ -322,7 +322,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 }
 
 static inline
-void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
+void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 {
 }
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 5174762f0b46..94fccf0b47ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -201,7 +201,7 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
 }
 
-void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
+void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	u32 domain = bo->preferred_domains;
@@ -213,6 +213,8 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
 	}
 
 	unreserve_mem_limit(adev, amdgpu_bo_size(bo), domain, sg);
+
+	kfree(bo->kfd_bo);
 }
 
 
@@ -1599,9 +1601,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
 	if (mem->dmabuf)
 		dma_buf_put(mem->dmabuf);
-	drm_gem_object_put(&mem->bo->tbo.base);
 	mutex_destroy(&mem->lock);
-	kfree(mem);
+
+	/* If this releases the last reference, it will end up calling
+	 * amdgpu_amdkfd_release_notify and kfree the mem struct. That's why
+	 * this needs to be the last call here.
+	 */
+	drm_gem_object_put(&mem->bo->tbo.base);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6b25982a9077..156002db24e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1279,7 +1279,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	abo = ttm_to_amdgpu_bo(bo);
 
 	if (abo->kfd_bo)
-		amdgpu_amdkfd_unreserve_memory_limit(abo);
+		amdgpu_amdkfd_release_notify(abo);
 
 	/* We only remove the fence if the resv has individualized. */
 	WARN_ON_ONCE(bo->type == ttm_bo_type_kernel
-- 
2.32.0

