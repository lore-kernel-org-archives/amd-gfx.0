Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85A3C48297
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 22:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D352210ED31;
	Fri,  2 Feb 2024 22:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ItvuPK44";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1406810ED31
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 22:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNdCHWahrtQLO5btoCBLRjqRnNbXrKl6QtBdWKUePFhoecicrhIhFhpJdDotWGDXN0RZas3Z4NuT+Q+VCTF9fjRF6dZJUH1Kcn7K3oLECpSq1D4/mBzg/tGvJti61t/fOQBJCia3U0sXvgPJdCQXUVJZIWouFcneYOvMZxTkW4xYDs3EvnlRjwUS2R+q13ffgWUdj0mtkfXQJMEINyctm0p0lTBlkUmNjOR7NyLSZcPyIgwdMluEAT2JWOTwvjCmwXeC797BCyxY2YWuTD7b0veqxOa79lMbyEjNbbVZjwrwKGL6F4gU/V4AhZitwQufm1osUuFJCaQSg/GgC5EYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKAsKfR4vqD2bQV1+Jjy5bOFgFXusEJdFa4Gp1ME+dI=;
 b=KMGws4OrbH0T2U06mebg21M3ErtHdp10wdeWvUaUP/eB0wM8/6VKHtVJruxMULHwxYq3vv9UJ2kiqPkGnOSHyAj1d1narCbIYqRSFIs3a1daVCh52kRbm5JZ4Kv0LXLnXQSNVgkQAWo7a0HzvD5boPdzsAtpkIhl0QsM6SB4+89Y6JXt5d4P87oySylmZ505zuMDj3tRKOzSxoBnqP/rDkD1lHHSE+yioXuiIi1gPYJn9nhOqV+iwx8LfHAdaLqkFP5yQOKwy5LTSrdUHkY3xpVwTuaW9z5r6VdzJSIP2AbmxkYwM+iVDhlojji0YyAmf79EbKQ9CqTOS965vAySQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKAsKfR4vqD2bQV1+Jjy5bOFgFXusEJdFa4Gp1ME+dI=;
 b=ItvuPK442Xt+kUeDyi0DSdMxoRj7Mc51+nUK45MZF90hNrRJF6MXtnPm/VBnPYpk394gQC7yL2pvhLq+fAlD95mN/GMBQCp8M0o162dUWpguH4fWFOn97m+G+GLBelZ7DNHyyL4N3emBpnyHKourcuIm+LN0uF6g+la9BQpZjNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5376.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Fri, 2 Feb
 2024 22:26:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7228.036; Fri, 2 Feb 2024
 22:26:33 +0000
Message-ID: <e482a75e-98a2-47b0-9761-c0e501b8c5ab@amd.com>
Date: Fri, 2 Feb 2024 17:26:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: update SIMD distribution algo for GFXIP 9.4.2
 onwards
Content-Language: en-US
To: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240201185445.1461461-1-rajneesh.bhardwaj@amd.com>
 <89049091-fcc2-4d9f-929c-108af7941f49@amd.com>
 <MW3PR12MB4489A4FEFAD589AC27354C9BF9422@MW3PR12MB4489.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <MW3PR12MB4489A4FEFAD589AC27354C9BF9422@MW3PR12MB4489.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f4e325-b76b-4adf-d791-08dc243e02a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItntNyjPJmW9UOX0sosSe4g8+zD4Yh5B2rPp4YBA6zBeDJgw0cBLEznBznAdDpkJLphC+BZ5x4DMNldLOHGv/A0e0KvCoSKNCRxMVJSVSUmW2gddmrGHvPKVNneFAvGDItbvUygSBMdnyUvMionyjaMvWU5CZ//AfFgHpc4RoyVQ5eHrElh1FvH64MAavsV64MXRC37qHurfFMFI8DjnyugYTVJw1p5coZ3e3KtHz5QPIuaJb7sN5WonA03OxU1Q0WIOqgcnxx8UM2dSVXUcDTEHWHW5DShdJ+2ppbjZpqbNUp+HdAYKMyXDyQxZ3buszD7b1jxwYTI15Ly+ydjUYI/f+khDsWJogww4+pth5zOGHK1XBBCEN5S5CeeiZmy20/Zx0pCGPjuXOLcgWaDq44Rezs8TSa+tqBFJ5pnxsOIYUeFcCAsiwzDoZCEYKDBGvdyHVc9QRM40ufqnWRfutveMCjR4PUoRxGpb9iINblMBJbex7WWZ07qFsjQJ5+M7M1eOS8GQ5WeAU3a5poyTJDPODFddB/pHT1k0dHFf3tlCKNBC9arvsh+uJVeR1a6LJhegF9tgs9JaCM/RQiuXYLLz3UVppZ3wShom7n5XUe7sWBzIjcjQ0tEycwZ3HPrhUC6zNmIBPJG/p/xCMRl+ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(83380400001)(86362001)(41300700001)(31696002)(36756003)(5660300002)(36916002)(26005)(2616005)(6512007)(2906002)(66946007)(6506007)(6486002)(53546011)(316002)(110136005)(44832011)(66476007)(8936002)(8676002)(66556008)(38100700002)(478600001)(15650500001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJVdzNYc3N1MGNIcmlIUDBDR1Y0NGc0cENiS0xqTzZqSnFlT1lFRlBXN0c5?=
 =?utf-8?B?YmxVYmFjUmpBbmNGZXhVR1ZvK1dtY0Z1WHRJbi9qNkFOVWJESHF6b3hiT3E3?=
 =?utf-8?B?OHpneUV4dXJBL0FESU9uZGVhNFpZV2pLVUl3NnZpTG95SE5tSmM0bzY2QlhG?=
 =?utf-8?B?ZkxpbjFRYlFYMEwzY2tzTVpuY2Q3TjVyNkVpTXNnREZFam9uZloxWTdmR296?=
 =?utf-8?B?VEZsSzZLdDhxbVNhRTM5bHhVVE1EL1BSdVhjRmlQWElxakVIMTVROFRZLzZH?=
 =?utf-8?B?ODlrSnBUaCtyV2M5cU5qaDFodFhzbmpYRWhFVnNTU2VuazhLckVqYlBKemd1?=
 =?utf-8?B?eGhOS0lHcW91cDg2Y1VmQ1dRZ1JNQ1VRK2VMcGJtckRQcVlrMFM4U3NPdEl4?=
 =?utf-8?B?SGt5TWkrZHozT2FJbnQvbWdMdUFtalpTbXRvNWtPWlRCeVlUaGFwbklGL0Vj?=
 =?utf-8?B?MnFxQTU0NVZaOUdGMGVRcmE2dnNTNFdWK254NGNUTjRYVUNobG9PSUp5THBU?=
 =?utf-8?B?dG5VSGVqdE4xdVFjeXBnL05JeFdEM05rYTcrUWc4T1hmVjM0c0p2VjA3cFZG?=
 =?utf-8?B?U05Ja0dSRUFFTzA1YmlrUjY5VTNkMFZ6dUpNVi85Tk91UU5keG84ckdZWWRr?=
 =?utf-8?B?WVBjUjR5Q3Jmc1dvTXJiYy9zVjkyNTR6ZElhaCsvUVZDOTd1QnpnbU1rNG1N?=
 =?utf-8?B?UEU3cm1vQWlibWIycHVBMVVQd29JejZQTkVDaUgxSEhSZUFFb0k0M1VybVFW?=
 =?utf-8?B?Z1l0V00wcStZSFJ4NlpLeUZNck02c2RFREM4OUVxT3RDR0pEZFh3SFJ2eDBy?=
 =?utf-8?B?cmZZUGZUb3dLcDFQR0htcjA3Vy9jbGhhUThCMFEvZk1jaldpZ3VxcENwdW5t?=
 =?utf-8?B?Z2pyOUxFa29rR1FFVENjb0NVUm1nNXd3Qk1lUzlzY3BEZGdDbndQM2hjaVJS?=
 =?utf-8?B?bElUQjN6NWFYSDZJdmNHcE9VczRLMm5RNG1xVzhVejJodXpsU2JlaFc4WkVx?=
 =?utf-8?B?bUVqVnQwTTBaUGFiY3hvZlZrUS9sM1hPYklzc2VRZHR4aXhIWnRPSHFVdGta?=
 =?utf-8?B?eFd1aUxBa0ROTHEvT0xCZzM4Zkw0YnU3am0wdVJBc1JLcDFNTmFORksyTTQ0?=
 =?utf-8?B?RkRlVVAxK25oTC81WkszTThGakJ4RHBUM1hxT1BCNmRDcGVjZllzVE05R2VO?=
 =?utf-8?B?N3VzZ1dreGpVL2ZNd1lOSG1DTXllK0FtaHRxRXFSVUNSdWtMVVluNGhjYkM3?=
 =?utf-8?B?UHZSN3M4SjVMTysvV1YzVWpvSmRmbEFpc0FCOXRneGVydEpxdUpYTWdlaTdT?=
 =?utf-8?B?QUUwT2dhWURsWEtJOHVyaVVkdlVzS0JpcG9vMEdYU1RCUTd5THdYc1lxcjN0?=
 =?utf-8?B?b0FvZU1ETTZ5ZnhqSlpMV2VWbmh5cklweXcxbG5TNnQwWnA4VktlNlhidnNN?=
 =?utf-8?B?dkFZU08yQjh5NnlZdVE3RnNxVEtsWEpNdkdkT04wTGs0Q0VIQ0pEbWFsODlT?=
 =?utf-8?B?S0JueUQxdHFZalFOaU54MmZ2NS9ldXJabkQ3YVptK25tVGVFdDFzbXp2emd0?=
 =?utf-8?B?Ujhma0tXeGtPWnFtUERaZGFtNHdGNTRLeWFsM2s3cVBabFZZa3kyNEg1UzFI?=
 =?utf-8?B?S1kwSlZIRzBMbndINldxamJTUnhuVzlDWWM2V3Bxb04vYnV3d0pHcDJweDY5?=
 =?utf-8?B?Qkw2R1c5a2lvNm1IV2g1TEdIOVBZMnlJQ2diQUhDcXNFT2pxMlk5SFp6MFdi?=
 =?utf-8?B?cXVZT3RVM2VCajI1RXpCMVZaelpzajJOVDJDNmNOVXhERk5uSERpQ2J1TkxO?=
 =?utf-8?B?bWNCRlZyendvRTFYUWpSTHpOcFBEbzROb1lQMWNSSTN1TGk4UkxpMGlwd1NN?=
 =?utf-8?B?TVVycEVhb3hVa05Pb09RSUNKbFdONlpzaDZsZFdHVTdFN0g4SU5pc2d1bEpr?=
 =?utf-8?B?Mi85L3dCUDR6b2hKUFdmZFR6ZjZKcWE3emhycFBLMVA3eXZkTkw4UWM3Qk5p?=
 =?utf-8?B?Rml5UUFzN1JzdjRWMGNVQ1UrQlJIck10Q01tOHZTbnlaSmtFQ2xFU3gxQTJR?=
 =?utf-8?B?TWZLTkJQR3hDVi9FTkRCbS9WcFpoRTBwMnJDVXkxbFlxckx0N29CQXhwUEhl?=
 =?utf-8?Q?pkMRGayU6i33o3yOwcV//SSQZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f4e325-b76b-4adf-d791-08dc243e02a9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 22:26:33.2366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AR+uCjPAan+a++1PgA8CN3TlNIukRPi/YZfS9ht0nDWtqq6X2N+DFmjITndiM99ll72agWiMFP08Elky4kQuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5376
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

On 2024-02-02 17:24, Greathouse, Joseph wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Friday, February 2, 2024 10:21 AM
>> To: Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Greathouse, Joseph <Joseph.Greathouse@amd.com>
>> Subject: Re: [PATCH] drm/amdkfd: update SIMD distribution algo for GFXIP 9.4.2 onwards
>>
>>
>> On 2024-02-01 13:54, Rajneesh Bhardwaj wrote:
>>> In certain cooperative group dispatch scenarios the default SPI
>>> resource allocation may cause reduced per-CU workgroup occupancy. Set
>>> COMPUTE_RESOURCE_LIMITS.FORCE_SIMD_DIST=1 to mitigate soft hang
>>> scenarions.
>>>
>>> Suggested-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
>>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> index 42d881809dc7..4b28e7dcb62f 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> @@ -303,6 +303,10 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>>>              update_cu_mask(mm, mqd, minfo, 0);
>>>      set_priority(m, q);
>>>
>>> +   if (KFD_GC_VERSION(mm->dev) >= IP_VERSION(9, 4, 2))
>> Are we sure this is only needed on GFX 9.4.2 and later GPUs? Does it affect older GFX 9.x GPUs as well? What about GFX 10 and 11? It
>> seems the register bit exists for all those GPUs?
> On gfx9 devices, it is only necessary for GFX 9.4.2 and beyond. This was a side effect of the move from 10 wave-slots per SIMD to 8 wave-slots per SIMD.
>
> Checking with the hardware group (and running some basic tests against the problem we saw on gfx9 parts), this should not be necessary for gfx10 parts, either those with 20 wave-slots per SIMD or 16.

Thanks for checking. The patch ls

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>
> Thanks,
> -Joe
>
>> Regards,
>>     Felix
>>
>>
>>> +           m->compute_resource_limits = q->is_gws ?
>>> +                   COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK : 0;
>>> +
>>>      q->is_active = QUEUE_IS_ACTIVE(*q);
>>>    }
>>>
