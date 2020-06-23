Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD5FC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 14:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFDAE20723
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 14:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HM3Tcg8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDAE20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F0406E178;
	Tue, 23 Jun 2020 14:50:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 512396E178
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 14:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUxKn7t6lrHzPDjchXHmcy5BrzZ1yDMrv2+fxtIQybi7OQhW+pOuuHDibPKJlAJI8fRyZUw5kIybFBlcsUuIKPU03Bye5l1xsX1t7oyGeuEuNoHP0SqRH13A+fUWq5xS1uNhSgBn8jgkbtFJlNMYMWCntQb4kaVoNjWHUD6+CLQEzXXBS+oGzO1C6MY1iZe0OhzHDgUWXNeoOI3XGHreIVKldAMR6LgR7Uh1x3f9s5BB2imYBm+IEzutoUTUnEGD2ciO9hpxs1Fu2IL6R0uV5/DgJqW8PrvZxmLqfx593K5HLUVciF9kGu9+sCSF4F2yf9Mh3hM40Oe0mU1EBnLlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOJWRTJqfqbzLuD98P9zP3upvorCI3Owa7L2Llx0OFo=;
 b=ODBDe8jU46AotKkaEwn72nyJRK/On0styFk7by+2V2rUvsXj9qrnFlRCfatMZxlLKy/3AdXDBcaSi41FyUXBeMrktk9jaffByU6u9OjfrXb1xRnsu0M0sa1c6I6/dLquiQbOYP+Gz5eESSi13eP8g/V5LjHaU1V/oaU+fEHkMkPpDGSB8xHrfT0/9HHAuNEiLqLL98GQWpxDh4I9ptPQHr6wfwo63TLlfBHDiw7a2puBjXGVgiA898OPC39CtSuEQ8torI01Ka6zDBLEpkb934kcD/TQkHwDdxrqBAXExRqa1qrQP/Ls/XAClb5zpo/ZL31hByzvsfxElPYIfYKsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOJWRTJqfqbzLuD98P9zP3upvorCI3Owa7L2Llx0OFo=;
 b=HM3Tcg8et8eqkVZrrHZXnKPIz7arpQv+gvlJw+/28nFMbnCNgSmJbawPKLQN3m1gPQIVkVo7VwQJfuQvs+iW4CohTXgUyx7+pUi5fZYMmQP2CvMBKWKYsYneo6ems7BpVLpe4zhXD7902i/+JOrr8UxacFE5T3/lcVNdrDmDQqQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 14:50:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 14:50:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amd/powerplay: return current DCEFCLK on sysfs
 read
Thread-Topic: [PATCH 1/1] drm/amd/powerplay: return current DCEFCLK on sysfs
 read
Thread-Index: AQHWSUKRhL2bw9Z7I0GzRuqHbJqajKjmSMLm
Date: Tue, 23 Jun 2020 14:50:45 +0000
Message-ID: <MN2PR12MB44887914BD44D23BA9D6ACDEF7940@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200623094327.10824-1-nirmoy.das@amd.com>
In-Reply-To: <20200623094327.10824-1-nirmoy.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-23T14:50:44.893Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.51.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ef93bab-3f0a-4912-e76c-08d81784cf4f
x-ms-traffictypediagnostic: MN2PR12MB4488:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4488C20B97308998DD38E36AF7940@MN2PR12MB4488.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:182;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0UVpkdkpV9G08aD/zFJoX1mpt6uQEhNh3ZuEv1yWb5kquFHY5KGz1DmYKJ1qp+8fPEpllBqsabQAh9GfAT9aoovXNBS+mkQiNYkQTaVRTBKmHJwQfSl4dQIahFTLuTwZlCF8L7vC0Y0xhzQ3k3/524Hh52ssPxTvbqG8GU5DbAIYV3rvPyXjwaTAurwG8QLPjcvL9MCnGcqm8S97/nK3k4PPdp3vTljThBz7yF3l240r0S1o4eWkB3B7Tv8jXPwCX/C6XmQm20CXPdTSreKB5yxSjY2q1f2cXSJFGfA3kiZkYaJkwb22yyBsXs08M8Cc9dZwJ/Cc2mzsF10MKE3J4lSicVSpZUTgak3TwWao81s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(2906002)(316002)(19627405001)(33656002)(55016002)(9686003)(186003)(26005)(7696005)(53546011)(6506007)(86362001)(8676002)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(5660300002)(478600001)(52536014)(83380400001)(71200400001)(966005)(110136005)(4326008)(8936002)(166002)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: B41sXiEPfRYTqOyLbRQdGlpETv/O4ng1Uz6oPEY3O/GQ+XhIMsmfsCzl43wuVTKPO8WmlH95BCM1gRAT/bMrb+z4gGVR/et2aSDX6ofxUDF7CuRwnOCNxc2swuf7d+jG93A96w7CiGfoLVc7a3mFJ5ZyML6mFR9+sqdFEo9qbuu0WD2bFXfng400QdJ8pWL8tIFJU4889AmQG8bCP9Qp0qz3YqKBCSuBE1BWCC9RAXvecdJ8g0ebk+JvNWbZnyQdpXrORjr8Akn7dFdXudjU0DrlBNMprUqVAwv5Z4VZQ0kr0JhAxcFwuhDBxSc4LVB83bi9tPtvcGUWQ9+shnoKj5wbKwrnkP5/WBJ2teyFUxgGiEBChPuta15K0l/7dS5ZcBOEpoq0IHpKq6uLaK48ZEAfg+ROpnht1uf+BFSOJTBfJfjm8s7UgCZFICkViULTURfHxHhp7HzgEDZ/7KT552a9Siwm2yWg/WYpX73DFzxxWad9zSqIA6eyDYakpupy
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef93bab-3f0a-4912-e76c-08d81784cf4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 14:50:45.3400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vjQW6by3OODEssYi4kB0JkuEVq+gHwdd48PVrZP+TGbjAavnkEeECpXMInOreUP6dGNM+Pwrn4iIG9jlkdnrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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
Cc: "Das, Nirmoy" <Nirmoy.Das@amd.com>
Content-Type: multipart/mixed; boundary="===============1705005575=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1705005575==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44887914BD44D23BA9D6ACDEF7940MN2PR12MB4488namp_"

--_000_MN2PR12MB44887914BD44D23BA9D6ACDEF7940MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Nirmoy D=
as <nirmoy.aiemd@gmail.com>
Sent: Tuesday, June 23, 2020 5:43 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH 1/1] drm/amd/powerplay: return current DCEFCLK on sysfs rea=
d

This fixes incorrect output when reading pp_dpm_dcefclk sysfs.

Output before this patch:
cat /sys/devices/pci0000:<snip>/pp_dpm_dcefclk
0: 506Mhz
1: 42949671Mhz *
2: 1266Mhz

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 3 +++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 3 +++
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index d93f8a43a96f..daeae14fd380 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -962,6 +962,9 @@ static int arcturus_get_smu_metrics_data(struct smu_con=
text *smu,
         case METRICS_CURR_FCLK:
                 *value =3D metrics->CurrClock[PPCLK_FCLK];
                 break;
+       case METRICS_CURR_DCEFCLK:
+               *value =3D metrics->CurrClock[PPCLK_DCEFCLK];
+               break;
         case METRICS_AVERAGE_GFXCLK:
                 *value =3D metrics->AverageGfxclkFrequency;
                 break;
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index 6c2f582bad5d..42ade9df0d6a 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -613,6 +613,9 @@ static int navi10_get_smu_metrics_data(struct smu_conte=
xt *smu,
         case METRICS_CURR_DCLK:
                 *value =3D metrics->CurrClock[PPCLK_DCLK];
                 break;
+       case METRICS_CURR_DCEFCLK:
+               *value =3D metrics->CurrClock[PPCLK_DCEFCLK];
+               break;
         case METRICS_AVERAGE_GFXCLK:
                 *value =3D metrics->AverageGfxclkFrequency;
                 break;
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/g=
pu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 0957957a2cf5..1378dabb6463 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -605,6 +605,9 @@ static int sienna_cichlid_get_smu_metrics_data(struct s=
mu_context *smu,
         case METRICS_CURR_DCLK1:
                 *value =3D metrics->CurrClock[PPCLK_DCLK_1];
                 break;
+       case METRICS_CURR_DCEFCLK:
+               *value =3D metrics->CurrClock[PPCLK_DCEFCLK];
+               break;
         case METRICS_AVERAGE_GFXCLK:
                 *value =3D metrics->AverageGfxclkFrequency;
                 break;
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C75a22f8a1b564c09bc9508d81759b036%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637285021304836731&amp;sdata=3DVHh%2BYyp5tQBvIut5K=
Lmb963jJnk%2BILJKF1I5BffqsF8%3D&amp;reserved=3D0

--_000_MN2PR12MB44887914BD44D23BA9D6ACDEF7940MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
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
ounces@lists.freedesktop.org&gt; on behalf of Nirmoy Das &lt;nirmoy.aiemd@g=
mail.com&gt;<br>
<b>Sent:</b> Tuesday, June 23, 2020 5:43 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amd/powerplay: return current DCEFCLK on sy=
sfs read</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This fixes incorrect output when reading pp_dpm_dc=
efclk sysfs.<br>
<br>
Output before this patch:<br>
cat /sys/devices/pci0000:&lt;snip&gt;/pp_dpm_dcefclk<br>
0: 506Mhz<br>
1: 42949671Mhz *<br>
2: 1266Mhz<br>
<br>
Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 3 &#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 3 &#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 3 &#43;&#43;&#43=
;<br>
&nbsp;3 files changed, 9 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index d93f8a43a96f..daeae14fd380 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -962,6 &#43;962,9 @@ static int arcturus_get_smu_metrics_data(struct smu=
_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_FCLK:<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *value =3D metrics-&gt;CurrClock[PPCLK_FCLK];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_DCEFCLK:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *value =3D metrics-&gt;CurrClock[PPCLK_DCEFCLK];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_AVERAGE_GFXCL=
K:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *value =3D metrics-&gt;AverageGfxclkFrequency;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 6c2f582bad5d..42ade9df0d6a 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -613,6 &#43;613,9 @@ static int navi10_get_smu_metrics_data(struct smu_c=
ontext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_DCLK:<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *value =3D metrics-&gt;CurrClock[PPCLK_DCLK];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_DCEFCLK:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *value =3D metrics-&gt;CurrClock[PPCLK_DCEFCLK];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_AVERAGE_GFXCL=
K:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *value =3D metrics-&gt;AverageGfxclkFrequency;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/g=
pu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
index 0957957a2cf5..1378dabb6463 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
@@ -605,6 &#43;605,9 @@ static int sienna_cichlid_get_smu_metrics_data(stru=
ct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_DCLK1:<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *value =3D metrics-&gt;CurrClock[PPCLK_DCLK_1];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_DCEFCLK:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *value =3D metrics-&gt;CurrClock[PPCLK_DCEFCLK];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_AVERAGE_GFXCL=
K:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *value =3D metrics-&gt;AverageGfxclkFrequency;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-- <br>
2.27.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C75a22f8a1b564c09bc9508d81759b036%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637285021304836731&amp;amp;sdata=3D=
VHh%2BYyp5tQBvIut5KLmb963jJnk%2BILJKF1I5BffqsF8%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7C75a22f8a1b564c09bc9508d81759b036%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637285021304836731&amp;amp;sdata=3DVHh%2BYyp5tQB=
vIut5KLmb963jJnk%2BILJKF1I5BffqsF8%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44887914BD44D23BA9D6ACDEF7940MN2PR12MB4488namp_--

--===============1705005575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1705005575==--
