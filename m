Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E8DC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 12:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B36206D7
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 12:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oL7yZsB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B36206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B163C6E301;
	Mon, 15 Jun 2020 12:49:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 606746E301
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 12:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WK1ewzuv4E6at/dNasBJ/K7wdfDeo205w9kigAvVH/ZHYnTJsna8214AOte9SN7NfzHT2thIZ+G7fzeI2AVgYiOogEIXQh1O2l4lLkklXQR3yQ0azfgyAmt9dr4Gf2MrArVXTFPbtZcKXDul8uC/GnUwKc55hyM0WdcQ37hMWBfhSkEwxqRFSb2qbhovZ4fcIsTutF444OCF4/WBpzBGjItsyKqenUnYbYq3JoXok7tBUpUJHJ8qOINYHGfwAN+UiWsKvRzBoOHOjLXDBAzNExJiZVgcOre+m34ueOv/kvd4189OBnlj36fkKuvbUI4c5Mg+DPq/dK2Iqd7KZw1iZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cB/Ku7GO7PGuLVoF9b5r6TOvQhU1C2P6nP1aSey8k4=;
 b=CTZ/pNT7TPb0UeOqzH5UMh5Ag+v+MkuGfZCeqEUDWCq3KyPLAopr8WznRHJSfXmHX5VJEM2VeNVtkby6SsVosBDMNxIAvyA3wegs56561BOEko4G93s50iK32yC3rXk3/fG9S+tQu3VrvcNfy6s6BFu5QPZ4LRllR4gGnwVsXomq7CNOsxM678bjj3seCD61WDRLbZvxa9fUB4Ory7/mPPYD3iwf456w6dJPWzY0B343UfRBVkcMvp7fUx1bJiT/eh5/EHinjtKN16vHwnF9xES9Uf2wsBzmH2mlqQMt7Y0uSWghr6H+oy+Vlb9btEmtop9qTWyMouPAqavzrTRgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cB/Ku7GO7PGuLVoF9b5r6TOvQhU1C2P6nP1aSey8k4=;
 b=oL7yZsB9H7WL+E3ODJE336eX9UoJucpJo7urkZSfsRkVG/DmxDk03cXM1HmYAnaY8P1Wnp+nNpMwrSbmK2fkkJuWdkQVt3HXNuaxIF3cdfeJEO0Qf0yrA/IgSvOtArgj7mZ826N/qo2uxEv7WUUXegV9SM2iXvLeFIdShN/7OCI=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3597.namprd12.prod.outlook.com (2603:10b6:208:cf::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Mon, 15 Jun
 2020 12:49:42 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 12:49:42 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: remove perf level dpm in one-VF
Thread-Topic: [PATCH] drm/amdgpu: remove perf level dpm in one-VF
Thread-Index: AQHWQJxJdpkVaD5VXkCN8E94az0fN6jU0P86gALrTICAAeiG7Q==
Date: Mon, 15 Jun 2020 12:49:42 +0000
Message-ID: <MN2PR12MB30222DE3A541D2FD398D893EA29C0@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20200612093034.19799-1-Wenhui.Sheng@amd.com>
 <MN2PR12MB3022A7FD07D068626D3EE2C5A2810@MN2PR12MB3022.namprd12.prod.outlook.com>,
 <CH2PR12MB4101C57C190490F0A10D1E8F8C9F0@CH2PR12MB4101.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4101C57C190490F0A10D1E8F8C9F0@CH2PR12MB4101.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-15T12:49:40.930Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.142.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce0da86f-f0b0-44ec-1851-08d8112a92fb
x-ms-traffictypediagnostic: MN2PR12MB3597:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB359726ECC4FB966F1A8C3149A29C0@MN2PR12MB3597.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 79Cy6vPSBto/YjxJ9xVpbOOGoaliKKxTE0l/u+2nyTe4m34c/UUCtSo+Hi8LMTIQ/LOIw54aOxMm8wjQVd4UFx6MMwDwHP9gJ+D7Z5WhbJfpQ3Ht2GoNTj+VRdexiVsVd7QRRaxxiv9OqONvCIiW+TtTNJS0K3DutIzMTynCLB8fPo8UDyH9Q/XMcIzw2PeqX91ZtZJlMP4qz4zueId0PwbQ7Xt8H6yjtiIlIZ5M5l8YxvpxNmgRUve0LAy5ulX+w1VLKdIcRVX39iDftXQwOO1KbYCSfTKw/gRtgjx1SbVD4j4bqz0/e17dzYaq864R4CmuAbon3B89mQEH00yyaYvka3pOIO0LzwasplohL2c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(2906002)(83380400001)(33656002)(966005)(55016002)(52536014)(9686003)(5660300002)(19627405001)(7696005)(8936002)(76116006)(91956017)(66446008)(64756008)(186003)(316002)(6506007)(66946007)(66476007)(71200400001)(166002)(478600001)(45080400002)(110136005)(86362001)(66556008)(53546011)(8676002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: oy7yaXrd6ELK0IMKfMHdggGRqYitBUuUZGRONx2UXg2bpSprUqD6Cr19Fg99tw2mViXVX026c28xODb8FUO4HuiQxslYE1mwuZ7a2BM/SmSQxZIJ0FJm6MFQ8Ri6VscrXvCIUp7m9gvTJ4qdYpdLch/t3pi7DyV7a7mYRaWftDblKA3FuEL1HQUz3PYig5J+1pzK/kVQyna9s0/wSwlzWHFDXdK3Y9PDIKYu60aMsun0P7UbAsuGXAT+cUQxYiqkVwJX9oNJHIE09uegkmHMNPDbeWh1ATxmj/SrsGCFcAS3qggWVE9eCxB7KYhi8dYiqB3X1r91gfyycaQ5BnHtVvhcBpt96GSpm1r1osj0oJ0R0S76ag8Inbw44TCzXezNLCxV/7iXXsXnaBPaH+3E96bTh/tu0OVgZ74zUWfvjLmQGxC8AD/bqb4u8M/usnoyJiRNDYUj6cajEPjFZhMBxsdCzq/k59jv4QiNwgU0ZH4=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0da86f-f0b0-44ec-1851-08d8112a92fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 12:49:42.2984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2taXwX7hAjt7NvSUAzOB4EoTIAyf5NZiyjNqcvkGkwyBoaD4uLuxS51Gdm1FBE46
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3597
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
Content-Type: multipart/mixed; boundary="===============2060442403=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2060442403==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30222DE3A541D2FD398D893EA29C0MN2PR12MB3022namp_"

--_000_MN2PR12MB30222DE3A541D2FD398D893EA29C0MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

please add these smu messages into patch commit,
after fixed,
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Sheng, Wenhui <Wenhui.Sheng@amd.com>
Sent: Sunday, June 14, 2020 3:38 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove perf level dpm in one-VF


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]



Hi Kevin,



At least 3  SMU messages not supported in one-VF mode , which could break t=
he node power_dpm_force_performance_level functionality



SMU_MSG_SetSoftMaxByFreq
SMU_MSG_SetSoftMinByFreq

SMU_MSG_TransferTableDram2Smu



Brs

Wenhui

From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Friday, June 12, 2020 7:04 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: remove perf level dpm in one-VF



[AMD Official Use Only - Internal Distribution Only]



which smu message will break this node work on navi12 asic?



Best Regards,

Kevin

________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Wenhui Sheng <Wenhui.Sheng@amd.com<ma=
ilto:Wenhui.Sheng@amd.com>>
Sent: Friday, June 12, 2020 5:30 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Sheng, Wenhui <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.com>>
Subject: [PATCH] drm/amdgpu: remove perf level dpm in one-VF



On Navi12 platform, node power_dpm_force_performance_level
doesn't work correctly in one-VF mode.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.c=
om>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 395ddbe2461c..4e7b579afe0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1877,7 +1877,7 @@ static ssize_t amdgpu_set_thermal_throttling_logging(=
struct device *dev,

 static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {
         AMDGPU_DEVICE_ATTR_RW(power_dpm_state,                          AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RO(pp_num_states,                            AT=
TR_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             AT=
TR_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           AT=
TR_FLAG_BASIC),
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C76d3cddef9744f5c7ee908d80eb3502e%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637275511045991505&amp;sdata=3D1uvfK9R%2FMAFkZrgPk5aEnVM=
Qs9zYOJQUFdLWwLzMbs4%3D&amp;reserved=3D0

--_000_MN2PR12MB30222DE3A541D2FD398D893EA29C0MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
please add these smu messages into patch commit,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
after fixed,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Sheng, Wenhui &lt;Wen=
hui.Sheng@amd.com&gt;<br>
<b>Sent:</b> Sunday, June 14, 2020 3:38 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: remove perf level dpm in one-VF</fo=
nt>
<div>&nbsp;</div>
</div>
<div lang=3D"EN-US">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0078D7=
; margin:15pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_msipheadera92e061b" style=3D"margin-right: 0in; margin-left: =
0in; font-size: 11pt; font-family: Calibri, sans-serif;margin:0in; margin-b=
ottom:.0001pt">
<span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; =
color:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><=
/p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
Hi Kevin,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
At least 3 &nbsp;SMU messages not supported in one-VF mode , which could br=
eak the node power_dpm_force_performance_level functionality
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
SMU_MSG_SetSoftMaxByFreq<br>
SMU_MSG_SetSoftMinByFreq</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
SMU_MSG_TransferTableDram2Smu</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
Brs</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
Wenhui</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt; <br>
<b>Sent:</b> Friday, June 12, 2020 7:04 PM<br>
<b>To:</b> Sheng, Wenhui &lt;Wenhui.Sheng@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: remove perf level dpm in one-VF</p>
</div>
</div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#0078D7">[AMD Official Use Only - Internal=
 Distribution Only]</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">which smu message will break =
this node work on navi12 asic?</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Best Regards,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Kevin</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"margin: 0in 0in 0.0001=
pt; font-size: 11pt; font-family: Calibri, sans-serif;text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
<b><span style=3D"color:black">From:</span></b><span style=3D"color:black">=
 amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-g=
fx-bounces@lists.freedesktop.org</a>&gt; on behalf of Wenhui Sheng &lt;<a h=
ref=3D"mailto:Wenhui.Sheng@amd.com">Wenhui.Sheng@amd.com</a>&gt;<br>
<b>Sent:</b> Friday, June 12, 2020 5:30 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Sheng, Wenhui &lt;<a href=3D"mailto:Wenhui.Sheng@amd.com">Wenhui=
.Sheng@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: remove perf level dpm in one-VF</span> =
</p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt=
; font-family: Calibri, sans-serif;">
On Navi12 platform, node power_dpm_force_performance_level<br>
doesn't work correctly in one-VF mode.<br>
<br>
Signed-off-by: Wenhui Sheng &lt;<a href=3D"mailto:Wenhui.Sheng@amd.com">Wen=
hui.Sheng@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 395ddbe2461c..4e7b579afe0b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -1877,7 &#43;1877,7 @@ static ssize_t amdgpu_set_thermal_throttling_logg=
ing(struct device *dev,<br>
&nbsp;<br>
&nbsp;static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(powe=
r_dpm_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(power_dpm_force=
_performance_level,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BAS=
IC|ATTR_FLAG_ONEVF),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(power_dpm_f=
orce_performance_level,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG=
_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_n=
um_states,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_c=
ur_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_f=
orce_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7C76d3cddef9744f5c7ee908d80eb3502e%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637275511045991505&amp;amp;sdata=3D1uvfK9=
R%2FMAFkZrgPk5aEnVMQs9zYOJQUFdLWwLzMbs4%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7C76d3cddef9744f5c7ee908d80eb3502e%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637275511045991505&amp;amp;sdata=3D1uvfK9R%2FMAFkZrgPk5aEnVMQs=
9zYOJQUFdLWwLzMbs4%3D&amp;amp;reserved=3D0</a></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB30222DE3A541D2FD398D893EA29C0MN2PR12MB3022namp_--

--===============2060442403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2060442403==--
