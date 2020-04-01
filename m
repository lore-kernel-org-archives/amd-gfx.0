Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C03C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 06:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27845206F6
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 06:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gIKk+aJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27845206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF2116E8DF;
	Wed,  1 Apr 2020 06:51:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831686E8DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 06:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFubq7noCHtSz5Wqfic7XzuXKCYW2FQp4S4WGTzxRMAQ/YqQYZ9HoIVbZ5q1YswDrQS1B4l6B5ZHhXxdomSdZZyPsYEpiwqYtHVRDhDKx+y4/3r6cjENQAwrdAeg+dSRfLusX9i2tcDkLrtwl6I4Ye4YSqb9VLUU1eeBEvkz6M3SAs5LVsmXfVkhpoc4jf1Anp7sRGAR6h9yEsDQKqY2EaoSrzv/n8nUdbGd3mwaycxknyEtWq9QFJurGWN3SyEpBF8VM08YQr+MuKS1nSG1ZuAXNILXe27FNgnl4X0gvPKZtWdhhylM8wnHby5Mjfdw7cSKWuU6cUz61IlCcpDB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEY/ruHybTOUdlTFUL5E0jjgFmq6CrsdJ7zm3n4Jip8=;
 b=kqUDmgP+7Qvu/4SoNvfKgbkvqqPKdCut+exgSPMlcPXPtkKTv1hNoFvJfuOg8VwM+Xd1uW4iU/Ckp0acPyNf06tlwfGsOjMSWof0pdlV+XZvCSi2rAEJC0qomsPXo+nN7jW3Nysrg8mfojATzOK7hvXKln/XwHtLKRXYtNGs0plXu1rAKMX06y1U5ZOwK0yTSsvBSlSqAL5waRjQ433T42Dfqf0rhHFvGTxJ4G99tc1VB8gFLGKn1rZf/XM7O4R0ImBV6LoWKXCHBY8SOaIc7fcw93UNCRy83E/8FxKA10OVBn8cBbEHA+RrALchqEJFU/rn3GM9UtAVYnnjh6cMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEY/ruHybTOUdlTFUL5E0jjgFmq6CrsdJ7zm3n4Jip8=;
 b=gIKk+aJEV3VqxT1fexhKeS8TR6D5kKej9ghzhROQ3Cu3+/YbRaVrW5zT+wK8rPNSBihG7oob43iDDuhMz0JF6ITDz6jaN46ME4eCvCJfm9sD26K5udFUEYeTAeFfiEKgJaSwlUfljJHCdcDlJeJSwGPYglto3KH9JsJFWJbsnwo=
Received: from CY4PR12MB1749.namprd12.prod.outlook.com (2603:10b6:903:11d::16)
 by CY4PR12MB1125.namprd12.prod.outlook.com (2603:10b6:903:43::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Wed, 1 Apr
 2020 06:51:05 +0000
Received: from CY4PR12MB1749.namprd12.prod.outlook.com
 ([fe80::20d0:3ee:a99d:797a]) by CY4PR12MB1749.namprd12.prod.outlook.com
 ([fe80::20d0:3ee:a99d:797a%9]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 06:51:05 +0000
From: "Dai, Yuxian (David)" <Yuxian.Dai@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the
 MCLK
Thread-Topic: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set
 the MCLK
Thread-Index: AQHWB+slzfgDSY6ufk2uppQ1md2LNahj0SoAgAAClkA=
Date: Wed, 1 Apr 2020 06:51:05 +0000
Message-ID: <CY4PR12MB1749A4E7681DDFB7616F35C88DC90@CY4PR12MB1749.namprd12.prod.outlook.com>
References: <20200401060227.15989-1-Yuxian.Dai@amd.com>
 <MN2PR12MB3296808841DCC834937AA87AA2C90@MN2PR12MB3296.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3296808841DCC834937AA87AA2C90@MN2PR12MB3296.namprd12.prod.outlook.com>
Accept-Language: en-AS, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-01T06:40:59.238Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-01T06:51:02Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 1bc418c3-a103-4a58-9c56-0000bdfb2a7a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuxian.Dai@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44f0021b-3ea9-4a6a-152f-08d7d6090d17
x-ms-traffictypediagnostic: CY4PR12MB1125:|CY4PR12MB1125:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1125FC4DDA97DA6E0650FD468DC90@CY4PR12MB1125.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1749.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(33656002)(45080400002)(26005)(81166006)(8936002)(8676002)(5660300002)(66946007)(81156014)(52536014)(6506007)(966005)(2906002)(86362001)(76116006)(21615005)(186003)(66476007)(9686003)(71200400001)(110136005)(66556008)(478600001)(316002)(55016002)(66446008)(7696005)(64756008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7BiGK65lShqG+78dvwlgWZjh3PZxEa7xIRro16Xxf9cVcia3INulSqjsBiFxUkxq7DAJnzCqvvHWFnwx67uGWr8dMQ31oBRePQl7M6mlW/lDSaQxWMZWbUNPdu/tqzzCMLODv06qCnG145QV11OS2eTWjaF7a7lsRmRLxYew5NgEM4cL9vB/Wgr+WKyN2gmHuY+YtDQvUnrCbDONnHjL47aEfH45fVy3/utHXt6L1/cWiaVjSTmfq+9LR42fu7MjWxIp1etecKfzvrwUGIra2u9jwPmPkNo6amIClbRhFnW40FF3IQp+s8suZ4rgXUbgZQ491GR5bG0TaG6HXK9WrruHdV+iUhq4tXPo6TqTubo+i2Q+ATPEEGtrvCA5Ht0v3OsX9WOleiNtro8zjaRi18bsRJ2x5q/N6T0tR2chJNY2TvxpfugeBXSYSZuGerR25hNn4sZtSYdwTsnKKurDTfO0I2NQzLVnGp0QeZYlzdMHfCYg3nJD4lUWvP/tCV2GgmYw3o3kzFr1AieJ32g7Bg==
x-ms-exchange-antispam-messagedata: 89EhfuVAj/vEKFKS+COYcyUbNCDUX7fwGfmAWFUALAfwLRAZYMN+nxa1raj/Kd0ziTvc4idRit9oEdSw3I9AqlAcCyNSJD74V4cALNqYPAHLFQbEJKqDtJJBZckWDf3pvSAzYU3D9QRohFXTElej9w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f0021b-3ea9-4a6a-152f-08d7d6090d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 06:51:05.7871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7B/LT+Cfih53MXEuxmtvIbsYyROT3MPsVrj6iCsR+dnUp7/hpuSxs+/QHBnu3FHKJC6/X2D7Mv2MxSt/NqSJaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1125
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
Content-Type: multipart/mixed; boundary="===============1346503815=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1346503815==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1749A4E7681DDFB7616F35C88DC90CY4PR12MB1749namp_"

--_000_CY4PR12MB1749A4E7681DDFB7616F35C88DC90CY4PR12MB1749namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

1,Using the FCLK DPM table to set the MCLK for DPM states consist of
three entities:
 FCLK
 UCLK
 MEMCLK
All these three clk change together, MEMCLK from FCLK, so use the fclk
frequency.
2,we should show the current working clock freqency from clock table metric

Change-Id: Ia45f3069fc7ae56db495cb5a3865e2c50c550774
Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com<mailto:Yuxian.Dai@amd.com>>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 8 ++++++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c
index 7bf52ecba01d..5c5d3f974532 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -239,6 +239,7 @@ static int renoir_print_clk_levels(struct smu_context *=
smu,
         uint32_t cur_value =3D 0, value =3D 0, count =3D 0, min =3D 0, max=
 =3D 0;
         DpmClocks_t *clk_table =3D smu->smu_table.clocks_table;
         SmuMetrics_t metrics;
+       bool cur_value_match_level =3D false;

         if (!clk_table || clk_type >=3D SMU_CLK_COUNT)
                 return -EINVAL;
@@ -297,6 +298,13 @@ static int renoir_print_clk_levels(struct smu_context =
*smu,
                 GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
                 size +=3D sprintf(buf + size, "%d: %uMhz %s\n", i, value,
                                 cur_value =3D=3D value ? "*" : "");
+               if(cur_value =3D=3D value) {
+                       cur_value_match_level =3D true;
+               }
+       }
+
+       if(!cur_value_match_level) {
+               size +=3D sprintf(buf + size, "   %uMhz *\n",cur_value);
         }
[kevin]:
I have a little suggestion about coding style.
"Do not unnecessarily use braces where a single statement will do."
we'd better fix it.
thanks.

  *   Ok, I will remove it.

https://www.kernel.org/doc/html/latest/process/coding-style.html
Linux kernel coding style - The Linux Kernel documentation<https://www.kern=
el.org/doc/html/latest/process/coding-style.html>
Linux kernel coding style=B6. This is a short document describing the prefe=
rred coding style for the linux kernel. Coding style is very personal, and =
I won't force my views on anybody, but this is what goes for anything that =
I have to be able to maintain, and I'd prefer it for most other things too.=
 Please at least consider the points made here.
www.kernel.org<http://www.kernel.org>

         return size;
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.h
index 2a390ddd37dd..89cd6da118a3 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
@@ -37,7 +37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu)=
;
                         freq =3D table->SocClocks[dpm_level].Freq;        =
\
                         break;                                          \
                 case SMU_MCLK:                                          \
-                       freq =3D table->MemClocks[dpm_level].Freq;        \
+                       freq =3D table->FClocks[dpm_level].Freq;  \
                         break;                                          \
                 case SMU_DCEFCLK:                                       \
                         freq =3D table->DcfClocks[dpm_level].Freq;        =
\
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cac64217a79c44e06267008d7d602484e%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637213177638342283&amp;sdata=3DiEt1JzC0wcb7rQ%2F2TWBu7Rf=
JGrChPpt%2Fc2jXPfqjruU%3D&amp;reserved=3D0

--_000_CY4PR12MB1749A4E7681DDFB7616F35C88DC90CY4PR12MB1749namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"Segoe UI Light";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:211038915;
	mso-list-template-ids:659446460;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1
	{mso-list-id:1788968203;
	mso-list-type:hybrid;
	mso-list-template-ids:-1850304904 -462801084 67698691 67698693 67698689 67=
698691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-start-at:5;
	mso-level-number-format:bullet;
	mso-level-text:\F0D8;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:.75in;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:Calibri;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.25in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.75in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.25in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.75in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.25in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.75in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.25in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.75in;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">1,Using the FCLK DPM table to set the MCLK for DPM s=
tates consist of<br>
three entities:<br>
&nbsp;FCLK<br>
&nbsp;UCLK<br>
&nbsp;MEMCLK<br>
All these three clk change together, MEMCLK from FCLK, so use the fclk<br>
frequency.<br>
2,we should show the current working clock freqency from clock table metric=
<br>
<br>
Change-Id: Ia45f3069fc7ae56db495cb5a3865e2c50c550774<br>
Signed-off-by: Yuxian Dai &lt;<a href=3D"mailto:Yuxian.Dai@amd.com">Yuxian.=
Dai@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 8 &#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 &#43;-<br>
&nbsp;2 files changed, 9 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c<br>
index 7bf52ecba01d..5c5d3f974532 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
@@ -239,6 &#43;239,7 @@ static int renoir_print_clk_levels(struct smu_conte=
xt *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cur_value =3D 0, =
value =3D 0, count =3D 0, min =3D 0, max =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DpmClocks_t *clk_table =3D=
 smu-&gt;smu_table.clocks_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetrics_t metrics;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool cur_value_match_level =3D fa=
lse;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!clk_table || clk_type=
 &gt;=3D SMU_CLK_COUNT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -297,6 &#43;298,13 @@ static int renoir_print_clk_levels(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%d: %uMhz=
 %s\n&quot;, i, value,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_value =3D=3D value ? &quot;*=
&quot; : &quot;&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if(cur_value =3D=3D value) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_value_ma=
tch_level =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!cur_value_match_level) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;&nbsp;&nbsp; %uM=
hz *\n&quot;,cur_value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">[kevin]:<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">I have a little suggestion about coding style.<o:p><=
/o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black;background:white">&quot;Do not unnecessarily use braces =
where a single statement will do.&quot;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black;background:white">we'd better fix it.</span><o:p></o:p><=
/p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black;background:white">thanks.</span><o:p></o:p></p>
</div>
<div>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:.25in;mso-list:l1 level=
1 lfo3">Ok, I will remove it.<o:p></o:p></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"https://www.kernel.org/doc/html/latest/pr=
ocess/coding-style.html">https://www.kernel.org/doc/html/latest/process/cod=
ing-style.html</a><o:p></o:p></p>
</div>
<div style=3D"margin-top:12.0pt;margin-bottom:12.0pt;min-width: 424px" id=
=3D"LPBorder_GTaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vz=
cy9jb2Rpbmctc3R5bGUuaHRtbA..">
<table class=3D"MsoNormalTable" border=3D"1" cellspacing=3D"3" cellpadding=
=3D"0" width=3D"100%" style=3D"width:100.0%;border:solid #C8C8C8 1.0pt">
<tbody>
<tr>
<td width=3D"100%" valign=3D"top" style=3D"width:100.0%;border:none;padding=
:9.0pt 27.0pt 9.0pt 9.0pt">
<div style=3D"margin-right:6.0pt;margin-bottom:9.0pt" id=3D"LPTitle234871">
<p class=3D"MsoNormal"><span style=3D"font-size:16.0pt;font-family:&quot;Se=
goe UI Light&quot;,sans-serif"><a href=3D"https://www.kernel.org/doc/html/l=
atest/process/coding-style.html" target=3D"_blank"><span style=3D"text-deco=
ration:none">Linux kernel coding style &#8212; The Linux Kernel
 documentation</span></a><o:p></o:p></span></p>
</div>
<div style=3D"margin-right:6.0pt;margin-bottom:9.0pt;max-height: 100px;over=
flow:hidden" id=3D"LPDescription234871">
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif;color:#666666">Linux kernel coding style=B6. This i=
s a short document describing the preferred coding style for the linux kern=
el. Coding style is very personal, and I won&#8217;t force
 my views on anybody, but this is what goes for anything that I have to be =
able to maintain, and I&#8217;d prefer it for most other things too. Please=
 at least consider the points made here.<o:p></o:p></span></p>
</div>
<div id=3D"LPMetadata234871">
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Se=
goe UI&quot;,sans-serif;color:#A6A6A6"><a href=3D"http://www.kernel.org">ww=
w.kernel.org</a><o:p></o:p></span></p>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<div>
<p class=3D"MsoNormal" style=3D"box-sizing: border-box"><span style=3D"colo=
r:black">&nbsp;</span><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.h<br>
index 2a390ddd37dd..89cd6da118a3 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h<br>
@@ -37,7 &#43;37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *=
smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq =
=3D table-&gt;SocClocks[dpm_level].Freq;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case SMU_MCLK:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq =3D table-&=
gt;MemClocks[dpm_level].Freq;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq =3D tab=
le-&gt;FClocks[dpm_level].Freq;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case SMU_DCEFCLK:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq =
=3D table-&gt;DcfClocks[dpm_level].Freq;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; \<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Cac64217a79c44e06267008d7d602484e%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637213177638342283&amp;amp;sdata=3DiEt1Jz=
C0wcb7rQ%2F2TWBu7RfJGrChPpt%2Fc2jXPfqjruU%3D&amp;amp;reserved=3D0">https://=
nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedeskt=
op.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%=
40amd.com%7Cac64217a79c44e06267008d7d602484e%7C3dd8961fe4884e608e11a82d994e=
183d%7C0%7C0%7C637213177638342283&amp;amp;sdata=3DiEt1JzC0wcb7rQ%2F2TWBu7Rf=
JGrChPpt%2Fc2jXPfqjruU%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1749A4E7681DDFB7616F35C88DC90CY4PR12MB1749namp_--

--===============1346503815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1346503815==--
