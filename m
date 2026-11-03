Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931D606EE86
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T4QducaV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A1510F4A5;
	Tue,  3 Nov 2026 09:40:41 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 891D610F4A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 09:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lb9HrN/phFUSfKZAWNJObRV9t04RYFmZaWcYztkG9Sp61F6eLIG/YD6uk5Mv+ZUqm+/F3Dg1QszmMwl5APuVOTbCaGQGg8IrFtW01qYzQYDeyWQnYbgZGH6wO3tU6hA8/RM+B6Ejvi//QF+i8pZ9mPXK9Oc9nYgy9ku7LzXKHYvUo5GInZ8oJgDr/IA/KI0Qydm+tminf9irBrGcCD8aSFMxupfOii922LCUQxahLaR1uT5d1hc3LwoRUE7Hc3hTEvn97GWPtg5ARWez2jdp0v18BBDCdPnDe+0aok19Wpg04FZ1tZMMUqJRAtOOhye5BEcCQHvaPDbBjGQefeGVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzktAKZbdXK2GyzBGNFFOXpXUZwCVKHqgCpj24CWrLw=;
 b=kQThvjC8CVgTRDEw7wlTKxcNaBCTKnejkmzq4oNiOa66/QNBYEORPxSdhFuyn8l0xM4TvlBO/Tcfxpt6xoTYWO7JFGDBgvJlhtmHnQMDmyLjePLXq0uACz+7atsGRiUl5ZjfsMP/DdIM4V0WmzTUHDZxbyfmRJYWUV7ifQUQb/hdqOnZMyu0rFe+Qh5XCQe0O+3qninFQ/uQc0W6gRxijxIe6on5MJZZ+BIzOiJ9kTW07JJSQoJR0/87nPs/bDCSmMAKyNnOXDTs2AEi88ZmBJlSUKEllEPPYta34tCq7LQ5kxbdAIuHB5xo59C667+5ud93ob6ywFtU5n8Rr7KQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzktAKZbdXK2GyzBGNFFOXpXUZwCVKHqgCpj24CWrLw=;
 b=T4QducaVsUOV32B2qfdxbBHHV6GyzqojO0WJ3vXJBYjAGKU46584ZTprKCUcfBnaLBEPqaafB4dFoCaZaJB9Q6lJ/h64pjgYnQvb0lPSA5Uf2VakloXce4LFAY/urMTBiXjJNEALDM1i1RBlsiaZbpRBZW4fveaxe9cSZOmaMxA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 3 Nov
 2026 09:40:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 09:40:31 +0000
Message-ID: <10dd384d-12ec-443c-8f1f-b21c524b10ae@amd.com>
Date: Tue, 3 Nov 2026 10:40:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] amdkfd: Native integration with DRM fences/syncobjs
To: aarthex <aarthex@proton.me>,
 SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>
References: <6LGhg_Yb_ppPcBcic7UenLy4cBVr66GyWswWm0xLqKQZc04YxYzLkPxbPNQj_2LvHWaG-hSzXaFM2ERSYhJbEOEUYXVn_tWBUYfMP_KzQAI=@proton.me>
 <ba707a14-2802-4a35-a727-c22e749c136d@amd.com>
 <5e8e8c22-d8c7-4c76-8a88-2a69f920245d@amd.com>
 <9PPY12T_RVxa1D24UhLqTocmtEOshesvldOUE5OiV3YlaMIUd0DtVNHxD2Ac6YyHHuGwS2VIhLz2LSsb0CH8_DATSblqKlSYg3ldElY2HPo=@proton.me>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9PPY12T_RVxa1D24UhLqTocmtEOshesvldOUE5OiV3YlaMIUd0DtVNHxD2Ac6YyHHuGwS2VIhLz2LSsb0CH8_DATSblqKlSYg3ldElY2HPo=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:408:f6::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d10c588-6b94-45f9-ae28-08df398e80a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261021123027099003|261026121527099003|261102123227099003|11063799006|261022105027099003|56012099006|261022075727099003|4143699003|261009223027099003|261021135927099003|10067099003|18002099003|22082099003|261021121427099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: FWWyQW7eTnRXCtD/kyT9Ka7y5A63P59aGb+fwwDYPF3NKdvrFnft9IlnRcxIaGkgcCDTxCZdpHvbvBNb48p8V2NkeTg03XkMfDoA2zjwnzOlg3UvSJoIM07eG1YsgDvGqSn24D24Zc70Ue5Cg3h+8ShKRdcCKD6q5Xx82w1H0qmWABlC2F7zPJGhmgOPcRgrnnMIVJiB30acrqfMq8CVTmcNt7iJ+PpQ7WAdWTAAKe8YYYniTFONLk0Gzf7SpuVbrK8o0E1fzbFOkJzwfx+xz4RWzA/wGjsq4SZs/7LMzSS5YVBe1IjStS3UAm/Q86UoyLQeJonxCAbznetKVWbFwNGohc3scBRatyZKxz4qMEQZEsZJr6SqAuTzS9sui6TutngPXY9BKldEwQjIpGtIHYNbb6V7xIs2gHTLgm1qfRcORBqjJFGH3uKSX25WC+wC8LwYhDYSHd+2esUYL0P7NsFB8PDPpIwlWw2bIVDyR1B3Hsphkx9LZmgExF5Ks/3uK/HhNohbdp64OIm4nUnTT+m0jWGTcOjtwuijkZQLVsVPA4xgg5D968GrJGBoFNzEd21Psghe3ZxhxqzvVgw123esuMQpj41MTH9Rd7E9rVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261021123027099003)(261026121527099003)(261102123227099003)(11063799006)(261022105027099003)(56012099006)(261022075727099003)(4143699003)(261009223027099003)(261021135927099003)(10067099003)(18002099003)(22082099003)(261021121427099003)(261026140227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUJqMEx4S1JvOG5RMVoxYlV2blJxNUZMNHpUOWR2amFsdzgweTlNWDdLNGNY?=
 =?utf-8?B?SGlaN3pDYzdsaHhNdElqaDRaVjJjbFpza2VyRzNDbkdQUDJaYTY2WkhNbzJi?=
 =?utf-8?B?T280NHhJSi94TDF3ZWZvWHVzNGpRUzZyalpBUWFWUy91SDZyU1JTc3BiUjQ3?=
 =?utf-8?B?MmJvcFI0Z0VHNlJ4N1FpZW44RDc3TXp5Zm01a2VWTjRhZ0VpVGZZWFZUeEVM?=
 =?utf-8?B?cTYrWmNMOURkR3pEK3lCQVM3ZHBETVlvcGs4SXFXQ2lSaGhnZHRqVVFCYmRl?=
 =?utf-8?B?VEYyTnJUa0hHU1ZLN1hFYkpFYjRjS1VzQnJhY1RLQlA3ZGdETkJETS9yUmRv?=
 =?utf-8?B?bDV5TE1oWWNUYnZtVkJlMzlIWGJ1ZjI1Vk0ySzlsckNEYk1aZVE3K0NKdmFO?=
 =?utf-8?B?L2Z4eGtxeGVSMEQrZFhONkpKL2paYzlneS84QzdHS3VWakwrSUk4YmFMNXdh?=
 =?utf-8?B?bkg0eEZPWm1ldldLWVRETjk1NzlZeGVVcmRhTDgwNVl5UVZ6LzZwK2UvUWxt?=
 =?utf-8?B?cXRyOENhZzBDUDV3MzY1eGRzNUl3S0hNVEdKaHlCQzBuQ3VHQVMvclRidnNK?=
 =?utf-8?B?VXhVL25FRW5uNWxTNVhFRURnU1RRK1UwdVV1Z294MzBVQ3J4ZC9pVHNoZDdM?=
 =?utf-8?B?T2RZeGRnTXVZNkFOMURBSUdNMTdiTDA4S3BGYmowMmw0a3J4ZitKYXZpR3Rl?=
 =?utf-8?B?VDFJMis1MkVmc1hTZ2QvNDhHZzFqcm16SDVETmZ0WlhGR1ZDaUVtWEZnaWxV?=
 =?utf-8?B?L1I4WEtmNlBwWFZlYU9GNFV2ZHh4ank1RDkzZGwzUUxlT0lpTEppZGd2dkVX?=
 =?utf-8?B?dmRuMDU2ekZ0SzlrMU1ZbUtYZ2NlNytiTHdYYmVTUkxNZmlFMHhzRGJRNC9I?=
 =?utf-8?B?ZHIrWkVUckdWN0ZRZll4aVY0ek8rZXc4ZUhiNVgrY1JNbHRRNXZkdi9EeDNy?=
 =?utf-8?B?b3ZBYWFQaUQ0cnkydWltQXhQM3B5MlhDd0pyU3pYUmpRSTRhQVUrQ2RkVGFG?=
 =?utf-8?B?QnF0WWY0bjJyMy9ERzR1dFpvNnJSa1B3eU5pdUhzakd0UHZSa3FJK1AzbFVz?=
 =?utf-8?B?amlNaVBoVXVTZGprUEdSU29HYks1K2d3bWh0TjhSdG9vUWF1dXVHK2FKWENG?=
 =?utf-8?B?cllvMytWeVB2MGllWnN6dHBBbUdySWcyNG1JeW1oTE9LMHhqbGZTekZqRHdI?=
 =?utf-8?B?d3UyTWFDZjJrSDFrZDhPdEhmdHo0MzlXUW5TMnB4TnZzS1VtWDRxelYySUd6?=
 =?utf-8?B?UXBISVNFdWw0QXc2aUE2d1pBQ1MxLzVqZW1INXA3MjNMcFpiTGF2RHMxWmhK?=
 =?utf-8?B?d3JEdzh6ZjlsbWt5ZE8xWjNjY0pCVlBPc2dlVm9ZWWF6VW1PK0ZTemZ1cnpP?=
 =?utf-8?B?ZmhxWEZ0Q2hLMGgreldKSmlEVjVQdEJscDNzeU94L3E1RXgvMmZNS1pMQjlB?=
 =?utf-8?B?YU9DVVhYbW1HVTNUWVNBNGl4TGVzNTBxZXZ5L1hvOUltbU9KVzgzUDg3RUxl?=
 =?utf-8?B?VU9RbWVqdG5kR3Nsb0N6UUptMzlxRzRMaEcvcUpPdUhCSEhZVW9LdTRFcG9V?=
 =?utf-8?B?aXFLM2p0UnJpS29ocnY3Zk10V2NhOUJ0RmR6bUl5TjI5MHRHQmRLa1UzZkFU?=
 =?utf-8?B?TnA5a09wd2VZVmIxSktaSnp2SGZ2OFZVK3R1VndUekp2emlOeFR4RWxJd3M5?=
 =?utf-8?B?cnFPdkZXcmk1OFNqU2lWL0x6by9vNUw0VzJrVVAxMkhTTDJnOWt2MHlEK1dS?=
 =?utf-8?B?eTY4TnBKSWNzWGovMkwwMS92VUFGcFpROGpmMUVvRytodzI0cUIyVE1qdU5F?=
 =?utf-8?B?NDJtbFlTTDJkV1p5WFhjdDRuSnk0TlpBZURNNkp2eXJIUUIwTXFQaFVEVGM1?=
 =?utf-8?B?UlkyYWhoS25IajZ2eHBQUXBDOWxlQnhaZXpjQTFKc05tdndPSVJvb3EvWlN2?=
 =?utf-8?B?SEl5V1QwbmlhU2lVeUxzY2hqZFJndlFFY2Y5dldZOXFOSjVST0xGZVRGLzNX?=
 =?utf-8?B?RHR3UHdpR2I5M1RNalhQZkpzSDJTczhSSVY1dzlhZTZqMTYrcUpBL2hjdDIy?=
 =?utf-8?B?N21CalkrVzZWRHhkMlRKUnpkYXBoVzgzS0UxQS9yZGR5dnRTY1E1M3BJNHZD?=
 =?utf-8?B?THorSUZaQmZPMnhQSG1PejVyYWMyWU9jbEFjRXhnUGo5Y1Vsa0UwdllhZ1NC?=
 =?utf-8?B?OVZvRHJ3NnByckZ2ZUg1T2E3NHBTbkQ0Nkk3VGtPVTU1QVppc3lKMENoZ2FJ?=
 =?utf-8?B?NkQxcWw0WHh1L2lWRGtMaHlQQWdPQVBYQ1ltVjFrcCtNK2xwQUhDZ1RrNDU5?=
 =?utf-8?Q?06TmU58Rf8ETS/HDWV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d10c588-6b94-45f9-ae28-08df398e80a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:40:31.8589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeHQszkBX9Hw/ji1NNiLxpnF/n69LLQkpq/MNo7N17ILlf6c5KZ78e3WkUp6xFtb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Aarthex,

On 11/3/26 09:44, aarthex wrote:
> Hey Christian and Srinivasan,
> 
> Thank you for your response. This eventfd solution seems quite promising!
> 
> As much as I don't want to take too much of your time, could you refer any discussions on why fences/syncobjs are fundamentally incompatible with amdkfd and such?

See the documentation here https://www.kernel.org/doc/html/next/driver-api/dma-buf.html#indefinite-dma-fences

"Infinite fences from compute workloads are allowed to depend on DMA fences, but not the other way around."

In other words ROCm submissions can wait for dma_fences inside sync_files or syncobj (which we partially already support), but you can't signal a dma_fence from a ROCm submission / KFD queue.

Technical background is that in compute frameworks like ROCm or CUDA you have features like long running submissions, page faults, busy waits on CPU activity etc.... all of that is not allowed when you want to signal a dma_fence or otherwise you sooner or later run into deadlocks with the core resource management.
> I was under the impression piping GPU events into eventfd is not too dissimilar from piping it into syncobjs and such.

Well what could be done is to signal a syncobj from an eventfd inside the kernel instead of userspace, we already support that the other way around.

But the problem here is that signaling inside the kernel it is not much better than creating an userspace thread, blocking for the eventfd to signal and then manually signal the syncobj.

You only save a mostly negligible kernel/userspace/kernel transition for the cost of much more complexity and resource handling inside the kernel and that is not really feasible.

> I will admit i am not very knowledgeable about amdgpu's internals.

Well that is not amdgpu related at all, it's just the general dma_fence rules.

And people get that wrong all the time and are then surprised when stuff is rejected during upstreaming or falls apart as soon as customers start to use it in a production environment.

We unfortunately had quite a number of such things in the past.

Regards,
Christian.


> -------- Original Message --------
> On Tuesday, 11/03/26 at 08:22 SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com> wrote:
> 
> On 11/2/2026 6:20 PM, Christian König wrote:
>> Hi,
>>
>> On 10/31/26 05:28, aarthex wrote:
>>> Hello people,
>>>
>>> Currently, amdkfd provides no native way to integrate itself into a wider event loop (like epoll or Wayland explicit sync) using standard DRM fences or syncobjs.
>> Yeah that is completely intentional.
>>
>> Background is that the semantics of dma_fences/DRM syncobjs are incompatible with ROCm or more generally any compute stack, Intel (XE) and Nvidia have the same limitation.
>>
>>> There are some workarounds, like creating a syncobj and then signaling it from the CPU side after the GPU is done, either via polling or hardware interrupts.
>>>
>>> But none of these are very tasteful, especially for something that is ideally the driver's job.
>>>
>>> I opened a feature request for this on GitLab a bit ago here: https://gitlab.freedesktop.org/drm/amd/-/issues/6013
>>>
>>>
>>> Before I work on implementing it, it would be nice to know if the team was open to accepting this, or if anyone had any thoughts/architectural pointers to leave.
>> It's really good that you asked before starting anything because stuff like that is completely impossible to get right for dma_fences and DRM syncobs.
>>
>> AMD and Intel are working together on a eventfd based approach for their compute stack to replace AMD specific KFD events. If you are interested Srini can point you to the right patches/components on the mailing list and in code.
> 
> Hi Christian,
> 
> Thanks for the context.
> 
> For reference, we've previously posted prototype work around
> eventfd-based compute event delivery, WAIT_EVENT infrastructure,
> 
> - EVENTFD infrastructure:
>    https://patchwork.freedesktop.org/series/164618/
> 
> - GPU event producers wired into EVENTFD notifications:
>    https://patchwork.freedesktop.org/series/170501/
> 
> - WAIT_EVENT metadata retrieval and consumption:
>    https://patchwork.freedesktop.org/series/164813/
> 
> The goal of that work was to explore a generic eventfd-based mechanism
> for queue completion, reset, and debugger-visible compute events from
> the render-node side.
> 
> Regards,
> Srini
> 
> 

