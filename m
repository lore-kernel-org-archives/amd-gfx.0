Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0E3C11D3D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 20:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A6F2469C
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 20:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r+B98Gch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A6F2469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB1E6E0F5;
	Thu, 27 Feb 2020 20:39:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 954F66E0F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 20:39:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epkWVh8qKius8RRM2PWiBHxPC7RxTVe5iC+luI3LZLcZHt7iU9Fn5tYadPNuToyy48VlL+FGh0ulANXVlOMPm6lZ/AgO33QZFwDGB8QqAqAj2UHTbzO2jR6mAsABWEJ13WjaTY2J2bkBxYXOzhsShK7jWOTJpbDsExjzrcQu16zSEKBgykbcGvG0bcx2iIroAYGve5YtUEOICM17AvqbiqlhJA8sDxdjgRRZbw/xMVAploF9mE/NW0Nk7AoaCtnHhNuN2tFGByabwpDdSFwJUB7jKZ8HEZE9OphWbN5P/mHlySgLHvRe3j6MQjkcrpesW3eTfH32DczdDGVH3n8KXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsoN/t1hR9x7HReJK9yUebutVHF1ayCAmU6lZNxHnzc=;
 b=djFvrQSnMaSBgJiBCaLWI+cBALE16K4o7zKYtGowhfJ7sCH8EghPQCzj0VpzyRHm2QOtXc1WZUhWdmFxX+VxjDxZzlwCx4fDzptE/+wxd1e1YN7qhpRiJ4BHGWptjf/gQMEkWT+kxp2aE0poqI/teCmldU5qgcaJSqjgNdXvSphS4HQu3hSkpUth3NnyeV+9Ypx0QUAOOSrKdzjR98PIIUGwkhU+/7oWPnk+9uHusVk0KsfH50pUlJsd++ELfCUPnlyCrIyiUvnb0gm8ohPW45uqnKU3UCVMYus8Onwu0t7uuV6kfUWGPMwj/rzJF5YQhutvfnHWTZpW5bMixZ/lUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsoN/t1hR9x7HReJK9yUebutVHF1ayCAmU6lZNxHnzc=;
 b=r+B98GchOqSNQHaSOuVzL1dV+7d9YyBnR8wUPlWw13pcEqZmvfKtOf4Mjej3hz0qDxsduJJUJFoNe3hH9weVtUFLaNCFcssmQ4BIj1QZ3JwQjAWrIJ3zPVXfgqdoMsisXey7i9r3lEKh9NRg4R/KmTgQu8Hq/Se5/+tZq92pNsw=
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB3797.namprd12.prod.outlook.com (2603:10b6:610:27::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 20:39:21 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 20:39:21 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: remove unused variable
Thread-Topic: [PATCH 1/2] drm/amdgpu: remove unused variable
Thread-Index: AQHV7aqbmyoYyx3C5k2kXD4uD289BagvgIa4
Date: Thu, 27 Feb 2020 20:39:20 +0000
Message-ID: <CH2PR12MB392656F0C897C3B6780594B7F0EB0@CH2PR12MB3926.namprd12.prod.outlook.com>
References: <20200227201450.185953-1-alexander.deucher@amd.com>
In-Reply-To: <20200227201450.185953-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-27T20:39:20.299Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 382672a7-adfc-47b6-ac0c-08d7bbc51fdc
x-ms-traffictypediagnostic: CH2PR12MB3797:|CH2PR12MB3797:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB379701B1AFBBEDD0989974E6F0EB0@CH2PR12MB3797.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:419;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39850400004)(396003)(346002)(376002)(189003)(199004)(5660300002)(45080400002)(9686003)(55016002)(8936002)(33656002)(66446008)(91956017)(6506007)(66476007)(66556008)(64756008)(76116006)(66946007)(71200400001)(86362001)(52536014)(7696005)(966005)(110136005)(2906002)(4326008)(316002)(26005)(81166006)(8676002)(81156014)(53546011)(19627405001)(478600001)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3797;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /YXPvDTduGcG9QGTfeRl5LFDrqW0m5/BMkydbCLaE7UU0J1djpdS3FTumGZQ11ECio7OPfuUrKeY3qxFaCXAJOfCOrMTdQ0LorDxRrEaAUYNW1sWdeVEQnXcNBaXm9vWG1jxQBRkewI1H9JrNryIeiwRus1Stw8B7UXAjwIkh7Zeqm28HEtkzuWYtlyxALxK36wC8+7V3XrvWJtttcc7Dc15MgbpO5brX6v4dtegBBVb+mKJwMu4xWWje0fVgcwzxpjiPb5wSRu9lQG47TQUQeR9TB6WXIZg1gB2wfBwRwThJ8O1tdiXFwCHQRdzBxCeOsBiPKjuLtQ7I4WvvAanNsLsDx9TTUDYXNMx8rsvfXBvJfIe3zxUwu2TC5Cke2jv0sdCjYQb6Q7PjmMqtU18atlbRTgPLrVpbbTTy6yGRN/oM+AVKY9IpguYXmM1ESZty28icJM85vzsXcFY9FJYWj+Y0VlrEMNOg4hIBovW4wc=
x-ms-exchange-antispam-messagedata: gRxxHicJ+VEXtYQU7lwFKM8UOuKa8KWN45PZAttBhspf9mfLrbVtEry5nzCFaFH//AgA1smUXgHcjPgif4UQAvtYqvqprRIuvBx6XxzROo34JR/ezMWeMqRgm6muk3xjxoMn11nHM1WswVbuwo61Rg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382672a7-adfc-47b6-ac0c-08d7bbc51fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 20:39:21.1203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKGzRdc7b9pgXHL3+CUpxYKrPRlsnkw2kCo2EGteK/8ZKKlQQF059hfDikMFbDnY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3797
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============0360204160=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0360204160==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB392656F0C897C3B6780594B7F0EB0CH2PR12MB3926namp_"

--_000_CH2PR12MB392656F0C897C3B6780594B7F0EB0CH2PR12MB3926namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Yong Zhao <Yong.Zhao@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: Thursday, February 27, 2020 3:14 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: remove unused variable

Fixes a warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index bec4337156a7..b3e32969eb7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1131,7 +1131,6 @@ static void
 amdgpu_pci_remove(struct pci_dev *pdev)
 {
         struct drm_device *dev =3D pci_get_drvdata(pdev);
-       struct amdgpu_device *adev =3D dev->dev_private;

 #ifdef MODULE
         if (THIS_MODULE->state !=3D MODULE_STATE_GOING)
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cyong.zha=
o%40amd.com%7Ca4b7a490c31647472ca608d7bbc1bc24%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637184313087705310&amp;sdata=3DLNUqZiHj4Ey7KHjtp1o2c%2BpYO=
87JeL61VAYfNwNiE0Q%3D&amp;reserved=3D0

--_000_CH2PR12MB392656F0C897C3B6780594B7F0EB0CH2PR12MB3926namp_
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
Reviewed-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Thursday, February 27, 2020 3:14 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: remove unused variable</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes a warning.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index bec4337156a7..b3e32969eb7f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -1131,7 &#43;1131,6 @@ static void<br>
&nbsp;amdgpu_pci_remove(struct pci_dev *pdev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D=
 pci_get_drvdata(pdev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev-&g=
t;dev_private;<br>
&nbsp;<br>
&nbsp;#ifdef MODULE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (THIS_MODULE-&gt;state =
!=3D MODULE_STATE_GOING)<br>
-- <br>
2.24.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cyong.zhao%40amd.com%7Ca4b7a490c31647472ca608d7bbc1bc24%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637184313087705310&amp;amp;sdata=3DLNUqZiHj=
4Ey7KHjtp1o2c%2BpYO87JeL61VAYfNwNiE0Q%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cyong.zhao%40amd.=
com%7Ca4b7a490c31647472ca608d7bbc1bc24%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637184313087705310&amp;amp;sdata=3DLNUqZiHj4Ey7KHjtp1o2c%2BpYO87Je=
L61VAYfNwNiE0Q%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB392656F0C897C3B6780594B7F0EB0CH2PR12MB3926namp_--

--===============0360204160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0360204160==--
