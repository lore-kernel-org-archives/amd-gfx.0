Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F1AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jan 2022 02:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3B410E17E;
	Tue,  4 Jan 2022 02:50:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F4C10E17E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jan 2022 02:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iY3MJ5XwTZcs9jwQM2+N4PfJMbbXdYdJdKK3JOKlMpIoZ+Gcofm24tKekCapicOyTD2D34qKVoCK++gCY/k6Ml5/Gq4ooEUzrFCKO1bXzyDYErxkoJt/mEfzk/gXeltoih1Wl+POJwfVmBiuZBBMEs/69EGt2211QgQe6hr2XT4V6Hd8Je/RxtHiPX8PcKr+vKd/7mdbX/IHOO5A+m+pkXPKInLgoml56Zs4x+klfg9wnjfnygKqLg45lx1R1aRGNsjTXKSw/JP6rfoRSZpWOUjwQgMWlPzEDz4D41RVqi9tHNYhk5gaVwT9ByDjZJnGkJDSQ2w9xnf2HlDASUMg0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCPclLjoVGs5b63ynvNJVf4ZWAWvkkdhkzX0HJC2Ing=;
 b=KSth64rpwGCW6xua9C9I+eTjUiAMQU/Yu4uslmsdC05bgGt7UIpHhgFjjITvTy8O5lV4+/jNaAHJ11pOlHHiEF4+rBYNibLb/ZLQPKHRnyw85qKzWk+ipQ1ZYcZOcZ0hM+GqhI7TuT3s7jYDFZ/ACxgvaDGSx2NLzGAHK37QxDe4tD7ShUYfvHRDqzJverwtrGgEHcrxSgaueu/Fd0xVG2hNQAlQH3Yvt8jS0cqZj0xsGkMIQY8JuVouNluTc+kWGUeWDqc/ZfNoSiOrWJVaRtrDVd+sh5FjFf2jwoLvcalvSsMayhwYE2tOAH+4LBj72aq8+VgKweISDy7MfG5WxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCPclLjoVGs5b63ynvNJVf4ZWAWvkkdhkzX0HJC2Ing=;
 b=GGDvsBwbGprvIycS3ZgCvkWSyuVacu5WBADaeCeYwlQ8OkFzLChiaHNjY1DiqFDrKdX9Ll+L/pPYdZ3fdZZWLAlnTtc8V/hqabNxBpbEi47Tl0Irm1uxsCOCgoEygt/5oHubITEHUFeVvHG8hEIsPXyx02ZRrp3po0VQ2Wnhngw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3178.namprd12.prod.outlook.com (2603:10b6:5:18d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.15; Tue, 4 Jan 2022 02:50:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 02:50:04 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time
Thread-Topic: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time
Thread-Index: AQHYALX1ASjFPEL/qECcSokVQS15B6xSKfig
Date: Tue, 4 Jan 2022 02:50:04 +0000
Message-ID: <DM6PR12MB2619EE6EBBECC5A1D84700C6E44A9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220103152311.1453-1-mario.limonciello@amd.com>
 <20220103152311.1453-2-mario.limonciello@amd.com>
In-Reply-To: <20220103152311.1453-2-mario.limonciello@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-04T02:50:01Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2dedc6ef-5fd4-44de-a9da-4b6876269063;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29432033-e662-4db2-5c07-08d9cf2ce93e
x-ms-traffictypediagnostic: DM6PR12MB3178:EE_
x-microsoft-antispam-prvs: <DM6PR12MB31789BF7116CFB163E0AD5D5E44A9@DM6PR12MB3178.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VnG2GXsmTVd7b0x7RDq17VAQFKlq2+Kdp65/EtlMK+97Z3k2lCFf9XUIhR2jFBU0iKREuk3AihysrNXKsy59Kc9fK7ra9bRf1KQp8CxegKw6do2VEGUax6btImljUyFTGTy7Sj6EUHHMjwQDlcnec31fomxQ9+b+qbxIYNECuoszlbZlQ7LzE/OSu3bzw5kzSjowk/AHXwWqFir98ab1T0uihaQpreEfsC8gfNlIS+A3TSW17dxuV8M/Q6VSpRJSrcmI/fplXsfnu2QonEdY7FnsyE3tySt3u2k5N7nGgRqw4udpKWpyiD1f/UET7NspjkxfoRejmdht6kkDClblnK/L/f/YwiPUWA23oC5RMthglbplI3Bk1GqHtxIvIwJSvRIX4/SGs944rfpt92LTqGrylubr/39MUH3wiNgntfVEQAxoLQUTAs4KBzhq+Ym1AfHsoK62k5evmtNHmN45Ffw4+4FqDVKHa//G8UW+mvEj4KJtOiNag6YCLWrUYJkwEJLJkFkdS89zA1EPNSj/8K/Pwa0N0dV/4UZmn6GejSfxraFoaQHAfX51zhBj5qsA+Bf9r20gD5u3LV3s1Eqcv3KhQZDgNjMi/BLe13hQXCAG+uOpRakBESlColf8LZREzFVTweASuo/QER0ksjwsBHOvwfdGPNfkit3g0XpGiXzLt/X9HPpPBAutz7EcOVoUbWH/41T0kEL+zomrCybHexS68FBwPHs2nbTKL+vfWeU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(66946007)(66476007)(83380400001)(8936002)(6506007)(2906002)(316002)(38100700002)(8676002)(64756008)(86362001)(76116006)(110136005)(66556008)(53546011)(26005)(7696005)(55016003)(52536014)(122000001)(71200400001)(186003)(4326008)(5660300002)(508600001)(38070700005)(33656002)(9686003)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f1nLWveTjAaa+jS5iAFZtNEh+ZRsKV3dgquBgfj+7aCGfjhCSB2bKR845Chz?=
 =?us-ascii?Q?jxUZ5hCzExgW4lawcrumztdfAzKlqBNE4i8VjNerrQBe7ICczURCsIrAdjen?=
 =?us-ascii?Q?Oer0nAGEJ7XcIjVZASIDJ/qxp69mxhwcli0uPdLlrYjdj/ptroI4Qh35AYK2?=
 =?us-ascii?Q?8YZGJQCGS8UPAJu+gWTjtcvKFeyjrGvl0E0w4jIJPbDmc8vrgFBfNZOeIsa7?=
 =?us-ascii?Q?1SgKCCOz1CBve8fC6cvEa7tnvMM5uRbysrAwH2biIrQPAZYIHp/hWFAB+7op?=
 =?us-ascii?Q?i2tYfLhX+xtrGgh8Zd3sUitImQT4Hyqko4wY/eLrIbQTGRpmTAjkv2MUswJ2?=
 =?us-ascii?Q?E8JlfGW5GyThVAns+/zCipMl/9DmJW9OP936UNBmgEi/mylsCrIJ86UZZhXG?=
 =?us-ascii?Q?2MlkTaIZUO22Wbq0bw5gxzcy7YeuQ3KW/Qzad9dA6eOA9mfa0BMlPAdRzoTK?=
 =?us-ascii?Q?XMwlrexlPceyyEQ0+V5nA8v5fKjhH/YZym9akgkPSlGKUSpcaZTcWNq4Hwrs?=
 =?us-ascii?Q?q6BbyrGFLCpUWcjqfSSQs+bcvDa2t9MvSilk3pYcY/tYM5OMI6Da+TzNjf4s?=
 =?us-ascii?Q?Vd5H58gxKiUD3p4ikNyrrI/hEWeEdu+tn1EdqUrN1DL8vmd6ybIJ4dTIZSjT?=
 =?us-ascii?Q?WRYIPwfCq4CV1GmxbNNNEojzf9iuIR3L2Rlab6RiDQT9vmodgpaSKVnsJHTU?=
 =?us-ascii?Q?cPy5tDqylHQIm36309VU7JLLvRsef419uBUZgly4FVCnpTaOHR0pbQ4IUiLT?=
 =?us-ascii?Q?dAJ8y+QY2PnVPvNGnen3tDtM4Fo8qefHRrxs3QbHMw26QaegVWhbKU46kD/X?=
 =?us-ascii?Q?km/fF+HdaXh0N5BrkRr+Yg1EfpMpeA+8iPHT+sLiTtxdL53Puv6kK+OAdq2E?=
 =?us-ascii?Q?BaMQSMKtf61LEEeQeuf7TKgEsjOcq7D3lSCo61YGrTVPmb03jElnj9GeQ3IT?=
 =?us-ascii?Q?vg/FNwBp24wzSROnXpTGpRzcf6KcN15XSx+qcm03wx5xvFXUWXR7C6VXzlTg?=
 =?us-ascii?Q?oPXFEJBMY6TEusi65Ew/ICdYTtyTEdjL3DbVziwzn1MesDtzqE93YaLRxkUK?=
 =?us-ascii?Q?gEt3F+tRLnFEc3FAbatFdJw7Q3tRu5WzX77B8bbUmexCQzcx8mtrxBzZYkvx?=
 =?us-ascii?Q?b07llFVTk62ZfYOpnRxvVREK0cZmrrqVrJy+6azu9asYFpAQMYm01fQS3ye0?=
 =?us-ascii?Q?TFfwKs8IwtEU3KU6bZS6jMzPS+D+DHcHkzrQyrosdU06HxLU7+VIztfMwoFs?=
 =?us-ascii?Q?DMBDfAKY2Fro4ESZShoDo76EvwV0hNwuq0kT1aGYGbzjxLlwGoALQPsLIm0z?=
 =?us-ascii?Q?aaYIWZPbLTv4DDsfz+x4XoqEYNbI67O3iUxsaiT0Ug7jcPucOPlsJ8jCl1YJ?=
 =?us-ascii?Q?SeS+1M/nGu/nBGznnFbnxLYkGiV5ndLWSPMikwKPdR9nW5r1tDyGYeP7w+aA?=
 =?us-ascii?Q?C5hUbi5o92KGzolE4qII1qco46aA+ZxVAiGhBqZ8KFHQklWEJezGgxsn9QDX?=
 =?us-ascii?Q?EV2oxqUzRw5uUndzrdiLH4+AEDoge7kF219l9BLDEDvCQUaeJA9NQKl/Qjkr?=
 =?us-ascii?Q?GJBuf52MzvF06KGSPt8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29432033-e662-4db2-5c07-08d9cf2ce93e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 02:50:04.7855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipOHRU+zQxlv3HgO4wrCke5juJxs+Aeidn7ZJXPekps21QQRdZK2HHFqvN3VK2zc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3178
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
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Series is acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Mario Limonciello
> Sent: Monday, January 3, 2022 11:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time
>=20
> This makes it clearer which codepaths are in use specifically in
> one state or the other.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index db2a9dfd5918..413fecc89e6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2165,9 +2165,9 @@ static int amdgpu_pmops_suspend(struct device
> *dev)
>=20
>  	if (amdgpu_acpi_is_s0ix_active(adev))
>  		adev->in_s0ix =3D true;
> -	adev->in_s3 =3D true;
> +	else
> +		adev->in_s3 =3D true;
>  	r =3D amdgpu_device_suspend(drm_dev, true);
> -	adev->in_s3 =3D false;
>  	if (r)
>  		return r;
>  	if (!adev->in_s0ix)
> @@ -2188,6 +2188,8 @@ static int amdgpu_pmops_resume(struct device
> *dev)
>  	r =3D amdgpu_device_resume(drm_dev, true);
>  	if (amdgpu_acpi_is_s0ix_active(adev))
>  		adev->in_s0ix =3D false;
> +	else
> +		adev->in_s3 =3D false;
>  	return r;
>  }
>=20
> --
> 2.25.1
