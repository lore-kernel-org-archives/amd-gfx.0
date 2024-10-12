Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73521D1A431
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Oct 2024 03:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9AA310EB61;
	Sat, 12 Oct 2024 03:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EVMOrkxp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC1E10E03B
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Oct 2024 03:29:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTkxjKB7x4n6Uevmc2mxLHcZQMniVnBM5Cm5cDexglcL8HibUnt8GajaG6e9iwl7cezPbpkpAQ/xCdWrcqsFuAZhNGwRCJgZ8iSxKm0Iu4UhHIBTG99/Ke0fE1ZTijjGbOvB8iZ2nVAq+Bb2/fvVXS4MW6m33fIVi5YMt1nrCpLgC7Z8XlZcS494sz4ZsPYq6uZvdJIx6CDv5U1dmDB09uprQX6ulCqZ11JV8zaN/W/raOD6T33yphIpB/PZM+zWy0b35jOvpluBOt8Do+VR5ZkZrtzPBVsmm3CwseiwJKbIR/pVyTSLiegci7w3393RwXSWxhGMwEwimrqDiS4JSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG4yiMWtcMp0xdfJ/7qt6J6GQ32WL10jfa0TZlczpnk=;
 b=Ns8CtjlSe5BNAOFIaxCHhsd5MvAtZ9fMIHZlKeukeKYzoDgzO1QuKsjuySW59AZrdIRb5B72OsR3b0q039FCJrgNLWWhBeSyp3ieCNyWyegTYBb2uT1hmsJtv/L+aaMBlGUbcpq4xqPiLETLhJ4OonyKTp8z5cdvXdPqmN54YrfsGYQR8IGjqXaS1GjAJeeRq6PfhfDoIsLYZv3r3nIO4IoP7jz5lSuXTiWA9hymmp3jS1BgYmN9p61kLngM44MfN7R7m/cQVKsu2iaIw1biHkMWzYmZG8DlZdhwKvpfxsLhocaDfDzQ7DewkySHE8ZyTIbe+8u27+nOD0iRHFMOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG4yiMWtcMp0xdfJ/7qt6J6GQ32WL10jfa0TZlczpnk=;
 b=EVMOrkxpIByy3YmDILhWojd4M2jkzHnBQ+rlDPdySKbx/lpFuILa04GpJRVCAu792w1yERI6ujkjxdGsQKD3J1Ti6pDHAuyyyAQX/pV/m/MRqs9aCvvn+MhxEdjCzQ2ULapJcyZ4aDQl8K0JcuIqtGExyeVzvPuvBCOMVq2pOfU=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Sat, 12 Oct
 2024 03:29:06 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8048.017; Sat, 12 Oct 2024
 03:29:06 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: update overdrive function on smu 14.0.2/3
Thread-Topic: [PATCH] drm/amd/pm: update overdrive function on smu 14.0.2/3
Thread-Index: AQHbHEp5xHVSnmuLbEa2Y+77np3WhLKCdRuA
Date: Sat, 12 Oct 2024 03:29:06 +0000
Message-ID: <PH7PR12MB5997116EABC350657C0207BA827A2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241012015958.2120967-1-kenneth.feng@amd.com>
In-Reply-To: <20241012015958.2120967-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a09f1908-2144-4f5b-a7f5-3ae5f010a3b1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-12T03:28:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MN2PR12MB4408:EE_
x-ms-office365-filtering-correlation-id: c6868a9e-1722-4384-ce41-08dcea6e06ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?b5QUJQfCCO0ixuAlWrqCyIuWja+BULwuAREctoyk69YOBROq2MUd2xJFmCMK?=
 =?us-ascii?Q?Jgww2peP6DPjm8gZhDGNYqTXVb5tEbXJt7uSio3KVEdSDyvfaXwg5gWTM2QZ?=
 =?us-ascii?Q?eZWe4AcVtSjevE6Ae87coGgPb4iEul7dhYCl4TuO4zM7ukhFEVUQ1aHOvCZo?=
 =?us-ascii?Q?4Qu2aWjd2gMEVmKntuDmqYFvXMaYkasUe7Y4OcbMaNXa6EGC6F/ocL6VS1QT?=
 =?us-ascii?Q?c8sI8Z2eoY8r8V0LgljI7z2OeZSwuPU+WcNuqwzP3OFvs8qGyBY7WTJdSJQl?=
 =?us-ascii?Q?ZlVKi0RT2qu2+0rLOKlSsE7csvCpAJFnxX4vmrJjxkVSFNuVVVwyF6i1NvVr?=
 =?us-ascii?Q?cgLBW3lOKFYQ4I1/KQbqKrTZ3cfV4xJwsXGpFMVgos5sTouqG/x1kYMbSLEw?=
 =?us-ascii?Q?NZcF/kN1CzaS6AVxiQM1DHgFQokS0Ax2Ru34c+tYnv3M8jpd4xTSbdUC9vuP?=
 =?us-ascii?Q?I9Vu/ryRsyGMoOc9wmXHvENHIMHYRPlkY7U9kC/L96uINy3hKWiO+h5N2tAZ?=
 =?us-ascii?Q?e3e9GVnEt0fQBZ9F/yN9IYtFSqDUTUPt2gUwTGZMfpN2AT+DlSMpYEDZQbXq?=
 =?us-ascii?Q?e/FhzSvico0sMHy83+bscMWoIAkN8DFBDVbixKKg4X63IRQPQgjUcxaQqibi?=
 =?us-ascii?Q?iaN2+QV45bcAri5B9TSQ4XcMAbxOgX3aQIaSkIIopwVpqLSmo9M4dqlocsui?=
 =?us-ascii?Q?Toka6SFGC+DRRPx3RNpTvAXXEf7Xqv6PO//RXu8wFKZeViO5M0xT6SiZ13un?=
 =?us-ascii?Q?Cz3r4v6Z1pbPIL51Y4tFENi0RE5GqxJh+w3G3UMLzY9gREG9ulslgd7dpG8+?=
 =?us-ascii?Q?DgDsmA12rahY7qlSNNWpdv99HKiX91CJicbCnf5s07LtLyFjl8Xy+/8CjbYZ?=
 =?us-ascii?Q?1uZkLv5nem6dZneEBJyTfhBraLDFBl9laZlEMprlnOz/x02tfzjY+eaOzt/J?=
 =?us-ascii?Q?GY2NaSeLPdq1q4J+Ivj23GdIhKulMwd4/vPHhEpsW1fNem9LoWAQHmkbAlli?=
 =?us-ascii?Q?t03Ur5dWhKVY7c7zDIHRtzfW0ntQDdoeosLpgso2VyQkqUDauDAD26qtc0Od?=
 =?us-ascii?Q?KjjHJ2Mhw8w/lmW2FLvrD/G0ATkt0KHuZE5OW4RHk6x/VLMSp9BEvaoUtKBC?=
 =?us-ascii?Q?P2SiNeC6A71CvP/gRMkY7uVgDrg4FnkP5cQgTIVTLrA48wVQTOO6K20MrqQZ?=
 =?us-ascii?Q?eNB7U7lIlHhXb3lhFHRqF10R3BjUOEoRGvPFUiStMhWBSTKL2YJZq4pwdoS5?=
 =?us-ascii?Q?HJa03JlW8R+5OLkTdGTzYwnFQR9Xv/Fffv0xwS8mON60eSbJKJW52eBxLA4j?=
 =?us-ascii?Q?/zqNR5Uvb1CtOV1zVeybkz4uZuQ/UdhyX4+0A/uLsolFuA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1lyIJlKGGk1Ymx2mrJD5sLN93GX37QUiA/aobNN+y6J7tFKXE0CRSIdK+6bA?=
 =?us-ascii?Q?hWMeFIGuXy9GGBR5+f0DNlKGTvJwBDi6c+qadGpqlC0HiD0rdnXDIWtr83od?=
 =?us-ascii?Q?UUaCz2LnEILQkgABM8GsQkWgFk/en7A08F9F9n2ZOSp24yP86lJRNT9LutJY?=
 =?us-ascii?Q?Y/RVoy8JcqQX0rVyEs/WN/zM+Kp2zUtdc5OH7Cs0DwFfMOG8dr/u1eiNcCIg?=
 =?us-ascii?Q?RBWiHJTW1Xi2qVjzrjC8kVHtcbA3wkDbToiPsN/SYwRvHszuKJnoNzkJjYP+?=
 =?us-ascii?Q?vSrv+DziBTwt/tygllQltoWyXBVlC7rffpqUJAJeLtKI86MHvoEyqXzN6K/m?=
 =?us-ascii?Q?b1uq7N1FH6ZEgjJ0SuGfF2kvKvaqiZABC5ZwSPdKe+5OOh0CBfTzHjcC6U3P?=
 =?us-ascii?Q?u3CIg6lMzaW+n9dme5Env7qCtp5i/kouGYx6pIOplO8nGy0c8gAfa6WXypFV?=
 =?us-ascii?Q?EmzI7Af0TXz48RSDJBNLPOJxmouj7/g1ni2YXdx+zIqj3rUb7QaDvNevltiW?=
 =?us-ascii?Q?PU8jqFMYLfBpQRBrDUC64T3pwhWRz/9HMqlDTZCrCPBoCF2SZ6NFsSPAanMg?=
 =?us-ascii?Q?rfBY1WYVRLYSDaaE0Kx1js2jno+45XlLU0vgPD9ppiS5Py1xw6p/wPjcxXBc?=
 =?us-ascii?Q?1hs/EvVbI6wfKKegVImuVsqxJbqOBV+lzbLOoyEfLcAuDsHvqeZKY5n85htK?=
 =?us-ascii?Q?6Yjahd3h7ZN5IcCbKkOmOspz15A8ynzG4Pk2JELumjz1LJ8+pFbwREnKpDB8?=
 =?us-ascii?Q?rGlhq57pWesvgY5ymHA42LIPltS/oMepy6Dy62+y/lo0S6/Btcc0Damwoz5J?=
 =?us-ascii?Q?SOxr/4nbxctFROq4sR0KS9XZE0z1GK33HXjc6IRlOsqgA5Miv814HmH6nz1f?=
 =?us-ascii?Q?yr1PLOc/z7rLP2q4EEiWVBJoqwi0V7jfQMQ2qzSlAjv2LB9O7FyMJuXyLMrD?=
 =?us-ascii?Q?grgQaEgCqLI6NMqKTXORbYv54mZ43c9mr0dikaZxwpSv0xJklsU1TGBOkRof?=
 =?us-ascii?Q?k1yyVLeRWROaC79GxmjpJgmwygw6JV6C/IBv5/2YP3mXs/khf7SBtfkG5QRk?=
 =?us-ascii?Q?iDbEn4Ii7U3f4RgtWpWDiyGB3lLbTdAKFEILEiP2ykWJ3gjbTCkl58l36wFm?=
 =?us-ascii?Q?o7xqOkeiVL3QojptorupAsVQfIaVAFK2+NZFbhOAI8jlVeZqKT9KAaVDOV4v?=
 =?us-ascii?Q?CifxymgnZ/996sMA+m+7JrUeNF9tU1fiTqt95teP+JF8xkHCsvX7rHcuLhb5?=
 =?us-ascii?Q?jHkPdR1iv7FGPK9udVKe1d8B1r7QE2BFo+pud7eQzrH/TvsnIJDis6XK6Pe5?=
 =?us-ascii?Q?latImZQadhy0hdu7Cwb41Pal9C3oeJUnm2ZCJRT9NNhWoWFLtoKqS/BaWzQq?=
 =?us-ascii?Q?d80+1idOgJZ3DC1rgqHCMstI3g8CSa8MdAlrf/dyINchMhPKcr+XILxLSeWN?=
 =?us-ascii?Q?qZBwr/HdqENV11ksv+ucG19XwcmFNJaQRHlHhrM4u2CrVM1oZilFuBfcBj9D?=
 =?us-ascii?Q?Kbrp8uEc+p+oZ5DW1kjAt2kgzLK+HOsnm+XVmQ0Ta+9jCYTwfHuX0f0tX5Bt?=
 =?us-ascii?Q?P5E3vxpHPABwT5UGZss=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6868a9e-1722-4384-ce41-08dcea6e06ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2024 03:29:06.2515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFx/HpcQ4XMA93EVuWEX5a2qrNFGoys57l2C7Y14c+j9ViiiqBop9nq3koaF+ZnG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

Acked-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Saturday, October 12, 2024 10:00 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/pm: update overdrive function on smu 14.0.2/3

update overdrive function on smu 14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 61 ++++++-------------
 1 file changed, 19 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index ade3ee398e3d..7c97a4d34377 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1064,12 +1064,9 @@ static void smu_v14_0_2_get_od_setting_limits(struct=
 smu_context *smu,

        switch (od_feature_bit) {
        case PP_OD_FEATURE_GFXCLK_FMIN:
-               od_min_setting =3D overdrive_lowerlimits->GfxclkFmin;
-               od_max_setting =3D overdrive_upperlimits->GfxclkFmin;
-               break;
        case PP_OD_FEATURE_GFXCLK_FMAX:
-               od_min_setting =3D overdrive_lowerlimits->GfxclkFmax;
-               od_max_setting =3D overdrive_upperlimits->GfxclkFmax;
+               od_min_setting =3D overdrive_lowerlimits->GfxclkFoffset;
+               od_max_setting =3D overdrive_upperlimits->GfxclkFoffset;
                break;
        case PP_OD_FEATURE_UCLK_FMIN:
                od_min_setting =3D overdrive_lowerlimits->UclkFmin; @@ -125=
6,10 +1253,16 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context=
 *smu,
                                                         PP_OD_FEATURE_GFXC=
LK_BIT))
                        break;

-               size +=3D sysfs_emit_at(buf, size, "OD_SCLK:\n");
-               size +=3D sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
-                                       od_table->OverDriveTable.GfxclkFmin=
,
-                                       od_table->OverDriveTable.GfxclkFmax=
);
+               PPTable_t *pptable =3D smu->smu_table.driver_pptable;
+               const OverDriveLimits_t * const overdrive_upperlimits =3D
+                                       &pptable->SkuTable.OverDriveLimitsB=
asicMax;
+               const OverDriveLimits_t * const overdrive_lowerlimits =3D
+                                       &pptable->SkuTable.OverDriveLimitsB=
asicMin;
+
+               size +=3D sysfs_emit_at(buf, size, "OD_SCLK_OFFSET:\n");
+               size +=3D sysfs_emit_at(buf, size, "0: %dMhz\n1: %uMhz\n",
+                                       overdrive_lowerlimits->GfxclkFoffse=
t,
+                                       overdrive_upperlimits->GfxclkFoffse=
t);
                break;

        case SMU_OD_MCLK:
@@ -1401,7 +1404,7 @@ static int smu_v14_0_2_print_clk_levels(struct smu_co=
ntext *smu,
                                                          PP_OD_FEATURE_GFX=
CLK_FMAX,
                                                          NULL,
                                                          &max_value);
-                       size +=3D sysfs_emit_at(buf, size, "SCLK: %7uMhz %1=
0uMhz\n",
+                       size +=3D sysfs_emit_at(buf, size, "SCLK_OFFSET: %7=
dMhz %10uMhz\n",
                                              min_value, max_value);
                }

@@ -2145,7 +2148,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu=
_context *smu,

        gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivity;
        gpu_metrics->average_umc_activity =3D metrics->AverageUclkActivity;
-       gpu_metrics->average_mm_activity =3D max(metrics->Vcn0ActivityPerce=
ntage,
+       gpu_metrics->average_mm_activity =3D
+max(metrics->AverageVcn0ActivityPercentage,
                                               metrics->Vcn1ActivityPercent=
age);

        gpu_metrics->average_socket_power =3D metrics->AverageSocketPower; =
@@ -2204,8 +2207,8 @@ static void smu_v14_0_2_dump_od_table(struct smu_cont=
ext *smu,  {
        struct amdgpu_device *adev =3D smu->adev;

-       dev_dbg(adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->OverDriveTab=
le.GfxclkFmin,
-                                                    od_table->OverDriveTab=
le.GfxclkFmax);
+       dev_dbg(adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->OverDriveTab=
le.GfxclkFoffset,
+                                                    od_table->OverDriveTab=
le.GfxclkFoffset);
        dev_dbg(adev->dev, "OD: Uclk: (%d, %d)\n", od_table->OverDriveTable=
.UclkFmin,
                                                   od_table->OverDriveTable=
.UclkFmax);
 }
@@ -2296,10 +2299,8 @@ static int smu_v14_0_2_set_default_od_settings(struc=
t smu_context *smu)
                memcpy(user_od_table,
                       boot_od_table,
                       sizeof(OverDriveTableExternal_t));
-               user_od_table->OverDriveTable.GfxclkFmin =3D
-                               user_od_table_bak.OverDriveTable.GfxclkFmin=
;
-               user_od_table->OverDriveTable.GfxclkFmax =3D
-                               user_od_table_bak.OverDriveTable.GfxclkFmax=
;
+               user_od_table->OverDriveTable.GfxclkFoffset =3D
+                               user_od_table_bak.OverDriveTable.GfxclkFoff=
set;
                user_od_table->OverDriveTable.UclkFmin =3D
                                user_od_table_bak.OverDriveTable.UclkFmin;
                user_od_table->OverDriveTable.UclkFmax =3D @@ -2428,22 +242=
9,6 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
                        }

                        switch (input[i]) {
-                       case 0:
-                               smu_v14_0_2_get_od_setting_limits(smu,
-                                                                 PP_OD_FEA=
TURE_GFXCLK_FMIN,
-                                                                 &minimum,
-                                                                 &maximum)=
;
-                               if (input[i + 1] < minimum ||
-                                   input[i + 1] > maximum) {
-                                       dev_info(adev->dev, "GfxclkFmin (%l=
d) must be within [%u, %u]!\n",
-                                               input[i + 1], minimum, maxi=
mum);
-                                       return -EINVAL;
-                               }
-
-                               od_table->OverDriveTable.GfxclkFmin =3D inp=
ut[i + 1];
-                               od_table->OverDriveTable.FeatureCtrlMask |=
=3D 1U << PP_OD_FEATURE_GFXCLK_BIT;
-                               break;
-
                        case 1:
                                smu_v14_0_2_get_od_setting_limits(smu,
                                                                  PP_OD_FEA=
TURE_GFXCLK_FMAX,
@@ -2456,7 +2441,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_c=
ontext *smu,
                                        return -EINVAL;
                                }

-                               od_table->OverDriveTable.GfxclkFmax =3D inp=
ut[i + 1];
+                               od_table->OverDriveTable.GfxclkFoffset =3D =
input[i + 1];
                                od_table->OverDriveTable.FeatureCtrlMask |=
=3D 1U << PP_OD_FEATURE_GFXCLK_BIT;
                                break;

@@ -2466,14 +2451,6 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_=
context *smu,
                                return -EINVAL;
                        }
                }
-
-               if (od_table->OverDriveTable.GfxclkFmin > od_table->OverDri=
veTable.GfxclkFmax) {
-                       dev_err(adev->dev,
-                               "Invalid setting: GfxclkFmin(%u) is bigger =
than GfxclkFmax(%u)\n",
-                               (uint32_t)od_table->OverDriveTable.GfxclkFm=
in,
-                               (uint32_t)od_table->OverDriveTable.GfxclkFm=
ax);
-                       return -EINVAL;
-               }
                break;

        case PP_OD_EDIT_MCLK_VDDC_TABLE:
--
2.34.1

