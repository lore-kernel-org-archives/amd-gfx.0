Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F812E7E644
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 15:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 973BF10E0EF;
	Tue, 26 Sep 2023 15:07:18 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A19B10E0EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 15:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxJ1r0/RC2V9Apv9a3751GL7KrZF/N54wt6aX4YyHE5y6ZDPMa2DeiMY9Z/xZ9VXpuLziKHS9ELdXBsk0mhucIaehDWB10C9sS20Cq5XjpM4w/K9ReFEuKi+zbhKGOKMDRQNjkyf3EdDdATtigiZvL9sSftStoQzBxmdQWkNW/MKjGI6hrd8TyL0sJwWed8AzQhp+UU+g+74F+KeHccq8Kuh5e2hxI2gXp+6NTDMkbAaoKaATq477okhy+GZt9oJCwD8U7PFX8v7TeDwCtGs5T7DYANxLVwCpULYK1nFbc92vdaqTNQDYDLMQ0MUQ7wld+zUp/+X9q07TdM4E4iTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VONDwuqcKWRHNvUqtC0aM/deRjLD/hp56wvX4ENF3k4=;
 b=T9Yy/iO/AGgHUICae7RUjE6MkDDUJ8a2uKHNaXALSmogPRBPx7L5KjN9AgU2wJfSGeoeJIZajJd6n6MRWm2lfCVU5c0e+lYzD+h82Ff5tCJcbkghwY39XXYzHk78dxUWA+UtZsM4uue+nVFCwp+M5xfizN/iSuU3GnhUFjoka6LNluzHu+5GM4nsLQjnzFN0ff4mnE0XmPetvs1lOaa+bYFdnR97RIyz8eDvesleCSQPT5IoYqBGGgMJI+njaJrj2M0LNNuaeTko09UZhy1ismdLrGebeQGE4aEYzVnVE6jb1dF5ZeRtFHTuREbplJtIIN3L9XH10V6zUG2/qmNK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VONDwuqcKWRHNvUqtC0aM/deRjLD/hp56wvX4ENF3k4=;
 b=0Gm+v73G8kk3DxTzSXFxJ/V0e3zPi3QX4A3U/S2aGkNY257dY03jbo4g4+FDTVamocMYpTB96cY0djRyyN/8+M/nZk2TavhQ1eUZk2/ZZImW/C5DM/IagEzNk3UeGlJWEoUXrtIiby+dJ7uLynkB7UhDP1pHcbYJlHrbuhB3Z/k=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 15:07:14 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 15:07:14 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd: Limit seamless boot by default to APUs
Thread-Topic: [PATCH] drm/amd: Limit seamless boot by default to APUs
Thread-Index: AQHZ8IruzSeYraQOcUywxnjpg/WIabAtNRQl
Date: Tue, 26 Sep 2023 15:07:14 +0000
Message-ID: <BL1PR12MB51449B3E684B5F7F38AEF2A3F7C3A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230926014413.139961-1-mario.limonciello@amd.com>
In-Reply-To: <20230926014413.139961-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-26T15:07:13.511Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB8284:EE_
x-ms-office365-filtering-correlation-id: 7de69635-e9c4-42b8-ec37-08dbbea24461
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OwyR1ysqsucKVb2Ip6NeLfpqK9n4BEpcu4ujBZdM+HExSrHeOreLrNU017J3KwgWXcvjlKlado79ghS8GIXUydqQBhYKVbJkLWAJPvb+CyZnaiDYNlWSR9gQM2fEILiX70xW7jsAqBqQQSVfuWdttOiqxFqDj65OaD+ZSMWBj9igKebMgK9EFRPdZfzHlyOfA27PXZjDjiJ1qTvdWuczjwhSXYxDDH/64y/l1lXeguiMgA4DsUxw6CBAsAlptdd6+DTZh/NWQ0KTsGlTsx1Q/tZKcyCamjQWCeg7YiYC6IP/+2GmDZQAt8NRlhZgMeQvjYjXBIdwuK3EZr4iNu0nFmOq4QQHhrnmnZHX2OAx78haABrBFaPIuJWLV3xfBGP749WgyCGXP7Egd1QtfJMM6qWCLiZo3pZaeSEm3/I+6XwWgviMwuv5xwzthQAsADm38gi9RC1I/MX1bXTYvzp4M0HHjnfVRAurSUwqAZ7T3KCd55RWc5KE5QgYevH45lQUWMQ+sAENUmjhXLWPHODqyV5aXsD2jgDMo9RGKTyVo/6cNLxSD+EjFTT6zZc2reHMbaqzK9FUr3lyQuTWyfbeBu8/81+lph94IlHNOiD18NQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(316002)(41300700001)(26005)(55016003)(52536014)(2906002)(19627405001)(5660300002)(8676002)(66556008)(66446008)(966005)(110136005)(76116006)(66476007)(8936002)(66946007)(64756008)(478600001)(4326008)(71200400001)(6506007)(7696005)(53546011)(9686003)(83380400001)(33656002)(38100700002)(86362001)(122000001)(38070700005)(166002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VDkU/w4jT99qzkTkLWtNzgi/I729Amt5ImwXmq+BA62ttC913AnXLW7qwQNY?=
 =?us-ascii?Q?8DBzxHjFWiQPZ7wAidVzAp3eQ79yhadraDAiQ5H1wDfMYAakxF1OdaiElkiP?=
 =?us-ascii?Q?DJWMz61MuMrYsdLgVgsFi8vZd95UOiPX3ECfnfraQmxaFCJu/WU4PmPSVUT4?=
 =?us-ascii?Q?Rt8tZUi3Clc+BJObkKeYPF4yz8/hTc343NLah5zPThPHky20rIY8+MUCJ+hS?=
 =?us-ascii?Q?u0agQDn6aP0STXIAkcB5ajW6dWAovq+2V21ZUl0jOAIc+TnTndVMQG8jD8HZ?=
 =?us-ascii?Q?YaLNdRRYfnMB82OlIvnTg53hOnw5SnY8k/M4t2ZuMzxtaSPZ6aQPr4YZ11Id?=
 =?us-ascii?Q?1q5jJoDTb4KS5RHg8tK8etqx8jqyjnCWOS9VeKLZM5eLt8VqHvYen8BBQI50?=
 =?us-ascii?Q?HJRLTC6SG4+GMaieTvcjvuYaosASbBDCTjKT7McP/LIG4YY1pInP67UHke7d?=
 =?us-ascii?Q?NoEQW+6G3dTHaniHri0mlAwHiGHkYN5TIGJwTgH2kHRWg6t7fyMhQCcVKApu?=
 =?us-ascii?Q?GteJ99UBd+JzLZM8xwHP7hKvcXgX1X89bl6BsfP8Sq2lQcADdE6X23xGECFG?=
 =?us-ascii?Q?NZn27vCUWW3M5nPwW5NgxB84/jxFyfBgnNpJqJ23+jg9X+cLGuXdLJjqD3Rz?=
 =?us-ascii?Q?ZnGrpevpTu8MolTCEAQpGYQ5SIPoMgE1JKXGjZ5PEFuS5dtN38FBHeT4PUDC?=
 =?us-ascii?Q?UbiziMMrNe7A9gEbhDgClWpzPkfsOlZGY+49uKvDITAjZ8HLAV2NdzzGvHK7?=
 =?us-ascii?Q?P5K6YmT2WtiJZbiyDd2OYKuTwXX+2+X1VFfx9CXZUUbpKvoVGfASo7npvowI?=
 =?us-ascii?Q?UpzYL0XS2+tnXWlJYg2yYr8ZFDDXOka0+ciSb3X8q1hBoFzPPREtUcywZJm4?=
 =?us-ascii?Q?i1Tm/+A5riZBEAmJrZ85OxSQgFOeGG4XvfjJb+usVlE5oGHUQg6CMrV6XXDx?=
 =?us-ascii?Q?2EXomHtn7vwZqjE6zOglO4CIu0gkK57MkNJfcPZQ49Yk0tHhCAIEn5OGKuwQ?=
 =?us-ascii?Q?JrFt/gKdz1vRvIiYSRrO57BbrFoLkAixJ+6KAYA1SNPYH6Qh3Ld5L5mwA7UD?=
 =?us-ascii?Q?bQVKej00Z0vwYrBYp+ieCoXpntBIQzA3mK9tp2YERu+OewHkeUHzfmeZu0cK?=
 =?us-ascii?Q?n4pzZ1cAqUGGn6tcjTCTRTQ10htIaF69qgZdlJo3IueN0x8TkynB4WYL3yd6?=
 =?us-ascii?Q?HyIajtTn2ialq8XTrvgDHShexDoRFcrYMRoTUC4ONrT9QgSGQ2NfU8rk3jFZ?=
 =?us-ascii?Q?5mHPrfKf1yTgisP3RIu+FO0aWFE3RbzvZhdinKw6VBQ2hh1ClZ9DR6hB6VuQ?=
 =?us-ascii?Q?+B84t6nTcbdBMoJrLE8qj3XEZpmfDdbgYWjkEBFk4NC2T7SWEjxTQi5Q8A1H?=
 =?us-ascii?Q?GtsAqgk46Cs3bGluRuxQUo9MeBDueK0dEbVOYVfnoRAAUN7S5W7u9uOlFGFP?=
 =?us-ascii?Q?vO/Ktkptj/qstqUsW8GFQ4I6JlZSVi1LxHXximyUOygFJHb0EbIs2TIl8Hyx?=
 =?us-ascii?Q?pnTUhw4Ve8/G0WhSCUD5BflIiWz1lenOxUUrcAGw1wUUmNszRl190CzEsaxD?=
 =?us-ascii?Q?LRqDkNdwzoZ1xN1/lWg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51449B3E684B5F7F38AEF2A3F7C3ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de69635-e9c4-42b8-ec37-08dbbea24461
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 15:07:14.4221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwRuBZv0WAuel+NuN9Pqy+1Tpc4j4/5h3/+0U13XW82dC0Jw3Y/JmFQaCNLA88lWaI3ZnxMxJQcvxj6n8FY4uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51449B3E684B5F7F38AEF2A3F7C3ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Monday, September 25, 2023 9:44 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Deucher, Alexander <Ale=
xander.Deucher@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amd: Limit seamless boot by default to APUs

A hang is reported on DCN 3.2 with seamless boot enabled.
As the benefits come from an eDP setup, limit it to only enabled
by default with APUs.

Suggested-by: Alexander.Deucher@amd.com
Reported-by: feifei.xu@amd.com
Closes: https://lore.kernel.org/amd-gfx/85b427f6-11ec-4249-bf6f-eadf9c375f8=
8@amd.com/T/#m2887e919d7c01b2a4860d2261b366d22e070f309
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 22c0e035de81..5436d7a34014 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1380,6 +1380,9 @@ bool amdgpu_device_seamless_boot_supported(struct amd=
gpu_device *adev)
                 return false;
         }

+       if (!(adev->flags & AMD_IS_APU))
+               return false;
+
         if (adev->mman.keep_stolen_vga_memory)
                 return false;

--
2.34.1


--_000_BL1PR12MB51449B3E684B5F7F38AEF2A3F7C3ABL1PR12MB5144namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Limonciello, Mario &l=
t;Mario.Limonciello@amd.com&gt;<br>
<b>Sent:</b> Monday, September 25, 2023 9:44 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Deucher, A=
lexander &lt;Alexander.Deucher@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.co=
m&gt;<br>
<b>Subject:</b> [PATCH] drm/amd: Limit seamless boot by default to APUs</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">A hang is reported on DCN 3.2 with seamless boot e=
nabled.<br>
As the benefits come from an eDP setup, limit it to only enabled<br>
by default with APUs.<br>
<br>
Suggested-by: Alexander.Deucher@amd.com<br>
Reported-by: feifei.xu@amd.com<br>
Closes: <a href=3D"https://lore.kernel.org/amd-gfx/85b427f6-11ec-4249-bf6f-=
eadf9c375f88@amd.com/T/#m2887e919d7c01b2a4860d2261b366d22e070f309">
https://lore.kernel.org/amd-gfx/85b427f6-11ec-4249-bf6f-eadf9c375f88@amd.co=
m/T/#m2887e919d7c01b2a4860d2261b366d22e070f309</a><br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 22c0e035de81..5436d7a34014 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -1380,6 +1380,9 @@ bool amdgpu_device_seamless_boot_supported(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mman.keep_sto=
len_vga_memory)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51449B3E684B5F7F38AEF2A3F7C3ABL1PR12MB5144namp_--
