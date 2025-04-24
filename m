Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40680C369C2
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 05:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8929110E439;
	Thu, 24 Apr 2025 05:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lM82eo2u";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D0D10E240
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 05:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTlqmd/Q92AmtPYrGaqBim/zhk779rkv9weGqz9oex3fvTktqOMhCZ8CLQZh/68sLy8SvsjrvHkkSg3DgmeS0ysOZmwejAFta990mVQ2i5Xf7uiEA9IzLLMODtV3MnY945nsueL85udlBeh/kJkN8Sel0rt2HQrulN+/Pc7v3llaFGIsDpRIvQCkVxLAffeGbl1dPl27G98hUAFVVZwm5qV2gk4IZd5iIB3m/eWQidszROhdR0q2Lg+VfbcjWOjK8W8J8m6wWpFWRjCfZoVV3fyiAQNpS1viBjhZrsAF6qDmsLHbkMAoMqVMCxcjSO4JNT5iWqOcjvr8DeAWiJcRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvsduWPf/w91THafS1WpRL5DyTb8CrJHE/p5pubX+bQ=;
 b=f3POiBJNZqzBnB5CriC1IatUrKFH/iHldTTa1aUnAxRJbJuZ+amKA+cTMPMQJMzd1ndIVpyzM0tJX4kQ/aCfJnv3GFeAt8kMrf0oPz9S9jGbwMUYHrTcwfvQGRZ4/b9OFK7j7u4k9pWZkKQjd0L8HKxzZ2V5S0BOKldvkorH/8zEeO4NP1Duhbff1Duflp12Gfos1GbtgdZ+SVqq9KxcgB3DJbfikQlypB0WkvprWJ+VfI6oKzb6gl7Bh4IExBqAyXiQb0CmoER6uSKojju053DJPjk038QS67/s8yeVX+4rmLlSfyTKWuWtwyqg6520Ioca8Qu1Uvcx3ILDMI93Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvsduWPf/w91THafS1WpRL5DyTb8CrJHE/p5pubX+bQ=;
 b=lM82eo2ufbDabj9Joc9aW9eCmu2bUybFwnm1YsB8MH+w13PWSfT0x9VARY3Grjyd7VXIBNYdOwRaNSChjTBUZfbImtpixaEMkYZ5W9+KTznBj/6I9onteoAsZoY38K0gQRorlTVjD8v/Kyj9x204K556ou5YNxFXA/exdQloTXs=
Received: from DM6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:5:1f4::17)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 05:54:42 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::c6) by DM6PR02CA0076.outlook.office365.com
 (2603:10b6:5:1f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.32 via Frontend Transport; Thu,
 24 Apr 2025 05:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 05:54:42 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 00:54:40 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>
CC: Shane Xiao <shane.xiao@amd.com>
Subject: [PATCH 2/2] amd/amdkfd: Trigger segfault for early userptr unmmapping
Date: Thu, 24 Apr 2025 13:54:26 +0800
Message-ID: <20250424055426.1471075-2-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250424055426.1471075-1-shane.xiao@amd.com>
References: <20250424055426.1471075-1-shane.xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c86524a-b4a0-4ac5-a1eb-08dd82f48215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AZpynbLleujjNp8+Wc2GQ5FXpVoUT1gflc3Xiy9gka8B9S4X0WNhXwUeHpiv?=
 =?us-ascii?Q?9uUEdO9uZsbYvowhPPc4ePoxigwC1X7LZ10S39xRCjnB+/Tfx9NvXD7Rs1YW?=
 =?us-ascii?Q?K5CiJ+tzpVd9mm3UPHplKHxlTfnxv4kfmyLJw9rmkeQgB2vDK39rGP/Nt3DF?=
 =?us-ascii?Q?BLX16WM90afdPf4qppBjrsaEFIIoUKPTWqkRHj7HB4FWgSsfejhkw16IQsKZ?=
 =?us-ascii?Q?56OL0upyxXfwO5xBsPbbLHkfn5JQBSNEReXYpnyOU5tsEpK0jFmkQhyA0jE9?=
 =?us-ascii?Q?rt8KeG97dOA8HOuxDN2bnobJFOQn9WNMmPFOez7hZWrsN06iNhmMHdwxr6GS?=
 =?us-ascii?Q?jwsiTkaBlwt1XtdzNn3fRNVYkalRiARZuAsofO0fGEVhOzm3P4To/KnK8+M/?=
 =?us-ascii?Q?/w4WjM0iCQGvG26hCSoJEAuHzAFBc+4J24c8yK/8W/J2XqegEPbkDm7g8yIm?=
 =?us-ascii?Q?tevnVVb1LGF41QbFTceQtKA9xKhyWcQfH1LKyNwLYeVnCJac1+bPUMHnUwp7?=
 =?us-ascii?Q?7YuK7Z1uYehQ5r8owkxKnxspEty5+p/Pk7nW5qt3gZJVi/lMP/oUnGILaps9?=
 =?us-ascii?Q?iTXM9PDzQli2D2J8mAUpwT43/aSeUZKdOu7ELR0vphm/hIn7B35vL9L/E7OL?=
 =?us-ascii?Q?KN47dvn/EDyKxfx/Tn4zekPT/y9I0XM/rQsFxdiEaVbd+rcS+Pp2GwK36O6b?=
 =?us-ascii?Q?CkjHueasP0Rh78cjsFygEbaXWtFL2LG3Qb0/bh6/F2Ntm2GzZ4R52JFxVSed?=
 =?us-ascii?Q?b3TOLLGRoqiLynFVFRP3fseqS95/KnRZoqGS22RLJBqvTD6sql/kPvczWdde?=
 =?us-ascii?Q?u9veh8/VJP+mvcpbAf26WfmMiFmVy7A9sUmwd/DwDiWckvxV52uSoXpt8Y6c?=
 =?us-ascii?Q?QzEgkf8vi42K3jDV0vxr85c2bUrTAqpPrStWebrUK9sd9zwMGvn8Ci9O/iNN?=
 =?us-ascii?Q?s95xlYphTLcudozr+pAki1CzBQ1N+qJ3SxWyh/t950aY7NB5Ox41epjXT0i+?=
 =?us-ascii?Q?sQROOf28P72FNuGBg3o2OYt7G/BfuAK84yQBWLDLG6dnkIBDT5FcXSPSkLfU?=
 =?us-ascii?Q?3yQY7VC3okA0GRHflq7WSPY1UXQul55xW8QUTn+csy5QBk8k8uMaIL2qM3hQ?=
 =?us-ascii?Q?X5qYo5wv1bBm3hXq7cwhUSKR0vqLoDHF0oCW0SyMNlf0CL5nF6mPbFREX85p?=
 =?us-ascii?Q?auAI07ZTTBtPP2tkBiEaxTs4QUH/QBkYvsWUezBWVsfo0CmM8Q2qaGiWvJhM?=
 =?us-ascii?Q?8Na+5LWz0FprO0gTqjvcn+7nYbRcFU5a1lEDUGgHq8sdwXu112h1cR2qcKN9?=
 =?us-ascii?Q?PU0UuiCK3Vguh6RaFgm+cY2rCQdhLWid63+DayFgU8THY9P3KlXVAVwxKyaH?=
 =?us-ascii?Q?KSb+qD9u6/TCDKar82HGvalLGSfqs6cbzxM6ME352gr3pNUbffJLbfJpASEc?=
 =?us-ascii?Q?PAl/wG6u0hn53K7IuqYN56/BiKVPzDLeLfB/7buyyIR6uuJii8WEd16JFbE9?=
 =?us-ascii?Q?4nytx95dZcKzAfOO1jk24LcIMBkagCCVwPWi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 05:54:42.1627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c86524a-b4a0-4ac5-a1eb-08dd82f48215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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

If applications unmap the memory before destroying the userptr, it needs
trigger a segfault to notify user space to correct the free sequence in
VM debug mode.

v2: Send GPU access fault to user space

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 14 +++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       | 20 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d2ec4130a316..876e9df34adf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2496,6 +2496,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 	struct ttm_operation_ctx ctx = { false, false };
 	uint32_t invalid;
 	int ret = 0;
+	uint64_t userptr = 0;
 
 	mutex_lock(&process_info->notifier_lock);
 
@@ -2559,6 +2560,19 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 			if (ret != -EFAULT)
 				return ret;
 
+			/* If applications unmap memory before destroying the userptr
+			 * from the KFD, trigger a segmentation fault in VM debug mode.
+			 */
+			if (amdgpu_ttm_adev(bo->tbo.bdev)->debug_vm_userptr) {
+				amdgpu_ttm_tt_get_userptr(&bo->tbo, userptr);
+				pr_err("User space unmap memory before destroying a userptr that refers to it\n");
+				pr_err("The unmap userptr address is 0x%llx\n", userptr);
+
+				// Send GPU VM fault to user space
+				kfd_signal_vm_fault_event_with_userptr(kfd_lookup_process_by_pid(process_info->pid),
+						amdgpu_ttm_adev(bo->tbo.bdev)->kfd.dev, userptr);
+			}
+
 			ret = 0;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index fecdb6794075..89943d2146a4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1177,6 +1177,26 @@ void kfd_signal_hw_exception_event(u32 pasid)
 	kfd_unref_process(p);
 }
 
+void kfd_signal_vm_fault_event_with_userptr(struct kfd_process *p,
+		struct kfd_dev *dev , uint64_t userptr)
+{
+	struct kfd_process_device *pdd;
+	struct kfd_hsa_memory_exception_data exception_data;
+	int i;
+
+	memset(&exception_data, 0, sizeof(exception_data));
+	exception_data.va = userptr;
+	exception_data.failure.NotPresent = 1;
+
+	// Send VM seg fault to all kfd process device
+	for (i = 0; i < p->n_pdds; i++) {
+		pdd = p->pdds[i];
+		exception_data.gpu_id = pdd->user_gpu_id;
+		kfd_evict_process_device(pdd);
+		kfd_signal_vm_fault_event(pdd, NULL, &exception_data);
+	}
+}
+
 void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
 				struct kfd_vm_fault_info *info,
 				struct kfd_hsa_memory_exception_data *data)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f6aedf69c644..34f47dc1cbbd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1507,6 +1507,9 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
 int kfd_get_num_events(struct kfd_process *p);
 int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
 
+void kfd_signal_vm_fault_event_with_userptr(struct kfd_process *p,
+				struct kfd_dev *dev , uint64_t userptr);
+
 void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
 				struct kfd_vm_fault_info *info,
 				struct kfd_hsa_memory_exception_data *data);
-- 
2.25.1

