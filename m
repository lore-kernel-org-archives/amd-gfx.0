Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D00C04EB5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C9E20838
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mSEeFWWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C9E20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A2D88985A;
	Fri,  7 Feb 2020 15:20:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD458985A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXIEsKQR6m73wOhlRp3CAheUTpEQZxckNzXsJ56GGljjfeBxOmb/MxqJV3D6xXcl2NNbnddifu2fW1hzIfFIhHPjhs09rX77YZaHSYg8p5cnxFu3jjKAXHVmiGSCDRVuZ4Vh15v9IW7eiAxa+zxnlW++5Pjce6n/xMg8QXj/1yWdAzbU7NRe3fA9ksXDo4BmE/OTH5kpVpSn4xM95THUGm6lAEtXgZQ3d8JyE69AJfGiT8c0JmWBsN5gbOmVAtGj8Y22aqxp9j1jnpkogUJdumm8X0u5ieyuTlYtu2B7MZRJd2JRUXOVNU7dHZgWy2RAGl6hKcVUXvO79d0pNBbGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id7NpakiG6eDhTFn2nynSmiEIex62j7UaI6X1yTMMxA=;
 b=Vm0/5PSKoXqEvmp8NEF82rFwa9rjaDw5hhytorRH0Gmd+fiRFOjylPRrEdZpL2WV96+s9FEgljGaIPE1TcI+S4iDPXS19R2ys/lu6KQ7x+X6SQqjeBK4uy7b7WO1bkkNdik0O3m3zChGbLPnAtxycFzclWV41pTk3LMBmKeLEPqMyvydzeG3rh825zQ7dq1lqAEC+Tl0wEOawGkXMSRoeVznjo/+1GXa+fR3kY0iH86Oi6sOeNOLApyurXOxa2i/aSwujPhf3007VJlTHiTNvkUns1u18kvUFPHbgf+AvIcz7lzSh/n1KpipqXSzffOC7xALxcEt1wnfqD0kDeOsvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id7NpakiG6eDhTFn2nynSmiEIex62j7UaI6X1yTMMxA=;
 b=mSEeFWWSgQqTNI0CBWSI+D3PhQPvIgXxV3fiTg1UWSQNbUn8/tc92DB0nXq3itaSWGxKmM8JAQlWRWB9CqUM4OYutZpmX/JaNJEF5HOY75V5oY7QasOauSZd0IxNv9DUL8VoNxifzPiiVl0gHYvH7uc5iFCzafvGE5A8QMA7WjQ=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (52.132.246.86) by
 CH2PR12MB4053.namprd12.prod.outlook.com (20.180.17.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Fri, 7 Feb 2020 15:20:57 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:20:57 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/sriov set driver_table address in VF
Thread-Topic: [PATCH] drm/amdgpu/sriov set driver_table address in VF
Thread-Index: AQHV3Zw7xmG0Q7wkKU6Lhh3m37G74KgP2QzK
Date: Fri, 7 Feb 2020 15:20:56 +0000
Message-ID: <CH2PR12MB391237E1E662421D053CD57AF71C0@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <1581069102-18302-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1581069102-18302-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-07T15:20:56.357Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95a41140-8e60-4bf5-3768-08d7abe1548d
x-ms-traffictypediagnostic: CH2PR12MB4053:|CH2PR12MB4053:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB40538877EA49FE2C62BBA457F71C0@CH2PR12MB4053.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(6506007)(53546011)(71200400001)(33656002)(186003)(7696005)(2906002)(478600001)(19627405001)(26005)(64756008)(66556008)(66476007)(66946007)(66446008)(86362001)(76116006)(52536014)(5660300002)(110136005)(8936002)(316002)(45080400002)(8676002)(81166006)(81156014)(966005)(9686003)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4053;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4QWF47Ikcxfs5ErVIYnMbAVdw8kOD/P9YkWlQcWnkNULdD9MXLOeBq5kx0ZoP3wC1R2xvIvlw5lGw17+EKW5P9d4D9lQBRTN4aS6cdoD+U6NpcyDm/aJdCoo06OBB6Y02cuE/gdIRv8gXfQT8f4CHaU0+RkK9FdQDfhIjog22dbSpGyqreE9p3sPkPim1gQcU3FsNa3jBHIrd6xFT2dXGGpXe6ZmgOkQJnWcgDKfZANz+lKel0Y12UDNfiedktNE21cy/uI/uTKvjXzLuaITLL3yO4rt4FwUEqmAxvnotS12IdYIUY1yLEC+mGbEgToiXJFTpknknvP96tQ/c33VN38VpV1LCZqO10wp9zeRnJXCY2ieA9B9Bm53ts8zM4jmTIl2D3kXnUC5yQVnFmz6/8gxAesvcSu3/P1PGCQGMQ5/+lpHtVeqRrNBK2IzmDht68FVo15GX1GDoRECLGExW22CwqvLB1jDtPSUvht+Qj1Eb5AktUi1WCEj1o1RjuPFZaj//mgv1Cx3fs2NSvkmWg==
x-ms-exchange-antispam-messagedata: KRA4TcUEK1Hvq6BCV7vv++FL+2jUkHNFCGRbiausEi5nJFoMDz3jhkddxRBZNXJPpjDJsfVO8QiooN9b//l00Z5Jj+AjZnXhvMkvWg8MdzIXsUPm1/FQfornkbn51eCk7xVj7g9ta+YVSqY2qFbTpg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a41140-8e60-4bf5-3768-08d7abe1548d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 15:20:56.9007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SoDWZI98FbEz4sVWhRrcFHU5EXeybwLInvKPX8ITSwnysQdPpH5Dhww8HlsF7PQMZkhHYvhxBJsZvvMDaalu2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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
Content-Type: multipart/mixed; boundary="===============1820669914=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1820669914==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB391237E1E662421D053CD57AF71C0CH2PR12MB3912namp_"

--_000_CH2PR12MB391237E1E662421D053CD57AF71C0CH2PR12MB3912namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jack Zha=
ng <Jack.Zhang1@amd.com>
Sent: Friday, February 7, 2020 4:51 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amdgpu/sriov set driver_table address in VF

With the recent patch to unify VRAM address for driver
table(a83f82e). VF cannot dump table info any more because
SMU_MSG_SetDriverDramAddrHigh/Low were deleted in the
function of smu_update_table.

Therefore, VF also needs to set driver_table address
in smu_hw_init to fix this regression issue.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 99ad4dd..b155f04 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1113,12 +1113,12 @@ static int smu_smc_table_hw_init(struct smu_context=
 *smu,
                         return ret;
         }

+       ret =3D smu_set_driver_table_location(smu);
+       if (ret)
+               return ret;
+
         /* smu_dump_pptable(smu); */
         if (!amdgpu_sriov_vf(adev)) {
-               ret =3D smu_set_driver_table_location(smu);
-               if (ret)
-                       return ret;
-
                 /*
                  * Copy pptable bo in the vram to smc with SMU MSGs such a=
s
                  * SetDriverDramAddr and TransferTableDram2Smu.
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Caf208aa3ff7b4af7901308d7abb35adb%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637166659148950161&amp;sdata=3Dy56uFDZzrgroC8VLFTQ=
sB8Oe0%2BmNyIoMoMvNrjqhrIs%3D&amp;reserved=3D0

--_000_CH2PR12MB391237E1E662421D053CD57AF71C0CH2PR12MB3912namp_
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
ounces@lists.freedesktop.org&gt; on behalf of Jack Zhang &lt;Jack.Zhang1@am=
d.com&gt;<br>
<b>Sent:</b> Friday, February 7, 2020 4:51 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sriov set driver_table address in VF</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">With the recent patch to unify VRAM address for dr=
iver<br>
table(a83f82e). VF cannot dump table info any more because<br>
SMU_MSG_SetDriverDramAddrHigh/Low were deleted in the<br>
function of smu_update_table.<br>
<br>
Therefore, VF also needs to set driver_table address<br>
in smu_hw_init to fix this regression issue.<br>
<br>
Signed-off-by: Jack Zhang &lt;Jack.Zhang1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 8 &#43;&#43;&#43;&#43;--=
--<br>
&nbsp;1 file changed, 4 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 99ad4dd..b155f04 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -1113,12 &#43;1113,12 @@ static int smu_smc_table_hw_init(struct smu_con=
text *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_driver_table_loca=
tion(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* smu_dump_pptable(smu); =
*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)=
) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_set_driver_table_location(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * Copy pptable bo in the vram to smc with SMU M=
SGs such as<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * SetDriverDramAddr and TransferTableDram2Smu.<=
br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Caf208aa3ff7b4af7901308d7abb35adb%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637166659148950161&amp;amp;sdata=3D=
y56uFDZzrgroC8VLFTQsB8Oe0%2BmNyIoMoMvNrjqhrIs%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Caf208aa3ff7b4af7901308d7abb35adb%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637166659148950161&amp;amp;sdata=3Dy56uFDZzrgroC8V=
LFTQsB8Oe0%2BmNyIoMoMvNrjqhrIs%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB391237E1E662421D053CD57AF71C0CH2PR12MB3912namp_--

--===============1820669914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1820669914==--
