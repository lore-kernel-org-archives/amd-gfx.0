Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A680C2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 14:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007D72236F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 14:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sNssLxjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007D72236F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 759966ECB3;
	Tue,  3 Nov 2020 14:30:25 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760081.outbound.protection.outlook.com [40.107.76.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532976ECB3
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 14:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPQrMQ2OA1DMQ9jdv5Ij7T+Cxoi1PGGifHGj+H6yW5Ce59zCSjpYtYjtC2cmRxKHhc7234HcmOCbqmcwyOgO2pc8wB1dJrh/G5Md1Q5iC08pA6g/w5fxp1tFmIrAa6cpte1EwXDd4gVcLO7SBdugltLWk06UCa5E+teK1kTe07TanEmvRfzsu88W60XyFaLWMUDMZXcEexveP3wzGYLWh+Br8BpbPcrPHTe40NNImcgn/H+BAFeBNoVsjpku/DjakX7Iha8nMbO+B/PQGQu7/hiVSaeD2Eo7urfeCsZon+QXXRJMDQ2Qcm62oPaSYUHU8hO4mDXbVsjJwZIrGWPIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBJhGniosGuuX0zIAiiHuMIkC99oW9YjWpy/Noi2iaQ=;
 b=ogVyeeAg6vh355LM8jIIIa1iuOnfvgUXKmKNs+MNaz1UWjGiS47JiYBnR4F1wKcfzh6kxZlnKPTf4gOmjAtyvGLMokHhHlnxluTC5gRljExMQb/lDEWwVg28I4nTjaO8uH6aiQocWjZVuSQwhn4+95voUVxfmx1MenA26wSMUWVTr3aRdCKtw2d72qpmfDFWOb/0oQk6NeOTCBkGUmsUDECMkJhw3NpNcgdmzvkF+2DfKVjrlVxUiGaRO4GtD5dTZydCnZdeWPjXDGa8pVqEubXIid6/FxcspEHCVge2fn48NxC9XxjrAucEWfnjWB8KphBiJucdsQtRMizCkrkdZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBJhGniosGuuX0zIAiiHuMIkC99oW9YjWpy/Noi2iaQ=;
 b=sNssLxjJOWg8onTa2wYbGdwqBomVr7o3yfvEyRr+g13BIL3XXMmdBZvA3W4Dm8pziu1L4jezdeQmySvaBhyk4tOzuZLf/1eK0iMGJTQBomTVz5PTZUOQ/uK+cXZVm9nCTxhlXWzZcyVyN5SJaQBKo17dYoD2j99IUTIwTIthgek=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Tue, 3 Nov
 2020 14:30:21 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 14:30:21 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: update module paramter doc of amdgpu_dpm
Thread-Topic: [PATCH] drm/amdgpu: update module paramter doc of amdgpu_dpm
Thread-Index: AQHWsaXY9YdpYfzkL0CLdy8bgfdFxqm2eFRW
Date: Tue, 3 Nov 2020 14:30:21 +0000
Message-ID: <MN2PR12MB4488A5F5CB401C946AFECBF0F7110@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201103055412.19169-1-kevin1.wang@amd.com>
In-Reply-To: <20201103055412.19169-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68c4036e-33c9-463e-37cf-08d88004fea8
x-ms-traffictypediagnostic: MN2PR12MB4272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB427234D2C6943D45CDA2D192F7110@MN2PR12MB4272.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXqzkE+oZwcO7nBzCWO1kdayjOFF/vsvlcZ0OO90ay3pvtBqqYZtT6IyTtGhnP8PGSHRj9ATs1/Z6dtSUEsTFMx/BZCahh1+KfFKZryksTAEVXvNrMT04oyxUFT0xy3oGB+vxS8v7ri2pdgMupH8Dn/gclKvGlkZVIs3ldvd9HrH/bD2VT5R/FqD1FtsfdpswUI3PDpG3gsh3Kxb3zHqin5fdiaZE9NXzW+A+PA209vC0N61kUujDQVT5CKUMGZaJReWJtdLDDLUn4QZfa1+bFet+H1W79uV22Q3vD7bvTrlVxmge4xcj0cXQVwOeNA/N9D4REQH6Rna6eLMmxxiX9hh3kV50i/HpdXtRCxmcwI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(55016002)(15650500001)(166002)(83380400001)(33656002)(45080400002)(4326008)(8936002)(86362001)(26005)(71200400001)(19627405001)(186003)(5660300002)(6506007)(8676002)(53546011)(2906002)(64756008)(966005)(66556008)(110136005)(7696005)(66946007)(76116006)(316002)(52536014)(478600001)(9686003)(66446008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: LIcStvTHXxFZTKKjRSYRQP6g1E4wQ84toGpNdOnvEqwy4jwLg84WUD0pyMP5wWxWWwRtTok5KQgraGEJcM75GKwxgSea4ZKKRZqttJq8KriWK3xUFHYKbvPXYe24PfSBk3BflyxP0InyQvz17t0af1QjGFTjio44PBEe7L7IZWOi0aVgZfGQLrxaEHThJhPDYF0SVPZHnY+BaXV4X61imVjVUXlu2mb3shYmVD4yKS+MpyO0EEefH4RBz4wC5BQeMUtYN1qseDGQNtTdyKFPgd7OwRMVJRKlNMhZQg4f5+tvZWYSVRLBQbA2ko+rel15wbzg5CJr1qfN25Gm1LKIh0VyOQNyyfE7WKKhh4UkdgMQWe950SdOq10eFoFe+L05+O2W+nOUUcBI9BDaEhPgAamY3HUQdLfQj4UpVE8ClW0OXMUqYycIxwa2q+O77dQftuDnMqsKH6ZsMQZAaaos0HGV8dNAJ8gKXXAKTIFjBoS8qknyLo6hYdwGwP5NlOFatJC07hDsQ++nQTgwAJhI07aocLFV0JXsbMD0QLwpCfyLHodfl2UEuZYSXfY+W7jB3oONEbjgOvLTdCgylguIBOx8ka/7zMGIOf+dZZIcAunEsyTmGTELjDYGED5djT/Cm6PBnMv04TM+qg/5U9LCoA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c4036e-33c9-463e-37cf-08d88004fea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 14:30:21.2929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5L+C0uCuvya/qzQ1+llmGKAFWI03H5W8Paeb5baGUW+qNh0e7PybqrnUaOs2LlyXzRnIUuiQhACiHC5dlGorg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: multipart/mixed; boundary="===============0954303679=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0954303679==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488A5F5CB401C946AFECBF0F7110MN2PR12MB4488namp_"

--_000_MN2PR12MB4488A5F5CB401C946AFECBF0F7110MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kevin Wa=
ng <kevin1.wang@amd.com>
Sent: Tuesday, November 3, 2020 12:54 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@am=
d.com>
Subject: [PATCH] drm/amdgpu: update module paramter doc of amdgpu_dpm

the vega20 isn't supported swsmu.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 03f4aab1fe99..9d28054b8aae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -279,7 +279,7 @@ module_param_string(lockup_timeout, amdgpu_lockup_timeo=
ut, sizeof(amdgpu_lockup_
 /**
  * DOC: dpm (int)
  * Override for dynamic power management setting
- * (0 =3D disable, 1 =3D enable, 2 =3D enable sw smu driver for vega20)
+ * (0 =3D disable, 1 =3D enable)
  * The default is -1 (auto).
  */
 MODULE_PARM_DESC(dpm, "DPM support (1 =3D enable, 0 =3D disable, -1 =3D au=
to)");
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C4ae8b1a81d21425639d008d87fbcf7a4%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637399796905142189%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DfuXa0uSIEISgNh%2FUxxU3HlEDJDb9E41UGW7EouDVm5k%3D&amp;reserved=3D0

--_000_MN2PR12MB4488A5F5CB401C946AFECBF0F7110MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kevin Wang &lt;kevin1.wang@am=
d.com&gt;<br>
<b>Sent:</b> Tuesday, November 3, 2020 12:54 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Feng, Kenneth &lt=
;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update module paramter doc of amdgpu_dp=
m</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">the vega20 isn't supported swsmu.<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 03f4aab1fe99..9d28054b8aae 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -279,7 +279,7 @@ module_param_string(lockup_timeout, amdgpu_lockup_timeo=
ut, sizeof(amdgpu_lockup_<br>
&nbsp;/**<br>
&nbsp; * DOC: dpm (int)<br>
&nbsp; * Override for dynamic power management setting<br>
- * (0 =3D disable, 1 =3D enable, 2 =3D enable sw smu driver for vega20)<br=
>
+ * (0 =3D disable, 1 =3D enable)<br>
&nbsp; * The default is -1 (auto).<br>
&nbsp; */<br>
&nbsp;MODULE_PARM_DESC(dpm, &quot;DPM support (1 =3D enable, 0 =3D disable,=
 -1 =3D auto)&quot;);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C4ae8b1a81d21425639d008d87fbcf7a4%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637399796905142189%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DfuXa0uSIEISgNh%2FUxxU3HlEDJDb9E41UGW7EouDVm5k%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C4ae8b1a81d21425639d008d87fbcf7=
a4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637399796905142189%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DfuXa0uSIEISgNh%2FUxxU3HlEDJDb9E41UGW7EouDVm5=
k%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB4488A5F5CB401C946AFECBF0F7110MN2PR12MB4488namp_--

--===============0954303679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0954303679==--
