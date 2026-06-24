Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A353ECDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 13:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 118A110EF36;
	Wed, 24 Jun 2026 13:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3bqVEI8N";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A33810EF24
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 13:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBUH4HaOg+31njZAYWeJfIId4ikcXvUxZgsUZug3yEBfYiKv7X18R28bHyIRU77Yx47/eH4OQBlsLUmmFXHVTCAUMv5YAtdnSKRtQuxd6XgqyBnafeSGHmlaZ+7CVAYV0Pj+QA6CmvF9OA8xTM4Xrr80V4OHFUCaRJYrZGKyBPgUOErs5bIdAYS5ZX5jm9bVmTTr2hMH9nhXRzlYEkGrxMqucMOgnizZDVl/G4OLsqqj/6EqRkKby/57iAcCESbXFzhQbJXMFZVrdHvLa07ycsQwpT7FtKPgj6Ra6lf8BM1NsmU2ft0r5hDiK+kLh+IWgCkxMKQSldnAsugW5hwGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dc6cAhmW+K1PddLVA7w5GLsi9gQATinafwEeoSoUqgw=;
 b=KUEdB8MspNOFs5Vzb4RbHM27y0zPjY0c8R3uVD3HlV8HzRvMRrupy4lYOOHY/Bc47qcinuIzg8p0PA7BmT3R/zio5xNDlcGd1pSlwsO0fLpVp7wsVhHtTu7d+gSGmfYpYWyiXWd6qxPLgYvg6pkJzpV8RdxBd+u8RCNWvKcRavHcrEJlmrA7Yx6wmacyf73DhKjmtTiJO/VzLyzB+Xc269sbFqyXP0gpqyXbW0CTa8jUVgUDqf8rwercfRuH8xTI8nAuVNCsNoyMu5SkmZaksKzGPJ52gJZdWysju09mUV9gRvMTSwgDkpgo90smepOxXxvH64QaZqLgwNcliZKSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc6cAhmW+K1PddLVA7w5GLsi9gQATinafwEeoSoUqgw=;
 b=3bqVEI8NUGOTvM2V4ZOXzflQdVCB7YJL+E9dWn22x2dTBXBC2GXEgx5rrMKnuXJBoZtcokWWeTCDhEILSv5VOVbWipPSSYA5tvcIrjsJTQFjoBywCW9nVAzlkVoaHV+uY3JtcsWy7nwIxcmB+3pu2wgiFnmiNK0ei0VWLNLaTzE=
Received: from BY3PR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:39b::28)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 13:35:26 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::15) by BY3PR05CA0053.outlook.office365.com
 (2603:10b6:a03:39b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6 via Frontend Transport; Wed, 24
 Jun 2026 13:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 13:35:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 08:35:24 -0500
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 06:35:24 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Avoid topology_lock in kfd_mmap
Date: Wed, 24 Jun 2026 09:35:11 -0400
Message-ID: <20260624133511.1080985-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d3a1c8-36ac-4a72-272b-08ded1f5724d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: h2Jy2I2h5ccEm0WHDZrWlkZAj77IwVB7DH24qmYRfI+4c25xZRelkJYMOCtVGsCwaEJYK5c8MvwzXTwq93zOkaVaOHi+0MdebGXOxBR7NsgEElqtakZTAKSEP6R6lsKtvbuznUJDKo4JfpQY91eTWeLgarYJojdJv//9U5dAHMpMZVfi8iExvD2eaOcK2J4d8+1fkPL1PyAEgGmootZAV90Z2mbayLmifUq0t8QW4+ZptMk1GMLSM0O3dcyHXhhm/itsqJ1m3bQ4+f1IiLhaZsAzOfLermw51kRmoKuq1CAy1gOg6gmnQXmzC4n6dwI1cxtY81AKmLLgM0OxMLOjJvpfBnT1YX5ctoPE/LbtPEAGJsoOo9mJj/1lHzoh5A7W6c5mTfxW/6LbPgSnsY49H3IYAQprPxqdmRRYjLO6E2k7ML3O4BJmmjnPLbwCqN8QH5zXEwLnf5SyvDxE2fu2hHXOAdCZnRy+BPXuR2hRT6vCYCdtk0anPtR0ZxKgO9Q6gXZ6GqAUvlGn5hbDSJONJSeugIhpxKekUUjYCF1UKHmPIVknPgchFydJkjXViuObRm7OMt5psL9r1s55iTIvU37qTOM7k0STs3b8BE2YeGyXmwGhgiMHiA+GNvmA+iAP7GIz3CepMtr0DGbZUpBPGqDdfRxqltlaaVqXn2eQE+UaliWF6rqlGga1r9S/oJRHK35Srv3sgratmiMFOKQdrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M6lJ+OT2NS9l9GW3Ys3GCAdO9nCwCXm2eYDvt2Zza1bmmX6erOuNeZXp3JwhjMha/fi8qaCjSnYL1/7CesXSrz6F955ylhs93slbpwPKFfnk51vaW96JIkiiXL8fqLYMTI+3CwY+uo9TkZ0w/8I0Ny2K4cOWVj8xYohQusYKGn2zh/vBK53t4olfr519XdfXrnvCgyJkvg131FQosK3ImWV/4+AoT4dE8vqxkBrrww7y1n0adhz03M6cBePeO1bzc4zVpQ93hHzLdHqZDKB/xcTmc3hOFpmlbbtsBL6PUnTCwt2erLzPk16cwPVef1fmA1uIvC/6e76/kjTcmDsahInAIKNrEvlKKF1SD5tSQVJ6+4tWUwWAGSizRctIsR5FIRmdoB4LOYusCN2/q79uLnbeeiHsnfQCerSqx/1UAJ733+1ylrsZHb3sYyFDg2bd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 13:35:24.6960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d3a1c8-36ac-4a72-272b-08ded1f5724d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
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

Use process-local GPU lookup in kfd_mmap() instead of kfd_device_by_id(),
so mmap path does not take topology_lock while holding mmap_lock.

Lockdep warning: possible circular locking dependency detected.
Chain:
  &topology_lock -> &root->kernfs_rwsem -> &mm->mmap_lock

Backtrace #0 (&topology_lock):
  down_read+0x8b/0x490
  kfd_device_by_id+0x1d/0xf0 [amdgpu]
  kfd_mmap+0x11e/0x750 [amdgpu]
  __mmap_region+0x101f/0x25e0
  mmap_region+0x228/0x2e0
  do_mmap+0x9f2/0x1070
  vm_mmap_pgoff+0x25d/0x430

Backtrace #1 (&root->kernfs_rwsem):
  down_write+0x80/0x200
  kernfs_add_one+0x30/0x6a0
  kernfs_create_dir_ns+0xd2/0x160
  sysfs_create_dir_ns+0x12c/0x2a0
  kobject_add_internal+0x280/0x8e0
  kfd_topology_update_sysfs+0xb85/0x1970 [amdgpu]

Backtrace #2 (&mm->mmap_lock):
  down_read_killable+0x8e/0x510
  lock_mm_and_find_vma+0x299/0xb00
  do_user_addr_fault+0x3fc/0xf80
  exc_page_fault+0x73/0x110
  filldir64+0x1aa/0x610
  kernfs_fop_readdir+0x3c2/0x810

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ab9e53dc8deb..82fceb8a116c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3710,10 +3710,10 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
 				vma->vm_page_prot);
 }
 
-
 static int kfd_mmap(struct file *filep, struct vm_area_struct *vma)
 {
 	struct kfd_process *process;
+	struct kfd_process_device *pdd;
 	struct kfd_node *dev = NULL;
 	unsigned long mmap_offset;
 	unsigned int gpu_id;
@@ -3727,8 +3727,10 @@ static int kfd_mmap(struct file *filep, struct vm_area_struct *vma)
 
 	mmap_offset = vma->vm_pgoff << PAGE_SHIFT;
 	gpu_id = KFD_MMAP_GET_GPU_ID(mmap_offset);
-	if (gpu_id)
-		dev = kfd_device_by_id(gpu_id);
+
+	pdd = kfd_process_device_data_by_id(process, gpu_id);
+	if (pdd)
+		dev = pdd->dev;
 
 	switch (mmap_offset & KFD_MMAP_TYPE_MASK) {
 	case KFD_MMAP_TYPE_DOORBELL:
-- 
2.50.1

