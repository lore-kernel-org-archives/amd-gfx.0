Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DAACD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 06:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E19BC10ECAF;
	Wed, 13 May 2026 06:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TK2nngH8";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2949B10E1B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 06:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jw4Zjap/upYbZxs2UL46dPwJ0EuQLUiuMHn4OFMWajguPFc0NlRZHs6IvQWW6KcBgCe11gplAXPDFd2X98YhEAZTPyeK0TEEL3+DSJvcHHi0YzUogRKqYT/Ni+LJXMCaIJMRBWaUZLTjO0f3gRAJh5Vuu7mC+Jqp1ln9kxixPBnqa04SyZDlwd707gvhkHh7p2QswaAs9B7fhduHNB3NHVCj0Huw9IsH24XhDLnc3X1W84sXMcFzLh44zrjwjgQbFdZIVFsvzVgQTr7blm++dFAbvrqeOW/z44a1aaBgdnek0OH9yIJONJ3H9ouLEm5eGQw0OR5mhE2wgHBBPm1MXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x79tPs8/Yd4uAc8sQkorfTeb41/qkAV/G1eNcLjGf6s=;
 b=xG7NrXyJvKiq3MovsBNNqCpsZQT6ZQCJ8SGxDWctBSGM2T35V0HfN+QtPgkO2/reb8/bJ/rkRZzISDAPCrSUnRftJQ9NbtkVvkPOS1wqHNRQbwFct9HMe4YRZwGdb6q+MIo2p5EEZUs+EBZIWFSgUSftYzvfamyhiypTQm6dJmsQJLiG2xdcLwXYUAFNCgnAWJaRrDpNpfiwwIAujG9s0Q9V89KISFsnLBXH2Fiq/DcgYLFuGd1psqdnyG9YXJKKioCeXqNtbubwdrQWPcmqAz2b/AORTUlYZD/dUDG2DICt507WutA2u6MUFl+HRxe2tMGZ/qbJhiDAiN6K3BIBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x79tPs8/Yd4uAc8sQkorfTeb41/qkAV/G1eNcLjGf6s=;
 b=TK2nngH8JlxtI0Kk3eTxhQckSFHkNh4tVkF92j8z811mWEA1CDFNOTzGRf9dDWYUHGeg793mBhCXssgyZDOwD9L+F7435YB8rn7KdEy03QN7QfOsNnMynirwkE1gBDCvs61cuIwXECVsf+b5zS2PKhpcaB/Tex8SvPtKN83tAyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 06:58:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 06:58:38 +0000
Message-ID: <f40f3088-073f-40cb-9e3c-38da7b101f27@amd.com>
Date: Wed, 13 May 2026 08:58:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Perry.Yuan@amd.com
References: <20260511142259.1424915-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260511142259.1424915-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c3054f-d719-432f-2405-08deb0bd0ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BRoMp3E268XiCEBsQilkCrLKPf0cTjmq5oW9ZVubuwGd2PI5qnwg/xLD16hXFMrKNJLBNfAsFjdrvyFYH/hj/jK2WVyhKI2qFfoqIgz/LZ5rX9v2kQXKl423kN+hb0CCASL4j53WfPg9BhoW/De7q7kFkJIy3ZubztlPK5JxY9Wp+j8kFZF0TSEl40Bxi3FBDj26eARXt+mlF8OQi8AabbxoitkPp68Ifv7nY5SbXvFF/T08KVoMNbDQV03kijYG9LB0xmfvI9HOX2Jcz16obZ3s8e7GArE9nTX8EfpnLQgqvkesx82g/0T41sKNK/S+/oIS+GWibkgEZrqhSoL3nGu9sy+VFlYGkj7v6YBBKLhr9xOfJimVLmdCEk4Q+Qpl2ABTsmpoJlAlg0+hHIm0d4GmDKX5Qx1GJKOQ6LWzk4WAl8buPowDIHu1+dHfIwBFOAa8B/jclZLMwsqirAYTgrwIHyKLfSnG9gZoMR3FDFjJ427y7gzO/rrkbOmuM/dnU6E+NiNYY2WogK/y6Vo2QKi9rO9akRm5Wu1NLMgwz6GUfRpc5bp4Vf3YtYfFxM0e33h4UCf2UAy0sOPad25fkgYqBMmaL6+5aJpkQt0/yiPWcUN/JsD5bnShV9fbGpPXJtuqaG3WpCmCSmytJJHdg68v4DnEm+CJLTyc0Z2plAyYfAvp6/uJqfaEHi+DMwpc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzRuSVVHY3Q2ZHA1ekRnMitjN1lTb1VZZUdXTnMzSXRlK1VFaERQdFFuRUhw?=
 =?utf-8?B?eGhkbDA2N3BpS3BPNU1YRXJndGJuVEdaSm41ZUU3dWFYa3c3Qy94M0xHUTdv?=
 =?utf-8?B?Vno4dTJPYXlkYzUvd1lNaFU4UUNWVlZKQnRWTkhsVE44Wk4yVDBQOEZCckNT?=
 =?utf-8?B?alNjNDNRakZpdmJCdlNpZkNHSmQ5eEo5K0pwQkhoUGM3MUNnQmh2THBUK1JJ?=
 =?utf-8?B?eDlTaWZvcE9obEVTTmlJY2JicHUvN1llME1OdE54aEkxWkgzQTAxR3F3d1dn?=
 =?utf-8?B?enRLcm5vV24wbGxDTWE4V0d6NHhTSHRFeTkyZmxXT0RzVzN6TS9XWUJrYXJP?=
 =?utf-8?B?VkR5eTB1RGdrM21zV2pVYjVZcitickk3MENrVGhOTXFGUHB0b2pHUmtCZVNN?=
 =?utf-8?B?QVJIbHlnSDJKQ1AzekZsYkgxU1BZQUM5RGh2d3I2WDdnb2J6c2tHeXNUZy9m?=
 =?utf-8?B?c3pTc2RJeEcxUFQ5Nm8zRlhxdmF3c1lnU3J2S0hrT3BLeWg5WmFKc1ZqYUJS?=
 =?utf-8?B?NmJhTisrcERTQk9iQXNZWEtGRDAyMzFrc2pUbElWbVRENXFNTUZUclBPUGJo?=
 =?utf-8?B?ZFFhbjhZd3k4dXVWMXQxczdDdkRWd2tTU1RuUk1XNW4xSUhDdFd6azZqTlMw?=
 =?utf-8?B?Zy9DeDNyQ3lKVkZsOXJYVFhndmViN1NXYXJFRHJTQnJPNWFreWFqa1ZaZEhM?=
 =?utf-8?B?dDBoSEd5OHhwUWlLSzJmZVBIMDliamFTLzVkZkUwUWJxOU9yTHdoWVZtWkRR?=
 =?utf-8?B?amQ3RDZGaEZyd25kK2UxaHc1QU5sWVdHSllkbmRXUUF6MC92cTlBdGF0M0U3?=
 =?utf-8?B?Tk1mNTQrMTdSWXBBU2lEbi9FU1hnbmdpa2R0UTgrRzEwalpmRTM3Q3A2UGV3?=
 =?utf-8?B?SDY4d1cyRExpTVBqUlpIME92ZEV5MXRrSlRmdXhvYWM5MzRta0dVQmFBeUlE?=
 =?utf-8?B?aFFSdWhtN2U1SlVOOGIxc245c2lsNUl5SGFqZEpHVjZkb3lhbUZPck13UkZv?=
 =?utf-8?B?bStNcUM1aVA4YnBkVlh0OXhBVVBpaFNHWCtmSU5ONFhtZjFCUFJ5UXhCMktP?=
 =?utf-8?B?OExYR1pTZ3BJbXJRd3hvZ21TaWY0UzFnK2hUTzZLYmVFMGRFbnI3ZkZGaHBW?=
 =?utf-8?B?eXUwVXc1azVaQnN5TW52Yk9XUEpwY3ZLUUx1VTNEQWRxN1p0SndCRHl1bHhU?=
 =?utf-8?B?N0lveEZ0bXFMckkwdzJIWE9OclFETDdtaDFrUUVxdzZSOFFsbjhaUDYwRmx2?=
 =?utf-8?B?bllYMER0MTVPN0ZMcnhub3pPc3h3TjluOTcyMDBSV3Nqd29EdWFHWUZ6d0hs?=
 =?utf-8?B?VzBkaS9xQ1QranB6dE5GQlJScTAyMWl4YWJ0WUJ4M2RHc1ZnZFhTa2s5WVEy?=
 =?utf-8?B?MFI0ck1yMTF5ZmdQMnROcTJwYXJ3ZEV1TXNoWXQzZngzZytDajFweUdaTGdW?=
 =?utf-8?B?TG16OHNlQWZTcStXa3UyOHVmUE1rVVB6RTV6NGZmTkFKUElxRURDcGYra3h2?=
 =?utf-8?B?Rld3cEhYd2FaVnBUSXAwYTZRbldoVVE3d0hENTVhUzdqU29BemEweWVQcXQy?=
 =?utf-8?B?ay82YlN6VWFOTjIwV1d5TXl6Mm1JUzd1bDFxV1ZWWDZGNXpXQlhmdmNkY2Fm?=
 =?utf-8?B?K0lKNmVlMnF3cmVpQU8rWmFxWnl6dlZLS0RwR0lXckZxdWtvN0EyZjBzWnFZ?=
 =?utf-8?B?VmFDaVpUQnlFbStxNW1Hdk5JY3pEdjJLdlRzR3J5RXdSM1docS9LTElIN3Rk?=
 =?utf-8?B?RXhqTkF2REtGT1VFcjlhNm5WemJ0alVrTzZPYVJNcFBuU3RyWDhwUldVbnhW?=
 =?utf-8?B?Nzh5TVpiOUhwaHpLTUZkR3hlQnhpQVZkenlucC9DcDdiTUNpZWRNREtGZTRG?=
 =?utf-8?B?bHB2UWdXejJZUnlDY3hXNWFCOE5wa2cwYmowMnJLUWF2NHZyU1ZWTWhXOHpZ?=
 =?utf-8?B?WW5qWFA3bnNtZFR5Uis0Q0t3bVFTNFA4bmxYOEt4aXdsNjZwT09hV3FDdDBs?=
 =?utf-8?B?ZHYwRWxZRU9yKzNJaGJ1V1Z5R3pZMisvZTE1M3RCb1NienBXekg4ZUczR1pi?=
 =?utf-8?B?T3NSNXZSUExQYlY4TGFNNDJuVkhVYjZlMENxZnJudldSUE5kcE82MDlEYWNq?=
 =?utf-8?B?ZW5yTmR1RjV1dEdMMXBXb1dpVUg5eWh5Q2YrVC9MUXZFSi9TWHFIeG9Jc20r?=
 =?utf-8?B?NGJQK2FKanRNYmpUcjA1VUVYQ3dwZHFRbTlvVTYwZzNvL0g2bHc1YWNxeDhm?=
 =?utf-8?B?YmlyemF1R3lFaEZwemRUTlRaUnhwbmtLYmt4YkE1cDNwWmhBbFhuTkpZUnRD?=
 =?utf-8?Q?BhAsmtTHlPG0s27mxF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c3054f-d719-432f-2405-08deb0bd0ef3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:58:38.1024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gf/o5dWZ44LAuRngBdJXLWPFKwgmgULUyBHZQu0Nhu9z968M23k/QNKzO2XL9M1V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
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



On 5/11/26 16:22, Yifan Zhang wrote:
> During Mode 1 reset, the ASIC undergoes a reset cycle and becomes temporarily
> inaccessible via PCIe. Any attempt to access framebuffer or MMIO registers during
> this window can result in uncompleted PCIe transactions, leading to NMI panics or
> system hangs.
> 
> To prevent this, Unmap all of the applications mappings of the framebuffer
> and doorbell BARs before mode1 reset. Also prevent new mappings from coming in
> during the reset process.
> 
> v2: remove inode in kfd_dev (Christian)
> v3: correct unmap offset (Felix), remove prevent new mappings part to avoid deadlock (Christian)
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
>  5 files changed, 52 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 7b10bbe28caf..d1dac3412a66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -36,6 +36,7 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_umc.h"
>  #include "amdgpu_reset.h"
> +#include "kfd_priv.h"
>  
>  /* Total memory size in system memory and all GPU VRAM. Used to
>   * estimate worst case amount of memory to reserve for page tables
> @@ -320,6 +321,27 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>  		(void)amdgpu_reset_domain_schedule(adev->reset_domain, &adev->kfd.reset_work);
>  }
>  
> +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
> +{
> +	struct kfd_dev *kfd = adev->kfd.dev;
> +	unsigned int i;
> +
> +	if (!kfd)
> +		return;
> +
> +	for (i = 0; i < kfd->num_nodes; i++) {
> +		struct kfd_node *node = kfd->nodes[i];
> +
> +		kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_DOORBELL |
> +					    KFD_MMAP_GPU_ID(node->id),
> +					    kfd_doorbell_process_slice(kfd));
> +		kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_MMIO |
> +					    KFD_MMAP_GPU_ID(node->id),
> +					    PAGE_SIZE);
> +	}
> +}
> +
> +
>  int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
>  				u32 domain, void **mem_obj, uint64_t *gpu_addr,
>  				void **cpu_ptr, bool cp_mqd_gfx9)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 2bf6a31c194d..5333e052d56d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -360,6 +360,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>  		uint64_t size, u32 alloc_flag, int8_t xcp_id);
>  void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>  		uint64_t size, u32 alloc_flag, int8_t xcp_id);
> +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
>  
>  u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1202a72ff063..6760c9331f46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5844,6 +5844,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	/* We need to lock reset domain only once both for XGMI and single device */
>  	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>  
> +	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
> +	 * accessing them
> +	 */
> +	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
> +	amdgpu_amdkfd_clear_kfd_mapping(adev);
> +
>  	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
>  				      hive, need_emergency_restart);
>  	if (need_emergency_restart)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 84b9bde7f371..1be1b1dd2341 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -69,6 +69,21 @@ static const struct class kfd_class = {
>  	.name = kfd_dev_name,
>  };
>  
> +/*
> + * Cache the address space of the chardev on first open so that the reset
> + * path can drop all userspace mappings of doorbell and MMIO ranges via
> + * unmap_mapping_range().
> + */
> +static struct address_space *kfd_dev_mapping;
> +
> +void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen)
> +{
> +	struct address_space *mapping = READ_ONCE(kfd_dev_mapping);
> +
> +	if (mapping)
> +		unmap_mapping_range(mapping, holebegin, holelen, 1);
> +}
> +
>  static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
>  {
>  	struct kfd_process_device *pdd;
> @@ -135,6 +150,13 @@ static int kfd_open(struct inode *inode, struct file *filep)
>  	if (iminor(inode) != 0)
>  		return -ENODEV;
>  
> +	/*
> +	 * /dev/kfd is a single chardev so all opens share one inode. Cache
> +	 * its address_space on the first open for use by the reset path.
> +	 */
> +	if (!READ_ONCE(kfd_dev_mapping))
> +		cmpxchg(&kfd_dev_mapping, NULL, inode->i_mapping);

That stuff looks really odd. Mostly @Felix why is that necessary?

Apart from that the patch looks good to me.

Regards,
Christian.


> +
>  	is_32bit_user_mode = in_compat_syscall();
>  
>  	if (is_32bit_user_mode) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a6ff1db477f9..f037062c33ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -399,6 +399,7 @@ enum kfd_mempool {
>  /* Character device interface */
>  int kfd_chardev_init(void);
>  void kfd_chardev_exit(void);
> +void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen);
>  
>  /**
>   * enum kfd_unmap_queues_filter - Enum for queue filters.

