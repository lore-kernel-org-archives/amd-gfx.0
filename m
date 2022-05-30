Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2C8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 15:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01B910F2C6;
	Mon, 30 May 2022 15:46:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB0EB10F2C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 15:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2MuWMWp2BLdPVbGwe4axbA+wrPqKApm5TVoH5PeuH2SqMpp1HaEEvOyY+Q4s1qmYoI6nHt1Xl9wuzn/I0GFDdOXKKK3jaW7vHJX81vxDZlH4Hss6EhKRyV6rd2bFXRQ6PNwCIj2KWFbhlVQtu4kwj6R/uZUsA66zFfC+PmGC7raZJ1akhmLH0cfIHSx76sdt05c1xSx9TVN6KBwJXsnaGqB+yLPQyjsiUEgK0IYDBapi8bE8Ua12yGtAiyxO22GrNBxIw+0YgwJtC4T5QyXR6I9mlm5k7tKhQ+/yUUdDQJ7Riq+iJQYMPHSTt0y5VXtXEaM7bqpKab43xSoyenNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4Gf2emNYGsE/xOq5ZzVu4wT+fF802wiiIc9JvlqysU=;
 b=IyJxv0evfDoacffBguKMA1kTSmFv4WdnfJMQHI3PqTGIzwYJNI/Cb6hOaRykO/zzAFji3qQtfumTibwdqLl1EccGSofZ3vCSlK/xIfAfTuW4RfeI5qW/ahil+yhNg9fQvFtgOn7a7l+T8AeRWj9fqyH5iDJH0KrYy2euTpagAMqx5OU6lAsVL5M17ASBiTOPrpbe9yjmU3w4L5PZn/Y/Mho5isJBscCzVEL0eSAsBRKdzgIHBF+zhOyx1d8z5Zy18u0nMVpfaW813XswMbesd3iOjuAiWdwxRlL+2AKEjIkFgS+J/mjoSTAJTkkDJW6EHv4yqXsaePC8XZW/bf2ixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4Gf2emNYGsE/xOq5ZzVu4wT+fF802wiiIc9JvlqysU=;
 b=Wds2BG9WfgB//+dljziP9yDO8UMJa29ji6+OOteG4NEqGnAkzLV+tvwwcNZ3SbvnRKudGT26xtNXiIx8Cca9RKws2aJFr/RHWtujc6eNoCxx5vjJnNrrjRuPrEQfxYpbIMBdF3PKo98FhtSGDgKJoVVULOvY7jM1vTbHLCzvBVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 15:46:15 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40%11]) with mapi id 15.20.5293.019; Mon, 30 May
 2022 15:46:12 +0000
Message-ID: <fc638286-6666-c70f-c797-c30dd39fc7a6@amd.com>
Date: Mon, 30 May 2022 11:46:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 4/7] drm/amdgpu: Add work_struct for GPU reset from
 debugfs
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, "Liu, Monk" <Monk.Liu@amd.com>
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
 <20220525190447.239867-5-andrey.grodzovsky@amd.com>
 <8b065c7b-d5ff-6742-94ed-997aadc7adca@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <8b065c7b-d5ff-6742-94ed-997aadc7adca@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29)
 To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92c40795-7656-48bb-d2cd-08da425385cc
X-MS-TrafficTypeDiagnostic: CH2PR12MB4039:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4039E79D0AAFAB6F2094E299EADD9@CH2PR12MB4039.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7nF/SrnJ0q6ao6f+E/sptokv+XqtDs8sl8EwA/qtyiQtWO0/tzROCjP5Fo9DYMgOLpPQmfZTBno9uP7FwuD5Q/8PGSNqCSAzpEgbkjjjgOhnvEHOdPMc7LX0wu++qCuuc7FoBYB/AYatZZHgjcQjoGWciEHHQT8MQMwhPwBm7BgbcCG3TPP0hWgD058iB364AToEb58PN51TQEiBwR48iIzHgi0Zr/6xDsksCbIXKo6t085zieQm7nnf3IRKDsv4hzLaC/WLKGfbbc0I4l4uoBWOXp9LVzqYP/Ai+1oQDlZU/700LV+s2ffLo9gGfeYpQZ3w7qfjrvMOrT2ddfra9LiO6N1KYj6ytQH52vKLPr1xrhQ2+QijbtP7JYsxnMdJ2S1gaXHoDVCAbs3a/sTzg5TJjTgNu8zxGIHrylBDxrQbXZ/6Ul7uG5QK/9kERYNqYW819bO5D+QNBkz18ulNpu1T2uGtQSvX4L7fsvrFUZTssedJD1NPEQJ1qG4sOf1QiKcP20b9sq5yY5S1RMhb9dat0Svt91yn2OjqNaZhaMMS0++2kYGeKOqGCP322YKo/Bnkv0TO9KFUT0+CL9l3JL2CAaYDxBIat6Achc9v40oL30VKaYatkOP6ELkvBK45w1mJKNlb+KlJlFM5+0Xq50yRu7a4ZFTKFfUekKqMHhWkm31DaRJPiutVHbOJotsRWBWUXiVrQg2cK7OMeYE1mNbRpQL93YAWeC5z7eRSvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(6636002)(6506007)(110136005)(31686004)(316002)(53546011)(2906002)(8936002)(31696002)(36756003)(83380400001)(5660300002)(86362001)(2616005)(4326008)(38100700002)(66946007)(8676002)(66556008)(44832011)(66476007)(508600001)(6486002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDZ1Z3A5NkJRcXVIeDQ5Y2UyNVplQkdzRU1wSFNsSnZQUGRFOVV0NUNhSnk5?=
 =?utf-8?B?UHBPdlAzSkg5L2tXdzJRR2Rob2VaZ2YvU3hZVmxFNFQ3eENrN0pIOThobXps?=
 =?utf-8?B?Lzh5OGRyaGxSc2ZUUG1heUtrTEJpYTFiWjBWK1psZk9KVjdJbytDSlZPanBo?=
 =?utf-8?B?WGh0bDNxZjdZUjkybWo4dTI5bHlaVmNVUjJyNFk5VXpUUURnVkVKQjUrS0ts?=
 =?utf-8?B?T2N6VHVCWnh2MkZETmg1UFJIL09TZ1J5OG9LUzh6cm5BTW1BUTRreVZmalB6?=
 =?utf-8?B?UzBjZTh4K3NVWWJhNGEvWE4ydU1oWU9acUcyTERYOWdQR3VJRTZwMlR5RFd4?=
 =?utf-8?B?YmpVdmtWY1AveTNiRFV4SW83aW9lU2ZZZ0JSWk5nSzkvNmIvYW91SDgrd1pG?=
 =?utf-8?B?RVM3aVFsV0ptY1BuNVBJaU1VaTVoVWZRSXloM1NlVUFLY3pBN09HbzNJT05B?=
 =?utf-8?B?K1dvRXBYOTRlcmJGZW1yNHl1bEJzamY4YWdJRzZ4NUhON0hQRmV4UThCcnhN?=
 =?utf-8?B?QUxLSEsyMFlEc2NncGNBckpXdUhLU3FuQ3FKRFBFTCswVTlENkI4VGsvOFFz?=
 =?utf-8?B?N2pPVy9Hek1XWTBDcXNlOXZGcitxWjZhM3UvcXcxbVRxZllnOGx2clNxS21Z?=
 =?utf-8?B?NUlRUXlGbUVyd2xROGlqUFJ3WWpZbmk4RXdPZ1pmUldaanE5elE1ZHUxYXcr?=
 =?utf-8?B?RE9oUW0wbVlOWWtFdFdpQlR6QnNVdS9rL0hWMXZmVGcraE1wNWlYZkpJTmxI?=
 =?utf-8?B?Uk55OVQrREFHTzZFVWhFZklXYzR3RG5wRnFMZ1hXSWVNd25iYTZ0YnJTSUZ5?=
 =?utf-8?B?SStpTVdkTjBkblZGd3loU043MVNScktwSzcwcFM3Y3pKSEhvOThqNm5wSkR2?=
 =?utf-8?B?S25DR0w5YmFXMkZ6blh6Szl4UXhMYmtzNmNXVUtIbHkyQ1ByZ0hLd3NTYy9E?=
 =?utf-8?B?d3dxTzhLU2FmcHkyMlZYN24vUkVkNDIzRG5iQ1Q3M0diWjN1cmIwN2Y2K0dH?=
 =?utf-8?B?bGFLTWdRMm9lZC91ZVVzWFhGWVJrVFZ5NzVyS1EwV2xsVkZKb3haVzYrODlL?=
 =?utf-8?B?UkcvTWdCYWJwdHhqamFibGhtSGtHekNJc1RJTmJKVnUycExLVkNuSFkvaTI4?=
 =?utf-8?B?VFhmU2NhZEZKei9TZlFkdzlLUmsxZ0dscWp2Tks2bWMremFsM3czZmxkSnhG?=
 =?utf-8?B?Qk1PZWE2NTh2YmswRFlaNmppaDJoN1Z0MFZtbTJodGh0T3MyV2hCMEZtNkth?=
 =?utf-8?B?YkE5Q2VFaW5KZ2g4RjJ2cGhNOW1yU2VpZFFQK0tIL05rY0FIeTltcXpRcFQ1?=
 =?utf-8?B?Q2xGdDMxWXZTRkU5S2dwK0l1cWxibWVtN2c3SWlJZXczMEI1NHpEVUZOUXU4?=
 =?utf-8?B?OSs3Wk5pQUZKQ3RqREdISXQ2U3FsUVBkOUc1alYyRUgvMUVNV09qRmpKaGto?=
 =?utf-8?B?TWxVQndWKzl0VFFEL1JFeUtyNU4rNHQvYm4zak5UMGM2YUYvN0xDaDhIalBF?=
 =?utf-8?B?TjdqS29RZDN4OStRSThKUTUybGpIVFJiNklHZFBRM2dtUHhMR1NGcGJRQWIr?=
 =?utf-8?B?WUhEWm5qMmI2cGM5c1ZNTGNoT0NnTzNuc01sZkw3SnB2ZWpSYlJxeFVEY2pm?=
 =?utf-8?B?Smxzc3VvbTZOQyt6V0x0clR4NnZ1U1NIdHFsa1BuZTVXalE1dzkrN2RDbDBn?=
 =?utf-8?B?SGZNSVRMQXRjVCtwdlZHeWVpL1NtQ2lpRGFhcCtrRklMS3VWNCt3N1I1TTZZ?=
 =?utf-8?B?UTl4TDhoZW9pUXFSNUx5cEh0U1RZeFpuY09zeVBiNHhOSHd5L3E3WEJUTGh6?=
 =?utf-8?B?ZW5Rdnl5MUlVOEliSXI2azZNNXQvZmd1Vmt5UFVNUTFSS0hyemVBdk93WlBX?=
 =?utf-8?B?dkczbUh3T0dKYVdEbmpXdVRJMTZsUzVqNGtuNkVxV1h6ZlpnZGhJVGRTT0pv?=
 =?utf-8?B?bFZHOWV3TzltTGx0Q0htV3hGeWNlRXhrU05TNUJnTVJqTEVJSHRRYlBjVkN4?=
 =?utf-8?B?VVpZa0dOVm1hUDZxMHJtK0sxaUh3dGZCME1pdnIyaWxuOG4zK1RXQVBiVjYy?=
 =?utf-8?B?TEE1c3RsOVNSR0U3a0JkRVVtejhpcldlV3NJbEdMYVNkYVN6UHpqdzhrU1hj?=
 =?utf-8?B?VFZWQjJXN2dzRVlOZWRXZW1qWnl0dzZqb2ZFeXJtaDYvQmVRVmhiR0tMd1po?=
 =?utf-8?B?cmVHVlgyQVpTcFJBNlZtamJ3KzZIWC9IMUZLU2wyYVphUzI0aVhkbTBtd0Fz?=
 =?utf-8?B?Qms2SEFuU2svODc1NkY0ZVhzU1R6V1BTaWJvSmkwV3pqd21YSEhmRmNkdTF1?=
 =?utf-8?B?ejlBVjhFYWxoS1FyVnFXcUpaYnFvcVNXa3dnbGxZcEsveGxIUzhaaVozUG8r?=
 =?utf-8?Q?3x/cINcUHLWSVvaGGLDbw8rCLoulDorTG2ZSXxq8mdcQT?=
X-MS-Exchange-AntiSpam-MessageData-1: eSs0+NApSiyWjg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c40795-7656-48bb-d2cd-08da425385cc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 15:46:12.2889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FphDakb2Ge8ZdDZxG3kzsejBFDVtCm8yDi5wTNOURFUmuIENKGRZehG7Xw9Myc4dyDXTtQsiBpi8Eq/p1vBCxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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
Cc: Zoy.Bai@amd.com, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+ Monk

On 2022-05-30 03:52, Christian König wrote:
> 
> 
> Am 25.05.22 um 21:04 schrieb Andrey Grodzovsky:
>> We need to have a work_struct to cancel this reset if another
>> already in progress.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 19 +++++++++++++++++--
>>   2 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 76df583663c7..8165ee5b0457 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1048,6 +1048,8 @@ struct amdgpu_device {
>>       bool                            scpm_enabled;
>>       uint32_t                        scpm_status;
>> +
>> +    struct work_struct        reset_work;
>>   };
>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>> *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index d16c8c1f72db..b0498ffcf7c3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -39,6 +39,7 @@
>>   #include <drm/drm_drv.h>
>>   #include "amdgpu.h"
>>   #include "amdgpu_trace.h"
>> +#include "amdgpu_reset.h"
>>   /*
>>    * Fences
>> @@ -798,7 +799,10 @@ static int gpu_recover_get(void *data, u64 *val)
>>           return 0;
>>       }
>> -    *val = amdgpu_device_gpu_recover(adev, NULL);
>> +    if (amdgpu_reset_domain_schedule(adev->reset_domain, 
>> &adev->reset_work))
>> +        flush_work(&adev->reset_work);
>> +
>> +    *val = atomic_read(&adev->reset_domain->reset_res);
>>       pm_runtime_mark_last_busy(dev->dev);
>>       pm_runtime_put_autosuspend(dev->dev);
>> @@ -810,6 +814,14 @@ DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
>>   DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, 
>> gpu_recover_get, NULL,
>>                "%lld\n");
>> +static void amdgpu_debugfs_reset_work(struct work_struct *work)
>> +{
>> +    struct amdgpu_device *adev = container_of(work, struct 
>> amdgpu_device,
>> +                          reset_work);
>> +
>> +    amdgpu_device_gpu_recover_imp(adev, NULL);
>> +}
>> +
>>   #endif
>>   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
>> @@ -821,9 +833,12 @@ void amdgpu_debugfs_fence_init(struct 
>> amdgpu_device *adev)
>>       debugfs_create_file("amdgpu_fence_info", 0444, root, adev,
>>                   &amdgpu_debugfs_fence_info_fops);
>> -    if (!amdgpu_sriov_vf(adev))
>> +    if (!amdgpu_sriov_vf(adev)) {
> 
> I think we should drop the check for amdgpu_sriov_vf() here. It's a 
> valid requirement to be able to trigger a GPU reset for a VF as well.
> 
> But not topic of this patch, feel free to add an Reviewed-by: Christian 
> König <christian.koenig@amd.com>.
> 
> Regards,
> Christian.

Monk - any idea why we prevent from creation of debugfs GPU reset for VF ?

Andrey

> 
>> +
>> +        INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
>>           debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
>>                       &amdgpu_debugfs_gpu_recover_fops);
>> +    }
>>   #endif
>>   }
> 
