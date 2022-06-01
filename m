Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47451C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 17:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE7E10E05F;
	Wed,  1 Jun 2022 17:07:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF1510E05F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 17:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkVmeKGdywY4MfW5rItkAMZ23CatbT5xgk50axJo1PeSQvAU5D3sSPnYC5yNW2QSZMW5vbRBMFK3D/TOc03/2LF4D0IVVA5LRunUG7pewnoUXYJYll/2mKRKZII7s2Com0wlSNj3LMcnE8gvs/4jHkKQ8/S/1gNrTMugpBe4O7ruiVzQoJQSzf/AeuRqkpd8rB7J6HTlAoHIJORWcaLbu97Iem6kuvJXui5GUSc98YsVeNiWX2wQHagcrcpIBU48Gv1qhJ/BjKgcJ2OXz+2/VEYb75HFSLhOFuh6E5hcoZj0+TchTR3VA+kbYo5AMc7sjYbGngYEIkLVOzgoK8SDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDKcNbmmKTv8fOLUi9IrKZ96AMpK4sH3LEoOliFPRVg=;
 b=VDfqo0YLYoA20kD1PJ+YYCHNwZztmicyQRGx7i6FjkSBfjeTz4sKnBSULYsu+2ohb7lYyzgvfDkkCcQh+13bLWwmtSNYVn0pbJba1U0bHFLW+94zRuzH5jsmPTb3PA7r9BbFrYs2V1YUwAeGdK3/fdxd38Kvptrc/GZGu6Aqqidrrc8zeoHMDOMNd5/4wyExF5HSKaWzveJtTNASgE0B7pjwRUo1M7hjB/wa0tXoUUF/sZM6qTgMpEfzLhnVLiOOiqkdQFmZk8D23BLlYGCC3MJlltg8bQGShNth5YetK4Q2bs8LT1gvvZR4yhGoZUVT4eyJmhXpHmtASp8HF0zn3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDKcNbmmKTv8fOLUi9IrKZ96AMpK4sH3LEoOliFPRVg=;
 b=0f5wTW96F1Sm57aOFaQ1kMaQS2YBlsGQzq3Od+VLU/HpmR01P8HOac3lMPRHWiTdTWA5h2jrbWdIFgH5LdYpnATwl2yMYzYGtpndj0j8iFfvfrQYSQpSLtfgXYDXNQ8XLroYL3orgB6Q2OFQbwotW1os1sxKnzW6XexjDKlnqBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB5546.namprd12.prod.outlook.com (2603:10b6:610:63::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 17:07:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 17:07:40 +0000
Message-ID: <4d563bf0-ade6-fc3e-9de1-cc2522c4a57f@amd.com>
Date: Wed, 1 Jun 2022 13:07:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Explicit VM updates
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 "Olsak, Marek" <Marek.Olsak@amd.com>
References: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
 <022d86d0-6301-70da-f320-b17c4859443b@amd.com>
 <412a23fc-eb92-8f3c-e339-0bc3918c0f18@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <412a23fc-eb92-8f3c-e339-0bc3918c0f18@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac05ac14-8470-47e6-ced4-08da43f13c10
X-MS-TrafficTypeDiagnostic: CH2PR12MB5546:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB55469A1F2CF71D233E99093492DF9@CH2PR12MB5546.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SIxjdh2GrJFvWtBj+ahcaOOaSFCErWM1Fuk3f9DdS9pQHFOsAJpqnLn7fpOwvpeEPTsfsWSd/rQbMDMaatNaaGQPfc9wmP0vf2visdZYrKT9WU8SOdXR3+tu1oDzb1tsDVYvHLGV9a92LfS27iBLBux8+TDJnq4Hc4Mao0fXn67Z0ogxKMxDsKbfMY2UHEfCNAVeKOgPUojCQXGI2fSn3Q2G/QHDScGjxC0MY3gCD62uRZeT6SaPMguQr9rhu1FpAjZDAlf66ROX2+W6qMMG6YlUb5xEgreumaJajfn5oRSnlL/OSbRWJNupZWPTRP0n2n6Stcf92nVDh+a6FH7ByQj/9v3eCIrWAAJ/v+b7e5WArtLv1HDtqEB+4JGy1N3i3Esf2xuYgd3OzVkq0x+Sfgw+yuVm0KdjkcFOU+LPapwHIGpkpzkKUmrQ/WTA/IEISsH3dm6Xz3NuOop1U9QyrFGKHiS64uT5yrjc5j0x2Eqb/N0WB8nFEWoY0txk7/V0U7p+q+phuwPvy/RpOrCTDSK+vX/c9Ewy7oaXWl1ItlFCbcUFnxYW/3hS1wZeqrb0TqFT+EfUn4Cs0QCtDwBrX+cHxlGaRH/zEm7CjT3FZ+OWScXL/yVLzt4WOp+11ZDh5/cZCKaRRQY4hffOpWWfX0/P8y4J7e98Ylss39TrWVjRneZ9NPvPXHtz+Xg2ccidrKSLzGQKAVE99ZVldbDQPBNB3lAeUdoOlx+4I1/HTizfXqUWpol2a7K1wm527Ea
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(44832011)(15650500001)(38100700002)(508600001)(5660300002)(36756003)(316002)(31686004)(6506007)(3480700007)(8936002)(7116003)(66574015)(86362001)(31696002)(6512007)(26005)(83380400001)(110136005)(6486002)(6636002)(2906002)(66556008)(66946007)(8676002)(2616005)(66476007)(186003)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVNL3pkc1lMdm1IdVlaQzJTWWx3cm15bEk4dUtDa0FQVmQxTHFNUjJCWkRQ?=
 =?utf-8?B?QlpNVEEySEV0dFZxTGFEczBBbXIyOGE1eEZCOE9BT29YU01WcHJ1eG5qTkpH?=
 =?utf-8?B?Y1ZNODVqbEUzRkUxN3F6TnNPbW1vRmVIcHVaMlYzNkxLYkJIVUg5WDAwUDFX?=
 =?utf-8?B?V0RXbWJqYUd2N1JhRDJ1WXVZdWozYi9jUnFYUVRwUzluT3RyTjA0ZG5VNGpH?=
 =?utf-8?B?bjVRMTVlMk1JUm5vNDRtdjRuYkwrRllUbkthQTNqNUY4bW1Ja2owN0hMUTFC?=
 =?utf-8?B?OXpBc2ZHM0Z2dEpzWEcyWm5xbHM2ejl5MWN0MFk4Z3RwOE5nODZuTDhxMTNk?=
 =?utf-8?B?NWpKcW0raXYvdTl0Qi83eHZCTWtmM1ZtSWVtZXRLanlqNlBMR0svRHFCcEsv?=
 =?utf-8?B?WWp6bFVQd1BDekpsS3g3SjJkN29GeVZyTStGd3RVZzA0YjkwTkhDT3NSTzl0?=
 =?utf-8?B?ZXNRUmdhM0ovcGV4K2szUUJxSlQxbFZXaWVBMFRjWWlUK1VRZmpYb3RQQVdv?=
 =?utf-8?B?Q09WeXJwYjQxUFgvOXpyZDVrVldMYUY5dmt2RmFyOWRkR2pxOGUrcmV3STRW?=
 =?utf-8?B?a3poMnpRNkpjcUx5cVFoUW1KWXRmNmVqRFpSN2hCZXhOQlpMSlJUL0JpRkNy?=
 =?utf-8?B?R2dFOEFKeWI4ak9tbDlZNWZTY3pjVG53WW9zdnozbW84T0JodE9WTFFXUHhW?=
 =?utf-8?B?amUvSk1UbHdVV2cwL2RheGZXY2lYdTExWmFmbVBTNDZsbDRKUERGNENwNmhh?=
 =?utf-8?B?ZW1XM3lmbkdrZmFocXlHaXBiTFFGOUdmaVZhK1laWWo3QXB4aTdERkJFTXMv?=
 =?utf-8?B?dkM4MzNKdGdlQUNUVCtoUk02QkpaS0V0dnhHQ3czZXpLQmpiM2xyOGNGa0lm?=
 =?utf-8?B?a0ZsVHQ5TUxxVUJmYzhUQlVvaFdiWU9tdHE2R2hJRkt5aTZ6MXJvUk0rMmZQ?=
 =?utf-8?B?WUJJaDllRktNbUM5dGlPd1FaQXVBT1VPa2lwWXBtYUs2OG9ZNk1JUmdQaFNo?=
 =?utf-8?B?TzVoY05aNm9QU0h5RndRa2p2QjFaSmtIdjhMd0kvWFd0TDJ6U3AzT2VTWk9F?=
 =?utf-8?B?RnNzRHVMZzI2VTZnVjdCNVRKR1BiQlNjNVhxaXdkaXh5UDlZUVRIQ1RYK3dW?=
 =?utf-8?B?V2NSVjNRNTk2WHZzWDIydDBrTVgyU2hCUDN1Z0EwMXlSbFFYMkgyRC9PT1Jp?=
 =?utf-8?B?cEdTZGMrV2NYY2NsaWIzMDh0Sk5nek1uTnhNMnkwazhqcndqbCtmR0JNUkMz?=
 =?utf-8?B?S1d0S0NCZVRqSE5DZEZSc0V5UjAwQWNoWXhJRGU0SGM2aXdWaEt2OFdXcVhx?=
 =?utf-8?B?SzVuWHp0cXBRL0o5T2VvUmJsZTYzSFBsTmlWV2dxSVduNjFuNmt2L1dsMUlN?=
 =?utf-8?B?aGREZzd1bitXbzVLL3UyRXkzM2JpRHE5QjR5OTNYYS80WXgycVd2VnNVdXl0?=
 =?utf-8?B?K2J0RmMxN0gxSEY5dDQrQVd0U2FUT2c4R25TNi9rWTk3OVorUXMyNEIxYUh5?=
 =?utf-8?B?SUt2Sm1ZQUQyK3N6d2hpaU92aTNHZ0RZNjc5ZnVGRXUwMTZjSU5NMUlQbGFT?=
 =?utf-8?B?emp1NW5wWFFiMDBHYy9ZRXJvTmUvSDc3L1lPTDZzZVFEb2duOEsvdE0xKzhB?=
 =?utf-8?B?L3pMTDNtWHFPMk1YMGdPR25jZmtVWlBiazdJZ0lLU1RIVlVhWnBJdGY5K2RF?=
 =?utf-8?B?MjBNQTh6YVlkNTJUMmZzWFpMbVBFbkUvTzh2SEJEckJKcU5UUWI5V0JqcW00?=
 =?utf-8?B?dXk3UXNLR0w4QnFEM1cybUV6TUwvM1Q5dzhNUmZKbGw5cE1TampKMysxMm0z?=
 =?utf-8?B?SlNqdjZ1NUhVL3ZkR1NuNjhGNittN3NYTk00T3NvYXUrZktkV0lrY0NWY0Ry?=
 =?utf-8?B?YllUS3Zkd1o4dUMxeXBGUmFIcjB1bEEzaXBLTUhOTzRVUTFEV21tVWZKbFBw?=
 =?utf-8?B?OW1PcGYxYUhHRk9DUDk2Ryt6Z2NuL05aWHFYajVFOWxqK3JNS1AzandkSjM5?=
 =?utf-8?B?aTVmcFdqakl6UzRiS3JvY1QyeUxkcEdHK3J2Mk5FSys3Z1RwTHNRMXEwdlZs?=
 =?utf-8?B?aXB2a2xIMXZhTk8xU1ZUaG1wSE9LOTRmL0djWnZpZnZ0L2tXNFFuRGpIZm12?=
 =?utf-8?B?akROU2VRd2ZVaDd2YU5ydnQybVVJbldaT2luSlNVcC9IR2FWMkRPMEZpMUlw?=
 =?utf-8?B?Q2Z3bjVaK1NXcDdoTFlMdSs3OGlJRm5ZOCtWZ2hXNUxCNEc0eGY2Tm10SFRz?=
 =?utf-8?B?Q3pRRGtSdHRzV0pMSmFReXNKZ2xlQ1Uyckw5T3dTZ0p1enhGbXExbzRvRTA3?=
 =?utf-8?B?eDFvWHBYdCtNdmlaSXZTMjFZaStZMksrNUw2QWo2K3ZUdWNVQUFKdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac05ac14-8470-47e6-ced4-08da43f13c10
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 17:07:40.2447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itd3wCIrfTEAc2GgO4QgQVGWykETKsuWcYgejhbL+TbKja3C7RtV4AvGRnjavR/OZoqumwVmzMcQhjzsLp+rdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5546
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-06-01 um 12:29 schrieb Christian König:
> Am 01.06.22 um 17:05 schrieb Felix Kuehling:
>>
>> Am 2022-06-01 um 08:40 schrieb Christian König:
>>> Hey guys,
>>>
>>> so today Bas came up with a new requirement regarding the explicit 
>>> synchronization to VM updates and a bunch of prototype patches.
>>>
>>> I've been thinking about that stuff for quite some time before, but 
>>> to be honest it's one of the most trickiest parts of the driver.
>>>
>>> So my current thinking is that we could potentially handle those 
>>> requirements like this:
>>>
>>> 1. We add some new EXPLICIT flag to context (or CS?) and VM IOCTL. 
>>> This way we either get the new behavior for the whole CS+VM or the 
>>> old one, but never both mixed.
>>>
>>> 2. When memory is unmapped we keep around the last unmap operation 
>>> inside the bo_va.
>>>
>>> 3. When memory is freed we add all the CS fences which could access 
>>> that memory + the last unmap operation as BOOKKEEP fences to the BO 
>>> and as mandatory sync fence to the VM.
>>>
>>> Memory freed either because of an eviction or because of userspace 
>>> closing the handle will be seen as a combination of unmap+free.
>>>
>>>
>>> The result is the following semantic for userspace to avoid implicit 
>>> synchronization as much as possible:
>>>
>>> 1. When you allocate and map memory it is mandatory to either wait 
>>> for the mapping operation to complete or to add it as dependency for 
>>> your CS.
>>>     If this isn't followed the application will run into CS faults 
>>> (that's what we pretty much already implemented).
>>
>> This makes sense.
>>
>>
>>>
>>> 2. When memory is freed you must unmap that memory first and then 
>>> wait for this unmap operation to complete before freeing the memory.
>>>     If this isn't followed the kernel will add a forcefully wait to 
>>> the next CS to block until the unmap is completed.
>>
>> This would work for now, but it won't work for user mode submission 
>> in the future. I find it weird that user mode needs to wait for the 
>> unmap. For user mode, unmap and free should always be asynchronous. I 
>> can't think of any good reasons to make user mode wait for the driver 
>> to clean up its stuff.
>>
>> Could the waiting be done in kernel mode instead? TTM already does 
>> delayed freeing if there are fences outstanding on a BO being freed. 
>> This should make it easy to delay freeing until the unmap is done 
>> without blocking the user mode thread.
>
> This is not about blocking, but synchronization dependencies.

Then I must have misunderstood this sentence: "When memory is freed you 
must unmap that memory first and then wait for this unmap operation to 
complete before freeing the memory." If the pronoun "you" is the user 
mode driver, it means user mode must wait for kernel mode to finish 
unmapping memory before freeing it. Was that not what you meant?


>
> In other words the free is not waiting for the unmap to complete, but 
> causes command submissions through the kernel to depend on the unmap.

I guess I don't understand that dependency. The next command submission 
obviously cannot use the memory that was unmapped. But why does it need 
to synchronize with the unmap operation?


>
> User mode submissions are completely unrelated to that.

I mention user mode command submission because there is no way to 
enforce the synchronization you describe here on a user mode queue. So 
this approach is not very future proof.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> 3. All VM operations requested by userspace will still be executed 
>>> in order, e.g. we can't run unmap + map in parallel or something 
>>> like this.
>>>
>>> Is that something you guys can live with? As far as I can see it 
>>> should give you the maximum freedom possible, but is still doable.
>>>
>>> Regards,
>>> Christian.
>
