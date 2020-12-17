Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71351C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 17:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E0E235DD
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 17:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E0E235DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F586E1BC;
	Thu, 17 Dec 2020 17:32:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E5F6E1BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 17:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAmP8Sw6gDWzyvZiNIrpR2+C2OgC4fTP7xTVSTKlLyifBcz5J2DcbSwG/58cvRP1rd5UKVr66YkMwKkENTA/QJB1qw/8AVwbN9DtInqt4UEvOSb4i9XU1Nzdzx+7PAj9eumdCYTJwxwhsKEFkuUNbRg/1Bk8yd2Jk9wPcRj2QOEBWLOMCO0hyy/dRH0HQKoxBLiLcupirUzZH3UqmET8ZwusZXI1CLC5CREM6TlNegOgtp3uplw++7FsZVTtFLQ5FDQOOrylOkcM8DTa4BHSmvPDR32pySG+zH7wSp14FULtULttScvHvetauZ63KJDeece7TPLvXrZoasgb+gPrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cjcl5a60TT10WJYguuAojMvQ4IiYw6D/cn9zG7amMRw=;
 b=maKJruLWhVp0ft1tsdoRjwdv3uu3lXIRHC8Z5l5HLi8C6pmC+tAQW4em3T/SG/fTf9smPUakXQdchy1/dmqep3j3HntAfYEHt5XBBwyBKKauvcOjkqH27vqeWwQs2ILq9zdo9MBR/5P9vx7kGgDQM4DxpYneAzRVTz+OFdb5iK+7EuPFPj9kuVTMDaWeBeUCBg+Q9b9XPvUG3544MuB0ZCimlmV6dR2tnnQ6AWPa85I1f5iS/UX8gTQMwHWORjL9x1mB8BsdQqRDti3aYCKy4C+FxjKFkJjNo1xMEhw217SFYll0cWKw0Pfnww3dEyQQVHuEyjVw7LOJWpWz3N6sNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cjcl5a60TT10WJYguuAojMvQ4IiYw6D/cn9zG7amMRw=;
 b=reSCD9QHu6W+tf4NDSZFq+sHjp9PWeS+MXfp2Y9UiFAGsozaiNQI11aKF9K7P6dp4NDxw6OJqqxMSFaKIjdH+PItMIdSRwlwkhImvCx7S5IICVID7U/NJj0ihEjNjY9Pu5tsOOSdA5sIWu0P6t15F/4aASmybMXAIL8exJdpCjc=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Thu, 17 Dec
 2020 17:32:27 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3%8]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 17:32:26 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux
 (MALL stutter)
Thread-Topic: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux
 (MALL stutter)
Thread-Index: AQHW1JV86Pyo88/tb0uKRGAsJd7p5an7hDGAgAAHUlo=
Date: Thu, 17 Dec 2020 17:32:26 +0000
Message-ID: <MW3PR12MB4554D9CAF479797E24D4108EF9C40@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20201217165459.3570331-1-Bhawanpreet.Lakha@amd.com>,
 <20201217165459.3570331-2-Bhawanpreet.Lakha@amd.com>,
 <MN2PR12MB448896B7772424C662E2EFD8F7C40@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB448896B7772424C662E2EFD8F7C40@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-17T17:32:26.731Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f49bce66-84c0-4f23-02a0-08d8a2b1b903
x-ms-traffictypediagnostic: MW3PR12MB4460:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB446003944CB094B66B33A18DF9C40@MW3PR12MB4460.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y0RlotTdNOB0CZMU7vkJPUZ0yksKOCkAI9efdgkY5DHyoGlmcddlXZb9CVax1KITlTE64BHGLDFiDAP/itODUnGhGdoiDLRSBXz9nP1PFviSawTu0RVIOkZHrT9cOEUqVt5mjPBv/b+gjdUTjPCTpbCgPginLZougEGYQJyZXC7rwBL2xiF0fOzCIrWTp2BMspqUZ6LFA4xk8MkHD5V6jV9QLfwLmIu6flBEIz5GGHF3ZvJasvqUDWAf8jzpYXfc+JU2e+M2ICI5htaS9/iOAYnRD+j4s0H1kGhWYpvytZBS8I3bi2mTyAYGioKFp2S7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(66556008)(9686003)(2906002)(64756008)(4326008)(66476007)(5660300002)(6506007)(76116006)(66446008)(7696005)(110136005)(83380400001)(91956017)(66946007)(33656002)(8676002)(186003)(86362001)(55016002)(52536014)(478600001)(53546011)(71200400001)(316002)(6636002)(26005)(8936002)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aIPAD8h+My/OkkWyPSbBi7HPVw4hYN5X7s+Iz/c+HVMkX7WdSjDT6BJ+5Fwt?=
 =?us-ascii?Q?OTE6a+SdP5VIndx5jsz4SnbG73NsOiyJ4bBYvIpwtCQ24oshZatdJiHV4Em+?=
 =?us-ascii?Q?qrsuZPRVKGVHc2ZgoEudfMPX6XQo7jH6tGLAGqec0YGkMXNMqWKztMbQYplh?=
 =?us-ascii?Q?+TWmrJYcYmJIMZXFbWAbDJ5gHfvsLYVgLJcrs8HIpwTq5MmwIL9fkLi3EaTM?=
 =?us-ascii?Q?qbYpahpWRLpOLwSUY7nBpykxQx8ja3uHYSrfBKJOpLeEKdUk++e6LoSrkk4n?=
 =?us-ascii?Q?Af42eqWtTxIgaaNxolAGLGfWGSNcwpWY9i2HHdIPca00J4MLDvr16sE7kzhJ?=
 =?us-ascii?Q?z196tFcl7lBg657M6a+VhPfRCrPbGOeMoP4rqFOuwy97E3jZ9Jd4JWm9ffeB?=
 =?us-ascii?Q?t3QMjt/Eeu7g8t/XTZ9AQRMFeoUxIp7lVKJ6qMsx5R1Ash0mFB+PdYbMkgfD?=
 =?us-ascii?Q?IzOBRBc2JIw5qci4E+O11D9CKsm4mOREKlKI9IDlk4rnfF02j/rJndy3Xtyd?=
 =?us-ascii?Q?F54g4OfrhA1DMajhGyATv/zFYg2sXfxybOGtQSu+j/pU2x3LoE1WpZR44v7x?=
 =?us-ascii?Q?fVYrJiw4E1wxu7k+XHAKpeKal7oAYfgBSdGXoohrXELEvlnSbfnY1Ugmb0Kq?=
 =?us-ascii?Q?1Ro3lXj7jo4tWUvPWw6tEke0ShUqU9SXt2nXchyGEZf5KLin3vrr5CG7VP+P?=
 =?us-ascii?Q?Hp7Rqqm4pFBb5Yd4QV1nOLC1xyaHm3cwrQoalvNQTaYeOZ2g85q4oM17CZdx?=
 =?us-ascii?Q?5v26psDbvHoBZRu/hleJc6vK/X0QUTrfgo/jjmVANenii8kVIYZuYWrxSTV1?=
 =?us-ascii?Q?9Nux9o/pmgq+s61/TaFJ5D+Sh2KthAJEMXSZC/I6T63Omarwojk09n+JTVJw?=
 =?us-ascii?Q?PRzgsHpxzcqiQTr+I2pgQhZaqfJ39T2dvoayGOY0kGwWD2c1DznSnkcsoBoP?=
 =?us-ascii?Q?5uh1MEIzWdzrFt7DAl2Myr5h8mOzF0RQrDQGvdVYEQc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49bce66-84c0-4f23-02a0-08d8a2b1b903
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 17:32:26.8255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhM36CRptI+4sFL8UKkjprbmiF/bZq5oI8EKHccIWrmNitCi9JGojQNfgoQ94Voc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1347809122=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1347809122==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4554D9CAF479797E24D4108EF9C40MW3PR12MB4554namp_"

--_000_MW3PR12MB4554D9CAF479797E24D4108EF9C40MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

I would but MALL is not fully validated so it might cause underflow issues =
if we keep it enabled by default. I can create a feature flag mask if that =
helps?

Bhawan
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: December 17, 2020 12:04 PM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Kazlauskas, Nicholas <N=
icholas.Kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/display: enable idle optimizations for lin=
ux (MALL stutter)


[AMD Public Use]

Can we drop the Kconfig?  With that, the series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Sent: Thursday, December 17, 2020 11:54 AM
To: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Deucher, Alexander =
<Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Lakha, B=
hawanpreet <Bhawanpreet.Lakha@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazl=
auskas@amd.com>
Subject: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux (=
MALL stutter)

[Why]
We can only use this feature when the display is idle. When active vblank
irq count is 0 we know all the displays are idle.

[How]
-Add a active vblank irq counter
-Update the counter when we enable/disable vblank irq
-if vblank irq count is 0 we can consider mall stutter

Change-Id: Ib1e14a84ee2e8c6e057072128693449665012584
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Nick Kazlauskas <Nicholas.Kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig           |  6 +++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  9 ++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +++
 4 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/disp=
lay/Kconfig
index 797b5d4b43e5..2444e664c7ee 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -23,6 +23,12 @@ config DRM_AMD_DC_HDCP
         help
           Choose this option if you want to support HDCP authentication.

+config DRM_AMD_DC_MALL
+       bool "Enable MALL support"
+       depends on DRM_AMD_DC
+       help
+         Choose this option if you want to support MALL
+
 config DRM_AMD_DC_SI
         bool "AMD DC support for Southern Islands ASICs"
         default n
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a78ec16418b3..080f2a52cfed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5479,6 +5479,7 @@ static inline int dm_set_vblank(struct drm_crtc *crtc=
, bool enable)
         struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);
         struct amdgpu_device *adev =3D drm_to_adev(crtc->dev);
         struct dm_crtc_state *acrtc_state =3D to_dm_crtc_state(crtc->state=
);
+       struct amdgpu_display_manager *dm =3D &adev->dm;
         int rc =3D 0;

         if (enable) {
@@ -5494,7 +5495,28 @@ static inline int dm_set_vblank(struct drm_crtc *crt=
c, bool enable)
                 return rc;

         irq_source =3D IRQ_TYPE_VBLANK + acrtc->otg_inst;
+#if defined(CONFIG_DRM_AMD_DC_MALL)
+
+       if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
+               return -EBUSY;
+
+       mutex_lock(&dm->dc_lock);
+
+       if (enable)
+               dm->active_vblank_irq_count++;
+       else
+               dm->active_vblank_irq_count--;
+
+       dc_allow_idle_optimizations(
+               adev->dm.dc, dm->active_vblank_irq_count =3D=3D 0 ? true : =
false);
+
+       DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->activ=
e_vblank_irq_count =3D=3D 0);
+       mutex_unlock(&dm->dc_lock);
+
+       return 0;
+#else
         return dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EB=
USY;
+#endif
 }

 static int dm_enable_vblank(struct drm_crtc *crtc)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 251af783f6b1..cab44bbd2e35 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -336,6 +336,15 @@ struct amdgpu_display_manager {
          */
         const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;

+#if defined(CONFIG_DRM_AMD_DC_MALL)
+       /**
+        * @active_vblank_irq_count
+        *
+        * number of currently active vblank irqs
+        */
+       uint32_t active_vblank_irq_count;
+#endif
+
 #ifdef CONFIG_DEBUG_FS
         /* set the crc calculation window*/
         struct drm_property *crc_win_x_start_property;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h
index 33642566bcb2..9d245033eb3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -504,6 +504,9 @@ struct dc_debug_options {
         bool dmcub_emulation;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
         bool disable_idle_power_optimizations;
+#endif
+#ifdef CONFIG_DRM_AMD_DC_MALL
+       unsigned int mall_size_override;
 #endif
         bool dmub_command_table; /* for testing only */
         struct dc_bw_validation_profile bw_val_profile;
--
2.25.1


--_000_MW3PR12MB4554D9CAF479797E24D4108EF9C40MW3PR12MB4554namp_
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
I would but MALL is not fully validated so it might cause underflow issues =
if we keep it enabled by default. I can create a feature flag mask if that =
helps?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Bhawan<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> December 17, 2020 12:04 PM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Kazlauskas=
, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/display: enable idle optimizations =
for linux (MALL stutter)</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#317100=
; margin:15pt">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Can we drop the Kconfig?&nbsp; With that, the series is:</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Bhawanpreet Lakha &=
lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 17, 2020 11:54 AM<br>
<b>To:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Deuche=
r, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Kazlauskas, Nich=
olas &lt;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/display: enable idle optimizations for =
linux (MALL stutter)</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">[Why]<br>
We can only use this feature when the display is idle. When active vblank<b=
r>
irq count is 0 we know all the displays are idle.<br>
<br>
[How]<br>
-Add a active vblank irq counter<br>
-Update the counter when we enable/disable vblank irq<br>
-if vblank irq count is 0 we can consider mall stutter<br>
<br>
Change-Id: Ib1e14a84ee2e8c6e057072128693449665012584<br>
Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Reviewed-by: Nick Kazlauskas &lt;Nicholas.Kazlauskas@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +++++<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++++++++=
+<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |&nbsp; 9 ++++++++<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<br>
&nbsp;4 files changed, 40 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/disp=
lay/Kconfig<br>
index 797b5d4b43e5..2444e664c7ee 100644<br>
--- a/drivers/gpu/drm/amd/display/Kconfig<br>
+++ b/drivers/gpu/drm/amd/display/Kconfig<br>
@@ -23,6 +23,12 @@ config DRM_AMD_DC_HDCP<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Choose this op=
tion if you want to support HDCP authentication.<br>
&nbsp;<br>
+config DRM_AMD_DC_MALL<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Enable MALL support&quot;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on DRM_AMD_DC<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Choose this option if you=
 want to support MALL<br>
+<br>
&nbsp;config DRM_AMD_DC_SI<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;AMD DC support =
for Southern Islands ASICs&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default n<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index a78ec16418b3..080f2a52cfed 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -5479,6 +5479,7 @@ static inline int dm_set_vblank(struct drm_crtc *crtc=
, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *acrtc =
=3D to_amdgpu_crtc(crtc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(crtc-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_crtc_state *acrt=
c_state =3D to_dm_crtc_state(crtc-&gt;state);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_display_manager *dm =3D=
 &amp;adev-&gt;dm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int rc =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
@@ -5494,7 +5495,28 @@ static inline int dm_set_vblank(struct drm_crtc *crt=
c, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return rc;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq_source =3D IRQ_TYPE_VB=
LANK + acrtc-&gt;otg_inst;<br>
+#if defined(CONFIG_DRM_AMD_DC_MALL)<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dc_interrupt_set(adev-&gt;dm.dc,=
 irq_source, enable))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EBUSY;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;dm-&gt;dc_lock);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dm-&gt;active_vblank_irq_count++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dm-&gt;active_vblank_irq_count--;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_allow_idle_optimizations(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;dm.dc, dm-&gt;active_vblank_irq_count =3D=3D 0 ? true :=
 false);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;Allow idle opt=
imizations (MALL): %d\n&quot;, dm-&gt;active_vblank_irq_count =3D=3D 0);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;dm-&gt;dc_lock);<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+#else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dc_interrupt_set(ad=
ev-&gt;dm.dc, irq_source, enable) ? 0 : -EBUSY;<br>
+#endif<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int dm_enable_vblank(struct drm_crtc *crtc)<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
index 251af783f6b1..cab44bbd2e35 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
@@ -336,6 +336,15 @@ struct amdgpu_display_manager {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gpu_info_soc_=
bounding_box_v1_0 *soc_bounding_box;<br>
&nbsp;<br>
+#if defined(CONFIG_DRM_AMD_DC_MALL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @active_vblank_irq_count<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * number of currently active vb=
lank irqs<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t active_vblank_irq_count;<br>
+#endif<br>
+<br>
&nbsp;#ifdef CONFIG_DEBUG_FS<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the crc calculation=
 window*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_property *crc_w=
in_x_start_property;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h<br>
index 33642566bcb2..9d245033eb3d 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dc.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dc.h<br>
@@ -504,6 +504,9 @@ struct dc_debug_options {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool dmcub_emulation;<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_idle_power_op=
timizations;<br>
+#endif<br>
+#ifdef CONFIG_DRM_AMD_DC_MALL<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int mall_size_override;<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool dmub_command_table; /=
* for testing only */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_bw_validation_pr=
ofile bw_val_profile;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_MW3PR12MB4554D9CAF479797E24D4108EF9C40MW3PR12MB4554namp_--

--===============1347809122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1347809122==--
