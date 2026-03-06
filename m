Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABFDF5140A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 06:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8888210E37F;
	Fri,  6 Mar 2026 06:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kdFrX3ya";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFDD10E37F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 06:41:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYc04YmBoxPM5vSTrHsrcOm+sFwBKvPK9T5IciDWUk6py5dDchcsRwryFkzMZeCLM0nJOi20eo2+qQv+SpMFi6H90bix1m1UUFwLLRhhhioEIJqpwjFxcS+F1JbuXMebgVgzdaaI5RbATaf9zCqGXigBshaE2I9xmDzRG6xt+fMnpTxWpDdcDRhMSCjjSEtv4PtA51fpr+25Ri3axJLH4Zk764PUEhH7f5J8Z3qCUUUsNhARDEjj8tj6JrdmKRdkPPlZFJGTsJL1QhQa+U0mFZmXNWdm3fxXfBvD7R70j6bS090tKL6hns4mOke1i96E8cdQCCribbANQPKJtEcASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hYjxVqs7uZ6dMJ3d6YTwZVsyeUnISbmFPirgTISSro=;
 b=kXEMaLyPYFGoSwLn6DzznIKWEpbIqy/prBw+Xog8PSOm5CO8roTLn3qBk2lNCq8abdUfMcyQOhOYQVWDyafFBcSIqX+dbbbi5gTeSQE5pR/hAr9OuaTAdYWtAcK+nrSNYcrfQC2wwQ+L12z3CVB3tC9aR6TS1ehK7md7/+CrkRANYArP8aA+RUZkPA/cAz9OxVIFHZ3XbY1ON1HQqIj/KC4iBbiY7m/ynpwNEduHRK6HLBK+TCS1oax/yfcTfQJS/7BWURS8gObecFBnKxcnEjHtJiQiZCHwXCjxJ+sT3nTZXSeO6U2qxeAD7b81LpWDnu5zlYqpC94pJIyPKIyO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hYjxVqs7uZ6dMJ3d6YTwZVsyeUnISbmFPirgTISSro=;
 b=kdFrX3yaUDgaXamCHRkkLBeffkRU2yLfjB+Yxw61MfJAAsJjyFhUFQKg7JbYZoDx0bjicg/3YKj+NQF1LcWXxVFJBgJasPL0uCbXs8MaG3TM9yiwdT3FMwQvpLo05CNG7UnU4uFprDu4qqhyoHxrhw2FWX0thFQx7AixYe8ohj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 06:41:39 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 06:41:38 +0000
Message-ID: <6ce53965-3e67-4164-979e-259e6b57a379@amd.com>
Date: Fri, 6 Mar 2026 12:11:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd: Fix more cases of NULL pointer deref at fini
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260305220540.1354776-1-mario.limonciello@amd.com>
 <7305e3af-1960-4612-9dc5-fbf718b7fb7d@amd.com>
 <1decb90d-1b7a-450e-b846-d3dbabfd81f2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <1decb90d-1b7a-450e-b846-d3dbabfd81f2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a483a7-3b3d-49c2-ee84-08de7b4b6b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: lejcZr30L9Us21LaMnB1FrOj6KWIUR7BRr/nDwHojsOXkQKAlqzBK16RnvZ+Gnk5SZRnilICRyBSWS9pSdc1gwIGIUNWVAiRpepvVK16UQbT30HIMPyC4X8+D5XS1ljLs+cczPUcjFuZQ7SKypQKzujRRP6ytTjcsobB7ed/AYrcgYiuCyKboj5T2HopXcoB5HlbZvAPvge8yfF64HtSy2eeOnz7w7M6LQ2ChEj73jq/p09Dri701s/X8SUKK9yFIZuCAeN9Agc5781KyfFKC1WceHNOCm8kbAsuslf3JKKCin2S39XFhn2nx7eCKPlXN18xFs4VoiZ9G4ftcjnyrYVdaMty99lonMeG4r/M4Xy9IyKALFoVQWbJT79PEkkD2Ii1D8yYPa1rvvs69ETrf5aKPyl/YtYPzBH1I5XuVv4D5fUyqkre6Uqq13L/f/7m66XIzxUTRqWxq6MOhH7DcfoETcuYs3S1ybjzTcMmDXiaOy/VF9dJzV0GixQM0Ay44eAEMRzmMNKa/DihZyoDYNcLgOYo++Hn0Q1/++M3p21+zhHAHbF9JfYX2GVUGFD21/UGHP4HyQjAda5JuzNXi7jgimKo1rIiyGB4x4S+GAamfqUZujKW7deiB/IRVEvohhBm0hMpd7HqLMjZUXJ7JotfhkkX/YM7IJVBIg3JPHZEvRQ352H6JWvhV1C0yB4Kc/1cEJzMAnZ2n5+mhDoUbVaqbM4/jbQ1LAIyr5IQQqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SndmOEN1WDNtOTRvUzVKU0ZLSXZlMWRTcXdEeEtESEJpdTRadklKUXkvcldj?=
 =?utf-8?B?T0c5bFIrVE5COTNSd29BaTltYldXNitUTzIwbkdwbTFjMUpxQzhFNUtRKzlL?=
 =?utf-8?B?bFR1eXhiVXBoeFppQmVFcERhQ1FCY0h3SVNKbm1NZTlSTXk3U3pMdzJ1V1c5?=
 =?utf-8?B?Mm8zM09ZbGF1M3lwUzIzd2xZQUpoUzBTcWNyTlltZWwwaGtqM0NIZGpwM0hs?=
 =?utf-8?B?ZGhqd0hNWEFMNUhVV0ZiVHc2a3ZjV2IrOVlDTldPS1dVNGJXY3J4UFJYWEx2?=
 =?utf-8?B?bXFCNlQxc0p0bllPWEw3Q2hTM21pQnJMVHJxelg4ZHJPbVBjd0tJK3NYUnJ4?=
 =?utf-8?B?RWNzZ3BYZXdpWnpLc09BQnF5Tms2Qy9scDV2Slg5TFdpeDhtR29ZaldtcEVQ?=
 =?utf-8?B?SUlsK0RXY3FlcDEyQk1LdlBhOE1DM1U2WDNFM2NwaVgweDdIbGZXRDR0OVRS?=
 =?utf-8?B?L0RtZkl5Q0FnaDB0MnN0VDV6ZEd5VnUxME1iTEZsOFZwOWJ5UDQ5OXg2NGtE?=
 =?utf-8?B?dFVJSW1BUTNubko4ekJ2azd1SHVjYUk0VS9kYXZHUDB2WlBKZDR4NWJGVmVH?=
 =?utf-8?B?dlAzbzdxZzhmWVNOeWZ6LzgwclZqUmNwM2FSZlpCSitVUm1zeFdhUHB3aTE4?=
 =?utf-8?B?RURsR290SDdlM2Rja2dzVHMxcTRSdENJbUFMWW1Pc2lKVDB6VjVxMTB2OU1F?=
 =?utf-8?B?N2kxbDBkcjUzYVlRdG14QzFhd2QvbFpUYVBMenpsR29Nb3dmRFNydHlPSFhI?=
 =?utf-8?B?MldCM1ZjVjNCVVJ5RURoekZvLzdqcm1JbzQzNEdaQ04zdHhEM0VpR3ZOczNw?=
 =?utf-8?B?UFJodHd1bkMzZlBwbkNLdHJaa2liOUlPeDZwRUppMmFNS25FUzV0RWdPd1hI?=
 =?utf-8?B?UzdvWXJMZGMxUmQvMk1sMmN2UDVNbURObi9PMUQzVEhRUmQ4TDhHK1dESDZX?=
 =?utf-8?B?VnhJV2t3aWtPd0VWYmhhOGJLN2pWc1VSczhZeXR6dnpMa1Jsa0RrZEZnbnAv?=
 =?utf-8?B?cGJFcDZqNzJxVHhIZEVnRnlpaHphanRSNm1XKzNJWExGZUNaaHAzVjhtVnhO?=
 =?utf-8?B?NDBCUmhFSWJSdUloYlh2Vm8wZC8xZE1LYXA4YkorQzBNaUhxMUZmaEdPSWhB?=
 =?utf-8?B?TVJOeG5VVCtNZnhJOFlpODh0aW1uQ2VoTFJpWWtvNy9DcFMyM0VZc2h5MmNF?=
 =?utf-8?B?NnBGTGNmanliRnJXTi8veU4yMFFHN1FBbHpiVGZyU0JubndZWnZWMTJIMThG?=
 =?utf-8?B?anBTa0RlR2hMeDFwV0NhU1lHR2p2TWU0OHJRZld4R3B1Ty96VmNNT0JVZ1hF?=
 =?utf-8?B?NSsxazgwL1BWVnY1V3YwNm5ZUE45aFlqTHlYSlErNW5odUhXS1JPNWpSUUJl?=
 =?utf-8?B?TUZndTZMQ0s0S0QyM2dPWGpFcUhlSGhrem9VZlYwaElKRUN6NjNMYzBRY3FB?=
 =?utf-8?B?RGJHU0dKUkJGeExkTzkvK1RXQzZ0dWhxZDU1OG0yb2llbUt3ZWpDS3hmRFFW?=
 =?utf-8?B?M3BmczVRUGhmQVd6TXhHanJHSUI3OVNKUWlVNG5yY1E0ajRWUWhPYlFEbS8v?=
 =?utf-8?B?dnhFYUY3ZEI1N0hWd20yMFFJV3NMVDdBQWVFVkE3OUl3U3BaUS9mcWhGcnAz?=
 =?utf-8?B?TGVVMDRQTVJtRERrSUNCN2UrNC93TjBzYWh5SWZIMXYyendTdEprQXRmS1Jw?=
 =?utf-8?B?L1FSK0Zndi9xMWxSMm5DbmQzNncxTk92Q3B0cSswZWNQWUNpdm9mblJmdVo0?=
 =?utf-8?B?c0lTUm1lM3Y3ZTJqYTlYVVBaYW8xMDJqcTZVd0xQWUxXSWE5bVlZTCttL2Uy?=
 =?utf-8?B?MVhVdDJLaGJLZEJ0SEQ2Y0s0RzlCeG1JZElBb3NuY2NGUVlVUEhyMEFzWis2?=
 =?utf-8?B?WVRkdmlUT0NXWVI4a2MraW05cGRCcWhnNEd6RFVFb2RtYmRWYXFxTHNHVldN?=
 =?utf-8?B?QVhOQlVZeTIyOUJIbS96d2lUWHdmWi8rR2lyVkFWRTVCSVZpNkxyd1c3UGl5?=
 =?utf-8?B?Qksvb1JnRGxPdVovSzFodnkxOGVPWmtCWWxWZmp0VDJ2Z21WYWpVWjRmOFlM?=
 =?utf-8?B?MXdDdDZ1dUFEeHZNTUZPOGxtZHVmZHlBenZiZHZCUEZpZVhLdGVBbEtPQmZm?=
 =?utf-8?B?ZlJ6cmprSGNDODFJQmc5cHdIdGNPVmRBZFNtSTFjTHZ2azd0ZUNoL0N4dFd6?=
 =?utf-8?B?WFFiUzR4NWs2dVJhamt0T0NMK1YzYXBaR0NpVnI1MkNYZU9KRmRKS2FnSVh1?=
 =?utf-8?B?QXdsbUJ5RlVzdkpncnpVZkJsbjBWK1BBcE5wNzNsVng1N0lBVjVKendldFpx?=
 =?utf-8?B?N0V6WkUreUtPMDNCZ2F6NERYWjNyR3AyUkNnaHh1ZFF5L0J6TTIzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a483a7-3b3d-49c2-ee84-08de7b4b6b3e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 06:41:38.8936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRCNeOdfM9Y6T3DbaLmPv7ymAmjEZkV0sf2qorZ7vJcnF7CVmZA4e+tPYJZMgZ0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474
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



On 06-Mar-26 11:40 AM, Mario Limonciello wrote:
> 
> 
> On 3/5/2026 11:07 PM, Lazar, Lijo wrote:
>>
>>
>> On 06-Mar-26 3:35 AM, Mario Limonciello wrote:
>>> I found more case that a NULL version causes problems.
>>> Add NULL checks as applicable.
>>>
>>> Fixes: 39fc2bc4da00 ("drm/amdgpu: Protect GPU register accesses in 
>>> powergated state in some paths")
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/ 
>>> gpu/ drm/amd/amdgpu/amdgpu_device.c
>>> index bc6f714e8763a..74cbe58484fe2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3463,6 +3463,9 @@ static void amdgpu_ip_block_hw_fini(struct 
>>> amdgpu_ip_block *ip_block)
>>>       struct amdgpu_device *adev = ip_block->adev;
>>>       int r;
>>> +    if (!ip_block->version)
>>> +        return;
>>> +
>>
>> ip block versions are set during discovery phase itself. This is a 
>> very early init failure 
> 
> Yes; this case is NPI system that not all blocks are in discovery yet. 
> System panics at bootup with NULL ptr deref in multiple places instead 
> of a clean recovery and keep fbdev.  This patch series sorts it out.
> 

Blocks not in discovery shouldn't be added to ip list or should be added 
differently.

>> and ideally the fix should be not to call any fini for such an early 
>> failure.
> 
> As an alternative to this series?
> 

Yes, if it's a failure as early as in discovery stage, probably we 
should skip amdgpu_device_fini_hw altogether.

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>>       if (!ip_block->version->funcs->hw_fini) {
>>>           dev_err(adev->dev, "hw_fini of IP block <%s> not defined\n",
>>>               ip_block->version->funcs->name);
>>> @@ -3496,6 +3499,8 @@ static void amdgpu_device_smu_fini_early(struct 
>>> amdgpu_device *adev)
>>>       for (i = 0; i < adev->num_ip_blocks; i++) {
>>>           if (!adev->ip_blocks[i].status.hw)
>>>               continue;
>>> +        if (!adev->ip_blocks[i].version)
>>> +            continue;
>>>           if (adev->ip_blocks[i].version->type == 
>>> AMD_IP_BLOCK_TYPE_SMC) {
>>>               amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
>>>               break;
>>
> 

