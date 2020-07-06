Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92940C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 18:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E44420771
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 18:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kxEnsK4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E44420771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAB26E0F4;
	Mon,  6 Jul 2020 18:45:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E0C6E0F4
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 18:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzplJa9H5mZJ5K+DA338ZGjM4Fi+EB5KYjFKCCCgysAmVOvDXgNmG2Yrrf9znIPMZo2Mll31O0DQoKrj9Uw9hMAkuTNCKHN7l0h49Yk9XS0Q2VWKqon4KbRegDgMzppmKq/SvqTrHyLWS9q2u34RH0gAZTXked7dsvO7ethK8lgnDU8FNxbU4TvvGyuP5kLf6Wt7CFkup+ZixzdumXNZvXudDILFv5x+UEMWv6PfLISp6RH8bCTPxs9MF+a6gmrBbuJPC4ZBS0f7n3JbrYS4nUijJXCbVXkrVcLmzO9i3MPaD1mT9FAJrFjHmf4JQSX95JV20lfFR5bMDk1rMO1C+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISHNjMBSu6fbN9VW4KUUqdQrVpunXf5Eo6FNd9XpNL4=;
 b=PSt9pEAQyYp4pWgd8V9IIj/endYyCFze7dCYeqVDgod7aXvsuEhKyWfUiK0nA/t+vWIxJ2FdO5CqE4Xxygrb7jwzgbfl+3km4cMXiCshgrZqFJ7kyJcLrDw/sTmqz7dAc84HRibs76dBgzyuid47XSln1yPtUDAjeXsEa4fVYZ1sIPacVpbmEH8Y2Nc9nO9jnotOLAWLgEtp5D9Mos2JJ7I+pc1tZbP0U7jGnLeCVL9+4K5nDCPCCaqJY3BeVdTSw+v1yw3fxHc70Q/SNU9fM7wC/VAMFDNVeFSAmPy6Sotzwv7GJ/KTbRuzbjNACK6J4+EeizEjHSP7urUBDBt2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISHNjMBSu6fbN9VW4KUUqdQrVpunXf5Eo6FNd9XpNL4=;
 b=kxEnsK4wXQ2Irx4K8JYr6HYfrPlSU5han/TpvkE5Gp/eYHOyVqeJHBUoNlb0IqA2ls633P0/kaQtEv3YJw6IY+UtAkkJPliCSlf6snz28dLvJBCcmbNzqc5zUZ/E8TL9kSDwiDN67Ba6VPLxiGPecquVIwLtnxPCURkSDcE5MWk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3767.namprd12.prod.outlook.com (2603:10b6:610:26::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 18:45:47 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%8]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 18:45:47 +0000
Date: Mon, 6 Jul 2020 14:45:38 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH 1/1] drm/amd/display: Add missing reg mask for dcn3
Message-ID: <20200706184538.omoami4qp6oakbnh@outlook.office365.com>
References: <20200702184813.20695-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200702184813.20695-1-Bhawanpreet.Lakha@amd.com>
X-ClientProxiedBy: YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::8) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56a0:f5c::9) by
 YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Mon, 6 Jul 2020 18:45:47 +0000
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98b85b56-4c4e-4017-c6f3-08d821dccc1f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3767E3420965C9713DD26F7298690@CH2PR12MB3767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6EyRvZgJNJV4GHp3ocdTgIHZGc6GKhT7GiDZs5VdnpRnf0WwcLCGj4t3HIPWEFKE7U55Fe/0xPM/R77KvvNS3Te9MXpJUOU38kpvb9koN0L13hDmjNViXhtW1vBvfofvZzQp/rUYHEq8unaf3B9O+WSgeCmPNpSa+wzCJrbNGyp+Ff4iq/9qeS8w816UmvrsbTO6lRV3e46p+3Q1m6BUevhVWUnHugi1ryF4jrDei6oMImaWLb4XFY2bq0yFB3RogcUT5Zctj7V11txJuucqH3/NQGOgkHxgoQiHMewTTEFHHrd5wvgU5Bi2DVOeuzPW71lSUnNiZdRDiEBgLDW/guvf3yiUxkejnrGd1kAqz1IzzORjU5LoN04628vg0nH0yEOkWNAq7G6t96skScU27SCG3+QxOGiG5y1nxJmEo4R/GtY6Db1FHgEtF6fntR9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(21480400003)(6666004)(186003)(16526019)(66946007)(8936002)(6506007)(66556008)(66476007)(4326008)(5660300002)(2906002)(6636002)(55016002)(9686003)(1076003)(44144004)(86362001)(316002)(45080400002)(83380400001)(478600001)(52116002)(966005)(7696005)(8676002)(6862004)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zE44h3pTA/660NqUfxUgqW9xqj2F2Wsb15UdLOq7wiWsbifKXsNjudEYHSlGwcqmWY5lUyClNlkpSWiFDVaygUZMXld9pDoTzbvSYk1lNlX2KMAsnYMvHbW02OJqSv3Y2fT5NwcvEapHDGMrCKxN+LZ4pD2RcizNioy7856KMsPhP2ZMLqU6ZRdXm9qgpXqNAfQO6sih/Om9eVn9KYkGmmf28g8y82WjS6EK5Wig6va1y3F8Lwyj9uLO9eU6vazrMqmZXUk+vYTC4niyymibapSqwgFRB3+6EF4VKxq7ZMg+3jMPWSsZZBafmwYFZdRZyXgPIXwiPxqaHgDIMLjNOrHIk15MmpONEKHolbJCsjTKVCmqRGHIP1yV9pcuFRsm26Aap4yZTYwxbWw63XIBY6J3bhQXf1PiOpVl02mMIH4eUr4ZFzxAl2bPEiq80+hy/8oYLQkZnsR0a1jzgs8jWyDW8SAbIH+0E0WANbqe4N4tN/RHbUiC6AfzfD1ncv23
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b85b56-4c4e-4017-c6f3-08d821dccc1f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 18:45:47.5883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxCr9AzjL7IpPXtQ20belMrc3yMSqf+s5J8vMksPkO6HvE/IXHFnrqslW5TMl8omnmYFEbNfg2odj+F+oBmcGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3767
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com,
 nicholas.kazlauskas@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1995233659=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1995233659==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r2diq32uascbg5w4"
Content-Disposition: inline

--r2diq32uascbg5w4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

LGTM

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 07/02, Bhawanpreet Lakha wrote:
> This mask is missing for dcn3 so add it from dcn20.
>=20
> enc2_set_dynamic_metadata() trys to sets this and we get a
> generic_reg warning since the mask is not defined.
>=20
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encode=
r.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
> index 8db6d76a1131..0b1755f1dea8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
> @@ -248,6 +248,7 @@
>  	SE_SF(DIG0_HDMI_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_ENABLE, m=
ask_sh),\
>  	SE_SF(DIG0_HDMI_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_LINE_REFE=
RENCE, mask_sh),\
>  	SE_SF(DIG0_HDMI_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_LINE, mas=
k_sh),\
> +	SE_SF(DIG0_DIG_FE_CNTL, DOLBY_VISION_EN, mask_sh),\
>  	SE_SF(DP0_DP_PIXEL_FORMAT, DP_PIXEL_COMBINE, mask_sh),\
>  	SE_SF(DP0_DP_SEC_FRAMING4, DP_SST_SDP_SPLITTING, mask_sh),\
>  	SE_SF(DIG0_DIG_CLOCK_PATTERN, DIG_CLOCK_PATTERN, mask_sh)
> --=20
> 2.17.1
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7Cea136365bcba44984d5008d81eb88106%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637293125094897456&amp;sdata=3DuF9l0dF%2Fi7KQNa=
JrWSiQCdZENWN6WNHL7vzarGTTc54%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--r2diq32uascbg5w4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl8DcUwACgkQWJzP/com
vP+SeRAAi8Ci0UNoJ8jHe7bkYVNOieWE8KQYonSpNCoz/IJIm1SfCCmrqGAvN/FJ
3MUtRGrH0GG24vebVpEQw+rVYopzUBDLEdUPrIctq131Nt05p3Ne4+UXb+Xm8bpz
IxngX6AROlaZiLggxnK+oD0Qp0QFun7Hq7rLRonAWzjT5+S//fcC+MZICWye2sU7
/SF116zKwcbGetJp5ZkI3zhORpAixKNdJZuNCkEAXco9bMAZUFKlSV+n1W0djF4p
My26p9bPR3S3GGDxpLvXJDDqXd5Xd7udhz2pjViNTh4lWOnEgP480jY2SDNpS0Hw
xyMd3s5JCaB4vq7scVueO5kGTvsdLLSCAXloWCAYssXj4dq2++Pw65GcRxbfzwSF
EKRTIGYmxOwApkoOT8f6c2zRe4uUEJ1aWOVIOSFcaCh3FQwgZ0VPZEag9a8SwsGq
C5WHyAXyPS8Upsflm/oDZu0lzpC0hXrXX13FMAcGpIaXCHgpyOfNLkQLt+G8w8yc
CCGGtyOASCKK7B6RTPFrIeIbPkNx0Lcxt7gMQptBcao6ZJQ94wQwXTlVlnX1LlM/
YjV5FERsf7WJxTQEHWElNG7TokfcGtCJQMZzN0OrTGm/ZF2VMnhoqVNSn3JLWyiP
JffQNoN1FoHhR2gBnm4irIOkZTMh6lIdapPkI6JD/ZWRKVL9LwQ=
=0lRG
-----END PGP SIGNATURE-----

--r2diq32uascbg5w4--

--===============1995233659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1995233659==--
