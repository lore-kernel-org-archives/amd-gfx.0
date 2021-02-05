Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262B8C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53DC64F06
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53DC64F06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E26B6F517;
	Fri,  5 Feb 2021 22:33:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D8F6F517
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKPY7dkti/m4sCSMfw4lpRbUir6L+VwAUKHPFopcbm1ODMh626dCHim7Ot7EjCMkkVPiVz7SivcUuWAKfsUtgu6jqeq8mtKNoP2r9Afm1Pf1T6Kqd+2Wbhk3pOWpuGXHmBbzZMUuvIPdR2APAJ0VM22cPbfdpsAgjW7/TNFywdXRbFPt4IxavhWATob/yhIUYfLq/fHyaoP6vtoZ3ksQBotCtTJB6oFKWt3gKxWwbMQH6OOCxtTdKPYf8WnnEF+GvcuDdjTDcmvb10zgnfqpUFX0ouNckwqERZDaj9o4/EDVJp6HoyQu6mz23OwaK+R8VTaNjRoqfPnCQmRZOBs+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNzC5P6ozPuIgy7sUVIfbTVyHpPTrQ6JYZw7/zpbtEo=;
 b=l9d1O08U489zl/QssD6OURmGikhTm3ALJLtVriKwmfwmz1EiLd3lTELaYvdGcTbdasRttkceY8v1JBjKLeZ9NBVad4GFhNnzUuA3ug9yHuo/2L8Ym1e00CJ/MXgaHUtYMC20b1b+qvGoEc5pY7y137I8oAICtSxkOdVL6DElwOssHXxMf7u3K63QDaw6pOgr3cL+kaTuvTW2BkPeQBTvFxwEDqwfbKU9YwQFRi+ArMzOwaiu4x2u5rEhD4wzW4NIwRvWI1xefZz7lX7H0uHr0zkx2ER+JCCvSxhQyywinOUjJMomAHsIHP0sNNqgfU00WiNwE1r+bEmy2JlHhkzN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNzC5P6ozPuIgy7sUVIfbTVyHpPTrQ6JYZw7/zpbtEo=;
 b=ksvAiJsXZKbugw55dggsNfwFQ7qfRWMt2KQxuP85GouvhrJ82AgqCAwtbfC2+rm8Z/NhuhkdOKfJX9YpV+oZEisXxu6ifvtYCNxcYolJA207Ik78Y4iGJV3Zk1Jl6hZlPttp7Dr6ZScDOqTRHyCAp+/mCR8CEjLqt+fi/zBG4RA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Fri, 5 Feb 2021 22:33:37 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3825.020; Fri, 5 Feb 2021
 22:33:37 +0000
Date: Fri, 5 Feb 2021 17:33:33 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Update NV1x SR latency values"
Message-ID: <20210205223333.5z5jqgd3bvnc6tuf@outlook.office365.com>
References: <20210203190646.2024787-1-alexander.deucher@amd.com>
In-Reply-To: <20210203190646.2024787-1-alexander.deucher@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:70d6:9dbe:66d5:9030]
X-ClientProxiedBy: BN9PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:408:f5::34) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:70d6:9dbe:66d5:9030)
 by BN9PR03CA0299.namprd03.prod.outlook.com (2603:10b6:408:f5::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Fri, 5 Feb 2021 22:33:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2102140-edb0-4217-1cfb-08d8ca26140d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2583:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25832B2B31A348010E99A1CA98B29@DM5PR12MB2583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:198;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijsoI/jpA3DtuUJNIs/U28Vv12MTeBen8/YyISplRVGqhhArBJF1ql1TyEIMwBFijSZqkBa2c7/U8F7HI61zh0vL2IQ8/PbZnXnEj4GESyMF2hK2aEEQbzw3ksetAstpFrQgrw/Pz/x8IGbDHOChXrJRvYl9TOBznKPzrUO9g2nlNDSTNeS5GmIumhEoUtPookGFaj7IRfP0dizNqMOntjrtr6sPNv9TUQugrtTxhuOlG/Mia+IXBIOAsmNHlg5npDGBvOdTGbGLoTcsXQWdpvhK+Vomeobzr/kkaGfv9QsHD26TWp0uUbUSnkK/Qh9brTXiy6ArtnuCoSISdj+6FqQw/aqyUPaFrl2P0PkrX8kcgIJb8AuEJUzkPLhybufskL+DHDuE26VAHqJdsvN+0beaszvvnsd38CcbRKhrlMZ3TWA0ufwgEzXUManls++jz75v7nbBip+hW5RNeDfzfj+E/pJQykcfRrnHjvnfC8o7K+a1VKqTh4YHakqZPDbzGF0/dua7iEfMhAt2plMlpWRe7QxgsTSl110MbZNNgb7E7VPLkjw4eMyQ5VWZTT1isZw6/316oeV1Myl5y9nvcedrToxRxU2QSKgxk9HYS7jHmEriyVUTxRqk2BEjugL+jZLxjFYsEtJ5dpVbFxlsKzg4LGRDJorjlij9Bhw3NVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(54906003)(1076003)(2906002)(66556008)(5660300002)(186003)(83380400001)(7696005)(86362001)(9686003)(6666004)(6506007)(966005)(66476007)(8676002)(44144004)(52116002)(4326008)(16526019)(6916009)(55016002)(21480400003)(66946007)(478600001)(8936002)(316002)(32563001)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?o2Nx2xZH7SXjKY0e2ZOb9GyRvKJ+X+l6mQec8jfxcihv/KnsyXk4TYriNRat?=
 =?us-ascii?Q?KjTbIwawe1/MDqOGz5pUt0d8AeitHRyGAz0sQrR+EvrSVmdGoEowbUmxMr2s?=
 =?us-ascii?Q?wgNpOCxNe7Y+7wEH+erg/HVoyQpPwPbxGEDp6peKOYORGtOWXOOEswFcQYyi?=
 =?us-ascii?Q?sIuMKlkYcU3k0fpx+Ll0PAlh8gTBluoiZS6l0bW7kqO4yZMcxCptEmD2UmdM?=
 =?us-ascii?Q?uECQaYeyM2vC0ROSNO3kHOc0X5D1GsesgB53UFdiU8EVDv7WDaQC1UpoICD4?=
 =?us-ascii?Q?0KIHAd6fJF094A07YU+jMjK9Fs3kW5y+MQgBiELCGJEOP4ude/Rtdmj0r8CM?=
 =?us-ascii?Q?gv11SFp1/y0Axf0KlcPuZL3cn2LtvyThsV7wHWRWf4RKiaDQalzXDRqC1M9D?=
 =?us-ascii?Q?BGvcd0TZCmxnL9KDwMkJAC6PzepVuxbyjn9wM0mwCH4UmDGa4PxjGXv2Hkzo?=
 =?us-ascii?Q?0f2J/21ZzpgxfWgLFGKVAaBwcxGysmCB1US7FZCtDRSKYDx8kxxz2mOD+8f8?=
 =?us-ascii?Q?gxz6viv7p5LmL2jyAj6Y4e9WJsEAuy8tCigpwV2e/x9Vxbc03vzg75vVGmSd?=
 =?us-ascii?Q?Brt++9Fz99AGCsHLjSeN5GlQOTVttAm8OshMzDOagqFSXCtIY/jzk8WAjmJ2?=
 =?us-ascii?Q?DkJ+uczBCLLfhm0OF8BHJV0n50FJsQh9EBgwlJGyllWvfy92gIK4qIPx8vaK?=
 =?us-ascii?Q?EsqXI+6v67/qGbbFPHYA+v4CJBVy5WyLXu6ucIa71aEWxaE+wOkXWT5VaQI0?=
 =?us-ascii?Q?SSUa8EkhzSwrUUhJgs/dWDpx4SRjHgUv2eJgZIYDj3oZ5yst3+sXQJP4N2RO?=
 =?us-ascii?Q?fbE76lhkd5sCqO6WGm2S5qmK9+Sbs2ZodR/nBPE1Xl8xwHKR5FzLLqsfcfkz?=
 =?us-ascii?Q?sins8ksOYwmACBCql9USQJY+sDM9RgqlZJJpk7rkEARRBhLJUSHBqh8VRvw0?=
 =?us-ascii?Q?FDfgoEcS0xA5OtkNuTMFnc4KLuyMS1reqxQa/NsSSVsR+VDij00B9rVPB1uu?=
 =?us-ascii?Q?yMhAX7R0EJew5ftuEL8H2yLr0m0+PgNIKUgAP/SZaFWskXDX3pVMwn7+98Gs?=
 =?us-ascii?Q?bfuk/mZNmAQXTVwX2QTbih5+Sf8gKxHd78/XweWPON4b9QWBn3enk2ZkfOcr?=
 =?us-ascii?Q?Zqk6Lnd2c3nczmF4n4FnabfOslFcF5LM4Xz/Rq/bcMOJvqemrsoCsfnmKWku?=
 =?us-ascii?Q?iktByooB2NoFfDhzzsWo8gM4+wPSrbImJpn0RBkrr471LtPYUnPnbwLQ/FPx?=
 =?us-ascii?Q?+1Lgg9npsmiiUwheiq6+0Z7MQd/3bjQh9XTa9pL5Yt8JrpMyXVeYorqBd7a5?=
 =?us-ascii?Q?1Z6lmg7TwnMU95YMo+ToGb/8P5IT3C97KeP9p7UoWsKW8dwENOCfjpR/1DD+?=
 =?us-ascii?Q?RgEjbAuKUQh1xE4wiBHWeZIG/b+q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2102140-edb0-4217-1cfb-08d8ca26140d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:33:36.9605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P442rmX3ltnHLHrGPD+dlOGTKXC8v9CeP5gTbo3JekESqc9x7i9x6tlJVIhlz5aUImimRi9VKyrGYlEBteoMtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2583
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1859742667=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1859742667==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqz3cfzwp7bjxma3"
Content-Disposition: inline

--vqz3cfzwp7bjxma3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks Alex,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 02/03, Alex Deucher wrote:
> This reverts commit 4a3dea8932d3b1199680d2056dd91d31d94d70b7.
>=20
> This causes blank screens for some users.
>=20
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1388
> Cc: Alvin Lee <alvin.lee2@amd.com>
> Cc: Jun Lei <Jun.Lei@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index 064f158ce671..d94a1b3ac1fb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -297,8 +297,8 @@ static struct _vcs_dpi_soc_bounding_box_st dcn2_0_soc=
 =3D {
>  			},
>  		},
>  	.num_states =3D 5,
> -	.sr_exit_time_us =3D 11.6,
> -	.sr_enter_plus_exit_time_us =3D 13.9,
> +	.sr_exit_time_us =3D 8.6,
> +	.sr_enter_plus_exit_time_us =3D 10.9,
>  	.urgent_latency_us =3D 4.0,
>  	.urgent_latency_pixel_data_only_us =3D 4.0,
>  	.urgent_latency_pixel_mixed_with_vm_data_us =3D 4.0,
> --=20
> 2.29.2
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--vqz3cfzwp7bjxma3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmAdx7gACgkQWJzP/com
vP9SFA//c+7f7+bJXwYSIl0PTvpGcc2e0gEoUgMMP2waoCRanjI/6zSAgmF9frzS
UwfL+eKSVZDWRXjr1YIgypvw6HR0AGRp85bxAD1tUIbUlGcMPBm9ss2yE5dTdK7N
cAXVI/U4rOPFqUEaxXni6UDh0BeMDCoVAkQ67msRMOVC9r1AgTWhEXLVdKAo4f+q
7MZd5ZfTaIE7nRyVIASsfoC3Nam3SDlBROMY703r+fJ0/yTRYFhgnQ33tRBREm3h
v0Mwr+XRbBFxPcAohxhGK2NHDVHK4XWLGSH8F+ADERjRIXv758EGrFbawsAHSFKN
YkSyKndONi/OsvSL7XlVfjycbGdwG8jycdZxulrbyU1Rc1mpz2geKOj++MV+xrFp
+c3G5PLILUhdtQVgU/8tVur+vJ6R72InH9aRfMZIbwD9A3urFe88I2y6Alosxerg
L6TUO5befUg/BMlBPazVBZU6gep64qu//HS8hpuIaFEWvAr5s/mvPbjBnW+A65ro
oW1u/l7uyaXeIQ3VCefTnx1WqnkrRC9Cvg5LgRgbtKW3jLE0sITzvNcGuxaxjbgL
iqLYGFpT2gvJYMFiKYQOtNvqgbEckxoHEtfG7n1HwfON1FEVJaRfGs5S+wuCCsUX
R22XCRqEvpEMOsOU8IzgDW5U8VE2Gsd3uAWfn3DrSWVd1meeidQ=
=49lo
-----END PGP SIGNATURE-----

--vqz3cfzwp7bjxma3--

--===============1859742667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1859742667==--
