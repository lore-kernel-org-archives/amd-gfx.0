Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D65CC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 15:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D2CA10E399;
	Mon, 13 Nov 2023 15:12:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED1210E380
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 15:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFRRFwfcLHoje39wmZu+FRKXxOWtrskL+LmQsV29dPhYcfyMPNnJ+hcT8N7CiwBYFHEoT0HsnriW3vhiLPI8lH87KUkSZ4MKh6mfGgeMjl5ac8Z/zAeeqfoDcTz+4JrmXsztNz6CKidLTPsLdQiTF68ajyuFGfWTSfziTtFMkAgiptAv1TufqutBcdEvP4dMJa2cQxXu7cvbVVTsoJnJKCww4Xvhz6OvF0qFqep6jB4uNu6zcJ6Q1u7wk8RSgtHDKnsa0CdzVweHbfAE+5R3v4rp24NC4JpD3QwIBSIwT/v7XeulHDF5TdacxZq6ySoAhRP+RaVfMiCqbE+RFtVLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olvQzRj6omJMB+PNLWASzQ//QCmZEZ3wnPmsBNb/bXA=;
 b=kUJpKFLUaE7/PU9wNp1kO4mCiKKzbEvEdRCqF1H2RcTltCqt6YAF/kQP/qEwWs+lZDOcnGb6yilP3Q6PZ2CnsrPOjSHCg9xxlSWyxRgHNUqHYiI94C6KqyR/AMAm/N1duOc4WxAPW8uiezJaPAg3C3mC5jBV4jgdQlNjD+begaWV7BWHgd7F9ufr0bdti2lP3U/RNP5al73H8852aK5IIJftdM8x4mFSQzKx2lWXu8SJ2prvRcblTFKxWsOVChWHVAz3Jgpc5HRzU99tjZP7aWyyeFTdyxxlh9sPbFmEjkeo0Z4K9gIbeVsYeLdkaGffZdkyXrIqsGppc9NGm9/wAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olvQzRj6omJMB+PNLWASzQ//QCmZEZ3wnPmsBNb/bXA=;
 b=EE/SGTdqzxZAM0D0Eoxdj8ObOlbbL2JligKGQbxLZZe2AWTcZZGt0rmhKqYb1/1DR+Xi4xU+0edq+fP3MTIrerT9SF7eza0AMBQlIfd5yrPk8LpzOiEISWAnfAgduTWMBIeoLgz3doQY+p1/CnVtdOLzfDNeO1dRQpIXOjKunOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by PH0PR12MB8052.namprd12.prod.outlook.com (2603:10b6:510:28b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 15:12:38 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 15:12:38 +0000
Content-Type: multipart/alternative;
 boundary="------------CaAhPO3ocUrS06FsRIaXjWyH"
Message-ID: <e26179d6-f172-4df4-8ea3-a3cbceac6ce0@amd.com>
Date: Mon, 13 Nov 2023 10:12:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] drm/amdkfd: add pc sampling release when process
 release
To: "Yat Sin, David" <David.YatSin@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-23-James.Zhu@amd.com>
 <DM6PR12MB5021960306E3061166F20DE095AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <DM6PR12MB5021960306E3061166F20DE095AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0328.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::20) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|PH0PR12MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfb0dd4-74b8-4a30-a08f-08dbe45af93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOSMdzBHopVULheZ9P5vOwqHCEIuFQsR+844UreJ1hD7kjge+SFczSG+oi4YVEY3VK2xJUc72rigHPOh3l+voj5zmRtNDenqMq+Z6KkdBN/IJEcC0Bs5XdzlDUTOR3YQulC6EFEIzRvQUORLq2pCH+Oxsvi8ltSr0NgPKnQWtkkPxrcBqpTjyadQMgD3otBj8dNy8oRWRXw3uGxkFsVem4V2RxILTUiiC50fAeRA5DbbyaapX8CnaXdAJy08ulxyAPse8xVQx6CalUfYfbufGhUakpz1mRkfJ4vBxCryZ0qfEXc3wxE/ivWYsKh6nJ6KiIBZWw7SuVWzmHEsl8KMGVrN8HwThwS6GCellroRHjvbF1RY1aUxOOsK+Ewo0d1sj+sg+opfdUoEoWWv3NFrhL53Q+I0xmXsYmOxgOobfhvmTYPH2qCBsYrhGLUhkFpcvEjFp/7HZmWPWWb9yCz2UtjILO13P3fGBANiWXRrXqIRi4avl4mDQ5UIimV+TlO7o7LF3EkPtrxe2kbOcWL7sSueNI/nlFDDcLmqoR7xGNuw2DBqLKr8yKVEM4VDBaw7ttXUUJM+pHDrsSm6xERAKmFBwkfQN5yF1ruJvJd7f0hFqIT86smX7ixxpo/18OCD1EiE0YnjhvvhGuC1TcOjcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(36916002)(33964004)(6506007)(53546011)(6666004)(2616005)(6512007)(83380400001)(5660300002)(4326008)(8936002)(8676002)(2906002)(41300700001)(4001150100001)(6486002)(478600001)(316002)(110136005)(54906003)(66476007)(66946007)(66556008)(36756003)(31696002)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z21LUzVWSEQxbGFwQmNFOEREczlzaDJtUWdJQjUwQ2NpMkZGR21SbkE5SDBx?=
 =?utf-8?B?NHdiRDdRZGVmczFCL05DZ1N1aTE1QnJoNmVPQnAwWGJMS2hwYzNwblZIYktT?=
 =?utf-8?B?Q1E5QVVxeW54RGl1R2UrazNFemZYMTZJazNobG1aSjVhSmRBTkhlcngzeTF3?=
 =?utf-8?B?QndHbXQxK2FoY0JSbWY3ZHBSUjJic3BTUkxLcUU4THRPTXFBMjZjZlJ3T09S?=
 =?utf-8?B?cjJCUlkvMkt3eGNzSTRmM2RBdEZkY0N4ZmVsc2lhRDZnN3plbkpNWVBqVmJN?=
 =?utf-8?B?aHFrdGFCSUNBTW8zRXN1TlBoa2ZTRGpraUtwUWVJZncxNm45L1BWNkZ5SW16?=
 =?utf-8?B?WmRMb0ZNRnVpclAzU3F1NytnSWtQdWdyMUU5ZzB4dnJnSjU4NW1RVDhQZDlI?=
 =?utf-8?B?WHBPbStZK3FSaHRjTStqZkhaYmp3SHJPTzl6RG1jTkVhZTFXdmFpc2ZnQnBr?=
 =?utf-8?B?WHZxVzVLeTZZeDQrZTQxU1NVYzAwL01BcnVyQ0NLbDJ2TW12TFp0Q3ovVUNm?=
 =?utf-8?B?L2RYaWkvYU1TTXpXRnN5TnErdk5QVTFMeS9zck1PZS9qcU5JVU9mT2lTRVdT?=
 =?utf-8?B?MjBac1RJZlhNUXR1dnVoNG1BSHhHcERTN3pBY3dpY2NhUDN6ZE9BYlVtbzg1?=
 =?utf-8?B?N1JJUE53YXRQancrUzlXWmk1bmNTWWh6bi9rQlo2NmFpWFhPS3Y5UzdsaXA3?=
 =?utf-8?B?ak1RT1o5Rm9GQmV5anE2Ny9lUmc0SXlzR2FaSStHOHplZGUxNGlDRVZDMTNW?=
 =?utf-8?B?VW0vS1duT2xReG5hcDMwbGk5WllxUFRLS1FkWDlTVkxBM1JUdExuMmlTaGFj?=
 =?utf-8?B?M29KcW9mRmJWclhySlJiY25uOUd2TnB3WFpNOHh4SEphbGhTUlY3b3ZQc1Fk?=
 =?utf-8?B?cmVkc0Z4MU1RMFY0ZGUxNnVGR05GeEszVGFoSnBKVUZmV3FwRWJZSzNTTG1U?=
 =?utf-8?B?aU40alA3T0tEN2JBOFZudmdKUHdDVUFwa0FGdDU1MkV2cVpGbklEN2RkM2Z0?=
 =?utf-8?B?M0Q3enBzc01lOEY1THdrNXgrRkVTcUh4Z2JHUTVYaTlySVBRZnVqaHV0NTc2?=
 =?utf-8?B?K2ljZWNQVkJSZ3cyVmlBNUszU1pwMVlIUTBpU2FLNCtiVTVNZklLVy91YWh5?=
 =?utf-8?B?YjFvVmNIMDI2NEtieVlEU1Y5WDg3NVJDVHBiS3RYQ29jalpaOTFCV0JxUjJp?=
 =?utf-8?B?M3FTODZRQ2RBMTROcWpqa0JsZWZ0QlpNd2FKcGJadjNWd1NWTXJHU1ZPN2kw?=
 =?utf-8?B?UjRMUUdXUXdmcWF2eWlKQk1zNzNFNW5GYW9aTGJJTVA4OXdPWFBhay8vcVNr?=
 =?utf-8?B?T0tiRlUrd1l2WGtBOTh3L05kTnVsam9BcTNxNFgrVWZ0SU5RQ2FuTzdBVlJY?=
 =?utf-8?B?dnVBeWVuYTBIM1hVcnk4RlY0THhLRDJqVlNaYTJWVC9mL1FucDkrNkVTUHdV?=
 =?utf-8?B?amUveGdWYlphRTd4WjBkZmZrTjlPSFkvWUdZbnVGRFp1Q0JTbTVRcTl1OHhO?=
 =?utf-8?B?dDQvMDJ3M1R5VDZIQ3MxbSs5MVA3ZUROVmplYkdkWkh4bndQTGZXbmQ1cGwx?=
 =?utf-8?B?aWwzSzZJdWxUQkRlM0NNOVNOV0MyL2lGc3RacDVnSTI4QjMvMmQzajd1ZWhi?=
 =?utf-8?B?czdjRzNlOFVwSkxSenNETGtMK1RvVGt4YklVNkQzLzBUT1ZjUTRKM2VueEI0?=
 =?utf-8?B?Q2RMT25vVmxPNytMK2RRVzNDUjdzdEZzSjNqVVZrVGRiOXBiNWxUS2p6UGlS?=
 =?utf-8?B?SjMxNXJjY3A3ODMvNHdYOEk4NzRVWFl2ZGE0RDZvTDBsdXpmTzNrT1hvV00v?=
 =?utf-8?B?UlVndFhvdXFvV0tVS2NabUpEWE8wb3pQK1JEYTEzSm5YQVJBMzFtVkxtM3hI?=
 =?utf-8?B?THptYVNNTTdNN3orTER0R09KR3QxWDVFODZuanFGTEVQUC9YTjVZeXZzNitT?=
 =?utf-8?B?aW92SEpjWU9sc3k1MnhJQ2NQVEFpRndyVC9SdGIzQlB3VllJR1lOQXJQN2tH?=
 =?utf-8?B?NHp6NFV1bUN3ZXN6RDBSTXRueEdnTzF1RkxUZTRWRFgwQjV6UEVOREZpQlc0?=
 =?utf-8?B?NnBaOGRqdEhuMWZpWU1aVktjREhCZHFRN2hRTnk5M0RuL2VrUXE4QnhCSGJ3?=
 =?utf-8?Q?7Klz+ADHHcL2IhQIv0AMLBXjV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfb0dd4-74b8-4a30-a08f-08dbe45af93c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 15:12:38.5094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2fofbuwV8N92jt6XpERYVZCXsB7FO59Ok8DMvQypzQFudhctNCtGv8NIuYx5mhW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8052
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

--------------CaAhPO3ocUrS06FsRIaXjWyH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2023-11-10 14:08, Yat Sin, David wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Zhu, James<James.Zhu@amd.com>
>> Sent: Friday, November 3, 2023 9:12 AM
>> To:amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix<Felix.Kuehling@amd.com>; Greathouse, Joseph
>> <Joseph.Greathouse@amd.com>; Yat Sin, David<David.YatSin@amd.com>; Zhu,
>> James<James.Zhu@amd.com>
>> Subject: [PATCH 22/24] drm/amdkfd: add pc sampling release when process
>> release
>>
>> Add pc sampling release when process release, it will force to stop all activate
>> sessions with this process.
>>
>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 26
>> ++++++++++++++++++++  drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |
>> 1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c     |  3 +++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> index 66670cdb813a..00d8d3f400a9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> @@ -274,6 +274,32 @@ static int kfd_pc_sample_destroy(struct
>> kfd_process_device *pdd, uint32_t trace_
>>        return 0;
>>   }
>>
>> +void kfd_pc_sample_release(struct kfd_process_device *pdd) {
>> +     struct pc_sampling_entry *pcs_entry;
>> +     struct idr *idp;
>> +     uint32_t id;
>> +
>> +     if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
>> +             pr_err("PC Sampling does not support sched_policy %i",
>> sched_policy);
>> +             return;
>> +     }
> You do not need to check the sched_policy here, already checked in kfd_ioctl_pc_sample(..) , so cannot have a hosttrap session if policy is NO_HWS.
[JZ]kfd_pc_sample_release is not called from kfd_ioctl_pc_sample. It is 
in process quit process.
>> +
>> +     /* force to release all PC sampling task for this process */
>> +     idp = &pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr;
>> +     mutex_lock(&pdd->dev->pcs_data.mutex);
>> +     idr_for_each_entry(idp, pcs_entry, id) {
>> +             if (pcs_entry->pdd != pdd)
>> +                     continue;
>> +             mutex_unlock(&pdd->dev->pcs_data.mutex);
> Can we not release the mutex here and just tell the worker thread to exit by setting the stop_enable bit.
> I find we have a lot of places where we are acquiring/releasing the mutex within loops and this results in a
> lot of extra states that we have to account for during the start/stop/destroy calls.
>> +             if (pcs_entry->enabled)
>> +                     kfd_pc_sample_stop(pdd, pcs_entry);
>> +             kfd_pc_sample_destroy(pdd, id, pcs_entry);
>> +             mutex_lock(&pdd->dev->pcs_data.mutex);
>> +     }
>> +     mutex_unlock(&pdd->dev->pcs_data.mutex);
>> +}
>> +
>>   int kfd_pc_sample(struct kfd_process_device *pdd,
>>                                        struct kfd_ioctl_pc_sample_args __user
>> *args)  { diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>> index cb93909e6bd3..4ea064fdaa98 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>> @@ -30,6 +30,7 @@
>>
>>   int kfd_pc_sample(struct kfd_process_device *pdd,
>>                                        struct kfd_ioctl_pc_sample_args __user
>> *args);
>> +void kfd_pc_sample_release(struct kfd_process_device *pdd);
>>   void kfd_pc_sample_handler(struct work_struct *work);
>>
>>   #endif /* KFD_PC_SAMPLING_H_ */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index d22d804f180d..54f3db7eaae2 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -43,6 +43,7 @@ struct mm_struct;
>>   #include "kfd_svm.h"
>>   #include "kfd_smi_events.h"
>>   #include "kfd_debug.h"
>> +#include "kfd_pc_sampling.h"
>>
>>   /*
>>    * List of struct kfd_process (field kfd_process).
>> @@ -1020,6 +1021,8 @@ static void kfd_process_destroy_pdds(struct
>> kfd_process *p)
>>                pr_debug("Releasing pdd (topology id %d) for process (pasid
>> 0x%x)\n",
>>                                pdd->dev->id, p->pasid);
>>
>> +             kfd_pc_sample_release(pdd);
>> +
>>                kfd_process_device_destroy_cwsr_dgpu(pdd);
>>                kfd_process_device_destroy_ib_mem(pdd);
>>
>> --
>> 2.25.1
--------------CaAhPO3ocUrS06FsRIaXjWyH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-11-10 14:08, Yat Sin, David
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB5021960306E3061166F20DE095AEA@DM6PR12MB5021.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">[AMD Official Use Only - General]

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Sent: Friday, November 3, 2023 9:12 AM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Greathouse, Joseph
<a class="moz-txt-link-rfc2396E" href="mailto:Joseph.Greathouse@amd.com">&lt;Joseph.Greathouse@amd.com&gt;</a>; Yat Sin, David <a class="moz-txt-link-rfc2396E" href="mailto:David.YatSin@amd.com">&lt;David.YatSin@amd.com&gt;</a>; Zhu,
James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Subject: [PATCH 22/24] drm/amdkfd: add pc sampling release when process
release

Add pc sampling release when process release, it will force to stop all activate
sessions with this process.

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 26
++++++++++++++++++++  drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |
1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c     |  3 +++
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 66670cdb813a..00d8d3f400a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -274,6 +274,32 @@ static int kfd_pc_sample_destroy(struct
kfd_process_device *pdd, uint32_t trace_
      return 0;
 }

+void kfd_pc_sample_release(struct kfd_process_device *pdd) {
+     struct pc_sampling_entry *pcs_entry;
+     struct idr *idp;
+     uint32_t id;
+
+     if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
+             pr_err(&quot;PC Sampling does not support sched_policy %i&quot;,
sched_policy);
+             return;
+     }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">You do not need to check the sched_policy here, already checked in kfd_ioctl_pc_sample(..) , so cannot have a hosttrap session if policy is NO_HWS.</pre>
    </blockquote>
    [JZ]<span style="white-space: pre-wrap">kfd_pc_sample_release is not called from </span><span style="white-space: pre-wrap">kfd_ioctl_pc_sample. It is in process quit process.</span>
    <blockquote type="cite" cite="mid:DM6PR12MB5021960306E3061166F20DE095AEA@DM6PR12MB5021.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+
+     /* force to release all PC sampling task for this process */
+     idp = &amp;pdd-&gt;dev-&gt;pcs_data.hosttrap_entry.base.pc_sampling_idr;
+     mutex_lock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);
+     idr_for_each_entry(idp, pcs_entry, id) {
+             if (pcs_entry-&gt;pdd != pdd)
+                     continue;
+             mutex_unlock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Can we not release the mutex here and just tell the worker thread to exit by setting the stop_enable bit.
I find we have a lot of places where we are acquiring/releasing the mutex within loops and this results in a
lot of extra states that we have to account for during the start/stop/destroy calls.
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+             if (pcs_entry-&gt;enabled)
+                     kfd_pc_sample_stop(pdd, pcs_entry);
+             kfd_pc_sample_destroy(pdd, id, pcs_entry);
+             mutex_lock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);
+     }
+     mutex_unlock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);
+}
+
 int kfd_pc_sample(struct kfd_process_device *pdd,
                                      struct kfd_ioctl_pc_sample_args __user
*args)  { diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
index cb93909e6bd3..4ea064fdaa98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
@@ -30,6 +30,7 @@

 int kfd_pc_sample(struct kfd_process_device *pdd,
                                      struct kfd_ioctl_pc_sample_args __user
*args);
+void kfd_pc_sample_release(struct kfd_process_device *pdd);
 void kfd_pc_sample_handler(struct work_struct *work);

 #endif /* KFD_PC_SAMPLING_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d22d804f180d..54f3db7eaae2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -43,6 +43,7 @@ struct mm_struct;
 #include &quot;kfd_svm.h&quot;
 #include &quot;kfd_smi_events.h&quot;
 #include &quot;kfd_debug.h&quot;
+#include &quot;kfd_pc_sampling.h&quot;

 /*
  * List of struct kfd_process (field kfd_process).
@@ -1020,6 +1021,8 @@ static void kfd_process_destroy_pdds(struct
kfd_process *p)
              pr_debug(&quot;Releasing pdd (topology id %d) for process (pasid
0x%x)\n&quot;,
                              pdd-&gt;dev-&gt;id, p-&gt;pasid);

+             kfd_pc_sample_release(pdd);
+
              kfd_process_device_destroy_cwsr_dgpu(pdd);
              kfd_process_device_destroy_ib_mem(pdd);

--
2.25.1
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------CaAhPO3ocUrS06FsRIaXjWyH--
