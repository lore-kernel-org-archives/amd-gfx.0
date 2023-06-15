Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ED1EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 09:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A30D610E4B0;
	Thu, 15 Jun 2023 09:38:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C54B10E4B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 09:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iv4Ez5VND71JxppUq7ZkvuZFjdsKbipu8T0vVwYhrzng29qrOxDO2kSmsr6X4gVc0IDfMiFkOYXTXDjuG4l4WiYxoiA+MyzkaZqHp09LkA0a0dOPE2doKhaVB9s9L5bh7OTmQmJnBw/BcHg0tK7tRrTqRBchVUQJGHJ88nOkgwkf/Kgvxa7coj59T/gg2WSEzrrSuROXjISSlESggohzrP47CxOO6aMEynzraTeJ0m0HTK9UfxdEnx/JUCxwZUVSVeEaReaV8zYXBA5KuFlM13TTtU9V06jSq+SFNYzN4YuQXCNzCSHuDbsnX/UPE5dRBhjRw+m0nqE7k0LyzIiTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMJZ/jCPfFW1eRsGRD2ND0Bz3v/MAJ6jQ+dwGB+5rZs=;
 b=ZHtoGTmjIV0zohkFucPhPkoWyI5POLoSXl7/pzcEYhoGfCPSCUcZroThGrW80PJmsmkF1GC7oZN9/iqDuA2AYomCJfnjLps4zMv+njMxieZ04njk+nMhh4zLXy9cWeR0VeeffzexVYI4ZOeIw4c5zc1Gaxfe8GSvjDkgt9AMSDPu8p3NCYgp7w5QQgTUh1RstyuSYLOU6As7U8TFJQA1qOVfFYbdpOYO/xgf9BIa699lByZmGnh0JkByNQX5Fghe+qCpd+9gPnjfF1+qnn3HLjs9Cp2df1ejhWRi0dj+2durC/r73Z7B033jZpDJOs8PcyB4KXzqKMRE78bh8+Krqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMJZ/jCPfFW1eRsGRD2ND0Bz3v/MAJ6jQ+dwGB+5rZs=;
 b=yV88COfh6yXAwmuuxkPLPvL0KDuijwGse/4VwVzwA0ELMW8+Vs+YBAEDJOUHkaqeAjk7vCHTlIa+5HGDGU7K9JiFNHsOJcbpyenAWrfwKbzOEYZfrbhrw9ctM4RuZxaI5aRTFT5g9loOc3XLmfJgr6EBvj7OAgoXT1qCzeHXXvY=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by BY5PR12MB4853.namprd12.prod.outlook.com (2603:10b6:a03:1da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 09:37:59 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::ed91:e0f1:49d2:1af1]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::ed91:e0f1:49d2:1af1%4]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 09:37:59 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add vbios attribute only if supported
Thread-Topic: [PATCH] drm/amdgpu: Add vbios attribute only if supported
Thread-Index: AQHZn2dZ9vbbZr5q0kS84Yth6OKQJ6+Lmwqg
Date: Thu, 15 Jun 2023 09:37:58 +0000
Message-ID: <PH0PR12MB5404BFCB302098F9AB9517C2F65BA@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20230615085610.1619133-1-lijo.lazar@amd.com>
In-Reply-To: <20230615085610.1619133-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=958c34f8-a4b4-4938-9429-2f20816b0665;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-15T09:36:56Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|BY5PR12MB4853:EE_
x-ms-office365-filtering-correlation-id: 92eef025-27c1-42d6-b775-08db6d8434a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 31sxwij4G2J/0wSTDQpoyP+uYAiiAJ6lzG6KWbrUCbahhZH3w8U66/KZKwQkj5W0UIjr9GGQOalaNjKFsAHbhwvoTd4l7phTrRhMme6jD7nyiMUC3ykX9D46cFgevBksXld7HSwQ9Sy0VVs4Tuu4STZHnq9mYBPSlJ97NvblMGbdiGXonLtGBijlkQ52CZimkPcnDmFUcamofXmdTarGm0Snrdm7+5PBuGbh+iEgXaiQIhQ9+B9275yna+8kkpnopy3gTzOM1QSwYApipIIuJmsHAmlcTuu7KxA8AdknsYT8HbUQ6qDx+yP7R94FALKun4dv7Q5ldsBi3rT7nAqWgaY8e3J/q5JE7R4VujzkmodakFaulZ5klfJJ9gLTtgoWg+a52gp7nytCLLati12EJko8inJt3YSyswtcZyA+w8WXrYWtrPIyv3u++CMJ+XYq37VEP4xx1vqhZ+R/ne/DWpNBghjO0UrQlxZz8q3cI5AgkLVdZMI5mrXQJoaeW0TaOOfpvY6LP1cN4VMn8LQ3IMCLFTIhT0Ar0V+QVnlECu8AOSe6FeOvgvzszlLvTB83yzowlU88yQp2I1d2TJAa2GKJgR5ofn+lJ9tXJ+oO+ccTFkFuSvBowfM2fF1mGgcC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(2906002)(9686003)(186003)(83380400001)(55016003)(66946007)(76116006)(66476007)(64756008)(66446008)(66556008)(71200400001)(4326008)(41300700001)(7696005)(8936002)(8676002)(316002)(110136005)(54906003)(86362001)(33656002)(38100700002)(478600001)(122000001)(38070700005)(53546011)(6506007)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gvL1hnYYjsgO8Xtmqe0VD9ESbn+sC0Vkvs5du7bUjsdbL6XUlJavGiAOCO8a?=
 =?us-ascii?Q?TSnmMO+aW9RPcf9y40d+iANqDMK2L+DWg4CS7/y2LagsDyclEMpuJDYIVkl8?=
 =?us-ascii?Q?hhAr6x3iHESr5fr/cM1QcWrNmtufc4qeCKF3PsAo5vFRJQ2MxgkktBoUgBGZ?=
 =?us-ascii?Q?ByJ0QQlVRd+PdefalpZrSJfWX6WfI2XrRUSqHF98bZowFThwVg1nVg/j2cd5?=
 =?us-ascii?Q?SL+HDciL+lQ4UoWsu+MYkDbjgYvX2r8lsZtEtECJYWDLs7xf4MLUG0hYi669?=
 =?us-ascii?Q?HSAAf6LcLCDAdWmIY30zphICc91+fh6xda35zL5kQ7thRca4bONdQGFIdGI3?=
 =?us-ascii?Q?DkmG17CFk+lHNVczK8SZKuokVsuEMbGWQTuzwRZyS85DSXScxBjxUYtTEg5Z?=
 =?us-ascii?Q?UWmJlGmi4Cd4Ei8nzRHOEz5kn7pxsmguDIVpiCgNbXZPli3fGLSozooul2xU?=
 =?us-ascii?Q?Euz+5lOqueDEH3X1YrdhV6KgUjEBEitDfsVaJMTurtEa9QoHZBNStUPECGjc?=
 =?us-ascii?Q?X6ZnWglrXd2oIu02lxY7XV47KnWeaWYRw52sqP1seinD+Ms4tzSvbY8mJuQX?=
 =?us-ascii?Q?iZt0ktcAC7wysOFLbFeCxnlffX3w7vQXu6bPPviylPh8zHp9827q3a+B+5Ns?=
 =?us-ascii?Q?nXdslHw5GteIXbSiCWJim5XV3A3iMH1urDKaORVGWLJnvVGPuXqG/nf0RUmI?=
 =?us-ascii?Q?XzdRl3GRqlKh7KO8CHTrNCpkec77qbQwSNOpnYqiOkz/mVP+EaupaN3vsAft?=
 =?us-ascii?Q?X8l5oXz32CGxhG1MhYxS81P22Pg1jS9j+ztfrXk4MUm4c81HmUjqpVFPUVXd?=
 =?us-ascii?Q?IQ32ak/0twefWQupKKETKojttBpjt5FoFyPr2kJH14g8/KyvfV0ISlf0ZNzm?=
 =?us-ascii?Q?vrKRLXz4g1thj5HnnLPF0BunZ088wcrXE/+GsFCkVOjdugojp7hmz0OKeUND?=
 =?us-ascii?Q?E5I9k3Etj8C3yzulvgcIEqsbh6LHRlsBinIZkFT2GwBqhxbM6/kGiSqPOHcr?=
 =?us-ascii?Q?oai0xIiWU4WXXCDdqhCAxMK9020MS5IJfbDBqOqO9v7HYTsiW4ptGvQ/Sm/h?=
 =?us-ascii?Q?RUhH9mulrco++qiaDJzaMbTnaUJikvWaFsfAXihKEC544g51yFwU/QjUbK2x?=
 =?us-ascii?Q?pldVpEjCHu55j7rG0eOFagbE5LuZjxlsl42PzZmpujhP4f2lYlpaGhGI7WBS?=
 =?us-ascii?Q?x0kIfUhc/PIvMd4x6txhGhM1RurdLXZl3jXzmu1UYsc+KQMs3vledCWh7MP9?=
 =?us-ascii?Q?laCJdIo0ReQ9JdXMLQ8nBCPxBvR6ReluJcGh1Hugxwz1mPoDi459cuE7eQkb?=
 =?us-ascii?Q?RPbaoMzy8/lYNyMphxZitvmVXyhCHD+lfM0fuOBDayxbMjuomewTfDnPEVDY?=
 =?us-ascii?Q?N4Jf89ySoOJn2nshxfghh415aTR/y2pNDSzvFxce2uFSI0iusIaOxWL4q903?=
 =?us-ascii?Q?L1cB3Q9l9Atv5gknwkvPLlHEssOFurZzcCJU7hwvJd/m7Wcn2PlxTWnRUZfI?=
 =?us-ascii?Q?SiovsYbpi4t03SdNe4l5EyGNlAlyG5cOTILsodOeGIV3xYrzbunhXzZniw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92eef025-27c1-42d6-b775-08db6d8434a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 09:37:58.8521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjK+omP+ai8m/WjQSqw+fjEzFUeNpAPCGr3A2CrQST/H0oyWCS+qgJsWtzYD1WpQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4853
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo
> Lazar
> Sent: Thursday, June 15, 2023 4:56 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le
> <Le.Ma@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Add vbios attribute only if supported
>
> Not all devices carry VBIOS version information. Add the device attribute=
 only if
> supported.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 9 +++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      | 2 --
>  4 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index 9ba4817a9148..f4e3c133a16c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1791,6 +1791,15 @@ const struct attribute_group
> amdgpu_vbios_version_attr_group =3D {
>       .attrs =3D amdgpu_vbios_version_attrs
>  };
>
> +int amdgpu_atombios_sysfs_init(struct amdgpu_device *adev) {
> +     if (adev->mode_info.atom_context)
> +             return devm_device_add_group(adev->dev,
> +
> &amdgpu_vbios_version_attr_group);
> +
> +     return 0;
> +}
> +
>  /**
>   * amdgpu_atombios_fini - free the driver info and callbacks for atombio=
s
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> index 4153d520e2a3..b639a80ee3fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> @@ -217,5 +217,6 @@ int amdgpu_atombios_get_data_table(struct
> amdgpu_device *adev,
>
>  void amdgpu_atombios_fini(struct amdgpu_device *adev);  int
> amdgpu_atombios_init(struct amdgpu_device *adev);
> +int amdgpu_atombios_sysfs_init(struct amdgpu_device *adev);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e25f085ee886..eda0a598722e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4018,6 +4018,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>       /* Get a log2 for easy divisions. */
>       adev->mm_stats.log2_max_MBps =3D ilog2(max(1u, max_MBps));
>
> +     r =3D amdgpu_atombios_sysfs_init(adev);
> +     if (r)
> +             drm_err(&adev->ddev,
> +                     "registering atombios sysfs failed (%d).\n", r);
> +
>       r =3D amdgpu_pm_sysfs_init(adev);
>       if (r)
>               DRM_ERROR("registering pm sysfs failed (%d).\n", r); diff -=
-git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 999d008b6b48..70455b00c36e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2896,12 +2896,10 @@ static struct pci_error_handlers
> amdgpu_pci_err_handler =3D {
>
>  extern const struct attribute_group amdgpu_vram_mgr_attr_group;  extern
> const struct attribute_group amdgpu_gtt_mgr_attr_group; -extern const str=
uct
> attribute_group amdgpu_vbios_version_attr_group;
>
>  static const struct attribute_group *amdgpu_sysfs_groups[] =3D {
>       &amdgpu_vram_mgr_attr_group,
>       &amdgpu_gtt_mgr_attr_group,
> -     &amdgpu_vbios_version_attr_group,
>       NULL,
>  };
>
> --
> 2.25.1

