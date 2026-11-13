Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B9606A330
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DugQhAPs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 214F710ECA3;
	Fri, 13 Nov 2026 20:40:52 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38DED10ECA3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 20:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cH+LG8EHLYSSMGYfCVg03FjCjP99Iu/L+fMEQaPe/dvPBBCWiaWW3C+MOaiKEPFupsLESn1KgJEhqfejkCLr+d5aAI/e6PpuFWNy7XUG6MsFcDaxHy3qrALNuUfrgZBHMjNCdXV2xvSfITapbRHXclbyy42dIVQJs2q/NSS9msn487GQe6xc2KWGnFn6MJax+sGpLExUBCm9REn1Qob3isoUTFoUkGjO1r29H9kAHih/8k+KBDCAKBHEkxbVt6UwqtSCmHUChpWYZeKavTc5jETH4i43CMB3KEuLzKryXLzgG122q5ILki9H/5t1Tg1BBA8p7/fc/xi8JTA0yrzKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSucXxJTTxvCiu86dXrojNRLzCmUt/DC9JH+HAxeAOs=;
 b=ELbWJvYH+Tuooov6OgNrAaLx66Nwf7GDzD82XN3ai5f/IKIL6xEsIa7i7hwlcijNnae+7W9PiVNe4w1+8/sNbJnV4WvU5sx7tOf5qELxnPXuCoMKmO6o6yYIoftdsWv1awoFGJUeWjNWdw3OcmkPJY3EV2Mnd3Pu/qIITgl3KBkg7j1BipgIOiowrtLcTYyX387kmlMIY47hAjzq7GAidXA95SypbAdbSrVYCjrduQ/0rGvTock8SboRY6+mJucmYhHn4RQPMq/8y7+dP8iei0bqVv3DNZoGdbWm0spzX8SwBa/tvuFRhQkLCUdlSyOl4XOWPROid2fsPrS+A+21YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSucXxJTTxvCiu86dXrojNRLzCmUt/DC9JH+HAxeAOs=;
 b=DugQhAPszVBE89Q6AdwEDVtw6uWkLm32SpPRfUG+1UNTsfK6Z/n4kr+OPvIIPtWEDyJ7+8Wxgf0BP+8uIcpPy+7JQp4Q3kP1tlkZsnHoBD26qUNnviqaSKC3ZCtCJrmfD3JKg3VkzQBcn+O7qDzv0CNsrEp/ZG0AAIgQK/Ew2U4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) by MW4PR12MB7117.namprd12.prod.outlook.com
 (2603:10b6:303:221::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 20:40:23 +0000
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::fd82:d106:2d09:2dcc]) by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::fd82:d106:2d09:2dcc%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 20:40:23 +0000
Message-ID: <e5e11770-9d68-486c-9c15-31369966a536@amd.com>
Date: Fri, 13 Nov 2026 15:40:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: clear root PT after setting vm->is_npa =
 true
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, yangp@amd.com
References: <20261113202944.3006069-1-shahyan.soltani@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261113202944.3006069-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::20) To SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF8ECEC29A9:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d8a0c1-576f-4a96-9c56-08df41c656fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|261009223027099003|11063799006|56012099006|261102123227099003|10067099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261022075727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: cm6qhqV5ePeNEI3vbwvvGV0FU2hWGcxe7HFaKKvRds+9V2S+b3bkWIf34Wtn7VlVy8sEdxR4xlPByipXithNHRiSXf+RYZlyIiM56U88u9/ccOH4ZR931ZH4qZ/c/ZmoUx0Qxw0Vf0EOMEwrcp2ZaMEEPy3cOK51zxNd24i+BsK6ksj31lyIhDw6s1L5rfE7Huqf6TZEDFLCvHBqXI5aOo82Cnm2EVf9c7c4dmwUiuiuIEU718vPBsQricdwvj2sVCx4Y2yGJbK3NFdFpzw6aqgH5hN/F+dv85HM6rqF+RY+/aloODD7d8CHcfRzeVqCzAz+tc2DB0SE2uWV1mF6cJi/h6rgBcffnc46EBT2v1xQVQfRRqvq903hHPB8NhcPQU1AZymFNnxUkeR9okeHCP0ZuzahVF+9D4BGN2RLduREcCVOcOp5OD8mT91/y0S1e95GeXaaxEaM7TVEwB/HFR8ZyiTySAfhWPfNg5ieYl6VV7ns61sKlUcLkKDZWmE8kPfCQoWyPWs/9cjxgksc9tE9ybpoUJyYeDa/soAQsxUwbHSn1i7oq04Zu7j26+ZrEnu2/gszf9oUr/LDG4iJBmiKmLI7p4vqtE7QScszWEQ++WFUOm7FueEy3MQCCxjQ5mfBrOzAxa8L8IPF49vUPcH8NZvIOsaHvAH8wgk0U8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA5PPF8ECEC29A9.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(10067099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTcvOUJheVBIK0xLWXlZQ2NnMFgxeTd5a3l2b0dyczdlOEFBbkdmcCtjc1Bl?=
 =?utf-8?B?a2NCbzlEU2IxeE9GM2N2UWZYRUp2bm9Ib0RHc0VtdytqbTRXUC8zZGZCdzhu?=
 =?utf-8?B?d3lGbyt0ZHE1ZmZKZk9QMkw5SVg0cmZ5dkdzM0g5YXptdzl2dlNCNCt2OXIx?=
 =?utf-8?B?RS9Rb3l0dkVsb1VBYnN3NXc2WHVrbTE1Z0ZRa1FWeXEyc1V1L3B5U1lSNlF6?=
 =?utf-8?B?RG9EcTlOb084OE1KMm1rUVlsb09ucys5dW1Cb21pQm9YNUhSM0lncWMvTmNF?=
 =?utf-8?B?eXRwbWE2ZjhCbXk3MmYvVksxY2N0Y3cxeERoMVBESVNyUzYxN2ovK2hRQTZ0?=
 =?utf-8?B?Ujkzc3hNV3lGVlJLYnZPOUljajVhZTc4SitDdzgxYlM1dWhCaUZhalgyUEd3?=
 =?utf-8?B?UWd5SVc5bkxtanAyWFJXUS8zVXpwNDR3cWFQT0kxckovZFRId0xpT0QvR3M1?=
 =?utf-8?B?TkVSczJScEFLRkkzRlUvWFU0MkRKTDJVSVpGaGthTEQ0OUdZdlVVTmM4UDMw?=
 =?utf-8?B?aEx6eWRMOE9sL0lJUVhKdlphTWNNUitONmgveVFDNVVqbUR3enprYnBYMzJh?=
 =?utf-8?B?VFlDQVc5RVJ1QXlDOVFyRHFpSWJQM1M3QjcwdEl0WEZrMTJvdkxENE5SR2cw?=
 =?utf-8?B?cytEZDluQ3NiYUpocDJsRHIrUUFoenhuVUUyUUg3dWJ5eDdPZDdzNU8xUUJy?=
 =?utf-8?B?K0UzZFRmODIyR2RNZnhoTS9QU0haMTdodzVVdWp5eGRscENEUGZiNjNxWTU0?=
 =?utf-8?B?VlBJK1hTRUZ5SVdwZjFMcy9GbmN3MmN6RHAxSUJCNkppdXhMQitrOFNZdVdQ?=
 =?utf-8?B?TFh6UnBrL1htc2tGNkVCdlp0eWFyYUtIN0c4WUsrbWFLbytYV0szR3oxRzlV?=
 =?utf-8?B?T0VuVFE1SVdPRmlDNXY2ejI4eHlNZmZRTHBxYityT0YrVHJJOTFpUWRtMU81?=
 =?utf-8?B?dEs1SmxOcGVLZ29qeGNTdWtTajYxQW1nVnZaNHBYdUxwWEsxeTlzZzBZb3Fm?=
 =?utf-8?B?akc5SU56Q1VhQzVIWWprdnNyc2tPR1RnN1pVdWpNSGRZUVpCNVVNQVd5OTJR?=
 =?utf-8?B?aXM2QTR3QkNXNEJZODdpYUlZdzhHbFQ4QzlabEFHeWtHVU1GN3FsUUNwL0pn?=
 =?utf-8?B?WHl2OUh3bVQ2TGtSQy8vYkNrUmtqWE1LaTUxTVNKbllhNE9pNzBJUGZtWmxj?=
 =?utf-8?B?Z1lOUjBnN0U0YUhhSlVZbjMyM3EzSzN4TTBnTXBGcFpXSld2Q21jL2Mvdm5y?=
 =?utf-8?B?TVNISmxDQTVDZEF0WXd0UWhlbmU2dXhYcHpGWDVRTnIralNsOVE5K1M0SzFh?=
 =?utf-8?B?RW5oR3VkVE1YVHg3VDBFRVlybVJnb2dBaEFxMXdVa2QrbGRCOEFBd0QxeVBr?=
 =?utf-8?B?cWlYTHZYLzkyU0JrQ04rbU9nRlI0MkVnNUxmNGlvV04yU1BmUll6SGhJeUpr?=
 =?utf-8?B?NTJkOHdFT25tOVJBM2EwUW95Q3QrODdlcU9iZExqRmZMSTd6cVgvODg2WjBF?=
 =?utf-8?B?UWVDTVNha3V0c0JZOGUxc2NyL1BNVXd0WklObXhiaXFHUTljWm1yLzBWb2NL?=
 =?utf-8?B?a1pDUndjMXFJZDIvbk9qeVFLNURIcW9ka0tTZStzVVhPU2JYMFJzd3NCQnlL?=
 =?utf-8?B?QzEwbW9vdGF4emwwZ0NsNkUvQ0Zsb3d3a1NMS1hXWGdkUldUTlF1b2lrSHlY?=
 =?utf-8?B?b0p1d29Cb1k4OXpQQmRTVjg4VHpCZmgwUTV3WnlHTXdjaFRFK0tEaWsvamhj?=
 =?utf-8?B?OThhT2FKM1I3MUczbGFWbStRa2U4bkxwOEhCVkRQTmZyV3pmczI3MmN0aHhR?=
 =?utf-8?B?NndzcytsQmhYOWJDWmlvbE5jSzFVYVlrK0U2TUEybEl6RTdmbng0L0NqVUd2?=
 =?utf-8?B?RmtnZEtFVTBaeFBGd3hEd3YvcUxBVEM2akZRRFczb2RteUF2VEoyTlo4SzYy?=
 =?utf-8?B?eEVZUEg4UkJ3R056MlBXMGw2WTBySVR3Nmp2TlMydTMzQnhvZFAzRkpDM09o?=
 =?utf-8?B?ZFI3dW5PWGtFY25vRnMrQlFMK2JETG0rQm04Z1IvcVJ5Rk41SGFrRTl3MDYv?=
 =?utf-8?B?cWJIR2YrMFFYMVkrSHV3dU9CSWJHWUZLak5icEdiQjhDNkJ0RHJJc1cwZjBn?=
 =?utf-8?B?NGd1TE51QVVMTFpaS0NySURzY2JpbnpDaVVkVFlvQWZCWlVTQm5aRFVsMHhD?=
 =?utf-8?B?K3B5YTYrb1NzOHNsNDhtN09yeFM4UFN5eXlNcHBhZWtiZTdldU5LNWkxVUtF?=
 =?utf-8?B?MkxyVUxkOHZEWisvZmRadGdwcStGWFRNSy9mZTRpUkVoLzlQQTZvWTZwN2s4?=
 =?utf-8?B?TWh6bkI2WEwxUFQ3dTZyclF5V0tXdDRJZmIwempsRTNxTUIwSTRpdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d8a0c1-576f-4a96-9c56-08df41c656fb
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF8ECEC29A9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:40:23.0556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jj3re0JWB3LqpqqKjij5Ng0eUwbOsdvXGsGYcPIqYgjuEcYtNFG9vzBgmBfmAWr95N4W3v17Sasup0onytbDbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-13 15:29, Shahyan Soltani wrote:
> Previously, the root PT was never cleared after setting vm->is_npa =
> true within amdgpu_vm_make_npa(). This resulted in the flag
> adev->gmc.no_retry_flags to never be applied for the NPA VMs.
>
> Call amdgpu_vm_pt_clear() after vm->is_npa = true is set and the bo has
> been pinned/validated. This allows the root PT of the NPA VM to be
> cleared with the correct value.
>
> If the pinning or reservation of the bo failed, the vm->is_npa flag will
> no longer remain as true. This is to avoid conditionals outside of
> amdgpu_vm_make_npa() that depend on the vm->is_npa flag to determine if
> the VM is a correctly initialized NPA VM.
>
> Warn if the VM already has mappings, since clearing the root PT will
> break existing mappings. Do a heavy weight TLB flush after the root PT
> clear to avoid any stale translations being left behind from a previous
> table.
>
> Remove the redundant second setting of vm->is_npa = true.
>
> v2:
> - Add the WARN_ON sanity check regarding an empty VM. (Felix)
> - Change the return handling to only set vm->is_npa = true upon a
>    successful pin (Felix)
> - Add the heavy weight TLB flush after the root PT clear (Philip)
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 94b1cfe05e3e..c7187e0f99b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2820,20 +2820,27 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>    */
>   int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	int r = amdgpu_vm_make_compute(adev, vm);
> +	int r;
>   
> +	r = amdgpu_vm_make_compute(adev, vm);
>   	if (r)
>   		return r;
> -	vm->is_npa = true;
> +
>   	r = amdgpu_bo_reserve(vm->root.bo, false);
>   	if (r)
>   		return r;
>   	r = amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
> +	if (!r) {
> +		/* Check if VM mappings are empty, clearing would break existing mapping */
> +		WARN_ON(!RB_EMPTY_ROOT(&vm->va.rb_root));
> +		vm->is_npa = true;
> +		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false);
> +		amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);

The TLB flush isn't really needed IMO. We don't expect there to be any 
previous mappings that would need to be flushed. If there were previous 
mappings, we're in a broken state anyway, and the WARN_ON would tell you 
about it.

With the flush_tlb removed, this patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +	}
>   	amdgpu_bo_unreserve(vm->root.bo);
>   	if (r)
>   		return r;
>   
> -	vm->is_npa = true;
>   	vm->need_tlb_fence = false;
>   
>   	return 0;
