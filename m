Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9567FF495E
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 14:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5497F10E7AE;
	Mon, 30 Mar 2026 14:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tr/qXhSP";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1405210E5FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 14:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzSv3DZyt1hK9HQtl5KU7mYaMpljbqtdCxtykWgduEVJ+5FbRnRli7W/8Mw7YyoQ5yLt6QvyzB5enHFtnZ4ToxByDX6URAmtEoTtPCpPr0QyciZO6D4kLTZro0LOPGviyy4CxEBfo3PqSdCCk9iVcVZq/5QuGwMn9VhyxiBTOEGuMaR4HpJjlH0EfFQAkJ4FFO1g4aSEjBj9qd2eLiLkcgaUX56+EQliE6tS9Ru1DnpnQTrnwyUldnnRzEnziAL0q9alWWVmW0G6IL086WOwqcqrv/rjBD52oPQ5dT2EAgkm96C5kiavXXETl5dbeTOTsWLqBnXpcSh8qh5rZ6eVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA7sjT9fJErMebj7moq3kRYQFwct4WgI0TLKfnPhW1M=;
 b=LsGWCvXE9kE0UohEE4FLCbyc6S3coU3EsqnqJ71zVLF9hTCn3w6LALVqe4CkfFWbawHxD8nSXpmbmk7FBOCCV4oIG8wbP23GG+KSfZZ2iymzObz1oJYDeV/AyPaVmavOweBj9Gjw+Q+3K2B5EN5sPO66OeIvQdlui/8GNkPBhfI3XKOVFkmPiL41KmOz5wYsOenkGfM/oKKowf7YmBBSupoItMr6ZneGriZo/MSdawIT3u03DJClsciaMDeEcgaKJbHjSdRREu2g57EWM9TPYRyUUxagqB5GwsTle5sEspoPKomDkD0Y151yr4Lw2EnuccYK2XEyxr3JoH1t95IcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA7sjT9fJErMebj7moq3kRYQFwct4WgI0TLKfnPhW1M=;
 b=Tr/qXhSP6ilmQnhymgv5ZkU1NMJ53IMfpkndgfV4ms/4XQHlhAAurb0lNGz6gCMy5/01fpsbtknfeUIcJEivTKnOAE8Zo4/TxuOiAYPGrGwIAyLmM6GrMxm99qEs1lcR9O8efsM7uI9LJ5AGPCIVLNw1KouSYManzU9WVOH4ilI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:14:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 14:14:19 +0000
Message-ID: <3cac3a26-e947-493c-ae33-0adf6032fdba@amd.com>
Date: Mon, 30 Mar 2026 16:14:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: make userq fence_drv drop explicit in
 queue destroy
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260327103621.3374979-1-Prike.Liang@amd.com>
 <20260327103621.3374979-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260327103621.3374979-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:208:32e::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 21037971-c3d7-4afd-b3fa-08de8e66a223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: y+I0MoFfAoANNSMzMI2RsTKC4Y7iOPPNOjCUnh2QkS+4ngjwBGWi4qs+Ln6toRmwyczD+9ZAleq4fohSb522FwMXrIUQSgFt04/rhe3zvOsw1v+RIfJIb/mhD1nv2FtJXAnRURSa3ksG7nNgBGNBRz3i3q+yChn4eYOIzkTUm1bp+5LarDU/yXPYNz6+OytXqFJJWpV+V4OYHGHoboAmIdnT8Vg5C5sQ+vGn2mPEFXucgY8p40V7fuzgdjWl0aPkfCYOpAdgMt8z28chsv7X/7a0JtA3gUSJ0wrFY+l0AziS+idNiURC+3awRxp0vjvWhiatCibeP9PoJEWoQ49bFD7UkK54jRkLDcFShT2tFXkocxjCATlpd8Ze9LnSCDll9ITX/aYRZQJ/Dsw9WnByfqEuF9ILUdSf9QFpJCyamZV3afBWN1C1pq6PupV8fKvLpSiRIyIkehApBo3MHZSYxRVITxWRDdTXlAxnKfBofbg6HdqberarrkqcKjy9zWTbu6Au6seu8VqXry/Nr4MjySsbALyXSwIztVgXDoLleZgYC5VGJvzCuLWcycJq4wpDtcCJTjlUSUUmzcUyur6dqOeIKbVrJN1hb2CGb8VdPBRIpaZohHG84vpFhqiZaoXwiDRTsE5Q7btFxYoOnhcIhPCEPznD10tM5YvKlAu0/OmYBw33qPkjtP9nRu1YxTe30yskdYn125S/aQ9XeQJcBBR2a7cFGdCSn8rDzdd82Zc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGJNcTBFUTBiZThwQkNpVTg2V2llblk4Rzl6WER2dURWUExzdXJIM25abXNj?=
 =?utf-8?B?VjN2VlV5MzU2dUt4NG0rSDlXNXJKdDdaa1VjM04zMHY2cGw3VjZUaW9hcGp6?=
 =?utf-8?B?SFdyeENVeWpmVzdOS2RzdHZwRUU0WDBQM3hNUloyQzlZVGVONzJCMWZEU2hI?=
 =?utf-8?B?azY4dmRPUE5POFVOeGFlMjI4U295WUhCTld1b2NCMHc4QkZmemNVb1FhbG5H?=
 =?utf-8?B?VnN5eWo2WjRlNzh1ai84bzQ3NGcyWTNVajBuZE1YL2srb2E3RUVaam93cDFn?=
 =?utf-8?B?QVlLNUE1MjFRdnZuMkQzb1dyN2VhenN4VGwyVnorUXRTODh6WUN3ckhkbitx?=
 =?utf-8?B?N0ljSGJmMFk1RTYwcnNyOXdGMy9TaTRPSEhpZFM3bXJsY2c5VFVLTWVmUStM?=
 =?utf-8?B?NG0vTVFqZTN2dXhmb1BzTk9PKzRYTEc3bmg1a0psQzArWk93WVIvUStoVXRp?=
 =?utf-8?B?bW00R3MwM2hZaHpNZmcrcmc5VW5ORE1zcmxnVmRMQVd4eGxvOVo2MnkweGI4?=
 =?utf-8?B?d2hudjJoWlJtd2hCems1K2J2bE42T2kzSitPWGJxUjE3QTlCTk9zZHpzWkxk?=
 =?utf-8?B?S0pBMjhQY08ycjViOENDdnYwN21EdURqYXd4MytqWXJLRkVtMjRUYndXTmsr?=
 =?utf-8?B?NGdvMUlIK1lTaFo5QTk3TkNJTTNTdTBMTUNvbVpWd1ZnSGhFZloyTmh2NHVk?=
 =?utf-8?B?ci9DUU13SVJrZnRnVHc2WHlkaGdXRllKZmhaNmNQRUdKYWhQblpiT1Fqc1lH?=
 =?utf-8?B?dHV4bjRhcUFmODdwejBzUFMxVGUyQWxDVE45OEVIVkhhOFJQL3pweFdYOTMw?=
 =?utf-8?B?djQ0MHZkT0w0Z3B0TkR4TjNOb0xTeG5BeGZGT29mTzM3QTNTbTB4RW5mdFpP?=
 =?utf-8?B?VWlaMFBnNlRlMkJnaCtpelB0b2dTWjJWdkgxZkJBOHdZZmNMak8yK2lJZ0dn?=
 =?utf-8?B?SFl2M0ZxcTdOdEg1L3hKd0ZjSUoyNTZrM0ZkYXRuTlJzeWZsUDhlWisxZW9n?=
 =?utf-8?B?TjNWU3YvVVBLdnBuK0kzNXFBdFVRSERlWGNySjdicHBVdDZQRVpNSC80NEo2?=
 =?utf-8?B?M2U1a1ZBQktzeE43VEwzYzhubEFzaGprR29GaktMSk5sQVU4UnJEbVArMTV0?=
 =?utf-8?B?TDdDODVpRGRSMmo5OEw1L0tIMk1wUGpJNGh4dHlEaVd4UzAyL2QxVDUwRHVJ?=
 =?utf-8?B?NFg4aGZlRjVXYWlKWkhaME9iWDJlUVM1Y2x3K2N6YlU5YVBCYkw2VzZaMWJ5?=
 =?utf-8?B?dDl3QWVhS3RoaUtEazRrczZwNG1zcXpjcWRRbnlETENvL0pjL1BMNXlHeW5S?=
 =?utf-8?B?VWhVRnhCckNJdVR5SXd2UUw0WkFkYmR5UFMxT25VVWZMYXlmZytMS3YrK1E1?=
 =?utf-8?B?YXZGTzFKUUIrVlZFRTE4WVRhUzA3ZHc4MzUxYXR2eThSTFY0N0NBTDlDZnJZ?=
 =?utf-8?B?SUp6TjlsS2dQK1R3amF1NjErNzJ2c2c1WGVCbUVabHhJa3l0eXJqclk1Qnkz?=
 =?utf-8?B?aUkvU1B1RXZ6RDNxT2Z4ZDYwL05HNmNwczlCa3o1NFhjZlFlSlhlcHFSVEg3?=
 =?utf-8?B?cnF2RW95Z3lmQ2h5dU1nOHJseDM3bENGUU9lVTVkOEQ2cFBhTXc2Rm9iUEV6?=
 =?utf-8?B?Vm4vMFRsbVJnUkF3ZTdBYmZZaTNSRHVxbGtaSDYweTFiZUlkL1VyWGRSeGxm?=
 =?utf-8?B?K1J5bGVOV0l0aHZURVN3VTZPU3BlYWQ1S1FCZTFGMjdWVWxqSUo1dFZhbGdO?=
 =?utf-8?B?SDZBVmtQaDFRWHJ0amJMMmhIejFqQjlVT1BkL3FDYUg1bUZ0N3dob2NrMG9O?=
 =?utf-8?B?d0pOVHpjd2FVSEdmemNuMVo0MTZBQjhHNWpBVWx5OWJxRTdUT0xOOEN2UFhi?=
 =?utf-8?B?TnJnRDRMMlpRems3ZkorNDV5elIyQzg1bTNCQTdJd3lpbFpUUmZ3RTFlS3dW?=
 =?utf-8?B?TmdJeWxQNG51WXMrUjV4S280S20vMjg4QmFoOG9Mdys2SVZUWHB3THlCRzcz?=
 =?utf-8?B?Z1psajh4WmdVaWFrdE5tUm05akE1OElBeUk0cjdQVW9oQTd4S1pFSDl6VkJ5?=
 =?utf-8?B?aEZNdUJ4ZzA4OUpZcStSamF5c3p1UkFGWmd2QkNHNUdibVBPSEJTeFhWeGlP?=
 =?utf-8?B?SmxVUS9BVFZ2cEJ5TnZzOSsxbERsTEJKL08rQWdMQ21GSWV2eFV2cDN2WHpV?=
 =?utf-8?B?eDJpMDhUci9IdXZlTU5kVlJvZi9aWjlPOTdCQ0Z2alhHQklYU0tDZTBhZFRv?=
 =?utf-8?B?VmJZKzh6VUJuMTA3T1RqZ003MFdSMXhVRnN1cHRwNnJ5Q1R2Q0JoaHpJL21p?=
 =?utf-8?Q?/TGu4waS2R1MyYvGZb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21037971-c3d7-4afd-b3fa-08de8e66a223
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:14:19.3375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WY5/kmecyDaX8JE79pyOmG6C0+BQroeSt4gmB8EdxFd5byFHE1GfdKoH7JizUYAb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815
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



On 3/27/26 11:36, Prike Liang wrote:
> amdgpu_userq_fence_driver_free() is now responsible only for releasing
> per-queue ancillary state (last_fence, fence_drv_xa) and no longer
> touches the ownership reference, making each function's contract clear.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 3 ---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index c4841df80bf8..d676f2709a0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -459,6 +459,9 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>  	uq_funcs->mqd_destroy(queue);
>  	amdgpu_userq_fence_driver_free(queue);
> +	/* Drop the queue's ownership reference to fence_drv explicitly */
> +	amdgpu_userq_fence_driver_put(queue->fence_drv);
> +	queue->fence_drv = NULL;
>  	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);

The xa_erase_irq() call must come first and then dropping the fence_drv reference.

>  	queue->userq_mgr = NULL;
> @@ -866,6 +869,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	up_read(&adev->reset_domain->sem);
>  clean_fence_driver:
>  	amdgpu_userq_fence_driver_free(queue);
> +	/* Pair with kref_init in amdgpu_userq_fence_driver_alloc */

It would be much cleaner if we would modify amdgpu_userq_fence_driver_alloc() to get struct amdgpu_userq_fence_driver **out as parameter and then call it like this:

ret = amdgpu_userq_fence_driver_alloc(adev, &userq->fence_drv);

This would make it absolutely clear what happens here and why we have to drop the queue->fence_drv reference in case of an error.

> +	amdgpu_userq_fence_driver_put(queue->fence_drv);
>  free_queue:
>  	kfree(queue);
>  unlock:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 87560c1251d8..a392ef9ba5aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -134,11 +134,8 @@ void
>  amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>  {
>  	dma_fence_put(userq->last_fence);
> -
>  	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
>  	xa_destroy(&userq->fence_drv_xa);
> -	/* Drop the fence_drv reference held by user queue */
> -	amdgpu_userq_fence_driver_put(userq->fence_drv);

I would keep that inside here, it already looks like the right place to have it.

We just need to make sure that amdgpu_userq_fence_driver_free() is called *after* xa_erase_irq().

Regards,
Christian.

>  }
>  
>  void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)

