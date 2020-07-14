Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B686C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 13:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46C02242C
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 13:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rEVAWpUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46C02242C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF4E6E40B;
	Tue, 14 Jul 2020 13:22:03 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690044.outbound.protection.outlook.com [40.107.69.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C566E40B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 13:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFIOSnZ9c8aM7utZ3jWYP8CoYavc3vzknHAFA9OtKBaVx7OlROh6Cxe89FIsj+Oz5EeSOpWzYvY74A7Rw+N17c8PPeASkmF4ymIbEZdfrC239zEg+09qmYX6SdLuSEVm5SWph/yD4Nb/V1L6iEFpeG90vP3SJtutc+G9qqnk6IEpAV5KXHVNn2vw20pmy70hMQ2iKY+SC1/Z3KDf47VR1IqQ3HxPnV9nd2GCXh90MjRbmSWeGChk1+7CGzOnFf7kaJToIqA8PbUwut0GlzurU9KWfMhXruxb4GJObxQIsEavmK8vPQIotEEkwKklPY10Eg0sT+4SKhzBbdjftnys8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrUVCI0mcNbKawIuxtDcWEGeLqo/zEBODZiKScnybHE=;
 b=Iz6iiUFxTqA3ydJeosOKWFN0DKjbZ27TMgtrKWkQUimji0M4g0ReSF72qT8jsqn8TPujWEBWL1cw7WoknQdXZcbGU/78fyiRBgBQUkHJ+jyJ2+MPDuIJ61jgfasnKU6kPUmq6t9MMRncGQBvQUC6B6SYqZ4LJVuo5sZlQplvWyenAX8BNQEulzB4b5Tl0UqHRFvCbUnRIK+fqGiRBgXwqulwtDFsa+yWnxJiXWCdjd85KT4Eqm+onQh/3u+8X49oO7t/d6bdR+1S84kcOshgTzntAWy1xwBUlEMEuYQqgCs8pI5Q6E210wvb94AwYGfKihbK+El6qhG70DAe2IaB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrUVCI0mcNbKawIuxtDcWEGeLqo/zEBODZiKScnybHE=;
 b=rEVAWpUKGhNFTy8MC2B3K3srkyE1w9To/ILqQ3K27nMH9AKtX6JtQZWxV5JKDEiiHOWdimQvJ85/BmXCuxG54f3uCJaSaOGypKMTvibVGUx9BB+Fx+i4uplePiDagZp7WmlgCeb98HvvZ8NuwFr2cPC7z3EgqXfeTwkN92H0GPI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4014.namprd12.prod.outlook.com (2603:10b6:208:16d::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 13:21:59 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 13:21:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix compilation error on dcn3
Thread-Topic: [PATCH] drm/amd/display: Fix compilation error on dcn3
Thread-Index: AQHWWdcyWyp66Lg32k65UR7eFrwUNKkHD73n
Date: Tue, 14 Jul 2020 13:21:59 +0000
Message-ID: <MN2PR12MB4488450799DD6AD59AB705CBF7610@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200714120602.916527-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20200714120602.916527-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-14T13:21:59.022Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b774adb-5b5c-46a0-e95e-08d827f8e3a3
x-ms-traffictypediagnostic: MN2PR12MB4014:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4014C2E516A67E1A7A784FF9F7610@MN2PR12MB4014.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:175;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9lUzNgvRY3TpZV2COcbpTFJX6rHLymQA7VM3RdG1UNXrtfmYlZWmPkDZHSKZrHIFSnE3KYMPwGNBYHg7Em7DWXYUMuT9hrdu7sOowtO/3QZoXgrfSIoYscdHHUFSr5mzGDzJgjdKJz3XYkDOh0YkC4L8sDpxrFXu14LIZavxMwPWgKvNxy+qOAPqosOqVRHmqhUaGw2gdSyCtPoJCFDshJRHP8RaIKX2eYhPKfGZIm9T1DdZ9mxsbGOFfzbiVQDy8f0QE+WjxUrwA4hI9Fu0FADcfde7nNuAJ6D6YM2OXm+iVkuffhNw3qXfnlfK5axikQDMqcuQSAK2nkmEYLP13Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(55016002)(9686003)(8936002)(316002)(2906002)(7696005)(54906003)(4326008)(5660300002)(83380400001)(26005)(33656002)(52536014)(19627405001)(186003)(66476007)(8676002)(76116006)(71200400001)(66556008)(64756008)(66446008)(66946007)(86362001)(478600001)(6506007)(110136005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: oWmD1qRO5mquPkWCavzZ4Nt8iwtkPg5115rig4k2tLHuaiZNvUJP2m/JMRZW9OP0nDCLs5fG+lwV9RcX3w5VeM6rmvsTzKUtboLrzp1MC3G4h0P92dRY2ea+xca9EdfUkcNNoo/4j+iKxPoZ4UEZDoVAmaERT8XYgg4VEvrIrVU6L7pTYbWHVGoBQR/ctRTx4ZYJFyxh68sryn8gqjQTPz098+ke4eBmqTAS0/JMLSXQA2Q6ffyLLgXuMzSv1agdXiMXwN/nmDFNTo12WxcHVlDcThl7PjzzBKsptxvlcJpT0XsMDNtqltBpVRxvTUebMjmjdAr02cs2AmBF0K3YWun6Jxt9+W86g7cMqw0NBzn7Z/LVmUSdpO/k/DqgaxmOiQoTmKuTs4KCWl7dzEOCTLAxfEAjje/GDsx8qYjKYFq44N2EdrGvt/CTgbiaAXDUI40mk2q86Xiz58fC673kmU1/qyL58LJA99D838XT4sg4NPXq9l7LpSqcgdTrEJPf
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b774adb-5b5c-46a0-e95e-08d827f8e3a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 13:21:59.6173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSTuPdizJkE45VCTre9KCLB1d3GVUzMJ6MAY+5gqLtcrTo+BeK+rPBAQEn4kuQJpYWVtuXTGerzjVzsI4k0Zfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4014
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Laktyushkin,
 Dmytro" <Dmytro.Laktyushkin@amd.com>, "Lee, Alvin" <Alvin.Lee2@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Teng, Rui" <Rui.Teng@amd.com>
Content-Type: multipart/mixed; boundary="===============0112489802=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0112489802==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488450799DD6AD59AB705CBF7610MN2PR12MB4488namp_"

--_000_MN2PR12MB4488450799DD6AD59AB705CBF7610MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Tuesday, July 14, 2020 8:06 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Teng, Rui <Rui.=
Teng@amd.com>; Laktyushkin, Dmytro <Dmytro.Laktyushkin@amd.com>; Kazlauskas=
, Nicholas <Nicholas.Kazlauskas@amd.com>; Lee, Alvin <Alvin.Lee2@amd.com>
Subject: [PATCH] drm/amd/display: Fix compilation error on dcn3

We have a compilation error when compiling dcn30_resource.c due to a
missing field in _vcs_dpi_soc_bounding_box_st. This commit fixes this
issue by introducing the required field and include file.

Cc: Rui Teng <rui.teng@amd.com>
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/dr=
ivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 0fac7f754604..6ab74640c0da 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -24,6 +24,7 @@
  */

 #include "dc_features.h"
+#include "display_mode_enums.h"

 #ifndef __DISPLAY_MODE_STRUCTS_H__
 #define __DISPLAY_MODE_STRUCTS_H__
@@ -120,6 +121,7 @@ struct _vcs_dpi_soc_bounding_box_st {
         double urgent_latency_adjustment_fabric_clock_reference_mhz;
         bool disable_dram_clock_change_vactive_support;
         bool allow_dram_clock_one_display_vactive;
+       enum self_refresh_affinity allow_dram_self_refresh_or_dram_clock_ch=
ange_in_vblank;
 };

 struct _vcs_dpi_ip_params_st {
--
2.27.0


--_000_MN2PR12MB4488450799DD6AD59AB705CBF7610MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Siqueira, Rodrigo &lt=
;Rodrigo.Siqueira@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 14, 2020 8:06 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd=
.com&gt;; Teng, Rui &lt;Rui.Teng@amd.com&gt;; Laktyushkin, Dmytro &lt;Dmytr=
o.Laktyushkin@amd.com&gt;; Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd=
.com&gt;;
 Lee, Alvin &lt;Alvin.Lee2@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix compilation error on dcn3</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">We have a compilation error when compiling dcn30_r=
esource.c due to a<br>
missing field in _vcs_dpi_soc_bounding_box_st. This commit fixes this<br>
issue by introducing the required field and include file.<br>
<br>
Cc: Rui Teng &lt;rui.teng@amd.com&gt;<br>
Cc: Dmytro Laktyushkin &lt;Dmytro.Laktyushkin@amd.com&gt;<br>
Cc: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;<br>
Cc: Alvin Lee &lt;Alvin.Lee2@amd.com&gt;<br>
Signed-off-by: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h | 2 &#43;&#=
43;<br>
&nbsp;1 file changed, 2 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/dr=
ivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h<br>
index 0fac7f754604..6ab74640c0da 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h=
<br>
@@ -24,6 &#43;24,7 @@<br>
&nbsp; */<br>
&nbsp;<br>
&nbsp;#include &quot;dc_features.h&quot;<br>
&#43;#include &quot;display_mode_enums.h&quot;<br>
&nbsp;<br>
&nbsp;#ifndef __DISPLAY_MODE_STRUCTS_H__<br>
&nbsp;#define __DISPLAY_MODE_STRUCTS_H__<br>
@@ -120,6 &#43;121,7 @@ struct _vcs_dpi_soc_bounding_box_st {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double urgent_latency_adju=
stment_fabric_clock_reference_mhz;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_dram_clock_ch=
ange_vactive_support;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool allow_dram_clock_one_=
display_vactive;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum self_refresh_affinity allow_=
dram_self_refresh_or_dram_clock_change_in_vblank;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct _vcs_dpi_ip_params_st {<br>
-- <br>
2.27.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488450799DD6AD59AB705CBF7610MN2PR12MB4488namp_--

--===============0112489802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0112489802==--
