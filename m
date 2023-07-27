Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B069DC001E0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 12:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5837110E3FF;
	Thu, 27 Jul 2023 12:04:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7968D10E3FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 12:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7D8cUptY/rHQS+LRApvsW/nDikBifevnxFnuXrmkLJwsPmDQereWuFYvDTcRIqcYuqiLTph7P4PtIy6/T9QL8vQenELbfW6bKWzfDg+ucYjoOXaRmoCn0X2mgqDMkFU8r4eJThJKfs4aTQpGw5L6yr3OUwNS8IKX4x+KT2X/KzsyLJbEr6BHotu8nCZ6hM7+P+Uzkjr5X7nMpQmlGPRbABIj/7B8li+iCZ7kYI+scK3dmj/MxwYVBQZA9DB9r76ivSfXLWWMKRSCpvKnVgBU0NcpHX/A1OBfUF2N6oXfB8TEG6/gA48EFxpcZWdXoYOrWNAdFpAuV3lZXRhMiCJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZITMXOchwdH6E2WvDmkIta6xMaAOq3X48i0bF0S4Ei8=;
 b=AJr1jFdsDpiaALWB+Dl64GkFdBbgEJ45Wvzt52B3z7imxZXCHwB9LfqBQJKvnikba06cixxNrmjYgtuBdUazplWAzLIxkEkLcOCdVHcXYMuwyvW0fQlDD9W48BcbMpT8gNDZm5a8eoqgl0WaDh/i5bOxECCtT6WrLhpMr6hrQStidZayHvOU2CrP7EdByBd4MfTgqihxFMUnI3r6cayDHP+FGriuYgkCTDbdAERuzmDM7hOyouVHpru50zcInr7oarvI503CBFLzO/ql9v+HFEmnxKh9Eq7eX+AHQhENSiVvjB2KCaxz9IAR95DPum+TLBV1myJJRBpfcwG7EIIB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZITMXOchwdH6E2WvDmkIta6xMaAOq3X48i0bF0S4Ei8=;
 b=NMrXi0ykUI29RxogUnRa31okZRqx802WEXkBFucePhs6vDEWpNvBpIG1+fZYJeN7uMPrAKV252C4iTApSPy/jzhmFLC1Ijha0bgIskdlzcVFg1Fec2KSGHH7oOAexYmhHsnp/1p+Rj72lJUDZN5UP/tOK9Z2ZZfqgJQ+ihhy2lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 12:04:32 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 12:04:32 +0000
Date: Thu, 27 Jul 2023 20:04:21 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
Message-ID: <ZMJdRbNoAPWdwk1c@lang-desktop>
References: <20230727075620.728235-1-Lang.Yu@amd.com>
 <329490e4-22d5-043c-e57d-12b029053e15@amd.com>
 <ZMInle4+cxmmiR1h@lang-desktop>
 <87302ce6-cb75-bc7a-72cc-d4f08c04258c@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87302ce6-cb75-bc7a-72cc-d4f08c04258c@amd.com>
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|SA0PR12MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b851ed-d07c-4a00-3aa3-08db8e99a303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqZOZDP7SGjGxxLiYYQtXUpSRy8KoIZ7nUSAZ6z+HpMI2m11VTTzWF8GpsOlClCrifmOgPjhCAGllliVyjFsySX1CJW2Wy+CBs6drOWP5dvJqVfEdd5eXr+ItnBeJbGdz1ShAx4BQ+GKeL1aDzy0+Q7+8wrSZt/VY6lwKRiEi5Bm4Ute5F9LjNWqLeriMyLWGMksMar5ZpHZu61CHJIhCp9koyjl/t4r5gDPGCUby0QVKl3lZVKkF008ivQt+3/kdaVaauuO3kDZ0/+ejIzy37RHndZ5NEUTvNO7UMRYXioAgdsr38Mdgv+i4XSoDg/6hrXBCVqwY6ZEeNonP5NL6ms+e2cwnDtBKH7M3sWFMcYOtdwULcR/oZD/rfiGNVeemz1cYNoesccgGjfqYoc/uuCIHVqRe2vh6drCgi9c0ZDNaXrwST2OSP77TrBMpXxZnrk1isKPHAVPcsWw+jf0W/cEXg6NGf+utW0iHfX43xHWbxSpzvt/CDeEJkxqAcrOJB4XiTv2YCCegv7txay95c8QftRmzKQMYenYibtO/zkIyarzN/fypatvspGfCQW+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(2906002)(316002)(8936002)(8676002)(6862004)(5660300002)(41300700001)(33716001)(86362001)(6486002)(6666004)(54906003)(478600001)(66574015)(26005)(6506007)(186003)(9686003)(66946007)(66556008)(83380400001)(38100700002)(6512007)(66476007)(4326008)(6636002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?e85yX4Z1iTx6cbeBh9wOoLr/l+2l3GaxEJWMQLuFH9aNo+Iq3gtcTEofzb?=
 =?iso-8859-1?Q?yN61YCi3JgH+F71+fOiIYTrpntla4dV2AZK/cvWQqia8K1l6MZjKZNex9J?=
 =?iso-8859-1?Q?LRz2Bpv2sfaAzcIFb4QqEXSDrBIhQzDcO5jnUdDfvmG8PeVKps3/ig+tEx?=
 =?iso-8859-1?Q?wdhsXqnJ4gUGBubFL5qiMZ8DDPvaTvB5rxL8hYc6j5+6zowUT2k87CuubQ?=
 =?iso-8859-1?Q?tPG0T6jONAl7uW+6+TMNVzALjzuYp/VQmHf25wBqoqDmOsWAaqW4bohI0R?=
 =?iso-8859-1?Q?Macg0rHBd9qEXpobGLAzaS6olVoPcrpkLjtJT08CDhsKH+N7DqqjTmjIIS?=
 =?iso-8859-1?Q?u9NnouEDywCIqLhHZ9IxFIT0Whg/wnmx1WqJU0gEYahOLBdNL+b+CtuXUr?=
 =?iso-8859-1?Q?WN/Mtfgc2pPsy/ui6ODcUkh0/NOPbEBO0kYJ74/35GVv4ots19Wfi2XWX3?=
 =?iso-8859-1?Q?30QIQs7QnqVhD3nQCUXkUhV5VIItnzOce/fBHVNDn3V8XI3+/sgvKEWhiJ?=
 =?iso-8859-1?Q?Gz4EjabOQ4yqCDbIKR1r0kHbgyFQHcHLQ9fyVxwYdHSFG+mxasOjOqk68l?=
 =?iso-8859-1?Q?S3LeNb9TNWSUfVvEvbA3fiIhuQMIa+Fy0T2ztjAUPXr2QmXpNRaS/2zGBA?=
 =?iso-8859-1?Q?ryc/VdNG3MKhYL/XET1coKMuP8Jc2xp1rS2yoLFSp7gSmRpAywl5AZJ9A9?=
 =?iso-8859-1?Q?PUb8JZjXbeULyWNteypDjbrKmiU3frpz2AD35lmdvxs4jqVarPT82XZROW?=
 =?iso-8859-1?Q?y86XRnBCZXSTs80rAQi5ncO9f3shtIyq+/FaqbfqZPISz4SRRoqNeWGCkm?=
 =?iso-8859-1?Q?uhpe8DXCJ/4SLdGTK2JcB/Q491xVGxBQB5lm8pQQvywSW/KjFnak/Ona3d?=
 =?iso-8859-1?Q?qYqnWlPyCYKFEk6+nvRQUbsTz+j9s0vDSrhEL827bPT7r7JnenxWsVv+uD?=
 =?iso-8859-1?Q?oJ+le/nNFjguRK7GoH39I0+xiyTSEZY44/Ml0vI0qqAW6HgI6sOHL/4hRx?=
 =?iso-8859-1?Q?aLyGHNwj6d4mqX2vqoAm62Rdzs0VexUX154HD4vNSQ0st5ry0reo1R5raZ?=
 =?iso-8859-1?Q?pjnOdyNTQ6hPhR/hzBJ5eSTu32p3aLBSYaeed7JCCZg8JrjHUqWXQ66Eu7?=
 =?iso-8859-1?Q?eGSVCWfdsv8sysDrwhsAgq7/JaPuCWHugdB6c8yaVSf6S/B8m1stXqz+Li?=
 =?iso-8859-1?Q?6b6Kt+SGeIbW64WgSsCwmt5KH8en/EAOr72MViltDwZyvlhyPpk1/iTVAm?=
 =?iso-8859-1?Q?qIZh5m4kXbpRSeqPuq4BRHfTcrZSYh9D4UaJjgQQAaoT2entY2jyfRFj72?=
 =?iso-8859-1?Q?xYCOyaUq7jf1WGpCEfgBlFPXSZxEbhHrN0AoJHb7PgTNvJwZTTE6lUtZb3?=
 =?iso-8859-1?Q?anmITrQAk3Y+oCTa+KUakooeI+V/M93SVvBGYCq/4ux4JFvhpvy9x52MIJ?=
 =?iso-8859-1?Q?lmTStmF95goFMlxPao2zQ7R+t3x1BvDobTIptfhIMca6BumjkHggYfemvo?=
 =?iso-8859-1?Q?enT2Efu4po96fffl+oOgIMVSuZNL0J+ubIxtb8LjqJtE4TbQNzMblDUAs/?=
 =?iso-8859-1?Q?tb6K5BiRniQGmmaW7G9yBpAinLOD0wa2SsQkmbzNrxA1GdgVxl99o+vJuH?=
 =?iso-8859-1?Q?DLABHg3wuAsbc5CakHY/H9iCR4hPqqV+Kc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b851ed-d07c-4a00-3aa3-08db8e99a303
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 12:04:32.0997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yREHv2T4z3nSxM8VhQFJ5sPUea2B/Evnl2jAfa4nfhJULVMP7lNVNMu+R/eAv069rJeJODN5cNuJTNG2IDK1IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
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
> Am 27.07.23 um 10:15 schrieb Lang Yu:
> > On 07/27/ , Christian König wrote:
> > > Am 27.07.23 um 09:56 schrieb Lang Yu:
> > > > amdgpu_bo_create_kernel_at() is used to create a physical
> > > > contiguous VRAM BO at the specific offset. It calls
> > > > amdgpu_bo_create_reserved() to create a VRAM BO first,
> > > > then frees its old memory and allocates new memory at
> > > > the specific offset. But amdgpu_bo_create_reserved() would
> > > > fail if requested VRAM BO size is too large(>128MB) on
> > > > APU which usually has a small default VRAM size(512MB).
> > > > 
> > > > That is because VRAM fragmentation and DRM_BUDDY_RANGE_ALLOCATION
> > > > is not natively supported by amdgpu_bo_create().
> > > > 
> > > > The approach is using amdgpu_bo_create_reserved() to
> > > > create a BO in CPU domain first, it will always succeed.
> > > > Then use amdgpu_bo_pin_restricted() to move the BO to
> > > > requested domain and location.
> > > That won't work like that.
> > > 
> > > The amdgpu_bo_create_kernel_at() function is used to take over specific
> > > memory areas from the BIOS and *not* to create a large VRAM BO.
> >    Literally, it is creating a VRAM BO.
> 
> No, it doesn't.
> 
> amdgpu_bo_create_kernel_at() creates a BO for a predefined offset in VRAM.
> 
> E.g. the BIOS says to us you can find the table at offsets 0x12345678000 in
> VRAM and during driver load we create a buffer object for this so that we
> can map or copy it away.
> 
> > 
> > > Allocating the initial dummy in the CPU domain is a good idea to avoid
> > > overlap, but you are messing this up quite a bit here and will probably
> > > break tons of stuff.
> >    I don't see it breaks something.amdgpu_bo_create() doesn't support
> >    DRM_BUDDY_RANGE_ALLOCATION. Actually it works, this approach is just using
> >    DRM_BUDDY_RANGE_ALLOCATION to satify such allocation request.
> 
> The big difference between amdgpu_bo_create_kernel_at() and
> amdgpu_bo_create_kernel() is that the allocated VRAM is not initialized to
> zero.
> 
> E.g. we keep the original content the BIOS has placed there for us. With
> your modifications that content would be overwritten.

Thanks, I got it. But it looks like only ttm_bo_type_device would be
initialized to zero. 

	switch (bo->type) {
	case ttm_bo_type_device:
		if (zero_alloc)
			page_flags |= TTM_TT_FLAG_ZERO_ALLOC;
		break;
	case ttm_bo_type_kernel:
		break;
	case ttm_bo_type_sg:
		page_flags |= TTM_TT_FLAG_EXTERNAL;
		break;
	default:
		pr_err("Illegal buffer object type\n");
		return -EINVAL;
	}

Yes, it would be overwritten. That's not expected.

Regards,
Lang

> Regards,
> Christian.
> 
> > 
> >    Reagrds,
> >    Lang
> > > Regards,
> > > Christian.
> > > 
> > > 
> > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > ---
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++++++++--------------
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 15 +++++------
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  2 +-
> > > >    4 files changed, 21 insertions(+), 29 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > index ff73cc11d47e..331daa47a444 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > @@ -358,6 +358,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
> > > >     * @offset: offset of the BO
> > > >     * @size: size of the BO
> > > >     * @bo_ptr:  used to initialize BOs in structures
> > > > + * @gpu_addr: GPU addr of the pinned BO
> > > >     * @cpu_addr: optional CPU address mapping
> > > >     *
> > > >     * Creates a kernel BO at a specific offset in VRAM.
> > > > @@ -367,42 +368,33 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
> > > >     */
> > > >    int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
> > > >    			       uint64_t offset, uint64_t size,
> > > > -			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
> > > > +			       struct amdgpu_bo **bo_ptr,
> > > > +			       u64 *gpu_addr, void **cpu_addr)
> > > >    {
> > > > -	struct ttm_operation_ctx ctx = { false, false };
> > > > -	unsigned int i;
> > > >    	int r;
> > > >    	offset &= PAGE_MASK;
> > > >    	size = ALIGN(size, PAGE_SIZE);
> > > >    	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
> > > > -				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
> > > > -				      cpu_addr);
> > > > +				      AMDGPU_GEM_DOMAIN_CPU,
> > > > +				      bo_ptr, NULL, cpu_addr);
> > > >    	if (r)
> > > >    		return r;
> > > >    	if ((*bo_ptr) == NULL)
> > > >    		return 0;
> > > > -	/*
> > > > -	 * Remove the original mem node and create a new one at the request
> > > > -	 * position.
> > > > -	 */
> > > > -	if (cpu_addr)
> > > > -		amdgpu_bo_kunmap(*bo_ptr);
> > > > -
> > > > -	ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);
> > > > +	amdgpu_bo_unpin(*bo_ptr);
> > > > -	for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
> > > > -		(*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
> > > > -		(*bo_ptr)->placements[i].lpfn = (offset + size) >> PAGE_SHIFT;
> > > > -	}
> > > > -	r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
> > > > -			     &(*bo_ptr)->tbo.resource, &ctx);
> > > > +	r = amdgpu_bo_pin_restricted(*bo_ptr, AMDGPU_GEM_DOMAIN_VRAM,
> > > > +				     offset, offset + size);
> > > >    	if (r)
> > > >    		goto error;
> > > > +	if (gpu_addr)
> > > > +		*gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
> > > > +
> > > >    	if (cpu_addr) {
> > > >    		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
> > > >    		if (r)
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > > > index 5d3440d719e4..8f5b5664a1b6 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > > > @@ -315,7 +315,8 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
> > > >    			    u64 *gpu_addr, void **cpu_addr);
> > > >    int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
> > > >    			       uint64_t offset, uint64_t size,
> > > > -			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
> > > > +			       struct amdgpu_bo **bo_ptr,
> > > > +			       u64 *gpu_addr, void **cpu_addr);
> > > >    int amdgpu_bo_create_user(struct amdgpu_device *adev,
> > > >    			  struct amdgpu_bo_param *bp,
> > > >    			  struct amdgpu_bo_user **ubo_ptr);
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > > > index 7c6dd3de1867..a210c243dac0 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > > > @@ -1619,7 +1619,7 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
> > > >    					  adev->mman.fw_vram_usage_start_offset,
> > > >    					  adev->mman.fw_vram_usage_size,
> > > >    					  &adev->mman.fw_vram_usage_reserved_bo,
> > > > -					  &adev->mman.fw_vram_usage_va);
> > > > +					  NULL, &adev->mman.fw_vram_usage_va);
> > > >    }
> > > >    /**
> > > > @@ -1644,7 +1644,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
> > > >    					  adev->mman.drv_vram_usage_start_offset,
> > > >    					  adev->mman.drv_vram_usage_size,
> > > >    					  &adev->mman.drv_vram_usage_reserved_bo,
> > > > -					  &adev->mman.drv_vram_usage_va);
> > > > +					  NULL, &adev->mman.drv_vram_usage_va);
> > > >    }
> > > >    /*
> > > > @@ -1729,8 +1729,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
> > > >    		ret = amdgpu_bo_create_kernel_at(adev,
> > > >    						 ctx->c2p_train_data_offset,
> > > >    						 ctx->train_data_size,
> > > > -						 &ctx->c2p_bo,
> > > > -						 NULL);
> > > > +						 &ctx->c2p_bo, NULL, NULL);
> > > >    		if (ret) {
> > > >    			DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
> > > >    			amdgpu_ttm_training_reserve_vram_fini(adev);
> > > > @@ -1742,7 +1741,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
> > > >    	if (!adev->gmc.is_app_apu) {
> > > >    		ret = amdgpu_bo_create_kernel_at(
> > > >    			adev, adev->gmc.real_vram_size - reserve_size,
> > > > -			reserve_size, &adev->mman.fw_reserved_memory, NULL);
> > > > +			reserve_size, &adev->mman.fw_reserved_memory, NULL, NULL);
> > > >    		if (ret) {
> > > >    			DRM_ERROR("alloc tmr failed(%d)!\n", ret);
> > > >    			amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
> > > > @@ -1885,14 +1884,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> > > >    		r = amdgpu_bo_create_kernel_at(adev, 0,
> > > >    					       adev->mman.stolen_vga_size,
> > > >    					       &adev->mman.stolen_vga_memory,
> > > > -					       NULL);
> > > > +					       NULL, NULL);
> > > >    		if (r)
> > > >    			return r;
> > > >    		r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
> > > >    					       adev->mman.stolen_extended_size,
> > > >    					       &adev->mman.stolen_extended_memory,
> > > > -					       NULL);
> > > > +					       NULL, NULL);
> > > >    		if (r)
> > > >    			return r;
> > > > @@ -1901,7 +1900,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> > > >    					       adev->mman.stolen_reserved_offset,
> > > >    					       adev->mman.stolen_reserved_size,
> > > >    					       &adev->mman.stolen_reserved_memory,
> > > > -					       NULL);
> > > > +					       NULL, NULL);
> > > >    		if (r)
> > > >    			return r;
> > > >    	} else {
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > > > index 41aa853a07d2..b93b42b916ce 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > > > @@ -397,7 +397,7 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
> > > >    		 */
> > > >    		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
> > > >    					       AMDGPU_GPU_PAGE_SIZE,
> > > > -					       &bo, NULL))
> > > > +					       &bo, NULL, NULL))
> > > >    			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
> > > >    		data->bps_bo[i] = bo;
> 
