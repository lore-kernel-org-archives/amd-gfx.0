Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3EFC2BB9A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 17:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A4423426
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 17:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A4423426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DAE8896E7;
	Thu, 17 Dec 2020 17:42:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5279E896E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 17:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFQvjb1ehEwPMKNztf4gjYVOcPTJH5qaMgKAwnsxdPjg/98HcmFE9/EPifNIkRuJlOZi7gKVrUU6pSnnaYZcLhs4q0atm6BkQpXqduvkYsTpjnIzSRdbyYaXZY6nS5X6C5ienawVVhtr8onGeeBQxqsoM3n9tKi2YIBY860lcNaK1D1vtgokj8bNiREsePVAN6XUJC9kISyb0ZBRprLez4MblP2S2A1G7q7zLtHu7hqgpsI/bzOMckWhj8crt1UUbrhDrg7rhg+nRr98rp4lnRuQoH0HesqJ1BMJKTad/s51zE2M9rM+u+nkJV78czmZa7KqPRuo6HyYuDji+uhrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr9ojSaHfSIhwwDKrVovY6NzhrNo6XEhpoT88L1fr3c=;
 b=DFt3CcKlsPUo5SftK70mSqEHWyuvselDPy5FZQWT5M5icbA2tiH9C1FFteTmIx3SogId/jL0lUNZR3dBUyl88HC+RLJjiL8I+k6XOvVigfayc6WCT7QDBccbGC1+hpP/zR5/wYTOv8FJ0SSlJyWM/pin4F62Dfo/bLhrNluLEv+Tor+Nd/bGy3rmW1ZvKXGP9lpuOdpUvEtTBsxJlC/8J8uDHvc9Q5ZEwklocnbZH1MDUEYybNpbenhjLIIQh5uV52n4z+AfCOKgILjvUKxW2Mzlzwc/RO/u3+Vy79KePIaNyoTqGA03qpGmrXqU9J6TmUiRI4GBi2faT1oqVXA23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr9ojSaHfSIhwwDKrVovY6NzhrNo6XEhpoT88L1fr3c=;
 b=FM2Q2g60TsWJnAyEDwMH5J5JA4f5AzI3hsQ9AdnYQ0MgM6fPuKm6k0faAt+bPaQF6UvybPyluNyrFqpgzfszOZGqdBJrkVemkaQ+hya6xyx6/0dWTlADpxZTf7pHtSRpThvpHzGBBeA9hsE/YqQaMk1ET7OidIkCCyBzZ7AsYRI=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR1201MB0253.namprd12.prod.outlook.com (2603:10b6:301:52::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Thu, 17 Dec
 2020 17:41:59 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3%8]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 17:41:59 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux
 (MALL stutter)
Thread-Topic: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux
 (MALL stutter)
Thread-Index: AQHW1JV86Pyo88/tb0uKRGAsJd7p5an7hDGAgAAHUlqAAALYZw==
Date: Thu, 17 Dec 2020 17:41:59 +0000
Message-ID: <MW3PR12MB45540F913662D5CE5ABFC87BF9C40@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20201217165459.3570331-1-Bhawanpreet.Lakha@amd.com>,
 <20201217165459.3570331-2-Bhawanpreet.Lakha@amd.com>,
 <MN2PR12MB448896B7772424C662E2EFD8F7C40@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <MW3PR12MB4554D9CAF479797E24D4108EF9C40@MW3PR12MB4554.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB4554D9CAF479797E24D4108EF9C40@MW3PR12MB4554.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-17T17:41:59.762Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70257a70-db8d-4070-90be-08d8a2b30e7b
x-ms-traffictypediagnostic: MWHPR1201MB0253:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB0253E0AFC81A3498248E4C4DF9C40@MWHPR1201MB0253.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H1vrejUKF0JmXYT8F2ZoCL2zT1zWphvN/Zg/am74YS2sVBCt8Rvi1W1TAJoDkTJpMRozRX++Aa75uccg8agH52wVReX6auvV4cOfLWf0H5ffLeYO/wmwNg259tL0qq2RQRUsXI1+lidgPyJVSRVrX09Qgx8giLe43lmd5R6Jhl9KVgcEIQuB4lXeWAne7qnHOAZcJdlZdt2NhInK1w25KPBDJGluagf8OQ4uTxDZyAYnBoJSMV5ZOTzXtMXsKvdM7rxpDzdzcuns1g9oBRRat8YfRyWukMr+5NC2SRmyY2491LFyKPiJRYnAesBMQszF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(8676002)(186003)(91956017)(8936002)(86362001)(6506007)(7696005)(6636002)(53546011)(66446008)(5660300002)(316002)(9686003)(66476007)(33656002)(64756008)(26005)(66946007)(71200400001)(110136005)(66556008)(478600001)(2906002)(76116006)(2940100002)(19627405001)(83380400001)(55016002)(4326008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FSHIH5TyMdGrZRf3kKDDvri+r1KlPOmfai4cILFvRr3eebwRADNBG8h5E25C?=
 =?us-ascii?Q?05G9xAfFTjX3H/KJJk4mMQvuR1tD9wctKCCoay65icy0CGlUBwCVhUurBW3G?=
 =?us-ascii?Q?RZa2SF7ZtaRn47fslWFXozHpLg4az1S/ObjZlIMGJ7EU7+SpBIjMXleQ+Seb?=
 =?us-ascii?Q?comTg7TSlw2CEHL8yAyc9WbX00ybZBcWb8z6iUA12GZWiOmSs3saRzkJ0O70?=
 =?us-ascii?Q?KgdYbuHyE4skr47qnONwIRLwq/j1nQ46GrYeU/S9nVANO9+ISClK+w0MnuKQ?=
 =?us-ascii?Q?CFkuSWWu1DPCOO1L63BTxCQYcm7H9AbuA07Mumo1YvXZuATBJaGpUdp1OrFK?=
 =?us-ascii?Q?JtD5kYlylePy5gl732hb/9YlSGOulk40wwiXtHLh8Y0yJpP/dOC9bqWUmXRy?=
 =?us-ascii?Q?MYIR4igrcX0c/mDmBlL5c8hczqt2AqmlApB24818sJGhcprJGeekTBfNbYbm?=
 =?us-ascii?Q?do2emCLNr+jxvL2kDBjeAJRSFipSz7JAJyP9bwOIVqmGS8r+UNDYRxgY/cQu?=
 =?us-ascii?Q?4263mU61WlT+cfQCCBpGYJIPveDquX2Ci+Eth9iy8/9RYg9MUmG5NEL744bf?=
 =?us-ascii?Q?DHdNWSK/USt2bedE0MHc7xrC1dTB8hdW7B9JzRhEWiGuB0Ws8BKiMBpSEzg8?=
 =?us-ascii?Q?QEia+lJcP/amyMxm4B4JioQZCNCr6ErfGww2GiA4cxoBOZs+JmGBmJsgqf4Z?=
 =?us-ascii?Q?XcqX+62EjwCT/Tlt+ICclQeNbjDBYhyLCE/GlGdvq95DpTM+9HI2o55llKzp?=
 =?us-ascii?Q?ofwnA45TyanTy2kEq6+Ej2ZvzN8kdyYb4VTr4UU5Dm4jOBlzH/d9vePXbELm?=
 =?us-ascii?Q?jYGiJClRzt2i8JkX2qOWWHEmYSmgsYUe5ny4r01T1dOYHhpXDsJg78gax5Xv?=
 =?us-ascii?Q?AMCXBOOp3u1umfawQ02e4MVPQ44AycVu0pOF9M36PwNbsZm4MaC57CILMtym?=
 =?us-ascii?Q?/2ZDGboCZkBQHT6zcobwQztlRwnMGKQcQGBiL+Hik7g=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70257a70-db8d-4070-90be-08d8a2b30e7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 17:41:59.7405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9GgXuEbZZo8lOr+Gs9+TAiqs8uK2m4gmHRduYl5/3g/roikLmwH79HQi6ZpBvXCo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0253
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
Content-Type: multipart/mixed; boundary="===============1463353781=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1463353781==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB45540F913662D5CE5ABFC87BF9C40MW3PR12MB4554namp_"

--_000_MW3PR12MB45540F913662D5CE5ABFC87BF9C40MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Actually, I will drop the guards and if we see issues related to this, we c=
an block it.

Bhawan
________________________________
From: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Sent: December 17, 2020 12:32 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Kazlauskas, Nicholas <N=
icholas.Kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/display: enable idle optimizations for lin=
ux (MALL stutter)

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


--_000_MW3PR12MB45540F913662D5CE5ABFC87BF9C40MW3PR12MB4554namp_
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
Actually, I will drop the guards and if we see issues related to this, we c=
an block it.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lakha, Bhawanpreet &l=
t;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Sent:</b> December 17, 2020 12:32 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kazlauskas=
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
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I would but MALL is not fully validated so it might cause underflow issues =
if we keep it enabled by default. I can create a feature flag mask if that =
helps?</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Bhawan<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander =
&lt;Alexander.Deucher@amd.com&gt;<br>
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
<div id=3D"x_x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif=
" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Bhawanpreet Lakha=
 &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
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
<div class=3D"x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size:1=
1pt">
<div class=3D"x_x_PlainText">[Why]<br>
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
</div>
</body>
</html>

--_000_MW3PR12MB45540F913662D5CE5ABFC87BF9C40MW3PR12MB4554namp_--

--===============1463353781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1463353781==--
