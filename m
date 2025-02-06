Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085DCC02198
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 23:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADBEA10E9A0;
	Thu,  6 Feb 2025 23:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HRbL9VWC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1579310E0B0
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 23:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nV6NMFxg5+DuWM9FxhMbX50hXCY4pk9MYrx5fQQp1xXXzSZgw6x9f77zxce0LK+Z+5plaodDRtvyYURVSwGK0rdP6E6DwFWFDe1zU0MmyNM4nn3TBQUMIOpcFTEaVGAx9w4pGgykcA/4KKpGT44S8cQxgOJ99Os1uOuR0C2An2JixPGLS2AdwmC3R4njeTJ9NQ4M/jvtLNfgiTGNeoyAo85TLtEXsoyOZ7PHO1u1GZ5jgouXGG8Mwzgp9Jd+02xIAJLh81UPHA4D+LpNEEPRoswEktxOkB9RYI0X5issjkAZamLLJ9nz6+tJAwwk0vPfIAXF4ntPGl4lneHVfFtiDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtfIyIfi/5l0RX9c2kmuwt/h0ERuZUa/fGGfWnE/4kE=;
 b=p3aa2oyNXQnTy76E39yLoFF0tRT2iNSRquHVoySqDMqu7H22HDy51hBCFu3BRVbSxB3XkHc2XGRPUGfueF3n70BkMbeY0gcbqFJ8u2dCU1FrkrXLM1c7fWeg/y34sBe+ldRanHPCInsyEhWJ1979v/2//g+IJC7KFtqJGHQkaDpuEZwEYhB9IYvHZOKtVn6vx/MJEuYQxH7S3/I1h14Zp/3fsFcyxDLtDwdpcymp2yEW/3Uqkrz29n8PRr1uE3/I1mZfMzjdRWeuFLEIXwN2n2Z7suRYoAF14w7iT2XJmJ7yUxZjreyeqkFXWBYsWgyVW+c3GBHrEtyBiV5OgcRn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtfIyIfi/5l0RX9c2kmuwt/h0ERuZUa/fGGfWnE/4kE=;
 b=HRbL9VWCutrvlDExk6wRvOhiXKWi5a5Lp88Xqy/gwdQ9IhCRyxDj4A8NxuEVnuBk7z8+CdDlZd328CJkCtIaYtvQ3MLBppUUJWEpPhBG4vFKnai1M6koHXI9q6FgbsY81GyjIYR0ESjdqHz4NG3Jqis/xDHOiJ5SiExb+VLgt1w=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Thu, 6 Feb
 2025 23:33:11 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 23:33:11 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Topic: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Index: AQHbeJjnBkTSX11A7kaLj0Yc6dV7/bM66/vQ
Date: Thu, 6 Feb 2025 23:33:11 +0000
Message-ID: <CY8PR12MB743505FC4310A69D4B2C372685F62@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-3-lijo.lazar@amd.com>
In-Reply-To: <20250206131258.1970391-3-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=5815d434-f1ef-48ba-8305-1769026f7319;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-06T23:27:04Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ2PR12MB9244:EE_
x-ms-office365-filtering-correlation-id: 5e87b60a-4a50-4040-3aa4-08dd47069edb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SZ8ENsPapOzXd3HmuplruR3CfBQftJkF/kACNxQ3o9pr/VM7OVhgd5+MshY0?=
 =?us-ascii?Q?YIWF5uBOMlFDZVOdYeDzLitvh6z9KW8+BzSxpAqHCSp4HaLtkhb9cGF5tG0Q?=
 =?us-ascii?Q?qFrjQTzbI2SLhryRN6WwNccLV/SC9tRNrFYvxLelbwxYnakc1N0xO+oOCnwn?=
 =?us-ascii?Q?gdNfJh58VhTeWFzgqe+qtHdcd4UDQUkXXqhvgyMg92tWbEUpQMzUeVPj7Ygb?=
 =?us-ascii?Q?dBVj/1PFfa40yQKPgp8/FxJsPqfF6MVgPtBS5jUCAF3FYh66dNK7Ot4UdY6u?=
 =?us-ascii?Q?kiZvlLEZF+m/XMbLJ6oQBBKuT5S8S40IiSaiAs2Eyujir5wI8O9aUAcP31A5?=
 =?us-ascii?Q?3TutcCTncPBStbZUrrziltPG8cY++AuFfSxEcglAl9rAbfQLG9LqRyuBJlW7?=
 =?us-ascii?Q?utjgYnggz4zgifE4FgoOTOFzXD0Qi3N+TP2V+3XYBTyx+cTxizpbR/jhYGlP?=
 =?us-ascii?Q?X0grm/spj3y01C+SM3Ffe9bUj8z8FzPPitrNfKm8fmfIoe3LE3K0wUGej+eG?=
 =?us-ascii?Q?8nVU5M5jCEK78sSQOvR7QXERPT6LAI7G3gNVFX8IRVCbG8Hgj81BvWjYyc61?=
 =?us-ascii?Q?VkBIQOmjemohhrqHI7obFiyuEgca6G2BlVssD+hx8NmmGtYhW4QCBqVLd5rH?=
 =?us-ascii?Q?6PIllowSo8nXYq+iYoBaP09b49nSgTWb/sNjMBl2bIxsRZJ8P29EyjsGKAGb?=
 =?us-ascii?Q?882BFEF7kSGWlx+vsB62PQYwvSCCEf0aWt2TyYcH6+N9xbbsNnnY5tQrBdBO?=
 =?us-ascii?Q?vzFGacQ5oNOEtL+zirhDr0CmYL5ekpQRA8YWqVoFOHgdwzSgP1RsPcrTtrUh?=
 =?us-ascii?Q?jNTjFguhrWctOcB7uXR2CNJ6GJW0Dj/h6zNqH7O5+xhNWH9JVoNX2XxI0SdH?=
 =?us-ascii?Q?8h2MMNz/u+iLemx5gS4Z+mBMEVBvgzziBvxyYsnJT7Roz5ID4xk4jIC6rW5/?=
 =?us-ascii?Q?it+LDlO0WpV6f3fSinUPBPA88v/DqObKkk5FTPWm4QM14BZLfwwjb5RwvFZf?=
 =?us-ascii?Q?BCArYFQUBCYsyEH4nnceufHudD1QpYW3ojiaonHKRDaBZZlqDIFUYWG1BSvT?=
 =?us-ascii?Q?ncRm8pIEbuE3b5myskJIuy+4vUE8dJUCqbLI0aASa8/LHwFNYTFNI5jXNTTB?=
 =?us-ascii?Q?gpxoHXaoo99k9yDdJMbRlnvQCqU5b9kGKY1sL18q/ZHHOqhpCE16+k7zDAi4?=
 =?us-ascii?Q?MVaVPA79HMeetTbGTgAa/MpFi5cZslTixZ2QqUrEHCM++ZG5u4Xt4ryCrznZ?=
 =?us-ascii?Q?qlT1GNMYXBo/MAhcrpp+cvLyvsrJB0RnDpNu3aq71ThiS9F5ER0wzdU+OlYT?=
 =?us-ascii?Q?TmTPMNYnzuQJnWMQ/8OaAN5c0qnKP/pGkxUPRj4BhdzaSUZaAXdPsjLMA5r4?=
 =?us-ascii?Q?3ZuAeKEf6KR9XGSr5p8U7+BHMKkGGyFpX2i/OopdPnoaC8BRv7MwNdon1CCI?=
 =?us-ascii?Q?Bljf44YPv29SRFiE0d4vVAOaAm4WVYaF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A4ZaCg2fplMc7/rZP2UkHhhf6CwS88+QyHTx/GHFqAT167HK0dK+luEFA5ZZ?=
 =?us-ascii?Q?7iMKF/Kjk001/P0kqxPqx69OVe6qkeuddEGp5OKBO8BjIxE4ZvJ3A5YCFaNs?=
 =?us-ascii?Q?mB6z3UR0sfg2BV/T9qFj72+ZXY6yPp0L1xPd08D1sJAFB33H3DByMJKOfLRh?=
 =?us-ascii?Q?CS7DS7BtiORvviR5nKukZ6TVOQrr4FP9uBvjBuwf6BSKGyTMxfB5O+t7+qKJ?=
 =?us-ascii?Q?kRMhL+NFJNxrFxfxNHhFcxNZxOlUr9EWjSf5gCd7jTbvbPaRA5qeDokM+K1b?=
 =?us-ascii?Q?hEHljB9wetEdAhPORLmaXI2pJoVBEDRXCTdwCOeX4WnVw0LSQmtWh1RC03uN?=
 =?us-ascii?Q?XdeNW5HBZhKdakYoSqpVtK4sm0mW4dvboN9AjB4Lg4b3fJu+cQ9hBj/1uXv0?=
 =?us-ascii?Q?89U12I5TQpbiIty5GKfGMj1555NaxxgkEYySffCZxoEWQyPNIoKhgCeXkkfP?=
 =?us-ascii?Q?Nuyo3EKsBIACgKvNGY9yKpaecxMjeJCk1sOXimcph/UtLN20CZ+ekmBoxEl1?=
 =?us-ascii?Q?by/XEF5E81FFrFFPj5ck82ir1oaUExJOGPnWIJXpD14lRG4gq2/zGIcFjFhf?=
 =?us-ascii?Q?PF9YkwNS4dYKa7ACz4fMAzz7O/JJRLmJGn6xkyWxstMjYUB2B/G9tadWP/9b?=
 =?us-ascii?Q?lqIcgsvYvDhXFhGXQusWyh1tq5x5s4CNnyiIOp/ZwLVrDgmJa92AdocZhgXf?=
 =?us-ascii?Q?AJAgK5SWRmVHAcqvNoOUla8m8W8VTNI0/1GciV89ScrzpjRE6qMtd5RCwFP8?=
 =?us-ascii?Q?UdSnnC9gPhcGJt9Qvvbsb30U7c/GZNa0zFl4+J3/I6gDIsMsogXD3wLpts9C?=
 =?us-ascii?Q?NYP8oYhHGcmZ1CMWRMOSL2rWBJrDBbJSSWyxad67Q2TZS57d43pbrx4P9hmb?=
 =?us-ascii?Q?+cMRG8EpraCoBV0GIFv34ECQHdR4Tt9UnHUOG6/wwIvLiUEJOQZFJ5jSUKX2?=
 =?us-ascii?Q?oAwv3D+0HT4toZXv0QKW1Svvi31B/+iivrOympSMqdmGpK5voTk8IH9grx9n?=
 =?us-ascii?Q?Uw6yroolSNj4QuoSZHSO0BYdNqF/oaYgw8OCyV+II2UEk5YiS4G8XHFRcyFx?=
 =?us-ascii?Q?ba753oujaUoN3bawwmPkAYIPbKXvVzIp2EmUmPrjD6JDO1hAhkPJFpd9aSVx?=
 =?us-ascii?Q?/GH7Sui25nBM/L/wZHoE8Ya07tB4qR8IWFfAoVXQ5ALucHm+Sh5sPEK5b++C?=
 =?us-ascii?Q?Sq28Ibt6us72RvwI4fvzgD29FklI6Ce+Kdiqzt36KIzyoxn5q2Z3ilzhbTfQ?=
 =?us-ascii?Q?EtpQsjjxqdAZzZc7467u6kmdGl1z3SF4H0ivworL2GTZXxyOQBjJdRevbIaF?=
 =?us-ascii?Q?K+Ikn23iXrxzZsItX9+cXsaXNWcPqIFicfUIYwrVqGnzhX39DXIqCGwPauXE?=
 =?us-ascii?Q?a87w/MHg21RXwbzJeYFCDtTQEIkdtwDX50USws8J3OyUSuBKBZUkHS+WBnAh?=
 =?us-ascii?Q?8NlM2PwB4GJfWdRAoCFlLu5vvpjY/+GkWaoUcnc3zu9gOIcN2x7lzOuHxeC5?=
 =?us-ascii?Q?I25fQuySDUVItOW8dojA7sAEzgShYZxMFxz4ox69fJGMW/JtetcxxqJPgCT0?=
 =?us-ascii?Q?6UwI49mDhKVIuGtsAcc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e87b60a-4a50-4040-3aa4-08dd47069edb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 23:33:11.6485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/5QJ4NHvAXuC79sxLVByEFw5Y6gyTXA7QqUzcqCPIV/H8UmcisE6FQIQ92+8WYW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
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
> Sent: Thursday, February 6, 2025 8:13 AM
> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
>
> Initialize xgmi related static information during discovery.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index eca431e52038..d4eade2bd4d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2502,6 +2502,19 @@ static int amdgpu_discovery_set_isp_ip_blocks(stru=
ct
> amdgpu_device *adev)
>       return 0;
>  }
>
> +static void amdgpu_discovery_set_xgmi_info(struct amdgpu_device *adev)
> +{
> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(4, 8, 0=
))
> +             adev->gmc.xgmi.supported =3D true;
> +
> +     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) =
||
> +         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))
> +             adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 4, 0);

Can this stuff get rolled into xgm_init_info and called directly into amdgp=
u_discovery_set_ip_blocks?
Breaking up discovery_set_xgmi_info and xgmi_init_info as 2 separate things=
 seems a little confusing.

> +
> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0))

Maybe roll this check into xgmi_init_info i.e. void early return if null.

> +             amdgpu_xgmi_init_info(adev);
> +}
> +
>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  {
>       int r;
> @@ -2769,12 +2782,7 @@ int amdgpu_discovery_set_ip_blocks(struct
> amdgpu_device *adev)
>               break;
>       }
>
> -     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(4, 8, 0=
))
> -             adev->gmc.xgmi.supported =3D true;
> -
> -     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) =
||
> -         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))
> -             adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 4, 0);
> +     amdgpu_discovery_set_xgmi_info(adev);

If you do the suggestions above, you can just call amdgpu_xgmi_init_info un=
conditionally.

Jon
>
>       /* set NBIO version */
>       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
> --
> 2.25.1

