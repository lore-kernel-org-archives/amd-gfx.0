Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE526C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 13:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A80B89DBF;
	Mon, 22 Nov 2021 13:49:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD7F89DBF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 13:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwabO2WChOtp+ZyudqAhBUZaqP1Vg5IjvEUU5fKbpYAzS44fYSqgB8k6fzlnZgnayKUCspg2NoeZ9ZhkY+MYPaaX/qezVWabD33spuOuBkaKY5KdhCvP6YW4Czzl71e84VOqdSLke5jFXvKqRIwK5tn1/kcAy/vdVCTR3l4B7oaEGc26lcx+4Ou7vXRGH2K7naH8n9cNdusYkD5RRXClYMkkmK9DpKc886rFO55aALc/mUF/QuxqwrtYFvNr+e0Inc0kRL8aV2bN80uSV3d3546UYE0K6kD+gxEw4E3OhuyqHnvUaP/6tY7Ywztu/33XM/G2wRwVPLxt2sNi1b61pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnjiWB56N/TcVDEXMqfWlzyyR/lB0bV8yVC5l0NCZdc=;
 b=I3lVLMlcDNY9lzICrK/QM3PoqnntnD1tT7DUscsb9IoQP4PzvuNqWR65aKWrfVBOyiXUz8MJjSdnggaKeco6eLw/gGHT2wXWUyVMP0LrBacmHMDC23oCCbmzvU+uvc7bsVkyFBgppBUnIiUnBHjVNNz4gyqhsbOeVDDX+VUgAUrQhUUVj70GBb5oDGty3NPZwJum/PCPEv1iS7vY2PxOE9O/ExPgbch1eJjPVEkhDKh831bp3iLWuDAf51hdRUnpYEAXDIK0YRdas/c6qYOZjNhic5zZIZdzSQI6cq8XLVpmhaqpxMBbkWfuxRsPhOC7NeL02LjL3BNdd6f3wkHHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnjiWB56N/TcVDEXMqfWlzyyR/lB0bV8yVC5l0NCZdc=;
 b=fz3oyUjCqNBw+sHAUSmDpMrW538t9BLlxN6cjkYMQQVTR74ThqXY96DZP4P+VHFqJLVgf29wfmVHzkuQB54zCvYGCfHniV7v7a1T18St4rS5QrKox8H74IIPzDDWhpuLTWmfXLcJH1ruQRPjYcuPZayH9uQ8ryi+v9huq2lzLg4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Mon, 22 Nov 2021 13:49:22 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4713.019; Mon, 22 Nov 2021
 13:49:22 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Cui, Flora" <Flora.Cui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings
Thread-Index: AQHX34A5HMvunoUuLkiLqW7OEXwlcKwPkDXA
Date: Mon, 22 Nov 2021 13:49:22 +0000
Message-ID: <DM5PR12MB2469709B28E24F1C8FCB573EF19F9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211122090353.1399178-1-flora.cui@amd.com>
In-Reply-To: <20211122090353.1399178-1-flora.cui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-22T13:49:16Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=92b010e6-113c-4418-b1ee-9041c5fc0780;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb12a32f-6ae5-4334-29c1-08d9adbee39b
x-ms-traffictypediagnostic: DM6PR12MB2892:
x-microsoft-antispam-prvs: <DM6PR12MB2892FA940D570BFB8B2F8511F19F9@DM6PR12MB2892.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 39aFc8keq8Lqu4/IxAgdAReceyOX089mnOCxeLZYalLbpUIAtRuMOYB0OxRO1ruVDnCXDqDrUgZcblaBU6xg34ChvfNTplXjQCPere8syJb1WKFxT15zFrygsQRH05DCZJUgfvmoKxO1GDrEjs1f219WEs5/KCqHUz9mFs0VDB0wyR0+SbmAluAY12FzU/IE2mGXuVkxNBlcTBBD4TFB89XSoVOPermJjJEbredVumoTsYr1CtqXIVmRdeBR/8Wo5JWrZ8EP/a87M8QsxAJ/J6+YCzHYxC0e3P/cF2nzaOD/fM35IlzTbf29wT3eh3RIQOsqJQt/JPS/hsirda1FvIkQX909qx2PbZBc5/csz61MuzwbFYrvhXGvl/ZJfmoZfsZ51TAcHQxpQlQ9BWY+fAHPlTEJwwbK+WJxIrjaJNb89TlEXN5x1vSD3obJlB4F7K1IBS2394L8OQdxDLK8ihG8yuM1oGU0EMewavZul1CR2t1zuG+ZbkVnhYE9QUjNZS+J2+VNFASd6gEyE/dAIgwKSZ0G4hpocO2l3vSAcwhnkfC/LUk+FjvsIu2gzWJHKABsbEE5YY3xUw6kQBJHkL9vE4lmnwBC2Hr9/efoWFPO09GhjTnw/dB2OfxJB+sLRg7Qy4YPi+s2Y8jyfN6Ufw3aYLt8lAkbrSrdECFwceDjg/94pQMC9Ee0V+TOmxeMJ7HTjONHb0+GFXwNSMvaGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(86362001)(71200400001)(83380400001)(6506007)(53546011)(2906002)(5660300002)(6636002)(26005)(8676002)(7696005)(66446008)(64756008)(66556008)(66476007)(66946007)(8936002)(186003)(76116006)(55016002)(52536014)(316002)(110136005)(33656002)(9686003)(122000001)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TeMrugN/0r9H+0lgrlgZZcqu1Ck6VsTx2v6U3R0jn6HJpf7atBopvgqMFR6D?=
 =?us-ascii?Q?c/4s3Hu8sC+E7Lzy9/7hm1Yzq+KH3wYkF9Gu1swPcEpYqHmDneTYLAEvmNrS?=
 =?us-ascii?Q?8yJBVKrpx7U4lD4ZbAij0f+jO9Ohl5KZQPrmg/LliNrQXGDeOkF6/9rOvzs+?=
 =?us-ascii?Q?0ptdIuYQ9WoixLjFbFdrgN0UIq0a6E2KmgGtuIyQ+OBMXT2UBJZtWiDSwNna?=
 =?us-ascii?Q?MpkzsVXplCt1mdBsuA/V1c0ycCJ/aOCxoGK30Yvz9eyvt9z7w2Nwogt6G9F3?=
 =?us-ascii?Q?7uVkv1x391x2J9cKqTBb3Ln6JBtfFzFFusoa4vyV1pJhnxuL69GYyUOIzdfw?=
 =?us-ascii?Q?ioAZc4oeycm66SwfMXcR92KKuY5lZCWl1Mi4qf0edBK1MyshRiMdX6Y4zCj5?=
 =?us-ascii?Q?0gNVR4t6C7Ov3oonKSKnDt4MBaqXox9pLT/Zqfmf4Ilpk+ov1Tm8bchjWwyd?=
 =?us-ascii?Q?wQjzukuFYOzNMO/IzzXqK85teqfHLR/ABgxeNAXXR9R8ZMAbYIAoSU3M2mM7?=
 =?us-ascii?Q?0N1NfIxquBMqGTIz6HwS/MFCEo7/JqJLSZ/CE671MM3hSGDhqWbMm4jUAPpn?=
 =?us-ascii?Q?E3kZlgYdgoQZsVuJG3C1k5h3PLKYPlFC0Fr1Mh3zivGNJsMXKUvQbi/OYadK?=
 =?us-ascii?Q?9kWLLx8IUmF6fkDf9c16rgQp20aDTxsqpAX1Wf9lmXhPNLfk8Poiq1dLBH5R?=
 =?us-ascii?Q?6CmGBAIYw9n0PFvVMj8/Z2OPM0yFyoEdefhXNZXvyiGDElN4ALt1rF/O3KI/?=
 =?us-ascii?Q?b8y+b4yw7rvJGP++Ug+vGncrweCoiH2iGTBtPU+Nuz+NbbZ47jMvnZ1E6BHH?=
 =?us-ascii?Q?FmaLdTongE/KK56QWdUhf4Z5SJCBeftSmMXWckbK/qB5iqWJUKvhRAfNDPDl?=
 =?us-ascii?Q?LlMP6xPha0D19N5qtdRP0meWX9HGltyU7tOUYLWlmcTDcdRsNB4lfXUzK9O4?=
 =?us-ascii?Q?wQbHUv4cPB30FEGMt1f6gIL66L74/XqFvT+01IXfUayMvp+08XLh9a57Cymq?=
 =?us-ascii?Q?5WEoHKJbkzw6uuK0yI7su8ykKkrtM5Gyj6YJV0q8nDFUdNX/9g/qE2FhZGH8?=
 =?us-ascii?Q?g6A1CuH0zmMk6JSIHJvfe165R5S42+XSxh13OP10Jxcx/HrFSBfMcTjWA2QU?=
 =?us-ascii?Q?tPFXUkZrA2Yx3kL1caW55eXgO8JCypI/7zGY/Jil2hXdqZTg4IizS7v/o0Wp?=
 =?us-ascii?Q?ZOI77snqDWfI8Nqkde0j75GfMKPFAyH40nNkGPPdNmEUjn75GYEZfwfYRRj4?=
 =?us-ascii?Q?KlsQPu0KD4YkNccWwEM8nAg3y4HgoEVUH+RjRzeIMGRI9qgzieFVBmjvdk1a?=
 =?us-ascii?Q?kcTHXJaWkBGeJCZZGvJVOwne3Vq1gwqGg3b5LtQQl4ETBH5sVlkNXBL3JILU?=
 =?us-ascii?Q?OkQvF6Xg78z20NuOsdk/6gVRwMpPWQroVHQvUaOaq2KqE2e3iVNxDn+zOee0?=
 =?us-ascii?Q?GIRhbO4pni4mTmEE1BcEk3K2kzo/bpkGFgan+T6hz8ZQAyBnDoGOtkyUCBAy?=
 =?us-ascii?Q?gqESF91qZr5ysU/wG6qERmYy7Zv+U55GNZ2Ggxb3pNbSyEtmg1Z7p57AY25d?=
 =?us-ascii?Q?WsGCSy2ZWjGJjDMA8c34tRGb9XnwMzeW937754tG5nDyEUJiyIO1QxUtoR9P?=
 =?us-ascii?Q?usZYHg5KTCcUej9CJhxcK6E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb12a32f-6ae5-4334-29c1-08d9adbee39b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 13:49:22.1455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2hdKF7RHLyLVacf+5KLg26gab7tPLfnjD+R1emZqnXPP3y0MS2tJEskbheQUY3WAp0cMnzhvkR+77ezaotmZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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

[Public]

Series is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

+Alex to comment this series as well.

Regards,
Guchun

-----Original Message-----
From: Cui, Flora <Flora.Cui@amd.com>=20
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
=20
 /**
  * DOC: amdgpu_vkms
@@ -41,14 +43,13 @@ static const u32 amdgpu_vkms_formats[] =3D {
=20
 static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *ti=
mer)  {
-	struct amdgpu_vkms_output *output =3D container_of(timer,
-							 struct amdgpu_vkms_output,
-							 vblank_hrtimer);
-	struct drm_crtc *crtc =3D &output->crtc;
+	struct amdgpu_crtc *amdgpu_crtc =3D container_of(timer, struct amdgpu_crt=
c, vblank_timer);
+	struct drm_crtc *crtc =3D &amdgpu_crtc->base;
+	struct amdgpu_vkms_output *output =3D=20
+drm_crtc_to_amdgpu_vkms_output(crtc);
 	u64 ret_overrun;
 	bool ret;
=20
-	ret_overrun =3D hrtimer_forward_now(&output->vblank_hrtimer,
+	ret_overrun =3D hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
 					  output->period_ns);
 	WARN_ON(ret_overrun !=3D 1);
=20
@@ -65,22 +66,21 @@ static int amdgpu_vkms_enable_vblank(struct drm_crtc *c=
rtc)
 	unsigned int pipe =3D drm_crtc_index(crtc);
 	struct drm_vblank_crtc *vblank =3D &dev->vblank[pipe];
 	struct amdgpu_vkms_output *out =3D drm_crtc_to_amdgpu_vkms_output(crtc);
+	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
=20
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
=20
-	hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	out->vblank_hrtimer.function =3D &amdgpu_vkms_vblank_simulate;
 	out->period_ns =3D ktime_set(0, vblank->framedur_ns);
-	hrtimer_start(&out->vblank_hrtimer, out->period_ns, HRTIMER_MODE_REL);
+	hrtimer_start(&amdgpu_crtc->vblank_timer, out->period_ns,=20
+HRTIMER_MODE_REL);
=20
 	return 0;
 }
=20
 static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)  {
-	struct amdgpu_vkms_output *out =3D drm_crtc_to_amdgpu_vkms_output(crtc);
+	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
=20
-	hrtimer_cancel(&out->vblank_hrtimer);
+	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
 }
=20
 static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc, @@ -92=
,13 +92,14 @@ static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc =
*crtc,
 	unsigned int pipe =3D crtc->index;
 	struct amdgpu_vkms_output *output =3D drm_crtc_to_amdgpu_vkms_output(crtc=
);
 	struct drm_vblank_crtc *vblank =3D &dev->vblank[pipe];
+	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
=20
 	if (!READ_ONCE(vblank->enabled)) {
 		*vblank_time =3D ktime_get();
 		return true;
 	}
=20
-	*vblank_time =3D READ_ONCE(output->vblank_hrtimer.node.expires);
+	*vblank_time =3D READ_ONCE(amdgpu_crtc->vblank_timer.node.expires);
=20
 	if (WARN_ON(*vblank_time =3D=3D vblank->time))
 		return true;
@@ -165,6 +166,8 @@ static const struct drm_crtc_helper_funcs amdgpu_vkms_c=
rtc_helper_funcs =3D {  static int amdgpu_vkms_crtc_init(struct drm_device =
*dev, struct drm_crtc *crtc,
 			  struct drm_plane *primary, struct drm_plane *cursor)  {
+	struct amdgpu_device *adev =3D drm_to_adev(dev);
+	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
 	int ret;
=20
 	ret =3D drm_crtc_init_with_planes(dev, crtc, primary, cursor, @@ -176,6 +=
179,17 @@ static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct d=
rm_crtc *crtc,
=20
 	drm_crtc_helper_add(crtc, &amdgpu_vkms_crtc_helper_funcs);
=20
+	amdgpu_crtc->crtc_id =3D drm_crtc_index(crtc);
+	adev->mode_info.crtcs[drm_crtc_index(crtc)] =3D amdgpu_crtc;
+
+	amdgpu_crtc->pll_id =3D ATOM_PPLL_INVALID;
+	amdgpu_crtc->encoder =3D NULL;
+	amdgpu_crtc->connector =3D NULL;
+	amdgpu_crtc->vsync_timer_enabled =3D AMDGPU_IRQ_STATE_DISABLE;
+
+	hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC, HRTIMER_MODE_RE=
L);
+	amdgpu_crtc->vblank_timer.function =3D &amdgpu_vkms_vblank_simulate;
+
 	return ret;
 }
=20
@@ -401,7 +415,7 @@ int amdgpu_vkms_output_init(struct drm_device *dev,  {
 	struct drm_connector *connector =3D &output->connector;
 	struct drm_encoder *encoder =3D &output->encoder;
-	struct drm_crtc *crtc =3D &output->crtc;
+	struct drm_crtc *crtc =3D &output->crtc.base;
 	struct drm_plane *primary, *cursor =3D NULL;
 	int ret;
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.h
index 97f1b79c0724..4f8722ff37c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
@@ -10,15 +10,14 @@
 #define YRES_MAX  16384
=20
 #define drm_crtc_to_amdgpu_vkms_output(target) \
-	container_of(target, struct amdgpu_vkms_output, crtc)
+	container_of(target, struct amdgpu_vkms_output, crtc.base)
=20
 extern const struct amdgpu_ip_block_version amdgpu_vkms_ip_block;
=20
 struct amdgpu_vkms_output {
-	struct drm_crtc crtc;
+	struct amdgpu_crtc crtc;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
-	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
 	struct drm_pending_vblank_event *event;  };
--
2.25.1
