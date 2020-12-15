Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531F3C4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 18:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FB022AAE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 18:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FB022AAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E1E89207;
	Tue, 15 Dec 2020 18:56:14 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760051.outbound.protection.outlook.com [40.107.76.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39AE89207
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 18:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkyGsB9s2R95HClPlbWKvE2wjPSAnUUFJtU9X+bpjThAnb+Y1gbxm/nfi3fY6f5gfi+miqyUFlKeuywYpZ1u+w+I1dNyJon8kXtUf3AXeP0uCxdWglXZkm+yV7dzWvjUtvUxH9DQvdfmNcmhNNuFDuaHb+gTaW2b2tVlT3+t1DdIf2xmC5MfTd9pPWTU+vKErbGsXwUuxI5b0/LhTP2D5Fqe8mE1BMVx/PEcKtoWrGLdH+v4n8b594WuPFYHP/yWa95hhZn699kLiSVdp/suDxRMSqYVAji6h1ChFVXZnNNz2AmV7jgqc5xHF0Kc+v3sIBQhrlZfCj+ZlGQ1DN6xSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9i1FIEjYXZAlIAdUwFL/pO8A2mdSvLF0y8CFr+Lulo=;
 b=CFDwJ43NdisWo7o0jLgCkpIFAXRzh60cNdKjpqCso9+nyZ3eMocR5w6nLBeEr7RC2+8bA2hb1ptpGKn7YFr8SozCZwDCCgDgBdl2FkTBlWEkWaeoqYmcCExAB7kgzSlPt9QP9znqW8swtmxKWaIIKqDgHeDzwGkADYaGQR7n8foa3194DUlZE0TumCb94VSF0/WmrA+bKavyiShmKRLJyXqIXUSjxWy55Qi4pBvCe9P8Re0KWxnpIblAM+D+YzF2CB8yPLbftfqin2tcu9JVF4S1jl2fTEgPZOLbkR2sITGqU2Gd2I1hf4rE5pQHmNermPkT2hLchYsQe9pLpFC11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9i1FIEjYXZAlIAdUwFL/pO8A2mdSvLF0y8CFr+Lulo=;
 b=vo+ezJHp4wnzQu9QbYZvL29y/JMxxpl8mljTfhbK3ff0dMG2PMmFOREOo5DsAkwjeCpkleyCbbXbWG4umpU2EtKsXO236V2avBYt2evL4K2OOfRa/EYKNbLi9UcbsPv28AWmgYXGSkqskAS9LBpnbNfwFwmK/mz2zdFWw1PatwI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 15 Dec
 2020 18:56:11 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 18:56:11 +0000
Date: Tue, 15 Dec 2020 13:56:04 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH] drm/amd/display: Add get_dig_frontend implementation for
 DCEx
Message-ID: <20201215185604.5hlgkiix6rubmgnl@outlook.office365.com>
References: <20201215154505.1321860-1-Rodrigo.Siqueira@amd.com>
 <CADnq5_N5tiECQ9XFU8fD=OaRwnH_Xsivcv7+-oHepsdmrpiG4w@mail.gmail.com>
In-Reply-To: <CADnq5_N5tiECQ9XFU8fD=OaRwnH_Xsivcv7+-oHepsdmrpiG4w@mail.gmail.com>
X-Originating-IP: [2607:fea8:56e0:6d60::bef5]
X-ClientProxiedBy: YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::48) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::bef5) by
 YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 18:56:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d331a8e-65a3-4c24-954f-08d8a12b16d8
X-MS-TrafficTypeDiagnostic: CH2PR12MB4892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB48924F64E3F294C8E2F3CEE398C60@CH2PR12MB4892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bz/C6b0CvaLpmX8PrKqBw3yV5kAGYoUTusHCOfKvKC5DW0G5DnyRytPfHjRHK6S1qmc4SDb4OUuTf7TYpPT8a3cxSH6uooyRCipoRWuwNu9OjrhtxyMuQ7ad+NwnqQr6A+AOIJtDYvStHk/kiuLp4AXRjtvY6h2+Qjzc1GBq4eY+vzQapNPYLDo3aKGXKPeoM7/k0LJL0cLm0bHU4VactBPtT9TmKgXhZ+sXzzpTO0/IrMOwsB8gbWv8xQf8HXIlbibgsl0c8owo8UW/wCaueARuifXetXNG/C9N04zulm3TaKLvfCJKe/1sFoiDZgHhKtTMwYtD4I0l4o3TeMc/JwO2TLYryHKAyy/w39QpyTg+RgeEWieF3vybzWu+lrJn2NYSBJAREjlrs4Wemg6Kn1ZYfS86AQQCFikiiv8Ht22LmLonVCs59Qh7c202T5DTqBbCXG8oDLD1toO/cgvpPXfrNYCqvj23fzLUVCNRPg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(21480400003)(66946007)(508600001)(45080400002)(34490700003)(52116002)(54906003)(110136005)(8676002)(6666004)(66476007)(55016002)(7696005)(9686003)(8936002)(186003)(5660300002)(6636002)(2906002)(66556008)(16526019)(53546011)(4326008)(44144004)(1076003)(83380400001)(966005)(86362001)(6506007)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aY+LaOACMoE4cQ1ePqeojzKn0L5ES4BguAgdxrR7HmOcKHsN4n18Yk8oz04V?=
 =?us-ascii?Q?xQzuHYvdrshfpvskfACXaz2P5KCxEYMur/QC/NO5tmRARJaWDwGMegqARen7?=
 =?us-ascii?Q?g6bN8MVK14BOA1ZOfxW/1ZiRFhEtUASq/Yrer1viVdX+atSaIiVNjEWifQa8?=
 =?us-ascii?Q?h2fy8MP3AxXBy0qutCTmRQp390LSRy5TlTHt0wU+Buyg13fYYm3X3rvEWZJt?=
 =?us-ascii?Q?5oLJkr31ig9E1qaJ5D1SwVomVrSp+WKZqtiAS5SKlneBdjNBH5Jkm2H8P3PZ?=
 =?us-ascii?Q?bkHn/n8HmfySNMUhvAPrG8sFhYl9vgaEaqErpibLt5DR8fCinTPPejW6Md0C?=
 =?us-ascii?Q?es90NcVOIjlr9t97bl8llM6dYfKwRjMQK5NCRgcehPiQ7c/fxU4Rr1d1ngDV?=
 =?us-ascii?Q?87C4lJ1Y8oCHyYlXUAY+K+YkkGbZSnFQFPk0+43mZ9Elho32XtXra9zPFsqf?=
 =?us-ascii?Q?Wj/0KKSHKM2SZSWT2xhqUhchEvUTaZAhRrckIluSFBS1OxWn429aYXwUEjhp?=
 =?us-ascii?Q?tomDNM2Eoel4nESmzoyTeCHQ6ema0s4ujIQ7Np8ZHh7X5J8FsmzRfOlrI5ue?=
 =?us-ascii?Q?NfjVChq+daTjdAw0Y0W3VdV3+i5I14WwafBD1mVwfR/U+BVHv1L2P6QHweVe?=
 =?us-ascii?Q?ssynjE9lKOxLYW1Tj61FJP+8xaNFMh8vxPofsWjovRf7ZIM2Vmxs+5SXKgix?=
 =?us-ascii?Q?EBD/v6RKT8iYytrtOwOxzti4ZWATBM7pUrBIO2Jqc6fygt0G0abXdptZtYYO?=
 =?us-ascii?Q?bpdw+91axUSwD0UtPTlVL/Lkukds31h57eQUm9Q+7xLcMldc5ylIgIRJAoMg?=
 =?us-ascii?Q?KJYdLwAW+adYM4ykl36/YRaxBa626q+9ozFDpER2rhLOViDsVbnTzpuLaCKF?=
 =?us-ascii?Q?iYNTqnt927RHHCKuq11fdr2fTbVRmMnj/j4oy+fL8yRtjmU8V3Rt+J68lrzp?=
 =?us-ascii?Q?qt015KBGMSr/sv8tHYxHBJv0+8xH7nbXvv6/KSZxh+5C4KUJX8BALhWwzdjm?=
 =?us-ascii?Q?pxvlNA6YkHWeRBUIsi5qiRs9JQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 18:56:11.0824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d331a8e-65a3-4c24-954f-08d8a12b16d8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjvVlBA3bIK38j++WgzbZYmJ0zN+5qzgAEJlVbzA6XSjBYWMVAuLaOWj3MkXolH5yMNKhWX5QYVxqhGWMk3nQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Borislav Petkov <bp@alien8.de>,
 Chiawen Huang <chiawen.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0686994376=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0686994376==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vtn5l5az3slue4ns"
Content-Disposition: inline

--vtn5l5az3slue4ns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

Make sense to me, and I can drop the ASSERT before apply the patch.

Nick, Harry,
Do you have any objection to drop this ASSERT?
=20
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

--vtn5l5az3slue4ns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl/ZBsAACgkQWJzP/com
vP/0Uw/+INE6jWrqhhjNcZIuiNW82TCjBCsf2ICyUO9ffWGbeaKMAsGB33G3ydDH
Eg11R/QvyXZUuRcpZxb7Rna5M3e/zg4scQoB5HC2T9Wlm1xMWdTQqi037KMz59Bn
TcuZyycVCnqa8viTJI/SPoDa3BVBq+bG55Q5Kfno1bJ1XqjG2oPywPu1zGh0k7uH
ZoUvw42Hy4JChQ66Rs0nk5rwPt8tGEioHIXvOxDGE8gx36WR72DrxhzmbVvJW+H5
Ts00winjG9hvwSb8GWzGWhync0/EXBiuNVDT7852OAvd0biBKQ/FHGE5Q1pRBPiG
1DmtaXiRppn0cjVgC/wxJshW9VgxT84JtS92nx2WkyT/4qcEnFju1xgFY0EpKKLs
ANQ0/tHfJqgo1aXfgYE2QmFE6LR3/jUtzPihnQoSgo2f9G+NnWgKvE6kKSGg/mnq
+p0wqAiS193c7LkdI2MdysAXGABK53i0PFhJMN+RNsxxbp4998m+sQ8exUrNjVhQ
8Bh8TWyTCgwx7GIseZoF9aR5ORVE6qzMc9Jrcf83pPtPgaaTKbRyBR6OMhknlPZT
5WA3lHATh5Kqi9nmUuEiK6dcZTMMP5IGh7Wos2a2bKcKjm49T2dhRQCe6ncj6Rt/
ItxF/2hrYx8HNsBdm/RYYb+tRWiPPPIVY2TrYBjMA7bm0gkkats=
=IRd9
-----END PGP SIGNATURE-----

--vtn5l5az3slue4ns--

--===============0686994376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0686994376==--
