Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B738EB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 13:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A702610E688;
	Fri, 21 Jul 2023 13:33:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D578510E688
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 13:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nT40yUYBqm9uHfjiPHyu9or1SKRbf/rWqUVzR0dTdqgkLOyioRLr6epIt4DV9Ru4FVNJjC6P0ZgC/RmagouHm69SbaXEUN6VyK9kzxBK2KeDqggelbeisPcd9sd5sssrnolVAc+ozocoNmPYnUN0r5HF/nsa5wUTgtgxoYrp8Y82hea2rdQ0jQKaJARvFQANZGRBOaJqNYB84vvCVL1mJJfjClA3/qj0Jwu+xblTdsPlK1Z9Ux0gkFHMHbwqtUevaB2vTAYmwrYCt0x/s2MZjGiGHuTN80hr2r+ZafaGRBGeD32lsStdkg1BQUgwC7k5YL08zOGb10F2PzaFLQaLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW8paghTZOqK4X0zJiNJ9SCfa4q92hdhi4WG+swz5OU=;
 b=Wc6YF5aOYr9EffnhMSVBsdSXPcvdroxl9GSEaORRwFBeikWwyvYtp9XOs8UVLh43USZZOEdBQSVZZCy5tYpYg+pJwp8/67owBcQje/1j5fD1HFWCHnV+UCWc1nnmETejhBGMvxLmlvAilG0M3bORc/3/HybIOoHbgI7izeNiLtvhbTQt5tYGavWJMXGpcWvTqbQJ8lEIHHlWgGQmYl6wz8HFxYDg4b/X7KOZuddt7g8LPv5J2C2UgPvmYPImxwTAbOcH6GhQvyNxSiOPPRh/4x+mRMtD/SmS3Wa5pgkNygYFsYRwrwzFN0wzjCrxpNKN/p1oitDrMsROQgQNhYyUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW8paghTZOqK4X0zJiNJ9SCfa4q92hdhi4WG+swz5OU=;
 b=O7zRmiVNwrLH8YveSQtfKV+ODIivPz/sLZLNwxIlbVRhkaP+MUdG/9NACCFK/tcwkej00dTGrFVKDZD4OtHqG9i3nHHbLMV7s5aQbveyjUr3dFPeGD1F9T87ozOT1sA53ZmCcdZnS6/B8h7F7dLiIPJM0SRQaarTfzWIIUln+aQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 13:33:02 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905%5]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 13:33:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Matthew Hall <mhall@mhcomputing.net>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: AMDGPU crash - request for assistance triaging / reporting
Thread-Topic: AMDGPU crash - request for assistance triaging / reporting
Thread-Index: AQHZu4Wi/bYdeAmQD0qCdkX1AnkmAa/EN6Rm
Date: Fri, 21 Jul 2023 13:33:02 +0000
Message-ID: <BL1PR12MB514416A3C79BA1E6F43FEF83F73FA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230721034359.GA1133@mhcomputing.net>
In-Reply-To: <20230721034359.GA1133@mhcomputing.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-21T13:33:01.717Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SN7PR12MB7980:EE_
x-ms-office365-filtering-correlation-id: 5f9da816-1867-4260-b9d6-08db89ef01ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y8U5bHyXhncAayBp8KS06KJ3w0tVCxvbsS/y7bM5rTEfDc4FHuYzpp4E+CTvGaIHla/XzKv4K2GlZb5fR0zZPMgV8fIfOTfVIWCGDApNw8u2E3oKV1x2LB5Kdo71FrICPQUCF4nLS8QNJkspMSM9RXXHXmH0efKkSvH6lntbtOmrET5Z1nsOYKJs93HLzrvPFm20FSfUFG92z0rMLSsU0KZEA3VuuKVGVMJzf29ARkLYuJblvZ0CD7G1d1A3HrNeeYV35ZWh6fFD+ba9VTPSrgvnZrdKHhnjUfgyXXg0x+3kdB/GiTYklQPbipMn2Jgs4c2HQEs8QTTBC1x5qV884hutfV72KHwtuJsUBaiF781FTbfo6gIdNoZIP7B9n6niGosvC+3TL39QmEkG68pfXOvTMNNYJKoLZ7dR4mnZ0Y7edohgUJAwvp2l/9c/U2kCNU09Qo9pNqfblwCdUqOlYYqoLAL9LJH00+3uatTbhogLQkD9UHUoccAYnJOFcA5Xi0zTg4hsFeUK6ktmRdzZxY8JghiLpzW6EDZcgIhxnQnbbKGSZnzHSmI/zzUvAymmm7sEUG+PYrRhembeTdq6zQCzXWFNCKH48X7W8sqNO1c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(186003)(6506007)(26005)(33656002)(66476007)(66946007)(478600001)(76116006)(66556008)(316002)(64756008)(71200400001)(66446008)(41300700001)(19627405001)(53546011)(7696005)(86362001)(52536014)(8676002)(8936002)(110136005)(9686003)(966005)(5660300002)(2906002)(83380400001)(38070700005)(55016003)(122000001)(38100700002)(166002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TwsqSf+4MwD3s6GDK9jZ3bciX2F8ZexsJgLxxDJB2saBzNeW3r1xPkqlYHhx?=
 =?us-ascii?Q?Vne9LE4uA5srTMyIUAFl+oDLhoOyIQOTqa06LA4jICrl6Dxl4x/FCTP4YnV4?=
 =?us-ascii?Q?097Gz8yGnNqONxwU1DNkb7DLoWhFik46ZO1f6c5MZ70+o2YUKvcFH3zCxv5C?=
 =?us-ascii?Q?yqhauRqkqrvfQE4WWaBZPLXOm1WMYVhXyw8zUoA80MOGOa1eVD+7yYgVMDzl?=
 =?us-ascii?Q?8jj6j+d362wyDEKqcRhQERaEmryBZG/2pYN0cPAC0jkBhIvgNEKnUit1e/SX?=
 =?us-ascii?Q?JxdvqK41Ggxh9n3CYP5zlEMLInYboPwY/Q2C7TohLF6inVtB9Zq/yTNwdVGK?=
 =?us-ascii?Q?5HQCp09jrbn6a8hQvfnKdcej7+y+pVxMGyqfYTho+ae8rRLDg7cs/QKZYeBR?=
 =?us-ascii?Q?2yq2glXcJO099aQItPKhYdhhSY1CVbqeYTcH9OC3xOmChlnf2AXkUrrA7XU1?=
 =?us-ascii?Q?dhpkrDThUg9/yd+tXcvGqksFA+XOyBj84hbFAFvO7LBx/2eaSuxHWvNz6Iz6?=
 =?us-ascii?Q?ugKBJ/sZAAXABOQZi8ljsyeASno28VsB92FEDG68f8QO0YLjXtVHykai8Odc?=
 =?us-ascii?Q?DWtqcR0fFUwP0Rh369LuMopmEfx9c7sfmhKts5RF9zjsg06IMqCbofHBV8tS?=
 =?us-ascii?Q?BwPppvYYCROz2CQTL9Hh9K6PniW0Xupa6igXyylLMKxDOmg0ntAI69OVB/wc?=
 =?us-ascii?Q?4lFfkg/K1cn5zspQgLIEOjT+5TMpt3abDJr4amA5tNxZDVgQXguRpBJXhIZL?=
 =?us-ascii?Q?Mf08pw3l/8bN7pSFnJ3sqgIlfo3Fy5J+cKRtdL+agZnm+4Giyu0vqBitYxtx?=
 =?us-ascii?Q?r4jZienogxo7fDmpI57e+7si/+2hcksau5Rra+qH6Oi2vxkJLSzW6MS6krFi?=
 =?us-ascii?Q?YROMOrpBR8aAJYu2iVIg96p1h19NDfQ/fE6rDOCokA4qJwaJn1D9rgZHw6L/?=
 =?us-ascii?Q?jkSMHXs5JmaZKm2+FLerDrojXxxzzohEWoF7y1wkSMD3Q1Knkc2rxu3acGaz?=
 =?us-ascii?Q?HgrVS1UMNumcgK7OruKnB1nuvDD9HUg3rRAGqhW8hVzZJtOP1GQ4cCI1c1y6?=
 =?us-ascii?Q?qeJHryskf9tOLbotD59LpCJbm2qjp9KRtALb5+lHJVMF051dOJBhe/isD0hQ?=
 =?us-ascii?Q?6X2v2hpFAjMNJohpsnEJMjk7rDDS3sp6SifMfDLVDa8O2zFCu1SdFfvEUvq2?=
 =?us-ascii?Q?HjghrmsoqnfyscDVUYwHKVNdGC1rT73qYdXz7BoPmMlltKhU5SiAH3/mUM+m?=
 =?us-ascii?Q?2YCcF5xl7DvF/gCwf++7JAsGutm96iyzGM5OGKDkpRqsxBl2/IgcFKN8+aLM?=
 =?us-ascii?Q?Rz/9a3ykCoh/yAoFTjwOZj9KcdM6LysKEOwX8UCxlwrwW6uvCQF1Yk4bDWCy?=
 =?us-ascii?Q?/i7cTwrvSmEGPRZR9y+GafqO9gdIDzT1MwsvSOek84vpVZyVdr5RnULiecdl?=
 =?us-ascii?Q?B0/+B7aPfiK7GAt46/34TEtQw1pKMUSZ3t2E09HcCkLMB6XWbM8GKKxjkv/b?=
 =?us-ascii?Q?wNtu/rfG/6pgIk5DlxcQ/QP+t/NP7N4x5pqOZ+AfsZALLkZYspV4yRKBXCED?=
 =?us-ascii?Q?8Hh3O7DBbJ9VKpsF5mk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514416A3C79BA1E6F43FEF83F73FABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9da816-1867-4260-b9d6-08db89ef01ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 13:33:02.5171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycXkLJSlNiLx0tJkgc3zcdI6ETUJT+oae/eQJb2lhAhthewCAn52v1cIJlblBbp892+hBGYg0qqNobMQ9xVXTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980
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

--_000_BL1PR12MB514416A3C79BA1E6F43FEF83F73FABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Please file a bug here:
https://gitlab.freedesktop.org/drm/amd/-/issues
and we'll take a look.  I believe  the Z16 was certified on ubuntu, so you =
should have a good experience with the latest ubuntu LTS with the OEM kerne=
l package.  One issue we've run into is with the PSR TCON controller on som=
e models.  Disabling PSR in the driver can work around that.  A newer kerne=
l also fixes the issue.

Thanks!

Alex

________________________________
From: Matthew Hall <mhall@mhcomputing.net>
Sent: Thursday, July 20, 2023 11:43 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.free=
desktop.org <amd-gfx@lists.freedesktop.org>
Subject: AMDGPU crash - request for assistance triaging / reporting

Hello,

I see you are listed in the MAINTAINERS for Radeon / AMDGPU.

I would greatly appreciate your advice in the best route to a triage and fi=
x for the following:

https://bugzilla.kernel.org/show_bug.cgi?id=3D217690

It makes it difficult to have a consistently stable Lenovo ThinkPad Z16 whi=
ch I think is one of the best available AMD & Radeon laptops out today, and=
 listed as supporting Linux officially.

I have about 30 years of programming experience, though none of it was on G=
PUs, so please let me know what I might be able to do in order to help figu=
re this out.

Sincerely,
Matthew Hall

--_000_BL1PR12MB514416A3C79BA1E6F43FEF83F73FABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Please file a bug here:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues" id=3D"LPlnk5577=
40">https://gitlab.freedesktop.org/drm/amd/-/issues</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
and we'll take a look.&nbsp; I believe&nbsp; the Z16 was certified on ubunt=
u, so you should have a good experience with the latest ubuntu LTS with the=
 OEM kernel package.&nbsp; One issue we've run into is with the PSR TCON co=
ntroller on some models.&nbsp; Disabling PSR in the
 driver can work around that.&nbsp; A newer kernel also fixes the issue.<br=
>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
Thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Matthew Hall &lt;mhal=
l@mhcomputing.net&gt;<br>
<b>Sent:</b> Thursday, July 20, 2023 11:43 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.co=
m&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<=
br>
<b>Subject:</b> AMDGPU crash - request for assistance triaging / reporting<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hello,<br>
<br>
I see you are listed in the MAINTAINERS for Radeon / AMDGPU.<br>
<br>
I would greatly appreciate your advice in the best route to a triage and fi=
x for the following:<br>
<br>
<a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D217690">https://bu=
gzilla.kernel.org/show_bug.cgi?id=3D217690</a><br>
<br>
It makes it difficult to have a consistently stable Lenovo ThinkPad Z16 whi=
ch I think is one of the best available AMD &amp; Radeon laptops out today,=
 and listed as supporting Linux officially.<br>
<br>
I have about 30 years of programming experience, though none of it was on G=
PUs, so please let me know what I might be able to do in order to help figu=
re this out.<br>
<br>
Sincerely,<br>
Matthew Hall<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514416A3C79BA1E6F43FEF83F73FABL1PR12MB5144namp_--
