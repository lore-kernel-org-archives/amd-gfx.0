Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76270C433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA1120748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RMuz41Ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA1120748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D0C76E0ED;
	Fri, 10 Jul 2020 20:24:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991306E0ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 20:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaaPlTIgdXmVqB1TuUOp5/gR04XlMMakjgqLLjBKBnpI29yaZ1yx3ugcJZboBKnBCFyZxA7DcZEJ34y3YcQDnISsRmWc4xGPj+QWTQL+iIIT5fH4BXDd7MkRkWVO/zuU8MriAUs2pBRYHE+cQBzWqDRhS4rp53GCxLGN4PzxgcBwJ9Lmfl4kDzq5lZL/7WzlLjRf+z/rpcIlgvnm7pJP6O2YHfBNA66Wx0N0EBfra/ZGx6PUvznqMUgrKU4dnF+TZSkTQldnuMnnnX8oLGNr3elUJFR9QOTwiZgyTxae7ONEvTv/IA0rdXDlq//2GCk3ofo0GQYQXX8jq1WyZLSBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtJN3BC1CIPfS8AtTCepAYC/anXuYnEpbJKwz+CmxLg=;
 b=gdS3kCSJYn2sMGxpdH//srHtnQq7iAA0M0R1qzyKDhJKF1ukJmeqhwjdpxGRgypATNFFxc+p+UIvG+P5TaL7t/8RhcKA8JT6imDvIB46/zpcYzaw8qe7ahCMnUm/DaqX+qnmZWdfHdrcixwlhjCnxfC/8il2mPj8t89FywwNhl5wHN9jOXGtHK4MD1uS23XOhBfx8fzYiPuugN4uHfKTK6ocxKS2kXTJBO42cmEE4GaShTXTQrwGYOBs5rgREDt5EndODsZkTG753HvL7UC4p8XmpY5npKg+rSjU+7U6HzCIXOdJXc5AEEJhi5qFc/Y0Ul1K44FeSU6AreIK3EEQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtJN3BC1CIPfS8AtTCepAYC/anXuYnEpbJKwz+CmxLg=;
 b=RMuz41OkqVuSrVcN/6djwaOuX5/5K0egQfCq0nQSKm5jXodlaUFDEQqotwtXYjMllMrM5RgninoXMuXDl/58GwbGUgC0qHezgFhnnvBmZa3UPc81UvxvM0DI99YteR1hgxzussqk7Xz+YDLd/1uPm/jicAlbN9peVoUJwx9DLXc=
Authentication-Results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3669.namprd12.prod.outlook.com (2603:10b6:610:27::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 10 Jul
 2020 20:24:31 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%9]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 20:24:31 +0000
Date: Fri, 10 Jul 2020 16:24:20 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 0/8] DC Patches July 03, 2020
Message-ID: <20200710202420.qlawmdku7drndy4v@outlook.office365.com>
References: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
 <19927257-4386-dc0c-6195-31100dd8f3b7@daenzer.net>
In-Reply-To: <19927257-4386-dc0c-6195-31100dd8f3b7@daenzer.net>
X-ClientProxiedBy: YT1PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::11) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56a0:8440::b10e) by
 YT1PR01CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 20:24:31 +0000
X-Originating-IP: [2607:fea8:56a0:8440::b10e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb3413ef-02bf-4f7d-ace4-08d8250f40af
X-MS-TrafficTypeDiagnostic: CH2PR12MB3669:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3669C5CD025F8849F0DA0DCD98650@CH2PR12MB3669.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXirk6HrQVwXYtGt13HnmBx1kTPqUF9xlxR5NpB8patHUklMNJyhY72IdQZ0V1qXwwzxsbc9Ra6D366pSFqj8G5clokuEGCApyptlQIPMmjFeacHAjs9Zr/clm/ZN8EE/rm4wD3nFvDJX9FXc0pYKWX+aoWBl1YzEJLMpveXvOFLa7/I8vc4l/LDPP0lBmYcdsjUnNcA+I0NeokpbS7WKVxpgfridP8ZM6qfskaApnxxKqU7gQ6SQmYuNdKEn03LZm0XZnt01xN0tyBYFzi0/09RqX45CclqNT9NE3B3DzFCQj89HOAw/NlWe/vDvJhSlTD8d5m23KGEu6RZA7tDZyvs2e+rtGqePaxwvOdo8YVlECUoGoOQYGVSFJIjM8GmaaSvoReSZYYP0ObdxtBV3wum6/izCCA+ZdkuXMPFvpbzw3EqcWKySr5uaxrOzeOalh/UzTZuQJCZSE79ZyrrJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(86362001)(478600001)(9686003)(45080400002)(52116002)(7696005)(44144004)(186003)(16526019)(5660300002)(6916009)(55016002)(4326008)(6506007)(53546011)(8676002)(8936002)(1076003)(316002)(66556008)(66476007)(66946007)(83380400001)(6666004)(21480400003)(2906002)(966005)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EYjuHoQgqVswNt2XOhi2hyNH8xU/8GcfP6m+I/4rUUeE+ITPNRIb8DbibhsXwC9NHcY0+PJrrS95Ttg9p5FZ89y12Y8g/w6H6A4JezW3SE/v/f9Z9qF64YbYgH2HsLZL7to4dhtLSzaJteQ7+Obc9Zxi2DS868kQl5xBRVa2IC24DCbXGxrWuhXYX/Wf7Ki/fstco72+Yh5642PRdCGx/10Tm+560kLjdXUcjnLXaPqS90tXcyDpZi7Ie+tPbEwg1GkjEq+6UjEIu23d8Xdvbht2Iiz9Oa+G0SA+1DOB0fUQ6A5sFgOGJHBdxxnRqT8WxAZaQiRYGSMR3G8Mbhz+mdGAMQY6ZknOfB9yN8xzlcYSG04BwMNrG9KHYh5dRM6zvGo3RMhKlQiZcioB2SM8omDoCSpcxNXchnwfzRi38uwIQWSJSSOiGJ/bfMZSC/rxG4C/tyz2O2lH+33UG4YbNEOWHtXmuZL6N4lBDjBwMb4Fou56x/tB9Bu838rS0gK0BZJNuCI31Nqi4aKWrLbCeA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3413ef-02bf-4f7d-ace4-08d8250f40af
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 20:24:31.4390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRWGXop/xAWvW00JWHhL2D/FT4npu/TdpjjMqimSifyuodOl6uqwef4nyQmHoBl/RdgT+Lgobuk311J6FnfFPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3669
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
Cc: eryk.brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, amd-gfx@lists.freedesktop.org, aurabindo.pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: multipart/mixed; boundary="===============0205294783=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0205294783==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r5xelgvamj4csek6"
Content-Disposition: inline

--r5xelgvamj4csek6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michel,

We try to follow tickets reported in FDO and try to make a triage of it
(using the DC label). However, we need to find a better process to keep
track of FDO bugs and try to map some of the fixes in our weekly
promotion.

Best Regards
Rodrigo Siqueira

On 07/06, Michel D=E4nzer wrote:
> On 2020-07-04 3:14 a.m., Rodrigo Siqueira wrote:
> > This DC patchset brings improvements in multiple areas. In summary, we
> > have:
> > * SMU logger messages
> > * DMCU improvements
> > * Bug fixes
>=20
> Are you guys keeping track of upstream bug reports like e.g.
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1108&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7C247ae3741e1640db86b708d821cacc44%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637296502193019525&amp;sdata=3DTQrrKligwedm0lVW=
ldziBLr4LQVyt2gFEAvz0WAH6oc%3D&amp;reserved=3D0 ? (I also reported
> that on the amd-gfx list early in the 4.7 cycle)
>=20
>=20
> --=20
> Earthling Michel D=E4nzer               |               https://nam11.saf=
elinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;data=
=3D02%7C01%7CRodrigo.Siqueira%40amd.com%7C247ae3741e1640db86b708d821cacc44%=
7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637296502193019525&amp;sdata=
=3Dl%2BztOfG%2BVHJ2Niv5TqiYmFbjjZvMI%2F2%2F0D5CAagPR1E%3D&amp;reserved=3D0
> Libre software enthusiast             |             Mesa and X developer
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7C247ae3741e1640db86b708d821cacc44%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637296502193019525&amp;sdata=3DUmKL%2Bbe3dKiOT1=
LW1p4y42mdC%2FiHp1Dz2L8x%2FOSHvaQ%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--r5xelgvamj4csek6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl8Izm8ACgkQWJzP/com
vP+sYxAAweOrU0JDQtMBgOpSTL9umkLZ+W5yYcHpyT/TDexfioPzbTOn0VpTP9R/
tlHGME07ZDsaPlvhA4FCfWfHTuOs88lqiU0bMHjB1iVTxkz+bT8EUVW09N/Jhzpe
3kiUcy/Ouyy4zjFwodxUV3EEvrhRfFWHRAbnw8fuqq1cjV0Ho5WSw9NLlRenu9Fv
l/0p2Y5C3hRdlle4DVjPeaKlKnKYT2TvZLnl6eWyiLuDpxe8XS6mCqJSh/ch3Eto
NfVmvn5U8cPdqSRTtvGgTHHCYSGJj4fAvZyBQtTQ1S4NQddVGbkd2sCoxPoGZ4iv
rAqCJ0Gqd+Yr0qL7ByPjbdlsKb4FeNNXODS1gB0moGVaopIuJvYdM0CmucTUkXBk
tcBwk3T0sUUgqG17ccc3ELYviEIIMLpXKjxsu/wMIiAyiZkP4oXrXbo5rUeJoLZc
sydLMUnyoMKbIkgaciBZODohkr5rc3VCbHy5dubaxdUCdIwTcpy+GX7G/YBSEqw4
xHDLgeWxrN9RAiOO5KnwMNQBqKffm5zk1jbhjK0CHdZmBjJ4AD3pjpvxURhxlBOu
/YVvUaYEgV2Q5lxIVVDK1b1GaYRxbFXjctJyXv27aBdIbhTGJvl7cA8bZ6YXOGO+
wP6kGOG+WD4oLmeGu3Kcu1lF87ajcNPFGh5ngqt6NdecgyxlX/8=
=JY8B
-----END PGP SIGNATURE-----

--r5xelgvamj4csek6--

--===============0205294783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0205294783==--
