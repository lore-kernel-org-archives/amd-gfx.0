Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A456AC77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 12:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A184910E70A;
	Tue, 25 Apr 2023 12:37:05 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E496010E70A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 12:37:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlBjbJfPxRt0hjBxb/JLAYc7H/J1eVZR4zGGGmpUNMO+glDpE7JVs5HetUFZs639VcYHwH0hTdad08gay6im0yU7zT4cjjwOhiMeBEgfYWcb0+vCZf6E8D1wYGBbMC51v0e7C9CNtmFmyiRUv90Mnc4NGP813Dm4VKXLiIrtQAXosWl31+tJb7askXMvWd3r5EkQOdmK9QPTNx39xGo0uuqrRq5L7GZGa3clZyyn2N/zYHXxsChcbifpFvNJ1+aLq8csJLaBswaZNg7M/4eLwDIu67V7NWGJylLAEw8C77tu1XW7wolVdHkTpinLorM3WOwfidcxv0RStUTYVTNSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFl1VxGRvhRK8hN1OnFlW2lO8je0pq6NjBdvwpOhSgA=;
 b=KQR1yHK9xL8KTqZ4OCEQqg98taNLnZqqVfdcLFzsiicd+HtE/3u9PHiDOV9bbMgzw0mRDY7hZekl+RduLlcfvDqr3iYScSM2sjagGQQWzIGrNEvgd26Q6LWDcsaX8QG/gieoLf1KNqkK+FFUrS2xWp/lVIJji4vQysjyR05ifmzzcqWnpk0uaPJyZUrYm0jEqnsSLqJqxlZ9ctX5bWDxHbPhu1jkgC5kf5XyYN6ZIhCWN5F6d6OmiugOMLNRpc8nX0gjZPMWnxZrklMpxlH/fI8TkVYKytqZO2Bk0s2SnagXDiFvVpNgcDwOCadLhu1t8Oyeb0t0ziu9drZK9taFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFl1VxGRvhRK8hN1OnFlW2lO8je0pq6NjBdvwpOhSgA=;
 b=nq+po3irn7Vha6C0yV1uI8qeFuatZNav4um/8ejFRVDSXr4Crs4dAcDKfq8pzjBwHEUj68+fuRc86YGlpWgEK9BAPloIyLPePzFyNfSmNSS4vWxEnJ8A4r/BJUDdcXfQEKM82IvqicrsxEKW/8f6OvmSrCyzjTVcUCl0DFjIpG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 12:37:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 12:37:01 +0000
Message-ID: <007d02c2-069d-5597-79c4-3cd21e24d3c1@amd.com>
Date: Tue, 25 Apr 2023 14:36:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 08/10] drm/amdgpu: map wptr BO into GART
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-9-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230424173836.1441-9-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfd65a9-34ea-47e0-cb49-08db4589c45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVeuJHQYAVlN2JhL18M9PQvZiiRmCRN9jo/xj9Rsr/E6kaA4ekazhlNUxBsQ2vjl/t++f++yQwaAdNm6zbY3YfSAcAZAIZ7BW4L5N47nBziXzeYd3nhN7WHFba+K1dz2osA980OVzYg13A9dwBS/SHxTul2zZ6RZGWsH/PZq9sFggyAb1WAxrel5ZCr5EGvWyGjPmDK/7Vu8wj+vF6YR9GD8/tPbAEsOs3kK85YWF6ihcbCOQiBOXt1His3DzNBiv2yxRvo3G8tcORhwS8XOUhzz1nvLejUltFEn8oer99CBUwH/RbyEYbyU6hiNkzozrLDbcRqdjaedyo23I9K+8qEKQGP7ituqq1dpx9iaS5//b6uy+yGsxN3iiimUbOnplCnKlMYH2CXxrG7ntyXBL7mEk3H6bVCRkeFukChSylAjLtff1SULZLKTNQ9t3+0Eu725bhzasyOuiqEG8wlitkFJIUo8sTjQdEU50fhICQ/X1+OtI5M0T8z3Mmmz/Up3oog06sMVEL6/rrNpEI0OGdxwRpPNpJdJpdy8bYTWTQs5nHHwygq2p5wV7FF19X11wzcb2srVsJw8x5zv+FhvT3xcFlpHqtv84YaXS4x4WToqN/SPmWJZZGCuDaJz4Ic2ayO+/nIypyxqJAClzRe48Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(41300700001)(5660300002)(8936002)(8676002)(83380400001)(186003)(6512007)(6506007)(2616005)(38100700002)(86362001)(31696002)(66476007)(4326008)(316002)(6486002)(36756003)(66946007)(66556008)(478600001)(6666004)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1hmaWRtN2FXbDg2dVQvS1F2bHFmMjJwRGh4ZU9nVk1NbVdHWXh6RGlXSGxE?=
 =?utf-8?B?T21RS09icnpQVFNaOHl1ZHJaV2JzSmRBS1VSemRCQUdmRkhySTdRMWFtT0FN?=
 =?utf-8?B?bTkxSFQreEoyOWVuTERvNEFMckhQd1JUMTB2UVk5b0pyYmR1czFlZWxqKzFY?=
 =?utf-8?B?c1FIbjFmYVpWOUVxUjBMVDZ5UDBSNUJPMWlValoyVGxERVo2OUJBeVRnZEM2?=
 =?utf-8?B?cW9hQUl1dVlZakZma2xZVXpwQjZhUUlyN0Rxb013dU16TG0zb3piUGNvT09r?=
 =?utf-8?B?eHJJSWg0T0ZPUk9tV2pCcHhVU0xRWHAxSVFiQ1BxZVVrWlBnTzVucE9CZFd0?=
 =?utf-8?B?VVkyMFJZc1RnWStoMjdpVlArWFlsYzAwMlZVTEFQbG1NNnJmRW4zSmM0YXZ0?=
 =?utf-8?B?dm4xK0ZZRnV4MkVZSjZuQjJnRXAyc0FtRlo4OFhPbWpIcUFhZUt5YkJVSXdF?=
 =?utf-8?B?a0oxbCsxd0xQUjVEUnNYdGRxWXFYajJYSCtpQWdwM2dGZExibWE3QXNTTkdR?=
 =?utf-8?B?Nk44S0haOW1kT3R4dnp1UTFZcmJTWDNHZStodnhQRVoxUWp3eG5oTEw1NnJp?=
 =?utf-8?B?ZHh3SHo0T29tTEZBNk5NWTVYR1E3TmN4aXExSHVjSXE0R3M0VVF1bXpOSWZG?=
 =?utf-8?B?alFzMmt3cXZiYmsvYS9tREROeUQ4bWQ3eDVqUW81dlRoMkRGV01CU3ExV2pO?=
 =?utf-8?B?TWhvUUtMamF6bXh0UVNyejJQYUZvZVR1R2dhaEdCaVQ0WklLSWRhL0Y3bEJH?=
 =?utf-8?B?dUlxMHM0NU1hQTh4N05mVVZYYzhyMnlVWVdoZllxT2FPU0M0OXlpOHF4L0or?=
 =?utf-8?B?ZldxSGtuNzM3TCs1VFJUbXZFS2crYmFNQ3dZcFl3NVRwL1kyNVl5aXhrQTBh?=
 =?utf-8?B?WGJRUENNN3gzNzNGNUtEQkhidm41YVZQVmNqSVVJU0JFb0xNQXozL1RMd2lv?=
 =?utf-8?B?ZXQzNUFtRWpxOXBQNjdaTWg4cmQrYnZ3MGVkZ2dQcFUxZUphVTlNaDYyV2E4?=
 =?utf-8?B?SG9aUDRlVGRTNUZxVi9aY1czL3BMeDN1azBKc3Z4bGMvV3NISzFQcitMTDI3?=
 =?utf-8?B?T0NGZkRsM25hMVFRSmcraGRTWW1uK1lXdWNhUThXTVFDS3VNYWlsbnN5Z0Nm?=
 =?utf-8?B?Ulc4OTZxUlBxQkhYTnMyT1FXL25xNEdNdlNZNWI3anZxUC9jVW9WNGF6d1Fs?=
 =?utf-8?B?K0RFcVNiSW5CbW5uYk9NWGp5YVBaTVZ1ZC80OHJKMDdjWnVBSjJEUXlpRk9O?=
 =?utf-8?B?RVk2M1I1cXl0WHQwaTRVSnl5T0d3ZzM3OWZIQ3pydm5qWUtCV1RvZ0RaZXZI?=
 =?utf-8?B?enoxejRlNExFR3RmSUJzMHlFSFVWby9QNmVvSi8wSVJ1ZlFLdkVaWXMvZ2Ex?=
 =?utf-8?B?MlhOVEU3aHZpbXZHRm1EclVLdVBseUQwMmYwZjc5KzBFZ3d0R0M3dmZFbkxS?=
 =?utf-8?B?WER2dTE1dVZzdnMxcGhOWnA2NXJvNVFkdmozZUJIc1ZKUW03cnZ2ajJkSUFW?=
 =?utf-8?B?TzROeGN2MjJwUmV0cEF2bjAyd0xjYm9zTUh5MkR3dG12U09CNzF5bGJWWVFJ?=
 =?utf-8?B?QzE5YjFGdUNuSXNWN1FOSWcrdlJ6ZzVLNFo1aTMzcHdFUVlTSXVBR3kweXo1?=
 =?utf-8?B?aXl5TVQxS1B1US9pa2xBdU5YRkVxZUFWdGtwdDEvNWtNMDJrSlBlSVBGSFBG?=
 =?utf-8?B?V3J4MkpNQU9yQ2NxTmJkVzA3SW8wRG1HRkxpSWJSbnFnUDAwemY0MEV3ZWVq?=
 =?utf-8?B?Ujdkdlh3OVZvV2cvczJWVWc4T3dHUHVReXJXZ3hieE1DZ3M4R1JnVXRTLytt?=
 =?utf-8?B?WEVyb2hBbzNTZDBMaHZvL3AxUUlGRjZ3enZxN2JKWUFJK2VOeFJ2UTNVUS9Z?=
 =?utf-8?B?NGU2aU40M2tPOU5jdTh4dC9vZm9JOVF4ZWsvK1N6bmZndGRRUi91VjBsbXVp?=
 =?utf-8?B?UWpzSkhUNFN2VFNOWDZLZzczQ3BEU0ZEK2VEUGloTzRnT2swVE1nMDZneU1K?=
 =?utf-8?B?OWRKNGxoN2l5bzdjZUt1c0JVZzBGdGlDTzJtWmtpellSYkN5RkpqVkNNcmdS?=
 =?utf-8?B?b3N6dFpZL01sZlB3aGdTK1grUkUzNDUvV2dldm8wdGhQRkJTU0l3YmRYbWVP?=
 =?utf-8?B?enRHNUVtMHNaN1NOVTBTV2RGdVlpU0pNb0ttOHdBVFZvenFneE1UamFXOTRL?=
 =?utf-8?Q?TjX4acIQMNDZqdf8ImJXq083jDWBTpIz0KeypoUT69w7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfd65a9-34ea-47e0-cb49-08db4589c45a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 12:37:01.1930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqoMCNb3Awkyh6ZAn0KnkMHkwBQuxUsKLAwCFXrimrLtsE/gDL2qb1d6DNqYZX7W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.04.23 um 19:38 schrieb Shashank Sharma:
> To support oversubscription, MES FW expects WPTR BOs to
> be mapped into GART, before they are submitted to usermode
> queues. This patch adds a function for the same.
>
> V4: fix the wptr value before mapping lookup (Bas, Christian).
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 90 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  1 +
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>   3 files changed, 92 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index e95fb35b0cb5..385cd51b6c96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -44,6 +44,89 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>   	return idr_find(&uq_mgr->userq_idr, qid);
>   }
>   
> +static int
> +amdgpu_userqueue_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
> +{
> +	int ret;
> +
> +	ret = amdgpu_bo_reserve(bo, true);
> +	if (ret) {
> +		DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
> +		goto err_reserve_bo_failed;
> +	}
> +
> +	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +	if (ret) {
> +		DRM_ERROR("Failed to pin bo. ret %d\n", ret);
> +		goto err_pin_bo_failed;
> +	}
> +
> +	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
> +	if (ret) {
> +		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
> +		goto err_map_bo_gart_failed;
> +	}

Either pinning *or* allocating GART, but not both!

I think calling amdgpu_ttm_alloc_gart() is the right thing to do here.

> +
> +	amdgpu_bo_unreserve(bo);
> +	bo = amdgpu_bo_ref(bo);
> +
> +	return 0;
> +
> +err_map_bo_gart_failed:
> +	amdgpu_bo_unpin(bo);
> +err_pin_bo_failed:
> +	amdgpu_bo_unreserve(bo);
> +err_reserve_bo_failed:
> +
> +	return ret;
> +}
> +
> +
> +static int
> +amdgpu_userqueue_create_wptr_mapping(struct amdgpu_device *adev,
> +				     struct drm_file *filp,
> +				     struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_bo_va_mapping *wptr_mapping;
> +	struct amdgpu_vm *wptr_vm;
> +	struct amdgpu_bo *wptr_bo = NULL;
> +	uint64_t wptr = queue->userq_prop.wptr_gpu_addr;
> +	int ret;
> +
> +	wptr_vm = queue->vm;
> +	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);

All the handling must be done with the VM and all resource locks held.

So this should be something the caller of the function does.

Regards,
Christian.

> +	if (ret)
> +		goto err_wptr_map_gart;
> +
> +	wptr &= AMDGPU_GMC_HOLE_MASK;
> +	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
> +	amdgpu_bo_unreserve(wptr_vm->root.bo);
> +	if (!wptr_mapping) {
> +		DRM_ERROR("Failed to lookup wptr bo\n");
> +		ret = -EINVAL;
> +		goto err_wptr_map_gart;
> +	}
> +
> +	wptr_bo = wptr_mapping->bo_va->base.bo;
> +	if (wptr_bo->tbo.base.size > PAGE_SIZE) {
> +		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
> +		ret = -EINVAL;
> +		goto err_wptr_map_gart;
> +	}
> +
> +	ret = amdgpu_userqueue_map_gtt_bo_to_gart(adev, wptr_bo);
> +	if (ret) {
> +		DRM_ERROR("Failed to map wptr bo to GART\n");
> +		goto err_wptr_map_gart;
> +	}
> +
> +	queue->wptr_mc_addr = wptr_bo->tbo.resource->start << PAGE_SHIFT;
> +	return 0;
> +
> +err_wptr_map_gart:
> +	return ret;
> +}
> +
>   static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union drm_amdgpu_userq *args)
>   {
>   	struct amdgpu_usermode_queue *queue;
> @@ -81,6 +164,13 @@ static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union drm_amdgpu_u
>   		goto free_queue;
>   	}
>   
> +	r = amdgpu_userqueue_create_wptr_mapping(uq_mgr->adev, filp, queue);
> +	if (r) {
> +		DRM_ERROR("Failed to map WPTR (0x%llx) for userqueue\n",
> +			   queue->userq_prop.wptr_gpu_addr);
> +		goto free_queue;
> +	}
> +
>   	if (uq_mgr->userq_funcs[queue->queue_type]->mqd_create) {
>   		r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
>   		if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 7a45d68091ec..6eeae0206d8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6439,6 +6439,7 @@ static int gfx_v11_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>   	queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>   	queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>   	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
> +	queue_input.wptr_mc_addr = queue->wptr_mc_addr;
>   
>   	amdgpu_mes_lock(&adev->mes);
>   	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 11e8ad649f6e..0001ecd710a7 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -38,6 +38,7 @@ struct amdgpu_usermode_queue {
>   	int			queue_id;
>   	int			queue_type;
>   	uint64_t		doorbell_handle;
> +	uint64_t		wptr_mc_addr;
>   	uint64_t		proc_ctx_gpu_addr;
>   	uint64_t		gang_ctx_gpu_addr;
>   	uint64_t		gds_ctx_gpu_addr;

