Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8216C103E190
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9F410E043;
	Wed, 18 Mar 2026 14:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q5zRyFrP";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BDD10E048
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpegJKpyHGfCYIdU7RGtPx0I8hAhRJeYtSZiSgsHtBX3XYeo3gKNRaPLjOlf8+VmX6SG/hhiXYOpWwLtnXaI4L5z/UWeBna5Eil2jiqnSKTmsqMGW8PLG4qGVqvGkOf5huNGD1GThIKhUcT4527uRpvn7c48o5uQHv0u2RHTlSLuRmk/u3PbOaBBNj0g+MNWNiCtRg0C+I+0bwMysfotkl5TA91GtENARpoMQ3rc1O7gYHL0+UP7uRyiywAms5xLv24x1MQQCiTO1kQ8VSnJQV8zYFlWSYnYZIsdIDx8Dj8X++EAXm3b4XjVTmjQFtFkaeJ3fTlFwsrJ/b2eSpRGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZPe5dn2ymfFT8uYUGBgTJMMVDa2wjcutk2mew9e1+8=;
 b=S0XCf3wImpaIbYybDBcWrPC2FkkV9V3hGEA+qbYHAsV6InB925R7C0ywSCFgSmCL5z6gf3kbWUaCy6zi/L+qAMgIKXFFyXDEovzu5goFeKBWDRWyGKUM+N/0bCoUH5aU5HZ+BMuRYv1daZZsWmTNSlMSF0bijXY9cL2P6Jq1mqDBXka30KwPcZEelP4ZF2SPnNkte0lcqAt/Rowrb3oHiBRQ1wolpgU9SdO47R8ol3hwAkLF+Ny8bFuCKwQPR/pz98u8JPr6m3vZMjaWnxQi91bHHbF/340Ymhh3A2/p/yyRSH3wkahl6/AeUNhigCFClZjuXX3wbYrrJyxxtsxUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZPe5dn2ymfFT8uYUGBgTJMMVDa2wjcutk2mew9e1+8=;
 b=Q5zRyFrP63jJJKzwi3SM1C7tTj06a/ivYA36zQs1ToOFxWbmK517x/2/TbemOnV2G9ct4Nl3zQsAx9cIArj7tuEWJzAUT/rJV+zivkJAYTr1Ejuct/3M/sUOiFuPTcw4MLO1nL3k7hiJsKy23MSoxMwR08UG911NbVeogcOkKiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 14:51:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 14:51:14 +0000
Message-ID: <f9ea26fc-cd55-4684-b510-9257f6579950@amd.com>
Date: Wed, 18 Mar 2026 15:51:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: prevent immediate PASID reuse case
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20260318143555.34179-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260318143555.34179-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:408:ea::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f5b226-12d3-4b1a-2024-08de84fdcd9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: +e4/aKZV4Y4EGBrteA5olSYZR/G4o5mTVoWX/DtUbB3Xx89CF1gv0GTnIlR1Ktg+bKj41VLi4IzmtROrU+Z6JAKF8sPKKhSP60+j4Jy89UXz3JF5sVcORsHWPD/HcffA8ANbZoTqq224sjPeqFPy4V4NQNL3rbZJK0TPhWORqAmu7Ua7tS1ckxP/E72+UxqCO2IDJwuSgGwYRjek2ouD9GH0yZsoyZYOCZnTKvwAHIGPbKqugoZvR6rLFTg37NptCcUQ7lhosXsCDrnFlFoXF7MKr09BVVo7iKznJ9B2O3DB+ecTZH0W9wVhKxrFSMSqc+rGuEcveu/qSRh3aHsax/S1eolmilNhB4bvsrlpuvon5juNdvKwzUdgZLNqftRTcxboYDqJOtE1nuS+DtoiMfsjwDBftgyFvbtYsiPOQauITanW6OXyT+gwIOIjmVrt0NnEp3YfPz94h66D1M6SdZQwrtikQFA6/VZ0fk/uGNLX0fpA4Xond6zAb3k9rVcQHIOpYtuO92cK0A5FMXloBhWn22SbR5pYRWPOeFmtdcNPeLyJBI50A0Zmlv9kiomcEvZnU9f9p8RJa2DFHbgAHvzqHJvmHPKdUYQa4O+DBBTIwRy4yaiurnTcKhErR+OQ5n3Exvp7R3aPCRcthgEBzRXXrUWTGsZY9ewqFVtGPD2AVJ2hwTnj8DhO3OgXSE0pPCftJQsBhvpQS+o6ibOxczwEMiA6K2fmu95ARK0ruLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnErRmlvdHFTSWxOcVFQZldxa09yRWdBWEZxWGcxeTF2eC8vbmVRZWZFcyt0?=
 =?utf-8?B?YzNRT0R4anlGemdlZ3VTMnZ0cWhmdVBGQ2NBRjFTY0g4Y1p6Z2dTSHRMWUxq?=
 =?utf-8?B?Q290YjVDZDRSUXFGcTdKWEhNUTRsZ29wZ20wQUt0amxOa0NyMGpHd3ZLVzBx?=
 =?utf-8?B?UkJuSkkwaTVGUkQybHc3RjVZQXJKUjA0NlU0R3B1YjMyNzBtVEJEZGRicFpj?=
 =?utf-8?B?aHhJSW85SlEzemF1K2xKQmpFWGpkcnRoaVZueEZoNHhTR0FDM3QxQzVWTXFK?=
 =?utf-8?B?MGNLTC91SWp2b2xMNGJBVjJJOVRiQUJ2aDNQU1U4bWJHUnFNZ2dKbzFaOUNx?=
 =?utf-8?B?NHFoMjZwcmk3eS9TRXREMGZEMW1jS3gvZUJuaW1wOFVaaFZSTkIvcWY3RVkw?=
 =?utf-8?B?QlprWmwvOS95aHFCWnVSQkJwenZuV1E1UnZwY3lwZ29HTDhUWnRBN0ljMW1Y?=
 =?utf-8?B?OW5VR2FzQlpJdUtHSVNObHFtU3Q1MmpIcDNnZTdKdHh6SDQ5bkRrWG9hKzVr?=
 =?utf-8?B?d1dWUUlMcXBvTjNaMHFXWG5yNjlUS0xLYng5Zk1JREdmRUpyT3Bvcmh1UE9G?=
 =?utf-8?B?d0t3TUd1L280ZFpwYjVNVmk2VE01Uk5OM0I5MDRIOGYvTFgvN3drRXgxUXQw?=
 =?utf-8?B?Y3BkN0ZlYk1Xc29kTHV5TWgxdDdYb0tLR29SZzVSZlJhbmRFeXZ2eEJGeG1m?=
 =?utf-8?B?VVgwSUdYSUl5L2NJZC9sTStBRlB3cXBHcnFLaDFpWTFkZ0tTNitoeGhOVExV?=
 =?utf-8?B?bHlOMDJ3S1pZQ2Fkampaa1ZBbEV1bXR6c1F2TlROLzNBOWxYYVpBUUpBa0lo?=
 =?utf-8?B?RkY3NHk3d2Z6VkdKeUVGaWRtNWlieWZZN2pJUkRvSklpUVN0UHhwWEhKT1Fn?=
 =?utf-8?B?MWdvQnB5YXBYUUgwWVVlcmhLOFczMGNRbXRTTjFUQ2xLZmY3VkYyZXRnRmVK?=
 =?utf-8?B?cVBIYkpxelAyTHB6R3NvMDRRL20vS3pXQWNTaXpPUmJualRxWHNjMTA0R3BD?=
 =?utf-8?B?cHNzUTQwN1RMcHJHVVNiMnloZ0o5VDZCL0NxaTZWMWdOOGVENHROd2M3bkFZ?=
 =?utf-8?B?UkZPOG1Yb0doNWxYQ01OTUduVmpjZzB4WHRTRUo1QzBvL2RyMFNxMVRuaTFY?=
 =?utf-8?B?Mmc0ZzRReHZYNUZyS2ZWVzJQUlhidXpBMDdxQWxXa01qMzBOZkhRWHphc3Jw?=
 =?utf-8?B?UlFyekRnUjcxWS9PNDA1enRTSFgwRmJuejlzU3hudGI0d2h2czhLMTZrRXFv?=
 =?utf-8?B?LzhBY243WUluYlhVMnM3WXAyTS9LalFPa1l0Z011akVRam1SYlhKQzRIbFVj?=
 =?utf-8?B?d0VISGZmMVFISmpnTndlU1YzWU5ZS2F0NTdEMkd5L09mS3RqVVRZSml6T3BO?=
 =?utf-8?B?emhCWUFPdVlnYUw5UVRSQ1c1UHFCV0Y2dFFkc3dVaVIvd2FrU1hYVlFLRWxl?=
 =?utf-8?B?ZTFtWGlXbEI3TGljQkFiTWpxRGw0VFlVL0Jjek8zTENxWHE4bmRXblh3cDNq?=
 =?utf-8?B?cFNGaUlxek91L0h5T3hiN2pkUTNiR3hZRWQ4aWhFQ3IzV0NKc1d4Y2J6Ukd5?=
 =?utf-8?B?RFovWXNMbWNoVFlid3puMnkzbkdzMHlwQjlYZTczUEZ1Rm0zWkFvdXJPR0tZ?=
 =?utf-8?B?RUpCSXRDSnRMN1BzQVN6ZjRRUkJIOE9TMmRUc3I1TEtReFdRbUQwTmVLenZD?=
 =?utf-8?B?ckdKbkVBUTNjaFBBdndESzE4OFNXK2VtbFpDK01MY1BaRHhQUUVYdUIvVS8y?=
 =?utf-8?B?eU1OcWg5dmJUNUZqY29qbS9LdktiUnVYaEFkdmJodUc3MEtGbFRYYlFDYStW?=
 =?utf-8?B?UGRiOEpPR1JwNUd1bG9JMmVyV281OWVQNkJhMER0UEQ2dTl5NC9peUFCM09p?=
 =?utf-8?B?QWxTZWtCenE3WXNoQVVFMzB0ZDJDcjlaSXIrWVc3bFNPRThqa0dNdVdyd2Rn?=
 =?utf-8?B?NWN2ckN5N2VyT1dIS0grVWEyR295eFA0ZDVwUHczamNyWGxKSk16YnRUY3Zz?=
 =?utf-8?B?Z1huUlV4R1BNREZVL1VrdUFBRjREQWhpRVBSUG5TZjYwdUdzcDl3czhXS3Nl?=
 =?utf-8?B?c01HdEo1dzdyU0R3Z2pyN1cwVFMrOWI1STRiNEc0T1ozei9vQWtMQUhMWU5K?=
 =?utf-8?B?ejU2b2tMZVRsNlVpd2VBcnhXWDFxNndrbXpvY1lkU0RUdVpEdXdkUitMNnp0?=
 =?utf-8?B?STBUWFlLeWFCbnZsNDNrSVBPZ3NQaUN0bTMwcldKWGJReEVWZ0lDRnBacjZm?=
 =?utf-8?B?YW5zYUJyRldyWWdNd3VLQmFGclZpbVc2Q3VncG9Ld082QWttb2lvYWllYXBF?=
 =?utf-8?Q?qA/9VBsq0XREeejUDm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f5b226-12d3-4b1a-2024-08de84fdcd9c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:51:14.6529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USn5kDPWziZTF1/YeEfRdVABgFQ/DRpwu4RWUIwv6Pxk9Xu2QSlI+MhVCiUL0L/9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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

On 3/18/26 15:35, Eric Huang wrote:
> using idr cyclic allocator same as kernel pid's.

What I mean is that this needs more techincal background and not less. E.g. something like this:

It's possible that page faults are still pending in the IH ring buffer when the process exits and frees up its PASID.

Since we don't have a good way of flushing those out use the PASIDs in a cyclic manner.

Regards,
Christian.

> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 45 ++++++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  1 +
>  3 files changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 9cab36322c16..0801c023f5a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -35,10 +35,13 @@
>   * PASIDs are global address space identifiers that can be shared
>   * between the GPU, an IOMMU and the driver. VMs on different devices
>   * may use the same PASID if they share the same address
> - * space. Therefore PASIDs are allocated using a global IDA. VMs are
> - * looked up from the PASID per amdgpu_device.
> + * space. Therefore PASIDs are allocated using IDR cyclic allocator
> + * (similar to kernel PID allocation) which naturally delays reuse.
> + * VMs are looked up from the PASID per amdgpu_device.
>   */
> -static DEFINE_IDA(amdgpu_pasid_ida);
> +
> +static DEFINE_IDR(amdgpu_pasid_idr);
> +static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
>  
>  /* Helper to free pasid from a fence callback */
>  struct amdgpu_pasid_cb {
> @@ -50,8 +53,8 @@ struct amdgpu_pasid_cb {
>   * amdgpu_pasid_alloc - Allocate a PASID
>   * @bits: Maximum width of the PASID in bits, must be at least 1
>   *
> - * Allocates a PASID of the given width while keeping smaller PASIDs
> - * available if possible.
> + * Uses kernel's IDR cyclic allocator (same as PID allocation).
> + * Allocates sequentially with automatic wrap-around.
>   *
>   * Returns a positive integer on success. Returns %-EINVAL if bits==0.
>   * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
> @@ -59,14 +62,15 @@ struct amdgpu_pasid_cb {
>   */
>  int amdgpu_pasid_alloc(unsigned int bits)
>  {
> -	int pasid = -EINVAL;
> +	int pasid;
>  
> -	for (bits = min(bits, 31U); bits > 0; bits--) {
> -		pasid = ida_alloc_range(&amdgpu_pasid_ida, 1U << (bits - 1),
> -					(1U << bits) - 1, GFP_KERNEL);
> -		if (pasid != -ENOSPC)
> -			break;
> -	}
> +	if (bits == 0)
> +		return -EINVAL;
> +
> +	spin_lock(&amdgpu_pasid_idr_lock);
> +	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> +			         1U << bits, GFP_KERNEL);
> +	spin_unlock(&amdgpu_pasid_idr_lock);
>  
>  	if (pasid >= 0)
>  		trace_amdgpu_pasid_allocated(pasid);
> @@ -81,7 +85,10 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  void amdgpu_pasid_free(u32 pasid)
>  {
>  	trace_amdgpu_pasid_freed(pasid);
> -	ida_free(&amdgpu_pasid_ida, pasid);
> +
> +	spin_lock(&amdgpu_pasid_idr_lock);
> +	idr_remove(&amdgpu_pasid_idr, pasid);
> +	spin_unlock(&amdgpu_pasid_idr_lock);
>  }
>  
>  static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> @@ -616,3 +623,15 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
>  		}
>  	}
>  }
> +
> +/**
> + * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
> + *
> + * Cleanup the IDR allocator.
> + */
> +void amdgpu_pasid_mgr_cleanup(void)
> +{
> +	spin_lock(&amdgpu_pasid_idr_lock);
> +	idr_destroy(&amdgpu_pasid_idr);
> +	spin_unlock(&amdgpu_pasid_idr_lock);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index b3649cd3af56..a57919478d3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -74,6 +74,7 @@ int amdgpu_pasid_alloc(unsigned int bits);
>  void amdgpu_pasid_free(u32 pasid);
>  void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>  			       u32 pasid);
> +void amdgpu_pasid_mgr_cleanup(void);
>  
>  bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>  			       struct amdgpu_vmid *id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b89013a6aa0b..5b9bdb79efcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2864,6 +2864,7 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>  	xa_destroy(&adev->vm_manager.pasids);
>  
>  	amdgpu_vmid_mgr_fini(adev);
> +	amdgpu_pasid_mgr_cleanup();
>  }
>  
>  /**

