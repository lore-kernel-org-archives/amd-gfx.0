Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ACBC982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 18:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F7310E032;
	Thu, 17 Sep 2026 18:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0GGOpnYw";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 028E710E032
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 18:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhDkJSm3gJ6QKXMuHm/M1FAByaKtU4dTaAFM8PaE9rLZ4L/phzsEYRwE/EWAgELjoVViSF4tr0RYiRgKmIGXRpoLwT84h1kbxPjtCrfWrbIO2AbM2mqe2D/rs9eFIwL0GIQwvqqOaxKcomHkLYmIprhTjQIqEZOcUnelH696fX2nD2iFzQveZo9n789jind6F6UrJjtuzr+ywsfU0+4yW8mZXqfhvBXk68wmf/uiX8CaEgo4kkkdG3Mq9rTkkNiGLtWZtztjqABtwpPZrIJjLr63KY4HcGJkIsuSn+AD5t7015lhznnt/eVMapjjd5sqHpn1fu2b/VBBUinzKX4RHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPFVfuGohKknhD/abL+COl4t9G8ITIdjjpW6BLS2TiA=;
 b=E1eqS0zl+gNEXSYF4ai60qFlPG6eTHy6Rbh5McctwAEkx8JgopXmZH0kORL04bkBT64EcS5yWX1y1N7pQhFS4aBq612ZUr+HwmeoMxjyhh9NGCV4Nn7Gr5malDiBr7LETpHjguWlfP+x0zzWJqT0CmREv5gjl3ab46kW6lsAtItvDn63qVUDK4d5EEjk+f/OnRNjfQL1hDeL5BHwSZqBhWGevLzOP98V6VoJ9Lra5Uzz21Jmua/bMtlGBQm+qPqu9DPTUqPfV/oMZvDCihobTUo4hzEytsaDzEiJZoebwVLrHBVszR6Q1QAMj5uV3CcNAcvVvP3od4aoefK/Lli7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPFVfuGohKknhD/abL+COl4t9G8ITIdjjpW6BLS2TiA=;
 b=0GGOpnYwI9QND1/iVlqMXz/O2jbV2k3+h26qDCsNXT1ARMMackL+1IG8jhVaNO9ofDrxXPVKCn0fyeY7P0sDA6UN4U8kkoLx1chvDMro2T+dFNEnBgCcu1jR6ZABnOvY4t6qh0idce2mGOzYQtcjGMRzW9bpK9T6G5+MIg79ZQs=
Received: from DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 18:17:22 +0000
Received: from DS0PR12MB7536.namprd12.prod.outlook.com
 ([fe80::6a2c:d797:8fa4:72ce]) by DS0PR12MB7536.namprd12.prod.outlook.com
 ([fe80::6a2c:d797:8fa4:72ce%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 18:17:22 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: don't widen the validate GPU set past one
 page owner
Thread-Topic: [PATCH] drm/amdkfd: don't widen the validate GPU set past one
 page owner
Thread-Index: AQHdRSK/4T+kZj/BlEeD5uuiGsAm1rbTFvxQ
Date: Thu, 17 Sep 2026 18:17:22 +0000
Message-ID: <DS0PR12MB75369C49F33D3D517826ED21F5B82@DS0PR12MB7536.namprd12.prod.outlook.com>
References: <20260915145833.601947-1-andrew.martin@amd.com>
In-Reply-To: <20260915145833.601947-1-andrew.martin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-17T18:16:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7536:EE_|SA1PR12MB7199:EE_
x-ms-office365-filtering-correlation-id: d2558675-f1e7-42e1-05a4-08df14e7eaeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|10067099003|22082099003|18002099003|5023799004|56012099006|11063799006;
x-microsoft-antispam-message-info: FJ4A6QQtapSt8Wpwzyhz9yGuJQeRgDc00GIfa+1DshO2MAwIZa03O7W3PaU40AVUnHUAG3LJMQI/oflmheMZCF/R/E4Jqt7HynISfFrZxgVSjeiKDIs4iNBQ/5HpDyD1YUufCyhEjVwyYUMbQk1gEUUp67crDRMI67BqX7dYpi3nZGguDhsF1iOBKNxUzeO1ulxTnjQcNwkdbxm9wKTt84gynmE2KjCOKwWkWe+C+vFg7pHNiBVHMrq85mqRYIsojpwRO7P/3T1MkriJ+KC78/BBtmr1OMitQz2hlsTyuZ2Y2/IvmmrEcLwzM35GADBxDz8SO+fKYXlkYG2VyJFTnOX6u19iJ6mLtg4Nz/Qf8Ge/xJ7X55Yom9H2WPhcnPXpMcQ5sQuybhzPxjFSZYmj0Rc/LkLqg6gQbkF1G6e4CpbBzqI7HVZbI1PSG4+sLPk9+N/VWtcHxGOBTgLDrty4DPaDgfmXEm86OMu13AKGL6hmaoEmYZ3ir6VkfUi3kdFdDvuLuSAL/aloaGqsIdmVAjLk8Wwrz8APDFoDAqBh7TpFLWNYn/sfDGedPq8p/Jm5LglAl4hRUidCJ+XJK0z9bEgry47gEMuyF6+diK9dGFmESKzYff64EbrrckRchpqyIghpONQc1c9PA6xB4NW8vFXilPAQLkiQ17zZ4hupEzNaokK7PJoyOrWhadQp5sgcqtgEwtOezR9uuBaLNnPHu/Y+MQzzl2z8xh5diM7BMrg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7536.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(10067099003)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kS0jb1CLP53a5n+kAJgQoxZoCrM75REqXK0mvCYHhaiWG3V6J1fEBQ9J2psB?=
 =?us-ascii?Q?207ASxa+kK+CQMoKelgPi97DG7xzu8bI3z3cch6YvONu3vJJQJ/jwxHAheMV?=
 =?us-ascii?Q?PjIuPg1SZPoSMR0pMZ4kaeX80cgGpY8bwAut1sNMFl8IQN70dL0OzuExOeML?=
 =?us-ascii?Q?Vowu8eL459sybcZdNcZ4MaD3kfx/4weLtU++0IvwSQfoPO+MZkNeMX5DJ911?=
 =?us-ascii?Q?z+TgG8l8giZJysSu+Dp7dLVfsa+1JtdnLRIEZFakHtjGH3RzT0ZM5Sg6ozYz?=
 =?us-ascii?Q?zj1Vp+YAuBwz6AKi1/vgWrL+0cewAbdfNKK1hnaDqW+ChQCVoPu1qsOueeRF?=
 =?us-ascii?Q?f57F39Sx+84R9CtP923ASesTCe/t5TS84cR/K7tND5phrDAmWKkxELnctxD0?=
 =?us-ascii?Q?lYUNbfAEUFN0KKqRncgmAiZplCR6E+4nGV41/HEb27LkxQpOkl3IPAaxSg6i?=
 =?us-ascii?Q?rfFH5eDsu+AUCgWoYsjgpkhSwsX1fx9i7qhwP4yTz3KG0PBbSgseyAZYxvA9?=
 =?us-ascii?Q?kGRQDXhASO8BkLzMacTDhUivKIBf15unrfZOtCO5nOQ0rv+pU8+jJ5v01nf8?=
 =?us-ascii?Q?XuReQ+C/OrQaiZ2L7iHA9/O38C32q2TB5Pmd0eGTAdqaocclvEhW+er1e3eE?=
 =?us-ascii?Q?ydaYOVBzb2Z0Fi9xWkabiggx2/Ld9ZqFF3VkdFQcALboIwUF1xqBmf9ZjEyn?=
 =?us-ascii?Q?WB4OTf8SXHh0mzqKyCX7ry6ED9J3bb096j2QENtlo0AefO7W5ES/tOKrh2Oz?=
 =?us-ascii?Q?oYfWW4PNzOpusZUaoO0VS2aRz3BJKtMDDasSlc1qecA90C+lxA1ouB9cxQXr?=
 =?us-ascii?Q?xLUwQGa61DR8trIjCddcvySYljwU60neKPhiUhJ9UCqhBwlty5HbDZVNV8sG?=
 =?us-ascii?Q?BUDmhGNXjB3N+XcAnGblQgm9G4CeCyzAqlsNrM5V7XoTip8xjo1XQwcA9OB5?=
 =?us-ascii?Q?Xg2uR8JjAWfz0HchkwGAt0DPpyWJ9zNFmABjSMPJBTg88nk2SyFUIvFOPPHL?=
 =?us-ascii?Q?kN0Ba6r9YlgGQYZctG3lXP9VYYVSeB+O01zET3yd6O4c4Mpd0t+71/0RaWLn?=
 =?us-ascii?Q?88+TltmV/MDp/hRezkEEy8vN361jrAxeiy3KvITs1/flWrCaLdP7Eq8CY41R?=
 =?us-ascii?Q?zIU/CYTx+Ge5CiAJAfO6x7pgVVxyps3/FKWZsP3KUe/bdDrh/ME2hqozn0Uc?=
 =?us-ascii?Q?cg9B9q9xr3HroAqKglkhN3zD1JDErIFvRYknP+6JiAT+cpDJp3079PGAFfZc?=
 =?us-ascii?Q?DoZ5HhkIsppY0dO1XOfVlIKw3wlN0x54dlhsrPJqGpg5cyv+LpT3xb93Yt8s?=
 =?us-ascii?Q?vWdu7yWvPZen+ZCWogpWwRiv1rUvEIywLexZlGHIxgx/6GMQYYtNC1faQzoL?=
 =?us-ascii?Q?kd8OGkHgJWTXf/2HOGrrl3ok1BKulK7OtRanRsrX5KPF7BSTAqMXtKUyDrFm?=
 =?us-ascii?Q?D+0D0a3tdM5jntxD/a+JSha09m/FRsSKdesc++KVG0mwoqLoiEmtnn8sViXe?=
 =?us-ascii?Q?pZaldCQObU9T0uKnCGWVpcckdmvaF+XjXo5q6TKtP7MH32qFE+9+ORiqb7NZ?=
 =?us-ascii?Q?gndF8cy3vZfnQz6hcYgQl0g2o4aGN6MxoTObi2NfZFVZ1Lcuo5e4k/Gnlk+H?=
 =?us-ascii?Q?8l3UDPMZwZdvB2k3iSD2LQT2Rp+Z2iFJRFD/lOuphlpI9N2MTAyakXDkaX9J?=
 =?us-ascii?Q?th+9HVUC/uhvv4/glS54upVA5SNEQc42D5pj1nz32j3wWhEc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7536.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2558675-f1e7-42e1-05a4-08df14e7eaeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 18:17:22.0833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 238GYMZ+WhnOHC2l+JaL3D0+Tr79xPWptioIWZrozsUjfHx393u74AtJlgDdNHnWPqPK+Hmlk1qkHvk1RUYnDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD General

Greetings, sending peace

Just a Ping to have a look at this.

> -----Original Message-----
> From: Martin, Andrew <Andrew.Martin@amd.com>
> Sent: Tuesday, September 15, 2026 10:59 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Philip <Philip.Yang@amd.com>; Martin, Andrew
> <Andrew.Martin@amd.com>
> Subject: [PATCH] drm/amdkfd: don't widen the validate GPU set past one pa=
ge
> owner
> Importance: High
>
> Commit 6b2969831f7e ("drm/amdkfd: Unmap svm range from GPU set to
> no-access") made svm_range_validate_and_map() OR bitmap_access into
> ctx->bitmap unconditionally for a range carrying
> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED.  Previously that only
> happened when
> ctx->bitmap was still empty:
>
>       if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>               if (prange->mapped_to_gpu ||
>                   prange->flags &
> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
>                       bitmap_copy(ctx->bitmap, prange->bitmap_access,
>                                   MAX_GPU_INSTANCE);
>       }
>
> The block just above already sets the bit for prange->actual_loc when the=
 range
> has been migrated to VRAM, so under the old code ctx->bitmap was left
> holding that single GPU and the OR was skipped.  Without the guard it now
> also picks up every other GPU with the ACCESS attribute.
>
> That matters because ctx->bitmap is not only the set of GPUs to map.  It =
also
> selects the HMM owner: owner is taken from the first set bit and reset to=
 NULL
> as soon as two set bits disagree.  On a two GPU system with ACCESS on bot=
h,
> owner becomes NULL, and amdgpu_hmm_range_get_pages() then no longer
> recognises the process's own device-private pages.  HMM calls migrate_to_=
ram
> on each of them, svm_migrate_to_ram() sees
> p->svms.faulting_task =3D=3D current and returns 0 without migrating, and
> hmm_range_fault() retries the same page forever.
>
> Which GPUs disagree depends on the interconnect.
> SVM_ADEV_PGMAP_OWNER() is the XGMI hive when the device has one and
> the adev otherwise, so GPUs sharing a hive also share an owner and never =
trip
> this.  It takes two or more GPUs with ACCESS that are not in a common hiv=
e,
> which is why this only shows up on multi-GPU machines with no XGMI link
> between the cards.
>
> On a 2x Instinct MI350P (gfx950) this hangs
>
>   HSA_XNACK=3D1 hipblaslt-test \
>     --gtest_filter=3Daux_handle_test.set_sm_count_target_default_is_zero
>
> The application never completes and burns 100% of a CPU in the kernel.
> /proc/<pid>/stat shows utime frozen while stime climbs and minflt advance=
s at
> roughly 12 million faults per second, reaching billions; majflt stays at =
0 and the
> GPU sits at 0% busy.  perf on the stuck task is 24% svm_migrate_to_ram, 2=
3%
> __handle_mm_fault, 5% do_swap_page.  The process cannot be killed and the
> machine has to be rebooted.
>
> Restore the bitmap_empty() guard.  The rest of that commit is kept: the
> bitmap_mapped tracking, bitmap_needs_unmap, mapping_done and the
> unmap of ranges set to no-access are all unaffected, and bitmap_mapped is=
 still
> ORed in at the top of the branch, so a range already mapped on a GPU stil=
l has
> its mapping updated there.
>
> The instrumentation, the hardware testing and this changelog were done wi=
th
> the assistance of an AI coding agent; the resulting change has been revie=
wed by
> hand.
>
> Fixes: 6b2969831f7e ("drm/amdkfd: Unmap svm range from GPU set to no-
> access")
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> Assisted-by: Claude:claude-opus-5
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index c521ec07bf3c..75e25f075da3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1758,9 +1758,14 @@ static int svm_range_validate_and_map(struct
> mm_struct *mm,
>
>               /*
>                * If prange with always mapped flag, update mapping on GPU=
s
> with
> -              * ACCESS attribute
> +              * ACCESS attribute.  Only widen the set when nothing else =
has
> +              * selected a GPU: ctx->bitmap also picks the owner passed =
to
> +              * amdgpu_hmm_range_get_pages() below, and spanning
> GPUs with
> +              * different page owners forces that owner to NULL, which
> makes
> +              * HMM fault on the process's own migrated pages.
>                */
> -             if (prange->flags &
> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
> +             if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE) &&
> +                 prange->flags &
> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
>                       bitmap_or(ctx->bitmap, ctx->bitmap, prange-
> >bitmap_access,
>                                 MAX_GPU_INSTANCE);
>       } else {
> --
> 2.43.0

