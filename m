Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F50BC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 15:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1698210EEC1;
	Thu, 30 Mar 2023 15:03:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37B210EEC1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 15:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdOAAkdI7Compiuo6o1Ezru+el8lylCxdXXyyKbi8ZChHvvRZ+tZdIoquWam2b/gNuGJs5faY5L6euPDBbRAi1arjJV+Ze9kHCjiBeyRq2Vf1CN3SNy8IBxsj/7glS95nQC7IlHngAz7Juq59j/re/7FaFS3ncuefcUfitZ4BG0ikWRmGDG03sapzJAkNGxuoZu3xej5sb2MxEY1vUmt0lpb6tHG3U0ddykragnprOV5f2IKgbdwz2p5zft/2KLSOHQINBio0/IussjHNNqkDvfutpx9mky7QIleDYHEDGatZQyhqs65ybHdClEcl93LEJa6r5NeDUswGsxJDTM66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+ZLQ8TP+WOliGcbhIpBmrqyP/+Xros0fJCVCgu8awM=;
 b=Slee1aep/J6CHldNQZJ+E1LwWJgOfKf9eXUfcwzW6BupD+c099JiDh7dkvyG1MOgSjgIRYm2qkCPpggge99hsSzmt43VUHukl3yUTxwiu28UZ9Codr3E4Txz1B12H/8XVNPZ+Mvr4rAdQlug0m651KT0hhiqYvaYuIwH+ZkwwOAy0DosgRQ5431b+x8n3EfHyvfTKYuTlTIEMx/s23r8MbNWXsL+hk9YexfInkgZ+LKqO78M40nps4eHoZ9OdKLPFfqtvkTb+fQjoFzilL1Q05mHoCvAxqYXkuZ9EZxzVemza4VFw9WOCa2EM0VWQTa6u3ZPknVRQx/92KH3CTfS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+ZLQ8TP+WOliGcbhIpBmrqyP/+Xros0fJCVCgu8awM=;
 b=lvn9FFtudLu45AFag4JEO9C4rxRcRzEA5suT2tRmTWgDW4Az9+MJcY8s0jUK5yCc239dEEr7geY8kw2OPDAGdOKly8ezPQ7sqSSvsMojWK67hUC2/g3UnHjSRDCesCLfuiC+grv7UACWcuyUEL5oG15OuNhhVFkuKr/2piHuPlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH2PR12MB4875.namprd12.prod.outlook.com (2603:10b6:610:35::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 15:03:02 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 15:03:02 +0000
Message-ID: <2ec957df-d04f-77e7-a817-f6e2891bb037@amd.com>
Date: Thu, 30 Mar 2023 17:02:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 10/16] drm/amdgpu: validate doorbell read/write
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-11-shashank.sharma@amd.com>
 <de6368af-b16b-0794-6eda-465d5046c142@amd.com>
 <fabf0ef4-f668-43d1-78d6-e5baac3ab098@amd.com>
 <5a83afd6-9e7f-5c1d-0b9a-77f49b213bd3@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <5a83afd6-9e7f-5c1d-0b9a-77f49b213bd3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH2PR12MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: 86cb6e22-6503-4d82-c9ed-08db312fdb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGYI4DzJxM91i1M7jbKZpeJH7O5cliXt8wRFML/iRMgjsQv8EfFbOYs0NXB6ELEs5LMK/le4xp6DNqRFkOJ1Gu1Px65v4r5/4544batJcmgbwpycEbD/X23gfOweAwI+I1ZcFpCFwKVAC1XJntzyYsgpyO7hF+7lr9+PY+SsWhJJdf5AmxG92A1jpC3nuxw8jX072EPJW3ECbxte/hLrrC2Y9keRtbpMqNZaUwQzFkcQLfiY5iCqExV7Kccn6tYTkaouKF8+WOYb3jHM8dJmrFktO4FrdAe7bPaBCt4Mf6q+A6dktbmqqzg9GEGO4zGXSuoisxQXqhQFomQaijDMxMK6eazduHmJDd2SnLSJsHON9LhzFZqU+KyBAHWOEPjtfKg2wwKsE53nvlUPNWliw0VJID+94wyvFho9+4c2NTQbAMDNbxWLSPuhclsSIqm96Y17ZJC2OZ2rb02QGRSMizftBr7bctD9xv2dVlgbOKgTInQvsYIQ9W+v8eMBChXv+e7PQ1nQfHdiis5jhrrXYAKPs7y08pFpK+QduVtRFgPlX+dKCSOXsfYKI/JZwLP/bEpTLHFDjZLMfd5mqzDEa+A1VtzQLkfgyXYB77YR/wbJxeDiAYck3or8QnjXH/XE9InPTtvWsOe6dW2xUN5hwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(26005)(6506007)(6512007)(53546011)(8936002)(5660300002)(8676002)(6486002)(36756003)(6666004)(38100700002)(31696002)(86362001)(4326008)(41300700001)(66476007)(66946007)(66556008)(478600001)(316002)(54906003)(44832011)(31686004)(15650500001)(2616005)(2906002)(83380400001)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czYxRWlBemVpMzloc2VhcE9lQmg1NmlTSW5tUjlBYUFlbkR3WW4xcmhWa3Rx?=
 =?utf-8?B?Tk5aZFFWTUxrY0IxVWEzZ0tNeHpyVTk5bjZHT1Z6OTlTcWlIb2YzUTVVNDVC?=
 =?utf-8?B?alNRS3BnSGMyTERQL2tLMlprMjlQVVlyT1htamY2L29CY1hxL1BZdWUvL2Zz?=
 =?utf-8?B?NldHeHBNTEc5VHNTeDIvTVA5QjU5Zll6dFF1TUZ6R1ptVmdST1lnUjBKQko4?=
 =?utf-8?B?UUJndWY5M3hBM0g5VGlBNGx4N0JrVDJxZlk3WURaa1lLNFFFUjJmOEROZXVF?=
 =?utf-8?B?UlhPWXA3ODRhWUdHZFZiVzkrTUdFM21IM3RMampydDEzZTYrOUhvYThPQ3Mv?=
 =?utf-8?B?WU5jcVQzYXRmd2M1ZkJYUEU3UGc1R0pnZ1lta2ZRbHI0MHhxQXhlNEh1MkFL?=
 =?utf-8?B?ZmhpUHEvR2o4V1c4WlR5MTJTb1hIbkJVK2ZwTUs2cXBYZHVybTlXU2JMeUpT?=
 =?utf-8?B?MEpueTNXYS9rYlZPNGVUV0syZHBIQlJrMkZYS3ZnaDU2bE5mSXAvY1pCbWZS?=
 =?utf-8?B?SDBjVGIrSDFLTkhJSFZhRXhEMUxTbmtCWmFFeUp4QU1YYzJkNWdMRldQMnlH?=
 =?utf-8?B?NTF0ZmRzdmRKZXcwcVVYdHB6VEp5THlkN29UM2xHN2trVExjczIva010NElX?=
 =?utf-8?B?WDNVSDViR3cweEs5UkVrNnRHQ21OS2h6S2RYclNDbHd6SWJzS2xqYWpXWWdt?=
 =?utf-8?B?UXNJcUxVTlhYT2UzMVVhaWxFYmQ1Nzc1MmwyK2JleGUvamdzclR3UDRiUTho?=
 =?utf-8?B?b0pWNXhDcXluTmo5QkltLzFyNldZZ2NqQlpHeXZ2K0pCU2xrSEVoT3lSV0dr?=
 =?utf-8?B?akNRdVl1TXovK1EvSTVNU0l5K1NhRUFGU1Yvemc1aXZMSjhXOHg2emd0YjVx?=
 =?utf-8?B?TGhlRDVvU0FaR3htcFFqc05BN3VFMStvY1hYNHpacndwR3RqSEs4NUt4WGh6?=
 =?utf-8?B?dWF1S2R4ZExhNCswRU1WQ2g5anlXbEZ3c3lCOWhnZXZKWkFHbVdOZnVqWGZS?=
 =?utf-8?B?RTRBWGVJMHFVSXBCTmpRNmhqaTR1NzkzOGxjQnF5NXg3RkFiQzY5Uldaa1Zp?=
 =?utf-8?B?UGI1OXVSb2tDUXlSSkx1a1QrR254NithTmhMWis2Z3NKZzQybnZ3WVQzSzU1?=
 =?utf-8?B?eXFBak1yV2EzODd3S3RPdjVYSjJTbFFnaG81TFlJNzNuRGJ4UFM0T3RyQ1Zh?=
 =?utf-8?B?TlVKTnNLRS9lT0UxRm9zNGF1TFkrMW9qM00zVkVYaW9KVStIcjM1VzhzQXU0?=
 =?utf-8?B?a1RTMTVQMHFDalRiZXoybmNDdjI2akgycm9RRGtiUlBGZ0poK05qdjZ4R3J4?=
 =?utf-8?B?ekZ0T21CdjJoS3d4eHZheDQ2Ry80QXorNSthM0twN2pUZndJamllN3k3N0t2?=
 =?utf-8?B?U3RpS2JkWHlIZk45b1FvYXhtUmJHUXhwb1dYaGo0UTNaVWNnUW12ZlJ5cHYz?=
 =?utf-8?B?eWdZZlBnNGZBNEcxdlF2cFRjczlmWTFPSS8rcTl4b1g2dkxIOWhFWTRMcVUx?=
 =?utf-8?B?MVRmVVlKd3NEeGljdTJ0bWFqMEVYd2JLN1VTNnZ2ckZvRkR2V2YyUlc3c3pP?=
 =?utf-8?B?OURwM25FaVoxdnFRcWtsY3dFZyt1M2dnYlY1Q0xMNGtyZTFvQ3k5QmU5cXJm?=
 =?utf-8?B?bzlBa3grT3kwbzY3U3RjRlZ6T0xXSnFLT1Z4czZJOW13ZzN1NWxnTjhKRzRz?=
 =?utf-8?B?YXNRUkpZRDV3TlJDMTN5VStaR0ZUeEVvQ0ZNYkZqclhXMGFOZUxONTBCcXUz?=
 =?utf-8?B?cFI2dE54OFFheno5NFhVKzQ0TERGOWxBdGlEOGZnM0FQM3JYekQybENhSDNZ?=
 =?utf-8?B?UFJ0c01mZWp6Qk5BNTVHSUJnaHAxeHAwSDZ5ZEJnVk10NDNTYVJPYWVobHBF?=
 =?utf-8?B?YmZMQkExZ01VbG9tL0tDQ1lMM0dEYW9ibWVKK2J2dVpMbTRYK0hDbEJSdU9W?=
 =?utf-8?B?c25zeEdkNHRlU3E5OHBJODU4bFlJRFlJbWZnakl2cnRXbjJJK2MvamhvTENS?=
 =?utf-8?B?SVl2V2Q2QWhSS2JwQWRpelFqczJKaXZYdTRaaHhXdEhjNE9pQksrSFNKVUls?=
 =?utf-8?B?UDVyQmErYUx6UUlpZU0xU0hxSlJMYTFKbXJCdFVJZVJqQ2VhbEEyOTJCV0VS?=
 =?utf-8?Q?3orgLF4QKw7KE2371q46iooit?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cb6e22-6503-4d82-c9ed-08db312fdb58
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:03:02.0649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8Dk+pkGxpvpC5fDWlwdZm7uzUYcHX5j+BYqhPzTsY5LCk4MZi/6eNZ0kueVoV5uBt3MyTo5wqj/UA+g7QkvIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 =?UTF-8?B?77+8QXJ2aW5kIFlhZGF2?= <arvind.yadav@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 16:49, Luben Tuikov wrote:
> On 2023-03-30 10:37, Shashank Sharma wrote:
>> On 30/03/2023 16:34, Luben Tuikov wrote:
>>> On 2023-03-29 11:47, Shashank Sharma wrote:
>>>> This patch:
>>>> - updates start/end values for each of the doorbell object
>>>>     created.
>>>> - adds a function which validates that the kernel doorbell read/write
>>>>     is within this range.
>>>> - uses this function during doorbell writes from kernel.
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
>>>> ---
>>>>    .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 29 ++++++++++++++++---
>>>>    1 file changed, 25 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> index b46fe8b1378d..81713b2c28e1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> @@ -22,6 +22,25 @@
>>>>     */
>>>>    
>>>>    #include "amdgpu.h"
>>>> +#include "kfd_priv.h"
>>>> +
>>>> +static inline
>>>> +bool amdgpu_doorbell_valid(struct amdgpu_device *adev, u32 index)
>>>> +{
>>>> +	if (index >= adev->doorbell.kernel_doorbells.start &&
>>>> +	    index < adev->doorbell.kernel_doorbells.end)
>>>> +		return true;
>>>> +
>>>> +	if (index >= adev->mes.kernel_doorbells.start &&
>>>> +	    index < adev->mes.kernel_doorbells.end)
>>>> +		return true;
>>>> +
>>>> +	if (index >= adev->kfd.dev->kernel_doorbells.start &&
>>>> +	    index < adev->kfd.dev->kernel_doorbells.end)
>>>> +		return true;
>>>> +
>>>> +	return false;
>>>> +}
>>> Here you're excluding "end".
>>>
>>> In patch 7 we see this:
>>>> +	/* Last index in this object */
>>>> +	uint32_t end;
>>> Which implies that "end" is included, but in this patch, the code excludes it.
>>> Perhaps you intended to use "index <= ...end" here?
>> No, this is intended, same as array object calculation.
>>
>> end = start + size;
>>
>> max = start + size - 1
> This I understand, but "end" is NEVER "start + size" in all
> code written since 1969. "end" is outside the bounds and thus
> never used like that.
> "start" and "end" usage comes from RTL and is always inclusive,
> and "end" always fits in the same sized register as that of "start".
> But if you use "size" and add, it may overflow. So, enough history.
>
> "end" is inclusive. If this is not the case in your implementation,
> then please use "size".
>
>> so (< end) not (<= end)
>>
>> end says last index in this doorbell range;
> This I don't understand.
>
> This isn't how "start" and "end" are being used.
> Their usage comes from RTL, and is always inclusive.
>
> Either use "start" and "size" or make "end" be inclusive.
>
> I'd prefer using "start" and "size" as this is traditionally
> what is done in memory management in software (not RTL).
>
> However using "end" in software makes it tricky to calculate
> size, and one always does "end-start+1", and this could lead
> to bugs and errors.
>
> Please use "start" and "size", then.

I think I am getting your point here, it should be end inclusive in this 
case, noted.

- Shashank


>
> Regards,
> Luben
>
>
>> - Shashank
>>
>>> Since this isn't RTL, wouldn't it be better to describe the doorbell instance,
>>> with a "start" and "size"? This is traditionally used in memory management,
>>> and it makes comparisons and checks easy.
>>>
>>> Regards,
>>> Luben
>>>
>>>
>>>>    
>>>>    /**
>>>>     * amdgpu_mm_rdoorbell - read a doorbell dword
>>>> @@ -37,7 +56,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>>>>    	if (amdgpu_device_skip_hw_access(adev))
>>>>    		return 0;
>>>>    
>>>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>>>> +	if (amdgpu_doorbell_valid(adev, index)) {
>>>>    		return readl(adev->doorbell.ptr + index);
>>>>    	} else {
>>>>    		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>>>> @@ -60,7 +79,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>>>>    	if (amdgpu_device_skip_hw_access(adev))
>>>>    		return;
>>>>    
>>>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>>>> +	if (amdgpu_doorbell_valid(adev, index)) {
>>>>    		writel(v, adev->doorbell.ptr + index);
>>>>    	} else {
>>>>    		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>>>> @@ -81,7 +100,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>>>>    	if (amdgpu_device_skip_hw_access(adev))
>>>>    		return 0;
>>>>    
>>>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>>>> +	if (amdgpu_doorbell_valid(adev, index)) {
>>>>    		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>>>>    	} else {
>>>>    		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>>>> @@ -104,7 +123,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>>>    	if (amdgpu_device_skip_hw_access(adev))
>>>>    		return;
>>>>    
>>>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>>>> +	if (amdgpu_doorbell_valid(adev, index)) {
>>>>    		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>>>>    	} else {
>>>>    		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>>>> @@ -157,6 +176,8 @@ int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>    		return r;
>>>>    	}
>>>>    
>>>> +	db_obj->start = amdgpu_doorbell_index_on_bar(adev, db_obj->bo, 0);
>>>> +	db_obj->end = db_obj->start + db_obj->size / sizeof(u32);
>>>>    	return 0;
>>>>    }
>>>>    
