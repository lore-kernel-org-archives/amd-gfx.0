Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1243C3F34E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE65246A9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pdErRQJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE65246A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC316E8D8;
	Thu, 27 Feb 2020 14:23:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95FC6E8D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 14:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Syi2rpK11dM3bKL64H12fvP5rTS4QFufqVI+QWairyvqJlH+ED6+aOuJ77iOVC8In1d1mAcixr9Ds28KOGTeinsdlGNanYzb61FpWy3wW1uZT9hccSKbocu7SN78EeKi8ZZs4KEQxy0VcklGuSH0b2s0MDE9xTm6euaMFBsDqR2N8HWy/y2fdPc6WKN629CQldhdVsy4YCdS5DIzPnG8eMNb2uVExnnw9udny/KO402YNCljsmzeJN6N9ptiTk3sw+/6Ga0g2vZqDDXU5guJ5KZJhpEMFJOplbMqLly0olNtHJc2JAvLAiC1a781w6BN96Hs8eWtyUggB5Df9fcCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOBXwLSgBAjlKdetZUQrUrjB/c2mGuv1YKOK/xNuT7g=;
 b=ie9X0/Vv1FNu9b4FfDORS7rjRAY1ZBCddJqhmRlF9IFGyi70Tm+95odei4O68FElWolx7/G+G8RNEDNurZezzYkTNNW67vp3g0upSduIOfJDQ5AzCHJlCmrPheHHniU6NXwnm6c2/ufF1ziVPUO0wV3Vi8s4wTDqnO41QXdut3+Ceo5hZWlVEs7pYcoS7nJ5Ctv2rDx32GMe7B5dIlqiuwAZi/8tfHeK0KZ7RXUc61dLJTinEJWv41gRjrKtrwszMONzKutYaIQVAkRLqdSDeU1t9AcfaaJDH7+LSlm/ampvg6g7ZoyXWGrR6tXPAT5CrbD1FauRdTinnsKEOTXcng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOBXwLSgBAjlKdetZUQrUrjB/c2mGuv1YKOK/xNuT7g=;
 b=pdErRQJ0+3TAAZ2N7rVNrTGMZW3eFkTbx7jxDKf8UYSQRk942tCHQ32tKl6Ynj8bGyOeNWcdNaIpIWbQeyIpXm++wfvbPgLvrldnS9nD2S5IlPz2lRWCn45xttAOtUnfu8NWSALijWQq+k3dmEKnl5ON9qmaw2g6nShucLfwtHs=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 14:23:09 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 14:23:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for
 gpu_clock_count
Thread-Topic: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for
 gpu_clock_count
Thread-Index: AQHV7WA4UlSmNL9rxUWdERAqCQqcYKgvGAE0
Date: Thu, 27 Feb 2020 14:23:09 +0000
Message-ID: <CH2PR12MB3912BF71221F4F9C9FDEA665F7EB0@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <1582802479-14724-1-git-send-email-Jiange.Zhao@amd.com>
In-Reply-To: <1582802479-14724-1-git-send-email-Jiange.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-27T14:23:08.798Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5a972e1-b50a-4a6c-1df4-08d7bb9091f0
x-ms-traffictypediagnostic: CH2PR12MB4038:|CH2PR12MB4038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4038446D3E36822B163E578CF7EB0@CH2PR12MB4038.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(66946007)(52536014)(76116006)(64756008)(2906002)(19627405001)(66446008)(81156014)(8936002)(66556008)(478600001)(966005)(186003)(81166006)(71200400001)(66476007)(86362001)(7696005)(33656002)(53546011)(5660300002)(26005)(45080400002)(8676002)(9686003)(55016002)(110136005)(54906003)(6506007)(4326008)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4038;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dSqct/XpzxATRSULpw/5+okFXQIOitxpDI+zUAI5B8w263yi1RMmf2EwPrt20hl5sLOzI/lJQkDNDL55Xeb45HK5XEuHzgwFkR8VwWecvW3vh1OcnLQm/su7YXmy4QlUJ+IQtOjB1Uh+ub0iVKLZrYZsv+BlroL74GMFXJX6azPbF1gQlSx/y5YZdPcdQ0yVaHJCo2i654aqa87VDcXVV09ugpUfDVR17aTg7unBQw9ceywsIKHVOekRSFFhXkWejrUcI0LpdTCRRGNY8EuNuyph+yFq+gl0AELed29mI6UC+1DX2gjQT/lVZ7PSn2KDpqgWo0+SwIZocHM1rsNOI8cDU53jjYlyR5yjjmLH5UUgBTkJhCATRAtblrO0aiJ7w6+lDrW40rN8bY13+zCFyJ2E8WjaXDDR6rhgnSdkXJNS3wKmageug5QPRiLProgq0rVIys6NuCw+eTPP7/fbhGLzdvfFksI9pwrpHHq7BQM=
x-ms-exchange-antispam-messagedata: Nr20G5amOh08FxkiMvGd7ZMA06nXppCODTHMtVsxSrPJlx/H+V23k1SadTluKFA4iT8EOH2AzYfvUBNE8ip1uYU22YWs6z0b6/PQL3b7UvNdCbaB6HaU865RQN6+yT9s9KmVtE9JnCBISgTAn9OsNA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a972e1-b50a-4a6c-1df4-08d7bb9091f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 14:23:09.1493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktVVJjgpVgy7axeOr8XCaCQEwD2GZbQ9UQIB8uwBvAmFnFKqkYymTLMwpOI7JJpRFZmU+TEMZc0SSo2gW4J6hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
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
Content-Type: multipart/mixed; boundary="===============2064028618=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2064028618==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3912BF71221F4F9C9FDEA665F7EB0CH2PR12MB3912namp_"

--_000_CH2PR12MB3912BF71221F4F9C9FDEA665F7EB0CH2PR12MB3912namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Is there any reason to not just use this for bare metal as well?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of jianzh <=
Jiange.Zhao@amd.com>
Sent: Thursday, February 27, 2020 6:21 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deng, Emily <Emily.Deng@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>; L=
iu, Monk <Monk.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for gpu_clock=
_count

Navi12 VK CTS subtest timestamp.calibrated.dev_domain_test failed
because mmRLC_CAPTURE_GPU_CLOCK_COUNT register cannot be
written in VF due to security policy.

Solution: use a VF-accessible timestamp register pair
mmGOLDEN_TSC_COUNT_LOWER/UPPER for SRIOV case.

Signed-off-by: jianzh <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 44f00ec..8787a46 100644
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
@@ -3920,9 +3922,14 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(stru=
ct amdgpu_device *adev)

         amdgpu_gfx_off_ctrl(adev, false);
         mutex_lock(&adev->gfx.gpu_clock_mutex);
-       WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
-       clock =3D (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) =
|
-               ((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) <=
< 32ULL);
+       if (!amdgpu_sriov_vf(adev)) {
+               WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
+               clock =3D (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COU=
NT_LSB) |
+                       ((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUN=
T_MSB) << 32ULL);
+       } else {
+               clock =3D (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COU=
NT_LOWER) |
+                       ((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUN=
T_UPPER) << 32ULL);
+       }
         mutex_unlock(&adev->gfx.gpu_clock_mutex);
         amdgpu_gfx_off_ctrl(adev, true);
         return clock;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C9b14a49e41fd48f7138f08d7bb773ed9%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637183993593225894&amp;sdata=3DjFUVpgeEcTTJbTJ3a7i=
bAPOyAU3RVF%2FEIN41zaqS0eM%3D&amp;reserved=3D0

--_000_CH2PR12MB3912BF71221F4F9C9FDEA665F7EB0CH2PR12MB3912namp_
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
Is there any reason to not just use this for bare metal as well?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of jianzh &lt;Jiange.Zhao@amd.co=
m&gt;<br>
<b>Sent:</b> Thursday, February 27, 2020 6:21 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; Zhao, Jiange &lt;Jiange.=
Zhao@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sriov: Use VF-accessible register for gp=
u_clock_count</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Navi12 VK CTS subtest timestamp.calibrated.dev_dom=
ain_test failed<br>
because mmRLC_CAPTURE_GPU_CLOCK_COUNT register cannot be<br>
written in VF due to security policy.<br>
<br>
Solution: use a VF-accessible timestamp register pair<br>
mmGOLDEN_TSC_COUNT_LOWER/UPPER for SRIOV case.<br>
<br>
Signed-off-by: jianzh &lt;Jiange.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;---<br>
&nbsp;1 file changed, 10 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 44f00ec..8787a46 100644<br>
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
@@ -3920,9 &#43;3922,14 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(=
struct amdgpu_device *adev)<br>
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
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; clock =3D (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUN=
T_LSB) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint64_t)R=
REG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) &lt;&lt; 32ULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; clock =3D (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUN=
T_LOWER) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint64_t)R=
REG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) &lt;&lt; 32ULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;gfx.gpu_clock_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, =
true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return clock;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C9b14a49e41fd48f7138f08d7bb773ed9%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637183993593225894&amp;amp;sdata=3D=
jFUVpgeEcTTJbTJ3a7ibAPOyAU3RVF%2FEIN41zaqS0eM%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C9b14a49e41fd48f7138f08d7bb773ed9%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637183993593225894&amp;amp;sdata=3DjFUVpgeEcTTJbTJ=
3a7ibAPOyAU3RVF%2FEIN41zaqS0eM%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB3912BF71221F4F9C9FDEA665F7EB0CH2PR12MB3912namp_--

--===============2064028618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2064028618==--
