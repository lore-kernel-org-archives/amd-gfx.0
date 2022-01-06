Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF34EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 15:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73ADA10FEA1;
	Thu,  6 Jan 2022 15:30:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3334810FEA1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 15:30:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAJ10yOE22QqkjPKF0uQlHDirKR8XabFbNPLTW6YztMKe8d58/SdzplNdH1YR7qWiZ0kxX1U2zZnzgTYYQGACXJh9fEYfKemLFj3jCmuvCMfapRK9WD/sc3lMPiPxE1aKl/HjvUKq3oWKK+MRoPlFfRieAqJyDuTKMcS+FfdOuS+1735lgNJSJlNFZM4NTM9pIF8NoZfjev08Q/+kTjqhIm82WuLEBTZvumnuZs4Z77eSmbm39XVHdKl8WvpugSx7bdzv2iHx4JudVW07uaiD2s9FGNJd9M0arA6diZPd6eg/Frhj35HQy+kMtO2Qs1zgp6WgQIirLBOkQ3fFhiS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+AxcQzlwosU+jjwasnnuMUwMcdE5R/JOPhQhe5SmZs=;
 b=RNqkeZTceLhWT3LSBBEYtqMxboJiRO7OtZUPNbaKP4uS1kS84mm1gjTZaczBvq6EYuI7o0ac1/eMkjUUm+7Qm+ReTsSTxYehbh9ZeJSYkmT1pu4tvjDGTpcE6se9qIJhqRDdho6kO3rgHdm1kegSiEp8oHcReeYJC1BDO5SDK+9EMzRPhBDqlw+btwOhFrBbDxpzfa+LZRHP4leg8mis2kKG3nwLaUdiz1VM8PaMmrD9OViuv9R0cPRsoMO4TmcCrPTktP4jbLZmQzapRE1rlXD4k6R6Jf5bQ7dxglIw8Td5CC7fEDF1Gqci/Ie2txMc9CoatXB3pQ5D7aHpYI0Mew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+AxcQzlwosU+jjwasnnuMUwMcdE5R/JOPhQhe5SmZs=;
 b=hzdK8vUKAezvLhGCMRxXFaQnaxGjSOe5DlucUZVf+rdGuZqGD1nLi3ttWKDfDLFnjKNTTlmoQZL3MOHEkXztNBXkimrz5X9N2n+ZJCDP20TOyymMoPzsojbw+B9N4AqzQWM0kvrNM+4vojYbcVknZxFW5qIV/h2kl1FQb2ddHno=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 15:30:43 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%4]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 15:30:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Lee, Becle" <Becle.Lee@amd.com>,
 "Huang, Rex" <Rex.Huang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use correct VIEWPORT_DIMENSION for DCN2
Thread-Topic: [PATCH] drm/amdgpu: Use correct VIEWPORT_DIMENSION for DCN2
Thread-Index: AQHYAnRMeshOYlewL06UbWiIMmg0R6xWH2Hg
Date: Thu, 6 Jan 2022 15:30:43 +0000
Message-ID: <BL1PR12MB51446FCF05C6914E1965D128F74C9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220105203901.52175-1-harry.wentland@amd.com>
In-Reply-To: <20220105203901.52175-1-harry.wentland@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-06T15:29:33Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7f75df74-5f90-4d09-a8c0-662df92d4aa8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-06T15:30:39Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c9dfbc46-46d8-41dc-addd-f7f89e6801df
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0a6bef8-067b-4a03-7dc2-08d9d12980c8
x-ms-traffictypediagnostic: BL1PR12MB5157:EE_
x-microsoft-antispam-prvs: <BL1PR12MB51572D12903862314F732B53F74C9@BL1PR12MB5157.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EwUvXr9TH4yo5P8pvLuHOytCY3z9Sb7RXO8O4Qh+IuM1bNa1IJJ6W/5VHfBOhZS0NUd1oETXP/ZCf+NADUGVHunoul9lhNiYaSS6rSxvA0223LeXGKoExJ6LZjV8eb9uMZG51uNxQSUyA5e+9VZOMAotpxwRJrDh/ndpczDzdkYWFS6Np0IKjkDO2sd1MaQJAraV+DA31Iv+0bFLEXB+GuypdDCHyBWvfjaj/dgm/M1xeHE/SY/CDf3MALCv7GsDquyEL+Yq1Q7RtDlIvbMNkMYrvst+2PEhrG2dw5AzqPxx5a5vbnZnTAN7YJ/G2ruMj8RTdFEZK3Kem/2tkS//PgxcaAWSNsVZZiS04p4qwTCSTuPp72a1zwX3ssImh2A2Ob74g76BiTTvCZFQDXlY0MjN1YFh9chucYHOyYTA18c1W+C06w7zAlAYLCzEpbo7Su6en4LM5ccyPYjClLqPukl0MeLj3AG6AX9SDMcb+QdO+2uGv4fMrzYuA1wAwIjPqR7eGY5DRtDz4zN66o7W/OjGvqMK9YljeKdkyxRPtwm/yzQtI3p8GOsaVW9BgyBqLNrrmqOJM+A45BYZAktCNF3g2EFSl8Ff72TMVqqryEh2jTutyPGh9H5qNLSiPe5swkgQQ9V3x4wq+cp4acjZRMNs9HxZlsfnvyfk7Bzw+DWIJI+mYauVQ58k2bxxhTU/n0X7QJEwvOSES9MYlEIa8/saycHooioLkiCwwoEZx9M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(76116006)(38100700002)(5660300002)(64756008)(66476007)(66946007)(66446008)(55016003)(122000001)(52536014)(186003)(38070700005)(66556008)(8936002)(2906002)(8676002)(4326008)(83380400001)(921005)(110136005)(6506007)(53546011)(33656002)(26005)(9686003)(71200400001)(6636002)(86362001)(316002)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gYav0/El9PpQekv1sq/8n+DcQXNrjmQLBBnY8YNsRGoC7k6UZBAFIgF3EFEF?=
 =?us-ascii?Q?qu4CfQ9OJOAHsklFHSM4J0XHXGv1s1MfhqY8t0LeQxMIjpr2kD0x3nYJdl4z?=
 =?us-ascii?Q?e2luR0Az0iz3lJ+fIaiHAdeDD2aaTftsiCSFB6ccDH3IxpiSlEfH47/XYkmG?=
 =?us-ascii?Q?dtq0Vwm5hIV7oFcf85wVaEYvdihaVK11OMNwYYY3cR94H8TBmjFdPbYOYHMt?=
 =?us-ascii?Q?yFADP555D0E69O4zGGNR17KNda+VRxhTBkwuVEcYxzEbd0ET24I/Tcsbbh3M?=
 =?us-ascii?Q?eOcoqKJPkCuedT6YXazdf9QlF1eL+sGcmFUgzDbXYf7HGTReAoxin7H6fwTx?=
 =?us-ascii?Q?XqaUc9ks2+qOm5Y+UUiRGLqGxHcSJkAt5rpSYWelIpveOPAFcOIG+Q0JlqRZ?=
 =?us-ascii?Q?Hko5SXQET6Pvg5L/nyA0hwBVDp5YpPtXUYyw2NAaF8R7RRZx9nIxFVG9g9Zt?=
 =?us-ascii?Q?61fiV2Oub6QGT0UIZDbwA/3PgXzipDMz+Mr/C/28nx5rh3Lbr2Tu/Yl5+qTX?=
 =?us-ascii?Q?hs09DHQNqcM/ykWxaPrKQrBpRz3zII8kQ8qy8GJiFMdlqXEtv17bRjLJQba8?=
 =?us-ascii?Q?Ev3QjE3zev9vq7mlP8c0rnUSoaDNxgcMuxzBaH7aMiYFzOrUYDKEPlPEmsbV?=
 =?us-ascii?Q?NBY3gVrAxCqTArTuWNXUNzB3RwbZewt7Cr1dfmPinBDvaXPBO0hkyJns7g80?=
 =?us-ascii?Q?ozu5qEpwJ/gmsEUG7InX+H71emd6EO4jBuMi9/bM5fYjLK6b5AHeAt5po71s?=
 =?us-ascii?Q?s1L4ILbcWsv/g8Fb+Z4mYVV19eg7arMgxEw1VpyMbYGqdaiIzX8gZW1V3osX?=
 =?us-ascii?Q?606zwCT1lAoHaE2Hg7XUu+0zI+PHJshE2e/3AxADqQWaAsgVhjNTOOlbLTzz?=
 =?us-ascii?Q?POwFRjSm8zwPpJWKeJrj2sxjLIi+t1bdJMTcNBWg2XBaARxKI6lxcV5ulbC+?=
 =?us-ascii?Q?XDMuM+kXT/gpkMUeOS8FWOa9tHh7DcBEyMWEfbde7m33i9d48v0V4FOdhzCu?=
 =?us-ascii?Q?73s99msQePFGJkS63JPc6C7J3L/hKra4FXxRzh+CmKOkhwt81eVFRiuXMrvl?=
 =?us-ascii?Q?FPTsyKoxjYuQ2uIdfI3G+4phNBQwCOgJkJTfn7crmzMvJeUAWxAnyli2+S4F?=
 =?us-ascii?Q?KGRajrigg0vRHnvGP404iULqFMFKcax7EknsOa6k8eR/MA4lTAFo4RuD4tj3?=
 =?us-ascii?Q?iSZsk7L5Wqhc8ReXBTgLWFO+b3zIda4gLo5V+StXT0UBSR6oyRl48bgLqAXT?=
 =?us-ascii?Q?2zVyuY3gmS091d9hNUXAjXRPQvFF+HL8lEMVvQUXRj1V75I1efF2JMdVt9Jq?=
 =?us-ascii?Q?dOylCg/xjE2OsCEh40yqjCPP3NtKegjQdD+0m0+7JqRhFxFlOC9YRvF1Zmaw?=
 =?us-ascii?Q?b1vdqXOJn9oIvuSWdk1He8kT/I2DAhjUoE+pk0bSGwgwvlaOHQGzurt9/jn8?=
 =?us-ascii?Q?QOQJtXG7s6wzqx1UxyNj+n02Qf/O86pZYgl4cD62IztcaX9o2cxWylBga3NM?=
 =?us-ascii?Q?Fjtz4maJtka4bn8+D9IfqOykErmKI/A60H0yVY+2VD7Hp+fQ8elE5Ge5Zwu1?=
 =?us-ascii?Q?FW+J6XxhdgFqJB6Q46Vc3hdUqnqSwQrps8gnzgutjaeZWWCiE+hauq1VYKz6?=
 =?us-ascii?Q?pQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a6bef8-067b-4a03-7dc2-08d9d12980c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 15:30:43.3342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMv3+jjM9aZTC5hbEy3gw3nLL4M56Y/aoMj/lK3FD7pXLcXUbg80jsz1bkl29kT37HXiT5demBB3ZvkzDAYgwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Harry Wentland
> Sent: Wednesday, January 5, 2022 3:39 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Lee, Becle <Becle.Lee@amd.com>; Huang,
> Rex <Rex.Huang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Cc: Wentland, Harry <Harry.Wentland@amd.com>
> Subject: [PATCH] drm/amdgpu: Use correct VIEWPORT_DIMENSION for
> DCN2
>=20
> For some reason this file isn't using the appropriate register headers fo=
r DCN
> headers, which means that on DCN2 we're getting the
> VIEWPORT_DIMENSION offset wrong.
>=20
> This means that we're not correctly carving out the framebuffer memory
> correctly for a framebuffer allocated by EFI and therefore see corruption
> when loading amdgpu before the display driver takes over control of the
> framebuffer scanout.
>=20
> Fix this by checking the DCE_HWIP and picking the correct offset accordin=
gly.
>=20
> Long-term we should expose this info from DC as GMC shouldn't need to
> know about DCN registers.
>=20
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 57f2729a7bd0..8367ecf61af1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -72,6 +72,9 @@
>  #define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0
> 0x049d
>  #define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0_BASE_IDX
> 2
>=20
> +#define DCN2_mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION
> 0x05ea
> +#define
> DCN2_mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX
> 2
> +

We normally append the _DCN2 to the end in these cases of the macro.  With =
that fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>=20
>  static const char *gfxhub_client_ids[] =3D {
>  	"CB",
> @@ -1142,7 +1145,6 @@ static unsigned
> gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
>  		switch (adev->ip_versions[DCE_HWIP][0]) {
>  		case IP_VERSION(1, 0, 0):
>  		case IP_VERSION(1, 0, 1):
> -		case IP_VERSION(2, 1, 0):
>  			viewport =3D RREG32_SOC15(DCE, 0,
> mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
>  			size =3D (REG_GET_FIELD(viewport,
>=20
> HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
> @@ -1150,6 +1152,14 @@ static unsigned
> gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
>=20
> HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_WIDTH) *
>  				4);
>  			break;
> +		case IP_VERSION(2, 1, 0):
> +			viewport =3D RREG32_SOC15(DCE, 0,
> DCN2_mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
> +			size =3D (REG_GET_FIELD(viewport,
> +
> HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
> +				REG_GET_FIELD(viewport,
> +
> HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_WIDTH) *
> +				4);
> +			break;
>  		default:
>  			viewport =3D RREG32_SOC15(DCE, 0,
> mmSCL0_VIEWPORT_SIZE);
>  			size =3D (REG_GET_FIELD(viewport,
> SCL0_VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
> --
> 2.34.1
