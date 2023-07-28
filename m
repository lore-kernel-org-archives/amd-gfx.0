Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9DBC0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 08:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 238FF10E689;
	Fri, 28 Jul 2023 08:10:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07CAC10E688
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 08:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoju9AkwmQYzvBUB4iPn2zRg+mY6Ja0PMnKW1akVA2ATMIpoAcBsxtMgKn4DLHScaluq4b+yR2Rnsd+mj9mQzBMOLvAqw+GgQhZTqa4okFJpRMIg4wOKvtMe07vvoywarqJRt1Nji1sNRvmklPE+0eN+hyYFpEeVvq8uOumPDwRyxrMRt8v668FNs7igS3GUNiIvMkGaXBwiY9WWpwtP80CzGsAFEGg/WIgSfUb3s4yPPW+57LLiUdOB8JW8YA8zRmSpojegjxsAmpx9WpWXcAJo4wRg7bPvgtLmnbVjUDOBJiGcqtpth8QkwEPfCwHyIEwuRkrsAyWCWrUMa2UkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Jq/7eqs6smJgCM6j0/x7D3AyOMQyp9VBCslTnSXPzo=;
 b=ho3caU+CWL6aRWPs32XpvKtGN3mFpsvBttjxWYYmfzDW6CbsrpgdV/+pivK4r8tJ2YF8OW9LF6o9Sk2UtWjHJrQfvP8EThqIK336gPY6M1s7F6az5ZM3B+eRh4H3jy/SvfT3UjDAHTKFWuPEeI8nVGQf1y0464ZgIPwKGybFo4IjcKwTk5i0Q3KiIVddOhnUJlSMllEOdqKuobVK66C9RrJRdvyBh/bnHEn1CRzo+M/rL1jqA1zhJXbtWUHZVADOBT+jtUUVY1ToXK8tm5P8IU+6jSjM1PiNuF294bpT++YMKK5c0GqY66zd4UpwKmpx2jOIZ9Wy5yreQPAaslXj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Jq/7eqs6smJgCM6j0/x7D3AyOMQyp9VBCslTnSXPzo=;
 b=5rG4PTEv+5snbn2zDbX0noNtBUzvxGCzSCigRr7ESoQXveOwH3hybd2qUBxiRVJkPfpsJmoApoIKGMhVT7++Bs5FS+tuPjnmNhk5sSqrSS8Mn/hlC6tgkbJn931SYIYJlCoUqvFYeZJ5L0DqWVg732TgLxrbxMm7O50PxNoxV2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 08:10:45 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:10:45 +0000
Date: Fri, 28 Jul 2023 16:10:35 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
Message-ID: <ZMN3+9iamg/hfUX5@lang-desktop>
References: <20230728060405.939785-1-Lang.Yu@amd.com>
 <b824e5ec-e383-b656-b1ef-543f31628092@amd.com>
 <c4f01c81-f173-ea9e-e9d4-3b9844c5817c@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4f01c81-f173-ea9e-e9d4-3b9844c5817c@amd.com>
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|SA0PR12MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: a0af8c23-0f1e-4722-2221-08db8f4224ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDesXGgWjU4TcdtSlqBsUUHBq+e8w2VpsXFhUTGJXYIZeKgT0BtS52VFjZbB61k1HyYGs3Vya/c4YUIS2WOuImrKdXMxxKqqeo85SucdN3gRDU8myqvBde3kBHG8s16Ge+mMFBqTiu2ImnF1oDrH8I2ZShItORaguJWYRvPOFTCA3C64NNeUL6VB7luBYrZpMG9ChQ9ugarH5vyoyNah8jn/oaHQ928P0sLZPrHkLwIH2dtacuhXFTQZJrnTeeOGPxpZS/3QeNOJyoQFWaA7Xl3WHR2hIA3p5DAYFuEMnlH9RFbf71O3s1YgLLdfoaUfxkDpfnaPYCkS5zhZSE/hm726kGLx8SugmnrkmZjrA/EhwQTPh3HYGWGjeuA89LzT/7rLHSEGuujGGnZLongmAj8z/iTUQliK2z8pIEXkFLS1nLMswhvUm5Aijr6PblvvfT/ETeqDyWgWxC+xFG67h/82XxYVKBbK6TV2ecDWO/cRiyEUeleZk4vjKmdH9U5bPeBzpl4zhoYJ2wMA0TcGjRS1BZQ8yi6Cm/eAx8E4qNJ90x6uNS/PLjhwsY3K8Ig2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(6862004)(2906002)(6506007)(26005)(186003)(316002)(38100700002)(66574015)(83380400001)(53546011)(66946007)(66556008)(5660300002)(41300700001)(66476007)(8676002)(6636002)(8936002)(6486002)(478600001)(6666004)(4326008)(9686003)(6512007)(33716001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fY0VZq4dpEDn1cMCCUa3ZRLjfK5mvzUPwXZ15OuDIZgvkybp7lk+M4T1qm?=
 =?iso-8859-1?Q?7ukvdNGeVaXvrZzhHfb1A57zig9I55NwecGYx54qMSw3ytKijPakw4h/U8?=
 =?iso-8859-1?Q?DaBf2OtBfF+6UXQexjqotdHBISkM9rhhSopeN0g0vkobQ3DJWu83xruzYG?=
 =?iso-8859-1?Q?OyqczBfOwYtRmp5hQ+aggRq7mWopYnhmIO5dok5c+EtzNoZQFBK9wsXVwu?=
 =?iso-8859-1?Q?P5Md61Tdy0BWmVvAgZ1x7lw8Z+/0Ss6ONdeT4/07VSCgBi0V1CJWzqS7rV?=
 =?iso-8859-1?Q?Y99Tpria7Ar1ha11qgaSwob76PL/0oBbCyAmQjjFEJi1oYyqkcpUwk8DKg?=
 =?iso-8859-1?Q?J133j9/8UbAizPzEA66S9moq4bFpTSt5PGiDGuRnyQkaN5chq2jgtAsGiN?=
 =?iso-8859-1?Q?lwXugFYu//Q5wtOwcYyz8ZhAK4Upnrdij4E56iIzjoDqaBtK06o7nCrs/d?=
 =?iso-8859-1?Q?gi0jf/i1d+e4ZcfOZsbtbY5T/fdSCjXNY8Tg487oURkA1fkS3shSo5VAVV?=
 =?iso-8859-1?Q?Rn3+7HOLBAAMhECVgmps52KFvpgyCd9Pb8zdatX8LLXuc35jYZaHTCx+JT?=
 =?iso-8859-1?Q?VhvnGxhOXS8s25opoHb1+Wf+zhbv2mabRevE4Jh2dWRTYQEqkCPESVv+yM?=
 =?iso-8859-1?Q?pzxTMWAuguM/cDW+qs6rdJHalJBVfMM6IppEthAzHbcIIeXjW2tHuI9uvD?=
 =?iso-8859-1?Q?C6I+VLPrbahdlE3ta2BC42whxNxM6gwx3JyXF0Cq6m+bc+XyQC19LOuiMF?=
 =?iso-8859-1?Q?4uMtyj/xVdYoIOfn6l8gwQnDP1WTELCTf1j9cwC9c34kQUWfAOpMhs6+Rm?=
 =?iso-8859-1?Q?KIeshfbWXFVk1NMZ7u82IVQlRH/5VzPt8tFwEYk2VuMFZ8A3rZf4J+Sysb?=
 =?iso-8859-1?Q?5YnZMzTBkQ0N+eWWJUXy8FkZF4uSnR+As2x6G9h1ycta+WOY5HwYzw47wc?=
 =?iso-8859-1?Q?juMXCi68lQLzYIHtx9CIPvL5JBt87UELq2I+OOPwj7XaYoXqnSO6imzudS?=
 =?iso-8859-1?Q?4nnxiOMhGNgTXdvkyJV8Ucm83WpUJ0tEbXORH77agPQzhWDwcHKI9X1U9B?=
 =?iso-8859-1?Q?1YVSwRNZvMM7niz4WXV58d0755ajLn2UJvMwio9T4oqJQU1gWtQy7zTI4T?=
 =?iso-8859-1?Q?abJ6nRxYOUskaEUp1uluE4FlQlBlXTxddiwXqaYgquNYe7XpBNuf+DFvpY?=
 =?iso-8859-1?Q?PQ7RFiz8aF7e1Jaa4kyYFI3TXbE8PTp4a3hopHGrMwP5989QRZ1FdoJUas?=
 =?iso-8859-1?Q?kL7TC/ZWH9jQjdlIQTLCZ9eLJopBBkKCDCgabWCKS5FQBBa0vjR5Rqh26J?=
 =?iso-8859-1?Q?yN5qUFhgF8Oi8lrf96lxF0RWq3Aojh+ypI50Nl3jl/A00xZA2oTD99N5BW?=
 =?iso-8859-1?Q?H+CYInt63lHN420iyk/b1xPIg2IEYOI3afPjPQNpa3TlVXLlw6ypVC+yuM?=
 =?iso-8859-1?Q?25vhd7kuxRlTVPk9eFLvWTF64+5oUk1ck5BHySabaZFFLdu5NKuXF5m5WA?=
 =?iso-8859-1?Q?LxNWQPcAl8UA6m7JyKgQP6yVLWXA9TB59az1jCkJAmLRnWDLavY//yPYaU?=
 =?iso-8859-1?Q?3vkSgeEcEsiJOvTrE4khZ0LE9cEeV/NkzBLUbN73pBcRhBqRR6Qf41MHw2?=
 =?iso-8859-1?Q?OmK5GMTAazng8DioXCX8GrV5C6zZjvhmar?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0af8c23-0f1e-4722-2221-08db8f4224ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 08:10:45.5885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vc/wH4XOFnZLpvTVOFZdMiExki7r8UJEfqSn773k2eX6P3gO1onJYLULRtq3rO4bcgBe+9QyZ4WhgSEIqFDLUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
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
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 07/28/ , Christian König wrote:
> Am 28.07.23 um 09:00 schrieb Lazar, Lijo:
> > 
> > 
> > On 7/28/2023 11:34 AM, Lang Yu wrote:
> > > Use amdgpu_bo_create_reserved() to create a BO in VRAM
> > > domain would fail if requested VRAM size is large(>128MB)
> > > on APU which usually has a default 512MB VRAM.
> > > 
> > > That's because VRAM is framgented after several allocations.
> > > 
> > > The approach is using amdgpu_bo_create_reserved() to
> > > create a BO in CPU domain first, it will always succeed.
> > > 
> > > v2: Don't overwrite the contents at specific offset.
> > > 
> > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 24 ++++++++++++++++------
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 15 +++++++-------
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  2 +-
> > >   4 files changed, 28 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > index ff73cc11d47e..fa30e96f27d0 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > @@ -358,6 +358,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device
> > > *adev,
> > >    * @offset: offset of the BO
> > >    * @size: size of the BO
> > >    * @bo_ptr:  used to initialize BOs in structures
> > > + * @gpu_addr: GPU addr of the pinned BO
> > >    * @cpu_addr: optional CPU address mapping
> > >    *
> > >    * Creates a kernel BO at a specific offset in VRAM.
> > > @@ -367,7 +368,8 @@ int amdgpu_bo_create_kernel(struct amdgpu_device
> > > *adev,
> > >    */
> > >   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
> > >                      uint64_t offset, uint64_t size,
> > > -                   struct amdgpu_bo **bo_ptr, void **cpu_addr)
> > > +                   struct amdgpu_bo **bo_ptr,
> > > +                   u64 *gpu_addr, void **cpu_addr)
> > 
> > A generic question (not considering other details in this patch) - this
> > API is literally asking to create BO at a particular GPU VRAM offset.
> > The offset goes in as the input, so why does it need to return a GPU
> > offset?
> 
> Yeah, that's exactly why I said that the intention of the function was
> misunderstood.
> 
> This change here doesn't seem to make much sense.

Because we have such use case acutally. When creating a TMR BO,
we also acquire it's GPU address. Of course, we can call
amdgpu_bo_gpu_offset(tmr_bo) to acquire it.

Regards,
Lang

> Regards,
> Christian.
> 
> > 
> > Thanks,
> > Lijo
> > 
> > >   {
> > >       struct ttm_operation_ctx ctx = { false, false };
> > >       unsigned int i;
> > > @@ -377,32 +379,42 @@ int amdgpu_bo_create_kernel_at(struct
> > > amdgpu_device *adev,
> > >       size = ALIGN(size, PAGE_SIZE);
> > >         r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
> > > -                      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
> > > -                      cpu_addr);
> > > +                      AMDGPU_GEM_DOMAIN_CPU,
> > > +                      bo_ptr, NULL, NULL);
> > >       if (r)
> > >           return r;
> > >         if ((*bo_ptr) == NULL)
> > >           return 0;
> > >   +    (*bo_ptr)->flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> > > +    (*bo_ptr)->flags |= cpu_addr ?
> > > AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
> > > +        : AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
> > > +
> > >       /*
> > >        * Remove the original mem node and create a new one at the
> > > request
> > >        * position.
> > >        */
> > > -    if (cpu_addr)
> > > -        amdgpu_bo_kunmap(*bo_ptr);
> > > -
> > >       ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);
> > >         for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
> > >           (*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
> > >           (*bo_ptr)->placements[i].lpfn = (offset + size) >> PAGE_SHIFT;
> > > +        (*bo_ptr)->placements[i].mem_type = TTM_PL_VRAM;
> > > +        (*bo_ptr)->placements[i].flags = TTM_PL_FLAG_CONTIGUOUS;
> > > +
> > > +        if (!((*bo_ptr)->flags &
> > > AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED))
> > > +            (*bo_ptr)->placements[i].flags |= TTM_PL_FLAG_TOPDOWN;
> > >       }
> > > +
> > >       r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
> > >                    &(*bo_ptr)->tbo.resource, &ctx);
> > >       if (r)
> > >           goto error;
> > >   +    if (gpu_addr)
> > > +        *gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
> > > +
> > >       if (cpu_addr) {
> > >           r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
> > >           if (r)
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > > index 5d3440d719e4..8f5b5664a1b6 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > > @@ -315,7 +315,8 @@ int amdgpu_bo_create_kernel(struct amdgpu_device
> > > *adev,
> > >                   u64 *gpu_addr, void **cpu_addr);
> > >   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
> > >                      uint64_t offset, uint64_t size,
> > > -                   struct amdgpu_bo **bo_ptr, void **cpu_addr);
> > > +                   struct amdgpu_bo **bo_ptr,
> > > +                   u64 *gpu_addr, void **cpu_addr);
> > >   int amdgpu_bo_create_user(struct amdgpu_device *adev,
> > >                 struct amdgpu_bo_param *bp,
> > >                 struct amdgpu_bo_user **ubo_ptr);
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > > index 7c6dd3de1867..a210c243dac0 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > > @@ -1619,7 +1619,7 @@ static int
> > > amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
> > > adev->mman.fw_vram_usage_start_offset,
> > >                         adev->mman.fw_vram_usage_size,
> > > &adev->mman.fw_vram_usage_reserved_bo,
> > > -                      &adev->mman.fw_vram_usage_va);
> > > +                      NULL, &adev->mman.fw_vram_usage_va);
> > >   }
> > >     /**
> > > @@ -1644,7 +1644,7 @@ static int
> > > amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
> > > adev->mman.drv_vram_usage_start_offset,
> > >                         adev->mman.drv_vram_usage_size,
> > > &adev->mman.drv_vram_usage_reserved_bo,
> > > -                      &adev->mman.drv_vram_usage_va);
> > > +                      NULL, &adev->mman.drv_vram_usage_va);
> > >   }
> > >     /*
> > > @@ -1729,8 +1729,7 @@ static int amdgpu_ttm_reserve_tmr(struct
> > > amdgpu_device *adev)
> > >           ret = amdgpu_bo_create_kernel_at(adev,
> > >                            ctx->c2p_train_data_offset,
> > >                            ctx->train_data_size,
> > > -                         &ctx->c2p_bo,
> > > -                         NULL);
> > > +                         &ctx->c2p_bo, NULL, NULL);
> > >           if (ret) {
> > >               DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
> > >               amdgpu_ttm_training_reserve_vram_fini(adev);
> > > @@ -1742,7 +1741,7 @@ static int amdgpu_ttm_reserve_tmr(struct
> > > amdgpu_device *adev)
> > >       if (!adev->gmc.is_app_apu) {
> > >           ret = amdgpu_bo_create_kernel_at(
> > >               adev, adev->gmc.real_vram_size - reserve_size,
> > > -            reserve_size, &adev->mman.fw_reserved_memory, NULL);
> > > +            reserve_size, &adev->mman.fw_reserved_memory, NULL, NULL);
> > >           if (ret) {
> > >               DRM_ERROR("alloc tmr failed(%d)!\n", ret);
> > > amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
> > > @@ -1885,14 +1884,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> > >           r = amdgpu_bo_create_kernel_at(adev, 0,
> > >                              adev->mman.stolen_vga_size,
> > > &adev->mman.stolen_vga_memory,
> > > -                           NULL);
> > > +                           NULL, NULL);
> > >           if (r)
> > >               return r;
> > >             r = amdgpu_bo_create_kernel_at(adev,
> > > adev->mman.stolen_vga_size,
> > >                              adev->mman.stolen_extended_size,
> > > &adev->mman.stolen_extended_memory,
> > > -                           NULL);
> > > +                           NULL, NULL);
> > >             if (r)
> > >               return r;
> > > @@ -1901,7 +1900,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> > > adev->mman.stolen_reserved_offset,
> > >                              adev->mman.stolen_reserved_size,
> > > &adev->mman.stolen_reserved_memory,
> > > -                           NULL);
> > > +                           NULL, NULL);
> > >           if (r)
> > >               return r;
> > >       } else {
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > > index 41aa853a07d2..b93b42b916ce 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > > @@ -397,7 +397,7 @@ static void amdgpu_virt_ras_reserve_bps(struct
> > > amdgpu_device *adev)
> > >            */
> > >           if (amdgpu_bo_create_kernel_at(adev, bp <<
> > > AMDGPU_GPU_PAGE_SHIFT,
> > >                              AMDGPU_GPU_PAGE_SIZE,
> > > -                           &bo, NULL))
> > > +                           &bo, NULL, NULL))
> > >               DRM_DEBUG("RAS WARN: reserve vram for retired page
> > > %llx fail\n", bp);
> > >             data->bps_bo[i] = bo;
> 
