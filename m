Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C14C7EE39
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Jun 2025 07:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7016110E1F8;
	Sun, 29 Jun 2025 07:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PtYNxTA2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE66810E1F8
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Jun 2025 07:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvxZw/oXzPtrp8PPIabCQfDcRTwfsWJFjIwr5P+evLtxn0zajEiPm+PZeGJkrhRAyPcs6FhrkOYIYhD3zh2FGk7uly7mISaYvIEn4mwTXplpBUheSGsRyZTAaPDvPx3/c5Tdgl965GpnQv3r7fBQoHGazyRYR3kHMFhpIfNKPYGRXu6o5rhdxA/sn7Ht/u1kbtks031i7lu4snX0qea/VVDlTWmzJuTxRM9ILB9IXJl4TMHPwsZjGq9/HwrDt9LzcVXDJOcUCgY3uT7K2vR8JX04IRf6K4HHJIiUWQrxh9rUhydt9u6I2CIvNcyZtqxFOW8L8AApiBBwh9UC47vgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvbfTcLTEk0f6br2EPUGlRCdgaZ0l/XRITNiF4AqWJw=;
 b=RFI5SAGGNmMUsUCNGbv6Ur5SEXtUVrCM+sRfl3NfufVPs4c8x6Ekror5nJtzWTnbtLsW5CvV9f04vH3wTnSNWE4rBlqHskbh2psPPvMpWP7c1++IgNbjA4eZFOuqwJRYK+5t3JyBDYZIf7fHw+I+5ZUwxReYnA9WrR+fLGauuangNR4suWKWuIF4FMPB+8a8DI1Lk4A6PsjVs7oxbMTOXXKP5u4l6Smp3SaOQGJ5w2djYws2Bv6kP6nUTDm1MG87l4I0EqIjZOKvx+QcrSSxdmriRbCczl07sTojwosSJjFcfpKk75HoaWkH3yLY747JTImw1c+z5tjRlP3tz6HgDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvbfTcLTEk0f6br2EPUGlRCdgaZ0l/XRITNiF4AqWJw=;
 b=PtYNxTA2dgfWsTDdPIz1YgyHsQC8d1g0zIAEwO7a/Q9VX3a9CsLETcWfBvSfjvrb+8tmy6rS8K8iREHTVcuYpIIRQOG9O1pNDTJsz0h8Zx2HTqZbz2xM6V+L6YvEJk4QmkxWkKzYNvRhiS0XIQdCFGm1pwBcYCSf4YTAjz8BCG0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Sun, 29 Jun
 2025 07:46:36 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.8880.021; Sun, 29 Jun 2025
 07:46:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] drm/amdgpu: Fix error with dev_info_once usage
Thread-Topic: [PATCH] drm/amdgpu: Fix error with dev_info_once usage
Thread-Index: AQHb5/6/Fpl7zZ1RLUKsjAGu1OjDlrQZw1qw
Date: Sun, 29 Jun 2025 07:46:36 +0000
Message-ID: <BN9PR12MB52572F2ED6EDD778FC4ADA88FC47A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250628073143.1249393-1-lijo.lazar@amd.com>
In-Reply-To: <20250628073143.1249393-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-29T07:44:40.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW4PR12MB5666:EE_
x-ms-office365-filtering-correlation-id: 52380e42-a47e-485c-dae0-08ddb6e1135f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8tHG95Y7RyNoeEefunk8B+JFBx8wO1vfc2CHLli4kO5SYPdvLmweMgmgsNJj?=
 =?us-ascii?Q?W73Rpg1lztgbbeEE1VWw/ibeyOHnHvJAPThCzEKYJl9f9fXL6Tk1dv7WsL/M?=
 =?us-ascii?Q?I002MZuC8KMQW6RM44nH1AyKPV1fVYX3Gx/efjxJisxszqECbj0KmI9duBd0?=
 =?us-ascii?Q?dlXy43g0C6jsmpFTKtwD+Fp+ry+3Pe8KNcEc5dnRj5f2ns4vjdQnTeI3MHlq?=
 =?us-ascii?Q?G9Hvyw4rnaZlxzGGmAPE5UnNqpWOkhKt26MPjPXv0COJZzOzRE+ToKZS5njs?=
 =?us-ascii?Q?c0llsYfoQfkzQDtB3tW8snBD3eA4XV9Nz40JAtvX2oQOYhlPsGOpC0f8hIMk?=
 =?us-ascii?Q?O/rTmzfGpxWRR0Be+QYTw/ht3d3k9IeJMhHFEMfUycQwnB/QuuN6XFMAU7v8?=
 =?us-ascii?Q?015OAHXOL0FWlMXZLV/98IHnC1RMlyA975XWJKDqyOCCALzhFNuUUC6Df7Tf?=
 =?us-ascii?Q?nC43EYVn6JH1BGlrVjERbqNMY1lFAUk8Cs+6igl/mPLjMURQyu765qgk3hv6?=
 =?us-ascii?Q?lPf7ewxvSIfMx8osKyACdAoW6iFxRFXP44fkXV+nw1YmenahoPGINvQmp7jm?=
 =?us-ascii?Q?2I2ut6xWgEY01doMVGL/Me3vl21m8MQkFOSrW/eFE+fQhLg9Ta8z7MM9joad?=
 =?us-ascii?Q?9HCbsu8h6Krwixej/z0scrvfv6s77AmHYiFIIwaoxWfUS2zsA9s3A+H98CId?=
 =?us-ascii?Q?XQrWO80jQp7LzKRUTHbRFaPCL63X2AbLa9EM22CDg1By1liiI1JHiTjTudUM?=
 =?us-ascii?Q?Ce1H7+7r8eKouMm78nC4rkt4g1XdGz1GtXFxd0rTYvAV1sqNcdafR47MCND9?=
 =?us-ascii?Q?ycvywv1GSzxANBHmUhGtx/v23O607HxU1u67r0Jef0rS6EUE2MElDPohlnn8?=
 =?us-ascii?Q?N8JfQtMIo0kHB1rdJIEZ7PTVGVefWWLuboRT099N/MI5azm5h5xlVZQmWMYh?=
 =?us-ascii?Q?cXJH7efZFjG8RvapYrphDQrfuJGG17IyohfZIohqsTT5ySJFJqAU68+n/xLr?=
 =?us-ascii?Q?PyLNS/KtQb3z+pDZUuucupSTly95HjF4g246bISyMmJMRNrAO98pIhGxkhpf?=
 =?us-ascii?Q?rE5ZaW72Qk6dtDO93fY3CPQTR4IUPXLJF94Z5bGpzd9OXR2eBWOs74/3HymI?=
 =?us-ascii?Q?VwbZyQwPvjF04XMzLNTEnqPluc1tOTShmw8bWhulacg+9/GUN/dONguLl9kc?=
 =?us-ascii?Q?qfxmZ7IrzyPsNcJPYrS8dUjnhLbeGRBdZAMbGG5VWt+gOpMfTnnla4TLPgOB?=
 =?us-ascii?Q?X8mHP/cdRYaqSyHIAJuOJFNw1CzpIhcPtxgts7DBH6dzSfyugE0fwKXT67CN?=
 =?us-ascii?Q?EIIYyj5RSbHK6BETHRCBVeBaH4bXBNwIlMj7UN7CJHCyLXNUHjXGj3qFB/8P?=
 =?us-ascii?Q?2glaEtfXGQgrvYSvawS2jksutQ29CKYLbU6HPun1mf4/oZklOhJRcrlIU1lA?=
 =?us-ascii?Q?UZZtcaQGLzub4NVawign6uTbQ7l3dDYNlETeGSxoGzYByw+KCxSo6X7UUMsO?=
 =?us-ascii?Q?+L+nzcNbLC+70Gk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kgNin+lhOoK7h17NMAS3yq9gMRp+O8Dx5r1etLJXeqs671cN0Dy8Wl94ggrl?=
 =?us-ascii?Q?+VRfmLbUfteG1pA8q8AuOFyKeJj/XNpeokHLH2eeW4fcXxClVfHrj6OZ9opx?=
 =?us-ascii?Q?PX8JpSux6aJd71bI5COIN4oX1nH0afYGLOB59BexB4YbyvqhxFfMj2RKQian?=
 =?us-ascii?Q?/5pnzKGhSXcWrcu/sNBKD93zKeoBTaJmoS/tVqZmXOmpHxAsknnlZcLj5JAY?=
 =?us-ascii?Q?gcioPnruocfRGZXCqUgI2WtwBqtUQ8ZVbNbMj8rM2QfMU3wryDoaeG7UWZzj?=
 =?us-ascii?Q?o+63qdn3MlraLnVe2g080fw3aB5NTD9U3ZaLxkMgk2dsiwtV4fyIEN6Ep02D?=
 =?us-ascii?Q?L5/vZ6IVq9iaFyjxiYf5dXrdQgP/zhe3G2NiAJq06jrrxRWOyEbcG7kLvzSN?=
 =?us-ascii?Q?ib+Alh/1TTsKiJrMkL1toFp/ud7cDx8JNZJ5rfxQVc+qHA7KFtwQlgiLWYDM?=
 =?us-ascii?Q?gnqrsBnIivqwT/f8sQ7YZQJqyf+CpyyqrE6BGACv6L5+DxIsfTgUZQrz85Pr?=
 =?us-ascii?Q?KK5zpXRqZOw/SUXPXqSvTZhuppl37jrZFAlsAI5svTSTolB44I7VHshfN7dC?=
 =?us-ascii?Q?odiB5Q7hBb9HSNxNg7+gzPTHiDMQ1ulfsDgYtL0gZ8UH/PR60j5zRRAkv0FS?=
 =?us-ascii?Q?qZceAfMEsKKkhom3uZRv5jZI/R+RaO6571Hxz3f8tCu36TCEImV1TwO7Ky2V?=
 =?us-ascii?Q?yYQp9tb1lN18l9wpy4srfseS8UuxcFJFmgw9x3R/Vz4PpZXd5Ym75sRMDHBj?=
 =?us-ascii?Q?JrsmVWTKyoarzVcdkA2UZIomLEw5AMd6+FrqriLd8XPXDvcUTsRhuXiSmmMr?=
 =?us-ascii?Q?Irn47v6/4p9H7OxlLI6eUIwz3A8VJjn8jb9fGPBe59UI+93+yjU+qd2MmlyD?=
 =?us-ascii?Q?EkXSj4QoMAOjh++quXuvpCy0WfRnv0J+3bz1trvuohPDiW2k5il3bNgB//Aw?=
 =?us-ascii?Q?r13qQiVBRuC5bPIhu6QQwpW8ntsXt7V8DTUPCFbvzRWmUkS9Nk+Bi7oOUsGa?=
 =?us-ascii?Q?l2B7SS3w6XDaAHU+kIaHKd1N3lC6zX4PX9BvmIuf+7Mqv0xgdFnk+Um5d31O?=
 =?us-ascii?Q?auGpZInlNtnsq+oErH+vJXbwGzfHoDDUd9UxzqLkDAzLXUo6XfPfkrY6Xy4s?=
 =?us-ascii?Q?oZnTMEawC2NxTwHQrL9iBeck+CWplN3OMBHkqk4ieFjwNHEmrdbZhXDs7aLQ?=
 =?us-ascii?Q?zhI4zXFhoQs+AUikHyyl1Q4QhLduZMVHh+bq+UMkfuZjXD52Fdt9e3JYgZcf?=
 =?us-ascii?Q?OLuQVuP5/1q6ztM0G1lpd5Vk3KSqwoBtYqi/a4VzWw/9ALb26gjftQeP4Hm4?=
 =?us-ascii?Q?NRpP0qQE1ny10SPPriP8mxgKANRu7IvZelUM5DOgEwAOJQ4wRPVOD1fsbG4T?=
 =?us-ascii?Q?RNpv+s8ONHRpC202kIm9nELxvdTIlVnfg3eyJN+PPgpOhP4t9gBFoqbhjHLw?=
 =?us-ascii?Q?64TNvZTfHO03/TkFH2+/sy1hrbxcRKBDvawBG+YwyJWlAMA7+HtUuO76xDCC?=
 =?us-ascii?Q?1OvrcL0iYOkr71/9H+onJT4ZGa2Zm2m5DC48Pq2Z+ufdzsuTmwIGaQgPQGmT?=
 =?us-ascii?Q?2qq2kNp/wsagjrsk9tA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52380e42-a47e-485c-dae0-08ddb6e1135f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2025 07:46:36.5014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +tyxe3iOVYJk0gCLxYAN8SVW3voLD7ywWDznfHKK2DpIT9jpXGiWB2hiSR+qNID2GY2wTqA8oBXUS6vf/zRQTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
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

-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
+bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
+                                      enum amd_asic_type asic_type)

You may also consider using amdgpu_device * as input parameter. either way =
works for me. The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Saturday, June 28, 2025 15:32
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; kernel test robot <lkp@i=
ntel.com>
Subject: [PATCH] drm/amdgpu: Fix error with dev_info_once usage

Fixes error with dev_info_once usage in amdgpu_device_asic_has_dc_support.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506281140.mXfWT3EN-lkp@int=
el.com/
Fixes: f408cc771c33 ("drm/amdgpu: Convert from DRM_* to dev_*")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 7427986992d6..1b61e0d27ce2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1390,7 +1390,8 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_devi=
ce *adev,  void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *ade=
v,
                                   u64 reg_addr, u64 reg_data);
 u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev); -bool amdgpu_dev=
ice_asic_has_dc_support(enum amd_asic_type asic_type);
+bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
+                                      enum amd_asic_type asic_type);
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);

 void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev); =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 334e442c95ef..95e9f7285351 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4099,12 +4099,14 @@ static void amdgpu_device_detect_sriov_bios(struct =
amdgpu_device *adev)
 /**
  * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
  *
+ * @pdev : pci device context
  * @asic_type: AMD asic type
  *
  * Check if there is DC (new modesetting infrastructre) support for an asi=
c.
  * returns true if DC has support, false if not.
  */
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
+bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
+                                      enum amd_asic_type asic_type)
 {
        switch (asic_type) {
 #ifdef CONFIG_DRM_AMDGPU_SI
@@ -4148,7 +4150,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_=
type asic_type)
        default:
                if (amdgpu_dc > 0)
                        dev_info_once(
-                               adev->dev,
+                               &pdev->dev,
                                "Display Core has been requested via kernel=
 parameter but isn't supported by ASIC, ignoring\n");
                return false;
 #endif
@@ -4168,7 +4170,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_devic=
e *adev)
            (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK))
                return false;

-       return amdgpu_device_asic_has_dc_support(adev->asic_type);
+       return amdgpu_device_asic_has_dc_support(adev->pdev, adev->asic_typ=
e);
 }

 static void amdgpu_device_xgmi_reset_func(struct work_struct *__work) diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_drv.c
index 2bb02fe9c880..b299e15bb5e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2327,7 +2327,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
                amdgpu_aspm =3D 0;

        if (amdgpu_virtual_display ||
-           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
+           amdgpu_device_asic_has_dc_support(pdev, flags & AMD_ASIC_MASK))
                supports_atomic =3D true;

        if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) {
--
2.49.0

