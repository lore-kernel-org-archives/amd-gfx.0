Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5575CC2BA17
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C888206B8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3sXJBvNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C888206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D47266E488;
	Mon,  6 Apr 2020 18:52:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5FD189C55
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 18:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJKY7wWor2CmZqGBo1BOru4o5QNz7cta88mnOcVIIZVPEYOpBYQOb1m6Rm3P1TZoYeifKjRp7VjXEjOuARffyb5UqTlo+aZSbk+xB8cVFTUd8sFhrEJvFAIOGMb4OIe0q1A1V1GvvDAj+1Mow8oAX6SCB1j1YkK903/e5DMo9d70DLwPxf/fE4Hs9SQzq41HkNvV/VqRlUCPaUewgutGACVbbYGqwMnqn0cgeBRveWKOZNBi+hOEIx6F2lhU9tCyrVUR7ssOG4egfOOTFrm8Ao3p6/jqmgtQa7qnu6tCx9yKs7Iar5yhQ46K39GNI1nw0HQJm7C3yaGm1Ku+BsgXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDj+DmLInkmsb/ZHDZV99dm5O8JnyEABx5a7l9q3gE4=;
 b=J9Ecs/iJafVVaGSNRo5S1MBnH9+HDbyRl1EmF3FjvwKt57E2DGOvGsW3acKzUp5vU2xLLnRY7Gs1xM9dhAgbRuLhuB1Xlc2xFvi6I4vga/ZCMsHIadCFW+wH7pnbAt6btWEOsdQoMZDTid84USuE/a/7UR0PGZr+JGqNDLSfvGTR9L+dw70GDwrXChWtIPi3SvOYkvVh2GktDm647fexNPay9MIV9YWknT530DDUgXyOB49ALywtgDQdTfOtAwwLRoMoqGbgA3RPiYjJbf/00lXb6J+E1g4CedBuvoAZyOr0Oj0Jm3RQCslaowlG2sJi+ds1+RUYUASnJvLwOpKkQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDj+DmLInkmsb/ZHDZV99dm5O8JnyEABx5a7l9q3gE4=;
 b=3sXJBvNdHpQcrR3v9aLhr0GnQO5Ai8cXoSiVlhJSY5hcmYq5DVeQ/EWJXG/A0VHtq5P5oXPq9MPH1GdnUlcgW19QRf8h7ybPvrYBtSLNL9K41VLV7bRnK/FjTd62kRe7lcd9XkpAl3lEtv4kAAlUk2ECyKwuTDLYGMfTqvGq8Bo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Mon, 6 Apr
 2020 18:52:26 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 18:52:26 +0000
Date: Mon, 6 Apr 2020 14:52:23 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 30/36] drm/amd/display: Avoid create MST prop after
 registration
Message-ID: <20200406185223.abr6gn7onveknnyv@outlook.office365.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
 <20200405204115.683559-31-Rodrigo.Siqueira@amd.com>
 <e6066d48-7666-50b6-c3c7-0e910b4ba3d4@daenzer.net>
 <20200406184421.ez2tll7llob3s6pb@outlook.office365.com>
 <CADnq5_NBpsW5ZnfiFM3ttmLHPZ7-nZP7AhE098W8Zz=YaOhszQ@mail.gmail.com>
In-Reply-To: <CADnq5_NBpsW5ZnfiFM3ttmLHPZ7-nZP7AhE098W8Zz=YaOhszQ@mail.gmail.com>
X-ClientProxiedBy: BN7PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:408:20::30) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56a0:11a1::4) by
 BN7PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:20::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.19 via Frontend Transport; Mon, 6 Apr 2020 18:52:25 +0000
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ab462aa-0dc6-4a29-3adc-08d7da5ba645
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:|MW2PR12MB2441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24411D25ED63CA8518042CEE98C20@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(16526019)(66476007)(8676002)(66556008)(86362001)(66946007)(9686003)(1076003)(55016002)(5660300002)(478600001)(21480400003)(54906003)(52116002)(186003)(81156014)(81166006)(316002)(7696005)(53546011)(6506007)(4326008)(2906002)(966005)(45080400002)(8936002)(44144004)(6916009)(2700100001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqQYSfaxKb7hFoefaToiZ1+ECV+CwJGTTZR20BEgHB3/SIn5snkKbBvUFifQidBmcBZv3FUH3w8soqSb986SmHofAMkB+ZhZCCBhzvQdYjhRcy4MM8uR0NFjxvQARtWJTt2HOc9VW9zm1LTs/duPaz37qF/GO0XjvC2hsCn/HDUo7m1ICeYDqx2jag/a3FtQV234cF83+wMrnNKVafuvr4GPRV7e+4+R+QMBVuimFqLsNEOjEtbMDOXa0BUegEQgM12VXQsQ8COUYORSFKeeNh+T+rZ1i2Uwf59oRgUf634tCBz/1WO18u9cj0MdwJ1EFpJEulR+8RXZCAx6gRcWYE33f5ZZq/ed2fTLWfRfId89Vg6geqIGSdF9PSeS+fAgiXuAKLGUU5omXbSj00FjlulyiNkOIyKkhRMsQv8b8cg3XRLzWjMJW9iOLxHjswZZnZfrXy2GYRqtSOJy2fAWReNilICiJYCDtqubS1vpwNwM0O2w7xIZTKCXMljVapecsKgcUyP16yOazJWIqaYu7jNE6/jlSk4Irng4jqMksdFtorTBK9NKGDHBlEq+eUSJ
X-MS-Exchange-AntiSpam-MessageData: i5iKSdjbujyhAvCdOMj3nei/KavImXJB8e2d1QN9OHjEOn4ACgI8ee4Bump5eZvw9Xi1x6hj1euXvrPc3ybQrxwAYAUB6bi5PhjLAEZlZbwaBQ3tJJUY6nwrp3uCPBnlqPw/rM/5on8EaK/HJn93IB+PpUJlo0q5vyUQPyi9tWI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab462aa-0dc6-4a29-3adc-08d7da5ba645
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 18:52:26.4917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2EXFni0VBcRgfHpK0hzNUmejk9b7Fes8mmRHlMXkSkRX2j1c0r1sSSioF9lJWFGIjxos6NXiXdY9nFsYXQPvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2441
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
Cc: "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>,
 Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Jerry \(Fangzhi\) Zuo" <Jerry.Zuo@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: multipart/mixed; boundary="===============1172689360=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1172689360==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ps3kjoe7vyfn227t"
Content-Disposition: inline

--ps3kjoe7vyfn227t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ok, I'll just push the patch to our repository.

Thanks

On 04/06, Alex Deucher wrote:
> On Mon, Apr 6, 2020 at 2:44 PM Rodrigo Siqueira
> <Rodrigo.Siqueira@amd.com> wrote:
> >
> > Hi Michel,
> >
> > I'm going to apply the patchset by the end of the day at AMD repository.
> > Is that ok for you? Or do you need this patch on drm-misc-next?
>=20
> I can cherry-pick the changes over to 5.7 fixes once we've addressed
> all the issues.
>=20
> Alex
>=20
> >
> > Best Regards
> >
> > On 04/06, Michel D=E4nzer wrote:
> > > On 2020-04-05 10:41 p.m., Rodrigo Siqueira wrote:
> > > > From: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>
> > > >
> > > > [Why]
> > > > Prop are created at boot stage, and not allowed to create new prop
> > > > after device registration.
> > > >
> > > > [How]
> > > > Reuse the connector property from SST if exist.
> > > >
> > > > Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
> > > > Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
> > > > Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > > This patch is needed in 5.7, or one gets the WARNINGs I reported in
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Farchives%2Famd-gfx%2F2020-April%2F048017.html&amp;da=
ta=3D02%7C01%7CRodrigo.Siqueira%40amd.com%7Cc277a51490f94ed99a2508d7da5af6f=
0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637217956540368991&amp;sdata=
=3D%2FGtnTlXrRSzZM7M4KApZO1FFVCJjuJ8cur74s2ZNz0E%3D&amp;reserved=3D0
> > > when an MST display is connected.
> > >
> > > Note that this patch doesn't fix all of those, there's also one
> > > triggered by dm_dp_add_mst_connector =3D> drm_encoder_init.
> > >
> > >  git grep mst_encoders drivers/gpu/drm/i915/
> > >
> > > shows how the i915 driver deals with this.
> > >
> > > Can you guys take care of that for 5.7 as well?
> > >
> > >
> > > --
> > > Earthling Michel D=E4nzer               |               https://nam11=
=2Esafelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;=
data=3D02%7C01%7CRodrigo.Siqueira%40amd.com%7Cc277a51490f94ed99a2508d7da5af=
6f0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637217956540373986&amp;sda=
ta=3DckUT0WFeLWopbqY6SG%2Bg69i%2F3O6cTkSTWqBAyFHg3iw%3D&amp;reserved=3D0
> > > Libre software enthusiast             |             Mesa and X develo=
per
> >
> > --
> > Rodrigo Siqueira
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsiq=
ueira.tech%2F&amp;data=3D02%7C01%7CRodrigo.Siqueira%40amd.com%7Cc277a51490f=
94ed99a2508d7da5af6f0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63721795=
6540373986&amp;sdata=3D%2BkwwR38PUel4j21WGo%2FxPMoXS%2BLnEQ4ax1yGxI%2F5xHc%=
3D&amp;reserved=3D0
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7Cc277a51490f94ed99a2508d7da5af6f0%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637217956540373986&amp;sdata=3DVlEy9R5us1VevQmt=
UJjen%2FrVoi0F8bjIAh%2FwffiCP2k%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--ps3kjoe7vyfn227t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl6LemYACgkQWJzP/com
vP+JQA//f53FlQuPftpX5HKAtVXQVvvrfpiMFczoMSceFT8uRYn+o4+epMLxPQio
MyCc27Ywn7f+KDg8TQY6+4SN3Xm8Wi6aq02EpVqu5lpmUIw5x40rQw6j97j9Hetb
Mjypr2pF6YBvVThe14xrsMfs+ouJk23o79qUVwExv7ULXvaeF1WkKn4JXHSS+Boy
RJSHZxmq5XQKdVkIrfvYeNQ9Uw2qUZ2y5U3r+puxl5ozptqLk8QvNYPIhsHROJqG
Nmv00VSOTrkYNvZ2P1yNxlQ7H8EkuPq++pxYjnznpykwGUAX6TCwUrAmKB+rQCOA
L00iwvyQEBxl5aaLufT2FJtViGmBX+sEQQkB3WFo2Frmkqw6+p5qIhdMBHcyixA3
d9XXeEqPF/piB6HqvK1f+b3398tI7Lm/U18uy3eHB3Y9GNWLpFWXAcg7V8eML/F+
zvAoD+MOaP95/2Z0K9zdkaJeZQ3hff7Y251ybVHenZuptl2jQqD1LN5RJNtClTwa
zzZR7NO8MUiw7CeSw07ArTmKpSCE4Rjs2osoUg2E/i0nVZIL6Eee6LmQbzn8YwES
NCxQjfbDZcbN8vl5PyxuMZUpt1odNxbGr0k9rasE1m9PpaB40Crn0o+qxV0y3QXl
MC5aj4RIWh03uIXxCtao8FSnJb8jGSYhnrttD1hQxSrIAzf9rw0=
=jEWn
-----END PGP SIGNATURE-----

--ps3kjoe7vyfn227t--

--===============1172689360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1172689360==--
