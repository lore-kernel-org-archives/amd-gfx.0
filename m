Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E24F4613A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 15:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B08210E11C;
	Mon, 23 Mar 2026 15:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4vJ7O3IA";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E52710E0E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 15:02:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8Y67k8nJ1PdtQMi8UYEhlmK0ktD+U9osU1cjoBANDWn9fqAtGsBhx5Au/Hs6qdNoh/4I6Fnn6xJ4jBNEfMAWLMqQEA5N1P3Wwi2KcbYnRkFVZTwlICFhlDogepvcmMzPBQ6pMeGaL6X8EM8O2s5nfCu35wWWJEfGiT89WQlFSjJuiOgDeiM6Ey606WQBHZ0ZqZcB48lt15UwJbLY3L+4L0Sm/dy90HreKg9/lewZyPPmcMz8SXOUQkB/YxWhdVccycHOsvsl9Iufty+Oqx+wczdhAKgMi+4mBaExt0WStjkUl08waSgXhqETVugUOX5Fi8lwtjTKTPKzEpdKfl6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCxworVksj/TW7ipMisPy97Mp+eihXs9mtGQDKLbxfI=;
 b=eblTuW/CXjAmWqOdxaXy/ixW0ZJ8bSqrMwMduxcBG1jxbKk0c3kb7eGWs6esUfFTyxYN1ANlOK7Gj1uy7s45c/fZ6hqv0kF3+6L3ofQwhPFcYs4q6N58p2aPhUg/NbeDzXLMeJHidkQZxbf0ml0+up1yZ6oYxUH62mDf9s8yDYg/64FbmP7snlGzl+L8XV6QebV9+9m1cYY8zQS0P0oFxVPaMRRqYJSudCExv6NekisUSiokHtSm9HgVHzPPRSmo3SC/I2wuX79l/w1QGh4w02aEp0lSlQP11ktEb8CUeNjQlkcw9cDaOljNjBJmbu3Ntmh+b0VjS0nLBi0TryR77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCxworVksj/TW7ipMisPy97Mp+eihXs9mtGQDKLbxfI=;
 b=4vJ7O3IAn/87ux1w4HKl5jExJYJZQEKLCY3KJ/RMZN1o7MMOabPqTwIUGlOG6Kqfx3FaTT+o3s0F3xOlG95qxYJkGEhRhbkzVgNTZV9G9NLI8IJws6rt2+DSSI8wKNQUzmrm+EwDZfuC2dg3TNw+aAKE730LbQtHmja0YdOO0G4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 15:02:03 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 15:02:02 +0000
Message-ID: <cf811c54-6fc6-4514-bdb1-8251c639fe44@amd.com>
Date: Mon, 23 Mar 2026 10:01:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: check system memory when set apu_prefer_gtt
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yuan, Perry" <Perry.Yuan@amd.com>, "Lin, Leo" <Leo.Lin@amd.com>,
 "Perry, David" <David.Perry@amd.com>
References: <20260319073250.147808-1-yifan1.zhang@amd.com>
 <80732b5f-27a9-4969-8afe-98f3156c725e@amd.com>
 <CY5PR12MB63693D88EBEAEE20CC4B6870C14CA@CY5PR12MB6369.namprd12.prod.outlook.com>
 <f388c29e-4d1c-4d04-9eca-ce3b74f00931@amd.com>
 <65c61436-f076-4308-b89f-d2bdb214e481@amd.com>
 <35726709-03f5-4e5f-8425-7a84ea406464@amd.com>
 <76890001-297a-4503-b64e-7328b479b676@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <76890001-297a-4503-b64e-7328b479b676@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:a03:255::19) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbadd78-f9fc-40fc-2e27-08de88ed23cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: DQpP476XbN+SkY8uj/sycm2owQtJuOj25tIltZl5dLLyOiT3AQMrTBctMPip8HGK+1OKmTThkqhenhPsF+8/hvC0fSkKP3WYkIbgF4ABniZtZN+zITocFt3KZVWl5HLIGHd3tjFICnkcdXxTQl1Khie7fKl/5m69gUN3PkmT3KLU2EJ2K3FsoC1jPYxS/tN1+930WzgZKHzb0Ku/2uISLvVkxn8e0KanSN62Fich7hrEarHixjpwLf8tiI/paFVGDZk9DrtVlFzjEAFNMI5RoU+gDb87V5OtuS0BY4jPXZJp6Vu6edyrJ2MwR3KSvMR9Vi7NnbrG48YgLkotMIXG4NjsJiY6Ap/9Mjxr29bxlzQm0sOLeK4tivsXPwGhNF6uurLjzqYf53WUqNPkmF4unc1xoFNeQXjU66khUhh+vMpoGuD25Oo9TTkpEzAgp4WDnxSsVn7ZFx5G6qGcgP/nx2p++P95dF1e77tDLe4qhMGhhEiDI2I7C2ZSzgRjJVEdc3QG0zHE96J7LH7P7/lxw2dHHJyh4xSIgYYwZjGcAt2AzsmrvtwAsYEX2V8PdEQtvrJdeH0gvTwFeWgiXRMbkW7qV85jYw0ca2Bdrso7XA2LuomiMe8TkFIurCa9GfUowpPEWLgAVixRZxJ+O+UjBuFza+z83MQ9cY6Rc9RnCfGnsZ8z9y94p0ASWv10Kj+Ake82EluugJWpqPnSaABXfpenqpH4F7Vrsu0IxdvTm+Wc6DOs/c5xQrS8K36f0VAZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEUrbHZSRzZtc0JDTmoyU3FsejVrMEhoTlNoLzAydlRBSVhSSWJZQjR4NG0w?=
 =?utf-8?B?VWJmS3ppTmNCcUFxRXptd05VSERSWUd2VDM5NG5DUCt2alRGMW8zTzhMTllj?=
 =?utf-8?B?Mjh5WW92SDlrYmFyazVPYlJ2SFEzWUFocUh3c0FzOUpOTy9OaDBqUlBYL0FD?=
 =?utf-8?B?aEhZa3lWc1dXc2YxZ0l5L1I3MVBZMEZMVUUyTWlYdjdlUmkvMmVMUG5sWEhi?=
 =?utf-8?B?Z3M5V3E4elJaNlVRSzlLTkkxdDdocmd6NmdYRmtpaDVETW5ZV0Nsa0JwQVFJ?=
 =?utf-8?B?d2pBdXVhVTZlb05jYzl2R0lOY0RaQVo5Mm4xa2JHeGlpdS9IaDFZVHhnaUJB?=
 =?utf-8?B?V2pQTk1wdGFuZEV0RmRwbHpVLzdFRG1MbVdmNUxhUk5uQTNOaE9BOXlvdHkz?=
 =?utf-8?B?UTNxVDhyaXlFSGlYV2Q0RjFnTVMrTWRnWEowZmdtRG9aMVpOcTN1T1hPdUdL?=
 =?utf-8?B?MXJ5NTR1aFdCVDJjbjJIazdnL2ltQTNCdlNPMEtvR3BGSGdZSHRrYVY0elhv?=
 =?utf-8?B?WEFhODFrQytVRVNGTnJ2NklBNW1kd2l3TXdzZTFhU2oyUW03VXNrWkUvQkhI?=
 =?utf-8?B?RjQ0V2hJc3F3Z0h6d1pzMTZVVkEyQ2dhTDM4bkJnOFpLam90MkVKKzVIeXhO?=
 =?utf-8?B?ODNQQXppV3ZmdXVsVzdxa0xrZXQ0dGFLblpXNzR1U1NvWU9yb1M2cFcybUFX?=
 =?utf-8?B?QUtraFgxaVl6M1RaQjI0ejh5L1VFbHJTWTVDUmg3RWk2N3pOM0hCV2RubXJU?=
 =?utf-8?B?Nm5kc0E0ZjVLVU4rWVlsYzJvclpsMmdhT2NJZlFZKzhsZDZRUUl5bU1ueU91?=
 =?utf-8?B?YVlnVXo4V1FhTVVGRnhQS21pajBXVmZWWnlQdjI4ZDJpQUMxVTB4TkhmYXNn?=
 =?utf-8?B?Y0M0MmtSZ1hRbnhBemM2RDBZUHVFOVl6OXJhYndWLzBSZnk0TjNML1RQaWhM?=
 =?utf-8?B?Vm5jcjVsRlEzNkdjZEpVNUwvd1dqNlNjVUVjbWNwak5kTWkxYkRTaHorWEhr?=
 =?utf-8?B?V3YwODhJSVZBVVRWcFUzUUY0L3FrZWU4TE42SGdFTFJOVTJnQlBLZURlRkdV?=
 =?utf-8?B?QUx0anZlcjEyckZNbnZtWVRlckFJYXdUQ2NaOVVTMEtHZjhmSGFFL3BSSm5U?=
 =?utf-8?B?enllMnU4c3dRNjI4RE1HcEdlMTh5SmR3ZmUyOU5uUlBDd2Vld3JRU3dJVE9o?=
 =?utf-8?B?KzR6Q2FXL1BOMDRVTXNpc2IvWkZ6K0s4MWJ1M0hYaFFWeTRIY2lBQjJjTDgv?=
 =?utf-8?B?ODkzb3ppUW9YTm1IVkJScTgyZ1hhMkN4SUtlRUxjQXR2eWJ2YkF5QW9vTU96?=
 =?utf-8?B?ckdlV1RpS0VsWmtCRS8va3pPV0poTVUxMHlYYlRSTndCZlNQMk81VnpzQncy?=
 =?utf-8?B?Q0s5SnVnWVg3ckg5M3NZMFprbXdhYVNEMG9LWnhzRTh4Yld1dURxQ3ZLN1V4?=
 =?utf-8?B?S01iMW52UVRtckNmcWRLUEtJUXlnNWV4RTQwVEpPYXdQVDFGT0MySjQ3Mk95?=
 =?utf-8?B?QWxhWHBuNEh6UTcxakZEVWpabUxDS2FsWG1NSFZ6WXY3SUlCZnZJVFFQUWd4?=
 =?utf-8?B?bjd1NTFBeHZsWldJOGtPM1BUVFN5TTZCTUJzb2lybVkxbllyQkFZWjJVbEky?=
 =?utf-8?B?QjFYTmhjRlJ3SW14L3FnTEl6TWtJcXZkRy9zWkdiQ3lyNTJ2L20rMXZ1Z04v?=
 =?utf-8?B?QzBjczlOQWZTY0Y3MkdlU21aYWpoV2FCRHNxN2xVOEZUdjlFQzRLNGlyRk0r?=
 =?utf-8?B?ekxOT3pRTUtqN3FzamVWdGtsNDd5eW1QZEhnVDNqZHNZNU92d1hKTTM3YzYz?=
 =?utf-8?B?ZW5VRFJQbzBNUEVwQTdDQTVmcFZMMEhIYWtscnpqamZ0dXNKWlQ4NHZvZ25B?=
 =?utf-8?B?R2RZV1BpcEVYdUhvdUk5M25yclg5T0xHZStyWHZ4c3UvcWs4NjUraFVMdmRo?=
 =?utf-8?B?dGl1UFhGdlRIeTdYblBVVERmQ3JmU3J0SFFXYWdkK21nc0Z1UElnaEc2RDA4?=
 =?utf-8?B?NXpPSlRXZTR4d0RQbjg0Ni9VZ2xWZXNjVWhZUDZuNjB1dUhYVGlNZ21YS2Vz?=
 =?utf-8?B?aitrMHFSSFBwRlN3T09kZ3hXM2M2SkI0OE0wdnRDZ3ozT3pWaG1UaHRnVyt2?=
 =?utf-8?B?Um5QaEhSSDFQQnZQL0g0R2NoWitUeDhWd0U5bVBlV0ZBUUttZzE1cEd6emow?=
 =?utf-8?B?angzK0ZZMVJqS1ZTUGdBbFhCTkRES00zN3Rkc1dFWHhxalFGYWI4aHZnN2Z2?=
 =?utf-8?B?R0ZTUG9XRXkvdXVmM1E1b0IzaDNGTGZydmF6NFptL1RoS0tuVHVjaTJBdFNm?=
 =?utf-8?B?d1p0OEM0ZjZZZnRaRmowSnRqZVdDUjBoV1hnL2ZmaUU2bUoyL3F1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbadd78-f9fc-40fc-2e27-08de88ed23cb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 15:02:02.5200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gzJkUtINT9wldmZU+T85TSXfu1EcdAGruOYQ4aSknf7sGL3FY3v6ZNHSUaRNz47mzgdBXXj19DBh5fK5Yd70Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646
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



On 3/23/2026 8:49 AM, Christian König wrote:
> Hi Mario,
> 
> On 3/23/26 13:56, Mario Limonciello wrote:
>>
>>
>> On 3/23/2026 4:13 AM, Christian König wrote:
>>> Hi Mario,
>>>
>>> first of all please loop me in on TTM changes as maintainer explicitely. I don't see everything which flys by on dri-devel.
>>
>> Sure.  I was initially just looking for anyone comments on it, didn't think it was worth bubbling to top of your mailbox for an RFC.
> 
> I usually completely miss such stuff otherwise. I'm not very proud of it, but I have a backlog of multiple thousands of mailing list mails I couldn't look into.

Ack.

> 
>>>
>>> Then changing the 50% limit is an absolutely NO-GO. It's completely irrelevant that AI wants to use more, HPC use cases complained about that for decades, but we simply can't do that reliable.
>>
>> What does HPC do now when they need more?  Tell people to put page limit on the kernel command line?
> 
> Yes, either that or other similar workarounds.
> 
>>    This shouldn't be any different than status quo before - except that user intent can persist.
> 
> The key point is the system starts to become unstable when you go over 50%. We have tons of complains about that as well from HPC customers.
> 
> The problem is that TTMs eviction code needs memory to swap GPU buffers out to disk, that's why we use the 50% limit here.

Do you mean for eviction in cases that the hardware is going to D3 like 
a system power state transition?

What kind of instability is actually hit?  I'd like to reproduce this 
first hand to understand it better.

Because as it stands today there is plenty of ROCm documentation that is 
user facing saying go increase your page limit if you want to load the 
big models.

> 
> Intel has been working on and provides an alternative shrinker callback (see drivers/gpu/drm/xe/xe_shrinker.c) to work around that and so lift the 50% limit. But so far that is only implemented for XE.
> 
> If you want to fix this for amdgpu just take the xe_shrinker as an example and implement that same stuff for us as well.

Do you know of limitations with it?  I wonder would it make sense to 
just move it to ttm for all drivers to use?

> 
> Regards,
> Christian.
> 
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>> On 3/20/26 15:34, Mario Limonciello wrote:
>>>> I think there is actually a very easy way to trigger it and it's not obvious that a user messed it up.
>>>>
>>>> Assume you're on a 128GB system with VRAM set to 512MB.
>>>> 1) Set TTM page limit corresponding to 96GB
>>>> 2) Use uma_carveout sysfs or BIOS to set VRAM to 96GB
>>>> 3) Reboot system
>>>> 4) Now VRAM is 96GB, but the page limit was a module parameter and will be wrong.
>>>>
>>>> I actually /think/ that the RFC [1] I proposed a few weeks ago could be a good way to prevent this.  By using EFI variable instead, TTM could sanity check anything it reads at startup and save sane values to EFI for the next reboot (if they're insane).
>>>>
>>>> https://lore.kernel.org/dri-devel/20260306055439.1822879-1-mario.limonciello@amd.com/ [1]
>>>>
>>>> On 3/20/2026 9:28 AM, Zhang, Yifan wrote:
>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>>
>>>>> Yes, I agree. I’ve just been notified that this memory configuration is a mistake rather than a valid user case. So the fix is low priority for now.
>>>>>
>>>>> -----Original Message-----
>>>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>>>>> Sent: Friday, March 20, 2026 11:14 AM
>>>>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
>>>>> Subject: Re: [PATCH v2] drm/amdkfd: check system memory when set apu_prefer_gtt
>>>>>
>>>>>
>>>>>
>>>>> On 3/19/2026 2:32 AM, Yifan Zhang wrote:
>>>>>> Current apu_prefer_gtt setting only check gtt_size, which could be set
>>>>>> by user to a larger than system memory value (via ttm modules
>>>>>> parameter pages_limit). E.g. carveout vram 32GB, gtt_size 50GB (via
>>>>>> ttm modules parameter pages_limit), system memory 31GB. In that case,
>>>>>> apu_prefer_gtt will be set incorrectly. Take system memory into
>>>>>> account when set apu_prefer_gtt.
>>>>>>
>>>>>
>>>>> Wouldn't it be cleaner to do this in TTM?  IE test that a bad option was set by user pages_limit value and then show something like:
>>>>>
>>>>> if (user > possible) {
>>>>>         pr_warn("Requested invalid %d pages, limiting to %d pages", user, possible);
>>>>>         user = possible;
>>>>> }
>>>>>
>>>>> Then we can always trust what we get from TTM.
>>>>>
>>>>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>>>>>> ---
>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       | 2 --
>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 4 ++--
>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++--
>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 7 ++++++-
>>>>>>      4 files changed, 12 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>> index 3bfd79c89df3..a6ee9d9bfafb 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>> @@ -170,8 +170,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>>>>>>          int i;
>>>>>>          int last_valid_bit;
>>>>>>
>>>>>> -     amdgpu_amdkfd_gpuvm_init_mem_limits();
>>>>>> -
>>>>>>          if (adev->kfd.dev) {
>>>>>>                  struct kgd2kfd_shared_resources gpu_resources = {
>>>>>>                          .compute_vmid_bitmap =
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>> index cdbab7f8cee8..13cada7da4a9 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>> @@ -369,7 +369,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct
>>>>>> amdgpu_device *adev, int xcp_id);
>>>>>>
>>>>>>
>>>>>>      #if IS_ENABLED(CONFIG_HSA_AMD)
>>>>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>>>>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>>>>>      void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>>>>>>                                  struct amdgpu_vm *vm);
>>>>>>
>>>>>> @@ -382,7 +382,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
>>>>>>      void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
>>>>>>      #else
>>>>>>      static inline
>>>>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>>>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>>>>      {
>>>>>>      }
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> index 8a869fe41acd..4fba7d2f34a9 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> @@ -109,13 +109,13 @@ static bool reuse_dmamap(struct amdgpu_device *adev, struct amdgpu_device *bo_ad
>>>>>>       *  System (TTM + userptr) memory - 15/16th System RAM
>>>>>>       *  TTM memory - 3/8th System RAM
>>>>>>       */
>>>>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>>>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>>>>      {
>>>>>>          struct sysinfo si;
>>>>>>          uint64_t mem;
>>>>>>
>>>>>>          if (kfd_mem_limit.max_system_mem_limit)
>>>>>> -             return;
>>>>>> +             return kfd_mem_limit.max_system_mem_limit;
>>>>>>
>>>>>>          si_meminfo(&si);
>>>>>>          mem = si.totalram - si.totalhigh;
>>>>>> @@ -132,6 +132,8 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>>>>          pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>>>>>>                  (kfd_mem_limit.max_system_mem_limit >> 20),
>>>>>>                  (kfd_mem_limit.max_ttm_mem_limit >> 20));
>>>>>> +
>>>>>> +     return kfd_mem_limit.max_system_mem_limit;
>>>>>>      }
>>>>>>
>>>>>>      void amdgpu_amdkfd_reserve_system_mem(uint64_t size) diff --git
>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> index 714fd8d12ca5..df98ece071e1 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> @@ -2071,6 +2071,7 @@ static void amdgpu_ttm_buffer_entity_fini(struct amdgpu_gtt_mgr *mgr,
>>>>>>      int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>>>      {
>>>>>>          uint64_t gtt_size;
>>>>>> +     uint64_t max_system_mem_limit;
>>>>>>          int r;
>>>>>>
>>>>>>          dma_set_max_seg_size(adev->dev, UINT_MAX); @@ -2210,8 +2211,12 @@
>>>>>> int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>>>          dev_info(adev->dev, " %uM of GTT memory ready.\n",
>>>>>>                   (unsigned int)(gtt_size / (1024 * 1024)));
>>>>>>
>>>>>> +
>>>>>> +     max_system_mem_limit = amdgpu_amdkfd_gpuvm_init_mem_limits();
>>>>>> +
>>>>>>          if (adev->flags & AMD_IS_APU) {
>>>>>> -             if (adev->gmc.real_vram_size < gtt_size)
>>>>>> +             if (adev->gmc.real_vram_size < gtt_size &&
>>>>>> +                     adev->gmc.real_vram_size < max_system_mem_limit)
>>>>>>                          adev->apu_prefer_gtt = true;
>>>>>>          }
>>>>>>
>>>>>
>>>>
>>>
>>
> 

