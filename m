Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817D9C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 15:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466D52070E
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 15:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466D52070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCCD16E32D;
	Thu, 14 Nov 2019 15:19:35 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700054.outbound.protection.outlook.com [40.107.70.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 986D16E32D
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 15:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxwcC1vXPL0ofH38syCY0hm3WbdDt3eaNgbOGslGAOBFs4i5yVkjEIEyoy3CwGRXEExavVsngvNhsa1fiJ74kwl97h1BKL8f2q/KqSgjyJXnV2sVrUpQZsW62rf4cPBqn/ZVb3AHmoCd8/mmVYYdYR7A6DLnu3xwtgWtblOO59r/m5Koq1YAFTm+NxHVX5YS2W8aSjCsdlH8TXy8m5k1zPqCAf423i/u5XAh7GrwFBiH5/v8RzBVpNGQQHIDOFeiYtUzB0P/lJ/qdECah0w0+WOc65GTWfHEXcCaNz0Vde69l077SuPW63qZNjptTTxANCFPZ6b47mF5el+1PAxOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27qSpQqO1kBQZqizebz0C/DdX/rK+0WLbFtzi8Al9io=;
 b=KFl73yKvQE5PNhR8BjU5F6ci8j3twKFb+iea68fU73z/LTk/DiZBOSViupOniExVyEKZC/5De33LYQxn6SUQJlK+AEnLMdGPEXATuQ3uvxTsVKLMVjy+YxRXJHir9pAgyUTWB8xo1mG7yPfLf5CsbciZ7C9ZzRZQCLbmYP2pxdc/0pHvqA2Zan3pqp9wMczTHYuoGcpyg1pvDYgXaggn8WhmWNpUQ5HtlC4RKTNT9l3jHB+6OlQ7Ml4ufciBn5j7qJOW9FEUCU4h4yGfIlycS/XzweZ9WCnbnLqLp0P6CdaeeoeWQqITzEfZW4lkVZXDIPJw/0qC+7FdUIphuH13rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1820.namprd12.prod.outlook.com (10.175.88.143) by
 DM5PR12MB2357.namprd12.prod.outlook.com (52.132.142.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 15:19:33 +0000
Received: from DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807]) by DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807%5]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 15:19:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/gfx10: explicitly wait for cp idle after
 halt/unhalt
Thread-Topic: [PATCH] drm/amdgpu/gfx10: explicitly wait for cp idle after
 halt/unhalt
Thread-Index: AQHVmswQYR5SMgszrECvHuChOY/+jqeKyB3G
Date: Thu, 14 Nov 2019 15:19:32 +0000
Message-ID:
 <DM5PR12MB1820FC3F5C0060E64CC7F831F7710@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <20191114091354.6414-1-xiaojie.yuan@amd.com>
In-Reply-To: <20191114091354.6414-1-xiaojie.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2623590e-eecf-47f6-05a8-08d769160d66
x-ms-traffictypediagnostic: DM5PR12MB2357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB23572EE3C3C4AAB9B4A011CDF7710@DM5PR12MB2357.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(54896002)(76176011)(99286004)(14454004)(476003)(11346002)(446003)(14444005)(66946007)(66446008)(66556008)(66476007)(64756008)(966005)(4326008)(6246003)(76116006)(2501003)(186003)(229853002)(105004)(53546011)(102836004)(8676002)(81156014)(26005)(81166006)(8936002)(6116002)(3846002)(7696005)(2906002)(66066001)(256004)(486006)(110136005)(316002)(5660300002)(6436002)(19627405001)(7736002)(71200400001)(74316002)(6506007)(6306002)(9686003)(54906003)(606006)(236005)(71190400001)(55016002)(33656002)(478600001)(52536014)(86362001)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2357;
 H:DM5PR12MB1820.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: siQDpyRvJr9LCMOz3AlRYrzQh/DWYBIm4zzTzqzR31SHXR8Iu++jeSxTYcQAlKhCmXny+AOWMIZ+dDNXU+iK8gC7WBHasdchIrmlFEcl39GtyrQSHNKpUkIbP9OL5yyKexZ7eQIBclwgK6+Rpm056JEHCfNJ6tR2jZ/+RMRtzk239Fe0dXti3PKryvREVqz5cS+ADglW52yKEsyWVmjMnld6gm1gb5eQctmL1SOS+LBjgnmO4BDK6BwxwF51/wBkE7GrKOrTz4bk3rxJ1ROVQLkJt2yNYCazJcO+Dc3wyS4MmxIbt6QaU6H1z6gMVqNhSCiJ74QwoqSWVxZ402i+7W6TeetEd6gd78oYKieXua+tV8+vYbaxh8yMNDw+/mm6qVwT/l7HJlTIHIL4u3+slO9D3iYsIi/4d8xnPmUdzl7fjF1Xmv+AUT5sy5wncdR+
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2623590e-eecf-47f6-05a8-08d769160d66
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 15:19:32.9952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JoE2TuTHkSswunPLf05dAi0OKvH8r0538/EergEj/ggQhBxusSJ/B8b5JUNm3rwF/QHOGnEkWicZ1DgR4moqQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2357
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27qSpQqO1kBQZqizebz0C/DdX/rK+0WLbFtzi8Al9io=;
 b=VbdLQxiv/c+1UnJQlQEUZ/3mfhcVidVTTENuJ01pgn0TXj4q7zPE2gg7yESJGTJu51SC+iAIsN1lGoE3qD446Zun3i0ju6UwwhHd7hlfq4Ir/qXrId7nbgDR38Kbtm52pufbZ1xg55eh5H6tzRtQJM2fogN1v/e7mTzVUvpYhp8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0488244939=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114151932.PQ5ZUiAIOtNeyWkmaOZaqQfpy5_qABaKRxuMsKrT1ik@z>

--===============0488244939==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1820FC3F5C0060E64CC7F831F7710DM5PR12MB1820namp_"

--_000_DM5PR12MB1820FC3F5C0060E64CC7F831F7710DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Xiaojie =
Yuan <xiaojie.yuan@amd.com>
Sent: Thursday, November 14, 2019 4:13 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Long, Gang <Gang.Long@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Yuan, X=
iaojie <Xiaojie.Yuan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: explicitly wait for cp idle after halt/u=
nhalt

50us is not enough to wait for cp ready after gpu reset on some navi asics.

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
Suggested-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 86db40717d38..7d40c73a5ab7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -2371,7 +2371,17 @@ static void gfx_v10_0_cp_gfx_enable(struct amdgpu_de=
vice *adev, bool enable)
                         adev->gfx.gfx_ring[i].sched.ready =3D false;
         }
         WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
-       udelay(50);
+
+       for (i =3D 0; i < adev->usec_timeout; i++) {
+               if (RREG32_SOC15(GC, 0, mmCP_STAT) =3D=3D 0)
+                       break;
+               udelay(1);
+       }
+
+       if (i >=3D adev->usec_timeout)
+               DRM_ERROR("failed to %s cp gfx\n", enable ? "unhalt" : "hal=
t");
+
+       return 0;
 }

 static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1820FC3F5C0060E64CC7F831F7710DM5PR12MB1820namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Xiaojie Yuan &lt;xiaojie.yuan=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 14, 2019 4:13 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Long, Gang &lt;Gang.Long@amd.com&gt;; Xiao, Jack &lt;Jack.Xiao@a=
md.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&gt;; Zhang, Hawking &lt;=
Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/gfx10: explicitly wait for cp idle after=
 halt/unhalt</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">50us is not enough to wait for cp ready after gpu =
reset on some navi asics.<br>
<br>
Signed-off-by: Xiaojie Yuan &lt;xiaojie.yuan@amd.com&gt;<br>
Suggested-by: Jack Xiao &lt;Jack.Xiao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 12 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;1 file changed, 11 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 86db40717d38..7d40c73a5ab7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -2371,7 &#43;2371,17 @@ static void gfx_v10_0_cp_gfx_enable(struct amdgp=
u_device *adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;gfx.gfx_ring[i].sched.ready =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_M=
E_CNTL, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;use=
c_timeout; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (RREG32_SOC15(GC, 0, mmCP_STAT) =3D=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; udelay(1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i &gt;=3D adev-&gt;usec_timeo=
ut)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_ERROR(&quot;failed to %s cp gfx\n&quot;, enable ? &quot;=
unhalt&quot; : &quot;halt&quot;);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *=
adev)<br>
-- <br>
2.20.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB1820FC3F5C0060E64CC7F831F7710DM5PR12MB1820namp_--

--===============0488244939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0488244939==--
