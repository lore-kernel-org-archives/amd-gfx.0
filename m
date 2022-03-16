Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4482AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 01:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8EB210E0E5;
	Wed, 16 Mar 2022 01:27:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB9A10E0E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 01:27:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aA6j/l9ZvmSV0tLayFEiyUE0zv/rC9PQifQItUsVNlnEcv4ljbU1U9TYDikY42llO3UZyEXX0q8tPuTrm3LdotmIr9IW7M4C4TNlP1lSelZpuhd9HGgo3NqSLJhKmaflXeEZLg7s+HzaT8UiMYxJjAmLvjVdNtjp8wIpYbiY22FaAKVNska/ZRDVhQAx6FNGyieEYkmDuZSyA79jm2M86YL9bTc4ShmjZv/93Pd4EXnEfpFseE2uv/xhpgSYxODYKeYLxbXV/PiQEHMa59Izx+cybevwrNa7+cn30xbc6yus2jc9UdVnGhCfd6dSJj0z8RTmJJFdTUCuw+s96RoEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38whLb0xl/MmPcBfm7WHROlglFWI5uZndtVZ6AYpguM=;
 b=S6Jg7dVr8PytbbAgWPT2gzZw2b+rnMvfsRQNptfseagnHxQ+fx6HeuhhSt3RpbCbi3v7hORKYxiZ7gE5FBJfXoz8n9xzlDFFCyLMl+VCwYbtAk+nAXtXAkQWW+3/HFZFVSPaxKrTFGyEH6ac4Cl7ap7aYs8gvanQ+90mJJjcl13vQxqvFP6EXmwoC1YOl3GDK/QFJYVQdNqFiZFS8jyYuTu4SGixeePpdxiwfnwpHhAmYoH/757GiSfjtJlkU43qflKB43peTBI5Fi3hhTTnjDoEWse3mnMdbuvu45gGl51OcwRCbdlWwYPupnkGJidfiGCBTZEWfXOptfwJzZnhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38whLb0xl/MmPcBfm7WHROlglFWI5uZndtVZ6AYpguM=;
 b=SJBYVcTNY66F9J3CnEvhQP++pJqAESgkSDcQy3hzxF1ouA+8biMs7z1XDvox120EgUznXBEAqFZlWmsj7aLz/AAc2b2XyfHYPmJmzr5upGRhapFC1YGV0qEcxyqRGPlmzfNPTimk208HfGkZcfIvRlRh6dCz+ZGibP3t6oRUWZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 by DM6PR12MB4826.namprd12.prod.outlook.com (2603:10b6:5:1fd::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 01:27:54 +0000
Received: from MN2PR12MB4256.namprd12.prod.outlook.com
 ([fe80::bc84:f611:60f6:2267]) by MN2PR12MB4256.namprd12.prod.outlook.com
 ([fe80::bc84:f611:60f6:2267%3]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 01:27:53 +0000
Date: Wed, 16 Mar 2022 09:27:36 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v3] drm/amdgpu: add workarounds for VCN TMZ issue on
 CHIP_RAVEN
Message-ID: <YjE9CDYjvJ72IQNg@lang-desktop>
References: <20220314024519.2201231-1-Lang.Yu@amd.com>
 <39dcbcab-8a92-4a01-e355-6e37ac4f1ce6@molgen.mpg.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39dcbcab-8a92-4a01-e355-6e37ac4f1ce6@molgen.mpg.de>
X-ClientProxiedBy: SG2PR06CA0118.apcprd06.prod.outlook.com
 (2603:1096:1:1d::20) To MN2PR12MB4256.namprd12.prod.outlook.com
 (2603:10b6:208:1d2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47ed779e-a9f1-4a43-2d45-08da06ec3120
X-MS-TrafficTypeDiagnostic: DM6PR12MB4826:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48265A1393F1C770EB78EC10FB119@DM6PR12MB4826.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: La7m2kL9CvICJDq272c7Lwcm3CkhbAZVIuMu5aZOXB6IBuSRcp0E/Z2bVPeu5+g18oVrXNGC9MyuOhc+4GCl4MDlPqnI1JQvgvaeOGT4Bxf/ga/OB9Epi9d1NwOaCBPt6q1OYTkpp88ez9+AnzUTecJhVGzwkjeOSSLX6MLZxhZDaY6JrZLKZNR7CC031tT4a964q4uVM5by/zdmmdstXU2aBj/cgcj1vqVnhtx7oZLHs8wu0G+Hl3gGQU/T2im63/zG/bHHzF+XNkLKzLCj+aje41ulYi9C0z/1cShf13IXl1LP3JMcmbVqulKL9A2h5N9tVwuOhrd1CL7DL5mivqdUG5FW1VF7fZI+ff4VE0RlQDkERUG6T6YDiJgYJlZ8ZY2Z9+o2/8wTaV0Y0IyWTBXsGgtWXk9XRrC/OTxwxIP64z2JHxbZQnQA9Lg8xcbhl/zauKIPDqU9b8LXkNPVuXo8pbfJJ9oFzWDXZn24bt6HbVeQ2+YlGX3RTSbPEhe5x+djwXxB8groxsyplDt3plkaB8JhQtI1gOZczJiVQYoIUL4ZXqEUJP8Ef+LvPqgRylAMVjVmwzq6fZZKAfH6ou5ABrTP/PYFvE29TwvL5pWSOZEJsOV4U+06zNwkNW+dq11st6B25fLho3A86nY+Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(54906003)(66574015)(2906002)(6512007)(316002)(5660300002)(6916009)(33716001)(26005)(83380400001)(186003)(6506007)(86362001)(9686003)(6666004)(508600001)(38100700002)(6486002)(8676002)(66556008)(66476007)(66946007)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HDuaSqArAbzSwZWrupBQWM5TRr+UEYZaY4hmGNYRMq6AxQfham7s0gH531?=
 =?iso-8859-1?Q?aK/pTUGDBn113X/0BZ/vZI5unmUpHo0WtCgw/+vPT3oVBnWK0wGDGO3/Si?=
 =?iso-8859-1?Q?B4hB1ONdCkSk5Rw1SrNhujQkKj3VmcYx0NqT2T1N5RIulI2N24OaO0fWt+?=
 =?iso-8859-1?Q?IJuc7nDdt/DC3IKCgcRb1iJxPJXawqKunF1RW1oZimhknjDhRGvLSnDbeL?=
 =?iso-8859-1?Q?BjODDcDbUqz8s0Kr0hnmhfpaU8+5ixX0j6Doltprls4zUH0Wa+ldoN+joF?=
 =?iso-8859-1?Q?MG1uZ56UoGjvfEaY+3liXWAoTV56Z9RR5f15kv2R9V1HA0BzaUP4O10F2K?=
 =?iso-8859-1?Q?Apx9H2NfKRd1fG7jPgdbaSs9ci+/FNbRLEfskm0T03woOSvytrerOUJn2y?=
 =?iso-8859-1?Q?nVuNRKwlBGHmJhw7BTqvfpSZMHYW9Gbk6qon0OxC3wfJFAHR25EgviqcOi?=
 =?iso-8859-1?Q?3JHaeE7BvLCqS72vLvjmq3YcTsJiYVBsgiIFg9Ccf3dy2gimmOsShBVN+y?=
 =?iso-8859-1?Q?WhHggByPN9iij6uZtmgFRlOCrEd8ZZQgbUH2G6NEyyoyHwM8oNE5Zm9hoO?=
 =?iso-8859-1?Q?QoICzZdJc0PgQjj3KDjs06xfz0u7oHF4ow+/D9Okl6gO1u4r4o92jL5nwr?=
 =?iso-8859-1?Q?mdHWl5NmF8QM/cbwSPfuwT74XFDR2H98ZFqwBwceRcg4l4Fj8wQjcSRWb6?=
 =?iso-8859-1?Q?2YztJ+OkskkSfb3sDEp/yaiQzpGDBsX5l3CNzK+F5YXiV15yMYMGFPMxTO?=
 =?iso-8859-1?Q?dsmW9azmrU12Z7rzVNWZAy+g9j7pCYMj7Wx8TzXxn+3aGSxcfhrqzndV8G?=
 =?iso-8859-1?Q?p6g7DCVWxs1QQ/Ivvey1BGZ7Pve5VIuwhoZ+CYi75xBTlfOFqL08vkK4Au?=
 =?iso-8859-1?Q?OKYvxdrYpp/Bc0TiNKkPs/GjPfiQdCJyjP6dHk0NoAROJKT0LyW+yOGNFi?=
 =?iso-8859-1?Q?hxJbS+rXrFOTOIqa/u91f0BW0v7YkqnA72zI8jmIdSAYqYrI72yNuvskZ0?=
 =?iso-8859-1?Q?eOUXoJlW/K3/tJj1ywpj2k9NIwIurMDU72f5bgtROxqV6B0uW/yaIWtHSH?=
 =?iso-8859-1?Q?Cu74FWVBXnD2dUYaJp3iVWyxF8ulLc7r3x0EXXJ4ux3vqMjpcc6qb3EoDD?=
 =?iso-8859-1?Q?/8u79iKkLHm+nncIKRDtrLxwAJJTpu6yXTsXIgc0P99lxNB1KmympANXsE?=
 =?iso-8859-1?Q?MmBX+R/wGyabVBEatyZJ+ztfcFMCuZ4fmbmpeAnXOA9v87mxjYp6D2OaS9?=
 =?iso-8859-1?Q?csrb3j9iZ7jPi9aZs2K1s7Q+4HfliqvBgMZcolP+mFtJyJMx1XB9J1sB3x?=
 =?iso-8859-1?Q?2OreppkvNYMs8CKbRNC7Jb1liHCoU4P+KsT9X4T3B1TEeIqQOuS3A9kidC?=
 =?iso-8859-1?Q?5Y0dOAbM1rlJqf/B3TAF5yERnxXkKGLUmDbgHejuCdRH3KzINn65KAlnzN?=
 =?iso-8859-1?Q?Xgz4oWoaU6byhQ1yr8M38B6XN0Fs/pQKfU9GOfG2OPhfWFyrNO1mXtn8zr?=
 =?iso-8859-1?Q?cPRirksd15gc8lRAHCh6DJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ed779e-a9f1-4a43-2d45-08da06ec3120
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 01:27:53.4462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NT4LG7xwYLlRrZdtmHvV2LcpjPqpYS6Ny/wku+XVlKUwlcfhZCt1YbwfuEQzwUsHdSMCvVLapgp/A9mZDHvMzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4826
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

On 03/15/ , Paul Menzel wrote:
> Dear Lang,
> 
> 
> Am 14.03.22 um 03:45 schrieb Lang Yu:
> 
> Thank you for your patch. A shorter commit message summary would be:
>
> > drm/amdgpu: Work around VNC TMZ issue on CHIP_RAVEN
> 
> > It is a hardware issue that VCN can't handle a GTT
> > backing stored TMZ buffer on CHIP_RAVEN series ASIC.
> 
> Where is that documented, and how can this be reproduced?

It is documented in AMD internal Confluence and JIRA.
Secure playback with a low VRAM config(thus TMZ buffer
will be allocted in GTT domain) may reproduce this issue.

> > Move such a TMZ buffer to VRAM domain before command
> > submission as a wrokaround.
> 
> workaround
> 
> Please use a text width of 75 characters per line.

Thanks for your comments. I will take care about this.

> > v2:
> >   - Use patch_cs_in_place callback.
> > 
> > v3:
> >   - Bail out early if unsecure IBs.
> > 
> > Suggested-by: Christian König <christian.koenig@amd.com>
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 71 +++++++++++++++++++++++++++
> >   1 file changed, 71 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > index 7bbb9ba6b80b..1ac9e06d3a4d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > @@ -24,6 +24,7 @@
> >   #include <linux/firmware.h>
> >   #include "amdgpu.h"
> > +#include "amdgpu_cs.h"
> >   #include "amdgpu_vcn.h"
> >   #include "amdgpu_pm.h"
> >   #include "soc15.h"
> > @@ -1905,6 +1906,75 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
> >   	.set_powergating_state = vcn_v1_0_set_powergating_state,
> >   };
> > +/*
> > + * It is a hardware issue that VCN can't handle a GTT TMZ buffer on
> > + * CHIP_RAVEN series ASIC. Move such a GTT TMZ buffer to VRAM domain
> > + * before command submission as a workaround.
> > + */
> > +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
> > +				struct amdgpu_job *job,
> > +				uint64_t addr)
> > +{
> > +	struct ttm_operation_ctx ctx = { false, false };
> > +	struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
> > +	struct amdgpu_vm *vm = &fpriv->vm;
> > +	struct amdgpu_bo_va_mapping *mapping;
> > +	struct amdgpu_bo *bo;
> > +	int r;
> > +
> > +	addr &= AMDGPU_GMC_HOLE_MASK;
> > +	if (addr & 0x7) {
> > +		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr/AMDGPU_GPU_PAGE_SIZE);
> > +	if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
> > +		return -EINVAL;
> > +
> > +	bo = mapping->bo_va->base.bo;
> > +	if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
> > +		return 0;
> > +
> > +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> > +	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> > +	if (r) {
> > +		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
> 
> to validate
> 
> > +		return r;
> > +	}
> > +
> > +	return r;
> > +}
> > +
> > +static int vcn_v1_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
> > +					   struct amdgpu_job *job,
> > +					   struct amdgpu_ib *ib)
> > +{
> > +	uint32_t msg_lo = 0, msg_hi = 0;
> > +	int i, r;
> 
> Use unsigned int for the counter variable?

You can see both signed and unsigned are used in kernel.
(e.g., mm/page_alloc.c).

For this case, I think it makes no difference.

In a word, we should consider the specific context.

Regards,
Lang

> > +
> > +	if (!(ib->flags & AMDGPU_IB_FLAGS_SECURE))
> > +		return 0;
> > +
> > +	for (i = 0; i < ib->length_dw; i += 2) {
> > +		uint32_t reg = amdgpu_ib_get_value(ib, i);
> > +		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
> > +
> > +		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
> > +			msg_lo = val;
> > +		} else if (reg == PACKET0(p->adev->vcn.internal.data1, 0)) {
> > +			msg_hi = val;
> > +		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
> > +			r = vcn_v1_0_validate_bo(p, job,
> > +						 ((u64)msg_hi) << 32 | msg_lo);
> > +			if (r)
> > +				return r;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
> >   	.type = AMDGPU_RING_TYPE_VCN_DEC,
> >   	.align_mask = 0xf,
> > @@ -1914,6 +1984,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
> >   	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
> >   	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
> >   	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
> > +	.patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
> >   	.emit_frame_size =
> >   		6 + 6 + /* hdp invalidate / flush */
> >   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
> 
> 
> Kind regards,
> 
> Paul
