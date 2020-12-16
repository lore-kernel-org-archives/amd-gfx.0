Return-Path: <SRS0=VOM3=FU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E49C4361B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 00:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0213722DD6
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 00:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0213722DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665F98997A;
	Wed, 16 Dec 2020 00:48:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37FB8997A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Dec 2020 00:48:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dghj+CpihnOmLklcau8KOTkDJeae9yhs5zFTlnt6ifNAWt5Urew9/BVIbVYslcD+UWAcqpXpSkUV8kgElvGN4pMairFdBOXStrliZcdCnDJLEsZvLnm/ghdWj/QGDHH2luATzCdgg9odRTtA24A7AvLLQbdwzKuhSLoHLqeNqB+GClf6JTuYr6r/Zk32Hi/Y3LfPG4PQaqFjqiii5YFWTlxT9Idv26/MqZSxsWixqlXn9itlyvRA2Cm6wGvlegwxEU5Iyejd0obUxFBqOy4Qb9gz9pZA0+TdJEr1C1JfealWKY9sZcZBX7x1wOVKDhoZ8FRE+vC9PMPp1Q8lHKWhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVup6K+chyjCmZWnEUEWEWN7wF5wamhlu7sQWW/NUVo=;
 b=WOvA3tGfmOn3WXqdbwLkN7a+Y2GQU1WkDWDHG00he3R/zy4auLpYZ5SfbvjMxeSvIqhHDQ4XPMJl17AISbaTtPddQE8+XgMNFBDdWc0aolHZBKALOXzvVSfr8OocR78ulWEdHDCmnhCzvEqL54Es0GWzgBYLQTduBPKp7Tw+T7o5xw7i7eKJpKL5TdEmorVjwAnGroO1+/ORacrK0R+xLDve5XiX6KbYOFNAR0FUcsAe+so8U4O5ok+EOIHkrJT2QqGgS754+Q+8C5nvG5Y5/lj9fqEgNIrYf4m/NHgGYE7Uj2pCZo12cfXmRuASpvlXhKWEllaiWu9q8n51heroBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVup6K+chyjCmZWnEUEWEWN7wF5wamhlu7sQWW/NUVo=;
 b=28Frl6VgG5yFMGLQEPuYITZz90I0F7xZ2fXQHyZSuyuM4iMoPysmIBmNmpcr7IytLKeES1I7DteWQxbDOikFCWWl3GJ8uRv9HEHhaHOiteVysTRFLfkf6NsJnYflwFL4jiKMvdf1y4Dkv7Z1/EHh+J6jWWAlQugi66upePx9tGo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB3909.namprd12.prod.outlook.com (2603:10b6:610:21::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Wed, 16 Dec
 2020 00:47:57 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 00:47:57 +0000
Date: Tue, 15 Dec 2020 19:47:51 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add get_dig_frontend implementation for
 DCEx
Message-ID: <20201216004751.ugbsp456dy4bhnzr@outlook.office365.com>
References: <20201215154505.1321860-1-Rodrigo.Siqueira@amd.com>
 <CADnq5_N5tiECQ9XFU8fD=OaRwnH_Xsivcv7+-oHepsdmrpiG4w@mail.gmail.com>
In-Reply-To: <CADnq5_N5tiECQ9XFU8fD=OaRwnH_Xsivcv7+-oHepsdmrpiG4w@mail.gmail.com>
X-Originating-IP: [2607:fea8:56e0:6d60::bef5]
X-ClientProxiedBy: YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28)
 To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::bef5) by
 YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Wed, 16 Dec 2020 00:47:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4bf0b0c5-6239-401d-bdd6-08d8a15c3b4a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB390964DE0537794139F6DAD898C50@CH2PR12MB3909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60sNAQUOBJoVsXM+H+tIVNQb4PeU2Bd/brt27dCSOamvQe11rS3KCZOHWfPGG4bV0V7IkG4bTDaZyRDZbnu1VZ57m4t1VTqNjodsHAkl9OB2bw8F3GVO3O6/1ATS6P3Hu8lOXH89hCdaEMO8wm8YJJxkmB5qKWU219m/ehV0jzdpwg8oBNtz8iROH5eUqCYTtP0EHuq1E1YDEx3IDm5e0dPKCUX6QLFbqGCgoCIj0/yJkMy+F6m2j3vVxI6hbO3jYrYG7j+b2SUon0t+WZQjc+wRoZNL12LcjX7r33uj4gsDoyVT9anIsj2j4yJkLm6huDqiTg4Q32zzhRYPuKdbh4sdw1ks8laZIiVlvMKpDmnaSGgpUFA5E+TxZW4oSPk+f7xDFNt8BQrsRzucfAaBP3cJKQahYzTDYsOLOGhLjHY+o3r/UtGMJskyn7/EHCtmZDBzQ73r+fdOdi1d43jZm9XMd2bzkIhkhPER0DRKbI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(6506007)(83380400001)(508600001)(44144004)(53546011)(6666004)(34490700003)(52116002)(5660300002)(45080400002)(2906002)(966005)(16526019)(86362001)(7696005)(66946007)(4326008)(54906003)(6916009)(55016002)(8936002)(1076003)(21480400003)(9686003)(186003)(66476007)(8676002)(66556008)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ty1dzRUjNcRJTIRXcawIwEjzPQ2mVeWfDGsZ9GZ9qL6qDr24Hrk6a5NMCIyG?=
 =?us-ascii?Q?1fgd73KTxlCNKoUXo+oEZPVUq3zGDWUKrFYvKoVoL2xhXVDSQtPtxSXu1eQg?=
 =?us-ascii?Q?tSA/3cJ1Ji6oFzi3IDLXVTRGPEJ6Yu6m7nzZylfRb9q4FKPUnQbI6zywAEFl?=
 =?us-ascii?Q?s+U0L9ChahCT+xz9Jwx63MyjpqJURtHLj8xcpjx0vA6CtqcR3sKEIErcW29r?=
 =?us-ascii?Q?TQqorJ1K6247AcdesuPuP+wFTu+KxL3VISSsZ9+fbO2kx7fF4n1+BQ/WiZJi?=
 =?us-ascii?Q?aqHdzWzBNhRyh6gUXDY1NW1kxqQ360lR9dg0yAIx8JoenQ4CGQN8+CjcJm1k?=
 =?us-ascii?Q?HlCZYOhfnWmCtG/9QMhkUya7w6qH1O2Fp6cl3dz4QEat9Lu2or7gbdXOMlHn?=
 =?us-ascii?Q?S1clPMJhYv64C2Jycun90dQj/qy+6pU7WzKPwu9qZ7XAIHBqtssU+RtPBa9d?=
 =?us-ascii?Q?ZZ0c24RcDCpp36NKNcKQqYN4GdJ2uDa5Ved6LAY2Ai4nCNftCjPhjdg4QGLI?=
 =?us-ascii?Q?02NFMMSli2DjS0zODMtajthRHHxA/vSPCZZy8camU4WevxNmDOkBJYLtR0YU?=
 =?us-ascii?Q?VGBLBQ+oJ53ywlry06M9AaBui8zNwfpC6kCpW3WMobfzfTBZGTdm2eR+3CbM?=
 =?us-ascii?Q?T+ZlQ2lyYYcbsrTUd0xNkIhZdOl680vYQIy6R3iHQHubgUKtC7sZmaG9sxny?=
 =?us-ascii?Q?upXh6bYzVfvM65Zau43TBs04WM0HNcYao0xNkISZSOQYgVe2idMmG6oozTOn?=
 =?us-ascii?Q?Kal5rtgo4ah1L8Y6UiO4kR8ApkypxZVg6hMCV+XrK0VX0dpANXpn1t+gFglj?=
 =?us-ascii?Q?Zo3iRopZBvAwGUYMoZJ/Th8YCZKIo5jl/T8LKuNZf7Yvigq6K+h9z0J2Le0C?=
 =?us-ascii?Q?CIBAyPMPsjq+Ou64BUoB9XbHi3v16g5visQ5kQhc8k/lPLjNO+1gPsrEBwXr?=
 =?us-ascii?Q?6t08rBfuBD7q6LaVkAT1a3QyzvC5dUWAPOFNl+F+SlfTCrzaD1Q31hyrEodK?=
 =?us-ascii?Q?Z01pkwdyjpCqzsXWNR8t9M4f4A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2020 00:47:57.5293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf0b0c5-6239-401d-bdd6-08d8a15c3b4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6XGHJgT7uGEHtTjD36rgDzmQFvt2BfKSpOd3aXPs3K56Z/hu92wEMLUU/yfAhRD2PT/WSldAEzmODTx83rr7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3909
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
Cc: Chiawen Huang <chiawen.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Borislav Petkov <bp@alien8.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: multipart/mixed; boundary="===============0723965424=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0723965424==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j5zxgviz4tdjpozg"
Content-Disposition: inline

--j5zxgviz4tdjpozg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Applied to amd-staging-drm-next.

Thanks

On 12/15, Alex Deucher wrote:
> On Tue, Dec 15, 2020 at 10:45 AM Rodrigo Siqueira
> <Rodrigo.Siqueira@amd.com> wrote:
> >
> > Some old ASICs might not implement/require get_dig_frontend helper; in
> > this scenario, we can have a NULL pointer exception when we try to call
> > it inside vbios disable operation. For example, this situation might
> > happen when using Polaris12 with an eDP panel. This commit avoids this
> > situation by adding a specific get_dig_frontend implementation for DCEx.
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Harry Wentland <Harry.Wentland@amd.com>
> > Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> > Cc: Chiawen Huang <chiawen.huang@amd.com>
> > Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > ---
> >  .../drm/amd/display/dc/dce/dce_link_encoder.c | 43 ++++++++++++++++++-
> >  .../drm/amd/display/dc/dce/dce_link_encoder.h |  2 +
> >  2 files changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/dr=
ivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> > index 4592ccdfa9b0..f355cd1e9090 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> > @@ -120,6 +120,7 @@ static const struct link_encoder_funcs dce110_lnk_e=
nc_funcs =3D {
> >         .is_dig_enabled =3D dce110_is_dig_enabled,
> >         .destroy =3D dce110_link_encoder_destroy,
> >         .get_max_link_cap =3D dce110_link_encoder_get_max_link_cap,
> > +       .get_dig_frontend =3D dce110_get_dig_frontend,
> >  };
> >
> >  static enum bp_result link_transmitter_control(
> > @@ -235,6 +236,45 @@ static void set_link_training_complete(
> >
> >  }
> >
> > +unsigned int dce110_get_dig_frontend(struct link_encoder *enc)
> > +{
> > +       struct dce110_link_encoder *enc110 =3D TO_DCE110_LINK_ENC(enc);
> > +       u32 value;
> > +       enum engine_id result;
> > +
> > +       REG_GET(DIG_BE_CNTL, DIG_FE_SOURCE_SELECT, &value);
> > +
> > +       switch (value) {
> > +       case DCE110_DIG_FE_SOURCE_SELECT_DIGA:
> > +               result =3D ENGINE_ID_DIGA;
> > +               break;
> > +       case DCE110_DIG_FE_SOURCE_SELECT_DIGB:
> > +               result =3D ENGINE_ID_DIGB;
> > +               break;
> > +       case DCE110_DIG_FE_SOURCE_SELECT_DIGC:
> > +               result =3D ENGINE_ID_DIGC;
> > +               break;
> > +       case DCE110_DIG_FE_SOURCE_SELECT_DIGD:
> > +               result =3D ENGINE_ID_DIGD;
> > +               break;
> > +       case DCE110_DIG_FE_SOURCE_SELECT_DIGE:
> > +               result =3D ENGINE_ID_DIGE;
> > +               break;
> > +       case DCE110_DIG_FE_SOURCE_SELECT_DIGF:
> > +               result =3D ENGINE_ID_DIGF;
> > +               break;
> > +       case DCE110_DIG_FE_SOURCE_SELECT_DIGG:
> > +               result =3D ENGINE_ID_DIGG;
> > +               break;
> > +       default:
> > +               // invalid source select DIG
> > +               ASSERT(false);
> > +               result =3D ENGINE_ID_UNKNOWN;
>=20
> Do we really want the ASSERT?  The same function for DCN asserts all
> the time on newer APUs if the register has it's default value (e.g.,
> if a particular output was not used by the vbios).  IMHO, we should
> remove the assert both here and for DCN.
>=20
> Alex
>=20
>=20
> > +       }
> > +
> > +       return result;
> > +}
> > +
> >  void dce110_link_encoder_set_dp_phy_pattern_training_pattern(
> >         struct link_encoder *enc,
> >         uint32_t index)
> > @@ -1665,7 +1705,8 @@ static const struct link_encoder_funcs dce60_lnk_=
enc_funcs =3D {
> >         .disable_hpd =3D dce110_link_encoder_disable_hpd,
> >         .is_dig_enabled =3D dce110_is_dig_enabled,
> >         .destroy =3D dce110_link_encoder_destroy,
> > -       .get_max_link_cap =3D dce110_link_encoder_get_max_link_cap
> > +       .get_max_link_cap =3D dce110_link_encoder_get_max_link_cap,
> > +       .get_dig_frontend =3D dce110_get_dig_frontend
> >  };
> >
> >  void dce60_link_encoder_construct(
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/dr=
ivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
> > index cb714a48b171..fc6ade824c23 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
> > @@ -295,6 +295,8 @@ void dce110_link_encoder_connect_dig_be_to_fe(
> >         enum engine_id engine,
> >         bool connect);
> >
> > +unsigned int dce110_get_dig_frontend(struct link_encoder *enc);
> > +
> >  void dce110_link_encoder_set_dp_phy_pattern_training_pattern(
> >         struct link_encoder *enc,
> >         uint32_t index);
> > --
> > 2.29.2
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRodr=
igo.Siqueira%40amd.com%7Ce4e5be182f2e462a5fd908d8a11cfc67%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637436493154372722%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;s=
data=3D%2BVbEKhRiSaQCDYYGo2aa8BADRJiposg4VJM9G0Z1Mw4%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--j5zxgviz4tdjpozg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl/ZWTIACgkQWJzP/com
vP+5oBAAqRK6zeZSHU7MsU87cHYnAJ4hcPNLI8V7bqYsAoEiMzXRKBDbRMZSgwIO
LnjuQlelxyxjqm3uDXJISqlcioLf8r4wWmXBgIkHrccJM8nIkmD8KayYBuoqCXSF
ImwRM8sS9e3wMG7FXqqSbrCLi2rMtVjfn+fKq31mkRuNB4yeu8aXdVRaqdO593y1
fgRmKEiTgo3habZSnughbo7bsnFZODMNfy/VVdlEIG8AlEY6FtcWgVF3fDJrZx6D
Mol7xT0LOupR5+OVnHCSJMqvKnTZhZTdmwrA+p8MsnoZFwF3U33vH7W03g+nrv6F
r3YITJ7WF/2YWFTbGulfaGAtvIvid/HMi1UPHk/3qqb8hqPVa9lUbMrSp2CA+QqN
5cYNI1SaRWnV3AOjTBxoXgdSKw80RSuO78vjVu+yoUGr8/reX/Yh67954nwtz7+G
IAXTqPZOMU06iyahQciHWfE5Uplo2OrmrGumstYX67tKD3BbL6kQ04DE74hQMu0g
K0qtGqwFpOcqvG5NfkkCK24nsglqOB12IaYP+++a7qs6GqMVZT91sVYEj5beoE5f
avmUFtWLjplGav66+IsAtfWfi3iYKKY4rm92pxoWgiynPZjWCx5NiHL35DzuTn5r
R9lkGps6mxBbWJd3XgWLGi3JFnvVMy484/ckturIYFWBSctePnA=
=Rkuv
-----END PGP SIGNATURE-----

--j5zxgviz4tdjpozg--

--===============0723965424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0723965424==--
