Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AEEC61D97
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 22:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD54710E6A5;
	Wed, 22 Nov 2023 22:15:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B634710E31B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 22:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS4rECBTAY6ahOaxuN/EuZH1d+bGJ8Saf2Y/OOI3qpgAvJXp6X9ZpTt6s6XnJFjijcAdjITzs7ZN3PPH8ypIMloKT0ef2Pv22+qVaBZGMLm4OjyuApZE/BN/5H5GxN1F/Cr31YdtbdT+LVwNBR0wJwSy00NFs6vriOqR4w4Z9lMMHxWevg0aN7rnoGhsg/z2wqazAsazRo2sIgmOQxbNdp4y9rAObeeheodrOWDeN6B+Cd0devDfG8qHPysn4OR+2Y4lwLLV4DBUlRP6UW7cHm3FoynSdeCryG1505gJKROFIUIq725az24RaRqks0lPBKaZHR6XvqcZzmicdJf5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqjR94K52GAA89rRkLb/v+cA25aybIEOfnt26+18rII=;
 b=bswNT9aC5ZdTh5IzaqBe5JpKG0H3v3bMSgRKovxhXeDay2l4SDjqaVbJu/tkpuRUoD4tSbTfG7yO055kzoO5YCZlf1f3YmJ1+4vSaLPV7nt/tEAhi5nkMc19M+845orHxUZ2RBPnyn7hlPBNFrJwrAOw/waVqBagI3uzzjFO4gUif/ikvIpviDZAidV34w1MB6zu1dg5fNBzsbuERgYXMGNqj06VU8JxhDluUE1BxYkYRQuLzXkgFWUpN5TyNvzA46M15eQsp4B5O4An1+lj8BnPzF+ebGr0Et5Y1I3S9EX2lsfGXTJoOPlZy5p/Ca7RLgzqPFYA/iZtLgKPOGMLDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqjR94K52GAA89rRkLb/v+cA25aybIEOfnt26+18rII=;
 b=g4I/EPHG88uNEjTfOppNP4I9hXz4bmDfEVNHmVXhH+CERyPg6CdZeNa32+vxJMCLHW6uKKFFpBF9UYz16sN2c9hj8fz49jyee1ktd9nVvmkRHJkRRe5/MLH5qbTIf+/MDE1HgXvTzAB8MLnq5XImO+kV4l3cptosK6S/57iLCGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 22:15:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 22:15:11 +0000
Message-ID: <8a4a1994-f92c-407d-8e12-4466b27ca53f@amd.com>
Date: Wed, 22 Nov 2023 17:15:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] drm/amdkfd: check pcs_enrty valid
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-8-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231103131139.766920-8-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d71a10b-54e4-4e53-92db-08dbeba87e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbaPM3avXdskA37VxKRZPD2tFsfQ7jNck1p9bUQN7/tTOO0kb8m/OCxrFGKOOCVhieziw50W7xE+Xu3xVOo2rlCVB+BKeISMa9PFtDTxiT8mvz/DFTbd9dk2QFiqk+aJ7RXcVdIQZLDJxNSTRxmn+dXxTYLdQS4/BGl3ZPHTwOOwVjhdKDc+1EgnuXyE25gLeX9roejobAWIO9tA5CNLay00gyY4wmcZhfVLUfOs+024lXb33Bs76qiCg2nZkYYCUjPvOEciBvMBmzQuyZFWCjpai72TEV5/iCFBV2UL8Lf15aopSBwfnAscDfMZJTg+Qhqle9ZSSB892TsNxxzIG5VZnmk38QOJi4N8fR/7yzAR+Dg+SrkEJe7AIt7YdBzy+RQhWv4ELREZ7wxkbal1NempOJAxrTRSnx2PuK9Vs5jvW0PUvoiBJ5ekdRGrrZxZosAJ8ZSOMMhgN17DqWW7gKtCIiiKKWCQsiZUS92Bhne5I0qSihsr4s+h/bG9rXRPZ4V0Tw1D4G6CsesgyEiUqOgXgKdmozU1rZVvFfjgE+mRRDcknh5yl/5CY//YzRjG+RV5/SoCNjDFgm/Ck2C45MbGO5D3B+m/Xg7ZVHn848ZXJ9yjMlw9onoY+lpR0OGzQVqXTqeJ5cNR46iUwY7QPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6506007)(36916002)(26005)(2616005)(6512007)(53546011)(83380400001)(44832011)(5660300002)(8936002)(4326008)(8676002)(41300700001)(316002)(6486002)(2906002)(478600001)(66476007)(66946007)(66556008)(86362001)(31696002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ZsK25RKzVmSHI5OEV1djRKQTdDRmxNU1BCSGhFQUp0RFh3RzZoOTZGVWp2?=
 =?utf-8?B?YXJyd3RqYmpUbldOOHVUYk1BdEZQdHorWWtLeEdQbDA0UnRzRW1MQnhGWm4w?=
 =?utf-8?B?NWNYalRKOThUMGlWSTJNdG9GRkNHV1JXd2p1MHlRSE9HYTlBR2ZkMmRmeWN3?=
 =?utf-8?B?WWhFWjlEKytRNG5pT2RwUlF0VnZ1U2JUMWVWVnpHRXJLYjAzaDZaZGt0VFVN?=
 =?utf-8?B?TWhYbktBVDZPQzNnZ05PbkIyVjlqQmhFMy92SUFkTWJMUUl0dzRvZy9wWWV6?=
 =?utf-8?B?c29WOEgrc3NodlJBeHJ6RmUxbGRKYmhYOVJaL3ltT2p0V2hyVUhnWkxrR1U1?=
 =?utf-8?B?eUpxc0QvbTVaWG80TFozR3pSRHZNd3N1ODZpT0R6MmRrNFhJZnhmU2UyZ1Q1?=
 =?utf-8?B?V0RpTHZoWGxBWGVFMnBHMGJvb1VXL0tpUVJycVQwNmptQlZPbGZTQVlucmJi?=
 =?utf-8?B?SlFEN1IwQkNZZUtDVlYvK296TU0vaXVjeTNRODluRTJhZHJDcUlmT0V0V2Iz?=
 =?utf-8?B?Z0VTY2NRbGNxUmEyWE9sUEZWaFA2VWo0emU0bVY4d2V5UWlzVXAyc0U5dW1W?=
 =?utf-8?B?c0VmZ0JpdWQwUklGU0tRNlR1Zmk0UUc0K0J6enVuL0VVcTR1UlVweHdGYktm?=
 =?utf-8?B?NE9sd1dNNUdUQldOY2EvOTBDc0xYQUhrNnBNTVFPTEdTWUNac0Q0MnJnOXMy?=
 =?utf-8?B?SzhaS0grZEZ2QlpvSGw0eWRHZkVGOFNFcUxnU0RsZXc0QjJJMUMvRnhYVnNX?=
 =?utf-8?B?Q2xCanRTczFqaUlZb0FMZEprZEdZZUZ3Q2JUNituZE1XVzJNZmYxVEh1WlFX?=
 =?utf-8?B?T1ZOcGZaWGp4VWI3bzhVWi9qWW9QbUZiTmJIcTZPUGQ2am8vblMwQmY1VGt5?=
 =?utf-8?B?Qk9tUFhBSHduVGl1WThRNkFlWmdwa09UWUdQZm9DYTF2MGsvanE2UGNXSmxz?=
 =?utf-8?B?MW9CQXdZZzhueDJXVTlydEN6RWdyYjVLUkNNMjFVSmtnQlB0N3gwWTI1aXQv?=
 =?utf-8?B?L05WbU4wOFJPVTYyM09RNmV3YW9DZ0hNN1NHbEwxQW0ydVUyVU9IclNzaWww?=
 =?utf-8?B?VlN6cVZNL3dnbnovZnRNNmxNQlU4MXBCMWNPbFJYZ1NKbUJyY0QyblhYRlZN?=
 =?utf-8?B?YVZsTVN3cSs5L3FtMjRRZXgxa25jaDFEeXpFWlZBcmhNUTRVS1llekkwU1Av?=
 =?utf-8?B?M3lIY1QvdnVsODI4K3NoS0NLVnIvTjJ1TThxbHRCNXZ3UVlaVGo0L1FldThG?=
 =?utf-8?B?ZXBsUmpHUnlXM0FQczVwWTRVNFVmd0xyK1lIc3pBVDhRdy9sMEJhV3ZKNFVx?=
 =?utf-8?B?Rkhlak1jNjVjL3BvKy9ldlUrYjhIM2JiZzdIRTBBZ1hvYXlic1BjQTN4REVD?=
 =?utf-8?B?S3FpRlF3eXpKcFMvbFh6cWc5SUdKbDRtYjhxRnlES0ZTaCtNdk9PNWdLMVpI?=
 =?utf-8?B?Q0NtOEcxbVFYbWhvTmNKRDljYkRDNmVRR21hQTIrallIU0N2OVdPb3p5d1pK?=
 =?utf-8?B?YlczVTQ1RDRVUUlZUW1scGdXM1NTZTl1NXNsOUEwTzl5cGpaUzg2YXRwYVVK?=
 =?utf-8?B?TG4yeEo2Q1NqbFVvc2lLcjJFd3R4Y0l5OEw3R05DR1VWUXZ4dXVOZzIzRXJW?=
 =?utf-8?B?dGl0SmV3SGY4cFpuWm8zVC8rRjl5SUtkSzQ1RHFSK1djRUdUOTlVVllmYys1?=
 =?utf-8?B?dEd3T01odVpYMm91ejFQOGNXb09tZEhsWDBBTnRTS3NpRmE1Vm1RNFFGQ3Ax?=
 =?utf-8?B?OHYrbVVTeFV5WDNFVm96NmpiWHgzWDB2aEh6L3h0N21LR1ZZN1FRTHVFK3ZN?=
 =?utf-8?B?NjZGQjVrTmoxWXloUzlmcUhXejZpdnhISm1HV3E5bEJ2Mm5ONkpCVStVbW5w?=
 =?utf-8?B?cWZQeTErSlZBVlFFYUdRTE5TS2w2UkhOcytNaVZoRzFJWTlnY05pNnFxRGJV?=
 =?utf-8?B?R0NhVkFlQ296eklYdmJWT2xFWHVFZ2tVWVFxbVhOMXFRUEEzZFRKMFp4SXBl?=
 =?utf-8?B?K1NtbVRQdWFiRTYyajNPYUU5TWhlVE1TQWdJN0NDNGJvYkZWU1dVV0VEWGhl?=
 =?utf-8?B?NmlLblQ4Zi9hNTZSZHI2NFhZV2VLbXJYN25NMG5UQjdMY1FCbnRvc2ZlTVRU?=
 =?utf-8?Q?z5K0a9GPnGBPTyKS1vUEZztQN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d71a10b-54e4-4e53-92db-08dbeba87e3b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 22:15:10.9280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qu1fs2ShNl1RwxcX5KgGQinnPKPkuA6QMx9OstWjY6eTphmUyX/jyxysA0ybaRmS4OhrIDggg9v03XC6cYXExQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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
Cc: joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-03 09:11, James Zhu wrote:
> Check pcs_enrty valid for pc sampling ioctl.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 30 ++++++++++++++++++--
>   1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> index 4c9fc48e1a6a..36366c8847de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> @@ -179,6 +179,21 @@ static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_
>   int kfd_pc_sample(struct kfd_process_device *pdd,
>   					struct kfd_ioctl_pc_sample_args __user *args)
>   {
> +	struct pc_sampling_entry *pcs_entry;
> +
> +	if (args->op != KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES &&
> +		args->op != KFD_IOCTL_PCS_OP_CREATE) {
> +
> +		mutex_lock(&pdd->dev->pcs_data.mutex);
> +		pcs_entry = idr_find(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
> +				args->trace_id);
> +		mutex_unlock(&pdd->dev->pcs_data.mutex);

You need to keep holding the lock while the pcs_entry is still used. 
That includes any of the kfd_pc_sample_<op> functions below. Otherwise 
someone could free it concurrently. It would also simplify the ..._<op> 
functions, if they didn't have to worry about the locking themselves.

Regards,
   Felix


> +
> +		if (!pcs_entry ||
> +			pcs_entry->pdd != pdd)
> +			return -EINVAL;
> +	}
> +
>   	switch (args->op) {
>   	case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
>   		return kfd_pc_sample_query_cap(pdd, args);
> @@ -187,13 +202,22 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
>   		return kfd_pc_sample_create(pdd, args);
>   
>   	case KFD_IOCTL_PCS_OP_DESTROY:
> -		return kfd_pc_sample_destroy(pdd, args->trace_id);
> +		if (pcs_entry->enabled)
> +			return -EBUSY;
> +		else
> +			return kfd_pc_sample_destroy(pdd, args->trace_id);
>   
>   	case KFD_IOCTL_PCS_OP_START:
> -		return kfd_pc_sample_start(pdd);
> +		if (pcs_entry->enabled)
> +			return -EALREADY;
> +		else
> +			return kfd_pc_sample_start(pdd);
>   
>   	case KFD_IOCTL_PCS_OP_STOP:
> -		return kfd_pc_sample_stop(pdd);
> +		if (!pcs_entry->enabled)
> +			return -EALREADY;
> +		else
> +			return kfd_pc_sample_stop(pdd);
>   	}
>   
>   	return -EINVAL;
