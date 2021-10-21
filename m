Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12731C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C406E610CB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C406E610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831856EC5F;
	Thu, 21 Oct 2021 13:14:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F476EC5F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 13:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6fUkckm9mhs5AfmWY/MmkCM//kK+LtKtQ9GXm6dBX71rlNKclTxiMwBcw/Rltq++GwdLUQmZNU/bTYt+fJHAsOU37ZgzaiG5rr2+EpHEdIOjHaSy9F5eGvQ4BY6XMqeViij9zL36JzWqlh1VP3l+kW/8osna+iLFYF2o6DQxy/BfnucQgfUdDrB3TxN/nOrmFEBQT+F4+TDFgAVfJoRZC2K6PpbaVr1MUZPKm2+1A2wtCXp8BRohla5MDXAr8XVakztRE63prQh+lwBOu8h3K2R9byCD82pq2XUNNZHaxv7d7iP+Zw2IMufloQjqTkhMSV5lvv65l7+KLtt3m1cNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdMDtJF+hZl/HOl7OhqM0fUjqAWWGsh2XtUR6AL8Ug0=;
 b=NKo8HKZba1HokzRv5cCNv0YTOJEXJO/V0S5KJzRbzjyamuDv2m+LHMTGNrkS0VB/f9ZNPQusnGTIUlRclLY644yq9J2zVmatM2c+7KufbrC+H4UllL+m1Y5iEMoCVXof0bNPFFPI747UvOXkV0CG0T9Il4SSqIBV6RxfhHCK6qkCLnkeCYBFQFoQJtBcyvz5zLLAv+lyhO9JxQ+/vL0G77IdJrD2Gx4QVyBq/YFGsUsm/3V8nQIQQkxC362WMTJhJPzB+OdNY3thXGZC4khdDqPv7dENLUeSank8Y0VcKtgnOM8wPYqWmGmRkPWICdk4T5c4jMSV/2qYFcnutlbDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdMDtJF+hZl/HOl7OhqM0fUjqAWWGsh2XtUR6AL8Ug0=;
 b=cB4gyub9gNut8YHOO41ejF0dGBQIiCN6dmEavpolv06ctUyMwRbaZ0VQ+iFfeJIq1C5KeO3L1pm60tUoU5SQjTnTt1Wy7DSMjOodfa57N0cxuDL1ntdhX/pcpPDVB30PnpBfbDec0IZkyLHJzIMOwaS+UzpgSIX8l7JjFEJIcyk=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Thu, 21 Oct 2021 13:14:22 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 13:14:22 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
Thread-Topic: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
Thread-Index: AQHXxktx1DjGstD6vkidsjU3klQZCqvdbB6AgAAATzA=
Date: Thu, 21 Oct 2021 13:14:22 +0000
Message-ID: <DM5PR12MB2469DF82D13B3FE947FCCC82F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211021071512.20034-1-guchun.chen@amd.com>
 <CADnq5_PJZDfNJOrFLsn5+FeWPm=eS4CE2d4FTdTSUKkDkDZg6g@mail.gmail.com>
In-Reply-To: <CADnq5_PJZDfNJOrFLsn5+FeWPm=eS4CE2d4FTdTSUKkDkDZg6g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a309f5a4-e333-464c-6519-08d99494b2f8
x-ms-traffictypediagnostic: DM5PR12MB4680:
x-microsoft-antispam-prvs: <DM5PR12MB4680A37E34C6466C5F9864B1F1BF9@DM5PR12MB4680.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qHAs7Hql59yA6KtQt/FDdWxKtLVSelubekoRoBH/qCTcnmX1uRZnh4GKsxAEiLZkzDUzTr3IZjQFhT7mF1EARLapxqDTdA5xXP9phHO7xvAGatEW2sdcdPxpvbLpbA8g9MRRSDO0HvNUBMmnTDySUFY+SXrfZmhef4Jxl1VlTxB8F7/WVtHjUVP1UX+GaRrpq4mYAvvXjbFGK0pmGWxt7YgmeL2DLNDwOgiyYYOcZFJG0KmvWTYFVQD6uaukHVyEdlm4gJeK9wRFCOwCF5XQTXnU8myY9UyJnPUQCT27gWCYvqhto8MgMeBUUsajmgcbbxWYqlB1HtgwSkimYja2xVEtecI1OgFJsoLxcJixBtd2en0Arwsl/KktnFzxBQZO79QQ1m58uzpvco72sm5uMZBWsoatEsNp2ZfOi037nBwy/bDbs3xC7B9Pk+W4EFDF/k5XzoXw8m/rrIvP2zLIixVSDryO00dBIC+XncoH3t7HjiSeG2ryjIySxdZzl+YK0ZdBUZpQ2iGPey1apf9E4vnReDqAdrRqZ0pUMczwf6uLzBx1Y5xmQS8wQFpUI+wefhxLkj90ArPpuieD7QR69EdGimhb2u5WX+TK5r/q1Z/H3QmyTVixf4nx4gfaG0GZ4SVXv+n2KCdzUaHI088OZxH6rZ6GE59eLc1VTe/SBaomcxKrm20Ou4ffIlMO45qAnG53MvD+oe4enPxKrHi/UR3uco5dPoJDm7BELxhMWeYwGAC+n5pS2qGQa+24VD5akYHiSMpG/dun+0huvyAUaCnD49C8EmYmgVzyVK/M8Y0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(8936002)(53546011)(54906003)(508600001)(26005)(2906002)(6916009)(122000001)(45080400002)(966005)(71200400001)(316002)(5660300002)(186003)(83380400001)(8676002)(52536014)(4326008)(38100700002)(66556008)(64756008)(66476007)(66946007)(33656002)(66446008)(86362001)(38070700005)(7696005)(76116006)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N/qtJPOlcDA1SsZz/TgeeBRm8CdjUKn7i042m7AexFFbLY/3/bVP9LrXz3Ms?=
 =?us-ascii?Q?wLgdmo4PiYC0qZWcfCPuCDJsCSqIDHNT8fyr0anPHIG1QPEjW35RxEu5qBQy?=
 =?us-ascii?Q?vvTYIvH+jQGQERgXtCTMEDO9dluG/cWfhadLyR8z6vAPMyFkCciltlvQru1t?=
 =?us-ascii?Q?zEJb0CWWV8H6JjSXvd24KOKScoKQApsQta5Eh3XcdgjXO2lepaWPFIdth77K?=
 =?us-ascii?Q?iZQOQaNe9hqmhGcEFNEtEvzI9b63G3M2dYWro/JMOct+2ET7ho05HBDE+hPt?=
 =?us-ascii?Q?D6h6JU6w7j9yQV02grtz15S54S8lPwgaY2kJp1RbouGtsmlm/2sPCzYENIJp?=
 =?us-ascii?Q?ICETX9/pKTzuN4w2wkMXRAyda9zHV5pkbtCjoq6qlmBuN2SF1FliuTsFQ1B1?=
 =?us-ascii?Q?vf/BwXfSlff/YA2FoLUPXmG1xthjoaMG1iHoTa9TZ+Cck0eWj/cubvGkJtV0?=
 =?us-ascii?Q?cyiiZPLyWEBC6xgKqjNV4k4ljBWn62vprVD6KKkUmskVDuL3wRL1s2TbrVtY?=
 =?us-ascii?Q?WbzxO7+xTdotwCKkhOGkyhay8Bg0S2Vi74n/V3drtLa+hvkYgCN4EuXyR39G?=
 =?us-ascii?Q?0UaLfu5UvxvUsaK7TQ/1GQrG7gWsWwG9j57IxeO/QKiuSSAcfZKxKX67m+Zn?=
 =?us-ascii?Q?egv6J+ncAmP/fpWoODWohr5ywuGft+w5jllqFgcfIhynnfJxAfduq8WtVPc8?=
 =?us-ascii?Q?UDguAgF628dccnn2hnwhLNpAVdq3PfqiCSyoCGlfzTIOr6oWU93ub7Kd8pYQ?=
 =?us-ascii?Q?xZbdEicUgbYslRCGH8Hb6OomJ6byKA4j7nuorKwJdeu0rr2O/ruZ2fp18QSo?=
 =?us-ascii?Q?9vCAeg2CI8YeZTzHhkliNk2wcA9bkgjncOvmJ7o8SoDoZ+JO4/zHd5FCDLIS?=
 =?us-ascii?Q?fsyoF4+yX8oy1W3R918oAjjeF4g2ICoIrGsCMiZB83zZIAKA/0Lw4dhcFJ1H?=
 =?us-ascii?Q?AsY6rUCyWMhgr9lobhwDHi2WSv5FIHDBTyuz26aDgEWwRE4Mt4CkkGB7/eI6?=
 =?us-ascii?Q?S8hVtNwMzA1+5ASPTSKZjPQl4csOCrkq0f4RTNMWpY14jtFJ01TOEene/9HX?=
 =?us-ascii?Q?ERQDkCjhIpVpgkJVZMZWFScKyCN+N9fxM7NGSCEQsjlrNDZ5v7Gd0IZqDtW+?=
 =?us-ascii?Q?cN88e5MBbrWF5Q/4HT2oyucY3rea9nhOLQNFJZKtYV3p9U2RjLEa5U0v7jV+?=
 =?us-ascii?Q?5AdtpLDYA5KxQppFIi7Vgkzs4hTUHvGmI4/INWN38vOojvcdYkWsCeFQQsCV?=
 =?us-ascii?Q?09fO8Fvlyood793040xYCGTgJMjpc+JkoYFYmcpqqFL7nAi30MSJL5KQ0Zy4?=
 =?us-ascii?Q?QhRFndVvcJTb85fovF3W6TLmmJK1zIvgF8fF41e9C3evi9WE6gDZOpFrsqZZ?=
 =?us-ascii?Q?OX3uWNA6+Qwg31SI2PJSjbU7/UbWxM5DI/V43umoo6dCoTwo1a7N0hvgyoBB?=
 =?us-ascii?Q?CtdhFsbtyYc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a309f5a4-e333-464c-6519-08d99494b2f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 13:14:22.6031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guchchen@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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

Hi Alex,

No, it does not help.

adev->vcn.harvest_config is 0 after retrieving harvest info from VBIOS. Loo=
ks that harvest info in VBIOs does not reflect the case that VCN1 is power =
gated.

I checked several navy flounders SKUs, the observation is the same, so this=
 is likely a common case. Perhaps we need to check with VBIOS/SMU guys.

Regards,
Guchun

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>=20
Sent: Thursday, October 21, 2021 9:06 PM
To: Chen, Guchun <Guchun.Chen@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Koenig, Christian <Christ=
ian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <=
Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: limit VCN instance number to 1 for NAVY_FL=
OUNDER

On Thu, Oct 21, 2021 at 3:15 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> VCN instance 1 is power gated permanently by SMU.
>
> Bug:=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitl
> ab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1743&amp;data=3D04%7C01%7C
> guchun.chen%40amd.com%7Cda80a308a28049d543ad08d99493847d%7C3dd8961fe48
> 84e608e11a82d994e183d%7C0%7C0%7C637704183581593964%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1000&amp;sdata=3D2vNLj9bXE2oV97rxBiUOiaFNpKopVSJefL%2BMcQE%2BSfo%3D&
> amp;reserved=3D0
>
> Fixes: f6b6d7d6bc2d("drm/amdgpu/vcn: remove manual instance setting")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Doesn't this patch effectively do the same thing?
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwo=
rk.freedesktop.org%2Fpatch%2F460329%2F&amp;data=3D04%7C01%7Cguchun.chen%40a=
md.com%7Cda80a308a28049d543ad08d99493847d%7C3dd8961fe4884e608e11a82d994e183=
d%7C0%7C0%7C637704183581593964%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DjPu3Yh%2B=
6OHR4F1BS5MWL3VyZ3pui6c0dP97Zl7yBJKY%3D&amp;reserved=3D0
Where else is num_vcn_inst used that it causes a problem?  Or is the VCN ha=
rvesting not set correctly on some navy flounders?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c=20
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index dbfd92984655..4848922667f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -103,6 +103,15 @@ static int vcn_v3_0_early_init(void *handle)
>                         adev->vcn.num_enc_rings =3D 0;
>                 else
>                         adev->vcn.num_enc_rings =3D 2;
> +
> +               /*
> +                * Fix ME.
> +                * VCN instance number is limited to 1 for below ASIC due=
 to
> +                * VCN instnace 1 is permanently power gated.
> +                */
> +               if ((adev->ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(3, =
0, 0)) &&
> +                       (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(=
10, 3, 2)))
> +                       adev->vcn.num_vcn_inst =3D 1;
>         }
>
>         vcn_v3_0_set_dec_ring_funcs(adev);
> --
> 2.17.1
>
