Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4C0F43685
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 09:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B2E10E993;
	Fri, 17 Apr 2026 09:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oakEMH8I";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42ED710E99B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 09:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFo4BWKQ4NvcxV4bCIJIb8iID0FnAH2/hIAhC+3vf2f9IAYZ9i2HIqpWPqp7fIJBFBinrSFqgNx38kiXJQcKuzsGEOwfOCnmolIS9MgXpd88imBH629/o9AJ9fE1E+FMnB1ezAWBVvStDQFyg0X0EB3BO0YmktU079XxhA9cC0OmWzaNWuH3DoZiJxsB2fmk9sKCDPfMXebyH30RcAAHD/M387ZZKxId9dn7fehfrpUwA9gYOTKvoHEfP8Z96NV1kDOyIq4llDmHG2FgrmlVzvPOFRznUBQvijv5O4TD38iTUDkoSPGoNDpoSaHb/QrPPZYkCAAVRcws0Eq85Ev06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9OJ7jQOkEBOk0GWu9YQvaRl7Fmh1dTE529+Zh+X9Ts=;
 b=KTXKlTA5U3GGnfMbp+3gdCKyS/AQMxLXDdQE+qHLq0OVJl8o0AOFPPxCoTitb7sukDASukHbcKSJ0433gmnjo70fbJfSzDq8GgLRMEToJmX8B6CNdHGOfOFO5WBeVAYG9Ar4RRX28fM4S1a37bThVZrq9s8vo9eXU0eblij3i8HrHWJkKjoezpYv/bpfMTwQZUP59MH2ADGC8K36pgBXTOjT6Y84Y7iWxxBfFYpi9YzzHGBEh0fnuGLZv5TMLOGrmTUnxA7srW+0vgOPudeIEF/kWmfs/cHXx/4vjsZkCZYfhakgxYZxOCvzpQTFwM9tygoKUBO4H7g9C5PaCMP8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9OJ7jQOkEBOk0GWu9YQvaRl7Fmh1dTE529+Zh+X9Ts=;
 b=oakEMH8I20BsL6Xjmdlotxx7CMjLcDSpnMdGtQipf4RrQvutqbI+upMPm0afsAPCEQiMDPDzH9dG3Y1PFtcp20umZsNwR2HM0GVeU1QCa1jCrmRHYM6duNxKEVR+sGh1f5ncjd9ooiCCPJT+l2f5yYxku4ok5w3av+7A9FKZQ30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 09:04:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 09:04:00 +0000
Message-ID: <5666ee13-9798-4dee-9614-d2f0ec5e8a31@amd.com>
Date: Fri, 17 Apr 2026 11:03:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] Documentation/gpu: Add TCC, update TCP in amdgpu
 glossary
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260416202643.25350-1-timur.kristof@gmail.com>
 <20260416202643.25350-7-timur.kristof@gmail.com>
 <b7656601-bbcc-4dc0-bbe7-7ebe8e5ab777@amd.com>
 <4874819.vXUDI8C0e8@timur-hyperion>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4874819.vXUDI8C0e8@timur-hyperion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e2a037-31b7-4312-3619-08de9c6043f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Vf4RKIF7UbO1g/ZMtteiUgylFd8JkJ7lcqOc8OUeT89kqffvbziF4EXnhjNd4N01VfWosn2LovUIh2Eqe0ONO75+JiqwAnyse/CLCkelnN+ry/gP2IhT4BPjUrfk1Sx7Ffq9QKf8kz1jSLo5oS4FGSLzEO3aOflRxF0jZkSctnMB1D36atFkGcPPpAdfYIq15nqP7OtCospcq8NC0Bfj37m7o1VAVH5S3NOL2VQ/gWwn/D/2V+sUZR/70ZH2eSEF7ruileRHrA3pTcyORii06IFEk172v/BqOFOpV5IDMxHSqwZFb+IHzQBwWjX8VSW1t6cJ1Ke2D7pb9oOJar6MfFTmw4+rmPHbUYqKHmtqHfuZllXUFYcYqA7kx4YY/3EgBjnjwwslKHpsIQuJSrt/bp4hoZ+uo/JqYHppe9X48VFW8YBDDPLO7giq7nY/3jjOx+LAAnjY5J/NU/4RU2SJQUKZUS/MIKK88Nmzer0K9KKT6mkUnWfxjWceHbJKHpyYFODM0bWJGK6guOwcchpScJMJtt3z3P6FAt0ARn14rU2ES1uRhCOFImhW1AWJiKUlAcTO2re/C4f/fV226GhGyIo7Qac66PBE1zPEChc5w4Gd6xp9rDCqPCxr+NBU4sDPTosYkbI2a2Lvac4lugJl7/DB6dGZpuoeO4XHUMTz+OQWdRTPBqxPPm2rc6vWsTGJOiMcXHiqWPy6EGFsQ2XI3uXQ8+dYEwW5pcW5LYZ1Ges=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVBHRnRNeWpHNWQ4Z0xtNDlrVTFLZG1MVWFUOTd3bldIUkdRQXZoM3Z4VHRY?=
 =?utf-8?B?MXdKOXBwa2IxVVVqWUx5OVF4WUhlbFNlNS9NTXZDc1ZsR0pVQUo5Vjd4TmV4?=
 =?utf-8?B?ZWUzTFRXNkJHTVJUMDM5YWVRVXBrZkVKbmc1NTJ4dEhOTFhXZDhIWVZSM2Z5?=
 =?utf-8?B?VXF1K3QrOVNFVXFtZGErV3dhbTdjRjlObnpBcVFFam9iWTBpVTY0VThGN0xx?=
 =?utf-8?B?OFdTQ29iU3daK3hjSURoUmlmcUwzdjRSVE10Mm1vWjFKejVHcDVIT1RkYVlL?=
 =?utf-8?B?OFRQUDhVMzZNTjlUOEFqanl3M3FsRUMrcEdxayt2MjBIb2EyWFNHTzIwWk5m?=
 =?utf-8?B?ekhpbjdwRVNRLzNZeEN6ejZmTGtBZzBoWGpZb2VFSU5KOUlMa2tYQmZLSGRJ?=
 =?utf-8?B?eUpUKzlHYVgzcXUrSzVNTGduQy8xMDFQcHVQb2Q2UHkwR3RRajQ3ZlJ2azBD?=
 =?utf-8?B?Rm9LOHI5WHRKV1doYXk1a2NOREFkYlhsUThpOGhhWWJMZHg0ZlBYV3JtT2ZT?=
 =?utf-8?B?ZEFmTmpGZEQ2aHZjSXJ0cmFoRmhBa2cvZmNJMXFpMVkyZ0FlM3BqNEJ5ZmRO?=
 =?utf-8?B?bHhLMXg1SWUrSDd6dEZnZ2ErSnk4Ky9WZjZGSGhPR1Q5YU1BRXZZK016MjZr?=
 =?utf-8?B?Y1piS3R0OWhpVHI2VWJqNDhtSTh2VDJnN0FoRk1QWTV2V0JWZ0tzMTZjY3F6?=
 =?utf-8?B?RElKc2FMazdrSFUxMHRCa3dlc1NwZ0ZJZnloNHRaOGt0ZUN1RVNPWnZ2QVFJ?=
 =?utf-8?B?UnF5ZUloVEwxdUlhdnFDMGtteEdPbWhzSEFSdm5NelltYzdES3k5UUhybllZ?=
 =?utf-8?B?aHI4R21OdkF2RkpEb0pLbnhMRWJQeEhkOEdKMFhFQ3hHa0RDS3hoNDZKTGE0?=
 =?utf-8?B?QklneVNROTVYM0tXYVZBN2JzdStuNk0vN1lRZ3Mxb0FuZGZpODIxK01adzlU?=
 =?utf-8?B?Z0J3VE85c1ZhVWh0L3NtaCttWS8zTTZ1dzdJV3dMWEJnL1doOTFjMnIzZktB?=
 =?utf-8?B?eGF5NlVjaEtPRjVuc3NkNlpzTzcrYk1Zb0NiQmpqRVA1cnFGK1hUZEltN3Ba?=
 =?utf-8?B?NWN5eU9tajFSM0J5T2hKRENMcE5JRWpxT09VM3lDMVdaU0FWaDFzOFZXRU1V?=
 =?utf-8?B?NEl4bit5c3hyTXg4dUZROHhVZnhhbjFFMUhoZHdWcWt4ZGpZcWdQaHZuYmNv?=
 =?utf-8?B?SUUvYnNQaGhKVEQybUtlTEc1aVRvc3BVS3F2QW16M2F2V1M4eVdsQkMxOXlr?=
 =?utf-8?B?Yy96Vk1ieHlXT3FVSjd3eEQ1ZjlDUjZGcnhab3JXWmJNNWZoNWpMbFZrdUxR?=
 =?utf-8?B?UjFWUkoveXkxSFlKbjRoUnNJa25WVHhPbWFIa0s1c1pxRmtiTm1zV1FmNm1N?=
 =?utf-8?B?VWtJRWtEY1lJekRXY3VNRVI0dE1vbDdvYTBPMmU0cU5DQXlIblhhRGE2bWZR?=
 =?utf-8?B?a2tzVWlzZU9Va0Z0czN3STFFa3Nya3hvL0Z2NW83TWZ6OEJ3empiMFUrRVF6?=
 =?utf-8?B?QkVZanFmZHNXN0dEbDB0U0JiYnNnWnpXeThyRUNROVRwVStNR3dpRjJsd1lq?=
 =?utf-8?B?L085UzhZTGdiSHFKTkl0M2k4YXBuQ2xSaVdWOVVocTBBVm8xN1V4RFNaSHFz?=
 =?utf-8?B?Y2F5V00vWGFKRnZvS0RIb3Z0ZFl6UXJMaUgwOERUNXR3WHlGNkQzOHlPRkRu?=
 =?utf-8?B?R3Z4RVpHOUJIYzNNOEZCUzZubkdhcXVCT2MyK0h1QVA5UW1Sak5yL013Tmlx?=
 =?utf-8?B?aXNKTHFpT2V2dG1sRXVBQVdmUWVhSkw0eFByYlphYThTaktsaC8vbmZFS1Nx?=
 =?utf-8?B?b3YvZHRpN2d5bnM2azBvUXgxZyt4NGNwenRzdDNIdnZFU2hDUnhMUVU3Mzl1?=
 =?utf-8?B?N203dGF5ZXhucis2RTQrMlJPajd2R3hMcjlBMTZkOXM2d3J0d2hkYUFLWkdr?=
 =?utf-8?B?QWRHZi96dHZEbUpITWtZMFVsQXRoTU5vcFZqYUVJWUZPZ2tjTXRIeTFQZ0di?=
 =?utf-8?B?N0NLZlRwTlRmZFhNSFlHMXpyRmJLVUFjUVZwY2xROHNDbVFmdEdoMURkaGVG?=
 =?utf-8?B?K1VIQUozTWg4Qm5MRkt2K1lNVlRLcUR1VkdZME5mNElvVXpiUnlRZldoR2M4?=
 =?utf-8?B?M1FuRHU1RWpLWjUrMG9jU1Y1K215Qlc5S1U1cW9xOUhZeFMrVzJkVTA1blN4?=
 =?utf-8?B?ZEo3UEhROENyQnY4MHlYRGlLNWIwTjROUHdzZVZlQjlpYnJjbnNGcFJCYUdC?=
 =?utf-8?B?R1NnSEo5Wm5ha2dlMzV2MzNGdjlHYWxNemJ3WWlHUm00MCtPS1g5U2pKY1lG?=
 =?utf-8?Q?wWiUOphZQ8LbKEAAO8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e2a037-31b7-4312-3619-08de9c6043f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 09:04:00.6584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ut3RKzigHh4CPq4+nCZ4n7vnuUQvIlQstU6C/fjY7Fpqz0mkLPX1Y6K/jR8YmWx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754
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

On 4/17/26 10:36, Timur Kristóf wrote:
> On Friday, April 17, 2026 9:24:55 AM Central European Summer Time Christian 
> König wrote:
>> On 4/16/26 22:26, Timur Kristóf wrote:
>>> These are the L2 and L1 cache on some AMD GPU architectures.
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
>>> b/Documentation/gpu/amdgpu/amdgpu-glossary.rst index
>>> 033167025fcca..d553dd599c966 100644
>>> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
>>> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
>>> @@ -233,8 +233,15 @@ we have a dedicated glossary for Display Core at
>>>
>>>      TC
>>>      
>>>        Texture Cache
>>>
>>> +    TCC
>>> +      Texture Cache per Channel - L2 cache attached to the memory
>>> channels. +      May be used when shader cores are accessing memory.
>>> +      Despite "Texture" in the name, this is used by any kind of memory
>>> access. +      TCCs may be mapped to TCPs, depending on the architecture.
>>> +
>>
>> Good to have, but maybe put that below TCP. E.g. L1 first and then L2.
> 
> I prefer to keep the alphabetical order for consistency with the rest of the 
> glossary.

Good argument as well, feel free to add my rb to the patch as it is.

Regards,
Christian

> 
> 
> 

