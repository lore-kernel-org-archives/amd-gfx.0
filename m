Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A7EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 06:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1272610E3A9;
	Wed, 16 Mar 2022 06:22:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2215810E3A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 06:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiCamf9xBMxzCYGeoVHoVq84CKRjXO4g7JUTDQrblPD0qsDZe5zoY5w+2WI4VVCn5/jUSZySTCPIoQJOxRk4yvewaDSLTXHqvgyLdGwEXdRBNLqsYnsCTAs02vm5G02rqXH3Bok47v6q+HrCzdQeRUPpR/5uimzusPecdRswcUy3vmfC+bLXQEEC21sV/etgKSsDQjuY4aoQyeBKg6ikfISyrdvkIUGVb6kUn4se5xG6YB1AYI7sf4nG7IKMSTor1KlAEqlDAHAkV2SbvDPeeb9LWNTlBpdZUEZ6lm1eu+vGG/uA40fs5GnYC7VDwqIMo3NpexzN7IIo71LBpLDEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Erb+DvjDMYGxZ2NosDL4Ir94hNPneXK4aq3rOVFTjxc=;
 b=TqGKXEMiUVIIQwOIHaGiEjktYudSEKGyW8RORVJwunLntxRbEm/fSzTR1XTu6iQyA2cz/knhOUbCveSOrZHlpK2ObNOFUeZCUF2KoroPMWoIAz0nIbRaes1/MATBlLzJM8WAHxOk1o/uMPsi9lh/23W2hiollRAOH88efOFisWiG7fe44YQR2fwBWmENTfkC5XI5f/hBHF7NQQ4gSd9hD/jZUMrq+uAKKcjBzFdYC6vK8r7SKlmCH55wV03tmJhwYEel0uGCXn6a2fL7LCV4gxOUU9HWX9TU6EKGPN8EOmqh3TuhZXVMNy6SbB5QEaKIxjB8eMIuKmGkqkZrCK8oMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Erb+DvjDMYGxZ2NosDL4Ir94hNPneXK4aq3rOVFTjxc=;
 b=Wm/08yDRXuwtHo9szvk4zA1i/Nn+dzjMlWy72pX/00uyaAu9qQ1Q1Isi5QqR1OSFen+wD/dyMP6QQ9wqXuZvSOlyX8xkj+FzTwwWfmVJ2/dvxQKaZt6xfTR75Xm0dJcZljJ/cOTDnhFl3dqHr4Q+U2/1eed0X0HiD7T1SqlNmjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 MWHPR1201MB2543.namprd12.prod.outlook.com (2603:10b6:300:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 06:21:54 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f%9]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 06:21:53 +0000
Date: Wed, 16 Mar 2022 14:21:44 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v3] drm/amdgpu: add workarounds for VCN TMZ issue on
 CHIP_RAVEN
Message-ID: <YjGB+Dx4nUIOyuMf@lang-desktop>
References: <20220314024519.2201231-1-Lang.Yu@amd.com>
 <39dcbcab-8a92-4a01-e355-6e37ac4f1ce6@molgen.mpg.de>
 <YjE9CDYjvJ72IQNg@lang-desktop>
 <c502a443-0987-6d88-1ef3-603723f04634@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c502a443-0987-6d88-1ef3-603723f04634@molgen.mpg.de>
X-ClientProxiedBy: HK2PR04CA0075.apcprd04.prod.outlook.com
 (2603:1096:202:15::19) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ad5153f-e25c-4e7e-a100-08da0715438f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2543:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB254368F93588653E1B2B8923FB119@MWHPR1201MB2543.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: madDYLdDmI5kCjDuOvlcoAAkEsrITpXD9oaauwXAjIWehvCXELd/rcMZhJhBcgxuYGF5hAg3sPZCss2p8kL2ct/cxcxxVS7yfmArmd1G3HgFv23MNRt9FqsNslqxhex9qWV1Az7fTYMeTC6uMfgk6FZ36kUlTRa700ldKRWVFJkXn2Gvz3S0usQVTghrMkPbd5r9b1GwA7sKXZf8839YmYZydVcnQ/SIdjGCNh8UZ9BpAKjkKTmm1/+TMGq2ppxLzIaxMTUNv8lLaeNVQziBIu2neK/qIBKW+1/tysTO8bPnJIrm7l5LSIaVnCKlfQnKgtsnPlGER6md3rsDiehbIC8oe7o/mJCB3dyXHDPimPk75Y1fIBGFcpwbARuTGylHh+Af7Keiki9lqSDpH+BH2yjbPRsHOugaeea8PxXe9+zErt1d/6EifP9EYxtvYsObpQWbA8hR41ln2WCCI8w/Qn5zvbxMjra3v/8D1Hzcfc5i/AOd6jou6oEtLJQO9vdL8rzUsS7aUrLVfZXrXjhqdYfWrHdudcYcezrYPxc4N8xMaOZlUjiBgr512iG71Mh70GCf/evcE4CqC94d9Y12s6i5ApVOAHCsplQCFRVsum+pnq21si/rU87g+cZUnnzTVxYslU+W98KwoFFCo3icVN5HyD6zqJ+lZIl7/6tV9t65EiALY590gSOGc9K//l8LR23U7Kgby2uLLnhuPu2MWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(7916004)(366004)(508600001)(38100700002)(6666004)(6486002)(5660300002)(8936002)(2906002)(6506007)(6512007)(9686003)(33716001)(66574015)(54906003)(316002)(83380400001)(6916009)(66476007)(8676002)(4326008)(186003)(66946007)(86362001)(66556008)(26005)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWlqcG44M0Z2MUtDNzdOOHcwNHF2ZXZCT0x1V0JZdXl5RWxpY0xSUkY3THNj?=
 =?utf-8?B?RkQwTU1rdERrMFlLeUFNQUpJMU4ycnI0WlFSV0dCcVRHbWRySzQ1NDVuNXNi?=
 =?utf-8?B?YzFWT20veFdzaW54eEM4MHBjVll3TEQxdXFBSzNDczJoUkxQa1RtSWJTT2sr?=
 =?utf-8?B?QjZVZ012dVFWSXJVR2tydFExMjU2OVVvcmJld3JRMmxsazNBOElCUjNsdXl6?=
 =?utf-8?B?RWFSa1NPUDFqQUdqc2ZERWFOM0k5YnZtKzcwa3lZcldpNGNzd05kVGlCSjF0?=
 =?utf-8?B?TUNTMjg0dmI4TVFSWHNySnFJeldzbGpsMmQ1UGdRd2Rlb3N5dFlVU1FSWkV1?=
 =?utf-8?B?U01JL05ub0NwTUFkMWxDc0xudGJJV1pjYk1YY01lRFlCK0NGRXM4WDhBdTQy?=
 =?utf-8?B?a0dWcXUxZjYzdTNrZHc2SjdWQ0VYaGxZeHFPaEUwcTlDRlhxYVppclhQeGJP?=
 =?utf-8?B?WDRLcVdpb1FaSG5qcE00WlhWODdGK2ZqY2NpNnAvT2xFWVR4encvYmVxSFlj?=
 =?utf-8?B?WWN3VXpRaGV6Sk5LV3Y1cFYxWXQ4VWhCMThCUEZ1VXdsVHI4eGJNcWtLOElk?=
 =?utf-8?B?MkxKQWlkcVpLVVFDeGxSVjd2NEVtbGxScUFYNENHblpia2svZm1pR2E5dU4v?=
 =?utf-8?B?N1BDaUdQUkx2dSs4V0djSXFiaFRrZEthclVvZGJzQU5CNk1ibEJtVHFhQi95?=
 =?utf-8?B?VzNMK0lQaUg2akpmR2N5VWZFN3phcjdhVzNPTnJpUlhUV09pS1FWTTdYdmNa?=
 =?utf-8?B?bHZnSTBranMrVk1yTzA2QkUwVjdNUTdTRW5EdXA0cEpoR0pLZkZ4Y3EzZzli?=
 =?utf-8?B?ZEJXL2o0SzJVeUhNN3BmMzNGODk5VmFsRmxIeWVKbkp1NjhiVVRsRTh2RCty?=
 =?utf-8?B?SkMvb0lvTzBUV2tjNEhBcFRkL2pkVkh6aEJRTDd6UXBtSGd2QTFhMVo3czBM?=
 =?utf-8?B?OXZwN2Z5b1Fyb1ZuMERNYUg1ZHgxN0VGOTRDWWxyek53cEcyaE5MY3Q1cDlw?=
 =?utf-8?B?b1l2OVdXVklxYWUzWmdXa1FGWWpLMi95bFBEVFhjRW9nY2tJbEdqd2RISXlE?=
 =?utf-8?B?dzB1YnhCSEJrQ29Yc1RyWTVWVjBKTU4yYmUzV3kvT1ArNzFUOE9DQzdpSGZt?=
 =?utf-8?B?R1ZFNHN6Zi91M0RSRVNaZWhsV1lJMnJoRHBhVS9mWWZzdFVGN1BwazhuMDBC?=
 =?utf-8?B?VE9LNTdqSkkreXhhdnRrczQvNUR0M3VVSXpFbHRUM0hYeXNVMzV2Yzl4bTcr?=
 =?utf-8?B?dUc4Vmx2OXJjbWo3Y0RBTGNvVDZKTGlSOW55N3ZyY3Q4ZE1EaXpmeTcxbnU3?=
 =?utf-8?B?UWxYR24rUUtLeFdIUjRadUdGUmVyYXZkSWJ6WGFvWjgxL2thRUlxT3Exc3NK?=
 =?utf-8?B?ZWo3bkRhT21IV2pEZ1FGWXhBejRGZWpqOWdZR1pBZzlXL0I4OEpTb1dLcm9E?=
 =?utf-8?B?TGtYOXdaejNYNXgyMlMzcEpBOVJmeEdYbk13TUxLcVAyOXJoRTF5TzZpVmtY?=
 =?utf-8?B?ZWt3eHlQSnVNRlIxUFdMMEgwRlV1YkkwWkQ2NC84Z2Y1TENES25ldkN5ZFo1?=
 =?utf-8?B?S3FOdjQ5K1BicWdJRkFMckhRM1BhczEwZzUyWnFWSmpQR0ZQSll4SlplbGZa?=
 =?utf-8?B?S3R1cFJWd3dadyszbEh4YWFlUnFHTmlqdzZWd2RGNmFnMndtN2k3ZE5UZVRp?=
 =?utf-8?B?Sjd5UkdhdGJla3hWaVEzWlZPckZtTFJVTnpHNC9kSCtlSTErT0NrbWZFbFRK?=
 =?utf-8?B?cGJyZVo4akpOaGVSVEI3RzkzQ0o3TmdkenRKa1pCbTlDOHNFVEZWQmZOTnFs?=
 =?utf-8?B?MnIrMy9NWEQzUHRPcEI4b0FlYjc4eDhLMjVGSFdGRmFPTzJzSTBxamZ2ZDdk?=
 =?utf-8?B?dTZIcHZmRVZ0ZGlFdlplWm1uWEl6VUVKcGM0UXlncWZrcDA3aWIxa1pVaDNK?=
 =?utf-8?Q?J2ZRga9X1FjuRn8rtv7sguMhEPySPEMF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad5153f-e25c-4e7e-a100-08da0715438f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 06:21:53.9445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQyLT166iaBUwr6L6J1dETzRtkyic0SUDTaKGiAgUOYPNGBZdzmQUTlD98rrgfOfX/GQlRJs176iV0ERQrUi2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2543
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
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 03/16/ , Paul Menzel wrote:
> Dear Lang,
> 
> 
> Am 16.03.22 um 02:27 schrieb Lang Yu:
> > On 03/15/ , Paul Menzel wrote:
> 
> > > Am 14.03.22 um 03:45 schrieb Lang Yu:
> > > 
> > > Thank you for your patch. A shorter commit message summary would be:
> > > 
> > > > drm/amdgpu: Work around VNC TMZ issue on CHIP_RAVEN
> > > 
> > > > It is a hardware issue that VCN can't handle a GTT
> > > > backing stored TMZ buffer on CHIP_RAVEN series ASIC.
> > > 
> > > Where is that documented, and how can this be reproduced?
> > 
> > It is documented in AMD internal Confluence and JIRA.
> > Secure playback with a low VRAM config(thus TMZ buffer
> > will be allocted in GTT domain) may reproduce this issue.
> 
> It’d be great if as much of the details from this non-publicly accessible
> information could be added to the commit message, and a way to reproduce
> this as there does not seem to be a test for this. (Also I guess a tag with
> a reference to the internal issue would be acceptable, so in case more
> question surface in the future.)

Thanks. I will add an internal link.

Regards,
Lang

> > > > Move such a TMZ buffer to VRAM domain before command
> > > > submission as a wrokaround.
> > > 
> > > workaround
> > > 
> > > Please use a text width of 75 characters per line.
> > 
> > Thanks for your comments. I will take care about this.
> > 
> > > > v2:
> > > >    - Use patch_cs_in_place callback.
> > > > 
> > > > v3:
> > > >    - Bail out early if unsecure IBs.
> > > > 
> > > > Suggested-by: Christian König <christian.koenig@amd.com>
> > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > ---
> > > >    drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 71 +++++++++++++++++++++++++++
> > > >    1 file changed, 71 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > index 7bbb9ba6b80b..1ac9e06d3a4d 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > @@ -24,6 +24,7 @@
> > > >    #include <linux/firmware.h>
> > > >    #include "amdgpu.h"
> > > > +#include "amdgpu_cs.h"
> > > >    #include "amdgpu_vcn.h"
> > > >    #include "amdgpu_pm.h"
> > > >    #include "soc15.h"
> > > > @@ -1905,6 +1906,75 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
> > > >    	.set_powergating_state = vcn_v1_0_set_powergating_state,
> > > >    };
> > > > +/*
> > > > + * It is a hardware issue that VCN can't handle a GTT TMZ buffer on
> > > > + * CHIP_RAVEN series ASIC. Move such a GTT TMZ buffer to VRAM domain
> > > > + * before command submission as a workaround.
> > > > + */
> > > > +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
> > > > +				struct amdgpu_job *job,
> > > > +				uint64_t addr)
> > > > +{
> > > > +	struct ttm_operation_ctx ctx = { false, false };
> > > > +	struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
> > > > +	struct amdgpu_vm *vm = &fpriv->vm;
> > > > +	struct amdgpu_bo_va_mapping *mapping;
> > > > +	struct amdgpu_bo *bo;
> > > > +	int r;
> > > > +
> > > > +	addr &= AMDGPU_GMC_HOLE_MASK;
> > > > +	if (addr & 0x7) {
> > > > +		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr/AMDGPU_GPU_PAGE_SIZE);
> > > > +	if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
> > > > +		return -EINVAL;
> > > > +
> > > > +	bo = mapping->bo_va->base.bo;
> > > > +	if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
> > > > +		return 0;
> > > > +
> > > > +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> > > > +	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> > > > +	if (r) {
> > > > +		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
> > > 
> > > to validate
> > > 
> > > > +		return r;
> > > > +	}
> > > > +
> > > > +	return r;
> > > > +}
> > > > +
> > > > +static int vcn_v1_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
> > > > +					   struct amdgpu_job *job,
> > > > +					   struct amdgpu_ib *ib)
> > > > +{
> > > > +	uint32_t msg_lo = 0, msg_hi = 0;
> > > > +	int i, r;
> > > 
> > > Use unsigned int for the counter variable?
> > 
> > You can see both signed and unsigned are used in kernel.
> > (e.g., mm/page_alloc.c).
> > 
> > For this case, I think it makes no difference.
> > 
> > In a word, we should consider the specific context.
> 
> Although it makes technically no difference, I prefer to use the best
> matching type to convey the intention of the variable to the reader. But you
> are right, there is no hard rule for it.
> 
> 
> Kind regards,
> 
> Paul
> 
> > > > +
> > > > +	if (!(ib->flags & AMDGPU_IB_FLAGS_SECURE))
> > > > +		return 0;
> > > > +
> > > > +	for (i = 0; i < ib->length_dw; i += 2) {
> > > > +		uint32_t reg = amdgpu_ib_get_value(ib, i);
> > > > +		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
> > > > +
> > > > +		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
> > > > +			msg_lo = val;
> > > > +		} else if (reg == PACKET0(p->adev->vcn.internal.data1, 0)) {
> > > > +			msg_hi = val;
> > > > +		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
> > > > +			r = vcn_v1_0_validate_bo(p, job,
> > > > +						 ((u64)msg_hi) << 32 | msg_lo);
> > > > +			if (r)
> > > > +				return r;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >    static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
> > > >    	.type = AMDGPU_RING_TYPE_VCN_DEC,
> > > >    	.align_mask = 0xf,
> > > > @@ -1914,6 +1984,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
> > > >    	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
> > > >    	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
> > > >    	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
> > > > +	.patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
> > > >    	.emit_frame_size =
> > > >    		6 + 6 + /* hdp invalidate / flush */
> > > >    		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
> > > 
> > > 
> > > Kind regards,
> > > 
> > > Paul
