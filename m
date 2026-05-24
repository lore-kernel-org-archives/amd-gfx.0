Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB5ACD5BAB
	for <amd-gfx@archiver.kernel.org>; Sun, 24 May 2026 11:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C9B10E0DD;
	Sun, 24 May 2026 11:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QYhmRmnc";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012029.outbound.protection.outlook.com
 [40.107.200.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73ACE10E0DD
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 May 2026 11:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWb2CAm2WphMGnwWUIlCIcpyY4/dlYeckLneivGwmjVTroSBf/1Pj5SNh31iJTVTDL1Ic4A0Y3ygXysvkRiwwL1OprXUnYpDpFnQYD1+DdWP5vmCDm8WENJzxMu/hik2FZ1SpS1aW/GipxbVwEpNfWoSlol4PRTp4MG6CnB+4aFI1iNMCDXmYC9p0ByfytLSXKO3fIDysNkzLZrjG96Zwlurf1TbLpe7vEYJ3b3MVKg+joXKpGuRAKmJsdaIifPJnlR2lNeW8/ttt1Cf34awU2VZIaxEE2eUuAbjN02sfbnh1NLBK6b93vBhz8FWcQRHSwOZ8fLR3qZFMPMRM6LSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekrWD0UAvLipLyyp+TnzSfDYz2FlwRro99zeRAcLdog=;
 b=N+Xml4FHFdp1nubrecbIkJWEyoufkx5jSN6pGi3GegArBJm5P7oGP3enoNQwG7WeXMRxwWWeRvI9zI7CPJVmpUHdbwNCdpQPJ7dYzQIUjnAEAPVt1hD2sZRkZxvCx6jwQdShCLhu+VxbVlQPcDcby8Q8HJD3EeyZqP/XOh0iFc35SLlVwFx4t3ysn44ci4oGsB/2A9SLva3FJPswsk5BoxKUpGYo3SvGHEEMRjTJ6/2V15Bc0z9L7JvruG+G4licCYSRCpemiReLiKlUaD1ZlC9aUVq58v0oXi/+XTnC2+HsW/8Ve7XDJJEcdnpQikHN7sGMOaJVPnpZT9Q6gve1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekrWD0UAvLipLyyp+TnzSfDYz2FlwRro99zeRAcLdog=;
 b=QYhmRmncPt2JRdCc4NaXmSCHSmmP4njY3dRicm1QuaVjSHHhPlOriearWtSNCTV2qSUOj9fVXMqXQOdE8/RHtfjnc6ZmX6dNY1NKt+E7BRscepPoAaNsoHIqxDeapeu7zt06O4CcDlMcsZz8VJySu+2xi6bf9r4LvOJuLaXRaAc=
Received: from IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sun, 24 May
 2026 11:17:46 +0000
Received: from IA1PR12MB6356.namprd12.prod.outlook.com
 ([fe80::ff6d:9e44:521d:dda3]) by IA1PR12MB6356.namprd12.prod.outlook.com
 ([fe80::ff6d:9e44:521d:dda3%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 11:17:45 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yat Sin, David" <David.YatSin@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v4] drm/amdgpu: add ioctl to handle RAS poison error
Thread-Topic: [PATCH v4] drm/amdgpu: add ioctl to handle RAS poison error
Thread-Index: AQHc6QDwKUAEe9DfbUKbzd1DfATuVrYdC8RQ
Date: Sun, 24 May 2026 11:17:45 +0000
Message-ID: <IA1PR12MB6356564293C123C66AF6EB6CC10D2@IA1PR12MB6356.namprd12.prod.outlook.com>
References: <20260521090445.2292040-1-yifan1.zhang@amd.com>
In-Reply-To: <20260521090445.2292040-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-24T11:17:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6356:EE_|PH7PR12MB8428:EE_
x-ms-office365-filtering-correlation-id: 22a3123c-0e14-4a3a-7c94-08deb98614ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|38070700021|6133799003|11063799006|3023799007;
x-microsoft-antispam-message-info: q++l+ZJRBOZvYos3Fuklf1eiM/r1nNH0abik6YZZKO4uQdTkT19JwBrGY5mwVLGJcid2Tc9Cd6fBmPdW7Bj+2TD5UZ+IQba4syXISqvbB07UbkGMWBGJtbNcPrdUSirGL7meefAEERBr+6Vz63YYoC5xKYfPQ4iWt69LUgpSjJq2QK4yMDQOg6I3tVgDAgV0tC7JugV3AsypAYh4asUQlHVK52zIJQgL6UjQEcQSMOkG7HhX5LXmDB69Rkr+vNBV2oNIArlJWwM9Ln/0HnasJRZ8GAxpwyHI/Yl7yYBOYYCOC6BTGA2OEf/uuY1Nn4yQvNSD2vih8Qg+Z+4/AHe2VM9nWFmdbzMhqqfr1Gjl5egp5QzP0XPuMfazyy2/1BIdWW0hrAaUQ9jyczsl/LRQ6I8gbSGlyZRVtt13Qr9S4sSJuG7YG8pqP8BrIEkjsXaKpC9YvNJ0LxrkLTXhaJBMnbzn7CJTOh5c5hpAxDlBh+gKAHE0LvecjYmElu3AAhvL7qNxNe+CyRYP9EYTgrxLtBUazaH3Y8LuxAErmahcu4DwgqOvKaS297FPXAsMEoWWOiuEnKLzDlb8BvRPyYmhYYOX4A2WVWa2nWhHutsNW+YwIbqaG8m6DirNdFP1RioiboqV54gTqWIbjoIrmp9g66CILNQGR2VM7wdg2eiUm0cndGquAeZqi871QNxSDgwDBDpBR1Btc0ajswrD4ixPHpMJ0Uad1Q/RG4i6i3YDHVg+lSBLJJIrDDMb7CpmRax3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(6133799003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bvS6fLzcAIzYa/An5pLYFtvYwcjS3Hd4MJNBeK/bbHmbg804TYR/Q8+RFNWn?=
 =?us-ascii?Q?tv7ByDVOCUHNE7FPwaS9qAUeewmTKJXXXM2bJMxSkWKyKEjIF6chGqD9mrZD?=
 =?us-ascii?Q?U8r+vnT2QTp2/f1RR7zJ9SCij7hmU2j3M2ZEelehanRP0wWwV3FqMzhn+yMb?=
 =?us-ascii?Q?0d9M/tIiodde0EiDgjtr/paUunyP1c+gIPy37/+grskypQP9yitYaShl9TPZ?=
 =?us-ascii?Q?PxCxVpE1QIHqc0mgZiMjkkETRTi+vzRKXvN1AnhWtFE+XzGHykMaugFFkr9n?=
 =?us-ascii?Q?GrRsoyMny+GagA/wJof/QA09X2/VWIUu6nDRGp1/a41kG1dX6zTQJt5o7l9C?=
 =?us-ascii?Q?U7/e+GkUZGWjCpGWopFjwmUMXSAoY7O6MnsVx5VsbtKPCALwkRCogLCehV+f?=
 =?us-ascii?Q?JwmAUb6dgBEmWAoi+38S1RBA2rSxX+lsv8WIqACk3p/PfF0UCWSVFfGHkQgO?=
 =?us-ascii?Q?17GqAJnb1B9Vdoylb/YBRFnxrh2R0xea02FI+/t69xcRpDWsCe9m1Kn4OSEU?=
 =?us-ascii?Q?l/l7IWDzG/cCB3repLHbvVIQIqpP7s74sB+c0GYBzWca8Vx+GsqZvY6hb1Vi?=
 =?us-ascii?Q?Nc8ebB35g7GK+/yYaVaCGGfNtqvFQSHzF+AfmEBQNX2PR1bjNXllqmkM07iO?=
 =?us-ascii?Q?mRrv2juLgF5y3Nk8iZuqDYTqwwhhI6ROrsQkUdtdecYbdp/StULKnTXZ64gY?=
 =?us-ascii?Q?9a0lbixA61d3Z/EUBD5GZ8G7gQIPH4sdV2pFQCI4yFwmW/+Uhlfr4taz3pgg?=
 =?us-ascii?Q?KVjQIPh5HuTw/eph7WPJPaWW8fyiP8C5/zS4A7s80kHdaAhKdE1KBJWXP44B?=
 =?us-ascii?Q?is+A8+j+jNMT3Wh9CpCY0BEp/tGcvWJscYDoO26Aufdd7zo1T23GLzveiyTE?=
 =?us-ascii?Q?lHgERhxVME4RV1RD2do5HHjfJWZvAkZwxmAWM/Z7cnkp9NTK5mBv21FJt5AA?=
 =?us-ascii?Q?sXQt96bvKlIYS0evrwIHlLEkorRUtU3vs5UMLZZMTCAXxvDzq5lW60t6PbYJ?=
 =?us-ascii?Q?lSB26SdKcWj32axmrHGSrJEGSinW/+a20YG35i2VgCNbOttnNwT6FD2F8xz6?=
 =?us-ascii?Q?KLkJr/MyHoVl8Z/txy5hcDtCFH2MsTHXD0OkG0Ic/zjUkQ6xgRahEX9pK+q8?=
 =?us-ascii?Q?kKryBazR/JIikPvVNKr+kPpsAk/PkKvYm4iiv0aJufUVl3XlyAifEphqPTQT?=
 =?us-ascii?Q?bjzpZ66A+EpMS6dPkN2Kc6llgd8dsC+qRH/yIlaUo7DUBwgvoq0BeROMFHjS?=
 =?us-ascii?Q?4e2obsbA8Mu+vcJM/OHf6P6Gf+mCZ5OdyZ1slDzaSCFdEVP1wxZ/nCFwcm7K?=
 =?us-ascii?Q?OlqfYEF66PzIWDqLAvD9AJjHSfxFf6+jjNMrAG+l0v1nNT2yvgSaFzazGcML?=
 =?us-ascii?Q?p44H3hiyCUpuyj4ESuhwGiXhJrBJ/YQHBRzlrbjUUEblSeQMgKCxwGZbs/jq?=
 =?us-ascii?Q?I1bdSOQoHuc/XWnqjlUHv4/tNGhIvKgazsBbjn346o1E73Nk/9ugXgtL2Bwv?=
 =?us-ascii?Q?/L7cn3L6oYXmO/jlJ1UI5x9xW+hxWoyvyjVbTgIyoNG+p98h4MVgU2kD6pFO?=
 =?us-ascii?Q?19xFstmM4tjkYb7nUtUzzp7PDj0dTMvyWy0jQ3YBbKZg2EFdHdYzxEhYbAwH?=
 =?us-ascii?Q?H9Zg0pSZrbUvVa1vUaXzrfEzWxhX5dtWEg092tW7gYbRgJhlqm8EcjGTRZj2?=
 =?us-ascii?Q?zJhWjoCt34TFiRvEi2W/hHW7yEw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a3123c-0e14-4a3a-7c94-08deb98614ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 11:17:45.6621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTOz4kKao9oV/q04US5Q3O+uEvoeGFLMOGNvpTFEoy9vtnx/FiRFYmXzoCFpSXKm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428
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

ping

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Thursday, May 21, 2026 5:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yat Sin, D=
avid <David.YatSin@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Yifan=
 <Yifan1.Zhang@amd.com>
Subject: [PATCH v4] drm/amdgpu: add ioctl to handle RAS poison error

Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the AMDGPU_USER_OPTIONS_=
OP_KFD_SIGBUS_DELAY option, allowing userspace (ROCr) to control per-proces=
s SIGBUS delivery.

Userspace for this can be found at:
https://github.com/ROCm/rocm-systems/pull/6190

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 27 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 70 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      | 14 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 23 +++++++
 include/uapi/drm/amdgpu_drm.h              | 21 +++++++
 8 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 5d7bfa59424a..771ec0608270 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1467,6 +1467,8 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc); =
 void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);  int amdgpu_info_io=
ctl(struct drm_device *dev, void *data,
                      struct drm_file *filp);
+int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
+                             struct drm_file *filp);

 /*
  * functions used by amdgpu_encoder.c
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 5333e052d56d..68d83a6e6b3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -210,6 +210,7 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_not=
ifier *mni,  int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
                                        uint32_t domain,
                                        struct dma_fence *fence);
+int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms);
 #else
 static inline
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm) @@ -=
241,6 +242,11 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *=
bo,  {
        return 0;
 }
+static inline
+int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms) {
+       return -EOPNOTSUPP;
+}
 #endif
 /* Shared API */
 int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size=
, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
index 1781c0c3d010..4d4d21babc61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3076,6 +3076,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D {
        DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, D=
RM_AUTH|DRM_RENDER_ALLOW),
        DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_A=
UTH|DRM_RENDER_ALLOW),
        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_=
ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+       DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS, amdgpu_user_options_ioctl,
+DRM_AUTH|DRM_RENDER_ALLOW),
 };

 static const struct drm_driver amdgpu_kms_driver =3D { diff --git a/driver=
s/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 24526e92f9b8..772e0fda7e14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1423,6 +1423,33 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
        return 0;
 }

+/**
+ * amdgpu_user_options_ioctl - set per-fd user options
+ *
+ * @dev: drm dev pointer
+ * @data: pointer to struct drm_amdgpu_user_options
+ * @filp: drm file
+ *
+ * Sets options stored on the per-file amdgpu_fpriv. Currently the only
+ * supported option is %AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY which
+ * controls how KFD delivers SIGBUS for poison/RAS events to the
+calling
+ * process (immediate, suppressed, or delayed by N milliseconds).
+ */
+int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
+                             struct drm_file *filp)
+{
+       struct drm_amdgpu_user_options *args =3D data;
+
+       switch (args->op) {
+       case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
+               return amdgpu_amdkfd_set_sigbus_delay(current,
+                                                     args->kfd_sigbus_dela=
y.value);
+       default:
+               DRM_DEBUG_KMS("Invalid user option op %u\n", args->op);
+               return -EINVAL;
+       }
+}
+
 /**
  * amdgpu_driver_open_kms - drm callback for open
  *
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c
index e9be798c0a2b..e7d70e3a7f3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -29,10 +29,12 @@
 #include <linux/uaccess.h>
 #include <linux/mman.h>
 #include <linux/memory.h>
+#include <linux/workqueue.h>
 #include "kfd_priv.h"
 #include "kfd_events.h"
 #include "kfd_device_queue_manager.h"
 #include <linux/device.h>
+#include <uapi/drm/amdgpu_drm.h>

 /*
  * Wrapper around wait_queue_entry_t
@@ -1337,6 +1339,72 @@ void kfd_signal_reset_event(struct kfd_node *dev)
        srcu_read_unlock(&kfd_processes_srcu, idx);  }

+/*
+ * Per-process opt-in for poison-consumption SIGBUS handling.
+ *
+ * Default: kernel sends SIGBUS to the process immediately when poison
+is
+ * consumed, in addition to delivering the KFD HW/MEMORY exception events.
+ *
+ * Userspace (ROCr) can opt-in per-process via the
+ * DRM_IOCTL_AMDGPU_USER_OPTIONS /
+AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
+ * option. This lets the app's registered system-event callback handle
+the
+ * RAS error first, instead of being killed by SIGBUS.
+ *
+ * Encoded value (stored on the kfd_process):
+ *   0          - default: SIGBUS immediately (no opt-in)
+ *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
+ *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
+ *                handle the error in time (safety timeout)
+ */
+
+static void kfd_signal_sigbus_delayed_fn(struct work_struct *work) {
+       struct kfd_process_device *pdd =3D container_of(to_delayed_work(wor=
k),
+                               struct kfd_process_device, work);
+       struct kfd_process *p =3D pdd->process;
+
+       if (p->lead_thread)
+               send_sig(SIGBUS, p->lead_thread, 0);
+
+       kfd_unref_process(p);
+}
+
+static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
+                                        struct kfd_process *p)
+{
+       struct kfd_process_device *pdd;
+       u32 delay_ms =3D atomic_read(&p->kfd_sigbus_delay_ms);
+
+       if (delay_ms =3D=3D AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) =
{
+               dev_info(dev->adev->dev,
+                        "SIGBUS suppressed for process %s(pid:%d): app opt=
ed in to handle RAS error\n",
+                        p->lead_thread->comm, p->lead_thread->pid);
+               return;
+       }
+
+       if (delay_ms =3D=3D 0)
+               goto send_now;
+
+       pdd =3D kfd_get_process_device_data(dev, p);
+       if (!pdd) {
+               dev_err(dev->adev->dev, "Process device data doesn't exist\=
n");
+               goto send_now;
+       }
+
+       /* Take an extra reference for the delayed worker. */
+       kref_get(&p->ref);
+       INIT_DELAYED_WORK(&pdd->work, kfd_signal_sigbus_delayed_fn);
+
+       dev_info(dev->adev->dev,
+                "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS erro=
r opt-in safety timeout)\n",
+                p->lead_thread->comm, p->lead_thread->pid, delay_ms);
+       schedule_delayed_work(&pdd->work, msecs_to_jiffies(delay_ms));
+       return;
+
+send_now:
+       send_sig(SIGBUS, p->lead_thread, 0);
+}
+
 void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)  {
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid, NULL);=
 @@ -1391,7 +1459,7 @@ void kfd_signal_poison_consumed_event(struct kfd_nod=
e *dev, u32 pasid)
        rcu_read_unlock();

        /* user application will handle SIGBUS signal */
-       send_sig(SIGBUS, p->lead_thread, 0);
+       kfd_signal_sigbus_with_delay(dev, p);

        kfd_unref_process(p);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index f037062c33ea..d3fcf07c0ebe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -875,6 +875,9 @@ struct kfd_process_device {
        u32 pasid;
        /* Indicates this process has requested PTL stay disabled */
        bool ptl_disable_req;
+
+       /* Delayed signal to user */
+       struct delayed_work work;
 };

 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd) @@ -=
957,6 +960,17 @@ struct kfd_process {
        size_t signal_event_count;
        bool signal_event_limit_reached;

+       /**
+        * @kfd_sigbus_delay_ms: Per-process KFD SIGBUS delivery option for
+        * poison/RAS events (set via DRM_IOCTL_AMDGPU_USER_OPTIONS /
+        * AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
+        *
+        *   0          - send SIGBUS immediately (default)
+        *   0xFFFFFFFF - suppress SIGBUS delivery
+        *   other      - delay SIGBUS delivery by this many milliseconds
+        */
+       atomic_t kfd_sigbus_delay_ms;
+
        /* Information used for memory eviction */
        void *kgd_process_info;
        /* Eviction fence that is attached to all the BOs of this process. =
The diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_process.c
index 419bb8086ccd..dadb7cf7b072 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -992,6 +992,29 @@ struct kfd_process *kfd_create_process(struct task_str=
uct *thread)
        return process;
 }

+/**
+ * amdgpu_amdkfd_set_sigbus_delay - Set per-process KFD SIGBUS delay
+ * @task: task in the target process
+ * @ms:   encoded delay value (0 =3D immediate, 0xFFFFFFFF =3D suppress,
+ *        otherwise delay in milliseconds)
+ *
+ * Stores the SIGBUS delivery option on the kfd_process associated with
+ * @task. If no kfd_process exists yet, one is created so the option
+ * persists until poison/RAS events are signaled.
+ */
+int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms) {
+       struct kfd_process *p;
+
+       p =3D kfd_create_process(task);
+       if (IS_ERR(p))
+               return PTR_ERR(p);
+
+       atomic_set(&p->kfd_sigbus_delay_ms, ms);
+       kfd_unref_process(p);
+       return 0;
+}
+
 static struct kfd_process *find_process_by_mm(const struct mm_struct *mm) =
 {
        struct kfd_process *process;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h =
index 9f3090db2f16..ab71c4b4aeac 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_SIGNAL                0x17
 #define DRM_AMDGPU_USERQ_WAIT          0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
+#define DRM_AMDGPU_USER_OPTIONS                0x1A

 #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_=
AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_USER_OPTIONS  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_USER_OPTIONS, struct drm_amdgpu_user_options)

 /**
  * DOC: memory domains
@@ -1673,6 +1675,25 @@ struct drm_amdgpu_info_uq_metadata {
 #define AMDGPU_FAMILY_GC_11_5_4                        154 /* GC 11.5.4 */
 #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.0.0 */

+/*
+ * Definition of user options
+ *
+ * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
+ *    0:          Disable sigbus delay - SIGBUS will be raised immediately
+ *    0xFFFFFFFF: SIGBUS will not be raised
+ *    other:      Set the sigbus delay in milliseconds
+ */
+#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY                0
+
+#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED  0xFFFFFFFFu
+
+struct drm_amdgpu_user_options {
+       __u32 op;
+       struct {
+               __u32 value;
+       } kfd_sigbus_delay;
+};
+
 #if defined(__cplusplus)
 }
 #endif
--
2.43.0

