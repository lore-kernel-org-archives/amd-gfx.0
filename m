Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498BDC982D8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 14:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB8610EF68;
	Fri, 18 Sep 2026 14:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V4E7Uukn";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2000110EF68
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 14:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFt/7PddhspPVyswiv/CV0JeljsS680aVVxAqPXt6qRqfX8Nldz9oFqnQan0lWJVkYCDNqaIEMc9Nv8HV2dOhe3I9k6ScnqG+5NixAjc6kflLEdACWM7SIVJD5y3aoG4rpmiNlkTocULFFcLJiXpqRiiVS/mRZy/ylbGSxBE+ndmcTk3KsRJRe4WWhQl5geIydxGXmTzg9yLOCHBweqMJVrTaJtgyLW4PisYZF28AfSmfrFYDX6xHDQ3tsT48XcMk+nlGWNcQDybl+nwUVtyDUZT6jXhMUpLfkMMdOK7QALA1WvVe3NkzmME9YtL/2/B/ep2CuuzPFDUwVccMU7F9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXoGH28J2iK03151+r+kPwcEA4brYvn2C0g3fWE4oQM=;
 b=VgoT7fCgjfAXJoB/EZU2bOQR8lmHtrIPBIokIULAgrP1m8FlX48tE66yI45glS1kFuebw3c4S5mtgnvTTfzsqZc8SVACeurRi2nt5Q20HEFtFwq/bQnzbSnTgcpApHXfJ6UHDUwWk4WZt/HSaiIQTXiL+BskmZprCsnS6yhiakHFmPq8OydfEbtJzBeHCWDzXPtWe+aDYd9hX9u5DhFFH14q7dkyFFmAWHL1yNjsKPuoOVvl4zAaSz4pzmgW1D4wzyN70Ns2WK7kMj8blv07kba71mDFgjHk3c/JaH8Cmc097XZlOD8iA3t1mUNTs28KeSiDVrByJ6qENZkAt2Q7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXoGH28J2iK03151+r+kPwcEA4brYvn2C0g3fWE4oQM=;
 b=V4E7UuknkNQ+7zeBFv8u8gpyvBJatJWcWq9nJTOxgEvkbW2WkUAsVG195itFZzgypJx/+cJCAfMR0l5XJV5gvmJPWvfK0ikLtFVgPEU0ED0kWzGcbAn8KQmCjbc1BB6FJM09u+acveawPt4YozxK2Xfydu6vp/d5LJ3roA7FzPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:32:04 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 14:32:04 +0000
Message-ID: <6a1d885b-56bd-4b08-8d1e-cf0967bc7a14@amd.com>
Date: Fri, 18 Sep 2026 20:01:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] drm/amdgpu: More compact VCN IB emission
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20260918120518.96922-1-tvrtko.ursulin@igalia.com>
 <20260918120518.96922-2-tvrtko.ursulin@igalia.com>
 <474139b2-c3c2-4d2b-81d7-e209231870f2@amd.com>
 <84ae6c9c-6ea5-4e02-9dbe-5ba855580da1@igalia.com>
 <de963600-ba53-4e34-bba1-2a838cbc2457@amd.com>
 <052c9390-8906-4f8f-a501-30730c41f011@igalia.com>
 <04dc6bc5-4fb0-4e8b-a3f4-bc681ddf0b73@amd.com>
 <720027b8-deec-4953-a1e5-8b1781285c8c@igalia.com>
 <95af58a6-f89f-4430-9be2-d4d4a18dd1e9@amd.com>
Content-Language: en-US
In-Reply-To: <95af58a6-f89f-4430-9be2-d4d4a18dd1e9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 085c9f8b-a49b-4bd4-1800-08df15919bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|4143699003|10067099003|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OahsUbjYF1mFLZFemsKKMGunAE5ds0ob6OB4Bivsairupwku/CTpKPS4R2MA8WgBX1i7h6kV/1tmuUlZJ5JIZMXgaTISx7AAeBK04O+9zVUsSAnrJhkzf06f1F/t78u3ODcgkP7wjkI11o508QOXmBFsj9MVFVIExKCRyzIiV/zlJppIAh2qhf/KbwIeTtAswuokL1NFU2W7jw4EhwvkvPRqWARs2sNRRnMhNbl7J5wpbRVDuXY/Nqt71qE+KpKRKHtywZ1g0n9S0cGJwR7YEs4tKocNatGu9XldHfaOcuyWQwsZoqfj9V2KZWUorGwTTVIaUaekoIXmffSzXXHEfKlwuHMfccXPBtrYJXoXld8SVZ0IogJ8931idvKi2jHN2ADzgHe3JYFn5vJjdEH0YP/pYZ39ZY9L3BDB6MVlmxwB5k1oHGF4taAQYk+rffBpWAERb8q1Bo8U58qseasn2fDU6qAix+S+EBDDPJKH2ghY2MMV93G1Xvb/d17vJQdanH349SIaBp7ytNDdVhIPMmWBXLIL8tFkhkmxrIHW7nQOVOT9SyzJ6g5WCIQasdYE5LAqVResA6yMn8n6WvZrhuV6L5rzCEstm53iIbZRoRzlRXFa1e9SpTXVwAWzjl6QMuwM82F6YNXLrmSlKQDCWiqH7NMXHs9lwA64/OJuCs8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(10067099003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alZJV1lEMm1uL0VTR1I2dVpkZzJWR2UwWkJDaUZRbHhrZHRJS3VSMHc3aWlE?=
 =?utf-8?B?TUVCeG5ZNE9VbUFucStnYmUvNEtsMjB3eStibDJPeTdOOVBsS0tCVzF3b0Nt?=
 =?utf-8?B?amZGNzg0TmhZU1hJa0hlTytVeHJZYnVWN2UrM1JJc0hMYmRSSGZ5cmFEdVVq?=
 =?utf-8?B?UUxiMFFMWGl4d3dnSWF4VHpkUmUyNkRNMmEvV0ptUWRzeGdraHpLUmhINTZV?=
 =?utf-8?B?OVhqSXkwVGs5SmNXY29MZkkrVFZMQm02L29HNDhkOE5IemZPcVh4TG5CWWxh?=
 =?utf-8?B?S1ovT0M2QWEyOVpoSnhFOFVZOVZjME83L2Nxc040K2owazhSL1lwc25EREFD?=
 =?utf-8?B?YXBoU1pLSjFWQklkTFJ0ckU3RjFwZWlGQW40dE1NOGIvV2VhT0ZWdVlHZHcz?=
 =?utf-8?B?cTVWeWJMaWgzeW1vTU5jUlN1Z2J4Tng0aGdhODBVRy9NSXFsWWswWFBRNGVR?=
 =?utf-8?B?QjZmUHo0WU0yUGYyUW9OSFh5VkpTd2Vtb2VKZTh6RFJkSzNzcGFtVFE4ck9t?=
 =?utf-8?B?WW9tNXFQMkV5bGtHZVNOc2RqREorcS9oN3E0bGZBVVVTK2Exd1ZzNUNGUHFi?=
 =?utf-8?B?elo0YkRUaEI4U1RObHg5NlN2cVFrR2tCZjhxUFBHN1lsZkdmUVU5bXVtdVlJ?=
 =?utf-8?B?UERJTHlYdTVxbU1DVjJ1N2o2alM3NkYrVGU5dWNoNHlVUGVrWjFhbUNiNVly?=
 =?utf-8?B?bnVPRCtJN1BkVWFZK0hnTFBPa2pvWm5tNVZLcVVMaTZVUmR6enBPTHdETWcx?=
 =?utf-8?B?azlLd2RXRGNWNnpFN09QWW0rUDM2YkZxOXRqYm1DSHJxZ0xSbnNpbGRBNG9t?=
 =?utf-8?B?anRFdVY5UXN5S3JjTTFydzhxWVpqYTdEaWYvbldXQUJSTGVKVzVrbEgrbEUx?=
 =?utf-8?B?L2k4UFoyS2h6OVZvU0h3cTljbW00eHAwMnR1NXYzY1cwMWticFlIazVPQ2pw?=
 =?utf-8?B?eEVwVk5MS3Q2WmQwM1BmQVF3QSttM2NsZHpMUDdwRDBHOGgwRnFJUXIzT3Bp?=
 =?utf-8?B?S0w3RWpwWTMySzR3NG1GUEV4RG1KVkpHdkVSNGc2V2FkRW5wQmdQTnlGYmZC?=
 =?utf-8?B?T0ZNUEg0cVJYUEhMTzRYWlRvZWw0b0h2Rm9WTVBlcVFLaUtRUVNaQkVhM24z?=
 =?utf-8?B?cnFhektPbTd3cWVrK2d1alJXU0FvV0FNWjlkN3JNRzZnWTRrc29oZG5Lbkow?=
 =?utf-8?B?U1I4UGRDSW5JaGsyM0hKRlNmNDlNanRUaDliNit3YzhwTjAvR29weUNlbWxn?=
 =?utf-8?B?VHpta2daQ1VwYlh6VzJLM1JSWW5PWndldy9CZnVNSHhyVlNwQTBFOXJndldy?=
 =?utf-8?B?R1VOYUZBV01zQW1BWjFEVDR1S0VpU1o0Sk1YYUY0YnhReE9ld2RpZGVpMjEz?=
 =?utf-8?B?Z2xyaElmZWVnNzlLaHI1R0MyVWFmY3ZrMEtrMy91TE45bng4dncxN0hwZWZk?=
 =?utf-8?B?RCtHdlJtb0dHWjZDOTdTRXdsZ0h6UlltWEtCWnRRQTE4Wkh3TzBaUXNTWGxH?=
 =?utf-8?B?QndCTTdTUjdNTXg5UUxOeEVLV0psTFlKaW9ReTVoRkJibUtjcEhzQ0N4ajhG?=
 =?utf-8?B?d0hVN3dMck1oUEZBc3M5dk5FZlBJc2RudXNYYjg3N05tSm5ZclRWT0tWNXc4?=
 =?utf-8?B?R0swRkZkblJLMXR0TmxvSlhvOTBoaUdsbDN4NWRNbnVud3NBdkd2QWt4VFgz?=
 =?utf-8?B?dGljQlNkemIzREN6VXBhT3RpZzd6QStwRnFLUkRVSVRDclhWWW9HdGovUHZl?=
 =?utf-8?B?SVRRV2xXcGxpV2RYYXJUK01RYlhLUk1CLzhMMnowMmY3S1RET2VTUEFodzdB?=
 =?utf-8?B?OVBVTG5ES1ZFclFWcC8xRC9sNjFaa1JuYnl2Nmo4MlFjclN2NFNLSDNOVjZi?=
 =?utf-8?B?aWhMb21uTCtiYk5CNmdzMDBFbllrZnhSd1RhV2JkY3R6NlZCZkcyUERrN2dF?=
 =?utf-8?B?WHM2RDJxQUNlb243bHRxWDNqNTZxT1VnTmZ4ekw4dnVEK0RQM0I0bzBmNkNL?=
 =?utf-8?B?VFVzWUxGdEg4VzNrSXJwY3ZTUGlSeGJpNi82WnVDaWM5WjhXdk8yK2ZQTTQ4?=
 =?utf-8?B?WjlMK1NsaVVEcllLVzJTMkFLdVFnY1RDb1Q5R3NaTURTL1hhOXk1bjVGbVhV?=
 =?utf-8?B?YVBRV3ZqVWFqM25xckRkbC8yci9HMnNLbkgwYTJkU204enlpaCtsR05SSjNw?=
 =?utf-8?B?aitTZktoYXgzRTdaak9DSnhKQmdYdW9EYStpMTNjMkNZbkdNU0xFUXRsTzRx?=
 =?utf-8?B?Syt1V3NmeWZUYk43YitCWHJSaFNEWVBXcDdDUzBNQUg2WUVEL3dmTTNYejcz?=
 =?utf-8?Q?QT2s+yZ4HCIVcLDKQr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085c9f8b-a49b-4bd4-1800-08df15919bf4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:32:04.4564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdGV6AjB04gwlYgADTLySNUq/CYrnesbNcmeAgLQIjjDqcBeoQg9x2sgFkNbcr8D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908
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



On 18-Sep-26 7:55 PM, Lazar, Lijo wrote:
> 
> 
> On 18-Sep-26 7:37 PM, Tvrtko Ursulin wrote:
>>
>> On 18/09/2026 14:34, Lazar, Lijo wrote:
>>> On 18-Sep-26 6:59 PM, Tvrtko Ursulin wrote:
>>>>
>>>> On 18/09/2026 14:23, Lazar, Lijo wrote:
>>>>> On 18-Sep-26 6:43 PM, Tvrtko Ursulin wrote:
>>>>>>
>>>>>> On 18/09/2026 14:08, Lazar, Lijo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 18-Sep-26 5:35 PM, Tvrtko Ursulin wrote:
>>>>>>>> Avoid constant register reloads while emitting IBs by using a 
>>>>>>>> local write
>>>>>>>> pointer and only updating the size at the end of each helper.
>>>>>>>>
>>>>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>>>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>> ---
>>>>>>>> v2:
>>>>>>>>   *  Fix decode buffer overwrite
>>>>>>>
>>>>>>> Overall for this series, below type of calculation  -
>>>>>>>
>>>>>>>      ib->length_dw = ptr - ib->ptr;
>>>>>>>
>>>>>>> is not anticipating a case like below.
>>>>>>>
>>>>>>>          r = amdgpu_vcn_enc_get_create_msg(ring, 1, &ib, NULL);
>>>>>>>          if (r)
>>>>>>>                  goto error;
>>>>>>>
>>>>>>>          r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, &ib, &fence);
>>>>>>>          if (r)
>>>>>>>                  goto error;
>>>>>>
>>>>>> So amdgpu_vcn_enc_ring_test_ib() - are you saying there is a bug 
>>>>>> there? Help me see it please.
>>>>>>
>>>>>> ib->length_dw update is enclosed in both of those helpers, same as 
>>>>>> before the patch.
>>>>>>
>>>>>
>>>>> What I'm saying is -
>>>>>
>>>>> It's the same ib pointer that is passed to back to back calls.
>>>>>
>>>>> Legacy implementation fills like -
>>>>>
>>>>> ib->ptr[ib->length_dw++]
>>>>>
>>>>> So no assumption that it is starting from offset 0 always. After 
>>>>> the function is filled, length gets updated based on what is filled.
>>>>>
>>>>> I don't see the same with an assignment like
>>>>>
>>>>>      ib->length_dw = ptr - ib->ptr;
>>>>
>>>> Hm, but both of those helpers emit separate jobs with their own 
>>>> respective IB.
>>>>
>>>
>>> Wouldn't this kind of logic help to be on the safer side -
>>>
>>> ib->length_dw += ptr - &ib->ptr[start_size];
>>
>> I am not sure at which call sites you would suggest that?
>>
>> I used the pattern of whoever writes to the IB starts their block with:
>>
>>      u32 *ptr = &ib->ptr[ib->length_dw];
>>
>> Then they emit their stuff, and finally close with:
>>
>>      ib->length_dw = ptr - ib->ptr;
>>
>> By that design callers are safe since all are self-contained. I at the 
>> moment do not see how making that more complicated would make it safer.
>>
> 
> I would say all places where the function starts like below without 
> keeping any assumptions.
> 
>      ib->ptr[ib->length_dw++] = <value>;
> 
> I don't see the complication with a code like this
> 
>      ib->length_dw += ptr - &ib->ptr[ib->length_dw];
> 
> It keeps the same behavior as before.
> 

As such the patch logic conflicts itself.

For this to be true -
	ib->length_dw = ptr - ib->ptr;

It should start like.

	u32 *ptr = ib->ptr;

Now it starts like
	u32 *ptr = &ib->ptr[ib->length_dw];

So if you feel the new way is self contained, I would expect a change 
here as well. Otherwise, this could be read as a bug.

Thanks,
Lijo

> Thanks,
> Lijo
> 
>> Regards,
>>
>> Tvrtko
>>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 134 ++++++++++++ 
>>>>>>>> +-----------
>>>>>>>>   1 file changed, 75 insertions(+), 59 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/ 
>>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>> index 17db7264269e..2c367ee6e182 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>> @@ -622,9 +622,12 @@ static int amdgpu_vcn_dec_send_msg(struct 
>>>>>>>> amdgpu_ring *ring,
>>>>>>>>   {
>>>>>>>>       u64 addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>>       struct amdgpu_device *adev = ring->adev;
>>>>>>>> +    struct amdgpu_vcn_reg *internal = &adev->vcn.inst[ring- 
>>>>>>>> >me].internal;
>>>>>>>> +    uint32_t nop = PACKET0(internal->nop, 0);
>>>>>>>>       struct dma_fence *f = NULL;
>>>>>>>>       struct amdgpu_job *job;
>>>>>>>>       struct amdgpu_ib *ib;
>>>>>>>> +    uint32_t *ptr;
>>>>>>>>       int i, r;
>>>>>>>>       r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>>>>>>>> @@ -635,15 +638,16 @@ static int amdgpu_vcn_dec_send_msg(struct 
>>>>>>>> amdgpu_ring *ring,
>>>>>>>>           goto err;
>>>>>>>>       ib = &job->ibs[0];
>>>>>>>> -    ib->ptr[0] = PACKET0(adev->vcn.inst[ring- 
>>>>>>>> >me].internal.data0, 0);
>>>>>>>> -    ib->ptr[1] = addr;
>>>>>>>> -    ib->ptr[2] = PACKET0(adev->vcn.inst[ring- 
>>>>>>>> >me].internal.data1, 0);
>>>>>>>> -    ib->ptr[3] = addr >> 32;
>>>>>>>> -    ib->ptr[4] = PACKET0(adev->vcn.inst[ring->me].internal.cmd, 
>>>>>>>> 0);
>>>>>>>> -    ib->ptr[5] = 0;
>>>>>>>> +    ptr = ib->ptr;
>>>>>>>> +    *ptr++ = PACKET0(internal->data0, 0);
>>>>>>>> +    *ptr++ = addr;
>>>>>>>> +    *ptr++ = PACKET0(internal->data1, 0);
>>>>>>>> +    *ptr++ = addr >> 32;
>>>>>>>> +    *ptr++ = PACKET0(internal->cmd, 0);
>>>>>>>> +    *ptr++ = 0;
>>>>>>>>       for (i = 6; i < 16; i += 2) {
>>>>>>>> -        ib->ptr[i] = PACKET0(adev->vcn.inst[ring- 
>>>>>>>> >me].internal.nop, 0);
>>>>>>>> -        ib->ptr[i+1] = 0;
>>>>>>>> +        *ptr++ = nop;
>>>>>>>> +        *ptr++ = 0;
>>>>>>>>       }
>>>>>>>>       ib->length_dw = 16;
>>>>>>>> @@ -763,17 +767,20 @@ int amdgpu_vcn_dec_ring_test_ib(struct 
>>>>>>>> amdgpu_ring *ring, long timeout)
>>>>>>>>   static uint32_t *amdgpu_vcn_unified_ring_ib_header(struct 
>>>>>>>> amdgpu_ib *ib,
>>>>>>>>                           uint32_t ib_pack_in_dw, bool enc)
>>>>>>>>   {
>>>>>>>> +    u32 *ptr = &ib->ptr[ib->length_dw];
>>>>>>>>       uint32_t *ib_checksum;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000010; /* single queue 
>>>>>>>> checksum */
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x30000002;
>>>>>>>> -    ib_checksum = &ib->ptr[ib->length_dw++];
>>>>>>>> -    ib->ptr[ib->length_dw++] = ib_pack_in_dw;
>>>>>>>> +    *ptr++ = 0x00000010; /* single queue checksum */
>>>>>>>> +    *ptr++ = 0x30000002;
>>>>>>>> +    ib_checksum = ptr++;
>>>>>>>> +    *ptr++ = ib_pack_in_dw;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000010; /* engine info */
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x30000001;
>>>>>>>> -    ib->ptr[ib->length_dw++] = enc ? 0x2 : 0x3;
>>>>>>>> -    ib->ptr[ib->length_dw++] = ib_pack_in_dw * sizeof(uint32_t);
>>>>>>>> +    *ptr++ = 0x00000010; /* engine info */
>>>>>>>> +    *ptr++ = 0x30000001;
>>>>>>>> +    *ptr++ = enc ? 0x2 : 0x3;
>>>>>>>> +    *ptr++ = ib_pack_in_dw * sizeof(uint32_t);
>>>>>>>> +
>>>>>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>>>>>       return ib_checksum;
>>>>>>>>   }
>>>>>>>> @@ -803,7 +810,8 @@ static int amdgpu_vcn_dec_sw_send_msg(struct 
>>>>>>>> amdgpu_ring *ring,
>>>>>>>>       uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>>       uint32_t *ib_checksum;
>>>>>>>>       uint32_t ib_pack_in_dw;
>>>>>>>> -    int i, r;
>>>>>>>> +    u32 *ptr;
>>>>>>>> +    int r;
>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>           ib_size_dw += 8;
>>>>>>>> @@ -825,18 +833,20 @@ static int 
>>>>>>>> amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>>>>>>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 
>>>>>>>> ib_pack_in_dw, false);
>>>>>>>>       }
>>>>>>>> -    ib->ptr[ib->length_dw++] = sizeof(struct 
>>>>>>>> amdgpu_vcn_decode_buffer) + 8;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 
>>>>>>>> cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
>>>>>>>> -    decode_buffer = (struct amdgpu_vcn_decode_buffer *)&(ib- 
>>>>>>>> >ptr[ib- >length_dw]);
>>>>>>>> -    ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>>>>>>>> +    ptr = &ib->ptr[ib->length_dw];
>>>>>>>> +
>>>>>>>> +    *ptr++ = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
>>>>>>>> +    *ptr++ = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
>>>>>>>> +    decode_buffer = (struct amdgpu_vcn_decode_buffer *)ptr;
>>>>>>>> +    ptr += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>>>>>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>>>>>       memset(decode_buffer, 0, sizeof(struct 
>>>>>>>> amdgpu_vcn_decode_buffer));
>>>>>>>>       decode_buffer->valid_buf_flag |= 
>>>>>>>> cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
>>>>>>>>       decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 
>>>>>>>> 32);
>>>>>>>>       decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
>>>>>>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>>>>>>> -        ib->ptr[i] = 0x0;
>>>>>>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 
>>>>>>>> ib_pack_in_dw);
>>>>>>>> @@ -934,7 +944,8 @@ static int 
>>>>>>>> amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t 
>>>>>>>> hand
>>>>>>>>       struct dma_fence *f = NULL;
>>>>>>>>       uint32_t *ib_checksum = NULL;
>>>>>>>>       uint64_t addr;
>>>>>>>> -    int i, r;
>>>>>>>> +    u32 *ptr;
>>>>>>>> +    int r;
>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>           ib_size_dw += 8;
>>>>>>>> @@ -947,31 +958,33 @@ static int 
>>>>>>>> amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t 
>>>>>>>> hand
>>>>>>>>           return r;
>>>>>>>>       ib = &job->ibs[0];
>>>>>>>> -    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>> -
>>>>>>>>       ib->length_dw = 0;
>>>>>>>> +    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 
>>>>>>>> 0x11, true);
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000018;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000001; /* session info */
>>>>>>>> -    ib->ptr[ib->length_dw++] = handle;
>>>>>>>> -    ib->ptr[ib->length_dw++] = upper_32_bits(addr);
>>>>>>>> -    ib->ptr[ib->length_dw++] = addr;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>>> +    ptr = &ib->ptr[ib->length_dw];
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000014;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x0000001c;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>>> +    *ptr++ = 0x00000018;
>>>>>>>> +    *ptr++ = 0x00000001; /* session info */
>>>>>>>> +    *ptr++ = handle;
>>>>>>>> +    *ptr++ = upper_32_bits(addr);
>>>>>>>> +    *ptr++ = addr;
>>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000008;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x08000001; /* op initialize */
>>>>>>>> +    *ptr++ = 0x00000014;
>>>>>>>> +    *ptr++ = 0x00000002; /* task info */
>>>>>>>> +    *ptr++ = 0x0000001c;
>>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>>>>>>> -        ib->ptr[i] = 0x0;
>>>>>>>> +    *ptr++ = 0x00000008;
>>>>>>>> +    *ptr++ = 0x08000001; /* op initialize */
>>>>>>>> +
>>>>>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>>>>> +
>>>>>>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>>>>>>>> @@ -1002,7 +1015,8 @@ static int 
>>>>>>>> amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, 
>>>>>>>> uint32_t han
>>>>>>>>       struct dma_fence *f = NULL;
>>>>>>>>       uint32_t *ib_checksum = NULL;
>>>>>>>>       uint64_t addr;
>>>>>>>> -    int i, r;
>>>>>>>> +    u32 *ptr;
>>>>>>>> +    int r;
>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>           ib_size_dw += 8;
>>>>>>>> @@ -1015,31 +1029,33 @@ static int 
>>>>>>>> amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, 
>>>>>>>> uint32_t han
>>>>>>>>           return r;
>>>>>>>>       ib = &job->ibs[0];
>>>>>>>> -    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>> -
>>>>>>>>       ib->length_dw = 0;
>>>>>>>> +    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 
>>>>>>>> 0x11, true);
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000018;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000001;
>>>>>>>> -    ib->ptr[ib->length_dw++] = handle;
>>>>>>>> -    ib->ptr[ib->length_dw++] = upper_32_bits(addr);
>>>>>>>> -    ib->ptr[ib->length_dw++] = addr;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>>> +    ptr = &ib->ptr[ib->length_dw];
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000014;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000002;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x0000001c;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>>> +    *ptr++ = 0x00000018;
>>>>>>>> +    *ptr++ = 0x00000001;
>>>>>>>> +    *ptr++ = handle;
>>>>>>>> +    *ptr++ = upper_32_bits(addr);
>>>>>>>> +    *ptr++ = addr;
>>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000008;
>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x08000002; /* op close session */
>>>>>>>> +    *ptr++ = 0x00000014;
>>>>>>>> +    *ptr++ = 0x00000002;
>>>>>>>> +    *ptr++ = 0x0000001c;
>>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>>>>>>> -        ib->ptr[i] = 0x0;
>>>>>>>> +    *ptr++ = 0x00000008;
>>>>>>>> +    *ptr++ = 0x08000002; /* op close session */
>>>>>>>> +
>>>>>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>>>>> +
>>>>>>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

