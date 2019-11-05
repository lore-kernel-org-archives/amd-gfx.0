Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E750EC5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 22:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E16204EC
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 22:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E16204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE5B6E15D;
	Tue,  5 Nov 2019 22:29:51 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740057.outbound.protection.outlook.com [40.107.74.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A6106E15D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 22:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbjHmzYF8hx9ZEOwhT/pwPygPWgox1Nprm3iutQxRCF5CNMPtZTzoTeGYDiE4Z9bJLtbqbFqVzp0LFPthHxVtqbze35ylfnQWQ6cdLkzTEy0tb6UFlkepZ5vdtURqbnPdYKBU/PVsHSqoA11JF8nntbZ1xYLwHfhyIJk98vvmZay7B4sM2tbusVbxo8JmPNkZWtLLitSgIJoQZHofX3O10UkesvO7xxjTFpG7/wINSfsXAfCI0CnsxEHIuSANszdIhqcON5/G3KKSjNSn2E/red2begTJ+AHeQ5giki4ChstxlXZ7mY18b3Mac9GHnNKxIvsIX90b/MTeeKrCkgBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UocORJWM8VqfFQPJfaKo1UPR7HK7JL0l9RrYqiUC/ek=;
 b=NsuGDl4pasoXniz9+xNrwtLwE3TF4f6xr1HKQl+UDmWmZGLYv86AR4UJo7vtbJyg9S8XEIoBxPyl6cswg6McmIbRSISosJNA/IXabi8t8JKissj5/JeDmnMJVHETkswcgaeIKoX7Yk/KKUc5EuRvhvvjk8nRnnqBoO/VrYJLF9wc8emAng45jQG7K+a6NMFc3OTdumrW7DE6RcFEEVGjUQHHSvbzkmVNGGpc+uJXCEDw+Zhn2ImJuUDk/kmipDgP4V7JraUV/YBCMeOkHhOY7xqlSSREu4nNLnuirnC83B0DINaLwvsdZxLh/fUVmFj2g6OFC2JW01cf4JHFzjUbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1813.namprd12.prod.outlook.com (10.175.80.21) by
 CY4PR12MB1701.namprd12.prod.outlook.com (10.175.62.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 22:29:47 +0000
Received: from CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc]) by CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc%4]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 22:29:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: register gpu instance before fan boost
 feature enablment
Thread-Topic: [PATCH] drm/amdgpu: register gpu instance before fan boost
 feature enablment
Thread-Index: AQHVk8JWWrJMFrql3UuN7eSaSxL7H6d9KXf0
Date: Tue, 5 Nov 2019 22:29:47 +0000
Message-ID:
 <CY4PR12MB1813DF71A6EC7517CAB8CEDEF77E0@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191105101755.16511-1-evan.quan@amd.com>
In-Reply-To: <20191105101755.16511-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.58.219.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ed25bf6-494c-4130-cc3d-08d7623faa24
x-ms-traffictypediagnostic: CY4PR12MB1701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1701498C3F9D70EBE153B7AFF77E0@CY4PR12MB1701.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(110136005)(486006)(446003)(86362001)(105004)(229853002)(11346002)(6436002)(14454004)(71190400001)(81156014)(74316002)(256004)(81166006)(71200400001)(66066001)(25786009)(5660300002)(3846002)(6116002)(52536014)(2906002)(476003)(102836004)(186003)(8676002)(8936002)(7736002)(478600001)(19627405001)(33656002)(55016002)(99286004)(76116006)(2501003)(9686003)(6246003)(316002)(54896002)(66476007)(66556008)(66446008)(64756008)(66946007)(76176011)(6506007)(53546011)(26005)(7696005)(14444005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1701;
 H:CY4PR12MB1813.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0OsHoJRy05pPvcjDVoQGQXdFoUSzc2HyOUtobZJTqAPyyjqV1ii96W66kQPN6bk7rUp/83VS99o08WA1Lz9/Jh8J3MVBtRGdAADthk7ylGeXRp1vW2vA3egPuYBqVAncIB6VO235F2SBTPGkHEZsr63tzJCWgTTLlnM796b0xAeA3xEwaaG7JtOT/A3jPvIjjgBFQrCIjqia2u8zeITap1ELRgBBV/DIg/4H/ep2IAAkNWouMj31e9yEL6NkKr5uAp6ysjw4/OPabP9djz9wUPY7ElLvgA4UtydirmxNwFIeuatdOM6jaMxjTKU5IoMb8GCfVD9Jw5TmZ5IvwXCxF7Hxiw2IFmwOUxV34Xgwq3VS0XwClG+I1ZPkn/lp/avCbhMOCGLer/tg3TU4v35A6tpTsoFQc9M+jrpK8H2H9jlloxKeHKXn8HfoQICBJU9F
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed25bf6-494c-4130-cc3d-08d7623faa24
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 22:29:47.2374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Q5V55ajfn5mDd0u96lDQMGf0qG8SmI0Gz4Y98II+pWpfr4ZEazHGSLNoP+4pCifcd4yPYc0Y6OP57dQBe9XPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1701
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UocORJWM8VqfFQPJfaKo1UPR7HK7JL0l9RrYqiUC/ek=;
 b=gffNBrGp+8G49B5SvcJDUJojDElU50A8lFODnas5QYH+xr/YabzXds+4gLHKHLy5IOWLprmy2uIMFvKXgCxkEGSqGj3k6trpCB3+quZaUrXwZcFDK4TUQS0v0kl6rn4rTHL3DGkD3dqhnpSthwhgbtbxLTTa4uFmzKvsuHFBWlw=
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
Content-Type: multipart/mixed; boundary="===============0555058840=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105222947.mP183p1htqjqkkcZTEuOD0sFGkpfQ34ML4wPhijjpEM@z>

--===============0555058840==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1813DF71A6EC7517CAB8CEDEF77E0CY4PR12MB1813namp_"

--_000_CY4PR12MB1813DF71A6EC7517CAB8CEDEF77E0CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, November 5, 2019 5:18 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amdgpu: register gpu instance before fan boost feature=
 enablment

Otherwise, the feature enablement will be skipped due to wrong count.
Caused by "drm/amdgpu: fix a race in GPU reset with IB test (v2)".

Change-Id: Id576090d7ce7645a5c98ac160e0af730a51526b0
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 1 -
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 2d72d206cead..02ccadbfd89f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3087,6 +3087,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
                         DRM_INFO("amdgpu: acceleration disabled, skipping =
benchmarks\n");
         }

+       /*
+        * Register gpu instance before amdgpu_device_enable_mgpu_fan_boost=
.
+        * Otherwise the mgpu fan boost feature will be skipped due to the
+        * gpu instance is counted less.
+        */
+       amdgpu_register_gpu_instance(adev);
+
         /* enable clockgating, etc. after ib tests, etc. since some blocks=
 require
          * explicit gating rather than handling it automatically.
          */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 688bb4abccf5..cbd4a5709470 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -204,7 +204,6 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsi=
gned long flags)
                 pm_runtime_put_autosuspend(dev->dev);
         }

-       amdgpu_register_gpu_instance(adev);
 out:
         if (r) {
                 /* balance pm_runtime_get_sync in amdgpu_driver_unload_kms=
 */
--
2.23.0


--_000_CY4PR12MB1813DF71A6EC7517CAB8CEDEF77E0CY4PR12MB1813namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 5, 2019 5:18 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: register gpu instance before fan boost =
feature enablment</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Otherwise, the feature enablement will be skipped =
due to wrong count.<br>
Caused by &quot;drm/amdgpu: fix a race in GPU reset with IB test (v2)&quot;=
.<br>
<br>
Change-Id: Id576090d7ce7645a5c98ac160e0af730a51526b0<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 &#43;&#43;&#43;&#43;&#=
43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&nbsp;&nbsp;&nbsp; | 1 -<br>
&nbsp;2 files changed, 7 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 2d72d206cead..02ccadbfd89f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3087,6 &#43;3087,13 @@ int amdgpu_device_init(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_I=
NFO(&quot;amdgpu: acceleration disabled, skipping benchmarks\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Register gpu instance bef=
ore amdgpu_device_enable_mgpu_fan_boost.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Otherwise the mgpu fan bo=
ost feature will be skipped due to the<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * gpu instance is counted l=
ess.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_register_gpu_instance(adev=
);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable clockgating, etc=
. after ib tests, etc. since some blocks require<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * explicit gating ra=
ther than handling it automatically.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 688bb4abccf5..cbd4a5709470 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -204,7 &#43;204,6 @@ int amdgpu_driver_load_kms(struct drm_device *dev, =
unsigned long flags)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_register_gpu_instance(adev);<b=
r>
&nbsp;out:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* balance pm_runtime_get_sync in amdgpu_driver_unloa=
d_kms */<br>
-- <br>
2.23.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1813DF71A6EC7517CAB8CEDEF77E0CY4PR12MB1813namp_--

--===============0555058840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0555058840==--
