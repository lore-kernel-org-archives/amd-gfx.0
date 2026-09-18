Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2265C88E75
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 06:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3817010F1AB;
	Fri, 18 Sep 2026 06:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DjFex+WA";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1310B10F1D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 06:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmXShWN2o2IdCmticJ9x5Eqn/PXSnJEHXDnyTkQbDpakcKBvt3Uqn4gXPWJdwcat/OO7J6LHcPt/c8R4XWZ+s/Ayd7k/I8zE0u25DfUghG8N89Pz5mMhcaG4Q8pu8NtcS2Lflfya6WzJjZSpPtzmc8BFE4Z5/r45YMNoTJPicoN/mCSJp3fkWQbWgl/geLtNju4DFBeTwBiA1uM5Ha/h16mIrW5WHvekXMMJt5OO7sMWxxfzOlPkGFuDFXwnAaaktypCsROw8qFzbRptjzvEBP8fHWgXgjBEg/V6nRC/j155wT/KiWaxdKG9/KJ0K9nnBN7JU1sUgCs79Ab+j9NPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOJZ853c3Vc/CmQ/XPua2t7sbS87oQGTA4exJmmvkA4=;
 b=ymET/HVwYNlCH2iQc6gziXAbbCeYVWxqvorHeRQf3yU4TyJAzdoTEEoYzgBUDfiYK1cauCa6/GLUy9Q0eWK4qv0IFIYjho7VXTrRfhfol914hUmFilGMtygFq576i6vjGJRHzNcNKTQxSpDYiMaPBCqJj/byhhINwvvdsJghynx9ivh7YMWyhMe90S3pmyFbCy/PRYAjeWl4KKnoqRMR9rLYT0JNKr6Fo70Q7lQWNOxyuPEO/cwVvZuOsb54utMSazo/sY1ujBbWqwwkFiIc/XSZBbvUlnRynIQrOc91MvG9G68sRv4NuT2eqxKS/7ZgrLoKcN5rQ+3wRdmuqwXPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOJZ853c3Vc/CmQ/XPua2t7sbS87oQGTA4exJmmvkA4=;
 b=DjFex+WAJkOcr4nCpPPe5JgUY5uqVkgtuoW6qCuJVrgAIIypi78kGItfV3Ku6K8pS+S62YJ/hR5ljVZcnjEAzwvLBZk89QyNbqkVfm6auyrRQu9EpBkKzD+mYqF1RQDF+nwz7KYNy941Y0eAis4brZFRA7/qCgpmyy4zpYoJ83M=
Received: from DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) by
 CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Fri, 18 Sep 2026 06:46:34 +0000
Received: from DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729]) by DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 06:46:34 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Add NPM status sensor
Thread-Topic: [PATCH] drm/amd/pm: Add NPM status sensor
Thread-Index: AQHdRzRnog4wGiL71kSrqZSytsAiGLbT5HbA
Date: Fri, 18 Sep 2026 06:46:34 +0000
Message-ID: <DM4PR12MB57486DE4D5ADE9AAF47A37EC8E872@DM4PR12MB5748.namprd12.prod.outlook.com>
References: <20260918060955.1802688-1-lijo.lazar@amd.com>
In-Reply-To: <20260918060955.1802688-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-18T06:46:30.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5748:EE_|CY5PR12MB6479:EE_
x-ms-office365-filtering-correlation-id: f3cf5f9f-4f9c-4c12-de33-08df1550948d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: LV4Z5fkQwUJsV8ecOf8C7qntJbLmi/ZF8gvS5gk6zQYFQy1mimedsEu39QsCUeuMk88KIF4ms3iOmrGkAc1VDTdCzq+z+NEb17Ork1miCU2TVcZ8wiujo9eaRORPFzHy9MugGw1KgI3LsY7XOH1iVYFTl5LMh+JPuwneKHhbNHaynNDjq5O7QE4fhk13B57+jpBe8aUHPjfk5oAyWUWW+cEOSiz2Hi6Sg7Met4YLM3QZdCruCH6BrvJPW9XGf8nxfJM3S/5xTjGZ3d12q+dWzJoda1jHlOYb/Zmyca0HzbT/a6K5JLGwqAgrbzFAqYIHAGre8hj4MYXkGDnprtAD8TOH1uFcFs0RMhlZpQx6NeXKY8vQmAy++3QXu1JPl3eZXp+ud9ZM6xd75ksqh054M0c4XOxvhCRErr8V5q6Zrzr2bDKNwNaqur/tI8oVAf3p7KIIEZVLnhPWRafb+9P7YB5s6lLKdyh4PS5vRb5UGS0ned6RHmmf/DaT6fQj7y7IoFGujG9gUQkoA5VjfUklwrZyv70vaaPx2FBo+gKcIjFE0l063N0uG9s6qMdF/3whWc0JpT+cOOu4Q9cUejKL5Q7mR6Wm1TpGbyzdtpvM2zL+FcSM1wboLRSLpMSylshaUaVuQ5qMoTPkTK8p0+ybfNs8kiXkRJieEJZnh8lz48flim5xg14dk8VGfRbMDUQuC/EaOAP3LBFY8MhmuxDjEM9jo/Zao8qqL36+Wmu36SI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5748.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y0Q+7gVGQnVXatSlarAAA9VhVR56NX5wmefSUilrFYuYs3s/lbJLnIsANbDd?=
 =?us-ascii?Q?DasXMiF6MIDVfwZSeS3X235AAcuhvHdkaKaJquYo1mpqTe/piMqnSdEjuhBC?=
 =?us-ascii?Q?dPHJQa6G5a5/YJQyj3DZCDrNuqLGu2qTYzfFTrz3reEHOl/t6JqDey6k3hso?=
 =?us-ascii?Q?uiAScH1ae8ZmrcgDlPlRrvrmJb1d/8mkOrnD4F5H8n0a+Wi5bBB1TTaH7FOx?=
 =?us-ascii?Q?TK5d2ZaFJFoNdJwj39YhUZ5t/bxg+jTD61oWX4XSwh8vMxFkXGk5d6P9IqmR?=
 =?us-ascii?Q?p7ozajJhTkCOWdh1wgNB93FxVoDIX1TXgDEd2h4sYIagNSZhlcKAtvK6hRlE?=
 =?us-ascii?Q?wAvBfNYuuydAkeeMjo9cHFUwpk1mjMGmMPCAy3NE3MVZWeKinM/aDePde4Z2?=
 =?us-ascii?Q?WbV/h3zpARxZBLKki75he0Lmt5EfWvJ2rjySTLRnhEcfq5mLRvHsEKMcVLZf?=
 =?us-ascii?Q?KwOeNWiKL/FQZxBqYjhQbfkWoaqvfnfJzg6Y8JF9uAhirXMG9g/KnfyGCnbQ?=
 =?us-ascii?Q?FEsAdG45Y0LyGvwp1jQQQSUcPiojH8t/IsZSqJ9+0v35A+oimHRS8eDHnKGi?=
 =?us-ascii?Q?nbq1i2+2LWttIaHsY0+FhtpoKDxynJy2VCaCX/OEr84zQG1hCxp95kFmJb/f?=
 =?us-ascii?Q?1VXh0o8Ea7enuCc2dJT9qVnbdfQ9A3ApDRnI30w3hWnDXN5g826G7gNb0Huy?=
 =?us-ascii?Q?U3WBjGij/afasaCTWLWyIDVtOMgGl0kjs4grxNA4oz2ubqLUc5ScdJsnqyYS?=
 =?us-ascii?Q?vKKPBFf5Uzu1C8+xg//BOVT/xC/tXPUvGH/wYpOmzs/p7oZIUaAYbMVN2RAi?=
 =?us-ascii?Q?aKKzHFF3VfpWXCaWFt0aF/XQPfR9uAOftmYuk20AD6X5WAWY3moUvg65F2zq?=
 =?us-ascii?Q?JjdAi/J+w7tBRVeVcQ1kLk35mAPKd/FmsgnnKcqViPL/PIv4Q1YDB7CgClrI?=
 =?us-ascii?Q?HJEniWn1YmTrf63Eba+jfF7mWP3kib2QMdD78vjxz4/I60zqU5OqMVQ/gjMk?=
 =?us-ascii?Q?y115BKNPGCxWtiPTVsYrAeSjIpVR4z4bw4Xh5w2VwPXr8OUSSobeFxgsnyq4?=
 =?us-ascii?Q?cM7rc4/ixVdUx/k2equLFQQQbpCKpq1Fkxd29mbtD6H8kN6q5rbPDb1adsd6?=
 =?us-ascii?Q?k1ux+WpHsYq+KxFiasvzLDytyzN1AlQ/sKUc20EM6iOjqEOESeuI4ngS13EU?=
 =?us-ascii?Q?vNCtFmEZU1YN1Ojuktke04KEQeohN/OkmzoID1qFnjv4iG0gv/XUrSpi0myP?=
 =?us-ascii?Q?kyeZnXcDvTXhVaH/SHqBnjJAs4hNauoYuNMMVgfQSLJw8L+v7mX0RCoRq0Gl?=
 =?us-ascii?Q?6uV5baUUruwvTN5uP0tVqeFNZsqpMtWxURWhsExE5itKnHoQEeZK7PdM4Thj?=
 =?us-ascii?Q?h49z3qKlM96mNI/xeFeamT8g+iQE4XJQ1tiSukKcwl9xjqs4JHLwcpI/gxhp?=
 =?us-ascii?Q?HmOd1s2xZhLE4TwhYjEqysEkloe3Op103O5PaZg7ChOc4J4im9ihl7J7NHjk?=
 =?us-ascii?Q?NduaCyYnGxYnBxxwHU3DAaqDUaHXIZA2QQ36czvhqAk0dJfLp9SH+motdI1P?=
 =?us-ascii?Q?50xknUjpR6ds+1vvIFG5pGAN6kbRKeAw8oBiH9Ii/KECAgUI71rhukAZ96Ws?=
 =?us-ascii?Q?MPFh0dloOKeHu+kew8YKGvKWhJXxLplN2+kOhLUZAPtOZnLxI3CwtDIqQTfW?=
 =?us-ascii?Q?0VNMZHQYfbi6JLg+lyq/ZFvHuGmYsnaOiEHh3etfpJXLDV7k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cf5f9f-4f9c-4c12-de33-08df1550948d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:46:34.3493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEotZgdhBA5+xgJFQKVZbk0Cl8A9HUsgcIwPewe9nvS0VNT89rK5RX0BRMt6qhAKQ88DHf7O2MclRDGGjMEh0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 18, 2026 11:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Add NPM status sensor

The logic for checking whether NPM is enabled/disabled stays within the par=
ticular IP version.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h        | 1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                    | 9 ++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 3 +++  drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 1 +  drivers/gpu/drm/amd/pm/sw=
smu/smu15/smu_v15_0_8_ppt.c  | 4 ++++
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 5e8476c4b808..4b863a2e38f1 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -172,6 +172,7 @@ enum amd_pp_sensors {
        AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT,
        AMDGPU_PP_SENSOR_UBB_POWER,
        AMDGPU_PP_SENSOR_UBB_POWER_LIMIT,
+       AMDGPU_PP_SENSOR_NPMSTATUS,
 };

 /*
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 6f8252376127..c6e3748bb11b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2266,16 +2266,15 @@ static ssize_t amdgpu_show_npm_status(struct device=
 *dev,  {
        struct drm_device *ddev =3D dev_get_drvdata(dev);
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
-       u32 npower;
+       u32 npm_status;
        int r;

-       /* get the node power */
-       r =3D amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_NODEPOWER=
,
-                                        (void *)&npower);
+       r =3D amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_NPMSTATUS=
,
+                                        (void *)&npm_status);
        if (r)
                return r;

-       return sysfs_emit(buf, "%s\n", str_enabled_disabled(npower));
+       return sysfs_emit(buf, "%s\n", str_enabled_disabled(npm_status));
 }

 /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 0ca5973391e8..1691a0be4f7d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -685,6 +685,9 @@ int smu_v13_0_12_get_npm_data(struct smu_context *smu,
        case AMDGPU_PP_SENSOR_NODEPOWER:
                *value =3D SMUQ10_ROUND(metrics->NodePower);
                break;
+       case AMDGPU_PP_SENSOR_NPMSTATUS:
+               *value =3D !!SMUQ10_ROUND(metrics->NodePower);
+               break;
        case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
                *value =3D SMUQ10_ROUND(metrics->GlobalPPTResidencyAcc);
                break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 83a5a4614a4b..95e288327e45 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1678,6 +1678,7 @@ static int smu_v13_0_6_read_sensor(struct smu_context=
 *smu,
        case AMDGPU_PP_SENSOR_NODEPOWER:
        case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
        case AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT:
+       case AMDGPU_PP_SENSOR_NPMSTATUS:
                ret =3D smu_v13_0_12_get_npm_data(smu, sensor, (uint32_t *)=
data);
                if (ret)
                        return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index b69efaecc1bb..5c8bfe7ecaa3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -618,6 +618,9 @@ static int smu_v15_0_8_get_npm_data(struct smu_context =
*smu,
        case AMDGPU_PP_SENSOR_NODEPOWER:
                *value =3D SMUQ10_ROUND(metrics->NodePower);
                break;
+       case AMDGPU_PP_SENSOR_NPMSTATUS:
+               *value =3D !!SMUQ10_ROUND(metrics->NodePower);
+               break;
        case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
                *value =3D SMUQ10_ROUND(metrics->GlobalPPTResidencyAcc);
                break;
@@ -681,6 +684,7 @@ static int smu_v15_0_8_read_sensor(struct smu_context *=
smu,
        case AMDGPU_PP_SENSOR_NODEPOWER:
        case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
        case AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT:
+       case AMDGPU_PP_SENSOR_NPMSTATUS:
                ret =3D smu_v15_0_8_get_npm_data(smu, sensor, (uint32_t *)d=
ata);
                if (ret)
                        return ret;
--
2.49.0

