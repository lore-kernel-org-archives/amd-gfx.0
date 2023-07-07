Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F298EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 12:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B0F10E574;
	Fri,  7 Jul 2023 12:29:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E1FA10E574
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 12:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEPo7r/U973dPKETzwFRKKctlRgGqQaJQDLC+9GiKUpCMcxN43YSNl6FAqusn3dA9gh4DNPFk4UXIZXnrZy5RBBfg1VyCOH1B21opEUSZOD+C3sVuQUiMfdYqfJ2qMxj6v/ySaNu52/CUh1QZH9dJYgmTFvV7rMZAngV7WColkz3Uu+nwwLKykphNHuQBN3AaBdVweidWr90dCj3L9oPBl5hAraB1w5JfxP6h0TeQESRvmbJ8zlK1k1Lfp6oqNkLJdTlCm22eKHxektHiDktSLVXTllLlVUDiZL/zYG5W+D5ptyG1A+xAlAlDHfXRvZUV5Y4Aq3ok/gTjeH23kTGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClFncWiCadv4AfEvcm1eLut1dKJug7Gt6Sks00WJzYc=;
 b=VOHlxZNg3CbUPAcdGWkhmpiwsO0CbEOR9JSUJY0xKRzfLEuHy+l4SZWk4VrjoTNDthOVNdlhg4WMtwJ28P3n8mC/Lqs854mp4WxwxU/exZk2LIgzIYKDvGmR09SB8LGlkSmWqWx0Ixm672l5Pvaex9xSIr+RRds0LXaur89Pcg8D4qYFKeBEe3/qhnxUxjnfasPwSBEbVPvkkC+mwyzcjMvWz2J41WTDfoZrXvsDiR7m9VXqLmsqwvzjNuEIIoZSunM4z8jPMXwaDPz3Zc5Mf1UX3DDe0pMQL69SQbAz5wF2xYgN3wht2AJMnIQpH8SUw6IW9IoI8DQoIXv0vqUPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClFncWiCadv4AfEvcm1eLut1dKJug7Gt6Sks00WJzYc=;
 b=1EwjU7qcMypHHe4mGU4d04a/f3NGuwxCKzKzNt01G+MlqPje126li13I6Q+IHQL7Pbo0AwfSfj9rHRF/Qp5ka0krLSJK+ujJZjT4YbYNMKB3cqWa0/zWJ2lwHfUOX8ohDL2Rviy6dSwgxW1babEOO4NaDj1Q6ImAhWi70Mxc8FU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 12:29:02 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0%6]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 12:29:01 +0000
Message-ID: <e06fd18e-aa43-9d1f-ec4b-4dee978ebdbf@amd.com>
Date: Fri, 7 Jul 2023 14:28:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
 <dfd92e84-c51a-82cb-5449-b3bb9c1dd3db@amd.com>
 <21d63938-fb00-35fc-6356-1176c04ccd89@amd.com>
 <06459f04-3030-cf2d-3b77-62bf3dd1f71d@amd.com>
 <86f69bc5-cca0-d1ab-4b72-03d0ab7902b5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <86f69bc5-cca0-d1ab-4b72-03d0ab7902b5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: de6ae398-6c4c-41dc-7809-08db7ee5be94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfpcFcTc+H6omqtFrcPefUaukUYJjqwt6W8cAdXvu6jK1YvpyDPni15vO0bz743sM0q8gemN72Qq8SHTOl1a0M+ksb0S3g2gcgBE7PSM1mPNBPp4+vWtWk4Red2wdwhuT9C5ceoJauxlM/BTJubwc+TCTxJxl8cXhIDLoLIslnbLbpSLOytN7y33bBeKJ2Uorot1tQQER/V6Izs9BnQGoI5H4loOuWnJdnE1rEO061ZLKHqiwbrougVPHGbe9Xq0ISAzyIGhvv9AQQO2FiwDHEkY1ZgvWwmJ8BajUGLHzJzIUEYut2TEHJEmdQjxhSnCvANNjoZSCnuW96r5yb9U3OGxr5c/hN/kSaT0EGTo5k2maYU2MxRrjYPNMwrB3BI4o1OPFZez/C92zsEF35oS+gDPg5eSo+FvD1yOlG+t6ve0YDetFdF6H/IFWV1fcmDZNz/jK5UicE+rdMHeDqAY/xz9xY5vLf0FRGXoZLQPak15XgyHKFgQ3quxYCnFmr8jMlPYowjYMs2XRH1i47loSdTEsc5+7RTb7wItRqhEQ7UsQjczOUvHLcl5/hNHZyQZr+kfPoAvYo3Zz0DsB8q88eXJ86WJWXuc+dBtwbetkde6MxhE2PfmLLX+ZQJEuqmERi/E6NUyKaY0FziwZLVRtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(6486002)(6666004)(66946007)(478600001)(41300700001)(8676002)(8936002)(4326008)(66556008)(66476007)(38100700002)(316002)(2616005)(66574015)(83380400001)(186003)(6512007)(53546011)(6506007)(31696002)(86362001)(2906002)(5660300002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUdCQWxXUXpJU0h1dHBrNHJWSjlGYUJuRWlYUTdJZ2lxRERBSXhpU1FVS0V3?=
 =?utf-8?B?aHBxRDhLMUtIQi94RVRXTHZ1Y2FSN1VyZ01ZVFozeGZyZFVwYk53MWpLRVlU?=
 =?utf-8?B?NUtwbEU4eUoyZFNRYVpmcEM2RkFKQXFUczVVSlg4Q3I1MTVVbEF2UUN6Y2J1?=
 =?utf-8?B?WXdXNFVDK1kwNHJmd3FHSGFtaTV1QTVMajFxSnZWWS9MekNoR0dYSWJOR1Ey?=
 =?utf-8?B?cnQ3ZWZwZEdvRHNlLzl4cytKbHBRY1JEamZwTmx3dGJ3MklHNURUYURZZktE?=
 =?utf-8?B?RC9oSDJJUnowT1h6U04vVGhSdk5RUkZTODB0V1d4Vm1NYjEybVp2a2RYTngv?=
 =?utf-8?B?RkdWN2YwME9oOFQrajQ0ZGRveHd1Tk9TZTFTTS9ZN2duN0I0SERhNlc3ZEtv?=
 =?utf-8?B?TWM5ZkIvd0ZKcHBIS1NPdm43UGNlMis4QUhab0FFTTNGcmF3aktTdHNsbjVV?=
 =?utf-8?B?VEtMTkNxSTBDVnpzUUN4TVBzWVNTRTBFTklNSUkvOTc4SWhnR2QvajZSdjVQ?=
 =?utf-8?B?V040NHRxanZDQWtOQ3p5dU1RL2RQdlVQY2dsQ1hZNjk4dnlEdlNmZDZpK3lz?=
 =?utf-8?B?blpGL1AyakZ3K2dOcXBuejhoOStnSUFBcUcwNDVZd0Y0cENQTHU2a3BzdzBE?=
 =?utf-8?B?eWY4NWZGUGZucEwzVlkxMnZSQ1lnR1BQOEh4TnN1cGIyK3hTSG02eDNPcVEy?=
 =?utf-8?B?SWVzeDF6cHZ3R0t3T0ZYdEJSVmxZdGQrUDNuYUNHQ3dRRldQUzFEOUIrWmtP?=
 =?utf-8?B?OTZ0VXd3ckV3T0svME1BdkhnNWN3RWhYRHA5RW10b0YzdzFXOGhnY3FoMTEw?=
 =?utf-8?B?d1JsRU8xdnN2cG9qN1ZiUHRUYW13V0RmSkM4VFBuR1B0NXNmak9SVCs1NU9l?=
 =?utf-8?B?b0xZdTFIeVlVUXk4MXcyaFBnR3Z1WG1VOHUwU1dGeS9OK096eTY3dlJJUXNv?=
 =?utf-8?B?elA1c05XLzhKM1VGYnVoN3VvY3NBUXFiQjhQcHhZZnNlTWdCajk1QmZweHUr?=
 =?utf-8?B?ZHVqNmhndjRKS0VTOEtDdWJXanpOZTZadXZyTG05YW5UTW4rRDhBc2l2OWoy?=
 =?utf-8?B?L3BvckNqc25ycE1MbzN1RHpvbGVJN3MrK1ptSVZRT1Rma2NrbElndnlCK3cr?=
 =?utf-8?B?eFo1MlBWSEF4dUV4YnRxc0xWSUZEdjNvckNxQzBBZTZtMk9sc2lVMkdPR0pm?=
 =?utf-8?B?RmRSeEZMcWJRSkwyOUNzd1ZpVURyV3RQUDNUa1hNMDI1VElhNTNTRFAveHNY?=
 =?utf-8?B?NUlyM0twcUVBZHhYOGNDamxDRFJKSityamhEVW8xdjJDbDZjbGJQVkREaGV4?=
 =?utf-8?B?a21yOXVOb2tXd2k2VXB2S1FSTkV2dlVVakJJNm1nUDBXMkZnRGM2U0JHeVh2?=
 =?utf-8?B?WDZyeWJSdnhzRFU3WUJVT0p0NnhBWDhHWEdVSGF5bDdUQUZRQnZzNC8rN0Ur?=
 =?utf-8?B?cVBNN2VDTGNqVERXb0RHK2g0TjhjV1ZXamk2TVZrSStnK1hqdGdwbHB2QUtW?=
 =?utf-8?B?VFZCNnNsb1BhTHVjdDh4cWk1aTIzZWtwb0g2SUs5RFNIa2E1NENma1I5NDNw?=
 =?utf-8?B?ZmF5SktoVnMrbmYwdHpiam5OckxaRUFxcjBsN1JtMUVDaVJmbVpMakcrQ2xw?=
 =?utf-8?B?Wi81MXhmOGlGS2o5Nk5Kd1FJeHltMFB0N2wzRzZjVlB4SjJpUlRxTlZrTGZz?=
 =?utf-8?B?VTF4VW9SYUlXL01GVFFabmJhY2NKRFk2RGJiYnhuamMwRHVvMzJOQVlzNlZU?=
 =?utf-8?B?N3lrUnJHaUF5a01XMHQ5SXA1RzllOW1MRkxaUGxqUmllbUNOSUVtVHgwd213?=
 =?utf-8?B?ZzBpR1krMGhvSUNVN05tYlYveTdpQ3YvR0Z4c3hQV3MxLzdjOFFKampkZHdE?=
 =?utf-8?B?S1MxTmMyeTU4TjFQSWViY25wNm5Ga1FrMU84eGpoT0RpdXhMbHlKcWxZZFRn?=
 =?utf-8?B?dlBrb1cvUlFTek1MbVNtTWFXelhDUVlTai9uc0ZiQUlkWjJSL0dIY2RtR0ox?=
 =?utf-8?B?QUN5TEw5YXVCQnJxV2ZNREF3NThXeUx5OURIK1hkRHR4SW9XSmtidjNzZDBr?=
 =?utf-8?B?Y3lUU2NjYXFjTzh6dTh5bkQ4dlE4cDVBa2QxbjJ6QVQ4ZDloRHNPMUltdEdj?=
 =?utf-8?B?NG1yU0NiazlCTnVkSlVPdjJPblNuenh1elNUWWZILzB2cFl1R2grcFNOellW?=
 =?utf-8?Q?BR1hIByDZhMgApHRAoxMPYVyJy2g32BR8qkSnx2kG42I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6ae398-6c4c-41dc-7809-08db7ee5be94
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 12:29:01.5509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AAjv0pjzI+AsD7xssvkkY+ObG4wNWing7cWJLUnehDTGpLBjmEUsWYKCWnqQcQB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 07.07.23 um 12:02 schrieb Shashank Sharma:
>
> On 07/07/2023 10:37, Christian König wrote:
>> Am 07.07.23 um 09:46 schrieb Shashank Sharma:
>>>
>>> On 07/07/2023 09:24, Christian König wrote:
>>>>
>>>>
>>>> Am 06.07.23 um 14:35 schrieb Shashank Sharma:
>>>>> A Memory queue descriptor (MQD) of a userqueue defines it in
>>>>> the hw's context. As MQD format can vary between different
>>>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>>>>
>>>>> This patch:
>>>>> - Introduces MQD handler functions for the usermode queues.
>>>>> - Adds new functions to create and destroy userqueue MQD for
>>>>>    GFX-GEN-11 IP
>>>>>
>>>>> V1: Worked on review comments from Alex:
>>>>>      - Make MQD functions GEN and IP specific
>>>>>
>>>>> V2: Worked on review comments from Alex:
>>>>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>>>>      - Formatting and arrangement of code
>>>>>
>>>>> V3:
>>>>>      - Integration with doorbell manager
>>>>>
>>>>> V4: Review comments addressed:
>>>>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>>>>      - Align name of structure members (Luben)
>>>>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>>>>        message (Luben)
>>>>> V5:
>>>>>     - No need to reserve the bo for MQD (Christian).
>>>>>     - Some more changes to support IP specific MQD creation.
>>>>>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 
>>>>> +++++++++++++++++++
>>>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>>>>   3 files changed, 96 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>> index e37b5da5a0d0..bb774144c372 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device 
>>>>> *dev, void *data,
>>>>>       return r;
>>>>>   }
>>>>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>>>> +
>>>>> +static void
>>>>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>>>>> +{
>>>>> +    int maj;
>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>>> +
>>>>> +    /* We support usermode queue only for GFX V11 as of now */
>>>>> +    maj = IP_VERSION_MAJ(version);
>>>>> +    if (maj == 11)
>>>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = 
>>>>> &userq_gfx_v11_funcs;
>>>>> +}
>>>>> +
>>>>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>>>>> struct amdgpu_device *adev)
>>>>>   {
>>>>>       mutex_init(&userq_mgr->userq_mutex);
>>>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>>>       userq_mgr->adev = adev;
>>>>>   +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>>>>       return 0;
>>>>>   }
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> index c4940b6ea1c4..e76e1b86b434 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> @@ -30,6 +30,7 @@
>>>>>   #include "amdgpu_psp.h"
>>>>>   #include "amdgpu_smu.h"
>>>>>   #include "amdgpu_atomfirmware.h"
>>>>> +#include "amdgpu_userqueue.h"
>>>>>   #include "imu_v11_0.h"
>>>>>   #include "soc21.h"
>>>>>   #include "nvd.h"
>>>>> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version 
>>>>> gfx_v11_0_ip_block =
>>>>>       .rev = 0,
>>>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>>>   };
>>>>> +
>>>>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr 
>>>>> *uq_mgr,
>>>>> +                      struct drm_amdgpu_userq_in *args_in,
>>>>> +                      struct amdgpu_usermode_queue *queue)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>> +    struct amdgpu_mqd *mqd_gfx_generic = 
>>>>> &adev->mqds[AMDGPU_HW_IP_GFX];
>>>>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>>>>> +    struct amdgpu_mqd_prop userq_props;
>>>>> +    int r;
>>>>> +
>>>>> +    /* Incoming MQD parameters from userspace to be saved here */
>>>>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>>>>> +
>>>>> +    /* Structure to initialize MQD for userqueue using generic 
>>>>> MQD init function */
>>>>> +    memset(&userq_props, 0, sizeof(userq_props));
>>>>> +
>>>>> +    if (args_in->mqd_size != sizeof(struct 
>>>>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>>>>> +        DRM_ERROR("MQD size mismatch\n");
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), 
>>>>> args_in->mqd_size)) {
>>>>> +        DRM_ERROR("Failed to get user MQD\n");
>>>>> +        return -EFAULT;
>>>>> +    }
>>>>
>>>> Sorry, I've just seen that now. Please don't have a 
>>>> copy_from_user() in the backend!
>>>>
>>>> This is pure front end stuff which we shouldn't do in hw generation 
>>>> specific code.
>>>>
>>> This is a bit difficult to achieve, as you know:
>>>
>>> - the whole reason we moved to ptr/size based approach from 
>>> fix-mqd-structure approach is so that we can support multiple MQD 
>>> structures using the same UAPI.
>>>
>>> - which means that in file amdgpu_userqueue.c layer (say front-end) 
>>> I do not know what is the right size of MQD, its independent of IP.
>>>
>>> - the correct size of MQD can only be known in IP specific functions 
>>> which are in gfx_v11.c (back end).
>>>
>>> - I may be able to achieve it by adding a new fptr get_mqd_size() 
>>> which can return the right MQD size for me from backend IP function, 
>>> and then I can move this copy from user to front-end. Does it sound 
>>> like a good idea to you ?
>>
>> Just use memdup_user() in the frontend. Allocating structures which 
>> are copied from userspace on the stack is usually a bad idea as well.
>>
>> Then pass in the kernel ptr and size as argument here and validate if 
>> what userspace gave us is correct.
>>
> This can still allow the user to pass invalid size (0 or too big), how 
> to prevent that ? I can still add a check for 0 size, but how about a 
> very big but invalid size for MQD ?

memdup_user() already takes care of that (has a maximum of 2MiB IIRC) 
and the hw specific function should still validate the size to filter 
out 0 and other invalid values.

Christian.

>
> - Shashank
>
>> Regards,
>> Christian.
>>
>>>
>>> - Shashank
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +
>>>>> +    /* Create BO for actual Userqueue MQD now */
>>>>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, 
>>>>> PAGE_SIZE,
>>>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>>>> +                    &queue->mqd.obj,
>>>>> +                    &queue->mqd.gpu_addr,
>>>>> +                    &queue->mqd.cpu_ptr);
>>>>> +    if (r) {
>>>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>>>> +        return -ENOMEM;
>>>>> +    }
>>>>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>>>>> +
>>>>> +    /* Initialize the MQD BO with user given values */
>>>>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>>>>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>>>>> +    userq_props.queue_size = mqd_user.queue_size;
>>>>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>>>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>>>> +    userq_props.use_doorbell = true;
>>>>> +
>>>>> +    r = mqd_gfx_generic->init_mqd(adev, (void 
>>>>> *)queue->mqd.cpu_ptr, &userq_props);
>>>>> +    if (r) {
>>>>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>>>>> +        goto free_mqd;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +
>>>>> +free_mqd:
>>>>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, 
>>>>> &queue->mqd.cpu_ptr);
>>>>> +    return r;
>>>>> +}
>>>>> +
>>>>> +static void
>>>>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, 
>>>>> struct amdgpu_usermode_queue *queue)
>>>>> +{
>>>>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>>>>> +
>>>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>>>> +}
>>>>> +
>>>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>>>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>>>>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>>>>> +};
>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>> index 55ed6512a565..240f92796f00 100644
>>>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>> @@ -29,6 +29,12 @@
>>>>>     struct amdgpu_mqd_prop;
>>>>>   +struct amdgpu_userq_obj {
>>>>> +    void         *cpu_ptr;
>>>>> +    uint64_t     gpu_addr;
>>>>> +    struct amdgpu_bo *obj;
>>>>> +};
>>>>> +
>>>>>   struct amdgpu_usermode_queue {
>>>>>       int            queue_type;
>>>>>       uint64_t        doorbell_handle;
>>>>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>>>>       struct amdgpu_mqd_prop    *userq_prop;
>>>>>       struct amdgpu_userq_mgr *userq_mgr;
>>>>>       struct amdgpu_vm    *vm;
>>>>> +    struct amdgpu_userq_obj mqd;
>>>>>   };
>>>>>     struct amdgpu_userq_funcs {
>>>>
>>

