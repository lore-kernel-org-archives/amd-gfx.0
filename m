Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435E9CD5BD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 11:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE8F510E7A8;
	Wed, 27 May 2026 11:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="45PY0sbG";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DE1E10E79D
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 11:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzxhVD0EGlmEBwVtnfM9q7Y07At7QAjWNSlzGuEK9d8N43r4OI0KoPHSmRhy/zG3DMqvwlhXaqVWev4ZQ8CjGQnyiDS3n4LbLPuySOA2GvAulbAQfj44R6BNm8Uhy1/000Hh7fQEgfPTstn1kHNEJT/RtrNLCdsQGd31ay6y5i9w/w68b513lRqQ3S54OfX/U/7mnwbJX/gNzdQP1VyDiZikykZSuW3ppzjBuOepMccd/OdbHwKQYM69c26kIqRigxxIkiiQsM6inD4b5F8ai4vCOSojBTggNTWcA/UR6SeC+slvI7JqdX3elVSZlIGEHoa3gSALcf+4/yOfaAsLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvnZjk9VJ5OveuEAZ7LCfLzIVsQ9IfB+RkpJv1erMQs=;
 b=rGpUr/RwM/zBVleAy9Yc4jPJjV7HAbDsLawM7mCYxRaf1Q+i92M8Jgg2D+SeYhCV7kQ8LCE1U27df7vK5pb7jSdLlaTcO5bJZ5y47pxDL6CiLbKX/xi4nx3yqHbCv9PyAbhzphRm52b8nR+7rXLWDXLB0oqmdhZwyoGwBOMr/157GoYVHorQpr0pqcnz67qrU2xXyrXfzC7kzH7A/mPF8TdPkLwdIUoKmnnZ6UDpsBuXdfUTOXMobcgZE9qALxuC8C9NsO7UiFSuCQPxdcApg7qePzdW/09qz9u/MiyW1Jpgr/p0CfyUkKbvY6OUnLuICD9munXceWr/sxb5/EfMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvnZjk9VJ5OveuEAZ7LCfLzIVsQ9IfB+RkpJv1erMQs=;
 b=45PY0sbGdt1tM7hxDzU3vXoaH9Ul1DvgOJfqzFxxHQL16+Uu9E+MY2ONhkgkrADM+/PLOBH9plAlySzKJmYt8IFc5g3NglGxj2MQoGuULL4tKf+ZwXWoIbDHphKRXu9lw6WSepLA2s2olL40mhSjeDNmDl1rPv3JOTj0oBSq2Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8790.namprd12.prod.outlook.com (2603:10b6:806:34b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 27 May
 2026 11:46:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 11:46:41 +0000
Message-ID: <546f4e04-e45e-4678-b71d-a63a4d223cc2@amd.com>
Date: Wed, 27 May 2026 13:46:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] drm/amdgpu: Add driver managed buffer copy
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260526160630.35562-1-tvrtko.ursulin@igalia.com>
 <20260526160630.35562-6-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260526160630.35562-6-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a34781-1973-4e5c-e551-08debbe59e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006|3023799007|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 1g+1mYdA8iHrlu6PbsnwhOh3tZlBX/0AAd/TdSWaEjde6sX5h666y2IFlW3Az5jjdKmndIHl/ak/i9SoNziwkrKmN0yprfeqAd4xt/66axRHtPk3n0TYLselS60hoVwrh0M5qlZeFKRikh36+0lMM8d+y54L42uy70vssscjJxjAMyPyCjgG2sfUCQQM2aXeKBTyTmfmt3gwNdLweKTGKiG0mb1HAg5yxHHAs3qHdnCHK5yiSoruU8SBKBLTaz8E+dfy8qJWnuF5I88YrX5QR5LlmOs6x/AwAb2yN2UtR9eDka6EhOK/94juRTG+ehWkKmBIKG+bUoEBddNiwqdi0ITZpwH1u96KS9AXxsm6+38hg9hyKYxJxwEaLIQeClM2+e3D1J1yLySGdEKQoJ7EuowIuFhOje8i1/jLN2DsrOZPGpC37v6+Ee1FbyqlS1D8XXyQbYHlSrYo8dG7VZ0h0M4PTdAUq80lkhrlVLLOMWCm/lGgDlVJ4ZzlVMjLrpF8QmMnasOxUclj9dkU+vwvxjr4jnN23Jt3CM30U7mTSb1xH5UPOsh/1v7IxkxDeZshPtK5qeFpW/D77IwBCORGK3UjtQodE9PXtKm+PH2j1i4yJ8jGizEjc7KqosxUbVfRyFHgoat5Nk5y+4rIBXwC9aoWLLqrxQIwx/zy7Cl6gnX4+4dSOwtoS5jU4Y8G5LKA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE5vS21weE9VS0kwdEU5akQyem5sK1RkOXRYSWo0TzBzSlVuOE1GNkkreEpK?=
 =?utf-8?B?TGk4VHlLcUs4WXZHbk0zUFZvM1JHT2h1dUpXNGdxSHIvOGtLVDM2MmEyQXo1?=
 =?utf-8?B?MExucndtRm4xWExFSXMzelZwVEdlSUZuQ25aRkRaS0VXK3d4QTBnNDFnSHc5?=
 =?utf-8?B?L3piZmNsUStYK3JScit5NGJNL243NG9UQlRscWtuNDdOWWx2cWVaSFZQR2Ja?=
 =?utf-8?B?eGY1MFdGdG5kVEFNaXNSanlNQ1J0QkJ5YUtTdGgrYklGTS9iZGFNdHd6WkxO?=
 =?utf-8?B?QTdLeXNaSWlhNEZzWXlVVFBXMHg2V1FQazNnem9BcDZRWTFWek9UVlMzUW1j?=
 =?utf-8?B?Rk84Sm1DZEhhMFhNdTRaZkYwbEVwMnlyNThKS3NHZlJCMTFWbXB6dElhc3hF?=
 =?utf-8?B?enl3b09LNnlXRG5QTE82TzBkeDBHVVBLUEx2TW1oUHVlcDBCZ3RQQU12YTBI?=
 =?utf-8?B?bWtuUFNiRFh0Z3NqUDRMR1lXME01QjVpNEp1M0tQY2JJVllWSU95bWRmZkJO?=
 =?utf-8?B?Z1d5UDhUWVNOUmdVazNrZWFpaWg0bHc2QUU4VEpqUU5MaDQvSmprWkNDbitX?=
 =?utf-8?B?OUpOdGwrSXBkdHl3R2cwaDEyVVpxNm9IanN0UWFuU1FESllhbm1uSEJWelFa?=
 =?utf-8?B?c0tJOWRZV3MyMkZkTVRlZjRRWmVwSDFMSXRDWStEaTdxWFM0aGliY3FaVkdI?=
 =?utf-8?B?UmZHZ2hPTVFKb241NW4vTWJMcklUUk9xd3JjWnpKL0VQRTczS0ZHM3gvVGdu?=
 =?utf-8?B?bnBVdEVyOW1CYkY0YjZoY0FkMy95QlRzaUdVL0pBSUFRS3F2ckZWb3BpeGQy?=
 =?utf-8?B?Y0J2Mjd3cXgzZHF5QXFRR3NYNis2YzQ3MmM0NncyWm9EaHdveHY3NnBIcnhi?=
 =?utf-8?B?dDFGYnpoTk5PZ3hSQWFWZmhvbmhBQzJMUUd4QVUydlVSNkxWZWU4MW5FbG5H?=
 =?utf-8?B?czR3OUN2S1JmeS83c0U2OGJBZDNwNmkxMEpCVmdYaGs3STF1NTVaaG1WNlE3?=
 =?utf-8?B?a2tSU1VVcmxtVGJ5dGNNUHJnNmdRaHRsRWV1eXU1K2JhSGZhK1RsWjR0dHhv?=
 =?utf-8?B?QVlXcjR5MDU5dDMrQjRlemlmMnNUM2RUWC9mKzk2WTZRMzdSYjlJYVE3ZU1m?=
 =?utf-8?B?akx0NGdBS25LTUhGVFUxcmQwK3pwZTJlVVZGQ0xzSTNDZFpBZ0V3NDZtUW83?=
 =?utf-8?B?WGIzQWVMZHlXWXBRN3JJUWZtdDVJTHZMUnR0bEw2NlFPeE1LMGk5M3QzanlY?=
 =?utf-8?B?ZmYwQUlldVZUUUdrR245VXZqK2tRTkNMdWRTdHpIc0d5czFZSDVoaC9vTHFm?=
 =?utf-8?B?NUpjZ3cvaDAyc2czV1BoN1JUVjFLdkdhM1Y5SlFVTnVUMDBFRS85ekp2VUZs?=
 =?utf-8?B?VUNYNDJUU3h6b2s0RnVHUXNacURSem4rcGhGS20zeG1rTG12Nlg0VDlSMU1U?=
 =?utf-8?B?YVlZWHNhSkFTY2U0OTkxZDlHOU9ISEQzU3oyd3U0LzBUMVlNUHkwblJRR3Bu?=
 =?utf-8?B?cmNGTW1ZMUVjNnhzSnI1azhjd3AxU3BLK3FwRHZPaFdLdUlQQmE5emJXZnM5?=
 =?utf-8?B?MjRJbGk0bUUvaG11QVJDekxrN3p0TXN4dGJKR3pRNFhaZmw0Ni9ZSkNVT1M0?=
 =?utf-8?B?VzNadXA3S09YSlA5WjgrYlhUTURTdGh2RVA2ekNZR1UxMzRpV3B2NXJIbkx2?=
 =?utf-8?B?NGxCWHVHMHFDMGVEbDRYbkhMS2YzZzFBT2c0NHdxdlFZWnpoRVV2ek1OR0dR?=
 =?utf-8?B?NFQ0N0xqbDlkZE1JbVNReFp4dWNSTm14Y2R1Q0Zwc3l3N3lmK2pSV3lNbWxP?=
 =?utf-8?B?TGM4bmsrbG1RTnBleHJzd1hsNlVLQ3V0cVJEN2QvL0J4WSttaFFUdGtRUVdC?=
 =?utf-8?B?YjdxWEtac2UrUzhMR25NTytZanFIdFJYUlczV0NTeTc2Yk9BclB1ZlE4N2px?=
 =?utf-8?B?aEdoVkJDeGtONU9iVFpqRHNkQjdJTnVTMjBkN25aemkzVTA0aWlidnE1aCtP?=
 =?utf-8?B?VXhGb1Y2eWNKUHRkYlRtVlhxelJaYkZTbHJTTEJEVERzdnhlM2VmRVRCRURR?=
 =?utf-8?B?dHJiOTF0NVZMSkVGTFg0OExRNCtYdW54ZXg0bzgzeWlOSVIzc0tlR2tmaVhG?=
 =?utf-8?B?RDNmcmRwdVd4WExtZ0tjN010RGdIVi9qWFMwOW9VaFZza29UcWt2VlNEcjAw?=
 =?utf-8?B?VGdmNWxVUU8xak0zZ1FaU2x4aHA1aWJjQWZaTEhmN2l0UXB2Wlg5VGZGNVlX?=
 =?utf-8?B?cFZESjYwMm1xamhsd2dqVm9GcmFDRUFPZEtGZCtaSUM3eVJTMi9VS2VGOHFZ?=
 =?utf-8?Q?LDJGEaxFv76eWEKDfO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a34781-1973-4e5c-e551-08debbe59e5d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 11:46:41.3737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6B2BHmMgHKDySfXWDLx+9Whk012wfdxqfsroz29jpexEo6gl5lWxay73FUjl5BK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8790
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

On 5/26/26 18:06, Tvrtko Ursulin wrote:
> Saving and restoring buffer object content poses a challenge for the
> checkpoint and restore process for at least two reasons.
> 
> For example not all objects can be exported as dma-buf to enable copying
> from a separate client context, neither can any objects be easily copied
> from the same context since the injected CRIU code is unaware of the GPU
> virtual memory free and allocated ranges.
> 
> Lets bypass both problems by simply exposing access to the alrady present
> fast kernel copy via a new DRM_IOCTL_AMDGPU_GEM_COPY_BUFFER ioctl.

Oh nice, that was on the TODO list for KFD integration as well.

> By giving the kernel simply the source and destination handles it is able
> to copy them without the need for objects to be mapped, or shared with a
> separate client.
> 
> For now this is implemented fully synchronous but can easily be extended
> for more parallelsim.

Looks reasonable of hand but I would rather like to have an output DMA-fence (drm_syncobj) instead of the dma_fence_wait().

Regards,
Christian.

> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 102 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  14 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |   7 ++
>  include/uapi/drm/amdgpu_drm.h           |   8 ++
>  6 files changed, 127 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2b971de3c189..b927e3a3089e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3066,6 +3066,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_CONTEXTS, amdgpu_gem_list_contexts_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_COPY_BUFFER, amdgpu_gem_copy_buffer_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 5eb8433229b4..4e0440cd6ee2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1216,6 +1216,108 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>  	return ret;
>  }
>  
> +/**
> + * amdgpu_gem_copy_buffer_ioctl - copy buffer object content
> + *
> + * @dev: drm device pointer
> + * @data: drm_amdgpu_gem_copy_buffer
> + * @filp: drm file pointer
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +int amdgpu_gem_copy_buffer_ioctl(struct drm_device *dev, void *data,
> +				 struct drm_file *filp)
> +{
> +	struct amdgpu_copy_mem src_mem = {}, dst_mem = {};
> +	struct drm_amdgpu_gem_copy_buffer *args = data;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct drm_gem_object *src_gobj, *dst_gobj;
> +	struct amdgpu_bo *src_bo, *dst_bo;
> +	struct dma_fence *fence = NULL;
> +	struct drm_exec exec;
> +	unsigned int e;
> +	long timeout;
> +	int r;
> +
> +	if (args->flags)
> +		return -EINVAL;
> +
> +	src_gobj = drm_gem_object_lookup(filp, args->src_handle);
> +	if (!src_gobj)
> +		return -ENOENT;
> +
> +	dst_gobj = drm_gem_object_lookup(filp, args->dst_handle);
> +	if (!dst_gobj) {
> +		r = -ENOENT;
> +		goto err_dst;
> +	}
> +
> +	src_bo = gem_to_amdgpu_bo(src_gobj);
> +	dst_bo = gem_to_amdgpu_bo(dst_gobj);
> +
> +	if (amdgpu_bo_size(src_bo) < amdgpu_bo_size(dst_bo)) {
> +		r = -E2BIG;
> +		goto err_sizes;
> +	}
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_obj(&exec, &src_bo->tbo.base, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto err_unlock;
> +
> +		r = drm_exec_prepare_obj(&exec, &dst_bo->tbo.base, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto err_unlock;
> +	}
> +
> +	src_mem.bo = &src_bo->tbo;
> +	src_mem.mem = src_bo->tbo.resource;
> +	dst_mem.bo = &dst_bo->tbo;
> +	dst_mem.mem = dst_bo->tbo.resource;
> +	e = atomic_inc_return(&adev->mman.next_move_entity) %
> +			      adev->mman.num_move_entities;
> +	r = amdgpu_ttm_copy_mem_to_mem(adev, &adev->mman.move_entities[e],
> +				       &src_mem, &dst_mem,
> +				       amdgpu_bo_size(src_bo),
> +				       amdgpu_bo_encrypted(src_bo),
> +				       dst_bo->tbo.base.resv, &fence);
> +	if (r) {
> +		goto err_unlock;
> +	} else if (!fence) {
> +		r = -ENXIO;
> +		goto err_unlock;
> +	}
> +
> +	dma_resv_add_fence(src_bo->tbo.base.resv, fence, DMA_RESV_USAGE_READ);
> +	dma_resv_add_fence(dst_bo->tbo.base.resv, fence, DMA_RESV_USAGE_WRITE);
> +	dma_fence_put(fence);
> +	drm_exec_fini(&exec);
> +
> +	timeout = dma_resv_wait_timeout(dst_bo->tbo.base.resv,
> +					DMA_RESV_USAGE_WRITE, true,
> +					MAX_SCHEDULE_TIMEOUT);
> +	if (timeout < 0)
> +		return timeout;
> +	else if (timeout == 0)
> +		return -ETIME;
> +	else
> +		goto out_put;
> +
> +err_unlock:
> +	drm_exec_fini(&exec);
> +out_put:
> +err_sizes:
> +	drm_gem_object_put(dst_gobj);
> +err_dst:
> +	drm_gem_object_put(src_gobj);
> +	return r;
> +}
> +
>  static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
>  				  int width,
>  				  int cpp,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index 0e17d9fc665f..64529680fdad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -71,6 +71,8 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>  				  struct drm_file *filp);
>  int amdgpu_gem_list_contexts_ioctl(struct drm_device *dev, void *data,
>  				   struct drm_file *filp);
> +int amdgpu_gem_copy_buffer_ioctl(struct drm_device *dev, void *data,
> +				 struct drm_file *filp);
>  
>  int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *filp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4023c84fe29d..3baad073ed54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -294,13 +294,13 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
>   *
>   */
>  __attribute__((nonnull))
> -static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
> -				      struct amdgpu_ttm_buffer_entity *entity,
> -				      const struct amdgpu_copy_mem *src,
> -				      const struct amdgpu_copy_mem *dst,
> -				      uint64_t size, bool tmz,
> -				      struct dma_resv *resv,
> -				      struct dma_fence **f)
> +int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
> +			       struct amdgpu_ttm_buffer_entity *entity,
> +			       const struct amdgpu_copy_mem *src,
> +			       const struct amdgpu_copy_mem *dst,
> +			       uint64_t size, bool tmz,
> +			       struct dma_resv *resv,
> +			       struct dma_fence **f)
>  {
>  	struct amdgpu_res_cursor src_mm, dst_mm;
>  	struct dma_fence *fence = NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 8c0424577dea..360a860b8280 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -286,4 +286,11 @@ void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
>  				    enum dma_data_direction dir,
>  				    struct sg_table *sgt);
>  
> +int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
> +			       struct amdgpu_ttm_buffer_entity *entity,
> +			       const struct amdgpu_copy_mem *src,
> +			       const struct amdgpu_copy_mem *dst,
> +			       uint64_t size, bool tmz,
> +			       struct dma_resv *resv,
> +			       struct dma_fence **f);
>  #endif
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index d2a7b4e9daed..1335a181eb39 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -59,6 +59,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ_WAIT		0x18
>  #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>  #define DRM_AMDGPU_GEM_LIST_CONTEXTS	0x20
> +#define DRM_AMDGPU_GEM_COPY_BUFFER	0x21
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -81,6 +82,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_CONTEXTS, struct drm_amdgpu_gem_list_contexts)
> +#define DRM_IOCTL_AMDGPU_GEM_COPY_BUFFER DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_COPY_BUFFER, struct drm_amdgpu_gem_copy_buffer)
>  
>  /**
>   * DOC: memory domains
> @@ -206,6 +208,12 @@ union drm_amdgpu_gem_create {
>  	struct drm_amdgpu_gem_create_out	out;
>  };
>  
> +struct drm_amdgpu_gem_copy_buffer {
> +	__u32	src_handle;
> +	__u32	dst_handle;
> +	__u64	flags;
> +};
> +
>  /** Opcode to create new residency list.  */
>  #define AMDGPU_BO_LIST_OP_CREATE	0
>  /** Opcode to destroy previously created residency list */

