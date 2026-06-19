Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426ECCD98E6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 05:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4FB10E037;
	Fri, 19 Jun 2026 05:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RB3WoovU";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20D1110E037
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 05:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwBM/s0gcKhiPQZJZHnx84cBvdSm9wVo0rlbnyGPLvVtaBddhHJ3C8d84MyroAbyzuvLjISGNjXernDAEEuA11SEQq1Yb2/fQkDuAjNK7Zbi7rdQQz0eGV/7BUMhoqKxiQqVUlH/8YA08VQCH8YkiG/q5soTFBmIue6YEp2JiO4WQ0IkDMgENtzGwvF9d4+8es0jwm7n2DVq+XHqHDhpYjbAKr698DuG9AWh7DJrKPQlTpaeODpQzlhsdTpI8s7z7Uk8M7orMFy0qOGcQKzGYRNO+ejzJzhr1u3HUEku0p2ms5TAZ/WcYubW1tRVIimJJIPNnSdAF3lJoX3lB6wXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8EXQxofZWBONKbsljAMBaCECvtH7xZvbkduamspg/w=;
 b=HSLUzyR9Xe4JWn23GUow9Bql++KND8OlvgMT+eFw7WtzM9Ce7rYfNkmm3Se84ijpWGI9tBLqGRKEY/JOqUEGbGPuf9swuOgDbgIQIYnvaWh2kzfcNSoOLqY1tWp2mAP4ItT3O508oIhWtqT52SSsjLbx2fOz+kwVoSkEvCTBzctB5x6slVQfqQ4R07EII7jVHtnEdW9E+ugyanWCoHxpZ/0TS/9ZETkL6IQuQrkjLZLlM6sNPx3PDbBwPssiLSPrmhsBm7h+UXGX+w2s0qaRNdJqcAYDa12Ds7RMeDjcsEDA859sQUTVcFsZul2L/G5PVjRjKtwcHw+MGkzIn6QKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8EXQxofZWBONKbsljAMBaCECvtH7xZvbkduamspg/w=;
 b=RB3WoovUs88cO35JNj6fXLvwuMPUmDq4qdqDHSJo/n1b+KjmkNZCLFCqXKr05g+HMgUbsK+OJ8HeU4xJcksJbrmPjptddV/D57QdGdLQsrPNknACsr60lziuSLElN1PA8Rk0z040a5LgsapoW9MXKiEbIunMj1NBUDplsdjLH8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 05:51:28 +0000
Received: from SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3]) by SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3%5]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 05:51:28 +0000
Content-Type: multipart/alternative;
 boundary="------------7hLY9HPV4kZvClZ4ZWfyIpJ3"
Message-ID: <73f27315-0b3a-4042-b16e-e49bc005d305@amd.com>
Date: Fri, 19 Jun 2026 11:21:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: amdgpu_userq_restore_all return errors on failed
 bo reservation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com
References: <20260618105158.93562-1-lingshan.zhu@amd.com>
 <d2a07581-dae9-45ff-909f-a87795e0b472@amd.com>
 <151c36e3-ead9-42c4-8bc8-1585a7871f38@amd.com>
 <5b36b3f7-f2e2-400f-8ef3-f3d953bb328c@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <5b36b3f7-f2e2-400f-8ef3-f3d953bb328c@amd.com>
X-ClientProxiedBy: MA5PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::13) To SA3PR12MB7782.namprd12.prod.outlook.com
 (2603:10b6:806:31c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7782:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c59478a-359e-4513-8b89-08decdc6ce29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|8096899003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: US9I/pEgWYKjrhg8p7796axNDv0r1L6ap1xQwmpcZxXK60+wTYcLK6S993LbKIqs1OlL6JPIjg9MzMCO0mHBDyfLuHlRUG+st5N0oATOMOjn0tJrzPTA//FMxmR5S8R8eh9wETQ27DDAL98OvuzbBMgvophUd5SYhFxFwt4sWKXO2B7nCie6/8HH7/A3zE+QJYWZw4OZX4Ah+CyLEPfKnn3zSy1UzD9IKkCjBNnrnf8Pd+dc/Ka4CkIkah/LTcsm7KULoEFWkQ+PtmwcrOUXptP84lphQ2ORNOzym/pLVGNjygP65bQkAJ2UI5gztqg97XJe1g3e3n4f1vjVaQFFi0I/f666LyEIxD+R/40TWtq4uft2xihi3ZKv6naw6ILomPgkAaOXfb9468a7uo26QEquGgQGTkkProWA8ZJgsZezWdy7QAW8dE7rtASA4QdNmSrIoJZIyXrRsq9JQin6OjJSWtXWS+mx5VbarjfDwrx+PlNBSd6MC4eoQV/FwT4TUk4D3KQ/nRjIEYTOsbVda1XyQutOJgEz5sUkjBKCuTz69UlJGnVym2QOoukuohbMX/AvnUDlZffwGI5ZsyOWB5NFFr4Q5LCkrkKN6ySAHyJedR7gh7zkCgKvykIBvzqoapeugJ9oKLlObU4JiWoosy7m6Y0B3XT24N4Myn8hrOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7782.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(8096899003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THJwTjlTVy9mOXVZQXdDNlN4RDM3WXUybFB0Ykh1ek55R1FYYURRSEQrdUs1?=
 =?utf-8?B?Y014S01URDB4WTBTZjhML3o3cFozZWowSTBYTVkreFlMaTUvYWJNWlZQRTc5?=
 =?utf-8?B?Y1RKUEJLdWExT1hCNnkyRnp5Wmhkdjcya2E0eHNyMDV2amlkNGo5a1ZBdCta?=
 =?utf-8?B?VFFMTUl0dDB1ZytKR291bHVSWnBFMjlmUU5JZU1nTlAwaVpjU1F3SE51TXlt?=
 =?utf-8?B?eFlUR01ld2N0OGMvZ042cGRSNFhDNFFEZDJRVXAzc2hEaXFiK05VRVU3MDY2?=
 =?utf-8?B?dVhLc3laUDN6SW1sLzdOeTdnNzAva29FMEdWRld3VUtrWlpMZVFlb1NTMjJv?=
 =?utf-8?B?eU84Rjd3Qm1PeTVWZUorVkNsaXhTS3RXSEc3Y3Y5NW5xUE0xLzkzdDhVLzZp?=
 =?utf-8?B?ODdIY3Z5UC9QUU9qQXREUFlkN21JVmVKdzJmNlJXd1J4dUZqSjRLQXNKUTQ1?=
 =?utf-8?B?cTkrWEtQU1U4RmZJbGhjTlRNa1VSamhiWDF1bkRoeHQ4bkZOdkx5SWZHaHpS?=
 =?utf-8?B?T0EvZFloZTRnVldEaVd2UjB5WXZTeU01aXVmbzBERjhvSXpGV3hZMUZ1Nlpi?=
 =?utf-8?B?WFBQeVZ5RktldHhxRnVBNjF4SFBNWWsyYnZzRWJ6ZzRCSkkvNzJnU0NRcWth?=
 =?utf-8?B?dDBZMnJjakxjRUtsREdoN2RsZmVPYUtoSjNCTWh0N0tKeXlrZ0JMY21XeHNP?=
 =?utf-8?B?M0loUUMxQlo5UFN5Y2VoWVk2eXcyVTlGQldVQUpYMGVlUitRU1hiWFN5eEZs?=
 =?utf-8?B?QmpFMm5iblM0VXh3cUZ2TWRDdzJhc3ZNUkJqMzR0NWZQQWxncW1qTm55MEFC?=
 =?utf-8?B?R2Fid3NMa1dKeGV0YmpYTkVyemdad1pYN3BKdm44L2JBQ1BINjlZcFBMcHo3?=
 =?utf-8?B?TWpnT21MZkVLN2thOGEwWnBJR0RjYVpjeTN2Ny9NektSY1VpU2R0aldvNC85?=
 =?utf-8?B?cXZTc0RNLzhFNk5wY2REdkZneE1CbmMzNzk2U0tNREJvbkQ0SlZFMUVYTENr?=
 =?utf-8?B?ajlWWjdFYk1FbUpubVErM2NYUGNHeHdCbGVWbWtvbkc3MXFwcWlISHBBVHY0?=
 =?utf-8?B?M01sdTZXVVUwNHhBcm5aRGxQbGQvdUlIWVNhNEhOZUtIbHNtMnZGOGhibGpM?=
 =?utf-8?B?RWdFY2tWazNEUTRMWk5lYnFUdVg4Z05yMGJMK21USzJuTjNrczhSbUQwcVhj?=
 =?utf-8?B?RGVsMEE5RndZVy96eGNwWVJwYlR6dk92eDVLN0xDNjZmbWw3U0lFVjNkL0xu?=
 =?utf-8?B?aGtpSmRVeVhmbUZNenZqb1dvYkJ1T1dod01NOVpVVkI0dndqajJ5QlUyeVpE?=
 =?utf-8?B?emlQVkhlZGREeFlJSGxROU9jcWNIQzFSM1MvejFOYkUxUVJpc3JmeURCb0pO?=
 =?utf-8?B?WHZTY014N1pwdDhiZ1RHcnYzM3NzWXRNY3ptRzJBK1cxTWFKeS83LzRwcVFC?=
 =?utf-8?B?VEpRUEZzaG9pZXNyVDJrVmhtb2lmek8yRGFFTlQ1RlFVS09kaWxkMEVoTHFS?=
 =?utf-8?B?KzRzVm1HTGpzQ3RGR1ZYR0d3ZWUwdjN6aEZHK2pnbkNJMzgrNWhFbU9melgv?=
 =?utf-8?B?Z2JmemNVckphU3BOZUVPWGE1cjJqWVRXNDIwMHFqSnpVS3A3eWMrYW5mZmZW?=
 =?utf-8?B?NVBmSE5GR1BuWkR0b1htb2VsMkZCc2pPaWJETWVnU2FFcXN4VFptb1pnWmI5?=
 =?utf-8?B?UkZLTFFKSCtVQW5HdzlNWW5IaFBTV3JHdjR6OHBzcVBBbGYyUHQ5MFV0dmdo?=
 =?utf-8?B?ZWl1ODBEZGkvMjdLNERLVDZtL1R2RFMrZjFHN3QrMWp2dnF4RFRDcFdoakVC?=
 =?utf-8?B?ZnhtYmFoN1BkRWVub3RCRUZ4amZiRC9EdXVseDZxUmxqTlAzUTZveVkybjBn?=
 =?utf-8?B?eXh6WEFsbzFoSjhpZ0ROQzJOOGpYNkpNODZSODZEOTE0SGdDdVp3Mjl1bWw0?=
 =?utf-8?B?eDdudGxVRi83dG9VUllUYU5DcTRhMXBNL0tYaTJTYjBIOVdFWEFnN2t4Wno1?=
 =?utf-8?B?elZHQm9hODNPV2VMZ2JUSmVObnhiMUo4K2t3M0NNVXh4UmY1RGJ5MVAzYitk?=
 =?utf-8?B?K2hwRmJIcEtlOXlPMVVleTIvaHJDSzhJbGVZRUhJNkpSWE5XOFl4dGp0SjVh?=
 =?utf-8?B?NlBrbWpQSjhyQkJ3dndOU1hBdWphM0lQSWRtN3pNUVlLbEovSThtSldxUzVD?=
 =?utf-8?B?b2tMK25IMHJxNkZ5K3VVa3k3YlJNeFJzUndzZno3eGNGK1dYdC9hSHlta2dD?=
 =?utf-8?B?QWFudm5CbDRiN0JtZmtiK2dkUS9GSkV3SWo1SjNuZDlTYzRLeVk4bHFnSEUx?=
 =?utf-8?B?dlV0akJLa20yV2NiYUxHSHMzazVpMXQrRzd2NGlzdmlXaWIxamZXUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c59478a-359e-4513-8b89-08decdc6ce29
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 05:51:28.2557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgorA/3oa/lgeqRyD37ju/gYY71sdpHh0UjTNlKYimoWEO+N0YE5sPbn7R+moyr0Z/30pgqwK0n/EpM14I+Pag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617
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

--------------7hLY9HPV4kZvClZ4ZWfyIpJ3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 18-06-2026 06:59 pm, Christian König wrote:
>
> On 6/18/26 15:18, Khatri, Sunil wrote:
>> On 18-06-2026 06:12 pm, Christian König wrote:
>>> On 6/18/26 12:51, Zhu Lingshan wrote:
>>>> In amdgpu_userq_restore_all(), when failed to reserve
>>>> a bo, it should return a meaningful error code other than
>>>> "false" that means SUCCESS, which is wrong.
>>>>
>>>> The caller should not ignore the return code of
>>>> amdgpu_userq_restore_all as well
>>>>
>>>> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++----
>>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> index 95b680fc88c5..8b14870afbf5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> @@ -894,9 +894,9 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>>>   	unsigned long queue_id;
>>>>   	int ret = 0, r;
>>>>   
>>>> -
>>>> -	if (amdgpu_bo_reserve(vm->root.bo, false))
>>>> -		return false;
>>>> +	r = amdgpu_bo_reserve(vm->root.bo, false);
>>>> +	if (r)
>>>> +		return r;
>>> Good catch, but that amdgpu_bo_reserve() is called here is a bug in the first place.
>> I think i probably missed that. There is no return value check for amdgpu_userq_restore_all and this cant fail. We should wait uninterruptible here i.e change false->true and drop the if condition.
> No, dropping and re-acquiring the lock is a broken approach to begin with.
>
>>> The call to amdgpu_userq_vm_validate() must be moved into amdgpu_userq_vm_validate(), right before we call drm_exec_fini() and the manual call to amdgpu_bo_reserve() here dropped.
>>>
>>> Otherwise we have a small windows where we drop the BO locks before starting the queues which could make the VM invalid again and cause all kind of issues.
>> we need to maintain order of locking First reserve root bo and then take mutex else we had mutex deadlocks.... this is why we have added root bo locking first before taking mutex in next line.
> As long as we do that in amdgpu_userq_vm_validate() that should be unproblematic. The VM root BO and all other BOs are still locked and acquiring the userq_mutex shouldn't be much of a problem.

Are you suggesting to move amdgpu_userq_restore_all inside the 
amdgpu_userq_vm_validate? Current order is we amdgpu_userq_vm_validate 
and then amdgpu_userq_restore_all. So if i get it correct, while we have 
the exec locks just before exec_fini, after amdgpu_evf_mgr_rearm, take 
mutex and call amdgpu_userq_restore_all?

Regards
Sunil Khatri

>
> Regards,
> Christian.
>
>> Regards
>>
>> Sunil Khatri
>>
>>> Regards,
>>> Christian.
>>>
>>>>   
>>>>   	mutex_lock(&uq_mgr->userq_mutex);
>>>>   	/* Resume all the queues for this process */
>>>> @@ -1133,7 +1133,9 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>>>>   		goto put_fence;
>>>>   	}
>>>>   
>>>> -	amdgpu_userq_restore_all(uq_mgr);
>>>> +	ret = amdgpu_userq_restore_all(uq_mgr);
>>>> +	if (ret)
>>>> +		drm_file_err(uq_mgr->file, "Failed to restore user queues, ret=%d\n", ret);
>>>>   
>>>>   put_fence:
>>>>   	dma_fence_put(ev_fence);
--------------7hLY9HPV4kZvClZ4ZWfyIpJ3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 18-06-2026 06:59 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5b36b3f7-f2e2-400f-8ef3-f3d953bb328c@amd.com">
      <pre wrap="" class="moz-quote-pre">

On 6/18/26 15:18, Khatri, Sunil wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 18-06-2026 06:12 pm, Christian König wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 6/18/26 12:51, Zhu Lingshan wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">In amdgpu_userq_restore_all(), when failed to reserve
a bo, it should return a meaningful error code other than
&quot;false&quot; that means SUCCESS, which is wrong.

The caller should not ignore the return code of
amdgpu_userq_restore_all as well

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 95b680fc88c5..8b14870afbf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -894,9 +894,9 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	unsigned long queue_id;
 	int ret = 0, r;
 
-
-	if (amdgpu_bo_reserve(vm-&gt;root.bo, false))
-		return false;
+	r = amdgpu_bo_reserve(vm-&gt;root.bo, false);
+	if (r)
+		return r;
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Good catch, but that amdgpu_bo_reserve() is called here is a bug in the first place.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">I think i probably missed that. There is no return value check for&nbsp;amdgpu_userq_restore_all and this cant fail. We should wait uninterruptible here i.e change false-&gt;true and drop the if condition.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
No, dropping and re-acquiring the lock is a broken approach to begin with.

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">The call to amdgpu_userq_vm_validate() must be moved into amdgpu_userq_vm_validate(), right before we call drm_exec_fini() and the manual call to amdgpu_bo_reserve() here dropped.

Otherwise we have a small windows where we drop the BO locks before starting the queues which could make the VM invalid again and cause all kind of issues.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
we need to maintain order of locking First reserve root bo and then take mutex else we had mutex deadlocks.... this is why we have added root bo locking first before taking mutex in next line.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
As long as we do that in amdgpu_userq_vm_validate() that should be unproblematic. The VM root BO and all other BOs are still locked and acquiring the userq_mutex shouldn't be much of a problem.</pre>
    </blockquote>
    <p>Are you suggesting to move amdgpu_userq_restore_all inside the&nbsp;<span style="white-space: pre-wrap">amdgpu_userq_vm_validate</span>?
      Current order is we&nbsp;<span style="white-space: pre-wrap">amdgpu_userq_vm_validate and then </span>amdgpu_userq_restore_all.
      So if i get it correct, while we have the exec locks just before
      exec_fini, after amdgpu_evf_mgr_rearm, take mutex and call
      amdgpu_userq_restore_all?</p>
    <p>Regards<br>
      Sunil Khatri</p>
    <blockquote type="cite" cite="mid:5b36b3f7-f2e2-400f-8ef3-f3d953bb328c@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Regards

Sunil Khatri

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Regards,
Christian.

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre"> 
 	mutex_lock(&amp;uq_mgr-&gt;userq_mutex);
 	/* Resume all the queues for this process */
@@ -1133,7 +1133,9 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 		goto put_fence;
 	}
 
-	amdgpu_userq_restore_all(uq_mgr);
+	ret = amdgpu_userq_restore_all(uq_mgr);
+	if (ret)
+		drm_file_err(uq_mgr-&gt;file, &quot;Failed to restore user queues, ret=%d\n&quot;, ret);
 
 put_fence:
 	dma_fence_put(ev_fence);
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------7hLY9HPV4kZvClZ4ZWfyIpJ3--
