Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9CFC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 02:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9C921582
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 02:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zQ9hND1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9C921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6627A6E220;
	Wed, 18 Dec 2019 02:29:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB076E21E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 02:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3c32/Y2DZUV/jRWe03UA1vj21te6Q5AJhPB9wuY1+kQBp+ijhtO+/ENedW9R1FFfyUDPXQrYdwUqH7x1I54Lhldm2HoJ3uhLIPc7KgIrjHjWuYYU1GJtBfdyy2IjySOomUXuHLs7OcYJFL0GLXFB8Q1Fez+cja7I1NFl7IzKR0wttzOSwT9Knz1GtNJEGdFiXOJnRGjgu6l1Tzc4nJI1Rx7k5Hpkg9+Q7pR2f7ho4t3PryrQcOU1zXSqyKD0Obc07JGMBH74KtVqPMem8JjeflujEqbl6B2HTKApEsMiPzSyKTKdcTcOmz0RxyrYtuZPE5ZfjGQ1HfNbh/kK5Fc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVGD+iOfAlEEoyn1xBvTuzcLJvc2Q9rfTYmZn1/qCq0=;
 b=DxKmOip4LHiS/wpg/PdMEPCt9Oy1PqdctShQ55xwK3Qm8zh/SUdGOOeQ4O3ujAzbHMvvXCbgdg684emCq67Frt8cAheYgIlvnE3G4puy8CrHGlePnSAysK4cSvbiYB/J11u4q8qiGQ48xkOWZFgdAqSHrXBQWEl4m1sga7SyWnw7RVLsnVvkJWTmmeumqhtnMmtaosJ0PvXpCB77GUZTd7WMnu3yjiwgH60ibVa/hSXg2Z8aSIarRKFO/l2K1GvaCZmkQGxzr0I+W/6uuoAw31P2UZLUU3KNzam5tUtXK+rx0xHRBFsmt85k9b2/xXweOcujYBl3VvQ7pR/3EAIaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVGD+iOfAlEEoyn1xBvTuzcLJvc2Q9rfTYmZn1/qCq0=;
 b=zQ9hND1W7yb5sb2m+sRyXbTtkF5IgmDl53XW90zH+oqeaauTHTSUXIdG4HEyWNfnPUSi/c3XCzxIXBkK3XNrIGs/TIutvnAZpTO597iaNJNJjagmFESWiHngnKtSwXM1jnsnhn57JB7KTvHAvoRixW90bZjUrPU3j2uJHWuJkqM=
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB3104.namprd12.prod.outlook.com (20.178.243.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Wed, 18 Dec 2019 02:29:42 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3%6]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 02:29:42 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/5] drm/amdgpu/smu: add metrics table lock
Thread-Topic: [PATCH v2 1/5] drm/amdgpu/smu: add metrics table lock
Thread-Index: AQHVtSOH0C6DygXab0OmuL4DtqX5Oae/K51X
Date: Wed, 18 Dec 2019 02:29:41 +0000
Message-ID: <MN2PR12MB3296E9D09441E2AD334D5FBDA2530@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191217214543.2285700-1-alexander.deucher@amd.com>
In-Reply-To: <20191217214543.2285700-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-18T02:29:41.337Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54965105-9c99-489b-d18d-08d783622375
x-ms-traffictypediagnostic: MN2PR12MB3104:|MN2PR12MB3104:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB31042E824E39604AD8A071B2A2530@MN2PR12MB3104.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(66556008)(66476007)(81156014)(76116006)(8676002)(186003)(110136005)(66946007)(316002)(91956017)(966005)(86362001)(478600001)(66446008)(81166006)(45080400002)(5660300002)(52536014)(8936002)(4326008)(9686003)(55016002)(2906002)(33656002)(26005)(7696005)(71200400001)(19627405001)(6506007)(64756008)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3104;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KkCpq3ymqzajPGPHi3sWQgTFfA7zBhEYr0dEIYzzDas3XsJYtP38UzEviALBdtHurmJP9Tg/b8s0RzKBY9shKP2XGTP9ZkmND3BeI+5K2JbWEXJUJdQDWlySyPpW6aVe7auV83h4jb1lwUXgofrVIHC1G4taJb7kqPxUnCuxENI3gtEO/CNgZXoK949sNiRl9SEx/MqTRHiAgCn+7Uj7vnBLLfnN0E35t8zibHSEXxo59asPORL2mfBuXMmb07lsonvHmfBNqgqOzYJhpLaqIBubHRZLX74lubh0s1X9lsa5ceJN0sC+rS363jA9nQb/XLxVmoq2wmHOc2aJiT+d7pt/AhqD26760deYnqQNrEqhio086c6KvGnfU9M/FahB76jSTPopDdHrWhmTDDVYCebiRyS1eSW2MrnzF5WW98X0ycXrTHsg7mQUrNBORhW5+DbhY6j1QmRe8RoBalVp5OsbsQjtPwEG9hdAW1zUA+A=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54965105-9c99-489b-d18d-08d783622375
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 02:29:41.8833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ojnFlxVFmgrQRCdnCLJFnUhQiIAJjWsKAc3WfVi+VWkDGrtnGXRQGqDgI3u/j0Pz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3104
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
Content-Type: multipart/mixed; boundary="===============1319933371=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1319933371==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296E9D09441E2AD334D5FBDA2530MN2PR12MB3296namp_"

--_000_MN2PR12MB3296E9D09441E2AD334D5FBDA2530MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

The series patches are
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: Wednesday, December 18, 2019 5:45 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH v2 1/5] drm/amdgpu/smu: add metrics table lock

This table is used for lots of things, add it's own lock.

Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F900&amp;data=3D02%7C01%7CKevin1=
.Wang%40amd.com%7C39da818e513e4cfb04fe08d7833a7fc2%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637122160270078326&amp;sdata=3DjL5LpNDv7ZX%2FpGPAexqcU=
DKOE5%2B9kkAxKuIzWO1CE0Y%3D&amp;reserved=3D0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 1 +
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index f76a1717ffbd..936c68298786 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -872,6 +872,7 @@ static int smu_sw_init(void *handle)
         smu->smu_baco.platform_support =3D false;

         mutex_init(&smu->sensor_lock);
+       mutex_init(&smu->metrics_lock);

         smu->watermarks_bitmap =3D 0;
         smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index a7d0ad831491..541cfde289ea 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -350,6 +350,7 @@ struct smu_context
         const struct pptable_funcs      *ppt_funcs;
         struct mutex                    mutex;
         struct mutex                    sensor_lock;
+       struct mutex                    metrics_lock;
         uint64_t pool_size;

         struct smu_table_context        smu_table;
--
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C39da818e513e4cfb04fe08d7833a7fc2%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637122160270078326&amp;sdata=3D5Z573z93vZHHifVEOQoXgpkcg=
KoGvlm%2B5hC6oVQdTec%3D&amp;reserved=3D0

--_000_MN2PR12MB3296E9D09441E2AD334D5FBDA2530MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
The series patches are&nbsp;</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: black; background-color: rgb(255, 255, 255)">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Wednesday, December 18, 2019 5:45 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2 1/5] drm/amdgpu/smu: add metrics table lock</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">This table is used for lots of things, add it's ow=
n lock.<br>
<br>
Bug: <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F900&amp;amp;data=3D0=
2%7C01%7CKevin1.Wang%40amd.com%7C39da818e513e4cfb04fe08d7833a7fc2%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637122160270078326&amp;amp;sdata=3DjL5L=
pNDv7ZX%2FpGPAexqcUDKOE5%2B9kkAxKuIzWO1CE0Y%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.=
freedesktop.org%2Fdrm%2Famd%2Fissues%2F900&amp;amp;data=3D02%7C01%7CKevin1.=
Wang%40amd.com%7C39da818e513e4cfb04fe08d7833a7fc2%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637122160270078326&amp;amp;sdata=3DjL5LpNDv7ZX%2FpGPAex=
qcUDKOE5%2B9kkAxKuIzWO1CE0Y%3D&amp;amp;reserved=3D0</a><br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; | =
1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 &#43;<br>
&nbsp;2 files changed, 2 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index f76a1717ffbd..936c68298786 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -872,6 &#43;872,7 @@ static int smu_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_baco.platform_=
support =3D false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;smu-&gt;se=
nsor_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;smu-&gt;metrics_l=
ock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;watermarks_bitmap =
=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;power_profile_mode=
 =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index a7d0ad831491..541cfde289ea 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -350,6 &#43;350,7 @@ struct smu_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct pptable_funcs=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ppt_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; mutex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; sensor_lock;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; metrics_lock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pool_size;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table;<br>
-- <br>
2.23.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7C39da818e513e4cfb04fe08d7833a7fc2%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637122160270078326&amp;amp;sdata=3D5Z573z=
93vZHHifVEOQoXgpkcgKoGvlm%2B5hC6oVQdTec%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7C39da818e513e4cfb04fe08d7833a7fc2%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637122160270078326&amp;amp;sdata=3D5Z573z93vZHHifVEOQoXgpkcgKo=
Gvlm%2B5hC6oVQdTec%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3296E9D09441E2AD334D5FBDA2530MN2PR12MB3296namp_--

--===============1319933371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1319933371==--
