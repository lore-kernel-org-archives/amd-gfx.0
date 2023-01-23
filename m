Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55A4C05027
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jan 2023 23:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4140410E5CE;
	Mon, 23 Jan 2023 23:39:15 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE6E410E5CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 23:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZVbeMlXCQLDSrDxL5smkJWn/F4YT6a8SuzRfuPmxRIcH4D8LY0U1TzJPdqe5zXs7G6xAk1Q+hfWrIsifFtKdyteIzj+Map0IKKJJOEmJ1XUn82550oTFQ7zDYrhffMtIBuYy4BQHaRiv3Kh0yUgXlLH1+P/SI4S+WNuMBhNDVjeBWNHmUu/lQ3R7akHh1jEmNgvh3MXFVaOy/qP3AmL08dbawP3Wa58onwxLKKzcDLHosfA5x4wScQhGWIqc4VGfB3jZA6p9fvnqR82WUGXDnLrcXUcN1iZindnfSpS3H1SIDB0UFi13m9f1p2y67VFnBgU+GvOX5kiQL+Fd6BRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CgnzGgq5Q6HuuDnmPS1kHd5rTgg/2LD21oHTdAu2vM=;
 b=J4mhEgIhB0g7x+1CMmuLD7aYTUgl+sWlZcrNDFqQnD3Is4ybGiUVyy6xjuF2GM607J5aZ51KWPwfQTtl62poV+/SZfCtPxLAT8r6u58+haIkRZt5zerjRUzXVf26BSZ6W9DWZ40bAICbqB+l7GfCQKKIwuYIJW4yi6fc3FUSPEIcAyHBPZyaFYAAeqG3uo2PRMFbnI4G8qfRZjLs4lN2Xlz4iiKm0e1KscJx5hEC+2HOZO2pcLztQdmt4N+NlVBdjTQbqOX3sh77QZHgVvoE/Mt9qcl0kFJDWcFX/tBC8JlGWGuJBOxJdFIA4WVcBdyHiTtgb0gj0b+EMKBaUpTSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CgnzGgq5Q6HuuDnmPS1kHd5rTgg/2LD21oHTdAu2vM=;
 b=JbQhrtvJPgdwGeL0tuzc/0kaqSg32FeERpqFDamphCaUoyybdkloSX04lsTVszqnkufgP+PwTZRmxibU8OZRsxI6rWIJBOHMHPEvT5n1WPAxT4Be+ve0zwbZk7YoHRpVu+/n2MubySE7ZBfeyXMjbybbAVltks0mxea41vRAr4Q=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 23:39:10 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::7f6b:ed3a:59b9:7ab8]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::7f6b:ed3a:59b9:7ab8%5]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 23:39:10 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Newton, Jeremy" <Jeremy.Newton@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: Fix for UMR on newer C++
Thread-Topic: Fix for UMR on newer C++
Thread-Index: AQHZL35pnc02zerYFUuC5kSnu0clg66sqMt/
Date: Mon, 23 Jan 2023 23:39:10 +0000
Message-ID: <DM6PR12MB3547393735ECEDB4B86926A9F7C89@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <DM8PR12MB54149D94A961377F6515A254F6C89@DM8PR12MB5414.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54149D94A961377F6515A254F6C89@DM8PR12MB5414.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3547:EE_|MW4PR12MB7143:EE_
x-ms-office365-filtering-correlation-id: 5eed03c7-bbb1-4cce-e094-08dafd9b06cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xc7feJXGfCTLhodbBHHEL5j94a+31lEte97efR3r02nrhj8HuANyeNEcYVopYIf6COvtAO+KSO4iVno25oo2OsvwB6tanqsMDpqdTTldX4wf9xyIKBOKs9PV/TSErliW0ZlTKgKWncr0T6bjipXYALVk5RY6NnQpt2i4mK+PbsQMonPEJspRHwK7kZoO6QHXIgamDGodvRHMLmlsKRoId4/Pp7NWDib3aqQQJi5FyP18kjiEwRgKY0UY1GgjrprtZLRfOB07vx0bF5UMVXCGz5s/qLUJii/tBun6vsL+4Wu64nwIZvRRKZk1gSsY+Zd1Q6wzRkm0KbX6zZIXI6fLIWcJdN/x/EX467Lvlh1lJ15fnJFF0gFEORS1XF0Hpgan10jw+o1r/MZTfI5jDcrl92OVgsYIdoiaUseUKa2HA2FFY+VovMdqN+fIYUEFGWoeSs2xns3kV0j7/Q+501EY5aWqZS5/O34fxAOpu84qfGO5UXt5hEGe+yOdXDlsK3kfxTSDAsRMHzhRth9tT4MyqbgdEGq85MUzD05KzNZcX6RKpQjf7ddx9kGih/pnR+NldPa9orkWdR3jlen7mm0JPJhV6Q6WRdNEsRmd3/VqXvTizbaCkthxZlqzH4vxeXzDYpDkbTomuOXXaGD9eNTBjNMpLLikm1ih0/1ScK+q1FSTXAl/VXPwJ3jSj2d74PW09rD/LNA8MfOoFnevqCmG3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(83380400001)(55016003)(33656002)(86362001)(38070700005)(38100700002)(122000001)(66446008)(64756008)(8676002)(66476007)(66556008)(91956017)(66946007)(76116006)(5660300002)(4744005)(2906002)(19627405001)(41300700001)(8936002)(52536014)(478600001)(53546011)(186003)(9686003)(6506007)(110136005)(316002)(71200400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z6kKjc0FvkjcwGmA1dstveIZSCl1BbEZW4SiAX7UZ0pJmpOibNUrihs1nD?=
 =?iso-8859-1?Q?i9/nMDbQ2TiSOPtP1gDIKUfTC7TqmnwhiC2VMiuGRZa/oN/LOwuwbXhR8A?=
 =?iso-8859-1?Q?4F0l5Qq+HTjuYAWccAwMrDP07CC3aKc8xguUDgoKktiMJcPMN3GrZBQc4X?=
 =?iso-8859-1?Q?/i0aMihWkMQfo4nsXeSn0k1DVBJtABpx60knlk0pUb8zkeSRtz/NWGJf0M?=
 =?iso-8859-1?Q?XPEXMoHNLrZnfTiEZCgtSyeosPuNBd1mFrtlOb+Aqd4lk773/0hqjNFIfB?=
 =?iso-8859-1?Q?YdOFLDKVe99edRb/kRb6Hb9JuNwYzCIchSC3HPN/1xwZgwwAFOllFk7jhP?=
 =?iso-8859-1?Q?PvdgWGzvLgrivLtLbi60eeYSRHOLbXYtgtzkr114srJv+aIeenjlJX5WDN?=
 =?iso-8859-1?Q?wswa4hYuRgUdWZMvoenPPV5ZWdEZ1Y0MEEIkTRw+HFUSfnO2fCgnS+9kQR?=
 =?iso-8859-1?Q?58bK4vrtQB3vFENDckkoguqiBxXusTcCh0u35180e3N0j4Fpl3/oWzL2Fg?=
 =?iso-8859-1?Q?UoaBwMyS0eF7HYmAdtPugUyNXwkmj7pJvDL64KKpFovdoKIpZX8CPUovVu?=
 =?iso-8859-1?Q?0O3lNN6//p+rVDaLSpx3VN4oJ2rWb7II8wdXIKZOQN8RNL+3T/OqYTzG9i?=
 =?iso-8859-1?Q?BLhpWncOwJOya4gn67ZeXxpluuixAoAHUy01OQXLEtHiTHvxzXzBCRtsKF?=
 =?iso-8859-1?Q?GprcTVR3o3WTkBElHEFVWvhA80t33xh1KfWocMfsLuWOgBigMglVDrYV4W?=
 =?iso-8859-1?Q?OJ50d7Sdcch79kn40yhtSLxSm5mKVSw/56CYG2JuC+M5MOy3l+0fYNYAOo?=
 =?iso-8859-1?Q?glLPeCE9HOY9TgZXbIZt6nao0IRhciMcm7Wh79RUdnSgoyRENn2G3v4v8V?=
 =?iso-8859-1?Q?juybyZNMWBP4nmbehjg9g2/N/v8YwjdmmmC3jQwAA04u6zqT9rrWYlgWKk?=
 =?iso-8859-1?Q?D4ADQR5RFf5utslITNfwt+Ddos2CFSB2xEuWfZs6EyRTqu0KZ0efd89Xku?=
 =?iso-8859-1?Q?AR1UZAlk9COUmMIYKg7wNRsViAOYuhAE1Ou92KKB0XLNqWT7j6Kzw55MGG?=
 =?iso-8859-1?Q?FpuBxvSyn0TwlFrHNjfdjU1CEh0Fh4qD2iixR0uPMkqS7qXO3SYwr1BMch?=
 =?iso-8859-1?Q?x61BzvlUUvRzVNjeUA+6QASMh/yHGI7K7rY282FSg9sZhm68AcWdcR8+y9?=
 =?iso-8859-1?Q?vNoOzae4qOKxFn2PLD4Qth/cpLwHNWBMi5sHdgjlfM9p4BhTUEl6FvRJI0?=
 =?iso-8859-1?Q?UkmSByVPAxOGVNWfUDyl0jlIotQuVNHYWWErCtf2Bzay67fwnTVfWVf2AZ?=
 =?iso-8859-1?Q?bCRXRw2b10NTsiYBj0YOgB8r0caSv3aW6SykDVkZoudfYWCT7xwdHUGkDi?=
 =?iso-8859-1?Q?GCfCung1PnAO4OOoPYbZuq2mGT/cme7WZ2hZjOR1xBP/70B7R90D00Xoic?=
 =?iso-8859-1?Q?Pu0NrxUnaZAsy0InBCOPzsXC1aDMskHfYzCTcGSBcFFGUzdtsDFvjPDmcG?=
 =?iso-8859-1?Q?g0WGNaOC3IFfvqBMxbDayTQmcyyctGw9e2D2XZjB81Ed+L1Flgs4nvBwTp?=
 =?iso-8859-1?Q?C0WSXIKv3tW9XnXew+UHMg3Oxf93XULFcxkimrVKHtPxh8eQy/SmaCaNTP?=
 =?iso-8859-1?Q?Pu9K7XOOKEuVt4FZjTHplUA560aHeqZCfMA2NS7VuxwRuDXZHRCyzFoExK?=
 =?iso-8859-1?Q?5PUpxAAcfg53xCI0COg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB3547393735ECEDB4B86926A9F7C89DM6PR12MB3547namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eed03c7-bbb1-4cce-e094-08dafd9b06cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 23:39:10.1766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqzL8YcEDZ2NKMlLSZEiRM9WLLaaBVdI8PogAqaNYOkPQzuuWCoQhH4QlXKh8CkkWULDgD+4F2c6r2WMcbQxNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143
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

--_000_DM6PR12MB3547393735ECEDB4B86926A9F7C89DM6PR12MB3547namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks I'll apply it upon the morrow
________________________________
From: Newton, Jeremy <Jeremy.Newton@amd.com>
Sent: Monday, January 23, 2023 18:04
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: Fix for UMR on newer C++


[AMD Official Use Only - General]


I noticed this today; it's required to explicitly include "<string>" in new=
er GCC's, which I think has to do with newer C++ standards.

None the less, see the attached patch.

--_000_DM6PR12MB3547393735ECEDB4B86926A9F7C89DM6PR12MB3547namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
Thanks I'll apply it upon the morrow&nbsp;
<div style=3D"font-family: inherit; font-size: inherit; color: rgb(0, 0, 0)=
;"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Newton, Jeremy &lt;Je=
remy.Newton@amd.com&gt;<br>
<b>Sent:</b> Monday, January 23, 2023 18:04<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;<br>
<b>Subject:</b> Fix for UMR on newer C++</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0000FF=
; margin:5pt">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"x_elementToProof"><span class=3D"x_elementToProof" style=3D"f=
ont-family:Calibri,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(0,=
0,0); background-color:rgb(255,255,255)">
<p class=3D"x_FluidPluginCopy x_ContentPasted0 x_elementToProof">I noticed =
this today; it's required to explicitly include &quot;&lt;string&gt;&quot; =
in newer GCC's, which I think has to do with newer C++ standards.</p>
<p class=3D"x_FluidPluginCopy x_ContentPasted0">None the less, see the atta=
ched patch.</p>
</span></div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB3547393735ECEDB4B86926A9F7C89DM6PR12MB3547namp_--
