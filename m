Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312C6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B707310E4FE;
	Tue, 15 Mar 2022 07:35:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2815D10E4FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVF/zNNfFE47cmHV65fcEBqKneN2B6PW8OMbHeD/aAUaiWt+oPjZ5Tde9Qo3wIxyu3yYOlBiizpn3vElOj+U9BTZd2Tdwo9x1tUEke0gILWCUZ7D5gIZiEPVr26xOc7FUwM/AvydyEpAsSx6pKzUrDntUyXDroX5+D6G3jT92AP8ywHbnwu2f7EljbqF2i6yv1nBYXt1mjT2L4keGrjO5nk8KYdZQPLCQSBJkvSKpySG8EOaIiK5XnDQbDGwQ6NP1qmGXJ3USZcVqQM7ezNixhq64wqb6uwxeaXRnlu6EWX9KAP7d8+QA1rDfyWVaXLA64uOI0j6NWlgLks65ZW+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilvpY3sFgv0jVXpKKHH1LS0yVeXQVENArsYP0TMalX0=;
 b=ZoEd8mfvQwJxxySpBXZDPhiV/GAcs0RgRLVhNexZGXosBnOz6/5lL1L8rI7Ku6WCVlD/UVbxyfQIhzUF1+vl1ZMHCgMtS8pFBhJ/To7mcE0E0p7ooMRJB21a2I7SbkVrDgCme7PwyRyQZE1KICZBc98mzfcJ8yyxBDTGlvX/dqDzqbnteWjIZmgji3NIyUxpdq6yIEYCDjGVTx9oy7JcrSXzt6D/KVPu8lnjYZWqOT9DXj0EUdNzxfsQin3hAZjS3WTQeyNG/9hxDPnBureejnH25eq7ZyX+2MbEaXbe4G0Lw0cka/N+JKgbFedj1Et61ZuOULSpMOA7xqY46pyz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilvpY3sFgv0jVXpKKHH1LS0yVeXQVENArsYP0TMalX0=;
 b=Ra80EdH+L7Wlf2/68RttNpoP3CTzCiAQCBuCaMY21gJN/Zujy76krSOG5R68DBIYMDhkDKCzfMwIpP4cAr476LlVoak5g2QQzGxHzkWwcrNp83ZoGsXvFRdXb/waoJOXKOLT3/YvTj+UDKaqyc4ypC8W+TteBRx5q5NmC9jq4P4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 07:35:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 07:35:12 +0000
Message-ID: <5931e547-fa64-854d-a212-1ce214f4e8e5@amd.com>
Date: Tue, 15 Mar 2022 08:35:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: prevent memory wipe in suspend/shutdown
 stage
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, xinhui.pan@amd.com, alexander.deucher@amd.com
References: <20220315070913.9046-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220315070913.9046-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR02CA0028.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::41) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76794cc5-915b-4fbe-34b9-08da065656f8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5157:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5157CE09857F8B6B4CAFC0AB83109@BL1PR12MB5157.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xX8QNzSq3dy7JlDmdSFxzdnKxJl4PQf0nmYTRKg/eBTC9mlsIF9VA6f93zZ9b34hcQ6dgYo8MpZF5CjyMB/jYKDQnor8e0iv+m1jJwEjHsgYJq122FCe8tnawTymdcBFZroazY+s39/njhVL/vkvTHoRA5Ra7H7z/Ooaq4n/2hGOxymwXqtG787/IrGBZKMT4b9JVDvBsOrms73cQV+eUXasMt6CWLcra7/fkhlaQsjKClW43+kPFiE2mQ6yniVPUP6Hgq8aLPiHoB/jewXHgWyTsQ5cFmTmX5zQQ5Vf/emGlPOVW0w0WHhoeE7hL/uTvb4Je/8gU5A9TWw3bs3hJSCQfDGx7uRbmlXcg+g0qyvVAkK3jrJ5AQlXZqtvrGDcX+IwmG+R6JcC317C79orneErY1k3ykPWSnT9bBuqY7V2qQhuFG7nsDglsUXCl6hvq7Y8+byKa7hMPv4iPg3TpkrclwbFqOIGqlewvRHTyMD7llP4NJVbZoIcw6Bm/1AWlAVp4gseDe0eEqYCefy4fQhZvTSRBB6y+oBLuR+7MFo4Zybzgn+Y5YpJkRtKnmvxRrKR8whY1pZD1e+A6ppbjtc7j9Z8KZ1IYCgPeRCdpkzaR3NsAefN6yEXedEOe29Yv3azounejohOkztbjSLRwGGH1Q6Ndwm9vgrpO6vIk/VABGV7ZzIwa/tnjpg4FY415PBKEWCkSOV26c2uF3W8ZVqCr9PQs7eosgzXPkhGWIPAKljgYQzA/EBoFiFSQVmm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(66574015)(2616005)(15650500001)(8936002)(31686004)(66556008)(2906002)(66476007)(8676002)(66946007)(186003)(26005)(508600001)(6512007)(6666004)(36756003)(6506007)(38100700002)(6636002)(86362001)(31696002)(6486002)(5660300002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clZkUTdUdTZNaFhHdGEzejZnVXRWR1BJQlhQTTl5ODJnWFErck5zWTNUeGVX?=
 =?utf-8?B?anM2bTBSbEhIeFBnaVhvSnpNWnFaeVp6WGVXcXVLcWQ2QTNrOUdPUFliNWpq?=
 =?utf-8?B?UDhpV3JLMERsUHp2VlN1eW4wY0lsaVZmdi9OeGdlWWtRYUxmZ0dqRTVPbjY2?=
 =?utf-8?B?QnJleHU4UUxZZ1U4NzJYNHpJZjd0S3lIeS8yd2dUTEplQlR4RnUyNE5OY1NU?=
 =?utf-8?B?UjhkQmxqYzdHWjlWMmFTOW1GaFB5cXVaL3BCYll3VjlvNWVpblJjUVVzenNq?=
 =?utf-8?B?SEUvQmlmclY0enlacWVXTktoWjZtbHJMQjBqbm1MYVFhYnlLNEVSei90NEl0?=
 =?utf-8?B?U3R4M04zNmtrRCtLRmk5dmZoaXdZQUdOb0V0U09sRmc5LzRlekhYTjc4aHRa?=
 =?utf-8?B?Z2FJYkZYaHdwTExHcmtsZmtSNDJOb3VwZzFLdUgrcWZ3STB6ZjVZbXhiTE9q?=
 =?utf-8?B?eDh3d3JzUnZBWVVDODRRRHVHb1pyVGo4ejVJcGJkcmd4bk9mMGNvcjNKckJo?=
 =?utf-8?B?TzRBS2NmeFA1WlhDU1lNUGtoUVA3OWIrYjRsQTZuQmN6bkpxUkFsZ2ZnZkpv?=
 =?utf-8?B?eENKUHYvNkJ2em1OOHVEU1ZxaHpSNGFEcjdURVdiTGNhVU1SSTEwbFZ3NWNI?=
 =?utf-8?B?ZjJ6QU1yY2hXbS9Qdkk4M0k5Ymx6Sk44NjBsci9vZkFhQ08vbDh6QUx0QjdC?=
 =?utf-8?B?Y1BNWHVyUnhTN2VjRkNqS0xnYTQ1MS8zb1NEOWZzajJpQnZGL1FQb3V6cmpJ?=
 =?utf-8?B?VWpFYk51N0U5eGZ5dTFMcmlRa0MxUjlYc2hHbTgvWG9IWlpuazRHOVdzdjl2?=
 =?utf-8?B?YVZVRmNETWFId2ZyY1JURDFTSG56eWQ0WGZFNEJ4amR0VWFvTm8xYkpBeHlI?=
 =?utf-8?B?bXYvYTlhVnlEaDNUU2h6Nm1LemVkelFMby9aRFltbktXenQxME0ydEdoR3g0?=
 =?utf-8?B?c1VzMUk5bXRoUjA2V3RpNkoxbUt4aTF4K1FsancvbEZuZFFWUFZZTm9sRHdz?=
 =?utf-8?B?aFJ1RE1VQVpZOFRyTHRPaE9iNE1vQUJRVUViTWFCOWdoUzJLcG0xN21uRjM3?=
 =?utf-8?B?WkhRN1VDcGpiWjlqWU9QRzZUZ09tVThwU09WUXpua29IWXN1cncwY1RtVW5G?=
 =?utf-8?B?dEo4enQ4U1BleVlQN2lKZm9SbVdFOWxsZXBZZElSWVR3Y3l0RU5PN0FCUjVY?=
 =?utf-8?B?Z1cyR0lob1J4K1hVZU1YaHRFWkxZOVhPamhqK3dwekJSMVdCSDJJa0FRM2tG?=
 =?utf-8?B?SDhJVmJ0dURvbE05TkI2SytoSkx2cVRhbExzQWNXNEFxS3FaQ3pFZDhycXl1?=
 =?utf-8?B?NFYvZS9Wc0ZVZnBBT1BNMTlvN0N1ZGJJQjU2M2loMTVWbWRPZXJyWDRqbUYw?=
 =?utf-8?B?S0dHQjlESXNaTnQ2WTR2ejFvU0x5R3hySnlrejRSdFVUTFZEYWpZOE9JYzVE?=
 =?utf-8?B?TWs2QVJROFNrb3dqZm8zcnhCWlVLNEFwc3ltbWxqalA2U3ZNY2tCWTQxNzlk?=
 =?utf-8?B?VXpVY2Z0dVA2UXpndkkrWHJGdFBlOFA1VFVOOWNiL0RjSjRnRTNvUmU3NzRi?=
 =?utf-8?B?YmVNWis5ZjhaMTV4OHo4VzdKZlZqWTl1amJ0TmErU0JGWSthVU9BaU5XSFdY?=
 =?utf-8?B?cGlQSDV6UGZRbEpFdGRJUzJtVzhJMmZpN25NNEVKb2hDQlJoMmVjaFlKdTN1?=
 =?utf-8?B?RzdkdUhXSjhGV2ExUmVRdGkzTkt4RzlCU3hQR2FRTnFiVDRMdGorWXZ6emxl?=
 =?utf-8?B?R21NVURXNnMyYk1tR2tvNGxWc0JHS3dIY1FYQjZ5MEx3cm9UdHlyNkZKUUVu?=
 =?utf-8?B?emc0MlFSTUpNNHRMa0Q4MStFYTVoTWRyVTlSekVlWUg3ZStKTG5wTm15VC8r?=
 =?utf-8?B?dkM5ODNsNDZlVmwxL0RpWjBxT1ViTDk5eHF2SGdKcGdsbkhwUTUxUmFvdnJ0?=
 =?utf-8?Q?jxuhEqsRjtlClhsyNlDIahALwi5xMGxZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76794cc5-915b-4fbe-34b9-08da065656f8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 07:35:12.4438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+b+Yg45pKBNX5851zubkVhz1hfQzgP/VXkY3uH1dJTVlvtP0ucSsu7LLnuG5492
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
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



Am 15.03.22 um 08:09 schrieb Guchun Chen:
> On GPUs with RAS enabled, below call trace is observed when
> suspending or shutting down device. The cause is we have enabled
> memory wipe flag for BOs on such GPUs by default, and such BOs
> will go to memory wipe by amdgpu_fill_buffer, however, because
> ring is off already, it fails to clean up the memory and throw
> this error message. So add a suspend/shutdown check before
> wipping memory.
>
> [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
>
> Fixes: e7e7c87a205d("drm/amdgpu: Wipe all VRAM on free when RAS is enabled")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Just one nit below, but the patch is anyway Reviewed-by: Christian König 
<christian.koenig@amd.com>.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 23c9a60693ee..ed1a19be4a54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1284,6 +1284,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
>    */
>   void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>   {
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>   	struct dma_fence *fence = NULL;
>   	struct amdgpu_bo *abo;
>   	int r;
> @@ -1303,7 +1304,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>   		amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);
>   
>   	if (bo->resource->mem_type != TTM_PL_VRAM ||
> -	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE))
> +		!(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE) ||
> +		adev->in_suspend || adev->shutdown)

What editor and settings are you using?

When you have a multi-line condition to an if the next line should start 
after the ( of the previous line, but this here is using two tabs instead.

Regards,
Christian.

>   		return;
>   
>   	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))

