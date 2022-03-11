Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326A8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Mar 2022 02:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABFAF10E168;
	Fri, 11 Mar 2022 02:32:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9866B10E168
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 02:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ref1trwDN9pla4jYMueSbfTVEnCXc17Hva2X56WXKHUVtET1Y2L6O2F0CJCTnviL82SgWmj3McnbU+UvugRFVx4jFKjK33jmM/VBCbt9J4yChH3qwkk4dzWfTCMhG2w4KIUus9Size5ek6TqujtC3rnX2OAVeeyv9teEXdnbQoO5Jl4y0PMubq+dks2gR1Ny8CiQW1f0tuiSczscLHMCTTnC4M4bry9MDTt3POn+lkgLUYSty2jk4nw4Oz+68koEw744VtWGuXDV3QA/YY68K8z+ReI45fGRJzvT79bQE3F3jN+ZGJIE2oGXyuGLsRdVWPqfcvZhttNTWq9neA7d0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAzKrbCdTv8TFpXxLnfX1YXVIIEEPKk6Hxa5h0y6C6E=;
 b=fe1h2Sfm+MUbDeQsvKwvgKVBub5vRx2jVxiuV4XblQ4AISodQZYC3ib7mx3z56JZ3cA+oARozIu12X4bIuaAxrgvqPrL4iVb2E92zwDAWrpcwkJ6mAz77/2gSGAsK53uK2gy1lF6ll0B5sCb+8s7JiErvX4w4WnTSvcoAh8mSdnA6cvmkLMreS1hdBgXVEDWwhaR1Q8dlYjl4sX1bitpb22XUbX4WjUIXgEsE95Pp4SV0l44CbfrBYr8DOlLGT5Dhb4rpssupca1cvyrzvSEYEZbrqd6nAP2II97A5PKzo0yzvQV2Nv4QGdemBYEYb3UDjRUoq1ndBHwuudjoCZaJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAzKrbCdTv8TFpXxLnfX1YXVIIEEPKk6Hxa5h0y6C6E=;
 b=0VHrrTVag+wRlXge4fqMtiHXiGTq+gK8Mg+URQubq5NePnCGzX9xW2hZPjDIXiVFiPAY7Ugt0IHp6+3NZtYDpWJBd9/ZO4hKhEDQLC1Uk3l+hn6r6rRpgfszNRFS9go9ukiE40EVEtqtvJrNJsD786BrJd5yU3DA3yQjepIZvxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 02:32:31 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::b48b:15ef:2dfd:e54f%9]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 02:32:31 +0000
Date: Fri, 11 Mar 2022 10:32:17 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Message-ID: <Yiq0sdkgNFw9w8g0@lang-desktop>
References: <YicG3THG9sem8Uet@lang-desktop>
 <cbebb9b6-705e-e6fc-9ff0-41c35c3ee94b@gmail.com>
 <YicOku9HhC3wJUb8@lang-desktop>
 <1c02d3b8-987a-3c4e-d123-6de8fd86dcab@amd.com>
 <ec57da49-8a3f-852b-aaee-5bacdeb56c80@amd.com>
 <95e6f48e-fdc7-e535-1803-080a8d189d33@amd.com>
 <Yim6vIBYKLd3Uqxu@lang-desktop>
 <f16e10f2-fa3f-7e63-c260-aaf1a70f8011@amd.com>
 <d6c3cf48-7699-7192-5655-4c5bd7f7a37b@amd.com>
 <b1277562-f425-b466-856f-f9590dd9a38a@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1277562-f425-b466-856f-f9590dd9a38a@amd.com>
X-ClientProxiedBy: HK0PR01CA0068.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::32) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97b07f60-3e6a-420c-81ec-08da03076419
X-MS-TrafficTypeDiagnostic: BN9PR12MB5244:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5244DC694C002A834781097AFB0C9@BN9PR12MB5244.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qmSykJBjtvZd6IsglsMs8WB535ibjhbxPQgGCfFLDSZoXzPPALWPaTA2wWUqHP6Ywnba3ABB6sGXMz13v17yLdlOWONK7cr6oCH7VrV5ZqpxZtkxguE8WJkJ5oh00fBTvJOcMUDLvH6NEOeq41p0dbajU7lgZqvjhr7bT8c7V5hDVm7XKeP9oRlwoWJ5d/2TwTc1k2986OqUhoNwRAO5Ec8kjn8g3geo/AjOScSg+T7PeXD2ux2R6oVIuoOByocutFnXFByCyqz0jYukmdbGymRnNyucgBHt+25joutqOPh6/mfUsqgBp0FJvFEUjQDIv7B7IKLa1OgeF8N+b0LFvVYc/0VbYvFbmtaS+Ql0fepK1rCimPa0rUlcB3Nz95lRc03KfCizZ68ZjW5ccqLo2LnvXUWTpFauA/b0g7xfMvnzoBaAXh4mLsdc+pMPDN2suP77wzFUxJAz2y3/pkJYmNvVthUIAnlT45etd//1eHC8KplU1ysPqid8FMvxhYrI1cGWUQZCvS/th2VPDYuni3QiD7q/dPEb0q0zCXC/CeuF/tLPbqtawgJTLGArnzW0omphiLQxS30yE2jAUDndjlixFloJLdtUy3qOHhqGgi5VHGr1CbFacZ54wBWfUVRx27916lF5XnnM9sKE7Sv0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(84040400005)(508600001)(6666004)(66574015)(26005)(186003)(6636002)(54906003)(86362001)(316002)(6486002)(8676002)(6862004)(66476007)(66556008)(4326008)(33716001)(66946007)(5660300002)(38100700002)(30864003)(6506007)(53546011)(8936002)(2906002)(83380400001)(6512007)(9686003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bt0OA4Q8ohLOyvgDI4tll1XovY3kYyhdWwfo2iOBOpFCGu58ybziokwpgZ?=
 =?iso-8859-1?Q?9Z9Ve2YExUqzLCHuXxRPX+nqrjkUVdQ/+najNk6gupzTfepxPWG+fzQIBV?=
 =?iso-8859-1?Q?tl0PCxNHUmZZgXxI8X6brIJCYTYnv3mPLOkevF2OMKGs9z44AbNpySRXyT?=
 =?iso-8859-1?Q?Rvz7oOlRi66Vgs8XuPjOYCHcDadakRrBwIINfcGFdcXEvij/iqU7Ldk/aX?=
 =?iso-8859-1?Q?Riq3/vJyuYmhc+RCxmHqcI00Clm7bz/zD4mQgLZQjkZI02NH6ucmmbOCFC?=
 =?iso-8859-1?Q?kw+2MtW4t1TPEMsbox7b6/ha7liKv9RdOjqets48bMPAktlPZK2B1HgJ0A?=
 =?iso-8859-1?Q?v7GXHR0BgOowF5hmRimhm5GyLDcHgxiPq9FSp6oYKD8m3s0aN5WY92v3yJ?=
 =?iso-8859-1?Q?7JGpEMouDx9NudzYH1luGeaT+F32VQc7OQ5mk5E2ms5jvPXj1BpxQN8af8?=
 =?iso-8859-1?Q?XVR0M4gi3yAP0ZN0A4r/zfD0FqnVQGL4JesX5uUqftcNdn4olm8gAUShMv?=
 =?iso-8859-1?Q?/z76rY38Sri7M+MvG4hBbAhAVj3GajZCNfL+RxV2sXyExxBRNtgvDhI43y?=
 =?iso-8859-1?Q?/1WHvGgWTkrS0SPCZevMv3SjkAzu+GAaToyNMa+PzrTXqmGDpCLXmWZufc?=
 =?iso-8859-1?Q?v1chfvSJwknKvfWdmRB/BZjNcXP5LOI2Bh5H0MyGzdDUKzvSAp8+B1Xltq?=
 =?iso-8859-1?Q?oDeIi/0XkxThnl5isXMc0QOdFTVyGeQayvKBySetqXJDzuTp0/owoJfqpe?=
 =?iso-8859-1?Q?PKFUWFJV5bMwBHL6h6okaRX29mteM640abvmb/EwytyF51OCNa3lPGnfi6?=
 =?iso-8859-1?Q?KN3CUiff0RnVMKtTB6VfQzCngSSlvGCL4ZUY3qitPDmQ92qjYznrErJcnH?=
 =?iso-8859-1?Q?UC4vRikp7Od/2oW2sIjg+qrC4JV5PuJTHStd8gTfextooyCHNV2ikZSJXo?=
 =?iso-8859-1?Q?JSpV/cWLOhe4XlFf3qX2holMJQx4YsAuw6/gyNBajrsKKGQ+aVpiwrD828?=
 =?iso-8859-1?Q?tgusHKiry96+WlWr+KU4zume/NWPKybFWclCMIF+qa3LPScQb6zGSX8ZTA?=
 =?iso-8859-1?Q?YN4KnpHEa8yo5uEucux4koYF2gVvYS1yF+L23ybONyun2VhOSbvWFoBMmn?=
 =?iso-8859-1?Q?t5Bmj6rXhX0Ghb6/xG2Vn8cn7Fd5gwJsbxxdTSmC4euVn2G5R8plG4/2gy?=
 =?iso-8859-1?Q?/VTYFPoFtWI5PUO1SGhy6wozOsjvbFZN2PQ7/gpXqgBG5/aMl2N1aSSF23?=
 =?iso-8859-1?Q?V8iWCnDFiJNkPvXNK4k+SfxVG5CWLB/iJpL7EPE3V1MmA5lIdVTyxblZJs?=
 =?iso-8859-1?Q?O1da0qr0e2aOEjhAZCm8FVXYqL2D/4fistRIIytluMp2x+XvaGi49OnNrr?=
 =?iso-8859-1?Q?3vppvk2jqLisdCLxLmAKvsu+I0D2z5ZtpnMAMke7+WZiabmhAr20mLhNuZ?=
 =?iso-8859-1?Q?8WwoWzGPmSBlx5TjmnoX49Ht7lsCKdnSjISZTvPhUS5ffnkekP7YMooamT?=
 =?iso-8859-1?Q?Gklw/Ybm0Z+mNoLG63ZEyK8QoWWVckbZsY7Uu9BSBaYdbw/U7AXNYyNOMD?=
 =?iso-8859-1?Q?iDTcG8pgDMu/eHvNCsr5d4S2jyJmTGsAMnd+eVay12K9wmy1Nq6ny98uzQ?=
 =?iso-8859-1?Q?75KJn3YDVcYyIULeKPY1vYtPyu9NLoF2OWzEaTq1rK0tHYcTN+HLULV4LV?=
 =?iso-8859-1?Q?ZrWR4HLkm4uJfGNBLMU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b07f60-3e6a-420c-81ec-08da03076419
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 02:32:31.0549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoOL+TwEb5+fQQSO3oIPVgWMf85IGC7W/sw/iBHD4RVarUwl8KSaTBcZuFsp/JdPs3CbiSLyNM89YTDZ8/PkcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
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
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 03/10/ , Christian König wrote:
> Ok, thanks.
> 
> Lang is that case your patch should work fine.
> 
> Just add another patch with a check for the encode case to reject any CS
> with TMZ buffers in it.

Only VCN decode ring is cared in this patch. For encode ring
(AMDGPU_HW_IP_VCN_ENC and AMDGPU_HW_IP_VCN_JPEG), is it fine 
we just reject secure IBs in amdgpu_ib_schedule like compute ring?

Regards,
Lang

> Thanks,
> Christian.
> 
> Am 10.03.22 um 15:17 schrieb Leo Liu:
> > No need for encode. Encrypting uses TEE/TA to convert clear bitstream to
> > encrypted bitstream, and has nothing to do with VCN encode and tmz.
> > 
> > Regards,
> > 
> > Leo
> > 
> > 
> > On 2022-03-10 04:53, Christian König wrote:
> > > Leo you didn't answered the question if we need TMZ for encode as well.
> > > 
> > > Regards,
> > > Christian.
> > > 
> > > Am 10.03.22 um 09:45 schrieb Lang Yu:
> > > > Ping.
> > > > 
> > > > On 03/08/ , Leo Liu wrote:
> > > > > On 2022-03-08 11:18, Leo Liu wrote:
> > > > > > On 2022-03-08 04:16, Christian König wrote:
> > > > > > > Am 08.03.22 um 09:06 schrieb Lang Yu:
> > > > > > > > On 03/08/ , Christian König wrote:
> > > > > > > > > Am 08.03.22 um 08:33 schrieb Lang Yu:
> > > > > > > > > > On 03/08/ , Christian König wrote:
> > > > > > > > > > > Am 08.03.22 um 04:39 schrieb Lang Yu:
> > > > > > > > > > > > It is a hardware issue that VCN can't handle a GTT
> > > > > > > > > > > > backing stored TMZ buffer on Raven.
> > > > > > > > > > > > 
> > > > > > > > > > > > Move such a TMZ buffer to VRAM domain before command
> > > > > > > > > > > > submission.
> > > > > > > > > > > > 
> > > > > > > > > > > > v2:
> > > > > > > > > > > >      - Use patch_cs_in_place callback.
> > > > > > > > > > > > 
> > > > > > > > > > > > Suggested-by: Christian König <christian.koenig@amd.com>
> > > > > > > > > > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >      drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68
> > > > > > > > > > > > +++++++++++++++++++++++++++
> > > > > > > > > > > >      1 file changed, 68 insertions(+)
> > > > > > > > > > > > 
> > > > > > > > > > > > diff --git
> > > > > > > > > > > > a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > > > > > index 7bbb9ba6b80b..810932abd3af 100644
> > > > > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > > > > > @@ -24,6 +24,7 @@
> > > > > > > > > > > >      #include <linux/firmware.h>
> > > > > > > > > > > >      #include "amdgpu.h"
> > > > > > > > > > > > +#include "amdgpu_cs.h"
> > > > > > > > > > > >      #include "amdgpu_vcn.h"
> > > > > > > > > > > >      #include "amdgpu_pm.h"
> > > > > > > > > > > >      #include "soc15.h"
> > > > > > > > > > > > @@ -1905,6 +1906,72 @@ static const struct
> > > > > > > > > > > > amd_ip_funcs vcn_v1_0_ip_funcs = {
> > > > > > > > > > > >          .set_powergating_state
> > > > > > > > > > > > =
> > > > > > > > > > > > vcn_v1_0_set_powergating_state,
> > > > > > > > > > > >      };
> > > > > > > > > > > > +/**
> > > > > > > > > > > > + * It is a hardware issue that Raven VCN can't
> > > > > > > > > > > > handle a GTT TMZ buffer.
> > > > > > > > > > > > + * Move such a GTT TMZ buffer to VRAM domain
> > > > > > > > > > > > before command submission.
> > > > > > > > > > > > + */
> > > > > > > > > > > > +static int
> > > > > > > > > > > > vcn_v1_0_validate_bo(struct
> > > > > > > > > > > > amdgpu_cs_parser *parser,
> > > > > > > > > > > > +                struct amdgpu_job *job,
> > > > > > > > > > > > +                uint64_t addr)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +    struct ttm_operation_ctx ctx = { false, false };
> > > > > > > > > > > > +    struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
> > > > > > > > > > > > +    struct amdgpu_vm *vm = &fpriv->vm;
> > > > > > > > > > > > +    struct amdgpu_bo_va_mapping *mapping;
> > > > > > > > > > > > +    struct amdgpu_bo *bo;
> > > > > > > > > > > > +    int r;
> > > > > > > > > > > > +
> > > > > > > > > > > > +    addr &= AMDGPU_GMC_HOLE_MASK;
> > > > > > > > > > > > +    if (addr & 0x7) {
> > > > > > > > > > > > +        DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> > > > > > > > > > > > +        return -EINVAL;
> > > > > > > > > > > > +    }
> > > > > > > > > > > > +
> > > > > > > > > > > > +    mapping = amdgpu_vm_bo_lookup_mapping(vm,
> > > > > > > > > > > > addr/AMDGPU_GPU_PAGE_SIZE);
> > > > > > > > > > > > +    if (!mapping ||
> > > > > > > > > > > > !mapping->bo_va ||
> > > > > > > > > > > > !mapping->bo_va->base.bo)
> > > > > > > > > > > > +        return -EINVAL;
> > > > > > > > > > > > +
> > > > > > > > > > > > +    bo = mapping->bo_va->base.bo;
> > > > > > > > > > > > +    if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
> > > > > > > > > > > > +        return 0;
> > > > > > > > > > > > +
> > > > > > > > > > > > +   
> > > > > > > > > > > > amdgpu_bo_placement_from_domain(bo,
> > > > > > > > > > > > AMDGPU_GEM_DOMAIN_VRAM);
> > > > > > > > > > > > +    r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> > > > > > > > > > > > +    if (r) {
> > > > > > > > > > > > +        DRM_ERROR("Failed validating the VCN
> > > > > > > > > > > > message BO (%d)!\n", r);
> > > > > > > > > > > > +        return r;
> > > > > > > > > > > > +    }
> > > > > > > > > > > Well, exactly that won't work.
> > > > > > > > > > > 
> > > > > > > > > > > The message structure isn't TMZ protected because
> > > > > > > > > > > otherwise the driver won't
> > > > > > > > > > > be able to stitch it together.
> > > > > > > > > > > 
> > > > > > > > > > > What is TMZ protected are the surfaces the message
> > > > > > > > > > > structure is pointing to.
> > > > > > > > > > > So what you would need to do is to completely parse
> > > > > > > > > > > the structure and then
> > > > > > > > > > > move on the relevant buffers into VRAM.
> > > > > > > > > > > 
> > > > > > > > > > > Leo or James, can you help with that?
> > > > > > > > > >    From my observations, when decoding secure contents, register
> > > > > > > > > > GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ
> > > > > > > > > > buffer address.
> > > > > > > > > > And this way works when allocating TMZ buffers in GTT domain.
> > > > > > > > > As far as I remember that's only the case for the decoding,
> > > > > > > > > encoding works
> > > > > > > > > by putting the addresses into the message buffer.
> > > > > > > > > 
> > > > > > > > > But could be that decoding is sufficient, Leo and James need
> > > > > > > > > to comment on
> > > > > > > > > this.
> > > > > > > > It seems that only decode needs TMZ buffers. Only observe
> > > > > > > > si_vid_create_tmz_buffer()
> > > > > > > > was called in rvcn_dec_message_decode() in
> > > > > > > > src/gallium/drivers/radeon/radeon_vcn_dec.c.
> > > > > > > Mhm, good point. Let's wait for Leo and James to wake up, when we
> > > > > > > don't need encode support than that would makes things much easier.
> > > > > > For secure playback, the buffer required in TMZ are dpb,
> > > > > > dt and ctx, for
> > > > > > the rest esp. those for CPU access don't need that E.g.
> > > > > > msg buffer, and
> > > > > > bitstream buffer.
> > > > > > 
> > > > > >  From radeon_vcn_dec.c, you can see the buffer for dpb
> > > > > > and ctx, and dt
> > > > > > buffer frontend/va/surface is set to PIPE_BIND_PROTECTED.
> > > > > > 
> > > > > > 
> > > > > > Regards,
> > > > > > 
> > > > > > Leo
> > > > > > 
> > > > > For VCN1, due to performance reason, the msg and fb buffer
> > > > > was allocated
> > > > > into VRAM instead of GTT(for other HW), but those are not
> > > > > TMZ in order to
> > > > > have CPU access.
> > > > > 
> > > > > 
> > > > > Regards,
> > > > > 
> > > > > Leo
> > > > > 
> > > > > 
> > > > > 
> > > > > > 
> > > > > > > Regards,
> > > > > > > Christian.
> > > > > > > 
> > > > > > > > Regards,
> > > > > > > > Lang
> > > > > > > > 
> > > > > > > > > Regards,
> > > > > > > > > Christian.
> > > > > > > > > 
> > > > > > > > > > Regards,
> > > > > > > > > > Lang
> > > > > > > > > > 
> > > > > > > > > > > Regards,
> > > > > > > > > > > Christian.
> > > > > > > > > > > 
> > > > > > > > > > > > +
> > > > > > > > > > > > +    return r;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > > +static int
> > > > > > > > > > > > vcn_v1_0_ring_patch_cs_in_place(struct
> > > > > > > > > > > > amdgpu_cs_parser *p,
> > > > > > > > > > > > +                       struct amdgpu_job *job,
> > > > > > > > > > > > +                       struct amdgpu_ib *ib)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +    uint32_t msg_lo = 0, msg_hi = 0;
> > > > > > > > > > > > +    int i, r;
> > > > > > > > > > > > +
> > > > > > > > > > > > +    for (i = 0; i < ib->length_dw; i += 2) {
> > > > > > > > > > > > +        uint32_t reg = amdgpu_ib_get_value(ib, i);
> > > > > > > > > > > > +        uint32_t val = amdgpu_ib_get_value(ib, i + 1);
> > > > > > > > > > > > +
> > > > > > > > > > > > +        if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
> > > > > > > > > > > > +            msg_lo = val;
> > > > > > > > > > > > +        } else if (reg ==
> > > > > > > > > > > > PACKET0(p->adev->vcn.internal.data1, 0)) {
> > > > > > > > > > > > +            msg_hi = val;
> > > > > > > > > > > > +        } else if (reg ==
> > > > > > > > > > > > PACKET0(p->adev->vcn.internal.cmd,
> > > > > > > > > > > > 0)) {
> > > > > > > > > > > > +            r = vcn_v1_0_validate_bo(p, job,
> > > > > > > > > > > > +                         ((u64)msg_hi) << 32 | msg_lo);
> > > > > > > > > > > > +            if (r)
> > > > > > > > > > > > +                return r;
> > > > > > > > > > > > +        }
> > > > > > > > > > > > +    }
> > > > > > > > > > > > +
> > > > > > > > > > > > +    return 0;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > > +
> > > > > > > > > > > >      static const struct amdgpu_ring_funcs
> > > > > > > > > > > > vcn_v1_0_dec_ring_vm_funcs = {
> > > > > > > > > > > >          .type = AMDGPU_RING_TYPE_VCN_DEC,
> > > > > > > > > > > >          .align_mask = 0xf,
> > > > > > > > > > > > @@ -1914,6 +1981,7 @@ static const struct
> > > > > > > > > > > > amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
> > > > > > > > > > > >          .get_rptr = vcn_v1_0_dec_ring_get_rptr,
> > > > > > > > > > > >          .get_wptr = vcn_v1_0_dec_ring_get_wptr,
> > > > > > > > > > > >          .set_wptr = vcn_v1_0_dec_ring_set_wptr,
> > > > > > > > > > > > +    .patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
> > > > > > > > > > > >          .emit_frame_size =
> > > > > > > > > > > >              6 + 6 + /* hdp invalidate / flush */
> > > > > > > > > > > >              SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
> > > 
> 
