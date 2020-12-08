Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA7DC4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 14:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F94723A69
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 14:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F94723A69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 887AB6E95B;
	Tue,  8 Dec 2020 14:07:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E9056E95B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 14:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvECgf0FZoCB7UI71U6c2S76QkBNQxeNyEHQQyaM+w9QRcsfJBAIfdHZ7sT1XVI6HUr83GSsyb9Nv+WsF6i6gPCMdnr0cPi1wk/uInWKzRoE93FrTmls2ZpH5JR2KZjx6YZu8rJlpHBRfKtKsoj98TDlaimSu0bYikPrV2JJXi/N44dNZyxLDkGBVtv0d26oZyl9qAaCMa/r/ez30RmKQhZ/vuai+0RtQ4z0aquH2E95SneXOV8VRs2cbJjb5gSE393tNTKkOsb9lSDM+vQWVZXIpK7Sya/sDdGvELB7R8Kl8+MWtIvdNtS1XD8lTGV+fQnjNPBO3M39Ew8485lU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0AAB/9nNzCivWOerS7oNVWXqNLtlnFzuX4gshxmyIE=;
 b=LJ3ijYLuDv8uIalok6FdioSCmnkhWVq4ZLAcYyifwyHkVNqM/pfFiK/ZUEPQfkTSBIr+gpLqMdhEzB/QF1DcSSmAENrzBolzO3Q9RTCknXenmbB7U3Vev5Gnh09ZCY8Mn8d6rNR6Y9afumyh75YyTQHA/raLCW1F/6rSWhqGEkyA68xyUizqUwRbR02+5MnWWqZOE0Pn1tL8ZYUPSdI/SG9m34vwIurbm++9jdNyD/gd3wkU/izd1HgypE2/lyCDfvlgCVECYdux7jwbUlMsSvcnfbKYK4Izsgknb1yYq5pqJZwudYF1u3brDBza3tqOVztcQWoaPgg1QQzSshqdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0AAB/9nNzCivWOerS7oNVWXqNLtlnFzuX4gshxmyIE=;
 b=lTKpu7vnkkNXJON2G/a6n9QZmOzoz+64ZtlZijcPHAMeivhk9VYU7gwBEQ6EI3Q97y9uojwm3nNHuu48bi8iOKLkO7ZPeZ0IHziRRRfCByFKRlB4ix7LQ4RI9doA/sAK1l1puLJJ+FgVNQIkyTHWRxf5UgGssmfEBpUgtqur+a0=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 14:07:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%5]) with mapi id 15.20.3632.019; Tue, 8 Dec 2020
 14:07:44 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Subject: Re: [PATCH] drm/amd/display: Drop unnecessary function call
Thread-Topic: [PATCH] drm/amd/display: Drop unnecessary function call
Thread-Index: AQHWzOwbTbL3ockkck25CJgH0QjZuantPQld
Date: Tue, 8 Dec 2020 14:07:44 +0000
Message-ID: <MN2PR12MB44885E1470E5CCD87689C222F7CD0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201207225523.2122889-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20201207225523.2122889-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-08T14:07:43.920Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4194b88-fb43-4ce9-35d0-08d89b82a272
x-ms-traffictypediagnostic: MN2PR12MB4160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4160EDDF1DFDB4F8D1584264F7CD0@MN2PR12MB4160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:312;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X+Rano5yuOpAkPYHa7bXw3DP0AqzgUI/q46jRAkcu9b0T24Jk/W67uzba7+uu1NUUZrb+hVGis9w6M0GLqwUHpFsjuierD9Jk1iMPvp6XiUuVeYHTk+JTnPiAbqpQimSNJeWpjHmi6H/40GzdjOgxI0UpBUqrsZlgMzyI2fUHvWEiNLnmQR3v4pV4g9Vb59c2/fYDCVbVePYLn2Zr0llNo51j4/77UfN+b5FbT5lw9UrXEjoq9LE07I1Lb9899OW+1ATbsvhPwPv1dJbXsFT39yMeI1xpOIZgJ70a3XkXlqTO+eMHo6u0SfqLKGoBegDz6X2th33PNhzudnyXC02FtmoZIIf04/6nf1Upaix6Tw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(5660300002)(86362001)(6506007)(26005)(110136005)(19627405001)(33656002)(52536014)(316002)(166002)(71200400001)(9686003)(4326008)(186003)(53546011)(8936002)(76116006)(6636002)(66946007)(83380400001)(64756008)(66476007)(8676002)(966005)(66446008)(66556008)(2906002)(45080400002)(55016002)(478600001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mIO+DezSDxw+MlMOfsKmWjEm5Y9bPY13vN135fxVfnBi16WQmM4qXrtSTRoO?=
 =?us-ascii?Q?BFZEiJZWTg7KAce1neItFZKP/BJJVj6yhVQenc5HoLO7Hk7dQCeD1Xc3ZYhU?=
 =?us-ascii?Q?1Nf6OPA2epsFBKPejykb5/M5J9D++5PDH8cc1P4nwswHPPvS0mwL8XogyY7v?=
 =?us-ascii?Q?tZL9riUKCk4I7L5htMmhP7FNeoy+3BpnBOYZICEHuQvXN7RQpCBmnmUcprua?=
 =?us-ascii?Q?ZpUyMxAXqwCYiXLsOg3wUYAbn0xsiwtGOCCxFMiYQKCCBUkcM10UepAbFIlX?=
 =?us-ascii?Q?O6EoLMPH18YWifpB4dKeFupX3BLMfCmO1W+YFW8Y1deN1335+zvKRLZwOz3E?=
 =?us-ascii?Q?5yyGWHg2hXzarDChIrYPu8f6SAMpz//4KhJGvo99foh0TDBhDxJ8yr5fU2Q3?=
 =?us-ascii?Q?ySsOVuUG3yqFb+8Z6VYo2aRTkXJh2PYF+BioFxtP/fVqs9YkieD7Ns6fZoTu?=
 =?us-ascii?Q?Ir1zZmfglP9TGP3sBgkahFUJvFqlNDU7kagSRNbQL1wHHDURPF8BHRydG6DL?=
 =?us-ascii?Q?aMtkigORsoLX89f1vEEAmbUZDN/nLrLtPyBLxSLMNFs1fl2tLY991I053Hgf?=
 =?us-ascii?Q?JgSGNQPQLKeUa7koQQV45o2bkfSl6M7j9uLsLJaQRQFq8Pd8FLWyPnbhYzEP?=
 =?us-ascii?Q?7f9xv5AJeliKQFtDevLo9CiutaUwTzRWn10epaZvuaVXwnQT6sltojNeKhLt?=
 =?us-ascii?Q?jrMCKmVOI8zWwhcD7FOMWv70iZZWNDchCNiNCwo173+em/LiiSpdG1VC2hXI?=
 =?us-ascii?Q?tB2pq0JWVO3jL5doA4mM/EQ8az6sVplIif0AEWdZiGjphV8FTum+ZWtceAFi?=
 =?us-ascii?Q?L0XUc3l5QPg2FBElkonhhzgp9ZqGkqauDQ/ABHWh0ZmJ13vGK8u5Cj8GAMTr?=
 =?us-ascii?Q?xHnERxEex/R+VleELeiVPbJNhMfu/4a4mrJkqaB1xrAtR6OVMM/3v0keodi4?=
 =?us-ascii?Q?7Q9QresfI5PfnjfEbIQDebrFLAOvCO4eLSKcgL1bK8I=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4194b88-fb43-4ce9-35d0-08d89b82a272
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 14:07:44.4441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQGamqMMYo/jW3NpHbm75D8GCYqWSqjHnE9WlSHs0kdivAxqmECeEq1h0hD4fItboJeN1GLGxgtQKldJZw/ULA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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
Content-Type: multipart/mixed; boundary="===============0899531231=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0899531231==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44885E1470E5CCD87689C222F7CD0MN2PR12MB4488namp_"

--_000_MN2PR12MB44885E1470E5CCD87689C222F7CD0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Rodrigo =
Siqueira <Rodrigo.Siqueira@amd.com>
Sent: Monday, December 7, 2020 5:55 PM
To: Wentland, Harry <Harry.Wentland@amd.com>; Kazlauskas, Nicholas <Nichola=
s.Kazlauskas@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Drop unnecessary function call

After refactor our amdgpu_dm_atomic_commit, this function only invoke
drm_atomic_helper_commit. For this reason, this commit drops
amdgpu_dm_atomic_commit and add drm_atomic_helper_commit directly in the
atomic_commit hook.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a37948f2e596..c89066b1c471 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2212,7 +2212,7 @@ static const struct drm_mode_config_funcs amdgpu_dm_m=
ode_funcs =3D {
         .get_format_info =3D amd_get_format_info,
         .output_poll_changed =3D drm_fb_helper_output_poll_changed,
         .atomic_check =3D amdgpu_dm_atomic_check,
-       .atomic_commit =3D amdgpu_dm_atomic_commit,
+       .atomic_commit =3D drm_atomic_helper_commit,
 };

 static struct drm_mode_config_helper_funcs amdgpu_dm_mode_config_helperfun=
cs =3D {
@@ -8158,20 +8158,6 @@ static void amdgpu_dm_crtc_copy_transient_flags(stru=
ct drm_crtc_state *crtc_stat
         stream_state->mode_changed =3D drm_atomic_crtc_needs_modeset(crtc_=
state);
 }

-static int amdgpu_dm_atomic_commit(struct drm_device *dev,
-                                  struct drm_atomic_state *state,
-                                  bool nonblock)
-{
-       /*
-        * Add check here for SoC's that support hardware cursor plane, to
-        * unset legacy_cursor_update
-        */
-
-       return drm_atomic_helper_commit(dev, state, nonblock);
-
-       /*TODO Handle EINTR, reenable IRQ*/
-}
-
 /**
  * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation=
.
  * @state: The atomic state to commit
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cbbf5c6ea7e2f4e32d50d08d89b033b75%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637429785490973923%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DV5Wg2XgI9zUCTH0OhTSr3Oky8PTvy8XYIa3eAhVDnlk%3D&amp;reserved=3D0

--_000_MN2PR12MB44885E1470E5CCD87689C222F7CD0MN2PR12MB4488namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Rodrigo Siqueira &lt;Rodrigo.=
Siqueira@amd.com&gt;<br>
<b>Sent:</b> Monday, December 7, 2020 5:55 PM<br>
<b>To:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Kazlauskas, Nich=
olas &lt;Nicholas.Kazlauskas@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.P=
illai@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Drop unnecessary function call</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">After refactor our amdgpu_dm_atomic_commit, this f=
unction only invoke<br>
drm_atomic_helper_commit. For this reason, this commit drops<br>
amdgpu_dm_atomic_commit and add drm_atomic_helper_commit directly in the<br=
>
atomic_commit hook.<br>
<br>
Signed-off-by: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c&nbsp;&nbsp;&nbsp; | 16 =
+---------------<br>
&nbsp;1 file changed, 1 insertion(+), 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index a37948f2e596..c89066b1c471 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -2212,7 +2212,7 @@ static const struct drm_mode_config_funcs amdgpu_dm_m=
ode_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_format_info =3D amd_g=
et_format_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .output_poll_changed =3D d=
rm_fb_helper_output_poll_changed,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .atomic_check =3D amdgpu_d=
m_atomic_check,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .atomic_commit =3D amdgpu_dm_atomic_c=
ommit,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .atomic_commit =3D drm_atomic_helper_=
commit,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static struct drm_mode_config_helper_funcs amdgpu_dm_mode_config_help=
erfuncs =3D {<br>
@@ -8158,20 +8158,6 @@ static void amdgpu_dm_crtc_copy_transient_flags(stru=
ct drm_crtc_state *crtc_stat<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream_state-&gt;mode_chan=
ged =3D drm_atomic_crtc_needs_modeset(crtc_state);<br>
&nbsp;}<br>
&nbsp;<br>
-static int amdgpu_dm_atomic_commit(struct drm_device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_atomic_state *=
state,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool nonblock)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Add check here for SoC's that=
 support hardware cursor plane, to<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * unset legacy_cursor_update<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return drm_atomic_helper_commit(dev, =
state, nonblock);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*TODO Handle EINTR, reenable IRQ*/<b=
r>
-}<br>
-<br>
&nbsp;/**<br>
&nbsp; * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implement=
ation.<br>
&nbsp; * @state: The atomic state to commit<br>
-- <br>
2.29.2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cbbf5c6ea7e2f4e32d50d08d89b033b75%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637429785490973923%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DV5Wg2XgI9zUCTH0OhTSr3Oky8PTvy8XYIa3eAhVDnlk%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7Cbbf5c6ea7e2f4e32d50d08d89b033b75=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637429785490973923%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3DV5Wg2XgI9zUCTH0OhTSr3Oky8PTvy8XYIa3eAhVDnlk%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44885E1470E5CCD87689C222F7CD0MN2PR12MB4488namp_--

--===============0899531231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0899531231==--
