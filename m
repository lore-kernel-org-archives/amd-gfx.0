Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12783C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 07:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7A11123C7;
	Wed, 13 Apr 2022 07:30:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF6BA1123C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 07:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEc1S4qXMuKD3MEt+8MOaxJ6ArxKyKhJ/8X1vV7MEM56CBfhbyjeRhLPZ34OuFW8IK3uE7q/te0wgLn5Wkk64fjJ+qMM37wSX9JNsPeI799t46v5udjczq+CGe1xl425ZEY9f6g146YmQcPc2nX4lYhGV1Cq6RFNjrF0vMOrFvaK15EHVkWLN80gpTnHLwK2JkZUwiNOw8ZCpjLV8RvhnUL8KWd+v1C496tnwFPO5z5S7d28kOYoUaELNIYG+/9MZEXSLMyI0InnCyFr6kXkL/JFpZMQdEz9Ul0RAbFMbkDhzeIz280JoQETJrKKUByN6SIo80sVaKZ/42/XYqK6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbrS1FfH74cDCPMam2jHMIBNEX9CgjB6OIvcU2xksV0=;
 b=EgsJrFpfZojPswjB3DscdqtpF0itlqEKmZm248+WB73mXFWgUKfxRT4uIxnXGIku5fSrK3mQ8Rwo6z3+i7NwLFbnT+fqX1TkfCAWG57TA6UpdMYtRdpDjhZi0TH2dTBD8ossKDYo8dwF7dQ5ZKBqnurrv/zs/6zP//D6lm20kxrYGe04O+AP/lZzP6eBFdE8x2KeIgwOdP7JsbQKi9jowyMgY01iRnaR3kkFjfvPuyUxrg5xp5jI1KzbZLnIk+53IVyA41qO9sRwihxuy/AfI9VMc+wSadhYAxOjI4S6G3UqJ2A/GOI7lflaGNtZR/ndiWpMeNq3aq5UO6FTjkkBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbrS1FfH74cDCPMam2jHMIBNEX9CgjB6OIvcU2xksV0=;
 b=UfND1/P7te/g6Q+UJ1HcChvtG20MV7QPLNbL/hyKAMchLo64DoWxNX47fwc4i68kbWiPGZOJv6f9eTo0ycXtxz7dOvAY+D3CxjNsbQlFiRPKEPw4UsIYF0aMM1FABrYPXzL6qKTFi+CzHOWvPDSRPX7HSNPzP4T73qDKZ0+BqTE=
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 07:30:52 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8%5]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 07:30:52 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: AW: [PATCH] drm/amdgpu: Make sure ttm delayed work finished
Thread-Topic: [PATCH] drm/amdgpu: Make sure ttm delayed work finished
Thread-Index: AQHYTuPZbmsZ0b1UjEWbi/YG74XfhKztcky5
Date: Wed, 13 Apr 2022 07:30:52 +0000
Message-ID: <BN8PR12MB3587639A4BC2C1B392DD2DFE83EC9@BN8PR12MB3587.namprd12.prod.outlook.com>
References: <20220413030854.31724-1-xinhui.pan@amd.com>
In-Reply-To: <20220413030854.31724-1-xinhui.pan@amd.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52c5d0f4-cf38-44c8-cbd9-08da1d1f89eb
x-ms-traffictypediagnostic: MN2PR12MB4078:EE_
x-microsoft-antispam-prvs: <MN2PR12MB40786AA0A38803BC09349A1A83EC9@MN2PR12MB4078.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNB+qyZ3qNOA0wvSVwRERPan5IjDe6bVC+uv7FtoLlUHNVBea5mqVAhrgl4w6jgqK3jiRi1APANIrm15mgNvsvnO+WYKqM4xRVo6nN7KrxCVpxxvygEUUPNavniSArdMj9fdfeBqHkVEQ3pXp/fs4CELx/p1fFs+XF+j46Kf2Ok2zrcJCdH1ENtfUGqCQtjqNlcndz1wUWODKFvWAvdyhWKOG8FkI/jEl4QqlCV1m3/NI/47dMWMzj47qoUkuUjSi4167ohLubM7EGEmeGnav5Fsm38BXFT1iBMm7FNN8P5AF5HBw2z/wXPQ4sqSzyoM1F7JmGVzk7L5ZZX5AnDNoNadrxbZkh51LkYAK0NCnNpCgtxNKFiYUERs/j7iGsGRt6GrdZmqMd0YrM+GdK31pMqvbB2hLw0yGj8gso7v+hkPovR1Du6jW9rih7T/YO2f2khd3CXNLvR/6McK1+srgtBvA6rVdpCtFhFbyHrUcXEkt1mz6Df7QFLvNAYMGuqyNZbEKQ7ndwYMtV+FjTcm99Qil4vcjBQ/uooqgQNOuEG+Ob3lJGlq/urMI1JeJw2RwL8mtgY9yEXEv8wLjjKuZQA6/jp0bKl6e3zQLckczL8TonLy3OCjl2FyQRUM5nWC0sDZ8aRJTruFHgGzwpNBVT/vmTXEa1Jojrfms0/xOaJYNVSMQJQuMms7Hm2JQ4lE/qqG0I4ehJgRyUkTAxaO4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(5660300002)(38070700005)(186003)(8936002)(76116006)(2906002)(316002)(110136005)(7696005)(6506007)(83380400001)(38100700002)(91956017)(122000001)(33656002)(52536014)(86362001)(66556008)(66476007)(66446008)(64756008)(8676002)(71200400001)(55016003)(508600001)(4326008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r1L6twjMIV4i+1Sa6vrt7T5glmLGifHtVlTfWOn7gN64pN6qqVM6ByAwOPYA?=
 =?us-ascii?Q?lE0THZLFX1kgyDEU4kVP1CFHxiNLnT/TCEL6LbXCeasS0nenFfYsEnqk+RBq?=
 =?us-ascii?Q?d9UxWcZekCJ73fONeXoHEkaTciodxZD60mFDA0pmZEZD1Zdclg8EZUof6+ZB?=
 =?us-ascii?Q?+hE3o1w0VWWlf+rEP//JiAipZJMlthdVtN2QuV2rEKBM+gIN41jlpr1o8fxy?=
 =?us-ascii?Q?QWCjVl6f/V4YxqzCLDz/LVItYydQ5OXQdhPL/4zYnno4GTi0KZTyXij3O0D6?=
 =?us-ascii?Q?o+oHE1BkAY2y2jvETghJEAMgylZ68waMtLWeRUH0Ab9lGHZC6sjLXXHlKPXF?=
 =?us-ascii?Q?zJs4a/l5LXGnAZanWNfTat+I0N5nMX2JPVuzz0eDsnDwH6OfM+mnzU6Djn5P?=
 =?us-ascii?Q?aNY8JT4QcqXYBx9zfxkfGxGUHc0a51PLHfwrF1T73njVJVsQwnhIu+I2iqYM?=
 =?us-ascii?Q?lw/jjz0hLV4GS0muSuHn1yri0nKhlwR/TNyoI9V+mv/lvAyI+e1dZ63B/iBJ?=
 =?us-ascii?Q?CfljAxWv1KEvDc3sLSZa8o5YyQAD8eT33uP7ZkLVy8LLtcXn6LsFtzCOvj7m?=
 =?us-ascii?Q?o+hIW0A8DJpDhuNSavrNTbEDnQ0hST7N2c73C+3rOxQuseJzleV67gb5i1jc?=
 =?us-ascii?Q?fCeO5Kdp/2LiypGV+XHtaeH06PDZNtO/y2hplMK6hxIhB5bM6BMQK+KydrGo?=
 =?us-ascii?Q?dv4dvSPaf1Y74/1oQhXFEfdnZFyucyKMDSThBZBIBftjBUmsjPGd6XaL+JDv?=
 =?us-ascii?Q?Qd6GUpYG7TVjkrLoINUx7pxsjsb4HjiD/o/4vOwN2NX5Z2dPkGZLkoX5HaOp?=
 =?us-ascii?Q?GG34lrKGCJStKQb5lhhu5HPQsjOBsqtVTz3nR+T/ZKpcTGkCnXKXwjbvNq0r?=
 =?us-ascii?Q?PAA8amr5H2t/pa0sM85ym8r5c2HcUS7Tf2wYRGFX44mmG2nHqdLlMg08LMzG?=
 =?us-ascii?Q?/lNlTNYTKbcnuJN3ys0vFuuHionfaApwprBAihHEU1k/BNl/VdWDllEoVZcq?=
 =?us-ascii?Q?2qUhy6QbdlgPXO9WVWnyfpH6OTa7qnXrDmVIlODn+VhsbRKxOF0d+CLLl+4Q?=
 =?us-ascii?Q?3h5N7+PXajiow0wL84GHSICfz5dknLvlXaSNPhYEcsiwkQjp4RjN8LcxU+RC?=
 =?us-ascii?Q?tHUHKnUvOZg/GyL0ArZkgdsRmL7MHeGt0Eq2dFo26skaW50XqSHCqdTQC5cb?=
 =?us-ascii?Q?sfrX04ZuwXo9NZ5a4t0CFa5TIQY4T49Av+/v+4rY1AiFG9IjkbA+9Xins14N?=
 =?us-ascii?Q?LB/beFmQZE0xS+HgG6c0mP9e7DKHDur87HBr1SZWSqe86x3OEEKNr+gtPz88?=
 =?us-ascii?Q?hkpqxW8wUGQ6+dJCc+rGTPdb7mO/v31KfrFq+NMLEUuhlNIotcRnSEzpnrZ7?=
 =?us-ascii?Q?2dh+JEqSOZpIrOybSEfYMPPua/x2MVOE9D7sB8UPXeZ4nS4h1Ftt/27fwKbe?=
 =?us-ascii?Q?jZuqY7GTAX2VTo2hd4AY5WDSbkMpsgmW8nSqdfTIhvtIvfTPEoZYOeUPOFbo?=
 =?us-ascii?Q?z/GvTgA3Dy4dJuWJmDZZYED0+TMtvWXGW1GZ/UksdilNZOGMFopuW25FpX7d?=
 =?us-ascii?Q?3opU2in7wVfyiC8QOkF54IquX2NGlZXb0em2D43C+3VovcCsbepZE+Dfgy9B?=
 =?us-ascii?Q?EcurMlOjePsM2cv3f/QFWSG9Amu86cSc2CrDSz4rGdF7jK8kc3u7/Cwr8LDX?=
 =?us-ascii?Q?YtpFVXD9Kz2z2ZPJPDQtOf98iiGn0q2v2NFyt9Fu4p6AB0KHgWGhug2yKMC7?=
 =?us-ascii?Q?rGy8wl8P3kY1n0exBsfIRvx0SZBwAvgJoysWnlfJ6rA/AZtiXMll?=
Content-Type: multipart/alternative;
 boundary="_000_BN8PR12MB3587639A4BC2C1B392DD2DFE83EC9BN8PR12MB3587namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c5d0f4-cf38-44c8-cbd9-08da1d1f89eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 07:30:52.0844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0A2/vM/K0cudajEH1UJ2kkV6xatsbOU8/TdbHYO2tCLLph/fXQYJA1yXOM4v+vqB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
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

--_000_BN8PR12MB3587639A4BC2C1B392DD2DFE83EC9BN8PR12MB3587namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We don't need that.

TTM only reschedules when the BOs are still busy.

And if the BOs are still busy when you unload the driver we have much bigge=
r problems that this TTM worker :)

Regards,
Christian

________________________________
Von: Pan, Xinhui <Xinhui.Pan@amd.com>
Gesendet: Mittwoch, 13. April 2022 05:08
An: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
Betreff: [PATCH] drm/amdgpu: Make sure ttm delayed work finished

ttm_device_delayed_workqueue would reschedule itself if there is pending
BO to be destroyed. So just one flush + cancel_sync is not enough. We
still see lru_list not empty warnging.

Fix it by waiting all BO to be destroyed.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 6f47726f1765..e249923eb9a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3957,11 +3957,17 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_=
device *adev)
  */
 void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 {
+       int pending =3D 1;
+
         dev_info(adev->dev, "amdgpu: finishing device.\n");
         flush_delayed_work(&adev->delayed_init_work);
-       if (adev->mman.initialized) {
+       while (adev->mman.initialized && pending) {
                 flush_delayed_work(&adev->mman.bdev.wq);
-               ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
+               pending =3D ttm_bo_lock_delayed_workqueue(&adev->mman.bdev)=
;
+               if (pending) {
+                       ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, t=
rue);
+                       msleep((HZ / 100) < 1) ? 1 : HZ / 100);
+               }
         }
         adev->shutdown =3D true;

--
2.25.1


--_000_BN8PR12MB3587639A4BC2C1B392DD2DFE83EC9BN8PR12MB3587namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div>We don't need that.</div>
<div><br>
</div>
<div>TTM only reschedules when the BOs are still busy.</div>
<div><br>
</div>
<div>And if the BOs are still busy when you unload the driver we have much =
bigger problems that this TTM worker :)</div>
<div><br>
</div>
<div>Regards,</div>
<div>Christian</div>
<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>Von:</b> Pan, Xinhui &lt;Xinhui=
.Pan@amd.com&gt;<br>
<b>Gesendet:</b> Mittwoch, 13. April 2022 05:08<br>
<b>An:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.co=
m&gt;<br>
<b>Betreff:</b> [PATCH] drm/amdgpu: Make sure ttm delayed work finished</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">ttm_device_delayed_workqueue would reschedule itse=
lf if there is pending<br>
BO to be destroyed. So just one flush + cancel_sync is not enough. We<br>
still see lru_list not empty warnging.<br>
<br>
Fix it by waiting all BO to be destroyed.<br>
<br>
Signed-off-by: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--<br>
&nbsp;1 file changed, 8 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 6f47726f1765..e249923eb9a7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3957,11 +3957,17 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_=
device *adev)<br>
&nbsp; */<br>
&nbsp;void amdgpu_device_fini_hw(struct amdgpu_device *adev)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int pending =3D 1;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &qu=
ot;amdgpu: finishing device.\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_delayed_work(&amp;ad=
ev-&gt;delayed_init_work);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mman.initialized) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (adev-&gt;mman.initialized &amp=
;&amp; pending) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; flush_delayed_work(&amp;adev-&gt;mman.bdev.wq);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ttm_bo_lock_delayed_workqueue(&amp;adev-&gt;mman.bdev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pending =3D ttm_bo_lock_delayed_workqueue(&amp;adev-&gt;mman.bde=
v);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (pending) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_unlock_de=
layed_workqueue(&amp;adev-&gt;mman.bdev, true);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep((HZ / 100=
) &lt; 1) ? 1 : HZ / 100);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;shutdown =3D true=
;<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN8PR12MB3587639A4BC2C1B392DD2DFE83EC9BN8PR12MB3587namp_--
