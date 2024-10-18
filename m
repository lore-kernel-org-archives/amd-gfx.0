Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23DDD3F2B0
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 22:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 820E010E9CB;
	Fri, 18 Oct 2024 22:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dG4iQYwz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C094910E9CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 22:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UesHCqKbzridF0iYKkQxCgJOWhNBro96jUlS5+1lOrQV84P5tTkl7OVxtd2nhjtafNsR6cCCCseO9j1zWzx/Y6qP4cc4Mn7RdKCoiCq/knclmMcOncZW255WluFXXQXhEdm/cMIDzgArnmiwiMcOAmx1Bfep2UUdsURk5qqazOM2LR5vrO7EeD7XhiK7jXo7sQpFZjpNYyudTrKNBpv44HHLyKyHUu02E3YA6j1X1e6oxNRz2kz+leezvn4xk3j4izFim2G4lskCoz0UJVJnYgHkj12h9ZCyRUE4DtPaGvRLvOoxGfOEednMboL7NdbtYSjwhIHGl1/UVJDopIPqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8jVeHrAQGYqddribBWhjPAfYAuaGjhFe8hunsPjSz8=;
 b=GsMngMfgOa9fAcS5bQqO6Ul1S/fau5GEnFljE/ZbajkDz9R9f0mEyx5PS6d5IkVqmJTRcQZ93Ip2GzqYNYn/tpH1FWZ/cI5DXpyih0J9lI7k2DV7l0u91yiAJgvCYonPBiURAEbeMg0z3Qrx0GOGE9VDpy2P7TqLPqBCSaZ1rbuu8TGa+wHO3LdgRsA0PaAvieF2N9JlZSkX+L8Ji0IfADxs0Jyja5xaynuMGfnl6Oocd6blokCOtAoYvvNAMabXiaOAb2ROjEyrHCtn2TeITUHNkAHl1op8JOZq6PqzcwTyVw4xz7i9E1cIVskS+EBLqI4PM30STVZiAMfPIiLumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8jVeHrAQGYqddribBWhjPAfYAuaGjhFe8hunsPjSz8=;
 b=dG4iQYwzQeaTvW1uewgBweiGUq1Zy1BPSJ0/bmvK6crymkCy5M+tZjM2l401aJsMWlYlivzBjXDXo/ZEkiWL5P2q88hRLzDcw7xNCKFaKELhr0wyH12g64gojqRtkuWfE1LdSeFT850NOR8Dkh3c8hEDhlSnS2OCT3NMuw92p8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Fri, 18 Oct
 2024 22:02:12 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 22:02:12 +0000
Message-ID: <9040368d-e698-4a3b-bf19-d7f3b35354b3@amd.com>
Date: Fri, 18 Oct 2024 17:02:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: change kfd process kref count at creation
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241011144155.120290-1-xiaogang.chen@amd.com>
 <f80e5f38-8235-4c73-89d1-c62991fe052d@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <f80e5f38-8235-4c73-89d1-c62991fe052d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:806:24::11) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: a34388b8-e312-4ade-2bf7-08dcefc08518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXozejBhYUdqajBvd3dRVTIzZGd3eVdNcUsyMW9mWTVESXg1UFRwb2lMVC81?=
 =?utf-8?B?TS9pT1dOd1lLM3lFRzZLUENFYU5GaG0rZUhwQWt5T256cXMrRmE3UkZDYUZp?=
 =?utf-8?B?Q0g3YitWQnNyZ0VLTVhkWHlvZktmYVdzUTJkRXpCSWVUM0hmYTh1VHc2dUVv?=
 =?utf-8?B?U0ZNVHB5a1JzQzZ2TlRWZXBwakRteHF1cit4N1BCdkIvK1JQcWpBUHcyQ1pE?=
 =?utf-8?B?eTY5NFBSeUs5NzFlanNHcUR5Q0FnYWRZVXBEZnpuNVJwQ0Z5STRGMCtYZ0ow?=
 =?utf-8?B?MVZTWlZVN0NvQkN5ZEZrdTcyNzJxbUtFTk9kaW9USDRDc1dpK1dvUDdEUVdr?=
 =?utf-8?B?TUhPdDdaQUJwUHVVVUt1dHZrL24veUxLWEFubHNLZkt6Wm55dmxJSGFISXdJ?=
 =?utf-8?B?SHhMVlh3UGQ5WGQ3UzJsbEdWeS83SmU0em82eGs4ekR4bytETHdTZnJJWkg0?=
 =?utf-8?B?YVJLV2k3dUpkZXZaZkhLRGhhbUJmVXVnblZVWnE2aG5wTmNPWHZBVncxNnlz?=
 =?utf-8?B?N2lDd1YrZFZSSm1zNEVwMXE3emltLzJmU0FFU2F5czhEdVFNbGRHaktvUEQr?=
 =?utf-8?B?UTk5TjBPTWRaTEJxT3NpWHF3Z01GSDVOcVVmbjk1QjY1YU9RS2c4bzQ5VENN?=
 =?utf-8?B?Y3RlVUdXV1MwTEd1UjVqU1RYbmhkemcrQ0lramx2NmJuVmpWUndzb3ZXM0NZ?=
 =?utf-8?B?YjlrQXVRVlZwVUtFWnFiREFFWGo3R3VIWjZSYzhMZWErZFJnb2NKMWZJTzV0?=
 =?utf-8?B?VVA1OEsvS1FCNy91L3VLMjVUOUI1NzUxd1FRZ2lJODJiN1Z1K1gzcUFzYng4?=
 =?utf-8?B?MGRqWDB1aUJ0M2xXQ24xN2MyOWdBblNEVnVyZmFvUUdEZ1BqaDBRUmptMkk1?=
 =?utf-8?B?WWJoaUxNWGEwWldOamZTOUM5SWl4bjJqQlpINWp2Q204VlQxUEN1Z0M2d1FD?=
 =?utf-8?B?bGZjd1FhcFRkSE55MWhCSnVXM0loeHBOVU9RSzBacnB4ZzY2cWpDNUlsdEtI?=
 =?utf-8?B?VzZ5eWlqZ0c1L0FtbFJuT0FGcVJQM0x1Y01jSUNTSjBBTUJJTmpiM3F0RFlN?=
 =?utf-8?B?YU5xZFd1TGxlT20wMGdlR0U4TXM2TmZEVyt4SVV5YTlUN3NOODBkbzd0TmhK?=
 =?utf-8?B?WjhYUy9oT2RYdHFLdVB4dGgrc2ZJZTJ6RjhoYURadmhqbGdISHd4bVFZSHV2?=
 =?utf-8?B?YkZkaUdSRldNQTNGcTI2aGYzMHVoa1F3Q1JjRVpZOTFSazd6ZDBUaHluT3RW?=
 =?utf-8?B?MHZodEVWRmZkY2hJTVYvbnpaNWEwaEQzeEtlVG56VlhxOTlKZzVJMVVqaDJn?=
 =?utf-8?B?d0VIckdmaHVPTUZGNkg3R0NORnoyMXVLVUtQaGpFMEYyWkhRTFVFNVJEdjA1?=
 =?utf-8?B?dGl2aU1nb0Z5ais2VXd3bTVVUkVWa0NNN21QaExNdGZNdnkzK1lha21nRlhU?=
 =?utf-8?B?QzJUd3VRL0FScytHdVMrb0pwSDhqVW1Xb3dRMS8vZ1NlcWN1bzRhWWVQMHlh?=
 =?utf-8?B?dEFCb3lPSTYvR3d3bW8vQ1k4Y1RnRFY0NGxpclV6MjFNVGNXV0xJbUMxd21K?=
 =?utf-8?B?M2xzM21HZi9TV2RWSXQyYVE4cm9USUdYYmMxZ1JIWVczTFBVUzd4K28zRm9M?=
 =?utf-8?B?dHE5QUtvSDZVVWpqRlVGSmlZRFk2S081cXNOSElFRDRTZ1BSS2ZvTzg3bDJO?=
 =?utf-8?B?SUpoUGNGSVBQaEtqV1M4blp3bGdROXkyZENOeGVGOGNMNWJGbUVJbDUvVW5l?=
 =?utf-8?Q?WH8hhFUp7dCz9uNbnR+FQgrwJbsNUexQnTkzxFR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVpqRTlhdklIZEljODBPbWJlZFVndFNlOHNXWVZCTnlMem5yOGNZUzhNZzBj?=
 =?utf-8?B?bHlZRys3ekoyNENpeS8zdktvZTBwbzhPMWVLMW1tb3lLTVZoTW1EMTNHTytF?=
 =?utf-8?B?OGtWQmtyRHZFRjdSU0RweEZjRXdEQXYyZy92ZGphWE9Yand5MHRnSHNXYjF0?=
 =?utf-8?B?NkNzNVh1ZGw2N0RMcGJxZ3FLdDdiZVo0eVJibGVJc0tnVTJGWUF3YzNvUllX?=
 =?utf-8?B?MkFIMHZNcHVlVzRmWkJpbEZ0TzBsYUkxdS91VVJpbnNZSHZFKzJiS0VHazl2?=
 =?utf-8?B?VmNGa1haVVQvQmdCZkkrYnNBTUs3RFVwODB2bW1tSmZVUkc2TDhMbkZ5QWZJ?=
 =?utf-8?B?ZmI1UldLTW50UHZsUFFqODVaUkZ4eEs5ZzVxUzhRTzhIU0Q3bkNIWkdiWWZ5?=
 =?utf-8?B?cjdkSGNIUGtwSDk5bGZXTnVZaXprMEJmRnJUb0pWdDhzY0ppbzhnMi9FeXVH?=
 =?utf-8?B?VVNidE1xc2ZoK00yNzZJZTMxVlVvY0NRbjZuck5RS3k3TFVMR05yZjBDREg2?=
 =?utf-8?B?YUJ1RHZsdG9oTkNocjdzVytMcmpoVG1raTNBZHZ1eHE4dzRiYy83TXZDSlpm?=
 =?utf-8?B?OUk0czUycnpFbnpHZ2Q3U24wcUM2YXBxRDlUUVlsQ2ErUXpZdVZIVGlXc0Zt?=
 =?utf-8?B?VHV2eXVJVkNLK2FwOVF2ME55Rkt5T0V3K0IvQ205TmtWWm5JMzIrV0tCcE0v?=
 =?utf-8?B?WEdYQzVGWEpaZWM5NURCS3pjNldVeU12SFplS0h3NFhXUm9RY1VWWnIwV0s2?=
 =?utf-8?B?TVpsNWlmeFZMWHdtMHZsdHJaNHA4TEM5NEx0a3hlTS9pZVlvdXJJb3NnRjNk?=
 =?utf-8?B?NEhjYmpvTWF5MUluTnd2Wmo0cnZmRGY0QmJKNm9BL2pkMCtDQmFEQm9IaC9D?=
 =?utf-8?B?SHBqTW9EK1lpUy9vdloyMmQzVjQrSDFqbUpvb3BoZUx5a08wOXl2MXZVR3RC?=
 =?utf-8?B?VnM2enIvSmhMTVkyZzFKOFYwb2VUU2M0c2VqMGZjeHljU3daS0lmcUFiVzZF?=
 =?utf-8?B?eDdIWk9vNHQraWpYZ28vR2Y4RjFDTUFESWZ5SEVtM3diMTFFUURTeGozVmtr?=
 =?utf-8?B?ZHdicy9ZM25mWksva0o5TzZpZExvMHFwU29VckRiaTZBcHFvRTFzVXUxMDd2?=
 =?utf-8?B?akRLZmZlM2FzMzlzVVlxVUU3cHliaHUxQ0xRTi9DSHVGQ1VMaEZvd1ZVTWhp?=
 =?utf-8?B?bnpLNU43TUR0Qi9IV2lZU3ovcHd2d0ozUTdNRE53UGlQaUpoYkFoeFV3RFB3?=
 =?utf-8?B?RnA3dDducUlJcE41TVFxb1loYjlTb0VHcjdCRG9zUmpLMk1kcjJkOWJYSEpv?=
 =?utf-8?B?eWJUdlVqZm9kN0UwMlFmN0REVlpTYWRUckZQWEJqU1M2TzNaUkZsWS95dTJN?=
 =?utf-8?B?elhNQnNXWWpBTjd4dHZNWVBlRUwvNUNKeVlSemdseHdVWlZxY2E5TUVFcWhW?=
 =?utf-8?B?K21xSGVXSkYzdzV2YW0xTTlJY0puajJmZXovaE16SzVCRHY1L2dzSDRjajNv?=
 =?utf-8?B?VTlReWhwUzJiUUlaS2QwQ3ROb0o4cTJBRHlwUXU3T2JsZ1ljNDhUMHZuT3FM?=
 =?utf-8?B?RmZFZGFuT0R3OHRJcy85d0lsVFhyajVobmtjYjcvcGNGaWxTdHNMYWVSWWNi?=
 =?utf-8?B?TWtQSzRQQnJ2akQxUGJZRktBa2MwSmNoWTFLUkNjOUtHSVJxblF2bWNlV2w4?=
 =?utf-8?B?d3FNOVJqWlM2RFIvMkpzQlp5UGRlRVZJckx2a3MzRyt0cTl4RXNKTjdjbkhP?=
 =?utf-8?B?YW0vY1JjVVIyRlpCNjRGZTdYS01PYUhkbGczRzJyUWc0eCt1K1ZtbDZUWVZk?=
 =?utf-8?B?Njdvb2w0VlZrZWFIdnEzdEM3aHFMSTdDZGJibjdsc3liY09udFZwY21OV3Jw?=
 =?utf-8?B?ei9aT3lJZG5TVHV5eG9aQlpNdjFMZzN1czlFMTVVaFlFMXJwOEsvLzlIVzM4?=
 =?utf-8?B?V3ByWUVXY3VWSi9LdmtJVXpTcmtsaUZMeGxQelRPMGpvaTR1ODRaa09Xc2Zh?=
 =?utf-8?B?ZGppVzlTeWw4U1ptbkFQZFd5Qk9zQWJ5a2p0WktIdmdRWU4vTy9xeE5ZTG5C?=
 =?utf-8?B?ekhxVzQ5RGlobG12RVM5UVA0Vkl3YzVPVXRmM1oyWStoclhtS2o0V0EwVHpR?=
 =?utf-8?Q?//4o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34388b8-e312-4ade-2bf7-08dcefc08518
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 22:02:12.6971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQgevSOAxv3q4yY83/j6YgV4l1y8fq5fokqKZSthH4m/Dt0LpyQOSNeQqrwzj2e9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
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


On 10/18/2024 2:14 PM, Felix Kuehling wrote:
>
> On 2024-10-11 10:41, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> kfd process kref count(process->ref) is initialized to 1 by 
>> kref_init. After
>> it is created not need to increaes its kref. Instad add kfd process 
>> kref at kfd
>> process mmu notifier allocation since we decrease the ref at 
>> free_notifier of
>> mmu_notifier_ops, so pair them.
>>
>> When user process opens kfd node multiple times the kfd process kref is
>> increased each time to balance kfd node close operation.
>>
>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>
> Thanks, this is an elegant solution, IMO. The reference returned by 
> kfd_create_process comes either from find_process or create_process. 
> And the extra reference that gets released by the free_notifier gets 
> allocated by the alloc_notifier. I think there is a race condition, 
> though. See inline.
>
>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index d07acf1b2f93..78bf918abf92 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -850,8 +850,10 @@ struct kfd_process *kfd_create_process(struct 
>> task_struct *thread)
>>           goto out;
>>       }
>>   -    /* A prior open of /dev/kfd could have already created the 
>> process. */
>> -    process = find_process(thread, false);
>> +    /* A prior open of /dev/kfd could have already created the process.
>> +     * find_process will increase process kref in this case
>> +     */
>> +    process = find_process(thread, true);
>>       if (process) {
>>           pr_debug("Process already found\n");
>>       } else {
>> @@ -899,8 +901,6 @@ struct kfd_process *kfd_create_process(struct 
>> task_struct *thread)
>>           init_waitqueue_head(&process->wait_irq_drain);
>>       }
>>   out:
>> -    if (!IS_ERR(process))
>> -        kref_get(&process->ref);
>>       mutex_unlock(&kfd_processes_mutex);
>>       mmput(thread->mm);
>>   @@ -1191,7 +1191,12 @@ static struct mmu_notifier 
>> *kfd_process_alloc_notifier(struct mm_struct *mm)
>>         srcu_read_unlock(&kfd_processes_srcu, idx);
>>   -    return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>> +    if (p) {
>> +        kref_get(&p->ref);
>
> This should be inside the srcu. I think you could use 
> kfd_lookup_process_by_mm instead of open-coding the SRCU locking and 
> find_process_by_mm. This does the lookup and reference counting safely 
> already.
>
ok, understand. Will do it after next week vacation.

Thanks

Xiaogang

> Regards,
>   Felix
>
>> +        return &p->mmu_notifier;
>> +    }
>> +
>> +    return ERR_PTR(-ESRCH);
>>   }
>>     static void kfd_process_free_notifier(struct mmu_notifier *mn)
