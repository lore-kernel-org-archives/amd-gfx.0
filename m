Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FDACA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 13:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC30B20717
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 13:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC30B20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7FD6E85A;
	Mon, 28 Oct 2019 13:02:51 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730045.outbound.protection.outlook.com [40.107.73.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 086696E85A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 13:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm2U/KcmpQuNb4j5n30BfBAjEx+2MUvnHLkFuO+IzyN7LXoaRygsmr8SzN1OxXwrCXbtoLRbICdCppd5i13ptyBdJUkhHTA9E7/9nsQVTyE30NLQdLscN9u667qwgIjDeoehnbm3hWziedcEqEAb1u0FLe8jn9jO0IRCzV90IuruFND2Kb67PFALMFWxpM7MJcaQrusTsHv/vgwlH5x1/9NJZTaF3nXjJ8DNKZiweXtJMvwQE+r90XodwLdj5JXBsqux603wzm5AcQo3yMVzDKw71EsaY4145+RSKZEOB7h5iOgqhgMo3nl8sMnROkxQWp9EZ2ZGxC9fieEPUvdq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fkk7iMeXVa2T2svFINFS8QIDNMOHME3rESqoCmzY2E=;
 b=DMc2fb3a2sL0B1oXxLRBm9/dj3FWleIqUyu/UmSJxL8zBbMKc7tXCWRqelOY6O0TmLkQEjm97YwZDkL5Pi1i9MQHtZeM5OPZhm/9lOIpEH8I6YEVMHLkhhw/aXo+flqNoEXVXoLwhyHzK3ynSazxEE+KNlGM15uexTi+Ydk9FTDfvnshHviBt05TM0LNVaQIGsm2bcAH5t6jH7V1IDGc8L4zwsCSkhnOMVuGNq8XiMniqV/ajEIAQko4lGms2dfo0IWZhthSUlrcin/RhkfiqRZaCzIZj1C4zB6GUszzuVTu5+6fS1RlnacW+kKM6CuO1WguSJoWBMVknrBQN64ZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1820.namprd12.prod.outlook.com (10.175.88.143) by
 DM5PR12MB1273.namprd12.prod.outlook.com (10.168.238.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Mon, 28 Oct 2019 13:02:47 +0000
Received: from DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807]) by DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807%5]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 13:02:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/SRIOV: SRIOV VF doesn't support BACO
Thread-Topic: [PATCH] drm/amdgpu/SRIOV: SRIOV VF doesn't support BACO
Thread-Index: AQHVjXiLEEkLZ1xVeEW9m36pMSA0kKdwBP5T
Date: Mon, 28 Oct 2019 13:02:47 +0000
Message-ID:
 <DM5PR12MB182097D97D4F53977C9F368EF7660@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <20191028101432.16464-1-jianzh@amd.com>
In-Reply-To: <20191028101432.16464-1-jianzh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.51.171.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ef3f0c4-8ccf-419e-04b7-08d75ba72168
x-ms-traffictypediagnostic: DM5PR12MB1273:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1273EA5F9A2F0B495F846267F7660@DM5PR12MB1273.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(74316002)(19627405001)(55016002)(5660300002)(2906002)(33656002)(966005)(110136005)(6436002)(54906003)(81156014)(8936002)(76176011)(6506007)(53546011)(7736002)(8676002)(11346002)(99286004)(76116006)(476003)(81166006)(25786009)(86362001)(486006)(66556008)(446003)(66446008)(64756008)(6246003)(66946007)(66476007)(7696005)(606006)(229853002)(14454004)(478600001)(14444005)(71190400001)(71200400001)(256004)(186003)(66066001)(26005)(52536014)(236005)(316002)(9686003)(3846002)(4326008)(6116002)(2501003)(105004)(54896002)(6306002)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1273;
 H:DM5PR12MB1820.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CHP4T4j9ALunkRNtaiuZ3iY8zZxAOCofyEk8xIcNBYt2qrmJN/oDnBVP2otv6FlQH+qnurwMZvoVDqodA4j21ABWRav8cDgfiyCN8bufGXypS3K2I9msGPFWnRhHhuQ34ZmBtCDs3LLNJhVBElMsyDvn3/wDGSewdW5VTBjXcLbq8WjaVcSNEivVFHQy2sWCbMBZ6Kobq8/MYx3SClRVfg5MjZOYJKXCTxz6L+uIOhDLa22/y5eps+hWygFKdG00lyMPO165yuVIf/EZ50ts+KaAAnyYdUTOvzvQjyl90zypF52eGsEHDCQ1w6rZgVwV/8z9gYQx2tCCpjeTrXfCUIMqTQzlu5gmxrvqFj8+33k3+Zgmin0jGbSnrxrTI1QQ5U4wJyK+qOpFFz5wG3fWPQdwf3+3X3CDDZ6V47rbYTiQzzXB6EGc/efRP1EMzmRXHof8Q7UOByGcbh1+Z5yZSBr842Qi8e4Zp7rv7UyKF/0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef3f0c4-8ccf-419e-04b7-08d75ba72168
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 13:02:47.2976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cTS29O0ehLRwyOIhkLNgoyfh97CTd7OLc9oZFo3/Dwih9Dausv1LFVZ/2gM0V4pz4jdVxh/ruDTBQexiq+uUhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1273
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fkk7iMeXVa2T2svFINFS8QIDNMOHME3rESqoCmzY2E=;
 b=wtpMD3mAkt/kvRooan0y7OkNCOWjiYPuqiR/eVQ+RVbEDB4JV3RtJtRUlgSP4U00+DQ9rvzLJCC3qr9EnAWGWlrEGjeG/VO9/o4brElmgJvpZ8d7IlkSZ547Rx2mbLrQg/gOy1evqZqC0DVacYSt3D6k/MFbPViZAQEKcgZI4gE=
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "Nieto, David M" <David.Nieto@amd.com>
Content-Type: multipart/mixed; boundary="===============1230302795=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028130247.KYbMxFS1Z0U5ntrYqHrLaw-feag88e-MconZvDkCIB4@z>

--===============1230302795==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB182097D97D4F53977C9F368EF7660DM5PR12MB1820namp_"

--_000_DM5PR12MB182097D97D4F53977C9F368EF7660DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of jianzh@a=
md.com <jianzh@amd.com>
Sent: Monday, October 28, 2019 6:14 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deng, Emily <Emily.Deng@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>; N=
ieto, David M <David.Nieto@amd.com>
Subject: [PATCH] drm/amdgpu/SRIOV: SRIOV VF doesn't support BACO

From: Jiange Zhao <Jiange.Zhao@amd.com>

SRIOV VF doesn't support BACO.

Only PF with BACO capability can do it.

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 22ab1955b923..a55a2e83fb19 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -299,7 +299,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 {
         struct smu_context *smu =3D &adev->smu;

-       if (smu_baco_is_support(smu))
+       if (!amdgpu_sriov_vf(adev) && smu_baco_is_support(smu))
                 return AMD_RESET_METHOD_BACO;
         else
                 return AMD_RESET_METHOD_MODE1;
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB182097D97D4F53977C9F368EF7660DM5PR12MB1820namp_
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
ounces@lists.freedesktop.org&gt; on behalf of jianzh@amd.com &lt;jianzh@amd=
.com&gt;<br>
<b>Sent:</b> Monday, October 28, 2019 6:14 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; Zhao, Jiange &lt;Jiange.=
Zhao@amd.com&gt;; Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/SRIOV: SRIOV VF doesn't support BACO</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
<br>
SRIOV VF doesn't support BACO.<br>
<br>
Only PF with BACO capability can do it.<br>
<br>
Signed-off-by: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 22ab1955b923..a55a2e83fb19 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -299,7 &#43;299,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D &amp;adev-&gt;smu;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_baco_is_support(smu))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev) &amp;&=
amp; smu_baco_is_support(smu))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return AMD_RESET_METHOD_BACO;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return AMD_RESET_METHOD_MODE1;<br>
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

--_000_DM5PR12MB182097D97D4F53977C9F368EF7660DM5PR12MB1820namp_--

--===============1230302795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1230302795==--
