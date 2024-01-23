Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C3BC47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 12:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8659110E79A;
	Tue, 23 Jan 2024 12:50:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9425C10E78E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 12:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ingI436tOPqANAGLyXxCF2WIMA8PkNxwx6vZtU/ffsKMix5pU7E9ljx8gQF0t0zDQ6sjnHKvQn+He4WBGDuNCgc+p8vzmQwffIJ0murzHk1Z6i51z3GxldPcI/jcx5bw9PPNOcyL09ecwTUloYqLOdsXroIZ6tO0cvAhMNzHkNq//sqmRujOmkiWRLhWUxxSGNTrfJNBXsPiSeLKZA4Cm9h8tb27Rvvw43TBY3T2P7WB3raMJsfuQQMrQFNGaKN5l9OrCSnjf9ZGUwMT6f72E6sZgD7zrXSEoXRfBhFhB9YkWxI24oHHTrObJtgNY3I1ZKASFI3Kyxq5lkguZqlpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbmLF9hWGj6Q8w0KKKwJnHIBmC6ZMaEl1uXo/sNBNHY=;
 b=H59+MNfhSRnNnyH7OhiRrEwnwTLe3oIU5YMiqyl23EktBOmmQ9Aoolp1gWzX6Sgx9gnU54phtkeJLi6cZLC0EMOVvdPEXRC5JP86qopjoUENBj2vNx7zB+yilcX/obJ/2ny8eI0F4+pVeyUxvcHd49Mjal1XCkkCIXkx5zqtnmw8BSU7qMuN9cS8Z2/En8WukELdDWki4I/rGyaHZxXuSsg8PsgGMpvb134E0qb5r1RDWRiSsvQIyokx9rT4Am3O3rvdgMtvTezFJy52gkEu+p/pzRjI+IDs1wvc0PlJFatc2N1jRziFKTjr4U8ATBVnTDMGu96XOkmMaW+MMKUhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbmLF9hWGj6Q8w0KKKwJnHIBmC6ZMaEl1uXo/sNBNHY=;
 b=yOzo42oCTb5eX7N/ZpCwDhYsSzw+Lu6DQSBxln5gSbk9g68qy+nAqIoLIpn2jDeNiI8rEDtU9IlZqAPNxm5IuJlsegS5vlaelhK4TClbvMd5FVL5NEgjF6vX33uDQmSbxrJ527CV0c0THardkc7rsNaS0EYQkyMGGcxsjFllST8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Tue, 23 Jan
 2024 12:50:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 12:50:04 +0000
Message-ID: <7483cddf-010e-4df0-80ed-468f744449d8@amd.com>
Date: Tue, 23 Jan 2024 13:49:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>, Joshua Ashton <joshua@froggi.es>, 
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
 <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
 <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
 <d15ac325-e830-4e11-a239-56eaeddecae8@gmx.de>
 <e977939c-db01-4b14-8494-0bdad5be7a8a@gmail.com>
 <CADnq5_Nb=ruoA2j-mHrQbxHY=yzwGm2kKjDiQ+ajk3urKKLing@mail.gmail.com>
 <42af4788-10bb-4107-bd1a-05f15dc9c1fa@gmx.de>
 <4d3e3c70-3307-4068-9416-613a19f587d4@gmail.com>
 <6590bae2-406d-4f45-a3e9-5dc6653925cf@amd.com>
 <0db29a99-f434-4886-9204-54eafaefa31a@amd.com>
 <60efdecd-0957-4e06-9f1e-7343dff87a8a@gmx.de>
 <098e975b-2271-4f11-9549-40bc2c444a28@gmx.de>
 <d45b23d1-ab1d-4285-8b18-a0eebaa2d871@amd.com>
 <dc8506c4-9114-473e-bfdc-8a24f2264392@froggi.es>
 <2906c98e-47fe-4a39-b32d-9d060d571076@amd.com>
 <e8d1bca4-61f1-4b44-b70b-c66f8b095860@gmx.de>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e8d1bca4-61f1-4b44-b70b-c66f8b095860@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cebc12d-3bbc-4945-ba7a-08dc1c11d20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9K2AnyVT+ej9xCImVI4NC7QS7gc6pOs/gzXeJEMhhBlaOVFQIoiaRuwcMPHBAyV97isLC7/sSefmiw1D3PyzzuiHxZ0Pk5c3neKXsSKbopTCDqC6rl96XLd9XfnOhvVk3Qrh/O69YijyeBI/+RDiRGfuOfzxfekL9FiKj0vjARcWY0KVa1BcCpSY19V6eD0Vackqqh6J/CMxrlf02f60f5oiNvlLkJ2ktXs2S8z0J+VI1+hWqpur6zLx2JPycXKiaYVEemX6loCt09EBtmwqmnzI0IlOvK0gepXRfq5PFRHEf2jKx1c8eqCVt8A26t4dQV2a3yMptXvwRej5yXFxiDj1jsAa1Et14sG5idPkeuyR3eaM2WMH0NUNCQed0VC8VQGBCjKw9LlLzTgKIWsYYmTafU8vS18yQdDhcN0OvkbMISIdIWhwHNWSmodZlWOf9t5Qge5Kz+MUQN6Im55ec0/UDdlSel0WBEmroSL7gOAoPJg6b2xDMTF8aqFstwUz66z4FhjYWHsiqg2/6mZQjAw8BNlJgdiJZdUFQwDXmZighkq1qGXGuq8VbE1SSSbUNV1MRdntWCltn9a05LMYEH6paulTsWmDI7XRVA/fcYwz9wQXowMcGioi75HLRUY+p+0VUqUC5LtvVAToVpYAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66476007)(6486002)(66946007)(8936002)(110136005)(31696002)(478600001)(4326008)(83380400001)(38100700002)(8676002)(2616005)(6666004)(6506007)(6512007)(26005)(66556008)(6636002)(53546011)(86362001)(316002)(66574015)(36756003)(2906002)(5660300002)(31686004)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkdoeDV6WW1DWkl4Mjh1L3N5UjhMSWkvdlFqYnhHZFEzSGEvUFFnRnIvSjFM?=
 =?utf-8?B?ZVVRVXplbnVWSk1lbXptRFlxNXRWc3NaelRaNlNDcXRadlA1NHJFeFZvd05O?=
 =?utf-8?B?NWxoVU5aMnV5Q3RsOWo0Sy8yYWo3TUliSDFNWVBmNFBTU3NVazlkQTVwcjlW?=
 =?utf-8?B?TUh4NGFnUnhLZ09lS3M0NEtmVjN4elZuTW50M2EyRnBwT0RNNzZIczI2a2s0?=
 =?utf-8?B?czFWU1pXZ1QwUzk1L0Zyd3NPUUFmR0hZYWxjUXVhTFU3aXg3S1NUbXZzbS85?=
 =?utf-8?B?NXFSb3RhUEZvcmhjQ2xKT012UlhaY2cvVExVK3B4V1pTNXJyamRYQURyWWlh?=
 =?utf-8?B?ME9jbVVqNlJZT1FIOVBGeDdxT0o5WDBsSVVEMThMdEpuMDMwemZQM3RqL2s3?=
 =?utf-8?B?WFZCSUhQN1JJamFJQnBqZXFCV2RRWTFLdHZvbVFZcVNXbjBtTkdUK2gvVWh1?=
 =?utf-8?B?Zk1tbk42MnBQbnFzTUExS3lGNXljQnBMYThJaTBQSWZvSTZrQ3pwcEQrOGtK?=
 =?utf-8?B?M1pxaWxMc0NVQXRwU2JjemlvUEgzTnEzdlpLWlp1aGN0UUpjSGZzN0xkVEsr?=
 =?utf-8?B?cjJnNUpXWDJZUlVmZUpCd2t3cURwVjBESHVyZzlsV2NNZTN4SmpXcDlVcGdz?=
 =?utf-8?B?Z0dnZ3g5S0pvM1J1Q1lpTU5vcCtOZWQ4a2JaY3kyNkg2M2hRVUkzVjczUzRE?=
 =?utf-8?B?eUxnS1FLaU1DcThPa3MrbHZxd294SlJQZkswUGNhNWJCZ1NMU2ZINVNrMzZx?=
 =?utf-8?B?UThpVFNBRWoxSDdMNCt3VmJGLzhYc20yUGQwdFhDUGxTL0dCRWRlbWV4RlMz?=
 =?utf-8?B?MXEwVFFLUmFyNU05RHdwdU1sQWxQdzRlRC8xRG9tUlZrUXN4SmJZK21Mcmtl?=
 =?utf-8?B?dDFwbGlWUlFLT3BiRm5kem5qc0NITzVRVjVFTVYrUmlKZ0Z0cEVYRjJPSHl1?=
 =?utf-8?B?VW90RVRWWkw0UkU3MllCR3VPSmNFU0J2a1dMSU1YdjlRYm05L2lkVDZMNjB2?=
 =?utf-8?B?WCtnVFhPWUl5UXFUZE5JWTJOQWI0RVZ3OE1GdENjWE1TQVl1ZjZ0M0VjTElw?=
 =?utf-8?B?dUtnQlU4NnhmaFBYUEVuOFptTnlrZjVKVWg3WVJ5NUF3KzN6SnpPNTN1NWJi?=
 =?utf-8?B?WjhvRU1ZQ3p4aVhWamlMLy91RlIwK2MwWHJ6YWM0VUh3VXJTQ3RzTHIxa2R6?=
 =?utf-8?B?ejJaZlBySmFQT00rbjZrS0x4NnJNSzBuc20vQXRtR2o2dEU0S3oyYkhTVVJL?=
 =?utf-8?B?UTNtMFYzUG5hOFhjQ1I5VTl5dWkzRDJ5SFdqOUMzZlJVWVBmTnI5UE9KTHpN?=
 =?utf-8?B?bnVDdkJaUWdVRWJtSno5RHovMEhUanBCbXpFcCs1TTMzUTBwWDcvQXNPZ25q?=
 =?utf-8?B?RFIzQ2RiMEZpR3NYNDg2RkprVVl3TDR3MVdFYWprTzBIaHVCYzMyZHloUGJr?=
 =?utf-8?B?Nm1pVXNkQnliTitIdkt4cUFHSEYvUXhlMlVJM2k4djFFeVBlbVVKMXF6R0xk?=
 =?utf-8?B?TU1HVmxQYVA1VTc0VkZRR3d4cko3cmNIMHk2Wjc3SDVNUitrbXRTQjV2ZUZ5?=
 =?utf-8?B?Z3hEVFR0ekpEazhsLzJJVVFVUGJNQ0U3MDZMQW13ME9aQ2MzdUhvV1BBU0dC?=
 =?utf-8?B?ei8wdDJYaDd4Um1qMDN1WmZJMVBNQWQ1UzlzdW05K1UyUWV3My9TMys1TCtI?=
 =?utf-8?B?dFpHd1V5dmdkVlVhcDhIcUdTK2lyS01zd3lPNlEyc29uWHl6TlFWR0V1aWNN?=
 =?utf-8?B?QXZDaTdVMysyTWxHY3R3M0pTdGpIT25ScDc4aHJWU0oyWXl0cGprbXI0Kytp?=
 =?utf-8?B?RGpXUktMSkZwemd3QVdFM2pEdFdweEFTNnREZDg0TmROa1A2dzhVNEJxMkRw?=
 =?utf-8?B?NFBKM0xqOW0vVnltcEtJSnJkeVlhUzRReUZNMllHbytjT1Z1L204QktzMWVN?=
 =?utf-8?B?NjRSclpjWUk0N0xsSzRjWjFKNWNEY3FSekViRmtjRzJuSW1TS0xVd1l6OWZI?=
 =?utf-8?B?KzF3VnQ1YkgvYTJEU1JLR2Nla1ltZlZQSHplNjdlRHd2c1pxNjh6dFBBZ0VP?=
 =?utf-8?B?QkhlK2RYa3RqNUxHckJIOG9OR3lDZ0ltYmxNbTdSak1CalIvL0F4dExyNVBD?=
 =?utf-8?Q?vIDO96sKzbHXEKMOtVxy0mOde?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cebc12d-3bbc-4945-ba7a-08dc1c11d20c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 12:50:04.5884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ox1c57haRgDREqhC8P0ZfokWPt6/6foo81l6agX2ZXddPeuBHFXe9jKXTLo9I9ug
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.01.24 um 12:35 schrieb Friedrich Vock:
> On 23.01.24 10:36, Christian König wrote:
>>
>>
>> Am 22.01.24 um 23:39 schrieb Joshua Ashton:
>>> [SNIP]
>>>>>
>>>>> Most work submissions in practice submit more waves than the 
>>>>> number of
>>>>> wave slots the GPU has.
>>>>> As far as I understand soft recovery, the only thing it does is
>>>>> kill all
>>>>> active waves. This frees up the CUs so more waves are launched, which
>>>>> can fault again, and that leads to potentially lots of faults for a
>>>>> single wave slot in the end.
>>>>
>>>> Exactly that, but killing each wave takes a moment since we do that
>>>> in a loop with a bit delay in there.
>>>>
>>>> So the interrupt handler should at least in theory have time to
>>>> catch up.
>>>
>>> I don't think there is any delay in that loop is there?
>>
>> Mhm, looks like I remember that incorrectly.
>>
>>>
>>>     while (!dma_fence_is_signaled(fence) &&
>>>            ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>>>         ring->funcs->soft_recovery(ring, vmid);
>>>
>>> (soft_recovery function does not have a delay/sleep/whatever either)
>>>
>>> FWIW, two other changes we did in SteamOS to make recovery more
>>> reliable on VANGOGH was:
>>>
>>> 1) Move the timeout determination after the spinlock setting the
>>> fence error.
>>
>> Well that should not really have any effect.
>>
>>>
>>> 2) Raise the timeout from 0.1s to 1s.
>>
>> Well that's not necessarily a good idea. If the SQ isn't able to
>> respond in 100ms then I would really go into a hard reset.
>>
>> Waiting one extra second is way to long here.
>
> Bumping the timeout seemed to be necessary in order to reliably
> soft-recover from hangs with page faults. (Being able to soft-recover
> from these is actually a really good thing, because if e.g. games
> accidentally trigger faults, it won't kill a user's entire system.)

I still have an extremely bad feeling about that. From the discussions a 
wave which waits for a fault resolution can't be preempted nor killed.

So what most likely happens is that some of the state sticks around in 
the hw and can only be cleared with a hard recovery.

For the steam deck it might still be the better option but that is most 
likely not the best solution for every use case. It could for example be 
that the system doesn't have the full performance any more.

>
> However, the bump I had in mind was more moderate: Currently the timeout
> is 10ms (=0.01s). Bumping that to 0.1s already improves reliability
> enough. I agree that waiting a full second before giving up might be a
> bit too long.

Well we should never have a timeout longer than we would expect a 
submission to be. So assuming a minimum of 10fps we should never go over 
100ms or so.

If killing the waves takes longer than the original submission would 
have then there is most likely some state not correctly cleared in the 
hw and we really have to do a hard reset to clean up.

Regards,
Christian.

>
> Regards,
> Friedrich
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> - Joshie 🐸✨
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Regards,
>>>>> Friedrich
>>>
>>

