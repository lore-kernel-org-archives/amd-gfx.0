Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4049C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 09:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A23810E8F6;
	Thu, 20 Feb 2025 09:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jW5QE423";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733F110E8F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 09:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G56wrN64dKf3KPf68mMWrh3hQL47lDozGmbhb3NwSypXeZNj9Zbc7ZBrBDodHXUcnFkO2yQEizM8kg9gQpOA3T/l7+mo+JXab5hDYMLonNoyDAfOTbxstQb0tnviJZQFTn6XQlcm5CAQo1BOSZZnz29hJIZzqixPyGDc4UdtrgSiR+SfM1tVcfApETmKja2Weo6zkrBM6aR2CBRxRw3OMap28BXwOE+1lSADixRtMfzsb+cBL9GhCxzVUmylt/X/YQqZgeb07amkgmQomG4xat99lJ8Da21eELr3cAOvsHzba9epwVTpyaL1G4ttFfnGfHe14TnogW2W9+Vn+E2W7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xomfh5ZFHrEGyZsh96XbeUOXPkDsY/qljzontcZeG84=;
 b=o1llwg78wtDgG+PMMdF29TYPK9FQ8xMZGRutwkSV6hAVeoBP19i7rPh1yUXt8nVoNSrbdqOgAPIWhWxNmq5ukFHLkQ95Bqra79m5xzHKRU/GB/Vu0KewIvDeS4WIPb5PqcoKkDTW+qTzh6/2n52CVpbUVIz/o2Q/PRJpLz8LNFzvLXUPKj+byAe+pJpuiM7Us7KXwhkP69otR/JMYOjCIQX0IoRpshWHziIWYDfHVE1zxic08SyVijoPrD6JcLZkcP9YxS7Rk81zBUGyHRdUIV/i6tcWWPsaWdJBiVKmcjjWCF2IyWUTRXTXDLIf5jtOEDtki6mBZZBgpl/+qqMF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xomfh5ZFHrEGyZsh96XbeUOXPkDsY/qljzontcZeG84=;
 b=jW5QE423ZkH7z7dv/KUX/lmMGGyGut0RpRGQMRmE0VWhRaAkhyF2NuQQ3L6FavxgzCTF2FFuh6FL4CtC+MZwyTSdvHiyk4XZUCyav/oxcRyN4pk+tx/EoR9kLRfyD0aJ0sn/AIyRT1vHCQZNR/bssr4jSJfA6NbComnM5Vs+AG0=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 09:10:13 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8445.020; Thu, 20 Feb 2025
 09:10:13 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhu, Jiadong"
 <Jiadong.Zhu@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amd/pm: add support for checking SDMA reset
 capability
Thread-Topic: [PATCH v2 1/2] drm/amd/pm: add support for checking SDMA reset
 capability
Thread-Index: AQHbg3HIfrU/jG8jV0yD3J+gYgk3e7NP420A
Date: Thu, 20 Feb 2025 09:10:13 +0000
Message-ID: <CH3PR12MB807412AB96427A93BAFC6994F6C42@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20250220083053.3834177-1-jesse.zhang@amd.com>
In-Reply-To: <20250220083053.3834177-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=de1d799f-4fca-43a8-b695-d066977cca8e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-20T08:55:30Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB7126:EE_
x-ms-office365-filtering-correlation-id: c4427fb8-ef8e-4740-b9b4-08dd518e6238
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Rbm7M70h7FtnxLWOcW4GW+rv0nmHpDpByeEJX1uI8BTuoLutlQBcxMTXZXFL?=
 =?us-ascii?Q?P12YI2RTAKNhLyHrG/4jO+k+tU6U3QnjMEP67z87bCx2fo+Dxw8ZTju6Pzy6?=
 =?us-ascii?Q?UHdDTuUd8hbpUWOcL4jP46hjrdg4PEslT00EqFCZCsTtegFTLPCrmQdFmD6B?=
 =?us-ascii?Q?eigXNyb5eXmdhPw6Nyu7Dt4mB9wJ3moejoHsxICpWwslZHYTXB4Bf62mfy/Y?=
 =?us-ascii?Q?0OXyNtXul3yTilw+Z1CcN89cqyOsrxYaiTuVedo9XQFCv4jmirY9pBrIxkDF?=
 =?us-ascii?Q?H9U6chdhgAg4XrgMP4TW69g6V3vpcaD1NsPf+um6ZhgGhv5vlbB+8Eu3Yb58?=
 =?us-ascii?Q?Ng5MeoB4WEDJdHkCYOskv+allR4UihSpnRx0DbCZDwbz4wk1+4nZQaG+IZQw?=
 =?us-ascii?Q?Sd/idfBOad0rr3N5LS3IwExVNWb26xSbNWIO770ddGvdAL7Qj02uHKkK8I9f?=
 =?us-ascii?Q?1JHvDEJoeJXTe4X7vS1JwvIaAzQauVmE7qSU8WTfwgQhomuseFYuUmcJHHPA?=
 =?us-ascii?Q?NYOvLpEi6wWje4cdQybjgDbLRQxozWQMEfgGCoKmjBh8m6huT4GFgXFfiC0V?=
 =?us-ascii?Q?nNR+nnOWjJ59dMQd0rWx95ZAxPPYBVcTgyknGsHfguhvnQIYwimoztmf4IUO?=
 =?us-ascii?Q?7ZcjtZnrsicfLmz8jRBh4nGchrropgUrvNrB4dFbEg6YCdzNswdjZN/tPJUK?=
 =?us-ascii?Q?aanKddyPAc/bi49v1q8WmvOJr/uYP2hAOxpVb1j7HTw1b/4ipvWXzMv8k99w?=
 =?us-ascii?Q?rhO+oFYoLPwWo1Gz/6tEMSpvMUikRvuH+D7V3LmSHa3QqWPsjLe7zPRAROSs?=
 =?us-ascii?Q?/3Mpx/WEyA/k43cWOoe2iVIzRC+pu87Lnp1hfliPwb8zFnPHJ6ROuCMnGTbW?=
 =?us-ascii?Q?gqcv8NCfo8V7WLEaAT0fqFbuwTjdmBIXWfsBXm7YLmFALWdXu7yVjO3jjkwd?=
 =?us-ascii?Q?srIoI4pMiPBlb4W/67dg4FwyMBkeNb3iE2bD2ZkF7CiITlEQZ7bRTcIgJKv2?=
 =?us-ascii?Q?vYsBO33Er0mx68aMrZI7GcUI08ORmJi4ysIVxiGTDjvcuylTzdvFJZrYqPP3?=
 =?us-ascii?Q?M3dLeoT4QCDu/SDSlwfMQ5/Qd3Gek3VmwYNqni/KSAz61Sa8LF9Qh+OVZiHq?=
 =?us-ascii?Q?kA9DTkjOyVioP9kYuN9vFt2jf7G68c1aazfAhMgNTQgpyxt6UqfdJweZF62/?=
 =?us-ascii?Q?oa67yqSY9Fqvm38GvHnbG2VqYo7dnHbm2GDK1w8wRwKbR+8nuOIcJy6SPz+X?=
 =?us-ascii?Q?OhnHUUfTL66DCYWhZMLaUL+cNXGLlNkR9OL8Q0VOAjClIxd12DiiteiHXdA4?=
 =?us-ascii?Q?SeI5WO/vM5/6aS0tHDkXWL8i/ujpbaoD/kWY3cX0oiR+jyKSpD+jXZNizfkz?=
 =?us-ascii?Q?e46oLfr7mYr5qEM600qmC4PGtk/OTF5/Atg+zGmshy7gG/gsAoZKKp7ppvNv?=
 =?us-ascii?Q?6dr6u8e/ekvGlmZQiqp0oSInvG+9qJra?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bt3IzYN/IcasPm4lYyke5IDCCGfiKD5224rHgIWdhbjIJMiGYOsNtIhb97v3?=
 =?us-ascii?Q?1IbBaW9V6mee0fuFtqd0V7e27bdUCF7W2RhZdqJ8BvFESWPMAbsUY0U47Eft?=
 =?us-ascii?Q?rGC9L5fNWrYgqOzo8CUkoi3RSCAHm5IQsaI0Xh8A4YBpVtLDw5GWn/gAHpy5?=
 =?us-ascii?Q?9QgPOjCKPwsAeGEWgVVBHux2w3Pxm6ddmTYFi9QyyFnI5AwJXgaMlwo3pmPA?=
 =?us-ascii?Q?kqMH3tlFNdDPF9WpyfoLZ7M2BWLShfWbUk8OsAlbSs54OfL6Q2Y4a7FHo247?=
 =?us-ascii?Q?N0/+EOgWyLCztFYV4ZMrFzLnjhBtV3l8xEgvS+OeEvGdQJy7qnKUVc14WNJX?=
 =?us-ascii?Q?9JHndFOrRF1rjrICMcsYM6Y/pV+Z7Ifl3I5acZWYoM8wu5rBWfd8fkcDDHQ5?=
 =?us-ascii?Q?Fw5Isgz6Xsn3v/vFEjgSZ0eDECCweAN1dMTZUopeSVhQXIqrwW8LvmDj5rap?=
 =?us-ascii?Q?dmXo8uL0VHU9YMVduGQitpGFGL8XyFUiyb+RWugp88bVUhwOiQiYZRn1h9sz?=
 =?us-ascii?Q?SGoqbnf7oeJxOTNoKEW1GKnu3wRUVqgVapm4rw7a2utR7D/Q41gBQ9fFf6aq?=
 =?us-ascii?Q?Fj3WIPa4Kc/YWfwKdMqbT1PmS2f9wvAk54Duq+NLebzb44WXVjKl4KLhJmqI?=
 =?us-ascii?Q?DJj336qXKITJRCG7qaAJ4swdPJgLXJzevBVe13U/kIScFZSsG8Cbf2U2UA8V?=
 =?us-ascii?Q?Lj5ki8PhT1WyBYnJ3d87AhzqgGk6M76JgjrLQ9koxH212Rui5sjAyzlq3lun?=
 =?us-ascii?Q?X1AiIvqPj5Xc2ZcoA9rjFkB+uO6fubLq6CP+Tk5wd1kaxOqbaBrszmNCA6qc?=
 =?us-ascii?Q?Y5EdWEyF+5RJqLGLVgQh0vzQLbrCQaHruN3DfMxHhiMzSTAofvxD+U2Toic6?=
 =?us-ascii?Q?OetyPeSisTPhDUUX01Rd/A+mqCAE49hPfoSWcg7GgGpmyMAXH5QYYoVpKJdH?=
 =?us-ascii?Q?ETb/yJFi/KL6SnL6lMx8Rod63eOkoErLjdR29pEm+3FOpJGBG0ZPNyUnItBn?=
 =?us-ascii?Q?Viy3itYin0Z/Ji4ik6VEXhKp0hwoZnY51cil+E7JOpFhRnwDu3RhjGVYwf0k?=
 =?us-ascii?Q?vleOXgO+Bmtr5Wj3ml6HBt25hmbvTaglKBih89ddfvdGY/l94y6del1YEVmE?=
 =?us-ascii?Q?G4iGgIyzx5ftyrewC4x3hpi5QgplpK6LvXzI3l0e9Em7VsNKoo9a1eunxN1K?=
 =?us-ascii?Q?MhhD/ObcrPSoQmiNQ9mi3F6TB1ru3+nxysG92PC+Bk+wZbilQnG4q6iVf0gq?=
 =?us-ascii?Q?zqIEHOkqc+LhjjgapXcp1i2liiu2+zY5jp+Sc6Lc/xNlZNDKVksBBWJKWb0x?=
 =?us-ascii?Q?8RG//BFZmQendJxTvYnN2th1JPgp6ePwpkdinH+O+1c4kBnFf6oG+F63gehY?=
 =?us-ascii?Q?FHldLj3f4HSoeiBMHSKN2CvoJDcbUcYqNkZmJDNEKjsZvDRECnf6DeSejgtJ?=
 =?us-ascii?Q?Q/uhdNdp/EyMMCPoTOADwC0Oqyd5I63xzP+r35w6Um2DHKywztKBKnH3l2/M?=
 =?us-ascii?Q?opTwFYUZN+22BGYEPfQyO72dN1vrEseQqELRuxdQKSAfcxPWhGC5XoMv1n3i?=
 =?us-ascii?Q?rs1b7ZNqvwTO+iF1aks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4427fb8-ef8e-4740-b9b4-08dd518e6238
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 09:10:13.1372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMOkj4av74u977yjlPpAcE8FXzEHKTGI9l41xoZRyY2LOa56qq9taRJCohKS0VVFd2H0oapSjd+bFmZNAR7qrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126
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

Hi Jesse,

> -----Original Message-----
> From: jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Thursday, February 20, 2025 4:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, Jiadong
> <Jiadong.Zhu@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Prosyak, Vitaly
> <Vitaly.Prosyak@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH v2 1/2] drm/amd/pm: add support for checking SDMA reset
> capability
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch introduces a new function to check if the SMU supports resetti=
ng
> the SDMA engine.
> This capability check ensures that the driver does not attempt to reset t=
he
> SDMA engine on hardware that does not support it.
>
> The following changes are included:
> - New function `amdgpu_dpm_reset_sdma_is_supported` to check SDMA
> reset
>   support at the AMDGPU driver level.
> - New function `smu_reset_sdma_is_supported` to check SDMA reset support
>   at the SMU level.
> - Implementation of `smu_v13_0_6_reset_sdma_is_supported` for the
> specific
>   SMU version v13.0.6.
> - Updated `smu_v13_0_6_reset_sdma` to use the new capability check
> before
>   attempting to reset the SDMA engine.
>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 23
> +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 17
> ++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5
> ++++  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23
> ++++++++++++++++++-
>  5 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index faae9bf48aa4..26209d5ff787 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -722,6 +722,29 @@ int amdgpu_dpm_send_rma_reason(struct
> amdgpu_device *adev)
>       return ret;
>  }
>
> +/**
> + * amdgpu_dpm_reset_sdma_is_supported - Check if SDMA reset is
> +supported
> + * @adev: amdgpu_device pointer
> + *
> + * This function checks if the SMU supports resetting the SDMA engine.
> + * It returns -EOPNOTSUPP if the hardware does not support software SMU
> +or
> + * if the feature is not supported.
> + */
> +int amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev) {
> +     struct smu_context *smu =3D adev->powerplay.pp_handle;
> +     int ret;
> +
> +     if (!is_support_sw_smu(adev))
> +             return -EOPNOTSUPP;


We may need to carefully set the return type and return value for this func=
tion, as it is used in your patch 2/2 like this:
            if ((adev->gfx.mec_fw_version >=3D 0xb0) &&amdgpu_dpm_reset_sdm=
a_is_supported(adev))
> +
> +     mutex_lock(&adev->pm.mutex);
> +     ret =3D smu_reset_sdma_is_supported(smu);
> +     mutex_unlock(&adev->pm.mutex);
> +
> +     return ret;
> +}
> +
>  int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t
> inst_mask)  {
>       struct smu_context *smu =3D adev->powerplay.pp_handle; diff --git
> a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 1f5ac7e0230d..353a10119dc5 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -603,5 +603,6 @@ int amdgpu_dpm_set_pm_policy(struct
> amdgpu_device *adev, int policy_type,  ssize_t
> amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
>                                     enum pp_pm_policy p_type, char *buf);=
  int
> amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
> +int amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 0b32c6cf6924..f860590ef893 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3907,6 +3907,23 @@ int smu_send_rma_reason(struct smu_context
> *smu)
>       return ret;
>  }
>
> +/**
> + * smu_reset_sdma_is_supported - Check if SDMA reset is supported by
> +SMU
> + * @smu: smu_context pointer
> + *
> + * This function checks if the SMU supports resetting the SDMA engine.
> + * It returns 0 if supported, -EOPNOTSUPP otherwise.
> + */
> +int smu_reset_sdma_is_supported(struct smu_context *smu) {
> +     int ret =3D 0;
> +
> +     if (smu->ppt_funcs && smu->ppt_funcs->reset_sdma_is_supported)
> +             ret =3D smu->ppt_funcs->reset_sdma_is_supported(smu);
> +
> +     return ret;
> +}
> +
>  int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)  {
>       int ret =3D 0;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 3630593bce61..090a2b3b81a0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1376,6 +1376,10 @@ struct pptable_funcs {
>        * @reset_sdma: message SMU to soft reset sdma instance.
>        */
>       int (*reset_sdma)(struct smu_context *smu, uint32_t inst_mask);
> +     /**
> +      * @reset_sdma_is_supported: Check if support resets the SDMA
> engine.
> +      */
> +     int (*reset_sdma_is_supported)(struct smu_context *smu);
>
>       /**
>        * @get_ecc_table:  message SMU to get ECC INFO table.
> @@ -1637,6 +1641,7 @@ int smu_send_hbm_bad_pages_num(struct
> smu_context *smu, uint32_t size);  int
> smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
> int smu_send_rma_reason(struct smu_context *smu);  int
> smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
> +int smu_reset_sdma_is_supported(struct smu_context *smu);
>  int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy
> p_type,
>                     int level);
>  ssize_t smu_get_pm_policy_info(struct smu_context *smu, diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 9f2de69f53b2..a200ac7b15a8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2902,11 +2902,31 @@ static int
> smu_v13_0_6_send_rma_reason(struct smu_context *smu)
>       return ret;
>  }
>
> +/**
> + * smu_v13_0_6_reset_sdma_is_supported - Check if SDMA reset is
> +supported
> + * @smu: smu_context pointer
> + *
> + * This function checks if the SMU supports resetting the SDMA engine.
> + * It returns -EOPNOTSUPP if the capability is not supported.
> + */
> +static int smu_v13_0_6_reset_sdma_is_supported(struct smu_context
> *smu)
> +{
> +     int ret =3D 0;
> +
> +     if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET))) {
> +             dev_info(smu->adev->dev,
> +                     "SDMA reset capability is not supported\n");
> +             ret =3D EOPNOTSUPP;

Need to set the return value consistence with the return of amdgpu_dpm_rese=
t_sdma_is_supported if not supported.

Tim
> +     }
> +
> +     return ret;
> +}
> +
>  static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t
> inst_mask)  {
>       int ret =3D 0;
>
> -     if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)))
> +     if (smu_v13_0_6_reset_sdma_is_supported(smu))
>               return -EOPNOTSUPP;
>
>       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> @@ -3590,6 +3610,7 @@ static const struct pptable_funcs
> smu_v13_0_6_ppt_funcs =3D {
>       .send_hbm_bad_pages_num =3D
> smu_v13_0_6_smu_send_hbm_bad_page_num,
>       .send_rma_reason =3D smu_v13_0_6_send_rma_reason,
>       .reset_sdma =3D smu_v13_0_6_reset_sdma,
> +     .reset_sdma_is_supported =3D smu_v13_0_6_reset_sdma_is_supported,
>  };
>
>  void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
> --
> 2.25.1

