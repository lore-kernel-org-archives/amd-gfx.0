Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C07CC4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 12:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51A110E6FE;
	Wed,  6 Dec 2023 12:50:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A79B10E720
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 12:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtXM/jDiBLBYqbShEYkVRMJmgDoqtGZUr6bnjgjq2GEDBZMhQslak/K72TNKg5XQenVQpGuKB98S8vVxXk0v3F9wO8ll7bTa+iu18eBrskasqyLpuS1GHYx9u9JpgFJ8RoT3iKXSoszdSgyfc2KQMfcIyyhelAebvHb5YlB7casCpJWsFft1fwfOF1QUF4y2Y8FF5wPWgraX6l+lPVH2qgu/fIrT3OPGtj6Cc251AgYcg4d670RamWOmzF0GjH4Mgpi1PEsoguFYRPua1zxu4JGpYDJ9hpXxnjvOjvCEFVC9UNGHNhPNaWsw344JDtdO1o9kgwyEWwwYdH34SUxhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJlwXgz4tNd0IBCH6UydpOtPtwfrj7WS2BBbev5v2XM=;
 b=CDbtD0BsbfaVqRIf++MI6sa96Kvaw79xPpeIbP3ywRvAE085CsZd+bTzbGchYyXCCru5g+dBBLUAWPngiclKL849atqM/6gYgHrzUp3+Sdukw2DemZ/RGQMTmn4W0iHcQ+hSePuqcFgg5HkphBfVojFgymgc+mIc3wCwH5QcAqh6aI2sY+PSYWF0f6boBRPAfyfSPm2xr2nd90mGHY3zgv+gzz83stP/s5BMbOGsF8+DctHE3rBKu4HVVpIGaVjJh0dUfveuSm68c+frzYacVdAVBOnpTzaiR5xTPpryW1bmXNzZZBvwMIemVUcEUEVepPtA88ln4optVwG1ySSexQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJlwXgz4tNd0IBCH6UydpOtPtwfrj7WS2BBbev5v2XM=;
 b=jk0FDCsjn8/yI5omEyOs3ZM2Y8GReM8u88FFCi3zYvHaRNObWkBRpYmCCESmNEZ3hsFSiWBXZfg9hU6NaZwRL4sglLHz77lwACZEjH2iUX0/G0TWwQDKjW3TuJf4RDzq0dX9iJitIu/d+eXd6wyohU4pGLF5ixhAgDfhgdE+qUA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 12:50:32 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 12:50:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use the right method to get IP version
Thread-Topic: [PATCH] drm/amdgpu: Use the right method to get IP version
Thread-Index: AQHaKEGGhJWIflHwDUKzK+6B0T0GubCcNQGQ
Date: Wed, 6 Dec 2023 12:50:31 +0000
Message-ID: <BN9PR12MB5257D74ABCC907572EA890F4FC84A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231206124107.1462461-1-lijo.lazar@amd.com>
In-Reply-To: <20231206124107.1462461-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=65a00f2b-fd00-4bb5-b239-04ba78b2d5fe;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-06T12:50:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA0PR12MB4431:EE_
x-ms-office365-filtering-correlation-id: 82a977bb-b8a5-49bc-937e-08dbf659eeab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LtqjGtEvlcxTFEpHGTzK8wPOShzHuGwIHD28k2aAMShWhzVyeAr3aMm8gKjHc3D4iIujk1ancS6REs2wdPuWcAEdCdC4GIzncREU1VitRMnm9a30H3lV/svQnJ2PDQiyDvL7Hg8BrMNDQ7lmsQnHSAkRGreePcDDAmZMGfSVeaaVN40KI9WYon1GhuN9EsSMlJBi+g2FZPu8Zctci6ioIaPZrBu4uK8xnzsaawWpTIBJUUC3eqTaislg5lXnfyd5JkTBxKmAq4/fsUoumOsrc1W8nfLubMEQpMIuQUXJWePCp+Z79BH8Q84mymHVHRONqYnZZ0Hk7433nHxA3p7rvw1Se6i+fpd/SdR7gnW5nWi0XnKz4QYFq/o5zP5UdjOR4DcrAGA+fRSgjYKllv8HhXioHjd1EQzaO3yAaZCuuEZFMgsaBnp3i8ZOzMG1xZgtA34TY9+0od0fvBhGBDoEjRd5yGjNSJp5Gtc1UdbrLKMWoq9HcfXCcCQ3eAdIyRObO0upKBSlRnyGBmnDyNw6elpoOGYggOww5kJXm1t8wvNglFktYhhyZtq3+9/7SeqtZGCjd4XDrvk/0YOHrJvuK0epC8gAErd8pMgAAnOzN7zML4eDbZBl4jMli+TiO5oX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(33656002)(2906002)(316002)(110136005)(66556008)(66446008)(64756008)(66476007)(38070700009)(66946007)(76116006)(4326008)(8676002)(55016003)(86362001)(52536014)(8936002)(41300700001)(5660300002)(122000001)(38100700002)(83380400001)(478600001)(26005)(71200400001)(7696005)(9686003)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HutRr8safTMRS3i/v2iEiSrPRxOY3S5YlxzsZVwjOMINUxkwdh46rWK78Zgu?=
 =?us-ascii?Q?4n7P+keb5cEVfAIRGjCvxjYOK0CjOJsMqXOlnBMWTt7O/8RtodgFHzpOB/wE?=
 =?us-ascii?Q?3iPVNr3uuG9xNXo1s+37BrIZ0GVV8HeORTatKskv0JsNKP5LRkZpjIALWQs7?=
 =?us-ascii?Q?ZsLQS91SNdqTjVLeTdUgE7X0oT6+lPLSKEI/jNRfxLJTfJYdiHamx/FO3hIt?=
 =?us-ascii?Q?M0+Mv6ArgWViW+IgkeEnhXx1yzaKNgIOrQX7MpqFdxfCpug9iMFraNBOxuX9?=
 =?us-ascii?Q?rhEBiDZvZ1RgF0Whzz4uX1AUctqx35NuCffnB3iX654oC5Zyr/A8l7OULzaN?=
 =?us-ascii?Q?HVS8EamObprma+EtVtx3fe5K65x/nnkN6gxGEsHJOcNKHek1clm4WQLHQc33?=
 =?us-ascii?Q?Y2+Q1uIBHLwofYEmTmYNPXOr+UptGkS0y0tcT9vYlkM4/6hx11P0mzX3kMYr?=
 =?us-ascii?Q?Be5rfJ5bS3Ukp+X78NBGilcU9lvjlEwFIELGdjGtM9TprBY4WM6ryvfoLoLu?=
 =?us-ascii?Q?xvBrM+hy89fIw/MY2gvwUd9DQAxmizOsd7GRAjAdgzxX1k03Mo5sWvnklQj5?=
 =?us-ascii?Q?NuhvAIHAxBEiSHc7tmpqrbTkD2wg6xY0WJ9NKHHcoIX3DiIBwnom6NAtm83w?=
 =?us-ascii?Q?N92tNNqdU1y3fDex1ydO7UMoiAs/8jh0dkw/pNy7dmk8tB5RDeWC01ITe//K?=
 =?us-ascii?Q?1l945xRQRylo7rKSTfH/dmzp1unlM1MXe+O6Cx6/QzHC8tO857Ucww4f2OII?=
 =?us-ascii?Q?ZIbmHaVKf/fyQmXRObkEyIH7qGyjflaQFa79pqslJG+oN4GleUHeOHECLTQM?=
 =?us-ascii?Q?ksmjmuzqNeF7Nowbvm8+cgw6OkYfJh29UPTqBL9PeZwcaeN502o3Iu1G9rrX?=
 =?us-ascii?Q?raTQe+QkjHj2dWO4/IlbFG+4sQ7mp+5Pf3Qlv1SLA02P26DqgbyFiGOfhY+U?=
 =?us-ascii?Q?rB6NLwOxdy/OzuiY/KPkyEPjLfJ8Qh3sEQTr90IgPsWRWbzkvjWnPgax5Huo?=
 =?us-ascii?Q?coUfcRw9oUEePqLAp08h0spkh11hQGbafdJ1cmq0FVslUvSxzZOENU0FRdhB?=
 =?us-ascii?Q?had/sz3pDFWKkB0m5OLL4x/ICYLAecKhMN7IBhVXsVOpdqx4C24aGYhxK4HM?=
 =?us-ascii?Q?es4h6qByXgb7bNrFqNsGmmTCZcCHnbZzZTrM9xyW6nP0QahHJ+UnxEzFRU4M?=
 =?us-ascii?Q?hNTHQ+7qGT0Zv+3zIfEV/bkjK4gwq2U+lQ+lrfB7V0gfgb0KhjTUEnId7CJ+?=
 =?us-ascii?Q?GoSC2OkFLqr864i0qORCzYBhqqENA8khFl5jxv6UH5MS1sfqt/SSdTbMufJT?=
 =?us-ascii?Q?Qo8ipTOpRFD7gOjL71hwL00dNsv6ravfZCn6iuIoZMgNPUONE35WoLnpYCqC?=
 =?us-ascii?Q?AQUHg/SJ54vO5I2LPKxhwIQyN+L/SBfAHm6zpJebOLfjy2F2EtQqptHfz/e+?=
 =?us-ascii?Q?nxe6pwwzX7n7a3n4MERAZW3VyDIrgQqwDkP0/2BOl/FR+8Y5qdpZbS1mtynt?=
 =?us-ascii?Q?n9UnuYc2X+QfP0fvZ69fIyESViPK5JR+2vOuVBhGVUOJ5P0O8I8b3v1Jrquc?=
 =?us-ascii?Q?5/R6bryftXOhIhlAjIWMFAeqq8o8c7l/CM3HaYwq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a977bb-b8a5-49bc-937e-08dbf659eeab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 12:50:31.9181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sa0BhAb8cn2EOI+fuRV5FH1jNWABJ+Z1coVrQOVZm0drJUFRSh+WxRi3QamN2Q/iDSBiSbk2Qt5AAzg7YsWSjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, December 6, 2023 20:41
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Use the right method to get IP version

Replace direct usage of adev->ip_versions with amdgpu_ip_version.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c          | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 6 +++---
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 1b73f519cfb8..f9e8341d9449 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1599,7 +1599,7 @@ bool amdgpu_device_seamless_boot_supported(struct amd=
gpu_device *adev)
        if (adev->mman.keep_stolen_vga_memory)
                return false;

-       return adev->ip_versions[DCE_HWIP][0] >=3D IP_VERSION(3, 0, 0);
+       return amdgpu_ip_version(adev, DCE_HWIP, 0) >=3D IP_VERSION(3, 0, 0=
);
 }

 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 3a632c3b1a2c..0dcff2889e25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1099,7 +1099,8 @@ bool amdgpu_sriov_xnack_support(struct amdgpu_device =
*adev)  {
        bool xnack_mode =3D true;

-       if (amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP][0] =3D=3D I=
P_VERSION(9, 4, 2))
+       if (amdgpu_sriov_vf(adev) &&
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2))
                xnack_mode =3D false;

        return xnack_mode;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 2ac5820e9c92..473a774294ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -883,7 +883,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
         * GRBM interface.
         */
        if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) &&
-           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
+           (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2)))
                RREG32_NO_KIQ(req);

        for (j =3D 0; j < adev->usec_timeout; j++) { diff --git a/drivers/g=
pu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdg=
pu_dm/amdgpu_dm.c
index c146dc9cba92..394142cf72bc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9860,7 +9860,8 @@ static bool should_reset_plane(struct drm_atomic_stat=
e *state,
         * TODO: Remove this hack for all asics once it proves that the
         * fast updates works fine on DCN3.2+.
         */
-       if (adev->ip_versions[DCE_HWIP][0] < IP_VERSION(3, 2, 0) && state->=
allow_modeset)
+       if (amdgpu_ip_version(adev, DCE_HWIP, 0) < IP_VERSION(3, 2, 0) &&
+           state->allow_modeset)
                return true;

        /* Exit early if we know that we're adding or removing the plane. *=
/ diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index d8f8ad0e7137..4894f7ee737b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -224,7 +224,7 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
        if (smu->is_apu)
                adev->pm.fw_version =3D smu_version;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
        case IP_VERSION(14, 0, 2):
                smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SMU_=
V14_0_2;
                break;
@@ -235,7 +235,7 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
                break;
        default:
                dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
-                       adev->ip_versions[MP1_HWIP][0]);
+                       amdgpu_ip_version(adev, MP1_HWIP, 0));
                smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_INV;
                break;
        }
@@ -733,7 +733,7 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, =
bool enable)
        int ret =3D 0;
        struct amdgpu_device *adev =3D smu->adev;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
        case IP_VERSION(14, 0, 2):
        case IP_VERSION(14, 0, 0):
                if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
--
2.25.1

