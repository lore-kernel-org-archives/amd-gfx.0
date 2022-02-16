Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2933C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 13:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F5E10ED16;
	Wed, 16 Feb 2022 13:18:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6DE410ED1C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 13:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPgwX0qfxdXsIVJL5ytWRqGsTk18UAZZsi/6El3WNElkiiLzFRkkbb0QZlPIykoGRskAHJOkUoOckfwJ1lAISes+EjPtQrpoTneU6XIGRbfzE0YVYrl+n6qkQTJ+tpUmSOag4QJY8t3OqThjc4SqjncFodhFgHQ3zTmvjZUDD4JKu2AqGJKEIqDXzjlK9CczoAYYiQ0Xaz+c+xNRBUPMd+eXEdNWV2LDXQYW7oxOsGpts1FSW9AvdSdykPBLI+fMZIZL5QNfRnurMoNILB6emfVgiW4/g/nr3InwMS2MJUHE/mV1dz60YumCJdyr+icNzJ1qPnKlqKjvSd2ws/ILyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ouTlKepFaBzAdygqCuIODlxIJ6hYYoJ20IRZctASiY=;
 b=BUHevg8p1m7N/Het4Frl0REBI5k250LjDj2BLUAmveNT3zWIV8pVdVGVJJS9qodik9PjBUs7EDUzD+jPPJEAKcARLW7nF4NFmSc33xwQZnYSHKcSDzvUqAqhjFY72NEXfDjgUEeAVFxs6JQOv6KMiYApOjGSbj16R+BC5HY8TYyprKdoir9dwxKQZYdPvxAnVRRpgVL1FXdv20AEkc1HoU1thtBZ3I+vIHXy3ofvQte4lsbwhB79A/acMuUE2OnLSikl2j5W8hWPPfRprJHaQ24wUNB1TqGtiw4T9pF6bgAJQV2nqzRGwmiDsmf9EisNo+p4p+uzwhzIiQH7le0PMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ouTlKepFaBzAdygqCuIODlxIJ6hYYoJ20IRZctASiY=;
 b=VyCObcbdMjumOPhsj/9D2myEwuxRp//Rb+ANrdCWSD2DMOqNrmwugRjgp51XrPTpOcMgImDGgIDKltcbN2Q6TLDJd3tcqMOntAn2VbUyGcbFouY/a2hJIcaVtVMQ6XiceoFH1f0VPqYni5V2jbpPMxjMRbO76ts1Zv3YoQrLf3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN8PR12MB3330.namprd12.prod.outlook.com (2603:10b6:408:43::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 13:17:57 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.4995.015; Wed, 16 Feb 2022
 13:17:57 +0000
Message-ID: <2577088d-a863-f5ed-8b8d-2060b7286a3a@amd.com>
Date: Wed, 16 Feb 2022 18:47:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <fa563eb7-a0df-cbda-004c-23b10e882a6b@amd.com>
 <392e1b15-8bbc-91cf-ab86-9d28aa0b716e@amd.com>
 <1021c2e4-22bb-1e94-1a91-c4d7cd915b49@amd.com>
 <9c3942f5-aaa2-da81-962a-a010bb093002@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <9c3942f5-aaa2-da81-962a-a010bb093002@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7773cce9-6613-48e8-3264-08d9f14ebf55
X-MS-TrafficTypeDiagnostic: BN8PR12MB3330:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3330B8A3EEB61956ABBC48DA97359@BN8PR12MB3330.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rznTI22qV+zpV0OVQxRm6/OBuZhyER+5P5IRSlJH6LvzNLbQpqq8Rfhw8l7benzm2U7NLBJtYm9OJQfWtvXikLWv4850zx2KcoQkonE/ks4OPHkGHLbbktlihSjC6ze7aTYDUJa2jbXd+J0/hAZcp2MTrteDcAzIRXUkefqbJjaYyB/jah9e+rEG7BGtYhRqwNMiesPxSHZQh3XDHbiISm0ZxuEikOSmtqyXZLChZtOwiu95YCXMm4SwgGxRiOcFSlQJhjuAbcdJNIxAxFvVVzgLiG/xAXs92EMjS6eoRL+EJcAd4+2+feB5LOFKFVFsygBBCiuQTpAeMjVpt0+F7CIVCYcy6siCrgo+eo98hrX5RbFGRJq3+EY+G4rVaw9wdczV2QHn8nN16ljGTXJ6dTVLflWnig7Vw8Rj9+jjqxap62nBYADtPREqBqEAKoS7TLsBgOqSsHsFUR9QXu806BQYviFP81JwtBPAIVnJVxVaYRxNjSTyf3yN2gCcRwXusUa/tPECCCDo6L0zIGQNNi4mjPgX5GTw6sFNyVYRZ7Gt5ddlZuIc6A4Ente2RrmC0l8VyYL6GqOX14dZ33vV7p3NTjrYkGEk1Y9c0D+zfYFU8UjFyeCnaHyc5dB7WVXta8X7V4OWCK09Epk3SMA/9xzQAKwqy3kIBXzNPaLG9o+eO8Ju/kx011KkWmewvMdo69LYpKAx6LFaK4PFStWj4FDbXMKlEycr6930ktAymXHeVD6b8K+dhh07rw4Txoop
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(8676002)(4326008)(31696002)(5660300002)(66476007)(186003)(36756003)(26005)(6512007)(86362001)(53546011)(2616005)(8936002)(6666004)(83380400001)(110136005)(316002)(38100700002)(2906002)(6486002)(66946007)(66556008)(508600001)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3ZIVWVvTjhhdHh0RUE3MTEzNjE5VnV5VlRlTFk1VXBDNVJESGMyNWgzalA3?=
 =?utf-8?B?SWtNMXNMTWttQ3VvZzd2NmhaWHRKdFBvTHNVeUFnMHRwaFo2ZTUzb09DNEti?=
 =?utf-8?B?MmlsTEsveGlLK2xnODNjbThmRTcyMzFPc2Z5ZUtkRDV3SWljOUN6dFU1bE84?=
 =?utf-8?B?SWhUbmxsTmtiaUJ5TkpVSG5nN2NjajFMandia1VwTjAyZzVIbU1MYzRsbi8y?=
 =?utf-8?B?RSt2eW9BZUZKNUx1dVJ2UUNHZDBXQmtnL0NncEZFUzFHa3daa1hPZWtyekVh?=
 =?utf-8?B?dEw4WDVxVjNRRURiK3RLanBndTFSTjAyaXZlN3o1ZHRlUmVwY0ZBTm1uaGcz?=
 =?utf-8?B?SlJjTjJXV0ZiZDBwVDh3OXBjWXNQQW9QMkN5VytLblMveDVpVm9uTnhxNzJK?=
 =?utf-8?B?ekR5MmxsN09qRzNqYThoQlJxUUFpRWxPYXRGNHJMWjRUZ0NjdkRqVmtoUnJS?=
 =?utf-8?B?YytiemxzdHZwYXR4ckkxdXpPWllNN2ZpZDFxMkRWZ2ZTOS81dzZYeXozek9p?=
 =?utf-8?B?aVlCbzU2ZEFZN2cvcmROU2RDZW8zSXh1OENaRzZ3M3pBT1lJZGpmVHZMTXky?=
 =?utf-8?B?WmFaWnN3cHlZTTVYR0dyQUZralRHUGJTZjVSa1daM2t0S292N1JPZGltNjJH?=
 =?utf-8?B?S28wRHZFS2hpWGNkT213KzUvalVkZ21HNnphZlVsbXYyTGdKeEhnMVFSQ3NJ?=
 =?utf-8?B?UjNoVVcrTW1hSWdQM21zeTF0WXB5Smo2TmNsM0dzSGlOVG55NlFpNEFER2FY?=
 =?utf-8?B?NldvYVo3c0NoZXpIZmYwcEUrK1ZtWFg2MkxLMHFMaS84SDBDNDg2aW9Iejhz?=
 =?utf-8?B?eFpQb3EvdEFCVjJ1ejNaQTltOUpVK3VyRnl5R29UNDRuT05qRXF0a1ZFTm5M?=
 =?utf-8?B?SUU5Q2czVjVLZHhMRXQ5S1dlM0hQY091c3BPTXpxbmtrOG9CSjJLcXdEcjUr?=
 =?utf-8?B?d1NFVGNUUG0wMnNhUDUyVHdkZnJsSWtJNjM2WVdLR0R6RTVkVms5L2pwbmFM?=
 =?utf-8?B?R2hacm5iMTRyRGJYMjlLUXdzUUs1ajV6eWhBV1hKQ3FtTlhCMFBublBFMEk4?=
 =?utf-8?B?S21XZ3RpZlAzU0hHZGlSRmJqS3hqUTlxUk5HbE9rWEF3dkRGVGhKbW5MWW1j?=
 =?utf-8?B?TmJrUnY5R3VwZmhXMEZSY2F6Z3owMjNraTBsTStMQ1ZTZ2luWWVla0ptSmx2?=
 =?utf-8?B?RWZmZUFZMVlmazNrWUlIMVJCbXpRc0FYZWNwblJqUXloTXdqOGVFaDl3bHh5?=
 =?utf-8?B?ZWtKTWhEOHlrNzl3VElyTnhUZHhpelZtUDJ4d3VVMnNXMURPZWlXellJaVh4?=
 =?utf-8?B?ZEhPSi9xTUZ0SXBvUWJlWnBEYWZwbEd3RTM3dUpQMm14WnltaWlyUzdCM21n?=
 =?utf-8?B?amdjWnB3dDBreDNISGYweXZTWTE0ZjhtemRQaTVvR0EwVm9XelV4NVdiY25D?=
 =?utf-8?B?Qit6UHJpekhqNm1ySkZGd1N0anNyMnhqaU9OeHlzL0t0dmdoN1ROVkVkQldP?=
 =?utf-8?B?WE1TZnppQ3dtSGFidnA3dkFmdXBSWnc0TmowdERVazRERkVRS2cyaTVUZmFC?=
 =?utf-8?B?anJCbHBybHZnZHBGYnh6K1JTb2FvSXlhU1R0Z0t1N2N4S3dTR3ZqVWpiRTVz?=
 =?utf-8?B?R1JsTUVZVzJEOHRzRXFPTWwyM0hPeUR2cFIwRFQ1Y2hxbEJUZWE2b1I3MW5z?=
 =?utf-8?B?dC9DbFB2azhyV05NeTYyZTFpeVpFOUN2L2ZwaUxtNGxtdEZmbUxwbjVaT1Ft?=
 =?utf-8?B?bFdoa3lXcDMzYjJnUlJhQ1VZWlRad3RXSW5BMmtKYTUrYXJhVkVxUU81ZHp6?=
 =?utf-8?B?WGVDOVdsN0g2bEoxeGF2cVZYK0dCTVdxTkRNUmQ2bVVHQUVxS2g2elpmYWRB?=
 =?utf-8?B?UDBPVW5OeEF0RkNXMHNLVExJbVo1TXNVKzlJenNmY3Q0Wi9meWc0bEY0QWJv?=
 =?utf-8?B?eC83Sm8yM014aFNMckV4RnhKbVZKdC9udThTWWtNemdTcGoxeGxBRlRGUHhX?=
 =?utf-8?B?SFNIMzZoVFZIbU5JbkZ5ZGV1OG1jLzYrYXJWNU9QU1dYTFNVTEVEcGUyYkcz?=
 =?utf-8?B?WEVRM3E1Q0xFZXBraTVReStob0Rzc2NMVk5qNmJkbHU0dlBkMktRQXVxQTZR?=
 =?utf-8?Q?ynM4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7773cce9-6613-48e8-3264-08d9f14ebf55
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 13:17:57.3004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaaKCj9DZfqJbR2aNBQI6jyvBUG9YiY2C5N05LK72kAmoMNNBMOhmuQ5M2uP5CZ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3330
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/16/2022 4:39 PM, Somalapuram, Amaranath wrote:
> 
> On 2/16/2022 4:13 PM, Lazar, Lijo wrote:
>>
>>
>> On 2/16/2022 4:04 PM, Somalapuram, Amaranath wrote:
>>>
>>> On 2/16/2022 3:45 PM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 2/16/2022 3:19 PM, Somalapuram Amaranath wrote:
>>>>> List of register populated for dump collection during the GPU reset.
>>>>>
>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 
>>>>> +++++++++++++++++++++
>>>>>   2 files changed, 100 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index b85b67a88a3d..57965316873b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>>>>         struct amdgpu_reset_control     *reset_cntl;
>>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>>> +
>>>>> +    /* reset dump register */
>>>>> +    uint32_t            *reset_dump_reg_list;
>>>>> +    int                             n_regs;
>>>>> +    struct mutex            reset_dump_mutex;
>>>>>   };
>>>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>>>> drm_device *ddev)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> index 164d6a9e9fbb..faf985c7cb93 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>> *)file_inode(f)->i_private;
>>>>> +    char reg_offset[11];
>>>>> +    int i, r, len = 0;
>>>>> +
>>>>> +    if (*pos)
>>>>> +        return 0;
>>>>> +
>>>>> +    if (adev->n_regs == 0)
>>>>> +        return 0;
>>>>> +
>>>>> +    for (i = 0; i < adev->n_regs; i++) {
>>>>> +        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
>>>>> +        r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>>>>> +
>>>>> +        if (r)
>>>>> +            return -EFAULT;
>>>>> +
>>>>> +        len += strlen(reg_offset);
>>>>> +    }
>>>>> +
>>>>> +    r = copy_to_user(buf + len, "\n", 1);
>>>>> +
>>>>> +    if (r)
>>>>> +        return -EFAULT;
>>>>> +
>>>>> +    len++;
>>>>> +    *pos += len;
>>>>> +
>>>>> +    return len;
>>>>> +}
>>>>> +
>>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>>>> +            const char __user *buf, size_t size, loff_t *pos)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>> *)file_inode(f)->i_private;
>>>>> +    char *reg_offset, *reg, reg_temp[11];
>>>>> +    static int alloc_count;
>>>>
>>>> This being static what happens when it is called on a second device?
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>> I tried to avoid adding to adev. It wont work for multiple devices.
>>
>> Hmm.This is not friendly for single device also. Some one could just 
>> parse a text file of reg offsets and do
>>     sudo echo offset > file
>>
>> This will overwrite whatever is there. Instead you may define a syntax 
>> like
>>     sudo echo 0x000 > file =>  Clears all
>>     sudo echo offset > file => Append to the existing set.
>>
>> Taking all offsets in one go may not be needed.
>>
>> Thanks,
>> Lijo
>>
> 
> 0x000 can be offset for some registers !

It's indeed a valid register called MM_INDEX register. The register 
doesn't have any meaning in standalone.

> This is application responsibly; any wrong data should clear the list.
> Application can read back the list for confomation.
> 

It needs to be done by user app anyway. This is more about how 
convenient the interface is. Probably you could switch to a user 
standpoint and try to add some 20-30 registers to the list. Then steps 
needed to add a revised list.

Thanks,
Lijo

> Regards,
> S.Amarnath
>>>>> +    int ret, i = 0, len = 0;
>>>>> +
>>>>> +    do {
>>>>> +        reg_offset = reg_temp;
>>>>> +        memset(reg_offset,  0, 11);
>>>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>>>> ((int)size-len)));
>>>>> +
>>>>> +        if (ret)
>>>>> +            goto failed;
>>>>> +
>>>>> +        reg = strsep(&reg_offset, " ");
>>>>> +
>>>>> +        if (alloc_count <= i) {
>>>>> +            adev->reset_dump_reg_list =  krealloc_array(
>>>>> +                            adev->reset_dump_reg_list, 1,
>>>>> +                            sizeof(uint32_t), GFP_KERNEL);
>>>>> +            alloc_count++;
>>>>> +        }
>>>>> +
>>>>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>>>>> +
>>>>> +        if (ret)
>>>>> +            goto failed;
>>>>> +
>>>>> +        len += strlen(reg) + 1;
>>>>> +        i++;
>>>>> +
>>>>> +    } while (len < size);
>>>>> +
>>>>> +    adev->n_regs = i;
>>>>> +
>>>>> +    return size;
>>>>> +
>>>>> +failed:
>>>>> +    mutex_lock(&adev->reset_dump_mutex);
>>>>> +    kfree(adev->reset_dump_reg_list);
>>>>> +    adev->reset_dump_reg_list = NULL;
>>>>> +    alloc_count = 0;
>>>>> +    adev->n_regs = 0;
>>>>> +    mutex_unlock(&adev->reset_dump_mutex);
>>>>> +    return -EFAULT;
>>>>> +}
>>>>> +
>>>>> +
>>>>> +
>>>>> +static const struct file_operations 
>>>>> amdgpu_reset_dump_register_list = {
>>>>> +    .owner = THIS_MODULE,
>>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>>> +    .llseek = default_llseek
>>>>> +};
>>>>> +
>>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>>   {
>>>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>>> *adev)
>>>>>       if (!debugfs_initialized())
>>>>>           return 0;
>>>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>>>>                     &fops_ib_preempt);
>>>>>       if (IS_ERR(ent)) {
>>>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>>> *adev)
>>>>>                   &amdgpu_debugfs_test_ib_fops);
>>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>>                   &amdgpu_debugfs_vm_info_fops);
>>>>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>>> root, adev,
>>>>> +                &amdgpu_reset_dump_register_list);
>>>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>>
