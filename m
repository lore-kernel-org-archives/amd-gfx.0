Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC8AC2BA17
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D829206B8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e+BM4YJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D829206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 124CD6E489;
	Mon,  6 Apr 2020 18:44:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A4B6E489
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 18:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtEONX6Txcfo8yn0eJsc2DQYy0ZhJi5kqyQGaTGDPvqQQcbu8fxA2Ogh7f76jyp8WHYd1+FYaSGj8F5kfyqW3jblRN1DHP6SJgE3rnMcpsTPsE7bypWEe49odMfxDymW87NBDlWysgYl0m6eBPublQvnLIF5fxjS0bkvdxzrUkxsi9W8rtKO0KczA+pz3hlcVaNbXWGwejQC6F/RxatRGsGGxjldxc72dAAigy2QELv6OWTLv5ZUGM9L872+2vEODGyk7KiZDzp5KkOIx/KgNu9fOZt82Ppal3cWBkcDn3SglgyR9vfDgSJqgMWmSt3UFAS7uCrAAsTQCHHmND+ZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0+b3VqlttPg152bIm1E/M0a0n9T2R3opFyhztF6mtw=;
 b=diMZAKSQnBwdr0L13foB/kjby2Egf5oXPdSSbeTT0Ko1b03zqxjzi/Y8IMf/1kniFj79D8bnjfyRNGH0Nf6cx9zPkuyD6EopBWgIxolrDlAaxwSNlc83NlDrlzr+WHXVhnRD8Z+SRCWeEzVlx4nxLtWMDL7Ep1pocRbZ5yfEfyvJ1TQDz6x3BiX57A5h3aiafhMIiknD/9aj3SN4rJQAgH95OhMM9hvQaVZi24HYyKiLhTItsJMBy2qWgQi7UQdA2iNxPLakeFZKL9r3crip5h/Kk+KRoG3UsaES0gOhl29+M8gdkNOWNGT+vJnIdjZROjwto1tSh7SrrZNfaFo9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0+b3VqlttPg152bIm1E/M0a0n9T2R3opFyhztF6mtw=;
 b=e+BM4YJRZ6GzXMUD7n/e792FZjuKba+3fkLHk8OLrwzUNraJ9Xf6Dva06Xv/CqSO3gQNzTQL1hl9ozi0fbqcMukpxdPxlwLnizLTdy6ZmjvcMBg5UJD1FhgvN4+MpdZVgc78RNrrfXiK3GvbfjvYkSfpwDlcJilcQZAlYaeFRuA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2442.namprd12.prod.outlook.com (2603:10b6:907:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 6 Apr
 2020 18:44:25 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 18:44:25 +0000
Date: Mon, 6 Apr 2020 14:44:21 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 30/36] drm/amd/display: Avoid create MST prop after
 registration
Message-ID: <20200406184421.ez2tll7llob3s6pb@outlook.office365.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
 <20200405204115.683559-31-Rodrigo.Siqueira@amd.com>
 <e6066d48-7666-50b6-c3c7-0e910b4ba3d4@daenzer.net>
In-Reply-To: <e6066d48-7666-50b6-c3c7-0e910b4ba3d4@daenzer.net>
X-ClientProxiedBy: BN6PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:404:5f::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56a0:11a1::4) by
 BN6PR02CA0039.namprd02.prod.outlook.com (2603:10b6:404:5f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Mon, 6 Apr 2020 18:44:23 +0000
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e68c0a2-027b-45c5-9ec5-08d7da5a873e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2442:|MW2PR12MB2442:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24420C79FA38814C9A6F9DEC98C20@MW2PR12MB2442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(66946007)(66556008)(16526019)(45080400002)(86362001)(81166006)(66476007)(55016002)(478600001)(8936002)(5660300002)(4326008)(21480400003)(7696005)(316002)(186003)(9686003)(8676002)(54906003)(966005)(6916009)(44144004)(6506007)(1076003)(81156014)(53546011)(2906002)(52116002)(2700100001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVEABbpKd4GAsJdbKPueYqLOdpNutUp6A10V+P/Tt8TWoCESkzh86VBaRp1XE5AZq3v9pw8VnxAHedsSby+CclO01fgBHywcx0CXYlQ7H08wQCfZU3gBjKjunRCrZY3IQyaifepxRnOcuBSRnTnN3CJxA3PZowqYtm1c9slj55ou5ax16sMDNRO2LfzDOQ+upOWWwEtOaWcRktymCI3UryZMknaBCxfH63hc6f+jA0sL/51gJ4CSpIkUkM4zImZqDdtN+pOYw8jG7H2BeCH/fyjCVpNVKw0PphWuOgKgYRjvhVf7o7roCwqKBkTC8PyGr4h8Y4t2ZlyBjR2E2ss7wP/6sX61znqnn/gzZNZN9RZc+XTVIQWRRqu5Nnxqr6Yl+JYhY7PCh5sm4er3VsrRBvD4s9AXwLO6Czlrpas2N4ICrs4COe3OPuKlU8LCkvqY4PDasI9Rljp1NPI1JRrnB++eJz50+ImODr7sq0TALmCI3K1HkJgtJhYwGrBnn6hLt1iynQI90cBd6Ulh8RtpfsJQEhpammZZdUUMZ1/cozCd/IvYIkohQjv2qEsy3Vdd
X-MS-Exchange-AntiSpam-MessageData: v9X1ayKBzbcULEkICMVhMCEQqraUfHe+6AYVeayee1LZIFfon1T8CxYplupJ/C3WDgl0oc8465Pxq8Pl2LxSq78JC81+JOrVO32Iaef/rpyBa3YM31rTBADEgC2fPuHqMsUn2l3BDe4C6x6U+qsKra/FLDgG8Nzje/qSbbn5vAM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e68c0a2-027b-45c5-9ec5-08d7da5a873e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 18:44:24.9533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0BvlS8BqH7CO/axr3VpXJAusi5Zrmxiu2jVeFp9cntDWwIPpSgUdEzZ3v1GDWIssfbgylIt1VxO1xXBTLMKDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2442
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 amd-gfx@lists.freedesktop.org, "Jerry \(Fangzhi\) Zuo" <Jerry.Zuo@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Harry.Wentland@amd.com
Content-Type: multipart/mixed; boundary="===============0549450654=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0549450654==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xqn4stx7px42qeiy"
Content-Disposition: inline

--xqn4stx7px42qeiy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michel,

I'm going to apply the patchset by the end of the day at AMD repository.
Is that ok for you? Or do you need this patch on drm-misc-next?

Best Regards

On 04/06, Michel D=E4nzer wrote:
> On 2020-04-05 10:41 p.m., Rodrigo Siqueira wrote:
> > From: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>
> >=20
> > [Why]
> > Prop are created at boot stage, and not allowed to create new prop
> > after device registration.
> >=20
> > [How]
> > Reuse the connector property from SST if exist.
> >=20
> > Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
> > Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
> > Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> This patch is needed in 5.7, or one gets the WARNINGs I reported in
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Farchives%2Famd-gfx%2F2020-April%2F048017.html&amp;data=
=3D02%7C01%7CRodrigo.Siqueira%40amd.com%7C82562d6efc6a4c85afd108d7da3c7490%=
7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637217825519023312&amp;sdata=
=3Dh7ZVldKMgP%2FWkMVpjn%2BX6fytKoNZi24lFjOdS3QMUts%3D&amp;reserved=3D0
> when an MST display is connected.
>=20
> Note that this patch doesn't fix all of those, there's also one
> triggered by dm_dp_add_mst_connector =3D> drm_encoder_init.
>=20
>  git grep mst_encoders drivers/gpu/drm/i915/
>=20
> shows how the i915 driver deals with this.
>=20
> Can you guys take care of that for 5.7 as well?
>=20
>=20
> --=20
> Earthling Michel D=E4nzer               |               https://nam11.saf=
elinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;data=
=3D02%7C01%7CRodrigo.Siqueira%40amd.com%7C82562d6efc6a4c85afd108d7da3c7490%=
7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637217825519028304&amp;sdata=
=3Dh9fm4x4B3Kn1U4bloZbLeZTbjygZCHIgoyroaEW9%2B3s%3D&amp;reserved=3D0
> Libre software enthusiast             |             Mesa and X developer

--=20
Rodrigo Siqueira
https://siqueira.tech

--xqn4stx7px42qeiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl6LeIEACgkQWJzP/com
vP/c2RAAuNuk9ZUWSs4UK+jQNjPsWwAjqhxACrgEuhMGxuHlg1O/8fRR7RWhi/Tg
KG7gr0VU7lMtDOKT05u45BxJwD9oAlD454qKCUG+5SfJz7vfkljZYvjHspJLDGtb
fDhXDP2xKb9QbwGiON74DaFFPEVWvs53iUKfNdk5AVAmCs+GxEq3EI2yhkrldxTh
Rg04iDjUMIJK9NjQkhyIylX0kHfhf8bLCVfwTRGEUnFiQhTLiwDAPGfri23fCg8J
mdY5XPFDbZgXEMCQymbDN7dyx6GtYuFtsMarZgBFkG494T5nHTw/wecDB7LaGGeS
vXkP9IgiPSx2kQEc1is1Uon+dxMRylWB+fD5K2vzoXqjCDcOm2+h9nzeaunmK7NU
oHiqugAgBO+ibSc9wMNWv5PX/74pow9WORs4TTRLCKdSlsveWUhdIvocb5rFOQe6
ieFSL1OIpCGVI7FXnP9nrBjdn+UYEwRa/Bg91s5WWVQQjsoXVKNh+9Eq6jlSXnbB
Mvp39EyHV4bLgZVgGPflI3lO3Fb2Jk1pQh1MIN+gHIix3m0CvAZ8fTyCDH7B0dMo
QdHxJUHmbB+rUGWmZEGosSxYnwo+d6KpmPXQC6c2DTD8watjMLm4xqHrqD2KRE85
NT0983upt7xgFFGaznN5MFbK3lh5jOK24uFPJqZ2w4COWPebhWo=
=r3/0
-----END PGP SIGNATURE-----

--xqn4stx7px42qeiy--

--===============0549450654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0549450654==--
