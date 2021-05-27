Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99199C47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 15:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656AE6128D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 15:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656AE6128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 291FC6F403;
	Thu, 27 May 2021 15:06:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C92226F403
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 15:06:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtMeRCceBqRR+4zNl8ekTdEvas/bRVk3+fC+FjIczMjkVOW/J1X7Hvc014SZQmAc/tIHoyo7q8kBrNDlTKQV+ZFddzjf9id/SZ5NhfjfWbKmavtfwPmiST1a8QhfsrfwdgGYqkkcywVtKxhHefiZPoI+ZtG2Tuasd0xcyXxF+vmA2MEp5wTFJEYdOLYM3HUXl9PpJ31NfgtnZq2TOBO9xm/L0OJ1mk6zUiuWv2jJxUpEc9I1FYtFAGWgrxZ6P5BdbgPhV004huz26hF99VNGToctc/+q/gjwqGuHdrjbdBxUxYQOnqEh8Iw32+bGOtU0d4RuS1rmUsp4tIQjCMCvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qr4kCeXSve9J3ERR+DaS2SmyinNVXWX70yfc3Athxas=;
 b=jc27Y/KEuaJ/YpXX2c4gm9JagUuv0ijAxv67HzootgYT+yAqQr65ZDDryYG9Rr3USAbnlY2/DhaEBi5ZJ222VDRWonw6oYLQqFgISZXkD1xAqy8KKipyYepK6F37XkjYC6sFAsfx2hHjpccCKQQgENzbhfpyT6NKBjlj7VvH83VuYcN8rdgDBE/B27HnRdApbtbZj2G/af0z0l0lFGfqOMv3FmwFXLCdHEEAN54EwS10mps9CjLoTes2hlnucIjgy0wR/3H+u6g6Kr8Sf8tg5uOBIkcaWw0XD7j1xgQSqK4Yr9InV/RMDa8tfM+i04NiLWBPsqaqqWtc5WmeHT5OdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qr4kCeXSve9J3ERR+DaS2SmyinNVXWX70yfc3Athxas=;
 b=EdJ3+ecRyLVjtTLNJ5pXrjqFrxfg5GVyJmmDwPDad+Ll2+xkn5d0nVVQkLphjBaKnL8PgT0N92fLyZ0aMFlND7cwy+q+tCo1+guFFdfbCeCJqc/NFcAlKQVmwl/m0CMG4aZxys0AsTjc7IRm5Pd9Twllz/DBLo9VUCOZPZN1AWk=
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MW2PR12MB2361.namprd12.prod.outlook.com (2603:10b6:907:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 15:06:01 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::4458:fc8b:a960:6d44]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::4458:fc8b:a960:6d44%7]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 15:06:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>
Subject: Re: [PATCH 1/1] drm/amd/display: WARN_ON cleanups
Thread-Topic: [PATCH 1/1] drm/amd/display: WARN_ON cleanups
Thread-Index: AQHXUvHqRVqnUD+Xi0e4rquvdUy8xqr3PkWAgAAvW7Q=
Date: Thu, 27 May 2021 15:06:00 +0000
Message-ID: <MW3PR12MB44911349AED903B553B60434F7239@MW3PR12MB4491.namprd12.prod.outlook.com>
References: <20210527121448.33713-1-nirmoy.das@amd.com>,
 <DM4PR12MB51368EC14A729844AB36FAD08B239@DM4PR12MB5136.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51368EC14A729844AB36FAD08B239@DM4PR12MB5136.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-27T15:06:00.148Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c050fa00-12e2-4293-cced-08d92120f0a9
x-ms-traffictypediagnostic: MW2PR12MB2361:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB236118E5B05121428D9164FAF7239@MW2PR12MB2361.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:167;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9FIembcgVz5mSBjTUYwOAkGSAVGe+YutfFw3gZ94Sq3/nJ+Y4xKSyM6tWi39HnmOaSHzUYEuvwLGM5XfBuErqI7mqLoNOBC9/orKu/KkJ2xqNpgHsvotHxtPTLDIFynh+LdXFlKnYSBNh2IFLJJCrmA9beAR+UP31lQb70l5mAfobhyLqBaYtAI06GXHvciPOAGlxvwzpP4FoycmjBBz+/WeGzuZK87FV7zLurMqix0mJJCgIg7MYiUGhWmlChliOqLgW1dZ5pkHqFzID1GcGdTD0FEm3CnYFsmKdzzz4gO8tS/ccmxUqZEuIzriM/OciFbBMF1jQnqUJ4t81xRSnfB/XjeahdY8CzIcogOqfk6NWStKsakedML37s94+D2J0phGQK9xAJIAwpclf+ENMzO8MYuCcdCtdiTwVLws4vjmnwl5DXvaQiODnAlbGEtYK7SlM2JCfDVrE5uNs2q9tSgPdNkSty9cp4NfP8LGWsvbWTkAO1YneQHd3PsxWoCinIn7vHwOZFIG7BueV2QKMB7xnH4F8iorNqF0JsxtiyPZIs5cUIxHrw/+I5qUh3b97qjKwWh0Ks6701FHdijkZjbE8tHepp/uIGdLWdTlq6M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(8676002)(54906003)(8936002)(19627405001)(4326008)(110136005)(5660300002)(76116006)(7696005)(33656002)(91956017)(2906002)(83380400001)(26005)(52536014)(66946007)(9686003)(64756008)(66446008)(6506007)(122000001)(316002)(6636002)(55016002)(38100700002)(53546011)(66476007)(478600001)(86362001)(66556008)(186003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Yt533Z+Hy1oDZA6qJ6Gkj6bGA7mk7D7zRe0wyWrmstipbIzUaXsg4DoJZNKz?=
 =?us-ascii?Q?VgpU4dXXDH9TXdMnZNyBh/E4ZBKHaEPA0x6CAFAMHPAwVx/BIEJDS3n5PjSO?=
 =?us-ascii?Q?I45+TjMvd52ZDqRqTLQow67gZ3gt8FItRPXifVTVkAFKywvg1zNo9IjOddda?=
 =?us-ascii?Q?m7xaFumFBNsCuhuEpJzsaAHnaqzv3k5Jk4Bf73j6WOBk1buKfGPWL4wG9Ypn?=
 =?us-ascii?Q?9XglCLrMak3e7ASpxUVvDtlpIaJdkzKlJl+vlSUCIZR7xHL60pzYJjGn012D?=
 =?us-ascii?Q?hCLWG4g5jybJvf7TQrdNd473n/SoQJ16xw6+sloIlHVYZgn5GZPhnqtm+MmD?=
 =?us-ascii?Q?7iQ4jrZU7nFXtw9TTRyK6tQBN/vehXlNeAD5cl/qZQl94jz/D6l7Yr1cP392?=
 =?us-ascii?Q?I8I7cdbhvDjOGDLko3G8xt88MQe29JAbPQOVDZCSgAwn8Gin6hJejWiVSNWW?=
 =?us-ascii?Q?CLk4GoZM5AnjWVTs0CCIWMl0nW2R9qTktk6iWooib+xDIQhHx4Q0x+LcPnKj?=
 =?us-ascii?Q?XPujXErK64kHdIxnjYBQjsQ2OwBcsHgqN8BhVEpGnl0vMGbauhCYO0PCUY4s?=
 =?us-ascii?Q?9d+o2CJolBWoVbGpLke1gS7MmCeyPCaFZrwru8f3HP/Mvs30ZhaTz83uto7g?=
 =?us-ascii?Q?7RfsyKsshdMi/nFhgDxWhe5L7q86CfuFepBSMbFwXCQkcOBbC9Anm0DZa2kC?=
 =?us-ascii?Q?wIp+Lqge4Gvgsuyln2WzxLQah3X9PUzEeFwnTubTCKNtNqRDT4jWK0C9bl1o?=
 =?us-ascii?Q?LfxqhAEg61BP+IEb+NZJM7ilwaxGLoCajFrkWLwPlE/B+BN3Dp3ODhaJYv2y?=
 =?us-ascii?Q?6VZnVcGgLYMfaRDXNuH/9vS3RV8Ys58KtYYftjh1uYItZUMmelwcGAim7l5+?=
 =?us-ascii?Q?4Y5o+ZOeQrIO/snm6AEOobbWl4lNlmxQcubLQpRjS7XtSW2t3Pa9BSqJI/60?=
 =?us-ascii?Q?opuaNH2epKVXTuHSDTO+oPH2q1LhEqJYqxXRSdbvQBDSIWNLTyxYcG61xgFH?=
 =?us-ascii?Q?5D2QhqxgG6XoHYugwY9y/8xqf8ofbTuQz+KJakwnCGQU2MJjs9HC4ZgfSyBq?=
 =?us-ascii?Q?uI3VIrzLnv5m5wNrDK/Yu7bm3lDVIAxuaZTWpKfB8CQ33aR/GwK2PMIMrZJa?=
 =?us-ascii?Q?Dr+wqQwSFtCJ0e5ZMKYrDRfrnT8Jcx3L8cZIDCgqS4hwpEto7w44zRjgBFrD?=
 =?us-ascii?Q?7/T7zn1kpBZFgnCHsaH6cLLGCAw1uBbCd16mRJbO5MTdJ1fTYcYhhuU1DsgD?=
 =?us-ascii?Q?CoJtlRyOtobNiZq0arU26fxZjBFIALxYNsXGuPLe/HvL2SiJppbzsfyutp/K?=
 =?us-ascii?Q?wyCYElA/pRvxzcIRQXi62eGJ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c050fa00-12e2-4293-cced-08d92120f0a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 15:06:00.9039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1IC0lofIz6T78p285tANB8tFtO6S9NF0JSBgIoLXHvdJwuflO256PsX5Ugs8odB0dCw/HWixSfOuBDyT3dNNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2361
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0235884716=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0235884716==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB44911349AED903B553B60434F7239MW3PR12MB4491namp_"

--_000_MW3PR12MB44911349AED903B553B60434F7239MW3PR12MB4491namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Das, Nirmoy <Nirmoy.Das@amd.com>
Sent: Thursday, May 27, 2021 8:16 AM
To: Wentland, Harry <Harry.Wentland@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedes=
ktop.org>
Subject: RE: [PATCH 1/1] drm/amd/display: WARN_ON cleanups

[AMD Official Use Only]

s/Uuse/use

-----Original Message-----
From: Das, Nirmoy <Nirmoy.Das@amd.com>
Sent: Thursday, May 27, 2021 2:15 PM
To: Wentland, Harry <Harry.Wentland@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org; Das, Nirmoy <Nirmoy.D=
as@amd.com>
Subject: [PATCH 1/1] drm/amd/display: WARN_ON cleanups

Uuse WARN_ON() inside if-condition when possible.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f2ed51484980..736eb537a8e4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -315,8 +315,7 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,
         struct drm_crtc *crtc;
         struct amdgpu_crtc *amdgpu_crtc;

-       if (otg_inst =3D=3D -1) {
-               WARN_ON(1);
+       if (WARN_ON(otg_inst =3D=3D -1)) {
                 return adev->mode_info.crtcs[0];
         }

@@ -397,8 +396,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
         e =3D amdgpu_crtc->event;
         amdgpu_crtc->event =3D NULL;

-       if (!e)
-               WARN_ON(1);
+       WARN_ON(!e);

         vrr_active =3D amdgpu_dm_vrr_active_irq(amdgpu_crtc);

@@ -6698,9 +6696,8 @@ static int dm_crtc_helper_atomic_check(struct drm_crt=
c *crtc,

         dm_update_crtc_active_planes(crtc, crtc_state);

-       if (unlikely(!dm_crtc_state->stream &&
-                    modeset_required(crtc_state, NULL, dm_crtc_state->stre=
am))) {
-               WARN_ON(1);
+       if (WARN_ON(unlikely(!dm_crtc_state->stream &&
+                    modeset_required(crtc_state, NULL, dm_crtc_state->stre=
am)))) {
                 return ret;
         }

--
2.31.1

--_000_MW3PR12MB44911349AED903B553B60434F7239MW3PR12MB4491namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Das, Nirmoy &lt;Nirmo=
y.Das@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 27, 2021 8:16 AM<br>
<b>To:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt=
;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH 1/1] drm/amd/display: WARN_ON cleanups</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only]<br>
<br>
s/Uuse/use<br>
<br>
-----Original Message-----<br>
From: Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt; <br>
Sent: Thursday, May 27, 2021 2:15 PM<br>
To: Wentland, Harry &lt;Harry.Wentland@amd.com&gt;<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christian=
 &lt;Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.org; Das, Nirm=
oy &lt;Nirmoy.Das@amd.com&gt;<br>
Subject: [PATCH 1/1] drm/amd/display: WARN_ON cleanups<br>
<br>
Uuse WARN_ON() inside if-condition when possible.<br>
<br>
Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++-------<br=
>
&nbsp;1 file changed, 4 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index f2ed51484980..736eb537a8e4 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -315,8 +315,7 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu=
_crtc;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (otg_inst =3D=3D -1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_ON(1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON(otg_inst =3D=3D -1)) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return adev-&gt;mode_info.crtcs[0];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -397,8 +396,7 @@ static void dm_pflip_high_irq(void *interrupt_params)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e =3D amdgpu_crtc-&gt;even=
t;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;event =3D =
NULL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!e)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_ON(1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(!e);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vrr_active =3D amdgpu_dm_v=
rr_active_irq(amdgpu_crtc);<br>
&nbsp;<br>
@@ -6698,9 +6696,8 @@ static int dm_crtc_helper_atomic_check(struct drm_crt=
c *crtc,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_update_crtc_active_plan=
es(crtc, crtc_state);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(!dm_crtc_state-&gt;strea=
m &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; modeset_required(crtc_state, NULL,=
 dm_crtc_state-&gt;stream))) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_ON(1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON(unlikely(!dm_crtc_state-&=
gt;stream &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; modeset_required(crtc_state, NULL,=
 dm_crtc_state-&gt;stream)))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.31.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB44911349AED903B553B60434F7239MW3PR12MB4491namp_--

--===============0235884716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0235884716==--
