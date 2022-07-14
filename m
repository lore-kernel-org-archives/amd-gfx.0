Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3BFC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 09:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E35495F7B;
	Thu, 14 Jul 2022 09:37:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9074A3C9F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 09:37:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+cE9Gng11QJm4AZG+8uJalXEe8kaeQRar1vOTYeQFNOSUYSYY5jqVdokgLOgU4n2Q0cRGbIkME2/W9p0SPFvfTalpLa89bEpbD4madp06PG6/YJnRrUlicNfaC4P53gikVLQkOWPHZBpB3pL7QBzNc4gkJvJU5sJ/VKQQ6g69asAgIEOtgNAwAUlYpVLZ440J+Na7oIEn0uZa+oACUwBKW5xDhVgEssabKzggPj+If17zuC0c/8p5qOP5H2YMVfdCF/ffxtIxGEful0M7igDfnG5eTyn93BjjzUaVjQ6KowUxXO6ZQmxVxsjWUp5AzSzylU+Ibvc/NfqyJRXXnUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksQ8wukWux2dMA3X3fRIdaMJIWLRCsAWk5WNT68srCs=;
 b=FJ+FYI5+9cuz57hBON8XuLX7BtjGWC3Xb9dTP7mhUzC16r3azsThgU4XqDNCzOuA8IFSgO+40Ehcmt3E2SvUPLwLmy2NasSg3s4QEWCWY63fRaSediYjoh/5WjFc6QyjJix42CBHwIbaGXqaRq9gknwlzVoXHxcq02MXwOpT6W/f5tzYJe8A7et2OHS/gbJKjUoPF6Xmf1PqY0JjOiHtQkAQAI6mupXw4C1+9dxUdBAxW7LFUk5u6Te+jDEL+sgCnKU1cOQ2G5Fw0IJ6+E5AlLYW17SoNoOd5C9jxY8qRQLpQId+N+SUn3XA8TExAoIYFK0i9K39LSsobfYhSTYxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksQ8wukWux2dMA3X3fRIdaMJIWLRCsAWk5WNT68srCs=;
 b=InVSwPk1YdoTBkAKw1JCaik48gPSPIc2ZZjCfLYUr3wRQyuiXpDREnRJEcZEkNRwxwMjk6kT05tbDBUBaBzAjLxJllAa0nT+e5exWiP9BlE+p4QzODeNPHErlREBAjvrAIc+ogKL7ry70SkxGwbR8A32m84c4nvXYpw6XiIIU4A=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3180.namprd12.prod.outlook.com (2603:10b6:5:182::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Thu, 14 Jul 2022 09:37:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6%5]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 09:37:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: drop runpm from amdgpu_device structure
Thread-Topic: [PATCH 4/4] drm/amdgpu: drop runpm from amdgpu_device structure
Thread-Index: AQHYl13HdOX/kjdTWkWFTK8/3cUmPK19m9iA
Date: Thu, 14 Jul 2022 09:37:38 +0000
Message-ID: <DM6PR12MB26195B73A590EC1CF87A9E33E4889@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220714084305.3191-1-guchun.chen@amd.com>
In-Reply-To: <20220714084305.3191-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-14T09:37:36Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=284164e8-e019-4534-8194-e45742b6beba;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 602fbe43-ef7a-41ec-21e7-08da657c7dca
x-ms-traffictypediagnostic: DM6PR12MB3180:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: osg34hNOwzSGYRVoSchOBBlCfx0mV728jAU0n6XkpEOzA2ty1yTGe5X8S3lzX3fndyty9LmvNxmCb5IhasKiYps/WJ6bOt+9ojqzRoH9u1mWpKibggZNKc/4eSi/1ZwjbAbA8DR91ou4MCVAfz1uIrJy6WrdKduxDgKz7KS7AmnlBFhWF4TIn2NefKKSAFlstMm0zeWonqjrFfUYKxvrq/AqYprNvf3YbnM8BeB8TV7aXyr70oIMlZppNvgDo05n+Zw5CcLFBAmHMsiEMXSTOYUWC2ZabsWtxxNqb1Mz9G2szVGapXhQKmRPLwjODmGnIXtnel+GOtcZvuI1/2zmTLLHnDqTHyVYGLn2kyHL7PNPa1R66AcNe43z2AzGLWh+CItI1Qjj3zliaZ8kLlTV1Ef9N51hF1FM7f2sXQqpBtrI6E0MwFviYoCOD1xZJce0y1U142GZOyq2xsnCIza0F5vYgrcmURMATmJVfrROFCUOUsTEutY6rQYX7LZyJX+WHp40TvIELGBP0pg/w4Ymdcl3+Udezh9zlgjPctlHQglRQHxihdPVWxo1yxZVam+KXd/krZks2pMve8oqaJxjtEdiI509nddlKH+7YAEbmljp/Dk6EgknxoQuG0rZsu7iMNd05potd6i7b+XYQoKOQbueeAcB0VFivg6VfbIOakGzZqlNQtk0hXeMoi6KKB6QuXvSkLyXiXdVtHOH+wSQW8u/0Dc0zU9bu8BOeLvoLaaMdVtWCI+sYIpJ/tDq1Zl7NOla4m8mckKM8Hdr/Zuyno7sFgvWdS7nCphXFPEPsfzF05dUf+pOog49zJtXhzUyzBsVOzni/kCTVaPKAtmXNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(478600001)(7696005)(110136005)(66946007)(6636002)(41300700001)(66476007)(6506007)(186003)(71200400001)(76116006)(66446008)(316002)(52536014)(55016003)(66556008)(5660300002)(8676002)(64756008)(2906002)(53546011)(8936002)(26005)(33656002)(86362001)(38070700005)(122000001)(38100700002)(83380400001)(921005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AOM7wUd3G6AR7qOydGWqgcOXbIP5E0umt8fPjwM/w9UWHaGWCjmRzIED4Tp7?=
 =?us-ascii?Q?4G2ZI7AF8Bq4B+BHOmx7r7dsfCdhyWGmlqNO3vd9PzuzFRLXxPUZv2ARqi/j?=
 =?us-ascii?Q?atT/ae361GrJXFcpMq5/ybIJF/GrSSRWk+QfornyF2vwYuXtpigQC4Jn6RYk?=
 =?us-ascii?Q?QRnYDapBRFjpti5ZBIgLb71jbPfxznj4LU80Lj1Vo5h85MdEskynLqYI/OMx?=
 =?us-ascii?Q?jUveZU7gT4CXYkMfyO3nzWyJtonELASMXCfpJmtOJIToFfHpdiiEwuvpyapc?=
 =?us-ascii?Q?Mx0lAeKRpyLQjA9RI+jHhTTPDw+dILP0F9iLfrJt67zFl5lxTyZJ1tlumrwZ?=
 =?us-ascii?Q?oTeQK9b8TcZUT9C1gSxD4MoBzsG7yZw0K+bIpnjro8wH9qs79EcQlQpWE5Qi?=
 =?us-ascii?Q?lDGcyNt3pfM4Ww535eHVc1L92yfE6XNr6AzsaDdzDTb7hlFXhOHUpxus7lfc?=
 =?us-ascii?Q?QoyDkvXeMxZAKzKqoSS7EpNdQd6uxFgoQ7oqO9ed0kATLjiB5y/nUX3SZB7U?=
 =?us-ascii?Q?TSMXVY8f/b7uHZTt+dkASwApAAZGYCRdXZGIjlQy9TcOeH8p/thodEFg71Jh?=
 =?us-ascii?Q?ibp0l66SJeWNRJ+fdFrELbXe1zWs4s4YTpilMwSLhAtuFyR13sKQDl2BZr31?=
 =?us-ascii?Q?O4oJi5GHpE48bIz6fFTE48rIFcp1vlpA3TmaSBjZcEnQyfWpVTxpYeFmB2qQ?=
 =?us-ascii?Q?IU/aVWYQjs9sUHs30tvYwOps23pQY6BDIN1/SS1aXiTX64iTT6kPvf+k6pYU?=
 =?us-ascii?Q?zO2Jou4WFbtXmZ6PI2F+xE5l0dx06xyJ6WijH371ZaNiDnENA3rESEwQfi6K?=
 =?us-ascii?Q?D3rGpj6ZU6s5MWanT7Gwd+P829zT6trNIiabi85xUK2A9sacBJ1iVwCFZLAl?=
 =?us-ascii?Q?OceamGbQh6zMjg+wWrnosA2i9tUmyEQWbyUUnEkyTsF0Zdreq/ZI0DhAmyhp?=
 =?us-ascii?Q?RzNZoWsf9f2qKyLfJKn1G8ppj89MPsDkFuAmTqAYYRloWtE/jsJff57u+WID?=
 =?us-ascii?Q?ktSAZE+MA+Hm8VxZlte58ViRchzYB2t8jpLXICLc0Bw/ED/E2kJrR9oIYezZ?=
 =?us-ascii?Q?pZ8dBEK+MW9NCkkDncjETc09mCpbJDbFgCH6hIhPxnaQ2b1KYOgbGzj/rvmM?=
 =?us-ascii?Q?DgEzcu4DBZKI/H6RemMTBdbJPYZp19ctkS5hjZBjTluG0c5UxQMYqH3foMYq?=
 =?us-ascii?Q?FFCPuh+4TFVlxeEx5eDyKpJ6/bttOotexiyokkTlwOYNa3zD9Fr3Ks/7xUxL?=
 =?us-ascii?Q?BQgXwk3PIs2opKhX0s9+H5Apwxr+BorLLt0pTsXjFG5/s6etaq27KYgHjqSY?=
 =?us-ascii?Q?qvaV1jFiGSiCk4KdUP9EMWt2uZxJNVpiwn1CE7HzS/1ugbKfPWPQDJCMILo3?=
 =?us-ascii?Q?M7bEoyth3SFmZhQZ1flsw5kryFVuKJcwi8gkvnIbFntCKpmNSpdxzYfeiR/J?=
 =?us-ascii?Q?0YeiXvzSgL3jVSYb5rbBg94QmsDMKB0HCpqnExAyDyJz+Uhi0MqPg3PA3dTF?=
 =?us-ascii?Q?6c+r0J0IB1PxLMGIyHUQ0xBvCtB/qJ/J+VpdoGozDBrhx6ujfY+oJTxMXaJn?=
 =?us-ascii?Q?nOoPazoM7Z1uszBXgmk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602fbe43-ef7a-41ec-21e7-08da657c7dca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 09:37:38.6470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZ2FxZKx0CmIRYUb5x6mC6lmaNeKfIynbHOgoG1l6Iypihe1Vc0kxRXQ6RVnI4yB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3180
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

[AMD Official Use Only - General]

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Thursday, July 14, 2022 4:43 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu: drop runpm from amdgpu_device
> structure
>=20
> It's redundant, as now switching to rpm_mode to indicate
> runtime power management mode.
>=20
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 23 ++++++++++-------------
>  3 files changed, 15 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 15f290c9523d..9f729a648005 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1011,7 +1011,6 @@ struct amdgpu_device {
>  	uint64_t
> 	df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMONS];
>=20
>  	/* enable runtime pm on the device */
> -	bool                            runpm;
>  	bool                            in_runpm;
>  	bool                            has_pr3;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1cc9260e75de..70a7203a2916 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2118,7 +2118,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
>=20
> -	if (adev->runpm) {
> +	if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) {
>  		/* only need to skip on ATPX */
>  		if (amdgpu_device_supports_px(ddev))
>  			dev_pm_set_driver_flags(ddev->dev,
> DPM_FLAG_NO_DIRECT_COMPLETE);
> @@ -2175,7 +2175,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>=20
>  	drm_dev_unplug(dev);
>=20
> -	if (adev->runpm) {
> +	if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) {
>  		pm_runtime_get_sync(dev->dev);
>  		pm_runtime_forbid(dev->dev);
>  	}
> @@ -2458,7 +2458,7 @@ static int amdgpu_pmops_runtime_suspend(struct
> device *dev)
>  	struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>  	int ret, i;
>=20
> -	if (!adev->runpm) {
> +	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE) {
>  		pm_runtime_forbid(dev);
>  		return -EBUSY;
>  	}
> @@ -2527,7 +2527,7 @@ static int amdgpu_pmops_runtime_resume(struct
> device *dev)
>  	struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>  	int ret;
>=20
> -	if (!adev->runpm)
> +	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE)
>  		return -EINVAL;
>=20
>  	/* Avoids registers access if device is physically gone */
> @@ -2571,7 +2571,7 @@ static int amdgpu_pmops_runtime_idle(struct
> device *dev)
>  	/* we don't want the main rpm_idle to call suspend - we want to
> autosuspend */
>  	int ret =3D 1;
>=20
> -	if (!adev->runpm) {
> +	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE) {
>  		pm_runtime_forbid(dev);
>  		return -EBUSY;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 9182e81e3135..a3744c0b632b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -147,14 +147,13 @@ int amdgpu_driver_load_kms(struct
> amdgpu_device *adev, unsigned long flags)
>  		goto out;
>  	}
>=20
> +	adev->pm.rpm_mode =3D AMDGPU_RUNPM_NONE;
>  	if (amdgpu_device_supports_px(dev) &&
> -	    (amdgpu_runtime_pm !=3D 0)) { /* enable runpm by default for atpx
> */
> -		adev->runpm =3D true;
> +	    (amdgpu_runtime_pm !=3D 0)) { /* enable PX as runtime mode */
>  		adev->pm.rpm_mode =3D AMDGPU_RUNPM_PX;
>  		dev_info(adev->dev, "Using ATPX for runtime pm\n");
>  	} else if (amdgpu_device_supports_boco(dev) &&
> -		   (amdgpu_runtime_pm !=3D 0)) { /* enable runpm by default
> for boco */
> -		adev->runpm =3D true;
> +		   (amdgpu_runtime_pm !=3D 0)) { /* enable boco as runtime
> mode */
>  		adev->pm.rpm_mode =3D AMDGPU_RUNPM_BOCO;
>  		dev_info(adev->dev, "Using BOCO for runtime pm\n");
>  	} else if (amdgpu_device_supports_baco(dev) &&
> @@ -162,25 +161,23 @@ int amdgpu_driver_load_kms(struct
> amdgpu_device *adev, unsigned long flags)
>  		switch (adev->asic_type) {
>  		case CHIP_VEGA20:
>  		case CHIP_ARCTURUS:
> -			/* enable runpm if runpm=3D1 */
> +			/* enable BACO as runpm mode if runpm=3D1 */
>  			if (amdgpu_runtime_pm > 0)
> -				adev->runpm =3D true;
> +				adev->pm.rpm_mode =3D
> AMDGPU_RUNPM_BACO;
>  			break;
>  		case CHIP_VEGA10:
> -			/* turn runpm on if noretry=3D0 */
> +			/* enable BACO as runpm mode if noretry=3D0 */
>  			if (!adev->gmc.noretry)
> -				adev->runpm =3D true;
> +				adev->pm.rpm_mode =3D
> AMDGPU_RUNPM_BACO;
>  			break;
>  		default:
> -			/* enable runpm on CI+ */
> -			adev->runpm =3D true;
> +			/* enable BACO as runpm mode on CI+ */
> +			adev->pm.rpm_mode =3D AMDGPU_RUNPM_BACO;
>  			break;
>  		}
>=20
> -		if (adev->runpm) {
> -			adev->pm.rpm_mode =3D AMDGPU_RUNPM_BACO;
> +		if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO)
>  			dev_info(adev->dev, "Using BACO for runtime
> pm\n");
> -		}
>  	}
>=20
>  	/* Call ACPI methods: require modeset init
> --
> 2.17.1
