Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A15C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 10:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9B910E4B5;
	Fri, 11 Feb 2022 10:22:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6932210E4B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 10:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM5pzNKoLWI6nOgRo/1SFndd8PId8tmEw82TdLDahkTgsYiaqtjNX9u/SosZFb7Hy81UiCbp9Si87yXSLIQVjpjr1jTwpwTAdXT5w7T8cO5aal3dUAn4Wswc85qc5tWYK2g2Gad6s+Pu/5S7uSP6tdsdnIh6x6DDxW4ozneobGUTyerDGnoe2/OAzt3mnmXPOW96FlB2XOMjQJzBFgpaod7KT441Lhv30e80+eNXG3MfncPpCRLhX0MhPAihNEkIEOl+EboVqlbY47O8H0AaEP2x59IBc/pTY9vGhuSQBuCcsZ/FGMrisKKi0aflFHXO5+mbW8uH37yDYpR08e55HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpqGVtZpsKMn85kGVULy6x+YdfZbglbVXpIPhy5YFRM=;
 b=Q90xVYFBobb0W7bkDFxqP68RhhUiWN1hs8jRgwo9LxnuUyHRAb1o7cly+WuET1KG+VH1U6Aq9CU8Ym0pdC5/W8iTwMJLGmC3Z6Qm1g38An+l24MU9Zwr9NcYoDzxSLjc/5Ex7DruTSEG7O+9L4oB7pw1GD+D84Qtc+RTqYnVn4ZHbdTGQGwkOKb0pxuV68jixNwBHLRS+t16m3/9JvF4SeT4OlqBcduRnX6xSS0FomHnvqak1FLLpzRQ2OTqEmBHrZzBtKGnl/0ia2AASgnhQsvz4ZXZDZk5xEEnJM2b3wpbqpdOW/DZmMy61dApGHyNKCpVjfU3y3zpBI1pH4Q1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpqGVtZpsKMn85kGVULy6x+YdfZbglbVXpIPhy5YFRM=;
 b=utj6N1QtawEI6RQWRWC3Su0sP71Bw5FgeIA5jwTYYv6iUf5bEQgTmYqNWNsPDSvJpPRY6gZKvpfmySHGiQGDsvLUse6fPDVE73dXPiKEgarwHAwXz1cAeKYh7Xzfb4KIg8KdSmwQH3Y5MQzK9Yv5VvUVrLqI7xsMhNST07MBogE=
Received: from CY4PR12MB1767.namprd12.prod.outlook.com (2603:10b6:903:121::9)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 10:21:57 +0000
Received: from CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::4998:7ffe:1f45:598e]) by CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::4998:7ffe:1f45:598e%7]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 10:21:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: adjust register address calculation
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: adjust register address
 calculation
Thread-Index: AQHYHzBHaH5DUvnsUUOKG9BVXchUXKyOI6Hw
Date: Fri, 11 Feb 2022 10:21:56 +0000
Message-ID: <CY4PR12MB176759C671463F2AA248EF6BB0309@CY4PR12MB1767.namprd12.prod.outlook.com>
References: <20220211101513.2189-1-Stanley.Yang@amd.com>
In-Reply-To: <20220211101513.2189-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-11T10:21:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f86a825d-728d-4ca6-8d94-278c1a074508;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-11T10:21:54Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: a511e208-e5fc-4fa6-b7ab-1b51132e446b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45e3bfec-308d-41cf-922d-08d9ed4854ee
x-ms-traffictypediagnostic: SJ0PR12MB5636:EE_
x-microsoft-antispam-prvs: <SJ0PR12MB5636A95B264DA6E052BC0F27B0309@SJ0PR12MB5636.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: moxOiPYVvtmvRmP+ZUat+Y5Ov2nxCiOuPx+rFpSE6cpGCu1fZJMbz6ksrC3nUPtmFWt4fS7czS3ljDh2AgcgbXRzzAmoRAMvQ5XoD2VDQwZqlFclm/TLdlspNPfDfDpx9ClAwtgTV8L7kJ/wqRvQsUxiEMrWN7ACbt0QGhYQpf+aD2VztIpUeNx0BgLc0YmDtQnmeakcUDPz/IuXdOxQY2nHnF4wjmuqmGbzk2DFw0qdD6CtTz7nrGfNDPp6h+wcQUXPyNp527HI757PuWLeRe6LZv33dtY/qF2AvUJ5LLHhBds0Js5JRTXY7gesH5Y01WhVd1VCeTpoJjOQaWI/6SkR3uEFhl46xiq1zcjZBL2U++t2Ul/o/cBZ5Ff+K/J3dYS71m5E0FD8DGiaaDHn95pwYTRSxeuYtfrqDjw+ll5JLMwe9mOoW8vb3yC6vw7T1jPrFL3SStbolFLAc5pytdiHEMwLgzRDbnrJwAp3mv4fH40BJZ2HTN7mm5uOZrbt44o22leqJf7ichKRB1taesv3tvPJOLidYor7uFa9cKLAgh0zaygIzIG9NWyblLRpjW8j6HP/nQq0hDJC29+xf7qy6mUSus7eQcJPbmb6T7XekO4TTZrm7SVhJYr/7qOiZM/cpVoGhOpkPa4mBx+rGC53+oICzXcPMwxE4QN7RUjC7WVGZEDjw/Dy9UWmAJXUwM3W5SNVpOiRhy76rYaiYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(122000001)(9686003)(2906002)(508600001)(71200400001)(6506007)(7696005)(38070700005)(33656002)(66446008)(66476007)(64756008)(4326008)(8676002)(110136005)(316002)(66946007)(6636002)(83380400001)(26005)(8936002)(5660300002)(53546011)(52536014)(186003)(66556008)(76116006)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G6K5TYa0uO5CFTxpxFPdKKqUSS8jrYndH3DB2IOnuhaUXDBwSBbTapQlXVbF?=
 =?us-ascii?Q?nDcTtcPwf/FedOdfXwwwiuaKK/mD9Ze5V7tXOhshMF2oPzPQ2DtA7s6cVXvq?=
 =?us-ascii?Q?LriEFbwuNz/toxEcXjhfo2hhoYygtf2xGEJS6PjYGlOVD3dBHa4WJd19Bhso?=
 =?us-ascii?Q?YJIy34bK8PJjbBQEV25ISMEnvy9BdrpfBBXPP9qo1jV+58oRBa3tNRNr2JB1?=
 =?us-ascii?Q?hKjURjE1Jn9b3JFL4wcLmPVArK3RVBuMNEe+TvpuHe6Wsb00yEk1SDsZ9bbh?=
 =?us-ascii?Q?wYrUjUL3kyLLHjqzpOtwrLUzdXTO7v3k2Ou2WvVQJ/BHDR/7/eaT1aUrIeNY?=
 =?us-ascii?Q?wwCzuHzsipLkh3bJvESu6eWrbGpZE1UcG5W64pFt7mSOwIQvdE/+MoUejiop?=
 =?us-ascii?Q?ZZPVMVbH4qGVfdK+ZOk+MZ9s5tDZNP4S3iqvMWl5WU8Y6DDicpy57HJ7FvJG?=
 =?us-ascii?Q?ehPnWY9Lspn/xcSDXti5PoWloP2+LtnWT/G+kfyfl5omHcOb49SA6EmqxdP0?=
 =?us-ascii?Q?ITWBzSMefPqCbCDYsv1dNDEoU2SCPhGQW+uHb0wIwAK1vRAGR/OrXEPIYrA0?=
 =?us-ascii?Q?8R0xwkaKkJro9ICNcTIr31UYKrwCopzmQelEvheMvlyJc35YVUSSvfmYz1Ke?=
 =?us-ascii?Q?XB+NFViTLIPvWZSjmiTSVNAtauLHpQnLdBiCwrdBe/hg31AMZJ8zMMtM7WXF?=
 =?us-ascii?Q?VpLMSGQpRtsuFeUsdlcP+DNchvIJMjI6dyj3mWizZLkJU6CUdsh+0gEYAPYw?=
 =?us-ascii?Q?KiaP6xceZEH48IZaPTxhjsqmU3lz+kFnf7lJ6E5P3aInP9qIgeuYtXbWoVfm?=
 =?us-ascii?Q?wgZvrXsDm4ktt6/5SD8SSK45olUAk1aWepWJVECuNEgw6Pkkxzx9EFjTLFd5?=
 =?us-ascii?Q?kV+HofnYiLOhw93iacmp93eM9uwLGtJL2t1hHGKUibiVyH3cGaAEsqF77Vtt?=
 =?us-ascii?Q?ZPTHyWpyoOUWZB4bMIj1CCBKoqOYVf2vb8uFFBxZTHyRTyJ65X7sSu6VqYKW?=
 =?us-ascii?Q?Kg+8TT7FF3NHRmpHq3FoYQ23jUxlnajDXA++z8bRt6rKurWlsJ4hxgSjI66q?=
 =?us-ascii?Q?ofxBuR1px1U38XL7ZG7TZkYBuj3NepEqBfpOy5mh5OxqwEUVqkOHcR7KW0Cx?=
 =?us-ascii?Q?d7v7csMsdQxMPAJnp+nj/iPvFhAvVllWDKOSLhZElAURxF1h0QsZ82h3842J?=
 =?us-ascii?Q?g53AfFHd56C1yhEDj4QwJqXjcrnmBrgUXRBWgo9wfsoZXyIgHO+UjL3GFs8g?=
 =?us-ascii?Q?mi8k9Z5m6dpOKWvL0J0xTVJkl5BBB3JjjIISoQK1dAnQsjGV9/GV/rkW9sYu?=
 =?us-ascii?Q?+R9rBHxD7WmOv5gbUgMUTv97o5veH5qiq1+safHQgZh8oEo6ZBuPyPjRaLNw?=
 =?us-ascii?Q?vlL//TzsfvfiD7Zjb1rk9FYOlqV8YNosLowX/H/HtDgPRNZOZRSGtnDUYcJE?=
 =?us-ascii?Q?HHzNUoffQFwxLiCZILYzSW6qjPCdJs8oqEAM6MLl9Hl6oLRjGaC8U7se5MTy?=
 =?us-ascii?Q?qMlNR23TGUmC0omwekQh+xFwFn1z7+YepTzmjSbXvM0RqVRiRgWQ4o1nfXTs?=
 =?us-ascii?Q?M72IDVTGv2MdXQXsjQY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e3bfec-308d-41cf-922d-08d9ed4854ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 10:21:56.6579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mVB80b7iIguR/yRR76oDGMztoFet5JzN2eB0QoXyho6xtSpnSt3+XNqj8msXNZNe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

With the typo fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Friday, February 11, 2022 6:15 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>;
> Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: adjust register address calculati=
on
>=20
> the UMC_STATUS register is not liner, adjust offset calculation formula t=
o get
[Tao]: typo, liner -> linear

> correct address
>=20
> Change-Id: Ic8926078301848330babf289c4238dc8cbcf313d
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index e613511e07e1..87e4ef18e151 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -47,6 +47,13 @@ static inline uint32_t get_umc_v6_7_reg_offset(struct
> amdgpu_device *adev,
>  					      uint32_t umc_inst,
>  					      uint32_t ch_inst)
>  {
> +	uint32_t index =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
> +
> +	/* adjust umc and channel index offset,
> +	 * the register address is not linear on each umc instace */
> +	umc_inst =3D index / 4;
> +	ch_inst =3D index % 4;
> +
>  	return adev->umc.channel_offs * ch_inst + UMC_V6_7_INST_DIST *
> umc_inst;  }
>=20
> --
> 2.17.1
