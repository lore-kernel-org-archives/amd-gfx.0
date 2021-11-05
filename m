Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8373C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 04:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB3960FC0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 04:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5FB3960FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599F96E02B;
	Fri,  5 Nov 2021 04:37:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1B46E02B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 04:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw2jSFeToedinY41GPzagPUvHjoCsGcnix7hMdP30wpzbqP6cdfwaqZTXLZLKZw3mDXHHbRcVT6H7EjwIc9uGoYXuUu0EiRCo7QHRBcOJNjwKrIIwCfDIepitpKM8gagqepEIA244gWNJyH9BLhfZccSqiOglDtKSvBMlh5S+kDXU1532QiJN+v29UG3aoQde+But42MABR/w2gMFAaqHh3RZyoKTWdTHQyJa8/tw+BSyOANpOQ405DDFs6VFinewRwW+6JaRtrbtGPItf66xK2LOnMFGnIsSMgQubprZkI1zZ0ehoVs52H+Q5nr/EGffoIfDszyQpuBaRepRwdGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bT1093MEiAtiDKU+526iZDepC5o/ZeXvykDuNIC3tiI=;
 b=OIy69h2yoOmFGYL5MPZHxksL+dXswkuvdSNjjUhDgpVEFOa0G0bAtBF3KZ7XZav2v6N6wdiU+LVDzExegHaEDI5L7U0q+r60ogwrLpRU/5/Ye7YLhdWEpm7kkUWUs5F/tG3VSSG2K+ARJMrkJVaHOotdIbbw+FrHx7prJJfJGPCVU5kcs/wU4uNlVlx80HmqWOkQfGMzPI4QToDLpV9Kwz2oBBzTalX9TjyUI5kMUwuHiiHB0b4uJwV+VvMXPDcJPwGs/xurchMqU4d7vlyUxKg0+j35NTdhNLMBwAynbeStgUjlyIznjYfF8C5oH3Yyu1zhgYBfIzb0Lm6EJhU1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT1093MEiAtiDKU+526iZDepC5o/ZeXvykDuNIC3tiI=;
 b=RPur6q8z+uRH++olqL4trK2idxauRObBBDJOWNIqavihvmOBtVku7ElRGpl1jkyGSnjHiW3GoX2prAnb2+VyCHzvDyRxTh8P5Gm9JI6GUIHjoJqigxgquIyBZ/yBWvkxyJquMT8kYtx/Fb0CaZkIhvm73JSggB1yzCSw4UtqJ1g=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Fri, 5 Nov 2021 04:37:54 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4649.018; Fri, 5 Nov 2021
 04:37:54 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Song, Asher" <Asher.Song@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: assign dpms for amdgpu_vkms_crtc_helper_funcs
Thread-Topic: [PATCH] drm/amdgpu: assign dpms for amdgpu_vkms_crtc_helper_funcs
Thread-Index: AQHX0ft9hOLrCGd9EU6QBOkXeX6SXqv0WWpg
Date: Fri, 5 Nov 2021 04:37:54 +0000
Message-ID: <DM5PR12MB24690E4FB3221191B9AF9A39F18E9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211105041301.3640212-1-Asher.Song@amd.com>
In-Reply-To: <20211105041301.3640212-1-Asher.Song@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-05T04:37:51Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fc53ecf4-74b0-4189-bdca-884519e8d690;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51eb8edd-38b5-461e-4d4e-08d9a016088a
x-ms-traffictypediagnostic: DM6PR12MB4387:
x-microsoft-antispam-prvs: <DM6PR12MB4387386BC4ACB05FB0770DB6F18E9@DM6PR12MB4387.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ihIjVxiHQfT2cWP+9cA5VLUGe8ndiIGDRdRg+EKcuqKqWB98RJqKqHnM0mDW7/Y2Qo6RyQQy0XKnLVJXVnL3V/7uLb4YwaP4ehyuqlmViYBI3j9sYg3F5MfPoKvK9OXw+7yfbSmIyxyw4VXrDOkH+fENZU1moOWdjR1+Nh23Ph1qaKydLwh4sR9sf+l/4fwWAiL4YQJjQkOr3h9h+c6OOs3uCXsOLHefoKH686oIwsNd3JG08OiZobbyHTrI6XBH1xCY6I/dRFC7tb3ziIVtiOjAertKP2QIozMmenaWskgnlBZEtGRD4dLMmea/mJ85eXUdiBoEmffGo721sUUeYibTmYO+tBekqvmj8AAaSKOjBoyNuhdomdHhld58GLq6C9JbmebsVik0UancgyPKU5uBdeu2Ao5NIYm+T2zqnLH//YZ5JW2AVZTYO3n/jkgrAvhS82fKfKglfzlvXy/6+jUfGAPfYVY4PkGiDr2qX16WPpm4+bnq55itZac6Q1c6V8btODm6nd9fgrfSrW5egx+78WEpnLhsB1AimLbVHch2BZRx62zr2RI7uMdv9VDqrjIH91/fEDhNchCz1bOiHTuywwBIwF9m4RvJ/bXrtJzxK8a0EnfKKmRrC1InBBlmCYWXf6ITxbUcciC7b0tA0wKReeMjUqvNn+8/IXBTZ7Nb4CH9nHHIo3UNR3ILs8vSfCJXZOSBeOJv6wwgygH3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(4326008)(6506007)(83380400001)(38070700005)(7696005)(52536014)(2906002)(8936002)(186003)(66476007)(71200400001)(5660300002)(86362001)(66446008)(64756008)(33656002)(316002)(66946007)(508600001)(76116006)(66556008)(110136005)(38100700002)(122000001)(55016002)(26005)(8676002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A35hbZUAqxP3uGdJl277u2W0kLflUpJ0qb9fHxX5g2h6hVpxWw6sGfAmfCxb?=
 =?us-ascii?Q?nZGMi1AclIYufV/zuIA+e549xGo9kXglLrXG6XPHsGUZRjJNDtXVsXKN9zMy?=
 =?us-ascii?Q?SMw76CeB4cQC3Og7WyHr1zAJhGhVfuA6qF5eD6rC6tWzybw0VTyU7al58hA7?=
 =?us-ascii?Q?g8sU/W0BIwuHcTxc4M+AKAKYIWa+XMRkDarMOfO7+zKT1GbU23sKg2K54xEF?=
 =?us-ascii?Q?T7jbpxbbOpeoKmp8d5SlnIVE0umQstTjSftURc4IKA3JlVVYuxB1gwzcwZ1b?=
 =?us-ascii?Q?zpnC9vo55xZiBjxZDYmrwP+FvuhRm/TRVyk/1xNP+q+MwtPj3/Cw2Gw4Gnhh?=
 =?us-ascii?Q?4q02yhuRfj86uSApYeV1PWoI35ddXHGeY/e0IVugkzX557qtD/ZuuItyNOc8?=
 =?us-ascii?Q?mjvt7v6uycJKmwPoPk6V88GYCRPufYhsF2SGTFhCZArQYdGPKcPhf7PcoE7f?=
 =?us-ascii?Q?QrWPV3Ghc8VD+0qJ75CyZLx21O/034PaQ1t0yPWnuITb6ydncz2s2BBDcYAJ?=
 =?us-ascii?Q?1DAzfx407iGgxIEO3mYnnOvcBmlwLqx0ZoA7Ky4ARsfJiGLhYEET2N4Po3XW?=
 =?us-ascii?Q?voSV+tBdmh0MQW2zDrnSvAJmuxdf1ZwxWptGwDR31e+4f5shRf6z3aeYjyEH?=
 =?us-ascii?Q?VUIDJe604O+eG77SelO//djMV1eX2Us7gu20WojlRHxEASF4GTUxl2dRcQP6?=
 =?us-ascii?Q?r+5ISDJo//+a40+nBJTGQvNPdZmuBhbE9AgT1v00JBYf02e69T0Msp+Jpocy?=
 =?us-ascii?Q?fRbP96lV/s7YIXxwwTgkPPKhRnq8wMe/0zKKA+if/HIcFg4jG8rsJQLK8Wpo?=
 =?us-ascii?Q?pPQ/yoVTjIgmP79HH/VTW4IZkd7gzeZYRmKpT3mm+AZybHLBPljikea/J9j6?=
 =?us-ascii?Q?h86I3lZorzEGJyhp2N2Vts/0JPAGnrKHCUqAp/wpPL0GZtbRMayScLHV4wxN?=
 =?us-ascii?Q?3PbILW8Is5oHjSPLdU/lyVQetbffkDUADfH4dwfwPh1iAQHLOkjsYMUrUhwI?=
 =?us-ascii?Q?ZVip17Uc+i+YZa7fKWgaxB4kEZx2AqCy7W+xiFnSptJjCmhCMQJAr/HuUtGr?=
 =?us-ascii?Q?fdWZeMdxvIS9hfoCJ4Wu7pwb8iCyh9/JvJQV1DJB4iy/SnKO6hZNXzfG4O0q?=
 =?us-ascii?Q?GyRe+nfr6hgi7glWdLOd2WXIfmctEeNH7rhU8WM6Eh0I4ljnWcd7w8SgZeWQ?=
 =?us-ascii?Q?RS24Byn0LcDuEKoFLoEPuPEe609sc44y9Hi+9UR/mUZvOdcSE+mF7zfJmaOO?=
 =?us-ascii?Q?9fG1Ue0PimlHEVFSokPbNUYV+Gz2EmuKfFX1i9bF1NsvPKPmlRVNslge0EuZ?=
 =?us-ascii?Q?T7ShGP469tEA8g3W+iGqfGRpoFtm12CmNQbs0vmA5Bfds/0QH8pX+IgsSp1S?=
 =?us-ascii?Q?Ngd7hDI84tNsm7Fo490H2sNGNkw4gW2scPz9PHBoLgPb0GKD89OIrxSlsR4z?=
 =?us-ascii?Q?VwRiTK9jSWeNiNMDgJlUjIwXyu+bAwVeLD1X/9skNCJIwWQsO1Ci7vmdDtkZ?=
 =?us-ascii?Q?l+j0KIEi6u6PfEHUM4AeY7wzYcgImh5/DwjOA5nKjHUim8VuzRHde2bwiUTK?=
 =?us-ascii?Q?URqCQkWHafiOSrdSQujfjk+xf/oG/lSMma16wP57KJlBRu7lvyRMWdiPX2lc?=
 =?us-ascii?Q?tFrjA9sCGlESqD7K9/AzwVk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51eb8edd-38b5-461e-4d4e-08d9a016088a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 04:37:54.1222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fY6cPuo3HRAkurDHvEN6Po7MCXGTsmyUKLCTY7wB7eAqFgCJIY3fACL2uRhfghNFYG+JSNvGCw/88UKw3VFrPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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
Cc: "Song, Asher" <Asher.Song@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

You need to add a Fix tag in the commit message, and pls document the null =
pointer calltrace as well.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Asher So=
ng
Sent: Friday, November 5, 2021 12:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Song, Asher <Asher.Song@amd.com>
Subject: [PATCH] drm/amdgpu: assign dpms for amdgpu_vkms_crtc_helper_funcs

To avoid NULL pointer, assign dpms for amdgpu_vkms_crtc_helper_funcs.

Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 26 +++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index 50bdc39733aa..920b6bc1a9fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -155,8 +155,32 @@ static void amdgpu_vkms_crtc_atomic_flush(struct drm_c=
rtc *crtc,
 		crtc->state->event =3D NULL;
 	}
 }
-
+static void amdgpu_vkms_crtc_dpms(struct drm_crtc *crtc, int mode) {
+	struct drm_device *dev =3D crtc->dev;
+	struct amdgpu_device *adev =3D drm_to_adev(dev);
+	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
+	unsigned type;
+
+	switch (mode) {
+	case DRM_MODE_DPMS_ON:
+		amdgpu_crtc->enabled =3D true;
+		/* Make sure VBLANK interrupts are still enabled */
+		type =3D amdgpu_display_crtc_idx_to_irq_type(adev,
+						amdgpu_crtc->crtc_id);
+		amdgpu_irq_update(adev, &adev->crtc_irq, type);
+		drm_crtc_vblank_on(crtc);
+		break;
+	case DRM_MODE_DPMS_STANDBY:
+	case DRM_MODE_DPMS_SUSPEND:
+	case DRM_MODE_DPMS_OFF:
+		drm_crtc_vblank_off(crtc);
+		amdgpu_crtc->enabled =3D false;
+		break;
+	}
+}
 static const struct drm_crtc_helper_funcs amdgpu_vkms_crtc_helper_funcs =
=3D {
+	.dpms =3D amdgpu_vkms_crtc_dpms,
 	.atomic_flush	=3D amdgpu_vkms_crtc_atomic_flush,
 	.atomic_enable	=3D amdgpu_vkms_crtc_atomic_enable,
 	.atomic_disable	=3D amdgpu_vkms_crtc_atomic_disable,
--
2.25.1
