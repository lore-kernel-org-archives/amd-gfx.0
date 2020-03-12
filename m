Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F011C1975A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 13:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9BA206E7
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 13:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SvkfllyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9BA206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 906916EABA;
	Thu, 12 Mar 2020 13:30:03 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700067.outbound.protection.outlook.com [40.107.70.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD6A6EABA
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 13:30:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFlBqoV2VPG2QmE/fn0E1cXkGOiTf2PNp8wISIJCB6/hnIxrqgOSlEuMB33/FJMB8xeOBiKxP1hqzb3Q+iywuvZsFMhM3qTl6+bQAD+lbrQQt2lsWoEhFn+wpRm5q9GNllM4p0fJHrr0+Wv2p2CV9JUB+vAcB9ZZ6N1/dLjD9SpW1doQOeczbxBxpOJwFlR9xLlCupvVH4SFfjVDxp1NiATh5FyH6WJQsaZ8ZcNb+l1Puh5wGntAB0nJQYF+WfAHVu/bU6cxU7hjPe0uBZrrKwFcS3xKQJ11+rhuAIO8O6umbQAC2H4dHhtjFUND3LRd8UVDC0vp0fqxDyzruCDEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+akwUdaN1vypWwk2sbrrFVLm6PLgonZwVmAH9KN0j3w=;
 b=oJijEwythUUw4gWvC8yM7fpoA6hrZ2hoveLgcPDWGqTwACcay9jW57V9hahMqZ5XlVxIZQ+7wBjqh2zlJb7roqCBVXqjoSyX+GdPJOfICgKTJRjHVHI7prenDqVu4PKrczSYGj+m3ODmiG26038R8lYGBxo/t7+lcIGeL6ZcpQz6hcpIjaGDlQG77z/FtJnVMp7a6Jg268gZMiayWZfD/22HEIMJPC71s0hK8YabEAMAeozpfMwSu4mhwBcLIlGCnTR6GVQRGl7DjvYsTaQ9k7+uUOjZ1fNi562ESjPFPYTMAEY0CWWTZm9rFVT1H5iProenBt74esDC/6GbyZlPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+akwUdaN1vypWwk2sbrrFVLm6PLgonZwVmAH9KN0j3w=;
 b=SvkfllyDvOCvtLsSYxxTTQSs6U+rknFu5qeU+Q1fLRSN1eKiDvLN/G5fmy86MA/PAUCR+dcP6nMpmfjinF9VrQHM1vBGpYuSMplRz9L/kcc0Fg9/hLZ5HQKc1eiYTXCnU2TrJc0RpWfizFap7eyeGPg+VClZf1AIX9Ufvt/WssE=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3389.namprd12.prod.outlook.com (2603:10b6:208:ca::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Thu, 12 Mar
 2020 13:30:01 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 13:30:01 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/swsmu: clean up unused header in swsmu
Thread-Topic: [PATCH] drm/amdgpu/swsmu: clean up unused header in swsmu
Thread-Index: AQHV+FPQZTS7SPmdaUyX3LEuDPL9UahE8+xt
Date: Thu, 12 Mar 2020 13:30:01 +0000
Message-ID: <MN2PR12MB448824CBB36864B0929047A0F7FD0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200312095056.3921-1-kevin1.wang@amd.com>
In-Reply-To: <20200312095056.3921-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-12T13:30:01.139Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 161554ea-ff8d-4dab-90c0-08d7c68977bf
x-ms-traffictypediagnostic: MN2PR12MB3389:|MN2PR12MB3389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3389FF5DC32BE7934DC492D7F7FD0@MN2PR12MB3389.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:75;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(199004)(55016002)(71200400001)(8936002)(86362001)(7696005)(186003)(2906002)(316002)(26005)(478600001)(81156014)(19627405001)(8676002)(110136005)(9686003)(53546011)(5660300002)(66476007)(76116006)(64756008)(33656002)(6506007)(66556008)(66446008)(66946007)(52536014)(4326008)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3389;
 H:MN2PR12MB4488.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6bHBUF2QI86Xy904cmuLmgRfsyhxInFHIwMaBXc4K556PUMEMImV1tuge1ORG5e708MCJfHJeO6dqYG95ZUcivU+4UObYVRAbzHzmL17DSgwNw5bo17h9VZfK5QRit9stcHNrPJ+Vwbl5nbaZoG2j3i9szj6uDN/alfqfr+Yj34156oyYetlKwoXaza0XifRonRRN3l/vZNk50OyLzQWoEzSvpBteucfdTRg/sFiWcO1x4mn+FgxqKbkdCNnCpYJ/Kawxpx1OMRNNR1+C8s/ywTAEfGzfGTfI+26kO+GaRYA3JZr6RkQWRBLBpftExJsd7dzIpKz8SdCyPVwU2sYSt7I4mNoTbGQROMR3zlzaF/SI7J0g/qXoa/Hptyre/Ra+9WBnP6F5b0iRDSchdpFjp9EOFJm6rSR/Oh4YN9e+Sy722vVIygirM2tXtWbfEQv
x-ms-exchange-antispam-messagedata: xodKnNBiIlw1Mit2o8por+dvXrYJCtgfeNaMiEd/ddknmHwOqyfYnuWUh3018vaQXM59o/cyNVBVvgk2UJlzKGd+S/7Gue0fW5aA/J3cBJx216rNe5dGUsACjNfaooLwAST7X1SSoimk4kS7Bz+ZpA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161554ea-ff8d-4dab-90c0-08d7c68977bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 13:30:01.6722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzpeZgzgLQE4iCEeM5RXDn8UxSkpogFmIVR31CJaoE2r5RDUGAf9a2Imy9dUigKOzpdGlDufBGlNq3duN5mpWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3389
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: multipart/mixed; boundary="===============0660191292=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0660191292==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448824CBB36864B0929047A0F7FD0MN2PR12MB4488namp_"

--_000_MN2PR12MB448824CBB36864B0929047A0F7FD0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Thursday, March 12, 2020 5:50 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu/swsmu: clean up unused header in swsmu

clean up unused header in swsmu driver stack:
1. pp_debug.h
2. amd_pcie.h
3. soc15_common.h

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c   | 3 ---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 1 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c   | 2 --
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c   | 1 -
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c    | 1 -
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c    | 1 -
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c   | 1 -
 7 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index f18e3fadbc26..8de8436f0839 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -23,15 +23,12 @@
 #include <linux/firmware.h>
 #include <linux/pci.h>

-#include "pp_debug.h"
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
 #include "smu_internal.h"
-#include "soc15_common.h"
 #include "smu_v11_0.h"
 #include "smu_v12_0.h"
 #include "atom.h"
-#include "amd_pcie.h"
 #include "vega20_ppt.h"
 #include "arcturus_ppt.h"
 #include "navi10_ppt.h"
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index cc4427ebf169..61596e8d522c 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -21,7 +21,6 @@
  *
  */

-#include "pp_debug.h"
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index 6e41f3c9ff1b..d66dfa7410b6 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -21,7 +21,6 @@
  *
  */

-#include "pp_debug.h"
 #include <linux/firmware.h>
 #include <linux/pci.h>
 #include "amdgpu.h"
@@ -31,7 +30,6 @@
 #include "amdgpu_atomfirmware.h"
 #include "smu_v11_0.h"
 #include "smu11_driver_if_navi10.h"
-#include "soc15_common.h"
 #include "atom.h"
 #include "navi10_ppt.h"
 #include "smu_v11_0_pptable.h"
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c
index 653faadaafb3..7bf52ecba01d 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -24,7 +24,6 @@
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
 #include "smu_internal.h"
-#include "soc15_common.h"
 #include "smu_v12_0_ppsmc.h"
 #include "smu12_driver_if.h"
 #include "smu_v12_0.h"
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index 3a5d00573d2c..4fd77c7cfc80 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -26,7 +26,6 @@

 #define SMU_11_0_PARTIAL_PPTABLE

-#include "pp_debug.h"
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
 #include "smu_internal.h"
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v12_0.c
index d52e624f16d3..169ebdad87b8 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -20,7 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */

-#include "pp_debug.h"
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c
index d7fa8c02c166..49ff3756bd9f 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -21,7 +21,6 @@
  *
  */

-#include "pp_debug.h"
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
--
2.17.1


--_000_MN2PR12MB448824CBB36864B0929047A0F7FD0MN2PR12MB4488namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 12, 2020 5:50 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com=
&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/swsmu: clean up unused header in swsmu</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">clean up unused header in swsmu driver stack:<br>
1. pp_debug.h<br>
2. amd_pcie.h<br>
3. soc15_common.h<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp; | 3 ---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 1 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp; | 2 --<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.c&nbsp;&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v12_0.c&nbsp;&nbsp;&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp; | 1 -<br>
&nbsp;7 files changed, 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index f18e3fadbc26..8de8436f0839 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -23,15 &#43;23,12 @@<br>
&nbsp;#include &lt;linux/firmware.h&gt;<br>
&nbsp;#include &lt;linux/pci.h&gt;<br>
&nbsp;<br>
-#include &quot;pp_debug.h&quot;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;#include &quot;smu_internal.h&quot;<br>
-#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;smu_v11_0.h&quot;<br>
&nbsp;#include &quot;smu_v12_0.h&quot;<br>
&nbsp;#include &quot;atom.h&quot;<br>
-#include &quot;amd_pcie.h&quot;<br>
&nbsp;#include &quot;vega20_ppt.h&quot;<br>
&nbsp;#include &quot;arcturus_ppt.h&quot;<br>
&nbsp;#include &quot;navi10_ppt.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index cc4427ebf169..61596e8d522c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -21,7 &#43;21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;<br>
-#include &quot;pp_debug.h&quot;<br>
&nbsp;#include &lt;linux/firmware.h&gt;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 6e41f3c9ff1b..d66dfa7410b6 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -21,7 &#43;21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;<br>
-#include &quot;pp_debug.h&quot;<br>
&nbsp;#include &lt;linux/firmware.h&gt;<br>
&nbsp;#include &lt;linux/pci.h&gt;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
@@ -31,7 &#43;30,6 @@<br>
&nbsp;#include &quot;amdgpu_atomfirmware.h&quot;<br>
&nbsp;#include &quot;smu_v11_0.h&quot;<br>
&nbsp;#include &quot;smu11_driver_if_navi10.h&quot;<br>
-#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;atom.h&quot;<br>
&nbsp;#include &quot;navi10_ppt.h&quot;<br>
&nbsp;#include &quot;smu_v11_0_pptable.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c<br>
index 653faadaafb3..7bf52ecba01d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
@@ -24,7 &#43;24,6 @@<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;#include &quot;smu_internal.h&quot;<br>
-#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;smu_v12_0_ppsmc.h&quot;<br>
&nbsp;#include &quot;smu12_driver_if.h&quot;<br>
&nbsp;#include &quot;smu_v12_0.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index 3a5d00573d2c..4fd77c7cfc80 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -26,7 &#43;26,6 @@<br>
&nbsp;<br>
&nbsp;#define SMU_11_0_PARTIAL_PPTABLE<br>
&nbsp;<br>
-#include &quot;pp_debug.h&quot;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;#include &quot;smu_internal.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v12_0.c<br>
index d52e624f16d3..169ebdad87b8 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br>
@@ -20,7 &#43;20,6 @@<br>
&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&nbsp; */<br>
&nbsp;<br>
-#include &quot;pp_debug.h&quot;<br>
&nbsp;#include &lt;linux/firmware.h&gt;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br>
index d7fa8c02c166..49ff3756bd9f 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
@@ -21,7 &#43;21,6 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;<br>
-#include &quot;pp_debug.h&quot;<br>
&nbsp;#include &lt;linux/firmware.h&gt;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448824CBB36864B0929047A0F7FD0MN2PR12MB4488namp_--

--===============0660191292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0660191292==--
