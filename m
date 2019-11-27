Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F5CC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8242070A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8242070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A2276E4DE;
	Wed, 27 Nov 2019 09:55:02 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730073.outbound.protection.outlook.com [40.107.73.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321946E4F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 09:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOQ6GTRHik5OVEW6241RxEGH4ESl+QJyC9OKkXzHCB4+rq33g+tI2wO/6Kdoc8fGJN6g65CDc2zPC9l/fVyxFWe5V7MjcvImNozVIF/5eRUAF2lZm3YFsbDUNXTAHaLcUL6rEv9xjRi+t7lUN+VabG6FK/susrd4DggRv4qUM8D2BbJtqon+5EWSBD0Yx+abig4FzOVRK2CeFxbQB7e/2uipJrinbeAuo1hc6ob4UtaZZfCu3s16EC089GTzrV8V6nlArXxgoxTun6IHFpUxqjaQ9xdwknJ/NsrXtzgqkg3gloLprxNhlDZOLno63H84BUFxPs27+3hoq5NPhGonyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1l2il6aEsx+FUx0aiozbRawhcK/VOm145aUthwvWpE=;
 b=QqXvg5yzxWT5+pO4XH3742XLyz616l01OBuvYcYPXCQnvaWslzw9wikzr96zwN83IVQcP5tzvvNseWea4MTSPB35uElKqRscybJeWW1TR3hy3L84zoQXnw4ZDl3/YijZ7KCiRzlb68z8B4JaBt0XGCHhAi1yQcbEBcbf010+ylA+IFL++aI1nBPajK00hcOwtc7NlLTbwV2syrJ+T8UyyfmW50lJW/tkq76EQ32yrYouTkmqBqbf5baJOyjgIxEkGpXWgH/eg5rXbClx/nkoLx0WIJgp6DIKvhtYegqvTlfteqtLAdBB6CfexrCx1bTVBqxrypQl83TH5r5zPHKNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) by
 MN2PR12MB2912.namprd12.prod.outlook.com (20.179.81.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Wed, 27 Nov 2019 09:54:56 +0000
Received: from MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5]) by MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5%6]) with mapi id 15.20.2495.014; Wed, 27 Nov 2019
 09:54:56 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 10/10] drm/amdgpu: reduce redundant uvd context lost
 warning message
Thread-Topic: [PATCH 10/10] drm/amdgpu: reduce redundant uvd context lost
 warning message
Thread-Index: AQHVpQNSJkgVwI5gBk2xZbbZOexldqeexeYAgAABQnA=
Date: Wed, 27 Nov 2019 09:54:56 +0000
Message-ID:
 <MN2PR12MB42858C745C5D0D125236BD51F6440@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-9-git-send-email-le.ma@amd.com>
 <BYAPR12MB280648A1C59519AA77B3FCA9F1440@BYAPR12MB2806.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB280648A1C59519AA77B3FCA9F1440@BYAPR12MB2806.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-27T09:49:27Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fd28ad11-65ce-4d69-bfb5-0000331a5625;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3a53736-478b-489a-f4d7-08d7731fdbfb
x-ms-traffictypediagnostic: MN2PR12MB2912:|MN2PR12MB2912:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB291265AD066FF85DC4D14C81F6440@MN2PR12MB2912.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(189003)(199004)(13464003)(25786009)(53546011)(6506007)(76176011)(110136005)(446003)(66556008)(99286004)(66066001)(76116006)(52536014)(11346002)(7736002)(316002)(66946007)(66446008)(14454004)(74316002)(3846002)(6246003)(64756008)(86362001)(256004)(14444005)(186003)(33656002)(790700001)(2906002)(2420400007)(54906003)(5660300002)(6116002)(102836004)(26005)(6436002)(2501003)(9686003)(236005)(478600001)(7110500001)(6306002)(229853002)(66476007)(55016002)(15650500001)(8676002)(81156014)(81166006)(71200400001)(54896002)(7696005)(4326008)(8936002)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2912;
 H:MN2PR12MB4285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CnbVMfBKYdm8AvDpJVF62Mw/xtlDdHq/Q9gJ3sCrsDTnRldq0pn9nyRz+OTMlReprabJQ/iJwEhD/bTZ8zmXVaR4zWKGMf4ZQVJ9mvJpEY71HzpMPdCAg6Dusi1TMzHgqlsncy5BzgoGFeExdBqbSyC2nyLQDoofBEcGemCU7LzD2JuP0lHBoy4Bp3GkkE3RMj74wujUAciOKqciTFQLobjAQgDEdJ6Rwt0nj5zKvLP9gsx8qzGK8ANqnEBVZjkwUqSipcSaifBIkgyI+orXA/JL1aN/UX1WW9Q8lrUPQ8qSiacN3hO0Hzwb/2/zyA4UPlnRyb3nyL3pI9rLgRM+WGboJ5bwgvLQZT3N5IRqrldO4x1C5vH7/Is/+7P79uUnbmSAEpZ0S3Jo7FpXBv2LpZ92bZRxw6ylRhpeq8iXAJPiWAclRTCQuQtsY2aG5vGV
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a53736-478b-489a-f4d7-08d7731fdbfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 09:54:56.7271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ibPJe90zFpUU7kBCioj+jgcRtMqITbjm28Hz1Ee1PKiy85UAHzkntXGWFri/1l+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2912
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1l2il6aEsx+FUx0aiozbRawhcK/VOm145aUthwvWpE=;
 b=L2fB6pwyhEVlZsi8g+SY4UqwyBm0os6txm4aQ3+Rc3rv+vix67l0Z2qs+I+/RkYL9wE3vr/Gbms7sBuE/K8AQe7qXeg5VH1d4eflrXvX2UAHpKHpcTwOkDIjDV2Cx3l/I9CUv1N57D9AS39C72/9t99E7zicWnAGwr+SVynne6s=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Le.Ma@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1626797980=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127095456.tbvDlpQvZg2ZzhAMNNaBB8XPOxE998LKu4-5lKtkpfk@z>

--===============1626797980==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB42858C745C5D0D125236BD51F6440MN2PR12MB4285namp_"

--_000_MN2PR12MB42858C745C5D0D125236BD51F6440MN2PR12MB4285namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable





-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Wednesday, November 27, 2019 5:50 PM
To: Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Dennis <Dennis.Li@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.=
com>; Ma, Le <Le.Ma@amd.com>
Subject: RE: [PATCH 10/10] drm/amdgpu: reduce redundant uvd context lost wa=
rning message



[AMD Official Use Only - Internal Distribution Only]









-----Original Message-----

From: Le Ma <le.ma@amd.com<mailto:le.ma@amd.com>>

Sent: Wednesday, November 27, 2019 5:15 PM

To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>

Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; C=
hen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Zhou1, Tao <=
Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Li, Dennis <Dennis.Li@amd.com=
<mailto:Dennis.Li@amd.com>>; Deucher, Alexander <Alexander.Deucher@amd.com<=
mailto:Alexander.Deucher@amd.com>>; Ma, Le <Le.Ma@amd.com<mailto:Le.Ma@amd.=
com>>

Subject: [PATCH 10/10] drm/amdgpu: reduce redundant uvd context lost warnin=
g message



Move the print out of uvd instance loop in amdgpu_uvd_suspend



Change-Id: Ifad997debd84763e1b55d668e144b729598f115e

Signed-off-by: Le Ma <le.ma@amd.com<mailto:le.ma@amd.com>>

---

drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 5 ++++-

1 file changed, 4 insertions(+), 1 deletion(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_uvd.c

index e324bfe..ac7c7795 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c

@@ -377,12 +377,15 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)

                        /* re-write 0 since err_event_athub will corrupt VC=
PU buffer */

                       if (amdgpu_ras_intr_triggered()) {

-                                   DRM_WARN("UVD VCPU state may lost due t=
o RAS ERREVENT_ATHUB_INTERRUPT\n");

                                   memset(adev->uvd.inst[j].saved_bo, 0, si=
ze);

                       } else {

                                   memcpy_fromio(adev->uvd.inst[j].saved_bo=
, ptr, size);

                       }

           }

+

+          if (amdgpu_ras_intr_triggered()) {

+                      DRM_WARN("UVD VCPU state may lost due to RAS ERREVEN=
T_ATHUB_INTERRUPT\n");

+

[Guchun]the "{" after the if condition needs to be removed?

[Le] Yes, sent it too quickly and made a mistake here.

           return 0;

}

--

2.7.4

--_000_MN2PR12MB42858C745C5D0D125236BD51F6440MN2PR12MB4285namp_
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:14.0pt;
	font-family:"Calibri",sans-serif;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<div class=3D"WordSection1">
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Chen, Guchun &lt;Guchun.Chen@amd.com&gt; <br>
Sent: Wednesday, November 27, 2019 5:50 PM<br>
To: Ma, Le &lt;Le.Ma@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&gt;; Deucher, Alexander &lt;A=
lexander.Deucher@amd.com&gt;; Ma, Le &lt;Le.Ma@amd.com&gt;<br>
Subject: RE: [PATCH 10/10] drm/amdgpu: reduce redundant uvd context lost wa=
rning message</p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">[AMD Official Use Only - Internal Distribution On=
ly]<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<o:p></o:p></p>
<p class=3D"MsoPlainText">From: Le Ma &lt;<a href=3D"mailto:le.ma@amd.com">=
<span style=3D"color:windowtext;text-decoration:none">le.ma@amd.com</span><=
/a>&gt;
<o:p></o:p></p>
<p class=3D"MsoPlainText">Sent: Wednesday, November 27, 2019 5:15 PM<o:p></=
o:p></p>
<p class=3D"MsoPlainText">To: <a href=3D"mailto:amd-gfx@lists.freedesktop.o=
rg"><span style=3D"color:windowtext;text-decoration:none">amd-gfx@lists.fre=
edesktop.org</span></a><o:p></o:p></p>
<p class=3D"MsoPlainText">Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.=
Zhang@amd.com"><span style=3D"color:windowtext;text-decoration:none">Hawkin=
g.Zhang@amd.com</span></a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:Guchun.C=
hen@amd.com"><span style=3D"color:windowtext;text-decoration:none">Guchun.C=
hen@amd.com</span></a>&gt;;
 Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com"><span style=3D"color:w=
indowtext;text-decoration:none">Tao.Zhou1@amd.com</span></a>&gt;; Li, Denni=
s &lt;<a href=3D"mailto:Dennis.Li@amd.com"><span style=3D"color:windowtext;=
text-decoration:none">Dennis.Li@amd.com</span></a>&gt;;
 Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com"><span =
style=3D"color:windowtext;text-decoration:none">Alexander.Deucher@amd.com</=
span></a>&gt;; Ma, Le &lt;<a href=3D"mailto:Le.Ma@amd.com"><span style=3D"c=
olor:windowtext;text-decoration:none">Le.Ma@amd.com</span></a>&gt;<o:p></o:=
p></p>
<p class=3D"MsoPlainText">Subject: [PATCH 10/10] drm/amdgpu: reduce redunda=
nt uvd context lost warning message<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Move the print out of uvd instance loop in amdgpu=
_uvd_suspend<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Change-Id: Ifad997debd84763e1b55d668e144b729598f1=
15e<o:p></o:p></p>
<p class=3D"MsoPlainText">Signed-off-by: Le Ma &lt;<a href=3D"mailto:le.ma@=
amd.com"><span style=3D"color:windowtext;text-decoration:none">le.ma@amd.co=
m</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">---<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 5 &#43;=
&#43;&#43;&#43;-<o:p></o:p></p>
<p class=3D"MsoPlainText">1 file changed, 4 insertions(&#43;), 1 deletion(-=
)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uv=
d.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index e324bfe..ac7c7795 100644<o:p></o:p></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<o:p=
></o:p></p>
<p class=3D"MsoPlainText">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdg=
pu_uvd.c<o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -377,12 &#43;377,15 @@ int amdgpu_uvd_suspend(=
struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* re-write 0 since err_event_athub will corrupt VCPU buffer=
 */<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (amdgpu_ras_intr_triggered()) {<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; DRM_WARN(&quot;UVD VCPU state may lost due to RAS ERREVENT_ATHUB_INT=
ERRUPT\n&quot;);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; memset(adev-&gt;uvd.inst[j].saved_bo, 0, size);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; } else {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 memcpy_fromio(adev-&gt;uvd.inst[j].saved_bo, ptr, size);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ras_intr_triggered()) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_WARN(&quot;UVD VCPU state may lost due to RAS ERREVENT_ATHUB_IN=
TERRUPT\n&quot;);<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">[Guchun]the &quot;{&quot; after the if condition =
needs to be removed?<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864;mso-style-textfill-f=
ill-color:#203864;mso-style-textfill-fill-alpha:100.0%">[Le] Yes, sent it t=
oo quickly and made a mistake here.<o:p></o:p></span></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">}<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">-- <o:p></o:p></p>
<p class=3D"MsoPlainText">2.7.4<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB42858C745C5D0D125236BD51F6440MN2PR12MB4285namp_--

--===============1626797980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1626797980==--
