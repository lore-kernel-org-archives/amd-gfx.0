Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498ADC76196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 08:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D062D10F127;
	Fri, 31 Mar 2023 08:27:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A1F10F127
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 08:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=du8AsePtWlF9CF6OzTyrglXocrXkjLdfcsgnIP42RU8QLK/HZF+JmKdSX+vHHOuW80ywyLw1MUYJGEL0xSEAK+Ih1Dj9yCF2zHM7fi3GrolX7YMFSmulQtye0vRneHBNYed6V/iPGt0ypcDUuZCrLa6rFBRpIG0m6Wzkstg+jKd98+qpotvNQiQJQJI1FIz5vPiXSIYJVo5aKlM2/iFLdDtKhfCPQjT6yD43Kbm4FejsQ0j6/9BWAzLo/NIO0ec8NdZV05FluhV/MhTedKe2sdh/w45u7Ku+4+68PcMFypDfvBJr6CZ4DWsPKE3cKKpumWs2ee0JGL8twWd+jG5uPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PydZASF0ubKSfje3sSb1Bom6sxsvgBNx1ajgriwrgXk=;
 b=SVpfgGycPH9DpXnt+PGAAh0rBpwNycvkTMcBT0CPqHnI1xa7qng0OMjDoy1zkUUni+6vviU7U+uVG+6dLGyTEsF//prPEFV3TuGP7ttcmwpZKcCCq3tei2h6BbSvVrtQcsz/JbHN5ESGdmeBBdtfSrPN1zdRJOwt8E81KsU5H984d66x8UCUDJMAlGf+wsTkS73DGlI3PI5h0Y/keZGQ9Z4ZBsxaH2S/heqnT1ljQdHkCQMudKS7BrOiitkpEFdjgSAoq7Bhz/bgLD1Ywk/s5r+6K7qiu3QT0FyMOD5eXBG+KlTGu+VlphReG+GY98z4XyL2uNqa6KXSltR1pkxsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PydZASF0ubKSfje3sSb1Bom6sxsvgBNx1ajgriwrgXk=;
 b=hhESr8z3e7Y+2QtfPP9t2vwQmQcsy+PqWkl1eaoN5uqJvCFg17PGbkmG6RTu0VM8ndu3x1wEjxJFlMdbZGqtTts0vcbIt5il9uA+X7OUnA1h1kWT3Z0GJ+bAwH5brEDSMXLdou9ME+l3XuQPHFLqWLNNcP2BqyQ2K8Z+9p3mtOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 08:27:42 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 08:27:42 +0000
Message-ID: <4bbcd7fb-1dcf-3cdf-3602-9d831998a30e@amd.com>
Date: Fri, 31 Mar 2023 10:27:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 12/16] drm/amdgpu: use doorbell manager for kfd kernel
 doorbells
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-13-shashank.sharma@amd.com>
 <CADnq5_Pg8+m+VqfravXf_4xxRFKKw+FaNYSMqF=PWSjk7CmVLg@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_Pg8+m+VqfravXf_4xxRFKKw+FaNYSMqF=PWSjk7CmVLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::15) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: a608f5ca-26b8-4db9-5c27-08db31c1cbb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vwgU/9SK8l63c24Lq3ygg5wdb5MpK0b4hYxXKUJAAS/5xP6Yajxb1tdJLwoa0K7hx6SK2N+/Q08C8zQHG/DCtViylTJU8aRxBYWmoGvLDzKnK9oZjaMg7mX3HbD0V6tCMMZPSD1Ys6kwpIW9emL9TKL+K8qweKTY3wraF2NU8d+Q/RoLgFPi2dChFkioYPRlZxM8H3rsJ+CXWo3E3umoy3lggFjQ1MpY/K77fIHsdiVAkX23tB66lrUzqaihIiioUIcceEZgJ67EHaLgLUxa7MichzzbLbMD6XdBKxRO42KKV034ErTHN5lD1pszsXkp0bf2eH4TXvTu4LlwaR+CR4UStZ8/CNBjF3BRUdc7pW3BcCfFxtxBtQFvSodGS6n9nfAowHb2r61GxpKpSu3fHSEV1K7UWUXkDvqVipYoRv+NUfAVP59qffhSSZ2AqXpUfb02W5M1BN+Eg4uldWqSdaa2zYnH2BT2sgV1TUBSAxG8bEv8IaAq5zY4fS1D1L1YJ40gSz+ISTU6YUM4oNO2U486z7tNhQLaLkvB4ps2Jp2Qqvgu92MC+5kV0gzxngqMAJ2408/vMtvhpZC7BlusjR8lTl0z5xNM5IJCnBthkvhQZA6OSReunViJAzu3RT0yIyfx0WHRMNiViEouD011Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(66476007)(186003)(4326008)(6916009)(66556008)(66946007)(8676002)(2906002)(44832011)(36756003)(8936002)(5660300002)(83380400001)(41300700001)(2616005)(26005)(54906003)(478600001)(86362001)(31696002)(6666004)(38100700002)(6486002)(6512007)(6506007)(31686004)(53546011)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXUxOTRWM3lqWEhqTWs2U1Npc3Q5bHdJa25GQ21iWDZuYkN0VE1tVVF0OWJy?=
 =?utf-8?B?U2JFMHVXMGRndUxiN2ZITFZ3bXVFUGZaOTFtYVpGdEVIUVIreVQ4TGczYnFr?=
 =?utf-8?B?ZFA2WS9HNUxKS01oeVBTejlhQ1hIWUdpZ3NxZHAzZEQrL1lNMkNNaWJ3dXZD?=
 =?utf-8?B?eDJqS29oZFZraWN3Ull0SXJEUEhzQTQ5aHAvUGY4U2FtTEJKaDVaRnVmVllR?=
 =?utf-8?B?dzFYcm96QWJwdXR5N25EVjREelc2ZHpNRm16QUFCR2MxVDVseHg4RmFqb3JY?=
 =?utf-8?B?SUV1eDJ5NGFPdWxFdCtYRDVjRFpMWU1nOEhDV3ZDT0h0UVI0MFdmLy9lYVFO?=
 =?utf-8?B?MmpoTCtDWHlPdDVpc1FQYU81U0x4R1UrK3dtVGF3SWpEMHo1bFlNQXIzUWp0?=
 =?utf-8?B?UmVYSnpERU5sNHlwd08xNnpOZkpUeXdScERIMVVwa092MXk5RXd5WHNxdW95?=
 =?utf-8?B?czVvWWhRN1pkdWpLb0NOQ2dhZ0J4c2hWc0N4VEpjdlZnMThkSXN3NzZGRUJS?=
 =?utf-8?B?UzVvUGNoZUhQNVB6Uk5GaytvNUdxQjNnZUNBSlFxQTFUNHZES0NBQXMrR2hH?=
 =?utf-8?B?Z1VDL3Y0SEEzM1ZuZkhiQlVOSTJnekM4R0E2Qi9HTmJLRjF5VytQMDFlbTFN?=
 =?utf-8?B?Z3B3bWdJbFpNRThQRE1QTEVqWU0wK3J4cGI4WmVqb21Lc0NkWHcxcG9MSFlo?=
 =?utf-8?B?ZlRoME10VlF0a043c1FFNitGVVNhUlZhVG9zYjZvVWhLWjl3RThjaWE3WDN2?=
 =?utf-8?B?bXBPcEVjeU5DMVZLam9kNW9UbU9aTkFDYlpoZ01JT3FBY2pXVnpLT2ViL2dr?=
 =?utf-8?B?bnFMeTlhOW42ZlIrbDVpNDlwekxSeU05S3A2NG5wQTBUNWJSeWU5NlZ5TEpN?=
 =?utf-8?B?aUJHZWZESGNPS0R4YmZxT2ZOK3VBMTNPWEcrMEZCd0EwQ3hoR3VYTjdzTFUy?=
 =?utf-8?B?T0h2WHdJTVkvclVBLzQzK280QTY4alFXS1ZucXZpZlF1OGtKMUhFeDlWdEtT?=
 =?utf-8?B?dHZxLzM5aTBKZ2xPdzhUbEJ6MVlFYUhUZHhsVGgzN0NCM1dEOXlJN3pIUE5H?=
 =?utf-8?B?NEhFandDYUl4eVZSb29sQUpESVlTd3FxeCtJNHdtdFo2OG5BZzVnbmtXaVBx?=
 =?utf-8?B?OWltNnE2ZEpyOXBkeElURitIcFNxOG5zMGVPMEJYbUwvL0cvYzliRmxPMCtE?=
 =?utf-8?B?cFV3dldUUjRNOWxndmRmc1U2Qy9oUElJOGZOR2dVY3JiSDBoUjBXZEQzUk1G?=
 =?utf-8?B?a2wwVkU1Rk9ZVzRiblV4MWo4end5WUVCMGRYRC85cEt4VFRZVExhZm92UFN6?=
 =?utf-8?B?dlNCRStCMXZBVkx5ZnpwdzJFcGdKb0E3UmNoWEhiTzdpM3p5MlBGZUlNeExB?=
 =?utf-8?B?emJ3eFYvWXdzdEhka0JWMVMvNG4yYTlFclpEMkpOWlhNVExKeTVWQXVkQkUy?=
 =?utf-8?B?K0V6ZHNZN3RMSVRnRzgwa2pudXk0a3hoQ3BldGU2c0Q0c01WNXRadVdHZnBV?=
 =?utf-8?B?VUpXaU9VYktpMy9iUnNVbXk0ckI4YmJMVjh4RVpYTitKbUZkVGV4dkkvdWJu?=
 =?utf-8?B?U1FHSjV6NmZHMWp5MTljTWhaYnJDdkJVYWc1RzJ0eHNxWkhrb0hsbXpvQVFR?=
 =?utf-8?B?ZU5NTVIxWnhXWWp6Sm9qT0JPQnArVVhoTjBzNFdkVmZ5L0kreVdYeXhFN0x2?=
 =?utf-8?B?am0yQlNOU3VuTXBrUzcyWTlEb2dnTFMyTkxHWkp2WmsvR2EzVFFIOXFzMEF0?=
 =?utf-8?B?ZUlLWVRWZk0wenN0bFliWU9uRmpENVN0azJYZmdPb3FVN09JNk1Bcy9TV2tI?=
 =?utf-8?B?UVBpRE9MMFBldmE5Y0hOVy9seGllU0F3UHZMNGJkZ0FYamxvd3QxMnc0WVJG?=
 =?utf-8?B?QjJUdENydFVYQUcxVjNmcGxDQjZ3NHhqcXA3SGFaN3NOWEdpaDRZck5zRlhC?=
 =?utf-8?B?L0U2dXdKcG15ZTVZRkFKZzdjZTVQU2xXQk13THl3UGhSM21ZUk5Sa3BYZzVr?=
 =?utf-8?B?emxBcXlZVk9hRlJwTUJyM2RSeVI5dUNJQitRRUl5a3c4OWdia0F1VUJiSzBi?=
 =?utf-8?B?ZEFOaFJ0M01hdjBBQXRDckRWWjU4YW00UUlmdEdHWUFNZDhsenpmZGVpRlZQ?=
 =?utf-8?Q?xY9EBmOrNBof4ImTVEZdaLoXw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a608f5ca-26b8-4db9-5c27-08db31c1cbb1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:27:42.1393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23x/0oB9th/vmQMiw2pV1WVnJT1jl2ZYomeqIbEpZO+ZRSu71+6FVnYSQySi/Iwfsdu4jzr0W6ytNrjepmJ/Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
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
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 22:46, Alex Deucher wrote:
> On Wed, Mar 29, 2023 at 11:48 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> This patch:
>> - adds a doorbell manager structure in kfd device structure.
>> - plugs-in doorbell manager APIs for KFD kernel doorbell allocations
>>    an free functions.
>> - removes the doorbell bitmap, uses the one into the doorbell manager
>>    structure for all the allocations.
>> - updates the get_kernel_doorbell and free_kernel_doorbell functions
>>    accordingly
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c   |   4 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 109 ++++++----------------
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |   3 +
>>   3 files changed, 35 insertions(+), 81 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index b8936340742b..a2e4cbddba26 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -435,8 +435,8 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>>          atomic_set(&kfd->compute_profile, 0);
>>
>>          mutex_init(&kfd->doorbell_mutex);
>> -       memset(&kfd->doorbell_available_index, 0,
>> -               sizeof(kfd->doorbell_available_index));
>> +       memset(kfd->kernel_doorbells.doorbell_bitmap, 0,
>> +              kfd->kernel_doorbells.size / BITS_PER_LONG);
>>
>>          atomic_set(&kfd->sram_ecc_flag, 0);
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> index cd4e61bf0493..df259f2cc58a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> @@ -61,81 +61,37 @@ size_t kfd_doorbell_process_slice(struct kfd_dev *kfd)
>>   /* Doorbell calculations for device init. */
>>   int kfd_doorbell_init(struct kfd_dev *kfd)
>>   {
>> -       size_t doorbell_start_offset;
>> -       size_t doorbell_aperture_size;
>> -       size_t doorbell_process_limit;
>> +       int r;
>> +       struct amdgpu_doorbell_obj *kernel_doorbells = &kfd->kernel_doorbells;
>>
>> -       /*
>> -        * With MES enabled, just set the doorbell base as it is needed
>> -        * to calculate doorbell physical address.
>> -        */
>> -       if (kfd->shared_resources.enable_mes) {
>> -               kfd->doorbell_base =
>> -                       kfd->shared_resources.doorbell_physical_address;
>> -               return 0;
>> -       }
>> -
>> -       /*
>> -        * We start with calculations in bytes because the input data might
>> -        * only be byte-aligned.
>> -        * Only after we have done the rounding can we assume any alignment.
>> -        */
>> -
>> -       doorbell_start_offset =
>> -                       roundup(kfd->shared_resources.doorbell_start_offset,
>> -                                       kfd_doorbell_process_slice(kfd));
>> -
>> -       doorbell_aperture_size =
>> -                       rounddown(kfd->shared_resources.doorbell_aperture_size,
>> -                                       kfd_doorbell_process_slice(kfd));
>> -
>> -       if (doorbell_aperture_size > doorbell_start_offset)
>> -               doorbell_process_limit =
>> -                       (doorbell_aperture_size - doorbell_start_offset) /
>> -                                               kfd_doorbell_process_slice(kfd);
>> -       else
>> -               return -ENOSPC;
>> -
>> -       if (!kfd->max_doorbell_slices ||
>> -           doorbell_process_limit < kfd->max_doorbell_slices)
>> -               kfd->max_doorbell_slices = doorbell_process_limit;
>> -
>> -       kfd->doorbell_base = kfd->shared_resources.doorbell_physical_address +
>> -                               doorbell_start_offset;
>> -
>> -       kfd->doorbell_base_dw_offset = doorbell_start_offset / sizeof(u32);
>> -
>> -       kfd->doorbell_kernel_ptr = ioremap(kfd->doorbell_base,
>> -                                          kfd_doorbell_process_slice(kfd));
>> -
>> -       if (!kfd->doorbell_kernel_ptr)
>> +       /* Bitmap to dynamically allocate doorbells from kernel page */
>> +       kernel_doorbells->doorbell_bitmap = bitmap_zalloc(PAGE_SIZE, GFP_KERNEL);
>> +       if (!kernel_doorbells->doorbell_bitmap) {
>> +               DRM_ERROR("Failed to allocate kernel doorbell bitmap\n");
>>                  return -ENOMEM;
>> +       }
>>
>> -       pr_debug("Doorbell initialization:\n");
>> -       pr_debug("doorbell base           == 0x%08lX\n",
>> -                       (uintptr_t)kfd->doorbell_base);
>> -
>> -       pr_debug("doorbell_base_dw_offset      == 0x%08lX\n",
>> -                       kfd->doorbell_base_dw_offset);
>> -
>> -       pr_debug("doorbell_process_limit  == 0x%08lX\n",
>> -                       doorbell_process_limit);
>> -
>> -       pr_debug("doorbell_kernel_offset  == 0x%08lX\n",
>> -                       (uintptr_t)kfd->doorbell_base);
>> -
>> -       pr_debug("doorbell aperture size  == 0x%08lX\n",
>> -                       kfd->shared_resources.doorbell_aperture_size);
>> +       /* Alloc and reserve doorbells for KFD kernel usages */
>> +       kernel_doorbells->size = PAGE_SIZE;
>> +       r = amdgpu_doorbell_alloc_page(kfd->adev, kernel_doorbells);
>
> Just do something like:
> r = amdgpu_bo_create_kernel(kfd->adev, PAGE_SIZE, PAGE_SIZE,
> AMDGPU_GEM_DOMAIN_DOORBELL,
>
> &kfd->doorbell_kernel_bo, NULL, &kfd->doorbell_kernel_ptr);
>
> Then you have your KFD pointer to its doorbell memory and no need to
> track the ranges.

Noted,

- Shashank

>
> Alex
>
>
>> +       if (r) {
>> +               pr_err("failed to allocate kernel doorbells\n");
>> +               bitmap_free(kernel_doorbells->doorbell_bitmap);
>> +               return r;
>> +       }
>>
>> -       pr_debug("doorbell kernel address == %p\n", kfd->doorbell_kernel_ptr);
>> +       kfd->doorbell_kernel_ptr = kernel_doorbells->cpu_addr;
>> +       pr_debug("Doorbell kernel address == %p\n", kfd->doorbell_kernel_ptr);
>>
>>          return 0;
>>   }
>>
>>   void kfd_doorbell_fini(struct kfd_dev *kfd)
>>   {
>> -       if (kfd->doorbell_kernel_ptr)
>> -               iounmap(kfd->doorbell_kernel_ptr);
>> +       struct amdgpu_doorbell_obj *kernel_doorbells = &kfd->kernel_doorbells;
>> +
>> +       bitmap_free(kernel_doorbells->doorbell_bitmap);
>> +       amdgpu_doorbell_free_page(kfd->adev, kernel_doorbells);
>>   }
>>
>>   int kfd_doorbell_mmap(struct kfd_dev *dev, struct kfd_process *process,
>> @@ -186,24 +142,19 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
>>                                          unsigned int *doorbell_off)
>>   {
>>          u32 inx;
>> +       struct amdgpu_doorbell_obj *kernel_doorbells = &kfd->kernel_doorbells;
>>
>>          mutex_lock(&kfd->doorbell_mutex);
>> -       inx = find_first_zero_bit(kfd->doorbell_available_index,
>> -                                       KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
>> +       inx = find_first_zero_bit(kernel_doorbells->doorbell_bitmap,
>> +                                 kernel_doorbells->size);
>>
>> -       __set_bit(inx, kfd->doorbell_available_index);
>> +       __set_bit(inx, kernel_doorbells->doorbell_bitmap);
>>          mutex_unlock(&kfd->doorbell_mutex);
>>
>>          if (inx >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
>>                  return NULL;
>>
>> -       inx *= kfd->device_info.doorbell_size / sizeof(u32);
>> -
>> -       /*
>> -        * Calculating the kernel doorbell offset using the first
>> -        * doorbell page.
>> -        */
>> -       *doorbell_off = kfd->doorbell_base_dw_offset + inx;
>> +       *doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev, kernel_doorbells->bo, inx);
>>
>>          pr_debug("Get kernel queue doorbell\n"
>>                          "     doorbell offset   == 0x%08X\n"
>> @@ -216,12 +167,12 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
>>   void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
>>   {
>>          unsigned int inx;
>> +       struct amdgpu_doorbell_obj *kernel_doorbells = &kfd->kernel_doorbells;
>>
>> -       inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr)
>> -               * sizeof(u32) / kfd->device_info.doorbell_size;
>> +       inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
>>
>>          mutex_lock(&kfd->doorbell_mutex);
>> -       __clear_bit(inx, kfd->doorbell_available_index);
>> +       __clear_bit(inx, kernel_doorbells->doorbell_bitmap);
>>          mutex_unlock(&kfd->doorbell_mutex);
>>   }
>>
>> @@ -280,7 +231,7 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>>          if (!pdd->doorbell_index) {
>>                  int r = kfd_alloc_process_doorbells(pdd->dev,
>>                                                      &pdd->doorbell_index);
>> -               if (r)
>> +               if (r < 0)
>>                          return 0;
>>          }
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 552c3ac85a13..0ed33416c35f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -346,6 +346,9 @@ struct kfd_dev {
>>
>>          /* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
>>          struct dev_pagemap pgmap;
>> +
>> +       /* Kernel doorbells for KFD device */
>> +       struct amdgpu_doorbell_obj kernel_doorbells;
>>   };
>>
>>   enum kfd_mempool {
>> --
>> 2.40.0
>>
