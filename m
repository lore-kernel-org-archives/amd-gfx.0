Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BA6C3A59D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 04:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE93A10E240;
	Mon, 24 Oct 2022 04:52:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B1210E240
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 04:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPRoxmRngHXccOyUdfy2MWAGkU2AMCxA//397lz+MSMBRbUqtgKcYE2uIU0oHOZC6rm+8sU//SvYLrxy8oqHfHwxSQDpxBHwslaF9DxYjr93G5a7YSMBtvj5iFO4qmAzocSvR0DqvpM/QJH3fQPuJ6IpTVz6+Q+721w3qDmRIeHtTd7iVESyWEejzueg3WI+GVhPhZOiTQ+wy+buEhXqTbxrbLkUdQiQSW7nPuJO21KK0SCVUEEsUWHsyXW294VcnAMXn6CX3VsWrC9xAwTKhnRfqO71QZKNEPwRF3eKxN2wDywXm8TBmfw/kvA61XhL0NeH8OJEEsMtlSMx9pRH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTSnxHFPaiO8asitLWyGSW3TcTBbOGEl6JahCu/p9WQ=;
 b=foBRyBwg6b6AlZ89XMcWdi1b+iXE5o4o+VfKVjtkiesKL+TqT4z7EA1XL4JlZ8rNVhkZqWDoc5KPqJIo5L22Ah+ya3L2DLGlwZONe9YG2hSi3MVdq0zRiDAsBQfc+E4SB5iTUOgKhb7tromaBW5h5Cqfd3FBOV1xH/O19endNZkwpQ+WRQthdAqDhTGNgjpXpt+J85vR530oJqxtqdjrUJpm70LflR5fNO45SpT721YKMMUD2vtGKwUuNjn6HGi6vU0BDR0ED+RUmeRmMBqatKRRh9gnKgnKxX07Mn/MczNlL6kNWfQPlqmA/k3WdSaJwVSbI9zkr9mdUy0qZ3YHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTSnxHFPaiO8asitLWyGSW3TcTBbOGEl6JahCu/p9WQ=;
 b=L7TUZEbnpfuMbnnZIB+4XSXt5CI7/GX5xD8cKUJ37K+5jmbNtq2q7tfnNbgP5ziPJP/dMA1URy1b3juInlDoxWTTiVm9X/UmF+8acKrrZclE+R41Nl1ASOnF5G+4mM9hbzQMjaYzG7bMiLkgzpuxSDGNFeQUbVklw6uIe9m8VCc=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 04:52:12 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::ca54:58f9:53db:d6f1]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::ca54:58f9:53db:d6f1%5]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 04:52:12 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: set fb_modifiers_not_supported in vkms
Thread-Topic: [PATCH] drm/amdgpu: set fb_modifiers_not_supported in vkms
Thread-Index: AQHY5pReAa6NH28jFECjxwG0nlO2Sq4c93+AgAAD+oA=
Date: Mon, 24 Oct 2022 04:52:12 +0000
Message-ID: <CY5PR12MB63699C408CCB061A39903543C12E9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20221023040246.2491869-1-yifan1.zhang@amd.com>
 <DM5PR12MB2469B079C55BCEE73642410AF12E9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469B079C55BCEE73642410AF12E9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-24T04:52:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=787d0f95-37da-4787-a8be-9d00aad5d14c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-24T04:52:08Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3ac81014-55a3-41ca-9280-387a44b0f65e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SN7PR12MB6792:EE_
x-ms-office365-filtering-correlation-id: 26886bcf-7f71-48a1-4268-08dab57b83b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HzdNB1xPGFtYYyz3hETrWNQYt3YS4g/rkyMKANDvor1YYzDujen0ZZ4SjQRiQ2Ycp21IUOYdXbfH8OEafrhkN9w+a7Zb4JBYKRnhlDdmCEXfKYG8kbRA03F5Wd0UYJUMYAERmk6LWVpVNSkO1dRotk1i62RkshHLufS2Tk89e7gfEKoQMWn/9PwQSmrBLERV/1EMNHvXDLIO9lXEewwgVskFVqClvlzW3F7vhZPwp7TCd3EzPi66X0U6q4isFHsVDF0tSi5LKDCqfL3h9wzBOQRQ9X4lX3tif+AkhXN+L8T4MxSiM1+GGoFbIxTPOeMuncsmPOPPdX4aHzw37cfdJafoR5Q9XBErziuaF33nV7rxn3J0e+GOmOrqlpRME1FgiwdmB64z1KrUQ7x1XsAv0uSQE7K1FJbDupjCObh2UHM0UOccS4yvze+FvhhnAHwRPIHlpw/9jIzsYOsiQ/aeb9eWY+Z7BzjDNJS//UvMaN21FMO718qZbbA+hw+ZFEFsN7bSxc+7apR+fwG8JNn6Tb72NegHl9db1UHcYBtgYb/WX1Hv3XfnSocEHkU6W2AqZ3txKZsruxXatnSQL5AvbhZgsqOktyygP+VtHlNR9VAnBa3F/mY//YgG+NCI8zjAUWTjKPsoSjbtx/j8fSt6865nahVICuBhDqAnTXULvZ/pm92yXg42BM0fmRgXKZHaBQodVvLHDLsc6EEEdtOeb6Wl5TWxy1jXQyb4Tb2XYAHHcv4R65FwoW6zzIdaokGNN9Rzakjo1N/gPr1LAH2/CA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199015)(66946007)(66476007)(64756008)(66556008)(4326008)(8676002)(186003)(76116006)(66446008)(41300700001)(2906002)(55016003)(83380400001)(54906003)(38100700002)(86362001)(478600001)(71200400001)(38070700005)(53546011)(6506007)(7696005)(33656002)(316002)(110136005)(9686003)(26005)(5660300002)(122000001)(8936002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TE4qa6okySjb8Jf/Mx20aBtt64oeMmNiogTT0/Q8XxIvSn8ud+y3IGYBy/gd?=
 =?us-ascii?Q?/1gX8qTnJZZ8/qjXV2ij2IjNnWfKj5hTKM7DOEfsjafE7ugV7XlmCCdtCRCw?=
 =?us-ascii?Q?lt8aI/oRdw6Ik0hOC/YOwnWMsregZfv7UK3bGY6RjwoF8Mp/BsJ2weXRYDrR?=
 =?us-ascii?Q?aFfaFkAIxXzpmpwuusV2wUG8P7zw539deHkuR5bxNtFUWu6C9auHXwEeczej?=
 =?us-ascii?Q?NFrCFGTvQuFy+GUKrB8942EaxK9fME55sxQTn4KdOMaLO9X31vR8gGsRwRTj?=
 =?us-ascii?Q?kCZ5jlmXAZX4vcCoa/oY5X/5HXZJBGTKnzmktYNVHRz3VwGHZjOSPbcSljab?=
 =?us-ascii?Q?KKi4kN0GoPznsPdvwpcQXrRSh+2xfqDaK2HcmTkQoNhF4pHwOL8+z0mZb8eC?=
 =?us-ascii?Q?eUJtAcJ41BU4cwy91mYgcq/qDrhvIg+5519SWoEv7E+t8rutP9+e93BdejNg?=
 =?us-ascii?Q?uedjqNRxSF9BBMprfoWwjtFYXhgCaC22uw4T4xRzEUUCKIFMR1RzA2XkPzX/?=
 =?us-ascii?Q?z6IsggWH88ckgTwDbGTzb2J7z+36IPHfSXJ34DGhqgJDjdvXLVrxffkudE+l?=
 =?us-ascii?Q?fhq4tYr2wyvVV6Ui9fpsikcsSTq1ItJ+zXg7mlUq3K9BqoxwvKPXHXqXy6GZ?=
 =?us-ascii?Q?oge3AXNL94bKvVheCoclOeUzK5+jUljYwwCRFMBuynP1WpfW6Mx4P9BwVzlL?=
 =?us-ascii?Q?kRGz9aaC5zhKavJcYeVKLsXYly3k8qzzhFRD/Q+uHd4lbXD/mWHuVefT7KqD?=
 =?us-ascii?Q?lXpZtcIpwnsh1E+CVbWUtXZBfnIgXrrM+KiVvZT5ApKkcpXa+RDqlJehGxe3?=
 =?us-ascii?Q?iB6J7xLn28SNWn0PcLgH4+M2jFaHWB7UxPC6QzvwT4eqmLD8KiAx1n4sAX8K?=
 =?us-ascii?Q?4GaS4R+qujQgzIMcJw8m0VHCwnRg9GJPzvkj/LasYek71GRLWw1jhRx51oD5?=
 =?us-ascii?Q?3+qWX7g+J1KBw0VC9T06OPEwZX0CWmcyLepj9/O9n6IV0KLAs8QGnmKokRHG?=
 =?us-ascii?Q?16/6F9+EUpL6FGUAN1AWL6gvPtgX5u2TFQxpjU3CTb3PvdQylSU4Fvh9KedA?=
 =?us-ascii?Q?5G/0k1rqPv5V+rm9MagE2ULYjT8SrLaFH61opZMwNQXplgmBySk0ikfy8baD?=
 =?us-ascii?Q?Q96Cb//a3JOBMSG7ys9zahHbKRK54xkgCY62+hdGtiS6POiLBtZffjnb0WGF?=
 =?us-ascii?Q?F+JRYuOGseZ7d7gPlZXdMyUtH2kVDP15Rearc3Oo6zT13n/soc9ga4OIoTwy?=
 =?us-ascii?Q?LeH9xt/zA8C5vsPQtPHfylRYs1lMiSoBHJHJLCjBokWEqUw49/7GL0Jd1TVe?=
 =?us-ascii?Q?k1Y0CvBQhfHjhgzeVGvcX8RAMdzQSIECJ0pjhhDqMJs+4HOMvK6iN52OB7OC?=
 =?us-ascii?Q?HujOTbNoPI8uCJ0ydO7VxTtTsuyKx/HxBoi4uUj1AciV3AMkWb0zEHAw4smn?=
 =?us-ascii?Q?sTbAA/1yWaWo06QtjAmOlefu9L4Bg9x6tWn05zO3yyXWR2oEegCRtevJImlz?=
 =?us-ascii?Q?R45a2fbvMpp4hUTDPfaipTmA7e+SWjV6ixM4pdb86nQnMaOf+unIBsF24jeW?=
 =?us-ascii?Q?e2szeTVjOl4KZZmXlFc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26886bcf-7f71-48a1-4268-08dab57b83b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 04:52:12.1226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWbbfpTwzerNEP69Pc6j0f/7e+Oo3HESgEELSBMlNTeBxpkRDHQ5sTusue97MiaZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Agree. Will change it in V2.

Best Regards,
Yifan

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: Monday, October 24, 2022 12:38 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Koenig, Christian <=
Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: set fb_modifiers_not_supported in vkms

Maybe it's suggested to add it in amdgpu_vkms_sw_init?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Sunday, October 23, 2022 12:03 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Koenig, Christian <=
Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: set fb_modifiers_not_supported in vkms

This patch to fix the gdm3 start failure with virual display:

/usr/libexec/gdm-x-session[1711]: (II) AMDGPU(0): Setting screen physical s=
ize to 270 x 203
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): Failed to make import pri=
me FD as pixmap: 22
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): failed to set mode: Inval=
id argument
/usr/libexec/gdm-x-session[1711]: (WW) AMDGPU(0): Failed to set mode on CRT=
C 0
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): Failed to enable any CRTC
gnome-shell[1840]: Running GNOME Shell (using mutter 42.2) as a X11 window =
and compositing manager
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): failed to set mode: Inval=
id argument

vkms doesn't have modifiers support, set fb_modifiers_not_supported to brin=
g the gdm back.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index 576849e95296..2bb346bf0d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -399,6 +399,8 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct =
drm_device *dev,
 	if (!plane)
 		return ERR_PTR(-ENOMEM);
=20
+	dev->mode_config.fb_modifiers_not_supported =3D true;
+
 	ret =3D drm_universal_plane_init(dev, plane, 1 << index,
 				       &amdgpu_vkms_plane_funcs,
 				       amdgpu_vkms_formats,
--
2.37.3
