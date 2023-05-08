Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ADEC77B7C
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 02:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F1910E09F;
	Mon,  8 May 2023 02:15:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D4CF10E09F
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 02:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFZ046R+aIC69siFL98BhAen09dPYXpq2ujDCGm+EunITm97daVx0hcLJcGCqaPi4tiVsF1lujUoMn5/VRqEMxDk4b56zGPrI6JDCUFMD3qAAL9OU040FHuFQJUnuB7sUjq1aCHOjgMzTOthie4s6G0kMYitx3kyjD56ByX7BskU3Hh+xhuXwL0pW/bbh0/KiDcloSq9+yNJRMBpylcWgXtxF8ObzVqBVYWUdPW3UGFgrYNKv7oNZjIz2C5Yp4oeCqDdOAeAPzGE0lQvuALh5dAI/hsNpJa6Q1ZBW3/cgB0L0Xy+Ct58RIuPFs0HWKKTXUMu9XiaOvzUYuTNJfwnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOhS3NjKB0JXytcC+CGuX/Jpz8s4qUmcR+U0qFuUfwo=;
 b=f+ShzoxZgjvY4fvUb5u7yXz/qs3MwPBxGEqT8yhToe91qVnwSsWKYaEyKIQRa6GAq1FAyvolX27bbkuuNXMgTnAigzdtviDpujc+QDnwc1/sV5YFNeVJ61jKJ7dDZhOd4LbKfKb4Hdzw+r/wzhnL9Y1vI07+lcljHjV7Aoz9CC137fV4+JQ1/Qp5ZPXRrCZEiD9FBGOx2aZLduYo88YW0U29CdYSjh1AiAzsu8Edoz3CPKyyqpAEXCPy1Huoqc2EKqFDy9xqPBnoXPqKj5+cdz2vBxPQQ72MxU8hMBWq4RMmjmGCAgTU7YA7t58VwGQk8h7cdxp6X0u/nHhTAde4Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOhS3NjKB0JXytcC+CGuX/Jpz8s4qUmcR+U0qFuUfwo=;
 b=Uw6sacdCeTEx1fcND46oCEkgIrqvm6OOlP9jn4qcv4j/tpW/mJu5teFJWFXzN+sc/bWOVZpIO27ryUiQ3f5Z0efzZNSZRJcnpibHI1NHclKepU1dq55WqgryY6rGHUN8VpebPPn/oT8jioMoifm+4pyKtdTeIXVi1Hj9AwU8oH8=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 02:15:43 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::91e5:bbae:9e9f:7663]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::91e5:bbae:9e9f:7663%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 02:15:43 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gfx: disable cp_ecc_error_irq only when gfx
 ras is enabled in suspend
Thread-Topic: [PATCH] drm/amdgpu/gfx: disable cp_ecc_error_irq only when gfx
 ras is enabled in suspend
Thread-Index: AQHZgBSEtC4hBF9gxEuvfUPZby0nBa9PpcaA
Date: Mon, 8 May 2023 02:15:43 +0000
Message-ID: <DM5PR12MB17706A2DDE5E7EF810AD6E81B0719@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230506121543.1891418-1-guchun.chen@amd.com>
In-Reply-To: <20230506121543.1891418-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-08T02:15:40Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=966fe96e-4a39-4d44-87c6-0f221f7b5db3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-08T02:15:40Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b8034c65-dda6-4c10-91e2-9956782dde31
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|MW3PR12MB4393:EE_
x-ms-office365-filtering-correlation-id: f62eff87-7e2f-4b84-21c5-08db4f6a2071
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cbym10dwRnUxmrND8hFCkWSu83R2SCKB2OKVwUUomlQ+XejZa33xtwjiKjnjOcyavskqFRAQFUlXzg0qO9YMYDHCzZDxHfAhtDMDhNBF861PvX4A4RJM3Ifq9OxNEe6yYL6qoW5HpiQCNJPL/YUocs49Gb1o0g1mXDh1DbBpalDpu4+ONiaIqNE+cnphc0HHAE7ZiUu5rgmUFy6Nr6KKu0PD1qpyt4MO7BXayXgp7I6fozweoyYG9h29Tt60IhFjRMZNTkIBETwUjycYiOS6J9KVV0gBWmPHTiV2lwvowto242hzhDCT7nG3rJrnVyVaaiwhsF1m4hfcJgem/3tjBM8huG0wcTST6wQFaoHr0C+9KU0zQ75MXTq8UubnR7XgwF7eK6gSmVEY1LzQmAMn/0byXjXvTHZPh1x/P1AETvPFWQ8xu9k871e+Oanzdnk73xwK9CU4/JeLBgJptvaqG/d07xqvov40p6PR2r+Ah+S1fwtpAEm9GxkaxrEUSKQv3dU0LPMuHyaEmbqESw1hbCDjju2nZJi2Swj/9yDcLN3Jn/kplb2nmm6gPlUhmlOswC4RrePTu5yUc5Cb7v7omg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(26005)(6506007)(53546011)(9686003)(7696005)(966005)(83380400001)(55016003)(33656002)(122000001)(38100700002)(86362001)(38070700005)(921005)(186003)(15650500001)(110136005)(478600001)(2906002)(5660300002)(64756008)(66446008)(66476007)(66556008)(6636002)(316002)(8936002)(8676002)(41300700001)(66946007)(52536014)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lvRbE7UbCzcqcc2n7Z3/iCPLmLR2D9auHprAIpByfhmo/tyPCmbEjPSuL5kr?=
 =?us-ascii?Q?NzvuZ5tmh5/608uMNt1UsJPLnvR8d2uhgBdK3UoiA+sPTLlXGXX7ev7AXGNe?=
 =?us-ascii?Q?VQHn4FOcruSU7Y33rV1wB4nbla5aQWD58uTQTzsLUE9AY4DK93Nqh28Y1IQI?=
 =?us-ascii?Q?zR/4wmf5eoX8hkFf6erjH6c8bOcXIpc4ruJINzs+VGLH0Q6dNn5ZPdzwurV+?=
 =?us-ascii?Q?kVyfBsfBw9xJW93MXjxiNmoTRe91/WnkR/zvJrm0RdfMJm2RCcdTJVPtp16l?=
 =?us-ascii?Q?q0BV4jpEc7EBzW/GDry8oQlekDNzI9C3E5DdkgZ3Ky1g561SCKQKAMFNT61e?=
 =?us-ascii?Q?8tLofbmP88BjxB+XokADVP40d0kw4x6dj7dTxTmEXtM0csihsNCfWkSt0xxr?=
 =?us-ascii?Q?q/QxXb2FGM5wi4he/edYqmKzu4uPMy0tLTPKrEl/HpRxgA6QGRE9wLmDkk82?=
 =?us-ascii?Q?jfcty/ovUpU4bYSDFho8+rIgdY80VT1LNChxHPw5QDcaoGZ3BcCgE+JkVJU6?=
 =?us-ascii?Q?s5kOxO3ZRCA+Rr/pl/6yuFPvWhRmZ3dtgoRhLU2h/60H56GJA4sg5DPpSIDs?=
 =?us-ascii?Q?ymWu0ESF6ZjCL+pY1NzbOtZLwrUThiFZjafuy31jbUAOGxtI5/Llk6Np8Mn6?=
 =?us-ascii?Q?3bqzb7sosiEzSlf6kAkK8T0Gkauc6OEpbkL2etk105CNr7doHvf2o7qvO42g?=
 =?us-ascii?Q?JXBvGmZcLP/cFBWJrtX+qkE+JEY7mrsfAqt5G00/KXB/Z4KpbZUZKVObImNm?=
 =?us-ascii?Q?33eaIT3FSmB8zufc7R3F8DWQEGLsS/trm7gRbqAynuA3RzIcCCHFVNi4p7Y1?=
 =?us-ascii?Q?GCnn5N5V6imkRo0qJM/UAn2y0yV84+LWIAlN93lJbHAN6xM4OXgK686bD4Xa?=
 =?us-ascii?Q?KX7bD8D6F4htj2qdpQoINe2+gxlPm+0sOG2L3o5s4QgcdC0xRd0BevWnK0sF?=
 =?us-ascii?Q?MW4JUe3x0K5jbO4emp68vxOIqVyWZP5be1/OK8+gaQvb8OixfO8pLp6aEfjO?=
 =?us-ascii?Q?owNIkCGTSK8cGaOq5ZnLoAIVGz8DqTSOY9aK9sO3Ct0qi6Jg88WoTGlZCyfT?=
 =?us-ascii?Q?LZt5ZpHyIqIBXh2YKZxCOMwJs4y4FnbGWLd4UC10MtXjpmHU42FEvroAd95T?=
 =?us-ascii?Q?Qv55wpVxBwWATe55d9Z7U6a2w5fZP0tL1cafhndYjT327EiHKkOa7SU/nWxZ?=
 =?us-ascii?Q?FzFo20+uWFE5kINA89tdmMKe7ERtLlGAWcUSog5YEqURPHB3FSSdCTGyVp/9?=
 =?us-ascii?Q?lw7JxLJdPyknrAKxwWQLlEf0aZFjGuNRhUBd2id2AMnvqzjwo9/PjgVWe9/C?=
 =?us-ascii?Q?eUVFXTW8PV8QDNpDyoFovkVhovGG2HsS2DxEOX1CHjVP3K1Ro47XlcrSbqv5?=
 =?us-ascii?Q?3GYC5WXWqENg/JPpfAMShFV4J+vmv57h/v+nQAr2MOCSp91UofvhOWQCM8e/?=
 =?us-ascii?Q?ciQSuCuGs1vWMCdq7Z3iaZraK2rqQJAh6H2JWgxNJwVKZ4CB+hIda93R/eCP?=
 =?us-ascii?Q?0gGEB2aD0u9DgTzrxDDhGu2oWN8MFDSNVJfQMLmCpwZpnuXK01Yh0A9+LhyM?=
 =?us-ascii?Q?TeLErCH5LsTr7RE9Jwk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62eff87-7e2f-4b84-21c5-08db4f6a2071
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 02:15:43.2242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stWDUcSUPnk3JluQxrS52FkFM/Z9Ab761eSFO7D9s45GM/XD2WkbeaIFsNJOqD2T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Saturday, May 6, 2023 8:16 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Lazar, Lijo <Lijo.Lazar@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu/gfx: disable cp_ecc_error_irq only when gfx r=
as is
> enabled in suspend
>=20
> cp_ecc_error_irq is only enabled when gfx ras is assert.
> So in gfx_v9_0_hw_fini, interrupt disablement for cp_ecc_error_irq should=
 be
> executed under such condition, otherwise, an amdgpu_irq_put calltrace wil=
l
> occur.
>=20
> [ 7283.170322] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu] [ 7283.170964]
> RSP: 0018:ffff9a5fc3967d00 EFLAGS: 00010246 [ 7283.170967] RAX:
> ffff98d88afd3040 RBX: ffff98d89da20000 RCX: 0000000000000000
> [ 7283.170969] RDX: 0000000000000000 RSI: ffff98d89da2bef8 RDI:
> ffff98d89da20000 [ 7283.170971] RBP: ffff98d89da20000 R08:
> ffff98d89da2ca18 R09: 0000000000000006 [ 7283.170973] R10:
> ffffd5764243c008 R11: 0000000000000000 R12: 0000000000001050
> [ 7283.170975] R13: ffff98d89da38978 R14: ffffffff999ae15a R15:
> ffff98d880130105 [ 7283.170978] FS:  0000000000000000(0000)
> GS:ffff98d996f00000(0000) knlGS:0000000000000000 [ 7283.170981] CS:  0010
> DS: 0000 ES: 0000 CR0: 0000000080050033 [ 7283.170983] CR2:
> 00000000f7a9d178 CR3: 00000001c42ea000 CR4: 00000000003506e0
> [ 7283.170986] Call Trace:
> [ 7283.170988]  <TASK>
> [ 7283.170989]  gfx_v9_0_hw_fini+0x1c/0x6d0 [amdgpu] [ 7283.171655]
> amdgpu_device_ip_suspend_phase2+0x101/0x1a0 [amdgpu] [ 7283.172245]
> amdgpu_device_suspend+0x103/0x180 [amdgpu] [ 7283.172823]
> amdgpu_pmops_freeze+0x21/0x60 [amdgpu] [ 7283.173412]
> pci_pm_freeze+0x54/0xc0 [ 7283.173419]  ? __pfx_pci_pm_freeze+0x10/0x10
> [ 7283.173425]  dpm_run_callback+0x98/0x200 [ 7283.173430]
> __device_suspend+0x164/0x5f0
>=20
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-
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
