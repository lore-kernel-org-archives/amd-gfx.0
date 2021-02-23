Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1588CC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 14:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD47B64DE7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 14:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD47B64DE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6800B6E9A9;
	Tue, 23 Feb 2021 14:13:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25F96E9A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 14:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KToPetwsB+JSZF+1aRbz5DHS7R2qnsvJKwHN2SEQAOQiUGhZy+XnfnISQwLPqA9mwNzKhyl36G4FeDNRTf62SJtfhtDWcDm57M2qHGIj7qODYKwZvGJgT30IaZ4T0MPMlvF0o2nu9jfUhqFEuONCSWbH8IgXk8pi0SL+0u3Ir5tQDAMNEpAAWdhq/ogunHz5jOxqjfmOkAtUR/XpVWPDULxOaybhwpAltoTENdW0qU1nCtRsxVrBsGR5G6zaKZs5lR6OdDHXg8YQlbxZBGg9M3gqgI8Bsm9K78B9Q/ZtBUi3mvUz6oZB9R13/UhVNfCMzFGyVCMPvKYsqUb4Vteurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULoN4LZKQDZj9nmQLp6va9O+DDVgR0Ee0vl1lCupo4c=;
 b=m9y25BsIEexbk1IIJXARMjOMg+PmT9outRJa3kAOf0k1q2Y+A15qVkzEvF6MqPqg9QVirkoaNhRVfoNeTmkoN3bwMGPZ6l6WPkxNN7gLwu4fpwyAMB7L9BvxkryTX+DYMMI5criiTaVSDNIP4r34SKxCJFOc8/Xs0nmLx+byYKh0t0mLSYzsT9i/icBqqda4BqCmjzRzqC8Efdpm2yQ2C8UOR0lAqV+xtJtkammBFLrJQdf14HgCZwE/7uThGd5qnuGfMyAvLCgdvD2etDw8l2zs40GWh+zy/rGYJFmt+dATuiNea1tNo/96E8gdeBDhe2J0pzCsYi1tGKPxezb5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULoN4LZKQDZj9nmQLp6va9O+DDVgR0Ee0vl1lCupo4c=;
 b=ov2qFU0qRCAOGka9Pxl+1/XCidqX3cidjd2p6GFt6YON/7UowfMIGTeFefNym5qVpsY/ym3L1zu7twJ3H9N3z4ODZyegxEeA9bEW72FawFfhQ0VFKIiJNkQHQ3jTMUHkEcEdLgkWy5GfXxUrihtLP3NP/LZahqGNHRaChFzQ2/k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB2779.namprd12.prod.outlook.com (2603:10b6:5:4f::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38; Tue, 23 Feb 2021 14:13:53 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 14:13:53 +0000
Date: Tue, 23 Feb 2021 09:13:49 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Stylon Wang <stylon.wang@amd.com>
Subject: Re: [PATCH] drm/amd/display: Enable ASSR in Linux DM
Message-ID: <20210223141349.xnbsc7mcrq2st3q3@outlook.office365.com>
References: <20210223103210.5148-1-stylon.wang@amd.com>
In-Reply-To: <20210223103210.5148-1-stylon.wang@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:d0f9:67b4:95b8:c568]
X-ClientProxiedBy: BN9PR03CA0471.namprd03.prod.outlook.com
 (2603:10b6:408:139::26) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:d0f9:67b4:95b8:c568)
 by BN9PR03CA0471.namprd03.prod.outlook.com (2603:10b6:408:139::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend
 Transport; Tue, 23 Feb 2021 14:13:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8f0de2c-4ff1-4835-c050-08d8d8053f91
X-MS-TrafficTypeDiagnostic: DM6PR12MB2779:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2779E121DD5B70352374A6E298809@DM6PR12MB2779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbXsYE2UKzwUykCmlFUIqH8PXm3a2EPbNYlTibLekhNW+rWa6ScYUiIggrWmKfnZBtA1yWBcEpF+7Zxth5l590OwjKokOF7yr08Hz1VM4UjwfKxPRb6dUZH0vxlQmr4lM3RUY2k0J4h9cWVBvFcGmHHrVsjq8f+bPNqicYBCFfdduvSKOYG6wXBQWrG2853sLsbxZYKVHzLlqTj10yJxWWSKjRbuL4H0nftEe+xehnqxv51q/Uax7NOoLSV9dDSKIg4mYhiybfBAj2+Fz5cF4BuxDDoMtXI6zV9CIMsCOf8cpLbPwydMwlsEzPiFbdSGiTzgsWdqYay9ihJ1owKyNmj4AeRGyK8BnNkNNIzA9/tHL20cOhZ994oI8bHw+MJS1fReYV/EGd0kkhajV3qH8eafNTfQ2GK3TzJYN8Y+kBC1IHbMgJAcmRA6ejnmklF0I9PTS18Sm+xWKcU6H9WP/IMiW02hiQpj0K+EQ10CtFNSGtzPb5b3dJ4IV7YMICPm1M3tTJRvc8vQaDcrvdCgz9eO1KOnWwtHXtAosd6QxaWGci4cLM2eIKnWuCmX3H3PMmuxAsxr+2cYlR55mMIjJtlrhxCnrC6XVJkXIPTXzWcjRvVt7ur2JWboLz8NEmCYPW36BccytcthI457Xftd+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(8676002)(66946007)(8936002)(66476007)(5660300002)(4326008)(66556008)(6666004)(1076003)(44144004)(52116002)(7696005)(86362001)(6636002)(478600001)(55016002)(2906002)(6506007)(316002)(16526019)(186003)(9686003)(83380400001)(6862004)(966005)(21480400003)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QG/zumdfplH5hazlk0c5RH4XpRH2JApaSx+lo8tWebkP9aXgkQE4YTpexvVW?=
 =?us-ascii?Q?xWcol77/K34ZaBntGO5EQHULYNdVfYU03kZszd0VjHPfckmiXEYQgdaVszK7?=
 =?us-ascii?Q?q/ZKle3O6b2kcxjxW62uGyqRMgEJgYhKg/OdCPwEeaP0O8vhxZlDJPIvpyq3?=
 =?us-ascii?Q?m+m2LmgS7TbHwb5OvWkb54vR7j1OfILI8hKlQBpGU/o+24rLNOduW07jBhMZ?=
 =?us-ascii?Q?weMbEnv+y5gUXliczXzWtp5CN8nuhjv6995ue56ZLRVG3w1ZQo/gE4++b/m1?=
 =?us-ascii?Q?t4PDm2KZJvw3UgcH2HjCRniKW7jvFVCZBCc5G/7cPMxpYXyR6BFzhEV216Pz?=
 =?us-ascii?Q?xRRSgY8m3UC0/Pw0lRTlrSu8S/7r2ZiiE1QLEX+fKjVsyAtjNF7t497JaCjd?=
 =?us-ascii?Q?DGiaM0lT9qTwtWa+MWMlVvYfZJGe32aU3nKZIziRZp9zAt90hACvXZTA8GR2?=
 =?us-ascii?Q?x8ZV9eNZWCWyyMKeGpfHSjEQ53qYZLDU/5Z6Xm3ssVUe96hhatUhrPyVQ4vU?=
 =?us-ascii?Q?Goq8XQt5j7ljlfxjACJt+7nAdfIKz4N/jdlYEpdJtmx44ncvyNjM6hm3jg/H?=
 =?us-ascii?Q?iFJkUfyxdPvIx/QFKGb0aWPYZ3i3YIXUE+TmEyTocL9XiVj+z4rTig1pUHif?=
 =?us-ascii?Q?SBE5YtlDQ9eOT+SFpqRYKICNLFbOqdwVfxcJwe+/k6UpNkiSfZ31DqS+m++2?=
 =?us-ascii?Q?Wh0kosIMxYSA6aXwsUzDt3WxJsiHN6bdOnCiIo6D11tp3R9PNQ6f407yiyZT?=
 =?us-ascii?Q?D8gWRryHh3DPuVao0GuWTA7ISdPkbJDMPCKAul+i/NQj6/TvK52foQKRmiLw?=
 =?us-ascii?Q?Vo1NoL25ZUbNhGq61etnocZZySkd/3IBIkJhAXbwtbdv5lArLG9IlqXOJ+Wp?=
 =?us-ascii?Q?oiYJBh14N0QxLxLAoaygXXz0zq+e5jrM2IKEHKhYJjPya4BU3JFx4KtRtjmx?=
 =?us-ascii?Q?3e+HsOFaijIqVJ8bKYVlL8NnhOrRQoFZ+oVGQiYfd/ZFL4QhKH02s5yoC8P7?=
 =?us-ascii?Q?E4NlhcM+aSdvDMQyjZ3gTq5/HZQ9I8h1XYQYqel5SzvgVm2oWGnLAHExyiMe?=
 =?us-ascii?Q?PzNP7Fg04UX+JRHN71ITT2ncXbhxuXXMrJ/VON0313Yxfuzw/G3BAiQc9aDQ?=
 =?us-ascii?Q?Kkt7MCZoiAG37bnb/0nbA10Lh6Agmj2wVSYp6RcaYxiTelFky2lDWOAkWBaN?=
 =?us-ascii?Q?t3vyX6nRIFZ8Zburf/v8+hzOHxfmOcdUlZIAMC+BXpZFI0B/8Kgl1n3WooyK?=
 =?us-ascii?Q?nVnXlT+ekbqBCBhPs+bCIoASGnwoPu99+vMpA6ZLDklrhoj6USMlfKXCQsa/?=
 =?us-ascii?Q?WkAaaQyhDDr3XNrmclyDZQwUZ0ytp1XJVdG7ZE6MvDSY3hGkFheuJoJWvOn8?=
 =?us-ascii?Q?VkuFvmcHE+UIru2ene71eThnTxX5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f0de2c-4ff1-4835-c050-08d8d8053f91
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 14:13:52.9705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJNeJJDXVKm4nbfDRTt2JjgN6rmkAlFTlcq0h9aaw38Z4YC1wFB7tYWN0j4ZBkYom4NI6ouvCXm0CGK9oN/blw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2779
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============2098338701=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2098338701==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n2lfblsk4lmrwxp3"
Content-Disposition: inline

--n2lfblsk4lmrwxp3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02/23, Stylon Wang wrote:
> ASSR implementation was already in DC and DM guarded by
> CONFIG_DRM_AMD_DC_HDCP. This patch enables ASSR if display
> declares such support in DPCD.
>=20
> Signed-off-by: Stylon Wang <stylon.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/g=
pu/drm/amd/display/dc/core/dc_link_dp.c
> index c1391bfb7a9b..099f43709060 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -1669,6 +1669,22 @@ bool perform_link_training_with_retries(
>  			msleep(delay_dp_power_up_in_ms);
>  		}
> =20
> +#ifdef CONFIG_DRM_AMD_DC_HDCP
> +		if (panel_mode =3D=3D DP_PANEL_MODE_EDP) {
> +			struct cp_psp *cp_psp =3D &stream->ctx->cp_psp;
> +
> +			if (cp_psp && cp_psp->funcs.enable_assr) {
> +				if (!cp_psp->funcs.enable_assr(cp_psp->handle, link)) {
> +					/* since eDP implies ASSR on, change panel
> +					 * mode to disable ASSR
> +					 */
> +					panel_mode =3D DP_PANEL_MODE_DEFAULT;
> +				}
> +			} else
> +				panel_mode =3D DP_PANEL_MODE_DEFAULT;
> +		}
> +#endif
> +
>  		dp_set_panel_mode(link, panel_mode);
> =20
>  		if (link->aux_access_disabled) {
> --=20
> 2.25.1
>=20

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

--=20
Rodrigo Siqueira
https://siqueira.tech

--n2lfblsk4lmrwxp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmA1DZkACgkQWJzP/com
vP9Yvw//T9rqMO/2WMtR3ucRqY4uNR98fNVBbcm/J2dF5vkoXkiMlU4Lt9Yh0+YU
WpJyWaeFbJawBXJ+QvyntGrztH+xqLwrHn1ZO3RrhUPvoRFni2NCzef8EMjK3sXE
PAVviV6YEzwtFMK1gjS63itZjIQTyF9RxmfnbgeTUT/caVSvWuWU78wgqmJ0XoOP
5Uh4SIH8NsjirxGSGFdob9hz73WGj5VZD862/OXgug/dqeyqHCi3qKzjaiKfDs59
r+ZOtufLXGnPs6rAJ11ivtXGy5HJNaMFPqpGQWj9Ae4C/aQs3lfsKe+DaWpeBQqT
AH0BuhJiJ2x4EKCli7FC4jAGuhwJweHZY6KwemFPh9li6d9fAXL8IzCjCis4utBB
SbScHVfVh2znB7Ec1KghGcksrPdwl42pQvvnQ+Y25y0daM1VDMAlJXIOZ3Q29Ck3
LfVCEIpHPbxegNJkURilsEhDwskj0qFc1yo1DP46DKo9BWYNphNKEENVMnbpbwYy
ntzGlTI5RZRDI0adeo8LXRIg52aUVg7gXnZ3Bb+PXo7Pu2uvWQek4Ykh9k2V2+dn
fUMSZJwCJa9O+BvwSqgD3Qij/4V5JBgijozjF67GSEKz9hPwH13vHTiP9k6mSWzK
bEk0BrQbSH7S2Dfxhwq43rN0/pYF4IP7aI5f9oHQk2+MUPILMpU=
=HrRB
-----END PGP SIGNATURE-----

--n2lfblsk4lmrwxp3--

--===============2098338701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2098338701==--
