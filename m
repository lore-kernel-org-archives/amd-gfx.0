Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BD6C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6706910E4EB;
	Fri, 31 May 2024 06:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X5HK+LOA";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E75110E4EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIsttgTotaYwxi/JunFFIpDhTbZ28boXvdxqo9CHaaOpjbA+QTEkbzf1YKsG8hMBOZZ55APsKqmTDtxAb8dP4+oSnGOs4pswvsBtswUljBLa/kCacDexE6X9ANKvjKCrJLCXTpOJtkjJ+91B4zbtAxaV/JZaQ9zdNbdYDs4x1epMZJVjGoaUBULp38pEvp6GkreHsJrqF1iHcG5F+h9k1Bi6KgOW2+V27YqP/upmfM263nesZVlZa9LOqE4S1IfDIqyfzHpm7mHIctrkxtt0+5ztowYK/hlclswBU+yHrjE/oYvRXcGBpvkP5qU3jnO2sAbpDdibiarOFs80JGsIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPJusYi+PQ0TRn5Jdlm7109WHlIzZQ2j3ELe3BE1P3M=;
 b=h5OgitpB1QLbLIW2gAU/S1aStd+pK3sNYf9GvZBuE7WyO1lbXzn8rzPq8hWX/87nHxAQ7Rmn8QHsf77xqeeA7QAM/Y4GruMDLDp03jcwrVm2Ec0A8LuZ2TcqS5dR4fiFvUSVgeenuJe6OFKmr64frBW5RoM9ZLlwKON32XpRODg8dzHnjiUqm639u5pvucdEldjOPE4OQaIwoyXRDeVYU8C+Y+VvVIlExer4FbRrywm8eY+HCGKamfXAIoloFfOOj70qVDsMDbdcpgo7FwbnjhGcGr7InY7xaHZY3r8pGvEOrqHVV9tDEWeGGGSnl3Urnmkw2BvkZ8/6YvZhroPCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPJusYi+PQ0TRn5Jdlm7109WHlIzZQ2j3ELe3BE1P3M=;
 b=X5HK+LOAHEtlSJ3n4qeIbez8R9BTCSjq376eeVXBFSmlp8YII0YctkZZPY4n6l+wSUHEsRsu3+R7+GsjqwYqvMmMo3vgfukL/H6vODJ5wNI/kbiu5k7ohTtAy/+GWE56kTJ4l0mBD4EJ1sUbNTavA/wCxyR+nowXDOucsq3FqZo=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 06:51:11 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 06:51:11 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhou, Bob" <Bob.Zhou@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: Fix the null pointer dereference for
 vega10_hwmgr
Thread-Topic: [PATCH v2] drm/amd/pm: Fix the null pointer dereference for
 vega10_hwmgr
Thread-Index: AQHasyXcSM5Nh3dfw02L6lYbRhY9MbGw5hKw
Date: Fri, 31 May 2024 06:51:11 +0000
Message-ID: <CH3PR12MB807452CF87A15D45148A234CF6FC2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240531064328.17351-1-bob.zhou@amd.com>
In-Reply-To: <20240531064328.17351-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f97c44f4-2792-4319-ab04-6e1697dd41ac;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-31T06:45:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB6917:EE_
x-ms-office365-filtering-correlation-id: e25d6403-1f76-4b93-669c-08dc813e0ec8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Uzf6+qYKAARonXUtkEAJ6++nkKhb8BxLjftD093ZncInUaqmxA4AORpUoEUw?=
 =?us-ascii?Q?O6Z2l8aeq1Dv+vh1HeXVLPNbSs/lFf+8uuIuYqoVYXcvvoJnsvUDWiE3Eh+e?=
 =?us-ascii?Q?47C7qPXu7RAEBYYcSuZo87rsn+24YKgNz9c+biDQhSMP0x/rDzmjP/U6vgDf?=
 =?us-ascii?Q?9J69TWxclZCKCKKpmKGbIMFJ5KITMLh89CkFi18EQzAydQbNrwt6MllCjFXn?=
 =?us-ascii?Q?Fow1UW29/L3fqgXyg4/SILIGtU3ceGG33EDRIhAe3KBXiJfDOYiXi5u58kwg?=
 =?us-ascii?Q?yN4s53W5WeJhs0jrPf4XFp0TwFv4ndKfektgJN6nUQ5IwkcF5MKcSaqgtSzL?=
 =?us-ascii?Q?jNUPDoPBEHac10YJ4rBVMgly8JHqzaG/rh/eoM2kDusPBIRJ1kGVNpSy9n4V?=
 =?us-ascii?Q?gDcFa52O3KGbMIn1Eev+qq53mKiMhEJLThxsXFApk17+YyF+cvW0ebcFzyj1?=
 =?us-ascii?Q?ZtHSml64nf42U+Bjw9vUdt6UGqPyiEt2zn/xOu+0SnUs/J9zwNJSCZhg/c3j?=
 =?us-ascii?Q?ek16UEdb4SxygDwRgOgRA6jev2VClEQMBIiXKkQ42lyMs1Z/e3l0qxhDlHTE?=
 =?us-ascii?Q?Mg0IGgqxxKd7W9H2oQzoOYmy+QCuwNb/UoR7IQd3qlDsIgSpjiCWghNDcEdt?=
 =?us-ascii?Q?cyep1FS5BPylB89vxVWDqs2iCv1NQ2+WGD6z1E/t4y7OQ5GkoNMe+SiF0rO+?=
 =?us-ascii?Q?F70NCpBDqZTd/nfm1CtMYkaw8qr/75QfbN+KBAgaT/E//sJSGjoqsTvUguEc?=
 =?us-ascii?Q?AKQoE9BdvJJ6bwikTvG5Umt4wW20HCjp4CByZ8Kkp/gXnX2x2IuICUbpOb7X?=
 =?us-ascii?Q?F+WlzewFC5NdxwCDxXxLUgf5SUQUkO6hInw0dfA/w+OKWrImEv0VgLF9muM2?=
 =?us-ascii?Q?AeksghyHtuD15tpja0JOQGmtGDksngPzEkEb0I/D1VWRTx3Usf4hxymo9nNV?=
 =?us-ascii?Q?lB5qBAxqlbSyRGwP4PLZwZuXvdry8Hd6gnuaJKE7OXHpYcWQY7jPD+fIMFQB?=
 =?us-ascii?Q?C4gfDULQaExo0HJ7KfoJ7t/KWg5YK+Ab5B2aK25eV16DGknD2+JyOczbfTGY?=
 =?us-ascii?Q?jG6lK2ZALr7BkGdxLoFNbxn6Ee9IpjpnMqOMxwujCgTwzBKjJ/aYRSoISlxc?=
 =?us-ascii?Q?AGPWPNDodJQEJWfaqAMxE/NZOCMrsvzkf4nvnufWpUKsxsMbx/9WXz7UEK5a?=
 =?us-ascii?Q?sIU4Z/8QtCaxxPbxIGLSx0STn9WCv754Bpk5SYIogpjVzoTAxjY0YLk/NagO?=
 =?us-ascii?Q?C8teHzyA6YfjaJOqUX5gjbF4YMddDzog9RPccEcelAMp1KX66Gjob+2tm0bD?=
 =?us-ascii?Q?9aeoiLJI2aN2/RUZSe5QC7Qi+/yR+DnbQvU1WXrTcIrNnw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UesnI7CuyefxN49ilXx83WpIUsZ1tUj0VkGb5rPKWgwLe8YXGJpT8Uf0Gpyj?=
 =?us-ascii?Q?glAF5VzO4bNPYP68j3bnPDOoDuwGm/+FkpPWDFmF6AHwk6HAKR1Kp4YVwNKO?=
 =?us-ascii?Q?3ZyonP5QEO96Mvfy320w2W7SWLiAPfutHQls0JAPpNH4SRiemWaeaX9TwD1s?=
 =?us-ascii?Q?cf1Py1TmTsVBelt+tNbS3ZpLGmay1lt9hOXt7k7iiOvGSY1QkT5LbNFq4WEF?=
 =?us-ascii?Q?usZ/9+yJWKyqSOAxkd++z8ziI8OF74a8vhNj1/vERJfV9H+JTdDTt2VFVdSB?=
 =?us-ascii?Q?CNIdAKcH21cqZ693rMOsvg2K5J8wRksTnfTj55EuYKRiC0nr9FBLyRL2/UPm?=
 =?us-ascii?Q?ZEcuuWtxya1trd4N+3x7LnM3RQlHZq3kK7foVAhG4olzwPq3FReH4MF1A1nd?=
 =?us-ascii?Q?R1sCTHaUqbApmrMVtTLr81tjppaOeR337F+WeH1Tp/GYtO0LnFgMVaIdTHA1?=
 =?us-ascii?Q?UPDTZhnBvBATcbmSnCXc5uPvMFrkZ9qLSqcQQmIX3O0Ew4Nf6iiBv/GyEkI5?=
 =?us-ascii?Q?sbj/hnumeTDCttaavI4W/BMwWl2p1fNGBGKhHW9tdBksEGzCXAjp6Vb6eJF/?=
 =?us-ascii?Q?vQMNTsdjPVQcfCdm7pkMuWc3kq0UpxqKFv9g2ViJYSwOYJpvkumLuRQd5eXP?=
 =?us-ascii?Q?QdcikWlTrVv9Gvhtvi2CCeeSZQhPFYvWo+j7C3/dtf7JkfIoVXiE4pBjQUBH?=
 =?us-ascii?Q?3JNCpbae7IG0+TrrS/4uTKhcb6PFIMLHbuv54Lw7ZhZGrEq7wT0jT5blCJG3?=
 =?us-ascii?Q?g63FQNR74pfHs77bTxMiodj8691AGY/PiHgystEtJ0YuZRTB4cSGULrLugCG?=
 =?us-ascii?Q?g08cP5wDmp3WaZzRdUKpTGHCrJ+eK8SMpIy7RWIJV9kwpDtDnTALocZI0rCk?=
 =?us-ascii?Q?k3xN0s82li7KJR30/ZDnLt4mbVjrA8+hj2lGEaq+lMuHSvEBdp9i8nezu6bC?=
 =?us-ascii?Q?8qUGXEqoB5AOxPqHIKNOH30U+Tjix0ciqaaarshWSdMD/hFTHFoYBtewwONA?=
 =?us-ascii?Q?mOLVpPmzhFv0n+EnCyU3QcJ6gGRTWAp4rxQ+SbeKTWClxh9VgB9PvO+OyKpH?=
 =?us-ascii?Q?IchASPTqwvNBwZmphOGnRcPseGFIzhceEEAa7rp3fHZ4zU36lTdZfQDfU9ag?=
 =?us-ascii?Q?767KFLgWd4WHQtpvTaxIRWQMWU0W3g/SKHFKmF4MgAkPbgc07UOnXDhPh+eE?=
 =?us-ascii?Q?WZJ3np7i8LdmzC3jymZj/nkxwWxDYHdv8AuSz0PoC7t7CartusMSJztRsNME?=
 =?us-ascii?Q?qNFpu70m1EOqHy9m5r2m5UkT3xnyBZFQF+b+kIbcL1VL3dy10+hwcGYKnkLU?=
 =?us-ascii?Q?sksvKASwFnF/k9nYK8n28LJ2xiEJHPcALjwcjSRjLJBRGR6Dz6xaM/gSNUCw?=
 =?us-ascii?Q?dTm7W/r8KODaOyVLq0w6xsn/sYQ6XR28UfA7BNrh+upUrD4bw17HYqb+/Jvj?=
 =?us-ascii?Q?k7C3lK58NweJcW56DtLjqoLIjuFT3y5kDpUcIdhxQneib5+Lg058E+dKz0i3?=
 =?us-ascii?Q?jEqj9QRwsawOx/b0ntHgwkhln/4sBgf4NZ64jPusxudvxLGX8DaarQw/LSDt?=
 =?us-ascii?Q?PJUf5Zox17JXuG1glrE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25d6403-1f76-4b93-669c-08dc813e0ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 06:51:11.5183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZpwxHH08awAsovGQw116/05mYk8h03HX6z2ssQ5Px3pOcAvTkJsqMRWWg11LddBoxCHeokxFFczT7m+luSCnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bob,

> -----Original Message-----
> From: Bob Zhou <bob.zhou@amd.com>
> Sent: Friday, May 31, 2024 2:43 PM
> To: amd-gfx@lists.freedesktop.org; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>
> Subject: [PATCH v2] drm/amd/pm: Fix the null pointer dereference for
> vega10_hwmgr
>
> Check return value and conduct null pointer handling to avoid null pointe=
r
> dereference.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 19
> +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 6524d99e5cab..68b93a0c16e4 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -3438,6 +3438,8 @@ static int
> vega10_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, co
>                       (const struct phm_set_power_state_input *)input;
>       const struct vega10_power_state *vega10_ps =3D
>                       cast_const_phw_vega10_power_state(states->pnew_stat=
e);
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;

Can't add the check here, your changes for the sclk and mclk in previous ve=
rsions are still needed.

Tim Huang

>       struct vega10_single_dpm_table *sclk_table =3D
> &(data->dpm_table.gfx_table);
>       uint32_t sclk =3D vega10_ps->performance_levels
>                       [vega10_ps->performance_level_count - 1].gfx_clock;=
 @@
> -3752,6 +3754,9 @@ static int vega10_generate_dpm_level_enable_mask(
>                       cast_const_phw_vega10_power_state(states->pnew_stat=
e);
>       int i;
>
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
> +
>       PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
>                       "Attempt to Trim DPM States Failed!",
>                       return -1);
> @@ -5035,6 +5040,8 @@ static int vega10_check_states_equal(struct
> pp_hwmgr *hwmgr,
>
>       vega10_psa =3D cast_const_phw_vega10_power_state(pstate1);
>       vega10_psb =3D cast_const_phw_vega10_power_state(pstate2);
> +     if (vega10_psa =3D=3D NULL || vega10_psb =3D=3D NULL)
> +             return -EINVAL;
>
>       /* If the two states don't even have the same number of performance=
 levels
>        * they cannot be the same state.
> @@ -5168,6 +5175,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr
> *hwmgr, uint32_t value)
>               return -EINVAL;
>
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
>
>       vega10_ps->performance_levels
>       [vega10_ps->performance_level_count - 1].gfx_clock =3D @@ -5219,6
> +5228,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t
> value)
>               return -EINVAL;
>
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
>
>       vega10_ps->performance_levels
>       [vega10_ps->performance_level_count - 1].mem_clock =3D @@ -5460,6
> +5471,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr
> *hwmgr)
>               return;
>
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return;
> +
>       max_level =3D vega10_ps->performance_level_count - 1;
>
>       if (vega10_ps->performance_levels[max_level].gfx_clock !=3D @@ -548=
2,6
> +5496,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr
> *hwmgr)
>
>       ps =3D (struct pp_power_state *)((unsigned long)(hwmgr->ps) +
> hwmgr->ps_size * (hwmgr->num_ps - 1));
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return;
> +
>       max_level =3D vega10_ps->performance_level_count - 1;
>
>       if (vega10_ps->performance_levels[max_level].gfx_clock !=3D @@ -567=
2,6
> +5689,8 @@ static int vega10_get_performance_level(struct pp_hwmgr
> *hwmgr, const struct pp_
>               return -EINVAL;
>
>       vega10_ps =3D cast_const_phw_vega10_power_state(state);
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
>
>       i =3D index > vega10_ps->performance_level_count - 1 ?
>                       vega10_ps->performance_level_count - 1 : index;
> --
> 2.34.1

