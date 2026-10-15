Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469E9CC6B33
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 09:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0369112275;
	Thu, 15 Oct 2026 09:47:26 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F8FB10E139
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 09:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxqJQiZN4xvUeaTIlKEpsnoKB5DqMLf00SKe6CDmW5WtMPdmOqbYFLDe4OzJuhzr8VXI3ANzf54L73PNwQ614zXJ/kmBRRP2+m/8zHqDctCFPDqirkrhTJha98kkSb7B/fTsN9HcNNiXyfdf2oMwHajEcaAW3NY+zmfSqPjNA6EaE0hZ9Jnji9biN01p2Snp5k1U1HBlcEfkdmRgzee06InuCc8TfXQeTR3rluSB+x8KVZUFfSwGOArHivb1229Enu7omYaaAFriVwA9EoGGTFBGz5sNuZEICDp2D6ynsUOUkrT/VPrv+zk6ROTTqQLoSexYxDYzWQSfLc03Rp96nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWRuewBeOHhpS+Og7L/BFwz450qqImLpk+87xbEkJeY=;
 b=vfyxT+D0MVYhRLN7YiUVmwnFoSI3Sb4KMu7uIVJfkgUkpU33qAsOoxALljOllPnDVVFFccRcH/FKukM7QplKv7wTU7e/UBciwG1nleuxDAFr9WKRIGNH4doSol7EwqWfOVxznRhbYwY0bstD+26Wvy2qHkFv9ukH5/rVXAyUxc4bi5E7P3ORmHvneYHipe1io1oJKjPb9Qb9xX++5ILZvxSZw3gvdVxEVKv9Hdhy8z3tJLTfreFmPYVOS6BaCl1ugXGIGdU9Nve6KJg09qJ3usFH7ywY6MUroUwsupZX6GSoj8QWM7iaIjbyncB4YkLUkDeUd+G5N4NgRTyOSM0AjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWRuewBeOHhpS+Og7L/BFwz450qqImLpk+87xbEkJeY=;
 b=rd2pcZerzMHvfkBABDxvbMJ1hEXd0uVaGCnZ9sjJma/oB+W3hqAeKCN9DcyMdxM0wFbE80W5u5rA7QlHFII+TOmUUFunL2rBnQYGhOpuudvCw4fZS801EbRH2ipVpGuKwSxo+IoYF/7OD8waZvY8ClTX1Kf3P/xGDKtNEAX8p+Y=
Received: from IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 09:47:17 +0000
Received: from IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522]) by IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522%6]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 09:47:17 +0000
From: "Hosur, Priya" <Priya.Hosur@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>, "Hosur, Priya"
 <Priya.Hosur@amd.com>
Subject: RE: [PATCH v2 1/1] drm/amd/pm: restore the forced performance level
 after a reset
Thread-Topic: [PATCH v2 1/1] drm/amd/pm: restore the forced performance level
 after a reset
Thread-Index: AQHdVxF5LzXLExPlPUWRugi8Q6qB67b+Y4ug
Date: Thu, 15 Oct 2026 09:47:17 +0000
Message-ID: <IA0PR12MB8895E6CA7AF1D2988800EDBBF39C2@IA0PR12MB8895.namprd12.prod.outlook.com>
References: <20261008104026.4102222-1-Priya.Hosur@amd.com>
 <20261008104026.4102222-2-Priya.Hosur@amd.com>
In-Reply-To: <20261008104026.4102222-2-Priya.Hosur@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-15T09:37:48.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8895:EE_|MN2PR12MB4469:EE_
x-ms-office365-filtering-correlation-id: 015f5339-549d-4e52-e51d-08df2aa14c88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|10067099003|3023799007|38070700021|4143699003|11063799006|261009223027099003|56012099006;
x-microsoft-antispam-message-info: WtT3BHO67TuqbGRpdfWwcB08//nnlPIcmLVojpUs2PYcCtnCP9Hubk+nsW51l0w/KDufCYdxm+Ssg7Eo6VuYtIg0Nu7ZV7GpuzGAx7kybaEMQiFoKXIGn1RZOBEBS3Uy9Exjy32jmeG1tJa+wrVhYyXs7KsmeAcPATFGiEO1Zj/WKkOUfx75Y6YvKDpx1JYdpn/uI1Xna23+mKP7vM9/JnHtKHaHXfgG1dr1Ve5jDvrWiVvezCeIR88kBm9jlhWhnPnBevW1O9MoeCbA8OVdghjB1x9yPj6BLWl2g4mTxHZ2aI6eYcaH+xPI3m5RrUo7nNvg8FWh+UsnVr7CCwNyitingpbP5e2bJQpvMyoij0nE41Bq5eG1bEs0g1tomvK7YEa5enqMkmkmbXW7FOTsMKGEsmpLTB795NgDAf8yi86S9axr5jj1kZys3kI9b3xSQ1T1h3+NUzvlsX1x6+VLnoGjCAlCVdJaesKq7afsq70CwrVmd4xj2WfgtwSiXb1UbBrGB5eJI+iSWRS3GJ3IoPtreUgJ5vDfBS5KHIPuVsmjmMns5UQEvOUNs11JgNTUC9WKdecRf/MQRBy7CQUYs9cAQ2rS119zd2X9iZolU1r48kXyYVZLLFOAIso3VSNzCq0hcXtBRbGlr/T/w8SSAP7QzKWdE7Rgn+VUBkSlRDRaJ9rpW+anmOLx82nmaHFDLaYve1v6FFRklJPeWWx4RA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8895.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(3023799007)(38070700021)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c3oHs6MYdPlp3LxOe+S3nYOocSEujQVJQEDuLOAOrG8z7KcolbkZkSBYE755?=
 =?us-ascii?Q?tbnMWuvhh0zJiUZfpylfMswFFKB46tH4TF0lEB4oeJ8/yxv0NWve10gUJCnY?=
 =?us-ascii?Q?YUw6wvJLqjLQKF9W2ioNIKEP4VBphS3lB10XW8unPyk1jw1V2pHUcvr3reWj?=
 =?us-ascii?Q?35YCl3J5z4r/t3IAMI2dQAIqLvyVnHHLY+4KUvbkOmlRLYCELEgk2TDCyHKN?=
 =?us-ascii?Q?oxeqQNNrWxvt3VFRjFXk1dvPnqQxFCV94OZat+uC8K7DnRpWg8HlioIqj9y1?=
 =?us-ascii?Q?9l9ns1kV1ZsbEPjQIlMrecPEp1GQJKvUQbwvhd+5zPjiYQw949URcqhrhO/9?=
 =?us-ascii?Q?NOTPskxIC6QkuBeuxTWZbRyICxRjPDTD1CJ+9C3cPx1yE8UbCvUp96UuXeRP?=
 =?us-ascii?Q?mB/hvkn/S3/KzOsELYXfHvzENr82iHWOsrMafQRRnIoOf5yALxcaLKVqnh91?=
 =?us-ascii?Q?XLS2+Z1to5LJzdrRhtoy3aEy58mVPcRRFHNLftLmARw/a6Bf6i8W5FgCn46t?=
 =?us-ascii?Q?knq39El1XEZC0NEVy/kRjc4b9l5rE0iiqpTpxGxJHsdrvrt9BXhFitgS+o2N?=
 =?us-ascii?Q?AFk/02DOrbWyCjY3AWKozLVJRBw6ZTCGLCHiOfn3ogNTlj4TkE3t3xD4qHRA?=
 =?us-ascii?Q?b7gjAPHyzhFSOqhrH6Z9TfYVj51o8GqtFDP44A0BFIB8zi087ubUuK7ZCfa6?=
 =?us-ascii?Q?tF8it/v4erUFRfZF0DKS/EAdSovID50xkSVZGJb+6cI12O8f4OSU9ixDnaH7?=
 =?us-ascii?Q?hNT3yJXDfDJ0fpKYQEV+Dq6VlXovZr+WfdMaYjaSSaJS7yK/VrymmZjf/YYi?=
 =?us-ascii?Q?wTnIhkyVCIV9lyBFc7NxmSjuSWaoYRsXlFTvOIIx3qpZGBIIp4RhkHRMIQQX?=
 =?us-ascii?Q?vE0f3OZcepUyiwe3cFpIWgLaKZhFCpSHD8DLho7FsySJ3NqE7zYO83g78TgX?=
 =?us-ascii?Q?jmOJdNxRy6znRyz21kKa0IrrDwFsAbHHuY3Ui0j34ZKjXnR2e2yZwncheMjD?=
 =?us-ascii?Q?zcuzXQF9gOWYnxMBY1HR2MKVDQYSWq5jAspaUQejuQDVIL87havh+heFMwYZ?=
 =?us-ascii?Q?0jWO51N/zNDfPuoZpdcBVW+725/jG+0EFQeLGBJAynBO17WYdxU/tisKQn8F?=
 =?us-ascii?Q?0FT6qHLiWMitdCrSUqhPODDPrzyotiqHhegcSyrAfnnMk8cxRWdgppLQ4W49?=
 =?us-ascii?Q?vCB0haBAF6jvsA4egZx5u3UL8k/G6VggtQKJyoN+xJ9QZ680sxv8TYaqcDDn?=
 =?us-ascii?Q?zxSxGeXCURniP8j+6vABiKaF+KzczkVmXG/kQfrCYvWkwhnEcC9MqFW9+8Jg?=
 =?us-ascii?Q?czENhVeFsNROL09WXAJQkOCgaufXXbeHOta1E+Vy0HVLSW6yJ34SUDE/ftzu?=
 =?us-ascii?Q?FY0uHr57gXNR8sbSm0lB7/zeC1q0K4emmoYBKTSO1fhlw21nGh5wxzopafLy?=
 =?us-ascii?Q?I7coK3RcklTBaBWd78EmJst2uiI2S3YHYL6iXcstagNjn47/2j0T7Ft9ITi1?=
 =?us-ascii?Q?Rkv0E5T67a6kb72KZrZ4AwKlWG0ClxkmImEJvOXkqdCMz8G7Bo5tZXIBHDuj?=
 =?us-ascii?Q?4O1yItuQmAzmLMat7qYcT51dU2jsaNcx7kR4vu1JWILcfCJWoEqz+P9ZZflH?=
 =?us-ascii?Q?WMT+/RSwqxEGWZvYu6ioRb0Ee4osGUfR2woKL3cmdtg+INL90Ja+WkAS8U0F?=
 =?us-ascii?Q?YJwgA+RaKRkjlVm11vnLfYK0tCsw5ec0eKwufOoNp+1uLyyX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015f5339-549d-4e52-e51d-08df2aa14c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:47:17.1981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4HPFBm9MeUNGADc4+/jM43Y6EdIJg5ZGgN5JjT3Ar954NVl3uW1xeNKFr/2gu7GSwpWJgR+0w1lrg2Wo5GpAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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

Hi Team,

Gentle reminder on this patch.

Lijo, v2 follows your feedback to restore the forced level rather than
report the default. Could you take a look when you get a chance?

Thanks and Regards,
Priya

-----Original Message-----
From: Priya Hosur <Priya.Hosur@amd.com>
Sent: Thursday, October 8, 2026 4:10 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Hosur, Priya <Priya.Hosur@amd.com>; Vishwakarma, Pratik <Pratik.Vishwak=
arma@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakri=
shnan@amd.com>
Subject: [PATCH v2 1/1] drm/amd/pm: restore the forced performance level af=
ter a reset

smu_late_init() re-applies the DPM level after a reset with

  smu_handle_task(smu, smu->smu_dpm.dpm_level, AMD_PP_TASK_COMPLETE_INIT);

but smu_adjust_power_state_dynamic() only programs the hardware when

  if (smu_dpm_ctx->dpm_level !=3D level)

and smu_dpm_ctx is &smu->smu_dpm, so the level is compared against itself.
The branch is never taken for this caller and
smu_asic_set_performance_level() is never called.

PMFW is reinitialised by the reset and comes back on its default curve, whi=
le smu_dpm.dpm_level still holds the level the user forced. The device ther=
efore runs at the default level while sysfs keeps reporting the forced one.=
 On an SMU 14.0.1 APU gfxclk drops from 2.8GHz to 600MHz while sysfs still =
reports high. Writing the same level again does not help either, as
amdgpu_dpm_force_performance_level() returns early when the requested level=
 matches the cached one.

Sync the cached level with the state PMFW came back in before re-applying t=
he forced level, so that it is programmed again. Suspend/resume is not cove=
red, as PMFW retains its state across s2idle and the forced level still app=
lies on resume.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index a65aa2129845..2d318726c521 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -998,9 +998,18 @@ static int smu_late_init(struct amdgpu_ip_block *ip_bl=
ock)

        smu_get_fan_parameters(smu);

-       smu_handle_task(smu,
-                       smu->smu_dpm.dpm_level,
-                       AMD_PP_TASK_COMPLETE_INIT);
+       if (amdgpu_reset_in_recovery(adev)) {
+               enum amd_dpm_forced_level level =3D smu->smu_dpm.dpm_level;
+
+               /* PMFW is reinitialised by the reset, so sync the cached l=
evel
+                * before re-applying the forced one
+                */
+               smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
+               smu_handle_task(smu, level, AMD_PP_TASK_COMPLETE_INIT);
+       } else {
+               smu_handle_task(smu, smu->smu_dpm.dpm_level,
+                               AMD_PP_TASK_COMPLETE_INIT);
+       }

        ret =3D smu_apply_default_config_table_settings(smu);
        if (ret && (ret !=3D -EOPNOTSUPP)) {
--
2.43.0

