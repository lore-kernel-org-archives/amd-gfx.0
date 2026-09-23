Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E54CC982FA
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 09:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13FCB10E85D;
	Wed, 23 Sep 2026 09:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vrcwg2N2";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012053.outbound.protection.outlook.com
 [40.107.200.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF2810E85D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 09:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNn6mCJprVKdgjcChepu85jLx74tzQYR5S+m3r6P7/NEYikAnkrQ8178iGiANmI5k/CrB6e1C7nRTezxDnCPYdAIDHyW1sqr4FFPKatXzr1E+O1hPLRrvORQb2+3sduvY/Zt1Gcqc6kXadQ2uuMnJ+/c01agJ2hE+EtzEUGwn0PUGaeZkjfabq1cas13SbH0LdM4hpuK6rA3XpCJ6btD+nC6ICKt6FIpOVXNWmqjeY+/8JWQx3lUbcETGpY4Gn56SyD4qRzR1Ned6irbtgtzsBv/5FBo8viSSEt7M7bfNEzz1yZ0Dg7fD63JJHap5RZZY0ND8efQq+Vs0Sf5v79rRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+bYo4cffYsZHqYLlasRt/sJ0FOO1u3VVgaZ8bk7sGw=;
 b=dac8m12guUDRl5XCItPsw9ksbLUJjPlZmIQ9fWvZnfZikgYCf/1CRMMaifRnjyc9ZvDYvMj7XI57RwBwLrDx0kH2vWBY7MSagcvSAcD3RalNgBJ6C957zTjSzzlniGZ97eNsFdD/n2Sl7I2372bwXYTAhbEYNWSwJ46pYkceYBKuV4pwAYWHlhbDmhEbi5LmQYQ6lE2yZdaTtRT8XBl0SVdgWAFJujDdlZWr71Z8i9gHv1TdhWf7Fdt8WSbd11BO71wd9hjk5dMqCU9Q2BcrwK+z5iSGf/38v1J+qGGW1O+5aR/S/qtSs71xVBfKiIloMxlGUhuIg2JN+Ab9+D+DVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+bYo4cffYsZHqYLlasRt/sJ0FOO1u3VVgaZ8bk7sGw=;
 b=vrcwg2N2qRXNhU1F9wSrzx2enm/0+lgZTGHcGmi4b++Fqdd5P7B/w4bOoAVha+fSwddAkFkXbHJGwOxWHaFQC94Ml77N0xKkk0EW8qOJ2yyCsoCRIdbbfkhu2IFLSzUyxPc+JLe/xE478RFR0WjXSuoaWOIpnal1UXG9VEYDo78=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 09:08:03 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 09:08:03 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: align smu 13.0.7 activity-monitor power
 profile output
Thread-Topic: [PATCH] drm/amd/pm: align smu 13.0.7 activity-monitor power
 profile output
Thread-Index: AQHdSzfCJqElkZe7pUKu/vyQwy6H47bb32gQ
Date: Wed, 23 Sep 2026 09:08:03 +0000
Message-ID: <MW4PR12MB680318CE2D09432473EDB6B28E822@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260923084404.538353-1-kevin.wang@amd.com>
In-Reply-To: <20260923084404.538353-1-kevin.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-23T09:07:13.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|MW3PR12MB4444:EE_
x-ms-office365-filtering-correlation-id: b97e4e2b-1f31-4205-230f-08df19522c67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|3023799007|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: ZeHOhLucVGQWZEZusFkefVqiqvtHBVt0mtkp6JK9PlYK5ORCkRKUPPBKYSCJ3UGrwS1/RetAimFeDktn9HS7xmshi5kpDWQ9jK3sP4Lfo5Lw7xlifE0rP9rx177tJ+a49kvFkXZsqp/37P0H8X+FU/PoNbHtEhbtGcA0DubPC6S69Vs0H0XVlaXgMpGuaVrRJ8ie4agXMBo4LNYTcTmighiTDYMAlE3LKD38dO6OIyJtpY5I3mJ2lwulheP0kJrYoJJgqWkh5V7k18sIIOU5yGaAcBAvQWdbY/U4JqvBjFwMJO1R9potf6QuZrMLalnsfdoXtE680YWRrSWBxkSbh5htu9yeZcrssZV3kh7/kq2aMD2hGIlLq5VKK2CrCh6o6214EE8QvdgorukAu2pnNrQuCJ6v9wtfPCMO93jmnhuyhjtahOV53qi1Yp/5EpIRxeDAwYD/kwzq3c8sr4TM5d9csusjwCLywsxZ3jEc1mH2l+KszYxs0JAGjgvStPZ6qbd6kdrONxsIOI4L1QB0rXGuRs4TRktD8OYP6aGsJSYf7S/EhF6N7UbBy5pEnokxkqX5V7hR8+UDvyV5Y35j/ALRsAugmV/XGLyxdVoNCiyf7xn19CBW7uTt1sPN3m73ItloXHQnRrJ+rJdLq00xJDUfVHoi4uOmMpn+n5fzqqa8dANGDhH/Z/QznAm9gz8TZnfHfg8egA7jkUteP5G2Fnb4WP3xSPf03ttb5QuHZ7c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vgN/6LOPNs4BXa0kC7LfBJ1GIobz1HH/uskEgptx+aDi+ArrNmy6XAysAlLh?=
 =?us-ascii?Q?gEH06iEE2Bzrzc1nTTs50AaRCu9T6SffLG6HGUOb7k+0VlT7Xk4i4LUQtOeZ?=
 =?us-ascii?Q?0mk3XM9HN6vBjIISsJELDuZ4Yy7CXd0dAmxzgivmUzQlKx2Cj7kSUKNq0ku3?=
 =?us-ascii?Q?c8amOtO80dydpmkmndrzDkMUV4eBpFdwMBpVpgQg1V2akA3M9jh71UlTjWkV?=
 =?us-ascii?Q?2oQSuI2/BcydF8BR2BjAh12+rB3+dv3ZVtWUaGtjsWrWZRjbWKBn7vFBjJzs?=
 =?us-ascii?Q?lGRe7Vyz1F3q2qXBaHAoB85x147liTQ4RRK2ucpDnDf+BfbvgphfCkyiaX53?=
 =?us-ascii?Q?4f7mSUXcT+ZNHsOCxCkIgaLcjRSHu3OlSVz1pkBOx3rvORe/Pm16CnpvbdDz?=
 =?us-ascii?Q?uzQ3KKDY3p0MRLTaahp0UBeEtWkB9LUH291zr5zz2eqHwuBzx/zcqzQAJC8d?=
 =?us-ascii?Q?gBIRiMmof7nf1BrT4hyPeYCthUlNo18UpCf4G2CSXiGaJETGXtkbuVvo8IvW?=
 =?us-ascii?Q?cTKzEJjNZ0xwyVI0h3jAO4d2bvOtP08FoARYru8bEEGGCIB8TI53aKxlvGf3?=
 =?us-ascii?Q?CltJi2CbpljURVyPcxwnhOFsxTSPo4yQeXrVcP5OqtmrG4YvE0Cpu8rxFnvB?=
 =?us-ascii?Q?TCNDE6MXTAFpp2SzMAp8EL2aX5ZnSzBLjO1VCY4r4Yl88FQCzQmRdvBVsMGC?=
 =?us-ascii?Q?behmPhcU0rgCrpG0wbDFuBT5xIje93yG37T+HKsvooqJ1VWUiSsepM9nbQ0w?=
 =?us-ascii?Q?qAFiqo1PL8g0jMiS1gApRKvhGovDdskV5sMdAZYFDwf5wRUZ7fFTYFzih9UD?=
 =?us-ascii?Q?YDJZwphnbofvXY/xeq7T31CWejwaKvlKRui9+ER7aNC/sAeUzPFikC0PR0AG?=
 =?us-ascii?Q?F5cLKFKJiS82poySVku/gkdjchAS3BY6+nYSrhXMu+uPPakdUB5sz5kOpVsn?=
 =?us-ascii?Q?ZF8mBErdBBRd4UeTGR4fAjLRYF64PgewxToVz2hxeU+VHXvR092p0LMG40ZR?=
 =?us-ascii?Q?IOKLQKDNVr/QYgN6zBT2czjtCMvNxPvwmcXDluhT52nCU2JFI2VSFTKM0wge?=
 =?us-ascii?Q?FZmDE3kiYAUQKP0ha2XO8QHxyHpEV4Q2BUVsDQkB/BXUDU/2S7bkz9UG4xp8?=
 =?us-ascii?Q?YTEZiI0UPsQ1ZWzSZdHlSHzzxY5e4NFi7YJtW5UYEf7l2VQ9yjkxkRivRNrw?=
 =?us-ascii?Q?mzwoFsXDdkIUBb012Z20RhG93etpsziQBkBXUCOcuV3lKKnDla2MlIzlgACg?=
 =?us-ascii?Q?FiqhCVo/ceTfw58v0pJTQQQyiNibDQfCwvt/ANidQoHlawXdnrZ4rIIMx7Os?=
 =?us-ascii?Q?PaMUiMGTd193XnGm0NZV7YaF8pIiU2TN1JzokuXyJ3Eaf4AISdt9vcLCH3ON?=
 =?us-ascii?Q?Rph6oRCSMfBK4toA2I2kxIf/WmBn5jMz4twLRUqLJ1bxeSckzFHsfUTelVDm?=
 =?us-ascii?Q?ETwcdIGK5ygCgdkFWfp79TKKpzTyl5PIQy/DMhhj6z8D+vaaxc7F96X9ca9B?=
 =?us-ascii?Q?/qZ2msbuSJonY8m36aO6e0sLtLkfSPqB5ptcDZBnOOHZOipvX75K50LhGq38?=
 =?us-ascii?Q?pDUdzWd3hFSP/BFl3w6Ib82GlnjLS1NZ8NTbQjhr219C7tyoqcocvkqrxatN?=
 =?us-ascii?Q?fv76I3m0sjHmT5NOl/Tr8M2Na50WieMVpnOsbdr+G1XR9dNV2C0QUxsPZ3P/?=
 =?us-ascii?Q?FQN8eq70j5rBfioXxbxOBDMr1NFiNndS8GHK/+1BMLR37wGK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97e4e2b-1f31-4205-230f-08df19522c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 09:08:03.2714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+B4ALlbyxi6bZ90cy+e34wuICJExHaj259/rnkazo+AhMpRaW/CI/c+z1Ongrtr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wa=
ng
Sent: Wednesday, September 23, 2026 4:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: align smu 13.0.7 activity-monitor power profil=
e output

smu 13.0.7 uses a transposed table layout for activity-monitor coefficients=
, unlike smu 13.0.0 / 13.0.10 which list per-profile gfxclk/fclk entries.
this mismatch forces userspace to implement special case handling for smu 1=
3.0.7.

adjust output formatting to align with other smu13 variants.

Format change:

Before:
  <profile 0>  <profile 1>  ... <profile 7>
  Gfx_FPS      value        ... value
  Fclk_FPS     value        ... value

After:
  PROFILE_INDEX(NAME) CLOCK_TYPE(NAME) ...
  0 BOOTUP_DEFAULT*:
                       0(GFXCLK) ...
                       1(FCLK)   ...

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 92 ++++++++++++-------
 1 file changed, 61 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 64590965fe56..5e445ce857b1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2445,7 +2445,21 @@ static int smu_v13_0_7_init_ppt_limits(struct smu_co=
ntext *smu)  static int smu_v13_0_7_get_power_profile_mode(struct smu_conte=
xt *smu, char *buf)  {
        DpmActivityMonitorCoeffIntExternal_t *activity_monitor_external;
-       uint32_t i, j, size =3D 0;
+       DpmActivityMonitorCoeffInt_t *activity_monitor;
+       static const char * const title[] =3D {
+               "PROFILE_INDEX(NAME)",
+               "CLOCK_TYPE(NAME)",
+               "ActiveHystLimit",
+               "IdleHystLimit",
+               "FPS",
+               "MinActiveFreqType",
+               "MinActiveFreq",
+               "BoosterFreqType",
+               "BoosterFreq",
+               "PD_Data_limit_c",
+               "PD_Data_error_coeff",
+               "PD_Data_error_rate_coeff"};
+       u32 i, size =3D 0;
        int16_t workload_type =3D 0;
        int result =3D 0;

@@ -2457,12 +2471,9 @@ static int smu_v13_0_7_get_power_profile_mode(struct=
 smu_context *smu, char *buf
        if (!activity_monitor_external)
                return -ENOMEM;

-       size +=3D sysfs_emit_at(buf, size, "                              "=
);
-       for (i =3D 0; i <=3D PP_SMC_POWER_PROFILE_WINDOW3D; i++)
-               size +=3D sysfs_emit_at(buf, size, "%d %-14s%s", i, amdgpu_=
pp_profile_name[i],
-                       (i =3D=3D smu->power_profile_mode) ? "* " : "  ");
-
-       size +=3D sysfs_emit_at(buf, size, "\n");
+       size +=3D sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s %s %s %s=
 %s %s\n",
+               title[0], title[1], title[2], title[3], title[4], title[5],
+               title[6], title[7], title[8], title[9], title[10], title[11=
]);

        for (i =3D 0; i <=3D PP_SMC_POWER_PROFILE_WINDOW3D; i++) {
                /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */ @@=
 -2483,32 +2494,51 @@ static int smu_v13_0_7_get_power_profile_mode(struct =
smu_context *smu, char *buf
                        dev_err(smu->adev->dev, "[%s] Failed to get activit=
y monitor!", __func__);
                        goto out;
                }
+
+               activity_monitor =3D
+                       &activity_monitor_external[i].DpmActivityMonitorCoe=
ffInt;
+
+               size +=3D sysfs_emit_at(buf, size, "%2d %14s%s:\n",
+                       i, amdgpu_pp_profile_name[i],
+                       (i =3D=3D smu->power_profile_mode) ? "*" : " ");
+
+               size +=3D sysfs_emit_at(buf, size,
+                       "%19s %d(%13s) %7d %7d %7d %7d %7d",
+                       " ",
+                       0,
+                       "GFXCLK",
+                       activity_monitor->Gfx_ActiveHystLimit,
+                       activity_monitor->Gfx_IdleHystLimit,
+                       activity_monitor->Gfx_FPS,
+                       activity_monitor->Gfx_MinActiveFreqType,
+                       activity_monitor->Gfx_MinActiveFreq);
+
+               size +=3D sysfs_emit_at(buf, size, "%7d %7d %7d %7d %7d\n",
+                       activity_monitor->Gfx_BoosterFreqType,
+                       activity_monitor->Gfx_BoosterFreq,
+                       activity_monitor->Gfx_PD_Data_limit_c,
+                       activity_monitor->Gfx_PD_Data_error_coeff,
+                       activity_monitor->Gfx_PD_Data_error_rate_coeff);
+
+               size +=3D sysfs_emit_at(buf, size,
+                       "%19s %d(%13s) %7d %7d %7d %7d %7d",
+                       " ",
+                       1,
+                       "FCLK",
+                       activity_monitor->Fclk_ActiveHystLimit,
+                       activity_monitor->Fclk_IdleHystLimit,
+                       activity_monitor->Fclk_FPS,
+                       activity_monitor->Fclk_MinActiveFreqType,
+                       activity_monitor->Fclk_MinActiveFreq);
+
+               size +=3D sysfs_emit_at(buf, size, "%7d %7d %7d %7d %7d\n",
+                       activity_monitor->Fclk_BoosterFreqType,
+                       activity_monitor->Fclk_BoosterFreq,
+                       activity_monitor->Fclk_PD_Data_limit_c,
+                       activity_monitor->Fclk_PD_Data_error_coeff,
+                       activity_monitor->Fclk_PD_Data_error_rate_coeff);
        }

-#define PRINT_DPM_MONITOR(field)                                          =
                             \
-do {                                                                      =
                             \
-       size +=3D sysfs_emit_at(buf, size, "%-30s", #field);               =
                               \
-       for (j =3D 0; j <=3D PP_SMC_POWER_PROFILE_WINDOW3D; j++)           =
                                 \
-               size +=3D sysfs_emit_at(buf, size, "%-18d", activity_monito=
r_external[j].DpmActivityMonitorCoeffInt.field);               \
-       size +=3D sysfs_emit_at(buf, size, "\n");                          =
                               \
-} while (0)
-
-       PRINT_DPM_MONITOR(Gfx_ActiveHystLimit);
-       PRINT_DPM_MONITOR(Gfx_IdleHystLimit);
-       PRINT_DPM_MONITOR(Gfx_FPS);
-       PRINT_DPM_MONITOR(Gfx_MinActiveFreqType);
-       PRINT_DPM_MONITOR(Gfx_BoosterFreqType);
-       PRINT_DPM_MONITOR(Gfx_MinActiveFreq);
-       PRINT_DPM_MONITOR(Gfx_BoosterFreq);
-       PRINT_DPM_MONITOR(Fclk_ActiveHystLimit);
-       PRINT_DPM_MONITOR(Fclk_IdleHystLimit);
-       PRINT_DPM_MONITOR(Fclk_FPS);
-       PRINT_DPM_MONITOR(Fclk_MinActiveFreqType);
-       PRINT_DPM_MONITOR(Fclk_BoosterFreqType);
-       PRINT_DPM_MONITOR(Fclk_MinActiveFreq);
-       PRINT_DPM_MONITOR(Fclk_BoosterFreq);
-#undef PRINT_DPM_MONITOR
-
        result =3D size;
 out:
        kfree(activity_monitor_external);
--
2.55.0

