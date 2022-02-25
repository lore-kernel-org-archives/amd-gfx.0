Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1CFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 06:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B3710E2FC;
	Fri, 25 Feb 2022 06:49:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE8410E2F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 06:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFojVjSmwXSjSluTxOXB2JmNzhUMcKAHqu2RuUf0Pov6d8k5z15phHNHYsfBRaLWxOoj0AliNH+5CF7Q3c+l3zDJRTqiSqBmjl7KqF020abmWdBM+FsxpRUe7gQ5cU+kA38OoNZGNgj0/QckZ6FQ9y3gRxSRgaq4mazhvqcZpiMr76odGcsVG8izO84VsTm1MUPpw/uqiUg7x6T+F97cwzjLNzjZRm7bxLlNKKeltaA7Qt0ODoiG8WuV4JaArvi8s4NjGfZUqiJGDTrfbcSEOmnr5rd3tCl1MCNJ8QZZuJTm7t8s+jccnl/L84voruoanoxzvVK6kB/9P+C7B7UPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xsa7o0ctjYoIBD65Z1ixIUvNTAjFy2w12qV6OCe19g=;
 b=aTJsdBG6PsKxfLvs6wPqy4oc5ls1VT56dXV35Sebx73Uu71S5dow3rQ+xfsBkyOm54TmamVMyCbivY4a1soYd20mvZ5GRYQHsqhwbvdrYssq0hTr6iz1DM8vkxGUX2ue+8OClVfS2CH24DpbqDwFGKLGouejzrXDe95r2MrU8xiJSrAHAY43Wirp6Glb/9mjuEdhrYEuZvTpYoK0+gLitwv5USCPXL3mwNv+57Jzlfx4NgeF8mxW6h9+HvlFxUO7i4NSQT1vbDcFhDSd3lMIHdeTAEImaGnY4uyNGYCD8LUcOo8/7h6PkFmIr7jQE32zAQBtGcsPD+80oSDgOt+hTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xsa7o0ctjYoIBD65Z1ixIUvNTAjFy2w12qV6OCe19g=;
 b=GlLrA+j9T/Q+fMuXrJaxRLNJlHX3lihPEPDLjQSCbr2NDc/fg7Q2Fql3LV64yIsDNJLT0E1OKONi5jAPo0p+En3jSFKmMifRNF4CH/ruwz5Rf9cXpPBb/lfj26mrgNPkCIaOfssH9bGkpLMsJcx2BGsC6DFDtRyxE+mw6dtRZrQ=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by CY4PR12MB1431.namprd12.prod.outlook.com (2603:10b6:903:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 06:49:34 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 06:49:34 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 12/12] drm/amdgpu: Remove redundant .ras_fini
 initialization in some ras blocks
Thread-Topic: [PATCH 12/12] drm/amdgpu: Remove redundant .ras_fini
 initialization in some ras blocks
Thread-Index: AQHYJww4PVbTRd0qSE+I+EayNwhhYayj2WBQ
Date: Fri, 25 Feb 2022 06:49:34 +0000
Message-ID: <DM5PR12MB177031B649E3A8172BED776DB03E9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
 <20220221101620.3269611-12-YiPeng.Chai@amd.com>
In-Reply-To: <20220221101620.3269611-12-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-25T06:49:31Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=df995bd9-0961-4e90-817f-d46aa52cac20;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-25T06:49:31Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9d839c01-b2b2-4e2e-b91b-a23e6854409f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f563446f-ad2f-4359-2b2f-08d9f82afbb9
x-ms-traffictypediagnostic: CY4PR12MB1431:EE_
x-microsoft-antispam-prvs: <CY4PR12MB14318066648F13B186033C6EB03E9@CY4PR12MB1431.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3K4UVW+T+yH1/qMsDVUpoS/5RK3Lc4U3H8CdZVlJxHfpcv0JIzoU2YmHZ9t+cwrcFaGX7K3Hc8KT0hYP0RXNaDUAolTbg6WgPuVlryzJMrkHg8d53WDQQtY0ei8uVTaALrWj4sSmZ2j5EQXeL8BaYjm3bOEB37Cm03nVkUfcn8j0/+PJ9thiCX/bqcyLGP/HLkMVPfEvm8Jyf8AhUGSGBlXPaVsXa/c3+Eul2Z8J2Rs3+ow+VzbQqwFOF04gUi+tK7ABA71uWMN6A6SbZqfJrR1oti0jOaqmgGgh0/GcuPKCkNyZjuXircGTPhYAR6n8b96sX6mYIRXeutws5e249O3Z17EzzoPxRB2HX8r+/g3Y5bFD8naOURp1Vqb1iwp5s9l9LrkbWwVT1A/Cs6+qwnBR8et120sVXR60/uqh0aqQhgecOYor95KauxA7wiMWXUrdpyB7fQHZASE+qQ/+wq5YX6cJi73ykeuSia3diK6sflXc9qXCtnlG+rqlAJTQ3bNLTDZkkLCRCAI6HTBZNvdjaSkzPM9TlWq+Wg1FqJ8R8iBL14ygP+bf4g0RHt2/lm8ztpOE8WWwB08YcPmLIuk5ed214wH2gqmL5J5UvNiJTTMbwMeV2k8HAktM1mKvPsDGe1+X8GEaKcFoqnWCcq650WjCQWalM4TbPkD6Q5J3hWOVkGpz+EnRwmhOwUWaZx2Oh7Bd6UCdWEj6M5+OEVweP5DWhJA8Dfye+0t/xNg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(52536014)(5660300002)(33656002)(71200400001)(9686003)(55016003)(38070700005)(53546011)(7696005)(8936002)(6506007)(86362001)(186003)(110136005)(316002)(83380400001)(26005)(54906003)(122000001)(66446008)(38100700002)(66476007)(508600001)(4326008)(66946007)(76116006)(64756008)(8676002)(66556008)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5BCdpyem0s7uRgcEG3uwoxRdRS4cWFcK2ytthnQ1qmdbxxS8+R7wqCzTpmDT?=
 =?us-ascii?Q?/67nv64HvXiRQ/aNprGJ0pYVem/+umnh8xUXWqe+oM0bsqAPskL0nU0b8XnF?=
 =?us-ascii?Q?IfD2q25tvq6fdhBtwvNrGFJEcYa0GJuD7QZXC4wbBFRDomM4+O1z188Yh06+?=
 =?us-ascii?Q?7txJ/+TajRmw20KSWqUkk7SIKdLbR2/8fCnf2mGzKVOC7HE1wWkZ2z+vnObj?=
 =?us-ascii?Q?l/07gl2mjfb5XVUAiTY6wWvED8Sx6m1Vh0iaFq9byAfoxCNHg5eQajlj48yW?=
 =?us-ascii?Q?38HoLhl1A2zLQaq37IR7L3hNCjAbOstcIbpWEfVUtvYpvDRYM92HGNbVFfsQ?=
 =?us-ascii?Q?Z0c/j8/5HmxEemjPvaTW6ptTsSE4mAuSNrUBOZOygTughGA3Td+NchWkroyZ?=
 =?us-ascii?Q?MlRaDc9mp66etW6O+14Pf/OFnH/RNmBlOc9mbJty4hi5tgYquXbu23YVVHYh?=
 =?us-ascii?Q?8CqhZJAnmurTSPmxuiHKynk64bVLvflEEJWyX4pVEsAwestrNCFSs2Od3oDl?=
 =?us-ascii?Q?4tZjwP1o7mLKTEXFd5MU4Aiz2/b0k+ATpk1vZegDm9Cek64omJSI9H9bzf7p?=
 =?us-ascii?Q?FW5bc9MetSeYeiTqqsQfc92LoFKd7MVPKK/ljCYn823WQs0hlKan2hs2uSxp?=
 =?us-ascii?Q?qy/qyDIePfLDa0jkZZa4f+30RsEAKhE2GjM7oBIulWn/kbs7TuafxwffczN6?=
 =?us-ascii?Q?AesLrnFP57ggjG6Uxam7Qx6hgskD1Zfw/NO9AT4cCCrhYRChCzbwGsB8ni/s?=
 =?us-ascii?Q?4/JDs2i2HTn6r4g5I8pXDXIMVMGfLxyowa8SceracDiPaJAiuqanAIweyqXT?=
 =?us-ascii?Q?4NQ+cvi7azYHKkc0oVNr0r/re+Uv2kG0Zw4PcmSzobOsSayjocmormuiDBuh?=
 =?us-ascii?Q?vtkWE9cxvE8HVY2HFVDz4cIm7/T0s7F+c6WSt2Ig/eG772V+hSGuAuL/u5Tc?=
 =?us-ascii?Q?G2zhyzqZkXZfSU/KDpZpLYu357Vi/F47p2oWAYpKZeAAmstpllbVjDBNT1UG?=
 =?us-ascii?Q?e0wI8edj6lNfhkoIAhwrxf5VVabnJbxnieaFABXuZn9I04cGgP/etYkrDmca?=
 =?us-ascii?Q?mVSvNxmgZ4dcranxTz3pPy65cs4elfV0SWllZ5xbdTQZz7snerLnVDE8qKNb?=
 =?us-ascii?Q?tulZ8l9YjYrFxiicWcrUEjzD3IWIxDuV7yY1F6+oTTRjyc2h+kaxvWJvz2J9?=
 =?us-ascii?Q?dHdGRdn2DFofF9+yQJkP46VfEXu4QLNsiIkWfDGzLfWzElrB0VJ8h+Lk7DGa?=
 =?us-ascii?Q?tC2SIjznJHHzMzAs8ywIsTgTih358Jb8GNEsOpLSuqm0908tLz7lN6H0bwP0?=
 =?us-ascii?Q?rIx+QfokaJTZiVCBn+rIsIt2l+AGBR9PYwn4DnmVwV4Ou4rNHnpB3RXZS932?=
 =?us-ascii?Q?mtA/1919oJqx/SRcH0dzVDNevR0O2EOMMZSSEeeguU5UfZwOh0D7L6/SyK6Q?=
 =?us-ascii?Q?NJmV70XcZ6HlVenUV+F726BsKjG/pDB9Ou5udyS3Hu/OP8vjemyDKCbl9ewR?=
 =?us-ascii?Q?05ceToFGMcpEdRmGpqGwxV629QnM6yjKW769NNv/CBlFStHCDzt+wMKnZ8Cf?=
 =?us-ascii?Q?pLE5fzoVdiJIvoprGJs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f563446f-ad2f-4359-2b2f-08d9f82afbb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 06:49:34.1104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvpTNbJ25bLT/uDxXYuuwjx8ZI0ChzvskPVtuPC+0dClqkzU1MO3/c4IBODvYTig
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1431
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Other than my suggestions, the series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, February 21, 2022 6:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 12/12] drm/amdgpu: Remove redundant .ras_fini initializat=
ion
> in some ras blocks
>=20
> 1. Define amdgpu_ras_block_late_fini_default in amdgpu_ras.c as
>    .ras_fini common function, which is called when
>    .ras_fini of ras block isn't initialized.
> 2. Remove the code of using amdgpu_ras_block_late_fini to
>    initialize .ras_fini in ras blocks.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 8 ++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 1 -
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 4 ----
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 4 ----
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 8 --------
>  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c    | 1 -
>  drivers/gpu/drm/amd/amdgpu/mca_v3_0.c    | 3 ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 1 -
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 4 ----
>  9 files changed, 8 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 846f51b0c013..17f7c0259115 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2477,6 +2477,12 @@ void amdgpu_ras_block_late_fini(struct
> amdgpu_device *adev,
>  		amdgpu_ras_interrupt_remove_handler(adev, ras_block);  }
>=20
> +void amdgpu_ras_block_late_fini_default(struct amdgpu_device *adev,
> +			  struct ras_common_if *ras_block)
> +{
> +	return amdgpu_ras_block_late_fini(adev, ras_block); }
> +
>  /* do some init work after IP late init as dependence.
>   * and it runs in resume/gpu reset/booting up cases.
>   */
> @@ -2586,6 +2592,8 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
>  			if (amdgpu_ras_is_supported(adev, obj-
> >ras_comm.block) &&
>  				obj->ras_fini)
>  				obj->ras_fini(adev, &obj->ras_comm);
> +			else
> +				amdgpu_ras_block_late_fini_default(adev,
> &obj->ras_comm);
>  		}
>=20
>  		/* Clear ras blocks from ras_list and free ras block list node */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index c04d98e3bd9d..8abdab6869e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -950,6 +950,5 @@ struct amdgpu_xgmi_ras xgmi_ras =3D {
>  		},
>  		.hw_ops =3D &xgmi_ras_hw_ops,
>  		.ras_late_init =3D amdgpu_xgmi_ras_late_init,
> -		.ras_fini =3D amdgpu_ras_block_late_fini,
>  	},
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index f0cc073e6bb0..8def7f630d4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2204,10 +2204,6 @@ static int gfx_v9_0_gpu_early_init(struct
> amdgpu_device *adev)
>  		if (!adev->gfx.ras->ras_block.ras_late_init)
>  			adev->gfx.ras->ras_block.ras_late_init =3D
> amdgpu_gfx_ras_late_init;
>=20
> -		/* If not define special ras_fini function, use gfx default ras_fini
> */
> -		if (!adev->gfx.ras->ras_block.ras_fini)
> -			adev->gfx.ras->ras_block.ras_fini =3D
> amdgpu_ras_block_late_fini;
> -
>  		/* If not defined special ras_cb function, use default ras_cb */
>  		if (!adev->gfx.ras->ras_block.ras_cb)
>  			adev->gfx.ras->ras_block.ras_cb =3D
> amdgpu_gfx_process_ras_data_cb; diff --git
> a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index c8ad824328d7..d9353bb99314 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -681,10 +681,6 @@ static void gmc_v10_0_set_umc_funcs(struct
> amdgpu_device *adev)
>  		if (!adev->umc.ras->ras_block.ras_late_init)
>  				adev->umc.ras->ras_block.ras_late_init =3D
> amdgpu_umc_ras_late_init;
>=20
> -		/* If don't define special ras_fini function, use default ras_fini */
> -		if (!adev->umc.ras->ras_block.ras_fini)
> -			adev->umc.ras->ras_block.ras_fini =3D
> amdgpu_ras_block_late_fini;
> -
>  		/* If not defined special ras_cb function, use default ras_cb */
>  		if (!adev->umc.ras->ras_block.ras_cb)
>  			adev->umc.ras->ras_block.ras_cb =3D
> amdgpu_umc_process_ras_data_cb; diff --git
> a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index b01767d78153..4c3483fbe613 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1241,10 +1241,6 @@ static void gmc_v9_0_set_umc_funcs(struct
> amdgpu_device *adev)
>  		if (!adev->umc.ras->ras_block.ras_late_init)
>  				adev->umc.ras->ras_block.ras_late_init =3D
> amdgpu_umc_ras_late_init;
>=20
> -		/* If don't define special ras_fini function, use default ras_fini */
> -		if (!adev->umc.ras->ras_block.ras_fini)
> -			adev->umc.ras->ras_block.ras_fini =3D
> amdgpu_ras_block_late_fini;
> -
>  		/* If not defined special ras_cb function, use default ras_cb */
>  		if (!adev->umc.ras->ras_block.ras_cb)
>  			adev->umc.ras->ras_block.ras_cb =3D
> amdgpu_umc_process_ras_data_cb; @@ -1290,10 +1286,6 @@ static void
> gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
>  		adev->mmhub.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__MMHUB;
>  		adev->mmhub.ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
>  		adev->mmhub.ras_if =3D &adev->mmhub.ras-
> >ras_block.ras_comm;
> -
> -		/* If don't define special ras_fini function, use default ras_fini */
> -		if (!adev->mmhub.ras->ras_block.ras_fini)
> -			adev->mmhub.ras->ras_block.ras_fini =3D
> amdgpu_ras_block_late_fini;
>  	}
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> index 86c166ae794a..04bc615f3af0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> @@ -163,7 +163,6 @@ struct amdgpu_hdp_ras hdp_v4_0_ras =3D {
>  			.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
>  		},
>  		.hw_ops =3D &hdp_v4_0_ras_hw_ops,
> -		.ras_fini =3D amdgpu_ras_block_late_fini,
>  	},
>  };
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> index 5ce6778a821d..d4bd7d1d2649 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> @@ -66,7 +66,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mp0_ras =3D {
>  		},
>  		.hw_ops =3D &mca_v3_0_mp0_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
> -		.ras_fini =3D amdgpu_ras_block_late_fini,
>  	},
>  };
>=20
> @@ -93,7 +92,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mp1_ras =3D {
>  		},
>  		.hw_ops =3D &mca_v3_0_mp1_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
> -		.ras_fini =3D amdgpu_ras_block_late_fini,
>  	},
>  };
>=20
> @@ -120,7 +118,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mpio_ras =3D {
>  		},
>  		.hw_ops =3D &mca_v3_0_mpio_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
> -		.ras_fini =3D amdgpu_ras_block_late_fini,
>  	},
>  };
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 485fd9239cd5..b31df4db01fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -671,7 +671,6 @@ struct amdgpu_nbio_ras nbio_v7_4_ras =3D {
>  		},
>  		.hw_ops =3D &nbio_v7_4_ras_hw_ops,
>  		.ras_late_init =3D amdgpu_nbio_ras_late_init,
> -		.ras_fini =3D amdgpu_ras_block_late_fini,
>  	},
>  	.handle_ras_controller_intr_no_bifring =3D
> nbio_v7_4_handle_ras_controller_intr_no_bifring,
>  	.handle_ras_err_event_athub_intr_no_bifring =3D
> nbio_v7_4_handle_ras_err_event_athub_intr_no_bifring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 206acb6a5b20..01b385568c14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2822,10 +2822,6 @@ static void sdma_v4_0_set_ras_funcs(struct
> amdgpu_device *adev)
>  		if (!adev->sdma.ras->ras_block.ras_late_init)
>  			adev->sdma.ras->ras_block.ras_late_init =3D
> amdgpu_sdma_ras_late_init;
>=20
> -		/* If don't define special ras_fini function, use default ras_fini */
> -		if (!adev->sdma.ras->ras_block.ras_fini)
> -			adev->sdma.ras->ras_block.ras_fini =3D
> amdgpu_ras_block_late_fini;
> -
>  		/* If not defined special ras_cb function, use default ras_cb */
>  		if (!adev->sdma.ras->ras_block.ras_cb)
>  			adev->sdma.ras->ras_block.ras_cb =3D
> amdgpu_sdma_process_ras_data_cb;
> --
> 2.25.1
