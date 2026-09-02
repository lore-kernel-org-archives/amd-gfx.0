Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9459CC61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 06:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D4710E473;
	Wed,  2 Sep 2026 06:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ksVN2zY";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010032.outbound.protection.outlook.com
 [52.101.193.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D680C10E473
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 06:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIzFCsbcxEqLqk+MVh1vPZh44xo0wmzHVvSNdGCz6hD7Jdj8t4R0x4bPlfcZzKezhIvtgJT4A0M+JGDy4f1F7ApP3pxs7f8jZtE0ZxOK0Um0n+kzi6fg3yWBhM5VGzEi+1KzJHGb3+qKUGxKQuXFbxevRENw4vyyIIkZlNpUI6++3oqfEip3xpR18ySJN1dzm0n+0N8amW1C/mQwBGhfvLDlflDpVXB78nNpe/nbiRCk9AKMvcFq+ia+mCvA3C2oxwbrTpfw/fNY3bx7TiiaxOaletn2zEDsEn0IxEKlR3uClw/LRE4HLm4HTem7Mi0/walnaoqIaMGgWG23bDVLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/eaXtlAn/BcfHQcYx5jBfCRPJowDTZGJoo3v/J3RcE=;
 b=VNBtn2I6NmCD0IdbCkTsdD6x/re83EeIfUUA2GOIsOcvpM4jBSC8oulphNdhvJssglMUO1R7iTGTWnCKHRZs1FqGNGz/UyJ3UA30Kcao8/lSclj9MQGS0iNESKjpiayd/vdpabNGT9nI+bPaPnXu01+/iDsj4on0FdCcj7ElI8OWEsn+anvg2lfQp032nOCJ8Xp/NjJ8QBGETN77JnFfMwgWgVqMwIPM07UQR53gnxog6YSMEc9Nxqzwak/4R1y5LbxHTgqo8ShGh02EYhYHda9uyHWrtu8Qf4FtvJQIyBGZX7la7zi6qnGdmz7BKyqgOP5rSsK7LfuEkKUmz2yS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/eaXtlAn/BcfHQcYx5jBfCRPJowDTZGJoo3v/J3RcE=;
 b=5ksVN2zYDCeC++reSSqQQ4zu8RA5HqBNIKCjQxR20xwVRTmvD+uVYAUmgLKaBd7nCGB4AQvD2g3iTzQFw6nRkz8PvPlkFYTQ4NFUERVRZa8mY6NZtHNEm9LrQMirtxdRD4tKAfF8CPDUFY6UMCDKN42C4jHUqppRwiKAWv/4YTo=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 06:26:17 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 06:26:16 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 20/31] drm/amdgpu/gmc: add new callback to lookup vmid to
 pasid mapping
Thread-Topic: [PATCH 20/31] drm/amdgpu/gmc: add new callback to lookup vmid to
 pasid mapping
Thread-Index: AQHdOk4NGl3e6m9YoEOSPvkWd76oIra60cAg
Date: Wed, 2 Sep 2026 06:26:16 +0000
Message-ID: <DM4PR12MB5152483D83142FC5B37F1AB2E3B72@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
 <20260901201034.2960437-21-alexander.deucher@amd.com>
In-Reply-To: <20260901201034.2960437-21-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-02T06:20:41.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA0PR12MB7774:EE_
x-ms-office365-filtering-correlation-id: 77acc005-37da-49f2-615b-08df08bb1832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|6133799003|3023799007|10067099003|56012099006|4143699003|18002099003|11063799006|22082099003;
x-microsoft-antispam-message-info: 0ADG07qVq2s4khYpVAuHRcuntPXiCbAum09vrlLShtOm0ZAKCd6Z/0iEG68cJQIwRdaIM3sdxHoKQ1dhITzxajcK3VUBMwFnRStl6RwkEldBoiSEHgtLKTVoSqTjXDnIZ8CAsVtAOY2VZSq0OmiiZWV1DPMU0YNd0mTDFupyIdVs+szDoqF334dc7YdZjKCyt/Sat/xZ6+rmnHk3AbqY+RqXhWS+Ahdhfg2mPjqTh71KUgvtHWv3jvHVcwH82KjeB1kF0UH3r4XpaharzMgy0R+CVpfBYBOspcJvH0Oxo2q/Qz69Y5B05ud7rShEYK9seHf2hWdLT5xLbWBlFqJ6sKaCM0AB7wa89fjG8eazDmPZgOeJKcGUGI40Frobz+/xEqMxTpmIxzWSuyJ6fMMwY+xXqzB0y/hverXvKoDVuxd4WMHzJHHqUtnsFcaY9LwSA7geacrPQreI0tzcqTRaSV/JhLUYjm+8xn901UU6FTOr67duxVoDrK0vU+nqUf/BD3/RoIXjWR+jt4qgj6dP93lUOZAu/BTti35tv1TGdhFIL6DBra2sggCHPVduQnno5GVGVRksPzbQDFZbJVW10DkHi7+6sqH5H6vU0CPMYsnONp5YrYEJu3xf38OOMXtWfIdbi9SOQiqZ1VCkX27M13AiCOBpBAPnJv54JLdWG2JFmGCXuX8GcgcOSer2Hslqwxjx9yM0NYBuTN994oxO46fSMvGg3PMFDmBshuwhv7c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(4143699003)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Kz/XjaBdY7P76LYEMzoJ30ZupseXxvK+aC6Jl1oBQ/fFmjIdN4C/EWnlZ3y?=
 =?us-ascii?Q?SMSJZ+zfmU86fgqOxFzX4e1gsyaz8QM2akm9nuJPgIEFuLQTVhB3TAFRH7eI?=
 =?us-ascii?Q?gfFB9nFidH+vFDvMvkUDRyZeu2RQ6rKXwDxjqrEQWrjIMkchjtnvpcjyqTA9?=
 =?us-ascii?Q?hjlSwKAViNghuUMD8kmlQeAdv44uMSHJtDluDUS+XGr/wWPPIvtjONbFqcwu?=
 =?us-ascii?Q?cfDYl2uZo83TfYC+BEbnTAM9lE5BFn3nt8lnTaF4ZHwymurewnXBWBA8fkWk?=
 =?us-ascii?Q?9lOTLaZ6UZxX2OXGv+pBd9R6f4ob/Qws4/FBQm9FbBMEKcK+BMJgjDUuwnhb?=
 =?us-ascii?Q?d2TRkPlyOnj3ymuvfHnMDgTO2vrviBl2HDlrQ8SesiwAS3GUiSacOVe9y3ti?=
 =?us-ascii?Q?YAgk8rAzCTj51o+BrsnVjK60a/5UKg5EZUCbWd+8bchK6iK1Ol0sJZGZI9Om?=
 =?us-ascii?Q?8sWJeIAafCt6ZLnD1+TG41TeuaUUGbR1TrA1WNhiO+SbsE5WSSkDTxTGmlXg?=
 =?us-ascii?Q?IrJNTj+VdJYyWjxDl8zsrTZRKpcu4wg8CiWudkUPebbJrck8dXxyd1lKH/OU?=
 =?us-ascii?Q?EbZdWNTaGh+xKPLqY3Ez0uliKka5bf23hiR8LgD7vn/hGha83kA0x+TDFwAa?=
 =?us-ascii?Q?/9Fu2J2dbcnaAwTArq7ImOEQ8TrenW0msFgfpFUf6l+OiuqMCimej9dnw7nX?=
 =?us-ascii?Q?Cp1L7LfjYNFABR2WWUdZGDs7ObrpJj4/uOWTOapIZ9oBf2Akp+hi87UXuIa3?=
 =?us-ascii?Q?Ezvci9IVp9vaSRWWhlvEKWAQye62ULSe6Qdplx9jWMG0T6rWoH6h9NB0s91T?=
 =?us-ascii?Q?zuzYSoNNiWgMD7oxaklmgDAXW2skKTdF/VPCSwAgUCbvPPLdqKOpe4wbcaCP?=
 =?us-ascii?Q?FadOVQn2iXXbHb17QpcxFwGuh6xa+emIBbRbVIY5fRp7mpr5c+n3Z2ZJnF2A?=
 =?us-ascii?Q?2OQ3lceqWCbeW7Pi+7QGIuJyUUE00zu12pxGQ41uALYHTeZY2cln1l9olRgP?=
 =?us-ascii?Q?EKZbIlRFC5ZMcKXQCsR2jzxTQ77opoD8B3GnNzYf/ScmKZwmB4c2tjrkIrJ5?=
 =?us-ascii?Q?IWzdh+9yZnxA446oIdUJ58oJP5azs6yJ2e4YheMbq14sfpherE20dFOUOcG4?=
 =?us-ascii?Q?oUcq5RvY5yL1d/2n7eYK4Tqgsx3S1w71BVxOlivJQtC2uFQvaKrsTs81v+4R?=
 =?us-ascii?Q?17iU3Gp8mKyYJUy2Vwf8Zrt3GMy6LIpyPBzG1jTr6xxF1fls0O8MwTzivKk2?=
 =?us-ascii?Q?H+IQgl597YqjNWTv7yaBqNA+uei7CtVHUzXK0BZh0h+Rnpv0KHTSECghoJqF?=
 =?us-ascii?Q?SgIlU8JJ+85w3ywxLXyu56zTH+8GUhb1aF0IYV9pJk5XN/LYcLv3yIUJ08Tz?=
 =?us-ascii?Q?ylYt6xW7topvOG/pxYciL/MFAAoELcAitmWwVuzorJaKY0iKpdpOw2zhpSMo?=
 =?us-ascii?Q?xwje7VqWpiWuu+dHXe+/AZz+anPTd0DeLpvOymCidUZmKHj/+5FHX6F7FknR?=
 =?us-ascii?Q?H5woKbGGqr7UT8g4nGYBNbU/ca0OlWcvLvPT7CKG/+ZTXJQpeqgsZJJbiDTn?=
 =?us-ascii?Q?3y0sHfEU0+i/uzZamQwJlHBLsS4pBJ5Bxhv3OmASf11eDitZ84j5KP6r8nX7?=
 =?us-ascii?Q?5Q9q0spkN0LPRN3UyrUJ7+W36bR7tIVG9GhD78jKLCbs7isTcZ2aH/KiuiMU?=
 =?us-ascii?Q?ioHNEW2IYyO2vzjDpFN5iFWtP+qa41/cwbMNTNEA8iJOguOg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77acc005-37da-49f2-615b-08df08bb1832
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 06:26:16.7533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvjO8SY2S+6nazP/wqbqXy1ES3m8PgnvWKn0aXXFD6UeqT/lxVBgbFNNCLJvznsuq0/6/Oia1vE2si5SzvQaTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, September 2, 2026 4:10 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 20/31] drm/amdgpu/gmc: add new callback to lookup vmid to
> pasid mapping
>
> Look up the mapping so we know which vmid to flush.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 7 ++++++-
> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 6 ++++--
> drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 6 ++++--
> drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 6 ++++--
> drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 6 ++++--
>  6 files changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 204cf1c360896..27785b1b38ccd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -171,6 +171,10 @@ struct amdgpu_gmc_funcs {
>       /* Change the VMID -> PASID mapping */
>       void (*emit_pasid_mapping)(struct amdgpu_ring *ring, unsigned vmid,
>                                  unsigned pasid);
> +     /* look up the vmids for the pasid */
> +     bool (*get_vmid_pasid_mapping_info)(struct amdgpu_device *adev,
> +                                         uint8_t vmid, uint8_t inst,
> +                                         uint16_t *p_pasid);
>       /* enable/disable PRT support */
>       void (*set_prt)(struct amdgpu_device *adev, bool enable);
>       /* get the pde for a given mc addr */
> @@ -384,7 +388,8 @@ struct amdgpu_gmc {
>  #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev-
> >gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))  #define
> amdgpu_gmc_emit_pasid_mapping(r, vmid, pasid) (r)->adev->gmc.gmc_funcs-
> >emit_pasid_mapping((r), (vmid), (pasid))  #define amdgpu_gmc_get_vm_pde(=
adev,
> level, dst, flags) (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (ds=
t),
> (flags)) -#define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags=
) \
> +#define amdgpu_gmc_get_vmid_pasid_mapping_info(adev, v, i, p) (adev)-
> >gmc.gmc_funcs->get_vmid_pasid_mapping_info((a), (v), (i), (p))
Spelling error?
It should be get_vmid_pasid_mapping_info((adev), (v), (i), (p)) // a -> ade=
v

Thanks
Jesse

> +#define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags)     \
>       ((adev)->gmc.gmc_funcs->get_vm_pte((adev), (vm), (bo), (vm_flags), =
\
>                                          (pte_flags)))
>  #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)  \
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 23d9fe995a2b5..0028639448956 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -204,7 +204,8 @@ static bool gmc_v10_0_use_invalidate_semaphore(struct
> amdgpu_device *adev,
>
>  static bool gmc_v10_0_get_atc_vmid_pasid_mapping_info(
>                                       struct amdgpu_device *adev,
> -                                     uint8_t vmid, uint16_t *p_pasid)
> +                                     uint8_t vmid, uint8_t inst,
> +                                     uint16_t *p_pasid)
>  {
>       uint32_t value;
>
> @@ -346,7 +347,7 @@ static void gmc_v10_0_flush_gpu_tlb_pasid(struct
> amdgpu_device *adev,
>       for (vmid =3D 1; vmid < AMDGPU_NUM_VMID; vmid++) {
>               bool valid;
>
> -             valid =3D gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, v=
mid,
> +             valid =3D gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, v=
mid,
> 0,
>                                                                 &queried)=
;
>               if (!valid || queried !=3D pasid)
>                       continue;
> @@ -555,6 +556,7 @@ static const struct amdgpu_gmc_funcs
> gmc_v10_0_gmc_funcs =3D {
>       .flush_gpu_tlb_pasid =3D gmc_v10_0_flush_gpu_tlb_pasid,
>       .emit_flush_gpu_tlb =3D gmc_v10_0_emit_flush_gpu_tlb,
>       .emit_pasid_mapping =3D gmc_v10_0_emit_pasid_mapping,
> +     .get_vmid_pasid_mapping_info =3D
> +gmc_v10_0_get_atc_vmid_pasid_mapping_info,
>       .get_vm_pde =3D gmc_v10_0_get_vm_pde,
>       .get_vm_pte =3D gmc_v10_0_get_vm_pte,
>       .get_vbios_fb_size =3D gmc_v10_0_get_vbios_fb_size, diff --git
> a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 098e1340554c5..b34bd7881726d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -200,7 +200,8 @@ static bool gmc_v11_0_use_invalidate_semaphore(struct
> amdgpu_device *adev,
>
>  static bool gmc_v11_0_get_vmid_pasid_mapping_info(
>                                       struct amdgpu_device *adev,
> -                                     uint8_t vmid, uint16_t *p_pasid)
> +                                     uint8_t vmid, uint8_t inst,
> +                                     uint16_t *p_pasid)
>  {
>       *p_pasid =3D RREG32(SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_VMID_0_LUT) + vmid) & 0xffff;
>
> @@ -338,7 +339,7 @@ static void gmc_v11_0_flush_gpu_tlb_pasid(struct
> amdgpu_device *adev,
>       for (vmid =3D 1; vmid < 16; vmid++) {
>               bool valid;
>
> -             valid =3D gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
> +             valid =3D gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,=
 0,
>                                                             &queried);
>               if (!valid || queried !=3D pasid)
>                       continue;
> @@ -546,6 +547,7 @@ static const struct amdgpu_gmc_funcs
> gmc_v11_0_gmc_funcs =3D {
>       .flush_gpu_tlb_pasid =3D gmc_v11_0_flush_gpu_tlb_pasid,
>       .emit_flush_gpu_tlb =3D gmc_v11_0_emit_flush_gpu_tlb,
>       .emit_pasid_mapping =3D gmc_v11_0_emit_pasid_mapping,
> +     .get_vmid_pasid_mapping_info =3D
> gmc_v11_0_get_vmid_pasid_mapping_info,
>       .get_vm_pde =3D gmc_v11_0_get_vm_pde,
>       .get_vm_pte =3D gmc_v11_0_get_vm_pte,
>       .get_vbios_fb_size =3D gmc_v11_0_get_vbios_fb_size, diff --git
> a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index cffc818880d12..9179dc0787f13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -196,7 +196,8 @@ static bool gmc_v12_0_use_invalidate_semaphore(struct
> amdgpu_device *adev,
>
>  static bool gmc_v12_0_get_vmid_pasid_mapping_info(
>                                       struct amdgpu_device *adev,
> -                                     uint8_t vmid, uint16_t *p_pasid)
> +                                     uint8_t vmid, uint8_t inst,
> +                                     uint16_t *p_pasid)
>  {
>       *p_pasid =3D RREG32(SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_VMID_0_LUT) + vmid) & 0xffff;
>
> @@ -374,7 +375,7 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct
> amdgpu_device *adev,
>       for (vmid =3D 1; vmid < 16; vmid++) {
>               bool valid;
>
> -             valid =3D gmc_v12_0_get_vmid_pasid_mapping_info(adev, vmid,
> +             valid =3D gmc_v12_0_get_vmid_pasid_mapping_info(adev, vmid,=
 0,
>                                                             &queried);
>               if (!valid || queried !=3D pasid)
>                       continue;
> @@ -581,6 +582,7 @@ static const struct amdgpu_gmc_funcs
> gmc_v12_0_gmc_funcs =3D {
>       .flush_gpu_tlb_pasid =3D gmc_v12_0_flush_gpu_tlb_pasid,
>       .emit_flush_gpu_tlb =3D gmc_v12_0_emit_flush_gpu_tlb,
>       .emit_pasid_mapping =3D gmc_v12_0_emit_pasid_mapping,
> +     .get_vmid_pasid_mapping_info =3D
> gmc_v12_0_get_vmid_pasid_mapping_info,
>       .get_vm_pde =3D gmc_v12_0_get_vm_pde,
>       .get_vm_pte =3D gmc_v12_0_get_vm_pte,
>       .get_vbios_fb_size =3D gmc_v12_0_get_vbios_fb_size, diff --git
> a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> index 6c0d2689cc05d..3fa1ec3dca273 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -668,6 +668,7 @@ static const struct amdgpu_gmc_funcs
> gmc_v12_1_gmc_funcs =3D {
>       .flush_gpu_tlb_pasid =3D gmc_v12_1_flush_gpu_tlb_pasid,
>       .emit_flush_gpu_tlb =3D gmc_v12_1_emit_flush_gpu_tlb,
>       .emit_pasid_mapping =3D gmc_v12_1_emit_pasid_mapping,
> +     .get_vmid_pasid_mapping_info =3D
> gmc_v12_1_get_vmid_pasid_mapping_info,
>       .get_vm_pde =3D gmc_v12_1_get_vm_pde,
>       .get_vm_pte =3D gmc_v12_1_get_vm_pte,
>       .query_mem_partition_mode =3D &amdgpu_gmc_query_memory_partition,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index a91d0ddb6e729..0019706b0b2a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -727,7 +727,8 @@ static bool gmc_v9_0_use_invalidate_semaphore(struct
> amdgpu_device *adev,  }
>
>  static bool gmc_v9_0_get_atc_vmid_pasid_mapping_info(struct amdgpu_devic=
e
> *adev,
> -                                     uint8_t vmid, uint16_t *p_pasid)
> +                                                  uint8_t vmid, uint8_t =
inst,
> +                                                  uint16_t *p_pasid)
>  {
>       uint32_t value;
>
> @@ -889,7 +890,7 @@ static void gmc_v9_0_flush_gpu_tlb_pasid(struct
> amdgpu_device *adev,
>               bool valid;
>
>               valid =3D gmc_v9_0_get_atc_vmid_pasid_mapping_info(adev, vm=
id,
> -                                                              &queried);
> +                                                              inst, &que=
ried);
>               if (!valid || queried !=3D pasid)
>                       continue;
>
> @@ -1302,6 +1303,7 @@ static const struct amdgpu_gmc_funcs
> gmc_v9_0_gmc_funcs =3D {
>       .flush_gpu_tlb_pasid =3D gmc_v9_0_flush_gpu_tlb_pasid,
>       .emit_flush_gpu_tlb =3D gmc_v9_0_emit_flush_gpu_tlb,
>       .emit_pasid_mapping =3D gmc_v9_0_emit_pasid_mapping,
> +     .get_vmid_pasid_mapping_info =3D
> +gmc_v9_0_get_atc_vmid_pasid_mapping_info,
>       .get_vm_pde =3D gmc_v9_0_get_vm_pde,
>       .get_vm_pte =3D gmc_v9_0_get_vm_pte,
>       .override_vm_pte_flags =3D gmc_v9_0_override_vm_pte_flags,
> --
> 2.55.0

