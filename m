Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FEEC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 20:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4005710E263;
	Mon, 10 Jan 2022 20:49:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6D910E4A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 20:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt+Hx7ty0UEaQ2ShyBl6PvtBUs5s2GPzXJEHuvJwVGFlLFiiqI2tzmOTKRpctUs77ASuzPPdbdEfsuRkb3EHA5pkkoeT/y3WT6vkNMKlpo9fh/V39Rhk2SV5jIdY/SaLtDZDcQNeFBUnJENQnZ8rPkp1rIWUoYQh6PNVggH2MlwXnmv236uNgcraUq+vmmTLugfjtrTZanrKSFAejZ3vp5HhCqDJGnw+/ugBIgEkLi8s95N8CqjSILy0BSzdzioT5xZVydvkLU1EMG4Bg2krM6b/RW9iEDnlKgTU88b6c6uXXS1FZhVufeNrQd0UU0u03NFsfA0RemYXGemYQ1HT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=To9S81ys+BY2cHKSPoUkWpeuExS9I76lNqEmfrmmZ64=;
 b=UGmhCZZ0IvXk0yFc4RTukN3AWokR0yixrI5wbDls2xPTAlgdKkn/Qrd9soY8ixbDIrM3eHYdj8kv5yeHtU83SXsIKdp/cv737xks3b68u80id2FA37VfAZD5Xr5/BMTzSZwnLPgSDYGaW0XL99DvDs1T4RBRtbF95abiZljO5m0iOyQgOCtUiVGkOahNHN0hjNbbOk24PNZ5Wp6oyR+DQsnWBiFyDLDriah5q3vzvZd9ODaNqa4z3aTF0SIGt7nAJChZKnMBpcui2ECckWm6151KVxttxdMdFsC5WkgTsHh6D9ctwAspoupnsnWIFDaGrzwY1DTiO3JpXnoy/L3r+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To9S81ys+BY2cHKSPoUkWpeuExS9I76lNqEmfrmmZ64=;
 b=29qMO0NE9lUmnHD8az8QAEunWOgQBGPmig+QDRv/1M8m5LDjJjOlckx1On6IDrlIIJPyewJD3UDESW9gZFPV+7SPZ636t2RpazCeW2PtfsakenYVlwr+Sqn5CeWilUZ2lUumfH77X2DdblnIdgaj3aysHkMcK/AUHGGSRGiDvCM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 20:49:18 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 20:49:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix unused variable warning
Thread-Topic: [PATCH] drm/amdgpu: Fix unused variable warning
Thread-Index: AQHYBmFQm0qShBbXiEenbc+BeS9xDqxcuiVh
Date: Mon, 10 Jan 2022 20:49:18 +0000
Message-ID: <BL1PR12MB5144285CC0A72A1FED2B3936F7509@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220110203255.95468-1-luben.tuikov@amd.com>
In-Reply-To: <20220110203255.95468-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-10T20:49:17.446Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: d8ba27c1-578b-d5fb-8ff3-60e4d6543797
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0e64570-8842-4450-9bb9-08d9d47aabde
x-ms-traffictypediagnostic: BL1PR12MB5237:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5237CA169FC1EBEB0C19CC5DF7509@BL1PR12MB5237.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:178;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: COWbKzCsvGVheU8v84QTbpRf77Nfrki14LveEPgY9SSG5ghmD3p2/UL6XjvyqzFarRQ8FCresg15HUOXaqmfrm91fuot+7UuACjEpaeUEuxjnZQb2yCz6952hEeM8pm55M+nJ/nPz2RrJce/NcqByuMwKiZX2YM9XbaZqbIbF9g1cDRFOVV9kfZPrqK00rCFj1IpeKkv3jpkiRemc5bDl0jrr8PfTWNHNlkZ8IOgXyfQ+gQh4RBYhLM4xgSwI/C6d0/xVV1wd+9Mtk2zh5tydztKrOEuwSQwTxZC32uVL61f7NBm76QtBOhfFrvQ/2tcfuDwhoizJVJo63cCA5cgWoBklPblCcJ4jMLLjSiceQaFBsAzSS0DwrkY2dxtpZ1BlXBBSLH4bErY5pbwk7lnT4sSRggoOGxp+DNQfVooU9kgSPf7BhPV2sEzAQpis/4aM/6u13hWyaI+gqEB6GDKFVQdCm973qiRFuzys5jecjlFN0tMKcWSBYTJUj4HiC/0pheA2JhBC5VxkmXn7r3TZJ6nUfIFLdajNSYmbG34fEdsKCvbOGyKxel0APYkOLiZ36tcNTHKXgViPf41Xi3YCyg1Yqhw5+kyUU6ZMf1EKa6DkMiX+X9Q3ks8SJvBaaqYnfWE7yNONd469hEluzFRdNuQy/AuVNbPRoQRwnKSX0gkg163aQbRwsjdAqcDo29BSWgE17SYK7/QGvwhE8d3Gg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(86362001)(26005)(6506007)(508600001)(55016003)(110136005)(7696005)(83380400001)(8676002)(19627405001)(316002)(53546011)(9686003)(38070700005)(38100700002)(66476007)(64756008)(71200400001)(66446008)(186003)(5660300002)(33656002)(66556008)(76116006)(122000001)(66946007)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?glVS23SYRtvC7iXBtKBUl3RjNPTUxrdrbo7rl9mVB0LAviMU96Mmc/pm?=
 =?Windows-1252?Q?lK42Hh+1Wg6ke4Yle0CQL/F2NKv1St4yOjlX7bNfsQzuY/Y9ZSNcFJS+?=
 =?Windows-1252?Q?h0XEwcXSMLGuHr5/0YGNF6kSEbrbcmCPNjbY1giVigiG2I6uhF+gY7i7?=
 =?Windows-1252?Q?ERrvbuJ98OA7q8jGkCxZShTf1IeD0VxyR4osyW5Rf4Gks5aKd8+hsaf3?=
 =?Windows-1252?Q?EClvWcAA7EURZTMezNA9vH2M37+sqn4cnTycOV1uYYtaBWpbd0qMgp1u?=
 =?Windows-1252?Q?JSxH5eavcjuMAf4GOKDfGPnHsi0qcd6+PV8brWDQc0ryO7Djni4oa/Sp?=
 =?Windows-1252?Q?ICX2+gIfE0llF8d9dCVWTaIAx+X9lhiceSaa5YTlUyctuf2/R875wYEK?=
 =?Windows-1252?Q?9KFOg6nYbuAExMCmevZf5bMGz5S1s0icJkjHK9F/rO2aiR1+uS+agybb?=
 =?Windows-1252?Q?MHLFs2UAkMGf553ctRcxRf7KLVI/umbD6joqXtZ4/khOFsXEjigQHWPC?=
 =?Windows-1252?Q?2UIcK5aMxG/N1Xy9ZRrxU4MfXZP3gMK7sSuarUpiqUga9yDyUqNL58q+?=
 =?Windows-1252?Q?ui6/uEUrMFM8cTTMKfpuN2TINfK00Q5DsEBAv2Zmy7rtA+rFzeWQm3nQ?=
 =?Windows-1252?Q?onhqWyKk5Bmi2TwkvbVOWG1f/cKo8lSxPFWsuMlMqzOnJajFxEXXDvJ1?=
 =?Windows-1252?Q?ciLYae2gQNIlu6v86n+fxk6QtT6Qb/XW58z1JiPvwuv1SkPQTpKkGZgA?=
 =?Windows-1252?Q?DW6oo3nt6JIVbdjD6oXwcuKk7Q4k/HOD/ECYTtFApBCSTa4P3CPru8Ku?=
 =?Windows-1252?Q?vx6FE9kwmugwUK0NVopdgfEUaRFzSyQc8H27pqmYJ/HBeV+2kI4d7Gn0?=
 =?Windows-1252?Q?Mu9oZJwQWmcQECHAXdne+gDs8hiH35yym82Zg2URpbjporEzVG8xwDIY?=
 =?Windows-1252?Q?g58pagMYxOo6PaOnGph7DfHYL2BUc/wgqQOldIjQJcX8HiMAP+A2I4KB?=
 =?Windows-1252?Q?yMVoNOjb6CXCgklc3vvoDo8m/bl81r3F+Z4G3NRrMwkl24UE3ERSz/38?=
 =?Windows-1252?Q?N8Ogtz4QCUFp3bCppQQt5deNYFRJihpwdFhiV2E3ZU7cpOycd+FDgklC?=
 =?Windows-1252?Q?zx83O3DKvZKiNUH5EbYyfqnxKrM+7s19+sMAdYs4AkVPxxjVhst+fwFX?=
 =?Windows-1252?Q?W+oepNnKiHsGN7l9qLEb9YtfA5Jpzb4Q/vlkES6wXDM2TjzBI95+JpJC?=
 =?Windows-1252?Q?9ZrB7LK2cV7HHzqyYJVofnQKDPW0lPptBaF9yB3buuMlvhbOpJ9FiEj/?=
 =?Windows-1252?Q?ryvrvyVO6kDHTRQlemVoUSRcm/YcWhEfWJ/DXFzr4is4ZI5gkGceqVWk?=
 =?Windows-1252?Q?OwjUdNlq4ZTyI9eU5C8JkxDwZuQ7CzeHksKZIarPRjt01BYf4dF0zv/g?=
 =?Windows-1252?Q?gYlFa6SwLJ7BnXAA9Da2ceonFKFB4QrCX043tSZbDBvj/z0mFzLRhFy2?=
 =?Windows-1252?Q?JaGV34UDtjezK4gU38JkLc3rGx+B5xW9BJj1U9XdvCxSy+Py5z+VSPga?=
 =?Windows-1252?Q?bi47CAAmXyRISKjAlK1gUNE/g5YIgSWp47mxBLw7LeGao5R7s71V6ASh?=
 =?Windows-1252?Q?YotizDfB0H/lFfbqQmL6jIwwgwHQdd/W6+DD6LEwH7bDqYVq9prEh3ws?=
 =?Windows-1252?Q?UnTKszGQK/kNGkIMVSDJPLMcxeSmx+DnY9Q/gWLi2fYBAQSNgv7WCm+e?=
 =?Windows-1252?Q?k8mldIOpwVYyAiwsyz0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144285CC0A72A1FED2B3936F7509BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e64570-8842-4450-9bb9-08d9d47aabde
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 20:49:18.3277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiM4P4+jmbgz0AqvEdLtYcvSMtBxjBc5OtBkrB4rzV1crUrhK7tmg4e4l9+uxd7lG+TifBoaIFEggrfBc2arbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5237
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

--_000_BL1PR12MB5144285CC0A72A1FED2B3936F7509BL1PR12MB5144namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[Public]

Please add:
Fixes: 36324c09d848 ("drm/amdgpu: Modify sdma block to fit for the unified =
ras block data and ops")

With that,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Monday, January 10, 2022 3:32 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix unused variable warning

Fix this:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: In function =91amdgpu_ras_query_er=
ror_status=92:
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:945:6: warning: unused variable =91=
i=92 [-Wunused-variable]
  945 |  int i;

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b1bedfd4febc4b..517650d286a722 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -942,7 +942,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device =
*adev,
         struct amdgpu_ras_block_object* block_obj =3D NULL;
         struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head)=
;
         struct ras_err_data err_data =3D {0, 0, 0, NULL};
-       int i;

         if (!obj)
                 return -EINVAL;

base-commit: 9b7d59707fe1ff51cdfa0a048629446ff3945bfd
--
2.34.0


--_000_BL1PR12MB5144285CC0A72A1FED2B3936F7509BL1PR12MB5144namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please add:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">Fixes: 36324c09d848 (&quot;=
drm/amdgpu: Modify sdma block to fit for the unified ras block data and ops=
&quot;)</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
With that,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Monday, January 10, 2022 3:32 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix unused variable warning</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix this:<br>
<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: In function =91amdgpu_ras_query_er=
ror_status=92:<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:945:6: warning: unused variable =91=
i=92 [-Wunused-variable]<br>
&nbsp; 945 |&nbsp; int i;<br>
<br>
Cc: Alex Deucher &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: amd-gfx@lists.freedesktop.org<br>
Signed-off-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index b1bedfd4febc4b..517650d286a722 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -942,7 +942,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras_block_ob=
ject* block_obj =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_manager *obj =
=3D amdgpu_ras_find_obj(adev, &amp;info-&gt;head);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data err_da=
ta =3D {0, 0, 0, NULL};<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!obj)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
<br>
base-commit: 9b7d59707fe1ff51cdfa0a048629446ff3945bfd<br>
-- <br>
2.34.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144285CC0A72A1FED2B3936F7509BL1PR12MB5144namp_--
