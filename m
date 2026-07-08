Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19556C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 22:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71B410E374;
	Wed,  8 Jul 2026 22:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HMmilY4x";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC3BD10E374
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 22:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkKrO0uu3i8DNUaQVqMJT/Gp990dNVSQL9Q/PsCHhEuK1LPiPVAhiG3pNsUyyUGCF9mj5ylW0OJXtaM5rsfbYB4rzVvlmH8u+AUQF5Hgbr2X3CxjVWB21UFhpYgd9u5YtF/QKs9khG50+GSrjkOoTyliP4l84Kz0WE2FwZ8YUzC59Tm2U8E98CvWTQdtVgMDaZpy+DUIgLUrzjn2dj+6oW8h4sXfy2wqwkb5PxuELTCQx1at6ox0+vP4p0vZ0hqFwWiXH6vCx6MY+elSluoj7lbvRme2o6O+42EhjqmpORk6uivN6oNOrWmVfu73u3Gpiy+ScpSe09jm7U/xak1SSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K8DjV3u+nTcjshRMpHtwKonXBjW41ujliyA9cClwxA=;
 b=hJjdg6OtZQ46zCj1gDRa6wB6ctWd1QVHpDhDhpGS//jF+rnwlI7mjPcb5E4elYdOZfLwdmoCdlBpolqNDJtRg1L20Kc8AxfdJvjr1u+sL3QziRoOwxIo9nhum9YO64JND9RW9QtqryQ/4QgCNHZNWszu7zNCd8sfXb4bQX0c/0BUHhGXYGu5KND4q4D7n/tTQ0UxqmNvAbncb+GLaqD3AS+3eVdP+80vxNZiqmeMsk63gRT2IeWGwc+KhQr043m7HKF/L4ybkk65aI9/rwns15sFU+9c4S6GNgJlf0KS4P1g8QPj21piH3mvtrGBHGWOnuyTlgN6zQPZtrF2Risp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K8DjV3u+nTcjshRMpHtwKonXBjW41ujliyA9cClwxA=;
 b=HMmilY4xT20MFJn/YD1seILMMhCDOTj/AiZmLiHtTuA3YgB3M6c3yKfBCa7N7rOo+I2a/qiZaNLcGDuOGepm3pnLgOYSN17zO/mvCEOTbOn3qUVzFR6WuZjSDGARSdcVzCnF6VvNKHzNJ/bTyWk2hClEY+rHDdas3+gRCCcfZ80=
Received: from IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 22:57:57 +0000
Received: from IA1PR12MB6138.namprd12.prod.outlook.com
 ([fe80::f4c7:6e6d:45bd:6eb6]) by IA1PR12MB6138.namprd12.prod.outlook.com
 ([fe80::f4c7:6e6d:45bd:6eb6%3]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 22:57:57 +0000
From: "Liang, Richard qi" <Richardqi.Liang@amd.com>
To: "Soliman, Fares" <Fares.Soliman@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
Thread-Topic: [PATCH] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
Thread-Index: AQHdDYiwLK8ufZ9E7EOQcjO6aod7k7ZkKj+w
Date: Wed, 8 Jul 2026 22:57:57 +0000
Message-ID: <IA1PR12MB6138FC719502EE171F4D6D53E1FF2@IA1PR12MB6138.namprd12.prod.outlook.com>
References: <20260706204711.4022513-1-Fares.Soliman@amd.com>
In-Reply-To: <20260706204711.4022513-1-Fares.Soliman@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-Mentions: Mario.Limonciello@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-08T21:42:21.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6138:EE_|PH7PR12MB7020:EE_
x-ms-office365-filtering-correlation-id: b2d4c6b3-339b-469c-f214-08dedd445a0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: FO1HbYu4Gyc9V6LPQ3ABiGooYu0CnGZjkxIYqOFZzlwMqnaYL23u4n0BP/1ZlIaB8JDpWRvduKF6JZ2/otoERxM7kT1l6V6W6DNaJJTwQPCwI4Y9z75Yzz59WNkTVefOuENGMIPPineOdANPHj/7AB5BG8Pax6bJLp4O2/TP0NMtKevVb3tUXFasLz/+o7020mngLJ2QKFgEBSF/Evo1wZ2zKzdPgmtTn7aQxQAT3aC7tIusfcQLjqZyvOAA8pXP9Zt3skmPzs8NcrSn7Fz1xNpXvURKN79dyA1jlOBPnL5BqPi24dqAEE3zX0FejsDiIYT83qduM8tAqa0Y6VGqTyOK3ZYF0gxejMEGg1k82HEz+dd4uZKagzUewK4z7EThthVBqR/NpYQYixLvR1VA3ebjDXykLATklsuNb9N9C4zq55PocgWF7i3bvpy8/ENt6VqNCKLYbWRG8LWk0RyAmCZn3dClyO7xHULAVQjITjE1GaO088FOU6jtWoCnl8VCVvadqfaP86osu2oc/ZRAMIxltn0OnNCIX6XJTVD8M9R8ihV4y9EUZuYReAVlkGfftVcxMKZ0yjSEH6P5gF1GflLsYtA25mjxhdWKZBDNXYIx5/T+0fZTIKZO2AZNVTZqmugLf4DonI9n/SKdhsR7z3yiyeHE4XeNhe5OZBRhFVXNHS2EnZ1bSKNMLy50w0ODDxmwJV9Ohx5V4xxk+Lurjs7+c1Cab/szyAlw+fmOrAo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xdmXB6amfxz4+ho7vag4KY2o6iUUCoiBQtBdcp5a57TDEOO+lfmFttagHkC8?=
 =?us-ascii?Q?5/A/2T4nvDb7TN4oYrGIi5i81oGgvFcRU+LrMzEl/lq4/QRBNfGzfzC0yTBE?=
 =?us-ascii?Q?c3FuUTftmNBPpyHr4Ix5G3FcHdsgV05BvNyRggNB7x30J6lPyNDrfNGV/2JI?=
 =?us-ascii?Q?uQ5FUuBwI8+w/6Ufzg85K4f2RpKmVFcj4v2P7CkfG/Er9Ko4ydoR8qBg/dQu?=
 =?us-ascii?Q?0icPAoRRhr9uCeRtrPZfiEY3z2S9HQvu+iJpwKUYfQA6hvevHHNDUPrObRIN?=
 =?us-ascii?Q?HsA4nDFSn5O+lEurUFhf0p/Zn9bQVMmE/ycetSIdCYmQZC7XAlaEJcIgKIRY?=
 =?us-ascii?Q?YbPbm03vuxsNN/JHlUDJ2n0c9AX0fcxxT9Yp7qvNzgA1/di/gUCtwagigORE?=
 =?us-ascii?Q?87paqA2AjAIR7Ooa3frFeBaCQi0aR1sLQRiVB0V/S0eJAAPDIdbuRJdw8hH2?=
 =?us-ascii?Q?Qj3EkI6Fk9it3gk0AHYdW7vPlDCkidEHsGXBZ3YjL2IYPQ+VUaQqyg0GACzH?=
 =?us-ascii?Q?k2H/bYscjR4+LV6G5EJm5uWtQglatcz/E4W5rOQAIK717YwnvAum4XDnNebY?=
 =?us-ascii?Q?RTTXdaUQ6j1cvqeND30Nu8fxzobMfgx0MEnciX9e6ezeUBpton1sVEo0zEri?=
 =?us-ascii?Q?WsPD2qPJCKUFX50M3sraakrhepEi1UVKWJagA92P4pc2/3iPymmbPZ7TgMl2?=
 =?us-ascii?Q?/wpFFfAYslpG2C9z0ccBMKgm8Y8xhnuwduekJHH6Kvr6hDzK6SMiJjVBkArD?=
 =?us-ascii?Q?o63lLXj6Wj5K9kbu0x06eTF0vb4SdRmZLxZ2y/Cviy+xnoJX2cwWxithJcr0?=
 =?us-ascii?Q?I2L6mK2kG3JIL1fZ9uhOP0dejgcD+7MpYvo+h3MPGWIR6WIjQNosL5rxFWH7?=
 =?us-ascii?Q?SNpcY4edXyv91SCNYOCtnQPaGuCOFe97T8hLXPBMLas0KSL76oXSFm2lQ5md?=
 =?us-ascii?Q?h+zN/KvZFKdYREu77wfudsjvmDqxzwcHq6W+mWlVk3BoNXTVHBQnpC2xnpnI?=
 =?us-ascii?Q?YtZePScxs2CHtW7BNNFKjt/ipgoBjBPrYY6a9tKscbW9LYBWW94pucovW3Ln?=
 =?us-ascii?Q?Qq/5ZH679XhFTFZAi1k+/HVqvaCHWOjyan0Ut5Eon/MEwymw/OHfmzuAndXJ?=
 =?us-ascii?Q?vAFmuvV7OzTCbupSxXuEaBXyHfm9sAsSvZtryaj9QdcAo5ioLMLbModVR1iL?=
 =?us-ascii?Q?TJ1/XQrmleMI7BuDxGKKq8x59VshuJlUqN3ie1G057UiLLgyvHIVv6onD283?=
 =?us-ascii?Q?WhEFG4uHkJaibdGx4xA3j1kG4NoYAVnIKGGWvYvj22Vtxeh/z+/o0vBfJ5dW?=
 =?us-ascii?Q?4Lg/f/ITKYwaS1q9R9ZSKCk0CoY8lXhkmUiD/qGR7cCNOl9dNv/mLFYLLMQe?=
 =?us-ascii?Q?CEsFbsM+F/NFq8VJ9oFEP37FschRDnrgg7fYwJOZmku65Xr38ZquIvkA/1zp?=
 =?us-ascii?Q?g1+uBKhpJfTYm1npx+10VIBqOAqI6WBnNb7NvM8Qu6ebzVwYnKYuG1JHW+bY?=
 =?us-ascii?Q?rZUzyVljSE5gbXhS6QUX2h7v2WUUI2ZSlBiTTMVUdwjEK+dwoevJSlh8wxo6?=
 =?us-ascii?Q?TrzsaRpHvpdemLoWha3OphETZL0ZauN08/3vMy+NFFbTKF+p3/AXsOE7aWlg?=
 =?us-ascii?Q?f5fT1fupnkhDVsRPygGKqwrIT7pZHaC8Udsn9ign9Ok+oeRPEUhVp4bn/uEC?=
 =?us-ascii?Q?qbfjZQEFuFpfnGo+s5tq5GeubxSEihjlngDkTaH97xSwgwxE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d4c6b3-339b-469c-f214-08dedd445a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 22:57:57.1392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zDbXYVnI3wEsSqWr7jsRSz3fszCdNtPE8Z2FltCH/bLVjr+Ijj26m8TuOUc4f79p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020
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

@Limonciello, Mario for code review.

Thanks,
Richard

-----Original Message-----
From: Soliman, Fares <Fares.Soliman@amd.com>
Sent: Monday, July 6, 2026 4:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Soliman, Fares <Fares.Soliman@amd.com>; Liang, Richard qi <Richardqi.Li=
ang@amd.com>; Soliman, Fares <Fares.Soliman@amd.com>
Subject: [PATCH] drm/amdgpu: Update message IDs to PMFW to correctly gather=
 GFXOFF residency logs

Updates PPSMC_MSGs and set/get functions for gathering GFXOFF logs on Van G=
ogh. Logs are now gathered live rather than starting then stopping logging =
and reading an average value afterwards. This is in accordance to changes m=
ade in PMFW.

Signed-off-by: Fares Soliman <Fares.Soliman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  1 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  6 ++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 ++-  .../gpu/drm/amd/pm=
/swsmu/smu11/vangogh_ppt.c  | 30 ++++++++++++-------
 7 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 5c4d4ff001ea..46514a1faf1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1320,8 +1320,8 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f=
, char __user *buf,
  * @size: Number of bytes to read
  * @pos:  Offset to seek to
  *
- * Read the last residency value logged. It doesn't auto update, one needs=
 to
- * stop logging before getting the current value.
+ * Read a live GFXOFF residency sample from firmware. One needs to
+ start logging
+ * before getting the current value.
  */
 static ssize_t amdgpu_debugfs_gfxoff_residency_read(struct file *f, char _=
_user *buf,
                                                    size_t size, loff_t *po=
s)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 62b5ad4d10b0..1bde0645c6f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3725,7 +3725,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        amdgpu_coredump_init(adev);

        adev->gfx.gfx_off_req_count =3D 1;
-       adev->gfx.gfx_off_residency =3D 0;
        adev->gfx.gfx_off_entrycount =3D 0;
        adev->pm.ac_power =3D power_supply_is_system_supplied() > 0;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index aefd4f03b443..4c1f8504ee1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -493,7 +493,6 @@ struct amdgpu_gfx {
        struct mutex                    gfx_off_mutex;      /* mutex to cha=
nge gfxoff state */
        uint32_t                        gfx_off_req_count;  /* default 1, e=
nable gfx off: dec 1, disable gfx off: add 1 */
        struct delayed_work             gfx_off_delay_work; /* async work t=
o set gfx block off */
-       uint32_t                        gfx_off_residency;  /* last logged =
residency */
        uint64_t                        gfx_off_entrycount; /* count of tim=
es GPU has get into GFXOFF state */

        /* pipe reservation */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index f8fd93999617..d94e3dcf7f9a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1333,7 +1333,7 @@ struct pptable_funcs {
        u32 (*set_gfx_off_residency)(struct smu_context *smu, bool start);

        /**
-        * @get_gfx_off_residency: Average GFXOFF residency % during the lo=
gging interval
+        * @get_gfx_off_residency: Live GFXOFF residency percentage
         */
        u32 (*get_gfx_off_residency)(struct smu_context *smu, uint32_t *res=
idency);

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/d=
rivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
index 7471e2df2828..4206514765cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
@@ -110,8 +110,10 @@
 #define PPSMC_MSG_GetSlowPPTLimit                      0x4C
 #define PPSMC_MSG_GetGfxOffStatus                     0x50
 #define PPSMC_MSG_GetGfxOffEntryCount                 0x51
-#define PPSMC_MSG_LogGfxOffResidency                  0x52
-#define PPSMC_Message_Count                            0x53
+#define PPSMC_MSG_GfxOffResidencyLogReadSample        0x52
+#define PPSMC_MSG_StopGfxOffResidencyLogging            0x53
+#define PPSMC_MSG_StartGfxOffResidencyLogging           0x56
+#define PPSMC_Message_Count                            0x57

 //Argument for PPSMC_MSG_GfxDeviceDriverReset  enum { diff --git a/drivers=
/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/sm=
u_types.h
index 636ff90923d9..acf03838d49d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -252,7 +252,9 @@
        __SMU_DUMMY_MAP(DriverMode2Reset), \
        __SMU_DUMMY_MAP(GetGfxOffStatus),                \
        __SMU_DUMMY_MAP(GetGfxOffEntryCount),            \
-       __SMU_DUMMY_MAP(LogGfxOffResidency),                    \
+       __SMU_DUMMY_MAP(StartGfxOffResidencyLogging),           \
+       __SMU_DUMMY_MAP(GfxOffResidencyLogReadSample),          \
+       __SMU_DUMMY_MAP(StopGfxOffResidencyLogging),            \
        __SMU_DUMMY_MAP(SetNumBadMemoryPagesRetired),           \
        __SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChannel), \
        __SMU_DUMMY_MAP(AllowGpo),      \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 717ba46c8933..4212abfdbe53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -142,7 +142,9 @@ static struct cmn2asic_msg_mapping vangogh_message_map[=
SMU_MSG_MAX_COUNT] =3D {
        MSG_MAP(GetSlowPPTLimit,                    PPSMC_MSG_GetSlowPPTLim=
it,                                          0),
        MSG_MAP(GetGfxOffStatus,                    PPSMC_MSG_GetGfxOffStat=
us,                                          0),
        MSG_MAP(GetGfxOffEntryCount,                PPSMC_MSG_GetGfxOffEntr=
yCount,                                      0),
-       MSG_MAP(LogGfxOffResidency,                 PPSMC_MSG_LogGfxOffResi=
dency,                                       0),
+       MSG_MAP(StartGfxOffResidencyLogging,  PPSMC_MSG_StartGfxOffResidenc=
yLogging,    0),
+       MSG_MAP(GfxOffResidencyLogReadSample, PPSMC_MSG_GfxOffResidencyLogR=
eadSample,   0),
+       MSG_MAP(StopGfxOffResidencyLogging,   PPSMC_MSG_StopGfxOffResidency=
Logging,             0),
 };

 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT]=
 =3D { @@ -2450,19 +2452,20 @@ static int vangogh_set_power_limit(struct sm=
u_context *smu,  static u32 vangogh_set_gfxoff_residency(struct smu_context=
 *smu, bool start)  {
        int ret =3D 0;
-       u32 residency;
        struct amdgpu_device *adev =3D smu->adev;

        if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
                return 0;

-       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_LogGfxOffResid=
ency,
-                                             start, &residency);
-       if (ret)
-               return ret;
-
-       if (!start)
-               adev->gfx.gfx_off_residency =3D residency;
+       if (start) {
+               ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_StartGfxOffReside=
ncyLogging, NULL);
+               if (ret)
+                       return ret;
+       } else {
+               ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_StopGfxOffResiden=
cyLogging, NULL);
+               if (ret)
+                       return ret;
+       }

        return ret;
 }
@@ -2479,11 +2482,16 @@ static u32 vangogh_set_gfxoff_residency(struct smu_=
context *smu, bool start)
  */
 static u32 vangogh_get_gfxoff_residency(struct smu_context *smu, uint32_t =
*residency)  {
+       int ret =3D 0;
        struct amdgpu_device *adev =3D smu->adev;

-       *residency =3D adev->gfx.gfx_off_residency;
+       if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
+               return 0;

-       return 0;
+       ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GfxOffResidencyLogReadSam=
ple,
+                                   residency);
+
+       return ret;
 }

 /**
--
2.43.0

