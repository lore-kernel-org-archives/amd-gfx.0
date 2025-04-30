Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05830C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 13:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8E010E32C;
	Wed, 30 Apr 2025 13:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mQqDe1SR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B1F10E32C
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 13:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1AK0r+54Rd4JT6DJhvW/UJ/C7ZsLlQakUypD+6nIo36xN3ZqtebcvwfsmW0ARGMMpgcf2mPE4AYhsaimPul3R/aOQz3OgjKA1Ybw9HKMgIpCiv6LJfWgmQXBxg5M+TA1gYGdQXEcUGnQhHckVD9AYr8WoBwrchfLcNOm1j9uiDDDGjVwoUgP8l9kIYuV70uNJ9tShz2OUC1zTlkKlAwckLfndOZhfPY+6LUocVxzMY47W2NN2hyFGpWxINVJSwYRqcZOnIYLYbqrDzCgRFcMxsZQti/8yoLGJK4UZuFO8faDGELMFE0X6lamdM3HwBP1bs8PN1aZamV8gj32VIxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGgDYpbvM57tOZNJ5Snq0EBqxlpf3lrRU1HJsKkHY60=;
 b=JdQK+rN8y6/zliMf+3od7i9UQho8JCglzzl2e0mUYlHqddTXQQwdMkE1lg2ctxi5Uo3T835T1UI/yM9qIR2e9Jcdqe9lvvVWeztpbsJYYM/N+EU/00fR+LcTyuIWlTtIEMQ3WJ08PVioa1lUYNRkNk9ZfQSgdBAMw5WHvN14co8CCIOQ0zMGJrwVW4NVAphuxEcBh+c5lSXvMRDTeFlDEZ/3hAWOZraGqQLwfL9eV2VUIIZG3el93Jg220grDt6/zIhxT9HXgS2TLQflbFWGyDRd4I8Q+9YovYKkHiZKVIlyhO5bOQMUJUjIOZIyXfTBBhJn7C3Rco3OVBDC1UhYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGgDYpbvM57tOZNJ5Snq0EBqxlpf3lrRU1HJsKkHY60=;
 b=mQqDe1SRjbBBK5SqBjzlnu6XCtb2965LsUYSdpw7LsPmx9q/d/1zcutAsgyEsXrvWv7EZpyGoPT5zkeSH8UrXLo1v5KTg+UGTRis3N8QGzk77UlYrySCWlezwI7HblgSAHmcSaACmKyBaY2/XRZrrffy/doVxaN83qc5czJGmyo=
Received: from DM5PR07CA0051.namprd07.prod.outlook.com (2603:10b6:4:ad::16) by
 MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 13:34:21 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::49) by DM5PR07CA0051.outlook.office365.com
 (2603:10b6:4:ad::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 30 Apr 2025 13:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 13:34:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 08:34:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Arvind Yadav
 <Arvind.Yadav@amd.com>
Subject: [PATCH] drm/amdgpu: properly handle GC vs MM in amdgpu_vmid_mgr_init()
Date: Wed, 30 Apr 2025 09:34:05 -0400
Message-ID: <20250430133405.2592112-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9f4cdd-e230-457d-b47b-08dd87ebb674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1A74mAwLjkorsZe5V57W2pOi1fdoGlyLOMVpik8S+GlojjQ/1jYlO9lhsfJ3?=
 =?us-ascii?Q?7hOXH0S5BU+25frwzAplhP085mTgMRvX2z0s5KuUr4Yi1ilsgqbBw8Yr0pSa?=
 =?us-ascii?Q?O6V+HhUj+YxnLYTjGzW0j71Eo0eeTBOTMH+yda/Rs0+vT0dezwPSEZXicidi?=
 =?us-ascii?Q?3LzDhFhLySTZ0jx7eXTAsGrZ/n0quC1MvNvMLsc4J1ek7u56K5dRxwa0q6O+?=
 =?us-ascii?Q?s4a4hyKhpeGj6sZZe0ijg5orNQncx6nU28WLuW6vJMEayhibgCDjfetH28KT?=
 =?us-ascii?Q?nrOCGVp6HnPd+fTImf/M6di/lYh1c/Slm3C1m7jRqKFpfHHycc7R7LzHqTia?=
 =?us-ascii?Q?aFS5aTV+3FrirMjUtMf93QWcQKde2bYHcaOzN+WQ8IdDYKJR6JD0wVaPDUV+?=
 =?us-ascii?Q?pCP2H2GttrwVxV/dfpdwKzbIIpirweNk9pL7HupN9gBc/dFQldMQ5AP2DUKP?=
 =?us-ascii?Q?yZ2BN0pVmnjZ4LrEzJNsG1qf84d9Ax6LEXBFbahPlc6vM5a6/39lwMD+9I9X?=
 =?us-ascii?Q?ci+IBF4OawhivztGOs4YeU/Wf9znju344jm3VL3xT0SHmM4RRC6H5wEq8HTq?=
 =?us-ascii?Q?RKvQ+I6Hy6jIe6RSE9ZHxbztGvzowBdjUv2amH5HsdeCdAjZLWndnatDJBLe?=
 =?us-ascii?Q?GcaleXLZ8b78rNr8z7bUSgtSbY9eG+YfjlDkmWyP6sTHX2D7qKOyV9t4cbU3?=
 =?us-ascii?Q?wbHzO48YN+BTqaM5HZt24NTvWAIpvUHDJy2m0ENoa0MG9FdITMxERDa1jGSg?=
 =?us-ascii?Q?67o8mTn6fRRKZmasFguhitIfxf/FOij3uosbAl7ErYfAPBid4Yje6HS73R6s?=
 =?us-ascii?Q?zdNrv8nJukxtw0mALJr1pikZF5sYAZwqG1eGb8DOzsNMBPQSqbS+xcLboDLX?=
 =?us-ascii?Q?zyltUbiSOVCYmz9BKpQnAX7tIfDhRy09sYJYjbZM1txYMol9G/5wUdJQo0ov?=
 =?us-ascii?Q?ufwVsjqnqgE2KBN8pFv2aBkolipPmdvMaFqNE7eIk1fGsmsQvEq3Xb+ak8w5?=
 =?us-ascii?Q?B6qzgtZ2/n5Tkioqt6Og63CKSVFXdBgs+BH58b2kBZhdxH5jOrJSJGl4T88z?=
 =?us-ascii?Q?x06byikASXUCA5791CFEu3FqP3XdEX06WAnFe0Nu+Zwn++CHKVzjT82tFlSv?=
 =?us-ascii?Q?4c3iV/7twjBqDMIWVlw2rqnokxxqZLDqgLr7OJLT4mFDhLKEEM58/dsIQkrQ?=
 =?us-ascii?Q?9OkoL1sBhQgcQ/2hK5vorgl/kJs595m3zaIUqwSHK0GHS/bojpLUdmJ6BTtZ?=
 =?us-ascii?Q?e+XH5V+nNrdRBG+ohg3VUdRgs8IVhu74CHnaQOeIHcbbcC9F8e6qBDnGnBb6?=
 =?us-ascii?Q?1LE46WoAE8/KlXnj5Trwd4YuB32nQUvkztBPm5tC0q9uwEuqrO6B2anV8JIB?=
 =?us-ascii?Q?kiCnQV0dBKkyGN9ut5LzMLdY8J1gDPP23UTGjCXO2eHmiyqAaMTEZNfw3Mrj?=
 =?us-ascii?Q?tmYbaw+G1k0Es0Tmh6a20C7ZElSckl3Hl+gDpzZEMw78+d5runM597tw1FVs?=
 =?us-ascii?Q?qhSGPKkX8oT7FkogM5xprju6IYqzyuSCS+aJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:34:20.3815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9f4cdd-e230-457d-b47b-08dd87ebb674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913
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

When kernel queues are disabled, all GC vmids are available
for the scheduler.  MM vmids are still managed by the driver
so make all 16 available.

Also fix gmc 10 vs 11 mix up in
commit 1f61fc28b939 ("drm/amdgpu/mes: make more vmids available when disable_kq=1")

v2: Properly handle pre-GC 10 hardware

Fixes: 1f61fc28b939 ("drm/amdgpu/mes: make more vmids available when disable_kq=1")
Cc: Arvind Yadav <Arvind.Yadav@amd.com>
Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com> v1
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  2 +-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 359c19de9a5b9..5dd78a9cb12dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -576,8 +576,16 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 		INIT_LIST_HEAD(&id_mgr->ids_lru);
 		id_mgr->reserved_use_count = 0;
 
-		/* manage only VMIDs not used by KFD */
-		id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
+		/* for GC <10, SDMA uses MMHUB so use first_kfd_vmid for both GC and MM */
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 0, 0))
+			/* manage only VMIDs not used by KFD */
+			id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
+		else if (AMDGPU_IS_MMHUB0(i) ||
+			 AMDGPU_IS_MMHUB1(i))
+			id_mgr->num_ids = 16;
+		else
+			/* manage only VMIDs not used by KFD */
+			id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
 
 		/* skip over VMID 0, since it is the system VM */
 		for (j = 1; j < id_mgr->num_ids; ++j) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 7648e977b44bc..a3e2787501f18 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -896,7 +896,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
+	adev->vm_manager.first_kfd_vmid = 8;
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 7f5ca170f141a..917d894a1316a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -828,7 +828,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
-- 
2.49.0

