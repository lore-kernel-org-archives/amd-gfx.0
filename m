Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C880CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 16:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E87F10E3DB;
	Mon, 21 Mar 2022 16:14:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA60710E3DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 16:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkmJAOW6W579vCSE/2+fbD8oAPPUAstTsGDrS5DO7J03+MCMCVotUEY2OAcoFgtAuqAEK2qzLYwu6JWBYQfOaIeVhBdhEhGiE8ijZlWB/u8XeEPbX8BLBg5IJunBRizUjxnWVJxZ9CVVuJ66yclwQX+IP3a/+P+Vw0kLTqmxqTB2JPO/D6CGy0CfDoqp4VJACdyFxIm2yqJXKdmacuDsoDoJEMPgV5BiTLh6plRXrCBpR6C0MI4PIK93RGTmvhTBNd3CA8almFihi52DdDlvTW6iaNfeRvGoEm6FUpTUDnx2xFmucGas6rDxJv32LZNK5yfkyKRWa6XD12c2+S5AvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJdt49idrejaIPuEv/9C5ldGOn3WjI8z4RhEsLhuo+8=;
 b=ZoixtVH1Fp0BC6NJ/+KuCiHptsrGEqTvbZlulkfyEiE6qOtK97ZXM1Y2+uln7iLz/tSnUXI4PfwFxxXC6so5ACnKSTOTLc2O/vwd6q6rfXVB6NCfJ9ppcamatfq9v8cystWHKjN07RNoG8ZJ4PsLX/1/IEIQyujfQ4DkMO6VJenTRH5zV/fsguiVZdT2013YmGkIVM9hqBkMegWqQO1iZgJTZ9cAVxFdK2FCbRFJcKW16/1C6iRjZMHrppJkeOMimKy2qIlrmlps0AHo8/btahbyT69pSnQO4N7kTXzFSbXI0QX/z1yAaDTZrRHPOaocQhPd1X3CzIKVixF0GT7n3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJdt49idrejaIPuEv/9C5ldGOn3WjI8z4RhEsLhuo+8=;
 b=KiEfeCN94tZMV7mgeZE9qucldYsehP4W/LYWAKn2GT0x7vO0e+rwCemRpBTpYqshoCr0CVeqVMx7Pg/ExuhRDdb6ssa8KTg6/d72qRtCGHW6V+VlZxvF1pxaVjpYsgDMGDrxFc+HuGz7FKi+FI1Wf+cqDnPwt1F1zjGJflXPfKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2505.namprd12.prod.outlook.com (2603:10b6:907:4::16)
 by CY4PR12MB1799.namprd12.prod.outlook.com (2603:10b6:903:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Mon, 21 Mar
 2022 16:14:04 +0000
Received: from MW2PR12MB2505.namprd12.prod.outlook.com
 ([fe80::381e:ef8f:81f2:5ba7]) by MW2PR12MB2505.namprd12.prod.outlook.com
 ([fe80::381e:ef8f:81f2:5ba7%6]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 16:14:04 +0000
Message-ID: <6941c177-d59e-8710-e4a6-e61c09d7b558@amd.com>
Date: Mon, 21 Mar 2022 09:14:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: Daniel Phillips <daniel.phillips@amd.com>
Subject: [RFC] Add KFD available memory ioctl
To: amd-gfx@lists.freedesktop.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:303:8d::6) To MW2PR12MB2505.namprd12.prod.outlook.com
 (2603:10b6:907:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37a44f7e-1041-4d72-26e8-08da0b55d172
X-MS-TrafficTypeDiagnostic: CY4PR12MB1799:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1799988CEB62AF902E6A92E8E3169@CY4PR12MB1799.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwEQKXwnPPQVfP97E0+1w2o0Yz8BNDkBqsW72NgY2dU3KlkEUMMsjynAvh9k5/4G90h61ns5oy0fp0/NM7HpliHCRSglcNS3J2Ytll+0iZz0UgmqThsJTYqzPIJUOk/MOkhyNYTjg6yDyVXE4yJjZMkgizR96+20QnXo3Gfmu94UzQnAjBSYahH8OjSYlLaiGCdD+AN/O5tmUbRpH6NWk9sy0BU/0y1M5O67O93/p7pYIrq1w1FQHaftA+wlZoUcRwZELLkCs9q76lpFgEPtOIvQvTkIhDI1zo7MoR78DsbYQ2HL3Hl06ao8crqF1jU63y/fY66SqhOO5K+CBKmuTdfWimdukM8PYKvdBuc4n8F76Tt31qRjQnHQ6CIehRjgNZCGQt4pHjVTxoOR4UPJD5jLeFQYxXa6OQl+7P042XQIYJ91EjJHzWxKOvB5nRKxbSfqJwTUwvMFiIDlbyNrlFN8H0CrmW7jmkby+HXKXHPJrKvFTcATW7w2x7lRGmU71MYwnYLqM/2R8mxRjkVFR0VrlHewcDnUOVDoMhfcHxwjT4hfsrhenRn0cWERAcIfjD4J8gAZBJmbpx27/kxC+rO/Tw5vU+zd9mMo1k/f5I/k91bC3mDSPaxuhAqiHk3BdJNZDoWWOS8rCrfImlWPRh6XbMy96dFAN95xXtHrrNvUd1iQLU/qGyI+rg607gdHpdriNluzG+XStb6PSz0uhWNElHNgdJu9mCN/oi/AGWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2505.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(26005)(2616005)(44832011)(31696002)(86362001)(5660300002)(36756003)(8936002)(2906002)(6916009)(8676002)(66476007)(66556008)(66946007)(83380400001)(4326008)(6512007)(508600001)(38100700002)(6506007)(186003)(6486002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVNpZ3daend0eUl1WEQ3MS9KZjRHN3dkVis3UmRSUWg0U2FaV2xic0JNb0hy?=
 =?utf-8?B?VjhJVGUxV2dPT3ZNMGVmNTFoMG9MZ3g2WC9wNlQ0REU2UCtEaHlCY1hheUQr?=
 =?utf-8?B?Q0JWTlhaY2dpSW41aHdsd2JMb3A1UkV1aksrVTdIaS9YSVBQMU1PM2dpMTc4?=
 =?utf-8?B?RnpGRGs3WUttU0piOElhaHRoTHlXSzlaWjNwZXhwdWxHb0hSWkpmV0MrZFZF?=
 =?utf-8?B?ZnppV2xYbU4rV3AzcG8wcDZpOENuTFVUbjhab0c5cndUQU5OdlBJbENIMWxC?=
 =?utf-8?B?ZXJEZmt3SmlHZkJUcTZ0RThqeitvUmZLRng1WnNkUjRhYVpwQldMdDMweDRF?=
 =?utf-8?B?SVhxY2FGMEtxc1RtdGlEaFc2NWdESXFKQTZwbUtJaWNNQkNFWFlFMGRkQVZC?=
 =?utf-8?B?NWZEMVJQQnF5TE1wSEs5eVIwZ0QxMC9KdTc4U2N6RG52YU9udjFlaTdQZHh6?=
 =?utf-8?B?MVpWd2gvRERjQXBGMW9qeTNBRWpBS2lDL0pmTHlYZEF0cUhLSHRSSXg4cDNV?=
 =?utf-8?B?d0FTQjFLbjlKYnRhVEppazBWMjRSOWpMaHF4RjVPbkJDcEFCOXZsdThpOVV2?=
 =?utf-8?B?N1c0S1VOVWlYVmIrOWpGaUxSNTkvaG5wZEpxak1xaDVLQ05ZRjFZTTJ0eXZj?=
 =?utf-8?B?SGxsR0xUT0ZjL2dZMk8yZEIvSjhTc2JPdG1UWG9hYTdyK0N5K1VhNWM1WWJi?=
 =?utf-8?B?YUJ3Ym1ISWo2OU5IOW8rZ0hheWJVeGN0WUxMKzYrTWw2S1dObjVuTkFmRzZF?=
 =?utf-8?B?S0FZd1ZVRm5EOFRJMkZZRCttQjAxS3FKM0c1alJFK2dkUmlRdkVGZ1dFbmMy?=
 =?utf-8?B?b1VwRmVYL1FuT0R4eFBESVlIN21UNkNwdXhwQ2NQRzAxS2RNN0lweE8vSWFN?=
 =?utf-8?B?SGlxdUJTZ1o1RFdCOXBDbmszaG1kL3MxdHJKalNORjV3VUsrTm84NzZpclB2?=
 =?utf-8?B?VnUweE0zMm1SNXJYT2NJeE0rMEJ2S0RiZ1EwcEJaTlpPOUNzZndRd25OWlhI?=
 =?utf-8?B?dC9XejFJcW1rWGtTUkpCN2djU3BjUjl2M1JqNDgvMFEzY0pHVi9zU0Y3TUV0?=
 =?utf-8?B?YndYNE1hem1yVktBYVJpZ29tcFU4N09Ccm5XZmR3TUEreUF1QnA2bHpzQ3hL?=
 =?utf-8?B?YXYxSnJZbXN4Y2ttWEdCZy9ncnFmSWZYSmhKQjNqREFFYjhZcEtBc1dncWdo?=
 =?utf-8?B?ZTZoUk1pVFZiVlpVYkxYS2N0Nkh5RERhdGExZUNWTVlHMUdZVXdJOXpCL1Jp?=
 =?utf-8?B?M3Z1Rk1qTVg3azdVeXREbFFCdUxhRDRXNWk3UTJJV1Juejdja0N5bzU3K1pu?=
 =?utf-8?B?Sy9rbHNnZkFNY2pzYS9xWkJQVXYvNTkvKzVRNHEveis1ZWU2WUE0VlNNSlNM?=
 =?utf-8?B?RjA4SzZnYzJSMmU1SGZtVXRkNzJFVzdyZjhldkVEN2RLMGJtUDBqeGFmaXpL?=
 =?utf-8?B?N1BrR0RVZUlHQ1U2V21qbHhkQWdEbkJjMlhVMUk0bTBtWnBLODM0UTY1RSt0?=
 =?utf-8?B?Tm54dFNZdTVzVDhrM3QyWHJIUjVad2xZUERMV0FKOGpwWExjdmY3TWJiQ0Rj?=
 =?utf-8?B?L1c2ZVpBVmpnRGpuS3hDdGZHK0llb3p1UDA4NWRWN0k2Z2FabzNwNkJrRk50?=
 =?utf-8?B?QjR5RVA3SHYyMUJPalZwSTg3ZmZoV3hCSmNvYlgwUzZDWGpDR202dVJyWTFN?=
 =?utf-8?B?MUdCSlBWWTNlaWJNU3hwYWRSQjRrYnJ5L25zc2g0S2dTRi84eW1ELytRUzVt?=
 =?utf-8?B?eW9SSzlkejNTTnM2bDdLa0ZyZDZQMWx1YXRiSnFGNkN1TFY4aVBNWHFDZ1JB?=
 =?utf-8?B?aTdvMi94NmhWa3hwRW1hSTdGeGFzTSs5bnpIeXlsOTlHbThXMEtROUtRVzFx?=
 =?utf-8?B?aEZOelQvNnlrSElobE10MTNXcU1TVGhMMkRxK2dPY0V5ZlgxWDZIRDBUTU1X?=
 =?utf-8?Q?x8agcNByOuQAnOrs91G+X3RqkItkcANo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a44f7e-1041-4d72-26e8-08da0b55d172
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 16:14:04.2422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bTnWbFk9rweeZ9CzSYTIZmoqxQqNarZxrxkURS/ZlC1MCPr9a9f028KP5VPymbTOuIuxWo0TdJkTf0ayMDweA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1799
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,

This patch adds a new KFD ioctl to return the largest possible memory
size that can be allocated as a buffer object by the existing
kfd_ioctl_alloc_memory_of_gpu. It attempts to use exactly the same 
accept/reject criteria as kfd_ioctl_alloc_memory_of_gpu, so that 
allocating a new buffer object of the size returned by this new ioctl is 
guaranteed to succeed, barring races with other allocating tasks.

Thunk patches to expose and to test the new ioctl will follow separately.

This patch is still in testing, so I am not asking for merge yet. This
work is targeted for ROCm 5.2, however we may be getting a tad close to
feature freeze time for that.

Regards,
Daniel

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |    1 +
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |   14 ++++++++++++++
drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |   15 +++++++++++++++
include/uapi/linux/kfd_ioctl.h                   |   16 +++++++++++++---
4 files changed, 43 insertions(+), 3 deletions(-)

Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4cb14c2fe53f..0a4c9187cba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -266,6 +266,7 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct 
amdgpu_device *adev,
 void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
                     void *drm_priv);
 uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv);
+size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev);
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
         struct amdgpu_device *adev, uint64_t va, uint64_t size,
         void *drm_priv, struct kgd_mem **mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cd89d2e46852..f904117e4960 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1494,6 +1494,20 @@ int amdgpu_amdkfd_criu_resume(void *p)
     return ret;
 }

+size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
+{
+    uint64_t reserved_for_pt =
+        ALIGN(ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size), PAGE_SIZE);
+    size_t available;
+
+    spin_lock(&kfd_mem_limit.mem_limit_lock);
+    available =
+        adev->gmc.real_vram_size -
+        adev->kfd.vram_used - reserved_for_pt;
+    spin_unlock(&kfd_mem_limit.mem_limit_lock);
+    return available;
+}
+
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
         struct amdgpu_device *adev, uint64_t va, uint64_t size,
         void *drm_priv, struct kgd_mem **mem,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 59d3fe269e7c..a63683a854ee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -961,6 +961,19 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
     return false;
 }

+static int kfd_ioctl_get_available_memory(struct file *filep,
+                     struct kfd_process *p, void *data)
+{
+    struct kfd_ioctl_get_available_memory_args *args = data;
+    struct kfd_dev *dev;
+
+    dev = kfd_device_by_id(args->gpu_id);
+    if (!dev)
+        return -EINVAL;
+    args->available = amdgpu_amdkfd_get_available_memory(dev->adev);
+    return 0;
+}
+
 static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
                     struct kfd_process *p, void *data)
 {
@@ -2693,6 +2706,8 @@ static const struct amdkfd_ioctl_desc 
amdkfd_ioctls[] = {
     AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_OP,
             kfd_ioctl_criu, KFD_IOC_FLAG_CHECKPOINT_RESTORE),

+    AMDKFD_IOCTL_DEF(AMDKFD_IOC_AVAILABLE_MEMORY,
+            kfd_ioctl_get_available_memory, 0),
 };

 #define AMDKFD_CORE_IOCTL_COUNT    ARRAY_SIZE(amdkfd_ioctls)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index b40687bf1014..4ee3bcee12fd 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -33,9 +33,10 @@
  * - 1.5 - Add SVM API
  * - 1.6 - Query clear flags in SVM get_attr API
  * - 1.7 - Checkpoint Restore (CRIU) API
+ * - 1.8 - Add available memory ioctl
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 7
+#define KFD_IOCTL_MINOR_VERSION 8

 struct kfd_ioctl_get_version_args {
     __u32 major_version;    /* from KFD */
@@ -99,6 +100,12 @@ struct kfd_ioctl_get_queue_wave_state_args {
     __u32 pad;
 };

+struct kfd_ioctl_get_available_memory_args {
+    __u64 available;    /* from KFD */
+    __u32 gpu_id;        /* to KFD */
+    __u32 pad;
+};
+
 /* For kfd_ioctl_set_memory_policy_args.default_policy and 
alternate_policy */
 #define KFD_IOC_CACHE_POLICY_COHERENT 0
 #define KFD_IOC_CACHE_POLICY_NONCOHERENT 1
@@ -823,7 +830,10 @@ struct kfd_ioctl_set_xnack_mode_args {
 #define AMDKFD_IOC_CRIU_OP            \
         AMDKFD_IOWR(0x22, struct kfd_ioctl_criu_args)

+#define AMDKFD_IOC_AVAILABLE_MEMORY            \
+        AMDKFD_IOWR(0x23, struct kfd_ioctl_get_available_memory_args)
+
 #define AMDKFD_COMMAND_START        0x01
-#define AMDKFD_COMMAND_END        0x23
+#define AMDKFD_COMMAND_END        0x24

-#endif
+        #endif

