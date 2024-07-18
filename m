Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5034FC3DA61
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 21:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 645A910EB29;
	Thu, 18 Jul 2024 21:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EUZjxA2v";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B8D410EB28
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 21:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmtlQjv9IAWsY0xkYDckk1ZgelN6FU/CFYaN/8nVl0d0Y4i7a9QZAykNNFpi+ucvHNIBKv8JGeabycQ1fesSu5+mWcO6aUoGi/ekkvrVO4fpoYOMBzjYOxU5DeNyE56jU0rzs9RbyTQJOZC6copo4yT983z/h4lZ02/Go9M9fZOp7SazF+60Dkzl3EiKOhg4B7pyfT7j4iki23Ln+4Gaol7IR3F8YClt4lAW538rOAv4SnsJM0MP8Jyg9MVa+IcXIzkIQmuMz/x23SsDnPZVvYBAolJZtmZDs+Q41x+ZFBxc4SpgvEuKoZcGqpeu3zxR+JRbEy8hnzoreeDc++50Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfp311Ainsndz+SF26jIto2O0OBRNErc+E7pJH0ywyk=;
 b=Plf10MvJH3hZOFi2MG/qDiqVKvLuvkzW+BZnuUsImmG6hbd6r7rYJTFGfC+Jjqde2RTYAub/mTA+tglNl7bqiRAp19BOLhxgsQ2WRZlo1Nut9CZ6WTjcxNFvspdg9EoJEFy+7+rL7Hp6yRKq6eekMW0bSqukVnxasemrTfWrCEZ1WpSIhtDFk94d7UAGDWNFLIwQ8gAzHZJvRokMpj2xRJ0SYynthibnnTBIrUGqQKhdkyCX5lSfikZxe9qfvNGuOrwdJ6ZyhF4x2rNW46uNjK1QUXfv+SzrQr2LG2ijHzSg2dp3xEFVe7u8y3svwAtBr45ktYluAaTzkC79mxntHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfp311Ainsndz+SF26jIto2O0OBRNErc+E7pJH0ywyk=;
 b=EUZjxA2v7Zj/6jMKS3FHyj7HQGfYrpl0IiE01Mm2GZrRzwuVcgXyiIFILXq7lpmfLDt1umwCz8k8nhWNYaHY69rY909lhha5mnr+tP8V4YJoSBH/b26Y1m21iXxcIRoHnWo1rJeP+mZ1keHjIC6Wf/1ZO5QpcrkBAuJLTfXOZhg=
Received: from SA0PR11CA0108.namprd11.prod.outlook.com (2603:10b6:806:d1::23)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 21:06:14 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::66) by SA0PR11CA0108.outlook.office365.com
 (2603:10b6:806:d1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 21:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 21:06:14 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 16:06:11 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v2 1/9] drm/amdkfd: kfd_bo_mapped_dev support partition
Date: Thu, 18 Jul 2024 17:05:50 -0400
Message-ID: <20240718210558.26340-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240718210558.26340-1-Philip.Yang@amd.com>
References: <20240718210558.26340-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b786bdc-2824-44f8-6f6a-08dca76d7574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G51RqdvmkgBHj+z9FK/2spwp0FxCNJ0Ej5o8J2XmBowMgI0G/giqVjl4aRq3?=
 =?us-ascii?Q?eZeEvS+tJQSsRFRemKz+s+CO8U6JEKldMaoJ4jz5UherSxgN1P9a0GiF7PAB?=
 =?us-ascii?Q?Gw56px+rLkeiWOhzhXzSYUEJVJzxxunx49yErG+hzNTB7dBc1+AwrQDIf7cO?=
 =?us-ascii?Q?rnR8eH5Rn3PKShvBdwjiiOzXdzceI2HQxBuE9XxxpVa0SwIgKTs7+fFGAh65?=
 =?us-ascii?Q?O6WcoVvZGDkutPHChpkeWHCA9ZVSBUMC4ozxsw5jRFfTUo8rX2/7ZoNEBrfF?=
 =?us-ascii?Q?tiIQ0I2B8rcNJ6f62UONKZo/GmkDT6laDT1hk9lEEF1K9DKnB99KfBHz/Y3n?=
 =?us-ascii?Q?dldE1SLpXJ/ZsnJjBAMgmBVD2IitDT55suyIMVs8TJUfaZ3vzfrgvkkf0a1S?=
 =?us-ascii?Q?Y/A6xvrkAu3HebiCruRXkW9zGP8Comk61xXAoO87CkmUCElLq5RNKuJcbKXf?=
 =?us-ascii?Q?m5e48Go3ADP+4OMU03StQY3TmoYpxXZX3vvzx3JP0ph53CaoQRn5QT44Bxwu?=
 =?us-ascii?Q?P4NFRb12GQn0jCQkGsOOucG/S+iOpSecv4qeZuymM+YCEIxgUeuRUqx6Q5Rw?=
 =?us-ascii?Q?GyILDhjDKSRTlivVE0iwGBWC8tiftaPRFK0egwG4pNeEE+d/9pLfMCmBQzL1?=
 =?us-ascii?Q?Vb+CF1NpbZhaB49G7meuT0JmY6HnNQKrk0WSvyjXCpEIWgMcnev7lbzrxJJg?=
 =?us-ascii?Q?vjqSntGWwPOzybe60jT+2v9TyM97oBzAngkJNPCCj4w05m+vuunKza6esT/H?=
 =?us-ascii?Q?gVsxyBxCIoQwPtys12J7x9WzunpXHyud8lJPR0JKuF67wpXHfwt9QcDu+QNB?=
 =?us-ascii?Q?bUjVCKgCfTxmk9SEigPZanYTTdOjEsSFXjkxCppqc9kKCOTspblt2cbWQ/Y4?=
 =?us-ascii?Q?hiXfADDzqzkUTBxo04RMj5cJoyvP+OJjORvdetoOmJJcTmmS3exjvIBqkEZZ?=
 =?us-ascii?Q?ds8Wsq6pDvJFOzOWTGuOfxY6NEVq+Q5k4hH+nl0C0O7T3FHX5K1nNX9rzEDm?=
 =?us-ascii?Q?j7x7HjOuSg0hYV+iu/N6N9StDHZHfNe9MygioJ+T9RDjUt6AXguVyUSLqPFH?=
 =?us-ascii?Q?Q+TkxMz3M8JKcSo4l/n485xfbqtrlX3toNLWtJfK6tw6V5NHby4p0LQ90gLc?=
 =?us-ascii?Q?STX98MTusxiMvEY98cXtoZlN20aSoMurJYcBrWLq7hucoyilyQLYUaJ2p6xz?=
 =?us-ascii?Q?oubJILFLDudXc2w/xJvPWvLVOyTiUBM5N0Dvt0+hHWrw5Qev7dfnaSU3pt3W?=
 =?us-ascii?Q?R6xYpetv2jLf3WgD+teq44X8DlLC0XerHvsZnRsLGFPHJJ6jRgFrgQmeCN6I?=
 =?us-ascii?Q?PT5Gp8b3T8WfVx4dW9WCGR5nOyO+Ib4q6JVm3MpvZ94+eoBA4EdI2iZS6Khl?=
 =?us-ascii?Q?0fYReIiRWurCxQZSW7DfSS3U/ft0tvdde+Tijhh3ISHiclyN6slanMt7fh7H?=
 =?us-ascii?Q?ZkLazWc2DfEAzsyNBytp9mxkGX0XdYO4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 21:06:14.2669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b786bdc-2824-44f8-6f6a-08dca76d7574
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
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

Change amdgpu_amdkfd_bo_mapped_to_dev to use drm_priv as parameter
instead of adev, to support spatial partition. This is only used by CRIU
checkpoint restore now. No functional change.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index e7bb1ca35801..66b1c72c81e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -345,7 +345,7 @@ void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *ad
 			pasid_notify pasid_fn, void *data, uint32_t reset);
 
 bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
-bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem);
+bool amdgpu_amdkfd_bo_mapped_to_dev(void *drm_priv, struct kgd_mem *mem);
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 11672bfe4fad..199e387d35f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -3200,12 +3200,13 @@ int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
 	return 0;
 }
 
-bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem)
+bool amdgpu_amdkfd_bo_mapped_to_dev(void *drm_priv, struct kgd_mem *mem)
 {
+	struct amdgpu_vm *vm = drm_priv_to_vm(drm_priv);
 	struct kfd_mem_attachment *entry;
 
 	list_for_each_entry(entry, &mem->attachments, list) {
-		if (entry->is_mapped && entry->adev == adev)
+		if (entry->is_mapped && entry->bo_va->base.vm == vm)
 			return true;
 	}
 	return false;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 32e5db509560..1d9b21628be7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1963,7 +1963,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 				bo_bucket->offset = amdgpu_bo_mmap_offset(dumper_bo);
 
 			for (i = 0; i < p->n_pdds; i++) {
-				if (amdgpu_amdkfd_bo_mapped_to_dev(p->pdds[i]->dev->adev, kgd_mem))
+				if (amdgpu_amdkfd_bo_mapped_to_dev(p->pdds[i]->drm_priv, kgd_mem))
 					bo_priv->mapped_gpuids[dev_idx++] = p->pdds[i]->user_gpu_id;
 			}
 
-- 
2.43.2

