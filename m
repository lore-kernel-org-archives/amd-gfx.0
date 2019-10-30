Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5451ACA9EAE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 02:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E41B20663
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 02:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E41B20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85806E85B;
	Wed, 30 Oct 2019 02:26:27 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800083.outbound.protection.outlook.com [40.107.80.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F5C6E85B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 02:26:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir4OV4GKhaJ2MIFYwoNPoLWQKS+dNAxBWaXGXTat82F7Flx71Q4VUwa67AQMF+rfWboMqfsO1v/OVk5wUwSuDoz4JZcmBtIx3Eoes7/IGN14r4m0HvV4Z5GC316eJ3qSQPeHs0Cuve1kMRPs3DqupEdaH6x0dhZHHtObDBUBD6ulKpTzbTumO1KuPVZKVfmU9kLN/vYodMHUWUsI5qc8tYvka4EATtagppURusBezFh/Uxz3u2xXHiwOIGnAVPaSLq9My9Db2TCiJRueOSnh4NmQbDo7Kjo3b4/x1GUou3v2AZxvtMqM18PTZhgKCvXqOk/KPRCYqUNiVJpJVWu1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO1Yvrgmk8Ts81Swy94O6a89p+LRlpNOvRq/+3HRwHg=;
 b=CeUjtZV9D2lO0wBlYqxuiOkoayLSZvi79IUr+g0UtoKG8R6Gj4rWrEppm85jkAQs0PohfysVUWXUOha0+Zts0iX0z/I/xQ36TAFge56jpERkeztqjLl/lOWivWzACZokTHF6rucnA+aQ3s6ytGQZy3tzNhnPUyrDdb7p8dD59+LOyfvnxJrtoE2pw9tHI4AvMKAVbbTB2QpM6s7oZdYytGlskPFJ4SKzUcV2kAbjO3JXpdpDtQj9oeyExJd11gUfIqFLjuPA6bm7kKfQQKZ7/y2fTuZVu687SyzxYILuqlU1nEH/r1SesJzeNSnWxRtQOLLYicbhaXShGOdlNs4rxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3056.namprd12.prod.outlook.com (20.178.242.143) by
 MN2PR12MB3518.namprd12.prod.outlook.com (20.179.82.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Wed, 30 Oct 2019 02:26:24 +0000
Received: from MN2PR12MB3056.namprd12.prod.outlook.com
 ([fe80::f951:43eb:5b8e:2a31]) by MN2PR12MB3056.namprd12.prod.outlook.com
 ([fe80::f951:43eb:5b8e:2a31%4]) with mapi id 15.20.2408.016; Wed, 30 Oct 2019
 02:26:24 +0000
From: "Zhao, Jiange" <Jiange.Zhao@amd.com>
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/SRIOV: Only reset hw.status for target IP
Thread-Topic: [PATCH] drm/amdgpu/SRIOV: Only reset hw.status for target IP
Thread-Index: AQHVjiyC8kvX+eeTjE2pmaa0Hd10kadydlAo
Date: Wed, 30 Oct 2019 02:26:24 +0000
Message-ID:
 <MN2PR12MB3056C5DBA2AD474DB9A005C7E1600@MN2PR12MB3056.namprd12.prod.outlook.com>
References: <20191029074248.11942-1-jianzh@amd.com>
In-Reply-To: <20191029074248.11942-1-jianzh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 708ab4da-cb53-42cd-325c-08d75ce08f41
x-ms-traffictypediagnostic: MN2PR12MB3518:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB351856D024D83C83D582BD16E1600@MN2PR12MB3518.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(7696005)(3846002)(76176011)(66446008)(478600001)(81166006)(14454004)(91956017)(64756008)(76116006)(7736002)(256004)(66946007)(99286004)(6116002)(66476007)(8676002)(476003)(4326008)(8936002)(5660300002)(66556008)(486006)(6506007)(14444005)(11346002)(19627405001)(33656002)(446003)(53546011)(52536014)(81156014)(71190400001)(86362001)(66066001)(316002)(55016002)(102836004)(186003)(71200400001)(26005)(54896002)(236005)(54906003)(9686003)(105004)(110136005)(2501003)(229853002)(6246003)(25786009)(6436002)(2906002)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3518;
 H:MN2PR12MB3056.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dJ0PUrTkaCt37OByYmg2crpHa/MYD9N9nH1KYqeBGp1QEar5KIMwJT6c9loX4FeGw9MIUcZSTLpym+dd0DQXed54/IVMi9CfQJ/uhBO4AlVLB3crZS0IAhk0WLbN822+3O+787rWOFbmrH2Qtnhu6S4YuB/TCAZle25ai3Gp7kKCkhCVfC4PmAFBBYhdEFHh1OGlnMMcB942b8/8vR/6mXVT7a+/JY+TOf8zgtZxbGzlKN+/mtibGuyILI5NMDMsiUnxv2siheBrIQFdc3LF5EX1Lg4iqSqrFMCcLJpz53WkHCcdKk7n5LBAbpuLW8z2aVohbxGH3J8WseJbKgz2/FIUym/yn2/aFzGOWDLSMDMvSCtI5+1nNqaWvhnB35q4DafzfbKYLqWO2E2kDmNGPUM/VxAiQr1MK8Lx0PFQO0Xm1yQ5FuUNEr5QnHdYWyv
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708ab4da-cb53-42cd-325c-08d75ce08f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 02:26:24.1219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7KEwrG/ZWC/76bDFG3E0QeDGzUcMx27PGlQj23f6BygT5ljXW6WKNy1KITlues4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3518
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO1Yvrgmk8Ts81Swy94O6a89p+LRlpNOvRq/+3HRwHg=;
 b=QkTC6kuHy1JC2H7EMacaqgFxsaL8SpMjJS4LLkMMw2CCwDoX+8TPXEE4IcogibwERWqzr6xcjjco9p2QkDWwJmAf0XpYWhTRcgBsLjU5WCc+haQ8+OWjlIOJV9QSWGhrOa8HcJwbeBwLFdRsCmjRRX87xi7Xd7ql9nvOrztED7g=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Chang,
 HaiJun" <HaiJun.Chang@amd.com>
Content-Type: multipart/mixed; boundary="===============0061905851=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030022624.yvlsrE1sYKqOxrXnbGQJUnDK48NsbNFnYMtwGkLE3xE@z>

--===============0061905851==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3056C5DBA2AD474DB9A005C7E1600MN2PR12MB3056namp_"

--_000_MN2PR12MB3056C5DBA2AD474DB9A005C7E1600MN2PR12MB3056namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ping.

@Deng, Emily<mailto:Emily.Deng@amd.com> @Liu, Monk<mailto:Monk.Liu@amd.com>=
, can you help review this patch?

Thanks!
Jiange
________________________________
From: Zhao, Jiange <jianzh@amd.com>
Sent: Tuesday, October 29, 2019 3:43 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Chang, =
HaiJun <HaiJun.Chang@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu/SRIOV: Only reset hw.status for target IP

From: Jiange Zhao <Jiange.Zhao@amd.com>

In the old way, when doing IH hw_init, PSP, nv_common
and GMC hw.status would be reset to false, even though
their hw_init have been done. In the next step, fw_loading,
PSP would do hw_init again.

In the new way, only reset hw.status to false for the target
IP in the list. In this way, PSP will only do hw_init once.

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 4eee40b9d0b0..ad6d2452fed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2352,11 +2352,11 @@ static int amdgpu_device_ip_reinit_early_sriov(stru=
ct amdgpu_device *adev)
                 for (j =3D 0; j < adev->num_ip_blocks; j++) {
                         block =3D &adev->ip_blocks[j];

-                       block->status.hw =3D false;
                         if (block->version->type !=3D ip_order[i] ||
                                 !block->status.valid)
                                 continue;

+                       block->status.hw =3D false;
                         r =3D block->version->funcs->hw_init(adev);
                         DRM_INFO("RE-INIT-early: %s %s\n", block->version-=
>funcs->name, r?"failed":"succeeded");
                         if (r)
--
2.20.1


--_000_MN2PR12MB3056C5DBA2AD474DB9A005C7E1600MN2PR12MB3056namp_
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
Ping.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a id=3D"OWAAM822686" class=3D"_1OtrSZdhKXVv3UhaivrdJ4 mention ms-bgc-nlr m=
s-fcl-b" href=3D"mailto:Emily.Deng@amd.com">@Deng, Emily</a>
<a id=3D"OWAAM720573" class=3D"_1OtrSZdhKXVv3UhaivrdJ4 mention ms-bgc-nlr m=
s-fcl-b" href=3D"mailto:Monk.Liu@amd.com">
@Liu, Monk</a>, can you help review this patch?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jiange<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhao, Jiange &lt;jian=
zh@amd.com&gt;<br>
<b>Sent:</b> Tuesday, October 29, 2019 3:43 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@a=
md.com&gt;; Chang, HaiJun &lt;HaiJun.Chang@amd.com&gt;; Zhao, Jiange &lt;Ji=
ange.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/SRIOV: Only reset hw.status for target I=
P</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
<br>
In the old way, when doing IH hw_init, PSP, nv_common<br>
and GMC hw.status would be reset to false, even though<br>
their hw_init have been done. In the next step, fw_loading,<br>
PSP would do hw_init again.<br>
<br>
In the new way, only reset hw.status to false for the target<br>
IP in the list. In this way, PSP will only do hw_init once.<br>
<br>
Signed-off-by: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 4eee40b9d0b0..ad6d2452fed9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2352,11 &#43;2352,11 @@ static int amdgpu_device_ip_reinit_early_sriov(=
struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;num_ip_blocks; j&#43;&#=
43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block=
 =3D &amp;adev-&gt;ip_blocks[j];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block-&gt;status=
.hw =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (b=
lock-&gt;version-&gt;type !=3D ip_order[i] ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !block-&gt;status.valid)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block-&gt;st=
atus.hw =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D=
 block-&gt;version-&gt;funcs-&gt;hw_init(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_I=
NFO(&quot;RE-INIT-early: %s %s\n&quot;, block-&gt;version-&gt;funcs-&gt;nam=
e, r?&quot;failed&quot;:&quot;succeeded&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r=
)<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3056C5DBA2AD474DB9A005C7E1600MN2PR12MB3056namp_--

--===============0061905851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0061905851==--
