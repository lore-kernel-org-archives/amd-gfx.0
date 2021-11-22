Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC201C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 16:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BAFA89354;
	Mon, 22 Nov 2021 16:43:19 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0022E89354
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 16:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkFQvq412WVeKbh8Iq1t3Mkoidvk/YgAInwpCnD/wpmQuK1duzWUsBoY7bUmJCmt9LvNAXByTKOrnqsSrxsFXWGdrY1O0DEqRgJTKFHnlU4ZBh3z+S3TloXfxgw6tIJ506JpG7GFJ9tRNcqrPFn6KrEljqdm7IYXudWqR02aTGgkJIqVscJ3no1hvs9EMBCFq1TtIJyAX9IEesk0MqvcYZ3KOEs5XN5T/kl9fdfLVLS5/mGW7CBeDf8pnj6wIspuMv1zlYhZBENRz7FXf0fOtL1lQUlPFrsCCgLCAbfdwOCWpriH4oXN3OIKhTvPExyzx0JuEDkLWSHixJEgzxHpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm4MkD2JaY88OypN1VaCczmjk10kd5OQuWgOIYoEDdw=;
 b=lFx2r5G1bREC981/LQYJMQ+daak3E/l3rLRmo6MSAUcE/SSDBvtBhhH5SyjTzrPs8pQdEYv4IV99WhuUSy5UKlCDzcaoBbHBO4WUbpceblF6tZHR5jRHCwoc+0q6QXeriG6HawgINdPaY+WAoug6NLDkCav2upJMbknT9m+GUM6HZpEBo5/8abfsq9FrmWT7TA6UfOhqhhbHZ6dZgHNKfge17ckHbljxGMtvj/eKoHu6nKTIqo/Set2/EycyVGtgxBZnVwcjvjB0Ki6d6FvF0xuRxuz/5gdkOJZAEXYySOrCIYFLK5TGZjd3itrh1jcN9lRDuNdtOfXyVfQmG9j0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xm4MkD2JaY88OypN1VaCczmjk10kd5OQuWgOIYoEDdw=;
 b=OTa0BNx+JtTqES/RNLggn6Q0/OUhOsh4rKPicY/LCQixDMxQNtMQi2Gj9BZJzyou1tU97fQ7Yh78f+EV2T3o9pA6T2oMYHMRLtRIYmUkOnPZnwycUUm8wrSvAJ7EERvG1ATplxZEO/Hr4ctby2cNgyJ9awPZQrXEQpf56lH5Jto=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 16:43:16 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 16:43:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings
Thread-Index: AQHX34BAh0aHDNRctU6dzz0dOSZJKawPkIEAgAAvFFo=
Date: Mon, 22 Nov 2021 16:43:15 +0000
Message-ID: <BL1PR12MB51440B523B58CA96EA7BC0C0F79F9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211122090353.1399178-1-flora.cui@amd.com>
 <DM5PR12MB2469709B28E24F1C8FCB573EF19F9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469709B28E24F1C8FCB573EF19F9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-22T16:43:15.383Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: cad34cd7-091c-30df-7fea-df180a95a0e8
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2fc8096-bcb1-4b17-8444-08d9add72e97
x-ms-traffictypediagnostic: BL1PR12MB5254:
x-microsoft-antispam-prvs: <BL1PR12MB52547E7CED8446A77D4CD344F79F9@BL1PR12MB5254.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gnCBDzYDi99bIEJ7EJon0kBSm1TcdsM14rzEGdzwa6MSRzap3JKPNicZ94HOKKsr2k6lTOEjSvZNkVn5YoNwC2uH9TYqJlfQzyrr65IeBHzgi5B3t0hyFhe+OtOTWl3Crcr0k2EILw4F1FbZo8Z6M2/qygqefDOvVBAUb0UPLSjl/WPIBDptDJzxEAD1lRy27T9QvjttjmlLQedPTVYOvk3nvwO7+NWniPHbcPbBHDLXUtTcM8+scslm0nbXRWF3jHx4aKLygfvjDcGveBy6n4ewxaRp8Wdf1+9nezYkAHj0btJ3O0X7872rnW6h12OzYepbiNhB2A54FQkxeGLucyxNjjoRMbmXLP9qb8U8Gdt+3y3/L7QvqGfQzRgbPH7w11/+esessucJHS07OxAVbIHHl099V4+yqtZrAxaHAElaj72KUOCKyA/dXeq3InkdY7OywfJEVTcTCwSSAlEjKhSe9+v3dS0TBmYX5ImNScnmHVS4fBf65VVt+HvMZVunZLBWdhY/LXRxxSbC+EuZP/QuNAduMejTb2D1tdexTnYjO5dCMNFsu3iZ0TNyuFId5sHkgoj+Y/hI4OLp6NdOVGw1+rA/WR/Rw8wNBDnPPJjO/VOzWEDTta99Fps7Bepo+HRnP5OePoSLA/xic4wOjSK+FZ5qPUE/WHem5KhRl9gUljlwDynSX4OCKmBCZhGQWHdvmZ9Y+M++St6bMYDKNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(5660300002)(122000001)(38100700002)(66476007)(2906002)(316002)(66946007)(64756008)(9686003)(76116006)(66556008)(86362001)(6506007)(19627405001)(71200400001)(53546011)(110136005)(55016002)(52536014)(508600001)(26005)(8676002)(38070700005)(186003)(7696005)(8936002)(83380400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GdpfrAnnN2nBojvm+XXG3mGRYprSlw+hKiotzIuGQFLQltTY9bnTtUH2B+o4?=
 =?us-ascii?Q?j6KJ2Phuhqi8/kAbZUHcLOmr+1GP707S9We/e5j3fVDPcQKz0epjJfjWE4yA?=
 =?us-ascii?Q?KjEEF2hLUwH/ngvc1m/vNBHZI4jTEQdHyWGcq7rKvkyqw+JjHSSR16jZ67eV?=
 =?us-ascii?Q?IMlPCayjGPcX4Ha5mXexASVi7uE1GYNv75zZi2fLOK+vgdtUy/VNV4zIzi9g?=
 =?us-ascii?Q?7j3oq6GOBY6X0PJzmyZ8bha/zO0E15cDpEK2GhOyecvotqhQ4t/88n+K6HUv?=
 =?us-ascii?Q?fFQ2qZdLbf0M7ag2WggpulT9920kyadKv/yhiKLpt6yA6g20e1gHGvMT8ZCu?=
 =?us-ascii?Q?Uhc3dIHMSJMEleUN7GuO287eaqwDxg3WkxfO+6JHSroFzzZEThPopOBuNdlG?=
 =?us-ascii?Q?zuPnxXeiUVUMABctm66IVxzMO3eCDRNAtu/OpIOroLOZ8kteWgI+N224sKLB?=
 =?us-ascii?Q?BzF4MrULuCrcpxJobFzU48cqjwlsvhJFFZb3nndGXUi157fU/cGcsw59YXDd?=
 =?us-ascii?Q?KzfQDXzCc00VBirnp7Ya9RcccXV3SWtP0/40S0yutgiMp/KRLfL7eeTzwzg6?=
 =?us-ascii?Q?azu1P/BNZ45RoLOdMktyFsFMRZHZSwOEQhYVxbivc7O96N08tldecncC3kZz?=
 =?us-ascii?Q?d/klgWrvyeBJi6ffNrOa9VMIl5cmwTFRg6mwrQzot41ZmYqLANlxabQQz98v?=
 =?us-ascii?Q?Yjp9cR+lYWXPD9HUXst/fnmJFjeivy16FHlOO+ZIwosQsSOC8xHQv2ie2fhi?=
 =?us-ascii?Q?5qSROmbzQ4p3PpGSyiUB/l/fX5uoPa7hoSGmhUl7fPHGad944ao2Fju5+36h?=
 =?us-ascii?Q?HHVwB1fMLzbZse52NOYruE3NaxyzF4Big3B83Ldhctb5SOqNtPjAU7XDP7EX?=
 =?us-ascii?Q?ps2XFPiyQlMYOdw9cdHb1Xo8Ed0MTuY7mvLaLvcLmNMwbtxRwSRxHSd0sWmx?=
 =?us-ascii?Q?JGtrNAQY89UIEgLRuURVd4mqqjVGUWmZFfDyCwS/Tg6NKwpUcndhVl7bhAMU?=
 =?us-ascii?Q?abQZ8WxHiB6A3ZFdogelty5nVVuh6Y+pbyHR6vbTpO5UKCuWKcmtiD9APswi?=
 =?us-ascii?Q?7SITSlf4MzG1aTa2bjFOG9S32lEYMmLH/8HbCSmRXAroBZPa2VlO4yOebwmk?=
 =?us-ascii?Q?y9y47m47LHFTS1/ikSGSmhv0hLQFVpEW95qrg/rVhc/SxpOyOH2RWiSEv2Qr?=
 =?us-ascii?Q?Awk8HOtLHs5dBWKIvka0dLgeZHLhdS4f32KJZ3gUEO331owf78M5UkUhixPD?=
 =?us-ascii?Q?23U9Y8H37t5ku7GQ3bH4Qipzy9sVieIMnYNp8tjukbHW4AZWwOvYzisjaW7p?=
 =?us-ascii?Q?pYHBjbsXAf0H69n/6SwYLxwWJd+SsQk03UtUMAV9Z8RNVT0rp44KxB4+z3iW?=
 =?us-ascii?Q?o7QEFzaLNiCruyBcYp3WBcYrJW0lt+Bwiv037MVraNMoLpA1WidxxttDb/A+?=
 =?us-ascii?Q?PMBu1uB5Z1gp+l6/SAZP/BlnjgWQzFRU/5KwXR/xFdlZSbbhNGyFVn01FeTx?=
 =?us-ascii?Q?tKLK/VE/BGXY3PM4hMVfR3VFxr23o1Gh1PxX3Iw05XyyNYYqZHm9pZUlDS37?=
 =?us-ascii?Q?mCx20t3AFpQMDNiNWgUWDE5qbSayVmIMswtOUu3Mdg7xhXtj4OouE1p9uQjo?=
 =?us-ascii?Q?XOzSOvZCAhPl7KwLdBQ01Hk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51440B523B58CA96EA7BC0C0F79F9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fc8096-bcb1-4b17-8444-08d9add72e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 16:43:15.9527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lsi260ew16/NqID0/LUABb3kQdUgkHFbmNLMNjpgUkI8q4zT1yc2tUbNkqobPLk+nBSL6hjbTrF172MHG1b4ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51440B523B58CA96EA7BC0C0F79F9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Can you explain how the current code is failing?  It's not immediately obvi=
ous to me.  I'm not opposed to this change, it's just not clear to me where=
 the current code fails.

Alex

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Monday, November 22, 2021 8:49 AM
To: Cui, Flora <Flora.Cui@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings

[Public]

Series is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

+Alex to comment this series as well.

Regards,
Guchun

-----Original Message-----
From: Cui, Flora <Flora.Cui@amd.com>
Sent: Monday, November 22, 2021 5:04 PM
To: amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Cui, Flora <Flora.Cui@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings

otherwise adev->mode_info.crtcs[] is NULL

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 38 ++++++++++++++++--------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h |  5 ++--
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index ce982afeff91..6c62c45e3e3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -16,6 +16,8 @@
 #include "ivsrcid/ivsrcid_vislands30.h"
 #include "amdgpu_vkms.h"
 #include "amdgpu_display.h"
+#include "atom.h"
+#include "amdgpu_irq.h"

 /**
  * DOC: amdgpu_vkms
@@ -41,14 +43,13 @@ static const u32 amdgpu_vkms_formats[] =3D {

 static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *ti=
mer)  {
-       struct amdgpu_vkms_output *output =3D container_of(timer,
-                                                        struct amdgpu_vkms=
_output,
-                                                        vblank_hrtimer);
-       struct drm_crtc *crtc =3D &output->crtc;
+       struct amdgpu_crtc *amdgpu_crtc =3D container_of(timer, struct amdg=
pu_crtc, vblank_timer);
+       struct drm_crtc *crtc =3D &amdgpu_crtc->base;
+       struct amdgpu_vkms_output *output =3D
+drm_crtc_to_amdgpu_vkms_output(crtc);
         u64 ret_overrun;
         bool ret;

-       ret_overrun =3D hrtimer_forward_now(&output->vblank_hrtimer,
+       ret_overrun =3D hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
                                           output->period_ns);
         WARN_ON(ret_overrun !=3D 1);

@@ -65,22 +66,21 @@ static int amdgpu_vkms_enable_vblank(struct drm_crtc *c=
rtc)
         unsigned int pipe =3D drm_crtc_index(crtc);
         struct drm_vblank_crtc *vblank =3D &dev->vblank[pipe];
         struct amdgpu_vkms_output *out =3D drm_crtc_to_amdgpu_vkms_output(=
crtc);
+       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);

         drm_calc_timestamping_constants(crtc, &crtc->mode);

-       hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_RE=
L);
-       out->vblank_hrtimer.function =3D &amdgpu_vkms_vblank_simulate;
         out->period_ns =3D ktime_set(0, vblank->framedur_ns);
-       hrtimer_start(&out->vblank_hrtimer, out->period_ns, HRTIMER_MODE_RE=
L);
+       hrtimer_start(&amdgpu_crtc->vblank_timer, out->period_ns,
+HRTIMER_MODE_REL);

         return 0;
 }

 static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)  {
-       struct amdgpu_vkms_output *out =3D drm_crtc_to_amdgpu_vkms_output(c=
rtc);
+       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);

-       hrtimer_cancel(&out->vblank_hrtimer);
+       hrtimer_cancel(&amdgpu_crtc->vblank_timer);
 }

 static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc, @@ -92=
,13 +92,14 @@ static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc =
*crtc,
         unsigned int pipe =3D crtc->index;
         struct amdgpu_vkms_output *output =3D drm_crtc_to_amdgpu_vkms_outp=
ut(crtc);
         struct drm_vblank_crtc *vblank =3D &dev->vblank[pipe];
+       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);

         if (!READ_ONCE(vblank->enabled)) {
                 *vblank_time =3D ktime_get();
                 return true;
         }

-       *vblank_time =3D READ_ONCE(output->vblank_hrtimer.node.expires);
+       *vblank_time =3D READ_ONCE(amdgpu_crtc->vblank_timer.node.expires);

         if (WARN_ON(*vblank_time =3D=3D vblank->time))
                 return true;
@@ -165,6 +166,8 @@ static const struct drm_crtc_helper_funcs amdgpu_vkms_c=
rtc_helper_funcs =3D {  static int amdgpu_vkms_crtc_init(struct drm_device =
*dev, struct drm_crtc *crtc,
                           struct drm_plane *primary, struct drm_plane *cur=
sor)  {
+       struct amdgpu_device *adev =3D drm_to_adev(dev);
+       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
         int ret;

         ret =3D drm_crtc_init_with_planes(dev, crtc, primary, cursor, @@ -=
176,6 +179,17 @@ static int amdgpu_vkms_crtc_init(struct drm_device *dev, s=
truct drm_crtc *crtc,

         drm_crtc_helper_add(crtc, &amdgpu_vkms_crtc_helper_funcs);

+       amdgpu_crtc->crtc_id =3D drm_crtc_index(crtc);
+       adev->mode_info.crtcs[drm_crtc_index(crtc)] =3D amdgpu_crtc;
+
+       amdgpu_crtc->pll_id =3D ATOM_PPLL_INVALID;
+       amdgpu_crtc->encoder =3D NULL;
+       amdgpu_crtc->connector =3D NULL;
+       amdgpu_crtc->vsync_timer_enabled =3D AMDGPU_IRQ_STATE_DISABLE;
+
+       hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC, HRTIMER_M=
ODE_REL);
+       amdgpu_crtc->vblank_timer.function =3D &amdgpu_vkms_vblank_simulate=
;
+
         return ret;
 }

@@ -401,7 +415,7 @@ int amdgpu_vkms_output_init(struct drm_device *dev,  {
         struct drm_connector *connector =3D &output->connector;
         struct drm_encoder *encoder =3D &output->encoder;
-       struct drm_crtc *crtc =3D &output->crtc;
+       struct drm_crtc *crtc =3D &output->crtc.base;
         struct drm_plane *primary, *cursor =3D NULL;
         int ret;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.h
index 97f1b79c0724..4f8722ff37c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
@@ -10,15 +10,14 @@
 #define YRES_MAX  16384

 #define drm_crtc_to_amdgpu_vkms_output(target) \
-       container_of(target, struct amdgpu_vkms_output, crtc)
+       container_of(target, struct amdgpu_vkms_output, crtc.base)

 extern const struct amdgpu_ip_block_version amdgpu_vkms_ip_block;

 struct amdgpu_vkms_output {
-       struct drm_crtc crtc;
+       struct amdgpu_crtc crtc;
         struct drm_encoder encoder;
         struct drm_connector connector;
-       struct hrtimer vblank_hrtimer;
         ktime_t period_ns;
         struct drm_pending_vblank_event *event;  };
--
2.25.1

--_000_BL1PR12MB51440B523B58CA96EA7BC0C0F79F9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Can you explain how the current code is failing?&nbsp; It's not immediately=
 obvious to me.&nbsp; I'm not opposed to this change, it's just not clear t=
o me where the current code fails.<br>
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
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Monday, November 22, 2021 8:49 AM<br>
<b>To:</b> Cui, Flora &lt;Flora.Cui@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &lt;Alexander=
.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Public]<br>
<br>
Series is:<br>
Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
<br>
+Alex to comment this series as well.<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: Cui, Flora &lt;Flora.Cui@amd.com&gt; <br>
Sent: Monday, November 22, 2021 5:04 PM<br>
To: amd-gfx@lists.freedesktop.org; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;=
<br>
Cc: Cui, Flora &lt;Flora.Cui@amd.com&gt;<br>
Subject: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings<br>
<br>
otherwise adev-&gt;mode_info.crtcs[] is NULL<br>
<br>
Signed-off-by: Flora Cui &lt;flora.cui@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 38 ++++++++++++++++-------=
-&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h |&nbsp; 5 ++--<br>
&nbsp;2 files changed, 28 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c<br>
index ce982afeff91..6c62c45e3e3e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c<br>
@@ -16,6 +16,8 @@<br>
&nbsp;#include &quot;ivsrcid/ivsrcid_vislands30.h&quot;<br>
&nbsp;#include &quot;amdgpu_vkms.h&quot;<br>
&nbsp;#include &quot;amdgpu_display.h&quot;<br>
+#include &quot;atom.h&quot;<br>
+#include &quot;amdgpu_irq.h&quot;<br>
&nbsp;<br>
&nbsp;/**<br>
&nbsp; * DOC: amdgpu_vkms<br>
@@ -41,14 +43,13 @@ static const u32 amdgpu_vkms_formats[] =3D {<br>
&nbsp;<br>
&nbsp;static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtime=
r *timer)&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vkms_output *output =3D=
 container_of(timer,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vkms_output,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vblank_hrtimer);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc =3D &amp;output=
-&gt;crtc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc =3D c=
ontainer_of(timer, struct amdgpu_crtc, vblank_timer);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc =3D &amp;amdgpu=
_crtc-&gt;base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vkms_output *output =3D=
 <br>
+drm_crtc_to_amdgpu_vkms_output(crtc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 ret_overrun;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret_overrun =3D hrtimer_forward_now(&=
amp;output-&gt;vblank_hrtimer,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret_overrun =3D hrtimer_forward_now(&=
amp;amdgpu_crtc-&gt;vblank_timer,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; output-&gt;period_ns);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ret_overrun !=3D 1=
);<br>
&nbsp;<br>
@@ -65,22 +66,21 @@ static int amdgpu_vkms_enable_vblank(struct drm_crtc *c=
rtc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pipe =3D drm_=
crtc_index(crtc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_vblank_crtc *vb=
lank =3D &amp;dev-&gt;vblank[pipe];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vkms_output =
*out =3D drm_crtc_to_amdgpu_vkms_output(crtc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc =3D t=
o_amdgpu_crtc(crtc);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_calc_timestamping_cons=
tants(crtc, &amp;crtc-&gt;mode);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_init(&amp;out-&gt;vblank_hrti=
mer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out-&gt;vblank_hrtimer.function =3D &=
amp;amdgpu_vkms_vblank_simulate;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out-&gt;period_ns =3D ktim=
e_set(0, vblank-&gt;framedur_ns);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_start(&amp;out-&gt;vblank_hrt=
imer, out-&gt;period_ns, HRTIMER_MODE_REL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_start(&amp;amdgpu_crtc-&gt;vb=
lank_timer, out-&gt;period_ns, <br>
+HRTIMER_MODE_REL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)&nbsp; {=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vkms_output *out =3D dr=
m_crtc_to_amdgpu_vkms_output(crtc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc =3D t=
o_amdgpu_crtc(crtc);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_cancel(&amp;out-&gt;vblank_hr=
timer);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_cancel(&amp;amdgpu_crtc-&gt;v=
blank_timer);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc, @=
@ -92,13 +92,14 @@ static bool amdgpu_vkms_get_vblank_timestamp(struct drm_=
crtc *crtc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pipe =3D crtc=
-&gt;index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vkms_output =
*output =3D drm_crtc_to_amdgpu_vkms_output(crtc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_vblank_crtc *vb=
lank =3D &amp;dev-&gt;vblank[pipe];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc =3D t=
o_amdgpu_crtc(crtc);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!READ_ONCE(vblank-&gt;=
enabled)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *vblank_time =3D ktime_get();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vblank_time =3D READ_ONCE(output-&gt=
;vblank_hrtimer.node.expires);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vblank_time =3D READ_ONCE(amdgpu_crt=
c-&gt;vblank_timer.node.expires);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON(*vblank_time =
=3D=3D vblank-&gt;time))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
@@ -165,6 +166,8 @@ static const struct drm_crtc_helper_funcs amdgpu_vkms_c=
rtc_helper_funcs =3D {&nbsp; static int amdgpu_vkms_crtc_init(struct drm_de=
vice *dev, struct drm_crtc *crtc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct drm_plane *primary, struct drm_plane *cursor)&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D drm_to=
_adev(dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc =3D t=
o_amdgpu_crtc(crtc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drm_crtc_init_with=
_planes(dev, crtc, primary, cursor, @@ -176,6 +179,17 @@ static int amdgpu_=
vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_crtc_helper_add(crtc, =
&amp;amdgpu_vkms_crtc_helper_funcs);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;crtc_id =3D drm_crtc_=
index(crtc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.crtcs[drm_crtc_ind=
ex(crtc)] =3D amdgpu_crtc;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;pll_id =3D ATOM_PPLL_=
INVALID;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;encoder =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;connector =3D NULL;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;vsync_timer_enabled =
=3D AMDGPU_IRQ_STATE_DISABLE;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_init(&amp;amdgpu_crtc-&gt;vbl=
ank_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;vblank_timer.function=
 =3D &amp;amdgpu_vkms_vblank_simulate;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -401,7 +415,7 @@ int amdgpu_vkms_output_init(struct drm_device *dev,&nbs=
p; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector *conn=
ector =3D &amp;output-&gt;connector;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_encoder *encode=
r =3D &amp;output-&gt;encoder;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc =3D &amp;output=
-&gt;crtc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc =3D &amp;output=
-&gt;crtc.base;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_plane *primary,=
 *cursor =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.h<br>
index 97f1b79c0724..4f8722ff37c2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h<br>
@@ -10,15 +10,14 @@<br>
&nbsp;#define YRES_MAX&nbsp; 16384<br>
&nbsp;<br>
&nbsp;#define drm_crtc_to_amdgpu_vkms_output(target) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of(target, struct amdgpu_vk=
ms_output, crtc)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of(target, struct amdgpu_vk=
ms_output, crtc.base)<br>
&nbsp;<br>
&nbsp;extern const struct amdgpu_ip_block_version amdgpu_vkms_ip_block;<br>
&nbsp;<br>
&nbsp;struct amdgpu_vkms_output {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc crtc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc crtc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_encoder encoder=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector conne=
ctor;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hrtimer vblank_hrtimer;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t period_ns;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_pending_vblank_=
event *event;&nbsp; };<br>
--<br>
2.25.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51440B523B58CA96EA7BC0C0F79F9BL1PR12MB5144namp_--
