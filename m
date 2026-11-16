Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D9606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WMQSMv3Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA00C10E3FB;
	Mon, 16 Nov 2026 19:43:46 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A2610E3FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsFsb0q0oSovfUZ85n/+NUaRy0eDzzrxQ0rDSCMBfSu/GI4WaCVQhO3Q9G6Q/W5ED/2/NbFRUAiNCA2kESW6yVTUmCjFhvVy7jtA20CJnNAjIt/G0VK5aEpXjmc+POB+Xzn9Tabg0WQOUSXkXtk+Fg1y11YdPXdAWBg5OyQCXBTsLX1uuitX2v6dMVOWfWw6OaNuZe+oBT+bhF0+ZWsCPrLI/3IyPhCkBLB/IoLS2uzusxnNbFi0NoNjk3Exhgwz4piVPYj63gWrLBRUP0tI//yvbmpJ4YacQshUJmnXaWuFEWd7+JRkS5u8e9ly4BcvG2WpnbBERf059zUYoEHGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ex9N6RIW2YnQKcOktO20SJCjLMLyCQ1ktMmzk/XzCKY=;
 b=VEdIET8B0KkLfvLw+BcrgmVzjigtKHnnwEqFlOjyrH77qjvmazt5Kpy7k9VMLN8HwnolRWxHwgb4anb2VA9nq7Q2pkxbkfpvBpuNZXdPknKr21xpWvmupU8bI6xLA4V1mmoWZERxTIAKMXzJ7DJCFB8Mnz5ij3EZ93gA7nowNrLgVW3z79KOHkke+blNwUnY8wZBZXx5KpeJgLqD/U5wtjno0BQixUTin02uZOYeAs1koyjjOMp1LeW06xvHJnHXOUfY8FXbq5uqV3Xb2UsLzw1LVmApsxOc8rtXTFmcvcH0Ejfp3HDOU4E6AOn1o1WynJnKLPnrsDY2UIXfWGSptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex9N6RIW2YnQKcOktO20SJCjLMLyCQ1ktMmzk/XzCKY=;
 b=WMQSMv3Y1gKvYjrZsBXXHN6XhEegfRz+bnQ/7L9PrDpnYZ+nQb9B3zLZgIGcnmb3Q/Je/B7odj56WlLJkg2PT9bJGN3yw3SHrU4xb1l8+p0bzk9s5WRzyWkQjOC/zAtFPdDeZFg3/kwT2tW24Kr+z/D9BEygT5Jx90r02LXwa2Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:43:35 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 19:43:35 +0000
Message-ID: <36ed0af8-d640-4b2a-9c57-7b39051945cb@amd.com>
Date: Mon, 16 Nov 2026 13:43:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: drm/amdgpu: Patch review for gfx hang on submitted jobs for S3
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Thothiralingam, Logatharshan" <Logatharshan.Thothiralingam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Perez, Randy" <Randy.Perez@amd.com>, "Chiu, Michael"
 <Michael.Chiu@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <SA1SPRMB0073292C113C6B98D9282092F87F2@SA1SPRMB0073.namprd12.prod.outlook.com>
 <835ebb0f-126c-4d30-b5d9-14f1950da83b@amd.com>
 <385b0781-f3f1-4819-a027-d6e3f5532783@amd.com>
 <e32c1312-8823-4c01-8b31-c4385614141a@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e32c1312-8823-4c01-8b31-c4385614141a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:208:52d::29) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e08b2a3-fd1e-4838-59f0-08df4419e74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|261022075727099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|56012099006|11063799006|10067099003|261102123227099003|4143699003;
X-Microsoft-Antispam-Message-Info: U7KC9KqtigWYYmnm8N7mE5eXKAN7h9B0FuRjW6tmLIN2EAmboKGyz0tTVhhVi7dfS5i93lNQJ4aJuNSJw2GNe3ZRO9+zAbuwthLmqIkHWDyOSAu9fChf671QK7iHteq5ePv5r3+7VfQNG27tpHQ8wscsCdTfrLn37S1nN2229FuTfu5UER4s3OgRAZ1klCVCRYCkjk1Yx+kBPf40ugsgmIqZwlYtAdr5L4agO2DBUuy2RbIA4rSyNQR7uRk2xPRTbwrLkq/df1nA7az1dX904PbWUcN5J5vvm0wNoeOmWRla/grCIHc8PDEl/d59XbY4+zkjpsPd8FptuMGehDpEHrVOAlhk8vmB/0h6/rlSYKyVCk2Ra/KRUsgMsUBQwc7hHxrCUzM6iLQ+d22XP5wpfSEnGgyGaoZcoByZ1Jxvrpx9iQ6ILRXcW9hJrn9pYyrmVWQV+IQ/ToL9vKLt1zPeF2CbJH8IWTQvl5Jv7xMM5md/49B5GZavVAZAqKl3b1kA3+Ss+MdPtL4ohswdSDgOICuSm3DOtWbippUXHUNYUWCCIQ5ut5iBw3cll9IKAz8Fqyq4q7TU/mceevjp6iRBCCHSENfc31fZSFd726TNILikKdX5MAcPKMc50vWBMT29OIwdllz2k+RDncyxS+p0cFowCWCSfRtSYQS7PVZynIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(261102123227099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVpWWGptZlVJa2JuUHFYdUpzMDZqdHl4MDZmcERZb1FoNGJKTHNONFAyK3hU?=
 =?utf-8?B?ODEwWkxJMXpRamxLWVIwNHFVbDN3dzRxU1NNUHNKL3VRTkExVVJ3WjlmTmFs?=
 =?utf-8?B?Vk1TWjMyMTMvdzg2RmJ3Q1VEeFAwS0tFZlVzWWxQT2tOWE9EeWZHR003Qm01?=
 =?utf-8?B?OWoxMlpCWkhTN2VVK2MrNVhpVEJMbk5BSlhYNm83RXhFYnZNam1jd1NrZjJT?=
 =?utf-8?B?TFRoTjkwQWhvUmhMQ3g2bkV6TlZrYlg5UUg1eVYySXE5RDFKem9yWmNVTEU3?=
 =?utf-8?B?UTZRdlJJOVcyMzNXK2RmT3Y4am9yOXJPMlF1MVJ3SE9LaEZIaUxrbG1pZlFh?=
 =?utf-8?B?emJVQ1lFb0EvTkdSd3JlaDhmMzM5dFhheHQweXZYVHdodk5sNXZSRThwVHNz?=
 =?utf-8?B?QWM0Qmw5TzQvTDd4NTNFakdOdFkyaUgxcGxYZ0ZBb1BTMDYyWGxRSVk2Q09n?=
 =?utf-8?B?Nk53VW44bkNqSytQdXA4MURyd2txelZWSlk2Q3ZZc1JTellTN1dqVGhrWGNs?=
 =?utf-8?B?cW9lNHgxbnVPV2ErMGQwR2JKRVl5WUVEUXNkUnVHOElZS0Q3eFRIemxUdm80?=
 =?utf-8?B?dS81ZDd4NnFsZHZZSExJNkpKOWpVMG9jMzU1R3FKT1JHQUdERW1lZVRSdmJM?=
 =?utf-8?B?SDZROGdrTzBKdUpCMlBjTy9VNnA5U21IcE1IS0Q1V3RSTjZRdXU5ZVRubnVH?=
 =?utf-8?B?UTg4S244SjBraFRXeVE0b25HcVZUcUNsdENpOTB6Y0I0L2sxb1F6SHltMmhL?=
 =?utf-8?B?MjlLZzNITWpUR3luRkcvMmlwcGpSdENRamF2VDBkaXlOS210eGI0S0R2bE0v?=
 =?utf-8?B?L1pFNDdvU1RtVVN5bzhNL3NEWEtsVXlKU3Z6dXdKSCtmV09KQ1A5ejJ3NE84?=
 =?utf-8?B?K3lqU1ZuMUZaOHpzemZiT2ROZjRuTzR3cTBJcFlpVmFwSUdKV3R6UGwwZ0lB?=
 =?utf-8?B?OHl6V05aQS9nS2tuNmlKR05aK2U4SjlrNEF2V0w1ZWZWUEh3OFRBNlo0ZmhY?=
 =?utf-8?B?amc3d0JzUDNnSlpvWCtFY0JDeGs5Y1BIeXhveWI4dUYwSWxINXZ1Tlc3OFJN?=
 =?utf-8?B?WUFWUDN1dlU5dlN1eVJUL0JFYnVKNjVITFhHU3QveE5aWmQ1Yno5ZFhPNGFR?=
 =?utf-8?B?RnVPVTdqZTk5bGQ5T3NyRW1RSnhJWDkyeit5RGdqaHRuVjlkZ1pNVUNjUExZ?=
 =?utf-8?B?N0VCK1BsajAzMXpOeSt2MEZVYWhuSW5lTmw0QW1GM012WmJHUHR3a0ZxK21i?=
 =?utf-8?B?Q3ZXdkxRWHphcDdydUxKbEt0L3M4elR1ZVM4RHFYbjU4ZktXazRHbUF0ZHpX?=
 =?utf-8?B?ZndjSUNyYm9UMi9Kd1BGbDhQWDJJZmNXMHIveE1TOVo1aFowZjNkazhGamY2?=
 =?utf-8?B?dEM1elM1bmpMOU85cGF1S0RmOUxHZjRhMHdJR2I0bmhhMmd2aEJkdDIrZHNQ?=
 =?utf-8?B?V3BlSTRVMUVGeGEzLzZ1NG9HYktGbk1NeDhUbG9BSXZvT3pWS3pUVUdWcUxj?=
 =?utf-8?B?UGtKUHQ2ZlFDQTlNdExrQ3prRnd5QSsrQTB2SjRKUEIzd2YxY1FSVjlDeVB5?=
 =?utf-8?B?dUFBNU9XOFpDZ0ZmelBqY1VNM2FBQVVLczFDdHVIalpTeTVmWnFwaGdzQ3U5?=
 =?utf-8?B?cG91bk13SE5oU0NYd2xIbndzVlhZZ1I4RUI0OHhPbzU2a2pkSE14ejZqeGp1?=
 =?utf-8?B?eExYNnVJUXRkOEV6TnZ3OEh2Y21EYVd3YjJmd2JuQUhlUzQ5Q2puc1AyWkVP?=
 =?utf-8?B?NDFHbGlCWjFVNmpXMEVuWmJmczVjQnFsenRBYys1YUZGWEZvMHBlYUlsa0tI?=
 =?utf-8?B?V1kvV1hqRXhmeGZxNko0T3dEakVNZ3pjRkVuUjhONjZJRERHam1adUE0eEhy?=
 =?utf-8?B?MVczaXZEU1VqUEVKNjZLblQrSng1TE1JYUdMa1hHUm9QTXRWUk5vbyt4NnJm?=
 =?utf-8?B?RGVSNzZaSE9lazdOQk15Yzl3MkVTY0V6bUtzM1M1bWxDRVNsRm9ET1Nzbkxp?=
 =?utf-8?B?eGpwZHliYnZYenJ6UGs0WGhoSk1MSENVelFGSVZNNHh1elZ0U2xFTHNkbkFi?=
 =?utf-8?B?ZlRoZFdOdFBUdG0wdFM5a0NQOVY0Sm5xQmhxWjI3RTF3M2ZzTXFxWHcrS2lI?=
 =?utf-8?B?dytGczJIWlRVSEJTSmp5TEdpTmN3RjlFNzhXRFViejA5NGN0Z2RNMVlld1k5?=
 =?utf-8?B?WUJnTlJBTUdMYjVoNU8zaGIzWXBsZFdGNjBPaEVqeE9OeHFuejJpLzgwWVda?=
 =?utf-8?B?RmU4Kzd1bElSSmM1WmVOV2tmWGVVU1NRM3lPbFJONjZaNUwwU1RqTWZRM1Rk?=
 =?utf-8?B?OVI4VFZacnk2eVlCL0ovR3ZVNldzN1JtcGRFdW11Z2JSSjlqRVFjdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e08b2a3-fd1e-4838-59f0-08df4419e74b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:43:35.7151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UssGN2pmnwJRaaWKHLHPyfYg+sTUXMlQsL4fkirrCNu/9fB0M0YGkXoPLoJZKQpVB+pkbZs+s0CI9bDL+HNFEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/26 13:42, Christian König wrote:
> On 11/16/26 16:24, Mario Limonciello wrote:
>> On 11/16/26 09:04, Christian König wrote:
>>> Hi Tharshan,
>>>
>>> the idea looks good in general, but could be simplified a bit by waiting for the VM to be idle.
>>>
>>> Question is why don't we already have that? Or do we already have that somewhere else? I'm pretty sure that waiting for all submissions before S3 should already been implemented somewhere.
>>>
>>> Adding Mario to answer that question, he has been working on suspend/resume quite a lot recently.
>>
>> I thought we had something like this, but looking through the code base it seems not (or I missed it).
>>
>> I think it's the wrong kind of patch though.  I believe we should use some of the existing flush functions and do it at the same time that we evict resources.  Something like this (attached).
> 
> Please drop the timeout, keep in mind that we should always wait forever for dma_fences.
> 
> Apart from that looks reasonable to me,
> Christian.

OK, I'll post it on it's own thread and drop the timeout.

> 
>>
>> Can you see if this also helps?
>>
>>>
>>> Adding Vitaly to double check if we have already a test case for that.
>>>
>>> Thanks,
>>> Christian.
>>>
>>> On 11/13/26 17:44, Thothiralingam, Logatharshan wrote:
>>>> AMD General
>>>>
>>>>
>>>> Hi,
>>>>
>>>>   
>>>> Please help me review the attached patch.
>>>>
>>>>   
>>>> A gfx hang that occurs 2 out of 400 times when performing S3 cycles. The issue is seen with the kernel version 6.18.8 and on AMD hardware; Picasso gfx9 APU.
>>>>
>>>>   
>>>> When going to S3 suspend, the driver checks whether GPU has completed its tasks, but it doesn’t wait for jobs that are submitted to the scheduler. As a result, queued up jobs slip into the ring and are lost when WPTR is set to 0. On wake up, we hit a timeout followed by a hang.
>>>>
>>>>    
>>>> The fix is to wait for all scheduled task to finish before going to S3. I tested the patch and the issue is not seen again.
>>>>
>>>>   
>>>>   
>>>> Thanks,
>>>>
>>>> Tharshan
>>>>
>>>
> 

