Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1B4E9904A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 08:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B63F10E136;
	Fri, 10 Apr 2026 08:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Rz3CoYn";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C4210E136
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 08:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfdQUcbkRtY4w4a/fx/S8o1Mq+7eAM2H8pqFUu9A8cP5UVJA35Zb8Z/DkwngL+GSN+JoSt1ykt4vUnA0mgy0SW3MN1QWjEdDb3pnWyg4GBOfs77dARcJs2ei1eYAiv1l+tYeNHlGjAJVmQmJ3hQIfduCB9lvxZBCQmtT6ImXcGOW7d2rsSqChUUa7PIju6dAhpw8LwNeXtTQEpcqzrIkVXfVPP+6YCDyfX9doel+csWQUYck5GpIDtIx3f/FHbjxA9aImIwIiTRGnRN0vfA7s6AF0UExomUTsyrMP52f+F2kjI3AsADPgvxp2KGs7x1caHFQXkRP0scU17H/IVtXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYbQTC3zAwyWabIVk/V1OAutDuCT329AIVdjPypHoDE=;
 b=vrETRG7P4Cpck+3buZar6wTLYSsumKRhIWqi8MhzgJ6XZ52eG+W0Ob25c+5aCtSqGsN93v8g9EHHUM4eaFc4JisvF6KNlp9LCwqC2yA+rxN1m+kVgmigmsDiS3ud8q8qO6Wh5czN4vR4otia1LLqF1OTPZQYGG08EHxBAeuXjC85t4OPlDuAA+HB1Lm/ql4Xg/YBYzI3fYZJ2J4frd8XKr2NYlXNAE3NGfMZbZJWS2bQfngwE43PDn+X4z8aAI3TJRFWTfitroog4oA0gfGRi/0pMUG83p0E2B65gS+Ox6iXo17XdXImutR6NjejNxCiKunL6O8LqxlN1dZ8sbBggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYbQTC3zAwyWabIVk/V1OAutDuCT329AIVdjPypHoDE=;
 b=3Rz3CoYnpFIg/IfdA71oVWh5sGby0RgnuGXx0PpoU43o/04E/G9l86BtiHGXKVLFmXOc4q8SXfyndhL7//d1f1LDhSn3WKUTONK8WWIT1P057xME4NTo9DsjNHmGs6VTKWZCX+OLL44dB27tZMHxDB3Xv84gMdzsoKpWdndt0zc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 08:16:58 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 08:16:58 +0000
Message-ID: <b5cbb3e1-bcf6-4686-8773-02b5fe264dcd@amd.com>
Date: Fri, 10 Apr 2026 13:46:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: correct single device PCIe reset flow for DPC
To: Ce Sun <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com
References: <20260410073013.2225397-1-cesun102@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260410073013.2225397-1-cesun102@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0246.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 04deaaaa-631b-4e86-2f29-08de96d988f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: j+CvHsEINGjuh9LJdhwlPXmfugEiP2Q7VTEH20RObAd9vfbvDVPnbdj0ghNe6/TU+IE7/Saie/ZM3/I139iOrhSLc4+cneYsbMBETnaCjs2/lp3Wbua2yE7gVw83JmRTwXPi4ggrA8B8yXMj/+97nsR0T9rbSfg26soyqFO/4dclMBPxObWkP9TC9c2e75rYKRQu6kUiYT7Dddf/2eKgawyDogrJoY83auU+t7QCo8C3pRWbO9ZCvx85hnvFmzZO8dcVUGoXYeVmaGQf3lPu/Z83z7JXaFdZR+3UJ9RylSyBu9NXfxz3I6NVBTKcJmJ51g1L9ikMvUPAAtU+NGM83CZN75ZlI5Ew4J69zPx1JUzTFHWUZfBd7YcHtc7AkXruMUEEu850M3guCxCym21GpN8D5JTGux/JJB8xy9HnCwPK9WfbEmBW3MYxvoSlKNgoNUBXoxDGfmCtSItmrwflINPals4inDjtxbTbh5tctzdWTwEWQ3fbQTNgNJfjY6FbT/tMKfVrsvD6guifwXh5YPmebjPLHOWqlJZjJ/orOCJdPmTEFX+AiGf0pO21uhAOLm/LhFmR+NZomGMzH2PmUqoOyBqOa0jkPelyK0s9k03w185HkMNx0CmpfW2c2qC64RR5psWSop1KQ1eBe7uOA/vUE6mRVmWat/Z4krv4n5Dhb9BUbvZmOkud/2+d7EAu/nvqD5z3F4bcO9KVZWvnzWWIyKxppCoF68/XSBbcAE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGdqZWlWOU9BWDIzSWVPVzVkTkJ5dVoyWlJ2MHVKRVhjamh4eDR3OEV5NzJ1?=
 =?utf-8?B?cE5kNXRYcWZUcnVXZFA2Uk5wR0xpRVNFaVlrM1NsTVNISUN3R0lTRmt5M2N0?=
 =?utf-8?B?N1JISTd1bWZVSXVvVlhoQWJndkNlTmw0NElXTVpEc21pRFZrb3JRTTBSSFZJ?=
 =?utf-8?B?ZWdEQmxGMWd0K3ZZemdjcFpLSndOS0RQNmFkTzRuN1MvZnN5dThIOEZLc2N3?=
 =?utf-8?B?RkNsWENiM2ZpZTZJNmhTcEtFS0I4dGpCdFFINnRlKy9KZWlPYUlucDBkOWFY?=
 =?utf-8?B?cUwxWDJvYjV4eEk5ZUF3ditkT1R3aE14cGdzaS9BOE5WTXhNVTEzYzk5cU9F?=
 =?utf-8?B?aGsyQXRXSXVhM2xXcE5YaE1GaDZmWEZSQ2g5RUpWSzExSGRZSVdxQlRVeXNm?=
 =?utf-8?B?bW12bUg3TVdDeUV6Sml5M0lZbTJJVmUxTmhjRjBwbXdBeUtCdzhvdWpsYWpT?=
 =?utf-8?B?UHJoZDMySC9oRzczQ0NBeVNaZytUZmE2cFl1S1QvS1hWWFl2UytKc2pjVWRC?=
 =?utf-8?B?SkppNWJJRmR6MldhdFpNTTBXZ2ptd1o0dndUTlRjelU3QXNFL3RqVWQ3b1hL?=
 =?utf-8?B?N2hZN0VYdmZwTTFNYmFkTGZqYXJNckptRjZnNWVURmc4WnhVMmVhR0VnL0tG?=
 =?utf-8?B?OEZoRk8vbG9VY1VqT0Mydm1HNENqTG1lLy9GMXAvNmora0tBZlBUbngrdUs2?=
 =?utf-8?B?Z0xDRFZ3RHdNNzFFZ1BYbWxqVkNTdE5CT1B3eU9hUmg3bnZzS2VwOWVtUlBy?=
 =?utf-8?B?U3VodHN4OStNd25mY3diRW9qRTZ1SnBSUVRDMHRkQ21YMEJYd3RsbDlyNWRO?=
 =?utf-8?B?ZG54enBGSFFNQ0NQdklqQzlITjZhOVl4bmVxZEE4bUpvNEZFaTZUMUtoaXF2?=
 =?utf-8?B?WUJKMGNGeDhmeENRdTYrNHkrcFVhRm51bmJqalgzcEJIOGNDaUVucnF1Zkxa?=
 =?utf-8?B?aHBONFdTcGZlZEY4STBoYnBGekVLU043SEZpVTYvSE5GNjlIYTF6ZWc2MnRi?=
 =?utf-8?B?Sjh1a1g5dGppbXRROFllL0dpb3NOcjgwVmJSWmJKNzB0eUFLRmJ5cHM1RHNZ?=
 =?utf-8?B?dWNzaUNFN2ZSNzdKOFdWREZjYmxPaEtzN3VFakt0S3VHTWIrNi9ENnF4RjRO?=
 =?utf-8?B?SWkvVHBhRzAyVkp4Q0lmTnhwSmk5UFYwRzZjZFZNY2Q2VmZXMjVGRTVYalh5?=
 =?utf-8?B?MzZmZlg5VEZaMmxITUl5OEhmQUJCZyswTndXOGdtbU9yK04wRUZzeTBzRTRS?=
 =?utf-8?B?Z1k1UmppbE8rc1B0bFNVa3o2ZGZGMjd1NlA0c1h4VkU1NVJuQldpOVNFdFd3?=
 =?utf-8?B?Ti9iallvUU9PYVVmTFdndVZiOUpPWENxMktrOFJHdG1xcW10M2xJaTBZTkcv?=
 =?utf-8?B?N3RSTVY2U3F4anBJTFd0bTJzSVpFT1Nvbm5xR1QxaXNMM0lsT2ZHNzJrRkpY?=
 =?utf-8?B?NUw3c3k3R3JOZ0pvbkt5VUJJQmFhTU9FTDlqNDRLY2ZlMUhSeHJqbk10V29X?=
 =?utf-8?B?aGFGWGVBQW5IZU9oM3RFMisxay80a3RsT1NxN29RQm42Qk9mQ1c3bmJrV0Uz?=
 =?utf-8?B?ZlFRZloreFVNUXFvTEUrLytmRGhYMUtlVnAwT0trb25NbEtqYTB3czc1amc4?=
 =?utf-8?B?cWdRV3RtQW5zMFczTGdWL1hPVGxiZ1kyMnpNcDBxNW5WWUlwU0p6QTVCTnRu?=
 =?utf-8?B?UC93UGdhRmh3WFFDeXVacFNpQUZrWkh5b3luOHdJcUhYdi9HRExuYVE5SlVF?=
 =?utf-8?B?dGZSY0wrTUFYWW5lYU5oY1Z2aTgwdDZRNitIZGJMWk1lSUJNYitmMm9QenRB?=
 =?utf-8?B?cXFIVVBlYlJtb1U5SWVzMTFHY0gyZjVqWFZCNmdnTlJnQ0VNcGpEWGxienFO?=
 =?utf-8?B?SGlZZlpVWXRIKy95dFVlRmpFVW95b3dpVWpvVHF2cWdNS3RlWkxncWtTMzhh?=
 =?utf-8?B?N1ZXYkJzeTFlblg2SGRldXpRT0NhemhsRjNWVUdmZDJHaG5YTEsrcmpIQVEr?=
 =?utf-8?B?cWVsdlpyZVNQYjkyNlNubDd6QzlZOVRHYzRMcUJvRURUMnZPOC9KYTlQQTJ1?=
 =?utf-8?B?ZEU3VldjM0NlS1RCbDhFWGpMNXdnaWNGeVhTS3NrZmFEVGJ5NG1KblFQcE03?=
 =?utf-8?B?NW5kN1YyVmlDMzNCNTVPdU9jcWhOb09yc1lVb0N1MTBoZENJTDZhZUFRUE9Z?=
 =?utf-8?B?Z1dZL0RvU3ZDaitJUndiQllDK2lZR2t0RnNuVCs1OGg0TzdGV3lSN3h3MEd1?=
 =?utf-8?B?Rm5MekF1Y3RNVlprVnNMdGR4bGNhWkRzeVdrYWhnN2xyTHB0SnJpL3BxYnRk?=
 =?utf-8?B?bU5TeXR1S2xmWFd3TytYNVhMai8rUzBvSHhjWVk1M1hDbjc3ZXdMdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04deaaaa-631b-4e86-2f29-08de96d988f8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:16:58.6970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79SaUezmiMlpgYZPlkeQRo7wUUpmNAQ7+wCx3y5IErFkCEUv4RvHBKSN+pRQZq5y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136
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



On 10-Apr-26 1:00 PM, Ce Sun wrote:
> For triggering the dpc event with a single device, we still need
> to set the in_link_reset flag and the dpc status.
> 
> Signed-off-by: Ce Sun <cesun102@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    |  3 ++-
>   2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index deb41c095b59..df1f6b070ea1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5518,8 +5518,6 @@ static void amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
>   			list_add_tail(&tmp_adev->reset_list, device_list);
>   			if (adev->shutdown)
>   				tmp_adev->shutdown = true;
> -			if (amdgpu_reset_in_dpc(adev))
> -				tmp_adev->pcie_reset_ctx.in_link_reset = true;
>   		}
>   		if (!list_is_first(&adev->reset_list, device_list))
>   			list_rotate_to_front(&adev->reset_list, device_list);
> @@ -6291,6 +6289,9 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>   			amdgpu_reset_set_dpc_status(adev, true);
>   
>   			mutex_lock(&hive->hive_lock);
> +		} else {
> +			if (amdgpu_device_bus_status_check(adev))
> +				amdgpu_reset_set_dpc_status(adev, true);
>   		}
>   		memset(&reset_context, 0, sizeof(reset_context));
>   		INIT_LIST_HEAD(&device_list);
> @@ -6411,6 +6412,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>   		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
>   			tmp_adev->pcie_reset_ctx.in_link_reset = true;
>   	} else {
> +		adev->pcie_reset_ctx.in_link_reset = true;
>   		set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>   	}
>   
> @@ -6467,9 +6469,10 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>   			tmp_adev->pcie_reset_ctx.in_link_reset = false;
>   			list_add_tail(&tmp_adev->reset_list, &device_list);
>   		}
> -	} else
> +	} else {
> +		adev->pcie_reset_ctx.in_link_reset = false;
>   		list_add_tail(&adev->reset_list, &device_list);
> -
> +	}
>   	amdgpu_device_sched_resume(&device_list, NULL, NULL);
>   	amdgpu_device_gpu_resume(adev, &device_list, false);
>   	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 03d95dca93d7..debb82a2e031 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -34,6 +34,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_pm.h"
>   #include "amdgpu_vcn.h"
> +#include "amdgpu_reset.h"
>   #include "soc15d.h"
>   
>   /* Firmware Names */
> @@ -361,7 +362,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i)
>   
>   	/* err_event_athub and dpc recovery will corrupt VCPU buffer, so we need to
>   	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
> -	if (in_ras_intr || adev->pcie_reset_ctx.in_link_reset)
> +	if (in_ras_intr || amdgpu_reset_in_dpc(adev))
>   		return 0;
>   
>   	return amdgpu_vcn_save_vcpu_bo_inst(adev, i);

