Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B096CC4725D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jan 2024 20:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78EF310E1CE;
	Fri, 19 Jan 2024 20:19:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4FED10E1CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 20:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1FV/gjAgP6rIY+FeFRuyl94tkr4eTZuoSlDusJumRLf9yuwr+1MJ9aV1B8gK2wKLPf8zVWe/xhFJAQtiRXR+5lOBmPHvcz2K0+vYKr0Tg8E8Zb7K5ECxwIyv8iaxU57rvLJfdP/rxCuJU88VTrKApY9XksnK5IVp/RJ3zP6xY0fdtDoaFDtYbaxXDzsJxdpK3qsWkxZemMy48ZaAmXI0uonzEc66I7EYe8+Dvf+ZxoTiyAzVtNksD3cUteT3xdnB1BmZWFYeQ4TUF21n8EWzrtQdW5hBPM/VlHJDohiVhayx2gIF/JNuiJSaEq5XoRyp0I17JxE4JxhIpQ6+HtTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SLk8HaN0MnprP4V/EQ97tDxhg73r0IadKtzhjNyGYY=;
 b=n6IExt3cwk5nx2QFMqHIzEu5+PTyq7BRpJF4sgipMSnX4Np7K0JxvC8Vbzh07hncU0HfSPXa3TXUfHvnUbsqRofNVzeP3mjUqU7ksiraoLjh+E6Id68M9FQK52P/ytRX5zMhz8QeuvCL9vIwytq3LTvXI5jMubzY+fHrZLIs1/XQjDSPZAZbW685FmjHbe4AuC9sE3+VNqu/gXgh098An/zcMLWyy/taNEVhwahBVwOgWCBV98GelFhWpjGZs14XdQrHDJjfug/LPn8krZivRIYLELstmRSrBjpE+xTtsyIPixtyRQbAuOCRBrK8SrQ1+JjT/cqJEga/QRDpXRy1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SLk8HaN0MnprP4V/EQ97tDxhg73r0IadKtzhjNyGYY=;
 b=Us4ysA2vC4JEhLCFJsOPHNokjFKGiAMZ5vSHepFYUvXqsKszGZsURe8v+hThLxmSdY2syHFtQhloVWDoewE5LGJCVk8rTi73cntw/bRzeTPIXln6XG0hR0UkWk0bQgpMB2yhYftFOLyOIoh5VyojN0qwd0iqyjc/lm4jTL0Naoc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 20:19:44 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%7]) with mapi id 15.20.7202.026; Fri, 19 Jan 2024
 20:19:44 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amd/pm: fix the high voltage and temperature
 issue"
Thread-Topic: [PATCH] Revert "drm/amd/pm: fix the high voltage and temperature
 issue"
Thread-Index: AQHaSxRGxNIWFhvOGkO6OvcXfx6yB7Dhk1kF
Date: Fri, 19 Jan 2024 20:19:44 +0000
Message-ID: <BL1PR12MB5144CE12BC49681460E25742F7702@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240119091600.30188-1-mario.limonciello@amd.com>
In-Reply-To: <20240119091600.30188-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-19T20:19:43.719Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|LV2PR12MB5869:EE_
x-ms-office365-filtering-correlation-id: f4e2583e-a714-4ca9-383b-08dc192bf98a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BCuenzpt7naSKUcElbwizF8P26sxzRkcjLobA5gbW+R7w1oc5vPEn5XmEc8n8Dy1MVwC7Idtk2jc5UACKcRsejFslCfZO64TD2SkLAjFYolvOOKaAEv9izbnnL/76N8Xzn6CGTtTPzPjJifq8ICsa796IPJha2wlpuBao9AoXJqpmgLg/bVAZnt9q+dPPoG3JcQelZgCNX8XGit0SZz/C9BL02YsN7nA/CP2JTtdHI/w+HnjY8IrgtWAyURsqAaoPk7luKnjKdOJsCoDu2xbX2C7Jejfur9xJkPMwbNOri6llIO9EcpW1z0VB8oZtJyezglhUiO9r20XKzc+1DW5Ev8MwKUWID/4FipgpJ1zNbcTzdbHJf5Yf2z0wBuXl4dicKkm9jn+TxeruAXEz8Udo/Iv7mDUqFlvGIeaa/nNhTpZyE+F2OyHid7XCnxiGfqLYx4f1XHOtXG0XEiq/1fwvdDU7k4oVqBTKhNObwp5seI5Bnal276vKFOAzd6CqWXeHdRnPdqqzny7jUMTMNLyKMaPfCOU5skx9d7xrqdKPqqBzFrpRAyyQ7Tyc+8hZBbMu2j0omZumqStFbYS9qvUSKA2AqlQhyNtB6F9sy4n8Dz1HTFL+v/cpSspLxNC4oRk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(9686003)(83380400001)(76116006)(54906003)(122000001)(38100700002)(5660300002)(4326008)(8676002)(316002)(52536014)(8936002)(64756008)(966005)(66476007)(53546011)(110136005)(71200400001)(478600001)(7696005)(2906002)(66446008)(66556008)(66946007)(6506007)(38070700009)(86362001)(33656002)(166002)(55016003)(19627405001)(41300700001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zYFLb0lCaNGaUCstgBTaOA5KgSS45ER5yUnUgNu+Ut9RpIPUwzaanjXDyy7E?=
 =?us-ascii?Q?ZbPWVBtL7HydO3/TLulh09tAVCX3IoEyJPSPMf0oBJ+mfhOPi8BuxJDNw7Sk?=
 =?us-ascii?Q?MvJ7RulUjDRKqZzVashRtJSR7gpPdoFUYQHLYK8hj4PdEl6iUOjW5I6lk6QM?=
 =?us-ascii?Q?gonFCtVSLgohteVMM1REhY6wgsOvvQ6sRqefVEQDcWfik0CWOh9pyPmX3Z4R?=
 =?us-ascii?Q?tnOtdb3xSyNa+xu/q+AgMFJlQGElgFgQr0jNawlRiY2AcJPqEHniZ1c/qKLG?=
 =?us-ascii?Q?eqpWQmwfobCMCanuYaMAD4c9QaDArkPpdTb8Ed8dOzSDoxPoww39elQb9i2x?=
 =?us-ascii?Q?nRaagFoROvjINLts3U2aJOtrcLMTZSRriLd7h8ayS+Wiawak6FImnV9VgLNM?=
 =?us-ascii?Q?66a8vn1PgBzrhxN7Nmuy4zgjlZGPbsOgXa+sVEIxq66QTDPzkzYTJQwbQiFp?=
 =?us-ascii?Q?h4PrpDBP1FdRFZLTCFHR1PR6o9TXCu/CDlh8nuGrCWuWPfCJJ6TqtyToOOFc?=
 =?us-ascii?Q?8XsrPuCMqXmiUZbZxEx+oNwmwzhQB9SS1BFq3dls0PlGefprjdhJedkoYCz1?=
 =?us-ascii?Q?i8wPKa67+CE4CUEK2J/B6us7I0xAzQdZexuaxGmnyooECzi+vOSNyIwHuAUT?=
 =?us-ascii?Q?SAd7MjD1vcT8Nq/VvU6cxs8H+l/gXz17lHeyNV2LFFzQnDeFncIxFrB1d8kL?=
 =?us-ascii?Q?CQFSb1EBKBQYtBCU2Lr+BM0S1SnOsHY7jAiys3j1KEBQPCtG1WsV7BDUO5tF?=
 =?us-ascii?Q?MNOFCOpzdbo1KOGzZWAvqv8W4gS5MvHO/TQqjwc2EuagdyFdr7a26+Azgncn?=
 =?us-ascii?Q?dVzoYHZqFC4YR+ZmAbov0RVkAFwEaKVi+153fCKEiSEZdze6B4Oz/brzNng6?=
 =?us-ascii?Q?AqQEst/n0XGf/l0GK/HDexttB+SyTWQOijbBiBOJrSapydOhwpqFN4hE2kkZ?=
 =?us-ascii?Q?88h/dZ7lPyF10xZyWQrxoEhSc7WAhSIkyHzUQBIJ0KeR3wRkkN/kIwJDHCkg?=
 =?us-ascii?Q?0uz5LeA3pyZ6IlY3SCQCkZDXeNfaUQercRAzvpEgh5/vmcUEX+CyWsE9sUb4?=
 =?us-ascii?Q?+wdKR1JpBRhWFemgSVyw+pBdf4In0NbX7l22c31lQ5zxtEWDkRApKRVxQVB/?=
 =?us-ascii?Q?I7whIXXcJzOgrEVc4Iylp1e5aG72C26m1kDJozk+YXP4JfZKuEmVaOdU47cp?=
 =?us-ascii?Q?xbUph8e6ux7Z3Ss2LnZrEtEtiVaU6uN94skQHMgLlGmh6K5PJgzFwshkFVn1?=
 =?us-ascii?Q?rmnIyvvJUteQZ6RqFQnmxWEZIOBnIHF32T6QbBmyu19DNfKOThNDuOZQW9zX?=
 =?us-ascii?Q?+9estmL8bvWloEVb4X3oYJMwqUQSR6D5L4jnsrsNxtTL1pV1KbtNTMNq9UaS?=
 =?us-ascii?Q?VJQ3d1hKMCgJOb4YNmTU9/VeA6WL1qYCoMaChO1dO4gwiyEmsg1O23KS/BYM?=
 =?us-ascii?Q?c1EJdrwUWA6V9xjD1ycPyKflyAdnOEamKOquqZywN4bhg0Fm5z7rtjAB5B+A?=
 =?us-ascii?Q?Z31lX+qK69iYvl8qJ2W7zhu8G1YQJE06cVqdB8aJGloSjcTenhnse7R6iKK0?=
 =?us-ascii?Q?stjniUPWLSX6JIdRdU8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144CE12BC49681460E25742F7702BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e2583e-a714-4ca9-383b-08dc192bf98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 20:19:44.0300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4znJibZV/Rxn1E78xelJuI9WKrGKM2VnNm+LP55gzYZIOm5DY94dMXMfo09TI0Lj6yVHP10AGPE79+XS+Hpjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144CE12BC49681460E25742F7702BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Friday, January 19, 2024 4:16 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Limonciello, Mario <Mario.Limonci=
ello@amd.com>; stable@vger.kernel.org <stable@vger.kernel.org>
Subject: [PATCH] Revert "drm/amd/pm: fix the high voltage and temperature i=
ssue"

This reverts commit 5f38ac54e60562323ea4abb1bfb37d043ee23357.
This causes issues with rebooting and the 7800XT.

Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: stable@vger.kernel.org
Fixes: 5f38ac54e605 ("drm/amd/pm: fix the high voltage and temperature issu=
e")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3062
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 24 ++++----------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 33 ++-----------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  8 +----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  8 +----
 5 files changed, 11 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b4c19e3d0bf1..56d9dfa61290 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4131,23 +4131,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
                                 }
                         }
                 } else {
-                       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-                       case IP_VERSION(13, 0, 0):
-                       case IP_VERSION(13, 0, 7):
-                       case IP_VERSION(13, 0, 10):
-                               r =3D psp_gpu_reset(adev);
-                               break;
-                       default:
-                               tmp =3D amdgpu_reset_method;
-                               /* It should do a default reset when loadin=
g or reloading the driver,
-                                * regardless of the module parameter reset=
_method.
-                                */
-                               amdgpu_reset_method =3D AMD_RESET_METHOD_NO=
NE;
-                               r =3D amdgpu_asic_reset(adev);
-                               amdgpu_reset_method =3D tmp;
-                               break;
-                       }
-
+                       tmp =3D amdgpu_reset_method;
+                       /* It should do a default reset when loading or rel=
oading the driver,
+                        * regardless of the module parameter reset_method.
+                        */
+                       amdgpu_reset_method =3D AMD_RESET_METHOD_NONE;
+                       r =3D amdgpu_asic_reset(adev);
+                       amdgpu_reset_method =3D tmp;
                         if (r) {
                                 dev_err(adev->dev, "asic reset on init fai=
led\n");
                                 goto failed;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index c16703868e5c..961cd2aaf137 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -733,7 +733,7 @@ static int smu_early_init(void *handle)
         smu->adev =3D adev;
         smu->pm_enabled =3D !!amdgpu_dpm;
         smu->is_apu =3D false;
-       smu->smu_baco.state =3D SMU_BACO_STATE_NONE;
+       smu->smu_baco.state =3D SMU_BACO_STATE_EXIT;
         smu->smu_baco.platform_support =3D false;
         smu->user_dpm_profile.fan_mode =3D -1;

@@ -1961,31 +1961,10 @@ static int smu_smc_hw_cleanup(struct smu_context *s=
mu)
         return 0;
 }

-static int smu_reset_mp1_state(struct smu_context *smu)
-{
-       struct amdgpu_device *adev =3D smu->adev;
-       int ret =3D 0;
-
-       if ((!adev->in_runpm) && (!adev->in_suspend) &&
-               (!amdgpu_in_reset(adev)))
-               switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-               case IP_VERSION(13, 0, 0):
-               case IP_VERSION(13, 0, 7):
-               case IP_VERSION(13, 0, 10):
-                       ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD)=
;
-                       break;
-               default:
-                       break;
-               }
-
-       return ret;
-}
-
 static int smu_hw_fini(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         struct smu_context *smu =3D adev->powerplay.pp_handle;
-       int ret;

         if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
                 return 0;
@@ -2003,15 +1982,7 @@ static int smu_hw_fini(void *handle)

         adev->pm.dpm_enabled =3D false;

-       ret =3D smu_smc_hw_cleanup(smu);
-       if (ret)
-               return ret;
-
-       ret =3D smu_reset_mp1_state(smu);
-       if (ret)
-               return ret;
-
-       return 0;
+       return smu_smc_hw_cleanup(smu);
 }

 static void smu_late_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 2aa4fea87314..66e84defd0b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -424,7 +424,6 @@ enum smu_reset_mode {
 enum smu_baco_state {
         SMU_BACO_STATE_ENTER =3D 0,
         SMU_BACO_STATE_EXIT,
-       SMU_BACO_STATE_NONE,
 };

 struct smu_baco_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 231122622a9c..bc8bd67c48ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2748,13 +2748,7 @@ static int smu_v13_0_0_set_mp1_state(struct smu_cont=
ext *smu,

         switch (mp1_state) {
         case PP_MP1_STATE_UNLOAD:
-               ret =3D smu_cmn_send_smc_msg_with_param(smu,
-                                                                          =
               SMU_MSG_PrepareMp1ForUnload,
-                                                                          =
               0x55, NULL);
-
-               if (!ret && smu->smu_baco.state =3D=3D SMU_BACO_STATE_EXIT)
-                       ret =3D smu_v13_0_disable_pmfw_state(smu);
-
+               ret =3D smu_cmn_set_mp1_state(smu, mp1_state);
                 break;
         default:
                 /* Ignore others */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 59606a19e3d2..0906221231ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2504,13 +2504,7 @@ static int smu_v13_0_7_set_mp1_state(struct smu_cont=
ext *smu,

         switch (mp1_state) {
         case PP_MP1_STATE_UNLOAD:
-               ret =3D smu_cmn_send_smc_msg_with_param(smu,
-                                                                          =
               SMU_MSG_PrepareMp1ForUnload,
-                                                                          =
               0x55, NULL);
-
-               if (!ret && smu->smu_baco.state =3D=3D SMU_BACO_STATE_EXIT)
-                       ret =3D smu_v13_0_disable_pmfw_state(smu);
-
+               ret =3D smu_cmn_set_mp1_state(smu, mp1_state);
                 break;
         default:
                 /* Ignore others */
--
2.34.1


--_000_BL1PR12MB5144CE12BC49681460E25742F7702BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Acked-by: Alex Deuch=
er &lt;alexander.deucher@amd.com&gt;</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Friday, January 19, 2024 4:16 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Limonciello, Mario &=
lt;Mario.Limonciello@amd.com&gt;; stable@vger.kernel.org &lt;stable@vger.ke=
rnel.org&gt;<br>
<b>Subject:</b> [PATCH] Revert &quot;drm/amd/pm: fix the high voltage and t=
emperature issue&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This reverts commit 5f38ac54e60562323ea4abb1bfb37d=
043ee23357.<br>
This causes issues with rebooting and the 7800XT.<br>
<br>
Cc: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
Cc: stable@vger.kernel.org<br>
Fixes: 5f38ac54e605 (&quot;drm/amd/pm: fix the high voltage and temperature=
 issue&quot;)<br>
Closes: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/3062">ht=
tps://gitlab.freedesktop.org/drm/amd/-/issues/3062</a><br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp; | 24 +++=
+----------<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; | 3=
3 ++-----------------<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |&nbsp; 1 -<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c&nbsp; |&nbsp; 8 +----<br=
>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c&nbsp; |&nbsp; 8 +----<br=
>
&nbsp;5 files changed, 11 insertions(+), 63 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index b4c19e3d0bf1..56d9dfa61290 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -4131,23 +4131,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_i=
p_version(adev, MP1_HWIP, 0)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(=
13, 0, 0):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(=
13, 0, 7):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(=
13, 0, 10):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D psp_gpu_reset(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D amdgpu_reset_method;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* It should do a default reset when loadin=
g or reloading the driver,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * regardless of the module parameter =
reset_method.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method =3D AMD_RESET_METHOD_NO=
NE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_asic_reset(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method =3D tmp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D amdgpu_r=
eset_method;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* It should do =
a default reset when loading or reloading the driver,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * regardle=
ss of the module parameter reset_method.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_met=
hod =3D AMD_RESET_METHOD_NONE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_asi=
c_reset(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_met=
hod =3D tmp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;asic=
 reset on init failed\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index c16703868e5c..961cd2aaf137 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -733,7 +733,7 @@ static int smu_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;adev =3D adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;pm_enabled =3D !!a=
mdgpu_dpm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;is_apu =3D false;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_baco.state =3D SMU_BACO_S=
TATE_NONE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_baco.state =3D SMU_BACO_S=
TATE_EXIT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_baco.platform_=
support =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;user_dpm_profile.f=
an_mode =3D -1;<br>
&nbsp;<br>
@@ -1961,31 +1961,10 @@ static int smu_smc_hw_cleanup(struct smu_context *s=
mu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu_reset_mp1_state(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((!adev-&gt;in_runpm) &amp;&amp; (=
!adev-&gt;in_suspend) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (!amdgpu_in_reset(adev)))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(13, 0, 0):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(13, 0, 7):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(13, 0, 10):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_=
mp1_state(smu, PP_MP1_STATE_UNLOAD);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
&nbsp;static int smu_hw_fini(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D adev-&gt;powerplay.pp_handle;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
&amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -2003,15 +1982,7 @@ static int smu_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm_enabled =
=3D false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_smc_hw_cleanup(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_reset_mp1_state(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_smc_hw_cleanup(smu);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void smu_late_fini(void *handle)<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h<br>
index 2aa4fea87314..66e84defd0b6 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
@@ -424,7 +424,6 @@ enum smu_reset_mode {<br>
&nbsp;enum smu_baco_state {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_BACO_STATE_ENTER =3D 0=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_BACO_STATE_EXIT,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_BACO_STATE_NONE,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct smu_baco_context {<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
index 231122622a9c..bc8bd67c48ac 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
@@ -2748,13 +2748,7 @@ static int smu_v13_0_0_set_mp1_state(struct smu_cont=
ext *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (mp1_state) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_MP1_STATE_UNLOAD:<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; SMU_MSG_PrepareMp1ForUnload,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x55, NULL);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ret &amp;&amp; smu-&gt;smu_baco.state =3D=3D SMU_BACO_STATE=
_EXIT)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_=
0_disable_pmfw_state(smu);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_set_mp1_state(smu, mp1_state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Ignore others */<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index 59606a19e3d2..0906221231ea 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -2504,13 +2504,7 @@ static int smu_v13_0_7_set_mp1_state(struct smu_cont=
ext *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (mp1_state) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_MP1_STATE_UNLOAD:<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; SMU_MSG_PrepareMp1ForUnload,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x55, NULL);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ret &amp;&amp; smu-&gt;smu_baco.state =3D=3D SMU_BACO_STATE=
_EXIT)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_=
0_disable_pmfw_state(smu);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_set_mp1_state(smu, mp1_state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Ignore others */<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144CE12BC49681460E25742F7702BL1PR12MB5144namp_--
