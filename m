Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FA0C00A89
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 15:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE33221556
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 15:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CrbeaxV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE33221556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782606E0EA;
	Mon,  2 Nov 2020 15:16:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7FB6E0EA
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 15:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUvwBDWpB63OWszdmAqJ59zxDue8BFCmtegtP7G0mwdpfIRbM2kNTazZIgtZAzXFp8jonR8vrq0vS2lGKRxxgkIvHM7XHzHjvSP3CsBxMSu8tSU2JqQiF2FGbn5uJKmWrHNdqavytD3rwGhtZCg4fRX6IOefpJ7PDrzY8QhNcH0ES8fTySYcVV2Sb54MdcLX/hjVj8P0OsACTybgEKNXp2i43/9kId3SiPDBptu5rmkQfmi53tKp+soePEUaOBpBDK18J57JDr9FMtLVc89AF6YD0m1ItJL2X6M2YHecjXU67dCpM3ouM1jO6UTZlWXwX8qBkkDBSXKer2UzwWHuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvFshuFhhjdg576voVtjo10FFRAQo8/OKq51FXof84U=;
 b=TRiDH/v2cLlT5uopP0a/gDk4LjymanaBf3oVHSNoFtNEjZ2J5DkXu8kcJ8jxLTDqXEoQmFXhMwysf8SV+PZzCQTt9+aWQ3RyWzauKNb3uBUQTEVkH/kl9oLzhWAeENGRf27mdN7hnaL9c5kdIDq43t2t7f5MDL3o59A0sx7KXpDXZIIbPelZps1vf2qlLiwONzt2T2E57u2J+Vm3Tmjl85bxXmg1FXUv65f9t3b6LQikGQS4kX88lzECc+7chLkuCV1LvmTRzGRbhTXPqYYOvKYydEYp1k/04QUZ5gjgvZbsHGvsWKpsMllIUR3S8dRzZW9mKDiJeh0xPtYGeH+LLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvFshuFhhjdg576voVtjo10FFRAQo8/OKq51FXof84U=;
 b=CrbeaxV3+JSzNNrNdIHwcnmhM92iTLOTOWNj8yui5Qm8SXg3CmYWrtrijCLINVlEdCL1f7+vji1X5TGTBjxJ30SmdE3/J95zXXEU5KCgWgLmfy6IG5gomXznpnH3QVoUCxTVRipdMKPB07NYVcFbbJbQ+JxTZbABRIwP50PYeTs=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4994.namprd12.prod.outlook.com (2603:10b6:208:1ca::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 15:16:20 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 15:16:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: replace ih ip block for vega20 and arcturus
Thread-Topic: [PATCH] drm/amdgpu: replace ih ip block for vega20 and arcturus
Thread-Index: AQHWrzME/rcLx41JgkiNge++U0LhQ6m096Y3
Date: Mon, 2 Nov 2020 15:16:20 +0000
Message-ID: <MN2PR12MB448883123B73D4DE4AC5BEDBF7100@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201031030619.16173-1-alex.sierra@amd.com>
In-Reply-To: <20201031030619.16173-1-alex.sierra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-02T15:16:20.055Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4523b47c-80ec-40b2-ff0e-08d87f424106
x-ms-traffictypediagnostic: BL0PR12MB4994:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4994E6C34A01B6D6E4B0F768F7100@BL0PR12MB4994.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kmSwbfZ8PnHG+AQCTFxJLa8dd46a9Eh3vdjXgvlpYmGrecZCgqZRWhv+4qTEvzA1kSPgt14WOzei99M+xKeMUVbJbqY3GoXiutrqbdKEz5qXCgyV397doi2XkuLh+QW2r1JBHv4zVb1cig3HT+3f57ZMSn1N8XQ5RzNtpNRudq1b2uotT7eWwWtiYt0Ii/TNVbZsOCkd+8JrJnntKDH6WpjxKmjzvtfMgcDYSoTcXTOmYro/aP3wy5wYOLCFg+fa7AJVNoSsUWgVXkEEyK3kpKh/pXpEufwN4pkpSR0GEriqNoVfk/B/crGkG7RVGCaybHg3GITNajVkdX0QlFlsp/GmiZkSN6BCIOuwmmIxakQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(110136005)(66556008)(66446008)(5660300002)(52536014)(83380400001)(19627405001)(166002)(8676002)(86362001)(6506007)(53546011)(7696005)(2906002)(26005)(9686003)(33656002)(8936002)(55016002)(66946007)(76116006)(316002)(478600001)(186003)(45080400002)(66476007)(71200400001)(966005)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 45W9ZUB7HhojNmNEhuTLmNVVTklVMnC1vtiw6o6qT8Qw9R14xMtA3ZzYdBf6lwpXXbChUXUAM6ASKj1iCwF8TVYzbIw3dAyOc6u+hwTaRCgdde/ZtmU0Glv4B5xHZGn7eVU6w96ftv6D290BpBSBw8WI90GSnBf8T7gI6yDUqQOgqN76yo6L2ELnmGXwG0rJVBlFM7IOve0zTK+6G1HFSdhBKt+HxcOe7UnA+5ZmYDWwuKn3EekwMWmCuQcxgLSXGKOSrLX6HylVLkHue28UjaA3AFMjmTqx/EsswlswHeNK++SauTDoVft/sMldUMFYs2U6npoyo5phD0sPgkWTWo4408kp/wE65oS84N7+oZOmgKh4ZYSPqMjiqXKCFe+gukSDW35CrNGnvnugzdAqpwRtBd3fMaiaZQKEDo2yGhrayJAXh2Ygc3TuDHbdeVWru/aRgP3uNk8uwiAeSTu5fn6Es3bMezEs/rn+qt6TtIlc/QohA8bv+4SboINrmApH598aaM0UyQgK6589JUU0+yd2Sl9ZDPBh4DqBmazBAJV/s9KAjAa22pnTylgnaXZ95iFxIBTfPBGP9WwHNSUSLmGb2uUJyJIRiILF/l/NdF605BInaC0z+GEqGjzsGFtidua26zo8Fc3p800fK8WWCA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4523b47c-80ec-40b2-ff0e-08d87f424106
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 15:16:20.7545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4vVGdYxW24THZnV8e6nyzqHGQC8TyOd30gznUVPFuWhTcKtbPCbuKfmKbKUhNmZN5PkTesUKJEq/u4CwUXUQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4994
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
Content-Type: multipart/mixed; boundary="===============1304122926=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1304122926==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448883123B73D4DE4AC5BEDBF7100MN2PR12MB4488namp_"

--_000_MN2PR12MB448883123B73D4DE4AC5BEDBF7100MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

It might be cleaner to just split out vega20 into a separate switch case in=
 that function.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Sie=
rra <alex.sierra@amd.com>
Sent: Friday, October 30, 2020 11:06 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>
Subject: [PATCH] drm/amdgpu: replace ih ip block for vega20 and arcturus

[Why]
Vega20 and Arcturus asics use oss 5.0 version.

[How]
Replace ih ip block by navi10 for vega20 and arcturus.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index f57c5f57efa8..fc5b11752931 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -62,6 +62,7 @@
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
 #include "vega10_ih.h"
+#include "navi10_ih.h"
 #include "sdma_v4_0.h"
 #include "uvd_v7_0.h"
 #include "vce_v4_0.h"
@@ -734,9 +735,15 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
                                 else
                                         amdgpu_device_ip_block_add(adev, &=
psp_v3_1_ip_block);
                         }
-                       amdgpu_device_ip_block_add(adev, &vega10_ih_ip_bloc=
k);
+                       if (adev->asic_type =3D=3D CHIP_VEGA20)
+                               amdgpu_device_ip_block_add(adev, &navi10_ih=
_ip_block);
+                       else
+                               amdgpu_device_ip_block_add(adev, &vega10_ih=
_ip_block);
                 } else {
-                       amdgpu_device_ip_block_add(adev, &vega10_ih_ip_bloc=
k);
+                       if (adev->asic_type =3D=3D CHIP_VEGA20)
+                               amdgpu_device_ip_block_add(adev, &navi10_ih=
_ip_block);
+                       else
+                               amdgpu_device_ip_block_add(adev, &vega10_ih=
_ip_block);
                         if (likely(adev->firmware.load_type =3D=3D AMDGPU_=
FW_LOAD_PSP)) {
                                 if (adev->asic_type =3D=3D CHIP_VEGA20)
                                         amdgpu_device_ip_block_add(adev, &=
psp_v11_0_ip_block);
@@ -787,9 +794,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
                 if (amdgpu_sriov_vf(adev)) {
                         if (likely(adev->firmware.load_type =3D=3D AMDGPU_=
FW_LOAD_PSP))
                                 amdgpu_device_ip_block_add(adev, &psp_v11_=
0_ip_block);
-                       amdgpu_device_ip_block_add(adev, &vega10_ih_ip_bloc=
k);
+                       amdgpu_device_ip_block_add(adev, &navi10_ih_ip_bloc=
k);
                 } else {
-                       amdgpu_device_ip_block_add(adev, &vega10_ih_ip_bloc=
k);
+                       amdgpu_device_ip_block_add(adev, &navi10_ih_ip_bloc=
k);
                         if (likely(adev->firmware.load_type =3D=3D AMDGPU_=
FW_LOAD_PSP))
                                 amdgpu_device_ip_block_add(adev, &psp_v11_=
0_ip_block);
                 }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C1f54f989cd9641c49c9708d87d4a000e%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637397104709391689%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdat=
a=3Dfe%2FU57bvUywZ57162F0sTzo%2FDaYGtX62J0MJf36Nxfo%3D&amp;reserved=3D0

--_000_MN2PR12MB448883123B73D4DE4AC5BEDBF7100MN2PR12MB4488namp_
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
It might be cleaner to just split out vega20 into a separate switch case in=
 that function.</div>
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
ounces@lists.freedesktop.org&gt; on behalf of Alex Sierra &lt;alex.sierra@a=
md.com&gt;<br>
<b>Sent:</b> Friday, October 30, 2020 11:06 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Sierra Guiza, Alejandro (Alex) &lt;Alex.Sierra@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: replace ih ip block for vega20 and arct=
urus</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
Vega20 and Arcturus asics use oss 5.0 version.<br>
<br>
[How]<br>
Replace ih ip block by navi10 for vega20 and arcturus.<br>
<br>
Signed-off-by: Alex Sierra &lt;alex.sierra@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c | 15 +++++++++++----<br>
&nbsp;1 file changed, 11 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index f57c5f57efa8..fc5b11752931 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -62,6 +62,7 @@<br>
&nbsp;#include &quot;nbio_v7_0.h&quot;<br>
&nbsp;#include &quot;nbio_v7_4.h&quot;<br>
&nbsp;#include &quot;vega10_ih.h&quot;<br>
+#include &quot;navi10_ih.h&quot;<br>
&nbsp;#include &quot;sdma_v4_0.h&quot;<br>
&nbsp;#include &quot;uvd_v7_0.h&quot;<br>
&nbsp;#include &quot;vce_v4_0.h&quot;<br>
@@ -734,9 +735,15 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;psp_v3_1_ip_block);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;vega10_ih_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asi=
c_type =3D=3D CHIP_VEGA20)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;navi1=
0_ih_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;vega1=
0_ih_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;vega10_ih_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asi=
c_type =3D=3D CHIP_VEGA20)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;navi1=
0_ih_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;vega1=
0_ih_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (l=
ikely(adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CH=
IP_VEGA20)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;psp_v11_0_ip_block);<=
br>
@@ -787,9 +794,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (l=
ikely(adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev,=
 &amp;psp_v11_0_ip_block);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;vega10_ih_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;navi10_ih_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;vega10_ih_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;navi10_ih_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (l=
ikely(adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev,=
 &amp;psp_v11_0_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C1f54f989cd9641c49c9708d87d4a000e%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637397104709391689%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C3000&amp;amp;sdata=3Dfe%2FU57bvUywZ57162F0sTzo%2FDaYGtX62J0MJf36Nxfo%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7C1f54f989cd9641c49c9708d87d4a=
000e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637397104709391689%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C3000&amp;amp;sdata=3Dfe%2FU57bvUywZ57162F0sTzo%2FDaYGtX62J0MJf3=
6Nxfo%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448883123B73D4DE4AC5BEDBF7100MN2PR12MB4488namp_--

--===============1304122926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1304122926==--
