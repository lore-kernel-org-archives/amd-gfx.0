Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3DEEDE98F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 08:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F0310E518;
	Thu, 14 Sep 2023 08:25:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2EA10E518
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 08:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/iIcX+il4niqh6FLCIlN4giXipCYogS9Tj5CVzSDEq329CS0gBjndFyTeHCGUHC9Wd00zAG7jzAtBObGk7+517Uw4wGyxfHxifAOE4hiFPAiG9Q5t+43ed0hHiYcyRi+VDtBvVgRdoUeopBu1cao1QGRarvRL5/sdp9sbHaB9xEOs9SxcIjZ9j00rq0prdnAoSTnpZjBaR35COeIewxwCJJTyzYPDJhu6wYBjizeM6VsOIvYaSYObFpKllSeFBg9CHypzX17GehiaOujrIekc0GlJdMMCOqgM8kz4RgQtsFuznli0R5WYV4QV0rB8W1b80HoEYCmJo0rBbGdy8inA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O77V8xvTfHyJc3Pj7DvH20bmuDWo3lPDYLal3Y8/+K8=;
 b=GW5LOf7hyI2gT0HJ2ZE6e86vZzVQAkqEkx71fDRVa1RNi2D6hp2u/C6NoWVCfmtEuBa486YX7BKzrcp0vBSGKVpSGSVDjJmo2x4eJN5wMFoFZu1FbWcBHGcTQFvqwxqq33+aDkEetrEUpIiOGJoiklu/0bK3FPc6mq1lmzrW9HWLSw/6uDh/9aK3Xte/Yh0XutRd0WRse/w5Dvg2ZwrTVyufHY4VVQn4D2UubzFSwYMFF9LyyDrJLJ2uyHxOG9yAr9Qc8EWaqwTwxNr2p66VqiNC6CWmu0RWig7672b3YKDM9m9Td2+YlJJdEolzw6sRXJ2dmrSzFCmrBGjJxPW3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O77V8xvTfHyJc3Pj7DvH20bmuDWo3lPDYLal3Y8/+K8=;
 b=r6cZULl35PetzGVSEbIzi6t206S+MAP5QsaJDyx3lz3nThiqhvXGkKkbyXo+Ajm+O9BGNG+fKNW6Tf/KMCXXq3vMNNvmxCGzOBuE0ZggI+JtirH5td42/QA6TPBcM7uuALqNUWSx5kG32VpcbbEIzFSzAVGtjfeA0SoBhSNN4Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 08:25:02 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 08:25:02 +0000
Message-ID: <009e90dd-2cf2-9838-a8c3-f18cbbd29b3d@amd.com>
Date: Thu, 14 Sep 2023 10:24:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 4/9] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-5-shashank.sharma@amd.com>
 <6d579492-1555-4dba-68c6-130266c011a1@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <6d579492-1555-4dba-68c6-130266c011a1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::18) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: baa7e06b-3018-4d39-f2c1-08dbb4fc1744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdEaM11Wssns4PuEbdjKuVYgY97m3q4czVdvRouGLufto3zSnvKqKYvrc0UWuVk+SHSnJTC1Najq7KGb6uwbRek6BWqlf2+/IbB8dT+V22FZDW1aOOBXVbNWNFlInAPK0bHKQLubVC98jKxL0BxHO2YB9s/I0M6UXx9RmlON2nQPAfb2Rzo7Wpv1dJVzePzxdnolNVQmU0cr0SXXRhJzzDHDXgT7l8E8t6zIYr3eWhIHp99esUjcFKLYHouuSqPKjVQTzB4rzyTAvKAqc9FBPnB2V5MopKjLPdm6FmRY8A/A8ln42oVdZVA4Txf4qBsqEgu2kiyODrlQO00/LGzb55XGnakilJIsVx9lvEZVZ9+4I8WTrnyz6in6ONNR52Ujo/yim2TvF91EdbSdhbetB7NkEp3QVmlG1gn6oa+Uzy+7Gn8fhjl3mMbZ6ziPIGDsNOOW8oAGhViQP67bA2jlonQUQoaRIZOAw4ohJ8WVRdPe+hYq9nkN4GCUO+TNIVtbKhxyrbgqJ0dLVuJUZd17hF2GJyZe0UdrYS8kOdSdtkyzppTPVc+B39/wDyggvFRgkQulLEEIdiL9ihaXB0+jsR+JTS46c7Zw0GJ5nY7FAVxdNyROxgPRq+whYH+Vu+lkBzYTvVzPmx16m493KAgBSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(186009)(1800799009)(451199024)(83380400001)(36756003)(2616005)(26005)(41300700001)(6506007)(53546011)(6486002)(31696002)(6512007)(86362001)(31686004)(6666004)(2906002)(4326008)(8936002)(8676002)(66556008)(44832011)(66476007)(66946007)(316002)(478600001)(38100700002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNrdThMME1iZ0phcjYxRHBtbWlnSmhSbVQ4OVdHVjVYbWIrcEowYmxvOGZ4?=
 =?utf-8?B?Zy85VlUyNUl2SkZsRk9uU05UN2JqUWE5WWVKcmxDY1R4V0JHM1JpYThxNTBJ?=
 =?utf-8?B?bWRQMmVrNFpnM3U5a0EzSXI3YkpkaURCQVJETnRxbHQ5THdUcjZPenViY2ox?=
 =?utf-8?B?MWcwUmF4RG81VWVRWWJMSzFIQXJIejJUZ1AyWnBKMVNtSHoyTU5ocG1MNXpo?=
 =?utf-8?B?Y3NGTkdXZnN5N2xtSk1sKzVzLzJFUHFwc0EzM2RGdjZoY3d1MXFNOG1JR3lu?=
 =?utf-8?B?bmVGMnUvbjVSUGVOd25OQU9hRU1WaE5pbUdvRzJRTm5RS1liaFdJRFVkSHZO?=
 =?utf-8?B?Um4vdlRleG41V1dQNGNHNWkyRVZSclp3OVpuMU82MGJvOHMyTUdiNDI0UGhF?=
 =?utf-8?B?elBnL21KQUhzT2lDb25waUFiTlFJdDBPUXFVdVBJSFZnUFJFY2JkbjB5cmZ5?=
 =?utf-8?B?QVdYUjlmWGhIN0EzcHcxWHNhelU3c2h2L3lFOTJIN01QSlNaeG96TEZ4WmdW?=
 =?utf-8?B?UDRtUWQ3a1ZOYXo0Z1hBOW94SDdKTWJlRS96RHU4NEQ3dktscnNLaUJOTndG?=
 =?utf-8?B?d2dBNDlNTE1hUXg4QlpPbGdsQVgrdnF2dnRrcmFGRkZKaXl5eEM2RmdlMXU3?=
 =?utf-8?B?SFNSZFI1bkx4MnB4aVNhVm5ZRE5ZS1pueXl6ZFkySGMveEZnMi94amY5Nm9t?=
 =?utf-8?B?cHpGVEVWZzBOQ0JOUkt6YUsySTJqYVR0UHFVZDk0bld3dDVFeDZXWDB0alps?=
 =?utf-8?B?MjllTTZ1VS9vdTByemNPd1hHNXNnWDZSamRTVmdWdThxMzJvcmpIRC9kVm8y?=
 =?utf-8?B?VHpKTHV4R3VkSENCWVdrUm5rcWJTZVkxZUpGU2ZHaGV6aW5uM2lsdEFSdWtj?=
 =?utf-8?B?c3ZRQzhwVkRUV1VLamVoNzNGVjdGLzc1K3ZySHRlUlA2T0F0UG5KUWpFZnJK?=
 =?utf-8?B?a1VNMEZEcjBLZHRQUlBJU1E0N1h1Vm5aVFFJVzl4bXM0dFZtNWg5eStlblQx?=
 =?utf-8?B?blo1bHU3cmdXaHl6ZzVEOEliVWdyWXBVZlQ2UWFadUVrelhKbStmZVR6aTVE?=
 =?utf-8?B?aThhSGQxckJSQW01Y1RSU3hDckhVd0JINXFWNlovL3d0QldUR2hIZnhqRGpS?=
 =?utf-8?B?SnRFUkFKbFJVaXk5WTdLemE4bjZGOTJUcmhBK3JQVVlQODMwc202T2tyS09Q?=
 =?utf-8?B?OGl5a3dRb3pkTFFubHB0aGF5dVlwZkZyb2IvQ2JYSVN6VHFkV25UeG1hQXI5?=
 =?utf-8?B?cG9Lc0k4Q3Nyb2hYMEl4NklqSWpHQjF6V2sxWUhYK1d0NG5MT2dsZnl2em0w?=
 =?utf-8?B?dkdUNjBBOU1jZDZsVmFwVXNEcFhGdjlpc0tGK3IyV1gvYnNiN1F5UHF2eDNM?=
 =?utf-8?B?eXREUHhYQWJtQ3dwS0xPcjVqRnp4cjZHbE5Td0pDYUxCWnVWaU05dUl5VlZ0?=
 =?utf-8?B?ZGlEUVprd253YWRUMUdRcExBMTN6aEwvL1ZJcGk1YXFKdW9jNGNPNFg1SzhH?=
 =?utf-8?B?ZEtiR2c5dmhQSlZSS2l4WSsySnpRNVNhU29qcDZ3bk50L0xKcEhaWTNBMFBE?=
 =?utf-8?B?OC9BTmNuZ3NQU2ZHYWdLeHlpTDFlcXlyNXVVTHRCZ3l3NmVpU2dkbXNXb0tn?=
 =?utf-8?B?WitSaUl6UHd4OEVNRVRadE53aVZaa0pUNGhtTnk3WG1xSFJhUVBrL0VnWkJj?=
 =?utf-8?B?dElJMVVUTWQxdXZmZXM0QS9FYWJjRGdiRGx4bW1vWndwSDBRTDRDQ2NBbncv?=
 =?utf-8?B?VENLeWZUQWlaQTlDdEVENG14d2F1UEFGb29IMFdLdURHTUdVV1hObGlrWERp?=
 =?utf-8?B?SEZrbWt1NFl1b0dEOTU5Zy9QN0EyTDlMY0RkYmcrSlVHb2hMSmNIVytGRlJh?=
 =?utf-8?B?dGFKZVBWQStvUVdSWmw3clBQRTRnZUdvdnh2bjVWTVB6OWF5T1Uyd3JmeXk3?=
 =?utf-8?B?WFVKOU5mQkxlc1NKYmhHRmNvekRnRWhqczBjaXB0TFhEYmFoaFhtZWI3NFNq?=
 =?utf-8?B?TThwNnZPWVhQSFRDZTBrYStJVlF0Vm9pNktvTGZrMjVmZURMUnFjemx1SVlV?=
 =?utf-8?B?dS94OXpPbkFlamVjL21DNFVrVzlaK3d6ZUlXanhxODZicjZQZEpOaWk1RU04?=
 =?utf-8?Q?lEvI/Rrz10/WVGAYeA2RazKOe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa7e06b-3018-4d39-f2c1-08dbb4fc1744
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 08:25:02.0929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lNe4qeRekbJFuzO1TJy0yN0e2uLf/dTZ9Ek/S4vobF6X1mTQEZv87WZk8Pd/Bm8VoJVEqtmiBmvGkgggsMfQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
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


On 14/09/2023 09:45, Christian König wrote:
> Am 08.09.23 um 18:04 schrieb Shashank Sharma:
>> A Memory queue descriptor (MQD) of a userqueue defines it in
>> the hw's context. As MQD format can vary between different
>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>
>> This patch:
>> - Introduces MQD handler functions for the usermode queues.
>> - Adds new functions to create and destroy userqueue MQD for
>>    GFX-GEN-11 IP
>>
>> V1: Worked on review comments from Alex:
>>      - Make MQD functions GEN and IP specific
>>
>> V2: Worked on review comments from Alex:
>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>      - Formatting and arrangement of code
>>
>> V3:
>>      - Integration with doorbell manager
>>
>> V4: Review comments addressed:
>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>      - Align name of structure members (Luben)
>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>        message (Luben)
>> V5:
>>     - No need to reserve the bo for MQD (Christian).
>>     - Some more changes to support IP specific MQD creation.
>>
>> V6:
>>     - Add a comment reminding us to replace the 
>> amdgpu_bo_create_kernel()
>>       calls while creating MQD object to amdgpu_bo_create() once 
>> eviction
>>       fences are ready (Christian).
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 77 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>   3 files changed, 100 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 44769423ba30..03fc8e89eafb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -140,12 +140,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev, 
>> void *data,
>>       return r;
>>   }
>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>> +
>> +static void
>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +    int maj;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>> +
>> +    /* We support usermode queue only for GFX V11 as of now */
>> +    maj = IP_VERSION_MAJ(version);
>> +    if (maj == 11)
>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>> +}
>
> That belongs into gfx_v11.c and not here.


Agree,

>
>> +
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>> struct amdgpu_device *adev)
>>   {
>>       mutex_init(&userq_mgr->userq_mutex);
>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>       userq_mgr->adev = adev;
>>   +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 0451533ddde4..6760abda08df 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -30,6 +30,7 @@
>>   #include "amdgpu_psp.h"
>>   #include "amdgpu_smu.h"
>>   #include "amdgpu_atomfirmware.h"
>> +#include "amdgpu_userqueue.h"
>>   #include "imu_v11_0.h"
>>   #include "soc21.h"
>>   #include "nvd.h"
>> @@ -6422,3 +6423,79 @@ const struct amdgpu_ip_block_version 
>> gfx_v11_0_ip_block =
>>       .rev = 0,
>>       .funcs = &gfx_v11_0_ip_funcs,
>>   };
>> +
>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>> +                      struct drm_amdgpu_userq_in *args_in,
>> +                      struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct amdgpu_mqd *mqd_gfx_generic = &adev->mqds[AMDGPU_HW_IP_GFX];
>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>> +    struct amdgpu_mqd_prop userq_props;
>> +    int r;
>> +
>> +    /* Incoming MQD parameters from userspace to be saved here */
>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>> +
>> +    /* Structure to initialize MQD for userqueue using generic MQD 
>> init function */
>> +    memset(&userq_props, 0, sizeof(userq_props));
>> +
>> +    if (args_in->mqd_size != sizeof(struct 
>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>> +        DRM_ERROR("MQD size mismatch\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), 
>> args_in->mqd_size)) {
>> +        DRM_ERROR("Failed to get user MQD\n");
>> +        return -EFAULT;
>> +    }
>> +
>> +    /*
>> +     * Create BO for actual Userqueue MQD now
>> +     * Todo: replace the calls to bo_create_kernel() with 
>> bo_create() and use
>> +     * implicit pinning for the MQD buffers.
>
> Well not implicit pinning, but rather fencing of the BO.
>
Noted.

- Shashank


> Regards,
> Christian.
>
>> +     */
>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, 
>> PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_GTT,
>> +                    &queue->mqd.obj,
>> +                    &queue->mqd.gpu_addr,
>> +                    &queue->mqd.cpu_ptr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>> +        return -ENOMEM;
>> +    }
>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>> +
>> +    /* Initialize the MQD BO with user given values */
>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>> +    userq_props.queue_size = mqd_user.queue_size;
>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>> +    userq_props.use_doorbell = true;
>> +
>> +    r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, 
>> &userq_props);
>> +    if (r) {
>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>> +        goto free_mqd;
>> +    }
>> +
>> +    return 0;
>> +
>> +free_mqd:
>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, 
>> &queue->mqd.cpu_ptr);
>> +    return r;
>> +}
>> +
>> +static void
>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>> +
>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>> +}
>> +
>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>> +};
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 55ed6512a565..240f92796f00 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -29,6 +29,12 @@
>>     struct amdgpu_mqd_prop;
>>   +struct amdgpu_userq_obj {
>> +    void         *cpu_ptr;
>> +    uint64_t     gpu_addr;
>> +    struct amdgpu_bo *obj;
>> +};
>> +
>>   struct amdgpu_usermode_queue {
>>       int            queue_type;
>>       uint64_t        doorbell_handle;
>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>       struct amdgpu_mqd_prop    *userq_prop;
>>       struct amdgpu_userq_mgr *userq_mgr;
>>       struct amdgpu_vm    *vm;
>> +    struct amdgpu_userq_obj mqd;
>>   };
>>     struct amdgpu_userq_funcs {
>
