Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6268C04E69
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 08:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 455C710E539;
	Thu, 27 Jul 2023 08:15:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 118A310E542
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 08:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4f3vSkGEGR8XqACOfjYiyYK0RAUAa5XOfqM4TYw0OsgUmRNZK4OyucCzj5pM3iirppcyfR1DclYqkqnilQXKc4CBX/FwATilvbbVZyiXjtwTXPPQqYssd/vCgoQ6L2BbPvKp3uIvDKgTEWd3r64E83YRsIsfYoUYwHL7Swz4ozJLYrk4RKNbWwCpWjq0XHHXlo99QhMra748/yBjq9pyhnIf8hjZa/DcqOnBReEFIg4nv++rGsXnx89ZHYGlx6uPy4tl8zTIOvKJCLfu37AWkqnqspAEF2b2K+PluIinu/JfGchGhiTdQ9Mz6rDBsL/YL8cL2a/D4gP2ZAzZahdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkabHHjpECB9zVvbVlo2+ozSpcDaEbP7RrLJPY4LgYI=;
 b=T/gFtU7OtxjduV3R2DbOa3EMliBp/Nlk1AqQ+o2/JG7bOFaapI00zGoqWIyGoiRi8tJ6z3/40IvIldNS+T8LrD61Hp9JiFGp9W4uaE3Mp6t4yKvNEZ7yObKBza/dEBDvH9Zv+YbpfJecWWw4JeDX5B3j6zff+/jhJvLvQopxRIq0vRxWYKGKlOwU115OTCH7WfVJPTRbCN1g0Gu4oVyfYeQguRF7MexVkp20HXSlEXuqMBNZq4mwJkmbKaZjkAGH7XIJvzQVBuUCPpi3ztsTdd1y2Hhd7X6XD42fhPvatrfTj+MGlvjt4JeIHZaOMnHXQMh2jDgWKiBNwZAAkcyn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkabHHjpECB9zVvbVlo2+ozSpcDaEbP7RrLJPY4LgYI=;
 b=qiKwuXh2rDsEpU/YciwJNDIt6vL9DnUaXWNDm5O7VEDsXdWjYGZoSogHssu2CFX3z9UrESilfGvOU+M03J+B4qOFHXKy4PKRX8Nt+Sz6vZzEs7bN/okae/1V50l3IOOI+fA/xxur2Cx77qpjLShSI9/s4ZuXiaU5gQNF8uBtnf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 08:15:28 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 08:15:28 +0000
Date: Thu, 27 Jul 2023 16:15:17 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
Message-ID: <ZMInle4+cxmmiR1h@lang-desktop>
References: <20230727075620.728235-1-Lang.Yu@amd.com>
 <329490e4-22d5-043c-e57d-12b029053e15@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <329490e4-22d5-043c-e57d-12b029053e15@amd.com>
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 56397632-d0b4-4be3-42df-08db8e79a32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xC8CGm07lv96XvJtnVmwiuaO/pOYGRW/Fwn1REQsyujOyXUdlUAok5sZnuAsKX9RuBJEDeNB9wr5g11hWU+N9UXBlkjTYd5rmQ3pki2E9YMpweD+GGv0EpSg3DLIOETSaOg3G3X6W9XfQst/+lPhgprRIZdoq45AbIMlTIgJbrEP/Gpqj7W554VYvkqe0dyn55GPggcEjgHgM53dbXwXj+nHhLK4bpXaDyWqJ6EAcw63MxV8jftA4UwFa/dFCX6CkYS7S4Ls2hM1LYxJJncf+b//6DW6o6RoqfxzasdPgeHXPBsEYiniTgPMXH51h8GbA3hxATwvLFabgh1YcEBcn/QkUhrtJKQt/P2gzjfdQGO+uW98MwMSAEDYG062v8G5c/G7d89A5JA9QdgOiTJeq2et82MGNZGRNSmDWhJ0bk6TgZUVsyY28t++LTnTTBC5Uk4gZ+EsBF5U8KxDiOvHkiSbvJXV9shq2+XMtbWHUwtKIX34f2EC3HkbUEjwdel3yer6y64Z2tiMzJGHUOIR8gNiu8lhAj+Sdg/bLJISclBE3hxr8M8AUtnjkhY77p02RYexvlVwQv39K39UERtliacNLG2ihXEE34YGGIVFAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(6862004)(2906002)(186003)(6506007)(26005)(86362001)(316002)(38100700002)(66574015)(83380400001)(41300700001)(5660300002)(66476007)(66556008)(66946007)(8676002)(8936002)(6636002)(4326008)(54906003)(6486002)(6666004)(478600001)(9686003)(6512007)(33716001)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?g9KSoMYCvhIqBqNNAXeRA6otJcxkPTDovV3yasOcpnJxs/mulFzWTBueyv?=
 =?iso-8859-1?Q?bEkqpRIikhHcoxnUq1eGmNeGHUDp55lJeVG2KHotsWPzfbQ/sGtsL+SH8O?=
 =?iso-8859-1?Q?S8qt8DnJ5nj37/vqCuRZhHr7jRKbj+Fj23jkpk3YEJQ5mbi9jAKAgFT+up?=
 =?iso-8859-1?Q?hYrAw7Qz+7saVtG7219tWSw0vTi6i0KYb/RKXWJoWjhBx9ZT9qGb1gTE88?=
 =?iso-8859-1?Q?flf+2GmS1+MCrIiYxw22o+qbMduiB48vyMSQ6Ai6qlYbTnYQ/fNntmAes4?=
 =?iso-8859-1?Q?junP7LSrndz9IWDt3X3fFn2GfmWoZJ4WWaAMMwUahQI9ZJDQG631799Wvd?=
 =?iso-8859-1?Q?5ldIfXYbvQjacgMtKvHINpnlQaCPJFsHeSF3fm8efPMJdlGeWa9EP8J5CF?=
 =?iso-8859-1?Q?XKUpS0PesaL/GfKXMyVaQyNCzN9y5fF2OazTRtIcN6xrSWNr3ww5tKfkEU?=
 =?iso-8859-1?Q?D2HqXJauOgXzekKz5aVxUDKuNp4pOvPzov9FUawxgwnVOFKJU/xYBGFt9h?=
 =?iso-8859-1?Q?QAkmyvCqkJE+lyfGpI5jRXKwrb/Km2iXPs0I0p5ICUCAQJprpgvrJfIUSt?=
 =?iso-8859-1?Q?crDazgQEIkZLd8wYkiEhB2EGp72TXU1vSEwUuLhj5er7S+gMKCbQd9nrUd?=
 =?iso-8859-1?Q?GeJqrsB9XJ9OoTbR/OpWDP6lxW1LJO/OqE8QTQh/tCXCOCmU3cRYz2jnyH?=
 =?iso-8859-1?Q?3XekoVtBEQgsg3vieO2H3hxbPMfAtNaXhYyNE6f2+UwyLajmF1D9IyVBHM?=
 =?iso-8859-1?Q?gUZRHfoiblxDfJ6+eUE/R/iP0bJ7WUQh0rkSUBv5JLN/dcfbgRe+8JyqEx?=
 =?iso-8859-1?Q?u+qfbeydVKRtGilMBnUJ0l5Py2mMdoRQFplEF2m2Vyw+MU1GE34RhqoFOR?=
 =?iso-8859-1?Q?D37ZDJgl2GalETaijNcNXs1CdW3Otw2Kt6U0cglWuTYEyCCzIuXOBq5bX3?=
 =?iso-8859-1?Q?pjq404jdrHIBCP8HpqgXUTSAFHWnOn/SRZ2DWuyNy1delU/bjMwcwFErRh?=
 =?iso-8859-1?Q?sV1lXVIBuj2NAJf4A051M5c2zfOVv4ERjQhaSsRxaBZUatUxqeySIMBuFi?=
 =?iso-8859-1?Q?WRTONM7RWFXNU3q84B6+FXGuLrgSMM6FTEsrNBwIHF+rhM/KDjuAjTXZN5?=
 =?iso-8859-1?Q?ko6j3oJwOYGtrVOm2qPjVm3fwhsakavboGBECzPVqPGHh0QJs9tCVZrsdH?=
 =?iso-8859-1?Q?4juiPfz1YqAWtzEeV2p0IubnImGrrwZhuvi/5egrmn5JKMaFwQKo/E3SJ7?=
 =?iso-8859-1?Q?bGVlrTwSkl8hHBGoalYHbFuhsZYS+vs3jRYbuwBcWxxlZI9GRWbktN7Kbe?=
 =?iso-8859-1?Q?azk/4oUZx1RSB7knz94+tf8YgdkvbzhmjAj4t5KUEUqHAIQCbOAfSSlG15?=
 =?iso-8859-1?Q?zEZ7F5ThxsWb2ycPjPKBgc2B09WJBVE4AT2dW2h8SL6kWFvkE9R2P5PiRK?=
 =?iso-8859-1?Q?P0RafaS05+SkHVvVRdBrR2yBYKGuYlcz67ikCEog4/QXNWV25lir2abLmQ?=
 =?iso-8859-1?Q?ZfRAyPS5lCOwV+ZULsGJaK7bfc8bTHTqFpU96oORXuZBnJpBXz/Jyro7kg?=
 =?iso-8859-1?Q?l/4K1giVmxMde6+G3MyRSMPiMAw+RvfVx67WXPlUQp8fST0eBJCYLIn175?=
 =?iso-8859-1?Q?5R13zNQBldHp1Zkvy5CbYj86lX7El/Ptnp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56397632-d0b4-4be3-42df-08db8e79a32e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 08:15:28.4243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5mN8DaAtjsPA5UY+UGk3VjP5qeBllcoNfNodm1iK3ax9FGuCwjQ454h/KejlUvcMQ9kTObjQzuDD3z24D4dcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
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
 Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 07/27/ , Christian König wrote:
> Am 27.07.23 um 09:56 schrieb Lang Yu:
> > amdgpu_bo_create_kernel_at() is used to create a physical
> > contiguous VRAM BO at the specific offset. It calls
> > amdgpu_bo_create_reserved() to create a VRAM BO first,
> > then frees its old memory and allocates new memory at
> > the specific offset. But amdgpu_bo_create_reserved() would
> > fail if requested VRAM BO size is too large(>128MB) on
> > APU which usually has a small default VRAM size(512MB).
> > 
> > That is because VRAM fragmentation and DRM_BUDDY_RANGE_ALLOCATION
> > is not natively supported by amdgpu_bo_create().
> > 
> > The approach is using amdgpu_bo_create_reserved() to
> > create a BO in CPU domain first, it will always succeed.
> > Then use amdgpu_bo_pin_restricted() to move the BO to
> > requested domain and location.
> 
> That won't work like that.
> 
> The amdgpu_bo_create_kernel_at() function is used to take over specific
> memory areas from the BIOS and *not* to create a large VRAM BO.
 
  Literally, it is creating a VRAM BO.

> Allocating the initial dummy in the CPU domain is a good idea to avoid
> overlap, but you are messing this up quite a bit here and will probably
> break tons of stuff.

  I don't see it breaks something.amdgpu_bo_create() doesn't support 
  DRM_BUDDY_RANGE_ALLOCATION. Actually it works, this approach is just using
  DRM_BUDDY_RANGE_ALLOCATION to satify such allocation request.

  Reagrds,
  Lang
  
> Regards,
> Christian.
> 
> 
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++++++++--------------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 15 +++++------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  2 +-
> >   4 files changed, 21 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > index ff73cc11d47e..331daa47a444 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -358,6 +358,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
> >    * @offset: offset of the BO
> >    * @size: size of the BO
> >    * @bo_ptr:  used to initialize BOs in structures
> > + * @gpu_addr: GPU addr of the pinned BO
> >    * @cpu_addr: optional CPU address mapping
> >    *
> >    * Creates a kernel BO at a specific offset in VRAM.
> > @@ -367,42 +368,33 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
> >    */
> >   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
> >   			       uint64_t offset, uint64_t size,
> > -			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
> > +			       struct amdgpu_bo **bo_ptr,
> > +			       u64 *gpu_addr, void **cpu_addr)
> >   {
> > -	struct ttm_operation_ctx ctx = { false, false };
> > -	unsigned int i;
> >   	int r;
> >   	offset &= PAGE_MASK;
> >   	size = ALIGN(size, PAGE_SIZE);
> >   	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
> > -				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
> > -				      cpu_addr);
> > +				      AMDGPU_GEM_DOMAIN_CPU,
> > +				      bo_ptr, NULL, cpu_addr);
> >   	if (r)
> >   		return r;
> >   	if ((*bo_ptr) == NULL)
> >   		return 0;
> > -	/*
> > -	 * Remove the original mem node and create a new one at the request
> > -	 * position.
> > -	 */
> > -	if (cpu_addr)
> > -		amdgpu_bo_kunmap(*bo_ptr);
> > -
> > -	ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);
> > +	amdgpu_bo_unpin(*bo_ptr);
> > -	for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
> > -		(*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
> > -		(*bo_ptr)->placements[i].lpfn = (offset + size) >> PAGE_SHIFT;
> > -	}
> > -	r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
> > -			     &(*bo_ptr)->tbo.resource, &ctx);
> > +	r = amdgpu_bo_pin_restricted(*bo_ptr, AMDGPU_GEM_DOMAIN_VRAM,
> > +				     offset, offset + size);
> >   	if (r)
> >   		goto error;
> > +	if (gpu_addr)
> > +		*gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
> > +
> >   	if (cpu_addr) {
> >   		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
> >   		if (r)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > index 5d3440d719e4..8f5b5664a1b6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > @@ -315,7 +315,8 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
> >   			    u64 *gpu_addr, void **cpu_addr);
> >   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
> >   			       uint64_t offset, uint64_t size,
> > -			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
> > +			       struct amdgpu_bo **bo_ptr,
> > +			       u64 *gpu_addr, void **cpu_addr);
> >   int amdgpu_bo_create_user(struct amdgpu_device *adev,
> >   			  struct amdgpu_bo_param *bp,
> >   			  struct amdgpu_bo_user **ubo_ptr);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index 7c6dd3de1867..a210c243dac0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1619,7 +1619,7 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
> >   					  adev->mman.fw_vram_usage_start_offset,
> >   					  adev->mman.fw_vram_usage_size,
> >   					  &adev->mman.fw_vram_usage_reserved_bo,
> > -					  &adev->mman.fw_vram_usage_va);
> > +					  NULL, &adev->mman.fw_vram_usage_va);
> >   }
> >   /**
> > @@ -1644,7 +1644,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
> >   					  adev->mman.drv_vram_usage_start_offset,
> >   					  adev->mman.drv_vram_usage_size,
> >   					  &adev->mman.drv_vram_usage_reserved_bo,
> > -					  &adev->mman.drv_vram_usage_va);
> > +					  NULL, &adev->mman.drv_vram_usage_va);
> >   }
> >   /*
> > @@ -1729,8 +1729,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
> >   		ret = amdgpu_bo_create_kernel_at(adev,
> >   						 ctx->c2p_train_data_offset,
> >   						 ctx->train_data_size,
> > -						 &ctx->c2p_bo,
> > -						 NULL);
> > +						 &ctx->c2p_bo, NULL, NULL);
> >   		if (ret) {
> >   			DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
> >   			amdgpu_ttm_training_reserve_vram_fini(adev);
> > @@ -1742,7 +1741,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
> >   	if (!adev->gmc.is_app_apu) {
> >   		ret = amdgpu_bo_create_kernel_at(
> >   			adev, adev->gmc.real_vram_size - reserve_size,
> > -			reserve_size, &adev->mman.fw_reserved_memory, NULL);
> > +			reserve_size, &adev->mman.fw_reserved_memory, NULL, NULL);
> >   		if (ret) {
> >   			DRM_ERROR("alloc tmr failed(%d)!\n", ret);
> >   			amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
> > @@ -1885,14 +1884,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >   		r = amdgpu_bo_create_kernel_at(adev, 0,
> >   					       adev->mman.stolen_vga_size,
> >   					       &adev->mman.stolen_vga_memory,
> > -					       NULL);
> > +					       NULL, NULL);
> >   		if (r)
> >   			return r;
> >   		r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
> >   					       adev->mman.stolen_extended_size,
> >   					       &adev->mman.stolen_extended_memory,
> > -					       NULL);
> > +					       NULL, NULL);
> >   		if (r)
> >   			return r;
> > @@ -1901,7 +1900,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >   					       adev->mman.stolen_reserved_offset,
> >   					       adev->mman.stolen_reserved_size,
> >   					       &adev->mman.stolen_reserved_memory,
> > -					       NULL);
> > +					       NULL, NULL);
> >   		if (r)
> >   			return r;
> >   	} else {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > index 41aa853a07d2..b93b42b916ce 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -397,7 +397,7 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
> >   		 */
> >   		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
> >   					       AMDGPU_GPU_PAGE_SIZE,
> > -					       &bo, NULL))
> > +					       &bo, NULL, NULL))
> >   			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
> >   		data->bps_bo[i] = bo;
> 
