Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3347EC4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 17:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCD1233A0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 17:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCD1233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D7328997E;
	Thu, 17 Dec 2020 17:04:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FDC58997E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 17:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afjZK5bBvluA1GGSnl5e4OKhRDRlhj2XOi0a9qg8dX4qDQSaw59xjks/Moe64OTkTV2bAiWLwLeA5zchb/kdGvD6qtstCrBAJw6EUkz+U3mxvMKJh5oh/d4i6uqXjlo7UuRUIpJxnFfumkFxj30hwKhgbsSi4wEhuD+tgKI4fhiOO9SpTMceS8tn/VEvgA5bdEuS7/DwivbI67uIG1O2gl9n7yLPoXON/EBeCjGSNNAfeh/Dexy9SD7b0vJM6CiejBNH6k9R3giUx9NOdTBFBFWq7GKB/RYSJ04lacIp7sTn/96y6n8giTcBUw8tezyT9B5V+5b1l1Pq9/zGnGtksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf71desZqK3qk9DTFKJ6N5ddYETXCbt1eBjC7LK9Nps=;
 b=eOpGcXurU7lzcw7NF8T44XfugQehnM+RQJsigbh5g6tXQ7M5jfFbzZvQuzaG+lYyhauqs8lWH2hIxkvxZAco+0p1+5XjAwgTlaFreWiYwP9xzMDd4GRKjNvJXhi74cj9lZ0z5GbnLXlqsKUK1CmTfRdKCnClWO4FqwWYZgrIMsWJIMCwTl8Za/b6k6BnLQLdRB5+6Q+9obwuvpkDtZ7Pw0vm8M2isjATOO36bW+lHP0i9TTvlZyPpoQMPop2pRnAPR2p7eyjxy5toEjpEcmLpzY01D7lqHxouIPd2SWA5xBUdz8rHaSsDRvIClgciioudANaq+/5P2FU5x/TwuDO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf71desZqK3qk9DTFKJ6N5ddYETXCbt1eBjC7LK9Nps=;
 b=oqQFvXhhJzSxzRzyYNrjTg6CtZfLdwZue5XE7hnllxvKWvzQDiqkMDrbeWBDJ9BJCOd0h1oq8KR/lgT7+IL9YMxB8Lu3od9gI85nEofx+RGSGy5fT6X7bn8yirQ91Nqo2vkVMBMElXmFtGHUS3RaxYN9U2VCrKJK+1y2S008qwE=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 17 Dec
 2020 17:04:29 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%4]) with mapi id 15.20.3654.024; Thu, 17 Dec 2020
 17:04:29 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux
 (MALL stutter)
Thread-Topic: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux
 (MALL stutter)
Thread-Index: AQHW1JV8olitLSabDEeLnC2/c1Ebv6n7g/6P
Date: Thu, 17 Dec 2020 17:04:29 +0000
Message-ID: <MN2PR12MB448896B7772424C662E2EFD8F7C40@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201217165459.3570331-1-Bhawanpreet.Lakha@amd.com>,
 <20201217165459.3570331-2-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20201217165459.3570331-2-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-17T17:04:29.208Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 465f9829-7cfb-4ffc-bd2a-08d8a2add14f
x-ms-traffictypediagnostic: MN2PR12MB4344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4344141EF4B44C0C3643EABDF7C40@MN2PR12MB4344.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F54IhspG9ZSiIqHRpx+nsxgZVx0gowNFrwmy6wEUNV8/gQRp33Usb1mdr8d+QuI3gCpHSk0d/4jniTY2fzhBKNfIFb0RUbpit8dicMYbWYKNQwvKiIQntrWlnmPYW9V4KWjep2kEbJgKJcQTxZLJNcsk0SuYLFowegETDh40wvNQN2dW8gj33+fsOB2YbwGc5uu6B5Sjy7Inc5THP3jzF0pixx+5brPgjlBFyorbDRz6eCzMjk49xZ109mVyiWtF9Oc+TV1dTjJjj/2MIHMVAxCUqw0QUSYDl9PbMj1zGgvlaXPbVYnXSs8t5ejN72wy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(8676002)(86362001)(83380400001)(66446008)(7696005)(55016002)(66556008)(19627405001)(76116006)(8936002)(4326008)(66946007)(64756008)(66476007)(6636002)(33656002)(71200400001)(2906002)(53546011)(6506007)(5660300002)(316002)(26005)(110136005)(52536014)(186003)(9686003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?b3TR92HqhaemGCha+xt/J+FiSbJAFHuavLB3axw8yd0R01WGSaxlkQNFd6S1?=
 =?us-ascii?Q?yBMRNWCcAXnZH9fV9ZFFc4Ej5g0LGC+J5My20R91CxqS/h9Rsv7qk4kI+X8x?=
 =?us-ascii?Q?zIJ9LJK3FanqgVsiCxjfeDYMldPXNIRB1oh9KFGdsdfyOre+63VXTghXwGw9?=
 =?us-ascii?Q?SDjr88NWR3vV/Outm0y3AoIQ1adIXM3JOD1ao479FHHNGEiDMFvdUDUOyEWT?=
 =?us-ascii?Q?qGh9NeXIMgGQ5bp5d3ekkZfOP6xxrKF9QSZZRBE6mvN193iGabaRk6LnR2yz?=
 =?us-ascii?Q?Vpu8kKgxCZU0GiroA4f8Pyl0yqWy22jChTkE0/QkzOrbpvUH1VirFWQnCq2O?=
 =?us-ascii?Q?Oqezuu6PCEsRaR7u9Y03YXfG4MuFNj6EB8++0auailtKEfxttH9MVjIOtR69?=
 =?us-ascii?Q?OEQs99TyBz2sxtFtEnAVau2woVT7ALCJG66uLxwX56wxFQytozR6jvZrbo2j?=
 =?us-ascii?Q?o0ignpKkHLYoGYEwLnfWFPfzHPFYtd7E1sAT3uGhfWWzDXlc0tnP8gAGr+uS?=
 =?us-ascii?Q?uRZakH4itUoIU88pv9pikUXKCoNbVipolz+IrweDCrckke1s3ZGrMkMRi8vh?=
 =?us-ascii?Q?e1cJVllzChlxFOOv6pgzxck5HOi8jJT0ykb4yBE+HLc7NtbkH0iNH+PRdHA2?=
 =?us-ascii?Q?8HmASErYP8u4ayqFn7mIbDPgtQrRwFsy6Xv1o/8OunwT1ZJ3BFLIoZZxJL4X?=
 =?us-ascii?Q?jefVUyuwxtS2Wc6il2au2JYy7HG1DLLsn8J+vCOXlacbO6y5hUiBk5ywm2En?=
 =?us-ascii?Q?iXRNtN55iLG/y5V/b9Yf1vtGva9pROmgllJ8AkJb9hTBmcKT2deRyzpnW2Ud?=
 =?us-ascii?Q?D/wLrb9GnAaZpPZEwFeVTojv4dN3EjIHQDn3rA2+1nUQYd7vEVE9zrsMskD/?=
 =?us-ascii?Q?LsFMvpXOuMHRb6susGZcTGo4y+R9nwZrkAFo6sjQoz9ER+ockysR1yYmDbFS?=
 =?us-ascii?Q?fs8h9SVQpzyi452N3CI1mXSpTVUrLTUk5UW4HjUNUHs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465f9829-7cfb-4ffc-bd2a-08d8a2add14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 17:04:29.7163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uPF2i+TiVV9TltmPv2hdRDUxRMnG7CJReckwJeOSGXrMB0/7Hz3m3O/uulvy+rIx1BithfsZNBFo5tSBN+qBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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
Content-Type: multipart/mixed; boundary="===============0298196209=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0298196209==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448896B7772424C662E2EFD8F7C40MN2PR12MB4488namp_"

--_000_MN2PR12MB448896B7772424C662E2EFD8F7C40MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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


--_000_MN2PR12MB448896B7772424C662E2EFD8F7C40MN2PR12MB4488namp_
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
Can we drop the Kconfig?&nbsp; With that, the series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Bhawanpreet Lakha &lt=
;Bhawanpreet.Lakha@amd.com&gt;<br>
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
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
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
</body>
</html>

--_000_MN2PR12MB448896B7772424C662E2EFD8F7C40MN2PR12MB4488namp_--

--===============0298196209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0298196209==--
