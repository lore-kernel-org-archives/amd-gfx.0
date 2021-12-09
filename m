Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D6CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 738E710E8EC;
	Thu,  9 Dec 2021 16:53:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011278925E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 09:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6rsNwxVjWdfHXh2MsbTO++ZsngXdkJgF2tawcbhj67YCx99pJaznX9aRAR9w4rpz+s7KpjcIC5V0nz5dFWlmoDGfZrJk7UH6UeWbCSh8TFmaqZgQymWrn+g06EP+KCFm+N21yqKS5RoeeEIS+n7ScR5jf+4kxfz+WBGXK2dA0Zjwxh5pTGtQUWoAQ2ZRhBtnN8V8/KTZTCokRLn449H1hMDX3TCvXde+Zs6p0aCvlSMnkbymaxqfPRJ+8fdZaldpjctvV4su/STrEoUrogyFVvQDyfpBjy0O5ByMk7WPo49h8j3ojthmxpyzVNbLO5x/oY0pPf1pZUSVQ1Kj26Ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRUgiY5K8c4wU+ZOsq+B+zKl3dyRDI/7xV1/xrb9JOo=;
 b=WJ1do54EE6GkFQW4p4OXlOZ0H+6FwxLnYCvPGB5JoEWVwZlin4mBk4IkBuVZGe/UKGRDAqoV2ddNfAZ9a23UNTusTx5Ea68zjxqZk+ZrY0RIH3v8L+7s6uS5uK6ESJcMFpcTpTVY5abheWi+GNfpk6pQZ1j3wiOX4HD96aCEZQX9XRFkFRxJdjvp2Ze0A/OefhR91GdvPWebpQkt7gLNb38RGJ5SmL7y3giOm4ulQQQKbybrBKwxoN73puonhQZb+ymtuXX0M26oF0euDw/xZJNINhaJzQAmf8dbOOCTDpIwuw5jIpDIErFpBzApcMX0BdZUiksRzD69Yq26Il2oCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRUgiY5K8c4wU+ZOsq+B+zKl3dyRDI/7xV1/xrb9JOo=;
 b=T1fkzQA8N/FxbDV2xA19R/sOgFKJRCa8AUA+LEHNhjr8Bs4l4JqyFzWGxQR/A1LDLpN3s0/4wSPfBVBQ2SfLenqjS0ImQo4gSwJQAFVFhttX7q7f5rFyw1Kj2yYt+6aK8UCLaBwbsn0sRs7v0d13z7S3DieBDmLmc8d9s8nDEQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1341.namprd12.prod.outlook.com
 (2603:10b6:300:11::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 09:00:58 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4%12]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 09:00:58 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: introduce a kind of halt state for amdgpu
 device
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211209084914.261889-1-lang.yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <af6c19e6-fcf4-ac19-637e-1fb47f15f9e6@amd.com>
Date: Thu, 9 Dec 2021 10:00:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211209084914.261889-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::19) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:2e35:ddd6:f296:528]
 (2a02:908:1252:fb60:2e35:ddd6:f296:528) by
 FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Thu, 9 Dec 2021 09:00:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30855ae5-f475-499c-17ab-08d9baf26a71
X-MS-TrafficTypeDiagnostic: MWHPR12MB1341:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB13419C42500DF27A6214613083709@MWHPR12MB1341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bVDd4Y6/BW6yVq4pvxoTofvQO5hAM/n5iLiGNcQK42ZivaEwptRK+8I9Jm5w/+qDzkVErj5OYG9xeoAI7yhwTb5l/DAlkMJa0XfR/S4Wllk100GzngQcHilrlPL92xS9mC3ZDVCAeCAkJhjqhZ9EaSBZGJPpMMutMWbe3+PHnvcuCc1SBOpG0oOA+fGCT80TgBI9Tt5XfZE9JH6ivA6T3PRZwruS9+b3PQBxFVi6uFrD2e7svmsmjdQWmuFnnJe6e9mKQBFkzO++zECe2fuH0ayUdZ0zw60NwBA0K90Q+J3+RhAECHDIXkNGwLCNcrmUxskfS5OMH/cc3xzeD+1SuWnv/ECzJod+fb1bfFZ2NY9L1gRyXHIKmqpimRNnD8GRi6BFgyhaZNCI+arEgAOxVpMLRO/BSLirqAZFaUBrQmDEWFJ/MpZSDgearSNzuDJWfMDezoE0GR8cO0uLzZhhr04U/7uwCpyErhrG0/VdS/4CXIWVfDzyaKfPjbLAsj8uOlRdV9S2q23DSGI2+UIihAy+LonptxBfsvvWd/I+c/OiOEtFdYtOSFasFcxoRZOon4mHEK7qj6eKO+7Nge9slm5mKUed+IfMqOpy5me+BBNFb3049jv6kI9C3guw2gYZcWu3VRDjVXKNYom2tOaGrvh/OV7Gz1XLGaRtFulBRWc5NcslzQxpxANFwpiEZeiQqaNcsf2/JseOOJNs/IQFvl4V79aaaO9yj1SpzyJtUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(66556008)(31696002)(5660300002)(36756003)(186003)(83380400001)(31686004)(6666004)(86362001)(508600001)(8676002)(54906003)(66946007)(38100700002)(8936002)(4326008)(316002)(6486002)(66476007)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ymt2ejlDcE9tWkhCZUJSY1dsRHByWmQrcUlKQUZBVlZOWUtWdmNlTXQraGcx?=
 =?utf-8?B?ZThoZE5jYUxNSHJ1UFN6TjBKM0pORU1LUnV4SmRlNkhkdlVNYkMrMHRtVGtk?=
 =?utf-8?B?RE5oSGNkK2l5SGtZR1BwUng1dEZROVdJaEI2N0tvS1p3czYrV0p0ZDMwL0hU?=
 =?utf-8?B?OEVJKzlBd2pycFdLN0piUUVnSUtxU3VKcldCT1F3ejR1dDFxY29HVXVXMkVU?=
 =?utf-8?B?Qkt1QXdyc0RYUnFXYnBNZklvbG1FUVcwbytCbUo0dG50eW9vSWNGRDRYOVBw?=
 =?utf-8?B?cW90WVlmUE9XWDBoY2w0MHNwVzduSW5jT2JZellrMHYzS29wSmJjY2lPREN3?=
 =?utf-8?B?YURvN1VsZ0ZiendaMGVKczVKQ20rYXNNdmduTU8rQjJ0WUF4Q0pmNUlqWmt0?=
 =?utf-8?B?VXlVdGh1MThxRTJJZUgrTjdxV2l4WWM0MDdOSGR2L1QxWVhENFgxQitUVm9S?=
 =?utf-8?B?NlNFUGE5N0hWaGFhckw3dHZPSVRnMmJ1K0dVNERWUWxkUVdOMnlCeThGa1JC?=
 =?utf-8?B?bHBYSUhWVGxqaUVCdWxWRXFWdjZXQkNvYVM4ZUhHN3VHaHJLYmV6MW4wQ05v?=
 =?utf-8?B?L3d6c1ZoVnVxOEMvdXF3eGJCaWNzNTBRMHM3ZkxGa1BhRk1IYmE1UzlVME5v?=
 =?utf-8?B?OFYxSVdpOS9SL09Xa3A5UnI0c25aV1VWcXF0R0htaUxFeitacmdaUkYyb0pn?=
 =?utf-8?B?ejYrTG9LSFV6WjBjSXhmMTVvZGlPRWl3akwvTTdKTWlITjlxaHFpb0lmdXEw?=
 =?utf-8?B?ejk1K1lHUDRETVZya1AvVW8zYWs0OWdKQitpcXZaNXM3ekhVdzdrcElzekcr?=
 =?utf-8?B?MW9URkt1dGtxbjNIMWVvaHU4dlhJY0xBNFhiTGhZZTZSNVlNaFZkVW0rcDBT?=
 =?utf-8?B?NXJMNnp6dDVVZ2dhdVpIbzJyN0tiOWhPTmVZR280dk9tL1lxVnFmQmhSbXla?=
 =?utf-8?B?cnBSQ1FrWVFjT1VLemZsaW55YlNQb1NMYXJ4cG1SY2FkdlFvUXRJbWdkUmRN?=
 =?utf-8?B?dG5PU0hOTUhRUVlZbmc5V1lUOXI1MHJybVNwaklRdEUveTZraE1aaHlhayti?=
 =?utf-8?B?b2lsaGFmWWprNnN2MitVcDcybjVtbU5sdXlKL1NodzRJdTVQYms2QjJ2WkQy?=
 =?utf-8?B?ZG9DSHIxOWw5SWdsZ2VHb21WUCtNeThTT2JaL1QzdUlLTHp0b29CMUsrMlh6?=
 =?utf-8?B?a2xyUzJDbnlhbGxEY1dqaDJjY0QxcUlzQ0c1SW41Y2dMZklIeWZWTGZ2d0M5?=
 =?utf-8?B?dDZCdFBzQ2FrTUVoK2ZCQ0RxcTJWcWN4TGc2Y29vZXdVWTZEQWNUaXhLcHM4?=
 =?utf-8?B?VkR3UUsvMFdOTzZ6eW1rb2w3eXZzOHRQZGRmWUcwZy9BNTF6d2N6WlhkQkha?=
 =?utf-8?B?ZzZPOHFSRzNpbVRURDE2QXJuWDB1SEZOeC9Wb0thU2tQekZKQkdPOUZ1NS9v?=
 =?utf-8?B?K0NqZ0pjQ05MT2JIQnZGN3VHSCtWTVowRng1RThjOGtKNjVNSDdBSzdvSEQv?=
 =?utf-8?B?eFdNTk9vVHVOZWhPTUl0S0pYNUZON3AvK2g1WUsvd0dPS3dMWDI4WmpuUTl3?=
 =?utf-8?B?TlVyK1p6NFo2ZTVRcC95T1ByeHZDSDI3V0pNN2dXd2s1WkhxL253N2JhMXZX?=
 =?utf-8?B?dlJWWVdadWR0QTl4TkZNZ1NkR2pTRnNtOWhRYkhqSDlnWmtXWDkzYVdaeS9Z?=
 =?utf-8?B?Z0syalo2dzNWdXZhNWlxTUNFR1EzKzFscTZGUjRBOGtRZStjaGpNWEE0aXAy?=
 =?utf-8?B?R29PR1dFQ1lja0FUdllZV2x0Vll1b1ZaZlF4a2xVd2NnMWRmNGZSeEp5S0lh?=
 =?utf-8?B?N24yM0VRTGVPZUloVmI4aWFvcmpMOHRDbUdoV1dTVk9aQ08ybHE1NVRkOGsv?=
 =?utf-8?B?Q3hqbTdPRUpNVk1lVTVSano3ZGZlSk9STnhsVW0wRmttUGFOTjZQMXNKNGFZ?=
 =?utf-8?B?K3hRTHBjVGxMOE0vZ0xWZkR2c0s0VEV6RjVUMlZJb1FKaVIvS1dJUXBCZGFo?=
 =?utf-8?B?Z0ZocVpsdzBJRC9RUk1lUHdqUjFRRUYvdW0yTnFpRyt4THQ4MlRuR0dnMnVV?=
 =?utf-8?B?N0w5SkdReko3ZFhPd3JQcG5oZ2dvREdGVkV3ZVdwa0pQNlZZT2UwZ1pVelhj?=
 =?utf-8?B?WjZieTdzL0VSaTkwam15UkxKR1RBSnV4M2w5WDkyQWE1elhiK0NoVElCUjJa?=
 =?utf-8?Q?t/cYJoeF9PkO7gWa/dnCxl4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30855ae5-f475-499c-17ab-08d9baf26a71
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 09:00:58.3143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vX1ztVmpZrnaVijbn8l0a+0l7eLggwzM1P3031dBih/eRf7jtgQaev1yI23nJnYV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1341
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 09.12.21 um 09:49 schrieb Lang Yu:
> It is useful to maintain error context when debugging
> SW/FW issues. We introduce amdgpu_device_halt() for this
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
> index a1c14466f23d..62216627cc83 100644
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
> + * 4. amdgpu_device_unmap_mmio() clears all MMIO mappings
> + * 5. pci_disable_device() and pci_wait_for_pending_transaction()
> + *    flush any in flight DMA operations
> + * 6. set adev->no_hw_access to true
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
> +	amdgpu_device_unmap_mmio(adev);
> +
> +	pci_disable_device(pdev);
> +	pci_wait_for_pending_transaction(pdev);
> +
> +	adev->no_hw_access = true;

I think we need to reorder this, e.g. set adev->no_hw_access much 
earlier for example. Andrey what do you think?

Apart from that sounds like the right idea to me.

Regards,
Christian.

> +}

