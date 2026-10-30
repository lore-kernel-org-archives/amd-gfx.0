Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1CB606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QsQKpRRD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 480AA112830;
	Fri, 30 Oct 2026 14:06:28 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011009.outbound.protection.outlook.com
 [40.93.194.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DBA4112830
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 14:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UREjOpwNL8u8jXNvmGjbSHGhen32mjvJ7fK98hOlGDWJC2r6Ovd6BesZULFFdOKaxPcAqwClk8ig+ifmKiKgfxWjkFOs82olJKt7FbAXIZGP4QdLbsf/qRhbF4m0JQD6C+PDBR7aNqPktS7qiHgqE4gRCAWYNX5MTzRXTH6uKVXu6/JduDILqKo3heSGZs8feFLn0kseO4EOlVfCCNhWYR9zVcwFgHMkAfFioLbfDnB4CyrU/UF5IfnxPiqBMYbamCpqMS2nRUobDtY62yPhdRQI39o+ikNDQCxu/E5XAKtLFOH/a2XC5WMO8GX8I797fVv54uD4Z7Kj9i1DaYNQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAXmSCBvqOX8Kx5lLHAm91Gie7zNWXKaoedsnvTufSo=;
 b=mV5YMlif3SbtPvL6SlCgxpqbg0da+crq4P8nFj6ND6hMnON2sspDUSA+GfJOFd6H5lnvNZHnTe9eE8W9uzoQM6gxjZyKyt4mf7KkWkIv3KM388pXMEeKH8uNj8rk4z7DeuCKHGIq9Uuk7+MHBwtGkYImJCtSN78uLBYzQMy9XnZqmJRTVur3zHjjUrDtaeFpiuXNuUb8yx++Vipf3jP9sqjc/0LIj1dax4DGnKPqMy4f7FZVn/YJEvxp9eXQkSqFyqINoW6hYq9I5g5nHJAuFPtamUVIfK1l3UAvtF5B6n8mLpQYnWVEDilRPk0w54gaQZ6gYgO8KIX6LgQIYIxhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAXmSCBvqOX8Kx5lLHAm91Gie7zNWXKaoedsnvTufSo=;
 b=QsQKpRRDqTlGdWXk8M+iBoEvdHTa1aql87bKGhXQOVZAEgmMHpT+uC8T1bMb4f1ncrJ0b368IX1ODxZfd+ohQ1RD7IrU9EXThlVpIeLrkkasdwpKcV6ENgXWyNIBZqi7xqZ4tbi2mQcR2QHpdUjUY6CkHVB+hMZW8zBjatNZxs4=
Received: from SJ0PR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:33f::14)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:06:11 +0000
Received: from BY1PEPF000264B4.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::72) by SJ0PR05CA0039.outlook.office365.com
 (2603:10b6:a03:33f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.4 via Frontend Transport; Fri, 30
 Oct 2026 14:06:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B4.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 14:06:10 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 09:06:09 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v2 3/3] drm/amdkfd: Don't check for vm ready on svm unmap
Date: Fri, 30 Oct 2026 10:05:50 -0400
Message-ID: <20261030140550.2524662-4-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030140550.2524662-1-David.Francis@amd.com>
References: <20261030140550.2524662-1-David.Francis@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B4:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 9439d326-b613-4be6-839e-08df368ef350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: lay2IheA/P5RHcD8xpMeC3fBBdZmERScVab8IibUCzV7LRuWC8HkUS49SNE96nNzY9cZjZ1PmB4nKWp2y0FY9cwBuUTBvnOg8ovRXeHO+yItM8ZEUKGJu0m8p3rQReq2MCNh4wZ8DN321zPvfBy1Vj9lvBhKgJ0prUTVAxbl1TQC9Oeyl5wE3w8yxK4zTEtkH8QAjjc/wequVL53Tilxl2zf4e2ZLAinb5RNJpxIPjH8pkOzDf7nrGKGmRfQHbtJlMWspHKhPE5u66yFYwtsBkMGFkGgfMGswSHT1+SNIWLvv7FE/+wOayJqBIC+s+j9vM95D3jLS4lbFXJHMrWYTytE77SpjPF7YarAAar17YuPNzdxc7Y0L9KkLOvi4KyYXoMFE6hbwW0Thc+pa4ZTe/luvXW69EWccg02/VdUw14FBleMKLeSmg1Cz1FIWvVgwYh+ldTeigKy/pNic2bzqZB8JEEXNvpqbFzQyzPwEXgHc8VZP5PKj07qpTNMo5CPsH+iZ7F60GDJkDLEotG4boB+YHpmd7Rd7OkiGkaaRRL1zizl+nbz3BZ8A5tq5jSPZ16nkBrsXUInxJZdZkCLip2hE6ZQ1yGeT6w/inTwaUbejEXGjieBJyJXhWglibFAFVh+vhKVg9P1ZJbkAms+CDCLNpKmo+fBfFejCet6o9hs1CUQEnzyYLqxuhMDjSsrEyAwsWn3QeUe8zEa6RcmBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DD93JxMQ/eyEz9LpSxvH8pDupf51MgN2VZFMMRYhddTodxDN/RcpKFk4irXlddCXMYcoG8GCDZVYkYgdJ50F2Wotsh7PkLuay2/Z+bhcybEq+JlxHdvELtiUVXtnxiuW0zfzb0QCfNDCVxYmp3QpknEYFEtIzKq7M1yhyChaYwzUeKvVva0yRx7+4waEYSz9j8OUZVNLUkKMD9iVuG1uDD3k7jjy3XG0z2NJOLB0nSVo/jX7c1AS4n5qx6E58C55zOcUmS3ou2YaKOCkkilT4Sy5yrWsb6kCuh/EPBwmVYVqHMZBRC5cGHKnZPDzUscoNWP0ttxm9QlP3joOL1OEhcvJeWfvRZx/jM238pqCLeIPZvFf39sV9tWZvyCUGv9A+EjbGcEfQ0uJMSxDQSLX0QiDoxm816PuVx6NCDDUdoDmYRoZp+7fHh8RwnuAtl/t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:06:10.4657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9439d326-b613-4be6-839e-08df368ef350
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There was an amdgpu_vm_ready check in svm_range_unmap_from_gpu.

This is improper, because
- amdgpu_vm_ready checks for the vm to be locked, and unmap is
expected to occur without that lock held
- amdgpu_vm_ready fails if the vm is in the process of eviction,
but there's no need for unmap during eviction to be an error

Remove it (and swallow the -EBUSY error from eviction in progress)

This change is necessary to avoid dmesg spam from the vm lock
check; handling eviction may require additional checks

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ed5e3318877be..4c0ccd585ff8e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1425,6 +1425,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 {
 	uint64_t init_pte_value = adev->gmc.init_pte_flags;
 	uint64_t gpu_start, gpu_end;
+	int ret;
 
 	/* Convert CPU page range to GPU page range */
 	gpu_start = start * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
@@ -1433,14 +1434,13 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	pr_debug("CPU[0x%llx 0x%llx] -> GPU[0x%llx 0x%llx]\n", start, last,
 		gpu_start, gpu_end);
 
-	if (!amdgpu_vm_ready(vm)) {
-		pr_debug("VM not ready, canceling unmap\n");
-		return -EINVAL;
-	}
-
-	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
+	ret = amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
 				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
 				      fence);
+	/* EBUSY here means "vm not ready for updates because it in the process of evicting."
+	 * If that is true, it's safe to not update the range now since the vm is not in use.
+	 */
+	return ret == EBUSY ? 0 : ret;
 }
 
 static int
-- 
2.34.1

