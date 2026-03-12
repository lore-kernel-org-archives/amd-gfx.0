Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88640105A591
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 12:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0560E10E42E;
	Thu, 12 Mar 2026 12:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0dKo8pOh";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CEDF10E42E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 12:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kas2Snq8fqjBJoUNP3hmr86IDXNu3367Q+95g/kjC54IBjWAdndqWjzRFP40hD7R1BRCsD050w3Qwt+YDg/4LY/0R+cVvfpPYZUpiohCwCl8vzKPn7BWDUop/TbVH1wYL1L0J3jfo1ivOZtM8LO+IEDrdReFA604PK6hlgzrpk0UhiYpUw4KVbcj1ECMoGYM/gZq1KHId0SeiShY70jv/YD4BranDPJ705kDYPju/AosS2/X3hExzy4SFk7ixheg79IJY4FK/9SID6o3haoN6jawIDp5+g1gLPU+uCkR9oJbVQijx0wWi0/Y+y7V0hUFkHimdiSlg5U9rNn8IHabIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AV7F/wqOaDo6triZgMvDljPqi+A23iOzqcPI3XEials=;
 b=DnXXWwRH0e6atMSZdL0jwXh+uu5z20+MHqtUStotIK3uZHB4njTfF4h2xmBetgEKlR5A6wXp90UVInhaU3CNVVxWTuVwaXuR5igZtzc3dkshy0JVOTFGc08kZf+0vWh72NigSX1XOn0hRSRLKNJABxBpnnDWK97F0E1jABxy6HCB1C/nwWz9wAdqh+ocsi2MjuWKYFb6LEgva8Vjc2VONEas2DGfB1tIIXAbHVCdCoBpCo4IbFe+QHwCJvkQKLC7QtDsK7+HII6r20dl7N3mpmD9vPA0YQvYE1Cyegj96upBNz99DS9i4G7cy4BblEUa0XaNg8h27W/xBIF4evjCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV7F/wqOaDo6triZgMvDljPqi+A23iOzqcPI3XEials=;
 b=0dKo8pOh3LPjuB8QcnVOhD0XknjqkMVi0/KS2/0pj9GYpXrkYeXRIxXwwHpDwpuYd+/LpuxJwhOzPKndB7pRkcQsTBtauUkAGszl4PCqwFzRIb30GER9fny229+AwQHJJwiNw/bL0RqnF1nQxWAnoBF4wEtXKsgAInmqBGB2Edw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB9549.namprd12.prod.outlook.com (2603:10b6:8:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 12:49:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 12:49:32 +0000
Message-ID: <72d9f9df-e762-4d9e-a351-91fa2c457600@amd.com>
Date: Thu, 12 Mar 2026 13:49:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drm/amdgpu: restructure VM state machine
To: "Khatri, Sunil" <sukhatri@amd.com>, tursulin@ursulin.net,
 Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-2-christian.koenig@amd.com>
 <20cd6ab0-97de-41c3-8bb0-56f6ec47ae19@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20cd6ab0-97de-41c3-8bb0-56f6ec47ae19@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fddec3-4d74-4d2d-d29c-08de8035ce86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: yipyjfRXr+4bGj3A13Wy3ck52a7ikdosP5snXUajO1ZzhJitBV/hGibPYLSgkKiBwiM7Dp0aRYX/RPyaX2pFtTCX18iop2BdI3hRHLjx36+ER4L4cwapM3AWb0fEY7jBp9+GjPYwY2qKdX2teLycgEECuckzyvRA0bPyHQEkBshLf0yfcoPFT/dXCEMeERLzy1i582N6FPXgbiQmWD4M8wfAFm0+nOt8n2sQkVeLhJNoR6zkkN7nvt6rnadpboTeov1ekxE1cfDbHsDuPB2Cz32Bhztba5zXcUo54lmtVHYm0SaQTUyIDStC+LBi9rzXTUkM5IeZlVr6EOUTu6glVbtuBryCMH3lRYFZRka1IvvOx07paYEro/0BB7D7nTYYhHLbEQYNCTwTP4Olc8vuwP0K3iDC81FSLasIaBUT9Es3TGTmm9HaCyuL03JXL3ED0h7+MyE8CruYqSmPkeokaIReSJCbFjxmrVkBF1eDFmO59n1JU8RSoUTrB2MGlukFTfKWRYIIUQyZRsI3NWXACko68zPaOQWrVMyfKsh4ORGoZO/xttp1ot6LFfc2/kcrf6K3zlnB684PEMVcjMJYzFW3nGaD0qtq7aT0p/VSbJH73H+GPOkfxuPRPrd9MmifxTSYYJNZfgyR1zhCAlXWGx1wOa93ZTZeTcnnUj482Fr0HaD0aq92besbwvR3HmvwM+KTB4W7COa/braIjMeclJrGENAKjFG4Mt3zZsI6wOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGdZaUFTM0dMaXRWV1hlTmY1NFVWNW9rdFllcXdpWm9nSVk0M3ZHNlJHNVRB?=
 =?utf-8?B?b0dJTElEUmRFdlZUc2tEdzU1V0V2V0pDY3lCekp1d0xmZStuZWhOemtxb2dl?=
 =?utf-8?B?RUV6dmZBUTN4TDZlL1hGTkxyZWJ2TVpHbE5WK2JSc25TWUhVRDN6MVFPUisw?=
 =?utf-8?B?ZVRKN2lPQzhGMEkxUHRzSmV1MnBaeVlyWjI5Z1FEenZ6Mm83TlJzQkFYVnJ3?=
 =?utf-8?B?Q2ZBQkZNNHlodktGS2FEY1V2V0Z0dzBKbWtvZzBnOW92RisxOVpOeTdXeHgx?=
 =?utf-8?B?WkxWaXJyNkpPZkRKclQvSWE5T2dtOE1MbU5OV0EzS0dkVHgrNUp1VjlKd1RY?=
 =?utf-8?B?WXZlQ245N2Z4ampkOG1Tc0hWVW9CeW45WFF5dS8ybEd2NWFiL0doMGNPTUYz?=
 =?utf-8?B?WU01V1JWOGJsNHMzYlE1YjF0bUkrVnI2TE5BZWt4Q052aDhuZ05xTkN1ZW5P?=
 =?utf-8?B?TGVhQUczMjhDZGdLcUpaZnIyQ2N6d3NCRUJqRWZQL1pldjdlRE5UZDh2eEg2?=
 =?utf-8?B?TWFLMDYyL1FvQkJYS1dGUlBwRHhxMkNKbWcydVg0cGRrcU82QVB6R1F6U3pY?=
 =?utf-8?B?ZjRVQXhvNHh1c1R5MEpzQXNtNjRKT3ppdDZUcDJHN0YxcFZjUWVtMnJ2NFZM?=
 =?utf-8?B?clRHVndiQkorQ25Yb0IvQ1lXYkZFQVJhL0lGQWlWT3drT1A0SGhVT0M2YVA5?=
 =?utf-8?B?RzlpSGdSNGpCeEdsR3pwSW1wY0xKR21JUTU4NUtVYVNuaW00S0I0N1JtM3Yx?=
 =?utf-8?B?SGZhWWdUTW1OSEtwdStEZjB5cUdwbkM0eENBa2xYOVhSeXJCSkc5Y1lIc3NQ?=
 =?utf-8?B?R3hmd3Y5cnE1TkxGbWo5UlMyUG5nSHlVNDZ5dDU2QVVKYnNGdEVSb3FmOXlj?=
 =?utf-8?B?bnliemxORGdFWFZ2RTljZ1NMWVduaGp5VVR4cUxLRWI0RkhKYlFxeC9aVXR6?=
 =?utf-8?B?Vlc4aVhZbzB0cU5DaFN5K2NlTGgxQ1hBKytqRnhENTliK0JWaVFCN3huT3l6?=
 =?utf-8?B?MEhGV0JHQndESHEwV0Y4UmhsZnFYUUxZcUxqb09kZ3plemoxK3J0T1B2enhr?=
 =?utf-8?B?UUFPYU9FMVpxVzBFNEZVNEdzMnJmRXdPQW43OFZINzQyaGNlWDBnejZCS3ZU?=
 =?utf-8?B?VEs4T3dNcHB1S3B3b1dFVk93N3VIZlpKUm1ncVZ6cExjR3lOOWtYd2lvaUhs?=
 =?utf-8?B?aUVuVjBnYkVxbjIxVksxeERPT0ovMFFLbGQ4c2lGN2JiT0FlVW9LaUw2MVVi?=
 =?utf-8?B?NCtja1dRQURuOGJSQWVsZm5JT3Y4Q2V4K21QUzNOMGo5Z0pBRmVzQzNLSytK?=
 =?utf-8?B?bElVdHNrY29meGl6Qkg3K2JwZ2x0RW1TZnV5d2VFdTZkbTloMTNQdDVPY0hF?=
 =?utf-8?B?S2Jja1JvUWR0ZC91RFVKZ3hsZWVNeGdHb1Zac0NmeTVPWjJlc3VIWmVkUnl6?=
 =?utf-8?B?Mld6b0JxU0p2N0ZlWUwzVG5XeFlRdWNwSGl6NWkrNzNXSFQwUTdRdzlMSXNs?=
 =?utf-8?B?ckk1ekpsWi9VVTRnOGxrRVNYdk1memJVZU1xM2tlWVBPOUxoVGVxS1NFVlJC?=
 =?utf-8?B?bGlIUVdFWGZiL1I3VVo3d1QvK3dvVXZjRHMzblM1MDdoc2ZTanJyNDlXbDc5?=
 =?utf-8?B?d0hKd0ZEWndhOTdka2lIdEZiRjZTVXBpZjhaT2I5RFY2eGdJcEgvcVhKK2xs?=
 =?utf-8?B?dUJBRWRaZG9TdHdXZmp4MklTZ3ZYaU80QUFrcVB3Tmp2ak9TdTBHd3RhaTFt?=
 =?utf-8?B?TlZoRGpQYXNKTkJ1Z2IzQ1ZrSFZFTVUyMlRoL21SYkNISjNOS2JVbkVJVjVs?=
 =?utf-8?B?QmVFWGpTZGtHSnRlSWpMWk1xUytZT1BLMDZpS283QkRVS2lrNmVDM3FMN3J0?=
 =?utf-8?B?eFRwM3VkOWg4VjZybmlXQzR6cmdiaDVUOFVTM3BlazNGS2w1NFU0eFhqUVUr?=
 =?utf-8?B?T09uR05remZmRWZOcTJFZXpxdW9xMytTNXUreEIxdFk2cTc3Y21ZK3FrbGdB?=
 =?utf-8?B?ZWJNNXJVWDVSekN6YUtOc1VpNStFY3FpdzRaY3liMVoxRzlhUGhCS1BvV1Zh?=
 =?utf-8?B?dmExUFJpZGhDdENVM1FNaC94YWxnbmNPZ29QYVZZWWIvZFZ2VWg4YmpTVXRv?=
 =?utf-8?B?TWxxWkRiTTcweVZNYXFoeFpORlpqY29UbUtwMjRXeGpDWU1nL3QrZmlnY2Rk?=
 =?utf-8?B?SWI0QytwUlQybThySUV4NHBHNE5Ca1lmMnVMd3ZFSld3ZUY3NGdEWHFTYXVM?=
 =?utf-8?B?blpwbHJUbUVxQXBHYkl6b0hRVG1KOEJ5cUhsRSs2bit4dGorRko2ZEJSdDhU?=
 =?utf-8?Q?VwTKXTq+4yV2wk7yx7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fddec3-4d74-4d2d-d29c-08de8035ce86
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 12:49:32.2947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GI1Hy9D4A/68DCDNeb3keba6a0qpM7FSYzOGJ+EognC4FFGibJNFO6jHijG4EYc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9549
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

On 3/11/26 09:47, Khatri, Sunil wrote:
> 
> On 11-03-2026 12:43 am, Christian König wrote:
>> Instead of comming up with more sophisticated names for states a VM BO
>> can be in group them by the type of BO first and then by the state.
>>
>> So we end with BO type kernel, shared_resv and individual_resv and then
>> states evicted, moved and idle.
>>
>> Not much functional change, except that evicted_user is moved back
>> together with the other BOs again which makes the handling in
>> amdgpu_vm_validate() a bit more complex. Also fixes a problem with user
>> queues and amdgpu_vm_ready().
> Some typos in commit message.

Can you point them out? I only the the extra "m" in the first sentence of hand.


>> @@ -349,46 +366,22 @@ struct amdgpu_vm {
>>  	spinlock_t		stats_lock;
>>  	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>>  
>> -	/*
>> -	 * The following lists contain amdgpu_vm_bo_base objects for either
>> -	 * PDs, PTs or per VM BOs. The state transits are:
>> -	 *
>> -	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
>> -	 *
>> -	 * Lists are protected by the root PD dma_resv lock.
>> -	 */
>> -
>> -	/* Per-VM and PT BOs who needs a validation */
>> -	struct list_head	evicted;
>> -
>> -	/* PT BOs which relocated and their parent need an update */
>> -	struct list_head	relocated;
>> +	/* kernel PD/Pts, resv is shared with the root PD */
>> +	struct amdgpu_vm_bo_status	kernel;
>>  
>> -	/* per VM BOs moved, but not yet updated in the PT */
>> -	struct list_head	moved;
>> -
>> -	/* All BOs of this VM not currently in the state machine */
>> -	struct list_head	idle;
>> +	/* userspace BOs where the resv object is shared with the root PD */
>> +	struct amdgpu_vm_bo_status	shared_resv;
>>  
>>  	/*
>>  	 * The following lists contain amdgpu_vm_bo_base objects for BOs which
>> -	 * have their own dma_resv object and not depend on the root PD. Their
>> -	 * state transits are:
>> -	 *
>> -	 * evicted_user or invalidated -> done
>> +	 * have their own dma_resv object and not depend on the root PD.
> 
> We might want to move the explanation before the individual_resv list for clarity. Grouping idea seems great and seems to simply the things to good extent. But just for better explanation and more clarity for others and documentation purposes if we want can add more details:
> 
> kernel:       BO's belonging to PD/PT and other BOs which are internal to the kernel.
> 
> shared_resv      BO's belonging to per process but still allocated by the driver/kernel for each process, for name can we says per_process
> 
> individual_resv : BO's whose memory is allocated by user for completely user managed buffers per process (User ptrs), alternate name : user_private or something.

Mhm, that description is actually not correct. Those are not necessarily userptrs but can also be normal BOs shared with other processes or devices.

I will try to come up with some better comments.

> 
> Apart from the nitpicks, the change looks great and simplify things.
> 
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Thanks,
Christian.

> 
> Regards Sunil Khatri
> 
>>  	 *
>>  	 * Lists are protected by the invalidated_lock.
>>  	 */
>>  	spinlock_t		invalidated_lock;
>>  
>> -	/* BOs for user mode queues that need a validation */
>> -	struct list_head	evicted_user;
>> -
>> -	/* regular invalidated BOs, but not yet updated in the PT */
>> -	struct list_head	invalidated;
>> -
>> -	/* BOs which are invalidated, has been updated in the PTs */
>> -	struct list_head        done;
>> +	/* Userspace BOs with individual resv object */
>> +	struct amdgpu_vm_bo_status	individual_resv;
>>  
>>  	/*
>>  	 * This list contains amdgpu_bo_va_mapping objects which have been freed

