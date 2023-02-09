Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C61DC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 04:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2391910E0A8;
	Thu,  9 Feb 2023 04:09:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF4310E0A8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 04:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvuFJ9CeJ6InDGUB4MN5phCF6abyPbDcgYtS7M8LJilhKrmoChb0oeg5p/q83wk1WS/3TihhRosoFw1KCJkGmU7NjKtc+D6I1IMI3y2Y4zFH+IaPdTxdDsIfjihuyLXCK2ZUWlaKY4D9vOhxTH5vpGoWa9323xGEr0RagcMiNK1P6OdPqLSqnLQmThEWTWokrV1/U71Tspo7HCV7QLyv9rio3uqkQAfVAN463b338HKetIiG0kcvnozZfAunrnaiogxwQ0p7fqavmTas/ORfRfj/FZF3yrjnNMLrCKRiNhilW6QO+7Ro5oMykpC62rtGpJQ5loLl4ckW9Tzt+sXFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fsnu3Vw1VX2NOqjSuXagTT5Kv4FzUoYxpRoxldLA5b0=;
 b=mGOFjl7rd1AoH4wsI6zkO4I+pOH6QxCwPYnkPw7Z19O+sgtnrAGpfyNZekbegQhpwut1lK3wNpH0+rSeBaAj5IDtg1brtiLFDlAAe3eO/hp8+Mf2ENBq0eP512XMHNMtIkZaKvymTQHmQ/ncLyTRPZx7kus5+GlYmhtujL5oeHnP6ZhTFBOoUo9kkTq73d4v/3JgQQI5dxGnZmHEiBmpuU0CtO9dnHk1XXSIGOOe3e45oDIMi6JPlFkokPKoI6V6I95ewybyTh8UNQje877xIjDGfcUL23jtQnPIR6DVQOztbZ1mR3ZPNuI5iZk5h21S+as4GOwv8sh+kx9d9CSC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fsnu3Vw1VX2NOqjSuXagTT5Kv4FzUoYxpRoxldLA5b0=;
 b=ZEAzinChjuAb/hdJuRRlGbsqZlqKLIs8GwXIMqNG4rm/OZGy5LXsJV6quxAPve6uNWMbOzo4ZkG7rVgecDVgiddF60ye9HcmYsopCcXIBWAIlXAsutfebo1IT8FOwi7oNO3vjvlqvf/ysHFjr0wr70RiyDyQgnGJ4N0lI0W9eZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 04:09:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da%6]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 04:09:06 +0000
Message-ID: <b64cf96b-bf46-a05d-0368-2355d13db3bf@amd.com>
Date: Wed, 8 Feb 2023 23:09:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] drm/amdkfd: Prevent user space using both svm and kfd
 api to register same user buffer
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230208232633.1399053-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230208232633.1399053-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b641ef-21ac-4498-1850-08db0a536317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pp6LMXUnz1W9atEdXqxcKDsgoBW4w0VOgvq3WkUjHw2YJp5MXJE3/70tsRdBKPf5Ikcf6jvVVYVkHgLO78SmvBBqccMVWu9Sb7sSjAg8kRMb1qDDu88aLRwzMrAA6X974UkyjNN9t0weqlQ0veK/c0RvQuJKlnIIBftB6XMRorPoi+VDrWGuCs2gwEyZCj2AqYVz0GhK+iUoKrbu5c2ed7bzOaj4FChrrhr/96baLam+700vuWQxq5YP43AX/xZaL0Xu+fppN6UF/v/M9KmhxruksnUxK951KJYRIXh9I795mAbmIpCmGgG3E1wOLzqvEID2U9B1KeEArJOA2GQzxYgegcscJNKWLY7PrkBaZngmP+IX4oOOTX3Az6VxeIY0B/FGGJCqmDxhuTCpJ/Fpyo9SqNceqUKKnDAf95nYfNOt6gRrXNpcQdVc5NDJEVl+9H1N2KfOWuGX7BrYpq+/oL3U2sPw2QoaF4WNuXgVk2lkFjU2HNXFyV6Tm4kYTmm1OK3MiVuAqvRle39Sn16IYfz1+YpadqkwPuxuekbAbwzfCWI7z5TXOmz+hNc/MeEWtiVZ2LiOVeRnGuS0GgNxKThWGW9vIvTCTRRAC/fKLOdiPFL0WqtPvk1IwvwzUbPhKswKyyv5cfvR71IaE1Y31eO0E2S1z2Umg5TeTKn4Rr7HwqSR2sL8JUts/dsuaa2jYmyzvO61ZaduOzdXWJ5HZf1HnqhTGrfQfchK1HvzOGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199018)(44832011)(2906002)(186003)(31696002)(86362001)(26005)(2616005)(8936002)(5660300002)(36756003)(6486002)(478600001)(6506007)(31686004)(83380400001)(6512007)(38100700002)(41300700001)(316002)(66946007)(66476007)(66556008)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHpjbThJV29vOUJXSmpHV2ZmMDJWZzZTRXJkckI5S0tjVy84dHFGVmk5WG9I?=
 =?utf-8?B?MTVPc28zQVdrMVVwTUY4K0xrNmtvQVBrSlZ6VitOSFZqQmRTUFhKK0FGMzZL?=
 =?utf-8?B?UlViaDZPS3V0bWkrdlY0VXFCVWZGajJKMnNQYzVqRlp5Y2RBejFidFE5RjZO?=
 =?utf-8?B?Vjh1anBOVGZ3QTRzVzlqbTBaMUlva2RYdHEyNDgxMXBsRVpPRHlNVCs0aytU?=
 =?utf-8?B?TmlMSktPQnRnakJQNnZUL0I5NklwQ3hrZHpBMDVLWnBCVnVpS0Z5MlA1a09t?=
 =?utf-8?B?UElpekgvT09ESGk2ZjNXb21FTTFhcnhJbUZmY0VWUTkweDBseGhwcVhtZzNt?=
 =?utf-8?B?cEU1VlNaK01xRFN6aVdGcittS3NBZXEwSE9oNVRvclMzMHdWR0xwcmZCS1lV?=
 =?utf-8?B?TGxJbWZqZEhFV2FiTzhyRWZ2OE11QkZSWFViT3RraWhDZGkvdjI3bW1lMGNl?=
 =?utf-8?B?bnp1NldrR01KVGNlS0hlNDdTRzRtZ3RzZTlXNXdCN1J6U3Vzd0FOUC9xRkJJ?=
 =?utf-8?B?YTFnKzIydHg2N3hiUTNmT3pKd25LUkx2ZXZUeXM0eEcwazhQOWNuWjZqRFBo?=
 =?utf-8?B?cXQ3SVEyT1ZpSmVPMUNGY1B1QjdYWkpmQlhtNGZxcStSTXM5QjZHbjd5d05D?=
 =?utf-8?B?a2c0ZXVPQU9CSjEzQ1dFZ2ovanZJb2dyTm15cGVGWkVTVGdxeWtkeUprR2ps?=
 =?utf-8?B?RTkyYjlDbzFUNFhPeXlPZ3Nwa3dtd3JLYnJvNGxjOHRXZjA0M3NHaG1IRlgy?=
 =?utf-8?B?a01HQlB0MUdWZi9ya0xGMDNtQ00wbEJtZnNuVDI2UzZhNHBUeklEcTl6S2Va?=
 =?utf-8?B?ZC9jWEEwdjcrSEJUMkRUZWJVNS83VmFmTERrOVVLY0pLdEpEeHdZRTR3bHNG?=
 =?utf-8?B?WUYzaU5ZQVZNZHZUeGtFWGFLWTdEcllYaGRvc3pPeDR5OENTdHlKNlBPV0RX?=
 =?utf-8?B?d2VFcWtLU0wrOUVQYisyR0ExWWpwRVIyRlhNYWkxbm1ZQ2s1djdydjgweTR2?=
 =?utf-8?B?YW0rZGdJS3NVOHgyUXdsbks1ajJ6V2l4KzZxYmhmRG5xTFBCSXZsdFFMdjd3?=
 =?utf-8?B?WUNLMGZsVUhZQk9XcjhncTE5dVVEakQySkl2c2VLZnpMMzZibGtTWmVIaFlL?=
 =?utf-8?B?WlRGMTBZQ3JiZnB0cUg2dDNBWVhiUmwwTGhrMFQyaFpCMzBrWURZcDBGL1pN?=
 =?utf-8?B?VDRxbVk4aGFKTzA1OW12UG9JSWl5alVnSno4ZlN5QnFLMWs0NkhHR2svbDN5?=
 =?utf-8?B?ekgvUWZwWDVGeVdvVDVDcVpPNUhKR0hOOUZXV09qWGFrWWhyOVkwSEVCSGU0?=
 =?utf-8?B?N3N4VGhCZnFqTDRlNVVDN0lxNWNWbDRHQ0ladTZGdFR3QmJqZnRScCt2R2t5?=
 =?utf-8?B?SmltN0h3d3VVdXlFUlhGbDkrK3lBZUZHQTJUNUl1QkF2cjRpQ0NOOWR4Y0Fz?=
 =?utf-8?B?aHlBUXd6YkxlQWJXaE5wNDY0T3NrSUFqOTdOMi96UmFVMUVqWFlKRU5yZ2VR?=
 =?utf-8?B?WjFreUFHMTBDdkd6c25KMXl4dXlrZHJ5WkRqSVVXV2pZN2hTV1RyQjJZYzJ1?=
 =?utf-8?B?alMxTWZQYS93VVcvUkNLbDAvSDNzZTdOYVY4YUhDTEJ6NzBRL3M3bGthSGkx?=
 =?utf-8?B?Z2JhMXdNTFAydm1ENm9SN2N4VVliTzVZQVVKUllldWJwRTE3RTFoY0hSVzJ6?=
 =?utf-8?B?VWVrZ3R3ZjFiUlFhejF2Tzc4TzcweURaQVlrcitDQ0F5b0lKYXdETlRxRFY5?=
 =?utf-8?B?c0RWVndsNVl2dW4wZEZQOThuQWJsTTBqckV3VlNWSXYwL2YxMWVGOWVnR3pI?=
 =?utf-8?B?VUU2ZDBsQytXTmxDVEs0NzdLa3l0cXMvaERZdjJhMnBaaXBiZFFFVXpJdnUw?=
 =?utf-8?B?R2F6MnJteWNLZFBNcU5iNXJnL2h2elpOUkVvbVJTWm9UaVFTQWFSWi9LN1Fp?=
 =?utf-8?B?dUl5QjdyOFQ2MHFVSk05dTJpbUhRcUNMYnBpV3pZRE5kZzRHaE0yTWV2SGNq?=
 =?utf-8?B?bm9nTS9Jc3QxY1FxL2k2MDJnWWJsdWhxRWJqeG9yK3hpYlQ2SnRGa0J3WWU1?=
 =?utf-8?B?MXpzR2xKcG9yNmcyY2dmWmRpMWZqOTVFL3FjeGYvc0RBL0dGMHY5QlBHSy9t?=
 =?utf-8?Q?NwOSM9pCfgSXGy0bpegdkx7ud?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b641ef-21ac-4498-1850-08db0a536317
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 04:09:06.5953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKIxf0mFaqUnUwt9Hj4fRlRVE5tljIRYz0syV731KYX9G199U6oruzDEjeFhPngViqVilHC95pIHJJ4EYUGr8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
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

Am 2023-02-08 um 18:26 schrieb Xiaogang.Chen:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When xnack is on user space can use svm page restore to set a vm range without
> setup it first, then use regular api to register. Currently kfd api and svm are
> not interoperable. We already have check on that, but for user buffer the mapping
> address is not same as buffer cpu virtual address. Add checking on that to
> avoid error propagate to hmm.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index f79b8e964140..072fa4fbd27f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1065,6 +1065,20 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>   		mutex_unlock(&p->svms.lock);
>   		return -EADDRINUSE;
>   	}
> +
> +	/* When register user buffer check if it has been registered by svm by
> +	 * buffer cpu virtual address.
> +	 */
> +	if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) &&
> +	    interval_tree_iter_first(&p->svms.objects,
> +				     args->mmap_offset >> PAGE_SHIFT,
> +				     (args->mmap_offset  + args->size - 1) >> PAGE_SHIFT)) {
> +		pr_err("User Buffer Address: 0x%llx already allocated by SVM\n",
> +			args->mmap_offset);
> +		mutex_unlock(&p->svms.lock);
> +		return -EADDRINUSE;
> +	}
> +
>   	mutex_unlock(&p->svms.lock);
>   #endif
>   	mutex_lock(&p->mutex);
