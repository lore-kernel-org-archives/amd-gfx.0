Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E8BCCA47B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5237D113D09;
	Fri, 10 Jun 2022 20:54:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0985E113D59
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afOgm9MqngUqeMW2EQePox65H8z0rG9PJylCdfV3R+AHjoFbqHBwjWF2CileyOsmOD+Br49TSRsw3I+SzLj4SbqQPRp+YojB7Uu7fX0QVZlqolAq/VE+PC+vUcfhNZK6//NtYtdo4fnEzNJfNec/USmKNDSlTfVU9xfXC0ulQRYarNxUD5lqgATU5VSNOOqIOehXqirkC2TvCz4F5h1MuU2hrYmXnoG7P1Si4C14UJHQfYGl9Yyj1/BvE/SPjA8+iI9axdrDlHYFyVKchJRBrz1WfgGRlFkf4BdEwmXA/mZxPrWB8+7kBmVbrhcCSRfz1zzNeMnfyh+T8JhklQh+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHuEE4kuS3zeeHvqRKmlvM53ikwpC+fccU1jVkkrZy4=;
 b=ODaIneyrwdQJt/+uV36olC3sKHnua24UixoiTJ8QmJOCZQ1ozpN3OFwPjq5sGBdbLUg4cOCUvFjG/o0+dcJUkENedh1mzEBQnK19o4F+DyvxhMcHlHZmMjRKWPpH4Lt35iA31bzf2EZI/u0q3DT9YhpJDlh/KaF6d2qovUTi1+OPET6hy83jblqjWEHwwwPX+S2IeyLyc0FsrY3fBg54FoUaXU/KyGkPgetfOrF099hs+a5lQw+PmUFPgJOf9Z92u9f7M0WDpq9xjQQySiVwXL7wSf2Q9GCDHkJjVabk+2/av0s9ats3SKe2W3slOkw+taiHMZrBhEQyjOD/Y4M6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHuEE4kuS3zeeHvqRKmlvM53ikwpC+fccU1jVkkrZy4=;
 b=FKoBD44JMlVZK92wO/CC+4Yb6WjqwWLTCIHiF5lpcY5BpyR7Rln/m1ZfBa7qd/1k+qWUKG6HMNHoykwtaDmahMcl9sgW75ZhlYtTWn+xd8eMiyM/N/mUTq5qKos2BPylUfxzUPBiCvNLVqxmJr0YG1Y2eh7L8pIF07G66UtjSbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY4PR12MB1672.namprd12.prod.outlook.com (2603:10b6:910:11::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 10 Jun
 2022 20:54:04 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5332.015; Fri, 10 Jun 2022
 20:54:04 +0000
Message-ID: <6de40990-093e-9a40-9263-43ba03e453b3@amd.com>
Date: Fri, 10 Jun 2022 16:54:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix error handling in
 amdgpu_amdkfd_gpuvm_free_memory_of_gpu
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org, 
 "Francis, David" <David.Francis@amd.com>
References: <20220610040411.1586427-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220610040411.1586427-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16c92464-3123-4759-ef8c-08da4b235a86
X-MS-TrafficTypeDiagnostic: CY4PR12MB1672:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1672D8177E5DBEC748AC49C792A69@CY4PR12MB1672.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JpzrxQ3ztV0YPhNaqCeNFNjTRXIJdtTpk99dNWMzpTmYYsMdVR6ccL7JpaXCdUhy5Pimtc0GWLKPH1fTYJlAIke28gRbu7R1JiX2CC8eY7qQUh6sbvoZc7X/66ZD/KDiLIWDfl/j2DAoFkFp6IFJk57bhUuqAnLfl+nwTrWlfHNJLkM6x6zx1hkJArlvE9UkE46VDTUSKeybNDUxLIfgFx8GVheogvlBaXXTHwJKPVvPJlHPRADZ6dZi/L04FINgW8Zk1yED1trM6KIoMMwC4H3cfPIn6BJSA90R9j/giEb0v6Mro1uPdnl0NVG1mq5bSA1RQVTwZP9I+ddbQ8QWvWuQRW08aVTKRfXIVDQsBNDfGcYzq9cmze9nb2ebDa4oGV+44j0y2ApFYy+w8cXcRWXo1cinJVDbx3+QyFYGD6HdgzARjzXZUuvnFuELazttZeJit/fy0Ykq+V59pIyS4yLfU/csGdtrjJvY9AKR01gWAEGQu9bxVf0sby68XHwy2K1dhI3yUHsLv0eurruNvqh5o163NtMhJ0QyIHiFG42wegE0oQCN/JL1RIC0ShcXppJy7OepdBvRwsNisf81phETZ3kXOwre53Sg817xbeawYcOt7Yo7exJUEYvSyVrmmevP8+nbYIU71wufJQ2+JcueUyLkKV/TK9yb/HJ4TtfKyZhlYeXYW4r3KYLXr3SV5gaZR8hOh9GFfMAf2OuM1gIEbN2aQLWLea9obh4gMf2H1ioUV6d+ObyH02vudpkk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(38100700002)(186003)(83380400001)(8936002)(5660300002)(6636002)(66946007)(31686004)(66556008)(66476007)(44832011)(8676002)(508600001)(110136005)(316002)(6486002)(6506007)(31696002)(86362001)(26005)(36756003)(6512007)(2616005)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUU2blN0SWJCbzQvdTE4K0o0WlVkUTlsa3dqRlBaekViL0RiU241MERha2M1?=
 =?utf-8?B?aFJlZTlCM0w5aGN4UTFFWnNHdWdyNXJOT0M2Tms0a1ZPUXZ1a3dwTWVXc0hr?=
 =?utf-8?B?c0VXdGptRUlkV3laRzh0R3NvRDc4aFU2UUtCeHdrOWhUMStLZUdacnV1VHNJ?=
 =?utf-8?B?eTdUWndNZWxmTHRiN1NiM0YxMGRTbG9xbUtTYTRtNUJvWWI0ZEZURzhWVVhD?=
 =?utf-8?B?Z2t5ZGZYU3dIcDJWMnZjZ3d2YVVseG5jcjFmQjJqeHpzNVM1NHZBUzg1YUUw?=
 =?utf-8?B?TGFYRVNWMmlkcVp3NlpzQ2t1a29GaFdjTkFTZjFFM3BZSFdoSWNXRVM0eDhu?=
 =?utf-8?B?NWtpTlFxeDhqTzhhZkpMUkNqYkxRbUV3UU9rV25WcUhvRXhGbGhTdTlpU2Ra?=
 =?utf-8?B?YUxMSjE1ODJsa0E4U3BqMXNpa0NMNlJxeHpIQisrM0NCNXlKZ3JZUEk1Q29o?=
 =?utf-8?B?SGRuU0VjdUhXQXQ3bFhJY3J1UzhXSkd1Z0JkVFQ5aDJZTmh2RWdlMHJNcWdv?=
 =?utf-8?B?UXZPcnJsdU1Ca3cxQUIzb3ZzRDVRRld0bDQ0UXJnTExkb2hZdjZpMXdSUEdu?=
 =?utf-8?B?UktIcVg1UTEyeXJLZUZxNFlIaExGekdxeGI4WkZzWkpLdzUxQndPWFRNUDBH?=
 =?utf-8?B?SldGV0VaRHd6VTVTNTcvWjV5eHFoMkxuYWRuOHpxeGVWZUt5UXhpYzdxL3dF?=
 =?utf-8?B?TTZXLytHa1hnQnZTaGgzNUpwNU95Mng4NXdnaWVJdzBveWI2YjljZGtycFRw?=
 =?utf-8?B?VW9yTzlkOWNCQXdYMkxoRC9kS1lZcmw5Z21iWjNoV2FOTHhidFkweGlzejlN?=
 =?utf-8?B?dXJsUEdoZ01HU3NTMjJCSUFmb2xyV2paZTJhLyt4SXo4OWNaU04vQlM5Vncw?=
 =?utf-8?B?UGU0MzdsbFl1U3NVaFFORzYvcy9JbG15YWR2ZUF1NFMzcGl4NlQ5WjRWbDRK?=
 =?utf-8?B?OWxCUXFFc050RlM4QUF4SG1xVVgwWGMyMlhCbG95NWtBOWtYa05xQllQMWtj?=
 =?utf-8?B?UzgyTzJWY3BKcnRsWmZaVFZpV0RNbitXNnc1Yld0SmFML2JSZTJPOXpSTFo2?=
 =?utf-8?B?bHRUSm00bWhOMlB6dmFxOU9Kb2tBQnFPMEVjMzBqL05saU5GZERreWNhVWx2?=
 =?utf-8?B?UzBzMkhDbmlsTTNqZXU5TTc2OEUvZklGUWN0TUpYb3hMMWtXUTFpTGhSdzJY?=
 =?utf-8?B?MWtHdjNKTG9yZTVhK09heWdoUmNtL3llQ050Q2srTVVPQ2xKZjJFeGE2c1c1?=
 =?utf-8?B?aTlZMmVwS0ZhMUxuUHB3R1BHZHlBRHlya2VZa1dPQWFIZ1FuUHM2ekt0VWFX?=
 =?utf-8?B?K2JFNHpsMVFrKzFSeEorOUlLK2p0N1d6TDRBa1FxYzhvSTc5cEpzK0hjMmNj?=
 =?utf-8?B?YzJZRVJRWGZaK0xnZmxVUGh5NDFhdjVZYzhqangrdzkxL21yRVlLQWlHMWdp?=
 =?utf-8?B?NWZONmVMQzFjSmVhcjlMWTRxVmV1ZjBRWmpabE04NFVrVlpSZjNVc1M5RFRI?=
 =?utf-8?B?NzlvM0hOWDZKelpwY1YxNjgxNG1keWNEMTJwN2VhVW1vV3BSUFMrbXhvWEdq?=
 =?utf-8?B?MlMzN2ZuZ2RaVHg5MW9iMGhKakdkQWpYamxiUmZ5dFZoOVovUGVEbTFaS2Fv?=
 =?utf-8?B?bHkvKzRNNXoxdHVobFM4ZUpBSVpGaXdDcVJCdWNBOEw1MW9KaWp4OG5aWkNw?=
 =?utf-8?B?YmJzbUVxTDF0N2hHUkdRc1JlVjF5RkpsYlFqbVhjekh1ZGVrL0dlNlQvY3hQ?=
 =?utf-8?B?NmNYdnN1azNSWTZGVHhpQ0x5dGRPT201V05tV0lraGdMRFV2S2F2cjV3TWh1?=
 =?utf-8?B?Q3kra3p4ZlI5S3VZbTZFMmNVWnRaYUhlZjhoU0NsRXhoNFA2N3REa0NYQmwr?=
 =?utf-8?B?WWNoOEdONVJmU2hYZHVCeEtiK3ZXS2J3M0diTFZSaUtVZGZxRUR1cnk3M0tn?=
 =?utf-8?B?b1lWODYvU3lNUjYva0hFUWVMbjRvYjRra2JGQ1hrQzl5dDRNRzQ0cG9SaFBm?=
 =?utf-8?B?bmdRdzFQTk1LVW1YOUVzOTFac2g2ZUhTUUZmL3lMUnVObENzRDdkSDJIczk3?=
 =?utf-8?B?cGovTnVCbGFNMXozWjJDVEhJQVptUTBSUnorVTk5Z2xmdGtuTUZLdTEyTGkr?=
 =?utf-8?B?ZEozblRyUk9aWlhYT1FHK1U3aGFXZ3FjcHNiNktGekdMbmdTR1JCM3JiZDRP?=
 =?utf-8?B?Rnk4VjYzSFl6NDNETmFyYzNwOFRKYS9jNHlqUE9jOUpZZjZrc3orSHNmcjlD?=
 =?utf-8?B?Wk43bWRrUWU3cnV6V1FjNERidHZmRmRxRmlpVTdZSmVyMGM3YW5UNml1QTls?=
 =?utf-8?B?QWRNNGZSQzBod05OTTlSMzZHdUR3a1Q5cldmZHFPSjVyVG9pUWk4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c92464-3123-4759-ef8c-08da4b235a86
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:54:04.2483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfpeWx/8tPRMRhRKw1hV57+JsIQskqWzCtZ5MlJE7aHc2cLAjUALezTK3xjUWZgk+0IdXUbDUi46k0RSr54drw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1672
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

Am 2022-06-10 um 00:04 schrieb Ramesh Errabolu:
> Following error conditions are fixed:
>    Unpin MMIO and DOORBELL BOs only after map count goes to zero
>    Remove BO from validate list of a KFD process in a safe manner
>    Print a warning message if unreserving GPUVMs encounters an error
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 42 +++++++++++--------
>   1 file changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a1de900ba677..ee48e6591f99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1013,14 +1013,22 @@ static void add_kgd_mem_to_kfd_bo_list(struct kgd_mem *mem,
>   	mutex_unlock(&process_info->lock);
>   }
>   
> -static void remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
> +/**
> + * remove_kgd_mem_from_validate_list() - Remove BO from process's validate list,
> + * in an idempotent manner, so that restore worker can't access it anymore
> + * @mem: BO's membership handle in validate list
> + * @process_info: KFD process handle to which BO belongs
> + *
> + * Return: void

I don't think you need to state a void return explicitly. [+David], 
since you were looking into KFD documentation and kernel-doc comments 
lately, do you have any feedback on the kernel-doc syntax?

Other than that, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> + */
> +static void remove_kgd_mem_from_validate_list(struct kgd_mem *mem,
>   		struct amdkfd_process_info *process_info)
>   {
>   	struct ttm_validate_buffer *bo_list_entry;
>   
>   	bo_list_entry = &mem->validate_list;
>   	mutex_lock(&process_info->lock);
> -	list_del(&bo_list_entry->head);
> +	list_del_init(&bo_list_entry->head);
>   	mutex_unlock(&process_info->lock);
>   }
>   
> @@ -1796,7 +1804,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   
>   allocate_init_user_pages_failed:
>   err_pin_bo:
> -	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
> +	remove_kgd_mem_from_validate_list(*mem, avm->process_info);
>   	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
>   err_node_allow:
>   	/* Don't unreserve system mem limit twice */
> @@ -1825,20 +1833,12 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	unsigned long bo_size = mem->bo->tbo.base.size;
>   	struct kfd_mem_attachment *entry, *tmp;
>   	struct bo_vm_reservation_context ctx;
> -	struct ttm_validate_buffer *bo_list_entry;
>   	unsigned int mapped_to_gpu_memory;
>   	int ret;
>   	bool is_imported = false;
>   
>   	mutex_lock(&mem->lock);
>   
> -	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
> -	if (mem->alloc_flags &
> -	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> -	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> -		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
> -	}
> -
>   	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
>   	is_imported = mem->is_imported;
>   	mutex_unlock(&mem->lock);
> @@ -1853,10 +1853,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	}
>   
>   	/* Make sure restore workers don't access the BO any more */
> -	bo_list_entry = &mem->validate_list;
> -	mutex_lock(&process_info->lock);
> -	list_del(&bo_list_entry->head);
> -	mutex_unlock(&process_info->lock);
> +	remove_kgd_mem_from_validate_list(mem, process_info);
>   
>   	/* No more MMU notifiers */
>   	amdgpu_mn_unregister(mem->bo);
> @@ -1878,7 +1875,18 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
>   		kfd_mem_detach(entry);
>   
> +	/* Return success even in case of error */
>   	ret = unreserve_bo_and_vms(&ctx, false, false);
> +	if (unlikely(ret)) {
> +		WARN_ONCE(ret, "Error in unreserving BO and associated VMs");
> +		ret = 0;
> +	}
> +
> +	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
> +	if (mem->alloc_flags &
> +	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
> +		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
>   
>   	/* Free the sync object */
>   	amdgpu_sync_free(&mem->sync);
> @@ -2814,7 +2822,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>   bo_reservation_failure:
>   	mutex_unlock(&(*mem)->process_info->lock);
>   	amdgpu_sync_free(&(*mem)->sync);
> -	remove_kgd_mem_from_kfd_bo_list(*mem, process_info);
> +	remove_kgd_mem_from_validate_list(*mem, process_info);
>   	amdgpu_bo_unref(&gws_bo);
>   	mutex_destroy(&(*mem)->lock);
>   	kfree(*mem);
> @@ -2832,7 +2840,7 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
>   	/* Remove BO from process's validate list so restore worker won't touch
>   	 * it anymore
>   	 */
> -	remove_kgd_mem_from_kfd_bo_list(kgd_mem, process_info);
> +	remove_kgd_mem_from_validate_list(kgd_mem, process_info);
>   
>   	ret = amdgpu_bo_reserve(gws_bo, false);
>   	if (unlikely(ret)) {
