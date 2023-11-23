Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2BEC61D85
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 20:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BDA810E34D;
	Thu, 23 Nov 2023 20:25:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F3310E34D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 20:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkFQ61qojqu1X5tz8WVBLIoqLqrUM46MzELE2WSW+czjTmlGt1m8YHsmZ9dcrC+QXaJdxIJf6G8kMsrC7Qs66utRH2m2T5SOFYK4Htb7gceoEdxlOyGZwnL8ApEoLIm88uQbRAf6IY0E1WfbR4/HNnSlil1FVaJ6UvdKMdYtRPYBrH/Qm1bFXstDJusw/Rk8N4qpbSIW5MtSpHny8I1xBwoaKW0zP1lL4HkwqZ2W+e1OVtGM1Svn+AVFeoOhGSJMwV+nRqvfSE75tliqBBzZbOF5dLeR3A8Kbftz6jX/yRbsPhX0/akipcTitemSF0ZQ0w2BxRx3UoYoP7g6t0bthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzOQMty5aRhfgsp57wiok1woGm6AeLzFTyy+1I6fRa8=;
 b=MBT6PW53iDVHBHFdL8mzfjpmVmAx6uJSBIoOjv8KaRnvO4Nsbayn0D/hH1tiRNhBKP+FupEjrUVl7jL6qtBYmiDB1VWnF3fRoGaOKJbD4p0pZlg2zY0S3uyPhCGeGkpegpbFu85/YirdXIh/XYLRW2zeDfiwvaQXGN/e1IoiJtcv5KapM5EyGMvSgTTNerT+hcZYgCVbuahj5HqJuA0TNN8+pGB2KJq5+4b5FTUE53rCDYQObqxzhmyfTHucmIodf4rCxFbBzptDlxMWZkBEibHOWN7C69EkQ7iEIB2dN0b1XmfLRyKBdUwrBTbgsn4vTXYYejoihy5wvihOwpADiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzOQMty5aRhfgsp57wiok1woGm6AeLzFTyy+1I6fRa8=;
 b=ERVYjCK0UhiTcwYBd6rbWMqQb7+rFb6I23p7xE9WakABpI8dWHJNan7q/Gs3kWSpp6vOm+BqBzm1UuJs+WM907OoUCmhKaJgdlYbhKsznKuROz46qKbRtyYkvh020KXriF2mWE0ujge/SwwpofIgEYM9jxgl2vabIoY3SoDNWEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 20:25:41 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 20:25:41 +0000
Message-ID: <c7727010-e81d-4ffa-9dfc-fb25a66b5c94@amd.com>
Date: Thu, 23 Nov 2023 15:25:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] drm/amdkfd: enable pc sampling create
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-6-James.Zhu@amd.com>
 <eb54d698-39d1-4111-a312-2d5c7221ecba@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <eb54d698-39d1-4111-a312-2d5c7221ecba@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::41) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: f7caebb8-b8ae-4e9a-73d0-08dbec625c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBebDGukrZVIYAHQQFqpSkUxjatnFsFnBYDKv6iLz4qWNTTAGCO9efx6P6HLcN6P1aHfignUolnIOTYJPJrzvx6HodxnsIS/h2ms5O4GSVpnT8yL5iMb/FIRMVKqq90/FsMp6MRCOkue16UOoq6R2Klmjw1YGgfXFxXS6mOULLnx2auLAA162d0d8QA++P6HLQUa2UTEQ56M8WWnMG3Ez80pcPsRnJAKRVhrYCRKlXqcNigmX0u9V7J++EBgjh3TbaEyB3HJq5KaV8J1y2cGPXAtIoBFUB3bb5yu405qZmNAlZSsfCS42rboGywJsgIBirRgHEdV+Di3nV+rrxpRDVmo5tTUE/VuX3y0NWDDc5RKW2nl/DgZESi6u7jgsx23J7x3DXlMNJEYV0WSIo5lOZljBDIxKQ4urj4AqALopNTBCz38CnO1JbjAkErFdMq50iMb8kc4rzUCek3O1KemPmh6wkXkGAk0OZ52PL8nUIEFLlxbbuKK2/vGZXQHdiNCCaZEjxwbjdvWjUD9mJDlyYDQwshNUiNK1pBwz4iLztG9+xN4IUxACYDGEVII+fTipWv+AjqkwHU+LmKb4PMslFFqKqzHGb/hQBO/W/47e40ZaYAmBl3GKVNRpOheMeiueB+Thw4slD3FeGBTArzpeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(8676002)(8936002)(4326008)(31696002)(53546011)(6506007)(36916002)(6486002)(66946007)(110136005)(66556008)(66476007)(31686004)(36756003)(316002)(38100700002)(2906002)(41300700001)(4001150100001)(83380400001)(26005)(2616005)(478600001)(6512007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1UrN1VUV3ZDVUV2dFladXRYOFJtVWpSZ3FhbUxBeW1JNytBamt0Q3FaQkZI?=
 =?utf-8?B?dW1scC8vNER6Y1ZBWCtITzRDaFU4OFVkRmtJcGliV1dYVU9UanVoeTdxOWlr?=
 =?utf-8?B?MXQxR2o2d2l2NTc1WmJyR25aMm5Bc3ZyMHNreDRZVWZDTVUwRGNWOWtxU1M0?=
 =?utf-8?B?SjZncTdxcXRiUFh2bVE4ekYrVkJ3TWx1SGZGRzJNR0lobTdIUmFnZURsNXQr?=
 =?utf-8?B?Ulg4OFhQNVdrVXRFTVZmcjNoZG5IdEVaalQ0Y2dEK2pNaXJKbnJwbU9mK3NP?=
 =?utf-8?B?M09XazJDWjhIb1ZnL2pFbVdVZWZZektldjJEcEY5bnp5cElGRDZvQlEzV1k3?=
 =?utf-8?B?VEJzRkp3dWNLUzFIM1VzRkFVTXU1SnI0R3BTTzIraUJVYW5ia09EZVh4Tmdi?=
 =?utf-8?B?Ym9Cb3JCWFA2TkMyY292eVgzREtuQjJ6aUpoQkVVVEZrQk56eTdRdkkrU1Nt?=
 =?utf-8?B?dEEyTHY0ZmxDaDdra3FqNHpOd1o1dER4NGZpZzdMdmFyb3p5czhIb1pXNm90?=
 =?utf-8?B?WUl2dHVDUGpFM0IvMkV5S3ZGRS91bU03UHhsZlYwdzJ2R1RNWU5scXJock9i?=
 =?utf-8?B?OHdRNmRiR3BTcXBHdk94ZW5VUFZ0QmcrYm1qNlh1akdTMnc2RGZyS2cxanJz?=
 =?utf-8?B?N0ZrdDU2TktzUHYwWDVNWEFyVk50UG8yYkJNRURXMUF6KythcjZzVTZtOUZQ?=
 =?utf-8?B?T25tSE5kd0JtZW56alEvbVJDbFFSQWJ4cW9DdlhjWHlxY21xWFF2Z29ncWFo?=
 =?utf-8?B?TFRTTWdZT09JTGM3amd4OGVpMXdpbUFzQmdvK1pDNTUzL0xvMkZkM3hHSjNj?=
 =?utf-8?B?YzZLczhLWjFKdDFNUHJ4Vi8wdVFGZ2I2aFN6WFpuRmZxUjZjTXk1bnpmWVVs?=
 =?utf-8?B?VE5QVzM1a09FdVZUQyt0OFE3Y0IrUyttNE8xaXRYR0hvdkp3cmtkakZSTXB4?=
 =?utf-8?B?NzNpbVZoTGlqVjdxZE1mY3ZuZDNiblJmNkJGWTVJdHhJdEJod3NHTmhqUWtm?=
 =?utf-8?B?WTZpZkZxTnBZVmJDVlU4SllFRE55NmpVK3ZTUlVqbk91cG1rNldkUXZNMVk2?=
 =?utf-8?B?NGFtSG9aNnY3M3ZHdTVHWnlOYnpZTzgxbFcrUTNXTmVRTGViSFJ2MlV5a2hr?=
 =?utf-8?B?QTU3aVpJS0tKWHRFWm5maHFqQjNwY2g5L2ZZZU8vcThHM2pabDJYdXl1c0JN?=
 =?utf-8?B?bE1qVWgrNWxsekpMSlpsZVpJM294ZjdCc3NiczJ1Y21UaVEwc294ZHFveDZ6?=
 =?utf-8?B?dWFoOHJUVG1uRHNIUHZReS9pcEwybjRhRlloNnB4cTVMaXkwY1VYN1dTUnVZ?=
 =?utf-8?B?ZHNCT1B1dmYxQzgrWmY3WHMweTZTdkMwM01ULzV1NHVRZm00Nnp6REFEdVJ2?=
 =?utf-8?B?bXVhSUxCUDFNM1RBc2tVcGVsUFpKbmZuZDFDNjF5TXA4ak1XMTJhd2ZYZ3FP?=
 =?utf-8?B?Skd0bVhQbm9aTnZGbTg4aXpyMXlGSTMyMTFYaWZqRWFpNTlPbDFBdExNSlhX?=
 =?utf-8?B?RmtabEF1dDFmcW9CVWh6LzU5RnFGK2dEZEdVR1ppMmlLcE1yYXRNMG1GTURp?=
 =?utf-8?B?U21NMkF0UHUrV2lRMUxrNUN6NkMwTDR5K2xsWTJiK1NrbDhHalUwS2QrS0pW?=
 =?utf-8?B?RmZMRGl0T1RFWlIyMzVWSjdDd0xSRW1zaG1qblUxd0Naa3FYWWQ5cWgzSjZI?=
 =?utf-8?B?Y09nZmFEaHRKcjhqb3lpRlg0UnpRSG1WOEFMMjNoODVkSlRqYjdVRGpheHNH?=
 =?utf-8?B?Zmk1cTBpQm1JbzVKakNEdHhGTTFJM2N0ZlN1bGxQY0FqSEtyTlMyVExaaUxy?=
 =?utf-8?B?dUF6QTRQYzRVNUJQdllwK3E1dUYzdW5EU2tTUWJsREN3UjdGbkxUWW04bXdm?=
 =?utf-8?B?cEVwYTZGN01PUkZGVzZ1dGphTlB4SzI1MVlqTnZuN2dpRTdmdVo3NHZXTU5G?=
 =?utf-8?B?US9Rdm1SVEE4R3l3dzRIanhURmNYOVFoazNXMzBEblVtbWkwRGNZRHNEV0py?=
 =?utf-8?B?M0IrODBGK1hIUGVUZVNxeHEvWnlNL3NZRjNQaWpYNUxUUDRoRDdHbk9PRFpN?=
 =?utf-8?B?OXZ0cVJrbGxjQWw0RXdWZTdqQ1lRYzZHU05MakVSbnhEcDdrU2JYMnBWclFT?=
 =?utf-8?Q?EIL8cWqGsu6dtZ8vXpWunQgD4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7caebb8-b8ae-4e9a-73d0-08dbec625c98
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 20:25:40.9201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p40v2xbQzxwAwGBV+4c0yo4kH93u6d6xJNXuxxDFrUjCAv79iwlZfEIQSY0m3lQM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
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
Cc: joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-22 16:51, Felix Kuehling wrote:
>
> On 2023-11-03 09:11, James Zhu wrote:
>> From: David Yat Sin <david.yatsin@amd.com>
>>
>> Enable pc sampling create.
>>
>> Co-developed-by: James Zhu <James.Zhu@amd.com>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 54 +++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h        | 10 ++++
>>   2 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> index 49fecbc7013e..f0d910ee730c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>> @@ -97,7 +97,59 @@ static int kfd_pc_sample_stop(struct 
>> kfd_process_device *pdd)
>>   static int kfd_pc_sample_create(struct kfd_process_device *pdd,
>>                       struct kfd_ioctl_pc_sample_args __user *user_args)
>>   {
>> -    return -EINVAL;
>> +    struct kfd_pc_sample_info *supported_format = NULL;
>> +    struct kfd_pc_sample_info user_info;
>> +    int ret;
>> +    int i;
>> +
>> +    if (user_args->num_sample_info != 1)
>> +        return -EINVAL;
>> +
>> +    ret = copy_from_user(&user_info, (void __user *) 
>> user_args->sample_info_ptr,
>> +                sizeof(struct kfd_pc_sample_info));
>> +    if (ret) {
>> +        pr_debug("Failed to copy PC sampling info from user\n");
>> +        return -EFAULT;
>> +    }
>> +
>> +    for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
>> +        if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version
>> +            && user_info.method == 
>> supported_formats[i].sample_info->method
>> +            && user_info.type == supported_formats[i].sample_info->type
>> +            && user_info.value <= 
>> supported_formats[i].sample_info->value_max
>> +            && user_info.value >= 
>> supported_formats[i].sample_info->value_min) {
>> +            supported_format =
>> +                (struct kfd_pc_sample_info 
>> *)supported_formats[i].sample_info;
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (!supported_format) {
>> +        pr_debug("Sampling format is not supported!");
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    mutex_lock(&pdd->dev->pcs_data.mutex);
>> +    if (pdd->dev->pcs_data.hosttrap_entry.base.use_count &&
>> + memcmp(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
>> +                &user_info, sizeof(user_info))) {
>
> I think you can compare structures in C. This would be more readable:
>
>     if (pdd->dev->pcs_data.hosttrap_entry.base.use_count &&
> pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info != user_info) {
>         ...
>     }
> [JZ[ Sure
>
>> +        ret = copy_to_user((void __user *) user_args->sample_info_ptr,
>> + &pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
>> +            sizeof(struct kfd_pc_sample_info));
>> +        mutex_unlock(&pdd->dev->pcs_data.mutex);
>> +        return ret ? ret : -EEXIST;
>
> When copy_to_user fails, it returns the number of bytes not copied. 
> That's not a useful return value here. This should be
>
>         return ret ? -EFAULT : -EEXIST;
>
> Also -EBUSY may be more appropriate than -EEXIST.
[JZ[ Sure
>
>
>> +    }
>> +
>> +    /* TODO: add trace_id return */
>> +
>> +    if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
>> + memcpy(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
>> +                &user_info, sizeof(user_info));
>
> I think you can assign structures in C. Just do
>
> pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info = user_info;
> [JZ[ Sure
> Regards,
>   Felix
>
>
>> +
>> +    pdd->dev->pcs_data.hosttrap_entry.base.use_count++;
>> +    mutex_unlock(&pdd->dev->pcs_data.mutex);
>> +
>> +    return 0;
>>   }
>>     static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, 
>> uint32_t trace_id)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 4a0b66189c67..81c925fb2952 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -256,9 +256,19 @@ struct kfd_vmid_info {
>>     struct kfd_dev;
>>   +struct kfd_dev_pc_sampling_data {
>> +    uint32_t use_count;         /* Num of PC sampling sessions */
>> +    struct kfd_pc_sample_info pc_sample_info;
>> +};
>> +
>> +struct kfd_dev_pcs_hosttrap {
>> +    struct kfd_dev_pc_sampling_data base;
>> +};
>> +
>>   /* Per device PC Sampling data */
>>   struct kfd_dev_pc_sampling {
>>       struct mutex mutex;
>> +    struct kfd_dev_pcs_hosttrap hosttrap_entry;
>>   };
>>     struct kfd_node {
