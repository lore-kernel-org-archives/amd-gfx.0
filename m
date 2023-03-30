Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A36DC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 13:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6CE10EE20;
	Thu, 30 Mar 2023 13:30:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC8F10EE20
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATT2cd9KD/C0+p2OEvrvm2/n1hYBfwH/t0CiWtomN/GriBJXTjjTu92CBN9xVjvzqhu6upb/XY/WBOH8Z4LQw5FdOsEe40w6PRJKblED80qIYZPPzKY4BmeV42mQjPKcUakv5P+IcDJLNNh4IuohF3ryzC5QS7qvBtZXOdalejIV4kQoEwih0awa3ijgx4/O3SW7Hs3/JITSQDNEETFzXyXW+F9wmCkLeKibIvxB/z/IOszZRsFXWxbMu6M7W6hwZAR9W6UCBO3e7hKwb82brG8jsbjwYUTGeGT7AW9yYuKJl2SDkMiaTs5Y4AmYpWeOTtqG0Tn+ooKQasa5h1505g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANKSIfCdxOu/xyFSdGjScB3quEb1TdpqpzhG6rqHC7M=;
 b=lkk0Oz/746+KwC00IDDceX6+9fNblC0QJicT3Acp+rJDDO6IsRuPp5BcEicGETmntQCsO4o6I8NWeXQoY9ygfwgKQ1vuN/oOzkVxEiYi/WpfNOC9tNotimbJGagVoFwOhNRVwM8pG4Qf4X7tcZV63NIkfxkSDyx4mEbPdpC6tNTbXf0LKkV1FqIUob6ppwJEII/aK1e6lzG78aFCvLxkCoECVd3TCV5MqIg0kd7YlcrIIoD3ZnA8EJdt0+XxvaBiFutLo1gOO0jDvgYSvVDt6hA4ePf7dG+AugfolYN/lbs+yMrjtOOUu94wyJXRfVWXb8xN4HZbFh0RWOPtBYxMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANKSIfCdxOu/xyFSdGjScB3quEb1TdpqpzhG6rqHC7M=;
 b=yectyv8foixjU+UeMEbup644K4Kwoe4/vwCaJRQ/nnxXSRHIghr7S/XYSkr8gZcDFZasR0oaaG5MtQs3mKgPOROitpLjqpTxD9B+//kcjABMZ8QWH42okxeZA/htcjXiodttN3VwhMCAQYV1nxSyTQX4vY6Sab5H17YSXGchzv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 13:30:02 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 13:30:02 +0000
Message-ID: <5c1c4b38-1574-4625-1074-62838bd3d0f7@amd.com>
Date: Thu, 30 Mar 2023 09:29:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-4-shashank.sharma@amd.com>
 <ed0f7cb9-78da-550c-8d91-6989e0ceb7a2@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 03/16] drm/amdgpu: create a new file for doorbell manager
In-Reply-To: <ed0f7cb9-78da-550c-8d91-6989e0ceb7a2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::17) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 56261191-2aa5-4f0f-b522-08db3122dde4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SajZg9H0VBzOYZBdE2mH4JP+3rp+CRa4hzDt1Me47XxnzDI7jlQsYoHMdaB2V16T+6yIUnXFZcRgBTjJku25aHuasqjcsf2WyVWJWyncoxwhGIkkpuXwZ6ZN4BHUJ44EW6hA0mtfisWSCrEp8JY20n1jy2P6HU3rHVG/9yqmYfb+R399xvOpfyVMEHzzvFezHncTjJdA5dbI/Y0FOlPRsmMZQ2JFvTJtYDVBpo3wddIpEjjJm7CS+UbdW97OZsiaVrbKReIgzCkrkBJMLwH6qzJkszH2w2/er9y+QyYBr2eXAYbmF3s3W8FVoGsAXxJTU2CBgcWs15UFtwf6y+VLOkF9vZv+EPOMMLjvn/utXLVmbha4/Tc63EShg64XpHS+gpSy74bq0kStoJFaEuzpjzSyZrJUb5/IFd55tSLDo5Zpd0PaVnw+/qDNbdSf57Y1/eolDPjDQ6pixytpTfXrPisGHg+HpzUJD+t44spCsHBAJVsnXgA7R+FVlWmu8ucFwZpcBFBF++FVYCzyHOzryFcsyp/vMpv5YEBAY0s+mW2JthQU6QZDITE0/yR1avbP+h9xNaUr8aLqQB7qa081gDxwWg4bSM+D1yva0BUdCo+YcXwvVa3deozPFC+zwpHeLbdakYc4LCaqJIAZj1dwdKSSJQK5UDHPaJwUEsCm+kDCCXiBmoaQmJZs3Oy4q9y5a47+Tf1yn+/ZXAdC/07y/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(6512007)(6486002)(53546011)(6666004)(6506007)(31686004)(26005)(316002)(54906003)(478600001)(110136005)(66574015)(66556008)(8676002)(66899021)(66476007)(186003)(2616005)(83380400001)(66946007)(41300700001)(8936002)(2906002)(4326008)(5660300002)(30864003)(44832011)(38100700002)(86362001)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFJQbUxyMmpIN3RBbnhhOFBqRlQ5bHJhbGcyckNlVkxYaFJrME5aclc5eWND?=
 =?utf-8?B?NXZpUUVWaDNlbHh4VTE4dC96ZFVDaVljb3huc0FaVVZDK1U0U0JzZ1JQR09k?=
 =?utf-8?B?MlRwVTRuOTdBTnRmK0dOeWxxeUtuUjFuNGdkYy9xYWU3eExIK0xtcERxNXcz?=
 =?utf-8?B?bWVQKzhCaWd0T3BqM3dVMU1OZmNPS1AvNURTRzk0TjFGODhkdVg1ajJtWSt5?=
 =?utf-8?B?c0JqR0MrbEl4YVd5Yk1CSHRIQnlWTHlPOVlYa1pzYVVTUVNRdGNnNUs3SHNB?=
 =?utf-8?B?cjJOVkp4dmJjR2J0ZWhxTWNWdDI0T3EwWDJvMjlqU291TVlHaE1yN3lXSkdq?=
 =?utf-8?B?YnQ5Qjh0a2dpUWRvRlpIbFVMaUVNT0dUdDJCR1VXU2tNaTc3L2RJN1pkaXpW?=
 =?utf-8?B?RGFrenVnREJhQVJJYkRtU3BYa042S2N6eWtXR2tlSnpxZnp3aWs2SGJ1YjlV?=
 =?utf-8?B?YWo2K0F0eC9Tb0l3Tnp4VURMMGs0UWp4UEJQZjZDajlBTEk5WGU2NzlkbExG?=
 =?utf-8?B?SHlIVnQzZGkxRWEvbmtITDROdHhOcjIxUnBac3RtZ0FGcmt6NHF1ZFdqVkdR?=
 =?utf-8?B?azNGODNyd0IzSjZ0Ri9CRUxqUjF6SHo2a0ZHUVJQSVE4WjNSUTJRTEtsc2dp?=
 =?utf-8?B?RGlUblRYN2svVDk5MGZBQmlxaER1bWtwaTV5REIxTUo1Mzk5cFJaOFVYcldX?=
 =?utf-8?B?OW5TeUdlSFJKYzlWTTZhRm9EOXVMNkJzV3dWYksxNEZBUTZiSXpVdkluUjhG?=
 =?utf-8?B?YTNWKzN1Ym5IYU4zOXFSemdKVW5sL2hla3J2TnBoaXNCd1pIRHA3Vy9sMmx3?=
 =?utf-8?B?UCt2emZBRFFZMlVKZWZORTZTQVJOTnBNNkdjbEpBM1FSQTBEdGNUeGU1MTFZ?=
 =?utf-8?B?Q3hxZGs1SVRzUGw2WTV1cGd4dFlFWm0wZkIydWhKMnJCTDQ5dDFmVjhoQllu?=
 =?utf-8?B?QlZPeHY5aHI0RVY0SWlodDBxcVk4MVZhOUhVZFdrV0xUb3U0QlZuNmJLRUJq?=
 =?utf-8?B?S01wd29SbjJXNHpxL0w3VGdkbzlGQzZWcW4wbngvZEV4RmdFeS9YNEovaStt?=
 =?utf-8?B?YlV3UmxwWC83MXNhRHo4bzBNcldHYlNsWDdNZHp3TXd3cjMveUJxUmVKK3Y4?=
 =?utf-8?B?RFA4N1NWL28zM0V2YVFhZEZHN0xUYWpZYjRSUTlReXo0K2ZaSDlqUkYyeUk3?=
 =?utf-8?B?cFMwenptMU4vd2tvei9oNEZuSThzbmNDNGJkenZtVmE0ZllWNDg3RjV2eVl2?=
 =?utf-8?B?aHVlTWNmeU5md3QyUDIxaWlQNGhVNkdpSG9SZ3JnZzhiUUJuNEczUnRJZ1R0?=
 =?utf-8?B?em9KcFVnQnB6biszdGNURENxN1ZRdDRRSm1iNnorc0k4cmhENENodFlUWlgr?=
 =?utf-8?B?cEJoUFg4QnZsQlhEZDR0eG5EQ2pxeFVZSUJWRk1TU0VRdUh2UTJhVC9sbUVj?=
 =?utf-8?B?blZPNFdsYTNsaEpYSC9ZWjFvMmlPb3R6dXQ0bm5KNC9Nd2srM0NERHg5ZHo4?=
 =?utf-8?B?U0dma1c3d0Zkc0JLNjUxY0JQWG8vaVhKQlRKMnhJUVpqMkcxcmVvVUg3VlVV?=
 =?utf-8?B?Y2ZLdHlZTGpjT0pUOEtMR0JaM1hKNlR0dUJ2R0xVbUNYTGZNTElmTVRmdG1Y?=
 =?utf-8?B?WUlveXc0NytvRFE2MThQWmZPeHVMc0lZRmduZTNSbkhOQlI2VU4zaE1LczRX?=
 =?utf-8?B?RjF1eHZ6a0FKREFDcktMWGFHbkhQNTRuUWcyMkNKcDQ2d3ZtNmUvTUM3b01S?=
 =?utf-8?B?Lzd4cXpRa2VXSkg0emNlT2ZIVnE0a3ZRQ0JoVVJodmRRWXh4aGFSU1pMZzd0?=
 =?utf-8?B?MlhnTnZEaDZpRk9NOFFhbTBlK2h2QnBEZ0liWmFIWGR2bE9vV1hUUUw4cmpB?=
 =?utf-8?B?MGtERytCcHNiK2JoQ09rcXlkVlhldStneXE5MUNYQ2w3aEM2ME4yRm1hbGVG?=
 =?utf-8?B?QzVtb3E3elRtQWRSRzV0U0hLSU5kWGVpRzZnVmpKSUl2YnVIb3pwRGJtc3oz?=
 =?utf-8?B?MFBvTnVCcm9aSGFxN1JXUm9UUU4yTjJZZWdFMUZWUlN3Z2VQeXhhVDUwaUs1?=
 =?utf-8?B?QkFXci9DckIvR0gxb2o2dVhFeEw2TGNaRjRRQ0hrSG00Y2ttMm9VK1FZdVdW?=
 =?utf-8?Q?0v6tLes6IyKIQE4/T4HmXNV2Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56261191-2aa5-4f0f-b522-08db3122dde4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:30:02.6231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ESIeBUVYoKjB5qrfW5UoI5wdpddVe7Az2lILOx/biv9+wlstchacFJbR5zqmUc8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868
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

Hi Shashank,

Inline:

On 2023-03-30 07:09, Christian König wrote:
> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
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
>>   	amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
>>   	atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
>>   	amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 57ee1c4a81e9..7f8fcac4f18b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -579,94 +579,6 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>>   	}
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
>> -	if (amdgpu_device_skip_hw_access(adev))
>> -		return 0;
>> -
>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>> -		return readl(adev->doorbell.ptr + index);
>> -	} else {
>> -		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> -		return 0;
>> -	}
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
>> -	if (amdgpu_device_skip_hw_access(adev))
>> -		return;
>> -
>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>> -		writel(v, adev->doorbell.ptr + index);
>> -	} else {
>> -		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>> -	}
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
>> -	if (amdgpu_device_skip_hw_access(adev))
>> -		return 0;
>> -
>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>> -		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>> -	} else {
>> -		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> -		return 0;
>> -	}
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
>> -	if (amdgpu_device_skip_hw_access(adev))
>> -		return;
>> -
>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>> -		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>> -	} else {
>> -		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>> -	}
>> -}
>> -
>>   /**
>>    * amdgpu_device_indirect_rreg - read an indirect register
>>    *
>> @@ -1016,82 +928,6 @@ int amdgpu_device_pci_reset(struct amdgpu_device *adev)
>>   	return pci_reset_function(adev->pdev);
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
>> -	/* No doorbell on SI hardware generation */
>> -	if (adev->asic_type < CHIP_BONAIRE) {
>> -		adev->doorbell.base = 0;
>> -		adev->doorbell.size = 0;
>> -		adev->doorbell.num_kernel_doorbells = 0;
>> -		adev->doorbell.ptr = NULL;
>> -		return 0;
>> -	}
>> -
>> -	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
>> -		return -EINVAL;
>> -
>> -	amdgpu_asic_init_doorbell_index(adev);
>> -
>> -	/* doorbell bar mapping */
>> -	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
>> -	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>> -
>> -	if (adev->enable_mes) {
>> -		adev->doorbell.num_kernel_doorbells =
>> -			adev->doorbell.size / sizeof(u32);
>> -	} else {
>> -		adev->doorbell.num_kernel_doorbells =
>> -			min_t(u32, adev->doorbell.size / sizeof(u32),
>> -			      adev->doorbell_index.max_assignment+1);
>> -		if (adev->doorbell.num_kernel_doorbells == 0)
>> -			return -EINVAL;
>> -
>> -		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
>> -		 * paging queue doorbell use the second page. The
>> -		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
>> -		 * doorbells are in the first page. So with paging queue enabled,
>> -		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
>> -		 */
>> -		if (adev->asic_type >= CHIP_VEGA10)
>> -			adev->doorbell.num_kernel_doorbells += 0x400;
>> -	}
>> -
>> -	adev->doorbell.ptr = ioremap(adev->doorbell.base,
>> -				     adev->doorbell.num_kernel_doorbells *
>> -				     sizeof(u32));
>> -	if (adev->doorbell.ptr == NULL)
>> -		return -ENOMEM;
>> -
>> -	return 0;
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
>> -	iounmap(adev->doorbell.ptr);
>> -	adev->doorbell.ptr = NULL;
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
> 
> I might be wrong, but having kerneldoc on both the declaration and the 
> implementation is forbidden I think.
> 
> We usually have it on the implementation side only.

Yes, that is correct--implementation side only as that's where
the actual code can be found.

> 
> Christian.
> 
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

Add an SPDX licence identifier as the very first line:
//SPDX-License-Identifier: <value>

with some appropriate value, maybe "GPL-2.0-or-later" (no quotes when added).

Regards,
Luben

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
>> +	if (amdgpu_device_skip_hw_access(adev))
>> +		return 0;
>> +
>> +	if (index < adev->doorbell.num_kernel_doorbells) {
>> +		return readl(adev->doorbell.ptr + index);
>> +	} else {
>> +		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> +		return 0;
>> +	}
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
>> +	if (amdgpu_device_skip_hw_access(adev))
>> +		return;
>> +
>> +	if (index < adev->doorbell.num_kernel_doorbells) {
>> +		writel(v, adev->doorbell.ptr + index);
>> +	} else {
>> +		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>> +	}
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
>> +	if (amdgpu_device_skip_hw_access(adev))
>> +		return 0;
>> +
>> +	if (index < adev->doorbell.num_kernel_doorbells) {
>> +		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>> +	} else {
>> +		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>> +		return 0;
>> +	}
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
>> +	if (amdgpu_device_skip_hw_access(adev))
>> +		return;
>> +
>> +	if (index < adev->doorbell.num_kernel_doorbells) {
>> +		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>> +	} else {
>> +		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>> +	}
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
>> +	/* No doorbell on SI hardware generation */
>> +	if (adev->asic_type < CHIP_BONAIRE) {
>> +		adev->doorbell.base = 0;
>> +		adev->doorbell.size = 0;
>> +		adev->doorbell.num_kernel_doorbells = 0;
>> +		adev->doorbell.ptr = NULL;
>> +		return 0;
>> +	}
>> +
>> +	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
>> +		return -EINVAL;
>> +
>> +	amdgpu_asic_init_doorbell_index(adev);
>> +
>> +	/* doorbell bar mapping */
>> +	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
>> +	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>> +
>> +	if (adev->enable_mes) {
>> +		adev->doorbell.num_kernel_doorbells =
>> +			adev->doorbell.size / sizeof(u32);
>> +	} else {
>> +		adev->doorbell.num_kernel_doorbells =
>> +			min_t(u32, adev->doorbell.size / sizeof(u32),
>> +			      adev->doorbell_index.max_assignment+1);
>> +		if (adev->doorbell.num_kernel_doorbells == 0)
>> +			return -EINVAL;
>> +
>> +		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
>> +		 * paging queue doorbell use the second page. The
>> +		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
>> +		 * doorbells are in the first page. So with paging queue enabled,
>> +		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
>> +		 */
>> +		if (adev->asic_type >= CHIP_VEGA10)
>> +			adev->doorbell.num_kernel_doorbells += 0x400;
>> +	}
>> +
>> +	adev->doorbell.ptr = ioremap(adev->doorbell.base,
>> +				     adev->doorbell.num_kernel_doorbells *
>> +				     sizeof(u32));
>> +	if (adev->doorbell.ptr == NULL)
>> +		return -ENOMEM;
>> +
>> +	return 0;
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
>> +	iounmap(adev->doorbell.ptr);
>> +	adev->doorbell.ptr = NULL;
>> +}
> 

