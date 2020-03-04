Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD0FC3F2CD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 14:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315DB2072A
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 14:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Go/5rOyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315DB2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036AE6E18F;
	Wed,  4 Mar 2020 14:14:31 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760072.outbound.protection.outlook.com [40.107.76.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C116E18F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 14:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU9O43WQO9y6DdOJXW6RZNd8EQxlswPgyMYYzGkS36zr9CdJmFONY4I11pzD1r2ZIV8/fosFbfDqjh8uDtBpkUYmD6YC/8EcbcdPp8w1BD/QxiCzRqzqJNwhMfo7NqwWZkUtw/2COcqEzjd2Ujj1YoK05OPP/Z7wMdaeMJE20wa6uuFROf4jBO8dlbq/F52zaMeLv7qg4GfWmYgfmDW70nHmOvrCxWY2uFaGoMtTMBLFK9ViIVXd6CT2rghO2q4vGB5HQVGZYt/TrpjpDvP/htXj4c+gpZCg47mRhhUx8cDTugZe55AobLWQIJ7VjNIF2+8N8+Bi8eMxKII4fmyMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FZ37PpBiKQVe1lC0zYueIJVstytKuWcpdjDuEItiNA=;
 b=ftMCUJLJhmcaB6YOETJ5svuCPjl500drqtLWOmEwd/j17Jg1ZNoOvx1LPgR60uB3z2I83kOCQ349u53eO2uDkUj34C2T+5MeFbgLxbxBzPdTCQfKhBKDlA3dS1k5b7jo0tjbaFaNzYYl4XUA6w4XFnJLGBWjtqOJZEi5cye+h7Yb7+ckjQfadVmDSqx+BinNV0vLgMq9BWDzAj9V4JzUvgicVeGSXsBG4Esp9RyrB2T+ZD+fWKajsmWTyiSUoZO+IbYIXoSMHR66FTJISYkajYegxxIWNxKve45EAY95Lho5L02CtWZfXiphocTp6PlVPZIwUscpJQj5fRdQZHc/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FZ37PpBiKQVe1lC0zYueIJVstytKuWcpdjDuEItiNA=;
 b=Go/5rOyB00vgVGtl3XVOIwi8ypMSmN9UU7HOfLJfzDNJCG9OUyH5pC9WYtR5wzinviQ1cab0md1acCINxZiNJssV0/J5uONEA5Z12tLlcEL30YCsFErJuEOb8NlGJQVVhgk9+QEfRexcspoz/76UhCduEfLCBXRoScQiKt8FAb4=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 14:14:28 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 14:14:28 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for
 gpu_clock_count
Thread-Topic: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for
 gpu_clock_count
Thread-Index: AQHV8edGMPj0mDhAD0egWIKfKCKZO6g4ek3o
Date: Wed, 4 Mar 2020 14:14:27 +0000
Message-ID: <CH2PR12MB39126CF789D937733CD795AEF7E50@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <1583300351-3896-1-git-send-email-Jiange.Zhao@amd.com>
In-Reply-To: <1583300351-3896-1-git-send-email-Jiange.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-04T14:14:27.543Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b37d46e2-ec51-4fa9-f534-08d7c04659b0
x-ms-traffictypediagnostic: CH2PR12MB4039:|CH2PR12MB4039:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4039EA08F4A78C293E0901E6F7E50@CH2PR12MB4039.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(189003)(199004)(66946007)(66476007)(2906002)(66556008)(64756008)(52536014)(66446008)(9686003)(4326008)(86362001)(76116006)(478600001)(71200400001)(55016002)(33656002)(54906003)(7696005)(6506007)(81156014)(81166006)(5660300002)(186003)(53546011)(19627405001)(8676002)(26005)(110136005)(316002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4039;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4v3znwOrm/e/MLxexD084ZsXyAPftu7gKof6rgKt5pLF91iUXs3fZgIRSYF2rNsDNOsx+THMmgMpDSia+BwgF4MWCHXpnMYns8Vm414lPCSK9k9DTcIdu2p8Yhze1rMiJovC77S+kLtGLJ2QwFiDx9i4kIKmmXO5cH1saG8e3+2pE/Nxkqxaxu7FLnwJTrqip/9sGP3+qtQ9sGh/lrjxWnREqoZkbJY7g1bNl0KMJH9kYDWF8c0QHHWBV4OGgcpvxAGKN4p0UJQMy79cj0KFsMl1LGVGmg7RHcam+ohu7TYutfMae758idgz8ygHhxXC9HTpfLBhXEOTs3mU4LWfZ/XQSX1jvyl76OWmsx8eGxDKOFwyvIpyVXSBnKJkHCiY7//ChBkzS5mTKcQJ3mJRg53bQwMgh12ghmaeNcGv1AuV7cOwjuA/mg59u6NA5mDQ
x-ms-exchange-antispam-messagedata: +FeyoNttlG/6DtlRM085pHMLXG+wLixHvpF7bM07u65vUm06dO/ac6d1QwsCk72rH1KVx0/f+thA+lmz0EXh4M+lV4LNbqCgRilwarCEIPpkOFjv/t1YxgTu6Oqt+VTOIZFIhSqG09ScokQeCpF4JQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37d46e2-ec51-4fa9-f534-08d7c04659b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 14:14:28.0098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTiPacP/S+teM4httcT1c6NXfBy+qzvOmiQfAooCj2PyEhT1Xkb2I7L8uRV37tMVxeIp6YRwrXfiF44PuIxugQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============0546011357=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0546011357==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB39126CF789D937733CD795AEF7E50CH2PR12MB3912namp_"

--_000_CH2PR12MB39126CF789D937733CD795AEF7E50CH2PR12MB3912namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: Zhao, Jiange <Jiange.Zhao@amd.com>
Sent: Wednesday, March 4, 2020 12:39 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Deucher=
, Alexander <Alexander.Deucher@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for gpu_clock=
_count

Navi12 VK CTS subtest timestamp.calibrated.dev_domain_test failed
because mmRLC_CAPTURE_GPU_CLOCK_COUNT register cannot be
written in VF due to security policy.

Solution: use a VF-accessible timestamp register pair
mmGOLDEN_TSC_COUNT_LOWER/UPPER for SRIOV case.

v2: according to Deucher Alexander's advice, switch to
mmGOLDEN_TSC_COUNT_LOWER/UPPER for both bare metal and SRIOV.

Signed-off-by: jianzh <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 03655c3..22a07ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -35,6 +35,8 @@

 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
+#include "smuio/smuio_11_0_0_offset.h"
+#include "smuio/smuio_11_0_0_sh_mask.h"
 #include "navi10_enum.h"
 #include "hdp/hdp_5_0_0_offset.h"
 #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
@@ -3925,9 +3927,8 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struc=
t amdgpu_device *adev)

         amdgpu_gfx_off_ctrl(adev, false);
         mutex_lock(&adev->gfx.gpu_clock_mutex);
-       WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
-       clock =3D (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) =
|
-               ((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) <=
< 32ULL);
+       clock =3D (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER=
) |
+               ((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER)=
 << 32ULL);
         mutex_unlock(&adev->gfx.gpu_clock_mutex);
         amdgpu_gfx_off_ctrl(adev, true);
         return clock;
--
2.7.4


--_000_CH2PR12MB39126CF789D937733CD795AEF7E50CH2PR12MB3912namp_
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
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Zhao, Jiange &lt;Ji=
ange.Zhao@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 4, 2020 12:39 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@a=
md.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhao, Jia=
nge &lt;Jiange.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sriov: Use VF-accessible register for gp=
u_clock_count</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Navi12 VK CTS subtest timestamp.calibrated.dev_dom=
ain_test failed<br>
because mmRLC_CAPTURE_GPU_CLOCK_COUNT register cannot be<br>
written in VF due to security policy.<br>
<br>
Solution: use a VF-accessible timestamp register pair<br>
mmGOLDEN_TSC_COUNT_LOWER/UPPER for SRIOV case.<br>
<br>
v2: according to Deucher Alexander's advice, switch to<br>
mmGOLDEN_TSC_COUNT_LOWER/UPPER for both bare metal and SRIOV.<br>
<br>
Signed-off-by: jianzh &lt;Jiange.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 &#43;&#43;&#43;&#43;---<br=
>
&nbsp;1 file changed, 4 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 03655c3..22a07ad 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -35,6 &#43;35,8 @@<br>
&nbsp;<br>
&nbsp;#include &quot;gc/gc_10_1_0_offset.h&quot;<br>
&nbsp;#include &quot;gc/gc_10_1_0_sh_mask.h&quot;<br>
&#43;#include &quot;smuio/smuio_11_0_0_offset.h&quot;<br>
&#43;#include &quot;smuio/smuio_11_0_0_sh_mask.h&quot;<br>
&nbsp;#include &quot;navi10_enum.h&quot;<br>
&nbsp;#include &quot;hdp/hdp_5_0_0_offset.h&quot;<br>
&nbsp;#include &quot;ivsrcid/gfx/irqsrcs_gfx_10_1.h&quot;<br>
@@ -3925,9 &#43;3927,8 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(s=
truct amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, =
false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;g=
fx.gpu_clock_mutex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU=
_CLOCK_COUNT, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock =3D (uint64_t)RREG32_SOC15(GC, =
0, mmRLC_GPU_CLOCK_COUNT_LSB) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) &lt;&l=
t; 32ULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock =3D (uint64_t)RREG32_SOC15(=
SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) =
&lt;&lt; 32ULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;gfx.gpu_clock_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, =
true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return clock;<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB39126CF789D937733CD795AEF7E50CH2PR12MB3912namp_--

--===============0546011357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0546011357==--
