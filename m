Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD0CC2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 23:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79ED21556
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 23:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kmt5uaiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79ED21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6566E917;
	Tue,  3 Nov 2020 23:33:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 002976E917
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 23:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us9wBb+LpbDp/bR6ZnL986ADlBnxLKNA8svW/bTAg2GvmjXFJzyOLKbErEaGFXkJ4hViAbogmcnomJQVNZv6iOLv/OSowEtdYiNAd9PEHhSx4OIdnlB+EZgMWIFDWjCy/Avs5rllL3xXPgGLyFohy6lwHUBxLiRDgxYhNdON/mrANm5crB+dGy7S9TkM89lqML4pWIfVFtZqAmNxy90KQue0W+Fxr7QDw7vgxJFkOAKlemMvVhfslfNaUG88YqxH8XzMGbKv6h0Xmuim9BXkF6rt+lY5dsedOgBKuZpoWOWlHBRMk+9iTO279/TUl5KTaqPBjG6gHoL+kVHL56tm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LaxraK4mspY2W79L8W9L/RktGn/94y5rdUtyu3USBs=;
 b=nfJFUL1ZIauw2ivx9BJpNO7tKp8rL0w22Sd8RSu9nPu7jBfm6tmunLezE/whdzXbuAKHtM7oZ7VuTbdQdkoMG4h5jmYbZlArJRDSpWLD+d5qupzK+ZGsi/tpE9t5jLtvMlQq3yaWsw24nhHQP+3SBFx52R1N4fNo2sq501yxwGOPdFyyan9RCDLWzuTF3ARIuRVgBCWkMaJTpIPBC+WV7c1XllIWZuKT3DZIY7g5POFJvHe8/VQ4Wq+xAyQ1UHCig7DCw5L7PzmNHOyTlDRbdQw74qUs40/pLaHKJk5xqMjfasg7rYe431X+efWhOdClntOOxOfhRPUryx1Nn0cjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LaxraK4mspY2W79L8W9L/RktGn/94y5rdUtyu3USBs=;
 b=Kmt5uaiLmL5WUtvhuHOyClJjQy4lPo40gI1djDnlqTdc1NOm97O8r9DO4c+MmV2FCQ2tAvJ+ghe9hdbmOfPALt3bEXY6XQTeLjf+tYPomCTmXk6PKsrZsEcznTtirgoSG/dnsRk25UY5m+aPvAa6OdqbrfAcQDviTjlrqraSYrQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 23:33:42 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 23:33:42 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Quan, Evan" <Evan.Quan@amd.com>, "Siqueira, 
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix psr panel lightup
Thread-Topic: [PATCH] drm/amd/display: fix psr panel lightup
Thread-Index: AQHWsjbb6BSJEIXo+U6BAKA1qBoFLam3DwnU
Date: Tue, 3 Nov 2020 23:33:42 +0000
Message-ID: <MN2PR12MB4488ABAFAC244DEADD36D2EEF7110@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201103231228.26376-1-Roman.Li@amd.com>
In-Reply-To: <20201103231228.26376-1-Roman.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 650d4269-3d5f-4862-88d3-08d88050e6a2
x-ms-traffictypediagnostic: MN2PR12MB4160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41606B9C8B829B26A293D29BF7110@MN2PR12MB4160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ykoaFLAzGLnN12TRwiLhv3t0Jn3iuuH2fGfAMwJZraynZJ4hBgFcq+xlQEkHuuDCJa7fySXEpaXKZuBwQc+95kbSb/fCK59rpDEy20hu3LGLWHsBm/pzPq+AOpfjU1nf8AWF7q4Vr8D5IB+87mtm4IBVXDrAyZW7RkEV3I4iPlMbmPDBVghS+TLXbHW+F9Qzgg8X/r4OSNXhfmmzumsYZ4P8h4/IvbyfUsrWNRNTLt3OjsQcew6zaKyl6Gp9iv2MMhjSbs+uwUYqMmA6KjgGRgIWl8q0RL4KB31xkoAGbqCw0fwrNhVArhfOMf7aixGKWqdWHbJwyYlTy88Ue1EwaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(66476007)(66556008)(66446008)(110136005)(66946007)(83380400001)(64756008)(19627405001)(316002)(478600001)(76116006)(33656002)(55016002)(5660300002)(6506007)(52536014)(6636002)(53546011)(186003)(8936002)(8676002)(86362001)(7696005)(9686003)(71200400001)(2906002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 7HiQTGCxq3JFP7F8lE0c++omFxRXhhktT79J/YUCzEnPvQ3ykpzRdCKXsUVHkhXHMp65w9KGFr4ET1YElfR/+H8yqaTcTwQVrJzjYlfdCx0XvBQZ+j20rZBcHZ6bJL1DVSKBbbgLrkorS9RTCJ30TF9CEY96XRfIl7UTejrUIAA6VqywOQYvwr1qgpp3J8KCe+TOqX6wd4CjlWeOy38U7dx+nXStNSBA5egOKAMErLfpcn81tprqlosV9xG2GPOu0vhHIcPgVHl5RAZeEAUn6AaE1NwfVIxGNrHe4k6vklZ2e9CemOfZlVhou4IA+A6H1B1mZwK/EjlYPhojLRxUnu9HkewjP+BQP0n1ZzOgzKXURngTWId+oV8/IWzIpnyJagPws78o2lDmqeNo+9wJ3gql5WLND1kQ1bnIGpGB2OiW0yk+FHpZ5VWqAFPQD46YA+7DL1EdLSfjVYao8x7al9fned6ZRB6h8sBamNPNx5sfq3inCmk6EoyH7HVWn7HnEp2kuQzf9a2CwA/RS3EtFel6arhzU+EcwR98CqBRv2B3VD2WpUjV77OiCyd3Md8kDZfhYcEAQfzLyR0qdAwAU/d4/L0Z5waV2QZaWeaqTHw+/U0VdNbm6C1DWOBsoc3HlvFF9EES2bKvLhAaLsjnfw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650d4269-3d5f-4862-88d3-08d88050e6a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 23:33:42.6313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9dx/ZOyBtcFpgULgR7n5kGbR92pcbKc3FCAnzbqdFjyoVcsDoMvyeC4I/5vHjhC+OgwpGQolGj/4UoRW3OCmQ==
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
Content-Type: multipart/mixed; boundary="===============1745668277=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1745668277==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488ABAFAC244DEADD36D2EEF7110MN2PR12MB4488namp_"

--_000_MN2PR12MB4488ABAFAC244DEADD36D2EEF7110MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Tuesday, November 3, 2020 6:12 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Siq=
ueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pil=
lai@amd.com>
Cc: Li, Roman <Roman.Li@amd.com>
Subject: [PATCH] drm/amd/display: fix psr panel lightup

From: Roman Li <roman.li@amd.com>

[Why]
The change for correct asic type check
caused a psr regression due to incorrect
chip family id for Raven.

[How]
Use correct family id.

Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c
index 6b8bc8dde6ea..09b51fca3d44 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2740,7 +2740,7 @@ bool dc_link_setup_psr(struct dc_link *link,

 #if defined(CONFIG_DRM_AMD_DC_DCN)
         /*skip power down the single pipe since it blocks the cstate*/
-       if ((link->ctx->asic_id.chip_family =3D=3D FAMILY_AI) &&
+       if ((link->ctx->asic_id.chip_family =3D=3D FAMILY_RV) &&
              ASICREV_IS_RAVEN(link->ctx->asic_id.hw_internal_rev))
                 psr_context->psr_level.bits.SKIP_CRTC_DISABLE =3D true;
 #endif
--
2.17.1


--_000_MN2PR12MB4488ABAFAC244DEADD36D2EEF7110MN2PR12MB4488namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Roman.Li@amd.com &lt;=
Roman.Li@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 3, 2020 6:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan &lt;E=
van.Quan@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; P=
illai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Cc:</b> Li, Roman &lt;Roman.Li@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: fix psr panel lightup</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Roman Li &lt;roman.li@amd.com&gt;<br>
<br>
[Why]<br>
The change for correct asic type check<br>
caused a psr regression due to incorrect<br>
chip family id for Raven.<br>
<br>
[How]<br>
Use correct family id.<br>
<br>
Signed-off-by: Roman Li &lt;roman.li@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c<br>
index 6b8bc8dde6ea..09b51fca3d44 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
@@ -2740,7 +2740,7 @@ bool dc_link_setup_psr(struct dc_link *link,<br>
&nbsp;<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*skip power down the sing=
le pipe since it blocks the cstate*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((link-&gt;ctx-&gt;asic_id.chip_fa=
mily =3D=3D FAMILY_AI) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((link-&gt;ctx-&gt;asic_id.chip_fa=
mily =3D=3D FAMILY_RV) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ASICREV_IS_RAVEN(link-&gt;ctx-&gt;asic_id.hw_internal_rev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psr_context-&gt;psr_level.bits.SKIP_CRTC_DISABLE =3D =
true;<br>
&nbsp;#endif<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB4488ABAFAC244DEADD36D2EEF7110MN2PR12MB4488namp_--

--===============1745668277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1745668277==--
