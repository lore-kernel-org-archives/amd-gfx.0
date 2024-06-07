Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B724BC27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 06:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AAC110E126;
	Fri,  7 Jun 2024 06:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pNAFNgBM";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0EDB10E126
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 06:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJVuV1SJBzaU11Nsq39WHbDND9Xpxn9DCp7YHI6XYKvHSYunyRFZwWH6+B1PNnRH3pii6ko5oSbPfjnqv5DngvUld45kMQ4jUnEdIe1pFTyi86zO9bnDrPiv2Bngc2h0j2vz+HeHRrnuXfjMiMKc1bNqne7mDH0J2pVjCiFg9IW4nh8XGutShn8njPq4Tx8DmyjtfchpyXCfSiP4Ya+TmjyLglkR/qWM901wTMVvrWw87kSpR1hVjCQyaf38I+F8nTHGUqvm/suDD7eLDcuxVeZ9fxAwA+1WDbqreC0HFL1IC1XvEBsvmkPLK2Xsypahd7pYqvE4PnjDRRtuJPi6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2mKcCM/HYuDK9Ror3AmAsZxUP66mK6HyBynO/zF/Fc=;
 b=LLpluZvrGbYfPPH8IkOC6pJ1num3Nrtx5YBRw7cDdCOIfNWHPhIChTXVDh+F5rYIl4JVoyIab660AH9MLZ9q7OfhwDIcz+QJnefgLP8OHHThzqB7YWzr2a7tuB1jkf9QtecKXOGdvOUjxzVEZ2VW7v7nQ7wLDb7Mg6NR5dtS2jhbNU/N/MSiFm/e7O+/jNRqVamiWba96s4XDXuqYG0WmJJfCeKlLjcB0MznHI/D89KKd+6d7cgBq2nMchgr0GYLa/zoZ0nsbIYNoejyt8Wn8itXz262rWCthw0SkfE90oxJ/nyfucYShD+YJGCc/SyhsN+DMyqmBTjBWZq6pNiIxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2mKcCM/HYuDK9Ror3AmAsZxUP66mK6HyBynO/zF/Fc=;
 b=pNAFNgBMvenatB3A/+12oSIMg6UJCwGE1qFY6F83t95d2QGh3ZO0g0LFsnwVqkYgYp/OgyFUsK2w2RYX/CdpoFFv1RNxUpi26G6/gM6KF7TmWrBDUruydYevReKPn8/EuXYkvw7DBWAE6/inGOFYok74n8w5eZYneh8r/qOGNRg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 7 Jun
 2024 06:02:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 06:02:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: update check condition for SMU mode1 reset
Thread-Topic: [PATCH 2/2] drm/amd/pm: update check condition for SMU mode1
 reset
Thread-Index: AQHat/kp4r2R1Hw7JUyxATOUw4yy7LG70Ixw
Date: Fri, 7 Jun 2024 06:02:42 +0000
Message-ID: <BN9PR12MB525777CBE78564F2B7703E9FFCFB2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240606100547.22269-1-tao.zhou1@amd.com>
 <20240606100547.22269-2-tao.zhou1@amd.com>
In-Reply-To: <20240606100547.22269-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6597f4b4-bc85-4d49-8c28-0315684d484d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-07T06:02:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW4PR12MB7264:EE_
x-ms-office365-filtering-correlation-id: a464e36a-39e2-4291-bd3e-08dc86b7717e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?sHaUBHw3Y7m9tfHtpKHwX5/WmYjgB2MgZ28YiPK8riQ/H6RhE0rQB+uozfXO?=
 =?us-ascii?Q?JSUsdyx/zVIY+wD7Mab5ydmIjJDEq9aN10o7Ewjv5ZW4h46lcXBZz1QmpbL0?=
 =?us-ascii?Q?nEsWtPPnRYb8E5sDZ4f2gIGthB6wMqQ51XvX43AETKnkByvTqg0FXHXzeklu?=
 =?us-ascii?Q?2K41DTinGXHXLP8WEKynW0JYHkctDk6Z/4f9eyIkr4s1EQy7nqBENIqAkgEP?=
 =?us-ascii?Q?UG/dSWlZ2K55hE4kwB5E/f5U7dUMMiX6ypUtZq4MQXo0gU3uDL1kGLOEWbmK?=
 =?us-ascii?Q?6L7ytQNZGQ8L1A7jfz71dLrxK2X3FqE4uiyK6FOt9cKXO3Gf4024siI2KnD7?=
 =?us-ascii?Q?0cguyUPHchVXMXV2nfi4JxStsYQClzUg1xU5cPkZzK2+OIWUomDLzs0B73GT?=
 =?us-ascii?Q?1JXstjna5E44fpi1wS7+X0g/caS8b50l/AVjo6G7tP/zJmPmd5QKnu2k4qre?=
 =?us-ascii?Q?ZUoX+YUIH5FIj2Uh8IaQa1+4P1+sqy8sW7MwBajz5jU0mwUbWLZBnkJal5SI?=
 =?us-ascii?Q?+flo+b2qRgsj0ECM0PSzUdQC+kESlTpYs80qvOASOhY2Zk4++ohNUADoYfJe?=
 =?us-ascii?Q?GaLymMpPC2Gy+2HzuwDKZRDHL+ZwALVmBwc6a8gfNo3pD8oKcAoSBxTWMBga?=
 =?us-ascii?Q?WwqaThKe9BZ1P3wOLU+hCE7jx0joDDwXJuK+WM8FmDkYOIb3mbodONGrTDhS?=
 =?us-ascii?Q?uarpY7l/jciYXzDOIZKfXKLyooBXST3gZ/L6vQ0YumilOwEuqtfJTZ9nkWyR?=
 =?us-ascii?Q?sPm2rKM7ozqjM2La4c9p3Ascr1aKmdb6p5hO5koqDSFgYMfuMTLZvOJQNTaz?=
 =?us-ascii?Q?qdbW/ZAkJ8MkWRrC/wne2A+3PQnC7y2NsUjcAwDkSs5E/nv/+FX0ZysBYNgV?=
 =?us-ascii?Q?DvLgr+Q5RSm5LbiBZXfg3gLYAwgfARA34fSKSS26R/gJo58vEfmphgZHx56Y?=
 =?us-ascii?Q?PU6qkUPPMV0zh/Mklx7oPCwcBkZJfpqbGfCpLI4Ok42/8UlXO03hgXLG4gf3?=
 =?us-ascii?Q?YNAV41bhhDjNvBI0xqFLSQxq6u1EEYI3/05JxZI68AgovRCBub63THW0PQ5N?=
 =?us-ascii?Q?eCee7uBhZUJ/b0vSK0bHMCpE2mSYtYlFIF3zB8fsSLyvSaVlUYqbsKLOFjsU?=
 =?us-ascii?Q?CbMmS8AFUirDmfIyr56eirjerP3zBC7BIghkIFnDqKdvrAwJKi6PGK9wc2Zb?=
 =?us-ascii?Q?xlSp9up1MVGDgQIIInSQhSSOHlWGhkuL5UASqOrQxqHDeK1s+R8QLnEB5KXL?=
 =?us-ascii?Q?5a/Dm91GlaNFti/nNf6u6M3bsTQbrxACx1wrydsbWoCfOaWU9t4I5CAb6wP+?=
 =?us-ascii?Q?Ka66h3ECzavmJWrGgHClqThxYURo+pQ1dREYLKzkWwxiZsqqxB5MgrLKhNur?=
 =?us-ascii?Q?/EitdHA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3MFxKs2hksYByaW7ycpQ0W609aCJChUGnO8sdFUuENNe6PxzL86zt5MLGNXg?=
 =?us-ascii?Q?JujSzC1zHI0PC8wvzt8EdlJeZ4bAYJnM8sY8ekSks31taPgpP53LgjoAdiku?=
 =?us-ascii?Q?vCZpi5HGrW6UHv1BpvefsRJCcLl22tFYJzNSAg1WhHCKguUxU6B9JOrtB0KW?=
 =?us-ascii?Q?c8EM9q5IlG8QnfN+8ZuYINHprgupX+ZgYVTowiIwNN3kz/Uk1S9LWnqkYRAb?=
 =?us-ascii?Q?97q37pxpIn9YnhHxM8TrQIx5xgjtrt9HqVFTlVAmWsoAf3Od5kujKKhvuurv?=
 =?us-ascii?Q?HjTGPbDaR2YQUw56K0rFsnSa7WH/kqAGHCsAoXV2oVgawBT57K/cf67DYghi?=
 =?us-ascii?Q?DxZ8EedVTcS+1j9h1rjsBqXKPtSMuQLTGBJ00li794n/LP06o+X2hyLbvYD5?=
 =?us-ascii?Q?/3G2KD/Kj9y+0PdLS+knW70/WSaKqeJM/NU5wLswHa4JaAs0W9bhTNpWgg8H?=
 =?us-ascii?Q?ZqhYMqILIcjvZY3qFA7M5iniMPIpSGEw6qcdeCDSGnZLdBRjF9vTBowkLkhJ?=
 =?us-ascii?Q?NuFaXhqNkFuMylZHYxqf4G5cSJ+7fcIOHCHr5lHQuKgIQN4yhLWVjJsUmjng?=
 =?us-ascii?Q?dDVS4ONwSiMtWiQVhXX4WGbhlq3rakPuKPi/YPkfSXCYm/8vNgr+n+BW2+S8?=
 =?us-ascii?Q?nGp/N3jxxGw3ttzYTo5ey1BMY6aw6qNRPgBFkIhVKQeWyJ9x6S6hm3nEvTws?=
 =?us-ascii?Q?WhbqABLmPuNfCsRi0Vsa6anPR3OPMZOMOgz/RwsNaTrRq71AZL+DvrDVWPau?=
 =?us-ascii?Q?W3iFlLck7sQ+n4YpVUdAWMx2C4Szae6j/qFwgxc6CwMOb8mml3oCDcPEqVwz?=
 =?us-ascii?Q?aKrjCWlJKMYEs+DvCzZf/JjYnRM485OdUCZZ9Utp91ppTDcGXoNOgplcZK/s?=
 =?us-ascii?Q?XiZyiDxk88HpdVEp4SPu0eo8ZuTWnAHAh/ruvam91Vsh4xrrQLxU5wxjOdKG?=
 =?us-ascii?Q?3a7Nj/y2+FkS34wQlLvVoZ+jqIiKJE19cEfcXji7co0K4Acm0+GGohsRt7b1?=
 =?us-ascii?Q?q6cc/OMmFLxQoTL+y/WpmVfZ8xl37qXFHKTo0gCALbrjvrjgwx0B/WiwnECA?=
 =?us-ascii?Q?fujpALmz3EVa6EuC/m5xvHaM4t+qVMldDp4l4lcyft4QeF70Bx2+AEuFgMdU?=
 =?us-ascii?Q?PrCrUCl0ne3xjPyXDBvt5jicuw1+HuZ9B9/4lMaNegCbAOMP/l70TPiaJa6e?=
 =?us-ascii?Q?75xccwIk8R0O3H1t15GlUAXs22iVu18iLLzukVKH5F5XmnzgVwU/QK/Kz93S?=
 =?us-ascii?Q?D0l0yQXNe+Vz79+rXLkHNnVthCSYfpKU2FMjb/4F7PjVFZAz9p3riS370AST?=
 =?us-ascii?Q?pxD9DvCcWlA+WskDR+OkHJuaSSNJm6xG55VKYGVxF8JahCv8bNG3R6Uh/EyY?=
 =?us-ascii?Q?fYuYM5TkckJ1sLI6R9kps01/1U2i5GgOTW+oKWQtlXlm5eVqybD61GCjXELS?=
 =?us-ascii?Q?mo3E/eYuaEGv+7l/I4Os0SPGsheA7haujePJIH2DCuZwtH4ol+yzvBrxffNP?=
 =?us-ascii?Q?Fa5DLeUAjl00cf9KhVFWpaAUvQ0OJYTMfloQIM8o/2xjp1jiwfc2SdPsCxCQ?=
 =?us-ascii?Q?Dh0oJG3xIF4SqeDjbqcARxsD0ERIrMk1lw+SSX0f?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a464e36a-39e2-4291-bd3e-08dc86b7717e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 06:02:42.0767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKPHd2x1u1zkyRDLdVaJWPAWpo2SB41VS59gI/6cgOleX+6TDEzZjeZDDFNOsJLsoCL+tsT4s2PdEf+Yiii3cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, June 6, 2024 18:06
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: update check condition for SMU mode1 reset

The fed status does indicate RAS fatal error.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-  drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 04533f99f1e3..2c35eb31475a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1876,7 +1876,7 @@ static int aldebaran_mode1_reset(struct smu_context *=
smu)
                /* fatal error triggered by ras, PMFW supports the flag
                   from 68.44.0 */
                if ((smu->smc_fw_version >=3D 0x00442c00) &&
-                   amdgpu_ras_in_recovery(adev))
+                   amdgpu_ras_get_fed_status(adev))
                        fatal_err =3D 1;

                param |=3D (fatal_err << 16);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index d1766a603bb9..c9639141792f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2788,7 +2788,7 @@ static void smu_v13_0_0_set_mode1_reset_param(struct =
smu_context *smu,
        struct amdgpu_device *adev =3D smu->adev;

        if ((smu->smc_fw_version >=3D supported_version) &&
-           amdgpu_ras_in_recovery(adev))
+           amdgpu_ras_get_fed_status(adev))
                /* Set RAS fatal error reset flag */
                *param =3D 1 << 16;
        else
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c1d7528a6dc8..7fda7196fa7c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2580,7 +2580,7 @@ static int smu_v13_0_6_mode1_reset(struct smu_context=
 *smu)
        param =3D SMU_RESET_MODE_1;

        /* fatal error triggered by ras, PMFW supports the flag */
-       if (amdgpu_ras_in_recovery(adev))
+       if (amdgpu_ras_get_fed_status(adev))
                fatal_err =3D 1;

        param |=3D (fatal_err << 16);
--
2.34.1

