Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98F9FF6E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 00:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E0610E659;
	Wed, 18 Mar 2026 00:20:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="keF4k4rQ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E60810E0E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 00:20:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ov9pAZCtcL9LsVHwUigw9oh9vPFt4idtIyDDWWhAQw6tzDOMdrC7np1DLhFQcQTRQDoyYs9ajhv4QDezYe+mQDngjnfz6YnSXT8jszJIUboqrbjSMPudw5xbU09jJljh2PC1zDUA9n7Yq0k2leN9yQzFXz/XmdY6o9w6pg7PleBNqoffqJiTCxKbeUx1S1iysalTkGF627/+wTrvc4m5VUYNpi6ktkAW0E22cHcmYnSt96XFlxYbI1n27xzRa6aJR1PUBiBccDdXoO5mDEDsFVBbqMVfVRfn/2QG+XCgZUfzJiuh8BpupBNhFg6I8rzDYIBXPKz+Xjrm/s03lV2UTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4Ln/okJ1rbd5rV/cFI8KGUnWWtz9aT8ojv2SLI2cR0=;
 b=Incrl1tpwX1d5gv7wUhItBfebxqy+kYW1zRk/nLknpreOT11X10bjJ/p7jYkIF9Cl+tS7XV7fa3wC+aTSWVqQNWZMSxeB/g+G4Q6IE88o2iuxXPp8MkWvI+J6MH0E55Z+wXZH8quwx0n+KozgaW8/5nfvPjaacecZLffEeKBeriqUVLZpttl1Nhy528k2jyd6lAbyoUo/CoTr/zUb8jrdMhh87xqa0xB5yDcj4aYRpve6lPt4bYR7JMPi5nUmuA6Mlpojo+hza7KG/94skC8i5X5Gk1RJH0C83nXxtg/MGhbBh+6s7MKYYgGxvwoEeABbchtBf9ly9ys+Hb2I0ZQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4Ln/okJ1rbd5rV/cFI8KGUnWWtz9aT8ojv2SLI2cR0=;
 b=keF4k4rQKTPCROd4gAr/vy9rpB3cK78lxdLkEDTsrvJ+by7TisTHksaf8a0oDiKakcqGQo/QybVIJiALZD9/Y5T/e7W2sbJF0XeMDY7dgu1MviFnMhW0pCbfeLrh6sutui1+A1nT3fAizweZkAYMgVDiYEHWec2+vFzzwgsETX8=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 CY1PR12MB9584.namprd12.prod.outlook.com (2603:10b6:930:fe::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Wed, 18 Mar 2026 00:20:03 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9700.006; Wed, 18 Mar 2026
 00:20:03 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: drop SMU driver if version not matched
 messages
Thread-Topic: [PATCH] drm/amdgpu/pm: drop SMU driver if version not matched
 messages
Thread-Index: AQHctk5rswxCtGvSyEyWBIYag9gAbLWzagPg
Date: Wed, 18 Mar 2026 00:20:03 +0000
Message-ID: <DM6PR12MB2972DDDCA2A35F95CBA2883D824EA@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260317204110.3833021-1-alexander.deucher@amd.com>
In-Reply-To: <20260317204110.3833021-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-18T00:08:13.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|CY1PR12MB9584:EE_
x-ms-office365-filtering-correlation-id: d200e9bd-1093-4341-d2fb-08de848419b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: eINILjZCkdrBf2x44B/jDKwkGjrw73/QVZ3vOrBGEIqD/CiwaLerrQyQUtD8aILH32P1c8WJN3GERvm8MrlA1tRhzLmvcIDhx/p9Vh/nFvm47Hk/1ZQxhe+8InmtrSDz4kRfY5s8VTOTwzLwb4Vu9SnwhajSqCe3zZ9XFgcXfs0/5UebROaxM2esikyPVtoA/kKRAe9VO8+C5kPkcZleMrcALxL0xZrWN/+eZOmX5RJ/h9WkJbK4f5rrQ28DVWi751s8xrC/YMYXWkDWuXY9uKRPSABDb6UFfHsB169crcNOn6L2qTH9igYp/PsNSrRXxvyatZrNgMaHejBamsq7Kl7pxgjbHJQ0MlTF0R0TweajJVb78x+0o/003rFU9lpFra7yYLRugxMOkdIeieIvW5NB4HDK0Vz2mriG/EFA72s2HBKOqJVRU9l/fnYvCCScKM4xNlDQIeywsVDpAjpDSJJl/zAGuSD33rjlqlTZd6qEJehrJoaPMXJrmkasvrbWD48lIqCWklwifaI4IQxOT+0GOIZ3g5a0z6kX/PO/G0C1Lew2A1eNAYmdHlZbSSYbRdi/SuBEnSyS4D1skv+5f3kN8WEsFxxxfci0qT8/4PCscUzT+9U6Zb3rdmPR6pLUUbvl60PEqc8VkBc+AE+UL0gNYENn1kOL3BxlJ8M82j56QvFUVe7BA3oqJW0eRs404WS9OvWIBRtPGH3LXRDQsHtABNEo+CVKBh9B5DHkckfV+9ZJMBXa1QCgxxtFK/ZC1yMPw+wXKPJJKZ6TCTzI2ajspWiVMtaPiSFkPB12dXs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DvElKEGU8tCOitZYEKQmHw4x7BBhbpT51mCIornsC/G8MRSv4n1scllpxXKO?=
 =?us-ascii?Q?lGXOyv8lb6KvcFC0pKuaxLdEciscdUfBCBhWpnKPO0cb09PiNBfuVkiE2ogb?=
 =?us-ascii?Q?JIdUUCU1Xzs65lb3jF0vaFbi8Cz1vugJRFucG+PVH1yQ/PsQOHNxTN8MX4AT?=
 =?us-ascii?Q?PTdwbG2DRGeMzl/9SYUkr9G2WBOcckGPjGzNJmLcYSXyzijLVJKZiO3nOwiD?=
 =?us-ascii?Q?6X2djMVRcqwyhoybdxn/vGH5QUruCJZYwM2LeH9EVRQAppCv252ZP2lFyg48?=
 =?us-ascii?Q?rDV/JBMg25Mp3KP6rvgUqJ/5EmwFsZxJ3VJVa8kZM0La2tGnAWckyTI6mVx0?=
 =?us-ascii?Q?XrqyBVHIvJKzramAXs03m6tUlo/VsQncCq2pbwx7GghPl6SZfjweaDtyyoCR?=
 =?us-ascii?Q?N+b8sRigDs+8myMcQfnEmQbzz2jmZnFr9tQL8RHsk6xoNkxlOSH7fqARdHbF?=
 =?us-ascii?Q?M9/cVH58XwVoXDqVaN+Tjvd5Ujs0AtYAkdm18v4tdJJQdlWquRVCnrkCwyiF?=
 =?us-ascii?Q?gqOI8TV5ROfIJBL0cCiSRYXXmkHk/fPdd+Q12NyiNaTHK8fOPl/vnPNVulGN?=
 =?us-ascii?Q?poxxZuewxVitCkjPKWDYuhNjr4iMUxo5Y7xTAoovMlRLJcfIc0oMGL5Trs1T?=
 =?us-ascii?Q?gHxX5Vr73lcb0XBpHo0fMW3dXMLHJbLmc3hxO+c3IXiui3K47Bh5R92MygGU?=
 =?us-ascii?Q?FmM/f2nvHMYewODUG3Rkp7rk43aurR/BeJv5+kt9J+/dDr39tJJqs/8X8pDW?=
 =?us-ascii?Q?eRS8PvG7+aZCXsdfwC9ZrQjLzFoTUw3aD+uQWBP+NDtv5K2Fzao/CjT5/UrZ?=
 =?us-ascii?Q?vzO7GLQKqvaj259mAkqItzM6YeA3c1iSLBDyJFU1XN2nJXq9z8W2NtAmCc1n?=
 =?us-ascii?Q?Eu1nmOTMptS9lmGcXJopzeM+tkCHtJ1tY+9CccY//l2JdYtoIblVFvul4y8X?=
 =?us-ascii?Q?yebIHnZJ/4u5fzbyXo+XWqCG2Ai5LZqe42VE5FdtHC3107CLKgCfOT1PcENq?=
 =?us-ascii?Q?okohRg0/5Hj0JIkT1NoJGreBfPoLF7LcPWolxMaiF3e0LKj3XkVbmUe8kpgX?=
 =?us-ascii?Q?QWJmQ2CK6ExRsFvpHoyr6XHezbBiEuSB3YLJ2ZCM6e0fEcKEMOTxpsTY381L?=
 =?us-ascii?Q?nPVw/cn+2vXRP1eAmYP2Uuq49POxlxQ6maGq2z1tFxVeKko+gzRA36V9lg+l?=
 =?us-ascii?Q?j7FS9CGkXourXd0qgxEiDkOf2sR7z+ph2DqA0nDIa1hSaw16xYsYCxW/4YH/?=
 =?us-ascii?Q?sQJkcyTZtK6CldsrM54pb26ouF6qElH5RWf4HE4EAiT1LbWPR7kl/0kiDR+w?=
 =?us-ascii?Q?4HUl90wfe2I6rMvFmnAbBsDz3julXq4gPYF1ulUbqzA+mxkXSjK9ff4AaWJk?=
 =?us-ascii?Q?4RuOzvyF4bV8h8Q3DC8spO+QroHFYVgVRBe1BVyaAza6BLmUF8P3ygC64Sko?=
 =?us-ascii?Q?uC+Vec6XX0cYta7GICjc2UIhtHBtwo9dGptQAGTMnmzLfaBsNEeKjrFuT8Y/?=
 =?us-ascii?Q?NwEwRvXJ1IBxIoa32DqzojXTp7xt7OfarootSp95E8gzN5dFntv3nu10o04+?=
 =?us-ascii?Q?Dn78rSd+9VwiaNUskDFeb17zMlnlU5Jn7iJHVGWmprAV+bLeeY6pjuFAes7B?=
 =?us-ascii?Q?dxMYtZs/NvB6XG60n0gthvsZfW/SgOc69k7VS/tGdSMsZ9aaPSAS5RYRLgQW?=
 =?us-ascii?Q?lRpQT8U7ecjzyy6sLpw381/pqnXDrZe+Yl+GzUkjgj6mJh78?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d200e9bd-1093-4341-d2fb-08de848419b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 00:20:03.4906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kZlnJ5hOcgqoylnXK09YCv9COn3FQJAf4Opxol5AkAKiNp1HHSVDvNcroXLX1Mq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9584
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

Yes, I agree.
This string may cause confusion for customers, but keeping the other versio=
n information is necessary for issue identification and debugging.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Alex Deucher <alexander.deucher@amd.com>
Sent: Wednesday, March 18, 2026 04:41
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <Kevi=
nYang.Wang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amdgpu/pm: drop SMU driver if version not matched mess=
ages

It just leads to user confusion.

Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 -  drivers/gpu/drm/amd/=
pm/swsmu/smu12/smu_v12_0.c | 1 -  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v1=
4_0.c | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c         | 4 ----
 4 files changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 56efcfa327dfd..1eec1a88e05f8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -262,7 +262,6 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
                        "smu fw program =3D %d, version =3D 0x%08x (%d.%d.%=
d)\n",
                        smu->smc_driver_if_version, if_version,
                        smu_program, smu_version, smu_major, smu_minor, smu=
_debug);
-               dev_info(smu->adev->dev, "SMU driver if version not matched=
\n");
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu12/smu_v12_0.c
index 2c20624caca45..ac5e44dff6c97 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -101,7 +101,6 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
                        "smu fw program =3D %d, smu fw version =3D 0x%08x (=
%d.%d.%d)\n",
                        smu->smc_driver_if_version, if_version,
                        smu_program, smu_version, smu_major, smu_minor, smu=
_debug);
-               dev_info(smu->adev->dev, "SMU driver if version not matched=
\n");
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 7dc6687c3693b..9f01bed3970ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -284,7 +284,6 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
                         "smu fw program =3D %d, smu fw version =3D 0x%08x =
(%d.%d.%d)\n",
                         smu->smc_driver_if_version, if_version,
                         smu_program, smu_version, smu_major, smu_minor, sm=
u_debug);
-               dev_info(adev->dev, "SMU driver if version not matched\n");
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index a644579903f40..5ec2b4e6f3f35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1057,10 +1057,6 @@ int smu_cmn_check_fw_version(struct smu_context *smu=
)
                      smu->smc_driver_if_version, if_version,
                      smu_program, smu_version, smu_major, smu_minor, smu_d=
ebug);

-       if (smu->smc_driver_if_version !=3D SMU_IGNORE_IF_VERSION &&
-           if_version !=3D smu->smc_driver_if_version)
-               dev_info(adev->dev, "SMU driver if version not matched\n");
-
        return 0;
 }

--
2.53.0

