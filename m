Return-Path: <SRS0=8BNM=6W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C797FC38A2A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 09:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1DF20735
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 09:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eWd7CX6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1DF20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD2106EAC6;
	Fri,  8 May 2020 09:35:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FDC06EAC6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2020 09:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6DZz1mnz4bQYOUZ0WcIZxdNbxJV+jnFhjuo3g3wEVcXlZDtJY/ntTpJY5kB5P+o6o6vjEAKCGT1TYloKeJmapxXzu1GWnV+27YsW3LdJ+udPdssu4PGAkMPP4N8Adno1CcvuBSukWBSTlHPKMBVNZKCRVR/1VU1pXtwQdQ0p06HU5yk5VdQyF9U0E34INhmJsnLG9jioN+zdJMDzMt+B7cgH50GRpm1jeTb7z9HA1RKCX7TO/1q9tVNc0KwcQkEjQ57ANOrOvt2zhBDE92h8JWHVFujklSQJCjqT/sHmdmHDY0lJ0CKYyDcDqu7OXiCcmhyeLrkrNPiGG4NffYM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsx3lHVVfpFwPH/V4NMRd7i8uROc/hquRjzrT9wvxds=;
 b=KNU94uUAmb26/7Szz+V1Es/b910F+ttMc5xdZMz2D+3cLqQq+euUKhsn9Pw+XieBGshbgtt3N4IDGN8D64/qeLZTYeyTTZnIOOlGUO2wa55pXtVZ5KTBgKycJaOBM+6TT7VUUocyxa28Olh4QaDhS3AXehF22gJ6eP6tvPYZUVEHubT0ANrwmAUjtaZOl7gjwmXvDbgO0wBH4/8AJ1Tzca1nkkwxd5gy1C9U+Wy0cAv/PTwEx/lkS1unteuJsfuZhZxdVJgvEA2Vx+6VY40ntCsUjVHLkm9wWrM7ogtDIZSHyYRs5WeAaWlTTvXxWCORfPB4JUG1efYZ/AedT/Jj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsx3lHVVfpFwPH/V4NMRd7i8uROc/hquRjzrT9wvxds=;
 b=eWd7CX6A9eUpYWeLrzyJzmU1ymLpD903JTR37n7UO92A3rdG07LezzcyKOBaQfyoRWs1F4zCHEWBurke3RlCmOIbh09xNBLySI/Kuld7ovIzoMUzAIftWk99MEpwdq40e2utezVW3BVKMDwXBy5sDO45HmvB11aS1hZJC9eamXI=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Fri, 8 May
 2020 09:35:45 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8%7]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 09:35:45 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] Series to disallow XGMI link power down during RAS XGMI
 error injection   
Thread-Topic: [PATCH] Series to disallow XGMI link power down during RAS XGMI
 error injection   
Thread-Index: AdYlBM1jbW95+O6gQgCVQiz75SiPwQAAj9dAAAUK0oA=
Date: Fri, 8 May 2020 09:35:45 +0000
Message-ID: <MN2PR12MB40329140B89312E660E81D5CFBA20@MN2PR12MB4032.namprd12.prod.outlook.com>
References: <MN2PR12MB4032BA32212F2A8948471950FBA20@MN2PR12MB4032.namprd12.prod.outlook.com>
 <CY4PR12MB1287A67072224F35AA0CE7E3F1A20@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287A67072224F35AA0CE7E3F1A20@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-08T07:11:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8a61f524-cf12-4ead-a456-0000b99f5f2c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-05-08T09:35:43Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ffb5e5a3-2107-4a16-8e85-000080a015bb
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e325104e-3582-4feb-01a2-08d7f3332ee1
x-ms-traffictypediagnostic: MN2PR12MB4256:|MN2PR12MB4256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4256A430BDD3FB3BA5CCFAC4FBA20@MN2PR12MB4256.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JVwHBTM2VxRButLwf40Pv6Og3bDcH2n7gAN7IjGbFIiK8+CWfCptaJImDCidTW/p5XUjQS0p/B9kkAlgnMPrTGYVcYUwGJH9teilHKOL68KqYgBYO0hhvz86kA/YxDB6Pc8jthWbcDvt6n870CCvtN0Wo1H7jvRSWEItJ5JT1i0g0uW4MAU/sRgi5CkF0/urYBxEZNTVYSGSRRAbLVtUl4Enia7aAjnL9RQ43zlMRad3XStkAm8VMuTqnxkfjmL53zLUKteJpnWtBafedDcC3uIvSlk8CZ9ZfSLKiqjKZOfCt+sEyTZRds24q5Xcfkt2kfbb2dXj9WXcB57p1D4JP5THrQ/M2FPBCO1lB8bYFgPi/KYSC9BAyctjzqMWXj75vWziGXApc5pEWNhCeCfTDZFF88re4bTIZjMIGjYoQzAXo82suaXkV15KW+vSmT+hXVd5aMgj+rZn6UGYtuyL4yB39/jE03cCFnjSdIEtg8ICx3VFbWlb5QsJgkEGakQVpsaVuANGz49ogTKz4ZWXpA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(33430700001)(110136005)(9686003)(66476007)(64756008)(66446008)(55016002)(76116006)(66556008)(66946007)(8676002)(52536014)(8936002)(71200400001)(7696005)(316002)(6636002)(33440700001)(186003)(26005)(83280400001)(83290400001)(83300400001)(83310400001)(83320400001)(6506007)(53546011)(478600001)(86362001)(5660300002)(33656002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: le1o2pgLiy6MMQi0JH2h1nKvDAdSM8/rdp+TaSkTlt/65yOQPfjYkW08uweK+wNqzp99NAKXjA+rhqs1xwjlzt1vHbS/t2zdCrARCkS/sRxAsSpW4OH9BdjBdKSGXNBL5jvuta19dAOtlU9VSrg0oQleWp5cnsRa9jArjKftmYgh3495w39qUCQeMFzKttmgNuNvYBZvV58xaiCrnmjAp7HGwAUSFd9x/ty1VH0sF60c5ohyEF9iJKvofFGNabRr3r8+h+KktR/TiDZVnXKvGVDV604L3Ts3KEAuyXDWiyT83MLSv8/Oc1T1ESK/SVBGcheOvJfjS3vQilDz901J3RuY8XInSOXDuDqy+fC42aAVZhNcJh62wyL67pb+hTbTbduSUsHv6IdaMk7zYAryZ6jhUGUq4CBPYLbUprMsA85bcADSFx09gKWeW8+OWRJ8fq3zyc/BwnswI7VrwUMTvXTlcNy2oHe2TyiRiC7nv7k72WqoDiKmma4kdiUwMQkD
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e325104e-3582-4feb-01a2-08d7f3332ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 09:35:45.0494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wURGed0u2hrf8kltmeWA36jYwsoXMZ92RbOklG581raE1LZqvK2eZ3KP7cpgdO7OjMpeJN/2ZNEzxbqOoxyO+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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
Content-Type: multipart/mixed; boundary="===============1218830848=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1218830848==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB40329140B89312E660E81D5CFBA20MN2PR12MB4032namp_"

--_000_MN2PR12MB40329140B89312E660E81D5CFBA20MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Responses inline

From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Friday, May 8, 2020 3:11 PM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org; =
Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] Series to disallow XGMI link power down during RAS XGM=
I error injection


[AMD Public Use]

Patch 1,
1. maybe it's better to split it into 2, one is for header file change, and=
 another is functional patch.
2.  Can below codes be merged to one return instead? Variable 'en' can serv=
e the function input in smu_send_smc_msg_with_param.
[JC] I think what you are suggesting would probably work, but my concern is=
 that it is not immediate clear to me if bool ec will compile to 1. The spe=
c for the SMU cmd defines 1 to enable and 0 to disable
if (en)
+                           return smu_send_smc_msg_with_param(smu,
+                                                                          =
             SMU_MSG_GmiPwrDnControl,
+                                                                          =
             1,
+                                                                          =
             NULL);
+
+            return smu_send_smc_msg_with_param(smu,
+                                                                         S=
MU_MSG_GmiPwrDnControl,
+                                                                         0=
,
+                                                                         N=
ULL);

Patch 2: Reviewed-by: Guchun Chen guchun.chen@amd.com<mailto:guchun.chen@am=
d.com>

Patch 3:
1.function amdgpu_ras_error_inject_xgmi should be one static function? [JC]=
 That makes sense, I'll update function to be static
2. Regarding below return case, is there one dpm_allow_xgmi_power_down leak=
? As we have disabled xgmi link power down.
[JC] I intentionally did this, when the RAS int is triggered I don't want t=
o create any races conditions to access the SMU to perform functions and en=
tering BACO reset, the XGMI per link settings will be restored anyway after=
 the BACO reset.
[JC] That being said I understand that this looks like it could be a bug, I=
'll add comments there to clarify the sequence
+            if (amdgpu_ras_intr_triggered())
+                           return ret;

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Clements, John
Sent: Friday, May 8, 2020 2:51 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zh=
ang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: [PATCH] Series to disallow XGMI link power down during RAS XGMI er=
ror injection


[AMD Official Use Only - Internal Distribution Only]

Submitting 3 patches for review:

  *   Added host to SMU FW cmd to enable/disable XGMI link power down
  *   Added DPM function for XGMI link power down control
  *   Disable XGMI link power down prior to issuing a XGMI RAS error

--_000_MN2PR12MB40329140B89312E660E81D5CFBA20MN2PR12MB4032namp_
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
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
	{mso-list-id:381831772;
	mso-list-type:hybrid;
	mso-list-template-ids:-1337145758 -291890196 67698691 67698693 67698689 67=
698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:DengXian;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-bidi-font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;
	mso-bidi-font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-bidi-font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;
	mso-bidi-font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-bidi-font-family:Wingdings;}
@list l1
	{mso-list-id:1418093501;
	mso-list-template-ids:228349740;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Responses <b><span style=3D"color:#C00000">inline</s=
pan></b><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt=
; <br>
<b>Sent:</b> Friday, May 8, 2020 3:11 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] Series to disallow XGMI link power down during =
RAS XGMI error injection
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Patch 1, <o:p></o:p></p>
<p class=3D"MsoNormal">1. maybe it&#8217;s better to split it into 2, one i=
s for header file change, and another is functional patch.<o:p></o:p></p>
<p class=3D"MsoNormal">2.&nbsp; Can below codes be merged to one return ins=
tead? Variable &#8216;en&#8217; can serve the function input in smu_send_sm=
c_msg_with_param.<o:p></o:p></p>
<p class=3D"MsoNormal"><b><span style=3D"color:#C00000">[JC] I think what y=
ou are suggesting would probably work, but my concern is that it is not imm=
ediate clear to me if bool ec will compile to 1. The spec for the SMU cmd d=
efines 1 to enable and 0 to disable<o:p></o:p></span></b></p>
<p class=3D"MsoNormal">if (en)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_send_smc_msg_with_param(smu,<=
o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; SMU_MSG_GmiPwrDnControl,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; 1,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return smu_send_smc_msg_with_param(smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp; SMU_MSG_GmiPwrDnControl,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp; 0,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp; NULL);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Patch 2: Reviewed-by: Guchun Chen <a href=3D"mailto:=
guchun.chen@amd.com">
guchun.chen@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Patch 3:<o:p></o:p></p>
<p class=3D"MsoNormal">1.function amdgpu_ras_error_inject_xgmi should be on=
e static function?
<b><span style=3D"color:#C00000">[JC] That makes sense, I&#8217;ll update f=
unction to be static<o:p></o:p></span></b></p>
<p class=3D"MsoNormal">2. Regarding below return case, is there one dpm_all=
ow_xgmi_power_down leak? As we have disabled xgmi link power down.<o:p></o:=
p></p>
<p class=3D"MsoNormal"><b><span style=3D"color:#C00000">[JC] I intentionall=
y did this, when the RAS int is triggered I don&#8217;t want to create any =
races conditions to access the SMU to perform functions and entering BACO r=
eset, the XGMI per link settings will be restored
 anyway after the BACO reset.<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"color:#C00000">[JC] That being sai=
d I understand that this looks like it could be a bug, I&#8217;ll add comme=
nts there to clarify the sequence<o:p></o:p></span></b></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_intr_triggered())<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Friday, May 8, 2020 2:51 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.=
com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] Series to disallow XGMI link power down during RAS =
XGMI error injection
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting 3 patches for review:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo3">Added host to SMU FW cmd to enable/disable XGMI link power down<o:p><=
/o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:=
l0 level1 lfo3">Added DPM function for XGMI link power down control<o:p></o=
:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0=
 level1 lfo3">Disable XGMI link power down prior to issuing a XGMI RAS erro=
r<o:p></o:p></li></ul>
</div>
</body>
</html>

--_000_MN2PR12MB40329140B89312E660E81D5CFBA20MN2PR12MB4032namp_--

--===============1218830848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1218830848==--
