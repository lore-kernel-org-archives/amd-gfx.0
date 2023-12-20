Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91FCC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 13:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CDF310E56E;
	Wed, 20 Dec 2023 13:14:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED1E10E56E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 13:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLxqYpM4GX85n7ubQqmKP5xLzzIdXMNBeNZjdJNBIIYFlVfI0Y4h8a0axqGQUIjt6buMWKixLdd4GXJD7tI4mbaZbV68wmUcxkZQQhjBDAleJEOsr50Y4I8/c+FOX4jnQC1exUoSVmK/Bo3FqpVXFDWx/mz0C7Wz1ZaCDFarHZRg/CvI4nV+CSvuKZCxa3PDCeBOzYNFggGe98ZkvHUQplGV1dunHurbHT+P4yeocfOs/UTWMzPKf576EPLWt/xMfe6ILgk9v5KaYGUm36urfzVjbZJTEdoz4ohnenLdlq9vKThcdn48tQ1eRz1iIv92m7jr8fJwKcvzrWj/1H9+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sch7YceMsgKXqm4Dk7LfJiW1aXakvGqhpIKX3FEYCTM=;
 b=Nl0BDnIxPf4XnTFSYcf22MuXulA7s3SA1DaVdEJjGRr716KlHYoxcXqaGSN/bYQREfloqvjFHO7Pob3RbdyfMzQ/Z1n+IXF1/r2KxKm1GuQ+BbTrTS1ZmnPuhoelG03BINS3BvJcCXA+XhLyEkwd4DO5SqyVKuDynF8VgZdKb/5g5iLx9bOsnCCizbRCIkAWJsg5dDYTU5NvVFm03SZvM+k+/wogSrnMDbYg+FNUCQwdJOoiYm9Zh33W+8xz4gFrgBfHHyLNHDTkIDzOOoXCrPsPHL2E6o3rNQr2vxasHwTE1PGwom6I/jTgyVDmmWRRbzG3doTz19UkBe3DtZnxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sch7YceMsgKXqm4Dk7LfJiW1aXakvGqhpIKX3FEYCTM=;
 b=awxL4U2t+7JvryealyBhQlsQ0ppZzjsb7pJUxmz3BqeXvrQs6WUNYkHCk70nxi0CtIPIBd7iRaZYo5MPzuYqVDtp9YG9DFJO+7I6y4uiL0yJuORyqID2odpFSrFEk0p2bDPXgJP6+YSEB9dPqJfyPmZfGKORuKInimy93JdinAM=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 13:14:49 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::7092:c19b:bd71:3b0c]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::7092:c19b:bd71:3b0c%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 13:14:49 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review V2 1/1] drm/amdgpu: Fix ecc irq enable/disable
 unpaired
Thread-Topic: [PATCH Review V2 1/1] drm/amdgpu: Fix ecc irq enable/disable
 unpaired
Thread-Index: AQHaMnmYQ49ryfdiTka7C8372wkg3bCx04GAgABUYHA=
Date: Wed, 20 Dec 2023 13:14:49 +0000
Message-ID: <PH7PR12MB7988F5DD49C701A1067202549A96A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231219124738.503604-1-Stanley.Yang@amd.com>
 <BN9PR12MB5257B7C02B9FA11BA3750ECCFC96A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257B7C02B9FA11BA3750ECCFC96A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=30653e98-5cbb-49d6-95c2-4013bec9e363;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-20T08:06:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|SJ0PR12MB6903:EE_
x-ms-office365-filtering-correlation-id: 00fa259a-69b0-4b35-fc25-08dc015da4f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QWnYcLVRUR+F/pSRcmTH7Qjs2QCbrdsFimYz6uZJMDxF/3bkwTit8uWNWJpw25PhzBoTDVwN2t/BhIVkkOuKDlLtPXOsWUBXMCr+DK2rt7dVvimR2a6iInIEryyvsSvMhnnEHdw+NWlZxuCvqtGHA5hE2i9t6o7tSfu1/c42bsgy8BPRVdvG09crgP4cUfcG1CreVmgO6WlV9oVz2fNAabSOD7R0zOUubbNW+bQHR+Ko5vBF7zzl1i8hp08UuOmBFiicZzqKiL3KMGH6pR1jOVURK7L9HwXeFTzHNGiVLLu0iTX6CYlDMtAEBjPvcDnH+F5qPnPEqCl9gd8pJ7bjSw34O5Wd+2pNLFIRmOYVoIB50ZuinFcA4iN2WgYZGQ9GllIAJoCu69Y5CtzC231UeAp97w1HLL6tc9vuUKBRQ5aGHMTHTWqMrml+yNNh7TNS8/sTpBZo8mU38qFny98M5aPZzb1v/3tY7sYaV3HoGskRULA+NX14CN8G1XUiSLxO915TzPvtMgANgpriWGYMRLnxcj5Qs4MZ+hQ+L+YHLNNkHrrgBMxXD5Qc4ugNXuUAw2zNmcFxY6kEmkLOHkj7drplJ3utrx1KBsky3no5Zcr/bXAVJWMaE4BfT6PcMxCU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(55016003)(7696005)(122000001)(9686003)(53546011)(26005)(71200400001)(6506007)(83380400001)(38100700002)(33656002)(38070700009)(2906002)(86362001)(478600001)(41300700001)(8936002)(110136005)(8676002)(5660300002)(66556008)(76116006)(52536014)(66476007)(66446008)(64756008)(66946007)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qFk+4OF1V6PtwAOn4cwXdlXeVh2D60dIohvl98v+mZWnY1g+egiPrjJdS88a?=
 =?us-ascii?Q?0jn0VzGk3ugx0pcf04aZZ7y852KEELU/qUGBcJSJ/KTHNBEQAlKJyF9S5k4C?=
 =?us-ascii?Q?bRYT8WhUyODtrLScc8mCqYg8vrAnga92+PR5O1/uaBu98GawO6YFR3SmdR8q?=
 =?us-ascii?Q?shVFbzGMHcCEUd/+87GZ3jebbxGqSleHG98wff+QlQ6Y3+3IO0p/gGvAcDEg?=
 =?us-ascii?Q?GO31Xiqdmbz4QUvXWpYU66ZGnckg2J9a1JYMyZwM1dfH3xG08n9Oub6aRqsW?=
 =?us-ascii?Q?si8UaPZcedzUiYyuyAgkNK2jQBapY44HTArjhatDpn0Ck9WOcjGyVL2KTnmT?=
 =?us-ascii?Q?vbhP42UpMEu1bB1lPRCI3oDxXVF9mKMPLdNjERilm9IIZva5nPBXJoOz0EpH?=
 =?us-ascii?Q?HxST2r2zKKqrviq5o1RcvfpTsPJiHyu1Ac6+nny79Ax8sLkkBaYxOGATEh78?=
 =?us-ascii?Q?tNSRLTI9FQYRwZvCRTlM/HQh4tFyVsNYL+jmNkpYICN5Txlaor3iwnkOP3ac?=
 =?us-ascii?Q?bR4VeE9cv7IlJQ8HZ+I03mTWmLRZgWbUTWXoUVybmJnJaQaU5dntExhzdgYl?=
 =?us-ascii?Q?E61Q5IIasfsr4ujIaeS97P6CoQ4OcP5YdL2HAWO75xVx6eZ+FRMAVDmyq+Si?=
 =?us-ascii?Q?Jgw96xcZVfktCOeYsWmFoS1gvYxYbdnFbMYTHUWKBtNFqR/HhJDvJWk5d9d+?=
 =?us-ascii?Q?fx0WF5H38oAXinInWDFfiS5gWMTHQALhpcSG+WDmgEGYrvRe648PKXavnqsc?=
 =?us-ascii?Q?KOxZp6JO7LuQCR7T1f4wbIDcBuS9G83xBPX3cAqifnRe/rOjHaR/cRO1zX0I?=
 =?us-ascii?Q?rNyZZgsiZ5f7EJUY4/IufLNq2doZsSHEnSM0vn+SKomx+dN3OWBD5b74mgnR?=
 =?us-ascii?Q?ZTc3j6PLKtLd51Gu9GN8fKUIh0fhVEzSczmXXc8igcsradpxbE/mQ7q/xJXG?=
 =?us-ascii?Q?UWhL6TiItDR37mIqnAKl1nl7/V4sNFP8LTXYY9whYKXzvG6Sidj/QSVv/Ikq?=
 =?us-ascii?Q?U/lKVE3nuqEQVve0RPrdDxhMselvXiB0jJOGSiQtu31MMR65BJTE8Lyu8SXg?=
 =?us-ascii?Q?W9bnuVbyVBOFciB4s1Jy21eRwK2EFOtbQPEExhyJJU0LPk5AVLoz7nl8sNJ1?=
 =?us-ascii?Q?ODqh2bJhJAag9rKXA7oZ6/ngz61GfrwnKAo+IlTwnoomFdOzEAO5IKkZDFa2?=
 =?us-ascii?Q?50BukfYtT3oce1jcCb+k9YIhvfNjna3jE/IS9OsPSnVaxccNwfUdK4NCG3Nq?=
 =?us-ascii?Q?P7CB83Qq933S1EY1WhB+hbXyZ6ypgA/oKhppP1HXp3PMPmblgLCpt2cY7IIf?=
 =?us-ascii?Q?54hMnJBDWqITY8dQU91sGiO9rMxQRzAy8GLlzg0HSL0bF53PziEsjgSCZ9zL?=
 =?us-ascii?Q?PIM1InVvxAi6vmhzQfxEn/wxs8/MxNCh2uA2cHbl4AmvCbI2N5WctVSiWtFa?=
 =?us-ascii?Q?BOiduugLbd5LjtAz/uBNyPtwXx7o+y+YO9ohib3eoaoKnkWTQD3dgbLvIqul?=
 =?us-ascii?Q?DdVnR2Kp/UNTNbTMsf1xvXgGxmIVVbn2BqDsh9suP/pwI2J1ZoqCNuFOrhD6?=
 =?us-ascii?Q?exTcafxCx/K8SoypTME=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fa259a-69b0-4b35-fc25-08dc015da4f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 13:14:49.0885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ngg856RkkheQMVf621aXDqjA4BFBF3FeCHfNCUQ7ShP73WPFRne1o0nksYg8ipwvP0Jd9HZV51TTYvpipSM3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
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

Yes, it should add check ras cap before put gmc.ecc_irq, thanks.

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Wednesday, December 20, 2023 4:12 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH Review V2 1/1] drm/amdgpu: Fix ecc irq enable/disable
> unpaired
>
> [AMD Official Use Only - General]
>
> +       if (adev->gmc.ecc_irq.funcs)
> +               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>
> This doesn't match with amdgpu_irq_get call for gmc.ecc_irq, where driver
> checks ras cap to decide whether enabling the interrupt or not (see
> amdgpu_umc_ras_late_init). We do the same check for amdgpu_irq_put call.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Tuesday, December 19, 2023 20:48
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review V2 1/1] drm/amdgpu: Fix ecc irq enable/disable
> unpaired
>
> The ecc_irq is disabled while GPU mode2 reset suspending process, but not
> be enabled during GPU mode2 reset resume process.
>
> Changed from V1:
>         only do sdma/gfx ras_late_init in aldebaran_mode2_restore_ip,
>         delete amdgpu_ras_late_resume function.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c | 28
> +++++++++++++++++++++++++-  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> |  3 +++  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  4 ++++
> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  3 +++
>  4 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index 02f4c6f9d4f6..b60a3c1bd0f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -330,6 +330,7 @@ aldebaran_mode2_restore_hwcontext(struct
> amdgpu_reset_control *reset_ctl,  {
>         struct list_head *reset_device_list =3D reset_context->reset_devi=
ce_list;
>         struct amdgpu_device *tmp_adev =3D NULL;
> +       struct amdgpu_ras *con;
>         int r;
>
>         if (reset_device_list =3D=3D NULL)
> @@ -355,7 +356,32 @@ aldebaran_mode2_restore_hwcontext(struct
> amdgpu_reset_control *reset_ctl,
>                  */
>                 amdgpu_register_gpu_instance(tmp_adev);
>
> -               /* Resume RAS */
> +               /* Resume RAS, ecc_irq */
> +               con =3D amdgpu_ras_get_context(tmp_adev);
> +               if (!amdgpu_sriov_vf(tmp_adev) && con) {
> +                       if (tmp_adev->sdma.ras &&
> +                               amdgpu_ras_is_supported(tmp_adev,
> AMDGPU_RAS_BLOCK__SDMA) &&
> +                               tmp_adev->sdma.ras->ras_block.ras_late_in=
it) {
> +                               r =3D tmp_adev->sdma.ras-
> >ras_block.ras_late_init(tmp_adev,
> +                                               &tmp_adev->sdma.ras->ras_=
block.ras_comm);
> +                               if (r) {
> +                                       dev_err(tmp_adev->dev, "SDMA fail=
ed to execute
> ras_late_init! ret:%d\n", r);
> +                                       goto end;
> +                               }
> +                       }
> +
> +                       if (tmp_adev->gfx.ras &&
> +                               amdgpu_ras_is_supported(tmp_adev,
> AMDGPU_RAS_BLOCK__GFX) &&
> +                               tmp_adev->gfx.ras->ras_block.ras_late_ini=
t) {
> +                               r =3D tmp_adev->gfx.ras->ras_block.ras_la=
te_init(tmp_adev,
> +                                               &tmp_adev->gfx.ras->ras_b=
lock.ras_comm);
> +                               if (r) {
> +                                       dev_err(tmp_adev->dev, "GFX faile=
d to execute
> ras_late_init! ret:%d\n", r);
> +                                       goto end;
> +                               }
> +                       }
> +               }
> +
>                 amdgpu_ras_resume(tmp_adev);
>
>                 /* Update PSP FW topology after reset */ diff --git
> a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 09cbca596bb5..b93a0baeb2d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1043,6 +1043,9 @@ static int gmc_v10_0_hw_fini(void *handle)
>
>         amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>
> +       if (adev->gmc.ecc_irq.funcs)
> +               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 416f3e4f0438..e633e60850b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -941,6 +941,10 @@ static int gmc_v11_0_hw_fini(void *handle)
>         }
>
>         amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> +
> +       if (adev->gmc.ecc_irq.funcs)
> +               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>         gmc_v11_0_gart_disable(adev);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 205db28a9803..8ac4d5b7fb37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2388,6 +2388,9 @@ static int gmc_v9_0_hw_fini(void *handle)
>
>         amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>
> +       if (adev->gmc.ecc_irq.funcs)
> +               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>         return 0;
>  }
>
> --
> 2.25.1
>

