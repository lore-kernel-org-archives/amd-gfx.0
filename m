Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCCCCC6B2F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 08:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984AE10E9FD;
	Thu, 15 Oct 2026 08:27:38 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D5710EB84
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 08:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwKma4rh8b06Aenni3RuWopE74J8gi2qRaEVUdrvj6A7vK5ZZsAFfdqqOHPhXGB7411ZmuQv3tKcmyFL/dX7/p3R7y0oyxk5Jew5XHGlFjFuft7vIaU61h7THCNm8JB0fpGkHdEQ+7v9O5Oa52+H5KIMMYkg2aSuxCh5e3q6GmNQHUL5kLZLRZaXMOWpIPw0BNeGHtFf3AHUgLFwzxd9CHSscvP3PL9Qdkai+j5WROti3GMlPGNmtTnZBlmy/6Sw21JR1TmVgSzCu7I0ysOgy0EXgRzjwwDhPku15ZmC3vWUj3Lg+zNLUEvHk7ltvDr1bD4bszKMNJnOtKaMtCVBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Fx4QgIaeYGcrBxiF2lMALlDNd1S18ykC5ZwGQmhlBQ=;
 b=P7wupI0PuFkzcFQUSHjZw3/9FFu2Q0d+44E5z/dDRo3VnK0P2msVmmv62uVlTaSPUuGM73bjqKYlUOLYIZWMl0dgC6oj61kYG65TLoyG6U1bwYGKIwgf0UuiqeOQUA4VLNLa4qosWiMTF08E96DLyYQX1Ah3M/OLGp8HZhjKJJc0ye9TWUxW9EKCnmTnpJU58rygfj6yhm2VquwfoOFmIHa4J7TED3n2KZhaq7HhqA6SwH4sX+67XOzF3KOwAQZEYbiREZkeEC+SBQ3peemx7z1C8Q1qtB2fysOX83hsIrAdhPlwsswnU9LZx+6eFf/RM0qr1vFWPipIT0aM7KA9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fx4QgIaeYGcrBxiF2lMALlDNd1S18ykC5ZwGQmhlBQ=;
 b=EaMz1TAeTo5F+NZIpXcClOD2+6PGtG7g94W2gc1qdBLisOB0i+tsCnin/JH0huvP6R0znm0x+iLndy6StmGxcJs0jAM4Ikhpg6PwzSiMyC8QvkT5+aTKFw88ha7si1rwh0hnrub0D7XqOaKja7Ow8FDDCC7pVn5kPZO/NltNc+4=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 15 Oct
 2026 08:27:27 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 08:27:26 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: reapply umd profile state after recovery
Thread-Topic: [PATCH] drm/amd/pm: reapply umd profile state after recovery
Thread-Index: AQHdXHtiJvO2chr1BkG4sI6pNsF9urb+P+6g
Date: Thu, 15 Oct 2026 08:27:26 +0000
Message-ID: <MW4PR12MB6803834002DAC252B28E13458E9C2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20261015080107.2472690-1-kevin.wang@amd.com>
In-Reply-To: <20261015080107.2472690-1-kevin.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-15T08:09:06.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|LV3PR12MB9411:EE_
x-ms-office365-filtering-correlation-id: 372d2455-f1f9-424c-60db-08df2a962549
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|18002099003|22082099003|261009223027099003|260925021311599003|38070700021|260925022911599003|260925021911599003|261009221227099003|56012099006|11063799006;
x-microsoft-antispam-message-info: ZgHshRgr3sn7/O8UnYkhRKIVTJP+0L/NkKHAW0cOafOd95JPnDtmP57GdYbclKxLVx3hdQouhSEAkjqp6Dc/wV0r+LmXi8CnAntFfEGGwy59dUEYRvhh4Z57cYCtQxClQca+WC+smNcSPhXFxbhJ1gGVdiZYQ3fP/sl9fv968/XqJwcXJIPNcXqMG7YLcgxfoAKioq4qoC6bkU0cTmgB3+FA/1dVItrlh80i858/5D9I7ipP+Cs5Zu4Dt4aE/oN6oACedFWGaTqNSHGJ55fhxi1bne7X3i8xUQ96+Fh0SxFEoSiQkZvN7eiSogIBVd2o7fnr1iUyKJ9j++P502Igpg8FhWMlJCGj8ryzPXNiFN+zu8f4A77l5hJAhCgkiDegK1YAC8Xtygm3ZHtUnHFd+tEcA2sWuFtmDARlhdXc7JRPBaAKMKKR1symwMhOp7fvlO2iKjCdvlb5GaLaOEGY4kKm9gfaorz0yBu0y+oyPc8Xxd2DHKVMNEyPsizo5AnG1o9/h01r4Iue/nSL8RdmsHjY5XBC0Vs8yzAMzFnyH9vnsqjke5Zm9Q8Vl/3WQRpBEvIWdkHvrM/hhR+BaPcnzlLivVtogEnN+JA+mdW4e+1/Epu9Coyt4ytZIUKGmB/k8aUN/MeRALR/CjhO3IfpQQz9iXvtfA4W5FN/pfunTdUw/M7VJD4i8LfcIhUreek7IyirtbhP0B52qEHSowFv3wm2+Hn7oXsZGe1pGBIf1B4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(261009223027099003)(260925021311599003)(38070700021)(260925022911599003)(260925021911599003)(261009221227099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eic2vK6gPcJ/b1Dgf7xyd3EFxozJNpyZSKbXmWZTi4LbX7b64MBa3Mar4F4V?=
 =?us-ascii?Q?gOdz9rMI8RdiVM8IGWbW/P0ald7dkUQj9tfndyUEyv0BJyruL0WOCPrwzdYA?=
 =?us-ascii?Q?/UzsBHSSTYXFrMkOcD+sPSOPTtld7wOFpaDHL/lkz1XHdeq7UXyfx4YqLLPs?=
 =?us-ascii?Q?CSV9HFW57zT2F5YPLFSU5aTnCWbQm1NuSgBXnqdWhY2t6GX2ElhhoxCKaKdI?=
 =?us-ascii?Q?5rJbixCBBvYhvCeIpA5OtuFhM5yluZVHoT8riE6ZfvQ8O8B5HJMoegFvG6+f?=
 =?us-ascii?Q?IoTshZa275BLmodEH5cjVpiG44exVF7fnBeBmBU20JbUnoOJ6aQ0IYi8J4bH?=
 =?us-ascii?Q?E3HBfK2IL2aZ17GSMXSKbTW0AYtORS+chp1qlwibtPXsC2B+e3eerc5Sd2AT?=
 =?us-ascii?Q?qJECFL4ueqxV1COIsVsN5ixckI/nqCrRs+pIhX324zwhdsPaWT9HBpTSo46O?=
 =?us-ascii?Q?bMpyfaytmxm0cUKBCihm+u34Jl1IQTiUQUCUAXD22AHNHLfkumt4rkqJXwnc?=
 =?us-ascii?Q?6/BbTLMZUjIf5kgAS4OthDBqY7w5vCnagQnTVUOuws83pnPdS5UrocVl6YS0?=
 =?us-ascii?Q?xKycgq8NIfYJOqVHX6hHhqHvAuX7RORjM9k6smKfWzVHvjhRvOLLVxOEwuAA?=
 =?us-ascii?Q?rksWR+NfBXqMpjM2cmElKc/+5UtBYup5woyS8uGmyD1mb4qCJJ6rGduGHdrG?=
 =?us-ascii?Q?ds+PIa62u85BWlGlYdsrsG3cZfAddGsxdIEWaTHBsEXPhNZL2A4U/6Sq99p+?=
 =?us-ascii?Q?jhp1qkn7H/a7PSj2fRrQMPJ6NfDHkUGhwE3FThH9wx3m++5IixL0quUKk8RU?=
 =?us-ascii?Q?L7Zr0B5nZ0fc4oGWGoPPdMzl8lDWheKcX4R8gBXWthe2a0tFfG5BYs224eZC?=
 =?us-ascii?Q?bTON2Vc0VnwhYFIC1B4+Q9Kx3JqCVrAY9MKtd5vcydkmqCFsHW7OOBO9IwH9?=
 =?us-ascii?Q?8eZzVqKL936GJ9eeeaYiHyYrFwCB3/0hXsYkCkfwqJQKveWbMUsbBBXaOKZ1?=
 =?us-ascii?Q?oAVocmQvqkamskoFARAnqUvP6KnvxA7zYhAxuxI/TeW4AIN2OUcKEYn7MVq1?=
 =?us-ascii?Q?nEbIA7xpBYPER/WVb4GRF8oj6bW1HWKjajFdKJhkRjrsMK6hyJ7XxuvcPoO8?=
 =?us-ascii?Q?9BczYEHha3Vpksw08ybQlY2ctGs6WpYhHMaDOhAnq/Ftm5Qs1I7LGSmx80AN?=
 =?us-ascii?Q?AA8W+bG1xkz5L8giKKrN2FCk1+mwEksa/Y3aBk1F45Gtp0YKWJxlxi363PeJ?=
 =?us-ascii?Q?VhbGaioVt+nlxkDZ2xHDRAiDY90BTqieBGKFyqRG/5ri80MQNjMChCan5rgS?=
 =?us-ascii?Q?GPXEacYji8HR3/Oz637+59TV0KE/Tva792QhYUQOuC6xFS1ztVcFopzIiNts?=
 =?us-ascii?Q?RkxnNsZWVdwGmKytssOgshf4a/ogUfwg/ofzUAUrQmi0sWmU8tIqhmtqvo2k?=
 =?us-ascii?Q?MsA31Mz83pX7zGxq/Yi4WHbkk5ymkdL7JAgZbv6uYvsTWPHV/l6LgFQL3duF?=
 =?us-ascii?Q?1joHl9LVPEDz8IagRVG7SDfNSgtaQuKaCe6y2xfjPDktnK/OXgf3EEoIOn8Y?=
 =?us-ascii?Q?GSxhOAjByKKgMjA4hVBQMKrdWjZ8QXL5vR3XcW3bsWkGY5lp38Q4mt1ZWZPI?=
 =?us-ascii?Q?BhbZKU94mXlcqM9P2yEejhrK+dTJuJuJ6jd6fJZXERLvjJ2WVA2WuaWMMGdL?=
 =?us-ascii?Q?ZdpBzcYTAEEJpP9qlghJHtnNNG0jQ+zu4IVa9F+Xhmo5rvav?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372d2455-f1f9-424c-60db-08df2a962549
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 08:27:26.8655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNrk8QLwwGppuBNihqSqieYT3eveU9nj69EBxFlWi2JMTbpvMhxLt1s38RgyQjDg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411
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
Sent: Thursday, October 15, 2026 4:01 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: reapply umd profile state after recovery

resume and full gpu reset retain the selected umd profile level in driver s=
tate.

add a generic dpm reapply path after cg and pg restoration.
it restores the umd gfx state and asks the pm backend to replay the retaine=
d level.

backend callbacks for swsmu and powerplay include swsmu gpo, gfx ulv, and d=
eep-sleep controls.

this covers:
- pci runtime resume
- full gpu reset recovery
- system resume, including s3 and s2idle

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 14 -----
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 63 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 15 +++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 61 +++++++++++++++---
 7 files changed, 138 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index e0014611f039..c4f807ca7eaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2776,6 +2776,12 @@ static int amdgpu_device_ip_late_init(struct amdgpu_=
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
index 0394085a0328..01d2049d8224 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1082,6 +1082,69 @@ static void amdgpu_dpm_exit_umd_state(struct amdgpu_=
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
+       int ret;
+
+       if (!pp_funcs || !pp_funcs->reapply_performance_level)
+               return 0;
+
+       /* Serialize the retained level with the GFX and PMFW reprogramming=
. */
+       mutex_lock(&adev->pm.mutex);
+       if (adev->pm.dpm.thermal_active) {
+               ret =3D -EINVAL;
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
+       amdgpu_dpm_enter_umd_state(adev);
+
+       ret =3D amdgpu_asic_update_umd_stable_pstate(adev, true);
+       if (ret)
+               goto exit_umd_state_unlock;
+
+       ret =3D pp_funcs->reapply_performance_level(adev->powerplay.pp_hand=
le,
+                                                    level);
+       if (ret)
+               goto exit_umd_state_unlock;
+
+unlock:
+       mutex_unlock(&adev->pm.mutex);
+
+       return ret;
+
+exit_umd_state_unlock:
+       amdgpu_dpm_exit_umd_state(adev);
+       mutex_unlock(&adev->pm.mutex);
+
+       return ret;
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
index 239c64b8edca..bddf75dfbc22 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -376,6 +376,20 @@ static int pp_dpm_force_performance_level(void *handle=
,
        return 0;
 }

+static int
+pp_dpm_reapply_performance_level(void *handle,
+                                enum amd_dpm_forced_level level)
+{
+       struct pp_hwmgr *hwmgr =3D handle;
+
+       if (!hwmgr || !hwmgr->pm_en || level !=3D hwmgr->dpm_level)
+               return -EINVAL;
+
+       hwmgr->request_dpm_level =3D level;
+
+       return hwmgr_handle_task(hwmgr, AMD_PP_TASK_READJUST_POWER_STATE,
+NULL); }
+
 static enum amd_dpm_forced_level pp_dpm_get_performance_level(
                                                                void *handl=
e)
 {
@@ -1536,6 +1550,7 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D {
        .load_firmware =3D pp_dpm_load_fw,
        .wait_for_fw_loading_complete =3D pp_dpm_fw_loading_complete,
        .force_performance_level =3D pp_dpm_force_performance_level,
+       .reapply_performance_level =3D pp_dpm_reapply_performance_level,
        .get_performance_level =3D pp_dpm_get_performance_level,
        .get_current_power_state =3D pp_dpm_get_current_power_state,
        .dispatch_tasks =3D pp_dpm_dispatch_tasks, diff --git a/drivers/gpu=
/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3cdf7d1e8d5b..b8057878a400 100644
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
@@ -2521,8 +2527,11 @@ static int smu_adjust_power_state_dynamic(struct smu=
_context *smu,
        }

        if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
-           smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINI=
SM)
-               smu_bump_power_profile_mode(smu, NULL, 0);
+           smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINI=
SM) {
+               ret =3D smu_bump_power_profile_mode(smu, NULL, 0);
+               if (ret)
+                       return ret;
+       }

        return ret;
 }
@@ -2541,13 +2550,13 @@ static int smu_handle_task(struct smu_context *smu,
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
@@ -2676,6 +2685,37 @@ static int smu_force_performance_level(void *handle,
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
+       return smu_adjust_power_state_dynamic(smu, level, true, true); }
+
 static int smu_set_display_count(void *handle, uint32_t count)  {
        struct smu_context *smu =3D handle;
@@ -4062,6 +4102,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs =3D {
        .force_clock_level       =3D smu_force_ppclk_levels,
        .emit_clock_levels       =3D smu_emit_ppclk_levels,
        .force_performance_level =3D smu_force_performance_level,
+       .reapply_performance_level =3D smu_reapply_performance_level,
        .read_sensor             =3D smu_read_sensor,
        .get_apu_thermal_limit       =3D smu_get_apu_thermal_limit,
        .set_apu_thermal_limit       =3D smu_set_apu_thermal_limit,
--
2.55.0

