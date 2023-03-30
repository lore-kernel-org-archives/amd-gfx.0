Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245F7C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B16E910EEA1;
	Thu, 30 Mar 2023 14:49:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0438210EEA2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNgudk2S7q5eWg3tOoxuvbuKGURPS9OaK7bj5hzY9xptn4Qnk+RftVtfYhRlv+Gor2+cSH6nGkCUpXweKvuydkYperi/YZQQunkDnc5L4HvJVP2TTGlVQmzEvs9EdEswum2kFUc5yF5cIe3lviP2Oh5PKj+kqEBelfEsiYZaa3DSyx6RUt9THmnLfwDnSd+4xK8VwjUG8BlnddL7GiAjoUeu4tY8191CYMV+VJBJdzQwinfeVreR7q/50mzqD0y/135cbnhANzxGva9JsHdmLS6Tq+Gk6me9tk7O1oktnFmt6yyDhMFs4D4TFHDyGqhnMfu304QB0aOGzfC8hm7vAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKItu0EH6ZEJMbuZY97Yn5PjZeulDWW1NsG5B7NEcNI=;
 b=mX63hg90prUAmBH434ujflX7zrKXwMazG4B0WPn4NWjx/BXvP8p7KYDsXf7QYUiyIYdUWMPWhqr7O6cunMHYgSVPsuIZ9zl2oMZRRNipf48o2X77d2HtOjgRGFczkFHU2CKuxcUs4YXtMRMMGggfn+ag7tPGtZFAYvlG1gV9aFGZgbxsTALzW2zEdhQUHnwc/g3keusf/VnBERwM9VQDCHh91awD7I10ct/eOA52N8wzD4yzJR0Qj1dXnbsTppJHpCPDtli0EosdwL0kvrrWBg364s7FWxvUO9au8Klj1VMJsQc11YiQwo3zqKBKxtuMsUs0Zg0888LFT6Vc21NIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKItu0EH6ZEJMbuZY97Yn5PjZeulDWW1NsG5B7NEcNI=;
 b=WaH558tIt1jkUIbNklD8M9qkyKS3ommRcyhU60FJZ3ZXRZReNNh8ogmvChQxWcByGa9T+rMDUmqdCvE1h1TdfIw0/MxwaaTD2NHJS3OPAlf0gY7MWCHUdQLJK1mgmZCj6swsOU7hVQT3SWcSm3JxwXAK2nCn/xGTKOdVyCvcjic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 14:49:52 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 14:49:52 +0000
Message-ID: <a298ca23-74f1-fb93-1b49-319c61f17099@amd.com>
Date: Thu, 30 Mar 2023 16:49:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 03/16] drm/amdgpu: create a new file for doorbell manager
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-4-shashank.sharma@amd.com>
 <CADnq5_PGPL1nTWyoiusGSLwBPMoFpv5a7sUpE6W99ozWTRv5-A@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_PGPL1nTWyoiusGSLwBPMoFpv5a7sUpE6W99ozWTRv5-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 795be668-6faf-4d3b-7405-08db312e0485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A++Ih8JrLXTtiS7AzjzCMJ1I4gU8Vi1bRnqhSbC7sNtj1WFvrI7LIy+s+4X+bsBDfpqTSWnMEZq9J+WKXGZ6MojDGYToCTXGM7NIKeB920ZVg2c/AZzSdAjpZHRY2tmETTx+tz98rYM7We18NlmCBio5ov5vnU8VuEUT0OaxmkTEyo9Rn2b/Yu1P9wUAVd1ZVvr/9hQshtKIlfShVVQ7r7fdIY++EbJ2VKhnx8XEfDLuO3ANrlTwZZL86MaenJjYkzhakXjeiorIa627Xocu4asvt7Ho32akhUgnGhN0ZA0NiGAbS6z/29K5CiIYVsdfHk5a0TmEfq0Jlugg2RYMl4YHBqxPxxUPxxdvjMaY07YORldNJZRDENGPns2MHfn0M0AjuXii1/iqoF06osaKzRP+lm4WSig3d5BcyQoe25KaktK7brUg8NbfEEBJkcER+zKp1dxeWG6iskAumpXyRjw651F3GVMjHVKXvpZggqpZTTCjiBX1+1/hRivmrPCGopPWdkMu4ilV6Kugi+uO263s7fQN+j/rQv7WLsCAffolcKrxEkFs1tHsJ5Jd+EB3mbgxalFW0i7ij3YxV02SWpuzeB7LvpDWgzoHb3ezAV+KyiZ3BgdKL1K7QH2zr7GzY9OgpCDD+B1fZZlDdGrgNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(83380400001)(6666004)(38100700002)(2616005)(186003)(6506007)(26005)(6512007)(53546011)(36756003)(41300700001)(8936002)(316002)(30864003)(44832011)(2906002)(6486002)(66476007)(478600001)(8676002)(31696002)(66946007)(66556008)(5660300002)(6916009)(4326008)(54906003)(86362001)(31686004)(66899021)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjlXR0U0NU9DakpMZ2RYdlNiV2ZScG5iWVNJZlNXSmtEeEFjTCtXc2Q5VTJV?=
 =?utf-8?B?VExWZG5hRUdacngrYTZPbWxHdDlLQmQ3MjdpNG9KeTluZElnRW1iZ3lvaHRR?=
 =?utf-8?B?eEhWVEdVYXhsSk9hc3k1Z0psNGtOUFFnQU9BRThyMkdTa0xROFVweTh1SDBP?=
 =?utf-8?B?bmtXaDBsUFRtcmtmS0JTYzdJOVJBeVp1MWtMdFN2aFJrc1pmYmgyRUI1OHRB?=
 =?utf-8?B?aXVWcW9oc05mMGpyZXBVcjNaeHI3bU10dVNBNnFST1dvYm5RbjU4Nk4vZ0Ra?=
 =?utf-8?B?WEZOVUtCTnorREQwd2VXQTY1bU9xaXdhWEdsUHpkVWhoQVl0SlZ0Q1JuSkQ0?=
 =?utf-8?B?K0pEMVg1NEx0UnppV01ZbkUxcUFqNFZIRllBMXZDZWdiYnNXR21hc2QzeDU0?=
 =?utf-8?B?dmFnTUtlR3RKNTZEb0RlK09EdUNxN1ZmOFp0cHZDbkZONUJneGlUekd1YnFY?=
 =?utf-8?B?bXVIaWtBQU5xblhFTEI0ODh6K0lscFV4MVNuZXB3SjJqYmZ3RlZUcGFqaXFs?=
 =?utf-8?B?UTNtRVMxRUMzOEEvNTlFeWFzRThOM3c4N2szM2Q0Rm1vT3hFQ0FOSm1nb0Vh?=
 =?utf-8?B?YlRoTkhJRTR0OUk2Q3BiQS9YL3VLWnBoV3o3TFVyT3hFL0xvaVJNQ0hhK2sv?=
 =?utf-8?B?TjdydnlQWG9QeGVLSzF0S055Zmx0Y084bjhvWHMwTnk0dThjeFkzcE4wNzVm?=
 =?utf-8?B?UndXeGxBZWYrY3FXQWRBVGtIRFF1UVhyTVlqSXh4MUc5OTJ3NWFSTktsQmZB?=
 =?utf-8?B?RUl3Zm9pWG9qZ0s0dTIxM3JuTkt4WVlUWDdjNFhXaVNxdDVKeDBQUlNPMXB4?=
 =?utf-8?B?T1N0anIyVnBMaFJjb0hFMERDdFV1MDErUktGOHphbG9rMW5TUit0WDUzakQx?=
 =?utf-8?B?YUhFaWJjR3ZvazVyck9WSlFXc0VyNHk3T0hnMGZwdUQyU2pLcThZcmtKRmJq?=
 =?utf-8?B?QUtWaHFUbVNuL0VJTlNleDBzTEZ1YVVOcU1FZnJTT2tqUTcrUkJPL01xVXZh?=
 =?utf-8?B?YzNwSWZHUlk5d21YeEc0MVFLa1cxbkZDZHFkZGhITklLSjhldTJBTzN5Ni9O?=
 =?utf-8?B?UmVqT0JMRkxLMG9VbC9xZjB0cHZId3BSVm1XZnI2SkQ4eTdhV2ZmaHhiNUpv?=
 =?utf-8?B?ZGd1MThwbHA5SEowZXI3RkVRY0xJb1pZN2dkVnlmV3BQY2tRUGNqWDdrd1NZ?=
 =?utf-8?B?cUpQNUR0bGU5eFdBYlc3UHNJNmJHNkFYVGtCR3lHMW5USUJKam5DK3pDVFgz?=
 =?utf-8?B?OU52MmRCSUlhcGZzdWVLYktXUURzUFRUSGhvVnhUSDNsTlRnZU4vNUZxMi9z?=
 =?utf-8?B?V0o2OHU0TVdFMmk4YVlyTlM4QURMV05TaXkzL3BwQWhWUElOdXVrT3pMR3Vo?=
 =?utf-8?B?MHM5MG9tK3g5eTJxaWxVL2NJRklEa3RHQVN0bzZPVXc2Q1VCakxUQ2l1ZHpC?=
 =?utf-8?B?QzRQQi85amo4Umw3TjlyRE5PelhBdHp0b2tzYUtYTm1LWDJGYWo0TzE0Yjdz?=
 =?utf-8?B?ZHl2U0tuYjRRaXB5b0l5NG5jYTh1SDVrNWJZbXFETjV2d053R3pZbzZCdDVI?=
 =?utf-8?B?WVhKZzRjeTQvL2NobmRJeE1naEc5OFp5Z0lFTTRKekhIdzVnMHp4SS9NcGRz?=
 =?utf-8?B?Q1Fsa2s4S2UvcjhKTVpBL2FaQkNINklxcHJLSlBnWld4NHRSNkhFdFhTeURQ?=
 =?utf-8?B?R1VGYWwrbkhuN1I2ZkJvNmM4MVFJZ01wMW1UcWJGdlBlYUZLMmdjMWRzaGpF?=
 =?utf-8?B?Titkc1Nxc3N4QWF3MXI4RVFwQnBqbFFWcjRrVW12eDNPSlRQQ3gzbTdtaGgw?=
 =?utf-8?B?WDZJOTRjWDh3RmNXbEUva1ZuMThJZ3YzY3cvbFdlc011S1JrTDJ5V2NBaXRo?=
 =?utf-8?B?Ujd5ZEdtRDl6MGdkREs3anhXSTdSUUNibXBodUlwMzBsczZjZytJL0hMcW0z?=
 =?utf-8?B?dHNFVi9lMExwbWFrQTVKTTJ2Qkpzd1lrRnpsNjZRU3B5cVFzMmtIWkU5ZUNR?=
 =?utf-8?B?RW0rcDYxcUNQR04vZ3ZRR09UdDhqa1plWXJsWmsyeTM5UEsrc05ERDhaY2hI?=
 =?utf-8?B?M3dpYjF4cG9yL1NFRmJzeWpYSW4vUStnQkxmODNGTEFmY1ZUaXo0czRwVWdY?=
 =?utf-8?Q?xGbxMYmSMDtr38DN/f8zrsNsI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795be668-6faf-4d3b-7405-08db312e0485
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:49:52.0043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+zUGtc2d6znHAHihHB2Jx8uyrN1VTfk4PR+qGl5U3Of16ZNyPh2zssFUI1hi/s4lgpCrMxM73uYAUEQD0kB6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 16:23, Alex Deucher wrote:
> On Wed, Mar 29, 2023 at 11:48 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch:
>> - creates a new file for doorbell management.
>> - moves doorbell code from amdgpu_device.c to this file.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 164 ---------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  22 +++
>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 186 ++++++++++++++++++
>>   4 files changed, 209 insertions(+), 165 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 798d0e9a60b7..204665f20319 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -41,7 +41,7 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
>>   amdgpu-y := amdgpu_drv.o
>>
>>   # add KMS driver
>> -amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>> +amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>>          amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
>>          atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
>>          amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 57ee1c4a81e9..7f8fcac4f18b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -579,94 +579,6 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>>          }
>>   }
>>
>> -/**
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
>> -       if (amdgpu_device_skip_hw_access(adev))
>> -               return 0;
>> -
>> -       if (index < adev->doorbell.num_kernel_doorbells) {
>> -               return readl(adev->doorbell.ptr + index);
>> -       } else {
>> -               DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> -               return 0;
>> -       }
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
>> -       if (amdgpu_device_skip_hw_access(adev))
>> -               return;
>> -
>> -       if (index < adev->doorbell.num_kernel_doorbells) {
>> -               writel(v, adev->doorbell.ptr + index);
>> -       } else {
>> -               DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>> -       }
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
>> -       if (amdgpu_device_skip_hw_access(adev))
>> -               return 0;
>> -
>> -       if (index < adev->doorbell.num_kernel_doorbells) {
>> -               return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>> -       } else {
>> -               DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> -               return 0;
>> -       }
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
>> -void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>> -{
>> -       if (amdgpu_device_skip_hw_access(adev))
>> -               return;
>> -
>> -       if (index < adev->doorbell.num_kernel_doorbells) {
>> -               atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>> -       } else {
>> -               DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>> -       }
>> -}
>> -
>>   /**
>>    * amdgpu_device_indirect_rreg - read an indirect register
>>    *
>> @@ -1016,82 +928,6 @@ int amdgpu_device_pci_reset(struct amdgpu_device *adev)
>>          return pci_reset_function(adev->pdev);
>>   }
>>
>> -/*
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
>> -       /* No doorbell on SI hardware generation */
>> -       if (adev->asic_type < CHIP_BONAIRE) {
>> -               adev->doorbell.base = 0;
>> -               adev->doorbell.size = 0;
>> -               adev->doorbell.num_kernel_doorbells = 0;
>> -               adev->doorbell.ptr = NULL;
>> -               return 0;
>> -       }
>> -
>> -       if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
>> -               return -EINVAL;
>> -
>> -       amdgpu_asic_init_doorbell_index(adev);
>> -
>> -       /* doorbell bar mapping */
>> -       adev->doorbell.base = pci_resource_start(adev->pdev, 2);
>> -       adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>> -
>> -       if (adev->enable_mes) {
>> -               adev->doorbell.num_kernel_doorbells =
>> -                       adev->doorbell.size / sizeof(u32);
>> -       } else {
>> -               adev->doorbell.num_kernel_doorbells =
>> -                       min_t(u32, adev->doorbell.size / sizeof(u32),
>> -                             adev->doorbell_index.max_assignment+1);
>> -               if (adev->doorbell.num_kernel_doorbells == 0)
>> -                       return -EINVAL;
>> -
>> -               /* For Vega, reserve and map two pages on doorbell BAR since SDMA
>> -                * paging queue doorbell use the second page. The
>> -                * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
>> -                * doorbells are in the first page. So with paging queue enabled,
>> -                * the max num_kernel_doorbells should + 1 page (0x400 in dword)
>> -                */
>> -               if (adev->asic_type >= CHIP_VEGA10)
>> -                       adev->doorbell.num_kernel_doorbells += 0x400;
>> -       }
>> -
>> -       adev->doorbell.ptr = ioremap(adev->doorbell.base,
>> -                                    adev->doorbell.num_kernel_doorbells *
>> -                                    sizeof(u32));
>> -       if (adev->doorbell.ptr == NULL)
>> -               return -ENOMEM;
>> -
>> -       return 0;
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
>> -       iounmap(adev->doorbell.ptr);
>> -       adev->doorbell.ptr = NULL;
>> -}
>> -
>> -
>> -
>>   /*
>>    * amdgpu_device_wb_*()
>>    * Writeback is the method by which the GPU updates special pages in memory
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index 6064943a1b53..f9c3b77bf65d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -306,6 +306,28 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v);
>>   u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);
>>   void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
>>
>> +/*
>> + * GPU doorbell aperture helpers function.
>> + */
>> +/**
>> + * amdgpu_device_doorbell_init - Init doorbell driver information.
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Init doorbell driver information (CIK)
>> + * Returns 0 on success, error on failure.
>> + */
>> +int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
>> +
>> +/**
>> + * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Tear down doorbell driver information (CIK)
>> + */
>> +void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
>> +
>>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> new file mode 100644
>> index 000000000000..2206926ba289
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> @@ -0,0 +1,186 @@
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
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
>> +       if (amdgpu_device_skip_hw_access(adev))
>> +               return 0;
>> +
>> +       if (index < adev->doorbell.num_kernel_doorbells) {
>> +               return readl(adev->doorbell.ptr + index);
>> +       } else {
>> +               DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> +               return 0;
>> +       }
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
>> +       if (amdgpu_device_skip_hw_access(adev))
>> +               return;
>> +
>> +       if (index < adev->doorbell.num_kernel_doorbells) {
>> +               writel(v, adev->doorbell.ptr + index);
>> +       } else {
>> +               DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>> +       }
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
>> +       if (amdgpu_device_skip_hw_access(adev))
>> +               return 0;
>> +
>> +       if (index < adev->doorbell.num_kernel_doorbells) {
>> +               return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>> +       } else {
>> +               DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> +               return 0;
>> +       }
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
>> +void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>> +{
>> +       if (amdgpu_device_skip_hw_access(adev))
>> +               return;
>> +
>> +       if (index < adev->doorbell.num_kernel_doorbells) {
>> +               atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>> +       } else {
>> +               DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>> +       }
>> +}
>> +
>> +/*
>> + * GPU doorbell aperture helpers function.
>> + */
>> +/**
>> + * amdgpu_device_doorbell_init - Init doorbell driver information.
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Init doorbell driver information (CIK)
>> + * Returns 0 on success, error on failure.
>> + */
>> +int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>> +{
>> +
>> +       /* No doorbell on SI hardware generation */
>> +       if (adev->asic_type < CHIP_BONAIRE) {
>> +               adev->doorbell.base = 0;
>> +               adev->doorbell.size = 0;
>> +               adev->doorbell.num_kernel_doorbells = 0;
>> +               adev->doorbell.ptr = NULL;
>> +               return 0;
>> +       }
>> +
>> +       if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
>> +               return -EINVAL;
>> +
>> +       amdgpu_asic_init_doorbell_index(adev);
>> +
>> +       /* doorbell bar mapping */
>> +       adev->doorbell.base = pci_resource_start(adev->pdev, 2);
>> +       adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>> +
>> +       if (adev->enable_mes) {
>> +               adev->doorbell.num_kernel_doorbells =
>> +                       adev->doorbell.size / sizeof(u32);
>> +       } else {
>> +               adev->doorbell.num_kernel_doorbells =
>> +                       min_t(u32, adev->doorbell.size / sizeof(u32),
>> +                             adev->doorbell_index.max_assignment+1);
>> +               if (adev->doorbell.num_kernel_doorbells == 0)
>> +                       return -EINVAL;
>> +
>> +               /* For Vega, reserve and map two pages on doorbell BAR since SDMA
>> +                * paging queue doorbell use the second page. The
>> +                * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
>> +                * doorbells are in the first page. So with paging queue enabled,
>> +                * the max num_kernel_doorbells should + 1 page (0x400 in dword)
>> +                */
>> +               if (adev->asic_type >= CHIP_VEGA10)
>> +                       adev->doorbell.num_kernel_doorbells += 0x400;
>> +       }
>> +
>> +       adev->doorbell.ptr = ioremap(adev->doorbell.base,
>> +                                    adev->doorbell.num_kernel_doorbells *
>> +                                    sizeof(u32));
>> +       if (adev->doorbell.ptr == NULL)
>> +               return -ENOMEM;
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Tear down doorbell driver information (CIK)
>> + */
>> +void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>> +{
>> +       iounmap(adev->doorbell.ptr);
>> +       adev->doorbell.ptr = NULL;
>> +}
> I would suggest renaming these functions to begin with
> amdgpu_doorbell_ to be consistent with the naming conventions in the
> driver.

Noted, agree.

- Shashank

> Alex
