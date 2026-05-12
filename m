Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A21CD4F24
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 18:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98BAC10E2B2;
	Tue, 12 May 2026 18:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ZQZ4sKL";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013061.outbound.protection.outlook.com
 [40.107.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A334710E2B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 18:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmUBWArVK82b5VDy60GQ9BJ17rbURksHLig9BQiI+90OfkbjIMOx5VC8TbggDDO3zGadkUDgPY2mcGaneQxQ+s5U+LV9XcJ0hKsGuOpKrpdnY540ffvDDQ1XlzZL8ezQeJa83ge3rEyOu/cQVzOjYTbKCVwvwfEGuDPRbdSqt1SHhVOXT4HeHyeGETo/YCgWHePOKjLvzIx10xdBkqotmhhqUkxcfq7KnnnriOveJNLQV7TktucEitPTjQ9Zbsb5lS/gxU/puC4yFixdxtBZ/Cxbs78GqEY7MPTkouDh+p9ewJqrc2J86wubZmnO+cIVQbNfm18/3c29kOV63sTrrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoovoUWojwaF/U7MsHV6mdmJKpMNfJFyoxU3bsGKNmM=;
 b=grQEXA8x9QXluTkjVay8mB7m8q5hxNwhqqaXFIah2yWv6UfLM8VIRouJKzbwM/5ggQA6oYswAxyHGDvCNymP8qL0tU25W72cLfRYgA3Hmx20qj79S2V5mVGWv2Fsot2mda8QLNjfNncXCmmdMXDXTbPQOkiEVg0JXhZEK/YPhtugzE+UH188/qUlLXtt0cquaxuMb8EZJr986aqx+Kr9Jg8+23LkUcyTXLjXWYtPbTAaIHFkGZFaa2PeqFobkXr8MhYiSJrTRjYDzyP6rkaRZNR3DwDTbdABwgh9Srd8cld0A5TNR22u0S6IL6SoWH1IZCFYqSUHAap/zgRubxLWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoovoUWojwaF/U7MsHV6mdmJKpMNfJFyoxU3bsGKNmM=;
 b=0ZQZ4sKLUyVUpJSVNley5/lub9rK1+wzd7SJOa7l0miXmj3wvURh1HUuOjfIkbpEI6+hH7W287rxPEh4lvRGtCAzCI3KSaL67h+DUwEzhfKbJjshhwizmrj4MHeYKprHAm9leYML1dM5geq/2y7QPYOwYmlaP8lNyLs7OHJ3aQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7730.namprd12.prod.outlook.com (2603:10b6:930:85::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 18:00:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 18:00:32 +0000
Message-ID: <449d2d4e-ff93-4374-9eab-40a793485301@amd.com>
Date: Tue, 12 May 2026 13:00:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com, Perry.Yuan@amd.com
References: <20260511142259.1424915-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260511142259.1424915-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: a040cb4c-a596-4fed-a1d8-08deb0505c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: 0AKOEQNLW0nBHt5peI4RvxpRnoosthmqFy1SgUnkMfkHYnekoJegMyVi1UsRh9jRoWz7ymeToUVZai7cw/D1HJH2En9KfMNbKUQgybP4CXBJIa/R8RdC+fsDNSJYd7ZVae1scxOybOxpy1M5l7j0Ve5tjJY0SQyoo/wNKLkoaZan7F7Pa+d84C+tXf0C0E53ZS84F3lWuFa+7IBOcoI0+iwXHnQYKWmXAjH8Nb4zThrqKbEeUiPTSB0GNiR4zavMAl63RfIc32IIu8vXLhZ18cslHtizt5+2F7q8WSVneHzwme0RYjrlYkMzHoYMElRFJuWCk0otg6HZNG+qPmeMRvJNlPFQDHtZk1vw2pYRYJuQXP/2tlZNEKlHcRkrvLMaRYCuNq04eLdxlXucTW7YZwKjL15ytROCMUZker/Z+fODLzt3Mtze0CXVRgnM8+0CLDItw5e5UIf5AjZSkp3mzUVY7J/Xb+dwIIIsN1TTTd7wl5IrGgYu3PQe3E/t3BxbIZtR6kxEHkI3vuIXB9LAFVDBgM1zRkqnjpYqxm34AMIB5MeNlXNiSwf9f6uu3gwTC3tWyAioq6DdwWopyipG4ztbh5hX2sk6uzSXEGIlUJlobbUAuXuAN0kF54BKUWzxJE6o4rhvQYY6XnB8VfbU3SWzo48h8X1Deh1NWy3uqjSX0xf9umebr+ZoK33sKtIn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEcyek9BZHNVODBaRnREOG9zNkU0eitQZ3l1VXV2ZzBFM24zK3UvUDF5Tmsr?=
 =?utf-8?B?Z0ZFNzJVckVqZzBuczNXSUdSZG5rcmtRTXlkSzBHb2NZclAzY0xMaW5nMWVk?=
 =?utf-8?B?Q1d0TXc2TzVoSVB5K3RsNHZzR0J3dkkzMm5BZUcvdUNoNVp6NCsxRlVGOGJx?=
 =?utf-8?B?a3kzdEFRR2E1eWlXdTNWQ0pBY1lka0xLNkRiZkw0UkZNMmpySEh5MFQvNFA5?=
 =?utf-8?B?TklRUm1mRjJpRlFtb2dBNDE4dm9FM09OWThHaFhaUEFSNDRLUVVjWWtHWkpT?=
 =?utf-8?B?Q05ITS9vRTI1NVVDbzkyRGtvRTdXdjdOQndlNXlhNit4Z0hROHI2Z013NEl3?=
 =?utf-8?B?ZkZRL1VkYzNZbG9LUDk4U3dMSkVTS1RUNGRXc2VDaEVOQ2hwQTBFcVhmaDNv?=
 =?utf-8?B?eTUyWGt0Q0k4WmZXMk5CeGwyclVxeVlsbEt1aE1iWjdXNzUyUmhUNnFQd0p4?=
 =?utf-8?B?TE5MYXRVMUd4ZDNuUkJjampySSs1TlpZKzJxS1RyQjBtSGFKcWtGOHk0dTd1?=
 =?utf-8?B?ZmNMNmdqTmVXMFF0VUI1U0Y1b2tvTm5iL3dxTVpOcW91Y1ZrN25CMUxUSG5D?=
 =?utf-8?B?eDdyNmFyQTdGRXhqc3B0dkhnU0J4eXNBRTY2TW1NVi9QeUlDcGZwZ3RldzZa?=
 =?utf-8?B?R25Scm4wOU16MlJEMmJGc3ozbm9nQUIvaUlpUzlqRkpOd3JsK0RzRU9SbW00?=
 =?utf-8?B?aTVKeHA1RHFDMFErK2U5VUJTMmlVWk5lS3Vya3IrcXZDTTQreHJvNHp2M0ly?=
 =?utf-8?B?azR1OTRKYVJta0VCOXBTNmtUeEY4N0N4TFBWWmYrZFN5Ty90eTRFVmlNeU5M?=
 =?utf-8?B?amtOc1k0dGlCRVpkaXhZT05teHBZai9LTUhFYVBmRzZvdnliRUJmaGpMditI?=
 =?utf-8?B?R0twSkhoZXRhSTBXK0VOU0QzQkdPL2NWSERjY2RKb2g4cllLY1dEQVRXaXAx?=
 =?utf-8?B?c0VwSFNmUHNwTzZGSk5Xck9OV2YwdTJQcitzdFBQL3AxOVVSS2ZLc0V3WWFa?=
 =?utf-8?B?bVVhS0UyM1ppSHpaWGlYMlV1VXNVSlQ3WWlianh5QW9qbkVydW8vaW4xSTJZ?=
 =?utf-8?B?aGV0Ri8zdjZ3b2lmRXc3MkNrMmpwdnBMK0thbDNKalNzLzZJNTZnUnl4K0pD?=
 =?utf-8?B?akxFaG0yN3M1Zk5CS0Q1Mm1oQW9tZklOQkx1TWN3UUVrVWNTMnNqalNkUW5H?=
 =?utf-8?B?aStKdDdHUDFCak5xdzFuM01PK21ycWVKb2FKcFpWcmRQcVFLajd0VVQ0UnVz?=
 =?utf-8?B?T21sYkJIR0VQNHBMOEVDenVEdU9JZE45dEo4SGlZUHovRmZ4aE8xWm9vbTBE?=
 =?utf-8?B?VXFmSDZQWjdMbzh2N3EzVEt2dUJrdEZ6bjhuMGVzUkd6eFpVRWpUZURuemZu?=
 =?utf-8?B?ZFBkeEd4eVVFKzZRb0pRdnVaTnlVdGl6RFkvY3NOR01PUmxqbHZHUGdWTE1N?=
 =?utf-8?B?bHBBRiticHNpakQrand2amVMU0IxWUdDQmttd3lsaG5FUHR5cGdXWGU1d3hP?=
 =?utf-8?B?RzdualQzdnV5dVpaL1BxaUJINXFkZVk4UGE0UTUrb0xjbDhKZUoyRi9aMFV2?=
 =?utf-8?B?dlNMcVYrUGR6dXE4K1BiMkZyWWZUUURLSFZTeGk0cm5GYmp3Q2xKUEJCSmIz?=
 =?utf-8?B?akRiK0ZvcmtxQUNLYXk2VXhSQXAzRklNK3E2QW9NZXJySlpqNlpLRzJwYlFH?=
 =?utf-8?B?TnU1SkNRVm1EM1R6YmFTeGdBbGZNYmZrOTBEOUZIUnExbWpkR0lJZkhIQ1Zs?=
 =?utf-8?B?S1RxQUxRUlRoQUNDeEVYaXY5MHovK0cwOEhvK2lpNUUrSmZGZm9UcHc3eG1j?=
 =?utf-8?B?djE3cDEyOXJvWE5HYjZLaHZvOXF6bFRxcUNjSDREVjUrWVRWWUxURUFJaEJv?=
 =?utf-8?B?cWx3VE44MUFVM2VYbGRudVZoOXBucUFiZXIzZnVnQ1RYZVZVL0pkWWxhaWhI?=
 =?utf-8?B?eUIwMDFNcjBDZCtlM1pyaG9rbU9FSFVpdnpxQjVSSGZFSGg4Qm1kbFVqWlFH?=
 =?utf-8?B?d1hQa2Q1MnYyUStkUzVKMkJyUk1TczdWS3hRM3MrRTFRYm1nK0Mwb1Z0aEVi?=
 =?utf-8?B?Z1QyS1NTZ0VPeERmQjRYcHNjc1Q4ZktoVHV2MTkrMmIxN2VWWXhIS0hUWWls?=
 =?utf-8?B?R3RmNDR5cUVWckdtbzUxeGN1UStZa1VvSWgzak5qVmc3VE5IcUhueXREK29O?=
 =?utf-8?B?UFd6cjdpUTYvMllQYUN5bVZ4Tm05bnNubllIWVZtU1pveXA2ZzBNK0FmWkd6?=
 =?utf-8?B?N2YxaWs3Y3lMTXZvb3pyL29nNmJCQ1hOY1ltZkNFYVdsTVZ3MHlKOFhHamsw?=
 =?utf-8?B?ei9FNjdtUE5kZWZGbmI4Qmg0MTVUTVIxUEE0ZHdhRHlMMTd1dEF3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a040cb4c-a596-4fed-a1d8-08deb0505c11
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 18:00:32.6316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6vGahkfGiHUK/rV/XdZCeFMyf3cp4XefGbsTN+91GV3sD7ZlbyM3qV7MTH3X4ke5YKzKj54AfZA8St0tEX69Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730
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

On 2026-05-11 09:22, Yifan Zhang wrote:
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

As far as KFD is concerned, this patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 22 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 22 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
>   5 files changed, 52 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 7b10bbe28caf..d1dac3412a66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -36,6 +36,7 @@
>   #include "amdgpu_ras.h"
>   #include "amdgpu_umc.h"
>   #include "amdgpu_reset.h"
> +#include "kfd_priv.h"
>   
>   /* Total memory size in system memory and all GPU VRAM. Used to
>    * estimate worst case amount of memory to reserve for page tables
> @@ -320,6 +321,27 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>   		(void)amdgpu_reset_domain_schedule(adev->reset_domain, &adev->kfd.reset_work);
>   }
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
>   int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
>   				u32 domain, void **mem_obj, uint64_t *gpu_addr,
>   				void **cpu_ptr, bool cp_mqd_gfx9)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 2bf6a31c194d..5333e052d56d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -360,6 +360,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag, int8_t xcp_id);
>   void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag, int8_t xcp_id);
> +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
>   
>   u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1202a72ff063..6760c9331f46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5844,6 +5844,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	/* We need to lock reset domain only once both for XGMI and single device */
>   	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>   
> +	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
> +	 * accessing them
> +	 */
> +	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
> +	amdgpu_amdkfd_clear_kfd_mapping(adev);
> +
>   	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
>   				      hive, need_emergency_restart);
>   	if (need_emergency_restart)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 84b9bde7f371..1be1b1dd2341 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -69,6 +69,21 @@ static const struct class kfd_class = {
>   	.name = kfd_dev_name,
>   };
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
>   static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
>   {
>   	struct kfd_process_device *pdd;
> @@ -135,6 +150,13 @@ static int kfd_open(struct inode *inode, struct file *filep)
>   	if (iminor(inode) != 0)
>   		return -ENODEV;
>   
> +	/*
> +	 * /dev/kfd is a single chardev so all opens share one inode. Cache
> +	 * its address_space on the first open for use by the reset path.
> +	 */
> +	if (!READ_ONCE(kfd_dev_mapping))
> +		cmpxchg(&kfd_dev_mapping, NULL, inode->i_mapping);
> +
>   	is_32bit_user_mode = in_compat_syscall();
>   
>   	if (is_32bit_user_mode) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a6ff1db477f9..f037062c33ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -399,6 +399,7 @@ enum kfd_mempool {
>   /* Character device interface */
>   int kfd_chardev_init(void);
>   void kfd_chardev_exit(void);
> +void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen);
>   
>   /**
>    * enum kfd_unmap_queues_filter - Enum for queue filters.
