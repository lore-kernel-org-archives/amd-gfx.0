Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C5EC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B37410EEB2;
	Thu, 30 Mar 2023 14:53:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FA210EEB2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:53:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CADAzPnfRTWd2o9DsZS2C3vuBMsDAkqDJlu+nzh5n3vTd8lmQJRrOLfYuSlVRJ85IVm6X/VAb3bfbt5XQn+gxMgJtC3zWMXSNKnSO+w+U0MHvpELtxje+Proa3KXo+DZIROkw8BBlTl7gWM6Gspa0q93znOoYLlItNfjeqhHDRBUoeqTOWJqG/waXVcisxUIfnWxyd1/buaYZUzwbaKZlnVB86xE1bM3LCst6CEHAubA6Vn7CdBYhKxmEOSfhP6gf6apMI485vB5ZSNFn7SpOJGw2dsys5rewcx+7YFdxZ6omRXof3exqA7Yjg8RQvoYx0b2FcwTg2l7DMDuJrF+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VV0W83O4dgAZGfaCm72V6Dow1mMIqtLu22PE+QbOpw=;
 b=S7ojni8rXpOkCGFfeVlL1ITT6Zx3D6XWQedvLSIaCNFAjCvKYaLkgF24j/VUrfcAZjKx3sssmAL9biBg2W5Ii3ZUTi1RNpUiozZkp4oukj5HG0Rk/X+XsCl31JruhRUS43C2H4jy+tkMc/UXN/W8/x71qEFj1GqU9r9Yuin5yk4kskmLP9HPNyTJMVei3HfZJyMipvut7uYnJ2Tcuuf39QE+d5MbSRlHph9oQn3bzXteqcC3vO4fWTgirLaAItw0QWi0w9fS5XKFTyFWed6EpHt++e5Geu49uari17sGnSL+tshxkDpHXXsMcZRkSIOGhQ0kNJ7kIOfiouZr0i5BXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VV0W83O4dgAZGfaCm72V6Dow1mMIqtLu22PE+QbOpw=;
 b=pIf0P3bSPlbsatn+6tyhSCdHHYgI1Cun43kWxqMNkQIAh1nAXOAOq4T3jainqedeRVJfr2DH2XtNsTl4ls6Cn2iFhowPryRFltoGUD8cS7unsCvK2lZO7btF0hL5jatoTiZzxjRfNXf2CmnjrnBdSXQut29sGAFLhQ0liSsNt3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 14:53:46 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 14:53:46 +0000
Message-ID: <e41c9db6-8633-e7b6-e1e8-c5bd6d607975@amd.com>
Date: Thu, 30 Mar 2023 16:53:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
 <41c5746c-8db9-07b4-2500-cf023031f221@amd.com>
 <fc73c097-5ea9-2e15-f459-e9bc2bd05c95@amd.com>
 <51e57144-dde5-6bfb-45ad-0dcc79bf0cae@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <51e57144-dde5-6bfb-45ad-0dcc79bf0cae@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 15790c08-74e1-4f5d-855c-08db312e9006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N44BNONJeW+ONUynZjikqdct31K1SQqZViX9mn2xIIsJePTCBt4HUukmOJvjmnbD1+Xs5/wLuKRLbD8Oq7xjw9vqh5NM2UtdJk7LrGh13Odc2q+/G49dU937R+whss7ziboYKa2wfJ3J7fOKGcZavxebkG6EUeMNK1/Nq7EVp4kfngtknbzoQkqUpZlwiE2PdYrwwQb8iGMkEJ1aUSxfbDl2Z/HHuF74qFXGyaz9FRJ3IYobmv+SiCSNZAlFgl5aTp/Rmpxs+BvN6G8/ywkrcBrT6LY8wTcbj8AttOKVjIfsPZuPp+4aIB3b9jVlzOYax0UJZ1baoUPDUZOr4MLw8tH3cBbzyudONGLMuUllcGcd540keyYP/67t5HKB0+eAmiiSTl0cnqhVZ6Ruzgc4wRham2oVsao0eilXeht9+H8xxVZDfTFxfvq3o6o1uEuw/2ENmKLgQrIJZPvoswW6TLQY/0StYcAUOCo9mPHJramtRQHBG82SJy6yG6eSbdELVkdJE0e+DYUP/5wbzbQCXWCEL052Fsb2IM4B004f4F/6gFCfJ8VxFsMAR2bu+ZUOm4EAQB2vAZeYfVOrX2XRTw1wDCdkbDVeQ6jTTrBLQzcEOeil4fedsBmG6jB87z3RtE8/GQKG7V1SIYyvqVApkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(66574015)(41300700001)(83380400001)(8936002)(5660300002)(31686004)(44832011)(2616005)(4326008)(66556008)(66946007)(66476007)(8676002)(316002)(26005)(110136005)(36756003)(6506007)(2906002)(6512007)(86362001)(186003)(478600001)(31696002)(53546011)(6486002)(38100700002)(6666004)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0puUy9nODdxNVB0cllqV0VURUNseFhLU29oajhQWE9rdytuRmVvdHVoWTlZ?=
 =?utf-8?B?akNrYW1YaGtVUHdsbXJiZWtwT1dIQ01wdVVlbS9qWmg4RWp3U0pPT1dOS2pa?=
 =?utf-8?B?ZTZOVDhIV1lpc1VQajJzNzNENmZnU0xBVkJIRUJGMXJRSEg5MjVNV1JWOUpt?=
 =?utf-8?B?bng2RVhUellTTUxjdDZRQ1A4aWdqbnZ1SWtReHgvVU5EbEpGNUVDcHhiNE8x?=
 =?utf-8?B?MW5YaHhabTVkQy9zdU1LM2pEVGtZdkFieEFvOVAzRG9wSDNyakQ0NXRjcWwv?=
 =?utf-8?B?T05tdlV1QnZRTGdBaVpybko3R215RUErQ2wwTFdPM1JHNnZ6ZlpBdGhSTHh1?=
 =?utf-8?B?cWdOdjc3dGF1WXFHd3F5Ly9BZzd4RjkvTVhEUFluN1IwOXBRMVlxYVBKYmV3?=
 =?utf-8?B?OTVCYXlVNXpRcFVwNThFNTNqaWNNZzhCN24rLzVsVUMzMEhXdEpZemhlVGdO?=
 =?utf-8?B?M05xTGFYd21CM1R3bjArbFozbC9xc2FFeGpHNWpnQmJrS01zZHN1NjQ1MTll?=
 =?utf-8?B?R2t4RkdiZDd0ZUtjMGo0SG1VUEkzZEVSdTdjR0I5dWdtcUJmKzh5aVBSbG5N?=
 =?utf-8?B?blVYb3VIazRUcnVYZER2Q1M1WUN6bnF3U2N3UmQxYytsTDhrVWozQkQydWMv?=
 =?utf-8?B?WlpqWXdyNWZzeWVpMHNtMWJpRG1SdmdCdFF4MnVSOHYxamlHSHRwZllpd2lD?=
 =?utf-8?B?Z3pXNjNJbjI3RHJIMzFxaFR5U0dvWE9UYzNOZjB6MllpZ3JtYnBaRFEzTXdL?=
 =?utf-8?B?WEtrUWJFQmc0M2s3emdsVGdrdXhXUlkyTWhoRFFuWDFjR3BncEZBYTVFRC9J?=
 =?utf-8?B?dUZ3UHhqSU5peXpyazVqeEVlellGYWROTDVRanpOdVJGWmIwNHBjYmwycmRt?=
 =?utf-8?B?TnFFa2Nnc1dPQnJIc2NHUVdaWmRNTG1lUC9odnByVFluQ3hLSldOTUpvbVhP?=
 =?utf-8?B?akJ2bTAxVWQ4cWpJMHZNbGVHTjVvaDdid1hTRXpNK0NsM0pMWUlQSUNXV2Qr?=
 =?utf-8?B?a0NtVTR2eFBsbmorMlhkYUkrRStGTlJ1NXRuRE5ucEdhQm5YcytYSXBnTTBp?=
 =?utf-8?B?R2dWZG43UXMrSitMaU1yMlJVU2xyNTdzNlVleHBpUWc0djEwSlNBOC9DMGlE?=
 =?utf-8?B?R3E0b3JEYzVZb2Vnbllwamxtc3lyNkJUejNFZUY3VU1xdFJramx0MXBkYVI0?=
 =?utf-8?B?TjdFNUpJSm1OQW1SeldPTC9qdWtwQzY5TWlnRVA0K1dVTWQ3dUU5d28wc1lY?=
 =?utf-8?B?ZEVGcFVaempEaGdvMExPcEZVVVAxdkhHbzV6Q3B0aWNvZS9VaTJtZGtzaXI1?=
 =?utf-8?B?aTdxUnpOWU5VQk5ZNmVYczVxUFArVjlmVEhIMlB6YzRlN0pWVkNabWIwMUpj?=
 =?utf-8?B?a3A3Z3dEY2I5aURubzZGZFVyMmJqSmxnM3Fxb2VzN3BtSjBuUENOVFR3UFpB?=
 =?utf-8?B?YzVvOWlKdzJpMHpnc09lZWFwVVlITTg2bUxHd0F2OWMyYW1QUnFwWXIxRWhw?=
 =?utf-8?B?ZDVpVjRDVjk5cDlIekRvN2lPeFc3VlJrMWh4NllRT2Fybmc5OXZsSkQrME56?=
 =?utf-8?B?UXZmeHYrV0RBQmVvd3B4RkNSOWlrMkVISWt5enFma1h1QnowM25VYzI5QjFQ?=
 =?utf-8?B?cmZJVmxCbTVXY09LRERvTlFwTU4ybXV6eCtHTExZdXdXN3V5RWE2S1M4cGUy?=
 =?utf-8?B?bGQ4RzdUMkNFU1BxL01hWTc2UXMwVzV0OWR2ZWtpNVgwL1VzK3ZOLzd0VXEr?=
 =?utf-8?B?dTcxNDhxdDF0SjVhTDlwZ1Y0RlplY1VCSEpUc1J1SzhHZGVuTXV6eDAzamxP?=
 =?utf-8?B?YTk2K1ZySU5adjBDT1RXa0ZYa1dYaC94c1FrZzhkUGhDNlRyeXJ4T3pWWmpJ?=
 =?utf-8?B?bTQrVW9YVGE2UE02VFJhd3NQUjg3UCtCU1JuREdFSzlTU3ArSW9GelEvcndK?=
 =?utf-8?B?T2xFY3R1UFhzNXN5cWV5Q1JkUHJ0b1RZMFRGbU5lVkd2SGtVUTFLaG50NXds?=
 =?utf-8?B?K1hLMXlGQVNtcWRKWVVkblUwd3p4OExzU2ZqaGZTMTF1SG1QQ2JFWlQrdHBN?=
 =?utf-8?B?clZYRjFPanFua2VTZWswWmZTczR5b243UDlxMmo2R0M1S3FXOGZkVmcwU3NR?=
 =?utf-8?Q?PPiokld2BiRBpfRVfCHQaiE9v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15790c08-74e1-4f5d-855c-08db312e9006
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:53:46.0301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpvNlL4LekB/Q3FJPfPb5f8NkQIS9AVRzsV1cvLg/2JedT06iRfKHM5KJLeuYvkYmqKjjDqnGdOPVQRJKe95sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 16:49, Christian König wrote:
> Am 30.03.23 um 16:40 schrieb Shashank Sharma:
>>
>> On 30/03/2023 16:24, Luben Tuikov wrote:
>>> On 2023-03-29 11:47, Shashank Sharma wrote:
>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>
>>>> This patch:
>>>> - creates a doorbell page for graphics driver usages.
>>>> - removes the adev->doorbell.ptr variable, replaces it with
>>>>    kernel-doorbell-bo's cpu address.
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44 
>>>> +++++++++++++++----
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>>>   3 files changed, 57 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> index 6581b78fe438..10a9bb10e974 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
>>>>       /* doorbell mmio */
>>>>       resource_size_t        base;
>>>>       resource_size_t        size;
>>>> -    u32 __iomem        *ptr;
>>>> +    u32    __iomem        *ptr;
>>>>         /* Number of doorbells reserved for amdgpu kernel driver */
>>>>       u32 num_kernel_doorbells;
>>>> +
>>>> +    /* For kernel doorbell pages */
>>>> +    struct amdgpu_doorbell_obj kernel_doorbells;
>>>>   };
>>> Here's an example where it could be confusing what the difference is
>>> between "struct amdgpu_doorbell" and "struct amdgpu_doobell_obj".
>>> As the comment to the struct doorbell_obj declarations says
>>> in patch 7,
>>>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>>>> +struct amdgpu_doorbell_obj {
>>
>> What is the confusion ? This is the object which is holding doorbell 
>> page. There could be 2 type of
>>
>> doorbell pages, kernel and process, this is a kernel one.
>>
>>> Perhaps we should call it "struct amdgpu_doorbell_bo", since
>>> it does contain amdgpu_bo's, which are doorbell's bos.
>>
>> This is not a buffer object (memory), this is doorbell object, so 
>> calling it bo would be wrong.
>
> I think what Luben means is that in object orient programming this 
> here would be the class. The object is then the actual instantiation 
> of that.
>
Why should we even bother about OOPs terminology in kernel C code ? I 
think we are spending too much time in something not worth.


> But I have some real doubts that this is the right approach in the 
> first place.


I would like to discuss and understand more on this technical aspect. 
Can you please have a look at the whole series and check how we have

handled the existing doorbell clients (KFD, MES), and if you feel the 
same, we should talk more on this ?

- Shashank

>
> Regards,
> Christian.
>
>>
>> - Shashank
>>
>>>
>>> Regards,
>>> Luben
>>>
>>>>     /* Reserved doorbells for amdgpu (including multimedia).
>>>> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct 
>>>> amdgpu_device *adev,
>>>>   int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>                   struct amdgpu_doorbell_obj *db_obj);
>>>>   +/**
>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel 
>>>> doorbells for graphics
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * Creates doorbells for graphics driver
>>>> + *
>>>> + * returns 0 on success, error otherwise.
>>>> + */
>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>>> *adev);
>>>> +
>>>>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), 
>>>> (v))
>>>>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> index 8be15b82b545..b46fe8b1378d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct 
>>>> amdgpu_device *adev,
>>>>       return 0;
>>>>   }
>>>>   +/**
>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel 
>>>> doorbells for graphics
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * Creates doorbells for graphics driver
>>>> + *
>>>> + * returns 0 on success, error otherwise.
>>>> + */
>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>>> *adev)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_doorbell_obj *kernel_doorbells = 
>>>> &adev->doorbell.kernel_doorbells;
>>>> +
>>>> +    kernel_doorbells->doorbell_bitmap = 
>>>> bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
>>>> +                              GFP_KERNEL);
>>>> +    if (!kernel_doorbells->doorbell_bitmap) {
>>>> +        DRM_ERROR("Failed to create kernel doorbell bitmap\n");
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +
>>>> +    kernel_doorbells->size = adev->doorbell.num_kernel_doorbells * 
>>>> sizeof(u32);
>>>> +    r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
>>>> +    if (r) {
>>>> +        bitmap_free(kernel_doorbells->doorbell_bitmap);
>>>> +        DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", 
>>>> r);
>>>> +        return r;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   /*
>>>>    * GPU doorbell aperture helpers function.
>>>>    */
>>>> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct 
>>>> amdgpu_device *adev)
>>>>           adev->doorbell.base = 0;
>>>>           adev->doorbell.size = 0;
>>>>           adev->doorbell.num_kernel_doorbells = 0;
>>>> -        adev->doorbell.ptr = NULL;
>>>>           return 0;
>>>>       }
>>>>   @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct 
>>>> amdgpu_device *adev)
>>>>       if (adev->asic_type >= CHIP_VEGA10)
>>>>           adev->doorbell.num_kernel_doorbells += 0x400;
>>>>   -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>> -                     adev->doorbell.num_kernel_doorbells *
>>>> -                     sizeof(u32));
>>>> -    if (adev->doorbell.ptr == NULL)
>>>> -        return -ENOMEM;
>>>> -
>>>> +    adev->doorbell.ptr = ioremap(adev->doorbell.base, 
>>>> adev->doorbell.size);
>>>>       return 0;
>>>>   }
>>>>   @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct 
>>>> amdgpu_device *adev)
>>>>    */
>>>>   void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>>>   {
>>>> -    iounmap(adev->doorbell.ptr);
>>>> -    adev->doorbell.ptr = NULL;
>>>> + bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
>>>> +    amdgpu_doorbell_free_page(adev, 
>>>> &adev->doorbell.kernel_doorbells);
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 203d77a20507..75c6852845c4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>           return r;
>>>>       }
>>>>   +    /* Create a boorbell page for kernel usages */
>>>> +    r = amdgpu_doorbell_create_kernel_doorbells(adev);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to initialize kernel doorbells. \n");
>>>> +        return r;
>>>> +    }
>>>> +
>>>>       /* Initialize preemptible memory pool */
>>>>       r = amdgpu_preempt_mgr_init(adev);
>>>>       if (r) {
>
