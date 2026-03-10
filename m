Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BDCFCC9CF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 06:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04F410E656;
	Tue, 10 Mar 2026 06:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n9IYliZT";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011022.outbound.protection.outlook.com
 [40.93.194.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DEE10E656
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 06:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKpNJrThE/JXL5Ri26ASINE9QWFdQZldIj7bvMayKEcYvzC+/lhSQN0/xoWDEm5AQzGOZ4BKMxxNwpKZxPvoJ4UUVwA4IlIN+wLducYBGvDPI8u3jd/hwtT6tGW6YSXjupJQcXoJcmD/cBHOLLfFLP6kMH6ioTcVrRMSdZPzkYTIPFJvE5mibtjAkp2nSCy/LrMERDAGwLWyta1Bgg+xw95mRwiBIFENsAqklJb1sODu5mJQxZSMNER0IfP1al0+92MQkNR6zn6KTLyFL9fMZ59bwVRadD7CTXaA/UKbpe8b6w4iwQCOB4HVvvIYtj8BWRbaQC4AKWOBE+bd9QxrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdEI3Z+GMG/m5WxpFDJbyH8Pyco8+rDLFxlqtmqsurs=;
 b=RZ5+BvLDB7NIFbEDCovH3RsNGgD6koiWsUox8PQkgpp46q5E3vIFoBPjXr4xC4ImE0YejUUQqXDDLxlEtnyPHEGNZMqvl6clYW2uqZcfeH83Y0zw/lyu4sN9mR8jMTEU8IaKpYR7+ur9gQvQ6k7N9Brv7m+gAAT9vIWJ61MQbx/K9DeluYoJSx6+P7q7DE9UPAeWzREhoKlbCS+WnqQ3F5XQGeMTBXupe7Ofq0lge+gzrkobuqePXcEY7BXoYVti/JgoFBt9W/ogbcXRBMETxrDBVHGSBMbv8g5E2dElvisVOfBpcU/q6JANA4YN0jiGdfrV3+zPDyLlZUMbhg8bQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdEI3Z+GMG/m5WxpFDJbyH8Pyco8+rDLFxlqtmqsurs=;
 b=n9IYliZTcoUzJj2WeqXmJfKHh8sMncdAQov8BLrxyZDrGNhiUxQRXoQOGAS00m3T1he8eT7Eto4SPsrNM130XMVBuOV1YWXGpCZfCeDGLRDofKU500uXWV8HElV859XA3VBbwuinK0aJQpqM69AdWI0wEKOnr+P4ToJoh6eIWY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 06:40:30 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 06:40:30 +0000
Message-ID: <36bdc19b-87c3-4ed2-ab60-b1f97cb9c0a7@amd.com>
Date: Tue, 10 Mar 2026 12:10:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Avoid KIQ ring access during GPU reset to
 fix fence timeout
To: Chenglei Xie <Chenglei.Xie@amd.com>, alexander.deucher@amd.com
Cc: jeffrey.chan@amd.com, zhigang.luo@amd.com, amd-gfx@lists.freedesktop.org
References: <CADnq5_OCRm7oVkr7TY_OCyfSnkPJXAY7ZhjThpEbAauQNz_T_g@mail.gmail.com>
 <20260309170950.1982724-1-Chenglei.Xie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260309170950.1982724-1-Chenglei.Xie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0088.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 80db4075-cab3-492f-df70-08de7e6fec2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 7WOiEdZbEUE8IIOswBWIR224SSaQFM3h8RezwxoSS3gF+QkFAYjwE+5Bz7DW3fJq6vk1yG6ibJ5MNidPG30MnJqbU7Z+Uz1z/wTBvNYUTHPkJ6jkdLkvN66BhjB/huOyhQEa3l9oh/BHWikLjw9gWpnTS7U/Rm4ApPA8QgxRxgEnzpp2/LY2hC0XLgCPv7JKx1cYe0CAwLa/Psddx5BmgQ/re8JIXC+qpnnyumDxIb/cxX05Y2PxflFxowukACvutPtQHa4RZM03QyxpxxWlsfg1KJrahOOO0C7SQCGHG+NpgcfiI7iUkMu6qUYkU8hIenJ0UczdZ24T0SaCebPE7h5twI0wCop7DDmA7YZJRAR4tBwSunhz8Mrn/yeyjoD9mubvw3mwPkNcrwdimtqnf04C9rmEE9iO+kJGLvBS3sJrWOZZzi8FPLknZGFksJTlxX8dbERC04T9kccUlEWUUWEDs5VfvMdUbgzXU0pShqxkZHJKjeVkmrq3f/HeT+wtcXLE2W2bsfywWMma9BH9k4gII6K7gNviLDnSOGhyTcXkvOqjM1FGh8pFrl3dSJSPCDv6J/u9ixeiWLbo5cLOGrvJ5jofiRWyoUE24zyIb502IOv1MMiMyP/wXN50r4TqFkZZ5pQXFr+ht13mrXtdv2Dk737e/K9FME72zPvfUl4dEixuu7/Yn9jsi8tMQDGWHrXGo6OSeDzIEYH/hXRtJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE1HZzdITTd1a1lhQ1ErWXc1YXdLN1Rua1pMcXFCRTFjejJlcGxLR0ZSZVBx?=
 =?utf-8?B?SEhST1FEdGFQcmwwVllTcmgrTHdlZ0lKajU4M0RQT1htaURGcXJ3bC9JeTA1?=
 =?utf-8?B?SVljbCtYS0k3TDNyRlVvQURjZ09ZWkRXNGRUNXRRTXNxVmdXQjJWRGNQWlUr?=
 =?utf-8?B?c0dhSWtjMFhvK2ZaOGhlUzUycldmeGJwQnZPWis4U1hhV3lKMDdqUnBvQit3?=
 =?utf-8?B?Mlp4ZEJrRGQ0dGNwdDN2eW1LQmJIQzNyWEFuRVlTS0Faa0h1RE1GelQ0b0N6?=
 =?utf-8?B?Wm8yalFPODNvV01tQjQ1YWNFWVI5NnFrNDk3MmJ3bHA5VGxNdVN1MHIvVC85?=
 =?utf-8?B?dk1pSlJYRk01NUw1d21mMVhJN0lVK25JOVJSejRWd2ZyazBrSHZXSDJyWnVn?=
 =?utf-8?B?SHluODFSbjB4VVMvRXJMSmR3cHh0ZDZCWW83engwWHpHc0gvUkhTM0xyWmRv?=
 =?utf-8?B?LytRdXNHdExRRTFIQ3ZzQnBlb095ZHpPUklrbXBSaVZMOVI2Ly83dkl6ajUy?=
 =?utf-8?B?QzI1dXd3YklaS3UzdGhncTZTZ01qTDBnUzNkZUJtKzdEazQ5MDFReUIvY3Jj?=
 =?utf-8?B?Zzg1YkY0dnE2MVBzZjRQODZpMHgwUFhyaEE2Q1RDdzBqSExoWDdjWEhmUEMy?=
 =?utf-8?B?M2NWY1gvVE5sT3FOa0FGS2hWN3BmTnJQS3UzZmdTemtNODBmdDJYQkd4TllS?=
 =?utf-8?B?aG50ZHlQNXFsZERTMm5PaFh2VmJ1K3BGRHBXOFQybGRIbnQzdHhLUUpOSzc0?=
 =?utf-8?B?YUMwbHIwZ0lBTlBoK20vMlhLbGJEZFdkc1dRRFRQdXhjYmV2RUZJRm5XTzdh?=
 =?utf-8?B?TlJVcFZQUWk1KzZ2d1BEdGZOS1l5MzhwR2FDTXJMb1dHemJYblVKMGc0S2N1?=
 =?utf-8?B?YXhIZDRtc0kxRWwyd0hjdkN2V1FEb1dVMVUwaExPcitQc2JZbnZNSFd5SkNv?=
 =?utf-8?B?Sm1QM2RHam1Fejl1T0Y2YzRZY0ZqRFZIUGE4THJDVGgzaVFlbklKb0hGT0o5?=
 =?utf-8?B?c1VlUU9QN3Q1eXB0UGJNQXlGeEs1WDA2ZGxmQkpRblZmdjVwYjNmdlpPL2tW?=
 =?utf-8?B?OVZrSFpWZWozZmRHTVFpVk94SjczYnpmaFk2cjVBN3k3NC83VGlhNFkyRk9p?=
 =?utf-8?B?Z1hXOXRodFliV3FlRUsxNldqTXVYMkNXS3pJWWs4WVNYQW0weHhCL3ZoU0Rt?=
 =?utf-8?B?Z2dtYTN2OTcyaDdVR3Yyd0J4QjZzMjdRZk5PUTNSbFhvUmV3T3BxbU1lbkNX?=
 =?utf-8?B?OXI4UFBBTU95YzE4dHNiWnl0QUlnb3NmdEdoWFV2Z2c0UTc3cDUraWRlZVlI?=
 =?utf-8?B?NEdIYko5LzhHMzlSVlduUVJtYWtkQjVGNERVelNDNUcyUXVZMWlwNW5tei9R?=
 =?utf-8?B?T051Zk1qYlY4aThJSlFFTC92cldyalZJS2Fpc3FzbWFES2lLMTNDTEd5VlRa?=
 =?utf-8?B?cjh2SHZ4bWd1ZEkrL093MEdGQy9FWUJIWlVPVjF5QkZBekxRcTc3VmhSdTkv?=
 =?utf-8?B?Z3h5akxJeENGdEJsTG5qaW1zYTB1U0U2RzRNTUpZdEpmcGRiMlpiZ0VDbC9X?=
 =?utf-8?B?T0U5V0swRGVIbGJzYkxFdHBWck9WMGFPak1HOXZPdnJUZWZNOXdEb29vSXRn?=
 =?utf-8?B?dS9FQWxqcW1pNEtYL2pFOVRUNXJoNG41ZG9oc2s0azRBT2g5MDNFQ251ZDBw?=
 =?utf-8?B?eWdVLzhnNDFuYXM5Nmg3RjFHaHloVmpEOEhYVW1acDluQjdUOXB0YmVYRHZJ?=
 =?utf-8?B?TG1MQ0xtSWJQNW5MU05YaWRFYWNhY1JuNzlxanJUd0p0bVcvdEZCS3ZHRUZn?=
 =?utf-8?B?eEFaVnEvVlV4WElnT2FMQ0tZRDZObkFScWM0Q2hxckNRdmR1cmwvc2hXNmRD?=
 =?utf-8?B?SlN4KzVzU0dra1FtcHZoNEt6dWwydnBRbTNJSFg5a3ZSYkEvQ1NLVVhLaldP?=
 =?utf-8?B?THkvRzdiQkhYZ3I2bkozWm00T3hWTjFoaGV3MTZ2YzRkSk5waWt1VnVZTmNG?=
 =?utf-8?B?VlIrRWh5WENyQ3hlc2o0U21PMWI4bFhxZ2dTdWFPb3RScXJmbE90aThFLzVO?=
 =?utf-8?B?Z0QzT09IeTVqdVdPZmd2Z2xDQ3I0OTVWK3MxZTYrM1lzaUN4ektOMnJkd3Ay?=
 =?utf-8?B?MDB2ZTZHcisxcnpMaWVmOUVPWDkxQWoyUW1JdGcvbnRrMDl1MkduK09MUFlw?=
 =?utf-8?B?d3J0SEg3dlRRODM2TVRRUkYzZEc3ZnZTTnVLa3RiNU54Z1Q1bzMxK1pqYTdK?=
 =?utf-8?B?dU94TENIalU1NnJEbUFaQ25xVFozcGxJSDdZcHVjLzRML1pDeXdJSkNzT1Zv?=
 =?utf-8?B?MmR0cEF2OEFsaGZ6cHFDM1NDYXgzbFJhRHU4T1Q0Q0FJb1ZhZFdndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80db4075-cab3-492f-df70-08de7e6fec2e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:40:30.5874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deANeb+yvuCghUM7TI360aPToFgzWfdZoV+XknhXhhgYRAuRIiPrV7vEuIDcUd5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 09-Mar-26 10:39 PM, Chenglei Xie wrote:
> [Some people who received this message don't often get email from chenglei.xie@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> After GPU reset, the hardware queue is cleared and all pending fences
> are lost, but the fence writeback memory stays stale. If the driver
> keeps submitting to the KIQ ring during reset (e.g. HDP flush),
> sync_seq advances while writeback does not, so amdgpu_fence_emit_polling()
> waits for lost fences and hits -ETIMEDOUT, blocking further KIQ use.
> 
> Fix this by skipping KIQ ring use when in reset.
> 
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> Change-Id: I717df52ed0ef0bb51a6901f218191d9837a77f6f
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  3 +++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index cab3196a87fb1..0021e763b753a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1124,6 +1124,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
>          if (adev->mes.ring[0].sched.ready)
>                  return amdgpu_mes_rreg(adev, reg, xcc_id);
> 
> +       if (amdgpu_in_reset(adev))
> +               return ~0;
> +

Please note that the existing logic assumes that kiq access will work 
fine even during reset and only could fail under certain reset 
situations (not all) -

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c#L1107

Also, there are additional things done after full access is released -

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L5610

May be it needs a force completion at the right place somewhere in 
amdgpu_device_reset_sriov() as Alex suggested and not to simply block 
all KIQ based reg accesses during reset. In baremetal case, it is done 
during pre-reset as we don't expect any more packet submission/indirect 
register accesses through kernel rings afterwards.

Thanks,
Lijo

>          BUG_ON(!ring->funcs->emit_rreg);
> 
>          spin_lock_irqsave(&kiq->ring_lock, flags);
> @@ -1202,6 +1205,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
>                  return;
>          }
> 
> +       if (amdgpu_in_reset(adev))
> +               return;
> +
>          spin_lock_irqsave(&kiq->ring_lock, flags);
>          r = amdgpu_ring_alloc(ring, 32);
>          if (r)
> @@ -1298,6 +1304,10 @@ int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev)
>          if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready)
>                  return amdgpu_mes_hdp_flush(adev);
> 
> +       /* Avoid KIQ ring access during reset; caller will use amdgpu_hdp_flush fallback */
> +       if (amdgpu_in_reset(adev))
> +               return -EBUSY;
> +
>          if (!ring->funcs->emit_hdp_flush) {
>                  return -EOPNOTSUPP;
>          }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 20e1395b39882..f9db2b17105b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -876,6 +876,9 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
>                  return;
>          }
> 
> +       if (amdgpu_in_reset(adev))
> +               return;
> +
>          spin_lock_irqsave(&kiq->ring_lock, flags);
>          amdgpu_ring_alloc(ring, 32);
>          amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
> --
> 2.34.1
> 

