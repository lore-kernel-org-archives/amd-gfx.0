Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64D3EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 21:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE7010E1BC;
	Tue, 25 Jul 2023 21:55:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8355F10E1BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 21:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ny485zdcuvJy4BX+c5d7dqpIB6pVklmAcXobBTGoD5zRD95+mX1CiITFwxuDCAnrzutotj26mCy8p8Dp8b+jBthU5XOQgoRKo2LUO0ArmbJkPgVYduNEwBf5jrlILIwwHR64N4zoFs+NI9JfPa/SwL5STZ/YLgedoTb8zFzzMund/2vjhVcbgU8f701vDR9Vap/ycqLfOOALWrf+b4Ag1/FG9KewSKh7viaBw9ExwOQUCjRO7oVTao9248uznJN8LLSPnSjDCGv4Tstip380l3YI4sl40UCnyNPG0yZ6k90YkpUund0RY8VLCCZDvGZlJryqfEDj1vA9f5amPJz4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQyIiQr3tAtm4zZsgnSLrRPLs97P9KzlIG9o/JxdPEc=;
 b=T2x23G2xJyK/1l3ZR+kZULao+0Mfta8037hUR10KpVsBVaPoM05BjHiinRRMn1J7bbmNuGwIZAgNk0YMgU8tdk/uGLy2nYpGDHufYciUmnzoqDHqzxjrX5Q64SVHHVZTVCLIQW9kLFg/3pSUFjYiOg/wskpIds8kERs6JAqyPqudqgEbBwWSa28rmBZvf+AtSb9yXQz03m9Y2Pn6Ifmr/rfU9aKCl36GNZVrSA96yHDRvI+hxtJ7qsNNVW6QIQ7gSOWEN2unTkJrRu/eKGLNrAA+dpLBpjNv9/Yel4XrIEkA/WXYhjQHtRDhTiqaFYt5vbY2eLEbQ+JjkruxNKAtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQyIiQr3tAtm4zZsgnSLrRPLs97P9KzlIG9o/JxdPEc=;
 b=ikRdVk6a2JSjOppe+V1NZGCZpiVqM6h5ahOXPFDIuBu2KtZB7bYpU41rCeV3qr+WHsH4Qdq2NJu/1itabKJkzuvr2T104WxOqohcL/cXxMsUC4o8qSoFvSQJ2HQ2hAaAUVPk2If/8dKrFBnAIZ1BE9tN2KVsRj9E7MABplX40Kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 21:54:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 21:54:58 +0000
Message-ID: <e4c959ed-0b1f-a659-c71c-7c0550a6cfaf@amd.com>
Date: Tue, 25 Jul 2023 17:54:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch V2 v2] drm/amdgpu: Checkpoint and Restore VRAM BOs without
 VA
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
References: <20230725211144.2212114-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230725211144.2212114-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: eeffa4d6-bca6-4f1c-d449-08db8d59ca1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdtN0rlSzqzzCbI45z0uQn8eyQLm+ZV2t9tXvpOEaSBGzxbHdQuGG/LgPaQ1VS7XxKg0hE/wWcb90VMiF2nc4Y8G0W+IMz6qGeFQub+Sn6yX/I6EdZ8iPCO88jYpmrhdQ+/5FISzbq/1aGnE78xBFkmnpaDXln+MUZ2Vik4P0z36GkHLUym0U3zYIziT7GmdqQwTzWJavl5ZHEWglguCYNTm1J2N8ZUszLuSSy86igc+mINMiqM1WDs+h7acN3UJLPrc3z3ozLX9473shqMx2yGX3N21peFcWOfcDAH2Eu8E+zdWb7F+zFlahtige6/KTF95xSzoCGznNsz9N6Tr5Q7xQH+G8D67EPxHa4aPw3/P2ny2K+K2Ann1h1U4AecBfDPjSkpRYDw3iX/ojU1xr7QftYKJNqoPSAxt+TWwXNbKgvtgbSM+8EY4Z5iU8nM3K6XSWjpJH+FG6I9dn0dZEXv4OsbPW8HVBtkD/KCJdMlKgCs/Hf5JvdX5PaBDD8TPM58myXv2U99DBAAdjhzTrZ/of029ut3KwVwlpZwvjBTzqM9FU8zLp2P+5Y8d46bmKKNGhoR3X6nYHSTt7XdNrFU4jseubm2QFSjaueN7kCN4c0T37CtYkOKZnh4eypnrq6u0ucoGrnxW42+PXzQJUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(6506007)(26005)(186003)(36756003)(5660300002)(31696002)(8676002)(8936002)(6862004)(44832011)(2906002)(38100700002)(86362001)(6486002)(66476007)(66556008)(6512007)(66946007)(83380400001)(31686004)(37006003)(478600001)(41300700001)(316002)(2616005)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkIxc0M4SlE1OGRvM1U4bGNzcG8rR2N3NmQxUGNsR0haeXpUaHBIOUdrdHB1?=
 =?utf-8?B?a2hybTFjYXdqeU1nU205V2lkVjhaa2ozV3cwZFE0VFpCZ2NoUG5HOFRhR0hy?=
 =?utf-8?B?RWR0NnNVWTJqbDNLVkNxQTBmN0Vrb0lGdG4vWENtaSt6KytFTERLZnFPYTVT?=
 =?utf-8?B?cGlIOHR2VFRoUmRVNlNhZ2haL3prYVFUTDRGalgxN3Y4OXRzNzhVMXFQVkdV?=
 =?utf-8?B?anJRQ1Nac1crU1NBMWNhS0ZmczVxcDBJRGxmdTVCSjBTUUI2T3RRYjlSSWlo?=
 =?utf-8?B?alI5VkR2QkY1QmhvYlkzSG8yUUZ6T2tKN3l2YVVhSHhLaWV5MEpHNGtac2RR?=
 =?utf-8?B?Wmx1blFZaWM3enBieGd4NlJGbmFJUFRROUJNcFp2Q0YyNlJxSVNXenZlTUo4?=
 =?utf-8?B?ekdVUFhKZUNWYkhpSWs2a0tzUzFOOFBYZ1hsUDY5bktXTnJjSlM3SDdiSkhJ?=
 =?utf-8?B?cFFDQkJGSkYxbUNuU2gyTWtZMXpxak1nRmJ4UlJ3STlsM21ETE5VUitlaXNl?=
 =?utf-8?B?WGlLeGdydzIvZ2VnenpLcW4xL29Xd3M2bVpaVVpBcGF1OUZOVzRlQnpjSkJ4?=
 =?utf-8?B?NzhzOHNNMi9wMGduSW1Bd1hvUFpiU25UMy9rTm5BY0tQQkM3ajUwUmJpWjFh?=
 =?utf-8?B?b0orT3NVVTdJNE5Cem1BUEZiWitPOWx4VnlCMmwyNER5eWN3UWc2UW9JVWNG?=
 =?utf-8?B?NkE2TldnU3pzeHRZaTU2L2x2dEZiSThEM2FaN2ZZbGRjTXJ5enF1bU1pQzRy?=
 =?utf-8?B?VEJkZjJGOGhGZVhWWlUrSWVFWnZiWm1PdDJZVWFiYW02MWJlZVV4cVBFM1Nt?=
 =?utf-8?B?ZC91dVdWZi9VeU5RN2kyYzhILzJjUS9lT3oyTG1ONklKMFdWZHk2clhGeWpV?=
 =?utf-8?B?UTlWRlk0ZkMvZ2F4YlJMQTc2ay9tOElyYVBFNTdJWUtuNzBwZWJCQTh3Z1J0?=
 =?utf-8?B?a2plZzF3SFlKaGZWNFBaNHlzT1lGYUJQZjI5QUxMa2dFUGdmM3VjK0tjTjZV?=
 =?utf-8?B?V012NC9sTEx2eUkwTUoya091bzNDTWxlWUMwOEIxYWhudjZQV2F6akpnbXhh?=
 =?utf-8?B?QXY5S3g0N3E5bzdKdTdyMnBjWUZoRVV0OEh3Qk52ekZuWVR2dkI2UmVKeVZz?=
 =?utf-8?B?dFdSTG9RZ3lSb1pkWlU2OFVxdmJRdWVLU09DYUwyQytJdStPWmhTd291Q0lz?=
 =?utf-8?B?SjJxOWNXdWM4VE9ob0hLQ0dxZitlblExSkxLK0d3eWtNNGlqWkpRZFl1ZW55?=
 =?utf-8?B?RXBpVDlyYU90Z3FjVnVpZEJOcVBsVzN6eHBBM04rM0xCUXlHZGNrYzA5U0s4?=
 =?utf-8?B?aVlWRnd6dmFHbnkwanZudWxJWEpTanVMMmhaMWJBRDdDS0tLT00yb0hHem85?=
 =?utf-8?B?NTlsSXJQdUZuL2thZ05vdEN2dzM1VTUvaXRvZUNOR2lVNit5Y3A5QmhuRXdn?=
 =?utf-8?B?Q0lhUkdVendPeDRhMExjd1oyRkpTODZoZHNEOHE1eUtnNnYvT2l1cks1cTU4?=
 =?utf-8?B?YnpsYWRnSW5Ib2NsTkxIbEl0bGw3WHhXYnZ4M3JFVzFpTnlSNGJTTUl4T0xp?=
 =?utf-8?B?dTBpRnNzYmU4LzNHbGJJa0l3bXRNM2MxNWhvQS9GVDFiaGpOeGVJc01UMjhK?=
 =?utf-8?B?c1ZaSHBCQks2Q2hncFJOckczY3dSMVZmRlh6RTJWMWpBQkNKbmluU1JQb25U?=
 =?utf-8?B?bUJnQkdQV0RoSjlSbkh4YkI3aVRZL3hvZzV5MGZtRWRCK1hmTzhXWEdVS1dD?=
 =?utf-8?B?dFUwRSs0TTVWYStiV05pMnArZ2o4Q2NZbCtPZlRHTXA4THNld2hJS0tDOGtz?=
 =?utf-8?B?UGhsMjVqQTNhR01Cclh1Njg5ZVIwR3NZcjRBN3RXbWw2enYrSTdkMGZHNWdQ?=
 =?utf-8?B?bXh3M0p1Mk1Pa21DQU1kcEdONWFRNEsvdVhCaWpDNkJCMXdndENBM2FwajF4?=
 =?utf-8?B?ekRlM2p0TFN3b0xPemZvbHZrQ3Eya01Zc3dQRVpCNC9xRTBFTHJIUVlNSXdE?=
 =?utf-8?B?WisvbEZiQyt2SmlGak5KUjI5RDR3SFcvdUpOY3BUODdHVTc0cDZzVUhoaG5E?=
 =?utf-8?B?RzlJQWdMQWtHQlJTb3R6SmVIb0dJYTVWRzFpbGdDS2FhT3cxcmNGTzA4M3or?=
 =?utf-8?Q?yUWoipW85177m931T1UTKrPlo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeffa4d6-bca6-4f1c-d449-08db8d59ca1c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 21:54:58.7206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rrs/YE6M8qNyG3Hu1HyTl8rfvHrvCW2FPwVk10z9pHesNMbYMdOo4HvXL6ET3J4farbjzE1EP/tJalqaKvX11w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947
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

Am 2023-07-25 um 17:11 schrieb Ramesh Errabolu:
> Extend checkpoint logic to allow inclusion of VRAM BOs that
> do not have a VA attached
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 40ac093b5035..44c647c82070 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1845,7 +1845,8 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
>   		idr_for_each_entry(&pdd->alloc_idr, mem, id) {
>   			struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
>   
> -			if ((uint64_t)kgd_mem->va > pdd->gpuvm_base)
> +			if (((uint64_t)kgd_mem->va > pdd->gpuvm_base) ||

Unnecessary parentheses around (a > b).


> +			    !kgd_mem->va)
>   				num_of_bos++;
>   		}
>   	}
> @@ -1917,7 +1918,11 @@ static int criu_checkpoint_bos(struct kfd_process *p,
>   			kgd_mem = (struct kgd_mem *)mem;
>   			dumper_bo = kgd_mem->bo;
>   
> -			if ((uint64_t)kgd_mem->va <= pdd->gpuvm_base)
> +			/* Skip checkpointing BOs that are used for Trap handler
> +			 * code and state. Currently, these BOs have a VA that
> +			 * is less GPUVM Base
> +			 */
> +			if (((uint64_t)kgd_mem->va <= pdd->gpuvm_base) && kgd_mem->va)

Unnecessary parentheses around (a <= b). In this condition I'd also 
prefer to put kgd_mem->va first, because it short-circuits execution for 
the case that va is NULL.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>



>   				continue;
>   
>   			bo_bucket = &bo_buckets[bo_index];
