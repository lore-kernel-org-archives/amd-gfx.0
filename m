Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBB3C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 06:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1BB61209
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 06:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1BB61209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF336E046;
	Mon, 12 Apr 2021 06:11:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B891A6E046
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 06:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hidFJbhrTuQTiSwWZOxCHtcicxiNZPsuNDsFlZ1fC6hubnUylZ/nAWvYqO1gREfs+Wp9YUqL7tmxJbEw5z3T4gpsif0mGRUlkRTibXEhzbF85HOJCaaqJjoEMI+dNFOusiA9HyOpR4JdZoeYyAV8omanfq0FJw/KNwKw5knZgXyiGqDg7MWncI26Z+askjIaMGsBs5K8J8RNI2Orl0ksu1wjF9aH5EiDyPmpJlZ5fS5ZTQIRK5agq8kV5WHEvmLwAUxdwzi8CAxL9KRwoS9ynqC/lF/9tcHGUkIUN/BqeU5GkWr2ekDnXPiTiIlwx0EBNgTfgoIllIbP+CnZP5+xJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqLmeuBXgdnWM/avYQoodf7LRPZN/WXDLHMz+qNRJ5Q=;
 b=EozSj5U5hBbcqNuQ6sax0nXBZ0ZW2a13YUGyelcwi6S47zQ0v3sJaT8mr3By4YLbp7yjp/gbjHMWUYQI5DOtb1164epCJGEx8CYPwgTFIHqVNi+MPJjd6KO9H2FGk0dreHqW08lGBNNlpdA7C9HfeaP8IOOy2A9Gde2ppFQV18YkWk3QtM6OuYkZsSAWzKqge58bhRZ7CClC23i6nZdISCD1Nv8vMDFEWw1TZtqNBZ5E2VDZw+j/zIb6O0adbvqEyY8fokznbbo6bR3HDgNev71XNxr4icaiYs+Yx+3QQ8k+vAnutsZObjtY+tpIlqF5XvZXe0dUrhRIA44zDkTEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqLmeuBXgdnWM/avYQoodf7LRPZN/WXDLHMz+qNRJ5Q=;
 b=vJc5EU5arNz91S1Vmq148GcPbjuIPi4EJnyxzK3IAqdOzWL1abYWC709af3Ci+5asPWO4+xFUVWl27oSdj6ib9HKFXFesZ9+wsZHrdw4JBC4tR7/U2cC3lbYUfljg6Hbh0SB5m1Hcw5NWhQDs8JRgZr6AiQm7ChTu2FGstrKy1Q=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3423.namprd12.prod.outlook.com (2603:10b6:208:cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 06:11:33 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::8da7:cf00:1356:1199]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::8da7:cf00:1356:1199%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 06:11:33 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: Use VBIOS PPTable for aldebaran
Thread-Topic: [PATCH] drm/amd/pm: Use VBIOS PPTable for aldebaran
Thread-Index: AdcvYcvnGouKBqz9SOC8GbANB1m7RgAANa/m
Date: Mon, 12 Apr 2021 06:11:33 +0000
Message-ID: <MN2PR12MB30225CBF9506F26EC94C89C0A2709@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <MN2PR12MB4549536629A4C68E418BA83097709@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549536629A4C68E418BA83097709@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-12T06:11:32.455Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbfa2f17-fcdb-4dbe-fca7-08d8fd79d24f
x-ms-traffictypediagnostic: MN2PR12MB3423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3423E51B8F5DF37534FCC88BA2709@MN2PR12MB3423.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VrMYty/SwYwwi5HE9+uwT6ItIwufagb92AQfdkvNtmYSFLxb+QYH3OkDh8NGB1IBX32dHkYqOphxyVyf18+897iKBkik/q1TAlj2R5hXDVN+yCF1gv/Y7dlyenT/nPIVFNjK2pshk5/s1mEYrlmd1/8PHke/IJMV6VfcBrKlWZoGT1u8okyr4fVtOfhMQt68bFgAZV9yU785DBQkL6dh8JP2XMh0YQQicWbvoKk8q9x1ZJREhRERwrsqkY2kdsc7GOJRt1zwLjTknHIMCa8wy/6uuMkQeSwfDscgOPsl9VzLaTGqrUpOBR/z5yYw9cEnoWNuieAxH6VtAQ4LwrXoaT4fvDOZVJwh2b7+9Oq/RMnwen0TlERzDEa1BH6jsbyxWrTHdg/qzF5/6r2m+OerZUoYuMI3GWGqOlrscc6DlrpdIwETg6z0eY6/4/2TbR/tcwgox/J4wByouyjsORDgPV5dDfEYWvSYqfUS1ZILFXUIdOTIXN7xq6FaaeVrvKuGJm61ivpN/P+kRNvlwEQGfU52R3+ZGSGlMbn8SFxyoz2tNbbAjVztW56w5tMwUX0uFw115faeqV6/x+lc0a3sAY3NJmEWaWEV8Mu3Un8FiEI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(54906003)(110136005)(2906002)(55016002)(86362001)(478600001)(186003)(71200400001)(19627405001)(9686003)(4326008)(33656002)(316002)(6506007)(53546011)(5660300002)(83380400001)(8676002)(8936002)(91956017)(66446008)(66946007)(64756008)(76116006)(66556008)(26005)(7696005)(52536014)(66476007)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?qKlpdFqgeVb3XJaek+F0Pive5AgAvvZ6AFz1TlG5NJ7Gu0uPIylqdVznkp?=
 =?iso-8859-1?Q?DXmR+tzP+l7lIV0nkFzii0xIOO30j5Nc8Bk3EeJz4WsCfty7hoQ98M7Vik?=
 =?iso-8859-1?Q?+El2idXw+xdF4Gz9iaIM28QTM8qBezHspObArvh2jtNNXuzlffg7H9iPNl?=
 =?iso-8859-1?Q?7KThTdhJ5eIh6qPxrBKb/Uf7Vh22b1g/X5tB/crk4q6ZXTB/hwfWWjofbT?=
 =?iso-8859-1?Q?/YhPTCApzOp6KVhqohArPKDa/1NKkQDSAQ9iNapfNwDa9S+AWJNo0etkF9?=
 =?iso-8859-1?Q?yyYbey0gGBPbq2+EtgF6eqdIdT3lgoce5oLXJiZn2N6e14cF1FB394F6t+?=
 =?iso-8859-1?Q?lNDgqAzXTDF4480MAYXYvHZdwdUsgCJMG3VF86k6pUXB8/ZomjoKFt/6/u?=
 =?iso-8859-1?Q?o/TDq4vl6TrJ7ZiPmZtOJtaoHWXP3Dku/2K/V4pkM57bRhgZu2S/Aw2+HN?=
 =?iso-8859-1?Q?IiNVpE+D8pQ5a5MMzgXmvUNz43IgGwOH5neSn+sivKKV8mpGaF03VUusXf?=
 =?iso-8859-1?Q?3ZDad8PJVT5ap2czD8W7ZzJJmOnsSUioCAiirz54BtdXhS6NdzpTkjGK1F?=
 =?iso-8859-1?Q?OEtKKM9wkrt5I2hs4XMs9eJ91657ZHxiX/hb4gC4mGMVQcaGFB8bEXM3FM?=
 =?iso-8859-1?Q?aTUlx/fkZK5npoKwoGJNk1TwkvjIbWy2w1uFGhlgQEqYhdDi+sWqWSdnKi?=
 =?iso-8859-1?Q?e9V/Wb1SdhVDVrvuMeDMc2ZGfFr3Z1OOPb4ER/Hr8PRlmxsrD/z6Fwd8BQ?=
 =?iso-8859-1?Q?FtOYUzngFZtVlv97wYy9hchsGUb/Y6KyvQLx1o6jK6R6L7HyhZtSxl4cBG?=
 =?iso-8859-1?Q?BA9g7eGeXumydO8qNV9vh2d5u9268CUt3IjgjfPSdfgyJJOlr0KkgwZGVu?=
 =?iso-8859-1?Q?D6zkEFQ32ndKMGUcdNfaPqCjs9edhn8X1OTEl3INIbaoP1sYhxu2V6dBz1?=
 =?iso-8859-1?Q?AtgTY7jbgL+BwATVeivfdWw0+OqnU8AMi2kzjt/XGRFrRYtrLJEC3Vzysx?=
 =?iso-8859-1?Q?8jZhaPX2VYsy5Lmxluukrkt471uOqPpSAjxENFKT9y2I4EmxWRCm1wcfRA?=
 =?iso-8859-1?Q?r6oz/ADddR98r2Vyjz9Hj05k+pmIzbsGmH/Z5bikjcDuJF/EpaqKm9lZYw?=
 =?iso-8859-1?Q?WHFLDbLw8YJy9riQry87V5Qf0iG5fqWgPk/EdRWsTzGnWFIBfgyTL2ibv5?=
 =?iso-8859-1?Q?ALl/K/IsD2Vqgh23iFNi9LI6pzsVG8FOmkyrna1sIx7UdxklueSsBBL9xJ?=
 =?iso-8859-1?Q?zVo0q6GIWdaO0GJkkLGdFVOKj9pS/idyHeDp/OmBMT3s4diDq8ssqlVJV5?=
 =?iso-8859-1?Q?yZ8coBKqRpTse+5i0eKTFr1kPWbwKuakkOdEw/SDYYTogGGsfxyfXsUEel?=
 =?iso-8859-1?Q?7UOWX2MdTv?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfa2f17-fcdb-4dbe-fca7-08d8fd79d24f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 06:11:33.3183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmJcEj+BFOzX7yYAxFBGIKIYiu5cWKKwWrbG9oiQ/gB1ObuGnjcRHrQbx7jzB/xe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3423
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0198648349=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0198648349==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30225CBF9506F26EC94C89C0A2709MN2PR12MB3022namp_"

--_000_MN2PR12MB30225CBF9506F26EC94C89C0A2709MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, April 12, 2021 2:06 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;=
 Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Use VBIOS PPTable for aldebaran


[AMD Public Use]


Keep the logic to force-use VBIOS PPTable in aldebaran rather

than in generic SMU13.



Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>

---

drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 +++

drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     | 2 --

2 files changed, 3 insertions(+), 2 deletions(-)



diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c

index abe80226a0ee..af6e0ce9b6a7 100644

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c

+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c

@@ -407,6 +407,9 @@ static int aldebaran_setup_pptable(struct smu_context *=
smu)

{

               int ret =3D 0;

+             /* VBIOS pptable is the first choice */

+             smu->smu_table.boot_values.pp_table_id =3D 0;

+

               ret =3D smu_v13_0_setup_pptable(smu);

               if (ret)

                               return ret;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c

index 30c9ac635105..0864083e7435 100644

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c

+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c

@@ -276,8 +276,6 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)

               void *table;

               uint16_t version_major, version_minor;

-              /* temporarily hardcode to use vbios pptable */

-              smu->smu_table.boot_values.pp_table_id =3D 0;

                if (amdgpu_smu_pptable_id >=3D 0) {

                               smu->smu_table.boot_values.pp_table_id =3D a=
mdgpu_smu_pptable_id;

--

2.17.1

--_000_MN2PR12MB30225CBF9506F26EC94C89C0A2709MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Monday, April 12, 2021 2:06 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Use VBIOS PPTable for aldebaran</font>
<div>&nbsp;</div>
</div>
<div lang=3D"EN-US" style=3D"word-wrap:break-word">
<p class=3D"x_msipheader251902e5" align=3D"Left" style=3D"margin:0"><span s=
tyle=3D"font-size:10.0pt; font-family:Arial; color:#317100">[AMD Public Use=
]</span></p>
<br>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Keep the logic to force-use VBIOS PPTable in aldebaran rather</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
than in generic SMU13.</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.lazar@amd.com">lijo.lazar@=
amd.com</a></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
---</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 +++</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 2 =
--</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
2 files changed, 3 insertions(+), 2 deletions(-)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
index abe80226a0ee..af6e0ce9b6a7 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -407,6 +407,9 @@ static int aldebaran_setup_pptable(struct smu_context *=
smu)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
{</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; int ret =3D 0;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /=
* VBIOS pptable is the first choice */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
mu-&gt;smu_table.boot_values.pp_table_id =3D 0;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; ret =3D smu_v13_0_setup_pptable(smu);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; if (ret)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
index 30c9ac635105..0864083e7435 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -276,8 +276,6 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; void *table;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uint16_t version_major, version_minor;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* temporarily hardcode to use vbios pptable */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smu-&gt;smu_table.boot_values.pp_table_id =3D 0;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (amdgpu_smu_pptable_id &gt;=3D 0) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boot_values.pp_table_id =
=3D amdgpu_smu_pptable_id;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-- </p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
2.17.1</p>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB30225CBF9506F26EC94C89C0A2709MN2PR12MB3022namp_--

--===============0198648349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0198648349==--
