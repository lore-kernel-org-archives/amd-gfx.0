Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A84C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 16:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C1110E4A2;
	Tue,  8 Mar 2022 16:30:27 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2F410E4C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 16:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifIgepbBDcFtS3Po5KQDpUQ9K5JC6xKycnfe79mkx3zmz1WtPtdCwNsrAkiZc3/xND8ns2TiMXtiloOLR0fud62caTKMQBFGmwC8TRqLwzeoNUVWTslomWYh6AvaKfX2gom6dJAWy7C+7huFslKtsh8PpG/FxeM79h3ODb6zWiKSZlflw9tcySCFwkBPBk1LCSoBJDv5juzJSBnDlz19AaJksL8beBcVf7MLfN4iwHIE6DYFKwaLOcjryV8LURZ3etm1j00U+UJXLZln/FvO/jAbQ/cz6IX0/n1xrxx/W9QI2QU4mC9i0MrFxhso+ubpEtMGqnR+zjsRROb8g9856g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxjOE8raE9Fg11TRQ9LkDG+ZoNWgSzbfK8dwaVTejbU=;
 b=cwF3EB+LhKtD3v2iTPRTxg+2oiOQ8MmCT8CNIF+jqilsNyTY3gWhscZbf9FQ1biw8JadKo3lShcKg0ZeQC/vnkXld0+nDkZew+3LkVWp5wgRxdLIgBE+UGnSEvdH4UEPR4/ZgtBm5ln5F5gLRsEFX/GT0lt9ktrO1AAhSRSDmQrZg89v49IES0eryBa9JP83QiXb8PcAKkn86yjD3xZRB1xCQb5jPW7rkSe5kO80AZOlTBViA8Fza03ORzLyRYj8EaGXqlTQkBVEGg3B0tgDxuF/nMzghEwHh5/QJG7RO4Q3DqAdTfHca4wtVrP7QeRwpyX7uyZZNPrPqZSNVr8G8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxjOE8raE9Fg11TRQ9LkDG+ZoNWgSzbfK8dwaVTejbU=;
 b=mV8Gg4uIdJcrhrGGXLGlGlhI9E/l0zrR55gLkRExktU54GGLIlfRkU3FWj79wH04IKjSsEJ4Ru2nrqNlfnGy/atNzcaGfrptKq3U/MSI9h8/kdhCQnClcgqs62vggCQc5NQtaoQtizBynt0bkv/EKL2MUYw0/ceJpxVxl92nIzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB2876.namprd12.prod.outlook.com (2603:10b6:5:15d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 16:30:21 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:30:21 +0000
Message-ID: <bc293ab7-db45-2b16-aeb8-291cffef8ba4@amd.com>
Date: Tue, 8 Mar 2022 17:30:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] drm/amdgpu: add work function for GPU reset event
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <20220307162631.2496286-2-contactshashanksharma@gmail.com>
 <9de42884-d1e2-309a-e669-5132539fbd22@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <9de42884-d1e2-309a-e669-5132539fbd22@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P251CA0008.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::26) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d522e0ba-9716-46d2-6d23-08da0120f04b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2876:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB287679D89324327618A6AFAAF2099@DM6PR12MB2876.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGQfasKk8Gv3InuBw6oPtWKdoSSat8wtXWYVCRw2XBCKJomBArt8L3ra0LY4dUo4653H1jPT23vKoZY96YWzkGjICwE6bCaMC+yvm01zrwbAJ1tu1McFxHEM0cox5nMKcCOrOOB3Dn/GLybeHMLueVdYYOuY23udyglzuxqR9i6b8wb2eXuKo4QI2qElDzqj8EQJf+VfxpB9LqnilbZRxochLrsmWeuiHf3Kr86mMmbIhoDse9s6a0GprkiJU5FslyUSscoSEEaG9NuLmDZvvDYUrPfdT8hogP1NPxjLMVYf8CZhRtKAahTD0zhmV8obhi4Qe4wc72Ig9+tyFg+41ypiwMl0Fz5IZ/jUyz9fX9h2fo4ZgsNe/olP5zVjkQdUdtLPQXW+3dqEMcgUje79K4J3Vm+spHLC1KOHfonEPAw0xmTbJDERXf5UMJTRK37e453XVNciy/R2Ve6OZjFRtyubUAgGslxJmaNMgBtJNTVZ8SUvWxkHLVf+uAUmY34b1LHb7fYqgoNDbn0YsTAuG6SmcJ/xsHNdneiRV3Yk9kUBFXaSv+L2rZJhKC9aa1tfRM7CQCzO3Y+hpb3Xn03L2mwr2p6COEvSBRtqW0bWRMKnOutRILmnqeq5biL1YJj7qJoJ3XURrZeILJcTOfFzH55L3Uxxj+DoKmjknOPvoWi9X/UFEQFN/0SQRPLDqYTbLw3iAHhl91bLvYqJGd1SqX70t6aWkBE/fI1A1ORcOgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(6666004)(6512007)(6506007)(2616005)(8676002)(8936002)(2906002)(36756003)(110136005)(4326008)(5660300002)(66946007)(66476007)(66556008)(31686004)(38100700002)(186003)(316002)(6486002)(508600001)(86362001)(54906003)(31696002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d25BZWQ3U0N5ME1rbGFvbGxpcGNEcFdOeEFvYWxpRkx4Q0JSNTJGalFDNnRD?=
 =?utf-8?B?WTY2VDNnRkNDdXhSQk5IaDNkdCtrbWpObDl2a01CTkdQdWl3bzUyd1hxQVhI?=
 =?utf-8?B?eWJaRFVEUVAwdjVBNlNpZlNsTmNsZlIyWkFXREF3aU01bWk1cmRiUE5QVitt?=
 =?utf-8?B?eGlSK2RKTjdscFpqbFU3OVVyWFZlS21LT1M4a2Q0QU45cXJBRjZXOU40OU1t?=
 =?utf-8?B?RWVyeS8yZWZSeXBTU2toV1RhQTZ5RE9ib1VESE5BaFltUWdnRFMvZkxxSVk3?=
 =?utf-8?B?Q0JOQUZOMjVXMlBhQTlhSm1McmorbTB4VHFmbnVBTVVseDgyNXJTWVBLSGNY?=
 =?utf-8?B?WkJZdzNmT3hDc3BOSmsyazd6NmlvSUw0ekJBZWlkZjFhNnErSXY5SUtWTCtu?=
 =?utf-8?B?N0UwOTdYSzMxRHpiRDNsYjlmZDVxL2VJQVFYRWxhU25WaWdwK0FoN2ppQW9K?=
 =?utf-8?B?dEZYZnlFRzM3dzNJMytPMlZONkN0VGEwWGVvdzZpWjJJVEJjYXJuTjUveG5V?=
 =?utf-8?B?amN6V1NWRllBUjhiMWU4VWRjcTBHeHlkanphaHliMUt4ODJjZHpnSVdYSVE4?=
 =?utf-8?B?d09hVWFTUk5TV1pUcVV0NDM2STVHYU9XZmdwbC9xc0I4Njg4WUd1eDBNd2tZ?=
 =?utf-8?B?Y3o1WXNEM1ZVQk1OMFJtcWw4NWt2SjNseTYzazF3bHRQUVkxUkw0U0R2em9m?=
 =?utf-8?B?WUNxaVF4NXlTcUxjejh1NzJsOXVTR3NOZnhUYWtncGhaNXhjQU1Fd3pESmNL?=
 =?utf-8?B?dWFGWUFTVGlXQXlxOCs4dGRWMEplWHBLb09zTXpXdk1ZSFpEMjdPVXBvNG9R?=
 =?utf-8?B?RThKbXdKajVlTUx2UldEQW82UDg3SzlhaXczeWpSZy9YbVlwNjhBVUpIYUlG?=
 =?utf-8?B?OHI3V0ZPRkFES0dib2Zyak1XS3hHSmdtMi9mSDB3c1A3Y1RIa0lrWkYzU0Nu?=
 =?utf-8?B?bFpXNythWnY3Sm1CdENlbnpVUjNWOXpscWx1aktWUW1YY01paWJsQjVhRUtK?=
 =?utf-8?B?d0J5OTJ2RGJTR0JnWmVWY1NWUE1PT2h1Zyt3NUxsbHQyVDk2TFdhYmthTWJr?=
 =?utf-8?B?VkZwKzNlTkpTNS9zbUpENGdhRGlQMmdOZU82dXlWNUxrMHhQTnZwRXpwRDdC?=
 =?utf-8?B?ODB3K0JzRFRoWWEvMC9RQmdldnJVL0FabCtKTVZ0VkxGeUtHODlJVHJ3MFY3?=
 =?utf-8?B?aDM4TmEvWHdMSFc5K3Zjcm5hSlMxSHJRUjlIekw5d3VBMlBLbmZ2TGJIQzk3?=
 =?utf-8?B?WVNPOFRTanZiSXBxdzl1WmhkSEIxKzZ5N2RENlFnSkVMcmkxVVB6M0dDKzlh?=
 =?utf-8?B?SklldmJTbzVnMXRENjRwY0E1WWU2cmRtQmJFRnRjSjZNVlJwS3ZmOTVMT2VK?=
 =?utf-8?B?blR1ekJCODI3TWJmaTg0dVVBQ2hieCtLZ3dnS0Fpa0krOTZnaU5NYVlkLzlj?=
 =?utf-8?B?eUNqNlJxV29yZjkzazJBK1VsbVFOcE03cnFhclNLL3FJZjdpRVJwMXFmUVZl?=
 =?utf-8?B?M3FFSlhwdWVjQjYyY2d6NzFIVk15MXVOM2ZOMXlkNTBiamJJRXlRWnhZdTVS?=
 =?utf-8?B?RVZLcGpwSXhYVlV4Q0g0MG1Sa0w0Sm9BTnI0czViQURLYWVvdUdQUDJwVmky?=
 =?utf-8?B?dDMyeUZjMU45S09sZVJtRDRMNDVmaVV5bWdvcHR2bmJPQUJKUTFpZ1RiYmt3?=
 =?utf-8?B?UlVDU2lUZXp4NjQ2OFFDK1RiU0JoeGoveE9MUWp4M2hOSFVHNHQ0ZlQwM1dN?=
 =?utf-8?B?MlRvQngwaTk2cHNOTENJeGtxdTJBYlg0RWNZM0RDRG4rNUVRR0svYitpSkNI?=
 =?utf-8?B?S25GMExuamE5MWNjNURaZFloZkR1ck5pYmVWWks4QmZnazJQeWRQTzNuOWk1?=
 =?utf-8?B?YTNUZXpGZk1lNGphdEJUMVE0djZNRS9TZ041ZmRKQ2VzWE5uc2VrQjJnbFhT?=
 =?utf-8?B?L0tlbjhiR0t2M05Kc2I0emdwUWJWSGpaWWpOb2oyV29HN3lXVDBTdXJSSVhY?=
 =?utf-8?B?WTJ5a3IxdjFKSDNRUTR2TnJVTG5JMmZEN3JQYzJoVGwxQWl6N3J0K3gxM3FN?=
 =?utf-8?B?ZkNPbUMvWWlDamVvZmVCN0Urejd0TjJQNFVNS3JWQmZzeG01UjdWbWlTTWhI?=
 =?utf-8?B?eEpIM2NZeFhoaXpOaFpISzdqanJKN2FlR09kODVlR1NBa204U2tKdWNnMFJz?=
 =?utf-8?Q?XUqegyiaUsJYTE7qgDndi3o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d522e0ba-9716-46d2-6d23-08da0120f04b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:30:21.0433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGreOrdPFvmNzfiRJt3kCqnjH7wkQcZwG/QTNc3vNiM3t3dJcGAal0S6chXNCrLbVwNTAavpMQWNpT70nZGPjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2876
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
Cc: Alexander Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Andrey

On 3/8/2022 5:26 PM, Andrey Grodzovsky wrote:
> 
> On 2022-03-07 11:26, Shashank Sharma wrote:
>> From: Shashank Sharma <shashank.sharma@amd.com>
>>
>> This patch adds a work function, which will get scheduled
>> in event of a GPU reset, and will send a uevent to user with
>> some reset context infomration, like a PID and some flags.
> 
> 
> Where is the actual scheduling of the work function ? Shouldn't
> there be a patch for that too ?
> 

Yes, Amar is working on that patch, on top of these patches. They should 
be out soon. I thought it was a good idea to get quick feedback on the 
basic patches before we build something on top of it.

- Shashank

> Andrey
> 
> 
>>
>> The userspace can do some recovery and post-processing work
>> based on this event.
>>
>> V2:
>> - Changed the name of the work to gpu_reset_event_work
>>    (Christian)
>> - Added a structure to accommodate some additional information
>>    (like a PID and some flags)
>>
>> Cc: Alexander Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index d8b854fcbffa..7df219fe363f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -813,6 +813,11 @@ struct amd_powerplay {
>>   #define AMDGPU_RESET_MAGIC_NUM 64
>>   #define AMDGPU_MAX_DF_PERFMONS 4
>>   #define AMDGPU_PRODUCT_NAME_LEN 64
>> +struct amdgpu_reset_event_ctx {
>> +    uint64_t pid;
>> +    uint32_t flags;
>> +};
>> +
>>   struct amdgpu_device {
>>       struct device            *dev;
>>       struct pci_dev            *pdev;
>> @@ -1063,6 +1068,7 @@ struct amdgpu_device {
>>       int asic_reset_res;
>>       struct work_struct        xgmi_reset_work;
>> +    struct work_struct        gpu_reset_event_work;
>>       struct list_head        reset_list;
>>       long                gfx_timeout;
>> @@ -1097,6 +1103,7 @@ struct amdgpu_device {
>>       pci_channel_state_t        pci_channel_state;
>>       struct amdgpu_reset_control     *reset_cntl;
>> +    struct amdgpu_reset_event_ctx   reset_event_ctx;
>>       uint32_t                        
>> ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
>>       bool                ram_is_direct_mapped;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index ed077de426d9..c43d099da06d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -73,6 +73,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <drm/drm_drv.h>
>> +#include <drm/drm_sysfs.h>
>>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>> @@ -3277,6 +3278,23 @@ bool amdgpu_device_has_dc_support(struct 
>> amdgpu_device *adev)
>>       return amdgpu_device_asic_has_dc_support(adev->asic_type);
>>   }
>> +static void amdgpu_device_reset_event_func(struct work_struct *__work)
>> +{
>> +    struct amdgpu_device *adev = container_of(__work, struct 
>> amdgpu_device,
>> +                          gpu_reset_event_work);
>> +    struct amdgpu_reset_event_ctx *event_ctx = &adev->reset_event_ctx;
>> +
>> +    /*
>> +     * A GPU reset has happened, indicate the userspace and pass the
>> +     * following information:
>> +     *    - pid of the process involved,
>> +     *    - if the VRAM is valid or not,
>> +     *    - indicate that userspace may want to collect the ftrace event
>> +     * data from the trace event.
>> +     */
>> +    drm_sysfs_reset_event(&adev->ddev, event_ctx->pid, 
>> event_ctx->flags);
>> +}
>> +
>>   static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>>   {
>>       struct amdgpu_device *adev =
>> @@ -3525,6 +3543,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>                 amdgpu_device_delay_enable_gfx_off);
>>       INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>> +    INIT_WORK(&adev->gpu_reset_event_work, 
>> amdgpu_device_reset_event_func);
>>       adev->gfx.gfx_off_req_count = 1;
>>       adev->pm.ac_power = power_supply_is_system_supplied() > 0;
