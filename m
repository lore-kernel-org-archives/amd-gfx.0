Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D32D58B11
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Mar 2026 06:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC00510E00D;
	Sun, 15 Mar 2026 06:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LHnYjUEp";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A527C10E00D
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Mar 2026 06:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m29b4rabpWCCyQuX0gy1cjSTWkUdPNStVQomhFqRIfoh0skrnjBHoYaGXFFtWFmer+2UgRpL72p5Pwx8bTLNLcjYXto10u2Ifb/IUSuVLDrKKk7hvjR86sypTdN8kaLtYbVIB49s3xG9PgDhab935qCOHFHrsEJ5lZk2kzgvtvTQNFaZPH8MeFPy53Nn2gl66+fNRTkdBL2+aNrkpl530V0R3VhixD7c3LmEjd/7UgUd+zR/4nGlnvswDgaXkAyG/w4vnMljUOvbBLTARQMvgSWlS5VAnR0Jb2uu4PI4zSFrAfBE5+TjuhKJtby4M8nZGi8IdVOXaatyKRMMetpe9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCh8QFVUp5jdcuN3aGBEhfp+AutD888EnoH7s9/v9Rc=;
 b=bMf2w+m/xNaekjF52vk5K2md7Iexbyw9Yg3HKe0Pz/VnAyAtrssXpplr6oBYT6uDWg9kp/pRWvzL05GqYnEGinI6AfGAFcTJVxeegkU2y3gf4ETjyLxYoyXROVixZTvxCuVhG4/d93/boZq3nEoaCodZZmbdR/2gu5rC7E5JT7CroYJGw1tzxyXFvkx9gDkpbG2ssnWJxA36UtiPAdCKXVs+E84ERlBVlQKfoyVCS161B28KBdf5Mlev/PkIqQHHUKPOkQs+8ZNkG0lXWJw+MPQ45I3P8KRBtxd9c972kBaOQsooqOZfplOz2Zuxw6JWxG47El7VeFf2OItnZO4emg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCh8QFVUp5jdcuN3aGBEhfp+AutD888EnoH7s9/v9Rc=;
 b=LHnYjUEp9PmWraSpnS50k0zLf+xh+TnCKbpVi/eltVGUsAHWvAzUtSVV5vMz1H+pPuU0o9aa5BWp7iZn5J2FqheR72Ox0wNYVPcGwT5mc6tNNNYbYjdsIxDkx1m9ahVFlPgY5W6tUGNCfpowHX9GXLsi1WSDTtTkKR/43JhuWy0=
Received: from SJ0PR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:332::14)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Sun, 15 Mar
 2026 06:55:44 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::fa) by SJ0PR05CA0069.outlook.office365.com
 (2603:10b6:a03:332::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Sun,
 15 Mar 2026 06:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Sun, 15 Mar 2026 06:55:44 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 15 Mar 2026 01:55:42 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: Make emit_vm_flush() check explicit in
 amdgpu_vm_flush()
Date: Sun, 15 Mar 2026 12:25:28 +0530
Message-ID: <20260315065528.1932950-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: e309993a-991d-46e7-64c5-08de825fe128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: /2cDRbikW+l3YZWvU7/RILGnKBCpiwbEYFOODgztw425k7nHnvJWhFn6XN8qRbezHsGVYWz/t8kue+ORWWZLMJhxp8sd/T/WuKD7hqltUsyMZvJE+JGJKetzrWiuVU2zFGfNaowwCC8WXvnem4IcPjq7AF4GieW7J7RJMf1YzlzRKHE5PBWsmmBXb3IpcSPOZt2gonsOrsPDBX0NtOL8qpKD1ZArAo26ld1c1vU8xHk0fvaJVuSG+Rh9xlhrSM33ZcAtIoo5wdPZbsRqSK5gfyzqAArUYAzH83f1+40sPiCCSYn3O2o/4ylDfFa3brqLbQNJ7apGxN6yRBz4MRhx0EdWFyYAeXYzAqp/K0MxxvTuhFWPNZk9sjB5POMD01+IIHXBge0Z6A9r25yclLi7qN2IpsBHE5P0kVWLyAyTh7abFs4NG19BnCdaY0qe53JgSsJKHC8ZOmZdgjmDYwYDRygqiS8oPqqy5IV1Km4AEEOpaq3j6yEfYDGTg3RChPHP1R8Bx+wwV18gGSMaIuLsXpvw+5zq4qThJpdQ386+PBJSDS1IIt38oc8kZacqJenIWsfORoJgRdSHudC1QvvTomYXx4TDQCs7QPxKpB4A7BW0zB8dJrsuxEnYmcsi/hUz/sqr2PFDM/77OW8lPXXRBypmm55Nmq7rwb5p+khtWmgw0emmc46GU8tDztEt3aVRCdXksDTmFr/JjDkb3YXeAep8l5un+Jcu/WyZf7GVbs8TE+9CNvwCJQhuwh27f9VKb6y/BKySKlqdXHio1fojWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6GzAss8P3MoDn2yDXA2jtaCzVsKJC1P8tshtEgZ61xpAqsg5Ici1/kZIPPcd/WIaHh2QO8APSgB5d916D/L+ia03J8rCp+ADOQJ//8UT0deexgr3NSTqRhwAmkVdWE/gY6U3LcTXppSgg4AN86DfHWXT7osdU3CYLURgJQkOviapoZlOEgculURhQVMVOOUwumJuGu6fw5mhVxTCiuSe2wwZ1oHkyedpWeGkoN3sNKZ2cwN/DoNcyMeynHOqu0VwUkgX8iNrjHsaQkVB/AyQTJxwtaScvKfrq8XOT+tGuL193oHZwmhsVSy1Lwdfm03XVxyulDMvoLzHB36k1NJQIQ0KYlVb/210CHSOzOkczHAK3yJXfz3sbDdo2VCIDgLcXaMtT51HWN51mnB0rJF5I7HwAlx19riCyv6etIux+TV3n4I58Gl74SSjO2PzMwZC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 06:55:44.3466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e309993a-991d-46e7-64c5-08de825fe128
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
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

amdgpu_vm_flush() sends commands to the GPU to update the VM page tables
for a job.

When a job uses a GPU virtual address space, the GPU needs to refresh
its address translations after the driver updates the page tables.
A VM flush tells the GPU to forget old address translations and use the
updated page table mappings.

This flush command is not supported on all rings. Only rings that
implement the emit_vm_flush() callback know how to emit the correct
hardware command for this operation.

The function already gates vm_flush_needed on the presence of
ring->funcs->emit_vm_flush earlier in the logic. However, static
analysis tools such as Smatch may not track this relationship through
the vm_flush_needed boolean and warn that emit_vm_flush() could be NULL
when the VM flush command is emitted later.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:826 amdgpu_vm_flush() error: we previously assumed 'ring->funcs->emit_vm_flush' could be null (see line 788)

Fixes: b3cd285fa68d ("drm/amdgpu: update the PASID mapping only on demand")
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b89013a6aa0b..cc79cb7dd4e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -807,7 +807,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (cleaner_shader_needed)
 		ring->funcs->emit_cleaner_shader(ring);
 
-	if (vm_flush_needed) {
+	if (vm_flush_needed && ring->funcs->emit_vm_flush) {
 		trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr);
 		amdgpu_ring_emit_vm_flush(ring, job->vmid, job->vm_pd_addr);
 	}
-- 
2.34.1

