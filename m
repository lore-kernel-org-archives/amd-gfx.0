Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6C2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 17:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1915110F25B;
	Tue, 10 May 2022 17:19:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA8B010F1BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 17:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQZbTpjLequfaPh2Lk7Q4ozKmx/j/JikdkhvoYsems4Xt/b3/Dvm7IBUC1o6DlWPyemxrse05nP8Oi9gYrT84apnsEysEdVmYAWPXDZTM4bEYRZrjNSLPUKtCNaDROdnqRx2Vtie3vf3uIS1Ptxisn/9MH52B85Vss0+l9BMCVRh34DEGFtNsI5nPYzAeKyQU0EkjO+3oYaq1U62jweXlEx7aTYfWyqKHqEi7oVwHitvc3AM+DHuhTucEe2Z+bUTuWYyC+JaDrHrefdWzSELpLQtfWCW5mCDmEGg2d7Ru9Mc0ya1lDvhhgb3AqEqTr17bxkk5aH8C156Zb1mR6Melg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s85szzDH6CN7+93Q87AMKKqmU4a8WwxMWONSHn5Mhpk=;
 b=fXf3XJf+O3DW6MRFhkSbyJSBa2wPg+s+Kd0DUKmmcUY9nuBch8cePoUN9cmJ/nv5cIJDVVr4/kU6ZOtDh5P0LXNZAmQ9BHD+bnaP80I1vtMkxfJFpA+H3P0eqN10zECG+dp5YtpsOONpRMXlklforo/poVXTCyIkHadcZ3yf0lepEVaWXzlh9ombeFeiR5p5frAgRcbrqWgscnzk/br3Wy2IOGldzcaSKK5LHINwDZ4oO5ESNStFxhUOO3sxWki6OiXgwUNKklEglm1/qwMXgY3laXrkA3lJh+euIO27r7PlaCZdWaILPQdhAyxOMzBdFSqYhHvCnBaNHn7loaucbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s85szzDH6CN7+93Q87AMKKqmU4a8WwxMWONSHn5Mhpk=;
 b=oulLvmJXp2v/Pm9Z54W3uNXdUyOHN1u3tdIcZ3lBhUYjGlZYHnHI4k4fuhaDmZ3kqQ1NH4V/wUWRUE5geDUs5rYpWTiCCUDFrWyQgdfc4EZzUHDzBpzUV3E5r4rr3B9PIARI82WMKdYOFXG+fH8XeTMAo+gFCKtl88GWmkfBuZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BYAPR12MB3031.namprd12.prod.outlook.com (2603:10b6:a03:d8::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 17:19:27 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 17:19:26 +0000
Message-ID: <fb066a24-3737-ad5d-d098-ef0b5d4a54d4@amd.com>
Date: Tue, 10 May 2022 19:19:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <7e9f45be-41a0-0764-8f4d-2787319477fb@amd.com>
 <80f0a3d8-5b42-f1b3-5396-464c665361c7@amd.com>
 <aec08997-9565-a596-f143-eccf92653a84@amd.com>
 <8ea0a998-b056-8cbf-d666-5305fd124a5d@amd.com>
 <40baeccc-86c0-5fc2-c970-c0bf8b6b6943@amd.com>
 <384abcbc-c5e9-3732-7257-7f7bbf4c704b@amd.com>
 <05a18be9-dcc3-9246-b572-e47ccf5e804b@amd.com>
 <5f49de9e-dfa0-3371-c800-581f00556820@amd.com>
 <82cf78c6-9246-e892-bc42-99f6ec668481@amd.com>
 <ffad0f2b-b975-c099-a96d-98f82bc972ab@gmail.com>
 <3cefe63f-1f27-db1c-aeee-3731ca1e6d1d@amd.com>
 <df5deb8c-1a33-e177-ce26-eaccae179786@amd.com>
 <2b9b0047-6eb9-4117-9fa3-4396be39d39a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <2b9b0047-6eb9-4117-9fa3-4396be39d39a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR05CA0029.eurprd05.prod.outlook.com
 (2603:10a6:20b:488::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34f56d32-6496-4e4b-0ed8-08da32a93c02
X-MS-TrafficTypeDiagnostic: BYAPR12MB3031:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB303163D68FC3DC9C0F63CA1283C99@BYAPR12MB3031.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0q7aOFdPy6rMD3TA/cVLtDJ1dklIWtMGYbzh/9WBMrhesw5LJVuR7ZoBfrOIG74atB2UYjtgQuC0xEy9iYGkmlAm8++CIsSFSXLLLLtVW7TIkw0NZ+LGrQuKnYmtFjdpK3XL/4BeBiLSN2lyqFx0BRR3obz2qc8X8AHr2Hbuykeo7OIiW1d2/HEGBe+YJwQdRD3/DMGmF1xPKceJac5c4JA3c7ZuUCF4CRFjCZyZX1uJtjqnnAZVKdA5fsWvqySO8bK2EpCl7iMoZvIYdDZuYXHguqycprdGyONRgRIlZkZ6k4oJR/2jxc6BtUbv0Usl4SSDah5pvPacABYntwMaIC024AeHeYonES97t+tm3JEmyqTtQYubW4vtp9jBam35p6yANS+CYP2jHUyZzSdsHaJbKNl4ULG3P6llgC1140bnzWWxELb2lZ4iUa4zbBfSOv63jpcL6O62hYP4bkzeJnpqBegy4DKRXGFojUEX2/hefnwS+ekk9Wl7G/qDFpmTHzsEyRw3m8DVpIsUmwibsyvBUQLqC3dHXFEQxA7k9bBq5HSssvWjuN+tFy04G7AEwdfzCdW7MBF8tslNSe/qhUEwDgHG0Q1CkmvPnrV6g8GlI7pPDFeS38RkjvE2SO7i+lb7zvZeULdxmCB4kEEmrqYWbmg+68qMU23c0xsbROaT80opAl+hDGjnHSY9Js/N+5jB6+h9krkqf2ZVDwhvKWiafEkgdX7aTJXDMUguXbM5GUb1CLA8ZBreReD+curR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(4326008)(86362001)(6512007)(2616005)(30864003)(31696002)(6506007)(53546011)(2906002)(6666004)(6486002)(83380400001)(316002)(8936002)(38100700002)(508600001)(5660300002)(186003)(31686004)(36756003)(66946007)(66574015)(66476007)(110136005)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dCtxR0xHODlHaVdKdmNTanZMd3ZNWXlZZXlPazErSVloNWkvUXFzODFRS0FK?=
 =?utf-8?B?UHJmbU43enRVRnhCcEIrdzIxTmtxYnUyWXNlYlRPMlJNUTZDM3hxbVBSUWF3?=
 =?utf-8?B?WTd1aEhpYTgveUtUbW56K3Bqb3dzak81bHVIUHR6Q2E5a1FwVkhiKzVVQkJk?=
 =?utf-8?B?eTcvZW5zYVQwOHE4VWZ1NEpIVzd2MS94V3N2VFcrZmNEZmM0Q1JmZkdVaHRi?=
 =?utf-8?B?d21xMUZ6bmc2c3ZoWTUxT2xiRWRrYUtZUS9OdFRwdzUvNUlibFBidTRMcXlF?=
 =?utf-8?B?bVZaL2dDc3IraG51UnIvSUhJbnRqSnQ3YjJqbzNyM0ZoallGS29yNDRZT2k2?=
 =?utf-8?B?ZERKSVpzQTVmZC9QQnNkenZaeG5ZVjZNQnppRjJZbjQ2K1Q2aFRQWURzOVNO?=
 =?utf-8?B?NVZGUFlram5rYTFxYjBMU3E5U240Wjd3Y25lbktQUkJZMkM3WHdweDQrK2l4?=
 =?utf-8?B?WFNBK1h2T0dzNDQzWXNtT09zZUhYK2RxcTFPUUt0TmxUbkN1Y0lNWmtueEJX?=
 =?utf-8?B?Mmw0d1ZHd0E2VFhHc3BjLzc0dU9vakY5alhDZHlESmY5YUIzVWpOaHE2SnNy?=
 =?utf-8?B?QXRIaFIxQURHSGR5UUxIbEZKcFUrbTJidFBmTWpudnNORmMzQzJwZzFmcytr?=
 =?utf-8?B?dDNNcHp4bUlXZzZnenNsVCt1WTM3VWh0SGM5NFJmU2Z4VUI1ekJscFAxN2I1?=
 =?utf-8?B?ZEk0ditnanViZzdDWDViQXZNdEcwMzcrYUlvcEwrSzltZ0U0cExLVFl2cStx?=
 =?utf-8?B?QnpPR01mR3FKb0xncXNYaXM1aFdxbmJQa0V5Q1FMSFhPREZ2Q2hxR1VsODVr?=
 =?utf-8?B?ajE1ZnVLbzlIcFBxelhham9vYmtYdzFFZUl1Z05sRndBWU5iLzduZitkVmZX?=
 =?utf-8?B?WjVZcmtRbEorQlIyVDhaNml6MnpXdGVlQkh0VWM3R3pySW1WL0lVWlMwVVQx?=
 =?utf-8?B?OS9wUHczcmZDVWdVSW1XckIxUEM5d3hReWgxdENkdlA0bXhXT2t3RThYZ0hL?=
 =?utf-8?B?V2FVOEhvTnpJWTE3QmtMOEJCWGVua3pwenAxYnJaNklWL0tmZVFObThTMUVs?=
 =?utf-8?B?RXZSVlhUU2ZSUkZFLzRTdEpvSU80a3FCeTVOaFlUVFpxcmQ4U3ptOVcza1Ry?=
 =?utf-8?B?YXRlSTBVWTBjM1YwSDRZM0pJVUZTSUVzeStVS0xKdzgrVG1kVmZ0R25IaFd6?=
 =?utf-8?B?MjgwMW15K2ZzaHVlTDZlN29hUXA1WitmR3ordEUvNWV4dDhPTk94NVBkZkJ6?=
 =?utf-8?B?ekFRNjhDN2tlVCtHQUkrUXJ3OTJsSGdZNjljYVNNZXJsc2puVW1rdXo3c2Fn?=
 =?utf-8?B?UEVhN0pCUWw2WXY1dG5ibUh0eDM1dzI4UHphVXdnVEwwMjMydGNoVHk4ZFhv?=
 =?utf-8?B?aS96VGtWbUsxZE5TZGlZNHcrL0MyY3pRU0dWRHFXTjZoVXNZY3JlSzJ3OW1E?=
 =?utf-8?B?Wk5iNXdVelg1OWx5QjBrZWZMSGE5UVAwMzNrTHBnUlZBb2loQVhxNjJkOHdv?=
 =?utf-8?B?L3hpVGNnMllnMzlWbUFPY2NzVGxmWGhPdERxWVUvRURKeHhyNHN6endlYjNq?=
 =?utf-8?B?am45NmxiYlFTWWZKeHVsbkFsWS9tS0FsSS9KVjhIa2J2bDRKWTVtdE1UaWJW?=
 =?utf-8?B?emxtMVl6RUh0YjdVT054Vm5BdlNqK3NnRVdDK2trL0czdEk3OTVxd1pjTytR?=
 =?utf-8?B?Wmp1NGlOcjN5RmI0N2JoRkNPZittVElrTGdUcHBQSkRkZDVCbzZxYVhGbnEx?=
 =?utf-8?B?Umhrdldub1JpT2JFUXBWVkRJN01QTjY0MDFUOGU1UGVJL0NKZ3p5WWRwVld0?=
 =?utf-8?B?N3o1WmJERCtUSDhJSjFXNURtQ1daa1pFQ2IyTnphcFY1UjVYa3dhOTVFKzhU?=
 =?utf-8?B?dnJxTVUxd0FGdW04SGpIOVlNaE9aRVJaQmJ2U1MzblhzK29mbkhPUGJWdnZF?=
 =?utf-8?B?MFU3b1Z1NW1NMXlWMDBLOVlrQ3RpZGdTWTJNSWhIbWVNMjJJT2tiYWpxODlr?=
 =?utf-8?B?R3VzTXloZHJnck4wZCtLZlM1eFpic0N1dmw0U3I5c0lneVVPbzYxMnU0MllB?=
 =?utf-8?B?M0YyeXRhSEcxK1BFaWlxbkZibWU2ZnNENko2eWc1b3p4WU5DL21USGFPSnpD?=
 =?utf-8?B?TE80TkJUVHd5R3lGWmFFS2wxL282eHBQZHN5NXFFT3EwWVQwT1BBM1FwUTZH?=
 =?utf-8?B?aitnblBrcXBteFVzWDRBOVFjcEtIYlk1NklQT0xBczh5LzRtYStGc3YweFZL?=
 =?utf-8?B?UnpIdmhaN3RtRnluemRqdDRSUjc5S1hMeU00TXI1a0JvT1ZJaUZUeCt6czFo?=
 =?utf-8?B?TGxBSXlHczVBNWF3eGlkdG1ocUNMSXB0MmpOUDRPcnJlNUQySnhNSUVtQjNP?=
 =?utf-8?Q?WFmi7/D9rLJf8YHFrmOAModMuiokiVi3kkTJRpK3OVwxe?=
X-MS-Exchange-AntiSpam-MessageData-1: QrhJ0J1mtvswiQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f56d32-6496-4e4b-0ed8-08da32a93c02
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 17:19:26.6944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sE+CAl3mrTMU639d2aIQ6Pav0IOQLI5VFT31dP9y0Tu6xmG7TpaXRjeEGzkdGlhW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3031
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
Cc: Bai Zoy <Zoy.Bai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.05.22 um 19:01 schrieb Andrey Grodzovsky:
>
> On 2022-05-10 12:17, Christian König wrote:
>> Am 10.05.22 um 18:00 schrieb Andrey Grodzovsky:
>>> [SNIP]
>>>> That's one of the reasons why we should have multiple work items 
>>>> for job based reset and other reset sources.
>>>>
>>>> See the whole idea is the following:
>>>> 1. We have one single queued work queue for each reset domain which 
>>>> makes sure that all reset requests execute in order.
>>>> 2. We have one delayed work item for each scheduler which fires 
>>>> when a timeout on a scheduler occurs and eventually calls the reset 
>>>> procedure with the last running job.
>>>> 3. We have one work item for each necessary hard reset.
>>>>
>>>> The delayed work item from the scheduler first tries a soft 
>>>> recovery and checks if a hard reset is really necessary. If it's 
>>>> not necessary and we can cancel the offending job we skip the hard 
>>>> reset.
>>>>
>>>> The hard reset work item doesn't do any of those checks and just 
>>>> does a reset no matter what.
>>>>
>>>> When we really do a reset, independent if its triggered by a job or 
>>>> other source we cancel all sources at the end of the reset procedure.
>>>>
>>>> This makes sure that a) We only do one reset even when multiple 
>>>> sources fire at the same time and b) when any source bails out and 
>>>> only does a soft recovery we do a full reset anyway when necessary.
>>>>
>>>> That design was outlined multiple times now on the mailing list and 
>>>> looks totally clear to me. We should probably document that somewhere.
>>>
>>>
>>> If you look at the patch what you described above is exactly what is 
>>> happening - since scheduler's delayed work is different from any non 
>>> scheduler delayed work the SW reset which might take place from 
>>> scheduler's reset
>>> will not have any impact on any non scheduler delayed work and will 
>>> not cancel them. In case the scheduler actually reaches the point of 
>>> HW reset it will cancel out all pending reset works from any other 
>>> sources on the same
>>> reset domain. Non scheduler reset will always proceed to do full HW 
>>> reset and will cancel any other pending resets.
>>
>> Ok, but why you then need that linked list? The number of reset 
>> sources should be static and not in any way dynamic.
>
>
> So array reset_src[i] holds a pointer to pending delayed work from 
> source i or NULL if no pedning work ?
> What if same source triggers multiple reset requests such as multiple 
> RAS errors at once , don't set the delayed work pointer in the 
> arr[RAS_index] if it's already not NULL ?
>
>>
>> See using the linked list sounds like you only wanted to cancel the 
>> reset sources raised so far which would not be correct as far as I 
>> can see.
>
>
> Not clear about this one ? We do want to cancel those reset sources 
> that were raised so far because we just did a HW reset which should 
> fix them anyway ? Those who not raised reset request so far their 
> respective array index will have a NULL ptr.

And exactly that's what I want to prevent. See you don't care if a reset 
source has fired once, twice, ten times or never. You just cancel all of 
them!

That's why I want to come to a static list of reset sources.

E.g. in the reset code (either before or after the reset, that's 
debatable) you do something like this:

for (i = 0; i < num_ring; ++i)
     cancel_delayed_work(ring[i]->scheduler....)
cancel_work(adev->ras_work);
cancel_work(adev->iofault_work);
cancel_work(adev->debugfs_work);
...

You don't really need to track which reset source has fired and which 
hasn't, because that would be racy again. Instead just bluntly reset all 
possible sources.

Christian.

>
> Andrey
>
>
>>
>>>
>>> The only difference is I chose to do the canceling right BEFORE the 
>>> HW reset and not AFTER. I did this because I see a possible race 
>>> where a new reset request is being generated exactly after we 
>>> finished the HW reset but before we canceled out all pending resets 
>>> - in such case you wold not want to cancel this 'border line new' 
>>> reset request.
>>
>> Why not? Any new reset request directly after a hardware reset is 
>> most likely just falsely generated by the reset itself.
>>
>> Ideally I would cancel all sources after the reset, but before 
>> starting any new work.
>>
>> Regards,
>> Christian.
>>
>>>
>>>
>>> Andrey
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>> You can see that if many different reset sources share same work 
>>>>>> struct what can happen is that the first to obtain the lock you 
>>>>>> describe bellow might opt out from full HW reset because his bad 
>>>>>> job did signal for example or because his hunged IP block was 
>>>>>> able to recover through SW reset but in the meantime another 
>>>>>> reset source who needed an actual HW reset just silently returned 
>>>>>> and we end up with unhandled reset request. True that today this 
>>>>>> happens only to job timeout reset sources that are handled form 
>>>>>> within the scheduler and won't use this single work struct but no 
>>>>>> one prevents a future case for this to happen and also, if we 
>>>>>> actually want to unify scheduler time out handlers within reset 
>>>>>> domain (which seems to me the right design approach) we won't be 
>>>>>> able to use just one work struct for this reason anyway.
>>>>>>
>>>>>
>>>>> Just to add to this point - a reset domain is co-operative domain. 
>>>>> In addition to sharing a set of clients from various reset sources 
>>>>> for one device, it also will have a set of devices like in XGMI 
>>>>> hive. The job timeout on one device may not eventually result in 
>>>>> result, but a RAS error happening on another device at the same 
>>>>> time would need a reset. The second device's RAS error cannot 
>>>>> return seeing  that a reset work already started, or ignore the 
>>>>> reset work given that another device has filled the reset data.
>>>>>
>>>>> When there is a reset domain, it should take care of the work 
>>>>> scheduled and keeping it in device or any other level doesn't 
>>>>> sound good.
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> I'd put the reset work struct into the reset_domain struct. That 
>>>>>>> way you'd have exactly one worker for the reset domain. You 
>>>>>>> could implement a lock-less scheme to decide whether you need to 
>>>>>>> schedule a reset, e.g. using an atomic counter in the shared 
>>>>>>> work struct that gets incremented when a client wants to trigger 
>>>>>>> a reset (atomic_add_return). If that counter is exactly 1 after 
>>>>>>> incrementing, you need to fill in the rest of the work struct 
>>>>>>> and schedule the work. Otherwise, it's already scheduled (or 
>>>>>>> another client is in the process of scheduling it) and you just 
>>>>>>> return. When the worker finishes (after confirming a successful 
>>>>>>> reset), it resets the counter to 0, so the next client 
>>>>>>> requesting a reset will schedule the worker again.
>>>>>>>
>>>>>>> Regards,
>>>>>>>   Felix
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Additional to that keep in mind that you can't allocate any 
>>>>>>>>> memory before or during the GPU reset nor wait for the reset 
>>>>>>>>> to complete (so you can't allocate anything on the stack either).
>>>>>>>>
>>>>>>>>
>>>>>>>> There is no dynamic allocation here, regarding stack 
>>>>>>>> allocations - we do it all the time when we call functions, 
>>>>>>>> even during GPU resets, how on stack allocation of work struct 
>>>>>>>> in amdgpu_device_gpu_recover is different from any other local 
>>>>>>>> variable we allocate in any function we call ?
>>>>>>>>
>>>>>>>> I am also not sure why it's not allowed to wait for reset to 
>>>>>>>> complete ? Also, see in amdgpu_ras_do_recovery and 
>>>>>>>> gpu_recover_get (debugfs) - the caller expects the reset to 
>>>>>>>> complete before he returns. I can probably work around it in 
>>>>>>>> RAS code by calling atomic_set(&ras->in_recovery, 0) from some 
>>>>>>>> callback within actual reset function but regarding sysfs it 
>>>>>>>> actually expects a result returned indicating whether the call 
>>>>>>>> was successful or not.
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> I don't think that concept you try here will work.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>> Also in general seems to me it's cleaner approach where this 
>>>>>>>>>> logic (the work items) are held and handled in reset_domain 
>>>>>>>>>> and are not split in each adev or any other entity. We might 
>>>>>>>>>> want in the future to even move the scheduler handling into 
>>>>>>>>>> reset domain since reset domain is supposed to be a generic 
>>>>>>>>>> things and not only or AMD.
>>>>>>>>>>
>>>>>>>>>> Andrey
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Andrey
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>>>>>>>>> Tested-by: Bai Zoy <Zoy.Bai@amd.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 11 +---
>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++--
>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +
>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 73 
>>>>>>>>>>>>>> +++++++++++++++++++++-
>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 3 +-
>>>>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 7 ++-
>>>>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 7 ++-
>>>>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 7 ++-
>>>>>>>>>>>>>>   8 files changed, 104 insertions(+), 24 deletions(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>> index 4264abc5604d..99efd8317547 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>> @@ -109,6 +109,7 @@
>>>>>>>>>>>>>>   #include "amdgpu_fdinfo.h"
>>>>>>>>>>>>>>   #include "amdgpu_mca.h"
>>>>>>>>>>>>>>   #include "amdgpu_ras.h"
>>>>>>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>>>>>>     #define MAX_GPU_INSTANCE        16
>>>>>>>>>>>>>>   @@ -509,16 +510,6 @@ struct 
>>>>>>>>>>>>>> amdgpu_allowed_register_entry {
>>>>>>>>>>>>>>       bool grbm_indexed;
>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>   -enum amd_reset_method {
>>>>>>>>>>>>>> -    AMD_RESET_METHOD_NONE = -1,
>>>>>>>>>>>>>> -    AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>>>>>>> -    AMD_RESET_METHOD_MODE0,
>>>>>>>>>>>>>> -    AMD_RESET_METHOD_MODE1,
>>>>>>>>>>>>>> -    AMD_RESET_METHOD_MODE2,
>>>>>>>>>>>>>> -    AMD_RESET_METHOD_BACO,
>>>>>>>>>>>>>> -    AMD_RESET_METHOD_PCI,
>>>>>>>>>>>>>> -};
>>>>>>>>>>>>>> -
>>>>>>>>>>>>>>   struct amdgpu_video_codec_info {
>>>>>>>>>>>>>>       u32 codec_type;
>>>>>>>>>>>>>>       u32 max_width;
>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>> index e582f1044c0f..7fa82269c30f 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>> @@ -5201,6 +5201,12 @@ int 
>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>         tmp_vram_lost_counter = 
>>>>>>>>>>>>>> atomic_read(&((adev)->vram_lost_counter));
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +    /* Drop all pending resets since we will reset now 
>>>>>>>>>>>>>> anyway */
>>>>>>>>>>>>>> +    tmp_adev = list_first_entry(device_list_handle, 
>>>>>>>>>>>>>> struct amdgpu_device,
>>>>>>>>>>>>>> +                        reset_list);
>>>>>>>>>>>>>> + amdgpu_reset_pending_list(tmp_adev->reset_domain);
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>       /* Actual ASIC resets if needed.*/
>>>>>>>>>>>>>>       /* Host driver will handle XGMI hive reset for 
>>>>>>>>>>>>>> SRIOV */
>>>>>>>>>>>>>>       if (amdgpu_sriov_vf(adev)) {
>>>>>>>>>>>>>> @@ -5296,7 +5302,7 @@ int 
>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>     struct amdgpu_recover_work_struct {
>>>>>>>>>>>>>> -    struct work_struct base;
>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct base;
>>>>>>>>>>>>>>       struct amdgpu_device *adev;
>>>>>>>>>>>>>>       struct amdgpu_job *job;
>>>>>>>>>>>>>>       int ret;
>>>>>>>>>>>>>> @@ -5304,7 +5310,7 @@ struct amdgpu_recover_work_struct {
>>>>>>>>>>>>>>     static void 
>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work(struct work_struct 
>>>>>>>>>>>>>> *work)
>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>> -    struct amdgpu_recover_work_struct *recover_work = 
>>>>>>>>>>>>>> container_of(work, struct amdgpu_recover_work_struct, base);
>>>>>>>>>>>>>> +    struct amdgpu_recover_work_struct *recover_work = 
>>>>>>>>>>>>>> container_of(work, struct amdgpu_recover_work_struct, 
>>>>>>>>>>>>>> base.base.work);
>>>>>>>>>>>>>>         recover_work->ret = 
>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(recover_work->adev, 
>>>>>>>>>>>>>> recover_work->job);
>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>> @@ -5316,12 +5322,15 @@ int 
>>>>>>>>>>>>>> amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>       struct amdgpu_recover_work_struct work = {.adev = 
>>>>>>>>>>>>>> adev, .job = job};
>>>>>>>>>>>>>>   -    INIT_WORK(&work.base, 
>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&work.base.base, 
>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>>>>>>> + INIT_LIST_HEAD(&work.base.node);
>>>>>>>>>>>>>>         if 
>>>>>>>>>>>>>> (!amdgpu_reset_domain_schedule(adev->reset_domain, 
>>>>>>>>>>>>>> &work.base))
>>>>>>>>>>>>>>           return -EAGAIN;
>>>>>>>>>>>>>>   -    flush_work(&work.base);
>>>>>>>>>>>>>> + flush_delayed_work(&work.base.base);
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>> &work.base);
>>>>>>>>>>>>>>         return work.ret;
>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>> index c80af0889773..ffddd419c351 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>> @@ -134,6 +134,9 @@ struct amdgpu_reset_domain 
>>>>>>>>>>>>>> *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>>>>>>>>>>>>>> atomic_set(&reset_domain->in_gpu_reset, 0);
>>>>>>>>>>>>>> init_rwsem(&reset_domain->sem);
>>>>>>>>>>>>>>   + INIT_LIST_HEAD(&reset_domain->pending_works);
>>>>>>>>>>>>>> + mutex_init(&reset_domain->reset_lock);
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>       return reset_domain;
>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>> index 1949dbe28a86..863ec5720fc1 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>> @@ -24,7 +24,18 @@
>>>>>>>>>>>>>>   #ifndef __AMDGPU_RESET_H__
>>>>>>>>>>>>>>   #define __AMDGPU_RESET_H__
>>>>>>>>>>>>>>   -#include "amdgpu.h"
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +#include <linux/atomic.h>
>>>>>>>>>>>>>> +#include <linux/mutex.h>
>>>>>>>>>>>>>> +#include <linux/list.h>
>>>>>>>>>>>>>> +#include <linux/kref.h>
>>>>>>>>>>>>>> +#include <linux/rwsem.h>
>>>>>>>>>>>>>> +#include <linux/workqueue.h>
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +struct amdgpu_device;
>>>>>>>>>>>>>> +struct amdgpu_job;
>>>>>>>>>>>>>> +struct amdgpu_hive_info;
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>     enum AMDGPU_RESET_FLAGS {
>>>>>>>>>>>>>>   @@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
>>>>>>>>>>>>>>       AMDGPU_SKIP_HW_RESET = 1,
>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>   +
>>>>>>>>>>>>>> +enum amd_reset_method {
>>>>>>>>>>>>>> +    AMD_RESET_METHOD_NONE = -1,
>>>>>>>>>>>>>> +    AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>>>>>>> +    AMD_RESET_METHOD_MODE0,
>>>>>>>>>>>>>> +    AMD_RESET_METHOD_MODE1,
>>>>>>>>>>>>>> +    AMD_RESET_METHOD_MODE2,
>>>>>>>>>>>>>> +    AMD_RESET_METHOD_BACO,
>>>>>>>>>>>>>> +    AMD_RESET_METHOD_PCI,
>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>   struct amdgpu_reset_context {
>>>>>>>>>>>>>>       enum amd_reset_method method;
>>>>>>>>>>>>>>       struct amdgpu_device *reset_req_dev;
>>>>>>>>>>>>>> @@ -40,6 +62,8 @@ struct amdgpu_reset_context {
>>>>>>>>>>>>>>       unsigned long flags;
>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>   +struct amdgpu_reset_control;
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>   struct amdgpu_reset_handler {
>>>>>>>>>>>>>>       enum amd_reset_method reset_method;
>>>>>>>>>>>>>>       struct list_head handler_list;
>>>>>>>>>>>>>> @@ -76,12 +100,21 @@ enum amdgpu_reset_domain_type {
>>>>>>>>>>>>>>       XGMI_HIVE
>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>   +
>>>>>>>>>>>>>> +struct amdgpu_reset_work_struct {
>>>>>>>>>>>>>> +    struct delayed_work base;
>>>>>>>>>>>>>> +    struct list_head node;
>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>   struct amdgpu_reset_domain {
>>>>>>>>>>>>>>       struct kref refcount;
>>>>>>>>>>>>>>       struct workqueue_struct *wq;
>>>>>>>>>>>>>>       enum amdgpu_reset_domain_type type;
>>>>>>>>>>>>>>       struct rw_semaphore sem;
>>>>>>>>>>>>>>       atomic_t in_gpu_reset;
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +    struct list_head pending_works;
>>>>>>>>>>>>>> +    struct mutex reset_lock;
>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>     @@ -113,9 +146,43 @@ static inline void 
>>>>>>>>>>>>>> amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain 
>>>>>>>>>>>>>> *dom
>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>     static inline bool 
>>>>>>>>>>>>>> amdgpu_reset_domain_schedule(struct amdgpu_reset_domain 
>>>>>>>>>>>>>> *domain,
>>>>>>>>>>>>>> -                        struct work_struct *work)
>>>>>>>>>>>>>> +                        struct amdgpu_reset_work_struct 
>>>>>>>>>>>>>> *work)
>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>> -    return queue_work(domain->wq, work);
>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +    if (!queue_delayed_work(domain->wq, &work->base, 0)) {
>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>> +        return false;
>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +    list_add_tail(&work->node, &domain->pending_works);
>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +    return true;
>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +static inline void 
>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(struct 
>>>>>>>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>>>>>>>> +                  struct amdgpu_reset_work_struct *work)
>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>> +    list_del_init(&work->node);
>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +static inline void amdgpu_reset_pending_list(struct 
>>>>>>>>>>>>>> amdgpu_reset_domain *domain)
>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct *entry, *tmp;
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>> +    list_for_each_entry_safe(entry, tmp, 
>>>>>>>>>>>>>> &domain->pending_works, node) {
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> + list_del_init(&entry->node);
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +        /* Stop any other related pending resets */
>>>>>>>>>>>>>> + cancel_delayed_work(&entry->base);
>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>     void amdgpu_device_lock_reset_domain(struct 
>>>>>>>>>>>>>> amdgpu_reset_domain *reset_domain);
>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>> index 239f232f9c02..574e870d3064 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>>>>>>>>   #define AMDGPU_VIRT_H
>>>>>>>>>>>>>>     #include "amdgv_sriovmsg.h"
>>>>>>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>>>>>>     #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS (1 << 0) /* 
>>>>>>>>>>>>>> vBIOS is sr-iov ready */
>>>>>>>>>>>>>>   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV (1 << 1) /* sr-iov 
>>>>>>>>>>>>>> is enabled on this GPU */
>>>>>>>>>>>>>> @@ -230,7 +231,7 @@ struct amdgpu_virt {
>>>>>>>>>>>>>>       uint32_t            reg_val_offs;
>>>>>>>>>>>>>>       struct amdgpu_irq_src ack_irq;
>>>>>>>>>>>>>>       struct amdgpu_irq_src rcv_irq;
>>>>>>>>>>>>>> -    struct work_struct        flr_work;
>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct flr_work;
>>>>>>>>>>>>>>       struct amdgpu_mm_table mm_table;
>>>>>>>>>>>>>>       const struct amdgpu_virt_ops *ops;
>>>>>>>>>>>>>>       struct amdgpu_vf_error_buffer vf_errors;
>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>> index b81acf59870c..f3d1c2be9292 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>> @@ -251,7 +251,7 @@ static int 
>>>>>>>>>>>>>> xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>>>>>>>>     static void xgpu_ai_mailbox_flr_work(struct 
>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>>>>>>> amdgpu_virt, flr_work);
>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>>>>>>>>       struct amdgpu_device *adev = container_of(virt, 
>>>>>>>>>>>>>> struct amdgpu_device, virt);
>>>>>>>>>>>>>>       int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>>>>>>   @@ -380,7 +380,8 @@ int xgpu_ai_mailbox_get_irq(struct 
>>>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>> @@ -389,6 +390,8 @@ void xgpu_ai_mailbox_put_irq(struct 
>>>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>     static int xgpu_ai_request_init_data(struct 
>>>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>> index 22c10b97ea81..927b3d5bb1d0 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>> @@ -275,7 +275,7 @@ static int 
>>>>>>>>>>>>>> xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>>>>>>>>     static void xgpu_nv_mailbox_flr_work(struct 
>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>>>>>>> amdgpu_virt, flr_work);
>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>>>>>>>>       struct amdgpu_device *adev = container_of(virt, 
>>>>>>>>>>>>>> struct amdgpu_device, virt);
>>>>>>>>>>>>>>       int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>>>>>>   @@ -407,7 +407,8 @@ int xgpu_nv_mailbox_get_irq(struct 
>>>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>> @@ -416,6 +417,8 @@ void xgpu_nv_mailbox_put_irq(struct 
>>>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>     const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c 
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>> index 7b63d30b9b79..1d4ef5c70730 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>> @@ -512,7 +512,7 @@ static int 
>>>>>>>>>>>>>> xgpu_vi_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>>>>>>>>     static void xgpu_vi_mailbox_flr_work(struct 
>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>>>>>>> amdgpu_virt, flr_work);
>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>>>>>>>>       struct amdgpu_device *adev = container_of(virt, 
>>>>>>>>>>>>>> struct amdgpu_device, virt);
>>>>>>>>>>>>>>         /* wait until RCV_MSG become 3 */
>>>>>>>>>>>>>> @@ -610,7 +610,8 @@ int xgpu_vi_mailbox_get_irq(struct 
>>>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>> @@ -619,6 +620,8 @@ void xgpu_vi_mailbox_put_irq(struct 
>>>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>     const struct amdgpu_virt_ops xgpu_vi_virt_ops = {
>>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>
>>>>
>>

