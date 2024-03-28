Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F89CC54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 08:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8532E10EFDE;
	Thu, 28 Mar 2024 08:00:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="krPhJnce";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C9810F426
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 08:00:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL3+Ajua+ortSYRL7cNzUkp4wlBU4/0Zd0qy2i7r5iAHQULxo97GRfTdB9KrbByN/kZnP+aZRkeP2pCnkl4xcJbZyij5l33TainUGzHbd31QK3goKZAG8HPZTvRrRpTYkV4F6dGcDa8pxaTlpq5JBxwAlUqh+xAyi6llS76eET5jaTCjvYVl3XX7c+xq7ytDCtlrBdo3XGBkWlChcXeGS76Tit0ipElbN2/qqNgVKZwQnZ776M7m5LVzV6iHBpJV5g961F4JrXjIjeRfSoFfscYLFY7KFoB/A2bbeahwBmvnFRSFI08leq+zTpUiByfKIWfX0pC9aqvoQSwW88ehFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1/7YHsgYIgp/tyybhIBQAMk/xmUslRuHxasrOaKmkM=;
 b=SOBxCpGltEps6nrOxDZlX5PF6lnQ+DAwFmemuhDZPc4rKwIzvHcrX1397GOgz0aW335u7H4yaF9OKGcyNoddCsis7On5/F39nl4dUGObfmPCtFhYTLZhWx7ydqPJGGzim/UU016WpnTT6UL8VCh09XlL7ZVO2LSQ4X5Ku4Anov06mbFORS9ns4cR+r82t8j7EsSr4vbrmHyGBXNlblNhQvPPxBW3dDG7xBqcoQnWNxb8KFuP2l3LxOOi/P/pWKHUNWEi0+twYngXV6X0FZ6sWp+eCXI6s0XnB8u4fVba27JASYvXssrvnpUjtZcHbekRRKuCnbjF6waISiY6zYRZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1/7YHsgYIgp/tyybhIBQAMk/xmUslRuHxasrOaKmkM=;
 b=krPhJncesJfrV3Q7135K1dNNgc5vgt51nuZeaGZkLUJwgB6gqEVUNyG3RAwTSgSgouT9UOln5OJ6z9stAWzrI2v4sPOO/2ZH0WCjoc3GXrqAd52TSgEJBXf3HbLvSm1VGSXbcLi7xX3/pcR6OGygj9TPx5IWaRsV3YlkNFGjR4I=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 08:00:49 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 08:00:49 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix the high voltage issue after unload
Thread-Topic: [PATCH] drm/amd/pm: fix the high voltage issue after unload
Thread-Index: AQHagNVuwAnqxVJeHUaX/Xd91wIVIrFMylVA
Date: Thu, 28 Mar 2024 08:00:48 +0000
Message-ID: <BN9PR12MB5257D278E4BB4EC6432C338CFC3B2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240328060141.1966119-1-kenneth.feng@amd.com>
In-Reply-To: <20240328060141.1966119-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a775008d-c19b-4494-bb4a-a7ad599db527;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-28T08:00:29Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY5PR12MB6646:EE_
x-ms-office365-filtering-correlation-id: e6822226-b187-4a89-d394-08dc4efd2e4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XEVJE8xEZ+Ljj/ue8mal29PFAetixZh+4jsUaadfwcyQqeS8js+VCG/y40C05UWF4LJHEJsTYJ/CqFiLdw6g2ly3NUr5J/aii++xxD9IZtRvzCCuBLOkoVoFhBE/MygHNMQW1hfr197L/xNHkIQuWVhzXWOmD9p015dzW9AhhHzXqM4HlJb4g6RY51eCkCih6ZoCd/A7PLNKgIG0pLaWrIkOMKGa1Gl3Y5HEtIYxhmng4wpvKF/mNe/D+5aQCHhHjwCqy0j1euIDsb7CqUjUc7srkLXacJscU+QRPBVEDOiswnKp+1FDNjEe19AeHoDOgKifRg/3tQR3g2bPq1sytnZ69l56yOuu0k+siLh+YNEEWJlTp0aEDtMnwVO0ykYljyaiBjKM9JSdSrQgHLz7wVY44JtvO7EB1jxiQW5z6+SBgN7D8h4wkP54Y7OAiIWIBAUspQJOkS97QKChpCaMuaWorM/CI9IEf9EzVjZjbxiZdHyq5UfNywKRA3VSl0tYNIce9IdruwQnG01jDOTv567iqFsJXvg9IBqFmBXiEebgAoMlbI7dcfRhQ18ek9dmER/OD+HHqcICW9EeseLzKLyuoN/WIfM7p1oL/bBKxMb80bU+VyJOo1eOm+nd4NDpn2hviuuycEGUgtWGjG1rsYCf90HMTeNb/tIuSBXF+PLgaQz8U1g2jWW7uJi0AfMBKwAF8JTJS3l9SGzOHTDhdLo5xezOHYWzFxnOwfRXbg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m9W6a/SiH8lmkoVHUoNPmvKwHZDRj7YSMvk1yZl4u3PTKsXKXnJ6C9VYEp5O?=
 =?us-ascii?Q?GVV0Agmx07gjn85h3fnZ9GcROmfVzJDmV14ZPmYbXUvIQ9iHsbXnR0kwNu2P?=
 =?us-ascii?Q?MBaSpWa6pmYun2nhRjFBkILVWn8jiqgKEhh11oTheY1c387COGlvTxxW0bPR?=
 =?us-ascii?Q?nz5L7ihgZHOe19WBjLdkrjsBjJ5ivvruon+zOP9ML5y2OAJXn1fKHYSyTxQy?=
 =?us-ascii?Q?Ellyw+E3GQaLFaHP2loqSBZRZdKe7pAdOsWzGuNBO1VjaQqlWmh6X32b/6uD?=
 =?us-ascii?Q?dYc/+7p0OWLBsdN5QkyRfAlfVZTRfHL2DZXNhRMdvLu+F+cSGzsNbjYjM99Q?=
 =?us-ascii?Q?zvQnn9yqhU2xOUHDX3OYHUaQ2uSWVedlEpY8l4DAla5llFbnU8jy70yx14lO?=
 =?us-ascii?Q?hQgkOYsC/Xrhado449CsgPaBcH6776u/2vbTqjO9Owk5bIO915ecBSE1fsa1?=
 =?us-ascii?Q?I8EEgSlrUUfdD0CzNESY8b1H1e6B3RNLzEh6JOqkqeLmg7mBt9Qqz7mx04xJ?=
 =?us-ascii?Q?J0fbe0d+9EZGPzNe9YKhtmKZI0N4vEq2uICDD5XMc+l3tLJS/ivsxQVneGIM?=
 =?us-ascii?Q?kvuS9D2SdyDu5dIPcj8H4xg4lZCqH5/T0xfGN/butqyW6j+aqcao2x3s+yKl?=
 =?us-ascii?Q?mTSZk0itsofpdcryBj+pq53I01YFXJZbbv3mdqx6R//MBx1ithDO1N8+Wc0S?=
 =?us-ascii?Q?BBGETUu7RkmgvSgRS04qbTFlcRjqTzEvDaR//2a8mLL8vGKfsUE9u/n3VJpm?=
 =?us-ascii?Q?r/biO3dqKXBZNBB8jXy0EAx6tEbsuIIWQbrkywQHhZHk8H4YKFjxUcEvJxXG?=
 =?us-ascii?Q?oARo1X8BwYk0Px6zisfAH+BVu8o91d6DAxqzLHVy84enW4Q/fOe92SQOsHwp?=
 =?us-ascii?Q?fWXfsKfskrPESsC2umeDLplwLEz//brH00N6TS7icchHfCiSDENDuQxqXBhA?=
 =?us-ascii?Q?qFf6gLfJvL4e0FRnQC9kRHloHF0RSqNdIvhz6DWcIQgnUk4azkYLduSLBk7Q?=
 =?us-ascii?Q?hBPWDlx62Cf7Wqwk87xqgqMJw9RJ/H3DuBCefGGAOy2EgV+2/Lg1iceAAMnh?=
 =?us-ascii?Q?fyMDHY7oKZGiO8+IEHkCg4tX+3VLRWMZD1G6Nf278Zz+i9XWP5sO1Gq+UsgO?=
 =?us-ascii?Q?8J76EjfgiLnqHEa0zqh/qrEoA8EQB48zQ2U2XL0KnyUq1EDuhGphJoj3p0zP?=
 =?us-ascii?Q?yDOjRdIB7PavoKHkZ10WCu0AHZeducIsFt0ljcVXGuHRym0VzVMddY4LsR55?=
 =?us-ascii?Q?RmUxVm4iT8pzcWZG6tzuitILN2Z9UrX86doBluRXLc600ORwjvi8/guMyM5c?=
 =?us-ascii?Q?OiDiscOFk8v9u0RQ9uoG9z0dWxM57aPrUfCfc3+0grP3jLEATGJw+oh0il01?=
 =?us-ascii?Q?QG+BqxGePFqPPBhMJEkfSuKc29wW2fEpxes1E5wmEjJqVvLAZcFp18ppu2Ir?=
 =?us-ascii?Q?UQzEEXogopeSDEqnSavCd4cFoq2Q8WVZLOlDw1aTEhXJ/gS6OPSfaoVWjbDC?=
 =?us-ascii?Q?HH+xabhs2OAlT5zVqfWdcQxK7RZHVplJ1Mr6vqYTh15AUb6P8EJ1IKt+Ksli?=
 =?us-ascii?Q?P4IPiESdqUsdBA+b5FA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6822226-b187-4a89-d394-08dc4efd2e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 08:00:49.0044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cp+6yX8Bi2Z5gxAOOqVTMvY3jB7nNcZYXNJ+TgXcWXF+RWT+4KPOcrwZV6L3cbqHs46kFxKAAyiJZGx5rFMOKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Thursday, March 28, 2024 14:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd=
.com>
Subject: [PATCH] drm/amd/pm: fix the high voltage issue after unload

fix the high voltage issue after unload on smu 13.0.10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 26 ++++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 27 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +  .../drm/amd/pm/swsmu=
/smu13/smu_v13_0_0_ppt.c  |  8 +++++-
 4 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 12dc71a6b5db..1b9136bb7f62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4138,18 +4138,22 @@ int amdgpu_device_init(struct amdgpu_device *adev,
                                        adev->ip_blocks[i].status.hw =3D tr=
ue;
                                }
                        }
+               } else if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_V=
ERSION(13, 0, 10) &&
+                                  !amdgpu_device_has_display_hardware(adev=
)) {
+                                       r =3D psp_gpu_reset(adev);
                } else {
-                       tmp =3D amdgpu_reset_method;
-                       /* It should do a default reset when loading or rel=
oading the driver,
-                        * regardless of the module parameter reset_method.
-                        */
-                       amdgpu_reset_method =3D AMD_RESET_METHOD_NONE;
-                       r =3D amdgpu_asic_reset(adev);
-                       amdgpu_reset_method =3D tmp;
-                       if (r) {
-                               dev_err(adev->dev, "asic reset on init fail=
ed\n");
-                               goto failed;
-                       }
+                               tmp =3D amdgpu_reset_method;
+                               /* It should do a default reset when loadin=
g or reloading the driver,
+                                * regardless of the module parameter reset=
_method.
+                                */
+                               amdgpu_reset_method =3D AMD_RESET_METHOD_NO=
NE;
+                               r =3D amdgpu_asic_reset(adev);
+                               amdgpu_reset_method =3D tmp;
+               }
+
+               if (r) {
+                 dev_err(adev->dev, "asic reset on init failed\n");
+                 goto failed;
                }
        }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 246b211b1e85..65333141b1c1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -735,7 +735,7 @@ static int smu_early_init(void *handle)
        smu->adev =3D adev;
        smu->pm_enabled =3D !!amdgpu_dpm;
        smu->is_apu =3D false;
-       smu->smu_baco.state =3D SMU_BACO_STATE_EXIT;
+       smu->smu_baco.state =3D SMU_BACO_STATE_NONE;
        smu->smu_baco.platform_support =3D false;
        smu->user_dpm_profile.fan_mode =3D -1;

@@ -1966,10 +1966,25 @@ static int smu_smc_hw_cleanup(struct smu_context *s=
mu)
        return 0;
 }

+static int smu_reset_mp1_state(struct smu_context *smu) {
+       struct amdgpu_device *adev =3D smu->adev;
+       int ret =3D 0;
+
+       if ((!adev->in_runpm) && (!adev->in_suspend) &&
+               (!amdgpu_in_reset(adev)) && amdgpu_ip_version(adev, MP1_HWI=
P, 0) =3D=3D
+                                                                       IP_=
VERSION(13, 0, 10) &&
+               !amdgpu_device_has_display_hardware(adev))
+               ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
+
+       return ret;
+}
+
 static int smu_hw_fini(void *handle)
 {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
        struct smu_context *smu =3D adev->powerplay.pp_handle;
+       int ret;

        if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
                return 0;
@@ -1987,7 +2002,15 @@ static int smu_hw_fini(void *handle)

        adev->pm.dpm_enabled =3D false;

-       return smu_smc_hw_cleanup(smu);
+       ret =3D smu_smc_hw_cleanup(smu);
+       if (ret)
+               return ret;
+
+       ret =3D smu_reset_mp1_state(smu);
+       if (ret)
+               return ret;
+
+       return 0;
 }

 static void smu_late_fini(void *handle) diff --git a/drivers/gpu/drm/amd/p=
m/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index a870bdd49a4e..1fa81575788c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -424,6 +424,7 @@ enum smu_reset_mode {  enum smu_baco_state {
        SMU_BACO_STATE_ENTER =3D 0,
        SMU_BACO_STATE_EXIT,
+       SMU_BACO_STATE_NONE,
 };

 struct smu_baco_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 5a857cb999f5..f4df4cceb06f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2752,7 +2752,13 @@ static int smu_v13_0_0_set_mp1_state(struct smu_cont=
ext *smu,

        switch (mp1_state) {
        case PP_MP1_STATE_UNLOAD:
-               ret =3D smu_cmn_set_mp1_state(smu, mp1_state);
+               ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                                                          =
               SMU_MSG_PrepareMp1ForUnload,
+                                                                          =
               0x55, NULL);
+
+               if (!ret && smu->smu_baco.state =3D=3D SMU_BACO_STATE_EXIT)
+                       ret =3D smu_v13_0_disable_pmfw_state(smu);
+
                break;
        default:
                /* Ignore others */
--
2.34.1

