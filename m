Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B364FC64ED6
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Feb 2023 06:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E812410E00C;
	Tue, 28 Feb 2023 06:20:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEBEE10E00C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Feb 2023 06:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcTHct5/lBjcHLbBFER8gj3HJhd8EkAEk7FIJLwXwvk+/mKqNd1G5iRDpEiiqY0p3YaSvXSEhis21/ENOaONmbhYIef/niZcENSvYwlQ6VvYqyrfs0hkDBmwzLeJcHA4eEkfgBOzqW8yQ1S9XiWvuZk/q3vFJtgTNOcRWe5HwZZc8qR3K6fdy2SUIlsTR2VrBhqHmVQXeV9wGwpUzP+kqiAUMSU7N8HB6MsKFlQseA3pHjxcdwSGkfGvHO4ZAcQjLbrB7BUpnyd5JZjHjzEUwh9PjLGKJZeANtQJi3ChVJ1ciqhMhL240YcYWen38rPhx3jlI2tKUNH82EI5KlbT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9ZezrvyDtLCPEh9u1vc/5JRzscasiDid3c77gx9ZAw=;
 b=TW7C8kbgkXrgyNII7T7nUUC+N3xPkAxoJAOEwWDxpY0euW+lwuYKxOln91cYBGwyk4jJL9L9ecYvUVPLCVu5c2JuBvN8XfGdgyTxARuofU9k0+VqNQy72JGyvzx+9+34e1ivjr+JDx6b4KifQ3zD+teVku3SV0YjtXPufDQ9ZhSD1Q36fAlwLLSFk2tnCZyJsbtW7JQimgmBFfSbmsonMoBdqAmT3/0+6sw4jFemY+y4v6F2TqCldQUFFe4Ckqk8LwhOr9dU3s5mjCZSw7EIliJKMeZZYrwaHT8GxtnsBlBG0emnFBUe5wf/2HDqYR8c82JEoGQGcE2cJNdJdZM9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9ZezrvyDtLCPEh9u1vc/5JRzscasiDid3c77gx9ZAw=;
 b=1sKHo44YlI59dog5Z9HpOZS4shxeRmekKVm9gWsZgxE+aXifMT5dLtL5PWwqdCm5H1Ofg76x3POCJHtHxpBXoNim8GX0OFyYhythuRZhLASUA1dVvUvuKfcCK2zlsXv6r6LqFXr/Q6RKsSMW2TKOS5aAaFW2d9yl+W2CKWUqBME=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Tue, 28 Feb 2023 06:20:31 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%5]) with mapi id 15.20.6134.026; Tue, 28 Feb 2023
 06:20:30 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 3/3] drm/amd: Add special handling for system s0ix
 state w/ dGPUs
Thread-Topic: [PATCH v2 3/3] drm/amd: Add special handling for system s0ix
 state w/ dGPUs
Thread-Index: AQHZSy87jAkEytxfT0WgArlOmQf5Q67j4osg
Date: Tue, 28 Feb 2023 06:20:30 +0000
Message-ID: <DM6PR12MB2619F2015DB125FFC50F3DFBE4AC9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230228044304.27940-1-mario.limonciello@amd.com>
 <20230228044304.27940-4-mario.limonciello@amd.com>
In-Reply-To: <20230228044304.27940-4-mario.limonciello@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-28T06:20:28Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e7414a3b-8495-4cfa-88af-9f9d11cbfd50;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CH0PR12MB5107:EE_
x-ms-office365-filtering-correlation-id: ca9f21c3-781c-4dd5-82c0-08db1953e463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TRjliFiRWA2o7zEigVrRQMU3v3sY6Ql8TiiOgzJEJvbftYuu8o7NhOzOoOx5Q35CTPQ8IC3S76KjciinDUlvs3M5KlQmsUL45Qb4hEenJ2+ZP7/fz/97ETw/emYAaWejQpSmZlI1zDmLYMs02xjW8HgKFme9XGM4+srVwXuwZyU/1MbWZS9WTp9J4WvSNCogh8ZhEUbNb/e1Tb904OCzbK/O8a9ZPnjaPS22iSInQKy5LE3df1SYgxO/+eVRZCeiYL7fDHEjj/psgnxcdgcGHH9c8AaIYATSKom0CVwZefUe9NQXN+3rcLJYGpLcDwBYXTfEHNazO0rZDedkCI5TNar44MHKRsudO37X5apMyHBf7O19/u04RdUfMBDf4jOyyfXOO02iKWjTvJ2hME1KwVV7UgZh7Jr6VfTfcKS8FWkOumWmzXPGptrbAhWCJmimMtXmdtG8mj/Dk/+hPE4PNiAIcA+FmOVWYtN/iJtGlpjIP7CgsMKXv/8t0EM9OxJG1DzZbJxqO9s8W/I5dQcKwbCpcrZeB63upLCqyI+l7YeBH9oSuoJw/pgvLx9dwu5Jerc9W6wRD3FDF8D4/1GyBEUrZiGpCL1HNZjgQczqKzRRbx5gpW91YY8TX4hBcNKE0oSqvh9eABwIR3hf+mXqmJRSFj8aC3FBXSqSInP5n6aTs8kQlSoZ/bDp61DUs34iO1A58Tibh/ZyJqCemR59hIhrIE1gsNqR2qZCBeMk0aA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199018)(9686003)(26005)(186003)(53546011)(6506007)(83380400001)(38070700005)(33656002)(86362001)(122000001)(38100700002)(55016003)(41300700001)(66446008)(66476007)(64756008)(4326008)(66946007)(8676002)(66556008)(76116006)(2906002)(8936002)(52536014)(5660300002)(71200400001)(7696005)(110136005)(316002)(54906003)(478600001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/n0HH0B9kNwIk7Jh46qNDhsm2Ys4H3ynb0iZsA0WgizV7RTLNWUWebcSuDZG?=
 =?us-ascii?Q?SZxlDs4RgmnNTc5uiXIyvO4GZN5zvsd+OXuAsrvhN+tPeI62GubjRqow/new?=
 =?us-ascii?Q?tsMGpSYNfpInsq76UzrjMhRkVC16i5hgB7BUMEop+EfRBmVKWbbaxckx3JM0?=
 =?us-ascii?Q?W2W/igYsco16umB9cYbni2PJ37T5R9JQyVNOaF7HiU3eQ0Nymr3NjXKzjFKU?=
 =?us-ascii?Q?kUDNyYfxNOlLh1daAd8jZgGN/TQWCfZmlu3I5OTxfI91+qgjJ6uTdyW6SFvx?=
 =?us-ascii?Q?HmPVtYOcPfjJWwa4zxJO3z/7sVofXajz0BK3vBoROa0Rzk0B85wZFmCk6YaX?=
 =?us-ascii?Q?O+QTtnQrV6taxenAFzWqcnXE1Nf7+MgmyMDilIcG6g7KCEQqs95Vrm34sAXJ?=
 =?us-ascii?Q?lMQsGYfM3KOd8yVpJaG0SDcogfagGVzRe4OT9fmBOhIUpFE0IJ1ZpRauMvud?=
 =?us-ascii?Q?FBFiDJ2UO0byy4n1ARZFRNZ/Z1GY+ZTVbPgBhWvmoUwzXa9Mql8lPo5VLC8N?=
 =?us-ascii?Q?HPCMTvqlneT1DKC0ksl6uBmlg7cxyc85oXrRIdMcuDpOnj5t7NZfR3jLDL+4?=
 =?us-ascii?Q?DG6NplNWqTFeJGeXRy/fBrELxo7WBSqa20lUAfnikR1R5pbS+tnp7tJHPx5F?=
 =?us-ascii?Q?bykvEbAo0s6RBDjMYvC/bwLv0ASVyXCjBttyJJftpgbte471N2rEuJI5PgOi?=
 =?us-ascii?Q?oZBdkpUyHwq7B9ZWeMQlSN0w1YxVKQuw8kDt1yLgSvPQKrDuH/wFsvLY7moZ?=
 =?us-ascii?Q?fu5arVe+tO8UdzZ4TPzyxnL2j+Q7pavijbOaoy44uBrPVP1tN6A4uO1HyZll?=
 =?us-ascii?Q?9HUQcLueh6cfNsNuuqxuSK10eWK7moaqvl3c1lRUNsTPHLLk9qJTEdfkKKJH?=
 =?us-ascii?Q?s0u50tG0p1EjotCAuBvBB7uTSPWfht9pWjRs0o0wcH7Z/2SJgtZCjyIyu6CF?=
 =?us-ascii?Q?XBafhfC6zBz29tqC1mvh+5qbeA9JmxFl08ThZsU0/qcUmLB0KaWUyZgpeBMF?=
 =?us-ascii?Q?AzHWBPSw+54kIazBd/vUkd+PRnSuTU/A7xNiXd3ZzLed2LAkkO+ayT2R+FwW?=
 =?us-ascii?Q?cLvNlShSEQjZJxMeZgStLv1g7SuELmEDqx0x4kyyNg8aYyYdeCgqSVXAKN7F?=
 =?us-ascii?Q?EuJEvEIECdj0z5tK+jNm0BZQttxQaWnq0V5q4FVveQgKlN2tVm2L2qYwcmew?=
 =?us-ascii?Q?RR5q4K5x5DAeAXtxjuX+yKf3ndvQJVWkUzS3EM/dkusiabTeCqkCOzFW10In?=
 =?us-ascii?Q?6TQ4k1f+KdiNETNlLnrKEA5GmuoUcMCqMOJLWCGAvkQlEZi2b/GXqPRGv2/1?=
 =?us-ascii?Q?m2FfxX30mft3Q/p/SkRqw67dXwafvc08B62WVZ2gn/sTwAbl7FBfpKZZHGvs?=
 =?us-ascii?Q?0IgrbNHMh2b4nHEq0xSrlGagfKjSED5ljXzXynZgAV1ssVxHrNdBqzpV6OwF?=
 =?us-ascii?Q?7h7Zxc2i0M19whGB+1JjhpfIn0iTmjHOTmohY0CiQ3JYPTnv8JF508uze2Ci?=
 =?us-ascii?Q?4geILdMjqb3qWNWtXDGLsliyxt2g/iFmvEaTZ0y1T2ns6C1OGr9QDf7AsZ2N?=
 =?us-ascii?Q?8Vclm4sSOm7nbFrfrIQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9f21c3-781c-4dd5-82c0-08db1953e463
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 06:20:30.7295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q5GlJ6gKahaDhQHzmBJSNnA2Cjck7H0kM2zxzy3eTNd7srQr7g2C+Wx5dle1a/AX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
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
Cc: Peter Kopec <pekopec@redhat.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Mario Limonciello
> Sent: Tuesday, February 28, 2023 12:43 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Peter Kopec <pekopec@redhat.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH v2 3/3] drm/amd: Add special handling for system s0ix sta=
te
> w/ dGPUs
>=20
> With dGPUs that support BACO or BOCO we want them to go into those
> states when the system goes to s2idle.  Detect that the system will
> be targeting this state and force the call into runtime suspend.
>=20
> If the runtime suspend call fails for any reason, then fallback to
> standard suspend flow.
The "standard suspend" means here is normal s2idle flow. Right?
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * New patch
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |  3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 711f2a1bf525..7c3c6380135a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1073,8 +1073,7 @@ bool amdgpu_acpi_should_gpu_reset(struct
> amdgpu_device *adev)
>   */
>  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>  {
> -	if (!(adev->flags & AMD_IS_APU) ||
> -	    (pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE))
> +	if (pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE)
>  		return false;
>=20
>  	if (adev->asic_type < CHIP_RAVEN)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 750984517192..acc032c4c250 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2415,8 +2415,18 @@ static int amdgpu_pmops_suspend(struct device
> *dev)
>  	struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>  	struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>=20
> -	if (amdgpu_acpi_is_s0ix_active(adev))
> +	if (amdgpu_acpi_is_s0ix_active(adev)) {
> +		/* try to explicitly enter runtime suspend for s2idle on
> BACO/BOCO */
> +		if (dev_pm_test_driver_flags(drm_dev->dev,
> DPM_FLAG_SMART_SUSPEND)) {
> +			int ret;
> +
> +			ret =3D pm_runtime_suspend(dev);
> +			if (!ret)
> +				return 0;
"ret" seems redundant and can be dropped.

BR
Evan
> +			DRM_WARN("failed to enter runtime suspend,
> running system suspend: %d\n", ret);
> +		}
>  		adev->in_s0ix =3D true;
> +	}
>  	else if (amdgpu_acpi_is_s3_active(adev))
>  		adev->in_s3 =3D true;
>  	if (!adev->in_s0ix && !adev->in_s3)
> --
> 2.34.1
