Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B24C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 15:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A17810E6A2;
	Tue, 11 Jan 2022 15:28:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5540D10E6A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 15:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQXQl0DaiH8xe7gnx4rEfKAZAnE6p6YSPgRrMgtQHXF+cEkuRLDX1zK5NhqBlY9bTWsetdCHyNYFecu3ul8rlpad7LzmA5WrRSI/6X1v1ELHRYCZegXbZexX3poIxTAqPzh7xRqWfT3m4/hC1lp1IpGZlsHKxjdIpT610Mm0wJjfScalCZ+0XViYaARmhMRluHoZub8XCxXm/JPoOCm0qyo1Kt65Su5rS+89RCe1ttEGO2b7hLph3zK+Q0PALjXGg5e51F8kNFP8hV7ba581HL+sFukjBIbyWfuaoq4lQf4Y3OLR8u8MDDkmIlbiRdReHD6xzXT8YSyXOeL46KPVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgNHmB4nPaOacciF9WCl6456Zdps8WgZXsaGp7nwK+I=;
 b=bRBMc3qQqlRjIKFbbQwYqnMvqikkxyr4iydSL9BUvIaELsCETqCdvLG22xmB5CIQuxJyUpDtTYIKZJ0RqSebbv3isIfksmvJPTkwHJtXo35LYew5aWAALkaOYFbJlzHRI6XMlnde1Cx4KC+qY91dDEddGZCGmEE2y0DEIZKGloAz1FmttZ66ZnNXRiuU/UUxfhMeWwY5ekXO9tcyAIppwPG7loBFQ3QmM1hyyekYI9chgxtlnhEqx4bVKfb1sI3WtLhsBV9lqdGvVZjjKF3hZgtgYu8Agnt+jZMQboYWeLKV/FyJi7Gb+C5adQaXminjxfSkmYb4vglLiV4jC/ERvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgNHmB4nPaOacciF9WCl6456Zdps8WgZXsaGp7nwK+I=;
 b=StPdF9hCVJA5suskVp7UGdqmuDNnnisR8ygr9DR/inBbnZg3OPpbw2ANriwiWSj/ARxoY7gcL905DNi/gGovg6q2d7JxZzrhBMMBrE4pgEKKRbDd/pJ6ozniuaT6ekC2ILtv1rHO9Qk6WCPeZmOwupdPzonFJGRjoY96W8EOh0s=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 15:28:44 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 15:28:44 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Enable recovery on yellow carp
Thread-Topic: [PATCH] drm/amdgpu: Enable recovery on yellow carp
Thread-Index: AQHYBv+f2UfwLOuFOEiLPdPN2yp+3qxd8cLT
Date: Tue, 11 Jan 2022 15:28:44 +0000
Message-ID: <BL1PR12MB5144AC9169710C46E316EE8DF7519@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220111152531.3761987-1-chandan.vurdigerenataraj@amd.com>
In-Reply-To: <20220111152531.3761987-1-chandan.vurdigerenataraj@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-11T15:28:43.848Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 061d73c4-7386-f742-faf7-b6c62cc511d6
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29b55d7c-ae7e-416b-b121-08d9d5170e12
x-ms-traffictypediagnostic: BL1PR12MB5109:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5109A8DF93401AAFDB3E563FF7519@BL1PR12MB5109.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:185;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tetOs19bnFFc9uUTR2bUL4Rca5ziACdnG2KEMtNyngEGRVekeTWzX3+0OOjQx9z3muvDU4OqAwJ+TY9RF/aZ8d9d2URcNP2BLcrbe/dIrk1QCFFrn7mTVOE24q0lybGCpT2RCqtgME5eP2cPjW+S1FY015mtCOqsUxFFijR4IEHf+gsEgBJaB63JKjptDsTyFRVkvB4x40O5DS46Ymc9uBnsW2yz/WL5IHJyUUu7pzTWTFZMrxtoJc9U107WpPLxH7g78cVm6YGx/GVyn8MWIHo9U1v1GJYy+m6QugtsyFDFKitfoM0l57pooHEnPYB4Ojx1hLOqTYnNXhoWO+Lfm/cQFx2NxN9Cbn6bfqZ1V2MgUCewl7nfXng4GIyU99h1QwoZhzI5AdtC+pTbXfcJrUiFkhjzZCV/nbpJA1ReCAFMl9UCdyQlHyrJiQrTjL/duIVqGx2usTUZaO0lDNA3V0EQ9YwwyHmUxPn8HPw6fzrqHiA20oBdU/+NAcCLQ0o7eMJtcaDEUSfgWhFCWBOhk1svGbmPaTIkdIF595ZJBz7eX2DD4xz8NvGE9GzF7L8v7aLvKCpoku4Tvf0rcxOUYLj0nZGfveJ7q/LCDdVm2iWAQS6Gg8wkarigb1S7zOKYCWLzSQJfBg1d2mfSPGy1/Bp7t4qlyXG6uwLkZ5pZyVe2t5jrt2hmLARu5wgMTnBOdT0rM2lwsu3GiOVon9hvvQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(86362001)(33656002)(38070700005)(6506007)(83380400001)(4326008)(5660300002)(66446008)(9686003)(52536014)(66556008)(66946007)(6862004)(66476007)(76116006)(64756008)(2906002)(7696005)(6636002)(8936002)(71200400001)(316002)(55016003)(38100700002)(8676002)(122000001)(186003)(26005)(508600001)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WxOuhiLlIRgUxBVfW/CWA170b17RxbZepFNVSfrtDcIwlVpRopZCDLmAEt6q?=
 =?us-ascii?Q?WVOSaapDY97tj+3KbY00x0GDw4jVmiC1TAymhykKbAaXonuL4RYEEiGJRSPy?=
 =?us-ascii?Q?g/yPNZt6JpJbhiqASngfGP+fsW7djrD84WDt51hUmFsVlHyYEHOuz91TflBe?=
 =?us-ascii?Q?HkVYcryo6EHmXYRtlVW+5sHXLKVb6wQeuUXUvm61Q90NVTzpAvvmomnXjJxB?=
 =?us-ascii?Q?fw34/sdvlMRVEHXCMXYSP8HqeTNAsZ+VFRl7DZn784WQTPal5DTDbfxPxphu?=
 =?us-ascii?Q?LHhlcryqP7s2aqjO+V2rQYK5X1zVx689fX3mAYzXZzT8a56Hbhh9/B3A0Vkc?=
 =?us-ascii?Q?5ETQAe+YJQMwAXI7BXyfTqWW7GPxzpJOt96iq+MZyzx4QjuYVKwEXP3dF4oU?=
 =?us-ascii?Q?6imgWjWhRNdQmJ5cAs887sFW8EUxViuJ18Re+6pGmxRIWtHtMah4XVoQKzcm?=
 =?us-ascii?Q?2kAEmDn3FgUowVY4QzK7a5YcStcgw6puvLtWdEiMi/9yDRMZkZ3G4PkuHVlZ?=
 =?us-ascii?Q?BdKPg01gVEe3RV6WLA5KYgAK+S0wBJCII3sxy327+++AByqbmhbA3Gg8R+7V?=
 =?us-ascii?Q?kQsAmHkF/cLqgZ6tW82fEniMunRsQgsL2tqmnoX7iXGawdpgzoORt9Lnj+Et?=
 =?us-ascii?Q?qMDTQxDjxrGq2IO1fLB00CYGss6AVN8HhbwBHj37CIMX2tPwThlcRmB6+wHs?=
 =?us-ascii?Q?Q1eZ81A8WgzVmyTVXXF0c3LDzuSXOrTBCN4njT4a09v7JYdkHsMHPH0faxjw?=
 =?us-ascii?Q?2SwxV2ltnB6rXKcq9ERHaSH7bLxGg74qIN091kZRIeUBWY+Hvtf/BsFMJ13q?=
 =?us-ascii?Q?Ei3hVSbPj8SOsGCJpYlC4uk/Q1drzPZVh0EJdHJMij+88kKfRohhkZgCQRW2?=
 =?us-ascii?Q?aXw+tCKcSrMWO19vYSsMnWde0Fro81yAbnUNB8iO2iYBsF0577OmCVL9XTCs?=
 =?us-ascii?Q?mW3K+YtPKheP02ECqayKlzy5AhFoRIECL2QfNC92q3p/3WaCwvB0bIvqg/Wf?=
 =?us-ascii?Q?50/yY68Z3DrKivGcFVj9MtO7FUHl3v5SxGFNgrL5YVyMGxi72KACXQM37xbV?=
 =?us-ascii?Q?UtzMOkadUQUSj2mmjpayCHA53Qw8DY35o28GK16lNP+s1Reqw4DMTLZZrknK?=
 =?us-ascii?Q?cw8jbeVZ4TJIfii5iYLbDCXL4MYbaU5IcWW+YMod5b/xNqkSGii7jvrJG4bS?=
 =?us-ascii?Q?vueOq83aifpAqnJ0c0UnICrqtrD7j0loZsnCoGm6DVBxAfDfmjrDa6sFOj1d?=
 =?us-ascii?Q?/yMFVDpYPCDmU8M33BGDEWZ83JEaSXGoPv0kT+4FZvHzTgYTWLN2hYvaktiu?=
 =?us-ascii?Q?vJ/iPsze7SisfVY0ca4OIdHI8usDf3Ua5mUUCE4jbaaHLsKkIWW3odagASYD?=
 =?us-ascii?Q?lJhEQJ8txDuJvsJTGVL/pHnMe2S0GBF+TAm8L+UKFPG9rsfqu2KIJfsSdbPw?=
 =?us-ascii?Q?nagoqIfLqb4PGJXnANEhiWk3gKEPOhufoHLTP5fD21B8kpPYDVM2QcSufxyU?=
 =?us-ascii?Q?Ip1CJdHxewvc5sYVF9XbsKSLZLWBrF9FZW2B2WtBmTJmBahnbjc+jY0om7p6?=
 =?us-ascii?Q?ziGbZmjQIt48HP2VFVcD9GPLVEAj2sxmEFPiEjESSVubj0Y90Hw/cxWuc0XK?=
 =?us-ascii?Q?8E60OMVZeKp3wOQxIBZ2Aw8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144AC9169710C46E316EE8DF7519BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b55d7c-ae7e-416b-b121-08d9d5170e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 15:28:44.5299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xM8mrsWwQY5Kteuhmlh2g7EyEJwJ4qNgvunVXcorEgZwnJ1tO26orc5pk2XFdvMsmG3VvTiC89txnzt5JttRbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144AC9169710C46E316EE8DF7519BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: VURDIGERENATARAJ, CHANDAN <CHANDAN.VURDIGERENATARAJ@amd.com>
Sent: Tuesday, January 11, 2022 10:25 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; VURDIGER=
ENATARAJ, CHANDAN <CHANDAN.VURDIGERENATARAJ@amd.com>
Subject: [PATCH] drm/amdgpu: Enable recovery on yellow carp

Add yellow carp to devices which support recovery

Signed-off-by: CHANDAN VURDIGERE NATARAJ <chandan.vurdigerenataraj@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f0fc015bd11e..2f519cbe7af9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4473,6 +4473,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_d=
evice *adev)
                 case CHIP_BEIGE_GOBY:
                 case CHIP_VANGOGH:
                 case CHIP_ALDEBARAN:
+               case CHIP_YELLOW_CARP:
                         break;
                 default:
                         goto disabled;
--
2.25.1


--_000_BL1PR12MB5144AC9169710C46E316EE8DF7519BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> VURDIGERENATARAJ, CHA=
NDAN &lt;CHANDAN.VURDIGERENATARAJ@amd.com&gt;<br>
<b>Sent:</b> Tuesday, January 11, 2022 10:25 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; VURDIGERENATARAJ, CHANDAN &lt;CHANDAN.VURDIGERENATARAJ@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Enable recovery on yellow carp</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add yellow carp to devices which support recovery<=
br>
<br>
Signed-off-by: CHANDAN VURDIGERE NATARAJ &lt;chandan.vurdigerenataraj@amd.c=
om&gt;<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index f0fc015bd11e..2f519cbe7af9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -4473,6 +4473,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_BEIGE_GOBY:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case CHIP_YELLOW_CARP:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
disabled;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144AC9169710C46E316EE8DF7519BL1PR12MB5144namp_--
