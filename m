Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D602FC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 13:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5641510EE3D;
	Thu, 30 Mar 2023 13:42:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5457F10EE3C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+/XXWEY7XruEL935V5ipLC7Eyk/S2wNlJVU2lZ+gqCZmDKqx+BGarD2qzPUyNoJ/2E7vW/N/RwlkjXHM74PLW1HfhM0rFI1tHijvRJcsuJyadnoqr4Me+vo5mpEoW4TvT6eiE2KiPHcbD1XePKQ6EjqUBx8qBF6PfMxzCLGmcXPXjhSEjJCAQG0WW0YwjHphI9kwV2TH3346fdHzQHUHtusUTJpf47dBNISOHqbQa+uK9Ff0xTIZ9t6H2jYzFZ0GObhL8d+m+cnaLk2PhbsFIDI89FS06ptq5L6U/cir/MVMqJ2Gki4ypys1llG6F14jpN5AiJvCQaNfv3Hk7GZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1E7mgjrXMc/SLDTg10Plt3dPwU0FSL560wE/bjZqnY=;
 b=MXX4MioqvS6OgUxDWHoj4HXb4IUpAK11gv4N0QgnjGzAUXKDj07R9Jlvlh/2UkASat7VMjylYoGHdJEn9XoEeWuZyyCyu4VRoh2w9NAEbSK3YxIDqwOzt+YDNo3/Jwl0VUYtXnhftY6Xq93uoESs727oP9WRZLdM4DxTOZMYiAvWTftvEq8XTwC5DfJ0S71z0F4MM5iELq4CSEq1kbrgGXOrof+c7NeDwSZ0pAlPzol/mdkW5KcUIL6nVB/uoql4bfyIO2YtP9CsHBDt73tQMlZlnD4jZNEflBWIFCiyM7mtA48CrmNCNPJnTS2OR+d/ykYGP38DE/279cZ155au2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1E7mgjrXMc/SLDTg10Plt3dPwU0FSL560wE/bjZqnY=;
 b=Hu6WT+pCmyhOdkTjuIgubqtiNn48y3uVlOq9LagPj61eiQblhwJYZxLJm44WB7mVAGOYw8Mlydm2HRzxtpz0nDPSbPwC73qcFp7bbEJRwsd7K6CFDSYWyyRnFTZwXmJbYatPN1mrHSjW00wlks5uuunYZ56QAlvBGrc0RhXjx2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 13:42:29 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 13:42:29 +0000
Message-ID: <1c34037b-b8a6-493d-11fd-4019834febee@amd.com>
Date: Thu, 30 Mar 2023 15:42:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 03/16] drm/amdgpu: create a new file for doorbell manager
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-4-shashank.sharma@amd.com>
 <ed0f7cb9-78da-550c-8d91-6989e0ceb7a2@amd.com>
 <5c1c4b38-1574-4625-1074-62838bd3d0f7@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <5c1c4b38-1574-4625-1074-62838bd3d0f7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::22) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 29829270-8161-469e-a488-08db31249ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7hc7FuY2YxIcEyFwjgyUH18qV4XL8GipjGYa4dVmCsITw8PIx9CuGHe+8pz0QeGmviLlLKxITcLGYV5duneNVSsTqr9QGRUIOIEnVlS/xcpvVCFAK2M0Kyblhsj/0HyedEpQgF1a9C4tR4pgZX0qAf7HgjVphEXkK4R/N1FQWLcwO3ZstIP1IiMq0jQ8Y98YihZjNPhhyFVjJp2qsa1xuXbw6KUeotVuqXpr4nedONs+LL3j+dD3OHiNwcZJ/O5XYTcChurmvlDxbKURhz+RiZm1MTzMo47y4zOv5W6QW12tk4BI3zGr7Cw+y57+gZZ3w5AkOPpbd22ZfXYjz9sjuUPQ/uSiV5HSl516YoeeFxHKCcxCn+FWHwaTWQ5OAStTnWZ0TQ1fJ2duKvFgSrCBTJkRNzhZOsKt87kFemZn85JxQjvTJ8EFdsyykZh4/xMYUjExkSwwjZ1kYL7YT++ozFWqfLxo2xP2L+OqDOKig+R7gswyDHkRZMz7MDMWxwIX75fHxvw8d+8EKPqjDFkguRg1Lo51UP6yAYlKPf+mBUXvZX0N5TgFgwFlZkpBRTVG7HsVVIG08TgqdKgoZTT/mNhXOCS7YbYqe0bI+5axnrHc4EHNikfIu5UKepXDoKtGE++ixYaHs5kLg6M72OKTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(66574015)(83380400001)(2616005)(6486002)(316002)(478600001)(54906003)(110136005)(186003)(26005)(6666004)(53546011)(6506007)(6512007)(2906002)(4326008)(30864003)(5660300002)(36756003)(44832011)(8936002)(38100700002)(66476007)(86362001)(8676002)(31696002)(41300700001)(66556008)(66946007)(31686004)(66899021)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVI3eDFMRGE4UHlXT3NvMUxNM2c3ZWZpR3JHcUMxTUhtMXUwell3c3JIVzJL?=
 =?utf-8?B?bkZkaEErMnppa0doSFAvZ2lMQVZONTU4RmY1cDlBdEVPUlRla2hreU9wUkNW?=
 =?utf-8?B?eTdjMUpHZ05JR3FRcEdXcE8vc0dyMjJVTDFSREZjbmVWYUJUUURoK2s1c29Q?=
 =?utf-8?B?KzEzTTM1ZFFPc1JzcGJBTk9lSHNmS2RZbWF6ZkRialk1ZkhscFRvK254Rk52?=
 =?utf-8?B?QlM4UGF4NXJucmtzbm5qblFIeW1PTUtXakxhTHZRMWhld2lmMklyZG1oR0tM?=
 =?utf-8?B?TURxNUFPNCtaUlE5c093NFNYdTIyNy9YaDh2TVZUTFptWnMvUHE2UmNvaW1v?=
 =?utf-8?B?blMvSHA3VCtmU0dRZTM2OHp5dmdOSXpnSkF6ZnpzMTVXaFpCeWF1d3JLY2E1?=
 =?utf-8?B?ZTRpUVo4QkxmMktzeGVIZ00raWVtUExwZUlvUE5IbVhRallLQS93dDNmWk5q?=
 =?utf-8?B?WkRRQmFrOW80cjlkZ1dTYjJ3SHBHTVVUbDk3OFR6dWtGWlF3TFlRa243R2ZH?=
 =?utf-8?B?YWFXc3lheDJxKy85emtpaXhoSFkwUklRald6dXNRYUVYb1NtOEM5WHdwNEtL?=
 =?utf-8?B?d25IN2VFWU5hR0xYbUZFNThqWU9Md0NRWnEyN1ZqU2hWQ3pOVi83d3JNUGFX?=
 =?utf-8?B?N3lYQU00Wmc4RGZpYkp1UzEyRStxaW1taGt3cWFuTXBlK0ZLQWsyOTArUXBa?=
 =?utf-8?B?QWdqSTNoOU5ZVlFDbmxuQW82aHh5V1pOTW9qMkhLTnN1Uzl2S0ovenMyWnQv?=
 =?utf-8?B?N2lBWUljVnNUbjFaTkhXYUJoOEc5aTQxejlnYVFDMm9BTlNvUjJ2a1UxdHBm?=
 =?utf-8?B?empmU25uUFp3TXRKSlh3aS9RSHByTzd4M1U1N3U1Y3pOWE16RGlMaVJpYmxD?=
 =?utf-8?B?VzhHeVQ4VmxnMUlCVkxNVnV1bmttTExwa29XbmIvKzVpdmVoSFB3V0xaZW43?=
 =?utf-8?B?cGdTWmtKakxhZ21rWG9KcG8ya1IyRXVaRU9LUFNuY2dtaEtyV1R1Z3UyVVpz?=
 =?utf-8?B?MXRsMDBscFdiUHdYZFpaeWJaQ1BRaVN4MVVaVURhSHE1OTQrKys2WnVzLzU3?=
 =?utf-8?B?aldzT3V0TUZ2M0tjY0pZRk5vVkpQLzgwUUlvRjF5a2JFQlZub3g0dlB3WVZn?=
 =?utf-8?B?RWJYTGNLMnQ0ZHB5alk1RDRETmJhaEVVdUIzNmdlRDNMNWFvQWE4eS9IdWJO?=
 =?utf-8?B?a2hjbHM4WkFGbm5LOHdpZkxoY2M4RG5NUVY2YzE4YTIzaURnNjR3STNTYjVi?=
 =?utf-8?B?RzlsUFEzTkplN1R6dWlJN1VrcTh5bzVrcVc1WU0yWjZVWHo3VXduK0FIUGlD?=
 =?utf-8?B?R2VjQ1Z1eHVlTGpBM3AyWHB0dzRIRjhuNW5vNUVyK3p3UGRyYkxuSHNqbVZa?=
 =?utf-8?B?ZHF6SVdoRFFjQTBvSW83eEFtbjBiTXhsVTlmZm1yYWw4YldaUEdONEl0Y2lv?=
 =?utf-8?B?UFJZMUdKV2RDK3pPaWdyVUVnVjU5ckZJUnI5ZEZrdVlCRDdrcDlVMzQzNUZB?=
 =?utf-8?B?VVdDMXNhSE9zYkYwa253OUc3WW90RjlBbzl1cFNYcHA2VzhaQUtIb1Ztem90?=
 =?utf-8?B?d0dKSkFDYnNTOXZqL2NFQzRCNHVmNkZoTkFUK2VkSXVYaGp5c3o1amVFWTE2?=
 =?utf-8?B?azF3QSs0cnFWcnBHZ0cwUk4zOHA3SGFJYldxTitXa1ZIVVFqVER5RmtjSGh6?=
 =?utf-8?B?MURrZTBnZUhxdnp0SnBzT2QxZm1lcGNlK1NNQWZialpGL3IwU1VrOWxKNWdi?=
 =?utf-8?B?ZmVRZGRWQUpIZjIvYWZ3ZlBIOEhWaVpFS2dGODdzdmJHNVdVU3BGNW5HRmJX?=
 =?utf-8?B?OVdGVWlCeEI5U2RqR3lkR2RZSzlTZHJ6ZGdVVWtpZEhHUGg0WWZRTE40WGdw?=
 =?utf-8?B?eFdFSGJBMmw0VVNxNkNIR0VmOXU1eEdqYXlnb2Ryb0I0UDJQYjU5c3JmaG9y?=
 =?utf-8?B?emJoY1pCRUpXUTlRYjRjTjM1YWR4cUNuaVNFZmhDTXl6dkF2V2R5ejQxZ1JF?=
 =?utf-8?B?TXpPbTJnNVJhMGxldWRMMEY5TkRaRWNOZWFEOHZtR2R4VkVaaWFua3BseFNs?=
 =?utf-8?B?WTcyNnpEZVUzRXloNU9OemQ3aEJGZnN1MXVFVXlQcUkyMHJsbVdtN2lHcERU?=
 =?utf-8?Q?MdhBo/CHSlSOuBlRHqIeO9VXY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29829270-8161-469e-a488-08db31249ae1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:42:29.2908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqMVaaeAc5yhofPrQICUX9LVYrcjgLfVsbZ16x46weikJce+850HBpNHGebw5yxD7EgB3FGLu11CsFNWxNVN5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
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


On 30/03/2023 15:29, Luben Tuikov wrote:
> Hi Shashank,
>
> Inline:
>
> On 2023-03-30 07:09, Christian König wrote:
>> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>
>>> This patch:
>>> - creates a new file for doorbell management.
>>> - moves doorbell code from amdgpu_device.c to this file.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 164 ---------------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  22 +++
>>>    .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 186 ++++++++++++++++++
>>>    4 files changed, 209 insertions(+), 165 deletions(-)
>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index 798d0e9a60b7..204665f20319 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -41,7 +41,7 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
>>>    amdgpu-y := amdgpu_drv.o
>>>    
>>>    # add KMS driver
>>> -amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>> +amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>>>    	amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
>>>    	atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
>>>    	amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 57ee1c4a81e9..7f8fcac4f18b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -579,94 +579,6 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>>>    	}
>>>    }
>>>    
>>> -/**
>>> - * amdgpu_mm_rdoorbell - read a doorbell dword
>>> - *
>>> - * @adev: amdgpu_device pointer
>>> - * @index: doorbell index
>>> - *
>>> - * Returns the value in the doorbell aperture at the
>>> - * requested doorbell index (CIK).
>>> - */
>>> -u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>>> -{
>>> -	if (amdgpu_device_skip_hw_access(adev))
>>> -		return 0;
>>> -
>>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>>> -		return readl(adev->doorbell.ptr + index);
>>> -	} else {
>>> -		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>>> -		return 0;
>>> -	}
>>> -}
>>> -
>>> -/**
>>> - * amdgpu_mm_wdoorbell - write a doorbell dword
>>> - *
>>> - * @adev: amdgpu_device pointer
>>> - * @index: doorbell index
>>> - * @v: value to write
>>> - *
>>> - * Writes @v to the doorbell aperture at the
>>> - * requested doorbell index (CIK).
>>> - */
>>> -void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>>> -{
>>> -	if (amdgpu_device_skip_hw_access(adev))
>>> -		return;
>>> -
>>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>>> -		writel(v, adev->doorbell.ptr + index);
>>> -	} else {
>>> -		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>>> -	}
>>> -}
>>> -
>>> -/**
>>> - * amdgpu_mm_rdoorbell64 - read a doorbell Qword
>>> - *
>>> - * @adev: amdgpu_device pointer
>>> - * @index: doorbell index
>>> - *
>>> - * Returns the value in the doorbell aperture at the
>>> - * requested doorbell index (VEGA10+).
>>> - */
>>> -u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>>> -{
>>> -	if (amdgpu_device_skip_hw_access(adev))
>>> -		return 0;
>>> -
>>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>>> -		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>>> -	} else {
>>> -		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>>> -		return 0;
>>> -	}
>>> -}
>>> -
>>> -/**
>>> - * amdgpu_mm_wdoorbell64 - write a doorbell Qword
>>> - *
>>> - * @adev: amdgpu_device pointer
>>> - * @index: doorbell index
>>> - * @v: value to write
>>> - *
>>> - * Writes @v to the doorbell aperture at the
>>> - * requested doorbell index (VEGA10+).
>>> - */
>>> -void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>> -{
>>> -	if (amdgpu_device_skip_hw_access(adev))
>>> -		return;
>>> -
>>> -	if (index < adev->doorbell.num_kernel_doorbells) {
>>> -		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>>> -	} else {
>>> -		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>>> -	}
>>> -}
>>> -
>>>    /**
>>>     * amdgpu_device_indirect_rreg - read an indirect register
>>>     *
>>> @@ -1016,82 +928,6 @@ int amdgpu_device_pci_reset(struct amdgpu_device *adev)
>>>    	return pci_reset_function(adev->pdev);
>>>    }
>>>    
>>> -/*
>>> - * GPU doorbell aperture helpers function.
>>> - */
>>> -/**
>>> - * amdgpu_device_doorbell_init - Init doorbell driver information.
>>> - *
>>> - * @adev: amdgpu_device pointer
>>> - *
>>> - * Init doorbell driver information (CIK)
>>> - * Returns 0 on success, error on failure.
>>> - */
>>> -static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>>> -{
>>> -
>>> -	/* No doorbell on SI hardware generation */
>>> -	if (adev->asic_type < CHIP_BONAIRE) {
>>> -		adev->doorbell.base = 0;
>>> -		adev->doorbell.size = 0;
>>> -		adev->doorbell.num_kernel_doorbells = 0;
>>> -		adev->doorbell.ptr = NULL;
>>> -		return 0;
>>> -	}
>>> -
>>> -	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
>>> -		return -EINVAL;
>>> -
>>> -	amdgpu_asic_init_doorbell_index(adev);
>>> -
>>> -	/* doorbell bar mapping */
>>> -	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
>>> -	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>>> -
>>> -	if (adev->enable_mes) {
>>> -		adev->doorbell.num_kernel_doorbells =
>>> -			adev->doorbell.size / sizeof(u32);
>>> -	} else {
>>> -		adev->doorbell.num_kernel_doorbells =
>>> -			min_t(u32, adev->doorbell.size / sizeof(u32),
>>> -			      adev->doorbell_index.max_assignment+1);
>>> -		if (adev->doorbell.num_kernel_doorbells == 0)
>>> -			return -EINVAL;
>>> -
>>> -		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
>>> -		 * paging queue doorbell use the second page. The
>>> -		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
>>> -		 * doorbells are in the first page. So with paging queue enabled,
>>> -		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
>>> -		 */
>>> -		if (adev->asic_type >= CHIP_VEGA10)
>>> -			adev->doorbell.num_kernel_doorbells += 0x400;
>>> -	}
>>> -
>>> -	adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>> -				     adev->doorbell.num_kernel_doorbells *
>>> -				     sizeof(u32));
>>> -	if (adev->doorbell.ptr == NULL)
>>> -		return -ENOMEM;
>>> -
>>> -	return 0;
>>> -}
>>> -
>>> -/**
>>> - * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
>>> - *
>>> - * @adev: amdgpu_device pointer
>>> - *
>>> - * Tear down doorbell driver information (CIK)
>>> - */
>>> -static void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>> -{
>>> -	iounmap(adev->doorbell.ptr);
>>> -	adev->doorbell.ptr = NULL;
>>> -}
>>> -
>>> -
>>> -
>>>    /*
>>>     * amdgpu_device_wb_*()
>>>     * Writeback is the method by which the GPU updates special pages in memory
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> index 6064943a1b53..f9c3b77bf65d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> @@ -306,6 +306,28 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v);
>>>    u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);
>>>    void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
>>>    
>>> +/*
>>> + * GPU doorbell aperture helpers function.
>>> + */
>>> +/**
>>> + * amdgpu_device_doorbell_init - Init doorbell driver information.
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * Init doorbell driver information (CIK)
>>> + * Returns 0 on success, error on failure.
>>> + */
>>> +int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
>>> +
>>> +/**
>>> + * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * Tear down doorbell driver information (CIK)
>>> + */
>>> +void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
>> I might be wrong, but having kerneldoc on both the declaration and the
>> implementation is forbidden I think.
>>
>> We usually have it on the implementation side only.
> Yes, that is correct--implementation side only as that's where
> the actual code can be found.

Noted, I will remove the extra doc.

- Shashank

>> Christian.
>>
>>> +
>>>    #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>    #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>>    #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> new file mode 100644
>>> index 000000000000..2206926ba289
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> @@ -0,0 +1,186 @@
>>> +/*
> Add an SPDX licence identifier as the very first line:
> //SPDX-License-Identifier: <value>
>
> with some appropriate value, maybe "GPL-2.0-or-later" (no quotes when added).
>
> Regards,
> Luben
>
>>> + * Copyright 2023 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtaining a
>>> + * copy of this software and associated documentation files (the "Software"),
>>> + * to deal in the Software without restriction, including without limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom the
>>> + * Software is furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#include "amdgpu.h"
>>> +
>>> +/**
>>> + * amdgpu_mm_rdoorbell - read a doorbell dword
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + * @index: doorbell index
>>> + *
>>> + * Returns the value in the doorbell aperture at the
>>> + * requested doorbell index (CIK).
>>> + */
>>> +u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>>> +{
>>> +	if (amdgpu_device_skip_hw_access(adev))
>>> +		return 0;
>>> +
>>> +	if (index < adev->doorbell.num_kernel_doorbells) {
>>> +		return readl(adev->doorbell.ptr + index);
>>> +	} else {
>>> +		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>>> +		return 0;
>>> +	}
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_mm_wdoorbell - write a doorbell dword
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + * @index: doorbell index
>>> + * @v: value to write
>>> + *
>>> + * Writes @v to the doorbell aperture at the
>>> + * requested doorbell index (CIK).
>>> + */
>>> +void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>>> +{
>>> +	if (amdgpu_device_skip_hw_access(adev))
>>> +		return;
>>> +
>>> +	if (index < adev->doorbell.num_kernel_doorbells) {
>>> +		writel(v, adev->doorbell.ptr + index);
>>> +	} else {
>>> +		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>>> +	}
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_mm_rdoorbell64 - read a doorbell Qword
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + * @index: doorbell index
>>> + *
>>> + * Returns the value in the doorbell aperture at the
>>> + * requested doorbell index (VEGA10+).
>>> + */
>>> +u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>>> +{
>>> +	if (amdgpu_device_skip_hw_access(adev))
>>> +		return 0;
>>> +
>>> +	if (index < adev->doorbell.num_kernel_doorbells) {
>>> +		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>>> +	} else {
>>> +		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>>> +		return 0;
>>> +	}
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_mm_wdoorbell64 - write a doorbell Qword
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + * @index: doorbell index
>>> + * @v: value to write
>>> + *
>>> + * Writes @v to the doorbell aperture at the
>>> + * requested doorbell index (VEGA10+).
>>> + */
>>> +void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>> +{
>>> +	if (amdgpu_device_skip_hw_access(adev))
>>> +		return;
>>> +
>>> +	if (index < adev->doorbell.num_kernel_doorbells) {
>>> +		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>>> +	} else {
>>> +		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>>> +	}
>>> +}
>>> +
>>> +/*
>>> + * GPU doorbell aperture helpers function.
>>> + */
>>> +/**
>>> + * amdgpu_device_doorbell_init - Init doorbell driver information.
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * Init doorbell driver information (CIK)
>>> + * Returns 0 on success, error on failure.
>>> + */
>>> +int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>>> +{
>>> +
>>> +	/* No doorbell on SI hardware generation */
>>> +	if (adev->asic_type < CHIP_BONAIRE) {
>>> +		adev->doorbell.base = 0;
>>> +		adev->doorbell.size = 0;
>>> +		adev->doorbell.num_kernel_doorbells = 0;
>>> +		adev->doorbell.ptr = NULL;
>>> +		return 0;
>>> +	}
>>> +
>>> +	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
>>> +		return -EINVAL;
>>> +
>>> +	amdgpu_asic_init_doorbell_index(adev);
>>> +
>>> +	/* doorbell bar mapping */
>>> +	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
>>> +	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>>> +
>>> +	if (adev->enable_mes) {
>>> +		adev->doorbell.num_kernel_doorbells =
>>> +			adev->doorbell.size / sizeof(u32);
>>> +	} else {
>>> +		adev->doorbell.num_kernel_doorbells =
>>> +			min_t(u32, adev->doorbell.size / sizeof(u32),
>>> +			      adev->doorbell_index.max_assignment+1);
>>> +		if (adev->doorbell.num_kernel_doorbells == 0)
>>> +			return -EINVAL;
>>> +
>>> +		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
>>> +		 * paging queue doorbell use the second page. The
>>> +		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
>>> +		 * doorbells are in the first page. So with paging queue enabled,
>>> +		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
>>> +		 */
>>> +		if (adev->asic_type >= CHIP_VEGA10)
>>> +			adev->doorbell.num_kernel_doorbells += 0x400;
>>> +	}
>>> +
>>> +	adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>> +				     adev->doorbell.num_kernel_doorbells *
>>> +				     sizeof(u32));
>>> +	if (adev->doorbell.ptr == NULL)
>>> +		return -ENOMEM;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * Tear down doorbell driver information (CIK)
>>> + */
>>> +void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>> +{
>>> +	iounmap(adev->doorbell.ptr);
>>> +	adev->doorbell.ptr = NULL;
>>> +}
