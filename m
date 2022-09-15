Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D0CECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 06:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 865AC10E116;
	Thu, 15 Sep 2022 06:32:00 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D95910E116
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 06:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMf1doAUHXLNLy/8u8TRcm3Z63FtHNpgehd5voyYV3yhWrULF5PPHnHOBhE4HSUk2A3AyPN11IVTX7zbCGT0wfLl33XqmDghDGO0ulw0hft45uDxHF5xMcQwOaKKEBuwNOHS4RH/BlA3pA1zVfKB17ja78PbVGYOIW+M3TFHrLSjN/iCxZbNeJ7fSv56ixYzcZ6X6X045qGMJ6J1Jsp9y7tpxCpv2Oh5reUwPwgfPyIUnV0O+e9q462SEKYahf5AuQQclNw82qrHI7oWlG7erH7IypCdgHM6cY/5pGjDYpX/Iluhra8maRswSx2H8kqRo3lQ08+5fghCzF0igKMWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdXU3YvCzMVJejuYDf3JVWGrOt8uwZ4py/QmmFnj9yA=;
 b=Lfe+n3M2cJOSM54R02gxYjYhvCXNflt/9MXYN0GQdPG3T84YqQWaECSsU3HvabI9J0EdJ4umRVFgn/hklHLBqpmWxxi0O8Dw4HKxA11/ZvtiblSYUPrJZlRKf5fBx1ljDoDigFJu99n8LMG/09ZU50m2xYyQgBAJYSLYJfFtjSWRBrSgdXsPXrFdEiMEZtPQWlYUM6s0wcGjjR2ou2pEuRpikHp8Bs58pKrdCKWeh0TYLZm7BgtTW9WsRHEmCzinqwJkzIYbKV5ECC4ucwrQZl0C/VErzMCWY6af4lii4dDXWnxeUbXLi9Vz3ZNZOmDvRiIycwxYymuzTbFcyVrBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdXU3YvCzMVJejuYDf3JVWGrOt8uwZ4py/QmmFnj9yA=;
 b=iO9d6XBtHa2J8H4zIfGTInLbKEbGEinV7gTaaGO79LbHectQ2p2MxS+8rj/e+5ZPpT6cOsV40VfRKcG5KiiS7YXJM1K4rNSCZ/wMZGzCH+Y/OnmElsVkZUKwbCGABhp2ha+/LUy1pI+nHVbjfYnIHjIb7PFxI25LjSu3fYKzl8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 15 Sep
 2022 06:31:51 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a%4]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 06:31:51 +0000
Message-ID: <1ea8528f-fb55-e8b1-73c8-bf8935f9870c@amd.com>
Date: Thu, 15 Sep 2022 08:31:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
Content-Language: en-US
To: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
 <DM6PR12MB4340D28D9D23472D571727D7FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM6PR12MB4340D28D9D23472D571727D7FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0010.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::22) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: e2365b7f-19da-4f08-99f0-08da96e3f966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7CHu+1X0Hr2C8S/yas/uPc/OuBOLgzIyopCRDkE99/77BC7rkKB6kGdU2bpnpbkfXffREgQmxbP/22a1BIAjtkGGcC9DjLcvVARuUwdS4qoYTePXq9vz6WzsBuvvJ4DlDOS5H5tHERQksLISDqq/PbIveJKi0YWQ7Vd0saR5LZP+rR9lwmxQPW6h3imVDDBEvASePKdYmEoD8IjFw27O3MGgpsZW6U8T8qHXd69ND8Egy+3XB7yMbDuvJrMqv7yK4QkV4LaHbcNrlfX38i1sRA69/XPH4E42jPSO3/QgtNWdAqenL3dYT9AuxUJMxq9W8BmzOiLOTzrhb+rpwHp9UT1KBtVupG9E9s4rw4AUVdamnYDnitIafCDgFgk2MhD0S5um0Uzdm5XrpLEg46mxiEofYuod1aFTJ66s7hEUqgBRTLH+xLSPjWT9YNTEMKzczfkixnoQX5L7M8ZR+mf3yEcGg23lF3KqrS6/A34qyy5kjeq4fdu5hRW1rIFE+C4xyvfTu9KJW7CvfUqZeiPEdsNQo1gEFXdhJENadv/+Ykw4yu2MjQGzes+6rk9oRP2dbvNmzxxOUdQbIKQ4De9sDB83hWCblVUnx1rISxDjlxoH7RJaw5evdiCYg3Xb5V1gyClq5JW/cwW9U3+yxMQnDKXTgLrdSxgKzcCRqE9jFbV0SZu5nsqfZfQYhuzQnXWI/8wFEEvD3+jYuTyKdZ3nQ5TQZ/8fOmk2KfyOZO0gB0T5xm/HyCSdb48NGE+Ms4rhVsxyrFmOOkmClM0936ZhS7wP5FK89IkP+fgQ5WTp9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199015)(6636002)(31686004)(6512007)(6486002)(86362001)(2906002)(2616005)(6506007)(8936002)(66946007)(316002)(26005)(31696002)(5660300002)(36756003)(41300700001)(83380400001)(6666004)(66476007)(478600001)(186003)(4326008)(38100700002)(110136005)(53546011)(8676002)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0VaVldLeEVGWWtpbCt5dHk5TVFwOHRRSFhrZk1GSzFDd3JHb1puN1lOUGJ4?=
 =?utf-8?B?RGU3bk1icXNoYmhqQUhMbHplVVNXOUdtY3BEZ1BXRVdkWDZrZk5LTFF4bzFB?=
 =?utf-8?B?VzYyREdlYUxidkFNVEpBdFhGNlJhNGRKQkVpWlYzQSt2OUlKKzRrYUhSNjYy?=
 =?utf-8?B?bGIxK2xyMElkMWl3RzBwZmpjY21iNDhTYy8wWldkWHBkWGFVOVBzdFgvTG1B?=
 =?utf-8?B?bnlqL2ljdUk1dmNyYSttTVFMUlZRbEVxSDBodUh2WUFKYzV1QUM5SURKTUpk?=
 =?utf-8?B?Tkl1NElaRG4vUnREaEhiall3Rld6aWQvMmlMeUZyUnE0TnkyTXdPUXZVY3FS?=
 =?utf-8?B?WHRsODFVUTJSeVBCWXJvYks0bjJrd0RaakhsbVZHZUtUczAvOVd2b1NreGs2?=
 =?utf-8?B?dTY0cExPbjBXOFozejlqODJXaUJmTU1WZ2JodXhreDVBRzUrYlA5TS9EWnFs?=
 =?utf-8?B?QllzMXFrblBYL0tnbVFWYkR6YnZSby9nZGRBY3o0NXMya29LckNnVGFGK2Uw?=
 =?utf-8?B?cTJ5andGNVNIeW1seGgxWlczdERlbUoyalp3Vm1DSmxSSm1Va3JUa3BCSzRa?=
 =?utf-8?B?aXA1T1MyUERKa3o5QVdoY3Q3VEk5d1JHRDloM244U0swWkZOUXJVR0FSL3U5?=
 =?utf-8?B?cWswL0NJZHpqQ3hxbjh2OC85SGF2eTNQSFRlUnlqNWU0ZE45UTBaWStQQkhY?=
 =?utf-8?B?VGRxZmRaU1d6MUlha2dQa3hXc01iWi9wQ2F1Nm1rZG1HSDVqSVZRb0F4bmdP?=
 =?utf-8?B?Ny9pMXFUSTZoL3BTUGRKZ3lHL3dDdUxRS05jV2dqSlMzd3pnSC9Wc0xDTEo1?=
 =?utf-8?B?dUtFSFhCUTBjQjRPWWhUWW5MbG8wWGpHWDZIb3BJOFYzdVJtRkRGemVFcFZJ?=
 =?utf-8?B?UFpCc0J2YTNRWkdGNk13WktlRFBqTVJabkxpMHhFT0RhbGh6TnlsdHkyWkdT?=
 =?utf-8?B?QnRodXF2OVZVSkVSeTVyeVFXenh6ZjY1c0lVckcvMDFxRVdXWEpSY0UwdEZz?=
 =?utf-8?B?VEV4TGhJNG54RzVkVHFBZjUycVc5Y2F1eS9mcUZybURZdDI3UkVOYVZOaUJG?=
 =?utf-8?B?N0UyN2xweEtEMmMrS09GSVF0Q0RrNUpGbnkrd0ppZDZ4QjBxem5idkZkS1c4?=
 =?utf-8?B?a3dITGg2RmxYQ0c4eVV4c2Q2TlJwcWdCVC8rc0Mrdm95b2UzSzRzZUMzbW94?=
 =?utf-8?B?U2tzNzhaL1YrVEdacU8vcGd3MTdudDROK0F2RGlUalY2YkJJZVhMemc2KzBW?=
 =?utf-8?B?Zk5UZUpSdWRIRFppU3hpZmliaUw1NkJiRk9wWTh2Z2I1Y2VpZlZtUXVNZTJI?=
 =?utf-8?B?cTBYRzlPWTl3MTdXV09KUFdmbjg2ZGhSdDBjVnhKczkrOWtWZitOVUNSQlov?=
 =?utf-8?B?SzRKTmRZNHNBMEVOK2Yvd0RBM2JjUFNjdHgyZHhFNmdoUmh0ajkwNmwrYm9Z?=
 =?utf-8?B?WUM3eCtTM01Kbmd4K0k0c2xWKzBoWlg0cERrc3hBTHI0MGsxSFhOUEIyNlhr?=
 =?utf-8?B?RlEzbStidXRsNk9INlY1ZjUwdjdZRHRDU0VtNFpibkVZOHFtUHN6VHZMVEs5?=
 =?utf-8?B?UDRFei91WWdUZG1OdXAzMEVOeG9FK1loVlhOdVNtREc5WVVRbDN2VWI0aGVo?=
 =?utf-8?B?RG1MNDZXcWd4QWRCZU1iRGo5bU1IZnFVSSt2TllKd29wbVoyRmQxMUt1SmxF?=
 =?utf-8?B?dEFBeHdlb3RwUDB6TVVzNytWakI4bGd4VTFPb3ZDemxiTXQyU2t1RVNHaHBT?=
 =?utf-8?B?ZnRGODhkb2JsbzlPOXlXZ2tjaE5NZkllbkJTbld2dnNWa3c5Um83VFVVWGJE?=
 =?utf-8?B?REdmMGtVRFpSazAya2RLYTlOaDEvbzBzNFlrbzhMcXo4bzQwcllOWjlMbjVw?=
 =?utf-8?B?c1BkWTJDaTl3Y1V2YWVPbjE0WlBtd2RodWVoUVo3NWFtQlo4S0h4K1NKTjhE?=
 =?utf-8?B?MXVJRXlqcjNPN3dwN0ZMTnMvblcxR0YrOHQwQ3dGSkJmejdzRGpPU09xeGgr?=
 =?utf-8?B?d2trRUthYm9VVURFL2N1WXVpYzRYSk1kMFluMndBQlRpQVBld0hMcmxzRzBq?=
 =?utf-8?B?QThENmpUWHE2VHNvaWZnT0dINEJCb3VTMlhiUW1UVHlEMXV5OWw3eFRLSWY5?=
 =?utf-8?Q?DyBSTryBXQHVhEpYiUVlTX7YW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2365b7f-19da-4f08-99f0-08da96e3f966
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 06:31:51.3589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNeaoca+RcehnG5GKa6/myy0/J4K7Fy0jyC2iW3AL7av+7/K50xLl79n9F6MwCwD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 15.09.22 um 06:02 schrieb Zhao, Victor:
> [AMD Official Use Only - General]
>
> Ping.
>
> Hi @Koenig, Christian and @Grodzovsky, Andrey,
>
> We found some reset related issues during stress test on the sequence. Please help give some comments.
>
>
> Thanks,
> Victor
>
>
>
> -----Original Message-----
> From: Victor Zhao <Victor.Zhao@amd.com>
> Sent: Wednesday, September 14, 2022 6:10 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>
> [background]
> For a gpu recovery caused by a hang on one ring (e.g. compute), jobs from another ring (e.g. gfx) may continue signaling during drm_sched_stop stage. The signal bit will not be cleared.
>
> At the resubmit stage after recovery, the job with hw fence signaled bit set will call job done directly instead go through fence process.
> This makes the hw_rq_count decrease but rcu fence pointer not cleared yet.
>
> Then overflow happens in the fence driver slots and some jobs may be skipped and leave the rcu pointer not cleared which makes an infinite wait for the slot on the next fence emitted.
>
> This infinite wait cause a job timeout on the emitting job. And driver will stuck at the its sched stop step because kthread_park cannot be done.
>
> [how]
> 1. move amdgpu_fence_driver_isr_toggle earlier to close interrupt before drm sched stop 2. handle all fences in fence process to aviod skip when overflow happens
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++++++---  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  6 +-----
>   2 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 943c9e750575..c0cfae52f12b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4610,8 +4610,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   		amdgpu_virt_fini_data_exchange(adev);
>   	}
>   
> -	amdgpu_fence_driver_isr_toggle(adev, true);
> -
>   	/* block all schedulers and reset given job's ring */
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i]; @@ -5214,6 +5212,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		      amdgpu_device_ip_need_full_reset(tmp_adev))
>   			amdgpu_ras_suspend(tmp_adev);
>   
> +		amdgpu_fence_driver_isr_toggle(tmp_adev, true);
> +
>   		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   			struct amdgpu_ring *ring = tmp_adev->rings[i];
>   
> @@ -5228,8 +5228,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		atomic_inc(&tmp_adev->gpu_reset_counter);
>   	}
>   
> -	if (need_emergency_restart)
> +	if (need_emergency_restart) {
> +		list_for_each_entry (tmp_adev, device_list_handle, reset_list) {
> +			amdgpu_fence_driver_isr_toggle(tmp_adev, false);
> +		}
>   		goto skip_sched_resume;
> +	}
>   
>   	/*
>   	 * Must check guilty signal here since after this point all old @@ -5240,6 +5244,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	if (job && dma_fence_is_signaled(&job->hw_fence)) {
>   		job_signaled = true;
>   		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
> +		list_for_each_entry (tmp_adev, device_list_handle, reset_list) {
> +			amdgpu_fence_driver_isr_toggle(tmp_adev, false);
> +		}
>   		goto skip_hw_reset;
>   	}
>   
> @@ -5276,6 +5283,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		if (r && r == -EAGAIN) {
>   			set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags);
>   			adev->asic_reset_res = 0;
> +			amdgpu_fence_driver_isr_toggle(adev, true);
>   			goto retry;
>   		}
>   	}
> @@ -5711,6 +5719,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>   	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>   	set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
>   
> +	amdgpu_fence_driver_isr_toggle(adev, true);
> +
>   	adev->no_hw_access = true;
>   	r = amdgpu_device_pre_asic_reset(adev, &reset_context);
>   	adev->no_hw_access = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 8adeb7469f1e..65a877e1a7fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -287,15 +287,11 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>   	if (unlikely(seq == last_seq))
>   		return false;
>   
> -	last_seq &= drv->num_fences_mask;
> -	seq &= drv->num_fences_mask;
> -
>   	do {
>   		struct dma_fence *fence, **ptr;
>   
>   		++last_seq;
> -		last_seq &= drv->num_fences_mask;
> -		ptr = &drv->fences[last_seq];
> +		ptr = &drv->fences[last_seq & drv->num_fences_mask];
>   
>   		/* There is always exactly one thread signaling this fence slot */
>   		fence = rcu_dereference_protected(*ptr, 1);

Those changes here doesn't seem to make sense. Please explain further 
why that is necessary.

Christian.

> --
> 2.25.1

