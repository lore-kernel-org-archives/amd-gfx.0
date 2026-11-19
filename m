Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60891606A326
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tz2OYx4F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F4E10F456;
	Thu, 19 Nov 2026 13:52:16 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D63010F456
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 13:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6qy35Ow4RbJDRfJV+yTRyRbx7hxKRyb9ah2VJQ1Jo1oxLH/t0/7i6S1PkrlddT8D+l5WcU3b7rUocQG0KkhQRblIGjIaPDmFtqjL6rJPFO4OrDKONb1f6GBBIJklqAr9kcM5c2l7wVnrtpYykRDOvNM2jVdA99FnXRYtZx0cnD0LNsbsGGULPwzvpIbxesmBRQbP3Fu//Et7MIZuGKQYNII2lZoKxxPvA+yXB3/9XTPFkU6UB2Ue3ZO5vHUaScKk/uRsH3f6wxFqYRHzG9kAf+jAQXPgBg/IlarieCgsqoyFwK4bsUEt0B/VchlrSXqXpm5Wdpw0sn7RvITwu4g+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy79SiceJdrPCBUog6xg+D64vxwO837Yk2FSF456czo=;
 b=WnF5SvCdoBU0i4z4bWKgpBu6mcEIhOXygXyjs09tdv8WErJMv1Fb8x1dq4biEOXVcqdQV13wRbWkOw49NHpP6S2ZGGKIIaA1P91AvOME1qhV09O66uGr7ZJpCp3nm7uYQYlUlP4296yJY03YaAD/6CrGX+LEesQRtCNJET+jx6Yggoscq/dXqSrv4J1RRAKFIWWdBBmvRqLmBWNwCN2u536Leg8DuQ8eFn+b78dQSAat1Gq5f9UKCHkZ2XQyl+DwvwIZzUYB3RxIYRs95t5ua9wTsOGXLCEfv6ujwrkaxxK0twuNdZNhvJfFNFtCegMkFAazDYlTptw7pqdIn0jlIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy79SiceJdrPCBUog6xg+D64vxwO837Yk2FSF456czo=;
 b=tz2OYx4F6gjq2D/FcBMSepCF5zww2dUXEXlnoA5fePtN+QfQ/M3lgF5mciCNy8quYXCuxcLx85FH0/VL8vIbiaUWVNQI/u9ld5jHxUEWl58/fg3E+fGjne2W76FFY+JRjqPFX01lubzXWjVsu1lllFSYyEZJEp0KZrkAtAw9QuE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 13:51:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 13:51:30 +0000
Message-ID: <6fd3e1d7-2aee-462b-850d-c244a2c085c6@amd.com>
Date: Thu, 19 Nov 2026 14:51:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
To: "Thothiralingam, Logatharshan" <Logatharshan.Thothiralingam@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20261116-superm1-drain-submissions-v1-1-e3ffee977a28@amd.com>
 <5e22b2e1-2379-4583-968f-78217ce5525f@amd.com>
 <SA1PR12MB715234880D4B3AEDAA1AFF72F87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <SA1PR12MB7152CB1DA95F6AC4190C93E6F87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <SA1PR12MB71526239725978636452725DF87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <1d06a6ef-7a67-409a-bbaf-9ec9c0dd32de@amd.com>
 <SA1PR12MB71528D13366F5048D82E4841F87A2@SA1PR12MB7152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB71528D13366F5048D82E4841F87A2@SA1PR12MB7152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 24389494-959d-4601-9214-08df464436b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261026121527099003|10067099003|261026140227099003|4143699003|5023799004|56012099006|11063799006|261022075727099003|261021121427099003|261022105027099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 5SY+mePBly4VCvg5WWkmeqd0GIP7L2yVCbNSDQp2PManD6/TFGqWljKHZRCui0y5mvPqF2+MU19dt3fF2xAbbKId5gQR6z1m1MhQzSrU1pcyNaDa+jOZnsidjiSPk5jyH6onA0rl4ER+EggfKS3u3pHM+6WxVhJgFL96qdUfCYkkhMwUYzM7GQgENHXXoYETBi+Ge4vcHYdoV4ouSRK8Nq8cHWqULWhV0SMT7wS0V8ykj48kufu0t318mT+o6TJ9EQsETYHghggJML6/wqfIiHZUocZD6Vvs2B4LN2t9SBSs/Xt3iZvIG90iFB5MiUNAY1P54lTfLgK+RDiprTQstmx6Vm+yuJXCOf+BYaciTAO3wyra1wNnYvm0/M4LecggMTNw5Wc+TYMRIt3LH7201yKR5Y5mK/fxbRM02EXp2FvemriF1YOFvx0uHIvzy22Dyo1l76V/VIfuCTHIdjisw/J+KMNg1VH4heaiq8R2kxuVMlSxUrCGyyRhwkQs/bPWukw4SoF3yQ93c8HkiApZX/vBUmwcnLm1h6r9t4U1pkI4S2JV99Rc/lFpulgY64k5j9Mb1CekwvsYKnEtEaedD0tn+zM3MmzjM6gIICNo5Ew=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261026121527099003)(10067099003)(261026140227099003)(4143699003)(5023799004)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261022105027099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWN6aEYwVzhySFB2a2toQlVaSmZDRDJ4OUtPZzJmbnlPMktScnlEbEF1ZFFa?=
 =?utf-8?B?OWJ0YXVVUDRVSVVnQk93b1ViWld5RTFoNXZJVVRZKzE1Vm9xK20yU2pydUFy?=
 =?utf-8?B?UUVKbHNVRlY3Y05QclRmMld3MHVYQ2llTm9URGZFUTRad2dpaVozWEcxUFdD?=
 =?utf-8?B?Rkdtd0pKR1ZncmhwU2VQcUZ6NUhhTm1XdjBhYWJvOVpYSWM1ai9pL2lrNEVN?=
 =?utf-8?B?d09odDRWK1M4WGJJZUxIUXkzOTN2SEhOemhhTmJzZHJrTEUxY3p4cWpnSlNP?=
 =?utf-8?B?dDNRZk9iTkJhaS9yejhUcHExY040bXQvNXkwOWZEZTdkYkZMemJ0MURCaVJF?=
 =?utf-8?B?UlRKUzBVVmRZejhHck8wc2ZrN09tSVI4Tzc4NW9odFBMMGZHNGxBRHZvTE55?=
 =?utf-8?B?OG01Y2RxTWQvazAyNjNidGxncGdCWGdUREZJdjVNRDMyNzNEZ2VXSlUydElE?=
 =?utf-8?B?TDdqeFpseWZBbmxOK3BGaWFMcmc5NjM3L0c1K05qV0JBRHZTTXV5bTQyUy9j?=
 =?utf-8?B?Zm9PakZLWEhPelp1UjdDMHl3bXZLaXNPOWJXSVhEbDJxVGhjYk9nMEZkUXVH?=
 =?utf-8?B?K1JqU3A3N0xmTUxBek81eGx3bld2eGk2Y281dlRGb0ZjZkdhQjR5MmVrTzds?=
 =?utf-8?B?Y2xWdEF5WmFCQmZiQkNYNXE5WWRFYXgyV044Tzg5cUZWK2RvNGIvNXlMQ1Nr?=
 =?utf-8?B?NGZiN0xUVWRWNDVwemhERU11S00vRDNkeWdnVi9JZ2ZjUkw1ZzNnNTR3d3BR?=
 =?utf-8?B?c2Y3RGNmTFU4SEtrUlhXN2phaG9ub1cyTHBDVmExNHpjc2RITXlwcTlrcEtK?=
 =?utf-8?B?ZkduRStUVyt3QmRFY0VPSGFpZGthRzdWZnluWkZmd0NWWW5QanVrNEphd21T?=
 =?utf-8?B?alBUUnJHNitVaytJZFlJTjc1RkFvcytVVXVlZTdpaU0zTm1BMmZoNXVXZ01h?=
 =?utf-8?B?M0NkVml6MmRtdFI0UGNLKzVYL2R2TGoreW5RaCtRQTRLeE1MMUdLbGtkeC9E?=
 =?utf-8?B?UG1pdk8vMk0yRHdwT1VoM0trcGJNTDU4NE05R2lRZU1BcXQralA5aE5Gbm5E?=
 =?utf-8?B?ZlNsU2xVRU1YWlNCSVpoWEhFYURBSlZFTW0yM3M1NEJrSlFCN3FwbU5rNTZq?=
 =?utf-8?B?UmJxUmd2d0NIbTY3VElveDhuWDdRbGMwVHMzMEZ4NnlMaU9FRXhZcFRuNWZZ?=
 =?utf-8?B?SVM4R0RpMW5oY0s1cEs4UXVZK04zVHZqQmJ1a3lzSWo0cmc1anJ5dHlOSEN6?=
 =?utf-8?B?alUvc1BKd3RkNVNlMm84dkVldmovazh4YVZNclRmT2puY0tQSVJzQVJBSUhq?=
 =?utf-8?B?SlhtalZPRWVqSVJCU1lsR0tYRFdWRlZ0VzBONENFejNoL0xCREhHZW5TL0Fa?=
 =?utf-8?B?dVNUM2JSbWVjS2pnTHl6dmo2bTlpYTF1bUprcjBGb3g3bjVlbGZHRTM2bTk3?=
 =?utf-8?B?enljbEFOMWZLTjRZQy9VTmFtMUE4ZUQ3OEo2UDVWK1lraTEzSTBHUXJXYW9E?=
 =?utf-8?B?TWEyVlJBRzh5ajJCQmM4bEp5N0FlaHhHLzhTSTdYU0dsVFk3WDR4elhMZXZ4?=
 =?utf-8?B?QUlDcnJqbThwY3JNRGt5VDJUcXBPZ2dqckgwbSswZ3MyWS80S2JSTTZOSWg5?=
 =?utf-8?B?aUdMRitkUCt0em0wei9TSHR2Ry9xVXVvcWVtbmdVQVdXK2Njb3FFK2EyWjRW?=
 =?utf-8?B?UWNGdGtVQ2lsSDFtWGlEdnVYV05yeVBBSXcwdEwzczJMai8xWGxYTTFwVUl5?=
 =?utf-8?B?YlRibkhTb2VQU29QUlBYVVovdFppRElWTHVTQ3hVS0ZiTDZKMzFVUDV1MlBl?=
 =?utf-8?B?YWhBeUh5TWd1eTk3L2dydGN2MDJKYXJiUWF1NElXc1lYTE5KQ25xLytqZGZZ?=
 =?utf-8?B?bzNGR093eGFJS1k2bFk2eGZoNGhXMW5Zc0paK2J5ODJ3SEpqNWdwYVZaSGdP?=
 =?utf-8?B?WElQOXM5amRWaXVENnR3KzJ0S1VlbURPd2szK1pZSXd3ZjBISTZsWStkbHJv?=
 =?utf-8?B?ZXpKRWM5VTlhSlpQVnFySUdOU2tGTDMzZHoyTGFXYUc0dHpzbjBOWFhsTkRX?=
 =?utf-8?B?RGhRell0QzBxUngwOGVvR2VNZFZ5NkEzbEY2ZXBGdkdsZGhvbmRoS1RBY2Vx?=
 =?utf-8?B?OTF4Q0pGcVFBQmIwd2lDTWlIOUsvS0xaQ09DVUlVK1h3Rk9TdjhPR2NTNTd1?=
 =?utf-8?B?SUhXSU9DQ1FYemhtM21GbGRZVlZYdkZKNWc0bHBiVlpxQ1Q0cC9aSWY4YURz?=
 =?utf-8?B?cWgxTWRHNzhSRm56TU9Td2dDc2djTW9GQWwvenovazFXcEZqSHM2NG1ZdGRj?=
 =?utf-8?Q?p/BSXpnszfvwffAPgG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24389494-959d-4601-9214-08df464436b5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:51:30.0735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHUBt9coDnj7e5j1nZXkWvWdmcRANOgMPBJAAGvK6iWdfACIwO3rWu7LGQM0kGsK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tharshan,

feel free to add Reviewed-by: Christian König <christian.koenig@amd.com> and push to amd-staging-drm-next unless Mario comes up with some last minute comments.

We should probably rename the amdgpu_vm_wait_idle() function to something like amdgpu_vm_flush_entities() because the name is really confusing.

Regards,
Christian.

On 11/18/26 20:01, Thothiralingam, Logatharshan wrote:
> AMD General
> 
> Hi Christian,
> 
> You are right, amdgpu_vm_wait_idle() is not needed. I was thinking of that before, but I added it in the previous patch per your request. But now, I have removed it.
> 
> Please see the attached patch. I have tested it, and the hang is not seen. Please let me know if the patch is good to go so that I can share the solution with our customer.
> 
> Then, I can create another patch against upstream and work on getting it pushed.
> 
> Thanks,
> Tharshan
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, November 18, 2026 5:15 AM
> To: Thothiralingam, Logatharshan <Logatharshan.Thothiralingam@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
> 
> Hi Tharshan,
> 
> oh that is a really good point, using amdgpu_vm_wait_idle() here is not correct either because of the same problems as with the context flush.
> 
>> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ,
>> false,MAX_SCHEDULE_TIMEOUT);
> 
> That looks like the right thing to do, yes.
> 
> It only might be necessary to replace DMA_RESV_USAGE_READ with DMA_RESV_USAGE_BOOKKEEP, but I'm not sure if KFD/userqueue suspend resume is actually fully implemented and handling this.
> 
> Maybe we should stick with DMA_RESV_USAGE_READ for now and I will let my team double check the KFD/userqueu thing later on.
> 
> Thanks,
> Christian.
> 
> On 11/17/26 21:08, Thothiralingam, Logatharshan wrote:
>> AMD General
>>
>> Hi Christian,
>>
>> So adding dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ, false,MAX_SCHEDULE_TIMEOUT); before the amdgpu_vm_wait_idle() fixes that gfx reset. So it seems like amdgpu_vm_wait_idle() alone is not enough.
>>
>> Attached the patch again. Please let me know if it's good.
>>
>> Thanks,
>> Tharshan
>>
>> -----Original Message-----
>> From: Thothiralingam, Logatharshan
>> Sent: Tuesday, November 17, 2026 12:52 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH] drm/amdgpu: drain queued scheduler jobs before
>> suspend
>>
>> Hi Chistian,
>>
>> Just having the amdgpu_vm_wait_idle() doesn't solve the issue. I
>> tested it and I do see the reset. I have attached a patch with the
>> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ,
>> false,MAX_SCHEDULE_TIMEOUT); I am building it now to test.  Please let
>> me know your thoughts
>>
>> Thanks,
>> Tharshan
>>
>> -----Original Message-----
>> From: Thothiralingam, Logatharshan
>> Sent: Tuesday, November 17, 2026 8:39 AM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH] drm/amdgpu: drain queued scheduler jobs before
>> suspend
>>
>> Hi Chistian,
>>
>> I looked a the amdgpu_vm_wait_idle() function and noticed that starting commit 1f02f20 (https://github.com/eseiker/kernel-asahi/commit/1f02f2044bda1db1fd995bc35961ab075fa7b5a2)  the wait on the VM's root page table fence list is removed. So correct me if I am wrong, this alone won't wait on the gfx jobs right?
>>
>> So should I add this before the idle call?
>>
>> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ,
>> false,MAX_SCHEDULE_TIMEOUT);
>>
>>
>> Thanks,
>> Tharshan
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, November 17, 2026 4:37 AM
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Thothiralingam, Logatharshan
>> <Logatharshan.Thothiralingam@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before
>> suspend
>>
>> On 11/16/26 21:40, Mario Limonciello wrote:
>>> At suspend, amdgpu_fence_driver_hw_fini() only waits for the last
>>> fence emitted to each ring. Jobs still queued in a scheduler entity
>>> have not reached run_job() yet and so have no hardware fence.
>>> Userspace is frozen at this point, but such jobs can become runnable
>>> later, for example once a dependency signals, and the scheduler then
>>> pushes them into the ring after the hardware wait has finished and
>>> before the IP blocks are torn down. On resume the ring write pointer
>>> is reset, those jobs never signal and the GFX ring times out and hangs.
>>>
>>> This was observed as a rare (about 2 in 400 cycles) GFX hang on S3
>>> resume on Picasso.
>>>
>>> Flush the context and VM scheduler entities of every open file before
>>> evicting resources, mirroring what amdgpu_flush() does on file close.
>>> Like for any other dma_fence there is no timeout, the wait is not
>>> bounded.
>>>
>>> Reported-by: Logatharshan Thothiralingam
>>> <Logatharshan.Thothiralingam@amd.com>
>>> Closes:
>>> https://lore.kernel.org/amd-gfx/SA1SPRMB0073292C113C6B98D9282092F87F2
>>> @ SA1SPRMB0073.namprd12.prod.outlook.com/
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>>> ++++++++++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 19a566187dfb5..d18348116d3f1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4538,6 +4538,30 @@ void amdgpu_device_complete(struct drm_device *dev)
>>>       }
>>>  }
>>>
>>> +/**
>>> + * amdgpu_device_flush_file_entities - drain scheduler entities of
>>> +open files
>>> + * @adev: amdgpu device object
>>> + *
>>> + * Wait for the scheduler entities owned by all open files (the
>>> +context
>>> + * entities used for command submission and the VM entities used for
>>> +page
>>> + * table updates) to run out of queued jobs, so that nothing can
>>> +slip into
>>> + * the rings after the hardware fences were waited on at suspend time.
>>> + */
>>> +static void amdgpu_device_flush_file_entities(struct amdgpu_device
>>> +*adev) {
>>> +     struct drm_device *ddev = adev_to_drm(adev);
>>> +     struct drm_file *file;
>>> +
>>> +     guard(mutex)(&ddev->filelist_mutex);
>>> +     list_for_each_entry(file, &ddev->filelist, lhead) {
>>> +             struct amdgpu_fpriv *fpriv = file->driver_priv;
>>> +
>>> +             amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr,
>>> +                                         MAX_SCHEDULE_TIMEOUT);
>>
>> That is actually superfluous and even a little bit dangerous.
>>
>> amdgpu_ctx_mgr_entity_flush() is only supposed to be called from the process which has the file descriptor open and is closing it.
>>
>> We use that to detect if that process using the file descriptor was killed and we should discard queued up work instead of waiting for it to finish executing.
>>
>>> +             amdgpu_vm_wait_idle(&fpriv->vm, MAX_SCHEDULE_TIMEOUT);
>>
>> That here should be enough to wait for all work to complete.
>>
>> Regards,
>> Christian.
>>
>>> +     }
>>> +}
>>> +
>>>  /**
>>>   * amdgpu_device_suspend - initiate device suspend
>>>   *
>>> @@ -4587,6 +4611,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>>       if (r)
>>>               goto unwind_ip_phase1;
>>>
>>> +     amdgpu_device_flush_file_entities(adev);
>>> +
>>>       r = amdgpu_device_evict_resources(adev);
>>>       if (r)
>>>               goto unwind_userq;
>>>
>>> ---
>>> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
>>> change-id: 20261116-superm1-drain-submissions-17d4414ab3b9
>>>
>>> Best regards,
>>> --
>>> Mario Limonciello <mario.limonciello@amd.com>
>>>
>>
> 

