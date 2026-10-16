Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0362DCC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 02:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3860410E297;
	Fri, 16 Oct 2026 02:49:28 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A5B310E1D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 02:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWplZWi24kqlGVOtBFC34Pvsf0sYXbNNtjJDSPDW98FE7bQhTg/lE/qKctWtSLKvOz0S8v9j58QBW2OrX+gISPFIN7XI12qRWnypYWGcqBIInpI4JchprYwTE8Yh81TmT6oWKsgfPgQ2lfP3v5v08hC7PdibSJ0ffFIf2iKv6vqcmtv3tO2zwTPpuwD4Cf9fXrN8SR5/kwAcyhDFZ2oVvqMES2+IUllkbapNCieRMQP33BFQ11Ng8ogZIGk19r5wU0lJml3X78z3vmgmTmpjN/3MDdUPcYvYMaTg+2n3b7U/6JzPLFRh/ouroCQlPCGZE3ijgJrUAjZaJIDBSCNnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p32DgZW2pULuzMlZqDrb/kkkaSVZN/8nweB9uhSHHIg=;
 b=olOu7XndJzMv1gQNCvJfkFS7ce8P9btXq8EG6dfxYzZ74Gzky0Q9gxfiQR76AF//j2S0ejrFDZPiS7s0e/uIP1CbT7b0kSJx6UUrW3NX1uqFYkbRU8a0aK5VMMWN2dXDUoHiUEbhy0YhRCT5ctghUAxL4LhQzZ8FyXREF/74Q3a9TilRGpvVj85dnLGtI9TX77JxiZQZgzUEaSMQzt6vom+bICA2wEos44OjwKGG1wvKpBf2uSTPWv39GmtJlcrToAcf59Z7oIxc0WGwIG/l8ErrOrFAw2rvz/gQqzl6jvJg6AqkaFaRsZfRmW7uOjrx2NOg6x8i2X7SHt45I+jj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p32DgZW2pULuzMlZqDrb/kkkaSVZN/8nweB9uhSHHIg=;
 b=OibQY+xcPUWN3zhmS0cvsE6KdoCoB2bH7Qw/VrH0EytTiT2UsHAb3CfgZ93QfEvM8wyd6tRJqFa/gmPaoOOgJXZ35gW23xZ9U1aTdDmKYT45httw8CJvEfkuGWsuDmGHm959alOu+S01UEdHlbJwPVp3yBrq1zDcUady+FOnsVk=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by DS0PR12MB999105.namprd12.prod.outlook.com (2603:10b6:8:301::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 02:49:16 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0522.011; Fri, 16 Oct 2026
 02:49:16 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Stamenkovic, Strahinja"
 <Strahinja.Stamenkovic@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: reapply umd profile state after recovery
Thread-Topic: [PATCH v2] drm/amd/pm: reapply umd profile state after recovery
Thread-Index: AQHdXQ1irO0bVhRwC0irFPqpQ0s707b/ccIw
Date: Fri, 16 Oct 2026 02:49:16 +0000
Message-ID: <MW4PR12MB68037B7C36FE118060D1C99F8E9B2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20261016012614.2812170-1-kevin.wang@amd.com>
In-Reply-To: <20261016012614.2812170-1-kevin.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-16T02:27:47.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|DS0PR12MB999105:EE_
x-ms-office365-filtering-correlation-id: 2b6e7fb6-140b-40da-4fd4-08df2b3011be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|261009223027099003|56012099006|11063799006|261009221227099003|10067099003|18002099003|22082099003|6133799003|260925021311599003|260925022911599003|260925021911599003;
x-microsoft-antispam-message-info: E2DhtYUXKskIm33mMYg7D/L4zsKeQV6t2ZgODkZ8oc0+Y/gGYLLpoNtcEdCnWmNeazvZoqBAEptMbFc9UvI9FfZ0OQH5GqHSrJX3+MJD0aUWptq/sB1FPYGICW4lP2nEb6cdbQP5bMle9l2gJdRE5c9wgQ9P/SCmTiQJpETuTtiP5tbjyuyAHb8meBOayaHuGPD/E1CBfOH6kf/HlamX1lQYN3+PIl0VTDJ0VnGrj7eMqFq8d8rwcZGRKJIOckU/r6DVYWmCqzkccIqKuWfG+76yHbkT8B3YUSr1azFPP1ZGAvRVTiubd4FrVNDdGz8cRHZC/xOy6+YGfQXLGfiW7DSx0LhBhJ70KgthPAzIW0qlfhzD2OkiaZW+UabXwvrAetyItxApuo+29+EnFDuYK1znl7r5EblI+xuG9eX+RJ3G/NWLBnlVEiwimCNYIjKfVfyAsvZ47/mGflXoToxiuZYaEsl+zLCBbbaIJGV6cqHhPrePe7cc+aSh/U+DjUz81CcyGqDk6UWcQnZjBHTf0kl++B7jbyTcpSIECNhUiMGaYB3+NadZ7aP+xq3B/67v2DDySvHF73TPdf3iJt052Qe91vBwBz07V5ayHf1K8wV6tKmXGtYMeDmP5WGaPRcoEmMwK6EmOOuUa0UsQ7FWLJbjYZ4dyuad5VkxlTYRgnNOi0TzEsHOjJqcjq1bZ7ErSAVznz0DKmDL5VIBxe2csXwCPWuMX7Cx5BZ7kobxNmY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(261009223027099003)(56012099006)(11063799006)(261009221227099003)(10067099003)(18002099003)(22082099003)(6133799003)(260925021311599003)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cd8EtjWB1pOrXTqwXAlW81O/rRJmiNKIkGGca9hLvBrltvv1u+aQ5vBcjR1/?=
 =?us-ascii?Q?XHY7SEBgVtxX9Gd4PByiJR2WCLViSquQmtziLdaEUFwnFJ+moSqBYZD92mIK?=
 =?us-ascii?Q?T07F8iO15gamdZsUcf87hLXgDqwbvemSWcKgvPWJg/XYPJz7lU+pUb8T60MC?=
 =?us-ascii?Q?ry4qK8hKhTE+3DxwiGjtc4/r/dBL25qC1cWoskkVQlCa1AQsOrDyqDkr1/Oa?=
 =?us-ascii?Q?4VwMKNFJ8GMf8OTpDSMmhClqcMQsfxU8HG8UydDWGg7wySWri7lsMMTv6aNt?=
 =?us-ascii?Q?wsAfwlEeesIQYSeGBkZ850lbAmM037EpYUja3djE5OUe8oIJHQRXhMzq7xa3?=
 =?us-ascii?Q?cX5IWHUjmncYGpJH+Toco2LI4fhZw3il5boLoHrm5WVYRvyzwiWCyRY/5PKK?=
 =?us-ascii?Q?6dTnkc/qyA6LWO35a8hlNQV5QfgOtJVw5fNYFoD2Qsix5xAFSBXWGSy29P2y?=
 =?us-ascii?Q?ZH9EFwgyGgrVdxdNC7LdS3WToUQvwMeLlJmU4EpnHDxfJt1M+ubgKueoKMjB?=
 =?us-ascii?Q?U0iiy99yh2Fd2VyVNTnqFAfG817qsd4WViQeubBHZCO1DZiTJiDc1nowqs6E?=
 =?us-ascii?Q?KTg5/8s/QoqBvUTevar+GIROmmBnT0wKYAXal1ohE2O3ih7gUPHZShMfGzma?=
 =?us-ascii?Q?hk7U23uTJPw0ifqQg0vXBD4UDj7ONWdAXSFiT7KaRfihUL+ujcRrygs6eMmy?=
 =?us-ascii?Q?iy/QEzIAHzGx1MR9W5ikDBTOsXxBbz9NrbEnAd50e2n6F4kp13+8n3iTiwQp?=
 =?us-ascii?Q?xht9V9vH1fNJD1HNHiXt2VhrP4Dni49cykRrN9cmjQPyRqFVBtVZfAUKTfCx?=
 =?us-ascii?Q?3q94H1PW1pbULA3GxStovCRHNNwmgPat3zpkBoK0WaL5Cb0Z8+Cqqc0zoIFe?=
 =?us-ascii?Q?JZuputEU2YdOuH3sPAF4zWJKwfakgTK1Y4dwAkDR6k2kxL/AkfBUXdu1lQnO?=
 =?us-ascii?Q?n/ZrE1FPJ0hUg++fjcfkKZUN2KCnbAkJOM9hDTckUrJG8NIqj2dO0wNskWrs?=
 =?us-ascii?Q?XUYeVaDS54PjG1vTc9xGM8Jt4VTtpZbGwYXntm+pdjKQAaoBkZBwIJ/YGvZd?=
 =?us-ascii?Q?btNT2jLGxFVc1NHlJXMCzblvoA/6Ir/qRkHIb22t5BI7fqVNzezsCriQy0la?=
 =?us-ascii?Q?oW1PT5mTBKnI9qwJNPMEQVtTJt85m3q95orptNyVMBgcG0ZISqOEqVjFbZy3?=
 =?us-ascii?Q?QdQVSf6fsJ01FyucIHsRf2z3ivjXeDEjLkdYRjg2vO4uTehg4B656TEb/Gfp?=
 =?us-ascii?Q?o+WYmDPLXRRtUGL0ZhrQ0Ui2aE1aUJssShxjdT836Mv/j2nYpp2JD33AvV3e?=
 =?us-ascii?Q?sBisuITdyK2ejhm7M/sYyZgL0IpKwGhGmswxMcQghIq0jdTzJcqsJKnF8Tgb?=
 =?us-ascii?Q?25dvQrlUbzRx1GfI6YkfQ4aQ5A7sZJ7wZktkIfxCs66LGET0Xm7yW/iefg8R?=
 =?us-ascii?Q?It4XaYLiYDDQS3Yky+qyKopLRU4eyqCSgNTitlEbc16fHDOy3FOoW9QiEcmV?=
 =?us-ascii?Q?ATzJ4atAHXzNzZcMlSO1IGKSzsXLN4XPcCdRYQaexGZi/GxM+kxL/kP8vY28?=
 =?us-ascii?Q?c46KPNrYBYBaFBgtnz68MXIDMaIhKTXkuQODHj3Mti6t6Ztxbo3OqEpAczOO?=
 =?us-ascii?Q?IucVMVBsP8XkVoV+iXHeI816pXVbgpj4Qm8GZpBTDEsyIP6U4VsENkhcHegS?=
 =?us-ascii?Q?1MQmdB1I0NFstLtpfsyFbq0MrG1wva3dsGFNvSaqNeppEGRM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6e7fb6-140b-40da-4fd4-08df2b3011be
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 02:49:16.5528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7Gc/je015cl2Sp/3hpHMe5QVHtrDb9Nj+m3oV7YVKGDfisIm/8GiKppc94hBYyo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999105
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Wang, Kevin <Kevin.Wang@amd.com>
Sent: Friday, October 16, 2026 9:26 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Stamenkovic, Strahin=
ja <Strahinja.Stamenkovic@amd.com>
Subject: [PATCH v2] drm/amd/pm: reapply umd profile state after recovery

Resume and full GPU reset retain the selected UMD profile level in driver s=
tate.
The GFX and PMFW state behind it is reinitialized.

Add a generic DPM reapply path after CG and PG restoration.
It restores the UMD GFX state and asks the PM backend to replay the retaine=
d level.

v2:
- Reapply only GFX CG to preserve the profile-owned GFX PG reference.
- Fall back to AUTO when reapply fails without failing device recovery.
- Propagate PowerPlay DPM errors before accepting AUTO fallback.
- Limit workload-profile error reporting to the swSMU reapply path.

This covers:
- PCI runtime resume
- Full GPU reset recovery
- System resume, including S3 and s2idle

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 14 ---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 85 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 33 +++++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 87 +++++++++++++++++--
 7 files changed, 201 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 96cb4d34157e..b74f9136aa2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2774,6 +2774,12 @@ static int amdgpu_device_ip_late_init(struct amdgpu_=
device *adev)
        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
        amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);

+       r =3D amdgpu_dpm_reapply_umd_profile(adev);
+       if (r) {
+               dev_err(adev->dev, "Failed to restore UMD profile state: %d=
\n", r);
+               return r;
+       }
+
        amdgpu_device_fill_reset_magic(adev);

        r =3D amdgpu_device_enable_mgpu_fan_boost();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 2712580a5663..d4267358156a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2987,19 +2987,6 @@ static int amdgpu_pmops_runtime_suspend(struct devic=
e *dev)
        return 0;
 }

-static void amdgpu_restore_umd_profile_pstate_after_runpm(struct amdgpu_de=
vice *adev) -{
-       enum amd_dpm_forced_level level;
-       uint32_t profile_mode_mask =3D AMD_DPM_FORCED_LEVEL_PROFILE_STANDAR=
D |
-               AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
-               AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
-               AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
-
-       level =3D amdgpu_dpm_get_performance_level(adev);
-       if (level & profile_mode_mask)
-               amdgpu_asic_update_umd_stable_pstate(adev, true);
-}
-
 static int amdgpu_pmops_runtime_resume(struct device *dev)  {
        struct pci_dev *pdev =3D to_pci_dev(dev); @@ -3045,7 +3032,6 @@ sta=
tic int amdgpu_pmops_runtime_resume(struct device *dev)
        if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
                drm_dev->switch_power_state =3D DRM_SWITCH_POWER_ON;

-       amdgpu_restore_umd_profile_pstate_after_runpm(adev);
        adev->in_runpm =3D false;
        return 0;
 }
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index ca818965afe1..7db44fa24042 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -449,6 +449,8 @@ struct amd_pm_funcs {
        int (*print_clock_levels)(void *handle, enum pp_clock_type type, ch=
ar *buf);
        int (*emit_clock_levels)(void *handle, enum pp_clock_type type, cha=
r *buf, int *offset);
        int (*force_performance_level)(void *handle, enum amd_dpm_forced_le=
vel level);
+       int (*reapply_performance_level)(void *handle,
+                                        enum amd_dpm_forced_level level);
        int (*get_sclk_od)(void *handle);
        int (*set_sclk_od)(void *handle, uint32_t value);
        int (*get_mclk_od)(void *handle);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 0394085a0328..75d8bb4868e8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1082,6 +1082,91 @@ static void amdgpu_dpm_exit_umd_state(struct amdgpu_=
device *adev)
                                               AMD_PG_STATE_GATE);
 }

+/**
+ * amdgpu_dpm_reapply_umd_profile - Restore the active UMD profile
+ * @adev: amdgpu device
+ *
+ * Resume and reset retain the selected DPM level in software, but the
+ * underlying GFX and PMFW state is lost. Reapply a retained UMD
+profile
+ * after the common resume path has restored its default CG and PG state.
+ */
+int amdgpu_dpm_reapply_umd_profile(struct amdgpu_device *adev) {
+       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
+       enum amd_dpm_forced_level level;
+       int ret, fallback_ret;
+
+       if (!pp_funcs || !pp_funcs->reapply_performance_level ||
+           !pp_funcs->force_performance_level)
+               return 0;
+
+       /* Serialize the retained level with the GFX and PMFW reprogramming=
. */
+       mutex_lock(&adev->pm.mutex);
+       if (adev->pm.dpm.thermal_active) {
+               dev_warn(adev->dev,
+                        "Cannot restore UMD profile while thermal control =
is active\n");
+               ret =3D 0;
+               goto unlock;
+       }
+
+       if (pp_funcs->get_performance_level)
+               level =3D pp_funcs->get_performance_level(adev->powerplay.p=
p_handle);
+       else
+               level =3D adev->pm.dpm.forced_level;
+
+       switch (level) {
+       case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+       case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+               break;
+       default:
+               ret =3D 0;
+               goto unlock;
+       }
+
+       /* The active profile already owns the GFX PG reference. */
+       ret =3D amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_T=
YPE_GFX,
+                                             AMD_CG_STATE_UNGATE);
+       if (ret)
+               goto fallback_auto;
+
+       ret =3D amdgpu_asic_update_umd_stable_pstate(adev, true);
+       if (ret)
+               goto fallback_auto;
+
+       ret =3D pp_funcs->reapply_performance_level(adev->powerplay.pp_hand=
le,
+                                                    level);
+       if (ret)
+               goto fallback_auto;
+
+unlock:
+       mutex_unlock(&adev->pm.mutex);
+
+       return ret;
+
+fallback_auto:
+       dev_warn(adev->dev, "Failed to restore UMD profile state: %d\n", re=
t);
+
+       /* Restore normal CG before releasing the profile's PG reference. *=
/
+       amdgpu_asic_update_umd_stable_pstate(adev, false);
+       amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+                                              AMD_CG_STATE_GATE);
+       mutex_unlock(&adev->pm.mutex);
+
+       mutex_lock(&adev->pm.stable_pstate_ctx_lock);
+       fallback_ret =3D amdgpu_dpm_force_performance_level(adev,
+                                                  AMD_DPM_FORCED_LEVEL_AUT=
O);
+       if (fallback_ret)
+               dev_warn(adev->dev, "Failed to fall back to AUTO performanc=
e level: %d\n",
+                        fallback_ret);
+       else
+               adev->pm.stable_pstate_ctx =3D NULL;
+       mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
+
+       return 0;
+}
+
 int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
                                       enum amd_dpm_forced_level level)  { =
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_dpm.h
index 72b13ece22ef..ba8624d28f28 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -484,6 +484,7 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *a=
dev,  enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amd=
gpu_device *adev);  int amdgpu_dpm_force_performance_level(struct amdgpu_de=
vice *adev,
                                       enum amd_dpm_forced_level level);
+int amdgpu_dpm_reapply_umd_profile(struct amdgpu_device *adev);
 int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
                                 struct pp_states_info *states);
 int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev, diff --git a/driv=
ers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/power=
play/amd_powerplay.c
index 239c64b8edca..7b0ff5a0993e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -358,24 +358,46 @@ static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hw=
mgr,
        }
 }

-static int pp_dpm_force_performance_level(void *handle,
-                                       enum amd_dpm_forced_level level)
+static int pp_dpm_apply_performance_level(struct pp_hwmgr *hwmgr,
+                                         enum amd_dpm_forced_level level,
+                                         bool reapply)
 {
-       struct pp_hwmgr *hwmgr =3D handle;
+       int ret;

        if (!hwmgr || !hwmgr->pm_en)
                return -EINVAL;

-       if (level =3D=3D hwmgr->dpm_level)
+       if (!reapply && level =3D=3D hwmgr->dpm_level)
                return 0;

        pp_dpm_en_umd_pstate(hwmgr, &level);
        hwmgr->request_dpm_level =3D level;
-       hwmgr_handle_task(hwmgr, AMD_PP_TASK_READJUST_POWER_STATE, NULL);
+       ret =3D hwmgr_handle_task(hwmgr, AMD_PP_TASK_READJUST_POWER_STATE, =
NULL);
+       if (ret)
+               return ret;
+
+       ret =3D phm_force_dpm_levels(hwmgr, level);
+       if (ret)
+               return ret;
+
+       hwmgr->dpm_level =3D level;

        return 0;
 }

+static int pp_dpm_force_performance_level(void *handle,
+                                       enum amd_dpm_forced_level level)
+{
+       return pp_dpm_apply_performance_level(handle, level, false); }
+
+static int
+pp_dpm_reapply_performance_level(void *handle,
+                                        enum amd_dpm_forced_level level)
+{
+       return pp_dpm_apply_performance_level(handle, level, true); }
+
 static enum amd_dpm_forced_level pp_dpm_get_performance_level(
                                                                void *handl=
e)
 {
@@ -1536,6 +1558,7 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D {
        .load_firmware =3D pp_dpm_load_fw,
        .wait_for_fw_loading_complete =3D pp_dpm_fw_loading_complete,
        .force_performance_level =3D pp_dpm_force_performance_level,
+       .reapply_performance_level =3D pp_dpm_reapply_performance_level,
        .get_performance_level =3D pp_dpm_get_performance_level,
        .get_current_power_state =3D pp_dpm_get_current_power_state,
        .dispatch_tasks =3D pp_dpm_dispatch_tasks, diff --git a/drivers/gpu=
/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3cdf7d1e8d5b..1915413ccac3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2398,6 +2398,13 @@ static int smu_set_powergating_state(struct amdgpu_i=
p_block *ip_block,
        return 0;
 }

+static void smu_enter_umd_pstate(struct smu_context *smu) {
+       smu_gpo_control(smu, false);
+       smu_gfx_ulv_control(smu, false);
+       smu_deep_sleep_control(smu, false);
+}
+
 static int smu_enable_umd_pstate(void *handle,
                      enum amd_dpm_forced_level *level)  { @@ -2416,9 +2423=
,7 @@ static int smu_enable_umd_pstate(void *handle,
                /* enter umd pstate, save current level, disable gfx cg*/
                if (*level & profile_mode_mask) {
                        smu_dpm_ctx->saved_dpm_level =3D smu_dpm_ctx->dpm_l=
evel;
-                       smu_gpo_control(smu, false);
-                       smu_gfx_ulv_control(smu, false);
-                       smu_deep_sleep_control(smu, false);
+                       smu_enter_umd_pstate(smu);
                        amdgpu_asic_update_umd_stable_pstate(smu->adev, tru=
e);
                }
        } else {
@@ -2477,7 +2482,8 @@ static void smu_power_profile_mode_put(struct smu_con=
text *smu,

 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
                                          enum amd_dpm_forced_level level,
-                                         bool skip_display_settings)
+                                         bool skip_display_settings,
+                                         bool force_performance_level)
 {
        int ret =3D 0;
        struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm); @@ -2504,7=
 +2510,7 @@ static int smu_adjust_power_state_dynamic(struct smu_context *s=
mu,
                }
        }

-       if (smu_dpm_ctx->dpm_level !=3D level) {
+       if (force_performance_level || smu_dpm_ctx->dpm_level !=3D level) {
                ret =3D smu_asic_set_performance_level(smu, level);
                if (ret) {
                        if (ret =3D=3D -EOPNOTSUPP)
@@ -2527,6 +2533,39 @@ static int smu_adjust_power_state_dynamic(struct smu=
_context *smu,
        return ret;
 }

+static int
+smu_reapply_power_state_dynamic(struct smu_context *smu,
+                               enum amd_dpm_forced_level level)
+{
+       struct smu_dpm_context *smu_dpm_ctx =3D &smu->smu_dpm;
+       int ret;
+
+       ret =3D smu_apply_clocks_adjust_rules(smu);
+       if (ret) {
+               dev_err(smu->adev->dev, "Failed to apply clocks adjust rule=
s!");
+               return ret;
+       }
+
+       ret =3D smu_asic_set_performance_level(smu, level);
+       if (ret) {
+               if (ret =3D=3D -EOPNOTSUPP)
+                       dev_info(smu->adev->dev, "set performance level %d =
not supported",
+                                level);
+               else
+                       dev_err(smu->adev->dev, "Failed to set performance =
level %d",
+                               level);
+               return ret;
+       }
+
+       smu_dpm_ctx->dpm_level =3D level;
+
+       if (smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL ||
+           smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMI=
NISM)
+               return 0;
+
+       return smu_bump_power_profile_mode(smu, NULL, 0); }
+
 static int smu_handle_task(struct smu_context *smu,
                           enum amd_dpm_forced_level level,
                           enum amd_pp_task task_id)
@@ -2541,13 +2580,13 @@ static int smu_handle_task(struct smu_context *smu,
                ret =3D smu_pre_display_config_changed(smu);
                if (ret)
                        return ret;
-               ret =3D smu_adjust_power_state_dynamic(smu, level, false);
+               ret =3D smu_adjust_power_state_dynamic(smu, level, false, f=
alse);
                break;
        case AMD_PP_TASK_COMPLETE_INIT:
-               ret =3D smu_adjust_power_state_dynamic(smu, level, true);
+               ret =3D smu_adjust_power_state_dynamic(smu, level, true, fa=
lse);
                break;
        case AMD_PP_TASK_READJUST_POWER_STATE:
-               ret =3D smu_adjust_power_state_dynamic(smu, level, true);
+               ret =3D smu_adjust_power_state_dynamic(smu, level, true, fa=
lse);
                break;
        default:
                break;
@@ -2676,6 +2715,37 @@ static int smu_force_performance_level(void *handle,
        return ret;
 }

+static int
+smu_reapply_performance_level(void *handle,
+                             enum amd_dpm_forced_level level) {
+       struct smu_context *smu =3D handle;
+       struct smu_dpm_context *smu_dpm_ctx =3D &smu->smu_dpm;
+
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;
+
+       if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
+               return -EINVAL;
+
+       switch (level) {
+       case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+       case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       if (smu_dpm_ctx->dpm_level !=3D level)
+               return -EINVAL;
+
+       smu_enter_umd_pstate(smu);
+
+       return smu_reapply_power_state_dynamic(smu, level); }
+
 static int smu_set_display_count(void *handle, uint32_t count)  {
        struct smu_context *smu =3D handle;
@@ -4062,6 +4132,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs =3D {
        .force_clock_level       =3D smu_force_ppclk_levels,
        .emit_clock_levels       =3D smu_emit_ppclk_levels,
        .force_performance_level =3D smu_force_performance_level,
+       .reapply_performance_level =3D smu_reapply_performance_level,
        .read_sensor             =3D smu_read_sensor,
        .get_apu_thermal_limit       =3D smu_get_apu_thermal_limit,
        .set_apu_thermal_limit       =3D smu_set_apu_thermal_limit,
--
2.55.0

