Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB536C54E60
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 19:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B9CD10EA6C;
	Thu, 14 Mar 2024 19:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aRLR3qxM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC31610F132
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 19:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+mOSePvzAsw8RuP6DWMHk2q/Xr8qpdIHD2vP3oMw2pq3Z0cvzbaytF+ysmUV3uqXfWWmOFypHJb1V0MPmEvkdCrRdtTljheQTAxQTL4zh53etvzogJeRxN/fUTPJ8LnfgbgDcnQg24B1euyCRp2ieeaDPJf3xtVgCku3L2pl0k1g0cILdvVM9I+iFzmfHZPf5GQzRuJSrc2qT3asTBIG/8cJXPR1B8vJHVGbLD4xsyVbD8lFm9EN7B/GiOKnJWOGs84+moRs+LoFzHlv6RetQzT78eo+TOltToDKPC1elEl/vpDL2siZR1m1Nb3XPAtqW2tJVvkruBY8VEhM/uYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AR76C/7lgZFcc38tQbWt0fo7XUZbK7/uJ0AE0RA3tiM=;
 b=gHu1pSxLK5Rz+lsmA4YU7QMLah9HSiOV1eKjpO+isn0OV/V+2ONIi7LmeJfkm7WqG9TKDaPeBMmgnzmH+PnS+75rvEdPnGhBzFmCf93I9QJevZTbmDzuoo7F7WZ09UitZiDlakRm7Wc0X6ALkisFE9bu8F6Ws5yNpOE0KlF8ZhHOVT5PZUa/uqEoTSZ1ApxWTuPbJCJr+zZtWgFp8nJb6r2o9mzlA47GSKt08jozbkkIPwx+vqGyAKSg97DfKttIdNMx48Ghi6Vjua0hP1lM3utu+H68tmBfTzBfdng0NbhlOqf9SRTdmkTDV4VWqeQex+wJngxZkA0P/GDmdPbd8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR76C/7lgZFcc38tQbWt0fo7XUZbK7/uJ0AE0RA3tiM=;
 b=aRLR3qxMpAf2701l2x7JQZJohHThmlziTxqtzpMRRNeDSgo9MlNbKtIY9o188QDk3IceDrsfA0xQCfBCm6ARO0cjfTne84bP/l3yS/BMDt6+QrS8fvFYTThfaQyhpNv9rtWBk23cXMfyM6X2rN+0HVV5OHH377tsx3i5cRmdb1s=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.20; Thu, 14 Mar 2024 19:49:54 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 19:49:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Liu, Shuzhou (Bill)"
 <Shuzhou.Liu@amd.com>
Subject: RE: [PATCH v2 1/9] drm/amd/pm: Add support for DPM policies
Thread-Topic: [PATCH v2 1/9] drm/amd/pm: Add support for DPM policies
Thread-Index: AQHadgbEOHPbTQXhaUWBiKZ5+hYmvLE3pONg
Date: Thu, 14 Mar 2024 19:49:53 +0000
Message-ID: <BL1PR12MB5144BD65618E6BBC807C5262F7292@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240314115630.682937-1-lijo.lazar@amd.com>
 <20240314115630.682937-2-lijo.lazar@amd.com>
In-Reply-To: <20240314115630.682937-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7fd9ef94-afbf-4b7d-9b7f-181ccf2e92d8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-14T19:47:44Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB6096:EE_
x-ms-office365-filtering-correlation-id: a9c53f58-2b73-4251-dcdc-08dc445feb47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HW6jnSCTZW+SiUOCrnw0m9kiyOSk3wpY3Jk4S+p9sPlajVlELOnuu4wTZc5dEc2hf52xUne8kzTz4t4s8h5ikUkbb11cQNgXPOEfZ/Pb41ArHAPyWOxvQCTMR7rWJZr27u4V3HhigqWtF/71UnWKENvKK/+y6E/tZ7cVGhg9iPBaY1Bj9Sn31cI9icfPV+9gpC/dLf1Yo5UqBGjNLegv35uXSTPGtib7olZLbIDBkr4JN6uorS3qheWt+7gqj2K5LF1N8aVDbBF/HXWfVB6xGwQzzuTVLT2eV61zBCunf/e1rR8yA6QXP8IBd/2Ma7cee+dwfE3s1zvPeyADkKKcOZcnwKEP9SuWG2188j5C67iCbZO9SOW2RCIeFa0i8ypbVxSSN0EXvjMz6mUC/HK9rhOMjUlnNsdb9AE9LfDwBd5W9EVhk4QVdXCyPye+5hqXRQH17S+4yX0Q5QC1srP7ZWQZB/C06ZQgXD9lZcPQH7pggSLWNKuRQLqueOr/DoJMeRAyWEpyNv/aqCuYS1xN896r+9XMg6+xwNYWVATJgv38O87+Qe3bdiM6yTV4IfxmzbV79CaSVFAtcPguBI4NTUgDuqtvVj6Gng3imtEDbJZK1tE+N8h3fDJ3N8EM0Ongmc8p4dAEtL6u0qT5W/0f2MhzbLMk7iWPVCQVvjGtJZswwNTHLXcg6KBA5WT12KjNM0IEcFHiw6aXjnyU4JWeGm277LleFSFelRLKOSUExWw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jrf9Rv2Vx6UgmPHQ0Gz91DDlfDiLaSmBmowa6zm1VoaucaHvDj1wIbc4WPhZ?=
 =?us-ascii?Q?mjD+fWudQLtoAwUZnKL9jUUhf8yuaIgNuDchTK0/3T4DUdz9J1lpml7Q1HJk?=
 =?us-ascii?Q?n3JaqDbU+8xXNwDNEiWqPKGyf5NHSHsELoqcSofmeipNK0hXl6mVgUCxeDie?=
 =?us-ascii?Q?panobabT++tmyN9dnsaK8CfGQ/c0mZQDBITX1YGlF2tAA4qmdANpSzXw35/J?=
 =?us-ascii?Q?QE3UHqO7JVNAwdKAlJsrxI9gFLlAXxrLJLEEpLTZZ+C/WFiX6qCQwHcrYyah?=
 =?us-ascii?Q?wF1Psn1/WPGrov7OwxHMIvCdLvmQr6isDdskjE5bfysxPQN6+5aYSj6Yaikw?=
 =?us-ascii?Q?yRybY4Q3TwKjn/uVky4poiwJcNQfHUievnf/Ai07JLdXCLSU7qr93klu6lrk?=
 =?us-ascii?Q?3Qcss3HJ0jsek3GFinHPsssXeGUD1qH3yxDgMcPSl/h+ncnfPPnO8AHYLjtK?=
 =?us-ascii?Q?L9DIDHtmjr1HmQLyrv7Ohf6DQ8OA2S1W+LMBcIrGWadufsyFh8Z2aUkAp6VB?=
 =?us-ascii?Q?lMqy2AKf5bnu8cmYkfNTA5gCp5GA0RzZoF3kwxqP2mrOfAT4DL6Y3TX2sirn?=
 =?us-ascii?Q?CEaGymVclyYUfuKWsiCyC9iZLXpECu9xL6StAaCC0knVl2V/ToHKVCtx/lre?=
 =?us-ascii?Q?gLJZ6A+5H/+ZE5TW72Az4eW+RY51jZmFf1nlu7RYDiCIjWlfZPt0W2kXN0Ty?=
 =?us-ascii?Q?rbxcLTudRpcZlsX/tayELLxb3NvZrHKE5g/tE09FNKcDtJ+wp9TRxJMK+unQ?=
 =?us-ascii?Q?ONz2h3LhD1NcfZUw4fl9hdF2ZWw6pS0cplh6Hpg5FE/3cjows8wSBsuL0znN?=
 =?us-ascii?Q?K6VjCZUubW54ECZnLA79TYRTRn39qrviDfifxooG9I0dFzMiWsdvl34ixBtP?=
 =?us-ascii?Q?nnW172zQVuI2V11U0JXiqBPLgS8+6g9ajQdtbrJLKzy2xdaAjri/vSarID1f?=
 =?us-ascii?Q?q0Yx9NOH438dA15tqBVB64RilmFyUrHQR78U+gHjop5mDpRhlf9LAvgxBbWI?=
 =?us-ascii?Q?QMEtVEkKTYV6OrZTb3rIV+ozvuMex5ILaan+C9VlS6bG9iG8kHqE08/IYtJH?=
 =?us-ascii?Q?9tIa+fZlZUXeGKsm6QBHO1UiOAlXYef6wJBk4+KUgZGbh7lh8fh/5n3KwQW6?=
 =?us-ascii?Q?IccCu5wPShYGv6Ly2Shw+sNq8EJ4PdBtlGazZJQLqofMai1kDg5zCy5c6mme?=
 =?us-ascii?Q?KZRzvmmrsuRfwkx0MWYvYlfxn5mYyL0lmE6iV2aR0irxcruL7EiTuuQpOpcy?=
 =?us-ascii?Q?cc0niRpw3SEILhnn+SYb56a+rULbrCth/4z2UvO0Hh9R7qvoCv9TWo6WoJYM?=
 =?us-ascii?Q?FUHQD7tXINLJ8dAjPvSlI+rvApaIOHNT4f9YIZoEsvfEEB5SWk45Ma2LDT5m?=
 =?us-ascii?Q?n8q+VltCjfRJ5qXCuRKraTuB6y1Gh5qR5abfShmNKkko8Com4H7SLo14SGq1?=
 =?us-ascii?Q?F4QPWmShC1U9VUPzl4tYaVB6LhGQ0BuqBTdgoH3dZYmbT4AVoE0QD+YOf3oo?=
 =?us-ascii?Q?rqRlzb9SZXxjd9XIM97Zw1VzC9ipg8YJdSi+Nmm53QJigHi95NbJ+uWB8+47?=
 =?us-ascii?Q?2gu2DUGRR8+P9uJdWSg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c53f58-2b73-4251-dcdc-08dc445feb47
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 19:49:53.9393 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mpt3rxWOk3TgN7+USJR2r3B6+oNSFCp83XBvfEDir47wBfsp8lwFFGKO0yttNTB7OuUHesP8zRzCC2QEnDA5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
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

[Public]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, March 14, 2024 7:56 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Liu, Shuzhou (Bill)
> <Shuzhou.Liu@amd.com>
> Subject: [PATCH v2 1/9] drm/amd/pm: Add support for DPM policies
>
> Add support to set/get information about different DPM policies. The supp=
ort
> is only available on SOCs which use swsmu architecture.
>
> A DPM policy type may be defined with different levels. For example, a po=
licy
> may be defined to select Pstate preference and then later a pstate prefer=
ence
> may be chosen.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
> v2: Add NULL checks before accessing smu_dpm_policy_ctxt
>
>  .../gpu/drm/amd/include/kgd_pp_interface.h    | 16 ++++
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 29 ++++++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 92 ++++++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 95
> +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 29 ++++++
>  6 files changed, 265 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index afb930b70615..84dd819ccc06 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -273,6 +273,22 @@ enum pp_xgmi_plpd_mode {
>       XGMI_PLPD_COUNT,
>  };
>
> +enum pp_pm_policy {
> +     PP_PM_POLICY_NONE =3D -1,
> +     PP_PM_POLICY_SOC_PSTATE =3D 0,
> +     PP_PM_POLICY_NUM,
> +};
> +
> +enum pp_policy_soc_pstate {
> +     SOC_PSTATE_DEFAULT =3D 0,
> +     SOC_PSTATE_0,
> +     SOC_PSTATE_1,
> +     SOC_PSTATE_2,
> +     SOC_PSTAT_COUNT,
> +};
> +
> +#define PP_POLICY_MAX_LEVELS 5
> +
>  #define PP_GROUP_MASK        0xF0000000
>  #define PP_GROUP_SHIFT       28
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index f84bfed50681..db3addd07120 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -411,6 +411,35 @@ int amdgpu_dpm_set_xgmi_plpd_mode(struct
> amdgpu_device *adev, int mode)
>       return ret;
>  }
>
> +ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char
> +*buf) {
> +     struct smu_context *smu =3D adev->powerplay.pp_handle;
> +     int ret =3D -EOPNOTSUPP;
> +
> +     if (is_support_sw_smu(adev)) {
> +             mutex_lock(&adev->pm.mutex);
> +             ret =3D smu_get_pm_policy_info(smu, buf);
> +             mutex_unlock(&adev->pm.mutex);
> +     }
> +
> +     return ret;
> +}
> +
> +int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int
> policy_type,
> +                          int policy_level)
> +{
> +     struct smu_context *smu =3D adev->powerplay.pp_handle;
> +     int ret =3D -EOPNOTSUPP;
> +
> +     if (is_support_sw_smu(adev)) {
> +             mutex_lock(&adev->pm.mutex);
> +             ret =3D smu_set_pm_policy(smu, policy_type, policy_level);
> +             mutex_unlock(&adev->pm.mutex);
> +     }
> +
> +     return ret;
> +}
> +
>  int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)  {
>       void *pp_handle =3D adev->powerplay.pp_handle; diff --git
> a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index efc631bddf4a..7ee11c2e3c61 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2179,6 +2179,96 @@ static ssize_t
> amdgpu_set_xgmi_plpd_policy(struct device *dev,
>       return count;
>  }
>
> +static ssize_t amdgpu_get_pm_policy(struct device *dev,
> +                                 struct device_attribute *attr, char *bu=
f) {
> +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> +     struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +     if (amdgpu_in_reset(adev))
> +             return -EPERM;
> +     if (adev->in_suspend && !adev->in_runpm)
> +             return -EPERM;
> +
> +     return amdgpu_dpm_get_pm_policy_info(adev, buf); }
> +
> +static ssize_t amdgpu_set_pm_policy(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 const char *buf, size_t count)
> +{
> +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> +     struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +     int policy_type, ret, num_params =3D 0;
> +     char delimiter[] =3D " \n\t";
> +     char tmp_buf[128];
> +     char *tmp, *param;
> +     long val;
> +
> +     if (amdgpu_in_reset(adev))
> +             return -EPERM;
> +     if (adev->in_suspend && !adev->in_runpm)
> +             return -EPERM;
> +
> +     count =3D min(count, sizeof(tmp_buf));
> +     memcpy(tmp_buf, buf, count);
> +     tmp_buf[count - 1] =3D '\0';
> +     tmp =3D tmp_buf;
> +
> +     tmp =3D skip_spaces(tmp);
> +     if (strncmp(tmp, "soc_pstate", strlen("soc_pstate")) =3D=3D 0) {
> +             policy_type =3D PP_PM_POLICY_SOC_PSTATE;
> +             tmp +=3D strlen("soc_pstate");
> +     } else {
> +             return -EINVAL;
> +     }
> +
> +     tmp =3D skip_spaces(tmp);
> +     while ((param =3D strsep(&tmp, delimiter))) {
> +             if (!strlen(param)) {
> +                     tmp =3D skip_spaces(tmp);
> +                     continue;
> +             }
> +             ret =3D kstrtol(param, 0, &val);
> +             if (ret)
> +                     return -EINVAL;
> +             num_params++;
> +             if (num_params > 1)
> +                     return -EINVAL;
> +     }
> +
> +     if (num_params !=3D 1)
> +             return -EINVAL;
> +
> +     ret =3D pm_runtime_get_sync(ddev->dev);
> +     if (ret < 0) {
> +             pm_runtime_put_autosuspend(ddev->dev);
> +             return ret;
> +     }
> +
> +     ret =3D amdgpu_dpm_set_pm_policy(adev, policy_type, val);
> +
> +     pm_runtime_mark_last_busy(ddev->dev);
> +     pm_runtime_put_autosuspend(ddev->dev);
> +
> +     if (ret)
> +             return ret;
> +
> +     return count;
> +}
> +
> +static int amdgpu_pm_policy_attr_update(struct amdgpu_device *adev,
> +                                      struct amdgpu_device_attr *attr,
> +                                      uint32_t mask,
> +                                      enum amdgpu_device_attr_states
> *states) {
> +     if (amdgpu_dpm_get_pm_policy_info(adev, NULL) =3D=3D -EOPNOTSUPP)
> +             *states =3D ATTR_STATE_UNSUPPORTED;
> +
> +     return 0;
> +}
> +

Please add kernel doc for this new interface and update thermal.rst to refe=
rence the new kernel doc.

Alex

> +
>  static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {
>       AMDGPU_DEVICE_ATTR_RW(power_dpm_state,
>               ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,
>       ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> @@ -2218,6 +2308,8 @@ static struct amdgpu_device_attr
> amdgpu_device_attrs[] =3D {
>       AMDGPU_DEVICE_ATTR_RW(smartshift_bias,
>       ATTR_FLAG_BASIC,
>                             .attr_update =3D ss_bias_attr_update),
>       AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,
>               ATTR_FLAG_BASIC),
> +     AMDGPU_DEVICE_ATTR_RW(pm_policy,
>       ATTR_FLAG_BASIC,
> +                           .attr_update =3D amdgpu_pm_policy_attr_update=
),
>       AMDGPU_DEVICE_ATTR_RO(pm_metrics,
>       ATTR_FLAG_BASIC,
>                             .attr_update =3D amdgpu_pm_metrics_attr_updat=
e),
> }; diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 621200e0823f..a98d1bda4430 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -594,4 +594,8 @@ enum pp_smu_status
> amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
>                                                 unsigned int *num_states)=
;
>  int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
>                                  struct dpm_clocks *clock_table);
> +int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int
> policy_type,
> +                          int policy_level);
> +ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char
> +*buf);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 246b211b1e85..1c23e0985377 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3465,6 +3465,101 @@ static int smu_get_prv_buffer_details(void
> *handle, void **addr, size_t *size)
>       return 0;
>  }
>
> +static void smu_print_dpm_policy(struct smu_dpm_policy *policy, char
> *sysbuf,
> +                              size_t *size)
> +{
> +     size_t offset =3D *size;
> +     int level;
> +
> +     offset +=3D sysfs_emit_at(sysbuf, offset, "%s \n", policy->desc->na=
me);
> +     for_each_set_bit(level, &policy->level_mask,
> PP_POLICY_MAX_LEVELS) {
> +             if (level =3D=3D policy->current_level)
> +                     offset +=3D sysfs_emit_at(
> +                             sysbuf, offset, "%d : %s*\n", level,
> +                             policy->desc->get_desc(policy, level));
> +             else
> +                     offset +=3D sysfs_emit_at(
> +                             sysbuf, offset, "%d : %s\n", level,
> +                             policy->desc->get_desc(policy, level));
> +     }
> +
> +     *size =3D offset;
> +}
> +
> +ssize_t smu_get_pm_policy_info(struct smu_context *smu, char *sysbuf) {
> +     struct smu_dpm_context *dpm_ctxt =3D &(smu->smu_dpm);
> +     struct smu_dpm_policy_ctxt *policy_ctxt;
> +     struct smu_dpm_policy *dpm_policy;
> +     size_t offset =3D 0;
> +     int i;
> +
> +     policy_ctxt =3D dpm_ctxt->dpm_policies;
> +     if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
> !policy_ctxt ||
> +         !policy_ctxt->policy_mask)
> +             return -EOPNOTSUPP;
> +
> +     if (!sysbuf)
> +             return -EINVAL;
> +
> +     for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM)
> {
> +             dpm_policy =3D &policy_ctxt->policies[i];
> +             if (!dpm_policy->level_mask || !dpm_policy->desc)
> +                     continue;
> +             smu_print_dpm_policy(dpm_policy, sysbuf, &offset);
> +     }
> +
> +     return offset;
> +}
> +
> +struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
> +                                      enum pp_pm_policy p_type)
> +{
> +     struct smu_dpm_context *dpm_ctxt =3D &(smu->smu_dpm);
> +     struct smu_dpm_policy_ctxt *policy_ctxt;
> +     int i;
> +
> +     policy_ctxt =3D dpm_ctxt->dpm_policies;
> +     for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM)
> {
> +             if (policy_ctxt->policies[i].policy_type =3D=3D p_type)
> +                     return &policy_ctxt->policies[i];
> +     }
> +
> +     return NULL;
> +}
> +
> +int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy
> p_type,
> +                   int level)
> +{
> +     struct smu_dpm_context *dpm_ctxt =3D &(smu->smu_dpm);
> +     struct smu_dpm_policy *dpm_policy =3D NULL;
> +     struct smu_dpm_policy_ctxt *policy_ctxt;
> +     int ret =3D -EOPNOTSUPP;
> +
> +     policy_ctxt =3D dpm_ctxt->dpm_policies;
> +     if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
> !policy_ctxt ||
> +         !policy_ctxt->policy_mask)
> +             return ret;
> +
> +     if (level < 0 || level >=3D PP_POLICY_MAX_LEVELS)
> +             return -EINVAL;
> +
> +     dpm_policy =3D smu_get_pm_policy(smu, p_type);
> +
> +     if (!dpm_policy || !dpm_policy->level_mask || !dpm_policy-
> >set_policy)
> +             return ret;
> +
> +     if (dpm_policy->current_level =3D=3D level)
> +             return 0;
> +
> +     ret =3D dpm_policy->set_policy(smu, level);
> +
> +     if (!ret)
> +             dpm_policy->current_level =3D level;
> +
> +     return ret;
> +}
> +
>  int smu_set_xgmi_plpd_mode(struct smu_context *smu,
>                          enum pp_xgmi_plpd_mode mode)
>  {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index a870bdd49a4e..39405e4ef590 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -362,6 +362,27 @@ struct smu_table_context {
>       void                            *gpu_metrics_table;
>  };
>
> +struct smu_context;
> +struct smu_dpm_policy;
> +
> +struct smu_dpm_policy_desc {
> +     const char *name;
> +     char *(*get_desc)(struct smu_dpm_policy *dpm_policy, int level); };
> +
> +struct smu_dpm_policy {
> +     struct smu_dpm_policy_desc *desc;
> +     enum pp_pm_policy policy_type;
> +     unsigned long level_mask;
> +     int current_level;
> +     int (*set_policy)(struct smu_context *ctxt, int level); };
> +
> +struct smu_dpm_policy_ctxt{
> +     struct smu_dpm_policy policies[PP_PM_POLICY_NUM];
> +     unsigned long policy_mask;
> +};
> +
>  struct smu_dpm_context {
>       uint32_t dpm_context_size;
>       void *dpm_context;
> @@ -372,6 +393,7 @@ struct smu_dpm_context {
>       struct smu_power_state *dpm_request_power_state;
>       struct smu_power_state *dpm_current_power_state;
>       struct mclock_latency_table *mclk_latency_table;
> +     struct smu_dpm_policy_ctxt *dpm_policies;
>  };
>
>  struct smu_power_gate {
> @@ -1547,6 +1569,9 @@ typedef struct {
>       uint32_t                MmHubPadding[8];
>  } WifiBandEntryTable_t;
>
> +struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
> +                                      enum pp_pm_policy p_type);
> +
>  #if !defined(SWSMU_CODE_LAYER_L2) &&
> !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
> int smu_get_power_limit(void *handle,
>                       uint32_t *limit,
> @@ -1594,5 +1619,9 @@ void amdgpu_smu_stb_debug_fs_init(struct
> amdgpu_device *adev);  int smu_send_hbm_bad_pages_num(struct
> smu_context *smu, uint32_t size);  int
> smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
> int smu_send_rma_reason(struct smu_context *smu);
> +int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy
> p_type,
> +                   int level);
> +ssize_t smu_get_pm_policy_info(struct smu_context *smu, char *sysbuf);
> +
>  #endif
>  #endif
> --
> 2.25.1

