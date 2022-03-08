Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165DAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 08:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4B010ECF0;
	Tue,  8 Mar 2022 08:06:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFFA010ECF0
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 08:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6AlcjR5o4M3n2A9rKUHEQgOdi7eomVNmLkgVVQaB+cqYUARPLIRkWkJ5qINhlNS7FpcfkiUvM79oh8i7prK1VYPWJ0xz+6UrzBikk0bePcRZIiYYoOD6sOYSenpXNJJ0c0+Mfa7HBG8kYdkWVoDtazAgl4W1I8mGQe1j5S9XMokCTAAtFMIclYJN1BHNoTqvREajRoF501SINhY4rynvto1RR2HY+myCYfq30XjI4yJid8YG/TY5e1e8hDW4SX//N2/px+c9Wmpzke6w7AhB2/DJaNGWEaqV6TUPlPCUNP+7c12Lp1qghEr+pstYMqFRH9fvRC2N5UUmstw/LJ6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBkl80nbAreYy9duY9wLCwBp7NPleeDKBhKhvW6uNAo=;
 b=NloYOI6gUZfmpFyy3odnpEcivWQ1eNR2dqnzGz276kv79n8Fdb769h6D6tejrAOGKRhMF1lW+37s+YHNvd44Vh/e2Wp8Us1qBuZM2t6wnxv3Qw+vE1dCmaAJYb8cqVFR8NQseGsE4VE9QQfDi8EMULG1bvyAZBO2PSK3XoIU/2bZxbUJU7wyWwnBFVLS4MihiW+Tj087VW54gTKCtfVJVORIOJfqTDwkHR/kcEhTuFFVF11X/NlY5+MOu/egxKWbAzWMC/XHKAGgoFg0CWV1faNKGuBqsXPZ8Dx/Ao2hP+MsTX/5I+OMSF76HO66+gg93a+UXzwsZ/By1Q0F2Hq9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBkl80nbAreYy9duY9wLCwBp7NPleeDKBhKhvW6uNAo=;
 b=iqu87glRH7jHyLRRSRfjAjwWjahyN5ZpahSW1mm0XKxGU/hjvHSQQfzwJzsv/7HskxSoeaw2mkuFoXIEta8UA5yaPW8DMzCi26IwZ9ZnypBoojpr9V9LctGMxS86PgS5uxOPNYDVBmQZTAbor9rt+Md3jdJc2w1Qn1KnMTj0+eQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BYAPR12MB3525.namprd12.prod.outlook.com (2603:10b6:a03:13b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Tue, 8 Mar
 2022 08:06:52 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f%9]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 08:06:52 +0000
Date: Tue, 8 Mar 2022 16:06:42 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Message-ID: <YicOku9HhC3wJUb8@lang-desktop>
References: <20220308033941.999933-1-Lang.Yu@amd.com>
 <0f785eed-9b48-9782-c817-30fbb24eaf4f@gmail.com>
 <YicG3THG9sem8Uet@lang-desktop>
 <cbebb9b6-705e-e6fc-9ff0-41c35c3ee94b@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbebb9b6-705e-e6fc-9ff0-41c35c3ee94b@gmail.com>
X-ClientProxiedBy: HK0PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::15) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 570acd30-b141-4618-3562-08da00da9ac2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3525:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3525C5F9C18CE83D3C8CE376FB099@BYAPR12MB3525.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6SCjO5KH5h7I7lzWBASJDphRtcL75Xr2SFaay3yhMkAgXc+JugIMh4t8NxN+JGG9NYYPLnakSE//m0fdDscOvUiUuWwCBMCYw6Oion+bFOcateAQAIyfotVOPWdTu73GOrTpXE7pvkKEjY4iws2cfmq5PFD2zNp4JUZ6YfYmnmsvVpeZX95o+DqE3e0xqbJnonfRc6+j7Wcty8vW7EYxXF5c8K5e2DPrakuTcTFwbyzqfK5SYUUCpdA6q7FpU/xUq5sc4SxJeE980q+i6hF71g6B4eris7aIrW6s9823IJDJOt3q21dsyFC9iHv/Ukucqxc76hxaB/JQ15D3Pcc7ASk0ffKY5B7mjKOdC22djVR89Hh+iUFbLpfJdD67Z3ARYsPvSYoC1Dv949vKOokHxMLe/XVQG+GtmkbA2LI9Du9iDkf6xpi+YKAdj/9UWVotqNYR/nbY4m6YNFHGCt3llx26uG+PY7qssD53rlZFttMUE10uYsuKwnt0cvbavL/rBNgu01eaALCeWQ61eZNsIvveUH3oFQnaGDwHG3ez/+RWcTABr1eEeCKr7+NlQHMoRsg4LA5S5tJKoHMlr+y18DRK5bBgQ3Afv3E2ASFLON41MPSEgh6gF7DWl2vsgjI67FZ+mavFSv8SM/OhF7+RfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(84040400005)(6486002)(38100700002)(26005)(9686003)(6506007)(5660300002)(6512007)(2906002)(6666004)(8936002)(508600001)(33716001)(66556008)(66476007)(8676002)(66946007)(186003)(316002)(83380400001)(66574015)(4326008)(54906003)(6916009)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MwkR7jVyq7GGUE69fnjxWymtGkOaumzKCk/35abj3FPhgYOXmibzGzGfZ2?=
 =?iso-8859-1?Q?UNqkV0jr+oaFNDjqJyvuC+n0xuPAotkcgQRsphUSpKUMfS076xJoX2uHW0?=
 =?iso-8859-1?Q?sqs2LCkXmkdypU2knIuDajYwdZ5U7g+E4issbH3th/ot77nfr68c2v0ByU?=
 =?iso-8859-1?Q?1EylrSnLTE79f/vxxbEQbTdrVWseNkIoJff6gnhttfLjm+MqCZQvyFt3CC?=
 =?iso-8859-1?Q?Jh2d+v6n4TTTST3iqgu54NOFnv9hzUNRFRtFz7BVC88wTEkjONTIULIz1W?=
 =?iso-8859-1?Q?RqNOEXFt11afin0X/KrlTc6enIRPCTMfOLp/kLB8twSWsKzd9nP4tISFkO?=
 =?iso-8859-1?Q?3c+oT9E2XUDus3e7mR+5gHA4Fxhdt633CMzSEKe4iWoPhIrNvLISulwuyB?=
 =?iso-8859-1?Q?LPGc/QLDn6963V5XpkXiUHk0jz0l+/E0/UIZXfN53KP129nb2KcMpm0mKd?=
 =?iso-8859-1?Q?na72ScNDuyoAdiRxV+mt8ZjgVMFfUqNd88KO6/+u+m/Dt67ky9IdU0leY7?=
 =?iso-8859-1?Q?VP2/YDpLBSzzVSaiwk3fjEe4zRn8rE4tM85Jtt+QSPXfD84GehIzSiDtW5?=
 =?iso-8859-1?Q?hBMPRZZc6gSL19DxelWAUFbLNxGty4zOT22BuyzFmvrV+qvoYCyrM5R+6l?=
 =?iso-8859-1?Q?ppe1yp+WiJk84pVNPdFkvkTkCWtI7jxjFSrTD2ztMUEh60RBQCuOFQVpNr?=
 =?iso-8859-1?Q?nSBJp5VL4ESK1THogDflFA5/DmLpiSbvxYFGO8/aWkYlnsUlZJO2UgzPsJ?=
 =?iso-8859-1?Q?Vi3ktlEqg/oDS420NXCsHa/w/PpkaasQFuHD+SGtpEWcITTB/+nToFv7fO?=
 =?iso-8859-1?Q?OBJetm0PVmSuo21pVCV5QakdpNuCGq3XvG92UR70EYdti+uQEuXCiROgFh?=
 =?iso-8859-1?Q?uHTzE9EpxeeZl59y4jcPd4houbep+yERRLlZr0XlQ2d5GVnu+2EkZXKYMN?=
 =?iso-8859-1?Q?kjyL1MJdbdJx1UokGslXsuqxLs+an+b6ntPl7PAS+ySytOZfROOxsCf/yL?=
 =?iso-8859-1?Q?z8b4URE9V7KoaMXu8vcFbW3Tb+8VZCVa5V26v++KN+5F3O47U2IZvKsrc/?=
 =?iso-8859-1?Q?x6RxDLmsr9NsKjoIErLBz0s7tRwyQ+TelVDs4lzYWDIaSe5/qm7hzAVuD3?=
 =?iso-8859-1?Q?G8q/kUq/YFUre6iwmmyOm+NHe6EHInrvypZ3jbPuL40mq4Yrde1vH7m0Bl?=
 =?iso-8859-1?Q?yND/ZBl4BU6MIjZFKZNhlphmhu49eiQ65i5Euy+SyNMvpGHEZCM0s/eRjS?=
 =?iso-8859-1?Q?a485Zg2qxWazSoWb39t+c3FXXb30hWEDYB1yPbQRg7ETK8RcrKvEuWfVzO?=
 =?iso-8859-1?Q?/OZC/9mt3EQZ6WEm0MD2DvOkK+590DiBh/SKeF8PCaunvIFHVuUEylm0Jx?=
 =?iso-8859-1?Q?mynwkWSN8QNkv75MkqdweTmTiSt31l7GpyJsWlGxcZdp+mBsPFIiPqU/1R?=
 =?iso-8859-1?Q?fz1Q1lpRmtmuZ4eV0bx+A6u3CqS3cbdrEQe0QRR0bUlktZwBA8m46OdTL3?=
 =?iso-8859-1?Q?OQiCXzbdbFKqg8azmTEnzjRUstfgDxI+aJhRH3QZHQUi9C/RSwWOey6jrN?=
 =?iso-8859-1?Q?ITlZNsN5EBULm+pkOYd1F/UAKnosrAlVDPYAhdFWfg9SXxR50BboDQwyHx?=
 =?iso-8859-1?Q?PAy01jj0OyMZEefRHUfV19PZrQkDOt9v8wkfkUH1IwJf8pL9C/LNv53RRi?=
 =?iso-8859-1?Q?5OAHmG1HdBOeVYU6fT4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570acd30-b141-4618-3562-08da00da9ac2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 08:06:52.7198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AIa0/HWlJSMn4TLxqg83QEnAx2Rj/82agjPMn6uUDQqS/bczIJPttp/D9B56uVJUebC2uNyqpTHdku8vM2fqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
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
> Am 08.03.22 um 08:33 schrieb Lang Yu:
> > On 03/08/ , Christian König wrote:
> > > 
> > > Am 08.03.22 um 04:39 schrieb Lang Yu:
> > > > It is a hardware issue that VCN can't handle a GTT
> > > > backing stored TMZ buffer on Raven.
> > > > 
> > > > Move such a TMZ buffer to VRAM domain before command
> > > > submission.
> > > > 
> > > > v2:
> > > >    - Use patch_cs_in_place callback.
> > > > 
> > > > Suggested-by: Christian König <christian.koenig@amd.com>
> > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > ---
> > > >    drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68 +++++++++++++++++++++++++++
> > > >    1 file changed, 68 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > index 7bbb9ba6b80b..810932abd3af 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > @@ -24,6 +24,7 @@
> > > >    #include <linux/firmware.h>
> > > >    #include "amdgpu.h"
> > > > +#include "amdgpu_cs.h"
> > > >    #include "amdgpu_vcn.h"
> > > >    #include "amdgpu_pm.h"
> > > >    #include "soc15.h"
> > > > @@ -1905,6 +1906,72 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
> > > >    	.set_powergating_state = vcn_v1_0_set_powergating_state,
> > > >    };
> > > > +/**
> > > > + * It is a hardware issue that Raven VCN can't handle a GTT TMZ buffer.
> > > > + * Move such a GTT TMZ buffer to VRAM domain before command submission.
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
> > > > +		return r;
> > > > +	}
> > > Well, exactly that won't work.
> > > 
> > > The message structure isn't TMZ protected because otherwise the driver won't
> > > be able to stitch it together.
> > > 
> > > What is TMZ protected are the surfaces the message structure is pointing to.
> > > So what you would need to do is to completely parse the structure and then
> > > move on the relevant buffers into VRAM.
> > > 
> > > Leo or James, can you help with that?
> >  From my observations, when decoding secure contents, register
> > GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ buffer address.
> > And this way works when allocating TMZ buffers in GTT domain.
> 
> As far as I remember that's only the case for the decoding, encoding works
> by putting the addresses into the message buffer.
> 
> But could be that decoding is sufficient, Leo and James need to comment on
> this.

It seems that only decode needs TMZ buffers. Only observe si_vid_create_tmz_buffer() 
was called in rvcn_dec_message_decode() in src/gallium/drivers/radeon/radeon_vcn_dec.c.

Regards,
Lang

> Regards,
> Christian.
> 
> > 
> > Regards,
> > Lang
> > 
> > > Regards,
> > > Christian.
> > > 
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
> > > > +					     ((u64)msg_hi) << 32 | msg_lo);
> > > > +			if (r)
> > > > +				return r;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +
> > > >    static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
> > > >    	.type = AMDGPU_RING_TYPE_VCN_DEC,
> > > >    	.align_mask = 0xf,
> > > > @@ -1914,6 +1981,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
> > > >    	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
> > > >    	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
> > > >    	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
> > > > +	.patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
> > > >    	.emit_frame_size =
> > > >    		6 + 6 + /* hdp invalidate / flush */
> > > >    		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
> 
