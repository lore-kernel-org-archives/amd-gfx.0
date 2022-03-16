Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAA1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 00:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42DAF10E4A4;
	Wed, 16 Mar 2022 00:56:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B5010E4A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 00:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGLyHF7HZfQya0G3YKVaiUggmX5vQcjYc573agzDFBnkNXlkdTqlu8GXhrZ8vkb8LibhkTJiEzTFOZE0YR5xrI7kvdqP5dF8OXfN+yv2O1LGeMGFXJeNadHtkjgDORAeFR/RYqpuu2pdj+cY8kW+9M1vH9J9xBAJOGORnWW45V2KXsGM0kzCoizAWbpvLP96SlJhJZjNbAM5j9xlNZfaa7p7Mg5IIrJc4NoWMCyhaPDtTWLIVWYbfudSMmnaimC4cFLOCCcrs1zr+LSAkz+uDQ7lnWkSadqW21pT00v8wocqxSnTCosPz72cnEXoEMCZyuWiquYt6S9QKrVPwHXaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdRGNUJV+ufOIBOJJJ86i2Q9Q4SEcQn6rkRxi6hsrXs=;
 b=hffzq9NB2YVj4xx+pLfvwCiZQ2DWi4VU9tiQ7ES9Z943AfwEkZ5QYrQ7jCaHf6PWTPEEeziBCVipEsjak2N6iiUdu4LBqYbi0YdNilpMAG8nTPf+xcnO9VQ7rV8BDKz6zBZ3GSp+WXLSfhSLO9rQu7jezHYeT5kHvUt1bWBC0vBmr5UYiF1Et4QSlqV/LkKe6lyeWwGDg4YI40y7xt1FM0WDgrk0peruXx+NVMq4Gm4LmrsEH3zaXk7AA4veVy5O0LYgAsjlUGO2nYXf6mBY65GrI7K3a+qUUWBpzKN69XYrD5YWLUFelRGuBzKXpQGLZINgRnL9wk8FGj2IY7HJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdRGNUJV+ufOIBOJJJ86i2Q9Q4SEcQn6rkRxi6hsrXs=;
 b=ydyU+5T18UHi8yh43zS6ttWUav5lJgp2HfI1vEux51ZieI7W+KslkD9cY1PZYJkv9/VNZdGo3EuS9byiwk+HuM58J1sh+UeRTRP97+V7CLULu2jk9yIGmUld67zNLFpyATSwidGL5i8amJzmekIoHd5LFc3xy/oqElhnQ1LKJqM=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Wed, 16 Mar 2022 00:55:58 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c5cf:8668:2fc7:afc4]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c5cf:8668:2fc7:afc4%7]) with mapi id 15.20.5061.029; Wed, 16 Mar 2022
 00:55:58 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: make amdgpu_display_framebuffer_init()
 static
Thread-Topic: [PATCH 1/3] drm/amdgpu: make amdgpu_display_framebuffer_init()
 static
Thread-Index: AQHYOI9zNuTrab+eXkyMhHKVW7IxAKzBL/ZA
Date: Wed, 16 Mar 2022 00:55:58 +0000
Message-ID: <DM5PR12MB2469FA3A27302187259A993EF1119@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220315170914.2804385-1-alexander.deucher@amd.com>
In-Reply-To: <20220315170914.2804385-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb455ba5-0518-420f-e00d-08da06e7bc1c
x-ms-traffictypediagnostic: DM6PR12MB4498:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4498342501285F79074CEAC3F1119@DM6PR12MB4498.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kk3pxeitwH53KACqojomexq77fTGBbW/4op0x9LZ/EG42L1W7jmnpD5p3B0TbwT59atQuGncNXNIsqDOkW2ECl2rDXW57Z0lS8N3u+2/y/g6kvsXxmvKk/FTqI0JGQPEMSCqVe17qDTVSjUucSXgYygnJwIySnmBXJ3TbW3+A4ISdIvxf9cL4aoieD/delg1lGLdECr+9xCB+ptcnbiet0SUSbYT8zGa7QifUFWM5rl0saoft3A93BTbUW+w6V4BoE7VWOaFLTMq9ArAwr8WXZg/P5PlNxaAhX/Pai94Q53i5yraT8BmieXbfoM6ewYmvI1f2Lf5Jd0KQFsyDZDHkwXy5BbfsZm6M+WrzQBK6SSZCLqn2nNOZUGdvaolssU9ZxcUF7sZmNxwxV8Ms48BwEWTXD3L55tlfr8wbiazLR6Z1BdinyssFQr80hxU+SOMOYnH76w1Rl2nnMU0X5FVU2T8iq+Tu47W5bSW3sVH7g1EmUlPFRVxDLctOvED3in8uuGC/PkfSyZSwQLcOjyb5j9vVyXWlX13B4EtyfHQ4c2iZS1enip7FvodIApmwQTuzN034dhBl87jDXFwUV66Gd+Uz4Vei7lJyO8nMvi+nLYrI+JdHJrGWg0hLhbzTAUswPnTfVNzKgTwt41ROHgnmxWQgk5Xe9TsTAQirNKz80sLUWn4CRCUbn9iCThwOKK/653B0l0rVwdnIzaRim5x6w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(26005)(83380400001)(9686003)(186003)(8936002)(86362001)(52536014)(5660300002)(508600001)(2906002)(71200400001)(53546011)(122000001)(7696005)(6506007)(76116006)(8676002)(66446008)(66476007)(66556008)(66946007)(64756008)(4326008)(33656002)(110136005)(55016003)(316002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8IcsMBV0VvSWRHmUllsjrbcOi2fB9p/O1G+3mmkvk7WKSvWY+nSoNO0c5bjp?=
 =?us-ascii?Q?VbHIhpZhYW+Sjo7o5bQ2qC80WRtfscMMBerWXYq+7QIBHeEHYzuQteKtz3O7?=
 =?us-ascii?Q?/CZ7EmJplPD4bo2LpJDevQA5ZP7QccVkwbDRVs0vX9hZbefR4EFosll9r1XG?=
 =?us-ascii?Q?QReTCrrTK09HHA3yuZC7Dpje4rLsnTe7UcXWuaGPVMEeGcd5P/i0bL55sUWU?=
 =?us-ascii?Q?DuUaAkm2/vQtVTDMEF2+t40z+Ie7zDSh6hcC5Q+0qa7tWfnrzwxtBVYjBmnf?=
 =?us-ascii?Q?Z+Ksb9YgeJ5vZqhE+tN0HXK8HtarWiIxGxJpJ5gJlejW7NAdIg6RKEM9HkgE?=
 =?us-ascii?Q?iBQL4XZr3cRAfRV+PNdxA8yl4BcYref1iKYZfHx8eiRhB32C/RebphTMBaxq?=
 =?us-ascii?Q?IJA00sNB6fydUWFzd9gAVuS804vASboEesDDQr3nVrZ593UaCr0/FbMvN6R/?=
 =?us-ascii?Q?rCY9GRCxGhHUOfLggZmxa4GLa6SoLoFF8LflhH5jm5L2YIeMlqJFeo8gIu9L?=
 =?us-ascii?Q?dlzefnEyH2iPrPAdHNM4Xl+Lxq0wIcLpxhsXz6zXYfe4LsBbxWE+qilSSNWU?=
 =?us-ascii?Q?4zDlGtV6Dk3kBijOATyppyae7OAwvTv8oPSI9pOggyYUoTDC6kPPmZv0h3Np?=
 =?us-ascii?Q?tpq9cwaKINTO43/2CtiRqBb9TO777HLqxAicQ1mHFbAZuW6vC808FHX3IGzO?=
 =?us-ascii?Q?OolJZI0SByomd0Da2WeJEqP3APrvtN+Q3ePude8huelgSQOLytbJrJl2iti4?=
 =?us-ascii?Q?vIkceZxVrgiF9i28hO1VozIsjRNk7K9neU9Hzwmi+rto5tlRau5aeMeWyhqZ?=
 =?us-ascii?Q?5nEzVtQe1qO0J0WbnKL9DakNSrVFNzx4BqNbTCK1V2ywk8iNUcoCazcNClIf?=
 =?us-ascii?Q?MDBPMh8/jnfHcfitoR5qNZd7kzmgzTFKWPEJ/mW37G6BbDMdT5EUx4odnVr3?=
 =?us-ascii?Q?ss3Z8G5WAMIaCWvj1z8TLwa4Q0o6+TweAMXG5ndhE1mP5ULOBgYN+RbwtCoi?=
 =?us-ascii?Q?DXcdo/h0h7MxLbAN7a6NUsAGQ5wub/LL9bh3ku367RoVNF7OyW9xmQxxV71V?=
 =?us-ascii?Q?d85OAYAHFk0DvN34Ky7dXTZMo54iyRDGRHlSUSvkFOk334qNInXGaKekw1DG?=
 =?us-ascii?Q?Nb3ICrjlHTe6Fyuj0+MxbnYbLjNBs894Fuzl2L05Hu9lDYu3/T58RUdTOQb2?=
 =?us-ascii?Q?5NFbQuPzJQTUBZeJLIfNTn5D4Z64eZ5XmBLENbdxu0RZSqT1Iegwy/xvHku7?=
 =?us-ascii?Q?NMvLUt0E4Htnucu1Y3TF4rUxB+IfeaI2REbfOmDAF6RUsaZy5H8B8gwvzLZt?=
 =?us-ascii?Q?gMKjHASSKKWkw6/nWz8aEMGzgy6b4ejVxScFOjaDvwD21pe6Xyqnf+jc2Wd9?=
 =?us-ascii?Q?pT2AVi9xS0MkykoHL77iOVrbA7JC7qhXqppE+F/LhGH1DMl2YzXg2rfYvfV2?=
 =?us-ascii?Q?nMUTozhA6rOlzQWDClaCYwS+BwqiV5g7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb455ba5-0518-420f-e00d-08da06e7bc1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 00:55:58.8317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: df7P0HCkrWc1GSgbQ+4a3tcQCbIvC85tSOTMslR37WjeLIa9BU2glz66nKkT2kHgYlfmYxdJ+GPTW4BsZnX+8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series are: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, March 16, 2022 1:09 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: make amdgpu_display_framebuffer_init() sta=
tic

It's not used outside of amdgpu_display.c.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 13 +++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |  4 ----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 70be09dd2a93..cb78ba396672 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -41,6 +41,11 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_vblank.h>
=20
+static int amdgpu_display_framebuffer_init(struct drm_device *dev,
+					   struct amdgpu_framebuffer *rfb,
+					   const struct drm_mode_fb_cmd2 *mode_cmd,
+					   struct drm_gem_object *obj);
+
 static void amdgpu_display_flip_callback(struct dma_fence *f,
 					 struct dma_fence_cb *cb)
 {
@@ -1097,10 +1102,10 @@ int amdgpu_display_gem_fb_verify_and_init(
 	return ret;
 }
=20
-int amdgpu_display_framebuffer_init(struct drm_device *dev,
-				    struct amdgpu_framebuffer *rfb,
-				    const struct drm_mode_fb_cmd2 *mode_cmd,
-				    struct drm_gem_object *obj)
+static int amdgpu_display_framebuffer_init(struct drm_device *dev,
+					   struct amdgpu_framebuffer *rfb,
+					   const struct drm_mode_fb_cmd2 *mode_cmd,
+					   struct drm_gem_object *obj)
 {
 	struct amdgpu_device *adev =3D drm_to_adev(dev);
 	int ret, i;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_mode.h
index 28848f1348a8..69ce2eeb782e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -600,10 +600,6 @@ int amdgpu_display_gem_fb_verify_and_init(
 	struct drm_device *dev, struct amdgpu_framebuffer *rfb,
 	struct drm_file *file_priv, const struct drm_mode_fb_cmd2 *mode_cmd,
 	struct drm_gem_object *obj);
-int amdgpu_display_framebuffer_init(struct drm_device *dev,
-				    struct amdgpu_framebuffer *rfb,
-				    const struct drm_mode_fb_cmd2 *mode_cmd,
-				    struct drm_gem_object *obj);
=20
 int amdgpufb_remove(struct drm_device *dev, struct drm_framebuffer *fb);
=20
--=20
2.35.1

