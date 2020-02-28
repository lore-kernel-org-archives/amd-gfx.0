Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A672FC3F2CD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 15:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5460024699
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 15:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VEU6jvPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5460024699
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B8EF6E063;
	Fri, 28 Feb 2020 15:03:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61CC06E063
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 15:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIfOwyGVRyuG7w7gywKTmlewGCYqodpIWvWWyKxGk1jiijwX00KMQnhbj74Y4xnA28DTYHyDzArCgusycEgdSHbDRVdqnEWqP43pa1ZY+pz7nArhrE8KVU1fzJRuUiUrTp2wD5x3upsWYluHOSEUN/nI1cSjYEceQbuY8CbqQfD0AiSzwssX7V4RUcFPTmRY4VZnJgLs67rMTvfN4Oi2eUeAjpzsWLNlwRHhjeKwvuOa36U1fbwebsA/TA5O7Q7ySHEuB4isM1AZibOrzKGhDwaZsoCe8x2UO+48qhxJoxtN8XnF9BmBEHjdZdRdnrW1Ggv9gJZnL47tpcPPeFEsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY2HoERuD6lzWRD5OkuSVAHkEkf69kKg2SbT1MJJSsQ=;
 b=fCKAnQi93NmZuc8lgWSqNGhTTM+c+H3jbsusKpdxYIdwnTp2ytS3YBzChdc1vmvxJTC3elJsMMDjwpErTGwX/aQktIxvYx9nHykM1RcRT5ivMcwZdR9LigDS2KBfjZA7jjeCzWTtMP8lgBEP7DM60UUNhxzykw2LjFGnODDnAOKQHCWiNf8kQoW6gfaXGnxHigiZoNF+FKzb7lFblvxgBV8pEWemAHIiYAIUIe6NSOWf1Ew6Zy3BEDNHx1105y5l87mUriowpCRcnGtEI/cD3EIahg5PntcpG+xMmLa3SE3ljrYvFTRS7X81fuThblkhGHfs9171ncTER3fJ0tYoiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY2HoERuD6lzWRD5OkuSVAHkEkf69kKg2SbT1MJJSsQ=;
 b=VEU6jvPKFsU2QiZdecP6ww+DmCMtXEh6bOePfpZT0oYItoLswRIwAcU5TjJphkD2zeJp1hOpMRTQAuSTa1ZDAEo6guE9oEffQBR3X7v98+pKVcTJTU1485FuX3fBQfra9GPozAkEh0blmEpH8J+KbkKjzCQ4NQtE8K8P2FXKvok=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 28 Feb
 2020 15:03:54 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 15:03:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for
 gpu_clock_count
Thread-Topic: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for
 gpu_clock_count
Thread-Index: AQHV7WA4UlSmNL9rxUWdERAqCQqcYKgvGAE0gADUZACAAMkusA==
Date: Fri, 28 Feb 2020 15:03:54 +0000
Message-ID: <CH2PR12MB39125494C4835547C9F8E313F7E80@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <1582802479-14724-1-git-send-email-Jiange.Zhao@amd.com>,
 <CH2PR12MB3912BF71221F4F9C9FDEA665F7EB0@CH2PR12MB3912.namprd12.prod.outlook.com>,
 <MN2PR12MB3056EF4F92975A794D55D304E1E80@MN2PR12MB3056.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3056EF4F92975A794D55D304E1E80@MN2PR12MB3056.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-28T15:03:53.899Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [172.58.187.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86bba1be-27a6-4e3d-b3ac-08d7bc5f6db0
x-ms-traffictypediagnostic: CH2PR12MB4215:|CH2PR12MB4215:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4215A55D392D226E1CFA9918F7E80@CH2PR12MB4215.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(52536014)(5660300002)(2906002)(4326008)(186003)(478600001)(19627405001)(66946007)(66556008)(64756008)(66446008)(966005)(66476007)(71200400001)(76116006)(45080400002)(26005)(33656002)(316002)(81156014)(8676002)(8936002)(6506007)(7696005)(86362001)(81166006)(53546011)(55016002)(54906003)(110136005)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4215;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IHebAoacymN/1OVXhOmooJSf6S57z2YUEcyRMmYswtZq74Km3XfAJNNAqGqALtZ1Ga7mwfF/I75Qa5RVPeAm3fhrlUYc8Nb3PT7E9UEM7kmXPYU5sZzrW5+xomaZTaQCndWfqmli6SpMlr+T9MRhbK39H2LOmnTVuYbRV2xRgH4lH2aEaq1bLlqS+lxabovq87LopYccdPfqsMSrbDPt3QqS7YQweZYY3b1yRq4ycpuTeEYh6Z40dwr0meC1IFE4JQD9Eo9OKZdoO6zMR/SfyD7+J+hsiLgzbLyDcAeJawB4aDFbNsl2oK9g1Yx83bMU1YFCk4cVRmjJfA2fhhML2x0xPyfF/b+KYqHEjg13m5cUr5pffIC5Oj/A1GEpZzQnT+FtLOKs1UFv0t63z/+lfO17yQAzOE2PNM7Vq19yeXbWX3+sfQPaABbQL8raR5fdmN0Z0u52/4kj098cia37FvoGh1OUrW6ZRd6/5rdcCJk=
x-ms-exchange-antispam-messagedata: 1IVjOilChouit5iM6OhiHuDLbjzVC7spe744/82SqPEa1odnMyIptl6425u2+MquQXAWXlHAheIRvQ5NqigbI4ew3LVBggjSD5gsYFWq2VjyrCTboyf4+P+R4jL4wNeYxcykVGWxgctZKM739lghrQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bba1be-27a6-4e3d-b3ac-08d7bc5f6db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 15:03:54.3337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xfOA6pWo8msLPlhEplN2inA9CGRSrMitYGZRXHngcgB0Kb8doXh8KAr4IY3rmZuMaepwHt7pKyqRf67kL4A3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
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
Content-Type: multipart/mixed; boundary="===============0075032545=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0075032545==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB39125494C4835547C9F8E313F7E80CH2PR12MB3912namp_"

--_000_CH2PR12MB39125494C4835547C9F8E313F7E80CH2PR12MB3912namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Let's just switch everyone over.  I think this should work for both bare me=
tal and SR-IOV.  Fewer code pathes to maintain.  Feel free to do it as a fo=
llow up patch.

Thanks,

Alex


________________________________
From: Zhao, Jiange <Jiange.Zhao@amd.com>
Sent: Thursday, February 27, 2020 10:02 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for gpu_c=
lock_count

Hi,

I got feedback from Linux team and they simply don't want to change.

I believe that it would work for bare metal as well.

Jiange
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, February 27, 2020 10:23 PM
To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for gpu_c=
lock_count


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

--_000_CH2PR12MB39125494C4835547C9F8E313F7E80CH2PR12MB3912namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Let's just switch everyone over.&nbsp; I think this should work for both ba=
re metal and SR-IOV.&nbsp; Fewer code pathes to maintain.&nbsp; Feel free t=
o do it as a follow up patch.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,<br>
</div>
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
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Zhao, Jiange &lt;Ji=
ange.Zhao@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 27, 2020 10:02 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@a=
md.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/sriov: Use VF-accessible register fo=
r gpu_clock_count</font>
<div>&nbsp;</div>
</div>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Hi,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I got feedback from Linux team and they simply don't want to change.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I believe that it would work for bare metal as well.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Jiange<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Deucher, Alexander =
&lt;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 27, 2020 10:23 PM<br>
<b>To:</b> Zhao, Jiange &lt;Jiange.Zhao@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@a=
md.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/sriov: Use VF-accessible register fo=
r gpu_clock_count</font>
<div>&nbsp;</div>
</div>
<div dir=3D"ltr">
<p style=3D"margin-top: 0px; margin-bottom: 0px;margin-top: 0px; margin-bot=
tom: 0px;font-family:Arial; font-size:10pt; color:#317100; margin:15pt" ali=
gn=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Is there any reason to not just use this for bare metal as well?</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" fa=
ce=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-g=
fx-bounces@lists.freedesktop.org&gt; on behalf of jianzh &lt;Jiange.Zhao@am=
d.com&gt;<br>
<b>Sent:</b> Thursday, February 27, 2020 6:21 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; Zhao, Jiange &lt;Jiange.=
Zhao@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sriov: Use VF-accessible register for gp=
u_clock_count</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size:1=
1pt">
<div class=3D"x_x_PlainText">Navi12 VK CTS subtest timestamp.calibrated.dev=
_domain_test failed<br>
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
</div>
</div>
</body>
</html>

--_000_CH2PR12MB39125494C4835547C9F8E313F7E80CH2PR12MB3912namp_--

--===============0075032545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0075032545==--
