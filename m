Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FEAC77B6C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 10:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F9810EABC;
	Thu, 13 Apr 2023 10:51:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B0410EABC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 10:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2ewCtccR9vY+4Nbieww/96V2W4pSF9VuC7OTXApNcS3IIX781EDSoVdqr3HWyGhLSQAVBdfrzYiHpSmQ/0LlxW97B57RTNs/29Kr5BV3x03ZpYNf5SMTRbbgdynjo1J6nAlRzSVJ8TIhzd1Vl9o5d5qBduFwvdsh3APPkTT48PtdzOM9sBesflzaJnfsx90Jk5Ym2EBXUuMQ1YhwD2C5HMM0vocPd2CqNeJU8oTogtpvieg7XENe2Oc1ng7j4zQiZ9bu24Ydd+Sqs9CAeNwJV5oFlsywDc78cmJnO6Xxe/KhSRiSZ+Q8ILvXsdKien4OEaPfCS0rxMd5cQ7ecIqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKuw0zQeK2qzYl7xYc5JgTAvSviMT/3KecvUj59KAo0=;
 b=dm0gCrVtXpOwiH7fZhEafpGk4OhehqFw+aseyWMKKHFU5p0roGuwpeH7kZo2go/09T2Qvk0eNg9U0SBs9nUiKDnUmAM4Gp5H+fEQTAY4wKCVVLrwGpkYJWfiJmQcFi3gHEXCzyOMQqvKhOR89thucusWZ1U9j+R8mehmzFsQqESHzpjEZBOADOUu79ixZ6/J84zioGnlcg7nsdrYnWGt7daJ4Exeld7BmdBAXWykpOGXxW6qWWF1L2xbJpFS/9gGgU7TsJpuKIUEaxwLQpf84RQDZKXdLEqxnwGpMxFa7Nn9K1xtJbFniw8taDd0Zqk71DrPdQFSv8Yv0xUDZ4Uvgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKuw0zQeK2qzYl7xYc5JgTAvSviMT/3KecvUj59KAo0=;
 b=aZa0+v52Th1rz9LmqHH5UvaUEm2jvBOy86uoENWgQ0jP+UMzfww1acJNrGXCPsNxOve+34+olVAqTtTjOmAMCXVzZCQaw5xTMBP9hcIFc3qS+Nj+InsB4rt+gGnR2C1KCtqT/0gEvbmrDG3MH3tjPjt8P8l1Ci4SdkXT28kTJ5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 10:51:29 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e208:1fec:a14e:eadb]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e208:1fec:a14e:eadb%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 10:51:29 +0000
Message-ID: <b92154c2-292e-8bc0-cdd3-dffc32802bed@amd.com>
Date: Thu, 13 Apr 2023 12:51:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 01/12] drm/amdgpu: create a new file for doorbell
 manager
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-2-shashank.sharma@amd.com>
 <89667a39-c514-f887-8a43-6685d954ddf4@amd.com>
In-Reply-To: <89667a39-c514-f887-8a43-6685d954ddf4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::7) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 6337cf37-bf7b-48f3-1457-08db3c0d08f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Glm6fiKEPObqBMTqyzELP3jUZevGBEMnTOHEZii2LESp0CBmys1w0Syd5Tn/344NyTlAISDWoevI1j3f1kVwNB6ZzeV4pPAFulx8Fc/QCvn9bFQaTX0UB2KUlgLeJvoVSQy9f1VFo75kAw3LCqfKWydKYTXmlyp+ICpczDarUO9xR8l3UvY1AI+5RBiRqAuWdI3kTXXkEOZ5aSzO8RbACinT27NYzE7BzULxUSXSlaz9fhNMPtAu6EAP9xNpr5RzcNUAUEs+HFcIwdZGVeJ5z78KvjT8uavhpLSl4IW1qpJS9UZM79jf8yYdOeQd69L2y0m5wcop1SeeuTNUnntM6jWF7h08vEjMObJ8vFuueRLAEhLXZWdLNZDaFVnY0CStFP/t+aEEMf/AarQlWHITkeh2msH1kVdBiWS5ZUbXG/OUqMcUCuOXxYMMQ7/u5bLSnYJNZby5yZbXW2kThPWRwNUFaqTc7TwW+n+dY4UvWcjfBsKWVcixMsYcwL37z/EH0Bg5rqtPn35YZy5HmN+BQHI02ogMu9OGGlmozBvesJmcHIT0fkUj7l7ziX2J6F8T6Z509HHmntBXgPMg7t8jlVRbA1FtGCZ3GQ4qmCT0Xr/XPG5sUFFuVqCUbI39QCtXpGcYjbs5sg712yDA2oEQVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(6666004)(6486002)(66476007)(66556008)(66946007)(4326008)(36756003)(30864003)(2906002)(31696002)(86362001)(41300700001)(5660300002)(8676002)(8936002)(316002)(38100700002)(478600001)(6512007)(6506007)(26005)(31686004)(2616005)(186003)(66899021)(83380400001)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEYyejkzdXRwN1VwQlUyVWY3RG5hNVZZYWtwMWFoamJET2ZFdWp1MlR0dHh6?=
 =?utf-8?B?b21tMGJzVjZ4TXRKY1JXSE1aT0ROc0JkZnp5ejk1cnJCQWxtb3FjOVR1YnFI?=
 =?utf-8?B?eFNFOEdTSmNFaGQxTUpyZXl3NE9Va0ZoV0lLNzQzT3JGM0N3OUhlSGc1bW1p?=
 =?utf-8?B?aGhjZ0ZYVy9WaUZNM3poS092YXppOUI1MDQvWWNhYk1pcDJ3SlBWZm0xWjBL?=
 =?utf-8?B?cHU5VUhHYm9KclRtYmQ2bFZ4aTd2eHFqSEVXY2Rib2dudnpYOFVwN1ltclJr?=
 =?utf-8?B?L1JnQ0VxMGg5djk3VDdMeUpWYUNVL0pES3NiTHkrTjBCMUFBSzdsSnVJODhX?=
 =?utf-8?B?Z2NUQjFOQWM0SWJLSThESjBPdW0ySCtLTGdmYzdGT0g5bXhhV0ovNSt4Smp3?=
 =?utf-8?B?aFVtWTVadThtZ0xvOXF0T2FrakpYUytHRCt3VElpTjFSN3dyMWhBOHZMQlNi?=
 =?utf-8?B?cnY3WkdOVDB5VHhzNHlSdWN2T2xVb2E2V2lPRnJPOXNHamJ5RzFqcHZzL1VI?=
 =?utf-8?B?S01DNVpUR0FJWi81ckg2WWUzMG1CTVlIeDVISGhYTmg1by84UnNHMDRZUlFr?=
 =?utf-8?B?WUFMSktDY2NqTTBjWHJMMjdjVWRWSEdzOGdaQTJYeEE1MFpIaTg3NXhJclE4?=
 =?utf-8?B?OWxYdzYrZ1p3bzJFcVZtNzg4L2JLd1RTVHRZc3NHN3hzbTl1TEpWMnlORDF1?=
 =?utf-8?B?eXNaL3pkZEZxNlMyUmdFejJDd2pyajU2dHRFOTl5dlppdUFBMmpEK0d3NzZ4?=
 =?utf-8?B?aVZ3NDhSN1FXWk40a0tVQmxrSlNpZVNmSkRTb2paeTBDWXJ3b0hEZ2hkQitn?=
 =?utf-8?B?SjlEQm9OR25XaThYY2U1eGxWRHdBMHRmNmZzbCtBNm02UVJZN2FmYWQ3WlNw?=
 =?utf-8?B?cU9yeUJkTHFrYXFEbUVxdjJKRXlZUis5MGg3SGE3TUpLclBuQktOWFpHNUd5?=
 =?utf-8?B?THJsWkFVa2xJVDVrbTJ2c2lNSDZnNHllR2RsMmlYaGhmcVJlZWJva29KeEEy?=
 =?utf-8?B?ellBU0d6bGIvN3FJZms5WHVtRnB4Q2YzMzBSYlRLOWJCV0d1TGNMRHoraGJM?=
 =?utf-8?B?YlpCU0pIa2F2MmNFWGdOcmNkcmJscDBleG1nZnFqN1Z3cGRodUtuTnBOUEdZ?=
 =?utf-8?B?M0ErL1JVa1I5d3dZRDRvVE5DMDFwSFVBTS84bzd3MmM1akZXOFBKajN5Nzdv?=
 =?utf-8?B?YTlibWIySG9INjFvOFNSTEU5elBXYVppZ2FhQkFQaGpXVlgyZGFoaXJQbHlx?=
 =?utf-8?B?OTJrcmV0VkFybjR0L0pyTWhEZGt2R1M0bi9KSTJ6eGVZaGVBN2taZWtvZXl6?=
 =?utf-8?B?SC9UdGwraWVxMldBd0srVXhtQlErOERRYUVSSnQvQ21Fc1d0d2QvbmZSMTVk?=
 =?utf-8?B?V2Z3M3VLbXBFbU1CNDZQSFVvQ2Vzd3p5STlGS3dmSngxMnRVS1RyTmQ5Ymxa?=
 =?utf-8?B?RGVzOE5TaXRERXBuckphV0hDQ1V1OGY1cEhRaVlKblI2bkNSMFBXVSsxY0hO?=
 =?utf-8?B?TS81NXN5bE5LNjdnYURacU1EdWY0NGRBRnFGalpqelJ0a05Kb1pROFBpQncw?=
 =?utf-8?B?RFVIcDVjUzJ6OU40RVA2Vlc4TGtNTUt4ODVVVzJqUXlIR1FQd3lIQUxLWFN0?=
 =?utf-8?B?Z2lPbjBoTndTR2dHQlJqOGp1djZKQlBtdmxVSWoyZWsydkc0Qko4OVNDYU45?=
 =?utf-8?B?Wkw5TkRUblZ5ZWdONjlPT2dDMS9JbkJJbnoxNmk2ZGdzUWRTbVhKMkk2YWRj?=
 =?utf-8?B?bU1tRm5KM1d4OFZGajZQRGdDZGp5eVlVemorcWg1dnZkenBTK01WOGdTY2Ra?=
 =?utf-8?B?NStZcVdBWnJ0N01tZEhMK0Fpbjd4Y0x2M0lDd3lGOW1HT2k5WWlBdm85MCti?=
 =?utf-8?B?L1F5SEdHdi9ISWlBNmNUY2R4WWNSMGhtZm1WdURpa2RQeVhCVGtnU2dOdzNZ?=
 =?utf-8?B?Y3BUenBWbDFQQTJFMjNTcEwzdEI0dVZnWWt3Y3FsRXh1cDJzZGxHNGVFNEZG?=
 =?utf-8?B?RWFQOFlqaEpvczJ0R3pjU3BnSXlUYkJhbDBid080M0NVTTd3UTQ1TmxoY01F?=
 =?utf-8?B?dEhsc3owVXJrQ1VPZ0hDbUViQU5IL1c3ZzRYU0pnZWJucGhweDZmSGNXOHla?=
 =?utf-8?Q?gwJ8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6337cf37-bf7b-48f3-1457-08db3c0d08f0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 10:51:28.7245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fhn15rCZao9meWVhLG11ICtKdh2GaWopxxlOqVjQn6TI2cYZzy0rQuUhxdp0dBdr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mukul.joshi@amd.com,
 contactshashanksharma@gmail.com, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.04.23 um 12:48 schrieb Christian König:
> Am 12.04.23 um 18:25 schrieb Shashank Sharma:
>> This patch:
>> - creates a new file for doorbell management.
>> - moves doorbell code from amdgpu_device.c to this file.
>>
>> V2:
>>   - remove doc from function declaration (Christian)
>>   - remove 'device' from function names to make it consistent (Alex)
>>   - add SPDX license identifier (Luben)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 174 +----------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |   6 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 183 ++++++++++++++++++
>>   4 files changed, 195 insertions(+), 170 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 798d0e9a60b7..204665f20319 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -41,7 +41,7 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
>>   amdgpu-y := amdgpu_drv.o
>>     # add KMS driver
>> -amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>> +amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>>       amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
>>       atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
>>       amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 57ee1c4a81e9..88c75f7a8d66 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -579,94 +579,6 @@ void amdgpu_mm_wreg_mmio_rlc(struct 
>> amdgpu_device *adev,
>>       }
>>   }
>>   -/**
>> - * amdgpu_mm_rdoorbell - read a doorbell dword
>> - *
>> - * @adev: amdgpu_device pointer
>> - * @index: doorbell index
>> - *
>> - * Returns the value in the doorbell aperture at the
>> - * requested doorbell index (CIK).
>> - */
>> -u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>> -{
>> -    if (amdgpu_device_skip_hw_access(adev))
>> -        return 0;
>> -
>> -    if (index < adev->doorbell.num_kernel_doorbells) {
>> -        return readl(adev->doorbell.ptr + index);
>> -    } else {
>> -        DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>> index);
>> -        return 0;
>> -    }
>> -}
>> -
>> -/**
>> - * amdgpu_mm_wdoorbell - write a doorbell dword
>> - *
>> - * @adev: amdgpu_device pointer
>> - * @index: doorbell index
>> - * @v: value to write
>> - *
>> - * Writes @v to the doorbell aperture at the
>> - * requested doorbell index (CIK).
>> - */
>> -void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>> -{
>> -    if (amdgpu_device_skip_hw_access(adev))
>> -        return;
>> -
>> -    if (index < adev->doorbell.num_kernel_doorbells) {
>> -        writel(v, adev->doorbell.ptr + index);
>> -    } else {
>> -        DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>> index);
>> -    }
>> -}
>> -
>> -/**
>> - * amdgpu_mm_rdoorbell64 - read a doorbell Qword
>> - *
>> - * @adev: amdgpu_device pointer
>> - * @index: doorbell index
>> - *
>> - * Returns the value in the doorbell aperture at the
>> - * requested doorbell index (VEGA10+).
>> - */
>> -u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>> -{
>> -    if (amdgpu_device_skip_hw_access(adev))
>> -        return 0;
>> -
>> -    if (index < adev->doorbell.num_kernel_doorbells) {
>> -        return atomic64_read((atomic64_t *)(adev->doorbell.ptr + 
>> index));
>> -    } else {
>> -        DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>> index);
>> -        return 0;
>> -    }
>> -}
>> -
>> -/**
>> - * amdgpu_mm_wdoorbell64 - write a doorbell Qword
>> - *
>> - * @adev: amdgpu_device pointer
>> - * @index: doorbell index
>> - * @v: value to write
>> - *
>> - * Writes @v to the doorbell aperture at the
>> - * requested doorbell index (VEGA10+).
>> - */
>> -void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, 
>> u64 v)
>> -{
>> -    if (amdgpu_device_skip_hw_access(adev))
>> -        return;
>> -
>> -    if (index < adev->doorbell.num_kernel_doorbells) {
>> -        atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>> -    } else {
>> -        DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>> index);
>> -    }
>> -}
>> -
>>   /**
>>    * amdgpu_device_indirect_rreg - read an indirect register
>>    *
>> @@ -1016,82 +928,6 @@ int amdgpu_device_pci_reset(struct 
>> amdgpu_device *adev)
>>       return pci_reset_function(adev->pdev);
>>   }
>>   -/*
>> - * GPU doorbell aperture helpers function.
>> - */
>> -/**
>> - * amdgpu_device_doorbell_init - Init doorbell driver information.
>> - *
>> - * @adev: amdgpu_device pointer
>> - *
>> - * Init doorbell driver information (CIK)
>> - * Returns 0 on success, error on failure.
>> - */
>> -static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>> -{
>> -
>> -    /* No doorbell on SI hardware generation */
>> -    if (adev->asic_type < CHIP_BONAIRE) {
>> -        adev->doorbell.base = 0;
>> -        adev->doorbell.size = 0;
>> -        adev->doorbell.num_kernel_doorbells = 0;
>> -        adev->doorbell.ptr = NULL;
>> -        return 0;
>> -    }
>> -
>> -    if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
>> -        return -EINVAL;
>> -
>> -    amdgpu_asic_init_doorbell_index(adev);
>> -
>> -    /* doorbell bar mapping */
>> -    adev->doorbell.base = pci_resource_start(adev->pdev, 2);
>> -    adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>> -
>> -    if (adev->enable_mes) {
>> -        adev->doorbell.num_kernel_doorbells =
>> -            adev->doorbell.size / sizeof(u32);
>> -    } else {
>> -        adev->doorbell.num_kernel_doorbells =
>> -            min_t(u32, adev->doorbell.size / sizeof(u32),
>> -                  adev->doorbell_index.max_assignment+1);
>> -        if (adev->doorbell.num_kernel_doorbells == 0)
>> -            return -EINVAL;
>> -
>> -        /* For Vega, reserve and map two pages on doorbell BAR since 
>> SDMA
>> -         * paging queue doorbell use the second page. The
>> -         * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
>> -         * doorbells are in the first page. So with paging queue 
>> enabled,
>> -         * the max num_kernel_doorbells should + 1 page (0x400 in 
>> dword)
>> -         */
>> -        if (adev->asic_type >= CHIP_VEGA10)
>> -            adev->doorbell.num_kernel_doorbells += 0x400;
>> -    }
>> -
>> -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>> -                     adev->doorbell.num_kernel_doorbells *
>> -                     sizeof(u32));
>> -    if (adev->doorbell.ptr == NULL)
>> -        return -ENOMEM;
>> -
>> -    return 0;
>> -}
>> -
>> -/**
>> - * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
>> - *
>> - * @adev: amdgpu_device pointer
>> - *
>> - * Tear down doorbell driver information (CIK)
>> - */
>> -static void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>> -{
>> -    iounmap(adev->doorbell.ptr);
>> -    adev->doorbell.ptr = NULL;
>> -}
>> -
>> -
>> -
>>   /*
>>    * amdgpu_device_wb_*()
>>    * Writeback is the method by which the GPU updates special pages 
>> in memory
>> @@ -1239,7 +1075,7 @@ int amdgpu_device_resize_fb_bar(struct 
>> amdgpu_device *adev)
>>                     cmd & ~PCI_COMMAND_MEMORY);
>>         /* Free the VRAM and doorbell BAR, we most likely need to 
>> move both. */
>> -    amdgpu_device_doorbell_fini(adev);
>> +    amdgpu_doorbell_fini(adev);
>>       if (adev->asic_type >= CHIP_BONAIRE)
>>           pci_release_resource(adev->pdev, 2);
>>   @@ -1256,7 +1092,7 @@ int amdgpu_device_resize_fb_bar(struct 
>> amdgpu_device *adev)
>>       /* When the doorbell or fb BAR isn't available we have no 
>> chance of
>>        * using the device.
>>        */
>> -    r = amdgpu_device_doorbell_init(adev);
>> +    r = amdgpu_doorbell_init(adev);
>>       if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
>>           return -ENODEV;
>>   @@ -3712,7 +3548,7 @@ int amdgpu_device_init(struct amdgpu_device 
>> *adev,
>>           dev_info(adev->dev, "PCIE atomic ops is not supported\n");
>>         /* doorbell bar mapping and doorbell index init*/
>> -    amdgpu_device_doorbell_init(adev);
>> +    amdgpu_doorbell_init(adev);
>>         if (amdgpu_emu_mode == 1) {
>>           /* post the asic on emulation mode */
>> @@ -3942,7 +3778,7 @@ static void amdgpu_device_unmap_mmio(struct 
>> amdgpu_device *adev)
>> unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
>>         /* Unmap all mapped bars - Doorbell, registers and VRAM */
>> -    amdgpu_device_doorbell_fini(adev);
>> +    amdgpu_doorbell_fini(adev);
>>         iounmap(adev->rmmio);
>>       adev->rmmio = NULL;
>> @@ -4051,7 +3887,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device 
>> *adev)
>>             iounmap(adev->rmmio);
>>           adev->rmmio = NULL;
>> -        amdgpu_device_doorbell_fini(adev);
>> +        amdgpu_doorbell_fini(adev);
>>           drm_dev_exit(idx);
>>       }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index 908433ac6cb3..3e77a6b4bd69 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -306,6 +306,12 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device 
>> *adev, u32 index, u32 v);
>>   u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);
>>   void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, 
>> u64 v);
>>   +/*
>> + * GPU doorbell aperture helpers function.
>> + */
>> +int amdgpu_doorbell_init(struct amdgpu_device *adev);
>> +void amdgpu_doorbell_fini(struct amdgpu_device *adev);
>> +
>>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> new file mode 100644
>> index 000000000000..64fec954815d
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> @@ -0,0 +1,183 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>
> That should probably be MIT. Except if Alex thinks otherwise.
>
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include "amdgpu.h"
>> +
>> +/**
>> + * amdgpu_mm_rdoorbell - read a doorbell dword
>> + *
>> + * @adev: amdgpu_device pointer
>> + * @index: doorbell index
>> + *
>> + * Returns the value in the doorbell aperture at the
>> + * requested doorbell index (CIK).
>> + */
>> +u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>> +{
>> +    if (amdgpu_device_skip_hw_access(adev))
>> +        return 0;
>> +
>> +    if (index < adev->doorbell.num_kernel_doorbells)
>> +        return readl(adev->doorbell.ptr + index);
>> +
>> +    DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> +    return 0;
>> +}
>> +
>> +/**
>> + * amdgpu_mm_wdoorbell - write a doorbell dword
>> + *
>> + * @adev: amdgpu_device pointer
>> + * @index: doorbell index
>> + * @v: value to write
>> + *
>> + * Writes @v to the doorbell aperture at the
>> + * requested doorbell index (CIK).
>> + */
>> +void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>> +{
>> +    if (amdgpu_device_skip_hw_access(adev))
>> +        return;
>> +
>> +    if (index < adev->doorbell.num_kernel_doorbells)
>> +        writel(v, adev->doorbell.ptr + index);
>> +    else
>> +        DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>> index);
>> +}
>> +
>> +/**
>> + * amdgpu_mm_rdoorbell64 - read a doorbell Qword
>> + *
>> + * @adev: amdgpu_device pointer
>> + * @index: doorbell index
>> + *
>> + * Returns the value in the doorbell aperture at the
>> + * requested doorbell index (VEGA10+).
>> + */
>> +u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>> +{
>> +    if (amdgpu_device_skip_hw_access(adev))
>> +        return 0;
>> +
>> +    if (index < adev->doorbell.num_kernel_doorbells)
>> +        return atomic64_read((atomic64_t *)(adev->doorbell.ptr + 
>> index));
>> +
>> +    DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> +    return 0;
>> +}
>> +
>> +/**
>> + * amdgpu_mm_wdoorbell64 - write a doorbell Qword
>> + *
>> + * @adev: amdgpu_device pointer
>> + * @index: doorbell index
>> + * @v: value to write
>> + *
>> + * Writes @v to the doorbell aperture at the
>> + * requested doorbell index (VEGA10+).
>> + */
>> +void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, 
>> u64 v)
>> +{
>> +    if (amdgpu_device_skip_hw_access(adev))
>> +        return;
>> +
>> +    if (index < adev->doorbell.num_kernel_doorbells)
>> +        atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>> +    else
>> +        DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>> index);
>> +}
>> +
>> +/*
>> + * GPU doorbell aperture helpers function.
>> + */
>> +/**
>> + * amdgpu_doorbell_init - Init doorbell driver information.
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Init doorbell driver information (CIK)
>> + * Returns 0 on success, error on failure.
>> + */
>> +int amdgpu_doorbell_init(struct amdgpu_device *adev)
>> +{
>> +
>> +    /* No doorbell on SI hardware generation */
>> +    if (adev->asic_type < CHIP_BONAIRE) {
>> +        adev->doorbell.base = 0;
>> +        adev->doorbell.size = 0;
>> +        adev->doorbell.num_kernel_doorbells = 0;
>> +        adev->doorbell.ptr = NULL;
>> +        return 0;
>> +    }
>> +
>> +    if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
>> +        return -EINVAL;
>> +
>> +    amdgpu_asic_init_doorbell_index(adev);
>> +
>> +    /* doorbell bar mapping */
>> +    adev->doorbell.base = pci_resource_start(adev->pdev, 2);
>> +    adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>> +
>> +    if (adev->enable_mes) {
>> +        adev->doorbell.num_kernel_doorbells =
>> +            adev->doorbell.size / sizeof(u32);
>> +    } else {
>> +        adev->doorbell.num_kernel_doorbells =
>> +            min_t(u32, adev->doorbell.size / sizeof(u32),
>> +                  adev->doorbell_index.max_assignment+1);
>> +        if (adev->doorbell.num_kernel_doorbells == 0)
>> +            return -EINVAL;
>> +
>> +        /* For Vega, reserve and map two pages on doorbell BAR since 
>> SDMA
>> +         * paging queue doorbell use the second page. The
>> +         * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
>> +         * doorbells are in the first page. So with paging queue 
>> enabled,
>> +         * the max num_kernel_doorbells should + 1 page (0x400 in 
>> dword)
>> +         */
>> +        if (adev->asic_type >= CHIP_VEGA10)
>> +            adev->doorbell.num_kernel_doorbells += 0x400;
>> +    }
>> +
>> +    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>> +                     adev->doorbell.num_kernel_doorbells *
>> +                     sizeof(u32));
>
> It might be a good idea to drop this. Or do we really have any use 
> case where we need to access doorbells outside of the kernel reserved 
> ones? (If yes, forget what I've said this looks good then).

Forget what I've wrote here. Just seen than you clean this up in patch #6.

With the license question solved feel free to add Reviewed-by: Christian 
König <christian.koenig@amd.com> to the patch.

Regards,
Christian.

>
> Christian.
>
>> +    if (adev->doorbell.ptr == NULL)
>> +        return -ENOMEM;
>> +
>> +    return 0;
>> +}
>> +
>> +/**
>> + * amdgpu_doorbell_fini - Tear down doorbell driver information.
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Tear down doorbell driver information (CIK)
>> + */
>> +void amdgpu_doorbell_fini(struct amdgpu_device *adev)
>> +{
>> +    iounmap(adev->doorbell.ptr);
>> +    adev->doorbell.ptr = NULL;
>> +}
>

