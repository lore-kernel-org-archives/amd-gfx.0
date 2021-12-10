Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AC3C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 09:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C31D10E2AC;
	Fri, 10 Dec 2021 09:57:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 851C510E2AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 09:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g975lXfwxUFNtbhan6T41gJRJikNd17VotvBWUmIYNx/KgYoWc4+uBOCqiPqz2ZYaszfwdue4W1j+kOEg/qTH3RhqSCvuSI2rc/Xv3E3G7Jv40WXy0ybRfV96SVlep1VZACyuytPjwAs/yJBgoShS9Gcc/3suKl2Xb76TEycXsv3qk5dhH7bRmdwo4M1l9D1N5b7nD+7T5TNlV+Ce1QrszvUwXOaMcFXOAoh4vkZOJQ4vY/5Tj4IvzHB0QXU0Zzyd8QrdEZYkopeyTyi+0FToinzOfkPHUXAof9eg1LZtbcVFgo9RHkRc/MFXbBPUVcAIzlkA4O2snleIeMzoeiw7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa/145kUwcdfTwFlcWBOPLUSwPwsUKOg3rVCmQHRlh8=;
 b=cr9w68h6N4ItCBubJALIpxgOi9qDLqFq06b4+QnRTVyyO8y6HLjoU4WnPyw2qM572lLe51jo204AQxsu0W3OiR9q3FAI1Q/gMrVHwl+I7ey6fA8f5JCSaEkfO5AEsG4lDxxoZ7hdSk2YlzciisIsGh+qAoCEU+KssOXPsu8Jw8/ttOuPJtWMfVVxpL0gqQFZEts+H85WQLmFhHLXaKIL9b2cbTY3P8eKWdYgZEGru7NslSb5zsBIyxo8y8qx0GEt0nH/QcBWmzBNUOUQUgjUWvKt0F4usspPfrRgOJMHHTFMCN2o/0IRdIlsn2XQJr96rBFcu+s3CsymazVMxDHZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa/145kUwcdfTwFlcWBOPLUSwPwsUKOg3rVCmQHRlh8=;
 b=GG3vwra00VXKjmt3ChmI3eUhYpC4b0rwOOWVp5NBLYYGzPBkD8Xb+qvnW6jwKVdDo63+He4ry9K8u/yG0HqcfWDzWET6/6aFr/akqB2A+etVXlwV4IrEagU1witFdsshwa9s8c1EloWBkOKPPLOOC/hbCW3A5RDNzYXiuLrlwF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1934.namprd12.prod.outlook.com
 (2603:10b6:300:109::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 09:57:36 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4%12]) with mapi id 15.20.4755.024; Fri, 10 Dec
 2021 09:57:36 +0000
Subject: Re: [PATCH v2] drm/amdgpu: introduce a kind of halt state for amdgpu
 device
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
References: <20211210093501.143523-1-lang.yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <94c4ad8d-be4d-bb16-448c-972cf3367549@amd.com>
Date: Fri, 10 Dec 2021 10:57:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211210093501.143523-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR02CA0033.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::46) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (87.176.191.248) by
 AM6PR02CA0033.eurprd02.prod.outlook.com (2603:10a6:20b:6e::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 10 Dec 2021 09:57:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3928ee6-de89-4cba-abd3-08d9bbc37e1a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1934:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1934C1A404A4C2EC095766A783719@MWHPR12MB1934.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7juPO2dQwl5H+SFrv4oBQiq3g6NFJquFZsE3Qsvb4ynHOpNWNIb+/wPOsJ3qd6An2d57Vel3Hsq1ag+qO3DX/1+KdkYi1lqlBcDRfcUN2QTcPzI4HBBk4MC/VRwsfDCdq+LEsuKxUt/QakIIgQQ7gLN957/pvMb3fEYFCSML+o/AScg6y0JMvivGCQUUKBRRZ87iGBAKZI9L/HAINKLVh5/OzcCcQvXa94Rd7zw+BuzjZWGaG5kXaZJuhKmBcYwVFIFxiMVR8287fb+H5wybyTIDA82kwwXKWRLpbZAgjuCY1iFCRMDdFj+uLHnihV+uNmRIrLlvTWwLJ3j77r7izF1pyYUdPWFFMd/hdql13pvv081hzeonpdsuNv0BIgZkHSzDgR/2HSWeF2tlenAmYLMWRY0A97/GDq0T4EUIXAuA9udv1RZzVKxFsw7iiip96sS7XiXdiVUjF8oDdWyMD5kIR9ReTU88O3QwOmOmb4rmIoiNLHYg8TjJsduM/LjUT6XfD42LA/dXBRc1AcWuSLa4HIKy+fIReyoTRyX/hhG6lgUMgiwkxP09S0vJ419ekMhkVnuUJ4XBEpwUv8LA+5c+QcSYaKBYfDcmGI3Gc6xNZTBcVfd6hEEKbJ8pA+AK14llV4gMFm512mIJxj8aXlBfeeO2RRto2NzUg98cFzS0Q8OSgg/dHww/n6ZeFiGPsZ0UOFRStqDiqRv/a9IVgouzIRCs+ThTBMijiOuRkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(2616005)(66946007)(5660300002)(66476007)(54906003)(66556008)(4326008)(186003)(86362001)(83380400001)(66574015)(8676002)(31686004)(316002)(6666004)(6486002)(956004)(16576012)(110136005)(508600001)(6636002)(36756003)(26005)(31696002)(8936002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU9qVGZzWFY2Ym1uTmFETWRIYjNhdUdzODF2ckRTNC9ya1FVM1M4UVFlV0ls?=
 =?utf-8?B?MCtLeWFyS0NPYURwZVRPVCtCYmhJRDlrTlREUUhhQTh1dEhpbjJ4REw1V2Mr?=
 =?utf-8?B?aTdYc1dXYmJnMm1zSFdjT2RMMklHRDFLSkJpbUUyR0RRbEFvQmgyeE53dTh0?=
 =?utf-8?B?ZGpFOXdXWVpSaTNGRm1tSmRZN25hOG82UlFQS3FTNm9seTk1YURCVlhhVUJ2?=
 =?utf-8?B?THozd2diYm44QWNZckJjNUFFdXN4V0c4N2t0SjBOUThSVm5UUTE0SGR2OVNT?=
 =?utf-8?B?ckFsd1BsRE9sZUt0WndvS3lmUit6WkJLQ0c4b0h4M1ZCM0dESEJ2WFgwd29Y?=
 =?utf-8?B?SlQ3bHZpb0NXdGpzZVg3aCs0c0VQWmZtWmpLK1hoWWM1M2dKanA5bHcwSXpW?=
 =?utf-8?B?dmU5S2c0ZHYwNkxNVzIrODVtTFBGaEU3UFFUd3FpUFY4WSsyKzB0TEFFU1VE?=
 =?utf-8?B?KzRjcmxaSFIzS2VBbmNzclN5Vklhb3RIYWJwK2NKejhGdCtSMHJpK01LNmxq?=
 =?utf-8?B?R2lNKy85M3dYYnRaRkxSaEJVcFFjQmptZkJjd0JLZHloSTFIb29yVGFQZlpF?=
 =?utf-8?B?NXhKMkdaMjFaNXpYVzVIdUNuYXc1NExVZlRGV3FERTloek91MGl5SkJ6UkFP?=
 =?utf-8?B?WE9vM0MvZkZXdkRNM3pqbjZteDR6R3lrdmpGSFQ4TW5xSlJHbEZqbWx6K3dP?=
 =?utf-8?B?OUx5MnQvbmRIaXdzRzRyaVZ6YlNHeDBSZWRjZVQ1bzZpSDYxNlYzZnE0Z0xO?=
 =?utf-8?B?d3ZBV2hFOW8rS0lPS3d5UmJGcFByQTIrNEhOL0xvTUlqSVdVZ3V4U2ZvQ0Z3?=
 =?utf-8?B?VXlnTFdCdDhNZGQxSU1VWlhINENWUnZiYnozQTU2ZTRueGYyak9vK1hxcFZa?=
 =?utf-8?B?RWtqcTZ1L3FNQWhDSnVnOCtyYXRkMXIwQ3BjN1JCZGNBcC9CSGJEK3VDSmJ6?=
 =?utf-8?B?Nlh4aElDWFhOcGcvNHpob3FmT2VvYjNvS3NJby9DR0xsQXVHYkJwajRXRHBv?=
 =?utf-8?B?Z043bWtCZ25sWFpvdTZYbzdLREkvaVBkT0ZJNjZCVDl0clRSWVU1ZzhCanNo?=
 =?utf-8?B?NlhySHB3U2k5enErRGV3a0dTU1ZQTFQrdm1zNUt1dUg5TytCNnVoU081R3h1?=
 =?utf-8?B?WkdVU2taUTVoUXY0SVFONUNvejZvZWdjaksreVdEdTUya2E3SGtUZ2ZWQ3ZX?=
 =?utf-8?B?U3hlWjRUZXZEQXp0UkhFam4wam1nRk9jM3ZoWEp4OU90TENWU1htUnljRzdI?=
 =?utf-8?B?dFVLcTEreWZiZXpNSGhyeDhtWXlXcG9BUkZEdExsNTZ5bm1aV2o0VmxIcEpy?=
 =?utf-8?B?UmkvbWhqdHdPZGhLL05pUUl2bWUzVlIxbXRxTlNRRHlib05KMGRjTEZ1REV0?=
 =?utf-8?B?Y3BDSTU5K0JVZzhMZ2NVUkZFMnl6MEVvVzZmSjV3VzF4bElLdVpRWkd3YkMr?=
 =?utf-8?B?UkVwb3ZCZXJwQnFQSW9MQ01MdldKazcreUc0TWg1Vm9sdHJrUGdsYTREY1NB?=
 =?utf-8?B?c2tBQjdjcXZFR2p2bVVGZEdOMjdEVmJPYVk2ejNiZWlvODFsbS9UV1RZVmhz?=
 =?utf-8?B?bnJVSUpSLzQyVHhCK1BtS2RSSlB4SU5pZkNyZG1wZSsyTTBzOGxwWWFZS29w?=
 =?utf-8?B?d2UxYVNWejByeE9ZVy8wNlBHWDhMa0JGRWMxenllOUtaS01lUjYremdxMDhB?=
 =?utf-8?B?bEduTGZJU2ZSeld4Tm5PMkNjcFQ4SmdUVFplTWZRa3RIVDEra1JaRXVNNDVZ?=
 =?utf-8?B?dUJBaC9TalVISk9pd29NcU8waVNFSDZ6bW1sUEFIMFgvSEVoYWQwTlhNMjU4?=
 =?utf-8?B?NHRpYWttNzd1c3A3MWFPYldXekwwNm5zd1ZwcWk2YWxQby9VWkVEci9aZ3pZ?=
 =?utf-8?B?bklsUXVtNEc3WE5DL3dseS9KREVaSjcveUkzZFh1VUM5NmlyZGtVT3ZMTUdN?=
 =?utf-8?B?eXFpM1M2SmxMb2NLbmJ6TUdQSHhNSXVGUm96TTVSM3U2c2xUbWtUOEFXV3gx?=
 =?utf-8?B?cm03VFJQVE95dSthSFR1OGpHb3Nsb2FLSXk5ekxUYWJTWHpnU0c3cUlIVDZl?=
 =?utf-8?B?bDU1K2hYZzhFUjIvWVNERXhWdjR4RUNoTTJxK0NBbUdIQkg1VmpxeFFzNk9M?=
 =?utf-8?Q?5gk4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3928ee6-de89-4cba-abd3-08d9bbc37e1a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 09:57:36.0908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQbj4dhCSdwFj0QSEhaTXYTvYXxnZkVEj2Ji916HDthJx62FgGWTvAlFDxRzPF6M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1934
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.12.21 um 10:35 schrieb Lang Yu:
> It is useful to maintain error context when debugging
> SW/FW issues. Introduce amdgpu_device_halt() for this
> purpose. It will bring hardware to a kind of halt state,
> so that no one can touch it any more.
>
> Compare to a simple hang, the system will keep stable
> at least for SSH access. Then it should be trivial to
> inspect the hardware state and see what's going on.
>
> Suggested-by: Christian Koenig <christian.koenig@amd.com>
> Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Signed-off-by: Lang Yu <lang.yu@amd.com>

I'm not 100% sure if the amdgpu_device_unmap_mmio() in necessary here, 
but for now that patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Thanks,
Christian.

>
> v2:
>   - Set adev->no_hw_access earlier to avoid crashes.(Christian)
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 ++++++++++++++++++++++
>   2 files changed, 41 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index c5cfe2926ca1..3f5f8f62aa5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1317,6 +1317,8 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
>   void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>   		struct amdgpu_ring *ring);
>   
> +void amdgpu_device_halt(struct amdgpu_device *adev);
> +
>   /* atpx handler */
>   #if defined(CONFIG_VGA_SWITCHEROO)
>   void amdgpu_register_atpx_handler(void);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a1c14466f23d..8fe7ea6cee18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5634,3 +5634,42 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>   
>   	amdgpu_asic_invalidate_hdp(adev, ring);
>   }
> +
> +/**
> + * amdgpu_device_halt() - bring hardware to some kind of halt state
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Bring hardware to some kind of halt state so that no one can touch it
> + * any more. It will help to maintain error context when error occurred.
> + * Compare to a simple hang, the system will keep stable at least for SSH
> + * access. Then it should be trivial to inspect the hardware state and
> + * see what's going on. Implemented as following:
> + *
> + * 1. drm_dev_unplug() makes device inaccessible to user space(IOCTLs, etc),
> + *    clears all CPU mappings to device, disallows remappings through page faults
> + * 2. amdgpu_irq_disable_all() disables all interrupts
> + * 3. amdgpu_fence_driver_hw_fini() signals all HW fences
> + * 4. set adev->no_hw_access to avoid potential crashes after setp 5
> + * 5. amdgpu_device_unmap_mmio() clears all MMIO mappings
> + * 6. pci_disable_device() and pci_wait_for_pending_transaction()
> + *    flush any in flight DMA operations
> + */
> +void amdgpu_device_halt(struct amdgpu_device *adev)
> +{
> +	struct pci_dev *pdev = adev->pdev;
> +	struct drm_device *ddev = &adev->ddev;
> +
> +	drm_dev_unplug(ddev);
> +
> +	amdgpu_irq_disable_all(adev);
> +
> +	amdgpu_fence_driver_hw_fini(adev);
> +
> +	adev->no_hw_access = true;
> +
> +	amdgpu_device_unmap_mmio(adev);
> +
> +	pci_disable_device(pdev);
> +	pci_wait_for_pending_transaction(pdev);
> +}

