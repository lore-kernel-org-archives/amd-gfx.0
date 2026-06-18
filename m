Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58656CD98F8
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 13:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E8E10E1E5;
	Thu, 18 Jun 2026 13:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="APo4yK92";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8531A10E1E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 13:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1hvPBojsv8qkRYlgTC0zkmFZFg6xTknP3HYdanSrfsKmFz7kC6RFi6Kbf11M85gkYpoyg0LrEZj3rKVlmnzsTrVodS9b8qdQI7kRgYvt7vmXEKHBY1q7o6E4HM5XgrpJ/E4sX4LVtzO08sAvRGWFcKQYePJheI5Sk/G9oPu5K9sws/riRCWb+Q2DlYXG5LJ73Cm/SZjVrClKyT+0lNX+bb1H1Yar7orc/lVQNsFfz7Y0Bpt0pzZloNFrCujS4JGYmInf8upjoOY6OT3i2GjORJaCfqAp+CnwElF+v/5EUByWYbNqNSKtQEaJUoAwwtBk71Cc9CE9mnUH5e/bv0x9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5d7QGIJpQsc7u6otozFMMzoeLREiN0N02K9tr1vCI4=;
 b=fqEP3T1R4yvKxjj1b0nITr6OpKcVOzj1Bf8XSeSmNlKqO1aSzt92pAtVPS11oe5X5GWSbf6CZQkZQENIK9zDFrNTyXAEmfNiyNxKOjGbZcgVO7Xc7AdCj6X13i36eQ6WZt5Es4XAkPtB3xdWe25e+fArFDqg1nAt8MXV7PH38zMM/+zsz8Kzl0wfB8iEwGNSmdxyJJKrp7buQUkjyHjvclCs2jfAI/X7N26sEMdaZIZVqm7/XHcsMNrK7t2YFfza0uMYL6OCbdDv2CA2M7agWV6gL3PO5V5gUZkzdvqPOv2a20UnQbyJ4qocWDE0NFrSakwhXmYBoh4bi6+aCOXtMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5d7QGIJpQsc7u6otozFMMzoeLREiN0N02K9tr1vCI4=;
 b=APo4yK92RRk54RbEJ6iXvizxSJY6C2X7QPJtixCYP18aMTJ1aYJHqSwU0CmtP23lYVYnN9G/gnWFcfkpj7McY3In1Gu6AvzLmASY93u2RK4JGGlXrnls7jvezjPbs+LP6CpBzVntqVyzWKgkK31PdLmRCpcMnBENwIJ537XzklE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9203.namprd12.prod.outlook.com (2603:10b6:510:2f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 13:29:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 13:29:37 +0000
Message-ID: <5b36b3f7-f2e2-400f-8ef3-f3d953bb328c@amd.com>
Date: Thu, 18 Jun 2026 15:29:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: amdgpu_userq_restore_all return errors on failed
 bo reservation
To: "Khatri, Sunil" <sukhatri@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Alexander.Deucher@amd.com, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com
References: <20260618105158.93562-1-lingshan.zhu@amd.com>
 <d2a07581-dae9-45ff-909f-a87795e0b472@amd.com>
 <151c36e3-ead9-42c4-8bc8-1585a7871f38@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <151c36e3-ead9-42c4-8bc8-1585a7871f38@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:208:23b::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ea7271-92d6-46d4-8070-08decd3da491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: GC3s1fFOAZrkOVTdcasqNoctbx/23zhgUc1d4TVpYk+hB+Z640TqL0cIdOQHPiyXMgCwLo7sidNDZHgNWuLiLDxTpGDkR+ta3pxFJ74ayLYSeqP7Y308Z0U8n9oQFGJTmt23FL4+PiB52QhzBcPn8AG5QP4TEefhNaHXgzdakw/AdywzBS+RPFA8T459V4MRas1uJaRBubWdefhPg8yW6IxqGvFtbQyzcNdR3i0fzKTMJlMGzTOdCziKV21IUVDHHJNZ+/dNNn6txMJmYJIwJKDQbcA1poHFvSYR+mtmC0baxN+4cEqCiJdSNUGEK+PR/jYx6IO3WIoj3SLZM2jLgXfizsiWZaVwVE5kovlcvUgppmTlQuaNffNEHF3WaCfFN3SnvC8JnySVQeOAu8+QB+sdGktMXkuMBIz8H7I5lu+ike3lgk1qWOM/MmooaPuX62ugorsiiHCHtLfBsFsT94WfiartcHIoKpt1SkJ1ZfmsSRYMsOwB/e+M7RpeKzJYI5HKypVp88hycDcQsHZvvKSrLbsfjudo4qiNiVYnrOkr+DXWyCdYKrIWY//CZU1DUa8qa78PHeXEf6iabQAdshKHwnm6JqZQRJj7vQO5MZSdJL0r0xkralw3G3q4P2m+Bp+HvCrN50IIAFGO1pLenxlAZscNl73aDcXYj+SLO0WKf3LdwQvjLkKE8tfAoQtz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2lteU92WmJTWnpsT0s4SFZTUTRyRTdjbW5SS21EcWJvcWdESE9GSVhTRStP?=
 =?utf-8?B?K3JkMlMzT0lWN0sxUFM2eEM2dGVKMnFZVTBKSEhtTjdSekxnWkF3Q04xUUlM?=
 =?utf-8?B?dUJOSFVJSHNNekpZdlNyei9Kc3RBTkN2VTJkTTJCVXdFVFFiVllzSHFUcGhL?=
 =?utf-8?B?dWJEbEdjREZERjV1UUhncmE5WFhSTGxSTm9DTWtNZFFYc2JuTXNKVVRrTVpV?=
 =?utf-8?B?bVY1cDRlWWduR1FMRVFlM2ZHUUJXQVJFbGZ4VDNxbHEzejFIdnd3NTVqMXFq?=
 =?utf-8?B?R092Q0QreXphSzNVdHQ1RDNyTzF3eGtadUEvSCtHaUJrSVNZSUFDTUE0VjJm?=
 =?utf-8?B?T0FTQmVmU2FpS2UySnRHS09iRmNVUEREYnY0ekRISWVzOUViR0ZtR3ExcGZr?=
 =?utf-8?B?bU9QREZibitJdWdTZ1FkOWN6bDlzQ0dDQ1ZmdVBHem1NcnYvcHVTRVl1amxj?=
 =?utf-8?B?VGVMalVkb0t3NmxhTFh3ZzlNT3hyQ2ZFQkFWZ1Bqb3ZFT0lVUDh2UXkzVFYy?=
 =?utf-8?B?Z1FUb20yeldzZG9uSVJKem1yWlM1bk9yQi95SjdsazN5TzVzVFZKVHFhWEVK?=
 =?utf-8?B?VTBMZ2taQWlVQnJUcVFQNkg4ME56VURVWWFKeVpKVHp0MXNWOFJRb3ZWVlZN?=
 =?utf-8?B?WThCb1V0M1FLUmMrQ25BYktMK3FUNWR4TDNkUWYvMHVscWNnc0tTVkR5OUFG?=
 =?utf-8?B?bHZsRnlLZTc0UUJzWHlSaGg3N29MQzJXOEh2OUg3VEdJblVIZ1Y2MjFxZmVx?=
 =?utf-8?B?SDRUOTNaL0xXcDF6aUx4dWVNd0QrblpnSVRDekNJL21FcGxKb0h5ZVdmNkpK?=
 =?utf-8?B?N0FjY01rblZZWi9zcHc4ODlsNmZvWHhpUHRyVjgyVzZVVlZsVExJeVczS0Ix?=
 =?utf-8?B?eG5YVnJEazdlWTQvR0xQNkR3YmJDUmJFNUpPN3M4UE1IOUFHVSs3amZrQUVB?=
 =?utf-8?B?cmgvT1pEdFREMy81bVh5U1ZuaGhtZ3ZGck1EZ21BZ3puK3lTajZ3WEF2RTdu?=
 =?utf-8?B?SFNGQ3hUQW9tTFh0aEQvbUM4TmZHSll5eDB3NU12dUxpakVtc0E4RGJJL25N?=
 =?utf-8?B?RkgvaS8ranZNMVNsRncyclhranlYN1JhV1gzUC9ycW92blJ4ZDFuRkhDRUI0?=
 =?utf-8?B?aFNXS0UzMUtUOW96ZTh3SDdLUjBhYmgyY3RWa3FMQ3lWeWV5bEVEY05KV2Qr?=
 =?utf-8?B?UDVSbjNsK0lGdkllTndpaEpvcjFIZXZCZXIyM05Vd3lQUkRYOHdTbW1taUNY?=
 =?utf-8?B?cStVZVc1c0pHZjR5UjkzaGtxQ1RaUW5oSnFmR2NXb2RzTi9nYWZleDRFR3JT?=
 =?utf-8?B?Y2p3ZVY2NzlvQnR0VmsyelFKQkNYakZOVEF2S1A4VmxtNnJiK3BHRlRBbjhK?=
 =?utf-8?B?WE13RU8zOHNTa0NMWjEzKzhNN0dxYUdqWnNiQlJqczBpcjE1Tm1sdWdQczNL?=
 =?utf-8?B?WlJXdWV2bXE2QVVCUy8vOWFqTHljTThtZFQ4SnNReW92YUZWVW9lWDlFTFVQ?=
 =?utf-8?B?YUJLa3hldGNsbjVyd09xTlBncWxZSXJGY3htNHpaOUdKQkpwekhPaExLQnlz?=
 =?utf-8?B?TFBzZytERjBiazRhYkkzcGIvQWdaTEx0ZzRiQ0ROM3BRNFVTUUJRMG9QRnl4?=
 =?utf-8?B?NFg4Z25lWnZHeVRSUXcyaHI3VkNtWW1VY1JCWDRIZllvRDFzT1MzSUFGbThP?=
 =?utf-8?B?b0VNS2kzL0xaVXpxajdJRlhyZWNzbmFucGx1SzAzaEJpR0IyUHM2N1JBMWtW?=
 =?utf-8?B?ZG5yT0ZJZWN1T3p2TklXb0xCZ1FGU0NJeVZncWFhOFgyTHh6bW0zT2xKR1JY?=
 =?utf-8?B?Z0V4ejIzUVdFQ0Rxc0hydGFzVUF0d3NjSnFCNTdVeXVXR3Fqc0QvWHRUdHZD?=
 =?utf-8?B?bUZZSm9JZTJmV0JBcS9GVGwrY2JIeUltdXBFRnRSUEZuRnhqYlUyWVFSOUgv?=
 =?utf-8?B?TnlpSkQwdUo3VVkyWlB3MWFuL1l0Y2lBRU1GK1ZQUGtkWTdYVHI5MnR4YzZK?=
 =?utf-8?B?dEZWajNVZ1ZuVnhKOEVjT2FnQ0ozQldxSHBOMFQwQlpHcitOenV1cnhhT1Vr?=
 =?utf-8?B?K1hWZnpKcE9DbXNEeDhkdnlQT3drUEhZNGRNQVBDbWMvN041bDJ5ejNTS3Rm?=
 =?utf-8?B?ZXNBdnJ4MmFsQjRkbUF0NG9pTlVZaEFZSjlBbkN4NXhxUnF1b0hkaE9CSzZT?=
 =?utf-8?B?VWljRkgvLzRyd0h0aG1aWTNNa2pkaFV0dU1wckZFU1Y4RnI4TCtVbXRLQjlZ?=
 =?utf-8?B?cmJ4dkdJNWpEMFhQSzBMK3dpdUxVUkl3V3dWQWxXZmVNQ1htb3ErUTI1bVF6?=
 =?utf-8?Q?LsnzIeL/4rQsivpHSY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ea7271-92d6-46d4-8070-08decd3da491
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 13:29:37.4043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oANXmjfa+tVxkPf5LAqSjICzahToX6oJ2gGhYft+Y+xzXo6HGJQ3fj6Bq7PD2cE4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9203
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



On 6/18/26 15:18, Khatri, Sunil wrote:
> 
> On 18-06-2026 06:12 pm, Christian König wrote:
>> On 6/18/26 12:51, Zhu Lingshan wrote:
>>> In amdgpu_userq_restore_all(), when failed to reserve
>>> a bo, it should return a meaningful error code other than
>>> "false" that means SUCCESS, which is wrong.
>>>
>>> The caller should not ignore the return code of
>>> amdgpu_userq_restore_all as well
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 95b680fc88c5..8b14870afbf5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -894,9 +894,9 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>>  	unsigned long queue_id;
>>>  	int ret = 0, r;
>>>  
>>> -
>>> -	if (amdgpu_bo_reserve(vm->root.bo, false))
>>> -		return false;
>>> +	r = amdgpu_bo_reserve(vm->root.bo, false);
>>> +	if (r)
>>> +		return r;
>> Good catch, but that amdgpu_bo_reserve() is called here is a bug in the first place.
> I think i probably missed that. There is no return value check for amdgpu_userq_restore_all and this cant fail. We should wait uninterruptible here i.e change false->true and drop the if condition.

No, dropping and re-acquiring the lock is a broken approach to begin with.

>> The call to amdgpu_userq_vm_validate() must be moved into amdgpu_userq_vm_validate(), right before we call drm_exec_fini() and the manual call to amdgpu_bo_reserve() here dropped.
>>
>> Otherwise we have a small windows where we drop the BO locks before starting the queues which could make the VM invalid again and cause all kind of issues.
> 
> we need to maintain order of locking First reserve root bo and then take mutex else we had mutex deadlocks.... this is why we have added root bo locking first before taking mutex in next line.

As long as we do that in amdgpu_userq_vm_validate() that should be unproblematic. The VM root BO and all other BOs are still locked and acquiring the userq_mutex shouldn't be much of a problem.

Regards,
Christian.

> 
> Regards
> 
> Sunil Khatri
> 
>> Regards,
>> Christian.
>>
>>>  
>>>  	mutex_lock(&uq_mgr->userq_mutex);
>>>  	/* Resume all the queues for this process */
>>> @@ -1133,7 +1133,9 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>>>  		goto put_fence;
>>>  	}
>>>  
>>> -	amdgpu_userq_restore_all(uq_mgr);
>>> +	ret = amdgpu_userq_restore_all(uq_mgr);
>>> +	if (ret)
>>> +		drm_file_err(uq_mgr->file, "Failed to restore user queues, ret=%d\n", ret);
>>>  
>>>  put_fence:
>>>  	dma_fence_put(ev_fence);

