Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E79DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 14:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A2F89DA5;
	Wed, 16 Mar 2022 14:04:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D3D89D8E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 14:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJaGIde6AfwO4vWuv8VMinH2JuTuIsY3FY3UWzKcGn+TnvoAnCWNp1Rk7x/jXeEc2v/95Ixhw5Xv5OBFZPGbS4psvIp9pBs19c/Unbl1qNurtHd+EszRBS79yTCVOcFPqRYVzmH71bsmtBlqgHmKG8Y6dBdbE2NpHgodOTUYXQR4NtRj53HVssabL82z7l9DIg7WH8h0FO+Q4Ns7wjcYwfX3mTE6X0cUmOjew5KGR3uzZqW7AyPpkFkWqxEuzKXKWgheC+i9FLME9bVPBAxD/CpFLzeeM19YgwYKLyoja/dLKreP7qpmOWvDd/PYKOfeNublHfPtUoEpFjihJjzwJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fqjB/z3MvJaMyXEjBnz/EAyGVZd04Z2bE1wFEU3BeE=;
 b=oad36MR9V7BaPNzfElTP8+l5oqgX5wtsQf6N8Gd+Wif+EoAUxWSNbGOdfY9X8VuDMl/svV8uWTVhbY2k0E6wwVfxBdcde99c1UNcJBVY+ATDrlROgyOZdfl2m1JTxkclakoOIxS3LFW5GF7GbkJBbx3nSSG8GDQU4Zk0sBd9KuRlT67zvPcYS+ZAoLlvHjp4MeLUzmowPNAT91UVPxRYhTlRdRYiTqEYshYOBsPULMGNJgNrmkYQE5jbjwl4Ss6k0CuNtd/Fv+yAr7eyU1xKIHEGjc+znEUunvS+R0J+llXo1M3CJFh5LjWA+o+BoV63HIjBVBG+2p0yh9kPCuVrUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fqjB/z3MvJaMyXEjBnz/EAyGVZd04Z2bE1wFEU3BeE=;
 b=5dSOErpCSwFTg/2vJ9v+jZYZ4FjYhrEKUza3a7KCbYqdeVy0d5zyiTgju3RwWN3hJGc9IcxYTRCuAvg8yicXycRrcyy1W3z2NNf/7ub7773B8jxO2Gymy9+WehkeATwTJ/SAVdTuR/TxuoZtlH8SVskJ+8GwXtmtEcgot3+/JlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 14:04:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 14:04:23 +0000
Message-ID: <6b278e9f-a443-b297-ab59-c7126d324302@amd.com>
Date: Wed, 16 Mar 2022 10:04:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] drm/amdkfd: refine event_interrupt_poison_consumption
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, yipeng.chai@amd.com
References: <20220316092627.17359-1-tao.zhou1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220316092627.17359-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c355813-d3f7-4810-2420-08da0755df88
X-MS-TrafficTypeDiagnostic: PH7PR12MB5878:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB587815A308CD69F6D9B4835A92119@PH7PR12MB5878.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKklsRXWVHBHd0PZCKP6Xq9N9osfiIhhrH6VvtPFdq73uljxCHIqrh5Xk9rTaTBPuTUGtvvMNEVb+40jAavBQMVm9HFd0ks6GpvqGhJwQw5bhzN+qTqPjLseh8c61EIbTpwjrjhZErejkdb4INZXatH0tsN8SGEOsni36oHcQN8VhDz0GVUJ1igZgf5snmOEF2ttWqxtjuKuFiHiOKixJsjhAcjKf4FizCaAUijUpDoyVloPmMGfPpt+DIidUxkXiWKR1//ryEvLeGAp47/aHSu6gd1kF00bzwG6XMsI257qbomH1TwQrqVGJTdfkRSrwbVatNK8hsxzwgZ0GeQoujHAXmoPKf8rcRgql0+HBOQlr48GwsB4jYlMGllJeqLRM3SGgDtIaAupsPLvEAGYRGTWNM7i4LgoQd1K1yOJaPJwWBQrkQ/QukUA9iKeGlVlmxm/BLjuNCVtjiO+kJW1AO9dgyGAPhEI21XO70RSjUhao0JKXWU2BY3qZgkcLTpXZtAWndeEKO9zXpfVmBqlJ8M6SVH3wkc/YH6oASi6Nc5mYuknpkOVGJ9EiePLR61AqWqtrNzFDVjTcaY/9dxceG8gbOAaJ/zSI+ZnT1okgPswRwNV0354yO/mnhtFn9A3bzdmanqstcsB7K1ZHhTDyiWVEDnVtJi/Ei5bebCHdIVWTfwxNZh4r7cSjxzaLmFUmHAXjnt+kLgDfzBrqUMYBLSVBIMgUnNCTP1PQL+rUtKMeUihrSRcX0WpUR5xD2Jr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(44832011)(36756003)(66946007)(66556008)(8676002)(5660300002)(83380400001)(66476007)(316002)(8936002)(6636002)(2616005)(6512007)(86362001)(26005)(186003)(508600001)(6506007)(31696002)(2906002)(6486002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFV3RHEwdTNvd2U2VGM2VGdKcW4rNGkyWldrM2pIZVJpRXlsS3hrL2hQQlJR?=
 =?utf-8?B?R3lwUC9ENXlFcGdFYzk3THhadHpscFRMemYzV2lrMmdGNjZCVHV4NW5wT1Rp?=
 =?utf-8?B?eWFFdFlKYXRCTVpMK0hFMnFWWVRmRE5POEN5aW53UHcyanpUTnZzWjdKbDRG?=
 =?utf-8?B?ZWxLRXN2N2RpdDFvaDc2OUlBb1hGOVd4VGhVdWRncEtSWjZGUVNYZmdvdWJp?=
 =?utf-8?B?UlI0bThZaHpSbDNraGE0aHZ6ZmJTWkYvVXoxTnZlTkIyOXhIOStpRUFFQUhM?=
 =?utf-8?B?aDIwWHEzRGZBUE45U0dGWXlyQzRUT0RXekx1azNrVUhhRHovMnhWaEprSWNK?=
 =?utf-8?B?RHlrZjY0a1ZoclVLTTFHMG94R04wR3J6RGM3QXYrclF6bldFeEZnUFZWSUZz?=
 =?utf-8?B?QlZRbFFFYjBUSWhIOWtmTVhBaTM4YUUvUHFtSHhLampUbHBoOExhczg3MXRr?=
 =?utf-8?B?eHFGa2ZUV3dJYWxsN1FOdmJZRUVmc2hNMU12VWdDWjFhbk1pMHAyejV5aEFH?=
 =?utf-8?B?SGwwNFJSWVZIcVJTcDZpajFrNVlLL05BYyswYnIxcWF4bXJpRzVrb1MxcjRS?=
 =?utf-8?B?R3lTSHFiL2puS2ZOTzBRMEVLM1pwVGY5aktPNStYQS8vSml3cjZCTUtkYVJi?=
 =?utf-8?B?eDJ4WTFMSFNaWHJoOWZqWnBaQjQvc0ZaMWJvcFpIdXE0UDk2cjJCRkdFalJM?=
 =?utf-8?B?aEFwZERaaVNacHhTRW1ZSGtkbHZISFFDNmVEMWRpWWE3cHdxSG5FR2kyWHFl?=
 =?utf-8?B?R0FvcmdyREF0ak5hMEU2RlJXT3BodmVhQ0t5eDdUNXRPOWtyQ2hHclQ3SkVN?=
 =?utf-8?B?cUoxdElnMjhvR2hnZVdDWXVqOEJVM3RKb3pSTEZuaDdnTEhDSXZNWUl4OEFh?=
 =?utf-8?B?OEZ1T0ZPNFJxajlNaCtEQkxEU1V0dnNoSEVEMXdJSGoyMWZoSkMrRmtoNWJH?=
 =?utf-8?B?ZGRxWVV1MG9TcTg3Wm9kRk1SZ3l4NDVXdEUxNzNtQXRlTHhIaU5KOFJrejda?=
 =?utf-8?B?M0lyT1R4T1lqUG5pZTdKc0JEb3MxUDlTUTlDRUpwa0pXTUg0SFM0Sjh4Zks0?=
 =?utf-8?B?MU15blg3N29SRytmekZZMXhUSkZKU3hDeGJKS1BjWmZlUTFQeXRpQTZlRy9W?=
 =?utf-8?B?SW84M1BoQnJuSVZzSEM0MVRvZjAvRWlkY0hDbnJLcVJxRXRaMWI4Z3I1Q3la?=
 =?utf-8?B?Rm5ONGV0ZlpadzgrM0M5WkxNYWJsZ1hleTdQbE5FOW1TMjhvVU9tbnM0OFpO?=
 =?utf-8?B?cU56STVtUkN4c0lrVDA4dGdtWW1lM01Xb1JTeFB2dkRGRG50UCtqSFZlRWVX?=
 =?utf-8?B?enErWkE3Sm1RUUxqMUtWQTluNHVTRFBmQ1ZTc0tBWVFUamcrZHA0REo1akhG?=
 =?utf-8?B?OHovZ3hSd3hrbjlwNTlqUzgrNFFPNEtkcmVkRDZSanZxQzdEV08yOHJGUXFx?=
 =?utf-8?B?azJPZjloMFhvM3pwWkJZbkF0RVRpaHYzblhGaFZTTWdMNXhnTzEwSW8yblFi?=
 =?utf-8?B?SHJUS3V5NXFkY296MVVJalRxenJ0dVJDMExSN1YvYmliQXBLY3hBZWZ6Tkd1?=
 =?utf-8?B?RTArSkhlcExwM2Z5TmcrYnNrSVBwUkFJYUJiL0t1SC84QVZvYjF5TmhQOVZ4?=
 =?utf-8?B?M0drckVoVW14UlBTL09WTGxnK0dTNmNqWjJwK0JXcG5QZXBXVVl6OWNLZW9S?=
 =?utf-8?B?QVdQM2R5TGJia1lZODVkWEU2ZUNvNzVNcHcyR1BzazlBSW1vOHlPa1NKTXdy?=
 =?utf-8?B?dWtXeWlYVkJFUUQyc29nWkdlNFBEaVgwSGQ2MHd2VFVJTU9WK1YyTVRpNjRE?=
 =?utf-8?B?ZlBqSkljNUNIWFlvdUxlb0VudmNqTlBIWlNKSDcxWi9PVE9uQWRTcUZFQzNu?=
 =?utf-8?B?SDlmNi84cnBhQllNK29PbDNWenJ1SE9tajgyVW00SU03TzlRSitTNHNROVVU?=
 =?utf-8?Q?ue2LSU9KOE/7n1068M1uLE85ys7YyOYQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c355813-d3f7-4810-2420-08da0755df88
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 14:04:23.2545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIwOwqbDmIay/HZk+jfQSAeownytjsfnZP/eUid4YpZR29wfuHI4utIt+UxIrsbtfNlvbyWf952QEvShj2yFqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878
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

Am 2022-03-16 um 05:26 schrieb Tao Zhou:
> Combine reading and setting poison flag as one atomic operation
> and add print message for the function.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 7eedbcd14828..a992798ff8b6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -93,20 +93,19 @@ enum SQ_INTERRUPT_ERROR_TYPE {
>   static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   				uint16_t pasid, uint16_t source_id)
>   {
> -	int ret = -EINVAL;
> +	int old_poison, ret = -EINVAL;
>   	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
>   
>   	if (!p)
>   		return;
>   
>   	/* all queues of a process will be unmapped in one time */
> -	if (atomic_read(&p->poison)) {
> -		kfd_unref_process(p);
> +	old_poison = atomic_cmpxchg(&p->poison, 0, 1);
> +	kfd_unref_process(p);
> +	if (old_poison)
>   		return;
> -	}
>   
> -	atomic_set(&p->poison, 1);
> -	kfd_unref_process(p);
> +	pr_warn("RAS poison consumption handling\n");

If this left over from debugging? Or did you mean to add a warning 
message here? Either way, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   
>   	switch (source_id) {
>   	case SOC15_INTSRC_SQ_INTERRUPT_MSG:
