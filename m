Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1F4C05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 08:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4066510E082;
	Mon,  6 Feb 2023 08:08:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A65E10E082
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 08:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rr+HD5M4WblItjcuowN65qUs5QIJmnpHvx7P22Vv6r/HMPfAEIUGlC/ZySzk7sozvyviYh6mPUHFzGM+WT5e3r0LFZ0GarcKgXLqR2mRBDaWTBubqtm45P8Ws4vy2y6R5n60forgKdGWnzjoPWefMtTVb8ZMr3HXi6kIJYZaD+BWeqoKg6l4t4rlq/qRIliS6TK7Gn/e5QmuzTLAjd0eB0Wc54rQeCUUzeqCbXWQwT5RuLMTGC9sDrbkkRYjG0WL7cGiZ2b27sQmbCeo/DqfXme1wNc4SmQE3klN9lFp/zLpaumNPuJ3GQM4qJKqBImCVd0CGMCtyuvX3qZzcUgaBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrDAGVCOkPxkKRXtRwTjXlU6uTqYPCWjHDtqMrobu5s=;
 b=H/C7i/mOyMG9evyLFdcirzGjnj0s8nAPoRJ+GoSRsaPuJFnEk/BpE93KxwmVWK6ucV6G6mbwTwzFREp3zp9AMHvUzET4Ie9sSl6lIdzHCIuAPByASynkuaYF5iK68OHZy/c18pfsm8dpmTJsE9YneHWUGmI666ZYqmonblBumn4kQ35M/nZ3KRFBXgUsiPC+LovEWh+FW39v5XtFiTfguyld4ilfEw5z/2xSLaWWeSDpvUaPYdUtD1lwclOcjAzoTu17wd/bGmqc1G3FaQqvTpKGVEQ82Dtb1wJY5g3rZYtcOyobLbeoTdI4w1fAiCBJXHO5kH2lpJ4SN++htqo3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrDAGVCOkPxkKRXtRwTjXlU6uTqYPCWjHDtqMrobu5s=;
 b=0mzJP5ZxZNcDuM+BCrF/plqxvmq2blFrriarMZqw5BpaG2MnpaDh+k4t+gj3DU9zYmmkNA+S9tyeKQEwknQRo+rQMvvqYeLTP1It0nfYbpDx5QOSBxzJLZneCiYcE8MueHZB2as0h2SgV6u2PgdWx/A5MhdIH+mqX89ytfE73g8=
Received: from DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 08:08:18 +0000
Received: from DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::9f2c:ea32:ce3f:8e3f]) by DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::9f2c:ea32:ce3f:8e3f%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 08:08:18 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wang, Yu
 (Charlie)" <Yu.Wang4@amd.com>
Subject: RE: [PATCH] drm/amd/display: Disable migration to ensure consistency
 of per-CPU variable
Thread-Topic: [PATCH] drm/amd/display: Disable migration to ensure consistency
 of per-CPU variable
Thread-Index: AQHZOgDu0uzPCQDZ5USOt9/M+A9hnK7Bj99S
Date: Mon, 6 Feb 2023 08:08:17 +0000
Message-ID: <DM4PR12MB5294AF32E509B6B15F58D7D395DA9@DM4PR12MB5294.namprd12.prod.outlook.com>
References: <20230206075846.3841054-1-tianci.yin@amd.com>
In-Reply-To: <20230206075846.3841054-1-tianci.yin@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-06T08:06:39.2421487Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5294:EE_|PH0PR12MB8176:EE_
x-ms-office365-filtering-correlation-id: 2b313627-1bb5-4b41-e247-08db08194e0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NIPrz3piXTYeHQMMkGbHgE4kUxFSL7HJYXO7vgXuDJGe9/N5jHXKDxzKSI+gExFKUEVqZW4QdnYTzj2PyfeftC1j5ZL3b0rfJTq+ti2OqcVfp38xDVYz9GNH8D2i2KNCGruiW0MmfSjrXEvWaDXQkIpXCjvrXcnyiQdQSeN71nr8nR4wK//egXuekiUBqTFvacKkItBHTsN34W2mWpDCk7pfJcKK/JH3PCwzwXbdAgjceTUj7xEBHhe2iqmS/GsLoWMp2ZV7BsC5sAcl+yunbJ/m8IJh+NKPOweXnri+mQIISWNJDFvEnfYIzrc4RQu9RcIq7i8RkvkefIYzXTE934RNFmnXJ+CJn3e50FIMnKuJKrqb4Hdf3AKQtMvFOMuAjl1817IVBjSJ48vm5gSkC99t7pnFL9NTthKu3A0cMG/6sjPza6mIWcHDu17yPaR01BF+jMRtSBO1AhGtFqZVijiqgtR8oYIycGqbcamitNjZrF2m5lRdjZ7Mq71hVq1eLSNf5dCskm6SFnjdLDlVXuvNi7l33QKa9Rgdl+HbpMk0RjVKZG/WcVl3nLcFM0hyi/FFbgG9P7VEAOvrj6wZwFwpXhQhSWn94s7nS8MXK3xyxqjR3meAsXT0PzPETu2u16fEdE3xAK58sWn0qUcSHQcV04u2anGXs4uXu+0Gz7lqV8x6k8BaA6CqFMh3vS82lqQvkfdDGNlb9z+d5S/KojLdzY3HPsRAlC4OxP3POKU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5294.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199018)(6636002)(71200400001)(7696005)(478600001)(316002)(54906003)(110136005)(6506007)(53546011)(5660300002)(52536014)(9686003)(26005)(186003)(33656002)(86362001)(38100700002)(122000001)(55016003)(38070700005)(66946007)(76116006)(91956017)(4326008)(8676002)(2906002)(166002)(64756008)(8936002)(41300700001)(66556008)(66476007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nrll5Hddtmo4Kof4x/RdYbRiDumG+u3oSyFLckAcL6KnkLM1KJDL4hIg+I+5?=
 =?us-ascii?Q?d1nEcWxftWNSHLhOXaWZLEwNkQPQEJ+4xknFQx/koUskXmuDbwDCYxk4OFvN?=
 =?us-ascii?Q?3kvBWApzThzU0KQ6y5vCwPh4hUdxjnIUuYDzXc+nF/QgP3lpHKgE0GEuYec5?=
 =?us-ascii?Q?m7b2fvq3xOzSGfbkewYb1YBKL2OSWE5TJhI+OVXW6qVEft8EWXnv/uftzeiS?=
 =?us-ascii?Q?KtRviRffb+ywoj87bLgyCO4aVL4TUhwyr+hwXmCMbuqCvaUx5ZrG5sV1aSQE?=
 =?us-ascii?Q?CEfdweVF6Ohm8wt8tS78fwgEy34JAlLd9GkZzHBj3CGToyLcGQbxpGaOGpcc?=
 =?us-ascii?Q?9M2l/cpUtkN+4BRRDQG2mDCFn43/W+jzCriz//ZwIeu3C2/cWnEA5Jx0+5tr?=
 =?us-ascii?Q?5kv0szl4xp7sTm9JUO66NBucSjuEZOAY8kSYguN6w+ciqOuFO86cWlqSfD/O?=
 =?us-ascii?Q?OkEjvWvWWG/6njaZ61/USrEmA+mXtcIVmbVFdOe0x08y96Qup6vKfgne8UOs?=
 =?us-ascii?Q?GPG/xldMFHUitdobx84Yw0L8av3EPf/7sqCylPZmMVhZsxhovB8GcqlrvwZu?=
 =?us-ascii?Q?tFD2ZGtzHqO4Da43QZGPrSQhbhxgWGYZY2WXPsVgM39Pf1Lo4mUuH80dax4l?=
 =?us-ascii?Q?6Goky4uoCIumMDdwPKu6W8elsyoFXqf2ZhHmgZ4mPDU/5Eq6OkzmhIPbdEgZ?=
 =?us-ascii?Q?iaXM+s6atJm7OjgUtnAEAu1kYkMRJotlJZ/eIfiJS8M5Ds20kXlC1RVxJ3ee?=
 =?us-ascii?Q?upbq34be1iOiCxONo7hLq1yEPdBmgduOqQWu+KDm5XeR55vUaeh1n2Xj6rnj?=
 =?us-ascii?Q?2BcgptyZJYyEDWgejkK1P8eRVO9evpp7OYDXQcp/ga85HkMKjVO2mo7aVWW0?=
 =?us-ascii?Q?EeDICTZP37UAlVoK0tEqsZZJa2YrMlC1419y5WOnyThK+0phdbAh3DjVDy1N?=
 =?us-ascii?Q?hDrLDBOTN6AEBhlq6NV31peJvbrcjZyAw8xQd3XeQJswMO4wQ59uaB2sVcie?=
 =?us-ascii?Q?m/ahG4gEw1F+iKfEleWCaPhn6/XPULUaTnkkr5OxTGWu63v+jSBb+e+DskFx?=
 =?us-ascii?Q?pbqJlrPCLBP+DJO9GtZacx04Oe2lThUPPJjlG5ubyx54xAIXY7I2Uqx0Zbey?=
 =?us-ascii?Q?fQlyakXMTivyWllF8HH4TdAzZfdJriv5zZsfjxKbLP3URDM6Jb56eGfPkqDb?=
 =?us-ascii?Q?nG2hjPcHoDmLOt78QUI8KLHJUfwzN8J+QjIHoQ37yjNAAQ4ejY6iYIRaxKDb?=
 =?us-ascii?Q?PQTdp+Cim9edR3oUyTfH3nD10yd9hZoBd8FxCTJq0s4DARDxUTkRx7545aFl?=
 =?us-ascii?Q?kvidz7XZcZwCbpDRfpgnWmmOl8NbBQYF5hGR66hW4hUOXh2lW+p7wq5Emd7O?=
 =?us-ascii?Q?l4GSkrxkA2BUAmzIK/y1WvwcNPiz1DubkkrHbQLoEfv5mfQB6Xf6opxgeizq?=
 =?us-ascii?Q?mmtx2LX+W7ymce5zwgs1SVg3XYpgCV8BKGvmEVzNR1Z0bWJrplMco5ywBRuo?=
 =?us-ascii?Q?qTtF2d5XqwtOJAERKiUAWSeVwN5ANiMymFWptf5B9Ug+XHBpqXzdwIzKsv42?=
 =?us-ascii?Q?Ff782egDt6SOF/rPKXllBlQcWiVUCSqtfOs2FSrhKfjQVBUdXj4CqTiBwF8m?=
 =?us-ascii?Q?PQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5294AF32E509B6B15F58D7D395DA9DM4PR12MB5294namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b313627-1bb5-4b41-e247-08db08194e0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 08:08:17.9350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3OfEW2IIc5uOb6ET/XYzca8b+UTouPaZz0a7U0g/xBEErAVrihnVTsicS7ggBA4MA4toyzeJBZfwVsaf35Osg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5294AF32E509B6B15F58D7D395DA9DM4PR12MB5294namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Loop  Charlie.

Thanks,
Rico

Sent from Mail<https://go.microsoft.com/fwlink/?LinkId=3D550986> for Window=
s

From: Tianci Yin<mailto:tianci.yin@amd.com>
Sent: Monday, February 6, 2023 3:59 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry<mailto:Harry.Wentland@amd.com>; Siqueira, Rodrigo<mailt=
o:Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo<mailto:Aurabindo.Pillai@amd.=
com>; Yin, Tianci (Rico)<mailto:Tianci.Yin@amd.com>
Subject: [PATCH] drm/amd/display: Disable migration to ensure consistency o=
f per-CPU variable

From: tiancyin <tianci.yin@amd.com>

[why]
Since the variable fpu_recursion_depth is per-CPU type, it has one copy
on each CPU, thread migration causes data consistency issue, then the
call trace shows up. And preemption disabling can't prevent migration.

[how]
Disable migration to ensure consistency of fpu_recursion_depth.

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 amdgpu_dm/dc_fpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/amdgpu_dm/dc_fpu.c b/amdgpu_dm/dc_fpu.c
index 1743ca0a36..c42aa947c9 100644
--- a/amdgpu_dm/dc_fpu.c
+++ b/amdgpu_dm/dc_fpu.c
@@ -89,6 +89,7 @@ void dc_fpu_begin(const char *function_name, const int li=
ne)

         if (*pcpu =3D=3D 1) {
 #if defined(CONFIG_X86)
+               migrate_disable();
                 kernel_fpu_begin();
 #elif defined(CONFIG_PPC64)
                 if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
@@ -129,6 +130,7 @@ void dc_fpu_end(const char *function_name, const int li=
ne)
         if (*pcpu <=3D 0) {
 #if defined(CONFIG_X86)
                 kernel_fpu_end();
+               migrate_enable();
 #elif defined(CONFIG_PPC64)
                 if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
                         disable_kernel_vsx();
--
2.34.1


--_000_DM4PR12MB5294AF32E509B6B15F58D7D395DA9DM4PR12MB5294namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:ZH-CN">Loop &nbs=
p;Charlie.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:ZH-CN"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:ZH-CN">Thanks,<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:ZH-CN">Rico</spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sent from <a href=3D"https://go.microsoft.com/fwlink=
/?LinkId=3D550986">
Mail</a> for Windows</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"mso-element:para-border-div;border:none;border-top:solid #E1E=
1E1 1.0pt;padding:3.0pt 0in 0in 0in">
<p class=3D"MsoNormal" style=3D"border:none;padding:0in"><b>From: </b><a hr=
ef=3D"mailto:tianci.yin@amd.com">Tianci Yin</a><br>
<b>Sent: </b>Monday, February 6, 2023 3:59 PM<br>
<b>To: </b><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc: </b><a href=3D"mailto:Harry.Wentland@amd.com">Wentland, Harry</a>; <=
a href=3D"mailto:Rodrigo.Siqueira@amd.com">
Siqueira, Rodrigo</a>; <a href=3D"mailto:Aurabindo.Pillai@amd.com">Pillai, =
Aurabindo</a>;
<a href=3D"mailto:Tianci.Yin@amd.com">Yin, Tianci (Rico)</a><br>
<b>Subject: </b>[PATCH] drm/amd/display: Disable migration to ensure consis=
tency of per-CPU variable</p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">From: tiancyin &lt;ti=
anci.yin@amd.com&gt;<br>
<br>
[why]<br>
Since the variable fpu_recursion_depth is per-CPU type, it has one copy<br>
on each CPU, thread migration causes data consistency issue, then the<br>
call trace shows up. And preemption disabling can't prevent migration.<br>
<br>
[how]<br>
Disable migration to ensure consistency of fpu_recursion_depth.<br>
<br>
Signed-off-by: tiancyin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;amdgpu_dm/dc_fpu.c | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/amdgpu_dm/dc_fpu.c b/amdgpu_dm/dc_fpu.c<br>
index 1743ca0a36..c42aa947c9 100644<br>
--- a/amdgpu_dm/dc_fpu.c<br>
+++ b/amdgpu_dm/dc_fpu.c<br>
@@ -89,6 +89,7 @@ void dc_fpu_begin(const char *function_name, const int li=
ne)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*pcpu =3D=3D 1) {<br>
&nbsp;#if defined(CONFIG_X86)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; migrate_disable();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kernel_fpu_begin();<br>
&nbsp;#elif defined(CONFIG_PPC64)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (cpu_has_feature(CPU_FTR_VSX_COMP)) {<br>
@@ -129,6 +130,7 @@ void dc_fpu_end(const char *function_name, const int li=
ne)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*pcpu &lt;=3D 0) {<br>
&nbsp;#if defined(CONFIG_X86)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kernel_fpu_end();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; migrate_enable();<br>
&nbsp;#elif defined(CONFIG_PPC64)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (cpu_has_feature(CPU_FTR_VSX_COMP)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disab=
le_kernel_vsx();<br>
-- <br>
2.34.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5294AF32E509B6B15F58D7D395DA9DM4PR12MB5294namp_--
