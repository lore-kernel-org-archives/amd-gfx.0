Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12FBC05027
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 10:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D977410E08E;
	Fri, 10 Feb 2023 10:25:33 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2CF610E08E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 10:25:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXplvv6r4vvVCb26gosaWrMZQEr6jUNdm6AD4Odl0ZeHBhRpKYKPU3h7V/yW3SJvq1imqZBcCVx2ZVq2Mcl3wmSAqFWMjbfMKgMAxj9+7cL4bY2CoOz9ECMgX3Cls3hZmHGqrmcCYDh4mfNBFHhA9b9PXEgEuyT38/pn0DtV2jGdveM2SoOMCd01pgS/nCjZwtd8GUpcdMg7hKbd/76PM7QiHctI/uYB3z5KycNHgUYkdWd839hynaeh1pJOcZgv+QajU1Ryg08D3MHW8xGF4wfiQM1A6iTh3p6EP5biKyvIlI3pdhS3NHxvMWfBK0TkEN/WhXeMK6YPFcQ9KZdexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nh401ZbHZ90a9C9EmgzKIGWceO6ci2Fspi5s+vuSon8=;
 b=LVtEGu7jjZoP61ZA17otrU/kLafVkzZWG/DQuIQTqANi+JuuPgWFHNxuK7Ws6Af657NKoTHN+C0nqYn9IPJSdGmruZUhcuioDJEl4oU6cIuT7aUjTf+07lqWEmA2s89zeXJ8tpG64QkTohEoZTYkeF3bv1FfSktjMdZUoCo2Umbq1ja7N2Fa6p43VOHV4I4NQqywJWv50Foyt/Vg7GpBIUB2aPJBiL91O4WOdWACxDxWLnMIR7ZCE5Kn8BqfNV8Byktc5EQwYf/e7zxz4XO5EZwBP4tj8O9TirF4SGwpPSYlrsA6xYFiXqQuILB5hT9y+JazZOanweS5yOYsBAYvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nh401ZbHZ90a9C9EmgzKIGWceO6ci2Fspi5s+vuSon8=;
 b=cInLeqV0GrW5/fpnEyLKjslr10mzpnzheq0ns9srND8UF2n6t7zSgmiHTcd+yzd0kHojefq8BmeQ/EjqneGK8+VV7qP4A5AI5FBEr0dIT8lUoyqO3C07Q7iYFmQom6jkRo+76WTFXbWDJTww6QWrA2eb1Tr+mVoBwxPWv332mUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Fri, 10 Feb
 2023 10:25:29 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 10:25:28 +0000
Content-Type: multipart/alternative;
 boundary="------------uGfaZ0bDdE3eZIDOdHJx3PD2"
Message-ID: <e188b6c7-2996-3f3c-9a7b-dc95c1b17697@amd.com>
Date: Fri, 10 Feb 2023 11:25:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Content-Language: en-US
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230202095416.4039818-1-Jack.Xiao@amd.com>
 <BYAPR12MB35899E39061894E55AC07FE383D69@BYAPR12MB3589.namprd12.prod.outlook.com>
 <MW3PR12MB4458B37F3A4E9AF91F35279FEFD79@MW3PR12MB4458.namprd12.prod.outlook.com>
 <a4d8d310-c2e0-f2e5-74e8-fe8a5c34501e@gmail.com>
 <MW3PR12MB4458263C5E9B1071F7831EF7EFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
 <9ac594eb-9b59-02e1-fc7f-a745e28ff201@amd.com>
 <MW3PR12MB4458C18F7080280760953EACEFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
 <9cf6c24f-2b91-0431-6098-4ee2230ce57a@gmail.com>
 <DM6PR12MB26199592B7845FA8543B9134E4DE9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <29f0cd30-9af6-0bd9-fa13-80c52d8209fe@amd.com>
 <MW3PR12MB44588B8BD8DD804DA96DBC65EFDE9@MW3PR12MB4458.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW3PR12MB44588B8BD8DD804DA96DBC65EFDE9@MW3PR12MB4458.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9d5723-5030-4661-d501-08db0b51217d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0qgfyjNGi+f5/F09kcY9Fk4GcZRXWyMNQw6BeqbRldrxUZOLkkepCs51/9pFg462Cv4kJZN5Wa1JEA/ZdrlvarBXtLn5qXjmAIGsFbsYSL1MNqMSJ/Az6wdWRsfC/IRvuQw71wEiiAJ0WMOsLialc2EXuIkqyPGi84oJaZa3ANbKQIdm7xENRz5aKkKDv5tjpxgmquIyLNEvXasaau3SeOmoN2RxaTXc5GXhC1cCrZTrvyU307C4aCQQsZF22FuLwRA1Zk/jpj8KqfC5nrQ4KMvCTmFipAGUd+D6RtMVdD7ocGivNxtH6BAnEz9EBfwGFCs5e0UiPZzsrEpuOjaX/3x7nwhMr8xER/7JHrZFVvFPTTm2JUot0PgtcxSrVG7v0D6VJUmJxLF/OW5b69xBF8SUhO3MSXjfvK0e6o1k4Fwt0+XuO1VO4K055HmQ7x67c5j7SF+ijTN/mDgu7a934rmwBo7E5bdNceVYxMFYvWC1hZyOZBf21Df3P6eaT5occ323AeGKwLoreeJRShhRfz0LL3C80UEFkuP4vq0Ba1U0bw8Lja3OQiWDydU+lU4WuNp7EfplR38vau0lVqNt/ErilOyIEvPUKD2Mo3CA5jkRnkwN2RQjRKiqnCCxnx5XgDMEz3ErW7MAzITk7bgorPCpXB7zLJ+g5mOBHoEqfCeguyUyuUgnlUST2i/3Z1IS/UVxCp0h+SU8My2SPnf1k9f4ykSWww+5SZlObcr0+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199018)(31686004)(2906002)(33964004)(30864003)(8936002)(36756003)(5660300002)(41300700001)(83380400001)(66946007)(66556008)(66476007)(2616005)(66574015)(110136005)(86362001)(6512007)(6636002)(186003)(45080400002)(6506007)(31696002)(6486002)(38100700002)(53546011)(478600001)(8676002)(316002)(6666004)(45980500001)(43740500002)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skpkc2h3NVRLVm1mYnp3SnRRdjY2WnRNb0s2UHJMZDVkT2FrMllzZTlDZDJJ?=
 =?utf-8?B?Rncvb3BLM0x4akdHWFVHS04yMEhPVnJnc3FNZGdHYnNBVDVzRkRHS0x0Ym5R?=
 =?utf-8?B?Tnh6d0szd0xib1R0SjYrZm5sVjlnZTBSTFh0YnZDSjB5SWo2SEdQMWNrMnVm?=
 =?utf-8?B?OEd5T0hZZHd3TDZ3eE9aTWFySTMxbWFXWTZOemZWZUp3aXdFM0ZnNkt3by9E?=
 =?utf-8?B?bk9acVdkVUw2aCtDVTE0OU82UDNoWUVEb1g3bHhrSy9CZjFFdytXSXRiZkpC?=
 =?utf-8?B?R1ROMEdMSEluZUhldWdpcTNmMzAvQ0dSM3g2Q3R0RmtDSFRCQmFGUFpob1RC?=
 =?utf-8?B?ZzZzRTdadVpBZ21SSFRvMmIwTHMrL3BPditaZDRBQzNOZ3V3anVoZ0FoSk9n?=
 =?utf-8?B?LzY4MzlmMmg4bUYyOEtOVFFTcjgra2RKdi9QNlE1Y254TW9udjg3Zk9DTlBV?=
 =?utf-8?B?Z1BqQjMrOXNwOFRoVHZrRTkwVlJCOHdCOVlGdkxOSU45OU5hOXdDMi9JTnpD?=
 =?utf-8?B?eWYvY2dqTWNwOTNlVzBLMlpsNEdEamZJN3R5TXZONWVUbEx5Nk43Q1Z1cXVW?=
 =?utf-8?B?VzhWWWxieGY0Ykd0WnZIWWRXZ242M1U1aUphVklmUWVCU1lTcnRzN2JTZGRa?=
 =?utf-8?B?M1dIRDlsZm5KSG5MUjRTR0g1dE9UOU1lalF3YThWaDYvNkllNFBKUW82YStn?=
 =?utf-8?B?M2hLaVhRellIWHBFaUlHaDRHY25tcks1WEwzNTEydUpDdzFDUWZxY3I2ZGRh?=
 =?utf-8?B?cUFaaWRkVlc5cmxPclBXczhnV0RlTy9uOVJVUTdHNGlUdFBvU29rMzBXS2tw?=
 =?utf-8?B?NTI4WnAvb3ozc3c4R1orWG9VUDFWaFNUYm5SaExGWDRSQkVLSWZXZ3YyOVQw?=
 =?utf-8?B?Wm9zdWIxektBMzBvei9qVXJhVlk2VzRXK0IxMTJVTUpKNmVrQ3Y3WWQ3UVAv?=
 =?utf-8?B?V0hsVDFpR2dzVEhQK1NDR0YxWGNUY1BBZ2hpTjFIOUxCNGZ2cGk2UGpUdE9D?=
 =?utf-8?B?a0s1cWtXTklHWVdxcXlyTkt6YWN1bW1OVUI4SjFwTVhqYUxjaDAzdTlCTkZp?=
 =?utf-8?B?UmlESmdNN1ErUFJzcXJyRzRtcmxWQ1EyYS9laDZmcXVTTk1tUVNHZzBYZU1Z?=
 =?utf-8?B?TUpxM3RHckJQc3ZLRXBkWTRRTWszN09iV0N5NFR2OUpMOVdXSk5xYW51OEdt?=
 =?utf-8?B?RDhjVjhJNXFicjNUcWhmOFYxek5DaUxWUlNaaWEwZll3RnhtTHZ5aXRqeTFv?=
 =?utf-8?B?OHlqa0tVdjdQOWJIUzVmam9tVE1zakJEWllKQk1qSGdFeWlFa0NzVFFJc3Vv?=
 =?utf-8?B?bCtKZGZwejd3dXFpa0JQcEx2cmxadG9MLy82WHhESGhCajJPSDhBM0NKcjBD?=
 =?utf-8?B?SjdBMGNqTFd1N1UxZ0p2NUlKMWNMYUJvQWRhc2wvOWxQdHBvN3hpNUQwSGFL?=
 =?utf-8?B?QlkrMVAvU1lpYkVNeDJyV055NlVBOEdHait2UlJvbkxFdFkzT3hFamJwVGV3?=
 =?utf-8?B?WUVuMDJheHZlTmFiWVIzV1BVZGRKM3N2UkNHbzV6Kzh2Z3VBbmFLQXZWK0dN?=
 =?utf-8?B?TFZ3YkR0Y3l6QmxoQXVxZUYwR1ZuOVp1bmVuTjQ4S0Vibk5TMmhidnVQSHAy?=
 =?utf-8?B?MTRzQW50bHVzc09FbHhoUjZ3Z2lQeXBJUFFDMjVVTGRXK0xQMnFldlJLL21K?=
 =?utf-8?B?Uy9GLzUybS9iWW9LUHhsTm5WamhXQWljUkI0ZndxM3E4c0ljSHh4cjZXRHJn?=
 =?utf-8?B?WEpiT2tvcEFSUnVobGpBTVpIcHI2cm5QVmJsd3QwcGZFUHJzekZBd0VNZ0Mx?=
 =?utf-8?B?ZDZOSlFhbHZKeG1QZ2lublVDWU5YSHBydWZKdmtYTFhRemlwd3kwTktYNURY?=
 =?utf-8?B?Mi96NW1PUWJRNjhqUGtjTlhVRS8wZURWVWxzam1xaFNuT0oyK1d6aTlGU0d6?=
 =?utf-8?B?MjM5Q05lNld2NmhNb1VKSk9TWkszVHhrKzJYdHhpZFRIWlQyV29xOENrRnc0?=
 =?utf-8?B?VEg2M2tqTDdtSklJcFgrZDFEeUZvSkM5emxVYU43V09lcnB0OCtkbDJJbnJ1?=
 =?utf-8?B?aGZtOThVRXErTEF6MGRKOHhEcS95c3pNcEZSWGVURVgyRG5YTjNjQTM1ZGps?=
 =?utf-8?B?a1gwVzAySTFreG1mc3VhZEtlVVJVTkNFbDE1dThVamZTeS9RK28rcTFhNnhT?=
 =?utf-8?Q?sD5ZcI4B43tWvlmpck5OKa6gIZkGj9fMTKxw0fd/mMRn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9d5723-5030-4661-d501-08db0b51217d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 10:25:28.7708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KT8arNh2nquQlGVPtJpBHyenSwe8kkm2NVKTundiF7JT29VOOYZTSJCkaHUpoqRW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356
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

--------------uGfaZ0bDdE3eZIDOdHJx3PD2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jack,

Am 10.02.23 um 10:51 schrieb Xiao, Jack:
>
> [AMD Official Use Only - General]
>
>
> Hi Christian,
>
> >> Allocating buffers temporary for stuff like that is illegal during 
> resume.
>
> Can you **deeply** explain why it is illegal during ip late_init stage 
> which is a part stage of resume?
>

Well no, I don't have the time to explain this to everybody individually.

> In my understanding, after gmc ready, driver can allocate/free kernel 
> bo, and after SDMA ready,
>
> the eviction should be ready. What else prevent driver doing that 
> during resume?
>

The driver are resumed before the core Linux memory management is ready 
to serve allocations. E.g. swap for example isn't turned on yet.

This means that this stuff only worked because we were able to allocate 
memory from the pool which isn't guaranteed in any way.

> >> I strongly suggest to just remove the MES test. It's abusing the 
> kernel ring interface in a way we didn't want anyway and is currently 
> replaced by Shahanks work.
>
> The kernel mes unit test is very meaningful and important to catch MES 
> firmware issue at first time before
>
> issue went spread to other components like kfd/umd to avoid the 
> problem complicated, Otherwise, the issue
>
> would become hard to catch and debug.
>
> Secondly, for mes unit test is self-containing and no dependency, it 
> is a part of milestone to qualify MES ready,
>
> indicating that it can deliver to other component especially during 
> brinup. It is likely ring test and ib test indicating
>
> gfx is ready to go. After totally transitioning to gfx user queue, mes 
> unit test may be the only one unit test which
>
> can indicate gfx is ready at the very early stage of bringup when UMD 
> is not ready.
>

Alex and I are the maintainers of the driver who are deciding stuff like 
that and at least I don't really buy that argument. The ring, IB and 
benchmark tests are in the kernel module because they are simple.

If we have a complicated unit test like simulating creating an MES user 
queue to test the firmware functionality than that's really overkill. 
Especially when you need to allocate memory for it.

We previously had people requesting to add shader code and other 
complicated testing and rejected that as well because it just bloat up 
the kernel driver unnecessarily.

If we can modify the MES test to not abuse the amdgpu_ring structure 
only work with memory from the SA for example we could keep this, but 
not really in the current state.

Regards,
Christian.

> Regards,
>
> Jack
>
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Friday, February 10, 2023 4:08 PM
> *To:* Quan, Evan <Evan.Quan@amd.com>; Christian König 
> <ckoenig.leichtzumerken@gmail.com>; Xiao, Jack <Jack.Xiao@amd.com>; 
> amd-gfx@lists.freedesktop.org; Deucher, Alexander 
> <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA 
> is unavailable
>
> Hi Evan,
>
> yeah, exactly that's what this warning should prevent. Allocating 
> buffers temporary for stuff like that is illegal during resume.
>
> I strongly suggest to just remove the MES test. It's abusing the 
> kernel ring interface in a way we didn't want anyway and is currently 
> replaced by Shahanks work.
>
> Regards,
> Christian.
>
> Am 10.02.23 um 05:12 schrieb Quan, Evan:
>
>     [AMD Official Use Only - General]
>
>     Hi Jack,
>
>     Are you trying to fix the call trace popped up on resuming below?
>
>     It seems mes created some bo for its self test and freed it up
>     later at the final stage of the resuming process.
>
>     All these happened before the in_suspend flag cleared. And that
>     triggered the call trace.
>
>     Is my understanding correct?
>
>     [74084.799260] WARNING: CPU: 2 PID: 2891 at
>     drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:425
>     amdgpu_bo_free_kernel+0xfc/0x110 [amdgpu]
>
>     [74084.811019] Modules linked in: nls_iso8859_1 amdgpu(OE)
>     iommu_v2 gpu_sched drm_buddy drm_ttm_helper ttm drm_display_helper
>     drm_kms_helper i2c_algo_bit fb_sys_fops syscopyarea sysfillrect
>     sysimgblt snd_sm
>
>     [74084.811042]  ip_tables x_tables autofs4 hid_logitech_hidpp
>     hid_logitech_dj hid_generic e1000e usbhid ptp uas hid video
>     i2c_i801 ahci pps_core crc32_pclmul i2c_smbus usb_storage libahci wmi
>
>     [74084.914519] CPU: 2 PID: 2891 Comm: kworker/u16:38 Tainted: G
>            W IOE      6.0.0-custom #1
>
>     [74084.923146] Hardware name: ASUS System Product Name/PRIME
>     Z390-A, BIOS 2004 11/02/2021
>
>     [74084.931074] Workqueue: events_unbound async_run_entry_fn
>
>     [74084.936393] RIP: 0010:amdgpu_bo_free_kernel+0xfc/0x110 [amdgpu]
>
>     [74084.942422] Code: 00 4d 85 ed 74 08 49 c7 45 00 00 00 00 00 4d
>     85 e4 74 08 49 c7 04 24 00 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d
>     c3 cc cc cc cc <0f> 0b e9 39 ff ff ff 3d 00 fe ff ff 0f 85 75 96
>     47 00 ebf
>
>     [74084.961199] RSP: 0000:ffffbed6812ebb90 EFLAGS: 00010202
>
>     [74084.966435] RAX: 0000000000000000 RBX: ffffbed6812ebc50 RCX:
>     0000000000000000
>
>     [74084.973578] RDX: ffffbed6812ebc70 RSI: ffffbed6812ebc60 RDI:
>     ffffbed6812ebc50
>
>     [74084.980725] RBP: ffffbed6812ebbb8 R08: 0000000000000000 R09:
>     00000000000001ff
>
>     [74084.987869] R10: ffffbed6812ebb40 R11: 0000000000000000 R12:
>     ffffbed6812ebc70
>
>     [74084.995015] R13: ffffbed6812ebc60 R14: ffff963a2945cc00 R15:
>     ffff9639c7da5630
>
>     [74085.002160] FS: 0000000000000000(0000)
>     GS:ffff963d1dc80000(0000) knlGS:0000000000000000
>
>     [74085.010262] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>
>     [74085.016016] CR2: 0000000000000000 CR3: 0000000377c0a001 CR4:
>     00000000003706e0
>
>     [74085.023164] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>     0000000000000000
>
>     [74085.030307] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>     0000000000000400
>
>     [74085.037453] Call Trace:
>
>     [74085.039911]  <TASK>
>
>     [74085.042023] amdgpu_mes_self_test+0x385/0x460 [amdgpu]
>
>     [74085.047293] mes_v11_0_late_init+0x44/0x50 [amdgpu]
>
>     [74085.052291] amdgpu_device_ip_late_init+0x50/0x270 [amdgpu]
>
>     [74085.058032] amdgpu_device_resume+0xb0/0x2d0 [amdgpu]
>
>     [74085.063187] amdgpu_pmops_resume+0x37/0x70 [amdgpu]
>
>     [74085.068162]  pci_pm_resume+0x68/0x100
>
>     [74085.071836]  ? pci_legacy_resume+0x80/0x80
>
>     [74085.075943] dpm_run_callback+0x4c/0x160
>
>     [74085.079873]  device_resume+0xad/0x210
>
>     [74085.083546]  async_resume+0x1e/0x40
>
>     [74085.087046] async_run_entry_fn+0x30/0x120
>
>     [74085.091152] process_one_work+0x21a/0x3f0
>
>     [74085.095173]  worker_thread+0x50/0x3e0
>
>     [74085.098845]  ? process_one_work+0x3f0/0x3f0
>
>     [74085.103039]  kthread+0xfa/0x130
>
>     [74085.106189]  ? kthread_complete_and_exit+0x20/0x20
>
>     [74085.110993]  ret_from_fork+0x1f/0x30
>
>     [74085.114576]  </TASK>
>
>     [74085.116773] ---[ end trace 0000000000000000 ]---
>
>     BR
>
>     Evan
>
>     *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>     <mailto:amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of
>     *Christian König
>     *Sent:* Monday, February 6, 2023 5:00 PM
>     *To:* Xiao, Jack <Jack.Xiao@amd.com> <mailto:Jack.Xiao@amd.com>;
>     Koenig, Christian <Christian.Koenig@amd.com>
>     <mailto:Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org;
>     Deucher, Alexander <Alexander.Deucher@amd.com>
>     <mailto:Alexander.Deucher@amd.com>
>     *Subject:* Re: [PATCH] drm/amdgpu: only WARN freeing buffers when
>     DMA is unavailable
>
>     Am 06.02.23 um 09:28 schrieb Xiao, Jack:
>
>         [AMD Official Use Only - General]
>
>                        >> >> It's simply not allowed to free up
>         resources during suspend since those can't be acquired again
>         during resume.
>
>         >> The in_suspend flag is set at the beginning of suspend and
>         unset at the end of resume. It can’t filter the case you
>         mentioned.
>
>
>                        Why not? This is exactly what it should do.
>
>         [Jack] If freeing up resources during resume, it should not
>         hit the issue you described. But only checking in_suspend flag
>         would take these cases as warning.
>
>
>     No, once more: Freeing up or allocating resources between suspend
>     and resume is illegal!
>
>     If you free up a resource during resume you should absolutely hit
>     that, this is intentional!
>
>     Regards,
>     Christian.
>
>
>         Regards,
>
>         Jack
>
>         *From:* Koenig, Christian <Christian.Koenig@amd.com>
>         <mailto:Christian.Koenig@amd.com>
>         *Sent:* Monday, February 6, 2023 4:06 PM
>         *To:* Xiao, Jack <Jack.Xiao@amd.com>
>         <mailto:Jack.Xiao@amd.com>; Christian König
>         <ckoenig.leichtzumerken@gmail.com>
>         <mailto:ckoenig.leichtzumerken@gmail.com>;
>         amd-gfx@lists.freedesktop.org; Deucher, Alexander
>         <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>
>         *Subject:* Re: [PATCH] drm/amdgpu: only WARN freeing buffers
>         when DMA is unavailable
>
>         Am 06.02.23 um 08:23 schrieb Xiao, Jack:
>
>             [AMD Official Use Only - General]
>
>             >> Nope, that is not related to any hw state.
>
>             can use other flag.
>
>             >> It's simply not allowed to free up resources during
>             suspend since those can't be acquired again during resume.
>
>             The in_suspend flag is set at the beginning of suspend and
>             unset at the end of resume. It can’t filter the case you
>             mentioned.
>
>
>         Why not? This is exactly what it should do.
>
>
>             Do you know the root cause of these cases hitting the
>             issue? So that we can get an exact point to warn the
>             freeing up behavior.
>
>
>         Well the root cause are programming errors. See between
>         suspending and resuming you should not allocate nor free memory.
>
>         Otherwise we can run into trouble. And this check here is one
>         part of that, we should probably add another warning during
>         allocation of memory. But this here is certainly correct.
>
>         Regards,
>         Christian.
>
>
>             Thanks,
>
>             Jack
>
>             *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
>             <mailto:ckoenig.leichtzumerken@gmail.com>
>             *Sent:* Friday, February 3, 2023 9:20 PM
>             *To:* Xiao, Jack <Jack.Xiao@amd.com>
>             <mailto:Jack.Xiao@amd.com>; Koenig, Christian
>             <Christian.Koenig@amd.com>
>             <mailto:Christian.Koenig@amd.com>;
>             amd-gfx@lists.freedesktop.org; Deucher, Alexander
>             <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>
>             *Subject:* Re: [PATCH] drm/amdgpu: only WARN freeing
>             buffers when DMA is unavailable
>
>             Nope, that is not related to any hw state.
>
>             It's simply not allowed to free up resources during
>             suspend since those can't be acquired again during resume.
>
>             We had a couple of cases now where this was wrong. If you
>             get a warning from that please fix the code which tried to
>             free something during suspend instead.
>
>             Regards,
>             Christian.
>
>             Am 03.02.23 um 07:04 schrieb Xiao, Jack:
>
>                 [AMD Official Use Only - General]
>
>                 >> It's simply illegal to free up memory during suspend.
>
>                 Why? In my understanding, the limit was caused by DMA
>                 shutdown.
>
>                 Regards,
>
>                 Jack
>
>                 *From:* Koenig, Christian <Christian.Koenig@amd.com>
>                 <mailto:Christian.Koenig@amd.com>
>                 *Sent:* Thursday, February 2, 2023 7:43 PM
>                 *To:* Xiao, Jack <Jack.Xiao@amd.com>
>                 <mailto:Jack.Xiao@amd.com>;
>                 amd-gfx@lists.freedesktop.org; Deucher, Alexander
>                 <Alexander.Deucher@amd.com>
>                 <mailto:Alexander.Deucher@amd.com>
>                 *Subject:* AW: [PATCH] drm/amdgpu: only WARN freeing
>                 buffers when DMA is unavailable
>
>                 Big NAK to this! This warning is not related in any
>                 way to the hw state.
>
>                 It's simply illegal to free up memory during suspend.
>
>                 Regards,
>
>                 Christian.
>
>                 ------------------------------------------------------------------------
>
>                 *Von:*Xiao, Jack <Jack.Xiao@amd.com>
>                 *Gesendet:* Donnerstag, 2. Februar 2023 10:54
>                 *An:*
>                 amd-gfx@lists.freedesktop.org<amd-gfx@lists.freedesktop.org>;
>                 Deucher, Alexander <Alexander.Deucher@amd.com>;
>                 Koenig, Christian <Christian.Koenig@amd.com>
>                 *Cc:* Xiao, Jack <Jack.Xiao@amd.com>
>                 *Betreff:* [PATCH] drm/amdgpu: only WARN freeing
>                 buffers when DMA is unavailable
>
>                 Reduce waringings, only warn when DMA is unavailable.
>
>                 Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
>                 ---
>                  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
>                  1 file changed, 2 insertions(+), 1 deletion(-)
>
>                 diff --git
>                 a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>                 b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>                 index 2d237f3d3a2e..e3e3764ea697 100644
>                 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>                 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>                 @@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct
>                 amdgpu_bo **bo, u64 *gpu_addr,
>                          if (*bo == NULL)
>                                  return;
>
>                 - WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend);
>                 + WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend &&
>                 +
>                 !amdgpu_ttm_adev((*bo)->tbo.bdev)->ip_blocks[AMD_IP_BLOCK_TYPE_SDMA].status.hw);
>
>                          if (likely(amdgpu_bo_reserve(*bo, true) == 0)) {
>                                  if (cpu_addr)
>                 -- 
>                 2.37.3
>

--------------uGfaZ0bDdE3eZIDOdHJx3PD2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Jack,<br>
    <br>
    Am 10.02.23 um 10:51 schrieb Xiao, Jack:<br>
    <blockquote type="cite" cite="mid:MW3PR12MB44588B8BD8DD804DA96DBC65EFDE9@MW3PR12MB4458.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style>@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p class="msipheaderdf3d92d6" style="margin:0" align="Left"><span style="font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD
          Official Use Only - General]</span></p>
      <br>
      <div class="WordSection1">
        <p class="MsoNormal">Hi Christian,<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">&gt;&gt; Allocating buffers temporary for
          stuff like that is illegal during resume.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Can you *<b>deeply</b>* explain why it is
          illegal during ip late_init stage which is a part stage of
          resume?</p>
      </div>
    </blockquote>
    <br>
    Well no, I don't have the time to explain this to everybody
    individually.<br>
    <br>
    <blockquote type="cite" cite="mid:MW3PR12MB44588B8BD8DD804DA96DBC65EFDE9@MW3PR12MB4458.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal">In my understanding, after gmc ready,
          driver can allocate/free kernel bo, and after SDMA ready,
          <o:p></o:p></p>
        <p class="MsoNormal">the eviction should be ready. What else
          prevent driver doing that during resume?</p>
      </div>
    </blockquote>
    <br>
    The driver are resumed before the core Linux memory management is
    ready to serve allocations. E.g. swap for example isn't turned on
    yet.<br>
    <br>
    This means that this stuff only worked because we were able to
    allocate memory from the pool which isn't guaranteed in any way. <br>
    <br>
    <blockquote type="cite" cite="mid:MW3PR12MB44588B8BD8DD804DA96DBC65EFDE9@MW3PR12MB4458.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">&gt;&gt; I strongly suggest to just remove
          the MES test. It's abusing the kernel ring interface in a way
          we didn't want anyway and is currently replaced by Shahanks
          work.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">The kernel mes unit test is very meaningful
          and important to catch MES firmware issue at first time before
          <o:p></o:p></p>
        <p class="MsoNormal">issue went spread to other components like
          kfd/umd to avoid the problem complicated, Otherwise, the issue
          <o:p></o:p></p>
        <p class="MsoNormal">would become hard to catch and debug. <o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Secondly, for mes unit test is
          self-containing and no dependency, it is a part of milestone
          to qualify MES ready,<o:p></o:p></p>
        <p class="MsoNormal">indicating that it can deliver to other
          component especially during brinup. It is likely ring test and
          ib test indicating
          <o:p></o:p></p>
        <p class="MsoNormal">gfx is ready to go. After totally
          transitioning to gfx user queue, mes unit test may be the only
          one unit test which<o:p></o:p></p>
        <p class="MsoNormal">can indicate gfx is ready at the very early
          stage of bringup when UMD is not ready.</p>
      </div>
    </blockquote>
    <br>
    Alex and I are the maintainers of the driver who are deciding stuff
    like that and at least I don't really buy that argument. The ring,
    IB and benchmark tests are in the kernel module because they are
    simple.<br>
    <br>
    If we have a complicated unit test like simulating creating an MES
    user queue to test the firmware functionality than that's really
    overkill. Especially when you need to allocate memory for it.<br>
    <br>
    We previously had people requesting to add shader code and other
    complicated testing and rejected that as well because it just bloat
    up the kernel driver unnecessarily.<br>
    <br>
    If we can modify the MES test to not abuse the amdgpu_ring structure
    only work with memory from the SA for example we could keep this,
    but not really in the current state.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:MW3PR12MB44588B8BD8DD804DA96DBC65EFDE9@MW3PR12MB4458.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Regards,<o:p></o:p></p>
        <p class="MsoNormal">Jack<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a> <br>
              <b>Sent:</b> Friday, February 10, 2023 4:08 PM<br>
              <b>To:</b> Quan, Evan <a class="moz-txt-link-rfc2396E" href="mailto:Evan.Quan@amd.com">&lt;Evan.Quan@amd.com&gt;</a>; Christian
              König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>; Xiao, Jack
              <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>;
              Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN freeing
              buffers when DMA is unavailable<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt">Hi Evan,<br>
          <br>
          yeah, exactly that's what this warning should prevent.
          Allocating buffers temporary for stuff like that is illegal
          during resume.<br>
          <br>
          I strongly suggest to just remove the MES test. It's abusing
          the kernel ring interface in a way we didn't want anyway and
          is currently replaced by Shahanks work.<br>
          <br>
          Regards,<br>
          Christian.<o:p></o:p></p>
        <div>
          <p class="MsoNormal">Am 10.02.23 um 05:12 schrieb Quan, Evan:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="msipheaderdf3d92d6" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
              Official Use Only - General]</span><o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">Hi Jack,<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">Are you trying to fix the call trace
            popped up on resuming below?<o:p></o:p></p>
          <p class="MsoNormal">It seems mes created some bo for its self
            test and freed it up later at the final stage of the
            resuming process.
            <o:p></o:p></p>
          <p class="MsoNormal">All these happened before the in_suspend
            flag cleared. And that triggered the call trace.<o:p></o:p></p>
          <p class="MsoNormal">Is my understanding correct?<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">[74084.799260] WARNING: CPU: 2 PID: 2891
            at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:425
            amdgpu_bo_free_kernel+0xfc/0x110 [amdgpu]<o:p></o:p></p>
          <p class="MsoNormal">[74084.811019] Modules linked in:
            nls_iso8859_1 amdgpu(OE) iommu_v2 gpu_sched drm_buddy
            drm_ttm_helper ttm drm_display_helper drm_kms_helper
            i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt
            snd_sm<o:p></o:p></p>
          <p class="MsoNormal">[74084.811042]&nbsp; ip_tables x_tables
            autofs4 hid_logitech_hidpp hid_logitech_dj hid_generic
            e1000e usbhid ptp uas hid video i2c_i801 ahci pps_core
            crc32_pclmul i2c_smbus usb_storage libahci wmi<o:p></o:p></p>
          <p class="MsoNormal">[74084.914519] CPU: 2 PID: 2891 Comm:
            kworker/u16:38 Tainted: G &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;W IOE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.0.0-custom #1<o:p></o:p></p>
          <p class="MsoNormal">[74084.923146] Hardware name: ASUS System
            Product Name/PRIME Z390-A, BIOS 2004 11/02/2021<o:p></o:p></p>
          <p class="MsoNormal">[74084.931074] Workqueue: events_unbound
            async_run_entry_fn<o:p></o:p></p>
          <p class="MsoNormal">[74084.936393] RIP:
            0010:amdgpu_bo_free_kernel+0xfc/0x110 [amdgpu]<o:p></o:p></p>
          <p class="MsoNormal">[74084.942422] Code: 00 4d 85 ed 74 08 49
            c7 45 00 00 00 00 00 4d 85 e4 74 08 49 c7 04 24 00 00 00 00
            5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc &lt;0f&gt; 0b
            e9 39 ff ff ff 3d 00 fe ff ff 0f 85 75 96 47 00 ebf<o:p></o:p></p>
          <p class="MsoNormal">[74084.961199] RSP: 0000:ffffbed6812ebb90
            EFLAGS: 00010202<o:p></o:p></p>
          <p class="MsoNormal">[74084.966435] RAX: 0000000000000000 RBX:
            ffffbed6812ebc50 RCX: 0000000000000000<o:p></o:p></p>
          <p class="MsoNormal">[74084.973578] RDX: ffffbed6812ebc70 RSI:
            ffffbed6812ebc60 RDI: ffffbed6812ebc50<o:p></o:p></p>
          <p class="MsoNormal">[74084.980725] RBP: ffffbed6812ebbb8 R08:
            0000000000000000 R09: 00000000000001ff<o:p></o:p></p>
          <p class="MsoNormal">[74084.987869] R10: ffffbed6812ebb40 R11:
            0000000000000000 R12: ffffbed6812ebc70<o:p></o:p></p>
          <p class="MsoNormal">[74084.995015] R13: ffffbed6812ebc60 R14:
            ffff963a2945cc00 R15: ffff9639c7da5630<o:p></o:p></p>
          <p class="MsoNormal">[74085.002160] FS:&nbsp;
            0000000000000000(0000) GS:ffff963d1dc80000(0000)
            knlGS:0000000000000000<o:p></o:p></p>
          <p class="MsoNormal">[74085.010262] CS:&nbsp; 0010 DS: 0000 ES:
            0000 CR0: 0000000080050033<o:p></o:p></p>
          <p class="MsoNormal">[74085.016016] CR2: 0000000000000000 CR3:
            0000000377c0a001 CR4: 00000000003706e0<o:p></o:p></p>
          <p class="MsoNormal">[74085.023164] DR0: 0000000000000000 DR1:
            0000000000000000 DR2: 0000000000000000<o:p></o:p></p>
          <p class="MsoNormal">[74085.030307] DR3: 0000000000000000 DR6:
            00000000fffe0ff0 DR7: 0000000000000400<o:p></o:p></p>
          <p class="MsoNormal">[74085.037453] Call Trace:<o:p></o:p></p>
          <p class="MsoNormal">[74085.039911]&nbsp; &lt;TASK&gt;<o:p></o:p></p>
          <p class="MsoNormal">[74085.042023]&nbsp;
            amdgpu_mes_self_test+0x385/0x460 [amdgpu]<o:p></o:p></p>
          <p class="MsoNormal">[74085.047293]&nbsp;
            mes_v11_0_late_init+0x44/0x50 [amdgpu]<o:p></o:p></p>
          <p class="MsoNormal">[74085.052291]&nbsp;
            amdgpu_device_ip_late_init+0x50/0x270 [amdgpu]<o:p></o:p></p>
          <p class="MsoNormal">[74085.058032]&nbsp;
            amdgpu_device_resume+0xb0/0x2d0 [amdgpu]<o:p></o:p></p>
          <p class="MsoNormal">[74085.063187]&nbsp;
            amdgpu_pmops_resume+0x37/0x70 [amdgpu]<o:p></o:p></p>
          <p class="MsoNormal">[74085.068162]&nbsp; pci_pm_resume+0x68/0x100<o:p></o:p></p>
          <p class="MsoNormal">[74085.071836]&nbsp; ?
            pci_legacy_resume+0x80/0x80<o:p></o:p></p>
          <p class="MsoNormal">[74085.075943]&nbsp;
            dpm_run_callback+0x4c/0x160<o:p></o:p></p>
          <p class="MsoNormal">[74085.079873]&nbsp; device_resume+0xad/0x210<o:p></o:p></p>
          <p class="MsoNormal">[74085.083546]&nbsp; async_resume+0x1e/0x40<o:p></o:p></p>
          <p class="MsoNormal">[74085.087046]&nbsp;
            async_run_entry_fn+0x30/0x120<o:p></o:p></p>
          <p class="MsoNormal">[74085.091152]&nbsp;
            process_one_work+0x21a/0x3f0<o:p></o:p></p>
          <p class="MsoNormal">[74085.095173]&nbsp; worker_thread+0x50/0x3e0<o:p></o:p></p>
          <p class="MsoNormal">[74085.098845]&nbsp; ?
            process_one_work+0x3f0/0x3f0<o:p></o:p></p>
          <p class="MsoNormal">[74085.103039]&nbsp; kthread+0xfa/0x130<o:p></o:p></p>
          <p class="MsoNormal">[74085.106189]&nbsp; ?
            kthread_complete_and_exit+0x20/0x20<o:p></o:p></p>
          <p class="MsoNormal">[74085.110993]&nbsp; ret_from_fork+0x1f/0x30<o:p></o:p></p>
          <p class="MsoNormal">[74085.114576]&nbsp; &lt;/TASK&gt;<o:p></o:p></p>
          <p class="MsoNormal">[74085.116773] ---[ end trace
            0000000000000000 ]---<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">BR<o:p></o:p></p>
          <p class="MsoNormal">Evan<o:p></o:p></p>
          <div style="border:none;border-left:solid blue
            1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b>From:</b> amd-gfx <a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">
                    &lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> <b>On
                    Behalf Of </b>Christian König<br>
                  <b>Sent:</b> Monday, February 6, 2023 5:00 PM<br>
                  <b>To:</b> Xiao, Jack <a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true">&lt;Jack.Xiao@amd.com&gt;</a>;
                  Koenig, Christian
                  <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                  <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">
                    amd-gfx@lists.freedesktop.org</a>; Deucher,
                  Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                    &lt;Alexander.Deucher@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN
                  freeing buffers when DMA is unavailable<o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            <p class="MsoNormal" style="margin-bottom:12.0pt">Am
              06.02.23 um 09:28 schrieb Xiao, Jack:<o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="msipheaderdf3d92d6" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                  Official Use Only - General]</span><o:p></o:p></p>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              <p class="MsoNormal" style="margin-bottom:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt;&gt; It's simply not allowed
                to free up resources during suspend since those can't be
                acquired again during resume.<o:p></o:p></p>
              <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &gt;&gt; The in_suspend flag is set at the beginning of
                suspend and unset at the end of resume. It can’t filter
                the case you mentioned.<o:p></o:p></p>
              <p class="MsoNormal"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Why not? This is exactly what it should
                do.<o:p></o:p></p>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              <p class="MsoNormal">[Jack] If freeing up resources during
                resume, it should not hit the issue you described. But
                only checking in_suspend flag would take these cases as
                warning.<o:p></o:p></p>
            </blockquote>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
              No, once more: Freeing up or allocating resources between
              suspend and resume is illegal!<br>
              <br>
              If you free up a resource during resume you should
              absolutely hit that, this is intentional!<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              <br>
              <o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              <p class="MsoNormal">Regards,<o:p></o:p></p>
              <p class="MsoNormal">Jack<o:p></o:p></p>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              <div>
                <div style="border:none;border-top:solid #E1E1E1
                  1.0pt;padding:3.0pt 0in 0in 0in">
                  <p class="MsoNormal"><b>From:</b> Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                      &lt;Christian.Koenig@amd.com&gt;</a> <br>
                    <b>Sent:</b> Monday, February 6, 2023 4:06 PM<br>
                    <b>To:</b> Xiao, Jack <a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true">&lt;Jack.Xiao@amd.com&gt;</a>;
                    Christian König
                    <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>;
                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                    Deucher, Alexander
                    <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN
                    freeing buffers when DMA is unavailable<o:p></o:p></p>
                </div>
              </div>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              <p class="MsoNormal" style="margin-bottom:12.0pt">Am
                06.02.23 um 08:23 schrieb Xiao, Jack:<o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="msipheaderdf3d92d6" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                    Official Use Only - General]</span><o:p></o:p></p>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <p class="MsoNormal">&gt;&gt; Nope, that is not related
                  to any hw state.<o:p></o:p></p>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <p class="MsoNormal">can use other flag.<o:p></o:p></p>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <p class="MsoNormal" style="margin-bottom:12.0pt">&gt;&gt;
                  It's simply not allowed to free up resources during
                  suspend since those can't be acquired again during
                  resume.<o:p></o:p></p>
                <p class="MsoNormal">The in_suspend flag is set at the
                  beginning of suspend and unset at the end of resume.
                  It can’t filter the case you mentioned.<o:p></o:p></p>
              </blockquote>
              <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                Why not? This is exactly what it should do.<br>
                <br>
                <br>
                <o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="MsoNormal">Do you know the root cause of these
                  cases hitting the issue? So that we can get an exact
                  point to warn the freeing up behavior.<o:p></o:p></p>
              </blockquote>
              <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                Well the root cause are programming errors. See between
                suspending and resuming you should not allocate nor free
                memory.<br>
                <br>
                Otherwise we can run into trouble. And this check here
                is one part of that, we should probably add another
                warning during allocation of memory. But this here is
                certainly correct.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                <br>
                <o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <p class="MsoNormal">Thanks,<o:p></o:p></p>
                <p class="MsoNormal">Jack<o:p></o:p></p>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <div>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="MsoNormal"><b>From:</b> Christian König <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">
                        &lt;ckoenig.leichtzumerken@gmail.com&gt;</a> <br>
                      <b>Sent:</b> Friday, February 3, 2023 9:20 PM<br>
                      <b>To:</b> Xiao, Jack <a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true">&lt;Jack.Xiao@amd.com&gt;</a>;
                      Koenig, Christian
                      <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                      <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">
                        amd-gfx@lists.freedesktop.org</a>; Deucher,
                      Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                        &lt;Alexander.Deucher@amd.com&gt;</a><br>
                      <b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN
                      freeing buffers when DMA is unavailable<o:p></o:p></p>
                  </div>
                </div>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <p class="MsoNormal" style="margin-bottom:12.0pt">Nope,
                  that is not related to any hw state.<br>
                  <br>
                  It's simply not allowed to free up resources during
                  suspend since those can't be acquired again during
                  resume.<br>
                  <br>
                  We had a couple of cases now where this was wrong. If
                  you get a warning from that please fix the code which
                  tried to free something during suspend instead.<br>
                  <br>
                  Regards,<br>
                  Christian.<o:p></o:p></p>
                <div>
                  <p class="MsoNormal">Am 03.02.23 um 07:04 schrieb
                    Xiao, Jack:<o:p></o:p></p>
                </div>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <p class="msipheaderdf3d92d6" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                      Official Use Only - General]</span><o:p></o:p></p>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <p class="MsoNormal">&gt;&gt; It's simply illegal to
                    free up memory during suspend.<o:p></o:p></p>
                  <p class="MsoNormal">Why? In my understanding, the
                    limit was caused by DMA shutdown.<o:p></o:p></p>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <p class="MsoNormal">Regards,<o:p></o:p></p>
                  <p class="MsoNormal">Jack<o:p></o:p></p>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <div>
                    <div style="border:none;border-top:solid #E1E1E1
                      1.0pt;padding:3.0pt 0in 0in 0in">
                      <p class="MsoNormal"><b>From:</b> Koenig,
                        Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                          &lt;Christian.Koenig@amd.com&gt;</a> <br>
                        <b>Sent:</b> Thursday, February 2, 2023 7:43 PM<br>
                        <b>To:</b> Xiao, Jack <a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true">&lt;Jack.Xiao@amd.com&gt;</a>;
                        <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                        Deucher, Alexander
                        <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                        <b>Subject:</b> AW: [PATCH] drm/amdgpu: only
                        WARN freeing buffers when DMA is unavailable<o:p></o:p></p>
                    </div>
                  </div>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <div>
                    <p class="MsoNormal">Big NAK to this! This warning
                      is not related in any way to the hw state.<o:p></o:p></p>
                  </div>
                  <div>
                    <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  </div>
                  <div>
                    <p class="MsoNormal">It's simply illegal to free up
                      memory during suspend.<o:p></o:p></p>
                  </div>
                  <div>
                    <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  </div>
                  <div>
                    <p class="MsoNormal">Regards,<o:p></o:p></p>
                  </div>
                  <div>
                    <p class="MsoNormal">Christian.<o:p></o:p></p>
                  </div>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <div class="MsoNormal" style="text-align:center" align="center">
                    <hr width="98%" size="2" align="center">
                  </div>
                  <div id="divRplyFwdMsg">
                    <p class="MsoNormal"><b><span style="color:black">Von:</span></b><span style="color:black"> Xiao, Jack &lt;</span><a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Jack.Xiao@amd.com</a><span style="color:black">&gt;<br>
                        <b>Gesendet:</b> Donnerstag, 2. Februar 2023
                        10:54<br>
                        <b>An:</b> </span><a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><span style="color:black"> &lt;</span><a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><span style="color:black">&gt;; Deucher, Alexander
                        &lt;</span><a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Alexander.Deucher@amd.com</a><span style="color:black">&gt;; Koenig, Christian &lt;</span><a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Christian.Koenig@amd.com</a><span style="color:black">&gt;<br>
                        <b>Cc:</b> Xiao, Jack &lt;</span><a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Jack.Xiao@amd.com</a><span style="color:black">&gt;<br>
                        <b>Betreff:</b> [PATCH] drm/amdgpu: only WARN
                        freeing buffers when DMA is unavailable</span>
                      <o:p></o:p></p>
                    <div>
                      <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                    </div>
                  </div>
                  <div>
                    <div>
                      <p class="MsoNormal" style="margin-bottom:12.0pt">Reduce
                        waringings, only warn when DMA is unavailable.<br>
                        <br>
                        Signed-off-by: Jack Xiao &lt;<a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Jack.Xiao@amd.com</a>&gt;<br>
                        ---<br>
                        &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3
                        ++-<br>
                        &nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
                        <br>
                        diff --git
                        a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
                        b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                        index 2d237f3d3a2e..e3e3764ea697 100644<br>
                        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                        @@ -422,7 +422,8 @@ void
                        amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64
                        *gpu_addr,<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*bo == NULL)<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
                        &nbsp;<br>
                        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;in_suspend);<br>
                        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;in_suspend
                        &amp;&amp;<br>
                        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
!amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;ip_blocks[AMD_IP_BLOCK_TYPE_SDMA].status.hw);<br>
                        &nbsp;<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(amdgpu_bo_reserve(*bo, true)
                        == 0)) {<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu_addr)<br>
                        -- <br>
                        2.37.3<o:p></o:p></p>
                    </div>
                  </div>
                </blockquote>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              </blockquote>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            </blockquote>
            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          </div>
        </blockquote>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------uGfaZ0bDdE3eZIDOdHJx3PD2--
