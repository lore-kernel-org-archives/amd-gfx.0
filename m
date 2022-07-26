Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435C3C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 00:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4789B11309B;
	Tue, 26 Jul 2022 00:41:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1341113066
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 00:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsqMxAUwLpZgqPASuWHvcI7JK/SoN1R2DYOqhwN2DRGvs1bXSeD81I1d4DCKsYtL4oR3W0cOewRVBh4Catx39xmYU+UUhJK/q50cuVFRX9Lw2OwcaR8iccsF/BoYr0PeLp0UPom63sFHacQZ1WjK/5GDspw3vcco7ePmkOCjCMUQVNUg087p2YPYDwF+8QINA8LJFHDh4jsv6B7AUKiDVNopakzcQLLGQHgsvJChZvTr3EaLfLYi9jfsu83vg3Cqt+ZtpQCL4L/0+1t/i5607pXoyOrs/3AteLD5bMFdKgErBNt91t3IOdZlBRB/EXGYNHSsL2YSCmDK/dqg6pK49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfpB9LN+pfe99lCjOt/Jh2AhkatJ3QdnPlzW523eOXY=;
 b=fclh5D1v6goGs255/Rn7n/2Dt+nLFOi+DuHKdGJV8s10VuMWtT/0sHOsbYzK338UtunDwyRhmmSUFTjqO6gwCekplqNMULLZswBFYldNKwOJasVZK7V5nizoGG3eeOE1+sF4ozLxxMhhF6wWNtvd3t3A8zcGHQ09Y8MRrwxORv++FDO/YIwTfN901fCIjkIbzmn2syB2r2ESRzheB3DUtqM3n8f8cBKupsQg/Uj2HRWAaUqE0Xto+Wbr7qVqXOdvT9Lq2vLeG5RqdWlHxVq3xQU7Ibio/f6pnQ0vhYarhd/MFvHhAXqOkq6/rqpYtUCfAauEd81sHOl73j7le9xPdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfpB9LN+pfe99lCjOt/Jh2AhkatJ3QdnPlzW523eOXY=;
 b=dHuJaqE2cgK+zQJWmX6SDmNlomStMQM+x0h5JsBfN6JUAmnP25sGT2w24YxDtUCw6dLIS3Lt0KCC9J5qs6rIa+4dKrKW9sw931MUlXj9AfyW9vOajYXLCp0p2Hamj/bMkGBcuWFE6OA5JW3+GPhlXHMCDktLL5qy4u4L+3LDemo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.20; Tue, 26 Jul 2022 00:40:58 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::fd31:9d15:8b1c:3a09]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::fd31:9d15:8b1c:3a09%7]) with mapi id 15.20.5458.019; Tue, 26 Jul 2022
 00:40:58 +0000
Date: Tue, 26 Jul 2022 08:40:49 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH 2/3] drm/amdkfd: refine the gfx BO based dmabuf handling
Message-ID: <Yt84EdsZe/2QCneC@lang-desktop>
References: <20220725103205.2085630-1-Lang.Yu@amd.com>
 <20220725103205.2085630-2-Lang.Yu@amd.com>
 <3ea7d3b9-266f-d9b1-f6d5-d998a5e6e2c9@amd.com>
 <Yt8yHSREAp6sRK+K@lang-desktop>
 <9548e049-8567-7479-7939-4cd12e856153@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9548e049-8567-7479-7939-4cd12e856153@amd.com>
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69d615a3-ea96-4f63-ebfb-08da6e9f818d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FD8NHGVbNBtOIMGWonPq6YFGQ8KFNr7GiKRTqBkiZHSuDORLdYd6N5jUkdoDA0pWBmjdE+UoenNhX5WtqHD7NaCEn++d5cbKSBVCuS8Gh+Kaan1tOz2A3Ok+L3ZcaZaLeYkb64zGWT21ycGE6MSEdLetOQwZdXLILEA+fr5mxRRxORPJJb1c/LqEYbLdM/jdCbP24+AipD1uZ9AFwNxw6erIJBoISlwYQIk7/+R9Cs6KjJGtkv4cOP7qGWLXp0bDJkXOsQ4FWhVHA5NQb1B4RXIq/wASXE1wjUkh5GWUGXicUJNZ5HZAAmBIBZZaVyakMZ9bsJCujZ9UHpvBAfVxNP+8x0Bm4GClDs0XVAANS6OfEsWgYTq+l04Q/FtkgX80/rCLNs+BkIAWhEgY9fEMk7BsuGMDaqbFUO8d1mHq2nd8oegA0EfH4qo+sY8e/kFqrk5dgEXxrglvG5amkH2pJibgEX6ASDhVlyRN/lmWHEyJgSHnN2FTg0gFLu9n+gfYty/hr/VTWsyNY0oOAXNsqZ5LdpVAVEHiEOeOCbddJlUYov8GgIKg1xdUa7IdljYi51pD7AG1ana8WPGQqivws2DINvsG2J1sHEcSfG1MpSPaQ2O1SAM7kPaf30uSm4kVnAXHTWO+l7iwbWWshzP8ZImIzBMvkouDcVXhbuaGUh4NsWfQFM/8sR3ZB4zTFOmyymY+rmJV0ES7aQ4F4O1DP5ul9hl6EfFlRZCVmpMS/hgW0r3VK+rPuC9KLCd+iodD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(7916004)(39860400002)(376002)(366004)(346002)(396003)(136003)(8936002)(33716001)(478600001)(5660300002)(6862004)(6486002)(26005)(186003)(6512007)(6506007)(9686003)(6666004)(83380400001)(41300700001)(54906003)(6636002)(38100700002)(66946007)(2906002)(4326008)(86362001)(8676002)(66556008)(316002)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CY50qzjy275s5kM1RAacJ2QIqpIDMxd8mhkk4+VFulBGL5/oy6LWOdbZhw?=
 =?iso-8859-1?Q?TFtAdCnG667oSGyhahnTnzatx8t0GUxXMRSl4M1RT0nPMnxpXcwxLeBwPc?=
 =?iso-8859-1?Q?BNbNVcBu6teycWng5whu6vNDB5jdaxk0V7CMFCXnz7F5xZmr2akme47wYK?=
 =?iso-8859-1?Q?Nq+eSeQdS+OXFL1c2pXe2HWD9/JgbSUO6AAqjUssDFuAWSrJGLwCNGCHUA?=
 =?iso-8859-1?Q?3pEsoNgr4jHHLfhF6gBcGFd2e5aEklDcfUMABZEM+gBYTKYvgtGBkY3xTO?=
 =?iso-8859-1?Q?fUduAyiROJDsT7MggHayk3gvw+qwa0wE2vZyfzuSpLMkB7KXD8dGnJoZZM?=
 =?iso-8859-1?Q?Fonp7XgEi1rFgnsT8x6Bh9uGDoAH2eXOPgYU9dLOcldAuD2sYOSQlSSRUB?=
 =?iso-8859-1?Q?DJ7AwCXhjEJxemvNzRm/a4NDX/txUey7W6BzB3m7Z6B60T9tifr8C4+tiR?=
 =?iso-8859-1?Q?mrI0EUInss2f3YydbctlkNQ7FiLG53+uYNQgjM8G+82iBgWQ8OVXALnQMO?=
 =?iso-8859-1?Q?7IlLSUKztwPmcpuaZk3Aqz4W2yJ0yN2k03X6XnjHFbWobZvM0xDkBugC4a?=
 =?iso-8859-1?Q?+fYwj5RmwgdsyXoJNOo4RO3JW8sSc9zlbQg4XpC7Ypb+CYG6LmryFfxG78?=
 =?iso-8859-1?Q?b5GfaryRScJK0FchtK4zb/vCMUGZgactws7Iln4iUsmypHWVXYcdsGMexH?=
 =?iso-8859-1?Q?537OVMkHNXL3uiBz9FidJ58kyATSe+GHShodPdYtlI1e+pdLgoQzIy+Am0?=
 =?iso-8859-1?Q?fWNHFuNRXWgTLy4oAaZSw2kll5FnoLge5yf60MFcgdprSHM2QZBYfgoW8P?=
 =?iso-8859-1?Q?YXMZg2O1b81DYoMfVl0redvnfArLqi2y+EVW7oqkZzIhM0Gm9rrvYr1LHZ?=
 =?iso-8859-1?Q?IU5d09m/0zAJQEMTlyd1kSkHKhdRR4iR/qB7uTzhYErV/DvYBPS5Dp5fsj?=
 =?iso-8859-1?Q?UzprmP+MJPHPLG70qsXZ9VSWlM0DXYwqzKgzoKM82aA9TRg0sqLd5hYJcG?=
 =?iso-8859-1?Q?GJiCK3oZFb8ZSFdIH+oRb5MLqeeNUzer0OLQFwdlkbdgHRLt5WewaqR1yr?=
 =?iso-8859-1?Q?PuiPjCobZ8B6HVSyNvIak6SCuA1Y4kLoEtLa5nrC/LIL9kO4YalWC6hTnJ?=
 =?iso-8859-1?Q?B/MZxubAYPIHir/gzTpA+jcmGxrp2Vye9Sz+6h3v2XvvijGotTihkgSSDA?=
 =?iso-8859-1?Q?kQfMAJfXnBxGjRtH2V8JLfPAewURQ2Qn9RpsSxZa6yP02QLfFSgBZxbXbd?=
 =?iso-8859-1?Q?4VB1aqKpVUBg2fhA1hZlXFgWf040cF6F7DRqEPvuRm+o3pKuiczWLt/xWv?=
 =?iso-8859-1?Q?IMTs3qgLF4NeAM9EKy3PQiMcCt0i7UOYfbek2qNP126DDsfiSnBW5GIref?=
 =?iso-8859-1?Q?nmCgLQnEmOUhFY1YwSfpjFOFR9FBqap+sXshyNYkjDIRo4xu/wJPOMbLjB?=
 =?iso-8859-1?Q?v6ce3aC2xYp0b89jkY+uzj7oAfSDapeuZl2C2x6nK1eZMroaaSUJa/TSwZ?=
 =?iso-8859-1?Q?nA3Z5RsDAbiMQ6G2GUjDXjHgPMJEFPspzaBzaCtlt+4KHN7CbhFrRtj+3o?=
 =?iso-8859-1?Q?vhMKY9ktRPabNTfdWIEcdj/yLYOOeI0nTtIFy6SpQ85+T4aMLEknNcJOVo?=
 =?iso-8859-1?Q?CJeo2gA1TTyzU6rlXaHEr8BQxxf1+m/7gk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d615a3-ea96-4f63-ebfb-08da6e9f818d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 00:40:58.0638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drDefhPmstkgXFaBOzObr2rV+Q13vf1PSdZmxrTS3NzRm312AfxdJwTSx4r+9cwdjp0YaXFuClXyD1fwYy7xwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 07/25/ , Felix Kuehling wrote:
> Am 2022-07-25 um 20:15 schrieb Lang Yu:
> > On 07/25/ , Felix Kuehling wrote:
> > > Am 2022-07-25 um 06:32 schrieb Lang Yu:
> > > > We have memory leak issue in current implenmention, i.e.,
> > > > the allocated struct kgd_mem memory is not handled properly.
> > > > 
> > > > The idea is always creating a buffer object when importing
> > > > a gfx BO based dmabuf.
> > > > 
> > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > ---
> > > >    .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 99 +++++++++++++------
> > > >    1 file changed, 70 insertions(+), 29 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > index b3806ebe5ef7..c1855b72a3f0 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > @@ -225,7 +225,8 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
> > > >    	u32 alloc_flags = bo->kfd_bo->alloc_flags;
> > > >    	u64 size = amdgpu_bo_size(bo);
> > > > -	unreserve_mem_limit(adev, size, alloc_flags);
> > > > +	if (!bo->kfd_bo->is_imported)
> > > > +		unreserve_mem_limit(adev, size, alloc_flags);
> > > >    	kfree(bo->kfd_bo);
> > > >    }
> > > > @@ -784,6 +785,24 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
> > > >    	}
> > > >    }
> > > > +static struct drm_gem_object*
> > > > +amdgpu_amdkfd_import(struct drm_device *dev, struct dma_buf *dma_buf)
> > > > +{
> > > > +	struct drm_gem_object *gobj;
> > > > +	struct amdgpu_bo *abo;
> > > > +
> > > > +	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
> > > I'd rather remove this limitation. We should be able to use any DMABuf with
> > > KFD. This check was added when we basically sidestepped all the dmabuf
> > > attachment code and just extracted the amdgpu_bo ourselves. I don't think we
> > > want to keep doing that.
> > This limitation here is to just reference the gobj if it is an amdgpu bo
> > and from same device instead of creating a gobj when importing a dmabuf.
> > 
> > > Please see my patch "[PATCH v2 1/2] drm/amdgpu: Generalize KFD dmabuf
> > > import" sent to amd-gfx on March 16. I'm about to send an updated version of
> > > this as part of upstream RDMA support soon.
> > The "drm/amdgpu: Generalize KFD dmabuf import" doesn't handle the struct kgd_mem
> > memory leak issue. Looking forward to the updated version. Thanks!
> 
> Maybe we're trying to fix different problems. Can you give a more detailed
> explanation of the memory leak you're seeing? It's not obvious to me.

The struct kgd_mem is allocted by "*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);",
but it is not assigned to bo->kfd_bo like this "bo->kfd_bo = *mem;". Then *mem will 
never be freed.

Regards,
Lang

> The problem I'm trying to solve is, to ensure that each exported BO only has
> a single dmabuf because we run into problems with GEM if we have multiple
> dmabufs pointing to the same GEM object. That also enables re-exporting
> dmabufs of imported BOs. At the same time I'm removing any limitations of
> the types of BOs we can import, and trying to eliminate any custom dmabuf
> handling in KFD.
> 
> Regards,
>   Felix
> 
> 
> > 
> > Regards,
> > Lang
> > 
> > > Regards,
> > >    Felix
> > > 
> > > 
> > > > +		gobj = dma_buf->priv;
> > > > +		abo = gem_to_amdgpu_bo(gobj);
> > > > +		if (gobj->dev == dev && abo->kfd_bo) {
> > > > +			drm_gem_object_get(gobj);
> > > > +			return gobj;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return amdgpu_dma_buf_create_obj_and_attach(dev, dma_buf);
> > > > +}
> > > > +
> > > >    static int
> > > >    kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
> > > >    		      struct amdgpu_bo **bo)
> > > > @@ -802,7 +821,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
> > > >    		}
> > > >    	}
> > > > -	gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
> > > > +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), mem->dmabuf);
> > > >    	if (IS_ERR(gobj))
> > > >    		return PTR_ERR(gobj);
> > > > @@ -1805,12 +1824,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> > > >    {
> > > >    	struct amdkfd_process_info *process_info = mem->process_info;
> > > >    	unsigned long bo_size = mem->bo->tbo.base.size;
> > > > +	bool is_imported = false;
> > > > +	struct drm_gem_object *imported_gobj;
> > > >    	struct kfd_mem_attachment *entry, *tmp;
> > > >    	struct bo_vm_reservation_context ctx;
> > > >    	struct ttm_validate_buffer *bo_list_entry;
> > > >    	unsigned int mapped_to_gpu_memory;
> > > >    	int ret;
> > > > -	bool is_imported = false;
> > > >    	mutex_lock(&mem->lock);
> > > > @@ -1885,7 +1905,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> > > >    	}
> > > >    	/* Free the BO*/
> > > > -	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> > > > +	if (!is_imported) {
> > > > +		drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> > > > +	} else {
> > > > +		imported_gobj = mem->dmabuf->priv;
> > > > +		drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
> > > > +	}
> > > > +
> > > >    	if (mem->dmabuf)
> > > >    		dma_buf_put(mem->dmabuf);
> > > >    	mutex_destroy(&mem->lock);
> > > > @@ -2249,62 +2275,77 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
> > > >    				      uint64_t *mmap_offset)
> > > >    {
> > > >    	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
> > > > -	struct drm_gem_object *obj;
> > > > -	struct amdgpu_bo *bo;
> > > > +	struct drm_gem_object *imported_gobj, *gobj;
> > > > +	struct amdgpu_bo *imported_bo, *bo;
> > > >    	int ret;
> > > > -	if (dma_buf->ops != &amdgpu_dmabuf_ops)
> > > > -		/* Can't handle non-graphics buffers */
> > > > +	/*
> > > > +	 * Can't handle non-graphics buffers and
> > > > +	 * buffers from other devices
> > > > +	 */
> > > > +	imported_gobj = dma_buf->priv;
> > > > +	if (dma_buf->ops != &amdgpu_dmabuf_ops ||
> > > > +	    drm_to_adev(imported_gobj->dev) != adev)
> > > >    		return -EINVAL;
> > > > -	obj = dma_buf->priv;
> > > > -	if (drm_to_adev(obj->dev) != adev)
> > > > -		/* Can't handle buffers from other devices */
> > > > +	/* Only VRAM and GTT BOs are supported */
> > > > +	imported_bo = gem_to_amdgpu_bo(imported_gobj);
> > > > +	if (!(imported_bo->preferred_domains &
> > > > +	    (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)))
> > > >    		return -EINVAL;
> > > > -	bo = gem_to_amdgpu_bo(obj);
> > > > -	if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
> > > > -				    AMDGPU_GEM_DOMAIN_GTT)))
> > > > -		/* Only VRAM and GTT BOs are supported */
> > > > -		return -EINVAL;
> > > > +	ret = drm_vma_node_allow(&imported_gobj->vma_node, drm_priv);
> > > > +	if (ret)
> > > > +		return ret;
> > > > -	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> > > > -	if (!*mem)
> > > > -		return -ENOMEM;
> > > > +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), dma_buf);
> > > > +	if (IS_ERR(gobj)) {
> > > > +		ret = PTR_ERR(gobj);
> > > > +		goto err_import;
> > > > +	}
> > > > -	ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
> > > > -	if (ret) {
> > > > -		kfree(mem);
> > > > -		return ret;
> > > > +	bo = gem_to_amdgpu_bo(gobj);
> > > > +	bo->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
> > > > +
> > > > +	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> > > > +	if (!*mem) {
> > > > +		ret = -ENOMEM;
> > > > +		goto err_alloc_mem;
> > > >    	}
> > > >    	if (size)
> > > > -		*size = amdgpu_bo_size(bo);
> > > > +		*size = amdgpu_bo_size(imported_bo);
> > > >    	if (mmap_offset)
> > > > -		*mmap_offset = amdgpu_bo_mmap_offset(bo);
> > > > +		*mmap_offset = amdgpu_bo_mmap_offset(imported_bo);
> > > >    	INIT_LIST_HEAD(&(*mem)->attachments);
> > > >    	mutex_init(&(*mem)->lock);
> > > >    	(*mem)->alloc_flags =
> > > > -		((bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> > > > +		((imported_bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> > > >    		KFD_IOC_ALLOC_MEM_FLAGS_VRAM : KFD_IOC_ALLOC_MEM_FLAGS_GTT)
> > > >    		| KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
> > > >    		| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
> > > > -	drm_gem_object_get(&bo->tbo.base);
> > > > +	get_dma_buf(dma_buf);
> > > > +	(*mem)->dmabuf = dma_buf;
> > > >    	(*mem)->bo = bo;
> > > >    	(*mem)->va = va;
> > > > -	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> > > > -		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
> > > > +	(*mem)->domain = AMDGPU_GEM_DOMAIN_GTT;
> > > >    	(*mem)->mapped_to_gpu_memory = 0;
> > > >    	(*mem)->process_info = avm->process_info;
> > > >    	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
> > > >    	amdgpu_sync_create(&(*mem)->sync);
> > > >    	(*mem)->is_imported = true;
> > > > +	bo->kfd_bo = *mem;
> > > >    	return 0;
> > > > +err_import:
> > > > +	drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
> > > > +err_alloc_mem:
> > > > +	drm_gem_object_put(gobj);
> > > > +	return ret;
> > > >    }
> > > >    /* Evict a userptr BO by stopping the queues if necessary
