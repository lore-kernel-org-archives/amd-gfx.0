Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB160CCA48B
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 03:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0FA11BD8E;
	Tue, 26 Jul 2022 03:40:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93CD910FF79
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 03:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KA1WpiXIijg8esMH1E5xFJK3/xFuqRvd4yhbD3PqCKzjiPiDuhya+/kFnHnknhBK0i9Ud5i+xDiSzW9HLXoZJxQyBOQ1aq/9+NxwXyUszN/ySfKzn74ql5hKsNe19JnAUUnhBhMP4kprKfvB3po93XGVbW9jVwpx0VHdu6IPWm7nWd9o2JsdeccrmhOsNHBzyu3TLqY7O09pfm+L+aDkAvyTyX6yDvWjWYDMkgYn/QtZb2OxQcXwl+qWf1t8qXL+twP/55O4l1qPvfYreEOHfkwDhtWZ1p8he4i3tN8CBhja7vnhB9YOJiKEDhHfp8egBRzuHvr6+c4qrV+YcDLEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBN2zbLtmc1jKf7oapdFQ+iDAmLQagwMYaf4Knnaa6o=;
 b=HkU9Q9/lksbQtgkdxnqH/ACLiLhiqkcQSUc8Pdiw3v9p2ezuTNXeYsJsCi6KMvx5QckXl5q8NVd/wx8JhDXh28X1OFA2sjUAtUKKRjdrJr/VwIWTWgIX0LkKS35RbV5twV59k1JlEBYEgA0ECgkEUHiXxQibznzP9POg6CDbjRAgE4p02esl5p8QYTubg//F+O9T1lDkwRsxP3YHh7CBPJfy3Yiktbmb7v3uJv1lfVeIP/dySWUShjpZnvxvnmoFSfjOB2m5nWHWBQOlMKv0FR5U/1eyzTDGBNC8mmCWdU2S0Rhcq19EnBbbUkycaxEYbHdcgIQAW0S89GF1TyOP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBN2zbLtmc1jKf7oapdFQ+iDAmLQagwMYaf4Knnaa6o=;
 b=y7TmHhjHKNdexJ5wHdvom6zyMSKu0qZe7VNR1+o9DLEX2qZKWKOxJjVbug9/QJ0dJ3dvDy6kafNcphBR/KbsOJcA53MInQbxLnEo4XdVMd+8zyV44lnyMaysa89/E26GsX/zxcy50N0JiC3SRS7lP1Et49a1TlxZ0xtsHUzpDDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR1201MB0187.namprd12.prod.outlook.com (2603:10b6:4:5b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Tue, 26 Jul 2022 03:40:49 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::fd31:9d15:8b1c:3a09]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::fd31:9d15:8b1c:3a09%7]) with mapi id 15.20.5458.019; Tue, 26 Jul 2022
 03:40:49 +0000
Date: Tue, 26 Jul 2022 11:40:38 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH 2/3] drm/amdkfd: refine the gfx BO based dmabuf handling
Message-ID: <Yt9iNmJ6cAQ82ppB@lang-desktop>
References: <20220725103205.2085630-1-Lang.Yu@amd.com>
 <20220725103205.2085630-2-Lang.Yu@amd.com>
 <3ea7d3b9-266f-d9b1-f6d5-d998a5e6e2c9@amd.com>
 <Yt8yHSREAp6sRK+K@lang-desktop>
 <9548e049-8567-7479-7939-4cd12e856153@amd.com>
 <Yt84EdsZe/2QCneC@lang-desktop>
 <fc9bff98-1d79-b769-6999-f792c045193c@amd.com>
 <Yt9O6loDDeDbQyen@lang-desktop>
 <0b7c8d09-26b6-44f1-610f-636a3e21ef8b@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b7c8d09-26b6-44f1-610f-636a3e21ef8b@amd.com>
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35ab489f-edb5-4c42-ca2f-08da6eb8a15a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0187:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyNPHkW8Tl9B8lABdtXCSIAzqD6AqFOrYhvUvb97ksyPFzdoa84oTTgdnNdDnUCe2OJZXNNeL+ymG98Z4utPeha5vNgGy6Uum7LxXJTwxluj5LaTDFgStGp8QKRJjCSwREW8+6znSbL6sa617vZ8KuVdadDO5PIpz4ajxLa7b/eUeqmHJcIb1Nj0DyKWpfsaZ6ClXGdcdlbIRyAcxV5fmkqUBOafuCpiiuVUcHv4UhkYB+V8NPgNMnNwPF86BI+USadBpcMAPbQup5y634F2s76PrEPM97OKxJ3+3SAt2uweLo+t9/0tbFKy2c/GvBfQdi62xH6OvslRXjYDe/4CrNyNZIC6AmMTzgNfE8rhAcjsJASdE3Ba72Zkw50hJQBQTEgJrpaDsSFMBYBZgg3s+kTWcI/ox5WIBOirsrqlZeaP5zr8qw9j+b0FBZQIT5Mx0JIh2GCAWckOwZkzqa4pkTN/L9Zk4VAnFLLG+WNfDxspRgO+9VBoFu7K0IhrRdbe2WM2lLJB/Zp+lNv1s6eG5nDdywr1MGtD5DF0OxaoLQvgpfwwOXJ4ssEUbjSOm3Pta9MzNEA1Os83sQRJS4jL503XqlaTWW4tDns2jaPOwWA5QquHKKbQX6pL/L3oaN7q6DBNQrNM2BHTVNpZ6lHPGZGOwxpQtO1LHXXL38lK6bTE9K/U7oykzMO1PX9Y3R1xv7BWTU8erW5rVlwH9zTedgbD0qBuOJOg/bsE7QiPCCJLNFwCcxfgLm2mbPO2a6HH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(7916004)(396003)(39860400002)(346002)(376002)(366004)(136003)(316002)(6862004)(8936002)(5660300002)(30864003)(38100700002)(2906002)(4326008)(33716001)(66476007)(8676002)(6666004)(6506007)(66556008)(66946007)(41300700001)(186003)(6486002)(86362001)(54906003)(6512007)(26005)(6636002)(478600001)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0/GWJ4UHhwF9yvtYJd+evh2GWk+VHqnp44+LCR2XyXaeRqYESRuNuwVrLa?=
 =?iso-8859-1?Q?PbYGEG8rQ3R1Qta4DdwsvRXP3W0wZpV+UGbhjistL4ZpUBwunLLakXKLoe?=
 =?iso-8859-1?Q?SQX7s+j4t976eaiFNO7/D8zfS9pwN2bMkr8DoCRWIq+FhXCP2Wwx7yMpB4?=
 =?iso-8859-1?Q?rLcPUOVsIxa0rIp73etLMTAS8AnRmq6Fs28vLpdwcIA7ev6F9GmxqS0cyz?=
 =?iso-8859-1?Q?gPlG+uSzLPhqf61c4BSGjNBZGnVMPbDeVpU11Z3A40p3GVKSW1nDAemx1n?=
 =?iso-8859-1?Q?Y6AXqaxfglXYiNvybXaKtgT3BIS/sdR56vp8gJSIV6LbqvWNTxm+oiC89R?=
 =?iso-8859-1?Q?ITuAA5HwSnFAA8QOaJfha1/LKHAap6nlrY3VmrlHWg3u71FUVANSCOsJ7k?=
 =?iso-8859-1?Q?WB4Vx0ZWLiKdZGlf2wJqmOE1C0/v1Nt7HoXTg3ikJwNnQRsumUzmkWvkiL?=
 =?iso-8859-1?Q?i2VKlXl1Ub823MX2IEw+hV262qRbtThExCpRoSIeJFn9Tlm3cAw7B4u9VC?=
 =?iso-8859-1?Q?C5d9/pfj6cBOu/uIYtDzAaLO9VwR6FhyA/r8EEHogCoH3G04pcN+L4LW6t?=
 =?iso-8859-1?Q?VHwqvYbc7Rbca9ld67Z38nOmgng4KjOPyoVuBA2sNETzCqSDfU/2/iQ2ZE?=
 =?iso-8859-1?Q?eWWP75A8f6dzV2zpzS1BkXq1qNrmFxyJKrPBiVcnJSlFrTGjjlJrYxcmTF?=
 =?iso-8859-1?Q?FxifkyWUymPr8w5pDRO6Sq+3kVL/DmqFSogA0Lxu7OhA2ZNeJdpZw4Iz6a?=
 =?iso-8859-1?Q?QPx+EVP27ZGQb6xG/p6O6dOhejscanaSncZZ6OJChzHq7auNhy7aywMc4B?=
 =?iso-8859-1?Q?8NZRKYTHNbom1FePrNj1KB1IpBVMQbCcn2h0Sn4NSUsv4jXOMEY03fL73X?=
 =?iso-8859-1?Q?ubu7RKj0+ME8HDTkTTfyXHFePIjqmRMdWRThuFrQqgxOcTWnqlmzmOpgIw?=
 =?iso-8859-1?Q?tqWRIC7xi0fTrkMHs1j/aSORvFH7dXIdTN1HW0s/th+jzmzaSsTybAXY2F?=
 =?iso-8859-1?Q?gKFvyrAzed8/ibE1JjhjgQ6g3RfSRyYJJ04aW+6bBCJ/hrBRdP36pCe/7N?=
 =?iso-8859-1?Q?+gYPT924SYXmxCVGVadA7OSusG0gjtHae8NoDKjNo9OsXm1iEZt6qP3Xwk?=
 =?iso-8859-1?Q?7INjNSkiSDS8AA1Efsf34OuB5LxT0GYbmSLCTB+ExyXbGOsxEdgFcSfhkQ?=
 =?iso-8859-1?Q?S580oOcG6wgpcbsdPqdKLGI89wBYDBc+/KTC5H6hJA7MzKJH+52hQ2U9D0?=
 =?iso-8859-1?Q?QGxeVtaTy/YjK3G413jw8kUC2IFiCZdRyIGgNVT9P5xcLoPsGMhBrmHI8R?=
 =?iso-8859-1?Q?eqSBOiYnIdaEvYM0zbldfFHSuugGFHm+VwXY93EFb1FCTg582T15ht9Uo2?=
 =?iso-8859-1?Q?hRGGJlJ5J56JxKrK8oSmItIexnWk7wFhYND7XKQKrWiJfEFD1EqbEgvwU1?=
 =?iso-8859-1?Q?CJg+/wV0MY4n96TDjzlUp01IiP26L70U6vA69F3Ed5MPe7kOPnGI3Btg2X?=
 =?iso-8859-1?Q?x9aZ4dPTmX8QMjU+/8hpJGkLxVVkWutDPgMqsdIF2bR/MjPrtp04K6thZH?=
 =?iso-8859-1?Q?7NnLBDBz3dR+uQZC72iSEZbQeRQc8BRRfbUQJ1nxgZoZxKPDj6lka5z53W?=
 =?iso-8859-1?Q?Y6yhr9N/pTKFPC7evZ1mCO0eYbII2PLIzi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ab489f-edb5-4c42-ca2f-08da6eb8a15a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 03:40:48.9902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IB5eaL4bdSZwzE6yvUiapidaIPihQKyXuV+7brhRMFTSqjPPPAE80zd9rZgPkQZPxqyJynzgM9HWzS3+1xaZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0187
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
> Am 2022-07-25 um 22:18 schrieb Lang Yu:
> > On 07/25/ , Felix Kuehling wrote:
> > > Am 2022-07-25 um 20:40 schrieb Lang Yu:
> > > > On 07/25/ , Felix Kuehling wrote:
> > > > > Am 2022-07-25 um 20:15 schrieb Lang Yu:
> > > > > > On 07/25/ , Felix Kuehling wrote:
> > > > > > > Am 2022-07-25 um 06:32 schrieb Lang Yu:
> > > > > > > > We have memory leak issue in current implenmention, i.e.,
> > > > > > > > the allocated struct kgd_mem memory is not handled properly.
> > > > > > > > 
> > > > > > > > The idea is always creating a buffer object when importing
> > > > > > > > a gfx BO based dmabuf.
> > > > > > > > 
> > > > > > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > > > > > ---
> > > > > > > >      .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 99 +++++++++++++------
> > > > > > > >      1 file changed, 70 insertions(+), 29 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > > > > > index b3806ebe5ef7..c1855b72a3f0 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > > > > > > > @@ -225,7 +225,8 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
> > > > > > > >      	u32 alloc_flags = bo->kfd_bo->alloc_flags;
> > > > > > > >      	u64 size = amdgpu_bo_size(bo);
> > > > > > > > -	unreserve_mem_limit(adev, size, alloc_flags);
> > > > > > > > +	if (!bo->kfd_bo->is_imported)
> > > > > > > > +		unreserve_mem_limit(adev, size, alloc_flags);
> > > > > > > >      	kfree(bo->kfd_bo);
> > > > > > > >      }
> > > > > > > > @@ -784,6 +785,24 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
> > > > > > > >      	}
> > > > > > > >      }
> > > > > > > > +static struct drm_gem_object*
> > > > > > > > +amdgpu_amdkfd_import(struct drm_device *dev, struct dma_buf *dma_buf)
> > > > > > > > +{
> > > > > > > > +	struct drm_gem_object *gobj;
> > > > > > > > +	struct amdgpu_bo *abo;
> > > > > > > > +
> > > > > > > > +	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
> > > > > > > I'd rather remove this limitation. We should be able to use any DMABuf with
> > > > > > > KFD. This check was added when we basically sidestepped all the dmabuf
> > > > > > > attachment code and just extracted the amdgpu_bo ourselves. I don't think we
> > > > > > > want to keep doing that.
> > > > > > This limitation here is to just reference the gobj if it is an amdgpu bo
> > > > > > and from same device instead of creating a gobj when importing a dmabuf.
> > > > > > 
> > > > > > > Please see my patch "[PATCH v2 1/2] drm/amdgpu: Generalize KFD dmabuf
> > > > > > > import" sent to amd-gfx on March 16. I'm about to send an updated version of
> > > > > > > this as part of upstream RDMA support soon.
> > > > > > The "drm/amdgpu: Generalize KFD dmabuf import" doesn't handle the struct kgd_mem
> > > > > > memory leak issue. Looking forward to the updated version. Thanks!
> > > > > Maybe we're trying to fix different problems. Can you give a more detailed
> > > > > explanation of the memory leak you're seeing? It's not obvious to me.
> > > > The struct kgd_mem is allocted by "*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);",
> > > > but it is not assigned to bo->kfd_bo like this "bo->kfd_bo = *mem;". Then *mem will
> > > > never be freed.
> > > True. With the current upstream driver there is no way this can happen,
> > > because we don't have an API for KFD to export a dmabuf in a way that could
> > > later be imported. But with the RDMA and IPC features we're working on, this
> > > becomes a real possibility.
> > > 
> > > Your solution is to ensure that the dmabuf import always creates a new
> > > amdgpu_bo. But that can add a lot of overhead. How about this idea: In
> > > amdgpu_amdkfd_gpuvm_free_memory_of_gpu we could add this after
> > > drm_gem_object_put:
> > > 
> > > 	if (mem->bo->kfd_bo != mem)
> > > 		kfree(mem);
> > This way will turn a imported BO(e.g., a gfx BO) to a kfd BO , i.e.,
> > assign *mem to bo->kfd_bo. I'm not sure whether it makes sense
> > to modify the original BO like this.
> 
> No. The point is that it won't. bo->kfd_bo should only be set for BOs that
> were originally allocated with KFD. Any import won't change the bo->kfd_bo.
> So the condition I suggested will be true, and
> amdgpu_amdkfd_gpuvm_free_memory_of_gpu will kfree the kgd_mem structure
> itself. Only the original allocation will use the release notifier to free
> the kgd_mem.

Thanks, got it. That's a good idea!

Regards,
Lang

> > 
> > The overhead is drm_prime_pages_to_sg + dma_map_sgtable when importing a
> > gfx dmabuf from same device.
> 
> Yes. The dma address arrays are pretty significant, because they store 4KB
> PTEs. I'd like to avoid duplicating those for imports, if I can.
> 
> Regards,
>   Felix
> 
> 
> > 
> > Regards,
> > Lang
> > 
> > > That way amdgpu_amdkfd_release_notify would only be responsible for freeing
> > > the original kgd_mem. Any imports will be freed explicitly.
> > > 
> > > Regards,
> > >    Felix
> > > 
> > > 
> > > > Regards,
> > > > Lang
> > > > 
> > > > > The problem I'm trying to solve is, to ensure that each exported BO only has
> > > > > a single dmabuf because we run into problems with GEM if we have multiple
> > > > > dmabufs pointing to the same GEM object. That also enables re-exporting
> > > > > dmabufs of imported BOs. At the same time I'm removing any limitations of
> > > > > the types of BOs we can import, and trying to eliminate any custom dmabuf
> > > > > handling in KFD.
> > > > > 
> > > > > Regards,
> > > > >     Felix
> > > > > 
> > > > > 
> > > > > > Regards,
> > > > > > Lang
> > > > > > 
> > > > > > > Regards,
> > > > > > >      Felix
> > > > > > > 
> > > > > > > 
> > > > > > > > +		gobj = dma_buf->priv;
> > > > > > > > +		abo = gem_to_amdgpu_bo(gobj);
> > > > > > > > +		if (gobj->dev == dev && abo->kfd_bo) {
> > > > > > > > +			drm_gem_object_get(gobj);
> > > > > > > > +			return gobj;
> > > > > > > > +		}
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	return amdgpu_dma_buf_create_obj_and_attach(dev, dma_buf);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >      static int
> > > > > > > >      kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
> > > > > > > >      		      struct amdgpu_bo **bo)
> > > > > > > > @@ -802,7 +821,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
> > > > > > > >      		}
> > > > > > > >      	}
> > > > > > > > -	gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
> > > > > > > > +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), mem->dmabuf);
> > > > > > > >      	if (IS_ERR(gobj))
> > > > > > > >      		return PTR_ERR(gobj);
> > > > > > > > @@ -1805,12 +1824,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> > > > > > > >      {
> > > > > > > >      	struct amdkfd_process_info *process_info = mem->process_info;
> > > > > > > >      	unsigned long bo_size = mem->bo->tbo.base.size;
> > > > > > > > +	bool is_imported = false;
> > > > > > > > +	struct drm_gem_object *imported_gobj;
> > > > > > > >      	struct kfd_mem_attachment *entry, *tmp;
> > > > > > > >      	struct bo_vm_reservation_context ctx;
> > > > > > > >      	struct ttm_validate_buffer *bo_list_entry;
> > > > > > > >      	unsigned int mapped_to_gpu_memory;
> > > > > > > >      	int ret;
> > > > > > > > -	bool is_imported = false;
> > > > > > > >      	mutex_lock(&mem->lock);
> > > > > > > > @@ -1885,7 +1905,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> > > > > > > >      	}
> > > > > > > >      	/* Free the BO*/
> > > > > > > > -	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> > > > > > > > +	if (!is_imported) {
> > > > > > > > +		drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> > > > > > > > +	} else {
> > > > > > > > +		imported_gobj = mem->dmabuf->priv;
> > > > > > > > +		drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > >      	if (mem->dmabuf)
> > > > > > > >      		dma_buf_put(mem->dmabuf);
> > > > > > > >      	mutex_destroy(&mem->lock);
> > > > > > > > @@ -2249,62 +2275,77 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
> > > > > > > >      				      uint64_t *mmap_offset)
> > > > > > > >      {
> > > > > > > >      	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
> > > > > > > > -	struct drm_gem_object *obj;
> > > > > > > > -	struct amdgpu_bo *bo;
> > > > > > > > +	struct drm_gem_object *imported_gobj, *gobj;
> > > > > > > > +	struct amdgpu_bo *imported_bo, *bo;
> > > > > > > >      	int ret;
> > > > > > > > -	if (dma_buf->ops != &amdgpu_dmabuf_ops)
> > > > > > > > -		/* Can't handle non-graphics buffers */
> > > > > > > > +	/*
> > > > > > > > +	 * Can't handle non-graphics buffers and
> > > > > > > > +	 * buffers from other devices
> > > > > > > > +	 */
> > > > > > > > +	imported_gobj = dma_buf->priv;
> > > > > > > > +	if (dma_buf->ops != &amdgpu_dmabuf_ops ||
> > > > > > > > +	    drm_to_adev(imported_gobj->dev) != adev)
> > > > > > > >      		return -EINVAL;
> > > > > > > > -	obj = dma_buf->priv;
> > > > > > > > -	if (drm_to_adev(obj->dev) != adev)
> > > > > > > > -		/* Can't handle buffers from other devices */
> > > > > > > > +	/* Only VRAM and GTT BOs are supported */
> > > > > > > > +	imported_bo = gem_to_amdgpu_bo(imported_gobj);
> > > > > > > > +	if (!(imported_bo->preferred_domains &
> > > > > > > > +	    (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)))
> > > > > > > >      		return -EINVAL;
> > > > > > > > -	bo = gem_to_amdgpu_bo(obj);
> > > > > > > > -	if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
> > > > > > > > -				    AMDGPU_GEM_DOMAIN_GTT)))
> > > > > > > > -		/* Only VRAM and GTT BOs are supported */
> > > > > > > > -		return -EINVAL;
> > > > > > > > +	ret = drm_vma_node_allow(&imported_gobj->vma_node, drm_priv);
> > > > > > > > +	if (ret)
> > > > > > > > +		return ret;
> > > > > > > > -	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> > > > > > > > -	if (!*mem)
> > > > > > > > -		return -ENOMEM;
> > > > > > > > +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), dma_buf);
> > > > > > > > +	if (IS_ERR(gobj)) {
> > > > > > > > +		ret = PTR_ERR(gobj);
> > > > > > > > +		goto err_import;
> > > > > > > > +	}
> > > > > > > > -	ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
> > > > > > > > -	if (ret) {
> > > > > > > > -		kfree(mem);
> > > > > > > > -		return ret;
> > > > > > > > +	bo = gem_to_amdgpu_bo(gobj);
> > > > > > > > +	bo->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
> > > > > > > > +
> > > > > > > > +	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> > > > > > > > +	if (!*mem) {
> > > > > > > > +		ret = -ENOMEM;
> > > > > > > > +		goto err_alloc_mem;
> > > > > > > >      	}
> > > > > > > >      	if (size)
> > > > > > > > -		*size = amdgpu_bo_size(bo);
> > > > > > > > +		*size = amdgpu_bo_size(imported_bo);
> > > > > > > >      	if (mmap_offset)
> > > > > > > > -		*mmap_offset = amdgpu_bo_mmap_offset(bo);
> > > > > > > > +		*mmap_offset = amdgpu_bo_mmap_offset(imported_bo);
> > > > > > > >      	INIT_LIST_HEAD(&(*mem)->attachments);
> > > > > > > >      	mutex_init(&(*mem)->lock);
> > > > > > > >      	(*mem)->alloc_flags =
> > > > > > > > -		((bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> > > > > > > > +		((imported_bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> > > > > > > >      		KFD_IOC_ALLOC_MEM_FLAGS_VRAM : KFD_IOC_ALLOC_MEM_FLAGS_GTT)
> > > > > > > >      		| KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
> > > > > > > >      		| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
> > > > > > > > -	drm_gem_object_get(&bo->tbo.base);
> > > > > > > > +	get_dma_buf(dma_buf);
> > > > > > > > +	(*mem)->dmabuf = dma_buf;
> > > > > > > >      	(*mem)->bo = bo;
> > > > > > > >      	(*mem)->va = va;
> > > > > > > > -	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> > > > > > > > -		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
> > > > > > > > +	(*mem)->domain = AMDGPU_GEM_DOMAIN_GTT;
> > > > > > > >      	(*mem)->mapped_to_gpu_memory = 0;
> > > > > > > >      	(*mem)->process_info = avm->process_info;
> > > > > > > >      	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
> > > > > > > >      	amdgpu_sync_create(&(*mem)->sync);
> > > > > > > >      	(*mem)->is_imported = true;
> > > > > > > > +	bo->kfd_bo = *mem;
> > > > > > > >      	return 0;
> > > > > > > > +err_import:
> > > > > > > > +	drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
> > > > > > > > +err_alloc_mem:
> > > > > > > > +	drm_gem_object_put(gobj);
> > > > > > > > +	return ret;
> > > > > > > >      }
> > > > > > > >      /* Evict a userptr BO by stopping the queues if necessary
