Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BAAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 16:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5828510F84C;
	Mon,  7 Feb 2022 16:27:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 304FC10F84C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 16:27:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h05wwbc7TrfIV3H/6W6XdkN3t4rgw1/G0/t5uWrVIedqFDb2ddwkoDRkHh6J/3yyaTxxY3mUQY2T2qWKYVDzyhJ8Pg51Id1SnK6bcnpVxCcYw1y85BMhlcVD3T76q6zCYbhsaMFFUOy2vs04oc2bZtXT+qPvL7xjMZMXLlupeYjRUwn18uO4xqwQqNBArMpepmOtGOeL5g6s7awrX6If+sosUKq4RKXdR8dkTOGTdRtBiA0A98l8EwxEgUepT5+b2S2OY9x7TQDWtVBFVf6XRqSvLIOC9/4qodWNtD5WiUYHuJmi0lMcvOs7/XUaRuwJdrDEAoJzQb0QlL8fz4riUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b23farzzCy2FcHlaGcQPTDIVSA0lRPVScNDebAdRryA=;
 b=Tgzv7zR+dfb3/JbHcqQSQzYeEPe2PgPfx/hL26QhxlBCHYobzkCvn9/wCcfc/O9U5ZW92QRr+tQLYpW7FPDhr0QCdWHTF8/B//MTEV42DdbpKANULpPAqwzLx7ZzHp0E40XIResj6V4b1HY3cOU2aa4CevRtbtOc0tDej/DaETmFs97GO4ku4McU26abiX+rGmOywNP5kBJ+Dl6T2VQWkEQg83B4QnBM0jG4V7iwh9591HgXXV2PBLOat2X/IFyonwu/bskFzkN6C4L090UVq57Ssbpwr+ZeplWTLcB9Bhsed2jvOc7wKs3cYHiLIb9Q4hMxmDmtNJ+umdpPnumprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b23farzzCy2FcHlaGcQPTDIVSA0lRPVScNDebAdRryA=;
 b=SZHo15sQDTgdfcKtDl1fVuKb5n30TYG9PkiDUFoaTH1KI5IcTkNAebOA9FNpT1YWGVoFejPtHXdciFtpXM5DiUQTDdvtpU8CoYH8/fxjfOa3hW5OYZcVAYRAo7O5KFfr19nMnHYReIxv2JQPIIq17cjIpQKgPvlF12DLK1+y114=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 16:27:07 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%5]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 16:27:07 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Amol <suratiamol@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: Minimal GPU setup
Thread-Topic: Minimal GPU setup
Thread-Index: AQHYGnVmlqCINGTv1kiEStr/P3/lrqyIRtjV
Date: Mon, 7 Feb 2022 16:27:07 +0000
Message-ID: <BL1PR12MB514403668180CB26983C25A7F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <CA+nuEB_u4G-Nf_nHODoY86anP6s0vRyh=0-yPxphbksbCPJ1Yg@mail.gmail.com>
In-Reply-To: <CA+nuEB_u4G-Nf_nHODoY86anP6s0vRyh=0-yPxphbksbCPJ1Yg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-07T16:27:06.780Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 05e6fd0d-c607-6ee9-295e-79e61abea1cb
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02ef054d-3bf5-4cc1-94a9-08d9ea56af14
x-ms-traffictypediagnostic: CH2PR12MB4279:EE_
x-microsoft-antispam-prvs: <CH2PR12MB427991F4223EA8B018585E9BF72C9@CH2PR12MB4279.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7oeC3lYvyaOB99NavbK9aDAxbsGe89cwmJCpGmmZ0eOthKSAnTjZ+xPnZsgyfYIugcX/nG8lGZj2Pz6E7GUb7gZ/ltBJxtxFaDRhYL9kK5FeTYiqgm82SVwA5L2xhlU1PPonhsRREJFBLHObAkCm+P7bA3Cz7SiESrXrKNrLRwkW3k5+bpORxcEgMXBcY+y7O5LjMJVXgaQ3xHIbcpQ1llGtdblMM6CoV6uGpr2SPR0qsxuPVrPeBqhnRFx+KrBxHjt8OP+ClV3scK6UaXm9tng1OIWPCdSqKUIBMZA5uwIHO4VO+NYom+2zjhuJmz9KyVu3m733q9/K2SyqEOg/WV9ASW4MD6S78l+4rgKwtfkTEZnLl16ivSQblqTnfYncspmtRtcs2Jdiq+lprJs1Wy+G0uhUv2B6IY3LY0gJQC0ty0LywBl26gkKwKOj33O8pSExYgprGtQgsyiGQW9WIZ/fhbCfAjUDPKHufU0pqhHhQTJegsbdkXBYu36KKFnjjb3NABKgKbv8kXPW+4Y8HMrDSfHokMtkNI4PK+IDhgFZEryXzczDvgXAkcd2s+hFS6asclzVmGihHmzXbmQwgc9RMv57iANGLnWsVhtq/wOpdDmlLK7E+eCpw+dz/CQVKeqorVEA+nmRBq9bOOmmeOaM2HJ0+vAVaBLl/16EfrGzQRkP+JPKkrGYUtzfmI7vKnQ4liXS5CGkEXR0rHamw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(53546011)(66476007)(55016003)(86362001)(66556008)(71200400001)(7696005)(9686003)(6506007)(83380400001)(38070700005)(33656002)(26005)(186003)(3480700007)(316002)(5660300002)(76116006)(66446008)(66946007)(8676002)(110136005)(8936002)(122000001)(38100700002)(7116003)(64756008)(52536014)(2906002)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?o/sc03jXe4822zaXSXyZCMXG5L9Et5m+LBqF782nQKzb7vYMz7R9+ZfRvJ?=
 =?iso-8859-1?Q?4C05TcbYdh6Z4O1tTwT7nDLbBqpMdni+HxCnZpGDpmziJTKvBcv3hO5U2S?=
 =?iso-8859-1?Q?gffRpy1mL9jrzGV7W0zdM+awNkjTRYUsmOfZuW7tMt9JatJ7Kxqyr9j77I?=
 =?iso-8859-1?Q?MXqq5oTnBIO8zcMb0xoC+EjkeJRYPXJljAA32iamuLYCsjcz/Us783nXwK?=
 =?iso-8859-1?Q?FHvWIsNeODoOpkArgFcBIFaS0YhjGAQQNmweD+MqWxRoLouAk0CLawpmQO?=
 =?iso-8859-1?Q?qNs3L3byYnqaf7kkz8q3FHWg3G5lQvnr7YwN2WudCW32iiwREGl97Xs3wv?=
 =?iso-8859-1?Q?XfOj32U2dtPRU8/x/aBM9jMkpuFND2fAcMUGGtNZNVupqkkLmUMpuF/Q/H?=
 =?iso-8859-1?Q?xn7XNXLqgXZ/SrgQTtGBon66OdEgYGpXLZc9rwmAhSxMExE3p1CYdgNt75?=
 =?iso-8859-1?Q?lFxLoIpxBaN0JOGe8y4mWopQNtVDZOeRa9tH3m8HX5WTZCh+0lAjQC+x48?=
 =?iso-8859-1?Q?gVH/rFjMralIwDNB00qKhdGUxVYhAqHs4XPHaeu35e2Ojas1wb4WaPfOp6?=
 =?iso-8859-1?Q?vUKu4cZjHd8U6h4uxFpA1Z02dbxsy44hBKSJkYan6q0IYdNjXFpcKWF6fv?=
 =?iso-8859-1?Q?vjZl0CuNp00JDMGyOmvpKLEHavP48ZAwBn8njHK1+XTIKZYsYYAFzMeExB?=
 =?iso-8859-1?Q?7Wg7OdsMosCs7HQnao57b00cq11omYvbEpI+lUpMgWrtAaSyAFjUakpXF3?=
 =?iso-8859-1?Q?jLUHIr/1PdRX7BZ/y10roVCjQ9GnkTro0T8YKTcmcNx7xxjforQwHHK/EG?=
 =?iso-8859-1?Q?wtRYUMt5dxtgQNP9yxYOj5cyYE8rhYNOfurxZna6J11RiQDLSy/Y+nsua4?=
 =?iso-8859-1?Q?Y5hCc9PgWe/6FSsofEP9cD9tHxStrRLvCQK49446o/lvVvVHiVU7N+4fED?=
 =?iso-8859-1?Q?ILZSxRpfZJxk71zhTMUapDX7GN0JDnXvqX0NHjp05McQ1lxFEBV6rfPS80?=
 =?iso-8859-1?Q?VAAQ1zHWGNHgnOZIgTjHVCMhfh1WiNkPhbAJJlaXl2neLKMq11UBLrmywT?=
 =?iso-8859-1?Q?Xld1M14zWu9IvPFu7cvG9i8Jag7sOaplYwjNR4vwEvLp+VXjUR57vehlVM?=
 =?iso-8859-1?Q?0UsBSvyZ79+nqId396xJCXsSXpcDngb06nEwsBS2/zS0+MBYVVGvsj/qZZ?=
 =?iso-8859-1?Q?bh7HGqy6jbQnK1qEI4gHyp+mBOzCFwlCBqYYp03YXsGVVmroS0viFD3xZn?=
 =?iso-8859-1?Q?ZPNTnhJ/dizmo4La3wzE4KJ1/JStsvI972u7oVkHH2UTz8yLFYlOHUPIS0?=
 =?iso-8859-1?Q?7PsADsOq9NgO5GN5Xekic0gB0qJBTjRShEscFe6D/HGrPgJhY0VrF+xXLI?=
 =?iso-8859-1?Q?EbXitJcXPPEcTC6742PZfthnKKOPUdNeE+bjXXJwCFlQEaD3t2YOBUgLNf?=
 =?iso-8859-1?Q?fA3An0yonvUVswoEdcyP/ri+8Qz25AZzNu3eZkIwVE+KzszF1SI76FUOcW?=
 =?iso-8859-1?Q?KzHcz03GHCdBAtZCEntjoVPm9cSg/ceTeJqRpadOMK9POenOosXrt8+Ov3?=
 =?iso-8859-1?Q?dqLbq/7ihclhvNfiwdJVEVliu2gkv0Wx4ZsK0Qw/WRYk8x5f1chIKJKM8g?=
 =?iso-8859-1?Q?nfhtDWteKCVCZvDbbVx83uvReboemzLbnV8B8wkdz8n6JSWREvy7edWxEr?=
 =?iso-8859-1?Q?Tl/nYudryNBwzgPSGYo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514403668180CB26983C25A7F72C9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ef054d-3bf5-4cc1-94a9-08d9ea56af14
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 16:27:07.4303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Z39tm86XMYpXHZGa0BtMp+yH21PyVNzMYTDliT4Bk855xTWt5tbH8TaJJQ2ULY1Vrb9heZhhjPwejBeqHwV+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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

--_000_BL1PR12MB514403668180CB26983C25A7F72C9BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Most of the register programming in evergreen_gpu_init is required.  That c=
ode handles things like harvesting (e.g., disabling bad hardware resources)=
 and setting sane asic specific settings in some registers.  If you don't d=
o it, work may get scheduled to bad or incorrectly configured hardware bloc=
ks which will lead to hangs or corrupted results.  You can probably skip so=
me of them, but I don't remember what is minimally required off hand.  It's=
 generally a good idea to re-initialize those registers anyway in case some=
one has previously messed with them (e.g., manual register munging or GPU p=
assed through to a VM etc.).

Posting the bios is enough to get you a working memory controller and enoug=
h asic setup to light up displays (basically what you need for pre-OS conso=
le).  As Christian mentioned, loading the ucodes will get the associated en=
gines working so that you can start feeding commands to the GPU, but withou=
t proper configuration of the various hardware blocks on the GPU, you may n=
ot have success in feeding data to the GPU.

Alex


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Amol <su=
ratiamol@gmail.com>
Sent: Saturday, February 5, 2022 4:47 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Minimal GPU setup

Hello,

I am learning to program Radeon HD 7350 by reading the radeon
driver source in Linux, and the guides/manuals from AMD.

I understand the general flow of initialization the driver performs. I
have also been able to understand and re-implement the ATOM
BIOS virtual machine.

I am trying to program the device up from scratch (i.e. bare-metal).
Do I need to perform all those steps that the driver does? Reading
the evergreen_gpu_init function is demotivating; it initializes many
fields and registers which I suspect may not be required for a minimal
setup.

Is posting the BIOS and loading the microcode enough to get me started
with running basic tasks (DMA transfers, simple packet processing, etc.)?

Thanks,
Amol

--_000_BL1PR12MB514403668180CB26983C25A7F72C9BL1PR12MB5144namp_
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
Most of the register programming in evergreen_gpu_init is required.&nbsp; T=
hat code handles things like harvesting (e.g., disabling bad hardware resou=
rces) and setting sane asic specific settings in some registers.&nbsp; If y=
ou don't do it, work may get scheduled to
 bad or incorrectly configured hardware blocks which will lead to hangs or =
corrupted results.&nbsp; You can probably skip some of them, but I don't re=
member what is minimally required off hand.&nbsp; It's generally a good ide=
a to re-initialize those registers anyway
 in case someone has previously messed with them (e.g., manual register mun=
ging or GPU passed through to a VM etc.).<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Posting the bios is enough to get you a working memory controller and enoug=
h asic setup to light up displays (basically what you need for pre-OS conso=
le).&nbsp; As Christian mentioned, loading the ucodes will get the associat=
ed engines working so that you can start
 feeding commands to the GPU, but without proper configuration of the vario=
us hardware blocks on the GPU, you may not have success in feeding data to =
the GPU.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
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
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Amol &lt;suratiamol@gmail.c=
om&gt;<br>
<b>Sent:</b> Saturday, February 5, 2022 4:47 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Minimal GPU setup</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hello,<br>
<br>
I am learning to program Radeon HD 7350 by reading the radeon<br>
driver source in Linux, and the guides/manuals from AMD.<br>
<br>
I understand the general flow of initialization the driver performs. I<br>
have also been able to understand and re-implement the ATOM<br>
BIOS virtual machine.<br>
<br>
I am trying to program the device up from scratch (i.e. bare-metal).<br>
Do I need to perform all those steps that the driver does? Reading<br>
the evergreen_gpu_init function is demotivating; it initializes many<br>
fields and registers which I suspect may not be required for a minimal<br>
setup.<br>
<br>
Is posting the BIOS and loading the microcode enough to get me started<br>
with running basic tasks (DMA transfers, simple packet processing, etc.)?<b=
r>
<br>
Thanks,<br>
Amol<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514403668180CB26983C25A7F72C9BL1PR12MB5144namp_--
