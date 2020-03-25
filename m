Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4087DC2D0E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 19:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B0520719
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 19:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0szGSjQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B0520719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A746E0DF;
	Wed, 25 Mar 2020 19:28:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8AD6E825
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 19:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BusmleDqEEsWQgDH69zusqhu1vwZvsEbKUmn1cmc58EPesXIsk/iYGqYMryqYB3pFZ4KvO7AIz5HNuRaut2Xzrig/qCy0ZwDdSK+aQi0XRxJoAVB5Ff2IX1xRlp6kyK/NBxQmPcooqCjpq42GrTrlcQ+KCtyU5E0RxWCU6SOK3T+fUZA9503juTeECwcPUuFoBRaoQLOHl4vRW4KCl1q0M5ykdn1QzltR/obLZH2/MAhpE+/oZzBva50KOlkjPmUvDYOHlqPKYAiSvonN618xpGaIasPEyFNCbHl7hBQ3n8p4KJeg9kplFyBiHJkH5Go3lpqD6BHa1DPdbkImXrd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYg1eSQ01HQ0Rr/n2wecqdnE8h9PJexEHF8VrHjl3vI=;
 b=VksRsXoU4IJkgphWwcr+kX4BZKqFdChptkD1dYR5rlT/elmQbZDAiQd2Mc/r19RM9e2NF2KVHvfD7AmQORK04My+UIg7n/8b3+DGwpPbNy6Va/n1qT7KrK4WB9MLOV2YPj3YzyJc11S/OcQ/OxPu4ZL6aGeMw560q3+oJATGf75tEUMnehKEvKQ0SxP3VopDKM+xh7pBy1pnr6QSLeDJhlNZbW1oIMRBF5X8hvc822rwbKMDU9yKjcrCmW+pdyD50mtSCLVO/v+QJ+l6Ke3hIR73/QpmspvshPbHBaK/2JcBtlnRI5rUg34OhD+m6z9CP6ez3pkUUjfk+MIuMkArBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYg1eSQ01HQ0Rr/n2wecqdnE8h9PJexEHF8VrHjl3vI=;
 b=0szGSjQR59FrDPtum7BLOtlA5SU/ZnjPxRKBeBf4fG44KQGWhgpRuiUt//JDSyPimvmMAo0RBky4RnEuE5qh8/W9GGugFP+/fB/v59LB0yuN6RZk2NqXS2cOWOzDHK/Zsf0oJ08Jl68cMx2IB72viUeGmSJqgzus1mw2mDFd71g=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 19:28:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 19:28:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix SMUIO/PWR Confusion (v2)
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix SMUIO/PWR Confusion (v2)
Thread-Index: AQHWAtq9bxGMNrAHP0C8Yc3fhnYcOahZsNBu
Date: Wed, 25 Mar 2020 19:28:18 +0000
Message-ID: <MN2PR12MB44886BCD9A29C93D8DC1A6FEF7CE0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200325192221.717578-1-tom.stdenis@amd.com>
In-Reply-To: <20200325192221.717578-1-tom.stdenis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-25T19:28:17.664Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40ff2636-b415-434e-cca9-08d7d0f2ac0d
x-ms-traffictypediagnostic: MN2PR12MB2975:|MN2PR12MB2975:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2975E02A3AA054EFD39DE261F7CE0@MN2PR12MB2975.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(316002)(6506007)(71200400001)(66446008)(76116006)(66556008)(64756008)(86362001)(53546011)(66946007)(66476007)(33656002)(26005)(186003)(110136005)(19627405001)(478600001)(81156014)(45080400002)(9686003)(8936002)(8676002)(81166006)(966005)(2906002)(55016002)(52536014)(5660300002)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2975;
 H:MN2PR12MB4488.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KuIDMcQNHgiUjvG0FQmAX6EEcJcAjibQynkxfq5X3HWTLoT/kSWssxmMOBxckoVwxxaaSRghWEpGNOFmvP7VWIrDl/DdlasY9dYFhc5iN0Mn+mBokAh1otfXt7c6Lj3PznASgTPCiTD7XUR3x5s+Fqjw+3hmDESFYA6Kd0qUmPd1wy0jeRfNfTQ8Rboxmitfmk+W7fCnN67gjMKn7dZU7+fMIg8F3Fcgw6F1yjYaFBSjixo3DDTBDvj/JydKvp+uDM7OMMRLo5pO9OPlibp6Y69YeY2onyG9oIB6MLvJlo6r1IpNH+VJdVunvpqFOH26yemtX3Hxx+iPaCduRHPXbi5VNUk5JakKpzgDK/JoxH71/O4e+Au4dyMJ8aEftqGEnJ1SimZ0k14CPpW5QtUBQOf3+96dwwJ0d6sy2m1whjzXjgjE8veeOA/8iPlSN6phV2mu/hh+FwJ+/7FuoKQvJT4GDoL+6bHgCSsvGAieZpI=
x-ms-exchange-antispam-messagedata: PgZ7XLS1d7pwR/9uumE+V/aHLu1tlKaKdlPgWVObuU/i6Vok2YbtOpctSC0x3keaWklgBwKvUtoxI1hqjwuwMJL0o42/j/TdP6KamPXEUpjVyz4oiHJuhRRT3fXZ1VyZWaejQ58LbZncyYqPWWigkw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ff2636-b415-434e-cca9-08d7d0f2ac0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 19:28:18.2477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZGU6WinnfV2Rt6TpYSpNPxkvsQ5m5JczbdH7I+WrU/Ra0QflsRm17JZqXi6MgNVdFEvDN7VhwGBGloPq1RKkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2975
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
Content-Type: multipart/mixed; boundary="===============1905161090=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1905161090==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44886BCD9A29C93D8DC1A6FEF7CE0MN2PR12MB4488namp_"

--_000_MN2PR12MB44886BCD9A29C93D8DC1A6FEF7CE0MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

While you are at it, can you clean up the local defines of these registers =
in
drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
drivers/gpu/drm/amd/powerplay/smu_v12_0.c
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
and verify that the appropriate offset is used for both Renoir and raven?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tom St D=
enis <tom.stdenis@amd.com>
Sent: Wednesday, March 25, 2020 3:22 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix SMUIO/PWR Confusion (v2)

The PWR block was merged into the SMUIO block by revision 12 so we add
that to the smuio_12_0_0 headers.

(v2): Drop nonsensical smuio_10_0_0 header

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h | 3 +++
 .../drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h    | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset=
.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
index 327b4d09f66d..9bf73284ad73 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
@@ -24,4 +24,7 @@
 #define mmSMUIO_GFX_MISC_CNTL                                             =
                             0x00c8
 #define mmSMUIO_GFX_MISC_CNTL_BASE_IDX                                    =
                             0

+#define mmPWR_MISC_CNTL_STATUS                                            =
                             0x0183
+#define mmPWR_MISC_CNTL_STATUS_BASE_IDX                                   =
                             1
+
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mas=
k.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
index d815452cfd15..26556fa3d054 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
@@ -24,5 +24,10 @@
 //SMUIO_GFX_MISC_CNTL
 #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK                       =
                                    0x00000006L
 #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT                     =
                                    0x1
+//PWR_MISC_CNTL_STATUS
+#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT                  =
                                    0x0
+#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT                    =
                                    0x1
+#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK                    =
                                    0x00000001L
+#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK                      =
                                    0x00000006L

 #endif
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C20b8d1812aac4516419c08d7d0f1de31%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637207609564642593&amp;sdata=3D%2BT3BSejxB%2F3MsW8=
lfqAZ%2BiFfMXVG394Atnxi3K%2Bhjs8%3D&amp;reserved=3D0

--_000_MN2PR12MB44886BCD9A29C93D8DC1A6FEF7CE0MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
While you are at it, can you clean up the local defines of these registers =
in</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
drivers/gpu/drm/amd/powerplay/smu_v12_0.c</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
and verify that the appropriate offset is used for both Renoir and raven?</=
div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Tom St Denis &lt;tom.stdeni=
s@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 25, 2020 3:22 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: Fix SMUIO/PWR Confusion (v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">The PWR block was merged into the SMUIO block by r=
evision 12 so we add<br>
that to the smuio_12_0_0 headers.<br>
<br>
(v2): Drop nonsensical smuio_10_0_0 header<br>
<br>
Signed-off-by: Tom St Denis &lt;tom.stdenis@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h | 3 &#43=
;&#43;&#43;<br>
&nbsp;.../drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h&nbsp;&nbsp;=
&nbsp; | 5 &#43;&#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 8 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset=
.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h<br>
index 327b4d09f66d..9bf73284ad73 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_o=
ffset.h<br>
@@ -24,4 &#43;24,7 @@<br>
&nbsp;#define mmSMUIO_GFX_MISC_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0x00c8<br>
&nbsp;#define mmSMUIO_GFX_MISC_CNTL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;<br>
&#43;#define mmPWR_MISC_CNTL_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0x0183<br>
&#43;#define mmPWR_MISC_CNTL_STATUS_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
&#43;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mas=
k.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h<br>
index d815452cfd15..26556fa3d054 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_s=
h_mask.h<br>
@@ -24,5 &#43;24,10 @@<br>
&nbsp;//SMUIO_GFX_MISC_CNTL<br>
&nbsp;#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000006L<br>
&nbsp;#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x1<br>
&#43;//PWR_MISC_CNTL_STATUS<br>
&#43;#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x0<br>
&#43;#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x1<br>
&#43;#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x00000001L<br>
&#43;#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x00000006L<br>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C20b8d1812aac4516419c08d7d0f1de31%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637207609564642593&amp;amp;sdata=3D=
%2BT3BSejxB%2F3MsW8lfqAZ%2BiFfMXVG394Atnxi3K%2Bhjs8%3D&amp;amp;reserved=3D0=
">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cal=
exander.deucher%40amd.com%7C20b8d1812aac4516419c08d7d0f1de31%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637207609564642593&amp;amp;sdata=3D%2BT3BSej=
xB%2F3MsW8lfqAZ%2BiFfMXVG394Atnxi3K%2Bhjs8%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44886BCD9A29C93D8DC1A6FEF7CE0MN2PR12MB4488namp_--

--===============1905161090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1905161090==--
