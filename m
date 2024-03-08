Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3062DC54E4A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 16:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A25CB113911;
	Fri,  8 Mar 2024 16:48:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3gqs+9jY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B2DD113911
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 16:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEjpv7QR1qwhSCk9LCXQcCmvriziGsWY1/FjS0GoP1qwDdKf15STPosMFkMg8hhciOYF8i3ZfDjmH/oLZ+R793oacbtCmpb7a4uOjleFJaHCIZL6SIXws1u4iZUYwBrmvasPksaEJ1ajlqMee7eT6hUS7YaGxeKRiKATdRketvMwOm0SXHn6SZxQTxuTTkeOkrqReHaBH1G6EN6AwqvdiOf3XmeLq98YAF2p542Tehm0Xv9AMcvaRbAyZMkY9duPMmRzLHTDSg1FjrIHUV4+T3e6pwMfsBMKvrbVkvp2wi59Z32Yz2gu35yUzvQP7ccSW07XT2Pgii7UQMBmTtkJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkEGXWmPIpW0B3EiS9CXUMcNlbdLzaDnPW0C2yECcng=;
 b=UrB/VKysdf17+0qXzNVu6S7jEKPfTuKXoPFYhgxFTMiT/UJpUvLWuyQHwJ0RwxfAEzIz9xve4d/UrFjjXS2aCnS82Xit2uKy3DyKr4wpAAUeo+cy7aA/n5a8yLQuaRB7WVv7wKvXvBOIGKRhGl/I9OJXzyW1DUmXIYxtUwdCtOaXfakAoFvltePHO6x5fr0DJTULAta7K9fQnyjSWAOQZG1PWfhXlxZQCDp9Cwe0bpjiyvoIifoxbBMsPAj0MlnujdBWuuZowUQu9v6eT6ZiE/7hUBIkn5WvmvUYv6NUIODPtYvWW4RtoZYEBEOeFViq7k9HXOo4Rcr4I3l96oBkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkEGXWmPIpW0B3EiS9CXUMcNlbdLzaDnPW0C2yECcng=;
 b=3gqs+9jYenk30hDRqwLUOallartbUbGFLpK4xA4pVZdEwn8GnNGFdkXD23fUZjNQFdJGCpFZlpkmkcThGMRYWdV3bPPD+CTpYuOzWpDFP1OxIyNQ1M/N9RiNjV0PXGAtj+GNnja8S80QVqS/9e1s7hH9q61jxMwL3ro/Q+IPFhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 16:48:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7362.029; Fri, 8 Mar 2024
 16:48:01 +0000
Message-ID: <b9b7b00d-57e9-4d35-a713-f922f5e19402@amd.com>
Date: Fri, 8 Mar 2024 11:47:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Handle duplicate BOs during process restore
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240308162253.264154-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240308162253.264154-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0191.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 001e1dec-2383-499e-37cf-08dc3f8f8491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XDXF13YwdIONQIqJdF2Y6yRnhin6SlK/ZGUgGkeM9ousW9P9ZEfmfZnsWHIBZvKogtB5MjKRkGUBagVXwnfHQOK6i5sfPVX4Ucb8QhBoWgT9+eVJ0qr/SiWWLfjDgL2g3mAKNPTNt313GIha7cgmDe6EwH+uC8oe5D3VcrdF2R78Fp8NsbBvvPFjTjORjc+7A8C3NGsEQjdHeKCHJOHB+6UtmmVR6S8VJsL1M41l5u90TZNnVu9gP8z5pt2f7D9sbcvasLIV5mu12je2VLSCo6ECqXvl65VeyCbnrYxIHheZnfTip0nSa8INV81DYjnP31QHVyF/TDzCVt5EFUSR/8wLvqF+qmWws0TwDBNP3XupQPv77/aYnotGftDZDJ80CqTzxLdeg6F5XSUnXERv3+GIl0FNZ3Vle9AowBQX9s5msl2H7xqUgVscGdZ1syCUAUkovCYDcLkU1/R/1nqmG4rrFwuqD+MJlfBUP6Vvp/DE3VybkNaEyObaclBn+uS34BMOwMtY1AEfEp6viCo1po529geYR6mV+kRQpyB6HmDMJWUHNa+xu+XSrRXxyZgMNQmuskthazRF/3iEsZseFifrAj8XMassTIhncpZpKu88ZaTpioFMJBmC9uFXR5UdGacfdV48jScCxAjiPOxJMREqdn4BizoJbVyaCl+K00=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVRpS09sTnl4TlpsbmdEbUdsaVVQY1dNQm11Sk40MTNPQVJkZ2swWUlUdU8x?=
 =?utf-8?B?VWZvbkpRdk9Uc3llNjVOYlArS04vMytIYlFBZzFBclRvNlJQMzRmbndqd1k4?=
 =?utf-8?B?YVF2Tlc0MFNYRTZzOW5tMElNVFl5c1VUTnNjdE8yRURta3NVVThoVERmUEVy?=
 =?utf-8?B?WGlDOEgyWUlqeXhuVUxBSjg0Q2lOT3daUy90VGRpb3FGSkdnS0FlZHNnN3lP?=
 =?utf-8?B?VUswN2tHM3MzYzl2MGdoeUliQWtFaWpyeS9SZ1pDTWNKZWFSNGNBYmF3SFE1?=
 =?utf-8?B?NlVIcHYxc3RKUnVXS2ZmUFFoZHFvVTB0cWJBazFGSW5XckNYODB2VXo5eDJp?=
 =?utf-8?B?N1lGNHdlOG9ZdUZWaWVXS3R4YmZIVXdzN0RuQW5XdjFiWi9JZkNTdG1GNGEy?=
 =?utf-8?B?eXBWc1Y4VytXLzF4cENjUmY2SUVBaVZUd3dIOHlseEpNT0hrWUJpNHZROGFk?=
 =?utf-8?B?cjBvcGlnOFF5di96QUd0RmVVZzVlSUxuUHpqTFdXK3E3a0Q1NnRHSGpmYWxZ?=
 =?utf-8?B?TXRTbVBaajAwNFBlN2p5MGZiMGIvdTFxUTBDNjJVZEFKbUM1OVFveGQrbGk2?=
 =?utf-8?B?bXFUYWszeUNsaFdIQW9oNTRCcHZZYjVFK1BBL281UHZmY2VaZHdNYWhVMW1K?=
 =?utf-8?B?eTZ0RGQyM0VqMTVhNFpqdjA5WjE4VmtpU0tXSlZLZmNwZmpGa0lEemp1bHV1?=
 =?utf-8?B?SkFQWEYrdlZUT00yU0oveWdDZkNQQXlaemZ2QUJFOFl1VlFGM3F5VzVNOUp4?=
 =?utf-8?B?SytWbE03ZXZ6VHlmTENvbnRnSmFLMFpQcGIzM1BxQWxRb0Q2K1ZPQmJPS2lX?=
 =?utf-8?B?ZlFqQnpKQnREazR3YXdzcmhaZFhKOUFDTVJzVVV5bEZwZTNNcnlQd0Q3TzdC?=
 =?utf-8?B?MUF3SGw3NmcrQm03S3c2dmNJV0p0dDhnSTUzT001VHJNR0xzeVFvVEswdHpE?=
 =?utf-8?B?d1lHTVFITlMyS1FxeVpmY3FDOXlpVmRBNk9ia0NWbGo1SXRoa0R5bVk4Y2Ur?=
 =?utf-8?B?YVB2NEJVQTVTNTRCcXU1TVE1SENYdU9Xb0ZhQWtmbVJ5Vk1GWHVnak11UnVR?=
 =?utf-8?B?ei9sWXdFMmxxcEJ2a0ZUblpPN3dQNzZvRUMvRmlYMmlQZTlCNnN4Nk9uNWcr?=
 =?utf-8?B?RlJUVU1YWEVMQzVlUGNjQlVmenArRy9kQlZTOXJ1dk1RVmJXbjhYQVNGZE9V?=
 =?utf-8?B?WGRWZFNneWNGTlNPZEtyVUtlN2Eza2ErSGVBc2U4bUlLczdOSEtQcjZlNnJh?=
 =?utf-8?B?d09WcHVUZVJnT1ZZb1lvZmRiaE5YSWtOa24rVEtLVDRudElPTENIVkM5SmYy?=
 =?utf-8?B?enZqNkNXV3FtZEd1aHZDaHJDSGpwZFJiOU5XNmJuQzg2a3NjdTNUMGJ1WGNX?=
 =?utf-8?B?L1VXcVVBdkFtcGNhTzl0cXVaRjVaak9YVUs4WDErYzVudlJidVVZTjJDQWVh?=
 =?utf-8?B?c2hXM0VSOVNGL2g4aHQ5bFlLbUxWYXNPeTJZcGo3ekQ0cFJtcW81RU5hTWpX?=
 =?utf-8?B?T0cyY2RXS0hjdFgyQTZXYjU2eTNwaVpwK2RBNXNHSUJVdjJwZ3hxeHFRbXFr?=
 =?utf-8?B?RkNUYUxCa3hwU2ZVYzRqZUtlKzJIYmVHYytkN2xyeTNUZm15ZU9KeXZwY3By?=
 =?utf-8?B?bi9YTndGSjcyQkI5TFM3YncwakswajQyYSt0U3FxTmRBQWM3QWF0V0RKM3M5?=
 =?utf-8?B?YklnYUN0d3hGWVc4S1RiRnNXa0JHZVcxZXlTZURsbXVlVnVpZC8xajJnRmhh?=
 =?utf-8?B?SjM4a2d1azl1cWdNRjdXeFVVTTgrb0g3Rms2NUUxWTA2UWhabllmY1ZubzhM?=
 =?utf-8?B?NXMwSll3cE11T1NPWTVIQld5cHAvQkNHWklFQWpvMEFseENndXFIWnFwY3dH?=
 =?utf-8?B?bXNXSUxRa0s1VlRIRXNWN2ZHL1lPYjN0dUdsRFZwTmxETWZtUnBQSTRBUk50?=
 =?utf-8?B?ZHpEdm00V1o5MHNnSVBqMFBtTlAwQU43bi95MWpVV1Z6K2hhZWwvYktKZXhH?=
 =?utf-8?B?SGFpcDVOK3I3MTE2N056cTg1dEpEMWMzd0dhWlpGbzNIOFIzMkZhamtrcFlq?=
 =?utf-8?B?QnRVZ0o5T2dDN0lvbjZoYTZXNnFLWUJna0xFaWl2dFNXUGRwRFNRYittVGtV?=
 =?utf-8?Q?2KDVoB3GMgWhH8/c48bKvDYzQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001e1dec-2383-499e-37cf-08dc3f8f8491
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:48:01.8166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WatcEQEoZqXRLPhI2/xngkhwykUYslzNYd0HL/1Ruarj2Kwb27IErdnjkDjff+VJTTfWJZuAQ0OEGUhqh5r0yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269
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

On 2024-03-08 11:22, Mukul Joshi wrote:
> In certain situations, some apps can import a BO multiple times
> (through IPC for example). To restore such processes successfully,
> we need to tell drm to ignore duplicate BOs.
> While at it, also add additional logging to prevent silent failures
> when process restore fails.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index bf8e6653341f..65d808d8b5da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2869,14 +2869,16 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   
>   	mutex_lock(&process_info->lock);
>   
> -	drm_exec_init(&exec, 0);
> +	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES);
>   	drm_exec_until_all_locked(&exec) {
>   		list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   				    vm_list_node) {
>   			ret = amdgpu_vm_lock_pd(peer_vm, &exec, 2);
>   			drm_exec_retry_on_contention(&exec);
> -			if (unlikely(ret))
> +			if (unlikely(ret)) {
> +				pr_err("Locking VM PD failed, ret: %d\n", ret);

pr_err makes sense here as it indicates a persistent problem that would 
cause soft hangs, like in this case.


>   				goto ttm_reserve_fail;
> +			}
>   		}
>   
>   		/* Reserve all BOs and page tables/directory. Add all BOs from
> @@ -2889,8 +2891,10 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   			gobj = &mem->bo->tbo.base;
>   			ret = drm_exec_prepare_obj(&exec, gobj, 1);
>   			drm_exec_retry_on_contention(&exec);
> -			if (unlikely(ret))
> +			if (unlikely(ret)) {
> +				pr_err("drm_exec_prepare_obj failed, ret: %d\n", ret);

Same here, pr_err is fine.


>   				goto ttm_reserve_fail;
> +			}
>   		}
>   	}
>   
> @@ -2950,8 +2954,10 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   	 * validations above would invalidate DMABuf imports again.
>   	 */
>   	ret = process_validate_vms(process_info, &exec.ticket);
> -	if (ret)
> +	if (ret) {
> +		pr_err("Validating VMs failed, ret: %d\n", ret);

I'd make this a pr_debug to avoid spamming the log. validation can fail 
intermittently and rescheduling the worker is there to handle it.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   		goto validate_map_fail;
> +	}
>   
>   	/* Update mappings not managed by KFD */
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,
