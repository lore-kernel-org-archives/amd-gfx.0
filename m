Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F43C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Dec 2022 07:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3914B10E2C9;
	Tue, 13 Dec 2022 07:00:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD7310E2C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Dec 2022 07:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP59wxnnawLUeZHCEqLW8g6LNjKwsJLQoP5h3awMC2pfN13cHdo7gknOgfzGrJHJBeQ102f1dvZZnPaHx3rJZFltbzOiDcZulTww1m56RxmEv8scXuxmKvfa+z6F+HkwsDiRW60fl/k9PIzpK6gGJ6QHN1qjANuR3b4XQglfP/MFgXl6xcNhKtRlunBJ+PWEDMETdLLkcgKj4fM9RxUZ4xRqAipGji/TK+3c0N+dJtGzpl3H58O7m9zIG8/45ZSDRyfNae9n62HTATO95ypboksz7Nz7nVd/q34cBD+XSRJTq7VCe4heH5eVBWCpVYN7r+r02RStxlkD1NHPHu2dTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u68MxYn+/M+S6M0Rkeg7e8YLS0x3Aa/gNQhlCCL8svc=;
 b=aaFRe5w0THQO8fRIvEd34EJLo4mlZ9m35fyoxNA8zneD8VAiRqn7RuCHM0kkts+7Ztu1t+ENtmzI0U8IkbJjGNA6maBtNOsxENPpctcEq0VzjLRnfhnnuKYzo2pb8CCiFLr1Ds371diWvOiwvEJAk//DzWHvPt7BBeEWsBQbO7d0ikseoB6vYUIFDtymwlaKJIRyIW5VBlPYC/rJxIfJPw4NhKhYQZz98E1GEykc/24VWs1EO/T2hYKywLyDa0vRRw2a9kIUGaZWUPzWhPTjnjUsuVi5tH4mkdZJh8BtQnHeZpGW2iNj/Y5OU1jIRDFm45E1q7Tp8Z6OaOYlHoWHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u68MxYn+/M+S6M0Rkeg7e8YLS0x3Aa/gNQhlCCL8svc=;
 b=kUO0+EyNObqZc65SP+gq5oxjc3dL27NjaNNKXEGUnV7eIa6WUlzVB8v0RXguMVC6uVJmDP05yty2sbYtLwxs29cPMTqTsBgLUwrRn60AeiD6Sd3qqMzD+LMzaQMFR7GpB9fL6zk0JVR1B03orF8QB/P7c66n4X1mKUEWsY+KVn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 07:00:35 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 07:00:35 +0000
Message-ID: <9e14bcd5-a911-c430-a474-4f43daf44283@amd.com>
Date: Tue, 13 Dec 2022 08:00:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] drm/amdgpu: Fix size validation for non-exclusive
 domains
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221210092419.16548-1-luben.tuikov@amd.com>
 <20221212174834.36544-1-luben.tuikov@amd.com>
 <802b6283-d015-eb67-18fd-cba6fb03c96a@amd.com>
 <fe09407d-9057-879b-be61-3bfbe74846db@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <fe09407d-9057-879b-be61-3bfbe74846db@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1d2917-903e-4ee5-07f5-08dadcd7bba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eoi2q9HQBb95EEs1d9obnZb/bwPL/A+3v7P12poPyU+PK5QVMRz7xNlqDEbWCho6Hu6CAwkQvRPgR3Xx1WxY9kOY9mrA50JAHffiNWUCfRb7jQjyGkvblRrpCQYd0cQkjXSVyZB1X3YnmfCR/b5AwrBtQzfy+iQcxdFsbqo/MPLPxs0qBQpnpNZpkWBGoQOyPaJ2HUCPDGhHYjPPhMI6fFAyQNGAT9h+1a10YlvC0Y96HrdelJ0hr03E7Fw4QfBlvy5Y4lqyAH6fj/IhE6brg1aSjA9UYQZcQu0pGJLzXA4pcjowzDC6OER8TtXjYnIK9GNWTVLvQ0oYgQi3ttlIhnxiCCH1kdhh2OBGBmVdRdgAfr/iu5dM94f+5pKOQXfNr94KtYLLu9IDSby9P7pZENY3RB/ErOGAfehPtf0AG4zXhk8WaTdcR9KEY0Z2pmJNRWUg3ZEJzikUNivcyCbutchngjVjyMJGSGrQDY3yZRe4zDjjrz+1y77ts3xEjN+h21rdT6z5jBUg17RGj+Aye+i43lqL1MLBbFwDomLDZFuj2FdBHxo482qymuKv6hYKfL20guukqP1VYaqNUVUEU4KYhEMs3at/abqmk0UqdJUb3LgtrjvWwmtxOUJYzwPG4lwvGVqAmpwVfJ4k+Gppn3o2/QlSYRZRHlHUYZ3sFOXfq/Cc9sDv9qRa6wabWGlnEtXjn+Rbi3dWm8AX8iboBGvQUl1spMfwjjt7TbzwV1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199015)(478600001)(6486002)(31686004)(6666004)(186003)(26005)(6506007)(53546011)(6512007)(66556008)(316002)(5660300002)(2906002)(4001150100001)(83380400001)(36756003)(66946007)(4326008)(110136005)(2616005)(66574015)(8676002)(66476007)(8936002)(86362001)(31696002)(41300700001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkxSb3hwRzMyNFI2RWh4OTZXeEw3V2o3MFgzdjVCZjJEOWduNG9XM1RZbUxJ?=
 =?utf-8?B?cWZ1RXVXS05XOHVjcm9HeHdQWG9Pd3JQK21Va0FKbmt3UmxoSTgvUFN4Q2hs?=
 =?utf-8?B?a3d0K0FvTVlPTUVxTTZqeEJFei9oeFIxQjlla0xKeGtaenFFUS80bFFOc2JJ?=
 =?utf-8?B?V1FrTnczcFE3MHpFOVZ5djFjNkNJRnJMNEh0Z04xOGdCTlJOYTZqdzlpT09w?=
 =?utf-8?B?cXlCOE8waGFQOWwzMGhCU2kzZzdYeEpFeXBsVHRuUTd2cEo4cUJpUy92WU9M?=
 =?utf-8?B?WFhrTEtURm9IMmR6RjE0cTRuNnZrYTBXeTRwVW1NenVWWlYxbnpuSTNBbjBp?=
 =?utf-8?B?TmdBOFJIaDJ0aU80LzZqZHVqbzg4bnl0VnladXNkNVdBUEh5NjZ0MTFqT2kz?=
 =?utf-8?B?SVhNZDdaOXBqbmRFY2hxRHlySDVNb1p2MFc5VytWTFhKZlV0aU1MamFjMGRv?=
 =?utf-8?B?SXhkM0hjZHZGMVBQWWo3WmhqdlIwOWRjbEtjV3dWMk1FZWQvZnBHL24vVlJB?=
 =?utf-8?B?NHBDaW8ydmh1cjYvL25wbjZwem1KY0NWV2xBcUhyTTF4a1R3NHdES3lOdzM0?=
 =?utf-8?B?OU8va1h1N3pidFJWYThtWWh2SlNyVFVBYjlxN2Vkc1lzeGtUZ3R5MnhxNzNm?=
 =?utf-8?B?ejB0TWpSbHRSMlBFdWFPRllqNnF5OFJSSlA4VWY5VHN2SXZ0QW9LMGtTcXlR?=
 =?utf-8?B?aEQ1L0ZRMWsvMGhCSWRaMUQvYjZ3aW9HdlcxSlBmaXBoQi9NU2x1MGVQRHRn?=
 =?utf-8?B?ajNia21LcHBYTzV6RnZzbjBMY3hRRzVpKzJ3YWFKWjhNZVIwcUxNKy9senJC?=
 =?utf-8?B?MlNoWlQxckZKZUdicWE1VTdJY1FBanp0ckdDNGhEWVUrcHIrU0c4aFBxdG9i?=
 =?utf-8?B?ZTBKaCtJbGN5TEEyd3phc0dCRjZHNGNKeWtwUDNRNFFtaGJXVDhKaE8rRDZk?=
 =?utf-8?B?NEdkY3ZYQzhwYWRCTUJ0N00wQjJDaXZQWUxlKzZQMXdBVWFFeGdjSVFtVFdL?=
 =?utf-8?B?SE9LZWdYb3NBNEZpV3dlT3JvdHIxL2dNMjZWL05CNGRIUngrbGFXaURHMHVW?=
 =?utf-8?B?VVk1L2tFcXFXQXkwYjF4ejBvRkVDWkhFaTRmOWwzZXFBOENkZ1JIZjQvWGZD?=
 =?utf-8?B?cUJJb2xFRE1TVkhyVnd6K2ExOFFlTHBYSGh2MWRTcVlnajlQODdWMTJtY09h?=
 =?utf-8?B?VEZXdlNiWlZRbzZzS3N3QytNM21FUk0yOHFubVp2OUM5RnFyOVVCT0gzSkFr?=
 =?utf-8?B?T3JFQzVERlZRWFBVdEhwWC90aXlRV09lSmZ3dS9LOEp6ODNqc0VjOUROM25y?=
 =?utf-8?B?dVEwUnptdWNhTllmbGwvaUhGL2FmdlFCSkhGQ3NZODlHNkptS0FjcVpuTFRR?=
 =?utf-8?B?MjQ3VzJZbFVaMzd4LzlNQzM1VW4za2w3WWN0TlFJNnBveThLME5jOW52d1JL?=
 =?utf-8?B?R1lJS1FRT0h5Yll1UC9WbUFpNWZIa090TmN4M3FFRVl4NE1TTlVVM3g1RDMz?=
 =?utf-8?B?dzRUSkRCUVVkSmRzeXk0eEh0MFZCUVA5Rm9yS3REN3B0M1YzN2IvZVg2UjU2?=
 =?utf-8?B?cVBCYzVMYTB0SFFHcXRBRWhyVHdtclpTNnRDeVMwMFhuMW8zSi9rb01lbkpH?=
 =?utf-8?B?bW5paWF1QWxsZTlRSEljbElzZS8zMWJOa2puQnZSY0xCOGtMUGhVS1lMRHUw?=
 =?utf-8?B?UkdTVVRlWHczZHEzSnZXbVp0blJXenFORVFadXdJcHk5NjRSM2lGOEVmRDF3?=
 =?utf-8?B?Z0JtRGZueXFtRkNNRzE4Z3lVU2ovK0RNU0xrZ2hGUlM2NnFqUXNMNVp2Z2lW?=
 =?utf-8?B?MngxQTJuekV6bE5oeEFyU3drVmJDQUlaZUNCYklYSHdOY1dCbVQzanJJWWZ2?=
 =?utf-8?B?VWJFUXNaejk1TG1UYkNLak5TNDBwRitCVXY2M2JPRDN0UmVabFgvcUhtSHdv?=
 =?utf-8?B?SEhYTjllbjJ6ODU0S09PaHNXMkdWaXVJNUw1VVdVUmxmTTVRdE5ESThYTDFX?=
 =?utf-8?B?VWphTUJUdWNRWGcyWlFHV0gzRUhCV3ZBd2dJdGhjUmx6NytaeUZUN2ZvY0hY?=
 =?utf-8?B?cUdoTytpNGxiTVh2R0M1djRPMEsveWVMM0NTZzUvSVNYcFg5dzd2SERNTmJB?=
 =?utf-8?Q?NSHAmUqqKp/TbwaRhZWZ7gfXr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1d2917-903e-4ee5-07f5-08dadcd7bba0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 07:00:35.2284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxfbG0PESpMDtjGR++4UihNUhOUo7UEx7CEqv95fM1ZqnXe92bDxodcWkFHjQ6C0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.12.22 um 00:44 schrieb Luben Tuikov:
> On 2022-12-12 14:19, Christian König wrote:
>> Am 12.12.22 um 18:48 schrieb Luben Tuikov:
>>> Fix amdgpu_bo_validate_size() to check whether the TTM domain manager for the
>>> requested memory exists, and to allow for non-exclusive domain allocations, as
>>> there would be if the domain is a mask, e.g. AMDGPU_GEM_DOMAIN_VRAM |
>>> AMDGPU_GEM_DOMAIN_GTT.
>>>
>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 +++++++------------
>>>    1 file changed, 7 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index fd3ab4b5e5bb1f..e0f103f0ec2178 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -448,31 +448,26 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>>    
>>>    	/*
>>>    	 * If GTT is part of requested domains the check must succeed to
>>> -	 * allow fall back to GTT
>>> +	 * allow fall back to GTT.
>>> +	 *
>>> +	 * Note that allocations can request from either domain. For
>>> +	 * this reason, check either in non-exclusive way, and if
>>> +	 * neither satisfies, fail the validation.
>> That's not correct, the original logic was completely intentional.
>>
>> If both VRAM and GTT are specified it's valid if the size fits only into
>> GTT.
> Given that this patch fixes a kernel oops, should this patch then fail the validation,
> i.e. return false?

It should be sufficient if a BO fits into the GTT domain for size 
validation. If we haven't initialized the GTT domain and end up here we 
should probably just ignore it.

>
> This would then fail, in amdgpu_ttm_reserve_tmr():
>
> 	ret = amdgpu_bo_create_kernel_at(adev,
> 				adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
> 				adev->mman.discovery_tmr_size,
> 				AMDGPU_GEM_DOMAIN_VRAM |
> 				AMDGPU_GEM_DOMAIN_GTT,

As I said before using amdgpu_bo_create_kernel_at() with VRAM|GTT 
doesn't make any sense at all. We should probably drop the domain 
parameter altogether.

Regards,
Christian.

> 				&adev->mman.discovery_memory,
> 				NULL);
>
> Regards,
> Luben
>

