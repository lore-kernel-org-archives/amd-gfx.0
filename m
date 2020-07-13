Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B84C433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 16:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52682067D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 16:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4Mv70/4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52682067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65FCC6E191;
	Mon, 13 Jul 2020 16:04:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D8826E191
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 16:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qb6Skg89m3L47cMFSItD58d/iYGVmNAR3hdUQjZYBaesfgUDe2z+k/suPrquxHrQ1d9Xw9f5v5yYlQRM7oRChxSyVrPvzcHUf/GPxR2KMWNFWyBpKV4UpcELiarwtK7VEOjxhCozT7AEF8I04ox8U6OMXER3+Kk3r93gNAA9afUrhPUINILlLiXdJiW8LaY04FEj+4AZNXAuO6Mwiuzre4/Mjw0CayCOZBUB+zHK+ECVRD2hj0FMXwy3FpJ7YBADKXo9Dy1kBgj0nQQJrbdT22ZT9mjiF+ZYLUkyJs10MWhZ5zfwa4bDRtv7m97s1Xp4BM1BGE4S94aW1QK4luWpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47ZxvxeSuV65nydAficlS1ySuTtXRuEl9oFmiUdFSTk=;
 b=i2QFNSqNx1xOUD5E0txgrQY5B3kHXNBmT0Jsu10EUQjwE2rioXnKBR+yklDt66qaJSa8RG1ipWBYiusVUP/lddijWR+j82jKTfksbytP1+g3tPRGFZTUcMSNZSb9f1XTwSMs6JZtf2+6Omqexa+yM5Ok92tLwcwTcTYyP9/RyY+qoNSdBB84co0U7RMCDEkxaVEnswH7426nQ/+5kwl2lJ1eEdkOs6lHkGFpAXzFGxAFBHOPYRcLyXcDDeOB3VajTUtWcOcGYYKAXpL9EYozmrSGyxXlsTPnNOudehkv9UWKEWS9k3U1bEJJziIDeyxYe3j6kAHECaoBqFp+tssgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47ZxvxeSuV65nydAficlS1ySuTtXRuEl9oFmiUdFSTk=;
 b=4Mv70/4jNm8HchH6l3L+zyVKhAeCeqBdhmRCZMIMgGe/bRAMVQKMv0ZLfwXHvVZqGOCR5YglUGXjNm5jNpGNo68mUV7NictiPNLbYiuM2hBC/Gj8ZSKC01Ao2i1QazUXGB/WjQGtXXXA5gVRF8mM8Z6abBdqPYut+yB+tjmVlQk=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MW2PR12MB2410.namprd12.prod.outlook.com (2603:10b6:907:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 16:04:12 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::f54a:55ae:1157:742]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::f54a:55ae:1157:742%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 16:04:12 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Add missing DCN30 registers and
 fields for OTG_CRC_CNTL2
Thread-Topic: [PATCH 1/2] drm/amd/display: Add missing DCN30 registers and
 fields for OTG_CRC_CNTL2
Thread-Index: AQHWWSvO80oYm42sY0uLYwI6tqCgQ6kFrB4e
Date: Mon, 13 Jul 2020 16:04:11 +0000
Message-ID: <MW3PR12MB4554F6ACAA057DAE3B7235EEF9600@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20200713153908.14815-1-nicholas.kazlauskas@amd.com>
In-Reply-To: <20200713153908.14815-1-nicholas.kazlauskas@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-13T16:04:12.237Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d638556a-248d-48c1-26c4-08d82746622a
x-ms-traffictypediagnostic: MW2PR12MB2410:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB2410B302B5C4DD12DA82ABB0F9600@MW2PR12MB2410.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4eGkSfEKyBI3dtfaQqGYpWx7fycHoOMKVh9cRBU7333LxT5SMCu8i4kAlmZ0h3jb4H9f0XSqjQVD9l6mPCCUMO+18KV03S5cHWWgNfCqjP0jXhI+kztLV4GFS9HuxqaOZzc6kV1IfdRgSoKQxXE4D+d8WM17Y2kuTYgLEFkDy7RcuptOzjO+2Zw8JbP6bzXfGZ596fOpNcWPOZKXE7CUaMXFGkR6qgscnyvIVNc3bZmhsWzTzPjpI0WLQrNpUD5OJTtNoN9KmZZLkfOUk2k04TRvM8pH+TBqgUlPyoHlltFyjYft6kJ6b9xwyG0L7RBtMdbfkuuU/dGEcBuXi3BQqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(5660300002)(19627405001)(86362001)(66946007)(66476007)(66556008)(66446008)(64756008)(91956017)(76116006)(186003)(26005)(52536014)(83380400001)(71200400001)(33656002)(2906002)(7696005)(6506007)(478600001)(8676002)(316002)(8936002)(9686003)(55016002)(110136005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ZfDHCzW6e2GuS3EzDEHpn9Zy/Zkj3PONGm8j6kVmYWtFdOwSclL+VZfbwfIxh93KGOj+8MthrcaGwj3dBkpk1kmps3H54GSwXdBiMS3E/vm+t55HR0gopNhJMNlp4XzAoapjBH+4dLEm1NtnAYPdGtTAC0pc0Et3FCm+rpFIVgR0cgEZOR4wNaiTmPBiOXeFLdpx1NnrQCQlIAW8WrRSVwK0XqK8s1G/2NmQ9vf4weYt/EisxB0VKpQ0ThhdQ/bM05bPjxVOAP549h0U2QuQVXuvlKmc1XOz/aeDlWTCVm+GXKkmtvWAOZDawGNeootYmclJNGoRa9vpOp5hBFluQIqNadPbMRt6gG+uW2xAgkyH0T0y7M/SV5YeKxL3J+795IyG1VLMicJBVTt5RKKEc5uAC0FY7zUdhMk0QSbHDsvyGfOLcF4R4k5AUsT/05nmR+eeRC5Utv5g0tTxmc8DXZAYwzFfilFjBarGKcELIE4e7UgJfb1vgXKg6ZAo+7ii
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d638556a-248d-48c1-26c4-08d82746622a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 16:04:11.9644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hq93v7Y8o+qWDJHHLdS6SMkpm+6M16azTIe8Je9Ph712fEAJAdcmxHdonXVBSn7h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2410
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
Content-Type: multipart/mixed; boundary="===============0987973134=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0987973134==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4554F6ACAA057DAE3B7235EEF9600MW3PR12MB4554namp_"

--_000_MW3PR12MB4554F6ACAA057DAE3B7235EEF9600MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
________________________________
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Sent: July 13, 2020 11:39 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Lakha, Bhawanpreet =
<Bhawanpreet.Lakha@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Add missing DCN30 registers and field=
s for OTG_CRC_CNTL2

[Why]
When enabling the debugfs for CRC capture we hit assertions caused by
register address and field masks and shifts missing.

[How]
We want these registers programmed, so add in the SRI/SF entries for
this register.

Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gp=
u/drm/amd/display/dc/dcn30/dcn30_optc.h
index d4106dd5a9b0..33f13c1e7520 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
@@ -98,6 +98,7 @@
         SRI(OTG_GSL_WINDOW_Y, OTG, inst),\
         SRI(OTG_VUPDATE_KEEPOUT, OTG, inst),\
         SRI(OTG_DSC_START_POSITION, OTG, inst),\
+       SRI(OTG_CRC_CNTL2, OTG, inst),\
         SRI(OTG_DRR_TRIGGER_WINDOW, OTG, inst),\
         SRI(OTG_DRR_V_TOTAL_CHANGE, OTG, inst),\
         SRI(OPTC_DATA_FORMAT_CONTROL, ODM, inst),\
@@ -248,6 +249,10 @@
         SF(OTG0_OTG_GSL_CONTROL, OTG_MASTER_UPDATE_LOCK_GSL_EN, mask_sh), =
\
         SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_X, mask_sh)=
, \
         SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_LINE_NUM, m=
ask_sh),\
+       SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DSC_MODE, mask_sh),\
+       SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_COMBINE_MODE, mask_sh),\
+       SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_SPLIT_MODE, mask_sh),\
+       SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_FORMAT, mask_sh),\
         SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG0_SRC_SEL, mask_sh),\
         SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG1_SRC_SEL, mask_sh),\
         SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_NUM_OF_INPUT_SEGMENT, mask_s=
h),\
@@ -280,6 +285,10 @@
         SF(OTG0_OTG_GSL_CONTROL, OTG_MASTER_UPDATE_LOCK_GSL_EN, mask_sh), =
\
         SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_X, mask_sh)=
, \
         SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_LINE_NUM, m=
ask_sh),\
+       SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DSC_MODE, mask_sh),\
+       SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_COMBINE_MODE, mask_sh),\
+       SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_SPLIT_MODE, mask_sh),\
+       SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_FORMAT, mask_sh),\
         SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG0_SRC_SEL, mask_sh),\
         SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG1_SRC_SEL, mask_sh),\
         SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG2_SRC_SEL, mask_sh),\
--
2.25.1


--_000_MW3PR12MB4554F6ACAA057DAE3B7235EEF9600MW3PR12MB4554namp_
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
Reviewed-by: <font size=3D"2"><span style=3D"font-size:11pt">Bhawanpreet La=
kha &lt;Bhawanpreet.Lakha@amd.com&gt;</span></font><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicholas Kazlauskas &=
lt;nicholas.kazlauskas@amd.com&gt;<br>
<b>Sent:</b> July 13, 2020 11:39 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Lakha,=
 Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/display: Add missing DCN30 registers an=
d fields for OTG_CRC_CNTL2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
When enabling the debugfs for CRC capture we hit assertions caused by<br>
register address and field masks and shifts missing.<br>
<br>
[How]<br>
We want these registers programmed, so add in the SRI/SF entries for<br>
this register.<br>
<br>
Cc: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
Signed-off-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h | 9 &#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 9 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gp=
u/drm/amd/display/dc/dcn30/dcn30_optc.h<br>
index d4106dd5a9b0..33f13c1e7520 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h<br>
@@ -98,6 &#43;98,7 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OTG_GSL_WINDOW_Y, OTG,=
 inst),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OTG_VUPDATE_KEEPOUT, O=
TG, inst),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OTG_DSC_START_POSITION=
, OTG, inst),\<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OTG_CRC_CNTL2, OTG, inst),\<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OTG_DRR_TRIGGER_WINDOW=
, OTG, inst),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OTG_DRR_V_TOTAL_CHANGE=
, OTG, inst),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OPTC_DATA_FORMAT_CONTR=
OL, ODM, inst),\<br>
@@ -248,6 &#43;249,10 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_GSL_CONTROL, O=
TG_MASTER_UPDATE_LOCK_GSL_EN, mask_sh), \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_DSC_START_POSI=
TION, OTG_DSC_START_POSITION_X, mask_sh), \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_DSC_START_POSI=
TION, OTG_DSC_START_POSITION_LINE_NUM, mask_sh),\<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DS=
C_MODE, mask_sh),\<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DA=
TA_STREAM_COMBINE_MODE, mask_sh),\<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DA=
TA_STREAM_SPLIT_MODE, mask_sh),\<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DA=
TA_FORMAT, mask_sh),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(ODM0_OPTC_DATA_SOURCE_S=
ELECT, OPTC_SEG0_SRC_SEL, mask_sh),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(ODM0_OPTC_DATA_SOURCE_S=
ELECT, OPTC_SEG1_SRC_SEL, mask_sh),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(ODM0_OPTC_DATA_SOURCE_S=
ELECT, OPTC_NUM_OF_INPUT_SEGMENT, mask_sh),\<br>
@@ -280,6 &#43;285,10 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_GSL_CONTROL, O=
TG_MASTER_UPDATE_LOCK_GSL_EN, mask_sh), \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_DSC_START_POSI=
TION, OTG_DSC_START_POSITION_X, mask_sh), \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_DSC_START_POSI=
TION, OTG_DSC_START_POSITION_LINE_NUM, mask_sh),\<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DS=
C_MODE, mask_sh),\<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DA=
TA_STREAM_COMBINE_MODE, mask_sh),\<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DA=
TA_STREAM_SPLIT_MODE, mask_sh),\<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DA=
TA_FORMAT, mask_sh),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(ODM0_OPTC_DATA_SOURCE_S=
ELECT, OPTC_SEG0_SRC_SEL, mask_sh),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(ODM0_OPTC_DATA_SOURCE_S=
ELECT, OPTC_SEG1_SRC_SEL, mask_sh),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(ODM0_OPTC_DATA_SOURCE_S=
ELECT, OPTC_SEG2_SRC_SEL, mask_sh),\<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4554F6ACAA057DAE3B7235EEF9600MW3PR12MB4554namp_--

--===============0987973134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0987973134==--
