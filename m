Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEDDC433EB
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 16:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5312065F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 16:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dDC4GKVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5312065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504C26E508;
	Mon, 13 Jul 2020 16:30:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692A06E508
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 16:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTmIZRaWENHUaBpC2xNCLiN5pqUCaohkYb0ztCirZBXLhFbnrtRrtL3jOPRViaB+hhuhR3wQQFrXEJOYqK9FrU8I7aqsWGDLytkFoG1+wpmCNwjKNsHzZIz1pFnSt+Yv/9p9bgluVR58IgnTVPFnDfz+PJVXAGZ1Tc7BurU8pmHRoeS+cycSDJL958deGYX3o6zehlpVrQbOYIakGNc0fw+XuQIO859gQPW/smnjl5KkNUuhVWmZvyjDyq7Y8eTasRMVS6+IPt1XgI5hIiwA7qn/LnKR0BQ4nMqa/afmCS4rZ/n7mOtIZNTjoYy6DKzntZ3b3QEsGVLjGsL2jXpT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRtBj7yiNwEUScziJHIuZG7c73ZQmy9aDSMVO9K5haY=;
 b=FfUpxOy/vuhwXSNFv7JDuV6Hi1y4aZr0jqtvccgsaCovRvngkL7ae9S2oq3HmO/tMkwj+9cFyPoU80ekUXzb0C+CIVi0Wk1KmX206B8MSQDdnV1zS23F9LAOa8GudOLvfsZgEaLsUundqXgrF4pM8l21RnoxSrF9Mi6JCJmxRqngDVLJcMmm5pC7YfsOIg9jYxjN+IQsgugPSQaoTvgUJXCe8MvaeFqMnauIxUMfnsRaGsuk2/9Lk5T8sH7df6iBqB62kht3fMYq7kV7H0de5yvVlGSmxIzI1zUQiDjxQBMQ5Lb9OU9cgxKcC+5KcdjXV+4QI0eNNOMlpius3G61XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRtBj7yiNwEUScziJHIuZG7c73ZQmy9aDSMVO9K5haY=;
 b=dDC4GKVDOaxtGLgZdKlDYHDI8L1LkFDNsldJJYFZLDLaYQzg6ggC5EkbyuBdoF7LP8cNq0fOa+4Xut3oyowBCfspakUh0qvLr+fjDnwEAwnVnBFZkwZkJUUS67OUSkruP2xXBGNLHdhV/8swwRPfkYAx6yspDg44Vz5VUNvObew=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR12MB1760.namprd12.prod.outlook.com (2603:10b6:300:112::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 16:30:49 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::f54a:55ae:1157:742]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::f54a:55ae:1157:742%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 16:30:49 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/display: Allow for vblank enabled with no
 active planes
Thread-Topic: [PATCH 2/2] drm/amd/display: Allow for vblank enabled with no
 active planes
Thread-Index: AQHWWSvPQR9pk1PSAEaT4iE6ZdYbyKkFsxhm
Date: Mon, 13 Jul 2020 16:30:49 +0000
Message-ID: <MW3PR12MB45546EFA0E61D396729AB02AF9600@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20200713153908.14815-1-nicholas.kazlauskas@amd.com>,
 <20200713153908.14815-2-nicholas.kazlauskas@amd.com>
In-Reply-To: <20200713153908.14815-2-nicholas.kazlauskas@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-13T16:30:49.834Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55988267-9c6c-4843-f4fd-08d8274a1a54
x-ms-traffictypediagnostic: MWHPR12MB1760:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1760F37DBACF1E4A66C7D389F9600@MWHPR12MB1760.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c63DCkDkHv3upjikpy3AF6jigEgM93oK67Act+t5CaDBl9V67Bi+osg6PCNxxHrDdgqmvKXohbL8bXeTo2g5VeRydHLsuBilXHtqvXdfzA9VHOd7nSl2JMGK9UPaZ1JBFWXGy6pf3KTpj3ZJRTqQ/ZoVzHFwese3OGcnxL+Tmwv6vgmPjbW/rBIyJILSyVc5aVRMNfCG43a+B5xAdF60k+R/etOYvSsgXzImv/ceDl6SG6Xa4dWsRu7T3eOydgHyGpWEpgX0HmCUvfx22HjdZTRdq5XUGcrKV9YBHNbqGS3zRe5PnZ8E2HgG2DcOoWtwN47BKgpA5Fc5fTddrJcCrA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(2906002)(316002)(186003)(83380400001)(26005)(76116006)(91956017)(66946007)(66446008)(64756008)(66556008)(66476007)(86362001)(9686003)(55016002)(5660300002)(478600001)(52536014)(8676002)(30864003)(19627405001)(7696005)(71200400001)(33656002)(110136005)(8936002)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: GFZsrxKDuzP1rJrvpmkOLsahfxtq2qvhCAZenDWgQHM4etKxR2Mr3IztXO8OUr5WMo8rOUg8YwfT9OkyH5iFzy3aj+7aEXICQjNEbpCuHOi+2e6uBqCeMR57hUlGqZbybYkUtme1Ip9P3csNunEYKwwhGjM5NibAVGkwBDXULIwX7VMIWZIDdLw9/GMXj7Q/ExgATGZhmAZLnJW7LSKsglraIYilH9zS3Ku76K2Q9nVoH8yMriyxuFdZUvwziybn2ZftQdzs18Eu03qF85T23CLORgJ0rIzg5RBzo0CUwZ305sQntOU1h9nogu6DNCUNbngJz8gRzQ0qv3KD8I4sUDpNUfGeJCDRoXR9npEm5okIs6ZepecGI/p1z5/kWHrxNdhB0JiJn0YSEUvG70yxOUIw8HG0ZDoXOtls2pNxQ8z7nU/lAAcBUYJ1+Agv6WgYqI4U4JQ/vPnEqcsRcHgtZ2SvR+FMrn2y2Jz3nv55mtJbeso5iVnZYQekoH55jwVp
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55988267-9c6c-4843-f4fd-08d8274a1a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 16:30:49.4409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekCzMF9ZnIeyeZKs5kJNsgpag3hoVQxBJWrWdw9gq0ztxf4/xXavtoY71HyMcKQ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1760
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
Content-Type: multipart/mixed; boundary="===============1550740414=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1550740414==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB45546EFA0E61D396729AB02AF9600MW3PR12MB4554namp_"

--_000_MW3PR12MB45546EFA0E61D396729AB02AF9600MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
________________________________
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Sent: July 13, 2020 11:39 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Lakha, Bhawanpreet =
<Bhawanpreet.Lakha@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Allow for vblank enabled with no acti=
ve planes

[Why]
CRC capture doesn't work when the active plane count is 0 since we
currently tie both vblank and pageflip interrupts to active_plane_count
greater than 0.

[How]
The frontend is what generates the vblank interrupts while the backend
is what generates pageflip interrupts. Both have a requirement for
the CRTC to be active, so control the overall interrupt state based
on that instead.

Pageflip interrupts need to be enabled based on active plane count, but
we actually rely on power gating to take care of disabling the interrupt
for us on pipes that can be power gated.

For pipes that can't be power gated it's still fine to leave it enabled
since the interrupt only triggers after the address has been written
to that particular pipe - which we won't be doing without an active
plane.

The issue we had before with this setup was that we couldn't force
the state back on. We were essentially manipulating the refcount
to enable or disable as needed in a two pass approach.

However, there is a function that solves this problem more elegantly:
amdgpu_irq_update() will unconditionally call the set based on what it
thinks the current enablement state is.

This leaves two future TODO items for our IRQ handling:
- Disabling IRQs in commit tail instead of atomic commit
- Mapping the pageflip interrupt to VUPDATE or something that's tied to
  the frontend instead of the backend since the mapping to CRTC is not
  correct

Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 168 ++++++++----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 -
 2 files changed, 78 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d9f8e9c26390..05160c6bbc03 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4719,7 +4719,6 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
         }

         state->active_planes =3D cur->active_planes;
-       state->interrupts_enabled =3D cur->interrupts_enabled;
         state->vrr_params =3D cur->vrr_params;
         state->vrr_infopacket =3D cur->vrr_infopacket;
         state->abm_level =3D cur->abm_level;
@@ -5393,29 +5392,19 @@ static int count_crtc_active_planes(struct drm_crtc=
_state *new_crtc_state)
         return num_active;
 }

-/*
- * Sets whether interrupts should be enabled on a specific CRTC.
- * We require that the stream be enabled and that there exist active
- * DC planes on the stream.
- */
-static void
-dm_update_crtc_interrupt_state(struct drm_crtc *crtc,
-                              struct drm_crtc_state *new_crtc_state)
+static void dm_update_crtc_active_planes(struct drm_crtc *crtc,
+                                        struct drm_crtc_state *new_crtc_st=
ate)
 {
         struct dm_crtc_state *dm_new_crtc_state =3D
                 to_dm_crtc_state(new_crtc_state);

         dm_new_crtc_state->active_planes =3D 0;
-       dm_new_crtc_state->interrupts_enabled =3D false;

         if (!dm_new_crtc_state->stream)
                 return;

         dm_new_crtc_state->active_planes =3D
                 count_crtc_active_planes(new_crtc_state);
-
-       dm_new_crtc_state->interrupts_enabled =3D
-               dm_new_crtc_state->active_planes > 0;
 }

 static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
@@ -5426,13 +5415,7 @@ static int dm_crtc_helper_atomic_check(struct drm_cr=
tc *crtc,
         struct dm_crtc_state *dm_crtc_state =3D to_dm_crtc_state(state);
         int ret =3D -EINVAL;

-       /*
-        * Update interrupt state for the CRTC. This needs to happen whenev=
er
-        * the CRTC has changed or whenever any of its planes have changed.
-        * Atomic check satisfies both of these requirements since the CRTC
-        * is added to the state by DRM during drm_atomic_helper_check_plan=
es.
-        */
-       dm_update_crtc_interrupt_state(crtc, state);
+       dm_update_crtc_active_planes(crtc, state);

         if (unlikely(!dm_crtc_state->stream &&
                      modeset_required(state, NULL, dm_crtc_state->stream))=
) {
@@ -6547,8 +6530,10 @@ static void manage_dm_interrupts(struct amdgpu_devic=
e *adev,
                                  bool enable)
 {
         /*
-        * this is not correct translation but will work as soon as VBLANK
-        * constant is the same as PFLIP
+        * We have no guarantee that the frontend index maps to the same
+        * backend index - some even map to more than one.
+        *
+        * TODO: Use a different interrupt or check DC itself for the mappi=
ng.
          */
         int irq_type =3D
                 amdgpu_display_crtc_idx_to_irq_type(
@@ -6571,6 +6556,19 @@ static void manage_dm_interrupts(struct amdgpu_devic=
e *adev,
         }
 }

+static void dm_update_pflip_irq_state(struct amdgpu_device *adev,
+                                     struct amdgpu_crtc *acrtc)
+{
+       int irq_type =3D
+               amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
+
+       /**
+        * This reads the current state for the IRQ and force reapplies
+        * the setting to hardware.
+        */
+       amdgpu_irq_update(adev, &adev->pageflip_irq, irq_type);
+}
+
 static bool
 is_scaling_state_different(const struct dm_connector_state *dm_state,
                            const struct dm_connector_state *old_dm_state)
@@ -7154,7 +7152,16 @@ static void amdgpu_dm_commit_planes(struct drm_atomi=
c_state *state,
                         usleep_range(1000, 1100);
                 }

-               if (acrtc_attach->base.state->event) {
+               /**
+                * Prepare the flip event for the pageflip interrupt to han=
dle.
+                *
+                * This only works in the case where we've already turned o=
n the
+                * appropriate hardware blocks (eg. HUBP) so in the transit=
ion case
+                * from 0 -> n planes we have to skip a hardware generated =
event
+                * and rely on sending it from software.
+                */
+               if (acrtc_attach->base.state->event &&
+                   acrtc_state->active_planes > 0) {
                         drm_crtc_vblank_get(pcrtc);

                         spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
@@ -7223,6 +7230,24 @@ static void amdgpu_dm_commit_planes(struct drm_atomi=
c_state *state,
                                                      &bundle->stream_updat=
e,
                                                      dc_state);

+               /**
+                * Enable or disable the interrupts on the backend.
+                *
+                * Most pipes are put into power gating when unused.
+                *
+                * When power gating is enabled on a pipe we lose the
+                * interrupt enablement state when power gating is disabled=
.
+                *
+                * So we need to update the IRQ control state in hardware
+                * whenever the pipe turns on (since it could be previously
+                * power gated) or off (since some pipes can't be power gat=
ed
+                * on some ASICs).
+                */
+               if (dm_old_crtc_state->active_planes !=3D acrtc_state->acti=
ve_planes)
+                       dm_update_pflip_irq_state(
+                               (struct amdgpu_device *)dev->dev_private,
+                               acrtc_attach);
+
                 if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
                                 acrtc_state->stream->link->psr_settings.ps=
r_version !=3D DC_PSR_VERSION_UNSUPPORTED &&
                                 !acrtc_state->stream->link->psr_settings.p=
sr_feature_enabled)
@@ -7323,64 +7348,6 @@ static void amdgpu_dm_commit_audio(struct drm_device=
 *dev,
         }
 }

-/*
- * Enable interrupts on CRTCs that are newly active, undergone
- * a modeset, or have active planes again.
- *
- * Done in two passes, based on the for_modeset flag:
- * Pass 1: For CRTCs going through modeset
- * Pass 2: For CRTCs going from 0 to n active planes
- *
- * Interrupts can only be enabled after the planes are programmed,
- * so this requires a two-pass approach since we don't want to
- * just defer the interrupts until after commit planes every time.
- */
-static void amdgpu_dm_enable_crtc_interrupts(struct drm_device *dev,
-                                            struct drm_atomic_state *state=
,
-                                            bool for_modeset)
-{
-       struct amdgpu_device *adev =3D dev->dev_private;
-       struct drm_crtc *crtc;
-       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-       int i;
-#ifdef CONFIG_DEBUG_FS
-       enum amdgpu_dm_pipe_crc_source source;
-#endif
-
-       for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
-                                     new_crtc_state, i) {
-               struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);
-               struct dm_crtc_state *dm_new_crtc_state =3D
-                       to_dm_crtc_state(new_crtc_state);
-               struct dm_crtc_state *dm_old_crtc_state =3D
-                       to_dm_crtc_state(old_crtc_state);
-               bool modeset =3D drm_atomic_crtc_needs_modeset(new_crtc_sta=
te);
-               bool run_pass;
-
-               run_pass =3D (for_modeset && modeset) ||
-                          (!for_modeset && !modeset &&
-                           !dm_old_crtc_state->interrupts_enabled);
-
-               if (!run_pass)
-                       continue;
-
-               if (!dm_new_crtc_state->interrupts_enabled)
-                       continue;
-
-               manage_dm_interrupts(adev, acrtc, true);
-
-#ifdef CONFIG_DEBUG_FS
-               /* The stream has changed so CRC capture needs to re-enable=
d. */
-               source =3D dm_new_crtc_state->crc_src;
-               if (amdgpu_dm_is_valid_crc_source(source)) {
-                       amdgpu_dm_crtc_configure_crc_source(
-                               crtc, dm_new_crtc_state,
-                               dm_new_crtc_state->crc_src);
-               }
-#endif
-       }
-}
-
 /*
  * amdgpu_dm_crtc_copy_transient_flags - copy mirrored flags from DRM to D=
C
  * @crtc_state: the DRM CRTC state
@@ -7420,12 +7387,10 @@ static int amdgpu_dm_atomic_commit(struct drm_devic=
e *dev,
          * in atomic check.
          */
         for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crt=
c_state, i) {
-               struct dm_crtc_state *dm_old_crtc_state =3D to_dm_crtc_stat=
e(old_crtc_state);
-               struct dm_crtc_state *dm_new_crtc_state =3D to_dm_crtc_stat=
e(new_crtc_state);
                 struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);

-               if (dm_old_crtc_state->interrupts_enabled &&
-                   (!dm_new_crtc_state->interrupts_enabled ||
+               if (old_crtc_state->active &&
+                   (!new_crtc_state->active ||
                      drm_atomic_crtc_needs_modeset(new_crtc_state)))
                         manage_dm_interrupts(adev, acrtc, false);
         }
@@ -7704,8 +7669,34 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_=
atomic_state *state)
                                                 dm_new_crtc_state);
         }

-       /* Enable interrupts for CRTCs going through a modeset. */
-       amdgpu_dm_enable_crtc_interrupts(dev, state, true);
+       /**
+        * Enable interrupts for CRTCs that are newly enabled or went throu=
gh
+        * a modeset. It was intentionally deferred until after the front e=
nd
+        * state was modified to wait until the OTG was on and so the IRQ
+        * handlers didn't access stale or invalid state.
+        */
+       for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc=
_state, i) {
+               struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);
+
+               if (new_crtc_state->active &&
+                   (!old_crtc_state->active ||
+                    drm_atomic_crtc_needs_modeset(new_crtc_state))) {
+                       manage_dm_interrupts(adev, acrtc, true);
+#ifdef CONFIG_DEBUG_FS
+                       /**
+                        * Frontend may have changed so reapply the CRC cap=
ture
+                        * settings for the stream.
+                        */
+                       dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_sta=
te);
+
+                       if (amdgpu_dm_is_valid_crc_source(dm_new_crtc_state=
->crc_src)) {
+                               amdgpu_dm_crtc_configure_crc_source(
+                                       crtc, dm_new_crtc_state,
+                                       dm_new_crtc_state->crc_src);
+                       }
+#endif
+               }
+       }

         for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
                 if (new_crtc_state->async_flip)
@@ -7720,9 +7711,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_a=
tomic_state *state)
                                                 dm, crtc, wait_for_vblank)=
;
         }

-       /* Enable interrupts for CRTCs going from 0 to n active planes. */
-       amdgpu_dm_enable_crtc_interrupts(dev, state, false);
-
         /* Update audio instances for each connector. */
         amdgpu_dm_commit_audio(dev, state);

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 94d3ff727c25..82cdf07b4bd0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -414,7 +414,6 @@ struct dm_crtc_state {

         int update_type;
         int active_planes;
-       bool interrupts_enabled;

         int crc_skip_count;
         enum amdgpu_dm_pipe_crc_source crc_src;
--
2.25.1


--_000_MW3PR12MB45546EFA0E61D396729AB02AF9600MW3PR12MB4554namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: <font size=3D"2"><span style=3D"font-size:11pt">Bhawanpreet La=
kha &lt;Bhawanpreet.Lakha@amd.com&gt;</span></font><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicholas Kazlauskas &=
lt;nicholas.kazlauskas@amd.com&gt;<br>
<b>Sent:</b> July 13, 2020 11:39 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Lakha,=
 Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/display: Allow for vblank enabled with =
no active planes</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
CRC capture doesn't work when the active plane count is 0 since we<br>
currently tie both vblank and pageflip interrupts to active_plane_count<br>
greater than 0.<br>
<br>
[How]<br>
The frontend is what generates the vblank interrupts while the backend<br>
is what generates pageflip interrupts. Both have a requirement for<br>
the CRTC to be active, so control the overall interrupt state based<br>
on that instead.<br>
<br>
Pageflip interrupts need to be enabled based on active plane count, but<br>
we actually rely on power gating to take care of disabling the interrupt<br=
>
for us on pipes that can be power gated.<br>
<br>
For pipes that can't be power gated it's still fine to leave it enabled<br>
since the interrupt only triggers after the address has been written<br>
to that particular pipe - which we won't be doing without an active<br>
plane.<br>
<br>
The issue we had before with this setup was that we couldn't force<br>
the state back on. We were essentially manipulating the refcount<br>
to enable or disable as needed in a two pass approach.<br>
<br>
However, there is a function that solves this problem more elegantly:<br>
amdgpu_irq_update() will unconditionally call the set based on what it<br>
thinks the current enablement state is.<br>
<br>
This leaves two future TODO items for our IRQ handling:<br>
- Disabling IRQs in commit tail instead of atomic commit<br>
- Mapping the pageflip interrupt to VUPDATE or something that's tied to<br>
&nbsp; the frontend instead of the backend since the mapping to CRTC is not=
<br>
&nbsp; correct<br>
<br>
Cc: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
Signed-off-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 168 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;----------<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |&nbsp;&nbsp; 1 -<br>
&nbsp;2 files changed, 78 insertions(&#43;), 91 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index d9f8e9c26390..05160c6bbc03 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -4719,7 &#43;4719,6 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;active_planes =
=3D cur-&gt;active_planes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;interrupts_enabled =3D cur-=
&gt;interrupts_enabled;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;vrr_params =3D c=
ur-&gt;vrr_params;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;vrr_infopacket =
=3D cur-&gt;vrr_infopacket;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&gt;abm_level =3D cu=
r-&gt;abm_level;<br>
@@ -5393,29 &#43;5392,19 @@ static int count_crtc_active_planes(struct drm_=
crtc_state *new_crtc_state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return num_active;<br>
&nbsp;}<br>
&nbsp;<br>
-/*<br>
- * Sets whether interrupts should be enabled on a specific CRTC.<br>
- * We require that the stream be enabled and that there exist active<br>
- * DC planes on the stream.<br>
- */<br>
-static void<br>
-dm_update_crtc_interrupt_state(struct drm_crtc *crtc,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc_state *new_crtc_state)<br>
&#43;static void dm_update_crtc_active_planes(struct drm_crtc *crtc,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct drm_crtc_state *new_crtc_state)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_crtc_state *dm_n=
ew_crtc_state =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; to_dm_crtc_state(new_crtc_state);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_new_crtc_state-&gt;acti=
ve_planes =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_new_crtc_state-&gt;interrupts_enab=
led =3D false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dm_new_crtc_state-&gt=
;stream)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_new_crtc_state-&gt;acti=
ve_planes =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; count_crtc_active_planes(new_crtc_state);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_new_crtc_state-&gt;interrupts_enab=
led =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dm_new_crtc_state-&gt;active_planes &gt; 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,<br>
@@ -5426,13 &#43;5415,7 @@ static int dm_crtc_helper_atomic_check(struct dr=
m_crtc *crtc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_crtc_state *dm_c=
rtc_state =3D to_dm_crtc_state(state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Update interrupt state for th=
e CRTC. This needs to happen whenever<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the CRTC has changed or whene=
ver any of its planes have changed.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Atomic check satisfies both o=
f these requirements since the CRTC<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is added to the state by DRM =
during drm_atomic_helper_check_planes.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_update_crtc_interrupt_state(crtc, =
state);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_update_crtc_active_planes(crtc=
, state);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(!dm_crtc_stat=
e-&gt;stream &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; modeset_required(state,=
 NULL, dm_crtc_state-&gt;stream))) {<br>
@@ -6547,8 &#43;6530,10 @@ static void manage_dm_interrupts(struct amdgpu_d=
evice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * this is not correct translati=
on but will work as soon as VBLANK<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * constant is the same as PFLIP=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * We have no guarantee that=
 the frontend index maps to the same<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * backend index - some even=
 map to more than one.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: Use a different int=
errupt or check DC itself for the mapping.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int irq_type =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_display_crtc_idx_to_irq_type(<br>
@@ -6571,6 &#43;6556,19 @@ static void manage_dm_interrupts(struct amdgpu_d=
evice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void dm_update_pflip_irq_state(struct amdgpu_device *adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_crtc *acrtc)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int irq_type =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_display_crtc_idx_to_irq_type(adev, acrtc-&gt;crtc_id)=
;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This reads the current st=
ate for the IRQ and force reapplies<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the setting to hardware.<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_update(adev, &amp;adev=
-&gt;pageflip_irq, irq_type);<br>
&#43;}<br>
&#43;<br>
&nbsp;static bool<br>
&nbsp;is_scaling_state_different(const struct dm_connector_state *dm_state,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; const struct dm_connector_state *old_dm_state)<br>
@@ -7154,7 &#43;7152,16 @@ static void amdgpu_dm_commit_planes(struct drm_a=
tomic_state *state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uslee=
p_range(1000, 1100);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (acrtc_attach-&gt;base.state-&gt;event) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /**<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * Prepare the flip event for the pageflip interrupt to=
 handle.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * This only works in the case where we've already turn=
ed on the<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * appropriate hardware blocks (eg. HUBP) so in the tra=
nsition case<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * from 0 -&gt; n planes we have to skip a hardware gen=
erated event<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * and rely on sending it from software.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (acrtc_attach-&gt;base.state-&gt;event &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acrtc_state-&gt;active_planes &gt; 0=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_c=
rtc_vblank_get(pcrtc);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_=
lock_irqsave(&amp;pcrtc-&gt;dev-&gt;event_lock, flags);<br>
@@ -7223,6 &#43;7230,24 @@ static void amdgpu_dm_commit_planes(struct drm_a=
tomic_state *state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &amp;bundle-&gt;stream_update,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; dc_state);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /**<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * Enable or disable the interrupts on the backend.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * Most pipes are put into power gating when unused.<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * When power gating is enabled on a pipe we lose the<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * interrupt enablement state when power gating is disa=
bled.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * So we need to update the IRQ control state in hardwa=
re<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * whenever the pipe turns on (since it could be previo=
usly<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * power gated) or off (since some pipes can't be power=
 gated<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * on some ASICs).<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (dm_old_crtc_state-&gt;active_planes !=3D acrtc_state-&gt=
;active_planes)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_update_pf=
lip_irq_state(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct amdgpu_device *)dev-&gt;dev_pri=
vate,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acrtc_attach);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((acrtc_state-&gt;update_type &gt; UPDATE_TYPE_FAS=
T) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acrtc_state-&gt;stream-&gt;link-=
&gt;psr_settings.psr_version !=3D DC_PSR_VERSION_UNSUPPORTED &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !acrtc_state-&gt;stream-&gt;link=
-&gt;psr_settings.psr_feature_enabled)<br>
@@ -7323,64 &#43;7348,6 @@ static void amdgpu_dm_commit_audio(struct drm_de=
vice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-/*<br>
- * Enable interrupts on CRTCs that are newly active, undergone<br>
- * a modeset, or have active planes again.<br>
- *<br>
- * Done in two passes, based on the for_modeset flag:<br>
- * Pass 1: For CRTCs going through modeset<br>
- * Pass 2: For CRTCs going from 0 to n active planes<br>
- *<br>
- * Interrupts can only be enabled after the planes are programmed,<br>
- * so this requires a two-pass approach since we don't want to<br>
- * just defer the interrupts until after commit planes every time.<br>
- */<br>
-static void amdgpu_dm_enable_crtc_interrupts(struct drm_device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_atomic_state *state,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool for_modeset)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev-&g=
t;dev_private;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc_state *old_crtc_state=
, *new_crtc_state;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-#ifdef CONFIG_DEBUG_FS<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_dm_pipe_crc_source source=
;<br>
-#endif<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_oldnew_crtc_in_state(state, =
crtc, old_crtc_state,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_crt=
c_state, i) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct dm_crtc_state *dm_new_crtc_state =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to_dm_crtc_state=
(new_crtc_state);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct dm_crtc_state *dm_old_crtc_state =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to_dm_crtc_state=
(old_crtc_state);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bool modeset =3D drm_atomic_crtc_needs_modeset(new_crtc_state);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bool run_pass;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; run_pass =3D (for_modeset &amp;&amp; modeset) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (!for_modeset &amp;&amp; !modeset &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; !dm_old_crtc_state-&gt;interrupts_enabled);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!run_pass)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!dm_new_crtc_state-&gt;interrupts_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; manage_dm_interrupts(adev, acrtc, true);<br>
-<br>
-#ifdef CONFIG_DEBUG_FS<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* The stream has changed so CRC capture needs to re-enabled. */=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; source =3D dm_new_crtc_state-&gt;crc_src;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_dm_is_valid_crc_source(source)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_crtc_c=
onfigure_crc_source(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crtc, dm_new_crtc_state,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_new_crtc_state-&gt;crc_src);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-#endif<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-}<br>
-<br>
&nbsp;/*<br>
&nbsp; * amdgpu_dm_crtc_copy_transient_flags - copy mirrored flags from DRM=
 to DC<br>
&nbsp; * @crtc_state: the DRM CRTC state<br>
@@ -7420,12 &#43;7387,10 @@ static int amdgpu_dm_atomic_commit(struct drm_d=
evice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in atomic check.<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_oldnew_crtc_in_st=
ate(state, crtc, old_crtc_state, new_crtc_state, i) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct dm_crtc_state *dm_old_crtc_state =3D to_dm_crtc_state(old=
_crtc_state);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct dm_crtc_state *dm_new_crtc_state =3D to_dm_crtc_state(new=
_crtc_state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);<b=
r>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dm_old_crtc_state-&gt;interrupts_enabled &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!dm_new_crtc_state-&gt;interrupts_enabl=
ed ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (old_crtc_state-&gt;active &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!new_crtc_state-&gt;active ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_atomic_crtc_needs_m=
odeset(new_crtc_state)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; manag=
e_dm_interrupts(adev, acrtc, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -7704,8 &#43;7669,34 @@ static void amdgpu_dm_atomic_commit_tail(struct =
drm_atomic_state *state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_new_crtc=
_state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable interrupts for CRTCs going =
through a modeset. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_enable_crtc_interrupts(dev,=
 state, true);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Enable interrupts for CRT=
Cs that are newly enabled or went through<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * a modeset. It was intenti=
onally deferred until after the front end<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * state was modified to wai=
t until the OTG was on and so the IRQ<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * handlers didn't access st=
ale or invalid state.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_oldnew_crtc_in_state(sta=
te, crtc, old_crtc_state, new_crtc_state, i) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (new_crtc_state-&gt;active &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!old_crtc_state-&gt;active ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_atomic_crtc_needs_modeset(=
new_crtc_state))) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; manage_dm_in=
terrupts(adev, acrtc, true);<br>
&#43;#ifdef CONFIG_DEBUG_FS<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Fron=
tend may have changed so reapply the CRC capture<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * sett=
ings for the stream.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_new_crtc_=
state =3D to_dm_crtc_state(new_crtc_state);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_d=
m_is_valid_crc_source(dm_new_crtc_state-&gt;crc_src)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_crtc_configure_crc_source(<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; crtc, dm_new_crtc_state,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; dm_new_crtc_state-&gt;crc_src);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;#endif<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_new_crtc_in_state=
(state, crtc, new_crtc_state, j)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (new_crtc_state-&gt;async_flip)<br>
@@ -7720,9 &#43;7711,6 @@ static void amdgpu_dm_atomic_commit_tail(struct d=
rm_atomic_state *state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm, crtc, w=
ait_for_vblank);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable interrupts for CRTCs going =
from 0 to n active planes. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_enable_crtc_interrupts(dev,=
 state, false);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update audio instances =
for each connector. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_commit_audio(dev=
, state);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
index 94d3ff727c25..82cdf07b4bd0 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
@@ -414,7 &#43;414,6 @@ struct dm_crtc_state {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int update_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int active_planes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool interrupts_enabled;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int crc_skip_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_dm_pipe_crc_so=
urce crc_src;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB45546EFA0E61D396729AB02AF9600MW3PR12MB4554namp_--

--===============1550740414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1550740414==--
