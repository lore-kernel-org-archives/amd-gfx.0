Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE687C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 14:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8393920672
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 14:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wgK1aI99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8393920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3313B6E5B4;
	Mon, 20 Apr 2020 14:58:33 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1056E5B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 14:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESMG0aw2D64a96y+dc/4D5Q8wRl5viTR6SB4XSZwy6b+Uo7M3qvIGhHGS7iexBii4d2qqd8ghwSSvccdW7i50p3O10Meq4bwu3bbTCAoCoNoDQfPbptWK9E5dx+jvgI2YaHLrvx+RmT9h438154YCHgdzv20kRqPBYQDIU0nAgJYFZeeEuDBKcOzk6Ln0gWPUROHdWCmCwdXQ0saedmWER10bc31hqy3p/qB/yXyJGDbGySDwu7KbCuCF0wPnT52wXpxCsz/OC5drUITTdEWNiRg5lV2dqVCm4mAidTGaYPlYYoXNkCsc1CUiTQcKhh7las5a5gVPtZYM/KR3fgQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn16Pbnymqpr52RgyjhRNifany2/6gkESuwRWNe3lYo=;
 b=FI+Spwh6n5tG3rd13wnSzHiAU8yrWkcVZsQx/AisGerEOmcrVN1SDEmcL8IfPe7MmE3A+l+bIHMGwX95HrddlPAF6DTAkrh9n9hF931HljxbUmzjFx9a3T7a310tYtD61lBE4ew/TM8qT3Ymei1O6Nc8ZMnvAG+fuq6ESw+co22qLmssezD3nvTe3GQJqIn0KG0T5rkzyEqEFbT/mTXii+rgNbJfIFbf1pM/VB86QnsAvZV8iN8lPlP7H1SscWtwu2+FSOdD1EI3uJOM/PvFv9RbbTyCrPM+7EJbJU/+c3YHZZ3DSDScbv6WnqnwXapRMEEKmbTafLxhD4gcxjb+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn16Pbnymqpr52RgyjhRNifany2/6gkESuwRWNe3lYo=;
 b=wgK1aI99/kL6p/frJauHPAV/Weqb5p+QwqEYoFQlHhqiEic4sS6KhryzxW8N2QuFs27uMuMR6tW+vI8aqb4unXGLg5fg38TO/E97tqntFFLXjA0OjAedzFKrauC/ePsbRUFX6vuNvrKYDj7uCSu76G3fhxOoX/ertbpncla21F8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2410.namprd12.prod.outlook.com (2603:10b6:907:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 14:58:28 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 14:58:28 +0000
Date: Mon, 20 Apr 2020 10:58:22 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 05/35] drm/amd/display: Remove byte swapping for dmcub
 abm config table
Message-ID: <20200420145822.f5v32z62y4lrgpg6@outlook.office365.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
 <20200416234044.2082886-6-Rodrigo.Siqueira@amd.com>
 <MN2PR12MB4488B2003904110CAE92E166F7D90@MN2PR12MB4488.namprd12.prod.outlook.com>
 <c3f3fef6-6c35-7201-c75e-2a72dca42350@gmail.com>
 <20200417214308.347n7xk2d46zx3nd@outlook.office365.com>
 <25091e0c-c465-d455-f991-581aeae744c3@amd.com>
In-Reply-To: <25091e0c-c465-d455-f991-581aeae744c3@amd.com>
X-ClientProxiedBy: BN6PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:404:11::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56a0:11a1::2) by
 BN6PR13CA0060.namprd13.prod.outlook.com (2603:10b6:404:11::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.6 via Frontend Transport; Mon, 20 Apr 2020 14:58:27 +0000
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0686ea0b-00c6-482b-a324-08d7e53b48b8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2410:|MW2PR12MB2410:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2410F440FE167A8C2F2E7F0398D40@MW2PR12MB2410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(21480400003)(966005)(5660300002)(6636002)(4326008)(9686003)(16526019)(186003)(52116002)(2906002)(7696005)(6666004)(6506007)(81156014)(316002)(66476007)(54906003)(66556008)(66946007)(8676002)(86362001)(55016002)(6862004)(66574012)(1076003)(44144004)(478600001)(8936002)(2700100001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gks6GBLWnDBzVqxT9OuNrYbasWcwB6x0U4LDg9iQ85RJJG1KsuC/Qy27odSvR31+yW8Luh7nUYttKuBQ/DLBPGT7q9evagJk7t5xJEOkFW2SQVj5NLkF3XjbDv9jvW9t1asmbWd4JlAlbPGocRWcg32YUBvuJrg9vsgsk9qEbpGLyckSw2+Aa7gOwPyblgk6HrzkU7npb38t3Ot8sbOZWTspw2HpEw8mN3tB0MlDOqx3P4WD4zUo0D+YzJX3EkqDIwHrG6lXXoOtqqlXusPWeJlI6vjbEBqSlqW2iMGLPWUWHP2xsw2b+UOeYCyOLeDWSix5Jid8LSH5RokmC42EtLYfqaVppKVEtmzpjH/rOJqDXmjbA23QBwHY+MI2KyRbSByP3zc5HILDl5LZEzqn2noVYzqbrJkdLltV5w5JwDVoNvLSmAhVYDTseuLrJPmbD3NGcVGrTMGHfN8+YgGWkBtRYnMtKb+k/+Wj0nWDfZalWvQ1QQDtUcq8J4QG/27JnFGwl8H8RGg4choJd8UP4rJ2i7rcFibfUwOFlLZW3Df4MgVisvYoJ0EHf58ly+vm
X-MS-Exchange-AntiSpam-MessageData: O+YGEExsx3lD9lznyPDHslYIfz5d1ev29PQhCmtg+xnSMfUW3R/w3He6TDHtLaKdINn4D/6Ii+YFSIzNDBGQBQro2Eyz07akKOm6gOlZSfBj5X7xeit/gaGiif/QBgbewellkIqTsWKCrK6plM7Dn4n1zQU6c2wj4Vm7G9vp7NzZBUH4sWUoKAaaH5viRQuCVI40aWhCOSKxyhpHRql9C0nQZaxT5AKDTCMDeZMUXNznSTg5AOWx+h4p3oWVPe1n91WuydUtLsUJ1GFtujLJ0YBiWtCktUofnZ6ctDG82XQzcRC1Re13glTNFA9Rw/HAC6TlocXfZSoBv+GmxFVaH6AGeHpshpHaMyIYzd+AdEa1VRsx2DmSsgDE9DbwPoRn0leKPAOGQ3JpzvZtbsGbJcGzjZuElgyJljYir3oHHEjMiY9hwhCCR2cRYtrtAx2itJI3gJ1WaKtuTlpw6+C7C3QQPYV3Ayq89tXXMlM+UhZXC4pfYJd4W1b1dKnvXtK49elCkG6rRck4x4zJ/+BqVeXRfHzdmfFk2azK64zMLlsxjQphyyY6yaEnAZ3GslcovSs6Bd4xNavWEgiToaw4DAkKpD7juhnT5KOClqMyIRORNWddtrisv+Ww1XK/etTntcL93v4amhMtNBujoMOjEVQ/33BSVEkdueC0TUpZH+Wrj45lrG5of9Ekfzm5pYzmL1RJjCR7g6xzNlrgAAE6kgOMLPQOKgwkvIvPIkIXhaR27wT6nJXQhonSFP/W8mj+Az4Z7rHDU4E3EQlUO8lwsBkPIVaeGo/N5wwzRf5/BQAKBKtb26XAUj+wfkAacncT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0686ea0b-00c6-482b-a324-08d7e53b48b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 14:58:28.6812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKSzA8gPAlA5rIFfAeiyFgCSgV8+yFQOjnfVD002TMS7lbtN4E1vGu9cBKbTWIvIUvu07cmp5dnSb+EjnwLcog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2410
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Wood, Wyatt" <Wyatt.Wood@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>
Content-Type: multipart/mixed; boundary="===============2016912111=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2016912111==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3mgpeptjq64bjedo"
Content-Disposition: inline

--3mgpeptjq64bjedo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04/19, Christian K=F6nig wrote:
> Am 17.04.20 um 23:43 schrieb Rodrigo Siqueira:
> > Hi,
> >=20
> > Wyatt made the below patch for fixing this issue. I can apply it on top
> > of this patchset if you all agree.
> >=20
> > [Why]
> > Current code does not guarantee the correct endianness of memory being
> > copied to fw, specifically in the case where cpu isn't little endian.
> >=20
> > [How]
> > Windows and Diags are always little endian, so we define a macro that
> > does nothing.  Linux already defines this macro and will do the correct
> > endianness conversion.
> >=20
> > Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
> > Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
> > Acked-by: Anthony Koo <Anthony.Koo@amd.com>
> > Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > ---
> >   .../amd/display/modules/power/power_helpers.c | 58 ++++++++++---------
> >   1 file changed, 31 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c =
b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> > index edb446455f6b..8c37bcc27132 100644
> > --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> > +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> > @@ -265,9 +265,11 @@ static void fill_backlight_transform_table_v_2_2(s=
truct dmcu_iram_parameters par
> >   		ASSERT(lut_index < params.backlight_lut_array_size);
> >   		table->backlight_thresholds[i] =3D (big_endian) ?
> > -			cpu_to_be16(DIV_ROUNDUP((i * 65536), num_entries)) : DIV_ROUNDUP((i=
 * 65536), num_entries);
> > +			cpu_to_be16(DIV_ROUNDUP((i * 65536), num_entries)) :
> > +			cpu_to_le16(DIV_ROUNDUP((i * 65536), num_entries));
> >   		table->backlight_offsets[i] =3D (big_endian) ?
> > -			cpu_to_be16(params.backlight_lut_array[lut_index]) : params.backlig=
ht_lut_array[lut_index];
> > +			cpu_to_be16(params.backlight_lut_array[lut_index]) :
> > +			cpu_to_le16(params.backlight_lut_array[lut_index]);
> >   	}
> >   }
> > @@ -596,7 +598,9 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_t=
able, struct dmcu_iram_parame
> >   	unsigned int set =3D params.set;
> >   	ram_table->flags =3D 0x0;
> > -	ram_table->min_abm_backlight =3D (big_endian) ? cpu_to_be16(params.mi=
n_abm_backlight) : params.min_abm_backlight;
> > +	ram_table->min_abm_backlight =3D (big_endian) ?
> > +		cpu_to_be16(params.min_abm_backlight) :
> > +		cpu_to_le16(params.min_abm_backlight);
> >   	for (i =3D 0; i < NUM_AGGR_LEVEL; i++) {
> >   		ram_table->hybrid_factor[i] =3D abm_settings[set][i].brightness_gai=
n;
> > @@ -620,30 +624,30 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 *ram=
_table, struct dmcu_iram_parame
> >   	ram_table->iir_curve[4] =3D 0x65;
> >   	//Gamma 2.2
> > -	ram_table->crgb_thresh[0] =3D (big_endian) ? cpu_to_be16(0x127c) : 0x=
127c;
> > -	ram_table->crgb_thresh[1] =3D (big_endian) ? cpu_to_be16(0x151b) : 0x=
151b;
> > -	ram_table->crgb_thresh[2] =3D (big_endian) ? cpu_to_be16(0x17d5) : 0x=
17d5;
> > -	ram_table->crgb_thresh[3] =3D (big_endian) ? cpu_to_be16(0x1a56) : 0x=
1a56;
> > -	ram_table->crgb_thresh[4] =3D (big_endian) ? cpu_to_be16(0x1c83) : 0x=
1c83;
> > -	ram_table->crgb_thresh[5] =3D (big_endian) ? cpu_to_be16(0x1e72) : 0x=
1e72;
> > -	ram_table->crgb_thresh[6] =3D (big_endian) ? cpu_to_be16(0x20f0) : 0x=
20f0;
> > -	ram_table->crgb_thresh[7] =3D (big_endian) ? cpu_to_be16(0x232b) : 0x=
232b;
> > -	ram_table->crgb_offset[0] =3D (big_endian) ? cpu_to_be16(0x2999) : 0x=
2999;
> > -	ram_table->crgb_offset[1] =3D (big_endian) ? cpu_to_be16(0x3999) : 0x=
3999;
> > -	ram_table->crgb_offset[2] =3D (big_endian) ? cpu_to_be16(0x4666) : 0x=
4666;
> > -	ram_table->crgb_offset[3] =3D (big_endian) ? cpu_to_be16(0x5999) : 0x=
5999;
> > -	ram_table->crgb_offset[4] =3D (big_endian) ? cpu_to_be16(0x6333) : 0x=
6333;
> > -	ram_table->crgb_offset[5] =3D (big_endian) ? cpu_to_be16(0x7800) : 0x=
7800;
> > -	ram_table->crgb_offset[6] =3D (big_endian) ? cpu_to_be16(0x8c00) : 0x=
8c00;
> > -	ram_table->crgb_offset[7] =3D (big_endian) ? cpu_to_be16(0xa000) : 0x=
a000;
> > -	ram_table->crgb_slope[0]  =3D (big_endian) ? cpu_to_be16(0x3609) : 0x=
3609;
> > -	ram_table->crgb_slope[1]  =3D (big_endian) ? cpu_to_be16(0x2dfa) : 0x=
2dfa;
> > -	ram_table->crgb_slope[2]  =3D (big_endian) ? cpu_to_be16(0x27ea) : 0x=
27ea;
> > -	ram_table->crgb_slope[3]  =3D (big_endian) ? cpu_to_be16(0x235d) : 0x=
235d;
> > -	ram_table->crgb_slope[4]  =3D (big_endian) ? cpu_to_be16(0x2042) : 0x=
2042;
> > -	ram_table->crgb_slope[5]  =3D (big_endian) ? cpu_to_be16(0x1dc3) : 0x=
1dc3;
> > -	ram_table->crgb_slope[6]  =3D (big_endian) ? cpu_to_be16(0x1b1a) : 0x=
1b1a;
> > -	ram_table->crgb_slope[7]  =3D (big_endian) ? cpu_to_be16(0x1910) : 0x=
1910;
> > +	ram_table->crgb_thresh[0] =3D (big_endian) ? cpu_to_be16(0x127c) : cp=
u_to_le16(0x127c);
> > +	ram_table->crgb_thresh[1] =3D (big_endian) ? cpu_to_be16(0x151b) : cp=
u_to_le16(0x151b);
> > +	ram_table->crgb_thresh[2] =3D (big_endian) ? cpu_to_be16(0x17d5) : cp=
u_to_le16(0x17d5);
> > +	ram_table->crgb_thresh[3] =3D (big_endian) ? cpu_to_be16(0x1a56) : cp=
u_to_le16(0x1a56);
> > +	ram_table->crgb_thresh[4] =3D (big_endian) ? cpu_to_be16(0x1c83) : cp=
u_to_le16(0x1c83);
> > +	ram_table->crgb_thresh[5] =3D (big_endian) ? cpu_to_be16(0x1e72) : cp=
u_to_le16(0x1e72);
> > +	ram_table->crgb_thresh[6] =3D (big_endian) ? cpu_to_be16(0x20f0) : cp=
u_to_le16(0x20f0);
> > +	ram_table->crgb_thresh[7] =3D (big_endian) ? cpu_to_be16(0x232b) : cp=
u_to_le16(0x232b);
> > +	ram_table->crgb_offset[0] =3D (big_endian) ? cpu_to_be16(0x2999) : cp=
u_to_le16(0x2999);
> > +	ram_table->crgb_offset[1] =3D (big_endian) ? cpu_to_be16(0x3999) : cp=
u_to_le16(0x3999);
> > +	ram_table->crgb_offset[2] =3D (big_endian) ? cpu_to_be16(0x4666) : cp=
u_to_le16(0x4666);
> > +	ram_table->crgb_offset[3] =3D (big_endian) ? cpu_to_be16(0x5999) : cp=
u_to_le16(0x5999);
> > +	ram_table->crgb_offset[4] =3D (big_endian) ? cpu_to_be16(0x6333) : cp=
u_to_le16(0x6333);
> > +	ram_table->crgb_offset[5] =3D (big_endian) ? cpu_to_be16(0x7800) : cp=
u_to_le16(0x7800);
> > +	ram_table->crgb_offset[6] =3D (big_endian) ? cpu_to_be16(0x8c00) : cp=
u_to_le16(0x8c00);
> > +	ram_table->crgb_offset[7] =3D (big_endian) ? cpu_to_be16(0xa000) : cp=
u_to_le16(0xa000);
> > +	ram_table->crgb_slope[0]  =3D (big_endian) ? cpu_to_be16(0x3609) : cp=
u_to_le16(0x3609);
> > +	ram_table->crgb_slope[1]  =3D (big_endian) ? cpu_to_be16(0x2dfa) : cp=
u_to_le16(0x2dfa);
> > +	ram_table->crgb_slope[2]  =3D (big_endian) ? cpu_to_be16(0x27ea) : cp=
u_to_le16(0x27ea);
> > +	ram_table->crgb_slope[3]  =3D (big_endian) ? cpu_to_be16(0x235d) : cp=
u_to_le16(0x235d);
> > +	ram_table->crgb_slope[4]  =3D (big_endian) ? cpu_to_be16(0x2042) : cp=
u_to_le16(0x2042);
> > +	ram_table->crgb_slope[5]  =3D (big_endian) ? cpu_to_be16(0x1dc3) : cp=
u_to_le16(0x1dc3);
> > +	ram_table->crgb_slope[6]  =3D (big_endian) ? cpu_to_be16(0x1b1a) : cp=
u_to_le16(0x1b1a);
> > +	ram_table->crgb_slope[7]  =3D (big_endian) ? cpu_to_be16(0x1910) : cp=
u_to_le16(0x1910);
>=20
> That you have to duplicate the values is rather ugly here.
>=20
> Since this is all in one file maybe come up with a helper for this? E.g.
> conditional_bswap16(big_endian, value)

I'm going to prepare a patch with your suggestion.

Thanks
=20
> Regards,
> Christian.
>=20
> >   	fill_backlight_transform_table_v_2_2(
> >   			params, ram_table, big_endian);
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--3mgpeptjq64bjedo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl6duIoACgkQWJzP/com
vP8GYw//ewVXfQl0H5uUHGZgEIgMHelzimYnIsNrjjsN7OSCXvElFRzrFFqktbr5
lIsRmn3vKY0sMOnaeWJZTsMSmlCBMvYTKvQiPBMUBiiKCmPPCagUrDHXSOMqQUd2
bHlg7u3QtAQsW3O5ZOde9GmVzdSNTBzC7GbEcBXPO7sZ/XMuY3xQqnn6iP2LRVE/
+TxE6BuBKpqvQKZuuBzIaUmpWtcg7kvVzMQuJK5vpyMaJM8eB/PJc2iCcOZhoHFa
DFqFCCYtvytJ/D2/i3xe8As4TzauALW0hG+8phwbgIBaPrmR/tU0880HCTNozzfo
A3mH/RZ/JbUAN6KFVx+HVDnV2CRqmEq23tC0fK4nQ3l/t4GGAbxm+s5Sk6EMpO3b
/W82CQE2d7lAgoHi27+Aa2DpncW6y3I5orq9bzTTgORP+t62jz0QEpOEP3Li+5zi
8vx3dvRztfWy9P2YmzI2Y21FQj6CtfEetgT6nxJgO51XgJYcthXTRSHBrKymNsUK
kqKeGnyP22xcdfT5Fg2r6mUMGgvra3hqsupHaKofiZnZuo2Yu6m0Guy68Cp1B5bv
0f1CoKIvhfpggmyu412ut68EJ0HFwopRSzuYjzVtg9wFSlVuepPf1b0qHXKWcfVQ
mCND5S0jpRP0jjyND7JIll+thKM/hflvRpjd++MOrNEYR9FIy7g=
=uuY+
-----END PGP SIGNATURE-----

--3mgpeptjq64bjedo--

--===============2016912111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2016912111==--
