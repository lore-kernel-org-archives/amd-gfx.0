Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41715C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 13:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F8410E181;
	Thu, 27 Jan 2022 13:39:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6798910E181
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 13:39:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VB8CwizfVJXgiXCf/SU8QbUmMvsO2xrPaHCOskVopNY73mClwyHhyrmXjXJeoHILEk3Sqd9QuJaSo/0TVIPYN+grWv9CzY6rPAIJA99rBbc0KwPITPADFDwrejH0x4xCWeI2yNmkUP3WQpiFbTPbTmGDOe0kTqsTZtgeJr4Vyzn+2K6at+x8vHhmo4MFN/MYCS2VJ5R4hShROl8grt3AOgNivN4VAwPg/m9I3PxUsjw78tURbMG0+XwRCspU1psw4oYsFS/Pxn/4mAfw+G1wkphb80mZv995ysF/fDcdeVP6jYmawZQs/3U+QbanHJm6DVIYsBt2CHOLVHSqaIFd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8evKKd6g7e6MWpRC+oFFTBrp0xECaSDFRK5gktDdXw=;
 b=jjfA6+C911GamlR8oxIeARCJd9U4FKdWaXF218jMzvEuAbLu5zxDaVbuYps9jteo8ZxKCP5iOGZKnGL/zxvAxk5ELDDbD4niuKd+LsPA2w/nwlOfUnt8+MkR3Z2FgAjFhfaSIc+kU3C53lhTdnM79dAMctJ9y3nSpPDsytC15eGy2o4N1z52x1oasCgw5/8wJQz6NUViPgZjCMErzkO3pjvj5IZsd6tTxDUQYvV2LKotpDnowWvmgxq1+rfZzD/iLHksN4uqTEn2HYW10/bPYajdWscyocho4Ah8qr0/RDn7T4Op/kduE5014FhZxpt2bGGOuV89iUTLdSANaOygqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8evKKd6g7e6MWpRC+oFFTBrp0xECaSDFRK5gktDdXw=;
 b=a+sNUB2fsLy/ZlTOy3Iv0kP2Rl6zBqC+k8TWF10KulRoafYMT4i97Yj1NSTqc3mGKH80nOPgr5V9Jlmp0wGj1Pgnl05diwcKTMtUI5AkJM0owKzmB0dDduX8BiHh45/UPB0ixIo+rT9fCge7PKmd2nKzZP/8n+iUp8YFsW9GG9Q=
Received: from DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) by
 BL0PR12MB2403.namprd12.prod.outlook.com (2603:10b6:207:40::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.17; Thu, 27 Jan 2022 13:39:04 +0000
Received: from DM8PR12MB5414.namprd12.prod.outlook.com
 ([fe80::f012:bd92:416b:a423]) by DM8PR12MB5414.namprd12.prod.outlook.com
 ([fe80::f012:bd92:416b:a423%8]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 13:39:04 +0000
From: "Newton, Jeremy" <Jeremy.Newton@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: FIx for UMR arm build
Thread-Topic: FIx for UMR arm build
Thread-Index: AQHYEtkhGgvqGfCQbkqox484qGU4iw==
Date: Thu, 27 Jan 2022 13:39:04 +0000
Message-ID: <DM8PR12MB54148E41D5C03634DDAC738FF6209@DM8PR12MB5414.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-27T13:39:04.027Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3d64612-699b-43b6-4e1d-08d9e19a62a4
x-ms-traffictypediagnostic: BL0PR12MB2403:EE_
x-microsoft-antispam-prvs: <BL0PR12MB240348A04931227F94431DD3F6219@BL0PR12MB2403.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5MyGnSSKuwV4W8hWr1i7g+Vi7DvdfRr35vx9R4Rs3l7MTUheLKh9TpMxXWpiMb90DfV8n3VFadR26c4u+NXoO4CPmm+WPRR/0RQ/8WkSd9k3vxNTqPIKKCoo0xoboZTXhTIwoUGs2YYrV9RIU8Cw/AIGZP/C8tZZ3hAo8JTT+HXPNczf+4n50s/96hUIRKsMSqWH2fCqckuu232bITvSi5Slt/vJOUjk1K2p5saVjlEg9o88Qwu4MSC8j69ScloDE4e8wzVvpOoCazEgOz2wvlcOwuhz4R3bhQPlJJYQbBJ+BxPP4Nd7SFS9mphf9Us3ICMP4ACWNY10OIKY9eGV/GdIcO2fsBrdEYLblr3ONlmGQxjzETFl529DRSw4/ZwBhe8v9SQ+5qUXskbMXANz0gD65nCvPrD1MGhBrcHVMino1u8lB92COEKZIfRapA8xbxahJVkhe3DsQJR6FkAfxPVQUHoHxJFZYFIbiCbAtIWZxRCEhnBBXHSn5xx2WI9AhSWwFbfiekHMjPNggf2VtJa4oOnLccPQLVvRZDd35puuL692nmC4l+CxMkAKJ2gAb7eB+KgPTZqdXvQ68UNtEOjS4/FjpOSXFlhnzHqRFIOjurztoP7Tr1rlb+5ipPOD6LTenER0AE2IoPwph+t7gJ9GMVolpTpK6aZLqi2den/x5E2RSK+7VAOoFnUPGRYs7uuA6A9iJ6T0HeKZ+DdRvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(558084003)(66476007)(4326008)(26005)(64756008)(8936002)(8676002)(66446008)(186003)(38070700005)(6916009)(122000001)(66556008)(86362001)(38100700002)(33656002)(9686003)(91956017)(52536014)(66946007)(76116006)(2906002)(55016003)(19627405001)(71200400001)(508600001)(5660300002)(6506007)(7696005)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IH9SsAUQgjdCanFCXQaa+xtZ0vqZj3scrB2NVt1PGclK3mYdZcXrkGZbmR?=
 =?iso-8859-1?Q?EXNAt5uR7cZeQnRAnv9m2bj1mFpm320CgrlTHksiNdf1g5tsSFQVDAPaBH?=
 =?iso-8859-1?Q?63Aja5p+9Th0DQsHYu9deImmVDYc+5L/Tl5TkQ8qABZOggCjy0ZscX+Rdz?=
 =?iso-8859-1?Q?X0XHMFu1DuEhlF0WzTMSljjgeEDFPbNtF61mbsMQr6Jw0Z6PCrKmtHl2Fs?=
 =?iso-8859-1?Q?O3vrmXt4kLZ2bljV51Q2/nckxNFPtN+enhUE+lVV98HBJIdOj1s712iSlm?=
 =?iso-8859-1?Q?VaXXLB9su8Rhl8Hn0yo8gMUZ0V4/D/uDWk7qAAUimazdkXDFwd6PpqIdXs?=
 =?iso-8859-1?Q?oJsxweKqJ1V5gHwTT98Q+eJQFPqhWs5eTrL9DW3YgGDmrVAgydRUxxncWB?=
 =?iso-8859-1?Q?KpsjRnr6hrS/LfB7UqCpUK/YN8D6xqz6AJRpYjrv4l2tQlUA3d3cQ/D8yK?=
 =?iso-8859-1?Q?/mVRzXtYO/UxUde/d670oK9cRi8JeSAkYQy7wP5AagNbiPaTHHS8sUnhWm?=
 =?iso-8859-1?Q?5Lv5nlUjojkrHeJD8RgKj7hMY5RgI4k8L8vcHNfBcUneYgSxEMH8J0quD1?=
 =?iso-8859-1?Q?/ukViF4Is7Br/JhLG+e9/bQtXpjaZV05wQxWxrK4X0DTqkcsm2X9Bf1KqD?=
 =?iso-8859-1?Q?9jwijzjf5WjpsZHXQAbZn5h/kJkSFJburntfM22vSk82zIJfIBubX3LnSf?=
 =?iso-8859-1?Q?BxnQZ2oE4tPBzvGOId36i6C3XbDvYFumVqAfwa5gs1iIcxriyEerZLZjQx?=
 =?iso-8859-1?Q?dALvEfJxGEx+bhlTwZi1jP16jbPBw0Kv4Lr1bAbwFfLr4wgf+YYnnzO97a?=
 =?iso-8859-1?Q?8/mM6I5qU8aCMWzqZ0+wQzMwn0337rwAZ2TaphonQfNCkpF1Y8kMaPKPbX?=
 =?iso-8859-1?Q?Db0/uyfClwcs2C2hYCfyTeTTEtdNvOyL4xDUXsIyqllKZyeDub1u3C1MRx?=
 =?iso-8859-1?Q?cuYLqnUVYF7A/eVHnYrxDCpXO/mewdSyO7xaX1UVJsFzd+FmNqxNfl9Lc+?=
 =?iso-8859-1?Q?h9HEAlwEURJZvOBeoFLJnQ6nzIyt5bs1TbMQcZhAfkLOC3hi05ktoKBaoy?=
 =?iso-8859-1?Q?b3RMMYzAGwj7Aa8YIMANwfB/ys20Ei5Soe4PHm7OkXQl6Tc8QFUX1sR0vr?=
 =?iso-8859-1?Q?03Gq7pGN+qSOM7DfzqI7qeGiCLvNoASqmy81iMxL+cYfoiPy5/Yv+/CSrG?=
 =?iso-8859-1?Q?CnhBy5m5QqvLHlxdJbEiQjlHqYqjHvDWwf+pbKUEGzrdjkeB6VHIZDrPMD?=
 =?iso-8859-1?Q?XkSDAss//g9eiw9bHnHPpZ5l0qmMJx7dGzrsHydt6RvnuHBvyyJ8kLgWOF?=
 =?iso-8859-1?Q?3N8vnn+HMBn7GU2RDBUxyPG9PQg86D6ljYPuYORievhowVxglKTbn+c7Hd?=
 =?iso-8859-1?Q?9RSsVKEBwB0SIVukT2VqA7/VE2fX/B5f2ckDuGmTO9IuW83JwtOa9KGvr6?=
 =?iso-8859-1?Q?5lVYlQrSpfS6+4cJBQ69MuTWn4d+I2cI+56Ej1c5jCk9bNZQk7MwKrf6t6?=
 =?iso-8859-1?Q?WKiVQVv5/uMI5d7t48uq/UmzsODiUTNFf8YPfxY2ciLYTGcxUL8YukKfk5?=
 =?iso-8859-1?Q?uJmmavCrIDyEGo4n43SMXEgjNsKd27MdYaP5lwfFlQUAF3/Oeg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR12MB54148E41D5C03634DDAC738FF6209DM8PR12MB5414namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d64612-699b-43b6-4e1d-08d9e19a62a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 13:39:04.4534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcmqEX5XWHUG1pj7wvCE4aCWQw5NqjkUM/y57nxX0ckKKvCOy5ftFKIbbkdPSNfm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2403
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM8PR12MB54148E41D5C03634DDAC738FF6209DM8PR12MB5414namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

I know we only technically only care about x86, but this just fixes a synta=
x issue if you build on arm.

--_000_DM8PR12MB54148E41D5C03634DDAC738FF6209DM8PR12MB5414namp_
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
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I know we only technically only care about x86, but this just fixes a synta=
x issue if you build on arm.</div>
</div>
</body>
</html>

--_000_DM8PR12MB54148E41D5C03634DDAC738FF6209DM8PR12MB5414namp_--
