Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C21606D82E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eexs7Eid
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C155112E12;
	Fri,  6 Nov 2026 14:18:28 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491BE112E12
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 14:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSxQSjLyR7uJGe5ZXEbtwhjRWGYz0uOwvVEMr1dARtX0RZ5V22c+3ZY8y8fbdcB5chwARuobNsQuVSXEHPa8KUCkcGlmPkRN80LcAdOUmS68Mkdi5bapDznv8DYHc256EvYxK9NgD77FMJAAfnjIWskB4NFWsdGXFQ9HS/8Ek+I1gL58jhu3j2YaJdSRaDvMlY1Oc8JEdb+2DnQpg7wIjCUYY02an2m30kUPrNqy9IOx+Q15RcY9BJs5cXGkj18Ip+gyt/q0LeDUWy4YFlsUUaTNnfSI5kHQin7uGEF29zV5Hrl5ud0er3c94jMICIpNy97wUhoV7+WtP0x5gLg7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6ubIuwT6hTND2hbWTmC1cR9wZWHqtr/f0tN6LDDQs4=;
 b=ixVKfkSp1Xv5SCewUdMUUq4BCZjeJNn94k2cetC27I5N9cBXKfOoCw9E9dMtdnXkKSgG0TBXHzj1Pu6dlCi7NvcbrBdNygZanpXwKs6hpqPiWFq1ni157tkHjImbXBSUzr+TSJA5pXLspQjU2BKE29l98ffAnCnHDdLVrN3cXji69k3EKLyKeV1I/mtmZ8ULy0OP26jFzrocDsef3LeKn7QT4GV32Az91oWg/EXEKnhLKxalbez2LEATmNgUfUAHQdmFnOdj+toNAqTkAyzDZTS4wPKwWUE0QsG8RQVDhGryKzUQ8ZeQ5u0SCoPElag2uj1N8J+Y1X8olQ2m2gfNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6ubIuwT6hTND2hbWTmC1cR9wZWHqtr/f0tN6LDDQs4=;
 b=eexs7Eidf7bIN5xiYj+M+ypHm9w7yUyDXyyajvWa2osu9UUiQubP1Hl+VdoaSP7pyXGODehj4CAtjN+nllJ198YH85rAhmUYGY51/pZrYaVZAiuZ7a/Dda+aZM5/TTL2Jum/ZqzFDPupmK8DO/IdLxpPPEBKp3yC/0B/vul1pT0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 14:18:17 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 14:18:17 +0000
Message-ID: <76cbeae6-fb4f-4809-bdaf-b7fe5f5bd5a1@amd.com>
Date: Fri, 6 Nov 2026 09:18:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/vm: free pte update job on error
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Shahyan Soltani <shahyan.soltani@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261105210020.3852328-1-benjamin.cheng@amd.com>
 <20261105210020.3852328-2-benjamin.cheng@amd.com>
 <de2d1b55-bfad-47bd-843d-2ce98006103d@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <de2d1b55-bfad-47bd-843d-2ce98006103d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0238.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::18) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 6491ab06-4d5a-42a1-ca3c-08df3c10cd51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|261102123227099003|22082099003|18002099003|261009223027099003|11063799006|4143699003|261022105027099003|56012099006|261021123027099003|261028144727099003|261021121427099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 5evObhLp5RRGcy91X8kUmbXHumcLOqRHjJHcEMAtae3DpFX12VmvBkXpxz+KFgYaQsj02oBnWXmsC1sAeuoWaTij8NoDsI7e37kN1VWWUw47/iQEvXGFA2snQdsQ3izAsawpXy/CurSV16STPlKap1+/OjJPo81Ra0zoPSz7M5yIMM5lhzA8TG07s2P+BiBrnfml0V17nzpFB0u/+eYVwO1zTTVypAHLWtfm+XSbbdgNyWZyp8pMVg9g9g81mZtXJQCTu07Z0GGAzym/dV+WCjxrWRHLiGe5FUQRBH+yw3XXgdGsogEuNiWLkdJoLeO/2rpWGhHvQONL8hrD3e17NyguH6MAcp38a7/ltH21JA3XHvoifdfaEwB4yWckDIwSmUaDq3urCnBqozqG4SXX06gEWAhyB6ljK9ABRy/2erRmhfu35VY/GgD/CDfIimpFbOtRL9BX2isy7OJNUN6mW25JFO4WkvQA9Ras/O1gt/P2G2AjCANqilO6gu8Pc4d/ebkzTCvh/TQyV/JsQ9iuuaBMvCMzrc0pzo85R9o54PY13aLg3A2ivNuI3HidwUqImyr8hRNd68lka5MvBqz6JjhJCRqCktj6WxaE0F1j1Ta/qi5HpWzW2mY1NNsAK8aKr1ZupAzmKV6Aw+q7Z7GM22mjjNQKIcD+c4KyPgpRJO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(261102123227099003)(22082099003)(18002099003)(261009223027099003)(11063799006)(4143699003)(261022105027099003)(56012099006)(261021123027099003)(261028144727099003)(261021121427099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm1STWd1ZU8rU05uL2dSTmMyQVgzT1FJQlZiVm1SK1RML2NDMWN3a2ZWL2w3?=
 =?utf-8?B?VnlzWE1zNlRUVzAyYzhjbm5iVFV0UE5yekFyZTNwczBXUk5EaWpWRDhia3NW?=
 =?utf-8?B?SzJ5VFk0ZzEyQ09xdmJNampzNGZXV0ZhbUJ4T25BNm81U2w1ZW5vZGxsNVk0?=
 =?utf-8?B?Q0F0ajBvdWo1VnRXMlppN2ZacHZyWEVLaVhwSHVja2dFS2J6ZkttM1I1R0I5?=
 =?utf-8?B?eTZaWXpNMjd2d2s1YXp5dmg3WVNMM1NieTMyaU9XdXhoZVA0Q2hzM3BvczNK?=
 =?utf-8?B?RGNyTk04V0xOTGNVcWRFSHFFQVRpZWJ6aFFPei9tV2FhQ2Y1Vk1uTFV6amtU?=
 =?utf-8?B?NUlNbmxvRy9EZ0NXSFNqK0VCalF0NkZuL2h0dis3czkzeUp2WG95TXBpN0pV?=
 =?utf-8?B?VGkvUEtvU2MzeEZCZWFLNWZKZERxNjZKVFFyUkt5a29yeE9ONWxoN3RWQ2g3?=
 =?utf-8?B?UjllK2ZVUS84Vm5RbStPV1ZtWWE3U0h6MG5pSXhacmZDc3pweVE4VVV4M0ZB?=
 =?utf-8?B?MUtlcUlUZ0RpaFA0YjZhTUs1V2ZzeVRiVm5aYlJYNS9NVVdOaEovRGpyL1k5?=
 =?utf-8?B?NjduNjhlNFM1eWwzMmU4OGIyM0lkSWorYW5uQ3VFeU10SzYzU2VjNUUxejZk?=
 =?utf-8?B?dEQ3VnhFVFVRTkdHVEg4akg2N0VrUnpkQ0xLNTNmQlRQZmMwdUdQOXVkUlpC?=
 =?utf-8?B?aVdyajBpT054M1ZFNEdpaUYvZktxVlFyaFpqM0tXZnBVclRROFlXVWEzT2JY?=
 =?utf-8?B?dSt0YVRoUm9wcDlCYXpXRGlRalBjMjU0T0pTUEJmRHJJemZ1U1NPRnpoUFIy?=
 =?utf-8?B?UHBpNEd0eHV0aDJBNEhpcUNIS202bTNTaEpqOTJ4bm9Yd3l1WUFIOGtucHJj?=
 =?utf-8?B?ekxJQ29qTk5nWnhIZU9UVDMrdjFPZVJvNlduWlNCR0RLY09sRHZkeFVUTm40?=
 =?utf-8?B?M1picE9MTDd5eWx4UE5qU3g4N2RHVTRvU3pnTndSK3h5WU9CekNqYUR4bG9E?=
 =?utf-8?B?RHBnaGJzT3lKelpYZmxNNUlSR1hDWFdrMnQ0Wk1WTFBqK2hRZGUweE1FM21H?=
 =?utf-8?B?WGtoVnpLdWRCSHRJZVVvYnBnZ3BNQzRxOVFjcW5lZExvMmN1NkI4Q1Q0REVG?=
 =?utf-8?B?a0lnQi96M0YzMENxZlZoTzhZRGxnS0hRTkMwL1ZNTmg4bjBJR1Y4ZW84d0t1?=
 =?utf-8?B?OUlUY1VPWjZ1TnkwZGZkcDIveWZpRm44Uk41SmxjSkJrTWFDTHdjcTZUTkUv?=
 =?utf-8?B?TjlNQXpVWG5scE1JeVRxSnlGSFJTelBSV2FzWTBkRTVkZlpWS3VpVHo2b3dr?=
 =?utf-8?B?UFYzQ1NjbDk1T3hsK09Sc3lCY2NsREFiYmZMOGJVSlZwNm92VHFJc1RuRTFt?=
 =?utf-8?B?U2Z2NWxZNXRpOVIxR0Fndy9rUVNpSUVFVVkwMW1VaWVOM0p1Mnl3U1FURUsw?=
 =?utf-8?B?M2Y5OTYyQ05iVGd6RURDa3NlNCtLUUN4cTlJVlptTnlVN0JWTkNaNmpkTlRM?=
 =?utf-8?B?eFlhWXV4QW5nRmd5aE9FVWJYWUphMnNmcW12OWdSakxzZEkyY0hjRkVuSXE3?=
 =?utf-8?B?UG0zbUR6K2RuODdCWE8xWjcvcy85TEJYVHhPS0tEYytFOFlhUkFnRDlzVzVY?=
 =?utf-8?B?VlV0c0grb0h6LzBPdDZLQVNEZFkxdnBXTGp2QUFvZkZXa29rUExsV0YwK1JL?=
 =?utf-8?B?QitFa01jODJxeHBqMHZFUlR1NzJYOGRxaDh6KzJ5cVNLZjJaR0s1elhpZEUz?=
 =?utf-8?B?Uk5DeEM0T2FvVmtrYkNRM09GMTdZNS9Gb3YxbXgxdWNuQVVpc1VrN3FadDNN?=
 =?utf-8?B?STRkdmsvaVB6QUl1TmNJTFZkdW00dXNJRnQrRlFNeityWU42UjV0UzI5bm9x?=
 =?utf-8?B?Q2JzZVhzS1I2cExneTdhMXAvT3lPaWMzRXlibEZnOU11UDZLd1RmSkd1aGFx?=
 =?utf-8?B?Uko3emFHS0p3blJRaXZyRjgwUTloc3A4Y21Cb04yOG1vR1k3UGdHdGdDMzVV?=
 =?utf-8?B?ajdNL0hNWjNQS2ZuR1E5QnlMdGZsNnNmc1Q1cE9QOFVWeGhlZGhNMzA3VGVs?=
 =?utf-8?B?WWFRZVMrbTFhaDAxZVFnYmZrTGlxN1YvbDlBRzl0UjFSdEZ1R0FCSEZKdUUy?=
 =?utf-8?B?ZW5CL1BNaWg3Zit2ZmZTcy90RG04dkNTL3hIOVl5Z0orbmtNUkdvOElXMXRC?=
 =?utf-8?B?L1c0Z3ZFM0ZQWGRkSlV6WHpwVkNoUFF5Z3lVTjBVOTl5OU9aT0ZDVFU5QUZ3?=
 =?utf-8?B?dzE0SWZ5aS9RWnBYcm9RSlE1UmJEWTZsSng0OGlhTUFhMHB6VU9hcE9jd05N?=
 =?utf-8?B?eFU1cVRJK2Ftb3dHSjdzU1U5bHpoYlN3LzVWU09vN1lvRS9QVndqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6491ab06-4d5a-42a1-ca3c-08df3c10cd51
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 14:18:17.3287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hX9gtxHjv3idfbv9s8NTsyHu9mist3sqQIhO/SbKLboNhgcILwTwTK564S/tLUzmV4sEOOODHSfV99QowAV1rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
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


On 2026-11-06 03:55, Christian König wrote:
> On 11/5/26 22:00, Benjamin Cheng wrote:
>> In the happy path, the job gets freed when the job is submitted.
>> However, if amdgpu_vm_ptes_update failed, we don't submit the job, so we
>> would leak the job.
> Yeah that was already brought up upstream as well, but that here is the wrong approach to fixing this.
>
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> came up with a few patches on the public mailing list to tackle this as well.
>
> Essentially we need to commit PTE updates before we allocate any new PT, background is not only that allocating PTs can fail but also that we need to drop the lock for this and that can make the PTEs we already constructed in the SDMA IB invalid.
>
> I wanted to get that fixed for weeks but couldn't find time for it. Can you guys together look into that?


I see, thanks I'll take a look at the previous patches.

Should we consider reverting commit 009f401fb98b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location") in the meantime then? As I wrote in the cover letter it exposes this issue and can now be detected by IGT tests, which makes our CI flaky.


> Thanks in advance,
> Christian.
>
>> Fixes: 009f401fb98b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 2ba33212d507..f6cb2b5854dd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1274,8 +1274,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>  
>>  		tmp = start + num_entries;
>>  		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
>> -		if (r)
>> +		if (r) {
>> +			if (params.job)
>> +				amdgpu_job_free(params.job);
>>  			goto error_free;
>> +		}
>>  
>>  		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
>>  		start = tmp;
