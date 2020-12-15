Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF15C2BB9A
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 16:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311C422509
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 16:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311C422509
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9586E416;
	Tue, 15 Dec 2020 16:07:31 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750084.outbound.protection.outlook.com [40.107.75.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8FF6E3F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 16:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLSQ4nVD+KSeSfXZx8UOOLfIlYMhTpJD9Z88vYd8pcu71sk0mBAbq8y++dFDPu7joeJrMxjaBzSaM9diD9g5rimZXSLPxrXC+zqWiCxBS1VV8YmAAJcuFzYgT872YJ8yoB7MT0fz5lVPugprBmDru0pHxw205HYFqzLGtyqPJ6K2LQbsJ4q50kaNDIc14UiuHJqgRbRjzwe8LzvGU46705Ghg1RYqX5TqLjEveqOEoWxUmqJ9yad4SudwCjl6wpXD3dY6DdU3AtYyW9xlWfKHfFiKaobo7QpetdylsmxXqvFaZlYjQcd31LAGfSr/uhTdBQ8FcOGG+q1uWoIjNyhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VREu0xpjoTVS6PUWbf+wScgvaMT5w4qIs+GqN41zDg=;
 b=CK/B5vhmCxjgna+RbV0yVjz1xM9TMyZJWlkVEvIQhGB0yoKVb+39skyBArUFEA4oENW/xLfHUGiZ4JrjH9gjVAJrxn+Bg24J/RF01/BFZHuusAZPd95+ApWE+ohSeD8YHCFp1LZ+fXa3lhI491fVeVf1bJmm7osWn9EZdY7Rb1uk/N/nYpvsVslPTuKnyYQpXCeeKeOPgOChTymGkNZFHLLQ2a4o3zhRrqMsHlbKFpNUEstXbaqtdlgTSU1lojUdYTnYdT7uQOZnli3WDY2T2c0sXoaLA/Yv5sujA6dXwOut8uR+nPgxPnUfBema5SN4Oao8sinxyWjMCV5aPsP9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VREu0xpjoTVS6PUWbf+wScgvaMT5w4qIs+GqN41zDg=;
 b=37LCBuFuscpo6gbNh2yOE2o1aK6LB1cfHlXDL0ifCmNbcmLmuk96V1l33lc2VaeQTclDkr/MonijpLdRHHIq77JYwMZDg6ejI6yiH2s+wOSvEzW4Pu9aQvG31ksiLya3EraTMEOT3+BQl1ljG8szOLQ4HBSgcJQ9rherFQNiXW8=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4954.namprd12.prod.outlook.com (2603:10b6:610:63::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 15 Dec
 2020 16:07:28 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 16:07:28 +0000
Date: Tue, 15 Dec 2020 11:07:20 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
Message-ID: <20201215160720.ewce4usgb53pzt2j@outlook.office365.com>
References: <20201211155553.GC25974@zn.tnic>
 <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
 <20201215155622.GC9817@zn.tnic>
In-Reply-To: <20201215155622.GC9817@zn.tnic>
X-Originating-IP: [2607:fea8:56e0:6d60::bef5]
X-ClientProxiedBy: CH2PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:610:53::16) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::bef5) by
 CH2PR17CA0006.namprd17.prod.outlook.com (2603:10b6:610:53::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 16:07:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c2fdbf0-c165-4fbb-0a80-08d8a1138526
X-MS-TrafficTypeDiagnostic: CH2PR12MB4954:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB495420E30AAE274B6354DFD298C60@CH2PR12MB4954.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scv3mLphpf66dZBU66n69yJuv42D6aYJROR9hCbwKtagAGuFZrdPNYQJ7BQwVUhzTBwbc65aWHoWyQ3b5qtbT6OZFaKq5m3gdJKOnHnwSPlaHfZ+ZCBJnPoENNyINRpqcp6Xx2PpDcS54c8KCnlt3KRo8xahRHuzKJz693vskDKD6bToc7Ck2StA11Na0l6pL7QVnUxzeCuxAAHcrxRafMa3novZfjX/Ef+qzKpVoZGn1kbVQS0ZX1xbd9e8zOvUta7nWqJ+sQFya2AcDU4dPzU1D3M+rIE/PnWul/66wE7KNKUlnxqnTtq/5J4i7qI2iB7wu/2ft0r55RygXpY0zzjUYPk1htH6XXJvzVQgNUD0RwD6EQUs2eJirXWnXtZoliziQkEuQlhT8+JJq3owJLY0hhJaifbl88ek8nv1DP4NiAsK7I00WUYG7kyOGvPAr2h5j6gf+qnNrg5+8TruiWRMwOu7QQyMMfR94afyj4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(8936002)(86362001)(55016002)(966005)(66946007)(5660300002)(54906003)(66476007)(1076003)(8676002)(16526019)(34490700003)(2906002)(21480400003)(186003)(6666004)(66556008)(44144004)(9686003)(6506007)(6916009)(52116002)(7696005)(45080400002)(508600001)(4326008)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sClsZF96inkO7dDcwqfnPsAh57wn97zzVMSz+RebNHMF0oI3Z+AFg3UVCeuY?=
 =?us-ascii?Q?BCxs0dah4G9kKnm9AMa2Swrkv7KVpl5Zj3RiWN9b1Ld5CyLLi80L/XUVDM4S?=
 =?us-ascii?Q?ycFoO6ARMbaX+0etYQzNX7fm1tHaYcSvRfUAzj3eGuuv9o5EQFw1kfa14lwl?=
 =?us-ascii?Q?QpLKcmFpimJCGooJVQMC8gFv3EL0MmlgxLlCRt8xT7UAqdLKaIPA4H7k5j8n?=
 =?us-ascii?Q?MjWlQPIaeSpAYgKR5gJdK5vEX+c3ifxiyd/lOLHJY+70LKh00DDdRXRmTn3w?=
 =?us-ascii?Q?frCE3KJq8lYUal3pLw24f9Dn0YhQlMQretEWaNWNQk/Oqu1lq0WLr7Yk4Foq?=
 =?us-ascii?Q?nijUuFVqy8GDwc502RBTvFEwcu5+3O/VmR0NCJM3iL/q0TFzx/WykPeLTP7t?=
 =?us-ascii?Q?j5oQ+psKmKb/QIGvr/JS/kZqAIV8ppZNBY6KGJIe8si7GPJg2ei8OwO09P6W?=
 =?us-ascii?Q?o8HKZ8EdOm3urBvpKPogXp4WIBt+xqad6/yQ8YonzknbWmlQ+O3P6Oz23yBk?=
 =?us-ascii?Q?7QwHd+3sCa8JMZzY+XoXJFDlGCPYij5/S1PzEbti2DQ7FSnEDphksDASGim9?=
 =?us-ascii?Q?V1ONy2ITDR5Zgp37izJT2TXGXm81fv2PB1+D8pHK7g+9B803YdM4bJEIxCwT?=
 =?us-ascii?Q?gwkFHUtsjNSODfnMwCsRCCfwzTmQkEjEn41zc2yRovbGQC9K3mjx4hdZrCF5?=
 =?us-ascii?Q?VVy0g/61nW1UDr/gRuTqJcG+1/IkbtFwJIJGoG5F9nfHTVj705VANnl5KGv1?=
 =?us-ascii?Q?2DEikyS30urix6aFHsxffzUj3Lhd3OxMfAmfqU9e62bX/yQ5QqSMwIM1c2Hn?=
 =?us-ascii?Q?enTqBYdDi8unuhr1ETHtmcubnwl2EuN7zfCUKUuueA2YrhO6U5jjXSoXoqDw?=
 =?us-ascii?Q?3Aq2/djJI0c87+G1WtBNhyHlQs03pqRTCNibqqyTNHNPbKSHVL7FxWzkfbF6?=
 =?us-ascii?Q?RtRgUsprzIGNR6aoTCi8oioECD7i29N10fNCUERaaKTXu9Rot6YOetaKgGS1?=
 =?us-ascii?Q?2aIFg45a2HBu0AqIP6WiqIwWfg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 16:07:28.2618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2fdbf0-c165-4fbb-0a80-08d8a1138526
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuiP/BXWaHs6RxyMEewDYGPOSPWvg5CzgiqKr6MNmCMaJqL+mKH4RUmKB5azNOyvz81iTXHL1YKXdPDslczgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4954
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Chiawen Huang <chiawen.huang@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0453784644=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0453784644==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="puchbvryl6xwf5wi"
Content-Disposition: inline

--puchbvryl6xwf5wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Could you try on Alex's repo?

 git://people.freedesktop.org/~agd5f/linux
 branch: amd-staging-drm-next

My patch should apply without any issue on top of this branch.

Thanks

On 12/15, Borislav Petkov wrote:
> On Tue, Dec 15, 2020 at 10:47:03AM -0500, Rodrigo Siqueira wrote:
> > Hi Boris,
> >=20
> > Could you check if your branch has this commit:
> >=20
> >  drm/amd/display: Fix module load hangs when connected to an eDP
> >=20
> > If so, could you try this patch:
> >=20
> >  https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
tchwork.freedesktop.org%2Fseries%2F84965%2F&amp;data=3D04%7C01%7CRodrigo.Si=
queira%40amd.com%7C1f7ff595746543f597a708d8a111fbdd%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637436445910587407%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DPESE3uBZeNjdWtIFRP6l07AyfhASpXCfaZa03l%2FFi6s%3D&amp;reserved=3D0
>=20
> So I did a bisection between
>=20
> git bisect start
> # bad: [3650b228f83adda7e5ee532e2b90429c03f7b9ec] Linux 5.10-rc1
> git bisect bad 3650b228f83adda7e5ee532e2b90429c03f7b9ec
> # good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
>=20
> and the patch in $Subject came in in 5.10-rc1.
>=20
> I can test any tree you want me to so just tell me on which tree to
> apply this patch and I'll run it.
>=20
> In any case, it doesn't apply on v5.10 though:
>=20
> $ test-apply.sh /tmp/rodrigo.siqueira=20
> checking file drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> Hunk #1 FAILED at 120
>=20
> You can push a tree of yours somewhere which I can try directly,
> alternatively.
>=20
> Lemme know.
>=20
> Thx.
>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl=
e.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=3D04%7C01%7CRodrigo.S=
iqueira%40amd.com%7C1f7ff595746543f597a708d8a111fbdd%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637436445910587407%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DkiGm0%2B2d2nXiEwUs0omOYv3ZtyfwTtoD9OhrT59Dv5c%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--puchbvryl6xwf5wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl/Y3zMACgkQWJzP/com
vP+PYQ//c7Je/rv6JTp1fJgWX3WqvdVMWwhEdovPfRz+jSx8VQBdbweXx8EJ9pQY
OG3xrQCpKcDnFA4y+m7zjUryFwnnFTAexYS5f5hWmz0Ri3vmbe9mFvRO0CS96vp5
9e+K1s54VT329anIFUw4ViQMoSi3I0GJxG4Yr+5w6iJDRDkFvhp48b+ycZBI+BRT
H7rMN0Wq3I1Znolik3qPSDwbk2nqRAKkHh+Ln0vxSCdB/x90FjwTM/z+e2/U8mDx
2UAN6n8oWJRr3G/+249SkR/isb1LHL+m1dlYDL18G81dUG+4a1r9zUV04RPQ9urx
4lZ7QY5JJC/n/3PoxsBJ3/fotfUQE9jfOdrayKRKjWP/Ei1zKDiCl79B25DhambB
cZ8cWzBoJ5xhxhzu89phmab9ZquzYCIZ2MatiC6wQ0kfZcWJ/JhBNSeDtuz9UlhK
xEhD7rM3nheoQ7+jgy6Gq5xxH5/27yFvpsL6Z8RZH++GPk4x4HWSjAiRy6J0IRlu
jfgwr3MV5ATUmX41UjL7/K9ujfJmLfB/fO0NIiqukgreO72MAUEvw0ddwqnCPDz/
YSPz6EJu2/Vkq9zZAAFZ8iF8KaKqIet8XjNru5BiHr3K5MZtK+DNUNXGqrZl9zI5
PRVabD+1pB8d0jx5T8VWOyVO8NSxuNNXUAKU40YhU39q0X3/drM=
=mM1C
-----END PGP SIGNATURE-----

--puchbvryl6xwf5wi--

--===============0453784644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0453784644==--
