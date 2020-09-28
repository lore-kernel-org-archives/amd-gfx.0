Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B3AC2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 17:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AADF820757
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 17:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zqmUOYKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADF820757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F83989F8B;
	Mon, 28 Sep 2020 17:01:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C8B89F8B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 17:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCn6nvbktU3FiZgRM1LYSYggcYR73iOa/S+i3QSg9HnPKCNhgVAv3Iq4Z/dH/qS7eO4tn1/Y5rmZ9IUwxBJehN98EVhkcv4dwevXp9T0CTFll6sFc7jGCl3tN8cn99NTneWkRT2cBTPs86Fm/+UKzpBQS9Ce1Olz+S8RI8JtSdzX/nB8qnnz4OqhvPoITuXJMlqJe9uvQFVBvXMGCv+bUHGQ5yjyp+5h62+NVA15sF3q5fR7t57psQCLn9r+Z+e9gEt8ciZ7e7i64tg80ocmXd9mRaoY0Q3NROZCLV/kLbyagOdkYFCKqn1nVCGpafhgws0k20EL+kV9H4wy0rIGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBW1ZxTwBGlu8UCQGIAOyewXiLhq+OgRyvEPAESHmFM=;
 b=OZ7FiNEVb0STH8dF6gxeoC/DrYPHmkGh/SEPtIkpSuA5SWhZVwkdk37fheWPD9/MAU2Utptnw3HcEwSPBGAFun2BRe3Q9AGe+Cu4KrXVwzuIUdwrtXN6mK8mR5xBA3+F9iQ3hw64usi/FhcCc7vC4+uIgnEJWcTRHxTjRSIcf0TBqg/TxDMhIULolmEFfbG5kbT8wn3LbV3Q23J8F8Pyg67w70rLcNi3L9mMlVQ6lz9863J2UIpRrxkCBQCzBZb5L4Qw3zPSN/8z89J8QjfN2+3L02OHA61zDvVl2OzqCDMkm8yoJjLikkNRixtOq0v8Z4jPFhRnIhtxDAc4mdw2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBW1ZxTwBGlu8UCQGIAOyewXiLhq+OgRyvEPAESHmFM=;
 b=zqmUOYKm5+h1eQKNr6HErkrbm6TolfUyqb/zmq2atVpF/hvX+Fcl+Cs0rA0GtNTb2Nh1FG4wyufLkA2YnYkt3/kOdA1E5iwGEBOiYnGaHWrG8E7et/oMo8W9/1JJIHxaYwyeBqKQFOpXO/Nnhxeuiq6Z8Vx8VKPJftz3PjkZZ8I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB3578.namprd12.prod.outlook.com (2603:10b6:5:3c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Mon, 28 Sep
 2020 17:01:07 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.026; Mon, 28 Sep 2020
 17:01:07 +0000
Date: Mon, 28 Sep 2020 13:01:01 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH] amd/drm/display: avoid dcn3 on flip opp change for slave
 pipes
Message-ID: <20200928170101.hu7sv7lfebkseuo2@outlook.office365.com>
References: <20200928164653.276877-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200928164653.276877-1-Bhawanpreet.Lakha@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-ClientProxiedBy: YT1PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::31)
 To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::980e) by
 YT1PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 17:01:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f4139b5-e51a-4ef8-27bd-08d863d01789
X-MS-TrafficTypeDiagnostic: DM6PR12MB3578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB357820F80E5C0C2DD8841E1E98350@DM6PR12MB3578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnhozaoxwEzDpnQv288aOWq0VZorx+2ntMT+MC+Ot8RKbt0wFoRKm1i7SN7kmlNnWfQJO/3beeE0QpuOnno71yYnc2htoqYSyMKQMJy28lfQf6nSg+IB0fk71OZmLwmP21YmD52Qay56OoCSpM2g/ZX8ETVsTWo2zvImgBZRxDUc7MTL//nCLo6EDblYHYmN6rvj+TuZNGifqcL+MbsrdZVTVcsj4ONjPe2JC2gEfMMmbp4h8xlfzYGUxHOLWN3VI63jFethfFMT4zunmsOGFxchPjoOgMJ9/gPJN4nC7lCV39dt9x4EZZDi/wTeS4/X7q8c5acp3UVOqfrHIE+B1SzVe99J5H2bwtv72DYEjbQPHuiOfYvzwghLGExaX0pj2UYllPwok02w1r7A4WMn4/sPBdxvwL18xF3YhmKzB9MYkqrReTceLiUGcpvSfEzWDilaRRobsaTGzkWfU3TQotlyOEj7KDbjkh4Aub71r8ocfsfvFCBpUOPkGsrrg4FG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(316002)(9686003)(4326008)(2906002)(8676002)(86362001)(8936002)(6666004)(21480400003)(66946007)(478600001)(55016002)(5660300002)(16526019)(6506007)(186003)(6862004)(1076003)(83380400001)(44144004)(966005)(52116002)(7696005)(66556008)(6636002)(66476007)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dZ4vnOnSxCm7zrluMyGW11t8fFlEFQG6n5E0bbgkmmZrQTAXO1DYpfaQ/5TSEdCr56L29Srxtkbnh6qr4hTq0bCkRqECOevc2t89s6uqcTvgDh06BmzxPKnTvFFiofckOIIkSdDY0C23KkPRt8v5ZlDxkbFwTNg2udxAxoo+VZZdgANgspcVd70hv3Wzjsv94EbUfp9O+tHmtgPNmzfS8GILA2YeX4sbC8voSev7X64UtN3uzBiKiu4DxoWMSm9O54K7cmwv+3M3GYg/a6RbCK5tCnRsf66KMVYnD1tHhJoG9s0eprxQhYP8W4gV6cIWt2NgcbKT42xMAmkzleojzkugjYWprbtHHEA8tXkRYr3N8TRr0zpoo9zkSvzHyhG+PcbCC6dfUf4RoSGA8Xqc+3nprAu31/42U/MLYCECkCDR80YmiY/cq+7UgBEba9EgtITW2VRmXz5L4RVvSkmIyqiWJBX7wl167ETk595pAQ7UHXTYCTQoFkGszb570blSzz5ZaWPcZ9AtFlEJh17op22aBvmJX5YZpXoi+UUF3OhqyFT7h0fQlkW5mEWVYS7ib9d5cg70AGixZTDJ87mvf6PyXcrNabE75vJanxvcLqkO+JZz6TR4H2FcdjZ0ui/7kGwFlbAY9xPc1Albrm6EgIVgxAzPvYeJn++7WoM5Nip4gtN3cUCq8yRfGszf/Ugt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4139b5-e51a-4ef8-27bd-08d863d01789
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 17:01:07.4138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehnI+u7PEBGX5ThTtzqL3bz2jlkaC/iZooN/mKDsKi0etjBmTX8ARa93NkTTdTwJ4dXtpSyEvxLEZrTyfWwXJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3578
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
Cc: alexander.deucher@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 nicholas.kazlauskas@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============2059819905=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2059819905==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcebohtnmlimuksd"
Content-Disposition: inline

--pcebohtnmlimuksd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

LGTM,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 09/28, Bhawanpreet Lakha wrote:
> From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
>=20
> At the moment on flip opp reassignment does not work in all cases
> for non root pipes.
> This change simply makes sure we prefer pipes not used previously
> when splitting in dcn3.
>=20
> Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
> Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>  .../drm/amd/display/dc/dcn30/dcn30_resource.c | 43 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index dde87baf1370..60ee4062dc8c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -1899,6 +1899,41 @@ static bool dcn30_split_stream_for_mpc_or_odm(
>  	return true;
>  }
> =20
> +static struct pipe_ctx *dcn30_find_split_pipe(
> +		struct dc *dc,
> +		struct dc_state *context)
> +{
> +	struct pipe_ctx *pipe =3D NULL;
> +	int i;
> +
> +	for (i =3D dc->res_pool->pipe_count - 1; i >=3D 0; i--) {
> +		if (dc->current_state->res_ctx.pipe_ctx[i].top_pipe =3D=3D NULL
> +				&& dc->current_state->res_ctx.pipe_ctx[i].prev_odm_pipe =3D=3D NULL)=
 {
> +			if (context->res_ctx.pipe_ctx[i].stream =3D=3D NULL) {
> +				pipe =3D &context->res_ctx.pipe_ctx[i];
> +				pipe->pipe_idx =3D i;
> +				break;
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * May need to fix pipes getting tossed from 1 opp to another on flip
> +	 * Add for debugging transient underflow during topology updates:
> +	 * ASSERT(pipe);
> +	 */
> +	if (!pipe)
> +		for (i =3D dc->res_pool->pipe_count - 1; i >=3D 0; i--) {
> +			if (context->res_ctx.pipe_ctx[i].stream =3D=3D NULL) {
> +				pipe =3D &context->res_ctx.pipe_ctx[i];
> +				pipe->pipe_idx =3D i;
> +				break;
> +			}
> +		}
> +
> +	return pipe;
> +}
> +
>  static bool dcn30_internal_validate_bw(
>  		struct dc *dc,
>  		struct dc_state *context,
> @@ -2024,6 +2059,7 @@ static bool dcn30_internal_validate_bw(
>  				dcn20_release_dsc(&context->res_ctx, dc->res_pool, &pipe->stream_res=
=2Edsc);
>  			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
>  			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
> +			repopulate_pipes =3D true;
>  		} else if (pipe->top_pipe && pipe->top_pipe->plane_state =3D=3D pipe->=
plane_state) {
>  			struct pipe_ctx *top_pipe =3D pipe->top_pipe;
>  			struct pipe_ctx *bottom_pipe =3D pipe->bottom_pipe;
> @@ -2038,6 +2074,7 @@ static bool dcn30_internal_validate_bw(
>  			pipe->stream =3D NULL;
>  			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
>  			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
> +			repopulate_pipes =3D true;
>  		} else
>  			ASSERT(0); /* Should never try to merge master pipe */
> =20
> @@ -2058,7 +2095,7 @@ static bool dcn30_internal_validate_bw(
>  			continue;
> =20
>  		if (split[i]) {
> -			hsplit_pipe =3D find_idle_secondary_pipe(&context->res_ctx, dc->res_p=
ool, pipe);
> +			hsplit_pipe =3D dcn30_find_split_pipe(dc, context);
>  			ASSERT(hsplit_pipe);
>  			if (!hsplit_pipe)
>  				goto validate_fail;
> @@ -2072,7 +2109,7 @@ static bool dcn30_internal_validate_bw(
>  			repopulate_pipes =3D true;
>  		}
>  		if (split[i] =3D=3D 4) {
> -			struct pipe_ctx *pipe_4to1 =3D find_idle_secondary_pipe(&context->res=
_ctx, dc->res_pool, pipe);
> +			struct pipe_ctx *pipe_4to1 =3D dcn30_find_split_pipe(dc, context);
> =20
>  			ASSERT(pipe_4to1);
>  			if (!pipe_4to1)
> @@ -2083,7 +2120,7 @@ static bool dcn30_internal_validate_bw(
>  				goto validate_fail;
>  			newly_split[pipe_4to1->pipe_idx] =3D true;
> =20
> -			pipe_4to1 =3D find_idle_secondary_pipe(&context->res_ctx, dc->res_poo=
l, pipe);
> +			pipe_4to1 =3D dcn30_find_split_pipe(dc, context);
>  			ASSERT(pipe_4to1);
>  			if (!pipe_4to1)
>  				goto validate_fail;
> --=20
> 2.25.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--pcebohtnmlimuksd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl9yFskACgkQWJzP/com
vP8PBQ/8CEu8Frb84Djrmun/M4Y5fTtfxXYG8TTuX9d8ZikRnmhMkyeO4W77vlvI
KJQ6PEdlVPLZGa6wSlV3GW9eHVgCxlONapVa/PnWrrYzHW19IU/XlsLdHyUoNBFX
7sl6Bm94NliWlXJzQYkxGk1Z+6L3DsgKG/Rsu5KuGmo+s/HSLeK57pXvLquyNrFE
upFCN91pA7bymxg95Dxc1KYoNZQyaCReW+D7wHRdAUXZnVSOCsG0w9UuJhpOLbb/
f9266O6+pVIEnTfzNNWA1MOQaBOMlbLvYatlN7d/82hlGMF5wMvbHIrmNhs0mSsI
JZMHxkGaE8dNbIRFZkEcPGsjK8w7G9YL3TWOEsKqaM6peuEnE83stn0Y5DCjfSEr
BouxVrEziToSKr+RxEUty6y/8jxpVrGZ6tAAQ6q06BziIrR15uWmQavFYx3qdD1D
V2k2vz1LuIjgVePuLEmHMEPHjsiMerYnI/b6Unq/zwtRpC1hsumkxxWb6Z4bdwd0
mDsm9etuvaIKSCNp54l9LzgHEXOCTmwAROXOTlVwXwIsNfOL89HhjLYA96T95FMQ
Y5mSznfVNilR7raDpaxJBdWa4Vcp0HKgH876gmOHPrRs7+Joyr3Q07PS1QJL4bPi
udcKEHGHjN3TfdFw2TEO9e0Klo97vEyCplvN8p66g8ljS2CIYbI=
=PtEM
-----END PGP SIGNATURE-----

--pcebohtnmlimuksd--

--===============2059819905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2059819905==--
