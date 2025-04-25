Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B38BC369D7
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 03:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3006F10E885;
	Fri, 25 Apr 2025 03:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4sRUBSsz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B820710E885
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 03:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hq1XPbg1cvTHDIpwEi4NJ1xT1nTBdt1l+zDYuUcoX0e9TtwIlHlPo/slZgugFSKCa3Dn74NrCpK5Lh7d95pZvhunRWRKmfGSvsAEm2uH5SORaMz0EXOJU9Rz4EdzaPuwOoLqAZjJUXiqz7DTub1DoOgH0A4k/wuofHqqyWcteC4bswOhV23dXLcXBe/N6mOmbyvgUKc00tJNLxwF8kI2SiP3gUcC9CKnJOVRcFHoFyVVSR88yiWDX8ZHE7i/ZUI5k88fvDAxV+FBg3R/kcAXhcODGPgFA9AjcSXDUOrBKQXRzLhKILsXqJJNhTCnRkEMZmD7otuvGmrZzLWCggHe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTZy1v4daxI/un4uf0FhGrixqRiz46LERI/DTFwt0lY=;
 b=o1wx0byc7LbRzpD6NpZSaKGisl2OKEmOuyIBvSGBV4id4RzGxURdplob8Aj+KcyQm/U01EYt8VnsL6tMqTCV1tG0TYOTYmaX4q4/WZX/xsjnupgpBoH+OI6CslFv17CTx6h5GPfcwFXeMdDz9kYyVCo/FfMNAqsr/oT/4vpDnAvQkn9xrh6Qk+TKZLerCJ63VnoQeVRiJwjIIBJlozctof9PYgboHc/aflmfaACMvWhJAtf5qg2Qq/qGyRurvemI/3BGnAQ36T93Vd6utiLNHVVSdwW0/JPNWVWj8U0x6fKp7j2tOpjlstOtdeobTdkEw9Y1OJHEErzBfWZrkhqhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTZy1v4daxI/un4uf0FhGrixqRiz46LERI/DTFwt0lY=;
 b=4sRUBSszTMuNOJYDjeUwA+AVFBK+7IhybatwWT6/RDpQLPhOckfhyMVO7Xfc2pGYhDVPBQFRftnLwEeDQ1GYKakU8ucHjMZ45XMikoGNgN4zdjJeAMRIDe8l8R9Ieqv7/ZTp7J53WD6wLEhLx70x14O9s5rmV4rFCpOF3xC/POs=
Received: from BYAPR01CA0049.prod.exchangelabs.com (2603:10b6:a03:94::26) by
 DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.26; Fri, 25 Apr 2025 03:35:31 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::45) by BYAPR01CA0049.outlook.office365.com
 (2603:10b6:a03:94::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Fri,
 25 Apr 2025 03:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 03:35:30 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 22:35:28 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>
CC: Shane Xiao <shane.xiao@amd.com>
Subject: [PATCH 2/2] amd/amdkfd: Trigger segfault for early userptr unmmapping
Date: Fri, 25 Apr 2025 11:35:13 +0800
Message-ID: <20250425033513.1535517-2-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250425033513.1535517-1-shane.xiao@amd.com>
References: <20250425033513.1535517-1-shane.xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2570df-7b1b-48eb-17ed-08dd83aa3a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Adjl7WRuINrJTIMGzHgq1ewXM80q/jGtdmokyw1SDGAWhG3BahnRdPy8bTsK?=
 =?us-ascii?Q?4b+2dQT1v5kcP3wjN6HmxbGF6f6GGgt4ybIjNGwN/xWf0NsPUILQ+Vd6wYQt?=
 =?us-ascii?Q?PPEImciWTyxUAdTQ6e6aXA3zmXnotwn6S4P1VznyfYTtn+O3ta7pgRC91iP9?=
 =?us-ascii?Q?5W3gcUDX6++0CkxQmRopRrGVkknPJEnqHb76GMG1tPhrJfxmqrQkW5nXWYOn?=
 =?us-ascii?Q?93QAaO0l4UJeHbcbdUBhGoeBBpjWxeP7KSFF2jDV2WupEwPEEHPXtPTiO2fI?=
 =?us-ascii?Q?N/e5dLpetG0mL37EgK4GhbRw3O/srRDiSR8hO0I8l4G03rtglLnh+lTTQRQK?=
 =?us-ascii?Q?L8B3JqSP00UiHZckksApltw7gfP9dbbe8A33a0LFuxh7+75RYMFAqp/himHo?=
 =?us-ascii?Q?g9klmsoOGNGSn7PfCDlkO72+JS5/MfydU1dCPWFyoZgBydJuxCH65HC9+IDk?=
 =?us-ascii?Q?dSMlGMHLqdwQSiqTViUweeqlZ2bsys+eIfjwa15vpG/YUhIh1RCQaK9dAugm?=
 =?us-ascii?Q?BRlCoVDqekcMCDEvVNPHceqEDQcyzZ3QZFl23VGSA483lRbikhig7vGdrS89?=
 =?us-ascii?Q?IE6N/QeoHfVARsP/mIvdF3k2+3Oblu1+zprxVP+5zVLOxPytzB3SK151hWGE?=
 =?us-ascii?Q?FtPdom6dCqZMJAxmvTCnaDLCMdqwc+NoUkVliAmyV1h0s9yXtp3cZXxKMvVx?=
 =?us-ascii?Q?7wD2MP9qJZpHQZWnwvdWkbi2vB1W+MinxOBqvw8ykLArF9aItgHGSvLVIwm6?=
 =?us-ascii?Q?uzNZZB5VTravNJGPKFJv5DF31TRqriuthpQ8ip6qllSwXi0/HaU6n+ijnIb+?=
 =?us-ascii?Q?bbGC0IdwiztyB2iQLubcu86A++JmzNM4DV+qwdQv+WMyf76PH/56mjYrlpsC?=
 =?us-ascii?Q?hp+fvFFVlP6wb4WsCzEvD/4zOtUOsEEsplPLGtmraDde+MuP9v8p0A9fhp87?=
 =?us-ascii?Q?cpPgM21/1O8cRMiJToGNLL8DdubEUcS2Ld2E7UJZbG7lLptne9KyXNWGsdFZ?=
 =?us-ascii?Q?m1YPMTLMGwj5oC79Q0lnWqAtkHxOt4J4cEvNC6aEuU6e19+UgUFqHDj+HxGK?=
 =?us-ascii?Q?va+DCh8/ZTJD/7xBneCo2fjsLZ6hSRtX+pIvWnlEcQcxQ9g2dCObmT8+GVge?=
 =?us-ascii?Q?bGziaurkkWSavIqIyfwSlgQUiHY+jwPt7gsTOZuiu43PWa578To7P+PB6KrR?=
 =?us-ascii?Q?9N1tNGN2BnePD3HVeosgKAGFwz7Rh7S+L2bfNz9yGLaP1yj5CnEp72Me9ReK?=
 =?us-ascii?Q?fkYwhcVor82TOzGd7IOYT5rumxbOeq/OiSaaVGWswo24r2MZSIy0ImFCmGsc?=
 =?us-ascii?Q?1e89CiHQjmkxn8FEM0qua2EpswStMBcBPWFTxOwOQvDOyH3hfbj2hBC8gXsA?=
 =?us-ascii?Q?9pm14kZxLaVUSr+Ki4eTXjKC2maPYYXmCydXSEoVEyHjFJNNk3wKPfrna4w2?=
 =?us-ascii?Q?XT4oLmHbXuf6bpBjQbKt6Bp7BxRB9xNHU35LJM/BC7YmSfp/irTieI8FOHmn?=
 =?us-ascii?Q?W7CLev5TDgQMjizjYULZSRi5EzJI4mEVrk4K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 03:35:30.4849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2570df-7b1b-48eb-17ed-08dd83aa3a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
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
v3: Report gpu address to user space, remove unnecessary params

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d2ec4130a316..61a698056fb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2496,6 +2496,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 	struct ttm_operation_ctx ctx = { false, false };
 	uint32_t invalid;
 	int ret = 0;
+	uint64_t userptr = 0;
 
 	mutex_lock(&process_info->notifier_lock);
 
@@ -2559,6 +2560,20 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 			if (ret != -EFAULT)
 				return ret;
 
+			/* If applications unmap memory before destroying the userptr
+			 * from the KFD, trigger a segmentation fault in VM debug mode.
+			 */
+			if (amdgpu_ttm_adev(bo->tbo.bdev)->debug_vm_userptr) {
+				amdgpu_ttm_tt_get_userptr(&bo->tbo, &userptr);
+				pr_err("User space unmap memory before destroying a userptr that refers to it\n");
+				pr_err("The unmap userptr cpu address is 0x%llx, gpu address is 0x%llx\n",
+								userptr, mem->va);
+
+				// Send GPU VM fault to user space
+				kfd_signal_vm_fault_event_with_userptr(kfd_lookup_process_by_pid(process_info->pid),
+								mem->va);
+			}
+
 			ret = 0;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index fecdb6794075..e54e708ed82d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1177,6 +1177,25 @@ void kfd_signal_hw_exception_event(u32 pasid)
 	kfd_unref_process(p);
 }
 
+void kfd_signal_vm_fault_event_with_userptr(struct kfd_process *p, uint64_t gpu_va)
+{
+	struct kfd_process_device *pdd;
+	struct kfd_hsa_memory_exception_data exception_data;
+	int i;
+
+	memset(&exception_data, 0, sizeof(exception_data));
+	exception_data.va = gpu_va;
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
index f6aedf69c644..8703be8077b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1507,6 +1507,8 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
 int kfd_get_num_events(struct kfd_process *p);
 int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
 
+void kfd_signal_vm_fault_event_with_userptr(struct kfd_process *p, uint64_t gpu_va);
+
 void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
 				struct kfd_vm_fault_info *info,
 				struct kfd_hsa_memory_exception_data *data);
-- 
2.25.1

