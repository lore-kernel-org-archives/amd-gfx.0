Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A092110A3D85
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DDB910EA55;
	Thu, 26 Mar 2026 12:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cq3J6jwO";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70CE910E97B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgXYrySzncdgCaqaAPqAJAp00iSajV2cT8uwM0rNTF+cj/obcHvrVsZ79fE24d/odDJZh9X+qQpwoOMnkSJsE//qFtmU7gtEORUrbecO+0qKfzWaQBOhi/FQIsT6yIZ8lWVet19q/B5dIbLwUH7IEfZTDqQ6wdWBE1FhB+6gfdYRchGq465fja097+mSi0VYMedzPjzDy5pciNvm8C7p6KeBPiCMdzHM2WD7SS6X7skG+w/YyesQVf6ZrwRgnwlxP6EX1ENqUezjkSaXErbfp3Enb9KaQQWeFdyKCab10fH+o/+czz8NMIIb8E/EVTaNWe4/YqKTrGfUBQrJe0ruFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm7k92uxGqrJNFShjkprLFbe+COdyvBo1BRdCld0Ryw=;
 b=Rm/VxnuZHGVvC3q5tRvhJ9WAd72u5mbexAuDwYM+3tnSqXkEBS+Pa2gz1+4OZSNvTjlr9wt+cHu93p3buAtB++/7oUJQcsY4m4Li75v88i6YyYYyENERcrX7GZhQv5XNkW+qF7Izh/p2KpArx8KIXos7HZK2aunGq/JjXNjOVJ1AytOiq4ozAt3g/93bwZPkWIEYA5jYYab8i+JrboIzm1Zs+pmXwx0WqZX7HzMvxnxL2jOOZPqGgvtTOpdHPgebu7X+V0hRT5xcaNIgIup+g7MXsZFkbjvcrFLjHiz4XK8FosI9Yefytl7NnN72WV7yANDKaoqmyrrNL3gNc4Rcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hm7k92uxGqrJNFShjkprLFbe+COdyvBo1BRdCld0Ryw=;
 b=cq3J6jwOAYr95JmTgmXt3pZfY7iEKaTnV8pIv9rmJLhRQSAJEqO63xPEyGsAm1ANb6oL4CPPE0fnxrIddYfTWR44/wI/HEDGq5DarAGMtNYfIEA8yhdtbYg8eK4vOeEZwYpcDkg3+3jsiMFsfLCw7GBH/AKwI5YCCUQP3qcGAnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Thu, 26 Mar
 2026 12:11:14 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 12:11:14 +0000
Message-ID: <94fd70ca-1700-4e3c-b6d2-34a51b63f265@amd.com>
Date: Thu, 26 Mar 2026 13:11:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1 3/4] drm/amdgpu/userq: no need to use local variable
 here for return
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260326085601.2665215-1-sunil.khatri@amd.com>
 <20260326085601.2665215-4-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260326085601.2665215-4-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::18) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f820df-2c8b-4070-7cf1-08de8b30c67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 9RsSsESCYLZcNS7n9aCryuVzCe6CQu23nvJH3rp6aRYa2301eQf+xpuJHjlvg/44TIMLR2h/vLMl2ESetb5snQaOjNhdDGd9mtxwhL30029a49oqbPTez5PG9iXuV+12wVYn6MpPoK/GDBKhM0qAUDyqE1ZM5RX2Ied1+7FUJLCbCXgIQonaBw76YcqY1bxCM3cUWy/02qA64Sf6ST+Na19icT4pED7Mzj+T6tYH/Gg0Pl2qVAEA/TpTYt1OjYfj2hqI6zu9d0p2keckXJnKBweDTsGYiVeHK6D24Vg15OLS3if2CII/l7xxi17a3ePwvfvgomuffvfPr6lhyHnolR+/x+J4J+ue91SwCWtB68lQobmeGSSzv67uX/qPUD5ZrrtL3Y5EqcvO87AJDAMUfYb/lTMY/XPEiSEO6rA7SGB/PmYBwQiQI6+pyMRdMoWHHvUtg8w2i025y21UhELRcZeWqQMywmyI1LXBpJGAPfuAS3QHVEwBMIlvI52i0Y7hqQ9xSWDFwMv77NCAF69mgZzzKeWzdj6n8AxuXDZCZ2TH39U4w0QXCQYIz52d/3BSjjGJJc8Gm3hdG5GCbIE0fNup0S7U735NrjlMZfgUFir/fcprlGy9r54p6CcG7g2IMSq+B2YNmUCQDqfuIpkhB8Wu/IWHPnciAIW/rGPSlmx2E6bHWIJW02POYSGgFUmBqzXnwy9hyIXwlTm7C3znVSjlNIPtaZH/Il7L2D6cvoc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGxQQzN0RmFDckMzY2VqNXBOOW1tVDZtSlhuMTZyS3BJazhaR1U0NEI3dWt2?=
 =?utf-8?B?a2VST1FYNjJCZDlOQmFVZGMyVTF4UnkzT0RNNFNNUXA4UXh4Qm1FcFZEVlFj?=
 =?utf-8?B?OGhybEFraHVGbXJPZTBKcW1SNWRYckNuT1grUk1rdnRsR0FJd3N4Z24wOW5V?=
 =?utf-8?B?dWN2clgrMW9odlFIVndvTFNHbXAwNy9VODVqMVNNSEg2dGFPbWk5dXF6bFM0?=
 =?utf-8?B?V2NpU1QyWUQxbGpmRzVnUy9LRnpMaTg4QXpDUUprWVU4Tk92dkQ5bXZFckp3?=
 =?utf-8?B?WXFxNmp0TTV2Sk42eGo4ejY1aXJCK20wQXVJVHZHRWQ3clN6elEzOFdSY09X?=
 =?utf-8?B?M2lHLzArMnRldWY2V20vcjVTcGNkaHVwSEVRbjRkREZSMDMvVVJPakVUUTRq?=
 =?utf-8?B?SW1YWjd2QmdtRDBhZkljZHh2TDR0cmNFZEo5R1g1WGx4aS92YUl4T2l2ZWtE?=
 =?utf-8?B?cjJhOHE0ckpoZ3BNVm1hU3BnVmo3eFljWXIzZVh6WDJTN01TRGw4ZzAweHhn?=
 =?utf-8?B?RHNpU1U2RzJXRHhOMXk5bVgxWCtmMHBQbWZkYjFiMGNYVFV1RWZZQVVlQkxO?=
 =?utf-8?B?T01sYjZYTkpiTEpaWmdlTDBrY3lGcURibFlXSlRQTC8vNkl2ZFVKbUNoRVdp?=
 =?utf-8?B?T2JrRmFtNEdRZ2EwV1hoOVU4Y1p1cmQzZDZVUCtDQXlRVjBwYUg2bVRXaG5X?=
 =?utf-8?B?djdXQnd0TUV5b0FySS9Ca3BYVElGcVBtMCs4aFBLRUNxdkkxc29KZkF4dEVN?=
 =?utf-8?B?WDhiZVRHdTF5WnN4SkhFNGtxZUpBWDQwT1BtUHVBU0ZGc0lVSVp0L01HUXpi?=
 =?utf-8?B?R2NFVGI3TEZ6MXhHR08rTFl6ZFNvVzJOUDJhQk1TOWJjR0xVNFJpTHdIZ1VY?=
 =?utf-8?B?OHV1ZThDQzVGRzR1VnV1bktOaU4zY2YwT3p2OEdqc0V1MGI5ZjIwMG4vbEkx?=
 =?utf-8?B?K09pb2RteVQxSDNwZDlyTEsrdEtYSmgyeG0yNWVQU2NRQXVWZkE2MG11VUQv?=
 =?utf-8?B?V2ZTbzUxcFFFUU5xUXhVS1ZTc2t2UlpERzIwWUtNN056ekkrK3oxVUQzWjQr?=
 =?utf-8?B?NFBPenNRbzNDRU45dVRyd0d4Wk9vMG84cTVjNDQvcnEvZkdzVElWQllvZ2lh?=
 =?utf-8?B?SUh2V1RSczlzUVVLZml5Y3hRV1hESHJRNEVlTzVXcVVTSHV1cXBiTUs5dnZw?=
 =?utf-8?B?dkRubDZmb09HRkFyc0JmR29yOTdudGtKQUJjR3pOQ1RXcGprOWkzMlVjeEdU?=
 =?utf-8?B?MjlCcGtPZlJTTThGcTdVREZwMlJ3MldWYXZtVmVCdGxpbzdZYndGWDVqdm1l?=
 =?utf-8?B?blM3cWxXdGo4UTg1TWV2NFJOTWUwT040c0NIMW5Zd29sdjF6SFVMMXcyUEV4?=
 =?utf-8?B?NGRscmlaQ0tFOGtHZXF0UkVCblU4MEZqOGp3U3YxZTkrZmpEYllNTlN1Wjh5?=
 =?utf-8?B?QjJtVDMyQnZ2c1pCdGlYTWlrRk5SdS92SWFSKzR4bEtlZU9hMWtqNG5HY2V4?=
 =?utf-8?B?VVNSZjNucjNRU29XUzMrTXh2WDhXeDBLOEhWSDVzZDc5dm9EbUhmVXAzZkY5?=
 =?utf-8?B?R1BDa0p3Z203ZDJqRG10ZlQ0bXVpSTZCbWlPZk11MUZLNC9jQUZtclpZNFVD?=
 =?utf-8?B?RDBqSG5ldDBDeXFyVjY3MDIyK2Fkd0lZTFVYZnR5UUltWDIwSTBpWFB6UlhU?=
 =?utf-8?B?VlVNOWFDY0ZmbkhCRDJvdmd0RzlTbVV4YUVtWTNkbUZ5VUx0aDJBQzAwaTdn?=
 =?utf-8?B?NU1qdU04RDVMTVpBZDAvcHNHVWQxYlFDcjYzSWN6TngxU21pbHN1c3A2cVIy?=
 =?utf-8?B?TStVMmtqKzg0Z09uMGVmWnhWSDBzbUtFTGtCMXZZUTN3cWh3WUg2aXRMcHds?=
 =?utf-8?B?MnQ2S0F6Uit3bkhxTjZTNVl3OFhEN1FJS1RuV2VGL0tXZG5iVU5ITlQxY0dM?=
 =?utf-8?B?RW0zenhjUjRXWllkYWlPR0VnY1Z3NStZYjVkK2hHMG9nK2JwV0ZWaUNhYUUv?=
 =?utf-8?B?bDdvRVAvUms0VDJTcXk3Zktzb1l0Nk11RWpUK3Y2QTBOK1ZhYWZEemF3NWsv?=
 =?utf-8?B?Q2tMS21sS2s2ZHNTZFVMTTV5QzlOQ21ndWFXVFQvcnY1UVdNQnhTdVdrcGs1?=
 =?utf-8?B?Ymp4RlJycmNTRk1maVJHZVE0SGRlelRKQThDS2hXLzhRalJQRTV1THNOQnE4?=
 =?utf-8?B?UkdPVVczRy84QXhpekRYejJwRTQ0ZVpoa3hJVWtXNHlYemtBY1c4TURULzgx?=
 =?utf-8?B?OWNUd3A1bEZrMGRzM0xKbHNEYlNnMzhkdmwxNWd1Z2E2b1J5RVlEMDM4cmJF?=
 =?utf-8?Q?VqfoRdA0JDIPB70boH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f820df-2c8b-4070-7cf1-08de8b30c67d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:11:13.9678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ib4dCEVyeWlI9polve5Rov4lKqGKNyyoITIA1pWVguHf7N+VNRRlx4BJjHy5pz90
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749
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



On 3/26/26 09:56, Sunil Khatri wrote:
> In function amdgpu_userq_gem_va_unmap_validate use function
> return value directly in the if condition instead
> of local variable ret.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 2b07c3941927..48cb2e21ce56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1478,7 +1478,6 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>  	struct amdgpu_bo_va *bo_va = mapping->bo_va;
>  	struct dma_resv *resv = bo_va->base.bo->tbo.base.resv;
> -	int ret = 0;
>  
>  	if (!ip_mask)
>  		return 0;
> @@ -1493,9 +1492,8 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  	 * the eviction fence is always unsignaled.
>  	 */
>  	if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {

That test is just nonsense, call dma_resv_wait_timeout() directly here.

> -		ret = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
> -					    MAX_SCHEDULE_TIMEOUT);
> -		if (ret <= 0)
> +		if (dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
> +					    MAX_SCHEDULE_TIMEOUT) <= 0)
>  			return -EBUSY;

That is wrong as well. We need to return ret here and not -EBUSY!

Regards,
Christian.

>  	}
>  

