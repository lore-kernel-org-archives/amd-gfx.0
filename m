Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF50C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 04:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CEF910FB12;
	Fri, 22 Apr 2022 04:11:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18A1510FB12
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 04:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGr8+v+d/Ws5ZxucRqbaa7g63XRJ9PmnEnhNOVqV2JqdEGrH/Pp9wP6hgWAOX//iyMWf39Gz3LYJxoXo01axOlkc1kiL2gwNVHbwb/9239Q3Xbj44cO/zx8EnlmkTsytzZXih8nsQCru3vXWz5SqdUFW8WlHFXkMtHVu4xUe4q+YulFJb5ueeq2koUeE3SxN/WYXBaDMqVYMKkjmlP5smrC/biuuiTksvX5H4Zx5K12GOLAV06720ylPpLnUD71k94gvjRllJEt91F1QZT4mjS7KgHotXTlqI1XXusa5xeEiT4xw811X1ezcjxvGBu5h+Ys20fO5xLXcVupI5+xoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPqGhVEn5jkEjpYY8K15ZQCT0bUNh8kHCIKEcp9e2CI=;
 b=iJUkqA3LKc6jp+vPVGbJmDH1sKP6EBC3pT5cnORB85aC4rtczkMvbDduE0xnouKY9oapYKJVhXxhswOv+tS4Qpke0Y8VHjfvTkYNmSvFhrQh0VHkEDGHNXH9G5xpDr1+WTZ0Rys1CqZIYI37KBW8M76muuTewWkawuXb2279Tck/M3nbSRZZbBJmP36bccH1kK5K0zo3L/XiX1fBBPPUeLgLiW5Y53kTsqk7yQh4GJVrRoxLworYpSRPPxJHXpaU8VN+LVSBa+EUGLGeWUXB5gPYGSBRxKBAgGvbT5e9NYIJtQypMzRGfUI1Q/TdHfODdUwElCJaS+hcQECvNdSJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPqGhVEn5jkEjpYY8K15ZQCT0bUNh8kHCIKEcp9e2CI=;
 b=A7X97FOFPvPZCWNY9+hAAeujuZaknvhCDAJ7YoXIi+MIWHXo2oYS23UnGSZpHDhfxLoU3uG9WN/yAp2S5V4Bl6JwuOmcB9bNZBn9yy+9TC7fgKCSNZFkyz0u2n/8UicE+T9WE/He05QFE0W5nFnYjwYwIHDaaTgNWMgKmQrsD94=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 04:11:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::a561:6b71:55fa:ed2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::a561:6b71:55fa:ed2d%8]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 04:11:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ziya, Mohammad zafar"
 <Mohammadzafar.Ziya@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: add RAS poison creation handler (v2)
Thread-Topic: [PATCH 1/3] drm/amdgpu: add RAS poison creation handler (v2)
Thread-Index: AQHYVKoM+fKd+ObatkWbJAquxwxDNqz6Z5/QgADrAICAAAE1wA==
Date: Fri, 22 Apr 2022 04:11:12 +0000
Message-ID: <BN9PR12MB52579393466F6D1895BBAE1CFCF79@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220420113009.8062-1-tao.zhou1@amd.com>
 <BN9PR12MB525799E8EB8215726022FA05FCF49@BN9PR12MB5257.namprd12.prod.outlook.com>
 <DM5PR12MB17702D829CE11CC3DDC8481BB0F79@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17702D829CE11CC3DDC8481BB0F79@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-22T04:03:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d633df3b-aa92-4fb5-8209-d1ecd4d95b9d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34fad30d-3a6e-40ef-fa41-08da241622fb
x-ms-traffictypediagnostic: PH0PR12MB5646:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5646C17474C1CEE5E69EEABFFCF79@PH0PR12MB5646.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iPj1dGs7mMA/f60Fg6IajtmgBXY1W+p1oi1IOU5kou0dK1fipPfNfcqdw2vGBmK3RzONvt83lO/gBV77UXLuY7cRcxWbzbl+ADrvFwaKWv4ly6P0m8gsMnNVURr9iqN+j9Ve4k4oWf1upqTNOtwlFkLgsJBRPO6z/uzMgGLdCXr86hJ/kGSEr6FxahtPht8z53Qv2lv6WyeT9FbC+26xhe4/v8iTJ/e/YDkv4AKUqiBl/gIpbUSVmB28owE4puABzUdONQu2kIADEh8wGhI5cLno0wz+bymckxiX9ANBsgOiz1/ttsUZVroSgFrevgjpMfiZemR5lAz9RVz/pQYB7eaD9WCkiq0jATvYMLVKnSA2OO//GkmZIRxLfnxciVdRj2P8KnlvTC+aeSz3jcwvZwYGOl3rd8zO+mP59eb9f9DgO4t3120GpCT2XX3ccaBEcLUA63LH2laaqyhtw/RKQ4yZbFdI5O3jlc8BgKE9sFLj+tnmGGJ8aDonT+gOyfT7ggk3VIwHwagnYnaHIM6e3iV0+2OI/dsbK9tdzB8PLu3pKiHZcDt6Ac7KtJFZRNg/yaQa8vNSP0b4VQnK1UcRqvO2HudeuK8o3qcP60VRcoJL28gm33v62EyK1OI5Ij7QD9nr/e5MYL9hFsdJ8U9r0QKy7Ci0crFfkExsPeqAd66kE433RsitY7O2ZdNWUuutribBIj4e5oXBuaFNui37vhhcIsKnMg6YgCO+VG2K/t4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(83380400001)(64756008)(2906002)(76116006)(66446008)(66476007)(53546011)(86362001)(8936002)(8676002)(26005)(66946007)(9686003)(52536014)(186003)(33656002)(6506007)(7696005)(5660300002)(110136005)(66556008)(38100700002)(6636002)(38070700005)(55016003)(316002)(122000001)(71200400001)(921005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m/ZSUwFmPY8JPmMv9Nuy5uWrMC5lMbBapfRSzC7Kj5hOZcYUP8GbhQ49v0Dt?=
 =?us-ascii?Q?zsbVGrAYEZqrUhjqCNJaz/AOgu/pAq3h/iy0j9JUF5HNaCdKsBLXrGCkACYj?=
 =?us-ascii?Q?03KUaoxF5JNxnWAT/dLBsBeB9y2Y6G6C7xl8ZAY2IHRl6nCM+J9Tg3QWc+At?=
 =?us-ascii?Q?JY5U7hk1RlhLJyz349/nMA4P1fQ1uwI+sNxjZ9wa6V3XF7YPVu40neDXigpe?=
 =?us-ascii?Q?6GaToD/veGNewT7VVu4x9yuEdq8AoWaWqw29H181VaZ/MsryfGtbIkUto0eT?=
 =?us-ascii?Q?0Rf46U0l/hR6I7bHoUCGENFHgNARONmxzCPsCjXzonV32LokuaD1NBnxiwmj?=
 =?us-ascii?Q?sOxYUin4gT+N69pjDb+4C29dFBzO2ALBqHsR4Il3pp1uiXpJ6vYbqGQm+5P4?=
 =?us-ascii?Q?HGtiKXuwyn0Ovi8L+Qxpkb93yDnUhLUkSes1Fcg9ToU3eGCZgKmKt6ck7Cm/?=
 =?us-ascii?Q?vCknllWq8IQekcTRSiHwF0kSmyt0wmKbEfMHE2BxB8QLOZ0wNz0HEJkZjnMF?=
 =?us-ascii?Q?l0agauWevA/L/0CfbtkG1RYXKAowJV+AHojbMl/WyA3qmJ96uRuThVQ/rq72?=
 =?us-ascii?Q?T2TEAnQvj0LZ911uH/DmKnBQJmyyu8VsnwZUFHu0GfHxbNNt4WoSW9/be13F?=
 =?us-ascii?Q?srigVgZHIl5pXbcAgGSVObLAxoIijcTkurarhgEKAVW8m4fSTdBw91ZMDPOD?=
 =?us-ascii?Q?a+SyagTkLbhR0mbl33As99C2wTSqMH0YTIzYZAMyQW+wRKO6c3KeVb5/b4jY?=
 =?us-ascii?Q?GkOH6pmtrc5tdXQQBHxoztXPXqUDNtltidzpSA/Pa0DspcoUk2XYgUjeEZnY?=
 =?us-ascii?Q?zYId7IwTu7/eJEnzfLZRbFL9gQ+uWu+XoCnDd6/nk0EYE101aoGOZmP/DrAM?=
 =?us-ascii?Q?hEd8BqkAGGygP8c67JW/4xAhjW9zeJqqnzL9+yZLc+EaZiAB9bcX8ir3iGvd?=
 =?us-ascii?Q?4vQbooU7riz98DqOs/JMZMHCeYR/kp50rbEsY1T/kPlaZTOHU36I5jclETaJ?=
 =?us-ascii?Q?FrLOUz6p04RT8om1yerLDvzNilJfHWbaiXsm254lOFgD07h7xO9IiJq9ij13?=
 =?us-ascii?Q?3mGZ7CjL6k5gN6AMZMMlpIr8ccMQ9ri9cRl6s13NlZbSguwLSBUtMvny+GoY?=
 =?us-ascii?Q?zT1k064rgm1enxIjGfbE/QZ/d73nUQwjc5Dc0IBTgOL/no10DUPnYACYkRJM?=
 =?us-ascii?Q?4aSJxwOdoolfFx9dndQM9TVSeaQLVoGARQDAEnyzjpWidp0yIsloYABvqJrT?=
 =?us-ascii?Q?zVJ5aXfIjVwd2zwQD0AHiE2HGtf9jOt0dbZEQEB8Mr8mC/L+pd4zW0swyQ5e?=
 =?us-ascii?Q?kGqiv1ZfOm7ebfFvj9IT1oXT/TkR0CIMey39Z1FPjeZHFreLmI9KzT/mfTrB?=
 =?us-ascii?Q?mQQjClPqLWUhI0sN3GbQlhtlaSeD0quh6TQtacw7ul8v9qdsaWOKtR7zsmbb?=
 =?us-ascii?Q?tkSDSLTf0OX6XXahHLrY+fLvJ9xK4UbuMKOUIeRE91B/mxJz1gwmpQPgXAeK?=
 =?us-ascii?Q?pHJGrV0DAXce6LZ/F+QqpbOQZ2Rfi6gtBn7jahKd4RTimcL2JoDChR5DeV8x?=
 =?us-ascii?Q?ebk9Vhxcx1F5Eef7+O+0ZAwcfBss/UWgkx+0nsUexY5x5Zpk/+XpPKzySStR?=
 =?us-ascii?Q?gLyXeeyjfJ1Ep3K8iy1SdrGwhZ2uVBXSfz//KVqeBjmt5/lNG/b4qkGtY4/L?=
 =?us-ascii?Q?idT2yEaBxD+MZL8CPNWGQ0bB8NZmfmXyefHFsJZvfxDzyfz0+VQlw63T3Vcz?=
 =?us-ascii?Q?+rC332QMaA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fad30d-3a6e-40ef-fa41-08da241622fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 04:11:12.0541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nqTFqjm1WIryE2Vg1AqMDp6NKIFMAl0IpBjrqtdLSimkvS4Ubj7MNpkZVCNd2zF6GT66WnB4Te2wArxqjk8jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646
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

Hi Tao,

I'm thinking of checking ip block first because we might want to leverage t=
his interrupt handler as a common entry for other RAS interrupt as well. In=
 such case, it looks more clearer if we check the ip block first.

I agree with you either way looks good.=20

You can have my RB for pushing the patches - We are always on the way to im=
prove code quality.

The series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Friday, April 22, 2022 12:04
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Yang, Stanley <Stanley.Yang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ziy=
a, Mohammad zafar <Mohammadzafar.Ziya@amd.com>; Chai, Thomas <YiPeng.Chai@a=
md.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: add RAS poison creation handler (v2)

[AMD Official Use Only]

Hi Hawking,

The logic in my patch is:

if (poison)
    if (umc)
        poison_creation_handler
    else
        poison_consumption_handler
else
    if (umc)
        umc_handler
    else
        not supported

I think your suggestion is:

if (umc)
    if (poison)
        poison_creation_handler
    else
        umc_handler
else
    if (poiosn)
        poison_consumption_handler
    else
        not supported

Either way is OK for me, I don't think one approach is better than another.

Regards,
Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, April 21, 2022 10:54 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org;=20
> Yang, Stanley <Stanley.Yang@amd.com>; Lazar, Lijo=20
> <Lijo.Lazar@amd.com>; Ziya, Mohammad zafar=20
> <Mohammadzafar.Ziya@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH 1/3] drm/amdgpu: add RAS poison creation handler=20
> (v2)
>=20
> [AMD Official Use Only]
>=20
> Hi Tao,
>=20
> I was thinking more aggressive change - current=20
> amdgpu_ras_interrupt_handler only serves as umc poison (poison mode)=20
> or uncorrectable error handler (fue mode).
>=20
> We can still keep it as a unified entry point, but how about check ip=20
> block first, then if it is umc, then check poison mode to decide=20
> poison creation handling or legacy uncorrectable error handling.
>=20
> As discussed before, we'll optimize the poison creation handling=20
> later. so keeping poison_creation_handler and legacy umc ue handler in=20
> separated functions seems right direction to me.
>=20
> Thoughts?
>=20
> Regards,
> Hawking
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao=20
> Zhou
> Sent: Wednesday, April 20, 2022 19:30
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Lazar,=20
> Lijo <Lijo.Lazar@amd.com>; Ziya, Mohammad zafar=20
> <Mohammadzafar.Ziya@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu: add RAS poison creation handler (v2)
>=20
> Prepare for the implementation of poison consumption handler.
>=20
> v2: separate umc handler from poison creation.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 70=20
> ++++++++++++++++---------
>  1 file changed, 44 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 4bbed76b79c8..22477f76913a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1515,12 +1515,45 @@ static int amdgpu_ras_fs_fini(struct=20
> amdgpu_device *adev)
>  /* ras fs end */
>=20
>  /* ih begin */
> +static void amdgpu_ras_interrupt_poison_creation_handler(struct
> ras_manager *obj,
> +                               struct amdgpu_iv_entry *entry) {
> +       dev_info(obj->adev->dev,
> +               "Poison is created, no user action is needed.\n"); }
> +
> +static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj,
> +                               struct amdgpu_iv_entry *entry) {
> +       struct ras_ih_data *data =3D &obj->ih_data;
> +       struct ras_err_data err_data =3D {0, 0, 0, NULL};
> +       int ret;
> +
> +       if (!data->cb)
> +               return;
> +
> +       /* Let IP handle its data, maybe we need get the output
> +        * from the callback to update the error type/count, etc
> +        */
> +       ret =3D data->cb(obj->adev, &err_data, entry);
> +       /* ue will trigger an interrupt, and in that case
> +        * we need do a reset to recovery the whole system.
> +        * But leave IP do that recovery, here we just dispatch
> +        * the error.
> +        */
> +       if (ret =3D=3D AMDGPU_RAS_SUCCESS) {
> +               /* these counts could be left as 0 if
> +                * some blocks do not count error number
> +                */
> +               obj->err_data.ue_count +=3D err_data.ue_count;
> +               obj->err_data.ce_count +=3D err_data.ce_count;
> +       }
> +}
> +
>  static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)  {
>         struct ras_ih_data *data =3D &obj->ih_data;
>         struct amdgpu_iv_entry entry;
> -       int ret;
> -       struct ras_err_data err_data =3D {0, 0, 0, NULL};
>=20
>         while (data->rptr !=3D data->wptr) {
>                 rmb();
> @@ -1531,30 +1564,15 @@ static void=20
> amdgpu_ras_interrupt_handler(struct
> ras_manager *obj)
>                 data->rptr =3D (data->aligned_element_size +
>                                 data->rptr) % data->ring_size;
>=20
> -               if (data->cb) {
> -                       if (amdgpu_ras_is_poison_mode_supported(obj->adev=
) &&
> -                           obj->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
> -                               dev_info(obj->adev->dev,
> -                                               "Poison is created, no us=
er action is needed.\n");
> -                       else {
> -                               /* Let IP handle its data, maybe we need =
get the output
> -                                * from the callback to udpate the error =
type/count, etc
> -                                */
> -                               memset(&err_data, 0, sizeof(err_data));
> -                               ret =3D data->cb(obj->adev, &err_data, &e=
ntry);
> -                               /* ue will trigger an interrupt, and in t=
hat case
> -                                * we need do a reset to recovery the who=
le system.
> -                                * But leave IP do that recovery, here we=
 just dispatch
> -                                * the error.
> -                                */
> -                               if (ret =3D=3D AMDGPU_RAS_SUCCESS) {
> -                                       /* these counts could be left as =
0 if
> -                                        * some blocks do not count error=
 number
> -                                        */
> -                                       obj->err_data.ue_count +=3D err_d=
ata.ue_count;
> -                                       obj->err_data.ce_count +=3D err_d=
ata.ce_count;
> -                               }
> -                       }
> +               if (amdgpu_ras_is_poison_mode_supported(obj->adev)) {
> +                       if (obj->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
> +                               amdgpu_ras_interrupt_poison_creation_hand=
ler(obj, &entry);
> +               } else {
> +                       if (obj->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
> +                               amdgpu_ras_interrupt_umc_handler(obj, &en=
try);
> +                       else
> +                               dev_warn(obj->adev->dev,
> +                                       "No RAS interrupt handler for=20
> +non-UMC block with poison disabled.\n");
>                 }
>         }
>  }
> --
> 2.35.1
>=20
