Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D1EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4369B10E22A;
	Thu,  9 Dec 2021 16:53:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B87890C7
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 05:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo4QJctUru6Hny8ShV/+6CcfByBmUYnE1bE1y8418j1pAJ8duuTgCfBnv0FJOZhFgwgHlU3TRE2dves9R+xPPqaAV+71ogZ0ZZ9kCxO4FMcHEm4GFCcOhUsx2/WQMIEpXJq0KnLsQ9RsqMnhyHBT4+RLvaWDvPZX0qXcJKCOGlgRllBPkln8HRG2MCiV2vtmAD8WI83YYFZuo6oqqklPGqEnm8wCabt4k63on4IwDu0W5vAqXtzOiBKK9pTsgDGjYr0qcgf2Xw0xfZladxsqLQFzkFlgJ0lEuuFwnfc/B8kw+zVb8wYquC79Q1Q3V5sicP+P4uaDIRH6JStAfRWX6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwfGJYxGKJA0mU7aeMYtZ5rBwbqog2Fx2kCXZkotcaU=;
 b=CUPYWrUckDpiwQgUHdBKP3wZfw1iBZHm2HMqnoVT2wtRcHFhwK/gzZhAEAxdjOcPJ96Ni0lGk2NtmvROAlOobyfaXy4B1Zr8mzHMa+W6Uxk9uOoAwh3ooqcnm2qKkmLzyejDRgE8a75DqTklxJA8Frqay+VvsIQSKqcsuzdG34ke/GE9auPgLdhGnpfBxsr1lgym3/8iFCmLyZA9I1cwJjM29iXYhrnYgg2bPzUgMeTnXXgbQRdTmxAomEQ2X8elcApI3ndAC51GmkY5n2WEGkoM5QFLQzXmnjY5iPAA3hpciCzxEHYslwAdmp9ftR3p9ia+MBKrhF1Z7BT4lTaGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwfGJYxGKJA0mU7aeMYtZ5rBwbqog2Fx2kCXZkotcaU=;
 b=lUeGcuysaU18OhjzXFf+MMXZvJBtHW6QGIAB5437fWFHzNB1xyD68+fpMd4hP3opovtusBrmZnatGf3MrJfS03cSRazxOHPi+7b9NCMfTOsg0zFPA07/WQ9cLwV/4enbFu6cLNwA+nsEJLl3LT9gqtYhUqREt7Oex2I8PpYXWyM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 9 Dec
 2021 03:28:36 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%6]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 03:28:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: skip gfx cgpg in the s0ix suspend-resume
Thread-Topic: [PATCH] drm/amd/pm: skip gfx cgpg in the s0ix suspend-resume
Thread-Index: AQHX7J9vwpFym18uqkKYYjJ6fe0pC6wpgFu5
Date: Thu, 9 Dec 2021 03:28:35 +0000
Message-ID: <BL1PR12MB514434A94141F33C4C265D00F7709@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <1639014681-16853-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1639014681-16853-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-09T03:28:35.104Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 85f6bda8-dc3f-c204-e9f0-a4346068e313
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 305a08dd-42dd-4cf6-1114-08d9bac3fc06
x-ms-traffictypediagnostic: BL1PR12MB5240:EE_
x-microsoft-antispam-prvs: <BL1PR12MB524062AF21BC4B5381F8579AF7709@BL1PR12MB5240.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dgNj/klk1UzxmFEL/2MAAly8jZVRHV589oeqkhIb9zX0co5khb48DMsqyvOo+YVwr5aHM9P6sYdf+VJRtludOEWFa4Dyl3YGGGXWP0oYLi44EeIlCuwK0LrM88blqGAF0qaZcpu0KpX8Hvk+ntSqMje9PTwO4DbQLxfrpXFGyAaNaBf5jt9CFHzg7tCx1Bzjsp1Q3w6SpLBxbnaKtP3J0SH8pWt0zUdU50c7uF2qb4HGM9x9gTQ3mNxYmG6pNnEmFDeHueegOAObblnWpv2NYi3o7VAIionnqcy0moBeXg/iAxLg0ZATvG3xgZZw8utRb3JDtoF+DMEtIiMPjcrzu41HW3BBbKfC4s56hJ8uPyQljmjbFGHjkLsevh9vuFVybp/3Ml5I+X+WaTboYupYuOJP/Bt0gSuYZ89MbgzDLCxtCF7kwnhCY6eZ5S/crEa39MI15R2eoC3hkAqpOVa6Hk862hpoGErxQV0q9zDgm7qgDvcweT7kq3Fr13WEEgne837RgUBL3HFuGlNmjg1jLxVmzyy6rf7BC9As0cuhmg8UjWOamkfiyzB6DJdehgpNNsHvdO2Ij+FWWBcv/ulJfjRmbJEsg8JEtKFJlYCaqZXSIIz5Jic/vb/5chqB+CgFgYFXDaHK2QJglgh1d3bPpNsJuYtzgUZXPYPVZEDN4zy/QXYpnNhlS7B1U7FfcQVORqYxqOcFd7FzFTtn477lXnd+pXSoPFMx+ZXbLbkwRTA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(71200400001)(8676002)(4326008)(83380400001)(19627405001)(38100700002)(8936002)(15650500001)(7696005)(508600001)(26005)(66446008)(76116006)(53546011)(186003)(110136005)(2906002)(38070700005)(5660300002)(66946007)(54906003)(64756008)(66556008)(52536014)(86362001)(66476007)(6506007)(316002)(55016003)(9686003)(33656002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EpqHMEUc6bdsn1NaljFNeKUP7rPyvf0gj+rFZHVEQLcWjf2UJPEiQRPTkg7R?=
 =?us-ascii?Q?H7MTow4hvLSEv6IeFZExzN/5Vl9a391uBbPDCtm18bNd6A8WxaTs04chXQd8?=
 =?us-ascii?Q?/Ghpe5jJtvMT6Ivr6UWFMgbSNXuBywRkwV6lBpeEbGwm580xtWupZfZTPRZM?=
 =?us-ascii?Q?cjkHId551HGsRcn7dJ9RvwvrHMRzb8H1ZEYQ5AzsxYWUVPj9d+wqTSLLnDLj?=
 =?us-ascii?Q?GuLjmd6SWmrfnCxIMcLKsgPxDC2mhso5pjXD7nfmI2/Frs+OUKQUY7zea8t0?=
 =?us-ascii?Q?csdi3OlyzI/z+qcIAIA9o4/RIqIRhIYlIzL9497Up8Aa8f5HCMLK+F78Fbzi?=
 =?us-ascii?Q?XZpFyGB9cbD3Vix6eCeGfAEhV9kBL8r1kho0LIlaw8IgfBccXxdGvp15zdUJ?=
 =?us-ascii?Q?ZPnADAnvkGdMOEU3njsqH4G4oHuZ+2CfH+9aZAyPuc7jdL3TZ0oRg20HHtnD?=
 =?us-ascii?Q?73M8LPsv1W9PS5krGSN0X8jqWnPYsrHUfmhEQMLK0cdfygbZlyX7jEmFKxA5?=
 =?us-ascii?Q?T+axThCg2x1f4j4ttdpADouKQJjK6kvp3PFS3mE50skiZ2FuTvpvLhA0QM3F?=
 =?us-ascii?Q?HClQ+XwSnTX3X2LZHPlXGoMUf+Zdga1NVXOLl15O6+NWmlNI+MJkSSibs4Tc?=
 =?us-ascii?Q?VF7UD1QntCvoIBtsXO3wztfvZgZnR4p12C+zkPJLv7nHOY1XIJDETeV2wW/0?=
 =?us-ascii?Q?tXg2GgR0ljiIVAJ3CesYjgJE220as+3UUrkq1FVOfp2vpqhsuaO65JRiFnXL?=
 =?us-ascii?Q?Lfpl91TNxSpG/FqO4Pqka/ZiEyqO+3g4S5YDU21CDVn/G1ths4bKKghtxaSq?=
 =?us-ascii?Q?a5+VTIbXbhmi+WEvCDR8E7cSgsuRJGbNir5RbPAqoepbztFo843L0Zr1XCOR?=
 =?us-ascii?Q?BqJe3FjWhVwiO/zwqRbjwqugGYsyChwfCqwstoTIeY8eVyH2cBTGFWeBNmQ7?=
 =?us-ascii?Q?i2GbSFZNOcIYXEegtWTm2D6KHoyCUEKLh8uPewPDSuaB06XdACfV5zZwda1A?=
 =?us-ascii?Q?FnBfyEiTjnnmAMd23CffYqTgpsF9+06K7O9U7lg6oiU+LueJ+sAPL2vEAXWX?=
 =?us-ascii?Q?taIAHX5GuPH4ACTdMiw9ppZucSR8YDk4hXLG0ON4JxlkU2grYCmQ4054kbuC?=
 =?us-ascii?Q?OBDEZ0chrAgtGzZkAds8b3Y8yfxVcqwUf6+j5BZZOx8L6Fm+7sCGsxAZoMk7?=
 =?us-ascii?Q?drlIT+/hsZ2I1WvX5DcmXaDY8lUL+Q6L3kQOv/3etAPsf+EYW/BZmzmgZfJi?=
 =?us-ascii?Q?eEP6MTrWUBBKqyRADXMABN9HvZunuH//tfg5/M9Z7bG52x35e59B0daqe/bF?=
 =?us-ascii?Q?35jtgtw43FqgladAPQGZI+KwLaiXjIGyl7K1nXbsmeuBB6hb0DK1gdyWG71W?=
 =?us-ascii?Q?0MXr9C+GJAcRfcv1J9XLtPjvVa4itrN73wSfBDwjQqzk/WyGYFR03wZkTghj?=
 =?us-ascii?Q?xPkEVkhlNkUhxMA4UCbATxunLb2mE+QQw1b08isNbUXG2woEci3w/AClb13e?=
 =?us-ascii?Q?UCyJIjFsoZ/8WfrIVftlQdjkK8UnKoC9uzwKjJQhDwSfyOkkpSjMz7ptOW0a?=
 =?us-ascii?Q?l+ikgawmzwuAY0UBxkr737fFVopQiEcwHZL0wcBX5I6+u9cDDDswJoxK4PxN?=
 =?us-ascii?Q?Y8in9jumoJKCquwI+Dhcbbk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514434A94141F33C4C265D00F7709BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305a08dd-42dd-4cf6-1114-08d9bac3fc06
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 03:28:35.8343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdF4pqd3z/0exS5H5ZxOa4qj9fa9kQmFLzf/Kdq+R4cUMNVkxHTJRXE6jAmm3vtgdCr2bE/HGdkGKBAbpZmAhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514434A94141F33C4C265D00F7709BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Wednesday, December 8, 2021 8:51 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Liang, Prike <Prik=
e.Liang@amd.com>
Subject: [PATCH] drm/amd/pm: skip gfx cgpg in the s0ix suspend-resume

In the s0ix entry need retain gfx in the gfxoff state,we don't
disable gfx cgpg in the suspend so there is also needn't enable
gfx cgpg in the s0ix resume.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 5839918..185269f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1607,7 +1607,8 @@ static int smu_resume(void *handle)
                 return ret;
         }

-       if (smu->is_apu)
+       /* skip gfx cgpg in the s0ix suspend-resume case*/
+       if (smu->is_apu && !adev->in_s0ix)
                 smu_set_gfx_cgpg(&adev->smu, true);

         smu->disable_uclk_switch =3D 0;
--
2.7.4


--_000_BL1PR12MB514434A94141F33C4C265D00F7709BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 8, 2021 8:51 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Limonciello, Mario &lt;Mario.Limonciello@amd.co=
m&gt;; Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: skip gfx cgpg in the s0ix suspend-resum=
e</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">In the s0ix entry need retain gfx in the gfxoff st=
ate,we don't<br>
disable gfx cgpg in the suspend so there is also needn't enable<br>
gfx cgpg in the s0ix resume.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 5839918..185269f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1607,7 +1607,8 @@ static int smu_resume(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* skip gfx cgpg in the s0ix suspend-=
resume case*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu &amp;&amp; !adev-&=
gt;in_s0ix)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_set_gfx_cgpg(&amp;adev-&gt;smu, true);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;disable_uclk_switc=
h =3D 0;<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514434A94141F33C4C265D00F7709BL1PR12MB5144namp_--
