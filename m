Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74760A2622
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2xrwwp+k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D92910E3F1;
	Tue, 27 Oct 2026 13:25:46 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013054.outbound.protection.outlook.com
 [40.93.196.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42A1110F519
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 13:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYlQuTEKY7/6jNog94wt6vBgt6wHhHzx5r+qUMt0A/FlLD+i7DyYPnRx7AUxCvcAAlzmdVMoesilsiwVs/94csU5QB30cwJXE1ZM+3fmW+w5qUOM5j/FXWU0adT8q5hK61tTvto6wDR3SoLHM9qHYedpuihRr4WrfY+2qDGZaihsi4ETySETEWfg6waQJvbyilCLa5o4B3yCFGbs9uN5pLFoGLKyLfN2ED64Ez7KfHVrBlUdfaZ9jnuSNiyzcd07VTmOOVVQrDmjVxFX9ggtw40b0FXYgzq6kgpXOc+pjGOyyY5MtD9iUyETlZktCfAcOjFGbTd5Ykb53eClkxrwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KChMKmVOL6GXkaEo29Osr0oWuI7vm/y/F8EbaUiFi6A=;
 b=s87eGWA9sEb/NUP2TfD775D+31Kat1kklVedcrMby0OSSf0cTN8fI7wRqvw8gWwf9wjyMJGqy2tYT9FDJXBr4xqYaGuMLboF28ICm3TZ/b0/IxXE40JDnqJlUAmneW2jnmhZ5GXu+sUwgB6SC8EXNIKkQknVPrcLVqQZISvpn04mrMO5W1/xbo2VTZPFo1p5eIoCxhUfqEMxGM/Rs2brOlwcnTKMhoBzjalatxAYYGgBFGLKXTPnzyTW6xiGq3ADIS0Cnp4wOcTUG5o0lbKha5LPFVbKIUKsbYznObemwOUvfJ9oBZXcpZAvr4W3zgBJ56u7fZ0GcLgF4sTP2ZGVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KChMKmVOL6GXkaEo29Osr0oWuI7vm/y/F8EbaUiFi6A=;
 b=2xrwwp+kxQ43HLKll5GZ/2ppAQQL5lMSI5rLNo5z0smN0igCrk2MX1mykXn44ixSTxNZ5EqrVR9dTXLKnW7siAa69ELAS69i8M0P6EsrynxNL1bqzGTnmDvl56vSln68M0XenUpQCmT4O2iij4+Qdmw25aJxbdDYT1m+ihWcs6I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:25:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 13:25:28 +0000
Message-ID: <e43cd3c4-555b-49ec-a550-4a24c672ba77@amd.com>
Date: Tue, 27 Oct 2026 14:25:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/amdgpu: Add usage argument to amdgpu_sync_resv.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
Cc: samuel.pitoiset@gmail.com, natalie.vock@gmx.de
References: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
 <20261022003058.1723817-3-bas@basnieuwenhuizen.nl>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261022003058.1723817-3-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:408:f8::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c1328e-4b74-468b-b4c8-08df342dc477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261009223027099003|261022105027099003|261021123027099003|261021121427099003|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: R7zA80GXKLA11/jOprrUFumvuha7ET1yCUBLZy8pQW8eVjpwNYTt/B+9sN/85wuhJ5wOVaKJUpVN3lW6+31OFOawxPi35v/iWx2Mkl0nyVvG6i/AWlok88QbV0/idFwtOVH2E+NuvQ+kTMGFpOjaoD0sJh6X9bhYeuyXrLxv9qisBgg54eUAdN7FrJVGmAmE4/B1HxJFjZFAcgWc7kwEkfsbw4X5vky0pU4u1+i+4J3jsYNBnrnSp62lrraEOPeFM23I2hNqlwKn8zSGBUhOM7KFWn1Sjz2TDJgnFydU8PRyTT/jXXzN97Kpx+XzYpBN0d7Gqd/kXDW4bgu35wSL3VOnjzaglvA9mdrshXpao5fFxDRRoA5J7ot+in8VdaR8x0U99C7GV4PtUfZcKIkfe9vnewScvSQhsh7TovLwznqNHyFaNhipbqGFuP/jC1qQyLeZs7r9i65dDWIOWGVYYZYEgLoYqImLpAqpa69M6G2wQWG7Q9590KQUrCWWIJbI9bpV+Qu6mf+3+OnZwqP05l3YGLdhkvJhT94D6ywoP9GUUKMxN2n/9P84SxIPcPIJ/iDXElwHftJ3joF/+n4iyp9MIdZg522wArOtVakbT09GKsVdN7CkD4Z55P9RoLF/iZIJVhyfLBWoJXAhSjcHufkdsRSh85SjiDu+EHTPhLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndMbkp0bWFTMC9lTkNSWWZuakRIZDh4NEtTUGk1eVpQRDFlY3dCbHVtaFpP?=
 =?utf-8?B?M0w0ME1INkpuYkVVbXJicWpISDVDY1hrUjAwNFUrTHd5cTNnb0xJemUwb0VP?=
 =?utf-8?B?Snl3d1lwbFFBRlYxTzhyK1JGSGRleEVZTnEvV2JIL0VEMllEZXNVbWZMcHdP?=
 =?utf-8?B?aFBuREt0aDdnRm1IR2ppaUhMRFZaY3RtdnlkckdROTFHWHF4emxFbWFaY3A5?=
 =?utf-8?B?eGU1bTVyUHUydWxKcWF2RG9KYzg2WjV0NnQzaUFLVUl5N1N4SG9kb0xLM1cy?=
 =?utf-8?B?UEFEb0MvSWl1Y1QyMTZhNkxReWY3SmtQK2RXd2p6cU1MQ2twSmlKRDkxalU4?=
 =?utf-8?B?dTFLeDl4K0ZJbDgyaEZrOWEyZUMvY20xaXUzd3ZMQWE5eUVROXlodTl5QVJY?=
 =?utf-8?B?Qy80TUxQYUR3aU05ZFhjTXBrNUxxSjBNcFJlUm1IaHFSRGJrd1BGU0lNUk94?=
 =?utf-8?B?VzgwcExBeDJFV1VmNHFMcHZjeXM0SnZXYzNTSGpYZ3dDWjdhc2VXMDNRRnpR?=
 =?utf-8?B?ZVFuZFRvbzJ2Q0tTWm1BTis1Z3lMOWhJVmRwU2FHQml3NHU4Z3FwMXdnMkI4?=
 =?utf-8?B?S016WE9xbGR5OFBpNUpLN3RmaE55U1lNcnEyaWowOEJBcCtoVmJzNWdRRFZq?=
 =?utf-8?B?RDZ3MmNud1dzamc4dGkrdmxrOHg0ZzBzT2VxTExMd3dXMFF3cDNhZzI1NExW?=
 =?utf-8?B?UTZpT1VyU21SSkU5dmFkMFQzcG9DaDNKR3pQTHVwUnBDWTM4dUQ0a2FkY2da?=
 =?utf-8?B?QWZQcjN1R2NYQ29NS3c4MDY5eTRhVHEwOUI3VU56SWZFZ0JmeGk2NmZSQWJ2?=
 =?utf-8?B?Y0RzNFFvVWR1Y3AvWEVHYnJ6a2g4cjc2WTBscUM3ZXZxZUx2bUgrczV1dUtn?=
 =?utf-8?B?REdYRDV1N1lucEdmbk8wRndoTExINVk5bGs5anJwaWRXWnoyUHU1VXZlWTF4?=
 =?utf-8?B?QjVsMWZwN3ltSEg3Wks1cHZscHA2Skc2K2t5Vm9MbkRkVDdOaE8vUXlCWmJp?=
 =?utf-8?B?UURwU2hJWE91dkhnTk9BOGYyc0N5UXY4TkE1NzVGT2N4K09MdVBqcW8yOHVX?=
 =?utf-8?B?WlZjVjlJSUwvTkdpS01nbXZGQXFteGw5aHhQSUFBYzhmMHhqVFVmOVJpQ0N0?=
 =?utf-8?B?dFUwNzJKbnI4U1BKRkdISjdJeFRoZnBpdXZ6aklUV1BQbEVzSkZHR29mbkVq?=
 =?utf-8?B?UHNDcmtYVFhXUkFqOU5KUVZ0MjBSNElXVnc3R3QraVNKenRyRGRYcHAzbVVi?=
 =?utf-8?B?ZnorWUFYWkUrOGpNSGw4aEIrdlV3bUNTMk9CMSswSXpqY2luZ1Z0K2svMTMx?=
 =?utf-8?B?WHZWUzd5RVFNK3RERGk0aFJ4WEtGZkxkVnhORWs4WHh3eXJzVVp0VXIyTDdI?=
 =?utf-8?B?VzNpNTdCSFNScVN6TmxxSnZ3MVRGVktraEVwTitIUUlUdnRlU2tJRW9KTTI3?=
 =?utf-8?B?dlNUTWNUdTlLL2YwejNnZmRpMWxPU3IxRVU0bzJKZWtjbW0wbStwakhpdkRs?=
 =?utf-8?B?QU5SaVVEUmMyUDBxVk1yOU5JUnEyUlZGbkVoTy9iYTRjQVN3eWM0UkM3cWRC?=
 =?utf-8?B?UU96L2gwS1VWQkNuenRxUmRXVUcwUzNZbjk1LzkxTTB5NFNGNXhzakQ4a2xl?=
 =?utf-8?B?Z09pYjVQN1d4SHZJZy95RC9SckNDMlpRNzRsL0E3ZTNmOGNnbVJyYm9SSm5G?=
 =?utf-8?B?VVBBZXQ5bHVJdUlaR0oyOVdEa3JaNUhNa0REQlBFM28zSnpVWlZhR2YvV2Fk?=
 =?utf-8?B?VXVqeExLa21GWXhLa0FsaytQMlRMRTNjMkZYVWNUZG15a0RSS3Q3WmFrRzdQ?=
 =?utf-8?B?T1FJWHliUW90UWh3dlB0WUxDK21iazZycHFXbktiZjA2aTJWVGxORnVUNm0x?=
 =?utf-8?B?KzVBYnk0U3g1VmpSUy9abzljVG85OXRmbWVDL0dOUVBxSGJ4MEZ6NHdFYVFB?=
 =?utf-8?B?amluVXhwbDBpSFpUWC9zcUMySmNTb0xJcldqNHNhUTNzRW9PTU9rWHhoc2pR?=
 =?utf-8?B?eXpSeGJNS2J1VFFiR1MyRjFudkNjUzVzL2R2TWtqTUkxZU5MZ3lJZ0taSkw1?=
 =?utf-8?B?OWp0YjJhbEZWODNpMFVRMCtJQXhwaGNNWW13VlQxaXU1QXpYd0hrY0IzOHVV?=
 =?utf-8?B?ZTY5UmNmVFlIUWhoRzYrTURncVh4Wlg1TnZOTERiWCtUbE83eFRHMmFYL3Nm?=
 =?utf-8?B?U2pONnVndHdPaVA0SmdQV0x2VFVybjMzSXNnY2crUUVTaFJwVkJkdVM1d2Uz?=
 =?utf-8?B?NmtaWHBROXoyOTVIY1gzNkltMlEyNXp2K2dzT1hSSURXcXV0YTZuWVc1LzlH?=
 =?utf-8?Q?MaczST2zAgckuDwPrd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c1328e-4b74-468b-b4c8-08df342dc477
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:25:28.7028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfPXLbPRXS1cDmIhLxprh75ttkQD+W1amBQqQZ/o6kuzt7UTNzDc9jDQtxqHAlz+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 02:30, Bas Nieuwenhuizen wrote:
> Let callers pass the highest dma_resv usage amdgpu_sync_resv() syncs to,
> instead of hardcoding DMA_RESV_USAGE_READ. All existing callers pass
> DMA_RESV_USAGE_READ, so there is no functional change.
> 
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>

We probably want to drop that change again at some point when we can fully switch over to only use the amdgpu_sync handling for WRITES.

But for now Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c       | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c         | 9 +++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h         | 5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 8 +++++---
>  6 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 9a7e14a3c719..0ed41f696197 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1375,6 +1375,7 @@ static int process_sync_pds_resv(struct amdkfd_process_info *process_info,
>  		struct amdgpu_bo *pd = peer_vm->root.bo;
>  
>  		ret = amdgpu_sync_resv(NULL, sync, pd->tbo.base.resv,
> +				       DMA_RESV_USAGE_READ,
>  				       AMDGPU_SYNC_NE_OWNER,
>  				       AMDGPU_FENCE_OWNER_KFD);
>  		if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 63fd16009bf8..afcd254c9884 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1227,7 +1227,9 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>  
>  		sync_mode = amdgpu_bo_explicit_sync(bo) ?
>  			AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
> -		r = amdgpu_sync_resv(p->adev, &p->sync, resv, sync_mode,
> +		/* Implicitly sync only to KERNEL, WRITE and READ */
> +		r = amdgpu_sync_resv(p->adev, &p->sync, resv,
> +				     DMA_RESV_USAGE_READ, sync_mode,
>  				     &fpriv->vm);
>  		if (r)
>  			return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index d6d84ff110a0..663873dc005a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1454,7 +1454,8 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
>  	int r;
>  
>  	amdgpu_sync_create(&sync);
> -	amdgpu_sync_resv(adev, &sync, resv, sync_mode, owner);
> +	amdgpu_sync_resv(adev, &sync, resv, DMA_RESV_USAGE_READ, sync_mode,
> +			 owner);
>  	r = amdgpu_sync_wait(&sync, intr);
>  	amdgpu_sync_free(&sync);
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index d6ae9974c952..c670ca01c230 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -234,14 +234,15 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
>   * @adev: amdgpu device
>   * @sync: sync object to add fences from reservation object to
>   * @resv: reservation object with embedded fence
> + * @usage: the maximum fence usage to sync to
>   * @mode: how owner affects which fences we sync to
>   * @owner: owner of the planned job submission
>   *
>   * Sync to the fence
>   */
>  int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
> -		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
> -		     void *owner)
> +		     struct dma_resv *resv, enum dma_resv_usage usage,
> +		     enum amdgpu_sync_mode mode, void *owner)
>  {
>  	struct dma_resv_iter cursor;
>  	struct dma_fence *f;
> @@ -249,8 +250,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
>  
>  	if (resv == NULL)
>  		return -EINVAL;
> -	/* Implicitly sync only to KERNEL, WRITE and READ */
> -	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
> +
> +	dma_resv_for_each_fence(&cursor, resv, usage, f) {
>  		dma_fence_chain_for_each(f, f) {
>  			struct dma_fence *tmp = dma_fence_chain_contained(f);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> index 51eb4382c91e..7d39bdb9d4d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> @@ -24,6 +24,7 @@
>  #ifndef __AMDGPU_SYNC_H__
>  #define __AMDGPU_SYNC_H__
>  
> +#include <linux/dma-resv.h>
>  #include <linux/hashtable.h>
>  
>  struct dma_fence;
> @@ -50,8 +51,8 @@ void amdgpu_sync_create(struct amdgpu_sync *sync);
>  int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f,
>  		      gfp_t flags);
>  int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
> -		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
> -		     void *owner);
> +		     struct dma_resv *resv, enum dma_resv_usage usage,
> +		     enum amdgpu_sync_mode mode, void *owner);
>  int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv);
>  struct dma_fence *amdgpu_sync_peek_fence(struct amdgpu_sync *sync,
>  				     struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0b8a8f82ecab..6adeb4b0e217 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1307,7 +1307,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>  		 * unmapping.
>  		 */
>  		r = amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
> -				     AMDGPU_SYNC_EQ_OWNER, vm);
> +				     DMA_RESV_USAGE_READ, AMDGPU_SYNC_EQ_OWNER,
> +				     vm);
>  		if (r)
>  			goto error_free;
>  		if (bo) {
> @@ -1339,7 +1340,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>  
>  		/* Implicitly sync to moving fences before mapping anything */
>  		r = amdgpu_sync_resv(adev, &sync, bo->tbo.base.resv,
> -				     AMDGPU_SYNC_EXPLICIT, vm);
> +				     DMA_RESV_USAGE_READ, AMDGPU_SYNC_EXPLICIT,
> +				     vm);
>  		if (r)
>  			goto error_free;
>  	}
> @@ -1593,7 +1595,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>  	 */
>  	amdgpu_sync_create(&sync);
>  	r = amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
> -			     AMDGPU_SYNC_EQ_OWNER, vm);
> +			     DMA_RESV_USAGE_READ, AMDGPU_SYNC_EQ_OWNER, vm);
>  	if (r)
>  		goto error_free;
>  

