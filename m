Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989E6C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 03:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F39910F121;
	Fri, 12 Apr 2024 03:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aoD+8cjJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F45F10EFFB
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 03:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtTNhEVw8sWnCTwA8iI9FYaKXQ6cS0Yh/m5XpEXacaU5+TEFylrs+5Bhytck8BJ983Bq6h0w0OOW3Nlo7Rpe13/LtoDDL/moPqypQh70JQT5Zk5KsW3B4ALD5QKueZTTCifiLKM92+LPyPATEp57QnwOACNrWLDZeHK/IYuP8yFigwK9gziuEtZxX78uRxMvuHe/JvERRltyLAjQKbZy9SDGlaN0Kp0DasQvZXLiq9xNrp5VOR43AUc2I8Ntf2qfXRc52rcDusdUWU5fk2alNUu+e/iSCI9V6BlUD7UsAEdb5vfxf97W0nWngyztO6jFe0BCtlKxlXA1+TRfY9uRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zdssY2HAIZUO9KMHX6laZ3nYBunaSh7RYIRVnvHYcw=;
 b=Rb1xL7e6jfkbTj/xqAajJuCZcMXTIyJOmEpHa/5ALQrq7TGOKJ8R2FdOzbkMQ5kvQC2KgwrIHN9J9ebKSJ/Ikwx6GHw7UEOVMeGQ7c7FKJ0zlDodL78ajBkA3igTSOQa34Bia7vwGX4JYJmEQoYzoKG3YMcasm5WpJmOdOFacOEwTdhfppxGjjfqmAVP9I1GFDiSonCWvI5clfewtxfpCdqY2uf2PC5bshM0qCWDzme7QF3efmtA+3z+6Kj7LSqUv0Uj3GJhkNm7iiZOlxwGV6XWeiwgK7WIFXSqOMkMuZx8MI+kZVm5fzhR9/H0YfO/4QOnnEk9Hsk2OwoeTPusUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zdssY2HAIZUO9KMHX6laZ3nYBunaSh7RYIRVnvHYcw=;
 b=aoD+8cjJPa31e+qbtDh+gb9iUd/iSg0sVJy4l23UROgWntoHMDzqX5juEwB2fs+1JgEPKnueqjDnl2Aq+CG4h6wSi1JgJm0KUby/PV6JoZmsCDq/pNc+7mfbHr/yFLIGcKVXzDAlgCBuaIRTHN0MkgSo/4DsMvBI5xaJRueButo=
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 03:40:16 +0000
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::b53f:d6e4:65c:7e73]) by SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::b53f:d6e4:65c:7e73%5]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 03:40:16 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add new aca smu callback func
 parse_error_code{}
Thread-Topic: [PATCH] drm/amdgpu: add new aca smu callback func
 parse_error_code{}
Thread-Index: AQHajIVhW64LsKm19Eu7GffcUNNsgLFj/Suw
Date: Fri, 12 Apr 2024 03:40:16 +0000
Message-ID: <SJ2PR12MB88073B77C4BD44AFCAA02960B0042@SJ2PR12MB8807.namprd12.prod.outlook.com>
References: <20240412025413.2957312-1-kevinyang.wang@amd.com>
In-Reply-To: <20240412025413.2957312-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=86729f96-cc17-48ce-8268-2782110d9da7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-12T03:40:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8807:EE_|SN7PR12MB7419:EE_
x-ms-office365-filtering-correlation-id: 4d1d6091-e814-43c8-d132-08dc5aa244d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8a0omHqqkXNP0c1RvrXM7G7ElAzxtpS6STiGLFo4JnpLvyQ5OJUAoYN0JZTBtGUy+9TUSgi5IDzFt/OKBcVfWUWRRwI88zDsFBCjTPjz2hnfy66IiGA9lbKTznPOmSH6DpXe7FCsTMXSL5ZQW6QChXybboZUf79oSDdTunNDJeXZqpF9vZqC9IRkQX1cRIGAnNE3mFSL2dJnUzi9PlAi2pk+tVfrGmeGe9Ek7R2H+5Bluqlfk7QBXL2YK00T0Q9WwFRkD2m15Bn3DrkrfAg2mVqocbj3Ij7kHADifkRCM6iEvK6YLqtW7wRoeXs+GMRMcSeFDCGnABqGY24V19Eo814OiSEo3V0vcSOI3xXit7mS4elbV7vC+BRv11fUveP6ykmv99u9CoDLat/FRhboFr2ltfQik/91CYoPSoLfQWNWlIPnkdcwnpp+A3uVQmObtWrtsPf9l5sBXAMWu7iuvwVdYWMSMDzcD3H5sG/2pBOm6fi+XjTy0YwdrM/1Eih7K+ONUVODWYMDm5jL+rXIXOm9hDTHT9BTssAk8v4L4Vt0HlxvApzTSWWadqRCTRxVSPm+Ii5EbWbGkkvXKDY6+9G4JBXbK193JJFEIrQRIRQ2QfqNj3Q46S69JK1nlCLMKBd6mKcMpLkbv1MSwohymMUYRdR/ODCB233BWoi9nKK2dH5iQYt9aD1B+tXV9kru7j3vhvtrPNP+YKBXHq48mg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LETHTxKY6r/ZtgdiCmUQccG3T5ktG8+WErqn10K+66M3yhakX3Er0fsLDEYB?=
 =?us-ascii?Q?taztD0o/noI3r4VgdKd2uhn6LMk9PTFDIVAFaemmpkns2gJl/Ve1O1kcr1eK?=
 =?us-ascii?Q?NK+2AVjIiI/nMOziW87T/jcQBHGJR/9/ka8BoAp/vJE6IMOX+Q5Eeo0Q3mMd?=
 =?us-ascii?Q?rtAgPtPOKnzcv4dUwmpBS/f39KuY0kGpsVwptky558Mab6MpxlHGTYMs1F8F?=
 =?us-ascii?Q?N5SIoRiSV1ODb+j1WKmTUPx0GQXe9WasGVeF7J0rSk+Y60tda6z4r3Amk+3s?=
 =?us-ascii?Q?RxLc19bFWlYd9gvqTH1k/EbTzfl8BnoFaBYLpgXCEr+0e/zgrGdHHusNy9qS?=
 =?us-ascii?Q?yJNHwix1I518XJ912keoP462t8rsFkWbo7AeWX6ec1QF9FJOGbQZC7Ah4cti?=
 =?us-ascii?Q?TOd1Qe5t2EfU0mMr2ZQMujLcjuoPhhk/uuyBF+5MqHQsG/jLwQYPLckiLW3J?=
 =?us-ascii?Q?EtUwTv52aCILjXKEYRtRw6y4ZiktCnA3JMwHA3dy9tZnIkenJpCQSieSTpBS?=
 =?us-ascii?Q?NGIoufIHzIt86zewItwl5CnejPm5CgEmeWX1YJQQWOpLfAmevWQkxRwY0qOh?=
 =?us-ascii?Q?FKsEHrTHnKB41/0B1HHUHy2ESSNd27P7SETdJcFyzUtUWH+41SDwxY9s6laP?=
 =?us-ascii?Q?0f5UDK34aVe4hlc0nuHz9NSJLwhmxyx4+seH1q5pnq4o+T/h/3f6rc/7iWPM?=
 =?us-ascii?Q?oi6AG4WiSMi0Je61m1nybYA6Gf2VbOaP32bcDNFL9I6X4pWx8yPbrdLcpz8x?=
 =?us-ascii?Q?x3hEDCCi+CAktuIxa28ft/pyjgJT0L7dT4FV2VKMQnFSlHwqgUivsf6zUY7D?=
 =?us-ascii?Q?h0XVZbWJUXyoO+NS/cd7a3CNUr+D19kKBmk7xztRUtmX9GV3PE2xWsSD/5Ix?=
 =?us-ascii?Q?Y30Ry7JEeJWj1ootQaR8S7l4FPv+1Lhh96HVQXBg8uXFHrVxMBKi5DK10AOh?=
 =?us-ascii?Q?tSS26j4Z8MKjETPsvhhNdhvNvn49AqTDH2Oqkvi7fB9DFFHNYMzi6Lsnw/a5?=
 =?us-ascii?Q?8IMoedAo6ptz2a4+KDSV9pDZNnl6dLo9ZcoKE4//0XBno40Q3T/blxd4QSpZ?=
 =?us-ascii?Q?rpy4gRslEEEyskE4zzyy913mF59fB15gtilQKuDWp3gv6IsqEbMqHUil4v+N?=
 =?us-ascii?Q?Yqq11GtVX2CmkCXW7xAvZMApy677W+Cx89Clu1yPcJUlzi7nFGjKHB39I9Xz?=
 =?us-ascii?Q?j2lD3/qIZpX4/xxGkghGFt/wPHwJq5f8UYBTw1m+/iTplalO/wD4xpPXcWSW?=
 =?us-ascii?Q?VzhRuXfDyYFEtqsWgZOviRsOhd++/sYUyyro5mibeXldPDD1Og+NqsO5+dkW?=
 =?us-ascii?Q?X/QJfQowZspQoX1uvVFM+Sqid3GYCF6g9mBI1hM9PYQaSURkDyFyZ+NBMT2q?=
 =?us-ascii?Q?FwAdL8xubEB9hj0qkWZDo4zDMkOBp/ziFwf/tVlnaf8w6fn9YJDX+A/UfA3j?=
 =?us-ascii?Q?HMzAudijiCw2a3o5zV0LHXqkkDoUGFNQ+Jy/xBt/o5Z5wiizyG+PWNuo3PGv?=
 =?us-ascii?Q?3I54Lkk40oW4eMdwEi1Ip8FQBiWrIu/yk4wRTZbBfaV7lj2ajN/2s/N0Cr1H?=
 =?us-ascii?Q?kTbcW5X5uDIcaOsGVAw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1d6091-e814-43c8-d132-08dc5aa244d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 03:40:16.4942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJJ70/f7gnbZ4V/Uo60eCdf+2fGcMTt9kjPw0FXAsBSzj6tVbVg7Zw5iTUVBIWEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang
> Wang
> Sent: Friday, April 12, 2024 10:54 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: [PATCH] drm/amdgpu: add new aca smu callback func
> parse_error_code{}
>
> add new aca smu callback parse_error_code{} to avoid specific asic check =
in
> amdgpu_aca.c file
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c       | 23 +++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h       |  1 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 13 +++++++++++
>  3 files changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> index cb6a40a042e1..d1059e4d54d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -753,23 +753,13 @@ int aca_bank_info_decode(struct aca_bank *bank,
> struct aca_bank_info *info)
>
>  static int aca_bank_get_error_code(struct amdgpu_device *adev, struct
> aca_bank *bank)  {
> -     int error_code;
> -
> -     switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> -     case IP_VERSION(13, 0, 6):
> -             if (!(adev->flags & AMD_IS_APU) && adev->pm.fw_version >=3D
> 0x00555600) {
> -                     error_code =3D
> ACA_REG__SYND__ERRORINFORMATION(bank->regs[ACA_REG_IDX_SYND]);
> -                     return error_code & 0xff;
> -             }
> -             break;
> -     default:
> -             break;
> -     }
> +     struct amdgpu_aca *aca =3D &adev->aca;
> +     const struct aca_smu_funcs *smu_funcs =3D aca->smu_funcs;
>
> -     /* NOTE: the true error code is encoded in status.errorcode[0:7] */
> -     error_code =3D ACA_REG__STATUS__ERRORCODE(bank-
> >regs[ACA_REG_IDX_STATUS]);
> +     if (!smu_funcs || !smu_funcs->parse_error_code)
> +             return -EOPNOTSUPP;
>
> -     return error_code & 0xff;
> +     return smu_funcs->parse_error_code(adev, bank);
>  }
>
>  int aca_bank_check_error_codes(struct amdgpu_device *adev, struct aca_ba=
nk
> *bank, int *err_codes, int size) @@ -780,6 +770,9 @@ int
> aca_bank_check_error_codes(struct amdgpu_device *adev, struct aca_bank
> *bank
>               return -EINVAL;
>
>       error_code =3D aca_bank_get_error_code(adev, bank);
> +     if (error_code < 0)
> +             return error_code;
> +
>       for (i =3D 0; i < size; i++) {
>               if (err_codes[i] =3D=3D error_code)
>                       return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> index 3765843ea648..5ef6b745f222 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> @@ -173,6 +173,7 @@ struct aca_smu_funcs {
>       int (*set_debug_mode)(struct amdgpu_device *adev, bool enable);
>       int (*get_valid_aca_count)(struct amdgpu_device *adev, enum
> aca_smu_type type, u32 *count);
>       int (*get_valid_aca_bank)(struct amdgpu_device *adev, enum
> aca_smu_type type, int idx, struct aca_bank *bank);
> +     int (*parse_error_code)(struct amdgpu_device *adev, struct aca_bank
> +*bank);
>  };
>
>  struct amdgpu_aca {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index d6d5be26e222..59e5c6256ea2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -3119,12 +3119,25 @@ static int aca_smu_get_valid_aca_bank(struct
> amdgpu_device *adev,
>       return 0;
>  }
>
> +static int aca_smu_parse_error_code(struct amdgpu_device *adev, struct
> +aca_bank *bank) {
> +     int error_code;
> +
> +     if (!(adev->flags & AMD_IS_APU) && adev->pm.fw_version >=3D
> 0x00555600)
> +             error_code =3D ACA_REG__SYND__ERRORINFORMATION(bank-
> >regs[ACA_REG_IDX_SYND]);
> +     else
> +             error_code =3D
> +ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_REG_IDX_STATUS]);
> +
> +     return error_code & 0xff;
> +}
> +
>  static const struct aca_smu_funcs smu_v13_0_6_aca_smu_funcs =3D {
>       .max_ue_bank_count =3D 12,
>       .max_ce_bank_count =3D 12,
>       .set_debug_mode =3D aca_smu_set_debug_mode,
>       .get_valid_aca_count =3D aca_smu_get_valid_aca_count,
>       .get_valid_aca_bank =3D aca_smu_get_valid_aca_bank,
> +     .parse_error_code =3D aca_smu_parse_error_code,
>  };
>
>  static int smu_v13_0_6_select_xgmi_plpd_policy(struct smu_context *smu,
> --
> 2.34.1

