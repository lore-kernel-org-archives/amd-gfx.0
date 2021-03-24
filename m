Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782DDC433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 02:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3337561580
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 02:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3337561580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02DF6E296;
	Wed, 24 Mar 2021 02:34:17 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760048.outbound.protection.outlook.com [40.107.76.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38AA66E296
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 02:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsAxact3cTcRDSe77uW9DqRlAkj3zwhFMqNcx88LE4wC5IhBt2KI2gHDZNC/AlZs6x2x8r5kSeoStBI1nxeJT+DF8JHTufhFzek28IY3FsgFql0oIJqf5jJP5SMQjVXJHsRLCX6LuPpkJfEal0sC3A8On8nCJCKKmLPwn5l4ueQRSb1vgtSyQU4k/ubTjB80kTG6G73+a80jECqZImyYkJjohF5R3A38tiKf6XpUpmPc1I8PO3slDXtZ7+fltY39ftJDG9hQTvQ08PcB60C4+EBCDhI+K1jTAaquJildN7UcKKECc0mWBqZKWev3o5p6qNEfXMZinQmVPQF0hozVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc5eIuLnugwDdwTN3DcACBFyqUgtw5KWXElGeRartcc=;
 b=ANwZ9/Fli/84MyTrIq8CbPn3uGuI2WI8bV54RiwSO5LLV6l0PQkvnR7rV2TBeeXN3qDMvh28LWN/KAqV8BalOGPce3EnXTqlkWAH9ovv1MojGgW36GxZ31OBK7Fs10dEPNsYs6sz38JfvEAl5dBFOYd6FEJLwNnlx1gMphp2jXL+HqMkspai6IZYGkZuPgx+fKnxG9wJ51xECliod9rsH2OjSePaxCnY1QnUztimJlaE+VYYD1z3T8wVxnrHPWgwOeQyrqSsEjGGG1FXZMXb5BAVBC68o7hLvV+7DIvFZ7Qugc9RVB2PgFrLBZBM6cftuEguOPqkgjOgfRUrOptPbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc5eIuLnugwDdwTN3DcACBFyqUgtw5KWXElGeRartcc=;
 b=apriHIUUYLXn5giPKOhZg+k1z2U9lNBZIIvbZ6TK2eTNtgtSOGpcJxsnnXdzSOqEDn8ujYES1J/wMs9HxFGJ/1VnJAkThTJilfEo0G3fa3xFIPsqmIByGVet+s2Cp7Y4cX0eMt46+dH7KbuINRHDmMcmJvr02wbJIyOUUciTCHI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 02:34:14 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%6]) with mapi id 15.20.3955.025; Wed, 24 Mar 2021
 02:34:14 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Use DRM_DEBUG_DP
Thread-Topic: [PATCH] drm/amd/display: Use DRM_DEBUG_DP
Thread-Index: AQHXH3vr9l1Gy4Pl7EW7EYXyuosSQ6qRofCAgAAavACAAEnmAIAAZr8A
Date: Wed, 24 Mar 2021 02:34:13 +0000
Message-ID: <MN2PR12MB44887387D0FE8FF1AE6C41D1F7639@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <9042072e-107a-eec8-2357-962698d91d0e@amd.com>,
 <20210323202614.20061-1-luben.tuikov@amd.com>
In-Reply-To: <20210323202614.20061-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-24T02:34:13.377Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 748e3c8e-dbdf-4c89-544e-08d8ee6d506c
x-ms-traffictypediagnostic: BL0PR12MB4865:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4865F7F098C9F0016E96497DF7639@BL0PR12MB4865.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:142;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GS/VsRYUltyZZ7mBHMFVV4wCVyrBn6q/Bk4XS/LENBnhVbuTKohd/fCxR+1Q4QLhTtfhphQU988+Sd3KUb+GbfyYughI1mSxB4cqmVqGLAn5WW2HOy/4XlJMTV7EdXKwi2Mo8zHb7O8ZxjkvlF4Xg8kGoeSyejVEIANdd69lKU9aDl2+RK7TRWtxIPvRJ0vWX5H2KlgBaMpWR24DmvcxX7lEoBd1LhWyABM4jZmMGYrNaX+SrXogkN+ghak+yhYw6G75CD3CMWDfmjDXSr6aK4TCdSv0aGSz/ATRr6TB21MSbgLoU1H+xMlJWG4vLYQOl5FYYnBrHR4OuinSCCj+C7KF7CXxqmOIUvytJQoQbWga/K/rryuG4KL/AhBBtiAuZwjHiQxj8pBcaF9NYt22Exlfbmhab2FwtgVkfp14WnszVKIx3TFbP+VEqiPEub3pGYPbTihswgsG9oyVtXzoY2Al8qI91/oxtjBe6UP9upbrKnkXV1vd+2QIRBE0kAxjbyAR9lWhoOrzaQRCokSSiICfAYphaX2rZo/ENaJIAXXrSa5jm21M7kBLtK9YzEf3ixuX9XRqNjxnoQxdTyJvW1jQzYpN8q82bqM8YN6LyBToTPioWdAcWgbcjkv4h6TLGOyd7mNLxq43bjmjC8UVewUWXNHSu7r9xXoWhhSV2gQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(5660300002)(66476007)(66946007)(64756008)(110136005)(76116006)(66556008)(71200400001)(478600001)(19627405001)(4326008)(8936002)(26005)(8676002)(33656002)(66446008)(2906002)(55016002)(9686003)(38100700001)(6506007)(86362001)(52536014)(7696005)(83380400001)(316002)(186003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5maCS8N8OCrVHpzYHZhNw+KU3eHI0d04tdzu9lx1JcNr5WpkznXkGRciHR4E?=
 =?us-ascii?Q?7BJd0xibC6XcEzJi/BiRw3AKINNlgtW82BXm86HG8uiF6EWLehc1JWLvw7jE?=
 =?us-ascii?Q?o7U5Vy798j+RR/rxvAFZQwP/Vy5SZSI+zktYOJqHQ1jH6YAALhFf9YPUMqGw?=
 =?us-ascii?Q?Qlrj+axBkD7H0Nz2PuuzwX2vHc9uXBEJfx6g0bW3n+bpYw/04NDfxiuww6im?=
 =?us-ascii?Q?MpxB90O5HTmhl5+44jXHWoU/WSK7kq+jPge1ciq/6cSEFqfaNyey5PE+ODv4?=
 =?us-ascii?Q?wXa3+8SfZuis42a8q9xC9OS0U9eTn+zwxYchCApLj4Yzl9coLWRZ7yFKYcdN?=
 =?us-ascii?Q?p//RtcTNQXDdoMQ79Ajhg1NjnmXdbaKUDR6Gw++s/JHg/ynf8bAM3XsScHko?=
 =?us-ascii?Q?IG3toOVBA8cq8Cqa9HDyWsmUUKR53NJluPNyWEQcf6KRfeSGoeU0QQiL9MCT?=
 =?us-ascii?Q?nbrX6pwFnHw1wQOXSgl9kgL8AbA4yAKrP7qSeN1YN7+Wpq8y9oHXPXZr30Ro?=
 =?us-ascii?Q?EIMsXO3s4Bal47YQ0C+PS2vDMjW5I05OGcBoY7Pr3Em6WBxR55QeP7Z/YWRZ?=
 =?us-ascii?Q?KbkuIONgnYe02O8TqNNA31JYkGaw/Gv5H+tUvAE4JxZUtAQeSCXddT3an/Md?=
 =?us-ascii?Q?X51wmpwSAaaZCBjWffd0VVBRz0seyfSIk9RO2fQiSx1Vjl/3kRiueImNV80F?=
 =?us-ascii?Q?M7aQrijhh10QmCAZor1+EwTKxZkQ/b35wtFHN/8vua6w2NJeb7YSqwotDdnW?=
 =?us-ascii?Q?MZJ6sZKOntNJYKFhoCIuxGmjgz5pGLrdm+21czEAGCWnttLywM1nIZyUhu/0?=
 =?us-ascii?Q?LpCZirfY3PqLxyZSCFTFjYi6fZmFaGpKVBej1Vc42HRJKB++hHJ457mc5Q9D?=
 =?us-ascii?Q?GeQN9WliazSEzIKoy878wb1ISPAak3ITUg2JLO4iKRiwVGJoNtUXZ2OLkCnM?=
 =?us-ascii?Q?LBMae40IWw93SegUZNeTBP78zSzUnobxEYV39hceSThzLYI8Ng+S+r/R2GXa?=
 =?us-ascii?Q?ij3JNTJOhzh/2RqOC5JtwGe+E7N4BF4mR1g72DW/4vY7U3HaTOjczl9k4jS5?=
 =?us-ascii?Q?hpHxyATNt4hyAa7k5AAv8Tacwb2ltZmz8Boe0BR6iTlQF6unw6OWxGsPQibj?=
 =?us-ascii?Q?Uhan0mrJfzgR8WmYyhLST5ys3s26VmOq3whJfAYC8H9T27WvYDGmaMHZB3Ug?=
 =?us-ascii?Q?SqMF1q2gsSh+hizHaPfYxQNI0H9f7KD0suAOKM5lIVHES/yorBN1IST5sreg?=
 =?us-ascii?Q?6MMJIvc8JGFMGP9UxvwQGRMTWR0bprGBBBn27uW8X7jDYpO63ItJFwvq8UOG?=
 =?us-ascii?Q?ZURjjFh9tc7HR0W/zG1C3cGk?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748e3c8e-dbdf-4c89-544e-08d8ee6d506c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 02:34:13.9644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OleZGQuwZ0esewd+V3537eDdGihP4ZasssUfbqWw/bpJ4hRGUUNyKHO13XDsWqd4ZuGW5yMug/HZQoZzndNBZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>
Content-Type: multipart/mixed; boundary="===============1902193913=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1902193913==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44887387D0FE8FF1AE6C41D1F7639MN2PR12MB4488namp_"

--_000_MN2PR12MB44887387D0FE8FF1AE6C41D1F7639MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Tuesday, March 23, 2021 4:26 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Wentland, Harry <Harry.Wentland@a=
md.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/display: Use DRM_DEBUG_DP

Convert IRQ-based prints from DRM_DEBUG_DRIVER to
DRM_DEBUG_DP, as the latter is not used in drm/amd
prior to this patch and since IRQ-based prints
drown out the rest of the driver's
DRM_DEBUG_DRIVER messages.

Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 57 +++++++++----------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f455fc3aa561..9376d44ce3b4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -449,9 +449,9 @@ static void dm_pflip_high_irq(void *interrupt_params)
         amdgpu_crtc->pflip_status =3D AMDGPU_FLIP_NONE;
         spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);

-       DRM_DEBUG_DRIVER("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]=
-fp %d\n",
-                        amdgpu_crtc->crtc_id, amdgpu_crtc,
-                        vrr_active, (int) !e);
+       DRM_DEBUG_KMS("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp=
 %d\n",
+                     amdgpu_crtc->crtc_id, amdgpu_crtc,
+                     vrr_active, (int) !e);
 }

 static void dm_vupdate_high_irq(void *interrupt_params)
@@ -993,8 +993,7 @@ static void event_mall_stutter(struct work_struct *work=
)
         dc_allow_idle_optimizations(
                 dm->dc, dm->active_vblank_irq_count =3D=3D 0);

-       DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->activ=
e_vblank_irq_count =3D=3D 0);
-
+       DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_v=
blank_irq_count =3D=3D 0);

         mutex_unlock(&dm->dc_lock);
 }
@@ -1810,8 +1809,8 @@ static void dm_gpureset_toggle_interrupts(struct amdg=
pu_device *adev,
                 if (acrtc && state->stream_status[i].plane_count !=3D 0) {
                         irq_source =3D IRQ_TYPE_PFLIP + acrtc->otg_inst;
                         rc =3D dc_interrupt_set(adev->dm.dc, irq_source, e=
nable) ? 0 : -EBUSY;
-                       DRM_DEBUG("crtc %d - vupdate irq %sabling: r=3D%d\n=
",
-                                 acrtc->crtc_id, enable ? "en" : "dis", rc=
);
+                       DRM_DEBUG_VBL("crtc %d - vupdate irq %sabling: r=3D=
%d\n",
+                                     acrtc->crtc_id, enable ? "en" : "dis"=
, rc);
                         if (rc)
                                 DRM_WARN("Failed to %s pflip interrupts\n"=
,
                                          enable ? "enable" : "disable");
@@ -4966,8 +4965,8 @@ static void update_stream_scaling_settings(const stru=
ct drm_display_mode *mode,
         stream->src =3D src;
         stream->dst =3D dst;

-       DRM_DEBUG_DRIVER("Destination Rectangle x:%d  y:%d  width:%d  heigh=
t:%d\n",
-                       dst.x, dst.y, dst.width, dst.height);
+       DRM_DEBUG_KMS("Destination Rectangle x:%d  y:%d  width:%d  height:%=
d\n",
+                     dst.x, dst.y, dst.width, dst.height);

 }

@@ -5710,8 +5709,8 @@ static inline int dm_set_vupdate_irq(struct drm_crtc =
*crtc, bool enable)

         rc =3D dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EB=
USY;

-       DRM_DEBUG_DRIVER("crtc %d - vupdate irq %sabling: r=3D%d\n",
-                        acrtc->crtc_id, enable ? "en" : "dis", rc);
+       DRM_DEBUG_VBL("crtc %d - vupdate irq %sabling: r=3D%d\n",
+                     acrtc->crtc_id, enable ? "en" : "dis", rc);
         return rc;
 }

@@ -6664,7 +6663,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plan=
e *plane,
         int r;

         if (!new_state->fb) {
-               DRM_DEBUG_DRIVER("No FB bound\n");
+               DRM_DEBUG_KMS("No FB bound\n");
                 return 0;
         }

@@ -7896,11 +7895,11 @@ static void handle_cursor_update(struct drm_plane *=
plane,
         if (!plane->state->fb && !old_plane_state->fb)
                 return;

-       DRM_DEBUG_DRIVER("%s: crtc_id=3D%d with size %d to %d\n",
-                        __func__,
-                        amdgpu_crtc->crtc_id,
-                        plane->state->crtc_w,
-                        plane->state->crtc_h);
+       DRM_DEBUG_KMS("%s: crtc_id=3D%d with size %d to %d\n",
+                     __func__,
+                     amdgpu_crtc->crtc_id,
+                     plane->state->crtc_w,
+                     plane->state->crtc_h);

         ret =3D get_cursor_position(plane, crtc, &position);
         if (ret)
@@ -7958,8 +7957,8 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrt=
c)
         /* Mark this event as consumed */
         acrtc->base.state->event =3D NULL;

-       DRM_DEBUG_DRIVER("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
-                                                acrtc->crtc_id);
+       DRM_DEBUG_KMS("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
+                     acrtc->crtc_id);
 }

 static void update_freesync_state_on_stream(
@@ -8265,7 +8264,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic=
_state *state,
                         &bundle->flip_addrs[planes_count].address,
                         afb->tmz_surface, false);

-               DRM_DEBUG_DRIVER("plane: id=3D%d dcc_en=3D%d\n",
+               DRM_DEBUG_ATOMIC("plane: id=3D%d dcc_en=3D%d\n",
                                  new_plane_state->plane->index,
                                  bundle->plane_infos[planes_count].dcc.ena=
ble);

@@ -8299,7 +8298,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic=
_state *state,
                                 dc_plane,
                                 bundle->flip_addrs[planes_count].flip_time=
stamp_in_us);

-               DRM_DEBUG_DRIVER("%s Flipping to hi: 0x%x, low: 0x%x\n",
+               DRM_DEBUG_ATOMIC("%s Flipping to hi: 0x%x, low: 0x%x\n",
                                  __func__,
                                  bundle->flip_addrs[planes_count].address.=
grph.addr.high_part,
                                  bundle->flip_addrs[planes_count].address.=
grph.addr.low_part);
@@ -8621,7 +8620,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_a=
tomic_state *state)
                 dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state);
                 dm_old_crtc_state =3D to_dm_crtc_state(old_crtc_state);

-               DRM_DEBUG_DRIVER(
+               DRM_DEBUG_ATOMIC(
                         "amdgpu_crtc id:%d crtc_state_flags: enable:%d, ac=
tive:%d, "
                         "planes_changed:%d, mode_changed:%d,active_changed=
:%d,"
                         "connectors_changed:%d\n",
@@ -8655,7 +8654,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_a=
tomic_state *state)

                 if (modeset_required(new_crtc_state, dm_new_crtc_state->st=
ream, dm_old_crtc_state->stream)) {

-                       DRM_DEBUG_DRIVER("Atomic commit: SET crtc id %d: [%=
p]\n", acrtc->crtc_id, acrtc);
+                       DRM_DEBUG_ATOMIC("Atomic commit: SET crtc id %d: [%=
p]\n", acrtc->crtc_id, acrtc);

                         if (!dm_new_crtc_state->stream) {
                                 /*
@@ -8688,7 +8687,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_a=
tomic_state *state)
                         crtc->hwmode =3D new_crtc_state->mode;
                         mode_set_reset_required =3D true;
                 } else if (modereset_required(new_crtc_state)) {
-                       DRM_DEBUG_DRIVER("Atomic commit: RESET. crtc id %d:=
[%p]\n", acrtc->crtc_id, acrtc);
+                       DRM_DEBUG_ATOMIC("Atomic commit: RESET. crtc id %d:=
[%p]\n", acrtc->crtc_id, acrtc);
                         /* i.e. reset mode */
                         if (dm_old_crtc_state->stream)
                                 remove_stream(adev, acrtc, dm_old_crtc_sta=
te->stream);
@@ -9298,7 +9297,7 @@ static int dm_update_crtc_state(struct amdgpu_display=
_manager *dm,
         if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
                 goto skip_modeset;

-       DRM_DEBUG_DRIVER(
+       DRM_DEBUG_ATOMIC(
                 "amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d,=
 "
                 "planes_changed:%d, mode_changed:%d,active_changed:%d,"
                 "connectors_changed:%d\n",
@@ -9382,8 +9381,8 @@ static int dm_update_crtc_state(struct amdgpu_display=
_manager *dm,

                         dc_stream_retain(new_stream);

-                       DRM_DEBUG_DRIVER("Enabling DRM crtc: %d\n",
-                                               crtc->base.id);
+                       DRM_DEBUG_ATOMIC("Enabling DRM crtc: %d\n",
+                                        crtc->base.id);

                         if (dc_add_stream_to_ctx(
                                         dm->dc,
@@ -9728,8 +9727,8 @@ static int dm_update_plane_state(struct dc *dc,
                 if (!dc_new_plane_state)
                         return -ENOMEM;

-               DRM_DEBUG_DRIVER("Enabling DRM plane: %d on DRM crtc %d\n",
-                               plane->base.id, new_plane_crtc->base.id);
+               DRM_DEBUG_ATOMIC("Enabling DRM plane: %d on DRM crtc %d\n",
+                                plane->base.id, new_plane_crtc->base.id);

                 ret =3D fill_dc_plane_attributes(
                         drm_to_adev(new_plane_crtc->dev),
--
2.31.0.rc2


--_000_MN2PR12MB44887387D0FE8FF1AE6C41D1F7639MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 23, 2021 4:26 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Wentland, Harry &lt;=
Harry.Wentland@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.co=
m&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Use DRM_DEBUG_DP</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Convert IRQ-based prints from DRM_DEBUG_DRIVER to<=
br>
DRM_DEBUG_DP, as the latter is not used in drm/amd<br>
prior to this patch and since IRQ-based prints<br>
drown out the rest of the driver's<br>
DRM_DEBUG_DRIVER messages.<br>
<br>
Cc: Harry Wentland &lt;Harry.Wentland@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 57 +++++++++---------=
-<br>
&nbsp;1 file changed, 28 insertions(+), 29 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index f455fc3aa561..9376d44ce3b4 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -449,9 +449,9 @@ static void dm_pflip_high_irq(void *interrupt_params)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;pflip_stat=
us =3D AMDGPU_FLIP_NONE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&am=
p;adev_to_drm(adev)-&gt;event_lock, flags);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;crtc:%d[%p], p=
flip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crt=
c-&gt;crtc_id, amdgpu_crtc,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vrr_active=
, (int) !e);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_KMS(&quot;crtc:%d[%p], pfli=
p_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;crtc_id, amd=
gpu_crtc,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vrr_active, (int) !e);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void dm_vupdate_high_irq(void *interrupt_params)<br>
@@ -993,8 +993,7 @@ static void event_mall_stutter(struct work_struct *work=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_allow_idle_optimization=
s(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dm-&gt;dc, dm-&gt;active_vblank_irq_count =3D=3D 0);<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;Allow idle opt=
imizations (MALL): %d\n&quot;, dm-&gt;active_vblank_irq_count =3D=3D 0);<br=
>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_KMS(&quot;Allow idle optimi=
zations (MALL): %d\n&quot;, dm-&gt;active_vblank_irq_count =3D=3D 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;dm-&gt;d=
c_lock);<br>
&nbsp;}<br>
@@ -1810,8 +1809,8 @@ static void dm_gpureset_toggle_interrupts(struct amdg=
pu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (acrtc &amp;&amp; state-&gt;stream_status[i].plane=
_count !=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq_s=
ource =3D IRQ_TYPE_PFLIP + acrtc-&gt;otg_inst;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc =
=3D dc_interrupt_set(adev-&gt;dm.dc, irq_source, enable) ? 0 : -EBUSY;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;=
crtc %d - vupdate irq %sabling: r=3D%d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acrtc-&gt;crtc_id, enable ? &qu=
ot;en&quot; : &quot;dis&quot;, rc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_VBL(&q=
uot;crtc %d - vupdate irq %sabling: r=3D%d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acrtc-&=
gt;crtc_id, enable ? &quot;en&quot; : &quot;dis&quot;, rc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r=
c)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_WARN(&quot;Failed to %s pfli=
p interrupts\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enable ? &quot;enable&quot; : &quot;disable&quot;);<b=
r>
@@ -4966,8 +4965,8 @@ static void update_stream_scaling_settings(const stru=
ct drm_display_mode *mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream-&gt;src =3D src;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream-&gt;dst =3D dst;<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;Destination Re=
ctangle x:%d&nbsp; y:%d&nbsp; width:%d&nbsp; height:%d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst.x, dst.y, ds=
t.width, dst.height);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_KMS(&quot;Destination Recta=
ngle x:%d&nbsp; y:%d&nbsp; width:%d&nbsp; height:%d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst.x, dst.y, dst.width, dst=
.height);<br>
&nbsp;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -5710,8 +5709,8 @@ static inline int dm_set_vupdate_irq(struct drm_crtc =
*crtc, bool enable)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc =3D dc_interrupt_set(ad=
ev-&gt;dm.dc, irq_source, enable) ? 0 : -EBUSY;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;crtc %d - vupd=
ate irq %sabling: r=3D%d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acrtc-&gt;=
crtc_id, enable ? &quot;en&quot; : &quot;dis&quot;, rc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_VBL(&quot;crtc %d - vupdate=
 irq %sabling: r=3D%d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acrtc-&gt;crtc_id, enable ? =
&quot;en&quot; : &quot;dis&quot;, rc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return rc;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -6664,7 +6663,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plan=
e *plane,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!new_state-&gt;fb) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG_DRIVER(&quot;No FB bound\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG_KMS(&quot;No FB bound\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -7896,11 +7895,11 @@ static void handle_cursor_update(struct drm_plane *=
plane,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!plane-&gt;state-&gt;f=
b &amp;&amp; !old_plane_state-&gt;fb)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;%s: crtc_id=3D=
%d with size %d to %d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crt=
c-&gt;crtc_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane-&gt;=
state-&gt;crtc_w,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane-&gt;=
state-&gt;crtc_h);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_KMS(&quot;%s: crtc_id=3D%d =
with size %d to %d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;crtc_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane-&gt;state-&gt;crtc_w,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane-&gt;state-&gt;crtc_h);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D get_cursor_positio=
n(plane, crtc, &amp;position);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -7958,8 +7957,8 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrt=
c)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Mark this event as cons=
umed */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acrtc-&gt;base.state-&gt;e=
vent =3D NULL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;crtc:%d, pflip=
_stat:AMDGPU_FLIP_SUBMITTED\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acrtc-&gt;crtc_i=
d);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_KMS(&quot;crtc:%d, pflip_st=
at:AMDGPU_FLIP_SUBMITTED\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acrtc-&gt;crtc_id);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void update_freesync_state_on_stream(<br>
@@ -8265,7 +8264,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic=
_state *state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
bundle-&gt;flip_addrs[planes_count].address,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; afb-&=
gt;tmz_surface, false);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG_DRIVER(&quot;plane: id=3D%d dcc_en=3D%d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG_ATOMIC(&quot;plane: id=3D%d dcc_en=3D%d\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_plane_state-&gt;plane-=
&gt;index,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bundle-&gt;plane_infos[pla=
nes_count].dcc.enable);<br>
&nbsp;<br>
@@ -8299,7 +8298,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic=
_state *state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_plane,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bundle-&gt;flip_addrs[planes_cou=
nt].flip_timestamp_in_us);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG_DRIVER(&quot;%s Flipping to hi: 0x%x, low: 0x%x\n&quot=
;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG_ATOMIC(&quot;%s Flipping to hi: 0x%x, low: 0x%x\n&quot=
;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bundle-&gt;flip_addrs[plan=
es_count].address.grph.addr.high_part,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bundle-&gt;flip_addrs[plan=
es_count].address.grph.addr.low_part);<br>
@@ -8621,7 +8620,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_a=
tomic_state *state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dm_old_crtc_state =3D to_dm_crtc_state(old_crtc_state=
);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG_DRIVER(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG_ATOMIC(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, &quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;planes_changed:%d, mode_changed:%d,active_changed:%d,&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;connectors_changed:%d\n&quot;,<br>
@@ -8655,7 +8654,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_a=
tomic_state *state)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (modeset_required(new_crtc_state, dm_new_crtc_stat=
e-&gt;stream, dm_old_crtc_state-&gt;stream)) {<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER=
(&quot;Atomic commit: SET crtc id %d: [%p]\n&quot;, acrtc-&gt;crtc_id, acrt=
c);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_ATOMIC=
(&quot;Atomic commit: SET crtc id %d: [%p]\n&quot;, acrtc-&gt;crtc_id, acrt=
c);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!=
dm_new_crtc_state-&gt;stream) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
@@ -8688,7 +8687,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_a=
tomic_state *state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crtc-=
&gt;hwmode =3D new_crtc_state-&gt;mode;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode_=
set_reset_required =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else if (modereset_required(new_crtc_state)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER=
(&quot;Atomic commit: RESET. crtc id %d:[%p]\n&quot;, acrtc-&gt;crtc_id, ac=
rtc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_ATOMIC=
(&quot;Atomic commit: RESET. crtc id %d:[%p]\n&quot;, acrtc-&gt;crtc_id, ac=
rtc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* i.=
e. reset mode */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (d=
m_old_crtc_state-&gt;stream)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remove_stream(adev, acrtc, dm_ol=
d_crtc_state-&gt;stream);<br>
@@ -9298,7 +9297,7 @@ static int dm_update_crtc_state(struct amdgpu_display=
_manager *dm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!drm_atomic_crtc_needs=
_modeset(new_crtc_state))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto skip_modeset;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_ATOMIC(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_crtc id:%d crtc_state_flags: enable:%d, =
active:%d, &quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;planes_changed:%d, mode_changed:%d,active_chang=
ed:%d,&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;connectors_changed:%d\n&quot;,<br>
@@ -9382,8 +9381,8 @@ static int dm_update_crtc_state(struct amdgpu_display=
_manager *dm,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_st=
ream_retain(new_stream);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER=
(&quot;Enabling DRM crtc: %d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crtc-&gt;base.id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_ATOMIC=
(&quot;Enabling DRM crtc: %d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; crtc-&gt;base.id);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (d=
c_add_stream_to_ctx(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dm-&gt;dc,<br>
@@ -9728,8 +9727,8 @@ static int dm_update_plane_state(struct dc *dc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!dc_new_plane_state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENOMEM;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG_DRIVER(&quot;Enabling DRM plane: %d on DRM crtc %d\n&q=
uot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane-&gt;base.id, new_plane_crtc-&gt;base.=
id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG_ATOMIC(&quot;Enabling DRM plane: %d on DRM crtc %d\n&q=
uot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane-&gt;base.id, new_plane_crtc-&gt=
;base.id);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D fill_dc_plane_attributes(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_t=
o_adev(new_plane_crtc-&gt;dev),<br>
-- <br>
2.31.0.rc2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44887387D0FE8FF1AE6C41D1F7639MN2PR12MB4488namp_--

--===============1902193913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1902193913==--
