Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79192EA3C59
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 13:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099CD10E3FD;
	Thu,  9 Apr 2026 13:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PN83va5w";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C13110E3FD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 13:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZcGQjp0jJKaNL34sPGHH7fyl0E2jzNKoX599kFWHKrDlBZee5lemri8wc9QREFtRO6BCsySeIVt2AIEByCNEKVfVEhmK4HM+hhQpBGvo7XC/QeRW5yk60jmsn1hFXkux9YBz1MB4NjU0aI4pPrOlJLxkht5EjeMIEm1h2LIdKDzWIfSdXpNCP3I+utjsmBYGxBIfosOeco3jxWj+fC8clIQ70fTTpRJAI8N/lXVsf81vx0ev8ms095buLBD0gZexCjA0m+70gZV1BF6aNnG3aG1EbW9JN1DkqbfCcKjtJRx+DtcmR+nWCci443HrMacJm5WKpoSonIeJaQF3Yx1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ripInukQdSIi8M9kyoH8yRLK+9+Uy0Wd/CDhc3+EQWo=;
 b=q9h+T993VNt52o7/j2/4+YkniEMP3fl+V3GF2pQfOP7Of1XyvIZC7cYOq9DfGjon1cYFq5j7EOJPXB3cyuhJKYkDSMeFDtQl6VGMQsu6/Iz6RxY5r5sdEcoexXEBLywTI56If1wnaZz1xXCR222kmv9yfimM9VvDmYo32nw1Q6/cpjJ77wH1zjbbf8/HwoFiFIduxxzJquBJyhSLN3jsAvmH2YJCE2ddvBnhvZl1xxXbQ6nSKVfJw8ief9mutYvsn9IJwnhCPyZhup3lQILOf5E1FupP3bQR43Hy/2TBm7iGKuJU2b/Hrr2N7njVi+gvjRePuYAoqYvksCgacs9ciQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ripInukQdSIi8M9kyoH8yRLK+9+Uy0Wd/CDhc3+EQWo=;
 b=PN83va5wYE8lvRqEEBcEo6R8jdVYXtJQjn7O7gzLrvoZ9mqBLnDtbE7pZQOgPfsL+5QGmEu7vISysgbFBBubGfWhG2KeiscB6czaRQL0iudIc6j17O63F+PY5o+P6Li26g1z5iW8G19L/zN7NaXyrxFPb1jZhxg2i0+Oi51DwMo=
Received: from IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 13:57:42 +0000
Received: from IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2]) by IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2%3]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 13:57:42 +0000
From: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
To: Bert Karwatzki <spasswolf@web.de>
CC: "Varone, Dillon" <Dillon.Varone@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-next@vger.kernel.org"
 <linux-next@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
 <linux-rt-devel@lists.linux.dev>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
Thread-Topic: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
Thread-Index: AQHcyCLT+fim4XOC0kmlAbF0I1GUirXWuPGTgAAB0YCAAAO67w==
Date: Thu, 9 Apr 2026 13:57:42 +0000
Message-ID: <IA1PR12MB63079F9EC61A08C46C2DAF2FF8582@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <20260409131411.10598-1-spasswolf@web.de>
 <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
 <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
In-Reply-To: <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-09T13:57:42.250Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6307:EE_|MW3PR12MB4412:EE_
x-ms-office365-filtering-correlation-id: 66e16231-1ed9-41a6-c95e-08de963ff837
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|13003099007|18002099003|22082099003|56012099003|8096899003;
x-microsoft-antispam-message-info: ABjTyTPh1xz8Iq90/dSdTHniGDTyHeQAZIU10vIUnNKeTIbN2K67tVE88lUjZjtjD6Gw64g2VSdm+7B4kx5ESac7qeLxmlemz/WMKKR9wLJP1gJY9BUNKuPNMPlZ0krCHWRBXeYocf7fXLc7gGLz1W1Ihf+5SUXRLRVj0l2bTcR6Mlt7DZHoXiXNmigBReO9WnnVc7iaz8lzUQaMmucYHwJGLZ0kxXxSUMRJnDbaKUPHPYhArUs2SrfwDMQi2UcETCZtiMGh0XyPUNU7j3jWvVN5Lj6xi3woFPl3VQTj02QhFjZjtkwpFrU5Sx3MdBrWLYNzo/KBnHQFa9Tomcvm2bd5JQBbHTDOPoxWyeH7lXUhE4Wh04i9DOGemAuspr0uyEtOmXEtSlhveygeBO7rA26or9Kjyyap8dRG/EieIVANSIiNfcuDStyHz+pxFWzdthqLtqzS8w3YpbCO/Z6BLvsZ6dFlIyvwgFHdbdgBW3KJSzCBC8ei71WIcISgispn0aAm8NFClsjFKF9a1bzIojQVqONzp9/GEbHQ1kgs+45V3LMg7pWOlM1644fmh3oqVGjnrifFTn2V0bssZE7H5vo5OUjvvqH4MfPUirWMDwPfqStUtOOcW9tSONM2iiRywKdmfcjC9ict6vpUaEdrS6F3JVkNhORGoi4s33R9+Xm+xQxyGhU10opBMjjZhUD8ozasQtgC89pSdWLj/N2aGkaOfFz65kY080zn/OTxmqjIovC870acVGJLpwMjh+CPoajGZuj2uGu3/pQ7AUU3EKOCcPzrpTaIkeLH+UjuCFQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(13003099007)(18002099003)(22082099003)(56012099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WsvFs5F9ccjHVxL3LWnCcqw620hGkOP6sJx0Kw8E1vYUao7STeSBa79GaH?=
 =?iso-8859-1?Q?Mzkr12L/+S6uvRZ1T6tton4Yua0DDMSyQa7Xgvp93z5f0DKVSgVFTr+ifp?=
 =?iso-8859-1?Q?SbqOLQIChLhPAIb2aQrPLQEUsDERtCEkjBXIh7u2KK3AJeMyj3vzBraM4r?=
 =?iso-8859-1?Q?xSAZZkY8p/qhk4L5akIHGQ+k/nClWG/A/G4cy9SSi+jvCdmEHdyQlRAPGR?=
 =?iso-8859-1?Q?tO7/XJ2EHdeS7/UOy5bdQuTY4MXG2CWuAsFgjmGsbMth9a2QR6CT1Kx5xw?=
 =?iso-8859-1?Q?gCbjOetXoHdP7jp56GHQKiwlqsyLMP1qdTgq6tRuw3wlPVhVclZiqNkMEh?=
 =?iso-8859-1?Q?RRd/AV57rvxhElq3+Q7eWMTLEiOjCqpr6tKEjZ7sJpvKlA/0ek2Pk2F6u5?=
 =?iso-8859-1?Q?giX3dk+0GI3mjIsFoedBcL3ZJ3TbfKqUIz3coam363D9kkkRcNgrkLm2+7?=
 =?iso-8859-1?Q?b+b2U7BpaSa7i9zl+WH09VreAeRqmutsv6nZAowJ5hWrBzOppcUE/PCDa5?=
 =?iso-8859-1?Q?Bc6h05AdxR3e60BcLKvrIcHRFNS4Nj3bXL6PMazdZ0/VZoSyahEktlPiK3?=
 =?iso-8859-1?Q?LwYxv5k2Qwd/iZV+AcPExZLr0WPK156gDfdOVcCoT1vWHUzsBotNUIzN42?=
 =?iso-8859-1?Q?HzWOoXA3ggVq1LhYSU7l0FYchnb1vKR3eAyfw7zRHVPHsvWGTsueZgq+0t?=
 =?iso-8859-1?Q?SOUpZP6TFp090gqoAKYsqNQj7T08GgDBexpYWkup/IRajFj9lE/wFrhYa+?=
 =?iso-8859-1?Q?OmQouEP4EI6Fv36aj3Td4bgpFLs7AsytMLI8KvEAQXoFARquktSEy0tqZ5?=
 =?iso-8859-1?Q?8k/HdrC+2xV34ZBwEkzuNKz3X1t2Y/JKurUZUhz57ke9d3yZnrNvrFMvh1?=
 =?iso-8859-1?Q?ggjbgcJ+zleT1YqThw8lWGrFTfYUWXxezajcZQ7AsYGxdBUw8JjMO+6m7y?=
 =?iso-8859-1?Q?nYvnCsf38eOlECAcEDm6x/5ZVMquvrlejanaZYiLaXdPQVtVG4/CXVpaF5?=
 =?iso-8859-1?Q?MUrPz1dhh2EmJ5LULtPUOvszanAdV83hXFGXE065W5eJ35pAOBlNNLtRpb?=
 =?iso-8859-1?Q?olGcrXDYmTsB4z+8kZJzolOtAkA5r8/RieOdbVHY6RxLPxglIxlrG/wMoX?=
 =?iso-8859-1?Q?HZFCXazaRleXI4UzY2LD/8LGyEJ+33EBWJ2aC195Lp62OIPnYwOifyy8Cc?=
 =?iso-8859-1?Q?yO5bCiC7qpkPVFhsKInWvLsA0M9G4eXUP5Yr2oN1KYnriiQo9LHPf0XZhz?=
 =?iso-8859-1?Q?DGr6AkFqA8/TATDa/8Q8nTI8QQofYdfVQ/RoEW6ZKYRKwNoZYIhkjgnAQb?=
 =?iso-8859-1?Q?zTxcAGUEkiuSudywZGza7hfwWJL4sOMx0ObM3mWWob6ACsTlQhsmVzosDW?=
 =?iso-8859-1?Q?MFDPRp5UN6FGkidMq/knwQdsrsdMhEc4OCwFK09/Z2cLFX1c125rZFIFib?=
 =?iso-8859-1?Q?dUx6IrylEOHYADZmClLc1DKoaDDw/ceiQqsxG1Jtfv8VO2JzPYPhfjBM0Q?=
 =?iso-8859-1?Q?j1WsnASvAuxoxUAkTk/Hzyglr6RK47Co/JMXHutyeyHTmBg+Jbj05RxiSl?=
 =?iso-8859-1?Q?+a73TtfnIkxvDCQp5YGBZqB+CxzmK0F4rFcXyukJp34oqfnS7GpRD3hZYG?=
 =?iso-8859-1?Q?uxTd3cEt694ykUiq7AITfesu7+ZuKFiJKbnEQyvspe2/pqaQwNdn+ENmE1?=
 =?iso-8859-1?Q?Vkp0czxptzEFmAueSokAey7IQrBAJ3+nmiQjz6XVgO6gXDVjKqDA0pYEsJ?=
 =?iso-8859-1?Q?32kI2kTGa/CZyjOKszjcOwdmIO+s6+2jVkbFiTW22tc2C8?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB63079F9EC61A08C46C2DAF2FF8582IA1PR12MB6307namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6307.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e16231-1ed9-41a6-c95e-08de963ff837
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 13:57:42.4417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qcXCJr2o1VE9zvukb8xyPZuaI99giQQd8VyarVgTD0cfIxYuVHKzTA/GjmENYs7TRDkXeGCFectl/Xb20/SgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
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

--_000_IA1PR12MB63079F9EC61A08C46C2DAF2FF8582IA1PR12MB6307namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

For a quick solution I would recommend:

  *
Check out before faulty patch
  *
Optionally (as workaround) wrap faulty allocation with DC_RUN_WITH_PREEMPTI=
ON_ENABLED in amdgpu driver. But you would have to know exact call stack in=
 amdgpu driver where allocation happened. Not sure if you will be able to c=
ollect stack trace for it

Problem is caused by illegal allocation when preemption is disabled. These =
3 patches were changing preemption blocks location. It seems that some path=
s were incorrectly covered.

I will try to reproduce it on my side. I will be back with more information=
 tomorrow.

Kind Regards,
Rafal

________________________________
From: Bert Karwatzki <spasswolf@web.de>
Sent: Thursday, April 9, 2026 3:33 PM
To: Ostrowski, Rafal <Rafal.Ostrowski@amd.com>
Cc: Varone, Dillon <Dillon.Varone@amd.com>; spasswolf@web.de <spasswolf@web=
.de>; Hung, Alex <Alex.Hung@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>; Thomas Gleixn=
er <tglx@linutronix.de>; linux-kernel@vger.kernel.org <linux-kernel@vger.ke=
rnel.org>; linux-next@vger.kernel.org <linux-next@vger.kernel.org>; linux-r=
t-devel@lists.linux.dev <linux-rt-devel@lists.linux.dev>; amd-gfx@lists.fre=
edesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: kernel panic when resuming from hibernate in next-20260406 wit=
h PREEMPT_RT

[You don't often get email from spasswolf@web.de. Learn why this is importa=
nt at https://aka.ms/LearnAboutSenderIdentification ]

Am Donnerstag, dem 09.04.2026 um 13:30 +0000 schrieb Ostrowski, Rafal:
>
>
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Bert,
>
>
> Sorry that you experience this issue.
>
>
> Do you have all these 3 patches?:
> "drm/amd/display: Move FPU Guards From DML To DC - Part 1"
> "drm/amd/display: Move FPU Guards From DML To DC - Part 2"
> "drm/amd/display: Move FPU Guards From DML To DC - Part 3"
>
>
> These are highly dependent on each other.
>
>
> Kind Regards,
> Rafal
>

The crashes also occur when all three patches are applied.

Bert Karwatzki

--_000_IA1PR12MB63079F9EC61A08C46C2DAF2FF8582IA1PR12MB6307namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
For a quick solution I would recommend:</div>
<ul data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:false,&quot;u=
norderedStyleType&quot;:2}" style=3D"margin-top: 0px; margin-bottom: 0px;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); list-s=
tyle-type: &quot;- &quot;;">
<div class=3D"elementToProof" role=3D"presentation">Check out before faulty=
 patch</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); l=
ist-style-type: &quot;- &quot;;">
<div class=3D"elementToProof" role=3D"presentation">Optionally (as workarou=
nd) wrap faulty allocation with DC_RUN_WITH_PREEMPTION_ENABLED in amdgpu dr=
iver. But you would have to know exact call stack in amdgpu driver where al=
location happened. Not sure if you will
 be able to collect stack trace for it</div>
</li></ul>
<div><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Problem is caused by illegal allocation when preemption is disabled. These =
3 patches were changing preemption blocks location. It seems that some path=
s were incorrectly covered.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I will try to reproduce it on my side. I will be back with more information=
 tomorrow.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Kind Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Rafal</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Bert Karwatzki &lt;spasswolf@web.de&gt;<br>
<b>Sent:</b>&nbsp;Thursday, April 9, 2026 3:33 PM<br>
<b>To:</b>&nbsp;Ostrowski, Rafal &lt;Rafal.Ostrowski@amd.com&gt;<br>
<b>Cc:</b>&nbsp;Varone, Dillon &lt;Dillon.Varone@amd.com&gt;; spasswolf@web=
.de &lt;spasswolf@web.de&gt;; Hung, Alex &lt;Alex.Hung@amd.com&gt;; Deucher=
, Alexander &lt;Alexander.Deucher@amd.com&gt;; Sebastian Andrzej Siewior &l=
t;bigeasy@linutronix.de&gt;; Thomas Gleixner &lt;tglx@linutronix.de&gt;;
 linux-kernel@vger.kernel.org &lt;linux-kernel@vger.kernel.org&gt;; linux-n=
ext@vger.kernel.org &lt;linux-next@vger.kernel.org&gt;; linux-rt-devel@list=
s.linux.dev &lt;linux-rt-devel@lists.linux.dev&gt;; amd-gfx@lists.freedeskt=
op.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b>&nbsp;Re: kernel panic when resuming from hibernate in next-=
20260406 with PREEMPT_RT
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">[You don't often get email from spasswolf@w=
eb.de. Learn why this is important at
<a href=3D"https://aka.ms/LearnAboutSenderIdentification" id=3D"OWA5ad363c2=
-2637-c2ac-d146-791262a28a9a" class=3D"OWAAutoLink" data-auth=3D"NotApplica=
ble">
https://aka.ms/LearnAboutSenderIdentification</a>&nbsp;]<br>
<br>
Am Donnerstag, dem 09.04.2026 um 13:30 +0000 schrieb Ostrowski, Rafal:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; [AMD Official Use Only - AMD Internal Distribution Only]<br>
&gt;<br>
&gt; Hi Bert,<br>
&gt;<br>
&gt;<br>
&gt; Sorry that you experience this issue.<br>
&gt;<br>
&gt;<br>
&gt; Do you have all these 3 patches?:<br>
&gt; &quot;drm/amd/display: Move FPU Guards From DML To DC - Part 1&quot;<b=
r>
&gt; &quot;drm/amd/display: Move FPU Guards From DML To DC - Part 2&quot;<b=
r>
&gt; &quot;drm/amd/display: Move FPU Guards From DML To DC - Part 3&quot;<b=
r>
&gt;<br>
&gt;<br>
&gt; These are highly dependent on each other.<br>
&gt;<br>
&gt;<br>
&gt; Kind Regards,<br>
&gt; Rafal<br>
&gt;<br>
<br>
The crashes also occur when all three patches are applied.<br>
<br>
Bert Karwatzki<br>
</div>
</body>
</html>

--_000_IA1PR12MB63079F9EC61A08C46C2DAF2FF8582IA1PR12MB6307namp_--
