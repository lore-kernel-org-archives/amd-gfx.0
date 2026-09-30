Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AB6CA5FC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 13:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7EB310E273;
	Wed, 30 Sep 2026 13:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hzt0JXl6";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D7110E273
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 13:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMb2QesKI1/8VG+bEkmphFqb9yQ3a58+KrBNIyq22GzbMAhbp5qyl2Z7u4iepb6ZdXlQHZohJbZq7nAE6b8Vl39MqMpUmSeEKwVjK/A9oJIfntjX1eMbNDlVyKlhVGOjuQDhGkVf2H7FwvmTdZgPcetnUtGcZdxSkwBEUZVDrWnal1+qz9ABtrKKMQ8bEvrTkEgf2NAk/3WbdghMCk3NN3vnaqMBLX2ksyRrAPtVjvBPy0KgGamRBjs1hSef21bNY6lq1b7fNfuGqxRhAQpSui3S4nTViHaSaiLa9TTlVq45nqase10caLK5j1HOFQ5OWVNws/1DkFJD7qjHx+XevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//SJujTnentl4lnediLNsJfMviup4GdymqGC2foBOYk=;
 b=K1gg3/dI9GXLN8I0tzkz3qVCYifhid+JnpZf+Zs4g619Ci8sjVTPM+leoyxqkzOGffijMw02O15Mc49EwivXm3ZqRqoixiWa1SWPSCETYOc4M3J8JtsQIh8IhWmmjxbK9iWHtEY8G7EV8uZn1UPBiHyxMlIVpEFJImFqGrawj2u8B23faz6iNR0O/Bkqge7VX/DrnT3h0z8YTZc+hDMZRF9YFgBocui6HZeMJ9IRqCGf5avFv3+HlYOoyMGPjSyxK1hAkPkG9wZ9X8mZVyGQy0fXEoyCrVdvc2mvRA3cVgPo01NWYlIfnCVUEiUwKQHSMLuxTBtrAfwZ9Bcva5aogQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//SJujTnentl4lnediLNsJfMviup4GdymqGC2foBOYk=;
 b=Hzt0JXl6iWTSLEPjbvfMjwL1p+LZGoct0wLKJk9FLhtifHC8TpTL0/TOsE1LiEvVQGWukvlMYHlsoIazS3KHe+cF5go2kzdRjgT9tbSM28/LeAY3iZTRcBFAEX6devz+iq67BlWcjeifJR99i8bVLpJ4hBtmpw8H5EBAcljnXyw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 13:23:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 13:23:54 +0000
Message-ID: <da65b814-7c7d-4efe-9db9-8fe42d09b57f@amd.com>
Date: Wed, 30 Sep 2026 15:23:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] drm/amdgpu: add amdgpu_vm_update_leaves()
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20260930103207.10690-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260930103207.10690-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:208:329::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f40393-58b5-4903-37c1-08df1ef61350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|5023799004|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: W/uS5vRGcqJlmxdjIKmrUbKw+csnZek+WB6AF8DuJTwZki2kpED8KlEjUtNvrXz55Cwr6jIP9UmzhVt7aJUaFd5z5t5adE0yc77Mr+PPoYTsGYSf93D4uGVWtJH7YMHzaa6VWUSGmAeebsOiIG4sscYCCjE5GiyanVxkV0442CSioCA4y8CF4Ed1pRgA009Az6yxAdc1U2IC7ec/GdsBND6edm07WikzE2e8lNuk4Rbbss5nBUb8Dk0CC2Gfyh7v9rw8rZSve9/+S3WrVj/mIkTx0y3tuMe1AMAguTvdNnmIJgqDhxpTeJAIwIBTI4Csf6wQHL6dfO8hZKLVzx7PNuh74ObGxcZZMz19DjA18qVik7Uz825Xb41rc47ImVKrOgeJvK7e3PxnbdNZZncmPmU+kOBD9Rjzv3q1N4TG/zWK7gXB8L89FuBThfDwebNbpaIkc9k6ybtS/JdKGXzOZ6a5VIop1oWUk8oQgF80CBhp1ANITS9bxJng9iu2T9aOWYDXr+bGKD0FMf8kKGFspntuUCuxBr/c7FVhRm/0m59RTYFJ9JqB78AE9IzUhjb9Mxv+A6uLR179rzMKZVC+IAiPzMOR9DZA4qDQ/kWWgbL6dO4MWybx1h6D1zIAmivc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTZPd0hOaFV4WVlJQVZCK05vTG5GOWRCRlo2T0U2Sm1RN25mWU1DNEM0bm90?=
 =?utf-8?B?ZXRJSXhPSWcwS1p0MTAyQzI4QloxQUVXTGZPUW04WUVjbTZEY0ZLcmJnL0sr?=
 =?utf-8?B?U0RDK2FQTVIxdG5yNndYZEJDUGxLdkQxbGdjN2crTy9HL1pET1JWY0VOSkly?=
 =?utf-8?B?TGR0L3Jac09ndGFBVDdlazU2ZjFYVFZxU1U1OFJyM0M2b1pSKy9ueGNoQ3ZJ?=
 =?utf-8?B?UkYySjZ1NVMwRXFxaE9Xdnc5ei9nNmQ3R0VtS2V2VnpRNmZHQ2JWY0gwQ0lU?=
 =?utf-8?B?RWlhWlhPZ2NTRDAvOE1jS0g3ZlQ2MGRJOFNEQXNDZW0xSG1kaXRNSllzeUxX?=
 =?utf-8?B?UWp0Z0wzKzZQcXQwYjIxM0drdTMxeTNwdW5Ia2JENzRic3FKTmVNUHRqSnB5?=
 =?utf-8?B?ZWwrRmg4OHhWQU9JZVVQV3R2ejMzcEp4WnRMczVVK3JqMHRrVVFmNHV1L0NF?=
 =?utf-8?B?ZkFsbERzOW9WQXo5YytXdC9Kend6TmZsbkpVeHl1Z3pIN3JIWlJFaVZHMW9S?=
 =?utf-8?B?ZzJ1aWtEelVPWlUrbnBmL21VYjdCeUtrc0I1NmVCbkVpVGlHc3E0Ykx6akJL?=
 =?utf-8?B?b04wNDg0eVM4QWFzWkJsM2RZZ0NiSWp6VmpiRTdoQnE5M0Vxa0VLVjcvZllR?=
 =?utf-8?B?VnNobisyZ0RRL215UG5YVVhma216L0U2T0FsVzN6aDlwQlJYTEE1bWo0Ukcx?=
 =?utf-8?B?MTRVZjhROW81ZkVFQWlrcGhFVEc5QW4zRGloSnlMY3pvdmlWNUYrcXhycW5P?=
 =?utf-8?B?QjdlaGg1QkJJZ09wU0g5R3M2MVNzSXhCUnNTeGcrQjdTUHZhbGlOSnIwTmts?=
 =?utf-8?B?VEI2Z0V1czFUTVNyMDgzL3BVajBxZFQ1WmFvU3lOZTJpZ0tRUitWQWJqd05j?=
 =?utf-8?B?RmlxRTZGUVJ4RWJjRXU1Q0VTVm02ZTJXL0pxUHF2alA1UWJHRktDNHQ5SmVB?=
 =?utf-8?B?ZkwrVFUxVEx2NWcvVnJsM0tTTHNDcmxXalJ1UWNRY0FLRmRxM0kyVjdSQzhQ?=
 =?utf-8?B?bThnVkkrZzltQnV5SnJIM0FSdlZsWElmYVBzN3EvRkRYRitBTVR5c29PTERu?=
 =?utf-8?B?c2xNeVh0REgwWXV1TC90THYvcExRNnVINmkra1l6eVZ6djhsL3pib0hsNHp1?=
 =?utf-8?B?VWEzbzNnR2RCTDUzTjdob3VhVE1KQ0dHd2RTK0QvajhIRTI3SFFhM3R1Undj?=
 =?utf-8?B?a3NmM0pNeWhaNWxNWG1uaUxpT0hRL3J2aTdQaHdqbm81b0MrV013OGtycW9V?=
 =?utf-8?B?QkRiOWpFbXd3RHlITDNlSHcxV3JJOWFTR1NmMklqc2lYNUMzSVhkUmNDNk5s?=
 =?utf-8?B?TDkvcGxxNDgwVWJwNFBqclFuRk5mRWg3djIzNU8xeUZ5WGNRbW1lOHpoZUJM?=
 =?utf-8?B?T1JCYm5nK0FteU5BN2JVQ05FN3NBWnQwTUl1QkwzV2dvUTByb1c2L284TTkw?=
 =?utf-8?B?N1F4QXNDSTdPMjhHZEE0eE5XY3RNbkE2Rkt3SjZPQ3VzZ2RsT2xEY2lXbkdW?=
 =?utf-8?B?ZU5RcDZ2dHlTcG1JNUNpZ0VrajRzVjhCY2s4aS9CK3Z4bE5BbUFuK3ZlNzRC?=
 =?utf-8?B?eE9vV09WaFNCWXRkK1E4RmVQK3lCMG1hOFcvNWlsejRpTEhVVUZ3U21nN2hh?=
 =?utf-8?B?NmpRME9JUUc2SEJZekFySEhJNkN5ejdGY1NMaHVFSkdxN2JPT2h0NXAwWEpY?=
 =?utf-8?B?dWs4L2VvdFY2bU03ZG1URUdnSjMzVVU3NGoyK1NNb3ZuWTFMcVQwbC9wd3VT?=
 =?utf-8?B?Q2NocWR3WVFsYnBybFpvM1gzWlJKN0tUdEROaVNkRkxtd3FYc2ZTakx3aHFs?=
 =?utf-8?B?WHlNUEQycmhCOXZrVGhyaitFNWs0SGtvbkdWbW5sYVFzMHFwbXlKTmhBZkpp?=
 =?utf-8?B?enRac2lkSS9hV21QcG50VDJkeTlnK0c5a1cyOGNRdVJIbkdaZXFqOTRhOEQ0?=
 =?utf-8?B?aHJTUjcveHFZenk2R1JVZVY0b0M4Ujl3SjhUQnUrWWlHcFdJYmhVZ0lmdGNa?=
 =?utf-8?B?SUFuVDV0RWdEM1N2dkhseWF2NjRiN1o3RW9MVnUzY25EYjFmaTdOcnl0Y2hK?=
 =?utf-8?B?VG5CUXBIR3YyYU1nQzIvdWk3NHJVbVBaYW5FNHJTM1prQW1OUTQ2cHJZTEIz?=
 =?utf-8?B?UENZTzdXRXBKKzVsdTFnYWk4UkM3SEtINFRocnF2VUhjcWVrT3JmOGc3UElu?=
 =?utf-8?B?V2hsN0gycjNHalBPVUdtdE9aNXBQTzRiRW5Yb2dJdHVJYkt0dlZuRnZrb3hZ?=
 =?utf-8?B?Q2ZrNUd1RzJBWEg4aGdWeHFUalpYTzlwSkovY0J3M21PUXljNUxscGkxRE96?=
 =?utf-8?Q?o/q/tG31QlnHkaOOO8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f40393-58b5-4903-37c1-08df1ef61350
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:23:54.7288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRms/D0rT96AiMCAPs6ejyYxpNXVZB4gl0md0cmP5NX5bfGyPcENV178T20Mmt9d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067
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

Hi Olivier,

On 9/30/26 12:32, Olivier Kaloudoff wrote:
> Hi Christian,
> 
> On 9/30/26 12:16, Christian König wrote:
>> thanks for the testing, but you are looking at outdated code.
>>
>> I was initially only testing with 2MiB pages and didn't see that
>> issue, it is already fixed in what I've send out on Friday.
>>
>> Can you give that version another round of testing? The would be
>> great.
> 
> Makes sense — with 2MiB mappings the leaf-level writes dominate and the
> non-leaf gap slot case barely gets exercised. Our SVM workload
> (eviction/restore churn under memory pressure) hits it reliably because
> it creates exactly the pattern that breaks: an unmapped gap followed by
> still-linked sibling subtrees in the same parent PD.
> 
> I just read the v2 series (the 9-patch set from the 28th) — the reworked
> amdgpu_vm_pt_leaves() in patch 4/9 looks right: walking forward and
> accumulating only consecutive entries that have no leaf in the same
> parent is strictly better than the one-entry clamp we used locally, since
> it still batches genuine gaps. And patch 2/9 explains the other half of
> what we observed in RAM — the PDE_PTE-only marker (0x40000000000000) in
> the clobbered slots lines up with the cleared-flag generation fix.
> 
> Happy to re-test. I'll apply the 9-patch series on top of our 7.2.6 tree
> and re-run the reproducer (vLLM/ROCm checkpoint staging on the MI50 —
> previously a deterministic fault at the same stage on every run). Will
> report back on the new thread.

I'm about to send out v3 of the series which can also be found here: https://gitlab.freedesktop.org/ckoenig/linux-drm/-/commits/amd-vm-svm

It's based on the latest amd-staging-drm-next development branch. I have no idea if that will even apply to 7.2.6.

> Two unrelated findings from the same debugging session, FYI — I'll send
> them as separate mails rather than polluting this thread:
> 
>   * amdgpu_vm_fini NULL pointer dereference when the eGPU is surprise-
>     removed while a compute VM is being torn down (TB3 link drop under
>     load). Sibling of a teardown_processes NULL deref we already patched
>     locally.

Interesting, we should have test cases for that since that is a rather common use case now.

If you could give a bit more data (e.g. what timing) then Vitaly will probably be able to create a CI test case for that.


>   * (older, on vanilla kernels too) the SVM restore-worker livelock
>     under sustained reclaim — separate mail already in preparation.

Yeah that is already very well known problem.

The old KFD SVM code has a whole bunch of design bugs. Because of that we are working on completely replacing that with a new implementation based on the drm_gpusvm component.

This patch set here is a per-requisite to that which fixes only one bug in the existing KFD implementation.

Regards,
Christian.

> 
> Regards,
> Olivier

