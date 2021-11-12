Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D457C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 17:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11DC61057
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 17:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B11DC61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3F06EB84;
	Fri, 12 Nov 2021 17:58:21 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60DC16ECC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 17:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcg2dzb+n3vpI8UuSbEnhgCz9bHwKKwtl7h9qXVcz1OiVM3SjhGaZOVMAk3bBL3keZ+gydXvaWbj1NGuw/I5IbefR3BhX3sA3q8uSI2EktVaeVhdYMtlCT1Sqe04E9O0y5JpeYrVtayLGyvR58onDuXBv2s9v1w8WiUt7HvWzOLz6Iv/eGW4rxTiRwq21QfkQwcKM/0BF1h9vS1Vl/ThWk9LGIjjjlfVkKXnr+gYVw0TXpxKxUm/kF+e36cN6w0S6zvO0sEa6KIbOt+e3ZCdBNZKx7R1Hk9XD5ayYUxNLxky66vrrdwmYDAO6JATfCMIUFLwobqTluJV+HNmmsXqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDHCReEyLOl4fq3DUJfIy089dZqbY2+Fbcu5OC69XEw=;
 b=CaF2EfsIgD0lTmZ9pL3Zjze9AEaWfWzicMDUDhSuxM0utb0AE3+OMMD3kXLHd+jWAa17qxgC4eVnBm1XGZMM1kyMVHFRhyJrwWv3o+ct4vc/xD0YzmQDRULEf/YcfaodiKD4T6NUk5oBEFs1WtJlc7WFTl11DbbFasVL4qFmFvWgs8k9lm1RulefpvICddiCY7usdGejh2Cw/g1sXb6GyVIO7fCnDj+KGBqvmfbLWXD4W22907PDXGLx1p3ECgC6vWoW5v6qRWN4DWSP3XnDSmZoOQIQNjHDUME/+fhl4Q2fVq3ye/hCxXm7xRcQY9TOAai6ZBfIIPWJ402kphvyCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDHCReEyLOl4fq3DUJfIy089dZqbY2+Fbcu5OC69XEw=;
 b=mJgbGIz1G8IP1e+i57/3zlFwm6WRf+gc6x7kMzAabS4Z26stqRzNtSz/88T9chJ5L2hTf534ftT61vfQsB/n1OoPryz1DOAl/7OgBhUPwWSfOXp0UmDuY3eKk4/BttARcJ1sAj/xtuu0k/o+w2ogczq8s9aNKPjf1hYI9aztA6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 12 Nov
 2021 17:58:18 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 17:58:18 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domain
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211111211303.12291-1-Ramesh.Errabolu@amd.com>
 <20211111211303.12291-2-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <bf8d1c54-961d-6ba3-f2d2-75e026dfa04f@amd.com>
Date: Fri, 12 Nov 2021 12:58:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211111211303.12291-2-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BL0PR1501CA0010.namprd15.prod.outlook.com
 (2603:10b6:207:17::23) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 BL0PR1501CA0010.namprd15.prod.outlook.com (2603:10b6:207:17::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Fri, 12 Nov 2021 17:58:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 372a10e6-e8cd-4dfa-9b64-08d9a6060191
X-MS-TrafficTypeDiagnostic: BL1PR12MB5304:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53040C763F2ACDBEBD3C6D6A92959@BL1PR12MB5304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnRRsCbQ6wPRE8/kLzW9ls3+X3u5ljXuTAtF+5vwKlP3ngfeS9zGuv1PGrS9WgxoByTtY+uSsPSKmPRWYi2WZFpUbxy7cfSbgwKGzCWweVcLQB+BhVb3tIl1xbv9+7nvuOhOfLyKwCap57sMwn/QmhOXnWEj3ihaChhr+1lPy6Ku8WZ6kN6m2EAt9E032zl195tYPAp5RaFeB2OfXzgWFmKSlHSHdM8rSvXx6AUuPXT+jAbpPd83dAmWza6ppwLc+klbVsvcAjrYJEw9265O+ECt5J5NWbEZ3y186Xq05A8EpEYFX50egayTk/qL0CCsVoLDrePKVeFMpfnz8kScoHrbPe6TwWlYAveKqNdJxWFkpP43Xo4WGTYOXTNw7eKomVjmZQ3hwDjCKSekCtVMCwlsfoEiAFLiVfkeTZVEs2XKtyKWG9eusQdo35b6P3JPSSD5enCmVHPf5DvIE6D/kqIYa4wSVscIFBYPe8/MEmNESeQCBFgeGVmut2FvpbB2uPC/X8MCcZAqvHgrfH63fKxO+rXxYLLe13R1gAi/drzyQWjlSrz7UnakuTUirg1rap44aGOyDS9mLMy7AfQ91iwxahxEtzD6sZEQHrhm+iBLlSwTVnfyKZAznF0ah3ReEn0TNeULTWAvmAPRPBwKGbpbzxBQEvKTFtrAltpfJ+Q6ZrRj+51YOUWn6/NMB5OitFcFcN/PDOtRW3I+W7yCBDoxZaDVrz0YCsC4/akhDYb9Fn3WgFQjdzqb5fLzTEkp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(66946007)(26005)(186003)(83380400001)(2906002)(4001150100001)(31686004)(38100700002)(86362001)(36916002)(8676002)(53546011)(6486002)(36756003)(66476007)(66556008)(508600001)(31696002)(956004)(2616005)(16576012)(8936002)(316002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0w2bHVFc05CNEJIL3ViSitEYm41Vm92THU3dXVYTW45NVQwUGw0VE1kNjg3?=
 =?utf-8?B?Y2dGYU0vMUh2WTgzaGFuRFF3MHFFOGVKUXZMQXlORXlnWXQ5VG1Uc2RVdHM3?=
 =?utf-8?B?Uk02aCtXb01hQ3V4N3RCcDlKTlBjeVc5OUIxR2RCRnl4NEw4Rm93VThZc3BN?=
 =?utf-8?B?MGwycDZHaS9ZZndlUHA1SGdTL2F3OU0yeFpFSERZMFdzaVFBY0YwRWc1eGZk?=
 =?utf-8?B?dVhBUkRiZnhVMEpzWVc5ZGRKRi92aXB6SFo2REJaY2pNNDRnanAyWlNwVXQr?=
 =?utf-8?B?MUdrQXduQ0QybTFyZlJrSFJtNmtBZjFQZ3hCNkoyUTdIb2NtcUJ1Q3JDb0pv?=
 =?utf-8?B?bWx4WVQvemRIVjlJUjZTZmF1UGxoSHVkK1R3dEpvM1JrK2dLay9GSkpLa1h5?=
 =?utf-8?B?S0dBTkFUakhORHV5NytSSFJQaE5xMmg2SjB4Uk8vdGpzbUlMZkpYd2hoaERm?=
 =?utf-8?B?bnJrSDZFQnVERmM3ZlFrdW5XZ3BxV0oxQ1c5ODNRVmtOaXM4UVRDQ2tYSXk2?=
 =?utf-8?B?SW1sNTVXcGhBQmZ3MUtqYXJSNEJ3UkFsc0JQQjY4SzRKMkgyaThwa2N1YW51?=
 =?utf-8?B?Zk5qMWpFZDU2enhkRkdwVjRQMHAwMlJiL2RYNHdwR0R6OEZDdjBDOXlXam80?=
 =?utf-8?B?UWtMcWtYSVFKclVrYlJUYVlEYy9EdzJPQjlUTXc3NFR2SDFMMXI4MGdWY1VR?=
 =?utf-8?B?aTZ4VktNZFZiTWgrRzZDMTI0bWxkUGxTSGw5ako1RS9WYndZZzRHSjNkSXZj?=
 =?utf-8?B?cHgxNks4WXYxSzhtaytnQnVSZERtRlNtMGo4ektkTnNqQ1VrdDZCMTVnSzRi?=
 =?utf-8?B?RUNGQjNtclJKZU15Mm9FR3JpeFd2SDhEWFF1Uko2OEFId0JhUmhIVmpyNEVs?=
 =?utf-8?B?T2l5YTBXelUwdG9qMkV2cWxWaXRDcFQ5QVRXMWE0b3VGTDNiMXNUWUtla3lR?=
 =?utf-8?B?eENsd1FDaWJ5azZRZkpxT2VSTG12TzlsaXBCVjJWVkdrQkFhb1FGT3czaElt?=
 =?utf-8?B?TE4xTDFQZHlQa0MwMUNpbVhvK3cyYTZ1L0Ztd1E1NEt0dDA5TVRIMUZ2NlNp?=
 =?utf-8?B?VnJSVENxUnNMZlFaNkhVOHRGSExscitONVNpZE9MYXZ1SkdGVlNUM2NNeXpr?=
 =?utf-8?B?a2JuVUlQLzAvWWMxUkROSVdaenRDaDJBSTBoVTgwQ3BaZVY2Wm43Sk4zUzQw?=
 =?utf-8?B?eXIyVnVqc21vQ2taek1Yemg5eDRHamFPNkI3QzduMlM3ays3Mnlha1lQVGor?=
 =?utf-8?B?cm5wTi9SVzZpNVJKbUp1S05QVUVXTmFzM1BybTZhYmQ1dDc5UkdNeldHWDdo?=
 =?utf-8?B?Z1lNVjAzWDRGZUdjeWlPSGp5VmVoTkR4bURCNnRCN2g4TmNMRHRHUHJBbWxl?=
 =?utf-8?B?aG1xejBVYWc1azR2Mll5ZXQ4YUdDNlJtVFhNYkZJMkRpMERDclQ0eG1aaWlv?=
 =?utf-8?B?aVBvSllNSm1jL3h5ZWRQM0pRU3NQNlpxaHRZazhrUTB0bElYcFowWjNIdHlo?=
 =?utf-8?B?RGtuanh3c0owQlpVMHUwRUZ5RWpFRm0ram80OURDa3VycS9hOGszMjA3TFZS?=
 =?utf-8?B?d2htMCt0VVF4cEZmRkNlL09XbmpzSEkwdm1YNkNDckpMOFhZRk5Mc05HWXdZ?=
 =?utf-8?B?R3c3WkwvMEZPRzFoM2FnQlA5MUFtSnhjekY2bXZZUVZPbys4WXdkVmNGVWFO?=
 =?utf-8?B?cHhWQ1hLSWdGenZNUWJYWXRkY3Nyd3JRTXk3UFB3WkdmNTlvZnFmMkM0am0y?=
 =?utf-8?B?QUp6Q3RpYy9lZFVXKzQ0eXJma0tNaHV6NjhKN3Z6OTJYMXFUQmc4eGROYXFi?=
 =?utf-8?B?ZmdIL015UnNuSmZWOVlJalJNZERQM1c4YnhRZ0IwZ2NYNjJDRm5ZREZsb1Bq?=
 =?utf-8?B?bk1oUEpXSGEvdEpMK1dlNzkvYzlLZ3p3eUJMZ1lQVDBCbkxyQXFSNmR2S2tS?=
 =?utf-8?B?dHpDcGJ4M054WFllUEJBdkZGUmRnNWxQeGV2b0hzOXpFOG5LWHo3WjRUNkpy?=
 =?utf-8?B?SG5HRUxtcGhvQVZUbDBXdDc5blM0Z3lGdkoyeWVRN1ZoQTdLOXJTNnpOY0RW?=
 =?utf-8?B?UWo2Ny90M3pkaXVRUlRJUzZkVWJnM2xSaGs3eDVhZWNzUmdON1pxOXJRNDlV?=
 =?utf-8?B?WVRNdEZmdHlsbTJmVW1IRTQ4SjFadjh2VUhERVplWEZHeW92MSszR0ZwYnVq?=
 =?utf-8?Q?L8EHnvkkv99g9r3fZ/xmr6A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372a10e6-e8cd-4dfa-9b64-08d9a6060191
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 17:58:18.4164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3tjmxH7WuZsQjUK0ZkD4b7dayeuXuNSCvO+SKotm37y3A/MxhJcOCfmTb1oIWViIzJGNouXfwSCCPMjRF+sUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
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

On 2021-11-11 4:13 p.m., Ramesh Errabolu wrote:
> MMIO/DOORBELL BOs encode control data and should be pinned in GTT
> domain before enabling PCIe connected peer devices in accessing it
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 69 +++++++++++++++++++
>   1 file changed, 69 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index cfc84af682b1..90b985436878 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1295,6 +1295,55 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   	return ret;
>   }
>   
> +/**
> + * amdgpu_amdkfd_gpuvm_pin_bo() - Pins a BO using following criteria
> + * @bo: Handle of buffer object being pinned
> + * @domain: Domain into which BO should be pinned
> + *
> + *   - USERPTR BOs are UNPINNABLE and will return error
> + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
> + *     PIN count incremented. It is valid to PIN a BO multiple times
> + *
> + * Return: ZERO if successful in pinning, Non-Zero in case of error.
> + */
> +static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
> +{
> +	int ret = 0;
> +
> +	ret = amdgpu_bo_reserve(bo, false);
> +	if (unlikely(ret))
> +		return ret;
> +
> +	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
> +	if (ret)
> +		pr_err("Error in Pinning BO to domain: %d\n", domain);
> +
> +	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
> +	amdgpu_bo_unreserve(bo);
> +
> +	return ret;
> +}
> +
> +/**
> + * amdgpu_amdkfd_gpuvm_unpin_bo() - Unpins BO using following criteria
> + * @bo: Handle of buffer object being unpinned
> + *
> + *   - Is a illegal request for USERPTR BOs and is ignored
> + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
> + *     PIN count decremented. Calls to UNPIN must balance calls to PIN
> + */
> +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
> +{
> +	int ret = 0;
> +
> +	ret = amdgpu_bo_reserve(bo, false);
> +	if (unlikely(ret))
> +		return;
> +
> +	amdgpu_bo_unpin(bo);
> +	amdgpu_bo_unreserve(bo);
> +}
> +
>   int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>   					   struct file *filp, u32 pasid,
>   					   void **process_info,
> @@ -1521,10 +1570,22 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	if (offset)
>   		*offset = amdgpu_bo_mmap_offset(bo);
>   
> +	if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +		ret = amdgpu_amdkfd_gpuvm_pin_bo(bo, AMDGPU_GEM_DOMAIN_GTT);
> +		if (ret) {
> +			pr_err("Pinning MMIO/DOORBELL BO during ALLOC FAILED\n");
> +			goto err_pin_bo;
> +		}
> +		bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
> +		bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
> +	}
> +
>   	return 0;
>   
>   allocate_init_user_pages_failed:
>   	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
> +err_pin_bo:
>   	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
>   err_node_allow:
>   	drm_gem_object_put(gobj);
> @@ -1557,6 +1618,14 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	bool is_imported = false;
>   
>   	mutex_lock(&mem->lock);
> +
> +	/* Unpin MMIO/DOORBELL BO's that were pinnned during allocation */
> +	if (mem->alloc_flags &
> +	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
> +	}
> +
>   	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
>   	is_imported = mem->is_imported;
>   	mutex_unlock(&mem->lock);
