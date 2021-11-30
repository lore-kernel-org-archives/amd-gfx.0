Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0037EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 15:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FE76E97F;
	Tue, 30 Nov 2021 15:10:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632946E97F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 15:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFxmIkJtgzEKmXM9NjI++U2Ma1EhIPnoLVyi8ohyUOykI/Pa4mGz7mMdU+bLYrZE56KdGd902kNkFqzhpQZhhN7+vMcKeyEQ246ka89wk/tl0iDM5M0OxUubtAiRnyN5X/3oJBguBBtYp0kf9yRYFoi68crypiuCY/rOVZtlh1b63ztLb2Kp1pcTMDKMwstnvlgdgzRKXCQOtQ1qI/FtnmnlhnvFyNU1YXQH2b0lXCJAJV3p+AEqjIYeh+GeCeOezxms2xXPc98Oxt5HYLcgLoh+u721FD8wbRGzwbAHJ62Rk/8VeFK2dmaLEsBx0XMgRQ6cUepvtt7zWds0d5YXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbNntK7/9B7TBRWgp/6vaawI7BPyRI1t0a7oYULr9RU=;
 b=XzlVlPFM5bj/sXLensTl+IGAe1tmkVhDmo69Ty+Dr/ziXEkT1d+XA7HeNhcUybrGVSKQxF94OqiZFcIhK4l+2SPFZohoivHALZW5bI8hrIlrxU67wmhMyEHSmzLy5px2Qpb/T7PNyjtBeV65vwWTMCMZL+qbIQFgHTXLICOtqv8bWG/ocdOS2SDA5F6VU5VRnIiXibgJE9gWkgXPMMWn1cW42U47BDLyvsm1iS6VSoj50dYgyy4+7UJNNuXjLqpHD2aj0vDOhyVsB+QRuXNMDzzTDENQBzU7RfiiVFRVQKs2z5Evp8p2NYDJ2qCP9iU/JKW15u4gyRcJNOn1aHY4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbNntK7/9B7TBRWgp/6vaawI7BPyRI1t0a7oYULr9RU=;
 b=P6LtCYYWb4XZB+fu5JIRfsOeF+JOXdsLELXqRetiqEX5R8ggvuywOxJWaUKZgJJi3QR5y0GT0AgvSHxZL4K3Izv5R1x9uTEhNT3O1LQkeQawQ0VN9OAcx+5NIwr5yd0QcEBFjY1Zh0EOYvlbaFY2O4NixZC6rWilsbp0r4AZiBA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 15:10:13 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4755.011; Tue, 30 Nov 2021
 15:10:13 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/display: Only set vblank_disable_immediate
 when PSR is not enabled
Thread-Topic: [PATCH] drm/amdgpu/display: Only set vblank_disable_immediate
 when PSR is not enabled
Thread-Index: AQHX5foQxoewQNsIR0u8jq7EOqlIJawcLKey
Date: Tue, 30 Nov 2021 15:10:13 +0000
Message-ID: <BL1PR12MB51445B3ECF29596AC59D3CC8F7679@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211130145333.38917-1-nicholas.kazlauskas@amd.com>
In-Reply-To: <20211130145333.38917-1-nicholas.kazlauskas@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-30T15:10:12.461Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: b485cab0-89a0-e729-243c-7bc54fe86096
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c847ceaf-2ddc-4622-1af6-08d9b413825e
x-ms-traffictypediagnostic: BL1PR12MB5176:
x-microsoft-antispam-prvs: <BL1PR12MB51766E5C589515A760DAF4ADF7679@BL1PR12MB5176.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Di4FJ9UeTMbGlEd/GO0xLtetLf3B2P/elNh9CktTFKtrvyfZW69tZDYG7hdwEb+8qIjr4ZxuHMARyimlBhWWW/iS+YAgdK6UFOd2Yrbtl3gr1ttza2+LsnUoXdzytEzkl8gT8a/u3uCrCiMy3JjHGPh4Omk1Qw3ColKeV0mbYh6e6cdAJKFSTz5maCqhG5r4YtxLEZwLgStZFtpj+T/vz7mZBmMyoO0EYi+QLbFaUehS36cw93c5ExCHtgTv3JcmEER9FcHzfz+693RF1NpLkaYwpGUXckGhH0tePvh3Dc02ibpPSpX6nECZdFD/v8M2MQfykT4p880GcDbip+gaSMrXWYqrvdEojINpiNxczMDV8UIRxXPfuM2kY/GedHwfAZpiU4VApvv1dDQnhNWvpgaORwiymqbi81S8L0t6Wm3EAGPz6o09YWkA6hPUHGk7QFKaIcnA++nHOULz12oM1B0JQSzyjpxxMyRQ7d/oUCYgQ4YlEt/knoWJnnqr++UZLX5E9rTF6uVPe8hHokNTLhuzpistfb0hV+p/44VaKV06SyS2vB6yIgEg6K856zLamCoq2YgRkdV1ll5bd5yHQ01h4a4mOGjxROCTvVgiMSQ307f6cC3WfFYNT7L5C++2RiLcYz+8a0RaxGBNiXWm33zyzExQefoDuVUnOGO77KxAtKZ1lDhWHtsRMVmI33GR3YLk76tEYYocgReRodP+B1uJ6Na3ozGVExWZKlwgWkI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(38100700002)(71200400001)(186003)(2906002)(6506007)(83380400001)(5660300002)(33656002)(7696005)(316002)(52536014)(4326008)(19627405001)(86362001)(8676002)(53546011)(508600001)(55016003)(76116006)(66556008)(66446008)(64756008)(26005)(110136005)(8936002)(38070700005)(9686003)(66476007)(66946007)(14773001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?29GXnMprO+cgAozr7E543bv4NA+VcSc6YKtgkdpNRxv23Xzd9+xwNKAM7pOc?=
 =?us-ascii?Q?+hwcRKiP27aYh0CvWf8vLwYkkMMFqaUXqbVpX1xI5fdjul47SbecbZx7aA6K?=
 =?us-ascii?Q?FUZ8hn0gv1unLxiU/alOAsjmBk+x0obC48kfYQnfXWFQMZT+jB32CMqCy4KJ?=
 =?us-ascii?Q?JoimEcHssKRO6lu1CcQ5DeGcSO6BUWbFj13CV2W7DSI+jdyRKlgmDYM4kGay?=
 =?us-ascii?Q?vX9UlZNl4iRXPW2N7R/5GY7w+yqTNzdPy8VPT8ZEqdnS4c/7sEF5JQNTG1Jv?=
 =?us-ascii?Q?n2lLXK39Q5XWQkOM7VahMjv92Qa8TShknBbWQfTz0zhPrxqXEsJL/c6BGdxI?=
 =?us-ascii?Q?6t7xn30DFvKJNK9gyAu7QDLeiFp3m65FyMF4hBA54w6x3L81CwUnIn/yiR97?=
 =?us-ascii?Q?WrYarRLtfVQ5w1aVs2EEGSwHTDtQMepGYXqdMGK6wJG9sEIa//RNovAn/tNH?=
 =?us-ascii?Q?Jj8ZQLFNTtgVs/N8V5EP6Edrl0YYKA0T4AT7pPuI2NJDmZ8acJf1izSBOKq6?=
 =?us-ascii?Q?Mo3a2HVrm+FaYtib0iezwZ6Fhphr0OTgW6AUU8loyF6CU/6zNRQOrd0mBFXX?=
 =?us-ascii?Q?opdTNKiUq3414AInn9m/Qx/OUwigvIGO+ZHeZIlFxqAMnXxVw/pPaaTF4r+m?=
 =?us-ascii?Q?RSWoydnifyYUiv4D+au32y97SykNI5794Skqw0ZYxlFYsyXkKNsijRpUhe2V?=
 =?us-ascii?Q?nhc6EZlwJFOLqdeJaR6Z+rr7tUvh2+g0VLLyW9nY3C94+ndZ1nU+ftwt/Fl8?=
 =?us-ascii?Q?ALfO/oMq+WDfiJkO6ttkRIEpwD/pTZl8pIykiWx63Z1Ke+IkoYw8QJuqjj/X?=
 =?us-ascii?Q?1Cqkv8MfXfnAocsRo/hQ3pI+JHp1q4QFvcmcO6898KWfUld0j1pj3GHpvYpt?=
 =?us-ascii?Q?GZ8iJAdM0Ip/LP6ZQ/Q096b/aNbj39Kcko3zKVKoI+AKwN22sFfaomExmJkx?=
 =?us-ascii?Q?ScUqYM7qZfGRTKQXZJ8Aa5IXkGh4dMwM2Yca4fxKrbb8UIU7x9Dpo0P3/AkU?=
 =?us-ascii?Q?7xOKAXoCDCYZjOuBfkxdS/r1jJwnZ9PUMorBkYqGQVBGyAfO0ub0ltTbFbu8?=
 =?us-ascii?Q?fuuQ5j1eejI9nM4neg0J8oP5t1FQfy6w1YVzR4ks5Ws5C2DWDFrv4k8xk5Do?=
 =?us-ascii?Q?NcPAzn0rtMy4oi6dvRT0UXrOkIbcLepA7oiMMd2wLpKD70ImcMW0x2hL1ZGv?=
 =?us-ascii?Q?PxjbMsqJOSUv/SWMN7ncsEMOzfn7TgrJh4SkfaYIZNj2yHR2tXlc9XPAaWPR?=
 =?us-ascii?Q?EUfp2PNeFNioYvLkbhHx7AMmhs/q3nelw22nHfsQhoELeNhfuzLmgxQz40ZM?=
 =?us-ascii?Q?XySr194d6tmI/3AM5PmFBDG6179by24TywwMtcbCJs3OpdcG1Dt643MsglAx?=
 =?us-ascii?Q?tHKr+sN7cPea4YqP8XUKkdbubeR0S8kAnXzUXZVUMtPvzwwrcEHlM4W4wSwr?=
 =?us-ascii?Q?u48pUoiS50+yxapPTMEenAf6Nl0dMc0QDy4PTU1kze2wigAs1HhosyMKd4Nt?=
 =?us-ascii?Q?rBJLbAxga1vpxReEEH1r4Lsb1dDifam09tgJ0VM+LktJJD4h6w8mgkFpvs5+?=
 =?us-ascii?Q?rGfc3wz0zLE83DzEkRfsm+kMEXU56yD2NVac5vsZ+k0JwiOal7bZAwEn/MYa?=
 =?us-ascii?Q?X07L9ewIsJo6xJv3seUxYPY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51445B3ECF29596AC59D3CC8F7679BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c847ceaf-2ddc-4622-1af6-08d9b413825e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 15:10:13.3054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UajfHGxffUcnBzAbfhqF2m4r16dQeyC+6qaPg03z75Fhci6r6S1miwEuQwYkobKLkTXwANXcETSSJzwzG4GmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51445B3ECF29596AC59D3CC8F7679BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Sent: Tuesday, November 30, 2021 9:53 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Wentland, Harry <Ha=
rry.Wentland@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: Only set vblank_disable_immediate when=
 PSR is not enabled

[Why]
PSR currently relies on the kernel's delayed vblank on/off mechanism
as an implicit bufferring mechanism to prevent excessive entry/exit.

Without this delay the user experience is impacted since it can take
a few frames to enter/exit.

[How]
Only allow vblank disable immediate for DC when psr is not supported.

Leave a TODO indicating that this support should be extended in the
future to delay independent of the vblank interrupt.

Fixes: 3d1508b73ff1 ("drm/amdgpu/display: set vblank_disable_immediate for =
DC")

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0747dc7922c2..d582d44c02ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1599,9 +1599,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
         adev_to_drm(adev)->mode_config.cursor_width =3D adev->dm.dc->caps.=
max_cursor_size;
         adev_to_drm(adev)->mode_config.cursor_height =3D adev->dm.dc->caps=
.max_cursor_size;

-       /* Disable vblank IRQs aggressively for power-saving */
-       adev_to_drm(adev)->vblank_disable_immediate =3D true;
-
         if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_nu=
m)) {
                 DRM_ERROR(
                 "amdgpu: failed to initialize sw for display support.\n");
@@ -4264,6 +4261,14 @@ static int amdgpu_dm_initialize_drm_device(struct am=
dgpu_device *adev)

         }

+       /*
+        * Disable vblank IRQs aggressively for power-saving.
+        *
+        * TODO: Fix vblank control helpers to delay PSR entry to allow thi=
s when PSR
+        * is also supported.
+        */
+       adev_to_drm(adev)->vblank_disable_immediate =3D !psr_feature_enable=
d;
+
         /* Software is initialized. Now we can register interrupt handlers=
. */
         switch (adev->asic_type) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
--
2.25.1


--_000_BL1PR12MB51445B3ECF29596AC59D3CC8F7679BL1PR12MB5144namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicholas Kazlauskas &=
lt;nicholas.kazlauskas@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 30, 2021 9:53 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Wentla=
nd, Harry &lt;Harry.Wentland@amd.com&gt;; Deucher, Alexander &lt;Alexander.=
Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/display: Only set vblank_disable_immedia=
te when PSR is not enabled</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
PSR currently relies on the kernel's delayed vblank on/off mechanism<br>
as an implicit bufferring mechanism to prevent excessive entry/exit.<br>
<br>
Without this delay the user experience is impacted since it can take<br>
a few frames to enter/exit.<br>
<br>
[How]<br>
Only allow vblank disable immediate for DC when psr is not supported.<br>
<br>
Leave a TODO indicating that this support should be extended in the<br>
future to delay independent of the vblank interrupt.<br>
<br>
Fixes: 3d1508b73ff1 (&quot;drm/amdgpu/display: set vblank_disable_immediate=
 for DC&quot;)<br>
<br>
Cc: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++++++---<br=
>
&nbsp;1 file changed, 8 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 0747dc7922c2..d582d44c02ad 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -1599,9 +1599,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev_to_drm(adev)-&gt;mode=
_config.cursor_width =3D adev-&gt;dm.dc-&gt;caps.max_cursor_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev_to_drm(adev)-&gt;mode=
_config.cursor_height =3D adev-&gt;dm.dc-&gt;caps.max_cursor_size;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Disable vblank IRQs aggressively f=
or power-saving */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev_to_drm(adev)-&gt;vblank_disable_=
immediate =3D true;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drm_vblank_init(adev_t=
o_drm(adev), adev-&gt;dm.display_indexes_num)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;amdgpu: failed to initialize sw for display sup=
port.\n&quot;);<br>
@@ -4264,6 +4261,14 @@ static int amdgpu_dm_initialize_drm_device(struct am=
dgpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Disable vblank IRQs aggressiv=
ely for power-saving.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: Fix vblank control help=
ers to delay PSR entry to allow this when PSR<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is also supported.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev_to_drm(adev)-&gt;vblank_disable_=
immediate =3D !psr_feature_enabled;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Software is initialized=
. Now we can register interrupt handlers. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_SI)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51445B3ECF29596AC59D3CC8F7679BL1PR12MB5144namp_--
