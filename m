Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54075C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 12:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD772075C
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 12:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD772075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF0236E29A;
	Wed, 27 Nov 2019 12:36:05 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730085.outbound.protection.outlook.com [40.107.73.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F6416E29A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 12:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/C/oS0S7Ae6usX4JLD/JVZYIJhRo84HRFgoe5WIxrbqYmUk2Fail5/LqYSlHT5wcrm/aTM0Pf39axAY64+SIZkxSElmEEJiJVJw9z6193fBIoRd/sesXMk4LrX5ZPtrGjEb4prRq7j5ZWIBaKc/xXcnahsXV4HrjdhWsmTJwxM2es6Gn0hsykja+bm2c8ljMAARJz5b4EaSzw1SbJIJvlBZEyaTg9cd1au2mBZ/MLjA39yeO8amLc/i0ex5NSC7Sry5ysX77ept5Tlx6YDcUrXiBfVSjV73LdSyLOlmpKK1YGRpJEOr2XWimly9vwXYnSqmXPgWWUfV9Wi00xUDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKrf0++O3nnlDlOG4RAX8SuNzEKQkmv8nmL9q88OC7s=;
 b=ntxzQp7INGDqKdsTZLL88+EhSkp2xskHiUoGUSCc/Fcp8rU+Z5hxDvHq/7+TZ0obE5jLiGFnOzzNq9zeVgxDIpIBx4mKwmHUNJg3fecd6Tokmh3G/6KsIBkSBLJ5X8ojh60cP6pqG8gJag5SRrjdS1dv2pP/17VUvJ5J5+R6CUSl4zNj/85cjAFw5rOnqVliS+67L9l01mKx4LhAYLTKHm6YlxegvmWf6o7EwM+Z9iZPUrwtLeVb3ctkt43LSdDaFavud7dKiWUe0BHczdgcFci9+BtNlGSPBE0gLDD0c2NoF8a7Yr8d54yDrelD5NlMaKfiRj7qDbl2cGyJqiN4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) by
 MN2PR12MB3631.namprd12.prod.outlook.com (20.178.240.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 27 Nov 2019 12:35:57 +0000
Received: from MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5]) by MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5%6]) with mapi id 15.20.2495.014; Wed, 27 Nov 2019
 12:35:57 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 06/10] drm/amdgpu: add condition to enable baco for
 xgmi/ras case
Thread-Topic: [PATCH 06/10] drm/amdgpu: add condition to enable baco for
 xgmi/ras case
Thread-Index: AQHVpQNF8p3JP+rj2kWZAyQf5kXx/6ee4XoAgAAFO3A=
Date: Wed, 27 Nov 2019 12:35:57 +0000
Message-ID:
 <MN2PR12MB4285E37DF7D44270D5CAD0E5F6440@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-5-git-send-email-le.ma@amd.com>
 <DM5PR12MB141825CB772FEEF1FD013EDBFC440@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB141825CB772FEEF1FD013EDBFC440@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-11-27T11:03:26Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1deaade1-8d67-4c40-8ee3-0000834588a2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f2cf12c-9381-4b38-2225-08d773365a2a
x-ms-traffictypediagnostic: MN2PR12MB3631:|MN2PR12MB3631:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3631637C0F39C68442FC1B72F6440@MN2PR12MB3631.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(13464003)(199004)(189003)(186003)(26005)(76176011)(8936002)(4326008)(74316002)(11346002)(25786009)(52536014)(7736002)(6246003)(2501003)(2906002)(76116006)(5660300002)(81166006)(81156014)(99286004)(8676002)(102836004)(53546011)(86362001)(6506007)(110136005)(54906003)(54896002)(6306002)(316002)(66066001)(236005)(478600001)(66556008)(55016002)(66476007)(66446008)(64756008)(66946007)(14454004)(9686003)(446003)(256004)(14444005)(790700001)(3846002)(7696005)(6116002)(71190400001)(71200400001)(229853002)(6436002)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3631;
 H:MN2PR12MB4285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e5HnP+8lA92J/82vAOoU3StOW7wzQ4JOz76IrdRKWoz6R2WaV/TG3xhkCJvgGvG9JHEX0GAVGBT3CZdoyXX4BJZqSje1L7JWatA8Tr8KCuCaicyt9oATjiYQ40zZvnHPt+KIdpa9pYhYVJnNXhPJ9UTp2dbG5gWOCnZDlwqlQmODx6LHWc+ndhc1dQH7nCucNSc9RtmAsS8W72n3CJwbW+XkdFpckPeQsc4iiQm7pyQ+T5rs+S51+5IS6xkO1ngTT3ofkD0cCTGuaeSLBetF6T70DM7+4KtHKYCEMCpeviBxNkFniyZQCe91P0lDRFeNFQfsUbvOhpzgN92yI2MR5+Z30aAnID0S0z2mI+JT6M4/v6tye56zG/Ow1TqXaf3Q0vib+Wbc39GRX8ANOxuN2f0pvAeQCRi0pU5AoXBERjOz0QYvb4fYdi2ousLmH/Bc
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2cf12c-9381-4b38-2225-08d773365a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 12:35:57.1983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jC71nEBQRogfrWHk2cgs79MHdtKqE9d7uwj3+UOd8Opu24Dq/M86Qa7zLldGO8+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3631
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKrf0++O3nnlDlOG4RAX8SuNzEKQkmv8nmL9q88OC7s=;
 b=If/xYTY/hQ9D3ZJIFPIEZNHliyYmcoFnIynP52omZqkKD4or2Io2jfz9jb8ED4l/Pfs9QY3cNOpivFJdH8PlYQQ28KzvfldpiTha9y8kqkxrvrOCMgEi7yiYJjM0yWVla+IyHWSI5H+2lX5TrnpB5L+13oUC0IE1tOddxl9tdQE=
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
 Tao" <Tao.Zhou1@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Content-Type: multipart/mixed; boundary="===============1598236071=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127123557.t6hdpWeERzLydbQCd-cmZ8Ezdf-AUrbq-85n6WHKSbQ@z>

--===============1598236071==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4285E37DF7D44270D5CAD0E5F6440MN2PR12MB4285namp_"

--_000_MN2PR12MB4285E37DF7D44270D5CAD0E5F6440MN2PR12MB4285namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Agree with your thoughts that we drop amdgpu_ras_enable=3D2 condition. The =
only concern in my side is that besides fatal_error, another result may hap=
pen that atombios_init timeout on xgmi by baco (not sure psp mode1 reset ca=
uses this as well).



Assuming no amdgpu_ras_enable=3D2 check, if PMFW > 40.52,  the use cases as=
 my understanding includes:

  1.  sGPU without RAS:
     *   new: baco
     *   old: baco
  2.  sGPU with RAS:

  *   new: baco
  *   old: psp mode1 chain reset and legacy fatal_error handling

  1.  XGMI with RAS: baco
     *   new: baco
     *   old: psp mode1 chain reset and legacy fatal_error handling
  2.  XGMI without RAS: baco
     *   new: baco
     *   old: psp mode1 chain reset



That is to say, all uses cases go on baco road when PMFW > 40.52.



Regards,

Ma Le



-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, November 27, 2019 7:28 PM
To: Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,=
 Dennis <Dennis.Li@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>=
; Ma, Le <Le.Ma@amd.com>
Subject: RE: [PATCH 06/10] drm/amdgpu: add condition to enable baco for xgm=
i/ras case



[AMD Public Use]



After thinking it a bit, I think we can just rely on PMFW version to decide=
 to go RAS recovery or legacy fatal_error handling for the platforms that s=
upport RAS. Leveraging amdgpu_ras_enable as a temporary solution seems not =
necessary? Even baco ras recovery not stable, it is the same result as lega=
cy fatal_error handling that user has to reboot the node manually.



So the new soc reset use cases are:

XGMI (without RAS): use PSP mode1 based chain reset, RAS enabled (with PMFW=
 40.52 and onwards): use BACO based RAS recovery, RAS enabled (with PMFW pr=
ior to 40.52): use legacy fatal_error handling.

Anything else?



Regards,

Hawking

-----Original Message-----

From: Le Ma <le.ma@amd.com<mailto:le.ma@amd.com>>

Sent: 2019=1B$BG/=1B(B11=1B$B7n=1B(B27=1B$BF|=1B(B 17:15

To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>

Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; C=
hen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Zhou1, Tao <=
Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Li, Dennis <Dennis.Li@amd.com=
<mailto:Dennis.Li@amd.com>>; Deucher, Alexander <Alexander.Deucher@amd.com<=
mailto:Alexander.Deucher@amd.com>>; Ma, Le <Le.Ma@amd.com<mailto:Le.Ma@amd.=
com>>

Subject: [PATCH 06/10] drm/amdgpu: add condition to enable baco for xgmi/ra=
s case



Avoid to change default reset behavior for production card by checking amdg=
pu_ras_enable equal to 2. And only new enough smu ucode can support baco fo=
r xgmi/ras case.



Change-Id: I07c3e6862be03e068745c73db8ea71f428ecba6b

Signed-off-by: Le Ma <le.ma@amd.com<mailto:le.ma@amd.com>>

---

drivers/gpu/drm/amd/amdgpu/soc15.c | 4 +++-

1 file changed, 3 insertions(+), 1 deletion(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c

index 951327f..6202333 100644

--- a/drivers/gpu/drm/amd/amdgpu/soc15.c

+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c

@@ -577,7 +577,9 @@ soc15_asic_reset_method(struct amdgpu_device *adev)

                                   struct amdgpu_hive_info *hive =3D amdgpu=
_get_xgmi_hive(adev, 0);

                                   struct amdgpu_ras *ras =3D amdgpu_ras_ge=
t_context(adev);

-                                   if (hive || (ras && ras->supported))

+                                  if ((hive || (ras && ras->supported)) &&

+                                      (amdgpu_ras_enable !=3D 2 ||

+                                      adev->pm.fw_version <=3D 0x283400))

                                               baco_reset =3D false;

                       }

                       break;

--

2.7.4

--_000_MN2PR12MB4285E37DF7D44270D5CAD0E5F6440MN2PR12MB4285namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
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
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"\@Microsoft YaHei";}
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
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:758333370;
	mso-list-type:hybrid;
	mso-list-template-ids:-1255109936 67698703 67698689 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:39.0pt;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:75.0pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:111.0pt;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:183.0pt;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:219.0pt;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:255.0pt;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:291.0pt;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:327.0pt;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1100415748;
	mso-list-type:hybrid;
	mso-list-template-ids:-1587907358 67698689 67698691 67698693 67698689 6769=
8691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:75.0pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:111.0pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:183.0pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:219.0pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:255.0pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:291.0pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:327.0pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:363.0pt;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Agree with your thoughts that we drop amdgpu_ras_=
enable=3D2 condition. The only concern in my side is that besides fatal_err=
or, another result may happen that atombios_init timeout on xgmi by baco (n=
ot sure psp mode1 reset causes this
 as well). <o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Assuming no amdgpu_ras_enable=3D2 check, if PMFW =
&gt; 40.52, &nbsp;the use cases as my understanding includes:
<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level1 lf=
o1">sGPU without RAS:<o:p></o:p></li><ul style=3D"margin-top:0in" type=3D"d=
isc">
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level2 lf=
o1">new: baco<o:p></o:p></li><li class=3D"MsoPlainText" style=3D"margin-lef=
t:3.0pt;mso-list:l0 level2 lfo1">old: baco<o:p></o:p></li></ul>
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level1 lf=
o1">sGPU with RAS:<o:p></o:p></li></ol>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoPlainText" style=3D"margin-left:39.0pt;mso-list:l1 level1 l=
fo2">new: baco<o:p></o:p></li><li class=3D"MsoPlainText" style=3D"margin-le=
ft:39.0pt;mso-list:l1 level1 lfo2">old: psp mode1 chain reset and legacy fa=
tal_error handling<o:p></o:p></li></ul>
<ol style=3D"margin-top:0in" start=3D"3" type=3D"1">
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level1 lf=
o1">XGMI with RAS: baco<o:p></o:p></li><ul style=3D"margin-top:0in" type=3D=
"disc">
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level2 lf=
o1">new: baco<o:p></o:p></li><li class=3D"MsoPlainText" style=3D"margin-lef=
t:3.0pt;mso-list:l0 level2 lfo1">old: psp mode1 chain reset and legacy fata=
l_error handling<o:p></o:p></li></ul>
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level1 lf=
o1">XGMI without RAS: baco<o:p></o:p></li><ul style=3D"margin-top:0in" type=
=3D"disc">
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level2 lf=
o1">new: baco<o:p></o:p></li><li class=3D"MsoPlainText" style=3D"margin-lef=
t:3.0pt;mso-list:l0 level2 lfo1">old: psp mode1 chain reset<o:p></o:p></li>=
</ul>
</ol>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">That is to say, all uses cases go on baco road wh=
en PMFW &gt; 40.52.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Ma Le<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt; <br>
Sent: Wednesday, November 27, 2019 7:28 PM<br>
To: Ma, Le &lt;Le.Ma@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
Cc: Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.=
com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&gt;; Deucher, Alexander &lt;Alexa=
nder.Deucher@amd.com&gt;; Ma, Le &lt;Le.Ma@amd.com&gt;<br>
Subject: RE: [PATCH 06/10] drm/amdgpu: add condition to enable baco for xgm=
i/ras case</p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">[AMD Public Use]<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">After thinking it a bit, I think we can just rely=
 on PMFW version to decide to go RAS recovery or legacy fatal_error handlin=
g for the platforms that support RAS. Leveraging amdgpu_ras_enable as a tem=
porary solution seems not necessary?
 Even baco ras recovery not stable, it is the same result as legacy fatal_e=
rror handling that user has to reboot the node manually.
<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">So the new soc reset use cases are:<o:p></o:p></p=
>
<p class=3D"MsoPlainText">XGMI (without RAS): use PSP mode1 based chain res=
et, RAS enabled (with PMFW 40.52 and onwards): use BACO based RAS recovery,=
 RAS enabled (with PMFW prior to 40.52): use legacy fatal_error handling.<o=
:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">Anything else?<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Hawking<o:p></o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<o:p></o:p></p>
<p class=3D"MsoPlainText">From: Le Ma &lt;<a href=3D"mailto:le.ma@amd.com">=
<span style=3D"color:windowtext;text-decoration:none">le.ma@amd.com</span><=
/a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">Sent: 2019<span lang=3D"ZH-CN" style=3D"font-fami=
ly:&quot;Microsoft YaHei&quot;,sans-serif">=1B$BG/=1B(B</span>11<span lang=
=3D"ZH-CN" style=3D"font-family:&quot;Microsoft YaHei&quot;,sans-serif">=1B=
$B7n=1B(B</span>27<span lang=3D"ZH-CN" style=3D"font-family:&quot;Microsoft=
 YaHei&quot;,sans-serif">=1B$BF|=1B(B</span>
 17:15<o:p></o:p></p>
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
<p class=3D"MsoPlainText">Subject: [PATCH 06/10] drm/amdgpu: add condition =
to enable baco for xgmi/ras case<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Avoid to change default reset behavior for produc=
tion card by checking amdgpu_ras_enable equal to 2. And only new enough smu=
 ucode can support baco for xgmi/ras case.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Change-Id: I07c3e6862be03e068745c73db8ea71f428ecb=
a6b<o:p></o:p></p>
<p class=3D"MsoPlainText">Signed-off-by: Le Ma &lt;<a href=3D"mailto:le.ma@=
amd.com"><span style=3D"color:windowtext;text-decoration:none">le.ma@amd.co=
m</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">---<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/soc15.c | 4 &#43;&#43;=
&#43;-<o:p></o:p></p>
<p class=3D"MsoPlainText">1 file changed, 3 insertions(&#43;), 1 deletion(-=
)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b=
/drivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index 951327f..6202333 100644<o:p></o:p></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc1=
5.c<o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -577,7 &#43;577,9 @@ soc15_asic_reset_method(s=
truct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev, 0);<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);<o:p></o:p></=
p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (hive || (ras &amp;&amp; ras-&gt;supported))<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if ((hive || (ras &amp;&amp; ras-&gt;supported)) &amp;&amp;<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; (amdgpu_ras_enable !=3D 2 ||<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; adev-&gt;pm.fw_version &lt;=3D 0x283400))<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; baco_reset =3D false;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoPlainText">--<o:p></o:p></p>
<p class=3D"MsoPlainText">2.7.4<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4285E37DF7D44270D5CAD0E5F6440MN2PR12MB4285namp_--

--===============1598236071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1598236071==--
