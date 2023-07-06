Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8ACEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 22:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA7B10E0C1;
	Thu,  6 Jul 2023 22:14:29 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6891210E0C1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 22:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXCwjY/a3zKqE0UVap+LTmbQIhj7QfMwK2vi8OTYMeJX8jHqvfBtuIV4MRxhr4Z3mHlwTmiRpXfWhRpHNkSzFrhgxhM6Ss80JEHYaTlpafgIMnuI4lVVteIzqdZ/alCcuha3FCHo+D4HNyvkK/Zvgd3wleJZ0PwI46Dc85M4qR/R+ltbn3W/kooJmjM6/ksMIdYYJdQCqwhEwHmzMvOIu0epOneCpkm2qugjEzxKrhHeIgsgp23Uk+oif1j9najlSPp2y0zM4x5SGxC70Or6Bih3g3bRmpC1lNLTu5M9SJpf/G1n+lbAkNIrL8oz3yuIkcd0vuHc6WYo1Zf5GXTuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO/zKBTWuEjcGgJxd2VvjhAeFSdthukq14eh5Aguk9I=;
 b=WafIpYumV8jy9+brRKF0hh7XK8AR8Bp1mu36qGkPcQ0nSW6oQDi1wjciBU5giTnoJsWJYES7udA9KtKX0LCMty/6n0+buQC/Nw53f75GbrUBu8M7mN4TTlSvk9vSZ747QoVaE7oPaSNPL8X/V5nB0F5b+9tP3h8dKs8cPXqOhbUTUsHUFiG8QzjxjFksIFO6V/OiMBBCyZGcq7hlPPLz3khnp/rba0r3G58Ht6Bj8+4KU63zGwPLJ4AryLIyA1okbv2CitBCCRjJBHl3VwlCPX2C1dQ4s4zN5faffdg6REiFclWvLcLPUlpT304CPj5TtGEqkBOYToKXz7vqlJOsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO/zKBTWuEjcGgJxd2VvjhAeFSdthukq14eh5Aguk9I=;
 b=Qu00hBcPQHSOX+yvyYhsBaZy/47ksay0ugHyecHOMmvgvWEv961tm3G0Di7aDYQMJACJgTTNYJvQ/VSXLl9jaPHjQ5PGy+bcZaAK2X4UhCtBx7rViaToa7XVLRznENksLsxrjY7e9yym15TTFSv6ZrE2fHUCOctHLn+7FE9si+w=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 22:14:24 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 22:14:23 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel.daenzer@mailbox.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Do not set drr on pipe commit
Thread-Topic: [PATCH 1/2] drm/amd/display: Do not set drr on pipe commit
Thread-Index: AQHZr2ug2Rr1VBGArEyzNhkdghCT2q+shBWAgAA/C1aAAAWVAIAAhmQn
Date: Thu, 6 Jul 2023 22:14:23 +0000
Message-ID: <CH0PR12MB5284C232D0393D5AFD421E0C8B2CA@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20230705180752.2813978-1-aurabindo.pillai@amd.com>
 <dc331ebc-7032-033a-0076-b80472920e79@mailbox.org>
 <CH0PR12MB528437E7114C0CD07C1491F38B2CA@CH0PR12MB5284.namprd12.prod.outlook.com>
 <a5a0551f-74cb-7ec0-eec8-2d82f193d98b@mailbox.org>
In-Reply-To: <a5a0551f-74cb-7ec0-eec8-2d82f193d98b@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-06T22:14:22.898Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|DM6PR12MB4201:EE_
x-ms-office365-filtering-correlation-id: 08be9e53-3659-4b69-ee6b-08db7e6e5ac0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TVMoSDv9wQH4S7vaCJgqLlKNih4wt3w1dUceK5uMbR04nI4Z56qfS5YlzfkxJ0CLN6N91n1vljU5AyfjX8OFIwUm8FRKu4Rk/1kt5h3fH8GaBqxYYtfq7EA662UovHbE74bGnxOeXPD9FJOuHaSGcFnNSJp9mXSfSP/ORwxbsj214QT/iIt35ck0VYR2QKgk0rxWhENUFfQBCMjyAy+SB5ErOH0F2VtfebUEuKpwg0eNTIynfY4ORi84/caa8W7dgWxm1PYydOe6gzlDxlUyzK9MNwPVJFmb91b8UjmTAuE3kW/Ct0gBN/x63qMd/qtzQrGWe3hxPuSfGRhPnYqeynRt5wY7lupWywh2m0LIuMjw8Jf0hF0lthNrQIp9KVavb3L7MmsI8dOj3kZPGUxMum/tZTtaIjJEvhjsHpwKTkRwX9SbjmGTFYBV0zRIsiTvJ3flkIqfV4uNSPEAI5kalgRalBj7WYHd8k6RmLHl+GXePN231SL9r1x5pdjQwtXofCVUDKMv2a7tTlSQdUszIYFyQqqOIEH8n/Sivy+E+FK5U6HG8jAakMJ8w/ktaJZRL6J3en21saUTARD1QAzphrcOArZIgtJFZB4DakuR7S8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(122000001)(71200400001)(478600001)(7696005)(91956017)(76116006)(110136005)(54906003)(26005)(186003)(53546011)(9686003)(966005)(66556008)(2906002)(66476007)(41300700001)(66946007)(66446008)(316002)(52536014)(8936002)(64756008)(8676002)(5660300002)(38100700002)(4326008)(166002)(38070700005)(83380400001)(33656002)(6506007)(66574015)(55016003)(86362001)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?07CSFXtwDEPwcaFYVKcf4GLy+l7z/+/dJXFRR0tjssWCfvAFmRHzr7QKQv?=
 =?iso-8859-1?Q?ZJBMfpIPoiQwjQA63qPBp1A41lGteTtuS91RTIKEdWHV6Bfo3DijUSiOec?=
 =?iso-8859-1?Q?gZHUOPQ2n5uVDyMeO85AzfSjDFJVnQTJ8tTkFAK0GB4ldgGVbfPJQe+QCT?=
 =?iso-8859-1?Q?G3XFp2Z8s84sn+7xwZ/LRh0DK01zNTrNhJCMMu7nPC7QHUxZKmRIm7aVf6?=
 =?iso-8859-1?Q?HAvLSXe1SY+e3MtPs8hlQci1g81dC7RO4xOnlHtR04ZYbqR2iao3VHAjyx?=
 =?iso-8859-1?Q?4QSj7oYHl2CVEk37j1YvthhbwUd26L+014b8nHqMiPedbq8A51HOmHYvgO?=
 =?iso-8859-1?Q?uEnP1KeuIoiI2if6l5cVoMUuLNZ7cvwQ/Ygbl1RcWRbJeX6gdK/Eihxyja?=
 =?iso-8859-1?Q?wsZUD/E38lAwyeFSD1aCNpFgznLpLKd8R4IEvMfMBFeA5hEL2MLjJGPXxC?=
 =?iso-8859-1?Q?TtFOXfE6gXhb5CUMJ7D5JTEhXrG4EqRFgvxz1f+4tQPp8QwrW8o0Fot8/0?=
 =?iso-8859-1?Q?8PtGYM5238Z2lKqLxraLcJOde4k+z3xpLW1NhS3i8+i9D4LHvBzYtNlf+N?=
 =?iso-8859-1?Q?n05aZ/FY2S8vfSJOCmgjf6hYE/Ji7jxcS1A79GVtw+2Ld6RX379CmNYlm8?=
 =?iso-8859-1?Q?Qgz7FSeBRuG9IO4dcU6dsg3MHMBUBTQcrgHWHg4up25bQk6ODc292A0XE+?=
 =?iso-8859-1?Q?9nbnTYpDdAiUoH/32AnksXn1bu/5IhPhQyX9GypAsELja81ZPRXsQrz8Zy?=
 =?iso-8859-1?Q?Kz/UxtqV4zM/38F1ZRoEzDt4DM6uxqlxVNdKHy0fgovGwDPVNemoO7ZMZ/?=
 =?iso-8859-1?Q?KhCJW0GIO5OWOhFLAK0ocPyczD4IyFLDnUMqeewV89sA8ovtx3GXXbVviJ?=
 =?iso-8859-1?Q?d+6yJ57+unDTGN387GhCajwd8JyxTgiXVBpeBFFWyQIwXOJEy02VBG0zh2?=
 =?iso-8859-1?Q?Foh+euoHQdKLg49MsglDYGoSGN5jQl4wSE3PS9lHohaadHC8qhJ2rUR0XT?=
 =?iso-8859-1?Q?bejggSEkAZbxrtlZbj/ta6R4tTBHp0Ih1scfZpl5USr1pg8o5Iu/FSblF9?=
 =?iso-8859-1?Q?hlgMCIn2sfsdcsEstLq4/sfJkEAt/ubJfNroRkUR+BJL2swjweQufHpMHa?=
 =?iso-8859-1?Q?h2/t50me8sqa0TteSdfwanrEHIA8Qgs1Fp3ZqG5tQXmtWJIa6Fmx2weSuC?=
 =?iso-8859-1?Q?anb6GphtX6ffiui5ToshKlCkLtSvaf27qVvmhReEaqDB+EENHsFkaomE7Y?=
 =?iso-8859-1?Q?FgiTdadaKy82XF5aNWJOTItpsMqHH6KAUeOJ3BegxTCF8VPQ971VwYhohY?=
 =?iso-8859-1?Q?dV4VgLVwISJn/Wb6DGZbfrQxtI+pRnwXfYvv3SY95yXJaL4KwTKGxLDFW7?=
 =?iso-8859-1?Q?ZIHJjn1Aq8SSmPY+pSl/6zzfA9+U0b1dkfS+lL0j9XqvniQtBS7ds3qvdW?=
 =?iso-8859-1?Q?vUz633mmn789XpIDIkftTMjZ7hykFJy4ndXC/0Ii/B9O1BNj9wxBYUeCOY?=
 =?iso-8859-1?Q?FVltdJMZB6hWchPAX91G3o0nyM9/s9nrYpr8T+si8QWNPJzXef38zjubcG?=
 =?iso-8859-1?Q?HROF5u3uZia4WGabeuoPi72cDVKITM2K1LmpYlPGHwXq+75aRgSQPU/XE+?=
 =?iso-8859-1?Q?aLL6hk6ltheK0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284C232D0393D5AFD421E0C8B2CACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08be9e53-3659-4b69-ee6b-08db7e6e5ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 22:14:23.6925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxP2m7qgd9IiRfFAc+3vzTpn5F7psoVfeXRvOKiNTTVUehYW0b83xa2Hc8iktmAHvO8ZZVb/neG9or7O+ka2dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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
Cc: "Chalmers, Wesley" <Wesley.Chalmers@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5284C232D0393D5AFD421E0C8B2CACH0PR12MB5284namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

From the log you provided, I extracted the panel id so I expect FAMS to get=
 disabled on your monitor. If it doesn't work, let me know.

--

Regards,
Jay
________________________________
From: Michel D=E4nzer <michel.daenzer@mailbox.org>
Sent: Thursday, July 6, 2023 10:11 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Chalmers, Wesley <Wesley.Chalmers@amd.com>; Siqueira, Rodrigo <Rodrigo.=
Siqueira@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Mahfooz, Hamza=
 <Hamza.Mahfooz@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; W=
entland, Harry <Harry.Wentland@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Do not set drr on pipe commit

On 7/6/23 15:55, Pillai, Aurabindo wrote:
>
> Hi Michel,
>
> You confirmed in another thread the monitor specific quirk for disabling =
FAMS fixed your hang.

That's not quite accurate. I confirmed that hard-coding FAMS to be disabled=
 works around the hangs I reported, and you asked me to test an EDID quirk =
patch, which I reported not to have any effect for my monitor. Then I didn'=
t hear back anything until this patch series today, so I haven't tested the=
 de1da2f7fe25 commit. (I expect it to work, but I can't confirm it yet)


--
Earthling Michel D=E4nzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer


--_000_CH0PR12MB5284C232D0393D5AFD421E0C8B2CACH0PR12MB5284namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
From the log you provided, I extracted the panel id so I expect FAMS to get=
 disabled on your monitor. If it doesn't work, let me know.<br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Michel D=E4nzer &lt;m=
ichel.daenzer@mailbox.org&gt;<br>
<b>Sent:</b> Thursday, July 6, 2023 10:11 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Chalmers, Wesley &lt;Wesley.Chalmers@amd.com&gt;; Siqueira, Rodr=
igo &lt;Rodrigo.Siqueira@amd.com&gt;; Wheeler, Daniel &lt;Daniel.Wheeler@am=
d.com&gt;; Mahfooz, Hamza &lt;Hamza.Mahfooz@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.=
com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/display: Do not set drr on pipe com=
mit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 7/6/23 15:55, Pillai, Aurabindo wrote:<br>
&gt; <br>
&gt; Hi Michel,<br>
&gt; <br>
&gt; You confirmed in another thread the monitor specific quirk for disabli=
ng FAMS fixed your hang.
<br>
<br>
That's not quite accurate. I confirmed that hard-coding FAMS to be disabled=
 works around the hangs I reported, and you asked me to test an EDID quirk =
patch, which I reported not to have any effect for my monitor. Then I didn'=
t hear back anything until this
 patch series today, so I haven't tested the de1da2f7fe25 commit. (I expect=
 it to work, but I can't confirm it yet)<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://redhat.com=
">
https://redhat.com</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mesa and Xwayland de=
veloper<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284C232D0393D5AFD421E0C8B2CACH0PR12MB5284namp_--
