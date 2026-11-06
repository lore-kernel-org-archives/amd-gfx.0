Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B90606D813
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fg8q2Hrl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C8E510EA98;
	Fri,  6 Nov 2026 16:07:43 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21FA610EA98
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 16:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDknNpCyMVIZ4nnbpsUDQFiPAYVk2G5vEFEQZgx/Q5ShY4TWH6mXyyBhM2bSUBHlihO5260e/OOx1gvxBu3SDRyzDc2CnYm/67I1H+kc5YNk/aVeeDB7+0PO/CPxFhhuOm1y4qVQrD5/ykIm57IR4vu0RX+UHFgVk57VlQh1TewmEMsaNbD+/N2NuphAKRAMQ5Qd7HjvDlAdznuKq0IpNlhbIi9DnBB9HT6eDDt9sP/VjDhYYJa9I/fKgkIKoE+eiZteqnJc69nGrseXQy15KwtFJNYyOPKFri8AAQ2QbZHE7/tOcGoFw6lVpz6tV5nIfLFJoYS4MkPF82EYCa3B/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEGUD5I+fHlCyoGCfIT8KrfAC7dtBq6HyN3RPOKRY6c=;
 b=Q+WY/aGXlOwUfaud4U1HEShCRirpDq+kdQNvqDkH6psxp733zS/2wDeYPtx4MNQOJiS4NDCTZNq8rNJ/rm+BuYUZBRizOOvoSiXwnxLQouUQIj96NHaVu0iDUHSUBkLKjz/phz6PesnXcYQSQFNMiry/0fEDBElBJ4oIyDk3fKEA+sgxx0eFatzV/CtwytYFJY6/BXJKFM36bdM3vDNX3FyuAdUFdRVKEcAsfuycPHE4tVL2ALu+UG6bF48BfOXBjWm0QPn9qpTSfNvDWHETjJ4dAHJbDuP+DGkA1sonK42a+85CLvXX9vdzP7ZiEJ8j/urVW64zIF1Tl363p203JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEGUD5I+fHlCyoGCfIT8KrfAC7dtBq6HyN3RPOKRY6c=;
 b=fg8q2HrlW6xnltKIedvAs92zL19tkPopXNo84yHE0x8sq1uvrAWAJOuuwlKdcRFnPH7w9qho8zDTD2bjc8b0RjZPQjxOogRnwleYYQ8h2BKvqv8kZLa4bDQ24yJEdqjRcCLcVl/Bveb2bP05GbA/ECtvPPOXKmT1h1qhDuChlCM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 16:07:31 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 16:07:30 +0000
Message-ID: <0fdcfb20-3c4e-41fc-9b40-55fe58f2d210@amd.com>
Date: Fri, 6 Nov 2026 11:07:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: wait for tlb flush before freeing BO
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261106152031.4040973-2-benjamin.cheng@amd.com>
 <26bbdd2a-b26a-4e76-9eba-092a7e61660c@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <26bbdd2a-b26a-4e76-9eba-092a7e61660c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0342.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::12) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db82fe0-c422-4f64-304d-08df3c200f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261028144727099003|11063799006|4143699003|5023799004|56012099006|261022105027099003|261021121427099003|261009223027099003|261021123027099003|261102123227099003|261026140227099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 7a/zF+hKaoGEN43+CEfCzKIC5UIuGeGmlwyr8JYr7wolS1TbbNX/vsd8/ib3+FnS8/AQM3vDhz26TpAk0Caq1Lux/3oKzKJXip8hmpb55OcuAyv22KT7Z7sQP/3yM1gAtGvJ4IL9jq8S2VEu+6/NdIyHcLKFDon294lsg9kpg3yCLlr0e5WDGY7Yj74YQkzGpJE8ytaMQZ+jY1M5x4WIva3+KRFodze38NNuimLnVBQ+Jn3ccrvS6Gwv3VJu/AmWGQ10iKryW9Rs3a+PInwjzq4Q0a0GQrQX0GhppXdYRSLRI/fund9YuAvES89SRm2poBnLP7tMwd27tEAJUjIaz+8h+ZkbkOM44Dv9WTxqSu/GkNdS1+NUVYdT1ohfOi4fFAbMDS0VWuTPXRyZ2SGM1vZPxYUI1lL3qRHyepjIofLvSUd/0fQcC1pFavI0i7XLL06DmtC9OexJzzKEUYCk4y9Oi4Y0p8Sgrh3dbFucMC5t041un/6dQz4BMgN1bDZ7kVFd/3m+Gb1uB1oFphL8oYf14RdzTrfOFrejti7HS5dKI2DhfF+pGlIfRmd2bZarTqtyiXd8c+k+TcwkkMGVyRDXW8Ch2aFK+Sd3YXxAlCTt9XSAqXo6E+OcIQfeLR5zKog1A1m6qyGVo7lv1a0QaByXi6+cdplHJnHoMUoXCrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261028144727099003)(11063799006)(4143699003)(5023799004)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(261102123227099003)(261026140227099003)(22082099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHY4ajlmZXU2ZVlIRkljR090aVhnRG0zODd1YmRyS2Vlb3dRQkhHZTdtSnE1?=
 =?utf-8?B?aFkzRDV0UGo4QklYV2hxTi9DZWVPbnhGekFlcGNjanliRVhCbm0yWmlRbElR?=
 =?utf-8?B?bkVFdlFGc2thbi8rL0FSSGZXQWpFWTFBV1huU3FFV2laci9XZHdIRkhRam5S?=
 =?utf-8?B?enFkaGhhQ0JyMzlIS21SVUNzMUlxdmxCMEkwTEF2MDEzcldiNENROUpKSWVS?=
 =?utf-8?B?UGRWKzJYQnRtVWNmNUg2WktDNUlBWEdRaTZZRFNvK051Tm9GTTQ4WHYzWklN?=
 =?utf-8?B?SlBKOWNGQUswK0Z1OUpCMHFwUFZjYkpEaGthN2dkd3BOTlJMMTZPSUs0ZVJO?=
 =?utf-8?B?ckNaYXRUbUxOUW1wSWRmT01DN3ZaRDBVcjI5a2FqWlZ6Qy90UzhEcGFKOVAx?=
 =?utf-8?B?QTM0c1Q0aDFQZWdEdzRKSTUycnR4WldWc2IxTWJFcXorV3N3bGVSMksrVUxB?=
 =?utf-8?B?c2NoNXNrNyttQ09XQTgrcFF3UVYrcEF0WERFeGxtclpyTHJpeWp4MDBzV2Zq?=
 =?utf-8?B?OFp5UHdCSHQvdlJEeTFSOHRWR2NqN3JzdTlxcy9qcHF4R2dLeXBGWHhvY0dG?=
 =?utf-8?B?SC9tVmI5c3kwR016MVl6d01XU3o5QjhmSk1OM0QwVTVtdzZqbWNOeVAxb0M1?=
 =?utf-8?B?dk9LRUxoZVdQMWJ2V0IrUW9wbjErRVc1NmRqZ0IrY0tvVUlrVnZhUklCdDFu?=
 =?utf-8?B?MXFackRCZWNCbFBCTmFsV1oxc3RtOEJTYjJyTG43NnlFN1I0WStISjV2SndV?=
 =?utf-8?B?RmhIR1JIZHU4Si9WWWhEU1g0ZlpxbXB4R0w2OHJaWlJmTGNYNkYycHRiZWNx?=
 =?utf-8?B?RGtyQ2JLVzlEWVRLUWc0a08reHREclMvRmpCdEM2SDRWZ09GOUZBZVVzRlNp?=
 =?utf-8?B?dThMZzYrQjVqV21CbDZHN2l2b1YyMFc2QmhXYVRyZVREZHJCMjNKVGZ2eEVq?=
 =?utf-8?B?alJoZW5qWU5uS1B4eTRoZXlVYnRNOElSb0gweTE5WUdTRE40L1l3dk1WNE5z?=
 =?utf-8?B?Ti81YW44Y3E1dlJQSUNGZ0VkMlcwWUZMOXB6UWtSMUc0YjVwTmg1QU11aE02?=
 =?utf-8?B?QzBXV0x3bW9PTDNIWmhQNXdmRURZMmxsUkxsMGJIY0duc1VLT0FCWlBWMlBC?=
 =?utf-8?B?SVFrYWd6ellrMmI4U1BNeWhzakJFQTJqQk1kVWM3bmJEUEZ0SVZzTm5MSTNN?=
 =?utf-8?B?SnNpNkxSWGpSSDdwMXZFQkpickdxdjA1UlFRMnRnU0p1bE9DeWV3WDNFQU9r?=
 =?utf-8?B?UFpOUWFYbHBYVmtTcVVtTENpRWgvdHpkWDlXbEJDQk52NHIvVW80ZnVNUGYz?=
 =?utf-8?B?ZldUaWNEdzNKeGU3ODc1U09mUUkzQlBqOFRZQ3kzK3RIWHlMUXZZK0ViMktw?=
 =?utf-8?B?a09KRXk4UnprcG5xa3lRV0VKZzRjWWtYNU1ETXNta012QkxrSGZPR0tabkxL?=
 =?utf-8?B?TkM5Z253OXdTTDZ3VVBscExZazBJazRKdk9UeE5pNjJvc29Va1dFdHc2U1pL?=
 =?utf-8?B?d2w3RXV1NndMbW9vT0g0SVZtamtpcDNUZ3ZoRkFHOFdlc09LTUhtL0Jvd0Vo?=
 =?utf-8?B?K2dCUmt3bWNZbzdhMWZGNk1wYk9vUkpTK2pUZWw4ejkvOFpGWCt0MW16K2lo?=
 =?utf-8?B?QXNuSVZuYXJYa2FzaE53cXFvbjgxazZ5WmRpRElTYUhGdnZ0cWVaa0d6UExh?=
 =?utf-8?B?WVAyYmY5TGRaUUQ4cXBqTTdoSHlOTzVac05qaVo2R1ZTS0dwNlYzbk8waFJO?=
 =?utf-8?B?L1dZanErclltejd4d2haNUpqV0QzakM3V01OVnp0NjVOMm9JTWpDdXd2QVdB?=
 =?utf-8?B?WEpmS0VTc3pnVXRuZldYeHhLanlzOEZwUUhjSklUWkNDZFU0d2d4K2U2RDdN?=
 =?utf-8?B?aWVUcytScXFZZVczakxzTStOd1pGM3NaL1RqNVZ1Vko0TFFHT1pBWE9hSGlo?=
 =?utf-8?B?RTNaMTJJUEZ6Wk0reVR6Z0hnL2ZZQlJITVlOdHV5RVFaV1I3WTRqYUluZURR?=
 =?utf-8?B?ZmxxWGFiOFl2UWdzY0NkNmxFVnJBUFpqRExwQklZTlM2bWtITlNxMmErVE80?=
 =?utf-8?B?cE5WbngzS1JZUEZBN0RtWXV5eUVNZlFXaVFrSDdDSVg0WlJncWs4OWQ1aVBC?=
 =?utf-8?B?Q05kN3FhcnNJMXpNVDVBUzM1NGZOblNOUHo4YllxS2FPSWlYZS9nZnZ0dm4r?=
 =?utf-8?B?WHJKQTYvQWRhcm9jRFlUMHRYS05XS0xqTjFxcXlQamZkY09sQ2hCNkRBQm9h?=
 =?utf-8?B?U1ZNWkdScnE5Ung3WkRWRXkrWm9ESDNrb3hsYlpWREh2eGZyZXBwWXBNdzZ6?=
 =?utf-8?B?L3k1d1RQemlEeThQalB4QS91WWVvRmdYVC9jTFlEUlV1V2V0OEUwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db82fe0-c422-4f64-304d-08df3c200f6a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:07:30.7454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbVvpD7QwdmRC38GrTPZ7jDhexdfLkseekM2Mu1MCkgQWGuPG4To5ASvkp/y31xys4cmv06AgbGTprkGKibpmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 2026-11-06 11:04, Christian König wrote:
>
> On 11/6/26 16:20, Benjamin Cheng wrote:
>> On gem object close, we previously only attached the fence of its own
>> clear_freed() call to the BO's resv. If an unmap of this BO happened
>> prior to the close call, clear_freed() would be invoked, leaving
>> vm->freed empty, and no meaningful fence to be attached to the resv.
>> Because of that the memory may be freed before the TLB flush is
>> complete, and give a running userq potential access to a stale
>> address translation.
>>
>> Fix this by attaching the last_tlb_inv fence to the BO's resv.
>>
>> Fixes: a1d201e16940 ("drm/amdgpu: enable GFX-V11 userqueue support")
>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>> ---
>> v2:
>> - Rebase on "drm/amdgpu: fix TLB invalidation fence handling v4" to get
>>   last_tlb_inv
>> - Move the fence after the clear_freed call to make sure we wait for the
>>   right invalidation.
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 6137ab4211be..36b0bd85616f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -371,11 +371,14 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>>  		dev_err(adev->dev, "failed to clear page "
>>  			"tables on GEM object close (%ld)\n", r);
>>  	if (r || !fence)
>> -		goto out_unlock;
>> +		goto out_tlb;
>>  
>>  	amdgpu_bo_fence(bo, fence, true);
>>  	dma_fence_put(fence);
>>  
>> +out_tlb:
>> +	amdgpu_bo_fence(bo, vm->last_tlb_inv, true);
> You need to change the drm_exec_prepare_obj() call above from 1 to 2 since we are now attaching 2 fences.


As I said in v1 of this patch, amdgpu_bo_fence calls resv itself.


> Apart from that looks good to me.
>
> Regards,
> Christian.
>
>> +
>>  out_unlock:
>>  	if (r && !drm_dev_is_unplugged(adev_to_drm(adev)))
>>  		dev_err(adev->dev, "leaking bo va (%ld)\n", r);
