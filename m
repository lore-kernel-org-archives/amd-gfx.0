Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EB2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 07:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1B010EBCC;
	Tue,  8 Mar 2022 07:34:04 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E08010EBBB
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 07:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9Gic5Id8RwzdLRMlPqAEpBN1SIlKNxGhM6VUqpX3KEHM6vc+biqqkL4EQgrsqVcd8jIbzosKXNWDJzmDCcm3wCnx0PhxZVE9eYqQuRFPPLzHTJGAus2G2vzF0gXAh24SMmHUKnE4yxz78fWlIJLF4y98TN23aJrbPbrHjG2kaNpuaqd51t/9n684ywwpwquN6Mg8cL9UocBX7EF5EpLd+3IEQf/QzMYoad4zIohnN4SBc3NzNlV2Nyc6TXoVcb0u2JKgWXZuC+vNpScOmIrpNxKueSiUqesWqlX0j4JJvqUURluT9SwIfdagYWF/G45+w1BZ1YLFdaHVTjo+atcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Awlli2jEEUdHvtx5ElDKI5mHrYjbVqkn0IR46weextg=;
 b=jeFnsoJSGbdpi5mSHCrqyGF9KHpBYox6cvQfepQEAaTy92tInjTgAS9H6HQDEoRVK8SBxExm8U8AAVTIIbRRRJ6w89BrcxG2ZJg3XohaYnJn40aHzFSUalLqynn+vXIF++xJYidQxqdwYed6vPTA6kpBWAt7CiEn1dpsub1KptGQrDsO6u56jPil/HEt+t95OGAXyKzkddsFPYphe9E+3/Ei/UdwJ3x8NMyCnxUmh8UfGhO8j5ROwdP771GDQi7Jjw5BWn1OZMTLyca8wZGknSOIOragQOBQy5FZm2yxLTf/8D4/rbe6UVmBcLvOYxsW9qo9i8wlDVKY94ebMOzhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awlli2jEEUdHvtx5ElDKI5mHrYjbVqkn0IR46weextg=;
 b=IptR0jdK/nXj/rovZy1pnoigbbne1n2C4R/NIpo2kNjDb99YPbpzXtBv1jCq0yHmUOrMZuVwFnlQDmQTCbG1mhRoewoYad5g6tMmdzn9ojfsARmHHyuAnkyDg3VzzlBwlr/Obgg/rwHO9HSYsRHC7eDB7GLKldD5Qe5p0+iAvVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 07:33:58 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f%9]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 07:33:58 +0000
Date: Tue, 8 Mar 2022 15:33:49 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Message-ID: <YicG3THG9sem8Uet@lang-desktop>
References: <20220308033941.999933-1-Lang.Yu@amd.com>
 <0f785eed-9b48-9782-c817-30fbb24eaf4f@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f785eed-9b48-9782-c817-30fbb24eaf4f@gmail.com>
X-ClientProxiedBy: HK2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:202:2e::27) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24da7caa-2e58-4f43-0115-08da00d601cc
X-MS-TrafficTypeDiagnostic: BN9PR12MB5355:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5355775C0CEC58E85FBB0268FB099@BN9PR12MB5355.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Zp5qoZnQVPip2E9Pr4eqI9X1WeHM+uZVveUGtisQOR++wp/+hXV9tdB5tM8CHPu/CUZbjMI8AoQSB4dTFuNGn2m/CDYZc2ogHAHfVmRHDUpGW5u8FkyauFjEKw+gse7YyqUCUtSVZPCx4u5jdPxcofR/kqbfcQFtNbYQdKchge3nrHVz2QCwGq7A5S026Wgq6xeqyHXh04YM4iaq3ccbgT6TVIBHBWero7emdqduywyJu4SwzsjvUgoxjqC/5+L8rNG+CasngHzYNethoI/5RPhLl37srrwyL/CEkzBGNCWlJqslrbvvk0CEjcGkrzccuTyx7R8Zv/H3gHsLm2UwEmOlX10MuJzifS2gnIusMKKS6GGm5JUdoV3FVdi+p8+81imOu7DZlyYz5FL3dUWbx7zOKWolwga1SKyRjCrG0S7eK4+8Rzx9wKVSxFT3Nv3+br61ZQAqr55/a1RsrGDvgHF6n73A+H9JTYT7EqKiZjCM7NrOcCqAc+ZWGFursT5L0ot+KukhDWPH2A68DsmKse3zWWu3Cv+GAEND2oEV46e11GdQQg0WjdwrAHkQ7Auxvq467bovWcFTVZAdvuxI0oKsfujr8QIpx5lEEqnEVBmLTrl7XeF47Y8ujrf10Uv1d98hbd3XJ9Y/2rt729LAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(84040400005)(38100700002)(66946007)(66556008)(66574015)(6916009)(54906003)(83380400001)(33716001)(316002)(6666004)(508600001)(6506007)(86362001)(5660300002)(8936002)(6512007)(26005)(186003)(2906002)(66476007)(8676002)(4326008)(9686003)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jLaQJb283LIpzCzDgYkO77jcRL3dR+m207K7rEgNaOVwpQX4sdCDQavxty?=
 =?iso-8859-1?Q?fBYjQ6RoQ++WpnKKgn5nwarqBIN0dHjniBbNu/hxhjv9DwyuizOMPeFn6z?=
 =?iso-8859-1?Q?lPQQgR8vbOkXJIu8SUk0H6mg0e/aU5yomQELVHAB+8X+zAZVNtdfRsj69m?=
 =?iso-8859-1?Q?UYHGpkFPhHpzsurjqA2veQKgXLDpoqUkwDFjWJodBvzNs/cX4TLqeEsycW?=
 =?iso-8859-1?Q?iTmkuSnmqynqez3c6X0zpf+sIQc3dgp3Ucvs7nOgl12MtkKSqANIfSLGee?=
 =?iso-8859-1?Q?Ujiac3WuYEIDXT3iJhHXPp1QuUp4KixuWZFBsHYmligoEMWRlHOa0l8QJ9?=
 =?iso-8859-1?Q?v4YuXNpfvRF8glOnqrZTbiHU4Gr5EjTBPkHdUmKjFtLyuo7BfbBTiU+wtJ?=
 =?iso-8859-1?Q?ItpwwIj/7x3lL9w4HJ283HWTHnGxfenBLSzkUBhWO7Cl4rnZBfzmi6dmnt?=
 =?iso-8859-1?Q?tavFJ8xkRFi68YB/2uMeRWedY4SGNW3c2xA8+mN9b+BW5tHBtgBrd0J8X+?=
 =?iso-8859-1?Q?aXKSiBpSzTvSBp2N9ZN4DcvxBIy1Ak4kCfOh6YUquj+xzkN9En9PaIkO6Z?=
 =?iso-8859-1?Q?pOSD3fLWCxCZVUidmt8KCIaiPgmRSwjFh8FrU67UG5XafOM+Ww4NukyZQV?=
 =?iso-8859-1?Q?j2KQ5SZjHPdNnvDqU3rHSVvML4j8mTh51rWJ0JIvInR63bOwzieFi67sQ9?=
 =?iso-8859-1?Q?CLivR1vvH8dLtMUBD5cdML608DBB0taolvrxuUcKz0fGI9FEQQpbAdtgqE?=
 =?iso-8859-1?Q?lYBCTyHAY4KISYhP3QOk89JU/9aQk1B71bo1kNay9Q/K+QIhJtP4NNxmFi?=
 =?iso-8859-1?Q?JIXLw5M9T8YWsTchU5ffwKvUr1b7RrNgn9xi+wfwPRUo+q8zC1V5vGMSyE?=
 =?iso-8859-1?Q?CpJw7BJ8GkUsOnff9HI5d/oM0toQRVQwQBLaeCof/T9JEhVdodzQDp8+Eg?=
 =?iso-8859-1?Q?V8uwfznuyD/+nLCWEQQsKvR3Q7H1YWJGHJhyH/Q1HFZ/xiAXrmKh4dUCie?=
 =?iso-8859-1?Q?iQ839TpD068/fPC8Je5gxS8UTCswyamkQ9QsZjKBZ0cIfyQgIJxEL/I6Bm?=
 =?iso-8859-1?Q?2SV7bpt5u0ljgxF6SdgShHiKg/dXQJdNVNLI6O+XdXQnR4Sjf20p6osteE?=
 =?iso-8859-1?Q?qVbW9TP0FZ4i/vpFkEAOUBPG302GSyKsx3BoomGUtP3kKf3Oy07Xyk9cjF?=
 =?iso-8859-1?Q?f0T+QlG95pNnJDhnx0st/hszfEIcU5GG6fjOCTS3BKTVigw5YIiU3PhZ/F?=
 =?iso-8859-1?Q?5XLcBIiUgN1m5gcIAqLn0SoJlTZfYpHdAfp05VHo5rxvIX25AV9rEjhZNL?=
 =?iso-8859-1?Q?QNwoZLg39oSdI11sdNilre+7mLbDFne/Kmbo/Hb/XmVnHTMwp2F6bW7RHr?=
 =?iso-8859-1?Q?dBabB0X5M/uT3+GVtPoIWL5YfvapgzVxrrOokwSedVAnGtoUoEJLLKahCv?=
 =?iso-8859-1?Q?X39cD2iJYvkJA/ErRJYNkAdIpXRcPMO91BrpOTggvL7dloL3Shvq1IYOs1?=
 =?iso-8859-1?Q?HwDgzcT1XtR5v0S3uqyouKXqzhRMl89fBLw+qQDw3+qMF1l9g/w87aGy10?=
 =?iso-8859-1?Q?91pES+1pGodm2z9AHdF7NkYzswY6tXcQiACf3ZPUp1RY8H+x569GZGvXRQ?=
 =?iso-8859-1?Q?IX3yU50GoqSs68mCW6CHSBRaEBRCL9/vVWiuSgbTxNkaasMyz1yevfUPo9?=
 =?iso-8859-1?Q?aVCi8gBlGJyEKX83W4A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24da7caa-2e58-4f43-0115-08da00d601cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 07:33:58.0877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9naxZjMHzj9TmkwJzGAyGpNQPuuG2icNW1JzExrvQ7y6bbiKB8+rckeqX+9fXZHchGeY/av7DTrKG0flWquv2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
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
Cc: amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 03/08/ , Christian König wrote:
> 
> 
> Am 08.03.22 um 04:39 schrieb Lang Yu:
> > It is a hardware issue that VCN can't handle a GTT
> > backing stored TMZ buffer on Raven.
> > 
> > Move such a TMZ buffer to VRAM domain before command
> > submission.
> > 
> > v2:
> >   - Use patch_cs_in_place callback.
> > 
> > Suggested-by: Christian König <christian.koenig@amd.com>
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68 +++++++++++++++++++++++++++
> >   1 file changed, 68 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > index 7bbb9ba6b80b..810932abd3af 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > @@ -24,6 +24,7 @@
> >   #include <linux/firmware.h>
> >   #include "amdgpu.h"
> > +#include "amdgpu_cs.h"
> >   #include "amdgpu_vcn.h"
> >   #include "amdgpu_pm.h"
> >   #include "soc15.h"
> > @@ -1905,6 +1906,72 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
> >   	.set_powergating_state = vcn_v1_0_set_powergating_state,
> >   };
> > +/**
> > + * It is a hardware issue that Raven VCN can't handle a GTT TMZ buffer.
> > + * Move such a GTT TMZ buffer to VRAM domain before command submission.
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
> > +		return r;
> > +	}
> 
> Well, exactly that won't work.
> 
> The message structure isn't TMZ protected because otherwise the driver won't
> be able to stitch it together.
> 
> What is TMZ protected are the surfaces the message structure is pointing to.
> So what you would need to do is to completely parse the structure and then
> move on the relevant buffers into VRAM.
> 
> Leo or James, can you help with that?

From my observations, when decoding secure contents, register
GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ buffer address.
And this way works when allocating TMZ buffers in GTT domain.

Regards,
Lang

> Regards,
> Christian.
> 
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
> > +					     ((u64)msg_hi) << 32 | msg_lo);
> > +			if (r)
> > +				return r;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +
> >   static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
> >   	.type = AMDGPU_RING_TYPE_VCN_DEC,
> >   	.align_mask = 0xf,
> > @@ -1914,6 +1981,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
> >   	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
> >   	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
> >   	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
> > +	.patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
> >   	.emit_frame_size =
> >   		6 + 6 + /* hdp invalidate / flush */
> >   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
> 
