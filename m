Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A97FF8867
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B96F210EA04;
	Tue, 28 Apr 2026 03:11:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZvvL57J8";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8DBE10EA04
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHizFcph3A2LNxg84I+ix1HKHGfq4bDPvfVCiqDdQPyaOS4uj7/r1sVU5dEdHmFmDbytwlqddWEARSYEApKJKsElgd3gSJiugv7o1o2VBiZWq/+iBz15P78LyTZG7GgFtDWuc7GWyRKLr4LkLTYogkKFe7oSPL+7Qk++1mKxecNagXKbcXrH5bqE0KlpfGQ3tDrvF8RqSPHcA3fIL/iNffwJKJGluIVjMihQ4FxUXxLWYpgzEYM8dGLEK6Ba7D7tvi3ZzEiymGZQh0piZky7KqXnUoJ22sEWtxe1nZ0+9f4L3Ax6uND40OuEsbVpRMBJZP18Tqn1E2Zi8okQAl5eTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfOA416cmbQKullJnMRILTAMoQfe+4hdVfAqnN3kzOU=;
 b=G7+3rDIqgaRgqZ3esNgyz1lmPPioDDATspxTbuslJDYRDVI4rC4GMgAqcCVhLsf2HmWGrgrha6MNRPM7s1RiQVvxNSIvWtU7nOZ/ijf+li9I635g5Hcy0UbiF6t3pOXfTfLlUfC0bHJrX1Jve2sKyiFiUtIbZsf/t68OXTCnQUrM1ayR1IkHxkP9332kt8ZDb2Ruz7tcCD8MAiHKeH5Y9K/PubiuhW0C4Hc4tyWZE6Q0+sKQ7sY6d41pML5Ehrk7K+KBGHhzy4pPk3akcamsqp5Y6Bc90e7YBjOXmxCeffUgCp5G2Ct3YZow9eSIPH4mA7IjR8eO9TqVARMi5c6Shg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfOA416cmbQKullJnMRILTAMoQfe+4hdVfAqnN3kzOU=;
 b=ZvvL57J8qVUbBg8ItffqPsKkI+DuZc0+9LpOylAzas3yw8msOfmW4tXC7YiaGhWHXPBIRnD1WCin1CugMArUQHroYGsDGgPUJcptD9ZOxrTJdJnsdF/zHWatV+vSkfomtLw7YQKJrqnHEzAKiS7OtC5SgFk/rzqss/2NEg3BQlQ=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:11:48 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:11:48 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 03/17] drm/amdgpu: implement profiler ioctl
Thread-Topic: [PATCH v2 03/17] drm/amdgpu: implement profiler ioctl
Thread-Index: AQHcu9QUDhaNUDrz7kClM3O1oaEF8rX0AcYw
Date: Tue, 28 Apr 2026 03:11:48 +0000
Message-ID: <BY5PR12MB4179A4E4B1B2B99121BC14E8FD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-4-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-4-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:11:33.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|SN7PR12MB7201:EE_
x-ms-office365-filtering-correlation-id: bdf459d5-9306-4f68-a5a3-08dea4d3e2fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: Rg7Gatuught7aHUaDBv7mYpYM41C2/lQHt/p2wQFes16d6tlKPRIxXsTn5ziaeeyPwjBpKYvZk8SNNjKotU8gFPi/G/Nbbfl6S7+sOhF6zOfGxbhslgqddLdZC0w3wRG6O38rnjdraD3Fc2lmqAtaQiCGFhACNIEH6EdyLYCxpWV1azEZMIcOSEbyOzk2vRBbXfJ8yJ7KCUiFqQNp6EOC4tceJxDokQCYBhSyxGGmmUtvw5ZQYIXZj3lGz+oTBjTRsvIoZsD9t6vdXvDET0l/AP4knx2l+55Jlmg7cALxTZqOWMv2rIOit9VAgpS1x5N/O43897aO4f4cbXzWRS5mXLFdQycX+JiQuLRjjZT7Ci9ba2vdsEK7ePW2dZ8+uo/oN+yg9LXBanWrqzFZRSfvOmBrR9kiundJZh7XxJfuTwyrM1lfdAV7nz/DkPxkcdzPmhoG3++DVG/eaKPc9bUsmPuRfPd5eykRrQCIeNAAW9odN6EaUWTLv4bE+m4eGDMH/FKeQyXPvFFEr+4rROETo5KSNfotHFTO0X2Z4dpodxCq5RKLJr30bCKGnKJ/7+7o6ROTFSkv6HnmZJwhuW4jOxeaCCya9OnKc0cxu7f3z+SQpfVyjii+gnIiwQqDyHGmwVRxZJI3317B6Or6Eo0fp4eJcfi+qrmEIg11Sdmtl6BlFw4nzD93LRxR/8I9VihSMEF74Tv91MMDHY/Cv50hhZgva+yX5++fpSOloQsfgeG436qxv7MrEczSFaj1EIShuX2EGHAKE2trhQ5/jhD4naS1ZOjDc3xXk59GL1h0aw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aviZjHJHvMglYa3HJ+uUSTNvL35EtlLzi3o/qE3RnhZwytOtfPnoM03RxjPM?=
 =?us-ascii?Q?HH5kIiAAdEPdO7d3rAc6yEm4IU99QvdNpzfwoQzPuJaW7GwaCLzyYT1SfdWg?=
 =?us-ascii?Q?x945ZiANNYtmXrDyPTYXDMXi+QU97E4yU5LLRqy+l1Q8F/Z4MbkWA5MpNTf/?=
 =?us-ascii?Q?o5ZTbjiI8qnGvBJhLq1P7SARn9N0OYfXp3lIienIkyb0tuQsDCTVbY4x1ZJr?=
 =?us-ascii?Q?+c5qtEu7llwAOZmBDG0s5/PQhGk7pVRqSOqEqh9MPBNCidPc994x3CD5qzkS?=
 =?us-ascii?Q?k+xP0tML/ixLd7vII62zJL3XxCzDJYsIlr6LNUfhJn5A9Y4R2lv0YF0ko3Rt?=
 =?us-ascii?Q?P7J9Pd7qcDAPrSQYBzH/IZ5+Tv341hSIZkcRxT/k9Xdr5utbDaeE0GPCjW/c?=
 =?us-ascii?Q?hVRgZ5xJxoF+K0zvgo3hUWKfvzaPKvxVFV2xOXmGmx6XT+XD3gTnn+Ags6j2?=
 =?us-ascii?Q?omVu/yPWVfzBNqy/rHiN/b+Y7PkHqe2/pG5bH6zyTKenHKqLlTbRFT4tRiVr?=
 =?us-ascii?Q?zTIR1a7MVSgGe7MlbcFVnPgKyRxBIpL88tGP1yPcmtYJhC1iHt6VcEfLJ4OG?=
 =?us-ascii?Q?MkRqiBei5m/nfdnj5cAiiAM5Gj8/tHJwQpOhebl5cHHoAxwMJD06b5Bh1ead?=
 =?us-ascii?Q?9fQ3vGoa+T4peA6U6E44y09GbwbFTqrbSZWcuJEvdSjFZZ6rWPdETLVr5311?=
 =?us-ascii?Q?pQp5ku50T3j8e6ElaKkNM3bUg+sPsdX3AVuagsZ1SjgEGC+CAAvKlJex9Gos?=
 =?us-ascii?Q?GMKnj4pmx4dM9+DcgAIe5dX9eoYMN75MELg20iblTZH3qQAO3T7brPnwlbX1?=
 =?us-ascii?Q?9a96bxAwT6RjbOurkLvR0obFgCjonkD8CK1OMUOiUY0rzcaavpL7nNKWuUcT?=
 =?us-ascii?Q?ssMtpB9hWV9OX5mAZqt3c4U5Q5MPGsei/U4oVQIRlFoAO12HzktVOU0Da/Z6?=
 =?us-ascii?Q?7Q1sYySTz7RSsXz5GyyI9NAtBexKH+fDaBVMl2texZE880WupXN97BJcutlF?=
 =?us-ascii?Q?vsL6bR9Y9hl8vMbt+CD1nVTUu+ZGZ9W2b8h4PG4dqexipEHuDm8T8tkaSPVS?=
 =?us-ascii?Q?I9xE9+jKpyjEjU5fciq0d+9q+DIohs8RJ45H34sgIZwx0rbIiNe5WbYeu9Du?=
 =?us-ascii?Q?ZJpYI8ra09D0zSAJ+oKZGsJuOhGetcMr2dS290xm56iFH9iu438MXYMNRAMc?=
 =?us-ascii?Q?OMRiSd27CSm9BgieHXXSw1ShaHKXvNedFHftX2/hH/BUif0EQeR6FGImOmJY?=
 =?us-ascii?Q?HJDdbLvf80j2tuk4wLkIXbCSHp96jZRftJMwtQDgAPq4zgYqsQXWfOLOwQGu?=
 =?us-ascii?Q?CA4u0vFY3nYnaqA11JqNwoEouFPSIRK+C8NdLVlcIMDxSvXXB7xljoFyN5ff?=
 =?us-ascii?Q?Fq6/ZzGA8cKgrqAcPzZjF99cGFaJ2m3fh34fDhNIiD2RXcYijNhTdA8by6Jh?=
 =?us-ascii?Q?RerPmDhGkACNWTV3M4sqjqiQPTZ1ijuv/5onBVCAqp9Lxw8k5vfRRCDxkMsi?=
 =?us-ascii?Q?vkfRQfwfMVkF7ACA+SvApGZ7OIyd0eQ61yqejqhTfxppwS0lFrJCMNXv9kNX?=
 =?us-ascii?Q?DCnTxczW2XYQakDaCLiep4iKTX5/NXg3qAA1jape3ktgeSiLix3vIjDAborS?=
 =?us-ascii?Q?C9yU1rqt56e+3qG77YvAatk+yPBOb3k0QX9bj8cYFDzLHy+eAl/ldBqr20LL?=
 =?us-ascii?Q?pk0G9F82V76H5nyT4iGuBf1Wc+O+bSoOlKMMqt1qmWcSd50u?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf459d5-9306-4f68-a5a3-08dea4d3e2fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:11:48.6032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZ8EWitrKfb2Zl0oeLDzRRcKKcG6o5/KXEcVL1RK2Yin3S1q/JZew4XNCltw1GtESsSS7moLivR6pzZWnbxJbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

AMD General

Reviewed-by: Bing Ma <Bing.Ma@amd.com>

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Tuesday, March 24, 2026 2:20 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH v2 03/17] drm/amdgpu: implement profiler ioctl

with wire up the DRM_AMDGPU_PROFILER ioctl introduced in the UAPI patch by =
registering amdgpu_profiler_ioctl() as its handler with DRM_AUTH|DRM_RENDER=
_ALLOW permissions.

Implement the first operation AMDGPU_PROFILER_VERSION, which returns the pr=
ofiler UAPI version to user space by packing the major version into bits 31=
:16 and the minor version into bits 15:0 of the args->version field. Unknow=
n operations return -EINVAL.

A helper macro AMDGPU_XCP_ID() is added to normalize the XCP partition ID f=
or display purposes: AMDGPU_XCP_NO_PARTITION (device not yet initialized) i=
s mapped to 0, while valid partition IDs are passed through unchanged.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 25 ++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 52423c98ebf5..dcd36a6d2930 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3064,6 +3064,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D {
        DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, D=
RM_AUTH|DRM_RENDER_ALLOW),
        DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_A=
UTH|DRM_RENDER_ALLOW),
        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_=
ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+       DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl,
+DRM_AUTH|DRM_RENDER_ALLOW),
 };

 static const struct drm_driver amdgpu_kms_driver =3D { diff --git a/driver=
s/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_=
profiler.c
index d2cf0520c6f1..bed43ea8bcc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -32,6 +32,31 @@
 #define AMDGPU_PROFILER_VERSION_MAJOR 1  #define AMDGPU_PROFILER_VERSION_M=
INOR 1

+int amdgpu_profiler_ioctl(
+               struct drm_device *dev,
+               void *data,
+               struct drm_file *filp)
+{
+       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
+       struct amdgpu_device *adev =3D fpriv_to_adev(fpriv);
+       struct drm_amdgpu_profiler_args *args =3D data;
+
+       dev_dbg(adev->dev, "Profiler IOCTL op %d on render node %d xcp %d",
+               args->op, adev->ddev.render->index, AMDGPU_XCP_ID(fpriv->xc=
p_id));
+
+       switch (args->op) {
+       case AMDGPU_PROFILER_VERSION:
+               args->version =3D AMDGPU_PROFILER_VERSION_MAJOR << 16 |
+                                       AMDGPU_PROFILER_VERSION_MINOR;
+               return 0;
+
+       default:
+               dev_dbg(adev->dev, "Invalid option: %i", args->op);
+       }
+
+       return -EINVAL;
+}
+
 int amdgpu_profiler_mgr_init(
                struct amdgpu_profiler_mgr *prof_mgr,
                struct amdgpu_fpriv *fpriv)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_profiler.h
index 2dfc0b1bb207..779cfe19fda2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -25,6 +25,7 @@
 #ifndef AMDGPU_PROFILER_H_
 #define AMDGPU_PROFILER_H_

+#define AMDGPU_XCP_ID(x) (x =3D=3D AMDGPU_XCP_NO_PARTITION ? 0 : x)
 #define fpriv_to_prof_mgr(fpriv) (&(fpriv)->userq_mgr.adev->prof_mgr)
 #define fpriv_to_adev(fpriv) ((fpriv)->userq_mgr.adev)

@@ -40,6 +41,8 @@ struct amdgpu_profiler_mgr {
        struct amdgpu_profiler_xcp_mgr prof_xcp_mgr[MAX_XCP];  };

+int amdgpu_profiler_ioctl(struct drm_device *dev, void *data,
+                                       struct drm_file *filp);
 int amdgpu_profiler_mgr_init(struct amdgpu_profiler_mgr *prof_mgr,
                                        struct amdgpu_fpriv *fpriv);
 void amdgpu_profiler_mgr_fini(struct amdgpu_profiler_mgr *prof_mgr,
--
2.34.1

