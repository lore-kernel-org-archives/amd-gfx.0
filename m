Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4467DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 19:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D5410E23D;
	Fri, 22 Apr 2022 19:02:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 613B110E23D
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 19:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzQA46SdcJ2eB/EkdkmjR8289C/k2P5SCOh3ONmq8V3rgE3YquyvMR2YLYnVPbVYXQLJmz9Nq+vUK1K4llqI9q0SOPY9DrOS7xhutJCa8rKAjK/uBDzQfyChmEee3Q0MLqr/DVLeZX/wKuil5ZmdC+SnPLdqXgKFt5QCI8QcF6GOURZxBT8NifuSafZnxHRp5TlU73rhQYYt2Csa13M6GvVtdoo6GQUb9fupPruktVrgpEM1XL2gZA7IX/9XboNsIP2TdNYrR4L/w8rBzfyAnWqh/puI65KhxF0GympUO0hBpcCPNS6qwYI4U+M+51Ieh+04acvlXAeLKAafZN0vug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHk+Nkk0k+hEG4l/hnPOdaFRAu/pU/2k39G3Kqg3p50=;
 b=XyuQ+xMjsRcCj/suOXrnva4AKOsB3D97zws/mIqgDmF3As+6KoDufvakIh2pZs5Do7A2WjQ77SZWc++jtmH2UklVbe4wALV7PR+mDxbK1Ol8Tk61PdW1nbOSKVenVWxOI+AIU7lXmFliXKrwAdFWlYmv5IGpKQjjAIJGtE1i2TdXz23meek0m9D5PVaJaioxgW15ZJZFcAFQQxQ+aP3kNHzzaczKc+9VtYd9TDtQgotSFLgIA3da1J7EFwK16um9K7lnoHGsCBlRy5wrXXKgMfDwZp+MGsVX0bbNRjnTueqNnRWFHdWBeVMNxbzaKOUsbI2fsXeunJqKs0n2DXHH2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHk+Nkk0k+hEG4l/hnPOdaFRAu/pU/2k39G3Kqg3p50=;
 b=yBL/tq4w6KEYKqPLGP8tyL+CTI5qSJZkCTLCmoVWJ7T0T414SIHEHw43OXvqKnSGNHSOIsY0OIAoa5tc8K1iiymeWvTd+28oQ5AlFw2Kv1JrQVPbqJ2JO+91g0EVXXHYRgMYoqpvrWjYbKt5OEMR8p589nRRV4P8YRoWNzU+/KA=
Received: from DM6PR11CA0065.namprd11.prod.outlook.com (2603:10b6:5:14c::42)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 19:02:47 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::38) by DM6PR11CA0065.outlook.office365.com
 (2603:10b6:5:14c::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 19:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 19:02:47 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 14:02:45 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: Fix circular lock dependency warning
Date: Fri, 22 Apr 2022 15:02:32 -0400
Message-ID: <20220422190232.2505589-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422190232.2505589-1-mukul.joshi@amd.com>
References: <20220422190232.2505589-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3506796-e031-48d8-1e9f-08da2492b088
X-MS-TrafficTypeDiagnostic: LV2PR12MB5895:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB58956B065578AE9349FA5691EEF79@LV2PR12MB5895.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7t3H/pGTxlS/6WwIPtgzTXW/A/SHZoQ8RxkOFoLPD9hl5Aq8UNN7umK+/w8flwHkBgdLyfNd15xV71pWn6ipA/cDLkDMsfYMh96bzTcm/hJPV4jkTGJLT+X9rMZzVIADnaccmIe1mwLoE3JaZnnNovqPxAYNZ7vIRFXqAA+8EC5lj/4q5KREjrJCC6weBZJcOSWduNQGQ0qPQu7sbM8exsDfBAp/S3LXCwlmbCPjSTa+mrJh/rwnBvgryo80ZMhj3LDPbRdkADpWqvl4+Q9WwFI1je+Mw2drrEpM6h8u3+jHuZW+XWH3n0tIi8gZ6fgScSlXz63KjbdtGrNoEmYwhZcgNAIzdQWxjWAfxx87Gr3lgqTSWX+uAbyhQlutY+eBzhoAv6VT2tOjw9eXHIKmJluX5L1Qe6K34NGpsjQ8uI6Uo4Z8FmxY7BpQojudnvH33jz8X1WZM+vQM1xc4mslIOmI7SIu6BZx/BYVYQRJT08a8gSjDNndbTM2ucxXkyBXhpSMi/J2llMlwv90DL6vmJ4v+KcCD5bQg66+5F6t7cFAMm13yf/dBa9F6TGnxb1Jqx573lA0ngbEX5uvzC0bj+d1xAS4PNjzHpxj53BrL6RviBSwDEJOtZOubkiEYFhZfwqHBJQ1vTrGt/9Fm7FzutnsrpwN5XS6C58FdAYxCJkGNDDUkaQ4EyaCzZn5000ZvHt00BCpGykhjw0QEGbBWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(70586007)(186003)(336012)(47076005)(426003)(16526019)(40460700003)(2616005)(1076003)(26005)(36756003)(83380400001)(7696005)(82310400005)(6916009)(54906003)(4326008)(8676002)(356005)(81166007)(36860700001)(86362001)(2906002)(6666004)(44832011)(8936002)(316002)(5660300002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 19:02:47.0788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3506796-e031-48d8-1e9f-08da2492b088
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[  168.544078] ======================================================
[  168.550309] WARNING: possible circular locking dependency detected
[  168.556523] 5.16.0-kfd-fkuehlin #148 Tainted: G            E
[  168.562558] ------------------------------------------------------
[  168.568764] kfdtest/3479 is trying to acquire lock:
[  168.573672] ffffffffc0927a70 (&topology_lock){++++}-{3:3}, at:
		kfd_topology_device_by_id+0x16/0x60 [amdgpu] [  168.583663]
                but task is already holding lock:
[  168.589529] ffff97d303dee668 (&mm->mmap_lock#2){++++}-{3:3}, at:
		vm_mmap_pgoff+0xa9/0x180 [  168.597755]
                which lock already depends on the new lock.

[  168.605970]
                the existing dependency chain (in reverse order) is:
[  168.613487]
                -> #3 (&mm->mmap_lock#2){++++}-{3:3}:
[  168.619700]        lock_acquire+0xca/0x2e0
[  168.623814]        down_read+0x3e/0x140
[  168.627676]        do_user_addr_fault+0x40d/0x690
[  168.632399]        exc_page_fault+0x6f/0x270
[  168.636692]        asm_exc_page_fault+0x1e/0x30
[  168.641249]        filldir64+0xc8/0x1e0
[  168.645115]        call_filldir+0x7c/0x110
[  168.649238]        ext4_readdir+0x58e/0x940
[  168.653442]        iterate_dir+0x16a/0x1b0
[  168.657558]        __x64_sys_getdents64+0x83/0x140
[  168.662375]        do_syscall_64+0x35/0x80
[  168.666492]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  168.672095]
                -> #2 (&type->i_mutex_dir_key#6){++++}-{3:3}:
[  168.679008]        lock_acquire+0xca/0x2e0
[  168.683122]        down_read+0x3e/0x140
[  168.686982]        path_openat+0x5b2/0xa50
[  168.691095]        do_file_open_root+0xfc/0x190
[  168.695652]        file_open_root+0xd8/0x1b0
[  168.702010]        kernel_read_file_from_path_initns+0xc4/0x140
[  168.709542]        _request_firmware+0x2e9/0x5e0
[  168.715741]        request_firmware+0x32/0x50
[  168.721667]        amdgpu_cgs_get_firmware_info+0x370/0xdd0 [amdgpu]
[  168.730060]        smu7_upload_smu_firmware_image+0x53/0x190 [amdgpu]
[  168.738414]        fiji_start_smu+0xcf/0x4e0 [amdgpu]
[  168.745539]        pp_dpm_load_fw+0x21/0x30 [amdgpu]
[  168.752503]        amdgpu_pm_load_smu_firmware+0x4b/0x80 [amdgpu]
[  168.760698]        amdgpu_device_fw_loading+0xb8/0x140 [amdgpu]
[  168.768412]        amdgpu_device_init.cold+0xdf6/0x1716 [amdgpu]
[  168.776285]        amdgpu_driver_load_kms+0x15/0x120 [amdgpu]
[  168.784034]        amdgpu_pci_probe+0x19b/0x3a0 [amdgpu]
[  168.791161]        local_pci_probe+0x40/0x80
[  168.797027]        work_for_cpu_fn+0x10/0x20
[  168.802839]        process_one_work+0x273/0x5b0
[  168.808903]        worker_thread+0x20f/0x3d0
[  168.814700]        kthread+0x176/0x1a0
[  168.819968]        ret_from_fork+0x1f/0x30
[  168.825563]
                -> #1 (&adev->pm.mutex){+.+.}-{3:3}:
[  168.834721]        lock_acquire+0xca/0x2e0
[  168.840364]        __mutex_lock+0xa2/0x930
[  168.846020]        amdgpu_dpm_get_mclk+0x37/0x60 [amdgpu]
[  168.853257]        amdgpu_amdkfd_get_local_mem_info+0xba/0xe0 [amdgpu]
[  168.861547]        kfd_create_vcrat_image_gpu+0x1b1/0xbb0 [amdgpu]
[  168.869478]        kfd_create_crat_image_virtual+0x447/0x510 [amdgpu]
[  168.877884]        kfd_topology_add_device+0x5c8/0x6f0 [amdgpu]
[  168.885556]        kgd2kfd_device_init.cold+0x385/0x4c5 [amdgpu]
[  168.893347]        amdgpu_amdkfd_device_init+0x138/0x180 [amdgpu]
[  168.901177]        amdgpu_device_init.cold+0x141b/0x1716 [amdgpu]
[  168.909025]        amdgpu_driver_load_kms+0x15/0x120 [amdgpu]
[  168.916458]        amdgpu_pci_probe+0x19b/0x3a0 [amdgpu]
[  168.923442]        local_pci_probe+0x40/0x80
[  168.929249]        work_for_cpu_fn+0x10/0x20
[  168.935008]        process_one_work+0x273/0x5b0
[  168.940944]        worker_thread+0x20f/0x3d0
[  168.946623]        kthread+0x176/0x1a0
[  168.951765]        ret_from_fork+0x1f/0x30
[  168.957277]
                -> #0 (&topology_lock){++++}-{3:3}:
[  168.965993]        check_prev_add+0x8f/0xbf0
[  168.971613]        __lock_acquire+0x1299/0x1ca0
[  168.977485]        lock_acquire+0xca/0x2e0
[  168.982877]        down_read+0x3e/0x140
[  168.987975]        kfd_topology_device_by_id+0x16/0x60 [amdgpu]
[  168.995583]        kfd_device_by_id+0xa/0x20 [amdgpu]
[  169.002180]        kfd_mmap+0x95/0x200 [amdgpu]
[  169.008293]        mmap_region+0x337/0x5a0
[  169.013679]        do_mmap+0x3aa/0x540
[  169.018678]        vm_mmap_pgoff+0xdc/0x180
[  169.024095]        ksys_mmap_pgoff+0x186/0x1f0
[  169.029734]        do_syscall_64+0x35/0x80
[  169.035005]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  169.041754]
                other info that might help us debug this:

[  169.053276] Chain exists of:
                  &topology_lock --> &type->i_mutex_dir_key#6 --> &mm->mmap_lock#2

[  169.068389]  Possible unsafe locking scenario:

[  169.076661]        CPU0                    CPU1
[  169.082383]        ----                    ----
[  169.088087]   lock(&mm->mmap_lock#2);
[  169.092922]                                lock(&type->i_mutex_dir_key#6);
[  169.100975]                                lock(&mm->mmap_lock#2);
[  169.108320]   lock(&topology_lock);
[  169.112957]
                 *** DEADLOCK ***

This commit fixes the deadlock warning by ensuring pm.mutex is not
held while holding the topology lock. For this, kfd_local_mem_info
is moved into the KFD dev struct and filled during device init.
This cached value can then be used instead of querying the value
again and again.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  | 7 ++-----
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 7 ++-----
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 459f59e3d0ed..95fa7a9718bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -944,8 +944,6 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
 
 bool kfd_dev_is_large_bar(struct kfd_dev *dev)
 {
-	struct kfd_local_mem_info mem_info;
-
 	if (debug_largebar) {
 		pr_debug("Simulate large-bar allocation on non large-bar machine\n");
 		return true;
@@ -954,9 +952,8 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
 	if (dev->use_iommu_v2)
 		return false;
 
-	amdgpu_amdkfd_get_local_mem_info(dev->adev, &mem_info);
-	if (mem_info.local_mem_size_private == 0 &&
-			mem_info.local_mem_size_public > 0)
+	if (dev->local_mem_info.local_mem_size_private == 0 &&
+			dev->local_mem_info.local_mem_size_public > 0)
 		return true;
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index afc8a7fcdad8..af1c4e054a23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2152,7 +2152,8 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	 * report the total FB size (public+private) as a single
 	 * private heap.
 	 */
-	amdgpu_amdkfd_get_local_mem_info(kdev->adev, &local_mem_info);
+	memcpy(&local_mem_info, &kdev->local_mem_info,
+		sizeof(struct kfd_local_mem_info));
 	sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
 			sub_type_hdr->length);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 62aa6c9d5123..c96d521447fc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -575,6 +575,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	if (kfd_resume(kfd))
 		goto kfd_resume_error;
 
+	amdgpu_amdkfd_get_local_mem_info(kfd->adev, &kfd->local_mem_info);
+
 	if (kfd_topology_add_device(kfd)) {
 		dev_err(kfd_device, "Error adding device to topology\n");
 		goto kfd_topology_add_device_error;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 33e7ffd8e3b5..49430c714544 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -344,6 +344,8 @@ struct kfd_dev {
 
 	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
 	struct dev_pagemap pgmap;
+
+	struct kfd_local_mem_info local_mem_info;
 };
 
 enum kfd_mempool {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4283afd60fa5..05089f1de4e9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1112,15 +1112,12 @@ static uint32_t kfd_generate_gpu_id(struct kfd_dev *gpu)
 	uint32_t buf[7];
 	uint64_t local_mem_size;
 	int i;
-	struct kfd_local_mem_info local_mem_info;
 
 	if (!gpu)
 		return 0;
 
-	amdgpu_amdkfd_get_local_mem_info(gpu->adev, &local_mem_info);
-
-	local_mem_size = local_mem_info.local_mem_size_private +
-			local_mem_info.local_mem_size_public;
+	local_mem_size = gpu->local_mem_info.local_mem_size_private +
+			gpu->local_mem_info.local_mem_size_public;
 
 	buf[0] = gpu->pdev->devfn;
 	buf[1] = gpu->pdev->subsystem_vendor |
-- 
2.35.1

