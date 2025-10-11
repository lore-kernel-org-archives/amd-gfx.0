Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF535CCD184
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 07:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F5DB10E2E7;
	Sat, 11 Oct 2025 07:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GIiZLK3C";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B77C10E2DB
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 07:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmZOcRZfBZBsDMySw7Nu6gxKrC1Jc79PZgmTrSOlp6flY95KTqZLALabAEhIF8wGFZcGXkOmZ4qG6Sj4LszCmFGPL9aPX0c+2JJydEq8Y5DsTA/4Vb4hO2elV9/eZtmFuGXpHnQVkJbD5AGk+SDVEgd7QZQk/Xx1/VqlFimCFaNTlWkfIf6gtwVlbd0dIO/8rs8tdl+AvpwjX1xKDVV8i23Ze1hu2unIJaTf3VIceiXfpiN+rBWYnXkORfrrFlrpoSNDJTFu2Uz4CEy2maOkJ9BnCWDI9ZAE8zXWbQl5x/2urib3D3GgPVHXlc2CCbYQ04oMODTFgMtUebDs28I8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1T7MEOMFZjeJ9SbyPHNmZyI68iapQSGk630OCLACZk=;
 b=b96axsMN9LmjH2bDjqG284zUiqpu9Kbn6bb69UfKe4Ja1eiGOuO+TaMUtpMzi8dFwA6KXVSEyvjCf65JdIonJ5Wj6NpRNGVA3v47I9OMkF6M4SS5BaUPcdimYcdVoxza09N4BVzq2grQ5JV3RrQO0+08tmlElgXatTbPBP3qQp6cP6/Sc3V3IkB/uMMYf6Z8Rt3Eg4CzXHoXafukHiVF6XN+ecEYNroTzZbfc+9FAILYKmYvp0hUiMiPEIo8zvAWpyBNO+NK0RIZ8tfwgsfkhzFPYpA9Cc2VQw8ai0b31B+5hR9vgj1cOKP+FBvqC8qC8Hza4N7akj9iuUxvUIwWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1T7MEOMFZjeJ9SbyPHNmZyI68iapQSGk630OCLACZk=;
 b=GIiZLK3CSfsDbC9W1i1SWU0mV1N1jG5sx2qsnxp2w6RYJ7FZ5fVgsX0W/xBcpPJI1EDnCpLl8TwR6fiBYxHs9MpmzURx2zJv1Hu9KoCaRt0faWRQGud/omUeK6BFn9VHeLL3lxnJ+AoByJS9uArhK6DsF37WKfP8OUQnf4GD8dA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Sat, 11 Oct 2025 07:39:24 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 07:39:24 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix bit shift logic
Thread-Topic: [PATCH] drm/amdgpu: fix bit shift logic
Thread-Index: AQHcOhMr5YemJR0oH0CPrjc5GB7zarS8j87A
Date: Sat, 11 Oct 2025 07:39:24 +0000
Message-ID: <DM4PR12MB5152491597EF5BFF459D3190E3ECA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20251010182418.648766-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20251010182418.648766-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-11T07:38:03.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DM4PR12MB6012:EE_
x-ms-office365-filtering-correlation-id: 0fc3842f-19da-453f-fcc0-08de08994cad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SDSLZiDWDiNU/tszzyy2nk6nusO4ct4dveCTn9x17ULMNaDu52BZ7ysgXvQR?=
 =?us-ascii?Q?rf/3dRgLEsXq3KcWdDrIbD+7Lp/mzFk9TBLSY7bTznvaVSWin7sHxX8A9phC?=
 =?us-ascii?Q?dsyQSwjx2JhD3Ercipf9Rp7YnwIz+rMz24dbQY2EzR5kkhzeWDk9JV54p/hv?=
 =?us-ascii?Q?HvQhw0WsJvMaWvbkNMxmnFbd+Nt0Zt2IP+ipC96+V7jQxaqT+mEZ6055CiNC?=
 =?us-ascii?Q?svomw0kVLsOIUqX7okxHIcsdVv2bF6U532s8jiuy9ncqROsz8j0c/s9xY0bQ?=
 =?us-ascii?Q?VSDqnUdw7DhTpjnwBwhEVKGV11b++/jtRVA19SUCA0i6fLaCxwLC43tAzL3O?=
 =?us-ascii?Q?i+aFuf8gKug3pVLUkyPeYxfgFfUBSyIr3InDf5FSlt9vHZPkku/B5GO4PdtV?=
 =?us-ascii?Q?Hny6Z7A1cMDyJtIsNg60pFdJ5k4HM0OQeiuvW2j+1vkXSC+hte4EwRrjVfLH?=
 =?us-ascii?Q?GfAtdJO9VhfwAk5x+mGgNSbcA/RHIfpktsov7A9Csm3hjByL6wYFm3p4+5Kz?=
 =?us-ascii?Q?XjlToYdpx9cKDdHclrHCcQIwHHIMM9Hwr64Ihum7wiDi+8Na/JlQR7s0pRhF?=
 =?us-ascii?Q?kd9JTNjJFlAjOEvHg8KvdDCsdbbHB+hLdomN0Y8PQaHo+nFMWvgFHtGZ70tF?=
 =?us-ascii?Q?CVaJAXwoE+sHHtIW5pLfwZE1WjiBS9OXLsV7x7+tLKsNPVRMjvzeaZPAAKpS?=
 =?us-ascii?Q?tblVX4y2cDnEvTPrszz56cYeORLElGuINBUNJUazR5aEEx/mUVKdRTqjcn+c?=
 =?us-ascii?Q?7iOh9tIHxr2SoiJ5dSmRNbcR9lQIHYdFnRoNBDuxNTCuUVhCkmPPzNL0GJ5b?=
 =?us-ascii?Q?1gcu6OKRaYcUFr9ufYpUbVCbGpSMeJaUNGWe0b0e09HJMq3CtsZZiB7rjWue?=
 =?us-ascii?Q?0qvLCz671LpET73SF7gVkVG2AQjblXEcQVfpijXgyIgHLCdfYG4RT9cCXzOR?=
 =?us-ascii?Q?lNhdtY5n25rZk1zBw9rQ31uOQMP+Kmx28KequkIpHsZ88Z3kpY9j+wOUEWaO?=
 =?us-ascii?Q?9trAbOejNA3R8+ki0zxL+E0Z0uQufzbhrZ76G/Y7iqy5/u3c7P2L416xOYFq?=
 =?us-ascii?Q?MqRTTAST7pWvPMzi/drUiEbe90bCBnzYan/iGA4sdi4giKJrQSyYJJlAVWhu?=
 =?us-ascii?Q?g206otKAkjChtNn/NmNPelBFv7+GkltG1wJhvgsevN1aaHNfaIsPqWkaGSWQ?=
 =?us-ascii?Q?sq2jULMLR1KAUAJnPzAYmKV8e7uaSzmTR3acgNTOe7N/k5bPbBqnsrQROy3z?=
 =?us-ascii?Q?lEDj5ClqeGX/qsdEuVn1jbpfzLiDQpxUyNOjdF/a+HAyA5so2/LJvHfpNIvZ?=
 =?us-ascii?Q?eJMNsOsBUy/Byh9MVtqOCJSmKy+OLMUc8tq+5MMs9xIU4YigACNMUy7Xev2T?=
 =?us-ascii?Q?o2YH0ptOqGbNJpfpjaA42orD4IcOM5ycXFo/oY3iXoFu1f08RCtk8RmaNsFt?=
 =?us-ascii?Q?6XRRIGIdGem/3v87MeDJ4S0XhijAoJwmOqV33zzbqkYHXKsjivRjfY9UoBHw?=
 =?us-ascii?Q?3T+xGGZ5CdR/Q7nwxb+d1T3p2pBRq6HNJ+6D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xAzG1OBIfjySOMbd43EJpNtx42EXFbGmfCkGMW590ZLjLq/Z4IrFxINrMcY3?=
 =?us-ascii?Q?sSnyX4VW6ptqgthcY32jll3P4Hk2UXT9noEyJAxDo1cstRkYg+wzF7YAWh8y?=
 =?us-ascii?Q?jn7fNVXdpwgMuOp99WNjO0vnwZvmBz6XYwr8rPLdRn1DFq3KCU6yBQrtJHQF?=
 =?us-ascii?Q?y8ZPljXjdALQS/aNTH9l2JU2nAkMixF1O6bbmeJP4/q4BKd5gBqlf5aY4CtC?=
 =?us-ascii?Q?sfx0FjUb3PYTp1fY/Qt9YqiRU62D+Z6YqinFhlEs25R4cQuPTrJ4yERtRUpA?=
 =?us-ascii?Q?JNVPHBsKb0S20BMCSZ3GOprVgOsfqZUnzzO7Vq89a1hhUVOJfRq+cVUbyJoD?=
 =?us-ascii?Q?JJmEfjy/0pfPw4LhFjfbtJJxmASSn7ABmghBpSWW+2CpgPRDwnM4TzLtUOHP?=
 =?us-ascii?Q?A0jprKgtwBQ/KsQ69PD8lXWN3JWzq1j02JEyO1PBIT6esUeDxGVvCogMtVFW?=
 =?us-ascii?Q?KIXt372qX2Bp1fOQ0KPXkdmGZaYUK/acZfHPyWpi8ae/cm6G/LfYGTkG6Z2Q?=
 =?us-ascii?Q?J2A2gd9Jc49T7FqUXk2Fe6xw9zK0pXNv704u7r4lfXHDkaxsHOlecU0ciEsE?=
 =?us-ascii?Q?wIiYkOghw3C9WUpTwZ6ztAlfgCv43aLt/EefdmSp0YNB8PncLe2wiy3yHe6U?=
 =?us-ascii?Q?rePWWaosEXLZ1ZIK1yuTrs90c8fYY53q0pGGUYDM+024/hBC0g8qVt9+RhJ0?=
 =?us-ascii?Q?uHE0OH7Lhqc1reJ8cjMbtxa8Yt14Wd+pbSqvfeJ8gyGAJ5IednUMcG7AoqGS?=
 =?us-ascii?Q?q+/VpKrvsiIBuy0vD8T8FVc7SuF8m+lmySIp8bZdVLXlMrJjSkqB6kQJU/iT?=
 =?us-ascii?Q?k1YOZUYn/OSwd7wWWCoWbY+zDu13Nt3yCaaXPbXR5LCQFLYSBZqOykaSVxLX?=
 =?us-ascii?Q?+iATim1k7XVQNESL/AexfRafT+/+mtO1ZzkIBM0m9B30na/tcNp/d3Ai9z40?=
 =?us-ascii?Q?k1D2lTDg0Xb+Ek9qluwLeqwIKb/6oESELKpcPpT7ojWfoqZMDwiVeeBkKXas?=
 =?us-ascii?Q?J9tfYapzcC3Tc512zCJXclsFI8aUtjgZ24zJdx6UsDjfxFIhfY1RdLSbyKn2?=
 =?us-ascii?Q?D1Q15E+VC62dN5BSCZbgXrEeFVr5/wk+yVLhjPsD5QkczbND+O4RD4llB/K7?=
 =?us-ascii?Q?3JbcN9ZNcjrZEstLvrpGKgHhMm5LP7AmR9sz4AMc5LkUeGDppL1mOlvP2aBY?=
 =?us-ascii?Q?Y0V5e5DNPXkLUDCpfh9lXj538c+Z0raDuk4P9QQZ9i9GgY4CrBEFr+gn8yrL?=
 =?us-ascii?Q?W+f2mrDejouRT52ZeeyDkkJjb3hAnrKEZ7MSMq//kc/CId2QwCgwYHaPq6C2?=
 =?us-ascii?Q?aWmU0uwWjGEGLZp9YCIKBCcPUiWIxOYYd0WFqKDmx5YCFPz2+7qg3KhG8Ad5?=
 =?us-ascii?Q?srjzG+Miptjf54tceptbRR+C8Fr9TXrMDPObq+hqvwEmCjxjjhJa3NHWLCNe?=
 =?us-ascii?Q?FHn/dFFT3EseakFwkbBPUe6QZ7a5mouuihEwZCyZ0bWKp0vTtYwfj3JpCTcz?=
 =?us-ascii?Q?ecmHF9fPEOrGsx/KPSONohZULpIK6Kpyb/i1tYWCwgnVJs/4qNsIU2D5UdrZ?=
 =?us-ascii?Q?w3zSP8pFwv0LyI2CSS8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc3842f-19da-453f-fcc0-08de08994cad
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2025 07:39:24.2553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbHS9VHcnIddre6+Ts93CAFS2coKa3Pao1cD8MzS4Mo1jvhDrFmf1AGxMevBs/MCAFbOe+FcFqeLvDl7NxPpoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
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

Thanks Satish.

Reviewed-by: Jesse.Zhang <Jesse.zhang@amd.com>

> -----Original Message-----
> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
> Sent: Saturday, October 11, 2025 2:24 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Leo <Leo.Liu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
> Subject: [PATCH] drm/amdgpu: fix bit shift logic
>
> BIT_ULL(n) sets nth bit, remove explicit shift and set the position
>
> Fixes: e30383fce4cb ("drm/amdgpu: fix shift-out-of-bounds in
> amdgpu_debugfs_jpeg_sched_mask_set")
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index e7b4b768f7d2..91678621f1ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -370,7 +370,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_set(void
> *data, u64 val)
>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>               for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>                       ring =3D &adev->jpeg.inst[i].ring_dec[j];
> -                     if (val & (BIT_ULL(1) << ((i * adev->jpeg.num_jpeg_=
rings) +
> j)))
> +                     if (val & (BIT_ULL((i * adev->jpeg.num_jpeg_rings) =
+ j)))
>                               ring->sched.ready =3D true;
>                       else
>                               ring->sched.ready =3D false;
> --
> 2.48.1

