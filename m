Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E21DCDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 11:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5ADD10E639;
	Mon, 22 Jun 2026 11:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NHl0QnNE";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E786810E639
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 11:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGpFUVFJHslOnc5M+AkgUZcMH1PzdB2LR/P6Ngl80UtvsDDQnyKks/xuWw/fFU/YisWHY2NLjvhlZr0PcHfsTJohKJM570tJNfbcBL6JkWKDEc1AO7DBGuzobD077rSDURKsW9FQ4/XeA79iMwf6pbhWUqdiKz+i3U8xuGIj4EdEoC8mNY4n/6Kv7oy7LCqdKRba0MtY5slSSZJUQbRTyHC70VesZkJgP5CPo3fH66IAWiqSuM/ZjUeO2aw4J5gEaq6Md0ikTQ5qdQoh6HS40RFfsEF83Ies4Dg2OniKBorMIse8zswiotfnKaeCNRL9FKKowThMCeU/U/DP9cp9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSPILv/Vp5OiDKGeMury6lZgXp6sTIEE4Wb2kj8qhAQ=;
 b=DGqQq4p0ANzNl1uyh8mO1Xq5vID5aEDHSFtpzdOntDjQbqWyQ7qBNDweRcrJRIIpVaC58FgSLGzD7A64sBJvLDFa2mU+dGSC26SWquZAG0DtHjhkKW3x1mg1GsTiUb/QiT5GhqYKckWFUvklIzOuWR6CrfEC5SivSyReI+MlX40IxXoaCEZ1hpZSdBXqhFdRQKoho/FJxJaoJJg4dlAxEkyipq6gUNl7q3XajA5yKjlP2kwrohglJH9fVamogRuln8Y1vd12ZV6UDRGFBlTg47pNFL+9zp0i6Q6B6vjKhKMAkGYT3e3DFPzQSPyu9ff8juXbHPnDmDmiahFHrST8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSPILv/Vp5OiDKGeMury6lZgXp6sTIEE4Wb2kj8qhAQ=;
 b=NHl0QnNEr7DGZQQdqRsKnbAg978HAutqgjIxQba3TcH12hFq6L0KGEjNVkS3CItkWX0rbunzGr/0hftw8uNZjuPdHe77uBijcvZ2E5+UjGHZwh4q/dvhXkyFpe6qz+i01T73aoQqzxY5xyTpuZ7cRm/GEc6HK41uMp6tIsfXqKk=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 11:18:56 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 11:18:55 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: =?iso-8859-2?Q?Timur_Krist=F3f?= <timur.kristof@gmail.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Reduce stack usage in IP block soft reset
Thread-Topic: [PATCH] drm/amdgpu: Reduce stack usage in IP block soft reset
Thread-Index: AQHdAA+QIv+XVhj5VEWKsTwNX70BhrZKPm0AgAAMQFCAAAK4MIAAIT8AgAACvgY=
Date: Mon, 22 Jun 2026 11:18:55 +0000
Message-ID: <IA0PR12MB82084FFD926ED6F878B843AD90EF2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260619171733.2976352-1-srinivasan.shanmugam@amd.com>
 <IA0PR12MB82087A22BE651E5AE05C3B6390EF2@IA0PR12MB8208.namprd12.prod.outlook.com>
 <IA0PR12MB8208536DAC79A742DB687A7B90EF2@IA0PR12MB8208.namprd12.prod.outlook.com>
 <27422769.1r3eYUQgxm@timur-max>
In-Reply-To: <27422769.1r3eYUQgxm@timur-max>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-22T11:17:46.4361933Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|DM4PR12MB6445:EE_
x-ms-office365-filtering-correlation-id: c42d16ac-3ef1-40e5-a2e9-08ded0500c6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|4143699003|8096899003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: O0gAiYe1lRirIPcqsOgT7d+mzs4GkBEd4puq7g61ffoB8clCtEQ+JHPKHBmROI93YnPQZmo9NuHhuFrB3B+YrrJnhoUfIwYBseMe8GYa1SIm0qr2Z2G4wP7bmKuY9JBW0HefcFuhOD6EX0WCyBqPLO/PU18SGMSwFPFFYVQ4wWb0PXcNnFd3h4RiG3ANnII1yjzag24zL8HqUnCV5ycTYNvi1RMyrcb3MnkQJgLx4nmT+erpC4u9h1zlFazw+U35tzS3pI/byrUREzeSKQejvuJ7QPC2yeiPeaeZxifiBfqWpyf/4VSVLfCTmOw47i/HlVq5kaXghNTco+Z5tZlVovS6PPnk31j2lD1iI72lYHGNF1gbtHNhuCJ678eLvhYveGyftpy4uOP1iI7UqQEFBdRFmapviP8Mg7NW9Fou4URTtmatQSGLsnP6h8vorvOg0STIYl86OlDaRthFClxcjEb5s5EwYRDJGGxFKTon6Fg9qFeniqpgrIfMRJxyqz1u2j7RL1VVM+8t/QxUTIqGQlgLcsZY/J03A4NPKlOJwYM1XbXcWuBZFFDOJQn5l9Myce5DX7cdc7bv8njf6g52kxxGI+CVm97Q/zuNfxfhh7zT4Nh4miDJUqqyuFykHOwunUVSD9k7dF4hU/hvcx/eRqXyBBhKqIRUBAbi6/Eo71A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(8096899003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Emhg9+AjN5FIsgjXoNaWD+sZvJj1psfEvw/av0mCG3L9AiIA1wsFPI8l61?=
 =?iso-8859-2?Q?huZQswJGb8EmWxHH8ra2ZoSTiCSztrTK3L3P9DFAcxSLjPTFPEWUpgULdI?=
 =?iso-8859-2?Q?vCjQyzg+Bmz08cw3h7nW3tgZny+UvTW5FNSoCF5TmKGJukb6wMt8mj2gSL?=
 =?iso-8859-2?Q?gEsUCm6hp6oV5caY1FkTllcuMQ7TmwhKzWC7cjPgrmQVJmSIvkPuP8f+87?=
 =?iso-8859-2?Q?iAQ3X0MkDTc5Dx+EY9zuKp4pBOBDRi/5npM/1/iVVPt+uryfp5SrEtbK/L?=
 =?iso-8859-2?Q?n6lCoAdO4vEOLrdpDaGoe9wP2R9bhlyKoRt9UDmeqP1kN0oyKsov/T03Yf?=
 =?iso-8859-2?Q?073wyGK6mSs1CwQ3bvSYhIPSNugc2BsMqgDEH1DC205ylvUCTD1UcHC1vg?=
 =?iso-8859-2?Q?bBqKd5lXshpxZj73xC+B/HZ/4zLG/47hGA3up/d3RHoYQ9ob//hOHW40NJ?=
 =?iso-8859-2?Q?lpwZ2UWwRc1jEdDBGQWB3zWUs5qwDDn04k6V/cki4y8GRSfUdrh9eg7uJD?=
 =?iso-8859-2?Q?x8nabxuF3sNQah+l8IsMTYuTgZGfWyO4sFjFtLoM5JS9r2Nsm7IZAlQUnA?=
 =?iso-8859-2?Q?zY8ZM7NEhTJdn+w3UPevt5jPwXY1ty5e9pXV8Dfu8lADeMzghS2WESCpOx?=
 =?iso-8859-2?Q?v3PaRsJLn0JmKRr8t4GchmTc60o4nzMQLNV5RpxH+uTC/U5ufKR2wm5F2n?=
 =?iso-8859-2?Q?p6eXTWbY9UKW0OSqS1YQh1HBWPODqxs31i8E/nZJx5Zjyh3SioBix2rbKw?=
 =?iso-8859-2?Q?fYAyiSPNjTtwdOzwEsthZv7Kvt3zOx0VncOCMGqI2UX7iRsoVo1qI/Vnd3?=
 =?iso-8859-2?Q?Wc8WUHzGndANd1DGvtLhvNtWOXgWJ2SN3PW54+sVkNNj6Q51sBU92XZktx?=
 =?iso-8859-2?Q?ZLN+uKYNKnw0tzqlCc+20Hqim9LUZfVoX+w+l/5hff+K6YDSppboR1+9a/?=
 =?iso-8859-2?Q?6DJ8lpDT5x2NSAwAyWAiCGNs13MdO/sWUh2lKTW3Db4Tc+eya2rBhRcsvZ?=
 =?iso-8859-2?Q?UIqYBQRILFtOSuoN77F9brofBVYUTz4QDSFHac8Kp1guYKFJVHqCUrw6/w?=
 =?iso-8859-2?Q?uVSdU1XQHE/TgxBzVPXiww53GS+nY/mOflGpPGobdHwuDRjS39CkW3eeR9?=
 =?iso-8859-2?Q?nABJ9xgR3pBrMG2Y+kQyVJqELmee7zK5WnUOItthAJyWnusre1/OqexWel?=
 =?iso-8859-2?Q?M2TzB4bgwJBxHJa8cqQe4T2yGzCnLhhJk2rmOaP5yIp073ORxdhuTfS2pQ?=
 =?iso-8859-2?Q?E5PcW5Kqarq4KgDedoLR6uY+ws0ZL439ntRT4OgJXG6OjFaQ8JnucCzRAd?=
 =?iso-8859-2?Q?LgIdSiLVxl1+EaitO/gVruxkav9bOqekaOxEqZygnal3YDQ+rfp899J3Ak?=
 =?iso-8859-2?Q?lQVJsYX9gjcXjqoL9YbExHaPzoqRDYGztyjGPRUZkxhyLVIPglyOrO+kZm?=
 =?iso-8859-2?Q?DluhmosI27lO0uTKHX1dP8mxI7Xapt7zUM8pD0K38V9rnlk6koxcdJw4Ug?=
 =?iso-8859-2?Q?mOgXE7NJihf7mvH+RcQFJy68J2iyRKBfh5cQXp6G69WUZUigYKAepQmuJ4?=
 =?iso-8859-2?Q?VzTv489KGC80wQsbyUjs36EQWfD5/aRJ8gSPNxLJ/AFprd5T/aAUpf8yFz?=
 =?iso-8859-2?Q?tWknVXxCguO5VfHE7C41mznelziAuqMW9aIZwx8toM9en+aQ4t2MZ6jjWo?=
 =?iso-8859-2?Q?n/Sh9KsSPOVwp1lGQBrq8YU5akYd6IzysYNKsDXupgw/C66nEKLaC5p4fc?=
 =?iso-8859-2?Q?biG3lhUW7GLZpndurt+jSrD/FlsS6XdM6OgrihiWau0Sc7uGtXzUU4uSVQ?=
 =?iso-8859-2?Q?bf9LWjuR8g=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA0PR12MB82084FFD926ED6F878B843AD90EF2IA0PR12MB8208namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42d16ac-3ef1-40e5-a2e9-08ded0500c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 11:18:55.6783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULROv3WhSEiX9UseHmPAQr66Mwzcj3uETm+30hDcM2vYquSQYW0eSfbIIYTRNsjCuKbPz3C1oseseuVrONWAfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6445
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

--_000_IA0PR12MB82084FFD926ED6F878B843AD90EF2IA0PR12MB8208namp_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

AMD General



Get Outlook for Android<https://aka.ms/AAb9ysg>

________________________________
From: Timur Krist=F3f <timur.kristof@gmail.com>
Sent: Monday, June 22, 2026 4:39:29 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Reduce stack usage in IP block soft reset

On 2026. j=FAnius 22., h=E9tf=F5 11:10:40 k=F6z=E9p-eur=F3pai ny=E1ri id=F5=
 SHANMUGAM,
SRINIVASAN wrote:
>
> I took another look at the implementation. The temporary array is
> currently only used to collect the subset of affected rings and pass
> them to the multi-ring reset helpers.
>
> amdgpu_filter_rings() simply copies matching entries from
> adev->rings[] into a temporary array, and the helpers only iterate
> over that array.
>
> From what I can see, adev->rings[] appears to be a stable device ring
> list, so it seems possible to eliminate the intermediate array
> entirely and have the helpers iterate directly over adev->rings[]
> while applying the same ring_type_mask filter.
>
> Hi Timur, was the temporary array intended to provide snapshot semantics
> for the affected rings, or was it mainly introduced for convenience?
>
> If there is no snapshot requirement, I'll respin the patch by removing
> the temporary array altogether.
>
> Regards,
> Srini

Hi Srini,

I'm sorry for the trouble, I haven't seen this warning.
Please give me a moment, I can send a fix later today.

Thanks & best regards,



Thanks Timur.
Sounds good.
While looking into the issue, I noticed that the temporary array is only us=
ed to collect the affected rings before passing them to the multi-ring rese=
t helpers. It looks like the intermediate array may be avoidable by having =
the helpers iterate directly over adev->rings[] while applying the same rin=
g_type_mask filter.

Thanks, Srini



--_000_IA0PR12MB82084FFD926ED6F878B843AD90EF2IA0PR12MB8208namp_
Content-Type: text/html; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
2">
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(33, 33, 33);" =
id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<span style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robo=
to, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(33, 33, 33);"=
>Get
</span><span style=3D"font-family: Aptos, Aptos_MSFontService, -apple-syste=
m, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;"><a href=3D"https=
://aka.ms/AAb9ysg">Outlook for Android</a></span></div>
<div dir=3D"auto" id=3D"mail-editor-reference-message-container"><br>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" style=3D"font-size: 11pt;" dir=3D"auto"><b>From:<=
/b>&nbsp;Timur Krist=F3f &lt;timur.kristof@gmail.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, June 22, 2026 4:39:29 PM<br>
<b>To:</b>&nbsp;Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher=
, Alexander &lt;Alexander.Deucher@amd.com&gt;; SHANMUGAM, SRINIVASAN &lt;SR=
INIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Cc:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] drm/amdgpu: Reduce stack usage in IP block=
 soft reset<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<div dir=3D"auto" class=3D"PlainText" style=3D"font-size: 11pt;">On 2026. j=
=FAnius 22., h=E9tf=F5 11:10:40 k=F6z=E9p-eur=F3pai ny=E1ri id=F5 SHANMUGAM=
,<br>
SRINIVASAN wrote:<br>
&gt;<br>
&gt; I took another look at the implementation. The temporary array is<br>
&gt; currently only used to collect the subset of affected rings and pass<b=
r>
&gt; them to the multi-ring reset helpers.<br>
&gt;<br>
&gt; amdgpu_filter_rings() simply copies matching entries from<br>
&gt; adev-&gt;rings[] into a temporary array, and the helpers only iterate<=
br>
&gt; over that array.<br>
&gt;<br>
&gt; From what I can see, adev-&gt;rings[] appears to be a stable device ri=
ng<br>
&gt; list, so it seems possible to eliminate the intermediate array<br>
&gt; entirely and have the helpers iterate directly over adev-&gt;rings[]<b=
r>
&gt; while applying the same ring_type_mask filter.<br>
&gt;<br>
&gt; Hi Timur, was the temporary array intended to provide snapshot semanti=
cs<br>
&gt; for the affected rings, or was it mainly introduced for convenience?<b=
r>
&gt;<br>
&gt; If there is no snapshot requirement, I'll respin the patch by removing=
<br>
&gt; the temporary array altogether.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Srini<br>
<br>
Hi Srini,<br>
<br>
I'm sorry for the trouble, I haven't seen this warning.<br>
Please give me a moment, I can send a fix later today.<br>
<br>
Thanks &amp; best regards,<br>
<br>
<br>
<br>
<span style=3D"color: rgb(0, 0, 0);">Thanks Timur.</span></div>
<div dir=3D"auto" style=3D"font-size: 11pt; color: rgb(0, 0, 0);">Sounds go=
od.</div>
<div dir=3D"auto" style=3D"font-size: 11pt; color: rgb(0, 0, 0);">While loo=
king into the issue, I noticed that the temporary array is only used to col=
lect the affected rings before passing them to the multi-ring reset helpers=
. It looks like the intermediate array
 may be avoidable by having the helpers iterate directly over adev-&gt;ring=
s[] while applying the same ring_type_mask filter.</div>
<div dir=3D"auto" style=3D"font-size: 11pt; color: rgb(0, 0, 0);"><br>
</div>
<div dir=3D"auto" style=3D"font-size: 11pt;"><span style=3D"color: rgb(0, 0=
, 0);">Thanks, Srini</span><br>
<br>
</div>
<br>
</div>
</div>
</body>
</html>

--_000_IA0PR12MB82084FFD926ED6F878B843AD90EF2IA0PR12MB8208namp_--
