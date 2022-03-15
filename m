Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045BAC43219
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 14:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2D8D89A8C;
	Tue, 15 Mar 2022 14:29:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A07899F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 14:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pgb9Kf8wlCigP/X7rYesEDPRBlVdBhT9Jd6QehhJAlkxxHykIbj49e6hvS2gjk+lYYuKYseplHSfOkxOjl92llPD9hZxBZAcs/2uSQATAzoid2JilVHjcQfB6axXsmTuvPW4uKVTnmjNkhxrg/VU+2FJpWhoBwoU7vQM6DQ4621yI2Gad8GvaUs5FY59Y3hDQ8TxsDp5Ue7VdNkuBlG2Q77T0O+OoDA/o5Xpp35dh9M7YctR66AKM50hwfWdJDNeCsl090QDnO4MuCMVUVyYOJrniFLX/+RmqqJgIv6r2jsYjE8RXdQ4gKtS91n1DpgLfDcCCOXKcZ+4+gn3MdCnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jayePPLjdvKZVG6kmhZKqn+piAkBx6m7QhiGZvk+gw=;
 b=XmxWAfTjfmSXAS1Q9rOzVO2Ht5reQmNMLL3fyFq6w7ZoakHygv0i0nzwlcRad9+Q0AjlOE2Gq0uoBikAxywNtmUTp1TH0f0ByzswyemMhfUvnw/z76zZmbfJpbfIWOhvklc2TUbMzEUbDyD+UI6kRwALoRMUp7tco9wB0ddfQ43koJd/jAbGsaYhFmoGv6KwbjT3zFxACZ3k2iTb3XePgVqq2jdUjYKR3IvrouzK/MUzGKobyvS03yTnOj1kHo+RWKrNMEtkicUbaGyzYFFDF/SjsB72t8MXs8OzV/S++egtNUMjk9z+pK2kWzS+mPGL9OccRFPUY+tlOFmBw2vyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jayePPLjdvKZVG6kmhZKqn+piAkBx6m7QhiGZvk+gw=;
 b=GI/bmT10NHas2dRkyymuIfW1fCg3oziZd5ua/rqRl+sDy3QeEMlJvg6BPszXhJcXYUqBxbN68UEGdi249r1qXictlmQl+jUKzHmaN8q+H/68/JI1cn5pwLaNFtz7ZVUDWxA3ZaG2P2JRd9ldUjt2vBA7E6ZeUDvEyAravYfOP8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Tue, 15 Mar 2022 14:29:06 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f%9]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 14:29:05 +0000
Date: Tue, 15 Mar 2022 22:28:56 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Leo Liu <leo.liu@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: add workarounds for VCN TMZ issue on
 CHIP_RAVEN
Message-ID: <YjCiqF5UqSF194XO@lang-desktop>
References: <20220314024519.2201231-1-Lang.Yu@amd.com>
 <6ffd73dc-ed1a-768c-cdab-7261f4deb916@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ffd73dc-ed1a-768c-cdab-7261f4deb916@amd.com>
X-ClientProxiedBy: HK2P15301CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::18) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56792ace-89cc-41ed-8e98-08da069028f0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4149:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41492671EE92A4E918F23B68FB109@CH2PR12MB4149.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Adn+9Y5AaEbq2Neq6lEFuk+edNBUNqDXIdLTWcQR8cOZmEgfRcmNiipaIE8N95M9GSV3KsdYzlM9csrrGlj0EfQGEaBU/AC5ucfW5SmG3E0vOZthxVKW68QIys4UasuCXxNdqluQ9SW3QDbb8krtCnbEYQyRPfFhSkDP0FAKgEP3KlFWRL8AwRGncyRW2hwlEb9CX6gqTr8PdAlmAywlsjHU0l7zd3YRjdlatAplA7Ty0ZyOA3W/HAAGJGEH3s2p/dhIatHiRTUCgkcniS1pzHcfLku7Y4Bf55Cx4gysURSb5cRGl7e7M18mgehQxGuMeh+4OYrKIQS8G6uLE6lPVYPGlQPapBfeOzT4KtFIeTMXYQyVqwaIpo2xou5VV1BT8L22ST7YAsGfBWxvC7ginDzYuvqrcY5wUJM/XrcqwuXvhKnOhv67O3Kqkb3Y1G9S6wx/Xxd1hmsWtsHpTaXNsN74L1YcP3to7wpuS5zDQDP8rIeGjV5iPrpoNzcHR1ZYAHQHWH5xRiXnhqQp9R3do4twjpE2hEukVuNtHry5eS0O+79QEm+1hVqI1IYgzLhkYitciee8Ir8659+kh+K1mxePFTgh/3NHB1bQi7rzJb5ZhydptBUl4aAoFt4YSE8UaC/LC9qzzjmZYDxaEqy+Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(83380400001)(186003)(26005)(508600001)(6486002)(6506007)(66574015)(54906003)(6636002)(6666004)(316002)(38100700002)(4326008)(66476007)(8676002)(66556008)(6862004)(2906002)(8936002)(5660300002)(33716001)(86362001)(6512007)(9686003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vs7QEZgK+1tBWKwzPyesftTMV0z2iCSh8yvm6W3racl/E6DOQIUmKI1vnc?=
 =?iso-8859-1?Q?335FHzi4VbVdNniOKcUtI//HVM3VhfJohQ4eO8MUA/GNMmq0smx7CF0rSO?=
 =?iso-8859-1?Q?vlJtMjB0GMCqgAab/4ObsXR1gmceCZfoT7WDHocwQXPPoACAifGVgLfp/W?=
 =?iso-8859-1?Q?0n7dgBXdc5SHMh+aXSLCC0mJBG0uz3o530ydOZLs+8lJjsDxrhnm9ip+hN?=
 =?iso-8859-1?Q?poVKfmPC4r1Hd38lLY/kL4nJfUjKVAH06F6i3oPUs0dkYWFY4Y83X3VBMt?=
 =?iso-8859-1?Q?af/zX/pedWpj+cYztIkNc6iO7ggKCrLhS7LQfjMZ7bByEYiSbgHU0o2UDO?=
 =?iso-8859-1?Q?zY/ZmCpLlOybLNRbzxGIgaGm+OTMSfjZk9s2ELbNAj09z6cn59RGtAh6jF?=
 =?iso-8859-1?Q?SspyJ5fLBSTExfZAb5seXQLWj0SM30OktSkaltI/+Zldx5FBQ4Ei125Ah5?=
 =?iso-8859-1?Q?v4FGqgtmfhA2FjYvSe2EDgaMrSnKUnCzuh5S/SaI/wspEUw1wR8/mO6n1e?=
 =?iso-8859-1?Q?vfJvsxPqY6qP60JFWlis+uWkvoiTHyyxrOQ50hmuSxtPIH5RWG60mk9wIl?=
 =?iso-8859-1?Q?WZUYz2zdwIn8aWxKlmEXlr2A3N2Ata0O5llN2rj5u/gIJeSaaMNmdZAb3B?=
 =?iso-8859-1?Q?N2+RYT27rAaEccGohX11e/fMKnZF1AQq1AJGc7GtF/cicBxTW5Spinfx7D?=
 =?iso-8859-1?Q?jqj28TJm43p84viIX3hqBtu7vpcyRurkUtJ04b/PRQf6CqDIQcZC6ki72H?=
 =?iso-8859-1?Q?75eQ64iWPMTQEnewnwFQ7uZyoLQlmXkfPzDWGMEO4VFaO0nKUllEs1WXhI?=
 =?iso-8859-1?Q?B7cfi49airbcXqLtPQzAi9V8mp2Re4EGLUHqdIwQu8hFdlIS7sxxaLYzwJ?=
 =?iso-8859-1?Q?Z+g1v9s9J3BuVMeMpTLD1552yDB7YghE+yn4AYOxn/NJWM0VPrx+7Xmkpz?=
 =?iso-8859-1?Q?R0kwh/oicwi1kh61j5LxvQYuonKg/pRRaH6Rw78IEg8EeXigLQB1N7XRwR?=
 =?iso-8859-1?Q?uci+X7Dftc3E+nSyOoj80HbBGS82Z8QKHNbChmr7PDwvTKtfQdoZmspnyu?=
 =?iso-8859-1?Q?YAl5Z4fg2t8oqvpViLDMt9xslSstwDmm7Zr9Nzh8zsi3lcuGvi0ke0IqdA?=
 =?iso-8859-1?Q?EOgKNrsaEMeRxb94kddAUE9dIlncpZ4cm26xZomRCeT1qiyNR8vtVx6vNF?=
 =?iso-8859-1?Q?DU40k5H3zKHTjZg42fai7gj72DVQqgxGBqHusBmBuTkoD9xrIYd8S3R0L+?=
 =?iso-8859-1?Q?kJ1pB5tKsq4kD12D6acZhniH7+U5oriqFlT+S4DpujfuN0eKDop3eE1eCL?=
 =?iso-8859-1?Q?o9BwFTWhVo8SSmu2Mw+o+LNBi/Yn8L42UHbGFDC7LPsa9H1KRDlSoPz3oe?=
 =?iso-8859-1?Q?1Am80U92HJVj2aWl8RQn+RSS0whUb7CX3TNGUt5FH8DHwdGKcz1jUw6acj?=
 =?iso-8859-1?Q?fuyeJvsr7ggZR9xsVWMecMINP6auFACWK5Sbe/aSH9VH688Qku7iXe/5hF?=
 =?iso-8859-1?Q?8PdicaMvlsoLYYwK5pOWjx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56792ace-89cc-41ed-8e98-08da069028f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 14:29:05.9507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9kuXijYkVYn5wVlhdCrvEbLZmvE+BZt7mI7L7pixsoXRH6uTFZmc8J2Wd9pJKjdWIpMdCUm8VN3gULmDkOh9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
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

On 03/14/ , Christian König wrote:
> Am 14.03.22 um 03:45 schrieb Lang Yu:
> > It is a hardware issue that VCN can't handle a GTT
> > backing stored TMZ buffer on CHIP_RAVEN series ASIC.
> > 
> > Move such a TMZ buffer to VRAM domain before command
> > submission as a wrokaround.
> > 
> > v2:
> >   - Use patch_cs_in_place callback.
> > 
> > v3:
> >   - Bail out early if unsecure IBs.
> > 
> > Suggested-by: Christian König <christian.koenig@amd.com>
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> But I would ask Leo to give his ok as well.
Hi Leo,

Do you have any commnets on this? Thanks.

Regards,
Lang

> Thanks,
> Christian.
> 
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
