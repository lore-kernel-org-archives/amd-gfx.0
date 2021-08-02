Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6570BC4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 07:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2105460FC1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 07:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2105460FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FC86E133;
	Mon,  2 Aug 2021 07:42:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ACA16E133
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 07:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I533p5fxGGQAvHbFMtwefd9iLY4CpRgGWvMLj8mK4fmz1qGOfGWeWWVvzXtnBkJzpksSlXkxMY8/4QDpKC+PQ0LiHrw3+G03WFFqbT8oUg/ujTBkifGFH9LvLujDA4Cq1GJzsnRJQeyYmLyfkl05OCmKo0Z+RLuCQV+aTYcrizPTtDdlAsqgWj56Q/mKyAsDn9u9lmD210rPBYpZCDn5TfO0tTtTeyXrb06VjMLGjAarTYLVQhGAQ8jfWXXwI8ZoJqKqpECqU7M14Ph+hRQ3nJ/T8SfkaDF+QyUQxIX7qTUol39pCCIDFnWmJbJV4xrA2YEC3axuwU0NXq4x4CoWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvkNHIq78AsfKb32JCTP/6WLZRqPGJTIoGOLQg4AsIk=;
 b=Ej8Tgqs7SVSWNWD8V9n/KpCnCfn1SrC5j02ichAIz8HJrrV7rqHCfUVCt+FmFOOvmXE3c4yPbc7IXCR1qW4H3lQZQdbjbrvWYvRDjo/EIX1CaH2uIacPGHoexo3ho19ppHRo6AYVKjxmPGqkv5AswznumJPWP181JJbVZaWczcxokKG1NHo+YrYKPqjb/17CqW+w0qCikT7pFCg99HGuttAZ0QMGJVPKSTn+gNbpHYaY0V3q2PcOba80NNYk+kYYhyDK1bx4hlEn9A6z0jg2jlDs0iKCN359KL04b+eL+rJWSS7pfsgmn4rKBCnRz11xzjwjNnVb8OM0DJXktad6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvkNHIq78AsfKb32JCTP/6WLZRqPGJTIoGOLQg4AsIk=;
 b=eJ233Avrdlvu1Cc+rdM2nOmNO6eVQNTg5XaUZSAn+PT5Rp76QaiJjBwchCGW2mU7yNXc7+ptixab54d0bPJrafOPGANO5AHrk4qrosqvmG/WlSXS6T1juc7MHDGEDuFUjZjDjIkzZsF9Pv5LeYWGXbmmFNTrI1neQzXdoM72UlY=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 07:42:47 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::4117:5516:ddb7:1514]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::4117:5516:ddb7:1514%9]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 07:42:47 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: correct aldebaran smu feature mapping
 FEATURE_DATA_CALCULATIONS
Thread-Topic: [PATCH] drm/amd/pm: correct aldebaran smu feature mapping
 FEATURE_DATA_CALCULATIONS
Thread-Index: AQHXh0mf511Ey1rP+0Kq0yaS5Wx6sKtf1OgAgAAAIWQ=
Date: Mon, 2 Aug 2021 07:42:47 +0000
Message-ID: <CO6PR12MB54733B318B38CFF8394EBF08A2EF9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210802025331.727141-1-kevin1.wang@amd.com>,
 <861a03c1-4ee9-4beb-03cb-d892e613e664@amd.com>
In-Reply-To: <861a03c1-4ee9-4beb-03cb-d892e613e664@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-02T07:42:46.738Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0ecc79c-2c70-4434-5909-08d955891f9d
x-ms-traffictypediagnostic: CO6PR12MB5460:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB5460552FB4430E5CC47431D7A2EF9@CO6PR12MB5460.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: grjNNXxyBI6TIH4oRzze+fA7Ayp5mTOC5wfJjaeV563svxcikRJvgSILj2w0RhU/QT0xgSbwZEtkokchi30Wltgcmgkhh9nRvJx0dHLgUCCiZ/kViMHZpc3UmaAC7DETgYikg/thr/VAGn/5vrN9sZ3r/w31CiWuuhesaCBX0nuIx4GlL/I3vNHb8HuEFqWXntYd09PkEQ7JIMwezROC9iAT10c8hljl62MK9NEtV+FzysMD2ohdGDH1vS+UlmYnYIDsUcgkDHtSOYyIMOx3g3II7Ax+cN5uGIqnEOSHcB3s5CBAXuJkunt3bqCUlsr3iQOTfT6QlEo+QOu5SpaQyaneYFWykwe+gdL1hMBxC+xfAlxWrkbmxQsfdKPoOdNMCoTsAJbvyOYrT0YRQ+SeO7s7TWaifu1S9DOAjcp7hjYpBMOab0wMMyEFjVKH9syshyx/ycUQcHPVG8SrM8ubM55U/WBzHnSIZ/ZAsI5VxBxcVEy65aLIJmoe3lId4ySx+ZEX0dGc1q2kIOY3D9Eizkh2zqaHLOk+1jYnAHeKKYoG977rl+1hs6gr7cWgXkIewuPZlMeHWC8XoKuF4dB9FxHvUgZHZG31S5XSiExYEhvCI2GGNkzmFlY6RELVyPDpvAR3CPF6o80IYu7quMS5xM7oYlHVVBYFGRG8qX8H52BYQtJZcHhO0O66Re59s/8qH7br7QfTXivt4d/OogR0ow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(38070700005)(66946007)(66476007)(19627405001)(186003)(86362001)(66556008)(110136005)(52536014)(26005)(64756008)(66446008)(478600001)(33656002)(53546011)(6506007)(9686003)(91956017)(122000001)(71200400001)(76116006)(316002)(2906002)(8936002)(5660300002)(83380400001)(8676002)(55016002)(38100700002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Bru0dej83urOpizLgcJ1uh4cchigYHxzG7pEgDUWcbMPUy0E5ZbsyWnKNl?=
 =?iso-8859-1?Q?wfMtSLGCRNkXzcmv3vrB4t+8e1qhwUjglOBZUcKh7oSr5EPjFkgRGqTvH/?=
 =?iso-8859-1?Q?nfZQ9V60oJOldzdDT6wknHo1auFSJtBzur55oZUWnjlckbgxXltU4Co9yB?=
 =?iso-8859-1?Q?sKh7/OAUT0RJlF6Z5pzoD1Q/c8TKY0fXleh11sYqexgnYu8fnb5wBOKnIE?=
 =?iso-8859-1?Q?yWln5TlprqN6wksiGvNyUr869i2oaNm/RPQslaKYND6cvDod5J5LhkTNfh?=
 =?iso-8859-1?Q?RGgKUNmIKzZDIky8o1kpztLWJPYhygwXQPPlSMp5PT8MEEE3mMs+elXdMr?=
 =?iso-8859-1?Q?6p8Mb5TsW17ZDKs9PDu9o2R009s6w9wiFNYXgjGY3WvmQZrrpkUDxKKeFf?=
 =?iso-8859-1?Q?YnlqXxd/X5Ns8nwiSjtP8qjNce7JLiChl+hv9QUVS57BPyeWAKnYdWvgYh?=
 =?iso-8859-1?Q?7gRr7qH7NofSruaTlBlTAQSuAlAZrduXwv6ZfjxdHCaLE7B4Y5e3Fip9+9?=
 =?iso-8859-1?Q?FFPFsLYUlo4vQI+0h8EdkEZtMWqt+gW6n2tqMkfsAkq5+OgQ1E/xsQDuzF?=
 =?iso-8859-1?Q?HLYZfBjrXjMzlc01jfAmTWYLMStKSyEFAjeK3rAyejbXpPdwlY7qKbFeBU?=
 =?iso-8859-1?Q?sElCD1YcG5enL2SuiUuGlIUcoQnfxq9bvoBuR1ERulF9GB6Kq8TRNzAPcS?=
 =?iso-8859-1?Q?puDIOIY5CqJ/DG1LFjl6yIedEWCG2FEEQDZJGxCLt4Ha7ueu7E9FIknxHQ?=
 =?iso-8859-1?Q?UkmmrrXerz2DFpFQLgtqBNwaQ9istdhVoZl2zuNua0sHbtPUD0tKCw6ZG7?=
 =?iso-8859-1?Q?4gJlI6GHq7oyI7Gd3IjEFkFHLdnHEdOeCs+RoCpYmChmF4HhwGUL3AJOu1?=
 =?iso-8859-1?Q?jwKZQVQasP8IBBAl/1rpboBpJhswFxACkRgMHwP8ILl8mLs6/bQrAY3rLZ?=
 =?iso-8859-1?Q?hYrMg+Mu0yqZrCq9ZNWxdF1rtY+sve8Ge32EzK+8Lhkhvb+m6Nz4JOv06p?=
 =?iso-8859-1?Q?JaIdkEtdh/89+Oe28ZTEMCXvupS7uEpdqwtSR8cEKRs/MDBQ+b/EY/1umN?=
 =?iso-8859-1?Q?evsGr+fa+dS7qahhHCD1NbAGdixSEEQagGyQVINzdfkLSLd26WABN5Wkdi?=
 =?iso-8859-1?Q?YZpys5D7tG12qpS0sep1CI5YY4wDnqo9vqqywxvcfsztUbO16lvavXOWzh?=
 =?iso-8859-1?Q?+b5sv5JQDLebpyXrjofWahkIlMCwDY+HxtUgzWVBWREvXKQo9nSurw3Cb+?=
 =?iso-8859-1?Q?hfdOrJ747/afIOf6+B31RGizo4YQG3HFaRr7wiwGSnReyM9/dB0UMDxS7V?=
 =?iso-8859-1?Q?WmnpHTnLvt+lfZ682P5UF5FHs7T66kIzt06p8vVGivgvijLdHd+/AQrW19?=
 =?iso-8859-1?Q?FG/MwvrpZz?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB54733B318B38CFF8394EBF08A2EF9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ecc79c-2c70-4434-5909-08d955891f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 07:42:47.4810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yY2Ri8dcAv/sYxFPs6nP/UOGIeDUx++d0SQWEufGvvgR7cKquPj8aNOJev8/zmTf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB54733B318B38CFF8394EBF08A2EF9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]



________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, August 2, 2021 3:41 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: correct aldebaran smu feature mapping FEAT=
URE_DATA_CALCULATIONS



On 8/2/2021 8:23 AM, Kevin Wang wrote:
> correct smu feature mapping: FEATURE_DATA_CALCULATIONS
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/inc/smu_types.h             | 1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 +--
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd=
/pm/inc/smu_types.h
> index 1d3765b873df..6239c30fcd5f 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> @@ -282,6 +282,7 @@ enum smu_clk_type {
>          __SMU_DUMMY_MAP(TDC),                                 \
>          __SMU_DUMMY_MAP(THERMAL),                             \
>          __SMU_DUMMY_MAP(GFX_PER_CU_CG),                       \
> +       __SMU_DUMMY_MAP(DATA_CALCULATIONS),                    \
>          __SMU_DUMMY_MAP(RM),                                  \
>          __SMU_DUMMY_MAP(DS_DCEFCLK),                          \
>          __SMU_DUMMY_MAP(ACDC),                                \
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 856eeaf293b8..4af602d6ee02 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -64,7 +64,6 @@
>
>   #define FEATURE_MASK(feature) (1ULL << feature)
>   #define SMC_DPM_FEATURE ( \
> -                       FEATURE_MASK(FEATURE_DATA_CALCULATIONS) | \

Data calculations should be enabled for DPM. Undo this change before
submitting.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

[kevin]:

thanks, lijo. I agree with you, and I will correct it before submit.

Best Regards,
Kevin

>                          FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)   | \
>                          FEATURE_MASK(FEATURE_DPM_UCLK_BIT)     | \
>                          FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)   | \
> @@ -150,7 +149,7 @@ static const struct cmn2asic_mapping aldebaran_clk_ma=
p[SMU_CLK_COUNT] =3D {
>   };
>
>   static const struct cmn2asic_mapping aldebaran_feature_mask_map[SMU_FEA=
TURE_COUNT] =3D {
> -     ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_PREFETCHER_BIT,                FE=
ATURE_DATA_CALCULATIONS),
> +     ALDEBARAN_FEA_MAP(SMU_FEATURE_DATA_CALCULATIONS_BIT,             FE=
ATURE_DATA_CALCULATIONS),
>        ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_GFXCLK_BIT,                    F=
EATURE_DPM_GFXCLK_BIT),
>        ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_UCLK_BIT,                      F=
EATURE_DPM_UCLK_BIT),
>        ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_SOCCLK_BIT,                    F=
EATURE_DPM_SOCCLK_BIT),
>

--_000_CO6PR12MB54733B318B38CFF8394EBF08A2EF9CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Monday, August 2, 2021 3:41 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pm: correct aldebaran smu feature mappi=
ng FEATURE_DATA_CALCULATIONS</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
<br>
On 8/2/2021 8:23 AM, Kevin Wang wrote:<br>
&gt; correct smu feature mapping: FEATURE_DATA_CALCULATIONS<br>
&gt; <br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/inc/smu_types.h&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 +--=
<br>
&gt;&nbsp;&nbsp; 2 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/=
amd/pm/inc/smu_types.h<br>
&gt; index 1d3765b873df..6239c30fcd5f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/inc/smu_types.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h<br>
&gt; @@ -282,6 +282,7 @@ enum smu_clk_type {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(=
TDC),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(=
THERMAL),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(=
GFX_PER_CU_CG),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DATA_CALCULATION=
S),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(=
RM),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(=
DS_DCEFCLK),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(=
ACDC),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; index 856eeaf293b8..4af602d6ee02 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; @@ -64,7 +64,6 @@<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define FEATURE_MASK(feature) (1ULL &lt;&lt; feature)<br>
&gt;&nbsp;&nbsp; #define SMC_DPM_FEATURE ( \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_MAS=
K(FEATURE_DATA_CALCULATIONS) | \<br>
<br>
Data calculations should be enabled for DPM. Undo this change before <br>
submitting.<br>
<br>
Reviewed-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
<br>
[kevin]:</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">thanks, lijo. I agree with you, and I will correct=
 it before submit.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Best Regards,</div>
<div class=3D"PlainText">Kevin<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)&nbsp;&nbsp; | \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; FEATURE_MASK(FEATURE_DPM_UCLK_BIT)&nbsp;&nbsp;&nbsp;&nbsp; | \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)&nbsp;&nbsp; | \<br>
&gt; @@ -150,7 +149,7 @@ static const struct cmn2asic_mapping aldebaran_clk=
_map[SMU_CLK_COUNT] =3D {<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static const struct cmn2asic_mapping aldebaran_feature_mas=
k_map[SMU_FEATURE_COUNT] =3D {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_PREFETCHER=
_BIT,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; FEATURE_DATA_CALCULATIONS),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ALDEBARAN_FEA_MAP(SMU_FEATURE_DATA_CALCULATI=
ONS_BIT,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; FEATURE_DATA_CALCULATIONS),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALDEBARAN_FEA_MAP(SMU_FEATUR=
E_DPM_GFXCLK_BIT,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_GFXCLK=
_BIT),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALDEBARAN_FEA_MAP(SMU_FEATUR=
E_DPM_UCLK_BIT,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_=
DPM_UCLK_BIT),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALDEBARAN_FEA_MAP(SMU_FEATUR=
E_DPM_SOCCLK_BIT,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_SOCCLK=
_BIT),<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB54733B318B38CFF8394EBF08A2EF9CO6PR12MB5473namp_--
