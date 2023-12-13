Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E394AC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 15:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7CC10E277;
	Wed, 13 Dec 2023 15:41:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEDEC10E277
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 15:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX3pbHFpcYX/KMkzHHL1bcMECXmXacj9f2QUsScrgLkSDfN22paU1LZz6jBBLa52ecmCCeJqOYN6Iirw00k0Fk93AywENwJAvsZcrvM7CcMJlIi5QqF/Oy2LVkDL7HzsN3Z303ELZBmvI3AWi+bGeXI/U3VljwywmL6538nnQOyfY4t0ctHFNuNoEwTsxe93Ol8EEt8Q6S7LHWDcrT7vWhkVTQXKyZF/OzFxTuP3+/TvloNhA0fWOCOdue2BMnpMjAPz4Z9EKveTSqQx/D2lvAYQJc5vcA2FmA2J/RTZvfo0JvZaYLSQsqmcOHWpD0zDXHYPHR6T0D0z/Bj/imqffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgsajrfyqnKoGYrWwgaglUZ/SlxcEGcPQuiCDGeKZeI=;
 b=SsoAnxp2pnKAnucZq6CxFkC5pl0yDCHc+HuPYtK0plgZHy/nFE0aRFni1Kti65NzQ8qPxClMCnAVIn1By16i2+mDBMCqaC0cjHuxYcgB9OS/Wn1x0h5GjBoKSBOgV2+ZEdolm7RPXMACCqQ4KccnPDkANgPzK285WUSANt92oKDnvTg5v+KLSWKwc64l4GhN5AvedRUDWWhrXIzE+VJxtW+1ztuZBMFbInoFfgKd5NVG9yGljFCpTnfWT9AsiPaJ4BeRpAMgOe1DOAQFjowX4hyEPFXDoTzTTXGHiI9NvOpuwEJCIDLsZP2dYo6i7yvgad+IAVPL5fiMGw6ENJMpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgsajrfyqnKoGYrWwgaglUZ/SlxcEGcPQuiCDGeKZeI=;
 b=34oph9G/eqS0UfHfT7Gn77Va5JczXVze3KjpUOD45iss+7DwqQC4n7UTa1D+dk3Luh4W18yyNLFIAn1HPj7pBhrjT64Yido1GTcEiuyqu5/0E2EATHXaQVuHblugg33Vd27LNCImuS1sEXhnJAWSxz6QF+3D3YogDGCyvHPebmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:41:20 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 15:41:20 +0000
Content-Type: multipart/alternative;
 boundary="------------UJd8YIu7Scfrl48HpOk46Z0S"
Message-ID: <5afcd203-cb7a-412a-8cad-dd3bf44058dc@amd.com>
Date: Wed, 13 Dec 2023 10:41:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/23] drm/amdkfd: enable pc sampling query
Content-Language: en-US
To: "Yat Sin, David" <David.YatSin@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
 <20231207225422.4057292-4-James.Zhu@amd.com>
 <DM6PR12MB5021CAF710E26D085BBCD92F958DA@DM6PR12MB5021.namprd12.prod.outlook.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <DM6PR12MB5021CAF710E26D085BBCD92F958DA@DM6PR12MB5021.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::34) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a1ecf6-d2f1-4574-f91e-08dbfbf1f41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcRDHL9HLF+EhqbPRebYGD8rY/unw72PqH4o4tR6jCo+5OGwITx66BvuhqTh5DIhAwJTNVInWKnWImkrOQgJEjS2IjGvcQh7IRWXS27rHGkpt7xuiXjQUNakv17P4zcYgLTCSsziPgNwChXT/5JBQScdkYwzPZ0a27qsbWdBv1EN5WD1n/KIoUrMqeHR278NpuGlQwo3irRcXs8qAUZ3T0aIC7gyA+42sWZlvJRqwBfvInY6Q4miEeJedVVmGsoHimXXCReXke2YlDD51qtIWvPxiCmrOEG/ErIyegCdue6cVI23Oa2+EgUlf8NUlylsJ8Ws6do6Jbf59HXN83Y8ECe3b+HH7R2W+TLyq/tOucdMVDSUF8q6IXrdCtlU6YgUyG/iujlQ8yxC98wHgKG4x/8iSVJv3lq33G1OMvyGC5qlY9UBPTr/xAuG+0+pjRogz/ze0jldHahqtGiu+wwfiVHp8exfo4DGSZku2Wr4Pcyce5Dpe8CWDmCKwFBP08CVxz7lNuKoxzVlyDPwZN7DyrY9QEzHuViS/O60UIDC1Hoa7TcZj36+7teAdeMEmq2QWs3OzT18JSztgvjnbES6wFkIMwEGsx2BahYS5z6TfOZurpVpSfygsHJwNy5uddw900Gywe3abzJGL0uAzwHwzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(36916002)(26005)(83380400001)(33964004)(6506007)(6512007)(2616005)(53546011)(4326008)(8936002)(5660300002)(8676002)(41300700001)(38100700002)(316002)(4001150100001)(2906002)(478600001)(6486002)(54906003)(66946007)(66476007)(66556008)(110136005)(36756003)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHBnQWVic3dOZ21jSjlxd0FUSTI5ak9NMkNWUk1YNkJjYi9zVEdGNmYwRzBP?=
 =?utf-8?B?aWMxbnBTbFhTOVc3Qjl1VlFVdWVvQmFzdkpLUVdndGZSamtTdUtJaTdoV3lu?=
 =?utf-8?B?KzNSUVVtNEhQZWtvY2d6WmZRWlVmTkZaTGZCM295aUVhL2dCS1ppblpySzNh?=
 =?utf-8?B?bWtOSGUzOEpLL0E0RnBpRG5ZeTdJUW52OEpVR1l1TEMrZ2JkOWxZYkVXRUhw?=
 =?utf-8?B?d3NJaThYenNudFBkZnNhZHRQTzdydW4yN1h6cjhqQjUzMHpOc1FWazNaVFhp?=
 =?utf-8?B?c0R1RFhWTFRmc29wcmVEYjdPSHE4NTZzbk4vSXdBVEYvYjhOUkowNGhLdDBk?=
 =?utf-8?B?TEl3MllXZmpWQUlVa1ZzM3pMZENlZDgzVUxIVCtsdjBucXUzWDlpUzZ4eDlT?=
 =?utf-8?B?ZTdmL1VsNTlUcDRPY25vS1dHZ2ROU1ZDcENaeTRaTU1BUHBaN3JjRHU0ZFhE?=
 =?utf-8?B?SXN2ZzNhdWlQVERkaVhnQ3NLSFRiMGtBa2k4aHBOM3RNMlNmcFBPS0ZOTUFK?=
 =?utf-8?B?eXFqcHlQZ3RiUWRjdVBoVFJBRGZpd2NtbEJwMU1vMHVsZ25XZHBwTHRYTHJr?=
 =?utf-8?B?dWI3NCtiUzFZU2JMUGtGa1J5KzVZVnVWekVzcWNJWTQ2MU9NV2o3ZGU3U1Uw?=
 =?utf-8?B?WG9Iak1JUmxuV1ZTVXhiVnZPcFhnZ2hMSTZPZFppc0pYUHVwbFJFTEY4QVhj?=
 =?utf-8?B?K2lBcWh5dk9iM1loRVNXMGo5cHVCYTRjbnV1TTZncDBMNGcvcWxLcW52dlFM?=
 =?utf-8?B?ZlJTNEY0UUhlUTZBZ1VsR1BxY2dSeDVDOWMzNS9HSzRvaU1XQ2R1cXdEcmV0?=
 =?utf-8?B?bGs4Q3VyeitKanpYdUlGR1pPNFFBNE4xbVh2cmNkN25lbWxSdEJRREJuOExQ?=
 =?utf-8?B?TllOd29qVzNsY01UcmJReEVUVkI5WnRHZXlrclRhQk5kRTZjakZrbEtSYVVT?=
 =?utf-8?B?eVk1YWY4MndYMm91RGZYZFk5VmR2NmZ5YVlIQ1NpcmtlL0FMc0xsNkFHa0p4?=
 =?utf-8?B?T2NWY0Q2STcvd1BuVFlwb3JqdFBrY2U4b05TQzlWRDVEMU1GbjhWL0VTMitK?=
 =?utf-8?B?Z2EyNzF6ZlZpRFNBQkVyNVFBejF5VmRuYlFtMVhKRHFwWm5GNE1TOEV4NnZh?=
 =?utf-8?B?NU8vMjh3SmhCTUlpa0JWdVBLSkpnMzRLYll0TmZHSWZ3VFFCd1NvZWgveGNU?=
 =?utf-8?B?dGZIUG1vWTc5SmZULzFPUlFEU01NUDJOZjRHcFppKzB6ajFvcUg2cnRjZ2Ft?=
 =?utf-8?B?U3lnWU1zN25sTjVoN2h1d0tHUlF0T0Flb0dORDZqRGZzVmM1TzlkQ2R1TTZD?=
 =?utf-8?B?eWczVDErSmpNRTd5SXczMlRXOHVnZWU4OVkwUzNjL2NlbXlEbVlJVFAwei9E?=
 =?utf-8?B?aGp0UTZyWG9aUm9rQXFUZWR0OU5DUEEwSkJ2TFRCTTY4dDhxSmFjVGdaY0Zj?=
 =?utf-8?B?MElHR28zdTBVMXBwekZod05vcFhMS0VxbU4xWGlybjNEY05zVnZNUEdNMW9t?=
 =?utf-8?B?aWU2K1E2OWsxNkZtUk1mcGJ0REVNOFFIZ28wcVRXUUNBbXJRSjRsQ2NjN3F0?=
 =?utf-8?B?U0diSDhNSzJqc0Y1SmdMbkRaeVpKRFp3RllheUQzMjNaRWIraXRsVGxrTExw?=
 =?utf-8?B?d0lqWCtUQnVIcU00QmcyRlpSNmZHWmxXRWJxcS9TR25lK1RTUGdVMkU5ZkNn?=
 =?utf-8?B?blRXVFM2akZrRk9nUVRSblJCcjlqd3UzU1ptazFpWWVyTUlKMXczQXluLzRi?=
 =?utf-8?B?REQ3bGVGY0tDK3RpSVhuWUhsS2xJTXRsRmt4djJRZzBhOW1ieTNuR2xmQ3hn?=
 =?utf-8?B?TFhJRVBxNzc1SUpnNDNyTUJwS3o3aThRS3RhVTFxUmJVb3dzdHFZSDN0ZnBa?=
 =?utf-8?B?dGQ3QUVLck5FblZOTm56UDMzV1pKT0hOVE9MK0N1K2N3bVUveE1aSkk3VU1j?=
 =?utf-8?B?amJTaTlQa2labE9ud29QSmRGSVZla0k1TlVQUW15VmR2cURyWVdwZTJSQjJU?=
 =?utf-8?B?eUorbDhyRzZpaUlhNU5sQ3htMTk4RG5JNE5TaW9ZOUZQM1ZMYkZBMy9GQ3Zz?=
 =?utf-8?B?WTRyRk13UjJsZmU3QTRkWTZ6Mm1lQkFLZGZtenU4VDU2Z3ZjcGI0MXR4dDV1?=
 =?utf-8?Q?i6fYfYKGgVbqGEE6Gpvx5APuV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a1ecf6-d2f1-4574-f91e-08dbfbf1f41f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:41:20.6572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBWRevv64MdyHaG/eemDk22HmgBMFUJi3DpaJfvLLgiEzJZQ+glXwghXbbq6gIRj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------UJd8YIu7Scfrl48HpOk46Z0S
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2023-12-12 19:55, Yat Sin, David wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Zhu, James<James.Zhu@amd.com>
>> Sent: Thursday, December 7, 2023 5:54 PM
>> To:amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix<Felix.Kuehling@amd.com>; Greathouse, Joseph
>> <Joseph.Greathouse@amd.com>; Yat Sin, David<David.YatSin@amd.com>;
>> Zhu, James<James.Zhu@amd.com>
>> Subject: [PATCH v2 03/23] drm/amdkfd: enable pc sampling query
>>
>> From: David Yat Sin<david.yatsin@amd.com>
>>
>> Enable pc sampling to query system capability.
>>
>> Co-developed-by: James Zhu<James.Zhu@amd.com>
>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>> Signed-off-by: David Yat Sin<david.yatsin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 54
>> +++++++++++++++++++-
>>   1 file changed, 53 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> index a7e78ff42d07..49fecbc7013e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> @@ -25,10 +25,62 @@
>>   #include "amdgpu_amdkfd.h"
>>   #include "kfd_pc_sampling.h"
>>
>> +struct supported_pc_sample_info {
>> +     uint32_t ip_version;
>> +     const struct kfd_pc_sample_info *sample_info; };
>> +
>> +const struct kfd_pc_sample_info sample_info_hosttrap_9_0_0 = {
>> +     0, 1, ~0ULL, 0, KFD_IOCTL_PCS_METHOD_HOSTTRAP,
>> +KFD_IOCTL_PCS_TYPE_TIME_US };
>> +
>> +struct supported_pc_sample_info supported_formats[] = {
>> +     { IP_VERSION(9, 4, 1), &sample_info_hosttrap_9_0_0 },
>> +     { IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 }, };
>> +
>>   static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
>>                                        struct kfd_ioctl_pc_sample_args
>> __user *user_args)  {
>> -     return -EINVAL;
>> +     uint64_t sample_offset;
>> +     int num_method = 0;
>> +     int i;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(supported_formats); i++)
>> +             if (KFD_GC_VERSION(pdd->dev) ==
>> supported_formats[i].ip_version)
>> +                     num_method++;
>> +
>> +     if (!num_method) {
>> +             pr_debug("PC Sampling not supported on GC_HWIP:0x%x.",
>> +                     pdd->dev->adev->ip_versions[GC_HWIP][0]);
>> +             return -EOPNOTSUPP;
>> +     }
>> +
>> +     if (!user_args->sample_info_ptr) {
> Should be:
> if (!user_args->sample_info_ptr || !user_args->num_sample_info) {
>
>> +             user_args->num_sample_info = num_method;
>> +             return 0;
>> +     }
>> +
>> +     if (user_args->num_sample_info < num_method) {
>> +             user_args->num_sample_info = num_method;
>> +             pr_debug("Sample info buffer is not large enough, "
>> +                      "ASIC requires space for %d kfd_pc_sample_info
>> entries.", num_method);
>> +             return -ENOSPC;
>> +     }
>> +
>> +     sample_offset = user_args->sample_info_ptr;
> If there is another active PC Sampling session that is active, I thought we were planning to have code to
> return a reduced list with only the methods that are compatible with the current active session. Did we
> decide to drop this behavior?
[JZ] Do we have design changed here? I though we allow sharing the 
sameactive PC Sampling session between multiple processes.
>
> Regards,
> David
>
>> +     for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
>> +             if (KFD_GC_VERSION(pdd->dev) ==
>> supported_formats[i].ip_version) {
>> +                     int ret = copy_to_user((void __user *) sample_offset,
>> +                             supported_formats[i].sample_info,
>> sizeof(struct kfd_pc_sample_info));
>> +                     if (ret) {
>> +                             pr_debug("Failed to copy PC sampling info to
>> user.");
>> +                             return -EFAULT;
>> +                     }
>> +                     sample_offset += sizeof(struct kfd_pc_sample_info);
>> +             }
>> +     }
>> +
>> +     return 0;
>>   }
>>
>>   static int kfd_pc_sample_start(struct kfd_process_device *pdd)
>> --
>> 2.25.1
--------------UJd8YIu7Scfrl48HpOk46Z0S
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-12-12 19:55, Yat Sin, David
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB5021CAF710E26D085BBCD92F958DA@DM6PR12MB5021.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">[AMD Official Use Only - General]

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Sent: Thursday, December 7, 2023 5:54 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Greathouse, Joseph
<a class="moz-txt-link-rfc2396E" href="mailto:Joseph.Greathouse@amd.com">&lt;Joseph.Greathouse@amd.com&gt;</a>; Yat Sin, David <a class="moz-txt-link-rfc2396E" href="mailto:David.YatSin@amd.com">&lt;David.YatSin@amd.com&gt;</a>;
Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Subject: [PATCH v2 03/23] drm/amdkfd: enable pc sampling query

From: David Yat Sin <a class="moz-txt-link-rfc2396E" href="mailto:david.yatsin@amd.com">&lt;david.yatsin@amd.com&gt;</a>

Enable pc sampling to query system capability.

Co-developed-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Signed-off-by: David Yat Sin <a class="moz-txt-link-rfc2396E" href="mailto:david.yatsin@amd.com">&lt;david.yatsin@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 54
+++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index a7e78ff42d07..49fecbc7013e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -25,10 +25,62 @@
 #include &quot;amdgpu_amdkfd.h&quot;
 #include &quot;kfd_pc_sampling.h&quot;

+struct supported_pc_sample_info {
+     uint32_t ip_version;
+     const struct kfd_pc_sample_info *sample_info; };
+
+const struct kfd_pc_sample_info sample_info_hosttrap_9_0_0 = {
+     0, 1, ~0ULL, 0, KFD_IOCTL_PCS_METHOD_HOSTTRAP,
+KFD_IOCTL_PCS_TYPE_TIME_US };
+
+struct supported_pc_sample_info supported_formats[] = {
+     { IP_VERSION(9, 4, 1), &amp;sample_info_hosttrap_9_0_0 },
+     { IP_VERSION(9, 4, 2), &amp;sample_info_hosttrap_9_0_0 }, };
+
 static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
                                      struct kfd_ioctl_pc_sample_args
__user *user_args)  {
-     return -EINVAL;
+     uint64_t sample_offset;
+     int num_method = 0;
+     int i;
+
+     for (i = 0; i &lt; ARRAY_SIZE(supported_formats); i++)
+             if (KFD_GC_VERSION(pdd-&gt;dev) ==
supported_formats[i].ip_version)
+                     num_method++;
+
+     if (!num_method) {
+             pr_debug(&quot;PC Sampling not supported on GC_HWIP:0x%x.&quot;,
+                     pdd-&gt;dev-&gt;adev-&gt;ip_versions[GC_HWIP][0]);
+             return -EOPNOTSUPP;
+     }
+
+     if (!user_args-&gt;sample_info_ptr) {
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Should be:
if (!user_args-&gt;sample_info_ptr || !user_args-&gt;num_sample_info) {

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+             user_args-&gt;num_sample_info = num_method;
+             return 0;
+     }
+
+     if (user_args-&gt;num_sample_info &lt; num_method) {
+             user_args-&gt;num_sample_info = num_method;
+             pr_debug(&quot;Sample info buffer is not large enough, &quot;
+                      &quot;ASIC requires space for %d kfd_pc_sample_info
entries.&quot;, num_method);
+             return -ENOSPC;
+     }
+
+     sample_offset = user_args-&gt;sample_info_ptr;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
If there is another active PC Sampling session that is active, I thought we were planning to have code to
return a reduced list with only the methods that are compatible with the current active session. Did we
decide to drop this behavior?</pre>
    </blockquote>
    [JZ] Do we have design changed here? I though we allow sharing the
    same<span style="white-space: pre-wrap"> active PC Sampling session between multiple processes.</span>
    <blockquote type="cite" cite="mid:DM6PR12MB5021CAF710E26D085BBCD92F958DA@DM6PR12MB5021.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
David

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+     for (i = 0; i &lt; ARRAY_SIZE(supported_formats); i++) {
+             if (KFD_GC_VERSION(pdd-&gt;dev) ==
supported_formats[i].ip_version) {
+                     int ret = copy_to_user((void __user *) sample_offset,
+                             supported_formats[i].sample_info,
sizeof(struct kfd_pc_sample_info));
+                     if (ret) {
+                             pr_debug(&quot;Failed to copy PC sampling info to
user.&quot;);
+                             return -EFAULT;
+                     }
+                     sample_offset += sizeof(struct kfd_pc_sample_info);
+             }
+     }
+
+     return 0;
 }

 static int kfd_pc_sample_start(struct kfd_process_device *pdd)
--
2.25.1
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------UJd8YIu7Scfrl48HpOk46Z0S--
