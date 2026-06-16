Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3307BCD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 10:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9702C10E0A9;
	Tue, 16 Jun 2026 10:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z6ADPIgt";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C2A10E0A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 10:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEFsZh3Tr3qXqe0+mHmVmPRnUmkzLs4x3dZfA/0dJlXKX+LissvRnL+Og7SDWkks7TjG0VYS3qGUYoqLt96ks9hXKGoLxoYX3OKAMe8b+Thf9fhyenb0QR5nhpK/JuuMe25gPu9n8kh2qv5pvJ+l13qMXoDdOTxTTxJ99OS562Y4+6yAT5GWHODpc7ZwzjR0Tymm0Gyhupq0UvC94q+cdfqhzvV3dRrMiFUbO8eDWNb9pBRIJ8lM9pdPBGDUatYKrMeIKkzeChhMHwAUW6DMmwCoUZD4OZK49dDWgjwzxTKMgOZ2/MAePBkwIWzWy+/JxJvuwboKRS/tsU4lUXpQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U+ExqVLscMy04xlqJ6sDCKiq0/TahyK6+mu117L5Vo=;
 b=CJnwMeQPeCKaNSvvhfRWDDCyWvPUQdeBsg/8wR/6/ZVdIrHC3au29KI4cVpQVp0/2Sq8T04hngDaPPBrJMRd1GG6pg3A+O0ZASSjcUwQT5fkvQFGKXvgHJzC2uJXA61jS4DglMH4pt9WdQjyq6ZDbxGjcZg2yqdJeFyC3f/L940155deycfxIlNANZgwtRzjg7A0uJe0DQh/XGyolwEA0wTbp+FhA7STu2CeJHMoBX5DMLXWZwPaCMCC3et6NzZvkHOOmPj34nVW9vLzrUjdVdqjM+oyWJ6E0WkCczwh8m3LT6y9dLMKiY9CH7BuS1tCFG+/0czgghD/XKWjBmyrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U+ExqVLscMy04xlqJ6sDCKiq0/TahyK6+mu117L5Vo=;
 b=z6ADPIgt6eOgUITm+mHRvFepyBftK3iV2KbweKN1LcCbNjsBUnwRPfBli2Q+OXSaL1/tZi5wyAMeGmulnqxjganBHLWweRIJQUD7K22jdztbeNPc1r1Ueg9BsAkertK1xJqryoL3MxB79XC3hpN7eRo2pIJ55wcx0tpe54fn5VM=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Tue, 16 Jun
 2026 10:19:08 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 10:19:08 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add buf length check
Thread-Topic: [PATCH] drm/amdgpu: add buf length check
Thread-Index: AQHc/XOGwkE7CjF5f02uFIrWXUeD57ZA+DaA
Date: Tue, 16 Jun 2026 10:19:08 +0000
Message-ID: <PH7PR12MB8796D813C76E73A6C3D07088B0E52@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260616093508.37315-1-ganglxie@amd.com>
In-Reply-To: <20260616093508.37315-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-16T10:19:04.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CYYPR12MB8922:EE_
x-ms-office365-filtering-correlation-id: 0e2f0225-fc77-4b37-9c57-08decb90b3e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info: UjN6z6Uh8H9eM2zKzLYvA9VVdwxF4NHZlIfaMX+Q2pjLakA5U8yZdE0GKQ1GFUpFmkxoa1npqy5zl8RqLWe+hHYTXoGYLJRZpwxGtTAWGKCHbvaiCLaGu/mPQThI4qsaaAGVCsGR/z0uPopCFDvVYTcyWcLtOSUJYr443P5z0ebGH63ggedtD1xs6iRSnmHAiooSYyEG0m/RRgeLIEGbvBqBkRMVY9BPMMj70p5S6MZ7ksVUT/6R7NIoH4fH3N3JIoRCZAXnLuxLiL42NdlETKdxxkgGPOUdvA/O5gHT5QiM73ZffdBy8x8as3Y0YRUIqkEzGLJErL6ddGFNxENVkWwdiP7fAdc2XX6/njO2rGGY5C8uQt3ce58pD9tu46q8o9ZoRnjMNpbijCbYQJHqeOU0ZOmC5cjyw7p6kH1sxxahOtCnKEfsoYGfFk1C9aKhRU4gdGhSyOD+e7Y0SfJLawXWdYIoNg2qFRlUtk7cd3atnkTYv0ig46IB98RDLUzfcoTFL7RVa3099R0xwXTKx6Cl0CYU8gV1f7puHDR31ZRnBy47WtJMveBY2VihzCX9IRpjC9AIZSKKKxwETsvoqlqDtCPTom19YToTC8UVLbuFCh8UfOqe5TxQ/u4UZ3hCNUIy/YI4CNPCaRyyUtGmFbkzntHxli0rFS0F67J7CcIbY48eqJ0Cjc4ax2bFta3tdhxOo/OV22nXnrqOyAS1lZ0jFipHNmqjcOLcVeA44vxoRHrayjiib1cxURSP+5JM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OYkClRR/RuONJBgOAA31uJ+yxSyU4fysd3eW99AthFQJAdQjFfRYc4om5Q/U?=
 =?us-ascii?Q?b2cXqjZ7kzoi+S1KbdJo9ush1wTSsRLlRNHSpVVNjT90oJl2GxDHJ29Uu8Ip?=
 =?us-ascii?Q?0JT8Z8Tf9B0wsqpzpe8Way7NU0UXzz9UIOz38RIuiSHxCAuoelxwevVVSxXy?=
 =?us-ascii?Q?jluzsOjm/9BzsLeztHZepSpLQ9qcl6WHgCSPxXJJnewbkCPfNWN5IBHqopSL?=
 =?us-ascii?Q?pLEfUia7OCfv5j7uhSKqhHmNNNNeMCbp0VRMh6mVFqa0QFD228kG+xy6Z5OX?=
 =?us-ascii?Q?Q8tO8A4r9f9gRVIc4y0f1RUz5c9EzfjxAePrucDKlrHJnhenTHQ8sZpPlM0a?=
 =?us-ascii?Q?I4NzU2JVO3yNmqhHytofhUDDvY3FxLsNMdIA75UVu1pMLkmGsvzucf5uh+VV?=
 =?us-ascii?Q?La5aJ7kqNloa6nn18MVrZIQi6P+3shiIpKXC/FAmQS7Q2F68SfcSv2D78r2t?=
 =?us-ascii?Q?yRTL/KfN7a3LqOl2RgUiY2d20n9DCjqwzKiPohEglVMFVxbMIh6bTxZW8sDj?=
 =?us-ascii?Q?Sw7CDzSkfG+1N+E8jAM+IiZ6xa0InaZHvDVtNxdT/SUu3n92AyRrhD3yejoP?=
 =?us-ascii?Q?DkKnNLX5AG+wLt79Xjfdr0Bm/JtZ+c9snTEBeMqcMejQH146p6kK4/AJegO1?=
 =?us-ascii?Q?2RvSSfrs8Qw1mrEcVxU3qlIIbYggF8jXQvtkF3HoFUiC1YhwbTk+6arSuzLW?=
 =?us-ascii?Q?nadbBkY6c9J9C/lXOKgkIGkKiC2/hpxsaatNeRw+HVcPrI8sW61AyRh872BA?=
 =?us-ascii?Q?dUrWgZYqhC1YGLmEJ/ql4wmypam6AJly+26Ty2frAiVnyL4tcjUvOIHgygoy?=
 =?us-ascii?Q?N5vwDsifqbPkvmubdREE/Ux9Ixe3G7UgV9dsDxKSYxt79+FlooAo4RDOrEVw?=
 =?us-ascii?Q?RcOOPU2j7XRYV8ZGorLZ0F3pDwMHonyR4efF69NCk+7M3wqlMgcJaIfAkIvH?=
 =?us-ascii?Q?cuK3AMazYvZ9uECHPdk7bgD58kDCsjA0kFbl7QqZ+9MDAHLc9AgSZP2d3r/9?=
 =?us-ascii?Q?Y7EAB4C26F6YGdwRTYUk968E15U6rtomVb4KoDdOVpLMo0NICA31MaWUXk8o?=
 =?us-ascii?Q?jiP+EilcXEzGQ51P2w2aTpaCh4+v5ynLC0pjn7F+FJPxG4un6Qv9JrjlEkXU?=
 =?us-ascii?Q?Er/dMZh7Tg21UmioK/7Fwi3kSBnTNZSOFNdcj8drR9mkVSlmVRQYl2BeVyUG?=
 =?us-ascii?Q?jIwXR5Qt2feML9dcEgRaT26vpEAGdGUMp+pl4vd6V+rQ6w/1/TBcM5ZPZvlH?=
 =?us-ascii?Q?LWYtSK55tfqLl4WW4A/Iq4j9vhZkqg/IHmiglPi2L0FQnTLM4kDEAvG6KAYd?=
 =?us-ascii?Q?mmcsweK38Oc9VA6rqfzoLF+UG5W+ugmtYmm1VgpdfEFM77y96u2f0uaDWhLk?=
 =?us-ascii?Q?oSBTB91uXp0ZP45pkNSjhJd3imiWb1C5reCK5UNe5G8hHyaJboz8SMRzK6WM?=
 =?us-ascii?Q?0v54/r5rKNokXrB5ED6uI2bx5AjWBp4hbbps25o7l/MZ/GYDtatkN7sguwGQ?=
 =?us-ascii?Q?Yt8N8Q7hg0oUzutPNKOUPxHYTTjHvy0KfKhVVlCNBdmQOqriXv/dZbGjZjKa?=
 =?us-ascii?Q?cCa1F/0DP78dBZ85/wh02GPU5eLjnbzWTgyMUktz3iYTJRD4l/npgk9eudjF?=
 =?us-ascii?Q?TqN+xwI3ZvjWC5y0mLMhwKUtGQr/ZnanoLZq4iqEkghkzpZC1dlMRzxRQspH?=
 =?us-ascii?Q?YQ7gyvV6CAFH2R92hapy6t6cp2nQFO/lpdrwLYs62//9+9WT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2f0225-fc77-4b37-9c57-08decb90b3e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 10:19:08.6945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKc7DKSjqS0yiaOBIPuTTsSkZsAze90yWSyZ1caojVFNSo8yMo8gB35+0uP42aVS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922
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

AMD General

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Tuesday, June 16, 2026 5:35 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amdgpu: add buf length check
>
> add buf length check before using it to access data
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> index 0d3c18f04ac3..8ae72c862d11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> @@ -166,7 +166,8 @@ static ssize_t ta_if_load_debugfs_write(struct file *=
fp, const
> char *buf, size_t
>       if (ret)
>               return -EFAULT;
>
> -     if (ta_bin_len > PSP_1_MEG)
> +     if (ta_bin_len < sizeof(struct common_firmware_header) ||
> +         ta_bin_len > PSP_1_MEG)
>               return -EINVAL;
>
>       copy_pos +=3D sizeof(uint32_t);
> @@ -321,6 +322,8 @@ static ssize_t ta_if_invoke_debugfs_write(struct file=
 *fp,
> const char *buf, size
>       ret =3D copy_from_user((void *)&shared_buf_len, &buf[copy_pos],
> sizeof(uint32_t));
>       if (ret)
>               return -EFAULT;
> +     if (!shared_buf_len || shared_buf_len > PSP_1_MEG)
> +             return -EINVAL;
>       copy_pos +=3D sizeof(uint32_t);
>
>       shared_buf =3D memdup_user(&buf[copy_pos], shared_buf_len);
> --
> 2.34.1

