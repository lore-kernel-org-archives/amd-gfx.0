Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F93DCA5539
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 16:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139B410E02A;
	Wed, 13 Sep 2023 16:14:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D7F10E02A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 16:14:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nu0Bb/iVRxBiFGMmcoXnQmDcPRNIHcPfqaL42Yh2+U0oT8qiT5+d3kviq548OpzRkS16k61yWUEW8U2lQfIG9S5phDHTA7GW+AofhjlwA1NCHFoxP+381Esd6rJ2xpJtEUnDzp3arLbCiHhOVPXXA9LjsPXxVvbyMDFPwpBzLNTm1WA0ohu8Z35LqKVDDx++sR1UyCF2E0vD9yOItXXLsSiPKMcSa75EdWGe8DA08CJg7vya0WophfRRECSIj5qAGSenAKdQFvCObcKYLrgN6JzWG/Zv0wOKMuj2gjeiXvQkZGSXjNLNiyPLdgd9oyy9xrhWpGbEqUVa2Cluqb/25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lTswuW9MFFCcc+1O6yYWzvvigt599tiBv8evhYAbcs=;
 b=frm1f2CyPCKRGfShv2xvoKQ1Y4GFeo2DmnpjIlhbuwDjCD+j5W8RpuKa93nEzo/HINiSZrYzcZL7rS+9QZmJ0zuGRcRmY3fX+lB9zCqG/ORbKpIHcsyJi1qNP0ly1Y0zToUXjxU7PRo+NmY3UafcF+ee9ZEBszBzxL6qnn3Dy737cZcs+Cx60ho3FWh1UHtKmvDeTsJ2I/0FVSlaWRnlYz6YSoEknowJ9SSmd3MsFHN72f3II1Orqn/QiJQpxX6455gSaID5OXopTbkWvtCVyhuGJF/Ol0/HCkyYBhmX8O6CCjlE5//yZ9gTm9dZDyhMcQbKIuvQmLieqdaodgV42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lTswuW9MFFCcc+1O6yYWzvvigt599tiBv8evhYAbcs=;
 b=SClY1w6vuc21cjOnLhc7fu02acJPAo9Ct689Jdu9jufVqv4L3OgCWe1uDruiZTwWxb0brT/Q+8oXZ1cZhV5TMpRqlocBd15vN0G4drL5J01BgybMjAnpQJVbA2kPf/bkfZs94+xE3XLIhGKo9vfPWY8BW49G5zvNWymw25MuTCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB5024.namprd12.prod.outlook.com (2603:10b6:5:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.39; Wed, 13 Sep
 2023 16:14:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 16:14:12 +0000
Message-ID: <afb950e9-47ac-5823-8ed2-4c1e01fb5f0d@amd.com>
Date: Wed, 13 Sep 2023 12:14:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdkfd: handle errors from svm validate and map
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230913151617.18894-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230913151617.18894-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::35)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d28e120-0bf6-4061-fac8-08dbb47477c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/daPG7V4nGVFPDShqNUqZznsmwQocSdKkKpsbrHY4cZr2vn/N5nIx1dpWchoC/X7/c62b/kzjkmlwNQiHWMya+yM7flqG+mlGMwZQyASiy0YvsmSI6+YcTkiF2nuxJdoeU5QOArYlLcRDDGY1sq1UEJgFwmziI+VVfz02s6PWbrWhw0Tar4cUb66PvN/A6WGCirZGm/DXjZ61/8EI8FD0JsSxS60ll8AdC3fT1OtNrW7yLbrYi2nOi+R8InHC4BaA9MjLTOwKYQesouHXvNFpe6XBs6tr/dyYgS77Obyr8G6/OMiNAAMFQtZMluCpbnXss9aNkvWnZ/0oIXszIIE4ZvBaBprBPtkhJu7Kp9hMTmvMn4+Tm2NNctJebEJuOarTthLJujEuT1eYYezi5zBw6ZCbhhYoV2fsOtXni/BJ9IdMAAVy+3PaCiRvRut3siFgAS4bCiQvXTjk6RhQG9wbrSJhJz+gbsPJX1GQtr/a6OVp1h/nwhv82Kk9ZvH6QBK/LpXrEg2vs4lpgtzvzK/ruWomwKSfHsX4IZYgRgfnyez2fhnaZVf6yMdJ8KWcZP2vRHxdI8Ep1ozF96GDohcTeA7VQFYCrH/VMTOt4rgovsCNV/byE8E/nI6DkD/Tam8pLxt/QxOUVSDQ4S+2dqqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(186009)(451199024)(1800799009)(66899024)(31686004)(6666004)(6486002)(6506007)(53546011)(36756003)(86362001)(31696002)(38100700002)(26005)(2616005)(83380400001)(15650500001)(6512007)(2906002)(44832011)(478600001)(5660300002)(4326008)(316002)(8676002)(41300700001)(8936002)(66556008)(66476007)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3BVUFNzWGFBTzVvWjh4VkRLbStLS2lKNG12R0lOWVJLbmpjaTlvRkdaUndw?=
 =?utf-8?B?citsUkpIZ1FpR0QzalVXNEIrNEVzd1hvUWNLbU92eWJyb1Q4NG5CdEdsRUF4?=
 =?utf-8?B?cDExMXhyLytoVHhkYkNwZUduTTA1R3FnQTJHaTBmK2pQWFFjRjRJdGRHbnkx?=
 =?utf-8?B?cmp3Snp4TVJucmprWlF1RkRrdjA3OTFUcUg0SEtEU3pXVW5kc1RuYjAyNGdW?=
 =?utf-8?B?QnpiSVhKWmhjTzQ4SmJ6NHRObFJsNFVQalBYOXE1SkRMN045b1VYdzdrT1BN?=
 =?utf-8?B?T3VWVzJycDZWclN0NEl5bk9aS0xISWtpWm1OVHhNdDd3MDhFZGYxLzYzaHIz?=
 =?utf-8?B?M3FZYTZhbGxBTnpVbWVTUFVFYnNvblgwbk5PR3VLRWZiTm05N3lvMGlVQS9Y?=
 =?utf-8?B?d1ZMTU9KZVU4RDBlbzNYUktSbTlKYUNsWTN2VkxVNmdmdG5GcVRiTnJSNzNH?=
 =?utf-8?B?UllHd1JBdHhDUlJHdTcwcEk1Q1BXZW9ReDMyZDdDZE1WOWc0MmlkbGhyNHdo?=
 =?utf-8?B?OHQ2aTJndG9USkNsc3BDWDQ2N3BnK2pBUWw3Z2FldjFpZ3lNQytXOU5jV2xh?=
 =?utf-8?B?SzkyUXUxSXNsNzVkc1B5MTI1Mi85VExjdUF1TVROSmsrbGUzNmZ2YjI0eFJB?=
 =?utf-8?B?K2pzLy9jdUFGU1JBWm44K3F3VndyQ053SGE4R28xTXJLWCs1Y0pNSnpnYURw?=
 =?utf-8?B?VzVrL2x2Q2Jva1RaYVhxZWxLMkpIWm1icUxYdEI5YWhKWGZRaXV1L0JRVVNJ?=
 =?utf-8?B?K0JkbUh4RXhMRE9xNlJWTkdwT0lZZVgyeEhod25td0l4cTN5MFBkaW50a25o?=
 =?utf-8?B?czJkdGFCQWMxK2pKMjZoZlFWcldXc2t4QjBRUXpjYm9wVWtQQXJuakt4dEhE?=
 =?utf-8?B?V25jbE5JeU5CTG9ieDR0YUZJaVA3OUVxZUxTVTZJcHJjWFBBU1NtZGFkTEVC?=
 =?utf-8?B?WjdFVTlKcytGYmYxK2d1elNrdnRBci9XN0JuazRaZG56TytHM0thcHY3NVRy?=
 =?utf-8?B?TlRjVGhYbjUxcnBYZXJXZis3SW1ON21jOEFxTDZjdE5mZ1d2dWN3NGZxMm9w?=
 =?utf-8?B?YWR3SmtES1hXR3A5VEJJalpML25LQ2UwUEY4R2RhRjJzQzZSUjJWSE8yNmlG?=
 =?utf-8?B?UG14VXQ0cXpXZTlDMEpYSitaY0NJYStKUHdERUZ0S1F5M1QyZlkwS3YzV1JZ?=
 =?utf-8?B?dnBNbU0xOHV4MS9IOEJuRFlPQkJNOVcyTXFHeFVzcTI1OGpQQ2pZNXIvdlZO?=
 =?utf-8?B?dGpkdnZHQ2dRTFVYSmFLdGh6NzhFdEQ5OWQwbUw4V1d2dStzcmRmclVNdVhB?=
 =?utf-8?B?emVhcWJERExRMkIwVERmTTVNT0NyZUUyNER5ZVAxRjUwRDNrclVReTNCWHhu?=
 =?utf-8?B?ZGF6VnFOWDVFek1zWVJQUHNRZWRQeFRKMGlMSUg3eUdZT3p1cEMxTWRjWmp6?=
 =?utf-8?B?NmNGSllMYnFHUDczM2VhT1lZSXBhdC9uQVlpODFRcHF3Tm1BM0dOcVBiNkRm?=
 =?utf-8?B?MmNBRUMxb0xZb0FEWDUrM2NhZ3FIbmJOdjZZSWhTQWFOTnpna0tnM3h2MVZF?=
 =?utf-8?B?a1htUEVwR2NWVEdPTDZFbGVCK2ZhNjYrWHFzd3pkRUhNKzZ5cURoY3g1RFdh?=
 =?utf-8?B?S2t5L21TeEN0Z1JyNjNRTFNBWkZEZ3Zjc1Z3T0piYjY1QjFyNGpEaTNLMGo4?=
 =?utf-8?B?cllaNzU5Z0tiL20rNWJiU0tERElzTTlwSW1rQ1dwQVBGMEVydWMwVkwrK2kr?=
 =?utf-8?B?b1hnQTZsOVI0UDdWSTc2ZGU1RW9GRnBuWWVyVFpRRjRrdWVrWGZQMFFQT0Nn?=
 =?utf-8?B?cno3eWVkb2lTeDlTTXNSbUFhTER0SHVhOEdveFVTNTVvR3hQZ3hta080aE5S?=
 =?utf-8?B?RUtuNUZWWTg0Rnplc3BhSGgweWM3aXprcXI2NnFWbE52Q1k0M3RzRGNqUjhI?=
 =?utf-8?B?SGR1NFRNWE80MmNLRlVTZ0ZsN1JhSmRBSG9zSS84Z1BwdWl5bGRYaFBSWUFX?=
 =?utf-8?B?N0lUWStwaVRBTHdtOGVLS3liSFFGeEVBVVgzRHR1TlpWVzhrbkh6VUlFaVZ4?=
 =?utf-8?B?RVFscHAzbmozUEsxRDV3RUtzaU9LZm1ZSXRkeG1iMTRrZzExcTFvcjgzbVZY?=
 =?utf-8?Q?qey2G2byEMNZWCirWS/w4LHpg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d28e120-0bf6-4061-fac8-08dbb47477c9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 16:14:12.3216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2ihBCDev3xthRpk16tVueo39gqQ4VDseZU6gXiSA3ElxiZNU2OX+M+u34wz/ASoaGA+FfpzbklyG3HlLmWeOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5024
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
Cc: alex.sierra@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-13 11:16, Philip Yang wrote:
> If new range is added to update list, splited to multiple pranges with
> max_svm_range_pages alignment, and svm validate and map returns error
> for the first prange, then the caller retry should add pranges with
> prange->is_error_flag or prange without prange->mapped_to_gpu to the
> update list, to update GPU mapping for the entire range.

It looks like the only new thing here is to remove the "same attribute" 
optimization for ranges that are not mapped on the GPU. I don't fully 
understand the scenario you're describing here, but it feels like this 
change has a bigger impact than it needs to have. Your description 
specifically talks about ranges split at max_svm_range_pages boundaries. 
But your patch affects all ranges not mapped on the GPU, even it 
prange->is_error_flag is not set.

Maybe that's OK, because the expensive thing is updating existing 
mappings unnecessarily. If there is no existing mapping yet, it's 
probably not a big deal. I just don't understand the scenario that 
requires a retry  without the prange->is_error_flag being set. Maybe a 
better fix would be to ensure that prange->is_error_flag gets set in 
your scenario.

Regards,
   Felix


>
> Fixes: c22b04407097 ("drm/amdkfd: flag added to handle errors from svm validate and map")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Tested-by: James Zhu <james.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 61dd66bddc3c..8871329e9cbd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -825,7 +825,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
>   		}
>   	}
>   
> -	return !prange->is_error_flag;
> +	return true;
>   }
>   
>   /**
> @@ -2228,7 +2228,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   		next = interval_tree_iter_next(node, start, last);
>   		next_start = min(node->last, last) + 1;
>   
> -		if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
> +		if (!prange->is_error_flag && prange->mapped_to_gpu &&
> +		    svm_range_is_same_attrs(p, prange, nattr, attrs)) {
>   			/* nothing to do */
>   		} else if (node->start < start || node->last > last) {
>   			/* node intersects the update range and its attributes
