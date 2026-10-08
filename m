Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5A9CA600D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 15:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B76BB10E71D;
	Thu,  8 Oct 2026 15:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SIA+9IaH";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F63910E51D
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 15:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6SOnmpCH+H4w/heFcghNKlIIDzxzpYStVjUoNGt/3hgIyoHV6nhR+2vkhu3pkTmyBl4fDftCnlwVed29hFK6WpA9YVn8t4JTASi0YTo1b9WPCS6Z9xt22C8RbvOfjF3HQqb/ZsEG6i1T0xM2zFqCNBiyujYjkSddQFQqOUTzeGDD/e0Ux/w3li6BwP+Y+j5Gm0sJaLa4gZMhSBvo7Nefl9SCTM7ofd51fOJJrBoak/Db9pW5k84MiD4nNJcI0jk3rcTKxTbS6/9NTQp0q2sBY7crY3XLp58W68bOv+bhUxwdCJtT58dBLGOSoaFZD5QWMA/Wz3ewtQWoU8WaPH69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W2hyZexWHtZYjaVZJ+0fnHQqf1RD3Sja53I5+cq2e0=;
 b=o7HZfRyCVG0Po1GugNytvjTc5IqxN1TcKcSFLXG9NOqgLVAFzGzD8+OT4A6hUSV9+P+736b/JCHOARyzuG9P2BcOn7aKfXBO7tSsN2UD0vu+uKGeZ2vGI6QoHKk2GOUy4hE+4ZO6pSzdFE8FmwbPJldXzPf2YZoEjtLruimzqFQyI+9AQbFB+QlAfGVQGnkjh4Zrg92ha3OWJb14JFKea9cmw2YBDvB76H0/aguz7GFzcEDq41JsQv8XZEq5kKwPY/jSNDjsKRtUiceAC4xF5y9gNyOgk3qnLgMKMgpUiP9AiBKYn4gGnYrGwWcdamqZiXNM6WsF8uh6gVMSdmqUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W2hyZexWHtZYjaVZJ+0fnHQqf1RD3Sja53I5+cq2e0=;
 b=SIA+9IaH57Fs0v11tM19yagAZSY29UKGpYoaaikrD5DtaqyXaHi1GNh0WMDeggDRKxcOxxKLSSGI4HM0Uu7HLrpguz69hHS16QooExVR9YzXHaPyNeL/VFMbhG2MNEidchQ9KoDzEPoEXt6lKeAgyirs9ELLH0wNO+Gh24vFzt8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CH1PPF5A8F51299.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 15:46:54 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 15:46:54 +0000
Message-ID: <87e18cc7-2382-4440-96bc-605dc0828ab6@amd.com>
Date: Thu, 8 Oct 2026 11:46:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: preempt KFD queues before taking the reset
 domain lock
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kent.russell@amd.com, Harish.Kasiviswanathan@amd.com
References: <20261008140045.1283288-1-William.Palacek@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261008140045.1283288-1-William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0206.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::16) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: 4427a464-a505-4fc8-ed65-08df2553608b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|22082099003|10067099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: pmXw41aqG0fycYQoWGRU3kytyK4ly3GgkG3qqf9jBNzU63BEtw0W70ZchFoD59B5ULP606aknLZIbapCk77DF5AS8w+I/tUj5f+jeRpe12J32eTSLe3hqAWx7/mpO+Bhx28uj2CrUB/rTjE5lvMeWYwT0F0dDriOQiE8jNBfps+cJPCTikPg1CZt6PSfRfdr+TLpe3P2wjcnOPagmhFROwMp/kUr+C2XoufytYoTXbv//RAAdU9ErgidUmCEYv+v/APnaQ6tocHxD5Ly4CgwRpuzPnje8DqFBE4EoJMa0XjKOIGs1K75p5YZM++pYcdfIkWeQIedSV39j0shoxJhgzf6sGw3UVyh9d7L50rsVqoyoLJ6gICjQdyJ6wt4DKgLusPrzT4Ef2rJqamm7a9ugbcpRA2M9DhGe0B9HwHDnVvo5DrDygXqdDlNRTjGPQmxHFvlxL6l/9uNR6e7dr4nDUmuBFTO0YDiOjJsXR73PyzcUTJ8OOVVovRf/Fnhhhb9znK4ULXblwbowwMUsTOHCJQgUxLufNv8yo2upN9sT8VCD2XoutTqjJFUkWitlGgN8OfcnvOoGB7ThCHsmEynEbB67FUSGFJylp9y5K0lIZMrEBu0TmlXdWk2eniMDHAxnExEfvVvsFDusFGJg3ar6xDKP97t4JQJpc4h4M3Tj5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(22082099003)(10067099003)(18002099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXVMWFc5eVN4Z0hFcHUrWkVkcU9aWmRmN1FMTlNkWXdNZjkxN2JMM3kwR3lL?=
 =?utf-8?B?OE9lUkJlMk96REVQa2FRMlhPTTBHSzFrcmwzbkZCdUxwWElRL3ZYWVVGNTNn?=
 =?utf-8?B?UHhsVmZUUy9mYzhUaGlRbjRwc3hVYnRKL295UThqVlFtYjFDRENaeHo4VERF?=
 =?utf-8?B?Y2VkbnAvMlIyajhNNzNYMEhlbWNkY0s0SXZKQm55cUVpRGpseXhiS3BwVFY0?=
 =?utf-8?B?MW5CRWpJL3lXUHRLSWZNK2VGcHF5bGdIckttK2FHaTZBSzNxODlKanpyN3VB?=
 =?utf-8?B?Qlcwd1ZKRU04Y3VNK09maVYzMk9rT0d2d1NvMTFUMUpocG9tSk9tS0VnOXho?=
 =?utf-8?B?djc3Y21PSTkzSi9zUTM3amtmOWJOYVc4NnpHRkQ0ek8vbWJ2REtIRlhDaXNJ?=
 =?utf-8?B?bGU0bTNkU2R4V091YmVGcm9ZNWtTSDhualIyQUdScUhOS0ZJZCtDTUNtVTZW?=
 =?utf-8?B?NW4raHdxVUROVUI4MWpCbERFNlVuVXVZRFlyYklHSUxzMDd1NHhJUlFHVnpX?=
 =?utf-8?B?WGxKRWFUcnhadGRKWm1sa3UwbkNqTXFDYkNzTWlYckFuQ1cyVnZCUmZhYjht?=
 =?utf-8?B?MjJnTmRRanZhVW16Y2VvZngxb3dJWmVqZTZBUnJ3eGJXcmJaaDBsQzFaekxx?=
 =?utf-8?B?WVlJbzhFY2t2Q1B3dDBXTDBKTXlld05WM2ZkY1dlN09qT2NXUXBvMVBDSElL?=
 =?utf-8?B?TGlmMlozSGtYTXdDdG9pQ3ZmcjFWSkQ2OEM1eStPS0J5Vm9kYVg1dWJyOGtK?=
 =?utf-8?B?MHR1WnZoZkpydE5FZWJkOGpzYnN3Ly9TZkw3ODcxdGtOMWtQK0Q5Z3paZ3Bq?=
 =?utf-8?B?VlFQcm54TVAwbVRQQmY5RjlaMmJtVjlLRGFVdnhQVXZlbzVBdEhxZS82ZTFr?=
 =?utf-8?B?MW00OWgxY05nd1c3NWZHN2NYdTFwamtNR21VVGoxMDF1aVEwUjc1Qit5VmtC?=
 =?utf-8?B?QldXV1hCa1dvSlpnaFk4UlZHeElGdXoyWndpOG9CZEVQbUVUU0tVeXZ2ejNp?=
 =?utf-8?B?NWVON0krTmNZcU1WbEJsMkJqanFxSzZGcTRVVmhwNkVJblRPOUFpMURNM2ZZ?=
 =?utf-8?B?bTcwTGhPTnNVaE9uZFA4SSswRE1pdXFiNnV1aXFoVGt1L3M5YUlUcjVMdlQ0?=
 =?utf-8?B?NnNqZzNzUVFXdXNvMEhsMkNqVWZkVHdtRkQrLzltcU91Smptb1V3REh4ZU5r?=
 =?utf-8?B?U1lYUjRGWEg5c1YrS3lSclAra0oySUtudnFSZ08reVJzWmtpL2dOMEJaQmUv?=
 =?utf-8?B?R3V6dlJkVDJiV3UxdlMzdno2VXZrL1hxdm5MZ3ZOTGw2dlpWOG0yMURsSUc4?=
 =?utf-8?B?NHMrSVBhK0NYNHowQlZLRGwxQ215eDREOCtvSWtwY2lTbCtFVUticG1vcFBJ?=
 =?utf-8?B?NndKc0d4K1EzNEtuS21qZnFFUmJWOFE3UklFVWQ3clhTMTh2NlFtYXRoUVNQ?=
 =?utf-8?B?R0twc2pMSllEaWxxQ1UyMEIyUmpPaG5SZ051MjhuMGszbCtkU0NNeXhLKzN4?=
 =?utf-8?B?UzJwSzdyOCtKTEN2cXFoQWlPMEFRUnc1ckhQYi9vV3pKS01Jd0hmc3NER2tx?=
 =?utf-8?B?NVZ3RStCcEo1TExobmFuRE5FVVUxT09FdFdHMUhCUEFCMGxxdldMQ3c3eTRp?=
 =?utf-8?B?M0M1TnYwa0ZFbEUxdXBEWGYxL0VzL3ptN2R3VXhJWkdRWnRDRC9RdlkrNFlH?=
 =?utf-8?B?M2lCSnNMZ1Q0YXFzYUVyZ29DeWNoUytDWFhxTDZyK2hyLzRISVZSZGpiTFRW?=
 =?utf-8?B?YUZYU1o2c2lBdEN5c1RMWmVYTStKUG4wRkxCMzYyVHNLQUtVQXBHTkZnQlBE?=
 =?utf-8?B?b2tSaFN1czN5MEFrdVI0SGd2T3IvWjEwVEw0MHR6M01maENYVHI2aUlKNFE3?=
 =?utf-8?B?OFI5TEUzZzY2bnVlc05VcWg5L2ZpemU4aURNSkhsMjJJZldLUnN2azgwZGVG?=
 =?utf-8?B?a3dkNXBMeFB6MTFTMHExdDJ6SVZFa3VBRkxodFZsTTh1OEFpWkEvd0srS2tM?=
 =?utf-8?B?RDFzZ1J3T0lWVmg1QVB0cjB6akdPaHYyd2NIREFUMy8vQzVpcHJDUStObFBt?=
 =?utf-8?B?bmFmRi9OdTBYRlhLWThUNnJFV3hlbmN2Wjk0cDZOWlZoZ1BoS1M3aHMzeDZH?=
 =?utf-8?B?MzZNcUxRME5hL0N3cmVKdTB2M0J1bzBWdmw3S0ZkYU84TnpxVFgrU292NXBP?=
 =?utf-8?B?ckNXOFBjblpmaUdRR0luNHNNZXJ5cTd3d0p2Y3gwRVUwaXRKMUpoZUpJWE83?=
 =?utf-8?B?MlhheFRGOCtsS09ZSUpKdnErR000TEp3RWhqdE1uR1pXcldnWXB4WmtTQnov?=
 =?utf-8?B?WmU2Vm14MSszSEdCWUtERXoraXlYeWZuUGIrWks2T0dYQ2NvMHZVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4427a464-a505-4fc8-ed65-08df2553608b
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 15:46:54.4049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMY1dBS8WI8eMMU75x4ife1Fd9BaBvtz6sQsg9KJzkqbRj4eBxTxalwdrB9uMipEzcVW9xOm9DA2Qy2/AAtX8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299
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


On 2026-10-08 10:00, William Palacek wrote:
> A GPU reset issued while processes are using the device can Oops the
> host in munmap() (free_swap_cache) after SDMA write faults from a user
> queue whose process has already exited.
>
> amdgpu_device_gpu_recover() takes reset_domain->sem for write before
> amdgpu_amdkfd_pre_reset(), so the down_read_trylock() in
> unmap_queues_cpsch() and execute_queues_cpsch() fails with -EIO and no
> unmap is sent. stop_cpsch() still clears sched_running, so user queues
> keep running while their memory is freed.

There is a general assumption that the GPU is stuck when we're in a GPU 
reset. It seems in your scenario, the GPU is not entirely stuck. So you 
can still get interrupts from the GPU. At the same time, you can't rely 
on MES or HWS to unmap queues when the GPU is in a half-broken state. So 
while your patch may help in this special case, there could be other 
cases where you can't reliably stop the GPU from sending spurious 
interrupts while a reset is in progress.

Maybe we need something in the interrupt handler to ignore interrupts 
while a GPU reset is in progress.


>
> Call amdgpu_amdkfd_pre_reset() before the lock, for gpu_recover and PCI
> error handling. Skip the dequeue when the HWS is hung or the PCI link is
> down, so recovery does not wait out the preemption timeout.
>
> Signed-off-by: William Palacek <William.Palacek@amd.com>
> ---
>
> Notes:
>      v2:
>      - Drop the SRC_USER gate and the helper; run for every reset source
>      - Cover amdgpu_pci_error_detected() as well as gpu_recover()
>      - Skip the dequeue when the HWS is hung or the PCI link is down
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 16 ++++++++++++++--
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c    | 14 ++++++++++++++
>   2 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e0014611f039..8ae6228dbf31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5479,6 +5479,16 @@ static void amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
>   	}
>   }
>   
> +/* Dequeueing needs reset_domain->sem for read, so run before it is write-locked */
> +static void amdgpu_device_kfd_pre_reset(struct amdgpu_reset_context *reset_context,
> +					struct list_head *device_list)

Instead of adding a new function with a confusingly similar name, should 
we change the signature of amdgpu_amdkfd_pre_reset to accept a 
device-list instead?


> +{
> +	struct amdgpu_device *tmp_adev;
> +
> +	list_for_each_entry(tmp_adev, device_list, reset_list)
> +		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
> +}
> +
>   static void amdgpu_device_recovery_get_reset_lock(struct amdgpu_device *adev,
>   						  struct list_head *device_list)
>   {
> @@ -5534,8 +5544,6 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>   
>   		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>   
> -		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
> -
>   		/*
>   		 * Mark these ASICs to be reset as untracked first
>   		 * And add them back after reset completed
> @@ -5784,6 +5792,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	/* Cannot be called after locking reset domain */
>   	amdgpu_ras_pre_reset(adev, &device_list);
>   
> +	/* Cannot be called after locking reset domain either */
> +	amdgpu_device_kfd_pre_reset(reset_context, &device_list);
> +
>   	/* We need to lock reset domain only once both for XGMI and single device */
>   	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>   
> @@ -6232,6 +6243,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>   		INIT_LIST_HEAD(&device_list);
>   
>   		amdgpu_device_recovery_prepare(adev, &device_list, hive);
> +		amdgpu_device_kfd_pre_reset(&reset_context, &device_list);
>   		amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>   		amdgpu_device_halt_activities(adev, NULL, &reset_context, &device_list,
>   					      hive, false);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 5e57576fba21..988fce11a4fb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -81,6 +81,16 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
>   			       struct qcm_process_device *qpd, bool verbose);
>   static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q);
>   
> +/*
> + * A dead HWS or an offline PCI link cannot service a dequeue request. Skip it
> + * rather than wait out queue_preemption_timeout_ms per node.
> + */
> +static inline bool kfd_dqm_can_reach_hw(struct device_queue_manager *dqm)
> +{
> +	return !dqm->is_hws_hang &&
> +	       dqm->dev->adev->pci_channel_state == pci_channel_io_normal;

Is pci_channel_state always valid? I notice that pci_channel_io_normal 
is 1. pci_channel_state is only set in amdgpu_pci_error_detected. If 
that never gets called, pci_channel_state is probably 0-initialized and 
this condition will never be true.

I'm a bit cautious about spreading different versions of "is the GPU 
usable" throughout the code. There are lots of things you could look at. 
I've seen different conditions related to GPU hot-unplug in another 
patch I'm reviewing. These kinds of conditions should be managed 
carefully, otherwise we end up with subtly different or broken 
conditions all over the place and it will be a mess to fix later. Or the 
the code becomes unmaintainable if the conditions need to change, 
because now you have to change it in 15 different places.


> +}
> +
>   static inline
>   enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
>   {
> @@ -314,6 +324,8 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
>   
>   	if (!dqm->sched_running || dqm->sched_halt)
>   		return 0;
> +	if (!kfd_dqm_can_reach_hw(dqm))
> +		return 0;

Why does this return 0 and not -EIO? Isn't this logically the same as 
the next condition? We don't talk to MES because the GPU is hanging and 
a reset in progress.


>   	if (!down_read_trylock(&adev->reset_domain->sem))
>   		return -EIO;
>   
> @@ -2832,6 +2844,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   
>   	if (!dqm->sched_running)
>   		return 0;
> +	if (!kfd_dqm_can_reach_hw(dqm))
> +		return 0;

Same question as above.

Regards,
   Felix


>   	if (!dqm->active_runlist)
>   		return 0;
>   	if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
