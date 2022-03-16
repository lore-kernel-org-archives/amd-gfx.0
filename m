Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71F2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 09:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8810C10E540;
	Wed, 16 Mar 2022 09:52:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E00F310E540
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 09:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3nWcUo6xB2/JzjCI3FjJBBEiMuMUueoFBBF7LC1xlZsF3TK9yWh/6Eb6w5TLQcwgDqLJM9RoAGfnRbibbT+F/mm4Hf9z6pFMjHGD5l1EyI/vDvmEgnZgf4IxbWnzAGO4uxIxQmc5wDvraHgpXqBRmLyZhyKwegU+qUkk5HAeer9wXHn2C68ZRWXVlVOme9wlzxtI3ME2B4aWTZYIQckXqAoFgZqElNkJR/Y9KGzFLa9nFrxMunKxJn5IDmQsT31wCw75swI7eB+PYxZ7llUBQqqy9O2L0WLloa9ZKeo8OOFWUP7NLp/PLfrH1edbktRKQc4WWpFKqAFyN1fYMjL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zN12xOQOqj4DJXI5UPgusTyGZ77W3++83VstxzW9akc=;
 b=KvRwRNE3k6cR88B4VcKfLtaUlKAoLoeyTRTQhqg/SJHwWCNWtqVdsC4lJ+YE+YXiY4fNB8RNy8zoiVcaW93y9VJyE7ogbAiwWsB5ZvsjUCniLW6ENzY49d7qZ92bWlQo88DuzzibjQIWRQ9KDfeiCiGwpiHk8iuhxtbxaDMJHAL6PthRsSH/EwNBJV+HWfMMWNBThqlrI70M5pVoc/CW8po+OS+ns8P0XCdOtYIbS8Ss7ftbb4lItL0awaeWxE53yMe22DK5hc/17/1vW2BpEEub0AKQ/FU8sVCt8vnq2nqtMNaXe0h0Rn4haaqL0mRaz3TPQPnjQLBYoluQkZGj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN12xOQOqj4DJXI5UPgusTyGZ77W3++83VstxzW9akc=;
 b=vOt1baydRSN9g1iOvfxA6MsKc95b1GjpvZ/ZkU19oWgMr3oYSimIzoOonZ/AEUakeY3+KnFBPucn7iX+NyPSNrKWqKerbTC+hqnWRW0aWLawRzIFzrHZ/g1ulBE5taqIGr9KRSVJgAmQZOpn1RtLD+tMrhEq5t19/c58H7GD6Mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 09:52:24 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f%9]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 09:52:24 +0000
Date: Wed, 16 Mar 2022 17:52:15 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: add workarounds for VCN TMZ issue on
 CHIP_RAVEN
Message-ID: <YjGzT/rpD+XFRvm2@lang-desktop>
References: <20220314024519.2201231-1-Lang.Yu@amd.com>
 <39dcbcab-8a92-4a01-e355-6e37ac4f1ce6@molgen.mpg.de>
 <YjE9CDYjvJ72IQNg@lang-desktop>
 <c502a443-0987-6d88-1ef3-603723f04634@molgen.mpg.de>
 <YjGB+Dx4nUIOyuMf@lang-desktop>
 <aa16b25a-197d-87d5-001f-87fdfcd1a139@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa16b25a-197d-87d5-001f-87fdfcd1a139@gmail.com>
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57ebb256-13ed-4462-7350-08da0732abd2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4289:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4289E52C2B179F1617A2DA79FB119@BY5PR12MB4289.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/aN0AMgDMlX0998mlgDspFDtAJ5+rAvriLy/POmuXMB+X4Dp5yil3Ig8YgIX5xlc+OfrmJRpRZIPYj7cbgabnUEmBcE42kzlfi6o4yalE6WgW51cNOWJ6AjV4cCPVssxYM5fhxHm0vIbdyat59PjJz+ylj8X/uNf/Y/DDzr5sgTYueJiOIJ6esIUhGVKsTEa3H2qTXdW0zRkcA9LP7rE5isZnsslHZD4r/ZdcvC4kgHaQtz1zPZG9RoFqjD2TMIHue5fbmFverOe7Ep/pvAwpCksGubQ3VUcjg3xD5EUDgC1h5piZVNT8ZuiUNURTPdOv8NfUh1w70+MXjVJk4/qD1z+rvFJ+IQwpaO8E8WaHW850OidN3Zmt9g9PKiheizn7V0x+jww8ssiRMqsIpQnsqEp7fBBdQWQDF9gNsi9yLQc82XBtq+4wBSfRl2AS4ttAmmbB/9+zmvqgyz7Wz4/QwX5D9+X0MDCWow9wWbtK0l1s4dJEvs8rRrM/QR3pB4+cOVlm3LQqB51nX2eFG1hLmsugMRluUshVtfguKJR3eGOVu1uZHTClrNvD30nOO/S+IY5Sb+0ADtTQwMpLGqC3n+JQAjyejX+YTqSai1YAT6kIlqtUAj57RR5qyBDYdwdi3FJu2L7N3m31qshYEo3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(7916004)(366004)(186003)(26005)(9686003)(6916009)(6486002)(508600001)(33716001)(6512007)(6666004)(6506007)(38100700002)(86362001)(66574015)(83380400001)(316002)(2906002)(5660300002)(8936002)(4326008)(66476007)(66556008)(66946007)(8676002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0tTVGZpMEVXYUtTcm16QnhjL3ZzQTZ4VDhGOXNTbDBsbFFZS0xKblV0bk4x?=
 =?utf-8?B?Zk82djBLWmx0dFhjbVBpTCtEcGJHRWVHSVFiUnY5eVIwbVhheEJSa25JcnI5?=
 =?utf-8?B?c0JvRFdNQ0EwZUpSbnVjS2dQMmoySjFYdlZuTUNDU0ZUNVlSS0FBeUZLNHNt?=
 =?utf-8?B?bVU3aUxzR281bmN6U1RrM1B2WTdXdE1KRVl3V0xKOFlzRllISmxJK1VsaER5?=
 =?utf-8?B?T092cUhtUGRpMnBXajUzc0wzUWFaTjJwUzE2MHVyS3laV3FCYXBCRUIyZkNx?=
 =?utf-8?B?Z21rYTd0M0ZqUE9nWmtjQmdiY3lHekNvU1E4cmEySFkwQ2lVRElYWXB1bzJG?=
 =?utf-8?B?N3dWMFQ4TnJYYkREUjN4K21NWFlyaHZqTjZ0WlpOU0hqQ1g2clA4Y2FKWUx4?=
 =?utf-8?B?V3hwUHMrRnZCdUREaTcrTm5DMW9BSWJYaS80REQ3Z0lLaE9MdzV4c0RUdEIy?=
 =?utf-8?B?aHNNYkIwVk1tR2ZMem0ra2FGOCtuSmd5bTMzS1JFSFd4VzFXZHoyYnVwdnh6?=
 =?utf-8?B?Ymt4UXAvTzRabGF1dnozK3hyRjkxMm5Jb1l3TjNXZ1FLTEE5UmhlQ1dmS2dD?=
 =?utf-8?B?cSsxQTQxandaczVMWGxDZXcwOUVJb0huVllhU3p1dVd0cmNYUTREUk1VbzZH?=
 =?utf-8?B?UGc2SWZvQlRtNGdSd0dSVHE3UVl5L0tVSUlEVVpUS1NXc1Y0R3k4alVmajJF?=
 =?utf-8?B?cDN4S0pJQjg1NVFGQ3RNS28vZkNGUjJpUlF5NG1QTWZhczRrczNwNnpCVExI?=
 =?utf-8?B?WHE3dHNsQ204YXl1K3dWcE15RmtNS3VOMG1RTWV3RUsrekJaQXFCeEwxZERL?=
 =?utf-8?B?dzBhci9qaHNHb1l5NDlDb29pcjZiWUlPNkx2aCtLTlhZMkxJUUljZWJraWRu?=
 =?utf-8?B?aGhpZkRhUGUzY2Q4NnBlMENpbWNIV0ZEbHhlWkFPMUJSSGY4RitoME90RUlI?=
 =?utf-8?B?R1dhMXNxRFNaYyttZUZoV050R01RelN4dTJyUmg3eXcwTGZmaEdGR2xzVU8v?=
 =?utf-8?B?OHgxWTdHazU4UHJkbnJ4NFI5dVg3RDBod0NBQm0wbHZGSnBLamNsNVVlS3FM?=
 =?utf-8?B?SUowRy9KNUNiYWFveXBnaDB3OG9RN3hZbmNOWHIwRHpyRmdlZVM4TjNvNXls?=
 =?utf-8?B?ZmJCRnpldEpwVHNPbkJFK3pmZXZHRElUQWR5VFIwUWlMOFhMc2JoRzg0MVNl?=
 =?utf-8?B?TDBJc3hQOUVpdExiaXIzdDVFbWtaVHlGV2xUU2w2Wi9VV1J2SE9DbXVpWWR0?=
 =?utf-8?B?a1AzQUJod2p0RnZJRkZ6eXhKdTd5b1l5TDMza2ZOWkl2dEI0cXVoTk1TL04z?=
 =?utf-8?B?SG1POW0rTW5TRjNOc29HMHdoTm9UYXhLU1NuTzdQWm5pTXpQVTVqSGM1WS9w?=
 =?utf-8?B?cWZvZGl5MXZTMkJsQmoweXhQKzdxRExjSmJPMWFjK0NOLzVrYzBCeC9KaE4y?=
 =?utf-8?B?VHZnMFNvNDNtb1gySWlRcEEvSkx2Y0FoaCtnS016TDV3T1ovbW9BdlJpTUdB?=
 =?utf-8?B?alhtcHIrWWZ5V29pSXp6NnFGYm9Odmt5Q21CVkpsdTNURWdRWnRjTURnd0hJ?=
 =?utf-8?B?em10OUZDNE1kSUp5WUVKRmNPWnJxM0JDaFMyUVB5RDFIdXkrMUs2cFhML1Bk?=
 =?utf-8?B?bkFBbmNpRHNKRVp2WmRabjAxNVVTS0pjdndtTnh5TFZXUXJVN05SdnNoTjJ3?=
 =?utf-8?B?UW4zTGQ1dk1jcm41TkYwTWs5SHZjL21FOUxIOWk3RTd4Mm5Cc1VrOTlpZFFv?=
 =?utf-8?B?RXUwYVdLc2wrbjZPR1EwbmJyNTZFdFczMVBIbXoyd2pvaG5FNmRRcU0rMTBr?=
 =?utf-8?B?ajFzQWFFTk5nTXFjblpQeXdJSmp4T0tQQndiamlTVVFmYUtxUkkybnExRzBu?=
 =?utf-8?B?b3hUZUtKRWRsaEJMZENkblA2QkN0REwvMkpkVC9Pd1JOSjNXUFVFcDdJSCty?=
 =?utf-8?Q?uji+nz2cS+EN2xH2wyyCB1x1lyvp1ED6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ebb256-13ed-4462-7350-08da0732abd2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 09:52:24.0676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1fiqBoF9mE4kcnavA7XXaHC735s4pf6FZZ5G+hNdJWYuUTyYBkk2J6FmkuUuU7VNI+ZSm55JW7YF7n9l6xRBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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
 Paul Menzel <pmenzel@molgen.mpg.de>, Huang Rui <ray.huang@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 03/16/ , Christian König wrote:
> Am 16.03.22 um 07:21 schrieb Lang Yu:
> > On 03/16/ , Paul Menzel wrote:
> > > Dear Lang,
> > > 
> > > 
> > > Am 16.03.22 um 02:27 schrieb Lang Yu:
> > > > On 03/15/ , Paul Menzel wrote:
> > > > > Am 14.03.22 um 03:45 schrieb Lang Yu:
> > > > > 
> > > > > Thank you for your patch. A shorter commit message summary would be:
> > > > > 
> > > > > > drm/amdgpu: Work around VNC TMZ issue on CHIP_RAVEN
> > > > > > It is a hardware issue that VCN can't handle a GTT
> > > > > > backing stored TMZ buffer on CHIP_RAVEN series ASIC.
> > > > > Where is that documented, and how can this be reproduced?
> > > > It is documented in AMD internal Confluence and JIRA.
> > > > Secure playback with a low VRAM config(thus TMZ buffer
> > > > will be allocted in GTT domain) may reproduce this issue.
> > > It’d be great if as much of the details from this non-publicly accessible
> > > information could be added to the commit message, and a way to reproduce
> > > this as there does not seem to be a test for this. (Also I guess a tag with
> > > a reference to the internal issue would be acceptable, so in case more
> > > question surface in the future.)
> > Thanks. I will add an internal link.
> 
> Lang, please don't!
> 
> This isn't an information which is expected to be made public.

Okay, got it.

Regards,
Lang

> Regards,
> Christian.
> 
> > 
> > Regards,
> > Lang
> > 
> > > > > > Move such a TMZ buffer to VRAM domain before command
> > > > > > submission as a wrokaround.
> > > > > workaround
> > > > > 
> > > > > Please use a text width of 75 characters per line.
> > > > Thanks for your comments. I will take care about this.
> > > > 
> > > > > > v2:
> > > > > >     - Use patch_cs_in_place callback.
> > > > > > 
> > > > > > v3:
> > > > > >     - Bail out early if unsecure IBs.
> > > > > > 
> > > > > > Suggested-by: Christian König <christian.koenig@amd.com>
> > > > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > > > ---
> > > > > >     drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 71 +++++++++++++++++++++++++++
> > > > > >     1 file changed, 71 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > index 7bbb9ba6b80b..1ac9e06d3a4d 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > @@ -24,6 +24,7 @@
> > > > > >     #include <linux/firmware.h>
> > > > > >     #include "amdgpu.h"
> > > > > > +#include "amdgpu_cs.h"
> > > > > >     #include "amdgpu_vcn.h"
> > > > > >     #include "amdgpu_pm.h"
> > > > > >     #include "soc15.h"
> > > > > > @@ -1905,6 +1906,75 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
> > > > > >     	.set_powergating_state = vcn_v1_0_set_powergating_state,
> > > > > >     };
> > > > > > +/*
> > > > > > + * It is a hardware issue that VCN can't handle a GTT TMZ buffer on
> > > > > > + * CHIP_RAVEN series ASIC. Move such a GTT TMZ buffer to VRAM domain
> > > > > > + * before command submission as a workaround.
> > > > > > + */
> > > > > > +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
> > > > > > +				struct amdgpu_job *job,
> > > > > > +				uint64_t addr)
> > > > > > +{
> > > > > > +	struct ttm_operation_ctx ctx = { false, false };
> > > > > > +	struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
> > > > > > +	struct amdgpu_vm *vm = &fpriv->vm;
> > > > > > +	struct amdgpu_bo_va_mapping *mapping;
> > > > > > +	struct amdgpu_bo *bo;
> > > > > > +	int r;
> > > > > > +
> > > > > > +	addr &= AMDGPU_GMC_HOLE_MASK;
> > > > > > +	if (addr & 0x7) {
> > > > > > +		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> > > > > > +		return -EINVAL;
> > > > > > +	}
> > > > > > +
> > > > > > +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr/AMDGPU_GPU_PAGE_SIZE);
> > > > > > +	if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	bo = mapping->bo_va->base.bo;
> > > > > > +	if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> > > > > > +	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> > > > > > +	if (r) {
> > > > > > +		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
> > > > > to validate
> > > > > 
> > > > > > +		return r;
> > > > > > +	}
> > > > > > +
> > > > > > +	return r;
> > > > > > +}
> > > > > > +
> > > > > > +static int vcn_v1_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
> > > > > > +					   struct amdgpu_job *job,
> > > > > > +					   struct amdgpu_ib *ib)
> > > > > > +{
> > > > > > +	uint32_t msg_lo = 0, msg_hi = 0;
> > > > > > +	int i, r;
> > > > > Use unsigned int for the counter variable?
> > > > You can see both signed and unsigned are used in kernel.
> > > > (e.g., mm/page_alloc.c).
> > > > 
> > > > For this case, I think it makes no difference.
> > > > 
> > > > In a word, we should consider the specific context.
> > > Although it makes technically no difference, I prefer to use the best
> > > matching type to convey the intention of the variable to the reader. But you
> > > are right, there is no hard rule for it.
> > > 
> > > 
> > > Kind regards,
> > > 
> > > Paul
> > > 
> > > > > > +
> > > > > > +	if (!(ib->flags & AMDGPU_IB_FLAGS_SECURE))
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	for (i = 0; i < ib->length_dw; i += 2) {
> > > > > > +		uint32_t reg = amdgpu_ib_get_value(ib, i);
> > > > > > +		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
> > > > > > +
> > > > > > +		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
> > > > > > +			msg_lo = val;
> > > > > > +		} else if (reg == PACKET0(p->adev->vcn.internal.data1, 0)) {
> > > > > > +			msg_hi = val;
> > > > > > +		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
> > > > > > +			r = vcn_v1_0_validate_bo(p, job,
> > > > > > +						 ((u64)msg_hi) << 32 | msg_lo);
> > > > > > +			if (r)
> > > > > > +				return r;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > >     static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
> > > > > >     	.type = AMDGPU_RING_TYPE_VCN_DEC,
> > > > > >     	.align_mask = 0xf,
> > > > > > @@ -1914,6 +1984,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
> > > > > >     	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
> > > > > >     	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
> > > > > >     	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
> > > > > > +	.patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
> > > > > >     	.emit_frame_size =
> > > > > >     		6 + 6 + /* hdp invalidate / flush */
> > > > > >     		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
> > > > > 
> > > > > Kind regards,
> > > > > 
> > > > > Paul
> 
