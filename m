Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2945DC10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 12:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84D410E72E;
	Thu,  9 May 2024 12:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rGrZNV/w";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F8210E72E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 12:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgUhvVn3PFM3KEq+42TYCLtskWYyF5pL3RQPEqoItk6v3RnTca/UYZa8LBHdjKpIWDvRdaBPwdTIs3Rc2wU+oy948epGzm2slzTgceKgnTr4uBgXyza2w7VRFIKJaYNQ2BOliHTZxVRw2AFn4u0oxnA2qlrc4Vea/cc6x3QHBeu5C9wkDOsf2z5cJFA/bC9Ze3jp2OCpxpNuuXpu4j8Hs82fB8slbOxN4H6tsYakjwVmHkId77JoRspfNvrnXgRfePu987BmYAgIPj3ayoM57/eaTw2vCtp4ITpIXtYDSIhw/YEVZ6SbGE0lH8mpRaHrPymoZUhbyH5HgZX7i8R27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cMtOZoPLxAEPuHfO61f+4T+h6h0bKJfFxfuZkTHcNc=;
 b=hgXz2Qh8YCLfmw3DHFKqHLpzzsTd0aBLRAUTMLGWm5sfDvT0f1Oy23XjxzvbMFTYODbv/x2tV+maXQBVE17oQtIFOHt8Ufajq89Q/PpLGyZ6ncqUYIXLQEjkwKaNyWqRYvarpK8WP0Mrh5m0QvKAybdKsUxRxttFhBlBCVDiSVAeW6TSYsJenaaNd9ijRYE9xiT+c9xWbyomerL7X3Gqg5zpdpgmtUQkadWXCBfiPS/5mnU7H6Q3tg5rOOsb3L8yJavuN6ic4QwKccQP5fKGiUOSYE60RCJtRWiAMUV8uJJmD2bGJaiuLrd7abFXBrTQEbxLTtefPRPiMfMxqAx+QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cMtOZoPLxAEPuHfO61f+4T+h6h0bKJfFxfuZkTHcNc=;
 b=rGrZNV/wBtRKzjGFwOFN+dsg0A/qtCAnENgZkCuHsQ8Qcd+oKDf+ej55F8D8COpXN5Gn3HT15I9kVluF8K1Vbc6wc4xIkkDfIysuGxRN1W1y/0nmcLlYqbWnYlQvVC4pW4hpa27+qEvVG4hXAjIQddfs7FRKDxuvWdxmDHx8c2c=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 12:48:30 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 12:48:27 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: Fix code alignment issue
Thread-Topic: [PATCH] drm/amdgpu/pm: Fix code alignment issue
Thread-Index: AQHaofRt4pcQVmjVs0KzJKI0gr69KrGO2mVQ
Date: Thu, 9 May 2024 12:48:27 +0000
Message-ID: <PH7PR12MB5997850F4DB111724AD24E8E82E62@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240509093633.414100-1-Jun.Ma2@amd.com>
In-Reply-To: <20240509093633.414100-1-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8ab74176-e60d-44ca-b5de-0dffc389afbf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-09T12:48:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA3PR12MB9197:EE_
x-ms-office365-filtering-correlation-id: 563f1fa1-a071-4ec6-28b3-08dc7026526d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?nUsa7eP3jIttw+/599Oc5HGPdYBowV7pcaMlQXVh2peuoIOoH/KMmpj4okQT?=
 =?us-ascii?Q?sbZSqyNqKpXIlUCvZ67e+acPrZLva+Pl8IYmuBzLi4utDXgVAqO7lYFySm0v?=
 =?us-ascii?Q?imbKIIGgNty6Q3zyazZiBGJHDUZ08OzM2xjcqTAUGtb28TxCnjjbIhYd2t6B?=
 =?us-ascii?Q?U3hsqlpBm/UtzKizkL7skVveVcGBm3pG9iv+6hTWj9HsDEw3iFzwtCteRDn4?=
 =?us-ascii?Q?fh7ZX2HT8VA2zVRZ26DxIl7kFF5ipKDmayQlG/AM0pszXi0FRaAlOb8tdA+m?=
 =?us-ascii?Q?E67mH0slWbiSqEF6Yr5rVvlzGTIk3jnH5KG330WqvCX8LRqzKeYBhjV5E/8p?=
 =?us-ascii?Q?NftCDCX1H+8acfOLqj4WZZdvoBN/1VdrPcvHbBrDn7CqdQ5w2ebYa7S5lpM0?=
 =?us-ascii?Q?Fsja5nBfgQl9qONLwu7iSNQRbwbU64smeaEYjULARuib29MsY4VkNo0V3ZQz?=
 =?us-ascii?Q?EXknJA2BRLEZfMgkchr8CFZUlK9Ek/aBg6hD/QNhPOqDdK1WVnOonvrNT6X9?=
 =?us-ascii?Q?M9BNZfOtqf9TpIe80nKPTFWtM2UXuQI5oaC2sQD7EfISbTFlOXwJTosSfGkK?=
 =?us-ascii?Q?CbdctyvIwkC34FkYcM1/DO5pVVNY00FuP8S9wsIzAr63QgonSsNbqkvOqSBx?=
 =?us-ascii?Q?b2QGqR+ORteeQy+ygWm5DIqkdBbZNqSP5lzrJs3mbk9XnIrUBT6RhnIr7lVq?=
 =?us-ascii?Q?EOngqFenuhQ1A4pltaitBCZHPEPuz79v1/ct+ryQxQw6sjlTcw8bPFURUQ1f?=
 =?us-ascii?Q?d1kbRaN3A1gyn2D6+wskv78ES5u8/hh3swnAdiXIKIjEXcpakWqm7/g29jWq?=
 =?us-ascii?Q?YbrtZvJMza4pVmXSubDAoZkR5tWOoW71BpQJHgKwoWxm0KAjKixgWpw7+JZl?=
 =?us-ascii?Q?66E8csQTMx5rHaBU9/8E1vxycFbF1Cc2mSva750vfmb4TQHUt3iOguziVX9V?=
 =?us-ascii?Q?Bi/pprqZ3gk2NBIwUpv8MdsYBHsaxTMpkUlSoKbhwBHYzAd1dxGix02GoUTe?=
 =?us-ascii?Q?pAXpit/oCw2nO2i6wZj+piSjdq9BbjA2KPk151plssCpKOxpZo8CQU+Rb80c?=
 =?us-ascii?Q?eJLNd3odiVtE5n1T3j7ji3UtTKW06rxZYL2igvNzKyVEIrp1QtkXUXIkX4f3?=
 =?us-ascii?Q?MDGEpYCmElmd5tnU/lg5yoLl6lz2HrxcUp1I35iuXYSsyt2THZxSYagTi1pG?=
 =?us-ascii?Q?GGMdQSlPARQqdSSCztbRAhE8TKel7Bf0V1wGOZqgHqkmGblY0fxr8bbxK3aW?=
 =?us-ascii?Q?gHAjryMpOEbQHXbumuIQXYDC553K2fkhYBoHPoqGI4KZQA4L04U2HyG4hzWs?=
 =?us-ascii?Q?/LARqIM9mrTVS1tGrcXInsPzAi8/gKRuFeWThEOjVOVj1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LDBB8NezRp0eiNRvJ87mYZBPrDZuAG2WPqBZV81LObxiMYsyxsUOcWO/o6Jt?=
 =?us-ascii?Q?oli9FJvt58urAXG+0wf58XXcM+PvsAjGhsEYX5HbU7vu5rWGuwGzhKN+M5+8?=
 =?us-ascii?Q?jaq2+L/h79SgEuvKaVBPJRjuDbBSron9TMRFwroBQpy93a4Lw1Pl7VOARjIo?=
 =?us-ascii?Q?mhMiPXfyzKfLyZ6Kgs/ejgXF9AouktVckpLr0BxsevtHb8TGeUmlpWdEshSM?=
 =?us-ascii?Q?p1X18Huc0p2+0RGcD4B8QaQhT+ThZSQH+0mBs/2OokKi4x7aBvkWEB1gTXqU?=
 =?us-ascii?Q?0KbniWUoJ8KYb7E3IdKKbSRnJn/vnBGEI+xm4Y+E/sbHy1ssUj+hk0JWcbdM?=
 =?us-ascii?Q?IaFV+NM1ZoTGlM4a+j0IHY+TsEpKlXv2TH7ZNoMrpkeo1hATfFUUOpYJhRkS?=
 =?us-ascii?Q?QSdt93ODcznsB6u79MJ7kng4qfAaag0Mo9MVxlZYioi7gw/VTR/1A3k285Vs?=
 =?us-ascii?Q?umWnl18zsyRgzZRKz+pZ2eMm8vIGfBpABBIoyDKi4dRC66MAyZO7fWyRIGxv?=
 =?us-ascii?Q?SinkzxxSTEtDZYj3IkYhSi1mcpcvFhXmaj19fg8exgxa8sPbJRaLrzJT6TBt?=
 =?us-ascii?Q?1uXI7qnxU//wP9JzF7MGsuQOm73c4/hl83ifE3njbSKHOeXRTBow5Kvoux4m?=
 =?us-ascii?Q?yL1xgL3YVirO5hRFceLC84I90N94+cPamCmgtYYJLbSvQl88IdqwRg5amjIU?=
 =?us-ascii?Q?l0H3OjkCKUueN+XjcPTJ6qBpIWicf7qTHLGyb6+OUdmOA3phCX1hUyUWep2j?=
 =?us-ascii?Q?I04YkvDaZAWi1Iv/hLL5f22/V1TMuAcvNOlMRMf/g5C1nwDmW+5nEUH/p3Qj?=
 =?us-ascii?Q?21DrTYVwEZnYViB0AIx5zpwzMEiAf5hcwBZBykwIOfCi2nkIaF2DM/YOUZR4?=
 =?us-ascii?Q?bSbDfFLg9v+b6VXGYJWVQKCRZBWlzQvremLsY9JI/NZp0O0pSZiCpw6/WVKu?=
 =?us-ascii?Q?XFzGgUNAXoFk4kGXkn9+Mgc8ZadHuV/nYYbHEIKjpNiJWGwe6dPzSG+eKR+L?=
 =?us-ascii?Q?G79+f+uKlDiV0pgjfEcTm5NR0Gp3ulEQ7MV43fn56Lyzu1wmZ0YABxYpfn9s?=
 =?us-ascii?Q?Lo23DbIiNapQ32WX0J2b3Q13PsmIapg3SbncjrljucCVcju79ptjSnBxaXWS?=
 =?us-ascii?Q?5pl8oHaj3ph+sH5JSSDDtmJ+tUlUzTKH+8L6Xee9en85j4K3bFuObZRA2YkM?=
 =?us-ascii?Q?6TCzLivHID8y0GGAhjVyx7ldZfoPApLH29nPl2jtdYfo4HaPJ6bYJdF1Re7g?=
 =?us-ascii?Q?mNFJ1hg8utRzoL0T9D2fwhtaCwEfKP71GyJGE/OhNDfCFOT6vdqJeLE42kNE?=
 =?us-ascii?Q?WxLMF1AC5v/V2QaKts+WX9oL5z/Q1YHzR3Oim2w2RW7fmOYba0fKtDMxS6eL?=
 =?us-ascii?Q?m91HByrHIM3TV8rmLx8RYEO0zKuCPlcOYl2uDDPpCFXefehhlwocLsdH5yKu?=
 =?us-ascii?Q?kL6KNI3guSzk2FcPvNDqiP8UpioFVIrOYb4ivtyhh5/grmUk78cuB3R6X8J+?=
 =?us-ascii?Q?92HvPdYhGfLuxB+aNKHjg+zmICPXIZZ5FaarcotU8X4f+Arl0FnEsB4ErPIF?=
 =?us-ascii?Q?4NFvRomlGynnmDnaR/M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563f1fa1-a071-4ec6-28b3-08dc7026526d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 12:48:27.3173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c59Vs5tcnOQQ1cVWvt1lPNeFwF0Xnmi8Qzwm3j6z5uroCAQVApUANd93y/C9g8Wk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Thursday, May 9, 2024 5:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Koenig, Christia=
n <Christian.Koenig@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Fix code alignment issue

Fix code alignment issue

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reported-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                   | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index ec9058c80647..110f2fc31754 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4381,8 +4381,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
        /* under multi-vf mode, the hwmon attributes are all not supported =
*/
        if (mode !=3D SRIOV_VF_MODE_MULTI_VF) {
                adev->pm.int_hwmon_dev =3D hwmon_device_register_with_group=
s(adev->dev,
-                                                                          =
                                     DRIVER_NAME, adev,
-                                                                          =
                                     hwmon_groups);
+                                                                       DRI=
VER_NAME, adev,
+                                                                       hwm=
on_groups);
                if (IS_ERR(adev->pm.int_hwmon_dev)) {
                        ret =3D PTR_ERR(adev->pm.int_hwmon_dev);
                        dev_err(adev->dev, "Unable to register hwmon device=
: %d\n", ret); diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_=
ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 1e09d5f2d82f..e8b01662e164 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2557,8 +2557,8 @@ static int smu_v13_0_0_set_power_profile_mode(struct =
smu_context *smu,
                        (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D I=
P_VERSION(13, 0, 10) &&
                         smu->adev->pm.fw_version >=3D 0x00504500)) {
                        workload_type =3D smu_cmn_to_asic_specific_index(sm=
u,
-                                                                          =
                                        CMN2ASIC_MAPPING_WORKLOAD,
-                                                                          =
                                        PP_SMC_POWER_PROFILE_POWERSAVING);
+                                                               CMN2ASIC_MA=
PPING_WORKLOAD,
+                                                               PP_SMC_POWE=
R_PROFILE_POWERSAVING);
                        if (workload_type >=3D 0)
                                workload_mask |=3D 1 << workload_type;
                }
--
2.34.1

