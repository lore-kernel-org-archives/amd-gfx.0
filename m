Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A09C433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 02:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701FD2222E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 02:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LS0c/K/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701FD2222E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C77D289C18;
	Thu, 15 Oct 2020 02:49:34 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700048.outbound.protection.outlook.com [40.107.70.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1EA589C18
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 02:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8Khr+ClDah5Q8Z2n5soahqAtTZJ1wJldWO7fMCad0hDfSARfvQuFdH3lNTA24CFRlzteVMYxAihpYOQlJ0o1mz9/Cu1dRMfbbsf/sf23G1HY3CabPVn2wTOwRkG7jCnoL626k/OMmXdf0f4oyw0L8AIGqZ5zvzm8q9jGVDCNBmKO3tAqyHAH8XYSzJ7o5himVJr5vPC9Ru5bufrwhGeIKJ8m/aoFeWW4jlTBAqIfkgNZiN/sm+8fss/sXsupLEC1A1xvoQpTRQPuu5z0CnDSvOeHdVu83cwdJZqWFlP5Kry02V3R+gdYAYorklAVZBBOchePOo1m5ZXO3xaz6w1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT7rV9PEKH+7WyFFEd/bg0QknMxLDKcddpEQEKG4OrQ=;
 b=EE0SP3MsXml/vCYnRBZd9BMDnlpND6w1wIsU2Guk7LZoze2UrjFDytCNhsdVYUiVVfrO+jHxKIaogI23dYBLcS63VeboWa/vrCF4fAjxAKIChkexoA4ob1FwGHVcggRJlmTmzjoJ07jiP6lYatJ449M/THnJx2oNv6CngO8Tsi/IXJHj48AteDzNuW7DZHyu0zf9jR3sJme004ikTDWUtdrWV4M9OOnxZppIr+qX0RPSQ9tsmjFGqyNmcgsagFKZlEHodVuFfOBbmcfLe+tWiOGYT5v1o+cIxNubQnpLH0GJQeGY+mbPEN4Y4fv4kOnUeLIkdNIdZkv3korZ/+vwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT7rV9PEKH+7WyFFEd/bg0QknMxLDKcddpEQEKG4OrQ=;
 b=LS0c/K/vAp5x0L/8E4Av8v+HEbKYawRcd24kzS4KFoGzsD2NpefoZelRmiwDp0wZzm+EgyhkIsxgUSP8yHOTyPOiUHFDeQuwX0+czLhSDvuy8WebpOMtsR2iNWhzDugKrY6SOlcNTai5+8UavNjuhP2GSg0S8IOUG8rJZ5T9HoQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 02:49:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 02:49:32 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: disable gfxoff temporarily for
 navy_flounder"
Thread-Topic: [PATCH] Revert "drm/amdgpu: disable gfxoff temporarily for
 navy_flounder"
Thread-Index: AQHWop2h5bXlfjNPNUug/harnaF/n6mX9kUl
Date: Thu, 15 Oct 2020 02:49:32 +0000
Message-ID: <MN2PR12MB448877A5C83FD3A48A66B263F7020@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201015024653.35436-1-Jiansong.Chen@amd.com>
In-Reply-To: <20201015024653.35436-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-15T02:49:31.817Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8da4834-3d95-44bf-5c4f-08d870b4f1b5
x-ms-traffictypediagnostic: MN2PR12MB4503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4503C9A96FFA3F86C60A2861F7020@MN2PR12MB4503.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:298;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XvSdU2ruj+ROUa3kfyrZtnuD8kwC+664MISUbuiW2sz6uPkTj6He936zx/G8/K70ppEPdZ/NPAde9eupftIotZnUnB8TPa3PjePlGxCR6oTtO7b0lahsSHRT/9qnPGM+OBsUjuNfMwuBbyc1RDHHDlzAHqwqUZi/Q7GHGUwWKLnlN5abWzV6czKuwEHJQ6HffIBUzXkc/VKfnnrQk9cmz7yNiaElK8phJm4jdmSDctr2JbUee1RYbiUH5MWMdJSxBSPkAe0dBVlCKPhBPJ1ZtKeQxY3aDPPeFwcAElCxK1gYoYdG+XuYlT+ytcEhJEdlI70HPH+dfo2J7AWFG66osU5R4heOsrdDmmpBWML6O6M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(26005)(186003)(54906003)(8936002)(6506007)(110136005)(33656002)(8676002)(9686003)(83380400001)(53546011)(7696005)(166002)(316002)(66556008)(76116006)(66476007)(19627405001)(52536014)(86362001)(71200400001)(5660300002)(64756008)(45080400002)(478600001)(966005)(2906002)(66946007)(66446008)(4326008)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gbYWWtu0tR3v92kBgRGAgPTsY7iQmbu/4d0fMBKdtW2EZmdYW86//UgyKBhcAXbLh/uB5Q4AA787t1ySBX9b0ikt3c0Uso96gY+gRnBH3WIjabDBaJGAoCSPcdtez0QnaKkUnk4hog6Jg+5XP3yizubI4V0DNjSTex+f4vUO8wC1td+LiendXr74f4D7FUJ8thEVCbUI7WLQ55//KflN/fiUAuka4a09WyIK92OW+3tP3zSgZwDPJeQ+Bg2ZD2VeGdO9g0N+J5l/o+Mb6beWWP7YoRRFJa4iICqXzobOr69p+CKZsygmeoCTtOmfTUdC/vFM2zRDTeJHrygqoT8pWpmxhhI75a4R1PoQLhnj0t/r1krnCx81Qo1IttfQGhE3PX0PfqlzKYX0ismVyoiP62giCHfN9TDHeoklrnfJr/4sBqOeQs1lDGKsUBeFF6cIwy+PtD7Du+pYWqk8C2KgXCQ0jsoATJ/v3IKDoojynGK5e1ZUfulcf82tcBEopwxaIMJxnnPx1cPFksC2LYlDrsdkxSaEfi6dGEduApX8aPGL0vlBBRRBenAZ+r2Npbgkqw4WNpKfrIlbpXQeynZA7eVxtf8vyLy6unABUKj7FDs3ckj/ZG8JygYzGEVkiLhNwEMrjz3qzI4OAvYfzPGZqw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8da4834-3d95-44bf-5c4f-08d870b4f1b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 02:49:32.3369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0DrzZgu19RsGrd4fosghG8XO5uy9vW3dWE9RGDdVy7bBER91VwvnIQnYDqG4nPNcTw3MEVk1goehdbY36NFRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0041715476=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0041715476==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448877A5C83FD3A48A66B263F7020MN2PR12MB4488namp_"

--_000_MN2PR12MB448877A5C83FD3A48A66B263F7020MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jiansong=
 Chen <Jiansong.Chen@amd.com>
Sent: Wednesday, October 14, 2020 10:46 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@a=
md.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: disable gfxoff temporarily for navy_fl=
ounder"

This reverts commit 7e59138e97574e8dbecd1f259581277fff555d00.
TDR issue has been resovled by pmfw update.

Change-Id: Ia04709c4ba13835abfdec56558738bf6fbfac20d
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 8fc69c208adb..be13495b97f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3723,7 +3723,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu=
_device *adev)
                 if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
                         adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
                 break;
-       case CHIP_NAVY_FLOUNDER:
         case CHIP_VANGOGH:
                 adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
                 break;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C567c2489998d4d6b96f208d870b49e3a%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637383268948419311&amp;sdata=3Dg6fKcr%2BozqHqtFzId=
vv5R9ZzuOWj5sRrTqZ%2Bbhn9ruM%3D&amp;reserved=3D0

--_000_MN2PR12MB448877A5C83FD3A48A66B263F7020MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jiansong Chen &lt;Jiansong.Ch=
en@amd.com&gt;<br>
<b>Sent:</b> Wednesday, October 14, 2020 10:46 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Chen, Jiansong (Simon) &lt;Jiansong.Chen@amd.com&gt;; Zhou1, Tao=
 &lt;Tao.Zhou1@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br=
>
<b>Subject:</b> [PATCH] Revert &quot;drm/amdgpu: disable gfxoff temporarily=
 for navy_flounder&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This reverts commit 7e59138e97574e8dbecd1f25958127=
7fff555d00.<br>
TDR issue has been resovled by pmfw update.<br>
<br>
Change-Id: Ia04709c4ba13835abfdec56558738bf6fbfac20d<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 8fc69c208adb..be13495b97f1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -3723,7 +3723,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C567c2489998d4d6b96f208d870b49e3a%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637383268948419311&amp;amp;sdata=3D=
g6fKcr%2BozqHqtFzIdvv5R9ZzuOWj5sRrTqZ%2Bbhn9ruM%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7C567c2489998d4d6b96f208d870b49e3a%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637383268948419311&amp;amp;sdata=3Dg6fKcr%2BozqH=
qtFzIdvv5R9ZzuOWj5sRrTqZ%2Bbhn9ruM%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448877A5C83FD3A48A66B263F7020MN2PR12MB4488namp_--

--===============0041715476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0041715476==--
