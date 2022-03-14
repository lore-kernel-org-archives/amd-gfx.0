Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124D3C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 07:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1AE210E206;
	Mon, 14 Mar 2022 07:51:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E13410E206
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 07:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTReggd6fAqC5HxbvCE7uiXPdIFC5om2jJ3cwmWyRvCKlzrT3ijmpYEbm0ovTFBfgKB+6pN40I4NseAD90dm2HLDDHR2u1dbTBPej5AyHGE0xWgcijTJy1nMaJX1xnKvGcdQ9DDCEUyK2a7IZ1Ksq2OECcw9FUQlzuLVo9K/po3TZknci0DLsN1k7anySv3w0LycSMve3Cv7zIMahr1G5IfFsBSlFVrMYM11THdgNkIPlUqDmgzMTd5U64dK1L0WyrgVvQYQyTjStEaEfWMlNuzIz09cK1afRAsSwFZI+8jlTO4wB4FNKITZkBrSk8mRkuv26mUgdsNUTWxhqTnK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN7CwDabjxSsSovv5HWe8G42p5B2zi4FseJullL8Lp4=;
 b=iSi+P61kKGj3Pq2t1GtS4541pEHBlrNsVozY59PjiDOiJjybaIjOpHHxraO0mJ+bz/xg9aCEPliiJNsAiOnp44cK5pbiVMd2G0SHW7PA5IkwQCJg823aEohqBzXgLMnF4LtgvGkH/cTleehb6vd0xRwcS1TgOm57tJAq98iTGgUjip341d2g5pC/z+Y70c5mtvyOrloWUw+niW8J7Otb8UrhgK5Bl13GBfwKtc08z26DiTJDoimfrVNAbibQkW0X5ruZ2iDbOy1bpGW+AF8TkdYIWG2H/pmgBz/unN3MCA8GpSGGceXL4SP65UcJH5AO4AqoI1+4+FtpayZuDw6oEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN7CwDabjxSsSovv5HWe8G42p5B2zi4FseJullL8Lp4=;
 b=C5gRlysg6KFRcn9WpnMO3YRZSacGWGO0/WqwTyCE+GaC7eWXyVWkhAwytQORQeRHqB8oOEQCNI6dGw/FnKeJaZ2vbw/xU+vGhYienTLxZ0+f73lJd/nGEcia4NC+azai7uIiry33y33OBUTbQMGol97/ivwIR5Y2ZHg4getb4HY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MWHPR12MB1261.namprd12.prod.outlook.com (2603:10b6:300:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 07:51:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 07:51:18 +0000
Message-ID: <6ffd73dc-ed1a-768c-cdab-7261f4deb916@amd.com>
Date: Mon, 14 Mar 2022 08:51:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] drm/amdgpu: add workarounds for VCN TMZ issue on
 CHIP_RAVEN
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220314024519.2201231-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220314024519.2201231-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR0502CA0072.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::49) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10b4cfa7-6d8c-49f2-f453-08da058f6c55
X-MS-TrafficTypeDiagnostic: MWHPR12MB1261:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1261B69B7FCF5488BA9AEA47830F9@MWHPR12MB1261.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJnt7O0dcbeNLT4KLEAJCyhyMciUdxvkzi35/8PlIy5Ra3xmV8aJ+NHMvELWINDlXo6nGrcDGHDZZessnQbWm/TKqxEZlcJd1GL78+VtV9nNH53jIJHTu2TJgji/cmVkiW0znFHwlCQEiFuLXGo88i4REUqjP5tySfNXffudImM4p/CBrVbY6L/46VfECo0C1ENwqT9j847G/t6UGstHXhz3pUiTn24txtWcw/Sgdc8KI7kPzLaMAWK7xvcGxF/DAGDTGvH1kw2OHI30EM4cXlGTwOs6qRtbJizz7NQednstzggFl3XlA6U1UAllf9Cij8uWHrvgsv6zPN2MEcQzf20Hpgh6/LSC2BeNHSDb1n2BUDNURprGjC0eHM4DssnMJGlNpFZTq2/+Qi9Py7VJ1XkTMny33GjGeZ8VJnpgw/Ad5TgsiKydLjQ3R6ZSi+bGYvbYTHZKOVKgyDGcj1h3B9RWboRfQWPCRAb9GSqBJwa5Z8T3gAWzBynhnfdbpjmrZHx6a31xGCzh+8qmCF9J5dKD+ih8aK0dDpmopdaiaev8Kkhf+aA2a0fIFiMf3Um6XVOacQKP25uDszCEGmETF14dJzf047wx97AME+2UkonXDZtGUWkkWgse6Mt5Pww/mPIgeyU4xlOwODiGloS9ESR73Kxb81+yiqrWAhg8WcDOXkvENvJdxQCNFGrPSuk1krpDpR5bGizjNW/2Gu6ufNT24SVRXCd3T1osu5J1DYfintjOTHm1taDVHAod5slE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(31686004)(66476007)(66556008)(66946007)(4326008)(8676002)(5660300002)(54906003)(83380400001)(316002)(8936002)(66574015)(2616005)(6512007)(86362001)(6666004)(26005)(186003)(508600001)(31696002)(6486002)(6506007)(2906002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mlh4Q0hybTJtSk1uVjBLdjlNbDhCTGZxSTU1VVJsUHRIa2lZTFRiVmU0VnlT?=
 =?utf-8?B?SVliZjhibDYrK0RJWlRUSkE1UWkxV3YvZTIvSG1vM2tIcFMyQmVhM09rdmw3?=
 =?utf-8?B?YmFsUFdJT0VaWXdwQnp3THpSWGNpNFNuZzBBd01vRzNueXpmQzFqaWExZHFm?=
 =?utf-8?B?NWdMbS9BWDBRYXNDZXgxUTRxVjFnZlM0b1djNVE4WXRPU2J5K3JGMlZHU3Uz?=
 =?utf-8?B?aEZmSDZXV2ZabWk2UTcvU2txekQ2UDdETXV2ZExYWWFtWWJpQzFQMFFhRXNs?=
 =?utf-8?B?TDlwR0pFNWQ5MU5reW9vd0RrTWh1ZFVjd2J3TTBXSTJmQjJwRVdiRTN4RWtX?=
 =?utf-8?B?dU8vcFhyM2EyZ2h6dTRrb3VoQklhRmEzekhvanhUVDRTaTJabElaRWRiVUZv?=
 =?utf-8?B?Ri9JcVdDN2RZTjBxUkU4MjVzWXYrZEV2cTZKbU5Rd3gwNmdLVnRVVU9sQzY2?=
 =?utf-8?B?UE9FLzcwL0pYa1QyeCtTd1dldDVWd2VSNytmSDIvWFExdjE5bHkwbnc3WnVm?=
 =?utf-8?B?QWRsNXFrUGptWWhMTnoxU3Q0WG9Edmo4OFI1ejF2RjFHUjlCUXJkMEdnVis2?=
 =?utf-8?B?emZzSnBVZXpXU1IrYXhhTEk3K3pSNUdpM2FRMWlwUFN2enBqeC95YlJGRk5i?=
 =?utf-8?B?TEJVNzRWbXdRNXAyUTkyd0lTYUROTTUrRTNqRXdEL3BWTVRJR0EyWjgvaW9L?=
 =?utf-8?B?c3VJcVdmVlk5eWpMRFZVRlowUWIybnQxcmNQNFRqOWVSNytTQVY2OFVGZFlK?=
 =?utf-8?B?WXg1bHI5N3Jab1FHc3ovajR2bnJKTmgyRHpjckNOREpxUzdOQ01Ydkx2U1lp?=
 =?utf-8?B?L0JJdVBOUnlucHlCMzdoZjRoaHdLcVprejRTcDdRaXpvV3hvTEkyTmhhNEZ1?=
 =?utf-8?B?NDM1OGxCZnl0enE1S2wxdWJrbko2WWFITXZkbklQV3pTNHZTV1l1RWtaVDRO?=
 =?utf-8?B?ZCtGaFdqc0taOGpwUjljS0VYMGs3bkVMSTcrNURnYmdISzA1Wnd3aW1qaHRV?=
 =?utf-8?B?R1ZrWUczVUUvTE5yellnZTZURmRmZGMxaUVkMXJNMHpxV0NwTHBaQlN6dHpM?=
 =?utf-8?B?M0NlUGxSbEUweXUrVnZkUnVEY1loZ09FakN6UzJKUnlUS2I2bTBWZHU5bFMr?=
 =?utf-8?B?cHVxNnViZTB1M25yRWlSSms0NG5ldjljSU5ka1RxbUx5ZlVUeW95NXJOcWNp?=
 =?utf-8?B?LzBOejB1b01NUTdWcEd4THN0V2s3TVdLZ2dBOUQ0UTR2R01qODlDdUE0MHEx?=
 =?utf-8?B?SnlxWVhJVjhwcU9YNHEvTTJPWUVtZW0rclNEUVhpWDI0K0Vyd0gxWnExWDIx?=
 =?utf-8?B?MVpRK3lkOG5ibFlNdU9Dd2Noc2d0SEZsV285cDYvWm5nRkd0REVoL0orZVlR?=
 =?utf-8?B?dU1BR1NwWWpka05oeHl0bTB5eHRsc2FaanpZckpPQnZ0R3VjY0ZkcEVVaU41?=
 =?utf-8?B?TEErZm03Rk5DZ3UxNUlRdUFRekpOc2ZVNDlYb3FLUWMrRmN5UExEYk83RjM0?=
 =?utf-8?B?Z1dmWFE3bnBNMVpkbmpWZVUwUXp3ZEJPMDhQTG9CeWRxQU5rWU91aWpGRjc4?=
 =?utf-8?B?ZzRWLzBWTVRhWURucDZMM3lYeGxqWjljdFVJdFlWNTZLNUZ3SlFESjNmOWIw?=
 =?utf-8?B?VVNmaEN3OUdzdEtnWEpxSkhoVC9BVUxQOFQxLzBCcUNzSTFNaXVrSEZSZ2RV?=
 =?utf-8?B?cWwrTzh5MFVJNjlkZ0ZXZ3RaUE0vOGhRdnRBN1JwaFlpeWhIZ29WUnk3dTYr?=
 =?utf-8?B?US9BblRhUGNlN1ZpREg1UFpkdDB4NDBlU1N2cFkrU24xaDhHS2NQVUx5a2k0?=
 =?utf-8?B?d0dhc2tkcmpxSlRIMUsrVnVydXhTblNQSWhNR2pyaktXTU5idk5yeXpJaENC?=
 =?utf-8?B?UlRvcTBpUGpEanJqblpjaW11N1ArYWJBdGVXY2lCWm5WTlFIQzdMRWhjT1J4?=
 =?utf-8?Q?WR/eag9eWv9AsBwZu/mwODZG9imkbOUS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b4cfa7-6d8c-49f2-f453-08da058f6c55
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 07:51:18.4099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8yjwatptOFk5hLnV61WfKz6mhdQS2/fWCUa8g8+c4E9UqqGPEqKsLVNyGMT0zzE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1261
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.03.22 um 03:45 schrieb Lang Yu:
> It is a hardware issue that VCN can't handle a GTT
> backing stored TMZ buffer on CHIP_RAVEN series ASIC.
>
> Move such a TMZ buffer to VRAM domain before command
> submission as a wrokaround.
>
> v2:
>   - Use patch_cs_in_place callback.
>
> v3:
>   - Bail out early if unsecure IBs.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

But I would ask Leo to give his ok as well.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 71 +++++++++++++++++++++++++++
>   1 file changed, 71 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 7bbb9ba6b80b..1ac9e06d3a4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -24,6 +24,7 @@
>   #include <linux/firmware.h>
>   
>   #include "amdgpu.h"
> +#include "amdgpu_cs.h"
>   #include "amdgpu_vcn.h"
>   #include "amdgpu_pm.h"
>   #include "soc15.h"
> @@ -1905,6 +1906,75 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
>   	.set_powergating_state = vcn_v1_0_set_powergating_state,
>   };
>   
> +/*
> + * It is a hardware issue that VCN can't handle a GTT TMZ buffer on
> + * CHIP_RAVEN series ASIC. Move such a GTT TMZ buffer to VRAM domain
> + * before command submission as a workaround.
> + */
> +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
> +				struct amdgpu_job *job,
> +				uint64_t addr)
> +{
> +	struct ttm_operation_ctx ctx = { false, false };
> +	struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
> +	struct amdgpu_vm *vm = &fpriv->vm;
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct amdgpu_bo *bo;
> +	int r;
> +
> +	addr &= AMDGPU_GMC_HOLE_MASK;
> +	if (addr & 0x7) {
> +		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> +		return -EINVAL;
> +	}
> +
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr/AMDGPU_GPU_PAGE_SIZE);
> +	if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
> +		return -EINVAL;
> +
> +	bo = mapping->bo_va->base.bo;
> +	if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
> +		return 0;
> +
> +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> +	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +	if (r) {
> +		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
> +		return r;
> +	}
> +
> +	return r;
> +}
> +
> +static int vcn_v1_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
> +					   struct amdgpu_job *job,
> +					   struct amdgpu_ib *ib)
> +{
> +	uint32_t msg_lo = 0, msg_hi = 0;
> +	int i, r;
> +
> +	if (!(ib->flags & AMDGPU_IB_FLAGS_SECURE))
> +		return 0;
> +
> +	for (i = 0; i < ib->length_dw; i += 2) {
> +		uint32_t reg = amdgpu_ib_get_value(ib, i);
> +		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
> +
> +		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
> +			msg_lo = val;
> +		} else if (reg == PACKET0(p->adev->vcn.internal.data1, 0)) {
> +			msg_hi = val;
> +		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
> +			r = vcn_v1_0_validate_bo(p, job,
> +						 ((u64)msg_hi) << 32 | msg_lo);
> +			if (r)
> +				return r;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0xf,
> @@ -1914,6 +1984,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>   	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
>   	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
> +	.patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
>   	.emit_frame_size =
>   		6 + 6 + /* hdp invalidate / flush */
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +

