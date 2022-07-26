Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B263BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 00:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB171120A4;
	Tue, 26 Jul 2022 00:15:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7BC811208B
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 00:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXAu8wTXGOJaDJN6m9gXny/cUu7fuo7JU1MdfTdGI76opZAmOEfw/Dh5cELzYg0wtm8+Gcc/KpqboEUUDByFDvUBxNcZvj02+QZu3WQKXaN+fnxyjnVnnoir/MWNxU2+acDklnQk2I5v+yYtJfRcu1HpifWIQyLBdsIf5tMQLE2GKlB0pwIY/lf1vcJD3yJKM3581FU30O6Yme8Do6isvZcxlo1lBd05uaEPFRng5aqxECFO2PFLAHitonVOUJEGh/a8n3IL6GdkbNoi7LGXgQ/E2FqqojU/3VbMlOP5VRqqvqSLaHg71pC7m62ty8ZGb/6Ik3NHZGX9oV7h/iQg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9PFG0AfBSC+pVgLR3IRApTS6El/KNkqhrQw/14Bf+8=;
 b=RDvIlDVIU7KUVdJnQAvOnu4ryHBNZEU2hRdbbPCEyQ8VDU9qFl8hovYUHvp6iiQYbKIrTeuTBFiv18TErMHTsm5B/U08BC8tp9Pg/7d7YPS96rY5IbKMaIDlWAYLyHzJuoQg9xFLyk2Azdn+koxa1yiAts3ThhbXs6cqos/Uj7Rb+knK/QeetmXMzZH3xEZ2j9zRILSieQ/Uxb4rRpqcrYr3I9oapt5SnjxBX9f3mk3vzF2lAj1dRnxVWNg3SVnTBGQR1YRGI7+MBf00InrnOHNRPJ0hNrahOWPuNR849BqWJwh4Lq/ciOmjqGNTfwE7mV2WGZhA1SxmuJitlqXQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9PFG0AfBSC+pVgLR3IRApTS6El/KNkqhrQw/14Bf+8=;
 b=ReANCaYO/8Z2jgNfxKmL/EjuAw1K7oroiwVU1nB4x2KUhswAvxp+xyNx6j8lgJWehLDH5CHRRKrDmcpFg0e4pd6l5cHH0VyWyXi5Xo8UyCDrbhPUI2w2d8z7CwM3hUTBlFB065TK8eUUhdO3vBukblC2N4XFq1XPSxii776J6po=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BYAPR12MB4775.namprd12.prod.outlook.com (2603:10b6:a03:107::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 00:15:35 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::fd31:9d15:8b1c:3a09]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::fd31:9d15:8b1c:3a09%7]) with mapi id 15.20.5458.019; Tue, 26 Jul 2022
 00:15:34 +0000
Date: Tue, 26 Jul 2022 08:15:25 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH 2/3] drm/amdkfd: refine the gfx BO based dmabuf handling
Message-ID: <Yt8yHSREAp6sRK+K@lang-desktop>
References: <20220725103205.2085630-1-Lang.Yu@amd.com>
 <20220725103205.2085630-2-Lang.Yu@amd.com>
 <3ea7d3b9-266f-d9b1-f6d5-d998a5e6e2c9@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ea7d3b9-266f-d9b1-f6d5-d998a5e6e2c9@amd.com>
X-ClientProxiedBy: SG2PR02CA0123.apcprd02.prod.outlook.com
 (2603:1096:4:188::22) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b5c3e01-9a2c-4609-63a0-08da6e9bf589
X-MS-TrafficTypeDiagnostic: BYAPR12MB4775:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BymjQ4G+NzpxeopZMave/R/t7ZCLcohv2M8dMl3UW/G00vBmeO5ydcG3bbeGrIPykfXyaUZ8DU3l6auLGhfpnR3IZxnZFvLFVfhr05RhlM0QEsbW0WrLFEr/+nr4i6fSr3Dnxgx7054/EaVXejEX8stzud9ZMLlTsMMr/ZL1I9PgZZn/fh4QAjAZbOzDuw1V1MgBmwcJMYR5hwZ9L3IdA6bo9Lz6h1nHo7p+v+n6TnCdHBPojs/KzgEGboBL5Jvp5PiMIdPwHC+ASph/dszJHBw+3YHUS0IYIPhjtbkGsb3jTLlEJED6RolkyiVeiu0cYfHq6cZ7RZT7sXJIwcpKwoKP9di1t75uA3YZ717hWQEUIsIq4v4A7y+XmzfGPYWX53fIiM1ekaDlGPV+2peaEwxQJNsXB1XFNgMhbNtY8kmHyPqjHSJQaUjMiSJO53q9loQXxZUiT03OUgreQxJHpdaX4pBRkN91b3M77np3EgYbR4XkzUgOqJZZ3LzQwz3llVT2IrT0u3KFXVm8mkuDKDde7UeRyjpIFx7u+x6PidefbPWcs09JrC46hXRcaTv/WHr42T/qwUrvHYFX5Qbbq/YBqCdFwdxQ1ReitkuaKuWUVC26DcaQCpOn00rIuX+7Bw9Zazy62ZMbPrFe+8FlU429r9X06xMJ3PjSeS4t+GgwKTKHwm0TRllqXGYa+G/cwAo6J+K/b8RUq6nvrTav1mLEPd15YLlc/cTFE8gLYiaZmiz4zDRxz/Adm1Dsz4+6zrZr444W1WP5PcYDW1SEOdSefl/84todIqO7V+2Hon0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(7916004)(376002)(136003)(366004)(396003)(39860400002)(346002)(33716001)(86362001)(38100700002)(6486002)(478600001)(8936002)(6862004)(5660300002)(316002)(6512007)(54906003)(6636002)(8676002)(66556008)(66946007)(4326008)(186003)(66476007)(83380400001)(6666004)(41300700001)(2906002)(26005)(6506007)(9686003)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8fq81rvRe2YgHdCx9c+JC3u/k1RGGXaE7UIAmpXQCVOZwD5Dd79C/snhRO?=
 =?iso-8859-1?Q?xpk9BydU4Lm+bGawj5Uh9M/ZSY22SrzjYuJcydNGW/0z7UnsrstzC2nXr+?=
 =?iso-8859-1?Q?Mz3usMjF0US8DIqzm2iLI5Q4RLwbCwQZxG+noxSXsjt0xD1RXL1z2MTBHY?=
 =?iso-8859-1?Q?U0xXGvRu4hYkOmlVQTXr2NfPOXZrE4jURq5FtpxgoY+CjK4azpFyjUMjtQ?=
 =?iso-8859-1?Q?ZiWG5StSTzH7/31sEDchTZJOsjquwbDkJaKCafsMWtGZmHXyxXnZrjICLK?=
 =?iso-8859-1?Q?Zmr5MGAn0meQS72YptmuHWiPATUlcg8LRmGaIrBDevsAkBy8wekjU0XDX9?=
 =?iso-8859-1?Q?kbndkqrqg8PCDljkNs9ABi5j31SbnjqA90AoeggEgGYVNsxAnwAM4z3Swx?=
 =?iso-8859-1?Q?YHXyUHxsPV/MbJzqbiUOtr1JuOcizP/6sJ4TudCImYQbZAIS5727J2ehqQ?=
 =?iso-8859-1?Q?am8LXAWFR1KMhHH0RU53u4ZZRJ2Rf5hhtYB2Z1wY5/B9mi3Xwugx0W3Sc5?=
 =?iso-8859-1?Q?r54h1C7bRvMAbJJK420Ct/h4tPP8Fg0ItPF964AVaksTIJJm0b88Wq/1pa?=
 =?iso-8859-1?Q?E39F33KyoraR0KerGNI9Rpp8zG3ZUYz63mP42YfxZkjJqI6NYhvbAok/0k?=
 =?iso-8859-1?Q?tAquudjdvvB3jefxsaa6heFGA1tzeRoT1l+9GrXpzP4HIw9e2CC7s1Gg0h?=
 =?iso-8859-1?Q?nwqicsMjCwiwyCl6H9pbJJQeGvFZOSft5XP2DwpbyxTkJcCJh/SdAMenYc?=
 =?iso-8859-1?Q?NOUYZsRRxJayGx55h8qDcRzymDZOPWJXq2fgiVqbDVHZMRE3NG9B0VEL6M?=
 =?iso-8859-1?Q?9JtRYs3VmQl+suuih4ThTr9Zk+d3+9/YP2Z6OgVmwOeFGgyyY739DgWiVl?=
 =?iso-8859-1?Q?BEr2VtRXouw6UHEX9DuA0Q+m+fK0BbGAqxh6lpTZTaViAm3Fm+VvZIL+Zs?=
 =?iso-8859-1?Q?ZWzHm/UvmBHu4TTWeQ6Gp7imLuHreBXH630pYAEC3YFIgogq6fo/7gR/fs?=
 =?iso-8859-1?Q?1QWPS+FwYPqsBN5at9fBHGxsQYWlAjtWDuxCiMziGWFzXzf7no2AjN0wcU?=
 =?iso-8859-1?Q?QQMR2yd2laQSP2xIaGqsBvb5GYyPBTsMAxrRUTxowc7ZvE1iGq30nJzK5c?=
 =?iso-8859-1?Q?hDFe37wIvnad8ZzJj/Vnu8/t2PHHp+oLJ5c6r3OjDBWhGVHO62bmm60say?=
 =?iso-8859-1?Q?J9UPHTSiSBydnJAkUqQ2XXYPOX0e2pWbXp0jcCQg4Oy7mRIVJbaJBesy07?=
 =?iso-8859-1?Q?VuwEhSrv7EHkFhTjn8kOURajJC2TQeZdbFWivltiRDHIsy+MCdPaKCyfGf?=
 =?iso-8859-1?Q?V/PtTZqzztmL1+iBnMyZGDCM5r5x80Rmr2n4ItHk9lIxHYaBPPFaWjjfRX?=
 =?iso-8859-1?Q?/6YevNmdfZD/8C69aijWVDPS90e3H345yv2L0obdKo/zrVcAnZME7RgR0Y?=
 =?iso-8859-1?Q?ahknWXoiw8CCBxzNhXYPY+WIVgzSR9GKNL0ihizh6ItBOfMIR2xSwFfxaU?=
 =?iso-8859-1?Q?zvpsSu5fdZPpGQBJb5TavAeBJoLKqsEcX1Fw/4MOgOXvNf+xl+b59YZVbs?=
 =?iso-8859-1?Q?qtX1BhCCSTxns43QYxyBJCJP4dXdvclxsWavkvYIBm/Ex8ge4egrMMJ/pW?=
 =?iso-8859-1?Q?2LNA5oFd5QSJ71eCCFU4Dgj4WvWCPoBbhM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5c3e01-9a2c-4609-63a0-08da6e9bf589
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 00:15:34.7566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3vKSwQ1h9bDVcSVimrGnhZxziq/vkYY77iw+y4dxm4JGH0eWLBKA8MzbOfG3Db99Qm6yoOh3leiu+teEFD/4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4775
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
> 
> Am 2022-07-25 um 06:32 schrieb Lang Yu:
> > We have memory leak issue in current implenmention, i.e.,
> > the allocated struct kgd_mem memory is not handled properly.
> > 
> > The idea is always creating a buffer object when importing
> > a gfx BO based dmabuf.
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 99 +++++++++++++------
> >   1 file changed, 70 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index b3806ebe5ef7..c1855b72a3f0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -225,7 +225,8 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
> >   	u32 alloc_flags = bo->kfd_bo->alloc_flags;
> >   	u64 size = amdgpu_bo_size(bo);
> > -	unreserve_mem_limit(adev, size, alloc_flags);
> > +	if (!bo->kfd_bo->is_imported)
> > +		unreserve_mem_limit(adev, size, alloc_flags);
> >   	kfree(bo->kfd_bo);
> >   }
> > @@ -784,6 +785,24 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
> >   	}
> >   }
> > +static struct drm_gem_object*
> > +amdgpu_amdkfd_import(struct drm_device *dev, struct dma_buf *dma_buf)
> > +{
> > +	struct drm_gem_object *gobj;
> > +	struct amdgpu_bo *abo;
> > +
> > +	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
> 
> I'd rather remove this limitation. We should be able to use any DMABuf with
> KFD. This check was added when we basically sidestepped all the dmabuf
> attachment code and just extracted the amdgpu_bo ourselves. I don't think we
> want to keep doing that.

This limitation here is to just reference the gobj if it is an amdgpu bo
and from same device instead of creating a gobj when importing a dmabuf.

> Please see my patch "[PATCH v2 1/2] drm/amdgpu: Generalize KFD dmabuf
> import" sent to amd-gfx on March 16. I'm about to send an updated version of
> this as part of upstream RDMA support soon.

The "drm/amdgpu: Generalize KFD dmabuf import" doesn't handle the struct kgd_mem
memory leak issue. Looking forward to the updated version. Thanks!

Regards,
Lang

> Regards,
>   Felix
> 
> 
> > +		gobj = dma_buf->priv;
> > +		abo = gem_to_amdgpu_bo(gobj);
> > +		if (gobj->dev == dev && abo->kfd_bo) {
> > +			drm_gem_object_get(gobj);
> > +			return gobj;
> > +		}
> > +	}
> > +
> > +	return amdgpu_dma_buf_create_obj_and_attach(dev, dma_buf);
> > +}
> > +
> >   static int
> >   kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
> >   		      struct amdgpu_bo **bo)
> > @@ -802,7 +821,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
> >   		}
> >   	}
> > -	gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
> > +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), mem->dmabuf);
> >   	if (IS_ERR(gobj))
> >   		return PTR_ERR(gobj);
> > @@ -1805,12 +1824,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> >   {
> >   	struct amdkfd_process_info *process_info = mem->process_info;
> >   	unsigned long bo_size = mem->bo->tbo.base.size;
> > +	bool is_imported = false;
> > +	struct drm_gem_object *imported_gobj;
> >   	struct kfd_mem_attachment *entry, *tmp;
> >   	struct bo_vm_reservation_context ctx;
> >   	struct ttm_validate_buffer *bo_list_entry;
> >   	unsigned int mapped_to_gpu_memory;
> >   	int ret;
> > -	bool is_imported = false;
> >   	mutex_lock(&mem->lock);
> > @@ -1885,7 +1905,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> >   	}
> >   	/* Free the BO*/
> > -	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> > +	if (!is_imported) {
> > +		drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> > +	} else {
> > +		imported_gobj = mem->dmabuf->priv;
> > +		drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
> > +	}
> > +
> >   	if (mem->dmabuf)
> >   		dma_buf_put(mem->dmabuf);
> >   	mutex_destroy(&mem->lock);
> > @@ -2249,62 +2275,77 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
> >   				      uint64_t *mmap_offset)
> >   {
> >   	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
> > -	struct drm_gem_object *obj;
> > -	struct amdgpu_bo *bo;
> > +	struct drm_gem_object *imported_gobj, *gobj;
> > +	struct amdgpu_bo *imported_bo, *bo;
> >   	int ret;
> > -	if (dma_buf->ops != &amdgpu_dmabuf_ops)
> > -		/* Can't handle non-graphics buffers */
> > +	/*
> > +	 * Can't handle non-graphics buffers and
> > +	 * buffers from other devices
> > +	 */
> > +	imported_gobj = dma_buf->priv;
> > +	if (dma_buf->ops != &amdgpu_dmabuf_ops ||
> > +	    drm_to_adev(imported_gobj->dev) != adev)
> >   		return -EINVAL;
> > -	obj = dma_buf->priv;
> > -	if (drm_to_adev(obj->dev) != adev)
> > -		/* Can't handle buffers from other devices */
> > +	/* Only VRAM and GTT BOs are supported */
> > +	imported_bo = gem_to_amdgpu_bo(imported_gobj);
> > +	if (!(imported_bo->preferred_domains &
> > +	    (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)))
> >   		return -EINVAL;
> > -	bo = gem_to_amdgpu_bo(obj);
> > -	if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
> > -				    AMDGPU_GEM_DOMAIN_GTT)))
> > -		/* Only VRAM and GTT BOs are supported */
> > -		return -EINVAL;
> > +	ret = drm_vma_node_allow(&imported_gobj->vma_node, drm_priv);
> > +	if (ret)
> > +		return ret;
> > -	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> > -	if (!*mem)
> > -		return -ENOMEM;
> > +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), dma_buf);
> > +	if (IS_ERR(gobj)) {
> > +		ret = PTR_ERR(gobj);
> > +		goto err_import;
> > +	}
> > -	ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
> > -	if (ret) {
> > -		kfree(mem);
> > -		return ret;
> > +	bo = gem_to_amdgpu_bo(gobj);
> > +	bo->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
> > +
> > +	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> > +	if (!*mem) {
> > +		ret = -ENOMEM;
> > +		goto err_alloc_mem;
> >   	}
> >   	if (size)
> > -		*size = amdgpu_bo_size(bo);
> > +		*size = amdgpu_bo_size(imported_bo);
> >   	if (mmap_offset)
> > -		*mmap_offset = amdgpu_bo_mmap_offset(bo);
> > +		*mmap_offset = amdgpu_bo_mmap_offset(imported_bo);
> >   	INIT_LIST_HEAD(&(*mem)->attachments);
> >   	mutex_init(&(*mem)->lock);
> >   	(*mem)->alloc_flags =
> > -		((bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> > +		((imported_bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> >   		KFD_IOC_ALLOC_MEM_FLAGS_VRAM : KFD_IOC_ALLOC_MEM_FLAGS_GTT)
> >   		| KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
> >   		| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
> > -	drm_gem_object_get(&bo->tbo.base);
> > +	get_dma_buf(dma_buf);
> > +	(*mem)->dmabuf = dma_buf;
> >   	(*mem)->bo = bo;
> >   	(*mem)->va = va;
> > -	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> > -		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
> > +	(*mem)->domain = AMDGPU_GEM_DOMAIN_GTT;
> >   	(*mem)->mapped_to_gpu_memory = 0;
> >   	(*mem)->process_info = avm->process_info;
> >   	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
> >   	amdgpu_sync_create(&(*mem)->sync);
> >   	(*mem)->is_imported = true;
> > +	bo->kfd_bo = *mem;
> >   	return 0;
> > +err_import:
> > +	drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
> > +err_alloc_mem:
> > +	drm_gem_object_put(gobj);
> > +	return ret;
> >   }
> >   /* Evict a userptr BO by stopping the queues if necessary
