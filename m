Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C69C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 20:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACEEA113E24;
	Thu,  9 Jun 2022 20:37:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F38A113E24
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 20:37:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZnilXuAZQpsNRTXAs9ypOnedCkspThA+O0KwH1Q7/ggbqRDKmKn5upaLKgmEbhLvk8WwUjXzQNyRxuJzo8imXjS/cDJQyn2Ip5ai2fptMLQ9Wzu7tZwqQqnPuqWVue4n6wuGEM8SNVikrni+xiOUWTw/Jlano8Ud+EkZQXiq0QBqUa2oW1quoV4w10vBFtv4VC2msml9QzdCDH/nq2U8DmwcLamsSDcgEHKJa5/7bJUMCb19FDSMg+SUv2qGOulAmjMyLuRRREJcBpKrb4YSAODWBpUNMSSbkRP+zvjbbJ3tBlcC2FRYR2g2gjkqgPsN7oiTCnVWmtLqag8EM2ZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS3/U+0oW8njf4ORNmry7ghbFQSiuHB9SDvhEXTvTEE=;
 b=I596DV2mIHguvjeF0C+Z64uIVHj0Xtb3EwMTNhZ1NK3If4LtYrga51fAhyJHxNdAZUWNyJWkbm6SdNfEgCph9Y5vwtXM4Lgb3/yHG8Tw3nZ4VrYeWwXZoOmtUTyTGcFlyuRpubdLYLmhhnrzW0+WDLmKYXofBA/yPw1Kylk3cMeoB9V1s0utTlFuPWV8Gx1hcPA9dSQr35/ArlZ0C4CvZCzcFOInlkP0uYNuCQEvydrdeC4tKVoBq9xgakugo9+nfsVoqrhBcYvWuz/kD331NRj/E3eX1h8barGzdoRHzCYyVzI6oQeETcdohIEV+a2wFvi6IWuYIjn25m29AvFbrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS3/U+0oW8njf4ORNmry7ghbFQSiuHB9SDvhEXTvTEE=;
 b=HT3EG7Da9jnX45OPr40nGVoQ9dS3deaSMrZmLDJmLYgFYL+JO1XQwffJgXBTpd/85yB6qfLYelPeqTbPaxrJ+CORlBEEmvM/dyLXTQOwP1U0tQi2MXD+Zeu6dGSBL/NNLP7ezVfqKDMdNfTtkv7SfrjLfmCFOev6mQmsMX+3NpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Thu, 9 Jun
 2022 20:37:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 20:37:10 +0000
Message-ID: <0f800182-ca4c-f093-3295-53e4a3188eb9@amd.com>
Date: Thu, 9 Jun 2022 16:37:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix error handling in
 amdgpu_amdkfd_gpuvm_free_memory_of_gpu
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220609171727.3581424-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220609171727.3581424-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34b49911-a9fc-4bb0-f799-08da4a57d3c8
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB6043A387D7A8F5A233E31DD892A79@IA1PR12MB6043.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XC4CMQQbPT6nbtfqGOL0laDFLKZ/ns2KVKEMEf1h69nsMdlGiqbPTwnc4Cy19PcLxkKmecBFXtiqA7SIw0ImztZWQpR3M+cXK5/EUYrnjMCdUSQb6lLPRKaWxU17ogttkgBJGd+tNGM26s6kDX/Rtr5a4UyXSErMUszPi+Q7aEDDmw8RX1CwIVou90q+dHcEH1GKGdlpg2E3W59XSRM2RXfkuHeRJZ58HTbbUmQBTXmBWWCQg42Cbv6n9psF0R2GdgGlk7QG1Isc57wh/boVZCxHnNDO2vVYgyHRjBk1i5xVvMjboLDw1x9ghKNbjYlZ5meYc5WdAga8ggemtw2+AkKVPj9J4NMI0/wZUd257W8zUATzfUr0qmU92DPb7Dgkyh1gqWNs0zMEhdSgnjXa6udeIzkoZDFl8+ONIuWvNelj+HeGQWmFcHK/E2zjuaYz/4Z+c/OH6JPnY3cXrl04qe8N/z6QxGTFGKqpfFoOHi8zEgwwCiWMwGFqtc+d3kU13jsIyHAMEjcG+LFutjbHCP/yHaYacdhiDHckM9IkhWonISzHA9/yYnz2ezC0awCU+L5S5r7QuuV4CwvYo3t4HLQ2OVz+XmXxWVl98dLarEucwhwZweDvCwMLAAruLaCrQo0tAKnVxJirPL05ooBUFltn/KmOjR5VcAFobHTNK0b03Cw3NUCHRWlyI9isIC5I5xP+8VSkEmbo13YxB49Ium1e50s3JacpKxtmyqn/3J9UbiCGLT4rVWYSY14LEyZQ4DaNIpyBgN1Iob4WhsdAq41vbJxSBPw7emBK4ZBkspn3NmPGWZt5C6aU2WDcoJ34e+AuVBeDrwb0B/J7YP3pObO/ErmTzpTWM8/mIi75zK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(36756003)(2616005)(508600001)(38100700002)(6506007)(6486002)(26005)(966005)(6512007)(31686004)(2906002)(186003)(31696002)(66556008)(86362001)(44832011)(8676002)(316002)(8936002)(5660300002)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGU2enVtNWMxZFI5eERWd1UyWEgyeEtkMGxhQjlSSVhyK3JXWDIxNzFzdXJQ?=
 =?utf-8?B?L0srL3pmbi9tVVhqNTgzWEViSDlpOFRuZjJqNlNhQ2ZuSkwzY2x4SnZhWEZs?=
 =?utf-8?B?a2hFd2FyV01yTVU1V0JsV3l4djlnd2JCL1BueXo3bmRFeFR5aHJ3WWIwQm5m?=
 =?utf-8?B?a2t4TytrTWJhdGs1c0JJTjgwOWRZdkNqWTNIN1NGaHBzQWhQT0lyVE9DdVQ5?=
 =?utf-8?B?aTQ4Y2dtRjBSVlRZU0YwUWdMVEpxcDNzY0N4dm1oR1Z2c01uTFJmd2wrKzVZ?=
 =?utf-8?B?QUJ1VjRqV1Z5aWFIRzhMUHJRenFhU1dyaUVUendYd3FFckl4R05tTVBZMHho?=
 =?utf-8?B?T0xSK3ozTXhhSWc3RlBnVGo3YjR5MmYxVHZnOXQ0T0Ivd0RRaEdtbnYvMTdh?=
 =?utf-8?B?NWQ5ZHlNb3BtVHpsSHJRTXlZVWpjaWM1U2IwamllWU56azROc2Z4UU5lZ1lD?=
 =?utf-8?B?clVUNWc5ZWIvU1d4ZkxlZ3ZwdmpkNnlmNmtlMlRCc3dIZ2lUVmVORVFIcEtC?=
 =?utf-8?B?VldaWXFkcVJwaVRkbFlXTWhqd3BWSTJCUTBvdkFicGJsOWNHeDIvOE9JWXlp?=
 =?utf-8?B?TXp1ZEE4T01WaFJRbUQ0QlRtTkJyaFphVDNGcUNZSm1mT0NVeWtpQ1IwaTd2?=
 =?utf-8?B?Wk1OelRvMXBEU2xiQnZsVzNRM0NsSHRmNGMwN0RlSGpvZUFsUjZpMTBXSUt3?=
 =?utf-8?B?ZEpoR0xlNURDTC9VSld6UkQxV1lXU2FjcnB2NlZVZGRWS3JDcVN2Qk9IRThU?=
 =?utf-8?B?ajVZU2czK3B4ejh5QldQMVZxS01UYjhLQmJYdVl5eTNWRERaazBaMmlRa09M?=
 =?utf-8?B?TE9jRG5vWE9tTExaNHY5YThJN056bXhyREFXaTR4VTVMZWdka2FjMFRTTWJH?=
 =?utf-8?B?Q05kMGR3ZVN5ZzR4c3NRSi9JQy9RN1ZYaEROZkRQSjUrU09WSmt0SUlEdmxN?=
 =?utf-8?B?RUp3aENoSlFIK3U2RnFuVmlBRXhFdlVwckszYitndmMzdzU3ZDBxMTNNQjhM?=
 =?utf-8?B?bWhiUm9zRHZmS2RYYkxidGFEWnlBbTdoOXNibnpCM2V6OGVicHFLdEdsaTFQ?=
 =?utf-8?B?VENSMFR5NVl3MkVTY1QxTWR5cmo4U3RJM05VcEx5NzRFZmYxK3g5ejNCdmJY?=
 =?utf-8?B?Z2dWRnVZQkpZSFFOTXd6U3dLUktNU201elRtcjQxNmo0aU9lcDJtSWZyc3NN?=
 =?utf-8?B?NXBoT3BEbFNaNWxReGxJSzR4cldDMEYvRW55czNzZlhCbWxyQkJnY0JNZCtP?=
 =?utf-8?B?Z3NjdGMrWThFMmJDd0EvZ3JUK2lMQjJTNHBnSTJUeWRsV3lkcHQzV2hQeUVW?=
 =?utf-8?B?Tm5aSWRZYXpWbExjZFlOWWhDaXFENHZYSTJpbEEyYlZndUJNOE1iQnFRUkNM?=
 =?utf-8?B?bFNIRWRNQitzS3N2VUZVNlR3ZXlDb3h1d2QwUEEzWGVBN0tZZTJKc0xtNk5F?=
 =?utf-8?B?V1k0Ynh5WWduQVdiTjBMeHQrd3ppcUVuSnQ5SEVqY3ArdFJtSUtJV1h0bFc5?=
 =?utf-8?B?RzYwQ2I4TTgwT0JCekNEekdHL2tvTjFkMEV2azJPVy9NNVNSRmpBdGR5cTBk?=
 =?utf-8?B?MHplUzY1c3d1anR2NGVhdHlMdnM1ck01b3VVNTlKWExOaldVMUZNdjR4NnFs?=
 =?utf-8?B?MzdHck1DN1BOSVlYcklYSUdsYWlSZTBhdkt1TlZKZS85K0M1bkIyTWZZTUs2?=
 =?utf-8?B?Mkh5NDBFV0dKa2dobVJvQ1dvUlJwM21PUXI2MkxCNEFOdEFlSFZtMzI2Nmlx?=
 =?utf-8?B?eGRMYjRxTys5Y3lKaklVYS9XcnlNRWJabW1zTXpOa05JZDJvR1NVTVAvVnBs?=
 =?utf-8?B?c2xkVUU5cy9wMjg2L2lTUFFvMjdwMlVmZlpSdEJQbXhraGxXWm9WcUNmRzNT?=
 =?utf-8?B?dWhOUFZNNWs1bHJFZFFadkIrWWc0eVVSazZaU0xDUDJ0K0FHOGo4bG0vNmND?=
 =?utf-8?B?TU1PaVM3OG1TdmxodG1GY0VGQ1d2MXhiY3kwc3Y3S3hIakJLYUxxclJXYm1B?=
 =?utf-8?B?VVhwN1VqT1RPdFJpVUdBcGttYXpKRnd2WVROTDZSS3F3c0NLVjlQQ3R3Witn?=
 =?utf-8?B?OXd4S3FqeERxVnV1VEcvOGpVN1ZDSGZnM2I3SmxyZDh5Vjk0YjBISng2QkxO?=
 =?utf-8?B?L0lsbGNPc25lVjVyQVh4eGd6S2RqUXRIMDNMTDdxZjRGYXNEQTd1ZTN5ajNC?=
 =?utf-8?B?R25DQ2paYlJaK28vM01mb3p0YkM0elg3UjFmMHZVSHM4OUFhZDZiUHErcE5D?=
 =?utf-8?B?ZXFIaFVQeXF5SVVnTDFCUDdCS1N4YXdKR0svWDBDMDFhR3FZcTN0WVplVHVU?=
 =?utf-8?B?cG9STU9oUlhjS2lRNUxndmlkYzA2azJpdmdSZE52ZHhxeXdxTHdsZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b49911-a9fc-4bb0-f799-08da4a57d3c8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 20:37:10.3213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ifbtx8XVMX8ZAvWvYFNU1DFFvFi9kCWiFcnwpZLTGhJHf70014fpjy55Xwn/z/w6dGjIVhltMaDR1wo/Jwev1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
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

Am 2022-06-09 um 13:17 schrieb Ramesh Errabolu:
> Following error conditions are fixed:
>      Ensure calls to delete a list element are safe
>      Unpin MMIO and DOORBELL BOs only after map count goes to zero
>      Print a warning message if unreserving VMs encounters an error
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 38 ++++++++++---------
>   1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a1de900ba677..78b3efecc2f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1013,14 +1013,14 @@ static void add_kgd_mem_to_kfd_bo_list(struct kgd_mem *mem,
>   	mutex_unlock(&process_info->lock);
>   }
>   
> -static void remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
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
> @@ -1796,7 +1796,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   
>   allocate_init_user_pages_failed:
>   err_pin_bo:
> -	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
> +	remove_kgd_mem_from_validate_list(*mem, avm->process_info);
>   	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
>   err_node_allow:
>   	/* Don't unreserve system mem limit twice */
> @@ -1825,20 +1825,12 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
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
> @@ -1852,11 +1844,10 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   		return -EBUSY;
>   	}
>   
> -	/* Make sure restore workers don't access the BO any more */
> -	bo_list_entry = &mem->validate_list;
> -	mutex_lock(&process_info->lock);
> -	list_del(&bo_list_entry->head);
> -	mutex_unlock(&process_info->lock);
> +	/* Make sure restore workers don't access the BO any more
> +	 * Ensure removal of BO from validate list is reentrant safe

The comment about being reentrant safe belongs in 
remove_kgd_mem_from_validate_list. That said, "reentrant safe" is not 
the correct term here. See 
https://en.wikipedia.org/wiki/Reentrancy_(computing). It refers to 
functions that can run multiple times concurrently, or be interrupted in 
the middle. Neither of those are applicable here.

The correct term here is "idempotent". See 
https://en.wikipedia.org/wiki/Idempotence. It requires that the function 
can be called multiple times sequentially without changing the results 
beyond the first call.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +	 */
> +	remove_kgd_mem_from_validate_list(mem, process_info);
>   
>   	/* No more MMU notifiers */
>   	amdgpu_mn_unregister(mem->bo);
> @@ -1878,7 +1869,18 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
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
> @@ -2814,7 +2816,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>   bo_reservation_failure:
>   	mutex_unlock(&(*mem)->process_info->lock);
>   	amdgpu_sync_free(&(*mem)->sync);
> -	remove_kgd_mem_from_kfd_bo_list(*mem, process_info);
> +	remove_kgd_mem_from_validate_list(*mem, process_info);
>   	amdgpu_bo_unref(&gws_bo);
>   	mutex_destroy(&(*mem)->lock);
>   	kfree(*mem);
> @@ -2832,7 +2834,7 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
>   	/* Remove BO from process's validate list so restore worker won't touch
>   	 * it anymore
>   	 */
> -	remove_kgd_mem_from_kfd_bo_list(kgd_mem, process_info);
> +	remove_kgd_mem_from_validate_list(kgd_mem, process_info);
>   
>   	ret = amdgpu_bo_reserve(gws_bo, false);
>   	if (unlikely(ret)) {
