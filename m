Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2187EB64DB
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 19:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1035510E0CF;
	Tue, 20 Jun 2023 19:25:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2583910E0CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 19:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inhnKUzDwtBYOZ8ptzZ5vegDcJVzWOlPFj22TnkcA65cFDF64DqEcmqj5EUcMLK+wW5FVTsIHPi8A+zruIGw3/fSGTYx3axp4EucFcdNc3uHWc1HPEqYoPIxcMmtw1hKefeS3GT9MxQpiDF4ZrRHazCpUetjogkmxo79DwiCl1Uxf2kwPzQLdKVabjpsCH+GZNJc51olOeIleSKanZawOvcNhU5bc7ndVzDCu8EG94KN0pCryM3kxWRKfBp0qs6uVWQejIfS4n7S2y/lONr24TC/cLmk605sYqrciI+NCoqC1JJEFi862lQHVHlAcD7omCIGdYqqxNqWh9XfzITxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wccA/r32QrzKUNtOJLw69qHtO8fi35fiZEbplBJC3xk=;
 b=Sb2hBZWaYb45Gf0EqtQEMuXwXbjkN49UuCDzKjlKR0BHrBt0cYV1rKvGOqqDp1oT8vC8ip2JVSXWpPTL26cRKQxZ8LMyZbAhzT4MCw/eMddHqttBEZn4Y9n0TJMWJyAcsM7Qh6cDKggXUt36+NyRx3Vrzu7xNBoXBnHtIpmJlXTmhK+U6QT4b+pYAGbo8SdFpdNVerydVpIUbS0zBhsTqj5mxaKQ5Mk2IhI1IS+ozotHcTe3c6bQX8TxfkiWJEYDOyfULWJ89NNFrJrTpTYTZ1BBFlGy1XXh//uaqcTb5n4YjS/jF5AqxGUXtFOOH3SNF5f6sfqtanlhuTiu/wpjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wccA/r32QrzKUNtOJLw69qHtO8fi35fiZEbplBJC3xk=;
 b=Y6KedkY3WxMROfDMaS8q6bHog6x2gCakM9+vPP4POe4eT8EhWV1BELHC7yYeIleezaNcFXknGSwtBbWrV5YwyH8t53ggC7wY6RChkaIr8GfhD4owHEhLVcRzUNiFek8xP419RIa9YCzUBIyczeBpEhnSQkQdBGLZHIiUGLSvcOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 19:25:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 19:25:52 +0000
Message-ID: <55f8aca0-ef75-6300-6482-cc19b5d58a08@amd.com>
Date: Tue, 20 Jun 2023 15:25:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv4] drm/amdgpu: Update invalid PTE flag setting
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230619173825.1461932-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230619173825.1461932-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN9PR12MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b192c79-ec83-4064-93cc-08db71c4296d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94SIv8Lzvqw4anjTZslgsJik2ng8fFYz85QkInHR1FCr8AFrAA6bK8m3JyQem4eyZ26hO74dw4EoWz0X6fN2QLTvyOYqbXIWlEUMQvCrcqvcCjKuSD9ptK1iLnqV7H+R5TvOHgNmYJwaU9d/r/Y8bTj8OlX/FSsy0OcGXQi4BOiag0VxRJpPyQIQ1JqUc60VjybPEI5ffyr2bZdTbQtmNnokTwnyQ+NwxOMWyYr2DACvGsTdV7o8AomQJFaSGjnOj/zQ2aQrZ+6PBTjK+UNGN5GTjpUp9x4Tx7mZfJs8jZ6EG1iZrDxGVtVCBpEBPJ4c+EoprYSETqvmR/rHZu4yqh+UI1ud+DMU1A+lhVcdzjU16/kv6BNXaGwjmrM+H4rTDKhZpes2axJuG60rQa/uENKj7lx+iUv2I9XgAxivWOvkOcFSgKobpLwNJgikVR1C1orKAlvrcdm9VfWiL3wVFZpFdxZY4xsCfZjh2xQiR+oQvvF5fJ99d1lOxRa4OoPNevfTom1sFVSBWo6axgURrIDurwxssyW8BwnYipynHl7xiJpf/Ac21ayGUpTq+OZZJsQ+IRUvgRaCJmnEcPs4zKMrA3XJVx6yJ8+fKZ0arfiUoHSOJrU95L6bIiSWy9eevJBmdD0od9QBZkDFOcTaow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(6512007)(6506007)(186003)(26005)(6486002)(41300700001)(31686004)(478600001)(36916002)(66946007)(66476007)(66556008)(4326008)(316002)(53546011)(38100700002)(44832011)(36756003)(5660300002)(8936002)(8676002)(2616005)(31696002)(86362001)(2906002)(83380400001)(15650500001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3VUdTQvcENXc0pOVVpVblhvQ09XTjlVN0t6RWdSOTMrK1pWdGdFUlp6anJL?=
 =?utf-8?B?blI4TEtJNTVTUk5iK2Fqd0Jwakd4QVVSUHJjUU01WE05VHdNWkFHN2FwVDB3?=
 =?utf-8?B?c1k1T09Oamg5cW45Q1BaT3FCcWtTQUZDZjBFUUlUU2kyQUxiWXQ0dFRmMzlP?=
 =?utf-8?B?dTB0aGMrbWUyRFkzNElaaWtvR0RLOXRWaWplMmUyUjBZa0xYKzI3Q3RrT1F2?=
 =?utf-8?B?SlpUVFFodTV3a25kb3pFSWtTai83MGR0OFBwTGRRdWJtT3d4bDBqRWpCaUwr?=
 =?utf-8?B?ZHc0cGNCR0pvbjRSWHB0dWxDcXR5RTAzQ2xjQ0E3OU1MaldTbXVmM2Y2UUZT?=
 =?utf-8?B?V0plMXF1b2dMQ0E3TVhkUzJUNExQaUR2RGRsRFlnWkxnSmhldzhSc0RoRzU5?=
 =?utf-8?B?OHZ6TXlRTXJGVlJhUnBrT1RMNjEyTG81Y1BCMTBYUmIxU1FmK2F4cnFpWEhC?=
 =?utf-8?B?eWZwdDVTM09uYlVPL2hDcFd4UkY3eHFPRTdvTEUzcTZranFFWm1Rc0E4c1Ey?=
 =?utf-8?B?by8zS3lUbFVsN3FQL0RTcGd6NXNZWER4S04rSGJRTy9WNGRWSll4K1c3QThC?=
 =?utf-8?B?SVJ6OStHVzh4S1EzQjNmQlNOM1NqNFpVaDZiNFZ1bVhWUmdzbVdLU01JM0JW?=
 =?utf-8?B?QnYyN0kvYSs0Q2JmbE5XOE93NzRiYnBoRk1HcndnM2hqM1A5Smg3UjBjcjBT?=
 =?utf-8?B?QVEyZyt3bXNGWm4rSGxVSWZOMjExSGFNeG1aK040anNCbG9iTWhLeDU3dDAw?=
 =?utf-8?B?Wkw0WDhCSkVyVHRHN2EzeXQ0TUJOTW5zYXQvcUp4bzlIQmRMYVlIUGlYdyt2?=
 =?utf-8?B?SGVIVk1tb3FPbVdFMkRha01GclEzSXAweGNYV1Jvd1lvQS9wMnpaWTdtS3J3?=
 =?utf-8?B?NGtPd0VkZ3pScnJBZzAxK1lteDAxVGQ2czJQZDNwUml5bFJFVUxPVkdrRUc2?=
 =?utf-8?B?bGgwakRTV3VqS3VxRWhjRzRZTWVBWU1pUlFFek9YOTJDL1hTVHducnJUZW9E?=
 =?utf-8?B?eGhIUXdwMEVIcDE1cDgrVnRqUTFPa0dUam0xWUF0a3hobDM0NTJlM0R3RERs?=
 =?utf-8?B?M3NMSGxDNkRNdGJWSUx3bFF6TTBreExLWVV4V3JQSHFTcWFvWmt1S2ErbTdT?=
 =?utf-8?B?U0VlQnc1OFhUN2ZxK294eVVFSk5EUGhkd2s0Ni82M2xFcy91UVFwV0dyTitJ?=
 =?utf-8?B?Q3E0aFR4SFhFbU1DY29IMDZhbGJXRG1vU0U2OU1ITHVlbUhIbGV4Sm5zTndv?=
 =?utf-8?B?eGJHanFaRm9uZmN0Rng0cm9mTStqcHQvYkhGM3lqV1FzSmpGd0kreFowa3Ur?=
 =?utf-8?B?b2xtbjNtRExKeG5RR05ha25lZXN1UUc2Z2hDUjdvc1dTZytkZEpqV2VYWXNu?=
 =?utf-8?B?dGNVTGJWK0hUNkVVaitiUytqbXJjYzlBL2lqZlcyeElWMHRDRUFrb0x5SHRE?=
 =?utf-8?B?V2trcXh0dXEzcVhvR2s0aGk0Y0RTTWxla1VpV0Q0YnlvTzhsQ1czQ2o4TkZr?=
 =?utf-8?B?TWpOWm4yTXdRRnJncEJ6NXV5NlAxUU02bGlrYW1EUFBBTzV0MGRyR2Y5alJI?=
 =?utf-8?B?TTY0UEFBK0I2N2F2MDNKMll5YlBlZjBjSkd4UmQ5TTEvbHNjSFdNRFFtcFBO?=
 =?utf-8?B?U1BDOGk0VDZQMER4dnIvUVIzUE1VWDZYei9CbVh5QjJWV0ZVUUlLYzNGUllH?=
 =?utf-8?B?TDF1NHQrYWt1c0VUM2pSV1B3OGFwSEgrYXRMNXU5K0hSd1piYlk2RHpNbkc3?=
 =?utf-8?B?endIcXlVVFVrWVNsMEtVaVJTYUxvY0tiR2dHWFI5NlNXdzhDOHprcGxTN0t0?=
 =?utf-8?B?TzdjQXBCd2xKdndDbkZZeWJCV2Mwam5nU1ZGbVFnbEFveTNndnNRSVhvKzln?=
 =?utf-8?B?N1pONEI4UW1iSnRqL3Qxd253TkhDeDNhaXZQamF0bG9HQnBONzB3ajVYSjBh?=
 =?utf-8?B?S2lkQi9pSTA0RjNLM0puTnFzRzVhaldDUWhxTDQ1NE10UU5qSmdLMk1ZQW8y?=
 =?utf-8?B?Z2xYN0pFZ2RYNEhFWDRkanpMUUttUm9CZWJaeitpT2s1ZU1ycFhHdUs2Sk9u?=
 =?utf-8?B?dGh4elcrODNKdFpqcE04NWozRjg4WmR2SVFNNGNPaUI5RDh5eWNXdSs4enVW?=
 =?utf-8?Q?F8ePJkin/bDGsNGMzomuVOjcf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b192c79-ec83-4064-93cc-08db71c4296d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 19:25:52.7082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxCr1z++M70RCIxIbZbbrE32cj9x0cTwCFYhBE8N2+o0eEXXs4sgmLvvHPg084zi/QbwauxftpHhv8j/rT1YFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-06-19 13:38, Mukul Joshi wrote:
> Update the invalid PTE flag setting with TF enabled.
> This is to ensure, in addition to transitioning the
> retry fault to a no-retry fault, it also causes the
> wavefront to enter the trap handler. With the current
> setting, the fault only transitions to a no-retry fault.
> Additionally, have 2 sets of invalid PTE settings, one for
> TF enabled, the other for TF disabled. The setting with
> TF disabled, doesn't work with TF enabled.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
> v1->v2:
> - Update handling according to Christian's feedback.
>
> v2->v3:
> - Remove ASIC specific callback (Felix).
>
> v3->v4:
> - Add noretry flag to amdgpu->gmc. This allows to set
>    ASIC specific flags.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 31 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c    |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c     |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c     |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  1 +
>   9 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 56d73fade568..fdc25cd559b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -331,6 +331,8 @@ struct amdgpu_gmc {
>   	u64 VM_CONTEXT_PAGE_TABLE_END_ADDR_LO32[16];
>   	u64 VM_CONTEXT_PAGE_TABLE_END_ADDR_HI32[16];
>   	u64 MC_VM_MX_L1_TLB_CNTL;
> +
> +	u64 noretry_flags;
>   };
>   
>   #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index eff73c428b12..8c7861a4d75d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2604,7 +2604,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		/* Intentionally setting invalid PTE flag
>   		 * combination to force a no-retry-fault
>   		 */
> -		flags = AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT;
> +		flags = AMDGPU_VM_NORETRY_FLAGS;
>   		value = 0;
>   	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
>   		/* Redirect the access to the dummy page */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9c85d494f2a2..b81fcb962d8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -84,7 +84,13 @@ struct amdgpu_mem_stats;
>   /* PDE Block Fragment Size for VEGA10 */
>   #define AMDGPU_PDE_BFS(a)	((uint64_t)a << 59)
>   
> +/* Flag combination to set no-retry with TF disabled */
> +#define AMDGPU_VM_NORETRY_FLAGS	(AMDGPU_PTE_EXECUTABLE | AMDGPU_PDE_PTE | \
> +				AMDGPU_PTE_TF)
>   
> +/* Flag combination to set no-retry with TF enabled */
> +#define AMDGPU_VM_NORETRY_FLAGS_TF (AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM | \
> +				   AMDGPU_PTE_PRT)
>   /* For GFX9 */
>   #define AMDGPU_PTE_MTYPE_VG10(a)	((uint64_t)(a) << 57)
>   #define AMDGPU_PTE_MTYPE_VG10_MASK	AMDGPU_PTE_MTYPE_VG10(3ULL)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index dea1a64be44d..24ddf6a0512a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -778,6 +778,27 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>   					1, 0, flags);
>   }
>   
> +/**
> + * amdgpu_vm_pte_update_noretry_flags - Update PTE no-retry flags
> + *
> + * @adev - amdgpu_device pointer
> + * @flags: pointer to PTE flags
> + *
> + * Update PTE no-retry flags when TF is enabled.
> + */
> +static void amdgpu_vm_pte_update_noretry_flags(struct amdgpu_device *adev,
> +						uint64_t *flags)
> +{
> +	/*
> +	 * Update no-retry flags with the corresponding TF
> +	 * no-retry combination.
> +	 */
> +	if ((*flags & AMDGPU_VM_NORETRY_FLAGS) == AMDGPU_VM_NORETRY_FLAGS) {
> +		*flags &= ~AMDGPU_VM_NORETRY_FLAGS;
> +		*flags |= adev->gmc.noretry_flags;
> +	}
> +}
> +
>   /*
>    * amdgpu_vm_pte_update_flags - figure out flags for PTE updates
>    *
> @@ -804,6 +825,16 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>   		flags |= AMDGPU_PTE_EXECUTABLE;
>   	}
>   
> +	/*
> +	 * Update no-retry flags to use the no-retry flag combination
> +	 * with TF enabled. The AMDGPU_VM_NORETRY_FLAGS flag combination
> +	 * does not work when TF is enabled. So, replace them with
> +	 * AMDGPU_VM_NORETRY_FLAGS_TF flag combination which works for
> +	 * all cases.
> +	 */
> +	if (level == AMDGPU_VM_PTB)
> +		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
> +
>   	/* APUs mapping system memory may need different MTYPEs on different
>   	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
>   	 * to be on the same NUMA node.
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 0c8a47989576..13b89f78d07d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -751,6 +751,7 @@ static int gmc_v10_0_early_init(void *handle)
>   	adev->gmc.private_aperture_start = 0x1000000000000000ULL;
>   	adev->gmc.private_aperture_end =
>   		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
> +	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index c571f0d95994..c68ecb7dfa39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -651,6 +651,7 @@ static int gmc_v11_0_early_init(void *handle)
>   	adev->gmc.private_aperture_start = 0x1000000000000000ULL;
>   	adev->gmc.private_aperture_end =
>   		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
> +	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index acd2b407860f..027b14603037 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -942,6 +942,7 @@ static int gmc_v7_0_early_init(void *handle)
>   		adev->gmc.shared_aperture_end + 1;
>   	adev->gmc.private_aperture_end =
>   		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
> +	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 85dead2a5702..581ed922dbe3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1056,6 +1056,7 @@ static int gmc_v8_0_early_init(void *handle)
>   		adev->gmc.shared_aperture_end + 1;
>   	adev->gmc.private_aperture_end =
>   		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
> +	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 67e669e0141c..ebdbc823fae3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1622,6 +1622,7 @@ static int gmc_v9_0_early_init(void *handle)
>   	adev->gmc.private_aperture_start = 0x1000000000000000ULL;
>   	adev->gmc.private_aperture_end =
>   		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
> +	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
>   
>   	return 0;
>   }
