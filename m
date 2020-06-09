Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B31BC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 02:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE292078C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 02:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lqsgcebC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE292078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B8E6E140;
	Tue,  9 Jun 2020 02:26:14 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690049.outbound.protection.outlook.com [40.107.69.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDB76E13D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 02:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUn1upNWtMHPX6fZriHj1JchMzRTu2OmR0T3o8+rf+U8xbIcnSjlZMs6bFvIHFTxSF+ZoIAbpptIja61CKeUVRKgJQzpkxk9m4viqsj8tCV0K4eTVr+H3OmVaClXU4MGDXddF7gRU38KjFk6ylao7jiE/gg3fqTuTLN8JiET5dx75ufPRl2zu96SrMq7/HV7MmuAmNO8GKOeCHLpsq7Q3n6py6wbaL8cT7R7sOzOu5umpFfPFqpCkPRKxFcl269wlGSDHYsrQ8telV2ADPPxbvMUhIHb56Nyoh49r3KKYnps17hquQIdSLoBHow6+4ePumy0E2rpcLS9umIG9JnrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4+t7HW9cffgSy5ZCmiaB/B0qeP5kkN/u0WpBuG17SI=;
 b=A/A1hN1TKYGfdlCwLwqf137hKt8eF7WNVOnCdCUWs1BqB9sCKDEoVYmnebvtRTYritxU0Qa+BaZRXH2N0DkC8I6Mhe9KxfC9Hx/v2DxTV9PDHyYerlrWuvjSxhVN1rDI1pkgV3j7aaaO5kwQH/dKLxXIuvHLgVM8uWlH2L3eSYBRNuGNEv+XYzUS1E19MPt9UtMgeezV8yv6Lp0CpA38X1TWqnKbxOU2I92XkoMdMOcSOa3Inq8WdoVJJH7tOkFt5zFVdlbISUj2N00sOxucYE9L6OUGkdguzyaeTowxwyjh14zk6Vmogdf74RSzcmFtGuoz/4ROIoVso7dtBubfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4+t7HW9cffgSy5ZCmiaB/B0qeP5kkN/u0WpBuG17SI=;
 b=lqsgcebCMGlvssuD79s1VeVDyc4P9Pd39Sg/QAuRB/8MQL0r1N1IHZ8DO6jGmd6uRUvE7LpEh6saVp5GZlopqB/Z2pY/G+wwZNiriGXsAslRGWDWge0YrXVzrWdXjYOzTfArYW6PI7kfiizHUQzEdHniyqR0uHrFw1m9YCOfGZQ=
Received: from MN2PR12MB3568.namprd12.prod.outlook.com (2603:10b6:208:c3::33)
 by MN2PR12MB4000.namprd12.prod.outlook.com (2603:10b6:208:16b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 02:26:09 +0000
Received: from MN2PR12MB3568.namprd12.prod.outlook.com
 ([fe80::e1d4:756b:d956:4df7]) by MN2PR12MB3568.namprd12.prod.outlook.com
 ([fe80::e1d4:756b:d956:4df7%5]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 02:26:09 +0000
From: "Cui, Flora" <Flora.Cui@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan"
 <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: move maximum sustainable clock
 retrieving to .hw_init
Thread-Topic: [PATCH] drm/amd/powerplay: move maximum sustainable clock
 retrieving to .hw_init
Thread-Index: AQHWPYIlm8qfJGTBTk+0XezjCrM36qjO0G+AgAC9ECA=
Date: Tue, 9 Jun 2020 02:26:09 +0000
Message-ID: <MN2PR12MB3568E08CED6FFD7A1C34044BFA820@MN2PR12MB3568.namprd12.prod.outlook.com>
References: <20200608104627.29595-1-evan.quan@amd.com>
 <MN2PR12MB4488A422C4B2769AB7B65EF0F7850@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4488A422C4B2769AB7B65EF0F7850@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-08T15:01:44.696Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db3fcf31-6fbd-4cd1-4634-08d80c1c7873
x-ms-traffictypediagnostic: MN2PR12MB4000:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB40005E33A3D6B4609EDEF943FA820@MN2PR12MB4000.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NX7GYss3ngnGkJ9zvhHTYCa+03P7vYze73WPRclwzVwdzfAe7v1Co70tJAxozXbGIRc9rX0kJGiN2qeLhaQIyq7894CqOzOYd7zso2XSCZ7ivnDmfTdLhQ/ssSu70cLt/6NVRXJqzUY+lme25JuerG/8WpUjnGgzgHUCcZTnCmCxUM2CqYHJc2KyYyZbM01qC2Vo3MnYPZjxoy+0AxPC4SkcfGjfM7798gyoLbt5aHySnPtM0G41o2St6iBjq3fdyy1UWk7dEZBRvVIAWlLLoMsear2mDod/IThnRVLPVkuLHTvv0Ijef+VrTwjOocWtSdzDBfgJZU3YplYggWp+wZSHCWBPw3MsDN2sz03+HVMz/22Cm9XfMLnZgFXOfxah
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3568.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(86362001)(2906002)(71200400001)(53546011)(7696005)(6506007)(76116006)(66556008)(8936002)(83380400001)(66476007)(26005)(66446008)(316002)(5660300002)(64756008)(66946007)(9686003)(478600001)(33656002)(8676002)(55016002)(186003)(110136005)(52536014)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: /CJjOM8ix6UnG3lk4dt8W7Tu1JWMXZ8HmeAJE2bwyCMa2wiNq40oq4sGpPvD2UR+vh2zcv5sNl29XWiZXKH4F2B3p8Y6kaSg+7B20/v8OJGS29YqgxAr9QMmCQ02HWKOHRR7d4G8fyh7z4HUbFYwfQXYCg40vYX5NePK754JlwCmbTz+xvMetbPe7rtPjhqQAKs0Y6H518yDwnFUWjvt07vDUV/Pu4hp2JgNv8mfei7GAcyaH58BIcEmR6blthR1XdkDpceL0rMc0DCJmIR58fvwE9HSEhoxztfQBEa5IctOgvz0LUPk9kCNo0PXUWrfq9aPZcP2BDF14istNNkTLVpGPr403QGDnd7FNP536xgnQ4VEima01BXTRkgXd2+qZopVSLNuj0nB1jMMceNde4mQZMOant3XmraTdiTcsb1YnJJR5mihypddbH3UCUmZ43TM33lHTXUyaR/ONegfed6t5t6cHcl6QTcUQ8+HkmxXIEFmTucF5RAawssKvBqp
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3fcf31-6fbd-4cd1-4634-08d80c1c7873
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 02:26:09.1094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZVGdIQKp9Z7T3UPkPshIZ3OO/lrRtY2acge9+mCUovW6+t+LT8G2cf04B3Gig3k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4000
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
Content-Type: multipart/mixed; boundary="===============1973915784=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1973915784==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3568E08CED6FFD7A1C34044BFA820MN2PR12MB3568namp_"

--_000_MN2PR12MB3568E08CED6FFD7A1C34044BFA820MN2PR12MB3568namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reported-and-tested-by: Flora Cui <flora.cui@amd.com>

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Monday, June 8, 2020 11:02 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Cui, Flora <Flora.Cui@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay: move maximum sustainable clock retr=
ieving to .hw_init


[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>
________________________________
From: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>
Sent: Monday, June 8, 2020 6:46 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Cui, F=
lora <Flora.Cui@amd.com<mailto:Flora.Cui@amd.com>>
Subject: [PATCH] drm/amd/powerplay: move maximum sustainable clock retrievi=
ng to .hw_init

Since DAL settings come between .hw_init and .late_init of SMU. And
DAL needs to know the maximum sustainable clocks.

Change-Id: I0702b7332a0d7c0b29dfdf4999c18efb588b8862
Signed-off-by: Evan Quan <evan.quan@amd.com<mailto:evan.quan@amd.com>>
Reported-by: Flora Cui <flora.cui@amd.com<mailto:flora.cui@amd.com>>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 725ac90c0f36..6beae3b496be 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -819,12 +819,6 @@ static int smu_late_init(void *handle)
                 return ret;
         }

-       ret =3D smu_init_max_sustainable_clocks(smu);
-       if (ret) {
-               dev_err(adev->dev, "Failed to init max sustainable clocks!\=
n");
-               return ret;
-       }
-
         ret =3D smu_populate_umd_state_clk(smu);
         if (ret) {
                 dev_err(adev->dev, "Failed to populate UMD state clocks!\n=
");
@@ -1364,6 +1358,19 @@ static int smu_hw_init(void *handle)
                 return ret;
         }

+       /*
+        * Move maximum sustainable clock retrieving here considering
+        * 1. It is not needed on resume(from S3).
+        * 2. DAL settings come between .hw_init and .late_init of SMU.
+        *    And DAL needs to know the maximum sustainable clocks. Thus
+        *    it cannot be put in .late_init().
+        */
+       ret =3D smu_init_max_sustainable_clocks(smu);
+       if (ret) {
+               dev_err(adev->dev, "Failed to init max sustainable clocks!\=
n");
+               return ret;
+       }
+
         adev->pm.dpm_enabled =3D true;

         dev_info(adev->dev, "SMU is initialized successfully!\n");
--
2.27.0

--_000_MN2PR12MB3568E08CED6FFD7A1C34044BFA820MN2PR12MB3568namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Reported-and-tested-by: Flora Cui &lt;flora.cui@amd.=
com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Monday, June 8, 2020 11:02 PM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; amd-gfx@lists.freedesktop.=
org<br>
<b>Cc:</b> Cui, Flora &lt;Flora.Cui@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: move maximum sustainable clo=
ck retrieving to .hw_init<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Acked-b=
y: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander.=
deucher@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com"=
>Evan.Quan@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, June 8, 2020 6:46 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Quan, Evan &lt;<a href=3D"mailto:Eva=
n.Quan@amd.com">Evan.Quan@amd.com</a>&gt;; Cui, Flora &lt;<a href=3D"mailto=
:Flora.Cui@amd.com">Flora.Cui@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: move maximum sustainable clock r=
etrieving to .hw_init</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Since DAL settings co=
me between .hw_init and .late_init of SMU. And<br>
DAL needs to know the maximum sustainable clocks.<br>
<br>
Change-Id: I0702b7332a0d7c0b29dfdf4999c18efb588b8862<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com">evan.quan=
@amd.com</a>&gt;<br>
Reported-by: Flora Cui &lt;<a href=3D"mailto:flora.cui@amd.com">flora.cui@a=
md.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 19 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------<br>
&nbsp;1 file changed, 13 insertions(&#43;), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 725ac90c0f36..6beae3b496be 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -819,12 &#43;819,6 @@ static int smu_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_init_max_sustainable_cloc=
ks(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to init max sustainable clock=
s!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_populate_umd_s=
tate_clk(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to populate UMD st=
ate clocks!\n&quot;);<br>
@@ -1364,6 &#43;1358,19 @@ static int smu_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Move maximum sustainable =
clock retrieving here considering<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 1. It is not needed on re=
sume(from S3).<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2. DAL settings come betw=
een .hw_init and .late_init of SMU.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp; And DAL=
 needs to know the maximum sustainable clocks. Thus<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp; it cann=
ot be put in .late_init().<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_init_max_sustainable_=
clocks(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to init max sustainable c=
locks!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm_enabled =
=3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &qu=
ot;SMU is initialized successfully!\n&quot;);<br>
-- <br>
2.27.0<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3568E08CED6FFD7A1C34044BFA820MN2PR12MB3568namp_--

--===============1973915784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1973915784==--
