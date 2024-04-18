Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FD1C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 18:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA35E113EF2;
	Thu, 18 Apr 2024 18:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tjPTJOX2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA822113EF2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 18:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPtapWKv7cDEGbDryapbpoR8n3TjsSPj1xH3Y0GnX3futxg9D0LsmSTeZFagaT48n0ea+BbLH36BFy5MlMI5ERXW1jx7O/UVb3otsy2S7mjtctNQT/OlEp7y3fZOcqwDlE7DeR72u120IgTVJ4W4ptJr6GK2uX3uv/Gx+/ninx6h/PUMD937DrmK6FBI+3fb0Aw60e2+oIiEFTneL+FDLyV/oTW3zTjdARsr5ePU4Xo+C9sFGtDZgNsxesMdU0eJae9VvH5Wdwn0GuRPIpiZP9uKJ+N1WrShiFnm/jxqbR4TghSndVoDIII8ijIBawFHTWpdWNH7RJv+foGIX5+EYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+3KFnV2s0QJWnjx2dE3ldG7Egs1ugpmWJ3Yeil8gt0=;
 b=g0dch6VsLwYwf0v0YDoCUvI2rxDGmDF36M71+OVB5+wGxoqnH+7x7wFnkxwkRvKqwnQkA/PJO3wQjM6tCOTTRoECeOUW1mcvWDVVy8nUQhjCXrCD5d8JTVqOyOM5BDnYJsKacWvQ+56VdXAcXF2WHvsMtFZ+D241qPRqGN/E1IFV3y4jkFaSVeYAeiYwxSgyuC7jRGN+z4ofgjcmTtlD142yrRBi/SdkO+pc6gDp5TUT3oIhYCHyM4OSpNp/bpvRJrkIcXJYOAfX0W20vVEbXrs8uzZ/ymP0oJDshOW/ZokiNRJuzrJ+c44uVXmmYnYyMgzykVvmGNA3ftEzeQI73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+3KFnV2s0QJWnjx2dE3ldG7Egs1ugpmWJ3Yeil8gt0=;
 b=tjPTJOX28Dma7wd8Qj8K/22UNR9uCWDNfLfm6k2Q5Cyo+KdLqvPHFoGdPMe5MTiyCpwNQVWmfV6WnWE1INtpco19GaLmO4qg4yQR19A24lp7bGY8GsKSkb+81/GM/kKD2/PUP04+QeX0YGURYWyKMrsVmWUXRq078460UbfJhnw=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 18:40:00 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%6]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 18:40:00 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update BO eviction priorities
Thread-Topic: [PATCH] drm/amdgpu: Update BO eviction priorities
Thread-Index: AQHakbtBpeYKmQlAaE+1qWMdkEeTNLFuWznQ
Date: Thu, 18 Apr 2024 18:40:00 +0000
Message-ID: <BL3PR12MB642591E17BB64CD3B2242413EE0E2@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240418180648.2934147-1-felix.kuehling@amd.com>
In-Reply-To: <20240418180648.2934147-1-felix.kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=53a8c732-03b2-4229-91f4-e599baf356a2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-18T18:36:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SJ1PR12MB6361:EE_
x-ms-office365-filtering-correlation-id: 40573e15-fe2f-4ca8-4bae-08dc5fd6f415
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LrWG9Zq/9gDaMPFWBMv4Nyp1TLqtDXLCZYTKUBejlwK7QHac+O/yddTOQhd4RPrWl7jkdwZDMWJGF1NKCrnKwv3AyK/kkc3fzkOkgLOLDti7Iaft8jsyWH+sysuelLsMqAV7O18WOL79C35eEQGUMZeSolqiE2sSlTnh6bpcho2GLGSqh6RH2gDaSB1kwe3sMOEg0okkFdo0qOetCbCSq1EQcVksPqqJxJXZhqOaJ0/jCjIBtEtA5uZ2QJxpGSTYOacGQ55rz3YzawQ3/L62T8oZ4d0JosDUk6218UBh1bMPKlVJYn8iT5XwPIYn5LVRA4TJOWZrhCZ+dEtNEPR55+d2PuSkk1ikB2X/+OInjDXAjiTA/hXDTp+PQ6Fv/E+0dsGO4bE6F/Oh62Bug0MA8FAAP8F1iEo/CDgXxNm1At6s/86cd+Dy111ZVS1whRVxgkn+vfaQhy06QWPZz4rIRnj3aEseFp4ntX23vMcNYjK6CQWdcEhM0DJUPa5bV/Vov5NPDd+tmkPUCHnr7XCKdoxp2fp5XcmYgFaiaR5NjN5XLQzIlD5uhU7ii7Y//lyPSIO/mqPvTXtimW6oTu2TE7X8VLG97v95iJMeoUvC05VmO7sh/p99olwzwVs7CBiWLtKtvr+oukIGywFTY0suw0EzdgbOBawlMuq0tSH5MzIcRHPJd6CidPQpPajCvm+Px1DBq4hZUZPyFWPZ+pYZ/45Jj019JSW47l3gndCvjBg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RyMeRPBbG1f1l9ibyvxSw4pQeUR2xNCyMeykVcnlwoTzUyazgkVmyaFqkjFw?=
 =?us-ascii?Q?M4XwuVydEU8aPEX8w/XwFmwdvrWsvPWRTYkX147iJs2kS9YZ0O/7Yj0CRzqo?=
 =?us-ascii?Q?FAQDIcl+A3Fa3QLMoKEVSAS9HYNKoXHHnwv2n41ODdHvri2aXcYnqlJ9s67c?=
 =?us-ascii?Q?V3g9oEWJftFfzTM8PHbctfaOJrPHimLmzj2n3tpw3BKFnnfaK5A1jRyvQ5/z?=
 =?us-ascii?Q?YddjSjuHpNp5DxfnWJzxknSTjB59qFyPUa3XDE7AWwjdZX5i+4u//WxBvSVl?=
 =?us-ascii?Q?pRNjgUmO0jN/LGSsqeGOfyix4NWs3BcThcgfUNJyxNLge70nfsJU+tw3biEj?=
 =?us-ascii?Q?JDScMCjk+0xydfZrmcuMooylIkzmnI6ib7c0DKM0TWCVQwgb4P+HFu5NbZOp?=
 =?us-ascii?Q?KjpakznyRbBisWO9jriM/CUOcFY4fgykGGubXfm0KOlVuaN+VxkLGx5eff4+?=
 =?us-ascii?Q?ll7/Y2JULJQW9pNXLZbs9ssMyqlqZ/QGCQuWSorQwkCYX+xy3wOvcy/a6KxB?=
 =?us-ascii?Q?lWn2ApmgxL3lbz5oAI/W/tf13e8NwFWPh6boVdkd36KAqIxJ6gf+taq82I1N?=
 =?us-ascii?Q?CB0i98S9v0wLxLTl6cosB6G6bCeJw3MN6kuLHxWnc50K6JIT/VvsYv2B8XKo?=
 =?us-ascii?Q?BRBF1a7gnB0lD7yEbaQkTO9+lnOhH8ZoIMCeSwwYPlIxX9gtREcuIlxZl3/7?=
 =?us-ascii?Q?2x8tuwkUXZeTVDvDWYZqpKyAncRbT+AQ+GMTF1VWY7436luGDxMThxIF5Ig+?=
 =?us-ascii?Q?dQpk8ezy8kkQoopEkCgTUmEeglSCcTUUcN8w8k3g0UVMEjWv10feULlU/c5V?=
 =?us-ascii?Q?huLX5fJrkcvTyeAJt0T3sL4Kd7kI1eSagPVVHPePTVJomHtJt6Af9RWBWYDX?=
 =?us-ascii?Q?BxaTP8Vjb4K+rulOtK9Tpcv97gOlBLNQMDTAszZzbsM9l0CAc0pGHsJB1syF?=
 =?us-ascii?Q?YFeYDdejpSxX1W9w/Z5AsGfknj2b/axgCxjomhC2fQ7pjdvGJMr+uLxoYO7h?=
 =?us-ascii?Q?x8IypB7DOxyatBeYUmRmzCLItmA+FYD9FWxXamcmVJLzbYDLrP0u+g9Pf0fS?=
 =?us-ascii?Q?xgeETVmQ77L4uYOHuit+7kyjjQXiZPu+CrJkBGPjAAza/1qNwlXCYQljxyqB?=
 =?us-ascii?Q?hh6W/1YXThvmAAtiuBZJqSVZk7vwlVqtrJJspLCggx11SCbCxNIKPYNzy5J+?=
 =?us-ascii?Q?N/LTSG899aV/e7v9kNYSPO+M9NTSXxe0D7acP83Gz86jiuzEMhzROC9qCYBl?=
 =?us-ascii?Q?NEstjyHDtoRKvPx1UzPmcqCDbV+eb8hIThiDJQw9/E5iYVMGF1gup3kttOwy?=
 =?us-ascii?Q?v9zE2H5IPY+91c8aVdtXkNeVRoS5Sf88L0xPrqRKgqPEdnR01wYOCMJK3fo/?=
 =?us-ascii?Q?aBdiZ0hcLRWnS/x75JNJa6U4RYjJY0/xwK4CVSKCw1uDwJLzDkgCCJ1x3bPd?=
 =?us-ascii?Q?Yub8kLE0vDZz/Kjjg8a0KYDkC2Oc4HRVHDvP6F1nnap4XFNj1C1XNkqbyK4z?=
 =?us-ascii?Q?7rD1Rpgz3qyy1zXB0VlA/LwcEAo6YocQqw2wIyvc0+Dd2+gRpsIqzB1XkTGL?=
 =?us-ascii?Q?Z1iBYg2n4Tozv/PjTj0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40573e15-fe2f-4ca8-4bae-08dc5fd6f415
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 18:40:00.2159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MG5qhAY0TRe+fYLncllEq39neUa8K4/SiSGxy8/BlLZHyIGnipdGLJqltlUDrJO5cvGztutDsl4RgDE7kz5a7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361
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

[AMD Official Use Only - General]

Tested-by and Acked-by: Mukul Joshi <mukul.joshi@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
> Kuehling
> Sent: Thursday, April 18, 2024 2:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: [PATCH] drm/amdgpu: Update BO eviction priorities
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> Make SVM BOs more likely to get evicted than other BOs. These BOs
> opportunistically use available VRAM, but can fall back relatively seamle=
ssly to
> system memory. It also avoids SVM migrations evicting other, more importa=
nt
> BOs as they will evict other SVM allocations first.
>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index cd2dd3ed7153..d80671535ab3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -608,6 +608,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>         else
>                 amdgpu_bo_placement_from_domain(bo, bp->domain);
>         if (bp->type =3D=3D ttm_bo_type_kernel)
> +               bo->tbo.priority =3D 2;
> +       else if (!(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE))
>                 bo->tbo.priority =3D 1;
>
>         if (!bp->destroy)
> --
> 2.34.1

