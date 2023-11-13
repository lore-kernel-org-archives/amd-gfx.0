Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DADC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 15:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB98710E3A6;
	Mon, 13 Nov 2023 15:19:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6035A10E3A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 15:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYmlKLTJ8RJ+ZsAZtBcq09ZYMmzlPawF3Y9hlMPZPzfGrwFgJFZdnGNLcjKUFhEs3Gwe4lNWFIm5EHDLZ65U8/39pclOMzTN2yDWe36LJVz01V5ZC18Oiyux4/Qto6nz35xax6rYpRP0i8OrTDLAXirnwsa9xNf3aeCEog8KdQaQY96HvMeYDelVjgTOErq5rOB4ruVlZrteFFeo+uuhHV580KWMdE7OUuEE83rBMV9UvUokQJqyVRvIHmMVh9dMvRJ4ztlqJkF9SWmgzssCy0ZbDmDWf4idDtbnB4FLB8wKYsB7lOirKETMoLzsRlAlH0tII12FDoZ5OPbS17GeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhqMMy/EJMJAN/qXIVL3myPiOV62wXIv1n+7pnqpV/A=;
 b=agGswTdmc5P7XCN6pYrHd30weCiCxjlo7pfaD9ujDguzijGz7ZCjhXXtymFHlKvfOh6+mXI0D6pRDrdjTbGZdslHwEatVrOMvcANt3uHQwxVOJnL2V1hK0451qoiTLnTTsrZVg1wP5i14wWqHQhPf6Mfw0hbtqaIzJG5Evj4fqNizqXDje6Jj4Lb5aJSkoTpfjIfBvX8vVR1u/rToMhTB66AojraTL34oOmsfVFmSEleh8h4UcQPAx3q5rIUYj1vzixhxxi6WICOqc66uHgthkUh8oavk5OqyhsaRt6nHt3FLk84tbrvRlqljETrcncmEk6fsgvyybalFSEOBxRdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhqMMy/EJMJAN/qXIVL3myPiOV62wXIv1n+7pnqpV/A=;
 b=Ayt4usBDTXmD+BnVDxzdPxCASF1sSkyrO/JcEF4Vp/W3BN/lYa1iEE3VDTHPQw4kPb1VRraxI0oFre1wJW2SOmQCarxyJefOJ+gNcV8Zw6obkzOHelThILS4nHLc6gLP1ODtPdk5QmWExPJHkjqqc1fHuM+TsIRJ7PxjqQEvwrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 15:19:39 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 15:19:39 +0000
Content-Type: multipart/alternative;
 boundary="------------yhaJ6H6zeJjley7TxG0PdONm"
Message-ID: <29c443f9-455b-481e-a2ae-f1315e447867@amd.com>
Date: Mon, 13 Nov 2023 10:19:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] drm/amdkfd: enable pc sampling stop
Content-Language: en-US
To: "Yat Sin, David" <David.YatSin@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-20-James.Zhu@amd.com>
 <DM6PR12MB50211E7128EDF3D5D6067B9295AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <DM6PR12MB50211E7128EDF3D5D6067B9295AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::22) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e65ab28-3ba9-48ca-db22-08dbe45bf447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/e+rmBEb9vYJ+xhw5bThqgmZQKfKWMF/7NiU8iD9PMcUKYQZWz3anuy5xR1lt3X2m6eDsZZXQXQibdtTiJ2dA9c4M4AbHcMfKM2QkvKVzVO6H+e4JsGk+XlTYFxqfK+BAHLHPLrQHsDYBg78qdw9XLPLeuxDqNUjeRWx4ZWJPaZ5bMtRe1GCOzU/FmSXJbAKBhPi9k3n58e7oa9YbO1ZOdtiiOePuL2d2Nw2GzCdifjwmrxh1bQnUcj1BnmJ6NQfAOJ+bdpd3iiX/2LywLu7bTjTgdYYNYe5mFGzrYNV0lAScSIL8ZUH+sab1fg/kXIj5VsiNQ6slOrhB5nogG6vSfDGiPxB2+cQqwTV7K1U6AnzbBVHc/MTdDrD/4/rCGLCTLaYruXQQHoNvvigijGtqoarEh1tZD3mDhPLNIMwMHNiPpETYsjn7ljS6/OAz670CsT6MruHUzvXC1S8FI8/34XeAKh3WoriMMJIufMdlGWXBE/rvb2ONuPTLhq85t1qobYoovrJxm5kg7yEad++ZrHdQAieef4Tv6x+s35BcwaHbrIXYjttJiMk5k8bdVh1anGnRSUV9pOaQNRBC1aHA1gEkAt3aaoKUzWb1Exixf0IcbYJQqEcDUEFvjSMlgG73pirD2SYyJxsFEa8WrDmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(2616005)(53546011)(6506007)(33964004)(6666004)(36916002)(6512007)(83380400001)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(4001150100001)(6486002)(478600001)(316002)(110136005)(54906003)(66476007)(66556008)(66946007)(36756003)(31696002)(38100700002)(31686004)(66899024)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmJyZi83Z3EwZHBMcXhkaE11UjZvSnFQYnR5SXFJcEpESHhDb0M0a0R5M2Y2?=
 =?utf-8?B?U3JGbHRKSXRkbWxmWHNpMWdmMDlsTHBCSDI3ZWxxODVadWFkc2dta1U1Qkw0?=
 =?utf-8?B?cFZyTzBHVjNLNkdCUzJJQitUbEZWZzc4SVE1SC93ejZrb0o0akxQaElWazQ2?=
 =?utf-8?B?VzV4OFU0T3ZPdUt1WVhnajlPS2Q2aDBaTi9RZ2o1cTkzRmpYNjkzTVlXNmlR?=
 =?utf-8?B?TWYrZVYxV25Vbys4OCtZUW44RzQyLzZmWEw0NEtkZ1lGc0NMZUw0bVBOYi9u?=
 =?utf-8?B?MkswSUUrdkE4K3dmRGFsdVlNdWJPMWlIVjFuY0FNcjlIL3BwcUkrVVdDTUY5?=
 =?utf-8?B?TVU2c0VsdFYvdkVqd3hreTNQMEVJMHRWdThjWkdRZzJObkJzYkNpV1VHWE80?=
 =?utf-8?B?amI3WnpUZ1k3UEtadnlkMU5iSnRqU3IwVkdrTGRFOHFWMzlwT0o1V1NQYVB5?=
 =?utf-8?B?TzgvMWhHQktpeWFKODdoL05EMGFkK3N2U0xyRzRicVRISDJKUjgyVTM4b2NV?=
 =?utf-8?B?djArYXJvRFM1Q2lJZjBrOG9SdGFXdXZCQ3gxQVZzbTVpTDcwL1hFbkJ4K1ZD?=
 =?utf-8?B?QWhoVElFZjRPbE4zWVhyYnkzejdnY2lmQ0VJMzNhS2tZQlRkTnVHY1ovUFRR?=
 =?utf-8?B?Uk0yWjFZdDdMZmtGMy9UWFVLcVJiQnJPSEZ6SWRYS1pqMy8zN3BkMDQrMVdo?=
 =?utf-8?B?TWdTRGZ2U2tyUVhsdDRuTlowWUw5MjNyaFBDdFI4UEQ2dkhIR0pIVWI0VFZQ?=
 =?utf-8?B?NEhMWTJxRGRsMHVZQjg5NHJUclpmVkhtUjdqcHlEZ1gwa1pJNVNuWWllTmlE?=
 =?utf-8?B?aHlNbDdncXphamNZOUQ5d0UvdTN0QjlvRFAwSE5NN0RDbTg1ZU01OGwrZDht?=
 =?utf-8?B?R3lwZjRXcyswZldJY1paeWFtdFlmOVJEeURHZkZ3WGtiekdIRGE0MUU0VUdS?=
 =?utf-8?B?MmErYjMyNFQrKzIxRlBJS0psbCtGTWc5STRnVGtHT2dMbUFxUm5XK1o5S0h4?=
 =?utf-8?B?TXlYUVhuRnJSaXE0VVlqNXRGZzBhRi9FYUtMemlFclBnYWRUSkNJM0ttb3E1?=
 =?utf-8?B?TzgxNEtRSUhkV2RuZU04UVN0VndIV3YvZGxQNVFhNXdyMHN3Y3JQNWt2OURP?=
 =?utf-8?B?NVk5S0VpMkhnQ2pIWm5uaDNzc0ZPbnBsRGZOWVV0R1pBVFdpUVR5cDZQK2Nt?=
 =?utf-8?B?Vks3elFycTkzTmZhdkNRcVBtK2M3YWxsZThzZGZBaVUzTFdlTWxaTG1Ialk3?=
 =?utf-8?B?V2V0aFVEdlpsNlRzNDAzM0FIZ0pzOWZQeklYcWMrQWhKRmEwS0FPdEd4T09X?=
 =?utf-8?B?TGdRM2dFZ0lLdEtiTWZVUG4rK3JMWnUwTElOSkdzZU94RTB3cVJUY210bU4y?=
 =?utf-8?B?S0c4TTgvdFpSMk5ZTDdBUU94amxyUU1QU1lFbW9EeWk0N2gzeDRsdUYySFZh?=
 =?utf-8?B?SmNOWGNQRGVSbmdWck0zZ1VsM29kVFFkTVNrVlgxWktPRXRuUEk4MWVTOVE4?=
 =?utf-8?B?N052MXNGeWZ5RlA4blBsYXlSWk12djM2bzZpcG1HVnpFajdvdU9RTXNjMWY3?=
 =?utf-8?B?ZkwrTEdMclYxaHNXWkhpQ1IyVGxUYnJ3cFhtVEppMkdDZFZDS3lNWndCZnpW?=
 =?utf-8?B?ZE9oNjBVMXVUVG0zK0I2Q0hJN0t3TXAxc05wNEJTQjdXN3lidm91cndqaktD?=
 =?utf-8?B?N281RzMwU05jd21pVVRiSjU2S3Uzd2JySStVbnB0SWtHd2xTM0RqZjgrWjdt?=
 =?utf-8?B?bWVJSDJpUmsxelovbGpmdkpJaExKb2sveExraVJCNmlOSGZBYys4MnliSk5z?=
 =?utf-8?B?TUpQOHo0REM0b2s5Z2xRWHNjSUpmeGcrMkFUOVRYdXdaSWMwQlg2U1dIOVY0?=
 =?utf-8?B?TEh0d2VLZmNtSmVHemEwNkFuREowRG1JdmRhaTBmaE1TV1BoWm1UVlowYXlF?=
 =?utf-8?B?SmhkVFhsblNhU0Jjd0E4VmZUUDM4c3M4SzlOdWFWSGoxU2RXWjFqT212aWVx?=
 =?utf-8?B?OXVTdVp5dkxDWENWdFpNU1N6VFBGNTZhbVIrY0E2MnNmbk9lWGlMN3ROVVox?=
 =?utf-8?B?dG5PWDRSZU80MndDclBEKzhzL2VCSXFlNmpobUx5R3lBeWN5S21CeVJ0d1Ny?=
 =?utf-8?Q?jqjOrU6wuAgyn4tMVNCoHIbbA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e65ab28-3ba9-48ca-db22-08dbe45bf447
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 15:19:39.6504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUZXzqTCku1YSGNBk9pf7qprSmIZk4saRIttX71cS3q+AOZuB7HLI5aHCge7itYP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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

--------------yhaJ6H6zeJjley7TxG0PdONm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2023-11-10 14:07, Yat Sin, David wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Zhu, James<James.Zhu@amd.com>
>> Sent: Friday, November 3, 2023 9:12 AM
>> To:amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix<Felix.Kuehling@amd.com>; Greathouse, Joseph
>> <Joseph.Greathouse@amd.com>; Yat Sin, David<David.YatSin@amd.com>; Zhu,
>> James<James.Zhu@amd.com>
>> Subject: [PATCH 19/24] drm/amdkfd: enable pc sampling stop
>>
>> Enable pc sampling stop.
>>
>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 28 +++++++++++++++++--
>> -
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  2 ++
>>   2 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> index 33d003ca0093..2c4ac5b4cc4b 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> @@ -108,10 +108,32 @@ static int kfd_pc_sample_start(struct
>> kfd_process_device *pdd,
>>        return 0;
>>   }
>>
>> -static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
>> +static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
>> +                                     struct pc_sampling_entry *pcs_entry)
>>   {
>> -     return -EINVAL;
>> +     bool pc_sampling_stop = false;
>> +
>> +     pcs_entry->enabled = false;
>> +     mutex_lock(&pdd->dev->pcs_data.mutex);
> For the START/STOP/DESTROY ioctls, I think we can hold pdd->dev->pcs_data.mutex through the whole IOCTL. Then we would not have to deal with the intermediate states where the START/STOP/DESTROY are happening at the same time.
[JZ] pdd->dev->pcs_data.mutex is per device, not per process. In the 
future, also it will share protection within different pc sampling 
methods on the same devices. So I don't think a bigger lock here is good 
idea.
>
>> +     pdd->dev->pcs_data.hosttrap_entry.base.active_count--;
>> +     if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count) {
>> +             WRITE_ONCE(pdd->dev-
>>> pcs_data.hosttrap_entry.base.stop_enable, true);
>> +             pc_sampling_stop = true;
>> +     }
>> +     mutex_unlock(&pdd->dev->pcs_data.mutex);
>>
>> +     if (pc_sampling_stop) {
>> +             kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>> +                     pdd->dev-
>>> pcs_data.hosttrap_entry.base.pc_sample_info.method,
>> +false);
>> +
>> +             mutex_lock(&pdd->dev->pcs_data.mutex);
>> +             pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
>> +             pdd->dev->pcs_data.hosttrap_entry.base.target_wave_slot = 0;
>> +             WRITE_ONCE(pdd->dev-
>>> pcs_data.hosttrap_entry.base.stop_enable, false);
>> +             mutex_unlock(&pdd->dev->pcs_data.mutex);
>> +     }
>> +
>> +     return 0;
>>   }
>>
>>   static int kfd_pc_sample_create(struct kfd_process_device *pdd, @@ -251,7
>> +273,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
>>                if (!pcs_entry->enabled)
>>                        return -EALREADY;
>>                else
>> -                     return kfd_pc_sample_stop(pdd);
>> +                     return kfd_pc_sample_stop(pdd, pcs_entry);
>>        }
>>
>>        return -EINVAL;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 613910e0d440..badaa4d68cc4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -259,6 +259,8 @@ struct kfd_dev;
>>   struct kfd_dev_pc_sampling_data {
>>        uint32_t use_count;         /* Num of PC sampling sessions */
>>        uint32_t active_count;      /* Num of active sessions */
>> +     uint32_t target_simd;       /* target simd for trap */
>> +     uint32_t target_wave_slot;  /* target wave slot for trap */
>>        bool stop_enable;           /* pc sampling stop in process */
>>        struct idr pc_sampling_idr;
>>        struct kfd_pc_sample_info pc_sample_info;
>> --
>> 2.25.1
--------------yhaJ6H6zeJjley7TxG0PdONm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-11-10 14:07, Yat Sin, David
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB50211E7128EDF3D5D6067B9295AEA@DM6PR12MB5021.namprd12.prod.outlook.com">
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
Subject: [PATCH 19/24] drm/amdkfd: enable pc sampling stop

Enable pc sampling stop.

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 28 +++++++++++++++++--
-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  2 ++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 33d003ca0093..2c4ac5b4cc4b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -108,10 +108,32 @@ static int kfd_pc_sample_start(struct
kfd_process_device *pdd,
      return 0;
 }

-static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
+static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
+                                     struct pc_sampling_entry *pcs_entry)
 {
-     return -EINVAL;
+     bool pc_sampling_stop = false;
+
+     pcs_entry-&gt;enabled = false;
+     mutex_lock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">For the START/STOP/DESTROY ioctls, I think we can hold pdd-&gt;dev-&gt;pcs_data.mutex through the whole IOCTL. Then we would not have to deal with the intermediate states where the START/STOP/DESTROY are happening at the same time.</pre>
    </blockquote>
    [JZ] <span style="white-space: pre-wrap">pdd-&gt;dev-&gt;pcs_data.mutex</span>
    is per device, not per process. In the future, also it will share
    protection within different pc sampling methods on the same devices.
    So I don't think a bigger lock here is good idea.<br>
    <blockquote type="cite" cite="mid:DM6PR12MB50211E7128EDF3D5D6067B9295AEA@DM6PR12MB5021.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+     pdd-&gt;dev-&gt;pcs_data.hosttrap_entry.base.active_count--;
+     if (!pdd-&gt;dev-&gt;pcs_data.hosttrap_entry.base.active_count) {
+             WRITE_ONCE(pdd-&gt;dev-
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">pcs_data.hosttrap_entry.base.stop_enable, true);
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">+             pc_sampling_stop = true;
+     }
+     mutex_unlock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);

+     if (pc_sampling_stop) {
+             kfd_process_set_trap_pc_sampling_flag(&amp;pdd-&gt;qpd,
+                     pdd-&gt;dev-
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">pcs_data.hosttrap_entry.base.pc_sample_info.method,
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">+false);
+
+             mutex_lock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);
+             pdd-&gt;dev-&gt;pcs_data.hosttrap_entry.base.target_simd = 0;
+             pdd-&gt;dev-&gt;pcs_data.hosttrap_entry.base.target_wave_slot = 0;
+             WRITE_ONCE(pdd-&gt;dev-
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">pcs_data.hosttrap_entry.base.stop_enable, false);
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">+             mutex_unlock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);
+     }
+
+     return 0;
 }

 static int kfd_pc_sample_create(struct kfd_process_device *pdd, @@ -251,7
+273,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
              if (!pcs_entry-&gt;enabled)
                      return -EALREADY;
              else
-                     return kfd_pc_sample_stop(pdd);
+                     return kfd_pc_sample_stop(pdd, pcs_entry);
      }

      return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 613910e0d440..badaa4d68cc4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -259,6 +259,8 @@ struct kfd_dev;
 struct kfd_dev_pc_sampling_data {
      uint32_t use_count;         /* Num of PC sampling sessions */
      uint32_t active_count;      /* Num of active sessions */
+     uint32_t target_simd;       /* target simd for trap */
+     uint32_t target_wave_slot;  /* target wave slot for trap */
      bool stop_enable;           /* pc sampling stop in process */
      struct idr pc_sampling_idr;
      struct kfd_pc_sample_info pc_sample_info;
--
2.25.1
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------yhaJ6H6zeJjley7TxG0PdONm--
