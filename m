Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E558C04A94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 15:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E1310E723;
	Fri,  4 Aug 2023 15:31:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 699E310E723
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Aug 2023 15:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9FisC19ecbnk5OupuEJhj2sn65DZfROLTVpe6oXAfUKTspv/ImYidiPF3Q7IjtHHDKa1mBqlaq16XbnfztbRdaytBSBMvf29G9eN++VX3GlEaA6lO67vRSg1toaxCr8zJKgHMMVQ87fmVmUcYEYp5C7Pe0UqT//zN3qVMtwzOglaU3m++hhJ3T5LHmkDYuuG51cl8dOyvEKQmddQjjPzbPpeeEQg7Hdb4Bitir6IUw4ILg1hfKVbWoOE/nHJthAMDl+n+c4rUihJVt7vsEilh+wI9Ahw0GY+uAsrWWb8H/aMlWH/grxeYokq5TSsfjULsu60laP4TQ4RltsU5W6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOJg/dAJPjvde2qr6TvaTG1iejoyHQxhCE7zqGkjHBc=;
 b=eank+UnO5aGBrPqwMxhuLEsNEGkar1Jie2h/02x1Lp4GijamhU5S56s0Ij+OmhwawJKIN3QFoWCW47G5r3sSkdJO3DWlSq783uadwi4zG+8qx4woqFMO9kVkkK2S24uCiWdgA3sNfVoQPRzD7+3x95HgcOGutvtPS/WOvq9xkJb0RCxpwcJCQfcaLknyYFfzd2H9agUKKKvWrPKUoZ0/lEZhSWB2Q/ttn9WeauvnRn/7A6ZDFADx3AveCq2pcGUHF8/tComjRUwMbQgCCEdr0dd8gSWE94o3eLz5Ujs1qoYdYMje/kjMrtznvjn53+fmZMGxNt7yKoXunNrlwqNx2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOJg/dAJPjvde2qr6TvaTG1iejoyHQxhCE7zqGkjHBc=;
 b=GsqUGO40WlemxxAtQj1fJHoaKDKG+CJjFJsFJJbz8+lG9SBSPh/2DgTt6eQpNfsp24/e5txxFXna4iU4sBXTUapzEhd66eF9NyZYOaBjF9RPc/loMausnMd3QYlygUZM02gxivoj2NbUE2Pfl6Lh2Trf5YcOzqbvreZTegBO/wE=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 15:31:42 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ba40:7dba:9b00:ff16]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ba40:7dba:9b00:ff16%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 15:31:42 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: avoid driver getting empty metrics table for
 the first time
Thread-Topic: [PATCH] drm/amd/pm: avoid driver getting empty metrics table for
 the first time
Thread-Index: AQHZxuCgbe6USWdQv02kQqU0pjSG2q/aNIyAgAAPDNw=
Date: Fri, 4 Aug 2023 15:31:42 +0000
Message-ID: <BYAPR12MB46142C9E07BC5A03BDEE83F69709A@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230804143258.1992824-1-kevinyang.wang@amd.com>
 <b7a6f60c-4b3f-e8fe-36f5-d4f329a2a666@amd.com>
In-Reply-To: <b7a6f60c-4b3f-e8fe-36f5-d4f329a2a666@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-04T15:31:01.7004907Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|BY5PR12MB4305:EE_
x-ms-office365-filtering-correlation-id: 83907371-8d01-4054-2a6f-08db94ffe781
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P2YswqKKKjl7xTnm1DEQpr/BXacWTP0qMQW5ttYi06Fw+QNHWUh/erN3dpWsWYjFn0GUIYmwRfKpojwOwohClZUEH4lMnKEiKWaLdrm9lFAlER1KBd0s+GyNDg3kw3ibc6eN+9wHS8AeCyyw10GZXMHU44/5HpkpuhrNAIaOZJBYWF6qF024MJbuvRhPN6PiOBONbbdhfoQr/NPdwoRI2yVZjWRl5ISMVqcPTZGmOQNE+zuDd0XtvRpXAGU1O7fVMs20PWg7FgiKChv55NtiwpyELVPPQmDgzswpYPh7WjxUw6iXC3NRswAhAi52F3SvaT/50ZbDGbCiaawlg4FvsfjaON7Ho2J+xNZ+NEvAot9U4WKWBVoT1XM7LACLk6JWG4StxAw9VBgWQOFmpDNI/t8u+3lHgivBWzSiKjiAqfeQyTBaGktCDoWjm0oHO3fzJZXXVNznVY2pxMl0TgdMLKe3eXHwaBXaLeqqkDxAjhK4zTCrYhY3sNbJj0cG56YJBFw602bIHjiecg7IRRMKZGTvhCqmJq6bPgGJQu1slkd4n3wFrE8AXg1iJgoesShGySQTx6HHNVe9lfRh/ta7ahojhoSn7zIDPpr8JYTzzqZpOub/2vW03SZM0k2yXLDf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(186006)(451199021)(1800799003)(2906002)(7696005)(55016003)(9686003)(86362001)(38070700005)(316002)(41300700001)(110136005)(478600001)(122000001)(53546011)(26005)(38100700002)(71200400001)(5660300002)(52536014)(66556008)(66946007)(76116006)(4326008)(66476007)(64756008)(66446008)(8676002)(8936002)(33656002)(6506007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ejBAhgPi31mTurG3ngQHtJ8Si+7caGG4EW4gnpVfa/IGoykQCCYXdtAg+4SJ?=
 =?us-ascii?Q?T3skwUlURG/NK96jupza+RGflTTjIovv8LvSMIgxooimWIoB15kozxo1fmte?=
 =?us-ascii?Q?mRMOF56VTaRZ4YwBYJH2ZqFa/PQsfmIJhRYEIGDxZMxRrn6egDkAp2rI2Qyi?=
 =?us-ascii?Q?vZUJlYgQ3nVUq/Qk5ZHEM0tYAQFDnV+itZRdFbbwnPUHGvlEYKOTcxs0Y70c?=
 =?us-ascii?Q?ImaQpp7O4JSE3dxpiXlXQroLpt6gYytbhKic7L1V8PEj2ghfhLKfH6R3rNON?=
 =?us-ascii?Q?9bFRpjrCifESFMiJrDJYN2D7J9s4nDqJogxZlfk7b2MKv+p9/p9ZEnRXXVuK?=
 =?us-ascii?Q?nMpSgJn5/++Jr9BqeP2VEmDiDYgWsCgMgLOieigdj/nPB2ej3c/lURwhvYGc?=
 =?us-ascii?Q?AhbuO7RmMgHb/4YL5l0Kd72f1DSctrepYc+Bm44GbtQxqEUE7kIgYccqcKUg?=
 =?us-ascii?Q?GwCrS6J1ZTZvbiSzxVf4iZ9oDxbbIfSeSBPDpCZgmokb8UxzDuV2JyfRjWvF?=
 =?us-ascii?Q?0iwNauhrQjiACqWeehxbxRSOXcS7CnbbXev5wjB/+fCSO3QoGxFaHN1h6VP6?=
 =?us-ascii?Q?Vp7IkrD15juQd7X1DM0W0266QJdj7bqExz0Q7RyScMGmZbyJlr0YluI1KYsX?=
 =?us-ascii?Q?QCmnX4x71zKNWSc2hfQsA62pkgdyWDty0HjXS+4CJUVhVINBb/6iHDyoO5SW?=
 =?us-ascii?Q?XygOFJqTDn7BH8UEefVP6GsBhbdFfETrMSbywfujIqsaLQiuttiHKDaZ2mfe?=
 =?us-ascii?Q?ABSokjHPp06G7A2lm/0X9o6Q5lERzX1eLm8h/h6omJdS9JdFXyDO6gQ5ilfK?=
 =?us-ascii?Q?0Ld/6/U1qUSbBq7Z9+Qztpa9YfO8ybDbZFksGSyImH11ycy+5If9oUpvscou?=
 =?us-ascii?Q?yp7YrGMmSDgtAvzF8PQMV7/SUrnCE/jXP5d4Kyu22IjYYAFVURduwYTjKVO2?=
 =?us-ascii?Q?t3DRMvLqxN1uRT5xsMP2ET2+g/Vyh/5Zm13MOnj1ezyr3SVojWGRYZW1H39T?=
 =?us-ascii?Q?3uUxpV8NZJi8YqoAeCFIKrjqydbNB10lmF31PI//oToWmkTIc1JqF9yH6inT?=
 =?us-ascii?Q?X1h4O6v01jjCDNN6PEjwq+8rR1NJ5Y2QugnU5YTHVG0pt+flfiopid/khOY1?=
 =?us-ascii?Q?Uh33pCnIoSD4He5ZC4Z5EGbmtscgNY8UiCAbtdR5COMSHVRHnCGgAEWOvpGL?=
 =?us-ascii?Q?EHp+859d2gYa83c0WTbhwdzWX+8eA7ksfaiMd2CKv1hChzx/DP0OT7lFw51V?=
 =?us-ascii?Q?RzDBvJnrfD84pVDduA0MyVqkMjOKmNm6IjyocwMb4jGe421Sle0+ZnSwFHUf?=
 =?us-ascii?Q?mMxwG8HW2iigRUUXoAQl0eP1E3aPY5wL87ThTbkbIwnSbMJUb1k/6gbHAGoM?=
 =?us-ascii?Q?W/GE9o/2vnKp6J0ezeF7B1WL5dul0Isiq9nMbm8g3oPX9lHQ0CJzku5kG8TG?=
 =?us-ascii?Q?HgGQFXImqBJwmsYYWpho4b8mPOFfA8Ul8tt/wgOcuN8D4IJGxdD7/fLiXghO?=
 =?us-ascii?Q?of2DEGCeOn/Pm1Yb9gwOeyWzCV8DogblkarG6eSRJ45cofJH21KSsnzC7ACc?=
 =?us-ascii?Q?YiZoPc2QCDTcTVgI6ObziCiUBd7AauOajGCpxHLz?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB46142C9E07BC5A03BDEE83F69709ABYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83907371-8d01-4054-2a6f-08db94ffe781
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 15:31:42.4355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwNrI2cGcshSAfqcLErRrJ7jpc58uU+oqUuB3andR+q7JBtB/zXvfWsVl3kg4MnO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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
Cc: "Kamal, Asad" <Asad.Kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB46142C9E07BC5A03BDEE83F69709ABYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Missed one thing - please replace msleep(1) with usleep_range.

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lazar, L=
ijo <lijo.lazar@amd.com>
Sent: Friday, August 4, 2023 8:07:11 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>
Cc: Kamal, Asad <Asad.Kamal@amd.com>
Subject: Re: [PATCH] drm/amd/pm: avoid driver getting empty metrics table f=
or the first time



On 8/4/2023 8:02 PM, Yang Wang wrote:
> From: Yang Wang <KevinYang.Wang@amd.com>
>
> add metrics.AccumulationCouter check to avoid driver getting an empty
> metrics data since metrics table not updated completely in pmfw side.
>
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
> Reviewed-by: Asad Kamal <asad.kamal@amd.com>
> Tested-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 20 ++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 6253ad13833c..5adc6b92bc49 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -325,14 +325,24 @@ static int smu_v13_0_6_setup_driver_pptable(struct =
smu_context *smu)
>        MetricsTable_t *metrics =3D (MetricsTable_t *)smu_table->metrics_t=
able;
>        struct PPTable_t *pptable =3D
>                (struct PPTable_t *)smu_table->driver_pptable;
> -     int ret;
> -     int i;
> +     int ret, i, retry =3D 100;
>
>        /* Store one-time values in driver PPTable */
>        if (!pptable->Init) {
> -             ret =3D smu_v13_0_6_get_metrics_table(smu, NULL, false);
> -             if (ret)
> -                     return ret;
> +             while (retry--) {
> +                     ret =3D smu_v13_0_6_get_metrics_table(smu, NULL, tr=
ue);
> +                     if (ret)
> +                             return ret;
> +
> +                     /* Ensure that metrics have been updated */
> +                     if (metrics->AccumulationCounter)
> +                             break;
> +
> +                     msleep(1);
> +             }
> +
> +             if (!retry)
> +                     return -ETIME;
>
>                pptable->MaxSocketPowerLimit =3D
>                        SMUQ10_TO_UINT(metrics->MaxSocketPowerLimit);

--_000_BYAPR12MB46142C9E07BC5A03BDEE83F69709ABYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"" dir=3D"auto">Missed one thing - please replace msleep(1) wi=
th usleep_range.</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lazar, Lijo &lt;lijo.lazar@am=
d.com&gt;<br>
<b>Sent:</b> Friday, August 4, 2023 8:07:11 PM<br>
<b>To:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.=
freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Kamal, Asad &lt;Asad.Kamal@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pm: avoid driver getting empty metrics =
table for the first time</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 8/4/2023 8:02 PM, Yang Wang wrote:<br>
&gt; From: Yang Wang &lt;KevinYang.Wang@amd.com&gt;<br>
&gt; <br>
&gt; add metrics.AccumulationCouter check to avoid driver getting an empty<=
br>
&gt; metrics data since metrics table not updated completely in pmfw side.<=
br>
&gt; <br>
&gt; Signed-off-by: Yang Wang &lt;KevinYang.Wang@amd.com&gt;<br>
&gt; Reviewed-by: Asad Kamal &lt;asad.kamal@amd.com&gt;<br>
&gt; Tested-by: Asad Kamal &lt;asad.kamal@amd.com&gt;<br>
<br>
Reviewed-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c&nbsp; | 20 ++=
++++++++++++-----<br>
&gt;&nbsp;&nbsp; 1 file changed, 15 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
&gt; index 6253ad13833c..5adc6b92bc49 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
&gt; @@ -325,14 +325,24 @@ static int smu_v13_0_6_setup_driver_pptable(stru=
ct smu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MetricsTable_t *metrics =3D =
(MetricsTable_t *)smu_table-&gt;metrics_table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PPTable_t *pptable =
=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (struct PPTable_t *)smu_table-&gt;driver_pptable;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret, i, retry =3D 100;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Store one-time values in =
driver PPTable */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pptable-&gt;Init) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_v13_0_6_get_metrics_table(smu, NULL, false);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; while (retry--) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_6_get=
_metrics_table(smu, NULL, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Ensure that metrics =
have been updated */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (metrics-&gt;Accumul=
ationCounter)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!retry)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIME;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pptable-&gt;MaxSocketPowerLimit =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUQ10_=
TO_UINT(metrics-&gt;MaxSocketPowerLimit);<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB46142C9E07BC5A03BDEE83F69709ABYAPR12MB4614namp_--
