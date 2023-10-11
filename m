Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1488CD98E0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 01:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35CBE10E164;
	Wed, 11 Oct 2023 01:22:07 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AA3510E41A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 01:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4L0kgxpzEHt5Bey3xCSKoTHHc2d9eODR/0mFflm57xoI18YKxrUlz/P7BNBSSaLAbkx4v6FgvPaDldzb8itUFHW+k9vy0lbFEDDjb1UhpEZOywvd2GLs/7+UBUK3yMFB7Dr4kbeVKWcUP00dD4avl6g0aE5HJIY10Gl+RPDefIQE9z/dBOMdzbuOMJAIDY3rV9b42bRyZ5XO2znOyhQZ1/HTEKIlyZbi8QmMUyupZGUcBeP2/SySwk2eXtV320/njRW3FoQT6zLmiZg5a9P45/K5nwmcd7+9bFyCbWdDw4RkSVYBSEc3HU/f72WHv8ORhXl+fg99sndTdj4soidOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLbbpqZdPsHnSTVjVcIqasU1B9ndOf6en0lhr3JQuGU=;
 b=LOXwb3iC16lRoQ2ucRhdCXoLNHG/Ih2pKEZOrHt2PVq6aISoT/EjgaSZX2SjelW33kPgRrQiOGu35BnUJOmO4zfAimc4kdXYtR1lPDFXwX3wua9qsYAhmwyxq5DCfo9/KLyDAjzyjB7YI8EMt3s5bF6NAa3t8Ua49WYbL9oxXoqp+yDsk37M138ZrEdVJMBlysWNmQzaX0vGc2gkzedqdXTeL2IVMH7GH2YX6EpCPfA2zzZcXxQbwkKQsz+DIUkWNVNrwTL3WTyJkj7r+MaDUOxbMVpj3exLqkQlFDffi4o1g1C2eIYoFlUNO8zygE3GfHbJHkk1hGIRLKyo0Ucm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLbbpqZdPsHnSTVjVcIqasU1B9ndOf6en0lhr3JQuGU=;
 b=YijVxARyXyc0H2hOh3AiENUGcjGL95zKeJOM5MtVaNRqvNZHVuMTCtKBr8fXrY68OiEifXsnSh9jgeYyGM3w+biKDFloxLmgA87uT5MNYRj8pb75S0e5ikloG9rFLHlrxN6oxFtHrk95DvVsdiIA1sugN2u55zlQ7p5NptdivjA=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 01:22:00 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::1e12:f561:5399:2a0b]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::1e12:f561:5399:2a0b%5]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 01:22:00 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: drop most smu_cmn_get_smc_version in smu
Thread-Topic: [PATCH] drm/amd/pm: drop most smu_cmn_get_smc_version in smu
Thread-Index: AQHZ+4lYa6GXGfuqlUSOQQRzH9rWKrBDy21w
Date: Wed, 11 Oct 2023 01:22:00 +0000
Message-ID: <DM4PR12MB51653C5F11FEFDAD1CC2D4838ECCA@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231010145147.573164-1-yifan1.zhang@amd.com>
In-Reply-To: <20231010145147.573164-1-yifan1.zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cfa60283-5ccb-44f4-849e-40077a4cec1f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-11T01:21:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DS7PR12MB6311:EE_
x-ms-office365-filtering-correlation-id: 682dbefd-e5c0-4682-9264-08dbc9f877cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1PJRfnh3pNWIALCGip4EDyobjbDQno5spTkSRAlqTNrIWS1Yw8xVCwS2QPbDDKOSn2sFmJRyI48V5flMiAxGgIUrGA7ZGgzDcJhUsrI6XQ7HVTxLURkT3HVgarQwROgMMR1F6W87okLzBfJPEpKDT9qz9bEF8xXjpfBu8EqIVHVpolrKcIwfRmbjuBX5C9oImwGEqF1Ee0LCbWE4wElqMNGUOt+UQLgtlcdqRppfFpHl1x6XnjD47bJf3t8ROQxrx/M0c81wCFRGYTuk33KFtn5w2bPQ26Cf9wTS0TcuooRHR2BUAVENBMDIf2wzm2wCCnr1HVbWdurmuoBjXC9mfiBNZWEPGZ7TSei1yjsIacBd9+ACnWHPLTmJRIWX0kHqMzss7qK+8HUipoA/tpden4zEqe6KYb8IAEi29EkQP8dgSdUmeXr4u2tfIH0gCkQMyzdFfyKy1dJWJyLYrFBLdTaJi289GhRIyEkCHehGDwCXQ1pLpAD+9Ego+36wZ2bIdx7piHhjo6nxgwsZw997Qhr+rfVloMDYTJpN/eHb0bJOUPLluENxhpA6MyUaqkVeNAauM0uEhLK+kNwRWx+4D/0fz+ZfxswXjFjQBWesqGmojf56KtVBMyMujM7rF6wq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(9686003)(53546011)(6506007)(7696005)(478600001)(4326008)(71200400001)(83380400001)(66574015)(2906002)(30864003)(110136005)(5660300002)(66556008)(66946007)(64756008)(76116006)(66446008)(54906003)(26005)(8676002)(52536014)(66476007)(41300700001)(8936002)(316002)(122000001)(33656002)(38070700005)(38100700002)(86362001)(55016003)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TQXFmK6JmkVp5jd6Gtns0XjRsNkZ0mm1IUsyAaVDeP9WqiGWpiBsaEubSDCT?=
 =?us-ascii?Q?ZrxQqKgP9MeQyZ5rzBlKuFWcdHH55b1p/VmjtaeJOrWmIRGeAFaSeFDM0DZz?=
 =?us-ascii?Q?a2Xizyd6m5zWvu/Dq3AdrjuMUhdItHeDQ99Mofhja6OMgZlKtrNin8lrFVri?=
 =?us-ascii?Q?Ua0TPwtawznMXR9lMnlNkdIbdnUQ7GFJHex787C5niVMmaLOHV1FPMvuvwsD?=
 =?us-ascii?Q?P7KCmz+b52Ti7oaEUUWkkqI1nEbnUQPvdclM1jUHrHQNy+9M+p8oLnYXs+Rq?=
 =?us-ascii?Q?lRJOdsNK6+0Agp2Kl5T72kw8uabtLkhP/43FUJJzKy2/XpoG/L5Cv3L4JxZY?=
 =?us-ascii?Q?a+t5y9yVc/5LM1oBRHTZkStkOHBY/48HjgsA9H/EeJvGIMjrORBwnEc+44x0?=
 =?us-ascii?Q?RfaV6F9awDGw4icseLqZbHQhcA4rKO0/MNR06qUkOcUpBPUkiRCDFHYbmROh?=
 =?us-ascii?Q?dJWdL4+WE32lGNiPZ5n1FVqLs7Ms4zN7NueKoe4xHt8jt1XKjFF7qahMLs/F?=
 =?us-ascii?Q?kFz/zoPyOptgoLwfMO5OYLYlvoqNg1Df2m7lGfJdk0YspjN+5pSJnZCH489D?=
 =?us-ascii?Q?bCPIDJSfJGnCq1FidiQJhN8FIXAIQK4vvcg5LnkT4JnvpRD/gNmrFHzUVabU?=
 =?us-ascii?Q?uKfpzOEq8RE3YRBCOb2jowDttb8xmYCYolP+/BnR8ORGcE27fpd+A2uksphv?=
 =?us-ascii?Q?KPyNfaaTTEBC6j80/cDlDznErqIWP7aoVH0ePIcxamdnLUCXWpEVtBpwLgmX?=
 =?us-ascii?Q?WD9PkzCNofNe0P8TRKQe71VmY/Dz6DvI/51Lwn7lVEVMUrNgOZDQ9uinwfXF?=
 =?us-ascii?Q?WkPCIDSO/GiScuPma2vKg/zprQjD851FyfmfLvOyFrFBQL9pCpsLfNJvjHl7?=
 =?us-ascii?Q?2iBNYz5NHMeYb8YCImJNJEn7U12elme9RwH060UK6QS5yEFBTrDc0Gx/nLmJ?=
 =?us-ascii?Q?yKbUUdeClzMZFQtp7yTgGTdOHdWbk8Nm8arKHr8+B+9Cysvjo44uPlev78UQ?=
 =?us-ascii?Q?0ou+zR/ujtq2vdQ1DJBBzi7fbjPIU2iZPqJY2FQ2Ir8e4g+BdV2P0ePWbthx?=
 =?us-ascii?Q?TEgvsBFZSDbrQJRQW2C7idPw99cadvsdh/9NCMbAdBRmEPSyIqWRSO/poafZ?=
 =?us-ascii?Q?dj326MdXklhEexJB0OQr6HTUm4PpDqJp7fFOGfkD4l2FMoD05gVg202sGd3M?=
 =?us-ascii?Q?AWDTpeTx2nyYdOJMOuX4H6S/TXuXLJ5++TqLIeXX9ypVUmMzn1IUEiPypO4a?=
 =?us-ascii?Q?QS2P/pj418pgIz4D7H0zwk4MvBkp8JwVbWdgvKur7iYzYaKN81/6zIDveCUH?=
 =?us-ascii?Q?0/5QYpkQrHh0XNPSSfJ9/os4iLM8DHaZJUpmTrH+5aS+l+AfeDCSGuxO58lk?=
 =?us-ascii?Q?KoB1cFmqp+CTCdAIH8HpqKvI5Hck2aliv0MWLIwdYCGX4nd9hOv+DbMBkGt/?=
 =?us-ascii?Q?x3Pf+ilO8LCLliSqoN32o9u9VifcAoG8+20vaxKh9X6GDcawoO+sXEow7pb4?=
 =?us-ascii?Q?/Ki1i6/DYXLfXvmEXy9gbDtNrBVCr4ltEImIFQ3p2On5GbxHCKADRL7a8oTO?=
 =?us-ascii?Q?eDCk10BoJwR7cETLQB4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682dbefd-e5c0-4682-9264-08dbc9f877cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 01:22:00.1528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDKCJP7Ejg/zmYVZiPRg+Yc9gMwde5IwuE3fIOoWfIsCWwBKXRFG6pV/ILRKTrPt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Ma, Li" <Li.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Tuesday, October 10, 2023 10:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Ma, Li <Li.Ma@amd.com>; Feng, Kenneth <Kenneth.Feng@=
amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: drop most smu_cmn_get_smc_version in smu

smu_check_fw_version is called in smu hw init, thus smu if version and vers=
ion are garenteed to be stored in smu context. No need to call smu_cmn_get_=
smc_version again after system boot up.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 66 ++++---------------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 37 +++--------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 43 +++---------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 45 +++----------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 60 +++++------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 20 ++----  .../drm/amd/pm/=
swsmu/smu13/smu_v13_0_6_ppt.c  | 22 ++-----
 7 files changed, 61 insertions(+), 232 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 44e4289b95cd..e38620e9436c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -963,17 +963,10 @@ static int arcturus_force_clk_levels(struct smu_conte=
xt *smu,
        struct smu_11_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
        struct smu_11_0_dpm_table *single_dpm_table =3D NULL;
        uint32_t soft_min_level, soft_max_level;
-       uint32_t smu_version;
        int ret =3D 0;

-       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (ret) {
-               dev_err(smu->adev->dev, "Failed to get smu version!\n");
-               return ret;
-       }
-
-       if ((smu_version >=3D 0x361200) &&
-           (smu_version <=3D 0x361a00)) {
+       if ((smu->smc_fw_version >=3D 0x361200) &&
+           (smu->smc_fw_version <=3D 0x361a00)) {
                dev_err(smu->adev->dev, "Forcing clock level is not support=
ed with "
                       "54.18 - 54.26(included) SMU firmwares\n");
                return -EOPNOTSUPP;
@@ -1344,16 +1337,11 @@ static int arcturus_get_power_profile_mode(struct s=
mu_context *smu,
        uint32_t i, size =3D 0;
        int16_t workload_type =3D 0;
        int result =3D 0;
-       uint32_t smu_version;

        if (!buf)
                return -EINVAL;

-       result =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (result)
-               return result;
-
-       if (smu_version >=3D 0x360d00)
+       if (smu->smc_fw_version >=3D 0x360d00)
                size +=3D sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s =
%s %s %s %s\n",
                        title[0], title[1], title[2], title[3], title[4], t=
itle[5],
                        title[6], title[7], title[8], title[9], title[10]);=
 @@ -1372,7 +1360,7 @@ static int arcturus_get_power_profile_mode(struct sm=
u_context *smu,
                if (workload_type < 0)
                        continue;

-               if (smu_version >=3D 0x360d00) {
+               if (smu->smc_fw_version >=3D 0x360d00) {
                        result =3D smu_cmn_update_table(smu,
                                                  SMU_TABLE_ACTIVITY_MONITO=
R_COEFF,
                                                  workload_type,
@@ -1387,7 +1375,7 @@ static int arcturus_get_power_profile_mode(struct smu=
_context *smu,
                size +=3D sysfs_emit_at(buf, size, "%2d %14s%s\n",
                        i, amdgpu_pp_profile_name[i], (i =3D=3D smu->power_=
profile_mode) ? "*" : " ");

-               if (smu_version >=3D 0x360d00) {
+               if (smu->smc_fw_version >=3D 0x360d00) {
                        size +=3D sysfs_emit_at(buf, size, "%19s %d(%13s) %=
7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
                                " ",
                                0,
@@ -1429,19 +1417,15 @@ static int arcturus_set_power_profile_mode(struct s=
mu_context *smu,
        int workload_type =3D 0;
        uint32_t profile_mode =3D input[size];
        int ret =3D 0;
-       uint32_t smu_version;

        if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
                dev_err(smu->adev->dev, "Invalid power profile mode %d\n", =
profile_mode);
                return -EINVAL;
        }

-       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (ret)
-               return ret;

        if ((profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) &&
-            (smu_version >=3D 0x360d00)) {
+            (smu->smc_fw_version >=3D 0x360d00)) {
                ret =3D smu_cmn_update_table(smu,
                                       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
                                       WORKLOAD_PPLIB_CUSTOM_BIT,
@@ -1517,15 +1501,8 @@ static int arcturus_set_power_profile_mode(struct sm=
u_context *smu,  static int arcturus_set_performance_level(struct smu_conte=
xt *smu,
                                          enum amd_dpm_forced_level level) =
 {
-       uint32_t smu_version;
        int ret;

-       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (ret) {
-               dev_err(smu->adev->dev, "Failed to get smu version!\n");
-               return ret;
-       }
-
        switch (level) {
        case AMD_DPM_FORCED_LEVEL_HIGH:
        case AMD_DPM_FORCED_LEVEL_LOW:
@@ -1533,8 +1510,8 @@ static int arcturus_set_performance_level(struct smu_=
context *smu,
        case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
        case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
        case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-               if ((smu_version >=3D 0x361200) &&
-                   (smu_version <=3D 0x361a00)) {
+               if ((smu->smc_fw_version >=3D 0x361200) &&
+                   (smu->smc_fw_version <=3D 0x361a00)) {
                        dev_err(smu->adev->dev, "Forcing clock level is not=
 supported with "
                               "54.18 - 54.26(included) SMU firmwares\n");
                        return -EOPNOTSUPP;
@@ -2172,16 +2149,11 @@ static void arcturus_i2c_control_fini(struct smu_co=
ntext *smu)  static void arcturus_get_unique_id(struct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev;
-       uint32_t top32 =3D 0, bottom32 =3D 0, smu_version;
+       uint32_t top32 =3D 0, bottom32 =3D 0;
        uint64_t id;

-       if (smu_cmn_get_smc_version(smu, NULL, &smu_version)) {
-               dev_warn(adev->dev, "Failed to get smu version, cannot get =
unique_id or serial_number\n");
-               return;
-       }
-
        /* PPSMC_MSG_ReadSerial* is supported by 54.23.0 and onwards */
-       if (smu_version < 0x361700) {
+       if (smu->smc_fw_version < 0x361700) {
                dev_warn(adev->dev, "ReadSerial is only supported by PMFW 5=
4.23.0 and onwards\n");
                return;
        }
@@ -2198,7 +2170,6 @@ static int arcturus_set_df_cstate(struct smu_context =
*smu,
                                  enum pp_df_cstate state)
 {
        struct amdgpu_device *adev =3D smu->adev;
-       uint32_t smu_version;
        int ret;

        /*
@@ -2208,14 +2179,8 @@ static int arcturus_set_df_cstate(struct smu_context=
 *smu,
        if (amdgpu_in_reset(adev) || adev->in_suspend)
                return 0;

-       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (ret) {
-               dev_err(smu->adev->dev, "Failed to get smu version!\n");
-               return ret;
-       }
-
        /* PPSMC_MSG_DFCstateControl is supported by 54.15.0 and onwards */
-       if (smu_version < 0x360F00) {
+       if (smu->smc_fw_version < 0x360F00) {
                dev_err(smu->adev->dev, "DFCstateControl is only supported =
by PMFW 54.15.0 and onwards\n");
                return -EINVAL;
        }
@@ -2226,17 +2191,10 @@ static int arcturus_set_df_cstate(struct smu_contex=
t *smu,  static int arcturus_select_xgmi_plpd_policy(struct smu_context *sm=
u,
                                            enum pp_xgmi_plpd_mode mode)
 {
-       uint32_t smu_version;
        int ret;

-       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (ret) {
-               dev_err(smu->adev->dev, "Failed to get smu version!\n");
-               return ret;
-       }
-
        /* PPSMC_MSG_GmiPwrDnControl is supported by 54.23.0 and onwards */
-       if (smu_version < 0x00361700) {
+       if (smu->smc_fw_version < 0x00361700) {
                dev_err(smu->adev->dev, "XGMI power down control is only su=
pported by PMFW 54.23.0 and onwards\n");
                return -EINVAL;
        }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 5f3cbfff156a..bbe0cb68ca30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -907,18 +907,11 @@ static int navi1x_get_smu_metrics_data(struct smu_con=
text *smu,
                                       uint32_t *value)
 {
        struct amdgpu_device *adev =3D smu->adev;
-       uint32_t smu_version;
        int ret =3D 0;

-       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (ret) {
-               dev_err(adev->dev, "Failed to get smu version!\n");
-               return ret;
-       }
-
        switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
        case IP_VERSION(11, 0, 9):
-               if (smu_version > 0x00341C00)
+               if (smu->smc_fw_version > 0x00341C00)
                        ret =3D navi12_get_smu_metrics_data(smu, member, va=
lue);
                else
                        ret =3D navi12_get_legacy_smu_metrics_data(smu, mem=
ber, value); @@ -928,10 +921,10 @@ static int navi1x_get_smu_metrics_data(s=
truct smu_context *smu,
        default:
                if (((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
                      IP_VERSION(11, 0, 5)) &&
-                    smu_version > 0x00351F00) ||
+                    smu->smc_fw_version > 0x00351F00) ||
                    ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
                      IP_VERSION(11, 0, 0)) &&
-                    smu_version > 0x002A3B00))
+                    smu->smc_fw_version > 0x002A3B00))
                        ret =3D navi10_get_smu_metrics_data(smu, member, va=
lue);
                else
                        ret =3D navi10_get_legacy_smu_metrics_data(smu, mem=
ber, value); @@ -2847,19 +2840,12 @@ static int navi10_run_umc_cdr_workarou=
nd(struct smu_context *smu)
        struct amdgpu_device *adev =3D smu->adev;
        uint8_t umc_fw_greater_than_v136 =3D false;
        uint8_t umc_fw_disable_cdr =3D false;
-       uint32_t pmfw_version;
        uint32_t param;
        int ret =3D 0;

        if (!navi10_need_umc_cdr_workaround(smu))
                return 0;

-       ret =3D smu_cmn_get_smc_version(smu, NULL, &pmfw_version);
-       if (ret) {
-               dev_err(adev->dev, "Failed to get smu version!\n");
-               return ret;
-       }
-
        /*
         * The messages below are only supported by Navi10 42.53.0 and late=
r
         * PMFWs and Navi14 53.29.0 and later PMFWs.
@@ -2868,9 +2854,9 @@ static int navi10_run_umc_cdr_workaround(struct smu_c=
ontext *smu)
         * - PPSMC_MSG_GetUMCFWWA
         */
        if (((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0,=
 0)) &&
-            (pmfw_version >=3D 0x2a3500)) ||
+            (smu->smc_fw_version >=3D 0x2a3500)) ||
            ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0,=
 5)) &&
-            (pmfw_version >=3D 0x351D00))) {
+            (smu->smc_fw_version >=3D 0x351D00))) {
                ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                                      SMU_MSG_GET_UMC_FW_WA=
,
                                                      0,
@@ -3355,18 +3341,11 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_co=
ntext *smu,
                                      void **table)
 {
        struct amdgpu_device *adev =3D smu->adev;
-       uint32_t smu_version;
        int ret =3D 0;

-       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (ret) {
-               dev_err(adev->dev, "Failed to get smu version!\n");
-               return ret;
-       }
-
        switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
        case IP_VERSION(11, 0, 9):
-               if (smu_version > 0x00341C00)
+               if (smu->smc_fw_version > 0x00341C00)
                        ret =3D navi12_get_gpu_metrics(smu, table);
                else
                        ret =3D navi12_get_legacy_gpu_metrics(smu, table); =
@@ -3376,10 +3355,10 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_co=
ntext *smu,
        default:
                if (((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
                      IP_VERSION(11, 0, 5)) &&
-                    smu_version > 0x00351F00) ||
+                    smu->smc_fw_version > 0x00351F00) ||
                    ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
                      IP_VERSION(11, 0, 0)) &&
-                    smu_version > 0x002A3B00))
+                    smu->smc_fw_version > 0x002A3B00))
                        ret =3D navi10_get_gpu_metrics(smu, table);
                else
                        ret =3D navi10_get_legacy_gpu_metrics(smu, table); =
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 28868f64d134..1e710c0c9042 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1279,7 +1279,6 @@ static int sienna_cichlid_print_clk_levels(struct smu=
_context *smu,
        uint32_t mark_index =3D 0;
        uint32_t gen_speed, lane_width;
        uint32_t min_value, max_value;
-       uint32_t smu_version;

        smu_cmn_get_sysfs_buf(&buf, &size);

@@ -1388,10 +1387,9 @@ static int sienna_cichlid_print_clk_levels(struct sm=
u_context *smu,
                 * OD GFX Voltage Offset functionality is supported only by=
 58.41.0
                 * and onwards SMU firmwares.
                 */
-               smu_cmn_get_smc_version(smu, NULL, &smu_version);
                if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
                     IP_VERSION(11, 0, 7)) &&
-                   (smu_version < 0x003a2900))
+                   (smu->smc_fw_version < 0x003a2900))
                        break;

                size +=3D sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n"); =
@@ -2148,16 +2146,14 @@ static void sienna_cichlid_dump_od_table(struct smu=
_context *smu,
                                         OverDriveTable_t *od_table)
 {
        struct amdgpu_device *adev =3D smu->adev;
-       uint32_t smu_version;

        dev_dbg(smu->adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->GfxclkF=
min,
                                                          od_table->GfxclkF=
max);
        dev_dbg(smu->adev->dev, "OD: Uclk: (%d, %d)\n", od_table->UclkFmin,
                                                        od_table->UclkFmax)=
;

-       smu_cmn_get_smc_version(smu, NULL, &smu_version);
        if (!((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0=
, 7)) &&
-             (smu_version < 0x003a2900)))
+             (smu->smc_fw_version < 0x003a2900)))
                dev_dbg(smu->adev->dev, "OD: VddGfxOffset: %d\n", od_table-=
>VddGfxOffset);  }

@@ -2235,7 +2231,6 @@ static int sienna_cichlid_od_edit_dpm_table(struct sm=
u_context *smu,
        enum SMU_11_0_7_ODSETTING_ID freq_setting;
        uint16_t *freq_ptr;
        int i, ret =3D 0;
-       uint32_t smu_version;

        if (!smu->od_enabled) {
                dev_warn(smu->adev->dev, "OverDrive is not enabled!\n"); @@=
 -2388,10 +2383,9 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu=
_context *smu,
                 * OD GFX Voltage Offset functionality is supported only by=
 58.41.0
                 * and onwards SMU firmwares.
                 */
-               smu_cmn_get_smc_version(smu, NULL, &smu_version);
                if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
                     IP_VERSION(11, 0, 7)) &&
-                   (smu_version < 0x003a2900)) {
+                   (smu->smc_fw_version < 0x003a2900)) {
                        dev_err(smu->adev->dev, "OD GFX Voltage offset func=
tionality is supported "
                                                "only by 58.41.0 and onward=
s SMU firmwares!\n");
                        return -EOPNOTSUPP;
@@ -2461,14 +2455,12 @@ static bool sienna_cichlid_is_mode1_reset_supported=
(struct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev;
        uint32_t val;
-       u32 smu_version;

        /**
         * SRIOV env will not support SMU mode1 reset
         * PM FW support mode1 reset from 58.26
         */
-       smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (amdgpu_sriov_vf(adev) || (smu_version < 0x003a1a00))
+       if (amdgpu_sriov_vf(adev) || (smu->smc_fw_version < 0x003a1a00))
                return false;

        /**
@@ -4060,14 +4052,9 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct=
 smu_context *smu,

 static int sienna_cichlid_check_ecc_table_support(struct smu_context *smu)=
  {
-       uint32_t if_version =3D 0xff, smu_version =3D 0xff;
        int ret =3D 0;

-       ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-       if (ret)
-               return -EOPNOTSUPP;
-
-       if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
+       if (smu->smc_fw_version < SUPPORT_ECCTABLE_SMU_VERSION)
                ret =3D -EOPNOTSUPP;

        return ret;
@@ -4133,17 +4120,13 @@ static int sienna_cichlid_enable_mgpu_fan_boost(str=
uct smu_context *smu)  static int sienna_cichlid_gpo_control(struct smu_con=
text *smu,
                                      bool enablement)
 {
-       uint32_t smu_version;
        int ret =3D 0;


        if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
-               ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
-               if (ret)
-                       return ret;

                if (enablement) {
-                       if (smu_version < 0x003a2500) {
+                       if (smu->smc_fw_version < 0x003a2500) {
                                ret =3D smu_cmn_send_smc_msg_with_param(smu=
,
                                                                      SMU_M=
SG_SetGpoFeaturePMask,
                                                                      GFX_G=
PO_PACE_MASK | GFX_GPO_DEM_MASK, @@ -4155,7 +4138,7 @@ static int sienna_ci=
chlid_gpo_control(struct smu_context *smu,
                                                                      NULL)=
;
                        }
                } else {
-                       if (smu_version < 0x003a2500) {
+                       if (smu->smc_fw_version < 0x003a2500) {
                                ret =3D smu_cmn_send_smc_msg_with_param(smu=
,
                                                                      SMU_M=
SG_SetGpoFeaturePMask,
                                                                      0,
@@ -4174,18 +4157,11 @@ static int sienna_cichlid_gpo_control(struct smu_co=
ntext *smu,

 static int sienna_cichlid_notify_2nd_usb20_port(struct smu_context *smu)  =
{
-       uint32_t smu_version;
-       int ret =3D 0;
-
-       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (ret)
-               return ret;
-
        /*
         * Message SMU_MSG_Enable2ndUSB20Port is supported by 58.45
         * onwards PMFWs.
         */
-       if (smu_version < 0x003A2D00)
+       if (smu->smc_fw_version < 0x003A2D00)
                return 0;

        return smu_cmn_send_smc_msg_with_param(smu,
@@ -4332,13 +4308,10 @@ static bool sienna_cichlid_is_mode2_reset_supported=
(struct smu_context *smu)

 static int sienna_cichlid_mode2_reset(struct smu_context *smu)  {
-       u32 smu_version;
        int ret =3D 0, index;
        struct amdgpu_device *adev =3D smu->adev;
        int timeout =3D 100;

-       smu_cmn_get_smc_version(smu, NULL, &smu_version);
-
        index =3D smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
                                                SMU_MSG_DriverMode2Reset);

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index a5481274052e..9d8afc83af67 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -225,15 +225,8 @@ static int vangogh_tables_init(struct smu_context *smu=
)  {
        struct smu_table_context *smu_table =3D &smu->smu_table;
        struct smu_table *tables =3D smu_table->tables;
-       uint32_t if_version;
-       uint32_t smu_version;
        uint32_t ret =3D 0;

-       ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-       if (ret) {
-               return ret;
-       }
-
        SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
        SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t), @@=
 -243,7 +236,7 @@ static int vangogh_tables_init(struct smu_context *smu)
        SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF, sizeof(Dpm=
ActivityMonitorCoeffExt_t),
                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);

-       if (if_version < 0x3) {
+       if (smu->smc_fw_if_version < 0x3) {
                SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMet=
rics_legacy_t),
                                PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
                smu_table->metrics_table =3D kzalloc(sizeof(SmuMetrics_lega=
cy_t), GFP_KERNEL); @@ -256,7 +249,7 @@ static int vangogh_tables_init(stru=
ct smu_context *smu)
                goto err0_out;
        smu_table->metrics_time =3D 0;

-       if (smu_version >=3D 0x043F3E00)
+       if (smu->smc_fw_version >=3D 0x043F3E00)
                smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_met=
rics_v2_3);
        else
                smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_met=
rics_v2_2); @@ -431,16 +424,9 @@ static int vangogh_common_get_smu_metrics_=
data(struct smu_context *smu,
                                       uint32_t *value)
 {
        struct amdgpu_device *adev =3D smu->adev;
-       uint32_t if_version;
        int ret =3D 0;

-       ret =3D smu_cmn_get_smc_version(smu, &if_version, NULL);
-       if (ret) {
-               dev_err(adev->dev, "Failed to get smu if version!\n");
-               return ret;
-       }
-
-       if (if_version < 0x3)
+       if (smu->smc_fw_if_version < 0x3)
                ret =3D vangogh_get_legacy_smu_metrics_data(smu, member, va=
lue);
        else
                ret =3D vangogh_get_smu_metrics_data(smu, member, value); @=
@ -814,16 +800,9 @@ static int vangogh_common_print_clk_levels(struct smu_c=
ontext *smu,
                        enum smu_clk_type clk_type, char *buf)  {
        struct amdgpu_device *adev =3D smu->adev;
-       uint32_t if_version;
        int ret =3D 0;

-       ret =3D smu_cmn_get_smc_version(smu, &if_version, NULL);
-       if (ret) {
-               dev_err(adev->dev, "Failed to get smu if version!\n");
-               return ret;
-       }
-
-       if (if_version < 0x3)
+       if (smu->smc_fw_if_version < 0x3)
                ret =3D vangogh_print_legacy_clk_levels(smu, clk_type, buf)=
;
        else
                ret =3D vangogh_print_clk_levels(smu, clk_type, buf); @@ -2=
011,18 +1990,12 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_contex=
t *smu,  static ssize_t vangogh_common_get_gpu_metrics(struct smu_context *=
smu,
                                      void **table)
 {
-       uint32_t if_version;
-       uint32_t smu_version;
        uint32_t smu_program;
        uint32_t fw_version;
        int ret =3D 0;

-       ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-       if (ret)
-               return ret;
-
-       smu_program =3D (smu_version >> 24) & 0xff;
-       fw_version =3D smu_version & 0xffffff;
+       smu_program =3D (smu->smc_fw_version >> 24) & 0xff;
+       fw_version =3D smu->smc_fw_version & 0xffffff;
        if (smu_program =3D=3D 6) {
                if (fw_version >=3D 0x3F0800)
                        ret =3D vangogh_get_gpu_metrics_v2_4(smu, table); @=
@ -2030,13 +2003,13 @@ static ssize_t vangogh_common_get_gpu_metrics(struct=
 smu_context *smu,
                        ret =3D vangogh_get_gpu_metrics_v2_3(smu, table);

        } else {
-               if (smu_version >=3D 0x043F3E00) {
-                       if (if_version < 0x3)
+               if (smu->smc_fw_version >=3D 0x043F3E00) {
+                       if (smu->smc_fw_if_version < 0x3)
                                ret =3D vangogh_get_legacy_gpu_metrics_v2_3=
(smu, table);
                        else
                                ret =3D vangogh_get_gpu_metrics_v2_3(smu, t=
able);
                } else {
-                       if (if_version < 0x3)
+                       if (smu->smc_fw_if_version < 0x3)
                                ret =3D vangogh_get_legacy_gpu_metrics(smu,=
 table);
                        else
                                ret =3D vangogh_get_gpu_metrics(smu, table)=
; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 2373a66c7efd..bdb278f5c654 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -467,18 +467,12 @@ static bool aldebaran_is_primary(struct smu_context *=
smu)

 static int aldebaran_run_board_btc(struct smu_context *smu)  {
-       u32 smu_version;
        int ret;

        if (!aldebaran_is_primary(smu))
                return 0;

-       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (ret) {
-               dev_err(smu->adev->dev, "Failed to get smu version!\n");
-               return ret;
-       }
-       if (smu_version <=3D 0x00441d00)
+       if (smu->smc_fw_version <=3D 0x00441d00)
                return 0;

        ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_BoardPowerCalibration, NU=
LL); @@ -1769,24 +1763,15 @@ static ssize_t aldebaran_get_gpu_metrics(struc=
t smu_context *smu,  static int aldebaran_check_ecc_table_support(struct sm=
u_context *smu,
                int *ecctable_version)
 {
-       uint32_t if_version =3D 0xff, smu_version =3D 0xff;
-       int ret =3D 0;
-
-       ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-       if (ret) {
-               /* return not support if failed get smu_version */
-               ret =3D -EOPNOTSUPP;
-       }
-
-       if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
-               ret =3D -EOPNOTSUPP;
-       else if (smu_version >=3D SUPPORT_ECCTABLE_SMU_VERSION &&
-                       smu_version < SUPPORT_ECCTABLE_V2_SMU_VERSION)
+       if (smu->smc_fw_version < SUPPORT_ECCTABLE_SMU_VERSION)
+               return -EOPNOTSUPP;
+       else if (smu->smc_fw_version >=3D SUPPORT_ECCTABLE_SMU_VERSION &&
+                       smu->smc_fw_version < SUPPORT_ECCTABLE_V2_SMU_VERSI=
ON)
                *ecctable_version =3D 1;
        else
                *ecctable_version =3D 2;

-       return ret;
+       return 0;
 }

 static ssize_t aldebaran_get_ecc_info(struct smu_context *smu, @@ -1849,7 =
+1834,7 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,

 static int aldebaran_mode1_reset(struct smu_context *smu)  {
-       u32 smu_version, fatal_err, param;
+       u32 fatal_err, param;
        int ret =3D 0;
        struct amdgpu_device *adev =3D smu->adev;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev); @@ -1860,1=
3 +1845,12 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
        /*
        * PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
        */
-       smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (smu_version < 0x00440700) {
+       if (smu->smc_fw_version < 0x00440700) {
                ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL)=
;
        } else {
                /* fatal error triggered by ras, PMFW supports the flag
                   from 68.44.0 */
-               if ((smu_version >=3D 0x00442c00) && ras &&
+               if ((smu->smc_fw_version >=3D 0x00442c00) && ras &&
                    atomic_read(&ras->in_recovery))
                        fatal_err =3D 1;

@@ -1883,18 +1867,15 @@ static int aldebaran_mode1_reset(struct smu_context=
 *smu)

 static int aldebaran_mode2_reset(struct smu_context *smu)  {
-       u32 smu_version;
        int ret =3D 0, index;
        struct amdgpu_device *adev =3D smu->adev;
        int timeout =3D 10;

-       smu_cmn_get_smc_version(smu, NULL, &smu_version);
-
        index =3D smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
                                                SMU_MSG_GfxDeviceDriverRese=
t);

        mutex_lock(&smu->message_lock);
-       if (smu_version >=3D 0x00441400) {
+       if (smu->smc_fw_version >=3D 0x00441400) {
                ret =3D smu_cmn_send_msg_without_waiting(smu, (uint16_t)ind=
ex, SMU_RESET_MODE_2);
                /* This is similar to FLR, wait till max FLR timeout */
                msleep(100);
@@ -1921,7 +1902,7 @@ static int aldebaran_mode2_reset(struct smu_context *=
smu)

        } else {
                dev_err(adev->dev, "smu fw 0x%x does not support MSG_GfxDev=
iceDriverReset MSG\n",
-                               smu_version);
+                               smu->smc_fw_version);
        }

        if (ret =3D=3D 1)
@@ -1944,13 +1925,11 @@ static bool aldebaran_is_mode1_reset_supported(stru=
ct smu_context *smu)  {  #if 0
        struct amdgpu_device *adev =3D smu->adev;
-       u32 smu_version;
        uint32_t val;
        /**
         * PM FW version support mode1 reset from 68.07
         */
-       smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if ((smu_version < 0x00440700))
+       if ((smu->smc_fw_version < 0x00440700))
                return false;
        /**
         * mode1 reset relies on PSP, so we should check if @@ -1995,19 +19=
74,10 @@ static int aldebaran_smu_send_hbm_bad_page_num(struct smu_context =
*smu,

 static int aldebaran_check_bad_channel_info_support(struct smu_context *sm=
u)  {
-       uint32_t if_version =3D 0xff, smu_version =3D 0xff;
-       int ret =3D 0;
+       if (smu->smc_fw_version < SUPPORT_BAD_CHANNEL_INFO_MSG_VERSION)
+               return -EOPNOTSUPP;

-       ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-       if (ret) {
-               /* return not support if failed get smu_version */
-               ret =3D -EOPNOTSUPP;
-       }
-
-       if (smu_version < SUPPORT_BAD_CHANNEL_INFO_MSG_VERSION)
-               ret =3D -EOPNOTSUPP;
-
-       return ret;
+       return 0;
 }

 static int aldebaran_send_hbm_bad_channel_flag(struct smu_context *smu, di=
ff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 47d008cbc186..f22f35c97d24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -296,7 +296,6 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context=
 *smu,
                                  uint32_t *feature_mask, uint32_t num)  {
        struct amdgpu_device *adev =3D smu->adev;
-       u32 smu_version;

        if (num > 2)
                return -EINVAL;
@@ -316,8 +315,7 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context=
 *smu,
                *(uint64_t *)feature_mask &=3D ~FEATURE_MASK(FEATURE_DPM_SO=
CCLK_BIT);

        /* PMFW 78.58 contains a critical fix for gfxoff feature */
-       smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if ((smu_version < 0x004e3a00) ||
+       if ((smu->smc_fw_version < 0x004e3a00) ||
             !(adev->pm.pp_feature & PP_GFXOFF_MASK))
                *(uint64_t *)feature_mask &=3D ~FEATURE_MASK(FEATURE_GFXOFF=
_BIT);

@@ -2583,15 +2581,13 @@ static int smu_v13_0_0_baco_exit(struct smu_context=
 *smu)  static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context=
 *smu)  {
        struct amdgpu_device *adev =3D smu->adev;
-       u32 smu_version;

        /* SRIOV does not support SMU mode1 reset */
        if (amdgpu_sriov_vf(adev))
                return false;

        /* PMFW support is available since 78.41 */
-       smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (smu_version < 0x004e2900)
+       if (smu->smc_fw_version < 0x004e2900)
                return false;

        return true;
@@ -2781,13 +2777,10 @@ static void smu_v13_0_0_set_mode1_reset_param(struc=
t smu_context *smu,
                                                uint32_t supported_version,
                                                uint32_t *param)
 {
-       uint32_t smu_version;
        struct amdgpu_device *adev =3D smu->adev;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

-       smu_cmn_get_smc_version(smu, NULL, &smu_version);
-
-       if ((smu_version >=3D supported_version) &&
+       if ((smu->smc_fw_version >=3D supported_version) &&
                        ras && atomic_read(&ras->in_recovery))
                /* Set RAS fatal error reset flag */
                *param =3D 1 << 16;
@@ -2903,15 +2896,10 @@ static int smu_v13_0_0_send_bad_mem_channel_flag(st=
ruct smu_context *smu,  static int smu_v13_0_0_check_ecc_table_support(stru=
ct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev;
-       uint32_t if_version =3D 0xff, smu_version =3D 0xff;
        int ret =3D 0;

-       ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-       if (ret)
-               return -EOPNOTSUPP;
-
        if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
10)) &&
-               (smu_version >=3D SUPPORT_ECCTABLE_SMU_13_0_10_VERSION))
+               (smu->smc_fw_version >=3D SUPPORT_ECCTABLE_SMU_13_0_10_VERS=
ION))
                return ret;
        else
                return -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8220bdcbd927..953a9a52ed8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -719,7 +719,6 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_=
context *smu,
        struct smu_table_context *smu_table =3D &smu->smu_table;
        MetricsTable_t *metrics =3D (MetricsTable_t *)smu_table->metrics_ta=
ble;
        struct amdgpu_device *adev =3D smu->adev;
-       uint32_t smu_version;
        int ret =3D 0;
        int xcc_id;

@@ -731,8 +730,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_=
context *smu,
        switch (member) {
        case METRICS_CURR_GFXCLK:
        case METRICS_AVERAGE_GFXCLK:
-               smu_cmn_get_smc_version(smu, NULL, &smu_version);
-               if (smu_version >=3D 0x552F00) {
+               if (smu->smc_fw_version >=3D 0x552F00) {
                        xcc_id =3D GET_INST(GC, 0);
                        *value =3D SMUQ10_ROUND(metrics->GfxclkFrequency[xc=
c_id]);
                } else {
@@ -1392,10 +1390,7 @@ static int smu_v13_0_6_register_irq_handler(struct s=
mu_context *smu)

 static int smu_v13_0_6_notify_unload(struct smu_context *smu)  {
-       uint32_t smu_version;
-
-       smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (smu_version <=3D 0x553500)
+       if (smu->smc_fw_version <=3D 0x553500)
                return 0;

        dev_dbg(smu->adev->dev, "Notify PMFW about driver unload"); @@ -140=
7,11 +1402,8 @@ static int smu_v13_0_6_notify_unload(struct smu_context *sm=
u)

 static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool en=
able)  {
-       uint32_t smu_version;
-
        /* NOTE: this ClearMcaOnRead message is only supported for smu vers=
ion 85.72.0 or higher */
-       smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (smu_version < 0x554800)
+       if (smu->smc_fw_version < 0x554800)
                return 0;

        return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,=
 @@ -1670,13 +1662,11 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct s=
mu_context *smu,  static int smu_v13_0_6_get_enabled_mask(struct smu_contex=
t *smu,
                                        uint64_t *feature_mask)
 {
-       uint32_t smu_version;
        int ret;

-       smu_cmn_get_smc_version(smu, NULL, &smu_version);
        ret =3D smu_cmn_get_enabled_mask(smu, feature_mask);

-       if (ret =3D=3D -EIO && smu_version < 0x552F00) {
+       if (ret =3D=3D -EIO && smu->smc_fw_version < 0x552F00) {
                *feature_mask =3D 0;
                ret =3D 0;
        }
@@ -2115,7 +2105,6 @@ static int smu_v13_0_6_get_thermal_temperature_range(=
struct smu_context *smu,  {
        struct amdgpu_device *adev =3D smu->adev;
        u32 aid_temp, xcd_temp, max_temp;
-       uint32_t smu_version;
        u32 ccd_temp =3D 0;
        int ret;

@@ -2126,8 +2115,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(=
struct smu_context *smu,
                return -EINVAL;

        /*Check smu version, GetCtfLimit message only supported for smu ver=
sion 85.69 or higher */
-       smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (smu_version < 0x554500)
+       if (smu->smc_fw_version < 0x554500)
                return 0;

        /* Get SOC Max operating temperature */
--
2.37.3

