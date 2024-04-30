Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DDDC10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 04:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7FD10E0A6;
	Tue, 30 Apr 2024 04:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tTYn4mww";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B4410E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 04:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJbHii6Ifwz3uJqAR3U3aS7G0z+twdbpw5wSgbXaAjZDbnZQrQaz4RwXOAl+t+O8FoPGK0Z+G3ka1kCsAmKq4J1gn33pGN+MKheAc9EPQL37t7ndMR3hjv36cbg55C8vn9BtPpXuZGn0zcSQM6E9jsfv0eV9zq/fL0nE4oqxHiY81OPhf+0y6+LQVn3l54X0JN/XrR2mNNPkwpP3MoFIjcbyMQj81d9tQGohO2Z5aeZU7M/0Q5TUVL5oujQiidOjBf3M8gDEYl4XJon2ZnKd4guWa+14f3txBbPUBYrpdKw/mTyaH17VvQOkbH6NHqiK/sV2H5wiRBMTRKhmfne4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7F0TwK19ejZIBGkF99lk3Q8GuxxgpuVir7+4JUUR40=;
 b=Szj+iWPMW587K+rWc5/h396rQPE73Hyw0lfKSLgkA4xjnXlJUNKaeqbpjfdcmlaFeof4s9PVrJeC7y0Jns8YZS3MzAhYhqGN7oCOv42byvbneyZeIuaK9jtVSjfcFNCam9R9LbbLJzBJHfcCEJGjUpX0DJybHL7Z13BdneD91ECALheqpC2uSwKPEtfwaLtHA42rzK4l+A1qhvS3ycE64nch66AslJItI/xyhethqEQtOCiVJYeGdsfobQnRGD0qwBjM8UJsAZbtIBeVFSCpjSs3xQUmWDLT415ZBVR24t1xCtpfCPMoSMJ1unizo8fTJmCqzGXIHFjyV6Ix5kbrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7F0TwK19ejZIBGkF99lk3Q8GuxxgpuVir7+4JUUR40=;
 b=tTYn4mwwP8RBo4nhDV51f/mhQhmRPRxKlbHlx0lkM+dNoMpPoCk1wvZiPFQp+lPtOsb5IDgI/HjVWgfo5XDbl/33AKjiN4nFofg0UKe//rO0n0aDGtLrl4bu9TS9P+a14dXHmNgFKTUkSAGU9ZbGazfnmpvAH3g5akFPgqtEe2c=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 04:12:18 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 04:12:18 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: fix uninitialized variable warnings for
 vega10_hwmgr
Thread-Topic: [PATCH 1/2] drm/amd/pm: fix uninitialized variable warnings for
 vega10_hwmgr
Thread-Index: AQHamUh4cEfDwAytpk2x76487O7LS7GAKisAgAAMWyA=
Date: Tue, 30 Apr 2024 04:12:18 +0000
Message-ID: <PH7PR12MB599769394768F1C3CF4C74FF821A2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240428084511.1646356-1-Tim.Huang@amd.com>
 <CH3PR12MB80741B48377DF02A3F711D01F61A2@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB80741B48377DF02A3F711D01F61A2@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0bf89161-ba33-4303-bb75-2dea8d1b162a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-30T03:25:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH2PR12MB4245:EE_
x-ms-office365-filtering-correlation-id: eb670eb0-5eab-4437-bfdf-08dc68cbb9ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?drp/dsxx1LaVm2kLd5GfQmUfwYTATlY03XAOTG6zNuXqof64hdBRM20SVMOr?=
 =?us-ascii?Q?xKiKUALWXobMD09jFxs5Z+w9/SoN0GnbScimPNYfaIbQvn4NnYFgpC1cAGbJ?=
 =?us-ascii?Q?MwMD778NTnCrPP344409JRxWPvbnPB2OCDbYueqmbsaFyPDGxA14THIOecS/?=
 =?us-ascii?Q?qZ6YzdH7VZUuOG9B8tyTuKytbPSQAPkpsyDQYBJCRZZCAxQbW+xrCJftcnnR?=
 =?us-ascii?Q?b9+GcGzKjzcMy3Y19qJFO7jD3xy/wlRMUtsQX3lDvo4Ej9B4mF8ybuuyJ8Wu?=
 =?us-ascii?Q?COAJXIr56PiPs1e7pzM0lgDqRgWKnZ414IsbaTGMTmnEPQehoB5vXpt2L5pL?=
 =?us-ascii?Q?q+p6i16alxSSMeR9WT3zr3STHWrthV62qcZhJU1YdIKJ22irRWdBToqZT4xU?=
 =?us-ascii?Q?7qwW8RFExmEWMp6uCe5pMmlKHctM1YSL98yXgHA1om96+onPgow8hZ1iOKvb?=
 =?us-ascii?Q?UmF69OtvhRsY6rdH7vbODJ5kh+2Vms2MPsALsnyXQVE0686UabIpcMWqz0y1?=
 =?us-ascii?Q?rAHHWeW2UTHd/AcB35FiEyCSrg5Sp6yPqTiyMIhRiHD6/h7Z4F3GZMvFSUEe?=
 =?us-ascii?Q?4hcnlYkuvWQk1k+1jht+pKqtVPdMRmPWawdT1Q2xpvCggQdXKSkH8mmYNSSs?=
 =?us-ascii?Q?yiNGw/1PH2En2QDISfimHgE1SFrZP8LpTgfYJWgkhkGK5hgbIC5v4XiASFpv?=
 =?us-ascii?Q?i2o5NYk85I7t7z6Slk3G9A0P9/7yWcRJk2xS+FzKg2xXX3nNYRToM7euFbe9?=
 =?us-ascii?Q?p4O1umLQMaLFgvkg/ioNNcc8au55QNRcHvCiwqsqSVmDuFaoRZ/w76hhHNP6?=
 =?us-ascii?Q?LGNMNJtRK5zRtXS1K0z2ZHOlL2+MV+NzfZCM3V/r6dnRkkGhqRd4XIU6nb4E?=
 =?us-ascii?Q?4Ps2ajTiJIiKKDWow7mlAThkZnn0ZqvdENyURU+JQLHMq8CqDyJXudXNHNvI?=
 =?us-ascii?Q?j6/pvGPpBa90zZy8qdd+fjcQngrbIdBP2YqvBYj/c9XEQgPSO8UBD8qZCrrn?=
 =?us-ascii?Q?uaKBSB6gNqqFOfEzgkIbaoTGFQWNM0KwNh5yzGIJss5VJ30LXctF+XgipiEX?=
 =?us-ascii?Q?kY5WSFX1QHNzZhmkXxq0BWr3KVdl7T/nFBrcuXochsM48/aQd0vjjJgRQsCw?=
 =?us-ascii?Q?ooSWxLZDHCxk5MXx994NtoFLdkzKpimQC4zxD7crNfvffiO1qRySjJB3sEEY?=
 =?us-ascii?Q?x6xkCJjObBusXw0YOGFtgJk+9G1IGLq/l1y9h/SNeKG5SmGoQWrZLos5rsT1?=
 =?us-ascii?Q?xgWvYMiAqsOhoh7JhJp6CX77GBeCMpZLkxNYVmoFEE+n0qD5GoPnmf54iY7r?=
 =?us-ascii?Q?nO5xNrOFZXiWutDlcXs6C8Dy3erEy06/imtdP9R4DCWwNA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m6FHApg+/DAbvjwziSIzAe1wfcqh1gFOMTy1Ms81l26D2xDiAerDONS+MDg9?=
 =?us-ascii?Q?u53DYMCUGZzK2QIQaINwfU1SyZ3TUAzJblyLPLSvOXKjWBuUpYV/569m342e?=
 =?us-ascii?Q?xFzUiuhoV5HHcplYCTDmE5MeUJ3CtNJmF+q3cU5eWSdTdr4GeMwkujZoCzL9?=
 =?us-ascii?Q?qPisSGUpxkJ+FlVKF3gmErp6Sv0+7KcvexuLk9M8TjukTCSqMiaP+R68OWVw?=
 =?us-ascii?Q?vErqtEf085F86MzJiaAXJmaMFOlSBcGW7gP0e8yBYhwJwMB9SbjcUCDh1z3W?=
 =?us-ascii?Q?70ZR2aLxKszSIkUmQ2tSAZulQEuytsiHkuOKRyXeymqKdPpJLY74PfV/VhsX?=
 =?us-ascii?Q?imd6zXZ5gjXZLjAiIOfPXW+TdXC8LabTZPNF9oHy1nuBAvrGFMBGHZcLprrP?=
 =?us-ascii?Q?UTJj7XoDjggtOBS+zMh9GVZS7ffQ7Lr+B07q6uAc0swkk98wxp17VzbvWQtg?=
 =?us-ascii?Q?NmXgNSmlMSCsN5WkMMlc75VBet8r7nfeVpGomEeqlN34xVHcUS60k4hMGjYc?=
 =?us-ascii?Q?pouMVT6vQlo6WG3NEKx1gfoJUJJaDek/Tqhzp84e2LYjVeCm/3zRvHiW8PUY?=
 =?us-ascii?Q?YxWFi56G/IdHUoaa1Q5XBYjCVobYk/0LzY9vCvuocKv6pZf8whZcGLSvTmpu?=
 =?us-ascii?Q?pdtJ2uNdKmyJF5BcQkr6nHYsevnJQbtI8ow9bR4wTtx4DitD950BWIDzQdpv?=
 =?us-ascii?Q?W0Ndwir7LgOxfgTOAWpt+O8ApJtDH5xnT60pXwL9nXPTPT0YqlVMZvMlrwxY?=
 =?us-ascii?Q?7gov0pUaA+c0udCB+naYg2cK/1gKA3SFgazv/HtCmO0NfCB7ij9mmu6aFWnh?=
 =?us-ascii?Q?LVeaSk2og+9c6xhS8YJW5rrkzIH4uF+fIlcPyBVgXADtRvhhjHCZoiUEcFw4?=
 =?us-ascii?Q?FnkyhdGHrZbBaKQtXNNMrKlO8CklpvYAVmFISaW3MNOeL7HAgDzf6GzdKkrM?=
 =?us-ascii?Q?uyz5/7LBfAAm7H39UXbrP0CO0rHbhNLZqQKhivXjqg94Rg5kbes6Bt4BA75E?=
 =?us-ascii?Q?uBmvbOO1r4dF+XEJ2PHmSPTurJWpPpAoUfRg0PYrN14XaKH1JIwtOQAJndY5?=
 =?us-ascii?Q?LBz50HE4JL093Qiie8Zc+Gh+SAUe+kYnb3+gI4qI8AtMyeJULy1OE9BNvrca?=
 =?us-ascii?Q?+fxODmkrsfeqgMKbckqU+LqFu8S+VK6OgCjnvjNxvaommmky/cXstGsmXBhe?=
 =?us-ascii?Q?LXf+rSYbCerf55t2rbrwIo4gvOtDuawu8KMGIlwq5bgKvuro264p0HfHwl1f?=
 =?us-ascii?Q?q15dveO1ZvQPFibW33Z/I4VqHTLq4rYKXHEsFcyAAh4mhXKGnSEhYjMIXdUd?=
 =?us-ascii?Q?syqMYR7RtTS0XLXPDRKUXjFRvVvRz1g+D3h203Xl93KXNxuNF5ej25+RVAd0?=
 =?us-ascii?Q?TbKtZkWfaC8K5zhIlRDRn+sHjAN0mTSC/fwtoVmdQwLFL1fTjZfmzpIbGmrw?=
 =?us-ascii?Q?iUpYMGGWExXGVMUluxVctKVAr6APqho6ZTJqqvrrptf3SoKEc+a6/Y0jssxU?=
 =?us-ascii?Q?tcy6jxDjvwOW6C5uLOMTYzpOZuqlxy1efP33TzKrW+QBS/FpEiyTFyYj/Xvw?=
 =?us-ascii?Q?ALgl9/7LZj/WYQZkWj4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb670eb0-5eab-4437-bfdf-08dc68cbb9ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 04:12:18.2934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9P35g+/5dNS7iQCVOBdiwwiU6XjyboMo4uQAqWr+nv7EpwXDBdiTKOtPHwC00qW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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

Series is
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang, T=
im
Sent: Tuesday, April 30, 2024 11:28 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: fix uninitialized variable warnings fo=
r vega10_hwmgr

[AMD Official Use Only - General]

[AMD Official Use Only - General]

Ping ...

> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Sunday, April 28, 2024 4:45 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH 1/2] drm/amd/pm: fix uninitialized variable warnings
> for vega10_hwmgr
>
> Clear warnings that using uninitialized variable when fails to get the
> valid value from SMU.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 46 ++++++++++++++-----
>  .../amd/pm/powerplay/smumgr/vega10_smumgr.c   |  6 ++-
>  2 files changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 9f5bd998c6bf..488ad9de4694 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -354,13 +354,13 @@ static int
> vega10_odn_initial_default_setting(struct
> pp_hwmgr *hwmgr)
>       return 0;
>  }
>
> -static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
> +static int vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>  {
>       struct vega10_hwmgr *data =3D hwmgr->backend;
> -     int i;
>       uint32_t sub_vendor_id, hw_revision;
>       uint32_t top32, bottom32;
>       struct amdgpu_device *adev =3D hwmgr->adev;
> +     int ret, i;
>
>       vega10_initialize_power_tune_defaults(hwmgr);
>
> @@ -485,9 +485,12 @@ static void vega10_init_dpm_defaults(struct
> pp_hwmgr
> *hwmgr)
>       if (data->registry_data.vr0hot_enabled)
>               data->smu_features[GNLD_VR0HOT].supported =3D true;
>
> -     smum_send_msg_to_smc(hwmgr,
> +     ret =3D smum_send_msg_to_smc(hwmgr,
>                       PPSMC_MSG_GetSmuVersion,
>                       &hwmgr->smu_version);
> +     if (ret)
> +             return ret;
> +
>               /* ACG firmware has major version 5 */
>       if ((hwmgr->smu_version & 0xff000000) =3D=3D 0x5000000)
>               data->smu_features[GNLD_ACG].supported =3D true; @@
> -505,10
> +508,16 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr
> +*hwmgr)
>               data->smu_features[GNLD_PCC_LIMIT].supported =3D true;
>
>       /* Get the SN to turn into a Unique ID */
> -     smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32,
> &top32);
> -     smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
> +     ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumTop32, &top32);
> +     if (ret)
> +             return ret;
> +
> +     ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
> +     if (ret)
> +             return ret;
>
>       adev->unique_id =3D ((uint64_t)bottom32 << 32) | top32;
> +     return 0;
>  }
>
>  #ifdef PPLIB_VEGA10_EVV_SUPPORT
> @@ -882,7 +891,9 @@ static int vega10_hwmgr_backend_init(struct
> pp_hwmgr
> *hwmgr)
>
>       vega10_set_features_platform_caps(hwmgr);
>
> -     vega10_init_dpm_defaults(hwmgr);
> +     result =3D vega10_init_dpm_defaults(hwmgr);
> +     if (result)
> +             return result;
>
>  #ifdef PPLIB_VEGA10_EVV_SUPPORT
>       /* Get leakage voltage based on leakage ID. */ @@ -3900,11
> +3911,14 @@ static int vega10_get_gpu_power(struct pp_hwmgr *hwmgr,
>               uint32_t *query)
>  {
>       uint32_t value;
> +     int ret;
>
>       if (!query)
>               return -EINVAL;
>
> -     smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrPkgPwr,
> &value);
> +     ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrPkgPwr,
> &value);
> +     if (ret)
> +             return ret;
>
>       /* SMC returning actual watts, keep consistent with legacy
> asics, low 8 bit as 8 fractional bits */
>       *query =3D value << 8;
> @@ -4800,14 +4814,16 @@ static int vega10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>       uint32_t gen_speed, lane_width, current_gen_speed,
> current_lane_width;
>       PPTable_t *pptable =3D &(data->smc_state_table.pp_table);
>
> -     int i, now, size =3D 0, count =3D 0;
> +     int i, ret, now,  size =3D 0, count =3D 0;
>
>       switch (type) {
>       case PP_SCLK:
>               if (data->registry_data.sclk_dpm_key_disabled)
>                       break;
>
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentGfxclkIndex, &now);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentGfxclkIndex, &now);
> +             if (ret)
> +                     break;
>
>               if (hwmgr->pp_one_vf &&
>                   (hwmgr->dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK))
> @@ -4823,7 +4839,9 @@ static int vega10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>               if (data->registry_data.mclk_dpm_key_disabled)
>                       break;
>
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentUclkIndex, &now);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentUclkIndex, &now);
> +             if (ret)
> +                     break;
>
>               for (i =3D 0; i < mclk_table->count; i++)
>                       size +=3D sprintf(buf + size, "%d: %uMhz %s\n", @@
> -
> 4834,7 +4852,9 @@ static int vega10_print_clock_levels(struct pp_hwmgr
> *hwmgr,
>               if (data->registry_data.socclk_dpm_key_disabled)
>                       break;
>
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentSocclkIndex, &now);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentSocclkIndex, &now);
> +             if (ret)
> +                     break;
>
>               for (i =3D 0; i < soc_table->count; i++)
>                       size +=3D sprintf(buf + size, "%d: %uMhz %s\n", @@
> -
> 4845,8 +4865,10 @@ static int vega10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>               if (data->registry_data.dcefclk_dpm_key_disabled)
>                       break;
>
> -             smum_send_msg_to_smc_with_parameter(hwmgr,
> +             ret =3D smum_send_msg_to_smc_with_parameter(hwmgr,
>                               PPSMC_MSG_GetClockFreqMHz, CLK_DCEFCLK,
> &now);
> +             if (ret)
> +                     break;
>
>               for (i =3D 0; i < dcef_table->count; i++)
>                       size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> index a70d73896649..f9c0f117725d 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> @@ -130,13 +130,17 @@ int vega10_get_enabled_smc_features(struct
> pp_hwmgr *hwmgr,
>                           uint64_t *features_enabled)  {
>       uint32_t enabled_features;
> +     int ret;
>
>       if (features_enabled =3D=3D NULL)
>               return -EINVAL;
>
> -     smum_send_msg_to_smc(hwmgr,
> +     ret =3D smum_send_msg_to_smc(hwmgr,
>                       PPSMC_MSG_GetEnabledSmuFeatures,
>                       &enabled_features);
> +     if (ret)
> +             return ret;
> +
>       *features_enabled =3D enabled_features;
>
>       return 0;
> --
> 2.39.2

