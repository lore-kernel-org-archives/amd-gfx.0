Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7D2C2BA15
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 11:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 858D510E036;
	Tue, 18 Jun 2024 11:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="goy6GWaK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB10F10E036
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 11:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0goH01X8aiwgMKuM2BgCxHWeraTMqlwWJM8Vn12sxxVw4HWWZPt/SxeNldKU++2R0s8Asr/eFokQfRT5fo+cQiXqksUNlMQSpeGSf1PMPuxHfa365plo5rI6EFMNe9wT6xn9uq532M+ETNEMaQuM+ZTbZlKHaghpPgEV37m+KkxWlCBnAfopzeJYdzd+/09DHoSmmdONfLAT+40mkMMEGG2m7zmsaGI3Eq6MwIsNula9sT2LbPZZWFMjSr62AHy4M4qOXwtobaMvvTeFTuz1DYnx6PFeZ6stjeCsGkneaHDHe2Wn65VzB5VP8h5Ob72m9ZQsjnGZliCgAcBQbUAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvzQts7ffuvFJfTHAFfisFdSN1E3RqjvPu0aprOtMmg=;
 b=azr1V//EWrpjOkVk7GcD8j0AJjauXWmg/d1tVZZDO8LDM4trgy8OwocFO3Hh4uGw6lfLM7DQDb+97ruZF/JI7fDnk+6Yzj/of/u81mHQGVP4WY/mG8cXULiTXNVGYIwih4O2/X61dUqJb63ecxEDz1FPwnb/5KJ5/nWDlgtP2GW6iklBwFR3aZdPDYhMcPK9pz69LlCvx4YtMtTto8Ul/Nq1PScGpkRgmS5rreZd2M6W7XI7/QV0Gd5L0a0XDXBdVOvkYOAT5N+Hn79s1evFTALsk6UtZ6lIgduGyunIw53K4RufcxVfO10TE0z2bNa+0bdsxcdaHQkIzyf/IzmdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvzQts7ffuvFJfTHAFfisFdSN1E3RqjvPu0aprOtMmg=;
 b=goy6GWaKQQNspnFyubWPKHoQJlJgaJjRWrDPu49AwZdNWcqR9G0ud1P37niM6OpkeK3GMGhSaOCP06ggo7/m0lm2fQes5TaKk6zxYPyFB3UW5tpIVyD2iTZl85ynb2tbRQi9uQ17G/82bEyXNqriPa15bs2G3mDMIEtyzSoRbds=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Tue, 18 Jun
 2024 11:34:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 11:34:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix pci state save during mode-1 reset
Thread-Topic: [PATCH] drm/amdgpu: Fix pci state save during mode-1 reset
Thread-Index: AQHawVvE6Ujf3UCInUmT6W2ZGw8cgLHNZAng
Date: Tue, 18 Jun 2024 11:34:12 +0000
Message-ID: <BN9PR12MB5257BBF75DB519040A60A183FCCE2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240618084423.1144125-1-lijo.lazar@amd.com>
In-Reply-To: <20240618084423.1144125-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=495d7642-7672-462f-8802-4cfa061af0d6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-18T11:33:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW4PR12MB7215:EE_
x-ms-office365-filtering-correlation-id: bab2b7d6-0a11-4f7e-3872-08dc8f8a937e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?9mS7Xh7XztEVdjJUJzBPgi82Akmd7JnUsuqy7f4XIQ7ilP/PGyCP90/82AFA?=
 =?us-ascii?Q?kfDe/Ls/RMujt9TNEIynJeuhSjiHeJeLtPJOH2n+0OjhN1M50femlTlGVM1B?=
 =?us-ascii?Q?k7iWHk8vKNUMmZ2k6o70bDDzjfz0w9KfTiCYHp5gzh2IMm9WwkQgsIkNCmIC?=
 =?us-ascii?Q?huO2u0Vwj2RjQo1wDnA3WPdvm+cgRa0ag3mUYfbURHjWN5u+iQ6f9DeKsgli?=
 =?us-ascii?Q?+oM74XSalsb9isXd5/qGAREjOZkcdtqwTvZyJmJFnweKgx/twMPFl6fZPd6H?=
 =?us-ascii?Q?k9STUcfwWdbBm6SbTI2YWVpRMmry5mKrSoVT8KkXn7GTrZZy1HghjkVbXSw4?=
 =?us-ascii?Q?SAjBEfg6ZM8FIqUbkamHst/LGv6lFJ20ZPiBOxIkfQD9QmIO3JDGR/RjTrGg?=
 =?us-ascii?Q?xfK+X5t80g2qQxUothSIn427mXBV3oDyYtG/rCMH0/4N7SebObWF3/MYvTrZ?=
 =?us-ascii?Q?T0TmdyZbYBV7xp/oonSTU2rPqpbXp7BqGBIART6QLv7GWNZC1u5TQkHsKAiv?=
 =?us-ascii?Q?4eK5Fxo0OtirwatNwM3bcvxpyc6b2Mo7OGDbUsRibF096ryu0FPG+PKhvnLK?=
 =?us-ascii?Q?8gy4SR5Wv2s8098OYAL8c7gwlKhWqENl2VlBck8R620MtZ8Exg1mXkAU5RoA?=
 =?us-ascii?Q?4Iie08gn4I9puMZOP2HQ17mk7tONn/hQLdBIQv9ukMyEfemC8BUoc7y/Vk8G?=
 =?us-ascii?Q?ckLdmSKYSPiqtVYUgKCwVZ5Vg87F/4eLUCjZRYsr6HZiGRgHJME3P2NsMuJa?=
 =?us-ascii?Q?a0YNuAHNidWV1zBzrk46GFQ5MHpzP9i9Lr9uB8MJ677PgeBM+ityYgO0yrQS?=
 =?us-ascii?Q?K4ZSD+ZpUA9bQt5CTSmK6oLmxwsA/cfk/z6mwkQu3q+SpZ1+VUyu+NLBGbSU?=
 =?us-ascii?Q?5wPvzFUfX6GlZW3v41fyt+MSAYnB0tI97dGWXIqzAeADcf6kyq+wbXzdwoRL?=
 =?us-ascii?Q?8tCIiA0UO2FagNWaFGRNxLBSYmTLkCWJOHxEt3NM9jy+bzNWxTxZMUNqGPkl?=
 =?us-ascii?Q?gnNshVLNiD3GG8H4IHnLzbaPSLJhW8XuX9Rv79Sz4NWGQz4WYA8GXOj++fZL?=
 =?us-ascii?Q?d+SVCdevOD5WmWBOKYZiL+p/rVzVdPcB64NH8Mo7TFA1lu50fiw3F6HLgbhX?=
 =?us-ascii?Q?zXeJUV3f0CJN+CubnoB6pccDohNJsCrJYsT4xuBDWBJ5KZGirrYy/JwrKux3?=
 =?us-ascii?Q?CSxpZ+kVxSQZYeMvNaNE4B4WYXH33oZK8hZzKv+5nlIHui2ukPwBtVj50GSL?=
 =?us-ascii?Q?aKd9QqsIS/GzlT3uTbxUmHdqQFBmgUXvBElgmanBmYIPhZ8jh15LgFBXeN+E?=
 =?us-ascii?Q?zk3HD1357fGwrXQ2jMdBrhFntSZvqt3NSzQPw2barlOPqtsBQOic9xIMEVSv?=
 =?us-ascii?Q?e0RxjVo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n5l8YLasR/oLhq0oXoHmr8B3rNxhuQV1QTC1RXuKqFCP95XVe1pSIdJA4rnJ?=
 =?us-ascii?Q?MxeiKmF5UFMgmsH/6stcveTNsxWdFOyelgF+3CbIjQ4qmQ45ZH3amj0yJeyb?=
 =?us-ascii?Q?j6PmfPbpMPAvExHCWEY23o/bcpNjzz3ZPkCl58+2xfZVy+i0UEPA01BjqapD?=
 =?us-ascii?Q?jvOnUZ9PrrZLEpswVakarIvQZZxpwmvLd7So6uJb+4SQGaDi+w4DGWhEhRq7?=
 =?us-ascii?Q?B24/9ynyTClpFDvVORxZZ9EMftlzPAyExFR9AXXO1YAK6nuoX9D0zO/s/Wf7?=
 =?us-ascii?Q?9/EFr8u3wzFdTVKArn/cgGUHsL+x7mv2W/RvZfpMfxIwlU4mngsM2LiEnu96?=
 =?us-ascii?Q?RRTJ0qI9vjZG6Uwkjgt4QKF5390JDngt+p3qrVOTsJQxmYIcQMjbb0V1+o2E?=
 =?us-ascii?Q?jtmW4t6ylqtuZigBW7ALBZOmi/+PJtK+SkRlYsLUB+2ibKxZl8l67OkSQ0Yt?=
 =?us-ascii?Q?X30FlYAMcMU1MXaL7BXlKOfrEvET5yjliGyc/CDsUUZSFBn6x/MybJG6iZTS?=
 =?us-ascii?Q?ynSVknvBeqqMFKdgBoaCrL4Gnnd5PngJI7B+ABLiTD9FPBjugDGJfLhI8Uzl?=
 =?us-ascii?Q?1KBGPhoU6mm86dpAelMPTyeT++qaGRpwY4oXp2QPdE4wdVrKGcb8FqEwlr8x?=
 =?us-ascii?Q?zj893JQbTgxZ3X8AYHKFdG3fB5wPRoPC7KmuktUG8anejUkX1/shqiR2RGOD?=
 =?us-ascii?Q?dBlAk2Bgq3DPTtLs1vph4ma4fkxGwuUGVuID8JAHThv0z7mjgdFILDyyGZQI?=
 =?us-ascii?Q?kLXHdAP1Me0cmiK1fENN9v3MRkhdkHZ3sSpq0UD08YcuTV+4Lm66IVi0dpbu?=
 =?us-ascii?Q?/Z/pdFbSKI2Ya8y9s352stQg6Nc8YaYVw+VUwEwnmjBMgQIYcpZHxJD4j91J?=
 =?us-ascii?Q?sEcvzZxQwP0Kwmg6/7ii/m+wnUimQROkdVXtatpfQXmbD+KxwDE3VZa47oAU?=
 =?us-ascii?Q?cWZQJ4BEPaYsgMprxCbkml1GQiN6mi0cOR8h1/Y7Pv5q+hxh7AZzdeXMXRU1?=
 =?us-ascii?Q?lX09yDmHW7dhrZRHrefbUP1yrZNcrNmEJrRhhOyd8CyB4HppAJEY5xc1+T0l?=
 =?us-ascii?Q?vap1tH+vj/GTXy+dMfELVB81zqdXj+JVF0z0LwZ53fnrkclaHfvRiL4G1rA1?=
 =?us-ascii?Q?DXOGUXGtC12Tg+rzwZDDRz8RASIUd8JfFszED/QQQbYH6DBpvR13czCIIXDt?=
 =?us-ascii?Q?ouT4lVuqC8i79iy0uZiL8Ikohj37rNTCoHdP7of98qMu2IXIBrLdBvxJDe+n?=
 =?us-ascii?Q?Vqx7aowimtLJy/YMVRFVNv7FmQxyknwQI9CKEw6uGVftM5Cyj2ejDnWQEGtf?=
 =?us-ascii?Q?XC4ytgo5/rnhDyWyHiwXernIVb0MBruwQlYoYQg9zNwoZFVbpw9Lp5cE++zf?=
 =?us-ascii?Q?g3d/xj0vJb6w6g/ixhgJGqP2gm8N7b6IAdFjVC1VhrlPsWJT1P7S/Jg+QYLn?=
 =?us-ascii?Q?rxq6xGzxv8Xet+Q/pbtjmfN1a4n57A7rfyDhKNi26Byy70JoiZS3oyRXfcg1?=
 =?us-ascii?Q?xfCcPNqFVFpr2Qtop1VMMPxz88NAB8YP7PpVLKRF0Gy58o+7hpEtn2gOrPM6?=
 =?us-ascii?Q?s/eAwpUhAbw6sanEbBfR6D2cak3B/+wsCDJnRHa+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab2b7d6-0a11-4f7e-3872-08dc8f8a937e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 11:34:12.2338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MaId6Js1fBgMnrRIoMFPMhAVime3RvP9j14DabL2N21+tVIiISrdWmNIS1dg8SCXFAbEFmate66nWZCBuROew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, June 18, 2024 16:44
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Xu, Feifei <Feifei.Xu@am=
d.com>
Subject: [PATCH] drm/amdgpu: Fix pci state save during mode-1 reset

Cache the PCI state before bus master is disabled. The saved state is later=
 used for other cases like restoring config space after mode-2 reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: 5c03e5843e6b ("drm/amdgpu:add smu mode1/2 support for aldebaran")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 3fb02f5b91c9..6c2ab14ca102 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5224,11 +5224,14 @@ int amdgpu_device_mode1_reset(struct amdgpu_device =
*adev)

        dev_info(adev->dev, "GPU mode1 reset\n");

+       /* Cache the state before bus master disable. The saved config spac=
e
+        * values are used in other cases like restore after mode-2 reset.
+        */
+       amdgpu_device_cache_pci_state(adev->pdev);
+
        /* disable BM */
        pci_clear_master(adev->pdev);

-       amdgpu_device_cache_pci_state(adev->pdev);
-
        if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
                dev_info(adev->dev, "GPU smu mode1 reset\n");
                ret =3D amdgpu_dpm_mode1_reset(adev);
--
2.25.1

