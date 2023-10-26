Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C49EC25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 03:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA22710E747;
	Thu, 26 Oct 2023 03:53:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E53D010E747
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 03:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG0AZ1VR4rBjvjLeqcuHKAzWamC8fHs0Foruh/FrLjq0RMqE0ZBpfwZFpzoCPxLN77cOHc3MDjCi5WsJ5oHSP7hpInqQSNQV9V8NTGKXQF04uUv+hO4GrEESXGbzb/IqppIUQUlosOWO0HgyUuzNkyra/ebLk/ZvzNcUl//n2DbrfUnizIKTNLm4bDaEBAoD8ZsUimYgyO4wFDrc0hwa1YramfS7oWsxVfhWlNiqWGx1GO3nRdHU6jJP11OwTXu3Ps4/qqtVFNJmg/PfEHkLK2fLrHtqbgu2e9ylBkLJCCgAP2D1WqwjIkzfPrEMa8zGczlp45zu+2lZMqVBbJ3XAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ljOntPbrn3DAH5wdHDYkhHAlXxKZV6BeG/PhNFXftY=;
 b=ZSO0jbuhx/ApFI2VJR5LhRnTvAtA2zt/ryMs8yNh8TIzKtrEPspRumcXbptB56Uk8xAG8GXx9ZWSAiIPGLHX5yfcjK6Xf6DBAmTuQ72gGK4MP3VDtSULaVLkl+wCeOxTOvzvgXQe8rnr2cRUeb+Drpza4SWOBX5WDAQVIwjQrOmDXyldcLccPodbd+hrVQZycFgp1zeCFTrvCyFIKdA2t/xm8iAvdqN4zeWHxFhz85jQ/MDm/HJctjiIDcZY2urByH9OIvwUVc7oX6YEsv25KEyMX6eBAe/tgNWJRnsI+URhwd4Fh62FP4FPe2exlImVDeRn9DwFKOGY62aMaOxBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ljOntPbrn3DAH5wdHDYkhHAlXxKZV6BeG/PhNFXftY=;
 b=AF7DJeEkfSoxUWj4a/I2U7U783T+kq29zTPBtfLMlNoGIny6Fnbf68VXrSub71f9gJnQzSOlVbhvGEwEIoAM5GKTwMEfCt5d6xcavLuI4mc1LC0fzVwR/LK75p4u650upYAFmQvcEvq1j016akbsRXNnnyCqnDI7pjTL30/GvgI=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.19; Thu, 26 Oct 2023 03:53:44 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 03:53:43 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: fix the high voltage and temperature issue
Thread-Topic: [PATCH v2] drm/amd/pm: fix the high voltage and temperature issue
Thread-Index: AQHaB71B+aMRLgyy5k+HxdkiX0fAw7Bba9+w
Date: Thu, 26 Oct 2023 03:53:43 +0000
Message-ID: <PH7PR12MB599736A363632C9F52B37F5D82DDA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231026033352.988746-1-kenneth.feng@amd.com>
In-Reply-To: <20231026033352.988746-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS0PR12MB8296:EE_
x-ms-office365-filtering-correlation-id: a9cbaddc-76ef-43ed-15a7-08dbd5d725fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YSS/hAicRuk54eWpXOGoki/+LtqjCKanOKXLtnVJDfNLWND/cVE9pwbD8GnU7mxbNmZzTbRqqupe9RmLSyvpgdqI8APM6nWZguLOmIoMO9Db9Tm33nni3NMUjZPsCnpLItygQH65JrXjVFCy+1JEKezhzUW0ehqHEPxQr2F4IyJFJMrocWw9X/nZz00tYuJAlZISCqY/dhIX/7VCDPqEmuIlv8psvMM67pmZ2Yhn5A4v86O/vDkfBcOrmB9mRTgtVwpRz/UXLvkEJlAlghgTOld5fadTHknY65OllWX815iG4pTqJ7v/8UO1iHNQtY1tGRSOwYCQGb9tD8MhsMXFmOr+LJpcF3Ksu7RhI+F3bF3GQ4R+gRqTkRBk39ugyyyY92Z7OrmIDUTFDbF+2iUav3zMJ60lk9YVJ60IKz1dKTx1ip4fFav5qzPi3jHdU68JQmKbM6H9gjPx3WrG7CNHLwfkCcb8VtfOl+sFNJuONSY2Vxg3y8WgrMZyT14EIOsEBykBkHEV3ScWf04BOH+LxhTzwlOsEfvw6Qy0b9TSm/rGEFqJyhHevbGpA4VhhY0UbjAroabgx6FyQiOfQqheY7T4PCbbuzCiz8ZobC+a0f7kyzslM7nscsG6AtSNnRbLmnh6zr3vnjzmUxxicaj6/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6506007)(86362001)(33656002)(55016003)(66946007)(316002)(66556008)(64756008)(66476007)(76116006)(110136005)(66446008)(52536014)(122000001)(38100700002)(38070700009)(54906003)(9686003)(7696005)(26005)(53546011)(71200400001)(41300700001)(8936002)(4326008)(8676002)(2906002)(5660300002)(478600001)(83380400001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WoVY1eUpFZdfdFx05TampBj2wl9EP4ayqcXAO01uXeaWzDvXL08Gt1L2CluZ?=
 =?us-ascii?Q?WurpKq5YRjOsbik5zJr/IZE1Opy/+JOGCdOyW1Cu099AS68R69RuB8C4G0Rq?=
 =?us-ascii?Q?N7ELCk2NHhyuExXPWBjFHlIlN37Fas0GK9Abu5/3cBXyEiLPE3jEv1ABMSxf?=
 =?us-ascii?Q?Muuc5j1MtxSesVDLTElAcdSOBLAPeqFF/Djebe7RFPoTsz8zTj5iA2FwTknp?=
 =?us-ascii?Q?pM4pHYw76PFVKwsyCqvlliuV2E3OOHcnbxko7rTOrHWjWV9ywf93cSh1A6SR?=
 =?us-ascii?Q?tXDTeajXjLxVPAQeMAklU21H8PwhC8M1EyVy9F1vYzUUBHJ1jO/IVLtb5+vZ?=
 =?us-ascii?Q?nl2yn5CFj67MfWp8fx/ga7hyaOyoI1W8D00Tt/1veBsFETEij4W1RGbHAqFt?=
 =?us-ascii?Q?M2C1tJ/cNpgnSwXcBgJtsHgvf40ltr2RYYbS4sefUFWdMyr8fkcyCtexUQhv?=
 =?us-ascii?Q?YH5wDgTvT2BJ4r91Pzn1vcYMn02kP4efmdN8FC/PsSoicJQZnKDZvkCn7jDk?=
 =?us-ascii?Q?kJYjk31ziExiu80wLMuh9u1meWmUPXXB6yKMZRJpUyLr8Bmzdi3d3u535aAk?=
 =?us-ascii?Q?iDdIDit2Ay4dzwszHic//HbXenNalvWWHcwoL+/9HCMP55eyflIQrYd9u9e8?=
 =?us-ascii?Q?BTfU9CLg+0ykEIGz5UdVAsYDq93LsEwFCmUbVt/qnia+AfpeNhp6RF2GjbEJ?=
 =?us-ascii?Q?MllhwQVsjBZGWC/6BSl8j7+ubVgPxvsoIIGHMtzoECM67edzSkrJtpcDrUDN?=
 =?us-ascii?Q?GBZ4x+cY1ZR8evoeVvRlpym8GChTeP7CpVAQ8AUvYybRDeBD+hnlDNatJCO3?=
 =?us-ascii?Q?tsglwK7qlgiguZ1MSUzdPlGlrhcb5POM17+nobomgZz1ntzAzWNxja1CF3s2?=
 =?us-ascii?Q?zPGdlOCEtvxD1IlcLTQrkAx8TYRZFUFT7xXcun0PfBkaZ7rLaUC8EzPJhGSo?=
 =?us-ascii?Q?l6cx/Fqr/zj7HWrfkDLfzu5EHaMlTRJDySEDEYo2+NIfCYT2jcc6Lb1o1CRW?=
 =?us-ascii?Q?Rm9KwpiiUeNGusdQqo0fqGQy1s4Sa2zwEoJxygWKjOLiupKUq/j6BRcoJ4U0?=
 =?us-ascii?Q?cTWx+tgSDH1OLFKZbr2hFgjKPGYTJV8xIHUZmc1N3tAh8pDcFK2H9HIbSnit?=
 =?us-ascii?Q?2UWyWhYDRRNpayeTvDVpf0FNfk6Scz9TdBdEFJZ7q2BuUttHo0eSXL+1RFB3?=
 =?us-ascii?Q?Injtx99SyuZd0SsvNiKE4uIfkXispiRXjRMmiG5yZ4mc1lpkMGx3T9wteLOu?=
 =?us-ascii?Q?q0OXoeYF60LEkRIhCiW3tZn6pK/2o2B3rCcv1v9X2VMrbhLB4LQLzj6QaJNe?=
 =?us-ascii?Q?jAyTfuUHLMsQ6GcA9QjNjeC+m5YTZrpyChbHv17Po/biFVVkeEgD4RtoEQCY?=
 =?us-ascii?Q?O8Nh91ks2EzOQsgeU12GBFPDT+3sMFwq7L44AjJGkXHPoFNyQZlff4cyCdmm?=
 =?us-ascii?Q?FDZaiMReHEqsZLoOIJmuNjnO0QTg9ZS2VmiNtmjM4Eb7frMZBQT4Jx5Hd8RR?=
 =?us-ascii?Q?RMszjyV9b5ePYRc6GaMOv47NSnxM0mqD3hM12aR05vZmvbLKlXMOlpbdiyl0?=
 =?us-ascii?Q?rOIOxFEduZU9u5qh6y8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cbaddc-76ef-43ed-15a7-08dbd5d725fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 03:53:43.5074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 16nCpxUihgrDad0SIyC/RtberwSEH8ZdPzmPru/rNWy71XYra6vNGn9Er+tr9Vte
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>=20
Sent: Thursday, October 26, 2023 11:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <Kevi=
nYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: fix the high voltage and temperature issue

fix the high voltage and temperature issue after the driver is unloaded on =
smu 13.0.0, smu 13.0.7 and smu 13.0.10
v2 - fix the code format and make sure it is used on the unload case only.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 25 ++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 33 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +  drivers/gpu/drm/amd/=
pm/swsmu/inc/smu_v13_0.h  |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 13 ++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 18 ++++++++--  .../drm/amd=
/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 19 +++++++++--
 7 files changed, 96 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 31f8c3ead161..1ad0fc3f3861 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3986,13 +3986,23 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				}
 			}
 		} else {
-			tmp =3D amdgpu_reset_method;
-			/* It should do a default reset when loading or reloading the driver,
-			 * regardless of the module parameter reset_method.
-			 */
-			amdgpu_reset_method =3D AMD_RESET_METHOD_NONE;
-			r =3D amdgpu_asic_reset(adev);
-			amdgpu_reset_method =3D tmp;
+			switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+			case IP_VERSION(13, 0, 0):
+			case IP_VERSION(13, 0, 7):
+			case IP_VERSION(13, 0, 10):
+				r =3D psp_gpu_reset(adev);
+				break;
+			default:
+				tmp =3D amdgpu_reset_method;
+				/* It should do a default reset when loading or reloading the driver,
+				 * regardless of the module parameter reset_method.
+				 */
+				amdgpu_reset_method =3D AMD_RESET_METHOD_NONE;
+				r =3D amdgpu_asic_reset(adev);
+				amdgpu_reset_method =3D tmp;
+				break;
+			}
+
 			if (r) {
 				dev_err(adev->dev, "asic reset on init failed\n");
 				goto failed;
@@ -5945,6 +5955,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 		return -ENOTSUPP;
=20
 	ret =3D amdgpu_dpm_baco_exit(adev);
+
[kevin]:
This blank line is not needed.

 	if (ret)
 		return ret;
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 7c3356d6da5e..2e82172ba250 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -733,7 +733,7 @@ static int smu_early_init(void *handle)
 	smu->adev =3D adev;
 	smu->pm_enabled =3D !!amdgpu_dpm;
 	smu->is_apu =3D false;
-	smu->smu_baco.state =3D SMU_BACO_STATE_EXIT;
+	smu->smu_baco.state =3D SMU_BACO_STATE_NONE;
 	smu->smu_baco.platform_support =3D false;
 	smu->user_dpm_profile.fan_mode =3D -1;
=20
@@ -1740,10 +1740,31 @@ static int smu_smc_hw_cleanup(struct smu_context *s=
mu)
 	return 0;
 }
=20
+static int smu_reset_mp1_state(struct smu_context *smu) {
+	struct amdgpu_device *adev =3D smu->adev;
+	int ret =3D 0;
+
+	if ((!adev->in_runpm) && (!adev->in_suspend) &&
+		(!amdgpu_in_reset(adev)))
+		switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+		  case IP_VERSION(13, 0, 0):
+		  case IP_VERSION(13, 0, 7):
+		  case IP_VERSION(13, 0, 10):
+			ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
+			break;
+		  default:
+			break;
+		}
+
+	return ret;
+}
[kevin]:

Hi Kenneth,

I prefer to add a callback function in _ppt.c file to avoid IP version chec=
k in SMU common file.
But either way is okay for me.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Thanks.

Best Regards,
Kevin
+
 static int smu_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
 	struct smu_context *smu =3D adev->powerplay.pp_handle;
+	int ret;
=20
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
@@ -1761,7 +1782,15 @@ static int smu_hw_fini(void *handle)
=20
 	adev->pm.dpm_enabled =3D false;
=20
-	return smu_smc_hw_cleanup(smu);
+	ret =3D smu_smc_hw_cleanup(smu);
+	if (ret)
+		return ret;
+
+	ret =3D smu_reset_mp1_state(smu);
+	if (ret)
+		return ret;
+
+	return 0;
 }
=20
 static void smu_late_fini(void *handle) diff --git a/drivers/gpu/drm/amd/p=
m/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 1454eed76604..9f2dbc90b606 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -419,6 +419,7 @@ enum smu_reset_mode {  enum smu_baco_state {
 	SMU_BACO_STATE_ENTER =3D 0,
 	SMU_BACO_STATE_EXIT,
+	SMU_BACO_STATE_NONE,
 };
=20
 struct smu_baco_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index cc02f979e9e9..43c7ba68eb50 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -299,5 +299,7 @@ int smu_v13_0_update_pcie_parameters(struct smu_context=
 *smu,
 				     uint8_t pcie_gen_cap,
 				     uint8_t pcie_width_cap);
=20
+int smu_v13_0_disable_pmfw_state(struct smu_context* smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index bcb7ab9d2221..0724441e53ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2473,3 +2473,16 @@ int smu_v13_0_update_pcie_parameters(struct smu_cont=
ext *smu,
=20
 	return 0;
 }
+
+int smu_v13_0_disable_pmfw_state(struct smu_context* smu) {
+	int ret;
+	struct amdgpu_device *adev =3D smu->adev;
+
+	WREG32_PCIE(MP1_Public | (smnMP1_FIRMWARE_FLAGS & 0xffffffff), 0);
+
+	ret =3D RREG32_PCIE(MP1_Public |
+					   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
+
+	return ret =3D=3D 0 ? 0 : -EINVAL;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 47d008cbc186..02c5e7b1e43b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2570,14 +2570,20 @@ static int smu_v13_0_0_baco_enter(struct smu_contex=
t *smu)  static int smu_v13_0_0_baco_exit(struct smu_context *smu)  {
 	struct amdgpu_device *adev =3D smu->adev;
+	int ret;
=20
 	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
 		/* Wait for PMFW handling for the Dstate change */
 		usleep_range(10000, 11000);
-		return smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+		ret =3D smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
 	} else {
-		return smu_v13_0_baco_exit(smu);
+		ret =3D smu_v13_0_baco_exit(smu);
 	}
+
+	if (!ret)
+		adev->gfx.is_poweron =3D false;
+
+	return ret;
 }
=20
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu) =
@@ -2758,7 +2764,13 @@ static int smu_v13_0_0_set_mp1_state(struct smu_cont=
ext *smu,
=20
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		ret =3D smu_cmn_set_mp1_state(smu, mp1_state);
+		ret =3D smu_cmn_send_smc_msg_with_param(smu,
+								SMU_MSG_PrepareMp1ForUnload,
+								0x55, NULL);
+
+		if (!ret && smu->smu_baco.state =3D=3D SMU_BACO_STATE_EXIT)
+			ret =3D smu_v13_0_disable_pmfw_state(smu);
+
 		break;
 	default:
 		/* Ignore others */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b8a7a1d853df..40e8d1767b71 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2429,7 +2429,13 @@ static int smu_v13_0_7_set_mp1_state(struct smu_cont=
ext *smu,
=20
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		ret =3D smu_cmn_set_mp1_state(smu, mp1_state);
+		ret =3D smu_cmn_send_smc_msg_with_param(smu,
+								SMU_MSG_PrepareMp1ForUnload,
+								0x55, NULL);
+
+		if (!ret && smu->smu_baco.state =3D=3D SMU_BACO_STATE_EXIT)
+			ret =3D smu_v13_0_disable_pmfw_state(smu);
+
 		break;
 	default:
 		/* Ignore others */
@@ -2455,14 +2461,21 @@ static int smu_v13_0_7_baco_enter(struct smu_contex=
t *smu)  static int smu_v13_0_7_baco_exit(struct smu_context *smu)  {
 	struct amdgpu_device *adev =3D smu->adev;
+	int ret;
=20
 	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
 		/* Wait for PMFW handling for the Dstate change */
 		usleep_range(10000, 11000);
-		return smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+		ret =3D smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
 	} else {
-		return smu_v13_0_baco_exit(smu);
+		ret =3D smu_v13_0_baco_exit(smu);
 	}
+
+	if (!ret)
+		adev->gfx.is_poweron =3D false;
+
+	return ret;
+
[kevin]:
Please remove this blank line too.
 }
=20
 static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *smu)
--
2.34.1

