Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DC9C54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 06:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82079112332;
	Thu, 28 Mar 2024 06:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hjJWi2Bt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F093112331
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 06:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN8bgA/01dt8BOjVhkcfrDgibfog5AQE12wFw1qF5/Ab6SPj7tPefLynq9IyIM6lsbJx6OhyyIPulUpBVQnebPog7GnJbKUFfLbJ4tLCt0M6ol3IAdi8vRBcNgCGdlGtUDT3KyNb8+cNyvUKl5cPk7eZooensq0Qs0xsyO+MCTsYAR5d1EAl5NSS7D0ptCn9xXNn2HUPv+hV+fi+cEd5RPw5czxdkosmNXP4f71bqz1Ak3v8tRfeBTNa3ZweqeB+AiQLefWNjNqkOvLWZ/BKvC/zfQIxOehauOKI2wlnXkwDr3mgi3spIjGnxpgv/nExox3w2ZoVnCB6htcuIQn7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I80gyOxqUvu5U1KVaDwM9yjgFmDU3+jqXuVD6YcYh8=;
 b=Fo7Cruu0s+KN4TR/F+yUoaAPEe84VdD5mY8dfcpYZ/nIRMHFFGhlXdhFMBbBZM2S4oU1sLWGRV6Sz5RL372Kdsptza2q13YJCS9Q/23uWg59MpEQpDCdFNCN/0msItXCMPdqFLwPmuwbn3xDu1dY8QH0rhcCbiLhg8aiJflv2u6tcWWKAbx6GXSZe+PQpGtOi1MZ9e8dPFNjth44WD5umztDjDG3Dww/D0DSKevLl5zs1nniCcaJ30nuWvEnojQ6uy67lwHmI6tiq04LAwXjQZcoDrlg/ceWNK58ETN5847JnM4kFgt9PxnjeodfsBMDnHGOkR+8ojF5o2HbwwqkvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I80gyOxqUvu5U1KVaDwM9yjgFmDU3+jqXuVD6YcYh8=;
 b=hjJWi2BtjTj3ElYdYKEi+fVEPf7SUMW1Soh/Va/lgY8GZBMf19OtW5RqsKrKIEcc6hMG+BQqUf2++P9AGJLBs6OJg3wr8YedVz5aDEqDTv2jvkoOSoqTYsKogkyh8z0XLTR4/GqUWpObZdkjMFPhEGRCP5oJBpgnLaHUtndttFI=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 06:25:26 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 06:25:26 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refine function signature of
 amdgpu_aca_get_error_data()
Thread-Topic: [PATCH] drm/amdgpu: refine function signature of
 amdgpu_aca_get_error_data()
Thread-Index: AQHagNRJ6qmBtnRGX0yS0f6efh3w9rFMrv/w
Date: Thu, 28 Mar 2024 06:25:26 +0000
Message-ID: <PH7PR12MB87963821F67C6D7013124876B03B2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240328055314.326165-1-kevinyang.wang@amd.com>
In-Reply-To: <20240328055314.326165-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=94b7b001-5f04-437b-97a1-a9e5e6f5f195;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-28T06:22:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA0PR12MB8326:EE_
x-ms-office365-filtering-correlation-id: 75dcbbee-80df-4841-8b4a-08dc4eefdb40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OmWfv6EiysV2ZN/eDSvQPVWLwIIMKYBclRwj6uOeD1c+khVZ+mEJdHr2lZgztcM01ApM0pQCi9lXON2+s+p1/3sWeFDwURE7qOQDKcaAOM33V4EA2Kdtixq27aXX0oYSnp1hOFoZ3wIQVLg/oGgX1FmCHuNYfO5d7OvJ9uOpAeMBTWParU+N7A9gXhKVSzyx2Jd+lrUPsVmzhvcxP1+b3fyQi+wahgC1HKg5I/c9md8tkMaL4yLVmlbALekA6FkqvANyCrQvVC+uMDMOuZq4yU2QtGkewmsveLn7d4fN8NSuZ623VUQZxho4fm5xU3xFn6PqdFCUaywTBi+9xqiEGRl5MjQrSahe7ZhhPJLf0v34Oo16cx2jS6FiFMJpJVvJotVLNItn9Z2MtAWxZsYezuz/3hAX8wDNMe1C/CT7E0v+mm2DEFMlMX7yWA59GmM4TyhmE6TCe432M0g7HrFbh9PJRwrshSvlW5tzbvF2CnfDkuqmLrSfB4vT2ajlj/yhkvV0fiq/M1MVL3fsuxKoK1VWuJYToVBT294CnzyocDKJCbnSA9f9mvS74j3Po7d0ntwrt34OhAk6tQja13x8HqiegE6j9wWOmviTUTZS18O2SQnA7bb+G/r6OPZqAmpqBCeyEBrUygbSc2d0jbQs55n4U1gQpmy89c21ax7W5aGnfVzrMgVzlrpUOWbXHSrBjJqYg3DmZkervJoc5Yl1MzMyYdXl+LdQhVCPERMP0JU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V9PDGJspKhOlMasL1f12IO2ACJn9XIx4+iVtxzItyrapWiXPf444j/pdDMve?=
 =?us-ascii?Q?brUbjJvLXqxtv3sRtsXMrYcomsJQbS10Jok0yghexayUuYnk0RnTdPxia+KQ?=
 =?us-ascii?Q?6hsWNAFogqRqpRgH4yArjj139TevAzpNuFPkVatx36onebHFG3oVVhjbEAGt?=
 =?us-ascii?Q?64E7ZpUnsOL+W9OVXw45WQK6465sKtSooCbdynhD4mc+CRNJH5OeDrZU8Tje?=
 =?us-ascii?Q?VsFDdeaXmzvemZIBjrYL1tTeUMQ8MAAlipW1JFL4wbG6kV5WMUdrUqQc/cjB?=
 =?us-ascii?Q?yiFcRd4udASxrS++2hPKXUm4M6zJtnsnhVHsj8I+mnZHqEkSdhWN6kp/woTn?=
 =?us-ascii?Q?qJIDbYJuZCBwSbYtrUHLq+VqxmxLjBw8F1yzcjsT0NEtr4Ram1Vzu6fxuUSZ?=
 =?us-ascii?Q?XOPRqupOVq8J7Lq/9boJTf/cQxsK/xWZyhShzRaBgEcyjzoKZMhccdXrZmZM?=
 =?us-ascii?Q?y4zBnpR5uy15Fuuem588mN7JjS+5hVtfgfdosjOJNwNJFjsHfIRfVD83Elf/?=
 =?us-ascii?Q?U8/QIZtfRwskKSpMJHRfHKwz4ifV0Y0w/LHJHP3aBW/6WHEvj898iiKaljCr?=
 =?us-ascii?Q?mGtE7zR2+svOsFGqUZTVZOJ/GohnatZZh9v2yG4L816FkVBy7B4PNKDxG/rn?=
 =?us-ascii?Q?tGlsCydUa1YRjgVndYSXBx4nEkuqBXkR/zROhe5I0zibAs5sO4rcplNOvn+b?=
 =?us-ascii?Q?4VeTjNHlzFYEEOr1IcK41EyR8J4WDpANLlmvIdNmXFEcXZxhke/AQjfBWrnv?=
 =?us-ascii?Q?xn7siMCmF+jGHz3QVp2mOjqoWcK0cElBMcWgBacnSyQgDP7TWv60I4mC6ygS?=
 =?us-ascii?Q?aKsCc8fT48NAuxpx+nlrw7/rxCebMUWEE2zPfSJ4+aqgL2NuL9IigZq0wEcj?=
 =?us-ascii?Q?30Q1UQ8NwJiwmjhU0EXSq410fUT06grPDe2Na067wscdf2lQgrITFyGp9iYQ?=
 =?us-ascii?Q?jHIEJcZB7O/Y6rJfRC7ZGlxAGm1wnYX4d70/sbevXu4WOSGOiTziwxnlN74g?=
 =?us-ascii?Q?yeGz1bmF0J4tsNZmooAyQck66d5yKa26i/VlmtCgWNHmW8kfk1JIdAzFPYEY?=
 =?us-ascii?Q?IzZTVD0IMi9EirUOT/uabNKs7eUkm6iFb29umtezglsEsdaFWO3G2cxFNgDp?=
 =?us-ascii?Q?j5DKSksX1Z1it4S2dR9FbSOYRCuQj6jyRSQ+f5V0UXeJNYwM4X/T5vv25gp6?=
 =?us-ascii?Q?AlE/5sJJ2eZzsTU1eTu0cnv7Qgjp4CrMXu1Cp8dwlbKfxXwctcclmcM59zv8?=
 =?us-ascii?Q?B+W+O5CLx2ASM34EobeCQ8Bm30i5faMdbXL+v6HLD7u7+NP90BfiKJ5krcsi?=
 =?us-ascii?Q?TqRxM99UgO+Yi3lFiIpyPSHgnDEoemyIZl9Psat3Xn1sJ5mBiwfhEczGL6C+?=
 =?us-ascii?Q?feoV84XvHXFUkp9DHVN46GwUMuhjVHfS5YJlw4Gvbt4cSn9znp+Luy6JBGpQ?=
 =?us-ascii?Q?rLT/bLbHf1CSKRVKxsbYBR8Dnzx7iTi+g2CJDuCJSOLZNItNX8TeehwZFD14?=
 =?us-ascii?Q?B+iRcDDQKnV89ruDAaFvg7Mb/uszRZ8LIimGpCjsPhVsa0G+M0m9oKVRTvSd?=
 =?us-ascii?Q?7H2q+OMK4NwpIZ2XniA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dcbbee-80df-4841-8b4a-08dc4eefdb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 06:25:26.1986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJaslQonNpWoQc3Ajr/Lc5JDiB7rtycR+LnC+fwQJ2j/C9Mn9clEHItBHw9lDkCi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
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

I think argument is more proper than signature here, with this fixed, the p=
atch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang
> Wang
> Sent: Thursday, March 28, 2024 1:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>
> Subject: [PATCH] drm/amdgpu: refine function signature of
> amdgpu_aca_get_error_data()
>
> refine function signature of amdgpu_aca_get_error_data();
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 8 +++-----
> drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h | 6 +++++-
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> index 920ddbb35c3d..cb6a40a042e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -525,10 +525,9 @@ static bool aca_handle_is_valid(struct aca_handle
> *handle)  }
>
>  int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_han=
dle
> *handle,
> -                           enum aca_error_type type, void *data, void *q=
ctx)
> +                           enum aca_error_type type, struct ras_err_data
> *err_data,
> +                           struct ras_query_context *qctx)
>  {
> -     struct ras_err_data *err_data =3D (struct ras_err_data *)data;
> -
>       if (!handle || !err_data)
>               return -EINVAL;
>
> @@ -538,8 +537,7 @@ int amdgpu_aca_get_error_data(struct amdgpu_device
> *adev, struct aca_handle *han
>       if (!(BIT(type) & handle->mask))
>               return  0;
>
> -     return __aca_get_error_data(adev, handle, type, err_data,
> -                                 (struct ras_query_context *)qctx);
> +     return __aca_get_error_data(adev, handle, type, err_data, qctx);
>  }
>
>  static void aca_error_init(struct aca_error *aerr, enum aca_error_type t=
ype) diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> index 247968d6a925..3765843ea648 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> @@ -26,6 +26,9 @@
>
>  #include <linux/list.h>
>
> +struct ras_err_data;
> +struct ras_query_context;
> +
>  #define ACA_MAX_REGS_COUNT   (16)
>
>  #define ACA_REG_FIELD(x, h, l)                       (((x) & GENMASK_ULL=
(h, l)) >>
> l)
> @@ -198,7 +201,8 @@ int amdgpu_aca_add_handle(struct amdgpu_device
> *adev, struct aca_handle *handle,
>                         const char *name, const struct aca_info *aca_info=
, void
> *data);  void amdgpu_aca_remove_handle(struct aca_handle *handle);  int
> amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle
> *handle,
> -                           enum aca_error_type type, void *data, void *q=
ctx);
> +                           enum aca_error_type type, struct ras_err_data
> *err_data,
> +                           struct ras_query_context *qctx);
>  int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);
> void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentr=
y
> *root);  int aca_error_cache_log_bank_error(struct aca_handle *handle, st=
ruct
> aca_bank_info *info,
> --
> 2.34.1

