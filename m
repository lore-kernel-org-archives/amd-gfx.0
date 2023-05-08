Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25331C77B7C
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 02:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B6710E0BD;
	Mon,  8 May 2023 02:23:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA08410E0BD
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 02:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imL5VnZTPa905MoL2nYKeRfahYhAz8mbR0qSJrZgB+QJd6aypQaRR5Z9wk2UyWvsEL0FGVPsftqKJsqimczAhQJ7zGlsnZBSnQna/eSb4iaY45jRAIHCxFceI/eNRTUoMhUV3eGu5ovMTbhuB3b8rDkepEvG2SXNusHZLROa0k+OAhN00I7vjTcWnMUxCXpiJ8Z1G9Hird2uwRrTikS9Tpb6VcadO9k1cIiXoBYhzQuho0KfqPVJr92Cw9TwYMc6DM2YA152VafMzcJrLZ0hWV9cOVCPEE6TMILKMb2ZpvZVmkq/pGTssditTu1pR484naBujOplzapc2tvv0yEfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAfTE4SEqSwcYmNm25irdjedTmgm5XhC2b/KsBkFzDs=;
 b=cgfgHkp4GAANvgkrVrAhkeQ+qtxGeEMkUD9qyPb584wcgykaQrnVU558G5lqZxBFjMWmHSgBvzII6O9OgFa+2+fqgZyN04j+KdUtSXmnvMOIcOVOqwXMbtp6YLBNsKwGj5xvmxngThaR0l1iEQLIBxamfdhlf1/Sb2SYUSLS7nAcv85dhBqNLZNT9HW6EL8hBMNY04wS7jSrNkMBjkeIRr1bpp/m9dIIceO77q0rqE+95limeqwF5PGTCoR29V1sgz0x+yVU6NHtsZKnn+RUunwbobYklPZoYAkigr5UdqXpMOsNaFqm9LLke7dwDpVCaxjjGw6+UMNgHxzh13LH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAfTE4SEqSwcYmNm25irdjedTmgm5XhC2b/KsBkFzDs=;
 b=X4N+6AhPnHcLfP59hsBi82818SIUL5fmK4Ep1v4zveFwNoIPwBtlBkQn0sNR5TN0cX0OiHE7101/h63f2qmpHl7ZNx6/qY7AjMw1Olm3p7GKJbjmYGU+XMd2NJx/j51BtsR5vAiuxA+xFwp0qpJbANOeducYRwUeh4mOmWqDQXo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 02:23:03 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 02:23:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, Horatio"
 <Hongkun.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gfx: disable cp_ecc_error_irq only when gfx
 ras is enabled in suspend
Thread-Topic: [PATCH] drm/amdgpu/gfx: disable cp_ecc_error_irq only when gfx
 ras is enabled in suspend
Thread-Index: AQHZgBSEfnd2EqvuPkqAWsc9/sVrO69PpdKAgAABR2A=
Date: Mon, 8 May 2023 02:23:03 +0000
Message-ID: <BN9PR12MB5257FE4DAF4864FD5A06716DFC719@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230506121543.1891418-1-guchun.chen@amd.com>
 <DM5PR12MB17706A2DDE5E7EF810AD6E81B0719@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17706A2DDE5E7EF810AD6E81B0719@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Hongkun.Zhang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-08T02:22:59Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=966fe96e-4a39-4d44-87c6-0f221f7b5db3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB6342:EE_
x-ms-office365-filtering-correlation-id: 1e30d507-51d8-40ba-a236-08db4f6b26b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: poZdAIdcYlfUMAWylb4M8mxSXGmjd6eeaMIdW2BBczNnINoUmOCmKmEeykXTRiZotMx34hfFdrmuj5/aLjFHX+J9C7B9r++oPLuA8OlM4hG3eKERuNPqk7waxKF/ZD37vzYPC12lOKNYfLiJ42QM2YY+Zu3pyAe4/yrC8vBCSspFfwDJ167UlvuftR0XtB8UTJjnAbPZhcmGYT7fcW19dlQo82oTZIzC/0QC9vBHjeLdLtI1192OkpL3q6PiDLO0vAEZ4Hs2XdTvDbyE7fnlZPF5n1C8nsQECdbq7n2sdcId2ggSBHSKjtw4+EqmbBmbpGn/ejSmpvSIRZwZk1a+KxuWQ++iaBqDlGwAW7ylQJhLuhHtIIQfu4OJoEr26EsHB/Bcr8uMFwj2iB3ZsvSNEV19WXvmYzLZML8sqc/2yBwksC5clfOjYzb6sI48ijbk83pYRwmsGRGiANduEo723BRS2Tv+wvrhhd7w0HaHGaa4r9AaFGn6XpKR1cOLjlSZOuRXm9aOl3bwzOH9PeZ/FLS6c5y8z5Br5ZhlDahIcCzSqjJe+q3haqXMrQL+xkEELMf/UtuMst+4uInJP4kXqQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(86362001)(33656002)(110136005)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6636002)(966005)(7696005)(478600001)(71200400001)(55016003)(8676002)(8936002)(5660300002)(52536014)(2906002)(15650500001)(41300700001)(38070700005)(921005)(38100700002)(122000001)(186003)(53546011)(9686003)(6506007)(26005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RFQCdkmBZQgQxXoTTfrk8cmEtMCMlQ7Js1qTywv8t3g0wlElJizYEJGr9IhK?=
 =?us-ascii?Q?5U+eR7k1RgbDir9D4rvOWoEgMl1/R4ybxzfRx0h1yQ2/vOkHta71Kd2KIgrh?=
 =?us-ascii?Q?b7eDM9Ch8Hc1WDkWrCuErhkS2x2owjWCfMSl3lkFW7AviA+ZF/MEQP+dVIA5?=
 =?us-ascii?Q?KBP94aYirzEKMJmCiuwiP3kiAqMcNP1m5CRr0Cl8rkI4I7GGtRv/sHbjP+xx?=
 =?us-ascii?Q?fSG64/a2a3VhEPp5PzRBvjaIYuzaXxSfmn4MvIayVMTg5iGCxyvGrilmiQxP?=
 =?us-ascii?Q?Srv0raEe5Pn9oV84Da7qPvhw2AZLuIVTNK+bwKfFQh7CEYtipgJ1o4PUNhWc?=
 =?us-ascii?Q?fW+irs7sNFNZP/JF31KsjebOYovj2pjphK/JBC+LeSFP5U25Qxytdo09q/V7?=
 =?us-ascii?Q?7Ai4MX3MGgnfDEmK47YFDrxJz2PdT9+Uhsz1iCPR5uWApaJkcORMiOt93duh?=
 =?us-ascii?Q?NEJZ8JTtqayPF1Wvlccdx55Xqtx0C5tvyfVVqu/4vIhvvEIf19m32DtR80/b?=
 =?us-ascii?Q?usC6dg3Kg167BM1HD5uCzZmLvh4S3FFcIztceilK70vtWANBmcjIXhk6UiK8?=
 =?us-ascii?Q?wL3EpY2/9Azx79gCMqzs5YJYHvyx2U0FzsmFQ1f0z295fXGypvqeB4rQI9gu?=
 =?us-ascii?Q?/4CfQiyV04xcaBIxgI0ikaVurngIGudRA00sUlo7z20HeBmbRiMASMM2dWHs?=
 =?us-ascii?Q?JJjwCft3zy9ylLys9zlYhoLl5I6MvYg5WOqEutXGsMmTMA2EoyoULsLPoKCB?=
 =?us-ascii?Q?rBX2vuMp21vTPTtrU9dur5DgKP0epiyUH2b1gbU8/9ZDCuSpbO2OpihhTweC?=
 =?us-ascii?Q?q7fL41Dv+LAbq5+eP18DHcXV3EqtZPfrT4FQC4esVKfUwg4jz2l5tliZBtkH?=
 =?us-ascii?Q?TJaLSh4CXeEezPpCd5V+ZTaZwK4SlS/rYHcDL8tgViD6l7wlyzrJo+rf/Q/Z?=
 =?us-ascii?Q?Lb9+qbhjJIXKOUVRymNaS11nz86IS4FnNNIkq1W7yyJlGdtkg+Q7fsGA4o8i?=
 =?us-ascii?Q?w4CQH34ReeL4+GSiSUJ7FSLrnB+187y+RiD6OYzyoebaPkMCmxRwTTCs2Pjz?=
 =?us-ascii?Q?sCtQZ7DOAP/fbPU3DLWuILxZOtBbsQHCl9KBHcfVtn1ist9n3J/IvYVJlt3w?=
 =?us-ascii?Q?FPV1RvJNoHUf1b3Hk70QPqtnDWmxE0dvhXsXmw4EgKra4q+o6zne8syuaRPL?=
 =?us-ascii?Q?mljELtHboSwoSiRB+bVpRn+/vonUtGjDz8KcazApo4nbhBS25b2U8LeUa40O?=
 =?us-ascii?Q?V/UXwPlgo9uayIBVVYE4sLF1ixLY724ojIzaD2psKwoauzj8soaocp9tTW+i?=
 =?us-ascii?Q?XouMZBWIbw9Dho0mHhjKuk6I3vEgx5kzavEhMspTgV5hdJ/KYpXaWDWJIhNL?=
 =?us-ascii?Q?91nooKSM6DYUwxwMwZj0LTXS/GEH5VtAjnnFIQdlIYfoUNdadFPGPPloIbAT?=
 =?us-ascii?Q?DdDriaqdBJGvBFRukQcbIyWx3gWrDrQpWFAzQ9jS15t2TqmuxIYiAJ9rdjVo?=
 =?us-ascii?Q?GiIdZ/66+U8yNxYETBG0K8fjjIOGXMXfyz+s+t/NXUoyzYFDKCnZYjCUDBiG?=
 =?us-ascii?Q?fZi5XtX+wvVpojMFJvk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e30d507-51d8-40ba-a236-08db4f6b26b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 02:23:03.2676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6YEFz1O/cu5KN1gt1cZMpekI2LJ5tJyiZRkoybPf+Zwas4OApFTiBF/01HiGtWAVNqfc6PR+fRHDNFyXIoSCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
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

Add @Zhang, Horatio

Gfx11 should be addressed by Horatio's patch, not sure he committed yet. Th=
e solution is retiring cp_ecc_irq funcs since gfx11 doesn't rely on the irq=
 for any software ras feature.

Gfx9 could still add RAS block check since we have legacy ras feature that =
needs the interrupt.

Hi Horatio,=20

Did you commit your fix yet?

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, May 8, 2023 10:16
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deuc=
her, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@a=
md.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koe=
nig@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gfx: disable cp_ecc_error_irq only when gfx=
 ras is enabled in suspend

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Saturday, May 6, 2023 8:16 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander=20
> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=20
> Lazar, Lijo <Lijo.Lazar@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=20
> Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu/gfx: disable cp_ecc_error_irq only when=20
> gfx ras is enabled in suspend
>=20
> cp_ecc_error_irq is only enabled when gfx ras is assert.
> So in gfx_v9_0_hw_fini, interrupt disablement for cp_ecc_error_irq=20
> should be executed under such condition, otherwise, an amdgpu_irq_put=20
> calltrace will occur.
>=20
> [ 7283.170322] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu] [=20
> 7283.170964]
> RSP: 0018:ffff9a5fc3967d00 EFLAGS: 00010246 [ 7283.170967] RAX:
> ffff98d88afd3040 RBX: ffff98d89da20000 RCX: 0000000000000000 [=20
> 7283.170969] RDX: 0000000000000000 RSI: ffff98d89da2bef8 RDI:
> ffff98d89da20000 [ 7283.170971] RBP: ffff98d89da20000 R08:
> ffff98d89da2ca18 R09: 0000000000000006 [ 7283.170973] R10:
> ffffd5764243c008 R11: 0000000000000000 R12: 0000000000001050 [=20
> 7283.170975] R13: ffff98d89da38978 R14: ffffffff999ae15a R15:
> ffff98d880130105 [ 7283.170978] FS:  0000000000000000(0000)
> GS:ffff98d996f00000(0000) knlGS:0000000000000000 [ 7283.170981] CS: =20
> 0010
> DS: 0000 ES: 0000 CR0: 0000000080050033 [ 7283.170983] CR2:
> 00000000f7a9d178 CR3: 00000001c42ea000 CR4: 00000000003506e0 [=20
> 7283.170986] Call Trace:
> [ 7283.170988]  <TASK>
> [ 7283.170989]  gfx_v9_0_hw_fini+0x1c/0x6d0 [amdgpu] [ 7283.171655]
> amdgpu_device_ip_suspend_phase2+0x101/0x1a0 [amdgpu] [ 7283.172245]
> amdgpu_device_suspend+0x103/0x180 [amdgpu] [ 7283.172823]
> amdgpu_pmops_freeze+0x21/0x60 [amdgpu] [ 7283.173412]
> pci_pm_freeze+0x54/0xc0 [ 7283.173419]  ?=20
> __pfx_pci_pm_freeze+0x10/0x10 [ 7283.173425] =20
> dpm_run_callback+0x98/0x200 [ 7283.173430]
> __device_suspend+0x164/0x5f0
>=20
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-=20
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index ecf8ceb53311..f6bc62a94099 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4442,7 +4442,8 @@ static int gfx_v11_0_hw_fini(void *handle)
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>  	int r;
>=20
> -	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
> +	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> +		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index ae09fc1cfe6b..c54d05bdc2d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3751,7 +3751,8 @@ static int gfx_v9_0_hw_fini(void *handle)  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
> -	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
> +	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> +		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>=20
> --
> 2.25.1
