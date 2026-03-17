Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251BEF33806
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 07:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F4310E349;
	Tue, 17 Mar 2026 07:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DXI8rBBl";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56D2F10E349
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 07:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIlrKJwj9aSEZFF5LdR8Bsv4KoVP+blcwQ0vRCDP9mq30S59Hk4J5NI/s3uvMaep8VA4cdohRr6XIad5TnkbrBznt/x1DWyR6il6jqmbRc/3zahPdvngjR4TRjNkuAhyiWt725UugD1TbZGQ0SETUFruX2NK4uSBVVlxMKHouiQB3xZzZKUtmJNd1yAlfY4NhOnE288/2sHVaYigUe+YYWbM6ilXdbNoP8BDzoi17T0l7t66v+OtlaL0G3/yLSqDtvFdLm/2NsT4a/PkJQLxMDTQ9T3MPNradCcgGRLMUdYktDvaQFejL1lOi/sPcjikWWS85PhxASBOcS90WeOMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMytHw6b/GkAEDttrxlnlx5jsDC9xMotNEx5zzUWa2A=;
 b=Ml9ch+FL0nV5HAOMRaLoSBFONqUCI259qJXtr4poSqT1ZylKTYdn2qVAFWQ48itltvLN9Z72z8sh+vLfOojcT356yxSyRhqVAPWRbGOhwuNuAMgczQcYcG6/2NQXfWuyCb0XJeIG+XgV3QwNRcAlkrr0id3n3aKbWssCYBMzYtpsSg5S0slhDXla8+Nvjk+eMunK5gQxRfXN7vO5vh+DMJYAyurpQXxqS4FNAMs0eCIXPvCSjJEkgfIdwibkkCUlXgH0e4BhT5zib3Z8r3mMxNexE19F9SeUm+6tSGose+kSGQJP6rjeW9m3f5BwqsIQFXLfn3xSedgyA5iZgE6eTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMytHw6b/GkAEDttrxlnlx5jsDC9xMotNEx5zzUWa2A=;
 b=DXI8rBBlvIACip/lFDS4tZRv1oNnOKc4ZdqtKlCLA3GobyseyxCO7jbwKKWuYV1PKc8iRtyZmmETMfY6YNvHAW23i4BrLp6dX6Wrzw2GGc2E3vf2HusmmL0KEz/degV/Owb7i2/p844KXCPpVeWTQA4vFDO7FqIqYKa770vr7CQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 07:05:12 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 07:05:12 +0000
Message-ID: <549e1e32-ef7d-45c1-90d0-a087fd029755@amd.com>
Date: Tue, 17 Mar 2026 12:35:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] drm/amdgpu: rework amdgpu_userq_wait_ioctl v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-7-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260310191327.2279-7-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::20) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 30edb6ad-dbcf-4d3e-195b-08de83f3885b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: t/d0jK36Zd8VGNk1Qaar+yFH/LxxFfw4b11687xbI/xbOezUCD+YA6rIaHQpJ/oUzfH5N7xyaAWazVk2sP7sdVNJGDT7xY7/EqCOMIHEdgi1a9i3CmCm3rWfjktshyaE+VyoLUQFB871Rwv9KrbGb0r4f8YyEifhagI/JU+eIr80FSxbaROeCgmBgUPI0HxJT6mm88rda81WW2HKPhwkTlQWFQwfvQh9wxTk4HfCP94PAajpDGFsX+TxLCngQV+WD3sPhW+VkXynRI4TIW45JRiHyKG2UoEMDsWVMveNxUKKttXR2S78fzL7PK8aSJ14i07XdsuZAhfy0bmDVJ8nrNHayBPLoRqJI6HJgkp3NpxA0+9zjQz2tCM9ImOP1UUwAKuSPIxVjjc9C1lL83pRZIzfkJVHgWGhqB1yOzt5vEBbHOmpOB0qAFsF0wLfb9OnxcyTnXjsX8+9ckVbyZ4C0sqvA7gCL7vkR8Qliluh+ASC/ww3qcqa/WsFY3QS7lMwZy/aCycUlt2sSTB0Zvs0iUCm7kxQLdy0l9ZbQtLTzcLfmPRErtQIvGYOz9UO26/lqWiD6jPnj0OsQiR8UjV6TFRvGhSRs8RyiL+wZtDxnDpnrruSwTg7/dye0ouq/0NYiuD+3mi2iH33sLFR6iYu6XvhMws+4yC+Qd64GEKQ7q3aWrGiFoDTRn3oPq9WkKjYKdMmycapf21e3bl8ipgK01cIdDADZSh6n9I7fC9cTeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFDQnVYQ2xqQnBXMThvTGhXdVB1RHpacDd3L1J5M3VRejlzVGJaSG43bXNN?=
 =?utf-8?B?c3p3MkFHQU5ZL0k0cmxMV2k2Z2s2QTZXWDlpWjJockJBeGRTRmhEeEhKK2xq?=
 =?utf-8?B?U282SEpicFFmTEJXSnFxWE10VzkzOGpNOWZ0aWtELzZtQkVOeGFOMnd1K0JE?=
 =?utf-8?B?NzgyOGl6OHh2eDRLRVAwSW92Ylp6RkNxbnhodnpHMmMzZXpzSG5UM0NWcEQ5?=
 =?utf-8?B?OERIL3lmY0dhODFKN2t0NjdxajlTT01sakhUVzgzbUF5NlA3ZVRKZHJ1ZEhL?=
 =?utf-8?B?M0haZ0dBdHNKSmRjSFpmN1QzN0NKNzdxa0RncVEwV09JMUJvMmhPRWQrN2o4?=
 =?utf-8?B?YXZ5eUR4c0hVR1hQb0lLS1RtSWhISTI3WmY1OWphbk0rZ2c4azIxa0w1M3Mw?=
 =?utf-8?B?UmRWTnRhOVNWSGJ5eEVJdmI4amQrVWJTbEV4YVgxMzArVU1kMXIwbWxyUXRq?=
 =?utf-8?B?YnM5c3h1MWQ2eC9WVjJlZnhpYURZWmpXeE5lcSswMG9aNkd1eVJ1RW82azN4?=
 =?utf-8?B?STRsUkw3QURYajFodFA0c2hhM0U5aVFSQnVmUzBYS3BMYTlYcHk5ZDNwMzZG?=
 =?utf-8?B?REdsS1QvWkZQa2o2a25OcFpsb0JSTVlmOUlaVWREdThFTzY2TUNSV242d2sx?=
 =?utf-8?B?cTN3TEwvZUZoRU1hTzgzSEhPc08yVVNkSEUrYVhiTFVnTXpSNmszSlQrTFd6?=
 =?utf-8?B?NURleVhyVHcreFNEZE14NmxvYzNIdkJyemxqYlc5UkdJOGJHRnNqTTRWdVI1?=
 =?utf-8?B?bHk3TVhyTWNqNEtIb0hyeW9aQ3pyREYrcXl4RzZwK2QxcFUxOFltUHM5d2Q3?=
 =?utf-8?B?bzUwNFJ5VnUrMEJnY016NWtKeHAyVHRsUnE5bmU5YUpPT0NOZHNrODNJODN5?=
 =?utf-8?B?NkZmRzJvS3dUR2lzZ2I3Tk02aUlZOEozS01DTHBocUdQVDI3V3lCWmovVzRi?=
 =?utf-8?B?bWpvY0xROFFxcWpVNHhUSWFTVlgyM0RWenF1YW50V1h5RHE5dTZXeFA4dkNK?=
 =?utf-8?B?dDRKRWhjS3hPMzBiNWQ3bHp1Q3p0ekZ1RlEwZCttY3dCR0FaR2RUS2NFUExP?=
 =?utf-8?B?VVVoeXZYVC9GQ0JlL1FGbnU4dnVvaHRJbDNZckVNTk1EeGxvVytmdjlCSmpv?=
 =?utf-8?B?UU9VZVJ6bUtKbU5wcFBxZWI0VDg1N1VYRXRBaVNFekU3cEJjNEJWRUVwQzhW?=
 =?utf-8?B?dWJjU0QwZnJGV0poU2F2L2tHV1YrLzY2azFwWFpKYytZbGJUT3ZUNDU5SGI4?=
 =?utf-8?B?TjZUVTZvOUNQK3FrdGRkUytJaXovVklZeGN1ZFA1Q0FwaGdRVG1ncGJJa2NQ?=
 =?utf-8?B?TVpETFRRU2lUZC85Q25MQk43c1FIQUFFNlF3Z1h1VU1KVXRNc0h2bTM5YzR2?=
 =?utf-8?B?TDVuemtJdE56RkZsNmZjc2tHNW14NWIzQnpKazFrYUNsajFhTjd0c1pTdy9v?=
 =?utf-8?B?aldFMFhnY0hTdjFSQi9ML3luWTBJMmFPbTBJQklQVmZsWTczZkJuT1ZtSkQ3?=
 =?utf-8?B?aWZpOFdXcjNGUU5YWXBCcXhzSGVKTU80UTBuNWhmSis1TUVPVGh3YzhSQ3FW?=
 =?utf-8?B?VmJDRkxncG5PRmRMUFZmYWh0bkVKbmg5K0FYSkMrQWNGQzZqWWpmbjVBMVps?=
 =?utf-8?B?K25zYnhGRGhudjc0YVM0TFFuUEQrVWJLeG1BS2ltUnB1MnViMXNGYWVZaXFk?=
 =?utf-8?B?QjlBS3ZJV2FNeVVhK1BwQ3pOQVF1V3JkNUxPZmZ1ZUtqNm1ZVjhXZjJwazR0?=
 =?utf-8?B?UlJia2lIWXhLOWx2K1NzRDc0VEo5WnJ6elJtWVJBTXEyVkhDNUtTaEFaczZl?=
 =?utf-8?B?ZWhIaVpOMkdOL09oUnpRa1l4VCtyUjhvazFJOFlLbVhkV2ZXazJoeG5wRFFo?=
 =?utf-8?B?M0NMMk1BTG1TWlNHbk0rTC93TWgvY3AxR2FWZUk1UkZLL2VQeEpkcU5rMUdQ?=
 =?utf-8?B?S3JZVnh6RnNTaHhmZW1yN3BSOWFiM1hSVWNKdWRSWGFpQWtFZXdYMHlyTU0v?=
 =?utf-8?B?eFRjOHFyQndGTjBTOVlKU1hmWUlUYndDSDdzajJmdGF6Uk9MWXU0SVc3LzJ0?=
 =?utf-8?B?TDBJa280SWdjTDhFSWdib2IzWThlMi9zZmhHQ0hHSGhDVmpGT0o4a1g3cU9u?=
 =?utf-8?B?NXNsQlF0aDZBMG1YRWxzeGZRK0RFYnZFc1pUWVV3N3I5K2o2b3BWK0U1ZjZN?=
 =?utf-8?B?K3FSZGQvLzA3d3BzTDB6YlR5a0VkRHNxOTBGVEFNYnRaeWRNc3ZSMHlCdzQy?=
 =?utf-8?B?ZHhMdlpleFRpTE5LUlk4UFhUazJ3blhTcUdYdnZXb0xoakVZT21HWGhkZjdp?=
 =?utf-8?B?RCtuMVlrZjBzTDZaYUNZN0Y3YjV2RFBUdWFqc2JQRnhpSXg3TlFCUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30edb6ad-dbcf-4d3e-195b-08de83f3885b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:05:12.4957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBbN2xO8vZCIeX8zdhI6VXE2gz9i6yCta0hnSatBItLY8DTK8MHe+S/KZlxGOTpuUQz18FCcaPDfN/65bfxLzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
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

Could rebase the patches as some of the changes i pushed have changed 
couple of lines and might get some conflicts.
With some of the points raised by Tvrtko the code looks cleaner to me 
and less locking.
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 11-03-2026 12:43 am, Christian König wrote:
> Lockdep was complaining about a number of issues here. Especially lock
> inversion between syncobj, dma_resv and copying things into userspace.
>
> Rework the functionality. Split it up into multiple functions,
> consistenly use memdup_array_user(), fix the lock inversions and a few
> more bugs in error handling.
>
> v2: drop the dma_fence leak fix, turned out that was actually correct,
>      just not well documented. Apply some more cleanup suggestion from
>      Tvrtko.
> v3: rebase on already done cleanups
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 591 ++++++++++--------
>   1 file changed, 325 insertions(+), 266 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 76f32fd768fb..14a289c782ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -617,339 +617,398 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> -int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> -			    struct drm_file *filp)
> +/* Count the number of expected fences so userspace can alloc a buffer */
> +static int
> +amdgpu_userq_wait_count_fences(struct drm_file *filp,
> +			       struct drm_amdgpu_userq_wait *wait_info,
> +			       u32 *syncobj_handles, u32 *timeline_points,
> +			       u32 *timeline_handles,
> +			       struct drm_gem_object **gobj_write,
> +			       struct drm_gem_object **gobj_read)
>   {
> -	struct drm_amdgpu_userq_wait *wait_info = data;
> -	const unsigned int num_write_bo_handles = wait_info->num_bo_write_handles;
> -	const unsigned int num_read_bo_handles = wait_info->num_bo_read_handles;
> -	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> -	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> -	struct drm_gem_object **gobj_write, **gobj_read;
> -	u32 *timeline_points, *timeline_handles;
> -	struct amdgpu_usermode_queue *waitq = NULL;
> -	u32 *syncobj_handles, num_syncobj;
> -	struct dma_fence **fences = NULL;
> -	u16 num_points, num_fences = 0;
> +	int num_read_bo_handles, num_write_bo_handles;
> +	struct dma_fence_unwrap iter;
> +	struct dma_fence *fence, *f;
> +	unsigned int num_fences = 0;
>   	struct drm_exec exec;
> -	int r, i, cnt;
> -
> -	if (!amdgpu_userq_enabled(dev))
> -		return -ENOTSUPP;
> -
> -	if (wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
> -	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
> -		return -EINVAL;
> -
> -	num_syncobj = wait_info->num_syncobj_handles;
> -	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
> -					    num_syncobj, sizeof(u32));
> -	if (IS_ERR(syncobj_handles))
> -		return PTR_ERR(syncobj_handles);
> -
> +	int i, r;
> +
> +	/*
> +	 * This needs to be outside of the lock provided by drm_exec for
> +	 * DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT to work correctly.
> +	 */
> +
> +	/* Count timeline fences */
> +	for (i = 0; i < wait_info->num_syncobj_timeline_handles; i++) {
> +		r = drm_syncobj_find_fence(filp, timeline_handles[i],
> +					   timeline_points[i],
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			return r;
> +
> +		dma_fence_unwrap_for_each(f, &iter, fence)
> +			num_fences++;
>   
> -	num_points = wait_info->num_syncobj_timeline_handles;
> -	timeline_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
> -					     num_points, sizeof(u32));
> -	if (IS_ERR(timeline_handles)) {
> -		r = PTR_ERR(timeline_handles);
> -		goto free_syncobj_handles;
> +		dma_fence_put(fence);
>   	}
>   
> -	timeline_points = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
> -					    num_points, sizeof(u32));
> +	/* Count boolean fences */
> +	for (i = 0; i < wait_info->num_syncobj_handles; i++) {
> +		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			return r;
>   
> -	if (IS_ERR(timeline_points)) {
> -		r = PTR_ERR(timeline_points);
> -		goto free_timeline_handles;
> +		num_fences++;
> +		dma_fence_put(fence);
>   	}
>   
> -	r = drm_gem_objects_lookup(filp,
> -				   u64_to_user_ptr(wait_info->bo_read_handles),
> -				   num_read_bo_handles,
> -				   &gobj_read);
> -	if (r)
> -		goto free_timeline_points;
> -
> -	r = drm_gem_objects_lookup(filp,
> -				   u64_to_user_ptr(wait_info->bo_write_handles),
> -				   num_write_bo_handles,
> -				   &gobj_write);
> -	if (r)
> -		goto put_gobj_read;
> -
> +	/* Lock all the GEM objects */
> +	/* TODO: It is actually not necessary to lock them */
> +	num_read_bo_handles = wait_info->num_bo_read_handles;
> +	num_write_bo_handles = wait_info->num_bo_write_handles;
>   	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> -		      (num_read_bo_handles + num_write_bo_handles));
> +		      num_read_bo_handles + num_write_bo_handles);
>   
> -	/* Lock all BOs with retry handling */
>   	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
> +		r = drm_exec_prepare_array(&exec, gobj_read,
> +					   num_read_bo_handles, 1);
>   		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> +		if (r)
> +			goto error_unlock;
>   
> -		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
> +		r = drm_exec_prepare_array(&exec, gobj_write,
> +					   num_write_bo_handles, 1);
>   		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> +		if (r)
> +			goto error_unlock;
>   	}
>   
> -	if (!wait_info->num_fences) {
> -		if (num_points) {
> -			struct dma_fence_unwrap iter;
> -			struct dma_fence *fence;
> -			struct dma_fence *f;
> -
> -			for (i = 0; i < num_points; i++) {
> -				r = drm_syncobj_find_fence(filp, timeline_handles[i],
> -							   timeline_points[i],
> -							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> -							   &fence);
> -				if (r)
> -					goto exec_fini;
> -
> -				dma_fence_unwrap_for_each(f, &iter, fence)
> -					num_fences++;
> -
> -				dma_fence_put(fence);
> -			}
> -		}
> +	/* Count read fences */
> +	for (i = 0; i < num_read_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
>   
> -		/* Count syncobj's fence */
> -		for (i = 0; i < num_syncobj; i++) {
> -			struct dma_fence *fence;
> +		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> +					DMA_RESV_USAGE_READ, fence)
> +			num_fences++;
> +	}
>   
> -			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> -						   0,
> -						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> -						   &fence);
> -			if (r)
> -				goto exec_fini;
> +	/* Count write fences */
> +	for (i = 0; i < num_write_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
>   
> +		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> +					DMA_RESV_USAGE_WRITE, fence)
>   			num_fences++;
> -			dma_fence_put(fence);
> -		}
> +	}
>   
> -		/* Count GEM objects fence */
> -		for (i = 0; i < num_read_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +	wait_info->num_fences = num_fences;
> +	r = 0;
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> -						DMA_RESV_USAGE_READ, fence)
> -				num_fences++;
> -		}
> +error_unlock:
> +	/* Unlock all the GEM objects */
> +	drm_exec_fini(&exec);
> +	return r;
> +}
>   
> -		for (i = 0; i < num_write_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +static int
> +amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
> +				    struct drm_amdgpu_userq_wait *wait_info,
> +				    u32 *syncobj_handles, u32 *timeline_points,
> +				    u32 *timeline_handles,
> +				    struct drm_gem_object **gobj_write,
> +				    struct drm_gem_object **gobj_read)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> +	struct drm_amdgpu_userq_fence_info *fence_info;
> +	int num_read_bo_handles, num_write_bo_handles;
> +	struct amdgpu_usermode_queue *waitq;
> +	struct dma_fence **fences, *fence, *f;
> +	struct dma_fence_unwrap iter;
> +	int num_points, num_syncobj;
> +	unsigned int num_fences = 0;
> +	struct drm_exec exec;
> +	int i, cnt, r;
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> -						DMA_RESV_USAGE_WRITE, fence)
> -				num_fences++;
> -		}
> +	fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info),
> +				   GFP_KERNEL);
> +	if (!fence_info)
> +		return -ENOMEM;
>   
> -		/*
> -		 * Passing num_fences = 0 means that userspace doesn't want to
> -		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
> -		 * userq_fence_info and return the actual number of fences on
> -		 * args->num_fences.
> -		 */
> -		wait_info->num_fences = num_fences;
> -	} else {
> -		/* Array of fence info */
> -		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
> -		if (!fence_info) {
> -			r = -ENOMEM;
> -			goto exec_fini;
> -		}
> +	fences = kmalloc_array(wait_info->num_fences, sizeof(*fences),
> +			       GFP_KERNEL);
> +	if (!fences) {
> +		r = -ENOMEM;
> +		goto free_fence_info;
> +	}
> +
> +	/* Retrieve timeline fences */
> +	num_points = wait_info->num_syncobj_timeline_handles;
> +	for (i = 0; i < num_points; i++) {
> +		r = drm_syncobj_find_fence(filp, timeline_handles[i],
> +					   timeline_points[i],
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			goto free_fences;
> +
> +		dma_fence_unwrap_for_each(f, &iter, fence) {
> +			if (num_fences >= wait_info->num_fences) {
> +				r = -EINVAL;
> +				goto free_fences;
> +			}
>   
> -		/* Array of fences */
> -		fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
> -		if (!fences) {
> -			r = -ENOMEM;
> -			goto free_fence_info;
> +			fences[num_fences++] = dma_fence_get(f);
>   		}
>   
> -		/* Retrieve GEM read objects fence */
> -		for (i = 0; i < num_read_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +		dma_fence_put(fence);
> +	}
> +
> +	/* Retrieve boolean fences */
> +	num_syncobj = wait_info->num_syncobj_handles;
> +	for (i = 0; i < num_syncobj; i++) {
> +		struct dma_fence *fence;
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> -						DMA_RESV_USAGE_READ, fence) {
> -				if (num_fences >= wait_info->num_fences) {
> -					r = -EINVAL;
> -					goto free_fences;
> -				}
> +		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			goto free_fences;
>   
> -				fences[num_fences++] = fence;
> -				dma_fence_get(fence);
> -			}
> +		if (num_fences >= wait_info->num_fences) {
> +			dma_fence_put(fence);
> +			r = -EINVAL;
> +			goto free_fences;
>   		}
>   
> -		/* Retrieve GEM write objects fence */
> -		for (i = 0; i < num_write_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +		/* Give the reference to the fence array */
> +		fences[num_fences++] = fence;
> +	}
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> -						DMA_RESV_USAGE_WRITE, fence) {
> -				if (num_fences >= wait_info->num_fences) {
> -					r = -EINVAL;
> -					goto free_fences;
> -				}
> +	/* Lock all the GEM objects */
> +	num_read_bo_handles = wait_info->num_bo_read_handles;
> +	num_write_bo_handles = wait_info->num_bo_write_handles;
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +		      num_read_bo_handles + num_write_bo_handles);
>   
> -				fences[num_fences++] = fence;
> -				dma_fence_get(fence);
> -			}
> -		}
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_array(&exec, gobj_read,
> +					   num_read_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto error_unlock;
> +
> +		r = drm_exec_prepare_array(&exec, gobj_write,
> +					   num_write_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto error_unlock;
> +	}
>   
> -		if (num_points) {
> -			struct dma_fence_unwrap iter;
> -			struct dma_fence *fence;
> -			struct dma_fence *f;
> -
> -			for (i = 0; i < num_points; i++) {
> -				r = drm_syncobj_find_fence(filp, timeline_handles[i],
> -							   timeline_points[i],
> -							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> -							   &fence);
> -				if (r)
> -					goto free_fences;
> -
> -				dma_fence_unwrap_for_each(f, &iter, fence) {
> -					if (num_fences >= wait_info->num_fences) {
> -						r = -EINVAL;
> -						dma_fence_put(fence);
> -						goto free_fences;
> -					}
> -
> -					dma_fence_get(f);
> -					fences[num_fences++] = f;
> -				}
> -
> -				dma_fence_put(fence);
> +	/* Retrieve GEM read objects fence */
> +	for (i = 0; i < num_read_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
> +
> +		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> +					DMA_RESV_USAGE_READ, fence) {
> +			if (num_fences >= wait_info->num_fences) {
> +				r = -EINVAL;
> +				goto error_unlock;
>   			}
> -		}
>   
> -		/* Retrieve syncobj's fence */
> -		for (i = 0; i < num_syncobj; i++) {
> -			struct dma_fence *fence;
> +			fences[num_fences++] = dma_fence_get(fence);
> +		}
> +	}
>   
> -			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> -						   0,
> -						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> -						   &fence);
> -			if (r)
> -				goto free_fences;
> +	/* Retrieve GEM write objects fence */
> +	for (i = 0; i < num_write_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
>   
> +		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> +					DMA_RESV_USAGE_WRITE, fence) {
>   			if (num_fences >= wait_info->num_fences) {
>   				r = -EINVAL;
> -				dma_fence_put(fence);
> -				goto free_fences;
> +				goto error_unlock;
>   			}
>   
> -			fences[num_fences++] = fence;
> +			fences[num_fences++] = dma_fence_get(fence);
>   		}
> +	}
>   
> -		/*
> -		 * Keep only the latest fences to reduce the number of values
> -		 * given back to userspace.
> -		 */
> -		num_fences = dma_fence_dedup_array(fences, num_fences);
> +	drm_exec_fini(&exec);
>   
> -		waitq = amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
> -		if (!waitq) {
> -			r = -EINVAL;
> -			goto free_fences;
> -		}
> +	/*
> +	 * Keep only the latest fences to reduce the number of values
> +	 * given back to userspace.
> +	 */
> +	num_fences = dma_fence_dedup_array(fences, num_fences);
>   
> -		for (i = 0, cnt = 0; i < num_fences; i++) {
> -			struct amdgpu_userq_fence_driver *fence_drv;
> -			struct amdgpu_userq_fence *userq_fence;
> -			u32 index;
> -
> -			userq_fence = to_amdgpu_userq_fence(fences[i]);
> -			if (!userq_fence) {
> -				/*
> -				 * Just waiting on other driver fences should
> -				 * be good for now
> -				 */
> -				r = dma_fence_wait(fences[i], true);
> -				if (r) {
> -					dma_fence_put(fences[i]);
> -					goto free_fences;
> -				}
> -
> -				dma_fence_put(fences[i]);
> -				continue;
> -			}
> +	waitq = amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
> +	if (!waitq) {
> +		r = -EINVAL;
> +		goto free_fences;
> +	}
> +
> +	for (i = 0, cnt = 0; i < num_fences; i++) {
> +		struct amdgpu_userq_fence_driver *fence_drv;
> +		struct amdgpu_userq_fence *userq_fence;
> +		u32 index;
>   
> -			fence_drv = userq_fence->fence_drv;
> +		userq_fence = to_amdgpu_userq_fence(fences[i]);
> +		if (!userq_fence) {
>   			/*
> -			 * We need to make sure the user queue release their reference
> -			 * to the fence drivers at some point before queue destruction.
> -			 * Otherwise, we would gather those references until we don't
> -			 * have any more space left and crash.
> +			 * Just waiting on other driver fences should
> +			 * be good for now
>   			 */
> -			r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
> -				     xa_limit_32b, GFP_KERNEL);
> +			r = dma_fence_wait(fences[i], true);
>   			if (r)
> -				goto free_fences;
> +				goto put_waitq;
> +
> +			continue;
> +		}
>   
> -			amdgpu_userq_fence_driver_get(fence_drv);
> +		fence_drv = userq_fence->fence_drv;
> +		/*
> +		 * We need to make sure the user queue release their reference
> +		 * to the fence drivers at some point before queue destruction.
> +		 * Otherwise, we would gather those references until we don't
> +		 * have any more space left and crash.
> +		 */
> +		r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
> +			     xa_limit_32b, GFP_KERNEL);
> +		if (r)
> +			goto put_waitq;
>   
> -			/* Store drm syncobj's gpu va address and value */
> -			fence_info[cnt].va = fence_drv->va;
> -			fence_info[cnt].value = fences[i]->seqno;
> +		amdgpu_userq_fence_driver_get(fence_drv);
>   
> -			dma_fence_put(fences[i]);
> -			/* Increment the actual userq fence count */
> -			cnt++;
> -		}
> +		/* Store drm syncobj's gpu va address and value */
> +		fence_info[cnt].va = fence_drv->va;
> +		fence_info[cnt].value = fences[i]->seqno;
>   
> -		wait_info->num_fences = cnt;
> -		/* Copy userq fence info to user space */
> -		if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
> -				 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
> -			r = -EFAULT;
> -			goto free_fences;
> -		}
> +		/* Increment the actual userq fence count */
> +		cnt++;
>   	}
> +	wait_info->num_fences = cnt;
> +
> +	/* Copy userq fence info to user space */
> +	if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
> +			 fence_info, cnt * sizeof(*fence_info)))
> +		r = -EFAULT;
> +	else
> +		r = 0;
> +
> +put_waitq:
> +	amdgpu_userq_put(waitq);
>   
>   free_fences:
> -	if (fences) {
> -		while (num_fences-- > 0)
> -			dma_fence_put(fences[num_fences]);
> -		kfree(fences);
> -	}
> +	while (num_fences--)
> +		dma_fence_put(fences[num_fences]);
> +	kfree(fences);
> +
>   free_fence_info:
>   	kfree(fence_info);
> -exec_fini:
> +	return r;
> +
> +error_unlock:
>   	drm_exec_fini(&exec);
> -put_gobj_write:
> -	for (i = 0; i < num_write_bo_handles; i++)
> -		drm_gem_object_put(gobj_write[i]);
> -	kfree(gobj_write);
> +	goto free_fences;
> +}
> +
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp)
> +{
> +	int num_points, num_syncobj, num_read_bo_handles, num_write_bo_handles;
> +	u32 *syncobj_handles, *timeline_points, *timeline_handles;
> +	struct drm_amdgpu_userq_wait *wait_info = data;
> +	struct drm_gem_object **gobj_write;
> +	struct drm_gem_object **gobj_read;
> +	void __user *ptr;
> +	int r;
> +
> +	if (!amdgpu_userq_enabled(dev))
> +		return -ENOTSUPP;
> +
> +	if (wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
> +	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
> +		return -EINVAL;
> +
> +	num_syncobj = wait_info->num_syncobj_handles;
> +	ptr = u64_to_user_ptr(wait_info->syncobj_handles);
> +	syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));
> +	if (IS_ERR(syncobj_handles))
> +		return PTR_ERR(syncobj_handles);
> +
> +	num_points = wait_info->num_syncobj_timeline_handles;
> +	ptr = u64_to_user_ptr(wait_info->syncobj_timeline_handles);
> +	timeline_handles = memdup_array_user(ptr, num_points, sizeof(u32));
> +	if (IS_ERR(timeline_handles)) {
> +		r = PTR_ERR(timeline_handles);
> +		goto free_syncobj_handles;
> +	}
> +
> +	ptr = u64_to_user_ptr(wait_info->syncobj_timeline_points);
> +	timeline_points = memdup_array_user(ptr, num_points, sizeof(u32));
> +	if (IS_ERR(timeline_points)) {
> +		r = PTR_ERR(timeline_points);
> +		goto free_timeline_handles;
> +	}
> +
> +	num_read_bo_handles = wait_info->num_bo_read_handles;
> +	ptr = u64_to_user_ptr(wait_info->bo_read_handles),
> +	r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
> +	if (r)
> +		goto free_timeline_points;
> +
> +	num_write_bo_handles = wait_info->num_bo_write_handles;
> +	ptr = u64_to_user_ptr(wait_info->bo_write_handles),
> +	r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
> +				   &gobj_write);
> +	if (r)
> +		goto put_gobj_read;
> +
> +	/*
> +	 * Passing num_fences = 0 means that userspace doesn't want to
> +	 * retrieve userq_fence_info. If num_fences = 0 we skip filling
> +	 * userq_fence_info and return the actual number of fences on
> +	 * args->num_fences.
> +	 */
> +	if (!wait_info->num_fences) {
> +		r = amdgpu_userq_wait_count_fences(filp, wait_info,
> +						   syncobj_handles,
> +						   timeline_points,
> +						   timeline_handles,
> +						   gobj_write,
> +						   gobj_read);
> +	} else {
> +		r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
> +							syncobj_handles,
> +							timeline_points,
> +							timeline_handles,
> +							gobj_write,
> +							gobj_read);
> +	}
> +
> +	while (num_write_bo_handles--)
> +		drm_gem_object_put(gobj_write[num_write_bo_handles]);
> +	kvfree(gobj_write);
> +
>   put_gobj_read:
> -	for (i = 0; i < num_read_bo_handles; i++)
> -		drm_gem_object_put(gobj_read[i]);
> -	kfree(gobj_read);
> +	while (num_read_bo_handles--)
> +		drm_gem_object_put(gobj_read[num_read_bo_handles]);
> +	kvfree(gobj_read);
> +
>   free_timeline_points:
>   	kfree(timeline_points);
>   free_timeline_handles:
>   	kfree(timeline_handles);
>   free_syncobj_handles:
>   	kfree(syncobj_handles);
> -
> -	if (waitq)
> -		amdgpu_userq_put(waitq);
> -
>   	return r;
>   }
