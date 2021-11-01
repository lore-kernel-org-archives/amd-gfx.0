Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C448C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 20:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386D460EB8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 20:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 386D460EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B8989F75;
	Mon,  1 Nov 2021 20:17:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2998689F6D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 20:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOQN19eD8A44/Yt9J0CUDLxGwj6IfnMasGOcrIO/yGRZQdAzfTzhZXGKMZHBulbjQkGcTXwDtv+G/x43YB4LmXNnzHXN7DbnIFm8zM8z5UC2+Prjy84jktdhTkBF1QY+XWjxGQ4EAT/NJh19aZapvdk1E8UF/7Fe6krLfJx1L6EY70Ds1VKKlHTmykR6PKea6RE2Vsm5iqpfo8eTXg10yM81wL86v0mrr4B4epJQ0q6IiNs6eCDjQbRlexvMAzgRjR1CjXs2YYVEH0iHYlaomY85wak2kAMmF+GP/BU9K2GpFTVZH2idzphwHOaiUikYeRALMVzK+JwhIZl4Z8MhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/RIQQdYErMq6JJKeDVzrSiDEPDLinpNR89UyZqJYZE=;
 b=e6sAQF3uezin+BU6nl2CcncPImw7YQsj3RSOj8r2MZGuKSypi8MdMIU4DZD5dobY9eYkmR4aJuHYr6sh0Lyr8dytk7Y1nuQKSIW7MUd/N5OJ5a1dbwNpY/YpRlryvw9+03MAfxlBC+DcHpIQROimfeegeRIQfUBg5pjTbFFnc0ShfW2zI74QW152hcsj6MYHZfM2umUNyaFpgw20azqPCfD9a/d7vdr8CZAXOUduIBmGgLucSbgKAh+sKNYAqoVqFBqn80OQEDdMFlRKkOePtkZfCoHWpn1pEBhzLjLKiVKGuMp6Ejigrh/3Xtsz66Lw3UP0k2R0VERZ7ksOZ1Dtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/RIQQdYErMq6JJKeDVzrSiDEPDLinpNR89UyZqJYZE=;
 b=nPPmKX2KEqKeFAPvCTD5Cj33ddqBUxa+nokR55GjouMUUmbLHub0zFLkRTRRDkBTnIGDhOQElWTOF+h+OINgx6mlIF3r+Ey/wXx1XIgqoDbWHRmzHgq653pfovBP9Zm1OoBh7LWD5Q3iSbb2LQF83UippBVT+9tZ1xLWgdyKVLA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 20:17:50 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 20:17:50 +0000
Subject: Re: [PATCH] drm/amdgpu: Make sure to reserve BOs before adding or
 removing
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211101201421.1689492-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b3975b84-6dbb-bdac-2e3f-63f868754b02@amd.com>
Date: Mon, 1 Nov 2021 16:17:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211101201421.1689492-1-kent.russell@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::8) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 20:17:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb201fc-8fed-4538-3428-08d99d74ad88
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3835FD6E96A0C66E528BA299928A9@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3GwLx8Xr6t6FlIE+SXYFaf8BbVbtVmVHf8Cmfxhx22Th2AcLbm89KRV+oqPe4itZHEmS5SA1DXpJB7eI8SXGuWXM0oCgq/eVQPtkmqyTIPaDAID+d/QfOTLbjIgvPXMfOWL6sD633eJpPYVNWsPEfZ/WNRk6U+7O9WMSjVR5al9sGUjjzR3RYKdgWNKocjjvXn/JwnSOBZO31UV/zXtLSCNXxYT1sUkjqx1m+cPfV8xcgk76+TIDBVBELdiv7TMZBA32fRglKHh04g2LGXEiJl403ELkYU/C/q56z8ia+pXdE/WOY9GWai04a1lbfTyEMZZRTkEyuboHPrqmphj9cnEI71UGKeMZTsihdHM6VOt6SDivbAhfwmIZrecnp7oII9gRtdqirSTf3Aq7qH97Ff8gHSj8Wl0KpmzBVl5BJTUKe8rY8G6N8jwPzUYahubvFhhekKtfZGRtU1TK/9hmmm8NM6T9nODHtuo576ukffQatXY9hDka3dATm0xhIdRCDLdt+WRx8/UXPft08d7/zpmTaVsaAEmlTmcFVzIl1OZy0atmVjI2eZLD9IpY8u4bn6EN860JmY2f4DxGIrFBWeQ4OHM8LiubH4vPOuivxw4jTCxvKVbFRV45ms8btac8sbIADP0SobX8LlN/g5oNsV+iTBwZ1u3TG7bfnst02iuShX/u4pguINvhur57DLNFGax6i7kcxRiPiIY5sBDqwYhfrv1XDFFz1liE1lofoJEvc8nG79tzZW/NtXh4KLNq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(26005)(6666004)(2616005)(956004)(31696002)(186003)(508600001)(44832011)(38100700002)(86362001)(66946007)(66476007)(5660300002)(16576012)(66556008)(316002)(2906002)(6486002)(8676002)(36756003)(8936002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU1ZT01uVVFXYUFxUlVKZGhDQ0VQNkhWN2Y1OWp5c1h2VUl6eUhPcGF4bUZH?=
 =?utf-8?B?Z0RwcXV5bUQrWVE4REN0eFBpVXdQUk1URzZVWHU3TFY4NnFlNXFzbVg3WURl?=
 =?utf-8?B?enhFRTQ3OVVUWFY1djlqdlViWS9UTEtyTC9menp5QVoxVHJhdndtNHhZZXYx?=
 =?utf-8?B?bDQ3RHJ5aklPTmNFaEkvOEZQcytabHhWemIxNFhUQWR0dFlIc2Fjc3hiMndE?=
 =?utf-8?B?NTMwa04xSmZ1WFR3S3hXcWJUVDNPQTVJblh1QmMvR29XL1lDaTVsd3kwd3NX?=
 =?utf-8?B?cnBoWmxUeTFFdmU0ZXVmd0ZBWm41QkRLQXhNQW5iUWxIZkpYNXZSTFhjeTMw?=
 =?utf-8?B?MEEyWkhsRWlVQU45NlZCWGZzQVg4VXIxdzhrQWRKSzZxOVpEQU0zUTY5TFd0?=
 =?utf-8?B?S1hraWZ6bXF3cTZYamRtYlAvRjUyK2Q1T3pEZ2E1dUg2MWI4QWN5OWY2UnpI?=
 =?utf-8?B?NXpwOElnbkNWeEo5VDJSTVhOV3U1L1lpM0pTRVNROUE5QitEamxJdTVhMEVy?=
 =?utf-8?B?cWFqN0RiSVIwRlc0Z3pvRjlyVFgyN1FpaldZRGV6LzZGaEdJMVFyT3BydXRS?=
 =?utf-8?B?MzIzdVFjY1F3Nmp5YVhwUll3WXhDdVRyN2FpaUF6YXJEMWY1YjRlZi9hVmFr?=
 =?utf-8?B?RkVmS0g1M2V1UVA4VFY1N1d4YkkvYndtM3hOelRyZDZyZENNcDdmM2xkWHM3?=
 =?utf-8?B?VDZDNGExSzhqWTZxRUlJdEd5d2x2c3VvdGg5b1o2NEZ0WjZwRFhIamh0ZU9X?=
 =?utf-8?B?RXJRR2lkalBmRWYrV0RoUzNhdTBDSG1BSkRvdEhiUXpQUUw1MlA2V1pCYmx6?=
 =?utf-8?B?blE1ZW5jSFdpL1ZGSHZqdXJlR0J1eHJPb0dxUWM5bmp0SG5oQTliTzkzMytB?=
 =?utf-8?B?TkpWZXlKY2UwaE1lemZNVlFyL3BKdW1jcEUwdEVScituMjN1MHluRDNONml2?=
 =?utf-8?B?NTgydS9nekN1S1VZb2t5c0xCYk81YTJvTkE2REV6alFlYjZUZ1J3WjNJd2lm?=
 =?utf-8?B?RU15cGRMVXF0a0lrUjBkZU5kR05BM2NDYkFGNXdRZ2tnOUphWGtLSUtZdm10?=
 =?utf-8?B?MkE1QXFPczdqeHZZWWdOcmZtT2docGVLaFZHc2QxcmROUWV1djErV2U1bTRW?=
 =?utf-8?B?QnB2UnlPYjNRdC9ZZHVvamVTS1l5dkxTNWZ2RUVGWGl3VkVPQ3QvbWQ0WlM5?=
 =?utf-8?B?SWtmbjZkTVJEUXk5Sk5pb3dxUVBMV2haMTJ0UEE4MVdsNG8xOG1TRVBqZnpE?=
 =?utf-8?B?WlNIZXA1MDFlcm51VjlwMFBQZnVYbFc3UHh6aFFhUkxkK2U2YThsUmcrQ0FN?=
 =?utf-8?B?NllZK1Q3aFZZd0txWW1HVFo3UzQzb3BBOUUwa0hoVlhKM2g1SCtuYUNnVUc0?=
 =?utf-8?B?eWxqdFlRalUxSjZ2ZnlVSWdSclg0Ui9yVnU2aThvTW9ERE0vQWJ3VTI4WjZ6?=
 =?utf-8?B?eCtSaTlrV0hzNktISExOT0lqVmZ6UGhFY1hQeFNRcm5pOWtCTHY1OFN2eFVY?=
 =?utf-8?B?WXZPQzNaV1BSVTZ1UGNoSzhWU25SMitVOFNmRmZZZGYvaitSKzRxdW4wYWds?=
 =?utf-8?B?UFRESSt1dzdYL3M2NUhubm4wS3FvMm1BZmE4OCtBbVJlaUpERG1hYjRJTzBW?=
 =?utf-8?B?YkgzR0dWellnMzJ4ZGVTWVBVc0FrcE5URlByVk0wcitIK09rekYweWh4RzA0?=
 =?utf-8?B?LzBQbHh4ejRnakFoSjlrem1RbzdoT2NleUFLanF1bGRZZXZzN0RBUUhsTys2?=
 =?utf-8?B?aDF5eEVrOE5GUW9NR0Y0U1Z0NnVUNDRuc0FSYVh6dmMzb29xNHBBeXp1bFda?=
 =?utf-8?B?T1NHaG5FYk0ycUNFMlljbnUrQ2U1eG1aTU1wTHRaZC9tMmg4ZS9qNUY1SW92?=
 =?utf-8?B?RVVpVitUckY0bFdDaXFSWW1PSnlaRXVCek9KOHFQS2dreDBNZE1hQ2lXeU5T?=
 =?utf-8?B?T1IzTHNIaEcyYUJ3YkFRT1lkd0NuWjF2UUhkdFBjTG5ITnJsOUJIdTRhOW8y?=
 =?utf-8?B?NDhXUyt3aWU0c0ZKWjhCTCtaTlBCRk9qb0NOK0hMWHpGeUNNVTA5bUZFeGpC?=
 =?utf-8?B?TG9ibHNqcTBpZnhaQkpzamYrRWxsZEhacDlEcWVZOUh5RHIxVFozOTlRVXpy?=
 =?utf-8?B?eHY5Y0Y1bU1ocW1FM0ZaZ1p5Z1JxZzBCTnUybXRHY3pUMStrUHpOTEJ1ZVV4?=
 =?utf-8?Q?cVEDT9feO/hYVUtVZfPPgwc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb201fc-8fed-4538-3428-08d99d74ad88
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 20:17:50.4686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Bdr1cIbGuAb+cQZdTcWG96k247iQpj0VYUFPS0TaagdBO0/RSInwe+Frjpg52anKEl3l7xbXiqrSRdaDhqWKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
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

Am 2021-11-01 um 4:14 p.m. schrieb Kent Russell:
> BOs need to be reserved before they are added or removed, so ensure that
> they are reserved during kfd_mem_attach and kfd_mem_detach
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 61784bbfd7fd..8d30ccd70800 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -798,14 +798,19 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>  		}
>  
>  		/* Add BO to VM internal data structures */
> +		ret = amdgpu_bo_reserve(bo[i], false);
> +		if (ret) {
> +			pr_debug("Unable to reserve BO during memory attach");
> +			goto unwind;
> +		}
>  		attachment[i]->bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
> +		amdgpu_bo_unreserve(bo[i]);
>  		if (unlikely(!attachment[i]->bo_va)) {
>  			ret = -ENOMEM;
>  			pr_err("Failed to add BO object to VM. ret == %d\n",
>  			       ret);
>  			goto unwind;
>  		}
> -
>  		attachment[i]->va = va;
>  		attachment[i]->pte_flags = get_pte_flags(adev, mem);
>  		attachment[i]->adev = adev;
> @@ -821,7 +826,9 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>  		if (!attachment[i])
>  			continue;
>  		if (attachment[i]->bo_va) {
> +			amdgpu_bo_reserve(bo[i], true);
>  			amdgpu_vm_bo_rmv(adev, attachment[i]->bo_va);
> +			amdgpu_bo_unreserve(bo[i]);
>  			list_del(&attachment[i]->list);
>  		}
>  		if (bo[i])
> @@ -1700,12 +1707,12 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>  	pr_debug("Release VA 0x%llx - 0x%llx\n", mem->va,
>  		mem->va + bo_size * (1 + mem->aql_queue));
>  
> -	ret = unreserve_bo_and_vms(&ctx, false, false);
> -
>  	/* Remove from VM internal data structures */
>  	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
>  		kfd_mem_detach(entry);
>  
> +	ret = unreserve_bo_and_vms(&ctx, false, false);
> +
>  	/* Free the sync object */
>  	amdgpu_sync_free(&mem->sync);
>  
