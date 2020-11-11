Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558EDC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 16:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AA82072C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 16:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UQeDZp4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AA82072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9BB6E038;
	Wed, 11 Nov 2020 16:40:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01EE96E038
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 16:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI1XDLtzDHIjVmhLn7RDL1J7QwRj2Y5VJpTU5zMttHSyFtuHLpgXjTBjhJLkModm6pTNcGllqRDjueQWsiCVo8Pf5qpu9Y4ZstkPlq5YnGHZUOFTyjNxYABWWGTfEmdwQwIjfiVleCdik+f3qVYzcCa6rSERnrGVnf4OJYSzjLp+n1RVspLsPDaB/X8lTi5YYsCxVXg0rYUTYltsVoZpzA8PUmphx/ec1VqE6is5tdWfVG+fsrvD9hSf04Ee1mV9h344kN8BV7GwY061PMt5xrawkamHcDIcYAW8GM0aoOTf6jfQmdDFhetRKtt3Kh6QdGcTK9lj90oKqgMaYdkGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+T5BZnqIsfpZhASuZlveS3dEACTM330baLZ22svdKQ=;
 b=lXSq4CGFDJPQIgzXWSz45+oS7ERA3DgzlP2JLDxTFkeIzyb9ynhOBMTsdFeyLM60t4ou+0AwMZyFdEHpNuQasK4/Ev/6IXERHvxuxVrfAXSjhYKusDB8XchxpylZFZF/THMsQU/U14bUHxaEIHosXVb+F4IZ5KD3K2CQKQhnq1tmWfdnk4Z9mCKd4ShVTolTL3pzlz5vupcwga0O8bTZhtz8HCxiLl+tqqc/zg4+avrgWoSUQzJyzbO3qLDEf+vVssAsYbLohyVw6KVbCs3Q9FeTA4AZa1kh4afl5Kk5qFY5t1mVQPgnTN/nh5JXnRbUK4qbv7SYuxBXGEEHVO6/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+T5BZnqIsfpZhASuZlveS3dEACTM330baLZ22svdKQ=;
 b=UQeDZp4QIncp3wb/Iy+ZmFRPnNrs+fXKxVKVhGRyLw1GydM3hiwMR3qCqg54IQK84dhNzDAQbFB7vb6FMTasWsKnp9g4ErfYBcyBeyOQU3DRrzOE9WMyzqC2I0/7jXH9cbRi3BhFd4JaG4+pkLLXo8kWo6yxz7gq5I9X+mvjtM8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2563.namprd12.prod.outlook.com (2603:10b6:207:4b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 16:40:13 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 16:40:13 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add UMC to ip discovery map
Thread-Topic: [PATCH] drm/amdgpu: add UMC to ip discovery map
Thread-Index: Ada4CAgug+1uArCgTMS+gFznKiJcWgAQR9Jt
Date: Wed, 11 Nov 2020 16:40:13 +0000
Message-ID: <MN2PR12MB448803A8380D6AD20EAC345DF7E80@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <MN2PR12MB403229B5319EAC6A7B8594F0FBE80@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB403229B5319EAC6A7B8594F0FBE80@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-11T16:40:12.420Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f3c6983-ba4c-4183-6f2d-08d886607641
x-ms-traffictypediagnostic: BL0PR12MB2563:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB256390601FA096250B81AA20F7E80@BL0PR12MB2563.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9bBlFwpJfHKwi8nRrrk4Lg1RLR4ONG8tsD31oVhQBmpo+0oKZoRDcV8VqsTYHrfI9VFp4Lzb8FkcvAQjv6ZO4C1DPN0AXaJx4KuglDoPHIr/C5MbB1WVe7KY5Iv+y0d+0pOvTuNkXOP/bfICePjeoogLOzprIEqyCkxtPI6rD7mmXkE5D9Y8BxYAn3XXM8noe3ZbE8cssnF1ilTCIdGwXcIjoY/E4VPFJ9fOd53kF+gyKfh9RhtiNux8PhCVqYy8d3I+BlkfebSv+pENBbHKDIPppUjaISiZt7NZ1vk7I2kvvQ70204lRfmqExzwmjbt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(2906002)(83380400001)(6506007)(19627405001)(52536014)(76116006)(19627235002)(66476007)(110136005)(478600001)(66946007)(33656002)(26005)(71200400001)(8936002)(6636002)(55016002)(66556008)(5660300002)(4744005)(53546011)(7696005)(86362001)(8676002)(66446008)(316002)(64756008)(186003)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: U4Nob2d46HjGIJmHJow4JLhN2gng07wHVtj78pMSRRHxbLnpB43FuQ/WIgdKNm8wgjLqXLToISii9uZAeYLe6CLFBW+qbto57X4NB8GlZAD5fbbWHOZNgq8YX+Z8rsoksiC9jrdQ9ni9//deTIMcgMPldRdoeh6SrC2VUzqHK37tKC6H3fpfsu3WnmE5jFCSDyHi8KfmRXrSeUZvxs7BGOkQCpPvTXaB7pBAeKja0HKlxn4J0htTYB0LcR3oTi2zi/f1BBC50j5Sj6hu+H7Dmirc02LMqKyIUdHL3Dkf0Ve8ZJfxclxjV68MyCLD9AVzmYl4PlmZnTHBp5K3zxl2lXguvje4bJ0kAa6+llSVmcU9xgpvc+RAoEqR9FnNss7uquIwYq5B6+un9Qk5H02RK3wv87Eg9DulqC9I2wFpDMV83v3WKIeEUqtD8klmoEZVjI0XS9UMA2XAENnXHGwfb4CZL+MxJse7KF+Gj1nOZHc8tZJW+0+ZTy8NMyf53YPKXHwq6N+h0avw7+vpgMjHlgOMkmOHvr3IbbcGb0lMSpIs72iwO8OjgyRYkFIbbWPyp39h02+qdr12OQsA9c8rzSqpSQKQ9eV/zPXROZPfKCgXVOZqrd0Ed9oLLUgU1HdKLNHFm9MF/9z5qU4IezhL6+7KWXTkIQoAWpKC3bqH8JTm/rzsIe1YB4FIsj8RQaahWZl2NiK0sr3wk0FAtDTSWjA26ksjh1w9uWxCRsGxNaDU70qSPdd89XM07K14j6z+/v8mbbYqOUfGiwL3oRuidbqDZD5X+xblGy2V9De0zXLjeygsm6pqYyyQSMFDF1KqKod24Wkd1CVFIIRLvrHsAhI2co0120SVh8rJucLtup850bGHVnro0TmHotYmZ76SZKRsn+Whd4TwjoxvXNIG3Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3c6983-ba4c-4183-6f2d-08d886607641
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 16:40:13.1499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBYEa1vQD8pOLeM/S9QOFGNY5laTGyjqSo5q42Q3Q49Q9rLtg2XTkQhqKiXUXUI6Fa7ocripAMgpID24MkneZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2563
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
Content-Type: multipart/mixed; boundary="===============0459070269=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0459070269==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448803A8380D6AD20EAC345DF7E80MN2PR12MB4488namp_"

--_000_MN2PR12MB448803A8380D6AD20EAC345DF7E80MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Are there any other IP mappings that are missing?  Maybe just add them all =
to avoid problems if there are other IPs we need to access in the future.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Clements=
, John <John.Clements@amd.com>
Sent: Wednesday, November 11, 2020 3:53 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhang, H=
awking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add UMC to ip discovery map


[AMD Official Use Only - Internal Distribution Only]


Submitting patch to add UMC into IP discovery mapping.



Thank you,

John Clements

--_000_MN2PR12MB448803A8380D6AD20EAC345DF7E80MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Are there any other IP mappings that are missing?&nbsp; Maybe just add them=
 all to avoid problems if there are other IPs we need to access in the futu=
re.</div>
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
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Clements, John &lt;John.Cleme=
nts@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 11, 2020 3:53 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add UMC to ip discovery map</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle17
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-family:"Calibri",sans-serif}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:b=
reak-word">
<p class=3D"x_msipheadera92f4c5c" align=3D"Left" style=3D"margin:0"><span s=
tyle=3D"font-size:11.0pt; font-family:Arial; color:#0078D7">[AMD Official U=
se Only - Internal Distribution Only]</span></p>
<br>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">Submitting patch to add UMC into IP discovery mapp=
ing.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Thank you,</p>
<p class=3D"x_MsoNormal">John Clements</p>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB448803A8380D6AD20EAC345DF7E80MN2PR12MB4488namp_--

--===============0459070269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0459070269==--
