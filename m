Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51916C0032E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 03:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5DA510E544;
	Wed, 25 Oct 2023 03:53:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FEB310E544
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 03:53:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6eRC5KTkTXTjjhC+A8KT0WIQnxqeXZCGs/ZnTJhvoKxExgvN50Tux3OZ/zzK2/IZkrDhMhrlFq7hqyeS0ru5ku99tDyEzMwg7O3RbqMyxZkG8HWzMQidV0Y5RnxHHcXti8Zyvh5OvomntN+2Es9nT4YvKkCdvfoSvmdBdiHWylCYMgNJix7uXqsLuVgi1g3EPSLwlPA8oBi/pubYjPoRDsVzSZ2F1NR8q2N6B2IkxRAfPJRWLECgVS8nLs4H6y3bYtMjlg+QI/6GgOteWvppmTLIQzpyiYwieDnikkAETRAHVk12etc9/8IWUkGY9ILMMTale0xcGda/frkXpTFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDW1/vgfUFM+Ik/xC38T0zEets8N6XNlMLEDEjV+W8A=;
 b=IGPI+35KB3Z6W23gfgxBduE69SAq1hdq7V5H4eRFIlLuTCqsRFz3WRN+cmBtw1oUCVD97aYi9lAAfZCCNncHzHRfLpD3bbsIhjHt+NhMakKUGE7aChUAh37UWCq6eBJWehpDe5SCmTHkO5MIUFNPqiU4GpaaXPuXmRH8guk8UPsJk+U0Xw/5Q8i27NiKvOBUz85kkzX/WbqWIMwT0JbU0K1EzD0EqaH+JgLHa00ihCvlfZKnUGWIWJHzCFNHoWrXuTGa2nLFrMU/n/iKY8z5hnRfFSfmMKrAShbOYJexHyN9qTFUroBpChnthqzkRkSb1JgFBEum4tX5yc61Rv5mfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDW1/vgfUFM+Ik/xC38T0zEets8N6XNlMLEDEjV+W8A=;
 b=FTnO0KmiLrQtjPSeahn30plyynvEYYMuDOGethNn08JgxeaQNVG3pcTEoO6HLS2uNe0EmF0j8AtvXnnBEvX42aZMOScmFtrnhHhpIJPcmdem+Wohj5C/Gy8PgxEUmkZz0q5d+lZxGBd8MzT7fI+79APrUgLTHN7fLENHL+qc+TU=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 CH0PR12MB5298.namprd12.prod.outlook.com (2603:10b6:610:d5::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 25 Oct 2023 03:53:24 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 03:53:23 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: fix the high voltage and temperature issue
Thread-Topic: [PATCH v2] drm/amd/pm: fix the high voltage and temperature issue
Thread-Index: AQHaBvZusSTAX30VvEuxShB2ewjGfbBZ34eg
Date: Wed, 25 Oct 2023 03:53:23 +0000
Message-ID: <DM4PR12MB51651EFC124CF2DAA37E2E788EDEA@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231025035035.766947-1-kenneth.feng@amd.com>
In-Reply-To: <20231025035035.766947-1-kenneth.feng@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8a87cd91-fbe0-4255-a938-68391e70b4b9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-25T03:52:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|CH0PR12MB5298:EE_
x-ms-office365-filtering-correlation-id: 146dc1b1-48a2-4d46-4e1c-08dbd50defd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QCpuMPWS10lWvqZH3P6skrtJ+hXW60ewjW2U3ocp6q6HFOccboH+RGt98D21DC9ypzNulkkjTcZ1Hz3wyEd3KsvlUDWBh0RKmkjSNgf+9zom4XhN2plv1UWJ9TEgAWwK+4kWT1zEobR9+b2kWoj04wXn1lE6czsqmiNhjpEDxFaOrr34tkOJoTzw1NpSPWGoT9uJV88kYIBD6AiGHfoGvY3t/xnb9i1edtkezEc9M28ryhEaGZ8Af+aauXP9xrRpmIeO3QCHs7S7fdFCiciO6nDNf3ZVixH/C9AbUEsMGfFDnwfStNEYm/+D8Ic97xWXQ0L0tSh3UCSCOl7Ai4+IH5WaIcN5NKb8QevII4i7OZHVlqzMoBO0CSz0X5asTYp5bMhJAZJ/4hHwl8lJrAKqpcPFj8+XFaHLdQExlX6LXod4OsDnEX+7qdaL2bGR/9NWBfxplezfJ/keIZ+xzo3MInpTrjkDgw4oFJ5vFqQo1CGaSC6KGzOL9VCUbFMvoTJmkE/fSVvkJsVnFruybO1LiH7ZPK89pxgtLox9blLVrR90UQnSnQ9OrK6Ua/vqxBXf3bYtRyCRIhh+Eushzw7ZFpd39DV/1jd8aJFWAuAPYxvn92BeP6VdJqylEJjTn7OKQRr/77UNAtazRA7PDDnMtg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(41300700001)(55016003)(66446008)(64756008)(66556008)(66476007)(110136005)(76116006)(38100700002)(9686003)(7696005)(122000001)(478600001)(52536014)(86362001)(71200400001)(53546011)(33656002)(6506007)(26005)(83380400001)(5660300002)(2906002)(316002)(66946007)(8936002)(38070700009)(4326008)(8676002)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WTqJiH13S4zFwx5+KDMDBv2pCbKeIeDMev7TnlGyIOBe0tJ/pESFhyF0l7P/?=
 =?us-ascii?Q?LZN7njdpCYhxHC5tvBXCHQ8NQKZnK7AMZS7r9UohZMEnF+lMv4qHQqfHYksb?=
 =?us-ascii?Q?RU63UNm/J2an31v/4wMPC+eHBBP9pptOO2U2T/q3jxLEyUvukumE8B9J6WAp?=
 =?us-ascii?Q?JrZetu7cohMwZL+lkfTdQXmvXCXM58pEujjFZfiKAJO345Pp7TQhs+VnwPkd?=
 =?us-ascii?Q?D8VEQrmiFywMxHAnmZwVQQIttnBoFULwpQ1LE9dX26iGYMONwg2mxSRxHIps?=
 =?us-ascii?Q?41tYnUIpUNLqiRuLwv598FTKGdRec3+gz6+rXj/W30jUTFC369M5oNNoZjTm?=
 =?us-ascii?Q?WnXasJ02CwHwm7JsMk5OuQYisEEBsCBD1XXAgSocEKVd23NHU3Wmmep/EKU7?=
 =?us-ascii?Q?sU4fb3Ll1HhFCBi3YSiUXhLZpfvQk5RNeUbqLeRlJgdYFx1TRxinrGcy8tFe?=
 =?us-ascii?Q?uGSOC/ZMY6x4LEUNKLbYKRjEqXrdehFNy9fszbRBQf4gGzmqZzplTS3XXETZ?=
 =?us-ascii?Q?iQzzOcg44gAGTHbv87ENbpKai38mvZ363GFBfsF3uH86bspKyNI9SJE4XWKU?=
 =?us-ascii?Q?2+wceDErJZvFjmHaUi4FdbHGmlcAFIIW7b5/RW6K23jQqw8wp9n+7AyvVzLZ?=
 =?us-ascii?Q?SoKKV2faHVKmG2QvoasfJHq5RXtpYR2KqBltnWikyI6lcy4TwduRQOaHfux7?=
 =?us-ascii?Q?dSt/QLk0qHhgn5clfHHaTeHb5JpSBpq0jS/17zaxPWT+SRTVyDyrAM9EKZWx?=
 =?us-ascii?Q?zkidZASBmo2PkFl8LFjeBgq9E9BAj80KRS6P58Bgp+UPICQih67eTb+sY9tS?=
 =?us-ascii?Q?JYwdjUpHlSEpDSsj2BNdSXZSpA5rCG8hxjUbZhsEB4ck32DCXX7Q1m5gs/mL?=
 =?us-ascii?Q?ynGacjegriPJhItdy9OgcqIK0dSfUWP0pD8Q6uZ9QB+OdEk8B136bJqXNKKQ?=
 =?us-ascii?Q?y1VkEGIooMo68WZoIYPBikRBPiTfPVcf1FrFQaaCbUuOfSjk5XPk8XqX/TGn?=
 =?us-ascii?Q?ISkI8Mm6AaztALuYsEDZtdz6rDbi+xfobFG38suqEzXqN2wDa4xuKF88MI97?=
 =?us-ascii?Q?wtwHpvmUNr/2sRo+Fs0b604P6wghNjW2Pl+8YGNlvLGq73FjcABceps/NPBI?=
 =?us-ascii?Q?WIZzsdA3gCLGkMg/N+/BljrJMyJxUBdwEsMkrWJ0FOzTDwnRzfSBsMFOnxNx?=
 =?us-ascii?Q?hDWSYR6tFmwOt1HN5KN67gtpe5WLQ8OnN1u5OOnDvuDSgVRvLooWoEUec7IZ?=
 =?us-ascii?Q?DfkyRDtzcq/N42ngDbGgm6+3Ywqn/zjUSPoXaXIhR8w+7cLn6UpCfWKNBB6k?=
 =?us-ascii?Q?0yCnxsaDzSrF0E60jk5isglvJyPdylnci6zHjkWTRT4D42Ii9R84+rfwNmj0?=
 =?us-ascii?Q?PisfBgotJxYQneHzb/iibVV8h+KY5vEzuH7e9oMblkIztJ5ZfBwYOpI5liRY?=
 =?us-ascii?Q?wYBl8Q/1JvveLi5n5x6Zi4uTbQa9BVWxYfKkKHdu/0qS5gbdB79o2Wd0YOD+?=
 =?us-ascii?Q?qnHifYQItDYtOKVNRxEBHcsYplTuQC2BtcyBYsU1wUAbGlmlv+022avHcs49?=
 =?us-ascii?Q?cXSq9Zk9g7ijhIIqqi8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146dc1b1-48a2-4d46-4e1c-08dbd50defd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 03:53:23.7839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxfvbvvXmijCr1KJMU4ns+1yn0qfx7mn85auCTZeJoQII52Cm1Z+CYUNTPbMqDVY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5298
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Sorry that I forgot another change in this V2.
Please ignore this one.
Thanks.


-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Wednesday, October 25, 2023 11:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: fix the high voltage and temperature issue

fix the high voltage and temperature issue after the driver is unloaded on =
smu 13.0.0, smu 13.0.7 and smu 13.0.10
v2 - fix the code format and make sure it is used on the unload case only.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 36 +++++++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 33 +++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +  drivers/gpu/drm/amd/=
pm/swsmu/inc/smu_v13_0.h  |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 13 +++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  8 ++++-  .../drm/amd/pm/s=
wsmu/smu13/smu_v13_0_7_ppt.c  |  8 ++++-
 7 files changed, 90 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 31f8c3ead161..c5c892a8b3f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3986,13 +3986,23 @@ int amdgpu_device_init(struct amdgpu_device *adev,
                                }
                        }
                } else {
-                       tmp =3D amdgpu_reset_method;
-                       /* It should do a default reset when loading or rel=
oading the driver,
-                        * regardless of the module parameter reset_method.
-                        */
-                       amdgpu_reset_method =3D AMD_RESET_METHOD_NONE;
-                       r =3D amdgpu_asic_reset(adev);
-                       amdgpu_reset_method =3D tmp;
+                       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+                       case IP_VERSION(13, 0, 0):
+                       case IP_VERSION(13, 0, 7):
+                       case IP_VERSION(13, 0, 10):
+                               r =3D psp_gpu_reset(adev);
+                               break;
+                       default:
+                               tmp =3D amdgpu_reset_method;
+                               /* It should do a default reset when loadin=
g or reloading the driver,
+                                * regardless of the module parameter reset=
_method.
+                                */
+                               amdgpu_reset_method =3D AMD_RESET_METHOD_NO=
NE;
+                               r =3D amdgpu_asic_reset(adev);
+                               amdgpu_reset_method =3D tmp;
+                               break;
+                       }
+
                        if (r) {
                                dev_err(adev->dev, "asic reset on init fail=
ed\n");
                                goto failed;
@@ -5945,6 +5955,18 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
                return -ENOTSUPP;

        ret =3D amdgpu_dpm_baco_exit(adev);
+
+       if (!ret)
+               switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+               case IP_VERSION(13, 0, 0):
+               case IP_VERSION(13, 0, 7):
+               case IP_VERSION(13, 0, 10):
+                       adev->gfx.is_poweron =3D false;
+                       break;
+               default:
+                       break;
+               }
+
        if (ret)
                return ret;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 7c3356d6da5e..2e82172ba250 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -733,7 +733,7 @@ static int smu_early_init(void *handle)
        smu->adev =3D adev;
        smu->pm_enabled =3D !!amdgpu_dpm;
        smu->is_apu =3D false;
-       smu->smu_baco.state =3D SMU_BACO_STATE_EXIT;
+       smu->smu_baco.state =3D SMU_BACO_STATE_NONE;
        smu->smu_baco.platform_support =3D false;
        smu->user_dpm_profile.fan_mode =3D -1;

@@ -1740,10 +1740,31 @@ static int smu_smc_hw_cleanup(struct smu_context *s=
mu)
        return 0;
 }

+static int smu_reset_mp1_state(struct smu_context *smu) {
+       struct amdgpu_device *adev =3D smu->adev;
+       int ret =3D 0;
+
+       if ((!adev->in_runpm) && (!adev->in_suspend) &&
+               (!amdgpu_in_reset(adev)))
+               switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+                 case IP_VERSION(13, 0, 0):
+                 case IP_VERSION(13, 0, 7):
+                 case IP_VERSION(13, 0, 10):
+                       ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD)=
;
+                       break;
+                 default:
+                       break;
+               }
+
+       return ret;
+}
+
 static int smu_hw_fini(void *handle)
 {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
        struct smu_context *smu =3D adev->powerplay.pp_handle;
+       int ret;

        if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
                return 0;
@@ -1761,7 +1782,15 @@ static int smu_hw_fini(void *handle)

        adev->pm.dpm_enabled =3D false;

-       return smu_smc_hw_cleanup(smu);
+       ret =3D smu_smc_hw_cleanup(smu);
+       if (ret)
+               return ret;
+
+       ret =3D smu_reset_mp1_state(smu);
+       if (ret)
+               return ret;
+
+       return 0;
 }

 static void smu_late_fini(void *handle) diff --git a/drivers/gpu/drm/amd/p=
m/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 1454eed76604..9f2dbc90b606 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -419,6 +419,7 @@ enum smu_reset_mode {  enum smu_baco_state {
        SMU_BACO_STATE_ENTER =3D 0,
        SMU_BACO_STATE_EXIT,
+       SMU_BACO_STATE_NONE,
 };

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

        return 0;
 }
+
+int smu_v13_0_disable_pmfw_state(struct smu_context* smu) {
+       int ret;
+       struct amdgpu_device *adev =3D smu->adev;
+
+       WREG32_PCIE(MP1_Public | (smnMP1_FIRMWARE_FLAGS & 0xffffffff), 0);
+
+       ret =3D RREG32_PCIE(MP1_Public |
+                                          (smnMP1_FIRMWARE_FLAGS & 0xfffff=
fff));
+
+       return ret =3D=3D 0 ? 0 : -EINVAL;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 47d008cbc186..e2a09fe29e2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2758,7 +2758,13 @@ static int smu_v13_0_0_set_mp1_state(struct smu_cont=
ext *smu,

        switch (mp1_state) {
        case PP_MP1_STATE_UNLOAD:
-               ret =3D smu_cmn_set_mp1_state(smu, mp1_state);
+               ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                                               SMU_MSG_Pre=
pareMp1ForUnload,
+                                                               0x55, NULL)=
;
+
+               if (!ret && smu->smu_baco.state =3D=3D SMU_BACO_STATE_EXIT)
+                       ret =3D smu_v13_0_disable_pmfw_state(smu);
+
                break;
        default:
                /* Ignore others */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b8a7a1d853df..2a0d1da18a9b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2429,7 +2429,13 @@ static int smu_v13_0_7_set_mp1_state(struct smu_cont=
ext *smu,

        switch (mp1_state) {
        case PP_MP1_STATE_UNLOAD:
-               ret =3D smu_cmn_set_mp1_state(smu, mp1_state);
+               ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                                               SMU_MSG_Pre=
pareMp1ForUnload,
+                                                               0x55, NULL)=
;
+
+               if (!ret && smu->smu_baco.state =3D=3D SMU_BACO_STATE_EXIT)
+                       ret =3D smu_v13_0_disable_pmfw_state(smu);
+
                break;
        default:
                /* Ignore others */
--
2.34.1

