Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B70AC0015E
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 13:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C6F10E3D6;
	Tue, 25 Jul 2023 13:50:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D4E10E3D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 13:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXFPk50iGw86k3kQe+FcabkagHSd9w1L6oMAoHoKCjK1TzpVDhJI3kHlJjHo8QPyCTiEq+ro3jdqN65qquEThzFGx1dVmmpD8d2d5AGLrDCAHjOYCHrp0wFn5hhnfK+VUWMxIJ3n+lYlMY1M7/HaO/ASwUtBFxLWrgWOZy38KCod/d2IOHOXF+ZwGy9IOSM4aT0KfiNgLlk8GWOaOr9qhBjXLxUhYSQTLakBMk0D1HkIkvgWeADzk6OoWIq/Wama7W5sItmOQ5WWMlenXLZvjw9sFwa/aP2UfytPvQxNoehT6uR/proZ+Oar07qqlv8N7hrGbEEFcoa7fUy9KS+i5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSs7UE4wNYYwDN/RdkA77ad9Evo34bvVjbwwx5ky2K4=;
 b=INq6ZkdAnfOtASzJQ8MVVrvlCdOsdPA/os+kaYEql4VtNOcZWcvHnrq9EmB4AbQq1n9BGrgkUg+k/k2wxG1/T5h+e1gYtJdQN3GL4dw7bZRgHLSwYHPDa6TTHJHaVMD9crug425MdGQOz7KJCpNMiVT0/lTWzL+sagArqQAccAAa706ND8j1QV+sKNr/nZdNLFGSRJQ8fZHWW7wJPEX5w5LX3P0d8IV2/lhFPILgIQuxIgP+Q7EKtnXsoJ5KS6dbB1syV+hF4+gkR5aruys/lO4rsTY6Qjhhdrwx/yW/WKp6tdsn6N+IBEWvZFFbNea0A0gJiZ+eVnmPB7TLAwY0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSs7UE4wNYYwDN/RdkA77ad9Evo34bvVjbwwx5ky2K4=;
 b=RzZTDFec8nQOKdjMG/LhyStcyOU47TJB/c0gqoWRPE9zWNHIt9T2mKZr6ARzSWCFsCqEReONHlHwSqJKv8yJqo4ExO2ZYbE8aKF0Erjv9iyT5907tNKOdP5jnhJYF/gJAIsRTdaqwjK6/4ZUvRksp4C5Wv99uf4jRZ8gW0BD7k0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 13:50:24 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 13:50:24 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Match against exact bootloader status
Thread-Topic: [PATCH] drm/amdgpu: Match against exact bootloader status
Thread-Index: AQHZvv7IY1VyI5AQUEmaktkV4zwvSa/Kf9Eb
Date: Tue, 25 Jul 2023 13:50:24 +0000
Message-ID: <BL1PR12MB5144F3E79D4C9A149F91EB1EF703A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230725134850.3197790-1-lijo.lazar@amd.com>
In-Reply-To: <20230725134850.3197790-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-25T13:50:23.235Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN2PR12MB4126:EE_
x-ms-office365-filtering-correlation-id: 7080378e-7270-40cb-996d-08db8d16187b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4XPTsyn9iOg1A9pyq0DjSGUMzdP9z9JDWHnATmUwn1sWMH3lNEJdSYknZG9uPCPBz5bJpFq1BLijoRQMceS4ToL9MOsOZlvkNIfDWhstwkV+A2Rs7U6Y46uos0+DVG7gp3xoWRCZ4gM8JVGV4U4SH8qV+KA47u8cWx8aKpBiD3tZtny8Ccush8TI+9R9jpbDdWw80iDByjgYdSyYCAcfrcDg0qpG0T4DAXs4jzqfKqN0Wsavnbe1PbHrdz/mhuhRpw4qCw1ZiehOUuMncuBeWdssTXlcJEefhIquHThSVCrYk5jYVmVkk/7F5l5tSdj5Hrc6rgmIwkH1cdlKh2LLg5mkCu/8galkYsYOWGGQsDa/XtmWHX4WgeuJSMxJiQ2fn3TesLAd8VvKx/ZozPkc8wJ3XhvS0Ri7RIkd8nrS+hbMDya/0fOZEEYNULKooegodXRPHMCds7qqOAWObVyv6kUZon1zHQg3jXyICcvSKUMjZ73b3jkMMLNPCg5I99gpW1OCVRqUApnM2zSg9/eu5xHX3IqDyuYeRo8TVkyopt1dktvD+OxsPr3nYfxKWYjirN7If6oYOraUUSXn+ozeoysgKMtCJO42ub65TxaGlSJMjtr8BL19karEN07fqDTt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(55016003)(26005)(186003)(71200400001)(53546011)(6506007)(64756008)(66476007)(83380400001)(66556008)(316002)(76116006)(66446008)(66946007)(4326008)(5660300002)(52536014)(41300700001)(8676002)(8936002)(7696005)(9686003)(110136005)(2906002)(478600001)(38100700002)(122000001)(33656002)(86362001)(38070700005)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r1LXkvCd03qV3+1qtv+AZMVRdavDDUABGsVwPMKtSHiCX8fa7tf9HkcH4qhs?=
 =?us-ascii?Q?bRcSwpta9vhVZjZS4k7OXPqAwbI+55NrePvkLs1akWtLB4/KJJuiBSjWBO05?=
 =?us-ascii?Q?lzKpmnJaw4y/jQG+ceb0glFgVl770ZIN7XWlXZHuoa6vZQIbCGRAm2iYXP8n?=
 =?us-ascii?Q?m7dmok76aohBSBrp7ea4ltZEmldL/O2j6PlZ6i413opIoP8ezATvaYcpK0Vu?=
 =?us-ascii?Q?1hzAmdAgYkdtE3BQtTT3TDFr+/wJM75iH+siraHCD7vwf12nX6ZVem0UZ7d1?=
 =?us-ascii?Q?n139idIE6Yz2xsgJRKymz/G1RtbzEnLm4H2sz761gZR+KhaDLzLmsOUcVGn8?=
 =?us-ascii?Q?x5i/uzUhKDLNLwFuw+h1trLzQNyc2zVNMRa7hwnVy8G4VDHl0zJY1GaUr9tO?=
 =?us-ascii?Q?wvVgACv2es/ks4vB9RgZFd4ePA+OMMG/C03QcskptIplyLVPOLA8UkilIhkJ?=
 =?us-ascii?Q?VZ1+STjx83b9LYlGX2egJDr6WrO72U++0EC28b3KHuY7kmcPhw1fwaElQ3Qp?=
 =?us-ascii?Q?YAz4kJhtGFkqYO6saFLQonI7n5Ikm6MSMpKnq4SwgS9wvIKjyxgjoDAosO34?=
 =?us-ascii?Q?OCUvzIKUecKrib3dTZ204YLtndl5i+gXiHHLNf4HmIbRTouc2e4vuOS8ng5W?=
 =?us-ascii?Q?W6jmI4oI32hkyhf56uxHrfSzr2CjyfTdSI2GgUFQOnulFGCz4t7eLTBm4D6E?=
 =?us-ascii?Q?1IwgfnKfiVw83K4W7nMhql8LYivhchh+KATcKx10aHdwghMKQG6ge94pYneh?=
 =?us-ascii?Q?End7gFOyrbItAtezynS+zqQitMf1vZEs82soS6tqBfJmaVb+QTagDSN0WiYQ?=
 =?us-ascii?Q?1PNsuInq82tVxnsbwKUR5wOo/YS242ffc8M2a29+kuvK4WosVjXkPocbO0a3?=
 =?us-ascii?Q?Z9nfXiL9R3WgbsNitueyv/xgqTE44Sb3ny9ScaR6Jjf0ikgHmnx8rOVR7Feu?=
 =?us-ascii?Q?1iTFmao3tK3Qgy6EarYO29rgXxexa7sDKi4EXXs7lAKMAEqxaNX9y5VOIrCz?=
 =?us-ascii?Q?uVvxWW7Eo+s6ynsBlyx8CV/duEqOvaUPOpdFA0jmcDP/P3vd0OYcnMngoxdp?=
 =?us-ascii?Q?0ZVSxHxG3skGk8pWD3ovzU6ywaXucOSuiJl9afBL9HK+f9xIu4kzc+n1PEUQ?=
 =?us-ascii?Q?nAURJWEH8hBbCepjGk6QaZFO6ruOxbw0X7Gx7VWgOy2VX93CT/6ra+yIKB3F?=
 =?us-ascii?Q?5a+34TeKhWCHfNwu8AqJYZbksoUVRhh2mbhbFmrhv+JDsGx86eb6k/K/3C7s?=
 =?us-ascii?Q?W14rp0vGpiD52lUXplSRSgw9pvK/t/rKc1GAWu3+rAK2GpnyrlrEznb3pxHl?=
 =?us-ascii?Q?zJjq1EabQTIPBijGyW5+OnlzCwxOMTPGIiHjsyVUrKY/Jo6fgi+OXOSi+jym?=
 =?us-ascii?Q?hhswEBXr08U+PMJO1UCKa0tjj5X58QmfD7uQ86BxO1DAjqFa8k+C0gAtoJ8+?=
 =?us-ascii?Q?nEF8piF3pSld1cGEvfT4YhA+Nksnl7IyHza19hSvxtG1naZXEoggmNelph7h?=
 =?us-ascii?Q?w8nfYFENR/BpMV8jybIK7zlZOvqDgGLGkIRszLeVaeHVeJVQjYwiA15w+/F7?=
 =?us-ascii?Q?LF9hOus7LUnOVv5+vkM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144F3E79D4C9A149F91EB1EF703ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7080378e-7270-40cb-996d-08db8d16187b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 13:50:24.2434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3v2qSU8XpGqYYkwCrDJJHGyWrOEMs5O1SYqXIKBWAOXb5WsoopIl3Avn7FMy4S9PK1OneMRLHd6URpqlRQyqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144F3E79D4C9A149F91EB1EF703ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, July 25, 2023 9:48 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Match against exact bootloader status

On PSP v13.x ASICs, boot loader will set only the MSB to 1 and clear the
least significant bits for any command submission. Hence match against
the exact register value, otherwise a register value of all 0xFFs also
could falsely indicate that boot loader is ready. Also, from PSP v13.0.6
and newer, bits[7:0] will be used to indicate command error status.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index e1a392bcea70..af5685f4cb34 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -137,14 +137,15 @@ static int psp_v13_0_wait_for_bootloader(struct psp_c=
ontext *psp)
         int ret;
         int retry_loop;

+       /* Wait for bootloader to signify that it is ready having bit 31 of
+        * C2PMSG_35 set to 1. All other bits are expected to be cleared.
+        * If there is an error in processing command, bits[7:0] will be se=
t.
+        * This is applicable for PSP v13.0.6 and newer.
+        */
         for (retry_loop =3D 0; retry_loop < 10; retry_loop++) {
-               /* Wait for bootloader to signify that is
-                   ready having bit 31 of C2PMSG_35 set to 1 */
-               ret =3D psp_wait_for(psp,
-                                  SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PM=
SG_35),
-                                  0x80000000,
-                                  0x80000000,
-                                  false);
+               ret =3D psp_wait_for(
+                       psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35)=
,
+                       0x80000000, 0xffffffff, false);

                 if (ret =3D=3D 0)
                         return 0;
--
2.25.1


--_000_BL1PR12MB5144F3E79D4C9A149F91EB1EF703ABL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 25, 2023 9:48 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Match against exact bootloader status</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On PSP v13.x ASICs, boot loader will set only the =
MSB to 1 and clear the<br>
least significant bits for any command submission. Hence match against<br>
the exact register value, otherwise a register value of all 0xFFs also<br>
could falsely indicate that boot loader is ready. Also, from PSP v13.0.6<br=
>
and newer, bits[7:0] will be used to indicate command error status.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 15 ++++++++-------<br>
&nbsp;1 file changed, 8 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c<br>
index e1a392bcea70..af5685f4cb34 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
@@ -137,14 +137,15 @@ static int psp_v13_0_wait_for_bootloader(struct psp_c=
ontext *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retry_loop;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for bootloader to signify tha=
t it is ready having bit 31 of<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * C2PMSG_35 set to 1. All other=
 bits are expected to be cleared.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If there is an error in proce=
ssing command, bits[7:0] will be set.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This is applicable for PSP v1=
3.0.6 and newer.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (retry_loop =3D 0; ret=
ry_loop &lt; 10; retry_loop++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Wait for bootloader to signify that is<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ready having bit 31 of C2PMSG_35 set to =
1 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_wait_for(psp,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(MP0, 0, =
regMP0_SMN_C2PMSG_35),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_wait_for(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp, SOC15_REG_O=
FFSET(MP0, 0, regMP0_SMN_C2PMSG_35),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000, 0xff=
ffffff, false);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n 0;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144F3E79D4C9A149F91EB1EF703ABL1PR12MB5144namp_--
