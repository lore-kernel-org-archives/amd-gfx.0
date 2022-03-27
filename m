Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D485C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Mar 2022 14:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3976810E04A;
	Sun, 27 Mar 2022 14:54:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 880A610E04A
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Mar 2022 14:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOkSyG16PHWMkOLQUOngv+dwHTgZ0vTZYvwvTcxzADw3fCXosePbj8lwss1z4D1+Wau44Pf2umT1lucLJIj2PXIDcS1sv/G++fxH+tQUGnnSa68hCbbv3iELQS0vfYVQMOWMU0Th9UFF8CCzFx2AtgrHheBmpEzZF+W+kVyfjhGj4LXKnVGvJ6EoXctSqk0XqvI/GImX9bTrzHHXQVgpiEGP24NCXf5UccNtydgEEG6cTietlHkrj2CkIdv1jXv9N3cfALjf/YtZp4OLE7I2P9ikwGwV86eT2SwUE5973oZYQvD6OJqEvSANFCuQ0t6/jsHKZtWTGnw1wVbUiTfEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRggbrggJGanEcdY12ZG1DxbQgC9/YfZOt65EyJjH4g=;
 b=fsQr0fK86fBokf4c/wnfNh+/joLt3z55GGaA1UjO0CoAujiPaNmx6E658O0iXZW2nhM7v8jCoQoqO2TPC3s8FKF2nP2gD+HMXbTf+hJSkGJEQE/XAkQjoMD/pngqIkLWWSRBjyjfh57ElMRoQ2E9wpscDZkgkdOSNhW99MLIAQPmO5nlfot0mlU2E4hNvvTgQlug+eyPzvopLcytGZEr34OSCDuXyFDmaj3NFXnFqzxPWS6iZoaLttb9lw+/23vHFETXmpVB5l6OMnpuS5cs22pJJr2pqRUapBwkWzYUYRdI07Z08nNYf3x/GfJRfaErXh06ITlk+WdJ1tXf1rR6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRggbrggJGanEcdY12ZG1DxbQgC9/YfZOt65EyJjH4g=;
 b=nfJGlRpEDGI81+tHtAs/T4HKeUk8MEkSeD/3QN33Rz6P82/0ywnR2hP65oLPq9/9LcuLsQ8PeAPLD8rkEYd7UdVzfLD5XXTD+UGHe3RPDfgRRV2aMHevrfFM67HDKGszkWvpCpS1O7DmXd365lQJeOkSgaHet15Ng+T3BF1TrCs=
Received: from DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15)
 by CY4PR1201MB0101.namprd12.prod.outlook.com (2603:10b6:910:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Sun, 27 Mar
 2022 14:54:52 +0000
Received: from DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::f941:9dfe:5e3e:853c]) by DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::f941:9dfe:5e3e:853c%4]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 14:54:51 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0
Thread-Topic: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0
Thread-Index: AQHYQcx5kAspmLeO7UCx68wx8Sn0zqzTPsiAgAASusg=
Date: Sun, 27 Mar 2022 14:54:51 +0000
Message-ID: <DM4PR12MB5294624553DE60971CFACD8B951C9@DM4PR12MB5294.namprd12.prod.outlook.com>
References: <20220327111857.1372675-1-tianci.yin@amd.com>
 <DM5PR12MB17539AA139BF9BC96D1AB46EE41C9@DM5PR12MB1753.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17539AA139BF9BC96D1AB46EE41C9@DM5PR12MB1753.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-27T14:54:51.357Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 4db9a2dc-c1e0-5290-e101-834c394e3369
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98052f63-cdac-4ce6-1530-08da1001bf55
x-ms-traffictypediagnostic: CY4PR1201MB0101:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB010145F8649E7B83355425CD951C9@CY4PR1201MB0101.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 10NbVPiYez+kAr09lPDr91i+taYnEzr6jJf7VAyMRy+nyd4Qz8H6oOWlwPv3M7uKI4WYt69IsRFhA6VKMF6XED5w6TJV4zD6UKl4+OdIO/wRQVnnwXbCkKk0nmutK6X3dtok4hOoQNZJEg2ROiaLCDQIqLtDjn00OwUGcHKuFVRnlM/582t7rR+y2hWspwzN87dWW32R6T3PHXAQipgO5MsZc6q0jXkx/18hcjTRBzBfdWLUrrF+IdMYcFNttsfp2KWh8PXIMHqCnWQkbNjrxCVcE7JotSNKyqr9sTs7DWS3LE1ko7DQvHjGZR//7fnd1CGpjEvNrkkB+QpEfLP7WI4u9k0/9EIOWaxPZKuEj3M05pr+50FRZ7TMSQbHO6NxFpZdo7qIN4DrG17YOcgqoO1/LuZVgzdgs3xDndRZ97RqgLu20g3l3Z/XVsCrp+vaJNuzqRmPECpnoRlV55ZiP0Q2AAICEgZJvdPG3svE0GiEsa/K4Qat1l6F57Fd1P8TCamH7Ztb2G7jNKgIbKGVVj9GLpI6MXjM9OG6pfTy2kr4wBoeJUWgIefgb+i0/2wayei764ujaByAzaMkItQJh16M7XLt3VmdoS/2cFhVHZ5eOhIahVPauScjQn5CBZEVZIvT6hAh/sh1F9GvdlkYnaNocWbMWNy+qCc/1lKlZrb7/RPRF0o+xeFr/NYqtFow0Lwcblhov4Td6zXbvwr/2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5294.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(55016003)(26005)(186003)(316002)(52536014)(4326008)(8936002)(122000001)(91956017)(86362001)(66476007)(8676002)(54906003)(66446008)(64756008)(76116006)(66946007)(66556008)(2906002)(19627405001)(110136005)(6506007)(38100700002)(71200400001)(9686003)(33656002)(7696005)(53546011)(38070700005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LiJIc6xBMA8kzSdsPvVKxmIlrP91IxASkrh5WVaIgNJ3ln2CL8YRyH8lbDla?=
 =?us-ascii?Q?AGhkiYnSrfBsTzXvkjXwLYgy4LKB2jasG5sik8jzdhkOgwG347mUfi1l7BS9?=
 =?us-ascii?Q?20kDAc+PgXNIwggZVUQ9TsdOMj5eRZBLZcZOUBWPcHGc9ONXoF5/GVnYn9Z5?=
 =?us-ascii?Q?5u5KaqYUOvoh04GdlRGxzcjChxLwcxCC1UvOd3gJ7AGBcy/lqLTwQF3q9713?=
 =?us-ascii?Q?DqGBQwO61V+kJjRMuDKEnk3a74prT2Tw+FZWkYLNL4UTaHK9hum/akJYThWC?=
 =?us-ascii?Q?z/B17chzNTGSE5HAfmN5v2BidcMEsnXkWVfyd0t9v6eMmTqlarzlFSbJ5EkF?=
 =?us-ascii?Q?w18rUsiECeVVroR/r4Igccpc4LExtTmQJgzZTAaZ8MmBdvbwaLapPWBzmYTJ?=
 =?us-ascii?Q?sFJr/V3RibCSP8012vZWQVLPUj8ik62E925p7jq9e1EkEFnqGPTvfM5xk3Jj?=
 =?us-ascii?Q?UfD/5kuJoknk9j6GTl6lvoiUPjIpjNhCAR1Q7M6SK97WHfj8AOloaQ7YqIok?=
 =?us-ascii?Q?EqSaumiEJTinZkj5x7Vm8az3f7uowlstlssUGiZxLsvsGFFgnBddbQrKY7NR?=
 =?us-ascii?Q?/+HHxezG8UYyTKoi8GEGkQZ8MZL2Eu3OxkUQ1BA5rdBcVParHoztpEEMUGFB?=
 =?us-ascii?Q?Om2vOsZy8Dc0BqODiKXXIE8yyU+o9FGLuI4hLEg3EmUPvPH5KVeHYhC6IOkT?=
 =?us-ascii?Q?vrFpAamiCugAFdj/1ScOUu+vqQeW/8VBFqhw6nPEMtN4NoCDNOysyiUJ/FkY?=
 =?us-ascii?Q?hn00MtgPxQKxZBDbxIv/QSe8EWnufqKQ1Vk3QHOL5BaZWgjU7wggDgk1D34t?=
 =?us-ascii?Q?EajGr+FZaRus9sDpCtIakzheOTM9Z8e2Ir3Oftk93Ce6CqpeTVOlnkn73SOx?=
 =?us-ascii?Q?3A6Y1FnAPOm3hI2WEkjLjjfCh24meisa64wywkIRSPXMiuzdrLj9PJk0y46p?=
 =?us-ascii?Q?HoefZ0fZpIJHnryG7DGUh3c4Kmkry3faSDnrBjgxemIbk/iPt4B9Kc4E8hcW?=
 =?us-ascii?Q?H8hHJZKn6mAZ+hPlCxx4axNoeL9Ub8eSk2Ni2bKGBgkImXRUOYii93R3WHTe?=
 =?us-ascii?Q?zoL8gOiuyM2T+s2COmEcb1TZxMWSyyU0tI06jXLTDRLHjmQokPtUGo94XmvC?=
 =?us-ascii?Q?GJ23Fr/ELPoRScwjOiGEMrosFs/IouGqKyx/WV+9r/OlU4WHraWMtj0Ry4iy?=
 =?us-ascii?Q?EvzByUoVWZz5iK0wOpKbp70ANPgRNvIVlocP8+k8Qp6P8TgVfmhSNdFLsd/r?=
 =?us-ascii?Q?6T9+dvTt/3LS7m2ycaR/FJ8pa2/3rXuVOzLhpP45Xpv/9Jc9d16bApc8jY1q?=
 =?us-ascii?Q?bMBQET77U5a93HJHVn1iTf1znSfqprjg+H5XLgqNuZeaCcudUIMo4/07GTwO?=
 =?us-ascii?Q?xCZ/qTTKCxFMsChFhpHvJxOT7ZVmOJkGX/p0aEY9iS0fi1s71uIpy9dxomYQ?=
 =?us-ascii?Q?hptrbY5KYsl2hocOyuJmUrvsnIdYlXpoqMoXU0AllbHmgPL1KngxXAYRKAMA?=
 =?us-ascii?Q?tRBD6Pr6lBItRpP//DiXJtCuWfJW7zmUekdParxNJ/6N99cvnJ4Q2DwZx6nS?=
 =?us-ascii?Q?eQd9fJ5CmjmENu+rViwMmrSIpETWljHiKQukz3p/XmtlifIMC9zHOIhb/cxg?=
 =?us-ascii?Q?fHgc9SLsq+WKGf/J51272NCZZbOpjbnaB9EHPglYcZiu9mcKlGvqTNdadksm?=
 =?us-ascii?Q?CufCEOPkELoK6p7wsT0d4ciiao+BNyCgdk/e+dCfe6nIDdmctAZr4/UehHNz?=
 =?us-ascii?Q?gbMgcNIBGw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5294624553DE60971CFACD8B951C9DM4PR12MB5294namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98052f63-cdac-4ce6-1530-08da1001bf55
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2022 14:54:51.6445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2aN7ejwp4BfMUYx/sMOvB2Yd1/0dFmXTYpOaPMN53EzlucyJInouLG3MjJTLgdQoxIxjbRWlV90F6sFk+kL8ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0101
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
Cc: "Wang, Yu \(Charlie\)" <Yu.Wang4@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5294624553DE60971CFACD8B951C9DM4PR12MB5294namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Thank you James!

Rico
________________________________
From: Zhu, James <James.Zhu@amd.com>
Sent: Sunday, March 27, 2022 21:47
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Wang, Yu (Charlie) <Yu.Wang4@amd.co=
m>
Subject: Re: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0


[AMD Official Use Only]

This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>

________________________________
From: Tianci Yin <tianci.yin@amd.com>
Sent: Sunday, March 27, 2022 7:18 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhu, James <James.Zhu@amd.com>; Wan=
g, Yu (Charlie) <Yu.Wang4@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0

From: tiancyin <tianci.yin@amd.com>

Some video card has more than one vcn instance, passing 0 to
vcn_v3_0_pause_dpg_mode is incorrect.

Error msg:
Register(1) [mmUVD_POWER_STATUS] failed to reach value
0x00000001 !=3D 0x00000002

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index e1cca0a10653..cb5f0a12333f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1488,7 +1488,7 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_devic=
e *adev, int inst_idx)
         struct dpg_pause_state state =3D {.fw_based =3D VCN_DPG_STATE__UNP=
AUSE};
         uint32_t tmp;

-       vcn_v3_0_pause_dpg_mode(adev, 0, &state);
+       vcn_v3_0_pause_dpg_mode(adev, inst_idx, &state);

         /* Wait for power status to be 1 */
         SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
--
2.25.1


--_000_DM4PR12MB5294624553DE60971CFACD8B951C9DM4PR12MB5294namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thank you James!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhu, James &lt;James.=
Zhu@amd.com&gt;<br>
<b>Sent:</b> Sunday, March 27, 2022 21:47<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Wang, Yu (Charlie) &lt=
;Yu.Wang4@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0</font>
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
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
This<span style=3D"color:silver"> </span>patch<span style=3D"color:silver">=
 </span>is<span style=3D"color:silver">
</span><span class=3D"x_mark32y0ivcxs">Reviewed-by</span>:<span style=3D"co=
lor:silver">
</span>James<span style=3D"color:silver"> </span>Zhu<span style=3D"color:si=
lver"> </span>
&lt;James.Zhu@amd.com&gt; <br>
</div>
<div><br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Tianci Yin &lt;tian=
ci.yin@amd.com&gt;<br>
<b>Sent:</b> Sunday, March 27, 2022 7:18 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Zhu, James &lt;James.Z=
hu@amd.com&gt;; Wang, Yu (Charlie) &lt;Yu.Wang4@amd.com&gt;; Yin, Tianci (R=
ico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">From: tiancyin &lt;tianci.yin@amd.com&gt;<br>
<br>
Some video card has more than one vcn instance, passing 0 to<br>
vcn_v3_0_pause_dpg_mode is incorrect.<br>
<br>
Error msg:<br>
Register(1) [mmUVD_POWER_STATUS] failed to reach value<br>
0x00000001 !=3D 0x00000002<br>
<br>
Signed-off-by: tiancyin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c<br>
index e1cca0a10653..cb5f0a12333f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
@@ -1488,7 +1488,7 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_devic=
e *adev, int inst_idx)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dpg_pause_state sta=
te =3D {.fw_based =3D VCN_DPG_STATE__UNPAUSE};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_pause_dpg_mode(adev, 0, &amp=
;state);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_pause_dpg_mode(adev, inst_id=
x, &amp;state);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for power status t=
o be 1 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_WAIT_ON_RREG(VCN, in=
st_idx, mmUVD_POWER_STATUS, 1,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5294624553DE60971CFACD8B951C9DM4PR12MB5294namp_--
