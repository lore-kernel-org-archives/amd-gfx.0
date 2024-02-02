Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3BDC47DB3
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 14:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94FE010F019;
	Fri,  2 Feb 2024 14:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gmo8LK4J";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7656110F019
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 14:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWpM6ufs7xPCKFioMJD9XWbrg1we2kEChfs93Sph3JL7yy2X4HBqDwqLrUkKuzhW0w/UOKo6gOOleztY1Akl6anVs9Uo1GJkUjaY3SBw9t3aTrV1gnJ2G1d4sJVtIMG0tJ5WztswZ/HKpvatJf5Jn7AokyevMXGX3ORZlKELeXzTwcBZgTlMfcYEVSuHwiwcEC/oJV/rKFERv7MRTHpYhluka0qV7q+Dld96EgBuv2oHHGVqX5gE5lGdXANvrpPzU4+JkhNuecbmyxqdBaDUNiNgUFnBVQWeiESUu7TR1fWYFFfqvxmxyOg3zaNF3CHBApoZTVbNWOxFQOxx1DEFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5oHudA55LqprCLqhcbKN1MXHZ8MyvhPHH4NItFWnFo=;
 b=WkDvu2zkObeWMr7TOgQ53Am0yDJyA/JSCQC7DZ/lKyMk+kqBsSjcWj+WNU9HJzDC1RV5Y64ZOmJVy/c+cB9V3gJwhOLTFj4xCL3L+cVVvEmuoxVu/+YwHmndBH7qODXtN/0D6Vz1hGYAeMfu4muDJvDitZkeWUk8En4Y6/NA+H+3A9EpwmnL58KXhhxfNkPMuGT1EzqegqB41RKyOGE14KaaOW/MniUkGr73bpR18UMMRZfY5gWkxPAgJioCOLsw94AOay3Wy9+16oFetR5rJqRtAZTeLCwS2hLc5vxfR1hDif3uoDeut8WhCCcdvpLhWlr0Nc1wiWg3Fm+66yXcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5oHudA55LqprCLqhcbKN1MXHZ8MyvhPHH4NItFWnFo=;
 b=Gmo8LK4JWf2loAV3ozEsm2iBiKoSGz40upLCWLBMWST3/MGOAUTtefGphY0JF15haLt1FaalbhqlvgSjo3V8EslphlC3oVNw9Qi66QHtjRl6v9lYeNpRzKX0/D42WjuKOXOR9ffUaRJ48rlCBU3blXVonsD2ijoaBZOLs8oDyA0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.9; Fri, 2 Feb
 2024 14:54:39 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7270.012; Fri, 2 Feb 2024
 14:54:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Sharma, Deepak" <Deepak.Sharma@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for
 suspend abort
Thread-Topic: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for
 suspend abort
Thread-Index: AQHaVOy7+vEFQW5qPk+W3IaHqDPSZrD3JYtQ
Date: Fri, 2 Feb 2024 14:54:39 +0000
Message-ID: <BL1PR12MB51440CDB4FC941BB8F0EE997F7422@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240201085735.989940-1-Prike.Liang@amd.com>
In-Reply-To: <20240201085735.989940-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a0912fa9-e8ae-4cf8-87f5-8d083411701d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-02T14:54:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW4PR12MB7468:EE_
x-ms-office365-filtering-correlation-id: 6cc778a9-748a-4f13-1f4e-08dc23fee185
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hNqZBpw8Nt8s4Lj2ushVEaFDJZ3C3Zcqg1EBlhV7XFO8glgn973cb+4S5gCJtvQMqcUsnR8GaRkFvzyDlH7jVkvAWSSI7os5TGN3GjCux89yapDtJC91ZaN6DuKYWI5Eu7PqFtSphCqzSHByZmhaB8jmSr5FXlT6xvqqsYzvvmBo/bzReUq4UfFtWnf0sDhzzp0kA1Zwf+J87skMyKcxcNteJ8TH8KSvhme+NY5iRmpCLnJfFSzlhix3tV0onyIikUBq+iMP7utRped+dZxobnBpGdpjmTQjhiq9f/UvCBVqGs/ppQin2S4WiwCG2nJKWVewPVIVt7f7xzEBB/5ugDETjE3US2TkYJ4a6RqbFJWioqXTT9KNfRBHQtOwbXsOAwu+AJSDVcND5oc6wk5z5rCxHg+EQYv1bhJ6FbRKyyKfZLkVbJOOA9yk5fuY4va4n3o7ajzpnfHGZWw7eXixYL1LdcGZ4y6ZEWWs4URplS2/Qb1YjcRf5/mIJ129BlxfBcvAKbcbhMTXZp+ZB3K5AAfc+AAVtU0IYMkaIFs+KCeAseOUjTlC3tA5MjNOXu0HgbWnBp73lo16xmmbPUr1BSy1VakRiqQBcaudUb1cv1DY10C4NE4BaThLiL4WkcKU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(64756008)(76116006)(110136005)(55016003)(33656002)(2906002)(15650500001)(5660300002)(66476007)(316002)(52536014)(66556008)(66446008)(4326008)(8936002)(8676002)(66946007)(478600001)(38100700002)(86362001)(9686003)(26005)(122000001)(71200400001)(7696005)(38070700009)(53546011)(41300700001)(6506007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eZRhA88VZKNcC/4LbliAU4q17BlPVeMluOPkmWescyiMXDcwRqijHxP6AHjE?=
 =?us-ascii?Q?RJsbfOjameQ1PDtQr3Bu5n56fLapJQbuM0E+x+hIIII85QfX4yO4pnafNgV2?=
 =?us-ascii?Q?p0O+5VutWUTx48Svj44S15FTQcMqfxh3tbJDi2hulTIXJReG9cYG9IHzC7vO?=
 =?us-ascii?Q?2lv451myR97jhCrl4wfdUVc/mCLaExcWSo+m532W+qK8Ol0JwFD5d3xN6qwx?=
 =?us-ascii?Q?mquJzfk8DbKkPHxPWp+hJKjvTL/Hcn8rvhwu/qP+nLigK5mBihCWwYmp5J4Z?=
 =?us-ascii?Q?RF5XBmEeq5my8n97k42TsIY4FA93Hk5y4hINJX0qubyVVP3rDGVOEgfm2rvc?=
 =?us-ascii?Q?yc1mFVH+Fimep/TidiZ7hUghDw9d3UgU1hOr08rtrmT9kuBI4STc8hsV8GBI?=
 =?us-ascii?Q?JHWcQSeHFmkNW6iHOrKb0V85UZxj4M1088sgs19cVBioS+FEv9uyXdCjKaM5?=
 =?us-ascii?Q?SPCXugZW6u1xThbJ3gynuRBppID6TsdxV27NagPhEIJbQJGkAzP1rF21eTE2?=
 =?us-ascii?Q?eoCcnJ6uEejE53gtl1ZXU2QgYI+H+m1PK+F15l+w1P+AiTviqSo4kOtEEyZ5?=
 =?us-ascii?Q?KpG/QjIdYeBmC7mi0w2/7dIizIoFl0GIa5SJuSbI9wMXjEX8UGfS/QfC+fxw?=
 =?us-ascii?Q?pkl6UgNAaocYjkUZbC0yn9q9xX8K6TX2l3AK1YXQq7uPoAzc73oOifqMkQDF?=
 =?us-ascii?Q?7sDf3KGtkJIfQYpIpuhnhZl5s+KBgLroCKFY1fueS8llnw5dAgyGVXbLZlpu?=
 =?us-ascii?Q?Uyj0Ul1tY66vPnrHgpfvQNCrXsfPfvnNsQZBydFwa1EAhcjBYm93bYDOnSDx?=
 =?us-ascii?Q?kk74PpxR51BjSnklHVFaap/jCgURd8DhB/INHKbP+PjpWz/ci7u5U5WRT2H1?=
 =?us-ascii?Q?Zs3OOze1cUhknewUJ3OyZ2arLAoJ4vpsWvC0PEhhH6jmuYG7acYwcrzNb/La?=
 =?us-ascii?Q?4q2i2n9QWoj8RJt1LwmrTuTqOYJ5qcRpsQZvxNG4Soa1pu2HsBmJqLpCltpW?=
 =?us-ascii?Q?5XQp7+aJ/iV9Wsfaj4HEGdHcDpk0rVhiG6o2oWZwyyxSZiWnz7LboGPKzwSF?=
 =?us-ascii?Q?XbArHXSKhknw+LOSST1V1mhYAVRdYE8genl9lzRHuDFLZpffamsEyHqzD5vn?=
 =?us-ascii?Q?GTZT1LjMoLZ3DZbz1cznVgw70SatC1UEhQVCrexjuTg3uGqIWRKM5bo3BKdN?=
 =?us-ascii?Q?Sx+wgH2vJUuuTkw+U3Pz4cxXH+vCLVPqLv00Ah7BJMpK9uCQmlPH7Lb2Xl2P?=
 =?us-ascii?Q?kyTb/sYnEJWS4qxLLlxtwsq7E/MT5HR3PIICXSwob4gtfmGVom+zNJyfoCLb?=
 =?us-ascii?Q?Ne6nAGgQLceFa0L1Zact278D/Scai17+ObGXGPUdBxr6ZGE7Ps8TfZsONl+v?=
 =?us-ascii?Q?So5Oo3c53mOrhBhtLzidMHOh8uoogcVjG5lC6Dhb2dk3Q8kaktfsrNKjSzbk?=
 =?us-ascii?Q?/1pd2egmET1x8J0bUX0ulDP6bdZgrJSGXMPEF5LPovuhzcoKr8HA3KFvKfUa?=
 =?us-ascii?Q?T29/3yKEx7oALHxD5tK4zTxn2ReiSIaJSYtBA1pe/qmnyYiZFbk//RHVRV1Y?=
 =?us-ascii?Q?faH/zdy9yOMITnK0RYI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc778a9-748a-4f13-1f4e-08dc23fee185
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 14:54:39.1873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Og0cRMmweCHHUwRPrWOrRbtF3x5zCP4hNXFfWe4NrZbX04Nb203kt18SNpDHQF0wwa7w4PqFHDy4adJyapo3WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
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

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Thursday, February 1, 2024 3:58 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for
> suspend abort
>
> In the suspend abort cases, the gfx power rail doesn't turn off so some
> GFXDEC registers/CSB can't reset to default value and at this moment
> reinitialize GFXDEC/CSB will result in an unexpected error.
> So let skip those program sequence for the suspend abort case.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 8 ++++++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index c5f3859fd682..312dfaec7b4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1079,6 +1079,8 @@ struct amdgpu_device {
>       bool                            in_s3;
>       bool                            in_s4;
>       bool                            in_s0ix;
> +     /* indicate amdgpu suspension status */
> +     bool                            suspend_complete;
>
>       enum pp_mp1_state               mp1_state;
>       struct amdgpu_doorbell_index doorbell_index; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 475bd59c9ac2..59254144916c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2472,6 +2472,7 @@ static int amdgpu_pmops_suspend(struct device
> *dev)
>       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>
> +     adev->suspend_complete =3D false;
>       if (amdgpu_acpi_is_s0ix_active(adev))
>               adev->in_s0ix =3D true;
>       else if (amdgpu_acpi_is_s3_active(adev)) @@ -2486,6 +2487,7 @@
> static int amdgpu_pmops_suspend_noirq(struct device *dev)
>       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>
> +     adev->suspend_complete =3D true;
>       if (amdgpu_acpi_should_gpu_reset(adev))
>               return amdgpu_asic_reset(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 57808be6e3ec..169d45268ef6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3034,6 +3034,14 @@ static int gfx_v9_0_cp_gfx_start(struct
> amdgpu_device *adev)
>
>       gfx_v9_0_cp_gfx_enable(adev, true);
>
> +     /* Now only limit the quirk on the APU gfx9 series and already
> +      * confirmed that the APU gfx10/gfx11 needn't such update.
> +      */
> +     if (adev->flags & AMD_IS_APU &&
> +                     adev->in_s3 && !adev->suspend_complete) {
> +             DRM_INFO(" Will skip the CSB packet resubmit\n");
> +             return 0;
> +     }
>       r =3D amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
>       if (r) {
>               DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
> --
> 2.34.1

