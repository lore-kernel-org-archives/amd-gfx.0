Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE5C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 09:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC87206C0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 09:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC87206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2446E517;
	Thu, 14 Nov 2019 09:18:03 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720084.outbound.protection.outlook.com [40.107.72.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 007E86E517
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 09:18:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3u+nixvZQbdINTaiR1cYQF1RQUqxjbmC5VHlTCf6jLSYT7WPK6Q/TqVe+ohZfhWaY09h++gEUAS+PH8WyFicsFShf2sQUJXzz0fw8fLtstF5zeIGYsdayGaHRAfIMoo7H45dbe8r2wcbbLP4NsXBU2HcPOX6rXOVT8SPXxI1Dp7I29aJ4DRnJq/mi2FmL2cTF4hY4jTUos9zGwa+fOQMzvW9qwdGEku7t4jEKgCOCVJXqz2U000qEb+cYLOr14QiB9LOZxmkTFfxkw4sPPLTkZyCdjk0/vSjIEKsctxyKcsgdiqP7rY6qJQINV0Zk3/82d1A0sRjDW57Q9VrTbZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BthdP6kA4XSXTIy1dHSpznA5yERmA49Nf+tMJZPbYr4=;
 b=EJGw2gR8Ud4fWU3r//cu1HywqGjY36aSyYJ0MAAQuMSw2UkY74VfjZNHkxvKoRQfSit3vv1pcIulTmdSE4+W0HWi4ixG0NgnK60ayvP8ll1Q1m9wiYDn+MCdl+6oKlTUtAhtiJAP5QNeuNHVevUE22GDoCtlH1DgUq/g0by160YzT7MgkjCMWgVcUIdgSnIpRw20G/fnZZ3FXmNO+nKvgutnMbDnAU7SRpD8eVDRFvLOtaXWORubKi26HoCSqNhm6HjRNzXms17cJiLFme4y2j5JiAdOl2vNS+VLAVjGFSyFJ6Bs281lcM7si3TfvJ566qn/zC8vGoBb0MefCWFBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB4093.namprd12.prod.outlook.com (52.135.51.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 09:18:00 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::3db4:a949:8b89:33be]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::3db4:a949:8b89:33be%7]) with mapi id 15.20.2430.027; Thu, 14 Nov 2019
 09:18:00 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: correct fine grained dpm force level
 setting
Thread-Topic: [PATCH] drm/amd/powerplay: correct fine grained dpm force level
 setting
Thread-Index: AQHVmsr/ra21hEWubEq0D46XmPkEs6eKYym0
Date: Thu, 14 Nov 2019 09:18:00 +0000
Message-ID:
 <MN2PR12MB3296BA02D3FFCAA6E40698DFA2710@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191114090720.14342-1-evan.quan@amd.com>
In-Reply-To: <20191114090720.14342-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71711cca-88c0-4ccb-13b6-08d768e38ba2
x-ms-traffictypediagnostic: MN2PR12MB4093:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4093306530FDEE912EF41A0DA2710@MN2PR12MB4093.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(189003)(199004)(8676002)(19627405001)(74316002)(606006)(8936002)(81156014)(33656002)(81166006)(7736002)(229853002)(76116006)(6116002)(3846002)(91956017)(55016002)(6246003)(2906002)(6436002)(6306002)(54896002)(9686003)(236005)(478600001)(52536014)(66476007)(66446008)(64756008)(66556008)(66946007)(110136005)(71200400001)(316002)(99286004)(966005)(105004)(256004)(25786009)(5660300002)(446003)(71190400001)(6506007)(26005)(76176011)(86362001)(186003)(7696005)(53546011)(476003)(486006)(2501003)(66066001)(14454004)(102836004)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4093;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LvWDc6gHj/f7Oo6UM8/fyimePiZVLjEK3emgVlGUIhCY7Fc6xx5TewlTwzd/BGUIdFREouYCtcfTdMpUTz4vTRXtL/HzjEXEoPbY0RF0YpCE0JkBmf4VoX++7P9WEIKnnZlDSugh70bkxkwHLuGs/80DXplhgYl8aVvZNPBNG8Yhtp198TxMYZed9vVkDNgGh6Zl7P47lcwvGhsIZ2V9LrT4DuxhVp4VW3tm/pgmbn7kqJI7yAHdYo/nD10vi7duPwTOrc2BwCzDz7n+JxRjfL1F6DwVEn+AxoLPFbFxonKNOmiwyJGXS/K+V+5T+ya5A2EEOIU2aoH68KT3h1gIcd9yqwF0AmE79/pRxDwbzAvKqe7jXtPTohsMXVVcEUFwwUqA/Z6YT/vd0S8O/8DqBhpqTPBDZTZx4I9loEmSy9+IE38/R+l+pyy2vxu/0v/g
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71711cca-88c0-4ccb-13b6-08d768e38ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 09:18:00.4405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTMZkuTCVa0OTvI2xuUIpCEOQfQdZpCVddvy2JsHj9jdZrn3icObXjc+NKlzpp2E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BthdP6kA4XSXTIy1dHSpznA5yERmA49Nf+tMJZPbYr4=;
 b=Akgm9yBPlKtXP1g/q+cIajZMH/08mkCArHkzlBCg6X0gbfxC6BLdvWMOItgJjlKnKuyQvABnOLICXmEyy/PYKtqwc/1/dGCs2za3SSm5O5A0MunMLAnJSrVrrfIW7k2JxkaQXCUPDgMYc9fXqxbSN4fBK08redkRVb0FxkPD8BA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1905688228=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114091800.sae1HssR9WPCgNA5bx6H1Erw83MPNCiRGcLeS8S5fHE@z>

--===============1905688228==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296BA02D3FFCAA6E40698DFA2710MN2PR12MB3296namp_"

--_000_MN2PR12MB3296BA02D3FFCAA6E40698DFA2710MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Qua=
n <evan.quan@amd.com>
Sent: Thursday, November 14, 2019 5:07 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: correct fine grained dpm force level se=
tting

For fine grained dpm, there is only two levels supported. However
to reflect correctly the current clock frequency, there is an
intermediate level faked. Thus on forcing level setting, we
need to treat level 2 correctly as level 1.

Change-Id: I32f936636f27eb8d8d9002bedd701f2bb0d3060a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index c4f84627cfd9..0bbe3412d9b5 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -823,6 +823,12 @@ static int navi10_force_clk_levels(struct smu_context =
*smu,
         case SMU_UCLK:
         case SMU_DCEFCLK:
         case SMU_FCLK:
+               /* There is only 2 levels for fine grained DPM */
+               if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+                       soft_max_level =3D (soft_max_level >=3D 1 ? 1 : 0);
+                       soft_min_level =3D (soft_min_level >=3D 1 ? 1 : 0);
+               }
+
                 ret =3D smu_get_dpm_freq_by_index(smu, clk_type, soft_min_=
level, &min_freq);
                 if (ret)
                         return size;
--
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB3296BA02D3FFCAA6E40698DFA2710MN2PR12MB3296namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, November 14, 2019 5:07 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: correct fine grained dpm force l=
evel setting</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">For fine grained dpm, there is only two levels sup=
ported. However<br>
to reflect correctly the current clock frequency, there is an<br>
intermediate level faked. Thus on forcing level setting, we<br>
need to treat level 2 correctly as level 1.<br>
<br>
Change-Id: I32f936636f27eb8d8d9002bedd701f2bb0d3060a<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 6 &#43;&#43;&#43;&#43;&#=
43;&#43;<br>
&nbsp;1 file changed, 6 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index c4f84627cfd9..0bbe3412d9b5 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -823,6 &#43;823,12 @@ static int navi10_force_clk_levels(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_UCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_DCEFCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_FCLK:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* There is only 2 levels for fine grained DPM */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soft_max_lev=
el =3D (soft_max_level &gt;=3D 1 ? 1 : 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soft_min_lev=
el =3D (soft_min_level &gt;=3D 1 ? 1 : 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_dpm_freq_by_index(smu, clk_type, soft=
_min_level, &amp;min_freq);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n size;<br>
-- <br>
2.24.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296BA02D3FFCAA6E40698DFA2710MN2PR12MB3296namp_--

--===============1905688228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1905688228==--
