Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1363EC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 21:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B74910E212;
	Tue,  2 Jan 2024 21:43:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3FC310E212
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 21:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtrcHjKHmssSe3ut6PKe8gsDvXwi7jmmlxKdjWxEqk2gABqYMGLgy0VIZua5GHMc0euBmXKQ8/ODVw1E28V7oIzLRW7FYf888Am7MOn6ANso3XRTChCRoVzUMjdkuWPTy07MwCLbhQryvsOH6ySMGD21LJdksUWJZCnmLUHAqrifX/2A74nS1kHgwntfLZqIvR639df3FXW9bsMRZ71iGr3wkn65du2XKJadduOBY3VwazzzNiI2sUEBNvIzlLr8Ui0aMj2BspUf3o1JhWCYwEz/YbnC28d6QUPq70b8xDaqUwoUAI6ivzz1iwXYAbD4MkZGfyIRHRhL0f0Bi4/dLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X33LinYmVJD/7mjrKOmmiZ3FP1xj9z8jp3KyKckxg0=;
 b=RP3DqKMQR/Sp9axfrh+dmmUB8ztux42FSOH2/iDi7138k7p7ghzCXzGSNHulBa2r+gwQbZWVvw6hPryicMc6WkqrZXnHQfFD5RVh29JkGvlqjij2e5/1fD7Yc2NZLM+XVTvfcZwNZQgYNiW6OpAQqJPrg7ts78D47OW1CLimwN1I5Uwv80uKX0Ie0/kHvttLCRY8a8trBtjLvrwAia6sCrRfFvmJiDmUZvnknM8T5WkkH2BhX2rNcMJtbr9uzSg7+a2V1rrA0KvfMYHSAwkIQOjZpTPscWSsRNEMGFVrh8HrZQlV1fYqk0R9Vm/XL1mhnQLr0YLFz+2yu0djO5p67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X33LinYmVJD/7mjrKOmmiZ3FP1xj9z8jp3KyKckxg0=;
 b=fdG9hIB2vFFP+PcjBT+J6j4M/JP/4CixiTxdqBJaVAfJVIqEwW70/QtBvyuVhVDGfzBG6sMV0qd45IXFWdXvulfqRBQs2zawSpLWveOFoEzfVLOLz1tlXlnGjab51sELg9qTpskWM+j87h/G3gSeLxfjM8eV/HWKHxvt6SqNVq4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 21:42:58 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%6]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 21:42:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: skip gpu_info fw loading on navi12
Thread-Topic: [PATCH 2/2] drm/amdgpu: skip gpu_info fw loading on navi12
Thread-Index: AQHaNDkbe9HxLTe3KU2x9rhxLr/dvLDHIM3r
Date: Tue, 2 Jan 2024 21:42:55 +0000
Message-ID: <BL1PR12MB5144AC0FE04260F237A07F4FF761A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231221181106.17924-1-alexander.deucher@amd.com>
 <20231221181106.17924-2-alexander.deucher@amd.com>
In-Reply-To: <20231221181106.17924-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-02T21:42:55.304Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH2PR12MB4326:EE_
x-ms-office365-filtering-correlation-id: 6e5eb688-dcfc-47ef-b9c6-08dc0bdbc7b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYJ5F0mbzasAUfgDWWAoC0Y/ImBijUYrTOJu+E3+v03lBpNjLS7npAOFQvntOU4HnnADM4zfn/qQJ8IfTQtIrM322C3LCGDarQuc3UdUcVOymHi6NQZ4mf7a5rvkEzXorZqduCPUny+Il2FrT2lxZ/7a5oUMCg843uNkvGdLATJBorUQT71OGFtBwL8f+bnuL7WjhcRX6UReza5asCxVzoqmP5VUwzYueK9kmCStQteBjKyP8WKHnNuLpp5f0QCP+kXEeuV5FX8lwaLonc3mELOL2fWCMK1UtnjoUXflw6ZHG+nsV7QgnBJTbYC4lAo9GxQEkJ2MGQeJHQVYMOSMytvpfC9iFWwwiywWExJZgEjY/PdRwZTEH8J7cosLFE+xGDvB73Fbz/XmHyksTaw9xQy8m2Injnu8rSIrYCXIXRWgbwirhULxCXVS0mInDOJFvNkGrSp9aONpbSOa/0hoQtDgBzaA2KCv8mmWrnH9kSxcREv6eiRiE3xev5pSXqQmIwDJVVDJvsob9LRFxhsMkZDcHhQStRud981cDwe5MkNCiFXmJTRVuGW5XxuJ8P+W99x6hOp1L5rWnsadQjU3TMKhndaASe1Q5KxbYTnLPyc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(5660300002)(38070700009)(41300700001)(6506007)(122000001)(55016003)(966005)(478600001)(38100700002)(33656002)(26005)(53546011)(83380400001)(7696005)(71200400001)(9686003)(8936002)(8676002)(52536014)(19627405001)(166002)(6916009)(66446008)(64756008)(66476007)(76116006)(86362001)(66946007)(66556008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b6ZH7PeUnK64dzkEVziaxGdwVO7IjYGdLIRQlBX6EmdwGep/3FdnM9rp5eks?=
 =?us-ascii?Q?AOnN5DDMiYceDjG7khqTJFbrQcgiBn6WRuDv5oJlC6jHDLhpS8nY0xy2Ofoi?=
 =?us-ascii?Q?TnsficqoPAd2j0FVRhPfN0GyFVMX56XaDadbL2YqPZcIQgz0UkcwrS7jDsDY?=
 =?us-ascii?Q?i0JPfb/hCz2B9V9/+dPTq/husHhzryBP+xQQE1FeLPW7sKoWBGFzEK5to9YL?=
 =?us-ascii?Q?R4C0J7UStGI4ADbrHKfnone+D2d0eUrttv/prxUqjPGy2xEcfOBwlHZnwt1Q?=
 =?us-ascii?Q?yDcbPfOqXSLHwgcPJjPt4E2Mrl12tsDNDxBqyZKC1QrY0FeGAtVwESDKyHIZ?=
 =?us-ascii?Q?Me9HUPibSCFaWIfEgj4wyCtF7rivLfZ/EWl4D/9At5MR497v3kIDCBhbE/Xs?=
 =?us-ascii?Q?KjRCEIPw8xtUZMEGOC/XrJnN/6cG7SMK2aUlbsRoPbUBj8md+36GlFaEglUH?=
 =?us-ascii?Q?R2lqheJjwwpBhumWTH0OsIqqrlYwyLHBxYlAnXf5PQVRM+nSgjbrGvjxLpTk?=
 =?us-ascii?Q?z15J5EjF34nOHK9i/9REDgvfca8O5ylBESr6ooiKlWYVwrGGRSpQ/QBO3LWp?=
 =?us-ascii?Q?07MG9IlAh0ux8U0tVsvcjzD2Iqp/xFOq+k8pjwjXta3VlRgKeuS+AQQMdyyI?=
 =?us-ascii?Q?Z3pbCc63U9F/0D6gFOVz3PHIvbp2qZFcrAc/vpgjmUolm6CAv4KsgYXpivCy?=
 =?us-ascii?Q?vTqh3266hp0B2m88zCkNq+4wHLGQ/bxmXtbxRiqaT3cLGrOxVslI794iF9PN?=
 =?us-ascii?Q?N1BhFy7HqFDGNI6wwlmT30Ompv7mV65oS3Ng9NG7v7Ib8PcYIuiCACP/KK35?=
 =?us-ascii?Q?Ss0bYQFWVb9wTA5WXgtqwS6yThY58J1zDr3L2nsyasD4jEiqAx08NQxEovgT?=
 =?us-ascii?Q?XsamGGVz6smBXMyUkn+c/0D2MMlZZ6IBtniJ8Jpbi3tzCUrcrRAyK4UYLx+T?=
 =?us-ascii?Q?bvKbrF3yatLcKrGEOmm7+FZb8s96LHbNm/Mskifs6+KkIiHw2LNFRtSCSPiA?=
 =?us-ascii?Q?NHwyGV1DBkFRu34PAxvukF48cYQgTvqdnZl4Z3weXKzJjDtqUH4swXsXBgrk?=
 =?us-ascii?Q?1+fie6Em03C7/55NAWCMWTmNIQq72SyMbbZQQrYc/E6Nke0DN2eTfuLZmaIS?=
 =?us-ascii?Q?pfd+lk/qC/PjbSq+EaMB9VmnxiLmajW9xseu2d/RSHfnBmeOEt0SWezZMvHb?=
 =?us-ascii?Q?2zUEW4kux5+0jwYOqhff0AP1YHJ3xFf/Yv8rLnPeDTxE7g9YI4SJHEhdWbwo?=
 =?us-ascii?Q?M8CjArMdgFLUCgq7RyIOxucIqmD04r7doeJp0JHTY/jzxxQNZMU2yHGG/ZHL?=
 =?us-ascii?Q?U7Cdj5iMc9fuTfSm1g6/Y9TsP6E5HtWhjHMNnCCZPNaHCK7pud+IHgBjZEnl?=
 =?us-ascii?Q?rq2qBzZOnzKejE27OJayflHWfVgRcLH1q2/QPSC83gzKQv3Ar18/NMTsg1Ry?=
 =?us-ascii?Q?/Hth/FOD+UoQslWwNURV/SWzywZkNurL3lLO2P6i6nZoi3P5hPK7rrE35NYM?=
 =?us-ascii?Q?RJJGKSb5vw+RCW5E0fTw5nBbHdRH9dMBMY4ODbPA72amOtX4fUsnKshp2Pi2?=
 =?us-ascii?Q?r3YcKi88bNXABxxLnmA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144AC0FE04260F237A07F4FF761ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5eb688-dcfc-47ef-b9c6-08dc0bdbc7b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 21:42:55.5753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72lGy3+27wbJDzmzDzd+ToPTGFu55ksYKkaKMmJRQgaUP8rfLb9xsTY6UInpfxT1bbe3U43yFnwpIG+mO4X/Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
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

--_000_BL1PR12MB5144AC0FE04260F237A07F4FF761ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Ping on this series?

Alex
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, December 21, 2023 1:11 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: skip gpu_info fw loading on navi12

It's no longer required.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2318
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 9c1ff893c03c..71e8fe2144b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2251,15 +2251,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct am=
dgpu_device *adev)

         adev->firmware.gpu_info_fw =3D NULL;

-       if (adev->mman.discovery_bin) {
-               /*
-                * FIXME: The bounding box is still needed by Navi12, so
-                * temporarily read it from gpu_info firmware. Should be dr=
opped
-                * when DAL no longer needs it.
-                */
-               if (adev->asic_type !=3D CHIP_NAVI12)
-                       return 0;
-       }
+       if (adev->mman.discovery_bin)
+               return 0;

         switch (adev->asic_type) {
         default:
--
2.42.0


--_000_BL1PR12MB5144AC0FE04260F237A07F4FF761ABL1PR12MB5144namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Ping on this series?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Alex</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 21, 2023 1:11 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: skip gpu_info fw loading on navi12<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It's no longer required.<br>
<br>
Link: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/2318">http=
s://gitlab.freedesktop.org/drm/amd/-/issues/2318</a><br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++---------<br>
&nbsp;1 file changed, 2 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 9c1ff893c03c..71e8fe2144b4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2251,15 +2251,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct am=
dgpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.gpu_info=
_fw =3D NULL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mman.discovery_bin) {<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * FIXME: The bounding box is still needed by Navi12, so<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * temporarily read it from gpu_info firmware. Should be dr=
opped<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * when DAL no longer needs it.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_NAVI12)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mman.discovery_bin)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-- <br>
2.42.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144AC0FE04260F237A07F4FF761ABL1PR12MB5144namp_--
