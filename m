Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B26BC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 11:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02D410EDB1;
	Thu, 30 Mar 2023 11:09:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9300610E232
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:09:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILmPzB9JNpALHo2tUyxyMzyf5RxOOtcVLKuRWu/9T2kqdYQUSz9O7X7lV5kl7msJWn2rXfiU8fFya5PheueQRAFLxCBBhSOuDp+0gOHUa4cs5CvQf/EmL7HXfXSKB3do7846zEzhlylFOOPqR4P06y+DY6UiZWrAlGYwIZN/f+INq93+DoJs/6mj1A0Tmf2JoO0d3Pj/zTlH3CT85HSI9AJQWmxnSKw59VvazCwaOccFe7puNOKFDpsjx0VZsBXrXHFTUI2SZFOmHFkqXYhpAJYaGKNlHrusR5NQb8DEn5cl/4hFaPuLaajP4FxzY4A278C1lVDZQtQqDOB6uDM4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEaf/xCkKG5KAe0vtOH4hdpXmii80jiw38kuEnyAErg=;
 b=IpRWIvLKZcvT4zyfbf3Zljy85qZoUwXrTFcxSsStcVUc7BBtLOAbeW4to3rznKw7UGNGsNEmKVx/7Hot2QcFXkG5UjUiC29SOmgiDpde8SM35ncN+fRxZkquk34iEp0gqNgv12mP/cWniimP7Mlvu7i96Qfucd56M3KtpyfhwUlIrjkzduKrvO2YchJQTJ5JXv2IKYQgrQL2a1HthmDbdBrSHaC5wWjkbNYGHJnZ4LweVDD7U426o4MVgnhZrZVu0jD4IYVox8Qiq4bczMy1yW0FgCAUurS+IDiZXp05o/6D/z2F6Ccl1knoHO2+r2u6WP6K7UCQSnWqOFrSHz66/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEaf/xCkKG5KAe0vtOH4hdpXmii80jiw38kuEnyAErg=;
 b=ic7RLqE2HyVGeuGuztp/VSnoUn/NfoRHTrupRrbUqbJLHN1/Kz9LIccNdwr1iHcpZzCAUiK68fWEVmJ9LljzU5LgvCA7OsvF8bLUerjTvbIhucb/DBet7FoQ9SP6tZW/FNUMC1Wwm3qzhlFAW1bCy3iB29P272RKg6vxG3y3yt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 11:09:36 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 11:09:36 +0000
Message-ID: <ed0f7cb9-78da-550c-8d91-6989e0ceb7a2@amd.com>
Date: Thu, 30 Mar 2023 13:09:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 03/16] drm/amdgpu: create a new file for doorbell manager
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-4-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230329154753.1261-4-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: 5801a8d9-1e1f-4634-7163-08db310f3fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldk85gfxT2wNsXBVl7/ObfQJQiYRbeDhLe/6zzhaRzrpxHisfHd4K6/T1pgX6aLxJb5TnjgrYEcniMibAvfUXZWX+FLzTA9gwfkSgJKDVrR3AVOCLxQE9PVQlUJ7T5/f7EHIoB0iGKQux4rtJxGibFBLoIluDtnStmaIz/WlQcxBDNei46n857+zq0CA/04CcA0/oTPCN8UlzILtgPW7J09gAGVjS49T8LxF2W1Lv/h2H1GlKvC1Xg97Jo0/PekjN2M2HNet74REUmlMxBy6vmUg0t6FK45tEkCQPCaVMr25Rg3ZfUACytChJ8uzCiSt4ZghSKhd9eV/hr6nyspbHVB9euYwXHJwOCE3P/9rzXcJEoPtwAL5ORMbXUrC4eb08DalNGwSt88LfaEKeN6bilVpTej1NbM7neqtg3/rGD8VRQvhuvhkV172LfmKdeeV9UZ7VD22STaldiYqQgFkOobfgBIHPh30txpNLtlJqjveesOw1pGKRretFqzo2oB3RrsuJOm+7w2tpF5aVL+e8neJQAAqEP2YoUjw8uB2mu1YgzTEYE4UKAWvBI+CG7SUwNvfyErE6NDSn5ilUxQi1jU+LKy1NvHZ/ZkK2YYEWJXpVMkcgg1+KktF/gikqD54vBzzNBgg0hAdmoCyX2D2Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(186003)(316002)(4326008)(66946007)(54906003)(31686004)(26005)(66556008)(8676002)(6512007)(66476007)(6506007)(41300700001)(478600001)(8936002)(6666004)(2616005)(83380400001)(5660300002)(30864003)(2906002)(6486002)(66899021)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHpWVmZ4NnZwbzQyampEeitqVjhlMTZTOUcrcEhNTHNlWHJPMkVFN3hYaUN1?=
 =?utf-8?B?TitQQmNraWtsaUdVR1lKSjV5YWhEcEkza0I0alU5eXJWWGJqa2hrM0V4clph?=
 =?utf-8?B?U0MxZUJEdEdxcjhJNThzWDM3THkxdTgzR1AwY2ZFZWswcjhJOFA4YXhueFB2?=
 =?utf-8?B?akszQVJScENScGdQek9oQnNBQ1JGTlFueHBNZ1l0dklqaHREZnFnM2ZVS1hi?=
 =?utf-8?B?RDhLUUE5KzcwcXdDRXR5S0daSGVDS2RmRTlWazVYMjc4cXMyTlFvWFBvdnJs?=
 =?utf-8?B?dzdJM1k5Rkt3dGtveDFSOGljWFM2ZTErUEtVWUxFRjBjK0RRWERiam44SkYw?=
 =?utf-8?B?UXNxM3IwOVl1SXA2bU5GdEFmU1V5VXF1dnErL1lmMnBjcnZkTU0vVEk1Zzlv?=
 =?utf-8?B?RUpWRXdobS9NazJUY05MeXZwNENhd1VpMFdnMzZZaWtTS0VNZHA3V3pvUHpC?=
 =?utf-8?B?bnVDMFIxa2RZWEMyd2FiWUJOcWtqRGhkQjUvSzZDWHEyQm10RkNqSDhzMzdy?=
 =?utf-8?B?cTBIZ1cvbER5ZGlKVEg4aWZUSEFNZkRRckhvaTB5WXV1Mmh5Vm5FM1EyYVJ6?=
 =?utf-8?B?NE1GVU9BZ2kySnovMThQYmRUenVXWVc1MExTMURQN2V4RmNUR3pxV1BaRmQy?=
 =?utf-8?B?dEFhclQ4Y25QT0NUQUdKYzlzbkw1OXJPRWhlMEZoamNzMWN5dmR2M1BOSmpS?=
 =?utf-8?B?a1dWWHlHaTBNTW05Y0hkaEgzQ1piN2xUYXg0U0hJRXVaMmJIcWp4c2dOQmNr?=
 =?utf-8?B?VVRNeWRFb1lTQW41ZDBYaExiRVg2ckVJVGNYbENiUFlIZ3dzdGY0bUMzNG1q?=
 =?utf-8?B?dWRuOTRYNzRjd1p6ZWo3b2dWZVlOZTBwK1hnV0RDTEtLc2RtL1RWYXh3Q2M0?=
 =?utf-8?B?VVl1allmLzdqaXpiR0FyYXRicmRTS28xZUJsajFObjdad21ZSWgwamc2alYw?=
 =?utf-8?B?a29jV2kwcGxMZG9oekIwY2JOVHNLRFdCR09TM2xsakNMMlhjYlhlTE5BVi9n?=
 =?utf-8?B?eTE4SCswbDZua3R1K21sMzh5T3V1K3VRNHZKRnhsS1JqaFVHenk2Qy8yVlZl?=
 =?utf-8?B?ZUlYWW9NTTFFRFFPRXZuU1lmNG5YNXBFMWJweW02czcydDREN2JBVWRMNitn?=
 =?utf-8?B?RXppdXFtR2thWU5jT3F4VnNQYTNiUk8wNVhxdEVoMTJBdElCVDQyUnBQWjNN?=
 =?utf-8?B?bGVJOFBEK0hFSUprVE9Dd0NDUWlLaDVjdzZobkNZSXI5bHdvNEh1Z2pETUJS?=
 =?utf-8?B?ZVMzOU5JaThwc0hNVjZac1JEcllCeUZGSDRWdTI5UndZTWVMbEkwYmY1MVNL?=
 =?utf-8?B?a2prdWlKeHk0OVBQb0RYcW5CUXc5NGY0NGRFK1dNeEtpZFlrcGpnQXdrQmhx?=
 =?utf-8?B?bGI1Tm01SmVHVXkzWGFMT3JUS1pYT29TUmlzUGwwWWJWL28zSkNaUXpaNUNw?=
 =?utf-8?B?OFJjVXh1RWJZZTJ3Y0dSdWs1eWF0WG1BVUVmTGhtR0tCbkM5eGZ6d2w3SXRX?=
 =?utf-8?B?cVBFMHlUM1Zwd3hBdk05MlZ2QTFTdmlJSER6UjZRMExJQ29tL0xmdFVEQ0Zi?=
 =?utf-8?B?MGF0djlJSk1acXBuT3oyNUF0TXBjQXdLSHJ5UDJHZmRucmpxdHBQVHRqYmlL?=
 =?utf-8?B?WGgrNEM3UVVqRHRkVnRnNTRjWXl3RWtad3lvL1VidEJBVktncGY3ZjRDb0hU?=
 =?utf-8?B?OTV0OVdYbG5WcUh4c29xRDJyeDBIbUJ5RU9tODg0L2xWUi9zaVhqRUlLbFM5?=
 =?utf-8?B?Q2J6RDhIYlZRSFZlQUVVZlMzNVN0V3VTQkd3QUFFQjNDUUQrM0RURjJ5Mm5F?=
 =?utf-8?B?Y2RwMmpORnRDa2NJTHpGbC9BWFNSS3ZieVVMdzVDVEc3MVR5ZjNYQ2xORUFX?=
 =?utf-8?B?VW5lSTBnbGxCdGxnUlJCamxCT1EydlZlWEg3dnRuNWF1cDRXbitodWhadVN6?=
 =?utf-8?B?bjU5Q3dackFHWTZHcFpSUTdWdmpkeEJnNXcxa2lZeFZwYi9ieVA5Qlhvalc4?=
 =?utf-8?B?VGZ0TXR0WnVFdUNFemRJelhFYVZKRnJXd0dVQ1JQd3MxMjlJQllNcVRqS0Vl?=
 =?utf-8?B?TUlCczNqSmRRQnRGcktHcVI5U0hyYzd5ekZ5UXZ4aDd1RTBsOUd3KzYxNExS?=
 =?utf-8?Q?TZjA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5801a8d9-1e1f-4634-7163-08db310f3fb2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:09:36.7352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2t58uUrf/ECfc5UZdO1MiVk13CaALfQ/iMt8y1y0qeSLhAKM2X/uP3n5XUMR3qE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
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

Am 29.03.23 um 17:47 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch:
> - creates a new file for doorbell management.
> - moves doorbell code from amdgpu_device.c to this file.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 164 ---------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  22 +++
>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 186 ++++++++++++++++++
>   4 files changed, 209 insertions(+), 165 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 798d0e9a60b7..204665f20319 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -41,7 +41,7 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
>   amdgpu-y := amdgpu_drv.o
>   
>   # add KMS driver
> -amdgpu-y += amdgpu_device.o amdgpu_kms.o \
> +amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>   	amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
>   	atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
>   	amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 57ee1c4a81e9..7f8fcac4f18b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -579,94 +579,6 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>   	}
>   }
>   
> -/**
> - * amdgpu_mm_rdoorbell - read a doorbell dword
> - *
> - * @adev: amdgpu_device pointer
> - * @index: doorbell index
> - *
> - * Returns the value in the doorbell aperture at the
> - * requested doorbell index (CIK).
> - */
> -u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
> -{
> -	if (amdgpu_device_skip_hw_access(adev))
> -		return 0;
> -
> -	if (index < adev->doorbell.num_kernel_doorbells) {
> -		return readl(adev->doorbell.ptr + index);
> -	} else {
> -		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> -		return 0;
> -	}
> -}
> -
> -/**
> - * amdgpu_mm_wdoorbell - write a doorbell dword
> - *
> - * @adev: amdgpu_device pointer
> - * @index: doorbell index
> - * @v: value to write
> - *
> - * Writes @v to the doorbell aperture at the
> - * requested doorbell index (CIK).
> - */
> -void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
> -{
> -	if (amdgpu_device_skip_hw_access(adev))
> -		return;
> -
> -	if (index < adev->doorbell.num_kernel_doorbells) {
> -		writel(v, adev->doorbell.ptr + index);
> -	} else {
> -		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> -	}
> -}
> -
> -/**
> - * amdgpu_mm_rdoorbell64 - read a doorbell Qword
> - *
> - * @adev: amdgpu_device pointer
> - * @index: doorbell index
> - *
> - * Returns the value in the doorbell aperture at the
> - * requested doorbell index (VEGA10+).
> - */
> -u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
> -{
> -	if (amdgpu_device_skip_hw_access(adev))
> -		return 0;
> -
> -	if (index < adev->doorbell.num_kernel_doorbells) {
> -		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
> -	} else {
> -		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> -		return 0;
> -	}
> -}
> -
> -/**
> - * amdgpu_mm_wdoorbell64 - write a doorbell Qword
> - *
> - * @adev: amdgpu_device pointer
> - * @index: doorbell index
> - * @v: value to write
> - *
> - * Writes @v to the doorbell aperture at the
> - * requested doorbell index (VEGA10+).
> - */
> -void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
> -{
> -	if (amdgpu_device_skip_hw_access(adev))
> -		return;
> -
> -	if (index < adev->doorbell.num_kernel_doorbells) {
> -		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
> -	} else {
> -		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> -	}
> -}
> -
>   /**
>    * amdgpu_device_indirect_rreg - read an indirect register
>    *
> @@ -1016,82 +928,6 @@ int amdgpu_device_pci_reset(struct amdgpu_device *adev)
>   	return pci_reset_function(adev->pdev);
>   }
>   
> -/*
> - * GPU doorbell aperture helpers function.
> - */
> -/**
> - * amdgpu_device_doorbell_init - Init doorbell driver information.
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Init doorbell driver information (CIK)
> - * Returns 0 on success, error on failure.
> - */
> -static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
> -{
> -
> -	/* No doorbell on SI hardware generation */
> -	if (adev->asic_type < CHIP_BONAIRE) {
> -		adev->doorbell.base = 0;
> -		adev->doorbell.size = 0;
> -		adev->doorbell.num_kernel_doorbells = 0;
> -		adev->doorbell.ptr = NULL;
> -		return 0;
> -	}
> -
> -	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
> -		return -EINVAL;
> -
> -	amdgpu_asic_init_doorbell_index(adev);
> -
> -	/* doorbell bar mapping */
> -	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
> -	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
> -
> -	if (adev->enable_mes) {
> -		adev->doorbell.num_kernel_doorbells =
> -			adev->doorbell.size / sizeof(u32);
> -	} else {
> -		adev->doorbell.num_kernel_doorbells =
> -			min_t(u32, adev->doorbell.size / sizeof(u32),
> -			      adev->doorbell_index.max_assignment+1);
> -		if (adev->doorbell.num_kernel_doorbells == 0)
> -			return -EINVAL;
> -
> -		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
> -		 * paging queue doorbell use the second page. The
> -		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
> -		 * doorbells are in the first page. So with paging queue enabled,
> -		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
> -		 */
> -		if (adev->asic_type >= CHIP_VEGA10)
> -			adev->doorbell.num_kernel_doorbells += 0x400;
> -	}
> -
> -	adev->doorbell.ptr = ioremap(adev->doorbell.base,
> -				     adev->doorbell.num_kernel_doorbells *
> -				     sizeof(u32));
> -	if (adev->doorbell.ptr == NULL)
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
> -/**
> - * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Tear down doorbell driver information (CIK)
> - */
> -static void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
> -{
> -	iounmap(adev->doorbell.ptr);
> -	adev->doorbell.ptr = NULL;
> -}
> -
> -
> -
>   /*
>    * amdgpu_device_wb_*()
>    * Writeback is the method by which the GPU updates special pages in memory
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 6064943a1b53..f9c3b77bf65d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -306,6 +306,28 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v);
>   u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);
>   void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
>   
> +/*
> + * GPU doorbell aperture helpers function.
> + */
> +/**
> + * amdgpu_device_doorbell_init - Init doorbell driver information.
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Init doorbell driver information (CIK)
> + * Returns 0 on success, error on failure.
> + */
> +int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
> +
> +/**
> + * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Tear down doorbell driver information (CIK)
> + */
> +void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);

I might be wrong, but having kerneldoc on both the declaration and the 
implementation is forbidden I think.

We usually have it on the implementation side only.

Christian.

> +
>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> new file mode 100644
> index 000000000000..2206926ba289
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -0,0 +1,186 @@
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu.h"
> +
> +/**
> + * amdgpu_mm_rdoorbell - read a doorbell dword
> + *
> + * @adev: amdgpu_device pointer
> + * @index: doorbell index
> + *
> + * Returns the value in the doorbell aperture at the
> + * requested doorbell index (CIK).
> + */
> +u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
> +{
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
> +	if (index < adev->doorbell.num_kernel_doorbells) {
> +		return readl(adev->doorbell.ptr + index);
> +	} else {
> +		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> +		return 0;
> +	}
> +}
> +
> +/**
> + * amdgpu_mm_wdoorbell - write a doorbell dword
> + *
> + * @adev: amdgpu_device pointer
> + * @index: doorbell index
> + * @v: value to write
> + *
> + * Writes @v to the doorbell aperture at the
> + * requested doorbell index (CIK).
> + */
> +void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
> +{
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return;
> +
> +	if (index < adev->doorbell.num_kernel_doorbells) {
> +		writel(v, adev->doorbell.ptr + index);
> +	} else {
> +		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> +	}
> +}
> +
> +/**
> + * amdgpu_mm_rdoorbell64 - read a doorbell Qword
> + *
> + * @adev: amdgpu_device pointer
> + * @index: doorbell index
> + *
> + * Returns the value in the doorbell aperture at the
> + * requested doorbell index (VEGA10+).
> + */
> +u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
> +{
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
> +	if (index < adev->doorbell.num_kernel_doorbells) {
> +		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
> +	} else {
> +		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> +		return 0;
> +	}
> +}
> +
> +/**
> + * amdgpu_mm_wdoorbell64 - write a doorbell Qword
> + *
> + * @adev: amdgpu_device pointer
> + * @index: doorbell index
> + * @v: value to write
> + *
> + * Writes @v to the doorbell aperture at the
> + * requested doorbell index (VEGA10+).
> + */
> +void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
> +{
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return;
> +
> +	if (index < adev->doorbell.num_kernel_doorbells) {
> +		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
> +	} else {
> +		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> +	}
> +}
> +
> +/*
> + * GPU doorbell aperture helpers function.
> + */
> +/**
> + * amdgpu_device_doorbell_init - Init doorbell driver information.
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Init doorbell driver information (CIK)
> + * Returns 0 on success, error on failure.
> + */
> +int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
> +{
> +
> +	/* No doorbell on SI hardware generation */
> +	if (adev->asic_type < CHIP_BONAIRE) {
> +		adev->doorbell.base = 0;
> +		adev->doorbell.size = 0;
> +		adev->doorbell.num_kernel_doorbells = 0;
> +		adev->doorbell.ptr = NULL;
> +		return 0;
> +	}
> +
> +	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
> +		return -EINVAL;
> +
> +	amdgpu_asic_init_doorbell_index(adev);
> +
> +	/* doorbell bar mapping */
> +	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
> +	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
> +
> +	if (adev->enable_mes) {
> +		adev->doorbell.num_kernel_doorbells =
> +			adev->doorbell.size / sizeof(u32);
> +	} else {
> +		adev->doorbell.num_kernel_doorbells =
> +			min_t(u32, adev->doorbell.size / sizeof(u32),
> +			      adev->doorbell_index.max_assignment+1);
> +		if (adev->doorbell.num_kernel_doorbells == 0)
> +			return -EINVAL;
> +
> +		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
> +		 * paging queue doorbell use the second page. The
> +		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
> +		 * doorbells are in the first page. So with paging queue enabled,
> +		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
> +		 */
> +		if (adev->asic_type >= CHIP_VEGA10)
> +			adev->doorbell.num_kernel_doorbells += 0x400;
> +	}
> +
> +	adev->doorbell.ptr = ioremap(adev->doorbell.base,
> +				     adev->doorbell.num_kernel_doorbells *
> +				     sizeof(u32));
> +	if (adev->doorbell.ptr == NULL)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Tear down doorbell driver information (CIK)
> + */
> +void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
> +{
> +	iounmap(adev->doorbell.ptr);
> +	adev->doorbell.ptr = NULL;
> +}

