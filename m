Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA023F54AC0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 14:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C69210E16E;
	Tue, 24 Mar 2026 14:10:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VFY00nBa";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A42410E16E
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 14:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jB2TFJ8QKzURatQZZ+faMw8dAK12khWokbbmYwwOjkna+SMo4iCXesLYjV70rzoFkyBXmBrh2WCKg+3NzHe1hzGdZTpVIBqAkeAvhIAu64oM3SEEZIHahTsgtB+aHib6wD9tk6yZdAOYlIaeW+n6DnaeBrT0/X5zgEDUM0viQngDfke9xdzdPI7RxifzEjvUIt2FZcTQoexlA+gTwZvdtREdgCgLCLFt6Fdya7lsA/lzPeX1/LaScdT2oRL0xUkjS99hXeGpc0mCI07Tm+JVK4NvDzvuvNMzpUdf0lM2kNT7J/Af60rmMTTF5Q3teGKG9W5C/+/smLU/X/Fqgai9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUPZ4MQJMpjoSybtQ68WPQAhMD1jdNQl4y7aSkFqJUM=;
 b=U+lVVbOEddxeH0r9s6QX4KRRCcyCJRFuG0kuBDO0wwtCNt+2ddgKgCfa0biZz6G59qSbocBmt8d7D5zN9t4Pq1+In5/dDR5rH08MtbKhrz/aZQwpFlUISmexymnMwtZOTqieHuQry3Y0kSjien8X9HtzlGP0NU4n3e87/+B5QZZvih+sOJo4lHc3Gl8a3oZEv2OkViAsJFBosyoHpJVMR31zFrrSIIEkuH4X4PFzpZw9nobiY/Q90ULo3+cQ/vIYedlJmfVNZ5bF/pOdD+RN6vTrAc5raoxPjFLr8UcC0FcU4yRRw2XNLrtZ6ZBlUtwHPhHMLf7ZoYJHWPCw+KbVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUPZ4MQJMpjoSybtQ68WPQAhMD1jdNQl4y7aSkFqJUM=;
 b=VFY00nBa1QR2QWyVPzMpks4kCA9bkvoj38wG2T6hTlCJ/S5uowB4/HvdVJA4IrjAvDaucw8LXQgcFqNzinN2x+YlyFm9I+9I13LZUYVvXYTyBS+lzXcqVkoljyRwd+kQowk/HAkfL2s2m8XeWxIdN2kJ/k4YQxVfaJLL1th0tg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 14:10:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 14:10:07 +0000
Message-ID: <a089317c-cf9a-469f-a8d1-2aca8769d56e@amd.com>
Date: Tue, 24 Mar 2026 15:10:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate SIGNAL/WAIT ioctl input argument
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260323033023.3338683-1-Prike.Liang@amd.com>
 <PH7PR12MB600006CE3FC81B5FF6985A87FB48A@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB600006CE3FC81B5FF6985A87FB48A@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 359ead18-7fe9-4169-f7ef-08de89af0ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hq68SFFXZZ4o1AKzjbxxbt4+ObZ7VUqjmqZzks9KPUMeYtHCCRW2nEVQe5AJEvaphBiOVIirDL0gn08Iobh52vVuasp85ygVHM9LM5MEKm89D4QLq1+CAkN1b+pxdwUkDTR7jXZp34i/bhjj2zvhxAWgCfQaxK8Qve2wWN2fItPO+Wnq8B17lRBJTTPnW01iM2419hhddxFbZiXcSewQ3fkBOx/yUpO3aI7tM3nOayWXySfvhXokq8Eb4uU9E2Crmv4K+CoPhaTaYxHz5WBgOPIuN9zpeR8glQiP0OsIclxfqpS1hsvQpRqeAvdZZKwbnZzUNuNogo3uE3dNa6s1V2JHdohMHSaZPm/4d+FgehWby8kvYPt7a2IIjIONN8V8WKHdRKrxTroDz1QVtHvmy4JTwPS/O0U3bKVTtl21s2CiRGkl1+P4hemkGRQTdQ7I+tx2MnM+BGE37fvAUbEy4yRd9mSzf6BJGnN5xzUYWw8FDoE3JMM81FVTj994k86gPh1QCLR0slF7QX++jYmRzJdDGzT6uJHKlyY8rL+akOGyl5pfKxx8NgMNHShsVzahaLdp1UpPbY3t2MeiLr1prq4Ehf3rcr5m34PqUXpI7Do/AQdhlCia4Xu6u/dmMD4MFu4hM2uah9ap6XE4qkFHn38xp3LfSw4ZVfnQ7RR9dysbhsRZrsSPpsGYTGY4B8DMYVdFzz3S7fAiTYwFPs6CRMde83zCn8BA8MvMv0zvaI0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmI5a1V3UUtubVRrWUNBaXc5MDdaOVdTSkdCeHpJeTZrWVlHeTFpWnhjMlZK?=
 =?utf-8?B?OXlzVjlzQk9ieFJOMnBXdnRLN0o3ZGh2MWJoM29yaTk0eXNSNUdrdC8yUnNx?=
 =?utf-8?B?SEdQQnBOOWxmMHVkQ0d2VFMxalJOb2lzQmFxV0NqeU9DYWd4YyttR0JLdTlx?=
 =?utf-8?B?ek9jeFRiZGlhMFU4TDI3S0pNNDNJZnpzQkNRV0xpWXR5VGFoV2lHVXFZY21K?=
 =?utf-8?B?RDVreHVQaDNHdWQvR25MakNCR3U4UWhqRkRaT2xIRXQyRG01L0YvMDdYWUxs?=
 =?utf-8?B?V0RWQzEyNlhOZjkzanh6VFYxVkI3elFRT3BqMDBJRERQQmJhWmpmUmJ4UGI5?=
 =?utf-8?B?akZaK0dic2tNZzBZUkxyRk5XMG9NNGxOMVFkWFdqS1VhaFIwdEJMd01XWHB6?=
 =?utf-8?B?bkRZSmowdnVQRGtPU2JJcjFRU1VEM000N3pQRzlqVjE3d2hDMHlsY3UzZXhh?=
 =?utf-8?B?a0xjZmdvaVg1cmNLOGR6aTA2R3ZiQlN4RnNVNG5RUzdsSzJDOGFVT1NKUE1a?=
 =?utf-8?B?cWVMdjRKSEE4RkJodU5CVXlBRHhOT1ZGU0NwOENlT3ZLaFlVYXRoYkZGY2lt?=
 =?utf-8?B?d01tcnJsbjl3UW1FeUlLekFpakNnQkpvaE5FSC95ZklpVWg5RXFJL2xVOTda?=
 =?utf-8?B?KytHdmR5NXlNVkxxQmx4QkFXVStpRnluUGtuM2NFUG9OZ0kvR2ZQL0wxcVZx?=
 =?utf-8?B?c0dYa0pmc0hSMVFPbjlvS2R3S25pTGtHNkxMbU9yVS9CQ056OWtaME0vVWdH?=
 =?utf-8?B?cUloTmdqVVBvbk9QK3pJdk1JUjdVd010cVdyL3dFU1JZMjBnaWdVVnFHK2VZ?=
 =?utf-8?B?Uk9GSXl2OGRHdEhzcHFqbDdBejB1ZUd3bjZyTFh2RDFVUWcrVkllY2pmaWhy?=
 =?utf-8?B?aVhZVVlHbm8yek9JZzJ4cXozSHorQ2hDM3N4bFZpL0pZNHlYYTIxMTliRFhY?=
 =?utf-8?B?S2lzTW4zeVhQNHJXZWhVTnR1UFM3ZVB5cUIxZENOOC9qQS9jaTErMkZ1cGNF?=
 =?utf-8?B?UHBhT2NwVG9iSFhhaEJFdzhDeEZ0cjkrVHpFMWYwMFp3OEZXZy8rRGxYSllF?=
 =?utf-8?B?MmVPbWh6SUxBOUtHaDF3Z3hOaFd0SUN3RityRzQ5RlFGdEFOY05UOWpENWpU?=
 =?utf-8?B?S3h3OWlvNys0cTFpcnFRMFU1LzRzT08xVW9PZ0ZicE53ZWF5SE0wc2NLTWNh?=
 =?utf-8?B?Qk5XMXFjQUcrWXZiYXp0S3F6cWx6c3poUkkwbHczZ3NEejFUcmNOa3p0bEx5?=
 =?utf-8?B?TytSZW9oekgyd2V3NFJFbk5zbmM3WmQvWmRsYWFockRpSWJSZWZzeXN1Z21v?=
 =?utf-8?B?UlBDM3RKdThrRzdNRUhSQ3B3QUpDeWFZck9ZUml6UEhnRmZyOVprQzl6bjJa?=
 =?utf-8?B?RzRjeEJJYUViYlMzalA2K21wS2VVZm1pWjZXMVRCWEFzWGFvSW4vRGdod24y?=
 =?utf-8?B?RElXMmhGQ3c2NGU0T01kWEU4NC8yelViMTFuSG1mVUlnOW5WT0NqbFBycFd2?=
 =?utf-8?B?Vy95eFB1MEN5cDlGaGZwRXY3dnNsSVY5V1llbUdoTHV3MDl6SVdWQ3dLZS9k?=
 =?utf-8?B?NytDdGFPdE1jbk5ZbnhsWHZodHJSVVJUVDM4TWVUQXRqTThrREJxSjk2akFj?=
 =?utf-8?B?UmRjMjRLTlp2Si9wNW5kNlZLVU9yNU9MOUpsMDFPSEg0MS9EbmdKZEcrMWdJ?=
 =?utf-8?B?UU5Ibzl3Y1ZBVjhuL0dDdjZRb1gvSVZFM0o2b3REaW1Kcjc3Q1RVcnJvc2lj?=
 =?utf-8?B?UHpwYlRsTm5SRExmSisyVEtldnhqUm5mTnlUSCt3dTg2QXpYMG9JRVFMekFG?=
 =?utf-8?B?UndzeUtiS2hZaUJRUElYK0p0dVV4alRrM2V1TGpLNEhlM2FRMml1U1FZa3Jj?=
 =?utf-8?B?RmJNU3lFdFY1Wkxyb0Z0MUZKM0NFZ2hIRzZjdmZxNldINHFIZFZyMTA5M3pZ?=
 =?utf-8?B?NXpSZWNncVE0MjMzNFJSamZoTnpaTmJIT1llV0MyNWJuamF4NWZ4dG5DL2lx?=
 =?utf-8?B?alNqN2hLU3N3TGxwWTdCc2JkZjdadEtKeUpTU1JRK1g3Vk92V0ZnWVBiWjEx?=
 =?utf-8?B?OFk2L1ppUFBIRndJd3h5S1hIVGJrZ2pIS1BONnVqODhYaE9zbW1QWXVRZTlS?=
 =?utf-8?B?d0daSmI4b2ZDYk1oYVowLy94Q1h5aVVxWDAwYW1PNzRpTHdWNUs3VFB3a1FZ?=
 =?utf-8?B?TTZxRnBEdWcvY014bjdQd3cvd1V6RnVKQVJZTFhUeUE2RjlTM3dyOGRoV2xM?=
 =?utf-8?B?UzlBZU1FeEFFTEtTaXBvOXhDUStxdStyclIwQ0JZNTZnRk9EMEhHRGNaMlUy?=
 =?utf-8?Q?8M/bmp0h7bJQeI9GkH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359ead18-7fe9-4169-f7ef-08de89af0ce0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:10:06.7808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5Fn9j2nczpK83GpP+wGECcdH1+e3HgQ1/pqmPKcYUpPTpDIDwPYPU0hMncMJW1W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

I don't think we can do this right know. Userqueues is still a beta feature, but that would break existing Mesa releases.

Regards,
Christian.

On 3/24/26 14:40, Liang, Prike wrote:
> [Public]
> 
> It's not too much change, so ping?
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Liang, Prike <Prike.Liang@amd.com>
>> Sent: Monday, March 23, 2026 11:30 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
>> Subject: [PATCH] drm/amdgpu: validate SIGNAL/WAIT ioctl input argument
>>
>> Filter out the invalid userq emit and wait ioctl input arguments.
>>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>> ---
>>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 27 +++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index f93da45cfa7e..7b2700a0c0ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -483,6 +483,17 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,
>> void *data,
>>       if (args->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
>>           args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>>               return -EINVAL;
>> +     /* After the mesa allocates the input obj properly, then there
>> +      * also requires filtering out the invalid obj number.
>> +      */
>> +     if (args->num_syncobj_handles && !args->syncobj_handles)
>> +             return -EINVAL;
>> +
>> +     if (args->num_bo_read_handles && !args->bo_read_handles)
>> +             return -EINVAL;
>> +
>> +     if (args->num_bo_write_handles && !args->bo_write_handles)
>> +             return -EINVAL;
>>
>>       num_syncobj_handles = args->num_syncobj_handles;
>>       syncobj_handles = memdup_array_user(u64_to_user_ptr(args-
>>> syncobj_handles),
>> @@ -946,6 +957,22 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void
>> *data,
>>           wait_info->num_bo_read_handles >
>> AMDGPU_USERQ_MAX_HANDLES)
>>               return -EINVAL;
>>
>> +     if (wait_info->num_syncobj_handles && !wait_info->syncobj_handles)
>> +             return -EINVAL;
>> +
>> +     if (wait_info->num_syncobj_timeline_handles &&
>> +         !(wait_info->syncobj_timeline_handles || wait_info-
>>> syncobj_timeline_points))
>> +             return -EINVAL;
>> +
>> +     if (wait_info->num_bo_read_handles && !wait_info->bo_read_handles)
>> +             return -EINVAL;
>> +
>> +     if (wait_info->num_bo_write_handles && !wait_info->bo_write_handles)
>> +             return -EINVAL;
>> +
>> +     if (!wait_info->num_fences && wait_info->out_fences)
>> +             return -EINVAL;
>> +
>>       num_syncobj = wait_info->num_syncobj_handles;
>>       ptr = u64_to_user_ptr(wait_info->syncobj_handles);
>>       syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));
>> --
>> 2.34.1
> 

