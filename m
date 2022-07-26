Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A54C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 02:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C8C18A093;
	Tue, 26 Jul 2022 02:18:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A5D18A044
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 02:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDJWkgxS6KbTAuaSl2mnaC1lkUpbJNpmxFm+4z9wbhSxJ6qp9qcYaUBGZKcMrqhL5XQxxtxz9IOf8dzbiommxhmGIZkJzgiEQkV84UA09G/O8Fv3PadcLvPggSolqEOMJ0pW5GCXtwlq73UMdpb5Vwyulon3OnFWBx/DRK5B3dflkNkz5fqFILX5DsCgv8uUjWLeozB99V4I0nEb9uVfFU/Vry7ol7ndNX5WMRi/jcsAiqaaYI1dxwAySUPuy05iwuM1g2MXXWWHmbwSt/pb98Rb/Ss42QDPcX/BewZQUq+gC1lxm3At2sKouG35SVBV9oO2exPzVTgHT6Qv7YBx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qunvtTG2ZXD86O/jShTb43NSBOLio/liWQ6wu4NL/sw=;
 b=LeCWUy1F0fps3GM1fg1qgW/rzUwgIcjKt925fvYJLB3izww2EKHLzmIcXEwlHzGg8dRJx5LPaWwSsdBMhLjzFzkfOsC4Bhhz5hjtMu5jvuXbtuFbe+utKAwuGIguGqRh3mMwRxmeXbComnEVvAwIw3951JAzg1VugswGdOuotrEPjSGAjunzIb9QZziYY06F2thpBp0ecgOcikPcIrpQUljJ++eyFC7XwZa1uY+QxRL246OferYT/mg+MLvd71Fxm/YcEs9Btt5r2CmOHy3ZVpdKs5IjPb2mqfQ0gYyUuy4/X9WRQ3IqEURqDoOx7S5Wtggh7bzokLKeQ5yKY2HxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qunvtTG2ZXD86O/jShTb43NSBOLio/liWQ6wu4NL/sw=;
 b=qqtbalqS5N2NmYwiW26zW91oIGLZaCLMANkAcph0alY/h071hFUA1eOLSamQRTxxHLMmFHQcgiASAvaxWWB2QX+YpEy5hkSqYLdxA9qZ+12tg89TR2gzv4Yk3p0tKn+XE1r+wYpOcywdfSAgvgErtsCOalLGhF1CCCPS3CGgAzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.24; Tue, 26 Jul 2022 02:18:28 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::fd31:9d15:8b1c:3a09]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::fd31:9d15:8b1c:3a09%7]) with mapi id 15.20.5458.019; Tue, 26 Jul 2022
 02:18:28 +0000
Date: Tue, 26 Jul 2022 10:18:18 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH 2/3] drm/amdkfd: refine the gfx BO based dmabuf handling
Message-ID: <Yt9O6loDDeDbQyen@lang-desktop>
References: <20220725103205.2085630-1-Lang.Yu@amd.com>
 <20220725103205.2085630-2-Lang.Yu@amd.com>
 <3ea7d3b9-266f-d9b1-f6d5-d998a5e6e2c9@amd.com>
 <Yt8yHSREAp6sRK+K@lang-desktop>
 <9548e049-8567-7479-7939-4cd12e856153@amd.com>
 <Yt84EdsZe/2QCneC@lang-desktop>
 <fc9bff98-1d79-b769-6999-f792c045193c@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc9bff98-1d79-b769-6999-f792c045193c@amd.com>
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a877928f-3e58-48a0-a346-08da6ead20a7
X-MS-TrafficTypeDiagnostic: CY5PR12MB6550:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PFY9cw2ChLEsILJSaLNm7guvbLzbi9v9aj53fVhg6lB28xa/tUPLYkoz0eyuWkNASnIxnIrnHG8xsYLDVs1p0aww6eZRN9elnMQAAUdYE8kCmPapaMIgudxnT6lwW1HcGfDDmE70GynWOEXMCU2mM/OZosyDiTyQ3/Wag7Km/lQDXH9QVOJp/CfRC8s4615fpKLPNUK3KxRmaz+fm6ycCJoR77i20KkJKdl6jLmeOkmTLSvQS0ma768WDwiIcqRAosmaNyRUCSsyb0PZkiNsiam7BIKcYGQcGTLDa+9Fhb/49wAJ3yeqibINk6OAVcEd7Wp6Ys3JKa49Pduvz8xzgsOA4XxU/KiZqLCp+SUsdxOcFjQhondL/7JfKeZ3JlnLs5CgsGTR94E9h9ME2+HBpnxL5MXbbEWpdUHSvrzfhJR26gw2G7z3ICSgmQxsxUokIiqEOQy6n27am1dDx4xqzJCkyDrw2sGilkvDzXKfZb0GiBREH7uS4CrTvUsYGDmbBqpcYfoi/9YZN+H5l8ATuOda1KlvhjVrZ5ppdrfwelc/wzFtCFnkMDvXS8XujfXNpyjL6wd1KMarqIUeeObk9ImcJxkmBq71IcBSOT3bU1Z+gjT+JvXs0c5XLahws3ieWvZ0Db//kbJqoPSTH09xOqNDC8eUGj2X6oDRBInWj6djf1YlO+fSr5YD2eZwjRLM6tbdXtT5etg/CtTrBV/XclOzfBsXkpb197cCQv30nBoqhtZWEtJWRI9A8j5rHFM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(7916004)(346002)(366004)(39860400002)(136003)(376002)(396003)(41300700001)(38100700002)(66476007)(66556008)(6636002)(4326008)(54906003)(8676002)(316002)(66946007)(33716001)(6512007)(5660300002)(26005)(9686003)(6486002)(478600001)(8936002)(6862004)(2906002)(30864003)(83380400001)(6506007)(186003)(6666004)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HNrZ61k6Nbd6mXEgszPD6E925Z2bmV5m4UgJeA4KDy/pjYCJjV2eVPQMiS?=
 =?iso-8859-1?Q?jFrR4Pidwo33FXdIoJOK7Cy0+s3/XyML+6Ncym6R7p9S8lw6cQp3P9nmKY?=
 =?iso-8859-1?Q?MfT41vff2MW8CBVpoMBmc88GSg67ZO7uF+Ue0KMuhHjZDQsEP5khqpDZX3?=
 =?iso-8859-1?Q?gnXdJf12yhk6+DCAZYjKNj5WqpOET3apYwuztzcdoaqeGsaMZT7wxrpO83?=
 =?iso-8859-1?Q?6euz6+fRPULDYD1QdJKTowHwzUFhPIxjiyGGkxJy1wh4TYRMl0uBRLrmO3?=
 =?iso-8859-1?Q?uBSOfQ9pGLdrNLW5RnyiFbSB0+RPtR7/QT4ZrZredwDbKltsHhdDmD2VtA?=
 =?iso-8859-1?Q?eORnh2LZDSWu+Jq8buYI3yyniOZHUxdVbX+2BvAs6ELBOZRyEPmGNsfbE6?=
 =?iso-8859-1?Q?uloBoZs9dChesFDq7/GnzG9GSzMMKm3gVMlvwp167VG7jhElSKeB+6KHFw?=
 =?iso-8859-1?Q?ZyAdTN0xOFf81bY92YJBE4SPvJdxdiIcTb2DN5bolUsQvuZmOs6aojog4j?=
 =?iso-8859-1?Q?T0eAthh3Xu6uuj/fPjePaAWa8NIrOq1/kKpEty2OlvH8tjd2ujLUDNWtXD?=
 =?iso-8859-1?Q?NPxrVFGRU1gf7Vwh1zJn2UADnlx58dSEHxDBYTAsgtR54loTV8iw2gGNWY?=
 =?iso-8859-1?Q?L9Pppz6XRt7pu1eNQctX3EMlVihKPUZTgtdTzaB8/ezAD1GnsK+4END5R4?=
 =?iso-8859-1?Q?Y+k3XkuxRdbVe75s7Jt1cbUSyyH5hTr0vyYoevMNJrN5m30blkdQwQxhG4?=
 =?iso-8859-1?Q?qpIHvf6I3lUl2UorN4BzqYVlg0IPFVTJT73gnB4W+ezflLOXmhpY/BxJqm?=
 =?iso-8859-1?Q?LBkoLMGqOyzjrEH7TOxqrQ/gZG0Y1blMZbOdIjIf3gQyIiKdLTS0pjmeCu?=
 =?iso-8859-1?Q?zlASqjFmnQ1h/0K81eCP9dMulC8JDKRjQ+JbodU/efBofbICgQZL1us71G?=
 =?iso-8859-1?Q?gOcJ3LbULLhcD8wL9SpdTjjcWIcjgW2DzB4ZjQH7nMHUixCGjeKOXv/NRH?=
 =?iso-8859-1?Q?rq/L3IMVS8B12CVYgBMJbjLoDNn1OonW5VvHRLWFkAu4y5Sl9WIW+iQa73?=
 =?iso-8859-1?Q?PN+arOkmD98VWZkKVOQfPkcs8fBpMBVLE0O3aEQMR7Z4PFcqL4VlJghF7j?=
 =?iso-8859-1?Q?MoRZi4l61uPADU70kMrg5h2s2tZEoVC2hePcnjjMJoOJD/W5Y9XXMBizuw?=
 =?iso-8859-1?Q?plt9AYxty8AAUSNslKmbUaenU6iQOynSaodjOdBTMmcqtBexqwRPMLLHpz?=
 =?iso-8859-1?Q?7lXXKOaXN9mnmC32By/puJ9IUHKh3ZxfjIbpbUvE/2GhDBnNSavHGAwes1?=
 =?iso-8859-1?Q?yKGLMsYDQK9Np71TBLG9bRJdXWeWwCh/dpBn3OHGX+jEOL1ziIoh1GCz08?=
 =?iso-8859-1?Q?pdeU2x5UXgPeeDZ0CiOGJfmR2f57kV4AQdw2QrVHUdphqi1XARCQqxeh0j?=
 =?iso-8859-1?Q?op0PohhPLKdG+OaGc4wLp0x62haOMlXtxRpFkYn9E1pPDt+EIBxFUaTwBE?=
 =?iso-8859-1?Q?a1Do4AyDBBnEhd/Y2O0KBZ0VV3mSHx4Zzrk5uF7N8rGp0jWA1E/xIuO3Rn?=
 =?iso-8859-1?Q?eHUDxKV3E/UxMJSqryEh3fhnFZJl1gy7YW8J4KeVzd6Lz20XHj6cUINQCc?=
 =?iso-8859-1?Q?MWeWOeNxN4bBVULacLa5ZpHDUoRAkNzhB8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a877928f-3e58-48a0-a346-08da6ead20a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 02:18:28.5413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6KG7OsjTA5XyOw0HgAmzxppSobdbyCqL68+AQGu2LMp4V1wgvEE+rF9pBqcUYEERXiE9E57EK6rc8bCVxfPAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
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
> Am 2022-07-25 um 20:40 schrieb Lang Yu:
> > On 07/25/ , Felix Kuehling wrote:
> > > Am 2022-07-25 um 20:15 schrieb Lang Yu:
> > > > On 07/25/ , Felix Kuehling wrote:
> > > > > Am 2022-07-25 um 06:32 schrieb Lang Yu:
> > > > > > We have memory leak issue in current implenmention, i.e.,
> > > > > > the allocated struct kgd_mem memory is not handled properly.
> > > > > > 
> > > > > > The idea is always creating a buffer object when importing
> > > > > > a gfx BO based dmabuf.
> > > > > > 
> > > > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > > > ---
> > > > > >     .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 99 +++++++++++++------
> > > > > >     1 file changed, 70 insertions(+), 29 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > > > index b3806ebe5ef7..c1855b72a3f0 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > > > @@ -225,7 +225,8 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
> > > > > >     	u32 alloc_flags = bo->kfd_bo->alloc_flags;
> > > > > >     	u64 size = amdgpu_bo_size(bo);
> > > > > > -	unreserve_mem_limit(adev, size, alloc_flags);
> > > > > > +	if (!bo->kfd_bo->is_imported)
> > > > > > +		unreserve_mem_limit(adev, size, alloc_flags);
> > > > > >     	kfree(bo->kfd_bo);
> > > > > >     }
> > > > > > @@ -784,6 +785,24 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
> > > > > >     	}
> > > > > >     }
> > > > > > +static struct drm_gem_object*
> > > > > > +amdgpu_amdkfd_import(struct drm_device *dev, struct dma_buf *dma_buf)
> > > > > > +{
> > > > > > +	struct drm_gem_object *gobj;
> > > > > > +	struct amdgpu_bo *abo;
> > > > > > +
> > > > > > +	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
> > > > > I'd rather remove this limitation. We should be able to use any DMABuf with
> > > > > KFD. This check was added when we basically sidestepped all the dmabuf
> > > > > attachment code and just extracted the amdgpu_bo ourselves. I don't think we
> > > > > want to keep doing that.
> > > > This limitation here is to just reference the gobj if it is an amdgpu bo
> > > > and from same device instead of creating a gobj when importing a dmabuf.
> > > > 
> > > > > Please see my patch "[PATCH v2 1/2] drm/amdgpu: Generalize KFD dmabuf
> > > > > import" sent to amd-gfx on March 16. I'm about to send an updated version of
> > > > > this as part of upstream RDMA support soon.
> > > > The "drm/amdgpu: Generalize KFD dmabuf import" doesn't handle the struct kgd_mem
> > > > memory leak issue. Looking forward to the updated version. Thanks!
> > > Maybe we're trying to fix different problems. Can you give a more detailed
> > > explanation of the memory leak you're seeing? It's not obvious to me.
> > The struct kgd_mem is allocted by "*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);",
> > but it is not assigned to bo->kfd_bo like this "bo->kfd_bo = *mem;". Then *mem will
> > never be freed.
> 
> True. With the current upstream driver there is no way this can happen,
> because we don't have an API for KFD to export a dmabuf in a way that could
> later be imported. But with the RDMA and IPC features we're working on, this
> becomes a real possibility.
> 
> Your solution is to ensure that the dmabuf import always creates a new
> amdgpu_bo. But that can add a lot of overhead. How about this idea: In
> amdgpu_amdkfd_gpuvm_free_memory_of_gpu we could add this after
> drm_gem_object_put:
> 
> 	if (mem->bo->kfd_bo != mem)
> 		kfree(mem);

This way will turn a imported BO(e.g., a gfx BO) to a kfd BO , i.e.,
assign *mem to bo->kfd_bo. I'm not sure whether it makes sense
to modify the original BO like this.

The overhead is drm_prime_pages_to_sg + dma_map_sgtable when importing a
gfx dmabuf from same device.

Regards,
Lang

> That way amdgpu_amdkfd_release_notify would only be responsible for freeing
> the original kgd_mem. Any imports will be freed explicitly.
> 
> Regards,
>   Felix
> 
> 
> > 
> > Regards,
> > Lang
> > 
> > > The problem I'm trying to solve is, to ensure that each exported BO only has
> > > a single dmabuf because we run into problems with GEM if we have multiple
> > > dmabufs pointing to the same GEM object. That also enables re-exporting
> > > dmabufs of imported BOs. At the same time I'm removing any limitations of
> > > the types of BOs we can import, and trying to eliminate any custom dmabuf
> > > handling in KFD.
> > > 
> > > Regards,
> > >    Felix
> > > 
> > > 
> > > > Regards,
> > > > Lang
> > > > 
> > > > > Regards,
> > > > >     Felix
> > > > > 
> > > > > 
> > > > > > +		gobj = dma_buf->priv;
> > > > > > +		abo = gem_to_amdgpu_bo(gobj);
> > > > > > +		if (gobj->dev == dev && abo->kfd_bo) {
> > > > > > +			drm_gem_object_get(gobj);
> > > > > > +			return gobj;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +	return amdgpu_dma_buf_create_obj_and_attach(dev, dma_buf);
> > > > > > +}
> > > > > > +
> > > > > >     static int
> > > > > >     kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
> > > > > >     		      struct amdgpu_bo **bo)
> > > > > > @@ -802,7 +821,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
> > > > > >     		}
> > > > > >     	}
> > > > > > -	gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
> > > > > > +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), mem->dmabuf);
> > > > > >     	if (IS_ERR(gobj))
> > > > > >     		return PTR_ERR(gobj);
> > > > > > @@ -1805,12 +1824,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> > > > > >     {
> > > > > >     	struct amdkfd_process_info *process_info = mem->process_info;
> > > > > >     	unsigned long bo_size = mem->bo->tbo.base.size;
> > > > > > +	bool is_imported = false;
> > > > > > +	struct drm_gem_object *imported_gobj;
> > > > > >     	struct kfd_mem_attachment *entry, *tmp;
> > > > > >     	struct bo_vm_reservation_context ctx;
> > > > > >     	struct ttm_validate_buffer *bo_list_entry;
> > > > > >     	unsigned int mapped_to_gpu_memory;
> > > > > >     	int ret;
> > > > > > -	bool is_imported = false;
> > > > > >     	mutex_lock(&mem->lock);
> > > > > > @@ -1885,7 +1905,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> > > > > >     	}
> > > > > >     	/* Free the BO*/
> > > > > > -	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> > > > > > +	if (!is_imported) {
> > > > > > +		drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> > > > > > +	} else {
> > > > > > +		imported_gobj = mem->dmabuf->priv;
> > > > > > +		drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
> > > > > > +	}
> > > > > > +
> > > > > >     	if (mem->dmabuf)
> > > > > >     		dma_buf_put(mem->dmabuf);
> > > > > >     	mutex_destroy(&mem->lock);
> > > > > > @@ -2249,62 +2275,77 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
> > > > > >     				      uint64_t *mmap_offset)
> > > > > >     {
> > > > > >     	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
> > > > > > -	struct drm_gem_object *obj;
> > > > > > -	struct amdgpu_bo *bo;
> > > > > > +	struct drm_gem_object *imported_gobj, *gobj;
> > > > > > +	struct amdgpu_bo *imported_bo, *bo;
> > > > > >     	int ret;
> > > > > > -	if (dma_buf->ops != &amdgpu_dmabuf_ops)
> > > > > > -		/* Can't handle non-graphics buffers */
> > > > > > +	/*
> > > > > > +	 * Can't handle non-graphics buffers and
> > > > > > +	 * buffers from other devices
> > > > > > +	 */
> > > > > > +	imported_gobj = dma_buf->priv;
> > > > > > +	if (dma_buf->ops != &amdgpu_dmabuf_ops ||
> > > > > > +	    drm_to_adev(imported_gobj->dev) != adev)
> > > > > >     		return -EINVAL;
> > > > > > -	obj = dma_buf->priv;
> > > > > > -	if (drm_to_adev(obj->dev) != adev)
> > > > > > -		/* Can't handle buffers from other devices */
> > > > > > +	/* Only VRAM and GTT BOs are supported */
> > > > > > +	imported_bo = gem_to_amdgpu_bo(imported_gobj);
> > > > > > +	if (!(imported_bo->preferred_domains &
> > > > > > +	    (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)))
> > > > > >     		return -EINVAL;
> > > > > > -	bo = gem_to_amdgpu_bo(obj);
> > > > > > -	if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
> > > > > > -				    AMDGPU_GEM_DOMAIN_GTT)))
> > > > > > -		/* Only VRAM and GTT BOs are supported */
> > > > > > -		return -EINVAL;
> > > > > > +	ret = drm_vma_node_allow(&imported_gobj->vma_node, drm_priv);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > -	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> > > > > > -	if (!*mem)
> > > > > > -		return -ENOMEM;
> > > > > > +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), dma_buf);
> > > > > > +	if (IS_ERR(gobj)) {
> > > > > > +		ret = PTR_ERR(gobj);
> > > > > > +		goto err_import;
> > > > > > +	}
> > > > > > -	ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
> > > > > > -	if (ret) {
> > > > > > -		kfree(mem);
> > > > > > -		return ret;
> > > > > > +	bo = gem_to_amdgpu_bo(gobj);
> > > > > > +	bo->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
> > > > > > +
> > > > > > +	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> > > > > > +	if (!*mem) {
> > > > > > +		ret = -ENOMEM;
> > > > > > +		goto err_alloc_mem;
> > > > > >     	}
> > > > > >     	if (size)
> > > > > > -		*size = amdgpu_bo_size(bo);
> > > > > > +		*size = amdgpu_bo_size(imported_bo);
> > > > > >     	if (mmap_offset)
> > > > > > -		*mmap_offset = amdgpu_bo_mmap_offset(bo);
> > > > > > +		*mmap_offset = amdgpu_bo_mmap_offset(imported_bo);
> > > > > >     	INIT_LIST_HEAD(&(*mem)->attachments);
> > > > > >     	mutex_init(&(*mem)->lock);
> > > > > >     	(*mem)->alloc_flags =
> > > > > > -		((bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> > > > > > +		((imported_bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> > > > > >     		KFD_IOC_ALLOC_MEM_FLAGS_VRAM : KFD_IOC_ALLOC_MEM_FLAGS_GTT)
> > > > > >     		| KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
> > > > > >     		| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
> > > > > > -	drm_gem_object_get(&bo->tbo.base);
> > > > > > +	get_dma_buf(dma_buf);
> > > > > > +	(*mem)->dmabuf = dma_buf;
> > > > > >     	(*mem)->bo = bo;
> > > > > >     	(*mem)->va = va;
> > > > > > -	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> > > > > > -		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
> > > > > > +	(*mem)->domain = AMDGPU_GEM_DOMAIN_GTT;
> > > > > >     	(*mem)->mapped_to_gpu_memory = 0;
> > > > > >     	(*mem)->process_info = avm->process_info;
> > > > > >     	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
> > > > > >     	amdgpu_sync_create(&(*mem)->sync);
> > > > > >     	(*mem)->is_imported = true;
> > > > > > +	bo->kfd_bo = *mem;
> > > > > >     	return 0;
> > > > > > +err_import:
> > > > > > +	drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
> > > > > > +err_alloc_mem:
> > > > > > +	drm_gem_object_put(gobj);
> > > > > > +	return ret;
> > > > > >     }
> > > > > >     /* Evict a userptr BO by stopping the queues if necessary
