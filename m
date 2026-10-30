Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BFA606B79D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=14fK8bfY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73CD010E094;
	Fri, 30 Oct 2026 21:24:44 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013023.outbound.protection.outlook.com
 [40.107.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C069510E094
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 21:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SI93TeNtB6bzQSQjMZ9s/YeyBRZDkaF1gdaHjhR3HbDznreMZjvJMb2EAd2Eo5eBVNmIE2tVhHOzMSdsdDgWy51XAASJ2FJdNHrV1lcDLmHJcqKlCBZ2cUvy+cILhGacA2u0TZg0INIBOxWJls0IHcABoJhLyd/8E0a/KwUP/J+uvU0cYWvRlbHcsiNXvl6FX0zCl6m709uig6OTajncpaQC6ZcFwK7Qn4a8SGGQZYmN3z4PbzPEXCbaPpdu6swbnlvKKDgnLyX/BOfCisQbn4W1dlrWUFg8+zMWAc3NcUJMn+5ZJEOtJuZJSbXbMJ8Eh7KeG7RfY2aHv+AWDrNMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnyzaK6PBUa94S85Znz1NSXoy8gMfVWP54k1yI0ZJWw=;
 b=woSWFWZXy0H8wTDk/ksTOAzJvUTnmhMK3c/QnCdL7CkNtGqdEOd1ufQrllCF8a6eo/b/idcmjd4hhh4C3kU86ynuWKQvGKgsbaEX509Yy/HLmdJyey/eZdlexhBKit1vMm9hMUM3kMPlH+0Nvb915Yb/QSmo3Ybwl16OC3ZoMYkf6T1Jne/SkO4VHQhyGMBJqUCbSKJSEDKEPrlB0XdSxjS8PMCB77nfOmY0E36KvAMG5nv1WXHbLrNT/b1wzY6xI2utmfM9KEXgb3m7IMk73AvIQuSWK+/WtTJ8+ZJ88fc9aaif3lgIJoBQhXwVv5qd/KzVtlmcNXgBm1qLZFhh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnyzaK6PBUa94S85Znz1NSXoy8gMfVWP54k1yI0ZJWw=;
 b=14fK8bfYUBFVBti2VwHUPHcej7JYB6UHLTvfiID+xND1xFhbZ2aLBrG9YZMRU3Lb8rO1+AC0Z/VJN8fxMY+xuYOFUi6kKp2v6A9PsnowOyc+q+VmikjZ3KKOjyID4Qe9Al6qL6Z7y0vxsbiImnzvElW+TryITJ0U/qrhR8Ki/jc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CY8PR12MB8298.namprd12.prod.outlook.com
 (2603:10b6:930:7c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 21:24:33 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 21:24:33 +0000
Message-ID: <20005934-e7e9-4479-977c-4b74236978d0@amd.com>
Date: Fri, 30 Oct 2026 17:24:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amdkfd: Get reference to svm queue buffers
 during CRIU resume
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20261030140550.2524662-1-David.Francis@amd.com>
 <20261030140550.2524662-3-David.Francis@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261030140550.2524662-3-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0051.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::9) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 617b2aad-e6fc-4941-8bb1-08df36cc30c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|261021121427099003|261028144727099003|261021123027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261022105027099003|10067099003|5023799004|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: UOJOZ6FQ7j5NmK917uFMn/29KbA6NP9vCsZsdhMO026eMGUqLVBX6F5BWemthEYWIHK6pPK9krEggkpUq1k+dTzdonUKZOs26ADezJnm+lT/sdQ+j57Gkh2GQpjn/VcqycXF2SZSOSeSmRzBGE1xM9yVVPfXB6MtOO/qtuJdirq6c2dG05A/ZXV+si0D26PJgHxY8Ta1rDTc4SOsbGpjte+9DInCbzRZYjECoHdqbtmhpHCurc1QlTnNyN6YEZEhuNJ+KvtCoV1KhSEPZ02gyzY5FNp6PAwq0+L4tJ8wwZtlxxkWZHwPQz2oHfufSXPGL1c5rQkvgX8bV1iJQGHZTQU2yvyH5R9NZOeoryi8Scj5efNQE4TvjbFI1M3iZj/BrbmiKzcvXhXRpQb/0vs4UqICBWhw32i157K6jfOpxOvVc+vvKILmnJzq7xaQFx8OSHbzmHRcuKE7XDLf380HR39HiBfn5l7myR79PgggF3erN9sMhRWORrtnu3Kw14uQAkVBn164UqCKteaoHhea5vntIiszdlmQ5CL04wTD765kNmQ6SZ2Wmlxqir7pllvpeHabAOwjrPVav9+LmEx9hZxM8cxrGsLqZEnf21+PRjCwLPGry/UFA4HuxFxd9s+ndfgksv6spE6wjmZEUjwsIebKSQDE//hLiL8RiUeEfpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261021121427099003)(261028144727099003)(261021123027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(5023799004)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnc5T2E5L0c1TGliNTNjUSsyVHQxclpvdWRrUkkvUnV1eG9MKy9RRW9FR1U5?=
 =?utf-8?B?K2w4UUxBbjNDUUFyUWw3ODc1aDk5bXBram5OVTdrZmlndzQ1ZDY3MW1Va055?=
 =?utf-8?B?S1lJcW4xbVlBT1VybURvb2E3L2p2WWo1S1d4SWZoMXlUdk9DSkVERHpWakdm?=
 =?utf-8?B?RHE4bjlCdWpxL3BaWTRKeVZUYUZZeXFwdXRrYnhlOHFmb0NkdHU1NzJMZTJW?=
 =?utf-8?B?WjBmYlpCb0tNYUVQcmllenJzeElsOWw5dHMvZnlpUTFLTWdaYjZGSjNSakVT?=
 =?utf-8?B?WGd0dDZrTkt4VGhleGo1d1orVXpDdlNmZ3cyajlJVVNiemF5aHhtOERzR1Jp?=
 =?utf-8?B?VkZnZ2laZ2R2M1ZnUGRoa0lvZXNETWxYa3Z0MXkzUVZid0J6ZjRMN3dpWUdy?=
 =?utf-8?B?UmxlYUVTYVQ0Z1ZmNUNRSnNnSEY4SU53NUk1YXllUTVuK1FPcC9ZMWZEcHVQ?=
 =?utf-8?B?OWZxd0ZLakc4YW5QMER0MlNnanZWQzUyYWo4OEdPT29QZ2libDIrTk1TWjcz?=
 =?utf-8?B?ZC8vbHVvYSs5K1hFcktqVmZLRHJsMUp3dTUzYkU0MGh3ZE95YTMyZUttbU54?=
 =?utf-8?B?ajlQNGVzQjdqeW1zWURlbUwvNEN2ZWVhNjhvM2xiOVlkNGFaSVdPRE9VdUJr?=
 =?utf-8?B?dWVWZndSSnJkRStRK09xV04xUk05Zjl6TEZRNjNPNHRHRHo1RzBrM0VCZlVo?=
 =?utf-8?B?Y0JSbkIrbWJyeGhOQXJHK3g3Rm0ySS9obXRQbzhWK2lLNU4xaWRNZWh3R3BW?=
 =?utf-8?B?K3R2NjAydXR0cWNMWXJlZXVhcG44eDVQdnlBQ1ZFWXJTNkNXRGJYNHVwbE5v?=
 =?utf-8?B?emtpakIzSHYyTWlzWTdRS1FpMGZxcFVKd0xMSFVaR1BMaU1SVzJ4QmFLTmVS?=
 =?utf-8?B?RmppV1B5bkZuUHVXbUVTZWJIR1NuTG5tMFRIRTc3M29jN2kyaXcvVGdYNHVE?=
 =?utf-8?B?eVVpMUFWRTNUbC8yMlNlb3QvcGg3bjlHR3VGVEVDZ21vSFRlaGhmRncvUkJw?=
 =?utf-8?B?dldTT3MvVnpSeHZpZjJycWJlSmxuYUJsSXVOZjFOMFRscGI1eG9Wc2NkS3d3?=
 =?utf-8?B?QytiUFhudS9MeHhtUDl6M3QxMXd4RXVNZWI3Vm1IYUZva2VFaHpZQ2lpWnRp?=
 =?utf-8?B?T0VsSGcyaFFIMnJNc0w4dTJBMHdWdlFsTGZGdzM1c3M3cmJpOEw0MzdYbzQy?=
 =?utf-8?B?Ni9ZMDkzU00wNUs4N0FsUjNCN0FkWEo2VlQ5YkltSFhpVGFCWWg0aUZSb29r?=
 =?utf-8?B?aVhIbFBLSVNiV2JXK3NVOGNzOTNkcHFnZVZlMWR2TVhmbk9lclhKSHY0eHQx?=
 =?utf-8?B?TUZVc1JKNlZSOUlnVDdrVmg0WnlMY016QXBxQTVVQXZUQTUvUXNEbEgrK1VI?=
 =?utf-8?B?UEdPMVhRUm9wZThycjcvck9XcUg1cUpRczlHVzNrTFlYc09VY0hjZ09UWDYz?=
 =?utf-8?B?ZzdNME5YenVQY1FielI5UVZ2MXdKVkVvUkNkRk5nV1o3Zng3MFJ2UXZEaDc3?=
 =?utf-8?B?RCtjUjQyems3YzBUcUpnaU92UU1QZ0pKUVhJQ2R5K3N5VzlqS1VlUnFBK0VM?=
 =?utf-8?B?QnRWdkxTa2h2SGlpbGdDZWJFM3dDNlBDTWQ2NHNRK0pjKzErTWJTcjNIMzFy?=
 =?utf-8?B?VWdNS2l2aGg1RlQ4Y2NBWVpDU3VMems2aGFxM1ZoN0l2dGtwNnBHN1QvZmFN?=
 =?utf-8?B?dHFaMVdkb1dLVUY1L1BmYitoOXM1Ynd0cldRdERZTTNUdWZtQUtQWWRtcXpN?=
 =?utf-8?B?cEVkcjM5SnluRmNsd1pBeFFmYjU0WlIyV3hsMUxnc1I4ZWNGNVdITEFraVV0?=
 =?utf-8?B?aFUwSDNyNzVTZzZYeC9kSzFibDVlazFIVnZNS0dkL2lMTHAwVDZBcTc2RWF2?=
 =?utf-8?B?WTB4bldCVDRNYnZOT0JGWk9md3hCUzk3aTJvWmkwUG1DYjk5c0pSMVh5T0dO?=
 =?utf-8?B?cWxCcFlCQTlsVWRrZnEvS0lwb2dDc2NnbXhIaFNXcjVXYyt5Umxub1ZFSVk4?=
 =?utf-8?B?dmczU2dFU2U1RjVzU0dYNXhGVXNBR2VDVVo2V0JNMjhLSlNDcjl2b3NNUkVB?=
 =?utf-8?B?dUlZZ2xtaCtaNEtWNlEyZG1uei9KdzZIamI1YmV0VkpoOGdDYVU0SEZoSmhH?=
 =?utf-8?B?ODR0RmRVYVQ2YmcwUjdsZW1BRGpNbVRtcEQwWTBMbTZtU1pBS2paTDZiMkJI?=
 =?utf-8?B?R3pXVDdLblh1bUJnODBOaThOOHAxY2YvVHNwMmErR20rbWcwNndJbGZnRHMv?=
 =?utf-8?B?RGZkOFFFdVhkVEhPZ0kwdVVHajdyZTRaTkg1WEpvRy9SbS9EQmdqd0JtUWxk?=
 =?utf-8?B?S3F6bkdqa1ZqMWZIbjl5aTQyWDdFc3hOOVo2YXRvUDRET0F3NlJlZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617b2aad-e6fc-4941-8bb1-08df36cc30c2
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:24:33.0223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzh0Hs3peLWeBOIEFNyW9ceWva9kOFbM7CfEGwVMnS62hkRrvzu56J78Nhu0KTt6UfHkISD+tRoAcrm7QOXuqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 2026-10-30 10:05, David Francis wrote:
> When a user queue is created through kfd, the driver normally
> acquires a reference to each buffer backing the queue, to ensure
> those buffers can't be freed from under the queue.
>
> During CRIU restore, we weren't acquiring those buffers. One of them
> (cwsr) is svm memory. During CRIU, svm memory is restored during RESUME
> phase, after queues are restored.
>
> During CRIU queue restore, keep a record of the svm buffer's address
> and size, and then get a reference to it during RESUME phase.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  5 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  6 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  1 +
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 38 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  4 +-
>   5 files changed, 51 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index d8233337b8d5e..8157f57e9e581 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2833,7 +2833,7 @@ static int criu_resume(struct file *filep,
>   {
>   	struct kfd_process *target = NULL;
>   	struct pid *pid = NULL;
> -	int ret = 0;
> +	int i, ret = 0;
>   
>   	pr_debug("Inside %s, target pid for criu restore: %d\n", __func__,
>   		 args->pid);
> @@ -2861,6 +2861,9 @@ static int criu_resume(struct file *filep,
>   		goto exit;
>   	}
>   
> +	for (i = 0; i < target->n_pdds; i++)
> +		kfd_criu_resume_pdd(target->pdds[i]);
> +
>   	ret =  amdgpu_amdkfd_criu_resume(target->kgd_process_info);
>   	if (ret)
>   		pr_err("amdgpu_amdkfd_criu_resume failed for %i\n", args->pid);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index eb4d35a42e917..79f7b126ebd0d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -895,6 +895,9 @@ struct kfd_process_device {
>   	u32 pasid;
>   	/* Indicates this process has requested PTL stay disabled */
>   	bool ptl_disable_req;
> +
> +	/* CRIU data preserved between restore and resume */
> +	struct list_head criu_pdd_metadata_list;
>   };
>   
>   #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> @@ -1371,6 +1374,8 @@ int kfd_criu_restore_event(struct file *devkfd,
>   			   uint8_t __user *user_priv_data,
>   			   uint64_t *priv_data_offset,
>   			   uint64_t max_priv_data_size);
> +
> +int kfd_criu_resume_pdd(struct kfd_process_device *pdd);
>   /* CRIU - End */
>   
>   /* Queue Context Management */
> @@ -1387,6 +1392,7 @@ void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
>   int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
>   			   struct queue_properties *properties);
>   void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev);
> +int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size);
>   
>   struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
>   		struct kfd_node *dev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ac18c2be6ecb6..ded42532e6d9c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1801,6 +1801,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
>   	pdd->dev = dev;
>   	INIT_LIST_HEAD(&pdd->qpd.queues_list);
>   	INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
> +	INIT_LIST_HEAD(&pdd->criu_pdd_metadata_list);
>   	mutex_init(&pdd->doorbell_mutex);
>   	pdd->qpd.dqm = dev->dqm;
>   	pdd->qpd.pqm = &p->pqm;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 509529af2dc3c..d3136f19238bb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1018,6 +1018,12 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
>   	qp->format = q_data->format;
>   }
>   
> +struct criu_pdd_metadata {
> +	struct list_head list;
> +	uint64_t ctx_save_restore_area_address;
> +	uint32_t ctx_save_restore_area_size;
> +};
> +
>   int kfd_criu_restore_queue(struct kfd_process *p,
>   			   uint8_t __user *user_priv_ptr,
>   			   uint64_t *priv_data_offset,
> @@ -1026,6 +1032,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   	uint8_t *mqd, *ctl_stack, *q_extra_data = NULL;
>   	struct kfd_criu_queue_priv_data *q_data;
>   	struct kfd_topology_device *topo_dev;
> +	struct criu_pdd_metadata *resume_info;
>   	struct kfd_process_device *pdd;
>   	uint64_t q_extra_data_size;
>   	struct queue_properties qp;
> @@ -1131,6 +1138,11 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   		goto exit;
>   	}
>   
> +	resume_info = kzalloc(sizeof(struct criu_pdd_metadata), GFP_KERNEL);
> +	resume_info->ctx_save_restore_area_address = qp.ctx_save_restore_area_address;
> +	resume_info->ctx_save_restore_area_size = qp.ctx_save_restore_area_size;
> +	list_add_tail(&resume_info->list, &pdd->criu_pdd_metadata_list);

Do we really need to allocate a new data structure here and a new list 
in the PDD? There is a list of all queues in struct qcm_process_device 
(pdd->qpd.queues_list). You could iterate over that. Each struct queue 
already has the addresses you need in q->properties.

Regards,
   Felix


> +
>   	if (q_data->gws)
>   		ret = pqm_set_gws(&p->pqm, q_data->q_id, pdd->dev->gws);
>   
> @@ -1146,6 +1158,32 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   	return ret;
>   }
>   
> +int kfd_criu_resume_pdd(struct kfd_process_device *pdd)
> +{
> +	struct kfd_topology_device *topo_dev = kfd_topology_device_by_id(pdd->dev->id);
> +	struct criu_pdd_metadata *resume_info;
> +	struct criu_pdd_metadata *next = NULL;
> +	u64 total_cwsr_size;
> +	int ret = 0;
> +
> +	list_for_each_entry(resume_info, &pdd->criu_pdd_metadata_list, list) {
> +		total_cwsr_size = resume_info->ctx_save_restore_area_size +
> +			topo_dev->node_props.debug_memory_size;
> +		total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
> +
> +		ret = kfd_queue_buffer_svm_get(pdd, resume_info->ctx_save_restore_area_address, total_cwsr_size);
> +		if (ret)
> +			break;
> +	}
> +
> +	list_for_each_entry_safe(resume_info, next, &pdd->criu_pdd_metadata_list, list) {
> +		list_del(&resume_info->list);
> +		kfree(resume_info);
> +	}
> +
> +	return ret;
> +}
> +
>   int pqm_get_queue_checkpoint_info(struct process_queue_manager *pqm,
>   				  unsigned int qid,
>   				  uint32_t *mqd_size,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 18d24ddb455eb..78de556da056c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -88,7 +88,7 @@ void uninit_queue(struct queue *q)
>   
>   #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>   
> -static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
> +int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
>   {
>   	struct kfd_process *p = pdd->process;
>   	struct list_head update_list;
> @@ -182,7 +182,7 @@ static void kfd_queue_buffer_svm_put(struct kfd_process_device *pdd, u64 addr, u
>   }
>   #else
>   
> -static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
> +int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
>   {
>   	return -EINVAL;
>   }
