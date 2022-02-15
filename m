Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7219C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 11:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249A689DED;
	Tue, 15 Feb 2022 11:15:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DAD489DED
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 11:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0qlKEwUlvNADj+7HW5OBeYg/Hahd4nBWqecMsa99URCn7l36ShdGpQM7kVxVorRL+zZ7aMQGvVow+Fl/3HhJr/le4VPjK8zUlU/Zc28YsLEAIEFGKTJceGcy6qdoJO61gQvzhqK6BI7EIexY0SLpJEbvjCHyO7mDcAj/A9UDc20hF38GCZFgxcTBZyvqP1u6MOG8OSYdkXo7zwBzsQem28/K4JSQpLxbSUl+EkJ7RIW5zdGaZc+/7IkMeqCyJRi4iKTtHaVKhPj8gcn1YbiPpgTodjO0ZlLYw7Ljg/CTc2G2R6O/OwR0pjVCwwtbxk2p036WhWFWON3Ghpg4owaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHo9j/TnGF8lpbEdwlHqcj1jzVSulSnQCM4y2X5LopQ=;
 b=FQV2hQzR38WOEri2pMimYhJin1hoC3TvEhnVSyMD4Mlx16UDvJ2BhRabcinqwJILWLKxo6vU7nxYLZUrjrqwzkT8XW9v/wriqarrdvbWGenekj09FRdQlqmjFzf/4sPT9Eqt4Q0IRcNZ0TV1/OAoOk04r1fX76c5ZIRMCFyugsSw6RkaYPMgW/MK76Vx07LTrf3CtQivXo4QsVkwBP2YuwK/8BkMSQGvSmHiSoyadOj9lircp8jlMo6OIymNndieHGZJydmgIwuNO/ax20aaPrfNAlB2W4LpyoMCUfY9pEkVLv0Ttox3bBkiqPbzyX9Qg8fj/12vx/kz9A4idHathA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHo9j/TnGF8lpbEdwlHqcj1jzVSulSnQCM4y2X5LopQ=;
 b=gSvkEqhmKeREY8Qg3JhKfsjlomDgRqPg0z7KAjDHwadX5C1NP4gg1ZtH0kzduW6EjaWoSU1aFoa3zrOa99Ib8A/TffXs8yAIyyJuf7+t0mcJ1J2NY4ANNOI9Zu87cBzzA0MycrqZ18CcaOG25rSIV4+ZmLIdJm8wK2xooA5/6JM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Tue, 15 Feb 2022 11:15:31 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d%2]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 11:15:31 +0000
Message-ID: <7e09e7e2-3f04-ebb9-7654-95cc0e54dda7@amd.com>
Date: Tue, 15 Feb 2022 16:45:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220215101228.9433-1-Amaranath.Somalapuram@amd.com>
 <e678e107-530e-260d-b14e-f742a651859e@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <e678e107-530e-260d-b14e-f742a651859e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::23) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 654dba6f-2a92-4540-936e-08d9f0747a2d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1514E65B17C702E3124F59DBF8349@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W44hA2aobqXN4fOomI1tOIr1X/kyIvur3Yv2zGar+S0Nho7WwtDK4rqfc/Royu5siMJwzuF5wxXmNDFpSRyUUWlsfrGWOQrRjsNqfw+sFUICSOm/4aLKB1jiosMJIELNsxOTH2jmCOmd/9cruDUFR+FBJqUYlo+c1rFMw3guXPgk4GCx5VBWOm+/DpKJLi6JIQlLvc8kR4RxypE4g4FeFUad33FMB90bTOS1EJVX71Oy0HvdVXUE3dIYDpsh/Lz0S7ozXm5C+WuCdNPWE4q5AXbLETEC+L07+gK1rjtpK6ZX2XWl905txGpxoUgmwaXNBtVuS2lvfPKZANRsq1WrHWOZ22d7PVzlmslWceUaKXFI1/Oy3DXTa2GAnLFgg94lzktBehJrQ3vDtOjjj80kJwQQ7dsduJuOEf+++aEhO2Pz5idA7mlanjWjKG6LezagXdYWspyOPFcR0ykgEcGGkANvk3ZSt70XJru7UuaP+KPxjCEsOXAbst0DMsyTGuI09ZMlLW55B85asCeOdccFd0sN5t7QSAOKfa5PTOb09xsWIuTqWmuHpCSX2svaX9owpiuljISG5mIxlNX0M0Px8xry6sEORvjizDOa57AO1azfsDAuyxYeplr3j50PuDwRA1IcsE0lMGkhnAArVlRVDQoHK3kUNqtGDzZr/4mdI2WvYXMyT5ye8deUs+zHldUbBxcuJn65Gl28puqz2+0r1dFbYjRPzT98TjDkm1luG5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(110136005)(8676002)(316002)(2906002)(6512007)(53546011)(31686004)(38100700002)(8936002)(6506007)(26005)(508600001)(31696002)(66556008)(66476007)(2616005)(5660300002)(36756003)(186003)(6486002)(66946007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkVVN3FwMnFzK05CcDM5K3RyV2lwMWhwVitWVXNqTU4zVm1iYnlORFdkUEhk?=
 =?utf-8?B?TU1Zb00wZjRucndXKzBHN1ZhVkhsR1JNQ3RKVWpHWVFsbXByZFJ1bmVmTVln?=
 =?utf-8?B?NExrem85L3RJaHNuVHVSdTFocE4xNDdYbG05VEE4Mm1rVWYwYmRXY0t6Z09n?=
 =?utf-8?B?UkVYbENXRjNkY0RGKzdtT3AvQUQrS0c3RXJ4Rks0eGF0dUxjV0docnY5dG9h?=
 =?utf-8?B?Vng1bWVFYWdCQkIyWEMxdVlGekR3UXBBZy9PYXJZWEs2aWdaTzBvSTJ6NFcr?=
 =?utf-8?B?dXIwMFdCSFArbUh3QzNDYzNBajZhZm9oNi80ZDkyMkRuckpyc3R2Q21pOHVx?=
 =?utf-8?B?YzI4bTl4NzRsT1RaZ1oxeFA1M1l3aHVnTXBUbVF3ZmhGWHJ0TzczdWR5ckNB?=
 =?utf-8?B?emc3RFNZblRhUVhReEJ4czFCc3kvRmtvVXRMMzl0cVdZZnNBU3c5eGgzcFhN?=
 =?utf-8?B?bFJsR05ITjQrQk1URzhVVVVZam5sR0pnUC93U3NiaWQzYk9RbjdiUFZmUWY5?=
 =?utf-8?B?THkyMHU2M09uaW4wMjJhd3k4UEFLUmt2bzl2SkZjZWxIczlRVzRmcS9sUE9k?=
 =?utf-8?B?MHNHRjVIVVI5YXhrTldBWHpqb2JraDdobytIQUdqV0tYR21vMjNOYXI3dkly?=
 =?utf-8?B?dkZZTWN0VzN5ZEZubHdTK3k3OVIxdk1xeUk2dGlGZWZaU0Ryb2oyT21ZWjBr?=
 =?utf-8?B?V0dPMURmcnhUYlZwcC9IYmk3NWZUaVBRLzd1WDhtem9rVjlNYU5OY0k2TzRT?=
 =?utf-8?B?RnZlV2FmOGxrZjFhdGQyZEVGYno2Y0d6eUhCQmRHREx3Nk4xTVFYTzJ6S1I3?=
 =?utf-8?B?MFhjU3EvT3J0Z25XNk9jR0hTSEZKMkxXL2lPaVF1aHJkbkFYVDA1ZGRTWTJ4?=
 =?utf-8?B?RFkzd2NGRW5MQjJLUWhVUUVWL0NwRWVrSjFjQXJKdVQ1ZThNeDZEcStrQm42?=
 =?utf-8?B?NExmR0RkZHphSmtMTEFwUjZ0bG8wVmxycmRudGlCd0s1aXNMRGsveEY2UlJI?=
 =?utf-8?B?RmthL0c1NlNwM29KTzlZRnVLc1o2T2d5WXNreDluNTdkdXpmUmpjYWFRczJE?=
 =?utf-8?B?d2xteFhZK2NsWVcwR2ExMkFMdWwvRDNPWTFXSlZTbCtrTmlscURncnk2Z2pz?=
 =?utf-8?B?SHhlNWxCeHZndy9qSmcvdmVRTy8zR3M1V3VZYXo5dTJxYjVCbG43RkdsNUJl?=
 =?utf-8?B?U001SE91aWw0YVN3ODNXWHhjZ2dtN0MvbkVRR25kTnU4ekdZWG92SktFSkhB?=
 =?utf-8?B?ekIxTC92aVo0dncrZzdFN0dNUTgweDYyNllmbWNNK0sybnJKdFlscnltK0RP?=
 =?utf-8?B?Tk53TWhlYUF6VUtCYUxLWlZsVFVYd09mbG1lT1JjSmpkODBPcnRGdy9kWE1T?=
 =?utf-8?B?SE1EOWtVSzNPY2FHZzdCYUpaMU56eWVHMUVhSThwZW1LWUVTSGNGcmtXQ1lC?=
 =?utf-8?B?RjNQVndaNDBITENBN3MwNW1icS9uemdRWVdjUG5GK3k5Y3pFWGpGdWZneUZI?=
 =?utf-8?B?TCtXYnRQRVNrQ1JJakFPZHVwOFdBK2hCYTEvNnAzbTNzenV5elZjU041S3po?=
 =?utf-8?B?UWNxMFNlNjY3MXZOdE1JYmJCVjZLQWU0ODcvaVZhWGZTK2JwT1FzUlk0UjlH?=
 =?utf-8?B?MzJwYkg4MCtrMmRoSnY2dktLRkZXZ05Uc0pKMXVpNndUSDFqNG96QXlPWDVK?=
 =?utf-8?B?UFBqL3BvVjFwdnptazB6L25lVVpqbXQ1d1dBNGo2d28xdWUwWnV1a3ZpdERS?=
 =?utf-8?B?SnF4dlhVei9SODQySFROb21jWEdsSXNFaU5rY0VnRDVxeDd1dmRYSHpIcS9P?=
 =?utf-8?B?a2RnTDAxQUdWNUFzSGYzOHdOSE5QdWo3TDduTy9MQnZRRjZrcGRUek40b08y?=
 =?utf-8?B?YWpDSE13bVoreWQ1UnRHcnNvTVdJRktOeXhyOEhQbU9GQzROeFNVQ2NQaTUw?=
 =?utf-8?B?Z2JwK1VXaTBudkNVWW1kVk9hZEduNnA2eTlucWhaKzZjT2hmbVpxNjE4ZzVT?=
 =?utf-8?B?MXIvRllDc2luZTFUeTQ5bkxKTjZWSDMvR0J0TzZoTHViRHVXODU0MnJGZlhG?=
 =?utf-8?B?RzBhRzlLRC9heUsvc3FxMTFCakJ5V1hwSGM4WE14UXZSNVVYQWpBMTR1SUVt?=
 =?utf-8?B?Q3Jaa0UvZEdNeVAvcmxBOTY2VWVJVUZlak13NjhPdnlxaUlYVGtvcS9lN2Z6?=
 =?utf-8?Q?grujFfqHZaJBXH6TL2pSACI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654dba6f-2a92-4540-936e-08d9f0747a2d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:15:31.0065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKsimTElxlJjy/58isM1uwiIrbPKc3KafFepzQiVMFPbu+bL2doG5kD+IszFjDe6qX1WSXPLdXeheU7j2dJ6xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/15/2022 3:46 PM, Christian König wrote:
>
>
> Am 15.02.22 um 11:12 schrieb Somalapuram Amaranath:
>> List of register populated for dump collection during the GPU reset.
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 89 +++++++++++++++++++++
>>   2 files changed, 93 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index b85b67a88a3d..2e8c2318276d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1097,6 +1097,10 @@ struct amdgpu_device {
>>         struct amdgpu_reset_control     *reset_cntl;
>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>> +
>> +    /* reset dump register */
>> +    uint32_t            *reset_dump_reg_list;
>> +    int                             n_regs;
>>   };
>>     static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>> *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 164d6a9e9fbb..edcb032bc1f3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1609,6 +1609,93 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>> +                char __user *buf, size_t size, loff_t *pos)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>> *)file_inode(f)->i_private;
>> +    char reg_offset[11];
>> +    int i, r, len = 0;
>> +
>> +    if (adev->n_regs == 0)
>> +        return 0;
>> +
>> +    for (i = 0; i < adev->n_regs; i++) {
>> +        memset(reg_offset,  0, 11);
>> +        sprintf(reg_offset + strlen(reg_offset),
>
> That here looks odd, probably just a leftover from the older code.
>
My mistake leftover code.

let me try to remove memset() also.

> Without it you can also drop the memset().
>
>> +                "0x%x ", adev->reset_dump_reg_list[i]);
>> +        r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>
> Whenever copy_to_user() returns a nonzero value the best practice is 
> to return -EFAULT.
>
agreed.
>> +        len += strlen(reg_offset);
>> +    }
>> +
>> +    r = copy_to_user(buf + len, "\n", 1);
>
> Same here.
>
agreed.
>> +    len++;
>> +
>> +    if (*pos >= len)
>> +        return 0;
>
> What is that good for?
>
If i don't have this condition read operation will be infinite loop and 
data keeps repeating.

I am not sure why !. maybe i need to set something while write operation.

> Regards,
> Christian.
>
>> +
>> +    *pos += len - r;
>> +
>> +    return len;
>> +}
>> +
>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>> +            const char __user *buf, size_t size, loff_t *pos)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>> *)file_inode(f)->i_private;
>> +    char *reg_offset, *reg, reg_temp[11];
>> +    int ret, i = 0, len = 0;
>> +
>> +    reg_offset = reg_temp;
>> +    memset(reg_offset,  0, 11);
>> +    ret = copy_from_user(reg_offset, buf, 11);
>> +
>> +    if (ret)
>> +        return -EFAULT;
>> +
>> +    if (adev->n_regs > 0) {
>> +        adev->n_regs = 0;
>> +        kfree(adev->reset_dump_reg_list);
>> +        adev->reset_dump_reg_list = NULL;
>> +    }
>> +
>> +    while (((reg = strsep(&reg_offset, " ")) != NULL) && len < size) {
>> +        adev->reset_dump_reg_list =  krealloc_array(
>> +                        adev->reset_dump_reg_list, 1,
>> +                        sizeof(uint32_t), GFP_KERNEL);
>> +        ret  = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>> +
>> +        if (ret) {
>> +            kfree(adev->reset_dump_reg_list);
>> +            adev->reset_dump_reg_list = NULL;
>> +            return -EINVAL;
>> +        }
>> +
>> +        len += strlen(reg) + 1;
>> +        reg_offset = reg_temp;
>> +        memset(reg_offset,  0, 11);
>> +        ret = copy_from_user(reg_offset, buf + len, 11);
>> +
>> +        if (ret) {
>> +            kfree(adev->reset_dump_reg_list);
>> +            adev->reset_dump_reg_list = NULL;
>> +            return -EFAULT;
>> +        }
>> +
>> +        i++;
>> +    }
>> +
>> +    adev->n_regs = i;
>> +
>> +    return size;
>> +}
>> +
>> +static const struct file_operations amdgpu_reset_dump_register_list = {
>> +    .owner = THIS_MODULE,
>> +    .read = amdgpu_reset_dump_register_list_read,
>> +    .write = amdgpu_reset_dump_register_list_write,
>> +    .llseek = default_llseek
>> +};
>> +
>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>   {
>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>> @@ -1672,6 +1759,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>                   &amdgpu_debugfs_test_ib_fops);
>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>                   &amdgpu_debugfs_vm_info_fops);
>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>> root, adev,
>> +                &amdgpu_reset_dump_register_list);
>>         adev->debugfs_vbios_blob.data = adev->bios;
>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>
